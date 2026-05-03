#!/usr/bin/env bash
# create-design-brief.sh — Crée docs/design-brief.md à partir du template.
#
# Usage :
#   bash create-design-brief.sh [<project-name>] [<destination-root>]
#
# Comportement :
#   - Crée docs/design-brief.md si absent.
#   - NE REMPLACE PAS si le fichier existe déjà (signale et utilise un suffixe horodaté).
#   - Pré-remplit {{PROJECT_NAME}} et {{YYYY-MM-DD}}.
#   - Aucune suppression.
#
# Created by João de Almeida — Art of Dev — https://artofdev.space

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE="${SKILL_ROOT}/templates/design-brief.template.md"

PROJECT_NAME="${1:-PROJECT_NAME}"
DEST_ROOT="${2:-.}"
DOCS_DIR="${DEST_ROOT}/docs"

if [[ ! -f "${TEMPLATE}" ]]; then
  echo "ERREUR : template introuvable : ${TEMPLATE}" >&2
  exit 1
fi

mkdir -p "${DOCS_DIR}"

DATE_PART="$(date +%Y-%m-%d)"
TARGET_FILE="${DOCS_DIR}/design-brief.md"

if [[ -e "${TARGET_FILE}" ]]; then
  STAMP="$(date +%Y-%m-%d-%H%M%S)"
  TARGET_FILE="${DOCS_DIR}/design-brief-${STAMP}.md"
  echo "==> design-brief.md existe déjà — création d'un fichier daté : ${TARGET_FILE}"
fi

sed \
  -e "s|{{PROJECT_NAME}}|${PROJECT_NAME}|g" \
  -e "s|{{YYYY-MM-DD}}|${DATE_PART}|g" \
  "${TEMPLATE}" > "${TARGET_FILE}"

echo "==> Brief créé : ${TARGET_FILE}"
echo
echo "Étapes suivantes :"
echo "  1. Compléter cible, objectif, style, contraintes."
echo "  2. Valider avec l'utilisateur avant de coder."
echo "  3. Lancer la phase B (recherche d'inspiration) → moodboard-report."
