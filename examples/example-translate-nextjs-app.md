# Exemple — Traduire une app Next.js (App Router + next-intl)

> Cas concret : ajouter l'allemand à une app Next.js déjà en FR + EN.

Created by João de Almeida

---

## Demande utilisateur

> *"Mon Next.js (App Router, next-intl) tourne en FR + EN. Je veux ajouter
> l'allemand. Préserve les variables, prépare hreflang, et fais le SEO
> multilingue final."*

---

## Question à poser

> *"Avant de commencer :*
> *1. Confirmes-tu DE comme cible (`de-DE` ou `de-AT` / `de-CH`) ?*
> *2. Slugs traduits ou non (`/de/kontakt` vs `/de/contact`) ?*
> *3. Y a-t-il des emails transactionnels à traduire (Resend, Sendgrid, autre) ?*
> *4. Le contenu blog est-il dans le code (.md) ou dans un CMS headless ?*
> *5. Faut-il humaniser au passage (le source EN sent l'IA) ?"*

---

## Fichiers à inspecter

```
app/
├── [locale]/
│   ├── layout.tsx
│   ├── page.tsx
│   ├── about/page.tsx
│   ├── contact/page.tsx
│   ├── pricing/page.tsx
│   └── blog/[slug]/page.tsx
├── api/
└── ...
messages/
├── fr.json
└── en.json
i18n.ts
middleware.ts
next.config.js
```

Vérifier :

- `next.config.js` : tableau `locales` ;
- `i18n.ts` : configuration next-intl ;
- `middleware.ts` : routing par locale ;
- `messages/*.json` : volume et structure ;
- `app/[locale]/layout.tsx` : balise `<html lang>` dynamique.

---

## Architecture recommandée

### Configuration

```ts
// i18n.ts
import { getRequestConfig } from 'next-intl/server';

const locales = ['fr', 'en', 'de'] as const;

export default getRequestConfig(async ({ locale }) => ({
  messages: (await import(`./messages/${locale}.json`)).default,
}));
```

```js
// next.config.js
module.exports = {
  i18n: {
    locales: ['fr', 'en', 'de'],
    defaultLocale: 'fr',
  },
};
```

### Fichiers de traduction

```
messages/
├── fr.json   (existe)
├── en.json   (existe)
└── de.json   (à créer en miroir des clés de fr.json)
```

---

## Contenus à traduire

### messages/de.json

Toutes les clés de `fr.json` reproduites avec valeurs en allemand. Ne pas oublier :

- **menus** ;
- **footers** ;
- **boutons** ;
- **formulaires** (labels, placeholders, erreurs) ;
- **emails** (sujets, corps, CTA) ;
- **erreurs** (404, 500) ;
- **microcopies** (états vides, tooltips) ;
- **legal** (mentions, RGPD, CGV) — souvent un travail juridique séparé.

### Pages dynamiques

Si le blog a des articles `.md` dans le code :

```
content/
├── fr/
│   └── article-1.md
├── en/
│   └── article-1.md
└── de/
    └── article-1.md  (à créer)
```

Ou via CMS headless avec entrée par locale.

### Slugs

Si stratégie *slugs traduits* :

```json
// app/i18n/pathnames.json
{
  "/contact": {
    "fr": "/contact",
    "en": "/contact",
    "de": "/kontakt"
  },
  "/pricing": {
    "fr": "/tarifs",
    "en": "/pricing",
    "de": "/preise"
  }
}
```

---

## Variables à préserver

next-intl utilise des messages ICU :

```json
{
  "welcome": "Bienvenue, {name} !",
  "items": "{count, plural, =0 {Aucun article} one {Un article} other {# articles}}"
}
```

→ traductions DE doivent garder `{name}`, `{count}`, `# articles`.

---

## SEO multilingue

### Layout root

```tsx
// app/[locale]/layout.tsx
export default function LocaleLayout({ children, params: { locale } }) {
  return (
    <html lang={locale}>
      <body>{children}</body>
    </html>
  );
}
```

### Hreflang

À générer dans le head de chaque page :

```tsx
<link rel="alternate" hrefLang="fr" href="https://site.com/fr/contact" />
<link rel="alternate" hrefLang="en" href="https://site.com/en/contact" />
<link rel="alternate" hrefLang="de" href="https://site.com/de/kontakt" />
<link rel="alternate" hrefLang="x-default" href="https://site.com/fr/contact" />
```

next-intl fournit un helper pour ça.

### Sitemap

```tsx
// app/sitemap.ts
export default function sitemap() {
  const routes = ['', '/contact', '/pricing', '/about'];
  return routes.flatMap((route) => [
    {
      url: `https://site.com/fr${route}`,
      alternates: {
        languages: {
          fr: `https://site.com/fr${route}`,
          en: `https://site.com/en${route}`,
          de: `https://site.com/de${route}`,
        },
      },
    },
    // ...idem pour /en et /de
  ]);
}
```

---

## Score attendu

| Critère | Note attendue |
|---|---|
| Translation Quality (DE) | 75-85 (sans relecture native) |
| Translation Quality (DE) | 90+ (avec relecture native) |
| Multilingual Site Readiness | 85-95 |

---

## Rapport (extrait)

```markdown
## Score
- Translation Quality (DE) : 80 / 100 (recommandation : relecture native)
- Multilingual Site Readiness : 88 / 100

## Travail effectué
- messages/de.json créé (482 clés en miroir de fr.json)
- next.config.js mis à jour avec 'de'
- middleware.ts mis à jour
- sitemap.ts génère les 3 langues
- balises hreflang réciproques générées
- emails transactionnels traduits

## Délégations
- relecture par natif allemand vivement recommandée
- si humanisation du source EN nécessaire, repasser le skill en mode 3

## Prochaine étape
Soumettre le sitemap dans Search Console et faire relire les pages clés
par un natif allemand.
```

---

Created by João de Almeida
