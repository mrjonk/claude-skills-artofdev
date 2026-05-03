# Exemple — Mini CMS sectoriel (PHP/SQLite)

## Prompt utilisateur

> *"Crée un repo pour un mini CMS de coiffeur. Stack PHP/SQLite, admin intégré, installateur web, exportable en ZIP."*

## Type détecté

`mini-cms`

## Ce que le skill doit produire

- arborescence alignée sur `CLAUDE_PROJECT_FACTORY.md` §20 (cf. `references/repo-structure-guide.md` §3) ;
- `INSTALL.md` et `EXPORT.md` en plus du `README.md` standard ;
- `manifest.json` à la racine ;
- `tools/export-zip.sh` ;
- placeholders pour les routes admin (`admin/login.php`, `admin/dashboard.php`, etc.) ;
- placeholder pour l'installateur (`install/index.php`) ;
- `.gitignore` strict : `*.sqlite`, `storage/logs/*`, `exports/*.zip`, `public/uploads/*` (sauf `.gitkeep`).

## Structure attendue

```txt
mini-cms-coiffeur/
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
│   ├── .htaccess
│   ├── assets/
│   └── uploads/.gitkeep
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

## `manifest.json` attendu

```json
{
  "name": "Coiffeur Mini CMS",
  "sector": "coiffeur",
  "version": "0.1.0",
  "stack": "PHP 8 + SQLite",
  "database": "sqlite",
  "installable_mode": true,
  "client_ready": false,
  "video_ready": true,
  "features": [
    "public_site",
    "admin",
    "installer",
    "media_manager",
    "contact_forms",
    "todo_list",
    "launch_checklist",
    "dashboard_stats",
    "export_zip"
  ],
  "requirements": {
    "php": ">=8.0",
    "extensions": ["pdo_sqlite", "gd"],
    "writable_paths": ["storage/", "public/uploads/"]
  },
  "install_url": "/install/"
}
```

## Points de contrôle qualité

- [ ] structure strictement alignée sur `CLAUDE_PROJECT_FACTORY.md` §20 ;
- [ ] `manifest.json` au format §24 du factory file ;
- [ ] aucun `*.sqlite` commité (uniquement `storage/.gitkeep`) ;
- [ ] aucun fichier dans `public/uploads/` (sauf `.gitkeep`) ;
- [ ] aucun fichier dans `exports/` (sauf `.gitkeep`) ;
- [ ] `INSTALL.md` documente les identifiants admin de dev (`admin@artofdev.local` / `ChangeMe123!`) avec mention claire *"À CHANGER après installation"* ;
- [ ] `EXPORT.md` documente la commande `bash tools/export-zip.sh` ;
- [ ] aucun mot de passe en dur dans le code PHP — uniquement dans la doc et au seed ;
- [ ] `check-repo-safety.sh` ne déclenche aucune alerte ;
- [ ] aucun chemin serveur (`/var/www/...`) dans le code livré.

## Commandes Git/GitHub préparées (non exécutées)

```bash
cd mini-cms-coiffeur
git init -b main
git add README.md INSTALL.md EXPORT.md CHANGELOG.md ROADMAP.md LICENSE \
        .gitignore manifest.json .env.example \
        public/ admin/ install/ app/ storage/ templates/ data/ tools/ exports/ docs/
git status
git commit -m "init: scaffolding mini-cms-coiffeur via repo-builder"

# À valider avant exécution :
gh repo create mini-cms-coiffeur --private --source=. --remote=origin
git push -u origin main
```

## Hypothèses faites

- secteur : coiffeur (défini dans le prompt).
- DB : SQLite (par défaut pour mini CMS).
- pas de Stripe (les coiffeurs font de la prise de RDV, pas de la vente en ligne — ajouter sur demande).
- mode vidéo Art of Dev actif → aucun chemin serveur, aucune IP, aucun nom Linux dans les fichiers.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
