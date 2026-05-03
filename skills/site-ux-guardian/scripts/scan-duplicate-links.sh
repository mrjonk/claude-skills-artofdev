#!/usr/bin/env bash
# scan-duplicate-links.sh — Détecte les liens internes répétés dans plusieurs fichiers.
#
# Usage :
#   bash scan-duplicate-links.sh [<chemin>]
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Extrait les liens internes (href / to commençant par /).
#   - Détecte les liens qui apparaissent dans BEAUCOUP de fichiers (suspect = menu hardcodé).
#   - Détecte les liens identiques répétés dans le même fichier.
#   - Exit code 0 toujours (informatif).
#
# Created by João de Almeida

set -euo pipefail

TARGET="${1:-.}"

if [[ ! -d "${TARGET}" ]]; then
  echo "ERREUR : ${TARGET} n'est pas un dossier." >&2
  exit 2
fi

if [[ -t 1 ]]; then
  C_BLU='\033[0;34m'; C_YEL='\033[0;33m'; C_RED='\033[0;31m'; C_GRN='\033[0;32m'; C_END='\033[0m'
else
  C_BLU=''; C_YEL=''; C_RED=''; C_GRN=''; C_END=''
fi

EXCLUDED='node_modules|vendor|.git|.venv|venv|__pycache__|dist|build|.next|.nuxt|.turbo|exports|backups|.skill-backups|coverage'

mapfile -t FILES < <(
  find "${TARGET}" \
    -type d -regextype posix-extended -regex ".*/(${EXCLUDED})$" -prune \
    -o -type f \( \
       -name "*.html" -o -name "*.htm" -o -name "*.php" \
    -o -name "*.tsx" -o -name "*.jsx" -o -name "*.vue" -o -name "*.svelte" \
    -o -name "*.md" \
    -o -name "*.twig" -o -name "*.blade.php" \
    \) -print
)

echo -e "${C_BLU}==> Scan de doublons de liens sur ${TARGET}${C_END}"
echo "Fichiers scannés : ${#FILES[@]}"
echo

# Collecter tous les liens internes par fichier
declare -A LINK_TO_FILES   # key: link, value: liste de fichiers (séparés par |)
declare -A LINK_COUNT      # key: link, value: nombre total d'occurrences

for f in "${FILES[@]}"; do
  # Extraire les liens href / to / action commençant par /
  links_in_file=$(grep -oE '(href|to|action)[[:space:]]*=[[:space:]]*["'"'"'](\/[^"'"'"']*)' "${f}" 2>/dev/null \
    | sed -E 's/^(href|to|action)[[:space:]]*=[[:space:]]*["'"'"']//' \
    | sort -u || true)

  while IFS= read -r link; do
    [[ -z "${link}" ]] && continue
    # Ignorer les liens dynamiques avec template
    case "${link}" in
      *\{\{*|*\}\}*|*\$\{*|*:id*|*:slug*|*\[*\]*) continue ;;
    esac

    LINK_COUNT[${link}]=$((${LINK_COUNT[${link}]:-0} + 1))
    LINK_TO_FILES[${link}]="${LINK_TO_FILES[${link}]:-}|${f}"
  done <<< "${links_in_file}"
done

# Liens présents dans 5+ fichiers → suspect (menu hardcodé probable)
echo -e "${C_BLU}── Liens présents dans 5+ fichiers (menu hardcodé probable) ──${C_END}"
SUSPECT_COUNT=0
for link in "${!LINK_COUNT[@]}"; do
  count=${LINK_COUNT[${link}]}
  if [[ "${count}" -ge 5 ]]; then
    SUSPECT_COUNT=$((SUSPECT_COUNT + 1))
    echo -e "${C_YEL}${link}${C_END} → présent ${count} fois"
    # Lister les 3 premiers fichiers
    files="${LINK_TO_FILES[${link}]#|}"
    echo "${files}" | tr '|' '\n' | sort -u | head -3 | sed 's/^/    /'
    if [[ "${count}" -gt 3 ]]; then
      echo "    ... et $((count - 3)) autres"
    fi
  fi
done
[[ "${SUSPECT_COUNT}" -eq 0 ]] && echo -e "  ${C_GRN}aucun lien suspect (menu probablement déjà partagé via composant)${C_END}"
echo

# Résumé
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Résumé scan-duplicate-links :"
echo "  - Liens internes uniques détectés : ${#LINK_COUNT[@]}"
echo "  - Liens dans 5+ fichiers (suspects) : ${SUSPECT_COUNT}"
echo
if [[ "${SUSPECT_COUNT}" -gt 0 ]]; then
  echo -e "${C_YEL}[ATTENTION]${C_END} ${SUSPECT_COUNT} liens présents dans 5+ fichiers."
  echo "  → Probable menu hardcodé."
  echo "  → Recommander un composant partagé (Header, Footer)."
fi
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

exit 0
