# Guide typographie et espacement — `site-ux-guardian`

Comment vérifier que la typographie et l'espacement sont **cohérents** sur tout le site.

Created by João de Almeida

---

## 1. Tailles de texte raisonnables

### Échelle géométrique recommandée

```
xs   12 px   captions, footnotes
sm   14 px   helper text, métadonnées
base 16 px   body — JAMAIS plus petit
lg   18 px   lead paragraph
xl   20 px   small headings
2xl  24 px   H3
3xl  30 px   H2 mobile
4xl  36 px   H2 desktop
5xl  48 px   H1 mobile
6xl  60 px   H1 desktop
7xl  72 px   hero exceptionnel
```

### Anti-patterns

- body 14 px (illisible mobile pour les seniors) ;
- body 12 px (cards, captures small) ;
- H1 à 120 px (déborde mobile) ;
- mix d'échelles (16, 17, 18, 19, 20 px sans logique).

---

## 2. Line-height confortable

### Règles

| Type de texte | Line-height |
|---|---|
| Titres (H1–H3) | 1.0–1.2 |
| Body text | 1.4–1.6 |
| Petites tailles (footnotes) | 1.4 |
| Headings dense (cards) | 1.3 |

### Anti-patterns

- line-height **1** sur du body (phrases collées, illisible) ;
- line-height **2** partout (texte dilué, scan impossible) ;
- même line-height pour body et titres (titres trop serrés).

---

## 3. Largeur de texte

### Règles

- **50–80 caractères** par ligne en lecture longue ;
- équivalent CSS : `max-width: 65ch` ou `max-width: 75ch` ;
- pour les **titres** : pas de limite, mais éviter qu'un H1 dépasse 60 caractères.

### Anti-patterns

- texte sur **toute la largeur** du viewport (ligne de 200 caractères → l'œil se perd) ;
- texte trop **étroit** sur grand écran (200 px de large → mauvais usage de l'espace) ;
- titres énormes qui s'étalent sur 4 lignes.

---

## 4. Système d'espacement

### Échelle géométrique base 4 px (recommandée)

```
0   0 px
0.5 2 px
1   4 px
2   8 px
3   12 px
4   16 px
6   24 px
8   32 px
12  48 px
16  64 px
20  80 px
24  96 px
32  128 px
```

(Compatible Tailwind par défaut.)

### Règle d'or

**Toujours** utiliser une valeur de l'échelle. Pas de `padding: 17px`, `margin: 23px`, `gap: 11px` arbitraires.

### Espacement entre sections

| Breakpoint | Espacement vertical |
|---|---|
| Mobile | 48–64 px (`py-12` à `py-16`) |
| Tablet | 64–96 px |
| Desktop | 96–128 px (`py-24` à `py-32`) |

---

## 5. Marges (margin)

### Règles

- pour **séparer** des éléments du même bloc (entre paragraphes, entre cards) ;
- échelle 8 / 12 / 16 / 24 / 32 px ;
- **cohérent** sur tout le site (ne pas mélanger 16 px et 23 px).

### Anti-patterns

- margin-bottom différent sur chaque paragraphe ;
- margin négatif partout pour "rattraper" un mauvais layout ;
- `margin-top` + `margin-bottom` (collapse) qui crée des espacements imprévisibles.

---

## 6. Padding

### Règles

- pour **espacer le contenu** d'un container (cards, sections, boutons) ;
- échelle 4 / 8 / 12 / 16 / 24 / 32 / 48 / 64 px ;
- padding latéral **mobile** : 16 px minimum ;
- padding latéral **desktop** : 32–48 px+ ;
- padding interne des **cards** : 16 ou 24 px.

### Anti-patterns

- card avec padding 4 px (texte collé au bord) ;
- bouton avec padding 24 px x 8 px (très allongé) ;
- container sans padding latéral (texte qui touche le bord).

---

## 7. Cohérence inter-pages

### À vérifier

- **mêmes tailles** de texte sur des éléments similaires (un H1 d'article ≈ un H1 de page produit) ;
- **mêmes margins** entre sections similaires ;
- **mêmes paddings** dans les cards similaires ;
- **mêmes line-heights** ;
- **mêmes familles** de polices.

### Anti-patterns

- H1 à 48 px sur la home, à 36 px sur les autres pages (sans intention) ;
- cards avec padding 16 px sur la home, 24 px sur la page services ;
- footer sur fond `#0a0a0a` partout sauf une page où il est `#1a1a1a`.

---

## 8. Erreurs fréquentes — catalogue

### "Trop de tailles"

```css
/* Mauvais */
.title-1 { font-size: 32px; }
.title-2 { font-size: 28px; }
.title-3 { font-size: 25px; }
.title-4 { font-size: 22px; }
.title-5 { font-size: 19px; }
```

→ Utiliser une échelle géométrique (16, 20, 24, 30, 36 px).

### "Trop de poids"

```css
/* Mauvais */
.text { font-weight: 400; }
.text-semi { font-weight: 450; }
.text-medium { font-weight: 500; }
.text-bold { font-weight: 550; }
```

→ Utiliser 3 poids max : 400 (regular), 500 ou 600 (semibold), 700 (bold).

### "Texte sur image sans overlay"

```css
/* Mauvais */
.hero {
  background-image: url(hero.jpg);
}
.hero h1 {
  color: white; /* mais l'image a parfois des zones claires */
}
```

→ Ajouter un overlay :
```css
.hero {
  background-image: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), url(hero.jpg);
}
```

---

## 9. Outils de vérification

| Outil | Usage |
|---|---|
| Chrome DevTools — Inspector | mesurer les tailles / line-heights réels |
| Lighthouse Accessibility | détecter contrastes faibles |
| `axe DevTools` | détection accessibilité automatisée |
| Stark (Figma + browser) | contraste + simulateur daltonisme |

---

## 10. Checklist typographie + spacing

### Typographie

- [ ] **2 familles maximum** ;
- [ ] **3 poids maximum** ;
- [ ] **échelle géométrique** respectée ;
- [ ] **body 16 px minimum** ;
- [ ] **line-height** 1.4–1.6 sur le body ;
- [ ] **largeur de ligne** 50–80 caractères en lecture ;
- [ ] **contraste AA** ;
- [ ] **cohérence inter-pages**.

### Spacing

- [ ] **valeurs de l'échelle** uniquement (pas d'arbitraire) ;
- [ ] **padding latéral** mobile ≥ 16 px ;
- [ ] **espacement entre sections** : 48–128 px selon breakpoint ;
- [ ] **padding cards** cohérent ;
- [ ] **respiration** du footer ;
- [ ] **cohérence inter-pages**.

---

Created by João de Almeida
