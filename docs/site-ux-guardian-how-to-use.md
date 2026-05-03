# Comment utiliser le skill `site-ux-guardian`

Created by João de Almeida

---

## 1. Installation

Une seule fois, depuis la racine du repo :

```bash
bash install.sh site-ux-guardian
```

Le skill est copié dans `~/.claude/skills/site-ux-guardian/`. Claude Code le détecte à la session suivante.

Pour vérifier :

```bash
ls ~/.claude/skills/site-ux-guardian/SKILL.md
bash uninstall.sh --list
```

> Si une version précédente était installée, elle est sauvegardée dans `~/.claude/skills/.backup/site-ux-guardian-YYYYMMDD-HHMMSS/`.

---

## 2. Activation automatique

Le skill s'active automatiquement quand ta demande matche sa `description:`.

Aucune syntaxe spéciale nécessaire. Si tu écris *"vérifie l'ergonomie de ce site"*, le skill se déclenche.

---

## 3. Comment l'appeler

### Audit complet (Mode 1 — lecture seule, recommandé par défaut)

```txt
Audite l'ergonomie globale du site. Vérifie menus, footers, routes, doublons,
cohérence front/admin, responsive, sécurité basique et qualité visuelle.
Ne modifie rien pour l'instant.
```

→ Le skill produit `reports/site-ux-report-YYYY-MM-DD.md` avec les scores et le plan.

### Audit ciblé sur menu / footer

```txt
Vérifie que le menu et le footer sont cohérents sur toutes les pages, y compris
mobile et admin. Signale les doublons et les fichiers à corriger.
```

### Audit visuel / webdesign

```txt
Audite l'ergonomie et la qualité visuelle globale du site. Vérifie hiérarchie
visuelle, typographie, spacing, layout, boutons, cards, formulaires, images,
responsive et cohérence design system.
```

### Audit + corrections sûres (Mode 2)

```txt
Fais un audit UX de cohérence, puis corrige uniquement les problèmes simples
et sûrs (typos, alt vides, balises manquantes, classes harmonisées). Ne refonds
pas le site sans validation.
```

### Vérification de discipline fichier

```txt
Vérifie que les changements ont été faits dans les bons composants partagés
et pas copiés page par page.
```

### Plan de refonte ergonomique (Mode 3)

```txt
Produis un plan de refonte ergonomique détaillé. Pas de modification immédiate,
juste le plan avec phases, fichiers concernés, et risques. Je validerai ensuite
phase par phase.
```

---

## 4. Comment demander un audit ergonomique + visuel

```txt
Audit ergonomie + visuel.

1. Cartographie : pages, menus, footers, routes, multilingue.
2. Vérification cohérence : front/admin, responsive, doublons.
3. Vérification webdesign guidelines (14 axes).
4. Vérification sécurité basique (admin protégé, .env exposé, routes debug).
5. Score cohérence + score visuel sur 100 chacun.
6. Rapport actionnable avec corrections par sévérité.
7. Recommandations de délégation à premium-webdesigner / production-auditor
   si applicable.

Mode : audit-only. Pas de modification.
```

---

## 5. Quand utiliser `site-ux-guardian` vs autres skills

### Utiliser `site-ux-guardian` quand…

- tu veux **vérifier la cohérence** d'un site existant ;
- tu modifies une page et **veux t'assurer** que le menu/footer/admin sont synchros ;
- tu suspectes des **doublons** (`HeaderV2`, fichiers `.bak`) ;
- tu veux **savoir le bon fichier** à modifier avant de toucher quelque chose ;
- tu veux un **audit responsive** rapide ;
- tu veux des **scores** cohérence + visuel sur 100.

### Utiliser `premium-webdesigner` quand…

- tu veux une **refonte créative** complète ;
- tu cherches des **inspirations** (21st.dev, shadcn, Lucide) ;
- tu veux une **direction artistique** premium ;
- tu pars de zéro sur un design.

→ `site-ux-guardian` peut **recommander** `premium-webdesigner` si le site est cohérent mais visuellement faible.

### Utiliser `production-auditor` quand…

- tu veux un **audit complet** avant mise en prod ;
- tu veux un **audit sécurité profond** (CSRF, XSS, SQLi, auth, billing, déploiement) ;
- tu veux un **score sur 7 axes** pondérés ;
- tu prépares un **lancement** ou une **release**.

→ `site-ux-guardian` est **complémentaire** : il s'occupe de l'ergonomie / cohérence, `production-auditor` de la production-readiness.

### Utiliser `seo-content-engine` quand…

- tu veux **améliorer le contenu** rédactionnel ;
- tu veux **auditer** des articles existants ;
- tu veux **rédiger** un nouveau contenu SEO.

---

## 6. Workflow conseillé (multi-skills)

Pour un site qu'on prépare au lancement :

```
1. site-ux-guardian
   → Audit ergonomique global. Identifier les problèmes de cohérence,
     menus, footers, routes, doublons.

2. premium-webdesigner (si refonte créative nécessaire)
   → Si score visuel < 60, déléguer la refonte ici.

3. seo-content-engine (si contenu à améliorer)
   → Auditer / rédiger le contenu.

4. site-ux-guardian (re-audit)
   → Vérifier que les modifications n'ont pas cassé la cohérence.

5. production-auditor (validation finale)
   → Audit complet (sécurité profonde, billing, déploiement, perf).
```

Cet enchaînement peut être orchestré (futur skill `skill-orchestrator`).

---

## 7. Comment l'utiliser avant `production-auditor`

`site-ux-guardian` est **complémentaire** de `production-auditor`. Workflow :

1. **`site-ux-guardian`** d'abord : trouve les problèmes ergonomiques / de cohérence ;
2. corriger les problèmes critiques ;
3. **`production-auditor`** ensuite : valide la production-readiness profonde.

Faire `production-auditor` **avant** `site-ux-guardian` est OK aussi, mais on risque d'avoir un score `production-auditor` faible sur des problèmes UX qui auraient été corrigés en amont par `site-ux-guardian`.

---

## 8. Comment l'utiliser après `premium-webdesigner`

Après une refonte par `premium-webdesigner` :

1. `site-ux-guardian` vérifie que la **cohérence inter-pages** est respectée ;
2. vérifie que le **mobile** fonctionne ;
3. vérifie que les **routes** ne sont pas cassées ;
4. vérifie que les **bons composants** ont été modifiés (pas de duplication créée par la refonte).

→ C'est un **filet de sécurité** post-refonte.

---

## 9. Limites du skill

- **statique** : ne teste pas le runtime, le serveur, la DB.
- **routes dynamiques** : `scan-orphan-pages.sh` ne détecte pas les routes paramétrées des frameworks.
- **pas un audit sécurité complet** : seulement les évidents. Pour profond → `production-auditor`.
- **pas une refonte créative** : pour ça → `premium-webdesigner`.
- **adaptation à la stack** : meilleure performance avec stacks bien identifiables (Next.js, WordPress, Laravel, etc.).

---

## 10. Désinstallation

```bash
bash uninstall.sh site-ux-guardian
```

Sauvegarde le skill dans `~/.claude/skills/.backup/`, puis le retire. **Ne touche pas** aux autres skills installés.

---

Created by João de Almeida
