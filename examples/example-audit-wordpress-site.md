# Exemple — Audit d'un site WordPress

## Contexte

Site WordPress 6.x classique, thème custom + 8 plugins, hébergé sur OVH/Infomaniak/équivalent.
Cible : lancement public dans la semaine.

## Prompt utilisateur

> *"Audit production de ce site WordPress. Lecture seule, ne modifie rien sans validation explicite. Vérifie les classiques : thème/plugins, secrets dans wp-config, protection /wp-admin, nonces sur formulaires custom, permissions dossiers, absence de backups dans uploads, contenu, pages légales, sitemap, robots.txt, HTTPS. Donne-moi un rapport complet."*

## Ce que le skill doit analyser

### Phase 1–2 (lecture + cartographie)

- `wp-config.php` (sans afficher les valeurs des `DB_*`, `*_KEY`, `*_SALT`) ;
- `.gitignore` du repo : doit exclure `wp-config.php`, `wp-content/uploads/`, `*.sql`, `*.zip` ;
- structure `wp-content/themes/<theme>` et `wp-content/plugins/<plugins>` ;
- liste des plugins actifs et leurs versions ;
- `functions.php` du thème (custom code).

### Phase 3 (UX/UI)

- homepage : design **non Hello Theme** ;
- menus : cohérence header / footer ;
- responsive 320/768/1024 ;
- formulaires (Contact Form 7, Gravity, WPForms…) — feedback clair, anti-spam (honeypot/reCaptcha) ;
- footer : minimum 3 colonnes (navigation + contact/social + légal) ;
- design global : pas de typographie WordPress par défaut ;
- effet wow sur la home ;
- breadcrumbs si site > 10 pages.

### Phase 4 (technique)

- versions à jour : core WordPress, thème, plugins (signaler les obsolètes) ;
- aucun debug actif (`WP_DEBUG`, `WP_DEBUG_DISPLAY` à `false` en prod) ;
- aucun `error_reporting(E_ALL)` ou `ini_set('display_errors', 1)` dans `functions.php` ;
- aucun `var_dump` / `print_r` / `error_log` oublié ;
- query monitor désactivé ou plugin retiré en prod ;
- uploads : pas de fichiers .zip, .sql, .bak, .old dans `/uploads/`.

### Phase 5 (sécurité)

- `wp-config.php` : `AUTH_KEY`, `SECURE_AUTH_KEY`, etc. **uniques** (pas les valeurs de l'install par défaut) ;
- `wp-config.php` non accessible publiquement (`Require all denied` côté Apache, ou règle Nginx) ;
- limit-login-attempts ou équivalent (Wordfence, Solid Security, Limit Login Attempts Reloaded) ;
- 2FA si possible (au moins pour les admins) ;
- `/wp-admin/` : reCAPTCHA ou IP whitelist si sensible ;
- nonces (`wp_nonce_field`) sur **tous** les formulaires custom ;
- échappement systématique en sortie (`esc_html`, `esc_attr`, `esc_url`) ;
- `disallow_file_edit` à `true` (bloquer l'éditeur de fichiers WP) ;
- préfixe DB **non `wp_`** (recommandation OWASP) ;
- aucun bloc PHP dans `/uploads/` (rejet via `.htaccess` ou Nginx).

### Phase 6 (SEO / contenu)

- Yoast / Rank Math / SEO Framework configuré ;
- titles + meta descriptions par page ;
- un seul `<h1>` par page (souvent buggé sur les thèmes) ;
- alt sur toutes les images (vérifier la médiathèque) ;
- pages légales : `Mentions légales`, `Politique de confidentialité`, `CGV` si vente, `Politique cookies` ;
- bandeau cookies fonctionnel (Cookiebot, Iubenda, Complianz, ou solution maison) ;
- `sitemap.xml` (généré par Yoast/Rank Math) ;
- `robots.txt` cohérent (autorise contenu public, bloque `/wp-admin/`, `/wp-includes/`, recherche).

### Phase 7 (admin)

- liste des utilisateurs admin : pas d'utilisateur "admin" / "administrator" par défaut ;
- aucun utilisateur de test resté actif ;
- rôles correctement assignés (Editor / Author plutôt qu'Admin pour les contributeurs) ;
- log d'activité admin (Simple History, WP Activity Log, ou similaire).

### Phase 8 (déploiement / hébergement)

- HTTPS forcé (redirection HTTP → HTTPS) ;
- HSTS activé ;
- backups quotidiens configurés (UpdraftPlus, BackWPup, ou côté hébergeur) ;
- backups stockés **hors du serveur** (Dropbox, S3, Google Drive) ;
- procédure de restauration testée ;
- logs PHP / Apache accessibles ;
- monitoring uptime externe.

### Phase 9 (rapport)

Standard.

### Phase 10 (corrections sûres — lecture seule en l'occurrence)

> Le prompt explicite "lecture seule, ne modifie rien sans validation". Donc **aucune correction appliquée**. Tout est en `recommandé`.

## Résultat attendu

### Score type pour un WP correctement maintenu

| Axe | Score attendu |
|---|---|
| Technique | 65–80 |
| UX/UI | 65–80 |
| Sécurité | 50–70 (souvent l'axe le plus faible sur WP) |
| SEO/Contenu | 75–90 (Yoast aide) |
| Admin/Backoffice | 70–85 |
| Billing | N/A si vitrine, ou 50–70 si WooCommerce |
| Déploiement | 60–75 |
| **Global** | **65–78** |

### Verdict typique

> *"Publiable avec corrections. Sécurité à renforcer (limit login + 2FA + nonces sur le 2 formulaires custom). Tout le reste est solide. Action immédiate : auditer les plugins listés et désactiver / mettre à jour ceux flagués."*

## Corrections possibles (à valider par l'utilisateur)

| Priorité | Action |
|---|---|
| 1 | Mettre à jour core + thème + plugins (sandbox de test d'abord) |
| 1 | Activer limit-login-attempts |
| 2 | Ajouter 2FA pour admins |
| 2 | Nettoyer la médiathèque (zip / sql / bak résiduels) |
| 3 | Compléter les meta descriptions manquantes |
| 3 | Ajouter alt aux images sans alt |

## Points de vigilance

- **`wp-config.php`** : ne **jamais** afficher son contenu pendant l'audit ou dans le rapport. Vérifier seulement la **présence** des bons constants.
- **Utilisateur "admin"** : si présent, c'est un drapeau rouge. Renommer ou supprimer.
- **Plugins abandonnés** : un plugin sans MAJ depuis 2 ans est un **risque sécurité**. Lister, recommander remplacement.
- **WooCommerce** : si présent, ajouter l'audit `payment-billing-checklist.md` (Stripe / PayPal / webhooks).
- **`.htaccess`** : vérifier qu'il n'a pas été modifié par un plugin malveillant (regarder les redirections inattendues).

---

Created by João de Almeida — Art of Dev — https://artofdev.space
