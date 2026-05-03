# Guide de sourcing d'images — `premium-webdesigner`

Comment choisir, sourcer, organiser et créditer les images d'un projet.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. Avant de chercher

**Toujours** définir avant d'ouvrir une banque d'images :

- **Sujet** précis (pas "business" → "femme codant sur laptop, lumière naturelle, ambiance studio") ;
- **Ambiance** (chaleureux / froid / clinique / artisanal / luxueux / urbain) ;
- **Palette** dominante (chaude / froide / monochrome / saturée / désaturée) ;
- **Cadrage** (portrait / paysage / square / pleine bleed) ;
- **Cohérence** avec le texte de la section (image hero ≠ blog post : pas le même crop) ;
- **Mobile / desktop** (l'image doit fonctionner aux deux ratios) ;
- **Format final** (WebP préféré, JPEG en fallback, PNG si transparence requise).

Sans ces critères, on télécharge la 1re image qui semble correcte. Résultat : incohérence + clichés.

---

## 2. Ordre de priorité des sources

```
1. Images existantes du projet     (assets/, public/, media/, uploads/)
2. Images fournies par l'utilisateur (en input direct)
3. Pixabay API                      (PIXABAY_API_KEY requis)
4. Unsplash API                     (UNSPLASH_ACCESS_KEY requis)
5. Placeholder propre               (uniquement si rien d'autre)
```

**Toujours** vérifier les niveaux 1–2 **avant** de générer / chercher en ligne. Beaucoup de projets ont déjà des images cohérentes inutilisées.

---

## 3. Pixabay (priorité haute si clé dispo)

- API : https://pixabay.com/api/docs/
- Endpoint images : `https://pixabay.com/api/?key=<KEY>&q=<keywords>&...`
- Endpoint vidéos : `https://pixabay.com/api/videos/?key=<KEY>&q=<keywords>&...`
- Licence : libre (commercial OK, attribution non requise mais appréciée).

**Bonnes pratiques :**

- charger la clé via `PIXABAY_API_KEY` (variable d'env) ;
- **jamais** de clé hardcodée dans le code ;
- requêtes spécifiques (`mots-clés métier`) plutôt que génériques (`business`, `office`) ;
- vérifier la qualité (variable selon auteur) ;
- préférer des images > 1920 px de large pour le hero.

**Exemple d'appel sécurisé (Node) :**

```js
const apiKey = process.env.PIXABAY_API_KEY;
if (!apiKey) throw new Error('PIXABAY_API_KEY missing');
const url = `https://pixabay.com/api/?key=${apiKey}&q=${encodeURIComponent(keywords)}&image_type=photo&orientation=horizontal&per_page=20`;
```

---

## 4. Unsplash

- API : https://unsplash.com/documentation
- Licence : libre + commercial OK + attribution requise (crédit photographe + lien Unsplash).

**Bonnes pratiques :**

- charger la clé via `UNSPLASH_ACCESS_KEY` ;
- **jamais** hardcodée ;
- ajouter le **crédit** dans `docs/image-credits.md` ;
- éviter la 1re page de résultats (vue partout) — descendre dans les pages 3–5.

---

## 5. Mots-clés par secteur

### SaaS / tech / productivité

- `abstract technology`, `workstation clean`, `digital workflow` ;
- `dashboard interface`, `code environment`, `developer setup` ;
- `soft gradient abstract`, `geometric pattern`, `light gradient` ;
- `AI assistant interface`, `data visualization`, `analytics screen` ;
- éviter : `business meeting`, `handshake`, `office team` (clichés corporate).

### Association locale / événementiel

- `community gathering`, `local event`, `village fête` ;
- `cultural activity`, `artistic workshop`, `volunteer hands` ;
- `people enjoying outdoor`, `families together` ;
- éviter : photos posées trop "stock", privilégier candid / reportage.

### Musique / label / DJ / studio

- `studio equipment`, `mixing console`, `vinyl record` ;
- `DJ booth`, `stage lights`, `concert crowd` ;
- `electronic music production`, `audio waveform abstract`, `sound waves` ;
- `recording session`, `microphone studio`.

### Tatoueur / artiste / studio

- `tattoo studio`, `tattoo machine`, `ink texture` ;
- `artist hands working`, `urban wall`, `street art texture` ;
- `black and white portrait`, `abstract body art`, `minimalist tattoo`.

### Sport / basket / urban

- `basketball court`, `team spirit`, `urban sport` ;
- `youth basketball`, `dynamic action`, `sport silhouette` ;
- `street basketball`, `outdoor court sunset`.

### Restaurant / gastronomie

- `restaurant interior warm`, `gastronomic plate`, `chef working` ;
- `wine glass elegant`, `dish plating`, `kitchen action` ;
- éviter : `food blog stock`, `couple eating clichéd`.

### Coiffeur / beauté

- `salon interior modern`, `hair styling action`, `beauty product detail` ;
- `hair color palette`, `barber tools`, `salon lighting`.

### Boutique / e-commerce / mode

- `product photography clean`, `flat lay minimalist`, `boutique window` ;
- `model editorial`, `fashion accessory detail`.

---

## 6. Anti-patterns image

À **éviter absolument** :

- équipe en costume + tablette autour table en verre (corporate cliché niveau 1) ;
- mains d'inconnus sur clavier (ennuyeux) ;
- ampoule lumineuse symbolisant "idée" ;
- poignée de main symbolisant "deal" ;
- flèche montante symbolisant "growth" ;
- robot mignon symbolisant "IA" ;
- gens souriants au téléphone sans contexte ;
- background "city skyline at night" sans rapport ;
- mix de styles incohérents (1 photo + 1 illustration + 1 3D = chaos visuel).

---

## 7. Structure de dossier images

**Structure recommandée** (créée par `scripts/prepare-image-assets-folder.sh`) :

```
public/assets/images/
├── hero/
│   ├── homepage-hero.webp
│   └── homepage-hero@2x.webp
├── sections/
│   ├── feature-1-bento.webp
│   ├── feature-2-bento.webp
│   └── testimonials/
│       ├── jane-doe.webp
│       └── john-smith.webp
└── placeholders/
    └── default-card.svg
```

Si la structure du projet est différente (`assets/`, `media/`, `static/`), respecter celle-ci.

**Conventions de nommage :**

- minuscules, kebab-case ;
- préfixe par usage (`hero-`, `feature-`, `team-`, `bg-`) ;
- suffixe `@2x` ou `-large` pour version retina ;
- format `.webp` en priorité, `.jpg` en fallback ;
- éviter les noms sans contexte (`image1.jpg`, `IMG_4823.jpeg`).

---

## 8. Documentation des images

**Toujours** documenter dans `docs/image-credits.md` :

```markdown
# Image credits

## Hero

- `public/assets/images/hero/homepage-hero.webp`
  - Source : Unsplash
  - URL : https://unsplash.com/photos/<id>
  - Photographe : Jane Doe ([@janedoe](https://unsplash.com/@janedoe))
  - Licence : Unsplash License (libre, commercial)
  - Crédit affiché : oui (footer + cette page)

- `public/assets/images/hero/homepage-fallback.jpg`
  - Source : Pixabay
  - URL : https://pixabay.com/photos/...
  - Auteur : John Smith
  - Licence : Pixabay Content License
  - Crédit affiché : non requis
```

Remplir aussi le template `templates/image-selection.template.md` pour la traçabilité interne.

---

## 9. `alt text` — règles

- **alt non vide** sur toute image **informative** (qui apporte du contenu) ;
- **alt=""** (vide explicite) sur images **décoratives** (background, séparateur visuel) ;
- alt **descriptif** (pas `image1`, pas `photo`) ;
- alt **court** (≤ 125 caractères idéalement) ;
- alt **localisé** (français si site français) ;
- **ne pas** répéter le `<title>` ou la légende dans le alt.

**Exemples :**

- ✅ `alt="Femme développeuse travaillant sur un laptop dans un bureau lumineux"`
- ✅ `alt=""` (image décorative de fond)
- ❌ `alt="image"` (inutile)
- ❌ `alt="hero"` (contexte interne, pas description)

---

## 10. Optimisation

Avant utilisation en prod :

- compresser (WebP qualité 80–90 selon usage) ;
- redimensionner (pas un hero 4000 × 3000 px pour un affichage 1200 × 600) ;
- générer 2 résolutions : standard + retina (`@2x`) ;
- utiliser `<picture>` avec WebP + JPEG fallback :
  ```html
  <picture>
    <source srcset="hero.webp" type="image/webp">
    <img src="hero.jpg" alt="..." width="1200" height="600">
  </picture>
  ```
- **lazy-load** les images en dessous de la ligne de flottaison (`loading="lazy"`) ;
- **eager** + `fetchpriority="high"` sur le hero pour LCP.

---

## 11. Si aucune image disponible

**Placeholder propre** :

- gradient subtil (2 couleurs proches du design system) + icône SVG centrale ;
- **pas** de "lorem ipsum" visuel (gros bandeau gris avec texte "PLACEHOLDER") qui donne un aspect inachevé ;
- mentionner clairement à l'utilisateur que ce sont des placeholders à remplacer ;
- ne **jamais** prétendre que ce sont les images finales.

Exemple SVG placeholder :

```html
<svg viewBox="0 0 1200 600" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="g" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="#1e293b"/>
      <stop offset="100%" stop-color="#334155"/>
    </linearGradient>
  </defs>
  <rect width="1200" height="600" fill="url(#g)"/>
  <text x="50%" y="50%" fill="#94a3b8" font-family="sans-serif" font-size="14" text-anchor="middle">
    Image à remplacer
  </text>
</svg>
```

---

## 12. Licences — récap rapide

| Source | Licence | Attribution | Commercial |
|---|---|---|---|
| Pixabay | Pixabay Content License | non requise | OK |
| Unsplash | Unsplash License | non requise (mais appréciée) | OK |
| Pexels | Pexels License | non requise | OK |
| Freepik | Free / Premium selon | requise (free) | OK |
| Adobe Stock | Selon abonnement | requise | OK avec licence |
| Photo perso de l'utilisateur | propriété utilisateur | N/A | dépend de l'autorisation des sujets |
| Photo client | propriété client | autorisation requise | dépend de l'accord |

**En cas de doute :** demander l'autorisation par écrit, ou ne pas utiliser.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
