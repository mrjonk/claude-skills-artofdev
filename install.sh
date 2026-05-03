#!/usr/bin/env bash
# install.sh — Installe TOUS les skills présents dans skills/ vers ~/.claude/skills/
#
# Comportement :
#   - Détecte le chemin du repo courant.
#   - Crée ~/.claude/skills/ si nécessaire.
#   - Itère sur skills/<nom>/ (chaque sous-dossier contenant un SKILL.md).
#   - Pour chaque skill :
#       - si déjà installé, sauvegarde dans ~/.claude/skills/.backup/<skill>-YYYYMMDD-HHMMSS/ ;
#       - copie skills/<skill>/ vers ~/.claude/skills/<skill>/ ;
#       - rend les scripts/ exécutables.
#   - Affiche un résumé clair.
#
# Usage :
#   bash install.sh                    # installe tous les skills
#   bash install.sh <skill-name>       # installe un seul skill
#
# Created by João de Almeida — Art of Dev — https://artofdev.space

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC_DIR="${REPO_DIR}/skills"
SKILLS_HOME="${HOME}/.claude/skills"
BACKUP_ROOT="${SKILLS_HOME}/.backup"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

if [[ -t 1 ]]; then
  C_GRN='\033[0;32m'; C_YEL='\033[0;33m'; C_BLU='\033[0;34m'; C_END='\033[0m'
else
  C_GRN=''; C_YEL=''; C_BLU=''; C_END=''
fi

echo -e "${C_BLU}==> Claude Skills — install${C_END}"
echo "    Repo source       : ${REPO_DIR}"
echo "    Destination       : ${SKILLS_HOME}"
echo

# 1. Vérifier la source.
if [[ ! -d "${SKILLS_SRC_DIR}" ]]; then
  echo "ERREUR : ${SKILLS_SRC_DIR} introuvable." >&2
  exit 1
fi

# 2. Créer le dossier global.
mkdir -p "${SKILLS_HOME}"

# 3. Lister les skills à installer (filtre éventuel par argument).
TARGET_SKILL="${1:-}"
SKILLS_TO_INSTALL=()

for dir in "${SKILLS_SRC_DIR}"/*/; do
  [[ ! -d "${dir}" ]] && continue
  skill_name="$(basename "${dir}")"

  # Filtre si argument
  if [[ -n "${TARGET_SKILL}" && "${TARGET_SKILL}" != "${skill_name}" ]]; then
    continue
  fi

  if [[ ! -f "${dir}/SKILL.md" ]]; then
    echo -e "${C_YEL}[skip]${C_END} ${skill_name} : pas de SKILL.md, ignoré."
    continue
  fi

  SKILLS_TO_INSTALL+=("${skill_name}")
done

if [[ "${#SKILLS_TO_INSTALL[@]}" -eq 0 ]]; then
  if [[ -n "${TARGET_SKILL}" ]]; then
    echo "ERREUR : skill '${TARGET_SKILL}' introuvable dans ${SKILLS_SRC_DIR}." >&2
  else
    echo "ERREUR : aucun skill à installer dans ${SKILLS_SRC_DIR}." >&2
  fi
  exit 1
fi

echo "Skills à installer : ${SKILLS_TO_INSTALL[*]}"
echo

# 4. Installer chaque skill.
INSTALLED=()
BACKED_UP=()

for skill_name in "${SKILLS_TO_INSTALL[@]}"; do
  src="${SKILLS_SRC_DIR}/${skill_name}"
  dest="${SKILLS_HOME}/${skill_name}"

  echo -e "${C_BLU}── ${skill_name} ──${C_END}"

  if [[ -d "${dest}" ]]; then
    mkdir -p "${BACKUP_ROOT}"
    backup_dir="${BACKUP_ROOT}/${skill_name}-${TIMESTAMP}"
    echo "  - skill existant détecté → sauvegarde : ${backup_dir}"
    mv "${dest}" "${backup_dir}"
    BACKED_UP+=("${skill_name}")
  fi

  cp -R "${src}" "${dest}"

  # Rendre les scripts/ exécutables s'il y en a
  if [[ -d "${dest}/scripts" ]]; then
    find "${dest}/scripts" -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
  fi

  echo -e "  - ${C_GRN}installé${C_END} : ${dest}"
  INSTALLED+=("${skill_name}")
done

echo
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo -e "${C_GRN}==> Installation terminée.${C_END}"
echo
echo "Skills installés : ${INSTALLED[*]}"
if [[ "${#BACKED_UP[@]}" -gt 0 ]]; then
  echo "Skills sauvegardés (anciennes versions) : ${BACKED_UP[*]}"
  echo "Sauvegardes dans : ${BACKUP_ROOT}/"
fi
echo
echo "Claude Code chargera automatiquement les skills selon le contexte de tes demandes."
echo
echo "Exemples :"
echo "  - \"Crée un repo propre pour un site statique.\"           → repo-builder"
echo "  - \"Audite ce projet avant mise en production.\"            → production-auditor"
echo
echo "Pour désinstaller :"
echo "  bash ${REPO_DIR}/uninstall.sh <skill-name>"
echo "  bash ${REPO_DIR}/uninstall.sh --all"
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
