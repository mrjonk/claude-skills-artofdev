# Rapport d'humanisation — {{PROJECT_NAME}}

> Détection et correction des patterns de style IA dans le contenu.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Langues analysées** : {{liste}}
- **Volume analysé** : {{N pages / fichiers}}

---

## Synthèse

```txt
┌─────────────────────────────────────┐
│  Style IA détecté : {{niveau}}      │
│  Tirets longs : {{N}}               │
│  Phrases creuses : {{N}}            │
│  Pages à réécrire : {{N}}           │
└─────────────────────────────────────┘
```

Niveau global : **{{faible / modéré / élevé / critique}}**.

---

## Tirets longs (—)

### Statistiques

- **Total tirets longs** : {{N}}
- **Pages concernées** : {{N}}
- **Moyenne par paragraphe** sur les pages concernées : {{X.X}}

### Top 10 fichiers

| Fichier | Nombre de — | Note |
|---|---|---|
| `{{path}}` | {{N}} | {{...}} |
| {{...}} | | |

### Action

- [ ] remplacer par virgule (incise légère) ;
- [ ] remplacer par deux-points (annonce) ;
- [ ] remplacer par parenthèses (info secondaire) ;
- [ ] couper en deux phrases ;
- [ ] **garder** si rhétorique réelle (rare).

---

## Phrases creuses détectées

| Pattern | Occurrences | Fichiers |
|---|---|---|
| *"dans le monde d'aujourd'hui"* | {{N}} | {{liste}} |
| *"solution innovante"* | {{N}} | {{liste}} |
| *"révolutionner"* | {{N}} | {{liste}} |
| *"expérience fluide"* | {{N}} | {{liste}} |
| *"de plus en plus"* | {{N}} | {{liste}} |
| *"il est important de"* | {{N}} | {{liste}} |
| *"découvrez comment"* | {{N}} | {{liste}} |
| *"bienvenue sur notre site"* | {{N}} | {{liste}} |
| *"en conclusion"* | {{N}} | {{liste}} |
| {{autre pattern détecté}} | {{N}} | {{liste}} |

---

## Patterns rhétoriques répétés

- [ ] structure "rule of three" mécanique ;
- [ ] introductions en 4 phrases creuses ;
- [ ] conclusions qui répètent l'intro ;
- [ ] *"Imaginez un monde où..."* ;
- [ ] *"Que ce soit pour A, B ou C..."*.

---

## Avant / après — exemples de réécriture

### Exemple 1 — {{Page / Section}}

**Avant :**

> *"{{texte original avec style IA}}"*

**Après :**

> *"{{texte humanisé}}"*

**Changements** :
- {{tirets longs supprimés}} ;
- {{phrases creuses remplacées}} ;
- {{adjectifs marketing → faits concrets}} ;
- {{introduction raccourcie}}.

### Exemple 2 — {{...}}

**Avant :**

> *"..."*

**Après :**

> *"..."*

---

## Pages prioritaires à réécrire

| Priorité | Page | Raison |
|---|---|---|
| 1 | `/fr/` (home) | introduction creuse, 8 tirets longs |
| 1 | `/fr/services` | 12 phrases creuses |
| 2 | `/fr/blog/{{article}}` | conclusion vide, marketing creux |
| 3 | `/fr/about` | mineur |

---

## Voix de marque

- **voix actuelle perçue** : {{neutre-fade / chaleureuse / formelle / autre}}
- **voix souhaitée** : {{...}}
- **alignement** : {{cohérent / incohérent}}

Recommandations :
- {{ex: choisir un ton informel et tutoiement pour les pages produits}}
- {{ex: garder un ton formel sur les pages légales et compte}}.

---

## Avant traduction

> Avant de traduire dans {{lang_target}}, **humaniser** d'abord la source. Sinon le style IA se propage dans toutes les langues.

- [ ] humanisation du source effectuée ;
- [ ] validation client avant traduction.

---

## Pénalité au Translation Quality Score

Application des règles de pénalité (cf. `anti-ai-style-guide.md §7`) :

| Constat | Pénalité |
|---|---|
| > 3 tirets longs en moyenne / paragraphe | {{-5}} |
| Phrases creuses (par occurrence, max -5) | {{-X}} |
| Conclusion vide | {{-2}} |
| Introduction passe-partout | {{-2}} |
| Voix neutre-fade | {{-3}} |
| **Pénalité totale** | **{{-X}}** |

---

## Prochaine étape

> {{Une seule phrase actionnable.}}

---

Created by João de Almeida
