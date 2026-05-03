# Exemple — Audit d'un dashboard admin

## Contexte

Application interne de gestion de leads commerciaux.
Stack : Laravel 11 + MySQL + Vue 3 + Tailwind.
Utilisée par 5 commerciaux + 1 admin.
Pas de billing.
Cible : passage en production interne dans 1 semaine.

## Prompt utilisateur

> *"Audit de ce dashboard admin Laravel/Vue. Vérifie protection /admin, CRUD, filtres, recherche, pagination, états vides, confirmations, logs activité, exports, cohérence UX. Pas de billing dans ce projet. Donne le rapport. Applique les corrections sûres uniquement (typos, alt, balises manquantes)."*

## Ce que le skill doit analyser

### Phase 1–2

- `composer.json`, `package.json` ;
- `routes/web.php` et `routes/api.php` ;
- `config/auth.php`, `config/session.php` ;
- middlewares custom (`app/Http/Middleware/`) ;
- modèles Eloquent (`app/Models/`) ;
- composants Vue (`resources/js/`).

### Phase 3 (UX/UI)

- login → dashboard → CRUD entités principales (Lead, User, Setting) ;
- navigation latérale claire ;
- terminologie **humaine** : *"Tâches à faire"* > *"Tasks queue"* (cf. factory file §11) ;
- aucun terme technique visible (`endpoint`, `JSON`, `schema`) ;
- responsive desktop only OK pour un outil interne, mais doit rester lisible sur tablette.

### Phase 4 (technique)

- `php artisan route:list` clean (pas de routes orphelines) ;
- migrations idempotentes ;
- aucun `dd()`, `dump()`, `var_dump` oublié ;
- variables d'environnement complètes dans `.env.example` ;
- aucun chemin absolu codé en dur ;
- queue (Redis ou DB) configurée si jobs async.

### Phase 5 (sécurité)

- middleware `auth` sur **toutes** les routes admin ;
- middleware de rôle (`role:admin`, `role:commercial`) si rôles différents ;
- `@csrf` sur tous les formulaires Blade ;
- requêtes Eloquent (pas de `DB::raw` avec concat) ;
- vérification de propriété : un commercial A ne doit voir que ses leads, pas ceux du commercial B ;
- politiques d'accès (`Policy`) déclarées et utilisées ;
- log de connexion + log d'actions admin (Spatie Activitylog ou similaire).

### Phase 6 (SEO / contenu)

> Outil **interne** — SEO peu important. Vérifier seulement :
> - aucun robots.txt qui exposerait l'index ;
> - `<meta name="robots" content="noindex,nofollow">` sur les vues admin ;
> - titles cohérents (utile pour les onglets navigateur).

### Phase 7 (admin / backoffice — l'axe central ici)

- **Protection admin** : redirige vers `/login` si non auth ;
- **CRUD complet** sur Lead, User, Setting :
  - Create : formulaire + validation côté serveur (`FormRequest`) ;
  - Read : liste + détail ;
  - Update : pré-rempli + sauvegarde ;
  - Delete : modal de confirmation obligatoire ;
- **Filtres** : par statut, par commercial, par date ;
- **Recherche** : debounced, conserve l'URL ;
- **Pagination** : 25 par défaut, sélecteur 10/25/50 ;
- **États vides** : message + action ("Ajouter un premier lead") ;
- **Confirmations** : suppression simple OK, suppression multiple → double confirmation ;
- **Badges** : nombre de leads non traités, alertes ;
- **Statistiques** :
  - leads créés aujourd'hui / cette semaine / ce mois,
  - taux de conversion par commercial,
  - leads par statut ;
- **Exports** : CSV des leads filtrés, format UTF-8 BOM ;
- **Gestion utilisateurs** : create/edit/disable, reset password par admin, log connexions ;
- **Cohérence** : un statut `won` côté Lead doit s'afficher *"Gagné"* à l'écran, pas *"won"*.

### Phase 8 (scoring)

> Pas de billing → 10 pts redistribués (Tech +5, Sec +5).

### Phase 9 (rapport)

Standard.

### Phase 10 (corrections sûres)

- typos dans les libellés français ;
- `<title>` manquants sur les vues admin ;
- `alt` vides sur icônes informatives ;
- ajout du middleware `auth` si un controller a été créé sans (rare, mais arrive) ;
- ajout `@csrf` si un formulaire en a été oublié.

## Résultat attendu

### Score type pour un dashboard admin sérieux

| Axe | Score attendu |
|---|---|
| Technique | 75–85 |
| UX/UI | 70–80 |
| Sécurité | 70–80 |
| SEO/Contenu | N/A (outil interne, redistribué) |
| Admin/Backoffice | 75–90 (l'axe central) |
| Billing | N/A |
| Déploiement | 60–75 |
| **Global** | **72–82** — *Solide* à *Lancement possible* |

### Verdict typique

> *"Solide. Lancement interne possible. Quelques `IMP` à boucler (états vides sur 2 listes, confirmations sur suppression multiple, export CSV à corriger en UTF-8 BOM). Plan d'action en 3 jours-homme."*

## Corrections possibles

| Phase | Actions typiques |
|---|---|
| 1 — Bloquants | Vérifier middleware auth partout (rare, mais critique si oubli) |
| 2 — UX | États vides, confirmations doubles sur actions destructives |
| 3 — Sécurité | Vérifier policies + log d'activité |
| 4 — SEO | Noindex/nofollow sur toutes les vues admin |
| 5 — Finition | Termes humains, traductions complètes |
| 6 — Tests | Test manuel multi-utilisateurs (commercial vs admin) |

## Points de vigilance

- **IDOR** : un commercial peut-il accéder à `/leads/<id>` même si le lead n'est pas le sien ? Tester explicitement avec deux comptes.
- **Export CSV** : encodage UTF-8 BOM (sinon Excel casse les accents). Format `;` ou `,` selon la locale cible.
- **Reset password admin** : ne doit jamais afficher l'ancien mot de passe ni le nouveau en clair. Email seulement.
- **Termes techniques** : `database`, `endpoint`, `schema`, `migration` ne doivent **jamais** apparaître dans l'UI admin. C'est une règle Art of Dev (cf. factory file §11).
- **Performance** : si la liste leads dépasse 1000 entrées, vérifier qu'il y a une pagination ou virtualisation, pas un `select * from leads`.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
