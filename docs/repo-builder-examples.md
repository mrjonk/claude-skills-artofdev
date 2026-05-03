# Exemples d'utilisation de `repo-builder`

Ce document liste 5 cas d'usage concrets. Pour chaque cas : le prompt utilisateur, ce que le skill doit produire, la structure attendue, et les points de contrôle qualité.

> Les exemples détaillés se trouvent aussi dans [`../examples/`](../examples/).

---

## Cas 1 — Site statique de portfolio

**Prompt :**

> "Crée un repo propre pour un site statique de portfolio personnel, HTML/CSS/JS pur, sans framework."

**Type détecté :** static-site
**Structure attendue :**

```txt
portfolio-statique/
├── README.md
├── CHANGELOG.md
├── .gitignore
├── public/
│   ├── index.html
│   ├── assets/
│   │   ├── css/
│   │   ├── js/
│   │   └── img/
│   └── 404.html
└── docs/
    ├── architecture.md
    └── deployment.md
```

**Points de contrôle qualité :**

- pas de `node_modules/` ;
- `.gitignore` minimal (`.DS_Store`, `*.log`, `.env`) ;
- `README` mentionne *"site statique, déployable n'importe où"* ;
- `docs/deployment.md` couvre Netlify, GitHub Pages, et upload FTP/Apache.

---

## Cas 2 — App SaaS Node/Next

**Prompt :**

> "Initialise un repo Node/Next pour une app SaaS de gestion de tâches, avec auth, dashboard, paiements Stripe."

**Type détecté :** node-saas
**Structure attendue :**

```txt
saas-tasks/
├── README.md
├── CHANGELOG.md
├── ROADMAP.md
├── .gitignore             # node_modules, .env*, .next, build/
├── package.json           # minimal, sans installer
├── .env.example           # placeholders DATABASE_URL, STRIPE_*, NEXTAUTH_*
├── src/
│   ├── app/
│   ├── components/
│   ├── lib/
│   └── server/
├── prisma/                # schema vide
├── public/
└── docs/
    ├── architecture.md
    ├── deployment.md
    └── stripe-setup.md
```

**Points de contrôle qualité :**

- `.env.example` présent, `.env` absent ;
- placeholders Stripe : `STRIPE_PUBLIC_KEY=`, `STRIPE_SECRET_KEY=`, `STRIPE_WEBHOOK_SECRET=` ;
- `README` mentionne *"Stripe est préparé mais non configuré — voir docs/stripe-setup.md"* ;
- pas d'install npm exécuté pour ne pas figer un `package-lock` aléatoire.

---

## Cas 3 — Plugin WordPress

**Prompt :**

> "Prépare un repo plugin WordPress pour un widget de réservation pour coiffeurs."

**Type détecté :** wordpress-plugin
**Structure attendue :**

```txt
wp-coiffeur-booking/
├── README.md
├── readme.txt              # format wordpress.org
├── CHANGELOG.md
├── .gitignore
├── wp-coiffeur-booking.php # header plugin standard
├── includes/
├── admin/
├── public/
├── assets/
│   ├── css/
│   └── js/
├── languages/
└── docs/
    └── architecture.md
```

**Points de contrôle qualité :**

- header `Plugin Name`, `Description`, `Version`, `Author`, `License` complet dans le `.php` principal ;
- `readme.txt` au format `wordpress.org` (Tags, Stable tag, etc.) ;
- pas d'appels à des CDN tiers non documentés ;
- `docs/architecture.md` mentionne nonces, capabilities, sanitisation, échappement.

---

## Cas 4 — Mini CMS PHP/SQLite

**Prompt :**

> "Crée un repo pour un mini CMS de coiffeur. Stack PHP/SQLite, admin intégré, installateur web, exportable en ZIP."

**Type détecté :** mini-cms
**Structure attendue :** voir [`../skills/repo-builder/references/repo-structure-guide.md`](../skills/repo-builder/references/repo-structure-guide.md), section "Mini CMS sectoriel".

**Points de contrôle qualité :**

- aligné sur les règles de `CLAUDE_PROJECT_FACTORY.md` du VPS ;
- installateur `/install/` présent ;
- `manifest.json` à la racine ;
- aucun mot de passe en dur dans le code (uniquement `ChangeMe123!` documenté comme valeur de dev) ;
- `tools/export-zip.sh` exclut `.env`, `.git`, `node_modules`, `vendor`, dumps.

---

## Cas 5 — Script d'automatisation Python

**Prompt :**

> "Crée un repo pour un script d'automatisation : il télécharge des images Pixabay et les renomme par catégorie."

**Type détecté :** python-script
**Structure attendue :**

```txt
pixabay-fetch/
├── README.md
├── CHANGELOG.md
├── .gitignore             # .venv, __pycache__, .env
├── requirements.txt       # requests
├── .env.example           # PIXABAY_API_KEY=
├── app/
│   ├── __init__.py
│   ├── main.py
│   └── fetcher.py
├── tests/
└── docs/
    └── usage.md
```

**Points de contrôle qualité :**

- `PIXABAY_API_KEY` chargée via variable d'environnement, jamais dans le code ;
- `.env.example` présent ;
- `README` explique : *"placez votre clé API dans `.env`, copiez `.env.example` → `.env`"* ;
- `requirements.txt` minimal, sans dépendances superflues.

---

## Comment lire ces exemples

Chaque exemple suit la même grille :

1. **Prompt** — ce que l'utilisateur tape ;
2. **Type détecté** — la catégorie déduite par le skill ;
3. **Structure attendue** — l'arborescence produite ;
4. **Points de contrôle qualité** — ce que l'audit final doit vérifier.

Si tu inventes un nouveau cas, ajoute-le ici **et** dans `examples/` au format `example-<slug>.md`.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
