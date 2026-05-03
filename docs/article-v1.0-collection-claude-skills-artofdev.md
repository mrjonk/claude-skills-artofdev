# Comment j'ai transformé Claude Code en chaîne de production avec 7 skills spécialisés

*Section éditoriale prête à intégrer dans un article public.*
*Created by João de Almeida*

---

## Le problème : les prompts répétés

Quand on commence à utiliser Claude Code sérieusement, on tombe vite dans une mécanique de prompts longs, recopiés, ajustés à la marge.

À chaque nouveau projet, on réécrit *"crée un repo propre avec README, .gitignore adapté, pas de .env commité..."*. À chaque audit, on réécrit *"vérifie title, alt text, console.log, .env..."*. À chaque refonte, on réécrit *"propose un design moderne mais pas une homepage avec 3 cards centrées..."*.

Ces prompts grossissent. On les copie dans des notes, dans Notion, dans des fichiers `.md` perso. Ils ne sont jamais à jour entre deux projets.

Plus grave : ils consomment des tokens à chaque session, alors que le comportement attendu est exactement le même. C'est du remplissage récurrent.

## Pourquoi j'ai créé des skills

Un Claude Skill, c'est un dossier de règles + références + templates + scripts que Claude charge automatiquement quand le contexte d'une demande correspond à sa description.

Ce n'est pas un prompt qu'on ajoute à la main : c'est un paquet de comportement réutilisable, versionné, partageable, qu'on installe une fois dans `~/.claude/skills/` et qui s'active tout seul sur les bonnes demandes.

L'avantage immédiat :
- on écrit la règle une fois ;
- elle est appliquée mille fois ;
- elle évolue dans Git, pas dans des notes éparses ;
- on peut la partager.

## Pourquoi ne pas tout charger à chaque demande

Le piège évident, en empilant des skills, c'est de tous les charger à chaque session.

Si chaque skill fait 800 lignes, et qu'on en a 7, ça fait 5 600 lignes injectées dans le contexte avant même que l'utilisateur ait fini sa phrase. C'est cher. C'est lent. Et c'est inutile : pour corriger une typo, on n'a besoin d'aucun skill.

J'ai donc adopté une logique **token-conscious** :
- chaque `SKILL.md` est court (idéalement sous 500 lignes) ;
- il commence par un bloc `USE WHEN` / `SKIP WHEN` qui dit en clair quand l'activer et quand l'éviter ;
- les détails métier (méthodologies longues, checklists, cas particuliers) sont déplacés dans `references/`, qui ne sont chargées que si le skill en a besoin pour la tâche en cours ;
- une table de routage centrale (`docs/skill-routing-map.md`) permet de matcher rapidement une intention utilisateur au bon skill ;
- aucune exécution multi-skills automatique : pour un workflow lourd, un skill orchestrateur propose le plan et demande confirmation avant de mobiliser plusieurs gros skills.

L'idée : payer en tokens uniquement pour ce qui sert à la tâche, pas pour ce qui pourrait servir.

## Les 7 skills

### 1. `repo-builder`

Crée un repo propre, structuré, documenté en une commande. Détecte la stack (statique, SaaS Node, app PHP, mini CMS, plugin WordPress, script Python, doc-only, claude-skill), génère README/CHANGELOG/ROADMAP/.gitignore adaptés, vérifie l'absence de secrets avant tout commit, prépare les commandes Git/GitHub CLI sans pousser sans accord.

### 2. `production-auditor`

Audit avant mise en prod, en 10 phases : lecture projet, cartographie, UX/UI, technique, sécurité, SEO/contenu, admin/billing, scoring, rapport, corrections sûres. Produit un score sur 100 avec 7 sous-axes pondérés (Tech 20 / UX 15 / Sec 25 / SEO 10 / Admin 15 / Billing 10 / Deploy 5). Mode `VIDEO_PRESENTATION_MODE` qui vérifie en plus qu'aucun secret, chemin serveur ou IP n'apparaît à l'écran avant un screen-recording.

### 3. `premium-webdesigner`

Empêche les designs IA basiques (homepage avec gros titre centré + 3 cards en dessous + dégradé violet + stock photo d'équipe). Force une méthode 6-phases : brief, recherche d'inspiration (21st.dev / shadcn / Lucide / Motion), sélection de composants documentée, direction artistique (palette, typo, spacing, radius, shadows), sourcing d'images licensed (Pixabay / Unsplash), exécution alignée stack (pas de React imposé sur PHP). Score `ui-quality-checklist` sur 100, 6 axes.

### 4. `seo-content-engine`

Empêche les articles IA génériques (intro *"dans le monde d'aujourd'hui"*, paragraphes transposables, statistiques inventées, FAQ artificielle). Force une méthode éditoriale 13-étapes avec règle centrale : *test du paragraphe transposable* — *"si un paragraphe peut être copié dans un article sur un autre sujet sans perdre son sens, il doit être supprimé ou réécrit."* Score qualité éditoriale 0-100. Public-ready.

### 5. `site-ux-guardian`

Empêche les corrections partielles. Audit ergonomique transversal en 11 phases : stack, pages, menus (desktop/mobile/admin/switch langue), footers, cohérence globale, doublons (`HeaderV2`, `.bak`), bons fichiers, webdesign guidelines 14 axes, sécurité basique (signalement uniquement), responsive 4 breakpoints. Score cohérence + score visuel sur 100 chacun. Public-ready.

### 6. `multilingual-site-engine`

Traduit, localise et internationalise un site sans casser son architecture. Demande les langues cibles si elles ne sont pas précisées, détecte l'i18n existante (next-intl, gettext, JSON, PHP arrays, .po/.mo, CMS multilingue), préserve variables et placeholders (`{name}`, `{{count}}`, `%s`, `__()`), traduit naturellement, humanise les textes (anti-style IA, traitement spécifique de l'usage excessif des tirets longs `—`), gère hreflang, slugs, menus, footers, formulaires, emails et formats locaux. Deux scores : Translation Quality + Multilingual Site Readiness, 0-100 chacun.

### 7. `skill-orchestrator`

Routeur léger qui analyse une demande utilisateur et identifie le skill le plus spécifique à mobiliser. Propose des skills secondaires uniquement si la demande l'implique. Demande confirmation avant tout workflow multi-skills lourd. Ne crée jamais automatiquement un repo, ne push jamais sans accord, n'enchaîne jamais 4 skills sans validation. Conçu lui-même pour être très court (128 lignes de SKILL.md), parce que c'est le skill chargé en premier dans une session ambiguë.

## Le rôle de l'orchestrateur

L'orchestrateur n'a qu'une mission : **filtrer**.

Il refuse d'invoquer plusieurs gros skills par "sécurité". Il refuse de lancer un audit complet pour une typo. Il refuse de chaîner refonte + traduction + audit final sans avoir d'abord proposé le plan.

Sa réponse type :

```
**Skill recommandé :** premium-webdesigner
**Raison :** la demande porte sur une refonte design.
**Skills secondaires possibles :** site-ux-guardian (cohérence post-refonte).
**Action proposée :** lancer premium-webdesigner en mode brief seul.
**Confirmation requise ?** oui — confirmer le périmètre (homepage seule ?).
```

C'est court. C'est explicite. Et ça empêche l'utilisateur de se retrouver, deux secondes après avoir tapé sa demande, avec 5 000 lignes de méthodologie injectées dans le contexte alors qu'il voulait juste savoir quoi faire.

## Les validations réelles (et ce qui reste à faire)

Cette collection a été construite sur plusieurs semaines, en testant chaque skill sur des projets réels (mini CMS sectoriels, sites vitrines, dashboards admin, projets vidéo YouTube). Chaque skill a un *self-audit* documenté dans `reports/`.

Mais soyons honnêtes : pour passer de **`v1.0.0-rc1`** à **`v1.0.0` final**, il manque :

- des tests runtime des 7 skills sur de vrais projets de plusieurs stacks (PHP statique, Next.js, WordPress) ;
- 15 cas de routage utilisateur réels confrontés à `skill-orchestrator` ;
- une revue anti-régression observée des 5 skills antérieurs ;
- un article publié, une bannière OG, et le tag `v1.0.0` sur GitHub.

Cette honnêteté est volontaire. Une v1.0 maquillée — *"7 skills stables"* parce qu'ils existent dans le repo — vaut moins qu'une v1.0-rc1 qui dit ce qui a été validé et ce qui reste à valider.

## Exemples d'usage

**Création** :
> *"Crée un repo propre pour un mini CMS restaurant PHP/SQLite."* → `repo-builder`.

**Audit avant prod** :
> *"Audite ce SaaS avant mise en prod, mode lecture seule."* → `production-auditor`.

**Refonte ciblée** :
> *"Refais la homepage mais ne touche pas au back-office."* → `premium-webdesigner` avec scope borné. Confirmation demandée.

**Contenu** :
> *"Écris un article SEO complet sur Claude Code pour débutants."* → `seo-content-engine`.

**Cohérence transversale** :
> *"Vérifie que les menus et footers sont cohérents partout."* → `site-ux-guardian`.

**Multilingue** :
> *"Traduis tout le site en anglais et allemand."* → `multilingual-site-engine` (langues précisées, pas de question préalable).

**Routage** :
> *"Quel skill dois-je utiliser pour ça ?"* → `skill-orchestrator`.

**Tâche atomique** :
> *"Corrige juste cette typo."* → aucun skill. L'orchestrateur le sait, et il vaut mieux qu'il le sache.

## Ce que v1.0 apporte (par rapport à des prompts copiés)

- **Cohérence** : la règle "pas de stock photo cliché" est appliquée pareil sur 50 projets.
- **Mémoire** : la règle évolue dans Git, pas dans des notes éparses.
- **Économie de tokens** : on charge le détail d'un skill seulement quand on en a besoin.
- **Délégation** : chaque skill connaît ses limites et envoie l'utilisateur vers le bon skill quand le périmètre dépasse.
- **Auditabilité** : un rapport est produit pour chaque audit / refonte / traduction. On sait ce qui a changé, et pourquoi.

## Limites honnêtes

- Cette collection est conçue pour **mon** workflow. Les règles "Art of Dev" reflètent mes opinions sur le design moderne, le SEO honnête, la cohérence ergonomique. Quelqu'un d'autre les ajusterait.
- Les 7 skills couvrent ce que je fais : créer des repos, refaire des sites, auditer avant prod, traduire, écrire du contenu. Ils ne couvrent pas tout : pas d'audit accessibilité approfondi WCAG, pas d'audit performance Lighthouse runtime, pas de migration de stack. Ces skills viendront plus tard ou pas, selon les besoins.
- L'orchestrateur dépend de la qualité de la table de routage. Si une intention utilisateur n'y figure pas clairement, l'orchestrateur peut proposer un skill imparfait. La table évolue avec l'usage.
- Tous les skills sont en français par défaut. Une version EN est envisagée mais pas engagée.

## Prochaines étapes

- Valider en runtime les 7 skills sur des projets réels.
- Publier `v1.0.0` final après validation humaine.
- Ouvrir le repo aux contributions.
- Documenter les premiers chantiers où la collection a vraiment changé la vitesse de production.

Le code source est ouvert. Les règles, templates et scripts sont versionnés. Chacun peut l'adapter à son propre workflow — c'est précisément à ça que sert un Claude Skill.

---

Created by João de Almeida
