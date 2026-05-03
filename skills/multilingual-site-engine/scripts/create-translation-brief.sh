#!/usr/bin/env bash
# create-translation-brief.sh — Crée un brief de traduction depuis le template.
#
# Usage :
#   bash create-translation-brief.sh [<dossier_destination>] [<nom_projet>]
#
# Comportement :
#   - COPIE le template `translation-brief.template.md` vers le dossier cible.
#   - Renomme avec la date du jour et le nom du projet.
#   - Ne supprime rien, ne modifie rien d'autre.
#   - Exit code 0 si succès, 2 sinon.
#
# Created by João de Almeida

set -euo pipefail

DEST="${1:-./docs}"
PROJECT="${2:-projet}"

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SKILL_DIR="$( dirname "${SCRIPT_DIR}" )"
TEMPLATE="${SKILL_DIR}/templates/translation-brief.template.md"

if [[ ! -f "${TEMPLATE}" ]]; then
  echo "ERREUR : template introuvable à ${TEMPLATE}" >&2
  exit 2
fi

if [[ -t 1 ]]; then
  C_BLU='\033[0;34m'; C_GRN='\033[0;32m'; C_END='\033[0m'
else
  C_BLU=''; C_GRN=''; C_END=''
fi

if [[ ! -d "${DEST}" ]]; then
  echo -e "${C_BLU}==> Création du dossier ${DEST}${C_END}"
  mkdir -p "${DEST}"
fi

DATE_STAMP="$(date +%Y-%m-%d)"
SAFE_PROJECT="$(echo "${PROJECT}" | tr ' /\\' '-' | tr '[:upper:]' '[:lower:]')"
OUTPUT="${DEST}/translation-brief-${SAFE_PROJECT}-${DATE_STAMP}.md"

if [[ -f "${OUTPUT}" ]]; then
  echo "ATTENTION : ${OUTPUT} existe déjà. Aucun fichier écrasé." >&2
  exit 2
fi

cp "${TEMPLATE}" "${OUTPUT}"

echo -e "${C_GRN}Brief de traduction créé :${C_END} ${OUTPUT}"
echo
echo "→ Ouvrir le fichier et remplir les placeholders {{...}}"
echo "→ Garder une copie validée avec le client avant traduction"

exit 0
