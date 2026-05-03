#!/usr/bin/env bash
# uninstall.sh — Retire le skill repo-builder de ~/.claude/skills/
#
# Comportement :
#   - Demande confirmation avant suppression.
#   - Sauvegarde le skill dans ~/.claude/skills/.backup/repo-builder-YYYYMMDD-HHMMSS/
#     avant de le retirer (rien n'est jamais supprimé sans copie de sécurité).
#   - Ne touche à AUCUN autre skill.
#   - Affiche un résumé clair.
#
# Created by João de Almeida — Art of Dev — https://artofdev.space

set -euo pipefail

SKILLS_HOME="${HOME}/.claude/skills"
SKILL_DEST="${SKILLS_HOME}/repo-builder"
BACKUP_ROOT="${SKILLS_HOME}/.backup"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

echo "==> Claude Skills — uninstall repo-builder"
echo "    Cible : ${SKILL_DEST}"
echo

if [[ ! -d "${SKILL_DEST}" ]]; then
  echo "Aucun skill repo-builder installé dans ${SKILLS_HOME}. Rien à faire."
  exit 0
fi

# Confirmation interactive (sauf si UNINSTALL_YES=1).
if [[ "${UNINSTALL_YES:-0}" != "1" ]]; then
  read -r -p "Confirmer la désinstallation ? (yes/no) " ANSWER
  if [[ "${ANSWER}" != "yes" ]]; then
    echo "Annulé. Aucune modification."
    exit 0
  fi
fi

# Sauvegarde avant suppression.
mkdir -p "${BACKUP_ROOT}"
BACKUP_DIR="${BACKUP_ROOT}/repo-builder-${TIMESTAMP}"
echo "==> Sauvegarde vers : ${BACKUP_DIR}"
mv "${SKILL_DEST}" "${BACKUP_DIR}"

echo "==> Désinstallation terminée."
echo
echo "Le skill repo-builder a été retiré de ${SKILLS_HOME}."
echo "Une copie est conservée ici : ${BACKUP_DIR}"
echo "Aucun autre skill n'a été touché."
