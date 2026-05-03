# Shared safety rules

> Règles de sécurité et de prudence communes à **tous** les skills Art of Dev.
> Référence centrale : chaque SKILL.md peut pointer ici plutôt que de répéter ces règles.
>
> Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Pourquoi cette référence partagée

Les 7 skills Art of Dev (`repo-builder`, `production-auditor`, `premium-webdesigner`,
`site-ux-guardian`, `seo-content-engine`, `multilingual-site-engine`, `skill-orchestrator`)
partagent un noyau de règles **non négociables** : ne pas pousser sans accord, ne pas
exposer de secret, ne pas casser l'existant, ne pas supprimer sans validation.

Avant cette factorisation, ces règles étaient **réécrites dans chaque SKILL.md**, parfois
légèrement différemment, ce qui :

- gonflait les SKILL.md (token-cher, plus dur à charger en contexte) ;
- créait un risque de **dérive** (une règle corrigée à un endroit, oubliée ailleurs) ;
- diluait les règles **spécifiques** de chaque skill au milieu du bruit commun.

Cette référence est la **source unique** des règles transversales. Chaque SKILL.md doit :

1. **Pointer** ici pour le tronc commun ;
2. **Garder en local** uniquement les règles **spécifiques** à son domaine
   (méthode, périmètre, délégations, anti-patterns métier).

Mise à jour : éditer **uniquement** ce fichier. Les SKILL.md qui pointent ici en héritent.

---

## Règles non négociables (tous skills)

### 1. Pas de push GitHub sans accord explicite

Tous les skills **préparent** les commandes Git/GitHub mais ne les **exécutent jamais**
sans accord écrit de l'utilisateur.

Concrètement :

- jamais de `git push` (toutes formes) sans accord ;
- jamais de `git push --force` (interdit même avec accord, sauf cas de fuite de secret
  documentée — cf. §10) ;
- jamais d'ajout automatique de `--push` à `gh repo create` ;
- jamais de `git commit --amend` sur un commit déjà publié ;
- jamais de `--no-verify`, `--no-gpg-sign` sans demande explicite.

> Préparer les commandes, les afficher à l'utilisateur, attendre la validation. Toujours.

---

### 2. Pas de modification de fichiers de secrets

Les skills **ne modifient jamais** :

- fichier `.env`, `.env.local`, `.env.production`, `.env.development` ;
- `wp-config.php` ou tout équivalent contenant des credentials (`config/database.php`,
  `appsettings.json` avec connection string réelle) ;
- fichiers de credentials applicatifs (`credentials.json`, `service-account.json`) ;
- clés SSH privées (`id_rsa`, `id_ed25519`, `*.pem`, `*.ppk`, `*.key`) ;
- certificats TLS privés (`*.p12`, `*.pfx`) ;
- dump SQL contenant des données utilisateur réelles ;
- identifiants SMTP / IMAP / FTP / SFTP en clair ;
- tokens API (Stripe, GitHub, OpenAI, Anthropic, Pixabay, SendGrid, AWS, Azure, GCP…).

**Exception unique :** un fichier `.env.example` peut être créé/édité **s'il ne contient
que des placeholders vides** (`PIXABAY_API_KEY=`) ou explicitement faux
(`STRIPE_SECRET_KEY=sk_test_REPLACE_ME`).

> Si un secret est détecté pendant un audit ou une lecture : signaler **uniquement**
> le fichier et la ligne, **ne jamais reproduire la valeur**, ni à l'écran, ni dans
> un rapport, ni dans un commit, ni dans un nom de fichier.

---

### 3. Pas d'action destructive sans demande explicite

**Jamais** sans accord écrit explicite de l'utilisateur :

- `rm -rf` (toutes formes — sauf chemin clairement temporaire et confirmé) ;
- `git reset --hard`, `git clean -fd` ;
- `git push --force` (toutes variantes) ;
- `gh repo delete` ;
- `gh repo edit --visibility public` sur un repo existant ;
- suppression d'un fichier source du projet (même un fichier qui semble mort) ;
- suppression d'une branche, d'un tag, d'une release ;
- modification de `~/.ssh/`, `~/.gitconfig` global, `/etc/hosts`, configurations système ;
- `DROP TABLE`, `TRUNCATE`, `DELETE FROM` sans `WHERE` sur une base réelle ;
- modification d'un environnement de **production** sans backup vérifié.

Pour toute opération potentiellement destructive : **proposer la commande**, attendre,
et préférer une approche réversible (un seul `git revert` doit annuler la modification).

---

### 4. Confirmation avant les opérations à grande échelle

Demander confirmation **avant** :

- refonte massive (réécriture de plusieurs composants, migration de stack) ;
- migration de données (changement de schéma DB, conversion de format) ;
- traduction multi-langues (avant de générer N fichiers de localisation) ;
- audit complet automatique (lancer la phase d'application des corrections) ;
- modification d'un layout / header / footer **global** ;
- création d'un **nouveau composant partagé** ;
- changement de routes existantes ;
- ajout d'une dépendance (`npm install`, `composer require`, `pip install`) ;
- introduction d'un framework (React, Tailwind, Next.js…) dans un projet qui n'en a pas ;
- modification de la configuration CMS ou de la sécurité admin.

> Toujours **plan d'abord, exécution ensuite**.

---

### 5. Préférer signaler à modifier

Quand un problème est détecté hors du périmètre **explicite** de la demande :

- **signaler** dans le rapport : fichier, ligne, sévérité, recommandation ;
- **ne pas corriger** automatiquement, sauf "corrections sûres" listées explicitement
  par chaque skill (typo dans une chaîne, alt vide, `<title>` manquant, `console.log`
  oublié, ajout d'un `.gitignore` minimum, ajout d'un `.env.example` si secrets).

Une mauvaise correction de sécurité **automatique** peut introduire une faille pire
que celle qu'on tente de corriger. Idem pour l'UX, le SEO, la performance.

> Règle d'or : *signaler > corriger sans validation*.

---

### 6. Non-destruction de l'existant

- ne pas casser une **route** existante ;
- ne pas casser un **flow critique** (auth, paiement, checkout, formulaire) ;
- ne pas remplacer une **donnée dynamique** (DB, API, CMS) par du contenu **hardcodé**
  pour "faire joli" ou "boucher un trou" ;
- ne pas supprimer une **fonctionnalité** existante sans accord ;
- ne pas casser les **SEO existants** (titles, meta, balises, hreflang, canonical) ;
- ne pas casser l'**admin** ou ses fonctionnalités ;
- ne pas réécrire un module entier en mode "audit" — c'est de la refonte, pas un audit.

Toute modification doit être **réversible** : un seul `git revert` doit suffire à
annuler.

---

### 7. Périmètre projet

- travailler **uniquement** dans le projet ciblé (chemin de travail courant) ;
- ne pas remonter au-dessus du dossier projet ;
- ne pas modifier des fichiers globaux du système (`~/.gitconfig`, `~/.ssh/`,
  `/etc/`, `~/.bashrc`) sans accord explicite.

---

### 8. Mode `VIDEO_PRESENTATION_MODE`

Quand un skill est utilisé dans un contexte de **screen-recording / vidéo YouTube**
(détecté par `production-auditor` ou demandé explicitement) :

- masquer à l'écran et dans le rapport : IP, chemins serveur complets, noms
  d'utilisateurs Linux, contenu `.env`, tokens, logs bruts, hostnames internes ;
- utiliser des libellés génériques (`Project folder`, `Local development server`,
  `[hidden]`) ;
- vérifier que l'app n'affiche **aucune** erreur PHP brute, aucun stack-trace
  visible, aucune URL d'admin exposée publiquement.

---

### 9. Honnêteté

- ne **jamais inventer** une fonctionnalité qui n'existe pas (Stripe configuré, email
  fonctionnel, intégration tierce…) — si ce n'est pas configuré, le dire ;
- ne **jamais prétendre** avoir consulté une source non lue, importé un composant non
  importé, lancé un test non lancé ;
- ne **jamais fabriquer** une citation, une statistique, une référence ;
- documenter chaque **hypothèse** dans le rapport final.

---

### 10. Procédure de fuite de secret

Si une fuite de secret est détectée pendant un audit ou une création :

1. **Ne pas commiter.**
2. **Ne pas pusher.**
3. Lister la valeur masquée et le fichier/ligne à l'utilisateur.
4. Proposer le déplacement vers `.env` + placeholder dans `.env.example`.
5. Si la fuite a déjà été commitée localement (pas encore poussée) :
   - `git reset HEAD~1` pour annuler le dernier commit (garde les modifs) ;
   - retirer le fichier, mettre à jour `.gitignore` ;
   - ré-stager + ré-commiter.
6. Si la fuite a été poussée publiquement : **vrai incident sécurité**.
   Action immédiate :
   - **révoquer** la clé/token côté service concerné ;
   - générer une nouvelle clé ;
   - re-commit et **force-push après accord explicite uniquement**.

---

## Règles spécifiques par domaine

Ces sections décrivent **où** chaque type de règle est traité en profondeur.
Un skill qui détecte un problème hors de son domaine doit **déléguer** explicitement.

### Sécurité applicative profonde → `production-auditor`

Audit profond complet : CSRF, XSS, SQLi, headers HTTP (CSP, HSTS, X-Frame-Options),
rate-limit, auth (sessions, JWT, OAuth, 2FA), permissions / IDOR, uploads de fichiers,
billing (Stripe webhooks, signatures HMAC), dépendances (CVE), backups, monitoring,
RGPD / PCI-DSS.

Référence : [`skills/production-auditor/references/security-checklist.md`](../skills/production-auditor/references/security-checklist.md).

> Si un autre skill détecte un problème de sécurité **profond**, il doit **signaler**
> et **recommander** `production-auditor`, pas tenter une correction.

### Sécurité de base / signalement → `site-ux-guardian`

Signalement uniquement (pas de correction automatique) : `.env` exposé dans le webroot,
route admin sans middleware visible, route `/info.php` / `/phpinfo.php` /
`/server-status` accessible, lien vers fichier sensible (`.env`, `.git/`, `wp-config.php`)
dans le code livré, formulaire sans CSRF visible, page privée indexable, action
destructive (bouton Supprimer) sans modal de confirmation.

Référence : [`skills/site-ux-guardian/references/security-sanity-checklist.md`](../skills/site-ux-guardian/references/security-sanity-checklist.md).

> Périmètre **strict** : signaler les évidences. Pour audit profond → `production-auditor`.

### Conventions repo / `.gitignore` / scaffolding → `repo-builder`

Création de repos propres : arborescence par stack, `.gitignore` minimum obligatoire,
`.env.example` avec placeholders, `README.md` / `CHANGELOG.md` / `ROADMAP.md` /
`docs/architecture.md` / `docs/deployment.md`, audit de sécurité avant premier commit,
préparation des commandes Git/GitHub sans push automatique, conventions de naming
(slugs, casing, longueur).

Références :
- [`skills/repo-builder/references/security-checklist.md`](../skills/repo-builder/references/security-checklist.md) ;
- [`skills/repo-builder/references/github-workflow.md`](../skills/repo-builder/references/github-workflow.md) ;
- [`docs/security-rules.md`](security-rules.md) (règles `.gitignore` + audit avant commit).

### Direction artistique / refonte créative → `premium-webdesigner`

Brief design, recherche d'inspiration (21st.dev, shadcn, Lucide, Motion, Unsplash,
Pixabay), sélection de composants, direction artistique (palette, typo, spacing,
radius, shadows), sourcing d'images, exécution alignée sur la stack existante,
crédit Art of Dev dans le footer.

> N'introduit **jamais** une stack moderne (React, Tailwind, Next.js) dans un projet
> PHP/WordPress/HTML sans accord explicite.

### Cohérence ergonomique transversale → `site-ux-guardian`

Vérification de la cohérence **inter-pages** : menus, footers, routes, navigation
front/admin, doublons de composants, responsive, qualité visuelle de base. Audit
**transversal**, pas profond.

> Distinct de `premium-webdesigner` (refonte créative) et de `production-auditor`
> (audit production-grade complet).

### Contenu éditorial / SEO → `seo-content-engine`

Rédaction d'articles, méthode éditoriale, anti-bullshit IA, structure d'article,
FAQ, citations de sources réelles, liens internes, planning d'images, scoring de
qualité éditoriale.

### Localisation / multilingue → `multilingual-site-engine`

Traduction non littérale, humanisation (anti-style IA, tirets longs en boucle),
`hreflang`, slugs traduits, formats locaux (date, nombre, monnaie), RTL, emails
transactionnels localisés, scoring traduction + readiness multilingue.

### Routage entre skills → `skill-orchestrator`

Si plusieurs skills semblent pertinents, ou si l'utilisateur demande explicitement
l'orchestration, le `skill-orchestrator` analyse l'intention et propose le skill
**le plus spécifique** sans charger les autres.

---

## Comment chaque SKILL.md doit pointer ici

Dans chaque SKILL.md, remplacer les longues sections **"ne jamais X"** par un bloc
court de ce type :

```markdown
## Règles strictes

Voir [`docs/shared-safety-rules.md`](../../docs/shared-safety-rules.md) pour les règles
de sécurité communes à tous les skills (push, secrets, destructif, validation).

Spécifique à ce skill :

- <règle 1 propre au skill>
- <règle 2 propre au skill>
- <…>
```

Et garder en local **uniquement** les règles **spécifiques** au skill (méthode,
périmètre, délégations, anti-patterns métier).

---

## Maintenance

- Toute modification d'une règle commune se fait **ici**.
- Les SKILL.md ne dupliquent jamais une règle déjà présente dans ce fichier.
- Si une règle commune doit être adaptée à un skill (exception locale), **citer** ce
  fichier et **expliquer** l'exception dans la section "Spécifique à ce skill" du
  SKILL.md concerné.
- L'audit de doublons se relance à chaque release majeure (cf.
  `reports/duplicate-rules-audit-v1.0.md` pour la v1.0.0-rc1).

---

Created by João de Almeida — Art of Dev — https://artofdev.space
