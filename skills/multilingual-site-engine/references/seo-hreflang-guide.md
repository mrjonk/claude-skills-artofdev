# Guide SEO multilingue et hreflang — `multilingual-site-engine`

Comment faire que Google, Bing et autres comprennent un site multilingue.

Created by João de Almeida

---

## 1. Pourquoi le SEO multilingue est piégeux

Sans configuration correcte :

- Google peut **dédupliquer** les versions linguistiques (ne garder qu'une seule) ;
- les utilisateurs sont **redirigés** vers la mauvaise langue ;
- les balises `<title>` apparaissent dans la mauvaise langue dans les SERP ;
- les pages **dupliquées** font chuter le ranking ;
- le **canonical** mal positionné détruit la version traduite.

Une bonne configuration repose sur 5 piliers :

1. balises `hreflang` ;
2. `<html lang>` ;
3. `canonical` ;
4. metadata traduites (`<title>`, `<meta description>`, OG) ;
5. sitemap multilingue.

---

## 2. Balises `hreflang`

### 2.1 Principe

Pour chaque page traduite, déclarer **toutes** les versions linguistiques.

```html
<link rel="alternate" hreflang="fr" href="https://site.com/fr/contact" />
<link rel="alternate" hreflang="en" href="https://site.com/en/contact" />
<link rel="alternate" hreflang="de" href="https://site.com/de/contact" />
<link rel="alternate" hreflang="x-default" href="https://site.com/en/contact" />
```

### 2.2 Règles obligatoires

- **réciprocité** : si A pointe vers B, B doit pointer vers A ;
- chaque page doit **se référencer elle-même** dans la liste ;
- toujours inclure `x-default` (page servie quand la langue de l'utilisateur n'est dans aucune des versions) ;
- URL **absolues** (avec `https://`), pas relatives ;
- codes ISO 639-1 (fr, en, de) éventuellement combinés ISO 3166-1 alpha-2 (`fr-CH`, `en-GB`).

### 2.3 Erreurs fréquentes

- balises `hreflang` **manquantes** sur la version source ;
- balises **non réciproques** (page FR liste EN mais pas l'inverse) ;
- URL **relatives** (`/fr/contact` au lieu de `https://site.com/fr/contact`) ;
- codes invalides (`hreflang="francais"`) ;
- absence de `x-default` ;
- mélange régional incohérent (`hreflang="en-EN"` n'existe pas).

### 2.4 Implémentation par stack

| Stack | Méthode |
|---|---|
| Next.js | `<Head>` dans chaque page, ou middleware injection |
| Nuxt | `head()` ou plugin `@nuxtjs/i18n` (auto) |
| WordPress (WPML) | géré nativement, vérifier l'option |
| WordPress (Polylang) | géré nativement |
| Django / Rails / Laravel | template du layout |
| Astro | `<head>` du layout |
| HTML statique | dur à maintenir, automatiser via build |

---

## 3. Balise `<html lang>`

Sur **chaque** page :

```html
<html lang="fr">
<html lang="en">
<html lang="de">
```

### Cas avec variante régionale

```html
<html lang="fr-CH">
<html lang="pt-BR">
```

### Erreurs courantes

- `<html lang="fr">` figé sur toutes les pages (même les versions EN) ;
- `<html lang="fr-FR">` alors que la cible réelle est `fr-CH` ou `fr-BE` ;
- absence totale du `lang`.

---

## 4. Canonical

### 4.1 Principe

Chaque page traduite doit avoir un `canonical` pointant **sur elle-même** :

```html
<!-- /fr/contact -->
<link rel="canonical" href="https://site.com/fr/contact" />

<!-- /en/contact -->
<link rel="canonical" href="https://site.com/en/contact" />
```

### 4.2 Erreur classique

Toutes les versions pointent vers la version source :

```html
<!-- /fr/contact -->
<link rel="canonical" href="https://site.com/en/contact" />  <!-- FAUX -->
```

→ Google ignore les versions traduites.

### 4.3 Cas paramètres / tracking

Les URL avec `?utm_source=...` doivent canoniquer vers l'URL **propre** sans paramètres :

```html
<!-- /fr/contact?utm_source=newsletter -->
<link rel="canonical" href="https://site.com/fr/contact" />
```

---

## 5. Metadata traduites

Pour **chaque** page traduite :

### 5.1 Title

```html
<!-- FR -->
<title>Contactez notre équipe | NomDuSite</title>

<!-- EN -->
<title>Contact our team | SiteName</title>
```

### 5.2 Meta description

```html
<!-- FR -->
<meta name="description" content="Contactez-nous pour une démonstration ou une question commerciale." />

<!-- EN -->
<meta name="description" content="Contact us for a demo or any sales question." />
```

### 5.3 OpenGraph

```html
<!-- FR -->
<meta property="og:locale" content="fr_FR" />
<meta property="og:locale:alternate" content="en_US" />
<meta property="og:locale:alternate" content="de_DE" />
<meta property="og:title" content="..." />
<meta property="og:description" content="..." />
<meta property="og:url" content="https://site.com/fr/contact" />
```

### 5.4 Twitter Card

```html
<meta name="twitter:title" content="..." />
<meta name="twitter:description" content="..." />
```

---

## 6. Sitemap multilingue

### 6.1 Format avec `xhtml:link`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xhtml="http://www.w3.org/1999/xhtml">
  <url>
    <loc>https://site.com/fr/contact</loc>
    <xhtml:link rel="alternate" hreflang="fr" href="https://site.com/fr/contact" />
    <xhtml:link rel="alternate" hreflang="en" href="https://site.com/en/contact" />
    <xhtml:link rel="alternate" hreflang="de" href="https://site.com/de/contact" />
    <xhtml:link rel="alternate" hreflang="x-default" href="https://site.com/en/contact" />
  </url>
  <url>
    <loc>https://site.com/en/contact</loc>
    <xhtml:link rel="alternate" hreflang="fr" href="https://site.com/fr/contact" />
    <xhtml:link rel="alternate" hreflang="en" href="https://site.com/en/contact" />
    <xhtml:link rel="alternate" hreflang="de" href="https://site.com/de/contact" />
    <xhtml:link rel="alternate" hreflang="x-default" href="https://site.com/en/contact" />
  </url>
</urlset>
```

### 6.2 Règles

- une entrée `<url>` **par version** linguistique ;
- balises `xhtml:link` **identiques** sur chaque entrée ;
- URL absolues ;
- **un seul** sitemap.xml ou un index si > 50 000 URL.

---

## 7. Pas de redirection automatique par langue

### 7.1 Pourquoi

Beaucoup de sites redirigent automatiquement selon `Accept-Language` :

- l'utilisateur **anglais** en France atterrit sur `/fr/` ;
- Google indexe **mal** (les bots n'ont pas de langue préférentielle réelle) ;
- l'utilisateur ne **comprend pas** qu'il y a d'autres versions.

### 7.2 Bonne pratique

- afficher la version correspondant à l'**URL** (pas au navigateur) ;
- proposer une **bannière** ou **modal** *"Cette page existe en EN, voir la version EN ?"* sans rediriger ;
- mémoriser le **choix** dans un cookie pour les visites suivantes ;
- garder le **switch langue** visible et fonctionnel.

---

## 8. URL et structure

### 8.1 Bonnes pratiques

- une langue par URL claire ;
- pas de paramètres dynamiques pour la langue si possible ;
- structure cohérente (cf. `route-and-slug-localization.md`).

### 8.2 À éviter

- `?lang=fr` en paramètre (mauvais SEO) ;
- détection IP (mauvais pour les bots et les VPN) ;
- duplication parfaite sans `hreflang` (pénalité contenu dupliqué).

---

## 9. Checklist SEO multilingue

- [ ] balises `hreflang` réciproques sur chaque page traduite ;
- [ ] `x-default` présent ;
- [ ] `<html lang>` correct par locale ;
- [ ] `canonical` correct par version ;
- [ ] `<title>` traduit ;
- [ ] `<meta description>` traduite ;
- [ ] balises OG traduites + `og:locale:alternate` ;
- [ ] sitemap multilingue avec `xhtml:link` ;
- [ ] pas de redirection auto par langue ;
- [ ] switch langue visible et persistant ;
- [ ] structured data (JSON-LD) traduits si applicable ;
- [ ] images avec `alt` traduit ;
- [ ] microcopies (breadcrumbs) traduites ;
- [ ] erreurs 404 / 500 traduites par langue ;
- [ ] robots.txt cohérent ;
- [ ] performances équivalentes par version (un site EN ne doit pas être 2x plus rapide que le FR à cause d'un bundle non optimisé).

---

## 10. Outils de vérification

- **Google Search Console** : section "International Targeting" puis "Language" ;
- **hreflang.org** : validateur de balises ;
- **Screaming Frog** : crawl + audit hreflang en bulk ;
- **Sitebulb** : audits multilingues détaillés ;
- **Lighthouse** : SEO de base.

Le skill peut suggérer ces outils dans le rapport final.

---

## 11. Validation post-implémentation

1. Crawler le site avec un outil ;
2. Vérifier la **réciprocité** des hreflang ;
3. Vérifier `<html lang>` sur 10 pages au hasard ;
4. Vérifier `canonical` sur 10 pages au hasard ;
5. Soumettre le sitemap dans Search Console ;
6. Attendre 2-3 semaines puis vérifier dans la Search Console.

---

Created by João de Almeida
