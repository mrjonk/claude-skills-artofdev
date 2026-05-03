# Changelog

Toutes les modifications notables de ce projet sont documentées dans ce fichier.

Format inspiré de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).
Versionnage [SemVer](https://semver.org/lang/fr/).

---

## [Unreleased]

### Changed
- `SKILL.md §11–12` : la roadmap peut être à la racine (`ROADMAP.md`) **ou** dans `docs/roadmap.md` ; la documentation technique (`docs/architecture.md` + `docs/deployment.md`) n'est plus obligatoire pour les types `claude-skill`, `docs-only`, `static-site` simple et scripts.

### À venir
- Détection automatique de la stack depuis une description en langage naturel.
- Skill `mini-cms-builder`.
- Skill `video-prep`.

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
