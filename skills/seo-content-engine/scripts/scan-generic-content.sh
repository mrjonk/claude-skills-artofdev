#!/usr/bin/env bash
# scan-generic-content.sh — Scan non destructif des phrases génériques / bullshit.
#
# Usage :
#   bash scan-generic-content.sh [<chemin>]
#
# Détecte dans .md / .html / .php / .tsx / .jsx / .vue / .twig :
#   - phrases creuses FR : "dans le monde d'aujourd'hui", "il est important de",
#     "de plus en plus", "solution innovante", "révolutionner", "optimiser votre expérience",
#     "améliorer votre productivité", "à l'ère du numérique", "il convient de noter"...
#   - phrases creuses EN : "in today's fast-paced world", "in this digital age",
#     "it is important to note", "game-changer", "cutting-edge", "best-in-class"...
#   - placeholders : "lorem ipsum", "placeholder", "content coming soon", "TODO"
#   - patterns IA caractéristiques : "plongeons dans", "dive into", "let's explore"...
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Affiche fichier:ligne pour chaque match.
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
  C_RED='\033[0;31m'; C_YEL='\033[0;33m'; C_GRN='\033[0;32m'; C_BLU='\033[0;34m'; C_END='\033[0m'
else
  C_RED=''; C_YEL=''; C_GRN=''; C_BLU=''; C_END=''
fi

EXCLUDED='node_modules|vendor|.git|.venv|venv|__pycache__|dist|build|.next|.nuxt|.turbo|exports|backups|.skill-backups|coverage'

mapfile -t FILES < <(
  find "${TARGET}" \
    -type d -regextype posix-extended -regex ".*/(${EXCLUDED})$" -prune \
    -o -type f \( \
       -name "*.md"  -o -name "*.html"  -o -name "*.htm" -o -name "*.php" \
    -o -name "*.tsx" -o -name "*.jsx"   -o -name "*.ts"  -o -name "*.js" \
    -o -name "*.vue" -o -name "*.svelte" \
    -o -name "*.twig" -o -name "*.blade.php" \
    \) -print
)

echo -e "${C_BLU}==> Scan de contenu générique sur ${TARGET}${C_END}"
echo "Fichiers de contenu scannés : ${#FILES[@]}"
echo

# Patterns à détecter (insensibles à la casse)
declare -a PATTERNS_FR=(
  "dans le monde d'aujourd'hui"
  "à l'ère du numérique"
  "de plus en plus de"
  "il est important de"
  "il convient de noter"
  "il va sans dire"
  "force est de constater"
  "au cœur de notre époque"
  "une solution innovante"
  "révolutionner"
  "optimiser votre expérience"
  "améliorer votre productivité"
  "booster votre business"
  "transformer votre quotidien"
  "une expérience inégalée"
  "le futur de"
  "l'avenir de"
  "disrupter"
  "une approche unique"
  "plongeons dans"
  "décortiquons"
  "explorons ensemble"
)

declare -a PATTERNS_EN=(
  "in today's fast-paced world"
  "in this digital age"
  "it is important to note"
  "at its core"
  "game-changer"
  "revolutionize"
  "cutting-edge"
  "best-in-class"
  "take your .* to the next level"
  "unleash the power of"
  "seamlessly integrate"
  "boost your productivity"
  "streamline your workflow"
  "empower your team"
  "let's dive into"
  "let's explore"
  "in conclusion, we have explored"
)

declare -a PATTERNS_PLACEHOLDER=(
  "lorem ipsum"
  "placeholder"
  "content coming soon"
  "your text here"
  "à compléter"
  "TODO"
  "FIXME"
  "XXX"
)

scan_patterns() {
  local label="$1"
  shift
  local patterns=("$@")
  local count=0

  for f in "${FILES[@]}"; do
    # Skip self + skill internal docs (qui listent les patterns à titre éducatif)
    if [[ "$(realpath "${f}" 2>/dev/null || echo "${f}")" == "$(realpath "${BASH_SOURCE[0]}" 2>/dev/null || echo "${BASH_SOURCE[0]}")" ]]; then
      continue
    fi
    case "${f}" in
      */references/anti-bullshit-rules.md|*/references/source-citation-guide.md|*/scripts/scan-generic-content.sh|*/scripts/scan-repetitions.sh)
        continue
        ;;
    esac

    for pat in "${patterns[@]}"; do
      matches="$(grep -E -i -n "${pat}" "${f}" 2>/dev/null | head -2 || true)"
      if [[ -n "${matches}" ]]; then
        count=$((count + 1))
        echo -e "${C_YEL}${f}${C_END}  →  ${C_RED}${pat}${C_END}"
        echo "${matches}" | sed 's/^/    /'
      fi
    done
  done

  if [[ "${count}" -eq 0 ]]; then
    echo -e "  ${C_GRN}aucune occurrence détectée pour ${label}${C_END}"
  fi
  echo
  echo "TOTAL_${label}=${count}"
  return 0
}

echo -e "${C_BLU}── Phrases creuses FR ──${C_END}"
scan_patterns "FR" "${PATTERNS_FR[@]}" || true
TOTAL_FR=$?  # not exit code, but for symmetry — count is in stdout above
echo

echo -e "${C_BLU}── Phrases creuses EN ──${C_END}"
scan_patterns "EN" "${PATTERNS_EN[@]}" || true
echo

echo -e "${C_BLU}── Placeholders / TODO ──${C_END}"
scan_patterns "PLACEHOLDER" "${PATTERNS_PLACEHOLDER[@]}" || true
echo

# Compter à la main pour le résumé final
count_all() {
  local total=0
  for f in "${FILES[@]}"; do
    if [[ "$(realpath "${f}" 2>/dev/null || echo "${f}")" == "$(realpath "${BASH_SOURCE[0]}" 2>/dev/null || echo "${BASH_SOURCE[0]}")" ]]; then continue; fi
    case "${f}" in
      */references/anti-bullshit-rules.md|*/references/source-citation-guide.md|*/scripts/scan-generic-content.sh|*/scripts/scan-repetitions.sh) continue ;;
    esac
    for pat in "$@"; do
      n=$(grep -E -i -c "${pat}" "${f}" 2>/dev/null) || n=0
      # n peut être vide si grep n'écrit rien
      n="${n:-0}"
      total=$((total + n))
    done
  done
  echo "${total}"
}

N_FR=$(count_all "${PATTERNS_FR[@]}")
N_EN=$(count_all "${PATTERNS_EN[@]}")
N_PH=$(count_all "${PATTERNS_PLACEHOLDER[@]}")
N_TOTAL=$((N_FR + N_EN + N_PH))

echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo "Résumé scan-generic-content :"
echo "  - phrases creuses FR        : ${N_FR}"
echo "  - phrases creuses EN        : ${N_EN}"
echo "  - placeholders / TODO       : ${N_PH}"
echo "  - Total signaux génériques  : ${N_TOTAL}"
echo

if [[ "${N_TOTAL}" -eq 0 ]]; then
  echo -e "${C_GRN}[OK] Aucun signal de contenu générique détecté.${C_END}"
else
  echo -e "${C_YEL}[ATTENTION] ${N_TOTAL} signaux à examiner avant publication.${C_END}"
fi
echo -e "${C_BLU}─────────────────────────────────────${C_END}"

exit 0
