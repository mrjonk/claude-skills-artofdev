# Comment utiliser le skill `seo-content-engine`

Created by João de Almeida

---

## 1. Installation

Une seule fois, depuis la racine du repo :

```bash
bash install.sh seo-content-engine
```

Le skill est copié dans `~/.claude/skills/seo-content-engine/`. Claude Code le détecte à la session suivante.

Pour vérifier :

```bash
ls ~/.claude/skills/seo-content-engine/SKILL.md
bash uninstall.sh --list
```

> Si une version précédente était installée, elle est sauvegardée dans `~/.claude/skills/.backup/seo-content-engine-YYYYMMDD-HHMMSS/`.

---

## 2. Activation automatique

Le skill se charge **automatiquement** quand ta demande matche sa `description:`.

Aucune syntaxe spéciale. Pas de slash-commande obligatoire. Si tu écris *"écris-moi un article SEO sur X"*, le skill se déclenche.

Pour forcer la prise en compte (debug) :

> *"Utilise le skill `seo-content-engine` pour rédiger cet article."*

---

## 3. Comment demander un article

### Article complet (cadrage + plan + rédaction + score)

```txt
Écris un article SEO complet sur "comment structurer une page produit SaaS".
Public : développeurs freelance qui lancent leur premier SaaS.
Ton : SaaS / clair, problème-solution.
Longueur : 1500 mots.
Inclure : metadata SEO, FAQ (4-5 questions), 3-6 liens internes, plan d'images,
sources si chiffres ou doc externes utilisés.
```

Le skill produit :
- frontmatter SEO complet ;
- structure H1/H2/H3 ;
- exemples concrets ;
- FAQ utile ;
- liens internes documentés ;
- plan d'images ;
- liste de sources ;
- score qualité éditoriale.

---

## 4. Comment demander seulement un plan

```txt
Crée un SEO outline pour un article sur "audit éditorial : 7 signaux d'un contenu
IA générique". Public : équipes marketing. Ton : article expert. Pas de rédaction,
juste le plan complet : title, meta, slug, H1, H2, H3 prévus, FAQ prévue, liens
internes prévus, plan d'images.
```

Le skill rend uniquement les fichiers de planning :
- `docs/article-brief.md`
- `docs/seo-outline.md`

C'est utile pour valider la direction **avant** de rédiger 1500 mots.

---

## 5. Comment demander un audit anti-bullshit

```txt
Audite cet article et liste : phrases creuses, paragraphes transposables, répétitions,
statistiques non sourcées, FAQ artificielle, CTA générique. Donne-moi le score qualité
éditoriale et les corrections recommandées. Ne réécris rien tant que je ne te le demande pas.
```

Le skill produit un rapport `content-audit.md` avec :
- score sur 100 ;
- problèmes classés (CRIT / IMP / MIN) ;
- paragraphes transposables détectés ;
- phrases creuses détectées ;
- répétitions ;
- statistiques à sourcer ;
- plan d'action.

---

## 6. Comment demander un article avec sources

```txt
Rédige un guide complet sur les Server Components React. Inclure des sources officielles
(doc React, doc Next.js). Ne **jamais** inventer une source. Si tu n'as pas accès au web,
ajoute une section "Sources à vérifier avant publication".
```

Le skill :
- cite les sources officielles ;
- indique clairement si l'accès web n'est pas dispo ;
- ajoute la section *"Sources à vérifier avant publication"* si nécessaire ;
- utilise des formulations prudentes pour les chiffres non vérifiés.

---

## 7. Comment l'utiliser sur un repo public

### Setup initial

```bash
cd /chemin/vers/mon/repo-content
bash skills/seo-content-engine/scripts/prepare-content-folder.sh
```

Crée la structure :

```
content/
├── drafts/
├── published/
├── briefs/
├── outlines/
├── images/
└── sources/
```

### Workflow par article

```bash
# 1. Brief éditorial
bash skills/seo-content-engine/scripts/create-article-brief.sh "Mon nouvel article"

# 2. Plan SEO
bash skills/seo-content-engine/scripts/create-seo-outline.sh "Mon nouvel article"

# 3. Rédaction (Claude utilise le skill automatiquement)
# 4. Audit
bash skills/seo-content-engine/scripts/scan-generic-content.sh content/drafts/mon-article/
bash skills/seo-content-engine/scripts/scan-repetitions.sh content/drafts/mon-article/article.md

# 5. Si OK : déplacer vers published/
mv content/drafts/mon-article content/published/
```

---

## 8. Comment l'utiliser dans un projet de contenu

### Cas : équipe marketing avec 10 articles par mois

1. Chaque membre clone le repo de skills.
2. `bash install.sh seo-content-engine` (une fois par poste).
3. Chaque article suit le workflow standard (brief → outline → rédaction → audit → publication).
4. Les **briefs** et **outlines** sont versionnés dans `content/briefs/` et `content/outlines/` (traçabilité éditoriale).
5. Les **scripts de scan** tournent en CI ou en pre-commit hook (optionnel).

### Cas : créateur indépendant

1. `bash install.sh seo-content-engine`.
2. Pour chaque article : *"Écris un article SEO sur X"* → Claude applique la méthode.
3. Audit final via les scripts pour détecter les phrases creuses oubliées.
4. Publication directe dans le CMS (le contenu est déjà au format prêt à coller).

---

## 9. Demander brief seul vs brief + rédaction

### Brief seul

> *"Brief éditorial uniquement, pas de rédaction. Je veux valider l'angle avant que tu écrives."*

Le skill rend `docs/article-brief.md` rempli. Il **n'écrit pas** d'article.

### Brief + rédaction

> *"Brief complet puis rédaction si je valide. Marque une PAUSE après le brief."*

Le skill rend le brief, **demande validation**, puis rédige sur OK.

### Rédaction directe (déconseillé)

> *"Écris directement l'article, pas besoin de brief."*

→ Le skill **résiste** à cette demande car elle court-circuite la méthode. Il propose un compromis : *"Brief minimal en 5 lignes puis rédaction"*. Si l'utilisateur insiste, le skill rédige mais signale dans le rapport que le score risque d'être inférieur à 70 (méthode incomplète).

---

## 10. Limites et bonnes pratiques

- Le skill **ne remplace pas** un rédacteur SEO humain qui connaît le secteur.
- Le skill **n'a pas** d'accès web par défaut. Pour les articles avec données chiffrées, prévoir une session avec accès web ou marquer les sources *"à vérifier"*.
- Le skill **est public-ready** : ne contient aucune référence privée. Réutilisable par n'importe qui dans n'importe quel contexte (créateur indé, équipe marketing, agence, blogueur).
- Les **sources** doivent être validées humainement avant publication, même si le skill cite des URLs (un humain vérifie qu'elles n'ont pas changé).

---

## 11. Désinstallation

```bash
bash uninstall.sh seo-content-engine
```

Sauvegarde le skill dans `~/.claude/skills/.backup/`, puis le retire. **Ne touche pas** aux autres skills installés.

---

Created by João de Almeida
