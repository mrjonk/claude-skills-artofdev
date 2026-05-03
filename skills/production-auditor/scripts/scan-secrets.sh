#!/usr/bin/env bash
# scan-secrets.sh — Scan non destructif de secrets potentiels.
#
# Usage :
#   bash scan-secrets.sh [<chemin>]
#
# IMPORTANT :
#   - Le script ne reproduit JAMAIS la valeur d'un secret en clair.
#   - Il signale uniquement le fichier, le numéro de ligne, et un libellé du type de secret.
#   - Aucune suppression, aucune modification.
#   - Conçu pour être safe en mode VIDEO_PRESENTATION_MODE (cf. CLAUDE_PROJECT_FACTORY.md §29).
#
# Exit code :
#   - 0 si aucun secret détecté ;
#   - 1 si au moins un secret potentiel détecté.
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

echo -e "${C_BLU}==> Scan secrets sur ${TARGET}${C_END}"
echo "Fichiers scannés : ${#FILES[@]}"
echo

ALERT_COUNT=0

# 1. Fichiers sensibles par nom
echo -e "${C_BLU}── Fichiers sensibles par nom ──${C_END}"
DANGEROUS_FILES=(
  '\.env$'
  '\.env\.'
  'secrets\.json$'
  'credentials\.json$'
  '\.pem$'
  '\.key$'
  '\.p12$'
  '\.pfx$'
  '\.ppk$'
  '^id_rsa$'
  '^id_rsa\.pub$'
  '^id_ed25519$'
  '^id_ed25519\.pub$'
)

DANGEROUS_FOUND=0
for f in "${FILES[@]}"; do
  base="$(basename "${f}")"
  for pat in "${DANGEROUS_FILES[@]}"; do
    if [[ "${base}" =~ ${pat} ]]; then
      [[ "${base}" == ".env.example" ]] && continue
      echo -e "${C_RED}[FICHIER SENSIBLE]${C_END} ${f}"
      DANGEROUS_FOUND=$((DANGEROUS_FOUND + 1))
      ALERT_COUNT=$((ALERT_COUNT + 1))
      break
    fi
  done
done
[[ "${DANGEROUS_FOUND}" -eq 0 ]] && echo -e "  ${C_GRN}aucun${C_END}"
echo

# 2. Patterns de secrets connus dans les contenus
# IMPORTANT : on n'affiche jamais la valeur réelle, seulement le label + fichier:ligne
echo -e "${C_BLU}── Secrets potentiels dans les fichiers ──${C_END}"

# Tableau "label|regex"
declare -a PATTERNS
PATTERNS=(
  "GitHub PAT classic|ghp_[A-Za-z0-9]{36}"
  "GitHub fine-grained PAT|github_pat_[A-Za-z0-9_]{50,}"
  "GitHub OAuth token|gho_[A-Za-z0-9]{36}"
  "Stripe live secret|sk_live_[A-Za-z0-9]{20,}"
  "Stripe test secret|sk_test_[A-Za-z0-9]{20,}"
  "AWS access key|AKIA[0-9A-Z]{16}"
  "Slack token|xox[baprs]-[A-Za-z0-9-]{10,}"
  "Private key block|-----BEGIN (RSA |OPENSSH |EC |DSA )?PRIVATE KEY-----"
)

# Patterns "valeur attribuée non vide"
declare -a ASSIGN_PATTERNS
ASSIGN_PATTERNS=(
  "password assigned|(password|passwd|pwd)[[:space:]]*[=:][[:space:]]*['\"][^'\"]{6,}"
  "secret assigned|(secret)[[:space:]]*[=:][[:space:]]*['\"][^'\"]{6,}"
  "api_key assigned|(api[_-]?key)[[:space:]]*[=:][[:space:]]*['\"][^'\"]{6,}"
  "access_token assigned|(access[_-]?token)[[:space:]]*[=:][[:space:]]*['\"][^'\"]{6,}"
)

is_text_file() {
  local f="$1"
  [[ ! -s "$f" ]] && return 1
  if command -v file >/dev/null 2>&1; then
    local mt
    mt="$(file -b --mime-encoding "$f" 2>/dev/null || true)"
    [[ "$mt" != "binary" ]] && return 0
    return 1
  fi
  return 0
}

CONTENT_FOUND=0
for f in "${FILES[@]}"; do
  # Skip self
  if [[ "$(realpath "${f}" 2>/dev/null || echo "${f}")" == "$(realpath "${BASH_SOURCE[0]}" 2>/dev/null || echo "${BASH_SOURCE[0]}")" ]]; then
    continue
  fi
  # Skip docs/checklists qui mentionnent les patterns à titre éducatif
  case "${f}" in
    */references/security-checklist.md|\
    */references/audit-methodology.md|\
    */docs/security-rules.md|\
    */scripts/check-repo-safety.sh|\
    */scripts/scan-secrets.sh)
      continue
      ;;
  esac

  if ! is_text_file "${f}"; then
    continue
  fi

  # Patterns spécifiques (haute confiance)
  for entry in "${PATTERNS[@]}"; do
    label="${entry%%|*}"
    pat="${entry#*|}"
    matches="$(grep -E -n "${pat}" "${f}" 2>/dev/null | head -2 | cut -d: -f1 || true)"
    if [[ -n "${matches}" ]]; then
      while IFS= read -r line; do
        [[ -z "${line}" ]] && continue
        echo -e "${C_RED}[${label}]${C_END} ${f}:${line}  (valeur masquée)"
        CONTENT_FOUND=$((CONTENT_FOUND + 1))
        ALERT_COUNT=$((ALERT_COUNT + 1))
      done <<< "${matches}"
    fi
  done

  # Patterns d'assignation (whitelist .env.example)
  base="$(basename "${f}")"
  if [[ "${base}" != ".env.example" ]]; then
    for entry in "${ASSIGN_PATTERNS[@]}"; do
      label="${entry%%|*}"
      pat="${entry#*|}"
      matches="$(grep -E -i -n "${pat}" "${f}" 2>/dev/null | head -2 | cut -d: -f1 || true)"
      if [[ -n "${matches}" ]]; then
        while IFS= read -r line; do
          [[ -z "${line}" ]] && continue
          echo -e "${C_YEL}[${label}]${C_END} ${f}:${line}  (valeur masquée)"
          CONTENT_FOUND=$((CONTENT_FOUND + 1))
          ALERT_COUNT=$((ALERT_COUNT + 1))
        done <<< "${matches}"
      fi
    done
  fi
done

[[ "${CONTENT_FOUND}" -eq 0 ]] && echo -e "  ${C_GRN}aucun${C_END}"
echo

# Résumé
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
if [[ "${ALERT_COUNT}" -eq 0 ]]; then
  echo -e "${C_GRN}[OK]${C_END} Aucun secret détecté. (${#FILES[@]} fichiers scannés.)"
  echo -e "${C_BLU}─────────────────────────────────────${C_END}"
  exit 0
else
  echo -e "${C_RED}[ALERTE]${C_END} ${ALERT_COUNT} signalement(s)."
  echo
  echo "Action recommandée :"
  echo "  1. Révoquer immédiatement la clé/token côté du service concerné si push public possible."
  echo "  2. Retirer la valeur du repo (la mettre dans .env)."
  echo "  3. Mettre un placeholder dans .env.example."
  echo "  4. Mettre à jour .gitignore."
  echo "  5. Re-lancer ce scan jusqu'à 0 alerte."
  echo -e "${C_BLU}─────────────────────────────────────${C_END}"
  exit 1
fi
