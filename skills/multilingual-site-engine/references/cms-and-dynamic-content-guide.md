# Guide CMS et contenu dynamique multilingue — `multilingual-site-engine`

Comment gérer les contenus traduisibles qui ne sont **pas** dans le code mais dans une base de données ou un CMS.

Created by João de Almeida

---

## 1. Pourquoi le contenu dynamique est piégeux

Un site moderne mélange :

- du **texte statique** dans le code (boutons, labels) → fichiers i18n ;
- du **contenu dynamique** dans la DB (articles, produits, descriptions) → champs traduits ;
- du **menu dynamique** dans le CMS → version par langue ;
- des **catégories** et **tags** → traductions séparées ;
- des **slugs** générés → mapping par langue.

Si on traduit uniquement le statique sans le dynamique, le site reste à moitié monolingue.

---

## 2. WordPress

### 2.1 Plugins courants

| Plugin | Approche | Forces | Faiblesses |
|---|---|---|---|
| **WPML** | duplique chaque contenu, lien entre versions | très complet, gère menus, CF, taxonomies | payant, parfois lourd |
| **Polylang** | duplique chaque contenu | gratuit, simple | options moins riches |
| **TranslatePress** | overlay frontend | UX éditeur facile | moins SEO-ready par défaut |
| **MultilingualPress** | un site WordPress par langue (multisite) | séparation forte | architecture plus lourde |

### 2.2 Règle d'or

**Un seul plugin** par site. Si deux sont installés :
- désactiver l'un proprement ;
- exporter les contenus du plugin retiré ;
- migrer dans le plugin gardé.

### 2.3 Vérifications WordPress

- chaque **post** a une version par langue ;
- chaque **page** a une version par langue ;
- chaque **catégorie** est traduite ;
- chaque **tag** est traduit ;
- les **menus** ont une version par langue (Apparence → Menus) ;
- les **widgets** sont traduits si le plugin le supporte ;
- les **custom fields** (ACF) sont traduits si le plugin a un connecteur ;
- le **thème** est traduit (`/languages/`, `.po` / `.mo`) ;
- les **plugins** tiers sont traduits (chaînes externes) ;
- les **slugs** sont traduits ou non selon stratégie.

### 2.4 Points de vigilance

- **shortcode** avec contenu en dur → externaliser le texte ;
- **theme custom** sans text domain → ajouter `__()` partout ;
- **cron** ou **email automatique** dans le code thème → vérifier que le texte vient bien du système i18n.

---

## 3. Headless CMS

### 3.1 Contentful

- **locale par champ** : chaque champ peut être marqué comme localisé ;
- toutes les locales sont configurées dans le projet space ;
- les **slugs** doivent être marqués localisables ;
- API renvoie le champ dans la locale demandée.

### 3.2 Sanity

- **doublure de document par locale** (un document FR + un document EN avec un lien) ;
- **ou** champ localisé dans un document unique ;
- selon la stratégie choisie, le frontend doit savoir quelle locale chercher.

### 3.3 Strapi

- plugin **i18n** activé ;
- chaque **collection type** peut avoir l'i18n activé ou non ;
- **chaque entrée** a sa version par locale ;
- API : `/api/articles?locale=fr`.

### 3.4 Storyblok

- **locales** configurées dans le space ;
- chaque **story** a un onglet par locale ;
- **field-level** ou **folder-level** translations.

### 3.5 Prismic

- **locales** par environnement ;
- chaque **document** a une version par locale ;
- API : query avec paramètre `lang`.

### 3.6 Vérifications

- **toutes** les entrées critiques (pages, articles, produits) ont une version par locale ;
- les **références** (auteur, catégorie) sont localisées ou justifiées en cas de partage ;
- les **slugs** sont configurés par locale ;
- l'**API call** côté frontend passe bien la locale ;
- les **fallbacks** sont gérés (si pas de version FR, montrer EN avec un avertissement).

---

## 4. Frameworks et CMS sur mesure

### 4.1 Modèle de DB

Si la DB est custom, vérifier le pattern :

**Pattern 1 — Colonnes par langue**
```sql
articles (id, title_fr, title_en, content_fr, content_en, ...)
```
→ rapide à coder, lourd si beaucoup de langues, pas scalable.

**Pattern 2 — Table de traductions**
```sql
articles (id, slug, ...)
article_translations (id, article_id, locale, title, content, ...)
```
→ scalable, recommandé.

**Pattern 3 — JSON localisé**
```sql
articles (id, title JSONB, content JSONB)
-- title = {"fr": "Titre", "en": "Title"}
```
→ flexible, attention aux index pour la recherche.

### 4.2 Slug

Stocker le slug par langue :

```sql
article_translations (id, article_id, locale, slug, title, content)
```

L'unicité du slug est **par locale**, pas globale.

---

## 5. Catégories et taxonomies

Les catégories sont du **contenu dynamique**. Elles doivent être :

- traduites par langue ;
- avec un **slug** par langue (`/fr/categorie/voyage` vs `/en/category/travel`) ;
- accessibles dans toutes les listes (filtres, breadcrumbs, sitemaps).

---

## 6. Champs custom et metadata

Ne pas oublier :

- **descriptions** et **excerpts** ;
- **alt text** des images ;
- **legends** des images ;
- **metadata SEO custom** (si plugin SEO comme Yoast, RankMath) ;
- **OpenGraph** et **Twitter Card** custom ;
- **schema.org** JSON-LD.

---

## 7. Hardcoding bloquant

Signaler quand du contenu **devrait** être dynamique mais est codé en dur :

- titre de la home dans le composant Hero plutôt que dans le CMS ;
- description "À propos" dans le code plutôt qu'éditable ;
- prix d'un produit en dur (catastrophe pour l'i18n monnaie) ;
- date d'événement en dur.

→ Recommander une externalisation.

---

## 8. Performance

- **lazy load** par locale si beaucoup de contenu ;
- **cache** par locale (CDN avec variation par URL) ;
- **prefetch** des locales utilisées fréquemment ;
- **bundle splitting** des messages i18n par route.

---

## 9. Recherche multilingue

Si le site a une recherche :

- index par langue (Algolia, Meilisearch, Elasticsearch supportent les analyseurs par langue) ;
- la recherche FR ne doit pas remonter des résultats EN (sauf fallback explicite) ;
- les **stop words** et **stemming** sont par langue.

---

## 10. Anti-patterns

- contenus traduits **partiellement** (titre traduit, corps en source) ;
- **mélange** de plugins WordPress ;
- duplication par **copy / paste** sans lien entre versions ;
- **slugs** identiques entre langues sans mapping (collision possible) ;
- **fallback** non géré (la page n'existe pas → 404 brut au lieu de fallback langue par défaut) ;
- **catégories** créées séparément par langue sans lien (statistiques fragmentées) ;
- **alt text** d'image non traduit ;
- **schema.org** dans une seule langue.

---

## 11. Checklist contenu dynamique

- [ ] modèle de DB / CMS adapté à plusieurs locales ;
- [ ] toutes les entrées critiques traduites ;
- [ ] catégories et tags traduits ;
- [ ] slugs configurés par locale ;
- [ ] alt text traduit ;
- [ ] excerpts / descriptions traduits ;
- [ ] metadata SEO custom traduits ;
- [ ] schema.org / JSON-LD traduit ;
- [ ] fallback géré ;
- [ ] recherche par langue ;
- [ ] cache par locale ;
- [ ] cohérence avec le statique (mêmes termes côté code et côté CMS).

---

Created by João de Almeida
