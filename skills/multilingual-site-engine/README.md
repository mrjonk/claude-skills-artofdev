# `multilingual-site-engine` — README du skill

> Mode d'emploi du skill **`multilingual-site-engine`**.
> Pour la définition formelle (règles, méthode, scoring, checklists), voir [`SKILL.md`](SKILL.md).

Created by João de Almeida

---

## À quoi sert ce skill

`multilingual-site-engine` transforme un site monolingue en **site multilingue propre**, ou améliore un site déjà multilingue.

Quand tu veux traduire ou localiser un site, le skill :

- te demande **les langues cibles** si tu ne les as pas précisées ;
- détecte la **stack** et l'**architecture i18n** existante (i18next, gettext, JSON, PHP, PO/MO, WPML, Polylang, headless CMS) ;
- inventorie tous les **textes traduisibles** : pages, menus, footers, formulaires, emails, metadata, erreurs ;
- préserve les **variables**, **placeholders** et **balises** (`{name}`, `%s`, `{{count}}`, `<0>...</0>`) ;
- traduit **naturellement** (pas mot à mot) ;
- **humanise** les textes générés par IA (signe distinctif : tirets longs en boucle) ;
- gère **routes**, **slugs**, **hreflang**, **sitemaps**, **canonical**, **OpenGraph** ;
- gère **formats locaux** (dates, heures, nombres, monnaie) et **RTL** ;
- produit deux scores : **Translation Quality Score** + **Multilingual Site Readiness Score** sur 100.

---

## Quand l'utiliser

Le skill se charge automatiquement pour des prompts comme :

- *"traduis ce site en anglais et en allemand"* ;
- *"ajoute le portugais à mon site"* ;
- *"audite la qualité de la traduction"* ;
- *"vérifie hreflang et metadata multilingues"* ;
- *"humanise ce site, ça sent l'IA"* ;
- *"vérifie que les slugs sont cohérents entre langues"* ;
- *"prépare un plan i18n pour mon Next.js"* ;
- *"localise les formats de date et la monnaie"* ;
- *"ajoute le support RTL pour l'arabe"* ;
- *"convertis mes traductions de gettext vers JSON i18next"*.

Dans le doute, l'activer plutôt que de traduire chaîne par chaîne sans architecture.

---

## Ce qu'il vérifie

### Cadrage langues
- langue source réelle vs langue déclarée ;
- langues cibles précises ;
- langue par défaut / fallback ;
- gestion des locales régionales (`fr-FR` vs `fr-CH`, `en-US` vs `en-GB`).

### Architecture i18n
- système de fichiers de traduction (JSON, PO/MO, PHP, YAML) ;
- bibliothèque utilisée (i18next, react-intl, next-intl, vue-i18n, gettext, formatjs) ;
- détection des **chaînes hardcodées** non extraites ;
- cohérence des **clés** entre langues ;
- détection des **clés manquantes** ou **clés orphelines**.

### Qualité de traduction
- fidélité au sens (pas littéralisme, pas contresens) ;
- naturel (lecture par natif sans accroc) ;
- préservation des **variables** et **balises** ;
- cohérence terminologique ;
- registre UI adapté (bouton court, erreur claire).

### Anti-style IA
- détection des **tirets longs en boucle** (signal fort) ;
- phrases creuses (*"dans le monde d'aujourd'hui"*, *"révolutionnaire"*) ;
- introductions vides, conclusions superflues ;
- vocabulaire marketing creux.

### SEO multilingue
- balises `<title>` et `<meta description>` traduites ;
- balises `hreflang` réciproques + `x-default` ;
- balise `<html lang>` correcte ;
- `canonical` correct par version ;
- sitemap multilingue ;
- balises OpenGraph (`og:locale`, `og:locale:alternate`).

### Routes et slugs
- stratégie cohérente (sous-domaine / sous-dossier / domaine séparé / paramètre / slug traduit) ;
- mapping entre versions linguistiques d'une même page ;
- pas de collision entre slugs.

### Menus / footers / formulaires / emails
- mêmes liens et même ordre dans chaque langue ;
- libellés traduits ;
- mentions légales traduites ;
- erreurs de formulaire traduites ;
- emails transactionnels traduits par gabarit.

### Formats locaux
- date, heure, nombre, monnaie ;
- pluriels (ICU MessageFormat, plurals i18next) ;
- adresses, téléphones.

### RTL
- direction `rtl` ;
- CSS logique (`margin-inline-start`) ;
- icônes inversées ;
- police compatible.

---

## Différences avec les autres skills

### vs `site-ux-guardian`

| | `multilingual-site-engine` | `site-ux-guardian` |
|---|---|---|
| Mission | traduction et localisation | cohérence ergonomique globale |
| Langues | détecte, demande, traduit, humanise | vérifie juste la cohérence |
| SEO | hreflang, sitemaps multilingues, slugs | non |
| Humanisation | oui (anti-style IA) | non |
| Formats locaux | oui (date, monnaie, RTL) | non |

→ `site-ux-guardian` vérifie que le menu existe partout. `multilingual-site-engine` vérifie qu'il est **traduit** partout, **avec les bons slugs**, **avec hreflang**, **et sans style IA**.

### vs `seo-content-engine`

| | `multilingual-site-engine` | `seo-content-engine` |
|---|---|---|
| Mission | traduire / localiser une UI ou un site existant | rédiger un article from scratch |
| Périmètre | tout le site (menus, footers, formulaires, emails) | un contenu éditorial |
| Sortie | fichiers i18n traduits, slugs, hreflang, scores | un article publiable |

→ Si tu pars d'un article existant à **traduire**, c'est `multilingual-site-engine`. Si tu pars d'un sujet à **écrire**, c'est `seo-content-engine`.

### vs `premium-webdesigner`

`premium-webdesigner` fait de la direction artistique. `multilingual-site-engine` ne touche pas au design. Si une langue exige un layout différent (RTL), le skill **signale** et délègue le travail visuel.

---

## Comment il évite les bugs classiques

1. **Demande les langues** avant tout — pas de supposition.
2. **Détecte la stack** — n'impose pas i18next à un site PHP qui utilise gettext.
3. **Préserve les variables** — `{name}` reste `{name}` dans toutes les langues.
4. **Cherche les chaînes hardcodées** non extraites avant de traduire.
5. **Génère hreflang réciproques** (chaque page se référence et référence ses sœurs).
6. **Ne traduit pas les codes**, **noms propres**, **commandes**, **classes CSS**, **clés JSON**.
7. **Humanise** au passage : repère le tiret long abusif, remplace par la ponctuation naturelle.

---

## Exemples de prompts

### Audit multilingue (Mode 1 — lecture seule)

```txt
/multilingual-site-engine Audite l'état multilingue de ce site. Vérifie clés
manquantes, hreflang, slugs, metadata, formulaires, emails. Calcule les deux
scores. Ne modifie rien.
```

### Plan de traduction (Mode 2)

```txt
/multilingual-site-engine Prépare un plan complet pour ajouter l'allemand et
l'espagnol à ce site Next.js. Identifie les routes, les chaînes à traduire,
la stratégie SEO. Demande validation avant d'écrire.
```

### Traduction effective (Mode 3)

```txt
/multilingual-site-engine Traduis le site en anglais. Préserve les variables
i18next, humanise les textes (le source sent l'IA, beaucoup de tirets longs).
```

### SEO multilingue final (Mode 4)

```txt
/multilingual-site-engine Génère hreflang, sitemap multilingue, OpenGraph
locales, et vérifie les balises <html lang> sur toutes les pages.
```

### Humaniser un site IA

```txt
/multilingual-site-engine Le client trouve que le site sent l'IA. Détecte les
patterns (tirets longs, phrases creuses, marketing creux) et propose une
réécriture humaine sans toucher au sens.
```

D'autres exemples détaillés dans [`../../examples/`](../../examples/).

---

## Ce qu'il ne fait jamais

- traduire **sans demander** les langues cibles ;
- supposer une langue source sans vérifier ;
- détruire **variables**, **placeholders**, **balises HTML**, **classes CSS**, **clés** ;
- traduire des **noms propres**, **commandes**, **codes**, **classes** ;
- imposer une bibliothèque i18n (i18next) à un projet qui en utilise déjà une autre (gettext, intl, custom) ;
- supprimer une langue existante sans validation ;
- modifier un fichier de traduction publié sans backup ;
- pousser vers GitHub ;
- faire de la direction artistique (déléguer à `premium-webdesigner`) ;
- rédiger un article from scratch (déléguer à `seo-content-engine`).

---

## Structure du skill

```txt
skills/multilingual-site-engine/
├── SKILL.md
├── README.md
├── references/                              (14 fichiers)
├── templates/                               (7 fichiers)
└── scripts/                                 (6 fichiers)
```

---

## Comment l'améliorer plus tard

Le skill est un dossier — modifie-le directement :

1. ajuste `SKILL.md` (règles, méthode, scoring) ;
2. enrichis `references/` (nouvelles bibliothèques i18n, nouveaux CMS) ;
3. ajoute des templates dans `templates/` ;
4. ajoute des scripts dans `scripts/` ;
5. relance `bash install.sh multilingual-site-engine` à la racine du repo.

---

Created by João de Almeida
