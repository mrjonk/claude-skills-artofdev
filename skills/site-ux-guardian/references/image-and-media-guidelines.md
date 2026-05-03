# Guide images et médias — `site-ux-guardian`

Comment choisir, optimiser et documenter les images d'un site.

Created by João de Almeida

---

## 1. Choisir les images

### Règles

- **cohérentes** avec le contenu (pas une image stock générique sans rapport) ;
- **cohérentes** entre elles (toutes en photo réaliste, ou toutes en illustration vectorielle, etc.) ;
- **alt text** non vide sur images informatives ;
- **alt vide** explicite (`alt=""`) sur images décoratives ;
- **ratio cohérent** (toutes en 16:9 ou 4:3, pas un mix arbitraire) ;
- **optimisées** (WebP qualité 80–85, dimensions adaptées).

### Anti-patterns à signaler

- équipe en costume autour table en verre (cliché stock) ;
- mains anonymes sur clavier ;
- ampoule lumineuse symbolisant *"idée"* ;
- poignée de main symbolisant *"deal"* ;
- robot mignon symbolisant *"IA"* ;
- flèche montante symbolisant *"growth"* ;
- city skyline at night sans rapport ;
- gens souriant à la caméra dans un contexte business (forcé, stock) ;
- mix photo + illustration plate + 3D dans la même page (chaos visuel).

---

## 2. Cohérence avec le contenu

### Règle centrale

L'image doit **renforcer** le message du contenu, pas le décorer.

### Bons exemples

- article *"Comment configurer Stripe en 5 minutes"* → screenshot du dashboard Stripe ;
- page produit *"App de time tracking"* → mockup réel de l'app ;
- article éditorial sur la productivité → photo ambiance de workstation, pas une stock corporate.

### Mauvais exemples

- article technique sur les API → photo stock *"businessman with tablet"* ;
- page *"À propos de notre équipe"* → photos d'avatars génériques (mannequins) ;
- article sur les bonnes pratiques de sécurité → ampoule lumineuse "idée" ;
- mini CMS pour coiffeur → photo générique de bureaux modernes.

---

## 3. Alt text

### Règles

- **non vide** sur images **informatives** ;
- **vide explicite** (`alt=""`) sur images **décoratives** (background, séparateur visuel) ;
- **descriptif** : *"Femme développeuse sur un laptop dans un bureau lumineux"*, **pas** `alt="image"` ;
- **localisé** (français si site français) ;
- **court** (≤ 125 caractères idéalement) ;
- **ne répète pas** le `<title>` ou la légende ;
- **sans** *"image de"*, *"photo de"* (le screen reader le sait déjà).

### Bons exemples

- ✅ `alt="Tableau de bord de gestion de tâches montrant 4 KPI : tâches du jour, en retard, terminées, et taux de complétion."`
- ✅ `alt=""` (image décoratrice du fond du hero)
- ✅ `alt="Logo de l'entreprise"` (logo)

### Mauvais exemples

- ❌ `alt="image"`
- ❌ `alt="hero"`
- ❌ `alt="dashboard.jpg"`
- ❌ `alt="banner-final-v2.png"`

---

## 4. Ratios cohérents

### Règles

- choisir **un ratio par type d'image** (hero, card, avatar, miniature) ;
- **ne pas mélanger** les ratios sur des éléments similaires.

### Ratios courants

| Type | Ratio | Cas |
|---|---|---|
| Hero | 2:1 ou 16:9 | bannière en haut de page |
| Card miniature | 16:9 ou 4:3 | grille de cards |
| Card carré | 1:1 | listings, témoignages |
| Avatar | 1:1 (cercle ou carré) | utilisateurs |
| Article cover | 16:9 ou 21:9 | blog hero |
| Logo | variable (souvent SVG) | marque |

### Anti-patterns

- 3 cards avec ratios 16:9 / 4:3 / 1:1 mixés ;
- avatars rectangulaires, certains ronds, certains carrés ;
- hero portrait sur desktop (image ne se voit pas en entier).

---

## 5. Optimisation

### Règles

- **format** : WebP qualité 80–85 (fallback JPEG) ;
- **PNG** uniquement si transparence ou logo SVG simple ;
- **dimensions** adaptées à l'usage (pas un hero 4000 × 3000 px pour un affichage 1200 × 600) ;
- **2 résolutions** : standard + retina (`@2x`) ;
- **`<picture>`** avec srcset pour responsive ;
- **`width`** + **`height`** explicites pour éviter CLS ;
- **lazy-load** sur images sous la ligne de flottaison ;
- **eager** + `fetchpriority="high"` sur le hero LCP.

### Exemple

```html
<picture>
  <source srcset="hero-1920w.webp 1920w, hero-960w.webp 960w" type="image/webp">
  <source srcset="hero-1920w.jpg 1920w, hero-960w.jpg 960w" type="image/jpeg">
  <img src="hero-1920w.jpg" alt="..." width="1920" height="960" fetchpriority="high">
</picture>
```

### Poids cibles

| Type | Poids cible (WebP) |
|---|---|
| Hero | < 150 Ko |
| Card miniature | < 50 Ko |
| Avatar | < 30 Ko |
| Logo SVG | < 10 Ko |

---

## 6. Hero images — règles spécifiques

### Règles

- **focus visuel** clair (sujet bien cadré) ;
- **espace** pour le texte qui passe par-dessus (overlay si nécessaire) ;
- **mobile** : version recadrée ou alternative ;
- **contraste** suffisant entre texte et image ;
- **chargement rapide** (LCP < 2.5 s).

### Anti-patterns

- hero pixelisé ;
- hero portrait sur desktop (image coupée) ;
- texte illisible sur image claire / chargée ;
- hero 4 Mo qui plombe le LCP.

---

## 7. Placeholders

### Quand les utiliser

- pendant le développement, avant que les vraies images soient livrées ;
- pour des images qui dépendent de données dynamiques (avatars utilisateurs absents).

### Patterns

- **gradient subtil + icône SVG** (le plus propre) ;
- **couleur unie** + initiales (avatars) ;
- **image floutée** placeholder (LQIP, BlurHash) puis image réelle.

### Anti-patterns

- placeholder gris générique avec texte *"PLACEHOLDER"* ;
- placeholder qui reste en prod (image jamais remplacée) ;
- placeholder lourd (1 Mo de gris).

---

## 8. Crédits

### Règles

- **toujours** documenter la source des images :
  - Unsplash : crédit photographe + lien (recommandé) ;
  - Pixabay : crédit non requis mais bienvenu ;
  - Pexels : crédit recommandé ;
  - photos client : autorisation écrite ;
  - photos perso : propriété propre.

### Format

```markdown
## Crédits images

- Hero homepage : photo par {{Prénom Nom}} sur Unsplash. https://unsplash.com/photos/...
- Section feature 1 : capture interne.
- Avatars testimonials : photos clients (autorisations reçues).
```

→ À placer dans `docs/image-credits.md` ou en pied de page.

---

## 9. Vidéos

### Règles

- **autoplay** uniquement si **muted** ;
- **contrôles** visibles (play/pause/volume) ;
- **alternative texte** ou transcription si contenu informatif ;
- **format** : MP4 H.264 ou WebM ;
- **poster** image définie ;
- **lazy-load** si pas dans le hero.

### Anti-patterns

- vidéo autoplay avec son (interdit par les navigateurs anyway) ;
- vidéo 50 Mo qui se charge avant le contenu ;
- pas de fallback texte pour vidéos informatives ;
- vidéo qui démarre à un moment aléatoire au scroll.

---

## 10. Détection automatique

```bash
# Images sans alt
grep -rIE '<img[^>]+alt=""' --include="*.html" --include="*.tsx" --include="*.jsx" --include="*.vue" --include="*.php" .

# Images PNG / JPG sans WebP fallback
grep -rIE '<img\s+src="[^"]+\.(png|jpg|jpeg)"' --include="*.html" --include="*.tsx" --include="*.jsx" .

# Images sans width/height
grep -rIE '<img(?![^>]+width=)[^>]*>' --include="*.html" --include="*.tsx" --include="*.jsx" .

# Lazy-load manquant
grep -rIE '<img(?![^>]+loading=)[^>]*>' --include="*.html" --include="*.tsx" --include="*.jsx" .
```

---

## 11. Checklist images / médias

### Choix

- [ ] **cohérence** avec le contenu (pas générique) ;
- [ ] **un seul style** sur tout le site (pas mix photo + illustration + 3D) ;
- [ ] **anti-clichés** : pas équipe en costume / mains sur clavier / ampoule "idée" ;
- [ ] **ratios cohérents** par type d'image.

### Accessibilité

- [ ] **alt text non vide** sur images informatives ;
- [ ] **alt=""** sur décoratives ;
- [ ] alt **descriptif**, court, localisé.

### Optimisation

- [ ] **WebP** + fallback JPEG ;
- [ ] **dimensions** adaptées à l'usage ;
- [ ] **`<picture>`** avec srcset si responsive ;
- [ ] **width / height** explicites ;
- [ ] **lazy-load** sous la ligne de flottaison ;
- [ ] **eager + fetchpriority** sur le hero.

### Documentation

- [ ] **crédits** documentés (`docs/image-credits.md`) ;
- [ ] **licences** vérifiées ;
- [ ] **autorisations** écrites pour photos clients.

### Performance

- [ ] **poids** raisonnable par type ;
- [ ] **LCP** < 2.5 s ;
- [ ] **CLS** < 0.1 (width/height en place).

---

Created by João de Almeida
