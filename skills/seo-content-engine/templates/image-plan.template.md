# Plan d'images — {{TITRE_ARTICLE}}

> Plan complet des images de l'article : description, style, prompt IA / mots-clés, alt text, emplacement, source, licence.
> Created by João de Almeida

---

## 1. Vue d'ensemble

| # | Slot | Description | Style | Statut |
|---|---|---|---|---|
| I-001 | Hero | {{description courte}} | photo réaliste | à sourcer |
| I-002 | Section "Comment ça marche" | {{description}} | screenshot | à créer |
| I-003 | Section "Cas d'usage" | {{description}} | schéma | à créer |
| I-004 | FAQ | {{décoratif}} | illustration plate | optionnelle |

---

## 2. Détail par image

### I-001 — Hero

| Critère | Valeur |
|---|---|
| **Description** | {{Développeuse codant sur laptop, vue de dessus, lumière naturelle}} |
| **Style** | photographique réaliste |
| **Prompt IA / mots-clés** | {{cf. §3 ci-dessous}} |
| **Alt text** | {{"Mains d'une développeuse sur un clavier mécanique, vue de dessus, lumière naturelle de matin."}} |
| **Emplacement** | sous le H1, avant l'introduction |
| **Format** | WebP qualité 85 + fallback JPEG |
| **Dimensions** | 1920 × 960 (ratio 2:1), version `@2x` 3840 × 1920 |
| **Poids cible** | < 150 Ko (WebP) |
| **Lazy-load** | non (au-dessus ligne de flottaison, `fetchpriority="high"`) |
| **Source prévue** | Unsplash / Pixabay / interne |
| **Licence** | {{Unsplash License / Pixabay Content / interne}} |
| **Crédit** | {{Photographe Name (URL) — si Unsplash}} |
| **Statut** | à sourcer |

### I-002 — Section "Comment ça marche"

| Critère | Valeur |
|---|---|
| **Description** | {{capture d'écran de l'étape 1, interface produit}} |
| **Style** | screenshot annoté |
| **Prompt IA / mots-clés** | N/A (capture interne) |
| **Alt text** | {{"Capture d'écran montrant l'écran de configuration initiale, étape 1 sur 3."}} |
| **Emplacement** | au milieu de la section "Comment ça marche" |
| **Format** | PNG (UI) ou WebP |
| **Dimensions** | 1200 × 800 max |
| **Poids cible** | < 200 Ko |
| **Lazy-load** | oui |
| **Source prévue** | interne (capture d'écran de l'app) |
| **Licence** | propriété projet |
| **Crédit** | non requis |
| **Statut** | à créer |

### I-003 — Section "Cas d'usage"

| Critère | Valeur |
|---|---|
| **Description** | {{schéma simple du flow utilisateur}} |
| **Style** | vectoriel (Excalidraw / Figma) |
| **Prompt IA / mots-clés** | N/A (créé en interne) |
| **Alt text** | {{"Schéma du parcours utilisateur en 4 étapes : connexion, configuration, action, validation."}} |
| **Emplacement** | début section "Cas d'usage" |
| **Format** | SVG |
| **Dimensions** | adaptable |
| **Source prévue** | interne |
| **Licence** | propriété projet |
| **Crédit** | non requis |
| **Statut** | à créer |

---

## 3. Prompts IA détaillés (si génération AI)

### Hero (I-001)

```
Photographic, top-down close-up of a developer's hands on a mechanical keyboard,
mid-typing. Backlit by soft window light from the left. Warm morning ambience.
Background: blurred wooden desk, ceramic mug with coffee, small plant.
Color palette: muted tones with subtle blue accents on the screen.
Mood: focused, professional, calm.
NOT corporate stock photography. NOT person smiling at camera.
Aspect ratio: 2:1 (1920 × 960).
```

### Image illustration (si pertinent)

```
Flat vector illustration, isometric perspective. Subject: developer workstation
with laptop, monitor, keyboard. Color palette: 3 colors max — primary blue,
neutral gray, accent orange. Clean lines, minimal shadows. Mood: organized,
tech-focused.
NOT photographic. NOT cartoonish. NOT 3D-rendered.
Aspect ratio: 16:9.
```

---

## 4. Anti-patterns (à éviter)

- ❌ équipe en costume autour d'une table en verre
- ❌ mains anonymes flottant sur clavier sans contexte
- ❌ ampoule lumineuse symbolisant "idée"
- ❌ poignée de main symbolisant "deal"
- ❌ flèche montante symbolisant "growth"
- ❌ robot mignon symbolisant "IA"
- ❌ city skyline at night sans rapport
- ❌ stock photo avec personne souriant à la caméra dans contexte business
- ❌ mix de styles (photo + illustration + 3D dans le même article)

---

## 5. Cohérence du style

**Style retenu pour cet article** : {{photographique réaliste / illustration plate / 3D / schémas / mixte avec règles}}

**Cohérence garantie** : {{toutes les images suivent le style retenu, même palette, même ambiance}}

---

## 6. Crédits (pour `image-credits.md` ou footer article)

```markdown
## Crédits images

- Image principale : photo par {{Prénom Nom}} sur [Unsplash]({{URL}}).
- Schéma section "Cas d'usage" : créé en interne.
- Captures d'écran : interface produit (propriété projet).
```

---

## 7. Optimisation technique

Avant publication :

- [ ] **format** : WebP qualité 80–85 (fallback JPEG)
- [ ] **dimensions** : adapter à l'usage
- [ ] **`width`** + **`height`** explicites pour éviter CLS
- [ ] **lazy-load** : `loading="lazy"` sur images sous la ligne de flottaison
- [ ] **eager** + `fetchpriority="high"` : sur le hero LCP
- [ ] **`<picture>`** avec srcset si responsive nécessaire

---

## 8. Checklist plan d'images

- [ ] **image principale** documentée avec tous les champs
- [ ] **alt text** non vide sur toutes images informatives
- [ ] **alt=""** explicite sur images décoratives
- [ ] **prompts IA** détaillés (pas vagues)
- [ ] **mots-clés** précis pour banque d'images
- [ ] **licences** vérifiées
- [ ] **crédits** ajoutés si requis
- [ ] **emplacement** précisé pour chaque image
- [ ] **style cohérent** sur toutes les images
- [ ] **anti-clichés** vérifiés
- [ ] **optimisation** documentée

---

Created by João de Almeida
