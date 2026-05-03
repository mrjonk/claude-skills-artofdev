# Sélection de composants — {{PROJECT_NAME}}

> Tableau de tous les composants UI retenus, avec source, justification, adaptations.
> Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Vue tabulaire

| ID | Composant | Source | URL | Usage prévu | Statut |
|---|---|---|---|---|---|
| C-001 | {{Hero with split mockup}} | 21st.dev (featured) | {{URL}} | Homepage hero | `à intégrer` |
| C-002 | {{Pricing 3 plans toggle}} | 21st.dev (popular) | {{URL}} | Section pricing | `à intégrer` |
| C-003 | {{Bento features grid}} | 21st.dev (newest) | {{URL}} | Section features | `à intégrer` |
| C-004 | {{Testimonials grid}} | shadcn block | https://ui.shadcn.com/blocks | Section testimonials | `à intégrer` |
| C-005 | {{Footer 4 columns}} | shadcn block | https://ui.shadcn.com/blocks | Footer toutes pages | `à intégrer` |

> Statuts : `à intégrer` | `intégré` | `adapté` | `validé` | `rejeté`.

---

## Détail par composant

### C-001 — {{Hero with split mockup}}

| Critère | Valeur |
|---|---|
| **Composant** | {{Hero with split mockup}} |
| **Source** | 21st.dev community — featured |
| **URL** | {{https://21st.dev/community/components/...}} |
| **Usage prévu** | Homepage hero — landing page principale |
| **Pourquoi pertinent** | met le mockup produit en valeur à droite, CTA simple à gauche, ambiance Linear-like |
| **Risques** | mockup PNG à fournir, animation Motion ajoute ~30 Ko |
| **Adaptations nécessaires** | remplacer la couleur primary par `#1e40af`, traduire les textes en français, swapper le mockup par notre capture |
| **Dépendances ajoutées** | `framer-motion` (~30 Ko), `lucide-react` (déjà présent) |
| **Impact responsive** | OK 768/1024/1440 ; à vérifier sur 320 (probable empilement vertical) |
| **Impact performance** | LCP +200 ms (mockup à optimiser en WebP) |
| **Statut** | `à intégrer` |

---

### C-002 — {{Pricing 3 plans toggle}}

| Critère | Valeur |
|---|---|
| **Composant** | {{Pricing 3 plans toggle annuel/mensuel}} |
| **Source** | 21st.dev community — popular |
| **URL** | {{https://21st.dev/community/components/...}} |
| **Usage prévu** | Section pricing |
| **Pourquoi pertinent** | toggle annuel/mensuel attendu sur SaaS B2B, plan central highlight |
| **Risques** | logique de toggle à brancher sur le state global (Stripe price IDs) |
| **Adaptations nécessaires** | mettre 3 plans réels (Free / Pro / Team), couleurs DS, devise EUR |
| **Dépendances ajoutées** | aucune (composant pur React + Tailwind) |
| **Impact responsive** | OK natif (cards s'empilent en mobile) |
| **Impact performance** | négligeable |
| **Statut** | `à intégrer` |

---

### C-003 — {{Bento features grid}}

| Critère | Valeur |
|---|---|
| **Composant** | {{Bento features grid}} |
| **Source** | 21st.dev community — newest |
| **URL** | {{https://21st.dev/community/components/...}} |
| **Usage prévu** | Section features (entre hero et pricing) |
| **Pourquoi pertinent** | look moderne 2025/2026, hiérarchie visuelle naturelle |
| **Risques** | empilement vertical en mobile peut sembler long ; vérifier `responsive-checklist.md` |
| **Adaptations nécessaires** | 5 cellules max, contenu adapté au produit, illustrations cohérentes |
| **Dépendances ajoutées** | aucune (CSS Grid pur) |
| **Impact responsive** | à vérifier — ratios à reconfirmer en mobile |
| **Impact performance** | dépend des images dans les cellules (lazy-load + WebP) |
| **Statut** | `à intégrer` |

---

### C-004 — {{Testimonials grid}}

| Critère | Valeur |
|---|---|
| **Composant** | {{Testimonials 3 columns}} |
| **Source** | shadcn block officiel |
| **URL** | {{https://ui.shadcn.com/blocks}} |
| **Usage prévu** | Section testimonials avant footer |
| **Pourquoi pertinent** | clean, lisible, n'écrase pas la page |
| **Risques** | testimonials réels nécessaires (pas inventés) |
| **Adaptations nécessaires** | 3–6 testimonials, photos clients réels |
| **Dépendances ajoutées** | aucune |
| **Impact responsive** | OK natif |
| **Impact performance** | négligeable |
| **Statut** | `à intégrer` (en attente photos client) |

---

### C-005 — {{Footer 4 columns}}

| Critère | Valeur |
|---|---|
| **Composant** | {{Footer with 4 columns}} |
| **Source** | shadcn block |
| **URL** | {{https://ui.shadcn.com/blocks}} |
| **Usage prévu** | Footer global toutes pages publiques |
| **Pourquoi pertinent** | minimum 3 colonnes (cf. `references/anti-basic-design-rules.md` §1.11), navigation + contact + légal |
| **Risques** | -- |
| **Adaptations nécessaires** | adapter les liens, ajouter copyright dynamique, social icons Lucide |
| **Dépendances ajoutées** | aucune |
| **Impact responsive** | OK natif (colonnes empilées en mobile) |
| **Impact performance** | négligeable |
| **Statut** | `à intégrer` |

---

## Résumé

- **Total composants retenus** : 5
- **Sources** : 3 × 21st.dev, 2 × shadcn block
- **Dépendances ajoutées** : `framer-motion`
- **Risques principaux** : mockup hero à fournir, testimonials clients à recevoir
- **Composants rejetés** : (à compléter si applicable)

---

## Composants rejetés (et pourquoi)

| Composant testé | Source | Raison du rejet |
|---|---|---|
| {{Hero animé Three.js}} | 21st.dev | trop lourd (600 Ko bundle), incompatible perf mobile |
| {{Pricing matrix}} | 21st.dev | trop dense pour 3 plans seulement |

---

Created by João de Almeida — Art of Dev — https://artofdev.space
