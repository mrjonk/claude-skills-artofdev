# Exemple — Script d'automatisation Python

## Prompt utilisateur

> *"Crée un repo pour un script d'automatisation : il télécharge des images Pixabay et les renomme par catégorie."*

## Type détecté

`python-script`

## Ce que le skill doit produire

- arborescence `python-script` (cf. `references/repo-structure-guide.md` §7) ;
- `requirements.txt` avec les deps minimales (`requests`) ;
- `requirements-dev.txt` avec `pytest` ;
- `.env.example` avec `PIXABAY_API_KEY=` ;
- `app/main.py` qui charge la clé via `os.getenv('PIXABAY_API_KEY')`, **jamais** en dur ;
- `README` qui explique la copie `.env.example` → `.env`.

## Structure attendue

```txt
pixabay-fetcher/
├── README.md
├── CHANGELOG.md
├── ROADMAP.md
├── LICENSE
├── .gitignore
├── .env.example
├── requirements.txt
├── requirements-dev.txt
├── app/
│   ├── __init__.py
│   ├── main.py
│   └── fetcher.py
├── tests/
│   └── test_fetcher.py
└── docs/
    └── usage.md
```

## `.env.example` attendu

```env
# --- Pixabay ---
PIXABAY_API_KEY=

# --- Options ---
DOWNLOAD_DIR=./downloads
DEFAULT_PER_PAGE=20
```

## `app/main.py` — pattern attendu

```python
"""Point d'entrée."""
from __future__ import annotations
import os
import sys
from app.fetcher import PixabayFetcher


def main() -> int:
    api_key = os.getenv("PIXABAY_API_KEY", "").strip()
    if not api_key:
        print("Erreur : PIXABAY_API_KEY non défini. Voir README.", file=sys.stderr)
        return 2

    fetcher = PixabayFetcher(api_key=api_key)
    # ... logique
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
```

## Points de contrôle qualité

- [ ] `PIXABAY_API_KEY` chargée via `os.getenv`, jamais en dur ;
- [ ] `.env.example` présent, `.env` absent ;
- [ ] `README` explique : *"copiez `.env.example` → `.env` et renseignez votre clé Pixabay (gratuite sur pixabay.com)"* ;
- [ ] `requirements.txt` minimal (idéalement juste `requests`) ;
- [ ] `requirements-dev.txt` avec `pytest` ;
- [ ] `app/__init__.py` présent (package Python valide) ;
- [ ] `tests/test_fetcher.py` présent (squelette de test) ;
- [ ] `.gitignore` exclut `.venv/`, `__pycache__/`, `downloads/` (le dossier de sortie) ;
- [ ] `check-repo-safety.sh` ne déclenche aucune alerte.

## Commandes Git/GitHub préparées (non exécutées)

```bash
cd pixabay-fetcher
git init -b main
git add README.md CHANGELOG.md ROADMAP.md LICENSE .gitignore \
        .env.example requirements.txt requirements-dev.txt \
        app/ tests/ docs/
git status
git commit -m "init: scaffolding pixabay-fetcher via repo-builder"

# À valider avant exécution :
gh repo create pixabay-fetcher --private --source=. --remote=origin
git push -u origin main
```

## Hypothèses faites

- Python 3.11+ (par défaut moderne).
- Lib HTTP : `requests` (la plus commune ; sur demande, basculer sur `httpx`).
- pas de framework CLI complexe (pas de `click`/`typer`) — `argparse` standard suffit pour un script.
- répertoire de sortie par défaut : `./downloads/`, configurable via `.env`.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
