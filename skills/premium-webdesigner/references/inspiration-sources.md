# Sources d'inspiration — `premium-webdesigner`

Quoi consulter, quand, et **comment ne pas copier bêtement**.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Sources principales

### 1. 21st.dev community

| URL | Quand l'utiliser |
|---|---|
| https://21st.dev/community/components | recherche générale par tag |
| https://21st.dev/community/components/featured | sections critiques (hero, pricing, CTA) — valeurs sûres curated |
| https://21st.dev/community/components/popular | composants éprouvés par la communauté |
| https://21st.dev/community/components/newest | inspiration récente, tendances actuelles |
| https://21st.dev/community/components/s/ui | recherche "UI" |
| https://21st.dev/community/components/s/modern-ui | recherche "Modern UI" |

**Détaillé dans [`21st-dev-workflow.md`](21st-dev-workflow.md).**

### 2. shadcn/ui

| URL | Quand l'utiliser |
|---|---|
| https://ui.shadcn.com/docs | doc générale |
| https://ui.shadcn.com/docs/components | catalogue complet de composants |

**Quand l'utiliser :**
- la stack du projet est React (Next.js, Remix, Vite + React) ;
- on a Tailwind CSS et Radix UI / `cn` helper en place (ou prêt à les ajouter) ;
- on cherche des **briques atomiques** (Button, Dialog, Sheet, Form, Toast).

**Quand NE PAS l'utiliser :**
- projet PHP / WordPress / .NET / HTML pur (shadcn n'a aucun sens hors React) ;
- petit composant isolé qui ne mérite pas d'introduire toute une chaîne d'outillage.

### 3. Lucide (icônes)

| URL | Quand l'utiliser |
|---|---|
| https://lucide.dev/icons | recherche d'icônes propres et cohérentes |

**Pourquoi Lucide :**
- famille d'icônes line uniforme (1.5–2 px stroke) ;
- 1 400+ icônes ;
- libre (ISC) ;
- packages React, Vue, Svelte, web component, font.

**Règle :** *une seule famille d'icônes par projet.* Ne pas mélanger Lucide + Font Awesome + Material + emojis.

### 4. Motion (Framer Motion)

| URL | Quand l'utiliser |
|---|---|
| https://motion.dev/docs/react | animations React élégantes |

**Quand l'utiliser :**
- projet React et animations souhaitées (apparitions section, hover cards, page transitions) ;
- besoin de gérer `prefers-reduced-motion` proprement.

**Règle :** animations subtiles (150–300 ms, ease-out). Pas de parallax sur 30 sections. Pas d'effet bling-bling.

### 5. Unsplash

| URL | Quand l'utiliser |
|---|---|
| https://unsplash.com/documentation | API images premium |

**Quand l'utiliser :**
- besoin de photos haute qualité (hero, sections, blog) ;
- clé `UNSPLASH_ACCESS_KEY` disponible.

**Règles :**
- attribution requise (crédit photographe + lien Unsplash) ;
- éviter les clichés vus partout (rechercher au-delà de la 1re page de résultats) ;
- respecter la licence Unsplash (gratuite + commerciale OK + pas de revente directe).

### 6. Pixabay

| URL | Quand l'utiliser |
|---|---|
| https://pixabay.com/api/docs/ | API images / vidéos / illustrations |

**Quand l'utiliser :**
- besoin de photos, vidéos, ou illustrations ;
- clé `PIXABAY_API_KEY` disponible (cf. `CLAUDE_PROJECT_FACTORY.md` §14 du VPS Art of Dev).

**Règles :**
- licence Pixabay : libre, commercial OK, attribution non requise mais appréciée ;
- vérifier la qualité (variable selon l'auteur) ;
- préférer les requêtes spécifiques (`mots-clés métier`) plutôt que génériques (`business`, `office`).

---

## Sources secondaires (à utiliser ponctuellement)

### Sites de référence sectoriels

Pour un **secteur** donné, identifier 2–3 sites de référence premium :

| Secteur | Exemples (à valider selon contexte) |
|---|---|
| SaaS productivité | Linear, Notion, Cron, Raycast, Vercel |
| SaaS dev | Stripe, Vercel, Resend, Render, Supabase |
| Site agence/studio | Studio Pendar, Locomotive, Active Theory, Dept |
| Site artiste / DJ | Squarespace templates premium, Cargo, Format |
| Restaurant premium | Noma, sites Michelin, Tablo Madrid |
| Tatoueur | Sang Bleu, Tin-Tin Tatouages |
| Coiffeur | Hairdreams, salons Vidal Sassoon |
| Boutique / e-commerce | Aesop, Glossier, Off-White |

> **Attention :** ces noms sont des points de départ, pas des consignes de copie. Adapter selon contexte et époque (les sites changent).

### Inspirations galleries

- https://www.awwwards.com/
- https://siteinspire.com/
- https://lapa.ninja/
- https://land-book.com/
- https://www.dribbble.com/ (filtrer "Web Design", "Landing Page")
- https://mobbin.com/ (UI mobile / web SaaS)

**Règle :** consulter pour **logique** et **patterns**, pas pour copier pixel-perfect. Ces sites montrent souvent du **portfolio** (design idéal, pas optimisé conversion).

---

## Comment ne pas copier bêtement

### 1. Identifier les **patterns** récurrents

Si 5 sites premium SaaS ont :
- un hero avec sous-titre court + 2 CTA (un primaire, un secondaire) ;
- une section "Logos clients" juste après le hero ;
- un bloc "How it works" en 3 étapes ;

→ ce **n'est pas** une copie, c'est une **convention sectorielle**. La respecter est intelligent. La transgresser sans raison est risqué.

### 2. Identifier les **signatures**

Si Linear utilise un dégradé violet très spécifique + des animations de scroll précises, c'est leur **signature**. La copier est :
- contre-productif (on ressemble à Linear sans être Linear) ;
- potentiellement perçu comme cheap par les viewers avertis.

→ **adapter** la logique (un dégradé bien intégré + animations subtiles), pas la signature exacte.

### 3. Filtrer par **adéquation produit**

Pour chaque pattern observé, se demander :

- est-ce que ce pattern sert **mon** produit ?
- ma cible attend-elle ce code visuel ?
- mon contenu se prête-t-il à ce pattern ?

Exemple : copier le hero animé d'un produit SaaS sur le site d'un avocat = inadéquat.

### 4. Documenter les **emprunts**

Pour chaque inspiration utilisée :

- noter la source ;
- noter ce qu'on en garde (le pattern abstrait) ;
- noter ce qu'on en écarte (la signature visuelle) ;
- noter l'adaptation faite.

→ documenté dans `templates/moodboard-report.template.md`.

---

## Si l'accès web n'est pas disponible

Cas fréquent (Claude Code sandbox restreint, firewall, etc.).

**Comportement attendu :**

1. **Le dire** explicitement à l'utilisateur :
   > *"Je n'ai pas accès au web depuis cet environnement. Je vais m'appuyer sur les références internes du skill et te proposer une shortlist de composants à consulter manuellement."*
2. Utiliser uniquement les références **internes** du skill.
3. Proposer une **shortlist** de 3–5 composants nommés explicitement (par exemple : *"21st.dev — Hero with split image + CTA, catégorie Heros"*).
4. Demander à l'utilisateur de valider ou compléter avant d'implémenter.

**Ne jamais :** prétendre avoir consulté une source web inaccessible. Si non-vérifié, marquer `[à vérifier]` à côté.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
