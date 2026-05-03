#!/usr/bin/env bash
# scan-translatable-text.sh — Cherche le texte susceptible d'être traduit (chaînes UI, labels, headings).
#
# Usage :
#   bash scan-translatable-text.sh [<chemin>]
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Liste les fichiers contenant du texte UI candidat à traduction.
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
    -o -name "*.vue" -o -name "*.svelte" -o -name "*.astro" \
    -o -name "*.twig" -o -name "*.blade.php" \
    -o -name "*.erb" -o -name "*.aspx" -o -name "*.cshtml" \
    \) -print
)

echo -e "${C_BLU}==> Scan texte traduisible sur ${TARGET}${C_END}"
echo "Fichiers UI scannés : ${#FILES[@]}"
echo

declare -a PATTERNS=(
  '<h[1-6][^>]*>[A-Za-zÀ-ÿ]'
  '<p[^>]*>[A-Za-zÀ-ÿ]'
  '<button[^>]*>[A-Za-zÀ-ÿ]'
  '<label[^>]*>[A-Za-zÀ-ÿ]'
  '<a [^>]*>[A-Za-zÀ-ÿ]'
  'placeholder="[A-Za-zÀ-ÿ]'
  'title="[A-Za-zÀ-ÿ]'
  'alt="[A-Za-zÀ-ÿ]'
  'aria-label="[A-Za-zÀ-ÿ]'
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
  echo -e "  ${C_YEL}aucun texte traduisible détecté — vérifier si le scan couvre les bons fichiers${C_END}"
else
  echo "Fichiers contenant du texte traduisible :"
  for f in "${!FOUND_FILES[@]}"; do
    echo "  - ${f}"
  done | sort
fi

echo
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Résumé scan-translatable-text :"
echo "  - Total fichiers avec texte UI : ${#FOUND_FILES[@]}"
echo
if [[ "${#FOUND_FILES[@]}" -gt 0 ]]; then
  echo -e "${C_GRN}[INFO]${C_END} Inspecter chaque fichier pour vérifier que les chaînes passent bien par un système i18n."
fi
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

exit 0
