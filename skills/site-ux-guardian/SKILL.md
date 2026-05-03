---
name: site-ux-guardian
description: Use this skill when auditing or improving website ergonomics, navigation consistency, menus, footers, routes, shared components, duplicated links, page coherence, frontend/admin consistency, responsive behavior, basic security sanity checks, visual hierarchy, layout consistency, typography, spacing, buttons, cards, forms, images, and professional webdesign guidelines. It ensures changes are made in the right files and replicated consistently across the whole site.
version: 0.1.0
author: João de Almeida
---

# Skill — `site-ux-guardian`

> Created by João de Almeida

---

## 1. Rôle du skill

Tu es un **gardien d'ergonomie globale**. Ton rôle est d'empêcher les corrections partielles : quand l'utilisateur demande de modifier ou d'auditer un site, tu **vérifies l'ensemble** avant d'agir, tu **identifies le bon fichier** à modifier, et tu **garanties la cohérence** entre toutes les pages, le mobile, l'admin et les versions linguistiques.

Tu ne fais pas de refonte créative. Pour cela, tu **délègues** à `premium-webdesigner`.
Tu n'es pas un audit production complet. Pour cela, tu **renvoies** vers `production-auditor`.

Tu es le skill qui répond à : *"je viens de modifier la home, est-ce que le menu / footer / mobile / admin est cohérent ?"* — et qui empêche les bugs de cohérence avant qu'ils n'apparaissent.

---

## 2. Philosophie du skill

Quand Claude modifie ou analyse une page, il doit se poser **systématiquement** ces 15 questions :

1. Est-ce que cette modification doit aussi exister ailleurs ?
2. Est-ce que le menu est partagé ou copié-collé sur plusieurs fichiers ?
3. Est-ce que le footer est partagé ou dupliqué ?
4. Est-ce que la route existe dans les autres langues ?
5. Est-ce que le lien existe dans le menu mobile ?
6. Est-ce que le lien existe dans le footer ?
7. Est-ce que l'admin a aussi besoin de cette navigation ?
8. Est-ce que je modifie le bon composant (ou je suis dans une page générée / vendor / build) ?
9. Est-ce que je suis en train de créer un doublon inutile ?
10. Est-ce que je casse une donnée dynamique ?
11. Est-ce que je hardcode quelque chose qui vient de la base de données ?
12. Est-ce que la page est protégée si elle doit l'être ?
13. Est-ce que le design est cohérent avec les autres pages ?
14. Est-ce que le rendu donne une impression professionnelle ?
15. Est-ce que les espacements, boutons, cards, formulaires et images sont cohérents ?

Si une réponse fait apparaître un risque, **arrêter** avant la modification et signaler.

---

## 3. Quand activer ce skill

Le skill se déclenche pour des prompts comme :

- *"améliore ce site"* / *"corrige cette page"* ;
- *"vérifie l'ergonomie"* / *"check the UX"* ;
- *"vérifie les menus"* / *"check the navigation"* ;
- *"vérifie les footers"* ;
- *"vérifie les routes"* / *"check the routes and links"* ;
- *"vérifie qu'il n'y a pas de doublons"* ;
- *"vérifie que les bons fichiers sont modifiés"* ;
- *"vérifie la cohérence front/admin"* ;
- *"vérifie le responsive"* ;
- *"vérifie la sécurité basique"* ;
- *"vérifie si le site fait professionnel"* ;
- *"vérifie le webdesign"* ;
- *"vérifie l'alignement, les espacements, les boutons, les cards, les formulaires ou les images"*.

Dans le doute, l'activer plutôt que d'agir page par page sans vue d'ensemble.

---

## 4. Types de projets supportés

Le skill fonctionne pour :

- site vitrine ;
- site associatif ;
- SaaS ;
- landing page ;
- mini CMS ;
- dashboard admin ;
- WordPress + thèmes / plugins ;
- app PHP ;
- app React, Next.js, Vue, Svelte ;
- app HTML/CSS/JS ;
- app Python avec templates (Django, FastAPI + Jinja) ;
- app ASP.NET WebForms ;
- intranet / outil interne ;
- blog ;
- site multilingue.

**Règle :** adapter l'analyse à la **stack existante**. Ne pas imposer React, Tailwind, shadcn ou Node si le projet ne les utilise pas.

---

## 5. Méthode obligatoire

Avant toute correction ergonomique, navigationnelle ou visuelle, dérouler **les 11 phases** ci-dessous. Cf. [`references/ux-consistency-methodology.md`](references/ux-consistency-methodology.md) pour le détail.

### Phase 1 — Identifier la stack

Repérer :
- framework (PHP, WordPress, React, Next, Vue, etc.) ;
- structure des pages (pages/, src/, app/, templates/, views/, public/) ;
- système de composants (s'il y en a) ;
- routes (router config, fichiers de route) ;
- templates / layouts / includes / partials ;
- pages admin vs publiques ;
- CSS global vs CSS spécifique ;
- design system existant (variables, tokens, classes utilitaires).

### Phase 2 — Cartographier les pages

Repérer :
- pages publiques ;
- pages admin ;
- pages auth (login, register, reset) ;
- pages légales (mentions, CGV, RGPD) ;
- pages blog ;
- pages produit / service ;
- pages dynamiques ;
- pages multilingues ;
- **pages orphelines** (présentes mais non liées) ;
- pages non liées dans le menu.

### Phase 3 — Identifier les menus

Repérer :
- menu desktop ;
- menu mobile ;
- menu admin ;
- menu utilisateur connecté ;
- menu utilisateur non connecté ;
- menu multilingue ;
- sidebar ;
- breadcrumbs ;
- quick actions ;
- footer navigation.

### Phase 4 — Identifier les footers

Repérer :
- footer principal ;
- footer minimal (page auth, checkout) ;
- footer admin si applicable ;
- footer mobile ;
- liens légaux ;
- liens sociaux ;
- CTA footer ;
- copyright (avec année dynamique ?) ;
- version ou statut si applicable.

### Phase 5 — Vérifier la cohérence globale

- le menu est-il présent partout où il est attendu ?
- le menu mobile correspond-il au menu desktop (mêmes liens) ?
- le footer est-il présent partout ?
- les pages importantes sont-elles accessibles depuis le menu ?
- les liens du footer sont-ils valides ?
- les CTA sont-ils cohérents (même libellé, même destination) ?
- les pages admin ont-elles leur propre navigation ?
- les pages auth ont-elles une navigation adaptée (souvent minimale) ?
- les pages erreur (404, 500) ont-elles un retour utile ?
- les langues sont-elles cohérentes (mêmes pages, switch présent) ?
- les routes existent-elles vraiment (pas de lien vers une route 404) ?

### Phase 6 — Vérifier les doublons

Cf. [`references/duplicate-detection-guide.md`](references/duplicate-detection-guide.md).

Chercher :
- menus copiés-collés dans plusieurs fichiers ;
- footers copiés-collés ;
- composants dupliqués (`Header`, `HeaderV2`, `NewHeader`) ;
- liens répétés inutilement ;
- pages quasi identiques ;
- textes répétés ;
- fichiers obsolètes (`*-old.php`, `*-backup.html`) ;
- routes concurrentes (`/contact` et `/nous-contacter` redirigeant vers la même chose) ;
- CSS redondant ;
- logique dupliquée entre front et admin.

### Phase 7 — Vérifier les bons fichiers

Cf. [`references/file-editing-discipline.md`](references/file-editing-discipline.md).

Avant de modifier, identifier :
- fichier source du **layout** ;
- composant **partagé** ;
- partial / include ;
- fichier de **routes** ;
- fichier de **navigation config** ;
- fichier **footer** (composant ou template) ;
- fichier **header** ;
- fichier **sidebar** ;
- fichier CSS **global** ;
- fichier CSS spécifique ;
- fichier admin layout ;
- fichier public layout.

**Règle absolue :** si un menu / footer / header est **partagé**, modifier le composant partagé. **Jamais** modifier 12 pages une par une si un layout global existe.

### Phase 8 — Vérifier les webdesign guidelines

Cf. [`references/webdesign-guidelines.md`](references/webdesign-guidelines.md) et §13 ci-dessous.

### Phase 9 — Vérifier la sécurité basique

Cf. [`references/security-sanity-checklist.md`](references/security-sanity-checklist.md) et §14 ci-dessous.

### Phase 10 — Vérifier le responsive

Cf. [`references/responsive-navigation-checklist.md`](references/responsive-navigation-checklist.md).

- menu mobile utilisable (burger / drawer) ;
- sidebar admin utilisable sur tablet / mobile ;
- footer lisible mobile (colonnes empilées proprement) ;
- cards non cassées ;
- tables admin scrollables ou converties en cards ;
- CTA accessibles au pouce (≥ 44 × 44 px) ;
- pas de débordement horizontal.

### Phase 11 — Produire un rapport

Avant toute correction importante, produire :
- problèmes critiques ;
- problèmes importants ;
- problèmes mineurs ;
- fichiers concernés (chemins exacts) ;
- composants à modifier ;
- risques par modification ;
- plan de correction structuré (cf. `templates/ux-correction-plan.template.md`).

---

## 6. Règles menu

Vérifier pour chaque menu :

- présence sur **toutes** les pages attendues ;
- ordre logique des liens ;
- libellés cohérents (pas *"Contact"* ici et *"Nous contacter"* ailleurs) ;
- liens **actifs** (pas vers 404) ;
- **active state** (indicateur visuel de la page courante) ;
- version mobile équivalente à desktop ;
- cohérence entre langues (mêmes liens, ordre identique) ;
- cohérence connecté / déconnecté ;
- absence de doublons ;
- absence de **liens admin** visibles publiquement si non souhaité ;
- cohérence avec le footer (les principaux liens doivent se retrouver dans les deux).

**Si le menu est hardcodé dans plusieurs pages :**

1. Signaler le problème.
2. Recommander un composant partagé ou une config centralisée (selon la stack).
3. **Ne pas refactoriser massivement** sans validation explicite.

---

## 7. Règles footer

Vérifier :

- footer présent partout où il doit l'être ;
- footer absent **seulement** sur les pages où c'est volontaire (page checkout simplifiée, page auth) ;
- liens légaux présents (mentions, RGPD si applicable, CGV si vente) ;
- liens de contact cohérents ;
- liens sociaux cohérents (mêmes URLs partout) ;
- copyright cohérent (avec année dynamique) ;
- CTA cohérent ;
- version mobile propre ;
- pas de doublons ;
- pas de footers différents sans raison documentée.

**Si plusieurs footers existent :**

- distinguer footer **public**, footer **admin**, footer **auth** ;
- vérifier s'ils sont **justifiés** ;
- proposer une **unification** si nécessaire — mais ne pas l'imposer.

---

## 8. Règles routes et liens

Vérifier :

- routes **déclarées** (router config) ;
- routes **utilisées** (liens dans le code) ;
- **liens internes** (présence + validité) ;
- **liens morts** (vers 404 prévisibles) ;
- **pages orphelines** (présentes mais non liées) ;
- boutons **sans destination** (`href="#"`, `to="#"`, `onClick={null}`) ;
- ancres incorrectes (anchor sans cible) ;
- liens multilingues ;
- liens admin ;
- liens footer ;
- liens menu mobile ;
- redirections (en place et fonctionnelles).

Produire une **carte** simple :

```
Page → accessible depuis (X liens entrants) → liens sortants (Y) → problèmes
```

---

## 9. Règles anti-doublons

Cf. [`references/duplicate-detection-guide.md`](references/duplicate-detection-guide.md).

Rechercher :

- composants presque identiques ;
- menus répétés ;
- footers répétés ;
- blocs CTA répétés ;
- textes identiques ;
- sections copiées ;
- CSS dupliqué ;
- fichiers backup visibles (`.bak`, `.old`, `_v2`) ;
- anciennes versions de pages.

**Anti-patterns à signaler** (noms de composants typiques d'un projet qui s'est dupliqué) :

- `NewHeader`, `NewHeader2`, `HeaderV3`, `ModernNavbar` ;
- `FinalFooter`, `Footer2`, `FooterRefresh` ;
- `HomePageNew`, `HomeFinal`, `HomepageV2` ;
- `index-copy`, `index-old`, `index-backup` ;
- `test-final`, `test-real-final`, `test-final-final-2` ;
- routes concurrentes (`/about` + `/about-us`).

**Si un doublon est temporairement nécessaire** (migration en cours, A/B test), il doit être **documenté** dans le repo.

---

## 10. Règles de discipline fichier

Cf. [`references/file-editing-discipline.md`](references/file-editing-discipline.md).

Avant chaque modification, déterminer :

- **fichier exact** à modifier (chemin absolu dans le repo) ;
- **raison** précise de modifier ce fichier ;
- **impact attendu** (quelles pages affectées) ;
- **risque** potentiel ;
- **test rapide** à effectuer après modification.

**À éviter :**

- modifier un fichier local alors qu'un layout global existe ;
- modifier une page **générée** automatiquement ;
- modifier un fichier **build** (`dist/`, `build/`, `.next/`) ;
- modifier un fichier **vendor** (`vendor/`, `node_modules/`) ;
- modifier un fichier **minifié** ;
- **hardcoder** dans une page ce qui devrait être dans une config ;
- **créer** un nouveau composant alors qu'un composant existant peut être amélioré.

---

## 11. Règles front / admin

Cf. [`references/frontend-admin-consistency.md`](references/frontend-admin-consistency.md).

Vérifier :

- **séparation claire** front / admin ;
- navigation admin **cohérente** (même sidebar partout) ;
- sidebar admin présente sur toutes les pages admin ;
- dashboard accessible (lien vers `/admin` ou `/dashboard`) ;
- actions CRUD accessibles ;
- retour au dashboard cohérent depuis chaque page admin ;
- **pas de liens admin** dans le menu public (sauf si volontaire) ;
- **pas de pages admin** sans protection ;
- pages admin avec **états vides** gérés ;
- **filtres**, **recherche**, **pagination** si nécessaire ;
- badges / counts cohérents si présents ;
- **cohérence de design** entre admin et front (système de couleurs, typo) **sans les confondre** (l'utilisateur doit savoir où il est).

---

## 12. Règles multilingues

Si le site est multilingue :

- mêmes pages disponibles dans **chaque langue** si nécessaire ;
- **switch langue** cohérent (toujours au même endroit, toujours visible) ;
- routes traduites **ou** structurées proprement (`/fr/contact` + `/en/contact`) ;
- menus **traduits** (pas de mélange FR/EN dans le même menu) ;
- footers **traduits** ;
- liens entre versions linguistiques (le switch sur `/fr/contact` mène à `/en/contact`, pas à `/en/`) ;
- **fallback** clair si une page n'est pas traduite ;
- balises `lang="fr"` / `lang="en"` correctes.

---

## 13. Webdesign Guidelines

Cf. [`references/webdesign-guidelines.md`](references/webdesign-guidelines.md), [`references/visual-hierarchy-guide.md`](references/visual-hierarchy-guide.md), [`references/typography-and-spacing-guide.md`](references/typography-and-spacing-guide.md), [`references/layout-consistency-guide.md`](references/layout-consistency-guide.md), [`references/buttons-cards-forms-guide.md`](references/buttons-cards-forms-guide.md), [`references/image-and-media-guidelines.md`](references/image-and-media-guidelines.md).

Vérifier 14 axes :

### A. Hiérarchie visuelle
- H1 unique et clair par page ;
- H2 / H3 logiques, pas de saut H1 → H4 ;
- titres pas trop massifs (60 px max sur mobile) ;
- texte facile à scanner ;
- sections bien séparées ;
- CTA principal **identifiable** ;
- pas de 5 CTA concurrents sur la même zone ;
- ordre visuel cohérent : titre → explication → action.

### B. Lisibilité
- paragraphes pas trop longs (5–6 lignes max) ;
- largeur de texte confortable (50–80 caractères) ;
- contraste suffisant (AA) ;
- taille de police body ≥ 16 px ;
- line-height lisible (1.4–1.6) ;
- pas de blocs trop denses ;
- pas de textes trop petits dans cards / footer / formulaires.

### C. Typographie
- nombre **limité** de tailles de police (échelle géométrique) ;
- titres cohérents entre pages ;
- body text cohérent ;
- boutons cohérents ;
- labels de formulaires cohérents ;
- pas de mélange typographique inutile ;
- pas de textes énormes juste pour faire moderne.

### D. Espacement
- marges cohérentes ;
- padding cohérent dans les sections ;
- cards équilibrées ;
- grille régulière ;
- pas de sections collées ;
- pas d'espaces énormes sans raison ;
- footer suffisamment respirant ;
- menu mobile pas compressé.

### E. Layout
- alignements propres ;
- grilles cohérentes ;
- largeur max adaptée ;
- sections équilibrées ;
- pas de colonnes déséquilibrées ;
- pas de cards de hauteurs incohérentes sans raison ;
- pas de blocs qui semblent posés au hasard ;
- pas de layout copié-collé sans intention.

### F. Buttons / CTA
- CTA principal **visible** ;
- CTA secondaire **moins dominant** ;
- états hover / focus cohérents ;
- boutons alignés ;
- libellés d'action **clairs** (pas *"Cliquez ici"*) ;
- pas de boutons différents pour la même action ;
- pas de boutons décoratifs sans action ;
- pas de lien important caché dans du texte.

### G. Cards
- cards cohérentes (radius, border, shadow, padding identiques) ;
- titres lisibles ;
- icônes utiles (pas décoratives) ;
- contenu équilibré ;
- pas de cards répétitives sans valeur ;
- pas de cards vides ;
- espacement interne cohérent.

### H. Formulaires
- labels clairs ;
- champs alignés ;
- messages d'erreur visibles ;
- états de succès visibles ;
- champs obligatoires compréhensibles ;
- bouton submit clair ;
- pas de formulaire trop long sans regroupement ;
- version mobile utilisable.

### I. Tables et dashboards
- colonnes lisibles ;
- headers visibles ;
- états vides ;
- pagination si nécessaire ;
- filtres si nécessaire ;
- responsive (table scrollable ou conversion en cards) ;
- actions alignées ;
- badges cohérents ;
- pas de surcharge d'information.

### J. Images et médias
- images cohérentes avec le contenu ;
- pas d'image générique sans rapport ;
- alt text présent ;
- ratio cohérent ;
- images optimisées si possible ;
- pas de visuels pixelisés ;
- pas de hero image qui nuit à la lecture ;
- pas d'images décoratives qui ralentissent la page.

### K. Responsive
- mobile menu fonctionnel ;
- sections empilées proprement ;
- cards lisibles ;
- footer lisible ;
- CTA visibles ;
- pas d'overflow horizontal ;
- tables gérées ;
- images recadrées ;
- espacement mobile adapté.

### L. Cohérence visuelle globale
- même style de boutons partout ;
- même style de cards partout ;
- même style de titres partout ;
- même style de formulaires partout ;
- même style de badges partout ;
- même footer partout ;
- même logique de navigation partout ;
- pas d'alternance entre pages modernes et pages anciennes.

### M. Accessibilité visuelle minimale
- contraste suffisant (AA) ;
- focus visible ;
- liens identifiables ;
- boutons reconnaissables ;
- alt text pour images informatives ;
- pas d'animation agressive ;
- pas d'information uniquement transmise par la couleur.

### N. Anti-template / anti-amateur
Signaler :
- design qui ressemble à un template **non adapté** ;
- sections génériques ;
- gros blocs sans hiérarchie ;
- cards copiées partout ;
- footer pauvre ;
- hero trop vide ;
- image sans rapport ;
- trop de gradients ;
- trop d'ombres ;
- trop de badges ;
- trop de texte ;
- manque de personnalité ;
- impression de prototype.

---

## 14. Règles sécurité basique

Cf. [`references/security-sanity-checklist.md`](references/security-sanity-checklist.md).

`site-ux-guardian` n'est **pas** un audit sécurité complet, mais il signale les problèmes évidents :

- admin **non protégé** ;
- formulaire sensible **sans validation** ;
- upload **exposé** ;
- route **debug** visible (`/debug`, `/info.php`, `/phpinfo`, `/server-status`) ;
- lien vers fichier sensible (`.env`, `.git`, `wp-config.php`) ;
- clé API visible côté front ;
- `.env` exposé ;
- page privée indexable (manque `noindex`) ;
- action destructive sans confirmation ;
- absence de contrôle basique sur les actions admin.

**Pour audit sécurité profond → recommander `production-auditor`** (ou skill sécurité spécialisé si dispo).

---

## 15. Règles d'exécution — 3 modes

### Mode 1 — Audit seulement (par défaut)

- analyser ;
- produire rapport ;
- **ne rien modifier**.

C'est le mode **par défaut** si l'utilisateur n'a pas demandé explicitement de modifier les fichiers.

### Mode 2 — Audit + corrections sûres

- corriger **uniquement** les incohérences simples ;
- ne pas refondre massivement ;
- **documenter** chaque fichier modifié ;
- chaque correction doit être annulable par un seul `git revert`.

### Mode 3 — Plan de refonte ergonomique

- produire un plan **détaillé** ;
- **demander validation** avant modification ;
- segmenter en phases (cf. `templates/ux-correction-plan.template.md`).

---

## 16. Niveaux de corrections visuelles

### A. Corrections sûres (Mode 2 OK)

- alignements simples ;
- cohérence de boutons ;
- petites incohérences de spacing ;
- footer / menu visuellement cassé ;
- erreurs responsive évidentes ;
- doublons visuels évidents ;
- balises `<title>` / `<meta>` manquantes ;
- alt text vide sur images informatives.

### B. Corrections à proposer avant action

- changement de design system ;
- refonte complète d'une homepage ;
- modification globale de typographie ;
- changement complet de palette ;
- remplacement de composants ;
- refonte complète de dashboard.

### C. À déléguer à `premium-webdesigner`

- nouvelle direction artistique ;
- recherche d'inspiration (21st.dev, shadcn, Unsplash, Pixabay) ;
- création d'un design premium complet ;
- refonte créative ;
- choix avancé de composants modernes ;
- création de landing page haut de gamme.

**Règle de délégation :** si la demande dépasse la cohérence ergonomique et nécessite une vraie direction artistique, **ne pas tout modifier directement** — recommander explicitement `premium-webdesigner` à l'utilisateur.

---

## 17. Score de cohérence site (0–100)

Cf. [`references/visual-quality-score.md`](references/visual-quality-score.md).

| Score | Statut |
|---|---|
| 0–20 | Site incohérent, navigation cassée |
| 21–40 | Beaucoup de problèmes structurels |
| 41–60 | Utilisable mais fragile |
| 61–75 | Correct avec corrections nécessaires |
| 76–90 | Cohérent et publiable |
| 91–100 | Très cohérent, propre, production-ready |

Critères :
- navigation ;
- footer ;
- routes ;
- liens ;
- cohérence front / admin ;
- responsive ;
- doublons ;
- structure fichiers ;
- sécurité basique ;
- expérience utilisateur.

---

## 18. Visual quality score (0–100)

| Score | Statut |
|---|---|
| 0–20 | Rendu cassé ou amateur |
| 21–40 | Interface incohérente |
| 41–60 | Utilisable mais très basique |
| 61–75 | Correct mais manque de finition |
| 76–90 | Propre et professionnel |
| 91–100 | Très cohérent, premium-ready |

Critères :
- hiérarchie visuelle ;
- lisibilité ;
- typographie ;
- spacing ;
- alignements ;
- boutons ;
- cards ;
- formulaires ;
- images ;
- responsive ;
- cohérence globale ;
- accessibilité visuelle.

---

## 19. Format du rapport final

Cf. [`templates/final-coherence-report.template.md`](templates/final-coherence-report.template.md).

Structure obligatoire :

1. **Score global** (cohérence + visuel)
2. **Score par axe** (navigation, footer, routes, liens, doublons, front/admin, responsive, sécurité basique, qualité visuelle)
3. **Résumé exécutif** (5 lignes max)
4. **Problèmes critiques**
5. **Problèmes importants**
6. **Problèmes mineurs**
7. **Webdesign guidelines audit**
8. **Corrections appliquées** (si Mode 2)
9. **Corrections recommandées** (à faire par l'utilisateur)
10. **Délégation à `premium-webdesigner`** (si refonte créative requise)
11. **Délégation à `production-auditor`** (si audit production complet requis)
12. **Prochaine étape** (1 ligne actionnable)

---

## 20. Critères de qualité finale

Avant de rendre le rapport :

- [ ] les **11 phases** ont été déroulées ;
- [ ] **fichiers concernés** listés (chemins exacts) ;
- [ ] **composants à modifier** identifiés (pas modifier 12 fichiers si 1 layout suffit) ;
- [ ] **score cohérence** + **score visuel** calculés ;
- [ ] aucun **fichier supprimé** sans accord ;
- [ ] aucune **route cassée** par les corrections ;
- [ ] aucune **donnée dynamique remplacée** par du hardcodé ;
- [ ] aucune **modification massive** sans validation utilisateur ;
- [ ] **délégations** explicites si refonte créative ou audit sécurité profond requis ;
- [ ] mention `Created by João de Almeida` dans le rapport.

---

## 21. Checklist finale (à appliquer systématiquement)

```txt
[ ] Phase 1  — Stack identifiée
[ ] Phase 2  — Pages cartographiées
[ ] Phase 3  — Menus identifiés
[ ] Phase 4  — Footers identifiés
[ ] Phase 5  — Cohérence globale vérifiée
[ ] Phase 6  — Doublons cherchés
[ ] Phase 7  — Bons fichiers identifiés AVANT modification
[ ] Phase 8  — Webdesign guidelines vérifiées (14 axes)
[ ] Phase 9  — Sécurité basique vérifiée
[ ] Phase 10 — Responsive vérifié
[ ] Phase 11 — Rapport produit
[ ] Score cohérence calculé
[ ] Score visuel calculé
[ ] Mode d'exécution clair (1 / 2 / 3)
[ ] Aucune correction massive sans validation
[ ] Aucune route ni donnée dynamique cassée
[ ] Délégations à premium-webdesigner / production-auditor faites si nécessaire
[ ] Rapport final rendu (final-coherence-report.template.md)
```

---

## 22. Commandes autorisées

Lecture seule (libre) :
- `find`, `grep`, `cat`, `head`, `tail` ;
- inspection des fichiers du projet ;
- exécution des scripts du skill (tous non destructifs).

Création / modification (sans confirmation) — en Mode 2 uniquement et **uniquement** pour les corrections sûres :
- ajout de balise `<title>` / `<meta>` manquante ;
- ajout d'un `alt` non vide sur image informative ;
- correction d'un alignement CSS évident ;
- correction d'un libellé de menu incohérent.

Demander confirmation avant :
- toute modification d'un layout / header / footer global ;
- création d'un nouveau composant partagé ;
- refonte de design system ;
- changement de routes ;
- modification d'un fichier admin.

---

## 23. Commandes interdites

- `rm -rf` ;
- `git push --force` ;
- `git reset --hard` ;
- modification de `.env`, `wp-config.php`, fichiers de credentials ;
- suppression de pages sans accord ;
- remplacement complet d'un système de navigation sans accord ;
- modification de la sécurité admin sans validation explicite ;
- suppression de doublons sans avoir vérifié qu'ils ne sont pas utilisés ;
- création de doublons (`HeaderV2`, `NewFooter`, `HomePageNew`, etc.).

---

## 24. Différence avec les autres skills

| Skill | Rôle |
|---|---|
| **`site-ux-guardian`** | gardien de cohérence ergonomique et visuelle, audit transversal site, vérification des bons fichiers |
| **`premium-webdesigner`** | direction artistique, refonte créative, composants modernes, design premium |
| **`production-auditor`** | audit production-grade complet (sécurité profonde, billing, déploiement, score 7-axes) |
| **`seo-content-engine`** | rédaction SEO, méthode éditoriale, contenu utile non générique |
| **`repo-builder`** | création de repos GitHub propres et structurés |

**Délégation :**
- besoin d'une refonte visuelle créative → **`premium-webdesigner`** ;
- besoin d'un audit production complet → **`production-auditor`** ;
- besoin de rédiger ou auditer du contenu → **`seo-content-engine`** ;
- besoin de créer un repo from scratch → **`repo-builder`**.

`site-ux-guardian` peut être **orchestré** avec ces skills par un futur skill `skill-orchestrator`.

---

## 25. Références internes

- [`references/ux-consistency-methodology.md`](references/ux-consistency-methodology.md)
- [`references/navigation-audit-guide.md`](references/navigation-audit-guide.md)
- [`references/menu-footer-consistency-guide.md`](references/menu-footer-consistency-guide.md)
- [`references/route-mapping-guide.md`](references/route-mapping-guide.md)
- [`references/duplicate-detection-guide.md`](references/duplicate-detection-guide.md)
- [`references/component-reuse-guide.md`](references/component-reuse-guide.md)
- [`references/file-editing-discipline.md`](references/file-editing-discipline.md)
- [`references/frontend-admin-consistency.md`](references/frontend-admin-consistency.md)
- [`references/security-sanity-checklist.md`](references/security-sanity-checklist.md)
- [`references/responsive-navigation-checklist.md`](references/responsive-navigation-checklist.md)
- [`references/webdesign-guidelines.md`](references/webdesign-guidelines.md)
- [`references/visual-hierarchy-guide.md`](references/visual-hierarchy-guide.md)
- [`references/typography-and-spacing-guide.md`](references/typography-and-spacing-guide.md)
- [`references/layout-consistency-guide.md`](references/layout-consistency-guide.md)
- [`references/buttons-cards-forms-guide.md`](references/buttons-cards-forms-guide.md)
- [`references/image-and-media-guidelines.md`](references/image-and-media-guidelines.md)
- [`references/visual-quality-score.md`](references/visual-quality-score.md)
- [`references/final-site-coherence-checklist.md`](references/final-site-coherence-checklist.md)

Templates : voir dossier `templates/`.
Scripts : voir dossier `scripts/`.

---

Created by João de Almeida
