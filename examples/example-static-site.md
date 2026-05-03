# Exemple — Site statique de portfolio

## Prompt utilisateur

> *"Crée un repo propre pour un site statique de portfolio personnel, HTML/CSS/JS pur, sans framework. Privé sur GitHub."*

## Type détecté

`static-site`

## Ce que le skill doit produire

- arborescence `static-site` (cf. `references/repo-structure-guide.md` §1) ;
- `README.md` qui mentionne explicitement *"site statique, déployable n'importe où"* ;
- `.gitignore` minimal : `.DS_Store`, `*.log`, `.env`, `node_modules/` (au cas où) ;
- `docs/deployment.md` couvrant Netlify, GitHub Pages, et upload FTP ;
- aucun `package.json`, aucun build-step.

## Structure attendue

```txt
portfolio-statique/
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
│       │   └── styles.css
│       ├── js/
│       │   └── main.js
│       └── img/
│           └── .gitkeep
└── docs/
    ├── architecture.md
    └── deployment.md
```

## Points de contrôle qualité

- [ ] `index.html` valide HTML5, avec `<meta name="viewport">` ;
- [ ] `404.html` présent ;
- [ ] `.gitignore` ne contient pas de motifs Node inutiles si l'utilisateur a précisé *"sans framework"* ;
- [ ] `README` explique : déploiement Netlify (drag & drop), GitHub Pages (branche `gh-pages`), ou upload FTP ;
- [ ] aucune dépendance npm / yarn / pnpm ;
- [ ] aucune mention de build-step ou de framework dans le `README` ;
- [ ] `docs/deployment.md` donne les 3 voies de déploiement avec commandes concrètes ;
- [ ] le repo passe `check-repo-safety.sh` sans alerte.

## Commandes Git/GitHub préparées (non exécutées)

```bash
cd portfolio-statique
git init -b main
git add README.md CHANGELOG.md ROADMAP.md LICENSE .gitignore public/ docs/
git status
git commit -m "init: scaffolding portfolio statique via repo-builder"

# À valider avant exécution :
gh repo create portfolio-statique --private --source=. --remote=origin
git push -u origin main
```

---

Created by João de Almeida — Art of Dev — https://artofdev.space
