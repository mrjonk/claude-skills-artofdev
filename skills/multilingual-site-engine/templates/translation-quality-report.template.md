# Rapport qualité de traduction — {{PROJECT_NAME}}

> Évaluation détaillée de la qualité de traduction par langue.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Langue source** : {{ex: fr-FR}}
- **Langues évaluées** : {{ex: en-US, de-DE}}
- **Volume audité** : {{N chaînes}}
- **Méthode** : {{revue manuelle / échantillonnage / 100 % couverture}}

---

## Score global

```txt
┌─────────────────────────────────────┐
│                                     │
│  Translation Quality : {{X / 100}}  │
│                                     │
│  Verdict : {{...}}                  │
│                                     │
└─────────────────────────────────────┘
```

---

## Score par critère

| Critère | Poids | Note brute | Score pondéré |
|---|---|---|---|
| Fidélité au sens | 18 | {{n / 18}} | {{...}} |
| Naturel | 16 | {{n / 16}} | {{...}} |
| Adaptation culturelle | 12 | {{n / 12}} | {{...}} |
| Préservation des variables | 12 | {{n / 12}} | {{...}} |
| Cohérence terminologique | 10 | {{n / 10}} | {{...}} |
| Adaptation au registre UI | 8 | {{n / 8}} | {{...}} |
| Absence de style IA | 10 | {{n / 10}} | {{...}} |
| Ponctuation locale | 6 | {{n / 6}} | {{...}} |
| Pas de fautes | 8 | {{n / 8}} | {{...}} |
| **Total** | **100** | | **{{X / 100}}** |

---

## Score par langue

| Langue | Score |
|---|---|
| {{en-US}} | {{X / 100}} |
| {{de-DE}} | {{X / 100}} |
| {{es-ES}} | {{X / 100}} |

---

## Problèmes critiques

### TQ-CRIT-001 — {{Titre court}}

- **Langue** : {{lang}}
- **Type** : {{contresens / variable cassée / faute / autre}}
- **Localisation** : `{{file:line}}` ou clé `{{namespace.key}}`
- **Source** : *"{{texte source}}"*
- **Traduction actuelle** : *"{{texte produit}}"*
- **Problème** : {{description}}
- **Correction proposée** : *"{{texte corrigé}}"*

---

## Problèmes importants

### TQ-IMP-001 — {{...}}

- ...

---

## Problèmes mineurs

### TQ-MIN-001 — {{...}}

- ...

---

## Style IA détecté

| Pattern | Occurrences | Fichiers |
|---|---|---|
| Tirets longs (—) abusifs | {{N}} | {{liste}} |
| *"dans le monde d'aujourd'hui"* | {{N}} | {{liste}} |
| *"solution innovante"* | {{N}} | {{liste}} |
| *"révolutionner"* | {{N}} | {{liste}} |
| *"expérience fluide"* | {{N}} | {{liste}} |
| *"de plus en plus"* | {{N}} | {{liste}} |
| *"il est important de"* | {{N}} | {{liste}} |
| *"découvrez comment"* | {{N}} | {{liste}} |

→ Cf. `humanization-report.template.md` pour la réécriture.

---

## Cohérence terminologique

| Terme | Variantes trouvées | Choix recommandé |
|---|---|---|
| {{ex: cart}} | panier / caddie / sélection | **panier** |
| {{ex: dashboard}} | tableau de bord / dashboard | **tableau de bord** |
| {{...}} | | |

---

## Variables et placeholders

| Variable | Préservée | Cassée | Fichier |
|---|---|---|---|
| `{name}` | {{N}} | {{N}} | |
| `%s` | {{N}} | {{N}} | |
| `{{count}}` | {{N}} | {{N}} | |

---

## Pluriels

- [ ] gestion ICU MessageFormat ou équivalent ;
- [ ] vérifié pour `count = 0`, `count = 1`, `count = 2`, `count = 100` ;
- [ ] couverture langues complexes (russe, arabe) si applicable.

---

## Résumé exécutif

{{5 lignes max.}}

La traduction {{lang}} est **{{verdict}}**.
Les **{{N_CRIT}}** problèmes critiques nécessitent correction immédiate.
Les **{{N_IMP}}** importants doivent être traités avant publication.
Style IA détecté : **{{X}}** patterns.
Score : **{{X / 100}}**.

---

## Top 5 corrections immédiates

1. {{...}}
2. {{...}}
3. {{...}}
4. {{...}}
5. {{...}}

---

## Prochaine étape

> {{Une seule phrase actionnable.}}

---

Created by João de Almeida
