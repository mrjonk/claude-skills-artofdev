# Exemple — Traduire un thème WordPress

> Cas concret : ajouter EN à un site WordPress en FR avec un thème custom.

Created by João de Almeida

---

## Demande utilisateur

> *"Mon site WordPress a un thème custom et tourne en français. Je veux passer
> en bilingue FR + EN. Quel plugin choisir, comment traduire le thème et les
> contenus, comment gérer les slugs ?"*

---

## Question à poser

> *"Avant de commencer :*
> *1. Confirmes-tu EN comme cible ?*
> *2. Le thème custom est-il déjà internationalisé (`__()`, `_e()`, text domain) ?*
> *3. Préfères-tu WPML (payant, complet) ou Polylang (gratuit, plus simple) ?*
> *4. Slugs traduits ou identiques entre langues ?*
> *5. Y a-t-il un WooCommerce ou des plugins majeurs à traduire aussi ?"*

---

## Fichiers à inspecter

```
wp-content/
├── themes/
│   └── mon-theme/
│       ├── functions.php
│       ├── index.php
│       ├── header.php
│       ├── footer.php
│       ├── single.php
│       ├── page.php
│       ├── languages/         (vide ou existant ?)
│       └── ...
├── plugins/
│   ├── sitepress-multilingual-cms/   (WPML)
│   ├── polylang/
│   └── ...
└── languages/
```

Vérifier :

- `style.css` : header `Text Domain` ;
- `functions.php` : `load_theme_textdomain()` ;
- chaque template : utilisation de `__()`, `_e()`, `esc_html__()`, `esc_attr__()` ;
- présence d'un dossier `languages/` avec `.po` / `.mo`.

---

## Choisir un plugin

### WPML
- payant ;
- gère contenus, menus, slugs, custom fields, commerce ;
- très complet ;
- communauté fournie.

### Polylang
- gratuit (Pro disponible) ;
- gère contenus, menus, slugs ;
- plus léger, parfait pour les sites simples.

### TranslatePress
- gratuit (Pro disponible) ;
- édition front visuelle ;
- moins SEO-friendly nativement.

**Règle :** un seul. Jamais deux en parallèle.

---

## Internationaliser le thème custom

### Étape 1 — Text domain

```php
// style.css (header)
/*
Theme Name: MonTheme
Text Domain: mon-theme
*/
```

```php
// functions.php
function mon_theme_setup() {
    load_theme_textdomain('mon-theme', get_template_directory() . '/languages');
}
add_action('after_setup_theme', 'mon_theme_setup');
```

### Étape 2 — Passer le texte par les fonctions de traduction

Avant :

```php
<h1>Bienvenue sur notre site</h1>
<a href="/contact">Nous contacter</a>
```

Après :

```php
<h1><?php _e('Bienvenue sur notre site', 'mon-theme'); ?></h1>
<a href="<?php echo home_url('/contact'); ?>"><?php _e('Nous contacter', 'mon-theme'); ?></a>
```

### Étape 3 — Générer le fichier .pot

Avec WP-CLI :

```bash
wp i18n make-pot wp-content/themes/mon-theme wp-content/themes/mon-theme/languages/mon-theme.pot
```

Puis créer `mon-theme-fr_FR.po` et `mon-theme-en_US.po`, les compiler en `.mo`.

---

## Contenus à traduire

### Pages et posts

Chaque page / article :

- WPML : un *job* de traduction par page ;
- Polylang : duplication par page avec lien entre versions.

### Menus

`Apparence → Menus` : un menu par langue.

### Widgets

WPML / Polylang ont leurs options pour traduire les widgets.

### Custom fields (ACF)

WPML a un connecteur ACF. Polylang a une option pour la traduction des champs ACF (Pro).

### WooCommerce

WPML : module WooCommerce Multilingual (payant).
Polylang : extension Polylang for WooCommerce (Pro).

---

## Slugs

### Posts

WPML : option *"Translate URL"* dans WPML > Languages.
Polylang : *"Permaliens"* dans Polylang Settings.

Exemple : `/fr/nous-contacter/` ↔ `/en/contact-us/`.

### Catégories / tags

WPML / Polylang gèrent par défaut.

---

## Variables à préserver

WordPress utilise :

- `__()` : `__('Hello %s', 'mon-theme')` ;
- `printf` avec `%s`, `%d` ;
- `sprintf` ;
- placeholders custom dans certains plugins.

Tous à conserver.

---

## SEO multilingue

### Avec WPML

- option **WPML SEO** ou Yoast SEO Multilingual ;
- balises `hreflang` automatiques ;
- sitemap multilingue (Yoast XML Sitemap + WPML).

### Avec Polylang

- balises `hreflang` automatiques (à activer) ;
- sitemap : Yoast SEO + module Polylang Yoast.

### Vérifications

- balise `<html lang>` dynamique (rendue par `language_attributes()`) ;
- `<title>` traduit ;
- `<meta description>` traduit (Yoast/RankMath stocke par langue avec WPML/Polylang) ;
- canonical correct par version.

---

## Score attendu

| Critère | Note attendue |
|---|---|
| Translation Quality | 80-90 (WPML est solide) |
| Multilingual Site Readiness | 85-95 (les plugins gèrent bien le SEO) |

---

## Rapport (extrait)

```markdown
## Score
- Translation Quality : 86 / 100
- Multilingual Site Readiness : 91 / 100

## Travail effectué
- thème internationalisé (text domain mon-theme)
- 247 chaînes extraites en .pot
- mon-theme-en_US.po créé et compilé en .mo
- Polylang installé et configuré pour FR + EN
- pages, articles, menus dupliqués et traduits
- slugs traduits activés
- hreflang vérifiés via Yoast SEO

## Problèmes mineurs
- MIN-001 : 12 chaînes encore hardcodées dans single-product.php
- MIN-002 : un widget de footer non passé par i18n

## Délégations
- audit sécurité WordPress : `production-auditor`
- amélioration UX du switch langue : `site-ux-guardian`

## Prochaine étape
Traduire les 12 chaînes restantes et soumettre le sitemap dans Search Console.
```

---

Created by João de Almeida
