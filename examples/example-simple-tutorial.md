# Exemple — Tutoriel simple

## Contexte

Tutoriel pour développeurs débutants.
Sujet générique réutilisable : *"Installer Node.js sur Windows, macOS et Linux"*.
Public : débutants en développement web.

## Prompt utilisateur

> *"Rédige un tutoriel simple pour installer Node.js sur Windows, macOS et Linux. Public : développeurs débutants. Ton : tutoriel débutant (simple, direct, étape par étape, accessible, rassurant). Longueur : 1200 mots. Prérequis explicites, étapes numérotées par OS, vérification après chaque étape, erreurs courantes (3+), FAQ (3-5), captures d'écran à prévoir, sources doc officielle, score qualité éditoriale."*

## Angle éditorial attendu

- **Pour vrais débutants** : ne pas supposer qu'ils savent ouvrir un terminal ;
- **Rassurant** : reconnaître les points qui peuvent bloquer ("si vous voyez l'erreur X, c'est normal") ;
- **Concret** : commandes exactes, captures, résultats attendus ;
- **Non condescendant** : on explique, on ne traite pas le lecteur de débile.

## Structure attendue (HowTo)

| Section | Contenu |
|---|---|
| H1 | "Installer Node.js : guide pour Windows, macOS et Linux" |
| Introduction (3 phrases) | qui c'est, ce qu'on va installer, pourquoi |
| Prérequis | minimal (ordinateur connecté à internet, droits admin si Windows) |
| H2 — Étape 1 — Choisir la version | LTS vs Current, avec recommandation |
| H2 — Étape 2 — Installer sur Windows | étapes + captures + commandes vérification |
| H2 — Étape 3 — Installer sur macOS | étapes + commandes (Homebrew ou installer officiel) |
| H2 — Étape 4 — Installer sur Linux | étapes (Ubuntu / Debian, Fedora, Arch) |
| H2 — Vérification finale | `node -v`, `npm -v`, output attendu |
| H2 — Erreurs courantes | "command not found", PATH, version Windows ARM |
| H2 — FAQ | 4 questions de débutant |
| H2 — Pour aller plus loin | tutoriels suivants |
| Sources | doc officielle Node.js |
| Conclusion | invitation au prochain tutoriel |

## SEO attendu

- **title** : *"Installer Node.js : guide pour Windows, macOS et Linux"* (54 car.) ;
- **meta description** : *"Tutoriel pas à pas pour installer Node.js sur Windows, macOS et Linux. Vérifications, erreurs courantes, FAQ pour débutants."* (140 car.) ;
- **slug** : `installer-nodejs-tutoriel` ;
- **mot-clé principal** : *"installer Node.js"* ;
- **schema_type** : `HowTo` ;
- **search_intent** : tutoriel.

## Exemples concrets à inclure

- **Commandes exactes** par OS :
  ```bash
  # Windows (via installer .msi puis vérification)
  node -v

  # macOS (via Homebrew)
  brew install node
  node -v

  # Ubuntu / Debian
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  sudo apt install -y nodejs
  node -v
  ```
- **Output attendu** après chaque commande (ex : `v20.10.0`).
- **Captures d'écran** prévues : installer Windows, fenêtre Terminal macOS, terminal Ubuntu.

## Liens internes possibles

| # | Slug cible | Ancre | Raison |
|---|---|---|---|
| 1 | `/blog/premiers-pas-javascript` | "premiers pas en JavaScript" | suite logique |
| 2 | `/blog/installer-vscode` | "installer VS Code" | environnement de dev complet |
| 3 | `/blog/git-pour-debutants` | "Git pour débutants" | suite naturelle |
| 4 | `/docs/glossaire-dev` | "glossaire des termes techniques" | si débutant absolu |

## Images recommandées

| Slot | Description | Style |
|---|---|---|
| Hero | Logo Node.js sur fond clair OU capture du terminal après install | photo / screenshot |
| Étape Windows | Capture de l'installer Node.js sur Windows | screenshot |
| Étape macOS | Capture du Terminal macOS avec `node -v` | screenshot |
| Étape Linux | Capture du terminal Ubuntu | screenshot |
| Erreur "command not found" | Capture de l'erreur dans le terminal | screenshot |

## Sources nécessaires

- Node.js. *"Downloads"*. https://nodejs.org/en/download (consulté le YYYY-MM-DD).
- Node.js. *"Installation guide"*. https://nodejs.org/en/learn/getting-started/how-to-install-nodejs (consulté).
- Documentation Homebrew (pour macOS) : https://brew.sh.
- NodeSource. *"Installation instructions"* (pour Linux) : https://github.com/nodesource/distributions.

## Erreurs à éviter

- **introduction "qu'est-ce que Node.js ? Une définition complète..."** sur 400 mots → le public veut **installer**, pas une dissertation ;
- **supposer que le lecteur sait ce qu'est un terminal** → l'expliquer brièvement ou pointer vers une ressource ;
- **commandes non testées** copiées d'une source douteuse ;
- **versions périmées** (toujours préciser la version LTS du moment) ;
- **erreurs courantes inventées** → utiliser des erreurs **réellement** vues dans des forums ;
- **CTA générique** *"Continuez sur notre blog !"* → préférer un tutoriel spécifique suivant.

## Score qualité attendu

**80–88 / 100** — Bon contenu SEO. Idéal pour SEO long-tail (`installer node.js windows`, `installer nodejs ubuntu`, etc.).

---

Created by João de Almeida
