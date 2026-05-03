# Exemple — Article technique

## Contexte

Article de blog technique pour développeurs intermédiaires.
Sujet générique réutilisable : *"Optimiser une application Next.js avec les Server Components"*.

## Prompt utilisateur

> *"Write a complete SEO article about how to optimize a Next.js application with Server Components. Public : intermediate React developers. Tone : technical blog. Length : 1800 words. Include SEO metadata, code snippets, internal link suggestions, FAQ, image plan, official sources. Mark unverifiable claims as 'TO VERIFY'."*

## Angle éditorial attendu

- **Pas** une introduction au concept (ça existe partout) ;
- **Angle pratique** : *"comment migrer un projet existant"* ou *"erreurs courantes en passant aux Server Components"* ;
- l'auteur a une **voix** : il a essayé, il sait ce qui foire, il l'écrit.

## Structure attendue

| Section | Contenu |
|---|---|
| H1 | titre précis, mot-clé naturel |
| Introduction (3–4 phrases) | pose le problème, précise le public, annonce la valeur |
| H2 — Quand utiliser Server Components vs Client Components | grille de décision claire |
| H2 — Migration d'un projet existant | étapes, erreurs courantes |
| H2 — Patterns recommandés | 4–5 patterns avec code |
| H2 — Pièges fréquents | liste avec correction |
| H2 — Performance et mesures | comment vérifier que ça améliore |
| H2 — Erreurs à éviter | liste actionnable |
| H2 — FAQ | 4–6 questions réelles |
| H2 — Pour aller plus loin | liens internes |
| H2 — Sources | doc officielle |
| Conclusion + CTA | non triviale |
| Score | sur 100 |

## SEO attendu

- **title** : *"Optimiser Next.js avec les Server Components : guide pratique"* (60 car.) ;
- **meta description** : *"Patterns, migration et pièges courants pour utiliser les Server Components Next.js 14+. Exemples de code, erreurs à éviter, FAQ."* (155 car.) ;
- **slug** : `nextjs-server-components-guide` ;
- **mot-clé principal** : *"Server Components Next.js"* ;
- **mots-clés secondaires** : *"migration React Server Components"*, *"client vs server components"*, *"Next.js 14 performance"* ;
- **schema_type** : `Article` ;
- **search_intent** : informationnelle / tutoriel.

## Exemples concrets à inclure

- Un **snippet de code** par pattern (5 patterns minimum).
- Une **mesure chiffrée** de la différence avant/après (avec source ou TO VERIFY).
- Un **cas réel** anonymisé d'erreur de migration.

## Liens internes possibles

| # | Slug cible | Ancre suggérée | Raison |
|---|---|---|---|
| 1 | `/blog/nextjs-app-router-introduction` | "introduction au App Router" | prérequis si lecteur découvre |
| 2 | `/blog/react-suspense-patterns` | "patterns Suspense" | complémentaire |
| 3 | `/docs/nextjs-deployment` | "guide de déploiement Next.js" | suite logique |
| 4 | `/blog/web-vitals-checklist` | "checklist Web Vitals" | pour mesurer l'impact |

## Images recommandées

| Slot | Description | Style |
|---|---|---|
| Hero | Capture d'écran d'un terminal montrant un build Next.js | screenshot ou photo de workstation |
| Section "Migration" | Diagramme simple avant/après architecture | vectoriel propre |
| Section "Patterns" | Captures de DevTools React montrant les composants | screenshots annotés |

## Sources nécessaires

- React Team. *"Server Components"*. React docs. https://react.dev/reference/rsc/server-components
- Vercel. *"Next.js App Router: Server Components"*. https://nextjs.org/docs/app/building-your-application/rendering/server-components
- (Si chiffre de performance utilisé) : benchmark à citer ou marquer TO VERIFY.

## Erreurs à éviter

- **introduction trop longue** (*"Dans le monde du développement web moderne..."*) ;
- **"qu'est-ce qu'un Server Component"** sur 600 mots (le public est intermédiaire, pas débutant) ;
- **inventer des chiffres de performance** ;
- **citer "selon une étude récente"** sans nommer l'étude ;
- **mélanger Pages Router et App Router** dans les exemples sans préciser ;
- **CTA générique** ("Lisez nos autres articles !") ;
- **FAQ artificielle** avec des questions reformulées de l'article.

## Score qualité attendu

**80–90 / 100** — Bon contenu SEO. Premium si l'auteur ajoute un **benchmark mesuré** vérifiable.

---

Created by João de Almeida
