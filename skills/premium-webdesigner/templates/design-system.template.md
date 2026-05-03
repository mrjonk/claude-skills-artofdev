# Design System — {{PROJECT_NAME}}

> Mini design system du projet : tokens, conventions, exemples.
> Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. Couleurs

### Palette principale

| Token | Hex | Usage |
|---|---|---|
| `primary-50` | `{{#eff6ff}}` | fonds très clairs |
| `primary-500` | `{{#3b82f6}}` | éléments d'accent moyen |
| `primary-700` | `{{#1d4ed8}}` | dominante |
| `primary-900` | `{{#1e3a8a}}` | textes sur primary clair |
| `accent-500` | `{{#fb7185}}` | CTA |

### Neutres (slate)

| Token | Hex | Usage |
|---|---|---|
| `neutral-50` | `#f8fafc` | background primaire |
| `neutral-100` | `#f1f5f9` | backgrounds secondaires |
| `neutral-200` | `#e2e8f0` | borders subtiles |
| `neutral-400` | `#94a3b8` | placeholders |
| `neutral-500` | `#64748b` | texte secondaire |
| `neutral-700` | `#334155` | body text |
| `neutral-900` | `#0f172a` | headings |

### Sémantiques

| Token | Hex | Usage |
|---|---|---|
| `success-500` | `#10b981` | succès |
| `warning-500` | `#f59e0b` | warning |
| `error-500` | `#ef4444` | erreur |

### Vérifications

- [ ] contraste texte sur fond ≥ 4.5:1 (AA)
- [ ] contraste boutons primary ≥ 4.5:1
- [ ] mode dark vérifié (si applicable)

---

## 2. Typographie

### Familles

```css
:root {
  --font-display: "Cabinet Grotesk", "Inter Display", system-ui, sans-serif;
  --font-body: "Inter", system-ui, sans-serif;
  --font-mono: "JetBrains Mono", monospace;
}
```

### Échelle

| Token | Taille | Line-height | Usage |
|---|---|---|---|
| `text-xs` | 12 px | 16 px | captions, footnotes |
| `text-sm` | 14 px | 20 px | helper text |
| `text-base` | 16 px | 24 px | **body** |
| `text-lg` | 18 px | 28 px | lead paragraph |
| `text-xl` | 20 px | 28 px | small headings |
| `text-2xl` | 24 px | 32 px | h3 |
| `text-3xl` | 30 px | 36 px | h2 mobile |
| `text-4xl` | 36 px | 40 px | h2 desktop |
| `text-5xl` | 48 px | 1 | h1 mobile |
| `text-6xl` | 60 px | 1 | h1 desktop |

### Poids

- `font-normal` (400)
- `font-medium` (500)
- `font-semibold` (600)
- `font-bold` (700)

> Ne pas charger 8 poids. 3–4 max.

---

## 3. Espacements

Échelle base 4 px (compatible Tailwind) :

```
0   0     0.5 2px   1   4px    2   8px
3   12px  4   16px  6   24px   8   32px
12  48px  16  64px  20  80px   24  96px
32  128px
```

**Règle :** toujours utiliser une valeur de l'échelle. Pas de `padding: 17px` arbitraire.

### Espacement entre sections

- mobile : 48–64 px (`py-12` à `py-16`)
- desktop : 96–128 px (`py-24` à `py-32`)

---

## 4. Radius

| Token | Valeur | Usage |
|---|---|---|
| `radius-sm` | `6px` | boutons, inputs, badges |
| `radius-md` | `12px` | cards, dropdowns |
| `radius-lg` | `24px` | modals, sections highlight |

---

## 5. Boutons

### Variantes

```html
<!-- Primary -->
<button class="btn-primary">Commencer</button>

<!-- Secondary -->
<button class="btn-secondary">En savoir plus</button>

<!-- Ghost -->
<button class="btn-ghost">Annuler</button>
```

### Tailles

| Taille | Hauteur | Padding x | text |
|---|---|---|---|
| `sm` | 32 px | 12 px | `text-sm` |
| `md` | 40 px | 16 px | `text-base` |
| `lg` | 48 px | 24 px | `text-base` |

### États

- `default`
- `hover` (élévation `shadow-md` ou couleur foncée)
- `focus` (ring 2 px primary, contraste suffisant)
- `active` (couleur encore plus foncée)
- `disabled` (opacité 0.5, `cursor: not-allowed`)
- `loading` (spinner + `aria-busy="true"`)

---

## 6. Cards

```html
<div class="card">
  <h3 class="card-title">{{titre}}</h3>
  <p class="card-body">{{contenu}}</p>
  <button class="btn-primary">Action</button>
</div>
```

```css
.card {
  background: var(--color-neutral-50);
  border: 1px solid var(--color-neutral-200);
  border-radius: var(--radius-md);
  padding: 1.5rem; /* 24 px */
  transition: box-shadow 200ms ease-out;
}
.card:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}
```

---

## 7. Badges

| Variante | Couleur fond | Texte |
|---|---|---|
| `success` | `success-100` | `success-700` |
| `warning` | `warning-100` | `warning-700` |
| `error` | `error-100` | `error-700` |
| `neutral` | `neutral-100` | `neutral-700` |
| `primary` | `primary-100` | `primary-700` |

Padding : 4 × 8 px (sm) ou 6 × 12 px (md). Radius : pleine pill (`rounded-full`).

---

## 8. Formulaires

### Champ texte

```html
<div class="form-field">
  <label for="email">Email</label>
  <input type="email" id="email" name="email" required>
  <p class="helper">On ne spammera pas, promis.</p>
</div>
```

```css
.form-field input {
  width: 100%;
  padding: 12px 16px;
  border: 1px solid var(--color-neutral-200);
  border-radius: var(--radius-sm);
  font-size: 16px;
  transition: border-color 150ms ease-out;
}
.form-field input:focus {
  outline: none;
  border-color: var(--color-primary-500);
  box-shadow: 0 0 0 2px var(--color-primary-200);
}
```

### Erreurs

```html
<div class="form-field" data-error="true">
  <label for="email">Email</label>
  <input type="email" id="email" aria-invalid="true" aria-describedby="email-error">
  <p id="email-error" class="error">Veuillez saisir un email valide.</p>
</div>
```

---

## 9. Tables

| Propriété | Valeur |
|---|---|
| Row height | 48 px (confortable) |
| Header background | `neutral-50` |
| Header weight | `600` |
| Border between rows | 1 px `neutral-100` |
| Hover row | `neutral-50` |
| Pagination | toujours dès > 25 lignes |

---

## 10. Animations

```css
:root {
  --duration-fast: 150ms;
  --duration-default: 250ms;
  --duration-slow: 400ms;
  --ease-out: cubic-bezier(0, 0, 0.2, 1);
}

.transition-default {
  transition-duration: var(--duration-default);
  transition-timing-function: var(--ease-out);
}

@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

Motifs autorisés :
- hover (boutons, cards) — 150 ms
- toasts / dropdowns — 250 ms
- page transitions — 400 ms (sobres)

---

## 11. Responsive (breakpoints)

| Breakpoint | Largeur | Cible |
|---|---|---|
| `sm` | 640 px | mobile L → tablet portrait |
| `md` | 768 px | tablet |
| `lg` | 1024 px | laptop |
| `xl` | 1280 px | desktop |
| `2xl` | 1536 px | grand écran |

Container max-width : **1280 px** ou **1440 px** selon densité visée.

---

## 12. Mode dark (si applicable)

- Background base : `neutral-900` (pas pur noir)
- Texte primaire : `neutral-100` (pas pur blanc)
- Borders : `neutral-700`
- Shadows : réduites ou remplacées par bordures
- Couleur primary : variante plus claire (ex: `primary-400` plutôt que `primary-700`)

---

## 13. Implémentation

### Tailwind

Configurer dans `tailwind.config.js` :

```js
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: { /* échelle */ },
        accent: { /* échelle */ },
      },
      fontFamily: {
        display: ['Cabinet Grotesk', 'system-ui', 'sans-serif'],
        body: ['Inter', 'system-ui', 'sans-serif'],
      },
      borderRadius: {
        sm: '6px',
        md: '12px',
        lg: '24px',
      },
    },
  },
}
```

### CSS classique

Variables dans `:root` (cf. exemples ci-dessus).

### WordPress

Variables CSS dans le fichier `style.css` du thème enfant.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
