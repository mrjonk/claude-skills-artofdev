# Discipline d'édition de fichier — `site-ux-guardian`

Comment identifier le **bon fichier** à modifier avant chaque correction.

Created by João de Almeida

---

## 1. Pourquoi cette discipline est critique

Modifier le **mauvais** fichier provoque :

- des corrections **invisibles** (le fichier n'est pas celui qui rend la page) ;
- des **conflits** au prochain build / déploiement ;
- des **doublons** si on duplique un composant au lieu de modifier l'existant ;
- de la **dette** technique permanente.

**Règle d'or :** **identifier le fichier exact AVANT de modifier**, jamais après.

---

## 2. Avant chaque modification — 5 questions

1. **Quel fichier exact** vais-je modifier ?
2. **Pourquoi** ce fichier précisément ?
3. **Quelles pages** seront affectées ?
4. **Quel est le risque** ?
5. **Comment vais-je tester** la modification ?

Si l'une de ces questions n'a pas de réponse claire, **arrêter**.

---

## 3. Fichiers à NE JAMAIS modifier

| Type | Pourquoi |
|---|---|
| `node_modules/**` | dépendances, écrasées au prochain `npm install` |
| `vendor/**` | dépendances Composer, écrasées |
| `dist/`, `build/`, `.next/`, `.nuxt/`, `out/` | générés automatiquement |
| `*.min.js`, `*.min.css` | minifiés (modifier les sources) |
| `package-lock.json`, `yarn.lock`, `composer.lock` | générés automatiquement |
| `.git/**` | structure git |
| `*.generated.*` | fichiers générés |
| `wp-includes/**` (WordPress) | core WordPress |
| `wp-admin/**` (WordPress) | core admin WordPress |
| Fichiers d'un thème **parent** WordPress | utiliser un thème enfant |
| Fichiers dans `bin/`, `obj/` (.NET) | compilés |

→ Si on doit modifier ce qui semble être un fichier généré, **chercher la source** d'abord.

---

## 4. Fichiers à PRIVILÉGIER

| Cas | Fichier à modifier |
|---|---|
| Menu / header global | layout principal du framework, **pas** chaque page |
| Footer global | layout principal du framework |
| Variables de style (couleur, font) | fichier de tokens (`_variables.scss`, `tailwind.config.js`, `:root` CSS) |
| Routes | fichier de routes du framework (`routes/web.php`, `app/router.tsx`) |
| Texte de copyright | composant Footer / template footer |
| Logo SVG | fichier SVG dans `assets/` (importé partout) |
| Locales / traductions | fichiers de locales (`fr.json`, `en.json`) |
| Configuration | fichier `.env.example` ou config dédiée (jamais hardcoder) |

---

## 5. Identifier le bon fichier — par stack

### WordPress

| Modification voulue | Fichier à modifier |
|---|---|
| Header global | `wp-content/themes/<theme-enfant>/header.php` |
| Footer global | `wp-content/themes/<theme-enfant>/footer.php` |
| Page personnalisée | `wp-content/themes/<theme-enfant>/page-<slug>.php` |
| Style général | `wp-content/themes/<theme-enfant>/style.css` |
| Fonctions custom | `wp-content/themes/<theme-enfant>/functions.php` |
| **Plugin custom** | `wp-content/plugins/<plugin>/...` (jamais le core WP) |

> Si le projet n'a pas de thème enfant, **proposer** d'en créer un avant toute modification du thème.

### Next.js (App Router)

| Modification voulue | Fichier à modifier |
|---|---|
| Header global | `app/layout.tsx` (ou composant `<Header />` partagé) |
| Footer global | `app/layout.tsx` (ou composant `<Footer />`) |
| Page spécifique | `app/<route>/page.tsx` |
| Layout de section | `app/<section>/layout.tsx` |
| Routes | structure de dossiers `app/` (pas un fichier de config) |
| Styles globaux | `app/globals.css` |
| Tokens design | `tailwind.config.js` ou `app/globals.css` |

### Next.js (Pages Router)

| Modification voulue | Fichier à modifier |
|---|---|
| Header / Footer global | `pages/_app.tsx` |
| Page spécifique | `pages/<route>.tsx` |
| Routes | structure `pages/` |

### React (Vite, CRA)

- composants partagés dans `src/components/` ;
- routes via React Router → `src/routes.tsx` ou similaire.

### Vue / Nuxt

| Modification voulue | Fichier à modifier |
|---|---|
| Layout par défaut | `layouts/default.vue` |
| Header / Footer | composants importés dans le layout |
| Page | `pages/<route>.vue` |

### Laravel

| Modification voulue | Fichier à modifier |
|---|---|
| Layout principal | `resources/views/layouts/app.blade.php` |
| Header partial | `resources/views/partials/header.blade.php` |
| Footer partial | `resources/views/partials/footer.blade.php` |
| Page | `resources/views/<route>.blade.php` |
| Routes | `routes/web.php` |

### PHP custom

- chercher `header.php`, `footer.php`, ou les `include` ;
- si rien n'existe, **proposer** la création de partials avant modification.

### ASP.NET WebForms

- `Site.Master` pour le layout principal ;
- `*.aspx` pour les pages individuelles ;
- `web.config` pour la configuration.

### Astro

- `src/layouts/Layout.astro` pour le layout principal ;
- `src/components/<X>.astro` pour les composants partagés ;
- `src/pages/<route>.astro` pour les pages.

---

## 6. Avant de modifier — checklist rapide

- [ ] j'ai identifié le **fichier exact** ;
- [ ] le fichier **n'est pas** dans la liste § 3 (à éviter) ;
- [ ] j'ai vérifié que le fichier est **bien le source** (pas un fichier généré ou minifié) ;
- [ ] j'ai estimé l'**impact** (combien de pages affectées) ;
- [ ] je peux **annuler** la modification facilement (`git revert` ou éditeur Undo) ;
- [ ] j'ai un **test rapide** prévu (recharger la page, lancer le build, vérifier le rendu).

---

## 7. Anti-patterns à signaler

### Modifier 12 pages au lieu d'un layout

```
✗ pages/index.html (modif menu)
✗ pages/about.html (modif menu)
✗ pages/contact.html (modif menu)
✗ ... (10 autres pages)
```

→ Un layout / composant partagé existe (ou doit exister). Modifier le layout, pas les pages.

### Hardcoder dans le composant ce qui devrait venir d'une config

```jsx
// ✗ Mauvais
<a href="https://example.com/social/twitter">Twitter</a>

// ✓ Bon
<a href={config.socials.twitter}>Twitter</a>
```

### Hardcoder dans le composant ce qui vient de la DB

```jsx
// ✗ Mauvais (remplace une donnée dynamique)
<h1>Restaurant Le Jardin</h1>

// ✓ Bon (utilise les données existantes)
<h1>{site.name}</h1>
```

→ **Règle absolue** : `site-ux-guardian` ne hardcode **jamais** une valeur qui vient d'une base de données ou d'une config dynamique.

### Modifier un fichier de config commit é à la place de la config locale

- `.env.production` est en général **ignoré** par git ;
- ne pas modifier `.env.example` pour y mettre des vraies valeurs ;
- `.env.example` doit contenir uniquement des **placeholders**.

### Créer un nouveau fichier au lieu de modifier l'existant

- créer `Footer-v2.tsx` au lieu de modifier `Footer.tsx` = anti-pattern.
- préférer **modifier en place** + commit ; ou **migrer** progressivement avec une PR claire.

---

## 8. Plan de modification — `templates/file-change-plan.template.md`

```markdown
| Fichier | Raison | Impact (pages) | Risque | Validation requise |
|---|---|---|---|---|
| `app/layout.tsx` | ajout du lien `Privacy` dans le footer | toutes les pages publiques | aucun (ajout simple) | non |
| `pages/about.tsx` | typo dans le titre | uniquement /about | aucun | non |
| `wp-content/themes/twenty-twenty-three/functions.php` | ajout d'un shortcode | toutes les pages utilisant le shortcode | moyen (PHP, peut casser) | oui (test sur staging d'abord) |
```

---

## 9. Tests rapides post-modification

| Type de modification | Test |
|---|---|
| CSS / style | recharger la page, vérifier le rendu mobile + desktop |
| JS / logique | tester l'interaction concernée |
| Routes | vérifier que toutes les pages liées chargent |
| Header / Footer | vérifier sur 3+ pages (home, page interne, page admin si applicable) |
| Texte / contenu | vérifier la page concernée + la page de listing si applicable |
| Composant partagé | vérifier les usages connus (lister via `grep`) |

---

## 10. Documentation des modifications

Après chaque modification importante, ajouter une **note** dans le rapport :

```markdown
## Fichiers modifiés (Mode 2 — corrections sûres)

| Fichier | Modification | Annulable par |
|---|---|---|
| `app/layout.tsx` | ajout du lien `Privacy` dans le footer | `git revert` |
| `app/components/Header.tsx` | active state ajouté sur le lien `/about` | `git revert` |
| `pages/contact.html` | `<title>` ajouté (manquait) | `git revert` |
```

---

Created by João de Almeida
