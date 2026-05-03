# Guide de hiérarchie visuelle — `site-ux-guardian`

Comment vérifier qu'une page **guide l'œil** correctement.

Created by João de Almeida

---

## 1. La règle de base

Une page bien hiérarchisée se **scanne** : l'utilisateur identifie en **3 secondes** :

1. **Quel est le sujet** (titre H1) ;
2. **Quelle est l'action principale** (CTA dominant) ;
3. **Comment est structuré le contenu** (H2, sections).

Si la réponse à l'une de ces questions n'est pas claire → la hiérarchie est cassée.

---

## 2. Vérifier le H1

### Règles

- **un seul** `<h1>` par page (zéro ou deux = bug) ;
- correspond au **sujet** de la page ;
- placé **en haut** de la zone de contenu (souvent dans le hero) ;
- taille **dominante** (mais pas écrasante) :
  - mobile : 36–48 px ;
  - desktop : 48–72 px ;
- contraste **AA** ;
- inclut le **mot-clé principal** SEO si applicable ;
- **pas un lien** (cliquable).

### Anti-patterns

- pas de `<h1>` du tout ;
- 3 `<h1>` (un dans le header, un dans le hero, un dans la sidebar) ;
- `<h1>` à 120 px qui sort de l'écran mobile ;
- `<h1>` *"Welcome to our website"* (vide de sens).

### Détection

```bash
grep -rIE '<h1\b' --include="*.html" --include="*.tsx" --include="*.jsx" --include="*.vue" --include="*.php" .
```

→ Compter le nombre de `<h1>` par page. Plus de 1 = problème.

---

## 3. Vérifier les H2 / H3

### Règles

- **3 à 8 H2** par page typiquement ;
- chaque H2 traite un **point distinct** ;
- structure **séquentielle** (pas de saut H1 → H4) ;
- libellés **descriptifs** (un humain comprend la section sans lire le détail) ;
- **mots-clés secondaires** SEO inclus naturellement.

### Anti-patterns

- H2 *"Section 1"*, *"Section 2"* (vides) ;
- 25 H2 sur la même page (devrait être plusieurs pages) ;
- H2 répétés (deux fois *"Conseils"*).

---

## 4. Identifier le CTA principal

### Règles

- **un seul** CTA primaire visible dès l'ouverture de la page ;
- couleur **distinctive** (couleur d'accent, contraste fort avec le fond) ;
- libellé d'**action concret** : *"Réserver"*, *"Commencer"*, *"Demander un devis"* ;
- **pas** *"Cliquez ici"* / *"En savoir plus"* sans contexte ;
- placé dans la **zone scrollable initiale** (above the fold).

### Anti-patterns

- 5 boutons primaires concurrents dans la même zone ;
- CTA primaire sous la ligne de flottaison ;
- CTA *"OK"* / *"Submit"* (vague) ;
- CTA dans la même couleur que les liens normaux.

---

## 5. Réduire la confusion visuelle

### Symptômes de confusion

- 6 couleurs d'accent qui crient en même temps ;
- 8 polices différentes ;
- gradients sur tous les composants ;
- ombres dramatiques partout ;
- animations sur chaque élément ;
- 3 colonnes égales sans hiérarchie.

### Solutions

- **palette restreinte** : 1 dominante + 1 accent + neutres ;
- **typographie disciplinée** : 2 familles, 3 poids ;
- **gradients et ombres parcimonieux** : 1–2 niveaux max ;
- **animations subtiles** : 150–300 ms, ease-out, sur les éléments interactifs uniquement.

---

## 6. Améliorer la lecture d'une page

### Patterns qui aident le lecteur

- **paragraphes courts** (3–5 lignes max) ;
- **listes à puces** pour les énumérations ;
- **gras** sur les mots-clés vraiment importants ;
- **sous-titres** régulièrement (tous les 200–300 mots) ;
- **images / schémas** pour aérer ;
- **callouts** ou **blockquotes** pour les passages importants ;
- **table des matières** si l'article > 1500 mots.

### À éviter

- pavés de 800 mots sans respiration ;
- gras sur 50 % du texte ;
- italique abusif ;
- changements de police entre paragraphes ;
- couleurs aléatoires dans le texte courant.

---

## 7. Repérer une page trop dense

### Signaux d'alerte

- aucun espace blanc entre les sections ;
- 12 cards sur la home ;
- `font-size` du body < 14 px ;
- `line-height` < 1.3 ;
- container sans `max-width` ;
- 5 sections de 600 px de hauteur sans pause visuelle.

### Solutions

- **séparer** les sections (96–128 px desktop, 48–64 px mobile) ;
- **réduire** le nombre d'éléments visibles à la fois ;
- **augmenter** la taille du body ;
- **borner** le container (1280 ou 1440 px max) ;
- **alterner** sections denses et sections aérées (rythme).

---

## 8. Échelle hiérarchique recommandée

```
H1 : 48 px (mobile) → 60 px (desktop) | poids 700 ou 600
H2 : 30 px         → 36 px            | poids 600
H3 : 24 px         → 24 px            | poids 600
H4 : 20 px         → 20 px            | poids 600
Body : 16 px      → 16 px              | poids 400
Small : 14 px     → 14 px              | poids 400
```

Cette échelle est **indicative**. Adapter selon la stack et la charte du projet.

---

## 9. Checklist hiérarchie visuelle

- [ ] **un seul** `<h1>` par page ;
- [ ] H1 inclut le sujet et idéalement le mot-clé principal ;
- [ ] structure H2 / H3 logique, pas de saut ;
- [ ] **un CTA primaire** identifiable dès l'ouverture ;
- [ ] palette restreinte (max 5 couleurs hors gris) ;
- [ ] typographie disciplinée (max 2 familles, 3 poids) ;
- [ ] échelle de tailles claire ;
- [ ] paragraphes courts, listes à puces, sous-titres réguliers ;
- [ ] espace blanc suffisant ;
- [ ] **test des 3 secondes** : un visiteur peut-il identifier sujet + action en 3 s ?

---

Created by João de Almeida
