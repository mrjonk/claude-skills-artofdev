# Visual quality score — `site-ux-guardian`

Système de scoring visuel **0–100** basé sur 12 critères pondérés.

Created by João de Almeida

---

## 1. Barème global

| Score | Statut | Signification |
|---|---|---|
| **0–20** | Rendu cassé ou amateur | refonte complète requise |
| **21–40** | Interface incohérente | beaucoup de problèmes structurels |
| **41–60** | Utilisable mais très basique | publiable seulement avec tolérance |
| **61–75** | Correct mais manque de finition | publiable avec corrections |
| **76–90** | Propre et professionnel | publiable |
| **91–100** | Très cohérent, premium-ready | exemplaire |

---

## 2. Critères pondérés (12 critères / 100 pts)

### 2.1 Hiérarchie visuelle (12 pts)

- un seul H1 par page ;
- structure H2 / H3 logique ;
- CTA principal identifiable ;
- ordre visuel cohérent (titre → contenu → action).

**Comment scorer :**
- 12 : impeccable ;
- 9 : 1–2 pages avec H1 manquant ou multiple ;
- 6 : structure approximative sur plusieurs pages ;
- 3 : aucune hiérarchie visible ;
- 0 : pages sans titres ni structure.

### 2.2 Lisibilité (10 pts)

- body 16 px+ ;
- line-height 1.4–1.6 ;
- contraste AA ;
- largeur de ligne 50–80 ch.

**Comment scorer :**
- 10 : tout respecté ;
- 7 : 1 critère manqué (ex: ligne trop large) ;
- 4 : plusieurs critères manqués ;
- 0 : illisible.

### 2.3 Typographie (10 pts)

- max 2 familles ;
- max 3 poids ;
- échelle géométrique ;
- cohérence inter-pages.

### 2.4 Spacing (10 pts)

- valeurs de l'échelle uniquement ;
- padding latéral mobile ≥ 16 px ;
- espacement sections cohérent ;
- footer respirant.

### 2.5 Layout / alignements (10 pts)

- grilles cohérentes ;
- container max-width raisonnable ;
- alignements propres ;
- équilibre des colonnes.

### 2.6 Buttons / CTA (8 pts)

- 3 variantes max ;
- états hover/focus/active ;
- libellés clairs (verbe d'action) ;
- focus visible.

### 2.7 Cards (6 pts)

- mêmes radius / border / shadow / padding ;
- hover state si interactive ;
- contenu équilibré.

### 2.8 Formulaires (6 pts)

- labels visibles ;
- focus visible ;
- erreurs localisées ;
- bouton submit clair ;
- champs autocomplete.

### 2.9 Tables / dashboards (6 pts)

- colonnes lisibles ;
- pagination ≥ 25 lignes ;
- états vides ;
- responsive.

### 2.10 Images / médias (6 pts)

- cohérence avec le contenu ;
- alt text présent ;
- ratios cohérents ;
- optimisées (WebP, dimensions adaptées).

### 2.11 Responsive (8 pts)

- testé 4 breakpoints ;
- aucun overflow horizontal ;
- menu mobile fonctionnel ;
- CTA atteignables au pouce.

### 2.12 Cohérence globale (8 pts)

- même style boutons / cards / forms partout ;
- header / footer cohérent ;
- pas d'alternance entre pages modernes et anciennes ;
- design system unifié.

---

## 3. Calcul du score

```
Score visuel = Σ des 12 critères (max 100)
```

**Penalty bloquant :**
- si **2.5 (Layout)** = 0 (pages cassées, overflow systématique) → score plafonné à **40** quel que soit le total.

---

## 4. Comment améliorer le score

### Si score < 40

1. **Corriger** les bases : H1 unique, body 16 px+, contraste AA ;
2. **Restreindre** la palette à 1 dominante + 1 accent + neutres ;
3. **Restreindre** la typo à 2 familles, 3 poids ;
4. **Adopter** une échelle de spacing géométrique ;
5. Re-scorer.

### Si score 41–60

1. **Harmoniser** les composants (mêmes boutons, cards, forms partout) ;
2. **Borner** le container ;
3. **Optimiser** les images ;
4. **Fixer** le responsive (menu mobile + breakpoints) ;
5. Re-scorer.

### Si score 61–75

1. **Polir** les détails (hover states, micro-interactions) ;
2. **Améliorer** les états (vides, chargement, erreur) ;
3. **Vérifier** la cohérence inter-pages ;
4. **Tester** l'accessibilité ;
5. Re-scorer.

### Si score 76–90

1. **Auditer** les anti-patterns restants ;
2. **Vérifier** le test du logo enlevé ;
3. **Polir** les petits détails ;
4. Publier.

### Si score 91–100

- Publier ;
- documenter le projet comme **référence** pour les futurs.

---

## 5. Format de sortie

```markdown
## Score visuel : 78 / 100 — Propre et professionnel

| Critère | Score | Note |
|---|---|---|
| Hiérarchie visuelle | 11 / 12 | impeccable sur la home, 1 H1 manquant sur /contact |
| Lisibilité | 10 / 10 | OK |
| Typographie | 8 / 10 | 2 familles + 3 poids OK, échelle un peu approximative |
| Spacing | 9 / 10 | quelques `padding: 17px` arbitraires |
| Layout | 9 / 10 | OK |
| Buttons / CTA | 7 / 8 | 4 variantes au lieu de 3 |
| Cards | 5 / 6 | cards admin avec radius différent du front |
| Formulaires | 5 / 6 | login OK, reset password sans focus visible |
| Tables / dashboards | 5 / 6 | OK, manque état vide sur /admin/orders |
| Images | 4 / 6 | mix photo + illustration sur la home |
| Responsive | 7 / 8 | OK 4 breakpoints, table admin déborde sur 320 |
| Cohérence globale | 8 / 8 | excellent |
| **Total** | **88 / 100** | |

**Verdict** : Propre et professionnel. Publiable.

**Top 3 actions immédiates** :
1. Ajouter le H1 manquant sur /contact.
2. Harmoniser les radius des cards admin avec le front.
3. Fixer le responsive de la table /admin/orders en mobile.
```

---

## 6. Quand délégué à `premium-webdesigner` ?

Si le score visuel est **inférieur à 60** ET que la cause principale est un **manque de direction artistique** (typographie générique, palette aléatoire, pas de personnalité), recommander explicitement **`premium-webdesigner`** au lieu d'essayer de tout corriger en Mode 2.

Exemple :

> *"Le score visuel actuel est de 42/100. Les principaux problèmes sont une typographie sans personnalité, une palette de 6 couleurs concurrentes, et un design qui ressemble à un template par défaut. La correction des incohérences seules ne suffira pas. Je recommande d'utiliser le skill `premium-webdesigner` pour produire une vraie direction artistique avant que je ne reprenne l'audit ergonomique."*

---

Created by João de Almeida
