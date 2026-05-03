# Exemple — Humaniser un site dont les textes sentent l'IA

> Cas concret : refonte éditoriale d'un site dont le contenu a été généré par IA sans relecture.

Created by João de Almeida

---

## Demande utilisateur

> *"Mon client trouve que mon site sent l'IA. Beaucoup de tirets longs, des
> phrases creuses, des formulations identiques d'une page à l'autre. Détecte
> tous les patterns, propose une réécriture des pages les plus touchées."*

---

## Question à poser

> *"Avant de commencer :*
> *1. Confirmes-tu que c'est uniquement la langue source à humaniser, pas une*
> *traduction ?*
> *2. Y a-t-il une voix de marque à respecter (ton informel jeune,*
> *professionnel formel, autre) ?*
> *3. Veux-tu que je réécrive directement, ou que je propose et tu valides ?*
> *4. Y a-t-il des pages prioritaires (home, pricing) ou tout le site ?"*

---

## Fichiers à inspecter

```
content/
├── index.md
├── about.md
├── services.md
├── pricing.md
├── blog/
│   └── (articles .md)
└── ...
```

Ou si site rendu :

```
app/
├── page.tsx
├── about/page.tsx
├── services/page.tsx
└── pricing/page.tsx
messages/
└── fr.json
```

---

## Étape 1 — Scanner les patterns

```bash
bash skills/multilingual-site-engine/scripts/scan-ai-style-patterns.sh .
```

Sortie type :

```
Tiret long (—) : 184 occurrences
  - content/index.md:14
  - content/services.md:23
  - content/pricing.md:8
  - ...

"dans le monde d'aujourd'hui" : 6 occurrences
  - content/index.md:3
  - content/about.md:12
  - ...

"solution innovante" : 9 occurrences
  - content/services.md:5
  - ...

"révolutionner" : 4 occurrences
  - ...

"expérience fluide" : 11 occurrences
  - ...

"de plus en plus" : 17 occurrences
  - ...

"il est important de" : 8 occurrences
  - ...

"découvrez comment" : 12 occurrences
  - ...
```

Total : **251 patterns IA détectés**, niveau **CRITIQUE**.

---

## Étape 2 — Ranger par priorité

| Page | Patterns détectés | Priorité |
|---|---|---|
| `index.md` (home) | 47 | 1 |
| `services.md` | 38 | 1 |
| `pricing.md` | 22 | 2 |
| `about.md` | 19 | 2 |
| `blog/article-X.md` | 35 (cumul) | 3 |
| `contact.md` | 7 | 3 |

---

## Étape 3 — Réécriture des pages prioritaires

### Avant (home)

> *"Dans le monde d'aujourd'hui — où chaque seconde compte — il est important
> de pouvoir compter sur des outils performants. Notre solution innovante —
> pensée pour les équipes modernes — révolutionne la manière dont vous gérez
> votre productivité. Découvrez comment optimiser votre workflow grâce à une
> expérience fluide et intuitive."*

**Détecté :**
- 4 tirets longs ;
- *"dans le monde d'aujourd'hui"* ;
- *"il est important de"* ;
- *"solution innovante"* ;
- *"révolutionne"* ;
- *"découvrez comment"* ;
- *"expérience fluide"*.

### Après (humanisé)

> *"Notre app remplace 4 outils par un seul : notes, tâches, calendrier, doc
> partagée. Les équipes l'utilisent pour arrêter de jongler entre Notion,
> Asana, Google Calendar et Slack."*
>
> *"10 jours d'essai gratuit, sans carte bancaire."*

**Changements :**
- 0 tiret long ;
- aucune phrase creuse ;
- adjectifs marketing remplacés par des faits concrets (4 outils → 1, noms d'outils précis) ;
- introduction raccourcie ;
- ton direct et concret.

---

## Étape 4 — Voix de marque

Si la voix souhaitée est **informelle et concrète** (typique SaaS jeune) :

- tutoiement ;
- contractions naturelles (*"on"* en FR informel) ;
- vocabulaire courant ;
- exemples chiffrés ;
- pas de jargon marketing.

Si la voix est **professionnelle B2B** :

- vouvoiement ;
- ton plus posé ;
- vocabulaire métier (mais pas creux) ;
- exemples de cas concrets clients.

---

## Étape 5 — Rapport d'humanisation

```markdown
## Synthèse
Style IA détecté : CRITIQUE (251 patterns).
14 pages réécrites.
Tirets longs supprimés : 184 → 12 (rhétoriques justifiées).
Phrases creuses supprimées : 67 → 0.
Voix de marque alignée sur "informel concret".

## Pages prioritaires réécrites
- index.md : 47 patterns → 0 ; ton aligné
- services.md : 38 → 2 (rhétoriques) ; ajout de cas concrets
- pricing.md : 22 → 0 ; clarification des plans
- about.md : 19 → 1 ; voix incarnée

## Pages secondaires en cours
- blog/* : à traiter article par article

## Pénalité Translation Quality Score
Avant humanisation : -8 / 10 sur le critère "Absence de style IA"
Après humanisation : 9 / 10

## Délégations
- pour rédiger de nouveaux articles : `seo-content-engine`
- pour traduire les pages humanisées : ce skill en mode 3

## Prochaine étape
Faire valider les 4 pages réécrites par le client, puis traiter les articles
de blog.
```

---

## Score attendu

| Critère | Note attendue |
|---|---|
| Critère "Absence de style IA" du Translation Quality Score | passage de 2/10 à 9/10 |
| Sentiment client | passage de "ça sent l'IA" à "c'est mieux, on reconnaît la marque" |

---

## Cas particulier — humaniser AVANT de traduire

Si le site doit être traduit en EN, DE, ES après humanisation : **toujours** humaniser le source d'abord. Sinon le style IA se propage dans toutes les langues, et on multiplie les corrections.

---

Created by João de Almeida
