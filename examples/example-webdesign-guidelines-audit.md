# Exemple — Audit webdesign guidelines (14 axes)

## Contexte

Site vitrine d'un cabinet de conseil. Site fonctionnel mais qui "fait template" selon le client.
Stack : Astro + Tailwind.

## Demande originale

> *"Audit webdesign guidelines (14 axes : hiérarchie, lisibilité, typo, spacing, layout, boutons, cards, formulaires, tables, images, responsive, cohérence, accessibilité, anti-template). Score visuel détaillé. Mode : audit only."*

## Analyse attendue

### Pages principales auditées

- `/` (home) ;
- `/services` ;
- `/equipe` ;
- `/cas-clients` ;
- `/contact` ;
- `/blog` + `/blog/[slug]`.

### Détection automatique

```bash
bash skills/site-ux-guardian/scripts/scan-visual-consistency-patterns.sh .
```

## Détail par axe

### A. Hiérarchie visuelle (8 / 12)

- ✓ un seul `<h1>` par page ;
- ⚠ structure H2 / H3 incohérente sur `/services` (saut H1 → H4) ;
- ✗ CTA principal **pas identifiable** sur la home (3 CTA concurrents : *"Découvrir"*, *"Nous contacter"*, *"Voir nos services"*).

### B. Lisibilité (7 / 10)

- ✓ body 16 px ;
- ✓ contraste AA ;
- ⚠ line-height 1.3 (un peu serré) ;
- ✗ largeur de ligne sur `/blog/[slug]` : 110 caractères (trop large) ;
- ⚠ texte sur image hero : pas d'overlay assombri suffisant.

### C. Typographie (5 / 10)

- ✗ **3 familles** détectées : Inter (body) + Playfair (titres home) + system-ui (autres titres) → incohérence ;
- ✓ 3 poids ;
- ⚠ tailles non strictement géométriques (15 px, 17 px détectés) ;
- ✗ titres sur la home en Playfair, mais sur `/services` en system-ui → patchwork.

### D. Spacing (6 / 10)

- ⚠ 5 valeurs arbitraires détectées (`padding: 17px`, `margin-top: 23px`, etc.) ;
- ✓ padding mobile ≥ 16 px ;
- ⚠ espacement entre sections : 96 px home, 60 px services, 80 px équipe → incohérent ;
- ✓ footer respirant.

### E. Layout (8 / 10)

- ✓ container max-width 1280 px ;
- ✓ alignements propres globalement ;
- ⚠ section "Cas clients" avec colonnes 70 % / 30 % sans raison visible ;
- ⚠ cards de hauteur incohérente sur la page équipe (sans bento intentionnel).

### F. Buttons / CTA (5 / 8)

- ⚠ **5 variantes** de boutons détectées (3 sur la home, 2 différentes ailleurs) ;
- ✓ états hover / focus présents sur la version principale ;
- ✗ **focus invisible** sur les boutons secondaires (`outline: none` sans alternative) ;
- ⚠ libellés vagues : *"En savoir plus"* x 6 sur la même page.

### G. Cards (3 / 6)

- ✗ **radius incohérents** : 4 px, 8 px, 12 px, 16 px mélangés selon les sections ;
- ⚠ shadows incohérentes (3 niveaux différents) ;
- ⚠ paddings : 16 px et 24 px mélangés ;
- ✓ titres lisibles.

### H. Formulaires (4 / 6)

- ✓ formulaire contact avec labels visibles ;
- ✗ **focus invisible** sur les inputs (problème accessibilité) ;
- ⚠ pas d'`autocomplete` activé ;
- ✓ erreurs localisées au champ ;
- ✓ submit clair.

### I. Tables / dashboards (N/A)

Site vitrine sans tableau. Score redistribué.

### J. Images (4 / 6)

- ⚠ **mix de styles** : photos réalistes (équipe) + illustrations plates (services) + icônes line (features) sur la même page ;
- ⚠ stock photos : photo "équipe en costume autour d'une table" sur la page équipe (cliché) ;
- ✓ alt text présent partout ;
- ⚠ pas en WebP (JPEG uniquement) ;
- ✗ width / height pas explicites (CLS visible).

### K. Responsive (6 / 8)

- ✓ menu mobile fonctionnel ;
- ✓ pas d'overflow horizontal ;
- ⚠ hero image coupée sur 320 px (le sujet sort du cadre) ;
- ✓ CTA atteignables au pouce.

### L. Cohérence globale (3 / 8)

- ✗ **5 styles de boutons** ;
- ✗ **3 familles** de polices ;
- ✗ **4 radius** différents sur les cards ;
- ⚠ home moderne (Playfair + Tailwind ambitieux), pages internes plus génériques (system-ui).

### M. Accessibilité visuelle (2 / 4)

- ✓ contraste AA majoritairement ;
- ✗ **focus invisible** sur boutons secondaires + inputs ;
- ⚠ liens dans le texte courant : juste underline retiré, pas d'alternative claire.

### N. Anti-template / amateur (1 / 4)

- ⚠ **test du logo enlevé** : on devine "site de services" mais pas le secteur précis (consulting / juridique / digital ?) ;
- ⚠ photo équipe en costume = cliché stock ;
- ⚠ icônes décoratives sans signification (ampoule, fusée, engrenage) ;
- ✓ footer riche (4 colonnes).

## Score total

```
A. Hiérarchie visuelle      : 8 / 12
B. Lisibilité               : 7 / 10
C. Typographie              : 5 / 10
D. Spacing                  : 6 / 10
E. Layout                   : 8 / 10
F. Buttons / CTA            : 5 / 8
G. Cards                    : 3 / 6
H. Formulaires              : 4 / 6
I. Tables / dashboards      : N/A
J. Images                   : 4 / 6
K. Responsive               : 6 / 8
L. Cohérence globale        : 3 / 8
M. Accessibilité visuelle   : 2 / 4
N. Anti-template            : 1 / 4
─────────────────────────────────
Total                       : 62 / 102
Normalisé sur 100           : ~61 / 100
```

→ **Score visuel : 61 / 100** — Correct mais manque de finition.

## Score cohérence attendu

- **Navigation** : 12 / 15 ;
- **Footer** : 8 / 10 ;
- **Routes** : 14 / 15 ;
- **Doublons** : 9 / 10 ;
- **Total cohérence** : ~76 / 100.

## Corrections sûres (Mode 2)

- [ ] ajouter `outline` ou `ring` visible sur les boutons secondaires et inputs (accessibilité) ;
- [ ] ajouter `autocomplete` sur les champs du formulaire contact ;
- [ ] ajouter `width` / `height` explicites sur les images ;
- [ ] corriger les paddings arbitraires (`17px` → `16px`, `23px` → `24px`).

## Corrections à valider — délégation `premium-webdesigner` recommandée

Le score visuel **61 / 100** indique un problème de **direction artistique** plus que de simple cohérence. Recommandation explicite :

> Le score visuel est de 61/100. Les problèmes principaux (3 polices, 5 styles de boutons, 4 radius, mix de styles d'images) indiquent un manque de **direction artistique cohérente**. La correction des incohérences seules ne suffira pas à passer en "professionnel". Je recommande d'utiliser le skill **`premium-webdesigner`** pour produire une vraie direction artistique (palette restreinte, typo unique, design system documenté) avant de revenir à `site-ux-guardian` pour la cohérence finale.

## Rapport final attendu

```markdown
# Final coherence report — Site cabinet de conseil

Score cohérence : 76 / 100
Score visuel : 61 / 100
Verdict : Correct mais manque de finition (direction artistique faible)

Top 3 actions :
1. **Déléguer à premium-webdesigner** pour produire une direction artistique
   (palette, typo unique, design system documenté).
2. Pendant ce temps, corriger les problèmes accessibilité (focus visible).
3. Remplacer la photo équipe stock par une vraie photo de l'équipe.

Délégations :
- premium-webdesigner : **recommandé** (score visuel 61, manque de direction).
- production-auditor : optionnel.
```

---

Created by João de Almeida
