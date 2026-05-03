#!/usr/bin/env bash
# scan-hardcoded-navigation.sh — Détecte les menus copiés-collés dans plusieurs fichiers.
#
# Usage :
#   bash scan-hardcoded-navigation.sh [<chemin>]
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Cherche les libellés de menu courants ("Accueil", "Home", "About", "Contact", etc.).
#   - Détecte les fichiers qui contiennent les mêmes libellés (suspect = menu hardcodé).
#   - Affiche un résumé.
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
    -o -name "*.tsx" -o -name "*.jsx" -o -name "*.vue" -o -name "*.svelte" \
    -o -name "*.twig" -o -name "*.blade.php" -o -name "*.aspx" -o -name "*.astro" \
    \) -print
)

echo -e "${C_BLU}==> Scan menus hardcodés sur ${TARGET}${C_END}"
echo "Fichiers UI scannés : ${#FILES[@]}"
echo

# Libellés de menu fréquents à chercher (FR + EN)
declare -a MENU_LABELS=(
  'Accueil' 'Home'
  'À propos' 'About' 'About us'
  'Services' 'Nos services'
  'Tarifs' 'Pricing'
  'Blog' 'Articles' 'News'
  'Contact' 'Nous contacter' 'Contact us'
  'Mentions' 'Mentions légales' 'Legal'
  'CGV' 'CGU' 'Privacy' 'Privacy Policy'
  'Connexion' 'Login' 'Sign in'
  'Inscription' 'Register' 'Sign up'
)

declare -A FILES_WITH_MENU

for f in "${FILES[@]}"; do
  count=0
  for label in "${MENU_LABELS[@]}"; do
    if grep -q -- "${label}" "${f}" 2>/dev/null; then
      count=$((count + 1))
    fi
  done
  # Si un fichier contient 4+ labels de menu, c'est probablement un menu hardcodé
  if [[ "${count}" -ge 4 ]]; then
    FILES_WITH_MENU[$f]=$count
  fi
done

echo -e "${C_BLU}── Fichiers contenant 4+ libellés de menu (menu probablement hardcodé) ──${C_END}"
if [[ "${#FILES_WITH_MENU[@]}" -eq 0 ]]; then
  echo -e "  ${C_GRN}aucun menu hardcodé détecté${C_END}"
elif [[ "${#FILES_WITH_MENU[@]}" -le 2 ]]; then
  echo -e "  ${C_GRN}${#FILES_WITH_MENU[@]} fichier(s) — probablement le composant Header / Footer canonique${C_END}"
  for f in "${!FILES_WITH_MENU[@]}"; do
    echo "  - ${f} (${FILES_WITH_MENU[$f]} libellés détectés)"
  done | sort
else
  echo -e "  ${C_YEL}${#FILES_WITH_MENU[@]} fichiers détectés — menu probablement hardcodé dans plusieurs endroits${C_END}"
  for f in "${!FILES_WITH_MENU[@]}"; do
    echo "  - ${f} (${FILES_WITH_MENU[$f]} libellés détectés)"
  done | sort
fi
echo

# Résumé
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Résumé scan-hardcoded-navigation :"
echo "  - Fichiers avec 4+ libellés menu : ${#FILES_WITH_MENU[@]}"
echo
if [[ "${#FILES_WITH_MENU[@]}" -gt 2 ]]; then
  echo -e "${C_YEL}[ATTENTION]${C_END} Menu probablement hardcodé dans ${#FILES_WITH_MENU[@]} fichiers."
  echo "  → Recommander un composant partagé (Header.tsx / header.php / etc.)."
  echo "  → Ne PAS refactoriser sans validation utilisateur."
elif [[ "${#FILES_WITH_MENU[@]}" -le 2 ]] && [[ "${#FILES_WITH_MENU[@]}" -gt 0 ]]; then
  echo -e "${C_GRN}[OK]${C_END} Menu probablement déjà partagé dans 1–2 composants."
fi
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

exit 0
