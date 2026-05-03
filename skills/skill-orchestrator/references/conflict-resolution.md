# Conflict resolution — `skill-orchestrator`

> Created by João de Almeida

Comment arbitrer quand **plusieurs skills semblent applicables** à une même demande, et quand demander une **confirmation explicite** avant de lancer un workflow lourd.

---

## 1. Règle d'or

> **Le skill le plus spécifique au domaine de la demande gagne.**

Si deux skills matchent, choisir celui dont le périmètre est le plus étroit et le plus aligné. Si trois skills matchent, c'est probablement que la demande mérite **un workflow séquentiel** — pas un chargement parallèle.

---

## 2. Cas concrets d'arbitrage

### 2.1 *"Audit ergonomique"*

**Skills tentants :** `site-ux-guardian`, `production-auditor`.

**Décision :** `site-ux-guardian`.

**Raison :** "ergonomique" est un marqueur **UX spécifique**. `production-auditor` couvre un périmètre plus large (sécurité, billing, déploiement) qui n'est pas demandé.

**Anti-pattern :** charger les deux "au cas où". Coût en tokens × 2, valeur ajoutée nulle.

---

### 2.2 *"Refonte design + vérifier la cohérence"*

**Skills tentants :** `premium-webdesigner`, `site-ux-guardian`.

**Décision :** workflow séquentiel.

1. `premium-webdesigner` — refonte créative.
2. `site-ux-guardian` — vérification cohérence post-refonte.

**Raison :** ce sont deux phases différentes. La refonte produit du nouveau design ; la vérification valide que le reste du site reste cohérent. Pas de doublon.

**Confirmation requise :** oui, avant la phase 1 (refonte = action lourde).

---

### 2.3 *"Traduis ce blog en anglais"*

**Skills tentants :** `multilingual-site-engine`, `seo-content-engine`.

**Décision :** `multilingual-site-engine` en primary.

**Raison :** la **structure** multilingue est plus critique que la qualité SEO d'une langue donnée. Si l'utilisateur précise *"avec optimisation SEO EN"*, ajouter `seo-content-engine` en secondary séquentiel.

---

### 2.4 *"Crée un repo Claude Skill"*

**Skills tentants :** `repo-builder`, peut-être un skill plus spécifique.

**Décision :** `repo-builder` direct, type `claude-skill`.

**Raison :** `repo-builder` gère explicitement le type `claude-skill`. Pas d'orchestration nécessaire.

**Cas où l'orchestrateur peut s'effacer :** demande déjà claire, un seul skill évident.

---

### 2.5 *"Audit complet du site"*

**Skills tentants :** `site-ux-guardian`, `production-auditor`, `seo-content-engine`.

**Décision :** **demander une précision** avant de choisir.

**Question type :**

> *"Tu veux un audit UX (cohérence, menus, footers, responsive), un audit production (sécurité, déploiement, billing), un audit SEO (contenu, balises, structure éditoriale), ou les trois en séquentiel ?"*

**Anti-pattern :** lancer les trois automatiquement. Explosion des tokens, rapport noyé.

---

### 2.6 *"Améliore mon site"*

**Skills tentants :** tous.

**Décision :** **demander une précision**.

**Question type :**

> *"Tu veux : (a) refondre le design, (b) vérifier la cohérence ergonomique, (c) optimiser le contenu SEO, (d) vérifier la production-readiness, (e) traduire en plusieurs langues ? Ou plusieurs en séquentiel ?"*

**Raison :** "améliore" est trop vague. Sans précision, l'orchestrateur n'a aucune base pour choisir.

---

### 2.7 *"Vérifie que c'est prêt à publier"*

**Skills tentants :** `production-auditor`, `site-ux-guardian`.

**Décision :** workflow séquentiel court.

1. `site-ux-guardian` (cohérence rapide) ;
2. `production-auditor` (sécurité + déploiement).

**Confirmation requise :** oui, avant phase 2 si l'audit prod est complet.

---

### 2.8 *"Corrige cette typo"*

**Skills tentants :** aucun.

**Décision :** **aucun skill nécessaire**, action directe.

**Raison :** action atomique, pas de méthode complexe à mobiliser. Charger un skill pour une typo = gaspillage.

---

## 3. Quand demander confirmation

L'orchestrateur **doit demander confirmation** avant de mobiliser un workflow dans ces cas :

1. **Audit large** (tout le site, plusieurs axes) → confirmation, sinon trop coûteux.
2. **Refonte** (design ou structure) → confirmation, action lourde.
3. **Traduction multi-langues** → confirmation, scope large.
4. **Création de repo** → confirmation, jamais en automatique.
5. **Workflow ≥ 3 skills** → confirmation, sinon explosion tokens.
6. **Action destructive potentielle** (suppression, refonte écrasante) → confirmation absolue.

Format de la confirmation :

```
**Plan proposé :**
1. {{skill 1}} — {{action courte}}
2. {{skill 2}} — {{action courte}}

**Coût estimé :** {{léger / modéré / lourd}}
**Confirmation requise :** OK pour lancer la phase 1 ?
```

---

## 4. Anti-patterns à signaler

### 4.1 Chaîner 4 skills "au cas où"

**Anti-pattern :**

> *"Lance `repo-builder`, puis `production-auditor`, puis `site-ux-guardian`, puis `premium-webdesigner`."*

Sans demande explicite, c'est **non**. L'orchestrateur ne fait pas ça.

### 4.2 Sur-spécification

**Anti-pattern :**

> *"L'utilisateur a dit 'crée un repo' → je propose `repo-builder` + `production-auditor` + `site-ux-guardian`."*

Non. La demande est *"crée un repo"*. `repo-builder` suffit. Les autres skills sont **éventuels** post-création, pas immédiats.

### 4.3 Sous-spécification

**Anti-pattern :**

> *"L'utilisateur a dit 'améliore mon site' → je lance `site-ux-guardian` direct."*

Non. La demande est trop vague. **Demander une précision**.

### 4.4 Ignorer un skill nommé

**Anti-pattern :**

> *"L'utilisateur a dit 'utilise `production-auditor`' → je propose `site-ux-guardian` à la place car ça me semble plus adapté."*

Non. Si l'utilisateur a nommé un skill, **respecter son choix**. Tu peux mentionner brièvement qu'un autre skill pourrait être pertinent, mais ne pas substituer.

### 4.5 Recommandation sans raison

**Anti-pattern :**

> *"Skill recommandé : `seo-content-engine`."* (sans expliquer pourquoi)

Non. Toujours **une phrase de raison**, sinon l'utilisateur ne peut pas valider.

---

## 5. Arbitrage en cas de doute persistant

Si après analyse, l'orchestrateur hésite encore :

1. **Lister les 2 skills candidats** explicitement.
2. **Expliquer la différence** en une phrase chacun.
3. **Demander à l'utilisateur** de trancher.

Format :

```
Deux skills pourraient convenir :
- {{skill A}} : {{phrase}}
- {{skill B}} : {{phrase}}

Lequel veux-tu ?
```

---

## 6. Limites de l'orchestrateur

L'orchestrateur **ne fait pas** :

- l'exécution du skill choisi (il route, c'est tout) ;
- la modification de fichiers ;
- la création de repos ;
- les audits ;
- les refontes.

Son rôle s'arrête à la **recommandation argumentée**. L'utilisateur (ou Claude) charge ensuite le skill effectif.

---

Created by João de Almeida
