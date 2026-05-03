# Skill 4 — `seo-content-engine` : écrire des articles SEO utiles, sans bullshit

*Section éditoriale prête à intégrer dans un article public.*

---

## Le problème : les articles IA génériques ont gagné

Quand on demande à une IA *"écris-moi un article SEO sur X"*, on obtient à 95 % du temps :

- une introduction qui commence par *"Dans le monde d'aujourd'hui..."* ou *"À l'ère du numérique..."* ;
- trois sections qui pourraient s'appliquer à n'importe quel sujet ;
- des paragraphes qui reformulent la même idée trois fois ;
- une statistique non sourcée du genre *"selon une étude récente, 80 % des utilisateurs..."* ;
- une FAQ artificielle où chaque question est une variante de la suivante ;
- une conclusion qui résume ce qu'on vient de lire ;
- un CTA générique du type *"N'hésitez pas à nous contacter"*.

C'est lisible. Ça **passe** dans Google. Mais ce n'est pas **utile**. Et le lecteur le sent.

Le problème n'est pas que l'IA ne sache pas écrire. Le problème est qu'elle ne **cadre pas** ce qu'elle écrit. Pas de cible précise, pas d'angle, pas de méthode.

## Le SEO n'est pas suffisant

Optimiser pour les moteurs de recherche est devenu trivial : metadata, mots-clés, structure, schema. Tout ça, n'importe quel outil le fait en 30 secondes.

Mais Google a évolué. Les **Helpful Content Updates** (2022, 2023, 2024) pénalisent maintenant le contenu généré sans valeur. Un article rempli des mots-clés mais creux finit **tassé dans les SERPs**, pas en première page.

L'enjeu n'est plus le SEO. C'est la **qualité éditoriale**. Et c'est exactement ce que la plupart des prompts IA naïfs ratent.

## La solution : un Claude Skill qui force une méthode

`seo-content-engine` est un Claude Skill **public-ready** qui empêche Claude de produire du contenu générique.

Quand tu lui demandes un article, il **ne rédige pas immédiatement**. Il commence par :

1. **Comprendre le sujet** — pas seulement les mots, mais l'angle, la profondeur attendue, la langue ;
2. **Identifier le public cible** — débutant ou expert ? technique ou non ? B2B ou B2C ? ;
3. **Définir l'intention de recherche** — informationnelle, tutoriel, comparative, transactionnelle, problème ? ;
4. **Préparer une structure SEO** — title, meta description, slug, H1/H2/H3, FAQ, liens internes, plan d'images ;
5. **Vérifier les sources** — citer ce qui peut être cité, refuser d'inventer ;
6. **Adapter le ton** au contexte (blog tech, SaaS, tutoriel, doc, page produit, article expert, contenu créatif).

**Et seulement après**, il rédige — section par section, avec exemples concrets, FAQ utile, CTA naturel.

À la fin, il **score** le contenu sur 100. Si le score est inférieur à 76, il propose de retravailler.

## Comment il prépare title, meta, slug, FAQ, liens internes et images

Pour chaque article, le skill produit une **fiche SEO complète** :

```yaml
title: "..."                  # 50-60 caractères, mot-clé naturel
meta_description: "..."       # 130-160 caractères, descriptive
slug: kebab-case-court
primary_keyword: "..."
secondary_keywords: [...]
search_intent: ...
target_audience: "..."
language: fr
schema_type: Article  # ou HowTo, FAQPage, Product...
```

Pour chaque **lien interne suggéré** : type de page, ancre descriptive, raison du lien, statut (existant ou à créer).

Pour chaque **image** : description, style, prompt IA détaillé ou mots-clés, alt text, emplacement, source, licence.

Pour la **FAQ** : 3 à 8 questions **réellement** posées (Stack Overflow, forums, support, People Also Ask), pas inventées.

## Comment il gère les sources

Le skill applique une règle stricte : **on ne fabrique pas de source**.

- Si une affirmation factuelle a besoin d'une source → la source est citée explicitement (auteur, année, URL).
- Si l'accès web n'est pas disponible (sandbox, firewall, hors ligne) → le skill **le dit** et ajoute une section *"Sources à vérifier avant publication"* qui liste tous les faits à valider manuellement.
- Si une statistique ne peut pas être sourcée → elle est **retirée**, pas inventée.
- Les citations célèbres attribuées à Einstein, Steve Jobs, etc. sont **vérifiées** avant utilisation (la plupart sont fausses).

## Comment il attribue un score qualité

Sur **100 points**, répartis sur **12 critères** pondérés :

| Critère | Poids |
|---|---|
| Précision (faits exacts, vocabulaire juste) | 12 |
| Utilité (apporte une vraie valeur) | 12 |
| Originalité (pas générique, angle clair) | 12 |
| Profondeur (traite vraiment le sujet) | 10 |
| Structure SEO (title, meta, H1/H2, slug) | 10 |
| Absence de bullshit (test du paragraphe transposable) | 10 |
| Exemples concrets | 8 |
| Cohérence du ton | 6 |
| Qualité de la FAQ | 6 |
| Qualité du CTA | 4 |
| Qualité des images proposées | 5 |
| Qualité des sources (si utilisées) | 5 |

**Verdict :**

| Score | Statut |
|---|---|
| 0–20 | Inutilisable |
| 21–40 | Trop générique |
| 41–60 | Correct mais faible |
| 61–75 | Publiable avec corrections |
| 76–90 | Bon contenu SEO |
| 91–100 | Contenu premium publiable |

Le skill **refuse** de livrer un contenu en dessous de 40 sans alerte explicite. Il propose alors de refondre ou de changer d'angle.

## Le test central : le paragraphe transposable

C'est le test que le skill applique à **chaque paragraphe** d'un article :

> *"Si je copie ce paragraphe dans un article sur un autre sujet sans rien changer, est-ce que ça reste cohérent ?"*

Si oui → le paragraphe est **transposable** → c'est du remplissage générique → **à supprimer ou réécrire**.

Si non → le paragraphe est **spécifique** au sujet → on garde.

Ce simple test élimine 70 % du contenu IA bullshit.

## Exemple de prompt

```txt
Écris un article SEO complet sur "comment structurer une page produit SaaS".

Public : développeurs freelance qui lancent leur premier SaaS.
Ton : SaaS / clair, problème-solution.
Longueur : 1500 mots.

Inclure :
- metadata SEO complète (title, meta, slug, mots-clés)
- structure H1/H2/H3
- exemples concrets dans chaque section
- FAQ (4-6 questions réelles)
- 3-6 liens internes documentés (avec ancres et raisons)
- plan d'images (hero + 1-2 secondaires)
- sources si chiffres ou doc externes utilisés
- score qualité éditoriale en fin

Si tu n'as pas accès au web, indique-le et marque les chiffres "TO VERIFY".
Ne JAMAIS inventer une source.
```

## Exemple de résultat attendu (extrait)

```markdown
---
title: "Comment structurer une page produit SaaS qui convertit"
meta_description: "Méthode en 7 sections pour bâtir une page produit SaaS claire,
crédible et orientée conversion. Exemples, erreurs à éviter, FAQ."
slug: structurer-page-produit-saas
primary_keyword: "page produit SaaS"
secondary_keywords: ["landing page SaaS", "structure page produit", "conversion SaaS"]
search_intent: tutoriel
target_audience: "développeur freelance lançant son premier SaaS"
estimated_reading_time: 7 minutes
schema_type: Article
---

# Structurer une page produit SaaS : la méthode en 7 sections

Une page produit SaaS qui convertit ne dépend pas du nombre d'animations ou de la
beauté du gradient. Elle repose sur sept sections qui répondent, dans l'ordre,
aux questions que se pose un visiteur en 30 secondes. ...

## 1. Le hero qui pose le problème
...
```

Et à la fin :

```markdown
## Score qualité éditoriale : 87 / 100 — Bon contenu SEO

| Critère | Score |
|---|---|
| Précision | 11 / 12 |
| Utilité | 12 / 12 |
| Originalité | 10 / 12 |
| ...

**Top 3 actions immédiates** :
1. Vérifier la version exacte de Stripe Checkout 3DS citée.
2. Reformuler le CTA pour préciser l'action.
3. Compléter le alt text de l'image de la section 3.
```

## La suite

`seo-content-engine` est un skill **public-ready**, conçu pour être utilisé par :

- développeurs indépendants ;
- agences web ;
- créateurs de contenu ;
- équipes marketing ;
- fondateurs de SaaS ;
- blogueurs ;
- éditeurs de sites ;
- rédacteurs SEO ;
- équipes produit.

Aucune référence privée. Aucun site personnel. Aucune marque. Réutilisable tel quel dans n'importe quel contexte.

Le code source du skill est ouvert. Les règles, templates et scripts sont versionnés. Chacun peut l'adapter à son ton, son secteur, sa charte éditoriale.

---

Created by João de Almeida
