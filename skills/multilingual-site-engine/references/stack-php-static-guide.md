# Guide stack — PHP statique sans framework

> Conventions et règles spécifiques au PHP statique (sites sans framework, sans CMS).
> Complément au guide architecture i18n générique.

Created by João de Almeida

---

## 1. Quand applicable

Ce guide s'applique à :

- sites en **PHP pur** sans framework (pas Laravel, pas Symfony, pas WordPress) ;
- sites avec **`require_once`** comme seul mécanisme de composition ;
- sites où chaque page est un **fichier `.php` autonome** dans la racine ou un sous-dossier ;
- sites qui n'utilisent **pas** de moteur de template (pas Twig, pas Blade) ;
- sites legacy qu'on ne veut **pas** migrer vers un framework juste pour ajouter une langue.

---

## 2. Détection

Indices d'un site PHP statique sans framework :

- `index.php`, `contact.php`, `services.php` à la racine ;
- pas de `composer.json` (ou `composer.json` minimal sans framework) ;
- pas de `wp-config.php` ;
- pas de `package.json` côté serveur ;
- usage de `require_once 'header.php'` répété ;
- pas de routeur central.

---

## 3. Stratégies i18n possibles

### 3.1 Duplication par dossier (simple)

```
/
├── fr/
│   ├── index.php
│   ├── contact.php
│   └── services.php
└── en/
    ├── index.php
    ├── contact.php
    └── services.php
```

Avantages : aucune dépendance, chaque page est autonome.
Inconvénients : duplication massive, un changement de structure se propage en double.

À privilégier si le site a < 10 pages.

### 3.2 Tableaux PHP (`lang/{locale}.php`)

```php
// lang/fr.php
return [
    'site.name'      => 'ArtOfDev',
    'home.hero.title'=> 'Studio web premium',
    'contact.submit' => 'Envoyer le message',
];
```

Helper minimal :

```php
// lang/loader.php
function t( string $key, array $vars = [] ): string {
    static $strings = null;
    if ( $strings === null ) {
        $locale = $_GET['lang'] ?? $_COOKIE['lang'] ?? 'fr';
        $locale = preg_replace( '/[^a-z]/', '', $locale );
        $file   = __DIR__ . "/{$locale}.php";
        $strings = file_exists( $file ) ? require $file : require __DIR__ . '/fr.php';
    }
    $value = $strings[ $key ] ?? $key;
    foreach ( $vars as $k => $v ) {
        $value = str_replace( '{' . $k . '}', (string) $v, $value );
    }
    return $value;
}
```

Avantages : un seul jeu de templates, fichiers de traduction triviaux.
Inconvénients : il faut extraire **toutes** les chaînes hardcodées avant de pouvoir traduire.

À privilégier si le site doit servir 3+ langues.

### 3.3 gettext (PO/MO en PHP pur)

PHP supporte gettext nativement (extension `gettext`) :

```php
bindtextdomain( 'mysite', __DIR__ . '/locale' );
textdomain( 'mysite' );
echo _( 'Welcome' );
```

Demande l'extension `gettext` activée côté serveur, et la compilation des `.mo`. À éviter sur des hébergements mutualisés où l'extension peut manquer.

---

## 4. Règles de préservation

### 4.1 Ne JAMAIS traduire

- les noms de fonctions PHP (`require_once`, `htmlspecialchars`, `filter_var`) ;
- les noms de variables PHP (`$errors`, `$success`, `$_POST`) ;
- les commentaires PHP techniques (`// debug only`) ;
- les attributs HTML techniques (`name="email"`, `id="form"`, `type="submit"`) ;
- les valeurs `class="..."` des balises HTML ;
- les chemins de fichiers (`/assets/style.css`, `/contact.php`) ;
- les commentaires CSS, même s'ils contiennent des mots qui ressemblent à des instructions (*"to be translated"* dans un commentaire CSS reste un commentaire).

### 4.2 Toujours traduire

- le contenu textuel des balises (`<h1>`, `<p>`, `<a>`, `<button>`) ;
- les attributs **sémantiques** (`alt=""`, `title=""`, `aria-label=""`, `placeholder=""`) ;
- les messages d'erreur dans les chaînes affichées ;
- les contenus d'emails (sujet + corps + CTA + footer email).

### 4.3 Cas ambigus à confirmer

- `<title>` : oui à traduire ;
- `<meta name="description">` : oui à traduire ;
- `<meta name="keywords">` : oui (mais souvent inutile aujourd'hui) ;
- `<html lang="fr">` : à **dynamiser** par locale ;
- les noms d'événements `onclick`, `onsubmit` : non, code technique.

---

## 5. Structure recommandée pour un site PHP statique multilingue

```
/
├── index.php                  # entry, choisit la locale et redirige vers /fr/ ou /en/
├── lang/
│   ├── fr.php
│   ├── en.php
│   └── loader.php             # helper t() et détection de locale
├── partials/
│   ├── header.php
│   └── footer.php
├── pages/
│   ├── home.php
│   ├── contact.php
│   └── services.php
├── email-templates/
│   ├── fr/
│   │   └── welcome.php
│   └── en/
│       └── welcome.php
├── assets/
│   ├── style.css
│   └── script.js
└── sitemap.xml
```

`index.php` à la racine ne sert qu'à rediriger : `header('Location: /fr/')` selon le cookie `lang`.

---

## 6. SEO multilingue en PHP statique

### 6.1 Hreflang dans `<head>`

```php
<?php $current_path = '/contact.php'; ?>
<link rel="alternate" hreflang="fr" href="https://site.com/fr<?= $current_path ?>" />
<link rel="alternate" hreflang="en" href="https://site.com/en<?= $current_path ?>" />
<link rel="alternate" hreflang="x-default" href="https://site.com/en<?= $current_path ?>" />
<link rel="canonical" href="https://site.com/<?= $locale ?><?= $current_path ?>" />
```

### 6.2 Sitemap multilingue

À générer **manuellement** (le site n'a pas de framework qui le génère). Fichier `sitemap.xml` à la racine, listant toutes les versions avec `xhtml:link`.

### 6.3 `<html lang>` dynamique

```php
<html lang="<?= htmlspecialchars( $locale ) ?>">
```

---

## 7. Pièges fréquents

### 7.1 Copyright statique

`<p>&copy; 2024</p>` doit devenir `<p>&copy; <?= date('Y') ?></p>` ou être stocké en chaîne traduite avec placeholder `{year}`.

### 7.2 Détection de langue par IP ou Accept-Language

À éviter (cf. règle SEO du skill : pas de redirection auto). Préférer :
1. URL (`/fr/...`) ;
2. cookie `lang` ;
3. fallback langue par défaut.

### 7.3 Chaînes hardcodées dans les emails

Un email transactionnel en PHP pur est souvent un `mail()` avec un `$body` hardcodé. Extraire chaque template dans `email-templates/{locale}/welcome.php` et choisir le template selon la langue de l'utilisateur.

### 7.4 Formulaires : labels et placeholders

Souvent un seul `<label>Email</label>` dans le code. À remplacer par `<label><?= t('contact.email.label') ?></label>` après extraction.

### 7.5 Slugs

Sur un site PHP statique pur, les slugs sont **les noms de fichier** (`/contact.php`, `/services.php`). Pour des slugs traduits :
- soit on renomme physiquement (`/services.php` → `/fr/services.php` + `/en/services.php`) ;
- soit on passe par un routeur léger (e.g. `.htaccess` + `index.php` en front controller).

---

## 8. Checklist PHP statique

- [ ] toutes les chaînes affichées extraites vers `lang/{locale}.php` ;
- [ ] helper `t()` opérationnel et testé ;
- [ ] `<html lang="...">` dynamique sur chaque page ;
- [ ] hreflang présents dans `<head>` ;
- [ ] canonical correct par version ;
- [ ] copyright dynamique (`date('Y')`) ;
- [ ] emails dans `email-templates/{locale}/` ;
- [ ] sitemap.xml multilingue ;
- [ ] redirection sur `/` vers la locale par défaut ;
- [ ] cookie de préférence langue (mais pas redirection auto par Accept-Language) ;
- [ ] commentaires CSS / PHP **non traduits** ;
- [ ] noms de classes CSS et IDs **non traduits**.

---

Created by João de Almeida
