# Règles anti-bullshit — `seo-content-engine`

Tout ce que le skill **doit refuser** de produire. Et tout ce qu'il doit **viser**.

Created by João de Almeida

---

## 1. Phrases creuses interdites

Liste non exhaustive de patterns à **bannir** systématiquement. Si tu en utilises une, **réécris** la phrase.

### En français

- *"Dans le monde d'aujourd'hui..."*
- *"À l'ère du numérique..."*
- *"De plus en plus de..."*
- *"Il est important de..."*
- *"Il convient de noter..."*
- *"Il va sans dire que..."*
- *"En effet..."* (utilisable rarement, mais souvent un signal de remplissage)
- *"Force est de constater..."*
- *"Au cœur de notre époque..."*
- *"Révolutionner..."*
- *"Solution innovante..."*
- *"Optimiser votre expérience..."*
- *"Améliorer votre productivité..."*
- *"Booster votre business..."*
- *"Transformer votre quotidien..."*
- *"Une expérience inégalée..."*
- *"Le futur de..."*
- *"L'avenir de..."*
- *"Disrupter..."*
- *"Une approche unique..."*

### En anglais

- *"In today's fast-paced world..."*
- *"In this digital age..."*
- *"It is important to note that..."*
- *"At its core..."*
- *"Game-changer..."*
- *"Revolutionize..."*
- *"Cutting-edge..."*
- *"Best-in-class..."*
- *"Take your X to the next level..."*
- *"Unleash the power of..."*
- *"Seamlessly integrate..."*
- *"Boost your productivity..."*
- *"Streamline your workflow..."*
- *"Empower your team..."*

### Patterns IA caractéristiques

- *"Plongeons dans..."* / *"Let's dive into..."*
- *"Décortiquons..."*
- *"Explorons ensemble..."*
- *"En conclusion, nous avons exploré..."*
- *"Pour conclure, il est essentiel de..."*

**Règle :** si tu lis une de ces phrases dans ton brouillon, tu la **réécris** avec quelque chose de spécifique au sujet.

---

## 2. Paragraphes transposables

**Test central :** *"Si je copie ce paragraphe dans un article sur un autre sujet sans rien changer, est-ce que ça reste cohérent ?"*

Si **oui** → paragraphe **transposable** → **à réécrire ou supprimer**.

### Exemple à réécrire

> *"La productivité est un enjeu majeur dans le monde du travail moderne. Beaucoup d'entreprises cherchent des solutions pour améliorer l'efficacité de leurs équipes. Il existe plusieurs méthodes pour y parvenir, chacune ayant ses avantages et ses inconvénients."*

→ Ce paragraphe pourrait être dans un article sur le management, le télétravail, les outils SaaS, la formation, etc. Il ne dit rien.

### Exemple **non** transposable (acceptable)

> *"Les développeurs en open space perdent en moyenne 23 minutes pour retrouver leur concentration après une interruption (source : Gloria Mark, UC Irvine, 2008). Une session focus de 50 minutes encadrée par un timer Pomodoro réduit ce coût à zéro tant que la session n'est pas brisée."*

→ Spécifique, chiffré, sourcé, actionnable. Acceptable.

---

## 3. Répétitions à supprimer

À chaque relecture, vérifier :

- la **même idée** ne doit pas être répétée dans 2 paragraphes (sauf récapitulatif final assumé) ;
- le **même mot** ne doit pas dominer 3 paragraphes consécutifs (varier le vocabulaire) ;
- la **même structure de phrase** ne doit pas se répéter (pas 5 phrases d'affilée commençant par *"Il faut..."*) ;
- le **même exemple** ne doit pas être donné 2 fois ;
- la **même statistique** ne doit pas être citée 2 fois ;
- les **transitions** ne doivent pas toutes être identiques (*"De plus..."*, *"En outre..."*, *"Par ailleurs..."* enchaînés = signal IA).

**Outil de détection :** `bash skills/seo-content-engine/scripts/scan-repetitions.sh <chemin>`.

---

## 4. Méthode pour rendre une phrase utile

Si tu écris une phrase et qu'elle te semble vague, applique cette méthode :

### Étape 1 — Identifier le verbe vague

Verbes à risque :
- *"améliorer"*, *"optimiser"*, *"booster"*, *"transformer"*, *"révolutionner"* ;
- *"engager"*, *"impacter"*, *"valoriser"*.

### Étape 2 — Remplacer par un verbe d'action concret

| Vague | Concret |
|---|---|
| améliorer la productivité | réduire le temps passé en réunion de 30 % |
| optimiser le workflow | passer de 5 étapes à 3 |
| booster les ventes | augmenter le panier moyen de 12 € |
| transformer l'expérience | éliminer 3 clics inutiles |
| révolutionner la collaboration | remplacer 7 outils par 1 seul |

### Étape 3 — Ajouter une preuve

Une phrase utile contient idéalement :
- un **chiffre** ;
- un **exemple** ;
- une **comparaison** ;
- une **source**.

**Règle :** si tu ne peux pas ajouter de preuve, c'est probablement une phrase vague à réécrire.

---

## 5. Introductions à proscrire

### Mauvaises introductions

- *"Vous êtes-vous déjà demandé pourquoi... ?"* (cliché)
- *"Si vous lisez cet article, c'est que vous vous intéressez à..."* (méta inutile)
- *"Bienvenue dans cet article où nous allons explorer..."* (annonce + ton scolaire)
- introduction de 8 paragraphes avant d'entrer dans le sujet.

### Bonne introduction (gabarit)

```
[Phrase 1] — Pose le problème ou le contexte concret en 1 ligne.
[Phrase 2] — Précise pour qui c'est et dans quel cas.
[Phrase 3] — Annonce ce que l'article va apporter, en restant honnête.
```

3–4 phrases. Pas plus.

---

## 6. Conclusions à proscrire

### Mauvaises conclusions

- *"En conclusion, nous avons vu que..."* + résumé identique au plan ;
- *"J'espère que cet article vous a plu..."* (méta) ;
- *"N'hésitez pas à laisser un commentaire si vous avez des questions !"* (cliché blog 2010).

### Bonne conclusion

- une **réflexion finale** non triviale ;
- une **question ouverte** ;
- un **pointeur vers l'action suivante** (lien interne, doc, démo) ;
- pas un résumé du plan.

---

## 7. FAQ artificielle vs FAQ utile

Cf. `faq-writing-guide.md`. Résumé :

### FAQ artificielle (à proscrire)

- questions **inventées** pour faire long ;
- questions auxquelles le contenu **a déjà répondu** ;
- réponses qui **bottent en touche** (*"cela dépend..."*) ;
- 15 questions identiques reformulées.

### FAQ utile

- 3 à 8 questions **réellement** posées par les utilisateurs ;
- réponses **claires et autonomes** (lisibles sans avoir lu l'article) ;
- adapte au format **People Also Ask** de Google si pertinent.

---

## 8. CTA agressifs vs naturels

### CTA agressifs (à proscrire)

- *"CLIQUEZ MAINTENANT !"*
- *"Inscrivez-vous immédiatement !"*
- *"Ne ratez pas cette occasion unique !"*
- 5 CTA différents dans l'article (dispersion).

### CTA naturels

- *"Lire le guide complet sur X"* (lien interne en lien avec le sujet) ;
- *"Tester la démo"* (article produit) ;
- *"Consulter la documentation"* (article technique) ;
- 1 CTA principal + 1 secondaire optionnel inline.

---

## 9. Statistiques inventées

**Tu ne fabriques jamais** une statistique.

- *"Selon une étude..."* sans nom de l'étude → **interdit** ;
- *"80 % des utilisateurs..."* sans source → **interdit** ;
- *"De nombreux experts s'accordent à dire..."* → **interdit** (qui sont ces experts ?).

Si tu veux donner un chiffre : tu cites la **source précise** (auteur, année, lien). Sinon tu **n'utilises pas de chiffre**.

---

## 10. Citations inventées

**Tu n'inventes jamais** une citation.

- *"Comme le disait Einstein..."* — vérifie d'abord (la plupart des citations attribuées à Einstein sont fausses) ;
- attribution vague (*"un célèbre auteur a dit..."*) → **interdit** ;
- citation sans **source vérifiable** → **interdit**.

Si tu cites quelqu'un, tu cites **précisément** (qui, où, quand).

---

## 11. Checklist anti-bullshit (relecture finale)

À cocher avant de livrer :

- [ ] aucune phrase de la **liste §1** dans le texte ;
- [ ] **test du paragraphe transposable** passé sur chaque section ;
- [ ] aucune **répétition** d'idée, de mot, de structure ;
- [ ] **introduction** ≤ 4 phrases ;
- [ ] **conclusion** non triviale ;
- [ ] **FAQ** réellement utile (3–8 questions, pas inventées) ;
- [ ] **CTA** naturel et lié au sujet ;
- [ ] aucune **statistique** non sourcée ;
- [ ] aucune **citation** non vérifiée ;
- [ ] **angle éditorial** clair (l'article a une voix, un point de vue) ;
- [ ] **score qualité éditoriale** ≥ 76 (sinon retravail).

---

Created by João de Almeida
