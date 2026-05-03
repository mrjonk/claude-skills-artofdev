# Règles de design system — `premium-webdesigner`

Comment construire un mini design system cohérent et premium.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. Palette

### Structure

Une palette propre comporte au minimum :

- **1 dominante** (couleur principale du produit, utilisée 60–70 % de l'espace) ;
- **1 accent** (couleur de CTA / focus / call-to-action, utilisée 5–10 %) ;
- **1–2 neutres** (gris pour textes, fonds, bordures) ;
- **3 couleurs sémantiques** (succès vert, erreur rouge, warning ambre).

### Échelles de gris (tailwind-style)

```
50  : #f8fafc  (background)
100 : #f1f5f9
200 : #e2e8f0  (borders)
300 : #cbd5e1
400 : #94a3b8  (placeholders)
500 : #64748b  (secondary text)
600 : #475569
700 : #334155  (body text)
800 : #1e293b
900 : #0f172a  (heading text)
```

### Exemples de palettes par ambiance

| Ambiance | Dominante | Accent | Notes |
|---|---|---|---|
| **SaaS tech** | bleu profond `#1e40af` ou violet `#7c3aed` | bleu clair / cyan | Linear, Vercel, Stripe |
| **Startup créative** | orange `#f97316` ou corail `#fb7185` | jaune / rose | énergique mais pas criard |
| **Corporate / B2B** | bleu marine `#1e3a8a` | doré `#d4af37` ou vert `#059669` | sérieux, crédible |
| **Artistique / éditorial** | noir `#0a0a0a` + crème `#fafaf9` | rouge mat `#991b1b` | typographie-first |
| **Restaurant warm** | terracotta `#b45309` ou bordeaux | doré `#ca8a04` | chaleur, gastronomie |
| **Tatoueur / urban** | noir + blanc + 1 accent vif | rouge sang `#7f1d1d` | brutaliste, contrasté |
| **Coiffeur / beauté** | rose poudré `#fdf2f8` + blush `#fb7185` | doré ou violet | doux, lifestyle |
| **DJ / nuit** | noir profond `#020617` + violet `#7c3aed` | cyan néon `#22d3ee` | scène, énergie |

### Règles

- **WCAG AA** : ratio ≥ 4.5:1 pour le texte normal, 3:1 pour le grand texte ;
- **maximum 5 couleurs** par projet (hors gris) ;
- **un seul** rouge, un seul vert, un seul ambre (si sémantiques utilisées) ;
- nommer les couleurs : `primary`, `secondary`, `accent`, `success`, `warning`, `error`, `neutral` ;
- **éviter** les gradients posés sans raison.

---

## 2. Typographie

### Choix des polices

- **Display** (titres) : 1 famille (Inter Display, Cabinet Grotesk, Recoleta, Söhne, etc.) ;
- **Body** (corps) : 1 famille (Inter, IBM Plex Sans, Geist, system-ui) ;
- **Monospace** (code, numéros) : 1 famille (JetBrains Mono, Geist Mono, Fira Code) — facultatif.

**Règle :** maximum **2 familles** principales (display + body). Mono en bonus uniquement si pertinent.

### Échelle (typographic scale)

```
xs   : 12 px / 16 px line-height  (captions, footnotes)
sm   : 14 px / 20 px              (helper text)
base : 16 px / 24 px              (body) — JAMAIS en dessous
lg   : 18 px / 28 px              (lead paragraph)
xl   : 20 px / 28 px              (small headings)
2xl  : 24 px / 32 px              (h3)
3xl  : 30 px / 36 px              (h2 mobile)
4xl  : 36 px / 40 px              (h2 desktop)
5xl  : 48 px / 1                  (h1 mobile)
6xl  : 60 px / 1                  (h1 desktop)
7xl  : 72 px / 1                  (hero exceptionnel)
```

### Poids

- 400 (regular), 500 (medium), 600 (semibold), 700 (bold) ;
- éviter de charger 8 poids différents (3 suffisent : 400 / 500 / 700) ;
- ne **pas** mélanger 300 / 400 / 600 / 800 sans raison.

### Hiérarchie

- **un seul `<h1>`** par page ;
- échelle `<h1>` > `<h2>` > `<h3>` claire (différence d'au moins 4 px) ;
- jamais sauter `<h1>` → `<h4>` ;
- accents typographiques (italique, gras) limités à des éléments **clés**.

---

## 3. Grille / layout

- **Container max-width** : 1280 px ou 1440 px (selon densité souhaitée) ;
- **Padding latéral** : 16 px mobile, 24 px tablet, 48 px+ desktop ;
- **Grid** 12 colonnes pour le bureau, 4 pour mobile ;
- **Gap** : 16, 24, 32 px selon la densité.

---

## 4. Spacing

### Échelle géométrique

Base 4 px (cohérent avec Tailwind par défaut) :

```
0   : 0
0.5 : 2 px
1   : 4 px
2   : 8 px
3   : 12 px
4   : 16 px
6   : 24 px
8   : 32 px
12  : 48 px
16  : 64 px
20  : 80 px
24  : 96 px
32  : 128 px
```

**Règle d'or :** *toujours* utiliser une valeur de l'échelle. Pas de `padding: 17px`, pas de `margin: 23px` arbitraires.

### Espacement entre sections

- mobile : 48–64 px entre sections ;
- desktop : 96–128 px entre sections ;
- **rythme cohérent** : pas une section à 32 px, la suivante à 200 px sans raison.

---

## 5. Border radius

3 valeurs maximum :

```
sm : 6 px   (boutons, inputs, badges)
md : 12 px  (cards, dropdowns)
lg : 24 px  (modals, sections highlight)
```

Variations possibles selon ambiance :

| Ambiance | sm | md | lg |
|---|---|---|---|
| Tech moderne | 6 | 12 | 24 |
| Soft / éditorial | 8 | 16 | 32 |
| Brutaliste | 0 | 0 | 0 |
| Luxe | 4 | 8 | 16 |

**Règle :** cohérence sur **tout** le projet. Pas un bouton à 4 px et une card à 16 px sans raison.

---

## 6. Shadows

2 niveaux maximum :

```
sm : 0 1px 2px rgba(0,0,0,0.05)             (élévation discrète)
md : 0 4px 12px rgba(0,0,0,0.08)            (cards survolées, dropdowns)
```

Optionnel : un 3e niveau pour modales / tooltips importants :

```
lg : 0 16px 48px rgba(0,0,0,0.16)
```

**Règle :** ombres **subtiles**. Pas d'ombres dramatiques de 30 px de blur sur tout. Pas de `box-shadow` sur chaque élément du DOM.

---

## 7. Bordures

```
default : 1 px solid neutral-200
focus   : 2 px solid primary-500
error   : 1 px solid error-500
```

**Règle :** maximum 2 px d'épaisseur. 3 px ou plus = signal d'alerte ou choix éditorial assumé.

---

## 8. Boutons

3 variantes max :

| Variante | Style | Usage |
|---|---|---|
| **Primary** | fond `primary`, texte blanc | CTA principal |
| **Secondary** | outline `primary`, texte `primary` | action secondaire |
| **Ghost** | transparent, texte `neutral` | action tertiaire |

États requis : **default**, **hover** (légère élévation ou couleur plus foncée), **focus** (ring 2 px), **active** (couleur encore plus foncée), **disabled** (opacité 0.5, cursor not-allowed), **loading** (spinner, texte caché ou inchangé).

Tailles : `sm` (32 px), `md` (40 px), `lg` (48 px). Une seule taille par contexte de page.

---

## 9. Forms

- **Input** : padding 12 px x 16 px, border 1 px, radius `sm`, focus ring 2 px primary ;
- **Label** : toujours visible (jamais juste un placeholder) ;
- **Helper text** : 12 px, color `neutral-500` ;
- **Error text** : 12 px, color `error-500`, sous le champ ;
- **Required** : marqué (`*` rouge ou texte "obligatoire") ;
- **Disabled** : opacité 0.5, cursor not-allowed ;
- **Espacement** entre champs : 24 px vertical.

---

## 10. Cards

- **Background** : `neutral-50` ou `white` ;
- **Border** : 1 px `neutral-200` OU shadow `sm` (pas les deux sauf besoin) ;
- **Padding** : 16–24 px selon densité ;
- **Radius** : `md` ;
- **Hover** : élévation `shadow-md` + transition 200 ms (si interactive) ;
- **Cohérence** : toutes les cards du même type ont le même padding / radius / élévation.

---

## 11. Tables

- **Row height** : 48 px confortable, 40 px dense ;
- **Header** : `font-weight: 600`, fond `neutral-50` ;
- **Borders** : 1 px `neutral-100` entre lignes (subtiles) ;
- **Hover row** : fond `neutral-50` ;
- **Alignement** : texte à gauche, nombres à droite ;
- **Pagination** : toujours présente si > 25 lignes ;
- **Responsive** : transformation en cards sur mobile.

---

## 12. Badges / pills

- **Padding** : 4 px x 8 px (sm), 6 px x 12 px (md) ;
- **Radius** : pleine pill (50 px) ou `sm` selon style ;
- **Couleur sémantique** : `success`, `warning`, `error`, `neutral`, `primary` ;
- **Texte** : 12 px, `font-weight: 500`.

---

## 13. Empty states

- **Icône** ou illustration légère (60–80 px) ;
- **Titre** clair ("Aucun élément pour le moment") ;
- **Description** courte (1 phrase) ;
- **CTA** d'action ("Ajouter un premier élément") ;
- alignement centré ;
- couleurs neutres (`neutral-500`).

---

## 14. Toasts / notifications

- **Position** : top-right ou bottom-right (cohérent dans tout le projet) ;
- **Auto-dismiss** : 3–5 s ;
- **Couleur** sémantique selon type ;
- **Icône** + titre + description optionnelle ;
- **Bouton fermer** (X) ;
- **Animation** : slide-in 250 ms.

---

## 15. Animations

### Durées

```
fast    : 150 ms  (hover, focus, color transition)
default : 250 ms  (toasts, dropdowns, modals appearing)
slow    : 400 ms  (page transitions, large reveals)
```

### Easings

- `ease-out` (default) : `cubic-bezier(0, 0, 0.2, 1)` — apparition naturelle ;
- `ease-in` : pour disparitions ;
- `ease-in-out` : pour transitions complexes ;
- éviter `linear` (impression mécanique) ;
- éviter les bounces excessifs.

### Règles

- toujours `prefers-reduced-motion` : respecter ;
- **pas** d'animation sur tout (parallax sur 30 sections = nausée) ;
- max 2–3 motifs d'animation dans le projet (hover, scroll-reveal, page transition) ;
- les animations doivent **servir** l'UX (focus, feedback, hiérarchie), pas décorer.

---

## 16. Dark mode (si demandé)

- pas une simple inversion de couleurs ;
- ajuster :
  - fonds (`bg-neutral-900` plutôt que `black` pur) ;
  - textes (`neutral-100` plutôt que `white` pur — moins fatigant) ;
  - couleur dominante (peut nécessiter une variante plus claire) ;
  - shadows (réduites ou remplacées par bordures subtiles) ;
  - images (overlay assombri ou versions alternatives) ;
- toggle utilisateur clair, persistance via `localStorage` ou cookie ;
- `prefers-color-scheme` respecté par défaut.

---

## 17. Variables / tokens

Centraliser dans **un seul fichier** (selon stack) :

- **Tailwind** : `tailwind.config.js` → `theme.extend.colors`, `fontSize`, `borderRadius`, `boxShadow`, `spacing` ;
- **CSS natif** : `:root { --color-primary: ...; --radius-md: ...; }` ;
- **Sass** : `_tokens.scss` avec `$color-primary`, `$radius-md`, etc. ;
- **WordPress** : variables CSS dans le thème enfant.

**Règle :** si on doit changer une couleur, **un seul fichier** doit suffire.

---

## 18. Cohérence inter-pages

- header / footer **identiques** sur toutes les pages publiques ;
- même typographie partout ;
- mêmes radius / shadows / spacings ;
- même style de boutons / forms / cards ;
- pas de "page A en moderne, page B en legacy".

---

Created by João de Almeida — Art of Dev — https://artofdev.space
