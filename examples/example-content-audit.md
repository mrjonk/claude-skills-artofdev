# Exemple — Audit éditorial d'un article existant

## Contexte

Audit d'un article de blog publié il y a 3 mois mais qui ne convertit pas et a un taux de rebond élevé.
Public : éditeurs / responsables éditoriaux / créateurs de contenu.

## Prompt utilisateur

> *"Audit this existing article (paste full text below). Focus on : generic paragraphs that could fit any topic, empty marketing phrases, repetitions, unsourced statistics, artificial FAQ, aggressive or generic CTA, weak SEO structure. Output : score (0-100) per criterion, list of CRIT/IMP/MIN issues, top 3 immediate actions. DO NOT rewrite — just audit."*

## Angle d'audit attendu

- **Lecture seule** : ne pas réécrire l'article, juste produire le rapport ;
- **Honnêteté** : si l'article est mauvais, le dire poliment mais clairement ;
- **Actionnable** : chaque problème identifié doit avoir une recommandation concrète.

## Structure du rapport attendu

(Cf. `templates/content-audit.template.md`.)

| Section | Contenu |
|---|---|
| Résumé exécutif | 5 lignes max, score global, top 3 actions |
| Score détaillé | tableau 12 critères |
| Problèmes critiques | liste CRIT-NNN avec citation + correction |
| Problèmes importants | liste IMP-NNN |
| Problèmes mineurs | liste MIN-NNN |
| Paragraphes transposables | tableau avec extraits |
| Phrases creuses | tableau avec localisation |
| Répétitions | tableau |
| Statistiques non sourcées | tableau |
| SEO à corriger | checklist |
| FAQ — qualité | analyse |
| Plan d'action | phases 1 à 4 |

## Exemples de problèmes typiques détectés

### Phrases creuses fréquentes (à signaler comme F-001, F-002...)

- *"Dans le monde d'aujourd'hui, les entreprises font face à de nombreux défis..."* (intro)
- *"Il est important de comprendre que..."*
- *"De plus en plus de professionnels..."*
- *"À l'ère du numérique..."*
- *"Une solution innovante qui révolutionne..."*

### Paragraphes transposables (T-001, T-002...)

- Paragraphe d'introduction qui pourrait être l'intro de **tout** article du blog ;
- Conclusion qui ne fait que résumer ce qui précède ;
- Section "Pourquoi c'est important" qui ne dit rien de spécifique au sujet.

### Statistiques non sourcées (S-001...)

- *"80 % des utilisateurs préfèrent..."* sans nom d'étude ;
- *"Selon une étude récente..."* sans précision ;
- *"De nombreux experts s'accordent à dire..."* sans nommer les experts.

### SEO faible

- title trop long ou trop court ;
- meta description manquante ;
- 2 H1 dans la page (bug) ;
- pas de mot-clé principal placé naturellement ;
- aucun lien interne.

### FAQ artificielle

- 8 questions qui sont des variantes les unes des autres ;
- réponses qui bottent en touche (*"cela dépend"*) ;
- questions auxquelles l'article a déjà répondu.

### CTA faible

- *"N'hésitez pas à nous contacter pour plus d'informations !"* (générique) ;
- 4 CTA différents qui dispersent ;
- aucun lien interne pertinent.

## Score attendu pour un article moyen

| Critère | Score typique d'un article IA générique |
|---|---|
| Précision | 8 / 12 (faits OK, vocabulaire approximatif) |
| Utilité | 4 / 12 (peu actionnable) |
| Originalité | 2 / 12 (transposable à n'importe quel sujet) |
| Profondeur | 3 / 10 (survole) |
| Structure SEO | 6 / 10 (basique) |
| Absence de bullshit | 2 / 10 (rempli de phrases creuses) |
| Exemples concrets | 2 / 8 (vagues) |
| Cohérence du ton | 4 / 6 (correct) |
| Qualité FAQ | 1 / 6 (artificielle) |
| Qualité CTA | 1 / 4 (générique) |
| Qualité images | 2 / 5 (placeholder) |
| Qualité sources | 1 / 5 (non sourcé) |
| **Total** | **36 / 100** — Trop générique |

→ Verdict : **Trop générique**. Refondre ou changer d'angle.

## Plan d'action attendu

### Phase 1 — Bloquants (priorité 1)
- supprimer les **5 paragraphes transposables** identifiés ;
- supprimer les **12 phrases creuses** listées ;
- retirer ou sourcer les **3 statistiques** non sourcées.

### Phase 2 — Importants (priorité 2)
- réécrire l'introduction (3 phrases max, spécifiques) ;
- ajouter **3 exemples concrets** dans les sections principales ;
- refondre la **FAQ** (3–5 questions réelles uniquement).

### Phase 3 — Mineurs (priorité 3)
- corriger title et meta description ;
- ajouter **3 liens internes** pertinents ;
- compléter le plan d'images avec alt text.

### Phase 4 — Validation finale
- re-scan avec `scan-generic-content.sh` → 0 alerte ;
- re-scan avec `scan-repetitions.sh` → 0 alerte ;
- re-calcul du score → cible **≥ 76**.

## Erreurs à éviter dans l'audit

- **manquer d'honnêteté** : si l'article est mauvais, le dire ;
- **être méprisant** : le rédacteur de l'article n'est pas la cible (le rapport doit aider, pas humilier) ;
- **tout réécrire sans demander** : l'audit reste **lecture seule** par défaut ;
- **inventer des problèmes** : si l'article est bon, l'admettre ;
- **score gonflé** par politesse : le score doit refléter la réalité.

## Score qualité du rapport d'audit lui-même

**85+ / 100** si le rapport :
- est précis et factuel ;
- cite des extraits réels de l'article ;
- propose des corrections actionnables ;
- ne réécrit pas l'article ;
- donne un verdict clair sans ambiguïté.

---

Created by João de Almeida
