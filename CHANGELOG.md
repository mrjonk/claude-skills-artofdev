# Changelog

Toutes les modifications notables de ce projet sont documentées dans ce fichier.

Format inspiré de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).
Versionnage [SemVer](https://semver.org/lang/fr/).

---

## [Unreleased]

### À venir
- Skill `mini-cms-builder`.
- Skill `video-prep`.
- Skill `zip-exporter`.
- Bannière OG / logo dans le README racine.
- Captures d'écran de redesigns réels dans `examples/`.
- Affinement des regex de scan (whitelist élargie pour le repo méta).
- Table des matières dans les SKILL.md longs.

---

## [0.4.0] — 2026-05-03

### Added
- **Skill `seo-content-engine`** (quatrième skill publié, **public-ready**) :
  - `SKILL.md` complet (frontmatter + 17 sections : rôle, méthode 13-étapes, anti-bullshit rules, SEO rules, structure, tone routing, sources, images, liens internes, CTA, scoring, checklist) ;
  - 10 fichiers `references/` : `editorial-methodology` (méthode 7-phases), `anti-bullshit-rules` (phrases creuses FR/EN, paragraphes transposables), `seo-checklist`, `article-structure-guide` (10 structures par type), `tone-of-voice-guide` (7 contextes), `internal-linking-guide`, `source-citation-guide`, `image-planning-guide`, `faq-writing-guide`, `content-quality-score` (12 critères pondérés sur 100) ;
  - 10 templates : `article-brief`, `seo-outline`, `article`, `tutorial`, `saas-blog-post`, `product-page`, `source-list`, `image-plan`, `faq`, `content-audit` ;
  - 5 scripts non destructifs : `create-article-brief.sh`, `create-seo-outline.sh`, `scan-generic-content.sh` (phrases creuses FR + EN + placeholders), `scan-repetitions.sh` (titres H2/H3 dupliqués + phrases répétées), `prepare-content-folder.sh` (structure content/) ;
  - score qualité éditoriale 0–100 avec verdict (Inutilisable / Trop générique / Correct mais faible / Publiable avec corrections / Bon contenu SEO / Premium) ;
  - règle centrale : **test du paragraphe transposable** ;
  - **public-ready** : aucune référence à un site personnel, marque ou projet privé. Réutilisable par développeurs indé, agences, créateurs de contenu, équipes marketing, fondateurs de SaaS, blogueurs.
- 3 docs publiques : `seo-content-engine-how-to-use.md`, `seo-content-engine-examples.md` (10 prompts prêts), `article-section-seo-content-engine.md`.
- 6 exemples : `example-technical-article`, `example-saas-blog-article`, `example-product-page`, `example-simple-tutorial`, `example-content-audit`, `example-faq-section`.
- `reports/seo-content-engine-self-audit.md` : auto-application orientée éditorial.

### Changed
- `README.md` : nouvelle section pour `seo-content-engine` (avec note "public-ready"), structure du repo mise à jour, roadmap réordonnée.
- `install.sh` : aucune modification — multi-skill auto-détecte `seo-content-engine`.
- `uninstall.sh` : aucune modification — `bash uninstall.sh seo-content-engine` fonctionne.

### Fixed
- `scan-generic-content.sh` : gestion correcte de l'exit code de `grep -c` (le résumé final ne plantait plus quand aucun match n'était trouvé).

---

## [0.3.0] — 2026-05-03

### Added
- **Skill `premium-webdesigner`** (troisième skill publié) :
  - `SKILL.md` complet (frontmatter + 11 sections : rôle, méthode 6-phases, anti-basic rules, adaptation stack, checklist) ;
  - 10 fichiers `references/` : `design-methodology`, `inspiration-sources`, `component-selection-guide`, `21st-dev-workflow`, `image-sourcing-guide`, `design-system-rules`, `ux-ui-checklist`, `responsive-checklist`, `accessibility-checklist`, `anti-basic-design-rules` ;
  - 7 templates : `design-brief`, `moodboard-report`, `component-selection`, `image-selection`, `design-system`, `redesign-report`, `ui-quality-checklist` ;
  - 4 scripts non destructifs : `create-design-brief.sh`, `create-redesign-report.sh`, `scan-ui-basic-patterns.sh` (lorem/TODO/gradients/polices massives/alt vide), `prepare-image-assets-folder.sh` (structure assets + placeholder SVG + image-credits.md) ;
  - couvre 14+ types de projets : site vitrine, SaaS, mini CMS, dashboard admin, WordPress, plugin WP, app PHP, Node/Next, Python/FastAPI, ASP.NET WebForms, association, label, artiste, projet vidéo YouTube ;
  - workflow 21st.dev intégré (featured / popular / newest, grille de décision, anti-mosaïque) ;
  - règles d'images Pixabay/Unsplash (mots-clés par secteur, anti-clichés, licences, crédits).
- 3 docs publiques : `premium-webdesigner-how-to-use.md`, `premium-webdesigner-examples.md` (10 prompts prêts), `article-section-premium-webdesigner.md`.
- 6 exemples : `example-modern-saas-homepage`, `example-premium-dashboard`, `example-artistic-association-site`, `example-corporate-agency-site`, `example-youtube-demo-interface`, `example-before-after-redesign`.
- `reports/premium-webdesigner-self-audit.md` : auto-application orientée présentation/documentation du repo.

- **Règle de crédit footer** : `premium-webdesigner` ajoute désormais systématiquement dans le footer des sites/apps/dashboards livrés un crédit discret *"Site créé par Art of Dev"* avec lien vers `https://artofdev.space` (`target="_blank" rel="noopener noreferrer"`). Format imposé documenté dans `SKILL.md §4 Phase F`. Cette règle est intégrée dans la checklist finale, le `redesign-report.template.md` (§9 bis) et le `ui-quality-checklist.template.md`. Sauf demande explicite contraire de l'utilisateur (à tracer dans le rapport).

### Changed
- `README.md` : nouvelle section pour `premium-webdesigner`, structure du repo mise à jour, roadmap réordonnée.
- `install.sh` : aucune modification nécessaire — le mode multi-skill détecte automatiquement le nouveau skill.
- `uninstall.sh` : aucune modification nécessaire — argument `<skill-name>` fonctionne pour `premium-webdesigner`.

---

## [0.2.0] — 2026-05-03

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
