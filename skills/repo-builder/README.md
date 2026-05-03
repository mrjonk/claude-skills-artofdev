# `repo-builder` — README du skill

> Mode d'emploi du skill **`repo-builder`**.
> Pour la définition formelle (règles, étapes, checklists), voir [`SKILL.md`](SKILL.md).

Created by **João de Almeida** — Art of Dev — https://artofdev.space

---

## À quoi sert ce skill

`repo-builder` industrialise la création de repos Git/GitHub propres avec Claude Code.

Il garantit qu'à chaque création :

- la structure est cohérente d'un projet à l'autre ;
- la documentation minimale est là ;
- aucun secret n'est commité ;
- les commandes Git/GitHub sont préparées mais jamais exécutées sans accord.

---

## Quand l'utiliser

Active-le (en réalité, Claude l'active automatiquement) dès que tu demandes :

- *"crée un repo pour…"* ;
- *"initialise un repo…"* ;
- *"démarre un nouveau projet…"* ;
- *"prépare la base d'un site / app / plugin / script…"* ;
- *"setup a clean repo for…"* (anglais OK).

Et tous les types de projets listés dans [`SKILL.md` §4](SKILL.md#4-types-de-projets-supportés).

---

## Comment l'appeler dans Claude Code

**Tu n'as rien à taper de spécial.**

Le skill est chargé automatiquement par Claude Code quand le contenu de ta demande matche la `description:` du frontmatter de `SKILL.md`.

Si tu veux **forcer** la prise en compte (par exemple en mode debug), tu peux toujours préciser :

> *"Utilise le skill `repo-builder` pour cette demande."*

Mais ce n'est normalement pas nécessaire.

---

## Exemples de prompts

### Site statique simple

> *"Crée un repo propre pour un site statique de portfolio personnel, HTML/CSS/JS pur, sans framework."*

### App SaaS Node/Next

> *"Initialise un repo Node/Next pour une app SaaS de gestion de tâches, avec auth, dashboard, paiements Stripe. Privé sur GitHub."*

### Plugin WordPress

> *"Prépare un repo plugin WordPress pour un widget de réservation pour coiffeurs."*

### Mini CMS PHP/SQLite

> *"Crée un repo pour un mini CMS de coiffeur. Stack PHP/SQLite, admin intégré, installateur web, exportable en ZIP."*

### Script Python

> *"Crée un repo pour un script d'automatisation : il télécharge des images Pixabay et les renomme par catégorie."*

### Repo Claude Skill

> *"Démarre un repo `claude-skills-<slug>` pour publier un nouveau skill `<nom>`."*

D'autres exemples détaillés dans [`../../examples/`](../../examples/).

---

## Ce que le skill crée automatiquement

À chaque exécution :

- arborescence adaptée au type ;
- `README.md` clair et personnalisé ;
- `.gitignore` adapté à la stack ;
- `CHANGELOG.md` (Keep a Changelog) ;
- `ROADMAP.md` ;
- `LICENSE` (MIT par défaut) ;
- `docs/architecture.md`, `docs/deployment.md` ;
- `.env.example` si la stack a des secrets ;
- audit `check-repo-safety.sh` ;
- `git init` + premier commit prêt (non poussé) ;
- commandes `gh repo create` préparées (non exécutées) ;
- rapport final.

---

## Ce que le skill ne fait jamais sans accord explicite

- pousser vers GitHub (`git push`, `gh repo create --push`) ;
- créer un repo public si tu n'as pas dit "public" (par défaut **privé**) ;
- supprimer un fichier existant ;
- exécuter `npm install`, `composer install`, `pip install` ;
- modifier `~/.gitconfig`, `~/.ssh/`, ou tout fichier hors du repo cible ;
- commiter `.env`, tokens, clés API, dumps SQL, backups privés.

---

## Comment l'améliorer plus tard

Le skill est un dossier — modifie-le directement dans le repo `claude-skills-artofdev` :

1. ajuste `SKILL.md` (règles, étapes, checklist) ;
2. enrichis `references/` (nouvelles structures, conventions) ;
3. ajoute des templates dans `templates/` ;
4. ajoute des scripts dans `scripts/` ;
5. relance `bash install.sh` pour redéployer.

L'ancienne version est sauvegardée automatiquement dans `~/.claude/skills/.backup/repo-builder-YYYYMMDD-HHMMSS/`.

---

## Structure du skill

```txt
skills/repo-builder/
├── SKILL.md                 # règles formelles, lues par Claude
├── README.md                # ce fichier
├── references/              # docs que Claude consulte
│   ├── repo-structure-guide.md
│   ├── github-workflow.md
│   ├── naming-conventions.md
│   ├── documentation-template.md
│   └── security-checklist.md
├── templates/               # templates de docs prêts à remplir
│   ├── README.template.md
│   ├── ARCHITECTURE.template.md
│   ├── DEPLOYMENT.template.md
│   ├── ROADMAP.template.md
│   └── CHANGELOG.template.md
└── scripts/                 # scripts de scaffolding + audit
    ├── create-basic-repo.sh
    ├── create-node-repo.sh
    ├── create-php-repo.sh
    ├── create-python-repo.sh
    └── check-repo-safety.sh
```

---

Created by **João de Almeida** — Art of Dev
https://artofdev.space
