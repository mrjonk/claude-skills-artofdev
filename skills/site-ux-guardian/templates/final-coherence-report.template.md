# Final coherence report — {{PROJECT_NAME}}

> Rapport final consolidé : score, problèmes, plan d'action.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Stack** : {{...}}
- **Mode** : {{audit-only / corrections sûres / plan de refonte}}
- **Auditeur** : Claude (skill `site-ux-guardian` v0.1.0)

---

## Score global

```txt
┌─────────────────────────────────────┐
│                                     │
│  Cohérence site : {{X / 100}}       │
│  Qualité visuelle : {{X / 100}}     │
│                                     │
│  Verdict : {{...}}                  │
│                                     │
└─────────────────────────────────────┘
```

---

## Score par axe

| Axe | Score | Note |
|---|---|---|
| Navigation | {{X / 15}} | {{...}} |
| Footer | {{X / 10}} | {{...}} |
| Routes / liens | {{X / 15}} | {{...}} |
| Doublons | {{X / 10}} | {{...}} |
| Front / admin | {{X / 10}} | {{...}} |
| Responsive | {{X / 10}} | {{...}} |
| Sécurité basique | {{X / 10}} | {{...}} |
| Discipline fichier | {{X / 10}} | {{...}} |
| Webdesign guidelines (visuel) | {{X / 10}} | {{...}} |
| **Cohérence site** | **{{X / 100}}** | |
| **Qualité visuelle** | **{{X / 100}}** | |

---

## Résumé exécutif

{{5 lignes maximum, lisible par un fondateur non technique.}}

Le site est **{{verdict en clair}}**.
Les **{{N_CRIT}}** problèmes critiques bloquent une utilisation propre.
Les **{{N_IMP}}** problèmes importants doivent être traités avant publication.
Les **{{N_MIN}}** mineurs peuvent attendre.

**Top 3 actions immédiates** :
1. {{action 1}}
2. {{action 2}}
3. {{action 3}}

---

## Problèmes critiques

### CRIT-001 — {{Titre court}}

- **Catégorie** : {{Navigation / Footer / Routes / Doublons / Front-admin / Responsive / Sécurité / Visuel}}
- **Fichier(s)** : `{{chemin}}` (ligne {{X}} si pertinent)
- **Impact** : {{1 phrase}}
- **Correction recommandée** : {{1 phrase}}
- **Mode 2 OK ?** : {{oui / non}}

### CRIT-002 — {{...}}

- ...

---

## Problèmes importants

### IMP-001 — {{...}}

- ...

---

## Problèmes mineurs

### MIN-001 — {{...}}

- ...

---

## Webdesign guidelines audit (synthèse)

(Cf. `webdesign-audit.template.md` pour le détail.)

| Axe | Statut |
|---|---|
| A. Hiérarchie visuelle | {{✓ / ⚠ / ✗}} |
| B. Lisibilité | {{...}} |
| C. Typographie | {{...}} |
| D. Spacing | {{...}} |
| E. Layout | {{...}} |
| F. Buttons / CTA | {{...}} |
| G. Cards | {{...}} |
| H. Formulaires | {{...}} |
| I. Tables / dashboards | {{...}} |
| J. Images | {{...}} |
| K. Responsive | {{...}} |
| L. Cohérence globale | {{...}} |
| M. Accessibilité visuelle | {{...}} |
| N. Anti-template / amateur | {{...}} |

---

## Corrections appliquées (Mode 2)

| ID | Fichier | Correction | Annulable par |
|---|---|---|---|
| CRIT-003 | `app/contact/page.tsx` | ajout du `<title>` manquant | `git revert` |
| MIN-007 | `app/page.tsx` | suppression de 3 `console.log` oubliés | `git revert` |

---

## Corrections recommandées (à faire par l'utilisateur)

| Priorité | ID | Action |
|---|---|---|
| 1 | CRIT-001 | {{...}} |
| 1 | CRIT-002 | {{...}} |
| 2 | IMP-001 | {{...}} |
| 3 | MIN-001 | {{...}} |

---

## Délégations recommandées

### `premium-webdesigner`

{{Si refonte créative requise :}}

> Le score visuel est de **{{X}} / 100**. La cause principale est {{description}}. Je recommande d'utiliser le skill **`premium-webdesigner`** pour produire une vraie direction artistique avant que `site-ux-guardian` ne reprenne l'audit ergonomique.

{{Sinon :}}

> Aucune délégation nécessaire. Les corrections proposées suffisent.

### `production-auditor`

{{Si audit production complet requis :}}

> Pour un audit production complet (sécurité profonde, billing, déploiement, dépendances), je recommande **`production-auditor`** après avoir traité les problèmes ergonomiques de ce rapport.

{{Sinon :}}

> Pas nécessaire à ce stade.

### `seo-content-engine`

{{Si contenu à améliorer :}}

> Si le contenu rédactionnel est aussi à améliorer (articles génériques, pages produits creuses), utiliser **`seo-content-engine`**.

---

## Plan d'action consolidé

| Phase | Description | Priorité | Statut |
|---|---|---|---|
| 1 | Corrections critiques | 1 | `pending` |
| 2 | Corrections navigation / menu / footer | 2 | `pending` |
| 3 | Corrections sécurité basique | 1–2 | `pending` |
| 4 | Corrections visuelles sûres | 2 | `pending` |
| 5 | Corrections visuelles à valider | 2–3 | `pending` |
| 6 | Délégation `premium-webdesigner` si applicable | — | `n/a` ou `pending` |
| 7 | Tests finaux | — | `pending` |

---

## Mode d'exécution choisi

- [ ] **Mode 1** — Audit only (rapport seul, aucune modification)
- [ ] **Mode 2** — Audit + corrections sûres (typos, alt, etc.)
- [ ] **Mode 3** — Plan de refonte (validation requise)

→ Mode actuel : **{{mode}}**.

---

## Fichiers modifiés (si Mode 2)

| Fichier | Modification | Git diff size |
|---|---|---|
| `{{path}}` | {{description}} | {{ex: +5 -2}} |

---

## Tests effectués

- [ ] navigation : tous les liens du menu fonctionnent ;
- [ ] mobile : menu burger fonctionnel sur 4 breakpoints ;
- [ ] admin : sidebar présente sur toutes les pages admin ;
- [ ] formulaires : envoi + validation OK ;
- [ ] pages 404 / 500 custom ;
- [ ] **4 breakpoints** (320 / 768 / 1024 / 1440) ;
- [ ] **focus visible** au clavier.

---

## Limites de cet audit

- audit **statique** (pas de runtime testing) ;
- pages **dynamiques** non vérifiées (lecture du code seulement) ;
- **performance** non mesurée (cf. `production-auditor` pour Lighthouse) ;
- **sécurité profonde** non auditée (cf. `production-auditor`).

---

## Prochaine étape

> {{Une seule phrase actionnable. Ex: "Corriger les 3 CRIT, traiter les corrections sûres en Mode 2, relancer un audit pour viser ≥ 76 sur les deux scores."}}

---

Created by João de Almeida
