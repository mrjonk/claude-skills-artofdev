# Guide stack — Thème WordPress multilingue

> Conventions et règles spécifiques aux thèmes WordPress (textdomain, gettext, plugins i18n).
> Complément au guide architecture i18n générique.

Created by João de Almeida

---

## 1. Détection

Indices d'un thème WordPress :

- fichier `style.css` à la racine du thème avec en-tête `Theme Name:` ;
- `functions.php` avec `add_action('after_setup_theme', ...)` ;
- usage de `wp_head()`, `wp_footer()`, `wp_nav_menu()` ;
- header `Text Domain: nom-du-theme` dans `style.css` ;
- dossier `languages/` avec `.pot` ou `.po`.

---

## 2. Le textdomain — concept central

Chaque thème doit déclarer **un seul** textdomain (par convention, slug du thème) :

```css
/* style.css */
Text Domain: mytheme
Domain Path: /languages
```

```php
// functions.php
load_theme_textdomain( 'mytheme', get_template_directory() . '/languages' );
```

### 2.1 Règle absolue

Le textdomain est une **constante** du code. Il **ne se traduit jamais**, ne change jamais, ne se renomme jamais sans coordination globale.

Dans tous les `__()`, `_e()`, `esc_html_e()`, le 2e argument doit être identique : `'mytheme'`.

### 2.2 Anti-patterns

- `__('Hello', 'mytheme')` puis `_e('Goodbye', 'my-theme')` (deux textdomains différents → traductions perdues) ;
- `__('Hello', $textdomain)` avec une variable (le parser `wp i18n make-pot` ne peut pas extraire) ;
- absence de textdomain dans certains appels (`__('Hello')`) → chaîne ignorée par l'extracteur.

---

## 3. Fonctions d'internationalisation WordPress

| Fonction | Usage |
|---|---|
| `__( $text, $domain )` | retourne la chaîne traduite |
| `_e( $text, $domain )` | echo direct (pas d'échappement) |
| `esc_html__( $text, $domain )` | retourne, avec échappement HTML |
| `esc_html_e( $text, $domain )` | echo, avec échappement HTML |
| `esc_attr__( $text, $domain )` | retourne, échappement attribut HTML |
| `esc_attr_e( $text, $domain )` | echo, échappement attribut HTML |
| `_n( $single, $plural, $number, $domain )` | pluriel simple |
| `_x( $text, $context, $domain )` | avec contexte (pour homonymes) |
| `_nx( ..., $context, $domain )` | pluriel avec contexte |

Le skill **ne traduit jamais** les noms de fonctions. Il traduit le **premier argument** de chaque appel et reporte la traduction dans le `.po`.

### 3.1 Cas du contexte

```php
__( 'Post', 'mytheme' );           // article de blog
_x( 'Post', 'verb', 'mytheme' );   // poster (action)
```

Dans le `.pot`, ces deux entrées sont **distinctes** :

```
msgid "Post"
msgstr ""

msgctxt "verb"
msgid "Post"
msgstr ""
```

---

## 4. Format `.pot` / `.po` / `.mo`

### 4.1 `.pot` — template

Sans traductions, généré par `wp i18n make-pot` ou `xgettext`. Sert de référence.

### 4.2 `.po` — traductions par langue

Nommage obligatoire : `{textdomain}-{locale}.po`, où `locale` suit le format **WordPress** :

| Langue | Locale WP |
|---|---|
| Français (France) | `fr_FR` |
| Français (Canada) | `fr_CA` |
| Anglais (US) | `en_US` |
| Anglais (UK) | `en_GB` |
| Allemand | `de_DE` |
| Allemand (Autriche) | `de_AT` |
| Espagnol (Espagne) | `es_ES` |
| Portugais (Brésil) | `pt_BR` |
| Italien | `it_IT` |
| Néerlandais | `nl_NL` |
| Arabe | `ar` |

Attention : le format est **`xx_XX`** avec **underscore** et **majuscules** sur la 2e partie. Différent du format BCP 47 (`fr-FR`) utilisé en HTML `lang`.

### 4.3 `.mo` — binaire

Compilé depuis le `.po` :

```bash
msgfmt mytheme-fr_FR.po -o mytheme-fr_FR.mo
```

Ou via WP-CLI :

```bash
wp i18n make-mo languages/
```

WordPress charge automatiquement le `.mo` au runtime, jamais le `.po`. Le skill doit **rappeler la commande de compilation** dans le rapport.

---

## 5. Plugins i18n WordPress

| Plugin | Logique | Avantages | Inconvénients |
|---|---|---|---|
| **WPML** | duplique chaque post / page par langue | très complet, gère menus, slugs, médias | payant, complexe |
| **Polylang** | duplique chaque post / page par langue | gratuit, simple, stable | fonctions natives, rigide |
| **TranslatePress** | overlay frontend (modifie le HTML rendu) | UX éditeur facile | moins SEO-friendly |
| **MultilingualPress** | multisite, un site par langue | propre architecturalement | demande WP multisite |
| **GTranslate** | proxy de traduction automatique | rapide à activer | qualité médiocre, à éviter |

### 5.1 Règle absolue

**Un seul** plugin. Jamais combinaison. WPML + Polylang installés simultanément = base de données corrompue.

### 5.2 Détection du plugin actif

| Fonction présente | Plugin |
|---|---|
| `pll_the_languages()` | Polylang |
| `icl_get_languages()` | WPML |
| `trp_translate()` | TranslatePress |

---

## 6. Slugs traduits dans WordPress

### Polylang

Activer dans **Settings > Languages > URL modifications**. Permet `/fr/contact/` ↔ `/en/contact-us/`.

### WPML

**WPML > Languages > Translation of taxonomy slugs**. Plus puissant, plus de configuration.

---

## 7. Hreflang dans un thème WordPress

### 7.1 Avec Polylang

Polylang ajoute automatiquement les balises `hreflang` dans `<head>`. Vérifier :

- Settings > Languages > URL modifications ;
- Settings > Languages > Strings translations.

### 7.2 Avec WPML

WPML gère automatiquement, mais à vérifier :

- WPML > Languages > SEO Options.

### 7.3 Sans plugin (cas rare)

Le thème doit générer `<link rel="alternate">` manuellement dans `header.php`, en s'appuyant sur une logique custom. À éviter — utiliser un plugin.

---

## 8. Préservation absolue dans le code PHP du thème

| Élément | À traduire ? |
|---|---|
| Premier argument de `__()`, `_e()`, etc. | OUI (dans le `.po`) |
| Textdomain (2e argument) | NON, jamais |
| Nom de fonction `__()`, `_e()` | NON |
| `wp_nav_menu()`, `wp_head()`, hooks | NON |
| Commentaires `/* translators: ... */` | NON dans le code, **OUI utiles dans le `.po`** comme contexte |
| Header `Theme Name:`, `Author:`, `License:` dans style.css | NON (sauf cas spécifique de localisation du header) |
| `Theme Name:` peut être traduit via `Theme Name X-{locale}:` | optionnel |
| Slugs / handles d'enregistrement (`wp_register_script`) | NON |
| `add_filter`, `add_action` callbacks | NON |
| Constantes (`ABSPATH`) | NON |
| Identifiants CSS (`.site-header`) | NON |

---

## 9. Pluriels gettext en WordPress

```php
printf(
    _n( '%s comment', '%s comments', $count, 'mytheme' ),
    number_format_i18n( $count )
);
```

Dans le `.po` :

```
msgid "%s comment"
msgid_plural "%s comments"
msgstr[0] ""
msgstr[1] ""
```

Le nombre de formes (`msgstr[0]`, `msgstr[1]`, ...) dépend de l'en-tête `Plural-Forms` du `.po` :

```
"Plural-Forms: nplurals=2; plural=(n > 1);\n"   # français
"Plural-Forms: nplurals=2; plural=(n != 1);\n"  # anglais, allemand
"Plural-Forms: nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2);\n"  # russe
```

Le skill doit **utiliser la formule correcte** par langue, pas calquer la formule anglaise.

---

## 10. Anti-patterns thème WordPress

- traduire le textdomain ;
- mélanger plusieurs textdomains dans le même thème ;
- traduire les fonctions `__()`, `_e()` (impossible mais on l'a vu) ;
- traduire les slugs hardcodés sans passer par Polylang/WPML ;
- compiler le `.mo` à la main sans `msgfmt` (risque de format invalide) ;
- nommer `.po` avec un format BCP 47 (`mytheme-fr-FR.po` au lieu de `mytheme-fr_FR.po`) → WordPress ne charge pas ;
- oublier `Domain Path: /languages` dans `style.css` ;
- traduire les commentaires `/* translators: ... */` (ils sont des notes pour le traducteur, pas du contenu) ;
- pousser des chaînes hardcodées dans le code (`echo 'Hello'`) au lieu de `_e( 'Hello', 'mytheme' )`.

---

## 11. Checklist thème WordPress multilingue

- [ ] textdomain unique déclaré dans `style.css` et utilisé partout ;
- [ ] `load_theme_textdomain` appelé en `after_setup_theme` ;
- [ ] toutes les chaînes UI passent par `__()`, `_e()`, ou variantes ;
- [ ] `.pot` à jour avec `wp i18n make-pot` ;
- [ ] `.po` par langue cible, nommés `{textdomain}-{locale}.po` (format `xx_XX`) ;
- [ ] `.mo` compilés (manuellement ou via WP-CLI) ;
- [ ] plugin i18n choisi (Polylang ou WPML), pas les deux ;
- [ ] hreflang vérifiés dans `<head>` ;
- [ ] slugs traduits configurés (si stratégie slug par langue) ;
- [ ] menus traduits par langue (chaque langue a son menu attribué) ;
- [ ] medias avec `alt` traduit ;
- [ ] sitemap multilingue activé ;
- [ ] tests sur `/`, `/fr/`, `/en/`, `/de/` ;
- [ ] commentaires `/* translators: ... */` ajoutés là où c'est utile ;
- [ ] Plural-Forms correct dans chaque `.po`.

---

Created by João de Almeida
