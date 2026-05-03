#!/usr/bin/env bash
# scan-orphan-pages.sh — Détecte les pages probablement orphelines (présentes mais non liées).
#
# Usage :
#   bash scan-orphan-pages.sh [<chemin>]
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Liste les fichiers de pages probables (app/, pages/, src/, public/, templates/, views/).
#   - Pour chaque page, cherche si son chemin est référencé quelque part dans le code.
#   - Approximation : ne détecte pas les routes dynamiques (routes de framework).
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

# Trouver les pages probables
declare -a PAGE_DIRS=("app" "pages" "src/pages" "src/app" "public" "templates" "views" "resources/views")
declare -a PAGES=()

for dir in "${PAGE_DIRS[@]}"; do
  if [[ -d "${TARGET}/${dir}" ]]; then
    while IFS= read -r f; do
      PAGES+=("$f")
    done < <(
      find "${TARGET}/${dir}" \
        -type d -regextype posix-extended -regex ".*/(${EXCLUDED})$" -prune \
        -o -type f \( \
           -name "page.tsx" -o -name "page.jsx" -o -name "index.html" -o -name "index.php" -o -name "index.tsx" \
        -o -name "*.html" -o -name "*.aspx" -o -name "*.blade.php" -o -name "*.vue" -o -name "*.astro" \
        \) -print
    )
  fi
done

echo -e "${C_BLU}==> Scan de pages orphelines sur ${TARGET}${C_END}"
echo "Pages probables détectées : ${#PAGES[@]}"
echo

if [[ "${#PAGES[@]}" -eq 0 ]]; then
  echo -e "${C_YEL}aucune page détectée — vérifier que les dossiers app/pages/src/templates existent${C_END}"
  exit 0
fi

# Tous les fichiers code pour la recherche de références
mapfile -t CODE_FILES < <(
  find "${TARGET}" \
    -type d -regextype posix-extended -regex ".*/(${EXCLUDED})$" -prune \
    -o -type f \( \
       -name "*.html" -o -name "*.php" -o -name "*.tsx" -o -name "*.jsx" \
    -o -name "*.ts" -o -name "*.js" -o -name "*.vue" -o -name "*.svelte" \
    -o -name "*.astro" -o -name "*.twig" -o -name "*.blade.php" \
    \) -print
)

# Pour chaque page, déduire son slug et chercher des références
declare -a ORPHAN_PAGES=()

for page in "${PAGES[@]}"; do
  # Déduire le slug : retirer le path target/dir et l'extension
  rel_path="${page#${TARGET}/}"
  # Retirer les segments /app/ /pages/ /src/pages/ etc. au début
  slug=$(echo "${rel_path}" | sed -E 's|^(app|pages|src/pages|src/app|public|templates|views|resources/views)/||')
  # Retirer extension et /index.* / /page.*
  slug=$(echo "${slug}" | sed -E 's|/(page|index)\.(tsx|jsx|html|php|astro|vue)$||' | sed -E 's|\.(tsx|jsx|html|php|astro|vue|aspx|blade\.php)$||')

  # Construire la route probable
  route="/${slug}"
  # Cas spécial : si le slug est juste "index" ou vide → route /
  if [[ -z "${slug}" || "${slug}" == "index" ]]; then
    route="/"
  fi

  # Chercher la route dans les fichiers code (exclure le fichier lui-même)
  found=0
  for code_f in "${CODE_FILES[@]}"; do
    [[ "${code_f}" == "${page}" ]] && continue
    if grep -E -l "['\"]${route}['\"\?#]|href=\"${route}\"|to=\"${route}\"|to='${route}'|href='${route}'" "${code_f}" >/dev/null 2>&1; then
      found=1
      break
    fi
  done

  if [[ "${found}" -eq 0 ]]; then
    # Cas spéciaux à exclure (pages racine ou layout)
    case "${rel_path}" in
      */layout.*|*/error.*|*/not-found.*|*/loading.*|*/_*|app/page.tsx|app/page.jsx|pages/index.*|src/pages/index.*|public/index.html)
        # Pages standard non orphelines (homepage, layout, error)
        continue
        ;;
    esac
    ORPHAN_PAGES+=("${page}|${route}")
  fi
done

# Affichage
echo -e "${C_BLU}── Pages potentiellement orphelines ──${C_END}"
if [[ "${#ORPHAN_PAGES[@]}" -eq 0 ]]; then
  echo -e "  ${C_GRN}aucune page orpheline détectée${C_END}"
else
  for entry in "${ORPHAN_PAGES[@]}"; do
    page="${entry%|*}"
    route="${entry#*|}"
    echo -e "${C_YEL}${page}${C_END}"
    echo "    route déduite : ${route}"
    echo "    aucune référence trouvée dans le code"
  done
fi
echo

# Résumé
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Résumé scan-orphan-pages :"
echo "  - Pages détectées        : ${#PAGES[@]}"
echo "  - Pages orphelines       : ${#ORPHAN_PAGES[@]}"
echo
if [[ "${#ORPHAN_PAGES[@]}" -gt 0 ]]; then
  echo -e "${C_YEL}[ATTENTION]${C_END} ${#ORPHAN_PAGES[@]} pages potentiellement orphelines."
  echo "  → Vérifier manuellement (cas légitimes : redirections automatiques, accès par lien direct, pages admin)."
  echo "  → Limites : ce scan ne détecte pas les routes dynamiques de framework."
fi
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

exit 0
