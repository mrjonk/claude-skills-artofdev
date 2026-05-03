# Audit production — {{PROJECT_NAME}}

- **Date** : {{YYYY-MM-DD}}
- **Type** : {{site-vitrine | saas | mini-cms | wordpress | dashboard | …}}
- **Stack** : {{PHP 8.2 + SQLite | Node 20 + Next.js | …}}
- **Auditeur** : Claude (skill `production-auditor` v0.1.0)
- **Mode** : {{audit-only | audit + corrections sûres | video-presentation}}

> Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Score global : {{GLOBAL_SCORE}} / 100 — {{VERDICT}}

| Axe | Score | Poids |
|---|---|---|
| Technique | {{TECH}} / 100 | 20 |
| UX/UI | {{UX}} / 100 | 15 |
| Sécurité | {{SEC}} / 100 | 25 |
| SEO/Contenu | {{SEO}} / 100 | 10 |
| Admin/Backoffice | {{ADMIN}} / 100 | 15 |
| Paiement/Billing | {{BILL}} / 100 | 10 |
| Déploiement | {{DEPLOY}} / 100 | 5 |

> Si le projet n'a pas de billing : retirer la ligne et redistribuer (Tech +5, Sec +5).

### Verdict

{{VERDICT_DETAIL}}

---

## Résumé exécutif

Le projet est **{{VERDICT_PHRASE}}**.
Les **{{N_CRIT}}** problèmes critiques bloquent une mise en prod immédiate.
Les **{{N_IMP}}** problèmes importants doivent être traités avant lancement public.
Les **{{N_MIN}}** mineurs peuvent attendre.

**Top 3 actions immédiates** :
1. {{ACTION_1}}
2. {{ACTION_2}}
3. {{ACTION_3}}

---

## Problèmes critiques (bloquent la prod)

### CRIT-001 — {{TITLE}}

- **Catégorie** : {{Technique | UX/UI | Sécurité | SEO | Admin | Billing | Déploiement}}
- **Fichier(s)** : `{{FILE}}` (ligne {{LINE}})
- **Impact** : {{IMPACT_PHRASE}}
- **Correction recommandée** : {{FIX_PHRASE}}
- **Statut** : `à corriger` | `corrigé` | `recommandé`

### CRIT-002 — {{TITLE}}

- ...

---

## Problèmes importants

### IMP-001 — {{TITLE}}

- **Catégorie** : {{...}}
- **Fichier(s)** : `{{FILE}}`
- **Impact** : {{...}}
- **Correction recommandée** : {{...}}
- **Statut** : `à corriger`

---

## Problèmes mineurs

### MIN-001 — {{TITLE}}

- **Catégorie** : {{...}}
- **Fichier(s)** : `{{FILE}}`
- **Impact** : {{...}}
- **Correction recommandée** : {{...}}
- **Statut** : `à corriger`

---

## Corrections appliquées par le skill

| ID | Fichier | Correction | Annulable par |
|---|---|---|---|
| {{ID}} | `{{FILE}}` | {{DESCRIPTION}} | `git revert {{COMMIT}}` |

---

## Corrections recommandées (à faire par l'utilisateur)

| Priorité | ID | Action |
|---|---|---|
| 1 | CRIT-001 | {{ACTION}} |
| 2 | CRIT-002 | {{ACTION}} |
| 3 | IMP-001 | {{ACTION}} |

---

## Plan d'action

(Cf. [`correction-plan.template.md`](correction-plan.template.md))

- **Phase 1** — Bloquants : {{...}}
- **Phase 2** — UX / Navigation : {{...}}
- **Phase 3** — Sécurité : {{...}}
- **Phase 4** — SEO / Contenu : {{...}}
- **Phase 5** — Finition premium : {{...}}
- **Phase 6** — Tests finaux : {{...}}

---

## Fichiers inspectés

- `{{FILE_1}}`
- `{{FILE_2}}`
- ...

---

## Fichiers modifiés (corrections appliquées)

- `{{FILE_A}}`
- `{{FILE_B}}`

---

## Prochaine étape

> {{ONE_LINE_NEXT_STEP}}

---

Created by João de Almeida — Art of Dev — https://artofdev.space
