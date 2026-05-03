# Section éditoriale — `multilingual-site-engine`

> Section prête à intégrer dans un article ou une page produit qui présente le skill.

Created by João de Almeida

---

## Pourquoi traduire un site n'est pas copier le texte dans Google Translate

La plupart des sites multilingues ratés partagent la même histoire. Quelqu'un a copié les pages dans un traducteur, recollé les textes dans le CMS, ajouté un drapeau dans le header, et appelé ça *"un site multilingue"*.

Trois mois plus tard, les utilisateurs étrangers se plaignent. Les emails de bienvenue arrivent en français. Les erreurs de formulaire s'affichent en *"Internal Server Error"*. Les dates sont au format US sur la version allemande. Le bouton *"S'inscrire"* déborde sur la version finlandaise. Google indexe la version anglaise comme un duplicata. Les utilisateurs RTL voient un layout en miroir cassé.

Un site multilingue, ce n'est pas un site **traduit**. C'est un site **localisé**, **structuré**, **branché au SEO multilingue**, **respectueux des formats locaux**, et écrit dans une **voix humaine** dans chaque langue.

Le skill `multilingual-site-engine` fait exactement ça.

---

## Ce qu'il vérifie réellement

Quand tu lances le skill sur un site, il ne se contente pas de regarder les pages publiques. Il **inventorie** :

- les **menus** et **footers** ;
- les **formulaires** (labels, placeholders, erreurs côté client, erreurs côté serveur) ;
- les **emails transactionnels** (welcome, reset, invoice, notifications) ;
- les **emails marketing** ;
- les **microcopies** (tooltips, breadcrumbs, états vides) ;
- les **erreurs API** exposées à l'utilisateur ;
- les **metadata SEO** (title, description, OG, Twitter) ;
- les **balises hreflang** et leur réciprocité ;
- la balise `<html lang>` ;
- les **sitemaps** ;
- les **slugs** ;
- les **routes** ;
- les **catégories** et **tags** dans le CMS ;
- les **alt text** des images ;
- les **formats** de date, heure, nombre, monnaie ;
- les **pluriels** (ICU MessageFormat) ;
- les langues **RTL** si applicables.

Tout ce qui peut casser un site multilingue est listé, scoré, et corrigé selon le mode choisi.

---

## La règle prioritaire — demander avant de traduire

Beaucoup d'outils traduisent dès qu'ils sont activés. Le skill **refuse** de commencer sans avoir cadré :

- la **langue source** réelle (parfois différente de celle déclarée) ;
- les **langues cibles** précises ;
- la **langue par défaut** (celle qui s'affiche en cas de fallback) ;
- les **variantes régionales** si pertinent (`fr-CH` vs `fr-FR`, `pt-BR` vs `pt-PT`) ;
- s'il faut **humaniser** les textes au passage.

10 secondes de cadrage évitent 2 heures de retravail. Le skill pose les questions une fois, sans les répéter, et les conserve dans le brief de traduction.

---

## Le détecteur de style IA

C'est la fonctionnalité signature.

Les modèles de langage ont une signature reconnaissable : les **tirets cadratins** (—) en boucle, à la place des virgules, des deux-points et des parenthèses. Un humain les utilise rarement. Un texte IA en abuse, parfois 3 par paragraphe, sur plusieurs paragraphes consécutifs.

Le skill compte ces tirets. Il **signale** les seuils suspects. Il **propose** des remplacements par la ponctuation locale naturelle : virgule pour une incise légère, deux-points pour une annonce, parenthèses pour une info secondaire, point pour autonomiser une idée.

À ça s'ajoute la détection des phrases creuses :

- *"dans le monde d'aujourd'hui"* ;
- *"solution innovante"* ;
- *"révolutionner"* ;
- *"expérience fluide"* ;
- *"de plus en plus"* ;
- *"il est important de"* ;
- *"découvrez comment"* ;
- *"Lorem ipsum"* oublié.

Si on traduit **avant** d'humaniser, le style IA se propage dans toutes les langues. Le skill propose donc d'**humaniser le source d'abord**, puis traduire.

---

## SEO multilingue qui marche

Un site multilingue mal configuré côté SEO se fait dédupliquer par Google. La version anglaise écrase la version allemande. Le canonical pointe vers la mauvaise URL. Les balises hreflang sont absentes ou non réciproques.

Le skill génère :

- balises `hreflang` réciproques avec `x-default` ;
- balise `<html lang>` correcte par locale ;
- `canonical` pointant sur la version courante ;
- `<title>` et `<meta description>` traduits ;
- balises `og:locale` et `og:locale:alternate` ;
- sitemap multilingue avec `xhtml:link` ;
- recommandations Search Console.

Et il **interdit** la redirection automatique sur `Accept-Language` : pour le SEO comme pour l'UX, c'est une mauvaise idée.

---

## Préservation des variables

Quand on traduit, on casse souvent les variables. `Welcome back, {name}!` devient `Bon retour, {nom} !` — et l'app crash.

Le skill préserve **automatiquement** :

- `{name}` (i18next, next-intl) ;
- `{{count}}` (Vue, Mustache) ;
- `%s`, `%d` (gettext, sprintf) ;
- `:user` (Laravel) ;
- `${var}` (template literals) ;
- `<0>...</0>` (Trans component) ;
- balises HTML inline.

Si une variable est cassée dans la traduction, le skill **signale** avant de livrer.

---

## Quatre modes selon le besoin

| Mode | Quand l'utiliser |
|---|---|
| **1. Audit only** | savoir où en est le site, sans rien modifier |
| **2. Plan** | préparer un plan validé par le client |
| **3. Traduction + humanisation** | exécuter la traduction réelle |
| **4. SEO multilingue final** | hreflang, sitemap, metadata |

Tu choisis. Le skill exécute. Il ne fait jamais plus que ce que tu as demandé.

---

## Deux scores honnêtes

À la fin :

- **Translation Quality Score** (0-100) — la traduction est-elle naturelle, fidèle, sans style IA, avec terminologie cohérente ?
- **Multilingual Site Readiness Score** (0-100) — le site est-il **vraiment** prêt pour l'international (hreflang, slugs, formats, emails, RTL) ?

Le skill ne flatte pas. Si le site est à 42, il dit 42. Si une zone est cassée, il pointe le fichier exact.

---

## Quand déléguer

Le skill ne fait pas tout. Quand la demande sort de son périmètre :

- **cohérence ergonomique** des menus / footers / routes existantes → `site-ux-guardian` ;
- **rédaction d'un article** from scratch → `seo-content-engine` ;
- **direction artistique** ou refonte créative pour le RTL → `premium-webdesigner` ;
- **audit production** complet (sécurité, perf, déploiement) → `production-auditor`.

Cette discipline évite les skills qui essaient de tout faire et finissent par mal faire.

---

## Pour qui

`multilingual-site-engine` est utile si tu :

- développes ou maintiens un site qui doit servir plusieurs marchés ;
- as un site qui traduit "un peu" mais où les emails, formulaires, slugs sont oubliés ;
- as un site dont les textes sentent l'IA après une génération brute ;
- veux ajouter une langue propre (avec hreflang, sitemap, slugs cohérents) ;
- veux migrer un système i18n vieillissant vers un moderne ;
- as une cible RTL et ne sais pas par où commencer.

Tu lances le skill. Tu réponds à 4 questions. Le skill fait le reste.

---

Created by João de Almeida
