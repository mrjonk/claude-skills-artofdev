# Design system consistency — {{PROJECT_NAME}}

> Audit du design system : tokens, cohérence, fichiers source.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Stack** : {{...}}
- **Fichier de tokens** : {{ex: tailwind.config.js, _variables.scss, app/globals.css}}

---

## 1. Couleurs

### Tokens définis

| Token | Hex | Usage prévu |
|---|---|---|
| `--primary` ou `primary-500` | `{{#1e40af}}` | dominante |
| `--accent` ou `accent-500` | `{{#fb7185}}` | CTA |
| `--neutral-50` à `--neutral-900` | gamme slate | textes + fonds |
| `--success` | `{{#10b981}}` | sémantique succès |
| `--warning` | `{{#f59e0b}}` | sémantique warning |
| `--error` | `{{#ef4444}}` | sémantique erreur |

### Vérifications

- [ ] **un seul fichier source** pour les tokens couleur ;
- [ ] **aucune couleur hardcodée** dans les composants (toutes via tokens) ;
- [ ] **contraste AA** entre texte et fond ;
- [ ] palette **restreinte** (max 5 couleurs hors gris).

### Anti-patterns détectés

| Fichier | Couleur hardcodée | Recommandation |
|---|---|---|
| `app/components/Hero.tsx:42` | `#3b82f6` | utiliser `var(--primary-500)` ou classe Tailwind |
| `app/styles/legacy.css:120` | `#999999` | remplacer par `--neutral-500` |

---

## 2. Typographie

### Tokens définis

| Token | Valeur | Usage |
|---|---|---|
| `--font-display` | `{{Cabinet Grotesk, system-ui, sans-serif}}` | titres |
| `--font-body` | `{{Inter, system-ui, sans-serif}}` | corps |
| `--font-mono` | `{{JetBrains Mono}}` | code |

### Échelle de tailles

| Token | Taille |
|---|---|
| `text-xs` | 12 px |
| `text-sm` | 14 px |
| `text-base` | 16 px |
| `text-lg` | 18 px |
| `text-xl` | 20 px |
| `text-2xl` | 24 px |
| `text-3xl` | 30 px |
| `text-4xl` | 36 px |
| `text-5xl` | 48 px |
| `text-6xl` | 60 px |

### Vérifications

- [ ] **2 familles maximum** ;
- [ ] **3 poids maximum** ;
- [ ] échelle **géométrique** ;
- [ ] tailles utilisées sont **toutes** dans l'échelle.

---

## 3. Spacing

### Échelle

```
0   0       0.5 2px    1   4px    2   8px
3   12px    4   16px   6   24px   8   32px
12  48px    16  64px   20  80px   24  96px
32  128px
```

### Vérifications

- [ ] **valeurs de l'échelle uniquement** (pas de `padding: 17px` arbitraire) ;
- [ ] cohérence inter-pages.

### Anti-patterns détectés

| Fichier | Valeur arbitraire | Recommandation |
|---|---|---|
| `app/page.tsx:78` | `padding: 17px` | utiliser `padding: 16px` (échelle) |
| `app/contact/page.tsx:34` | `margin-top: 23px` | utiliser `margin-top: 24px` |

---

## 4. Radius

### Tokens définis

| Token | Valeur | Usage |
|---|---|---|
| `radius-sm` | `6px` | boutons, inputs, badges |
| `radius-md` | `12px` | cards, dropdowns |
| `radius-lg` | `24px` | modals, sections highlight |

### Vérifications

- [ ] **3 valeurs maximum** ;
- [ ] cohérence partout.

---

## 5. Shadows

### Tokens définis

| Token | Valeur | Usage |
|---|---|---|
| `shadow-sm` | `0 1px 2px rgba(0,0,0,0.05)` | élévation discrète |
| `shadow-md` | `0 4px 12px rgba(0,0,0,0.08)` | cards survolées |

### Vérifications

- [ ] **2 niveaux maximum** (3 si modal/tooltip dédié) ;
- [ ] subtiles, pas dramatiques.

---

## 6. Boutons

### Variantes définies

| Variante | Background | Color | Border |
|---|---|---|---|
| Primary | `--primary-500` | white | none |
| Secondary | transparent | `--primary-500` | 1px solid `--primary-500` |
| Ghost | transparent | `--neutral-700` | none |

### États

- [ ] hover défini ;
- [ ] focus défini ;
- [ ] active défini ;
- [ ] disabled défini ;
- [ ] loading défini (si applicable).

### Vérifications

- [ ] **3 variantes maximum** ;
- [ ] **3 tailles maximum** (sm, md, lg) ;
- [ ] cohérence inter-pages.

---

## 7. Cards

### Style canonique

```css
.card {
  background: var(--neutral-50);
  border: 1px solid var(--neutral-200);
  border-radius: var(--radius-md);
  padding: 1.5rem; /* 24 px */
  transition: box-shadow 200ms ease-out;
}
.card:hover {
  box-shadow: var(--shadow-md);
}
```

### Vérifications

- [ ] **un seul style canonique** par type de card ;
- [ ] cohérence radius / border / shadow / padding ;
- [ ] hover state si interactive.

---

## 8. Forms

### Style canonique

| Élément | Style |
|---|---|
| Input | padding 12px 16px, border 1px neutral-200, radius sm |
| Focus | ring 2px primary-500 |
| Label | text-sm, font-medium, mb-2 |
| Error | text-sm, text-error-500, mt-1 |
| Helper | text-sm, text-neutral-500, mt-1 |

### Vérifications

- [ ] cohérence inter-pages ;
- [ ] espacement entre champs : 24 px.

---

## 9. Badges

### Variantes

| Variante | Background | Color |
|---|---|---|
| Success | `success-100` | `success-700` |
| Warning | `warning-100` | `warning-700` |
| Error | `error-100` | `error-700` |
| Neutral | `neutral-100` | `neutral-700` |

### Vérifications

- [ ] couleurs sémantiques utilisées correctement ;
- [ ] **rouge réservé** aux erreurs ;
- [ ] **vert réservé** aux succès ;
- [ ] cohérence partout.

---

## 10. Tables

### Style canonique

| Élément | Style |
|---|---|
| Row height | 48 px (confortable) |
| Header background | `neutral-50` |
| Header weight | 600 |
| Border between rows | 1 px `neutral-100` |
| Hover row | `neutral-50` |

### Vérifications

- [ ] cohérence des tables admin ;
- [ ] pagination si > 25 lignes ;
- [ ] alignement (texte gauche, nombres droite).

---

## 11. Navigation

### Vérifications

- [ ] tokens utilisés pour les couleurs (pas hardcodé) ;
- [ ] active state défini avec un token (couleur primary, ou border bottom) ;
- [ ] hover state défini.

---

## 12. Footer

### Vérifications

- [ ] tokens utilisés ;
- [ ] cohérent avec le reste du site (mêmes couleurs, mêmes radius si cards dans le footer).

---

## 13. Anti-patterns globaux détectés

| Fichier | Problème | Recommandation |
|---|---|---|
| `app/styles/global.css:42` | 3 définitions différentes de `--primary` | centraliser |
| `app/components/Card.tsx` | `padding: 17px` arbitraire | utiliser échelle |
| `app/components/Button.tsx` | 5 variantes au lieu de 3 | consolider |

---

## 14. Score design system consistency

```
Couleurs cohérentes        : __ / 15
Typographie disciplinée    : __ / 15
Spacing géométrique        : __ / 15
Radius cohérents           : __ / 10
Shadows subtiles           : __ / 10
Boutons cohérents          : __ / 10
Cards cohérentes           : __ / 10
Formulaires cohérents      : __ / 10
Tokens centralisés         : __ / 5
─────────────────────────────────
Total                      : __ / 100
```

---

## Recommandations

### Mode 2 — Corrections sûres

- [ ] remplacer 3 couleurs hardcodées par des tokens ;
- [ ] corriger 5 paddings arbitraires.

### Mode 3 — À valider

- [ ] consolider les 5 variantes de bouton en 3 ;
- [ ] centraliser les variables CSS dans un seul fichier.

---

## Prochaine étape

> {{Une phrase actionnable.}}

---

Created by João de Almeida
