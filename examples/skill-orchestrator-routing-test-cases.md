# skill-orchestrator — 15 routing test cases

> Cas réalistes pour valider la table de routage `docs/skill-routing-map.md`.
> Chaque cas documente : demande utilisateur → skill principal attendu → secondaires éventuels → skills à NE PAS utiliser → confirmation requise → risque token → raison.
> Created by João de Almeida

> **Note honnêteté :** ces cas sont des **attentes documentées**, pas des observations runtime. Un humain doit invoquer ces 15 prompts dans une vraie session Claude pour valider que `skill-orchestrator` les route effectivement comme attendu.

---

## Cas 1 — Création de repo mini CMS

**Demande :** *"Crée un repo propre pour un mini CMS restaurant PHP/SQLite."*

| Élément | Valeur |
|---|---|
| Skill principal | `repo-builder` |
| Skills secondaires | aucun (audit pertinent uniquement après mise en prod) |
| Skills à NE PAS utiliser | `production-auditor`, `premium-webdesigner` (rien à auditer/refaire à la création) |
| Confirmation requise | non (intention claire) |
| Risque token | faible — skill seul |
| Raison | "Crée un repo" = signal explicite, stack précisée, pas d'ambiguïté |

---

## Cas 2 — Audit avant prod

**Demande :** *"Audite ce SaaS avant mise en prod."*

| Élément | Valeur |
|---|---|
| Skill principal | `production-auditor` |
| Skills secondaires | `site-ux-guardian` si l'utilisateur valide étendre l'audit côté ergonomie |
| Skills à NE PAS utiliser | `repo-builder` (repo existe déjà), `seo-content-engine` (pas le périmètre) |
| Confirmation requise | non |
| Risque token | moyen — chargement complet d'un audit 7-axes |
| Raison | "audit avant mise en prod" = match direct |

---

## Cas 3 — Refonte WordPress template

**Demande :** *"Ce site fait trop template WordPress, rends-le premium."*

| Élément | Valeur |
|---|---|
| Skill principal | `premium-webdesigner` |
| Skills secondaires | `site-ux-guardian` après refonte (cohérence post-design) |
| Skills à NE PAS utiliser | `seo-content-engine` (pas de demande contenu) |
| Confirmation requise | **oui** — confirmer périmètre (homepage seule ? tout le site ?) avant phase 1 du skill |
| Risque token | élevé — méthode 6-phases + génération brief/moodboard |
| Raison | "rends-le premium" = signal direct refonte créative |

---

## Cas 4 — Traduction site

**Demande :** *"Traduis tout le site en anglais et allemand."*

| Élément | Valeur |
|---|---|
| Skill principal | `multilingual-site-engine` |
| Skills secondaires | `site-ux-guardian` après trad (responsive après textes plus longs, cohérence menus) |
| Skills à NE PAS utiliser | `seo-content-engine` (sauf si textes à enrichir) |
| Confirmation requise | non — langues précisées |
| Risque token | élevé — méthode 12 étapes |
| Raison | "Traduis le site en X et Y" = match direct, langues données → pas de question préalable |

---

## Cas 5 — Article SEO

**Demande :** *"Écris un article SEO complet sur Claude Code pour débutants."*

| Élément | Valeur |
|---|---|
| Skill principal | `seo-content-engine` |
| Skills secondaires | `multilingual-site-engine` uniquement si traduction demandée |
| Skills à NE PAS utiliser | `premium-webdesigner` (pas de demande design), `production-auditor` |
| Confirmation requise | non |
| Risque token | moyen |
| Raison | "Écris un article SEO" = match direct |

---

## Cas 6 — Cohérence menus/footers

**Demande :** *"Vérifie que les menus et footers sont cohérents partout."*

| Élément | Valeur |
|---|---|
| Skill principal | `site-ux-guardian` |
| Skills secondaires | aucun par défaut |
| Skills à NE PAS utiliser | `premium-webdesigner` (pas de refonte demandée), `production-auditor` (pas de demande prod) |
| Confirmation requise | non |
| Risque token | moyen |
| Raison | "menus et footers cohérents" = cœur de site-ux-guardian |

---

## Cas 7 — Typo isolée (anti-pattern)

**Demande :** *"Corrige juste cette typo."*

| Élément | Valeur |
|---|---|
| Skill principal | **AUCUN** |
| Skills secondaires | aucun |
| Skills à NE PAS utiliser | tous |
| Confirmation requise | non |
| Risque token | nul si l'orchestrateur respecte la règle "aucun skill" |
| Raison | tâche atomique → corriger directement, pas de skill nécessaire. Anti-pattern explicite dans `skill-routing-map.md`. |

---

## Cas 8 — Audit sécurité profond

**Demande :** *"Je veux un audit sécurité profond."*

| Élément | Valeur |
|---|---|
| Skill principal | `production-auditor` |
| Skills secondaires | aucun |
| Skills à NE PAS utiliser | `site-ux-guardian` (signalement basique seulement, périmètre insuffisant) |
| Confirmation requise | non |
| Risque token | moyen-élevé |
| Raison | "sécurité profond" = `production-auditor` > `site-ux-guardian` selon la table de délégation |

---

## Cas 9 — Refonte partielle avec garde-fou

**Demande :** *"Je veux refaire la homepage mais ne touche pas au back-office."*

| Élément | Valeur |
|---|---|
| Skill principal | `premium-webdesigner` |
| Skills secondaires | `site-ux-guardian` ciblé sur la homepage uniquement (cohérence post-refonte) |
| Skills à NE PAS utiliser | aucun à priori — l'instruction "ne touche pas au back-office" doit être propagée comme garde-fou explicite |
| Confirmation requise | **oui** — confirmer le périmètre (homepage = quels fichiers exactement ?) |
| Risque token | moyen |
| Raison | refonte demandée mais bornée → activer `premium-webdesigner` avec scope strict |

---

## Cas 10 — Multilingue thème WordPress

**Demande :** *"Ajoute le multilingue à un thème WordPress."*

| Élément | Valeur |
|---|---|
| Skill principal | `multilingual-site-engine` |
| Skills secondaires | aucun par défaut ; `site-ux-guardian` si demande étendue |
| Skills à NE PAS utiliser | `seo-content-engine` (sauf si textes à enrichir) |
| Confirmation requise | **oui** — demander quelles langues cibles (le skill l'impose explicitement) |
| Risque token | élevé |
| Raison | thème WordPress → stack reconnue, méthode i18n existante (textdomain, .po/.mo) |

---

## Cas 11 — Demande de méta-routage

**Demande :** *"Quel skill dois-je utiliser pour ça ?"*

| Élément | Valeur |
|---|---|
| Skill principal | `skill-orchestrator` (récursif — c'est pile son rôle) |
| Skills secondaires | celui qu'il finit par recommander |
| Skills à NE PAS utiliser | tous tant que la recommandation n'est pas confirmée |
| Confirmation requise | non |
| Risque token | nul (l'orchestrateur est le skill le plus court à charger) |
| Raison | méta-question explicite, exactement ce que l'orchestrateur sert |

---

## Cas 12 — Workflow multi-skills explicite

**Demande :** *"Fais une refonte complète du site + traduction + audit final."*

| Élément | Valeur |
|---|---|
| Skill principal | aucun unique → orchestrateur enchaîne 4 skills |
| Skills secondaires | dans l'ordre : `premium-webdesigner` → `multilingual-site-engine` → `site-ux-guardian` → `production-auditor` |
| Skills à NE PAS utiliser | `repo-builder` (pas de création) |
| Confirmation requise | **oui — chaque transition entre skills doit demander validation** |
| Risque token | très élevé — workflow le plus lourd possible |
| Raison | demande explicitement multi-skills. `skill-orchestrator` doit proposer le plan AVANT d'exécuter. |

---

## Cas 13 — Repo sans push (garde-fou)

**Demande :** *"Prépare un repo mais ne le pousse pas."*

| Élément | Valeur |
|---|---|
| Skill principal | `repo-builder` |
| Skills secondaires | aucun |
| Skills à NE PAS utiliser | aucun |
| Confirmation requise | non — la contrainte "pas de push" est déjà claire |
| Risque token | faible |
| Raison | `repo-builder` a déjà la règle "pas de push sans accord explicite". L'instruction utilisateur la renforce. |

---

## Cas 14 — Doublons + cohérence navigation

**Demande :** *"Supprime les doublons HeaderV2/FooterNew et rends la navigation cohérente."*

| Élément | Valeur |
|---|---|
| Skill principal | `site-ux-guardian` |
| Skills secondaires | aucun |
| Skills à NE PAS utiliser | `premium-webdesigner` (pas de refonte créative demandée) |
| Confirmation requise | **oui** — la suppression de fichiers (`HeaderV2`, `FooterNew`) est destructive. Le skill doit proposer un plan de migration AVANT toute suppression. |
| Risque token | moyen |
| Raison | "doublons + cohérence" = cœur de site-ux-guardian, mais la partie "supprime" déclenche le garde-fou destructif |

---

## Cas 15 — Workflow chaîné contenu + traduction

**Demande :** *"Rédige une page produit SaaS, puis propose une version EN."*

| Élément | Valeur |
|---|---|
| Skill principal | `seo-content-engine` (1ère étape) |
| Skills secondaires | `multilingual-site-engine` (2ème étape, sur la page produite) |
| Skills à NE PAS utiliser | `premium-webdesigner` (pas de design demandé) |
| Confirmation requise | non — plan séquentiel évident |
| Risque token | moyen-élevé (2 skills enchaînés) |
| Raison | "Rédige... puis EN" = workflow naturellement séquentiel, langue cible déjà précisée |

---

## Synthèse des règles d'arbitrage observées

D'après ces 15 cas, l'orchestrateur doit appliquer ces règles dans l'ordre :

1. **Skill explicitement nommé dans la demande gagne.** (cas 11, 13)
2. **Tâche atomique = aucun skill.** (cas 7)
3. **Skill le plus spécifique au domaine gagne.** (cas 6, 8)
4. **Demande multi-skills = plan + confirmation.** (cas 12)
5. **Périmètre borné explicitement = propager comme garde-fou.** (cas 9, 13, 14)
6. **Action destructive demandée = confirmation obligatoire.** (cas 14)
7. **Multi-langues = `multilingual-site-engine` même si SEO mentionné.** (cas 4, 15)

---

## Confirmation requise — récapitulatif

| Cas | Confirmation ? | Raison |
|---|:---:|---|
| 3 | oui | Périmètre refonte à clarifier |
| 9 | oui | Périmètre "pas le back-office" à valider |
| 10 | oui | Langues cibles à demander |
| 12 | oui (à chaque transition) | Workflow lourd |
| 14 | oui | Action destructive |

Soit **5 cas sur 15** où la confirmation est obligatoire — cohérent avec la philosophie "ne pas mobiliser plusieurs gros skills sans validation" et "ne pas faire d'action destructive sans accord explicite".

---

## Reste à valider en runtime

Cette table décrit l'**attente**. Le test runtime consiste à :

1. Ouvrir une session Claude Code avec le skill `skill-orchestrator` installé.
2. Soumettre les 15 prompts ci-dessus, un par un.
3. Vérifier que la réponse cite le skill principal attendu, propose les bons secondaires, demande la bonne confirmation.
4. Documenter les écarts dans une seconde passe de `reports/validation-skill-orchestrator.md`.

Tant que ce runtime n'est pas fait, le skill reste en statut "spec validée statiquement, runtime non observé".

---

Created by João de Almeida
