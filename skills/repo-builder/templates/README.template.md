# {{PROJECT_NAME}}

{{ONE_LINER_DESCRIPTION}}

> Created by {{AUTHOR}} — {{ORGANIZATION}} — {{HOMEPAGE}}

---

## Description

{{LONGER_DESCRIPTION}}

## Stack

- {{STACK_LANGUAGE}}
- {{STACK_FRAMEWORK}}
- {{STACK_DB}}

## Installation

```bash
# 1. Cloner le repo
git clone {{REPO_URL}}
cd {{REPO_SLUG}}

# 2. Installer les dépendances
{{INSTALL_COMMAND}}

# 3. Copier la config exemple
cp .env.example .env

# 4. Lancer
{{RUN_COMMAND}}
```

## Usage

{{USAGE_EXAMPLES}}

## Structure

```txt
{{REPO_SLUG}}/
{{REPO_TREE}}
```

## Scripts

| Commande | Description |
|---|---|
| `{{SCRIPT_DEV}}` | Lance le serveur de dev |
| `{{SCRIPT_BUILD}}` | Build de production |
| `{{SCRIPT_TEST}}` | Lance les tests |

## Variables d'environnement

Voir [`.env.example`](.env.example) pour la liste complète.

| Variable | Obligatoire | Description |
|---|---|---|
| `{{ENV_VAR_1}}` | oui | {{ENV_VAR_1_DESC}} |
| `{{ENV_VAR_2}}` | non | {{ENV_VAR_2_DESC}} |

## Déploiement

Voir [`docs/deployment.md`](docs/deployment.md).

## Roadmap

Voir [`ROADMAP.md`](ROADMAP.md).

## Licence

[{{LICENSE}}](LICENSE)

## Credits

Created by **{{AUTHOR}}** — {{ORGANIZATION}}
{{HOMEPAGE}}
