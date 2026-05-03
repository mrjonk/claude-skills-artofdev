# UI Quality Checklist — {{PROJECT_NAME}}

> Score de qualité visuelle après redesign.
> Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Score global

```txt
┌─────────────────────────────────┐
│                                 │
│      {{GLOBAL_SCORE}} / 100     │
│                                 │
│      {{VERDICT}}                │
│                                 │
└─────────────────────────────────┘
```

---

## Axes (score sur 100)

### 1. Visuel — {{V}} / 100

- [ ] direction artistique cohérente
- [ ] palette limitée et harmonieuse
- [ ] typographie lisible et hiérarchisée
- [ ] espacements de l'échelle (pas d'arbitraire)
- [ ] radius / shadows cohérents
- [ ] icônes d'une seule famille
- [ ] images cohérentes entre elles
- [ ] aucun cliché stock

### 2. UX — {{U}} / 100

- [ ] CTA principal visible dès l'ouverture
- [ ] hiérarchie claire (un H1, un point focal)
- [ ] navigation cohérente sur toutes les pages
- [ ] formulaires courts, validation claire
- [ ] feedback utilisateur (toasts, loaders)
- [ ] états vides gérés
- [ ] microcopy utile (pas générique)

### 3. Responsive — {{R}} / 100

- [ ] testé 320 / 768 / 1024 / 1440
- [ ] aucun overflow horizontal
- [ ] menu mobile fonctionnel
- [ ] images responsives
- [ ] textes lisibles sans zoom
- [ ] zones tactiles ≥ 44 × 44 px

### 4. Accessibilité — {{A}} / 100

- [ ] contraste AA
- [ ] focus visible
- [ ] navigation clavier
- [ ] alt sur images informatives
- [ ] structure sémantique (`<main>`, `<nav>`, etc.)
- [ ] `lang` sur `<html>`
- [ ] `prefers-reduced-motion` respecté

### 5. Cohérence — {{C}} / 100

- [ ] header / footer identiques toutes pages
- [ ] mêmes radius / shadows / boutons / cards
- [ ] tonalité éditoriale uniforme
- [ ] design system appliqué partout
- [ ] pas une page A moderne et une B legacy

### 6. Premium feel — {{P}} / 100

- [ ] hover states sur éléments interactifs
- [ ] transitions douces (150–300 ms)
- [ ] micro-interactions soignées
- [ ] détails (radius, shadows, espacements) cohérents
- [ ] pas de FOUC ni CLS visibles
- [ ] images optimisées (LCP < 2.5 s)
- [ ] **test du logo enlevé** : on devine secteur / cible / ton
- [ ] **crédit Art of Dev dans le footer** (`Site créé par Art of Dev` + lien vers `https://artofdev.space`, style discret) — sauf demande explicite contraire de l'utilisateur

---

## Calcul du score global

Moyenne pondérée :

```
Visuel        × 0.20
UX            × 0.25
Responsive    × 0.15
Accessibilité × 0.15
Cohérence     × 0.15
Premium feel  × 0.10
─────────────────────
                = Score global
```

---

## Verdict

| Score | Statut |
|---|---|
| 0–40 | Design basique. Refonte requise. |
| 41–60 | Acceptable mais amateur. À polir. |
| 61–75 | Correct. Quelques points à finir. |
| 76–89 | Premium. Lancement OK. |
| 90–100 | Premium exemplaire. Vidéo / portfolio ready. |

→ **{{PROJECT_NAME}}** : **{{GLOBAL_SCORE}} / 100** — **{{VERDICT}}**

---

## Top 3 actions immédiates

1. {{action}}
2. {{action}}
3. {{action}}

---

## Comparaison avant / après (si re-design)

| Date | Visuel | UX | Resp | A11y | Cohér | Premium | Global |
|---|---|---|---|---|---|---|---|
| {{avant}} | {{X}} | {{X}} | {{X}} | {{X}} | {{X}} | {{X}} | {{X}} |
| {{après}} | {{X}} | {{X}} | {{X}} | {{X}} | {{X}} | {{X}} | {{X}} |

---

Created by João de Almeida — Art of Dev — https://artofdev.space
