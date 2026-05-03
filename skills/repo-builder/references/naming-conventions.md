# Conventions de nommage

Comment nommer un repo, un dossier, un fichier ou un slug, dans le contexte `repo-builder`.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. Nom du repository

### Règles

- **Slug** : minuscules, séparateur `-`, ASCII pur.
- **Pas d'espaces.**
- **Pas d'accents** (`é`, `è`, `ç`, `à` → `e`, `e`, `c`, `a`).
- **Pas de majuscules.**
- **Pas de underscore** (préférer `-`).
- **Court** : 3 à 5 mots maximum.
- **Descriptif** : on doit comprendre le projet en lisant le nom.

### Bons exemples

```txt
mini-cms-coiffeur
saas-task-manager
wp-booking-widget
pixabay-fetcher
artofdev-portfolio
claude-skills-artofdev
```

### Mauvais exemples

```txt
My Project              # espaces
mon_projet              # underscore
PROJECT-FINAL           # majuscules
projet-éééé             # accents
test                    # trop flou
app                     # trop générique
my-project-final-v2     # bricolage
new-app                 # vide de sens
```

### Préfixes utiles

| Préfixe | Usage |
|---|---|
| `mini-cms-` | mini CMS sectoriel |
| `wp-` | plugin ou thème WordPress |
| `saas-` | application SaaS |
| `cli-` | outil ligne de commande |
| `api-` | API standalone |
| `bot-` | bot (Discord, Slack, etc.) |
| `claude-skills-` | collection de skills Claude |
| `artofdev-` | projet maison Art of Dev |

---

## 2. Branches Git

- `main` — par défaut.
- `develop` — intégration (optionnel).
- `feature/<slug>` — `feature/auth-google`, `feature/dashboard-stats`.
- `fix/<slug>` — `fix/login-redirect`, `fix/menu-mobile`.
- `chore/<slug>` — `chore/update-deps`, `chore/cleanup-readme`.
- `docs/<slug>` — `docs/architecture-update`.

---

## 3. Messages de commit

Format **Conventional Commits** :

```txt
<type>: <description courte>

[corps optionnel]

[footer optionnel]
```

Types autorisés : `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `init`.

### Bons exemples

```txt
feat: ajouter le dashboard admin avec stats
fix: corriger le login admin sur Safari
docs: ajouter la section déploiement Nginx
chore: mise à jour de phpmailer
init: scaffolding via repo-builder skill
```

### Mauvais exemples

```txt
update                  # vide
WIP                     # à éviter sur main
fixes                   # imprécis
final version           # n'existe pas
asdf                    # ...
```

---

## 4. Dossiers et fichiers

### Dossiers

- minuscules, `-` séparateur ;
- éviter les abréviations cryptiques ;
- préférer `documentation/` > `docs/` (mais `docs/` est devenu standard, OK).

### Fichiers de code

| Stack | Convention |
|---|---|
| PHP | `kebab-case.php` ou `PascalCase.php` pour classes (PSR-1/4) |
| JavaScript / TypeScript | `kebab-case.ts` ou `camelCase.ts` |
| React composants | `PascalCase.tsx` (`UserCard.tsx`) |
| Python | `snake_case.py` |
| Bash | `kebab-case.sh` |
| Markdown | `kebab-case.md` ou `MAJUSCULES.md` (`README.md`, `LICENSE`, `CHANGELOG.md`) |

### Fichiers spéciaux (toujours en majuscules)

```txt
README.md
LICENSE
CHANGELOG.md
ROADMAP.md
CONTRIBUTING.md
CODE_OF_CONDUCT.md
SECURITY.md
INSTALL.md
EXPORT.md
```

---

## 5. Variables d'environnement

- toujours `SCREAMING_SNAKE_CASE` ;
- préfixe par domaine (`STRIPE_`, `PIXABAY_`, `AWS_`, `DB_`) ;
- jamais d'espaces, accents, `-`, ni guillemets autour des valeurs simples.

### Bons exemples

```env
STRIPE_PUBLIC_KEY=
STRIPE_SECRET_KEY=
PIXABAY_API_KEY=
DB_PATH=storage/database.sqlite
APP_DEBUG=false
```

---

## 6. Slug d'un nouveau Claude Skill

Pour la cohérence avec le reste des skills Art of Dev :

- minuscules, `-` ;
- 1 à 3 mots ;
- nom **fonctionnel** (ce que ça fait) ;
- éviter les abréviations.

### Bons exemples

```txt
repo-builder
mini-cms-builder
video-prep
zip-exporter
seo-audit
```

### Mauvais exemples

```txt
RepoBuilder              # PascalCase
repo_builder             # underscore
repo-builder-skill       # redondant
rb                       # cryptique
the-greatest-repo-builder-ever-made   # trop long
```

---

Created by João de Almeida — Art of Dev — https://artofdev.space
