# Exemple — Homepage SaaS moderne

## Contexte

App SaaS productivité (timer focus + statistiques) pour freelances tech.
Stack : Next.js 14 + Tailwind + shadcn/ui.
Lancement public dans 2 semaines.
La home actuelle est un placeholder Next.js générique.

## Prompt utilisateur

> *"Refonte premium de la homepage. Cible : freelances tech 25-40 ans, sensibles au design Apple/Linear. Action principale : créer un compte gratuit. Émotion : sérénité + performance. Cherche 21st.dev pour hero, pricing, features. Direction artistique : palette tech avec accent corail. Implémente section par section. Rapport final."*

## Recherche d'inspiration attendue

### 21st.dev

| Catégorie | Pourquoi |
|---|---|
| Heros (featured + popular) | section critique, valeurs sûres |
| Features (newest) | look 2026, bento si possible |
| Pricing (popular) | toggle annuel/mensuel attendu |
| Testimonials (featured) | social proof |
| Footer (popular) | 4 colonnes minimum |

### shadcn/ui

- Button, Card, Tabs, Toast, Form (briques atomiques)

### Sites de référence

- **Linear** — clean, animations subtiles ;
- **Cron** — typographie ;
- **Vercel** — structure de page ;
- **Raycast** — landing dense mais aérée.

> Ne pas copier la signature (gradient violet Linear), garder la **logique**.

## Composants à chercher

| Composant | Source visée | Adaptation prévue |
|---|---|---|
| Hero with split mockup | 21st.dev featured | mockup à fournir, couleurs DS, FR |
| Feature bento grid | 21st.dev newest | 5 cellules, contenu adapté |
| Pricing 3 plans toggle | 21st.dev popular | 3 plans réels, EUR |
| Testimonials grid | shadcn block | 3-6 testimonials clients |
| Footer 4 columns | shadcn block | nav + contact + social + légal |

## Images à chercher

| Emplacement | Source | Mots-clés |
|---|---|---|
| Hero | Unsplash | `workstation clean`, `soft gradient abstract`, `developer focus` |
| Feature 1 mockup | interne | capture du dashboard |
| Feature 2 mockup | interne | capture du timer focus |
| Testimonials avatars | client | photos réelles à recevoir |

## Direction artistique

- **Palette** : primary `#1e40af` (bleu profond), accent `#fb7185` (corail), neutres slate
- **Typographie** : Cabinet Grotesk (display) + Inter (body)
- **Spacing** : base 4 px, sections 96–128 px desktop
- **Radius** : 6 / 12 / 24 px
- **Shadows** : subtiles, 2 niveaux max
- **Animations** : 150–250 ms ease-out, hover boutons et cards, scroll-reveal sections
- **Mode** : light par défaut, dark mode optionnel (à activer plus tard si demandé)

## Résultat attendu

5 fichiers dans `docs/` :
- `design-brief.md` rempli
- `moodboard-report.md` avec sources et palette
- `component-selection.md` avec 5 composants documentés
- `image-selection.md` avec 4 images documentées
- `design-system.md` avec tokens

Puis implémentation :
- `src/app/page.tsx` refondu
- `src/components/Hero.tsx`, `Pricing.tsx`, `FeaturesBento.tsx`, `Testimonials.tsx`, `Footer.tsx` (nouveaux)
- `tailwind.config.js` (ajout palette, fontFamily)
- `src/app/globals.css` (variables CSS)
- `public/assets/images/hero/homepage-hero.webp`
- `docs/image-credits.md`

Rapport final dans `reports/redesign-YYYY-MM-DD.md` avec score `ui-quality-checklist`.

### Score attendu

| Axe | Cible |
|---|---|
| Visuel | 80–90 |
| UX | 80–85 |
| Responsive | 90+ |
| Accessibilité | 85+ |
| Cohérence | 85+ |
| Premium feel | 80+ |
| **Global** | **85+** |

## Erreurs à éviter

- **mosaïque de composants** non réharmonisés ;
- **hero animé Three.js** trop lourd (600 Ko bundle) ;
- **lorem ipsum** résiduel dans les sections ;
- **stock photos clichés** (équipe en costume autour table) ;
- **footer pauvre** (juste copyright) ;
- **ajouter Stripe en dur** alors qu'il faut juste un placeholder pricing ;
- **casser la page /pricing existante** si elle existe déjà ;
- **forcer dark mode** non demandé (il est optionnel ici).

## Checklist finale

- [ ] design-brief rempli et validé
- [ ] moodboard-report rendu
- [ ] 5 composants documentés
- [ ] 4 images documentées
- [ ] design-system documenté
- [ ] hero implémenté + responsive 4 BP
- [ ] features bento implémenté
- [ ] pricing implémenté (devise EUR, toggle)
- [ ] testimonials implémenté (placeholder si photos pas reçues)
- [ ] footer implémenté
- [ ] alt sur toutes images informatives
- [ ] contraste AA vérifié
- [ ] Lighthouse SEO ≥ 90, A11y ≥ 90
- [ ] LCP < 2.5 s
- [ ] redesign-report.md rendu
- [ ] mention `Created by João de Almeida — Art of Dev`

---

Created by João de Almeida — Art of Dev — https://artofdev.space
