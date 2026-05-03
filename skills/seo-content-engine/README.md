# `seo-content-engine` — README du skill

> Mode d'emploi du skill **`seo-content-engine`**.
> Pour la définition formelle (règles, méthode, scoring, checklists), voir [`SKILL.md`](SKILL.md).

Created by João de Almeida

---

## À quoi sert ce skill

`seo-content-engine` empêche Claude de produire des articles **génériques** ou **bullshit**.

Quand tu demandes *"écris-moi un article SEO"*, Claude ne saute pas direct à la rédaction. Il :

1. **Comprend** le sujet, le public, l'intention de recherche, le niveau de profondeur.
2. **Prépare** une structure SEO complète (title, meta description, slug, H1/H2/H3, FAQ, liens internes).
3. **Rédige** un contenu utile, avec exemples concrets et angle éditorial clair.
4. **Cite** ses sources quand il s'appuie sur de la doc externe — et **refuse** d'inventer des chiffres ou citations.
5. **Propose** des images cohérentes (description, alt text, prompts IA).
6. **Suggère** des liens internes pertinents (ancres + raisons).
7. **Score** la qualité du contenu sur 100 et donne un verdict.

Tout est **prêt à coller dans un CMS** (WordPress, Ghost, Hashnode, headless) sans retravail.

---

## Quand l'utiliser

Le skill se charge automatiquement pour des prompts comme :

- *"écris un article"* / *"write an article"* ;
- *"article SEO"* / *"SEO blog post"* ;
- *"rédige un tutoriel"* / *"write a tutorial"* ;
- *"audit this article"* / *"audite ce contenu"* ;
- *"improve this content"* / *"améliore cet article"* ;
- *"prepare a FAQ"* / *"prépare une FAQ"* ;
- *"write a product page"* / *"page produit"* ;
- *"make this content less generic"* / *"rends ce contenu moins générique"* ;
- *"prepare SEO metadata"* / *"prépare les metadata SEO"*.

---

## Comment l'appeler dans Claude Code

**Aucune syntaxe spéciale.** Le skill se charge dès que ta demande matche sa `description:`.

Pour forcer la prise en compte (debug) :

> *"Utilise le skill `seo-content-engine` pour rédiger cet article."*

---

## Ce qu'il impose

Méthode éditoriale en **13 étapes** (cf. `SKILL.md §4`). Court-circuiter une étape n'est pas une option.

À chaque article produit, il fournit :

- metadata SEO complète (`title`, `meta_description`, `slug`, `category`, `tags`, `primary_keyword`, `secondary_keywords`, `search_intent`, `target_audience`) ;
- structure H1/H2/H3 logique ;
- exemples concrets dans chaque section ;
- FAQ utile (3–8 questions) ;
- 3–6 suggestions de liens internes ;
- plan d'images (hero + secondaires) ;
- liste de sources citées ;
- CTA naturel ;
- score qualité éditoriale (0–100) avec verdict.

---

## Comment il évite le contenu générique

Cf. [`references/anti-bullshit-rules.md`](references/anti-bullshit-rules.md). Le skill **refuse** :

- phrases creuses (*"dans le monde d'aujourd'hui"*, *"il est important de"*, *"révolutionner"*) ;
- paragraphes répétitifs ou transposables ;
- introduction trop longue ;
- conclusion vide ;
- statistiques inventées ;
- citations inventées ;
- titres sensationnalistes sans substance ;
- FAQ artificielle ;
- CTA agressif.

**Test central :** *"Si un paragraphe peut être copié dans un article sur un autre sujet sans perdre son sens, il doit être supprimé ou réécrit."*

---

## Comment il structure un article

Structure par défaut (cf. `SKILL.md §6`) :

```
Frontmatter SEO (title, meta, slug, mots-clés, public, intention)
H1
Introduction (3–4 phrases max)
H2 — section 1
  Exemple concret
H2 — section 2
  Exemple concret
Exemples concrets (synthèse)
Conseils pratiques
Erreurs à éviter
FAQ
Pour aller plus loin (liens internes)
Sources
Images recommandées
Conclusion + CTA
Score qualité éditoriale
```

Tout est **prêt à coller** dans un CMS.

---

## Comment il adapte le ton

Cf. [`references/tone-of-voice-guide.md`](references/tone-of-voice-guide.md). 7 contextes prévus :

| Contexte | Ton |
|---|---|
| Blog technique | clair, précis, pédagogique, crédible |
| SaaS | problème/solution, rassurant, conversion non agressive |
| Tutoriel débutant | simple, direct, étape par étape |
| Documentation simplifiée | très clair, structuré, neutre |
| Page produit | bénéfices réels, concret, sans promesses vagues |
| Article expert | approfondi, argumenté, avec sources |
| Contenu créatif | vivant, contextualisé, sans exagération |

**Règle :** un seul ton par article. Pas de mix incohérent.

---

## Comment il gère les sources

Cf. [`references/source-citation-guide.md`](references/source-citation-guide.md).

**Tu cites quand** : doc externe, fonctionnalité récente, chiffres, comparaisons, prix, API, lois, conditions.

**Tu n'inventes jamais** : sources, citations, chiffres, "selon une étude".

**Si l'accès web n'est pas disponible :**

1. tu le **dis explicitement** ;
2. tu écris un brouillon avec formulations prudentes ;
3. tu ajoutes une section *"Sources à vérifier avant publication"* listant les faits à valider.

---

## Comment il prépare images et liens internes

### Images

Pour chaque image proposée :
- description précise ;
- style visuel ;
- mots-clés de recherche **ou** prompt IA détaillé ;
- alt text non vide ;
- emplacement recommandé dans l'article ;
- crédit si source externe.

**Anti-clichés :** pas d'équipe en costume, pas de mains sur clavier, pas d'ampoule "idée".

### Liens internes

3 à 6 suggestions par article. Pour chaque :
- type de page à lier ;
- ancre suggérée (descriptive, jamais *"cliquez ici"*) ;
- raison du lien (pourquoi c'est utile au lecteur) ;
- page à créer si elle n'existe pas (signal de planning éditorial).

---

## Exemples de prompts

### Article complet

```txt
/seo-content-engine Write a complete SEO article about how to structure a small SaaS landing page. Include SEO metadata, H1/H2/H3, FAQ, internal link suggestions and image ideas.
```

### Tutoriel

```txt
/seo-content-engine Rédige un tutoriel simple pour installer un outil de développement. Le contenu doit être clair, concret, sans jargon inutile, avec FAQ et sources si une documentation externe est utilisée.
```

### Audit

```txt
/seo-content-engine Audit this article and remove generic paragraphs, repetitions, weak examples and SEO fluff. Keep only useful, specific and publishable content.
```

### Plan SEO seul

```txt
/seo-content-engine Create a SEO outline for a product page targeting non-technical users. Include title, meta description, slug, H1, H2, FAQ, CTA and image recommendations.
```

D'autres prompts dans [`../../docs/seo-content-engine-examples.md`](../../docs/seo-content-engine-examples.md).

---

## Ce que le skill ne fait jamais

- rédiger un article complet sans cadrage éditorial ;
- inventer une source, une citation, un chiffre ;
- prétendre avoir consulté une page web non vue ;
- copier du contenu sans citer la source ;
- produire des paragraphes transposables (test central) ;
- ajouter des CTA agressifs ;
- inclure des FAQ artificielles ;
- pousser vers GitHub sans accord ;
- supprimer un fichier sans accord écrit ;
- utiliser des phrases creuses listées dans `anti-bullshit-rules.md`.

---

## Comment l'améliorer plus tard

Le skill est un dossier — modifie-le directement :

1. ajuste `SKILL.md` (règles, méthode, scoring) ;
2. enrichis `references/` (nouveaux contextes, nouveaux types de contenu) ;
3. ajoute des templates dans `templates/` ;
4. ajoute des scripts dans `scripts/` ;
5. relance `bash install.sh seo-content-engine` à la racine du repo.

---

## Structure du skill

```txt
skills/seo-content-engine/
├── SKILL.md
├── README.md
├── references/                              (10 fichiers)
│   ├── editorial-methodology.md
│   ├── anti-bullshit-rules.md
│   ├── seo-checklist.md
│   ├── article-structure-guide.md
│   ├── tone-of-voice-guide.md
│   ├── internal-linking-guide.md
│   ├── source-citation-guide.md
│   ├── image-planning-guide.md
│   ├── faq-writing-guide.md
│   └── content-quality-score.md
├── templates/                               (10 fichiers)
│   ├── article-brief.template.md
│   ├── seo-outline.template.md
│   ├── article.template.md
│   ├── tutorial.template.md
│   ├── saas-blog-post.template.md
│   ├── product-page.template.md
│   ├── source-list.template.md
│   ├── image-plan.template.md
│   ├── faq.template.md
│   └── content-audit.template.md
└── scripts/                                 (5 fichiers)
    ├── create-article-brief.sh
    ├── create-seo-outline.sh
    ├── scan-generic-content.sh
    ├── scan-repetitions.sh
    └── prepare-content-folder.sh
```

---

Created by João de Almeida
