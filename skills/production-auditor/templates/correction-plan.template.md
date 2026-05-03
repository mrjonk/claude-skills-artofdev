# Plan de correction — {{PROJECT_NAME}}

> Plan ordonné par phases. Chaque phase doit être terminée avant de passer à la suivante.
> Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Phase 1 — Bloquants (priorité 1)

**Objectif :** rendre le projet déployable.
**Durée typique :** 0,5–2 jours selon volume.

- [ ] CRIT-001 — {{Description}} → fichier `{{path}}`
- [ ] CRIT-002 — {{Description}} → fichier `{{path}}`
- [ ] CRIT-003 — {{Description}} → fichier `{{path}}`

**Critère de sortie :** zéro `CRIT-` ouvert + scan secrets clean.

---

## Phase 2 — UX / Navigation (priorité 2)

**Objectif :** rendre le projet utilisable par un utilisateur réel.
**Durée typique :** 0,5–1 jour.

- [ ] IMP-XXX — Vérifier la cohérence du menu sur toutes les pages
- [ ] IMP-XXX — Corriger les CTA mal placés ou peu visibles
- [ ] IMP-XXX — Tester le responsive 320 / 768 / 1024 / 1440
- [ ] IMP-XXX — Compléter les états vides
- [ ] IMP-XXX — Ajouter feedback utilisateur sur les actions

**Critère de sortie :** un utilisateur non technique peut faire le parcours principal sans buguer.

---

## Phase 3 — Sécurité (priorité 2)

**Objectif :** verrouiller les fuites évidentes.
**Durée typique :** 0,5–1 jour.

- [ ] Vérifier `.env.example` complet, `.env` absent du repo
- [ ] Vérifier hash des mots de passe (bcrypt/argon2)
- [ ] Vérifier protection `/admin/`
- [ ] Vérifier CSRF sur tous les formulaires de mutation
- [ ] Vérifier requêtes DB préparées
- [ ] Vérifier validation MIME / taille sur les uploads
- [ ] Vérifier que `DEBUG=false` en prod

**Critère de sortie :** scan secrets clean + checklist sécurité ≥ 80%.

---

## Phase 4 — SEO / Contenu (priorité 2)

**Objectif :** publier un projet lisible par humains et moteurs.
**Durée typique :** 0,5 jour.

- [ ] Ajouter les `<title>` manquants (uniques par page)
- [ ] Ajouter les `<meta description>` manquantes
- [ ] Vérifier un seul `<h1>` par page
- [ ] Compléter les `alt` images
- [ ] Vérifier les pages légales (mentions, RGPD si applicable)
- [ ] Générer / vérifier `sitemap.xml` et `robots.txt`
- [ ] Remplacer tout texte générique par du contenu réel

**Critère de sortie :** Lighthouse SEO ≥ 90.

---

## Phase 5 — Finition premium (priorité 3)

**Objectif :** passer de "ça marche" à "c'est propre".
**Durée typique :** 0,5–1 jour.

- [ ] Vérifier la cohérence du design (polices, couleurs, espacements)
- [ ] Polir le hero (effet wow, image forte)
- [ ] Polir le footer (3 colonnes minimum, copyright dynamique)
- [ ] Vérifier les hover states, transitions douces
- [ ] Vérifier les micro-interactions (cards, boutons)
- [ ] Vérifier les images (compression, ratios cohérents)

**Critère de sortie :** screenshot de la homepage présentable dans une vidéo / un article.

---

## Phase 6 — Tests finaux (avant déploiement)

**Objectif :** valider que rien n'a régressé.
**Durée typique :** 0,5 jour.

- [ ] Build clean (`npm run build` / `composer dump-autoload` / etc.)
- [ ] Tests automatisés OK (smoke tests minimum)
- [ ] Test manuel du parcours principal
- [ ] Test admin (login, CRUD, déconnexion)
- [ ] Test billing si applicable (checkout en mode test)
- [ ] Test responsive sur 5 breakpoints
- [ ] Healthcheck (`/healthz`) répond
- [ ] Backups configurés
- [ ] Rollback documenté

**Critère de sortie :** déploiement OK + rapport audit relancé → score ≥ 76.

---

## Suivi

| Phase | Statut | Démarrée | Terminée |
|---|---|---|---|
| 1 — Bloquants | `pending` / `in-progress` / `done` | YYYY-MM-DD | YYYY-MM-DD |
| 2 — UX | `pending` | | |
| 3 — Sécurité | `pending` | | |
| 4 — SEO | `pending` | | |
| 5 — Finition | `pending` | | |
| 6 — Tests | `pending` | | |

---

## Tip

Si le projet a beaucoup de bloquants : **ne pas tout corriger d'un coup**. Avancer par lots de 3 à 5 fichiers, commit dédié, vérifier que rien ne casse, passer au lot suivant.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
