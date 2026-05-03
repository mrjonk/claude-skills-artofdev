# Guide de citation des sources — `seo-content-engine`

Quand citer, comment citer, et **comment ne jamais inventer** une source.

Created by João de Almeida

---

## 1. Quand citer une source

### Tu dois citer si tu utilises

- une **documentation externe** (API, framework, outil tiers) ;
- une **fonctionnalité récente** d'un produit ou service ;
- des **chiffres** ou **statistiques** ;
- une **comparaison** entre solutions ;
- un **résumé** d'un service ou produit tiers ;
- des **prix**, **conditions**, **règles**, **API**, **lois** susceptibles de changer ;
- une **citation** d'auteur ;
- une **étude** scientifique ou rapport sectoriel ;
- un **benchmark** ou test de performance ;
- une **norme** ou standard (RFC, W3C, ISO).

### Tu peux ne pas citer si

- l'information est **évidente** et **largement connue** (*"HTML est un langage de balisage"*) ;
- c'est une **opinion personnelle** assumée comme telle (*"selon moi..."*) ;
- c'est une **technique courante** non spécifique (*"on utilise généralement un Promise pour les opérations asynchrones"*).

**Règle d'or** : *en cas de doute, cite.*

---

## 2. Comment citer

### Format inline

```markdown
Selon [la documentation officielle de Next.js](https://nextjs.org/docs), le hook `useRouter` retourne un objet immutable.
```

### Format note de bas / liste de sources

À la fin de l'article :

```markdown
## Sources

- Next.js — *"Routing: useRouter"*. https://nextjs.org/docs/app/api-reference/functions/use-router (consulté le 2026-05-15)
- Mark, Gloria. *"The Cost of Interrupted Work: More Speed and Stress"*. UC Irvine, 2008. https://...
- W3C. *"Web Content Accessibility Guidelines (WCAG) 2.1"*. https://www.w3.org/TR/WCAG21/
```

**Format minimal recommandé :**
- **auteur / organisation** ;
- **titre** du document ;
- **éditeur** si différent ;
- **année** ou date de consultation ;
- **URL**.

### Citation textuelle

```markdown
> *"Selon Gloria Mark (UC Irvine, 2008), un employé met en moyenne 23 minutes pour retrouver son focus après une interruption."*
```

Format `> blockquote` Markdown + attribution claire.

---

## 3. Hiérarchie des sources

Privilégier dans cet ordre :

| Niveau | Source | Quand |
|---|---|---|
| 1 | **Documentation officielle** | feature, API, config produit/framework |
| 2 | **Standards reconnus** (W3C, RFC, IETF, MDN, ISO) | normes web, formats, protocoles |
| 3 | **Publications académiques / institutionnelles** | études chiffrées, recherches |
| 4 | **Articles d'auteurs reconnus** | analyse, retour d'expérience documenté |
| 5 | **Blogs ou tutoriels** de qualité éditoriale | techniques courantes, à vérifier |
| 6 | **Forums** (Stack Overflow, GitHub Discussions) | utile mais à valider |

**Règle :** quand une info est dans la doc officielle, **toujours** lier la doc officielle, même si on connaît une autre source secondaire.

---

## 4. Sources interdites / à éviter

- **réponses ChatGPT / IA** (jamais citer une IA comme source) ;
- **sites de spam SEO** ou contenu auto-généré douteux ;
- **traductions non vérifiées** d'articles originaux (lier l'original) ;
- **sources gravitant autour d'une marque** quand on parle d'objectivité (lier la doc officielle ou une étude tierce) ;
- **forums sans réputation** ;
- **screenshots sans source** trouvés sur des slides marketing.

---

## 5. Ce que tu ne fais jamais

- **inventer une source** ;
- **inventer un chiffre** (*"selon une étude récente..."* sans nom) ;
- **inventer une citation** (notamment celles attribuées à Einstein, Steve Jobs, etc. — la plupart sont fausses) ;
- **citer un papier non lu** (consulter la version dispo, pas le titre seul) ;
- **résumer une source** sans la lire (= invention déguisée) ;
- **paraphraser** une source en omettant l'attribution (= plagiat) ;
- **attribuer** une opinion à un auteur sans lien vers la prise de position originale ;
- **falsifier** une URL (ex : *"voir https://exemple.com/article"* qui n'existe pas).

---

## 6. Si l'accès web n'est pas disponible

Cas fréquent (sandbox, firewall, hors ligne).

### Comportement attendu

1. **Le dire explicitement** dans le brief :
   > *"Note : je n'ai pas pu accéder au web pour cette session. Les sources mentionnées dans cet article sont à vérifier avant publication."*

2. **Utiliser des formulations prudentes** :
   - ✅ *"Selon la documentation officielle (à vérifier), useEffect..."*
   - ✅ *"Plusieurs sources s'accordent sur le fait que... (à confirmer)..."*
   - ❌ *"Selon une étude de Stanford de 2024..."* (invention probable)

3. **Ne jamais** inventer un chiffre ou une URL.

4. **Ajouter une section** explicite :

```markdown
## Sources à vérifier avant publication

- [ ] Documentation Next.js sur le routing — vérifier la version actuelle de l'API
- [ ] Étude UC Irvine sur les interruptions — vérifier la référence exacte (Gloria Mark, 2008 ?)
- [ ] Chiffre cité sur la productivité (4h/semaine de réunions redondantes) — trouver une source ou retirer
```

Cette section sert de **rappel** au rédacteur humain qui validera l'article avant publication.

---

## 7. Format des notes "à vérifier" dans le texte

Quand tu n'es pas sûr d'une info, marque-la dans le brouillon :

```markdown
Le hook `useEffect` re-déclenche son effet à chaque changement de la valeur dans son tableau de dépendances. {{À VÉRIFIER : confirmer le comportement exact dans la doc React 18+}}
```

Le `{{À VÉRIFIER : ...}}` doit être **scanable** par l'humain qui relit. Marquage explicite, pas dilué dans le texte.

---

## 8. Citations courantes à toujours vérifier

Beaucoup de citations célèbres sur le web sont **fausses** ou mal attribuées. Avant de citer :

- *"La folie c'est..."* — souvent attribué à Einstein, source douteuse ;
- *"Stay hungry, stay foolish"* — Steve Jobs (vérifié, Stanford 2005) ;
- *"L'imagination est plus importante que la connaissance"* — Einstein (vérifié, mais le contexte est souvent omis) ;
- *"Si vous ne pouvez pas l'expliquer simplement..."* — souvent attribué à Einstein, attribution douteuse.

**Règle :** vérifier **avant** de citer, sinon **ne pas** citer.

---

## 9. Plagiat — à proscrire

- **paraphrase non attribuée** = plagiat (réécrire une source sans la citer) ;
- **copier 2 phrases identiques** d'une source = plagiat ;
- **résumer un article** sans le citer = plagiat ;
- **utiliser une structure d'article** copiée d'un autre site sans citation = problème éthique.

**Règle :** si une idée vient d'ailleurs, **on cite**. Si on construit l'article sur un cluster d'idées, on cite **toutes** les sources principales.

---

## 10. Format de la section "Sources" en fin d'article

```markdown
## Sources

### Documentation officielle
- React Team. *"useEffect"*. React docs. https://react.dev/reference/react/useEffect (consulté le 2026-05-15)
- Next.js. *"App Router: Layouts and Pages"*. https://nextjs.org/docs/app

### Études / publications
- Mark, Gloria. *"The Cost of Interrupted Work: More Speed and Stress"*. UC Irvine, 2008.

### Articles
- Smith, Jane. *"Server Components in Production"*. Personal blog, 2025-09. https://...

### Sources à vérifier
- [ ] Chiffre sur l'adoption des Server Components — pas de source trouvée pour le 78 % cité dans le brouillon
```

Catégoriser les sources rend la traçabilité plus facile pour l'éditeur ou le client.

---

## 11. Checklist citation (relecture finale)

- [ ] toutes les **affirmations factuelles** ont une source ;
- [ ] toutes les **statistiques** ont une source ;
- [ ] toutes les **citations** sont **vérifiées** (auteur, année, contexte) ;
- [ ] toutes les **URL** ont été **testées** (pas de lien mort prévisible) ;
- [ ] **section Sources** présente en fin d'article ;
- [ ] **section "À vérifier"** si l'accès web n'était pas dispo ;
- [ ] aucune source **inventée** ;
- [ ] aucune **paraphrase non attribuée**.

---

Created by João de Almeida
