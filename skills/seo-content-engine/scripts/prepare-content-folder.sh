#!/usr/bin/env bash
# prepare-content-folder.sh — Prépare une structure de dossiers de contenu propre.
#
# Usage :
#   bash prepare-content-folder.sh [<destination-root>]
#
# Crée :
#   content/
#   ├── drafts/
#   ├── published/
#   ├── briefs/
#   ├── outlines/
#   ├── images/
#   └── sources/
#
# Comportement :
#   - mkdir -p (idempotent) — ne casse rien si la structure existe déjà.
#   - Crée un .gitkeep dans chaque sous-dossier vide.
#   - Crée un README.md dans content/ avec convention d'usage si absent.
#   - Aucune suppression.
#
# Created by João de Almeida

set -euo pipefail

DEST_ROOT="${1:-.}"
CONTENT_DIR="${DEST_ROOT}/content"

if [[ -t 1 ]]; then
  C_GRN='\033[0;32m'; C_YEL='\033[0;33m'; C_BLU='\033[0;34m'; C_END='\033[0m'
else
  C_GRN=''; C_YEL=''; C_BLU=''; C_END=''
fi

echo -e "${C_BLU}==> Préparation de la structure content/${C_END}"
echo "    Destination : ${DEST_ROOT}"
echo

SUBDIRS=("drafts" "published" "briefs" "outlines" "images" "sources")

for sub in "${SUBDIRS[@]}"; do
  dir="${CONTENT_DIR}/${sub}"
  if [[ -d "${dir}" ]]; then
    echo -e "  ${C_YEL}[déjà présent]${C_END} ${dir}"
  else
    mkdir -p "${dir}"
    echo -e "  ${C_GRN}[créé]${C_END}        ${dir}"
  fi

  # .gitkeep pour versionner les dossiers vides
  if [[ ! -e "${dir}/.gitkeep" ]]; then
    touch "${dir}/.gitkeep"
  fi
done

echo

# README de la structure content/ si absent
README="${CONTENT_DIR}/README.md"
if [[ ! -e "${README}" ]]; then
  cat > "${README}" <<'EOF'
# content/

Structure de travail éditorial pour le skill `seo-content-engine`.

## Sous-dossiers

| Dossier | Usage |
|---|---|
| `drafts/` | brouillons en cours de rédaction |
| `published/` | contenus finalisés (avant export vers le CMS) |
| `briefs/` | briefs éditoriaux (cf. `templates/article-brief.template.md`) |
| `outlines/` | plans SEO (cf. `templates/seo-outline.template.md`) |
| `images/` | images locales du contenu (sourcées, optimisées) |
| `sources/` | listes de sources par contenu (cf. `templates/source-list.template.md`) |

## Convention de nommage

- 1 article = 1 sous-dossier dans `drafts/` ou `published/`
- ex : `drafts/2026-05-comment-structurer-une-page-produit-saas/`
  - `article.md` (le brouillon)
  - `brief.md` (le brief éditorial)
  - `outline.md` (le plan SEO)
  - `images/` (les images de l'article)
  - `sources.md` (la liste des sources)

## Workflow

1. Créer le brief : `bash skills/seo-content-engine/scripts/create-article-brief.sh`
2. Créer le plan SEO : `bash skills/seo-content-engine/scripts/create-seo-outline.sh`
3. Rédiger dans `drafts/<slug>/article.md`
4. Auditer avec `scan-generic-content.sh` et `scan-repetitions.sh`
5. Calculer le score qualité éditoriale (cf. `templates/article.template.md`)
6. Déplacer vers `published/<slug>/` quand validé
7. Exporter vers le CMS

---

Created by João de Almeida
EOF
  echo -e "  ${C_GRN}[créé]${C_END}        ${README}"
else
  echo -e "  ${C_YEL}[déjà présent]${C_END} ${README}"
fi

echo
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
echo -e "${C_GRN}==> Structure content/ prête.${C_END}"
echo
echo "Structure :"
echo "  ${CONTENT_DIR}/"
echo "  ├── drafts/"
echo "  ├── published/"
echo "  ├── briefs/"
echo "  ├── outlines/"
echo "  ├── images/"
echo "  └── sources/"
echo
echo "Étapes suivantes :"
echo "  1. bash skills/seo-content-engine/scripts/create-article-brief.sh"
echo "  2. bash skills/seo-content-engine/scripts/create-seo-outline.sh"
echo "  3. Rédiger dans content/drafts/<slug>/"
echo -e "${C_BLU}─────────────────────────────────────${C_END}"
