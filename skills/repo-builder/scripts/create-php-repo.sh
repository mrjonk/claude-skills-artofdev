#!/usr/bin/env bash
# create-php-repo.sh — Crée la structure d'un repo PHP propre.
#
# Usage :
#   bash create-php-repo.sh <slug> [<destination_dir>]
#
# Structure adaptée à une app PHP générique (front + admin + config).
# Pour un mini CMS sectoriel complet, utiliser plutôt le skill mini-cms-builder
# (à venir, v0.3 — voir ROADMAP.md du repo claude-skills-artofdev).
#
# Created by João de Almeida — Art of Dev — https://artofdev.space

set -euo pipefail

SLUG="${1:-}"
DEST_DIR="${2:-.}"

if [[ -z "${SLUG}" ]]; then
  echo "Usage : bash create-php-repo.sh <slug> [<destination_dir>]" >&2
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

echo "==> Création de la structure PHP : ${REPO_DIR}"
mkdir -p "${REPO_DIR}"/{public/{assets/{css,js,img},uploads},src,config,docs,tests}
touch "${REPO_DIR}/public/uploads/.gitkeep" \
      "${REPO_DIR}/src/.gitkeep" \
      "${REPO_DIR}/config/.gitkeep" \
      "${REPO_DIR}/tests/.gitkeep"

# index.php minimal
cat > "${REPO_DIR}/public/index.php" <<'EOF'
<?php
declare(strict_types=1);

/**
 * Front controller minimal.
 * Ce fichier est un placeholder. À adapter selon le framework / routeur choisi.
 */

$projectName = 'À compléter';
echo "<h1>{$projectName}</h1><p>Front controller en place. Configurez votre routeur.</p>";
EOF

# .htaccess basique (route tout vers index.php, bloque .env et .git)
cat > "${REPO_DIR}/public/.htaccess" <<'EOF'
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^ index.php [L]

<FilesMatch "^\.env">
    Require all denied
</FilesMatch>

<FilesMatch "^\.git">
    Require all denied
</FilesMatch>
EOF

# .env.example
cat > "${REPO_DIR}/.env.example" <<'EOF'
# --- Application ---
APP_ENV=development
APP_DEBUG=true
APP_URL=http://localhost

# --- Base de données ---
DB_DRIVER=sqlite
DB_PATH=storage/database.sqlite
# DB_HOST=
# DB_PORT=
# DB_NAME=
# DB_USER=
# DB_PASS=

# --- Mailer (optionnel) ---
# SMTP_HOST=
# SMTP_PORT=587
# SMTP_USER=
# SMTP_PASS=
EOF

# composer.json minimal
cat > "${REPO_DIR}/composer.json" <<EOF
{
    "name": "artofdev/${SLUG}",
    "description": "À compléter",
    "type": "project",
    "license": "MIT",
    "require": {
        "php": ">=8.2"
    },
    "autoload": {
        "psr-4": {
            "App\\\\": "src/"
        }
    }
}
EOF

# .gitignore PHP
cat > "${REPO_DIR}/.gitignore" <<'EOF'
# secrets
.env
.env.*
!.env.example

# deps
vendor/

# storage
storage/database.sqlite
storage/database.sqlite-journal
storage/logs/*
!storage/logs/.gitkeep
storage/cache/*

# uploads
public/uploads/*
!public/uploads/.gitkeep

# logs / temp
*.log
.DS_Store

# IDE
.vscode/
.idea/
EOF

# README
cat > "${REPO_DIR}/README.md" <<EOF
# ${SLUG}

> App PHP (à compléter).

Created by João de Almeida — Art of Dev — https://artofdev.space

## Stack

- PHP 8.2+
- Composer (PSR-4 autoload, namespace \`App\\\\\`)
- (Base de données : à préciser — SQLite recommandé pour démarrer)

## Installation

\`\`\`bash
git clone <url>
cd ${SLUG}
composer install
cp .env.example .env
# Éditer .env
\`\`\`

## Démarrage local

\`\`\`bash
php -S localhost:8000 -t public
\`\`\`

## Structure

\`\`\`txt
${SLUG}/
├── public/
│   ├── index.php
│   ├── .htaccess
│   ├── assets/
│   └── uploads/
├── src/
├── config/
├── docs/
└── tests/
\`\`\`

## Licence

[MIT](LICENSE)
EOF

# CHANGELOG, ROADMAP, LICENSE, docs
cat > "${REPO_DIR}/CHANGELOG.md" <<EOF
# Changelog

## [0.1.0] — $(date +%Y-%m-%d)
### Added
- Premier scaffolding via repo-builder (create-php-repo.sh).
EOF

cat > "${REPO_DIR}/ROADMAP.md" <<'EOF'
# Roadmap

## MVP
- [ ] Routeur
- [ ] Connexion DB
- [ ] Page d'accueil
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
À compléter (Apache / Nginx + PHP-FPM).
EOF

echo "==> Structure créée."
echo
echo "Fichiers principaux :"
find "${REPO_DIR}" -maxdepth 3 -type f | sort | sed 's|^|  - |'
echo
echo "Prochaines étapes :"
echo "  1. cd ${REPO_DIR}"
echo "  2. composer install"
echo "  3. cp .env.example .env  (ne jamais commit er .env)"
echo "  4. php -S localhost:8000 -t public"
echo "  5. bash <ce-skill>/scripts/check-repo-safety.sh ."
