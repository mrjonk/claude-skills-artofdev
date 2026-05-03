# Exemple — Site corporate d'agence / cabinet de conseil

## Contexte

Cabinet de conseil B2B (juridique).
Stack : WordPress 6.x + thème custom déjà en place mais ressemble à un thème gratuit retouché.
Cible : DAF, DRH, dirigeants PME/ETI françaises.
Émotion attendue : sérieux, crédible, sobre. Pas de gadget.

## Prompt utilisateur

> *"Refonte complète du look. Ce site fait beaucoup trop 'thème par défaut'. Sérieux, crédible, sobre. Reste sur WordPress (modifie le thème enfant). Palette bleu marine + doré accent + neutres slate. Aucun gradient violet random, aucune icône fusée / ampoule / poignée de main. Brief avant d'implémenter."*

## Recherche d'inspiration attendue

### 21st.dev

| Catégorie | Pourquoi |
|---|---|
| Heros (featured) | clean, sobre, sans bling |
| Features | grille services / expertises |
| Testimonials | très important pour B2B juridique |
| CTA | "Demander un rendez-vous" |
| Footer 4 colonnes | sérieux + complet |

### shadcn/ui

- Card, Tabs, Badge.

### Sites de référence corporate sérieux

- sites de **cabinets d'avocats premium** (Latham, Clifford Chance — référence pour la sobriété visuelle, pas pour la copie) ;
- sites de **cabinets de conseil** (BCG, Bain, Roland Berger — densité d'info) ;
- sites de **cabinets B2B premium français** (à valider).

> L'objectif est la **crédibilité institutionnelle**, pas l'effet wow startup.

## Composants à chercher

| Composant | Source | Adaptation |
|---|---|---|
| Hero éditorial sobre | 21st.dev featured | photo discrète + claim institutionnel |
| Section "Nos expertises" | shadcn | 4–6 cards : Droit social, Droit fiscal, Compliance, etc. |
| Section "Cas traités" | 21st.dev | 3 études de cas anonymisées |
| Section "L'équipe" | 21st.dev | photos sobres + bio courte |
| Testimonials grid | shadcn | 4–6 quotes clients (avec autorisation) |
| CTA contact | discret mais visible (sticky scroll-aware) |
| Footer 4 colonnes | shadcn | nav + contact + légal + accréditations |

## Images

> Cible juridique premium = très peu d'images photographiques. Privilégier :

- **photos d'équipe sobres** (portraits sur fond neutre, fournies par le client) ;
- **icônes line uniformes** (Lucide ou Heroicons) ;
- **éventuellement** une photo discrète dans le hero (intérieur de cabinet, livres, architecture institutionnelle) — **pas de photo d'équipe en costume autour d'une table en verre**.

| Emplacement | Source | Mots-clés |
|---|---|---|
| Hero | client ou Unsplash | `library books`, `architecture institutional`, `concrete texture neutral` |
| L'équipe | photos client (à fournir) | portraits sobres, fond neutre |
| Sections expertise | icônes Lucide | une icône line discrète par expertise |

## Direction artistique

- **Palette** : primary `#1e3a8a` (bleu marine sérieux) + accent `#d4af37` (doré sobre) + neutres slate
- **Typographie** : Lora ou Source Serif Pro (display) + Inter (body) — un serif pour la crédibilité institutionnelle
- **Spacing** : généreux (128 px entre sections desktop)
- **Radius** : 4 / 8 / 16 px (sobre, pas trop rond)
- **Shadows** : très subtiles, presque invisibles
- **Animations** : minimales, pas de scroll-reveal agressif
- **Style icônes** : line uniforme (Lucide stroke 1.5 px)

## Stack — adaptation WordPress

- Modifier le **thème enfant** existant.
- Conserver les **plugins** SEO (Yoast / Rank Math) en place.
- Conserver les **custom post types** existants.
- Refondre uniquement le **CSS** + **templates PHP** du thème.

## Résultat attendu

- 5 fichiers dans `docs/` ;
- modifications dans `wp-content/themes/<theme-enfant>/` :
  - `front-page.php`
  - `page-expertises.php`
  - `page-equipe.php`
  - `page-cas.php`
  - `page-contact.php`
  - `header.php`, `footer.php`
  - `style.css` avec variables et tokens
- images dans WP media library ;
- `docs/image-credits.md` ;
- `redesign-report.md`.

### Score attendu

| Axe | Cible |
|---|---|
| Visuel | 80+ |
| UX | 75–85 (cible exigeante mais pas en quête d'effets) |
| Responsive | 80+ (cible utilise plus desktop que mobile) |
| Accessibilité | 85+ (cible peut inclure des seniors) |
| Cohérence | 90+ (priorité absolue : tout doit respirer le sérieux uniforme) |
| Premium feel | 85+ |
| **Global** | **82+** |

## Erreurs à éviter

- **gradient violet random** sur la home ;
- **icônes décoratives sans signification** (fusée, ampoule, poignée de main, robot) ;
- **animations excessives** (parallax, scroll-reveal lourd) ;
- **photos stock corporate** (équipe en costume autour table en verre) ;
- **typographie trop "startup"** (sans serif rond et joyeux pour un cabinet juridique = contre-emploi) ;
- **gros boutons partout** ;
- **CTA "Commencer gratuit"** type SaaS — préférer "Demander un rendez-vous" ;
- **pages légales bâclées** (cabinet juridique = exigence absolue de conformité, mentions Barreau, etc.).

## Checklist finale

- [ ] design-brief rempli (sérieux, crédible, sobre)
- [ ] palette validée (bleu marine + doré, **pas** de violet)
- [ ] typographie sérieuse (serif display + sans body)
- [ ] hero sobre, sans gadget visuel
- [ ] expertises listées clairement
- [ ] cas traités anonymisés et présentés sobrement
- [ ] équipe : photos sobres
- [ ] testimonials : quotes vérifiées et autorisées par les clients
- [ ] CTA "Prendre rendez-vous" visible mais pas agressif
- [ ] footer 4 colonnes complètes
- [ ] mentions légales **complètes** (Barreau, RPVA, RGPD, etc.)
- [ ] responsive : focus desktop sans négliger mobile
- [ ] accessibilité AA renforcée
- [ ] aucune icône cliché
- [ ] aucun gradient random
- [ ] redesign-report.md rendu

---

Created by João de Almeida — Art of Dev — https://artofdev.space
