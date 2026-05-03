#!/usr/bin/env bash
# generate-audit-report.sh — Génère un squelette de rapport d'audit.
#
# Usage :
#   bash generate-audit-report.sh [<project-name>] [<destination-dir>]
#
# Comportement :
#   - Crée <destination-dir>/reports/ si absent.
#   - Génère <destination-dir>/reports/audit-YYYY-MM-DD.md.
#   - Si le fichier existe déjà : utilise YYYY-MM-DD-HHMMSS pour ne PAS écraser.
#   - Pré-remplit le squelette à partir de templates/audit-report.template.md.
#   - Ne supprime, ne modifie aucun rapport existant.
#
# Created by João de Almeida — Art of Dev — https://artofdev.space

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE="${SKILL_ROOT}/templates/audit-report.template.md"

PROJECT_NAME="${1:-PROJECT_NAME}"
DEST_ROOT="${2:-.}"
REPORTS_DIR="${DEST_ROOT}/reports"

if [[ ! -f "${TEMPLATE}" ]]; then
  echo "ERREUR : template introuvable : ${TEMPLATE}" >&2
  exit 1
fi

mkdir -p "${REPORTS_DIR}"

DATE_PART="$(date +%Y-%m-%d)"
TARGET_FILE="${REPORTS_DIR}/audit-${DATE_PART}.md"

if [[ -e "${TARGET_FILE}" ]]; then
  STAMP="$(date +%Y-%m-%d-%H%M%S)"
  TARGET_FILE="${REPORTS_DIR}/audit-${STAMP}.md"
fi

# Pré-remplir : substitutions évidentes
sed \
  -e "s|{{PROJECT_NAME}}|${PROJECT_NAME}|g" \
  -e "s|{{YYYY-MM-DD}}|${DATE_PART}|g" \
  "${TEMPLATE}" > "${TARGET_FILE}"

echo "==> Rapport pré-rempli : ${TARGET_FILE}"
echo
echo "Étapes suivantes :"
echo "  1. Compléter score, problèmes, corrections."
echo "  2. Sauvegarder."
echo "  3. (optionnel) commit dans le repo."
