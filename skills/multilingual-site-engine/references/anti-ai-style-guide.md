# Guide anti-style IA — `multilingual-site-engine`

Liste des patterns générés par IA et méthode de détection / correction.

Created by João de Almeida

---

## 1. Pourquoi détecter le style IA

Un site qui sent l'IA :

- **perd en confiance** (les utilisateurs reconnaissent le style) ;
- **se dilue** dans la masse de contenu génératif ;
- **manque de personnalité** ;
- **devient interchangeable** avec n'importe quel concurrent ;
- **dégrade le SEO** quand Google détecte du contenu de faible valeur.

Le skill détecte ces patterns et les **signale** ou les **corrige** selon le mode.

---

## 2. Le tiret cadratin (—) — signal majeur

### 2.1 Pourquoi c'est un marqueur fort

Les modèles de langage ont une tendance documentée à abuser du tiret cadratin :

- comme **séparateur rythmique** ;
- comme **remplacement** de la virgule, du deux-points, des parenthèses ;
- en série de 2-3 par paragraphe ;
- de manière **systématique** sur plusieurs paragraphes consécutifs.

Un humain utilise le tiret long **rarement** : il a une fonction rhétorique précise (rupture, chute, incise forte). Une moyenne saine est < 1 par paragraphe, et **pas dans tous les paragraphes**.

### 2.2 Seuils de détection

| Seuil | Diagnostic |
|---|---|
| 0-1 par paragraphe | normal |
| 2 par paragraphe | suspect, vérifier |
| 3+ par paragraphe | très probable IA |
| 2+ par paragraphe sur 3 paragraphes consécutifs | quasi-certain IA |

### 2.3 Correction

Remplacer par la ponctuation **locale naturelle** :

- **virgule** si l'incise est légère ;
- **deux-points** si annonce ou explicitation ;
- **parenthèses** si information secondaire ;
- **point** + nouvelle phrase si l'idée mérite d'être autonome ;
- **point-virgule** entre deux propositions liées (FR formel).

Ne **pas** remplacer mécaniquement par un tiret demi-cadratin (–) — c'est juste plus discret mais reste un tic.

### 2.4 Exemples

**Source IA :**

> *"L'application — pensée pour les équipes — permet — en quelques clics — de gérer ses tâches."*

**Réécritures possibles :**

> *"L'application, pensée pour les équipes, permet de gérer ses tâches en quelques clics."*
> *"L'application a été pensée pour les équipes. Elle permet de gérer les tâches en quelques clics."*
> *"Pour les équipes : une app qui gère les tâches en quelques clics."*

---

## 3. Phrases creuses (catalogue)

### 3.1 Introductions

À supprimer ou remplacer :

- *"Dans le monde d'aujourd'hui"*
- *"À l'ère du numérique"*
- *"À l'heure où..."*
- *"Plus que jamais"*
- *"Au cœur de notre époque"*
- *"Imaginez un monde où..."*
- *"Bienvenue sur notre site"*
- *"Nous sommes ravis de..."*
- *"Découvrez comment..."*
- *"Vous l'avez compris..."*

### 3.2 Marketing creux

- *"Solution innovante"*
- *"Solution révolutionnaire"*
- *"Révolutionner X"*
- *"Réinventer X"*
- *"Disruptif"*
- *"Best-in-class"*
- *"Leader du marché"* (sans preuve)
- *"Unique en son genre"*
- *"Inégalé"*
- *"Sans pareil"*
- *"De pointe"*
- *"Cutting-edge"*

### 3.3 Tautologies UX

- *"Expérience utilisateur exceptionnelle"*
- *"Expérience fluide"*
- *"Interface intuitive"*
- *"Conviviale"*
- *"User-friendly"* (FR)
- *"Easy to use"* (sans précision)

### 3.4 Verbes mous

- *"Optimiser"* (sans dire comment)
- *"Booster"*
- *"Maximiser"*
- *"Élever"*
- *"Sublimer"*
- *"Transformer"* (sans contexte)

### 3.5 Connecteurs IA

Surutilisés en boucle :

- *"De plus en plus"*
- *"En effet"*
- *"Par ailleurs"*
- *"En outre"*
- *"Néanmoins"*
- *"Cependant"*

Un humain alterne. L'IA en abuse.

### 3.6 Conclusions vides

- *"En conclusion"*
- *"Pour conclure"*
- *"En définitive"*
- *"En résumé"* (suivi d'un résumé inutile)
- *"Voilà tout ce qu'il faut savoir"*
- *"N'hésitez pas à nous contacter"*

---

## 4. Patterns d'écriture IA

### 4.1 La structure "rule of three" mécanique

L'IA aime les listes de 3 éléments parallèles :

> *"Notre app est rapide, intuitive et performante."*

→ trois adjectifs vagues sans contenu.

**Correction :** un seul fait précis.

> *"Notre app charge en 0,4 seconde."*

### 4.2 L'introduction en 4 phrases creuses

Pattern courant :

1. constat général flou ;
2. *"il est essentiel de..."* ;
3. *"c'est pourquoi nous avons..."* ;
4. *"découvrez comment..."*.

Solution : couper les 4 phrases, commencer par le **bénéfice concret**.

### 4.3 La conclusion qui répète

L'IA termine souvent par :

> *"En somme, X est important pour Y, et il est crucial de Z."*

→ ne sert à rien. Supprimer.

### 4.4 Le ton "neutre-fade"

Texte qui pourrait être écrit par n'importe qui, pour n'importe quel produit, dans n'importe quel secteur.

Test : si tu copies le paragraphe sur un autre site sans rien changer, ça marche → **trop générique**.

### 4.5 Le faux personnage

> *"Nous croyons que..."* sans dire qui est *"nous"*.

Mieux : voix incarnée (*"Notre équipe de 5 personnes..."*) ou voix produit assumée.

---

## 5. Détection programmatique

Le script `scripts/scan-ai-style-patterns.sh` cherche :

- tiret long `—` (cadratin) ;
- *"dans le monde d'aujourd'hui"* ;
- *"solution innovante"* ;
- *"révolutionner"* ;
- *"expérience fluide"* ;
- *"de plus en plus"* ;
- *"il est important de"* ;
- *"découvrez comment"* ;
- *"Lorem ipsum"* ;
- *"placeholder"* ;
- *"contenu à venir"*.

Le résultat est un **rapport** des fichiers à inspecter, pas une auto-correction. La réécriture passe par un humain (ou par le mode 3 du skill avec validation).

---

## 6. Faux positifs à connaître

### Tirets longs justifiés

- citations littéraires reproduites fidèlement ;
- pages éditoriales avec voix marquée ;
- transcription de dialogues (théâtre, interview) ;
- typographie historique (livres anciens reproduits).

→ Ne pas corriger sans confirmer.

### Phrases acceptables en contexte

- *"de plus en plus"* dans un texte qui détaille une **évolution chiffrée** ;
- *"il est important de"* dans un guide pédagogique très formel ;
- *"découvrez"* dans un CTA très court (pas en intro).

→ Le contexte prime. Le skill **signale**, l'humain valide.

---

## 7. Score anti-IA

À l'intérieur du Translation Quality Score, le critère "Absence de style IA" (10 points) se calcule :

| Constat | Pénalité |
|---|---|
| > 3 tirets longs en moyenne par paragraphe | -5 |
| 2-3 tirets longs en moyenne | -3 |
| Phrases creuses listées (par occurrence) | -1 chacune (max -5) |
| Conclusion vide en fin d'article | -2 |
| Introduction passe-partout | -2 |
| Voix neutre-fade détectée | -3 |

Score plein si aucun de ces constats.

---

## 8. Workflow de réécriture

1. **Scanner** avec `scan-ai-style-patterns.sh` ;
2. **Lister** les fichiers / paragraphes suspects ;
3. **Lire** chaque paragraphe avec œil humain ;
4. **Réécrire** en suivant `human-writing-guide.md` ;
5. **Relire** à voix haute ;
6. **Vérifier** que la voix de marque tient sur tout le texte.

---

## 9. Quand le client dit *"ça sent l'IA"*

Souvent, la cause exacte est :

- **tirets longs** en boucle (corriger en priorité) ;
- **introductions** trop longues et creuses ;
- **adjectifs marketing** non chiffrés ;
- **conclusions** vides ;
- **structure** identique d'un paragraphe à l'autre ;
- **terminologie** abstraite sans exemple concret ;
- **voix** qui ne ressemble à personne.

Le skill applique les 7 corrections — souvent ça suffit pour redonner de l'âme au texte.

---

Created by João de Almeida
