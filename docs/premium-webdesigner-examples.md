# Exemples — `premium-webdesigner`

Created by João de Almeida — Art of Dev — https://artofdev.space

10 prompts prêts à copier. Chacun déclenche le skill et applique la méthode en 6 phases.

---

## 1. Landing page SaaS

```txt
Refonte premium de la homepage de cette app SaaS productivité.

Stack : Next.js 14 + Tailwind + shadcn/ui.
Cible : freelances tech 25-40 ans, sensibles au design Apple / Linear.
Action principale : créer un compte gratuit.
Émotion à transmettre : sérénité + performance.

Phases :
1. Brief design + moodboard.
2. Recherche 21st.dev : Hero (featured + popular), Pricing (popular), Features bento (newest), Footer 4 colonnes.
3. Direction artistique : palette tech + corail accent, typo Cabinet Grotesk + Inter, radius 6/12/24, shadows discrètes.
4. Images via Unsplash (PIXABAY_API_KEY et UNSPLASH_ACCESS_KEY dispos dans .env).
5. Implémentation section par section, commits séparés.
6. Rapport final : redesign-report.md + ui-quality-checklist.

Ne casse pas le pricing existant ni l'auth. Pas de push GitHub.
```

---

## 2. Dashboard admin

```txt
Améliore ce dashboard admin (gestion de leads B2B).

Stack : Laravel 11 + Tailwind + Alpine.js.
Utilisé par 5 commerciaux + 1 admin.
Pas de billing.

Vise :
- interface claire, moderne ;
- cards / badges / stats / filtres / empty states ;
- responsive desktop + tablet ;
- termes humains uniquement (pas "endpoint", pas "schema") ;
- termes en français ;
- focus visible au clavier.

Cherche 21st.dev catégorie Dashboard (featured + popular).
Brief avant d'implémenter. Ne casse pas le CRUD existant.
```

---

## 3. Site association

```txt
Refonte du site d'une association locale (jeunesse + activités culturelles).

Stack : WordPress 6.x + thème enfant.
Cible : familles, bénévoles, partenaires institutionnels.
Émotion : humain + chaleureux + crédible.

Vise :
- design qui transmet la communauté (cf. mots-clés image : community, gathering, cultural activity) ;
- pas template WordPress par défaut ;
- pages : accueil, mission, événements, adhérer, contact, dons ;
- accessibilité AA renforcée (cible diverse).

Pas de Next.js imposé. Reste sur WordPress.
Importe images via Pixabay (clé dispo).
Brief design avant d'implémenter.
```

---

## 4. Site artiste / portfolio

```txt
Refonte du portfolio d'une photographe (street photography + portraits).

Stack : HTML/CSS/JS classique (pas de framework).
Cible : galeries, magazines, clients privés.
Émotion : éditorial, contrasté, immersif.

Vise :
- direction artistique éditoriale (typographie marquée, layout magazine) ;
- galerie immersive (full-width, lazy-load, lightbox accessible) ;
- pages : home, séries, à propos, contact ;
- mode dark possible mais pas obligatoire ;
- responsive impeccable mobile.

Pas de React. Pas de Tailwind. CSS custom propre.
Cherche inspiration sur 21st.dev catégorie Heros + sites de référence éditoriaux.
Brief design détaillé avant d'implémenter.
```

---

## 5. Site label musical

```txt
Refonte du site d'un label de musique électronique indépendant.

Stack : Astro + Tailwind.
Cible : fans, programmateurs club/festival, presse spécialisée.
Émotion : nuit, énergie, scène.

Vise :
- mode dark par défaut (cf. design-system-rules : dark = design à part entière, pas inversion) ;
- palette nuit + accent néon (cyan ou magenta) ;
- sections : roster artistes, releases, agenda, presskit, contact booking ;
- effet wow sur la home (gradient subtil + image scène) ;
- pas de presskit téléchargeable (PDF) tant que les fichiers ne sont pas finalisés — placeholder propre.

Cherche 21st.dev catégories Heros + Cards.
Mots-clés images : DJ booth, stage lights, sound waves, electronic music.
Brief avant implémentation.
```

---

## 6. Site service local

```txt
Refonte du site d'un coiffeur (salon premium en centre-ville).

Stack : PHP 8 + SQLite (mini CMS sectoriel Art of Dev).
Cible : clientèle 25–55 ans, prêts à payer pour un service haut de gamme.
Action principale : prendre rendez-vous (formulaire ou téléphone).

Vise :
- design chic, lumineux, lifestyle ;
- palette rose poudré + blush + doré accent ;
- sections : accueil, prestations + prix, équipe, galerie, avis, contact + horaires ;
- effet wow homepage : photo salon + CTA téléphone visible en sticky mobile ;
- aligné CLAUDE_PROJECT_FACTORY.md (admin intégré, dashboard avec to-do, export ZIP).

Pas de React. PHP/HTML/CSS classique.
Mots-clés images : salon interior modern, hair styling action, beauty product detail.
Brief design + implémentation. Préserver l'admin et l'installer.
```

---

## 7. Mini CMS pour vidéo YouTube

```txt
Crée le design d'un mini CMS pour un cas vidéo YouTube : "Je crée un site pour un tatoueur en 30 min avec Claude".

Stack : PHP 8 + SQLite.
Mode VIDEO_PRESENTATION_MODE activé (cf. CLAUDE_PROJECT_FACTORY.md §27).
Cible : viewers de la chaîne Art of Dev + portfolio démontrable.

Vise :
- design présentable à l'écran ;
- aucun secret / chemin / IP visibles si on fait ls/cat dans la vidéo ;
- effet wow homepage (photo studio tattoo, ambiance brutaliste-noir-rouge) ;
- admin clair avec termes humains ;
- export ZIP fonctionnel pour la fin de vidéo.

Cherche 21st.dev catégorie Heros sombres + cards portfolio.
Mots-clés images : tattoo studio, ink texture, urban wall, black and white portrait.

Brief design avant implémentation. Documente chaque choix pour le voice-over.
```

---

## 8. Refonte WordPress moins template

```txt
Ce site WordPress fait beaucoup trop "thème par défaut". Refonte du look complète.

Stack : WordPress 6.x + thème custom déjà en place (mais ressemble à un thème gratuit).
Cible : agence de conseil B2B (juridique).
Émotion : sérieux, crédible, sobre.

Vise :
- enlever toute trace de "template WordPress importé" ;
- typographie sérieuse (1 display + 1 body, pas 4) ;
- palette : bleu marine + doré accent + neutres slate ;
- sections : home, expertise, équipe, cas traités, contact ;
- footer 4 colonnes propres ;
- aucun gradient violet random ;
- aucune icône fusée / ampoule / poignée de main.

Reste WordPress (pas de Next imposé). Modifie le thème enfant.
Cherche 21st.dev pour inspiration des sections (sans imposer React).
Brief avant d'implémenter.
```

---

## 9. Interface pour vidéo de démo produit

```txt
Crée l'interface d'une démo produit pour ma chaîne YouTube.

Le produit montré : un outil interne de gestion de presskit pour artistes (Presskit-as-a-service).
Stack : Next.js 14 + Tailwind + shadcn.
Public viewer : créateurs indépendants, devs, designers.

Vise :
- screencast-friendly (lisible à 1080p sur YouTube) ;
- effet wow dès l'ouverture ;
- chemin utilisateur démontrable en 3 minutes : login → dashboard → créer presskit → preview → exporter ZIP ;
- aucun secret / chemin / IP affichés ;
- les démos doivent montrer des données seed crédibles (pas "Lorem ipsum") ;
- micro-interactions soignées (visibles à la caméra).

Cherche 21st.dev featured + popular.
Brief + implémentation page par page. Commits séparés pour montage vidéo séparable.
```

---

## 10. Refonte avant / après (challenge)

```txt
Mode "challenge avant/après" :

1. Avant tout, fais un audit du design actuel (méthode du skill production-auditor si disponible — sinon scan visuel).
2. Liste les problèmes avec gravité et page concernée.
3. Propose une direction artistique radicalement différente mais cohérente avec le produit.
4. Brief design + moodboard + sélection composants + sélection images + design system.
5. Implémente.
6. Rapport final qui montre AVANT (problèmes) → APRÈS (solutions) côte à côte.
7. Score ui-quality-checklist avant et après pour mesurer le delta.

Stack : à détecter en lisant le projet.
Mode "screen-recording-friendly" si je vais filmer le résultat.
Pas de push GitHub. Commits locaux séparés.
```

---

Created by João de Almeida — Art of Dev — https://artofdev.space
