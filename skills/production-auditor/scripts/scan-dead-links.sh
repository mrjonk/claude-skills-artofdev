#!/usr/bin/env bash
# scan-dead-links.sh — Scan non destructif des liens internes potentiellement morts.
#
# Usage :
#   bash scan-dead-links.sh [<chemin>]
#
# Comportement :
#   - Scanne les fichiers .html, .md, .php, .tsx, .jsx, .vue, .twig.
#   - Extrait les `href="..."` et `to="..."` qui pointent vers des chemins relatifs internes.
#   - Pour chaque chemin interne, vérifie s'il existe en local (au moins un fichier candidat).
#   - Signale les liens suspects (probablement morts).
#   - Ne supprime rien, ne modifie rien.
#   - Limites : approximatif, ne sait pas résoudre les routes dynamiques (Next.js, Laravel, FastAPI).
#     Le rapport doit être lu avec recul, pas pris pour parole d'évangile.
#
# Exit code : 0 (informatif).
#
# Created by João de Almeida — Art of Dev — https://artofdev.space

set -euo pipefail

TARGET="${1:-.}"

if [[ ! -d "${TARGET}" ]]; then
  echo "ERREUR : ${TARGET} n'est pas un dossier." >&2
  exit 2
fi

if [[ -t 1 ]]; then
  C_RED='\033[0;31m'; C_YEL='\033[0;33m'; C_GRN='\033[0;32m'; C_BLU='\033[0;34m'; C_END='\033[0m'
else
  C_RED=''; C_YEL=''; C_GRN=''; C_BLU=''; C_END=''
fi

EXCLUDED='node_modules|vendor|.git|.venv|venv|__pycache__|dist|build|.next|.nuxt|.turbo|exports|backups|.skill-backups|coverage'

mapfile -t FILES < <(
  find "${TARGET}" \
    -type d -regextype posix-extended -regex ".*/(${EXCLUDED})$" -prune \
    -o -type f \( \
       -name "*.html" -o -name "*.md" -o -name "*.php" \
    -o -name "*.tsx"  -o -name "*.jsx" -o -name "*.vue" \
    -o -name "*.twig" -o -name "*.blade.php" \
    \) -print
)

echo -e "${C_BLU}==> Scan de liens potentiellement morts sur ${TARGET}${C_END}"
echo "Fichiers concernés : ${#FILES[@]}"
echo

# Extraire toutes les valeurs entre guillemets après href= ou to=
# (heuristique simple ; ne gère pas le templating dynamique)

declare -A SEEN_LINKS
SUSPICIOUS_COUNT=0
TOTAL_LINKS=0

for f in "${FILES[@]}"; do
  # Cherche href="..." href='...' to="..." to='...'
  links="$(grep -oE '(href|to|action)[[:space:]]*=[[:space:]]*["'"'"'][^"'"'"']{1,200}["'"'"']' "${f}" 2>/dev/null \
    | sed -E 's/^(href|to|action)[[:space:]]*=[[:space:]]*["'"'"']//; s/["'"'"']$//' \
    | sort -u || true)"

  while IFS= read -r link; do
    [[ -z "${link}" ]] && continue
    TOTAL_LINKS=$((TOTAL_LINKS + 1))

    # Ignorer les protocoles / mailto / tel / ancres pures / templating
    case "${link}" in
      http://*|https://*|mailto:*|tel:*|sms:*|javascript:*|data:*|\#*)
        continue
        ;;
      \{*|*\}*|\{\{*|*\$\{*)
        continue
        ;;
    esac

    # Ignorer les routes très dynamiques courantes
    case "${link}" in
      *":id"*|*":slug"*|*"<id>"*|*"<slug>"*|*"[id]"*|*"[slug]"*|*"[...slug]"*)
        continue
        ;;
    esac

    # Normaliser : retirer query string et fragment
    norm="${link%%\?*}"
    norm="${norm%%\#*}"

    # Ignorer chemins vides ou racine
    [[ -z "${norm}" || "${norm}" == "/" ]] && continue

    # On dédoublonne par lien-clé
    key="${norm}"
    [[ -n "${SEEN_LINKS[$key]:-}" ]] && continue
    SEEN_LINKS[$key]="1"

    # Tenter de résoudre :
    #   - chemin relatif depuis racine du projet
    #   - chemin relatif depuis le fichier source
    #   - chemin avec extension implicite (.html, .php, .md)
    candidates=()
    if [[ "${norm}" == /* ]]; then
      candidates+=("${TARGET}${norm}")
      candidates+=("${TARGET}${norm}.html" "${TARGET}${norm}.php" "${TARGET}${norm}.md")
      candidates+=("${TARGET}${norm}/index.html" "${TARGET}${norm}/index.php" "${TARGET}${norm}/index.md")
    else
      base_dir="$(dirname "${f}")"
      candidates+=("${base_dir}/${norm}")
      candidates+=("${base_dir}/${norm}.html" "${base_dir}/${norm}.php" "${base_dir}/${norm}.md")
      candidates+=("${base_dir}/${norm}/index.html" "${base_dir}/${norm}/index.php")
    fi

    found=0
    for c in "${candidates[@]}"; do
      if [[ -e "${c}" ]]; then
        found=1
        break
      fi
    done

    if [[ "${found}" -eq 0 ]]; then
      SUSPICIOUS_COUNT=$((SUSPICIOUS_COUNT + 1))
      echo -e "${C_YEL}[suspect]${C_END} ${f}  →  ${link}"
    fi
  done <<< "${links}"
done

echo
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Liens internes scannés : ${TOTAL_LINKS}"
echo "Suspects (probablement morts) : ${SUSPICIOUS_COUNT}"
echo
echo "Note : ce scan est approximatif. Les routes dynamiques (Next.js, Laravel,"
echo "FastAPI) ne sont pas résolvables sans exécution. Vérifiez chaque suspect"
echo "manuellement avant d'appliquer une correction."
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

exit 0
