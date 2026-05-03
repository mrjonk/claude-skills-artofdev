# Méthode d'audit — `production-auditor`

Méthode complète en **10 phases**. Chaque phase produit un output explicite réutilisable par la phase suivante.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Phase 1 — Lecture projet

**Objectif :** comprendre le projet en 10 minutes.

À lire :

- `README.md` (à la racine et dans `docs/` s'il existe) ;
- `package.json` / `composer.json` / `requirements.txt` / `pyproject.toml` / `Gemfile` ;
- `manifest.json` si mini CMS ;
- `.env.example` (jamais `.env`) ;
- `docker-compose.yml`, `Dockerfile` si présents ;
- `CHANGELOG.md`, `ROADMAP.md` ;
- `git log --oneline -20` pour le tempo des commits ;
- `git status` pour l'état courant.

**Output :** notes sur le type de projet, la stack, l'intention du créateur, le niveau de maturité.

---

## Phase 2 — Cartographie

**Objectif :** dresser l'inventaire des routes, fichiers, dépendances.

Commandes :

```bash
find . -type f -not -path './node_modules/*' -not -path './vendor/*' -not -path './.git/*' \
  -not -path './.venv/*' -not -path './dist/*' -not -path './build/*' | wc -l

# Routes (selon stack)
grep -rIE "(Route::|router\.|@Route|app\.(get|post|put|delete)|<Route )" \
  --include="*.php" --include="*.ts" --include="*.tsx" --include="*.js" --include="*.py" .

# Liens dans le HTML/JSX/PHP
grep -rIE "href=|to=" --include="*.html" --include="*.tsx" --include="*.jsx" --include="*.php" .
```

**Output :** liste des routes trouvées, liste des templates/pages, dépendances clés, taille du projet.

---

## Phase 3 — Audit UX/UI

**Objectif :** repérer les défauts visibles d'une vraie utilisation.

Cf. [`ux-ui-checklist.md`](ux-ui-checklist.md). Points clés :

- navigation cohérente et complète ;
- hiérarchie visuelle (un seul H1, H2 logiques) ;
- design **non template-look** (pas de "WordPress par défaut") ;
- CTA clairs et bien placés ;
- responsive (mobile prioritaire) ;
- états vides (`empty state`) gérés ;
- feedback utilisateur (notifications, loaders, succès/erreur).

**Output :** liste UX horodatée par page/écran.

---

## Phase 4 — Audit technique

**Objectif :** détecter les problèmes invisibles à l'œil nu.

Cf. [`technical-checklist.md`](technical-checklist.md). Outils :

```bash
bash skills/production-auditor/scripts/scan-common-issues.sh .
```

Points clés :

- build clean ;
- dépendances à jour ou explicitement figées ;
- pas de `console.log` / `var_dump` / `print_r` / `dd()` oubliés ;
- pas de fichiers `.bak`, `.old`, `.tmp` commitéss ;
- pas de données hardcodées (URLs prod, emails admin, IP) ;
- gestion d'erreurs présente (pas d'erreur PHP brute, pas de stack-trace public) ;
- variables d'environnement chargées correctement.

**Output :** liste technique.

---

## Phase 5 — Audit sécurité

**Objectif :** détecter les fuites et les vulnérabilités évidentes.

Cf. [`security-checklist.md`](security-checklist.md). Outils :

```bash
bash skills/production-auditor/scripts/scan-secrets.sh .
```

Points clés :

- aucun secret commit é (.env, tokens, clés API) ;
- auth en place (login admin, sessions, hash de password) ;
- permissions correctes (`/admin/` protégé) ;
- protection CSRF sur les formulaires de mutation ;
- requêtes DB préparées (pas de concaténation) ;
- uploads : validation MIME, taille max, nettoyage du nom ;
- `.env.example` présent, `.env` jamais dans le repo ;
- logs ne contiennent pas de données sensibles ;
- backups ne sont pas accessibles publiquement.

**Output :** liste sécurité **sans reproduire la valeur** des secrets détectés.

---

## Phase 6 — Audit SEO / contenu

**Objectif :** vérifier que le projet est lisible par un humain et un moteur.

Cf. [`seo-content-checklist.md`](seo-content-checklist.md). Points clés :

- `<title>` unique et pertinent par page ;
- `<meta description>` pertinente, pas générique ;
- un seul `<h1>` par page ;
- structure `<h2>`/`<h3>` cohérente ;
- contenu **réel** : pas de lorem ipsum, pas de bullshit IA générique, pas de doublons ;
- images avec `alt` non vide ;
- liens internes cohérents (pas de 404) ;
- pages légales (mentions, CGV si applicable, RGPD si applicable) ;
- `sitemap.xml`, `robots.txt` si site public.

**Output :** liste SEO/contenu.

---

## Phase 7 — Audit admin / billing / emails

**Objectif :** vérifier les zones critiques côté backoffice.

Cf. [`admin-dashboard-checklist.md`](admin-dashboard-checklist.md) et [`payment-billing-checklist.md`](payment-billing-checklist.md).

### Admin

- protection `/admin/` (redirige vers login si non authentifié) ;
- CRUD complet sur les entités principales ;
- filtres, recherche, pagination ;
- états vides corrects ;
- confirmations sur actions destructives (suppression) ;
- statistiques utiles (pas de tableau vide) ;
- cohérence front public ↔ admin.

### Billing (si applicable)

- plans et prix cohérents entre site, checkout et factures ;
- intégration Stripe/PayPal en mode test ou prod selon env ;
- webhooks reçus et traités ;
- factures générées et stockées ;
- emails transactionnels (paiement OK, paiement KO, renouvellement) ;
- gestion des erreurs de paiement.

### Emails

- templates non vides ;
- expéditeur configuré ;
- pas de mention `localhost` ou `[hostname]` qui fuiterait ;
- liens dans les emails : URL absolues correctes.

**Output :** liste admin/billing/emails.

---

## Phase 8 — Scoring

**Objectif :** transformer les listes en score actionnable.

Méthode :

1. Pour chaque axe (7 axes), compter les `critique`, `important`, `mineur`.
2. Partir d'un baseline `100`, soustraire :
   - `critique` : −10 pts ;
   - `important` : −4 pts ;
   - `mineur` : −1 pt.
3. Plancher à 0, plafond à 100.
4. Pondérer selon les poids définis dans `SKILL.md §8`.
5. Si pas de billing : redistribuer les 10 pts (5 sur Technique, 5 sur Sécurité).

**Output :** score global + 7 scores par axe + verdict (`SKILL.md §8`).

---

## Phase 9 — Rapport final

**Objectif :** rendre un document lisible en < 10 min.

Cf. [`report-format.md`](report-format.md) et [`../templates/audit-report.template.md`](../templates/audit-report.template.md).

Génération automatique d'un squelette :

```bash
bash skills/production-auditor/scripts/generate-audit-report.sh <project-name>
```

Le rapport doit pouvoir être lu par un fondateur non technique.

**Output :** `reports/audit-YYYY-MM-DD.md`.

---

## Phase 10 — Corrections sûres

**Objectif :** corriger uniquement ce qui est **évident**, **sûr** et **réversible**.

Corrections autorisées sans accord :

- typos évidentes ;
- balises `<title>` / `<meta description>` manquantes (avec valeurs neutres en placeholder) ;
- `alt` vides sur images ;
- `console.log` / `var_dump` / `dd()` / `print_r` oubliés ;
- `.gitignore` minimum manquant ;
- `.env.example` manquant si secrets nécessaires ;
- liens internes cassés évidents (typo dans URL) ;
- normalisation indentation/encodage si dégât léger.

Corrections **interdites sans accord** :

- refactor de fonction ;
- changement de route ;
- modification de pricing ;
- suppression de fichier (même `.bak`) ;
- modification de schéma DB ;
- mise à jour de dépendance majeure.

Chaque correction doit être :

- **listée** dans la section "Corrections appliquées" du rapport ;
- **annulable** par un seul `git revert` ;
- **documentée** : fichier, ligne, raison, état avant/après.

**Output :** diff propre + section "Corrections appliquées" remplie.

---

## Ordre d'exécution recommandé

```
Phase 1 → Phase 2 → (Phases 3 à 7 en parallèle si rapide)
                  → Phase 8 (scoring) → Phase 9 (rapport)
                                      → Phase 10 (corrections sûres)
                                      → mise à jour Phase 9 avec section "Corrections appliquées"
```

---

Created by João de Almeida — Art of Dev — https://artofdev.space
