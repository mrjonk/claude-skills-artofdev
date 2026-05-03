# Checklist SEO — `seo-content-engine`

À dérouler à la phase 6 (optimisation) et phase 7 (relecture).

Created by João de Almeida

---

## 1. `<title>`

- [ ] présent ;
- [ ] **unique** sur le site ;
- [ ] **50–60 caractères** (pour ne pas être tronqué dans les SERPs) ;
- [ ] contient le **mot-clé principal** naturellement ;
- [ ] **donne envie** de cliquer (curiosité, bénéfice, précision) ;
- [ ] **pas** sensationnaliste sans substance.

### Exemples

- ✅ *"Comment structurer une page produit SaaS qui convertit"* (60 car.)
- ✅ *"Optimiser un site Astro : guide pratique en 5 étapes"* (54 car.)
- ❌ *"Article"* (trop court, vide)
- ❌ *"Le guide ultime, complet et définitif pour absolument tout savoir sur le SEO en 2026"* (trop long, pompeux)

---

## 2. `<meta description>`

- [ ] présente ;
- [ ] **130–160 caractères** ;
- [ ] **résumé honnête** du contenu ;
- [ ] inclut le **mot-clé principal** au moins une fois ;
- [ ] peut inclure un **appel à la lecture** (ex : *"Découvrez comment X..."*) ;
- [ ] **pas** vague ni générique.

### Exemples

- ✅ *"Apprenez à structurer une page produit SaaS efficace : section hero, démonstration, pricing clair, FAQ et CTA. 5 exemples concrets."* (148 car.)
- ❌ *"Bienvenue sur notre site. Découvrez nos articles."* (générique, vide)

---

## 3. Slug

- [ ] **kebab-case** (mots séparés par `-`) ;
- [ ] **minuscules** ;
- [ ] **3–5 mots** maximum ;
- [ ] **descriptif** (un humain comprend le sujet) ;
- [ ] **sans accents** ni caractères spéciaux ;
- [ ] **sans mots vides** (*"le"*, *"la"*, *"un"*, *"de"*) sauf si nécessaire au sens.

### Exemples

- ✅ `structurer-page-produit-saas`
- ✅ `astro-optimisation-performance`
- ❌ `mon-super-article-final-v2` (vide de sens)
- ❌ `comment-faire-pour-bien-structurer-sa-page-produit-saas-en-2026` (trop long)

---

## 4. H1

- [ ] **un seul** `<h1>` par page ;
- [ ] **proche du title** mais **pas identique** ;
- [ ] inclut le **mot-clé principal** ;
- [ ] **explicite** sur le sujet ;
- [ ] **lisible** (pas un mot-clé bourré).

### Exemple

- `<title>` : *"Comment structurer une page produit SaaS qui convertit"*
- `<h1>` : *"Structurer une page produit SaaS : la méthode en 7 sections"*

---

## 5. H2

- [ ] **logiques** et **séquentiels** (chaque H2 est une étape ou un point distinct) ;
- [ ] **descriptifs** (un humain comprend le contenu de la section sans lire le détail) ;
- [ ] **incluent** au moins un **mot-clé secondaire** quand c'est naturel ;
- [ ] **3 à 8 H2** par article (au-delà : sectionner différemment) ;
- [ ] **pas** de H2 répétés (*"Conseils"* deux fois → reformuler).

### Bons exemples

- ✅ *"Choisir le hero qui pose le problème"*
- ✅ *"Construire une démo qui n'enlise pas le visiteur"*
- ❌ *"Section 1"* (vide)
- ❌ *"Tips"* (générique)

---

## 6. H3

- [ ] **utilisés** uniquement quand un H2 a plusieurs sous-points ;
- [ ] **descriptifs** (jamais *"Étape 1"* seul, mais *"Étape 1 — Identifier le mot-clé principal"*) ;
- [ ] **cohérents** dans la hiérarchie (jamais sauter `<h1>` → `<h3>`).

---

## 7. Mot-clé principal

- [ ] **identifié** dès le brief ;
- [ ] présent dans :
  - [ ] `<title>` ;
  - [ ] `<meta description>` ;
  - [ ] `<h1>` ;
  - [ ] **première phrase** ou premier paragraphe ;
  - [ ] **au moins** un `<h2>` ;
  - [ ] **conclusion** si naturel ;
  - [ ] **alt text** d'au moins une image.
- [ ] **densité** 1–2 % du texte (pas plus, sinon spam) ;
- [ ] **variations** naturelles autorisées (singulier/pluriel, synonymes).

---

## 8. Mots-clés secondaires

- [ ] **2 à 4** identifiés ;
- [ ] présents **naturellement** dans :
  - [ ] H2 ou H3 ;
  - [ ] paragraphes pertinents ;
  - [ ] FAQ.
- [ ] **pas forcés** (si une formulation sonne forcée, retirer le mot-clé).

---

## 9. Intention de recherche

- [ ] **identifiée** dès le cadrage (cf. `editorial-methodology.md` phase 2) ;
- [ ] **respectée** par le format de l'article :
  - intention informationnelle → guide / définition ;
  - intention tutoriel → step-by-step ;
  - intention comparative → tableau ou liste critères ;
  - intention transactionnelle → page produit avec CTA clair ;
  - intention problème → troubleshooting / FAQ.

---

## 10. FAQ

- [ ] présente si pertinent (la plupart des articles long format en bénéficient) ;
- [ ] **3 à 8 questions** ;
- [ ] questions **réellement** posées par les utilisateurs (pas inventées) ;
- [ ] réponses **claires** et **autonomes** ;
- [ ] **format Schema.org `FAQPage`** prévu si CMS le permet (cf. `internal-linking-guide.md`).

Cf. `faq-writing-guide.md`.

---

## 11. Liens internes

- [ ] **3 à 6** liens internes proposés ;
- [ ] ancres **descriptives** (pas *"cliquez ici"*) ;
- [ ] **raison** documentée pour chaque lien ;
- [ ] **pas de bourrage** (max 8 liens internes pour un article standard).

Cf. `internal-linking-guide.md`.

---

## 12. Images

- [ ] **image principale** prévue (hero) ;
- [ ] **alt text** non vide pour images informatives ;
- [ ] **alt text** vide explicite (`alt=""`) pour images décoratives ;
- [ ] **format** `WebP` recommandé (fallback JPEG) ;
- [ ] **dimensions** explicites pour éviter CLS ;
- [ ] **lazy-loading** sous la ligne de flottaison ;
- [ ] **eager** + `fetchpriority="high"` sur le hero.

Cf. `image-planning-guide.md`.

---

## 13. Sources

- [ ] toutes les **affirmations factuelles** ont une source ;
- [ ] toutes les **statistiques** ont une source ;
- [ ] toutes les **citations** sont vérifiées ;
- [ ] sources **officielles** privilégiées ;
- [ ] section *"Sources"* en bas d'article ;
- [ ] section *"Sources à vérifier avant publication"* si l'accès web n'était pas dispo.

Cf. `source-citation-guide.md`.

---

## 14. CTA

- [ ] **un seul** CTA principal en fin d'article ;
- [ ] **lié** au sujet ;
- [ ] **action concrète** (pas *"Cliquez ici"*) ;
- [ ] **vers une destination claire** (page interne, doc, démo) ;
- [ ] **CTA secondaire** optionnel inline si pertinent (jamais 5 CTA différents).

---

## 15. Performance et lecture

- [ ] longueur de **paragraphes** raisonnable (3–5 lignes max) ;
- [ ] **listes à puces** pour les énumérations ;
- [ ] **gras** uniquement sur les mots-clés vraiment importants ;
- [ ] **pas** d'italique abusif ;
- [ ] **temps de lecture** estimé en début d'article (utile pour le lecteur) ;
- [ ] **table des matières** générée si article > 1500 mots.

---

## 16. Schema.org / données structurées

Selon le type de contenu :

- **`Article`** pour blog / actualité ;
- **`HowTo`** pour tutoriel step-by-step ;
- **`FAQPage`** si FAQ ;
- **`Product`** pour page produit ;
- **`Service`** pour page service ;
- **`Organization`** sur la home si applicable.

Souvent généré par les plugins SEO (Yoast, Rank Math, SEO Framework). À vérifier que c'est bien activé.

---

## 17. Open Graph / Twitter Card

- [ ] `<meta property="og:title">` ;
- [ ] `<meta property="og:description">` ;
- [ ] `<meta property="og:image">` (1200 × 630 px recommandé) ;
- [ ] `<meta property="og:url">` ;
- [ ] `<meta name="twitter:card" content="summary_large_image">` ;
- [ ] testé via Facebook Debugger / Twitter Card Validator.

---

## Checklist finale (à cocher avant publication)

- [ ] title 50–60 car.
- [ ] meta description 130–160 car.
- [ ] slug propre
- [ ] H1 unique
- [ ] structure H2/H3 cohérente
- [ ] mot-clé principal placé naturellement
- [ ] mots-clés secondaires présents
- [ ] intention de recherche respectée
- [ ] FAQ utile
- [ ] 3–6 liens internes
- [ ] images avec alt
- [ ] sources citées
- [ ] CTA naturel
- [ ] OG / Twitter Card OK
- [ ] Schema.org pertinent
- [ ] score qualité ≥ 76

---

Created by João de Almeida
