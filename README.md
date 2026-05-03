# Claude Skills — Art of Dev

Une collection de **Claude Skills** maison pour industrialiser la création de projets propres avec Claude Code.

Skills publiés :

| Skill | Rôle |
|---|---|
| [`repo-builder`](skills/repo-builder/) | Créer un repo GitHub propre, structuré, documenté, en une commande |
| [`production-auditor`](skills/production-auditor/) | Auditer un projet avant mise en production : score 7-axes, plan de correction, corrections sûres |

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
│   └── production-auditor/
│       ├── SKILL.md
│       ├── README.md
│       ├── references/                       # 9 checklists (audit, tech, UX, SEO, sec, admin, billing, deploy, report-format)
│       ├── templates/                        # 5 templates (audit-report, bug-list, correction-plan, score, release-checklist)
│       └── scripts/                          # 4 scripts (scan-common-issues, scan-secrets, scan-dead-links, generate-audit-report)
├── examples/                                # 5 exemples repo-builder + 5 exemples production-auditor
└── reports/                                 # rapports d'audit générés
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

Claude applique alors les règles du `SKILL.md` correspondant et rend un rapport final.

Voir [`examples/`](examples/) pour 10 cas concrets (5 par skill).

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
- **v0.2** — `production-auditor` : audit 10-phases, scoring 7-axes, 9 checklists, 5 templates, 4 scripts (livré).
- **v0.3** — `repo-builder` enrichi : détection automatique de stack depuis langage naturel.
- **v0.4** — `mini-cms-builder` : générateur de mini CMS sectoriels PHP/SQLite.
- **v0.5** — `video-prep` : préparation d'un repo en mode screen-recording propre.
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
