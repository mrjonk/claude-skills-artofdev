# Exemples — `production-auditor`

Created by João de Almeida — Art of Dev — https://artofdev.space

Prompts prêts à copier. Choisis celui qui correspond à ton contexte.

---

## 1. Audit d'un SaaS

```txt
Audit production-grade de cette app SaaS Node/Next.

Contexte :
- Stack : Next.js 14 + Prisma + PostgreSQL + Stripe.
- Cible : lancement public dans 2 semaines.
- Pricing : 3 plans (Free / Pro / Team).

Vérifie en priorité :
- l'auth (NextAuth, sessions, hash mot de passe) ;
- le checkout Stripe (mode test → mode live, webhooks signés et idempotents) ;
- la cohérence pricing entre /pricing, /checkout et factures ;
- les permissions (un user A ne doit pas voir les données du user B) ;
- les variables d'environnement (.env vs .env.example) ;
- le déploiement (HTTPS, headers de sécurité, backups DB).

Donne-moi le rapport complet avec score et plan d'action.
Applique uniquement les corrections sûres et évidentes.
Ne push rien.
```

---

## 2. Audit d'un mini CMS

```txt
Audit avant livraison client de ce mini CMS sectoriel (PHP 8 + SQLite).

Cible : restaurant. Le client doit pouvoir installer le ZIP en autonomie via /install/.

Vérifie :
- le flux d'installation (/install/ propre, lock après installation) ;
- le dashboard admin (statistiques, to-do, checklist de lancement) ;
- l'intégrité du export ZIP (rien de sensible inclus, .env exclu, manifest.json correct) ;
- la cohérence front public ↔ admin ;
- les images : Pixabay configuré ou placeholders propres ;
- les fonctions admin essentielles (gestion contenu, médias, horaires, contact, demandes) ;
- aucun mot de passe en dur dans le code.

Mode `VIDEO_PRESENTATION_MODE` activé : masque les chemins serveur dans le rapport.

Donne-moi le rapport et applique les corrections sûres.
```

---

## 3. Audit d'un site WordPress

```txt
Audit production de ce site WordPress.

Vérifie :
- thème et plugins à jour (sans tout casser) ;
- aucun secret dans wp-config.php commit é (vérifier .gitignore) ;
- protection /wp-admin/ (limite-login, 2FA si possible) ;
- nonces sur formulaires custom ;
- permissions des dossiers (uploads, wp-content) ;
- absence de backups dans wp-content/uploads ;
- cohérence du contenu (zéro lorem ipsum, alt images, meta descriptions) ;
- pages légales (mentions, RGPD, politique cookies) ;
- sitemap.xml et robots.txt présents ;
- HTTPS + HSTS.

Audit lecture seule. Ne modifie rien sans validation explicite.
```

---

## 4. Audit d'un dashboard admin

```txt
Audit de cette app admin (dashboard interne pour gestion de leads).

Stack : Laravel 11 + MySQL + Vue.

Vérifie :
- protection /admin (auth + permissions par rôle) ;
- CRUD complet sur les entités principales (leads, users, settings) ;
- filtres + recherche + pagination sur toutes les listes ;
- états vides + confirmations sur actions destructives ;
- logs d'activité admin (qui a fait quoi) ;
- exports (CSV des leads, factures PDF) ;
- aucun terme technique visible dans l'UI admin.

Donne-moi un score + bug-list + plan d'action.
Applique les corrections de typos et balises manquantes uniquement.
```

---

## 5. Audit avant vidéo YouTube

```txt
Audit "screen-safe" avant tournage YouTube de ce projet.

Mode `VIDEO_PRESENTATION_MODE` activé.

Vérifie particulièrement :
- aucun secret visible si je fais `cat` ou `ls -la` à l'écran ;
- aucun chemin serveur complet (/var/www/...) dans les fichiers ;
- aucune IP locale ou publique du VPS dans le code ;
- aucune erreur PHP brute affichable côté public ;
- pages 404 et 500 customisées et silencieuses ;
- effet wow sur la homepage (cf. CLAUDE_PROJECT_FACTORY.md §16) ;
- aucune route admin exposée avec une URL devinable ;
- mots de passe par défaut documentés mais marqués "À changer".

Donne-moi le rapport et la liste des fichiers/zones à éviter de montrer à l'écran.
```

---

## 6. Audit avant déploiement VPS

```txt
Audit déploiement uniquement de ce projet.

Vérifie :
- variables d'environnement de prod (sans afficher leur valeur) ;
- build clean (`npm run build` ou équivalent) ;
- backups configurés (DB + uploads) ;
- procédure de rollback documentée et testée ;
- config Nginx/Apache (try_files, deny .env, gzip, cache assets) ;
- HTTPS + HSTS + headers sécurité (X-Frame-Options, X-Content-Type-Options, CSP) ;
- permissions fichiers (755 dossiers, 644 fichiers, 600 .env) ;
- cron / workers documentés et idempotents ;
- monitoring minimal (uptime, healthcheck, alerte erreur 5xx) ;
- domaine (DNS, SPF/DKIM/DMARC si emails sortants).

Score uniquement sur l'axe "Déploiement". Liste les actions manquantes.
```

---

## 7. Audit SEO / contenu

```txt
Audit SEO et contenu de ce site (focus : Lighthouse SEO ≥ 90 visé).

Vérifie :
- titles uniques par page, longueur 50-60 ;
- meta descriptions uniques, longueur 130-160 ;
- un seul H1 par page, hiérarchie H2/H3 cohérente ;
- contenu réel (zéro lorem, zéro phrase IA générique, zéro doublon) ;
- alt images non vides sur images informatives ;
- liens internes (zéro 404) ;
- pages légales (mentions, RGPD si UE) ;
- sitemap.xml + robots.txt présents et cohérents ;
- Open Graph (og:title, og:description, og:image) ;
- schema.org adapté (LocalBusiness, Product, etc.) ;
- HTML valide sans erreurs critiques.

Applique les corrections sûres : ajout de titles/meta descriptions manquants, alt vides, structure H1/H2 si typo évidente.
```

---

## 8. Audit sécurité

```txt
Audit sécurité only.

Vérifie :
- aucun secret commit é (.env, tokens, clés API, password=, secret=) ;
- mots de passe hashés (bcrypt/argon2, jamais MD5/SHA1) ;
- protection /admin (auth + permissions) ;
- sessions sécurisées (HttpOnly, Secure, SameSite) ;
- CSRF sur tous les formulaires de mutation ;
- requêtes DB préparées (zéro concaténation) ;
- uploads : validation MIME + taille + extension ;
- aucun upload exécutable dans un dossier exposé ;
- HTTPS obligatoire en prod + HSTS ;
- headers sécurité (CSP, X-Frame-Options, X-Content-Type-Options, Referrer-Policy) ;
- aucune fuite d'IP locale, chemin serveur, nom user Linux.

Lecture seule. Si secret détecté : signaler le fichier et la ligne, JAMAIS la valeur.
Donne le verdict en une phrase claire à la fin.
```

---

## 9. Audit ASP.NET WebForms (legacy)

```txt
Audit production de cette app legacy ASP.NET WebForms.

Vérifie :
- web.config : modes debug, authentification, chaînes de connexion (sans afficher) ;
- ViewState chiffré ;
- contrôles avec validation côté serveur ;
- protection contre XSS (HtmlEncode) ;
- requêtes paramétrées (zéro string concat dans SQL) ;
- gestion d'erreurs (page d'erreur custom, pas de stack-trace exposé) ;
- patches Windows et IIS à jour.

Score sur 7 axes adapté.
Lecture seule.
```

---

## 10. Re-audit / comparaison

```txt
Lance un nouvel audit production sur ce projet.

Contexte : un audit a été fait il y a 5 jours (reports/audit-2026-04-28.md).
J'ai corrigé les CRIT et 4 IMP.

Compare le score avant/après et confirme :
- aucune nouvelle régression sur les CRIT corrigés ;
- les IMP corrigés sont bien fermés ;
- pas de nouveau MIN qui aurait apparu lors des corrections.

Donne-moi un rapport "delta" plutôt qu'un rapport complet.
```

---

Created by João de Almeida — Art of Dev — https://artofdev.space
