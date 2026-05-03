# Validation — skill-orchestrator

> Date : 2026-05-03
> Type : validation **statique** (revue spec + 15 cas de routage attendus)
> Runtime non observé dans cette session
> Created by João de Almeida

---

## Note d'honnêteté

Cette validation est **statique**. Elle compare la spec du skill (`SKILL.md` + `references/`) à 15 cas de routage réalistes (`examples/skill-orchestrator-routing-test-cases.md`) et vérifie que la table de routage `docs/skill-routing-map.md` couvre ces cas correctement.

**Ce qui n'a pas été fait** : ouvrir une session Claude live, installer le skill, soumettre les 15 prompts, et observer la réponse réelle de Claude. Cette validation runtime est l'étape qui distingue `v1.0.0-rc1` de `v1.0.0`. Elle reste à faire par un humain.

---

## Spec relue

Lectures effectives :
- `skills/skill-orchestrator/SKILL.md` (128 lignes — court, dense, orchestrable)
- `skills/skill-orchestrator/README.md`
- `skills/skill-orchestrator/references/routing-rules.md`
- `skills/skill-orchestrator/references/conflict-resolution.md`
- `skills/skill-orchestrator/references/token-optimization.md`
- `docs/skill-routing-map.md`

---

## Couverture des 15 cas

| Cas | Skill attendu | Couvert par la table ? | Anomalie spec ? |
|---:|---|:---:|---|
| 1 | `repo-builder` | ✓ | non |
| 2 | `production-auditor` | ✓ | non |
| 3 | `premium-webdesigner` | ✓ | non |
| 4 | `multilingual-site-engine` | ✓ | non |
| 5 | `seo-content-engine` | ✓ | non |
| 6 | `site-ux-guardian` | ✓ | non |
| 7 | **AUCUN** | ✓ (section "Quand ne charger AUCUN skill") | non |
| 8 | `production-auditor` | ✓ | non |
| 9 | `premium-webdesigner` (scope borné) | ✓ partiel — la règle "propager le scope comme garde-fou" mériterait d'être explicitée |
| 10 | `multilingual-site-engine` | ✓ | non |
| 11 | `skill-orchestrator` (récursif) | ⚠ — le skill ne dit pas explicitement qu'il peut se recommander lui-même pour les méta-questions |
| 12 | enchaînement 4 skills | ✓ — workflow "refonte complète" mentionné dans `skill-routing-map.md` |
| 13 | `repo-builder` sans push | ✓ — règle "pas de push sans accord" déjà dans le skill |
| 14 | `site-ux-guardian` + confirmation destructive | ✓ — règle "action destructive = confirmation" dans `conflict-resolution.md` |
| 15 | `seo-content-engine` puis `multilingual-site-engine` | ✓ | non |

**Score statique : 13/15 ✓ + 2/15 partiels.**

---

## Trous spec identifiés

### Trou 1 — Méta-routage récursif (cas 11)

Quand l'utilisateur demande *"Quel skill dois-je utiliser ?"*, l'orchestrateur doit reconnaître que la demande EST un cas de routage, charger les autres skills uniquement après identification, et répondre avec le skill recommandé. Le SKILL.md ne dit pas explicitement comment gérer ce cas auto-référentiel.

**Action recommandée** : ajouter une ligne dans `references/routing-rules.md` : *"Si la demande est elle-même une question de routage (ex: 'quel skill ?', 'lequel choisir ?'), répondre directement avec une recommandation, sans charger d'autre skill avant validation."*

### Trou 2 — Propagation des contraintes utilisateur (cas 9, 13)

Quand l'utilisateur dit *"refais X mais ne touche pas à Y"* ou *"crée mais ne push pas"*, ces contraintes doivent être **propagées comme garde-fous explicites** au skill mobilisé. Le SKILL.md actuel ne formalise pas cette propagation.

**Action recommandée** : ajouter dans `SKILL.md` une étape "5 bis — propager les contraintes utilisateur explicites au skill choisi" dans la méthode de routage.

### Trou 3 — Workflow multi-skills : transitions (cas 12)

Pour `"refonte complète + traduction + audit final"`, l'orchestrateur doit demander confirmation **entre chaque skill**, pas juste avant le premier. Cette règle est implicite dans `conflict-resolution.md` mais gagnerait à être explicite dans le SKILL.md principal.

---

## Cohérence avec `docs/skill-routing-map.md`

Vérifications :
- ✓ Les 7 skills apparaissent dans la table principale.
- ✓ Section "Workflows multi-skills recommandés" couvre 2 cas (refonte complète, nouveau projet).
- ✓ Section "Anti-patterns" liste les pièges typiques (4 patterns).
- ✓ Section "Quand ne charger AUCUN skill" couvre le cas 7.
- ⚠ Manque un workflow explicite "audit YouTube / video presentation" pour le mode `VIDEO_PRESENTATION_MODE` de `production-auditor` — à ajouter ou à confirmer comme intentionnellement absent.

---

## Risques token observés

| Cas | Risque token estimé | Contrôle de l'orchestrateur ? |
|---|---|---|
| 7 (typo) | **0** si orchestrateur respecte "aucun skill" | critique |
| 12 (workflow 4 skills) | très élevé — 4 SKILL.md + leurs références | critique |
| 11 (méta-routage) | faible — orchestrateur seul (128 lignes) | bon |
| autres | proportionnel au skill mobilisé | acceptable |

**Le scénario à risque #1 est le cas 12.** L'orchestrateur doit obligatoirement présenter le plan AVANT d'exécuter, et demander confirmation entre chaque transition. Sinon il charge ~3000 lignes de SKILL.md d'un coup.

**Le scénario à risque #2 est le cas 7.** Si l'orchestrateur charge un skill par "sécurité" pour une typo, c'est l'anti-pattern fondamental. La règle "aucun skill = option valide" doit rester très visible dans le SKILL.md.

---

## Format de sortie attendu — vérification

D'après le SKILL.md, le format de sortie est :

```
**Skill recommandé :** {{skill}}
**Raison :** {{1 phrase}}
**Skills secondaires possibles :** {{liste ou "aucun"}}
**Action proposée :** {{1 phrase actionnable}}
**Confirmation requise ?** {{oui/non + raison}}
```

Ce format suffit pour les 15 cas. ✓

Pour le cas 12 (multi-skills), le format devrait probablement être étendu en :

```
**Workflow recommandé :**
  1. {{skill A}} — {{but}}
  2. {{skill B}} — {{but}}
  3. ...
**Confirmation requise entre chaque étape :** oui
```

À ajouter en variante dans le SKILL.md.

---

## Verdict statique

| Critère | Statut |
|---|:---:|
| Couverture des 15 cas | ✓ 13/15 + 2 partiels |
| Trous spec identifiés | 3 (mineurs) |
| Cohérence avec routing-map | ✓ avec 1 lacune mineure (workflow vidéo) |
| Risques token couverts | ✓ |
| Format de sortie clair | ✓ + variante multi-skills à ajouter |

**Verdict global** : `skill-orchestrator` tient la route en statique. **3 ajustements mineurs** identifiés. **Runtime obligatoire** avant promotion en stable.

---

## Actions recommandées (n'ont PAS été appliquées dans cette passe)

1. Ajouter dans `skills/skill-orchestrator/references/routing-rules.md` la règle "méta-routage = répondre directement, ne pas charger d'autre skill".
2. Ajouter dans `skills/skill-orchestrator/SKILL.md` une étape "propager les contraintes utilisateur (scope, no-push, no-delete) au skill choisi".
3. Ajouter dans le format de sortie une variante multi-skills (workflow numéroté + confirmation entre chaque étape).
4. Ajouter dans `docs/skill-routing-map.md` un mini-workflow `VIDEO_PRESENTATION_MODE`.

Ces fixes sont laissés à une passe ultérieure (RC2 ou v1.0 final) car ils nécessitent que l'utilisateur confirme l'intention avant modification.

---

## Reste à valider en runtime

1. Soumettre les 15 prompts dans une session Claude live.
2. Mesurer la latence et le nombre de tokens consommés par cas.
3. Vérifier que les confirmations demandées sont bien présentes pour les cas 3, 9, 10, 12, 14.
4. Vérifier le comportement "aucun skill" pour le cas 7.

---

Created by João de Almeida
