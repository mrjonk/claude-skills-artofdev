# Checklist UX/UI — `premium-webdesigner`

À dérouler en phase 10 (vérification qualité).

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. Navigation

- [ ] menu principal **visible** sur toutes les pages publiques ;
- [ ] tous les liens du menu **fonctionnent** (zéro 404) ;
- [ ] menu **mobile** (burger / drawer) testé et lisible ;
- [ ] indicateur de **page active** (souligné, fond, couleur) ;
- [ ] cohérence header **et** footer (mêmes liens dans le même ordre si possible) ;
- [ ] CTA primaire visible dans la navbar.

---

## 2. Hiérarchie visuelle

- [ ] **un seul `<h1>`** par page ;
- [ ] `<h1>` clair, en lien direct avec le sujet ;
- [ ] structure `<h2>` / `<h3>` cohérente (pas de saut `<h1>` → `<h4>`) ;
- [ ] échelle de tailles claire (différence d'au moins 4 px entre niveaux) ;
- [ ] poids typographiques cohérents ;
- [ ] **un** point focal par section (pas 5 éléments qui crient en même temps).

---

## 3. CTA

- [ ] **un seul CTA primaire** par section critique ;
- [ ] verbe d'action clair (`Réserver`, `Commencer`, `Demander un devis`) ;
- [ ] CTA **visible** dès la zone visible (au-dessus de la ligne de flottaison) ;
- [ ] couleur du CTA primaire **distincte** des CTA secondaires ;
- [ ] zone clickable **≥ 44 × 44 px** sur mobile ;
- [ ] feedback hover et active ;
- [ ] focus visible au clavier.

---

## 4. Responsive

- [ ] testé à **320 px** (mobile S), **375 px** (mobile M), **768 px** (tablet), **1024 px** (laptop), **1440 px** (desktop) ;
- [ ] aucun **overflow horizontal** ;
- [ ] menu mobile fonctionne et lisible ;
- [ ] images responsives (`max-width: 100%`) ;
- [ ] textes lisibles sans zoom ;
- [ ] CTA atteignables au pouce.

Cf. [`responsive-checklist.md`](responsive-checklist.md) pour détails.

---

## 5. Lisibilité

- [ ] body 16 px **minimum** ;
- [ ] line-height confortable (1.4–1.6) ;
- [ ] longueur de ligne 50–80 caractères en lecture longue ;
- [ ] contraste **AA** (≥ 4.5:1 sur texte normal, ≥ 3:1 sur grand texte) ;
- [ ] aucun texte clair sur fond clair ou foncé sur foncé ;
- [ ] aucun texte sur image sans overlay assombri si nécessaire.

---

## 6. Focus utilisateur

- [ ] l'utilisateur comprend en **5 secondes** ce que fait le site ;
- [ ] sait **où il est** (breadcrumbs ou indicateur clair) ;
- [ ] sait **quoi faire** (un CTA dominant) ;
- [ ] sait comment **revenir** (logo cliquable vers home, menu cohérent) ;
- [ ] peut **contacter** facilement (email, formulaire, téléphone visibles).

---

## 7. Densité

- [ ] **rythme visuel** alterné (sections denses + sections aérées) ;
- [ ] **pas** de "wall of features" 12 cards identiques d'affilée ;
- [ ] **pas** de pages 8000 px de haut sans pause visuelle ;
- [ ] sections clairement **différenciées** (background, espacement, accent) ;
- [ ] **respiration** entre éléments (padding/margin de l'échelle de spacing).

---

## 8. Flow utilisateur

- [ ] le parcours d'inscription / commande / contact est **fluide** ;
- [ ] **pas** plus de 3 étapes pour une action critique ;
- [ ] aucune étape inutile ;
- [ ] un retour en arrière est **toujours possible** ;
- [ ] confirmation après action critique.

---

## 9. Conversion

- [ ] homepage : 1 CTA principal (pas 8) ;
- [ ] page produit / pricing : prix clair, CTA bien visible ;
- [ ] formulaire de contact : court (3–5 champs max) ;
- [ ] réassurance présente (testimonials, logos clients, garanties) ;
- [ ] aucune **friction** inutile (sign-up qui demande la couleur préférée) ;
- [ ] mobile : CTA toujours accessible (sticky bottom si pertinent).

---

## 10. États d'erreur

- [ ] **page 404** custom et accueillante (pas l'écran serveur brut) ;
- [ ] **page 500** custom et silencieuse (pas de stack-trace exposé) ;
- [ ] formulaires : erreurs **localisées** au champ, message clair ;
- [ ] feedback erreur **sans dramatiser** (pas un toast rouge plein écran) ;
- [ ] action de récupération suggérée ("Réessayer", "Contacter le support").

---

## 11. États vides

- [ ] **toujours** géré sur les listes / tableaux / dashboards ;
- [ ] message + action ("Aucun lead pour le moment — Ajouter un premier lead") ;
- [ ] illustration ou icône légère ;
- [ ] pas une page totalement vide qui semble cassée.

---

## 12. Microcopy

- [ ] textes des **boutons** : verbes d'action concrets ;
- [ ] textes d'**aide** : utiles, pas évidents ;
- [ ] textes d'**erreur** : précis, suggèrent une action ;
- [ ] textes de **confirmation** : rassurants ("Votre demande a été envoyée. Réponse sous 24 h.") ;
- [ ] **pas** de jargon technique côté utilisateur final ;
- [ ] **pas** de phrases creuses marketing ("Révolutionnez votre productivité") ;
- [ ] **pas** de lorem ipsum résiduel.

---

## 13. Touch / interaction

- [ ] zones cliquables ≥ 44 × 44 px sur mobile ;
- [ ] hover states sur desktop ;
- [ ] active states (feedback au clic / tap) ;
- [ ] pas de hover-only critical (sur mobile, pas de hover) ;
- [ ] scroll fluide (pas de scroll-jacking agressif) ;
- [ ] formulaires utilisables au clavier de bout en bout.

---

## 14. Performance perçue

- [ ] pas de **flash of unstyled content** (FOUC) ;
- [ ] pas de **layout shift** majeur (CLS < 0.1) ;
- [ ] images avec `width` / `height` explicites ;
- [ ] LCP < 2.5 s sur la home ;
- [ ] skeleton ou loader pour chargements > 300 ms ;
- [ ] feedback immédiat sur action utilisateur.

---

## 15. Cohérence

- [ ] design system appliqué uniformément ;
- [ ] **pas** une page A moderne et une page B legacy ;
- [ ] header et footer identiques sur toutes les pages publiques ;
- [ ] mêmes radius / shadows / boutons / forms partout ;
- [ ] tonalité éditoriale uniforme.

---

## Sortie attendue

Pour chaque item failed, lister dans le `redesign-report.template.md` :

- **page / écran** concerné ;
- **gravité** : critique / important / mineur ;
- **impact** utilisateur (1 phrase) ;
- **correction recommandée**.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
