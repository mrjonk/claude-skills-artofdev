# Webdesign guidelines — `site-ux-guardian`

Guide complet de webdesign professionnel. Référence canonique pour les **14 axes** vérifiés par le skill.

Created by João de Almeida

---

## A. Hiérarchie visuelle

Cf. [`visual-hierarchy-guide.md`](visual-hierarchy-guide.md) pour le détail.

### Règles essentielles

- **un seul `<h1>`** par page ;
- échelle `<h1>` > `<h2>` > `<h3>` claire (différence d'au moins 4 px) ;
- jamais de saut `<h1>` → `<h4>` ;
- **un point focal** par section (pas 5 éléments qui crient) ;
- **un CTA dominant** par zone critique (max 1 CTA primaire + 1 secondaire) ;
- ordre visuel : **titre → explication → action**.

### Anti-patterns

- 3 H1 dans la même page ;
- titres tous en taille identique ;
- aucun élément qui "saute" aux yeux ;
- 5 CTA concurrents qui se neutralisent.

---

## B. Lisibilité

Cf. [`typography-and-spacing-guide.md`](typography-and-spacing-guide.md).

### Règles

- **body 16 px minimum** ;
- **line-height** confortable (1.4–1.6) ;
- **largeur de ligne** 50–80 caractères en lecture longue ;
- **contraste AA** : ratio ≥ 4.5:1 sur texte normal, ≥ 3:1 sur grand texte ;
- paragraphes **pas trop longs** (3–5 lignes max) ;
- aucun **texte clair sur fond clair** ou foncé sur foncé ;
- aucun **texte sur image** sans overlay assombri.

### Anti-patterns

- body 12 px (illisible mobile) ;
- line-height 1 (phrases collées) ;
- contraste gris 400 sur gris 100 ;
- texte qui dépasse 100 caractères de large.

---

## C. Typographie

### Règles

- **2 familles maximum** (1 display + 1 body) ;
- **3 poids maximum** par famille (ex: 400 + 500 + 700) ;
- échelle géométrique (12 / 14 / 16 / 18 / 20 / 24 / 30 / 36 / 48 / 60 / 72 px) ;
- titres **cohérents** entre pages ;
- body cohérent ;
- boutons cohérents ;
- labels de formulaires cohérents.

### Anti-patterns

- 6 polices différentes (Helvetica + Arial + Times + Verdana + Georgia + Comic Sans) ;
- 8 poids différents (300 / 400 / 500 / 600 / 700 / 800 / 900) ;
- titres énormes "juste pour faire moderne" (H1 à 120 px).

---

## D. Espacement

### Règles

- **base 4 ou 8 px** ;
- échelle géométrique (4 / 8 / 12 / 16 / 24 / 32 / 48 / 64 / 96 / 128 px) ;
- **toujours** utiliser une valeur de l'échelle (pas de `padding: 17px` arbitraire) ;
- espacement entre **sections** : 48–64 px mobile, 96–128 px desktop ;
- cards avec padding interne **cohérent** (16 ou 24 px) ;
- footer **respirant** (pas étouffé).

### Anti-patterns

- tout collé (densité écrasante) ;
- tout espacé (rythme perdu) ;
- padding aléatoires (17 px ici, 23 px là, 31 px ailleurs) ;
- menu mobile compressé (items à 8 px d'écart).

---

## E. Layout

Cf. [`layout-consistency-guide.md`](layout-consistency-guide.md).

### Règles

- **alignements propres** ;
- **grilles cohérentes** (12 colonnes desktop, 4–6 mobile) ;
- **container max-width** raisonnable (1280 ou 1440 px) ;
- sections **équilibrées** (pas une 90 % - 10 % sans raison) ;
- cards de **hauteur cohérente** (sauf bento intentionnel) ;
- pas de blocs **posés au hasard**.

### Anti-patterns

- 3 colonnes : 80 % / 10 % / 10 % ;
- card 1 = 200 px, card 2 = 600 px, card 3 = 350 px sans logique ;
- sections sans alignement avec le container global ;
- mix de centrage et de left-align dans la même page.

---

## F. Buttons / CTA

Cf. [`buttons-cards-forms-guide.md`](buttons-cards-forms-guide.md).

### Règles

- **3 variantes maximum** (primary / secondary / ghost) ;
- **3 tailles maximum** (sm / md / lg), **1 seule** par contexte de page ;
- **état hover / focus / active / disabled / loading** définis ;
- **focus visible** au clavier ;
- libellés d'action **clairs** (`Réserver`, `Commencer`, **pas** *"Cliquez ici"*) ;
- **pas de bouton décoratif** sans action.

### Anti-patterns

- 5 styles de boutons différents sur la même page ;
- focus invisible (`outline: none` sans alternative) ;
- bouton qui ne fait rien (`href="#"`) ;
- gros boutons partout sans hiérarchie.

---

## G. Cards

### Règles

- **mêmes radius / border / shadow / padding** sur toutes les cards d'un même type ;
- titres **lisibles** ;
- icônes **utiles** (pas décoratives) ;
- contenu **équilibré** ;
- espacement interne cohérent ;
- état hover si interactive (élévation discrète).

### Anti-patterns

- 12 cards sur la home, toutes identiques sans hiérarchie ;
- cards avec radius 4 / 8 / 12 / 16 / 24 px mélangés ;
- cards sans padding (texte collé au bord) ;
- cards vides qui semblent oubliées.

---

## H. Formulaires

### Règles

- **labels visibles** au-dessus des champs (pas seulement placeholder) ;
- champs **alignés** (largeur cohérente) ;
- **messages d'erreur** sous le champ concerné ;
- **état succès** clair après submit ;
- champs obligatoires **marqués** (`*` ou texte) ;
- bouton submit **clair** ;
- **désactivé** pendant l'envoi (anti double-submit) ;
- **mobile** : version utilisable.

### Anti-patterns

- placeholder à la place du label (disparaît à la saisie) ;
- erreurs en haut de page sans lien au champ ;
- 30 champs sans regroupement ;
- bouton submit *"OK"* (vague) ;
- champs trop petits sur mobile (zone < 44 px).

---

## I. Tables et dashboards

### Règles

- colonnes **lisibles** ;
- headers **visibles** (`font-weight: 600`, fond léger) ;
- **alignement** : texte à gauche, nombres à droite ;
- **état vide** géré ;
- **pagination** dès > 25 lignes ;
- **filtres / recherche** si applicable ;
- **responsive** : scroll ou conversion en cards sur mobile ;
- actions **alignées** ;
- badges **cohérents** (mêmes couleurs sémantiques).

### Anti-patterns

- table qui déborde sans indication mobile ;
- 50 lignes sans pagination ;
- aucun état vide ;
- colonnes mal alignées (header gauche, contenu centré).

---

## J. Images et médias

Cf. [`image-and-media-guidelines.md`](image-and-media-guidelines.md).

### Règles

- images **cohérentes** avec le contenu ;
- **alt text** non vide sur images informatives ;
- **`alt=""`** explicite sur images décoratives ;
- **ratio cohérent** (toutes en 16:9, toutes en 4:3, etc.) ;
- **optimisées** (WebP, taille adaptée) ;
- **lazy-loaded** sous la ligne de flottaison ;
- **eager** + `fetchpriority="high"` sur le hero LCP.

### Anti-patterns

- équipe en costume autour table (cliché stock) ;
- mains anonymes sur clavier ;
- ampoule lumineuse "idée" ;
- mix photo réaliste + illustration plate + 3D dans la même page ;
- alt vide sur des images informatives ;
- PNG 8 Mo pour un hero (LCP catastrophique).

---

## K. Responsive

Cf. [`responsive-navigation-checklist.md`](responsive-navigation-checklist.md).

### Règles

- testé sur **4 breakpoints** (320 / 768 / 1024 / 1440) ;
- **aucun overflow horizontal** ;
- menu mobile fonctionnel ;
- footer lisible mobile ;
- CTA atteignables au pouce (≥ 44 × 44 px).

---

## L. Cohérence visuelle globale

### Règles

- **même** style de boutons partout ;
- **même** style de cards partout ;
- **même** style de titres partout ;
- **même** style de formulaires partout ;
- **même** style de badges partout ;
- **même** footer partout ;
- **même** logique de navigation partout ;
- **pas d'alternance** entre pages modernes et pages anciennes.

### Anti-patterns

- une page au design 2024, une autre au design 2018 ;
- 3 styles de cards différents selon la section ;
- footer différent sur la home et la page contact (sans raison).

---

## M. Accessibilité visuelle minimale

### Règles

- **contraste AA** ;
- **focus visible** ;
- **liens identifiables** (couleur ou underline distinct) ;
- **boutons reconnaissables** (pas un texte plat sans indication) ;
- **alt text** sur images informatives ;
- **pas d'animation flash** (clignotement < 3× par seconde) ;
- **pas d'information uniquement par couleur** (toujours doubler avec icône / texte) ;
- **`prefers-reduced-motion`** respecté.

---

## N. Anti-template / anti-amateur

Signaler **automatiquement** :

- design qui ressemble à un **template** non adapté (Hello World, Welcome to our website) ;
- sections **génériques** (équipe en costume + 3 features + testimonials clichés) ;
- gros blocs **sans hiérarchie** ;
- cards copiées **partout** ;
- footer pauvre (juste un copyright) ;
- hero **trop vide** (texte court + image stock) ;
- image **sans rapport** avec le contenu ;
- **trop de gradients** (gradient sur navbar + hero + cards + boutons) ;
- **trop d'ombres** (shadow dramatique sur tout) ;
- **trop de badges** (10 badges sur une card) ;
- **trop de texte** (paragraphes denses sans aération) ;
- manque de **personnalité** (impression de prototype) ;
- impression de **template non fini**.

### Test du logo enlevé

Si on enlève le logo du site :

- peut-on deviner le **secteur** ? (oui = signal positif)
- peut-on deviner la **cible** ? (oui = signal positif)
- peut-on deviner le **ton** ? (oui = signal positif)

Si **non** aux 3 questions → design générique → signaler.

---

## Erreurs fréquentes (récap)

1. **Pas de hiérarchie** : tous les éléments ont la même importance visuelle.
2. **Trop de couleurs** : 6 couleurs d'accent qui crient en même temps.
3. **Espacement chaotique** : valeurs aléatoires hors échelle.
4. **Polices mélangées** : 4 familles différentes.
5. **Boutons incohérents** : 5 styles selon la page.
6. **Cards inégales** : hauteurs différentes sans logique.
7. **Footer pauvre** : juste un copyright.
8. **Animations agressives** : parallax sur 30 sections.
9. **Stock photos clichés** : équipe en costume, mains sur clavier.
10. **Mobile cassé** : overflow, menu non fonctionnel, CTA inaccessibles.

---

## Checklist finale

À cocher avant de rendre le rapport :

- [ ] **A.** hiérarchie visuelle OK
- [ ] **B.** lisibilité OK
- [ ] **C.** typographie cohérente
- [ ] **D.** espacement géométrique
- [ ] **E.** layout aligné
- [ ] **F.** boutons cohérents
- [ ] **G.** cards cohérentes
- [ ] **H.** formulaires utilisables
- [ ] **I.** tables / dashboards lisibles
- [ ] **J.** images cohérentes, alt présents
- [ ] **K.** responsive 4 breakpoints
- [ ] **L.** cohérence inter-pages
- [ ] **M.** accessibilité AA
- [ ] **N.** pas de template / amateur
- [ ] test du logo enlevé : passé

---

Created by João de Almeida
