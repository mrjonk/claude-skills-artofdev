# Visual quality checklist — {{PROJECT_NAME}}

> Checklist détaillée à cocher pour chaque page auditée.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Page auditée** : {{ex: /home}}

---

## A. Hiérarchie visuelle

- [ ] un seul `<h1>` ;
- [ ] H1 inclut le sujet de la page ;
- [ ] structure H2/H3 logique ;
- [ ] pas de saut H1 → H4 ;
- [ ] CTA principal identifiable ;
- [ ] max 1 CTA primaire + 1 secondaire par section ;
- [ ] ordre visuel : titre → contenu → action.

## B. Lisibilité

- [ ] body 16 px minimum ;
- [ ] line-height 1.4–1.6 sur le body ;
- [ ] contraste AA (≥ 4.5:1 sur texte normal) ;
- [ ] largeur de ligne 50–80 caractères ;
- [ ] paragraphes de 3–5 lignes max ;
- [ ] aucun texte clair sur fond clair ;
- [ ] aucun texte sur image sans overlay si nécessaire.

## C. Typographie

- [ ] max 2 familles de polices ;
- [ ] max 3 poids par famille ;
- [ ] échelle géométrique (12 / 14 / 16 / 20 / 24 / 30 / 36 / 48 / 60) ;
- [ ] cohérence avec les autres pages.

## D. Spacing

- [ ] valeurs de l'échelle uniquement (4 / 8 / 12 / 16 / 24 / 32 / 48 / 64 / 96 px) ;
- [ ] padding latéral mobile ≥ 16 px ;
- [ ] espacement entre sections : 48–64 px mobile, 96–128 px desktop ;
- [ ] cards avec padding interne cohérent (16 ou 24 px) ;
- [ ] footer respirant.

## E. Layout

- [ ] grille cohérente (12 colonnes desktop, 4–6 mobile) ;
- [ ] container max-width 1280 ou 1440 px ;
- [ ] alignements propres ;
- [ ] équilibre des colonnes (sauf bento intentionnel) ;
- [ ] cards de hauteur cohérente (sauf bento) ;
- [ ] pas de blocs posés au hasard.

## F. Buttons / CTA

- [ ] max 3 variantes (primary / secondary / ghost) ;
- [ ] max 3 tailles, 1 par contexte ;
- [ ] états : default / hover / focus / active / disabled / loading ;
- [ ] focus visible au clavier ;
- [ ] libellés : verbe d'action concret ;
- [ ] pas de bouton décoratif sans action ;
- [ ] icon-only avec `aria-label`.

## G. Cards

- [ ] mêmes radius / border / shadow / padding ;
- [ ] titre lisible ;
- [ ] icônes d'une seule famille ;
- [ ] contenu équilibré ;
- [ ] hover state si interactive ;
- [ ] mobile : empilées et lisibles.

## H. Formulaires

- [ ] labels visibles au-dessus ;
- [ ] focus visible (ring 2 px) ;
- [ ] erreurs localisées au champ concerné ;
- [ ] succès clair après submit ;
- [ ] champs obligatoires marqués (`*` ou texte) ;
- [ ] bouton submit clair (verbe d'action) ;
- [ ] submit désactivé pendant l'envoi ;
- [ ] autocomplete activé ;
- [ ] types corrects (email, tel, number) ;
- [ ] mobile : zones ≥ 44 px de hauteur.

## I. Tables / dashboards

- [ ] colonnes lisibles ;
- [ ] headers visibles (`font-weight: 600`) ;
- [ ] alignement (texte gauche, nombres droite) ;
- [ ] état vide géré ;
- [ ] pagination dès > 25 lignes ;
- [ ] filtres / recherche si applicable ;
- [ ] responsive : scroll ou conversion en cards ;
- [ ] actions alignées.

## J. Images / médias

- [ ] cohérence avec le contenu ;
- [ ] un seul style (photo OU illustration OU 3D) ;
- [ ] alt text non vide sur images informatives ;
- [ ] alt="" sur images décoratives ;
- [ ] ratios cohérents par type ;
- [ ] WebP + fallback JPEG ;
- [ ] dimensions adaptées ;
- [ ] width / height explicites (anti-CLS) ;
- [ ] lazy-load sous la ligne de flottaison ;
- [ ] eager + fetchpriority="high" sur le hero ;
- [ ] aucun cliché stock corporate.

## K. Responsive

- [ ] 4 breakpoints OK (320 / 768 / 1024 / 1440) ;
- [ ] aucun overflow horizontal ;
- [ ] menu mobile fonctionnel ;
- [ ] footer lisible mobile ;
- [ ] tables : scroll ou conversion en cards ;
- [ ] CTA atteignables au pouce (≥ 44 × 44 px) ;
- [ ] pas de hover-only critique.

## L. Cohérence globale

- [ ] mêmes boutons partout ;
- [ ] mêmes cards partout ;
- [ ] mêmes titres partout ;
- [ ] mêmes formulaires partout ;
- [ ] mêmes badges partout ;
- [ ] header / footer cohérents ;
- [ ] pas d'alternance moderne / ancien.

## M. Accessibilité visuelle

- [ ] contraste AA partout ;
- [ ] focus visible ;
- [ ] liens identifiables ;
- [ ] alt text présent ;
- [ ] pas d'animation flash (< 3× / sec) ;
- [ ] pas d'info uniquement par couleur ;
- [ ] `prefers-reduced-motion` respecté.

## N. Anti-template / anti-amateur

- [ ] **test du logo enlevé** : on devine secteur ;
- [ ] **test du logo enlevé** : on devine cible ;
- [ ] **test du logo enlevé** : on devine ton ;
- [ ] pas de "Welcome to our website" résiduel ;
- [ ] pas d'image stock cliché ;
- [ ] footer riche (3+ colonnes) ;
- [ ] design système identifiable.

---

## Score visuel

```
A. Hiérarchie visuelle      : __ / 12
B. Lisibilité               : __ / 10
C. Typographie              : __ / 10
D. Spacing                  : __ / 10
E. Layout                   : __ / 10
F. Buttons / CTA            : __ / 8
G. Cards                    : __ / 6
H. Formulaires              : __ / 6
I. Tables / dashboards      : __ / 6
J. Images                   : __ / 6
K. Responsive               : __ / 8
L. Cohérence globale        : __ / 8
M. Accessibilité visuelle   : __ / 4
N. Anti-template            : __ / 4
─────────────────────────────────
Total                       : __ / 108
Normalisé sur 100           : __ / 100
```

(Le total brut est sur 108 — division par 1.08 pour normalisation sur 100, ou simple bonus. À adapter selon préférence.)

---

## Verdict

| Score | Statut |
|---|---|
| 0–20 | Rendu cassé ou amateur |
| 21–40 | Interface incohérente |
| 41–60 | Utilisable mais très basique |
| 61–75 | Correct mais manque de finition |
| 76–90 | Propre et professionnel |
| 91–100 | Très cohérent, premium-ready |

→ **{{PAGE}}** : **{{X / 100}}** — **{{Verdict}}**

---

Created by João de Almeida
