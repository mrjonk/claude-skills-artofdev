#!/usr/bin/env bash
# check-repo-safety.sh — Audit non destructif d'un repo avant commit.
#
# Usage :
#   bash check-repo-safety.sh [<chemin>]
#
# Comportement :
#   - SCAN UNIQUEMENT, ne supprime rien, ne modifie rien.
#   - Vérifie l'absence de fichiers dangereux (.env, *.key, *.pem, id_rsa, dumps...).
#   - Vérifie l'absence de chaînes suspectes (tokens GitHub/Stripe/AWS/Slack, blocs
#     PRIVATE KEY, mots-clés password=/secret=/token=/api_key= avec valeur).
#   - Affiche un résumé clair et code-couleur (si TTY).
#   - Exit code 0 si rien de suspect, 1 sinon.
#
# Options d'environnement :
#   CHECK_VERBOSE=1   — affiche aussi les fichiers ignorés.
#
# Created by João de Almeida — Art of Dev — https://artofdev.space

set -euo pipefail

TARGET="${1:-.}"

if [[ ! -d "${TARGET}" ]]; then
  echo "ERREUR : ${TARGET} n'est pas un dossier." >&2
  exit 2
fi

# Couleurs si TTY
if [[ -t 1 ]]; then
  C_RED='\033[0;31m'
  C_YEL='\033[0;33m'
  C_GRN='\033[0;32m'
  C_BLU='\033[0;34m'
  C_END='\033[0m'
else
  C_RED=''; C_YEL=''; C_GRN=''; C_BLU=''; C_END=''
fi

ALERT_COUNT=0
SCAN_FILE_COUNT=0

log_alert() {
  ALERT_COUNT=$((ALERT_COUNT + 1))
  echo -e "${C_RED}[ALERTE]${C_END} $*"
}

log_warn() {
  echo -e "${C_YEL}[ATTENTION]${C_END} $*"
}

log_ok() {
  echo -e "${C_GRN}[OK]${C_END} $*"
}

log_info() {
  echo -e "${C_BLU}[INFO]${C_END} $*"
}

# --- 1. Fichiers dangereux par nom ---

# Patterns de fichiers à ne JAMAIS commit er.
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
  'id_rsa$'
  'id_rsa\.pub$'
  'id_ed25519$'
  'id_ed25519\.pub$'
  '\.sqlite$'
  '\.sqlite3$'
  '\.sql$'
  '\.dump$'
  '\.bak$'
)

# Liste des fichiers du repo, en excluant explicitement node_modules/, vendor/,
# .git/, .venv/, __pycache__/, dist/, build/, .next/, exports/.
mapfile -t FILES < <(
  find "${TARGET}" \
    -type d \( \
        -name node_modules \
     -o -name vendor \
     -o -name .git \
     -o -name .venv \
     -o -name venv \
     -o -name __pycache__ \
     -o -name dist \
     -o -name build \
     -o -name .next \
     -o -name .nuxt \
     -o -name .turbo \
     -o -name exports \
     -o -name backups \
     -o -name .skill-backups \
    \) -prune \
    -o -type f -print
)

SCAN_FILE_COUNT="${#FILES[@]}"
log_info "Fichiers scannés : ${SCAN_FILE_COUNT}"

# --- Filename scan ---

for f in "${FILES[@]}"; do
  base="$(basename "${f}")"
  for pat in "${DANGEROUS_FILES[@]}"; do
    if [[ "${base}" =~ ${pat} ]]; then
      # Whitelist explicite
      if [[ "${base}" == ".env.example" ]]; then
        continue
      fi
      log_alert "Fichier sensible présent : ${f}"
    fi
  done
done

# --- 2. Contenus suspects ---

# Patterns regex de secrets connus (extended regex).
SECRET_PATTERNS=(
  'ghp_[A-Za-z0-9]{36}'                   # GitHub PAT classic
  'github_pat_[A-Za-z0-9_]{50,}'          # GitHub fine-grained PAT
  'gho_[A-Za-z0-9]{36}'                   # GitHub OAuth token
  'sk_live_[A-Za-z0-9]{20,}'              # Stripe live secret
  'sk_test_[A-Za-z0-9]{20,}'              # Stripe test secret
  'AKIA[0-9A-Z]{16}'                      # AWS access key
  'xox[baprs]-[A-Za-z0-9-]{10,}'          # Slack token
  '-----BEGIN (RSA |OPENSSH |EC |DSA )?PRIVATE KEY-----'
)

# Patterns "valeur attribuée" (avec valeur non vide, au moins 6 chars)
ASSIGN_PATTERNS=(
  "(password|passwd|pwd)\\s*[=:]\\s*['\"][^'\"]{6,}"
  "(secret)\\s*[=:]\\s*['\"][^'\"]{6,}"
  "(api[_-]?key)\\s*[=:]\\s*['\"][^'\"]{6,}"
  "(access[_-]?token)\\s*[=:]\\s*['\"][^'\"]{6,}"
)

# On ne scanne que les fichiers texte — on saute binaires et .gitkeep vides.
is_text_file() {
  local f="$1"
  if [[ ! -s "$f" ]]; then return 1; fi
  # Heuristique : utilise file -b si dispo
  if command -v file >/dev/null 2>&1; then
    local mt
    mt="$(file -b --mime-encoding "$f" 2>/dev/null || true)"
    [[ "$mt" != "binary" ]] && return 0
    return 1
  fi
  # Fallback : essaie de grep, échoue silencieusement si binaire
  return 0
}

scan_content_for_patterns() {
  local f="$1"
  shift
  local pats=("$@")
  for pat in "${pats[@]}"; do
    if grep -E -n -H "${pat}" "${f}" 2>/dev/null | head -3; then
      return 0
    fi
  done
  return 1
}

for f in "${FILES[@]}"; do
  # Skip self (le script lui-même contient les patterns ; faux positif sinon).
  if [[ "$(realpath "${f}" 2>/dev/null || echo "${f}")" == "$(realpath "${BASH_SOURCE[0]}" 2>/dev/null || echo "${BASH_SOURCE[0]}")" ]]; then
    continue
  fi
  # Skip security-checklist.md et autres docs du skill (qui mentionnent les patterns à titre éducatif).
  case "${f}" in
    */references/security-checklist.md|*/docs/security-rules.md)
      continue
      ;;
  esac

  if ! is_text_file "${f}"; then
    [[ "${CHECK_VERBOSE:-0}" == "1" ]] && log_info "binaire ignoré : ${f}"
    continue
  fi

  # 2.a — patterns de secrets très spécifiques (haute confiance)
  for pat in "${SECRET_PATTERNS[@]}"; do
    matches="$(grep -E -n -H "${pat}" "${f}" 2>/dev/null | head -3 || true)"
    if [[ -n "${matches}" ]]; then
      log_alert "Secret potentiel dans ${f} :"
      echo "${matches}" | sed 's/^/      /'
    fi
  done

  # 2.b — patterns d'assignation (moyenne confiance)
  for pat in "${ASSIGN_PATTERNS[@]}"; do
    matches="$(grep -E -i -n -H "${pat}" "${f}" 2>/dev/null | head -3 || true)"
    if [[ -n "${matches}" ]]; then
      # Whitelist : .env.example contient des placeholders → OK
      base="$(basename "${f}")"
      if [[ "${base}" == ".env.example" ]]; then
        continue
      fi
      log_warn "Affectation suspecte dans ${f} :"
      echo "${matches}" | sed 's/^/      /'
      ALERT_COUNT=$((ALERT_COUNT + 1))
    fi
  done
done

# --- 3. Résumé final ---

echo
echo "─────────────────────────────────────"
echo "Audit sécurité — ${TARGET}"
echo "Fichiers scannés : ${SCAN_FILE_COUNT}"
if [[ "${ALERT_COUNT}" -eq 0 ]]; then
  log_ok "Aucune alerte. Repo prêt pour le commit."
  echo "─────────────────────────────────────"
  exit 0
else
  log_alert "${ALERT_COUNT} alerte(s) détectée(s)."
  echo "Action recommandée :"
  echo "  - retirer les valeurs réelles ;"
  echo "  - les déplacer dans .env (non commit é) ;"
  echo "  - mettre des placeholders dans .env.example ;"
  echo "  - mettre à jour .gitignore ;"
  echo "  - relancer cet audit avant tout git add."
  echo "─────────────────────────────────────"
  exit 1
fi
