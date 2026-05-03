# Guide des structures de repo

Ce document liste les structures recommandées pour chaque type de projet supporté par `repo-builder`.
Claude doit choisir une structure **adaptée**, pas appliquer aveuglément le même squelette.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. Site statique (`static-site`)

```txt
<slug>/
├── README.md
├── CHANGELOG.md
├── ROADMAP.md
├── LICENSE
├── .gitignore
├── public/
│   ├── index.html
│   ├── 404.html
│   └── assets/
│       ├── css/
│       ├── js/
│       └── img/
└── docs/
    ├── architecture.md
    └── deployment.md
```

Notes :
- `.gitignore` minimal (`.DS_Store`, `*.log`, `.env`).
- `docs/deployment.md` couvre Netlify, GitHub Pages, FTP/Apache/Nginx.
- Aucune dépendance node par défaut.

---

## 2. App SaaS Node/Next (`node-saas`)

```txt
<slug>/
├── README.md
├── CHANGELOG.md
├── ROADMAP.md
├── LICENSE
├── .gitignore             # node_modules, .env*, .next, build/, coverage/
├── .env.example           # placeholders DATABASE_URL, NEXTAUTH_*, STRIPE_*
├── package.json           # minimal — pas d'install auto
├── next.config.js         # ou astro/nuxt selon stack
├── tsconfig.json          # si TypeScript
├── src/
│   ├── app/
│   ├── components/
│   ├── lib/
│   └── server/
├── prisma/
│   └── schema.prisma      # vide à compléter
├── public/
└── docs/
    ├── architecture.md
    ├── deployment.md
    └── stripe-setup.md    # uniquement si Stripe demandé
```

Notes :
- **Ne pas exécuter** `npm install` — laisser l'utilisateur choisir son gestionnaire.
- `package.json` : `name`, `version: 0.0.1`, `private: true`, `scripts` minimaux.
- `.env.example` lister **tous** les secrets attendus, sans valeur.

---

## 3. Mini CMS sectoriel (`mini-cms`)

Structure alignée sur `CLAUDE_PROJECT_FACTORY.md` du VPS Art of Dev (§20).

```txt
<slug>/
├── README.md
├── INSTALL.md
├── EXPORT.md
├── CHANGELOG.md
├── ROADMAP.md
├── LICENSE
├── .gitignore
├── manifest.json
├── .env.example
├── public/
│   ├── index.php
│   ├── assets/
│   ├── uploads/.gitkeep
│   └── .htaccess
├── admin/
│   ├── login.php
│   ├── dashboard.php
│   ├── settings.php
│   ├── content.php
│   ├── media.php
│   ├── todos.php
│   ├── stats.php
│   └── logout.php
├── install/
│   ├── index.php
│   ├── check.php
│   ├── database.php
│   ├── admin.php
│   └── finish.php
├── app/
│   ├── config/
│   ├── core/
│   ├── models/
│   ├── services/
│   └── helpers/
├── storage/
│   ├── .gitkeep
│   ├── logs/.gitkeep
│   └── backups/.gitkeep
├── templates/
├── data/
├── tools/
│   └── export-zip.sh
├── exports/.gitkeep
└── docs/
    ├── architecture.md
    └── deployment.md
```

Notes :
- `.gitignore` doit exclure `*.sqlite`, `storage/logs/*`, `storage/backups/*`, `exports/*.zip`, `public/uploads/*` (sauf `.gitkeep`).
- `manifest.json` aligné sur §24 du factory file.
- Identifiants admin de dev : `admin@artofdev.local` / `ChangeMe123!` documentés dans `INSTALL.md`, **jamais** dans le code.

---

## 4. Plugin WordPress (`wordpress-plugin`)

```txt
<slug>/
├── README.md
├── readme.txt              # format wordpress.org
├── CHANGELOG.md
├── ROADMAP.md
├── LICENSE                 # GPL-2.0-or-later si publication wordpress.org
├── .gitignore
├── <slug>.php              # header plugin standard
├── uninstall.php
├── includes/
│   ├── class-<slug>.php
│   ├── class-<slug>-loader.php
│   └── class-<slug>-i18n.php
├── admin/
│   ├── class-<slug>-admin.php
│   ├── css/
│   ├── js/
│   └── partials/
├── public/
│   ├── class-<slug>-public.php
│   ├── css/
│   ├── js/
│   └── partials/
├── languages/
│   └── <slug>.pot
└── docs/
    └── architecture.md
```

Notes :
- Header de `<slug>.php` : `Plugin Name`, `Plugin URI`, `Description`, `Version`, `Author`, `License`, `Text Domain`.
- License par défaut : **GPL-2.0-or-later** (compatible wordpress.org).
- `uninstall.php` propre obligatoire.

---

## 5. App PHP générique (`php-app`)

```txt
<slug>/
├── README.md
├── CHANGELOG.md
├── ROADMAP.md
├── LICENSE
├── .gitignore             # vendor/, .env, *.log
├── .env.example
├── composer.json          # minimal si Composer utilisé
├── public/
│   └── index.php
├── src/
├── config/
├── tests/
└── docs/
    ├── architecture.md
    └── deployment.md
```

---

## 6. App Python / FastAPI (`python-fastapi`)

```txt
<slug>/
├── README.md
├── CHANGELOG.md
├── ROADMAP.md
├── LICENSE
├── .gitignore             # .venv, __pycache__, *.pyc
├── .env.example
├── pyproject.toml         # ou requirements.txt si simple
├── app/
│   ├── __init__.py
│   ├── main.py            # FastAPI app
│   ├── routes/
│   ├── models/
│   └── services/
├── tests/
│   └── test_main.py
└── docs/
    ├── architecture.md
    └── deployment.md
```

Notes :
- `app/main.py` doit déjà avoir un endpoint `GET /healthz` minimal.
- `pyproject.toml` ou `requirements.txt` : choisir selon préférence utilisateur, par défaut `requirements.txt` pour rester simple.

---

## 7. Script Python (`python-script`)

```txt
<slug>/
├── README.md
├── CHANGELOG.md
├── LICENSE
├── .gitignore
├── .env.example           # uniquement si secrets
├── requirements.txt
├── app/
│   ├── __init__.py
│   ├── main.py
│   └── <module>.py
├── tests/
└── docs/
    └── usage.md
```

---

## 8. Script Bash (`bash-script`)

```txt
<slug>/
├── README.md
├── CHANGELOG.md
├── LICENSE
├── .gitignore
├── <slug>.sh
├── lib/
└── docs/
    └── usage.md
```

Notes :
- Tous les scripts en `set -euo pipefail`.
- `chmod +x` à la création.

---

## 9. Documentation seule (`docs-only`)

```txt
<slug>/
├── README.md
├── LICENSE
├── .gitignore
├── docs/
│   ├── index.md
│   ├── chapter-01.md
│   ├── chapter-02.md
│   └── assets/
└── mkdocs.yml             # si MkDocs choisi
```

---

## 10. Repo Claude Skill (`claude-skill`)

```txt
<slug>/
├── README.md
├── CHANGELOG.md
├── LICENSE
├── .gitignore
├── install.sh
├── uninstall.sh
├── docs/
└── skills/
    └── <skill-name>/
        ├── SKILL.md
        ├── README.md
        ├── references/
        ├── templates/
        └── scripts/
```

Notes :
- Strictement aligné sur la structure de **ce repo** (`claude-skills-artofdev`).
- `SKILL.md` doit avoir un frontmatter `name:` + `description:` clair.

---

## Choix de la structure

```txt
Demande utilisateur
       │
       ▼
[Type clair ?] ── non ──> demander à l'utilisateur, ou hypothèse + note
       │ oui
       ▼
Choisir la section ci-dessus
       │
       ▼
mkdir -p l'arborescence
       │
       ▼
Remplir avec templates/ + adaptation
```

Si le projet est **mixte** (par exemple SaaS PHP + front Vue.js), on combine deux structures avec une racine commune et deux sous-dossiers (`api/` et `web/`).

---

Created by João de Almeida — Art of Dev — https://artofdev.space
