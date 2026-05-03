# Self-audit — `multilingual-site-engine`

> Rapport d'auto-évaluation de la qualité du skill `multilingual-site-engine`.
> Created by João de Almeida

---

## Métadonnées

- **Date** : 2026-05-03
- **Version** : 0.1.0
- **Skill audité par** : Claude (revue interne)
- **Méthode** : revue de structure, cohérence avec la famille de skills, complétude des références, scripts, templates, exemples.

---

## Score global

```txt
┌─────────────────────────────────────┐
│                                     │
│  Score qualité skill : 88 / 100     │
│                                     │
│  Verdict : Solide — production-ready│
│                                     │
└─────────────────────────────────────┘
```

---

## Score par axe

| Axe | Poids | Score |
|---|---|---|
| Clarté du SKILL.md | 12 | 11 |
| Frontmatter conforme (description) | 6 | 6 |
| Couverture USE WHEN / SKIP WHEN | 6 | 6 |
| Méthode obligatoire structurée | 10 | 9 |
| Règles d'humanisation et anti-IA | 10 | 10 |
| Couverture i18n (frameworks, CMS) | 10 | 9 |
| Couverture SEO multilingue | 8 | 8 |
| Couverture formats locaux + RTL | 6 | 6 |
| Scores (Translation Quality + Site Readiness) | 6 | 6 |
| Scripts (lecture seule, conventions OK) | 6 | 5 |
| Templates utiles (placeholders réels) | 6 | 5 |
| Exemples concrets et exploitables | 8 | 7 |
| Délégations explicites | 6 | 6 |
| **Total** | **100** | **88** |

---

## Points forts

### Structure conforme à la famille de skills

- frontmatter `description` à la troisième personne, instructif ;
- pas de `version` ni `author` parasite (instructions à jour) ;
- même rythme que `site-ux-guardian` et `seo-content-engine` ;
- 14 références, 7 templates, 6 scripts — bon ratio orchestrabilité / profondeur.

### Règle prioritaire — demander les langues

Le skill commence **toujours** par cadrer les langues. Il ne traduit pas en aveugle. Cette règle est répétée dans le SKILL.md, dans le guide dédié, et dans tous les exemples.

### Détection du style IA

Le tiret cadratin abusif est identifié comme **signal majeur**, traité dans :

- une section dédiée du SKILL.md ;
- un guide complet (`anti-ai-style-guide.md`) ;
- un guide d'écriture humaine (`human-writing-guide.md`) ;
- un script de scan (`scan-ai-style-patterns.sh`) ;
- un template de rapport (`humanization-report.template.md`) ;
- un exemple concret (`example-humanize-ai-content.md`).

C'est cohérent et documenté de bout en bout.

### Couverture i18n large

Le guide d'architecture couvre :
- React, Next.js (Pages + App Router), Vue, Nuxt, Svelte, Astro ;
- Laravel, Symfony, Django, Rails ;
- WordPress (WPML, Polylang, TranslatePress) ;
- headless CMS (Contentful, Sanity, Strapi, Storyblok, Prismic) ;
- HTML statique pur ;
- migration entre systèmes.

### Préservation des variables

Le skill liste **tous** les patterns courants de variables et placeholders, et garantit leur préservation. C'est un piège classique évité.

### 4 modes d'exécution clairs

Audit / Plan / Traduction+humanisation / SEO final. Chaque mode est explicite, avec ses limites.

### Deux scores distincts

- Translation Quality (qualité textuelle) ;
- Multilingual Site Readiness (qualité de l'infrastructure i18n).

Les deux sont nécessaires et ne se confondent pas.

---

## Problèmes identifiés

### IMP-001 — Pas de script de validation hreflang

**Catégorie** : scripts
**Description** : un script `scan-hreflang.sh` qui crawl les pages rendues pour vérifier la réciprocité des hreflang serait utile. Actuellement, le skill explique **comment** vérifier mais ne fournit pas l'outil.
**Impact** : faible (l'audit reste possible manuellement, et `Screaming Frog` ou `Sitebulb` font ça mieux).
**Action** : à ajouter dans une v0.2.0.

### IMP-002 — Templates de fichiers de traduction absents

**Catégorie** : templates
**Description** : il n'y a pas de template `locales-en.json.template` ou équivalent qui servirait de squelette de fichier de traduction par bibliothèque.
**Impact** : faible (les templates sont propres aux projets).
**Action** : à voir si pertinent — peut-être trop générique pour être utile.

### MIN-001 — Le guide de routing ne donne pas d'exemple Next.js App Router avec `pathnames` next-intl

**Catégorie** : références
**Description** : la section "slug traduit" est générique. Un exemple précis avec next-intl `pathnames` serait éclairant.
**Impact** : faible (l'exemple `example-translate-saas-app.md` couvre partiellement).
**Action** : enrichir `route-and-slug-localization.md` en v0.2.0.

### MIN-002 — Pas d'exemple `.po` → `.json` côté script

**Catégorie** : scripts
**Description** : un script de conversion gettext → JSON serait pratique. Mais c'est un cas spécifique qui peut sortir du scope (chaque projet a ses contraintes).
**Impact** : faible.
**Action** : à reconsidérer.

---

## Couverture par cas d'usage

| Cas d'usage | Couvert |
|---|---|
| Traduire un site statique HTML | oui (exemple dédié) |
| Traduire Next.js App Router | oui (exemple dédié) |
| Traduire site PHP custom | oui (exemple dédié) |
| Traduire thème WordPress | oui (exemple dédié) |
| Traduire SaaS complet | oui (exemple dédié) |
| Humaniser site IA | oui (exemple dédié) |
| Audit SEO multilingue | oui (exemple dédié) |
| Migration de système i18n | référence couverte, pas d'exemple complet dédié |
| Localiser des emails | référence couverte (`forms-errors-emails-localization.md`) |
| Ajouter le RTL | référence couverte (`rtl-language-checklist.md`) |
| Formats locaux | référence couverte (`locale-formatting-guide.md`) |

---

## Cohérence avec les autres skills

- **vs `site-ux-guardian`** : différenciation explicite, bonne ;
- **vs `seo-content-engine`** : différenciation explicite ;
- **vs `premium-webdesigner`** : délégation pour RTL exotique ;
- **vs `production-auditor`** : délégation pour audit production complet.

Pas de chevauchement problématique.

---

## Public-ready

- aucune référence à `artofdev.space`, `jonk.space`, ou marque privée ;
- signature `Created by João de Almeida` partout ;
- pas de chemin absolu hardcodé (`/var/www/...`) hors instructions ;
- frontmatter conforme aux instructions Claude Code ;
- scripts non destructifs, lecture seule.

---

## Prochaine étape

> Tester le skill sur un projet réel (par exemple un Next.js bilingue), itérer sur les éventuels manques détectés en usage, et envisager une v0.2.0 avec un script de validation hreflang.

---

Created by João de Almeida
