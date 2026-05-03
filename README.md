# Claude Skills — Art of Dev

Une collection de **Claude Skills** maison pour industrialiser la création de projets propres avec Claude Code.

Skills publiés :

| Skill | Rôle |
|---|---|
| [`repo-builder`](skills/repo-builder/) | Créer un repo GitHub propre, structuré, documenté, en une commande |
| [`production-auditor`](skills/production-auditor/) | Auditer un projet avant mise en production : score 7-axes, plan de correction, corrections sûres |
| [`premium-webdesigner`](skills/premium-webdesigner/) | Empêcher les designs IA basiques : méthode 6-phases (brief → 21st.dev/shadcn → composants → direction artistique → images → exécution alignée stack) |

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

## Le skill `production-auditor`

### Le problème

Un projet généré rapidement avec Claude finit toujours par avoir des trous : balises `<title>` manquantes, `console.log` oubliés, webhooks Stripe non signés, `.env` commit é par accident, page 500 qui expose la stack-trace, mots de passe par défaut non changés, footer pauvre, design template-look.

Aucun de ces points n'est dramatique seul. Cumulés, ils transforment un projet "qui marche" en projet **publiable seulement avec des excuses**.

### La solution

Le skill **`production-auditor`** force une méthode d'audit **en 10 phases** :

1. lecture projet → 2. cartographie → 3. UX/UI → 4. technique → 5. sécurité → 6. SEO/contenu → 7. admin/billing → 8. scoring → 9. rapport → 10. corrections sûres.

### Ce que le skill produit

- un **score** sur 100 + 7 sous-scores (Technique 20 / UX 15 / Sécurité 25 / SEO 10 / Admin 15 / Billing 10 / Déploiement 5) ;
- une **liste classée** des problèmes : `CRIT-NNN` (bloquants), `IMP-NNN` (importants), `MIN-NNN` (mineurs) ;
- un **plan d'action** en 6 phases ;
- un **rapport** dans `reports/audit-YYYY-MM-DD.md` ;
- les **corrections sûres** appliquées automatiquement (typos, balises manquantes, `console.log` oubliés, etc.).

### Verdict global

| Score | Statut |
|---|---|
| 0–20 | Non publiable |
| 21–40 | Très fragile |
| 41–60 | Prototype acceptable, pas production |
| 61–75 | Publiable avec corrections |
| 76–90 | Solide. Lancement possible. |
| 91–100 | Prêt production premium |

### Mode `VIDEO_PRESENTATION_MODE`

Pour un projet préparé en vue d'une vidéo YouTube / screen-recording, le skill active un mode strict qui vérifie en plus qu'aucun secret, chemin serveur, IP, ou nom d'utilisateur Linux n'apparaisse à l'écran.

### Ce que le skill ne fait jamais sans accord explicite

- pousser vers GitHub ;
- supprimer un fichier (même `.bak`/`.tmp`) ;
- afficher le contenu d'un `.env` ou d'un secret ;
- modifier des credentials, mots de passe, tokens ;
- faire un refactor d'architecture ;
- changer le pricing, les routes existantes, la stack ;
- lancer `npm install` / `composer install` / `pip install`.

Voir [`docs/production-auditor-how-to-use.md`](docs/production-auditor-how-to-use.md), [`docs/production-auditor-examples.md`](docs/production-auditor-examples.md), et [`docs/article-section-production-auditor.md`](docs/article-section-production-auditor.md).

---

## Le skill `premium-webdesigner`

### Le problème

Quand on demande à une IA *"fais-moi un design moderne"*, on récupère systématiquement :

- une homepage avec un gros titre centré et 3 cards génériques en dessous ;
- un dégradé violet posé "parce que ça fait moderne" ;
- une stock photo d'équipe en costume autour d'une table en verre ;
- un footer pauvre avec juste un copyright ;
- des icônes décoratives sans signification (ampoule "idée", fusée "lancement", poignée de main "deal").

Si on **enlève le logo** d'un tel design, on peut le coller sur n'importe quel site. C'est le test ultime du **design IA générique**.

### La solution

Le skill **`premium-webdesigner`** interdit à Claude de coder directement. Il force une **méthode en 6 phases** :

1. **Compréhension** — type de projet, cible, action principale, émotion à transmettre, stack ;
2. **Recherche d'inspiration** — 21st.dev (featured + popular + newest), shadcn/ui, Lucide, Motion, Unsplash, Pixabay ;
3. **Sélection de composants** — chaque composant avec source, URL, raison du choix, adaptations, dépendances, impact responsive et perf ;
4. **Direction artistique** — palette, typographie, spacing, radius, shadows, animations ;
5. **Sourcing d'images** — Pixabay/Unsplash en priorité, mots-clés précis par secteur, alt text + licence + crédit documentés ;
6. **Exécution** — alignée sur la stack existante (pas de React imposé sur PHP, pas de Next sur WordPress, pas de Tailwind sur HTML pur).

### Ce que le skill produit

- 4 fichiers de planification dans `docs/` : `design-brief`, `moodboard-report`, `component-selection`, `image-selection`, `design-system` ;
- l'**implémentation** elle-même (commits séparés par phase) ;
- un **rapport de redesign** avec score `ui-quality-checklist` (sur 100, 6 axes : visuel, UX, responsive, accessibilité, cohérence, premium feel).

### Ce que le skill ne fait jamais sans accord explicite

- coder directement sans avoir produit un brief ;
- copier un composant 21st.dev sans le citer ;
- imposer React/Tailwind/Next sur un projet PHP ou WordPress ;
- supprimer ou modifier des données dynamiques pour faire joli ;
- casser un flow critique (auth, paiement, formulaire) ;
- utiliser des images sans respecter la licence ;
- pousser vers GitHub.

Voir [`docs/premium-webdesigner-how-to-use.md`](docs/premium-webdesigner-how-to-use.md), [`docs/premium-webdesigner-examples.md`](docs/premium-webdesigner-examples.md), et [`docs/article-section-premium-webdesigner.md`](docs/article-section-premium-webdesigner.md).

---

## Structure du repo

```txt
claude-skills-artofdev/
├── README.md                                # ce fichier
├── CHANGELOG.md
├── LICENSE                                  # MIT
├── .gitignore
├── install.sh                               # installe TOUS les skills présents dans skills/
├── uninstall.sh                             # retire un ou tous les skills (avec sauvegarde)
├── docs/
│   ├── article-section.md                   # article jonk.space — Skill 1 (repo-builder)
│   ├── how-to-use.md                        # repo-builder
│   ├── repo-builder-examples.md
│   ├── security-rules.md
│   ├── roadmap.md
│   ├── production-auditor-how-to-use.md     # production-auditor
│   ├── production-auditor-examples.md
│   └── article-section-production-auditor.md  # article jonk.space — Skill 2
├── skills/
│   ├── repo-builder/
│   │   ├── SKILL.md
│   │   ├── README.md
│   │   ├── references/
│   │   ├── templates/
│   │   └── scripts/
│   ├── production-auditor/
│   │   ├── SKILL.md
│   │   ├── README.md
│   │   ├── references/                       # 9 checklists
│   │   ├── templates/                        # 5 templates
│   │   └── scripts/                          # 4 scripts
│   └── premium-webdesigner/
│       ├── SKILL.md
│       ├── README.md
│       ├── references/                       # 10 fichiers (design-methodology, inspiration-sources, 21st-dev-workflow, image-sourcing, design-system-rules, ux/responsive/a11y/anti-basic checklists)
│       ├── templates/                        # 7 templates (design-brief, moodboard, component-selection, image-selection, design-system, redesign-report, ui-quality-checklist)
│       └── scripts/                          # 4 scripts (create-design-brief, create-redesign-report, scan-ui-basic-patterns, prepare-image-assets-folder)
├── examples/                                # 16 exemples (5 repo-builder + 5 production-auditor + 6 premium-webdesigner)
└── reports/                                 # rapports d'audit / redesign générés
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

`install.sh` (multi-skill) :

- détecte le chemin du repo ;
- crée `~/.claude/skills/` si nécessaire ;
- itère sur **tous** les sous-dossiers de `skills/` et installe / met à jour chacun ;
- **sauvegarde** chaque skill existant dans `~/.claude/skills/.backup/<skill>-YYYYMMDD-HHMMSS/` avant de l'écraser ;
- affiche les instructions d'utilisation.

Pour désinstaller un skill spécifique (sans toucher aux autres) :

```bash
bash uninstall.sh repo-builder
bash uninstall.sh production-auditor
```

Pour désinstaller **tous** les skills (avec confirmation) :

```bash
bash uninstall.sh --all
```

---

## Utilisation

Dans n'importe quelle conversation Claude Code, le bon skill s'active automatiquement selon ta demande.

### `repo-builder` (création de repo)

- *"Crée un repo propre pour un site statique de portfolio."*
- *"Initialise un repo Node/Next pour une app SaaS de gestion de tâches."*
- *"Prépare un repo plugin WordPress pour un widget de réservation."*
- *"Crée un repo Python/FastAPI pour une API d'envoi d'emails."*
- *"Démarre un repo pour un mini CMS de coiffeur."*

### `production-auditor` (audit avant prod)

- *"Audite ce projet."*
- *"Vérifie si c'est prêt pour la prod."*
- *"Audit complet : UX, SEO, sécurité, admin, déploiement."*
- *"Audit sécurité only, lecture seule."*
- *"Audit avant vidéo YouTube — masque les chemins serveur."*

### `premium-webdesigner` (refonte design)

- *"Refonte premium de cette homepage SaaS."*
- *"Ce site fait trop template WordPress, revois l'expérience visuelle complète."*
- *"Améliore ce dashboard admin : cards, badges, stats, états vides."*
- *"Brief design seul, sans coder. Moodboard + palette + composants."*
- *"Refonte avant/après avec score chiffré."*

Claude applique alors les règles du `SKILL.md` correspondant et rend un rapport final.

Voir [`examples/`](examples/) pour 16 cas concrets (5 + 5 + 6).

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

- **v0.1** — `repo-builder` : structure de base, 5 stacks supportées, install/uninstall (livré).
- **v0.2** — `production-auditor` : audit 10-phases, scoring 7-axes (livré).
- **v0.3** — `premium-webdesigner` : design 6-phases, 21st.dev/shadcn workflow, anti-basic rules, scoring UI quality (livré).
- **v0.4** — `mini-cms-builder` : générateur de mini CMS sectoriels PHP/SQLite.
- **v0.5** — `video-prep` : préparation d'un repo en mode screen-recording propre.
- **v0.6** — `zip-exporter` : empaquetage en ZIP livrable client.
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
