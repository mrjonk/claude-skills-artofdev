# Guide architecture i18n — `multilingual-site-engine`

Comment détecter, choisir et structurer une architecture i18n selon la stack.

Created by João de Almeida

---

## 1. Principes communs à toutes les stacks

Quelle que soit la techno, une bonne architecture i18n a :

- **séparation** entre code et contenu textuel ;
- **clés** stables, pas de texte hardcodé ;
- **fichiers par langue** dans un dossier dédié ;
- **fallback** explicite ;
- **détection de langue** documentée (URL, header, cookie, sélecteur) ;
- **pluriels** gérés (ICU MessageFormat est la référence) ;
- **interpolation de variables** sécurisée ;
- **lazy loading** par locale si l'app est volumineuse.

---

## 2. Stack par stack

### 2.1 React (CRA, Vite)

**Bibliothèque recommandée :** `i18next` + `react-i18next`.

```txt
locales/
├── fr/
│   ├── common.json
│   ├── home.json
│   └── auth.json
└── en/
    ├── common.json
    ├── home.json
    └── auth.json
```

Points clés :
- namespaces par feature ;
- `<Trans>` pour les chaînes avec balises HTML ;
- `react-i18next` + `i18next-http-backend` pour le lazy loading.

### 2.2 Next.js (Pages Router)

**Option A :** `next-i18next` (i18next sous le capot).
**Option B :** native `next.config.js` `i18n` config + bibliothèque tierce.

```js
// next.config.js
module.exports = {
  i18n: {
    locales: ['fr', 'en', 'de'],
    defaultLocale: 'fr',
    localeDetection: false,
  },
};
```

### 2.3 Next.js (App Router)

**Bibliothèque recommandée :** `next-intl`.

Routes : `/[locale]/page.tsx`.

```txt
messages/
├── fr.json
└── en.json
```

Points clés :
- middleware pour la redirection ;
- `useTranslations(namespace)` côté client ;
- `getTranslations()` côté serveur ;
- `<NextIntlClientProvider>` au layout.

### 2.4 Vue 3 / Nuxt 3

**Bibliothèque recommandée :** `vue-i18n` v9 ou `@nuxtjs/i18n`.

```txt
locales/
├── fr.json
└── en.json
```

Points clés :
- composition API (`useI18n()`) ;
- routing par locale géré par `@nuxtjs/i18n` ;
- SEO automatique (hreflang, canonical) si bien configuré.

### 2.5 Laravel

**Système natif** : `resources/lang/{locale}/messages.php`.

```php
// resources/lang/fr/messages.php
return [
    'welcome' => 'Bienvenue',
    'cart' => [
        'empty' => 'Votre panier est vide',
        'count' => ':count article|:count articles',
    ],
];
```

Helper : `__('messages.welcome')` ou `trans()`.

### 2.6 Symfony

**Système natif** : `translations/messages.{locale}.{format}` (xliff, yaml, php).

```yaml
# translations/messages.fr.yaml
welcome: Bienvenue
cart:
  empty: Votre panier est vide
```

Helper : `{{ 'welcome'|trans }}`.

### 2.7 Django / Python

**Système natif** : gettext (PO/MO).

```txt
locale/
├── fr/LC_MESSAGES/django.po
└── en/LC_MESSAGES/django.po
```

Commandes :
- `django-admin makemessages -l fr` ;
- `django-admin compilemessages`.

### 2.8 Rails

**Système natif** : YAML.

```yaml
# config/locales/fr.yml
fr:
  welcome: Bienvenue
  cart:
    empty: Votre panier est vide
```

Helper : `t('welcome')`.

### 2.9 WordPress

Trois approches principales :

| Plugin | Mode | Points forts | Points faibles |
|---|---|---|---|
| **WPML** | duplique chaque post | très complet, gère tout | payant, plus lourd |
| **Polylang** | duplique chaque post | gratuit, simple | configuration parfois rigide |
| **TranslatePress** | overlay editor frontend | UX éditeur facile | moins SEO-friendly nativement |

**Règle :** un seul plugin, jamais combinés.

Pour un thème WordPress, les chaînes du code passent par `__()` ou `_e()` avec text domain :
```php
__( 'Read more', 'mon-theme' );
```
Fichiers `.po` / `.mo` dans `/languages/`.

### 2.10 Astro

**Approche** : routes `[locale]` + bibliothèque type `astro-i18next` ou `i18next` direct.

### 2.11 Headless CMS

| CMS | Mode i18n |
|---|---|
| **Contentful** | locale par champ |
| **Sanity** | doublure de document par locale ou champ localisé |
| **Storyblok** | multi-locales dans la même story |
| **Strapi** | plugin i18n, locale par entrée |
| **Prismic** | locale par document |

Adapter le système d'i18n du **frontend** au mode du CMS.

### 2.12 Site statique pur (HTML/CSS/JS)

Sans framework, deux options :

- **dossiers par langue** (`fr/index.html`, `en/index.html`) avec contenu dupliqué ;
- **JS léger** type `i18next` + JSON.

Pour les sites < 10 pages, dupliquer reste viable.

---

## 3. Détection de la stack

### Par fichiers

| Fichier présent | Stack probable |
|---|---|
| `package.json` avec `next` | Next.js |
| `package.json` avec `nuxt` | Nuxt |
| `package.json` avec `vite` + `vue` | Vue 3 + Vite |
| `composer.json` avec `laravel/framework` | Laravel |
| `composer.json` avec `symfony/symfony` | Symfony |
| `manage.py` | Django |
| `Gemfile` avec `rails` | Rails |
| `wp-config.php` | WordPress |
| `gatsby-config.js` | Gatsby |
| `astro.config.mjs` | Astro |
| `_config.yml` | Jekyll |
| `hugo.toml` ou `config.toml` | Hugo |

### Par dossier

| Dossier présent | Indice |
|---|---|
| `locales/` | i18next ou next-intl |
| `messages/` | next-intl |
| `lang/` | Laravel |
| `translations/` | Symfony |
| `locale/` (avec PO) | gettext / Django |
| `config/locales/` | Rails |
| `wp-content/languages/` | WordPress |

---

## 4. Anti-patterns à signaler

- **plusieurs systèmes** mélangés (i18next + custom JSON + textes hardcodés en parallèle) ;
- **textes hardcodés** dans le code malgré un système i18n présent ;
- **clés en français** quand la langue source est l'anglais (incohérent) ;
- **clés trop longues** ou avec espaces ;
- **traductions inline** dans le code (`{lang === 'fr' ? 'Bonjour' : 'Hello'}` partout) ;
- **fallback non défini** → l'app casse si une clé manque ;
- **lazy loading absent** alors que le bundle traductions est énorme ;
- **WPML + Polylang** installés en même temps ;
- **slugs non traduits** dans WPML alors que c'est ce qu'on attend.

---

## 5. Migration entre systèmes

Cas fréquents :

- gettext (PO) → JSON (i18next) ;
- WPML → Polylang ;
- texte hardcodé → extraction vers JSON ;
- locale par champ → doublure d'entrée (CMS).

**Règle :** ne jamais migrer sans un **export complet** de l'existant et un **plan de rollback**.

---

## 6. Structure de fichiers recommandée

Pour un projet moyen avec i18next :

```
locales/
├── fr/
│   ├── common.json         # menus, footers, boutons, erreurs
│   ├── home.json
│   ├── auth.json
│   ├── account.json
│   ├── pricing.json
│   ├── legal.json
│   └── emails.json
├── en/
│   └── (mêmes fichiers)
└── de/
    └── (mêmes fichiers)
```

Avantages :
- diff par feature ;
- lazy loading par namespace ;
- ownership clair (qui traduit quoi) ;
- pas de fichier monolithique de 5000 clés.

---

## 7. Vérification post-installation

Après mise en place :

- [ ] balise `<html lang="...">` change selon la locale ;
- [ ] le switch langue **persiste** la préférence (cookie ou storage) ;
- [ ] le routing change l'URL (`/fr/` ↔ `/en/`) ;
- [ ] les fallbacks fonctionnent (clé manquante → langue par défaut, pas d'erreur) ;
- [ ] le bundle JS reste raisonnable (lazy load par locale si > 200 KB) ;
- [ ] aucun texte hardcodé qui aurait dû être extrait.

---

Created by João de Almeida
