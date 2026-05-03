# Exemples d'utilisation — `multilingual-site-engine`

Cas d'usage concrets et prompts copiables.

Created by João de Almeida

---

## Exemple 1 — Traduction d'un site statique HTML/CSS/JS

### Prompt

```txt
/multilingual-site-engine J'ai un site statique en français (HTML pur, pas de
framework). Je veux ajouter l'anglais. Inventaire ce qui existe, propose une
stratégie d'URL, et un plan complet.
```

### Résultat attendu

- détection de la stack (HTML statique) ;
- demande de confirmation des langues ;
- proposition stratégie sous-dossier (`/fr/`, `/en/`) ou duplication (`fr.html`, `en.html`) ;
- inventaire des pages, menus, footers ;
- plan de fichiers traduits ;
- plan SEO (hreflang, sitemap) ;
- rapport.

---

## Exemple 2 — Ajout d'une langue à un Next.js multilingue

### Prompt

```txt
/multilingual-site-engine Mon Next.js (App Router, next-intl) supporte FR et
EN. Je veux ajouter l'allemand. Mode plan, demande validation avant action.
```

### Résultat attendu

- détection : Next.js + next-intl + locales `fr`, `en` ;
- volumétrie de chaînes existantes ;
- plan de création `messages/de.json` ;
- mise à jour `next.config.js` `locales` ;
- mapping de slugs si applicable ;
- plan hreflang ;
- estimation volume ;
- demande validation.

---

## Exemple 3 — Audit qualité d'une traduction EN existante

### Prompt

```txt
/multilingual-site-engine Audite la qualité de la traduction anglaise du site
WordPress (WPML installé). Vérifie cohérence terminologique, variables,
fautes, style IA. Produis le score.
```

### Résultat attendu

- détection WordPress + WPML ;
- échantillonnage de chaînes ;
- liste des problèmes (calques, contresens, variables cassées) ;
- détection de style IA ;
- score Translation Quality (0-100) ;
- plan de correction.

---

## Exemple 4 — Humanisation d'un site IA

### Prompt

```txt
/multilingual-site-engine Mon site sent l'IA (tirets longs partout, phrases
creuses). Détecte tous les patterns, compte les occurrences, propose une
réécriture des 5 pages les plus touchées.
```

### Résultat attendu

- exécution du script `scan-ai-style-patterns.sh` ;
- comptage des tirets longs, phrases creuses ;
- rapport d'humanisation ;
- exemples avant/après ;
- pénalité au Translation Quality Score ;
- recommandation : humaniser avant de traduire dans d'autres langues.

---

## Exemple 5 — Préparation hreflang + sitemap multilingue

### Prompt

```txt
/multilingual-site-engine Le site existe en FR, EN, DE mais le SEO multilingue
est mal configuré. Vérifie hreflang, lang, canonical, sitemap. Propose les
corrections.
```

### Résultat attendu

- audit page par page (échantillon) ;
- liste des balises manquantes ;
- liste des hreflang non réciproques ;
- proposition d'ajout par stack ;
- génération d'un sitemap multilingue avec `xhtml:link` ;
- score SEO multilingue.

---

## Exemple 6 — Localisation des formats (date, monnaie)

### Prompt

```txt
/multilingual-site-engine Mon SaaS affiche les prix en USD pour tous, et les
dates au format US partout. Localise pour FR (EUR + DD/MM/YYYY) et DE (EUR +
DD.MM.YYYY).
```

### Résultat attendu

- inventaire des endroits où les formats apparaissent ;
- recommandation `Intl.DateTimeFormat` et `Intl.NumberFormat` ;
- gestion de la monnaie côté backend ;
- exemples de code ;
- tests à effectuer.

---

## Exemple 7 — Ajout du RTL (arabe)

### Prompt

```txt
/multilingual-site-engine Ajoute le support arabe au site. Liste les pages à
adapter en RTL, le CSS à passer en logique, les icônes à inverser, la police à
charger.
```

### Résultat attendu

- détection de l'absence de support RTL ;
- liste des fichiers CSS avec direction physique (`margin-left`) ;
- proposition de migration vers logique (`margin-inline-start`) ;
- icônes directionnelles à inverser ;
- recommandation de polices (Cairo, Tajawal, Noto Sans Arabic) ;
- déclaration `<html dir="rtl">` ;
- éventuelle délégation à `premium-webdesigner` si refonte créative nécessaire.

---

## Exemple 8 — Migration de gettext vers JSON i18next

### Prompt

```txt
/multilingual-site-engine J'ai un site PHP avec gettext (PO/MO). Je migre vers
React + i18next. Plan de migration, conversion des fichiers, mapping des
clés.
```

### Résultat attendu

- inventaire des fichiers `.po` ;
- conversion en JSON ;
- mapping `msgid` → clés JSON cohérentes ;
- gestion des pluriels (Plural-Forms en gettext → ICU MessageFormat) ;
- stratégie de migration phasée ;
- tests de non-régression.

---

## Exemple 9 — Localisation d'emails transactionnels

### Prompt

```txt
/multilingual-site-engine Les emails transactionnels (welcome, reset, invoice)
sont envoyés en anglais à tous les utilisateurs. Localise par langue de
compte : FR, EN, DE.
```

### Résultat attendu

- inventaire des emails (sujets, corps, CTA, footers) ;
- structure `emails/{locale}/welcome.html` ;
- mécanisme de sélection de langue (langue du compte) ;
- traduction des sujets, préheaders, CTA ;
- tests recommandés (Litmus, Mailtrap) ;
- traduction du footer email (désinscription, adresse).

---

## Exemple 10 — Audit SaaS multilingue complet

### Prompt

```txt
/multilingual-site-engine Mode audit complet. Mon SaaS supporte FR, EN, DE.
Vérifie tout : couverture pages, menus, footers, formulaires, emails, slugs,
hreflang, formats locaux, style IA. Calcule les deux scores.
```

### Résultat attendu

- exécution des 4 scripts d'inventaire ;
- couverture par langue par section ;
- liste des problèmes critiques / importants / mineurs ;
- détection style IA ;
- Translation Quality Score par langue ;
- Multilingual Site Readiness Score global ;
- top 5 actions immédiates.

---

## Exemple 11 — Conversion d'un blog mono vers multi

### Prompt

```txt
/multilingual-site-engine Mon blog WordPress (FR) doit devenir bilingue
(FR + EN). Quel plugin choisir, quelle structure, comment migrer les 120
articles existants ?
```

### Résultat attendu

- comparaison WPML vs Polylang vs TranslatePress ;
- recommandation selon contexte (budget, complexité, SEO) ;
- plan de migration ;
- gestion des slugs (traduits ou non) ;
- gestion des catégories / tags ;
- gestion du menu et du footer ;
- estimation de volume.

---

## Exemple 12 — Vérification post-deploy

### Prompt

```txt
/multilingual-site-engine Le site multilingue vient d'être déployé. Vérifie
que tout est OK : hreflang sur 10 pages au hasard, switch langue, sitemap
soumis, balises canonical correctes.
```

### Résultat attendu

- échantillonnage de pages ;
- vérification balises hreflang ;
- vérification switch langue ;
- vérification sitemap.xml accessible ;
- vérification canonical ;
- liste des éventuels problèmes ;
- recommandation : Search Console + 2-4 semaines de suivi.

---

D'autres exemples détaillés dans [`../examples/`](../examples/).

---

Created by João de Almeida
