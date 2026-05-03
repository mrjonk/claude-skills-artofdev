# `site-ux-guardian` — README du skill

> Mode d'emploi du skill **`site-ux-guardian`**.
> Pour la définition formelle (règles, méthode, scoring, checklists), voir [`SKILL.md`](SKILL.md).

Created by João de Almeida

---

## À quoi sert ce skill

`site-ux-guardian` empêche les **corrections partielles** d'un site.

Quand tu modifies une page, le skill vérifie :

- est-ce que le **menu** est cohérent partout ?
- est-ce que le **footer** existe sur toutes les pages attendues ?
- est-ce que les **routes** marchent vraiment (pas de lien vers 404) ?
- y a-t-il des **doublons** de composants (`HeaderV2`, `NewFooter`) ?
- modifies-tu le **bon fichier** (le composant partagé, pas une copie locale) ?
- la **navigation admin** est-elle cohérente ?
- le **mobile** est-il fonctionnel (burger menu, responsive) ?
- la **sécurité basique** est-elle respectée (admin protégé, pas de `.env` exposé) ?
- les **webdesign guidelines** sont-elles tenues (typographie, spacing, hiérarchie, alignements) ?

À la fin, il produit **un score de cohérence + un score visuel** sur 100.

---

## Quand l'utiliser

Le skill se charge automatiquement pour des prompts comme :

- *"améliore ce site"* / *"corrige cette page"* ;
- *"vérifie l'ergonomie / les menus / les footers / les routes"* ;
- *"vérifie qu'il n'y a pas de doublons"* ;
- *"vérifie que les bons fichiers sont modifiés"* ;
- *"vérifie la cohérence front/admin"* ;
- *"vérifie le responsive / le webdesign"* ;
- *"vérifie l'alignement / les espacements / les boutons / les cards / les formulaires / les images"*.

Dans le doute, l'activer plutôt que d'agir page par page sans vue d'ensemble.

---

## Ce qu'il vérifie

### Cohérence ergonomique
- présence du menu sur toutes les pages attendues ;
- correspondance menu desktop ↔ menu mobile ;
- présence du footer ;
- liens internes valides ;
- pages orphelines ;
- pages multilingues cohérentes.

### Discipline fichier
- modification du composant partagé (pas 12 pages une par une) ;
- pas de modification de fichiers `vendor/`, `dist/`, `build/`, `node_modules/` ;
- pas de hardcoding qui devrait venir d'une config ou d'une DB.

### Anti-doublons
- détection de `HeaderV2`, `NewFooter`, `HomeFinal`, `index-copy`, `*-old.php`, etc. ;
- détection de menus / footers copiés-collés.

### Cohérence front / admin
- séparation claire ;
- navigation admin présente partout ;
- pages admin protégées ;
- liens admin pas exposés au public si non souhaité.

### Sécurité basique
- admin protégé ;
- pas de routes debug visibles ;
- pas de `.env` ou `wp-config.php` accessible ;
- pas de clé API en clair côté front.

### Responsive
- menu mobile fonctionnel ;
- pas d'overflow horizontal ;
- footer lisible mobile ;
- tables admin scrollables ou converties en cards.

### Webdesign guidelines (14 axes)
- hiérarchie visuelle (un H1, structure H2/H3) ;
- lisibilité (contraste AA, body 16 px+) ;
- typographie cohérente ;
- spacing cohérent (échelle géométrique) ;
- layout aligné, grilles cohérentes ;
- buttons cohérents (états hover / focus / active) ;
- cards cohérentes (radius, border, shadow, padding) ;
- formulaires utilisables (labels, validation, états) ;
- tables / dashboards (pagination, filtres, états vides) ;
- images cohérentes avec le contenu ;
- responsive sur 4 breakpoints ;
- cohérence visuelle globale ;
- accessibilité visuelle minimale ;
- détection de design template / amateur.

---

## Différences avec les autres skills

### vs `production-auditor`

| | `site-ux-guardian` | `production-auditor` |
|---|---|---|
| Périmètre | cohérence ergonomique + visuelle | audit production complet |
| Sécurité | basique (signaler les évidents) | profonde (auth, CSRF, XSS, SQLi, billing, webhooks) |
| Performance | non | oui (LCP, CLS, build) |
| Billing | non | oui |
| Déploiement | non | oui (HTTPS, headers, backups, monitoring) |

→ **Utiliser `site-ux-guardian` AVANT** de mettre en prod, **puis `production-auditor`** pour la validation finale.

### vs `premium-webdesigner`

| | `site-ux-guardian` | `premium-webdesigner` |
|---|---|---|
| Mission | gardien de cohérence | direction artistique |
| Méthode | 11 phases d'audit ergonomique | 6 phases de design (brief → 21st.dev → composants → DA → images → exécution) |
| Sources d'inspiration | non (vérifie l'existant) | oui (21st.dev, shadcn, Lucide, Motion) |
| Refonte créative | **non** (délègue) | oui |
| Score | cohérence + visuel | UI quality (visuel, UX, responsive, A11y, cohérence, premium feel) |

→ **Utiliser `site-ux-guardian` pour vérifier**, et **déléguer à `premium-webdesigner`** si refonte créative nécessaire.

---

## Comment il protège contre les corrections partielles

15 questions systématiques (cf. `SKILL.md §2`) :

1. Est-ce que cette modification doit aussi exister ailleurs ?
2. Le menu est-il partagé ou copié-collé ?
3. Le footer est-il partagé ou dupliqué ?
4. La route existe-t-elle dans les autres langues ?
5. Le lien existe-t-il dans le menu mobile ?
6. Le lien existe-t-il dans le footer ?
7. L'admin a-t-il besoin de cette navigation aussi ?
8. Suis-je en train de modifier le bon composant ?
9. Suis-je en train de créer un doublon inutile ?
10. Suis-je en train de casser une donnée dynamique ?
11. Suis-je en train de hardcoder ce qui devrait venir de la DB ?
12. La page est-elle protégée si elle doit l'être ?
13. Le design est-il cohérent avec les autres pages ?
14. Le rendu donne-t-il une impression professionnelle ?
15. Espacements / boutons / cards / formulaires / images sont-ils cohérents ?

Si une réponse fait apparaître un risque → **arrêter** avant la modification et signaler.

---

## Comment il vérifie menus et footers

1. **Cartographie** des fichiers contenant menu / footer (`scan-navigation-patterns.sh`, `scan-footer-patterns.sh`).
2. Détection de **menus hardcodés** dans plusieurs fichiers (`scan-hardcoded-navigation.sh`).
3. Vérification de **cohérence** entre desktop / mobile / admin / public.
4. Vérification des **liens** vers des routes existantes (`scan-orphan-pages.sh`).
5. Recommandation : utiliser un **composant partagé** plutôt que 12 copies.

---

## Comment il évite les doublons

Cf. [`references/duplicate-detection-guide.md`](references/duplicate-detection-guide.md).

- détection de patterns suspects : `HeaderV2`, `NewFooter`, `HomeFinal`, `*-old.*`, `*-backup.*` ;
- détection de menus / footers identiques copiés dans plusieurs fichiers ;
- détection de routes concurrentes (`/about` + `/about-us`) ;
- recommandation de **consolidation** (jamais imposée).

---

## Comment il vérifie les bons fichiers

Cf. [`references/file-editing-discipline.md`](references/file-editing-discipline.md).

Avant chaque modification, le skill détermine :

- **fichier exact** à modifier (chemin) ;
- **raison** de modifier ce fichier ;
- **impact** attendu (pages affectées) ;
- **risque** ;
- **test rapide** post-modification.

Évite :
- modification d'un fichier local quand un layout global existe ;
- modification d'un fichier généré, vendor, build, minifié ;
- hardcoding au lieu de config / DB.

---

## Comment il gère front / admin

- vérifie séparation claire ;
- vérifie navigation admin cohérente sur toutes les pages admin ;
- vérifie protection des pages admin ;
- vérifie qu'il n'y a pas de liens admin dans le menu public ;
- vérifie cohérence du design front / admin **sans les confondre** (l'utilisateur doit savoir où il est).

---

## Comment il gère la sécurité basique

`site-ux-guardian` n'est **pas** un audit sécurité complet, mais signale :

- admin non protégé ;
- formulaire sensible sans validation ;
- upload exposé ;
- routes debug visibles ;
- `.env` accessible ;
- clé API en clair ;
- page privée indexable ;
- action destructive sans confirmation.

→ Pour audit profond : **`production-auditor`**.

---

## Comment il vérifie les webdesign guidelines

14 axes (cf. `SKILL.md §13`) :
**A.** Hiérarchie visuelle · **B.** Lisibilité · **C.** Typographie · **D.** Espacement · **E.** Layout · **F.** Buttons · **G.** Cards · **H.** Formulaires · **I.** Tables / dashboards · **J.** Images · **K.** Responsive · **L.** Cohérence globale · **M.** Accessibilité visuelle · **N.** Anti-template / anti-amateur.

Score visuel sur 100.

---

## Exemples de prompts

### Audit complet (Mode 1 — lecture seule)

```txt
/site-ux-guardian Audite l'ergonomie globale du site. Vérifie menus, footers,
routes, doublons, cohérence front/admin, responsive, sécurité basique et
qualité visuelle. Ne modifie rien pour l'instant.
```

### Audit menu + footer

```txt
/site-ux-guardian Vérifie que le menu et le footer sont cohérents sur toutes
les pages, y compris mobile et admin. Signale les doublons et les fichiers à
corriger.
```

### Audit webdesign

```txt
/site-ux-guardian Audite l'ergonomie et la qualité visuelle globale du site.
Vérifie hiérarchie visuelle, typographie, spacing, layout, boutons, cards,
formulaires, images, responsive et cohérence design system.
```

### Audit + corrections sûres (Mode 2)

```txt
/site-ux-guardian Fais un audit UX de cohérence, puis corrige uniquement les
problèmes simples et sûrs. Ne refonds pas le site sans validation.
```

### Vérification de discipline fichier

```txt
/site-ux-guardian Vérifie que les changements ont été faits dans les bons
composants partagés et pas copiés page par page.
```

D'autres exemples détaillés dans [`../../examples/`](../../examples/).

---

## Ce qu'il ne fait jamais

- déplacer toute l'architecture sans accord ;
- supprimer des pages sans accord ;
- remplacer tout un système de navigation sans accord ;
- modifier la sécurité admin sans validation explicite ;
- casser des routes existantes ;
- remplacer des données dynamiques par du hardcodé ;
- créer des doublons (`HeaderV2`, `NewFooter`, etc.) ;
- faire une refonte créative complète sans validation ;
- agir comme un skill de direction artistique avancée ;
- pousser vers GitHub sans accord ;
- supprimer un fichier sans accord écrit.

---

## Comment l'améliorer plus tard

Le skill est un dossier — modifie-le directement :

1. ajuste `SKILL.md` (règles, méthode, scoring) ;
2. enrichis `references/` (nouveaux types de sites, nouvelles checklists) ;
3. ajoute des templates dans `templates/` ;
4. ajoute des scripts dans `scripts/` ;
5. relance `bash install.sh site-ux-guardian` à la racine du repo.

---

## Structure du skill

```txt
skills/site-ux-guardian/
├── SKILL.md
├── README.md
├── references/                              (18 fichiers)
├── templates/                               (10 fichiers)
└── scripts/                                 (7 fichiers)
```

---

Created by João de Almeida
