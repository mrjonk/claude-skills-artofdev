#!/usr/bin/env bash
# create-site-ux-report.sh — Génère un rapport UX vide à partir du template.
#
# Usage :
#   bash create-site-ux-report.sh [<project-name>] [<destination-root>]
#
# Comportement :
#   - Crée <destination>/reports/site-ux-report-YYYY-MM-DD.md.
#   - Si le fichier existe déjà : ajoute YYYY-MM-DD-HHMMSS pour ne PAS écraser.
#   - Pré-remplit {{PROJECT_NAME}} et {{YYYY-MM-DD}}.
#   - Aucune suppression.
#
# Created by João de Almeida

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE="${SKILL_ROOT}/templates/final-coherence-report.template.md"

PROJECT_NAME="${1:-PROJECT_NAME}"
DEST_ROOT="${2:-.}"
REPORTS_DIR="${DEST_ROOT}/reports"

if [[ ! -f "${TEMPLATE}" ]]; then
  echo "ERREUR : template introuvable : ${TEMPLATE}" >&2
  exit 1
fi

mkdir -p "${REPORTS_DIR}"

DATE_PART="$(date +%Y-%m-%d)"
TARGET_FILE="${REPORTS_DIR}/site-ux-report-${DATE_PART}.md"

if [[ -e "${TARGET_FILE}" ]]; then
  STAMP="$(date +%Y-%m-%d-%H%M%S)"
  TARGET_FILE="${REPORTS_DIR}/site-ux-report-${STAMP}.md"
fi

sed \
  -e "s|{{PROJECT_NAME}}|${PROJECT_NAME}|g" \
  -e "s|{{YYYY-MM-DD}}|${DATE_PART}|g" \
  "${TEMPLATE}" > "${TARGET_FILE}"

echo "==> Rapport pré-rempli : ${TARGET_FILE}"
echo
echo "Étapes suivantes :"
echo "  1. Compléter chaque section (cohérence, scores, problèmes, plan d'action)."
echo "  2. Renseigner les fichiers concernés et les corrections."
echo "  3. Lister les délégations vers premium-webdesigner / production-auditor si applicable."
