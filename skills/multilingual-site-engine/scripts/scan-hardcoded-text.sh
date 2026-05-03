#!/usr/bin/env bash
# scan-hardcoded-text.sh — Cherche les chaînes hardcodées qui devraient passer par un système i18n.
#
# Usage :
#   bash scan-hardcoded-text.sh [<chemin>]
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Liste les fichiers où des chaînes en français ou anglais semblent hardcodées
#     (sans appel à t(), __(), trans(), ou un wrapper i18n).
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

EXCLUDED='node_modules|vendor|.git|.venv|venv|__pycache__|dist|build|.next|.nuxt|.turbo|exports|backups|.skill-backups|coverage|locales|messages|translations|lang'

mapfile -t FILES < <(
  find "${TARGET}" \
    -type d -regextype posix-extended -regex ".*/(${EXCLUDED})$" -prune \
    -o -type f \( \
       -name "*.tsx" -o -name "*.jsx" -o -name "*.ts" -o -name "*.js" \
    -o -name "*.vue" -o -name "*.svelte" -o -name "*.astro" \
    -o -name "*.php" -o -name "*.html" -o -name "*.blade.php" -o -name "*.twig" \
    \) -print
)

echo -e "${C_BLU}==> Scan chaînes hardcodées sur ${TARGET}${C_END}"
echo "Fichiers scannés : ${#FILES[@]}"
echo

declare -A SUSPECT_FILES=()

# Patterns détectant un mot français ou anglais commun en literal
# (juste un signal — la décision finale reste manuelle)
declare -a HEURISTIC_PATTERNS=(
  '"[A-Z][a-zà-ÿ]+ [a-zà-ÿ]+'
  "'[A-Z][a-zà-ÿ]+ [a-zà-ÿ]+"
  '>[A-Z][a-zà-ÿ]+ [a-zà-ÿ]+ [a-zà-ÿ]+<'
)

# Patterns d'appels i18n légitimes (à exclure du signal)
declare -a I18N_CALLS=(
  't\('
  'i18n\.'
  'useTranslations'
  'getTranslations'
  '__\('
  '_e\('
  'esc_html__\('
  'esc_attr__\('
  'trans\('
  'tr\.'
  'gettext\('
  '\$t\('
  '<Trans'
  'Translate'
)

if [[ "${#FILES[@]}" -gt 0 ]]; then
  for f in "${FILES[@]}"; do
    HAS_HEURISTIC=0
    for pat in "${HEURISTIC_PATTERNS[@]}"; do
      if grep -E -l "${pat}" "${f}" >/dev/null 2>&1; then
        HAS_HEURISTIC=1
        break
      fi
    done
    if [[ "${HAS_HEURISTIC}" -eq 0 ]]; then
      continue
    fi
    HAS_I18N=0
    for call in "${I18N_CALLS[@]}"; do
      if grep -E -l "${call}" "${f}" >/dev/null 2>&1; then
        HAS_I18N=1
        break
      fi
    done
    if [[ "${HAS_I18N}" -eq 0 ]]; then
      SUSPECT_FILES[$f]=1
    fi
  done
fi

if [[ "${#SUSPECT_FILES[@]}" -eq 0 ]]; then
  echo -e "  ${C_GRN}aucun fichier suspect — soit tout passe par i18n, soit les chaînes sont en JSON / config${C_END}"
else
  echo "Fichiers suspects (chaînes hardcodées sans appel i18n détecté) :"
  for f in "${!SUSPECT_FILES[@]}"; do
    echo "  - ${f}"
  done | sort
fi

echo
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Résumé scan-hardcoded-text :"
echo "  - Total fichiers suspects : ${#SUSPECT_FILES[@]}"
echo
if [[ "${#SUSPECT_FILES[@]}" -gt 0 ]]; then
  echo -e "${C_YEL}[ATTENTION]${C_END} Ces fichiers contiennent du texte qui semble hardcodé."
  echo "  → Inspecter manuellement, certaines chaînes sont des libellés UI à extraire."
  echo "  → Les faux positifs sont normaux (commentaires, logs, contenus markdown)."
fi
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

exit 0
