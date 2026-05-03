# Checklist sécurité — `production-auditor`

Created by João de Almeida — Art of Dev — https://artofdev.space

À dérouler en phase 5. **Ne jamais reproduire la valeur** d'un secret détecté.

---

## 1. Secrets

- [ ] aucun fichier `.env`, `.env.local`, `.env.production` commit é ;
- [ ] `.env.example` présent et **uniquement** avec des placeholders ;
- [ ] aucun token GitHub (`ghp_`, `github_pat_`, `gho_`) dans le code ;
- [ ] aucune clé Stripe (`sk_live_`, `sk_test_`) dans le code ;
- [ ] aucune clé AWS (`AKIA...`) ;
- [ ] aucune clé OpenAI / Anthropic / Pixabay / SendGrid en clair ;
- [ ] aucun bloc `-----BEGIN PRIVATE KEY-----` ;
- [ ] aucune clé SSH privée (`id_rsa`, `id_ed25519`, `*.pem`) ;
- [ ] aucun `password=`, `secret=`, `api_key=`, `access_token=` avec valeur réelle ;
- [ ] secrets chargés via variables d'environnement uniquement.

> Outil : `bash skills/production-auditor/scripts/scan-secrets.sh .`

---

## 2. Authentification

- [ ] login admin / utilisateur fonctionnel ;
- [ ] mots de passe **hashés** (bcrypt, argon2, password_hash en PHP, jamais MD5/SHA1) ;
- [ ] sessions sécurisées (cookies `HttpOnly`, `Secure`, `SameSite=Lax` ou `Strict`) ;
- [ ] pas de "remember me" qui expose un token long permanent en clair ;
- [ ] limitation des tentatives de login (rate-limit / lockout) ;
- [ ] reset de mot de passe : token à usage unique, expiration courte, envoi par email ;
- [ ] 2FA disponible si SaaS ou app sensible.

---

## 3. Permissions / Authorization

- [ ] `/admin/`, `/install/`, `/api/private/` protégés ;
- [ ] séparation **public / admin** stricte ;
- [ ] vérification des droits **côté serveur**, jamais côté client uniquement ;
- [ ] pas d'IDOR (`/users/123/edit` accessible avec une autre session) ;
- [ ] rôles documentés et appliqués (admin / éditeur / lecteur) ;
- [ ] revue manuelle : un user A peut-il accéder aux données du user B ?

---

## 4. Admin

- [ ] URL `/admin/` non devinable ou protégée par firewall app ;
- [ ] `installed.lock` ou équivalent qui empêche la ré-installation ;
- [ ] mot de passe admin par défaut **changé** avant la prod (et pas affiché publiquement en mode dev) ;
- [ ] aucune route admin accessible sans session ;
- [ ] logs admin (qui a fait quoi, quand).

---

## 5. Uploads de fichiers

- [ ] validation MIME **côté serveur** ;
- [ ] taille max bornée (8 Mo par défaut) ;
- [ ] noms de fichiers nettoyés (pas de `../`, pas d'espaces ni d'accents non échappés) ;
- [ ] upload stocké **hors du dossier exécutable** ou avec exécution PHP/Node désactivée ;
- [ ] type de fichier vérifié par contenu (`finfo_file`), pas seulement extension ;
- [ ] images vérifiées (rejeter les fichiers PHP renommés en `.jpg`).

---

## 6. XSS (Cross-Site Scripting)

- [ ] toute donnée utilisateur affichée passe par un échappement (`htmlspecialchars`, `e()` Laravel, JSX par défaut, etc.) ;
- [ ] aucun `innerHTML` avec contenu utilisateur sans assainissement ;
- [ ] aucun `dangerouslySetInnerHTML` non maîtrisé ;
- [ ] CSP (`Content-Security-Policy`) présente côté HTTP headers (au moins `default-src 'self'`).

---

## 7. CSRF (Cross-Site Request Forgery)

- [ ] **tous les formulaires de mutation** (POST/PUT/DELETE) ont un token CSRF ;
- [ ] WordPress : nonces (`wp_nonce_field`, `check_admin_referer`) ;
- [ ] Laravel : `@csrf` ;
- [ ] Express / Node : middleware `csurf` ou équivalent ;
- [ ] FastAPI : token CSRF + `SameSite` cookies.

---

## 8. SQL Injection

- [ ] requêtes **toujours préparées** (paramètres liés) ;
- [ ] aucune concaténation `"SELECT * FROM users WHERE email = '" + email + "'"` ;
- [ ] ORM utilisé proprement (Prisma, Eloquent, SQLAlchemy, Doctrine) ;
- [ ] échappement même dans les `LIKE %x%`.

---

## 9. Environnement

- [ ] `APP_ENV=production` ou équivalent en prod ;
- [ ] `DEBUG=false` en prod ;
- [ ] aucune erreur PHP / stack-trace exposée publiquement ;
- [ ] aucune route `/debug`, `/info.php`, `/phpinfo.php`, `/server-status` accessible ;
- [ ] HTTPS obligatoire en prod (HSTS si possible).

---

## 10. Logs sensibles

- [ ] aucun mot de passe loggé ;
- [ ] aucun token loggé ;
- [ ] aucun numéro de carte loggé (PCI-DSS) ;
- [ ] PII (email, téléphone) tronquée ou masquée si possible ;
- [ ] rotation des logs en place ;
- [ ] logs accessibles uniquement à l'admin / sysadmin.

---

## 11. Backups

- [ ] backups réguliers configurés ;
- [ ] backups **chiffrés** au repos ;
- [ ] backups **non accessibles publiquement** (jamais dans `/public/backups/`) ;
- [ ] procédure de restauration testée au moins une fois ;
- [ ] backups conservés assez longtemps pour récupérer d'un incident détecté tardivement.

---

## 12. Déploiement

- [ ] HTTPS obligatoire (TLS 1.2+) ;
- [ ] HSTS (`Strict-Transport-Security`) ;
- [ ] `X-Frame-Options: SAMEORIGIN` ou CSP `frame-ancestors` ;
- [ ] `X-Content-Type-Options: nosniff` ;
- [ ] `Referrer-Policy: strict-origin-when-cross-origin` ;
- [ ] firewall serveur en place (UFW, iptables, fail2ban) ;
- [ ] SSH avec clés uniquement (pas de mot de passe) ;
- [ ] root SSH désactivé.

---

## 13. Dépendances

- [ ] `npm audit` / `composer audit` / `pip-audit` exécuté récemment ;
- [ ] CVE haute non corrigée signalée ;
- [ ] dépendances de dev pas embarquées en prod (`npm ci --production`).

---

## 14. Données personnelles (RGPD si UE)

- [ ] consentement cookies / trackers (bandeau actif, pas pré-coché) ;
- [ ] page `Politique de confidentialité` à jour ;
- [ ] possibilité d'export / suppression des données utilisateur ;
- [ ] pas de transfert hors UE non documenté ;
- [ ] anonymisation des logs IP si possible.

---

## 15. Monitoring sécurité minimal

- [ ] alerte si nombre d'erreurs 500 explose ;
- [ ] alerte si tentatives de login en masse ;
- [ ] alerte si taille du repo / disk pleine ;
- [ ] dashboard accessible uniquement par admin.

---

## Sortie attendue

Pour chaque item failed :

- **fichier** ou **zone concernée** (sans valeur du secret) ;
- **gravité** : `critique` (toujours `critique` pour un secret commit é) / `important` / `mineur` ;
- **impact** : 1 phrase ;
- **correction recommandée** : 1 phrase ;
- pour un secret détecté : **action immédiate** = révoquer la clé côté service.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
