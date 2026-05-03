# Changelog

Toutes les modifications notables de ce projet sont documentées dans ce fichier.

Format inspiré de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).
Versionnage [SemVer](https://semver.org/lang/fr/).

---

## [Unreleased]

### Added
- **Skill `production-auditor`** (deuxième skill publié) :
  - `SKILL.md` complet (frontmatter + 15 sections : rôle, méthode 10-phases, scoring 7-axes 0–100, checklist) ;
  - 9 fichiers `references/` : `audit-methodology`, `technical-checklist`, `ux-ui-checklist`, `seo-content-checklist`, `security-checklist`, `admin-dashboard-checklist`, `payment-billing-checklist`, `deployment-readiness`, `report-format` ;
  - 5 templates : `audit-report`, `bug-list`, `correction-plan`, `production-readiness-score`, `release-checklist` ;
  - 4 scripts shell non destructifs : `scan-common-issues.sh` (TODO/FIXME/console.log/.bak), `scan-secrets.sh` (jamais affichage en clair), `scan-dead-links.sh`, `generate-audit-report.sh` ;
  - mode `VIDEO_PRESENTATION_MODE` pour les projets filmés ;
  - couvre 14 types de projets : site vitrine, SaaS, mini CMS, CMS open-core, dashboard admin, WordPress + plugin WP, app PHP, Node/Next, Python/FastAPI, ASP.NET WebForms, outil interne, repo doc, projet vidéo.
- 3 docs publiques : `production-auditor-how-to-use.md`, `production-auditor-examples.md`, `article-section-production-auditor.md`.
- 5 exemples : `example-audit-saas`, `example-audit-mini-cms`, `example-audit-wordpress-site`, `example-audit-admin-dashboard`, `example-audit-before-youtube-demo`.
- Dossier `reports/` pour les rapports d'audit générés.

### Changed
- `install.sh` : passe en mode **multi-skill** (boucle sur `skills/*` pour installer chaque skill, sauvegarde individuelle).
- `uninstall.sh` : accepte un nom de skill en argument (`bash uninstall.sh production-auditor`) ou `--all` pour tout désinstaller. Refuse de tout retirer sans confirmation explicite.
- `README.md` : nouvelle section pour `production-auditor`, structure du repo mise à jour, roadmap réordonnée.

### À venir
- Détection automatique de la stack depuis une description en langage naturel.
- Skill `mini-cms-builder`.
- Skill `video-prep`.

---

## [0.1.1] — 2026-05-03

### Changed
- `SKILL.md §11–12` (`repo-builder`) : la roadmap peut être à la racine (`ROADMAP.md`) **ou** dans `docs/roadmap.md` ; la documentation technique (`docs/architecture.md` + `docs/deployment.md`) n'est plus obligatoire pour les types `claude-skill`, `docs-only`, `static-site` simple et scripts.

---

## [0.1.0] — 2026-05-03

### Added
- Skill `repo-builder` (premier skill publié).
- Structure complète du repo : `docs/`, `skills/`, `examples/`.
- Templates de documentation : README, ARCHITECTURE, DEPLOYMENT, ROADMAP, CHANGELOG.
- Scripts de création de repo : basic, Node, PHP, Python.
- Script `check-repo-safety.sh` (audit secrets en lecture seule).
- 5 exemples de prompts d'utilisation du skill.
- `install.sh` / `uninstall.sh` avec sauvegarde datée.
- Section d'article éditorial (`docs/article-section.md`) prête pour jonk.space.
- Licence MIT.

---

Created by João de Almeida — Art of Dev
https://artofdev.space
