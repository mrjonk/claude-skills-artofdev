# Comment utiliser le skill `repo-builder`

## 1. Installation

Une seule fois, après avoir cloné ce repo :

```bash
bash install.sh
```

Le skill est copié dans `~/.claude/skills/repo-builder/`. Claude Code le détecte automatiquement à la prochaine session.

Pour vérifier :

```bash
ls ~/.claude/skills/repo-builder/SKILL.md
```

## 2. Activation automatique

Le skill s'active **automatiquement** dès que ta demande à Claude correspond à sa description (création, initialisation ou structuration d'un repo).

Tu n'as **rien** à taper de spécial. Pas de `/repo-builder`. Pas de mention de skill dans le prompt.

Si Claude détecte que ta demande matche, il charge `SKILL.md` en contexte et applique les règles.

## 3. Prompts qui déclenchent le skill

Tous ces prompts activent `repo-builder` :

- *"Crée un repo propre pour un site statique de portfolio."*
- *"Initialise un repo Node/Next pour une app SaaS de gestion de tâches."*
- *"Prépare un repo plugin WordPress pour un widget de réservation."*
- *"Crée un repo Python/FastAPI pour une API d'envoi d'emails."*
- *"Démarre un repo pour un mini CMS de coiffeur."*
- *"Setup a clean repo for a documentation-only project."*

Variantes utiles pour préciser :

- *"... en privé sur GitHub."* → repo privé.
- *"... avec déjà la structure pour Stripe."* → variables d'env Stripe en placeholder.
- *"... sans push, je veux valider d'abord."* → git init + commit local uniquement.

## 4. Ce que tu obtiens

À chaque utilisation, le skill produit :

1. **La structure de dossiers** adaptée au type de projet ;
2. **Un `README.md`** clair (titre, description, install, usage, structure, scripts, env, déploiement, roadmap, credits) ;
3. **Un `.gitignore`** adapté à la stack ;
4. **Un `CHANGELOG.md`** au format Keep a Changelog ;
5. **Un `ROADMAP.md`** ou équivalent ;
6. **Un dossier `docs/`** avec `architecture.md` et `deployment.md` selon le projet ;
7. **Un audit sécurité** (aucun secret détecté avant commit) ;
8. **Les commandes Git/GitHub CLI** prêtes — mais non exécutées sans ton accord ;
9. **Un rapport final** synthétique.

## 5. Validation manuelle requise

Le skill **ne pousse jamais** vers GitHub sans accord explicite.

À la fin, Claude te montrera quelque chose comme :

```bash
# Commandes prêtes — confirme avant exécution :
gh repo create mon-projet --public --source=. --remote=origin --push
```

Tu valides, ou tu adaptes (`--private`, autre nom, etc.).

## 6. Mise à jour du skill

Quand le repo `claude-skills-artofdev` est mis à jour :

```bash
cd /chemin/vers/claude-skills-artofdev
git pull
bash install.sh
```

L'ancienne version du skill est **automatiquement sauvegardée** dans `~/.claude/skills/.backup/repo-builder-YYYYMMDD-HHMMSS/`.

## 7. Désinstallation

```bash
bash uninstall.sh
```

Le skill est sauvegardé puis retiré. Aucun autre skill n'est touché.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
