# Skill — `site-ux-guardian` : garder un site cohérent, lisible et professionnel page après page

*Section éditoriale prête à intégrer dans un article public.*

---

## Le problème des corrections page par page

Quand on développe un site avec une IA, on tombe vite dans un piège classique :

- on demande *"corrige cette page"* — Claude corrige une page ;
- la modification ne s'applique pas aux 11 autres pages qui ont le même header copié-collé ;
- le footer dit toujours *"© 2022"* parce qu'il a été oublié ;
- le menu mobile a 4 liens, le menu desktop en a 5 ;
- une fonctionnalité ajoutée à `/admin/users` n'existe pas dans `/admin/orders` ;
- on a créé `HeaderV2.tsx` parce que c'était plus rapide que de modifier `Header.tsx`.

Le site **fonctionne**, mais il est **incohérent**.

Et l'incohérence se voit. Un visiteur perçoit immédiatement qu'un site n'a pas été pensé comme un tout.

## Pourquoi les menus et footers se désynchronisent

Trois raisons principales :

1. **Les composants ne sont pas partagés** : le menu est hardcodé dans 12 pages plutôt que dans un layout global. Chaque modification doit être répétée 12 fois — et l'oubli arrive vite.
2. **Personne ne vérifie l'ensemble** : on travaille page par page, sans vue d'ensemble. Quand on ajoute un lien dans le menu desktop, on oublie le mobile.
3. **Les variantes ne sont pas documentées** : il y a `<HeaderPublic />` et `<HeaderAdmin />` (légitime), mais aussi `<HeaderV2 />` et `<HeaderV3 />` (refonte abandonnée). Personne ne sait lequel est canonique.

## Pourquoi Claude peut modifier le mauvais fichier

Sans cadre, une IA modifie le **premier** fichier qui contient le pattern recherché — pas forcément le **bon**. Cas typiques :

- modifier une page individuelle alors qu'un layout global existe ;
- modifier un fichier généré (`dist/`, `build/`) qui sera écrasé au prochain build ;
- modifier un fichier vendor au lieu du code applicatif ;
- modifier un fichier minifié au lieu du source ;
- hardcoder dans une page ce qui devrait venir d'une config ou d'une DB.

Résultat : modifications qui **n'ont pas l'effet attendu**, ou qui **disparaissent** au prochain build.

## Pourquoi un site peut être fonctionnel mais visuellement incohérent

Trois cas fréquents :

1. **Plusieurs designs accumulés** : la home a un design 2024, la page services style 2018, le dashboard admin style 2020. Chaque section a été retravaillée à un moment différent sans harmonisation globale.

2. **Pas de design system** : pas de tokens centralisés (couleurs, typos, spacing). Chaque composant définit ses propres valeurs. Résultat : 5 styles de boutons, 3 nuances de bleu, 4 radius différents.

3. **Composants copiés** : pour gagner du temps, on copie une card qui marchait ailleurs. Avec un peu d'adaptation. Multiplié par 12 cards. Résultat : 12 variantes presque identiques mais toutes légèrement différentes.

## La solution : un Claude Skill qui regarde **tout le site**

`site-ux-guardian` est un Claude Skill qui **empêche les corrections partielles**.

Quand on lui demande d'auditer ou modifier un site, il déroule **11 phases** avant d'agir :

1. **Identifier la stack** (framework, structure, layouts) ;
2. **Cartographier les pages** (publiques, admin, auth, légales) ;
3. **Identifier les menus** (desktop, mobile, admin, switch langue) ;
4. **Identifier les footers** (principal, minimal, admin) ;
5. **Vérifier la cohérence globale** (menu = footer, liens valides, pages accessibles) ;
6. **Détecter les doublons** (`HeaderV2`, `NewFooter`, fichiers `.bak`) ;
7. **Identifier les bons fichiers** (layout global, composant partagé, partials) ;
8. **Vérifier les webdesign guidelines** (14 axes : hiérarchie, lisibilité, typo, spacing, etc.) ;
9. **Vérifier la sécurité basique** (admin protégé, `.env` non exposé, routes debug) ;
10. **Vérifier le responsive** (4 breakpoints) ;
11. **Produire un rapport** structuré avec scores et plan d'action.

## Comment il cartographie le site

Pour chaque page détectée, le skill produit une ligne :

```
| Page | Type | Route | Fichier source | Liens entrants | Liens sortants | Problème |
```

Puis il croise avec les **liens utilisés dans le code** pour détecter :

- les **pages orphelines** (présentes mais jamais liées) ;
- les **liens morts** (vers des routes 404) ;
- les **routes concurrentes** (`/about` + `/about-us`).

Le résultat : une **carte du site** complète, en quelques minutes.

## Comment il vérifie menus, footers, routes, doublons

Sept scripts d'analyse non destructifs :

- **`scan-navigation-patterns.sh`** : détecte tous les fichiers contenant un menu ;
- **`scan-footer-patterns.sh`** : détecte tous les footers, signale les copyrights statiques ;
- **`scan-duplicate-links.sh`** : détecte les liens internes répétés dans 5+ fichiers (signal de menu hardcodé) ;
- **`scan-orphan-pages.sh`** : détecte les pages présentes mais non liées ;
- **`scan-hardcoded-navigation.sh`** : détecte les fichiers contenant 4+ libellés de menu (probable hardcoding) ;
- **`scan-visual-consistency-patterns.sh`** : détecte les couleurs hardcodées, polices massives, gradients excessifs, alt vides, libellés de boutons vagues ;
- **`create-site-ux-report.sh`** : génère un rapport vide à remplir.

Tous **non destructifs**, **lecture seule**.

## Comment il vérifie les webdesign guidelines

14 axes vérifiés :

| Axe | Vérification |
|---|---|
| A. Hiérarchie visuelle | un H1, structure H2/H3, CTA dominant |
| B. Lisibilité | 16 px+, contraste AA, line-height 1.4–1.6 |
| C. Typographie | max 2 familles, 3 poids, échelle géométrique |
| D. Spacing | échelle géométrique respectée |
| E. Layout | grilles cohérentes, container max-width |
| F. Buttons / CTA | 3 variantes max, états hover/focus, libellés clairs |
| G. Cards | radius / border / shadow / padding cohérents |
| H. Formulaires | labels visibles, focus, erreurs localisées |
| I. Tables / dashboards | pagination, états vides, responsive |
| J. Images | cohérence, alt text, ratios, optimisation |
| K. Responsive | 4 breakpoints, no overflow horizontal |
| L. Cohérence globale | mêmes composants partout |
| M. Accessibilité visuelle | contraste, focus, alt |
| N. Anti-template / amateur | test du logo enlevé |

## Comment il protège les pages admin

Sans modifier la sécurité, le skill **signale** les problèmes évidents :

- pages admin **non protégées** par middleware d'auth ;
- formulaires sensibles **sans CSRF** ;
- routes debug visibles (`/info.php`, `/server-status`) ;
- `.env` accessible publiquement ;
- clé API en clair côté front ;
- pages privées **indexables** (manque `noindex`).

Pour audit sécurité **profond**, il **délègue** à `production-auditor`.

## Comment il complète un audit production

`site-ux-guardian` est **complémentaire** de `production-auditor` :

| | `site-ux-guardian` | `production-auditor` |
|---|---|---|
| Périmètre | cohérence ergonomique + visuelle | audit production complet |
| Sécurité | basique (signalements évidents) | profonde (CSRF, XSS, SQLi, billing) |
| Performance | non | oui (LCP, CLS, build) |
| Score | cohérence (0-100) + visuel (0-100) | 7 axes pondérés (Tech, UX, Sec, SEO, Admin, Billing, Deploy) |

→ **Workflow recommandé** : `site-ux-guardian` **AVANT** mise en prod, **puis** `production-auditor` pour validation finale.

## Exemple de prompt

```txt
Audite l'ergonomie globale du site.

Vérifie :
- menus (desktop, mobile, admin)
- footers (principal + variantes)
- routes (déclarées, utilisées, orphelines)
- doublons (HeaderV2, fichiers .bak, menus hardcodés)
- cohérence front/admin
- responsive 4 breakpoints
- sécurité basique (admin protégé, .env exposé)
- webdesign guidelines (14 axes)

Mode : audit only. Pas de modification.
Produire un rapport avec scores cohérence + visuel sur 100,
problèmes par sévérité, et plan d'action.
```

## Exemple de rapport attendu

```markdown
# Final coherence report — Mon Site

## Score global

- Cohérence site : 72 / 100
- Qualité visuelle : 68 / 100
- Verdict : Correct avec corrections nécessaires

## Top 3 actions immédiates

1. Centraliser le menu (actuellement hardcodé dans 8 fichiers).
2. Corriger l'overflow horizontal mobile sur /pricing.
3. Ajouter les pages légales (mentions, RGPD) absentes du footer.

## Problèmes critiques (4)

### CRIT-001 — Menu hardcodé dans 8 fichiers
Le scan-hardcoded-navigation.sh détecte 8 fichiers avec 5+ libellés de menu.
→ Recommander un composant partagé (Header.tsx).
→ Plan de migration phasé requis.

### CRIT-002 — Pages /admin sans protection
Aucun middleware d'auth détecté sur les routes admin.
→ Critique. Ajouter middleware avant publication.
→ Pour audit auth profond : `production-auditor`.

...

## Délégation recommandée

Pour la refonte créative du hero (score visuel 45/100 sur cet axe) :
**`premium-webdesigner`**.

Pour l'audit production complet (sécurité, billing, déploiement) :
**`production-auditor`** après corrections.
```

## La suite

`site-ux-guardian` se positionne comme **gardien de cohérence** dans une chaîne de skills :

- `site-ux-guardian` — vérification ergonomique et visuelle ;
- `premium-webdesigner` — direction artistique et refonte créative ;
- `production-auditor` — audit production-grade ;
- `seo-content-engine` — rédaction SEO ;
- `repo-builder` — création de repos propres.

Chacun garde son périmètre. Quand l'un dépasse son rôle, il **délègue** explicitement aux autres.

Le code source du skill est ouvert. Les règles, templates et scripts sont versionnés. Chacun peut l'adapter à son contexte.

---

Created by João de Almeida
