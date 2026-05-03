# Sélection d'images — {{PROJECT_NAME}}

> Toutes les images du projet, avec source, licence, crédit et statut.
> Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Vue tabulaire

| ID | Image | Source | URL / chemin | Usage | Statut |
|---|---|---|---|---|---|
| I-001 | hero-homepage.webp | Unsplash | https://unsplash.com/photos/{{id}} | Homepage hero | `à intégrer` |
| I-002 | feature-1-mockup.png | interne | `/public/assets/images/sections/feature-1-mockup.png` | Section features 1 | `à fournir` |
| I-003 | testimonials/jane.webp | client | fournie par le client | Avatar testimonial | `en attente` |
| I-004 | placeholder-card.svg | interne | `/public/assets/images/placeholders/default-card.svg` | Cards par défaut | `généré` |

> Statuts : `à intégrer` | `intégré` | `optimisé` | `en attente` | `à fournir` | `validé` | `généré`.

---

## Détail par image

### I-001 — Hero homepage

| Critère | Valeur |
|---|---|
| **Image** | hero-homepage.webp |
| **Source** | Unsplash |
| **URL d'origine** | {{https://unsplash.com/photos/...}} |
| **Photographe / auteur** | {{Jane Doe — @janedoe}} |
| **Licence** | Unsplash License (libre, commercial OK, attribution appréciée) |
| **Crédit affiché** | oui (footer + `docs/image-credits.md`) |
| **Usage** | Homepage hero — section principale |
| **Alt text** | "{{Femme développeuse travaillant sur un laptop dans un bureau lumineux et minimaliste}}" |
| **Recadrage** | landscape 1920×960 (ratio 2:1), version `@2x` 3840×1920 |
| **Format** | WebP qualité 85 + fallback JPEG |
| **Poids cible** | < 150 Ko en WebP |
| **Lazy-load** | non (au-dessus ligne de flottaison, `fetchpriority="high"`) |
| **Statut** | `à intégrer` |

---

### I-002 — Feature 1 mockup

| Critère | Valeur |
|---|---|
| **Image** | feature-1-mockup.png |
| **Source** | capture d'écran interne (mockup app) |
| **Chemin** | `/public/assets/images/sections/feature-1-mockup.png` |
| **Auteur** | équipe projet |
| **Licence** | propriété projet |
| **Crédit affiché** | non requis |
| **Usage** | Section features — 1ère feature |
| **Alt text** | "{{Capture d'écran du dashboard Pomodoro avec timer actif et statistiques de focus}}" |
| **Recadrage** | 1200×800 (ratio 3:2) |
| **Format** | PNG (transparence pour ombre douce intégrée) |
| **Poids cible** | < 200 Ko après compression |
| **Lazy-load** | oui |
| **Statut** | `à fournir` (mockup pas encore prêt) |

---

### I-003 — Avatar testimonial Jane Doe

| Critère | Valeur |
|---|---|
| **Image** | testimonials/jane.webp |
| **Source** | photo fournie par le client |
| **Chemin** | (à intégrer dans `/public/assets/images/testimonials/`) |
| **Auteur** | Jane Doe (autorisation reçue par email du {{date}}) |
| **Licence** | autorisation écrite obtenue |
| **Crédit affiché** | nom + entreprise sous le testimonial |
| **Usage** | Section testimonials — avatar circle 80×80 |
| **Alt text** | "Jane Doe, CEO de Acme Corp" |
| **Recadrage** | square 320×320, crop centré sur visage |
| **Format** | WebP qualité 90 + fallback JPEG |
| **Poids cible** | < 30 Ko |
| **Lazy-load** | oui |
| **Statut** | `en attente` (photo HD à recevoir) |

---

### I-004 — Placeholder card

| Critère | Valeur |
|---|---|
| **Image** | placeholder-card.svg |
| **Source** | généré en interne |
| **Chemin** | `/public/assets/images/placeholders/default-card.svg` |
| **Auteur** | équipe projet |
| **Licence** | propriété projet |
| **Crédit affiché** | non requis |
| **Usage** | placeholder pour cards quand image absente |
| **Alt text** | "" (décoratif) |
| **Recadrage** | scalable (SVG) |
| **Format** | SVG (gradient + icône Lucide en SVG inline) |
| **Poids cible** | < 2 Ko |
| **Lazy-load** | non (SVG inline) |
| **Statut** | `généré` |

---

## Résumé

- **Total images** : 4
- **Sources** :
  - 1 × Unsplash
  - 2 × interne (mockup + placeholder)
  - 1 × client
- **Licences** : toutes vérifiées
- **Crédits documentés** : oui dans `docs/image-credits.md`
- **À recevoir** : 1 (avatar testimonial Jane Doe)
- **À fournir** : 1 (mockup app feature 1)

---

## Anti-clichés vérifiés

- [ ] **pas** d'équipe en costume + tablette autour table en verre
- [ ] **pas** de mains anonymes sur clavier
- [ ] **pas** d'ampoule lumineuse symbolisant "idée"
- [ ] **pas** de poignée de main symbolisant "deal"
- [ ] **pas** de robot mignon symbolisant "IA"
- [ ] **pas** de flèche montante symbolisant "growth"
- [ ] **pas** de city skyline at night sans rapport
- [ ] mix de styles **cohérent** (toutes photo réaliste, ou toutes illustration plate, pas un mix chaotique)

---

Created by João de Almeida — Art of Dev — https://artofdev.space
