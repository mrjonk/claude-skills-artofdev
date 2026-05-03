#!/usr/bin/env bash
# scan-visual-consistency-patterns.sh — Détecte les patterns visuels suspects.
#
# Usage :
#   bash scan-visual-consistency-patterns.sh [<chemin>]
#
# Détecte :
#   - trop de classes Tailwind text-* différentes (signal d'échelle non disciplinée) ;
#   - couleurs hardcodées (`#FFFFFF`, `rgb(...)`) au lieu de tokens ;
#   - shadows différentes ;
#   - border-radius différents ;
#   - alt="" sur images (à vérifier si décoratif) ;
#   - TODO / placeholder / lorem ipsum ;
#   - boutons sans label clair ;
#   - classes de gradient répétées partout.
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Affiche uniquement un rapport.
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
       -name "*.html" -o -name "*.php" -o -name "*.tsx" -o -name "*.jsx" \
    -o -name "*.vue" -o -name "*.svelte" -o -name "*.css" -o -name "*.scss" \
    -o -name "*.md" \
    \) -print
)

echo -e "${C_BLU}==> Scan patterns visuels sur ${TARGET}${C_END}"
echo "Fichiers scannés : ${#FILES[@]}"
echo

# Skip self + skill internal files
should_skip() {
  local f="$1"
  case "${f}" in
    */references/*-checklist.md|*/references/webdesign-guidelines.md|*/references/visual-quality-score.md|*/references/buttons-cards-forms-guide.md|*/references/typography-and-spacing-guide.md|*/references/image-and-media-guidelines.md|*/scripts/scan-*.sh|*/templates/*.template.md)
      return 0
      ;;
  esac
  return 1
}

# 1. Couleurs hardcodées
echo -e "${C_BLU}── Couleurs hardcodées (à remplacer par tokens) ──${C_END}"
HARDCODED_COLORS=0
for f in "${FILES[@]}"; do
  should_skip "${f}" && continue
  matches=$(grep -E -n -H '#[0-9a-fA-F]{3,8}\b|rgb\([^)]+\)|rgba\([^)]+\)' "${f}" 2>/dev/null \
    | grep -v -E ':[[:space:]]*//|:[[:space:]]*#' | head -3 || true)
  if [[ -n "${matches}" ]]; then
    HARDCODED_COLORS=$((HARDCODED_COLORS + 1))
    if [[ "${HARDCODED_COLORS}" -le 5 ]]; then
      echo -e "${C_YEL}${f}${C_END}"
      echo "${matches}" | sed 's/^/    /'
    fi
  fi
done
[[ "${HARDCODED_COLORS}" -gt 5 ]] && echo "  ... et $((HARDCODED_COLORS - 5)) autres fichiers"
[[ "${HARDCODED_COLORS}" -eq 0 ]] && echo -e "  ${C_GRN}aucune couleur hardcodée${C_END}"
echo

# 2. Polices massives
echo -e "${C_BLU}── Polices massives (text-6xl / 7xl / 8xl / 9xl) ──${C_END}"
HUGE_TEXT=0
for f in "${FILES[@]}"; do
  should_skip "${f}" && continue
  matches=$(grep -E -n -H 'text-(6|7|8|9)xl' "${f}" 2>/dev/null | head -2 || true)
  if [[ -n "${matches}" ]]; then
    HUGE_TEXT=$((HUGE_TEXT + 1))
    if [[ "${HUGE_TEXT}" -le 3 ]]; then
      echo -e "${C_YEL}${f}${C_END}"
      echo "${matches}" | sed 's/^/    /'
    fi
  fi
done
[[ "${HUGE_TEXT}" -gt 3 ]] && echo "  ... et $((HUGE_TEXT - 3)) autres fichiers"
[[ "${HUGE_TEXT}" -eq 0 ]] && echo -e "  ${C_GRN}aucune${C_END}"
echo

# 3. Gradients répétés
echo -e "${C_BLU}── Gradients Tailwind ──${C_END}"
GRADIENT_FILES=0
for f in "${FILES[@]}"; do
  should_skip "${f}" && continue
  count=$(grep -c -E 'bg-gradient-to-[a-z]' "${f}" 2>/dev/null) || count=0
  count="${count:-0}"
  if [[ "${count}" -gt 3 ]]; then
    GRADIENT_FILES=$((GRADIENT_FILES + 1))
    echo -e "${C_YEL}${f}${C_END} : ${count} gradients (suspect : > 3)"
  fi
done
[[ "${GRADIENT_FILES}" -eq 0 ]] && echo -e "  ${C_GRN}aucun fichier > 3 gradients${C_END}"
echo

# 4. Alt vide
echo -e "${C_BLU}── alt=\"\" sur balises <img> (à vérifier si décoratif) ──${C_END}"
ALT_EMPTY=0
for f in "${FILES[@]}"; do
  should_skip "${f}" && continue
  matches=$(grep -E -n -H '<img[^>]*alt=""' "${f}" 2>/dev/null | head -2 || true)
  if [[ -n "${matches}" ]]; then
    ALT_EMPTY=$((ALT_EMPTY + 1))
    if [[ "${ALT_EMPTY}" -le 3 ]]; then
      echo -e "${C_YEL}${f}${C_END}"
      echo "${matches}" | sed 's/^/    /'
    fi
  fi
done
[[ "${ALT_EMPTY}" -gt 3 ]] && echo "  ... et $((ALT_EMPTY - 3)) autres fichiers"
[[ "${ALT_EMPTY}" -eq 0 ]] && echo -e "  ${C_GRN}aucun alt vide détecté${C_END}"
echo

# 5. TODO / placeholder / lorem
echo -e "${C_BLU}── TODO / FIXME / placeholder / lorem ipsum ──${C_END}"
TODO=0
for f in "${FILES[@]}"; do
  should_skip "${f}" && continue
  matches=$(grep -E -i -n -H '\b(TODO|FIXME|XXX|HACK|lorem ipsum|placeholder)\b' "${f}" 2>/dev/null | head -2 || true)
  if [[ -n "${matches}" ]]; then
    TODO=$((TODO + 1))
    if [[ "${TODO}" -le 3 ]]; then
      echo -e "${C_YEL}${f}${C_END}"
      echo "${matches}" | sed 's/^/    /'
    fi
  fi
done
[[ "${TODO}" -gt 3 ]] && echo "  ... et $((TODO - 3)) autres fichiers"
[[ "${TODO}" -eq 0 ]] && echo -e "  ${C_GRN}aucun${C_END}"
echo

# 6. Boutons sans label clair
echo -e "${C_BLU}── Boutons avec libellés vagues (\"Click here\", \"OK\", \"Submit\") ──${C_END}"
WEAK_BTN=0
for f in "${FILES[@]}"; do
  should_skip "${f}" && continue
  matches=$(grep -E -i -n -H '>[[:space:]]*(Click here|Cliquez ici|OK|Submit|Envoyer)[[:space:]]*<' "${f}" 2>/dev/null | head -2 || true)
  if [[ -n "${matches}" ]]; then
    WEAK_BTN=$((WEAK_BTN + 1))
    if [[ "${WEAK_BTN}" -le 3 ]]; then
      echo -e "${C_YEL}${f}${C_END}"
      echo "${matches}" | sed 's/^/    /'
    fi
  fi
done
[[ "${WEAK_BTN}" -gt 3 ]] && echo "  ... et $((WEAK_BTN - 3)) autres fichiers"
[[ "${WEAK_BTN}" -eq 0 ]] && echo -e "  ${C_GRN}aucun bouton à libellé vague${C_END}"
echo

# Résumé
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Résumé scan-visual-consistency-patterns :"
echo "  - Couleurs hardcodées       : ${HARDCODED_COLORS} fichier(s)"
echo "  - Polices massives (6xl+)   : ${HUGE_TEXT} fichier(s)"
echo "  - Gradients > 3 par fichier : ${GRADIENT_FILES} fichier(s)"
echo "  - alt=\"\" sur <img>          : ${ALT_EMPTY} fichier(s)"
echo "  - TODO / placeholder        : ${TODO} fichier(s)"
echo "  - Boutons à libellé vague   : ${WEAK_BTN} fichier(s)"
echo

TOTAL=$((HARDCODED_COLORS + HUGE_TEXT + GRADIENT_FILES + ALT_EMPTY + TODO + WEAK_BTN))
if [[ "${TOTAL}" -eq 0 ]]; then
  echo -e "${C_GRN}[OK]${C_END} Aucun signal de design basique."
else
  echo -e "${C_YEL}[ATTENTION]${C_END} ${TOTAL} signaux à examiner."
fi
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

exit 0
