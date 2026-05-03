# Examples

Cas d'usage des 7 skills de la collection.

> Created by João de Almeida

---

## Organisation

Les exemples sont triés par skill et par scénario. Chaque fichier contient une demande utilisateur réaliste, le comportement attendu du skill, le rapport produit (extrait), et les délégations recommandées.

### Statut

| Type | Description |
|---|---|
| **Exemples documentés** | scénarios écrits à partir de cas typiques. Pas nécessairement issus d'un runtime live. Servent de référence pédagogique. |
| **Fixtures de validation** | dans `examples/validation-fixtures/` : projets minimaux mais réalistes, prêts à être testés en runtime sur les skills v0.6+. |
| **Cas de routage** | `examples/skill-orchestrator-routing-test-cases.md` : 15 demandes utilisateur avec skill attendu et raisonnement. |

---

## Exemples par skill

### `repo-builder`
- [`example-static-site.md`](example-static-site.md)
- [`example-saas-app.md`](example-saas-app.md)
- [`example-mini-cms.md`](example-mini-cms.md)
- [`example-wordpress-plugin.md`](example-wordpress-plugin.md)
- [`example-automation-script.md`](example-automation-script.md)

### `production-auditor`
- [`example-audit-saas.md`](example-audit-saas.md)
- [`example-audit-mini-cms.md`](example-audit-mini-cms.md)
- [`example-audit-wordpress-site.md`](example-audit-wordpress-site.md)
- [`example-audit-admin-dashboard.md`](example-audit-admin-dashboard.md)
- [`example-audit-before-youtube-demo.md`](example-audit-before-youtube-demo.md)

### `premium-webdesigner`
- [`example-modern-saas-homepage.md`](example-modern-saas-homepage.md)
- [`example-premium-dashboard.md`](example-premium-dashboard.md)
- [`example-artistic-association-site.md`](example-artistic-association-site.md)
- [`example-corporate-agency-site.md`](example-corporate-agency-site.md)
- [`example-youtube-demo-interface.md`](example-youtube-demo-interface.md)
- [`example-before-after-redesign.md`](example-before-after-redesign.md)

### `seo-content-engine`
- [`example-technical-article.md`](example-technical-article.md)
- [`example-saas-blog-article.md`](example-saas-blog-article.md)
- [`example-product-page.md`](example-product-page.md)
- [`example-simple-tutorial.md`](example-simple-tutorial.md)
- [`example-content-audit.md`](example-content-audit.md)
- [`example-faq-section.md`](example-faq-section.md)

### `site-ux-guardian`
- [`example-menu-footer-consistency.md`](example-menu-footer-consistency.md)
- [`example-admin-front-consistency.md`](example-admin-front-consistency.md)
- [`example-route-and-link-audit.md`](example-route-and-link-audit.md)
- [`example-duplicate-components-cleanup.md`](example-duplicate-components-cleanup.md)
- [`example-wordpress-like-site-audit.md`](example-wordpress-like-site-audit.md)
- [`example-saas-dashboard-ux-audit.md`](example-saas-dashboard-ux-audit.md)
- [`example-webdesign-guidelines-audit.md`](example-webdesign-guidelines-audit.md)

### `multilingual-site-engine`
- [`example-translate-static-site.md`](example-translate-static-site.md)
- [`example-translate-nextjs-app.md`](example-translate-nextjs-app.md)
- [`example-translate-php-site.md`](example-translate-php-site.md)
- [`example-translate-wordpress-theme.md`](example-translate-wordpress-theme.md)
- [`example-translate-saas-app.md`](example-translate-saas-app.md)
- [`example-humanize-ai-content.md`](example-humanize-ai-content.md)
- [`example-multilingual-seo-audit.md`](example-multilingual-seo-audit.md)

### `skill-orchestrator`
- [`skill-orchestrator-routing-test-cases.md`](skill-orchestrator-routing-test-cases.md) — 15 cas de routage attendus

---

## Fixtures de validation (Phase 2 v1.0.0-rc1)

Projets minimaux destinés à tester les skills en runtime. Chaque fixture contient assez de fichiers pour exercer les règles principales du skill correspondant.

```
examples/validation-fixtures/
├── php-static-multilingual/        # multilingual-site-engine
├── nextjs-multilingual/            # multilingual-site-engine
└── wordpress-theme-multilingual/   # multilingual-site-engine
```

Voir le `README.md` de chaque fixture pour les conventions et le périmètre testé.

---

## Captures d'écran et placeholders

Pour les captures d'écran (avant/après audit, routing orchestrator, traduction multilingue, token optimization before/after), un dossier `assets/` est prévu à la racine du repo.

Tant que les vrais screenshots ne sont pas livrés :
- pas de lien cassé dans le README ;
- les emplacements sont décrits dans `assets/README.md` (brief créatif) ;
- les exemples documentés ne référencent pas d'image manquante.

---

## Comment contribuer un exemple

1. Reproduire la demande utilisateur exacte.
2. Documenter le skill activé, les délégations, les fichiers modifiés.
3. Inclure un extrait du rapport final (5-15 lignes).
4. Indiquer le score si le skill en produit un.
5. Préciser si l'exemple est issu d'un runtime réel ou d'une simulation.

Nommer le fichier `example-<scenario-court>.md`.

---

Created by João de Almeida
