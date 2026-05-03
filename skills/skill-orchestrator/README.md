# skill-orchestrator

> Created by João de Almeida

Skill de **coordination léger** pour l'écosystème Art of Dev Claude Skills.
Son rôle : analyser une demande utilisateur, identifier le bon skill à utiliser, **sans charger automatiquement plusieurs skills lourds**.

---

## 1. Pourquoi ce skill existe

L'écosystème Art of Dev compte plusieurs skills spécialisés (`repo-builder`, `production-auditor`, `premium-webdesigner`, `seo-content-engine`, `site-ux-guardian`, `multilingual-site-engine`).

Sans orchestration, on observe deux dérives :

- **Sur-mobilisation** : Claude charge 3–4 skills "au cas où", explosion du contexte.
- **Mauvais routage** : Claude utilise un skill générique alors qu'un skill plus spécifique existe.

`skill-orchestrator` résout les deux : **le skill le plus spécifique, et lui seul** (sauf si la demande exige explicitement un workflow multi-skills).

---

## 2. USE WHEN

- la demande est **ambiguë** ;
- l'utilisateur demande explicitement *"quel skill utiliser"* ;
- l'utilisateur veut un **workflow multi-skills** ;
- l'utilisateur n'est **pas sûr du périmètre**.

## 3. SKIP WHEN

- la demande est triviale (typo, fix CSS isolé) ;
- un skill plus spécifique est évident dès la première lecture ;
- l'utilisateur a déjà nommé le skill à utiliser.

---

## 4. Table de routage rapide

| Intent | Primary skill | Supporting (optionnel) |
|---|---|---|
| Créer un repo | `repo-builder` | `production-auditor` |
| Audit production | `production-auditor` | `site-ux-guardian`, `premium-webdesigner` |
| Refonte design / UI | `premium-webdesigner` | `site-ux-guardian` |
| Article SEO / contenu | `seo-content-engine` | `multilingual-site-engine` |
| Cohérence ergonomique | `site-ux-guardian` | `premium-webdesigner` |
| Traduction / multilingue | `multilingual-site-engine` | `seo-content-engine` |

Détails complets : [`references/routing-rules.md`](references/routing-rules.md).

---

## 5. Exemples de prompts

### Exemple 1 — demande ambiguë

> *"Audite ce projet, je ne sais pas si c'est UX ou prod."*

Réponse orchestrateur :

```
**Skill recommandé :** site-ux-guardian
**Raison :** "ergonomique" et "audit site" sont des marqueurs UX ; un audit prod complet serait redondant.
**Skills secondaires possibles :** production-auditor (uniquement si l'audit UX révèle des risques de prod).
**Action proposée :** lancer un audit ergonomique d'abord, puis évaluer si un audit prod est nécessaire.
**Confirmation requise ?** non, audit UX en lecture seule.
```

### Exemple 2 — workflow multi-skills

> *"Je veux refondre la home et vérifier que tout reste cohérent."*

Réponse orchestrateur :

```
**Skill recommandé :** premium-webdesigner
**Raison :** "refondre" est un marqueur de direction artistique.
**Skills secondaires possibles :** site-ux-guardian (en aval, pour vérifier la cohérence sur le reste du site).
**Action proposée :** workflow séquentiel : 1) premium-webdesigner pour la home, 2) site-ux-guardian pour cohérence globale.
**Confirmation requise ?** oui, refonte = action lourde.
```

### Exemple 3 — demande explicite skill direct

> *"Quel skill devrait-on utiliser pour traduire un dashboard ?"*

Réponse orchestrateur :

```
**Skill recommandé :** multilingual-site-engine
**Raison :** demande explicite de traduction.
**Skills secondaires possibles :** site-ux-guardian (pour vérifier que le switch langue est cohérent).
**Action proposée :** charger multilingual-site-engine pour la traduction du dashboard.
**Confirmation requise ?** oui, traduction multi-langues = action large.
```

### Exemple 4 — demande triviale

> *"Corrige cette typo dans le footer."*

Réponse orchestrateur :

```
**Skill recommandé :** aucun
**Raison :** correction atomique, aucun skill nécessaire.
**Skills secondaires possibles :** aucun.
**Action proposée :** modifier directement le fichier footer concerné.
**Confirmation requise ?** non.
```

---

## 6. Ce que ce skill ne fait jamais

- **Jamais** créer un repo, lancer un push, ou exécuter une action destructive.
- **Jamais** charger plusieurs gros skills sans confirmation explicite.
- **Jamais** remplacer un skill (il route, il n'exécute pas).
- **Jamais** auditer ou modifier directement du code.
- **Jamais** ajouter un skill secondaire "au cas où" — règle de minimalité stricte.

---

## 7. Règles d'arbitrage (résumé)

- Le **plus spécifique** gagne toujours.
- Si l'utilisateur **mentionne** un skill, respecter son choix.
- Si la demande est **floue**, poser **une question courte** plutôt que de deviner.
- Si **plusieurs skills sont nécessaires**, proposer un **workflow séquentiel** (jamais parallèle automatique).

Détails : [`references/conflict-resolution.md`](references/conflict-resolution.md).

---

## 8. Token-conscious design

Ce skill est **volontairement court**. Son rôle est de **filtrer**, pas de dupliquer la logique des autres skills.

- `SKILL.md` court (~150 lignes).
- Pas de chargement préventif d'autres skills.
- Délégation explicite, pas implicite.

Détails : [`references/token-optimization.md`](references/token-optimization.md).

---

Created by João de Almeida
