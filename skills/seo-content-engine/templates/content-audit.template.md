# Audit éditorial — {{TITRE_DU_CONTENU_AUDITÉ}}

- **Date** : {{YYYY-MM-DD}}
- **URL / fichier** : {{URL ou chemin}}
- **Type de contenu** : {{article / page produit / tutoriel / FAQ / etc.}}
- **Auditeur** : Claude (skill `seo-content-engine`)
- **Mode** : {{audit-only | audit + corrections proposées}}

> Created by João de Almeida

---

## 1. Résumé exécutif (5 lignes max)

Le contenu est **{{verdict en clair}}**.
Score qualité éditoriale : **{{X / 100}}**.
Les **{{N_CRIT}}** problèmes critiques bloquent la publication.
Les **{{N_IMP}}** problèmes importants doivent être corrigés avant la mise en ligne.
**Top 3 actions** : {{action 1}} ; {{action 2}} ; {{action 3}}.

---

## 2. Score détaillé

| Critère | Score | Note |
|---|---|---|
| Précision | {{X / 12}} | {{...}} |
| Utilité | {{X / 12}} | {{...}} |
| Originalité | {{X / 12}} | {{...}} |
| Profondeur | {{X / 10}} | {{...}} |
| Structure SEO | {{X / 10}} | {{...}} |
| Absence de bullshit | {{X / 10}} | {{...}} |
| Exemples concrets | {{X / 8}} | {{...}} |
| Cohérence du ton | {{X / 6}} | {{...}} |
| Qualité FAQ | {{X / 6}} | {{...}} |
| Qualité CTA | {{X / 4}} | {{...}} |
| Qualité images | {{X / 5}} | {{...}} |
| Qualité sources | {{X / 5}} | {{...}} |
| **Total** | **{{X / 100}}** | |

**Verdict :** {{Inutilisable | Trop générique | Correct mais faible | Publiable avec corrections | Bon contenu SEO | Premium}}

---

## 3. Problèmes critiques (bloquants)

### CRIT-001 — {{Titre court}}

- **Catégorie** : {{Précision / Utilité / Bullshit / Sources / SEO / etc.}}
- **Localisation** : {{section, paragraphe}}
- **Citation problématique** : > *"{{extrait fautif}}"*
- **Pourquoi c'est critique** : {{explication}}
- **Correction recommandée** : {{...}}

### CRIT-002 — {{...}}

- ...

---

## 4. Problèmes importants

### IMP-001 — {{Titre}}

- **Catégorie** : {{...}}
- **Localisation** : {{...}}
- **Pourquoi c'est important** : {{...}}
- **Correction recommandée** : {{...}}

### IMP-002 — {{...}}

…

---

## 5. Problèmes mineurs

### MIN-001 — {{Titre}}

- **Catégorie** : {{...}}
- **Localisation** : {{...}}
- **Correction recommandée** : {{...}}

---

## 6. Paragraphes transposables détectés

> Test du paragraphe transposable (cf. `references/anti-bullshit-rules.md` §2).

| # | Localisation | Extrait | Recommandation |
|---|---|---|---|
| T-001 | {{section / paragraphe X}} | *"{{extrait}}"* | {{réécrire avec exemple concret OU supprimer}} |
| T-002 |  |  |  |

---

## 7. Phrases creuses détectées

> Liste des phrases bannies (cf. `references/anti-bullshit-rules.md` §1).

| # | Localisation | Phrase | Réécriture proposée |
|---|---|---|---|
| F-001 | introduction | *"Dans le monde d'aujourd'hui..."* | *"Pour les équipes qui travaillent en remote depuis 2020..."* |
| F-002 |  |  |  |

---

## 8. Répétitions détectées

| # | Localisation | Répétition | Action |
|---|---|---|---|
| R-001 | {{H2 X et H2 Y}} | {{même idée formulée 2 fois}} | {{fusionner ou différencier}} |
| R-002 |  |  |  |

---

## 9. Statistiques / citations non sourcées

| # | Localisation | Affirmation | Source à trouver ou suppression |
|---|---|---|---|
| S-001 | {{section}} | *"{{ex: 78 % des utilisateurs..."}}* | trouver source ou retirer le chiffre |
| S-002 |  |  |  |

---

## 10. SEO — points à corriger

- **`<title>`** : {{✅ OK | ⚠️ trop long / trop court / manque mot-clé}} → correction : {{...}}
- **`<meta description>`** : {{...}}
- **slug** : {{...}}
- **H1** : {{...}}
- **structure H2/H3** : {{...}}
- **mot-clé principal** : {{densité, placement}}
- **mots-clés secondaires** : {{...}}
- **liens internes** : {{nombre, qualité des ancres}}
- **plan d'images** : {{présent / absent / partiel}}
- **alt text** : {{...}}
- **sources** : {{...}}

---

## 11. FAQ — qualité

- **Nombre de questions** : {{X}}
- **Qualité** : {{utile / artificielle / mixte}}
- **Questions à supprimer** : {{liste}}
- **Questions à reformuler** : {{liste}}
- **Questions manquantes (à ajouter)** : {{liste}}

---

## 12. Corrections appliquées (si mode "audit + corrections")

| ID | Localisation | Correction | Annulable par |
|---|---|---|---|
| CRIT-003 | introduction | suppression de la phrase *"Dans le monde d'aujourd'hui..."* | `git revert` |
| MIN-007 | section 4 | reformulation d'une phrase répétée | `git revert` |

---

## 13. Corrections recommandées (à faire par l'utilisateur)

| Priorité | ID | Action |
|---|---|---|
| 1 | CRIT-001 | {{...}} |
| 1 | CRIT-002 | {{...}} |
| 2 | IMP-001 | {{...}} |
| 3 | MIN-001 | {{...}} |

---

## 14. Plan d'action

### Phase 1 — Bloquants (priorité 1)
- [ ] CRIT-001
- [ ] CRIT-002
- [ ] CRIT-003

### Phase 2 — Importants (priorité 2)
- [ ] IMP-001
- [ ] IMP-002
- [ ] supprimer paragraphes transposables détectés
- [ ] supprimer phrases creuses détectées

### Phase 3 — Mineurs / polish (priorité 3)
- [ ] MIN-001
- [ ] MIN-002
- [ ] revoir les liens internes
- [ ] compléter le plan d'images

### Phase 4 — Validation finale
- [ ] re-scan avec `scan-generic-content.sh` → 0 alerte
- [ ] re-scan avec `scan-repetitions.sh` → 0 alerte
- [ ] re-calcul du score qualité éditoriale → ≥ 76

---

## 15. Prochaine étape

> {{Une seule phrase actionnable. Ex: "Corriger les 3 problèmes critiques (CRIT-001 à CRIT-003), supprimer les 5 paragraphes transposables, relancer un audit, viser un score ≥ 76 avant publication."}}

---

Created by João de Almeida
