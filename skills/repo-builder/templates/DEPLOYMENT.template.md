# Déploiement — {{PROJECT_NAME}}

---

## Prérequis

- {{REQUIRED_RUNTIME}} (version {{RUNTIME_VERSION}}+)
- {{REQUIRED_DB}} (version {{DB_VERSION}}+)
- {{REQUIRED_TOOLS}}
- Accès SSH au serveur cible (si déploiement self-hosted)

---

## Installation

### 1. Cloner le repo

```bash
git clone {{REPO_URL}}
cd {{REPO_SLUG}}
```

### 2. Installer les dépendances

```bash
{{INSTALL_COMMAND}}
```

### 3. Configurer

```bash
cp .env.example .env
# Éditer .env avec les vraies valeurs
nano .env
```

---

## Variables d'environnement

| Variable | Obligatoire | Exemple | Description |
|---|---|---|---|
| `{{ENV_1}}` | oui | `{{EX_1}}` | {{DESC_1}} |
| `{{ENV_2}}` | oui | `{{EX_2}}` | {{DESC_2}} |
| `{{ENV_3}}` | non | `{{EX_3}}` | {{DESC_3}} |

> ⚠️ Ne jamais commit er le fichier `.env`. Voir `docs/security-rules.md`.

---

## Build

```bash
{{BUILD_COMMAND}}
```

Output : `{{BUILD_OUTPUT_DIR}}`

---

## Démarrage

### Mode dev

```bash
{{DEV_COMMAND}}
```

### Mode production

```bash
{{PROD_COMMAND}}
```

---

## Reverse-proxy

### Nginx

```nginx
server {
    listen 80;
    server_name {{DOMAIN}};

    root {{PROJECT_PATH}}/public;
    index index.{{INDEX_EXT}};

    location / {
        try_files $uri $uri/ /index.{{INDEX_EXT}}?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.2-fpm.sock;
    }

    # Sécurité minimale
    location ~ /\.env { deny all; }
    location ~ /\.git { deny all; }
}
```

### Apache (`.htaccess`)

```apache
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^ index.php [L]

<Files .env>
    Require all denied
</Files>
```

---

## Permissions

```bash
# À adapter selon utilisateur applicatif (www-data, nginx…)
chown -R {{APP_USER}}:{{APP_USER}} {{PROJECT_PATH}}
find {{PROJECT_PATH}} -type d -exec chmod 755 {} \;
find {{PROJECT_PATH}} -type f -exec chmod 644 {} \;
chmod -R 775 {{PROJECT_PATH}}/storage
chmod -R 775 {{PROJECT_PATH}}/public/uploads
```

---

## Premier démarrage

1. {{FIRST_START_STEP_1}}
2. {{FIRST_START_STEP_2}}
3. {{FIRST_START_STEP_3}}

---

## Rollback

En cas de problème après déploiement :

```bash
# 1. Identifier le tag/commit précédent stable
git tag -l --sort=-creatordate | head -5

# 2. Revenir à cette version
git checkout {{PREVIOUS_TAG}}

# 3. Re-build / re-démarrer
{{BUILD_COMMAND}}
{{PROD_COMMAND}}
```

Pour la base de données : voir la section *Backups* dans `docs/architecture.md`.

---

## Healthcheck

```bash
curl https://{{DOMAIN}}/healthz
# Doit retourner : {"status":"ok"}
```

---

Created by {{AUTHOR}} — {{ORGANIZATION}} — {{HOMEPAGE}}
