# Exemple — Cohérence front / admin

## Contexte

SaaS Next.js avec partie publique (landing + blog) et dashboard admin.
Stack : Next.js 14 + Tailwind + shadcn/ui + Prisma.

## Demande originale

> *"Audit cohérence entre site public et admin. Vérifie séparation, protection des pages admin, navigation, états vides, termes humains. Mode : audit only."*

## Analyse attendue

### Pages détectées

- public : `/`, `/pricing`, `/blog`, `/blog/[slug]`, `/contact`, `/about` ;
- auth : `/login`, `/register`, `/forgot-password` ;
- admin : `/admin`, `/admin/users`, `/admin/orders`, `/admin/settings`, `/admin/content` ;
- compte utilisateur : `/account`, `/account/billing`, `/account/profile`.

### Layouts

- `app/(public)/layout.tsx` : layout public (Header public + Footer) ;
- `app/admin/layout.tsx` : layout admin (Sidebar + Topbar) ;
- `app/(auth)/layout.tsx` : layout auth (logo + form centré, footer minimal).

→ Bonne séparation.

## Fichiers à inspecter

- `app/admin/layout.tsx` (sidebar admin)
- `app/admin/components/Sidebar.tsx`
- `app/admin/components/Topbar.tsx`
- `app/admin/users/page.tsx` (CRUD users)
- `app/admin/orders/page.tsx`
- `middleware.ts` (auth check)
- `app/(public)/components/Header.tsx`

## Problèmes typiques détectés

### Protection admin

- middleware d'auth présent dans `middleware.ts` ;
- redirige vers `/login` si non auth ;
- → **OK**.

### Sidebar admin

- présente sur **toutes** les pages admin (vérifié via layout) ;
- icônes Lucide cohérentes ;
- active state via `usePathname()` ;
- collapsible sur mobile (drawer) ;
- → **OK**.

### Liens admin dans le menu public

- vérification du Header public : aucun lien `/admin` ;
- vérification du Footer public : aucun lien `/admin` ;
- → **OK**.

### États admin

- `app/admin/users/page.tsx` : a un état vide ✓ ;
- `app/admin/orders/page.tsx` : **manque** un état vide ;
- `app/admin/content/page.tsx` : a un état chargement (skeleton) ✓ ;
- `app/admin/settings/page.tsx` : OK.

### Confirmations sur actions destructives

- suppression user : **modal de confirmation** présente ✓ ;
- suppression order : **pas de confirmation** — confirmation à ajouter ;
- suppression content : modal présente ✓.

### Termes humains dans l'UI admin

Détection automatique :

```bash
grep -rIE 'endpoint|schema|migration|database' app/admin/
```

- `app/admin/settings/page.tsx:34` contient *"API endpoint"* dans une description visible ;
- → à reformuler en français humain (*"URL de l'API"* ou simplement *"URL"*).

### Retour vers le site public

- bouton "Voir le site" dans la topbar admin ;
- → **OK**.

### Déconnexion

- visible dans la topbar admin (dropdown profil) ;
- → **OK**.

## Corrections sûres (Mode 2)

- [ ] ajouter un état vide à `app/admin/orders/page.tsx` ;
- [ ] reformuler "API endpoint" → "URL de l'API" dans `app/admin/settings/page.tsx`.

## Corrections à valider

- [ ] ajouter une modal de confirmation sur la suppression d'order ;
- [ ] vérifier le focus visible sur tous les boutons admin (test clavier).

## Score cohérence attendu

- **Navigation** : 14 / 15 ;
- **Footer** : N/A (admin n'a pas de footer, volontaire) ;
- **Routes** : 14 / 15 ;
- **Doublons** : 10 / 10 ;
- **Front / admin** : 8 / 10 (états vides incomplets) ;
- **Sécurité basique** : 9 / 10 (middleware OK mais à confirmer auth profonde) ;
- **Total cohérence** : ~85 / 100 → cohérent et publiable.

## Score visuel attendu

- **82–88 / 100** (admin propre, cohérent, design system shadcn discipliné).

## Rapport final attendu

```markdown
# Final coherence report — SaaS Next.js

Score cohérence : 85 / 100
Score visuel : 85 / 100
Verdict : Cohérent et publiable

Top 3 actions :
1. Ajouter état vide à /admin/orders.
2. Ajouter modal de confirmation sur suppression d'order.
3. Reformuler "API endpoint" en "URL de l'API" dans /admin/settings.

Délégations :
- production-auditor : recommandé pour audit sécurité profond + billing.
- premium-webdesigner : non nécessaire (design système solide).
```

---

Created by João de Almeida
