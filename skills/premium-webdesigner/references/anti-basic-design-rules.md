# Règles anti-design-basique — `premium-webdesigner`

Tout ce que Claude doit **refuser de produire**. Et tout ce qu'il doit **viser** systématiquement.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. Anti-patterns à refuser

### 1.1 Homepage générique

- **Gros titre central + sous-titre + 3 cards en dessous, sans personnalité.**
- **Hero "We help businesses grow"** + image générique d'équipe en costume.
- **Trois colonnes "Vitesse / Sécurité / Simplicité"** avec icônes random.

→ Si on **enlève le logo**, le site pourrait être celui de **n'importe quel concurrent**. C'est le signal d'un design générique.

### 1.2 Gradients random

- Gradient violet → rose posé "parce que ça fait moderne".
- Gradient sur **tout** : navbar, hero, cards, boutons (incohérent).
- Gradient pur sans rapport avec l'ambiance produit.

→ Un gradient doit **servir** un effet (profondeur, ambiance), pas remplir un vide.

### 1.3 Dark mode sans lisibilité

- Texte `#888888` sur fond `#222222` (contraste insuffisant).
- Inversion brutale : blanc → noir, sans ajustement des couleurs accent.
- Aucun ajustement des shadows (les ombres dramatiques en dark mode = pâté noir).

→ Dark mode = **un design à part entière**, pas un toggle d'inversion.

### 1.4 Boutons énormes partout

- Tous les CTA en taille XL.
- Pas de hiérarchie : 4 boutons primaires côte à côte.
- Boutons qui prennent 80 % de la largeur d'une section.

→ Un seul CTA primaire par section. Les autres en variante secondaire ou tertiaire.

### 1.5 Icônes décoratives sans signification

- Icône ampoule à côté de "Idées".
- Icône fusée à côté de "Lancement".
- Icône engrenage à côté de "Configuration".

→ Si l'icône ne **dit rien de plus** que le texte adjacent, **la supprimer** ou la remplacer par une icône **vraiment** spécifique.

### 1.6 Textes marketing creux

- *"Révolutionnez votre productivité"*.
- *"Une expérience inégalée"*.
- *"Le futur de la gestion"*.
- *"Boostez votre business"*.
- *"Disruption pour les professionnels exigeants"*.

→ Remplacer par des phrases **concrètes** : *"Crée et démarre une session focus en 8 secondes"*.

### 1.7 Sections répétitives en mode template

- **Section 1** : "Notre histoire" — paragraphe générique.
- **Section 2** : "Nos valeurs" — 4 cards icônes-titre.
- **Section 3** : "Notre équipe" — photos posées.
- **Section 4** : "Nos clients" — logos en niveaux de gris.
- **Section 5** : "Témoignages" — avatars génériques.
- **Section 6** : "Contact" — formulaire 6 champs.

→ Si la page **ressemble** à 1000 autres, **repenser** chaque section : sert-elle un objectif réel ?

### 1.8 Cards toutes identiques sur 12 features

- Grille 4 × 3 de cards strictement identiques (icône + titre + 2 lignes).
- Aucune hiérarchie : pas de feature mise en avant, pas de groupement, pas de variation.
- Énumération sans souffle.

→ Préférer **3 features bien mises en avant** + un récapitulatif synthétique des autres. Ou un **bento grid** avec hiérarchie visuelle.

### 1.9 Espacements mal gérés

- Tout collé (densité écrasante, illisible).
- Tout espacé (vide entre éléments, le rythme se perd).
- Padding aléatoires (17 px ici, 23 px là).

→ Échelle de spacing géométrique (4 / 8 / 12 / 16 / 24 / 32 / 48 / 64 / 96 px).

### 1.10 Polices trop massives

- H1 à 120 px qui sort de l'écran mobile.
- Body à 14 px ou moins (illisible).
- 6 poids différents (300 / 400 / 500 / 600 / 700 / 900) dans la même page.

→ Body 16 px min. H1 raisonnable (48–60 px desktop, 36–48 px mobile). 3 poids max.

### 1.11 Footer pauvre

- Juste un copyright.
- Liens cassés vers des pages inexistantes.
- Pas de réseaux sociaux.
- Pas de mentions légales.

→ Footer minimum **3 colonnes** : navigation + contact/social + légal.

### 1.12 Navbar incohérente entre pages

- Page A : 5 items dans le menu.
- Page B : 3 items, dans un autre ordre.
- Logo qui change de couleur sans raison.
- CTA primaire absent sur certaines pages.

→ Header et footer **identiques** sur toutes les pages publiques.

### 1.13 Design template-WordPress

- Hero : "Welcome to our website".
- Sections génériques importées d'un thème.
- Mix de polices Google Fonts cumulées par 3 plugins différents.
- Typo trop massive, animations en pagaille, footer interminable.

→ Repartir de **zéro** côté style. Conserver fonctionnalité, refondre apparence.

### 1.14 Image hero sans rapport

- Restaurant italien avec hero "city skyline at night".
- App de productivité avec photo "homme heureux dans un parc".
- Tatoueur avec photo "stock corporate équipe en costume".

→ Mots-clés **précis** par secteur (cf. `image-sourcing-guide.md`).

### 1.15 Stock photos clichés

- Équipe en costume + tablette autour table en verre.
- Mains anonymes sur clavier.
- Ampoule lumineuse ("idée").
- Poignée de main ("deal").
- Robot mignon ("IA").
- Flèche montante ("growth").

→ Bannir. Préférer images **spécifiques** au contexte.

### 1.16 Animations inutiles

- Parallax sur 30 sections (nausée).
- Hover qui scale à 1.5 (agressif).
- Apparition fade-in séquentielle sur 50 éléments.
- Curseur custom obligatoire.
- Cursor follower décoratif.

→ Animations **subtiles** : 150–300 ms, ease-out. Max 2–3 motifs dans le projet. Servent l'UX, pas la déco.

### 1.17 Manque de hiérarchie

- Tous les éléments ont la même taille.
- Tout est en gras.
- 5 couleurs d'accent crient en même temps.
- Aucun point focal.

→ Hiérarchie : un H1, un CTA primaire, un point focal par section.

### 1.18 Manque d'objectif utilisateur

- Page sans CTA clair.
- Page qui n'amène nulle part.
- Page sans motif d'exister (autre que "remplir le menu").

→ **Chaque page** doit avoir un objectif. Si elle n'en a pas, la **supprimer** ou la **fusionner**.

---

## 2. Critères premium à viser

### 2.1 Clarté

- L'utilisateur comprend en **5 s** ce que fait le site.
- Promesse de valeur **dans le hero**.
- Action principale **visible** dès l'ouverture.

### 2.2 Hiérarchie

- **Un seul** H1 par page.
- **Un seul** CTA primaire par section.
- Échelle typographique claire.
- Couleurs d'accent limitées.

### 2.3 Finition premium

- Hover states partout.
- Transitions douces (150–300 ms).
- Micro-interactions sur boutons, cards, formulaires.
- Détails soignés (radius, shadows, espacements).
- Pas de bug visuel (pas de saut, pas de FOUC, pas de CLS).

### 2.4 Cohérence

- **Un seul** design system.
- Pas un mix de styles (1 page moderne + 1 page legacy).
- Header / footer identiques sur toutes les pages publiques.

### 2.5 Lisibilité

- Body 16 px **min**.
- Line-height 1.4–1.6.
- Contraste **AA** (≥ 4.5:1).
- Longueur de ligne 50–80 caractères en lecture.

### 2.6 Rythme visuel

- Alternance dense/aéré.
- Sections différenciées (background, espacement).
- Respiration entre éléments.
- Variation de layouts (text-image, image-text, fullwidth, contained).

### 2.7 Personnalité

- Un secteur restaurant ≠ secteur tech ≠ secteur tatouage.
- Une **direction artistique** qui transmet l'**émotion** du produit.
- Une **typographie** qui colle au ton.
- Des **images** qui correspondent à l'univers.

### 2.8 Conversion

- CTA clair, pas perdu dans 12 boutons.
- Formulaires courts.
- Réassurance présente (testimonials, logos, garanties).
- Aucune friction inutile.

### 2.9 Crédibilité

- Testimonials **réels** (avec nom + entreprise + photo si possible).
- Logos clients **réels**.
- Métriques **honnêtes** (pas inventées).
- Mentions légales complètes.
- Coordonnées vraies et accessibles.

### 2.10 Responsive propre

- Testé à 4 breakpoints minimum.
- Mobile fonctionnel.
- Aucun overflow horizontal.

### 2.11 Accessibilité minimale

- WCAG AA respecté.
- Navigation clavier.
- Focus visible.
- Alt text sur images informatives.
- `lang` sur `<html>`.

### 2.12 Design justifié par le contenu

- Chaque section sert un but.
- Chaque visuel sert un message.
- Chaque animation sert une UX.
- Aucune section "remplissage".

---

## 3. Test final : *le test du logo enlevé*

Si on **enlève le logo** du site, est-ce qu'on peut deviner :

- le **secteur** ? (oui = signal positif)
- la **cible** ? (oui = signal positif)
- le **ton** (corporate / startup / artistique) ? (oui = signal positif)

Si la réponse est **non** aux trois questions, le design est **trop générique**.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
