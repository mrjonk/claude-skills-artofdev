# Architecture — {{PROJECT_NAME}}

> Document technique. Public cible : développeurs intervenant sur le projet.

---

## Vue générale

{{ARCHITECTURE_SUMMARY}}

```txt
[Schéma ASCII ou description textuelle des composants principaux]

      ┌──────────┐       ┌───────────┐
      │ Frontend │ <───> │  Backend  │ <───> [DB]
      └──────────┘       └───────────┘
                              │
                              ▼
                          [Services
                           externes]
```

---

## Stack

- **Langage(s) :** {{LANGUAGES}}
- **Framework(s) :** {{FRAMEWORKS}}
- **Base de données :** {{DATABASE}}
- **Services externes :** {{EXTERNAL_SERVICES}}
- **Dépendances clés :** {{KEY_DEPS}}

---

## Structure des dossiers

```txt
{{REPO_TREE_DETAILED}}
```

Détail des dossiers principaux :

| Dossier | Rôle |
|---|---|
| `src/` (ou équivalent) | Code applicatif |
| `public/` | Fichiers statiques exposés |
| `docs/` | Documentation technique |
| `tests/` | Tests automatisés |
| `tools/` | Scripts de maintenance |

---

## Modules

### {{MODULE_1_NAME}}

- **Rôle :** {{MODULE_1_ROLE}}
- **Dépendances :** {{MODULE_1_DEPS}}
- **Interfaces :** {{MODULE_1_INTERFACES}}

### {{MODULE_2_NAME}}

- **Rôle :** {{MODULE_2_ROLE}}
- **Dépendances :** {{MODULE_2_DEPS}}
- **Interfaces :** {{MODULE_2_INTERFACES}}

---

## Données

### Modèle

{{DATA_MODEL_DESCRIPTION}}

| Entité | Champs principaux | Notes |
|---|---|---|
| `{{ENTITY_1}}` | `id`, `{{FIELDS}}` | {{NOTES}} |
| `{{ENTITY_2}}` | `id`, `{{FIELDS}}` | {{NOTES}} |

### Stockage

- **DB principale :** {{DB_TYPE}}
- **Cache :** {{CACHE}}
- **Fichiers / médias :** {{MEDIA_STORAGE}}

---

## Sécurité

- **Authentification :** {{AUTH_METHOD}}
- **Autorisation :** {{AUTHZ_METHOD}}
- **Validation des entrées :** {{INPUT_VALIDATION}}
- **Gestion des secrets :** variables d'environnement uniquement (jamais en dur) ;
- **Protection CSRF :** {{CSRF}}
- **Rate-limiting :** {{RATE_LIMIT}}
- **HTTPS obligatoire en prod :** oui.

---

## Déploiement

Voir [`deployment.md`](deployment.md).

---

Created by {{AUTHOR}} — {{ORGANIZATION}} — {{HOMEPAGE}}
