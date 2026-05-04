# Research matrix — `premium-webdesigner`

Grille de routage par **type de projet**. Quoi consulter en priorité, quoi éviter, quel niveau de "wow" est autorisé, quels risques surveiller, et quel livrable produire.

> Cette matrice **complète** [`inspiration-sources.md`](inspiration-sources.md). Elle ne remplace pas la méthode des 6 phases (cf. `SKILL.md` §4), elle l'**oriente** selon le contexte.
>
> **Règle d'usage :** identifier le type de projet en Phase A → consulter la ligne correspondante avant la Phase B → documenter dans le moodboard les sources réellement consultées et le niveau de "wow" retenu.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Légende

| Champ | Définition |
|---|---|
| **Sources prioritaires** | À consulter en premier avant Phase B |
| **Sources à éviter** | Risque de patchwork, de stack inadaptée, ou de ton incompatible |
| **Type de "wow" autorisé** | Niveau d'effets / animations / 3D acceptables — au-delà = bling-bling |
| **Risques à surveiller** | Pièges récurrents pour ce type de projet |
| **Livrable attendu** | Ce qui doit figurer dans le rapport final |

---

## 1. SaaS B2B (productivité, dev tools, analytics)

| Champ | Contenu |
|---|---|
| **Sources prioritaires** | shadcn/ui, 21st.dev (Featured + Popular), Magic UI, Landingfolio, SaaS Websites, Refero |
| **Sources à éviter** | Codrops (trop expérimental), Aceternity en bloc (trop "demo"), Spline (overkill sauf produit IA visuel) |
| **Type de "wow" autorisé** | Animations subtiles d'apparition, gradients maîtrisés, mockup produit dans hero, micro-interactions sur cards/CTA |
| **Risques à surveiller** | Hero générique "We help businesses grow", pricing illisible, témoignages inventés, footer pauvre, dark mode mal contrasté |
| **Livrable attendu** | Brief design + moodboard avec 3 SaaS de référence + design system + sélection composants (hero, features, pricing, testimonials, CTA, footer) |

---

## 2. Dashboard admin / interne

| Champ | Contenu |
|---|---|
| **Sources prioritaires** | shadcn/ui, Blocks.so, HyperUI (sections data), Mobbin, Pageflows, Origin UI |
| **Sources à éviter** | Awwwards, Godly (portfolio artistique), Spline / Rive (inutile en admin), Aceternity (trop marketing) |
| **Type de "wow" autorisé** | Quasi nul — densité maîtrisée, hover discret, transitions 150ms, skeleton loaders propres |
| **Risques à surveiller** | Stats illisibles, data table sans pagination ni recherche debounced, empty states absents, états chargement ignorés, mobile cassé |
| **Livrable attendu** | Brief + design system **dense** + sélection composants (stats cards, data tables, empty states, navigation, filtres, badges, progress) |

---

## 3. Site association / collectivité / ONG

| Champ | Contenu |
|---|---|
| **Sources prioritaires** | SiteInspire, One Page Love, HyperUI, Preline, Unsplash / Pixabay (mots-clés "community"), Codrops (avec **modération**) |
| **Sources à éviter** | Aceternity (ton trop SaaS), Magic UI (trop tech), Spline (luxe inadapté) |
| **Type de "wow" autorisé** | Hero photo forte (vraies personnes du projet), animations quasi nulles, accent humain |
| **Risques à surveiller** | Stock photos corporate, ton trop "startup", manque de coordonnées et appels à l'action concrets (don, bénévolat, contact), accessibilité oubliée |
| **Livrable attendu** | Brief + moodboard avec photos réelles si possible + design system simple + sections (mission, actions, équipe, agenda, dons, contact) |

---

## 4. Site artiste / label musical / DJ / créatif

| Champ | Contenu |
|---|---|
| **Sources prioritaires** | Codrops, Godly, Awwwards, Spline / Rive (avec **modération**), images / médias forts (vrais visuels du projet), Fontshare (typo de caractère) |
| **Sources à éviter** | Flowbite, daisyUI, TailGrids (look "framework" inadapté), Preline (trop SaaS) |
| **Type de "wow" autorisé** | Élevé — typographie marquée, transitions cinématographiques, scène 3D au hero, hover audacieux, palette tranchée |
| **Risques à surveiller** | Animation au détriment de la lisibilité, navigation confuse, perf ruinée par 3D non optimisée, `prefers-reduced-motion` ignoré, mobile dégradé |
| **Livrable attendu** | Brief + moodboard avec direction artistique forte + design system marqué + sections (releases, agenda, médias, presskit, contact booking) |

---

## 5. Mini CMS PHP / HTML / WordPress

| Champ | Contenu |
|---|---|
| **Sources prioritaires** | HyperUI, Preline, Meraki UI, Mamba UI, Uiverse, FreeFrontend, TailwindFlex |
| **Sources à éviter** | shadcn (React-only), Magic UI / Aceternity / Motion Primitives (React-only), Spline (poids), Blocks.so (React) |
| **Type de "wow" autorisé** | Modéré — micro-interactions CSS pures, hover propres, transitions 200ms, **pas de React imposé** |
| **Risques à surveiller** | Imposer un build moderne (Tailwind compilé alors que le projet n'a pas Node), casser un thème WP, doublonner les CSS, perdre le SEO existant |
| **Livrable attendu** | Brief + composants HTML/Tailwind purs + design system léger + adaptation respectueuse de la stack existante |

---

## 6. Landing page produit / lancement / waitlist

| Champ | Contenu |
|---|---|
| **Sources prioritaires** | Landingfolio, One Page Love, Lapa Ninja, 21st.dev (Featured), Magic UI, Aceternity (1 effet max), Haikei (background SVG) |
| **Sources à éviter** | Mobbin (orienté flow), Refero (orienté UI patterns), Codrops (trop expérimental pour conversion) |
| **Type de "wow" autorisé** | Élevé sur le hero **uniquement** — un effet signature (gradient animé, marquee, particles), reste sobre |
| **Risques à surveiller** | Trop d'effets qui noient le CTA, formulaire waitlist cassé, métriques inventées, pas de social proof, perf hero (LCP > 2.5s) |
| **Livrable attendu** | Brief + 1 hero signature + sections (problème, solution, social proof, CTA répété, FAQ) + design system minimal + perf vérifiée |

---

## 7. Portfolio / freelance / agence

| Champ | Contenu |
|---|---|
| **Sources prioritaires** | Awwwards, SiteInspire, Godly, Lapa Ninja, Fontshare, Spline (1 scène max) |
| **Sources à éviter** | Flowbite, daisyUI, TailGrids (look corporate), HyperUI seul (pas assez signature) |
| **Type de "wow" autorisé** | Élevé — la signature visuelle **est** la valeur ; typographie marquée, layout original, transitions soignées |
| **Risques à surveiller** | Sites cas-études vides ("Coming soon"), navigation cachée par esthétique, contact difficile à trouver, mobile négligé |
| **Livrable attendu** | Brief + DA forte + sections (intro, sélection projets, à propos, contact) + cas-études réels documentés |

---

## 8. Site service local (restaurant, coiffeur, tatoueur, salle de sport)

| Champ | Contenu |
|---|---|
| **Sources prioritaires** | One Page Love, SiteInspire, HyperUI, Preline, Unsplash / Pixabay (mots-clés sectoriels précis) |
| **Sources à éviter** | Aceternity, Magic UI (trop SaaS), Mobbin (orienté app), Codrops (trop techy) |
| **Type de "wow" autorisé** | Faible à modéré — photos fortes, hero immersif, hover doux, **info pratique avant tout** (adresse, horaires, réservation) |
| **Risques à surveiller** | Manque coordonnées visibles, pas de carte / horaires, photos stock clichés, formulaire réservation cassé, SEO local oublié |
| **Livrable attendu** | Brief + design system sectoriel + sections (intro, services, galerie, équipe, infos pratiques, réservation, contact) |

---

## 9. Documentation / blog / site média

| Champ | Contenu |
|---|---|
| **Sources prioritaires** | shadcn/ui (si React), HyperUI (si HTML), Refero, Fontpair, sites docs de référence (Stripe, Vercel) |
| **Sources à éviter** | Aceternity, Magic UI (trop visuel pour de la doc), Spline / Rive (poids inutile) |
| **Type de "wow" autorisé** | Quasi nul — typographie soignée, lisibilité maximale, table des matières propre, code blocks lisibles |
| **Risques à surveiller** | Body < 16px, longueur de ligne > 80 caractères, search absente, dark mode mal contrasté, navigation latérale cassée mobile |
| **Livrable attendu** | Brief + design système orienté **lecture** + composants (TOC, search, code block, callouts, breadcrumb, pagination article) |

---

## 10. Interface conçue pour démo vidéo YouTube

| Champ | Contenu |
|---|---|
| **Sources prioritaires** | 21st.dev (Featured), Magic UI, Aceternity (1 effet visible à l'écran), shadcn/ui, Lottie (icônes animées) |
| **Sources à éviter** | Sources sans personnalité visuelle (un design plat passe mal en vidéo) |
| **Type de "wow" autorisé** | Élevé sur les éléments **filmés** — contraste fort, animations visibles à 1080p, hover lisibles à distance, palette qui ressort |
| **Risques à surveiller** | Effets qui se voient mal en compression vidéo, contraste insuffisant en preview, texte trop fin pour 1080p, animations trop rapides pour la caméra |
| **Livrable attendu** | Brief + design system **vidéo-ready** + check des plans à filmer + une signature visuelle reconnaissable |

---

## Comment utiliser cette matrice

1. **Phase A** — identifier le type de projet (ligne à utiliser).
2. **Phase B** — consulter d'abord les "Sources prioritaires" de la ligne, ignorer les "Sources à éviter".
3. **Phase D** — caler le niveau d'effets sur le "Type de wow autorisé" — ne **jamais** dépasser sans justification documentée.
4. **Phase F** — vérifier les "Risques à surveiller" avant de livrer.
5. **Rapport final** — produire le "Livrable attendu" de la ligne.

Si le projet **chevauche** plusieurs lignes (ex : SaaS B2B avec une landing très visuelle), combiner **2 lignes max** et expliciter le compromis dans le moodboard.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
