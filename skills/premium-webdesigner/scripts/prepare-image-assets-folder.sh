#!/usr/bin/env bash
# prepare-image-assets-folder.sh — Prépare une structure de dossiers d'images propre.
#
# Usage :
#   bash prepare-image-assets-folder.sh [<destination-root>]
#
# Comportement :
#   - Si public/ existe → crée public/assets/images/{hero,sections,placeholders}.
#   - Sinon → crée assets/images/{hero,sections,placeholders} à la racine.
#   - Crée docs/image-credits.md si absent.
#   - Ne SUPPRIME RIEN. Ne MODIFIE RIEN d'existant.
#   - Si la structure existe déjà, signale et continue sans écraser.
#
# Created by João de Almeida — Art of Dev — https://artofdev.space

set -euo pipefail

DEST_ROOT="${1:-.}"

if [[ -t 1 ]]; then
  C_GRN='\033[0;32m'; C_YEL='\033[0;33m'; C_BLU='\033[0;34m'; C_END='\033[0m'
else
  C_GRN=''; C_YEL=''; C_BLU=''; C_END=''
fi

echo -e "${C_BLU}==> Préparation de la structure d'images${C_END}"
echo "    Destination : ${DEST_ROOT}"
echo

# Choisir la base : public/ si existe, sinon racine.
if [[ -d "${DEST_ROOT}/public" ]]; then
  ASSETS_BASE="${DEST_ROOT}/public/assets/images"
  echo "  - public/ détecté → utilisation de public/assets/images/"
else
  ASSETS_BASE="${DEST_ROOT}/assets/images"
  echo "  - public/ absent → utilisation de assets/images/ à la racine"
fi
echo

# Créer la structure (mkdir -p est idempotent).
SUBDIRS=("hero" "sections" "placeholders")
for sub in "${SUBDIRS[@]}"; do
  dir="${ASSETS_BASE}/${sub}"
  if [[ -d "${dir}" ]]; then
    echo -e "  ${C_YEL}[déjà présent]${C_END} ${dir}"
  else
    mkdir -p "${dir}"
    echo -e "  ${C_GRN}[créé]${C_END}        ${dir}"
  fi

  # .gitkeep pour que les dossiers vides soient versionnés
  if [[ ! -e "${dir}/.gitkeep" ]]; then
    touch "${dir}/.gitkeep"
  fi
done

echo

# Créer un placeholder SVG par défaut si absent
PLACEHOLDER="${ASSETS_BASE}/placeholders/default-card.svg"
if [[ ! -e "${PLACEHOLDER}" ]]; then
  cat > "${PLACEHOLDER}" <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 600" width="1200" height="600" role="img" aria-label="Image placeholder">
  <defs>
    <linearGradient id="grad-placeholder" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="#1e293b"/>
      <stop offset="100%" stop-color="#334155"/>
    </linearGradient>
  </defs>
  <rect width="1200" height="600" fill="url(#grad-placeholder)"/>
  <text x="50%" y="50%" fill="#94a3b8" font-family="system-ui, sans-serif" font-size="14" text-anchor="middle" dominant-baseline="middle">
    Image à remplacer
  </text>
</svg>
EOF
  echo -e "  ${C_GRN}[créé]${C_END}        ${PLACEHOLDER}"
else
  echo -e "  ${C_YEL}[déjà présent]${C_END} ${PLACEHOLDER}"
fi

# Créer docs/image-credits.md
DOCS_DIR="${DEST_ROOT}/docs"
CREDITS_FILE="${DOCS_DIR}/image-credits.md"
mkdir -p "${DOCS_DIR}"

if [[ ! -e "${CREDITS_FILE}" ]]; then
  cat > "${CREDITS_FILE}" <<'EOF'
# Image credits

Liste des images utilisées dans le projet, avec source, auteur et licence.

> Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Hero

(Aucune image ajoutée pour le moment.)

## Sections

(Aucune image ajoutée pour le moment.)

## Format d'entrée recommandé

```markdown
- `<chemin du fichier>`
  - Source : (Unsplash / Pixabay / fournie / interne)
  - URL : <url d'origine si applicable>
  - Auteur / photographe : <nom + lien>
  - Licence : <Unsplash License / Pixabay Content License / propriété projet / autorisation écrite>
  - Crédit affiché : <oui/non + où>
```

---

Created by João de Almeida — Art of Dev — https://artofdev.space
EOF
  echo
  echo -e "  ${C_GRN}[créé]${C_END}        ${CREDITS_FILE}"
else
  echo
  echo -e "  ${C_YEL}[déjà présent]${C_END} ${CREDITS_FILE}"
fi

echo
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo -e "${C_GRN}==> Structure prête.${C_END}"
echo
echo "Structure :"
echo "  ${ASSETS_BASE}/"
echo "  ├── hero/"
echo "  ├── sections/"
echo "  └── placeholders/"
echo "      └── default-card.svg"
echo
echo "  ${DOCS_DIR}/image-credits.md"
echo
echo "Étapes suivantes :"
echo "  1. Sourcer les images (Pixabay / Unsplash / interne)."
echo "  2. Optimiser (WebP qualité 85, dimensions adaptées)."
echo "  3. Documenter chaque image dans image-credits.md."
echo "  4. Remplir templates/image-selection.template.md pour le suivi."
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
