#!/usr/bin/env bash
# scan-ai-style-patterns.sh — Détecte les patterns typiques d'un texte généré par IA.
#
# Usage :
#   bash scan-ai-style-patterns.sh [<chemin>]
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Cherche tirets longs (—) en surnombre, phrases creuses, marketing creux,
#     placeholders oubliés.
#   - Liste les fichiers et nombres d'occurrences.
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
  C_BLU='\033[0;34m'; C_YEL='\033[0;33m'; C_GRN='\033[0;32m'; C_RED='\033[0;31m'; C_END='\033[0m'
else
  C_BLU=''; C_YEL=''; C_GRN=''; C_RED=''; C_END=''
fi

EXCLUDED='node_modules|vendor|.git|.venv|venv|__pycache__|dist|build|.next|.nuxt|.turbo|exports|backups|.skill-backups|coverage'

mapfile -t FILES < <(
  find "${TARGET}" \
    -type d -regextype posix-extended -regex ".*/(${EXCLUDED})$" -prune \
    -o -type f \( \
       -name "*.md" -o -name "*.mdx" -o -name "*.txt" \
    -o -name "*.html" -o -name "*.htm" -o -name "*.php" \
    -o -name "*.tsx" -o -name "*.jsx" -o -name "*.ts" -o -name "*.js" \
    -o -name "*.vue" -o -name "*.svelte" -o -name "*.astro" \
    -o -name "*.json" -o -name "*.yml" -o -name "*.yaml" \
    -o -name "*.po" -o -name "*.twig" -o -name "*.blade.php" \
    \) -print
)

echo -e "${C_BLU}==> Scan patterns de style IA sur ${TARGET}${C_END}"
echo "Fichiers texte scannés : ${#FILES[@]}"
echo

# Patterns à détecter — chaque entrée = "label|regex"
declare -a PATTERNS=(
  'Tiret long (—)|—'
  '"dans le monde d.aujourd.hui"|dans le monde d.aujourd.hui'
  '"solution innovante"|solution innovante'
  '"révolutionner"|révolutionner'
  '"révolutionnaire"|révolutionnaire'
  '"expérience fluide"|expérience fluide'
  '"de plus en plus"|de plus en plus'
  '"il est important de"|il est important de'
  '"découvrez comment"|[Dd]écouvrez comment'
  '"Lorem ipsum"|Lorem ipsum'
  '"placeholder"|[Pp]laceholder'
  '"contenu à venir"|contenu à venir'
  '"in today.s world"|in today.s world'
  '"innovative solution"|innovative solution'
  '"revolutionize"|revolutionize'
  '"seamless experience"|seamless experience'
  '"more and more"|more and more'
  '"it.s important to"|it.s important to'
  '"discover how"|[Dd]iscover how'
)

declare -A FILES_FOUND=()
TOTAL_HITS=0

if [[ "${#FILES[@]}" -gt 0 ]]; then
  for entry in "${PATTERNS[@]}"; do
    LABEL="${entry%%|*}"
    REGEX="${entry#*|}"
    HITS=0
    declare -a HIT_FILES=()
    for f in "${FILES[@]}"; do
      COUNT=$(grep -E -c "${REGEX}" "${f}" 2>/dev/null || true)
      COUNT="${COUNT:-0}"
      if [[ "${COUNT}" -gt 0 ]]; then
        HITS=$((HITS + COUNT))
        HIT_FILES+=("${f}:${COUNT}")
        FILES_FOUND[$f]=1
      fi
    done
    if [[ "${HITS}" -gt 0 ]]; then
      TOTAL_HITS=$((TOTAL_HITS + HITS))
      echo -e "${C_YEL}${LABEL}${C_END} : ${HITS} occurrences"
      for hit in "${HIT_FILES[@]}"; do
        echo "    - ${hit}"
      done
    fi
  done
fi

echo
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Résumé scan-ai-style-patterns :"
echo "  - Patterns détectés totaux : ${TOTAL_HITS}"
echo "  - Fichiers concernés : ${#FILES_FOUND[@]}"
echo
if [[ "${TOTAL_HITS}" -gt 50 ]]; then
  echo -e "${C_RED}[CRITIQUE]${C_END} Niveau de style IA très élevé. Humanisation prioritaire avant traduction."
elif [[ "${TOTAL_HITS}" -gt 15 ]]; then
  echo -e "${C_YEL}[ATTENTION]${C_END} Style IA détecté de manière modérée. Humanisation recommandée."
elif [[ "${TOTAL_HITS}" -gt 0 ]]; then
  echo -e "${C_GRN}[INFO]${C_END} Quelques patterns détectés. Vérifier si le contexte les justifie."
else
  echo -e "${C_GRN}[OK]${C_END} Aucun pattern de style IA flagrant détecté."
fi
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

exit 0
