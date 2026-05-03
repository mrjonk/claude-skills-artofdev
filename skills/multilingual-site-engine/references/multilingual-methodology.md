# Méthode multilingue — `multilingual-site-engine`

Méthodologie complète en 12 étapes pour traduire et localiser un site ou une application.

Created by João de Almeida

---

## Vue d'ensemble

Traduire un site n'est **pas** copier les textes dans un traducteur. C'est :

1. comprendre la **stack** ;
2. comprendre les **textes** ;
3. comprendre l'**audience** ;
4. produire des fichiers traduits **propres** ;
5. brancher l'**infra SEO** multilingue ;
6. vérifier la **qualité**.

Court-circuiter une étape = produire un site multilingue **fragile** : clés manquantes, hreflang absent, slugs incohérents, traductions littérales, style IA non détecté.

---

## Étape 1 — Cadrage langues

Avant tout, clarifier :

- **langue source réelle** (parfois différente de la langue déclarée — un site `lang="fr"` peut avoir 30 % de contenu en anglais) ;
- **langues cibles** (combien, lesquelles, dans quel ordre de priorité) ;
- **langue par défaut** (celle qui s'affiche si la traduction manque) ;
- **locales régionales** (fr-FR vs fr-CH vs fr-BE, en-US vs en-GB) ;
- **fallbacks** (si `de-AT` manque, on tombe sur `de` ou sur la langue par défaut ?).

Si l'utilisateur n'a pas répondu à ces questions, **demander** avant de commencer.

---

## Étape 2 — Détection de la stack

Repérer :

- **framework** (PHP, WordPress, Laravel, React, Next.js, Vue, Nuxt, Astro, Svelte, Angular, Django, Flask, Rails) ;
- **CMS** (WordPress, Drupal, Strapi, Contentful, Sanity, Storyblok, Ghost, Hugo, Eleventy) ;
- **build tool** (Vite, Webpack, Turbopack, Parcel, Rollup) ;
- **système i18n** existant (i18next, react-intl, next-intl, vue-i18n, gettext, formatjs, custom).

Cette détection conditionne **tout** : on ne propose pas la même chose à un WordPress qu'à un Next.js App Router.

---

## Étape 3 — Inventaire i18n existant

Pour chaque type de système :

### JSON (i18next, next-intl, vue-i18n, react-intl)
- locales/{lang}/common.json ;
- locales/{lang}/{namespace}.json ;
- vérifier les clés manquantes avec un diff entre langues.

### gettext (PO/MO)
- /locale/{lang}/LC_MESSAGES/messages.po ;
- vérifier `msgid` / `msgstr` ;
- détecter les `fuzzy` (à relire).

### PHP arrays (Laravel, custom)
- resources/lang/{lang}/messages.php ;
- vérifier la cohérence des clés.

### YAML (Rails, Jekyll, Hugo)
- config/locales/{lang}.yml ;
- attention aux indentations.

### WordPress
- WPML (table `wp_icl_strings`) ;
- Polylang (post duplication) ;
- TranslatePress (overlay editor) ;
- ne **pas** mélanger plusieurs plugins.

### Headless CMS
- Contentful : locale par champ ;
- Sanity : doublure de document par locale ;
- Storyblok : multi-langue dans la même story ;
- Strapi : i18n plugin avec locale par entrée.

### Site statique
- pas de système → tout est hardcodé → préparer une extraction.

---

## Étape 4 — Cartographie textuelle

Lister **tous** les endroits où il y a du texte traduisible :

- **pages publiques** (home, about, contact, services, blog) ;
- **pages auth** (login, register, reset, MFA) ;
- **pages légales** (mentions, RGPD, CGV, cookies) ;
- **pages erreur** (404, 500, maintenance) ;
- **menus** (desktop, mobile, admin, footer) ;
- **footers** ;
- **formulaires** (labels, placeholders, aide, erreurs, succès) ;
- **boutons** et **CTA** ;
- **emails transactionnels** (welcome, reset password, invoice, notifications) ;
- **emails marketing** (si dans le scope) ;
- **metadata SEO** (title, description, OG, Twitter Card) ;
- **microcopies** (tooltips, badges, breadcrumbs, états vides) ;
- **messages d'erreur d'API** (si exposés à l'utilisateur) ;
- **notifications** (push, in-app, snackbar, toast) ;
- **bots / chatbots** (réponses pré-écrites).

Cf. `templates/i18n-file-plan.template.md`.

---

## Étape 5 — Détection des variables et placeholders

Avant de traduire, repérer **toutes** les variables :

| Pattern | Système |
|---|---|
| `{name}` | i18next, next-intl |
| `{{count}}` | Vue i18n, Mustache, Handlebars |
| `%s`, `%d`, `%1$s` | gettext, sprintf, PHP |
| `:user`, `:count` | Laravel |
| `${var}` | template literals JS |
| `<0>...</0>`, `<1>...</1>` | i18next Trans component |
| `<strong>...</strong>` | balises HTML inline |
| `[link]...[/link]` | BBCode-like |

**Règle absolue :** ces patterns **ne se traduisent jamais**. Ils restent identiques dans toutes les langues.

---

## Étape 6 — Détection du style IA dans le source

Avant même de traduire, vérifier que le texte source est **propre**.

Si le source est généré par IA (signaux : tirets longs en boucle, phrases creuses), traduire fidèlement va **propager le bullshit** dans toutes les langues. Il faut :

1. signaler le problème ;
2. proposer une **humanisation** du source d'abord ;
3. ensuite traduire le texte humanisé.

Cf. `references/anti-ai-style-guide.md`.

---

## Étape 7 — Plan routes / slugs

Choisir une stratégie (cf. `route-and-slug-localization.md`) :

- sous-dossier (`/fr/contact`) ;
- sous-domaine (`fr.site.com`) ;
- domaine séparé (`site.fr`) ;
- paramètre (`?lang=fr`) ;
- slug traduit (`/fr/contact` + `/en/contact-us`).

Une seule stratégie pour tout le site. Documenter le choix.

---

## Étape 8 — Plan SEO multilingue

Préparer pour chaque page traduite :

- `<title>` traduit ;
- `<meta description>` traduite ;
- `hreflang` réciproques + `x-default` ;
- `<html lang>` correct ;
- `canonical` correct ;
- `og:locale` + `og:locale:alternate` ;
- entrée dans le sitemap multilingue.

Cf. `references/seo-hreflang-guide.md`.

---

## Étape 9 — Plan formats locaux

Lister les endroits où apparaissent :

- **dates** (formats par locale) ;
- **heures** ;
- **nombres** (séparateur de milliers, décimales) ;
- **monnaie** (symbole, position, espace) ;
- **adresses** (ordre des champs) ;
- **téléphones** (préfixes internationaux) ;
- **pluriels** (ICU MessageFormat, plurals i18next).

Si une langue cible est **RTL** (arabe, hébreu, farsi, ourdou), prévoir l'adaptation directionnelle. Cf. `references/rtl-language-checklist.md`.

---

## Étape 10 — Traduction + localisation

Règles principales (cf. `references/translation-quality-guide.md`) :

- traduire le **sens**, pas les mots ;
- préserver les **variables** ;
- adapter au **registre UI** ;
- adapter les **idiomes** ;
- éviter le **calque** (anglicisme involontaire) ;
- maintenir une **terminologie cohérente** (si "panier" alors toujours "panier", pas alterner avec "caddie") ;
- éviter de traduire mot à mot un **CTA** d'une langue à l'autre (un *"Get started"* ne devient pas *"Obtenez commencé"*).

---

## Étape 11 — Humanisation

Cf. `references/human-writing-guide.md` et `references/anti-ai-style-guide.md`.

Pour chaque texte produit :

- compter les **tirets longs** (—) → si > 2 par paragraphe sans rhétorique réelle, remplacer ;
- détecter les **phrases creuses** (liste dans `anti-ai-style-guide.md`) ;
- raccourcir les **introductions** (max 3-4 phrases) ;
- éviter les **conclusions vides** (résumés inutiles) ;
- ajuster le **ton** (formel vs informel selon le pays).

---

## Étape 12 — Rapport + scores

Produire :

- liste des **fichiers** traduits / créés ;
- liste des **clés** ajoutées / modifiées ;
- liste des **slugs** créés ;
- balises **hreflang** générées ;
- détail des **humanisations** (avant / après) ;
- **Translation Quality Score** (0-100) ;
- **Multilingual Site Readiness Score** (0-100) ;
- **prochaine étape** (1 phrase actionnable).

Cf. `templates/final-multilingual-report.template.md`.

---

## Erreurs classiques à éviter

1. **Traduire sans demander les langues** → mauvaise piste.
2. **Traduire les clés JSON** → casse l'app.
3. **Traduire les variables** → casse l'interpolation.
4. **Hreflang non réciproque** → Google ignore les balises.
5. **Slugs hardcodés en anglais** dans une UI multilingue → mauvaise UX.
6. **Mélanger WPML + Polylang** → catastrophe.
7. **Redirection auto par `Accept-Language`** → mauvais SEO + mauvaise UX.
8. **Traduire littéralement les CTA** → conversion en chute libre.
9. **Tirets longs partout** → texte qui sent l'IA même après traduction.
10. **Ne pas traiter les emails transactionnels** → expérience cassée pour l'utilisateur étranger.

---

## Quand reboucler avec d'autres skills

| Cas | Skill |
|---|---|
| Le site est **incohérent ergonomiquement** avant traduction | `site-ux-guardian` |
| Il faut **rédiger** un nouvel article (pas traduire) | `seo-content-engine` |
| Il faut **refondre visuellement** pour gérer le RTL | `premium-webdesigner` |
| Il faut un **audit production complet** | `production-auditor` |

---

Created by João de Almeida
