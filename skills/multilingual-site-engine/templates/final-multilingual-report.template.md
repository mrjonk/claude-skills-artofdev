# Rapport multilingue final — {{PROJECT_NAME}}

> Rapport final consolidé : scores, problèmes, plan d'action.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Stack** : {{...}}
- **Système i18n** : {{...}}
- **Mode** : {{audit-only / plan / traduction+humanisation / SEO multilingue final}}
- **Skill** : Claude (`multilingual-site-engine` v0.1.0)

---

## Scores

```txt
┌─────────────────────────────────────────────┐
│                                             │
│  Translation Quality : {{X / 100}}          │
│  Multilingual Site Readiness : {{X / 100}}  │
│                                             │
│  Verdict : {{...}}                          │
│                                             │
└─────────────────────────────────────────────┘
```

---

## Score par axe (Multilingual Site Readiness)

| Axe | Poids | Score |
|---|---|---|
| Pages clés traduites | 12 | {{n}} |
| Menus + footers traduits | 10 | {{n}} |
| Formulaires + erreurs + emails traduits | 10 | {{n}} |
| Metadata SEO traduites | 10 | {{n}} |
| `hreflang` correct | 10 | {{n}} |
| `<html lang>` correct | 5 | {{n}} |
| Slugs / routes cohérents | 8 | {{n}} |
| Switch langue fonctionnel | 6 | {{n}} |
| Formats locaux | 6 | {{n}} |
| RTL géré | 5 | {{n}} |
| Fallbacks | 6 | {{n}} |
| Sitemap multilingue | 6 | {{n}} |
| Pas de hardcoding bloquant | 6 | {{n}} |
| **Total** | **100** | **{{X}}** |

---

## Score par langue (Translation Quality)

| Langue | Score |
|---|---|
| {{en-US}} | {{X / 100}} |
| {{de-DE}} | {{X / 100}} |
| {{es-ES}} | {{X / 100}} |
| {{ar-SA}} | {{X / 100}} |

---

## Résumé exécutif

{{5 lignes maximum.}}

Le site est **{{verdict en clair}}**.
Sur {{N langues}} cibles, {{N OK}} sont au niveau publiable.
**{{N_CRIT}}** problèmes critiques bloquent la mise en ligne multilingue propre.
**{{N_IMP}}** problèmes importants doivent être traités.
**{{N_MIN}}** mineurs peuvent attendre.

**Top 3 actions immédiates** :
1. {{action 1}}
2. {{action 2}}
3. {{action 3}}

---

## Problèmes critiques

### MULT-CRIT-001 — {{Titre court}}

- **Catégorie** : {{traduction / SEO / route / format / RTL / humanisation}}
- **Langues touchées** : {{liste}}
- **Fichiers** : `{{chemin}}`
- **Impact** : {{description}}
- **Correction** : {{description}}

### MULT-CRIT-002 — {{...}}

- ...

---

## Problèmes importants

### MULT-IMP-001 — {{...}}

- ...

---

## Problèmes mineurs

### MULT-MIN-001 — {{...}}

- ...

---

## Synthèse par section

| Section | Statut |
|---|---|
| Cadrage langues | {{OK / KO}} |
| Architecture i18n | {{OK / KO}} |
| Pages traduites | {{couverture %}} |
| Menus / footers | {{OK / KO}} |
| Formulaires / erreurs | {{OK / KO}} |
| Emails / notifications | {{OK / KO}} |
| Metadata SEO | {{OK / KO}} |
| Hreflang | {{OK / KO}} |
| Routes / slugs | {{OK / KO}} |
| Formats locaux | {{OK / KO}} |
| RTL (si applicable) | {{OK / KO / N/A}} |
| CMS / contenu dynamique | {{OK / KO}} |
| Humanisation | {{OK / KO}} |

---

## Plan d'action consolidé

| Phase | Description | Priorité | Statut |
|---|---|---|---|
| 1 | Cadrage langues + glossaire | 1 | {{...}} |
| 2 | Extraction des chaînes hardcodées | 1 | {{...}} |
| 3 | Traduction (Mode 3) | 2 | {{...}} |
| 4 | Humanisation source + traduction | 2 | {{...}} |
| 5 | SEO multilingue (hreflang, sitemap, OG) | 2 | {{...}} |
| 6 | Slugs / routes traduits | 2-3 | {{...}} |
| 7 | Formats locaux + RTL | 3 | {{...}} |
| 8 | Tests finaux | — | {{...}} |

---

## Délégations recommandées

### `site-ux-guardian`

{{Si la cohérence ergonomique du site doit être auditée d'abord :}}

> Avant la traduction, je recommande de passer **`site-ux-guardian`** pour vérifier la cohérence des menus, footers, routes existants.

### `seo-content-engine`

{{Si certains contenus sont à réécrire from scratch :}}

> Pour les pages dont le contenu doit être totalement réécrit (pas juste traduit), utiliser **`seo-content-engine`**.

### `premium-webdesigner`

{{Si l'ajout de RTL exige une refonte créative :}}

> L'ajout de l'arabe nécessite une **refonte visuelle** non triviale. Je recommande **`premium-webdesigner`** pour la direction artistique.

### `production-auditor`

{{Si audit production complet requis :}}

> Pour valider le site avant mise en prod multilingue (sécurité, performance, déploiement), utiliser **`production-auditor`**.

---

## Mode d'exécution choisi

- [ ] **Mode 1** — Audit only (rapport seul)
- [ ] **Mode 2** — Plan (validation requise avant action)
- [ ] **Mode 3** — Traduction + humanisation
- [ ] **Mode 4** — SEO multilingue final

→ Mode actuel : **{{mode}}**.

---

## Fichiers modifiés (si Mode 3 ou 4)

| Fichier | Modification | Diff |
|---|---|---|
| `{{path}}` | {{description}} | {{ex: +120 -3}} |

---

## Tests à effectuer

- [ ] navigation dans chaque langue OK ;
- [ ] formulaires soumis dans chaque langue ;
- [ ] emails reçus dans chaque langue ;
- [ ] switch langue depuis chaque page testé ;
- [ ] mobile fonctionnel ;
- [ ] performances équivalentes par langue ;
- [ ] 404 / 500 custom par langue ;
- [ ] hreflang vérifiés via Search Console (post-deploy).

---

## Limites de cet audit

- audit **statique** (pas de runtime testing) ;
- relecture **par natif** non effectuée (recommandée) ;
- **performance** non mesurée (cf. `production-auditor`) ;
- **sécurité** non auditée (cf. `production-auditor`).

---

## Prochaine étape

> {{Une seule phrase actionnable. Ex: "Corriger les 5 critiques, traduire les emails transactionnels, relancer un audit pour viser ≥ 76 sur les deux scores."}}

---

Created by João de Almeida
