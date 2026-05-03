# File change plan — {{PROJECT_NAME}}

> Plan détaillé des fichiers à modifier, raisons, impact et risques.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Mode** : {{audit-only / corrections sûres / plan de refonte}}

---

## Résumé

- **Total fichiers à modifier** : {{N}}
- **Fichiers en Mode 2** (corrections sûres autorisées) : {{N}}
- **Fichiers nécessitant validation** : {{N}}

---

## Fichiers à modifier — détail

### Mode 2 — Corrections sûres (validation non requise)

| # | Fichier | Modification | Impact (pages) | Risque | Annulable par |
|---|---|---|---|---|---|
| 1 | `app/contact/page.tsx` | ajout du `<title>` manquant | uniquement /contact | aucun | `git revert` |
| 2 | `app/components/Header.tsx` | ajout `aria-current="page"` sur lien actif | toutes pages publiques | aucun | `git revert` |
| 3 | `app/components/Footer.tsx` | retrait du lien `/old-blog` (404) | toutes pages publiques | aucun (lien mort de toute façon) | `git revert` |
| 4 | `app/about/page.tsx` | correction typo "developpeur" → "développeur" | uniquement /about | aucun | `git revert` |
| 5 | `app/services/page.tsx` | ajout `alt` non vide sur image hero | uniquement /services | aucun | `git revert` |

### Mode 3 — Validation requise

| # | Fichier | Modification | Impact (pages) | Risque | Validation |
|---|---|---|---|---|---|
| 6 | `app/components/Header.tsx` | refonte du menu (passage de 3 à 5 items) | toutes pages publiques | moyen (impact UX visible) | **OUI** |
| 7 | `app/admin/components/Sidebar.tsx` | ajout d'une nouvelle section "Reports" | toutes pages admin | moyen | **OUI** |
| 8 | `tailwind.config.js` | ajout d'une couleur d'accent | toutes pages | élevé (visible partout) | **OUI** |
| 9 | `app/layout.tsx` | wrap du body avec un nouveau provider | toutes pages | **élevé** | **OUI + tests** |
| 10 | `routes/web.php` (Laravel) | ajout d'une nouvelle route `/api/notifications` | API | moyen | **OUI** |

### Refacto à proposer (jamais en Mode 2)

| # | Fichier source 1 | Fichier source 2 | Action proposée | Validation |
|---|---|---|---|---|
| 11 | `Header.tsx` | `HeaderV2.tsx` | consolider en `Header.tsx`, migrer les usages, supprimer V2 | **OUI** + plan de migration phasé |
| 12 | `pages/about.html` | hardcoded menu | extraire menu dans `partials/header.html` | **OUI** + tests sur 5+ pages |

---

## Fichiers à NE PAS toucher

| Fichier | Raison |
|---|---|
| `node_modules/**` | dépendances |
| `dist/`, `build/`, `.next/` | générés |
| `.env`, `.env.production` | secrets |
| `wp-config.php` (WP) | secrets DB |
| `package-lock.json` | géré automatiquement |
| `vendor/**` | dépendances Composer |
| Fichiers `.min.js`, `.min.css` | minifiés (modifier les sources) |

---

## Tests post-modification

Pour chaque modification, prévoir :

| # | Fichier modifié | Test |
|---|---|---|
| 1 | `app/contact/page.tsx` | recharger /contact, vérifier le `<title>` dans l'onglet |
| 2 | `app/components/Header.tsx` | naviguer entre 3 pages, vérifier que `aria-current` change |
| 3 | `app/components/Footer.tsx` | vérifier que le lien `/old-blog` n'existe plus dans le footer |
| 6 | refonte menu | tester sur 4 breakpoints (320 / 768 / 1024 / 1440) + vérifier mobile |
| 8 | nouvelle couleur d'accent | inspecter le rendu sur 5+ pages (home, internes, admin) |

---

## Rollback

Toutes les modifications **Mode 2** sont annulables par un `git revert <commit>`.

Pour les modifications **Mode 3**, prévoir un commit dédié par modification (rollback granulaire).

---

## Workflow recommandé

1. **Lister** les modifications (ce template).
2. **Discuter** avec l'utilisateur les modifications Mode 3 / refacto.
3. **Appliquer** les Mode 2 dans un commit dédié (`fix(ux): <description>`).
4. **Appliquer** les Mode 3 validés dans des commits séparés.
5. **Tester** chaque commit individuellement.
6. **Rendre** le rapport final.

---

## Prochaine étape

> {{Une phrase actionnable.}}

---

Created by João de Almeida
