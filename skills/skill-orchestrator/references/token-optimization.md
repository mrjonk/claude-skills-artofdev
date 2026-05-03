# Token optimization — `skill-orchestrator`

> Created by João de Almeida

Règles strictes pour **ne pas charger inutilement** des skills, des références ou du contexte. Le rôle de l'orchestrateur est de **filtrer**, pas d'amplifier.

---

## 1. Pourquoi c'est critique

Chaque skill chargé consomme du contexte :

- `SKILL.md` (parfois 500–1000 lignes) ;
- `references/*.md` (souvent plusieurs fichiers) ;
- `templates/*` ;
- `scripts/*`.

Si Claude charge 4 skills "au cas où", on perd **30–60% du budget de tokens** avant même d'avoir commencé la tâche réelle. C'est un gaspillage qui dégrade la qualité de la réponse finale.

L'orchestrateur existe pour éviter ça.

---

## 2. Règles non négociables

### 2.1 Un skill = un besoin

Un skill ne doit être chargé **que si la tâche le requiert directement**. Pas "au cas où". Pas "pour être complet". Pas "parce que ça pourrait servir".

### 2.2 Le SKILL.md d'un skill doit rester court

Pour qu'un skill soit orchestrable :

- `SKILL.md` court (idéalement 130–300 lignes) ;
- détails déportés dans `references/` ;
- chargement à la demande, pas en bloc.

`skill-orchestrator` lui-même respecte cette règle (~150 lignes pour `SKILL.md`).

### 2.3 Pas de chargement préventif

L'orchestrateur **ne charge jamais** un skill secondaire "au cas où". Il le **mentionne** comme possibilité dans le bloc de recommandation, mais c'est l'utilisateur qui décide.

### 2.4 Pas de doublon entre skills

Si deux skills couvrent partiellement le même périmètre, choisir le plus spécifique. Ne **jamais** charger les deux pour "couvrir tous les angles".

---

## 3. Quand suggérer "ne pas appeler de skill"

Cas où l'orchestrateur **doit recommander aucun skill** :

| Cas | Exemple | Action |
|---|---|---|
| Typo / fix mineur | *"corrige cette faute"* | modification directe |
| Lecture / inspection | *"affiche le contenu de X"* | lecture directe |
| Question simple | *"c'est quoi un .env ?"* | réponse directe |
| Renommage local | *"renomme cette variable"* | edit direct |
| Petit ajout CSS | *"ajoute 8px de padding"* | edit direct |
| Question de vocabulaire | *"que veut dire SSR ?"* | réponse directe |

Pour ces cas, l'orchestrateur produit :

```
**Skill recommandé :** aucun
**Raison :** {{action atomique / lecture / question simple}}
**Action proposée :** {{1 phrase}}
**Confirmation requise ?** non
```

---

## 4. Comment formuler une recommandation concise

### 4.1 Format obligatoire

```
**Skill recommandé :** {{skill}}
**Raison :** {{1 phrase}}
**Skills secondaires possibles :** {{liste ou "aucun"}}
**Action proposée :** {{1 phrase actionnable}}
**Confirmation requise ?** {{oui/non + raison}}
```

5 lignes max. Pas de préambule. Pas d'explication redondante.

### 4.2 Phrase "Raison" — règles

- Une seule phrase.
- Mentionne le **marqueur** dans la demande utilisateur (ex: *"'audit' + 'ergonomie' = UX-spécifique"*).
- Pas de jargon inutile.

### 4.3 "Skills secondaires possibles" — règles

- Liste seulement les skills **pertinents pour cette demande précise**.
- Pas plus de **2** secondaires.
- Si aucun n'est pertinent : *"aucun"*.

### 4.4 "Action proposée" — règles

- Verbe d'action en tête.
- Cible claire.
- Pas plus d'une phrase.

### 4.5 "Confirmation requise" — règles

- Oui si : audit large, refonte, multi-langues, création de repo, workflow ≥ 3 skills.
- Non si : audit léger lecture seule, action atomique.
- Toujours préciser **pourquoi** en quelques mots.

---

## 5. Anti-patterns de gaspillage

### 5.1 Recommander 3 skills pour une demande simple

**Mauvais :**

```
**Skill recommandé :** site-ux-guardian + premium-webdesigner + production-auditor
```

**Bon :**

```
**Skill recommandé :** site-ux-guardian
**Skills secondaires possibles :** premium-webdesigner (si refonte créative requise)
```

### 5.2 Charger toutes les références d'un skill

L'orchestrateur ne charge **aucun** fichier d'un skill secondaire. Il **mentionne** le skill, c'est tout.

### 5.3 Réécrire la doc des autres skills

L'orchestrateur **ne duplique pas** la doc des autres skills. Si l'utilisateur veut les détails, il charge le skill.

### 5.4 Boucler sur des recommandations

Si l'orchestrateur a déjà recommandé un skill et que l'utilisateur a validé, **passer la main**. Pas de re-recommandation.

---

## 6. Budget cible de l'orchestrateur

L'orchestrateur lui-même doit coûter :

- `SKILL.md` : ~150 lignes ;
- `references/` : 3 fichiers, ~200–300 lignes chacun, **chargés à la demande** ;
- exécution typique : lire la demande + matcher la table + produire 5 lignes de recommandation.

Coût total d'une session orchestrateur : **5–10% du budget de tokens** d'une tâche moyenne. Au-delà, il ne remplit plus sa fonction de filtre.

---

## 7. Délégation propre

Quand l'orchestrateur a recommandé un skill et que l'utilisateur valide :

1. L'orchestrateur **se retire**.
2. Claude charge le skill effectif (via le mécanisme de skill habituel).
3. L'orchestrateur n'intervient plus, sauf si l'utilisateur revient demander un autre routage.

Pas de chevauchement. Pas de re-validation. Délégation propre.

---

## 8. Cas où l'orchestrateur lui-même est inutile

L'orchestrateur **doit s'effacer** si :

- la demande matche un seul skill évident (ex: *"écris un article SEO"* → `seo-content-engine` direct, pas besoin de routage) ;
- l'utilisateur a déjà nommé le skill ;
- la tâche est triviale (typo, lecture).

Dans ces cas, l'orchestrateur produit une recommandation **encore plus courte** :

```
**Skill recommandé :** {{skill évident}}
**Raison :** demande directement alignée.
**Action proposée :** charger {{skill}}.
```

3 lignes suffisent.

---

## 9. Métriques de qualité de l'orchestrateur

Un bon routage respecte ces critères :

- [ ] **un seul skill primary** identifié ;
- [ ] **0 ou 1–2 secondaires** maximum ;
- [ ] **raison claire** en une phrase ;
- [ ] **confirmation demandée** si action lourde ;
- [ ] **format de sortie** strict (5 lignes) ;
- [ ] **pas de chargement** d'autres skills par l'orchestrateur lui-même ;
- [ ] **délégation propre** une fois validé.

Si un de ces critères est cassé, l'orchestrateur a échoué sa mission.

---

Created by João de Almeida
