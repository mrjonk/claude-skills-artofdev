# Workflow 21st.dev — `premium-webdesigner`

Comment utiliser **21st.dev** comme source d'inspiration et de composants.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## C'est quoi 21st.dev ?

`21st.dev` est une **bibliothèque communautaire** de composants UI modernes (principalement React + Tailwind + shadcn/ui).

Ce n'est ni une librairie officielle ni un design system canonique — c'est un **catalogue d'inspirations**, dont la qualité varie d'un composant à l'autre.

Le skill `premium-webdesigner` l'utilise pour **gagner du temps sur l'inspiration** et **ne pas réinventer** des patterns qui existent déjà.

---

## Quand consulter 21st.dev

**Toujours**, dans la phase B (recherche d'inspiration), si l'accès web est dispo et si le projet a une UI à concevoir.

**Pas pour** : un repo doc-only, un script CLI, une API sans front.

---

## URLs canoniques

| URL | Usage |
|---|---|
| https://21st.dev/community/components | recherche générale |
| https://21st.dev/community/components/featured | sections critiques (hero, pricing, CTA) — composants curated |
| https://21st.dev/community/components/popular | composants éprouvés par la communauté |
| https://21st.dev/community/components/newest | inspiration récente, tendances |
| https://21st.dev/community/components/s/ui | filtre par tag "ui" |
| https://21st.dev/community/components/s/modern-ui | filtre par tag "modern-ui" |

---

## Catégories de composants à explorer

Selon le type de page à concevoir, prioriser ces catégories :

### Landing page / site public

- **Heros** — section principale ;
- **Features** — démonstration produit ;
- **Calls to Action** — conversion ;
- **Pricing Sections** — abonnements ;
- **Testimonials** — preuve sociale ;
- **Buttons** — CTA atomiques ;
- **Text Components** — typographie expressive.

### SaaS / Dashboard

- **Dashboard** — layouts admin ;
- **AI Chat Components** — si projet IA ;
- **UI** — recherche large ;
- **Modern UI** — recherche moderne.

---

## Comment choisir un composant

**Étapes :**

### 1. Préciser le besoin AVANT d'ouvrir le catalogue

Avant d'aller chercher : *"j'ai besoin d'un hero pour un SaaS B2B productivité, ambiance Linear / Cron, avec mockup app à droite et CTA simple"*.

Sans cette précision, on tombe sur 20 composants qui semblent "tous bien" et on perd 30 min.

### 2. Filtrer par catégorie

Aller direct dans la catégorie correspondante (Heros, Pricing, CTA…).

### 3. Filtrer par section adaptée

- **Featured** + **Popular** pour des sections **critiques** (hero, pricing, CTA principal de conversion). Ce sont les briques qui doivent fonctionner ; on prend des **valeurs sûres**.
- **Newest** pour de l'**inspiration récente** ou pour un site qui doit avoir l'air daté de 2026 (et pas de 2022).

### 4. Critères de sélection (par composant)

Pour chaque composant retenu, vérifier :

| Critère | Question |
|---|---|
| **Adéquation produit** | est-ce que ce composant sert mon produit, ou seulement mon goût ? |
| **Stack** | est-ce que je peux l'intégrer sans casser mon projet ? |
| **Dépendances** | ajoute-t-il une lib (Motion, lib graphique) acceptable ou pénalisante ? |
| **Responsive** | est-il responsive natif ou faudra-t-il tout réécrire ? |
| **Accessibilité** | a-t-il `aria-*`, focus visible, contrastes corrects ? |
| **Performance** | image / animation lourde ? bundle size raisonnable ? |
| **Code quality** | propre, lisible, ou "fait à la va-vite" ? |

### 5. Ne pas choisir parce que c'est joli

Le piège classique : *"oh ce hero animé est super beau, je le prends"* — sauf qu'il est en Three.js, ajoute 600 Ko de bundle, ne tourne pas en mobile, et n'a aucun rapport avec le produit.

**Filtrer** par adéquation, pas par esthétique pure.

---

## Comment intégrer un composant 21st.dev

### 1. Documenter le choix

**Avant** d'intégrer : remplir une ligne dans `templates/component-selection.template.md` :

```markdown
| Composant | Hero with split mockup |
| Source | 21st.dev community |
| URL | https://21st.dev/.../<slug> |
| Usage | Homepage SaaS — hero principal |
| Pourquoi | mockup à droite met le produit en valeur, ambiance proche de Linear |
| Risques | image mockup à fournir, animation Motion ajoute 30 Ko |
| Adaptations | replacer la couleur primary par la nôtre, traduire textes en français |
| Dépendances | framer-motion (~30 Ko), lucide-react |
| Impact responsive | OK 768/1024/1440, à vérifier 320 |
| Impact perf | LCP +200 ms (mockup PNG à optimiser en WebP) |
```

### 2. Adapter au design system

**Ne jamais** importer un composant tel quel. Toujours :

- remplacer les **couleurs** par celles du design system du projet ;
- remplacer la **typographie** par celle du projet ;
- remplacer les **icônes** par la famille du projet (Lucide, etc.) ;
- traduire / adapter les **textes** ;
- adapter les **espacements** à l'échelle du projet ;
- adapter les **radius** et **shadows** à la cohérence générale.

### 3. Nettoyer le code importé

Composants 21st.dev = code communautaire. Souvent :

- imports inutiles ;
- styles redondants ;
- props non utilisées ;
- commentaires en anglais à retirer.

**Nettoyer** avant commit. Le code final doit être lisible comme s'il avait été écrit pour ce projet.

### 4. Vérifier responsive + accessibilité

Tester systématiquement :

- 4 breakpoints (320 / 768 / 1024 / 1440) ;
- navigation clavier (Tab, Enter, Escape) ;
- contraste AA ;
- focus visible.

### 5. Vérifier les dépendances

Un composant qui ajoute :

- ✅ Lucide → OK (déjà dans la stack du projet) ;
- ✅ Motion / Framer Motion → acceptable si projet React et animations souhaitées ;
- ⚠️ Three.js / WebGL → réfléchir 2 fois (poids, perf mobile) ;
- ⚠️ une lib graphique custom (chartjs, recharts) → voir si le projet en a déjà une ;
- ❌ une lib jamais entendue parlée → red flag, chercher une alternative.

---

## Anti-pattern : la mosaïque de composants incohérents

Le piège : *"je prends ce hero de 21st.dev, ce pricing d'un autre, ce footer d'un troisième"*.

Résultat : chaque section a son propre style, ses propres radius, ses propres ombres → **patchwork incohérent**.

**Solution :**

- **un seul** `design-system.template.md` à la base ;
- **chaque composant** importé doit être **réharmonisé** avec ce design system ;
- préférer **3 composants bien adaptés** à **8 composants mal réharmonisés**.

---

## Si l'accès à 21st.dev n'est pas disponible

Cas fréquent (sandbox, firewall, hors ligne).

**Comportement attendu :**

1. **Le dire** : *"Je n'ai pas accès à 21st.dev depuis cet environnement."*
2. Proposer une **shortlist** de 3–5 composants nommés (sans URL inventée) :
   ```
   Pour un hero SaaS productivité, je recommande de chercher manuellement :
     - "Hero with split mockup" (catégorie Heros, featured)
     - "Hero with feature grid" (catégorie Heros)
     - "Bento hero" (catégorie Heros)
   ```
3. Demander à l'utilisateur de valider / partager les URLs trouvées.
4. **Ne jamais** prétendre avoir consulté une page non vérifiée.

---

## Grille de décision finale (à remplir)

Pour chaque composant :

```markdown
| Composant | <nom> |
|---|---|
| Source | 21st.dev community / featured / popular / newest |
| URL | https://21st.dev/... |
| Usage prévu | <où l'utiliser dans le projet> |
| Pourquoi pertinent | <2 lignes max> |
| Risques | <perf / responsive / accessibilité> |
| Adaptations nécessaires | <design system, traduction, etc.> |
| Dépendances ajoutées | <packages npm> |
| Impact responsive | <OK / À vérifier / À réécrire> |
| Impact performance | <LCP, bundle size> |
```

Remplir dans `templates/component-selection.template.md` à chaque utilisation.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
