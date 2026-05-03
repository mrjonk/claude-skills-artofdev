# Méthode de design — `premium-webdesigner`

Méthode complète **en 10 étapes**. À dérouler dans l'ordre.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. Comprendre le produit

Avant tout : **lire** ce qui existe.

- `README.md` du projet ;
- structure des dossiers (`pages/`, `templates/`, `views/`, `components/`) ;
- routes existantes ;
- contenu existant (textes, images) ;
- charte graphique si présente (`brand.md`, `style-guide.md`, fichier de variables CSS).

**Output :** une phrase qui résume le produit. *"App SaaS B2B de gestion de tâches focus, cible : freelances tech, action principale : démarrer une session focus."*

---

## 2. Identifier la cible

Pour qui ce design est-il fait ?

- **Persona** principale (1, 2 max) ;
- **Niveau d'expertise** (grand public / pro / expert) ;
- **Contexte d'usage** (mobile en transport / bureau en focus / showroom client) ;
- **Attentes implicites** (un avocat n'attend pas le même design qu'un DJ).

**Output :** *"Freelance tech, 25–40 ans, sensible au design Apple/Linear, utilise FocusForge sur desktop entre 2 sessions de code."*

---

## 3. Définir l'objectif de conversion

Quelle action doit déclencher cette page ?

- **Action principale** (1 seule, pas 5) ;
- **Action secondaire** (1 acceptable) ;
- **Indicateur de succès** (taux de clic, taux de complétion, temps passé).

**Output :** *"Action principale : créer un compte gratuit. Action secondaire : voir une démo. KPI : taux de clic sur 'Démarrer gratuitement'."*

---

## 4. Analyser l'existant

Si une version existe déjà :

- screenshots (mental ou textuel) des pages clés ;
- liste des forces (qu'est-ce qui marche déjà ?) ;
- liste des faiblesses (qu'est-ce qui fait template / basique / cassé ?) ;
- identifie les **incohérences** (footer ≠ header, polices mélangées, couleurs aléatoires).

**Output :** liste *forces / faiblesses / incohérences* en bullets, avec fichiers concernés.

---

## 5. Chercher des inspirations

Ouvrir / consulter :

- **21st.dev** community → catégorie correspondant au besoin ;
- **shadcn/ui** docs → composants atomiques ;
- **Lucide** → icônes ;
- **Motion (Framer Motion)** → si animations React ;
- **Unsplash** / **Pixabay** → images ;
- **2 ou 3 sites de référence** dans le secteur (concurrents directs ou produits similaires premium).

**Règles d'inspiration :**

- chercher la **logique** derrière le design, pas la copie pixel-perfect ;
- noter ce qui se répète sur 3+ sites premium (= convention sectorielle) ;
- noter ce qui se distingue (= leur signature de marque) ;
- éviter de copier la signature des autres ; s'inspirer du fond, pas du tatouage.

**Output :** un **moodboard** (mental ou écrit) listant 3–5 références avec leur leçon utile.

---

## 6. Choisir les composants

À partir des inspirations + besoins, lister les composants à utiliser.

Cf. [`component-selection-guide.md`](component-selection-guide.md). Pour chaque composant :

- **nom**,
- **source** (21st.dev / shadcn / custom),
- **URL**,
- **usage** dans le projet,
- **adaptations** nécessaires,
- **dépendances** ajoutées (si Motion, Lucide, etc.),
- **risque** identifié (perf, accessibilité, responsive).

Documenter dans `templates/component-selection.template.md`.

**Output :** tableau de composants documenté.

---

## 7. Choisir les images

Cf. [`image-sourcing-guide.md`](image-sourcing-guide.md).

Étapes :

1. dresser la **liste des emplacements images** (hero, sections, illustrations, avatars…) ;
2. par emplacement : type d'image, ambiance attendue, mots-clés ;
3. recherche dans cet ordre : assets locaux → Pixabay → Unsplash → placeholder ;
4. **documenter chaque image** (template `image-selection.template.md`).

**Output :** tableau d'images + dossier `public/assets/images/` organisé.

---

## 8. Définir le design system

Cf. [`design-system-rules.md`](design-system-rules.md). Sortir un mini design system :

- **Palette** (4–6 couleurs : 1 dominante, 1 accent, 1–2 neutres, 3 sémantiques) ;
- **Typographie** (1 display + 1 body, échelle 12/14/16/18/20/24/30/36/48/60/72) ;
- **Spacing** (unité 4 ou 8 px, échelle géométrique) ;
- **Radius** (3 valeurs max : sm/md/lg) ;
- **Shadows** (2 niveaux max) ;
- **Boutons** (3 variantes : primary / secondary / ghost) ;
- **Cards** (1 ou 2 styles, max) ;
- **Animations** (durée 150–300 ms, ease-out, max 2–3 motifs) ;
- **Breakpoints** (sm/md/lg/xl) ;
- **Mode** (light, dark si demandé).

**Output :** `design-system.template.md` rempli + variables CSS / Tailwind config / SCSS.

---

## 9. Implémenter

**Et seulement maintenant** modifier l'existant ou créer les nouveaux composants.

Règles :

- respecter la stack existante (cf. `SKILL.md §5.3`) ;
- ne pas casser les routes / formulaires / auth / paiement ;
- ne pas remplacer les données BDD par du hardcodé ;
- modifier de manière **réversible** (un `git revert` doit suffire) ;
- documenter chaque fichier modifié ;
- commit logique (1 phase = 1 commit).

**Output :** le projet est mis à jour, fichier par fichier, avec diffs propres.

---

## 10. Vérifier la qualité

Cf. [`ux-ui-checklist.md`](ux-ui-checklist.md), [`responsive-checklist.md`](responsive-checklist.md), [`accessibility-checklist.md`](accessibility-checklist.md), [`anti-basic-design-rules.md`](anti-basic-design-rules.md).

Tests :

- responsive 320 / 768 / 1024 / 1440 ;
- contraste AA (≥ 4.5:1 sur texte) ;
- navigation clavier (Tab visible) ;
- aucune erreur HTML ou warning console ;
- LCP < 2.5 s sur la home ;
- aucun design "basique" (cf. anti-basic) ;
- testé dans 2 navigateurs minimum (Chromium + Firefox).

**Output :** `redesign-report.template.md` rempli avec score `ui-quality-checklist`.

---

## Récap visuel

```txt
1. Comprendre  →  2. Cible  →  3. Conversion  →  4. Existant
       ↓
5. Inspirations  →  6. Composants  →  7. Images  →  8. Design system
       ↓
9. Implémenter  →  10. Vérifier qualité
       ↓
   Rapport final
```

**Règle d'or :** *si on saute une étape, on retombe dans le design basique.*

---

Created by João de Almeida — Art of Dev — https://artofdev.space
