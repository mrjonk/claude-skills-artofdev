# Checklist langues RTL — `multilingual-site-engine`

Pour ajouter le support arabe, hébreu, farsi, ourdou ou toute autre langue RTL.

Created by João de Almeida

---

## 1. Pourquoi le RTL est différent

Les langues RTL ("right-to-left") :

- **arabe** (ar) ;
- **hébreu** (he) ;
- **farsi / persan** (fa) ;
- **ourdou** (ur) ;
- **dhivehi** (dv) ;
- **yiddish** (yi) ;
- **kurde** sorani (ckb).

s'écrivent **de droite à gauche**. Cela impose :

- direction du texte ;
- direction de la mise en page ;
- direction des **icônes** (flèches, breadcrumbs) ;
- direction des **animations** (slide droite ↔ gauche) ;
- choix de **police** compatible.

Ce n'est **pas** juste un changement de texte. C'est un changement de layout.

---

## 2. Détection RTL

Si une des langues cibles est RTL, le skill doit :

- prévenir l'utilisateur ;
- proposer une **stratégie** d'adaptation ;
- recommander de **tester** chaque page avant publication.

---

## 3. Direction HTML

Sur **chaque** page en langue RTL :

```html
<html lang="ar" dir="rtl">
<html lang="he" dir="rtl">
```

Sur les langues LTR, garder `dir="ltr"` (ou ne rien préciser, défaut LTR).

---

## 4. CSS logique

### Mauvaise pratique

CSS physique, fixe une direction :

```css
.card {
  margin-left: 16px;
  padding-right: 24px;
  text-align: left;
  border-left: 1px solid #ccc;
}
```

→ casse en RTL.

### Bonne pratique

CSS logique, suit le sens de lecture :

```css
.card {
  margin-inline-start: 16px;
  padding-inline-end: 24px;
  text-align: start;
  border-inline-start: 1px solid #ccc;
}
```

### Liste des propriétés logiques

| Physique | Logique |
|---|---|
| `margin-left` | `margin-inline-start` |
| `margin-right` | `margin-inline-end` |
| `padding-left` | `padding-inline-start` |
| `padding-right` | `padding-inline-end` |
| `border-left` | `border-inline-start` |
| `border-right` | `border-inline-end` |
| `left` | `inset-inline-start` |
| `right` | `inset-inline-end` |
| `text-align: left` | `text-align: start` |
| `text-align: right` | `text-align: end` |
| `float: left` | `float: inline-start` |
| `border-top-left-radius` | `border-start-start-radius` |

### Frameworks CSS

- **Tailwind CSS 3.3+** : variantes `rtl:` et `ltr:` (`mr-4 rtl:ml-4`) ;
- **Bootstrap 5** : variables CSS pour direction ;
- **CSS-in-JS** : utiliser `stylis-plugin-rtl` pour Emotion / styled-components.

---

## 5. Icônes directionnelles

À **inverser** en RTL :

- flèches de pagination ;
- breadcrumbs `>` ;
- icônes "next" / "previous" ;
- chevrons des accordéons (selon contexte) ;
- icônes de "envoyer" (avion en papier) ;
- icônes de progression (bar de progression).

À **ne pas** inverser :

- play / pause (toujours triangle vers la droite) ;
- numérotation latine (1, 2, 3) ;
- logos ;
- icônes universellement reconnues (loupe, panier).

---

## 6. Layout

### Sidebar

- en LTR : sidebar à gauche ;
- en RTL : sidebar à droite (par défaut).

### Header

- logo : en haut à droite (RTL) plutôt qu'à gauche ;
- navigation : à gauche du logo (sens de lecture) ;
- CTA : à gauche du header (côté "fin" de lecture).

### Cards

- alignement texte commence à droite ;
- listes commencent à droite.

### Tables

- ordre des colonnes peut rester logique (chronologique, par exemple), mais l'alignement texte est à droite.

---

## 7. Polices

### Polices système recommandées

- **arabe** : *"Noto Sans Arabic"*, *"Cairo"*, *"Tajawal"*, *"IBM Plex Sans Arabic"*, *"Amiri"* ;
- **hébreu** : *"Noto Sans Hebrew"*, *"Heebo"*, *"Rubik"*, *"Assistant"* ;
- **farsi** : *"Vazirmatn"*, *"Sahel"*, *"Vazir"* ;
- **ourdou** : *"Noto Nastaliq Urdu"*.

### Règles

- la police latine d'origine (Inter, Roboto, etc.) **ne supporte pas toujours** ces alphabets ;
- charger une **police par langue** via `font-display: swap` ;
- utiliser `font-family: "Cairo", "Inter", sans-serif;` (fallback latin pour les chiffres ou mots latins mêlés).

---

## 8. Tests visuels

### Pages à tester

- home ;
- formulaires (auth, contact, checkout) ;
- listings (blog, produits) ;
- détails (article, fiche produit) ;
- footer ;
- menu mobile ;
- modaux ;
- emails transactionnels.

### À vérifier

- alignement du **texte** ;
- direction des **icônes** ;
- ordre des **colonnes** dans les tables ;
- alignement des **boutons** dans les groupes ;
- direction des **breadcrumbs** ;
- direction des **animations** de transition ;
- placeholders qui ne **débordent** pas ;
- tailles des **textes** (l'arabe est souvent plus court ou plus long que la source).

---

## 9. Animations

À ajuster :

- slide-in depuis la droite en LTR → depuis la gauche en RTL ;
- carrousel : sens de défilement inversé ;
- progress bar : remplissage de droite à gauche.

---

## 10. Erreurs fréquentes

- `dir="ltr"` figé sur toutes les pages ;
- CSS physique laissé partout (`margin-left`) ;
- icônes non inversées (flèche "next" pointant à droite en RTL) ;
- police latine sur du texte arabe (rendu illisible) ;
- chiffres latins forcés dans un contexte arabo-indien (selon préférence client) ;
- alignement de boutons cassé (CTA principal à droite en RTL) ;
- emails transactionnels non préparés en RTL.

---

## 11. Outils

- **`rtlcss`** : convertit du CSS physique en CSS logique ;
- **`stylis-plugin-rtl`** : pour Emotion / styled-components ;
- **`bidi-js`** : gestion bidirectionnelle ;
- **Chrome DevTools** : forcer `dir="rtl"` pour tester.

---

## 12. Workflow recommandé

1. **Détecter** la langue cible RTL.
2. **Préparer** le CSS (logique ou variantes RTL).
3. **Adapter** les icônes directionnelles.
4. **Charger** une police compatible.
5. **Tester** chaque page critique.
6. **Tester** les emails.
7. **Réviser** par un locuteur natif si possible.

---

## 13. Checklist RTL

- [ ] `dir="rtl"` sur les pages RTL ;
- [ ] CSS logique (ou variantes RTL via framework) ;
- [ ] icônes directionnelles inversées ;
- [ ] sidebar / menu inversés ;
- [ ] police compatible chargée ;
- [ ] alignement texte adapté ;
- [ ] formulaires testés ;
- [ ] emails préparés en RTL ;
- [ ] animations adaptées ;
- [ ] microcopies (breadcrumbs, paginations) inversées ;
- [ ] relecture par locuteur natif si possible.

---

## 14. Quand déléguer à `premium-webdesigner`

Si l'adaptation RTL nécessite une **refonte créative** (typographie totalement différente, hiérarchie visuelle à repenser), déléguer à `premium-webdesigner` plutôt que d'imposer une solution mécanique.

---

Created by João de Almeida
