# Checklist sécurité basique — `site-ux-guardian`

`site-ux-guardian` n'est **pas** un audit sécurité complet. Il signale uniquement les problèmes **évidents et visibles**.

Pour un audit profond → **`production-auditor`**.

Created by João de Almeida

---

## 1. Périmètre du skill

### Ce que le skill vérifie

- présence visible de fichiers / routes sensibles ;
- pages admin évidemment non protégées ;
- absence de protections de base attendues sur les formulaires ;
- absence de protections sur les uploads ;
- liens vers fichiers sensibles dans le code livré.

### Ce que le skill **ne** vérifie **pas**

- vulnérabilités CSRF / XSS / SQLi en profondeur ;
- audit auth complet (JWT, OAuth, sessions) ;
- audit des dépendances (npm audit / composer audit) ;
- audit cryptographique ;
- audit de conformité (RGPD, PCI-DSS) ;
- audit de pentests / OWASP Top 10 complet.

→ Pour ces points : **`production-auditor`** ou audit humain spécialisé.

---

## 2. Admin non protégé

### Symptômes à détecter

- page accessible via `/admin` **sans redirection vers /login** ;
- pas de middleware d'auth visible dans le code des routes admin ;
- pages admin **indexables** (manque `<meta name="robots" content="noindex,nofollow">`) ;
- routes admin présentes dans le `sitemap.xml`.

### Détection

```bash
# Trouver les routes admin
grep -rIE '/admin|/dashboard|/manage' --include="*.php" --include="*.tsx" --include="*.jsx" --include="*.vue" .

# Chercher la protection
grep -rIE 'auth\b|middleware|requireAuth|@Auth|isAuthenticated' --include="*.php" --include="*.tsx" --include="*.jsx" .
```

### Action `site-ux-guardian`

- **signaler** comme **CRITIQUE** ;
- **NE PAS** ajouter d'auth automatiquement (trop sensible) ;
- recommander : middleware auth + `noindex` + redirection ;
- pour audit auth complet → **`production-auditor`**.

---

## 3. Formulaire sensible sans validation

### Cas

- formulaire de **paiement** sans validation ;
- formulaire de **création d'utilisateur** sans rate-limit visible ;
- formulaire de **contact** sans honeypot / CAPTCHA / rate-limit ;
- formulaire d'**upload** sans contrôle MIME / taille.

### Détection

```bash
grep -rIE '<form\b' --include="*.html" --include="*.php" --include="*.tsx" --include="*.jsx" --include="*.vue" .
```

→ Pour chaque formulaire, vérifier :
- **CSRF token** présent (`@csrf`, `<input type="hidden" name="_token">`, `wp_nonce_field`, `csrfToken`, etc.) ;
- **validation** côté serveur (pas seulement HTML5) ;
- **rate-limit** ou anti-spam pour les formulaires publics.

### Action

- **signaler** ;
- **lister** les formulaires sans CSRF visible ;
- **NE PAS** ajouter de protection automatiquement.

---

## 4. Upload exposé / non sécurisé

### Cas critiques

- dossier `/uploads/` qui exécute du PHP ;
- upload sans validation MIME ;
- upload sans validation de taille ;
- upload qui garde le **nom original** (`../../../etc/passwd`).

### Détection

```bash
# Chercher les zones d'upload
grep -rIE 'enctype="multipart/form-data"|FileUpload|<input type="file"' \
  --include="*.html" --include="*.php" --include="*.tsx" --include="*.jsx" .

# Vérifier la conf .htaccess / nginx pour /uploads/
cat .htaccess 2>/dev/null
find . -name "*.htaccess" -path "*/uploads/*" 2>/dev/null
```

### Action

- **signaler** comme **important** ;
- recommander :
  - `.htaccess` ou config Nginx qui désactive l'exécution PHP dans `/uploads/` ;
  - validation MIME via `finfo_file` (PHP) / `file-type` (Node) ;
  - taille max ;
  - sanitisation du nom de fichier.

---

## 5. Routes debug visibles

### Routes à chercher

| Route | Signal |
|---|---|
| `/debug` | mode debug actif en prod |
| `/info.php` | phpinfo() exposé |
| `/phpinfo.php` | phpinfo() exposé |
| `/server-status` | Apache mod_status |
| `/server-info` | Apache mod_info |
| `/_profiler` | Symfony web profiler |
| `/__debug__` | Django debug toolbar |
| `/_routes` | parfois exposé |
| `/.git/` | repo git accessible |

### Détection

- `grep` dans les routes / URLs déclarées ;
- vérifier la config server (Apache/Nginx) si possible ;
- en mode local, ces routes peuvent être OK ; en prod, elles sont **critiques**.

### Action

- **signaler** comme critique si production ;
- **NE PAS** modifier la config server sans accord.

---

## 6. Lien vers fichiers sensibles

### Fichiers à ne **jamais** linker

- `.env` ;
- `.env.production`, `.env.local` ;
- `wp-config.php` ;
- `.htaccess` ;
- `.git/` ;
- `composer.json` (peut être OK selon contexte, mais `composer.lock` non) ;
- `package.json` (peut être OK) ;
- backups (`.bak`, `.sql`, `.dump`).

### Détection

```bash
grep -rIE 'href="[^"]*\.(env|sql|bak|dump|sqlite)"' \
  --include="*.html" --include="*.php" --include="*.tsx" --include="*.jsx" .
```

### Action

- **signaler** ;
- **NE PAS** modifier sans accord.

---

## 7. Clé API visible côté front

### Cas

- clé API hardcodée dans un fichier JS bundle ;
- clé API exposée via `process.env.NEXT_PUBLIC_*` (publique par construction) ;
- clé API dans un attribut HTML (`data-api-key="..."`).

### Détection

```bash
grep -rIE '(api[_-]?key|access[_-]?token|secret)[[:space:]]*[=:][[:space:]]*['"'"'"][^'"'"'"]{6,}' \
  --include="*.js" --include="*.tsx" --include="*.jsx" --include="*.html" --include="*.php" .
```

→ Le scanner du skill `production-auditor` (`scan-secrets.sh`) fait cette détection plus précisément.

### Action

- **signaler** sans afficher la valeur ;
- recommander :
  - utiliser un proxy backend pour les API qui le permettent ;
  - clé API publique (Maps, etc.) = OK si **restrictions** côté service (referer, IP) ;
  - **JAMAIS** de clé secrète en front.

---

## 8. `.env` exposé

### Détection

- présence d'un fichier `.env` à la racine du dossier servi par le webserver ;
- absence de protection `.htaccess` / Nginx pour `.env` ;
- `.env` dans le repo git (vérifier le `.gitignore`).

### Action

- **signaler** critique ;
- recommander :
  - `.env` **jamais** dans le webroot (placer hors du dossier servi) ;
  - règle Apache/Nginx qui bloque l'accès aux `.env*` ;
  - `.env` dans `.gitignore`.

---

## 9. Page privée indexable

### Cas

- page admin sans `<meta name="robots" content="noindex,nofollow">` ;
- page utilisateur connecté indexée par Google ;
- page de paiement réussi (`/order-success?id=123`) accessible et indexée.

### Détection

```bash
# Pages potentiellement privées
grep -rIE '(admin|dashboard|account|profile|orders|invoices|checkout)' --include="*.html" --include="*.tsx" .

# Vérifier la balise robots
grep -rIE '<meta\s+name="robots"' --include="*.html" --include="*.tsx" --include="*.php" .
```

### Action

- **signaler** ;
- recommander l'ajout de `<meta name="robots" content="noindex,nofollow">` sur les pages privées.

---

## 10. Action destructive sans confirmation

### Cas

- bouton **Supprimer** qui supprime sans modal de confirmation ;
- API DELETE qui n'exige pas de confirmation ;
- script qui supprime des données sans dry-run.

### Détection

```bash
# Boutons / liens "Supprimer", "Delete"
grep -rIE '>\s*(Supprimer|Delete|Remove)\s*<' \
  --include="*.html" --include="*.php" --include="*.tsx" --include="*.jsx" .
```

→ Pour chaque résultat, vérifier qu'une confirmation existe à proximité (`onClick={confirmDelete}`, `data-confirm`, etc.).

### Action

- **signaler** ;
- recommander :
  - modal de confirmation ;
  - typage (`Tapez 'SUPPRIMER' pour confirmer`) pour les actions très critiques ;
  - dry-run pour les scripts.

---

## 11. Format de rapport sécurité basique

```markdown
## Audit sécurité basique

| ID | Sévérité | Fichier / route | Problème | Recommandation |
|---|---|---|---|---|
| SEC-001 | critique | `/admin` | aucune protection détectée | ajouter middleware auth + noindex |
| SEC-002 | critique | `/contact` | formulaire sans CSRF | ajouter token CSRF côté serveur |
| SEC-003 | important | `/uploads/` | aucune restriction d'exécution PHP | `.htaccess` ou conf Nginx |
| SEC-004 | important | `pages/checkout-success.html` | indexable | ajouter `<meta noindex>` |
| SEC-005 | mineur | `client.js:42` | clé API publique sans restriction connue | vérifier les restrictions côté service |

**Pour audit profond** : `production-auditor` (CSRF, XSS, SQLi, headers, dépendances, billing).
```

---

## 12. Règle d'or

`site-ux-guardian` **signale** mais ne **modifie jamais** les éléments de sécurité sans validation explicite.

Une mauvaise correction de sécurité **automatique** peut introduire une faille pire que celle qu'on tente de corriger.

---

Created by João de Almeida
