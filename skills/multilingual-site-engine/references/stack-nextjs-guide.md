# Guide stack — Next.js (App Router et Pages Router)

> Conventions et règles spécifiques à Next.js avec `next-intl` ou `i18next`.
> Complément au guide architecture i18n générique.

Created by João de Almeida

---

## 1. Détection du mode Next.js

| Indice | Mode |
|---|---|
| dossier `app/` avec `page.tsx`, `layout.tsx` | App Router |
| dossier `pages/` avec `index.tsx` | Pages Router |
| **les deux** présents | hybride (rare, à clarifier) |

| Indice | Bibliothèque i18n |
|---|---|
| `messages/{locale}.json` + `next-intl.config.ts` | `next-intl` (App Router) |
| `next-i18next.config.js` | `next-i18next` (Pages Router) |
| `locales/{locale}/*.json` + `i18n.ts` import direct | `i18next` brut |
| `.intl/` ou `intl/messages/` | `react-intl` / FormatJS |
| absence totale de fichiers de traduction | extraction à faire |

---

## 2. App Router avec `next-intl`

### 2.1 Structure typique

```
app/
├── [locale]/
│   ├── layout.tsx
│   ├── page.tsx
│   ├── about/page.tsx
│   └── contact/page.tsx
├── api/
│   └── contact/route.ts        # NE PAS TRADUIRE
└── globals.css
messages/
├── en.json
├── fr.json
└── de.json
next-intl.config.ts
middleware.ts
```

### 2.2 Préservation absolue

Dans les chaînes JSON :

| Pattern | Description | À préserver ? |
|---|---|---|
| `{name}` | interpolation simple next-intl | OUI |
| `{count, plural, one {...} other {...}}` | ICU MessageFormat | OUI (entièrement) |
| `{date, date, short}` | formatage date ICU | OUI |
| `{value, number, currency}` | formatage nombre ICU | OUI |
| `<link>...</link>` | placeholders rich text next-intl | OUI |

### 2.3 Pluriel ICU — règle stricte

```json
{
  "items": "{count, plural, =0 {No items} one {# item} other {# items}}"
}
```

Le format ICU n'est pas du JS. Les **catégories** de pluriel (`one`, `other`, `few`, `many`, `two`, `zero`) dépendent de la langue cible :

| Langue | Catégories utilisées |
|---|---|
| `en` | one, other |
| `fr` | one, other (one = 0 ou 1, other = 2+) |
| `de` | one, other |
| `ru` | one, few, many |
| `pl` | one, few, many, other |
| `ar` | zero, one, two, few, many, other |

Le skill doit **adapter** la liste de catégories à la langue cible, pas calquer celle de l'anglais.

### 2.4 JSX et interpolations

Distinction importante :

```tsx
// JSX brut — { count } est une expression React, le SKILL NE TOUCHE PAS
<p>{count}</p>

// next-intl — { count } est une interpolation dans une chaîne, à préserver dans la traduction
<p>{t('items', { count })}</p>
```

Dans le **JSON**, `{count}` est texte. Dans le **TSX**, `{count}` est code. Aucun des deux ne se traduit.

### 2.5 Locale dans le routing

`next-intl` injecte la locale dans le chemin via `[locale]` :

- `/fr/contact` → page rendue avec `locale = 'fr'` ;
- `/en/contact` → page rendue avec `locale = 'en'`.

Le middleware redirige `/` vers `/fr/` (ou la locale détectée). Le skill doit **documenter** la stratégie de détection initiale (cookie, header) sans imposer une auto-redirection silencieuse.

### 2.6 Metadata par locale

```tsx
import { getTranslations } from 'next-intl/server';

export async function generateMetadata({ params: { locale } }) {
  const t = await getTranslations({ locale, namespace: 'home.meta' });
  return {
    title: t('title'),
    description: t('description'),
    alternates: {
      canonical: `/${locale}`,
      languages: {
        en: '/en',
        fr: '/fr',
        de: '/de',
      },
    },
  };
}
```

Le skill doit générer ces metadata pour **chaque page** traduite.

---

## 3. Pages Router avec `next-i18next`

### 3.1 Structure typique

```
pages/
├── _app.tsx
├── index.tsx
└── contact.tsx
public/
└── locales/
    ├── en/
    │   ├── common.json
    │   └── home.json
    └── fr/
        ├── common.json
        └── home.json
next-i18next.config.js
next.config.js
```

### 3.2 Différences clés vs App Router

- pas de dossier `[locale]` — le routing locale est natif via `next.config.js` `i18n.locales` ;
- usage de `serverSideTranslations()` dans `getServerSideProps` ou `getStaticProps` ;
- la prop `locale` arrive directement dans `getStaticProps`.

---

## 4. `i18next` brut (sans Next.js helper)

Possible mais plus rare en Next.js. Patterns : `useTranslation()` + namespaces.

```tsx
const { t } = useTranslation('common');
return <h1>{t('hero.title')}</h1>;
```

Dans ce cas, les chaînes sont dans `public/locales/{lang}/{namespace}.json`. Mêmes règles de préservation.

### 4.1 Trans component

Pour les chaînes avec balises HTML :

```tsx
<Trans i18nKey="welcome">
  Welcome <strong>{{name}}</strong>!
</Trans>
```

Dans le JSON :

```json
{
  "welcome": "Welcome <1>{{name}}</1>!"
}
```

Le skill doit préserver `<0>...</0>`, `<1>...</1>` (composants enfants indexés) et `{{name}}`.

---

## 5. API Routes — NE PAS TRADUIRE

Les fichiers dans `app/api/` ou `pages/api/` contiennent du code serveur :

- les **codes d'erreur** (`INVALID_PAYLOAD`, `AUTH_FAILED`) sont des **identifiants machine**, pas des messages UI ;
- les **logs** ne sont pas traduits ;
- les **réponses JSON** vers le frontend doivent renvoyer un **code** que le frontend traduit, pas une chaîne traduite côté serveur.

Pattern recommandé :

```ts
// app/api/contact/route.ts
return NextResponse.json({ error: 'INVALID_EMAIL' }, { status: 400 });
```

```tsx
// app/contact/page.tsx
const errorMessages = {
  INVALID_EMAIL: t('errors.invalid_email'),
};
```

---

## 6. Hreflang en Next.js

### App Router

Via `generateMetadata` (cf. §2.6) ou un composant `<Head>` injecté.

### Pages Router

Via `<Head>` dans chaque page :

```tsx
import Head from 'next/head';

export default function ContactPage() {
  return (
    <>
      <Head>
        <link rel="alternate" hrefLang="fr" href="https://site.com/fr/contact" />
        <link rel="alternate" hrefLang="en" href="https://site.com/en/contact" />
        <link rel="alternate" hrefLang="x-default" href="https://site.com/en/contact" />
      </Head>
      ...
    </>
  );
}
```

---

## 7. Sitemap multilingue Next.js

App Router : `app/sitemap.ts` :

```ts
export default async function sitemap() {
  const locales = ['en', 'fr', 'de'];
  const pages = ['', '/about', '/contact'];

  return pages.flatMap((page) =>
    locales.map((locale) => ({
      url: `https://site.com/${locale}${page}`,
      alternates: {
        languages: Object.fromEntries(
          locales.map((l) => [l, `https://site.com/${l}${page}`])
        ),
      },
    }))
  );
}
```

---

## 8. Anti-patterns Next.js

- traduire les **chaînes JSX** au lieu de les extraire vers JSON (`<h1>{lang === 'fr' ? 'Bonjour' : 'Hello'}</h1>`) ;
- traduire les **clés JSON** elles-mêmes (`{ "bonjour": "Hello" }` au lieu de `{ "hello": "Bonjour" }`) ;
- mélanger `next-intl` et `next-i18next` dans le même projet ;
- mettre le contenu i18n dans la **base de données** sans cache et faire un fetch SSR par requête ;
- redirection automatique par `Accept-Language` sans afficher de bannière de choix ;
- oublier le `<html lang>` dynamique dans `layout.tsx` ;
- oublier les metadata `alternates.languages` ;
- traduire les codes d'erreur API ;
- coder en dur la liste des locales en plusieurs endroits (config + middleware + sitemap divergent).

---

## 9. Checklist Next.js multilingue

- [ ] `next-intl` ou `next-i18next` installé et configuré (un seul, pas les deux) ;
- [ ] dossier `messages/` ou `public/locales/` peuplé pour chaque langue ;
- [ ] `[locale]` dans le routing (App Router) ou config `i18n.locales` (Pages) ;
- [ ] middleware de routing locale en place ;
- [ ] `<html lang>` dynamique dans `layout.tsx` ;
- [ ] `generateMetadata` ou `<Head>` produisant title / description / hreflang / canonical traduits ;
- [ ] sitemap.xml multilingue ;
- [ ] API routes ne renvoient **que** des codes d'erreur, pas des messages traduits ;
- [ ] aucune chaîne JSX hardcodée restante ;
- [ ] ICU plural correct par langue ;
- [ ] tests sur `/fr/`, `/en/`, et `/de/` (ou autre langue cible) ;
- [ ] switch langue visible et persistant.

---

Created by João de Almeida
