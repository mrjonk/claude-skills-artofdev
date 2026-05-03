# Roadmap — Claude Skills Art of Dev

## Vision

Construire une collection de **Claude Skills** réutilisables, qui couvrent les tâches répétitives du workflow Art of Dev :

- création de repos propres ;
- génération de mini CMS sectoriels ;
- préparation de projets en mode screen-recording ;
- empaquetage en ZIP livrable client.

Chaque skill suit la même règle : **écrit une fois, appliqué mille fois.**

---

## v0.1 — `repo-builder` (publié)

Statut : **livré le 2026-05-03**.

- Skill `repo-builder` complet.
- 5 stacks supportées : static-site, node-saas, php-app, mini-cms, python-script (+ wordpress-plugin, doc-only, claude-skill).
- Templates : README, ARCHITECTURE, DEPLOYMENT, ROADMAP, CHANGELOG.
- Scripts : create-basic, create-node, create-php, create-python, check-repo-safety.
- Install/uninstall avec sauvegarde datée.
- 5 exemples documentés.

---

## v0.2 — `repo-builder` enrichi

Statut : **planifié**.

- Détection automatique de la stack à partir d'une description en langage naturel ("c'est une app pour…", "il y aura du Python et du Stripe…").
- Support React Native / Expo.
- Support Rust (Cargo workspace).
- Support Go (modules).
- Pré-remplissage des `*.template.md` avec les valeurs détectées (nom du repo, description, stack).

---

## v0.3 — `mini-cms-builder`

Statut : **planifié**.

Second skill : générer la base PHP/SQLite d'un mini CMS sectoriel, aligné avec `CLAUDE_PROJECT_FACTORY.md`.

- core admin + installer ;
- dashboard intelligent (todo, checklist, stats) ;
- déclinaison sectorielle (restaurant, tatoueur, coiffeur, DJ, association, boutique) ;
- export ZIP intégré.

---

## v0.4 — `video-prep`

Statut : **planifié**.

Skill destiné à préparer un repo en mode screen-recording :

- masque les chemins serveur ;
- vérifie qu'aucun secret n'apparaît à l'écran ;
- prépare un terminal "propre" ;
- génère un fichier `STAGING.md` qui décrit la séquence des étapes filmables.

---

## v0.5 — `zip-exporter`

Statut : **planifié**.

Skill pour empaqueter un projet en ZIP livrable :

- exclut `.git`, `node_modules`, `vendor`, dumps, `.env` ;
- inclut `README`, `INSTALL`, `EXPORT`, `manifest.json` ;
- nomme le fichier `project-name-installable-YYYYMMDD-HHMM.zip` ;
- vérifie le poids final (alerte si > 200 Mo).

---

## v1.0 — Collection stable

Statut : **objectif fin 2026**.

- 5 skills publiés et stabilisés.
- Article complet sur jonk.space / Art of Dev.
- Vidéo YouTube : *"Comment j'ai industrialisé mon workflow avec Claude Code"*.
- Templates téléchargeables séparément depuis Art of Dev.
- Documentation EN + FR.

---

## Idées futures (non engagées)

- `i18n-helper` : skill d'aide à la traduction d'un mini CMS.
- `seo-audit` : skill d'audit SEO automatisé.
- `lighthouse-runner` : skill qui génère un rapport Lighthouse + actions correctives.
- Marketplace privée de skills Art of Dev (clients pro).
- Intégration GitHub Action : *"créer un repo via skill au lieu d'un template"*.

---

## Comment contribuer à la roadmap

Ouvrir une issue sur le repo GitHub :
`github.com/mrjonk/claude-skills-artofdev/issues`

Tag :
- `idea` pour une suggestion de skill ;
- `bug` pour un bug du skill `repo-builder` ;
- `doc` pour une amélioration de documentation.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
