# Exemple — Traduire un site statique HTML/CSS/JS

> Cas concret : traduire un site vitrine HTML pur de FR vers FR + EN.

Created by João de Almeida

---

## Demande utilisateur

> *"J'ai un site vitrine en HTML/CSS/JS pur (5 pages : home, services, à propos, contact, mentions légales). Je veux ajouter l'anglais. Pas de framework, pas de CMS. Comment faire ?"*

---

## Question à poser

> *"Avant de commencer, peux-tu me préciser :*
> *1. La langue source : FR (confirmé) ;*
> *2. Langues cibles : juste EN, ou plus tard d'autres ?*
> *3. Langue par défaut : FR ou EN ?*
> *4. Préférence URL : `/fr/contact.html` + `/en/contact.html` (sous-dossier) ou `contact.html` + `contact-en.html` (suffixe) ?*
> *5. Faut-il garder un système simple (duplication) ou introduire un build statique avec un système i18n (Eleventy, Hugo) ?"*

---

## Fichiers à inspecter

```
project/
├── index.html
├── services.html
├── about.html
├── contact.html
├── mentions-legales.html
├── css/styles.css
└── js/main.js
```

Vérifier :

- balise `<html lang="fr">` ;
- contenus textuels (paragraphes, boutons, formulaires) ;
- metadata SEO (`<title>`, `<meta>`) ;
- menu et footer (probablement répétés dans chaque page).

---

## Architecture recommandée

### Option A — Duplication propre (le plus simple, < 10 pages)

```
project/
├── fr/
│   ├── index.html
│   ├── services.html
│   ├── about.html
│   ├── contact.html
│   └── mentions-legales.html
├── en/
│   ├── index.html
│   ├── services.html
│   ├── about.html
│   ├── contact.html
│   └── legal-notice.html
├── index.html        (redirection vers /fr/ ou /en/ selon préférence)
├── css/styles.css
└── js/main.js
```

### Option B — Build statique avec Eleventy ou Hugo

Plus de souplesse pour la suite.

---

## Contenus à traduire

### Pages

| Page FR | Page EN |
|---|---|
| `/fr/index.html` | `/en/index.html` |
| `/fr/services.html` | `/en/services.html` |
| `/fr/about.html` | `/en/about.html` |
| `/fr/contact.html` | `/en/contact.html` |
| `/fr/mentions-legales.html` | `/en/legal-notice.html` |

### Menu et footer

- libellés traduits ;
- liens pointant vers `/en/` quand on est en EN ;
- switch langue dans le header (drapeaux ou texte `FR / EN`).

### Metadata SEO

Chaque page :

```html
<!-- /fr/contact.html -->
<html lang="fr">
<head>
  <title>Contactez-nous | Marque</title>
  <meta name="description" content="Contactez l'équipe pour une démonstration." />
  <link rel="canonical" href="https://site.com/fr/contact.html" />
  <link rel="alternate" hreflang="fr" href="https://site.com/fr/contact.html" />
  <link rel="alternate" hreflang="en" href="https://site.com/en/contact.html" />
  <link rel="alternate" hreflang="x-default" href="https://site.com/fr/contact.html" />
</head>
```

### Formulaire de contact

- labels (Nom, Email, Message) ;
- placeholders ;
- bouton submit ;
- erreurs côté client (JS) ;
- message de succès.

### Mentions légales

À traduire **et** adapter au contexte juridique du marché cible (peut nécessiter un avocat pour les marchés régulés).

---

## Variables à préserver

Sur un site statique pur, peu de variables. Vérifier :

- script de mise à jour de l'année dans le copyright (`new Date().getFullYear()`) ;
- éventuel formulaire avec validation JS.

---

## Score attendu

| Critère | Note attendue après traduction propre |
|---|---|
| Translation Quality | 80-90 |
| Multilingual Site Readiness | 70-85 |

(< 100 car un site statique n'a pas de gestion fine des fallbacks, pluriels, etc.)

---

## Rapport (extrait)

```markdown
## Score
- Translation Quality : 84 / 100
- Multilingual Site Readiness : 78 / 100

## Synthèse
Site statique de 5 pages traduit en EN. Architecture sous-dossier propre,
hreflang et canonical en place, menus et footers traduits, formulaire de
contact localisé.

## Problèmes mineurs
- MIN-001 : copyright avec année figée (à passer dynamique).
- MIN-002 : `Accept-Language` détection absente — non requis ici.

## Délégations
- Si refonte créative : `premium-webdesigner`.
- Si ajout d'un blog : envisager Eleventy + i18next.

## Prochaine étape
Soumettre le sitemap en Search Console et suivre 2 semaines.
```

---

Created by João de Almeida
