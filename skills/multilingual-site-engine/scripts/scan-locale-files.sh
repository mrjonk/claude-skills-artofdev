#!/usr/bin/env bash
# scan-locale-files.sh — Inventorie les fichiers de traduction et leurs locales.
#
# Usage :
#   bash scan-locale-files.sh [<chemin>]
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Liste les fichiers JSON, PO, PHP, YAML organisés par locale.
#   - Détecte les chemins typiques (locales/, messages/, lang/, translations/, locale/).
#   - Exit code 0 toujours.
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

echo -e "${C_BLU}==> Scan fichiers locales sur ${TARGET}${C_END}"
echo

# Dossiers candidats
declare -a LOCALE_DIRS=(
  "locales"
  "messages"
  "lang"
  "translations"
  "locale"
  "i18n"
  "src/locales"
  "src/messages"
  "src/i18n"
  "app/locales"
  "app/messages"
  "resources/lang"
  "config/locales"
  "wp-content/languages"
)

declare -A FOUND_DIRS=()

for dir in "${LOCALE_DIRS[@]}"; do
  while IFS= read -r d; do
    [[ -z "${d}" ]] && continue
    FOUND_DIRS[$d]=1
  done < <(find "${TARGET}" \
    -type d -regextype posix-extended -regex ".*/(${EXCLUDED})$" -prune \
    -o -type d -name "${dir}" -print 2>/dev/null)
done

if [[ "${#FOUND_DIRS[@]}" -eq 0 ]]; then
  echo -e "  ${C_YEL}aucun dossier locale standard détecté${C_END}"
  echo "  → vérifier manuellement les conventions du projet"
else
  echo "Dossiers de traductions détectés :"
  for d in "${!FOUND_DIRS[@]}"; do
    echo
    echo -e "  ${C_GRN}${d}${C_END}"
    while IFS= read -r f; do
      [[ -z "${f}" ]] && continue
      echo "    - ${f}"
    done < <(find "${d}" -maxdepth 3 -type f \( \
        -name "*.json" -o -name "*.po" -o -name "*.mo" \
     -o -name "*.yml" -o -name "*.yaml" -o -name "*.php" \
     -o -name "*.xliff" -o -name "*.xlf" \
     \) 2>/dev/null | sort)
  done | sort
fi

echo
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Résumé scan-locale-files :"
echo "  - Dossiers locale détectés : ${#FOUND_DIRS[@]}"
echo
if [[ "${#FOUND_DIRS[@]}" -gt 1 ]]; then
  echo -e "${C_YEL}[ATTENTION]${C_END} Plusieurs dossiers locale détectés."
  echo "  → vérifier qu'ils ne dupliquent pas le même contenu (mauvaise migration)."
fi
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

exit 0
