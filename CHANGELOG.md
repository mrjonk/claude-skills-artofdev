# Changelog

Toutes les modifications notables de ce projet sont documentées dans ce fichier.

Format inspiré de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).
Versionnage [SemVer](https://semver.org/lang/fr/).

---

## [Unreleased]

### v1.0 blockers (à compléter avant `v1.0.0` final)

- runtime live des 7 skills sur 2-3 projets réels (multilingual-site-engine sur 3 stacks) ;
- runtime validation des 15 cas de routage `skill-orchestrator` ;
- bannière OG `assets/og-banner.png` produite ;
- captures avant/après audit, routing, traduction, optimisation token livrées dans `assets/captures/` ;
- article éditorial relu et publié ;
- décision humaine : promouvoir `v1.0.0-rc1` en `v1.0.0` final.

---

## [1.0.0-rc1] — 2026-05-03

### Added
- **`docs/shared-safety-rules.md`** : référence unique pour les règles non-négociables communes (push, secrets, destructif, validation, signaler>modifier, périmètre, mode vidéo, honnêteté). Pointée par les 7 SKILL.md.
- **`docs/skill-routing-map.md`** : table de routage 7 skills + workflows multi-skills + anti-patterns + règles d'arbitrage.
- **`docs/release-notes-v1.0.0-rc1.md`** : release notes RC1 complètes avec critères pour passer en v1.0.0 final.
- **`docs/article-v1.0-collection-claude-skills-artofdev.md`** : article éditorial prêt à publication.
- **Section `USE WHEN / SKIP WHEN`** ajoutée à chaque SKILL.md (7 skills) pour permettre le routage sans charger tout le contenu.
- **Section `Token-conscious design`** dans le README.
- **`reports/v1.0-readiness-audit.md`** : état des lieux honnête v1.0.
- **`reports/validation-multilingual-site-engine.md`** : validation statique sur 3 stacks (fixtures `examples/validation-fixtures/`).
- **`reports/validation-skill-orchestrator.md`** : couverture des 15 cas de routage attendus.
- **`reports/v1.0-regression-validation.md`** : anti-régression statique des 5 skills antérieurs.
- **`reports/token-optimization-v1.0.md`** : avant/après détaillé des SKILL.md.
- **`reports/duplicate-rules-audit-v1.0.md`** : 10 familles de doublons identifiées, factorisées ou justifiées.
- **`examples/skill-orchestrator-routing-test-cases.md`** : 15 cas de routage attendus.
- **`examples/validation-fixtures/php-static-multilingual/`** : fixture testable PHP.
- **`examples/validation-fixtures/nextjs-multilingual/`** : fixture testable Next.js + next-intl.
- **`examples/validation-fixtures/wordpress-theme-multilingual/`** : fixture testable thème WordPress (gettext, .po/.mo).
- **`examples/README.md`** : index complet des exemples.
- **`assets/README.md`** : brief créatif pour bannière OG et captures à produire.

### Changed
- **Optimisation token** :
  - `skills/site-ux-guardian/SKILL.md` : 849 → 258 lignes (-591, -69 %).
  - `skills/seo-content-engine/SKILL.md` : 570 → 306 lignes (-264, -46 %).
  - 5 SKILL.md (`repo-builder`, `production-auditor`, `premium-webdesigner`, `multilingual-site-engine`, `skill-orchestrator`) : sections de sécurité communes raccourcies + pointeur vers `docs/shared-safety-rules.md`.
  - Total cumulé : 3 160 → 2 307 lignes (-853, -27 %).
- **Roadmap** : v0.6/v0.7 marqués "committé, runtime à valider", ajout d'une étape `v1.0.0-rc1` explicite, séparation propre rc1 / v1.0 final.
- **README** : suppression de la fausse séparation "publiés / planifiés", remplacée par une note honnêteté sur le statut RC1.

### Fixed
- Aucun nouveau bug corrigé dans cette passe — uniquement consolidation, optimisation et documentation.

---

## [0.6.0] — 2026-05-03

### Added
- **Skill `multilingual-site-engine`** (sixième skill, **public-ready**) :
  - traduction, localisation et cohérence multilingue de sites et applications ;
  - question obligatoire sur les langues cibles si elles ne sont pas précisées ;
  - détection de l'architecture i18n existante (i18next, gettext, JSON, PHP arrays, PO/MO, CMS multilingue) ;
  - préservation des variables, composants dynamiques, placeholders, routes ;
  - traduction naturelle (anti-littéralisme) + humanisation (anti-style IA, traitement du tiret long excessif) ;
  - SEO multilingue : title, meta, hreflang, canonical, slugs, sitemap, Open Graph ;
  - localisation menus, footers, formulaires, erreurs, emails, metadata, alt text ;
  - formats locaux (dates, devises, nombres) + checklist RTL ;
  - 4 modes : audit-only, plan, traduction+humanisation, SEO multilingue final ;
  - 2 scores : Translation Quality Score + Multilingual Site Readiness Score (0-100 chacun).
- **Skill `skill-orchestrator`** (septième skill, **public-ready**, optimisé tokens) :
  - analyse l'intention utilisateur et identifie le skill principal le plus spécifique ;
  - propose les skills secondaires seulement si utiles ;
  - demande confirmation avant de mobiliser plusieurs gros skills ;
  - ne crée jamais automatiquement un repo, un ZIP ou une action destructive sans demande explicite ;
  - s'appuie sur la table de routage `docs/skill-routing-map.md`.
- `docs/skill-routing-map.md` : table de routage centrale (intention utilisateur → skill principal → skills secondaires possibles → ne pas utiliser quand).
- Section **"USE WHEN / SKIP WHEN"** ajoutée à chaque SKILL.md (5 skills existants + 2 nouveaux), pour permettre à `skill-orchestrator` de router sans charger tout le contenu.
- Section **"Token-conscious design"** dans le README : explique le chargement progressif et l'orchestration explicite.

### Changed
- Roadmap (`docs/roadmap.md` + section `## Roadmap` du README) :
  - retrait des entrées `mini-cms-builder` (anciennement v0.6), `video-prep` (anciennement v0.7) et `zip-exporter` (anciennement v0.8) ;
  - ajout de `multilingual-site-engine` en v0.6 ;
  - ajout de `skill-orchestrator` en v0.7 ;
  - v1.0 redéfinie comme collection stable de 7 skills.
- Tableau principal du README : ajout d'une seconde table "Skills planifiés" listant `multilingual-site-engine` et `skill-orchestrator`.

### À venir
- Bannière OG / logo dans le README racine.
- Captures d'écran de redesigns / audits réels dans `examples/`.
- Affinement des regex de scan (whitelist élargie pour le repo méta).
- Optimisation continue des SKILL.md existants : déplacement progressif des longues checklists vers `references/`.
- Table des matières dans les SKILL.md longs (notamment site-ux-guardian, ~830 lignes).

---

## [0.5.0] — 2026-05-03

### Added
- **Skill `site-ux-guardian`** (cinquième skill publié, **public-ready**) :
  - `SKILL.md` complet (frontmatter + 25 sections : rôle, philosophie 15 questions, méthode 11 phases, règles menus/footers/routes/doublons, discipline fichier, cohérence front/admin, multilingue, webdesign guidelines 14 axes, sécurité basique, 3 modes d'exécution, scoring cohérence + visuel sur 100, checklist) ;
  - 18 fichiers `references/` : `ux-consistency-methodology`, `navigation-audit-guide`, `menu-footer-consistency-guide`, `route-mapping-guide`, `duplicate-detection-guide`, `component-reuse-guide`, `file-editing-discipline`, `frontend-admin-consistency`, `security-sanity-checklist`, `responsive-navigation-checklist`, `webdesign-guidelines`, `visual-hierarchy-guide`, `typography-and-spacing-guide`, `layout-consistency-guide`, `buttons-cards-forms-guide`, `image-and-media-guidelines`, `visual-quality-score`, `final-site-coherence-checklist` ;
  - 10 templates : `site-map-audit`, `navigation-report`, `menu-footer-report`, `duplicate-report`, `file-change-plan`, `ux-correction-plan`, `webdesign-audit`, `visual-quality-checklist`, `design-system-consistency`, `final-coherence-report` ;
  - 7 scripts non destructifs : `scan-navigation-patterns`, `scan-footer-patterns`, `scan-duplicate-links`, `scan-orphan-pages`, `scan-hardcoded-navigation`, `scan-visual-consistency-patterns`, `create-site-ux-report` ;
  - **score cohérence + score visuel** sur 100 chacun ;
  - délégations explicites vers `premium-webdesigner` (refonte créative) et `production-auditor` (audit production profond) ;
  - 3 modes d'exécution : Mode 1 (audit-only, défaut), Mode 2 (corrections sûres), Mode 3 (plan de refonte avec validation) ;
  - **public-ready** : aucune référence privée, signature minimale "Created by João de Almeida".
- 4 docs publiques : `site-ux-guardian-how-to-use.md`, `site-ux-guardian-examples.md` (10 prompts), `site-ux-guardian-webdesign-guidelines.md`, `article-section-site-ux-guardian.md`.
- 7 exemples : `example-menu-footer-consistency`, `example-admin-front-consistency`, `example-route-and-link-audit`, `example-duplicate-components-cleanup`, `example-wordpress-like-site-audit`, `example-saas-dashboard-ux-audit`, `example-webdesign-guidelines-audit`.
- `reports/site-ux-guardian-self-audit.md` : auto-application en mode audit-only.

### Changed
- `README.md` : nouvelle section pour `site-ux-guardian` (avec note "public-ready"), structure du repo mise à jour, roadmap réordonnée.
- `install.sh` / `uninstall.sh` : aucune modification — multi-skill auto-détecte.

### Fixed
- `site-ux-guardian/scripts/scan-navigation-patterns.sh` + `scan-footer-patterns.sh` : initialisation explicite des arrays associatifs + garde sur array vide. Corrige `unbound variable` quand `set -euo pipefail` rencontre un dossier sans fichiers UI à scanner.

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
