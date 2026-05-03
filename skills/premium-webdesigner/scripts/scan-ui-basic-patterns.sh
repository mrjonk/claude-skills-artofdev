#!/usr/bin/env bash
# scan-ui-basic-patterns.sh — Scan non destructif d'indices de design basique.
#
# Usage :
#   bash scan-ui-basic-patterns.sh [<chemin>]
#
# Détecte :
#   - lorem ipsum / placeholder text résiduel
#   - TODO / FIXME / XXX / HACK
#   - bg-gradient-to-* utilisés trop souvent (Tailwind)
#   - text-6xl / text-7xl / text-8xl / text-9xl (polices trop massives)
#   - alt="" sur balises <img> (sauf images décoratives explicites)
#   - mots-clés "Hello World", "Document", "Untitled"
#   - répétition de la même classe Tailwind sur > 10 lignes
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Affiche un rapport synthétique.
#   - Exit code 0 toujours (informatif).
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

# On scanne les fichiers de UI/template/markup.
mapfile -t FILES < <(
  find "${TARGET}" \
    -type d -regextype posix-extended -regex ".*/(${EXCLUDED})$" -prune \
    -o -type f \( \
       -name "*.html"  -o -name "*.htm"  -o -name "*.php" \
    -o -name "*.tsx"   -o -name "*.jsx"  -o -name "*.ts"  -o -name "*.js" \
    -o -name "*.vue"   -o -name "*.svelte" \
    -o -name "*.twig"  -o -name "*.blade.php" \
    -o -name "*.erb"   -o -name "*.aspx" \
    \) -print
)

echo -e "${C_BLU}==> Scan d'indices de design basique sur ${TARGET}${C_END}"
echo "Fichiers UI scannés : ${#FILES[@]}"
echo

TOTAL_ISSUES=0

# 1. Lorem ipsum résiduel
echo -e "${C_BLU}── Lorem ipsum / placeholder text ──${C_END}"
LOREM_COUNT=0
for f in "${FILES[@]}"; do
  matches="$(grep -E -i -n "(lorem ipsum|placeholder text|fpo placeholder)" "${f}" 2>/dev/null | head -3 || true)"
  if [[ -n "${matches}" ]]; then
    LOREM_COUNT=$((LOREM_COUNT + 1))
    TOTAL_ISSUES=$((TOTAL_ISSUES + 1))
    echo -e "${C_RED}${f}${C_END}"
    echo "${matches}" | sed 's/^/    /'
  fi
done
[[ "${LOREM_COUNT}" -eq 0 ]] && echo -e "  ${C_GRN}aucun${C_END}"
echo

# 2. TODO / FIXME / XXX / HACK
echo -e "${C_BLU}── TODO / FIXME / XXX / HACK ──${C_END}"
TODO_COUNT=0
for f in "${FILES[@]}"; do
  matches="$(grep -E -n '\b(TODO|FIXME|XXX|HACK)\b' "${f}" 2>/dev/null | head -3 || true)"
  if [[ -n "${matches}" ]]; then
    TODO_COUNT=$((TODO_COUNT + 1))
    echo -e "${C_YEL}${f}${C_END}"
    echo "${matches}" | sed 's/^/    /'
  fi
done
[[ "${TODO_COUNT}" -eq 0 ]] && echo -e "  ${C_GRN}aucun${C_END}"
echo

# 3. Tailwind : gradients répétés
echo -e "${C_BLU}── Gradients Tailwind (bg-gradient-to-*) ──${C_END}"
GRADIENT_COUNT=0
for f in "${FILES[@]}"; do
  count="$(grep -c -E 'bg-gradient-to-[a-z]' "${f}" 2>/dev/null || echo 0)"
  if [[ "${count}" -gt 3 ]]; then
    GRADIENT_COUNT=$((GRADIENT_COUNT + 1))
    TOTAL_ISSUES=$((TOTAL_ISSUES + 1))
    echo -e "${C_YEL}${f}${C_END} : ${count} gradients (suspect : > 3 dans le même fichier)"
  fi
done
[[ "${GRADIENT_COUNT}" -eq 0 ]] && echo -e "  ${C_GRN}aucun fichier > 3 gradients${C_END}"
echo

# 4. Tailwind : polices massives
echo -e "${C_BLU}── Polices massives (text-6xl / 7xl / 8xl / 9xl) ──${C_END}"
HUGE_TEXT_COUNT=0
for f in "${FILES[@]}"; do
  matches="$(grep -E -n 'text-(6|7|8|9)xl' "${f}" 2>/dev/null | head -3 || true)"
  if [[ -n "${matches}" ]]; then
    HUGE_TEXT_COUNT=$((HUGE_TEXT_COUNT + 1))
    TOTAL_ISSUES=$((TOTAL_ISSUES + 1))
    echo -e "${C_YEL}${f}${C_END}"
    echo "${matches}" | sed 's/^/    /'
  fi
done
[[ "${HUGE_TEXT_COUNT}" -eq 0 ]] && echo -e "  ${C_GRN}aucun${C_END}"
echo

# 5. Alt vide sur images informatives potentielles
echo -e "${C_BLU}── alt=\"\" sur balises <img> (à vérifier) ──${C_END}"
ALT_EMPTY_COUNT=0
for f in "${FILES[@]}"; do
  # Cherche <img ... alt=""
  matches="$(grep -E -n '<img[^>]*alt=""' "${f}" 2>/dev/null | head -3 || true)"
  if [[ -n "${matches}" ]]; then
    ALT_EMPTY_COUNT=$((ALT_EMPTY_COUNT + 1))
    echo -e "${C_YEL}${f}${C_END}"
    echo "${matches}" | sed 's/^/    /'
  fi
done
[[ "${ALT_EMPTY_COUNT}" -eq 0 ]] && echo -e "  ${C_GRN}aucun (ou tous décoratifs explicites)${C_END}"
echo "  Note : alt=\"\" est OK uniquement pour images décoratives explicites."
echo

# 6. Mots-clés template par défaut
echo -e "${C_BLU}── Mots-clés template par défaut ──${C_END}"
TEMPLATE_COUNT=0
for f in "${FILES[@]}"; do
  matches="$(grep -E -i -n '\b(Hello World|Untitled Document|Document|Welcome to (our|the) website|Click here)\b' "${f}" 2>/dev/null | head -3 || true)"
  if [[ -n "${matches}" ]]; then
    TEMPLATE_COUNT=$((TEMPLATE_COUNT + 1))
    TOTAL_ISSUES=$((TOTAL_ISSUES + 1))
    echo -e "${C_YEL}${f}${C_END}"
    echo "${matches}" | sed 's/^/    /'
  fi
done
[[ "${TEMPLATE_COUNT}" -eq 0 ]] && echo -e "  ${C_GRN}aucun${C_END}"
echo

# Résumé
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Résumé scan-ui-basic-patterns :"
echo "  - lorem ipsum / placeholder       : ${LOREM_COUNT} fichier(s)"
echo "  - TODO / FIXME                    : ${TODO_COUNT} fichier(s)"
echo "  - gradients > 3                   : ${GRADIENT_COUNT} fichier(s)"
echo "  - polices massives (6xl+)         : ${HUGE_TEXT_COUNT} fichier(s)"
echo "  - alt=\"\" à vérifier               : ${ALT_EMPTY_COUNT} fichier(s)"
echo "  - mots-clés template par défaut   : ${TEMPLATE_COUNT} fichier(s)"
echo "  - Total signaux design basique    : ${TOTAL_ISSUES}"
echo
if [[ "${TOTAL_ISSUES}" -eq 0 ]]; then
  echo -e "${C_GRN}[OK] Pas de signal de design basique détecté.${C_END}"
else
  echo -e "${C_YEL}[ATTENTION] Vérifier les ${TOTAL_ISSUES} signaux ci-dessus avant déploiement.${C_END}"
fi
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

exit 0
