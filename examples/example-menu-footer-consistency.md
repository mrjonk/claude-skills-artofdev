# Exemple — Cohérence menu / footer

## Contexte

Site vitrine d'une PME en B2B. 12 pages publiques (home, services, équipe, cas clients, contact, blog, mentions, RGPD, CGV, etc.).
Stack : HTML/CSS classique avec includes PHP.

## Demande originale

> *"Vérifie que le menu et le footer sont cohérents sur toutes les pages, y compris mobile et admin. Signale les doublons et les fichiers à corriger. Mode : audit only."*

## Analyse attendue

### Phase 1 — Stack identifiée

- HTML + PHP avec `include 'partials/header.php'` ;
- pas de framework moderne ;
- CSS dans `style.css` global.

### Phase 2 — Cartographie

12 pages publiques détectées. Aucune admin (site purement vitrine).

### Phase 3 — Menus

| Menu | Source | Pages couvertes |
|---|---|---|
| Header desktop | `partials/header.php` | toutes |
| Header mobile | `partials/header-mobile.php` | toutes |

→ Bonne pratique : composants partagés.

### Phase 4 — Footers

| Footer | Source | Pages couvertes |
|---|---|---|
| Footer principal | `partials/footer.php` | toutes |

→ Une seule version, partagée.

## Fichiers à inspecter

- `partials/header.php`
- `partials/header-mobile.php`
- `partials/footer.php`
- `style.css`
- toutes les pages dans `pages/*.php`

## Problèmes typiques détectés

### Cohérence menu desktop vs mobile

- desktop : 5 liens (Accueil / Services / Équipe / Cas / Contact) ;
- mobile : 4 liens (manque "Cas") ;
- → **incohérence** détectée.

### Liens du footer

- footer contient 6 liens : 5 du menu + Contact + Mentions + RGPD + CGV ;
- liens sociaux : Twitter, LinkedIn (fonctionnels) ;
- copyright : `© 2022 PME Corp` → **statique** (à rendre dynamique).

### Active state

- détecté via `<?php if ($currentPage == 'services') echo 'active'; ?>` ;
- présent dans header.php ;
- **absent** dans header-mobile.php → bug UX.

### Pages légales

- **mentions légales** : présentes ✓ ;
- **RGPD** : présente ✓ ;
- **CGV** : page existe mais lien dans le footer pointe vers `/cgv.php` (404) — le fichier est `/conditions.php` ;
- **politique cookies** : pas mentionnée mais le site a Google Analytics → manque potentiel.

## Corrections sûres (Mode 2)

- [ ] ajouter le lien "Cas" dans `partials/header-mobile.php` ;
- [ ] corriger le lien CGV dans `partials/footer.php` (`/cgv.php` → `/conditions.php`) ;
- [ ] passer le copyright en dynamique : `© <?= date('Y') ?> PME Corp`.

## Corrections nécessitant validation

- [ ] ajouter une page **politique cookies** + bandeau cookies + lien dans le footer.
- [ ] copier la logique active state dans `header-mobile.php`.
- [ ] vérifier la cohérence libellés ("Cas clients" vs "Cas" dans le mobile).

## Score cohérence attendu

- **Navigation** : 12 / 15 (mobile ≠ desktop) ;
- **Footer** : 8 / 10 (lien CGV cassé + copyright statique) ;
- **Routes** : 14 / 15 ;
- **Doublons** : 10 / 10 (composants partagés) ;
- **Sécurité basique** : 9 / 10 ;
- **Total cohérence** : ~73 / 100 → publiable avec corrections.

## Score visuel attendu

- **76–82 / 100** (site cohérent, design correct, pas amateur mais sans direction artistique forte).

## Rapport final attendu

```markdown
# Final coherence report — Site PME B2B

Score cohérence : 73 / 100
Score visuel : 78 / 100
Verdict : Correct avec corrections nécessaires

Top 3 actions :
1. Synchroniser header-mobile.php avec header.php (lien "Cas" manquant).
2. Corriger le lien CGV cassé dans footer.php.
3. Passer le copyright en année dynamique.

Délégations :
- premium-webdesigner : optionnel pour passer en premium (score 78).
- production-auditor : recommandé avant publication (audit sécurité profond).
```

---

Created by João de Almeida
