# `production-auditor` — README du skill

> Mode d'emploi du skill **`production-auditor`**.
> Pour la définition formelle (règles, méthode, scoring, checklists), voir [`SKILL.md`](SKILL.md).

Created by **João de Almeida** — Art of Dev — https://artofdev.space

---

## À quoi sert ce skill

`production-auditor` audite un projet **avant** sa mise en production.

Il fait ce qu'un auditeur senior ferait :

- inspecte la structure du projet ;
- repère les problèmes visibles (UX, contenu, build) et invisibles (sécurité, fuites de secrets, dead-code) ;
- classe chaque problème (`critique` / `important` / `mineur`) ;
- score la production-readiness sur **7 axes** ;
- propose un plan de correction priorisé ;
- corrige uniquement ce qui est **sûr** et **réversible** ;
- rend un rapport structuré dans `reports/audit-YYYY-MM-DD.md`.

---

## Quand l'utiliser

Active-le (Claude le fait automatiquement) dès que tu demandes :

- *"audite ce projet"* ;
- *"vérifie si c'est prêt pour la prod"* ;
- *"trouve les bugs et incohérences"* ;
- *"vérifie l'UX / les routes / le footer / le responsive"* ;
- *"prépare la mise en ligne"* ;
- *"corrige ce qui bloque la production"* ;
- *"fais un audit avant vidéo YouTube"* ;
- *"audit sécurité / SEO / admin / billing"*.

---

## Comment l'appeler dans Claude Code

**Aucune syntaxe spéciale.** Le skill se charge automatiquement dès que ta demande matche sa `description:`.

Pour forcer la prise en compte (debug) :

> *"Utilise le skill `production-auditor` pour auditer ce projet."*

---

## Exemples de prompts

```txt
/production-auditor Audite ce projet avant mise en production.

/production-auditor Vérifie si ce mini CMS est prêt pour une vidéo YouTube.

/production-auditor Audite le site complet : UX, SEO, admin, sécurité, liens, responsive.

/production-auditor Fais un audit production-grade et corrige uniquement les problèmes sûrs.

/production-auditor Audit sécurité seul, sans corrections, juste le rapport.

/production-auditor Vérifie la cohérence pricing / checkout / webhooks Stripe.

/production-auditor Audit avant déploiement VPS — focus déploiement et permissions.
```

---

## Ce que le skill vérifie

7 catégories. Chacune a sa checklist détaillée dans `references/`.

| # | Catégorie | Référence |
|---|---|---|
| 1 | Technique | [`references/technical-checklist.md`](references/technical-checklist.md) |
| 2 | UX / UI | [`references/ux-ui-checklist.md`](references/ux-ui-checklist.md) |
| 3 | Sécurité | [`references/security-checklist.md`](references/security-checklist.md) |
| 4 | SEO / Contenu | [`references/seo-content-checklist.md`](references/seo-content-checklist.md) |
| 5 | Admin / Backoffice | [`references/admin-dashboard-checklist.md`](references/admin-dashboard-checklist.md) |
| 6 | Paiement / Facturation | [`references/payment-billing-checklist.md`](references/payment-billing-checklist.md) |
| 7 | Déploiement | [`references/deployment-readiness.md`](references/deployment-readiness.md) |

---

## Comment lire le rapport

Le rapport est généré dans `reports/audit-YYYY-MM-DD.md`. Structure :

1. **En-tête** — projet, date, type, stack
2. **Score** — global (0–100) + 7 axes + verdict
3. **Résumé exécutif** — 5 lignes max
4. **Problèmes critiques** — bloquent la prod
5. **Problèmes importants** — à faire avant lancement
6. **Problèmes mineurs** — peuvent attendre
7. **Corrections appliquées** — déjà faites par le skill
8. **Corrections recommandées** — à faire toi-même
9. **Plan d'action** — phases 1 à 6
10. **Prochaine étape** — 1 ligne actionnable

### Verdict global

| Score | Statut |
|---|---|
| 0–20 | Non publiable |
| 21–40 | Très fragile |
| 41–60 | Prototype acceptable, pas production |
| 61–75 | Publiable avec corrections |
| 76–90 | Solide |
| 91–100 | Prêt production premium |

---

## Ce que le skill ne fait jamais sans accord explicite

- pousser vers GitHub ;
- supprimer un fichier (même `.bak`/`.tmp`) ;
- modifier des credentials, mots de passe, tokens ;
- afficher le contenu d'un `.env` ou d'un secret ;
- faire un refactor d'architecture ;
- changer le pricing, les routes existantes, la stack ;
- lancer `npm install` / `composer install` / `pip install` ;
- modifier l'environnement de production sans backup vérifié.

---

## Audit sans corrections

Pour un rapport **lecture seule** :

> *"Fais un audit, mais ne corrige rien. Je veux juste le rapport."*

Pour un rapport **avec corrections sûres uniquement** :

> *"Audite et corrige les problèmes évidents et sûrs (typos, alt, console.log oubliés, .gitignore manquant)."*

Pour un audit **focus** sur une catégorie :

> *"Audit sécurité seulement."*
> *"Audit SEO et contenu uniquement."*
> *"Vérifie le billing : pricing, checkout, webhooks Stripe."*

---

## Comment l'améliorer plus tard

Le skill est un dossier — modifie-le directement :

1. ajuste `SKILL.md` (règles, méthode) ;
2. enrichis `references/` (nouvelles checklists par stack) ;
3. ajoute des templates dans `templates/` ;
4. ajoute des scripts d'analyse dans `scripts/` ;
5. relance `bash install.sh` à la racine du repo pour redéployer.

L'ancienne version est sauvegardée automatiquement dans `~/.claude/skills/.backup/production-auditor-YYYYMMDD-HHMMSS/`.

---

## Structure du skill

```txt
skills/production-auditor/
├── SKILL.md
├── README.md
├── references/
│   ├── audit-methodology.md
│   ├── technical-checklist.md
│   ├── ux-ui-checklist.md
│   ├── seo-content-checklist.md
│   ├── security-checklist.md
│   ├── admin-dashboard-checklist.md
│   ├── payment-billing-checklist.md
│   ├── deployment-readiness.md
│   └── report-format.md
├── templates/
│   ├── audit-report.template.md
│   ├── bug-list.template.md
│   ├── correction-plan.template.md
│   ├── production-readiness-score.template.md
│   └── release-checklist.template.md
└── scripts/
    ├── scan-common-issues.sh
    ├── scan-secrets.sh
    ├── scan-dead-links.sh
    └── generate-audit-report.sh
```

---

Created by **João de Almeida** — Art of Dev
https://artofdev.space
