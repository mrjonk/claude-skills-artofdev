# Exemple — Dashboard admin premium

## Contexte

Application interne de gestion de leads B2B.
Stack : Laravel 11 + Tailwind + Alpine.js.
Utilisée par 5 commerciaux + 1 admin.
Pas de billing, pas d'inscription publique.
Le dashboard actuel est fonctionnel mais visuellement plat.

## Prompt utilisateur

> *"Améliore ce dashboard admin Laravel/Vue. Je veux une interface claire, moderne, avec cards / badges / stats / filtres / empty states / responsive propre. Termes humains uniquement (pas 'endpoint', pas 'schema'). Pas de billing dans ce projet. Cherche 21st.dev catégorie Dashboard. Brief avant d'implémenter. Ne casse pas le CRUD existant."*

## Recherche d'inspiration attendue

### 21st.dev

| Catégorie | Pourquoi |
|---|---|
| Dashboard (featured + popular) | layouts admin |
| Stats cards | KPI + delta |
| Data tables | listing leads |
| Empty states | états sans données |
| Modal / Dialog | confirmations, détail lead |

### shadcn/ui

- Card, Badge, Tabs, Sheet (drawer), DataTable, Toast.

### Sites de référence

- **Linear** (project management) — densité d'info propre ;
- **Notion** (workspaces) — cards et navigation ;
- **Stripe Dashboard** — KPI + tables.

## Composants à chercher

| Composant | Source visée | Pour quoi |
|---|---|---|
| Dashboard sidebar + main | 21st.dev featured | layout principal |
| Stats card with delta | 21st.dev popular | KPI ("Leads ce mois +24%") |
| Data table with filters | 21st.dev / shadcn | liste leads |
| Empty state illustration | 21st.dev | "Aucun lead — Ajouter un premier lead" |
| Lead detail drawer | shadcn Sheet | détail rapide sans changer de page |

## Images à chercher

> Dashboard interne = peu d'images photo. Surtout des **icônes** (Lucide) et des **illustrations légères** pour les états vides.

| Emplacement | Source | Notes |
|---|---|---|
| Empty state | illustration line art | générée ou Pixabay illustrations |
| Avatar utilisateurs | initiales colorées | générées (Lucide ou avatar SVG dynamique) |

## Direction artistique

- **Densité** : compacte (dashboard interne, pas une landing) ;
- **Palette** : primary `#0f766e` (vert sapin) + accent `#f59e0b` (ambre) + neutres slate ;
- **Typographie** : Inter unique (display + body) ;
- **Spacing** : base 4 px, mais sections plus serrées (24–48 px entre blocs) ;
- **Radius** : 6 / 12 px (sobre, pas de 24) ;
- **Shadows** : `sm` uniquement (pas d'élévations dramatiques sur un dashboard) ;
- **Animations** : très subtiles, hover tables et cards uniquement.

## Termes humains (cf. CLAUDE_PROJECT_FACTORY.md §11)

À utiliser dans l'UI :

- ✅ "Tâches à faire", "Modifier le lead", "Voir les demandes", "Ajouter un commercial", "Sauvegarder", "Annuler"
- ❌ "Endpoint", "Schema", "Migration", "Configuration", "Database", "JSON", "Token"

## Résultat attendu

- 5 fichiers dans `docs/` (brief + moodboard + composants + images + design system) ;
- `resources/views/admin/` refondue ;
- `resources/css/admin.css` (variables CSS) ;
- `tailwind.config.js` adapté ;
- `app/Http/Controllers/` **non touché** (pas de cassure de logique) ;
- `routes/web.php` **non touché** (mêmes routes) ;
- `redesign-report.md` rendu.

### Score attendu

| Axe | Cible |
|---|---|
| Visuel | 75–85 |
| UX | 80–90 (axe central pour un dashboard) |
| Responsive | 80+ (desktop priorité, tablet OK, mobile en lecture seule acceptable) |
| Accessibilité | 80+ |
| Cohérence | 85+ |
| Premium feel | 75+ |
| **Global** | **80+** |

## Erreurs à éviter

- **trop d'animations** sur un dashboard pro (parasite) ;
- **icônes décoratives** sans signification ;
- **gros boutons partout** (un dashboard n'est pas une landing) ;
- **sections marketing** sur le dashboard (zéro hero, zéro testimonials) ;
- **termes techniques visibles** ("Update lead record" → "Modifier le lead") ;
- **casser le CRUD** ou la gestion des permissions ;
- **changer les routes** existantes (impactant les bookmarks utilisateurs).

## Checklist finale

- [ ] design-brief rempli
- [ ] composants documentés (5+)
- [ ] design-system rendu
- [ ] sidebar + main responsive (drawer mobile)
- [ ] stats cards 4 KPI minimum
- [ ] data table avec recherche debounced + pagination
- [ ] filtres conservés dans l'URL
- [ ] empty states sur **toutes** les listes
- [ ] confirmations modal sur actions destructives
- [ ] focus visible au clavier
- [ ] termes humains partout (audit manuel)
- [ ] CRUD existant non cassé
- [ ] routes existantes intactes
- [ ] redesign-report.md rendu

---

Created by João de Almeida — Art of Dev — https://artofdev.space
