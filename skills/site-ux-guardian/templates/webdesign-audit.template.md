# Webdesign audit — {{PROJECT_NAME}}

> Audit visuel détaillé selon les 14 axes des webdesign guidelines.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Stack** : {{...}}
- **Pages auditées** : {{liste}}

---

## Résumé visuel

{{Phrase qui résume l'impression générale du site en 2 lignes.}}

---

## Score visuel global : **{{X / 100}}** — {{Verdict}}

(Cf. `references/visual-quality-score.md` pour le barème complet.)

| Verdict | Score |
|---|---|
| Rendu cassé ou amateur | 0–20 |
| Interface incohérente | 21–40 |
| Utilisable mais très basique | 41–60 |
| Correct mais manque de finition | 61–75 |
| **Propre et professionnel** | **76–90** |
| Très cohérent, premium-ready | 91–100 |

---

## Détail par axe (14 axes)

### A. Hiérarchie visuelle ({{X / 12}})

**Constat :** {{...}}

| Critère | Statut |
|---|---|
| Un seul H1 par page | {{✓ / ⚠ avec nombre / ✗}} |
| Structure H2 / H3 logique | {{...}} |
| CTA principal identifiable | {{...}} |
| Ordre visuel cohérent | {{...}} |

**Pages avec problème :** {{liste}}

### B. Lisibilité ({{X / 10}})

**Constat :** {{...}}

| Critère | Statut |
|---|---|
| Body 16 px+ | {{...}} |
| Line-height 1.4–1.6 | {{...}} |
| Contraste AA | {{...}} |
| Largeur de ligne 50–80 ch | {{...}} |

### C. Typographie ({{X / 10}})

| Critère | Statut |
|---|---|
| Max 2 familles | {{...}} |
| Max 3 poids | {{...}} |
| Échelle géométrique | {{...}} |
| Cohérence inter-pages | {{...}} |

### D. Spacing ({{X / 10}})

| Critère | Statut |
|---|---|
| Valeurs de l'échelle | {{...}} |
| Padding mobile ≥ 16 px | {{...}} |
| Espacement sections cohérent | {{...}} |
| Footer respirant | {{...}} |

### E. Layout / alignements ({{X / 10}})

| Critère | Statut |
|---|---|
| Grilles cohérentes | {{...}} |
| Container max-width | {{...}} |
| Alignements propres | {{...}} |
| Équilibre des colonnes | {{...}} |

### F. Buttons / CTA ({{X / 8}})

| Critère | Statut |
|---|---|
| 3 variantes max | {{...}} |
| États hover/focus/active | {{...}} |
| Libellés clairs | {{...}} |
| Focus visible | {{...}} |

### G. Cards ({{X / 6}})

| Critère | Statut |
|---|---|
| Mêmes radius / border / shadow / padding | {{...}} |
| Hover state si interactive | {{...}} |
| Contenu équilibré | {{...}} |

### H. Formulaires ({{X / 6}})

| Critère | Statut |
|---|---|
| Labels visibles | {{...}} |
| Focus visible | {{...}} |
| Erreurs localisées | {{...}} |
| Submit clair | {{...}} |
| Autocomplete activé | {{...}} |

### I. Tables / dashboards ({{X / 6}})

| Critère | Statut |
|---|---|
| Colonnes lisibles | {{...}} |
| Pagination ≥ 25 lignes | {{...}} |
| États vides | {{...}} |
| Responsive | {{...}} |

### J. Images ({{X / 6}})

| Critère | Statut |
|---|---|
| Cohérence avec contenu | {{...}} |
| Alt text présent | {{...}} |
| Ratios cohérents | {{...}} |
| Optimisées (WebP) | {{...}} |

### K. Responsive ({{X / 8}})

| Critère | Statut |
|---|---|
| 4 breakpoints OK | {{...}} |
| Aucun overflow horizontal | {{...}} |
| Menu mobile fonctionnel | {{...}} |
| CTA atteignables au pouce | {{...}} |

### L. Cohérence globale ({{X / 8}})

| Critère | Statut |
|---|---|
| Même style boutons partout | {{...}} |
| Même style cards partout | {{...}} |
| Header / footer cohérents | {{...}} |
| Pas d'alternance moderne / ancien | {{...}} |

### M. Accessibilité visuelle ({{X / 4}})

| Critère | Statut |
|---|---|
| Contraste AA | {{...}} |
| Focus visible | {{...}} |
| Liens identifiables | {{...}} |
| Alt text sur images | {{...}} |
| `prefers-reduced-motion` | {{...}} |

### N. Anti-template / anti-amateur ({{X / 4}})

| Critère | Statut |
|---|---|
| Test du logo enlevé : on devine secteur | {{...}} |
| Test du logo enlevé : on devine cible | {{...}} |
| Test du logo enlevé : on devine ton | {{...}} |
| Pas d'image stock cliché | {{...}} |
| Footer riche (pas pauvre) | {{...}} |

---

## Problèmes par sévérité

### Critiques (bloquent une utilisation propre)

| ID | Description | Fichier / page | Correction |
|---|---|---|---|
| VC-001 | {{...}} | {{...}} | {{...}} |

### Importants

| ID | Description | Fichier / page | Correction |
|---|---|---|---|
| VI-001 | {{...}} | {{...}} | {{...}} |

### Mineurs

| ID | Description | Fichier / page | Correction |
|---|---|---|---|
| VM-001 | {{...}} | {{...}} | {{...}} |

---

## Corrections sûres possibles (Mode 2)

- [ ] {{ex: ajouter `aria-current="page"` sur les liens actifs}} ;
- [ ] {{ex: harmoniser les radius des cards}} ;
- [ ] {{ex: corriger le `font-size` body de 14 → 16 px}} ;
- [ ] {{ex: ajouter `alt` non vide sur 5 images informatives}}.

---

## Corrections à valider

- [ ] {{ex: refonte du hero}} → **demander direction** ;
- [ ] {{ex: changement de palette}} → **valider nouvelle palette**.

---

## Recommandation `premium-webdesigner`

{{Si score visuel < 60 ET cause = manque de direction artistique :}}

> Score visuel actuel : **{{X}} / 100**. Le manque principal est {{description}}. Je recommande d'utiliser le skill `premium-webdesigner` pour produire une vraie direction artistique avant que `site-ux-guardian` ne reprenne l'audit ergonomique.

{{Sinon :}}

> Pas de délégation nécessaire. Les corrections sûres + à valider devraient suffire à atteindre un score ≥ 76.

---

## Prochaine étape

> {{Une phrase actionnable.}}

---

Created by João de Almeida
