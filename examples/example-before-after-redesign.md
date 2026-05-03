# Exemple — Refonte avant / après (challenge mode)

## Contexte

Site existant qui n'a pas vieilli — ou plutôt qui a vieilli **mal**.
Possible :
- ancien thème WordPress importé tel quel ;
- POC SaaS avec hero gigantesque et 3 cards génériques ;
- mini CMS dont le design n'a jamais été retouché depuis le scaffolding ;
- portfolio bricolé en 2018 et jamais refait.

Le but : **mesurer l'écart** entre l'avant et l'après. Les viewers de la vidéo doivent voir le delta.

## Prompt utilisateur

> *"Mode 'challenge avant/après' :
> 1. Audit du design actuel (problèmes + page concernée + gravité).
> 2. Direction artistique radicalement différente mais cohérente avec le produit.
> 3. Brief + moodboard + composants + images + design system.
> 4. Implémente.
> 5. Rapport AVANT (problèmes) → APRÈS (solutions) côte à côte.
> 6. Score ui-quality-checklist avant et après pour mesurer le delta.
> Stack : à détecter en lisant le projet. Mode 'screen-recording-friendly'. Pas de push GitHub. Commits locaux séparés."*

## Recherche d'inspiration attendue

### Phase d'audit (avant)

1. **Capture mentale** des pages clés :
   - homepage : section par section ;
   - footer : structure ;
   - admin si applicable ;
   - 1–2 pages internes.
2. **Lister** les problèmes par catégorie (cf. `references/anti-basic-design-rules.md` §1) :
   - homepage générique ;
   - gradients random ;
   - typographie incohérente ;
   - espacements arbitraires ;
   - footer pauvre ;
   - clichés image ;
   - manque d'identité.

### Phase de redesign (après)

Standard méthode 6-phases du skill.

## Composants à chercher

Selon stack et type de projet identifiés. Cf. `references/component-selection-guide.md`.

## Direction artistique radicalement différente

L'objectif est de **changer la perception**, pas juste de "rafraîchir". Exemples :

| Avant (généralement) | Après (proposition) |
|---|---|
| dégradé violet partout | palette monochromatique + 1 accent vif |
| polices au hasard (4–6) | 1 display + 1 body (max 2 familles) |
| sections répétitives identiques | bento grid + sections différenciées |
| stock photos corporate | photos spécifiques métier ou illustrations sobres |
| footer pauvre | footer 4 colonnes + maillage interne |
| pas de hiérarchie | un H1, un CTA primaire, points focaux |

## Images

- **avant** : capturer ou décrire l'état actuel (sans la conserver dans le repo final si elle sort du projet) ;
- **après** : sourcer images cohérentes avec la nouvelle direction.

## Format de rapport "avant / après"

Section spéciale dans `redesign-report.template.md` :

```markdown
## Comparaison avant / après

### Homepage hero

| | Avant | Après |
|---|---|---|
| Image | photo équipe en costume | photo workstation clean (Unsplash) |
| Titre | "Welcome to our website" | "Concentre-toi sur ce qui compte vraiment" |
| Sous-titre | absent | "Sessions focus de 25 min, sans distraction." |
| CTA principal | "Cliquez ici" | "Commencer gratuitement" |
| Visuel | dégradé violet | photo + overlay subtil |

### Score ui-quality-checklist

| Axe | Avant | Après | Δ |
|---|---|---|---|
| Visuel | 32 / 100 | 86 / 100 | +54 |
| UX | 45 / 100 | 88 / 100 | +43 |
| Responsive | 40 / 100 | 92 / 100 | +52 |
| Accessibilité | 38 / 100 | 84 / 100 | +46 |
| Cohérence | 25 / 100 | 90 / 100 | +65 |
| Premium feel | 20 / 100 | 85 / 100 | +65 |
| **Global** | **35 / 100** | **88 / 100** | **+53** |
```

## Direction "radicalement différente" — règles

- **changer la perception**, pas juste les couleurs ;
- **identité claire** après refonte (test du logo enlevé) ;
- **mais cohérent** avec le produit (un cabinet d'avocats refondu ne doit pas devenir une rave) ;
- **réversible** (un `git revert` sur la branche de refonte doit ramener l'avant).

## Résultat attendu

- audit du design actuel dans `reports/audit-redesign-AVANT-YYYY-MM-DD.md` ;
- 5 fichiers de design dans `docs/` ;
- implémentation (commits séparés par section) ;
- `reports/redesign-AVANT-APRES-YYYY-MM-DD.md` avec :
  - tableau comparatif avant/après par section ;
  - tableau des scores avant/après ;
  - liste des fichiers modifiés ;
  - delta global mesurable.

## Erreurs à éviter

- **refonte aveugle** sans audit préalable (pas de baseline = pas de delta mesurable) ;
- **changement de stack** non demandé (refonte du look ne veut pas dire rewrite Next.js) ;
- **suppression de fonctionnalités** existantes ;
- **rupture du flow critique** (auth, paiement, formulaire) ;
- **animations gadget** "pour la vidéo" qui rendent mal en prod ;
- **dramatiser** le "avant" (l'audit doit être lucide, pas méprisant — les viewers reconnaîtront leur propre projet et il ne faut pas les décourager).

## Pour la vidéo YouTube

Cette refonte est filmable. Format :

1. **0:00** — état initial (capture d'écran ou navigation live) ;
2. **2:00** — audit lucide en parlant des problèmes courants ;
3. **5:00** — direction proposée (palette, typo, composants choisis) ;
4. **10:00** — implémentation accélérée (montage time-lapse) ;
5. **20:00** — résultat final (capture côte à côte avec l'avant) ;
6. **22:00** — score avant/après chiffré.

## Checklist finale

- [ ] audit AVANT documenté (problèmes + scores)
- [ ] direction artistique radicalement différente proposée
- [ ] brief design rempli
- [ ] moodboard + composants + images + design system documentés
- [ ] implémentation par section (commits séparés)
- [ ] aucune fonctionnalité cassée
- [ ] aucun flow critique cassé
- [ ] responsive 4 breakpoints OK
- [ ] accessibilité AA OK
- [ ] rapport AVANT/APRES côte à côte
- [ ] scores chiffrés avant/après
- [ ] mention `Created by João de Almeida — Art of Dev`
- [ ] pas de push GitHub sans validation

---

Created by João de Almeida — Art of Dev — https://artofdev.space
