# Exemple — App SaaS Node/Next

## Prompt utilisateur

> *"Initialise un repo Node/Next pour une app SaaS de gestion de tâches, avec auth, dashboard, paiements Stripe. Privé sur GitHub."*

## Type détecté

`node-saas`

## Ce que le skill doit produire

- arborescence `node-saas` (cf. `references/repo-structure-guide.md` §2) ;
- `package.json` minimal **sans installer** automatiquement ;
- `.env.example` avec placeholders Stripe + NextAuth + DATABASE_URL ;
- `docs/stripe-setup.md` (ajouté car Stripe demandé) ;
- `README` qui mentionne *"Stripe préparé mais non configuré"*.

## Structure attendue

```txt
saas-task-manager/
├── README.md
├── CHANGELOG.md
├── ROADMAP.md
├── LICENSE
├── .gitignore
├── .env.example
├── package.json
├── tsconfig.json
├── next.config.js
├── src/
│   ├── app/
│   ├── components/
│   ├── lib/
│   └── server/
├── prisma/
│   └── schema.prisma
├── public/
└── docs/
    ├── architecture.md
    ├── deployment.md
    └── stripe-setup.md
```

## `.env.example` attendu

```env
# --- Application ---
NODE_ENV=development
PORT=3000
NEXTAUTH_URL=http://localhost:3000
NEXTAUTH_SECRET=

# --- Base de données ---
DATABASE_URL=

# --- Stripe (mode test recommandé pour dev) ---
STRIPE_PUBLIC_KEY=pk_test_REPLACE_ME
STRIPE_SECRET_KEY=sk_test_REPLACE_ME
STRIPE_WEBHOOK_SECRET=
```

## Points de contrôle qualité

- [ ] `.env.example` présent, `.env` absent ;
- [ ] aucun `npm install` exécuté par le skill ;
- [ ] `package-lock.json` absent (laisser l'utilisateur choisir son gestionnaire) ;
- [ ] `README` mentionne explicitement : *"Pour activer les paiements, voir `docs/stripe-setup.md`. Tant que les clés Stripe ne sont pas définies, les routes de paiement renvoient une erreur claire."* ;
- [ ] `docs/stripe-setup.md` détaille : création du compte Stripe, mode test, clés à mettre dans `.env`, configuration du webhook ;
- [ ] `prisma/schema.prisma` présent avec un schéma vide (juste `generator` et `datasource`) ;
- [ ] `check-repo-safety.sh` ne déclenche aucune alerte.

## Commandes Git/GitHub préparées (non exécutées)

```bash
cd saas-task-manager
git init -b main
git add README.md CHANGELOG.md ROADMAP.md LICENSE .gitignore \
        .env.example package.json tsconfig.json next.config.js \
        src/ prisma/ public/ docs/
git status
git commit -m "init: scaffolding SaaS Next.js via repo-builder"

# À valider avant exécution :
gh repo create saas-task-manager --private --source=. --remote=origin
git push -u origin main
```

## Hypothèses faites

- TypeScript par défaut (le skill peut basculer sur JavaScript pur si l'utilisateur précise) ;
- Prisma par défaut comme ORM (interchangeable avec Drizzle / Kysely sur demande) ;
- DB par défaut : non choisie — `DATABASE_URL` vide à remplir.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
