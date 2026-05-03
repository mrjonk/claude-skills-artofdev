#!/usr/bin/env bash
# install.sh — Installe le skill repo-builder dans ~/.claude/skills/
#
# Comportement :
#   - Détecte le chemin du repo courant.
#   - Crée ~/.claude/skills/ si nécessaire.
#   - Si un skill repo-builder existe déjà, le sauvegarde dans
#     ~/.claude/skills/.backup/repo-builder-YYYYMMDD-HHMMSS/ avant de l'écraser.
#   - Copie skills/repo-builder/ vers ~/.claude/skills/repo-builder/.
#   - Affiche un résumé clair.
#
# Created by João de Almeida — Art of Dev — https://artofdev.space

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SRC="${REPO_DIR}/skills/repo-builder"
SKILLS_HOME="${HOME}/.claude/skills"
SKILL_DEST="${SKILLS_HOME}/repo-builder"
BACKUP_ROOT="${SKILLS_HOME}/.backup"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

echo "==> Claude Skills — install repo-builder"
echo "    Repo source       : ${REPO_DIR}"
echo "    Destination       : ${SKILL_DEST}"
echo

# 1. Vérifier que la source existe.
if [[ ! -d "${SKILL_SRC}" ]]; then
  echo "ERREUR : ${SKILL_SRC} introuvable. Es-tu bien dans le repo claude-skills-artofdev ?" >&2
  exit 1
fi

if [[ ! -f "${SKILL_SRC}/SKILL.md" ]]; then
  echo "ERREUR : ${SKILL_SRC}/SKILL.md introuvable. Le skill semble incomplet." >&2
  exit 1
fi

# 2. Créer le dossier global des skills si besoin.
mkdir -p "${SKILLS_HOME}"

# 3. Sauvegarder l'ancien skill s'il existe.
if [[ -d "${SKILL_DEST}" ]]; then
  mkdir -p "${BACKUP_ROOT}"
  BACKUP_DIR="${BACKUP_ROOT}/repo-builder-${TIMESTAMP}"
  echo "==> Skill existant détecté."
  echo "    Sauvegarde vers : ${BACKUP_DIR}"
  mv "${SKILL_DEST}" "${BACKUP_DIR}"
fi

# 4. Copier le skill.
cp -R "${SKILL_SRC}" "${SKILL_DEST}"

# 5. Rendre les scripts exécutables.
if [[ -d "${SKILL_DEST}/scripts" ]]; then
  chmod +x "${SKILL_DEST}/scripts/"*.sh 2>/dev/null || true
fi

echo "==> Installation terminée."
echo
echo "Le skill repo-builder est maintenant disponible globalement."
echo "Claude Code le chargera automatiquement quand tu lui demandes de créer un repo."
echo
echo "Exemples de prompts qui déclenchent le skill :"
echo "  - \"Crée un repo propre pour un site statique de portfolio.\""
echo "  - \"Initialise un repo Node/Next pour une app SaaS.\""
echo "  - \"Prépare un repo Python/FastAPI.\""
echo
echo "Pour désinstaller : bash ${REPO_DIR}/uninstall.sh"
