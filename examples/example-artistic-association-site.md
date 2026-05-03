# Exemple — Site d'association artistique

## Contexte

Association locale dédiée aux activités culturelles et à la jeunesse.
Stack : WordPress 6.x + thème enfant custom.
Cible : familles, bénévoles, partenaires institutionnels (mairie, région).
Le site actuel a un look thème WordPress par défaut.

## Prompt utilisateur

> *"Refonte du site de notre association locale. Ne sors pas de WordPress (pas de Next imposé). Direction : humain + chaleureux + crédible. Pas template WP par défaut. Pages : accueil, mission, événements, adhérer, contact, dons. Importe images via Pixabay. Brief avant implémentation."*

## Recherche d'inspiration attendue

### 21st.dev

| Catégorie | Adaptation |
|---|---|
| Heros | hero immersif avec photo communauté |
| Cards | événements, activités |
| Pricing | adapté en "Niveaux d'adhésion" (5€ / 20€ / soutien) |
| CTA | dons + adhésion |
| Footer 4 colonnes | nav + contact + sociaux + mentions légales |

### Sites de référence

- sites d'**associations locales premium** (à explorer manuellement) ;
- sites d'**associations culturelles régionales** (référence visuelle) ;
- **Squarespace templates** "non-profit" (logique de structure).

> Adapter à WordPress, pas copier en SPA.

## Composants à chercher

| Composant | Source | Adaptation |
|---|---|---|
| Hero immersif | 21st.dev | photo gathering, overlay clair |
| Cards événements | shadcn block / WP custom | date + image + lieu + lien |
| Section "À propos" | 21st.dev | mission + équipe |
| CTA don / adhésion | shadcn / 21st.dev | sticky bottom mobile |
| Newsletter | WP plugin Mailchimp | discret en footer |
| Footer | shadcn | 4 colonnes |

## Images à chercher (Pixabay)

| Emplacement | Mots-clés |
|---|---|
| Hero homepage | `community gathering`, `local event happy`, `families together outdoor` |
| Section mission | `volunteer hands`, `cultural activity workshop` |
| Section événements | `village fête`, `outdoor concert local` |
| Section partenaires | logos institutionnels (fournis par client, à demander) |

> **Éviter** : photos posées trop "stock", privilégier candid / reportage.

## Direction artistique

- **Ambiance** : chaleureuse, accueillante, sérieuse mais pas froide ;
- **Palette** : primary `#0f766e` (vert sapin chaleureux) + accent `#f59e0b` (ambre) + crème `#fefce8` (warmth) ;
- **Typographie** : Source Sans 3 (body) + Crimson Pro (display) — un display avec personnalité, lisible mais marqué ;
- **Spacing** : aéré (96 px entre sections desktop) ;
- **Radius** : 8 / 16 / 32 px (plus rond, plus humain) ;
- **Shadows** : douces, jamais nettes ;
- **Animations** : très subtiles, scroll-reveal sur cards événements.

## Stack — adaptation WordPress

- **Pas de React**, pas de Next, pas de SPA.
- Modifier le **thème enfant** existant.
- Si Tailwind n'est pas en place, utiliser CSS custom propre avec variables `:root`.
- Page-builder type Bricks / Elementor / GeneratePress → respecter ce qui est déjà en place.
- Custom fields ACF si déjà installés.

## Résultat attendu

- 5 fichiers dans `docs/` ;
- modifications dans `wp-content/themes/<theme-enfant>/` :
  - `front-page.php` (homepage)
  - `page-mission.php`
  - `page-evenements.php` ou archive `event` custom post type
  - `page-adherer.php`
  - `page-contact.php`
  - `page-dons.php`
  - `header.php`, `footer.php` refondus
  - `style.css` avec variables et tokens
- images dans `wp-content/uploads/` (pas dans le repo Git, gestion WP standard) ;
- `docs/image-credits.md` dans le repo si versionné ;
- `redesign-report.md`.

### Score attendu

| Axe | Cible |
|---|---|
| Visuel | 80+ (humain + chaleureux est plus accessible visuellement) |
| UX | 80+ (cible familiale, simplicité requise) |
| Responsive | 90+ (smartphone est le device dominant pour cette cible) |
| Accessibilité | 90+ (cible diverse incluant seniors) |
| Cohérence | 85+ |
| Premium feel | 75+ (pas trop "luxe", trop premium = froid pour une asso) |
| **Global** | **80+** |

## Erreurs à éviter

- **forcer Next.js** ou React → casse tout, demande compétences extérieures à l'asso ;
- **template WP par défaut** non retravaillé → résultat amateur ;
- **photos stock corporate** (équipes en costume) → contre-emploi total pour une asso locale ;
- **trop premium / minimal** → froid, ne donne pas envie d'adhérer ;
- **animations excessives** → ralentit sur les vieux smartphones de la cible ;
- **pages légales absentes** (mentions, RGPD si collecte de données adhérents) ;
- **bouton don trop discret** ou trop agressif (UX subtile à trouver).

## Checklist finale

- [ ] design-brief rempli avec contraintes WordPress notées
- [ ] images Pixabay sourcées + crédits documentés
- [ ] palette validée (chaleureuse, pas froide)
- [ ] hero avec photo communauté propre
- [ ] section événements fonctionnelle (custom post type ou plugin)
- [ ] formulaire contact protégé contre spam (CF7 + honeypot ou reCaptcha)
- [ ] CTA dons clair (page dédiée ou widget Stripe / HelloAsso intégré)
- [ ] niveaux d'adhésion clairs (pricing-like)
- [ ] footer 4 colonnes
- [ ] mentions légales + politique de confidentialité présentes
- [ ] responsive mobile parfait (cible primaire)
- [ ] accessibilité AA renforcée
- [ ] redesign-report.md rendu

---

Created by João de Almeida — Art of Dev — https://artofdev.space
