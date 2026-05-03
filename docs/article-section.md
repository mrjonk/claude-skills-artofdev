# Skill 1 — repo-builder : créer des repositories GitHub propres avec Claude

*Section éditoriale prête à intégrer dans l'article publié sur jonk.space / Art of Dev.*

---

## Le problème : Claude code vite, mais pas toujours proprement

Quand on travaille avec Claude Code, on a tous fait l'expérience.
On lance une demande : *"crée-moi une petite app pour gérer mes notes"*.
Trente secondes plus tard, on a du code qui tourne.

Et puis, on regarde le dossier.

Pas de `README`. Pas de `.gitignore`. Pas de `CHANGELOG`.
Un dossier `node_modules/` énorme déjà présent.
Un fichier `.env` avec une clé API en dur dedans.
Un nom de repo qui ressemble à `my-project-final-v2-test`.

Multiplie ça par dix projets, et ton GitHub commence à ressembler à un grenier.

Le problème n'est pas Claude. Le problème est qu'on lui demande la même chose **dix fois différentes**, sans cadre. Chaque conversation repart de zéro. Chaque résultat est légèrement incohérent.

## La solution : un Claude Skill

Un **Claude Skill** est un dossier de règles, de références et de templates que Claude Code charge **automatiquement** quand le contexte s'y prête.

Concrètement : on écrit une seule fois "voici comment tu crées un repo propre chez moi", et à partir de là, **chaque** demande de création de repo respecte ces règles. Sans avoir à le redire.

C'est l'équivalent d'un *runbook* maison, mais lu et appliqué par l'IA.

## Ce que fait `repo-builder`

Le skill `repo-builder` impose un standard. Quand je demande à Claude de créer un repo, il :

- **identifie le type de projet** (statique, SaaS, mini CMS, plugin WordPress, app PHP/Node/Python, script…) ;
- **choisit la bonne structure** pour ce type ;
- **génère un `README.md` professionnel** — pas un placeholder ;
- **ajoute un `.gitignore`** adapté à la stack ;
- **prépare la documentation** : `docs/architecture.md`, `docs/deployment.md`, `docs/roadmap.md` ;
- **crée un `CHANGELOG.md`** au format Keep a Changelog ;
- **scanne le repo** pour vérifier qu'aucun secret n'est sur le point d'être commité ;
- **prépare** les commandes Git et GitHub CLI sans rien pousser sans mon accord ;
- **me rend un rapport final** : ce qui a été créé, ce qu'il reste à faire.

Et surtout, il y a des choses qu'il **ne fait pas**. Jamais. Sans accord explicite :

- supprimer un fichier existant ;
- pousser vers GitHub ;
- commiter un `.env`, un token, une clé SSH, un dump SQL ;
- créer un repo public quand on n'a pas dit "public".

## Pourquoi c'est utile pour Art of Dev

Mon workflow Art of Dev tourne autour de la création de mini CMS sectoriels (restaurant, tatoueur, coiffeur, DJ, association, boutique…). Chaque projet finit en repo, en ZIP exportable, et parfois en vidéo YouTube.

Avoir une **base de repo identique** d'un projet à l'autre change tout :

- les viewers de la chaîne reconnaissent la structure d'un projet à l'autre — c'est rassurant ;
- je peux dupliquer un projet en 10 secondes au lieu de réécrire les mêmes fichiers ;
- les exports ZIP sont propres, sans secret oublié ;
- la documentation est là, prête, dès le premier commit.

Industrialiser, ce n'est pas tuer la créativité. C'est se débarrasser des tâches qu'on n'a aucune raison de refaire à la main.

## Exemple — une demande, un repo complet

**Ma demande à Claude :**

> "Crée un repo pour un mini CMS de coiffeur. Stack PHP/SQLite, admin intégré, installateur web, exportable en ZIP. Prépare la doc et la roadmap."

**Ce que `repo-builder` produit :**

```txt
mini-cms-coiffeur/
├── README.md                # description, stack, install, structure
├── INSTALL.md               # comment lancer /install/
├── EXPORT.md                # comment générer le ZIP
├── CHANGELOG.md
├── ROADMAP.md
├── .gitignore               # .env, vendor/, *.sqlite, exports/...
├── manifest.json
├── public/
├── admin/
├── install/
├── app/
├── storage/
├── docs/
│   ├── architecture.md
│   └── deployment.md
└── tools/
    └── export-zip.sh
```

Plus un rapport :

```txt
Repo créé : oui
Type : mini CMS PHP/SQLite
Stack : PHP 8 + SQLite
Documentation : README, INSTALL, EXPORT, CHANGELOG, ROADMAP, docs/architecture, docs/deployment
.gitignore : adapté PHP + SQLite + exports
Sécurité : .env.example uniquement, aucun secret détecté
Git : initialisé, premier commit prêt (non poussé)
GitHub CLI : commandes préparées, en attente de validation
Prochaine étape : valider le push, démarrer le développement
```

## La suite

`repo-builder` est le **premier skill** d'une collection que je publie sur Art of Dev :

- **`mini-cms-builder`** — générer la base PHP/SQLite d'un mini CMS sectoriel ;
- **`video-prep`** — préparer un repo en mode screen-recording (zéro secret affiché, zéro chemin privé visible) ;
- **`zip-exporter`** — empaqueter un projet en ZIP livrable client.

Chaque skill suit la même logique : une seule fois écrit, mille fois appliqué.

Le repo complet est ici : `github.com/mrjonk/claude-skills-artofdev`

Et le code, comme toujours sur Art of Dev, est libre, MIT, à reprendre.

---

Created by **João de Almeida** — Art of Dev
https://artofdev.space
