# Comment utiliser `multilingual-site-engine`

Guide pratique d'utilisation du skill **`multilingual-site-engine`**.

Created by João de Almeida

---

## En une phrase

`multilingual-site-engine` traduit, localise et humanise un site web ou une application — sans casser les variables, en branchant le SEO multilingue, en respectant les formats locaux, et en repérant les textes au style IA.

---

## Quand l'activer

Active-le pour :

- traduire un site dans une ou plusieurs langues ;
- ajouter une langue à un site déjà multilingue ;
- auditer la qualité d'une traduction existante ;
- humaniser un site dont les textes sentent l'IA ;
- vérifier hreflang, slugs, metadata multilingues ;
- préparer une refonte i18n (changement de bibliothèque) ;
- localiser les formats (date, monnaie, RTL).

N'active pas pour :

- traduire une seule phrase isolée ;
- rédiger un article from scratch (utiliser `seo-content-engine`) ;
- faire de la direction artistique (utiliser `premium-webdesigner`) ;
- une simple correction de typo.

---

## Cycle d'utilisation classique

### Étape 1 — Lancer le skill

```txt
/multilingual-site-engine [demande]
```

### Étape 2 — Le skill demande les langues

Si tu n'as pas précisé :

> *"Avant de commencer, peux-tu me préciser :*
> *1. La langue source ;*
> *2. Les langues cibles ;*
> *3. La langue par défaut ;*
> *4. Faut-il humaniser les textes existants au passage ?"*

Réponds avec ces 4 infos minimum.

### Étape 3 — Le skill détecte la stack

Il scanne automatiquement :

- `package.json` ;
- `composer.json` ;
- dossiers `locales/`, `messages/`, `lang/` ;
- présence de plugins WordPress (WPML, Polylang).

### Étape 4 — Le skill propose un mode

| Mode | Quand l'utiliser |
|---|---|
| **Mode 1 — Audit only** | savoir où en est le site, scores, sans modifier |
| **Mode 2 — Plan** | préparer un plan validé avant action |
| **Mode 3 — Traduction + humanisation** | exécution réelle |
| **Mode 4 — SEO multilingue final** | hreflang, sitemap, metadata, OG |

### Étape 5 — Production des livrables

Selon le mode :

- rapport multilingue final (`final-multilingual-report.template.md`) ;
- brief de traduction (`translation-brief.template.md`) ;
- carte des langues (`language-map.template.md`) ;
- plan i18n (`i18n-file-plan.template.md`) ;
- rapport qualité de traduction ;
- rapport SEO multilingue ;
- rapport d'humanisation.

### Étape 6 — Scores

À la fin :

- **Translation Quality Score** (0-100) ;
- **Multilingual Site Readiness Score** (0-100) ;
- verdict + prochaine étape.

---

## Modes d'exécution en détail

### Mode 1 — Audit only

Lance les scans, calcule les scores, produit le rapport.
**Aucune modification** de fichier.

```txt
/multilingual-site-engine Audite l'état multilingue de mon Next.js. Vérifie
hreflang, slugs, metadata, formulaires, emails. Calcule les scores.
```

### Mode 2 — Plan

Produit un plan détaillé : volume, fichiers à créer, mappings de slugs, stratégie SEO.
**Aucune modification** sans validation.

```txt
/multilingual-site-engine Prépare un plan complet pour ajouter l'allemand et
l'espagnol. Inventorie les chaînes, les routes, les emails, l'estimation
volume. Demande validation avant d'exécuter.
```

### Mode 3 — Traduction + humanisation

Exécute la traduction réelle sur les fichiers identifiés.
Demande **confirmation** avant de remplacer un fichier publié.

```txt
/multilingual-site-engine Traduis le site en anglais. Préserve les variables
i18next. Le source contient du style IA (tirets longs en boucle), humanise au
passage avant traduction.
```

### Mode 4 — SEO multilingue final

Génère hreflang, sitemap multilingue, balises OG, vérifie `<html lang>` et `canonical`.

```txt
/multilingual-site-engine Génère hreflang réciproques, sitemap multilingue
avec xhtml:link, balises og:locale, et vérifie <html lang> sur toutes les
pages.
```

---

## Scripts utiles

Tous lecture seule. Lance-les depuis la racine du projet :

```bash
# Inventaire des textes traduisibles
bash skills/multilingual-site-engine/scripts/scan-translatable-text.sh .

# Détection de chaînes hardcodées sans appel i18n
bash skills/multilingual-site-engine/scripts/scan-hardcoded-text.sh .

# Détection de patterns de style IA
bash skills/multilingual-site-engine/scripts/scan-ai-style-patterns.sh .

# Inventaire des fichiers locales existants
bash skills/multilingual-site-engine/scripts/scan-locale-files.sh .

# Création d'un brief de traduction (copie du template)
bash skills/multilingual-site-engine/scripts/create-translation-brief.sh ./docs MonProjet

# Création d'un rapport multilingue (copie du template)
bash skills/multilingual-site-engine/scripts/create-multilingual-report.sh ./reports MonProjet
```

---

## Variables et placeholders

Le skill **préserve** automatiquement :

- `{name}` (i18next) ;
- `{{count}}` (Vue / Mustache) ;
- `%s`, `%d` (gettext / printf) ;
- `:user` (Laravel) ;
- `${var}` (template literals) ;
- `<0>...</0>` (Trans component i18next) ;
- balises HTML inline (`<strong>`, `<em>`, `<a>`).

Si une variable est **cassée** dans la traduction, le skill le signale.

---

## Bibliothèques i18n supportées

Le skill détecte et adapte sa stratégie pour :

- **i18next** + `react-i18next` ;
- **next-intl** ;
- **next-i18next** ;
- **vue-i18n** ;
- **@nuxtjs/i18n** ;
- **react-intl** / FormatJS ;
- **gettext** (PO/MO) ;
- **Laravel** (`__()`, `trans()`) ;
- **Symfony** (xliff, yaml, php) ;
- **Django** (gettext) ;
- **Rails** (YAML) ;
- **WordPress** (`__()`, WPML, Polylang, TranslatePress) ;
- headless CMS (Contentful, Sanity, Strapi, Storyblok, Prismic).

---

## Stratégies de routes

Le skill choisit ou propose :

1. **sous-dossier** — `/fr/`, `/en/` (recommandé par défaut) ;
2. **sous-domaine** — `fr.site.com`, `en.site.com` ;
3. **domaine séparé** — `site.fr`, `site.de` ;
4. **paramètre URL** — `?lang=fr` (à éviter) ;
5. **slug traduit** — `/fr/contact`, `/en/contact-us` (premium UX).

Une seule stratégie par site.

---

## Délégations

| Cas | Skill recommandé |
|---|---|
| Cohérence ergonomique (menus, footers, routes) | `site-ux-guardian` |
| Rédiger un article from scratch | `seo-content-engine` |
| Refonte créative ou direction artistique | `premium-webdesigner` |
| Audit production complet | `production-auditor` |
| Création d'un repo from scratch | `repo-builder` |

---

## Astuces

### Le client trouve que "ça sent l'IA"

Lance d'abord **Mode 1** avec focus humanisation :

```txt
/multilingual-site-engine Mode audit. Détecte les patterns de style IA dans
toutes les pages. Compte les tirets longs, les phrases creuses, les
introductions creuses. Produis un rapport.
```

Puis **Mode 3** pour humaniser avant traduction.

### Tu veux ajouter une langue à un site existant

```txt
/multilingual-site-engine Ajoute le portugais (pt-PT) au site. Inventorie ce
qui existe en FR et EN, propose un plan, montre le volume, demande validation.
```

### Tu veux migrer de gettext à JSON i18next

```txt
/multilingual-site-engine Plan de migration de gettext (PO) vers i18next
(JSON). Inventorie les fichiers .po, propose la structure JSON cible, plan en
phases.
```

### Tu veux ajouter le RTL

```txt
/multilingual-site-engine Ajoute le support arabe (ar-SA). Liste les pages à
adapter en RTL, le CSS à passer en logique, les icônes à inverser, la police
à charger.
```

---

## Limites

- audit **statique** (lecture du code) ;
- **relecture native** non effectuée par le skill (fortement recommandée) ;
- ne **modifie** un fichier publié qu'en Mode 3 ou 4 et avec validation ;
- ne **pousse** rien vers GitHub ;
- ne fait **pas** de direction artistique.

---

Created by João de Almeida
