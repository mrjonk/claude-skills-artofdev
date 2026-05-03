# Production-Readiness Score — {{PROJECT_NAME}}

- **Date** : {{YYYY-MM-DD}}
- **Auditeur** : Claude (skill `production-auditor` v0.1.0)

> Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Score global

```txt
┌─────────────────────────────────────────┐
│                                         │
│         {{GLOBAL_SCORE}} / 100          │
│                                         │
│         {{VERDICT}}                     │
│                                         │
└─────────────────────────────────────────┘
```

---

## Détail par axe

### Technique — {{TECH}} / 100 (poids 20)

- Build clean : {{ok / ko}}
- Dépendances à jour : {{ok / ko}}
- Pas de logs oubliés : {{ok / ko}}
- Config externalisée : {{ok / ko}}
- Routes / API testables : {{ok / ko}}

### UX/UI — {{UX}} / 100 (poids 15)

- Navigation cohérente : {{ok / ko}}
- Hiérarchie visuelle : {{ok / ko}}
- Design non template-look : {{ok / ko}}
- Responsive : {{ok / ko}}
- États vides + feedback : {{ok / ko}}

### Sécurité — {{SEC}} / 100 (poids 25)

- Secrets non commit és : {{ok / ko}}
- Auth + hash mot de passe : {{ok / ko}}
- Permissions admin : {{ok / ko}}
- CSRF + XSS + SQLi : {{ok / ko}}
- Uploads sécurisés : {{ok / ko}}

### SEO/Contenu — {{SEO}} / 100 (poids 10)

- Titles + meta descriptions : {{ok / ko}}
- H1/H2 cohérents : {{ok / ko}}
- Contenu réel (zéro lorem) : {{ok / ko}}
- Sitemap + robots.txt : {{ok / ko}}
- Pages légales : {{ok / ko}}

### Admin/Backoffice — {{ADMIN}} / 100 (poids 15)

- Protection admin : {{ok / ko}}
- CRUD complet : {{ok / ko}}
- Filtres + recherche + pagination : {{ok / ko}}
- États vides + confirmations : {{ok / ko}}
- Statistiques utiles : {{ok / ko}}

### Paiement/Billing — {{BILL}} / 100 (poids 10)

> Si N/A, redistribuer : Tech +5, Sec +5.

- Cohérence pricing : {{ok / ko / N/A}}
- Webhooks vérifiés : {{ok / ko / N/A}}
- Factures + emails transactionnels : {{ok / ko / N/A}}
- Annulation + renouvellement : {{ok / ko / N/A}}
- Admin billing : {{ok / ko / N/A}}

### Déploiement — {{DEPLOY}} / 100 (poids 5)

- HTTPS + HSTS : {{ok / ko}}
- Backups + rollback : {{ok / ko}}
- Permissions fichiers : {{ok / ko}}
- Monitoring minimal : {{ok / ko}}
- Doc déploiement à jour : {{ok / ko}}

---

## Verdict final

| Score | Statut |
|---|---|
| **0–20** | Non publiable |
| **21–40** | Très fragile |
| **41–60** | Prototype acceptable, pas production |
| **61–75** | Publiable avec corrections |
| **76–90** | Solide. Lancement possible. |
| **91–100** | Prêt production premium |

→ **{{PROJECT_NAME}}** : **{{GLOBAL_SCORE}} / 100** — **{{VERDICT}}**

---

## Comparaison entre audits (si re-run)

| Date | Global | Tech | UX | Sec | SEO | Admin | Bill | Deploy |
|---|---|---|---|---|---|---|---|---|
| {{DATE_1}} | {{X}} | {{X}} | {{X}} | {{X}} | {{X}} | {{X}} | {{X}} | {{X}} |
| {{DATE_2}} | {{X}} | {{X}} | {{X}} | {{X}} | {{X}} | {{X}} | {{X}} | {{X}} |

---

Created by João de Almeida — Art of Dev — https://artofdev.space
