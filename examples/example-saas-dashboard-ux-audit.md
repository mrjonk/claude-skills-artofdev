# Exemple — Audit UX d'un dashboard SaaS

## Contexte

Dashboard SaaS de gestion de projet. Stack : React + Vite + Tailwind + shadcn/ui + tRPC.
~15 pages d'admin / dashboard (projets, tâches, équipe, paramètres, billing, intégrations).

## Demande originale

> *"Audit UX du dashboard SaaS. Vérifie cohérence sidebar, états vides, confirmations, filtres / recherche / pagination, cohérence design system, responsive. Mode : audit + corrections sûres."*

## Analyse attendue

### Pages détectées

- `/dashboard` (overview) ;
- `/projects`, `/projects/[id]` ;
- `/tasks`, `/tasks/[id]` ;
- `/team`, `/team/[userId]` ;
- `/integrations` ;
- `/settings`, `/settings/billing`, `/settings/notifications` ;
- `/account/profile`, `/account/security`.

### Layout

- `app/components/DashboardLayout.tsx` : sidebar + topbar + main ;
- utilisé par toutes les pages dashboard.

## Fichiers à inspecter

- `app/components/DashboardLayout.tsx`
- `app/components/Sidebar.tsx`
- `app/components/Topbar.tsx`
- `app/projects/page.tsx`, `app/projects/[id]/page.tsx`
- `app/tasks/page.tsx`, `app/tasks/[id]/page.tsx`
- `app/components/EmptyState.tsx`
- `app/components/Pagination.tsx`
- `app/components/SearchInput.tsx`
- `app/components/FilterBar.tsx`

## Problèmes typiques détectés

### Sidebar

- **présente** sur toutes les pages dashboard ✓ ;
- **active state** via `usePathname()` ✓ ;
- icônes Lucide cohérentes ✓ ;
- collapsible mobile (drawer) ✓ ;
- groupement logique (Espace / Données / Compte) ✓.

→ **OK**.

### États vides

| Page | État vide ? |
|---|---|
| `/projects` (sans projets) | ✓ ("Pas encore de projet — Créer votre premier projet") |
| `/tasks` (sans tâches) | **✗ manque** |
| `/team` (sans membres) | ✓ |
| `/integrations` (aucune connectée) | ✓ |
| `/settings/billing` (pas d'abonnement) | **✗ manque** |

→ 2 états vides à ajouter.

### Confirmations sur actions destructives

| Action | Confirmation ? |
|---|---|
| Supprimer projet | ✓ modal |
| Supprimer tâche | **✗ pas de modal** — suppression directe |
| Retirer membre de l'équipe | ✓ modal |
| Annuler abonnement | ✓ modal + typage du mot "ANNULER" |
| Déconnexion | ✓ confirmation simple |

→ **1 confirmation manquante** sur la suppression de tâche.

### Filtres / recherche / pagination

| Liste | Recherche | Filtres | Pagination |
|---|---|---|---|
| `/projects` | ✓ debounced 300 ms | ✓ par statut, par membre | ✓ |
| `/tasks` | ✓ | ✓ | **✗ manque** (toutes les tâches affichées) |
| `/team` | ✓ | ✗ pas pertinent | n/a (peu de membres) |

→ **Pagination manquante** sur `/tasks` (potentiel problème si > 100 tâches).

### Cohérence design system

- **boutons** : 3 variantes (primary / outline / ghost) cohérentes ;
- **cards** : radius identique partout (8 px), padding 16 ou 24 px selon contexte ;
- **badges** : couleurs sémantiques OK ;
- **typographie** : Inter unique, échelle géométrique (12 / 14 / 16 / 18 / 24 / 30 / 36 px).

→ **OK**.

### Responsive

- **sidebar** drawer mobile fonctionnelle ;
- **tables** : `/tasks` table déborde sur 320 px (overflow horizontal sans gradient indicateur) ;
- **cards** : empilées correctement.

→ **1 problème responsive** sur `/tasks`.

### Termes humains UI

Détection :

```bash
grep -rIE 'endpoint|schema|JSON|payload' app/
```

- `app/integrations/page.tsx:24` : *"API endpoint URL"* dans une description visible.

→ Reformuler en *"URL de votre API"*.

### Sécurité basique

- routes dashboard protégées (middleware d'auth) ✓ ;
- pas de routes debug visibles ✓ ;
- billing protégé ✓.

→ **OK**.

## Corrections sûres (Mode 2)

- [ ] ajouter état vide à `/tasks` (réutiliser `<EmptyState />`) ;
- [ ] ajouter état vide à `/settings/billing` ;
- [ ] reformuler `app/integrations/page.tsx:24` *"API endpoint URL"* → *"URL de votre API"*.

## Corrections à valider

- [ ] ajouter modal de confirmation sur suppression de tâche ;
- [ ] ajouter pagination sur `/tasks` (50 par défaut, sélecteur 25 / 50 / 100) ;
- [ ] fixer overflow horizontal de la table `/tasks` mobile (gradient ou conversion en cards).

## Score cohérence attendu

- **Navigation** : 14 / 15 ;
- **États** : 7 / 10 (2 états vides manquants) ;
- **Confirmations** : 8 / 10 (1 manquante) ;
- **Filtres / recherche / pagination** : 7 / 10 (pagination manquante sur /tasks) ;
- **Front / admin** : N/A (entièrement admin) ;
- **Responsive** : 8 / 10 (table déborde) ;
- **Sécurité basique** : 9 / 10 ;
- **Total cohérence** : ~83 / 100.

## Score visuel attendu

- **85–88 / 100** (design system shadcn discipliné, bonne base).

## Rapport final attendu

```markdown
# Final coherence report — Dashboard SaaS

Score cohérence : 83 / 100
Score visuel : 87 / 100
Verdict : Cohérent et publiable

Top 3 actions :
1. Ajouter modal de confirmation sur suppression de tâche.
2. Ajouter pagination sur /tasks (potentiel problème si volume > 100).
3. Compléter les 2 états vides manquants (/tasks, /settings/billing).

Corrections appliquées (Mode 2) :
- état vide /tasks ajouté ;
- état vide /settings/billing ajouté ;
- reformulation "API endpoint URL" → "URL de votre API".

Délégations :
- production-auditor : recommandé pour validation finale (sécurité, billing, déploiement).
- premium-webdesigner : non nécessaire (design system solide).
```

---

Created by João de Almeida
