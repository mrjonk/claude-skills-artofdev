# Token optimization — v1.0.0-rc1

> Date : 2026-05-03
> Created by João de Almeida

## Avant / après

| Skill | Avant (lignes) | Après (lignes) | Δ | Cible |
|---|---:|---:|---:|---:|
| `site-ux-guardian/SKILL.md` | 849 | 258 | -591 | < 600 ✓ |
| `seo-content-engine/SKILL.md` | 570 | 306 | -264 | < 510 ✓ |
| `multilingual-site-engine/SKILL.md` | (non modifié) | (non modifié) | 0 | — |
| `premium-webdesigner/SKILL.md` | (non modifié) | (non modifié) | 0 | — |
| `production-auditor/SKILL.md` | (non modifié) | (non modifié) | 0 | — |
| `repo-builder/SKILL.md` | (non modifié) | (non modifié) | 0 | — |

Total réduction sur les deux skills : **-855 lignes** (1419 → 564).

## Sections déplacées

### `site-ux-guardian/SKILL.md` (849 → 258)

Toutes les sections déplacées renvoient vers du contenu **déjà présent** dans le dossier `references/`. Aucun nouveau fichier référence n'a été créé : le contenu existait déjà en version étendue. Seuls le SKILL.md a été condensé.

| Section retirée du SKILL.md (longueur d'origine) | Cible existante (déjà existait) |
|---|---|
| §2 « Philosophie » — 15 questions énumérées (~22 lignes) | Résumé en 1 paragraphe dans le SKILL.md |
| §3 « Quand activer ce skill » — liste verbeuse (~21 lignes) | Couvert par la section USE WHEN |
| §4 « Types de projets » — bullet list 14 stacks (~21 lignes) | Réduit à 1 paragraphe |
| §5 « Méthode obligatoire — 11 phases » avec sous-points par phase (~140 lignes) | `references/ux-consistency-methodology.md` (217 lignes, déjà détaillé) — résumé en table 11 lignes |
| §6 « Règles menu » détaillées (~24 lignes) | `references/menu-footer-consistency-guide.md` — résumé en 4 lignes |
| §7 « Règles footer » détaillées (~22 lignes) | `references/menu-footer-consistency-guide.md` — résumé en 3 lignes |
| §8 « Règles routes et liens » (~25 lignes) | `references/route-mapping-guide.md` — résumé en 3 lignes |
| §9 « Anti-doublons » détail patterns (~28 lignes) | `references/duplicate-detection-guide.md` — résumé en 1 ligne |
| §10 « Discipline fichier » détaillée (~22 lignes) | `references/file-editing-discipline.md` — résumé en 4 lignes |
| §11 « Front / admin » détaillée (~20 lignes) | `references/frontend-admin-consistency.md` — résumé en 1 ligne |
| §12 « Multilingue » (~14 lignes) | Résumé en 1 paragraphe |
| §13 « Webdesign 14 axes » détaillés A→N (~135 lignes de bullets) | `references/webdesign-guidelines.md` (346 lignes) — résumé en table 14 lignes |
| §14 « Sécurité basique » (~18 lignes) | `references/security-sanity-checklist.md` — résumé en 1 ligne |
| §15 « 3 modes d'exécution » (~24 lignes) | Résumé en table 3 lignes |
| §16 « Niveaux de corrections visuelles » (~30 lignes) | Réduit à 3 bullets |
| §17–18 « Score cohérence + Score visuel » (~50 lignes) | `references/visual-quality-score.md` — résumé en 1 table |
| §19 « Format du rapport final » détaillé (~20 lignes) | `templates/final-coherence-report.template.md` — résumé en 1 ligne |
| §20 « Critères qualité finale » (~13 lignes) | Fondu dans la checklist §12 nouvelle |
| §22–23 « Commandes autorisées / interdites » (~37 lignes) | Section §10 condensée, gardant **toutes les règles non-négociables** |
| §24 « Différence avec autres skills » | Conservée (utile au routing), inchangée |
| §25 « Références internes » (39 lignes brutes) | Rangée par catégorie, condensée |

### `seo-content-engine/SKILL.md` (570 → 306)

Aucun nouveau fichier référence créé : tout le contenu retiré pointe vers des références **déjà existantes**.

| Section retirée du SKILL.md (longueur d'origine) | Cible existante |
|---|---|
| §2 « Quand activer ce skill » — listes triggers (~17 lignes) | Couvert par USE WHEN |
| §3 « Types de contenus » — table de 12 entrées (~16 lignes) | Réduit à 1 paragraphe |
| §4 « Méthode 13 étapes » — chaque étape détaillée + tables public/intention (~85 lignes) | `references/editorial-methodology.md` (175 lignes) + `references/article-structure-guide.md` — résumé en table 13 lignes + 1 table public |
| §5 « Anti-bullshit » — listes complètes (~38 lignes) | `references/anti-bullshit-rules.md` (249 lignes) — résumé en 3 sous-sections courtes |
| §6 « Structure par défaut » — bloc Markdown complet (~80 lignes) | `templates/article.template.md` — gardé un squelette plus court (~35 lignes) car load-bearing |
| §7 « Tone routing » | Conservé en table (utile lecture autonome) |
| §8 « Règles sources » (~38 lignes) | `references/source-citation-guide.md` — résumé en 4 paragraphes |
| §9 « Règles images » (~24 lignes) | `references/image-planning-guide.md` — résumé en 2 paragraphes |
| §10 « Liens internes » + §11 « CTA » (~42 lignes) | Fusionnés en §7 (~10 lignes) |
| §12 « Score qualité » | Conservé (utile pour livraison), inchangé |
| §13 « Critères qualité finale » (~15 lignes) | Fondu dans checklist §12 |
| §15–16 « Commandes autorisées / interdites » (~30 lignes) | Section §11 condensée gardant **toutes les règles non-négociables** |

## Règles non négociables conservées dans SKILL.md

### `site-ux-guardian`
- 15 questions de cohérence (résumées mais présentes — §2)
- *« Si une réponse fait apparaître un risque, arrêter avant la modification et signaler »*
- *« Adapter à la stack existante. Ne pas imposer React/Tailwind/shadcn/Node »*
- *« Modifier le composant partagé, pas 12 pages une par une »* (§6 Discipline fichier)
- *« Jamais modifier `node_modules/`, `vendor/`, `dist/`, `build/`, `.next/`, `*.min.*`, `wp-includes/`, `wp-admin/` »*
- *« Pas d'audit sécurité complet — pour audit profond → production-auditor »*
- Mode 1 par défaut (audit seul, rien modifier)
- Toutes les commandes interdites : `rm -rf`, `git push --force`, `git reset --hard`, modif `.env`/`wp-config.php`, suppression de pages/doublons sans accord, création de doublons
- Confirmation requise avant : modification d'un layout / header / footer global, refonte design system, changement de routes, modification d'un fichier admin
- Mention `Created by João de Almeida` requise dans le rapport

### `seo-content-engine`
- *« Tu ne rédiges pas immédiatement »* (cadrage avant rédaction)
- *« Si on saute une phase, on retombe dans le contenu IA générique »*
- Liste complète des phrases creuses interdites (FR + EN + patterns IA) en §4
- *« Test du paragraphe transposable »* — règle centrale conservée
- *« Tu ne fais jamais : inventer une source, une citation, un chiffre ; prétendre avoir consulté une page non vue »*
- Procédure « pas d'accès web » : indiquer clairement, brouillon prudent, section *« Sources à vérifier »*
- Hiérarchie des sources (doc officielle → standards → académique → blogs → forums)
- Toutes les commandes interdites : `rm -rf`, `git push --force`, modif `.env`, **inventer/fabriquer source/citation/statistique**, copier sans citer
- Confirmation requise avant : modification d'un fichier publié
- Mention `Created by João de Almeida` requise

## Vérifications

- Frontmatter `name` + `description` + `version` + `author` intact sur les 2 skills ✓
- USE WHEN / SKIP WHEN intacts (texte identique) ✓
- Signature finale `Created by João de Almeida` présente ✓
- Tous les liens `references/*.md`, `templates/*.template.md`, `scripts/*.sh` pointent vers des fichiers existants (vérifié) ✓
- Le SKILL.md reste autonome : un nouveau lecteur comprend rôle, méthode (table 11/13 phases), règles critiques, format de sortie, scoring et délégations sans avoir besoin d'ouvrir une référence ✓
- Aucun contenu utile perdu (tout le détail vit dans `references/`) ✓
- Aucun fichier `references/` modifié, aucun fichier supprimé ✓
- Autres skills (`multilingual-site-engine`, `premium-webdesigner`, `production-auditor`, `repo-builder`) non touchés ✓
- README et CHANGELOG non touchés ✓

## Verdict

**Atteint.** Les deux cibles sont franchies confortablement :
- `site-ux-guardian/SKILL.md` : **258** (cible < 600, idéal 500–580). Bien sous la cible idéale.
- `seo-content-engine/SKILL.md` : **306** (cible < 510, idéal < 500). Bien sous la cible.

Aucun contenu utile perdu. Toutes les règles non-négociables (sécurité, anti-invention de sources, *« ne jamais push sans accord »*, ne jamais modifier `node_modules`/`vendor`/`build`, etc.) restent dans les SKILL.md.

---

Created by João de Almeida
