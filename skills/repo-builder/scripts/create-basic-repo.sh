#!/usr/bin/env bash
# create-basic-repo.sh — Crée la structure générique d'un repo propre.
#
# Usage :
#   bash create-basic-repo.sh <slug> [<destination_dir>]
#
# Crée, dans <destination_dir>/<slug>/ :
#   README.md, CHANGELOG.md, ROADMAP.md, LICENSE (placeholder), .gitignore,
#   docs/architecture.md, docs/deployment.md, src/.gitkeep
#
# Ne fait JAMAIS :
#   - rm -rf
#   - git push
#   - npm install / composer install / pip install
#   - création de fichiers .env
#
# Created by João de Almeida — Art of Dev — https://artofdev.space

set -euo pipefail

SLUG="${1:-}"
DEST_DIR="${2:-.}"

if [[ -z "${SLUG}" ]]; then
  echo "Usage : bash create-basic-repo.sh <slug> [<destination_dir>]" >&2
  exit 1
fi

# Slug check : minuscules, chiffres, tirets, 1-50 chars.
if [[ ! "${SLUG}" =~ ^[a-z0-9][a-z0-9-]{0,49}$ ]]; then
  echo "ERREUR : slug invalide '${SLUG}'." >&2
  echo "Règles : minuscules, chiffres, tirets uniquement, 1 à 50 caractères, ne commence pas par un tiret." >&2
  exit 1
fi

REPO_DIR="${DEST_DIR%/}/${SLUG}"

if [[ -d "${REPO_DIR}" ]]; then
  echo "ERREUR : ${REPO_DIR} existe déjà. Aucune modification." >&2
  exit 1
fi

echo "==> Création de la structure générique : ${REPO_DIR}"
mkdir -p "${REPO_DIR}/docs" "${REPO_DIR}/src"
touch "${REPO_DIR}/src/.gitkeep"

# README.md minimal
cat > "${REPO_DIR}/README.md" <<EOF
# ${SLUG}

> Description courte du projet (à compléter).

Created by João de Almeida — Art of Dev — https://artofdev.space

## Installation

\`\`\`bash
git clone <url>
cd ${SLUG}
\`\`\`

## Structure

\`\`\`txt
${SLUG}/
├── README.md
├── CHANGELOG.md
├── ROADMAP.md
├── LICENSE
├── .gitignore
├── docs/
│   ├── architecture.md
│   └── deployment.md
└── src/
\`\`\`

## Licence

[MIT](LICENSE)
EOF

# CHANGELOG
cat > "${REPO_DIR}/CHANGELOG.md" <<EOF
# Changelog

## [Unreleased]

## [0.1.0] — $(date +%Y-%m-%d)

### Added
- Premier scaffolding via repo-builder (create-basic-repo.sh).
EOF

# ROADMAP
cat > "${REPO_DIR}/ROADMAP.md" <<EOF
# Roadmap

## MVP
- [ ] À compléter

## v1.0
- [ ] À compléter

## Idées futures
- À compléter
EOF

# LICENSE placeholder
cat > "${REPO_DIR}/LICENSE" <<EOF
MIT License

Copyright (c) $(date +%Y) <Auteur>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction. See README for details.
EOF

# .gitignore minimal
cat > "${REPO_DIR}/.gitignore" <<'EOF'
.env
.env.*
!.env.example
*.key
*.pem
*.token
*.secret
id_rsa*
id_ed25519*
node_modules/
vendor/
.venv/
__pycache__/
dist/
build/
*.log
.DS_Store
*.sqlite
*.sqlite3
*.sql
*.dump
*.zip
exports/
.vscode/
.idea/
EOF

# docs/
cat > "${REPO_DIR}/docs/architecture.md" <<EOF
# Architecture

## Vue générale
À compléter.

## Stack
À compléter.

## Modules
À compléter.

## Données
À compléter.

## Sécurité
À compléter.
EOF

cat > "${REPO_DIR}/docs/deployment.md" <<EOF
# Déploiement

## Prérequis
À compléter.

## Installation
À compléter.

## Variables d'environnement
À compléter.

## Démarrage
À compléter.
EOF

echo "==> Structure créée."
echo
echo "Fichiers générés :"
find "${REPO_DIR}" -maxdepth 3 -type f | sort | sed 's|^|  - |'
echo
echo "Prochaines étapes recommandées :"
echo "  1. cd ${REPO_DIR}"
echo "  2. compléter README.md, ROADMAP.md, docs/"
echo "  3. bash <ce-skill>/scripts/check-repo-safety.sh ."
echo "  4. git init -b main && git status"
