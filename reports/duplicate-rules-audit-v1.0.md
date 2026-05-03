# Duplicate rules audit — v1.0.0-rc1

> Date : 2026-05-03
> Phase 6 — préparation v1.0.0-rc1
>
> Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. Méthodologie

### Greps exécutés depuis `/var/www/artofdev-projects/claude-skills-artofdev/`

```bash
grep -RInE "(\.env|secret|token|password|credential|API key|clé|mot de passe)" skills/ docs/ README.md
grep -RInE "(push|commit|tag|release|GitHub|destructive|supprimer|forcer)" skills/
grep -RInE "(CSRF|XSS|SQLi|rate limit|admin protégé|middleware|auth)" skills/
grep -RInE "(menu|footer|navigation|hreflang|canonical|slug)" skills/
grep -RInE "(template|generic|bullshit|IA|tiret|—)" skills/
grep -RInE "confirmation|valid(er|ation)|accord explicite" skills/
```

| Grep | Lignes brutes | Lignes pertinentes (filtrage `Ne jamais`/`sans accord`/`interdit`) |
|---|---|---|
| Secrets / `.env` / tokens | 581 | ≈ 35 règles dupliquées (le reste = code, `.gitignore`, scripts) |
| Push / commit / supprimer | 367 | 31 règles dupliquées |
| Sécurité applicative (CSRF/XSS/SQLi) | 106 | 0 règle dupliquée — concentré dans `production-auditor` |
| Menu / footer / hreflang / slug | 804 | 0 règle dupliquée transversale (chaque skill a son angle) |
| Tone / bullshit / IA / tiret | 1 429 | 0 règle factorisable (chaque skill a son anti-pattern métier) |
| Confirmation / validation / accord explicite | 167 | ≈ 15 règles dupliquées |

### Critères de factorisation

- Une règle qui apparaît dans **3+ skills** avec une formulation très proche → **factoriser**
  dans `docs/shared-safety-rules.md`.
- Une règle **spécifique** à un skill (même formulée comme une règle de sécurité) →
  **garder** dans le skill.
- Périmètres **différents qui se chevauchent** (ex: audit profond vs signalement basique) →
  **garder distincts** + documenter la différence dans `shared-safety-rules.md` §
  "Règles spécifiques par domaine".

### Périmètre d'édition

- **Modifié** : `repo-builder/SKILL.md`, `production-auditor/SKILL.md`,
  `premium-webdesigner/SKILL.md`, `multilingual-site-engine/SKILL.md`,
  `skill-orchestrator/SKILL.md`.
- **Non modifié** (autre agent en parallèle sur l'optimisation token) :
  `site-ux-guardian/SKILL.md`, `seo-content-engine/SKILL.md`.
- **Créé** : `docs/shared-safety-rules.md`.

---

## 2. Doublons trouvés

### Famille 1 — Règles de sécurité (`.env`, secrets, tokens)

**Présent dans :**

| Fichier | Forme |
|---|---|
| `repo-builder/SKILL.md` §2, §6 | "Ne jamais commiter `.env`, tokens, clés API…" |
| `repo-builder/references/security-checklist.md` | liste détaillée |
| `repo-builder/README.md` | "aucun secret n'est commité" |
| `production-auditor/SKILL.md` §4.1 | "Ne jamais committer un secret, token…" |
| `production-auditor/references/security-checklist.md` §1 | checklist détaillée |
| `premium-webdesigner/SKILL.md` §5.2, §10 | "Ne jamais modifier `.env`, `wp-config.php`" |
| `premium-webdesigner/README.md` | implicite via délégation |
| `site-ux-guardian/SKILL.md` §22, §23 | "modification de `.env`, `wp-config.php`" |
| `site-ux-guardian/references/security-sanity-checklist.md` §6, §8 | signalement |
| `seo-content-engine/SKILL.md` §16 | "modification de `.env`, fichiers de credentials" |
| `multilingual-site-engine/SKILL.md` (ajout via shared) | implicite |
| `skill-orchestrator/SKILL.md` §6 | "JAMAIS faire un git push, git reset --hard, rm -rf" |
| `docs/security-rules.md` §1 | référence repo-builder existante |

**Action :** factorisation **§2** de `docs/shared-safety-rules.md` ("Pas de modification
de fichiers de secrets"). Le détail repo-builder reste dans
`docs/security-rules.md` (`.gitignore` minimum, audit avant commit), le détail audit profond
reste dans `production-auditor/references/security-checklist.md`, le détail signalement
reste dans `site-ux-guardian/references/security-sanity-checklist.md`.

**Verbatim répliqué dans 6+ skills → factorisé.**

---

### Famille 2 — Règles destructives (push, rm -rf, reset --hard)

**Présent dans :**

| Fichier | Forme |
|---|---|
| `repo-builder/SKILL.md` §2.1, §7, §10 | "Ne jamais pousser sans accord", "Jamais `git push --force`" |
| `repo-builder/references/github-workflow.md` | "jamais de `force push` sur `main`" |
| `production-auditor/SKILL.md` §4.1, §12 | "Ne jamais faire de `rm -rf`, `git reset --hard`…" |
| `premium-webdesigner/SKILL.md` §5.2, §10 | "Ne jamais supprimer de fichiers existants sans accord écrit" |
| `premium-webdesigner/README.md` §UNDO | "pousser vers GitHub sans accord", "supprimer un fichier sans accord" |
| `site-ux-guardian/SKILL.md` §22, §23 | "git push --force", "git reset --hard" |
| `site-ux-guardian/README.md` | "pousser vers GitHub sans accord" |
| `seo-content-engine/SKILL.md` §16 | "rm -rf", "git push --force" |
| `seo-content-engine/README.md` | "pousser vers GitHub sans accord" |
| `skill-orchestrator/SKILL.md` §6 | "JAMAIS faire un git push, git reset --hard, rm -rf" |

**Action :** factorisation **§1** ("Pas de push GitHub sans accord explicite") et **§3**
("Pas d'action destructive sans demande explicite") de `shared-safety-rules.md`.

Conservé localement dans `repo-builder/SKILL.md` §7 : la **convention de scaffolding**
spécifique (branche `main`, message `init:`, `git add` explicite, choix public/privé,
gh repo create sans `--push`).

**Verbatim répliqué dans 6+ skills → factorisé.**

---

### Famille 3 — Confirmation / validation avant grande échelle

**Présent dans :**

| Fichier | Forme |
|---|---|
| `repo-builder/SKILL.md` §2.1, §3.7 | "demander à l'utilisateur" avant push, public/privé |
| `production-auditor/SKILL.md` §4.2, §7 | "réversibles", "validé par écrit", "ne pas mélanger audit et refonte" |
| `premium-webdesigner/SKILL.md` §9 | "Demander confirmation avant : modification d'un fichier de production…" |
| `site-ux-guardian/SKILL.md` §22 | "Demander confirmation avant : layout / header / footer global" |
| `seo-content-engine/SKILL.md` §15 | "Modification (demander confirmation) : modification d'un fichier de contenu publié" |
| `multilingual-site-engine/SKILL.md` §14 mode 3 | "demander confirmation avant de remplacer un fichier source" |
| `skill-orchestrator/SKILL.md` §6 | "JAMAIS lancer un audit complet automatique sans validation" |

**Action :** factorisation **§4** ("Confirmation avant les opérations à grande échelle")
de `shared-safety-rules.md`.

Conservé localement : la **liste précise** des opérations spécifiques (header global pour
`site-ux-guardian`, refonte design system pour `premium-webdesigner`, fichier de contenu
publié pour `seo-content-engine`, etc.).

**Verbatim partiellement répliqué dans 6+ skills → factorisé sur le tronc commun.**

---

### Famille 4 — Non-destruction de l'existant (routes, flows, données dynamiques, SEO)

**Présent dans :**

| Fichier | Forme |
|---|---|
| `production-auditor/SKILL.md` §4.2 | "Ne jamais casser une app fonctionnelle" |
| `premium-webdesigner/SKILL.md` §4 Phase F | "Ne pas casser : routes, données dynamiques, formulaires fonctionnels, flows critiques, admin, SEO existants" |
| `site-ux-guardian/SKILL.md` §22 | "ne pas casser les routes existantes" |
| `multilingual-site-engine/SKILL.md` §11-12 | "ne jamais hardcoder du texte qui doit venir du CMS", "ne jamais traduire un lien admin sans avoir traduit l'admin" |

**Action :** factorisation **§6** ("Non-destruction de l'existant") de
`shared-safety-rules.md`.

Conservé localement : les **flows critiques métier** spécifiques (paiement Stripe pour
`premium-webdesigner`, hreflang pour `multilingual-site-engine`, etc.).

**Présent dans 4 skills → factorisé sur le tronc commun.**

---

### Famille 5 — Périmètre projet (`~/.gitconfig`, `~/.ssh`, hors projet)

**Présent dans :**

| Fichier | Forme |
|---|---|
| `repo-builder/SKILL.md` §10 | "modification de `~/.ssh/`, `~/.gitconfig` global" |
| `production-auditor/SKILL.md` §4.3 | "Ne pas modifier `~/.gitconfig`, `~/.ssh/`" |

**Action :** factorisation **§7** ("Périmètre projet") de `shared-safety-rules.md`.

**Présent dans 2 skills, mais règle universelle qui mérite la promotion → factorisé.**

---

### Famille 6 — Mode `VIDEO_PRESENTATION_MODE`

**Présent dans :**

| Fichier | Forme |
|---|---|
| `production-auditor/SKILL.md` §10 | bloc complet "Mode VIDEO_PRESENTATION_MODE" |
| `repo-builder/SKILL.md` §10 (commande interdite) | implicite ("pas affiché à l'utilisateur ni à l'écran en mode vidéo") |
| `docs/security-rules.md` §3 | "Cette règle vaut particulièrement pour le mode vidéo" |

**Action :** factorisation **§8** de `shared-safety-rules.md`.

Conservé localement dans `production-auditor/SKILL.md` §10 : la **liste détaillée** des
checks vidéo spécifiques au mode audit (effet wow d'écran d'accueil, factory file §16).

**Présent dans 3 fichiers → factorisé.**

---

### Famille 7 — Honnêteté (ne pas inventer)

**Présent dans :**

| Fichier | Forme |
|---|---|
| `repo-builder/SKILL.md` §2 | "Ne jamais inventer de fonctionnalité. Si Stripe n'est pas configuré, dis-le." |
| `premium-webdesigner/SKILL.md` §4 Phase B | "Ne pas inventer un composant qui n'existe pas sur la source citée" |
| `seo-content-engine/SKILL.md` §16 | "inventer / fabriquer une source, citation, statistique" |
| `multilingual-site-engine/SKILL.md` (philosophie) | implicite |

**Action :** factorisation **§9** ("Honnêteté") de `shared-safety-rules.md`.

**Présent dans 4 skills → factorisé.**

---

### Famille 8 — UX/UI checklists

**Présent dans :**

| Fichier | Périmètre |
|---|---|
| `premium-webdesigner/references/ux-ui-checklist.md` (182 l.) | vérification qualité phase 10 d'une **refonte créative** (vise design premium) |
| `production-auditor/references/ux-ui-checklist.md` (184 l.) | audit phase 3 d'une **production-readiness** (vise détection de bloquants) |
| `site-ux-guardian/references/webdesign-guidelines.md` (346 l.) | audit **transversal de cohérence** (14 axes : layout, typo, spacing) |

**Décision : ne PAS fusionner.** Les checklists ont 60-70 % de recouvrement nominal
(menu, hiérarchie visuelle, CTA, hover states…) **mais** chaque liste vise un angle
distinct :

- `premium-webdesigner` valide qu'une **refonte est premium** ;
- `production-auditor` détecte ce qui **bloque la prod** ;
- `site-ux-guardian` vérifie la **cohérence inter-pages** sur 14 axes.

Fusionner ces 3 fichiers créerait une référence générique qui perdrait l'angle métier
de chaque skill. **Documenté dans `shared-safety-rules.md` §** "Règles spécifiques par
domaine" → renvoi explicite à chaque référence.

**Doublons gardés volontairement.**

---

### Famille 9 — Anti-style-IA / anti-bullshit

**Présent dans :**

| Fichier | Forme |
|---|---|
| `seo-content-engine/references/anti-bullshit-rules.md` | détection de phrases creuses, marketing IA, FAQ artificielle |
| `multilingual-site-engine/references/anti-ai-style-guide.md` | détection de tirets longs en boucle, *"dans le monde d'aujourd'hui"* |
| `multilingual-site-engine/references/human-writing-guide.md` | guide d'humanisation positif |
| `production-auditor/references/seo-content-checklist.md` | "zéro lorem ipsum, zéro bullshit IA, zéro doublon" |
| `site-ux-guardian/references/webdesign-guidelines.md` | "ne ressemble pas à un thème WordPress par défaut" |

**Décision : ne PAS fusionner.** Les angles diffèrent :

- `seo-content-engine` : qualité **éditoriale** d'un article rédigé from scratch ;
- `multilingual-site-engine` : style IA dans des **chaînes traduites courtes** (UI) ;
- `production-auditor` : repérage en mode **audit superficiel** ;
- `site-ux-guardian` : aspect **template-look** du design.

Une référence unique noierait les anti-patterns métier propres à chaque skill.
**Doublons gardés volontairement.**

---

### Famille 10 — Menu / footer / hreflang / slug / navigation

**Présent dans :**

| Fichier | Angle |
|---|---|
| `multilingual-site-engine/references/menu-footer-localization.md` | traduction des libellés, hreflang |
| `multilingual-site-engine/references/route-and-slug-localization.md` | 5 stratégies de routage multilingue |
| `multilingual-site-engine/references/seo-hreflang-guide.md` | hreflang correct, réciproque, x-default |
| `site-ux-guardian/references/menu-footer-consistency-guide.md` | cohérence inter-pages |
| `site-ux-guardian/references/route-mapping-guide.md` | détection routes orphelines |
| `site-ux-guardian/references/navigation-audit-guide.md` | audit transversal navigation |
| `seo-content-engine/references/internal-linking-guide.md` | maillage interne d'un article |

**Décision : ne PAS fusionner.** Périmètres clairement distincts : i18n vs cohérence
ergonomique vs maillage SEO d'article. **Doublons gardés volontairement** — c'est plutôt
une famille de **chevauchement thématique apparent** que de la duplication réelle.

---

## 3. Doublons NON factorisés et pourquoi

| Famille | Présent dans | Pourquoi non factorisé |
|---|---|---|
| UX/UI checklists | 3 skills | Angles métier distincts (refonte vs audit vs cohérence). Fusionner ferait perdre la spécificité. |
| Anti-style-IA / anti-bullshit | 4 skills | Anti-patterns propres à chaque domaine éditorial. |
| Menu / footer / navigation | 3 skills | Chevauchement thématique mais périmètres distincts (i18n vs cohérence vs maillage SEO). |
| Sécurité applicative profonde | 1 skill (`production-auditor`) | Concentré déjà — pas un doublon mais une **délégation** documentée dans `shared-safety-rules.md`. |
| Sécurité signalement basique | 1 skill (`site-ux-guardian`) | Idem — délégation. |
| Conventions repo / `.gitignore` | 1 skill (`repo-builder`) | Idem — délégation. |

---

## 4. Référence partagée créée

**Fichier :** `docs/shared-safety-rules.md` (319 lignes, 13 728 octets).

**Sections :**

1. Pourquoi cette référence partagée (motivation token-conscious + single source of truth).
2. **§1** Pas de push GitHub sans accord explicite.
3. **§2** Pas de modification de fichiers de secrets.
4. **§3** Pas d'action destructive sans demande explicite.
5. **§4** Confirmation avant les opérations à grande échelle.
6. **§5** Préférer signaler à modifier.
7. **§6** Non-destruction de l'existant.
8. **§7** Périmètre projet.
9. **§8** Mode `VIDEO_PRESENTATION_MODE`.
10. **§9** Honnêteté.
11. **§10** Procédure de fuite de secret.
12. Règles spécifiques par domaine (renvoi vers chaque skill : production-auditor pour
    sécurité profonde, site-ux-guardian pour signalement, repo-builder pour conventions
    repo, premium-webdesigner pour direction artistique, etc.).
13. Comment chaque SKILL.md doit pointer ici.
14. Maintenance.

Signature : `Created by João de Almeida — Art of Dev — https://artofdev.space`.

---

## 5. SKILL.md mis à jour

### `repo-builder/SKILL.md`

- **§2 Règles strictes** — section "ne jamais X" raccourcie : pointe vers le tronc
  commun pour push/secrets/destructif/honnêteté ; ne garde que les règles spécifiques
  scaffolding (dumps, node_modules, vendor, .venv, builds + travail dossier courant +
  rapport final). **−10 lignes nettes.**
- **§6 Règles de sécurité** — pointeur en tête + liste spécifique conservée. **+1 ligne
  de pointeur, contenu identique.**
- **§7 Règles Git/GitHub** — pointeur vers le tronc commun pour push --force / amend /
  --no-verify, garde les conventions scaffolding. **−4 lignes.**
- **§10 Commandes interdites** — pointeur vers tronc commun pour rm -rf / reset --hard /
  push --force / gh repo delete / modifs `~/.ssh`. Garde les commandes spécifiques
  (`gh repo edit --visibility public`, `cat .env`, `printenv`, `grep PASSWORD`).
  **−5 lignes nettes.**

**Bilan repo-builder : ~−18 lignes nettes** dans le SKILL.md (déduplication des
règles de sécurité communes), tout le contenu critique survit dans
`docs/shared-safety-rules.md` ou dans les références internes.

---

### `production-auditor/SKILL.md`

- **§4 Règles strictes** — bloc §4.1 (10 lignes "Ne jamais X") + §4.2 (4 lignes
  "Non-destruction") + §4.3 (3 lignes "Périmètre") **remplacés** par un pointeur vers
  le tronc commun + 5 lignes spécifiques audit (lecture seule par défaut, réversibilité,
  pas de refonte, pas de cosmétique cassante, pas de prod sans backup) + 1 phrase sur
  la procédure secret. **−12 lignes nettes.**
- **§12 Commandes interdites** — pointeur vers le tronc commun pour rm -rf / push --force
  / reset --hard / gh repo delete. Garde les commandes spécifiques (npm/composer/pip
  install, modif DB, contact prod, cat .env). **−4 lignes nettes.**

**Bilan production-auditor : ~−16 lignes nettes.**

---

### `premium-webdesigner/SKILL.md`

- **§5.2 Sécurité / non-destruction** — pointeur vers tronc commun + 3 lignes
  spécifiques (donnée dynamique → hardcodé, flow critique cassé, réversibilité).
  **−2 lignes nettes.**
- **§4 Phase F (règles d'exécution)** — la liste "ne pas casser routes/SEO" garde ses
  bullets métier ; suppression du bullet redondant "Ne jamais remplacer des données BDD"
  (pointe vers shared §6). **−1 ligne nette.**
- **§10 Commandes interdites** — pointeur vers le tronc commun pour rm -rf / push --force
  / reset --hard / `.env`/credentials. Garde les commandes spécifiques (hardcodage de
  données dynamiques, imposition stack moderne, copie 21st.dev sans citation, images
  sans licence, npm install). **−2 lignes nettes.**

**Bilan premium-webdesigner : ~−5 lignes nettes** (le crédit footer Art of Dev et le
bloc anti-design-basique sont **conservés intégralement** car spécifiques métier).

---

### `multilingual-site-engine/SKILL.md`

- **§1 Rôle du skill** — ajout d'un pointeur en bloc cite vers `shared-safety-rules.md`
  pour les règles transversales (push, secrets, destructif, non-destruction).
  **+3 lignes** (l'ajout d'un pointeur explicite, car il n'existait pas de bloc "ne
  jamais X" centralisé dans ce SKILL.md).
- Le reste (anti-style IA, hreflang, slugs, formats locaux, RTL) est entièrement
  spécifique → conservé.

**Bilan multilingual-site-engine : +3 lignes** (ajout du pointeur, pas de duplication
préexistante à supprimer).

---

### `skill-orchestrator/SKILL.md`

- **§6 Règles non négociables** — pointeur vers le tronc commun + 6 règles spécifiques
  (créer un repo sans demande, audit complet auto, charger plusieurs gros skills en
  chaîne, expliquer le choix, le plus spécifique d'abord, mentionner si évitable).
  **Suppression des 2 bullets redondants** (push/reset/rm-rf + actions destructives).
  **−2 lignes nettes.**

**Bilan skill-orchestrator : −2 lignes nettes.**

---

### Non touchés (autre agent en parallèle)

- `site-ux-guardian/SKILL.md` — déjà optimisé par l'autre agent (passé de ~830 à 258 lignes).
- `seo-content-engine/SKILL.md` — déjà optimisé par l'autre agent (306 lignes).

Ces deux SKILL.md pourront pointer vers `docs/shared-safety-rules.md` dans une passe
ultérieure quand l'autre agent aura fini, **sans conflit** car le tronc commun existe
désormais.

---

## 6. Références d'analyse non touchées (lecture seule de l'audit)

Aucune référence dans `skills/*/references/` n'a été modifiée pendant cette phase.
La factorisation s'est faite **uniquement** au niveau des SKILL.md (où la duplication
était la plus visible et la plus coûteuse en tokens).

Les références spécifiques (security-checklist détaillé de production-auditor,
github-workflow de repo-builder, security-sanity-checklist de site-ux-guardian, etc.)
restent **intactes** : elles sont chargées **à la demande** par le skill concerné, donc
le coût en tokens est déjà cloisonné.

---

## 7. Verdict

| Métrique | Valeur |
|---|---|
| Familles de doublons identifiées | **10** |
| Familles factorisées (déplacées vers `docs/shared-safety-rules.md`) | **7** (familles 1-7) |
| Familles **gardées volontairement** (périmètres distincts) | **3** (familles 8-10) |
| Référence partagée créée | **1** — `docs/shared-safety-rules.md` (319 lignes) |
| SKILL.md mis à jour | **5** — repo-builder, production-auditor, premium-webdesigner, multilingual-site-engine, skill-orchestrator |
| SKILL.md non touchés (autre agent) | **2** — site-ux-guardian, seo-content-engine |
| Tokens économisés (estimation) | **~38 lignes nettes** dans les 5 SKILL.md modifiés ; ~250 lignes de duplication conceptuelle factorisée vers une source unique. Gain réel = lecture future plus rapide + maintenance d'une seule règle au lieu de 6. |

### Statut Phase 6

**Préparation v1.0.0-rc1 : section "déduplication des règles communes" complétée.**

Reste à faire (hors périmètre de cette tâche) :

- une fois l'autre agent terminé sur `site-ux-guardian/SKILL.md` et
  `seo-content-engine/SKILL.md` : ajouter le pointeur vers `docs/shared-safety-rules.md`
  dans ces 2 fichiers (section sécurité courte) ;
- mettre à jour le `CHANGELOG.md` à la racine avec une ligne v1.0.0-rc1 mentionnant
  la création de `docs/shared-safety-rules.md` ;
- mettre à jour le `README.md` racine pour mentionner cette référence partagée dans
  la section documentation.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
