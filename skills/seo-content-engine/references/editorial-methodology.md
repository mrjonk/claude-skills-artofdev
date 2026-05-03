# Méthode éditoriale — `seo-content-engine`

Méthode complète **en 7 phases**. À dérouler dans l'ordre pour chaque contenu produit.

Created by João de Almeida

---

## Phase 1 — Cadrage

**Objectif :** comprendre ce qu'on doit écrire, pour qui, et pourquoi.

À déterminer :

- **Type de contenu** (cf. `SKILL.md §3`) : article de blog, tutoriel, guide, page produit, FAQ, doc, audit ;
- **Sujet précis** (pas *"productivité"* → *"techniques de focus pour développeurs en open space"*) ;
- **Public cible** (cf. `SKILL.md §4 étape 2`) ;
- **Objectif éditorial** : informer, convertir, expliquer, documenter ;
- **Niveau de profondeur** : court (300–600 mots), standard (800–1500), complet (1500–3000), expert (3000+) ;
- **Langue** (FR / EN / autre) ;
- **Contraintes** : longueur cible, style maison existant, mots-clés imposés.

**Output :** brief éditorial (cf. `templates/article-brief.template.md`).

---

## Phase 2 — Recherche d'intention

**Objectif :** comprendre **ce que l'utilisateur cherche réellement** quand il tape la requête.

Pour le mot-clé principal :

- l'intention est-elle **informationnelle**, **transactionnelle**, **comparative**, **navigationnelle**, **tutoriel**, **problème à résoudre** ?
- quel **format** est attendu ? (guide long, listicle, comparatif, vidéo + texte) ;
- quelles **questions sous-jacentes** le lecteur se pose-t-il ?
- quels sont les **angles complémentaires** que les concurrents oublient ?

Si tu as accès au web :
- **observer les 5 premiers résultats** sur la requête (sans copier) ;
- noter ce qu'ils ont **en commun** (= conventions du sujet) ;
- noter ce qui leur **manque** (= ton angle).

Si pas d'accès web :
- baser l'analyse sur les **conventions générales** du type de contenu ;
- l'indiquer clairement dans le brief.

**Output :** intention de recherche définie + angle éditorial spécifique.

---

## Phase 3 — Plan SEO

**Objectif :** poser la structure avant la rédaction.

À produire :

- **`<title>`** : 50–60 caractères, contient le mot-clé principal naturellement, donne envie de cliquer ;
- **`<meta description>`** : 130–160 caractères, résumé honnête du contenu, peut inclure un appel à la lecture ;
- **slug** : kebab-case, court, descriptif (3–5 mots) ;
- **mot-clé principal** ;
- **mots-clés secondaires** (2–4 max) ;
- **catégorie** (si CMS le demande) ;
- **tags** (3–5 max) ;
- **H1** (proche du title mais pas identique) ;
- **plan H2 / H3** logique ;
- **FAQ** prévue (3–8 questions identifiées) ;
- **liens internes** prévus (3–6) ;
- **images** prévues (1 hero + secondaires).

**Output :** outline SEO (cf. `templates/seo-outline.template.md`).

---

## Phase 4 — Sources

**Objectif :** vérifier les faits avant de les écrire.

Cf. `references/source-citation-guide.md`.

- **lister** les affirmations factuelles que l'article va contenir ;
- pour chaque : peut-elle être démontrée par une source ?
- **citer** les sources officielles en priorité ;
- **ne jamais** inventer une source ;
- si l'accès web n'est pas disponible : marquer **"à vérifier"** chaque affirmation factuelle.

**Output :** liste de sources (cf. `templates/source-list.template.md`).

---

## Phase 5 — Rédaction

**Objectif :** produire le brouillon, **section par section**.

Règles de rédaction :

- **introduction courte** (3–4 phrases) qui pose le problème et annonce ce que le lecteur va apprendre ;
- **chaque H2** traite **un** point précis ;
- **chaque H3** détaille un sous-point ;
- **chaque section explicative** contient au moins **un exemple concret** (snippet, cas d'usage chiffré, anecdote vérifiable) ;
- **pas de phrases creuses** (cf. `anti-bullshit-rules.md`) ;
- **un seul ton** sur tout l'article (cf. `tone-of-voice-guide.md`).

**Test du paragraphe transposable** : à chaque paragraphe écrit, se demander *"ce paragraphe peut-il être copié dans un autre article sur un autre sujet ?"*. Si oui, **le réécrire**.

**Output :** brouillon complet.

---

## Phase 6 — Optimisation

**Objectif :** finaliser le SEO sans dégrader la qualité éditoriale.

- vérifier la **densité** du mot-clé principal (1–2 % du texte, pas plus) ;
- vérifier que les **mots-clés secondaires** apparaissent naturellement ;
- vérifier la **structure** H1 unique, H2 logiques, H3 cohérents ;
- ajouter les **liens internes** prévus avec ancres descriptives ;
- finaliser **title** et **meta description** ;
- ajouter le **plan d'images** (cf. `image-planning-guide.md`) ;
- ajouter la **FAQ** (cf. `faq-writing-guide.md`) ;
- ajouter le **CTA** naturel ;
- ajouter les **sources**.

**Règle :** le SEO ne doit **jamais** dégrader la qualité éditoriale. Si un mot-clé sonne forcé, le retirer.

**Output :** version optimisée.

---

## Phase 7 — Relecture anti-bullshit

**Objectif :** dernière passe avant publication.

Checklist de relecture :

- [ ] aucune phrase creuse listée dans `anti-bullshit-rules.md` ;
- [ ] aucun paragraphe transposable ;
- [ ] aucune répétition (mêmes mots, mêmes phrases dans 2 sections) ;
- [ ] aucune statistique ou citation **non sourcée** ;
- [ ] introduction courte ;
- [ ] conclusion non triviale (pas un simple résumé) ;
- [ ] FAQ utile (pas artificielle) ;
- [ ] CTA naturel ;
- [ ] tous les liens internes ont une **raison** ;
- [ ] toutes les images ont un **alt text** non vide ;
- [ ] le lecteur cible peut **comprendre** dès la 1re lecture.

**Output :** version finale + score qualité éditoriale (cf. `content-quality-score.md`).

---

## Récap visuel

```txt
1. Cadrage
   ↓
2. Recherche d'intention
   ↓
3. Plan SEO
   ↓
4. Sources
   ↓
5. Rédaction
   ↓
6. Optimisation
   ↓
7. Relecture anti-bullshit
   ↓
   Livraison + score
```

**Règle d'or :** *si on saute une phase, on retombe dans le contenu IA générique.*

---

Created by João de Almeida
