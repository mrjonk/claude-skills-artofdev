#!/usr/bin/env bash
# create-seo-outline.sh — Crée docs/seo-outline.md depuis le template.
#
# Usage :
#   bash create-seo-outline.sh [<titre>] [<destination-root>]
#
# Comportement :
#   - Crée docs/seo-outline.md si absent.
#   - NE REMPLACE PAS si le fichier existe déjà (utilise un suffixe horodaté).
#   - Aucune suppression.
#
# Created by João de Almeida

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE="${SKILL_ROOT}/templates/seo-outline.template.md"

TITLE="${1:-TITRE}"
DEST_ROOT="${2:-.}"
DOCS_DIR="${DEST_ROOT}/docs"

if [[ ! -f "${TEMPLATE}" ]]; then
  echo "ERREUR : template introuvable : ${TEMPLATE}" >&2
  exit 1
fi

mkdir -p "${DOCS_DIR}"

TARGET_FILE="${DOCS_DIR}/seo-outline.md"

if [[ -e "${TARGET_FILE}" ]]; then
  STAMP="$(date +%Y-%m-%d-%H%M%S)"
  TARGET_FILE="${DOCS_DIR}/seo-outline-${STAMP}.md"
  echo "==> seo-outline.md existe déjà — création d'un fichier daté : ${TARGET_FILE}"
fi

sed "s|{{TITRE}}|${TITLE}|g" "${TEMPLATE}" > "${TARGET_FILE}"

echo "==> Outline SEO créé : ${TARGET_FILE}"
echo
echo "Étapes suivantes :"
echo "  1. Renseigner le frontmatter (title, meta, slug, mots-clés)."
echo "  2. Détailler chaque H2 avec son idée principale et un exemple prévu."
echo "  3. Lister la FAQ prévue (3-8 questions)."
echo "  4. Documenter les liens internes (3-6) et le plan d'images."
echo "  5. Ouvrir docs/article-brief.md pour valider la cohérence."
