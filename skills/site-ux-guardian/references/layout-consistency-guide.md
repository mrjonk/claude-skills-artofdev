# Guide de cohérence de layout — `site-ux-guardian`

Comment vérifier que la mise en page est **cohérente** entre les pages.

Created by João de Almeida

---

## 1. Grille

### Règles

- **12 colonnes** desktop (standard) ;
- **6 ou 4 colonnes** mobile ;
- **gap** cohérent (16 / 24 / 32 px selon densité) ;
- **container max-width** : 1280 ou 1440 px.

### Patterns courants

| Layout | Colonnes | Cas |
|---|---|---|
| 1 colonne pleine | 12/12 | hero, contenu long |
| 2 colonnes égales | 6/6 | features alternées |
| 1 + 2 | 4/8 ou 8/4 | sidebar + contenu |
| 3 colonnes | 4/4/4 | grille de cards |
| 4 colonnes | 3/3/3/3 | grille dense (logos, miniatures) |

---

## 2. Largeur max

### Règles

- container **borné** (1280 ou 1440 px) ;
- au-delà : fond unifié, contenu centré ;
- **pas de container sans max-width** sur grand écran (texte qui s'étale, mauvais usage) ;
- variantes selon contexte :
  - **prose** (article) : 75 ch (~ 720 px) ;
  - **content** (page services) : 1280 px ;
  - **media** (galerie) : 1440 px ;
  - **full-bleed** (hero immersif) : 100 % ponctuel.

### Anti-patterns

- texte sur 100 % de la largeur d'un écran 4K ;
- container à 600 px sur grand écran (espace gaspillé) ;
- container différent par page sans logique.

---

## 3. Alignements

### Règles

- **sections principales** alignées avec le container global ;
- **éléments internes** alignés à la même grille ;
- **cohérence d'alignement** dans les listings (tout left-align ou tout center, pas mix) ;
- **alignement vertical** dans les cards (top, baseline ou center selon contexte).

### Anti-patterns

- section 1 alignée à gauche, section 2 centrée, section 3 alignée à droite (chaos) ;
- cards qui semblent posées au hasard ;
- paddings asymétriques (16 px à gauche, 24 px à droite sans raison).

---

## 4. Équilibre des colonnes

### Règles

- colonnes **équilibrées** sauf intention claire (sidebar étroite + contenu large = OK) ;
- **rythme** entre les sections (alterner gauche-droite si pertinent) ;
- **pas de colonne vide** ou quasi vide.

### Anti-patterns

- colonne 1 = 80 % du contenu, colonne 2 = 20 % vide ;
- 3 colonnes : 80 % / 10 % / 10 % ;
- card 1 = 200 px de hauteur, card 2 = 600 px (sans bento intentionnel).

---

## 5. Cohérence des sections

### Règles

- **rythme vertical** régulier (espacement entre sections cohérent) ;
- **fond alterné** ou variations subtiles pour différencier ;
- **largeur** identique entre sections (toutes dans le container global) ;
- **structure** similaire : titre H2 → contenu → optional CTA.

### Anti-patterns

- section 1 dans le container, section 2 en full-bleed, section 3 dans un container plus étroit (sans intention) ;
- alternance de fonds aléatoire ;
- sections de tailles très différentes (300 px / 1200 px / 500 px / 2000 px).

---

## 6. Layout mobile

### Règles

- sections **empilées** verticalement ;
- colonnes **transformées** en pile (1 colonne mobile, 2–3 colonnes tablet+) ;
- ordre **logique** (pas un mockup à droite qui se retrouve avant le titre en mobile) ;
- **padding latéral** : 16 px min ;
- **espacement vertical** : 48–64 px entre sections.

### Anti-patterns

- 4 colonnes maintenues en mobile (texte écrasé) ;
- ordre cassé en mobile (footer apparaît avant le contenu principal) ;
- pas de `gap` ou `margin` entre éléments empilés.

---

## 7. Cohérence entre types de pages

### Règles

- **homepage** : layout marketing (hero + sections diverses) ;
- **pages internes** (services, à propos) : layout standard (titre + contenu structuré) ;
- **pages admin** : layout sidebar + main ;
- **pages auth** : layout minimal centré ;
- **pages légales** : layout prose (texte centré, max 75 ch).

### Anti-patterns

- pages internes qui copient le layout marketing (chaque page a un hero massif) ;
- pages admin avec hero (incohérent) ;
- pages auth avec sidebar admin ;
- mix de layouts au sein d'une même section du site.

---

## 8. Cohérence entre langues / variants

### Règles

- même **layout** dans chaque langue ;
- ajustement seulement pour **longueur de texte** (l'allemand est plus long que l'anglais) ;
- **switch langue** au même endroit ;
- **footer / header** mêmes positions ;
- **CSS** identique (pas une feuille différente par langue).

### Anti-patterns

- version FR avec un layout, version EN avec un autre ;
- texte qui déborde dans certaines langues sans tester ;
- container plus étroit en JP qu'en FR.

---

## 9. Patterns de layout récurrents

### Hero classique

```
[───── Hero pleine largeur ─────]
[Container : Titre H1 + Sous-titre]
[CTA primaire + CTA secondaire]
[Image hero (50% droite ou full-bleed)]
```

### Section features

```
[Container]
[H2 + intro courte]
[Grille 2x2 ou 3 colonnes de cards]
[CTA optionnel]
```

### Bento grid

```
[1 grande cellule (50% largeur)]
[2-3 petites cellules (25% chacune)]
[Layout cohérent en mobile (empilé)]
```

### Pricing

```
[Toggle annuel/mensuel]
[3 cards alignées (Free / Pro / Team)]
[Card centrale highlight]
[FAQ pricing en dessous]
```

### Article / blog

```
[Container prose 75 ch]
[Titre H1 + métadonnées (auteur, date)]
[Image hero ou table des matières]
[Corps de l'article]
[Auteur bio + articles liés]
```

---

## 10. Outils de vérification

- **Chrome DevTools** — inspect grille, mesurer tailles ;
- **Firefox DevTools** — meilleurs outils Grid / Flexbox ;
- **Stark** — vérification contraste + simulateur ;
- **resize manuel** — meilleur test final.

---

## 11. Checklist layout

- [ ] **grille** cohérente (12 colonnes desktop, 4–6 mobile) ;
- [ ] **container max-width** raisonnable (1280 ou 1440 px) ;
- [ ] **alignements propres** (rien posé au hasard) ;
- [ ] **équilibre des colonnes** (sauf intention bento) ;
- [ ] **rythme vertical** régulier entre sections ;
- [ ] **layout mobile** : 1 colonne, ordre logique, padding 16 px+ ;
- [ ] **cohérence** entre types de pages (home, internes, admin, auth) ;
- [ ] **cohérence** entre langues ;
- [ ] **patterns** récurrents identifiables.

---

Created by João de Almeida
