#!/usr/bin/env bash
# create-article-brief.sh — Crée docs/article-brief.md depuis le template.
#
# Usage :
#   bash create-article-brief.sh [<titre-provisoire>] [<destination-root>]
#
# Comportement :
#   - Crée docs/article-brief.md si absent.
#   - NE REMPLACE PAS si le fichier existe déjà (utilise un suffixe horodaté).
#   - Aucune suppression.
#
# Created by João de Almeida

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE="${SKILL_ROOT}/templates/article-brief.template.md"

TITLE="${1:-TITRE_PROVISOIRE}"
DEST_ROOT="${2:-.}"
DOCS_DIR="${DEST_ROOT}/docs"

if [[ ! -f "${TEMPLATE}" ]]; then
  echo "ERREUR : template introuvable : ${TEMPLATE}" >&2
  exit 1
fi

mkdir -p "${DOCS_DIR}"

TARGET_FILE="${DOCS_DIR}/article-brief.md"

if [[ -e "${TARGET_FILE}" ]]; then
  STAMP="$(date +%Y-%m-%d-%H%M%S)"
  TARGET_FILE="${DOCS_DIR}/article-brief-${STAMP}.md"
  echo "==> article-brief.md existe déjà — création d'un fichier daté : ${TARGET_FILE}"
fi

sed "s|{{TITRE_PROVISOIRE}}|${TITLE}|g" "${TEMPLATE}" > "${TARGET_FILE}"

echo "==> Brief créé : ${TARGET_FILE}"
echo
echo "Étapes suivantes :"
echo "  1. Compléter type de contenu, public, intention, ton."
echo "  2. Lister mots-clés principaux et secondaires."
echo "  3. Préparer le plan provisoire H1/H2/H3."
echo "  4. Lancer create-seo-outline.sh quand le brief est validé."
