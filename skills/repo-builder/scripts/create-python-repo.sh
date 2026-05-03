#!/usr/bin/env bash
# create-python-repo.sh — Crée la structure d'un repo Python propre.
#
# Usage :
#   bash create-python-repo.sh <slug> [<destination_dir>]
#
# Structure adaptée à un script ou une petite app Python.
# Pour FastAPI ou Django, étendre la structure manuellement après scaffolding.
#
# Created by João de Almeida — Art of Dev — https://artofdev.space

set -euo pipefail

SLUG="${1:-}"
DEST_DIR="${2:-.}"

if [[ -z "${SLUG}" ]]; then
  echo "Usage : bash create-python-repo.sh <slug> [<destination_dir>]" >&2
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

# Slug → module Python (remplacer - par _)
PKG_NAME="${SLUG//-/_}"

echo "==> Création de la structure Python : ${REPO_DIR}"
mkdir -p "${REPO_DIR}/app" "${REPO_DIR}/tests" "${REPO_DIR}/docs"

# app/__init__.py
cat > "${REPO_DIR}/app/__init__.py" <<EOF
"""Package ${PKG_NAME}."""
__version__ = "0.1.0"
EOF

# app/main.py
cat > "${REPO_DIR}/app/main.py" <<EOF
"""Point d'entrée de l'application."""
from __future__ import annotations


def main() -> int:
    """Entry point."""
    print("${SLUG} — placeholder. À compléter.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
EOF

# tests/test_main.py
cat > "${REPO_DIR}/tests/test_main.py" <<'EOF'
"""Tests basiques."""
from app.main import main


def test_main_returns_zero() -> None:
    assert main() == 0
EOF

# requirements.txt minimal
cat > "${REPO_DIR}/requirements.txt" <<'EOF'
# Dépendances runtime — à compléter selon le projet.
# Exemple :
# requests==2.32.3
EOF

# requirements-dev.txt
cat > "${REPO_DIR}/requirements-dev.txt" <<'EOF'
# Outils de dev
pytest>=8.0
EOF

# .env.example
cat > "${REPO_DIR}/.env.example" <<'EOF'
# Exemples — adapter selon le projet
# PIXABAY_API_KEY=
# DATABASE_URL=
EOF

# .gitignore Python
cat > "${REPO_DIR}/.gitignore" <<'EOF'
# secrets
.env
.env.*
!.env.example

# venv
.venv/
venv/
env/

# bytecode
__pycache__/
*.py[cod]
*$py.class

# tests / coverage
.pytest_cache/
.coverage
htmlcov/
.tox/

# packaging
build/
dist/
*.egg-info/

# IDE
.vscode/
.idea/
.DS_Store

# logs
*.log
EOF

# README
cat > "${REPO_DIR}/README.md" <<EOF
# ${SLUG}

> Script Python (à compléter).

Created by João de Almeida — Art of Dev — https://artofdev.space

## Stack

- Python 3.11+

## Installation

\`\`\`bash
git clone <url>
cd ${SLUG}

python3 -m venv .venv
source .venv/bin/activate

pip install -r requirements.txt
pip install -r requirements-dev.txt

cp .env.example .env
# Éditer .env
\`\`\`

## Démarrage

\`\`\`bash
python -m app.main
\`\`\`

## Tests

\`\`\`bash
pytest
\`\`\`

## Structure

\`\`\`txt
${SLUG}/
├── README.md
├── requirements.txt
├── requirements-dev.txt
├── .env.example
├── app/
│   ├── __init__.py
│   └── main.py
├── tests/
│   └── test_main.py
└── docs/
\`\`\`

## Licence

[MIT](LICENSE)
EOF

# CHANGELOG, ROADMAP, LICENSE, docs
cat > "${REPO_DIR}/CHANGELOG.md" <<EOF
# Changelog

## [0.1.0] — $(date +%Y-%m-%d)
### Added
- Premier scaffolding via repo-builder (create-python-repo.sh).
EOF

cat > "${REPO_DIR}/ROADMAP.md" <<'EOF'
# Roadmap

## MVP
- [ ] Implémenter app/main.py
- [ ] Premiers tests
EOF

cat > "${REPO_DIR}/LICENSE" <<EOF
MIT License — Copyright (c) $(date +%Y) <Auteur>
EOF

cat > "${REPO_DIR}/docs/architecture.md" <<'EOF'
# Architecture
À compléter.
EOF

cat > "${REPO_DIR}/docs/usage.md" <<'EOF'
# Usage
À compléter : exemples de commandes.
EOF

echo "==> Structure créée."
echo
echo "Fichiers principaux :"
find "${REPO_DIR}" -maxdepth 2 -type f | sort | sed 's|^|  - |'
echo
echo "Prochaines étapes :"
echo "  1. cd ${REPO_DIR}"
echo "  2. python3 -m venv .venv && source .venv/bin/activate"
echo "  3. pip install -r requirements-dev.txt"
echo "  4. pytest  (vérifie que le scaffolding tourne)"
echo "  5. bash <ce-skill>/scripts/check-repo-safety.sh ."
