#!/usr/bin/env bash
# scan-footer-patterns.sh — Cherche les patterns de footer (footer, copyright, legal, privacy, terms).
#
# Usage :
#   bash scan-footer-patterns.sh [<chemin>]
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Liste les fichiers contenant des patterns de footer.
#   - Détecte les copyrights statiques (année hardcodée).
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
  C_BLU='\033[0;34m'; C_YEL='\033[0;33m'; C_RED='\033[0;31m'; C_GRN='\033[0;32m'; C_END='\033[0m'
else
  C_BLU=''; C_YEL=''; C_RED=''; C_GRN=''; C_END=''
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

echo -e "${C_BLU}==> Scan patterns de footer sur ${TARGET}${C_END}"
echo "Fichiers UI scannés : ${#FILES[@]}"
echo

declare -A FOOTER_FILES=()
declare -A LEGAL_FILES=()
declare -A STATIC_COPYRIGHT_FILES=()

if [[ "${#FILES[@]}" -gt 0 ]]; then
  for f in "${FILES[@]}"; do
    # Pattern footer
    if grep -E -l '<footer\b|<Footer\b|class="[^"]*footer' "${f}" >/dev/null 2>&1; then
      FOOTER_FILES[$f]=1
    fi
    # Mentions légales
    if grep -E -i -l 'mentions[ -]?l[ée]gales|privacy[ -]policy|terms[ -]of[ -]service|conditions[ -]g[ée]n[ée]rales|RGPD|GDPR|CGV|CGU' "${f}" >/dev/null 2>&1; then
      LEGAL_FILES[$f]=1
    fi
    # Copyright statique (année hardcodée)
    if grep -E -l '©\s*20[0-9]{2}|&copy;\s*20[0-9]{2}|copyright\s+20[0-9]{2}' "${f}" >/dev/null 2>&1; then
      # Vérifier si c'est dynamique (new Date / date() / php year)
      if ! grep -E -l '(new Date\(\)\.getFullYear|date\(.[Yy].\)|Date\.now)' "${f}" >/dev/null 2>&1; then
        STATIC_COPYRIGHT_FILES[$f]=1
      fi
    fi
  done
fi

# Footers
echo -e "${C_BLU}── Fichiers avec patterns de footer ──${C_END}"
if [[ "${#FOOTER_FILES[@]}" -eq 0 ]]; then
  echo -e "  ${C_YEL}aucun footer détecté — possiblement un site sans footer ou utilise un layout global${C_END}"
else
  for f in "${!FOOTER_FILES[@]}"; do echo "  - ${f}"; done | sort
fi
echo

# Légaux
echo -e "${C_BLU}── Fichiers avec mentions légales / privacy / CGV ──${C_END}"
if [[ "${#LEGAL_FILES[@]}" -eq 0 ]]; then
  echo -e "  ${C_RED}AUCUN lien vers mentions légales / RGPD / CGV détecté${C_END}"
  echo "    → Vérifier que les pages légales existent et sont liées (footer)"
else
  for f in "${!LEGAL_FILES[@]}"; do echo "  - ${f}"; done | sort
fi
echo

# Copyright statique
echo -e "${C_BLU}── Copyright avec année statique (à remplacer par dynamique) ──${C_END}"
if [[ "${#STATIC_COPYRIGHT_FILES[@]}" -eq 0 ]]; then
  echo -e "  ${C_GRN}aucun copyright statique détecté${C_END}"
else
  for f in "${!STATIC_COPYRIGHT_FILES[@]}"; do
    echo -e "  ${C_YEL}${f}${C_END}"
    grep -E -n -H '©\s*20[0-9]{2}|&copy;\s*20[0-9]{2}|copyright\s+20[0-9]{2}' "${f}" 2>/dev/null | head -2 | sed 's/^/    /'
  done
fi
echo

# Résumé
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Résumé scan-footer-patterns :"
echo "  - Total fichiers avec footer       : ${#FOOTER_FILES[@]}"
echo "  - Total fichiers avec mentions     : ${#LEGAL_FILES[@]}"
echo "  - Total copyrights statiques       : ${#STATIC_COPYRIGHT_FILES[@]}"
echo

if [[ "${#FOOTER_FILES[@]}" -gt 3 ]]; then
  echo -e "${C_YEL}[ATTENTION]${C_END} ${#FOOTER_FILES[@]} fichiers contiennent un footer."
  echo "  → Vérifier si le footer est partagé (composant) ou hardcodé."
fi
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

exit 0
