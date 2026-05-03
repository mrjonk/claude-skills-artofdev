# Exemple — Audit routes et liens

## Contexte

App Vue/Nuxt qui a connu plusieurs refontes successives. ~30 pages, multilingue (FR/EN).
Risque : pages orphelines + liens morts + routes concurrentes.

## Demande originale

> *"Cartographie toutes les routes du site. Identifie les pages orphelines, les liens morts, les routes concurrentes, les redirections. Mode : audit only."*

## Analyse attendue

### Routes déclarées

| Type | Source |
|---|---|
| Pages Vue | `pages/**/*.vue` |
| API | `server/api/**/*.ts` |
| Middlewares | `middleware/auth.ts`, `middleware/i18n.ts` |

### Routes utilisées (liens dans le code)

Extraction via `grep` des `<NuxtLink to="">`, `<router-link to="">`, `href="">`.

## Fichiers à inspecter

- `pages/**/*.vue`
- `components/**/*.vue` (pour les liens)
- `composables/**/*.ts` (pour les redirections programmatiques)
- `nuxt.config.ts` (pour les redirections déclaratives)

## Problèmes typiques détectés

### Pages orphelines

| Page | Route | Détection |
|---|---|---|
| `pages/legacy/old-pricing.vue` | `/legacy/old-pricing` | aucun lien dans le code |
| `pages/internal/draft.vue` | `/internal/draft` | aucun lien (volontaire ? brouillon ?) |
| `pages/test.vue` | `/test` | page de test laissée |

→ **3 pages orphelines** détectées.

### Liens morts

| Lien | Trouvé dans | Route attendue | Statut |
|---|---|---|---|
| `/contat` | `components/Footer.vue:42` | `/contact` (typo) | typo évidente |
| `/old-blog` | `components/HeroSection.vue:28` | n'existe plus depuis la refonte | à retirer ou rediriger |
| `/services/web-design` | `pages/index.vue:120` | `/services/webdesign` (sans tiret) | typo |

### Routes concurrentes

| Route 1 | Route 2 | Recommandation |
|---|---|---|
| `/about` | `/about-us` | les deux existent (FR/EN ?), pas de système multilingue clair → consolider |
| `/contact` | `/nous-contacter` | à structurer (`/fr/contact` + `/en/contact`) |

### Multilingue

- système : préfixe URL (`/fr/...` + `/en/...`) ;
- détection :
  - `/fr/about` ✓
  - `/en/about` ✓
  - `/fr/pricing` ✓
  - `/en/pricing` **manquante** → la version EN n'a pas de pricing.
- switch langue : `<LangSwitch>` présent dans le header, mais redirige toujours vers la home (pas vers la page équivalente).

### Liens vers `#` ou `javascript:void(0)`

- `components/CtaBanner.vue:18` : bouton avec `href="#"` (CTA jamais branché) ;
- `pages/services.vue:88` : ancre `href="#section-3"` mais pas de `id="section-3"` dans la page.

## Corrections sûres (Mode 2)

- [ ] corriger la typo `/contat` → `/contact` dans `Footer.vue` ;
- [ ] corriger `/services/web-design` → `/services/webdesign` dans `index.vue` ;
- [ ] retirer le lien `/old-blog` de `HeroSection.vue` (page n'existe plus) ;
- [ ] ajouter l'id `section-3` manquant dans `services.vue`.

## Corrections nécessitant validation

- [ ] décision sur les **3 pages orphelines** : supprimer (risque), rediriger, ou laisser ;
- [ ] consolidation des **routes concurrentes** (`/about` + `/about-us`) ;
- [ ] créer la page `/en/pricing` (ou rediriger vers `/fr/pricing` ?) ;
- [ ] **fixer** le switch langue pour qu'il mène à la page équivalente ;
- [ ] décision sur le bouton `href="#"` dans `CtaBanner.vue` (qu'est-ce qu'il devait faire ?).

## Score cohérence attendu

- **Navigation** : 12 / 15 (switch langue cassé, libellés OK) ;
- **Routes** : 8 / 15 (plusieurs liens morts, routes concurrentes) ;
- **Pages orphelines** : 7 / 10 (3 orphelines à traiter) ;
- **Multilingue** : 6 / 10 (pages EN incomplètes) ;
- **Total cohérence** : ~65 / 100 → publiable avec corrections.

## Rapport final attendu

```markdown
# Final coherence report — App Nuxt multilingue

Score cohérence : 65 / 100
Score visuel : 75 / 100
Verdict : Publiable avec corrections

Top 3 actions :
1. Décider du sort des 3 pages orphelines (`/legacy/old-pricing`, `/internal/draft`, `/test`).
2. Corriger les 3 liens morts détectés (typos + lien vers page supprimée).
3. Compléter la version EN du site (pricing manquant) + fixer le switch langue.

Carte du site :
- 30 pages détectées
- 3 orphelines
- 3 liens morts corrigeables (typos)
- 2 routes concurrentes à consolider
- 4 ancres internes à vérifier
- multilingue partiellement cassé (switch + 1 page manquante en EN)

Délégations :
- aucune (problèmes ergonomiques uniquement, pas de refonte créative ni audit prod requis pour l'instant).
```

---

Created by João de Almeida
