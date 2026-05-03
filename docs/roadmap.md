# Roadmap — Claude Skills Art of Dev

## Vision

Construire une collection de **Claude Skills** réutilisables, légers à charger, orchestrables, qui couvrent les tâches répétitives du workflow Art of Dev.

Chaque skill suit la même règle : **écrit une fois, appliqué mille fois.**

Les skills sont conçus pour un **chargement progressif** :

- `SKILL.md` court avec des règles `USE WHEN` / `SKIP WHEN` claires ;
- détails métier déplacés dans `references/` ;
- pas d'exécution multi-skills automatique ;
- orchestration explicite via `skill-orchestrator`.

---

## v0.1 — `repo-builder` (publié)

Statut : **livré le 2026-05-03**.

- Skill `repo-builder` complet.
- 5 stacks supportées : static-site, node-saas, php-app, mini-cms, python-script (+ wordpress-plugin, doc-only, claude-skill).
- Templates : README, ARCHITECTURE, DEPLOYMENT, ROADMAP, CHANGELOG.
- Scripts : create-basic, create-node, create-php, create-python, check-repo-safety.
- Install/uninstall avec sauvegarde datée.

---

## v0.2 — `production-auditor` (publié)

Statut : **livré le 2026-05-03**.

- Audit 10-phases.
- Score 7-axes pondéré sur 100.
- Mode `VIDEO_PRESENTATION_MODE`.
- Corrections sûres optionnelles.

---

## v0.3 — `premium-webdesigner` (publié)

Statut : **livré le 2026-05-03**.

- Méthode 6-phases : brief → 21st.dev/shadcn → composants → direction artistique → images → exécution alignée stack.
- Score `ui-quality-checklist` sur 100.
- Anti-design IA basique.

---

## v0.4 — `seo-content-engine` (publié)

Statut : **livré le 2026-05-03**.

- Méthode éditoriale 13-étapes.
- Test du paragraphe transposable.
- Score qualité éditoriale 0–100.
- **Public-ready**.

---

## v0.5 — `site-ux-guardian` (publié)

Statut : **livré le 2026-05-03**.

- Audit ergonomique transversal 11-phases.
- Webdesign guidelines 14 axes.
- Score cohérence + score visuel sur 100.
- **Public-ready**.

---

## v0.6 — `multilingual-site-engine` (planifié)

Skill dédié à la **traduction, localisation et cohérence multilingue** des sites, interfaces, contenus, menus, SEO, slugs, métadonnées et textes administrables.

Couverture :

- détection de la langue source ;
- question obligatoire sur les langues cibles ;
- détection de l'architecture i18n existante ;
- préservation des variables, composants dynamiques et placeholders ;
- traduction naturelle (anti-traduction littérale) ;
- humanisation des textes (anti-style IA, traitement du tiret long excessif) ;
- SEO multilingue (title, meta, hreflang, canonical, slugs, sitemap) ;
- routes et slugs traduits ;
- menus, footers, formulaires, erreurs et emails localisés ;
- formats locaux (dates, devises, nombres) et RTL si applicable ;
- score qualité de traduction + score readiness multilingue (0–100 chacun).

---

## v0.7 — `skill-orchestrator` (planifié)

Skill de **coordination** qui analyse une demande utilisateur, identifie les skills utiles, évite les doublons, **ne charge pas tout automatiquement**, et propose une stratégie d'exécution claire avant de mobiliser plusieurs skills.

Comportement :

- analyse l'intention utilisateur ;
- identifie le **skill principal** le plus spécifique ;
- propose les skills **secondaires** seulement si utiles ;
- explique pourquoi un skill est utile ou inutile ;
- demande confirmation avant de charger plusieurs gros skills ;
- ne crée jamais automatiquement un repo, un ZIP, ou une action destructive sans demande explicite ;
- s'appuie sur la table de routage `docs/skill-routing-map.md`.

---

## v1.0 — Collection stable

Statut : **objectif fin 2026**.

- 7 skills publiés et stabilisés.
- Documentation complète.
- Article éditorial accompagnant la collection.

---

## Idées futures (non engagées)

- `lighthouse-runner` : skill qui génère un rapport Lighthouse + actions correctives.
- `accessibility-auditor` : audit accessibilité approfondi (WCAG AA / AAA).
- `migration-assistant` : skill de migration de stack (PHP → Node, Vue → React).
- Marketplace privée de skills Art of Dev (clients pro).
- Intégration GitHub Action : *"créer un repo via skill au lieu d'un template"*.

---

## Comment contribuer à la roadmap

Ouvrir une issue sur le repo GitHub :
`github.com/mrjonk/claude-skills-artofdev/issues`

Tag :

- `idea` pour une suggestion de skill ;
- `bug` pour un bug d'un skill existant ;
- `doc` pour une amélioration de documentation.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
