# Méthode UX consistency — `site-ux-guardian`

Méthode complète **en 11 phases**. À dérouler **dans l'ordre** pour chaque audit.

Created by João de Almeida

---

## Vue d'ensemble

```
1. Stack       →  2. Pages       →  3. Menus       →  4. Footers
                       ↓
5. Cohérence   →  6. Doublons    →  7. Bons fichiers
                       ↓
8. Webdesign   →  9. Sécurité    →  10. Responsive
                       ↓
              11. Rapport + scores
```

---

## Phase 1 — Identifier la stack

**Objectif :** comprendre l'architecture du projet **avant** d'analyser quoi que ce soit.

À détecter :

- **framework** : PHP (Laravel, Symfony, custom), WordPress, React (Next/Remix/Vite), Vue (Nuxt), Svelte, Astro, Eleventy, ASP.NET WebForms ;
- **structure des pages** : `pages/`, `src/app/`, `templates/`, `views/`, `public/` ;
- **système de composants** : présence d'un dossier `components/`, `partials/`, `includes/` ;
- **routes** : router config (`routes/web.php`, `app/router.tsx`, `pages/`, etc.) ;
- **layouts** : layout principal, layout admin, layout auth ;
- **CSS** : global vs spécifique, design tokens, framework CSS (Tailwind, Bootstrap, custom).

**Output :** une note de 5 lignes décrivant la stack.

---

## Phase 2 — Cartographier les pages

**Objectif :** lister toutes les pages du site, classées par type.

| Catégorie | Indices |
|---|---|
| **Pages publiques** | `pages/index.*`, `pages/about.*`, etc. |
| **Pages admin** | `admin/`, `dashboard/`, routes protégées |
| **Pages auth** | `login`, `register`, `password-reset` |
| **Pages légales** | `mentions`, `cgv`, `privacy`, `cookies` |
| **Pages blog / docs** | `blog/`, `docs/`, `articles/` |
| **Pages produit / service** | `products/`, `services/` |
| **Pages dynamiques** | routes paramétrées (`[slug]`, `:id`) |
| **Pages multilingues** | duplications `/fr/`, `/en/`, ou suffixes `-en` |
| **Pages orphelines** | présentes mais jamais liées (à vérifier) |

**Output :** tableau dans `templates/site-map-audit.template.md`.

---

## Phase 3 — Identifier les menus

**Objectif :** lister tous les menus, repérer leur source, vérifier leur cohérence.

À détecter :

- menu desktop (header) ;
- menu mobile (burger / drawer) ;
- menu admin (sidebar) ;
- menu utilisateur connecté (dropdown profil) ;
- menu utilisateur non connecté (CTA login) ;
- menu multilingue (switch langue) ;
- breadcrumbs ;
- quick actions (top-right toolbar) ;
- footer navigation.

Pour chaque menu :
- **fichier source** (composant ou template) ;
- **pages qui l'utilisent** ;
- **liens contenus** ;
- **incohérences** détectées.

**Output :** `templates/navigation-report.template.md`.

---

## Phase 4 — Identifier les footers

**Objectif :** lister tous les footers et vérifier leur uniformité.

À détecter :

- footer principal ;
- footer minimal (auth, checkout) ;
- footer admin ;
- footer mobile ;
- liens légaux (mentions, RGPD, CGV) ;
- liens sociaux ;
- CTA footer (newsletter ?) ;
- copyright (année dynamique ?) ;
- version / statut (si applicable).

**Output :** `templates/menu-footer-report.template.md`.

---

## Phase 5 — Vérifier la cohérence globale

Liste de questions à appliquer à chaque page :

- [ ] menu présent et cohérent ?
- [ ] menu mobile = menu desktop ?
- [ ] footer présent ?
- [ ] pages importantes accessibles depuis le menu ?
- [ ] liens du footer valides ?
- [ ] CTA cohérents (mêmes libellés, mêmes destinations) ?
- [ ] navigation admin présente sur les pages admin ?
- [ ] navigation auth adaptée (souvent minimale) ?
- [ ] page 404 / 500 avec retour utile ?
- [ ] langues cohérentes (mêmes pages, switch présent) ?
- [ ] toutes les routes liées **existent vraiment** ?

---

## Phase 6 — Détecter les doublons

Cf. [`duplicate-detection-guide.md`](duplicate-detection-guide.md).

Outils :
- `bash skills/site-ux-guardian/scripts/scan-duplicate-links.sh`
- `bash skills/site-ux-guardian/scripts/scan-hardcoded-navigation.sh`

À chercher :
- composants doublonnés (`HeaderV2`, `NewFooter`) ;
- pages quasi identiques ;
- fichiers obsolètes (`.bak`, `.old`, `_v2`) ;
- CSS redondant ;
- routes concurrentes.

---

## Phase 7 — Vérifier les bons fichiers

Cf. [`file-editing-discipline.md`](file-editing-discipline.md).

**Avant chaque modification**, identifier le **fichier exact** :

- est-ce un layout global ou une page locale ?
- est-ce un composant partagé ?
- est-ce un fichier généré (à ne pas toucher) ?
- est-ce un fichier vendor / build / minifié (à ne pas toucher) ?

**Règle absolue :** modifier le **composant partagé**, pas 12 pages une par une.

---

## Phase 8 — Vérifier les webdesign guidelines

Cf. [`webdesign-guidelines.md`](webdesign-guidelines.md). 14 axes (A à N) :

A. Hiérarchie · B. Lisibilité · C. Typographie · D. Spacing · E. Layout · F. Buttons · G. Cards · H. Formulaires · I. Tables · J. Images · K. Responsive · L. Cohérence globale · M. Accessibilité · N. Anti-template.

**Output :** `templates/webdesign-audit.template.md`.

---

## Phase 9 — Vérifier la sécurité basique

Cf. [`security-sanity-checklist.md`](security-sanity-checklist.md).

Signaler les évidents :
- admin non protégé ;
- routes debug visibles ;
- `.env` exposé ;
- clé API en front ;
- page privée indexable.

**Pour audit profond → déléguer `production-auditor`.**

---

## Phase 10 — Vérifier le responsive

Cf. [`responsive-navigation-checklist.md`](responsive-navigation-checklist.md).

Tester sur 4 breakpoints (320 / 768 / 1024 / 1440) :
- menu mobile fonctionnel ;
- pas d'overflow horizontal ;
- footer lisible ;
- tables admin scrollables ;
- CTA atteignables au pouce.

---

## Phase 11 — Produire le rapport final

Cf. [`../templates/final-coherence-report.template.md`](../templates/final-coherence-report.template.md).

Structure :
1. score global cohérence + score visuel ;
2. score par axe ;
3. résumé exécutif (5 lignes) ;
4. problèmes critiques / importants / mineurs ;
5. fichiers concernés ;
6. corrections appliquées (Mode 2) ;
7. corrections recommandées ;
8. délégations (`premium-webdesigner` ou `production-auditor`) ;
9. prochaine étape.

---

## Règle d'or

**Ne jamais corriger sans avoir cartographié.** Une correction faite sans vue d'ensemble crée plus de problèmes qu'elle n'en résout.

---

Created by João de Almeida
