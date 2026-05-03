# Guide de structure d'article — `seo-content-engine`

Structures canoniques selon le type de contenu. À adapter sans dénaturer.

Created by João de Almeida

---

## 1. Article de blog standard (informationnel)

```markdown
# H1 — proche du title, sujet clair

## Introduction (3–4 phrases)
- Pose le problème
- Précise le public
- Annonce la valeur de l'article

## H2 — Section principale 1
Explication + exemple concret.

### H3 — Sous-point si nécessaire

## H2 — Section principale 2
Explication + exemple concret.

## H2 — Conseils pratiques (optionnel)
Liste actionnable.

## H2 — Erreurs à éviter (optionnel)
Liste avec correction.

## H2 — FAQ
3–8 questions utiles.

## Pour aller plus loin
3–6 liens internes (avec ancres et raisons).

## Sources
Liste avec URL.

## Conclusion
Réflexion finale + CTA naturel.
```

**Longueur typique** : 800–1500 mots.

---

## 2. Tutoriel / How-to

```markdown
# H1 — "Comment X" ou "X : guide étape par étape"

## Introduction (3–4 phrases)
- Que va apprendre le lecteur
- Pour quel public (niveau)
- Prérequis (rapide liste)

## Prérequis
- Liste explicite (versions, comptes, accès)
- Estimation du temps total

## Étape 1 — Titre de l'étape (verbe d'action)
Description + capture / snippet de code.

```language
// snippet de code commenté
```

## Étape 2 — Titre
…

## Étape N — Titre
…

## Vérification
Comment savoir que ça marche : commande de test, output attendu.

## Erreurs courantes
- Erreur 1 → cause → solution
- Erreur 2 → cause → solution

## FAQ
3–5 questions pratiques.

## Pour aller plus loin
Liens vers doc, prochain niveau, projet associé.

## Sources
Documentation officielle utilisée.
```

**Longueur typique** : 1000–2500 mots selon profondeur.
**Schema.org** : `HowTo`.

---

## 3. Article SaaS / orienté produit

```markdown
# H1 — angle problème ou bénéfice (pas le nom du produit)

## Introduction
- Pose le problème métier
- Annonce la solution / approche

## H2 — Le problème en détail
Avec données ou exemples concrets.

## H2 — La solution / l'approche
Sans tomber dans le pitch produit.

## H2 — Comment l'appliquer concrètement
Step-by-step ou cas d'usage.

## H2 — Cas d'usage / exemples
Mini-études de cas (anonymisées si nécessaire).

## H2 — Erreurs à éviter
Liste critique.

## H2 — FAQ
Questions stratégiques courantes.

## CTA
Démo, doc, ou lecture complémentaire.

## Sources
Si chiffres, études, comparaisons.
```

**Longueur typique** : 1200–2000 mots.
**Ton** : problème/solution, rassurant, conversion non agressive.

---

## 4. Page produit (transactionnelle)

```markdown
# H1 — nom du produit + bénéfice principal

## Section 1 — Hero
- Titre fort (1 ligne)
- Sous-titre (1–2 lignes)
- CTA principal
- Visuel (mockup ou photo produit)

## Section 2 — Le problème résolu
2–3 phrases sur le pain point.

## Section 3 — Bénéfices clés (3–6 points)
Pas de features — des bénéfices concrets.

## Section 4 — Comment ça marche
Démonstration en 3 étapes (visuelles si possible).

## Section 5 — Cas d'usage / preuves sociales
Testimonials, logos clients, métriques honnêtes.

## Section 6 — FAQ
Objections courantes traitées.

## Section 7 — Pricing (si applicable)
Plans clairs, prix lisibles.

## Section 8 — CTA final
"Démarrer", "Demander une démo", "Voir la doc".
```

**Longueur typique** : 600–1200 mots.
**Schema.org** : `Product` + `Offer`.

---

## 5. Article technique / approfondi

```markdown
# H1 — technique précis

## Introduction
- Contexte technique
- Pour qui (niveau d'expertise requis)
- Ce qu'on va couvrir

## H2 — Concept / contexte
Explication des bases nécessaires.

## H2 — Implémentation détaillée
Code, configurations, choix d'architecture.

```language
// snippets longs OK ici
```

## H2 — Cas particuliers / limites
Edge cases, performance, sécurité.

## H2 — Comparaison avec d'autres approches
Tableau ou liste critères.

## H2 — Quand l'utiliser / quand ne pas l'utiliser
Recommandations claires.

## FAQ
Questions techniques pointues.

## Sources
Documentation officielle, RFCs, articles d'auteurs reconnus.

## Conclusion
Synthèse + pointeur vers approfondissement.
```

**Longueur typique** : 2000–4000 mots.
**Ton** : approfondi, argumenté, sources nombreuses.

---

## 6. Guide débutant

```markdown
# H1 — "Démarrer avec X" ou "X pour débutants"

## Introduction
- Reconnaître que le sujet peut être intimidant
- Promesse : à la fin de l'article, le lecteur saura X

## H2 — C'est quoi X ?
Définition simple, analogie si possible.

## H2 — À quoi ça sert ?
Cas d'usage concrets, parlants.

## H2 — Comment commencer
Premiers pas, en 3–5 étapes maximum.

## H2 — Premier projet / premier exemple
Cas pratique très simple.

## H2 — Erreurs courantes du débutant
Liste rassurante avec corrections.

## H2 — Pour aller plus loin
Lectures, tutos, communautés.

## FAQ
Questions de débutants vraies.
```

**Longueur typique** : 1000–1800 mots.
**Ton** : simple, direct, accessible, **rassurant**.

---

## 7. Documentation simplifiée

```markdown
# H1 — nom de la fonctionnalité ou du concept

## Vue d'ensemble (1 paragraphe)
- À quoi ça sert
- Pour qui

## Installation / mise en place
Étapes concrètes.

## Utilisation de base
Exemple le plus courant.

```language
// exemple minimal
```

## Options / paramètres
Tableau des options.

## Exemples avancés
2–3 cas plus complexes.

## Dépannage
Erreurs courantes + solutions.

## API reference (si applicable)
Structure formelle.
```

**Ton** : neutre, structuré, **précis**.

---

## 8. Page ressource / hub

```markdown
# H1 — thème large

## Introduction
Pose le thème, annonce les sous-sujets couverts.

## H2 — Sous-thème 1
Résumé + lien vers article complet.

## H2 — Sous-thème 2
Résumé + lien vers article complet.

## H2 — Sous-thème N
…

## Outils recommandés
Liste curated.

## Pour aller plus loin
Ressources externes vérifiées.
```

**Usage** : pilier d'un cluster SEO, page qui distribue le link juice.

---

## 9. Article comparatif

```markdown
# H1 — "X vs Y" ou "Alternatives à Z"

## Introduction
- Quand on hésite entre les options
- Critères qu'on va appliquer

## H2 — Critères de comparaison
Liste claire et **non négociable**.

## H2 — Présentation rapide de chaque option
1 paragraphe par option.

## H2 — Tableau comparatif
| Critère | Option A | Option B | Option C |
|---|---|---|---|

## H2 — Cas d'usage : choisir A
Quand A est la meilleure.

## H2 — Cas d'usage : choisir B
Quand B est la meilleure.

## H2 — Recommandation finale
Synthèse honnête (pas de gagnant artificiel si vraiment équivalent).

## Sources
Pricing, doc, benchmarks.
```

**Longueur typique** : 1500–3000 mots.
**Honnêteté requise** : ne pas pousser un favori sans le dire.

---

## 10. FAQ standalone

```markdown
# H1 — "FAQ X" ou "Questions fréquentes sur X"

## Introduction (courte)
À qui s'adresse la FAQ.

## Catégorie 1 — Concepts / définitions

### Question 1
Réponse claire.

### Question 2
Réponse.

## Catégorie 2 — Mise en place

### Question 3
…

## Catégorie 3 — Dépannage

### Question N
…

## Pas trouvé votre réponse ?
Lien vers contact / doc / forum.
```

**Schema.org** : `FAQPage`.
**Cf. `faq-writing-guide.md` pour les règles de rédaction.**

---

## Règle générale

- une **structure claire** sert le lecteur ;
- une **structure rigide** (toujours la même même quand inadapté) trahit un contenu généré sans réflexion ;
- l'objectif : choisir **la** structure qui sert **ce** sujet pour **ce** public.

---

Created by João de Almeida
