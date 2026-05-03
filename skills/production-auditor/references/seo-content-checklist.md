# Checklist SEO / Contenu — `production-auditor`

Created by João de Almeida — Art of Dev — https://artofdev.space

À dérouler en phase 6.

---

## 1. `<title>` par page

- [ ] **chaque page** a un `<title>` ;
- [ ] le `<title>` est **unique** pour chaque page (pas tous identiques) ;
- [ ] longueur 50–60 caractères ;
- [ ] format cohérent : `Page | Nom du site` ou `Nom du site — Page` ;
- [ ] mots-clés naturels (pas de spam SEO).

---

## 2. `<meta description>`

- [ ] présente sur **chaque page** ;
- [ ] longueur 130–160 caractères ;
- [ ] décrit le contenu réel de la page ;
- [ ] **non générique** ("Bienvenue sur notre site" → à proscrire) ;
- [ ] CTA implicite ou explicite si pertinent.

---

## 3. URLs / Slugs

- [ ] minuscules, séparateur `-` ;
- [ ] sans accents, sans espaces, sans caractères spéciaux ;
- [ ] **lisibles** par un humain (`/contact` plutôt que `/page?id=42`) ;
- [ ] cohérents (pas un mix `/about-us` et `/equipe`) ;
- [ ] courts ;
- [ ] aucune URL avec `?id=` côté pages publiques si possible.

---

## 4. Hiérarchie des titres

- [ ] **un seul `<h1>`** par page ;
- [ ] `<h1>` correspond au titre principal et inclut le concept clé ;
- [ ] `<h2>` séparent les sections principales ;
- [ ] `<h3>` pour les sous-sections, jamais sauter de `<h1>` à `<h3>` ;
- [ ] aucun `<div class="title">` qui devrait être un vrai `<h2>`/`<h3>`.

---

## 5. Contenu réel

- [ ] **zéro lorem ipsum** ;
- [ ] **zéro phrase générique IA** ("Dans le monde d'aujourd'hui...", "À l'ère du numérique...") ;
- [ ] **zéro doublon** entre pages (descriptions différentes pour services différents) ;
- [ ] textes **utiles** (chaque paragraphe apporte une info) ;
- [ ] vocabulaire **adapté au métier** (cf. `CLAUDE_PROJECT_FACTORY.md` §17) ;
- [ ] aucune promesse non implémentée ("Réservation en ligne" sans formulaire) ;
- [ ] FAQ pertinente si applicable.

---

## 6. Images — `alt` text

- [ ] **chaque image informative** a un `alt` non vide ;
- [ ] les images décoratives ont `alt=""` (vide explicite) ou `role="presentation"` ;
- [ ] `alt` décrit **le contenu réel** (pas `image1`, pas `photo`) ;
- [ ] cohérence : nommage des fichiers cohérent (`hero-restaurant.jpg`, `team-jane-doe.jpg`).

---

## 7. Liens internes

- [ ] **aucun lien interne 404** ;
- [ ] aucun lien `href="#"` qui ne devrait pas l'être ;
- [ ] ancres internes (`#section`) fonctionnelles ;
- [ ] textes de liens **descriptifs** (pas "cliquez ici", pas "en savoir plus" sans contexte) ;
- [ ] maillage logique entre pages (chaque page renvoie vers au moins une autre).

---

## 8. Liens externes

- [ ] `target="_blank" rel="noopener noreferrer"` sur les liens externes pertinents ;
- [ ] aucune redirection vers un site cassé ;
- [ ] pas de lien sortant inutile vers un concurrent en dofollow.

---

## 9. Pages légales

- [ ] `Mentions légales` (obligatoire en France/UE) ;
- [ ] `Politique de confidentialité` si collecte de données ;
- [ ] `CGV` / `CGU` si vente en ligne ou service en ligne ;
- [ ] `Politique cookies` + bandeau cookies si trackers / analytics ;
- [ ] page `Contact` complète ;
- [ ] coordonnées de contact non cachées.

---

## 10. Sitemap

- [ ] `sitemap.xml` présent à la racine si site public ;
- [ ] généré automatiquement ou maintenu à jour ;
- [ ] référencé dans `robots.txt` ;
- [ ] inclut toutes les pages publiques (et seulement elles).

---

## 11. `robots.txt`

- [ ] présent à la racine ;
- [ ] autorise l'indexation du contenu public ;
- [ ] **désindexe** `/admin/`, `/install/`, `/api/`, `/debug/` ;
- [ ] référence le `sitemap.xml`.

---

## 12. Open Graph / réseaux sociaux

- [ ] `<meta property="og:title">`, `og:description`, `og:image`, `og:url` ;
- [ ] image OG dimensionnée correctement (1200×630 px) ;
- [ ] `<meta name="twitter:card">` (`summary_large_image` recommandé) ;
- [ ] preview testé sur Facebook Debugger / Twitter Card Validator.

---

## 13. Schema.org (selon cas)

- [ ] `LocalBusiness` pour un commerce local (restaurant, coiffeur, tatoueur) ;
- [ ] `Product` pour une boutique ;
- [ ] `Article` pour un blog ;
- [ ] `Event` pour des événements (DJ, association) ;
- [ ] `FAQPage` si FAQ présente.

---

## 14. Performance SEO

- [ ] HTML valide (ou au moins sans erreurs critiques W3C) ;
- [ ] Lighthouse SEO > 90 ;
- [ ] Core Web Vitals corrects (LCP < 2.5 s, FID < 100 ms, CLS < 0.1) ;
- [ ] `lang="fr"` (ou autre langue) sur `<html>` ;
- [ ] charset UTF-8 explicite.

---

## 15. Cohérence multi-langue (si applicable)

- [ ] sélecteur de langue clair ;
- [ ] `<link rel="alternate" hreflang="...">` pour chaque langue ;
- [ ] traductions complètes (pas de mots anglais qui restent dans une page française) ;
- [ ] URLs cohérentes (`/fr/contact`, `/en/contact`).

---

## Sortie attendue

Pour chaque item failed :

- **page / URL** concernée ;
- **gravité** : `critique` / `important` / `mineur` ;
- **impact** : 1 phrase ("Pas de title → pénalisation forte SEO + apparence incohérente sur Google.") ;
- **correction recommandée** : 1 phrase + valeur suggérée si évident.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
