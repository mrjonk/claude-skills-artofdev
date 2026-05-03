# Guide routes et slugs multilingues — `multilingual-site-engine`

5 stratégies de localisation des URL, comment choisir, comment implémenter.

Created by João de Almeida

---

## 1. Pourquoi la stratégie d'URL compte

L'URL est :

- un **signal SEO** ;
- une **promesse** sur la langue affichée ;
- un **lien** que les utilisateurs partagent ;
- un **point d'ancrage** pour les balises `hreflang` et `canonical`.

Une mauvaise stratégie d'URL peut détruire le SEO multilingue, la maintenance, et l'UX.

---

## 2. Les 5 stratégies

### 2.1 Sous-dossier (recommandé par défaut)

```
site.com/fr/contact
site.com/en/contact
site.com/de/contact
```

**Avantages :**
- une seule autorité de domaine partagée (bon pour le SEO) ;
- simple à mettre en place dans la plupart des frameworks ;
- maintenance unique ;
- `hreflang` faciles à gérer.

**Inconvénients :**
- pas de signal géographique fort.

**Quand l'utiliser :**
- choix par défaut pour la grande majorité des sites ;
- sites SaaS, vitrines, blogs, contenus.

### 2.2 Sous-domaine

```
fr.site.com/contact
en.site.com/contact
de.site.com/contact
```

**Avantages :**
- séparation propre par langue ;
- équipes / déploiements indépendants possibles ;
- signal de localisation plus fort.

**Inconvénients :**
- domain authority **non partagée** entre sous-domaines ;
- configuration DNS et SSL plus complexe ;
- duplication d'infrastructure si chaque sous-domaine est un déploiement séparé.

**Quand l'utiliser :**
- grandes structures avec équipes par marché ;
- contenus très différents par langue (pas juste traduction).

### 2.3 Domaine séparé

```
site.fr/contact
site.com/contact
site.de/contact
```

**Avantages :**
- branding local fort ;
- meilleur signal géographique ;
- peut s'aligner sur des marchés très distincts.

**Inconvénients :**
- coût d'achat et de renouvellement des domaines ;
- domain authority à construire **par domaine** ;
- grosse complexité (SSL, DNS, sitemap par domaine, mais hreflang inter-domaines) ;
- migration future difficile.

**Quand l'utiliser :**
- gros marchés établis (e-commerce international, multinationales) ;
- besoin de différencier complètement le branding local.

### 2.4 Paramètre URL

```
site.com/contact?lang=fr
site.com/contact?lang=en
```

**Avantages :**
- aucune modification de routing ;
- très rapide à implémenter.

**Inconvénients :**
- **mauvais SEO** (Google peut considérer comme une seule page) ;
- mauvaise UX (URL moins propre) ;
- canonical compliqué.

**Quand l'utiliser :**
- **rarement**. Site interne ou MVP éphémère.

### 2.5 Slug traduit

```
site.com/fr/nous-contacter
site.com/en/contact-us
site.com/de/kontakt
```

**Avantages :**
- meilleure UX locale ;
- meilleur SEO local (mots-clés natifs dans l'URL) ;
- partage social plus naturel.

**Inconvénients :**
- **plus de travail** : mapping FR ↔ EN ↔ DE ;
- les **changements** de slug doivent être propagés ;
- maintenance d'une **table de routes** ;
- gestion des redirections si un slug change.

**Quand l'utiliser :**
- sites premium ;
- e-commerce avec catégories localisées ;
- blog avec catégories localisées ;
- volonté SEO local fort.

---

## 3. Choisir une stratégie

### Arbre de décision

1. Plusieurs marchés avec branding distinct ? → **domaine séparé**.
2. Équipes / contenus indépendants par langue ? → **sous-domaine**.
3. Volonté SEO local fort + budget ? → **sous-dossier + slugs traduits**.
4. Site standard, contenus identiques traduits ? → **sous-dossier**.
5. MVP / interne / contraintes fortes ? → **paramètre** (en dernier recours).

### Règle d'or

**Une seule stratégie** sur tout le site. Pas de mélange.

---

## 4. Mapping entre versions linguistiques

Avec slugs traduits, il faut mapper :

```json
{
  "contact": {
    "fr": "nous-contacter",
    "en": "contact-us",
    "de": "kontakt"
  },
  "pricing": {
    "fr": "tarifs",
    "en": "pricing",
    "de": "preise"
  },
  "blog": {
    "fr": "journal",
    "en": "blog",
    "de": "blog"
  }
}
```

Ce mapping sert :
- au **routing** (résoudre la page) ;
- au **switch langue** (envoyer vers le bon slug) ;
- aux **balises hreflang** ;
- aux **liens internes**.

---

## 5. Slugs CMS

### WordPress
- WPML duplique les posts, chaque version a son slug ;
- Polylang idem ;
- gérer les **catégories** et **tags** traduits aussi.

### Headless CMS
- Contentful : champ slug par locale ;
- Sanity : doublure de document ou champ localisé ;
- Strapi : i18n plugin avec slug par locale ;
- Storyblok : slug différent par locale.

### Génération automatique vs manuelle

- **manuelle** : qualité supérieure, plus de travail ;
- **automatique** (translate API) : vite mais qualité variable ;
- **hybride** : auto puis relecture humaine.

---

## 6. Slugs à ne pas traduire

| Type | Pourquoi |
|---|---|
| Identifiants techniques | (`/api/v1/users`) — codes |
| Routes auth | (`/login`, `/logout`) — souvent gardées EN par convention |
| Routes admin | (`/admin`, `/dashboard`) — à voir selon contexte |
| Slugs de produits avec référence | (`/products/SKU-12345`) |

→ Décider tôt et **garder cohérent**.

---

## 7. Redirections

### 7.1 Quand un slug change

Si `/fr/nous-contacter` devient `/fr/contact`, créer une **redirection 301**.

### 7.2 Pas de détection automatique par langue navigateur

Cf. `seo-hreflang-guide.md`. **Ne pas** rediriger automatiquement par `Accept-Language`.

### 7.3 Redirections de page racine

Si l'utilisateur arrive sur `site.com/` (sans locale), proposer :

- soit **afficher** la langue par défaut directement (sans redirection) ;
- soit **rediriger** vers `/{defaultLocale}/` (souvent plus propre pour le routing).

Choix à documenter.

---

## 8. Switch de langue

### Bon comportement

- visible **partout** ;
- redirige vers la **même page** dans l'autre langue (`/fr/contact` → `/en/contact`) ;
- pas vers la home (perte d'UX classique) ;
- mémorise le choix dans un cookie/storage.

### Mauvais comportement

- redirige toujours vers `/en/` quelle que soit la page courante ;
- absent en mobile ;
- caché dans le footer uniquement ;
- difficile à voir.

---

## 9. Liens internes

Avec routes localisées, **chaque** lien interne doit pointer vers la **bonne version** :

```html
<!-- Mauvais (sur /fr/about) -->
<a href="/contact">Contact</a>  <!-- ambigu -->

<!-- Bon -->
<a href="/fr/contact">Contact</a>
```

Un système de helper (`localizedHref('contact')`) évite les erreurs.

---

## 10. Anti-patterns

- **un mélange** de stratégies (sous-dossier + sous-domaine ensemble sans raison) ;
- **slugs hardcodés** dans le composant (au lieu de venir d'un mapping) ;
- **switch langue cassé** (perte du chemin courant) ;
- **redirection auto** sur `Accept-Language` ;
- **slugs traduits non mappés** (la version anglaise existe mais le bouton ne la trouve pas) ;
- **collision de slug** (un slug FR identique à un slug EN technique) ;
- **incohérence majuscule** (`/contact` et `/Contact`).

---

## 11. Checklist routes

- [ ] stratégie unique choisie et documentée ;
- [ ] toutes les pages traduites suivent la stratégie ;
- [ ] mapping slug FR ↔ EN ↔ DE ↔ ... existe (si slugs traduits) ;
- [ ] switch langue redirige vers la même page traduite ;
- [ ] pas de redirection automatique par langue ;
- [ ] redirections 301 en place pour les anciens slugs ;
- [ ] sitemap par langue à jour ;
- [ ] balises `hreflang` cohérentes avec les routes ;
- [ ] liens internes localisés.

---

Created by João de Almeida
