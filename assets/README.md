# Assets — visuels et briefs créatifs

> Brief pour les visuels accompagnant la collection Claude Skills Art of Dev.
> Created by João de Almeida

---

## Statut

Aucun visuel livré pour l'instant. Ce fichier sert de **brief créatif** à utiliser quand les images seront produites.

**Conséquence pratique** : tant que les vrais fichiers ne sont pas dans `assets/`, le `README.md` racine ne référence aucune image — pas de lien cassé.

---

## Bannière OG / hero du repo

**Fichier cible** : `assets/og-banner.png`
**Format** : 1200 × 630 px (ratio Open Graph standard).
**Variantes recommandées** :
- `og-banner.png` — bannière pour partage réseaux sociaux ;
- `og-banner-wide.png` (2000 × 800) — éventuelle bannière hero du README.

**Brief créatif** :
- Style : minimaliste, sobre, technique. PAS de gradient violet, PAS de stock photo, PAS de blob coloré.
- Palette : noir/blanc + un accent (cyan ou ocre — à choisir).
- Typographie : sans-serif géométrique (Inter, Manrope, Geist Sans).
- Élément central : grille modulaire de 7 cellules représentant les 7 skills (chaque cellule = un nom de skill court + une icône monochromatique propre, pas Lucide générique).
- Mention discrète : *"Claude Skills · Art of Dev"* en bas-droite ou bas-centre.
- Pas d'emoji. Pas de "🚀". Pas de "AI-powered".

**Anti-design (pour éviter la tentation)** :
- pas de cerveau stylisé,
- pas de robot,
- pas de "neural network" filaire,
- pas de hands-shake humain/robot,
- pas de fond étoilé.

---

## Captures d'écran à prévoir

Quand les skills seront utilisés en production sur des projets réels, prévoir 4 séries de captures :

### `assets/captures/audit-before-after/`
2 captures par audit (avant / après) sur 2-3 projets différents. Score visible. Légende sobre.

### `assets/captures/orchestrator-routing/`
Capture d'une session Claude où l'orchestrateur retourne sa réponse-type :
```
**Skill recommandé :** ...
**Raison :** ...
**Confirmation requise ?** ...
```
Format : screenshot terminal lisible (zoom suffisant), thème sombre standard.

### `assets/captures/multilingual-translation/`
Avant / après traduction d'une page (homepage ou page produit) avec hreflang et menus traduits. Idéalement sur les 3 fixtures (PHP / Next.js / WordPress).

### `assets/captures/token-optimization/`
Comparaison `wc -l` avant / après l'optimisation Phase 5 : capture d'un terminal montrant les tailles des `SKILL.md` avant la passe et après. Témoignage du gain token-conscious.

---

## Logo

Pas obligatoire. Si produit :
- `assets/logo.svg` — vectoriel, monochrome, lisible à 16 px.
- pas de typographie cursive,
- pas de "C" stylisé en spirale,
- géométrie simple : un carré, une grille, un point. Volontairement austère.

---

## Conventions générales

| Règle | Détail |
|---|---|
| Format | PNG pour les screenshots, SVG pour les logos/icônes, PNG/JPG pour OG. Pas de WebP par défaut (compatibilité GitHub). |
| Poids max | < 500 KB par image, < 200 KB pour OG. |
| Nommage | `kebab-case.png`, descriptif (`audit-saas-before-after.png`, pas `image1.png`). |
| Crédit | si stock photo utilisée, créditer dans `assets/image-credits.md`. |
| Aucune capture sensible | pas de chemin serveur, pas d'IP locale, pas de tokens visibles, pas de noms d'utilisateur Linux. |

---

## À faire avant `v1.0.0` final

- [ ] Produire `og-banner.png` (1200 × 630).
- [ ] Capturer 2 audits réels avant/après.
- [ ] Capturer 1 routing orchestrator réel.
- [ ] Capturer 1 traduction multilingue avant/après.
- [ ] Ajouter les captures pertinentes dans le `README.md` racine.
- [ ] Mettre à jour ce `assets/README.md` pour cocher les éléments livrés.

Tant que ces items ne sont pas cochés, la collection reste en `v1.0.0-rc1`.

---

Created by João de Almeida
