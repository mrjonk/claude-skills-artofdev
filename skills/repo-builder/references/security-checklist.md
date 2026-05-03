# Checklist sécurité — `repo-builder`

À appliquer **avant tout commit**, sans exception.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. Aucun fichier sensible commité

Vérifier que **rien** de cette liste n'est en passe d'être ajouté à Git :

- [ ] aucun `.env`, `.env.production`, `.env.local`, `.env.development` ;
- [ ] aucun `secrets.json`, `credentials.json`, `*.token`, `*.secret` ;
- [ ] aucune clé SSH privée : `id_rsa`, `id_ed25519`, `*.pem`, `*.ppk`, `*.key` ;
- [ ] aucun certificat TLS privé : `*.crt`, `*.cer` (si privé), `*.p12`, `*.pfx` ;
- [ ] aucun dump SQL contenant des données réelles : `*.sql`, `*.dump` ;
- [ ] aucun backup privé : `*.bak`, `*.zip`, `*.tar.gz` non publics ;
- [ ] aucun `node_modules/`, `vendor/`, `.venv/`, `__pycache__/` ;
- [ ] aucun build artifact : `dist/`, `build/`, `.next/`, `out/`.

`.env.example` est **autorisé** s'il contient uniquement des placeholders **vides** ou explicitement faux.

---

## 2. Aucune chaîne suspecte dans le code

Faire tourner mentalement (ou via `check-repo-safety.sh`) une recherche pour :

```regex
password\s*=\s*['"]
secret\s*=\s*['"]
token\s*=\s*['"]
api[_-]?key\s*=\s*['"]
private[_-]?key
ghp_[A-Za-z0-9]{36}            # GitHub Personal Access Token classique
github_pat_[A-Za-z0-9_]{50,}    # GitHub Fine-grained PAT
sk_live_[A-Za-z0-9]{20,}        # Stripe live secret key
sk_test_[A-Za-z0-9]{20,}        # Stripe test secret key
xox[baprs]-[A-Za-z0-9-]{10,}    # Slack token
AKIA[0-9A-Z]{16}                # AWS access key
-----BEGIN (RSA |OPENSSH |EC )?PRIVATE KEY-----
```

Si une de ces signatures apparaît : **arrêter**, lister les fichiers, demander à l'utilisateur.

---

## 3. Aucune information serveur sensible

À éviter dans le code livré :

- [ ] chemins absolus type `/var/www/...`, `/home/<user>/...` — utiliser des chemins relatifs ou des variables ;
- [ ] adresses IP locales (`192.168.x.x`, `10.x.x.x`) ;
- [ ] adresses IP publiques du VPS ;
- [ ] noms d'utilisateurs Linux (`root`, `adminvps`, etc.) ;
- [ ] noms d'hôtes internes ;
- [ ] ports internes inhabituels exposés ;
- [ ] commentaires datés/signés mentionnant un environnement spécifique.

---

## 4. `.gitignore` minimum obligatoire

Tout repo créé par `repo-builder` doit avoir, au minimum :

```gitignore
# secrets
.env
.env.*
!.env.example
*.key
*.pem
*.token
*.secret
id_rsa*
id_ed25519*
*.ppk

# deps
node_modules/
vendor/
.venv/
venv/
__pycache__/
*.pyc

# builds
dist/
build/
out/
.next/
.nuxt/
.cache/

# logs / temp
*.log
.DS_Store
Thumbs.db
*.tmp
*.swp

# dumps & backups
*.sqlite
*.sqlite3
*.db
*.sql
*.dump
*.bak
backups/

# archives
*.zip
*.tar
*.tar.gz
exports/

# IDE
.vscode/
.idea/
```

Compléter selon la stack (par exemple : `coverage/` pour les tests, `target/` pour Rust, `bin/`/`obj/` pour .NET).

---

## 5. `.env.example` correctement rempli

Si le projet utilise des secrets, `.env.example` doit :

- lister **toutes** les variables nécessaires ;
- avoir des **valeurs vides** ou explicitement factices ;
- être commit é (lui, oui).

Bon exemple :

```env
# --- Pixabay ---
PIXABAY_API_KEY=

# --- Stripe (mode test recommandé pour dev) ---
STRIPE_PUBLIC_KEY=pk_test_REPLACE_ME
STRIPE_SECRET_KEY=sk_test_REPLACE_ME
STRIPE_WEBHOOK_SECRET=

# --- SMTP ---
SMTP_HOST=
SMTP_PORT=587
SMTP_USER=
SMTP_PASS=
```

Mauvais exemple (vraies valeurs présentes) :

```env
PIXABAY_API_KEY=12345678-abcdef1234567890   # NON
STRIPE_SECRET_KEY=sk_live_xxxxxxxxxxxxx     # NON
```

---

## 6. Audit automatique avant commit

```bash
bash skills/repo-builder/scripts/check-repo-safety.sh .
```

Le script :

- est **non destructif** ;
- alerte uniquement ;
- retourne un code de sortie ≠ 0 en cas de match suspect ;
- doit être exécuté **avant** `git add` final.

---

## 7. Que faire si une fuite est détectée

1. **Ne pas commit er.**
2. **Ne pas push er.**
3. Lister les fichiers concernés.
4. Demander à l'utilisateur :
   - retirer la valeur réelle ;
   - la mettre dans `.env` (non commit é) ;
   - mettre un placeholder dans `.env.example` ;
   - mettre à jour `.gitignore` si nécessaire.
5. Re-lancer `check-repo-safety.sh`.
6. Re-vérifier `git status`.
7. Reprendre la procédure de commit normale.

Si une fuite a déjà été commit ée localement (pas encore push ée) :

- `git reset HEAD~1` pour annuler le dernier commit (garde les modifs).
- Modifier les fichiers.
- Ré-stager + ré-commit er.

Si une fuite a été push ée publiquement : c'est une **vraie incident sécurité**. Action :

1. **Révoquer immédiatement** la clé/token côté du service concerné.
2. Générer une nouvelle clé.
3. Réécrire l'historique (`git filter-repo` ou `BFG`).
4. Force-push **après accord explicite**.
5. Documenter l'incident dans `CHANGELOG.md`.

---

## 8. Rappel mode vidéo / screen recording

(Aligné sur `CLAUDE_PROJECT_FACTORY.md` §29.)

À l'écran, ne **jamais** afficher :

- contenu d'un `.env` ;
- résultat de `printenv` ;
- IP locale ou publique du VPS ;
- chemins serveur complets ;
- noms d'utilisateurs Linux ;
- tokens, clés API, mots de passe.

Si une vérification de ce type est nécessaire pour le travail réel, **l'exécuter sans afficher la sortie** dans le résumé filmable.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
