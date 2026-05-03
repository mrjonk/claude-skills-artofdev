# Moodboard / Rapport d'inspiration — {{PROJECT_NAME}}

> Synthèse de la phase B (recherche d'inspiration) du skill `premium-webdesigner`.
> Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Direction artistique retenue

**Ambiance générale :** {{ex: clean tech moderne — proche de Linear/Vercel mais avec une chaleur supplémentaire issue de la couleur d'accent corail}}

**Mots-clés** : {{ex: clean, focus, productivité, sérénité, performance}}

**Test du logo enlevé** : {{est-ce qu'on devine le secteur / la cible / le ton ? — oui / non + raison}}

---

## Sources consultées

### 21st.dev community

| Catégorie consultée | URL | Notes |
|---|---|---|
| Heros | https://21st.dev/community/components/?tag=heros | 12 composants vus |
| Pricing | https://21st.dev/community/components/?tag=pricing | 8 composants vus |
| Features | https://21st.dev/community/components/?tag=features | 10 composants vus |
| Featured | https://21st.dev/community/components/featured | curated, valeurs sûres |

### shadcn/ui

| URL | Composants pertinents |
|---|---|
| https://ui.shadcn.com/docs/components | Button, Card, Dialog, Sheet, Tabs, Toast, Form |

### Sources images

| Source | URL | Mots-clés utilisés |
|---|---|---|
| Pixabay | https://pixabay.com/photos/workstation/ | `clean workstation`, `soft gradient abstract` |
| Unsplash | https://unsplash.com/s/photos/abstract-tech | `abstract technology`, `digital workflow` |

### Sites de référence sectoriels

| Site | URL | Ce qu'on garde | Ce qu'on écarte |
|---|---|---|---|
| Linear | https://linear.app | hero clean, pricing 3 plans, animations subtiles | ne pas copier le dégradé violet signature |
| Cron | https://cron.com | dark mode propre, typographie | spécificité produit calendrier |
| Vercel | https://vercel.com | structure de page, performance perçue | densité d'info parfois excessive |

---

## Composants repérés

(Pour le détail, voir `templates/component-selection.template.md`.)

| Composant | Source | Pour quelle section |
|---|---|---|
| Hero with split mockup | 21st.dev (featured) | Homepage hero |
| Pricing 3 plans toggle | 21st.dev (popular) | Section pricing |
| Bento features | 21st.dev (newest) | Section features |
| Testimonials grid | shadcn block | Section testimonials |
| Footer 4 columns | shadcn block | Footer toutes pages |

---

## Palette proposée

| Rôle | Couleur | Hex | Notes |
|---|---|---|---|
| Primary | bleu profond | `#1e40af` | dominante, marques tech |
| Accent | corail | `#fb7185` | CTA + accents |
| Neutral | slate | gamme `#0f172a` → `#f8fafc` | textes + fonds |
| Success | vert | `#059669` | sémantique |
| Warning | ambre | `#d97706` | sémantique |
| Error | rouge | `#dc2626` | sémantique |

Vérification contraste : ratio ≥ 4.5:1 entre texte (`#0f172a`) et fond (`#f8fafc`).

---

## Typographie

| Rôle | Famille | Poids | Notes |
|---|---|---|---|
| Display | Cabinet Grotesk | 500, 600 | titres |
| Body | Inter | 400, 500 | texte courant |
| Mono | JetBrains Mono | 400 | snippets de code (si applicable) |

Échelle :

```
xs   12 / sm 14 / base 16 / lg 18 / xl 20 / 2xl 24 / 3xl 30 / 4xl 36 / 5xl 48 / 6xl 60
```

---

## Spacing / Radius / Shadows

| Token | Valeur |
|---|---|
| Spacing base | 4 px (échelle 4 / 8 / 12 / 16 / 24 / 32 / 48 / 64 / 96) |
| Radius sm / md / lg | 6 / 12 / 24 px |
| Shadow sm / md | `0 1px 2px rgba(0,0,0,0.05)` / `0 4px 12px rgba(0,0,0,0.08)` |

---

## Images

(Pour le détail, voir `templates/image-selection.template.md`.)

- **Hero homepage** : photo immersive, ambiance soft gradient + workstation clean. Source : Unsplash.
- **Section features** : mockups internes (prévoir captures d'écran de l'app).
- **Testimonials** : photos fournies par client.
- **Footer / sociaux** : icônes Lucide (cohérence).

---

## Animations

- **Hover boutons** : 150 ms, ease-out, légère élévation `shadow-md`.
- **Scroll reveal** : 250 ms, ease-out, sur sections en dessous de la ligne de flottaison.
- **Page transition** : pas d'animation custom (Next.js par défaut).
- **`prefers-reduced-motion`** : respecté.

---

## Risques

- **Image hero** : qualité variable selon l'auteur Unsplash → tester 3 candidats avant validation finale.
- **Bento grid** : peut surcharger en mobile → vérifier `responsive-checklist.md`.
- **Testimonials** : photos clients pas encore reçues → placeholder neutre en attendant.
- **Animations** : tester sur mobile bas de gamme, désactiver si saccades visibles.

---

## Recommandation finale

**Direction validée :** {{description en 2 lignes}}

**Étapes suivantes :**

1. {{ex: Valider la palette et la typographie avec l'utilisateur.}}
2. {{ex: Importer les composants 21st.dev retenus dans `src/components/sections/`.}}
3. {{ex: Adapter au design system : remplacer couleurs / radius / shadows.}}
4. {{ex: Sourcer les images via Unsplash API.}}
5. {{ex: Implémenter section par section, commit séparés.}}

---

Created by João de Almeida — Art of Dev — https://artofdev.space
