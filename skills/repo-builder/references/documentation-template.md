# Modèle de documentation minimale

Ce que **tout repo créé par `repo-builder`** doit contenir, au minimum.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. `README.md` — sections obligatoires

```markdown
# <Nom du projet>

<Une phrase qui décrit ce que c'est, en 15 mots maximum.>

> Created by <Auteur> — <Organisation> — <site>

---

## Description

<2-4 phrases : à quoi sert ce projet, pour qui, dans quel contexte.>

## Stack

- <Langage / framework principal>
- <Base de données si pertinent>
- <Dépendances clés>

## Installation

<Commandes copiables, dans l'ordre.>

## Usage

<Comment lancer, comment utiliser, exemples concrets.>

## Structure

<Arborescence du repo (3 à 5 niveaux maximum) — voir templates/README.template.md>

## Scripts

<Liste des commandes utiles : build, dev, test, deploy.>

## Variables d'environnement

<Liste des variables attendues, pointant vers `.env.example`.>

## Déploiement

<Lien vers `docs/deployment.md` ou résumé court.>

## Roadmap

<Lien vers `ROADMAP.md` ou liste courte.>

## Licence

<MIT par défaut, ou autre.>

## Credits

Created by <Auteur> — <Organisation>.
```

---

## 2. `docs/architecture.md` — sections obligatoires

```markdown
# Architecture

## Vue générale

<Schéma textuel ou ASCII : composants principaux, flux de données.>

## Stack

<Détail technique des choix.>

## Structure des dossiers

<Arborescence commentée.>

## Modules

<Pour chaque module / service principal : rôle, dépendances, interfaces.>

## Données

<Modèle de données : tables, schémas JSON, fichiers, formats.>

## Sécurité

<Authentification, autorisation, validation, secrets, points d'attention.>

## Déploiement

<Lien vers `deployment.md` ou résumé.>
```

---

## 3. `docs/deployment.md` — sections obligatoires

```markdown
# Déploiement

## Prérequis

<Versions requises (PHP, Node, Python, etc.), services externes (DB, S3…).>

## Installation

<Étapes d'installation pas-à-pas.>

## Variables d'environnement

<Tableau ou liste : nom, exemple, obligatoire/optionnel.>

## Build

<Commande de build si stack le nécessite.>

## Démarrage

<Comment lancer en dev et en production.>

## Reverse-proxy

<Configuration Nginx ou Apache si pertinent.>

## Rollback

<Comment revenir à la version précédente en cas de problème.>
```

---

## 4. `ROADMAP.md` — sections obligatoires

```markdown
# Roadmap

## MVP (en cours)

- [ ] <fonctionnalité 1>
- [ ] <fonctionnalité 2>

## v1.0

- [ ] <fonctionnalité>

## v1.1+

- [ ] <fonctionnalité>

## Idées futures (non engagées)

- <idée>
```

---

## 5. `CHANGELOG.md` — format obligatoire

Format **Keep a Changelog** simplifié :

```markdown
# Changelog

## [Unreleased]

### Added
- ...

### Changed
- ...

### Fixed
- ...

## [0.1.0] — YYYY-MM-DD

### Added
- Premier scaffolding.
```

---

## 6. Checklist de documentation

Avant de conclure, vérifier que tous ces fichiers existent et sont **non vides** :

- [ ] `README.md`
- [ ] `CHANGELOG.md`
- [ ] `ROADMAP.md`
- [ ] `LICENSE`
- [ ] `docs/architecture.md`
- [ ] `docs/deployment.md`
- [ ] `.env.example` (si secrets nécessaires)

Pour les types de projets spécifiques, ajouter :

- mini CMS : `INSTALL.md`, `EXPORT.md`, `manifest.json` ;
- plugin WordPress : `readme.txt` (format wordpress.org) ;
- repo Claude Skill : `install.sh`, `uninstall.sh`, `skills/<name>/SKILL.md`.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
