# Webdesign Guidelines — `site-ux-guardian` (référence publique)

> Document public détaillant les règles visuelles vérifiées par le skill.
> Created by João de Almeida

---

## 1. Pourquoi ces règles

Un site **fonctionnel** n'est pas suffisant. Pour qu'un site soit **publiable**, il doit aussi être :

- **lisible** (typographie, contraste, line-height) ;
- **cohérent** (même style de composants partout) ;
- **hiérarchisé** (l'utilisateur sait quoi regarder) ;
- **professionnel** (pas template / amateur) ;
- **accessible** (WCAG AA minimum) ;
- **responsive** (4 breakpoints).

Les **14 axes** ci-dessous formalisent ces critères.

---

## 2. Les 14 axes

### A. Hiérarchie visuelle (12 pts)

L'œil de l'utilisateur doit pouvoir scanner la page en 3 secondes.

**Vérifie :**

- un seul `<h1>` par page ;
- structure `<h2>` / `<h3>` cohérente ;
- CTA principal identifiable ;
- ordre visuel : titre → contenu → action ;
- max 1 CTA primaire + 1 secondaire par section.

**Exemples de problèmes** : 3 H1, aucune hiérarchie typographique, 5 CTA concurrents, titres tous en taille identique.

---

### B. Lisibilité (10 pts)

Le texte doit être lisible **sans effort**.

**Vérifie :**

- body 16 px minimum ;
- line-height 1.4–1.6 ;
- contraste AA (≥ 4.5:1 sur texte normal) ;
- largeur de ligne 50–80 caractères en lecture longue ;
- pas de blocs trop denses ;
- pas de texte clair sur fond clair.

**Exemples de problèmes** : body 12 px, line-height 1.0, texte gris clair sur fond blanc, paragraphes de 800 mots sans aération.

---

### C. Typographie (10 pts)

Discipline typographique visible.

**Vérifie :**

- max 2 familles de polices (1 display + 1 body) ;
- max 3 poids (400 / 500 ou 600 / 700) ;
- échelle géométrique (12 / 14 / 16 / 18 / 20 / 24 / 30 / 36 / 48 / 60 px) ;
- cohérence inter-pages.

**Exemples de problèmes** : 6 polices différentes, 8 poids, tailles aléatoires (15, 17, 19, 21 px), titre sur la home en Cabinet Grotesk et titre sur about en Open Sans.

---

### D. Spacing (10 pts)

Échelle géométrique respectée.

**Vérifie :**

- valeurs de l'échelle uniquement (4 / 8 / 12 / 16 / 24 / 32 / 48 / 64 / 96 / 128 px) ;
- padding latéral mobile ≥ 16 px ;
- espacement entre sections : 48–64 px mobile, 96–128 px desktop ;
- cards avec padding interne cohérent (16 ou 24 px).

**Exemples de problèmes** : `padding: 17px` arbitraire, sections collées, espaces énormes sans raison, footer compressé.

---

### E. Layout (10 pts)

Mise en page disciplinée.

**Vérifie :**

- grilles cohérentes (12 colonnes desktop, 4–6 mobile) ;
- container max-width raisonnable (1280 ou 1440 px) ;
- alignements propres ;
- équilibre des colonnes.

**Exemples de problèmes** : colonnes 80 % / 10 % / 10 %, cards de hauteurs aléatoires, sections alignées différemment.

---

### F. Buttons / CTA (8 pts)

Boutons cohérents et fonctionnels.

**Vérifie :**

- 3 variantes max (primary / secondary / ghost) ;
- 3 tailles max (sm / md / lg), 1 par contexte ;
- états : default / hover / focus / active / disabled / loading ;
- focus visible au clavier ;
- libellés : verbe d'action concret ;
- icon-only avec `aria-label`.

**Exemples de problèmes** : 5 styles de boutons, focus invisible, libellés vagues ("OK", "Cliquez ici"), boutons décoratifs sans action.

---

### G. Cards (6 pts)

Cards homogènes par type.

**Vérifie :**

- mêmes radius / border / shadow / padding ;
- titre lisible ;
- icônes d'une seule famille ;
- contenu équilibré ;
- hover state si interactive.

**Exemples de problèmes** : radius 4 / 8 / 12 px mélangés, padding 4 px (texte collé), 12 cards identiques sans hiérarchie, cards vides.

---

### H. Formulaires (6 pts)

Formulaires utilisables et accessibles.

**Vérifie :**

- labels visibles au-dessus ;
- focus visible (ring 2 px) ;
- erreurs localisées au champ ;
- succès clair après submit ;
- champs obligatoires marqués ;
- bouton submit clair (verbe d'action) ;
- submit désactivé pendant l'envoi ;
- autocomplete activé ;
- types corrects (email, tel, number).

**Exemples de problèmes** : placeholder à la place du label, erreurs en haut sans pointer le champ, formulaire 30 champs sans regroupement, submit "OK".

---

### I. Tables / dashboards (6 pts)

Tables lisibles et utilisables.

**Vérifie :**

- colonnes lisibles ;
- headers visibles ;
- alignement (texte gauche, nombres droite) ;
- état vide géré ;
- pagination dès > 25 lignes ;
- filtres / recherche si applicable ;
- responsive : scroll ou conversion en cards.

**Exemples de problèmes** : table qui déborde mobile, pas de pagination sur 200 lignes, aucun état vide, alignement chaotique.

---

### J. Images (6 pts)

Images cohérentes et optimisées.

**Vérifie :**

- cohérence avec le contenu ;
- un seul style (photo OU illustration OU 3D) ;
- alt text non vide sur images informatives ;
- alt="" sur images décoratives ;
- ratios cohérents par type ;
- WebP + fallback JPEG ;
- dimensions adaptées ;
- width / height explicites (anti-CLS) ;
- lazy-load sous la ligne de flottaison ;
- aucun cliché stock corporate.

**Exemples de problèmes** : équipe en costume sur table, mains sur clavier, ampoule "idée", mix photo + illustration + 3D.

---

### K. Responsive (8 pts)

Site fonctionnel aux 4 breakpoints.

**Vérifie :**

- 4 breakpoints OK (320 / 768 / 1024 / 1440) ;
- aucun overflow horizontal ;
- menu mobile fonctionnel ;
- footer lisible mobile ;
- tables : scroll ou conversion en cards ;
- CTA atteignables au pouce (≥ 44 × 44 px).

**Exemples de problèmes** : menu desktop maintenu en mobile, scroll horizontal sur mobile, table illisible, boutons 24 × 24 px.

---

### L. Cohérence globale (8 pts)

Tout le site partage le même style.

**Vérifie :**

- mêmes boutons partout ;
- mêmes cards partout ;
- mêmes titres partout ;
- mêmes formulaires partout ;
- header / footer cohérents ;
- pas d'alternance moderne / ancien.

**Exemples de problèmes** : home moderne 2024, page services style 2018, 3 styles de cards selon la section.

---

### M. Accessibilité visuelle (4 pts)

WCAG AA minimum.

**Vérifie :**

- contraste AA ;
- focus visible ;
- liens identifiables ;
- alt text sur images ;
- pas d'animation flash (< 3× / sec) ;
- pas d'info uniquement par couleur ;
- `prefers-reduced-motion` respecté.

---

### N. Anti-template / anti-amateur (4 pts)

Le site a une **personnalité**.

**Vérifie :**

- pas de "Welcome to our website" résiduel ;
- pas d'image stock cliché ;
- footer riche (pas pauvre) ;
- design système identifiable ;
- **test du logo enlevé** : on devine secteur / cible / ton sans le logo ?

---

## 3. Score visuel — barème

| Score | Statut |
|---|---|
| 0–20 | Rendu cassé ou amateur |
| 21–40 | Interface incohérente |
| 41–60 | Utilisable mais très basique |
| 61–75 | Correct mais manque de finition |
| **76–90** | **Propre et professionnel** |
| 91–100 | Très cohérent, premium-ready |

---

## 4. Exemples de problèmes typiques

### Site "fonctionnel mais amateur"

Caractéristiques :
- design générique (look template par défaut) ;
- 3 styles de cards selon les sections ;
- gradients posés sans intention ;
- typo aléatoire (4–5 polices) ;
- footer pauvre (juste un copyright) ;
- mobile cassé (overflow horizontal) ;
- aucun focus visible.

→ Score visuel typique : **35–55 / 100**.
→ Recommandation : `premium-webdesigner` pour donner une vraie direction artistique.

### Site "cohérent mais visuellement moyen"

Caractéristiques :
- design system en place (mêmes boutons partout) ;
- typo disciplinée ;
- responsive OK ;
- mais pas d'effet wow ;
- contenu plat.

→ Score visuel typique : **65–75 / 100**.
→ Recommandation : `site-ux-guardian` corrige les détails ; `premium-webdesigner` optionnel pour passer en premium.

### Site "premium-ready"

Caractéristiques :
- direction artistique forte ;
- design system complet ;
- micro-interactions soignées ;
- responsive parfait ;
- accessibilité AA dépassée ;
- contenu adapté.

→ Score visuel typique : **85–100 / 100**.
→ `site-ux-guardian` ne propose plus que des polish mineurs.

---

## 5. Exemples de corrections sûres (Mode 2)

| Correction | Pourquoi sûre |
|---|---|
| Ajouter `<title>` manquant sur une page | aucun risque |
| Ajouter `alt` non vide sur image informative | aucun risque |
| Corriger une typo dans un libellé | aucun risque |
| Retirer un `console.log` oublié | aucun risque |
| Ajouter `aria-current="page"` sur lien actif | aucun risque |
| Harmoniser les radius des cards (vers une valeur de l'échelle) | risque visuel mineur |

---

## 6. Limites du skill

- **statique** : ne mesure pas le runtime, le LCP, le CLS en conditions réelles ;
- **performance** non auditée (déléguer à `production-auditor` pour Lighthouse) ;
- **rendu effectif** non vérifié (le skill lit le code, pas le navigateur) ;
- **certaines incohérences** peuvent être intentionnelles (artistic choice) — toujours vérifier avec l'utilisateur avant correction.

---

## 7. Recommandations finales

- utiliser `site-ux-guardian` **régulièrement** pendant le développement (pas juste à la fin) ;
- viser **76+** sur les deux scores avant publication ;
- déléguer à `premium-webdesigner` si la direction artistique manque ;
- déléguer à `production-auditor` pour la validation finale avant prod.

---

Created by João de Almeida
