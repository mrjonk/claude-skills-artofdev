# Release notes — v1.0.0-rc1

> Date : 2026-05-03
> Statut : **Release Candidate** — pas encore stable
> Created by João de Almeida

---

## Pourquoi `rc1` et pas `v1.0.0` final

Cette release est volontairement publiée comme **release candidate** plutôt que v1.0 stable. La raison est documentée dans [`reports/v1.0-readiness-audit.md`](../reports/v1.0-readiness-audit.md) :

- les 7 skills existent et passent la validation **statique** ;
- l'optimisation token (Phase 5) a réduit `site-ux-guardian/SKILL.md` de 849 → 258 lignes et `seo-content-engine/SKILL.md` de 570 → 306 lignes ;
- la chasse aux doublons (Phase 6) a factorisé les règles communes dans `docs/shared-safety-rules.md` ;
- les 15 cas de routage `skill-orchestrator` sont documentés ;
- mais le **runtime live** des 7 skills n'a pas pu être observé dans cette session — un humain doit invoquer chaque skill dans une vraie session Claude pour confirmer le comportement attendu.

Tant que cette validation runtime n'a pas été faite, prétendre v1.0 stable serait malhonnête.

---

## Résumé de la release

7 skills publiés, **architecturalement stables**, **optimisés tokens** :

| Skill | SKILL.md (lignes) | Statut |
|---|---:|---|
| `repo-builder` | 403 | publié, validé statiquement, runtime partiel (auto-application) |
| `production-auditor` | 349 | publié, validé statiquement, runtime partiel |
| `premium-webdesigner` | 445 | publié, validé statiquement, runtime partiel |
| `seo-content-engine` | 306 | publié, optimisé token, validé statiquement |
| `site-ux-guardian` | 258 | publié, optimisé token (-591 lignes), validé statiquement |
| `multilingual-site-engine` | 416 | spec + 3 fixtures testables, runtime non observé |
| `skill-orchestrator` | 128 | spec + 15 cas de routage attendus, runtime non observé |

Total : **2 305 lignes** de SKILL.md cumulées (vs 3 160 avant la passe v1.0-rc1, soit **-855 lignes** ≈ **-27 %**).

---

## Highlights v1.0-rc1

### Architecture token-conscious

- `USE WHEN` / `SKIP WHEN` ajoutés à tous les SKILL.md.
- Détails métier déplacés vers `references/` ; SKILL.md compactés.
- `docs/shared-safety-rules.md` créé pour factoriser les règles non-négociables communes.
- `docs/skill-routing-map.md` permet à l'orchestrateur de router sans charger tout le contenu.

### Validations documentées

- [`reports/v1.0-readiness-audit.md`](../reports/v1.0-readiness-audit.md) — état des lieux complet.
- [`reports/validation-multilingual-site-engine.md`](../reports/validation-multilingual-site-engine.md) — validation statique + 3 fixtures (PHP / Next.js / WordPress).
- [`reports/validation-skill-orchestrator.md`](../reports/validation-skill-orchestrator.md) — couverture des 15 cas de routage.
- [`reports/v1.0-regression-validation.md`](../reports/v1.0-regression-validation.md) — anti-régression statique des 5 skills antérieurs.
- [`reports/token-optimization-v1.0.md`](../reports/token-optimization-v1.0.md) — avant/après détaillé.
- [`reports/duplicate-rules-audit-v1.0.md`](../reports/duplicate-rules-audit-v1.0.md) — chasse aux doublons.

### Article éditorial

- [`docs/article-v1.0-collection-claude-skills-artofdev.md`](article-v1.0-collection-claude-skills-artofdev.md) — section éditoriale prête à intégrer dans un article public.

### Examples & assets

- [`examples/README.md`](../examples/README.md) — index complet des exemples.
- [`examples/skill-orchestrator-routing-test-cases.md`](../examples/skill-orchestrator-routing-test-cases.md) — 15 cas réalistes.
- [`examples/validation-fixtures/`](../examples/validation-fixtures/) — 3 fixtures testables.
- [`assets/README.md`](../assets/README.md) — brief créatif pour la bannière OG et les captures à produire.

---

## Breaking changes

Aucun. Les 5 skills antérieurs gardent leurs frontmatters, leurs périmètres, leurs scripts. Les seuls changements sont :

- ajout de la section `USE WHEN / SKIP WHEN` en tête de chaque SKILL.md (n'altère pas le comportement) ;
- déplacement de longues sections de SKILL.md vers `references/` (le contenu reste accessible, juste à un autre chemin).

L'installation par `bash install.sh` ou `bash install.sh <skill-name>` reste identique.

---

## Limites connues (release candidate)

| Limite | Détail | Plan |
|---|---|---|
| Runtime non observé | les 7 skills n'ont pas été invoqués dans une session live pendant la passe rc1 | tests humains à effectuer avant v1.0.0 final |
| Bannière OG absente | brief créatif présent, image non produite | à livrer avant v1.0.0 final |
| Captures avant/après absentes | brief présent, captures non produites | à livrer après runtime testing |
| Documentation EN | repo en français | mentionné en idée future, pas engagé |
| Fixtures Next.js / WordPress minimales | suffisent pour valider la spec, pas pour stress-tester l'i18n complet | enrichissement possible si retours utilisateur |

---

## Pour passer en `v1.0.0` final

Critères :

- [ ] Runtime live des 7 skills sur 2-3 projets réels (par stack pour les multilingues).
- [ ] Confirmation que les 15 cas de routage `skill-orchestrator` se comportent comme attendu.
- [ ] Bannière OG + 4 captures avant/après livrées.
- [ ] Article éditorial relu et publié.
- [ ] Aucune régression observée sur les 5 skills antérieurs.
- [ ] CHANGELOG : `[Unreleased]` → `[1.0.0] — YYYY-MM-DD` figé.

---

## Commandes proposées (NE PAS exécuter sans validation explicite)

```bash
# 1. Vérifier l'état du repo
git status
git diff --stat

# 2. Stager + commiter
git add docs/ reports/ examples/ assets/ skills/ README.md CHANGELOG.md
git commit -m "Prepare v1.0.0-rc1 release candidate"

# 3. Tag annoté
git tag -a v1.0.0-rc1 -m "v1.0.0-rc1 — release candidate, runtime validation pending"

# 4. Push
git push origin main
git push origin v1.0.0-rc1

# 5. Release GitHub (release candidate, NE PAS marquer comme latest)
gh release create v1.0.0-rc1 \
  --title "v1.0.0-rc1 — Release candidate (runtime validation pending)" \
  --notes-file docs/release-notes-v1.0.0-rc1.md \
  --prerelease
```

**Important** : la flag `--prerelease` est cruciale. Elle empêche GitHub de marquer cette release comme "Latest", ce qui irait à l'encontre du choix RC1 honnête.

---

## Pour passer plus tard en `v1.0.0` final

Quand les critères ci-dessus seront cochés :

```bash
# 1. Mettre à jour CHANGELOG : [Unreleased] → [1.0.0] — YYYY-MM-DD
# 2. Commiter le changelog
git commit -am "Cut v1.0.0 stable"

# 3. Tag final
git tag -a v1.0.0 -m "v1.0.0 — stable seven-skill collection"

# 4. Push
git push origin main
git push origin v1.0.0

# 5. Release GitHub (sans --prerelease cette fois)
gh release create v1.0.0 \
  --title "v1.0.0 — Stable seven-skill collection" \
  --notes-file docs/release-notes-v1.0.0.md
```

---

Created by João de Almeida
