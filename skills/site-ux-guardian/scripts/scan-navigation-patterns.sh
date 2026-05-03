#!/usr/bin/env bash
# scan-navigation-patterns.sh — Cherche les patterns de navigation (navbar, nav, menu, sidebar, header).
#
# Usage :
#   bash scan-navigation-patterns.sh [<chemin>]
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Liste les fichiers contenant des patterns de navigation.
#   - Affiche un résumé.
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
  C_BLU='\033[0;34m'; C_YEL='\033[0;33m'; C_GRN='\033[0;32m'; C_END='\033[0m'
else
  C_BLU=''; C_YEL=''; C_GRN=''; C_END=''
fi

EXCLUDED='node_modules|vendor|.git|.venv|venv|__pycache__|dist|build|.next|.nuxt|.turbo|exports|backups|.skill-backups|coverage'

mapfile -t FILES < <(
  find "${TARGET}" \
    -type d -regextype posix-extended -regex ".*/(${EXCLUDED})$" -prune \
    -o -type f \( \
       -name "*.html" -o -name "*.htm" -o -name "*.php" \
    -o -name "*.tsx" -o -name "*.jsx" -o -name "*.ts" -o -name "*.js" \
    -o -name "*.vue" -o -name "*.svelte" \
    -o -name "*.twig" -o -name "*.blade.php" \
    -o -name "*.erb" -o -name "*.aspx" \
    \) -print
)

echo -e "${C_BLU}==> Scan patterns de navigation sur ${TARGET}${C_END}"
echo "Fichiers UI scannés : ${#FILES[@]}"
echo

declare -a PATTERNS=(
  '<nav\b'
  '<Nav\b'
  '<header\b'
  '<Header\b'
  'class="[^"]*navbar'
  'class="[^"]*navigation'
  'class="[^"]*main-menu'
  'class="[^"]*top-menu'
  'class="[^"]*sidebar'
  'aria-label="[Nn]avigation'
)

declare -A FOUND_FILES=()

if [[ "${#FILES[@]}" -gt 0 ]]; then
  for f in "${FILES[@]}"; do
    for pat in "${PATTERNS[@]}"; do
      if grep -E -l "${pat}" "${f}" >/dev/null 2>&1; then
        FOUND_FILES[$f]=1
        break
      fi
    done
  done
fi

if [[ "${#FOUND_FILES[@]}" -eq 0 ]]; then
  echo -e "  ${C_YEL}aucun pattern de navigation détecté — vérifier si le site a vraiment une navigation${C_END}"
else
  echo "Fichiers contenant des patterns de navigation :"
  for f in "${!FOUND_FILES[@]}"; do
    echo "  - ${f}"
  done | sort
fi

echo
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Résumé scan-navigation-patterns :"
echo "  - Total fichiers avec navigation : ${#FOUND_FILES[@]}"
echo
if [[ "${#FOUND_FILES[@]}" -gt 5 ]]; then
  echo -e "${C_YEL}[ATTENTION]${C_END} ${#FOUND_FILES[@]} fichiers contiennent des patterns de navigation."
  echo "  → Vérifier si la navigation est partagée (composant) ou hardcodée."
  echo "  → Si > 3 fichiers ont du HTML de menu copié, recommander un composant partagé."
fi
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

exit 0
