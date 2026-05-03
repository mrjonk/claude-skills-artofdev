#!/usr/bin/env bash
# uninstall.sh — Désinstalle un ou tous les Claude Skills d'Art of Dev.
#
# Usage :
#   bash uninstall.sh <skill-name>    # désinstalle UN skill (avec sauvegarde)
#   bash uninstall.sh --all           # désinstalle TOUS les skills (double confirmation)
#   bash uninstall.sh --list          # liste les skills installés
#   bash uninstall.sh --help          # aide
#
# Comportement :
#   - JAMAIS de suppression sans sauvegarde préalable.
#   - JAMAIS de suppression de tous les skills sans confirmation explicite.
#   - JAMAIS de modification de skills non ciblés.
#   - Variable env UNINSTALL_YES=1 saute les confirmations interactives.
#
# Created by João de Almeida — Art of Dev — https://artofdev.space

set -euo pipefail

SKILLS_HOME="${HOME}/.claude/skills"
BACKUP_ROOT="${SKILLS_HOME}/.backup"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

if [[ -t 1 ]]; then
  C_GRN='\033[0;32m'; C_YEL='\033[0;33m'; C_RED='\033[0;31m'; C_BLU='\033[0;34m'; C_END='\033[0m'
else
  C_GRN=''; C_YEL=''; C_RED=''; C_BLU=''; C_END=''
fi

usage() {
  cat <<EOF
Usage : bash uninstall.sh <commande>

Commandes :
  <skill-name>    Désinstalle un skill spécifique (avec sauvegarde datée).
                  Exemple : bash uninstall.sh production-auditor
  --all           Désinstalle TOUS les skills (double confirmation requise).
  --list          Liste les skills actuellement installés.
  --help          Affiche cette aide.

Sécurité :
  - Chaque désinstallation crée une sauvegarde dans ${BACKUP_ROOT}/<skill>-YYYYMMDD-HHMMSS/
  - Variable d'env UNINSTALL_YES=1 saute les confirmations.

Created by João de Almeida — Art of Dev — https://artofdev.space
EOF
}

list_installed() {
  if [[ ! -d "${SKILLS_HOME}" ]]; then
    echo "Aucun skill installé. ${SKILLS_HOME} n'existe pas."
    return 0
  fi
  echo "Skills installés dans ${SKILLS_HOME} :"
  local found=0
  for dir in "${SKILLS_HOME}"/*/; do
    [[ ! -d "${dir}" ]] && continue
    name="$(basename "${dir}")"
    [[ "${name}" == ".backup" ]] && continue
    [[ -f "${dir}/SKILL.md" ]] && {
      version="$(grep -E '^version:' "${dir}/SKILL.md" 2>/dev/null | head -1 | awk '{print $2}' || echo "?")"
      echo "  - ${name} (v${version})"
      found=1
    }
  done
  if [[ "${found}" -eq 0 ]]; then
    echo "  (aucun)"
  fi
}

uninstall_one() {
  local skill_name="$1"
  local skill_dir="${SKILLS_HOME}/${skill_name}"

  echo -e "${C_BLU}==> Désinstallation : ${skill_name}${C_END}"

  if [[ "${skill_name}" == ".backup" ]]; then
    echo -e "${C_RED}ERREUR :${C_END} '.backup' n'est pas un skill, c'est le dossier de sauvegardes." >&2
    return 1
  fi

  if [[ ! -d "${skill_dir}" ]]; then
    echo -e "${C_YEL}[skip]${C_END} ${skill_name} n'est pas installé."
    return 0
  fi

  # Confirmation
  if [[ "${UNINSTALL_YES:-0}" != "1" ]]; then
    read -r -p "Confirmer la désinstallation de '${skill_name}' ? (yes/no) " ANSWER
    if [[ "${ANSWER}" != "yes" ]]; then
      echo "Annulé."
      return 0
    fi
  fi

  # Sauvegarde puis retrait
  mkdir -p "${BACKUP_ROOT}"
  local backup_dir="${BACKUP_ROOT}/${skill_name}-${TIMESTAMP}"
  echo "  - sauvegarde → ${backup_dir}"
  mv "${skill_dir}" "${backup_dir}"

  echo -e "  - ${C_GRN}retiré${C_END} : ${skill_dir}"
  echo "  - copie conservée dans : ${backup_dir}"
}

uninstall_all() {
  echo -e "${C_BLU}==> Désinstallation de TOUS les skills${C_END}"

  if [[ ! -d "${SKILLS_HOME}" ]]; then
    echo "Aucun skill installé."
    return 0
  fi

  # Lister les skills
  local skills=()
  for dir in "${SKILLS_HOME}"/*/; do
    [[ ! -d "${dir}" ]] && continue
    name="$(basename "${dir}")"
    [[ "${name}" == ".backup" ]] && continue
    skills+=("${name}")
  done

  if [[ "${#skills[@]}" -eq 0 ]]; then
    echo "Aucun skill à désinstaller."
    return 0
  fi

  echo "Skills à désinstaller : ${skills[*]}"
  echo

  # Double confirmation
  if [[ "${UNINSTALL_YES:-0}" != "1" ]]; then
    echo -e "${C_RED}ATTENTION : cette action retire ${#skills[@]} skill(s).${C_END}"
    read -r -p "Premier OK (yes/no) ? " A1
    [[ "${A1}" != "yes" ]] && { echo "Annulé."; return 0; }
    read -r -p "Confirmation finale (oui/non) ? " A2
    [[ "${A2}" != "oui" ]] && { echo "Annulé."; return 0; }
  fi

  # Désinstallation effective
  for skill_name in "${skills[@]}"; do
    UNINSTALL_YES=1 uninstall_one "${skill_name}"
  done

  echo
  echo -e "${C_GRN}==> Tous les skills ont été désinstallés (sauvegardes dans ${BACKUP_ROOT}/).${C_END}"
}

# Dispatcher
case "${1:-}" in
  ""|"--help"|"-h")
    usage
    ;;
  "--list")
    list_installed
    ;;
  "--all")
    uninstall_all
    ;;
  *)
    # Argument = nom de skill
    skill="${1}"
    # Refuser tout ce qui ressemble à un flag inconnu
    if [[ "${skill}" == --* || "${skill}" == -* ]]; then
      echo -e "${C_RED}ERREUR :${C_END} option inconnue '${skill}'." >&2
      echo
      usage
      exit 2
    fi
    uninstall_one "${skill}"
    ;;
esac
