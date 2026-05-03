# Claude Skills — Art of Dev

Une collection de **Claude Skills** maison pour industrialiser la création de projets propres avec Claude Code.

> Premier skill publié : **`repo-builder`** — créer en une commande des repositories GitHub propres, structurés, documentés, prêts pour le développement.

Created by **João de Almeida** — Art of Dev
https://artofdev.space

---

## C'est quoi un Claude Skill ?

Un **Claude Skill** est un dossier de règles + références + templates + scripts que Claude Code charge automatiquement quand le contexte d'une conversation correspond à sa description.

Concrètement, un skill répond à trois questions :

1. **Quand l'activer ?** — décrit dans le `description:` du frontmatter de `SKILL.md`.
2. **Que faire ?** — instructions étape par étape pour Claude.
3. **Avec quoi ?** — références à lire, templates à utiliser, scripts à exécuter.

Un skill, ce n'est pas une simple consigne envoyée dans un prompt. C'est un **paquet de comportement réutilisable**, versionné, partageable, qu'on installe dans `~/.claude/skills/` ou dans `.claude/skills/` à la racine d'un projet.

---

## Le skill `repo-builder`

### Le problème

Claude Code peut générer du code utile en quelques secondes. Mais sans cadre, on se retrouve avec :

- des dossiers brouillons sans `README` ;
- pas de `.gitignore` adapté → `node_modules/`, `.env`, dumps SQL commités par accident ;
- structure incohérente d'un projet à l'autre ;
- pas de roadmap, pas de docs, pas de `CHANGELOG` ;
- secrets hardcodés ou tokens dans le repo ;
- noms de repos flous (`my-project`, `test`, `app-final-v2`).

### La solution

Le skill **`repo-builder`** force un standard : à chaque création de repo, Claude applique les mêmes règles de structure, documentation, sécurité et conventions Git.

### Ce que le skill fait

- analyse le type de projet demandé (statique, SaaS, mini CMS, plugin WP, app PHP/Node/Python, script, doc, skill Claude…) ;
- crée une structure adaptée au type de projet ;
- génère un `README.md` clair et professionnel ;
- ajoute un `.gitignore` adapté à la stack ;
- ajoute `docs/`, `CHANGELOG.md`, `ROADMAP.md`, templates de documentation ;
- vérifie l'absence de secrets avant tout commit ;
- prépare les commandes Git/GitHub CLI (sans pousser sans accord) ;
- produit un rapport final clair des fichiers créés.

### Ce que le skill ne fera jamais sans accord explicite

- supprimer des fichiers existants ;
- pousser vers GitHub ;
- créer un repo public au lieu de privé (ou inversement) ;
- commiter `.env`, tokens, clés SSH, dumps SQL ou backups privés.

---

## Structure du repo

```txt
claude-skills-artofdev/
├── README.md                # ce fichier
├── CHANGELOG.md             # historique des versions du repo
├── LICENSE                  # MIT
├── .gitignore
├── install.sh               # installe le skill dans ~/.claude/skills/repo-builder
├── uninstall.sh             # retire le skill avec sauvegarde datée
├── docs/                    # documentation publique du projet
│   ├── article-section.md   # section prête pour l'article jonk.space / Art of Dev
│   ├── how-to-use.md
│   ├── repo-builder-examples.md
│   ├── security-rules.md
│   └── roadmap.md
├── skills/
│   └── repo-builder/
│       ├── SKILL.md         # cœur du skill, lu par Claude
│       ├── README.md        # mode d'emploi du skill
│       ├── references/      # documents que Claude consulte
│       ├── templates/       # templates de README, ARCHITECTURE, etc.
│       └── scripts/         # scripts shell (création + audit sécurité)
└── examples/                # 5 exemples de prompts + résultats attendus
```

---

## Installation

### Prérequis

- Claude Code installé (CLI ou extension VS Code).
- `bash` disponible.
- Optionnel mais recommandé : `git` et `gh` (GitHub CLI) configurés.

### Étapes

```bash
git clone git@github.com:mrjonk/claude-skills-artofdev.git
cd claude-skills-artofdev
bash install.sh
```

`install.sh` :

- détecte le chemin du repo ;
- crée `~/.claude/skills/` si nécessaire ;
- installe ou met à jour `repo-builder` ;
- **sauvegarde** un éventuel skill `repo-builder` existant dans `~/.claude/skills/.backup/repo-builder-YYYYMMDD-HHMMSS/` avant de l'écraser ;
- affiche les instructions d'utilisation.

Pour désinstaller :

```bash
bash uninstall.sh
```

---

## Utilisation

Dans n'importe quelle conversation Claude Code, le skill s'active dès que tu demandes la création d'un repo. Exemples de prompts qui déclenchent le skill :

- *"Crée un repo propre pour un site statique de portfolio."*
- *"Initialise un repo Node/Next pour une app SaaS de gestion de tâches."*
- *"Prépare un repo plugin WordPress pour un widget de réservation."*
- *"Crée un repo Python/FastAPI pour une API d'envoi d'emails."*
- *"Démarre un repo pour un mini CMS de coiffeur."*

Claude applique alors les règles de `SKILL.md`, choisit la bonne structure, génère les fichiers, et te donne un rapport final.

Voir [`examples/`](examples/) pour 5 cas concrets.

---

## Sécurité

Le skill applique systématiquement la checklist `skills/repo-builder/references/security-checklist.md` avant tout commit.

Règles non négociables :

- jamais de `.env` réel commité — uniquement un `.env.example` ;
- jamais de token GitHub, clé API, mot de passe, identifiant SMTP ;
- jamais de clé SSH privée (`id_rsa`, `id_ed25519`, `*.pem`) ;
- jamais de dump SQL contenant des données client ;
- jamais de fichier de backup privé ;
- pas de `node_modules/`, `vendor/`, `.venv/`, fichiers temporaires ;
- pas de chemins serveur sensibles, pas d'IP locales du VPS dans le code livré.

Le script `skills/repo-builder/scripts/check-repo-safety.sh` scanne le repo et alerte (sans rien supprimer).

Voir [`docs/security-rules.md`](docs/security-rules.md) pour le détail.

---

## Roadmap

- **v0.1** — `repo-builder` : structure de base, 5 stacks supportées, install/uninstall.
- **v0.2** — détection automatique de la stack à partir d'une description en langage naturel.
- **v0.3** — second skill : `mini-cms-builder` (générateur de mini CMS sectoriels PHP/SQLite).
- **v0.4** — troisième skill : `video-prep` (préparation d'un repo en mode screen-recording propre).
- **v1.0** — collection stable, publiée sur Art of Dev avec article + vidéo YouTube.

Voir [`docs/roadmap.md`](docs/roadmap.md).

---

## Licence

[MIT](LICENSE) — utilisation libre, attribution appréciée.

---

## Note éditoriale

Ce repo accompagne un article publié sur **jonk.space / Art of Dev** dans la série *"Industrialiser son workflow avec l'IA"*. L'objectif : montrer comment un créateur indépendant peut transformer Claude Code en chaîne de production reproductible, sans renoncer à la qualité.

L'article correspondant se trouve dans [`docs/article-section.md`](docs/article-section.md) — sous une forme prête à coller.

Created by **João de Almeida** — Art of Dev
https://artofdev.space
