# Exemple — Audit d'un SaaS

## Contexte

App SaaS Node 20 + Next.js 14 + Prisma + PostgreSQL + Stripe.
3 plans (Free / Pro / Team).
Lancement public prévu dans 2 semaines.
Le repo a été développé en 6 semaines avec Claude Code.

## Prompt utilisateur

> *"Audit production-grade de cette app SaaS. Stack : Next.js 14 + Prisma + PostgreSQL + Stripe. Lancement dans 2 semaines. Vérifie en priorité auth, checkout Stripe, cohérence pricing, permissions multi-utilisateurs, déploiement. Donne le rapport avec score et plan. Applique uniquement les corrections sûres."*

## Ce que le skill doit analyser

### Phase 1–2 (lecture + cartographie)

- `package.json` + `package-lock.json`
- `prisma/schema.prisma`
- `.env.example`
- routes Next.js dans `src/app/`
- `next.config.js`
- `docker-compose.yml` si présent

### Phase 3 (UX/UI)

- homepage + page de pricing : cohérence visuelle, CTA, hero ;
- flow checkout : étapes claires, retour utilisateur, gestion d'échec ;
- dashboard utilisateur : navigation, états vides, feedback ;
- mobile : responsive 320 / 768 / 1024.

### Phase 4 (technique)

- build (`next build`) clean ;
- pas de `console.log` oublié dans le code app/api ;
- gestion d'erreurs (try/catch sur les calls Stripe et DB) ;
- gestion des routes 404 et 500 (pages custom) ;
- pas de données hardcodées (URL prod, email admin, IP).

### Phase 5 (sécurité)

- aucun `.env` commit é ;
- NextAuth correctement configuré (sessions sécurisées, CSRF) ;
- mots de passe hashés (bcrypt/argon2 via NextAuth) ;
- `/admin` (si présent) protégé ;
- requêtes Prisma préparées par défaut → OK ;
- IDOR : `/api/users/[id]` vérifie bien le `session.user.id` ;
- headers de sécurité (CSP, HSTS, X-Frame-Options) en `next.config.js` ou `middleware.ts`.

### Phase 6 (SEO / contenu)

- titles + meta description par page ;
- contenu des landing pages (zéro lorem) ;
- `sitemap.xml` + `robots.txt` ;
- Open Graph + Twitter Card.

### Phase 7 (admin / billing)

- cohérence des prix entre `/pricing`, `src/lib/stripe/plans.ts`, et le dashboard Stripe ;
- intégration Stripe : `mode: 'subscription'`, 3DS, redirection OK/KO ;
- webhook : signature vérifiée (`stripe.webhooks.constructEvent`) ;
- webhook : idempotence (un même `event.id` ne crée pas deux factures) ;
- events traités : `checkout.session.completed`, `invoice.paid`, `invoice.payment_failed`, `customer.subscription.updated`, `customer.subscription.deleted` ;
- emails transactionnels (Resend / SendGrid / Postmark) configurés ;
- factures stockées et accessibles dans l'espace client.

### Phase 8–9 (scoring + rapport)

Cf. `templates/audit-report.template.md`.

### Phase 10 (corrections sûres)

- ajouter les `<title>` / `<meta description>` manquants ;
- supprimer les `console.log` dans le code app/api ;
- `alt` vides sur images marketing ;
- `.gitignore` complété si besoin (`.env.production`, `.next/`, `coverage/`).

## Résultat attendu

### Score type pour un SaaS bien suivi mais à 2 semaines du lancement

| Axe | Score attendu (typique) |
|---|---|
| Technique | 75–85 |
| UX/UI | 70–80 |
| Sécurité | 50–65 (axe à risque) |
| SEO/Contenu | 60–75 |
| Admin/Backoffice | 70–80 |
| Paiement/Billing | 55–70 (souvent oublié) |
| Déploiement | 50–65 |
| **Global** | **62–72** — *Publiable avec corrections* |

### Verdict typique

> *"Publiable avec corrections. 3 à 5 problèmes critiques (souvent : webhook Stripe non signé, 3D Secure pas activé, `.env.production` codé en dur, page d'erreur 500 non custom). Top action : verrouiller les paiements avant tout."*

## Corrections possibles (selon score)

| Si score | Action recommandée |
|---|---|
| < 60 | Reporter le lancement de 1 semaine. Corriger les CRIT en priorité. |
| 60–75 | Lancer en soft launch (waitlist, friends & family) pendant 1 semaine. |
| 75–85 | Lancer comme prévu, plan de correction des `IMP` sur 1 mois post-launch. |
| > 85 | Lancer publiquement. |

## Points de vigilance

- **Webhooks Stripe** : 80% des bugs en prod viennent de webhooks non signés ou non idempotents. Vérifier en priorité.
- **3D Secure / SCA** : obligatoire en UE depuis 2021. Pas optionnel.
- **Cohérence pricing** : 9 fois sur 10, le prix est différent quelque part (ex : `/pricing` dit 19€, le code Stripe dit 19,90€).
- **Permissions multi-utilisateurs** : tester explicitement qu'un user A ne peut pas accéder à `/api/users/B/data`. C'est l'IDOR le plus courant.
- **Page de mot de passe oublié** : souvent le maillon faible (token long permanent, pas d'expiration, leak).

---

Created by João de Almeida — Art of Dev — https://artofdev.space
