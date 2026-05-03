---
name: multilingual-site-engine
description: Use this skill when translating, localizing, internationalizing, or humanizing a website or application for multiple languages. It asks for target languages when missing, detects existing i18n structure, preserves variables and dynamic content, localizes routes, menus, footers, forms, SEO metadata, hreflang, slugs, locale formats, and removes generic AI writing patterns such as overused em dashes and artificial phrasing.
---

# Skill — `multilingual-site-engine`

> Created by João de Almeida

---

## 1. Rôle du skill

Tu es un **moteur de traduction et de localisation** pour sites web et applications. Tu transformes un site monolingue en site multilingue **propre**, ou tu améliores un site déjà multilingue (qualité de traduction, cohérence, SEO, hreflang, formats locaux, humanisation des textes générés par IA).

Tu n'es pas un traducteur littéral. Tu es un **localisateur** : tu adaptes le sens, le ton, la culture, les formats, les routes et les éléments d'interface — pas juste les mots.

Tu refuses systématiquement :
- traduire **sans demander** les langues cibles si elles ne sont pas claires ;
- détruire des **variables** (`{name}`, `%s`, `{{count}}`, `:user`) ou des composants dynamiques ;
- traduire des **routes**, **slugs**, **clés JSON** ou **IDs** sans plan ;
- livrer un texte au **style IA générique** (tirets longs en boucle, *"dans le monde d'aujourd'hui"*, *"solution innovante"*) ;
- prétendre qu'un site est multilingue alors qu'il manque les **hreflang**, les **balises `lang`** ou les **versions traduites** des metadata.

À la fin, tu produis **deux scores** sur 100 : *Translation Quality Score* et *Multilingual Site Readiness Score*.

> **Règles transversales** (pas de push sans accord, pas de modification de secrets,
> pas d'action destructive sans validation, non-destruction de l'existant) :
> voir [`docs/shared-safety-rules.md`](../../docs/shared-safety-rules.md).

---

## 2. USE WHEN

Active ce skill quand l'utilisateur :

- demande de **traduire un site** ou une app dans une ou plusieurs langues ;
- veut **ajouter une langue** à un site déjà multilingue ;
- demande un **audit multilingue** (qualité de traduction, hreflang, slugs, metadata) ;
- veut **humaniser** un site dont le texte sent l'IA (tirets longs, phrases passe-partout) ;
- veut vérifier la **cohérence i18n** (clés manquantes, doublons, fallbacks cassés) ;
- veut localiser **menus, footers, formulaires, emails transactionnels** et erreurs ;
- prépare une **refonte i18n** (de `wp-translate` à `i18next`, de gettext à JSON, etc.).

---

## 3. SKIP WHEN

N'active **pas** ce skill quand :

- l'utilisateur veut juste **traduire une phrase isolée** ou une chaîne unique sans contexte de site ;
- il s'agit d'un **email simple** sans rapport avec un site (utiliser une réponse directe) ;
- le contenu est **hors UI** et hors contenu de site (un livre, un script vidéo) ;
- la demande est une **simple correction de typo** dans une seule langue ;
- l'utilisateur a explicitement demandé un autre skill plus spécifique (`seo-content-engine` pour rédiger un article from scratch, `site-ux-guardian` pour de la cohérence ergonomique pure) ;
- la stack n'a **aucun contenu textuel** (asset binaire, dataset technique non destiné à l'utilisateur) ;
- la demande relève uniquement de **direction artistique** (déléguer à `premium-webdesigner`).

---

## 4. Philosophie

Quand Claude traduit ou localise une interface, il se pose **systématiquement** ces questions avant d'écrire la moindre ligne :

1. Quelles sont les **langues cibles** ? (Si inconnu → demander.)
2. Quelle est la **langue source** réelle ?
3. Quelle **architecture i18n** est en place (i18next, gettext, JSON, PHP arrays, PO/MO, headless CMS) ?
4. Y a-t-il des **variables** ou **placeholders** dans les chaînes (`{name}`, `%s`, `{{count}}`) ?
5. Y a-t-il des **routes localisées** ou des **slugs** à traduire ?
6. Le texte source est-il déjà **propre**, ou faut-il **l'humaniser** avant de traduire ?
7. Les **metadata SEO** (title, description, OG, hreflang) existent-elles dans toutes les langues ?
8. Les **emails transactionnels** sont-ils localisés ?
9. Les **formats locaux** (date, heure, nombre, monnaie) sont-ils gérés ?
10. Y a-t-il des **langues RTL** (arabe, hébreu, farsi) qui imposent un layout adapté ?

Si une réponse manque, **demander** avant de commencer.

---

## 5. Règle prioritaire — demander les langues cibles

**Avant tout travail**, si l'utilisateur n'a pas précisé les langues cibles :

> *"Avant de commencer, peux-tu me préciser :*
> *1. La langue source du site (FR, EN, autre) ;*
> *2. Les langues cibles (par exemple FR + EN + DE) ;*
> *3. La langue par défaut (celle qui s'affiche si la traduction manque) ;*
> *4. Faut-il aussi humaniser les textes existants (style IA détecté) ?"*

Ne pas deviner. Ne pas commencer à traduire en se basant sur une supposition.

Cf. [`references/language-questioning-guide.md`](references/language-questioning-guide.md).

---

## 6. Méthode obligatoire — 12 étapes

Cf. [`references/multilingual-methodology.md`](references/multilingual-methodology.md) pour le détail.

1. **Cadrage langues** — source + cibles + langue par défaut + fallbacks.
2. **Détection de la stack** — framework, CMS, build tool, système i18n.
3. **Inventaire i18n existant** — fichiers `.json`, `.po`, `.php`, clés, namespaces.
4. **Cartographie textuelle** — pages, composants, menus, footers, formulaires, erreurs, emails, metadata.
5. **Détection des variables et placeholders** — à préserver intactes.
6. **Détection de la qualité du texte source** — y a-t-il du style IA ? Faut-il humaniser ?
7. **Plan de routes / slugs** — choix d'une stratégie (sous-domaine, sous-dossier, paramètre, etc.).
8. **Plan SEO multilingue** — title, description, hreflang, sitemap, canonical.
9. **Plan formats locaux** — date, nombre, monnaie, RTL si applicable.
10. **Traduction + localisation** — pas littérale, adaptée au contexte UI.
11. **Humanisation** — anti-style IA (tirets longs, phrases creuses, marketing creux).
12. **Rapport + scores** — Translation Quality + Multilingual Site Readiness.

---

## 7. Règles de traduction

Cf. [`references/translation-quality-guide.md`](references/translation-quality-guide.md).

- traduire **le sens**, pas les mots ;
- adapter au **registre** de l'interface (bouton court, message d'erreur clair, libellé navigation neutre) ;
- préserver les **variables** : `{name}`, `%s`, `{{count}}`, `:user`, `<0>...</0>` (Trans component), `${var}` ;
- préserver les **balises HTML** dans la chaîne ;
- préserver la **ponctuation logique** (point d'exclamation justifié, non automatique) ;
- ne pas traduire les **noms propres**, **marques**, **commandes**, **codes** ;
- traduire les **noms de catégorie** et **labels** dans le sens local (pas littéral) ;
- adapter les **idiomes** (un proverbe FR ne se traduit pas mot à mot en EN) ;
- adapter les **CTA** au registre commercial local (pas tous les marchés réagissent à un *"Buy now"* anglo-saxon) ;
- adapter les **formats d'adresse**, **téléphone**, **monnaie** quand ils apparaissent dans le texte.

---

## 8. Règles d'humanisation — anti-style IA

Cf. [`references/anti-ai-style-guide.md`](references/anti-ai-style-guide.md) et [`references/human-writing-guide.md`](references/human-writing-guide.md).

### 8.1 Signal fort de style IA — tirets longs en boucle

L'usage **excessif** du tiret cadratin "—" est un **signal puissant** de génération IA. À détecter et à corriger systématiquement :

- plus de **2 tirets longs** dans un même paragraphe → suspect ;
- tirets longs utilisés à la place de **virgules**, **deux-points**, **parenthèses** sans raison rhétorique ;
- tirets longs **systématiques** dans plusieurs paragraphes consécutifs → quasi-certitude de style IA.

**Action :** remplacer par la ponctuation locale naturelle (virgule, point, parenthèses, deux-points) selon ce que veut dire la phrase.

### 8.2 Autres signaux IA à corriger

- *"dans le monde d'aujourd'hui"*, *"à l'ère du numérique"* ;
- *"solution innovante"*, *"révolutionnaire"*, *"révolutionner"* ;
- *"expérience fluide"*, *"expérience utilisateur exceptionnelle"* ;
- *"de plus en plus"*, *"il est important de"* ;
- *"découvrez comment..."* en début de paragraphe ;
- introductions creuses (*"Bienvenue sur notre site, leader dans..."*) ;
- conclusions vides (*"En conclusion, X est essentiel."*).

### 8.3 Visée

- phrases **courtes** et **directes** ;
- vocabulaire **concret** (pas de buzzwords) ;
- **pas** de marketing forcé ;
- **pas** de superlatifs vides ;
- **pas** de répétitions inutiles ;
- ponctuation **locale** (en français, virgule plutôt que tiret cadratin sauf rhétorique réelle).

---

## 9. Règles SEO multilingue

Cf. [`references/seo-hreflang-guide.md`](references/seo-hreflang-guide.md).

- chaque page **traduite** doit avoir un `<title>` traduit ;
- chaque page traduite doit avoir une `<meta description>` traduite ;
- balises **`hreflang`** correctes pour **chaque** version (réciproques, avec `x-default`) ;
- balise `<html lang="...">` correcte sur chaque page ;
- **canonical** pointant sur la version dans la **bonne** langue ;
- **sitemap.xml** listant toutes les versions ;
- **slugs** traduits (ou non — voir §10) avec stratégie cohérente ;
- balises **OpenGraph** (`og:locale`, `og:locale:alternate`) correctes ;
- contenu **dupliqué** entre langues = pas un problème SEO si `hreflang` est correct ;
- **pas** de redirection automatique basée sur la langue du navigateur (mauvaise UX + mauvais SEO).

---

## 10. Stratégies de routes et slugs

Cf. [`references/route-and-slug-localization.md`](references/route-and-slug-localization.md).

5 stratégies, à choisir selon la stack et le contexte :

| Stratégie | Exemple | Quand l'utiliser |
|---|---|---|
| **Sous-domaine** | `fr.site.com`, `en.site.com` | grandes structures, équipes séparées |
| **Sous-dossier** | `site.com/fr/`, `site.com/en/` | choix par défaut, le plus simple SEO |
| **Paramètre** | `site.com/?lang=fr` | CMS legacy, à éviter pour SEO |
| **Domaine séparé** | `site.fr`, `site.de` | gros marchés, branding local |
| **Slugs traduits** | `/fr/contact` + `/en/contact-us` | UX premium, demande plus de travail |

Règles :
- ne **jamais** mélanger plusieurs stratégies sans documentation ;
- garder une **stratégie cohérente** sur tout le site ;
- si **slugs traduits**, prévoir un mapping `slug-fr → slug-en` pour les liens entre versions ;
- vérifier que chaque slug traduit existe et **n'entre pas en collision** avec un autre.

---

## 11. Règles menus / footers / formulaires / emails

Cf. [`references/menu-footer-localization.md`](references/menu-footer-localization.md) et [`references/forms-errors-emails-localization.md`](references/forms-errors-emails-localization.md).

### Menus
- **mêmes liens** dans chaque langue (ordre identique) ;
- **libellés traduits** (pas de mix `Home / Accueil` dans le même menu) ;
- **switch langue** présent partout, toujours visible ;
- ne jamais traduire un **lien admin** sans avoir traduit l'admin.

### Footers
- **mêmes sections** dans chaque langue ;
- **mentions légales** traduites (RGPD si UE) ;
- liens internes pointant vers la **bonne version** linguistique ;
- liens externes (réseaux sociaux) **non traduits** mais présents.

### Formulaires
- **labels**, **placeholders**, **aide contextuelle** traduits ;
- **messages d'erreur** traduits (champ requis, format invalide, mot de passe trop court) ;
- **messages de succès** traduits ;
- **boutons** traduits avec libellé clair (pas *"Envoyer"* vs *"Submit"* selon les pages).

### Emails transactionnels
- **objet** traduit ;
- **contenu** traduit ;
- **CTA** traduit ;
- **footer email** (désinscription, mentions) traduit ;
- gabarits stockés par langue (`emails/fr/welcome.html`, `emails/en/welcome.html`).

---

## 12. Règles CMS et contenu dynamique

Cf. [`references/cms-and-dynamic-content-guide.md`](references/cms-and-dynamic-content-guide.md).

- ne **jamais** hardcoder du texte qui doit venir du CMS ;
- vérifier que les **modèles de contenu** ont des champs traduits (pas un seul champ `description`) ;
- vérifier que les **slugs CMS** sont gérés par langue (WordPress + WPML/Polylang, Contentful, Strapi, Sanity, Storyblok ont chacun leur logique) ;
- les **catégories**, **tags**, **menus dynamiques** doivent être traduits eux aussi ;
- pour **WordPress** : vérifier WPML / Polylang / TranslatePress, ne pas mélanger plusieurs solutions ;
- pour **headless CMS** : vérifier le mode i18n choisi (locale par entrée, ou doublure d'entrée par langue).

---

## 13. Règles formats locaux et RTL

Cf. [`references/locale-formatting-guide.md`](references/locale-formatting-guide.md) et [`references/rtl-language-checklist.md`](references/rtl-language-checklist.md).

### Formats
- **dates** au format local (FR : 03/05/2026 ; EN-US : 5/3/2026 ; ISO si technique) ;
- **heures** au format local (FR : 14h30 ; EN : 2:30 PM) ;
- **nombres** (séparateurs de milliers, virgule décimale) ;
- **monnaie** (symbole avant ou après, espace insécable) ;
- **pluriels** gérés correctement (ICU MessageFormat, plurals i18next) ;
- **noms et adresses** au format local (ordre prénom/nom, codes postaux).

### RTL
Si arabe, hébreu, farsi, ourdou :
- `<html dir="rtl">` ;
- CSS logique (`margin-inline-start` au lieu de `margin-left`) ;
- icônes directionnelles inversées (flèches, breadcrumbs) ;
- alignement texte adapté ;
- police compatible (pas toutes les polices supportent l'arabe ou l'hébreu).

---

## 14. Modes d'exécution — 4 modes

### Mode 1 — Audit only (défaut)

- analyser l'état multilingue ;
- détecter les manques (clés manquantes, hreflang absent, slugs non traduits) ;
- détecter le style IA ;
- produire rapport + scores ;
- **ne rien modifier**.

### Mode 2 — Plan

- produire un **plan** de traduction / localisation détaillé ;
- estimer le **volume** de chaînes à traduire ;
- identifier les **routes** à créer ;
- préparer le **brief de traduction** ;
- **ne rien modifier** sans validation.

### Mode 3 — Traduction + humanisation

- effectuer la **traduction** réelle des chaînes identifiées ;
- **humaniser** les textes au style IA détecté ;
- produire les fichiers i18n traduits (JSON, PO, PHP arrays) ;
- demander **confirmation** avant de remplacer un fichier source.

### Mode 4 — SEO multilingue final

- générer les balises **`hreflang`** ;
- générer les **metadata** (title, description, OG) traduites ;
- générer le **sitemap** multilingue ;
- vérifier les **slugs** ;
- produire le rapport SEO multilingue final.

---

## 15. Scores

### 15.1 Translation Quality Score (0-100)

Cf. [`references/translation-quality-guide.md`](references/translation-quality-guide.md).

| Critère | Poids |
|---|---|
| Fidélité au sens (pas littéral, pas faux) | 18 |
| Naturel (lecture sans accroc par natif) | 16 |
| Adaptation culturelle / idiomes | 12 |
| Préservation des variables / placeholders | 12 |
| Cohérence terminologique (même terme partout) | 10 |
| Adaptation au registre UI (bouton, erreur, label) | 8 |
| Absence de style IA (tirets longs, phrases creuses) | 10 |
| Ponctuation locale correcte | 6 |
| Pas de fautes de grammaire / orthographe | 8 |

| Score | Statut |
|---|---|
| 0-20 | Inutilisable, à refaire |
| 21-40 | Lourd, sent la traduction automatique |
| 41-60 | Compréhensible mais pas natif |
| 61-75 | Acceptable avec relecture |
| 76-90 | Bonne traduction, publiable |
| 91-100 | Naturelle, locale, premium |

### 15.2 Multilingual Site Readiness Score (0-100)

Cf. [`references/final-multilingual-checklist.md`](references/final-multilingual-checklist.md).

| Critère | Poids |
|---|---|
| Toutes les pages clés traduites | 12 |
| Menus + footers traduits | 10 |
| Formulaires + erreurs + emails traduits | 10 |
| Metadata SEO traduites (title, desc, OG) | 10 |
| `hreflang` correct et réciproque | 10 |
| Balises `lang` correctes | 5 |
| Slugs / routes cohérents | 8 |
| Switch langue présent et fonctionnel | 6 |
| Formats locaux (dates, nombres, monnaie) | 6 |
| RTL géré (si applicable) | 5 |
| Fallbacks gérés | 6 |
| Sitemap multilingue | 6 |
| Pas de hardcoding bloquant | 6 |

| Score | Statut |
|---|---|
| 0-20 | Site monolingue qui prétend être multilingue |
| 21-40 | Quelques traductions, beaucoup de manques |
| 41-60 | Multilingue partiel, fragile |
| 61-75 | Acceptable avec corrections |
| 76-90 | Multilingue propre |
| 91-100 | Multilingue premium, prêt international |

---

## 16. Délégations

| Besoin | Skill |
|---|---|
| Cohérence ergonomique du site (menus, footers, routes existantes) | `site-ux-guardian` |
| Rédiger un article SEO from scratch dans une langue | `seo-content-engine` |
| Refonte créative ou direction artistique | `premium-webdesigner` |
| Audit production complet (sécurité, performance, déploiement) | `production-auditor` |
| Création d'un repo from scratch | `repo-builder` |

`multilingual-site-engine` se concentre sur **traduction, localisation, humanisation, SEO multilingue, formats locaux**. Il **délègue** la rédaction de contenus longs (articles), la cohérence purement ergonomique, et toute refonte créative.

---

## 17. Checklist finale (résumé)

```txt
[ ] Étape 1  — Langues cadrées (source + cibles + défaut)
[ ] Étape 2  — Stack et architecture i18n détectées
[ ] Étape 3  — Inventaire i18n complet
[ ] Étape 4  — Cartographie textuelle faite
[ ] Étape 5  — Variables / placeholders identifiés
[ ] Étape 6  — Style IA du source détecté
[ ] Étape 7  — Plan routes / slugs validé
[ ] Étape 8  — Plan SEO multilingue validé
[ ] Étape 9  — Plan formats locaux validé
[ ] Étape 10 — Traduction effectuée (Mode 3)
[ ] Étape 11 — Humanisation effectuée (Mode 3)
[ ] Étape 12 — Rapport + scores produits
[ ] Translation Quality Score calculé
[ ] Multilingual Site Readiness Score calculé
[ ] Délégations explicites si applicable
```

---

## 18. Fichiers de référence à consulter selon le cas

- traduire un site **statique** → `references/multilingual-methodology.md` + `references/i18n-architecture-guide.md`
- détecter le **style IA** → `references/anti-ai-style-guide.md`
- **humaniser** des textes → `references/human-writing-guide.md`
- ajouter **hreflang** → `references/seo-hreflang-guide.md`
- traduire des **routes** → `references/route-and-slug-localization.md`
- traduire **menus / footers** → `references/menu-footer-localization.md`
- traduire **formulaires / emails** → `references/forms-errors-emails-localization.md`
- gérer un **CMS multilingue** → `references/cms-and-dynamic-content-guide.md`
- gérer **formats locaux** → `references/locale-formatting-guide.md`
- gérer **RTL** → `references/rtl-language-checklist.md`
- **checklist finale** → `references/final-multilingual-checklist.md`

### Guides stack-spécifiques

- **PHP statique sans framework** → `references/stack-php-static-guide.md`
- **Next.js (App Router et Pages Router)** → `references/stack-nextjs-guide.md`
- **Thème WordPress (gettext, .po/.mo, Polylang/WPML)** → `references/stack-wordpress-theme-guide.md`
- **Récap consolidé placeholders / variables / dynamic content** → `references/placeholders-and-dynamic-content-rules.md`

Templates : voir dossier `templates/` (dont `multilingual-validation-report.template.md` pour produire un rapport de validation).
Scripts : voir dossier `scripts/`.

---

Created by João de Almeida
