# Guide boutons, cards, formulaires — `site-ux-guardian`

Comment vérifier la cohérence des composants UI critiques.

Created by João de Almeida

---

## 1. Boutons

### Variantes recommandées

| Variante | Style | Usage |
|---|---|---|
| **Primary** | fond plein, couleur d'accent | action principale (1 par section critique) |
| **Secondary** | outline, couleur d'accent | action secondaire |
| **Ghost** | transparent, texte seul | action tertiaire (annuler, fermer, retour) |
| **Destructive** | fond rouge ou outline rouge | suppression, action critique |

→ Maximum **4 variantes** sur tout le site.

### Tailles

| Taille | Hauteur | Padding | Cas |
|---|---|---|---|
| `sm` | 32 px | 12 px x 8 px | actions inline, listes admin |
| `md` | 40 px | 16 px x 12 px | défaut |
| `lg` | 48 px | 24 px x 16 px | CTA principal |

→ **Une seule taille** par contexte de page.

### États obligatoires

- `default` ;
- `hover` (couleur plus foncée, ou élévation `shadow-md`, transition 150 ms) ;
- `focus` (ring 2 px, contraste suffisant) ;
- `active` (couleur encore plus foncée) ;
- `disabled` (opacité 0.5, `cursor: not-allowed`) ;
- `loading` (spinner + `aria-busy="true"`).

### Libellés

- **verbe d'action concret** : *"Réserver"*, *"Commencer"*, *"S'inscrire"*, *"Demander un devis"* ;
- **pas** *"Cliquez ici"*, *"En savoir plus"*, *"OK"*, *"Submit"* ;
- icon-only : `aria-label` obligatoire.

### Anti-patterns

- 5 styles de boutons différents sur la même page ;
- focus invisible (`outline: none` sans alternative visible) ;
- bouton qui ne fait rien (`href="#"`) ;
- libellé long (*"Cliquez ici pour découvrir nos services"*) au lieu d'*"Découvrir"* ;
- boutons décoratifs sans action.

---

## 2. Cards

### Anatomie d'une card

```
┌─────────────────────────────┐
│ [Icône / image]              │
│ Titre H3                     │
│ Description (2-3 lignes)     │
│ [Métadonnées / badges]       │
│ [CTA / lien]                 │
└─────────────────────────────┘
```

### Règles

- **mêmes radius** sur toutes les cards d'un même type (6, 12 ou 16 px) ;
- **mêmes border / shadow** sur toutes les cards ;
- **mêmes paddings** internes (16 ou 24 px) ;
- **titres lisibles** ;
- **icônes** d'une seule famille ;
- **contenu équilibré** ;
- **hover state** si la card est cliquable (élévation discrète + cursor pointer).

### Anti-patterns

- 3 cards avec radius 4 / 8 / 12 px sur la même page ;
- card avec padding 4 px (texte collé au bord) ;
- card cliquable sans cursor pointer ;
- cards de hauteurs aléatoirement différentes (sans bento intentionnel) ;
- 12 cards identiques sans hiérarchie ;
- cards vides (placeholder oublié).

---

## 3. Formulaires

### Anatomie d'un champ

```
[Label visible au-dessus]
[Input avec padding confortable]
[Helper text (optionnel)]
[Error text (en cas d'erreur)]
```

### Règles

- **labels visibles** au-dessus (pas seulement placeholder) ;
- **placeholder** comme exemple, pas comme label ;
- **champs alignés** (largeur cohérente) ;
- **focus visible** (ring 2 px primary) ;
- **état erreur** : bordure rouge + message sous le champ ;
- **état succès** : bordure verte ou check icon ;
- **champs obligatoires** : marqués `*` ou texte ;
- **bouton submit** clair (pas *"Envoyer"* tout court — *"Envoyer le message"*).

### Espacement

- **24 px** entre champs verticalement ;
- **8 px** entre label et input ;
- **4 px** entre input et helper / error.

### Validation

- **côté client** (HTML5 `required`, `pattern`, `type=email`) ;
- **côté serveur** (toujours, jamais seulement client) ;
- **erreurs localisées** au champ concerné ;
- **erreurs annoncées** aux lecteurs d'écran (`aria-invalid`, `aria-describedby`) ;
- **succès** annoncé pareillement.

### Anti-patterns

- placeholder à la place du label (disparaît à la saisie) ;
- erreurs en haut de page sans pointer le champ concerné ;
- 30 champs sans regroupement / sections ;
- formulaire de contact qui demande 12 infos pour un simple contact ;
- bouton submit *"OK"* / *"Submit"* (vague) ;
- champs trop petits sur mobile (zone < 44 px de hauteur).

---

## 4. Champs spéciaux

### Email

```html
<input type="email" name="email" required autocomplete="email">
```

### Téléphone

```html
<input type="tel" name="phone" autocomplete="tel">
```

→ déclenche le clavier numérique sur mobile.

### Mot de passe

```html
<input type="password" name="password" required minlength="8" autocomplete="new-password">
```

→ pour reset / création : `new-password`. Pour login : `current-password`.

### Adresse

```html
<input type="text" name="address" autocomplete="street-address">
<input type="text" name="city" autocomplete="address-level2">
<input type="text" name="postal-code" autocomplete="postal-code">
```

→ `autocomplete` correct = champs auto-remplis par le navigateur (UX +++).

### Numérique

```html
<input type="number" name="quantity" min="1" max="99">
<!-- OU -->
<input type="text" inputmode="numeric" pattern="[0-9]*">
```

---

## 5. États globaux UI

### États vides

- liste / tableau vide : message + CTA + icône légère (cf. `frontend-admin-consistency.md` §9).

### États chargement

- skeleton ou spinner ;
- pour requêtes < 300 ms : pas de loader (UX flicker) ;
- pour requêtes > 300 ms : skeleton ;
- pour requêtes longues : barre de progression.

### États erreur

- toast en haut ou en bas (rouge) ;
- ou block d'erreur dans la zone concernée ;
- texte clair, pas un code d'erreur cryptique.

### États succès

- toast vert avec icône check ;
- auto-dismiss 3–5 s ;
- ou redirect vers la page suivante.

---

## 6. Cohérence inter-composants

### Règles

- même style de **boutons** partout ;
- même style de **cards** partout (par type) ;
- même style de **formulaires** partout ;
- même style de **toasts** ;
- même style de **modals**.

### Anti-patterns

- cards modernes sur la home, cards style 2018 sur la page services ;
- formulaire stylé sur la home, formulaire générique sur le contact ;
- 3 styles de toasts (un succès vert plein, un succès vert outline, un succès vert sans icône).

---

## 7. Detection automatique

```bash
# Boutons sans label clair
grep -rIE '<button[^>]*>(\s*Click here\s*|\s*Submit\s*|\s*OK\s*)</button>' \
  --include="*.html" --include="*.tsx" --include="*.jsx" --include="*.vue" --include="*.php" .

# Inputs sans label associé
grep -rIE '<input\b' --include="*.html" --include="*.tsx" --include="*.jsx" --include="*.vue" --include="*.php" .
# → vérifier manuellement chaque résultat pour la présence d'un <label for="...">

# href="#" suspects
grep -rIE 'href="#"|href="javascript:void\(0\)"' --include="*.html" --include="*.tsx" --include="*.jsx" --include="*.vue" --include="*.php" .
```

---

## 8. Checklist boutons / cards / formulaires

### Boutons

- [ ] **3 variantes max** (primary / secondary / ghost) ;
- [ ] **3 tailles max**, 1 par contexte ;
- [ ] **5 états** (default / hover / focus / active / disabled / loading) ;
- [ ] **focus visible** ;
- [ ] **libellés clairs** (verbe d'action) ;
- [ ] **icon-only** : `aria-label` ;
- [ ] **cohérence** sur tout le site.

### Cards

- [ ] **mêmes radius / border / shadow / padding** par type ;
- [ ] **titre lisible** ;
- [ ] **icônes cohérentes** (1 famille) ;
- [ ] **contenu équilibré** ;
- [ ] **hover state** si interactive ;
- [ ] **mobile** : empilées, lisibles ;
- [ ] **cohérence** inter-pages.

### Formulaires

- [ ] **labels visibles** ;
- [ ] **focus visible** ;
- [ ] **erreurs localisées** au champ ;
- [ ] **succès** clair après submit ;
- [ ] **champs obligatoires** marqués ;
- [ ] **submit** désactivé pendant l'envoi ;
- [ ] **autocomplete** activé ;
- [ ] **types** corrects (email, tel, number) ;
- [ ] **mobile** : utilisable (zones ≥ 44 px) ;
- [ ] **validation** client + serveur.

---

Created by João de Almeida
