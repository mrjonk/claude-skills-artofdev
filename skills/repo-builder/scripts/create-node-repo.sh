#!/usr/bin/env bash
# create-node-repo.sh — Crée la structure d'un repo Node/Next basique.
#
# Usage :
#   bash create-node-repo.sh <slug> [<destination_dir>]
#
# Crée la structure mais NE LANCE PAS npm install.
# C'est volontaire : on laisse l'utilisateur choisir son gestionnaire (npm/pnpm/yarn/bun)
# et la version exacte des deps.
#
# Created by João de Almeida — Art of Dev — https://artofdev.space

set -euo pipefail

SLUG="${1:-}"
DEST_DIR="${2:-.}"

if [[ -z "${SLUG}" ]]; then
  echo "Usage : bash create-node-repo.sh <slug> [<destination_dir>]" >&2
  exit 1
fi

if [[ ! "${SLUG}" =~ ^[a-z0-9][a-z0-9-]{0,49}$ ]]; then
  echo "ERREUR : slug invalide '${SLUG}'." >&2
  exit 1
fi

REPO_DIR="${DEST_DIR%/}/${SLUG}"

if [[ -d "${REPO_DIR}" ]]; then
  echo "ERREUR : ${REPO_DIR} existe déjà. Aucune modification." >&2
  exit 1
fi

echo "==> Création de la structure Node/Next : ${REPO_DIR}"
mkdir -p "${REPO_DIR}"/{src/{app,components,lib,server},public,docs,tests}
touch "${REPO_DIR}/src/app/.gitkeep" \
      "${REPO_DIR}/src/components/.gitkeep" \
      "${REPO_DIR}/src/lib/.gitkeep" \
      "${REPO_DIR}/src/server/.gitkeep" \
      "${REPO_DIR}/public/.gitkeep" \
      "${REPO_DIR}/tests/.gitkeep"

# package.json minimal — pas d'install auto
cat > "${REPO_DIR}/package.json" <<EOF
{
  "name": "${SLUG}",
  "version": "0.0.1",
  "private": true,
  "description": "À compléter",
  "scripts": {
    "dev": "echo 'configurer le runner ici (next dev / vite / etc.)'",
    "build": "echo 'configurer le build ici'",
    "start": "echo 'configurer le start ici'",
    "lint": "echo 'configurer eslint ici'",
    "test": "echo 'configurer les tests ici'"
  },
  "engines": {
    "node": ">=20"
  }
}
EOF

# .env.example
cat > "${REPO_DIR}/.env.example" <<'EOF'
# --- Application ---
NODE_ENV=development
PORT=3000

# --- Base de données ---
DATABASE_URL=

# --- Auth ---
NEXTAUTH_SECRET=
NEXTAUTH_URL=http://localhost:3000

# --- Stripe (mode test recommandé pour dev) ---
# STRIPE_PUBLIC_KEY=pk_test_REPLACE_ME
# STRIPE_SECRET_KEY=sk_test_REPLACE_ME
# STRIPE_WEBHOOK_SECRET=
EOF

# .gitignore Node
cat > "${REPO_DIR}/.gitignore" <<'EOF'
# secrets
.env
.env.*
!.env.example

# deps
node_modules/

# builds
dist/
build/
.next/
.nuxt/
.vercel/
out/
.turbo/
.cache/

# logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# tests
coverage/
.nyc_output/

# IDE
.DS_Store
.vscode/
.idea/

# misc
*.tsbuildinfo
EOF

# README
cat > "${REPO_DIR}/README.md" <<EOF
# ${SLUG}

> App Node/Next (à compléter).

Created by João de Almeida — Art of Dev — https://artofdev.space

## Stack

- Node 20+
- (Next.js / Vite / Nuxt selon choix — à préciser)
- (DB : à préciser)

## Installation

\`\`\`bash
git clone <url>
cd ${SLUG}

# Choisir un gestionnaire
npm install      # ou pnpm install / yarn / bun install

# Configurer
cp .env.example .env
# Éditer .env

# Lancer
npm run dev
\`\`\`

## Structure

\`\`\`txt
${SLUG}/
├── README.md
├── package.json
├── .env.example
├── .gitignore
├── src/
│   ├── app/
│   ├── components/
│   ├── lib/
│   └── server/
├── public/
├── tests/
└── docs/
\`\`\`

## Variables d'environnement

Voir [\`.env.example\`](.env.example).

## Licence

[MIT](LICENSE)
EOF

# CHANGELOG, ROADMAP, LICENSE, docs : minimal
cat > "${REPO_DIR}/CHANGELOG.md" <<EOF
# Changelog

## [0.1.0] — $(date +%Y-%m-%d)
### Added
- Premier scaffolding via repo-builder (create-node-repo.sh).
EOF

cat > "${REPO_DIR}/ROADMAP.md" <<'EOF'
# Roadmap

## MVP
- [ ] À compléter

## v1.0
- [ ] À compléter
EOF

cat > "${REPO_DIR}/LICENSE" <<EOF
MIT License — Copyright (c) $(date +%Y) <Auteur>
EOF

cat > "${REPO_DIR}/docs/architecture.md" <<'EOF'
# Architecture
À compléter.
EOF

cat > "${REPO_DIR}/docs/deployment.md" <<'EOF'
# Déploiement
À compléter (Vercel / VPS / Docker / autre).
EOF

echo "==> Structure créée."
echo
echo "Fichiers principaux :"
find "${REPO_DIR}" -maxdepth 2 -type f | sort | sed 's|^|  - |'
echo
echo "Prochaines étapes :"
echo "  1. cd ${REPO_DIR}"
echo "  2. choisir le framework (next/vite/etc.) et compléter package.json"
echo "  3. npm install (ou pnpm/yarn/bun)"
echo "  4. cp .env.example .env  (ne jamais commit er .env)"
echo "  5. bash <ce-skill>/scripts/check-repo-safety.sh ."
