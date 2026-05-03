# Routing rules — `skill-orchestrator`

> Created by João de Almeida

Table complète de routage **intent utilisateur → skill recommandé**, avec exemples de phrases typiques et règles de priorité.

---

## 1. Principes fondamentaux

1. **Le plus spécifique gagne.** Si deux skills matchent, choisir celui dont le périmètre est le plus étroit et le plus aligné à la demande.
2. **Skill nommé par l'utilisateur = priorité absolue.** Si l'utilisateur dit *"utilise `production-auditor`"*, ne pas suggérer un autre skill.
3. **Pas de skill par défaut.** Si rien ne matche clairement, **demander une précision** — ne pas inventer.
4. **Pas de chargement préventif.** Un skill secondaire ne doit être proposé que si la demande l'implique explicitement.
5. **Workflow > parallélisme.** Si plusieurs skills sont nécessaires, les enchaîner séquentiellement, jamais en bloc.

---

## 2. Table complète de routage

### 2.1 `repo-builder`

**Quand l'activer :**

- création d'un nouveau projet ;
- scaffolding ;
- initialisation d'un repo ;
- structure de dossiers + README + CHANGELOG + ROADMAP.

**Phrases utilisateur typiques :**

- *"crée un nouveau repo pour…"* ;
- *"initialise un projet…"* ;
- *"scaffold un mini CMS…"* ;
- *"je veux démarrer un nouveau site…"* ;
- *"prépare la structure pour un plugin WordPress…"* ;
- *"démarre un repo Claude Skill…"*.

**Skills secondaires possibles :**

- `production-auditor` (en aval, pour valider la structure produite) — uniquement si demandé.

**Skip :**

- pas de mention de repo ou de création ;
- demande de modification d'un projet **existant**.

---

### 2.2 `production-auditor`

**Quand l'activer :**

- audit production complet ;
- vérification avant mise en ligne ;
- contrôle sécurité profond, billing, déploiement ;
- score 7-axes de production-readiness.

**Phrases utilisateur typiques :**

- *"audit production"* ;
- *"est-ce que c'est prêt à mettre en prod ?"* ;
- *"check la sécurité, le billing, le déploiement"* ;
- *"production-ready ?"* ;
- *"audit complet du projet"* ;
- *"score de qualité prod"*.

**Skills secondaires possibles :**

- `site-ux-guardian` (pour la partie ergonomique) ;
- `premium-webdesigner` (pour la partie design si l'audit le suggère).

**Skip :**

- tweak isolé (CSS, typo, mineur) ;
- audit purement ergonomique (préférer `site-ux-guardian`) ;
- audit purement contenu (préférer `seo-content-engine`).

---

### 2.3 `premium-webdesigner`

**Quand l'activer :**

- refonte créative ;
- direction artistique ;
- création de landing page haut de gamme ;
- inspiration moderne (composants, palette, typographie premium) ;
- redesign visuel.

**Phrases utilisateur typiques :**

- *"refonte design"* ;
- *"redesign de la home"* ;
- *"je veux un design premium"* ;
- *"inspire-toi de 21st.dev / shadcn"* ;
- *"crée une landing page moderne"* ;
- *"il faut une vraie direction artistique"*.

**Skills secondaires possibles :**

- `site-ux-guardian` (en aval, pour vérifier que la refonte reste cohérente avec le reste du site) ;
- `production-auditor` (uniquement si la refonte change l'architecture).

**Skip :**

- correction de texte ;
- petit fix CSS isolé ;
- ajout d'un élément trivial (un bouton, un padding).

---

### 2.4 `seo-content-engine`

**Quand l'activer :**

- rédaction d'articles SEO ;
- création de contenu utile non générique ;
- méthode éditoriale ;
- optimisation pour la recherche (titres, balises, structure éditoriale).

**Phrases utilisateur typiques :**

- *"écris un article sur…"* ;
- *"rédige du contenu SEO"* ;
- *"optimise ce texte pour Google"* ;
- *"crée une page de blog sur…"* ;
- *"améliore le contenu de la page d'accueil"*.

**Skills secondaires possibles :**

- `multilingual-site-engine` (si le contenu doit exister en plusieurs langues).

**Skip :**

- email simple ;
- message court ;
- demande de traduction pure.

---

### 2.5 `site-ux-guardian`

**Quand l'activer :**

- audit ergonomique transversal ;
- cohérence menu / footer / routes / liens ;
- vérification front/admin ;
- responsive, doublons, structure fichiers ;
- webdesign guidelines (typo, spacing, alignement).

**Phrases utilisateur typiques :**

- *"vérifie l'ergonomie"* ;
- *"audit UX"* ;
- *"vérifie les menus et footers"* ;
- *"check la cohérence du site"* ;
- *"vérifie le responsive"* ;
- *"vérifie qu'il n'y a pas de doublons"* ;
- *"vérifie que je modifie le bon fichier"*.

**Skills secondaires possibles :**

- `premium-webdesigner` (si l'audit révèle un besoin de refonte créative) ;
- `production-auditor` (si l'audit UX révèle des risques de prod).

**Skip :**

- refonte créative pure (préférer `premium-webdesigner`) ;
- création from scratch (préférer `repo-builder` + `premium-webdesigner`).

---

### 2.6 `multilingual-site-engine`

**Quand l'activer :**

- traduction d'un site ou d'une partie ;
- mise en place d'un système multilingue ;
- gestion de switch langue, routes traduites, fallback.

**Phrases utilisateur typiques :**

- *"traduis ce site en EN/DE/IT"* ;
- *"ajoute une version anglaise"* ;
- *"mets en place un système multilingue"* ;
- *"vérifie la cohérence des langues"* ;
- *"le switch langue ne marche pas"*.

**Skills secondaires possibles :**

- `seo-content-engine` (si la traduction implique de réécrire / optimiser du contenu) ;
- `site-ux-guardian` (pour vérifier que les routes traduites sont cohérentes).

**Skip :**

- une seule phrase à traduire ;
- traduction d'un email isolé.

---

### 2.7 `skill-orchestrator` (lui-même)

**Quand l'activer :**

- demande ambiguë multi-skills ;
- *"quel skill utiliser ?"* ;
- workflow multi-skills explicite.

**Skip :**

- demande déjà claire (un skill évident) ;
- skill nommé explicitement par l'utilisateur.

---

## 3. Règles de priorité

### 3.1 Le plus spécifique gagne

| Demande | Skill générique tentant | Skill plus spécifique (à choisir) |
|---|---|---|
| *"audit ergonomique"* | `production-auditor` | `site-ux-guardian` |
| *"audit complet"* | `site-ux-guardian` | `production-auditor` |
| *"refonte de la home"* | `site-ux-guardian` | `premium-webdesigner` |
| *"écris un article"* | `premium-webdesigner` | `seo-content-engine` |
| *"traduis le menu"* | `seo-content-engine` | `multilingual-site-engine` |
| *"crée le repo"* | `production-auditor` | `repo-builder` |

### 3.2 Skill explicit dans la demande gagne

Si l'utilisateur écrit *"utilise `seo-content-engine`"*, ne pas proposer autre chose. Confirmer le choix et passer la main.

### 3.3 Pas de skill par défaut

Si rien ne matche clairement, **demander une précision courte** :

> *"Veux-tu un audit UX (cohérence, menus, footers) ou un audit production (sécurité, déploiement) ?"*

---

## 4. Cas particuliers

### 4.1 Audit + redesign

Demande : *"audite et refonds la home"*.

- Workflow séquentiel :
  1. `site-ux-guardian` (audit ergonomique de l'existant) ;
  2. `premium-webdesigner` (refonte créative) ;
  3. `site-ux-guardian` (re-vérification cohérence post-refonte).
- Demander confirmation avant la phase 2 (refonte = action lourde).

### 4.2 Traduction + SEO

Demande : *"traduis cet article en anglais avec optimisation SEO"*.

- Workflow séquentiel :
  1. `multilingual-site-engine` (traduction structurelle) ;
  2. `seo-content-engine` (optimisation EN, balises, titres).
- Pas de chargement parallèle.

### 4.3 Création de repo + audit prod

Demande : *"crée le repo et vérifie qu'il est production-ready"*.

- Workflow séquentiel :
  1. `repo-builder` (scaffolding) ;
  2. `production-auditor` (audit du repo créé).
- Confirmation requise avant push GitHub.

### 4.4 Refonte design + cohérence multi-langues

Demande : *"refonds la home en gardant la cohérence FR/EN/DE"*.

- Workflow séquentiel :
  1. `premium-webdesigner` (refonte FR) ;
  2. `multilingual-site-engine` (propagation EN/DE) ;
  3. `site-ux-guardian` (cohérence finale).
- Demander confirmation avant chaque phase.

---

## 5. Anti-patterns à éviter

- **Charger 3+ skills d'un coup** sans demande explicite.
- **Choisir un skill générique** alors qu'un skill spécifique existe.
- **Inventer un workflow multi-skills** quand un seul skill suffit.
- **Ignorer un skill nommé** par l'utilisateur.
- **Suggérer un skill secondaire "au cas où"** — uniquement si la demande l'implique.

---

## 6. Format de la recommandation

Quand l'orchestrateur produit une recommandation, il utilise **toujours** ce bloc :

```
**Skill recommandé :** {{skill}}
**Raison :** {{1 phrase}}
**Skills secondaires possibles :** {{liste ou "aucun"}}
**Action proposée :** {{1 phrase actionnable}}
**Confirmation requise ?** {{oui/non + raison}}
```

Pas plus, pas moins. La concision est une fonctionnalité.

---

Created by João de Almeida
