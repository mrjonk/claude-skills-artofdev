# Checklist UX/UI — `production-auditor`

Created by João de Almeida — Art of Dev — https://artofdev.space

À dérouler en phase 3 (audit UX). L'œil d'un utilisateur réel, pas d'un développeur.

---

## 1. Navigation

- [ ] menu présent et **visible** sur toutes les pages ;
- [ ] tous les liens du menu fonctionnent (zéro 404) ;
- [ ] menu mobile (hamburger) testé et lisible ;
- [ ] indicateur de page active dans le menu ;
- [ ] cohérence : ordre des liens identique entre header et footer.

---

## 2. Hiérarchie visuelle

- [ ] **un seul `<h1>`** par page, et qui correspond au sujet de la page ;
- [ ] structure `<h2>` / `<h3>` cohérente (pas de saut `<h1>` → `<h4>`) ;
- [ ] taille de police cohérente entre pages similaires ;
- [ ] espacements (margins/paddings) cohérents ;
- [ ] aucun "mur de texte" sans respiration visuelle.

---

## 3. Design premium ou template-look

- [ ] **ne ressemble pas** à un thème WordPress par défaut ;
- [ ] pas de "Hello World" ou "Lorem ipsum" résiduel ;
- [ ] palette de couleurs cohérente (max 3 couleurs principales + neutres) ;
- [ ] vraie direction artistique (cf. `CLAUDE_PROJECT_FACTORY.md` §15) ;
- [ ] hero avec un effet wow (image forte, gradient subtil, typographie soignée) ;
- [ ] cards bien équilibrées (pas une carte à 50% et une à 100%) ;
- [ ] hover states sur les boutons et liens ;
- [ ] icônes cohérentes (pas un mix de Font Awesome + Material + emojis).

---

## 4. Polices

- [ ] taille du body : 16 px minimum ;
- [ ] hero pas trop massif (pas d'`H1` à 120 px qui sort de l'écran mobile) ;
- [ ] line-height confortable (1.4–1.6) ;
- [ ] max 2 familles de polices (1 display + 1 body) ;
- [ ] poids de police cohérents (pas un mix `300/400/600/700/900` désordonné).

---

## 5. CTA (Calls to Action)

- [ ] CTA principal **visible** dès l'ouverture de la homepage ;
- [ ] verbe d'action clair (`Réserver`, `Commencer`, `Demander un devis`) — **pas** `Cliquez ici` ;
- [ ] couleur du CTA principal **distincte** des CTA secondaires ;
- [ ] CTA cohérent dans toutes les pages (pas un `Réserver` puis un `Book now` ailleurs) ;
- [ ] CTA répété raisonnablement (header + section + footer ≈ 3 max) ;
- [ ] CTA mène à une action **réelle** (pas vers `#`).

---

## 6. Formulaires

- [ ] labels présents pour chaque champ ;
- [ ] champs obligatoires marqués ;
- [ ] validation côté client (HTML5) **et** côté serveur ;
- [ ] messages d'erreur clairs et **localisés au champ** ;
- [ ] feedback de succès clair ;
- [ ] bouton submit désactivé pendant l'envoi (anti double-soumission) ;
- [ ] formulaires accessibles au clavier ;
- [ ] CAPTCHA / honeypot si formulaire public exposé.

---

## 7. États vides

- [ ] aucun tableau ou liste vide sans message ("Aucune donnée pour le moment") ;
- [ ] message d'état vide accompagné d'une **action** ("Ajouter un premier élément") ;
- [ ] illustration ou icône légère pour ne pas avoir une page blanche ;
- [ ] cas covered : aucune donnée, recherche sans résultat, filtre sans résultat.

---

## 8. Feedback utilisateur

- [ ] toasts / notifications après action (sauvegarde, suppression) ;
- [ ] loaders pendant les opérations longues ;
- [ ] confirmation avant action destructive (suppression) ;
- [ ] succès et erreur **différenciés** visuellement (couleur, icône) ;
- [ ] auto-dismiss des toasts après 3–5 s.

---

## 9. Cohérence des pages

- [ ] header et footer identiques sur toutes les pages publiques ;
- [ ] style de boutons cohérent (pas un bouton arrondi puis un carré) ;
- [ ] espacement vertical des sections cohérent ;
- [ ] traitement des images cohérent (toutes en ratio 16:9 ou 4:3, pas un mix) ;
- [ ] cohérence de langue (pas de mots anglais qui apparaissent dans une UI française et vice versa).

---

## 10. Responsive

- [ ] testé à 320 px (mobile S), 375 px (mobile M), 768 px (tablet), 1024 px (laptop), 1440 px (desktop) ;
- [ ] aucun overflow horizontal ;
- [ ] menu mobile fonctionne ;
- [ ] images responsives (`max-width: 100%`) ;
- [ ] textes lisibles sans zoom sur mobile ;
- [ ] CTA atteignables au pouce (zone de 44 × 44 px minimum).

---

## 11. Accessibilité basique

- [ ] contrastes AA (texte foncé sur fond clair, ratio ≥ 4.5:1) ;
- [ ] navigation au clavier (Tab/Shift+Tab) fonctionnelle ;
- [ ] focus visible sur les éléments interactifs ;
- [ ] `alt` non vide sur images informatives ;
- [ ] `aria-label` sur boutons sans texte ;
- [ ] vidéos avec sous-titres si contenu informatif ;
- [ ] formulaires utilisables au lecteur d'écran (labels associés).

---

## 12. Densité d'information

- [ ] pas de "wall of features" ennuyeux ;
- [ ] sections espacées ;
- [ ] sections **utiles** uniquement (pas de section ajoutée pour remplir) ;
- [ ] longueur des pages raisonnable (pas une homepage 8000 px de haut).

---

## 13. Footer

- [ ] **pas pauvre** : minimum 3 colonnes (navigation + contact/social + légal/copyright) ;
- [ ] mention copyright avec année dynamique ;
- [ ] liens vers pages légales (mentions, CGU, RGPD/cookies si applicable) ;
- [ ] liens sociaux fonctionnels (pas vers `#`) ;
- [ ] cohérence visuelle avec le reste du site.

---

## 14. Effet premium

Cf. `CLAUDE_PROJECT_FACTORY.md` §16. Vérifier au moins un de :

- hero avec image forte et bien cadrée ;
- gradient subtil bien intégré ;
- overlay élégant sur images ;
- animation légère au scroll (sans sur-charger) ;
- compteur ou stats si pertinent ;
- typographie soignée (pas Arial nue) ;
- micro-interactions (hover de cards, transitions douces).

---

## 15. Clarté pour l'utilisateur final

L'utilisateur doit pouvoir :

- comprendre **en 5 secondes** ce que fait le site ;
- trouver **en un clic** ce qu'il cherche ;
- savoir **où il est** (breadcrumbs, indicateur de page active) ;
- savoir **quoi faire** (un CTA dominant) ;
- contacter facilement (email, téléphone, formulaire visibles).

---

## Sortie attendue

Pour chaque item failed :

- **page / écran** concerné (`/`, `/admin`, `/contact`, `/checkout`…) ;
- **gravité** : `critique` / `important` / `mineur` ;
- **impact** : 1 phrase utilisateur ("L'utilisateur ne sait pas comment réserver.") ;
- **correction recommandée** : 1 phrase actionnable.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
