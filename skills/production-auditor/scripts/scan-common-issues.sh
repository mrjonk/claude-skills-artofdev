#!/usr/bin/env bash
# scan-common-issues.sh — Scan non destructif des problèmes communs.
#
# Usage :
#   bash scan-common-issues.sh [<chemin>]
#
# Détecte :
#   - TODO / FIXME / XXX / HACK
#   - console.log / var_dump / print_r / dump / dd / debugger
#   - fichiers .bak / .old / .tmp / ~ (suspects)
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Affiche un résumé.
#   - Exit code 0 toujours (informatif). Pour intégrer dans un CI, parser la sortie.
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
    -o -type f -print
)

echo -e "${C_BLU}==> Scan des problèmes communs sur ${TARGET}${C_END}"
echo "Fichiers scannés : ${#FILES[@]}"
echo

# 1. TODO / FIXME / XXX / HACK
echo -e "${C_BLU}── TODO / FIXME / XXX / HACK ──${C_END}"
TODO_COUNT=0
for f in "${FILES[@]}"; do
  matches="$(grep -E -n -H '\b(TODO|FIXME|XXX|HACK)\b' "${f}" 2>/dev/null | head -3 || true)"
  if [[ -n "${matches}" ]]; then
    TODO_COUNT=$((TODO_COUNT + 1))
    echo -e "${C_YEL}${f}${C_END}"
    echo "${matches}" | sed 's/^/    /'
  fi
done
[[ "${TODO_COUNT}" -eq 0 ]] && echo -e "  ${C_GRN}aucun${C_END}"
echo

# 2. console.log / var_dump / print_r / dd / dump / debugger oubliés
echo -e "${C_BLU}── Logs de debug oubliés ──${C_END}"
DEBUG_COUNT=0
DEBUG_PATTERN='\b(console\.log|console\.debug|console\.warn|var_dump|print_r|debugger;?$|dd\(|dump\(|var_export\()'
for f in "${FILES[@]}"; do
  case "${f}" in
    *.md|*.txt|*.json|*.yaml|*.yml) continue ;;
  esac
  matches="$(grep -E -n -H "${DEBUG_PATTERN}" "${f}" 2>/dev/null | head -3 || true)"
  if [[ -n "${matches}" ]]; then
    DEBUG_COUNT=$((DEBUG_COUNT + 1))
    echo -e "${C_YEL}${f}${C_END}"
    echo "${matches}" | sed 's/^/    /'
  fi
done
[[ "${DEBUG_COUNT}" -eq 0 ]] && echo -e "  ${C_GRN}aucun${C_END}"
echo

# 3. Fichiers suspects (.bak, .old, .tmp, fichiers terminant en ~)
echo -e "${C_BLU}── Fichiers suspects (.bak / .old / .tmp / *~) ──${C_END}"
SUSPECT_FILES=()
for f in "${FILES[@]}"; do
  base="$(basename "${f}")"
  case "${base}" in
    *.bak|*.old|*.tmp|*~|*.orig|*.swp|.DS_Store|Thumbs.db)
      SUSPECT_FILES+=("${f}")
      ;;
  esac
done
if [[ "${#SUSPECT_FILES[@]}" -eq 0 ]]; then
  echo -e "  ${C_GRN}aucun${C_END}"
else
  for f in "${SUSPECT_FILES[@]}"; do
    echo -e "${C_YEL}${f}${C_END}"
  done
fi
echo

# 4. Fichiers très gros (> 5 Mo) — souvent de mauvaises surprises
echo -e "${C_BLU}── Fichiers > 5 Mo (potentiellement à exclure) ──${C_END}"
BIG_COUNT=0
for f in "${FILES[@]}"; do
  size="$(stat -c %s "${f}" 2>/dev/null || echo 0)"
  if [[ "${size}" -gt 5242880 ]]; then
    BIG_COUNT=$((BIG_COUNT + 1))
    size_h="$(du -h "${f}" 2>/dev/null | cut -f1)"
    echo -e "${C_YEL}${size_h}\t${f}${C_END}"
  fi
done
[[ "${BIG_COUNT}" -eq 0 ]] && echo -e "  ${C_GRN}aucun${C_END}"
echo

# Résumé
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Résumé scan-common-issues :"
echo "  - fichiers avec TODO/FIXME/XXX/HACK : ${TODO_COUNT}"
echo "  - fichiers avec logs debug oubliés  : ${DEBUG_COUNT}"
echo "  - fichiers suspects (.bak/.old/...) : ${#SUSPECT_FILES[@]}"
echo "  - fichiers > 5 Mo                   : ${BIG_COUNT}"
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

# Exit code 0 (informatif)
exit 0
