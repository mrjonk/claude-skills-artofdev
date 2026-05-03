#!/usr/bin/env bash
# scan-repetitions.sh — Détecte titres H2 répétés et phrases identiques répétées.
#
# Usage :
#   bash scan-repetitions.sh <chemin/fichier.md>
#   bash scan-repetitions.sh <dossier>
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Détecte :
#       1. titres H2 / H3 dupliqués dans un même fichier ;
#       2. phrases identiques répétées (≥ 5 mots) dans un même fichier.
#   - Affiche un rapport synthétique.
#   - Exit code 0 toujours (informatif).
#
# Created by João de Almeida

set -euo pipefail

TARGET="${1:-.}"

if [[ -t 1 ]]; then
  C_RED='\033[0;31m'; C_YEL='\033[0;33m'; C_GRN='\033[0;32m'; C_BLU='\033[0;34m'; C_END='\033[0m'
else
  C_RED=''; C_YEL=''; C_GRN=''; C_BLU=''; C_END=''
fi

EXCLUDED='node_modules|vendor|.git|.venv|venv|__pycache__|dist|build|.next|.nuxt|.turbo|exports|backups|.skill-backups|coverage'

if [[ -f "${TARGET}" ]]; then
  FILES=("${TARGET}")
elif [[ -d "${TARGET}" ]]; then
  mapfile -t FILES < <(
    find "${TARGET}" \
      -type d -regextype posix-extended -regex ".*/(${EXCLUDED})$" -prune \
      -o -type f -name "*.md" -print
  )
else
  echo "ERREUR : ${TARGET} n'est ni un fichier .md ni un dossier." >&2
  exit 2
fi

echo -e "${C_BLU}==> Scan de répétitions sur ${TARGET}${C_END}"
echo "Fichiers .md scannés : ${#FILES[@]}"
echo

TOTAL_DUP_HEADINGS=0
TOTAL_DUP_PHRASES=0

for f in "${FILES[@]}"; do
  # 1. Titres H2 / H3 dupliqués dans le même fichier
  dup_headings="$(
    grep -E '^#{2,3} ' "${f}" 2>/dev/null \
      | sort \
      | uniq -d || true
  )"

  if [[ -n "${dup_headings}" ]]; then
    echo -e "${C_YEL}${f}${C_END}"
    echo -e "  ${C_RED}── Titres H2/H3 dupliqués ──${C_END}"
    while IFS= read -r line; do
      [[ -z "${line}" ]] && continue
      TOTAL_DUP_HEADINGS=$((TOTAL_DUP_HEADINGS + 1))
      echo "    \"${line}\""
    done <<< "${dup_headings}"
  fi

  # 2. Phrases identiques répétées (≥ 5 mots, ≥ 30 caractères)
  # On considère une phrase = ligne non vide, non titre, non liste de bullets, non code
  dup_lines="$(
    grep -v '^#' "${f}" 2>/dev/null \
      | grep -v '^- ' \
      | grep -v '^  - ' \
      | grep -v '^\* ' \
      | grep -v '^|' \
      | grep -v '^>' \
      | grep -v '^\s*$' \
      | grep -v '^```' \
      | awk 'length($0) >= 30' \
      | sort \
      | uniq -c \
      | awk '$1 > 1 {print}' \
      | head -10 || true
  )"

  if [[ -n "${dup_lines}" ]]; then
    echo -e "${C_YEL}${f}${C_END}"
    echo -e "  ${C_RED}── Phrases répétées (≥ 30 car.) ──${C_END}"
    while IFS= read -r line; do
      [[ -z "${line}" ]] && continue
      TOTAL_DUP_PHRASES=$((TOTAL_DUP_PHRASES + 1))
      echo "    ${line}"
    done <<< "${dup_lines}"
  fi
done

echo
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Résumé scan-repetitions :"
echo "  - titres H2/H3 dupliqués     : ${TOTAL_DUP_HEADINGS}"
echo "  - phrases répétées détectées : ${TOTAL_DUP_PHRASES}"
echo

if [[ "${TOTAL_DUP_HEADINGS}" -eq 0 && "${TOTAL_DUP_PHRASES}" -eq 0 ]]; then
  echo -e "${C_GRN}[OK] Aucune répétition évidente détectée.${C_END}"
else
  echo -e "${C_YEL}[ATTENTION] Répétitions à examiner.${C_END}"
  echo "  Note : ce scan est approximatif. Une répétition volontaire (résumé final, FAQ qui rappelle un point) peut apparaître ici sans être un bug."
fi
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

exit 0
