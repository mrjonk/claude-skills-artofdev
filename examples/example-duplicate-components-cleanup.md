# Exemple — Cleanup de composants doublons

## Contexte

App React qui a connu plusieurs refontes successives sans nettoyage. Les noms de fichiers évoquent des couches de duplication : `Header.tsx`, `HeaderV2.tsx`, `HeaderNew.tsx`, `HeaderModern.tsx`, et même `header-final-final-2.tsx`.

## Demande originale

> *"Audit doublons sur tout le repo. Identifie composants doublons, fichiers .bak, pages quasi identiques, menus hardcodés. Plan de consolidation phasé. Ne supprime rien sans accord. Mode : audit only."*

## Analyse attendue

### Composants doublons détectés

| Type | Fichiers | Statut |
|---|---|---|
| Header | `Header.tsx`, `HeaderV2.tsx`, `HeaderNew.tsx`, `HeaderModern.tsx` | 4 versions, **3 inutilisées** |
| Footer | `Footer.tsx`, `FooterFinal.tsx`, `Footer-old.tsx` | 3 versions |
| Card | `Card.tsx`, `CardOld.tsx`, `ProductCard.tsx`, `ItemCard.tsx`, `Box.tsx` | 5 variantes, à consolider |

### Fichiers obsolètes / backup

| Fichier | Type | Action recommandée |
|---|---|---|
| `Footer.bak.tsx` | sauvegarde | demander à supprimer |
| `index-old.html` | page legacy | demander à supprimer ou rediriger |
| `style-v2.css` | CSS legacy | vérifier qu'il n'est plus chargé puis supprimer |
| `header-final-final-2.tsx` | doublon désespéré | demander à supprimer |
| `app/page-backup.tsx` | sauvegarde page | demander à supprimer |

### Pages quasi identiques

| Page 1 | Page 2 | Similarité |
|---|---|---|
| `/about` | `/about-us` | 95 % de contenu identique |
| `/contact` | `/nous-contacter` | 90 % similaires |
| `/services/all` | `/services` | 80 % similaires |

### Menus / footers hardcodés

Le scan révèle que les libellés "Accueil / Services / Contact / À propos" apparaissent dans **8 fichiers de pages** différents.
→ Probable hardcoding malgré l'existence d'un composant `Header.tsx`.

## Fichiers à inspecter

- `app/components/Header*.tsx` (4 fichiers)
- `app/components/Footer*.tsx` (3 fichiers)
- `app/components/Card*.tsx` + `Box.tsx` (5 fichiers)
- toutes les pages `app/**/page.tsx` pour vérifier quels Header/Footer/Card elles importent

## Plan de consolidation phasé (à valider)

### Phase 1 — Identifier les canoniques

- **Header canonique** : `Header.tsx` (le plus utilisé d'après les imports).
- **Footer canonique** : `Footer.tsx`.
- **Card canonique** : à décider (`Card.tsx` semble le plus générique).

### Phase 2 — Lister les usages

```bash
grep -rIE "import .* from .*/Header" app/
grep -rIE "import .* from .*/HeaderV2" app/
# etc.
```

→ Lister chaque utilisation des doublons.

### Phase 3 — Migrer une utilisation à la fois

- remplacer `<HeaderV2 />` par `<Header />` dans **un** fichier ;
- tester ;
- commiter (`refactor: migrate HeaderV2 to Header in <fichier>`) ;
- passer au suivant.

### Phase 4 — Nettoyer

Une fois **toutes** les migrations faites :

- vérifier qu'aucun import ne pointe encore vers `HeaderV2`, `HeaderNew`, `HeaderModern`, `header-final-final-2` ;
- supprimer ces fichiers ;
- commit dédié (`chore: remove deprecated header variants`).

### Phase 5 — Pages doublons

- décider canonique (`/about` vs `/about-us`) ;
- créer redirections 301 ;
- supprimer les pages canniblisées après vérification.

### Phase 6 — Fichiers de backup

- demander à l'utilisateur la liste des fichiers à supprimer (`.bak`, `*-old`, `*-backup`) ;
- supprimer un par un avec validation.

## Corrections sûres (Mode 2)

**Aucune.** Toute consolidation de doublon nécessite validation utilisateur.

## Corrections à valider

Tout le plan ci-dessus doit être validé phase par phase. Le skill **ne supprime rien** sans accord écrit.

## Score cohérence attendu

- **Doublons** : 4 / 10 (très problématique) ;
- **Discipline fichier** : 5 / 10 (refontes accumulées sans nettoyage) ;
- **Routes** : 9 / 15 (routes concurrentes) ;
- **Total cohérence** : ~55 / 100 → utilisable mais fragile.

## Score visuel attendu

- 70–78 / 100 (le rendu peut être OK malgré le bordel sous le capot).

## Rapport final attendu

```markdown
# Final coherence report — App React (cleanup needed)

Score cohérence : 55 / 100
Score visuel : 75 / 100
Verdict : Utilisable mais fragile (dette technique élevée)

Top 3 actions :
1. Identifier le Header canonique parmi les 4 versions et planifier la migration.
2. Décider du sort des 5 fichiers .bak / *-old / header-final-final-2.
3. Consolider les routes concurrentes (`/about` + `/about-us`).

Plan de consolidation : 6 phases (cf. duplicate-report.template.md).

Délégations :
- aucune (cleanup ergonomique avant tout, pas de refonte créative ni audit prod ici).
- recommandation : faire ce cleanup AVANT d'utiliser premium-webdesigner ou production-auditor.
```

## Erreurs à éviter

- **NE PAS** supprimer un composant doublon avant d'avoir migré ses usages ;
- **NE PAS** consolider en bloc (`HeaderV2 → Header` sur 30 fichiers d'un coup) ;
- **NE PAS** modifier les pages quasi identiques sans avoir validé la canonique ;
- **NE PAS** écraser un fichier `.bak` (l'utilisateur peut en avoir besoin pour comparer).

---

Created by João de Almeida
