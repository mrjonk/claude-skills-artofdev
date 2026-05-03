# Exemple — Traduire un site PHP custom

> Cas concret : ajouter EN à un site PHP custom (sans framework) en FR.

Created by João de Almeida

---

## Demande utilisateur

> *"Mon site PHP custom (pas de framework, pas Laravel) tourne en français.
> Beaucoup de templates `.php` avec du HTML inline et du texte en dur. Je veux
> ajouter l'anglais proprement."*

---

## Question à poser

> *"Avant de commencer :*
> *1. Confirmes-tu EN comme cible ?*
> *2. Préfères-tu introduire gettext (PO/MO) ou un système custom (array PHP par locale) ?*
> *3. Stratégie URL : sous-dossier `/fr/`, `/en/` ou détection par paramètre ?*
> *4. Y a-t-il une base de données avec contenu textuel (articles, produits) ?*
> *5. Y a-t-il des emails envoyés depuis le site ?"*

---

## Fichiers à inspecter

```
project/
├── index.php
├── about.php
├── contact.php
├── services.php
├── includes/
│   ├── header.php
│   ├── footer.php
│   └── menu.php
├── admin/
└── ...
```

Inspecter :

- header / footer / menu (probablement utilisés via `include`) ;
- chaque page pour repérer le texte en dur ;
- formulaires de contact ;
- emails envoyés via `mail()` ou bibliothèque ;
- éventuelle DB de contenu.

---

## Architecture recommandée

### Système simple — array PHP par locale

```
lang/
├── fr.php
└── en.php
```

```php
// lang/fr.php
return [
    'welcome' => 'Bienvenue',
    'menu' => [
        'home' => 'Accueil',
        'about' => 'À propos',
        'services' => 'Services',
        'contact' => 'Contact',
    ],
    'contact' => [
        'title' => 'Contactez-nous',
        'name_label' => 'Votre nom',
        'submit' => 'Envoyer',
    ],
];
```

```php
// lang/en.php
return [
    'welcome' => 'Welcome',
    'menu' => [
        'home' => 'Home',
        'about' => 'About',
        'services' => 'Services',
        'contact' => 'Contact',
    ],
    // ...
];
```

### Helper

```php
// includes/lang.php
function set_locale() {
    $locale = $_GET['lang'] ?? $_COOKIE['locale'] ?? 'fr';
    if (!in_array($locale, ['fr', 'en'])) $locale = 'fr';
    return $locale;
}

function t($key, $default = '') {
    global $LANG;
    $keys = explode('.', $key);
    $value = $LANG;
    foreach ($keys as $k) {
        if (!isset($value[$k])) return $default ?: $key;
        $value = $value[$k];
    }
    return $value;
}

$locale = set_locale();
$LANG = require __DIR__ . "/../lang/{$locale}.php";
```

### Routes

```
/fr/index.php
/fr/contact.php
/en/index.php
/en/contact.php
```

Avec `.htaccess` pour le routing propre.

---

## Contenus à traduire

### Templates

- `header.php` (logo, menu, CTA) ;
- `footer.php` (liens, copyright, mentions) ;
- `menu.php` (libellés des liens) ;
- chaque page (`index.php`, `about.php`, etc.) ;
- formulaires.

### Emails

```php
function send_contact_email($name, $message, $locale = 'fr') {
    $subject = t('email.contact_subject');
    $body = sprintf(t('email.contact_body'), $name, $message);
    mail('contact@site.com', $subject, $body);
}
```

→ sujets et corps dans `lang/{locale}.php`.

### DB contenu

Si contenu en DB, ajouter une colonne `locale` ou une table de traductions :

```sql
CREATE TABLE article_translations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    article_id INT NOT NULL,
    locale VARCHAR(5) NOT NULL,
    title VARCHAR(255),
    content TEXT,
    UNIQUE KEY (article_id, locale)
);
```

---

## Variables à préserver

Patterns courants en PHP :

- `%s`, `%d` (pour `sprintf`) ;
- `:user`, `:count` si style Laravel utilisé ;
- placeholders custom (`{name}`).

Tous à conserver dans la traduction.

---

## SEO multilingue

```php
<!-- header.php -->
<html lang="<?= $locale ?>">
<head>
  <title><?= t('page.title') ?></title>
  <meta name="description" content="<?= t('page.description') ?>" />
  <link rel="canonical" href="<?= 'https://site.com' . $_SERVER['REQUEST_URI'] ?>" />
  <link rel="alternate" hreflang="fr" href="https://site.com/fr<?= $current_path ?>" />
  <link rel="alternate" hreflang="en" href="https://site.com/en<?= $current_path ?>" />
  <link rel="alternate" hreflang="x-default" href="https://site.com/fr<?= $current_path ?>" />
</head>
```

---

## Score attendu

| Critère | Note attendue |
|---|---|
| Translation Quality | 80-90 |
| Multilingual Site Readiness | 70-85 (le custom est moins robuste qu'un framework) |

---

## Rapport (extrait)

```markdown
## Score
- Translation Quality : 82 / 100
- Multilingual Site Readiness : 76 / 100

## Travail effectué
- création de lang/fr.php et lang/en.php
- helper t() ajouté dans includes/lang.php
- header.php et footer.php passés via t()
- templates de pages mis à jour
- emails contact traduits
- hreflang générés dans le header

## Problèmes restants
- IMP-001 : la base de données articles n'a pas encore de table de traduction
  (à mettre en place pour le blog)
- MIN-001 : pas de fallback automatique si une clé manque (afficher la clé)

## Délégations
- pour audit sécurité PHP : `production-auditor`
- pour cohérence ergonomique : `site-ux-guardian`

## Prochaine étape
Étendre le système de traduction à la DB d'articles si on veut un blog
multilingue.
```

---

Created by João de Almeida
