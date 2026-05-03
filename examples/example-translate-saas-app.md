# Exemple — Traduire une SaaS app complète

> Cas concret : une SaaS B2B en EN qui doit s'ouvrir aux marchés FR, DE, ES.

Created by João de Almeida

---

## Demande utilisateur

> *"Mon SaaS (React frontend + Node API + Postgres) tourne en anglais. On
> veut s'ouvrir à FR, DE, ES. Stack frontend : Next.js App Router avec
> next-intl. Plan complet, traduction, hreflang, emails transactionnels,
> formats locaux."*

---

## Question à poser

> *"Avant de commencer :*
> *1. Confirmes-tu FR-FR, DE-DE, ES-ES (pas de ES-MX) ?*
> *2. Langue par défaut : EN ou autre ?*
> *3. Slugs traduits ou identiques (`/fr/dashboard` vs `/fr/tableau-de-bord`) ?*
> *4. Emails transactionnels via quel service (Resend, Sendgrid, Mailgun, autre) ?*
> *5. Monnaie : USD pour tous, ou conversion automatique ?*
> *6. Faut-il humaniser (le site EN sent l'IA) ?"*

---

## Fichiers à inspecter

### Frontend

```
app/
├── [locale]/
│   ├── (auth)/
│   ├── (dashboard)/
│   ├── (marketing)/
│   └── layout.tsx
messages/
├── en.json
i18n.ts
middleware.ts
next.config.js
```

### Backend

```
src/
├── routes/
├── controllers/
├── services/
├── emails/
│   └── templates/
│       └── (en/welcome.html, ...)
└── ...
```

### Marketing

Pages publiques de présentation (souvent dans le même monorepo).

---

## Architecture recommandée

### 1. Frontend i18n

next-intl avec `messages/{locale}.json` par locale.

### 2. Backend i18n

- API renvoie les **codes d'erreur**, pas les messages traduits ;
- frontend mappe code → message localisé ;
- exception : si l'API envoie des emails directement, gérer la locale dans l'API.

### 3. Emails

```
emails/templates/
├── en/
│   ├── welcome.html
│   ├── reset-password.html
│   ├── invoice.html
│   └── ...
├── fr/
├── de/
└── es/
```

Sélection de la locale selon le compte utilisateur (`user.locale`).

### 4. DB

Ajouter `locale` dans la table `users`. Stocker la langue préférée.

---

## Contenus à traduire

### Frontend (volume estimé)

| Section | Clés FR EN DE ES |
|---|---|
| common | 80 (menus, footers, boutons) |
| auth | 60 |
| dashboard | 120 |
| settings | 90 |
| billing | 70 |
| marketing | 100 |
| errors | 40 |
| forms | 50 |
| **total** | **610 par langue** |

### Emails

15 emails transactionnels × 4 langues = 60 templates.

### Marketing

- home, pricing, features, about, contact, blog, legal × 4 langues.

### Slugs traduits (si choisi)

```json
{
  "/dashboard": {
    "en": "dashboard",
    "fr": "tableau-de-bord",
    "de": "dashboard",
    "es": "panel"
  },
  "/pricing": {
    "en": "pricing",
    "fr": "tarifs",
    "de": "preise",
    "es": "precios"
  }
}
```

---

## Variables à préserver

next-intl ICU MessageFormat :

```json
{
  "welcome": "Welcome, {name}!",
  "items": "{count, plural, =0 {No items} one {# item} other {# items}}",
  "since": "Member since {date, date, long}"
}
```

---

## Formats locaux

### Dates

`Intl.DateTimeFormat(locale)`.

### Monnaie

API renvoie la monnaie choisie par le compte (`user.currency`).
Frontend affiche avec `Intl.NumberFormat(locale, { style: 'currency', currency: 'EUR' })`.

### Pluriels

Géré par next-intl (ICU).

---

## SEO multilingue

### Marketing pages

```tsx
// app/[locale]/page.tsx (home)
export async function generateMetadata({ params: { locale } }) {
  const t = await getTranslations({ locale, namespace: 'marketing' });
  return {
    title: t('home.title'),
    description: t('home.description'),
    alternates: {
      canonical: `https://app.com/${locale}`,
      languages: {
        en: 'https://app.com/en',
        fr: 'https://app.com/fr',
        de: 'https://app.com/de',
        es: 'https://app.com/es',
      },
    },
    openGraph: {
      locale: locale === 'fr' ? 'fr_FR' : locale === 'de' ? 'de_DE' : ...,
      alternateLocale: ['fr_FR', 'de_DE', 'es_ES'].filter(l => !l.startsWith(locale)),
    },
  };
}
```

### Sitemap

Toutes les pages **marketing** dans le sitemap multilingue. Les pages dashboard ne sont **pas** indexables (`robots: noindex`).

---

## Humanisation

Si le source EN sent l'IA (tirets longs, phrases creuses), exécuter :

```bash
bash skills/multilingual-site-engine/scripts/scan-ai-style-patterns.sh .
```

Réécrire les pages marketing avant de traduire.

---

## Score attendu

| Critère | Note attendue |
|---|---|
| Translation Quality (par langue) | 75-85 sans relecture native |
| Translation Quality (par langue) | 90+ avec relecture native |
| Multilingual Site Readiness | 85-95 |

---

## Rapport (extrait)

```markdown
## Score
- Translation Quality (FR) : 82 / 100
- Translation Quality (DE) : 78 / 100 (relecture native fortement recommandée)
- Translation Quality (ES) : 80 / 100
- Multilingual Site Readiness : 89 / 100

## Travail effectué
- messages/{fr,de,es}.json créés (610 clés chacun)
- 15 emails transactionnels traduits dans 4 langues
- pages marketing traduites
- slugs traduits configurés (mapping pathnames.json)
- hreflang réciproques générés
- sitemap multilingue avec xhtml:link
- formats Intl.* en place (date, currency)
- humanisation effectuée sur 8 pages marketing (76 tirets longs supprimés,
  23 phrases creuses réécrites)

## Problèmes restants
- IMP-001 : pages dashboard ont 14 chaînes encore hardcodées
- IMP-002 : 3 templates email DE n'ont pas été testés en rendu

## Délégations
- relecture native par locuteurs FR / DE / ES
- audit production : `production-auditor`

## Prochaine étape
Engager 3 relecteurs natifs et tester les 60 templates email avec Mailtrap.
```

---

Created by João de Almeida
