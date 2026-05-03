# Navigation report — {{PROJECT_NAME}}

> Rapport sur tous les menus du site.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Stack** : {{ex: Next.js 14}}
- **Mode** : {{audit-only}}

---

## Menus détectés

| Menu | Fichier source | Pages couvertes | Liens (nb) | Mobile OK | Active state | Liens morts | Doublons |
|---|---|---|---|---|---|---|---|
| Header desktop | `app/components/Header.tsx` | toutes publiques | 5 | oui | oui | 0 | 0 |
| Header mobile | `app/components/MobileMenu.tsx` | toutes publiques | 5 | oui | oui | 0 | 0 |
| Sidebar admin | `app/admin/components/Sidebar.tsx` | toutes admin | 6 | drawer | oui | 0 | 0 |
| Profil dropdown | `app/components/UserDropdown.tsx` | post-auth | 3 | oui | n/a | 0 | 0 |
| Footer nav | `app/components/Footer.tsx` | toutes publiques | 12 | colonnes | n/a | 1 | 0 |
| Switch langue | `app/components/LanguageSwitch.tsx` | toutes publiques | 2 (fr/en) | oui | oui | 0 | 0 |

---

## Détail menu desktop

### Source

`app/components/Header.tsx`

### Liens

| # | Libellé | Route | Statut |
|---|---|---|---|
| 1 | Accueil | `/` | OK |
| 2 | À propos | `/about` | OK |
| 3 | Tarifs | `/pricing` | OK |
| 4 | Blog | `/blog` | OK |
| 5 | Contact | `/contact` | OK |

CTA primaire : *"Commencer"* → `/register`.

### Cohérence avec footer

- les 5 liens du menu sont **présents** dans le footer ;
- le footer ajoute : Mentions / RGPD / CGV / sociaux.

### Cohérence mobile

- mêmes 5 liens dans `MobileMenu.tsx` ;
- même ordre ;
- même CTA primaire en bas du drawer.

### Cohérence multilingue

- {{si applicable, vérifier que les libellés sont traduits}} ;
- {{vérifier que `/en/about`, `/en/pricing`, etc. existent}}.

---

## Détail sidebar admin

### Source

`app/admin/components/Sidebar.tsx`

### Liens

| # | Libellé | Route | Icône |
|---|---|---|---|
| 1 | Dashboard | `/admin` | LayoutDashboard |
| 2 | Utilisateurs | `/admin/users` | Users |
| 3 | Commandes | `/admin/orders` | ShoppingBag |
| 4 | Contenu | `/admin/content` | FileText |
| 5 | Paramètres | `/admin/settings` | Settings |
| 6 | Déconnexion | `/logout` | LogOut |

### Cohérence

- toutes les pages admin ont la sidebar **présente** ;
- icônes **toutes** de la même famille (Lucide) ;
- **active state** clair (fond légèrement coloré + bordure gauche).

---

## Problèmes détectés

### Liens morts

| Lien | Trouvé dans | Recommandation |
|---|---|---|
| `/old-blog` | `Footer.tsx:42` | retirer du footer (page n'existe plus) |

### Doublons hardcodés

Aucun détecté. Tous les menus utilisent des composants partagés.

→ Si menus hardcodés détectés, lister :

```
| Fichier | Lignes | Recommandation |
|---|---|---|
| `pages/old-home.html:120-145` | 25 lignes | extraire dans composant partagé |
| ... | ... | ... |
```

### Incohérences mobile / desktop

Aucune détectée. Vérifié sur 4 breakpoints.

→ Si incohérence, lister :

```
| Élément | Desktop | Mobile | Recommandation |
|---|---|---|---|
| Lien "Pricing" | présent | absent | ajouter dans MobileMenu.tsx |
```

### Active state

OK partout. Implémenté via `usePathname()` (Next App Router).

---

## Recommandations

### Mode 2 — Corrections sûres possibles

- [ ] retirer le lien `/old-blog` du footer ;
- [ ] ajouter `aria-current="page"` sur les liens actifs (accessibilité).

### Mode 3 — À valider

- {{ex: créer un menu mega-menu si > 5 items}} ;
- {{ex: ajouter un menu utilisateur dropdown}}.

### Délégation à `premium-webdesigner`

- aucune nécessaire si seule la cohérence est en cause.

---

## Score navigation

**{{X / 100}}** — {{Verdict}}

| Critère | Score |
|---|---|
| Présence sur toutes les pages attendues | {{X / 15}} |
| Cohérence libellés | {{X / 10}} |
| Cohérence mobile / desktop | {{X / 15}} |
| Active state | {{X / 10}} |
| Cohérence multilingue | {{X / 10}} |
| Aucun lien mort | {{X / 15}} |
| Pas de doublons hardcodés | {{X / 15}} |
| Pas de liens admin dans le menu public | {{X / 10}} |

---

## Prochaine étape

> {{Une phrase actionnable.}}

---

Created by João de Almeida
