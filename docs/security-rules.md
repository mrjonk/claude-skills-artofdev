# Règles de sécurité — `repo-builder`

Ces règles sont **non négociables**. Le skill `repo-builder` les applique à chaque création de repo.

---

## 1. Aucun secret commité — jamais

Ne doivent **jamais** entrer dans un commit :

- fichiers `.env`, `.env.production`, `.env.local` (uniquement `.env.example` est autorisé) ;
- tokens GitHub, GitLab, Bitbucket ;
- clés API (Stripe, OpenAI, Anthropic, Pixabay, SendGrid, Mailgun, AWS…) ;
- mots de passe — y compris ceux de comptes de dev ;
- identifiants SMTP, IMAP, FTP, SFTP ;
- chaînes de connexion à une base de données contenant l'hôte/user/pass ;
- certificats TLS privés (`*.pem`, `*.key`, `*.p12`, `*.pfx`) ;
- clés SSH privées (`id_rsa`, `id_ed25519`, `*.ppk`) ;
- credentials de service Google, Firebase, Azure, GCP ;
- secrets webhook (Stripe, GitHub, Linear…).

> **Exception unique :** un fichier `.env.example` avec des **placeholders vides** (`PIXABAY_API_KEY=`) ou explicitement faux (`STRIPE_SECRET_KEY=sk_test_REPLACE_ME`).

---

## 2. Aucune donnée client commitée

Ne doivent jamais être commités :

- dumps SQL contenant des données réelles (utilisateurs, emails, paiements) ;
- exports CSV de clients ;
- backups privés ;
- captures d'écran d'admin avec données réelles visibles ;
- logs serveur bruts.

Si un dump est nécessaire pour un test, il doit être **anonymisé** et nommé explicitement (`fixtures/seed-anon.sql`).

---

## 3. Aucune information serveur sensible

Ne doivent jamais apparaître dans le code livré :

- IP locales du VPS ;
- chemins absolus serveur (`/var/www/...`, `/home/<user>/...`) — utiliser des chemins relatifs ou des variables ;
- noms d'utilisateurs Linux (`adminvps`, `root`) ;
- ports internes non standards exposés ;
- noms d'hôtes internes.

> Cette règle vaut particulièrement pour le mode **vidéo / screen recording**. Voir `CLAUDE_PROJECT_FACTORY.md` §29.

---

## 4. `.gitignore` minimum obligatoire

Tout repo créé doit avoir, au minimum, ces motifs dans son `.gitignore` :

```gitignore
.env
.env.*
!.env.example
*.key
*.pem
id_rsa*
id_ed25519*
node_modules/
vendor/
.venv/
__pycache__/
*.log
*.sqlite
*.sqlite3
*.sql
*.dump
*.zip
*.tar.gz
exports/
backups/
.DS_Store
.vscode/
.idea/
```

Le skill adapte/complète selon la stack (par exemple : `.next/` pour Next.js, `dist/` pour build front, `target/` pour Rust).

---

## 5. Audit avant commit

Avant tout `git add` final, le skill exécute (ou propose d'exécuter) :

```bash
bash skills/repo-builder/scripts/check-repo-safety.sh .
```

Le script :

- scanne tous les fichiers en lecture seule ;
- alerte sur `.env`, `*.key`, `*.pem`, `id_rsa`, `id_ed25519`, `*.sql`, `*.dump`, motifs `password=`, `secret=`, `token=`, `api_key=` ;
- **ne supprime rien** ;
- retourne un code de sortie non nul s'il trouve quelque chose de suspect.

Si l'audit alerte, le skill **demande** à l'utilisateur avant de continuer.

---

## 6. Variables d'environnement documentées

Tout secret nécessaire au fonctionnement du projet doit être :

- déclaré dans `.env.example` avec un placeholder ;
- documenté dans le `README.md` (section *Environment variables*) ;
- chargé dans le code via une variable d'environnement, jamais en dur.

Exemple correct :

```php
$apiKey = getenv('PIXABAY_API_KEY') ?: '';
```

Exemple à proscrire :

```php
$apiKey = "1234567-abcdef1234567890";
```

---

## 7. Authentification GitHub via SSH ou token court

- Préférer `gh auth login` avec **SSH** (clé locale) ou **OAuth via navigateur**.
- Ne **jamais** stocker un Personal Access Token dans le repo, dans un fichier de config commit é, ni dans un `README`.
- Si un workflow CI a besoin d'un token, utiliser les **GitHub Actions secrets** (jamais commit é).

---

## 8. Vérifications post-création

Le skill doit conclure chaque création de repo avec un mini-rapport sécurité :

```txt
Audit sécurité :
- .env présent ? non
- .env.example présent ? oui
- Clés/tokens détectés ? non
- Dumps SQL détectés ? non
- node_modules / vendor commit é ? non
- Chemins serveurs sensibles détectés ? non
État : OK / À VÉRIFIER
```

Si l'état est `À VÉRIFIER`, le skill **bloque** le commit final et signale les fichiers en cause.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
