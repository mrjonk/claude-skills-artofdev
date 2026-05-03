# Skill routing map

> Table de routage pour l'orchestrateur de skills Art of Dev.
> Created by João de Almeida

## Objectif

Permettre à `skill-orchestrator` (et à tout utilisateur humain) d'identifier rapidement quel skill activer pour une demande donnée, sans charger plusieurs skills inutilement.

## Principe : "le plus spécifique gagne"

Quand plusieurs skills semblent applicables, choisir celui dont le périmètre est le plus précis pour la tâche.

## Table principale

| Intention utilisateur | Skill principal | Skills secondaires (si demandé) | Ne pas utiliser quand |
|---|---|---|---|
| Créer un nouveau repo | `repo-builder` | `production-auditor` (post-création) | Modification d'un repo existant |
| Audit avant production | `production-auditor` | `site-ux-guardian`, `premium-webdesigner`, `seo-content-engine` | Tweak CSS isolé |
| Refonte design / direction artistique | `premium-webdesigner` | `site-ux-guardian` (cohérence post-refonte), `production-auditor` (final) | Fix CSS unitaire |
| Rédiger article / tutoriel / page produit / FAQ | `seo-content-engine` | `multilingual-site-engine` (si à traduire) | Email court ou post réseau social |
| Audit ergonomique transversal (menus, footers, doublons, responsive) | `site-ux-guardian` | `premium-webdesigner` (refonte créative), `production-auditor` (audit final) | Refonte créative pure |
| Traduction / localisation / multilingue | `multilingual-site-engine` | `seo-content-engine` (contenu enrichi), `site-ux-guardian` (cohérence post-trad), `premium-webdesigner` (responsive après textes plus longs) | Une seule phrase ou email |
| Demande ambiguë / "quel skill ?" | `skill-orchestrator` | (le skill principal qu'il recommande) | Demande déjà parfaitement claire |

## Workflows multi-skills recommandés

### Workflow refonte complète d'un site existant
1. `site-ux-guardian` — audit cohérence (state des lieux)
2. `premium-webdesigner` — refonte design
3. `multilingual-site-engine` — si site à internationaliser
4. `seo-content-engine` — si contenu à enrichir
5. `production-auditor` — audit final avant prod

→ JAMAIS chaîner automatiquement. Toujours demander validation entre étapes.

### Workflow nouveau projet
1. `repo-builder` — création de la structure
2. `premium-webdesigner` — design initial (si vitrine/SaaS/dashboard)
3. `seo-content-engine` — contenu initial
4. `multilingual-site-engine` — si multilingue dès le départ
5. `production-auditor` — audit final

### Workflow audit avant publication YouTube / vidéo
1. `production-auditor` — mode `VIDEO_PRESENTATION_MODE`
2. `site-ux-guardian` — vérification cohérence visuelle filmable

## Anti-patterns

- ❌ Charger automatiquement 4 skills "par sécurité" → bcp de tokens, peu utile.
- ❌ Lancer un audit complet pour une typo → préférer une correction directe sans skill.
- ❌ Mobiliser `premium-webdesigner` pour un changement de couleur isolé.
- ❌ Mobiliser `seo-content-engine` pour un email court.
- ❌ Mobiliser `multilingual-site-engine` pour traduire une phrase isolée.

## Quand ne charger AUCUN skill

- Question informationnelle (`Comment fonctionne X ?`)
- Modification triviale (typo, espace, virgule)
- Conversation de planification non technique
- Demande déjà couverte par un assistant général

## Règles d'arbitrage

1. Le skill le plus spécifique au domaine gagne.
2. Le skill explicitement nommé par l'utilisateur gagne.
3. Si conflit non résolu : demander à l'utilisateur 1 question courte.
4. Toujours expliquer le choix du skill (1 phrase suffit).

## Confirmation requise

`skill-orchestrator` doit demander confirmation avant :
- toute mobilisation simultanée de 2+ gros skills
- tout audit "complet" sans précision de périmètre
- toute traduction multi-langues
- toute création de repo
- toute action destructive

---

Created by João de Almeida
