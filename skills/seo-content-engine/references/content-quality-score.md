# Content quality score — `seo-content-engine`

Comment scorer un contenu sur 100. À calculer à la fin de chaque article produit.

Created by João de Almeida

---

## 1. Barème global

| Score | Statut | Action |
|---|---|---|
| **0–20** | Inutilisable | retravailler complètement ou abandonner le brief |
| **21–40** | Trop générique | refondre, identifier les paragraphes transposables et les réécrire |
| **41–60** | Correct mais faible | revoir la structure, ajouter des exemples concrets, retirer le bullshit |
| **61–75** | Publiable avec corrections | corriger les points mineurs, ajouter sources si manquantes, polir le ton |
| **76–90** | Bon contenu SEO | publiable. Points d'amélioration possibles mais non bloquants |
| **91–100** | Contenu premium publiable | publiable directement. Vise ce niveau pour le contenu pilier |

---

## 2. Critères pondérés (12 critères / 100 pts)

### 2.1 Précision (12 pts)

- exactitude factuelle ;
- vocabulaire technique correct ;
- absence d'erreurs visibles ;
- cohérence des données chiffrées.

**Comment scorer :**
- 12 : tout est exact, vocabulaire précis ;
- 8 : globalement exact, quelques imprécisions mineures ;
- 4 : plusieurs imprécisions ou termes mal employés ;
- 0 : faits faux, vocabulaire incorrect.

### 2.2 Utilité (12 pts)

- répond à un besoin réel ;
- actionnable ;
- le lecteur ressort avec quelque chose de concret.

**Comment scorer :**
- 12 : article hautement actionnable, le lecteur peut appliquer immédiatement ;
- 8 : utile mais une partie reste théorique ;
- 4 : informatif mais peu actionnable ;
- 0 : creux, le lecteur n'apprend rien d'utile.

### 2.3 Originalité (12 pts)

- angle éditorial clair ;
- pas générique ;
- voix de l'auteur identifiable.

**Comment scorer :**
- 12 : angle distinctif, point de vue clair, ne ressemble à aucun autre article du sujet ;
- 8 : angle correct mais classique ;
- 4 : générique mais correct ;
- 0 : aucune originalité, transposable à n'importe quel autre sujet.

### 2.4 Profondeur (10 pts)

- traite vraiment le sujet ;
- pas survolé ;
- explore les nuances.

**Comment scorer :**
- 10 : sujet traité en profondeur, nuances explorées ;
- 7 : profondeur correcte, quelques aspects survolés ;
- 4 : trop survolé sur les aspects techniques ;
- 0 : surface seulement.

### 2.5 Structure SEO (10 pts)

- title 50–60 car., unique ;
- meta description 130–160 car. ;
- slug propre ;
- H1 unique ;
- structure H2 / H3 logique ;
- mot-clé principal placé naturellement.

**Comment scorer :**
- 10 : tout en place, naturel, lisible ;
- 7 : tout en place mais une ou deux balises forcées ;
- 4 : éléments manquants ou mal placés ;
- 0 : aucune optimisation.

### 2.6 Absence de bullshit (10 pts)

- aucune phrase creuse ;
- aucun paragraphe transposable ;
- aucune répétition.

**Comment scorer :**
- 10 : zéro bullshit ;
- 7 : très peu, scénarios limites ;
- 4 : plusieurs paragraphes douteux ;
- 0 : article rempli de phrases creuses, transposables, répétitives.

### 2.7 Exemples concrets (8 pts)

- au moins un exemple par section explicative ;
- exemples spécifiques (pas génériques).

**Comment scorer :**
- 8 : exemples partout, précis, illustrant le propos ;
- 5 : quelques bons exemples mais sections sans illustration ;
- 2 : exemples vagues ou rares ;
- 0 : aucun exemple concret.

### 2.8 Cohérence du ton (6 pts)

- un seul ton sur tout l'article (cf. `tone-of-voice-guide.md`) ;
- adresse cohérente ;
- temps verbal cohérent.

**Comment scorer :**
- 6 : ton parfaitement homogène ;
- 4 : ton cohérent mais quelques sections discordantes ;
- 2 : mix de tons ;
- 0 : article qui sonne "patchwork".

### 2.9 Qualité de la FAQ (6 pts)

- 3–8 questions ;
- questions réellement posées ;
- réponses claires et autonomes.

**Comment scorer :**
- 6 : FAQ excellente, questions réelles, réponses utiles ;
- 4 : FAQ correcte, 1–2 questions doublonnent un peu ;
- 2 : FAQ artificielle ;
- 0 : pas de FAQ alors qu'elle serait pertinente, ou FAQ inventée.

### 2.10 Qualité du CTA (4 pts)

- naturel ;
- lié au sujet ;
- non agressif.

**Comment scorer :**
- 4 : CTA pertinent, action concrète, un seul CTA principal ;
- 2 : CTA correct mais générique ;
- 0 : CTA agressif, multiple, ou décorrélé.

### 2.11 Qualité des images (5 pts)

- image principale prévue ;
- alt text non vide sur images informatives ;
- prompts IA détaillés (ou mots-clés précis pour banque) ;
- cohérence stylistique.

**Comment scorer :**
- 5 : plan d'images complet, alt text propre, style cohérent ;
- 3 : plan d'images correct mais incomplet ;
- 1 : alt text manquant ou prompts vagues ;
- 0 : aucun plan d'images alors que pertinent.

### 2.12 Qualité des sources (5 pts)

- toutes les affirmations factuelles sont sourcées ;
- sources officielles privilégiées ;
- aucune source inventée ;
- section "Sources à vérifier" si accès web indispo.

**Comment scorer :**
- 5 : sources solides, aucune invention ;
- 3 : sources correctes mais quelques affirmations non sourcées ;
- 1 : sources discutables ;
- 0 : sources inventées ou citations fausses → **bloquant** (refaire l'article).

---

## 3. Calcul du score

```
Score = somme des 12 critères (max 100)
```

**Penalty bloquant :**
- si **2.12 (Qualité des sources)** = 0 (sources inventées) → score plafonné à **40** quel que soit le total.

---

## 4. Comment améliorer le score

### Si score < 40 (trop générique)

1. relire chaque paragraphe avec le **test du transposable** (cf. `anti-bullshit-rules.md` §2) ;
2. supprimer ou réécrire ;
3. ajouter des **exemples chiffrés** ;
4. clarifier l'**angle éditorial** : qu'est-ce que l'article apporte d'unique ?

### Si score 41–60 (correct mais faible)

1. ajouter de la **profondeur** sur 2–3 sections clés ;
2. enrichir les **exemples** (cas réels, snippets, captures) ;
3. ajouter **sources** sur les affirmations factuelles ;
4. polir la **FAQ** (questions réelles seulement).

### Si score 61–75 (publiable avec corrections)

1. relecture **anti-bullshit** finale ;
2. vérifier les **liens internes** (3–6, descriptifs) ;
3. compléter le **plan d'images** si vide ;
4. resserer la **conclusion**.

### Si score 76–90 (bon)

1. peaufiner le **CTA** ;
2. vérifier la **cohérence** stylistique ;
3. relire à voix haute pour détecter les phrases lourdes ;
4. publier.

### Si score 91–100 (premium)

1. publier ;
2. partager ;
3. utiliser comme **référence** pour les futurs articles du même thème.

---

## 5. Format de sortie attendu

À la fin de chaque article, ajouter :

```markdown
---

## Score qualité éditoriale : 84 / 100 — Bon contenu SEO

| Critère | Score | Note |
|---|---|---|
| Précision | 11 / 12 | une imprécision sur la version Node citée |
| Utilité | 12 / 12 | très actionnable |
| Originalité | 9 / 12 | angle classique mais propre |
| Profondeur | 9 / 10 | bien, manque un cas avancé |
| Structure SEO | 10 / 10 | OK |
| Absence de bullshit | 9 / 10 | une phrase un peu vague en intro |
| Exemples concrets | 8 / 8 | OK |
| Cohérence du ton | 6 / 6 | OK |
| Qualité FAQ | 5 / 6 | une question un peu redondante |
| Qualité CTA | 3 / 4 | CTA correct mais pourrait être plus précis |
| Qualité images | 4 / 5 | un alt text à compléter |
| Qualité sources | 5 / 5 | toutes vérifiées |
| **Total** | **91 / 100** | |

**Verdict** : Bon contenu SEO. Publiable avec une relecture finale (corriger l'imprécision Node, retravailler le CTA).

**Top 3 actions immédiates** :
1. Vérifier la version exacte de Node citée (section "Prérequis").
2. Reformuler le CTA pour rendre l'action plus concrète.
3. Compléter le alt text de l'image de la section 3.
```

Cette structure est **obligatoire** dans le rapport final.

---

## 6. Quand refuser un contenu trop faible

Si le score est **< 40** après une première rédaction :

- **ne pas publier** ;
- proposer à l'utilisateur soit :
  - une **refonte complète** (réécrire en gardant le brief) ;
  - un **changement d'angle** (le sujet est trop générique, trouver un angle plus spécifique) ;
  - un **abandon** du brief si vraiment rien à dire ;
- documenter dans le rapport pourquoi le score est si bas.

---

Created by João de Almeida
