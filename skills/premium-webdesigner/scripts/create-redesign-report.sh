#!/usr/bin/env bash
# create-redesign-report.sh — Génère un squelette de rapport de redesign.
#
# Usage :
#   bash create-redesign-report.sh [<project-name>] [<destination-root>]
#
# Comportement :
#   - Crée <destination-root>/reports/ si absent.
#   - Génère reports/redesign-YYYY-MM-DD.md.
#   - Si le fichier existe déjà : ajoute YYYY-MM-DD-HHMMSS pour ne PAS écraser.
#   - Pré-remplit {{PROJECT_NAME}} et {{YYYY-MM-DD}}.
#   - Aucune suppression.
#
# Created by João de Almeida — Art of Dev — https://artofdev.space

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE="${SKILL_ROOT}/templates/redesign-report.template.md"

PROJECT_NAME="${1:-PROJECT_NAME}"
DEST_ROOT="${2:-.}"
REPORTS_DIR="${DEST_ROOT}/reports"

if [[ ! -f "${TEMPLATE}" ]]; then
  echo "ERREUR : template introuvable : ${TEMPLATE}" >&2
  exit 1
fi

mkdir -p "${REPORTS_DIR}"

DATE_PART="$(date +%Y-%m-%d)"
TARGET_FILE="${REPORTS_DIR}/redesign-${DATE_PART}.md"

if [[ -e "${TARGET_FILE}" ]]; then
  STAMP="$(date +%Y-%m-%d-%H%M%S)"
  TARGET_FILE="${REPORTS_DIR}/redesign-${STAMP}.md"
fi

sed \
  -e "s|{{PROJECT_NAME}}|${PROJECT_NAME}|g" \
  -e "s|{{YYYY-MM-DD}}|${DATE_PART}|g" \
  "${TEMPLATE}" > "${TARGET_FILE}"

echo "==> Rapport pré-rempli : ${TARGET_FILE}"
echo
echo "Étapes suivantes :"
echo "  1. Compléter chaque section (problèmes initiaux, direction, composants, images, fichiers)."
echo "  2. Renseigner les scores (cf. ui-quality-checklist.template.md)."
echo "  3. Sauvegarder."
echo "  4. (optionnel) commit dans le repo."
