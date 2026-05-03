# Skill 3 — `premium-webdesigner` : empêcher Claude de créer des interfaces basiques

*Section éditoriale prête à intégrer dans l'article publié sur jonk.space / Art of Dev.*

---

## Le problème : "moderne" ne suffit pas comme consigne

Quand on demande à une IA *"fais-moi un design moderne"*, on récupère systématiquement la même chose :

- une homepage avec un gros titre centré ;
- trois cards en dessous, identiques, avec des icônes random ;
- un dégradé violet posé "parce que ça fait moderne" ;
- une stock photo d'équipe en costume ;
- un footer pauvre avec juste un copyright.

C'est le **design IA générique**.

Le problème n'est pas que l'IA n'a pas de goût. Le problème est qu'**elle saute toutes les phases qui font un vrai design** :

- elle ne **comprend** pas le produit ;
- elle ne **regarde** pas ce qui se fait ailleurs ;
- elle ne **choisit** pas de composants spécifiques ;
- elle ne **réfléchit** pas à l'image ;
- elle ne **construit** pas de design system ;
- elle code direct, sur la base d'une moyenne statistique des designs existants.

Résultat : un design qui ressemble à 1000 autres. Si on **enlève le logo**, on peut le coller sur n'importe quel SaaS, n'importe quelle association, n'importe quel restaurant. C'est le test ultime du design générique.

## La solution : un Claude Skill qui force une méthode

`premium-webdesigner` est un **Claude Skill** qui interdit à Claude de coder directement.

Quand tu lui dis *"fais-moi un design moderne"*, il ne génère plus de code. Il déroule **6 phases obligatoires** :

1. **Compréhension** — quel est le produit ? la cible ? l'action principale ? l'émotion à transmettre ?
2. **Recherche d'inspiration** — consultation de 21st.dev, shadcn/ui, Lucide, Motion, Unsplash, Pixabay + 2–3 sites de référence sectoriels.
3. **Sélection de composants** — choix explicite des composants (hero, pricing, features, footer, dashboard cards, etc.) avec **source**, **URL**, **raison du choix**, **adaptations nécessaires**.
4. **Direction artistique** — palette, typographie, spacing, radius, shadows, animations.
5. **Sourcing d'images** — Pixabay / Unsplash en priorité, mots-clés précis par secteur, alt text + licence + crédit documentés.
6. **Exécution** — et **seulement maintenant**, Claude implémente — en restant **fidèle à la stack existante**.

Tout est documenté. Tout est validable avant de coder.

## Comment il utilise 21st.dev

`21st.dev` est une **bibliothèque communautaire** de composants UI modernes. C'est l'un des meilleurs catalogues d'inspiration disponibles en 2026.

Le skill l'utilise selon une **grille de décision** :

- **Featured + Popular** pour les sections critiques (hero, pricing, CTA — valeurs sûres) ;
- **Newest** pour l'inspiration récente (éviter le look 2022) ;
- **Catégories ciblées** : Heros, Pricing, Features, Testimonials, Buttons, Dashboard, Modern UI.

Pour chaque composant retenu, Claude **documente** :

| Critère | Exemple |
|---|---|
| Composant | "Hero with split mockup" |
| Source | 21st.dev community, featured |
| URL | https://21st.dev/community/components/... |
| Pourquoi pertinent | mockup à droite met le produit en valeur |
| Risques | mockup à fournir, animation Motion ajoute 30 Ko |
| Adaptations nécessaires | remplacer la couleur primary, traduire les textes |
| Dépendances | framer-motion |
| Impact responsive | OK 768/1024/1440, à vérifier 320 |
| Impact perf | LCP +200 ms (image à optimiser en WebP) |

**Anti-pattern explicite :** la mosaïque de composants incohérents. Le skill **interdit** de prendre ce hero d'un site, ce pricing d'un autre, ce footer d'un troisième. Tout doit être **réharmonisé** avec un design system unique.

## Comment il choisit les images

Le skill applique une **hiérarchie de sources** :

1. images **existantes** du projet (assets/, public/, media/, uploads/) ;
2. images **fournies** par l'utilisateur ;
3. **Pixabay** API (si `PIXABAY_API_KEY` disponible) ;
4. **Unsplash** API (si `UNSPLASH_ACCESS_KEY` disponible) ;
5. **placeholder propre** uniquement si rien d'autre.

Pour chaque secteur, il a des **mots-clés précis** :

- SaaS / tech : `abstract technology`, `workstation clean`, `soft gradient`, `dashboard interface` ;
- Association : `community gathering`, `local event`, `cultural activity` ;
- Musique / label : `studio equipment`, `vinyl`, `DJ booth`, `stage lights` ;
- Tatoueur : `tattoo studio`, `ink texture`, `urban wall`, `black and white portrait` ;
- Coiffeur : `salon interior modern`, `hair styling action`, `beauty product detail` ;
- Restaurant : `restaurant interior warm`, `gastronomic plate`, `chef working`.

**Anti-clichés** explicites : pas d'équipe en costume, pas de mains anonymes sur clavier, pas d'ampoule lumineuse "idée", pas de poignée de main "deal", pas de robot mignon "IA", pas de flèche montante "growth".

Chaque image est **documentée** : URL, photographe, licence, crédit, alt text.

## Comment il crée un design system

Le skill produit toujours un mini design system **avant** d'implémenter :

- **palette** : 1 dominante, 1 accent, 1–2 neutres, 3 sémantiques (max 6 couleurs) ;
- **typographie** : 1 display + 1 body (max 2 familles), échelle géométrique, 3 poids max ;
- **spacing** : base 4 ou 8 px, échelle géométrique (4 / 8 / 12 / 16 / 24 / 32 / 48 / 64 / 96) ;
- **radius** : 3 valeurs max (sm / md / lg) ;
- **shadows** : 2 niveaux max ;
- **boutons** : 3 variantes (primary / secondary / ghost), 3 tailles ;
- **animations** : 150–300 ms ease-out, max 2–3 motifs, `prefers-reduced-motion` respecté.

Le tout centralisé dans **un seul fichier** (Tailwind config, `:root` CSS, ou variables Sass) — pour que **changer une couleur soit l'affaire d'une ligne**, pas d'une chasse au trésor sur 50 fichiers.

## Comment il adapte selon la stack

C'est le point qui sépare un skill sérieux d'un skill jouet.

`premium-webdesigner` **n'impose jamais** une stack moderne sur un projet qui ne l'utilise pas :

- projet PHP → **pas** de React imposé ;
- projet HTML/CSS/JS → **pas** de Tailwind imposé ;
- projet WordPress → **pas** de Next.js imposé ;
- projet ASP.NET WebForms → **pas** de SPA imposé.

Le skill respecte ce qui existe et adapte le **niveau de sophistication** au **niveau d'effort acceptable**. C'est ce qui fait la différence entre un design "réaliste" et un design "fantasmé".

## Pourquoi c'est utile pour Art of Dev

Ma chaîne tourne autour de **mini CMS sectoriels**, de **SaaS** et de **projets filmables**. Tous mes projets passent par 3 contraintes :

1. **présentables dans une vidéo YouTube** (effet wow, lisible à 1080p, aucun secret à l'écran) ;
2. **livrables à un client** (zéro lorem, zéro placeholder, contenu réel) ;
3. **réutilisables** (design system clair, composants documentés, brief retrouvable).

`premium-webdesigner` me garantit que **chaque projet** suit la même méthode, produit le même type de documentation, et **ressemble à un projet sérieux** — pas à un POC bricolé.

Pour les autres outils Art of Dev (FocusForge, AudioMasterizer, Presskit, Stemify, PlannerDesk, jonk.space), c'est la même règle : pas de design IA générique, pas de homepage interchangeable. Chaque produit a sa **personnalité**, justifiée par son contenu et sa cible.

## Exemple de prompt

> *"Refonte premium de la homepage de FocusForge. Stack : Next.js 14 + Tailwind + shadcn/ui. Cible : freelances tech 25–40 ans, sensibles au design Apple/Linear. Action principale : créer un compte gratuit. Émotion : sérénité + performance. Cherche 21st.dev (featured + popular pour le hero, newest pour les features). Direction artistique : palette tech avec accent corail, typo Cabinet Grotesk + Inter, animations subtiles, dark mode supporté. Images via Unsplash. Implémente section par section, commits séparés. Rapport final avec score ui-quality-checklist."*

## Exemple de résultat attendu

Le skill rend (avant tout code) **5 fichiers** dans `docs/` :

- `design-brief.md` — projet, cible, objectif, contraintes ;
- `moodboard-report.md` — direction artistique, sources consultées, palette, typo ;
- `component-selection.md` — chaque composant 21st.dev avec URL, raison, adaptations ;
- `image-selection.md` — chaque image avec source, licence, crédit, alt ;
- `design-system.md` — tokens prêts à copier dans `tailwind.config.js`.

Puis il **implémente**, fichier par fichier, en commits séparés. À la fin, un **rapport** dans `reports/redesign-YYYY-MM-DD.md` avec :

- problèmes initiaux ;
- direction choisie ;
- composants utilisés ;
- images utilisées ;
- fichiers modifiés ;
- améliorations UX (avant → après) ;
- tests responsive aux 4 breakpoints ;
- score `ui-quality-checklist` (sur 100, 6 axes).

## La suite

`premium-webdesigner` est le **troisième** skill de la collection Art of Dev. Les deux précédents :

- **`repo-builder`** — créer des repos propres, documentés, structurés ;
- **`production-auditor`** — auditer un projet avant mise en prod (score sur 100, 7 axes).

À venir :

- `mini-cms-builder` — générer la base PHP/SQLite d'un mini CMS sectoriel ;
- `video-prep` — préparer un repo en mode screen-recording propre ;
- `zip-exporter` — empaqueter un projet en ZIP livrable client.

Chacun continue le même principe : **écrit une fois, appliqué mille fois**.

Le repo complet :

`github.com/mrjonk/claude-skills-artofdev`

---

Created by **João de Almeida** — Art of Dev
https://artofdev.space
