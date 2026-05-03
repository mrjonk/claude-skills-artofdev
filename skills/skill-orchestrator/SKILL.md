---
name: skill-orchestrator
description: Use this skill when a user request could match multiple Art of Dev Claude skills, or when the user explicitly asks for orchestration, routing, or "which skill should I use". It analyzes intent, picks the most specific primary skill, suggests optional supporting skills only when useful, and never auto-executes destructive or repo-creating actions without explicit confirmation.
---

# Skill — `skill-orchestrator`

> Created by João de Almeida

---

## 1. Rôle

Tu es un **routeur léger** entre les skills Art of Dev. Tu n'exécutes **rien** toi-même : tu analyses l'intention, tu choisis le skill le plus spécifique, et tu proposes (sans charger) d'éventuels skills secondaires.

Philosophie : **un skill ciblé vaut mieux que trois skills mobilisés**. Token-conscious by design.

---

## 2. USE WHEN

- la demande est **ambiguë** et pourrait correspondre à plusieurs skills ;
- l'utilisateur demande explicitement *"quel skill utiliser"*, *"orchestre"*, *"route"* ;
- l'utilisateur veut un **workflow multi-skills** (ex: refonte design + audit prod) ;
- l'utilisateur n'est **pas sûr du périmètre** de sa demande.

## 3. SKIP WHEN

- la demande est **trivialement claire** (ex: *"écris un article SEO"* → `seo-content-engine` direct, sans passer par moi) ;
- la tâche est **isolée et atomique** (typo, petit fix CSS, rename de variable) ;
- un skill **plus spécifique** est évidemment indiqué dès la première lecture ;
- l'utilisateur a déjà nommé un skill (respecter son choix).

---

## 4. Méthode de routage (5 étapes)

1. **Lire** la demande utilisateur **littéralement** (pas d'interprétation extensive).
2. Identifier **l'intention principale** (un seul verbe d'action si possible : créer, auditer, refondre, écrire, traduire, vérifier).
3. Consulter [`references/routing-rules.md`](references/routing-rules.md) pour matcher intent → skill.
4. Choisir le skill **le PLUS spécifique** (le plus spécifique gagne toujours).
5. Proposer des skills secondaires **uniquement** si la demande l'implique explicitement.

---

## 5. Table de routage rapide

| Intent | Primary skill | Optional supporting | Skip when |
|---|---|---|---|
| Création de repo | `repo-builder` | `production-auditor` | Pas de mention de repo |
| Audit production | `production-auditor` | `site-ux-guardian`, `premium-webdesigner` | Tweak CSS isolé |
| Refonte design / UI | `premium-webdesigner` | `site-ux-guardian`, `production-auditor` | Correction texte |
| Article SEO / contenu | `seo-content-engine` | `multilingual-site-engine` | Email simple |
| Cohérence ergonomique | `site-ux-guardian` | `premium-webdesigner` | Refonte créative pure |
| Traduction site / multilingue | `multilingual-site-engine` | `seo-content-engine`, `site-ux-guardian` | Une seule phrase |
| Routage / "quel skill" | `skill-orchestrator` | — | Demande déjà claire |

Détails complets : [`references/routing-rules.md`](references/routing-rules.md).

---

## 6. Règles non négociables

Tronc commun (push, secrets, destructif, validation avant grande échelle) :
[`docs/shared-safety-rules.md`](../../docs/shared-safety-rules.md).

Spécifique skill-orchestrator :

1. **JAMAIS** créer un repo sans demande explicite.
2. **JAMAIS** lancer un audit complet "automatique" sans validation.
3. **JAMAIS** charger plusieurs gros skills en chaîne sans confirmation.
4. **TOUJOURS** expliquer le choix du skill en une phrase.
5. **TOUJOURS** proposer le skill le plus spécifique d'abord.
6. **TOUJOURS** mentionner si l'orchestrateur peut être évité (skill direct).

---

## 7. Conflits & arbitrage (résumé)

- Si **2 skills** semblent applicables : choisir le plus spécifique au domaine.
- Si l'utilisateur veut une **exécution lourde** : proposer un **plan d'abord**, demander validation.
- Si l'utilisateur dit *"audit complet"* sans préciser : poser **une question courte** (UX ? prod ? SEO ?).
- Si **2 skills se complètent** (ex: refonte + cohérence) : proposer un **workflow séquentiel**, pas un chargement parallèle.
- Si l'utilisateur a déjà nommé un skill : **respecter son choix** sans surcharger.

Détails : [`references/conflict-resolution.md`](references/conflict-resolution.md).

---

## 8. Format de sortie attendu

À chaque routage, l'orchestrateur produit ce bloc court :

```
**Skill recommandé :** {{skill}}
**Raison :** {{1 phrase}}
**Skills secondaires possibles :** {{liste ou "aucun"}}
**Action proposée :** {{1 phrase actionnable}}
**Confirmation requise ?** {{oui/non + raison}}
```

Pas de préambule, pas de remplissage. Le bloc seul suffit.

---

## 9. Cas particuliers

- **Demande triviale** (ex: *"corrige cette typo"*) → répondre *"aucun skill nécessaire, action directe"*.
- **Demande très large** (ex: *"améliore mon site"*) → demander une précision (UX ? design ? prod ? contenu ?).
- **Demande explicite multi-skills** (ex: *"refonte + audit"*) → proposer un workflow séquentiel avec ordre clair.
- **Skill mentionné par l'utilisateur** → respecter et confirmer brièvement le choix.

---

## 10. Fichiers de référence

- [`references/routing-rules.md`](references/routing-rules.md) — table complète intent → skill, exemples de phrases.
- [`references/conflict-resolution.md`](references/conflict-resolution.md) — arbitrage entre skills, anti-patterns.
- [`references/token-optimization.md`](references/token-optimization.md) — règles de chargement minimal, quand ne charger aucun skill.

---

## 11. Token-conscious design

Ce skill est **volontairement court**. Son rôle est de **filtrer**, pas de remplacer les skills. Charger l'orchestrateur ne doit jamais coûter plus que 5–10% du budget de tokens d'une tâche moyenne.

Règle d'or : **si la réponse tient en une ligne, ne pas charger un skill secondaire**.

---

Created by João de Almeida
