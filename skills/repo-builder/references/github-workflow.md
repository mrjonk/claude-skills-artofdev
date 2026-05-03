# Workflow Git / GitHub recommandé

Ce document décrit les commandes que `repo-builder` doit utiliser, dans quel ordre, et avec quels avertissements de sécurité.

⚠️ **Aucune commande de cette page n'est exécutée automatiquement.**
Le skill prépare et propose. L'utilisateur valide.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. Préparation locale

```bash
# 1. Créer le dossier et entrer dedans
mkdir -p <slug>
cd <slug>

# 2. Initialiser Git (branche main par défaut)
git init -b main

# 3. Vérifier la config globale
git config --global --get user.name
git config --global --get user.email
```

Si `user.name` ou `user.email` ne sont pas configurés, **demander** à l'utilisateur avant de continuer.

---

## 2. Création des fichiers

Créer **avant** le premier `git add` :

- `.gitignore` (CRITIQUE — éviter les commits accidentels) ;
- `README.md` ;
- `LICENSE` ;
- les fichiers de structure (cf. `repo-structure-guide.md`).

> **Toujours** créer `.gitignore` **avant** de générer du code qui pourrait produire `node_modules/`, `vendor/`, `.venv/`, etc.

---

## 3. Audit sécurité avant commit

```bash
bash skills/repo-builder/scripts/check-repo-safety.sh .
```

Si l'audit alerte, **stopper**. Lister les fichiers, demander à l'utilisateur.

---

## 4. Premier commit

```bash
# Vérifier ce qu'on va commiter
git status
git diff --stat

# Stage explicite — JAMAIS git add -A en aveugle
git add README.md CHANGELOG.md ROADMAP.md LICENSE .gitignore docs/ <…>

# Premier commit
git commit -m "init: scaffolding via repo-builder skill"
```

**À éviter :**
- `git add -A` ou `git add .` sans avoir vu `git status` au préalable ;
- `git commit -am` (raccourci dangereux qui peut inclure des fichiers non vus).

**À ne jamais faire :**
- `git commit --no-verify` (sauter les hooks) ;
- `git commit --no-gpg-sign` si l'utilisateur signe ses commits.

---

## 5. Création du repo distant via `gh`

```bash
# Vérifier que gh est connecté
gh auth status

# Pour un repo PRIVÉ (par défaut)
gh repo create <slug> --private --source=. --remote=origin

# Pour un repo PUBLIC (uniquement si demandé explicitement)
gh repo create <slug> --public --source=. --remote=origin
```

> **Ne pas** ajouter `--push` automatiquement.
> **Demander** à l'utilisateur avant de pousser.

---

## 6. Premier push

```bash
git push -u origin main
```

**Après validation explicite uniquement.**

Vérifier ensuite :

```bash
git remote -v
gh repo view --web    # ouvre la page du repo dans le navigateur
```

---

## 7. Branches conventionnelles

Pour les projets multi-branches :

- `main` — branche stable, jamais cassée ;
- `develop` (optionnel) — intégration ;
- `feature/<slug>` — nouvelle feature ;
- `fix/<slug>` — correctif ;
- `chore/<slug>` — maintenance.

Convention de commit (Conventional Commits) :

- `feat:` nouvelle fonctionnalité ;
- `fix:` correctif ;
- `docs:` documentation seule ;
- `style:` formatage, pas de logique ;
- `refactor:` refactor sans changement comportemental ;
- `test:` tests ;
- `chore:` maintenance, build, deps ;
- `init:` premier commit (variante perso utilisée par `repo-builder`).

---

## 8. Erreurs fréquentes à signaler à l'utilisateur

| Erreur | Cause typique | Solution |
|---|---|---|
| `gh: command not found` | gh non installé | `sudo apt install gh` (Debian/Ubuntu) ou installation officielle |
| `error: failed to push some refs` | la branche distante a divergé | `git pull --rebase origin main` |
| `Permission denied (publickey)` | clé SSH non enregistrée sur GitHub | `gh auth login` ou ajouter la clé dans Settings > SSH keys |
| `fatal: The current branch main has no upstream` | premier push sans `-u` | `git push -u origin main` |
| `nothing to commit, working tree clean` | rien n'a changé OU les fichiers sont dans `.gitignore` | vérifier `.gitignore` |

---

## 9. Workflow protégé pour repos publics Art of Dev

Si le repo est public (ex : `claude-skills-artofdev`) :

- jamais de `force push` sur `main` ;
- toujours passer par une PR si plusieurs contributeurs ;
- protéger `main` côté GitHub : *Require a pull request before merging* ;
- ne pas désactiver les workflows GitHub Actions sans accord ;
- vérifier que les secrets nécessaires aux Actions sont en *Settings > Secrets*, pas dans le repo.

---

## 10. Commandes interdites par défaut

(Reprises de `SKILL.md` §10 pour rappel.)

```bash
git push --force                         # interdit
git reset --hard <ref>                   # interdit en mode skill
git clean -fd                            # interdit
gh repo delete <slug>                    # interdit
gh repo edit --visibility public         # interdit sur repo existant
rm -rf <chemin>                          # interdit sauf chemin temporaire validé
```

---

Created by João de Almeida — Art of Dev — https://artofdev.space
