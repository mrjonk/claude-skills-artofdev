---
name: repo-builder
description: Crée un repository propre, structuré et documenté pour un nouveau projet. À utiliser dès que l'utilisateur demande de créer, initialiser, démarrer, scaffolder ou structurer un repo (site statique, SaaS, mini CMS, plugin WordPress, app PHP/Node/Python/FastAPI, script d'automatisation, repo de documentation, repo Claude Skill). Génère arborescence, README, .gitignore, docs, CHANGELOG, ROADMAP, audite la sécurité, prépare git/gh sans pousser sans accord. Refuse de commiter secrets, .env, tokens, dumps SQL ou backups privés.
version: 0.1.0
author: João de Almeida — Art of Dev
homepage: https://artofdev.space
---

# Skill — `repo-builder`

> Created by **João de Almeida** — Art of Dev — https://artofdev.space

## USE WHEN / SKIP WHEN

**USE WHEN:**
- l'utilisateur demande de créer un nouveau repo, projet ou structure de base
- il faut initialiser un repo propre (README, .gitignore, docs, CHANGELOG)
- il faut détecter une stack et appliquer les conventions adaptées
- il faut préparer un repo public/privé sur GitHub avec les bonnes garanties (pas de secret, .env.example, etc.)

**SKIP WHEN:**
- l'utilisateur n'a pas demandé de créer un repo
- la tâche est de modifier un projet existant (utiliser un autre skill)
- la demande est un simple commit, push, ou modification ciblée
- le repo existe déjà et n'a pas besoin de structure additionnelle

→ Voir [`docs/skill-routing-map.md`](../../docs/skill-routing-map.md) pour la table complète d'orchestration.

---

## 1. Rôle du skill

Tu es chargé de créer un repository **propre, professionnel et reproductible** pour un nouveau projet.

Ton objectif n'est **pas** de coder le projet. Ton objectif est de produire la **base** :

- arborescence ;
- documentation minimale mais réelle ;
- conventions Git/GitHub ;
- audit de sécurité ;
- préparation des commandes `git` / `gh` sans pousser sans accord explicite.

Tu produis un repo qu'on peut montrer dans un article, dans une vidéo YouTube, ou livrer à un client sans avoir honte.

---

## 2. Règles strictes (non négociables)

Voir [`docs/shared-safety-rules.md`](../../docs/shared-safety-rules.md) pour le tronc
commun (pas de push sans accord, pas de modification de secrets, pas d'action
destructive sans validation, signaler > corriger, honnêteté).

**Spécifique à `repo-builder` :**

1. **Ne jamais commiter** : dumps SQL contenant des données réelles, backups privés,
   `node_modules/`, `vendor/`, `.venv/`, builds. (Cf. `references/security-checklist.md`
   pour la liste complète.)
2. **Toujours travailler dans le dossier courant** sauf instruction contraire.
3. **Toujours vérifier** le dossier courant avant d'écrire (`pwd`, `ls`).
4. **Toujours produire un rapport final** synthétique (cf. §13).

---

## 3. Étapes de travail

### 3.1 Comprendre la demande

Avant d'écrire le moindre fichier, identifie :

- **type de projet** (cf. §4) ;
- **stack technique** (PHP/SQLite, Node/Next, Python/FastAPI, statique, etc.) ;
- **visibilité** souhaitée (public/privé GitHub) — par défaut **privé** si non précisé ;
- **nom du repo** — si l'utilisateur ne donne pas de nom, propose un slug clair (cf. `references/naming-conventions.md`) ;
- **besoin de Stripe / Pixabay / SMTP** — listés en `.env.example`, jamais en dur.

Si une info critique manque, **demande**. Sinon, fais une hypothèse raisonnable et **note-la** dans le rapport final.

### 3.2 Vérifier l'environnement

```bash
pwd
ls -la
git --version
gh --version 2>/dev/null || echo "gh non installé"
git status 2>/dev/null || echo "pas un repo git"
```

Si `gh` est absent, prépare uniquement les commandes Git locales et signale qu'il manque.

### 3.3 Choisir la structure

Consulter `references/repo-structure-guide.md` et choisir la structure adaptée au type détecté (§4).

### 3.4 Générer les fichiers

Dans cet ordre :

1. créer l'arborescence (`mkdir -p`) ;
2. `README.md` (utiliser `templates/README.template.md` comme base, puis personnaliser) ;
3. `.gitignore` adapté à la stack (cf. `references/security-checklist.md`) ;
4. `CHANGELOG.md` (template) ;
5. `ROADMAP.md` (template) ;
6. `docs/architecture.md` et `docs/deployment.md` (templates) ;
7. fichiers spécifiques à la stack (`package.json` minimal, `requirements.txt`, `manifest.json`, etc.) ;
8. `.env.example` si secrets nécessaires.

### 3.5 Auditer la sécurité

Exécuter :

```bash
bash skills/repo-builder/scripts/check-repo-safety.sh .
```

Si une alerte remonte, **stopper** la procédure de commit, lister les fichiers concernés, demander à l'utilisateur.

### 3.6 Préparer Git

```bash
git init
git add <fichiers explicites — jamais "git add -A" en aveugle>
git status
```

Préparer le message de commit :

```txt
chore: initial scaffolding via repo-builder skill
```

ou plus descriptif selon le projet.

**Ne pas commiter sans avoir affiché `git status` à l'utilisateur.**

### 3.7 Préparer GitHub (si `gh` disponible)

Préparer la commande **sans l'exécuter** :

```bash
# À valider avant exécution :
gh repo create <slug> --private --source=. --remote=origin --push
```

Demander à l'utilisateur :
- public ou privé ?
- pousser maintenant ou pas ?

### 3.8 Rapport final

Voir §11.

---

## 4. Types de projets supportés

Le skill doit savoir gérer **au minimum** ces types :

| Type | Slug | Stack typique |
|---|---|---|
| Site statique | `static-site` | HTML/CSS/JS, parfois Astro/Eleventy |
| App SaaS | `node-saas` | Node + Next.js / Nuxt / Remix |
| Mini CMS sectoriel | `mini-cms` | PHP 8 + SQLite |
| Plugin WordPress | `wordpress-plugin` | PHP, conventions WP |
| App PHP générique | `php-app` | PHP 8, structure custom |
| App Node / Next | `node-app` | Node, sans business SaaS |
| App Python / FastAPI | `python-fastapi` | Python 3.11+, FastAPI, uvicorn |
| Script d'automatisation | `python-script` ou `bash-script` | Python ou Bash |
| Documentation seule | `docs-only` | MkDocs, Docusaurus, ou Markdown brut |
| Repo Claude Skill | `claude-skill` | structure `skills/<name>/SKILL.md` |

Si l'utilisateur demande un type non listé, **adapte** en partant du plus proche et **signale** que c'est un cas générique.

---

## 5. Structure de repo recommandée (générique)

```txt
<repo-slug>/
├── README.md
├── CHANGELOG.md
├── ROADMAP.md
├── LICENSE                  # MIT par défaut sauf demande contraire
├── .gitignore
├── .env.example             # uniquement si secrets nécessaires
├── docs/
│   ├── architecture.md
│   └── deployment.md
├── src/                     # ou app/, public/, etc. selon stack
└── tests/                   # si stack le permet
```

Les variantes par stack sont détaillées dans `references/repo-structure-guide.md`.

---

## 6. Règles de sécurité

Tronc commun : [`docs/shared-safety-rules.md`](../../docs/shared-safety-rules.md).

Détail repo-builder : `references/security-checklist.md` + `docs/security-rules.md`
(`.gitignore` minimum + audit avant commit).

Spécifique :

- `.env` interdit, `.env.example` obligatoire si secrets ;
- aucun chemin serveur sensible (`/var/www/...`, `/home/...`) commité ;
- aucune IP locale, nom d'utilisateur Linux, hostname interne ;
- aucune donnée client réelle dans les fixtures ;
- audit `check-repo-safety.sh` avant commit.

---

## 7. Règles Git/GitHub

Tronc commun (push, force-push, amend, no-verify) :
[`docs/shared-safety-rules.md`](../../docs/shared-safety-rules.md) §1.

Spécifique repo-builder :

- Initialise toujours avec `git init` (jamais `git init --bare` à moins que ce soit demandé).
- Branche par défaut : `main`.
- Premier commit : message clair, en-tête `chore:`, `feat:`, ou `init:`.
- Jamais `git add -A` sans avoir vérifié `git status`. Préfère `git add <fichiers>` explicites.
- Pour GitHub :
  - utiliser `gh` ;
  - protocole **SSH** ;
  - **demander** public/privé avant `gh repo create` ;
  - **ne pas** ajouter automatiquement `--push` sans accord explicite.

---

## 8. Règles de documentation

Tout repo créé doit contenir, au minimum :

- `README.md` clair (titre, description, install, usage, structure, scripts, env, déploiement, roadmap, credits) ;
- `CHANGELOG.md` (Keep a Changelog) ;
- `ROADMAP.md` (MVP, v1.0, idées futures) ;
- `docs/architecture.md` ;
- `docs/deployment.md`.

Style :

- français (par défaut, sauf instruction contraire) ;
- concis, professionnel, sans bullshit IA ;
- pas de lorem ipsum, pas de phrases creuses, pas de remplissage ;
- exemples concrets, commandes copiables ;
- mention `Created by João de Almeida — Art of Dev` quand le skill est utilisé pour un projet Art of Dev (sinon, mention de l'auteur fournie par l'utilisateur).

---

## 9. Commandes autorisées

Sécurisées, à utiliser librement :

- `mkdir -p`, `touch`, `chmod +x` sur les scripts du skill ;
- `git init`, `git add <fichiers>`, `git status`, `git diff`, `git log`, `git commit -m` ;
- `gh auth status`, `gh repo create --private` (sans `--push` par défaut) ;
- `cat`, `ls`, `pwd`, `find` (lecture seule).

Demander confirmation avant :

- `gh repo create --public` ;
- toute commande avec `--push` ;
- `git push` (toutes formes) ;
- exécution d'un script d'install (`npm install`, `composer install`, `pip install`) — parfois utile, mais pas par défaut.

---

## 10. Commandes interdites ou dangereuses

Tronc commun (rm -rf, git reset --hard, push --force, gh repo delete, modifs `~/.ssh`) :
[`docs/shared-safety-rules.md`](../../docs/shared-safety-rules.md) §3.

Spécifique repo-builder, jamais en mode "scaffolding" :

- `gh repo edit --visibility public` sur un repo existant ;
- `cat .env`, `printenv`, `env | grep -i secret/token/key/password` (afficherait des secrets) ;
- `grep -R PASSWORD .`, `grep -R SECRET .` en mode visible (peut être fait silencieusement pour audit, mais pas affiché à l'utilisateur ni à l'écran en mode vidéo).

---

## 11. Critères de qualité finale

Avant de conclure, vérifier que **toutes** ces conditions sont remplies :

- [ ] le repo a un nom clair et un slug propre (`references/naming-conventions.md`) ;
- [ ] `README.md` présent, complet, en français, sans phrase creuse ;
- [ ] `.gitignore` présent et adapté à la stack ;
- [ ] `CHANGELOG.md` présent ;
- [ ] **roadmap présente** : `ROADMAP.md` à la racine **ou** `docs/roadmap.md` ;
- [ ] **documentation technique** présente : `docs/architecture.md` et `docs/deployment.md`
      — **obligatoires** pour les types `node-saas`, `mini-cms`, `wordpress-plugin`, `php-app`, `node-app`, `python-fastapi` ;
      — **non requis** pour les types `claude-skill`, `docs-only`, `static-site` simple, `bash-script`, `python-script` (où une seule page de doc — `docs/usage.md` ou équivalent — suffit) ;
- [ ] `LICENSE` présent (MIT par défaut sauf demande ; GPL-2.0-or-later pour `wordpress-plugin`) ;
- [ ] aucun secret détecté par `check-repo-safety.sh` ;
- [ ] aucun chemin serveur sensible dans les fichiers ;
- [ ] git initialisé, premier commit prêt mais **non poussé** ;
- [ ] commandes `gh` préparées mais **non exécutées** ;
- [ ] rapport final fourni à l'utilisateur.

---

## 12. Checklist finale (à appliquer systématiquement)

```txt
[ ] Type de projet identifié et noté
[ ] Nom de repo validé (slug propre, sans accent, sans espace)
[ ] Visibilité GitHub validée (public/privé)
[ ] Structure générée (mkdir -p)
[ ] README.md écrit et personnalisé
[ ] .gitignore adapté à la stack
[ ] CHANGELOG.md initial
[ ] Roadmap initiale (ROADMAP.md OU docs/roadmap.md selon convention du type)
[ ] docs/ adapté au type :
    - app/plugin/cms : docs/architecture.md + docs/deployment.md obligatoires
    - claude-skill / docs-only / static simple : docs/ minimal (au moins une page d'usage)
[ ] LICENSE adaptée (MIT par défaut ; GPL-2.0-or-later si wordpress-plugin)
[ ] .env.example si secrets nécessaires
[ ] Aucun .env / token / clé / dump présent
[ ] check-repo-safety.sh exécuté → état OK
[ ] git init effectué
[ ] git add explicite
[ ] Premier commit prêt (non poussé)
[ ] Commandes gh préparées (non exécutées)
[ ] Rapport final rendu à l'utilisateur
```

---

## 13. Format du rapport final

À la fin de toute exécution du skill, rendre **systématiquement** un bloc de ce type :

```txt
═══════════════════════════════════════════
RAPPORT — repo-builder
═══════════════════════════════════════════
Repo créé          : oui
Nom                : <slug>
Type               : <static-site | node-saas | mini-cms | …>
Stack              : <…>
Visibilité prévue  : public / privé
Chemin local       : <chemin relatif>

Fichiers principaux créés :
- README.md
- .gitignore
- CHANGELOG.md
- ROADMAP.md
- docs/architecture.md
- docs/deployment.md
- <fichiers spécifiques>

Sécurité :
- .env présent ?            non
- .env.example présent ?    oui / non
- Secrets détectés ?        non
- Audit check-repo-safety : OK / À VÉRIFIER

Git :
- git init              : fait
- Premier commit prêt   : oui (non poussé)
- Message de commit     : "<message>"

GitHub CLI :
- gh installé           : oui / non
- Connecté              : oui / non (compte : <login>)
- Commande préparée     : gh repo create <slug> --private --source=. --remote=origin
- Push                  : NON exécuté — en attente de validation

Hypothèses faites :
- <…>

Prochaine étape :
- valider la commande gh ;
- lancer le push si OK ;
- commencer le développement.
═══════════════════════════════════════════
```

---

## 14. Références internes

- `references/repo-structure-guide.md` — structures par type de projet
- `references/github-workflow.md` — workflow Git/GitHub recommandé
- `references/naming-conventions.md` — slugs, casing, longueur
- `references/documentation-template.md` — sections obligatoires d'un bon README
- `references/security-checklist.md` — règles de sécurité (lecture obligatoire avant commit)
- `templates/README.template.md`
- `templates/ARCHITECTURE.template.md`
- `templates/DEPLOYMENT.template.md`
- `templates/ROADMAP.template.md`
- `templates/CHANGELOG.template.md`
- `scripts/create-basic-repo.sh`
- `scripts/create-node-repo.sh`
- `scripts/create-php-repo.sh`
- `scripts/create-python-repo.sh`
- `scripts/check-repo-safety.sh`

---

Created by **João de Almeida** — Art of Dev
https://artofdev.space
