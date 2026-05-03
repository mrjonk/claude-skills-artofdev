# Checklist accessibilité — `premium-webdesigner`

WCAG **AA** minimum. Pas un objectif optionnel.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. Contraste

- [ ] texte normal : ratio **≥ 4.5:1** entre texte et fond ;
- [ ] grand texte (18 px+ ou 14 px bold+) : ratio **≥ 3:1** ;
- [ ] éléments d'interface (boutons, bordures de focus) : ratio **≥ 3:1** ;
- [ ] aucun texte clair sur fond clair (gris 400 sur gris 100 = ❌) ;
- [ ] aucun texte foncé sur fond foncé ;
- [ ] aucun texte directement sur image sans **overlay** ou **tinted background** ;
- [ ] outils de vérification : Chrome DevTools Lighthouse, axe DevTools, Stark.

---

## 2. Focus visible

- [ ] **toujours** un focus visible au clavier (Tab) ;
- [ ] **ne jamais** désactiver le focus avec `outline: none` sans alternative ;
- [ ] focus ring : 2 px solid, couleur d'accent, **contraste suffisant** ;
- [ ] focus visible sur tous les éléments interactifs : `<a>`, `<button>`, `<input>`, `<select>`, `<textarea>`, custom widgets ;
- [ ] ordre de tabulation logique (de haut en bas, de gauche à droite).

---

## 3. Labels

- [ ] **chaque champ de formulaire** a un `<label>` associé (`for="..."` + `id="..."`) ;
- [ ] **ne pas** utiliser `placeholder` comme seul label (disparaît à la saisie) ;
- [ ] **ne pas** utiliser `aria-label` quand un label visuel est possible ;
- [ ] champs requis : marqués visuellement **et** sémantiquement (`required` + texte ou `*`) ;
- [ ] groupes de champs : `<fieldset>` + `<legend>` ;
- [ ] erreurs : `aria-invalid="true"` + message lié via `aria-describedby`.

---

## 4. Alt text

- [ ] **alt non vide** sur images informatives ;
- [ ] **alt=""** sur images décoratives ;
- [ ] alt **descriptif** : `alt="Femme codant sur laptop dans un bureau lumineux"` ;
- [ ] alt **localisé** (français si site français) ;
- [ ] alt **court** (≤ 125 caractères idéalement) ;
- [ ] images SVG : `<title>` + `<desc>` ou `aria-label` selon contexte ;
- [ ] images de **graphiques / data** : description longue (`aria-describedby` ou `<figcaption>` ou `<details>`).

Cf. [`image-sourcing-guide.md`](image-sourcing-guide.md) §9.

---

## 5. Boutons

- [ ] balises sémantiques : `<button>` pour actions, `<a>` pour navigation ;
- [ ] **pas** de `<div onClick="...">` qui simule un bouton sans accessibilité ;
- [ ] texte du bouton **descriptif** (`Réserver une table`, pas `Cliquez ici`) ;
- [ ] icon-only buttons : `aria-label="Description"` obligatoire ;
- [ ] état `disabled` : attribut `disabled`, **et** style visuel ;
- [ ] état `loading` : `aria-busy="true"` + spinner.

---

## 6. Navigation clavier

- [ ] **toute action** disponible à la souris est disponible au clavier ;
- [ ] menu mobile : ouvrable / fermable au clavier (Enter, Escape) ;
- [ ] modals / dialogs : focus trap + Escape ferme ;
- [ ] dropdowns : flèches haut/bas, Enter, Escape ;
- [ ] liens skip-to-content (`<a href="#main">Aller au contenu</a>`) ;
- [ ] aucun **piège au focus** (perdu dans un widget custom).

---

## 7. Structure sémantique

- [ ] **un seul** `<h1>` par page ;
- [ ] structure `<h2>` / `<h3>` cohérente (pas de saut `<h1>` → `<h4>`) ;
- [ ] balises landmark : `<header>`, `<nav>`, `<main>`, `<aside>`, `<footer>` ;
- [ ] section principale : `<main>` (un seul par page) ;
- [ ] regions importantes : `aria-label` ou `aria-labelledby` ;
- [ ] **lang** sur `<html>` (`lang="fr"`) ;
- [ ] charset UTF-8 explicite.

---

## 8. Liens

- [ ] textes de liens **descriptifs** (jamais "cliquez ici", jamais "en savoir plus" sans contexte) ;
- [ ] liens externes : icône + `aria-label` mentionnant l'ouverture dans une nouvelle fenêtre ;
- [ ] liens cassés signalés (404 lors du scan) ;
- [ ] couleur de lien **distincte** du texte normal (pas seulement par underline supprimé).

---

## 9. Animations / mouvement

- [ ] respect de `prefers-reduced-motion` (disable / reduce les animations) :
  ```css
  @media (prefers-reduced-motion: reduce) {
    *, *::before, *::after {
      animation-duration: 0.01ms !important;
      transition-duration: 0.01ms !important;
    }
  }
  ```
- [ ] **pas d'animation flash** (clignotement < 3× par seconde — risque crise épileptique) ;
- [ ] **pas de parallax agressif** sur tout le site ;
- [ ] **pas d'auto-play vidéo avec son** ;
- [ ] carousels auto-rotatifs : pause sur hover/focus, contrôles accessibles.

---

## 10. Couleurs et information

- [ ] l'information **ne dépend jamais que de la couleur** (ex : un statut indiqué uniquement par une pastille rouge → ajouter un texte ou une icône) ;
- [ ] indicateurs de statut accompagnés de **texte** (Succès / Échec / Avertissement) ;
- [ ] graphiques : motifs ou textures en plus des couleurs ;
- [ ] daltonisme considéré (vert/rouge sont les plus problématiques).

---

## 11. Forms — accessibilité avancée

- [ ] erreurs annoncées via `aria-live="polite"` ou `aria-live="assertive"` selon urgence ;
- [ ] succès annoncé pareillement ;
- [ ] groupes de cases à cocher / radio : `<fieldset>` + `<legend>` ;
- [ ] `autocomplete` activé (`name`, `email`, `tel`, `address-line1`, etc.) ;
- [ ] champs dépendants : annoncés correctement aux lecteurs d'écran.

---

## 12. ARIA — règles d'or

- **Première règle d'ARIA :** ne pas utiliser ARIA quand HTML sémantique suffit.
  - `<button>` > `<div role="button">`
  - `<nav>` > `<div role="navigation">`
- **`aria-label`** uniquement quand il n'y a pas de texte visible ;
- **`aria-labelledby`** quand un autre élément peut servir de label ;
- **`aria-describedby`** pour des descriptions complémentaires (helper text, erreurs) ;
- **`aria-hidden="true"`** sur éléments purement décoratifs ;
- **`aria-live`** sur régions dynamiques (toasts, erreurs) ;
- **`role`** seulement si HTML5 ne suffit pas.

---

## 13. Lecteurs d'écran

- [ ] **tester** avec au moins un lecteur d'écran :
  - **VoiceOver** (macOS / iOS) ;
  - **NVDA** (Windows, gratuit) ;
  - **TalkBack** (Android).
- [ ] navigation par landmark (`Ctrl+Option+U` sur VoiceOver) ;
- [ ] navigation par titre ;
- [ ] formulaires : labels lus correctement ;
- [ ] erreurs : annoncées au moment de l'erreur ;
- [ ] modals : titre annoncé à l'ouverture.

---

## 14. Accessibilité mobile

- [ ] zone tactile **≥ 44 × 44 px** (Apple HIG) / **≥ 48 × 48 px** (Material) ;
- [ ] espace entre éléments cliquables ≥ 8 px ;
- [ ] zoom navigateur autorisé (`user-scalable=yes`, **ne pas** désactiver) ;
- [ ] orientation portrait **et** paysage supportées (sauf raison forte).

---

## 15. Outils de vérification

- **Lighthouse** (Chrome DevTools) — score Accessibility ≥ 90 cible ;
- **axe DevTools** (extension navigateur) — détecte ~30% des problèmes auto ;
- **WAVE** (https://wave.webaim.org/) — visualisation des problèmes ;
- **Stark** (Figma + navigateur) — vérification contraste ;
- **Color Contrast Analyser** (CCA — outil gratuit) ;
- **tests manuels au clavier** (Tab uniquement) ;
- **tests avec lecteur d'écran**.

---

## Sortie attendue

Pour chaque item failed :

- **page** concernée ;
- **gravité** : critique (bloque l'accès) / important (gêne forte) / mineur ;
- **impact** sur l'utilisateur ;
- **correction recommandée**.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
