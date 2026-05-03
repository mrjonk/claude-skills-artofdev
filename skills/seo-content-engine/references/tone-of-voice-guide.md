# Guide du ton — `seo-content-engine`

7 contextes éditoriaux, 7 tons. Choisir **un** ton par article.

Created by João de Almeida

---

## A. Blog technique

**Ton :** clair, précis, pédagogique, crédible.

**Caractéristiques :**

- vocabulaire technique **assumé** mais expliqué quand ce n'est pas trivial ;
- snippets de code **commentés** ;
- références aux **standards** (W3C, RFC, MDN, doc officielle) ;
- pas de tutoiement institutionnel (français : *"vous"* par défaut) ;
- pas de jargon **inutile** (utilise un terme technique seulement s'il apporte quelque chose) ;
- pas d'humour gratuit qui casse le rythme.

**À utiliser pour :** articles dev, articles ops/sysadmin, articles data, articles cybersécurité, articles cloud.

**Exemples**

- ✅ *"Le hook `useEffect` re-déclenche son effet à chaque changement de la valeur dans son tableau de dépendances. Si ce tableau est omis, l'effet tourne après chaque rendu — comportement à éviter sur les composants montés en parallèle."*
- ❌ *"Imaginez un monde où vos hooks s'exécutent quand vous le souhaitez ! C'est exactement ce que `useEffect` permet."*

---

## B. SaaS

**Ton :** orienté problème/solution, rassurant, conversion non agressive.

**Caractéristiques :**

- structure **problème → enjeu → solution → preuve** ;
- vocabulaire **business** mesuré (*"workflow"*, *"productivité"*, *"équipe"*) sans tomber dans le jargon corporate ;
- chiffres **réels** (gains de temps mesurés, % d'amélioration sourcés) ;
- testimonials **vrais** ou pas du tout ;
- CTA **invitant**, pas pressant.

**À utiliser pour :** landing pages SaaS, articles de blog SaaS, études de cas, comparatifs produits.

**Exemples**

- ✅ *"Les équipes produit perdent en moyenne 4 heures par semaine en réunions de coordination redondantes. Une vue partagée du backlog peut réduire ce coût."*
- ❌ *"Révolutionnez votre façon de travailler avec notre solution innovante !"*

---

## C. Tutoriel débutant

**Ton :** simple, direct, étape par étape, accessible, **rassurant**.

**Caractéristiques :**

- vocabulaire **expliqué** dès qu'il sort du quotidien ;
- phrases **courtes** ;
- une idée **par paragraphe** ;
- captures d'écran ou diagrammes **dès que possible** ;
- reconnaissance des **points qui peuvent bloquer** ("si vous voyez l'erreur X, c'est normal — voici comment la corriger") ;
- ton **bienveillant** sans être condescendant.

**À utiliser pour :** articles "Démarrer avec X", tutoriels installation, premiers pas avec un outil.

**Exemples**

- ✅ *"Ouvrez votre terminal. Si vous êtes sur macOS, vous le trouverez dans Applications > Utilitaires. Sous Windows, recherchez « Invite de commandes » dans le menu Démarrer."*
- ❌ *"Lancez bash et configurez votre environnement."*

---

## D. Documentation simplifiée

**Ton :** très clair, structuré, **neutre**, précis.

**Caractéristiques :**

- pas d'opinion ;
- pas de promesse ;
- pas de marketing ;
- structure **toujours** identique entre pages similaires ;
- exemples **minimaux** mais **complets** (un exemple qui marche, plutôt qu'une explication abstraite) ;
- références croisées vers la doc officielle si applicable.

**À utiliser pour :** documentation technique de produit, documentation interne, knowledge base.

**Exemples**

- ✅ *"La méthode `fetch()` accepte deux paramètres : l'URL (string, obligatoire) et un objet d'options (optional). Elle retourne une `Promise` qui résout vers un objet `Response`."*
- ❌ *"`fetch()` est une méthode incroyablement puissante qui va changer votre façon de faire des requêtes !"*

---

## E. Page produit

**Ton :** orienté bénéfices réels, concret, crédible, **sans promesses vagues**.

**Caractéristiques :**

- bénéfices **mesurables** (*"5 minutes pour configurer"*, *"3 clics pour publier"*) ;
- **pas** de superlatifs vides (*"le meilleur"*, *"la plus complète"*) ;
- mockups / captures **réels** ;
- testimonials **vrais** avec nom + rôle + entreprise (ou pas du tout) ;
- pricing **clair** ;
- pas de pression (*"Plus que 24 heures !"*).

**À utiliser pour :** pages produit, pages service, landing pages.

**Exemples**

- ✅ *"Configurez votre premier projet en moins de 5 minutes — sans installation. Importez votre repo GitHub, choisissez un template, déployez."*
- ❌ *"La solution ultime pour révolutionner votre productivité !"*

---

## F. Article expert / opinion

**Ton :** approfondi, argumenté, structuré, sources solides.

**Caractéristiques :**

- **point de vue** assumé (l'article a une voix) ;
- **arguments** étayés (sources, exemples, contre-arguments examinés) ;
- vocabulaire **précis**, occasionnellement technique ;
- **structure claire** malgré la profondeur ;
- conclusion **non triviale** (un vrai point de vue, pas un résumé).

**À utiliser pour :** essais, analyses sectorielles, articles d'opinion technique, prises de position.

**Exemples**

- ✅ *"L'argument selon lequel les microservices résolvent la complexité est mal posé : ils déplacent la complexité du code vers l'infrastructure et le réseau. Un monolithe bien découpé reste préférable pour une équipe de moins de 15 développeurs."*
- ❌ *"Les microservices, c'est génial pour tout le monde !"*

---

## G. Contenu créatif / culturel

**Ton :** vivant, contextualisé, descriptif, **sans exagération marketing**.

**Caractéristiques :**

- description **sensorielle** quand pertinent ;
- contexte **historique** ou **culturel** précis ;
- vocabulaire **riche** mais accessible ;
- pas de superlatifs creux ;
- l'article a une **personnalité éditoriale**.

**À utiliser pour :** articles culturels, portraits, reportages, pieces longues éditoriales.

**Exemples**

- ✅ *"Dans la salle de répétition de Hambourg, les Beatles enchaînaient huit heures de concert par nuit. Cette discipline brutale est ce qui les a transformés d'un groupe scolaire en machine de scène."*
- ❌ *"Les Beatles ont été le groupe le plus important de tous les temps !"*

---

## Choix du ton — récap

```txt
Article dev / sysadmin / data / sécurité ──→ A. Blog technique
Landing SaaS / blog SaaS / études cas ───→ B. SaaS
"Démarrer avec X" / installer / premiers pas → C. Tutoriel débutant
Doc produit / KB / référence ────────────→ D. Documentation simplifiée
Page produit / page service / landing ───→ E. Page produit
Essai / analyse approfondie / opinion ───→ F. Article expert
Reportage / portrait / culturel ─────────→ G. Contenu créatif
```

---

## Règles transverses (tous tons confondus)

- **un seul** ton par article ;
- **adresse** cohérente (tutoiement / vouvoiement) toute l'article ;
- **temps** principalement présent (pas de mélange aléatoire passé/futur) ;
- **nous éditorial** (*"nous allons voir"*) à éviter — privilégier *"vous allez apprendre"* ou la voix neutre ;
- **pas de superlatifs** sauf justifiés (*"le plus rapide selon le benchmark X (source)"*) ;
- **pas de "très"** abusif — préférer un vocabulaire précis (*"très rapide"* → *"3× plus rapide qu'avant"*) ;
- **pas d'auto-promotion** (sauf en page produit, et avec mesure) ;
- **honnêteté** sur les limites et trade-offs.

---

Created by João de Almeida
