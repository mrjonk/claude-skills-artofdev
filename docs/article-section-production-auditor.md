# Skill 2 — `production-auditor` : auditer un projet avant qu'il parte en production

*Section éditoriale prête à intégrer dans l'article publié sur jonk.space / Art of Dev.*

---

## Le piège des projets IA qui "marchent à moitié"

Quand on développe avec Claude Code, on arrive vite à un truc qui tourne.

La homepage charge. Le formulaire envoie. L'admin est là. Le checkout aussi.

Et puis on déploie. Et là, ça commence :

- le `<title>` est `Document` sur 12 pages — Google nous remerciera ;
- le `.env` est commit é, bravo ;
- l'admin est accessible à `/admin` sans aucune protection MFA ;
- le webhook Stripe n'est pas signé : un petit malin peut nous fabriquer des factures ;
- le formulaire de contact balance les emails dans le vide parce que le SMTP n'est pas configuré ;
- l'image hero pèse 8 Mo en PNG ;
- la page 500 montre une stack-trace PHP au public ;
- 17 `console.log` traînent dans le code prod.

Aucun de ces points n'est dramatique pris isolément. Cumulés, ils transforment un projet "qui marche" en projet **publiable seulement avec des excuses**.

Le problème n'est pas qu'on n'est pas vigilant. Le problème est qu'**il n'y a pas de checklist systématique** pour passer un projet "ça tourne en local" → "ça tient debout en prod".

## La solution : un audit structuré, pas un coup d'œil

`production-auditor` est un **Claude Skill** qui force une méthode d'audit en 10 phases.

Ce n'est pas Claude qui "regarde un peu le projet". C'est Claude qui :

1. lit le `README`, les manifests, les deps ;
2. cartographie l'arborescence et les routes ;
3. inspecte l'UX/UI (design template-look ? CTA cohérents ? responsive ? états vides ?) ;
4. inspecte le technique (build, logs oubliés, données hardcodées, gestion d'erreurs) ;
5. scanne la sécurité (secrets, auth, CSRF, XSS, SQLi, uploads) ;
6. inspecte le SEO et le contenu (titles, meta, H1, alt, contenu réel) ;
7. inspecte l'admin / billing / emails si applicables ;
8. **score** sur 7 axes pondérés ;
9. rédige un rapport structuré ;
10. applique uniquement les corrections **évidentes et sûres**.

Le tout en suivant des checklists qui sont **dans le repo**, versionnées, modifiables, partageables.

## Comment le skill classe les problèmes

Trois priorités :

- **`CRIT-NNN`** — bloquant. Empêche la mise en prod. Exemple : `.env` commit é, webhook Stripe non vérifié, page 500 qui expose la stack.
- **`IMP-NNN`** — important. À traiter avant lancement public. Exemple : pas de `<title>` unique par page, footer pauvre, états vides manquants.
- **`MIN-NNN`** — mineur. Peut attendre. Exemple : un `console.log` traîne, une image trop lourde, un alt manquant sur une icône décorative.

Chaque entrée vient avec : **fichier concerné**, **impact** en une phrase, **correction recommandée** en une phrase. Lisible par un fondateur non technique.

## Le score de production-readiness

Le skill produit un score sur **100** :

| Score | Statut |
|---|---|
| 0–20 | Non publiable |
| 21–40 | Très fragile |
| 41–60 | Prototype acceptable, pas production |
| 61–75 | Publiable avec corrections |
| 76–90 | Solide. Lancement possible. |
| 91–100 | Prêt production premium |

Avec un score par axe (Technique 20 / UX 15 / Sécurité 25 / SEO 10 / Admin 15 / Billing 10 / Déploiement 5).

L'idée : repérer instantanément l'axe qui tire le projet vers le bas.

Un projet à `82` global mais `45` en sécurité, ce n'est **pas** un projet `82`. C'est un projet bloqué par la sécurité.

## Pourquoi c'est utile pour Art of Dev et FocusForge

Mon workflow Art of Dev tourne autour de mini CMS sectoriels (restaurant, tatoueur, coiffeur, DJ…), de SaaS, et de projets filmables pour YouTube.

Sans audit structuré, je passais beaucoup de temps avant chaque livraison à **tout re-vérifier à la main**. Une heure par projet, à minimum, pour des trucs que je faisais plus ou moins toujours dans le désordre.

Avec `production-auditor` :

- **chaque projet** passe par la même checklist ;
- **chaque livraison** s'accompagne d'un rapport scoré, conservé dans `reports/` ;
- **les régressions** sont détectables (re-audit + comparaison) ;
- **les vidéos YouTube** activent un mode `VIDEO_PRESENTATION_MODE` qui vérifie en plus qu'aucun secret/chemin serveur n'apparaît à l'écran ;
- **FocusForge** (mon SaaS de productivité) bénéficie du même audit que les sites client : zéro favoritisme.

Industrialiser un audit ne veut pas dire faire moins. Ça veut dire faire **toujours** plus, sans y penser.

## Exemple de prompt

> *"Audite ce SaaS Next.js + Stripe avant le lancement public dans 2 semaines. Vérifie en priorité : auth, checkout Stripe (mode test → live, webhooks signés), cohérence pricing, permissions multi-utilisateurs, déploiement (HTTPS, headers de sécurité, backups DB). Donne-moi le rapport avec score et plan d'action. Applique uniquement les corrections sûres et évidentes. Ne push rien."*

## Exemple de rapport attendu (extrait)

```markdown
# Audit production — saas-tasks
- Date : 2026-05-10
- Type : SaaS Node/Next + Stripe
- Mode : audit + corrections sûres

## Score global : 67 / 100 — Publiable avec corrections

| Axe | Score |
|---|---|
| Technique | 78 / 100 |
| UX/UI | 72 / 100 |
| Sécurité | 54 / 100  ← axe le plus faible
| SEO/Contenu | 68 / 100 |
| Admin/Backoffice | 80 / 100 |
| Paiement/Billing | 60 / 100 |
| Déploiement | 55 / 100 |

## Résumé exécutif

Le projet est publiable avec corrections.
Les 3 problèmes critiques bloquent une mise en prod immédiate.
Les 8 problèmes importants doivent être traités avant lancement public.
Les 12 mineurs peuvent attendre.

Top 3 actions immédiates :
1. Vérifier la signature des webhooks Stripe (CRIT-001).
2. Activer 3D Secure / SCA sur le checkout (CRIT-002).
3. Retirer le DEBUG=true du .env.production (CRIT-003).

## Problèmes critiques

### CRIT-001 — Webhook Stripe non signé
- Catégorie : Sécurité
- Fichier : src/app/api/webhooks/stripe/route.ts:8
- Impact : Un attaquant peut forger des events de paiement.
- Correction : Vérifier la signature HMAC à chaque réception via stripe.webhooks.constructEvent().
- Statut : à corriger
```

Et ainsi de suite.

## La suite

`production-auditor` est le **deuxième** skill de la collection Art of Dev. Le premier, `repo-builder`, créait des repos propres. Celui-ci les **vérifie**.

À venir :

- `mini-cms-builder` — générer une base PHP/SQLite sectorielle ;
- `video-prep` — préparer un repo en mode screen-recording ;
- `zip-exporter` — empaqueter un projet en ZIP livrable client.

Chacun continue le même principe : **écrit une fois, appliqué mille fois**.

Le repo complet :

`github.com/mrjonk/claude-skills-artofdev`

---

Created by **João de Almeida** — Art of Dev
https://artofdev.space
