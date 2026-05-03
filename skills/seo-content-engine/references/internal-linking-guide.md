# Guide des liens internes — `seo-content-engine`

Comment construire un maillage interne **utile** pour le lecteur, **propre** pour le SEO.

Created by João de Almeida

---

## 1. Pourquoi les liens internes comptent

- **SEO** : ils distribuent le link juice et signalent les relations entre les pages.
- **UX** : ils permettent au lecteur de continuer sa lecture sur des pages connexes.
- **Conversion** : ils peuvent guider vers une page de fonds (pricing, démo, doc).
- **Architecture** : ils renforcent la structure thématique du site (clusters).

---

## 2. Combien de liens par article

- **Minimum** : 2–3 (sauf article très court ou page atomique) ;
- **Cible standard** : **3 à 6** par article ;
- **Maximum** : **8** (au-delà, c'est du bourrage et l'utilisateur décroche).

Un article qui parle d'un sujet spécifique a généralement 3–4 liens internes naturels qui s'imposent. Si tu en mets 10, tu en inventes.

---

## 3. Comment choisir les liens

### Principe d'utilité

Pour chaque lien, demande-toi : **le lecteur a-t-il besoin de cette ressource pour avancer dans sa compréhension ou son action ?**

Si la réponse est non → le lien est **du bourrage SEO** et nuit à l'expérience.

### Types de pages à lier

| Type | Quand |
|---|---|
| **Page d'accueil** | rare — uniquement si pertinent (plutôt en menu/footer) |
| **Page service** | quand le service est directement lié au sujet |
| **Page produit** | quand l'article démontre un cas d'usage du produit |
| **Documentation** | tutoriel, article technique, référence à une fonctionnalité |
| **Autre article de blog** | sujet **adjacent** ou **prérequis** ou **suite logique** |
| **Guide complet** | l'article est un sous-thème d'un guide pilier |
| **Page contact** | si le lecteur peut avoir besoin de poser une question |
| **Démo** | article SaaS / page produit |
| **Pricing** | si conversion attendue |
| **FAQ** | si l'article génère beaucoup de questions |
| **Étude de cas** | preuve sociale dans un article SaaS |

---

## 4. Comment écrire les ancres

### Bonnes ancres

- **descriptives** (le lecteur comprend où il va) ;
- **naturelles** (s'intègrent dans la phrase) ;
- **incluent** le mot-clé de la page cible quand c'est naturel ;
- **uniques** (pas la même ancre pour 2 liens différents).

**Exemples :**

- ✅ *"Voir notre guide complet sur le SEO technique"*
- ✅ *"La documentation officielle de Next.js"* (lien vers la doc)
- ✅ *"Notre étude de cas avec l'équipe produit de X"*

### Mauvaises ancres

- *"cliquez ici"* — pas descriptif, mauvais SEO ;
- *"en savoir plus"* — vague ;
- *"ici"* — vide ;
- ancre trop longue (toute la phrase soulignée) ;
- ancre **bourrée de mots-clés** (*"SEO blog référencement Google optimisation"*).

---

## 5. Documentation des liens (template à remplir)

Pour chaque lien interne proposé, remplir :

```markdown
| # | Type de page | URL ou slug | Ancre suggérée | Raison du lien | Statut |
|---|---|---|---|---|---|
| 1 | guide complet | /blog/guide-seo-technique | "guide complet sur le SEO technique" | le lecteur de cet article a probablement besoin du guide pilier en complément | OK |
| 2 | page service | /services/audit-seo | "demander un audit SEO" | l'article identifie des problèmes que le service résout | à créer |
| 3 | autre article | /blog/checklist-content | "checklist contenu publiable" | suite logique pour passer à l'action | OK |
```

Si la page n'existe pas (`Statut: à créer`), c'est un **signal de planning éditorial** : la page doit être créée pour que le maillage soit complet.

---

## 6. Anti-patterns

### Bourrage de liens internes

Plus de 8 liens internes dans un article standard → bourrage.

**Symptômes :**
- chaque paragraphe a un ou deux liens ;
- liens vers des pages **non pertinentes** (juste pour caser une cible SEO) ;
- ancres **identiques** répétées ;
- mots-clés sur-soulignés.

**Conséquence :** le lecteur ne sait plus où cliquer, le SEO se dilue.

### Lien vers la même page plusieurs fois

Un même article ne devrait pas linker **2 fois** vers la même page sauf cas très précis (lien dans le corps + lien dans le CTA).

### Lien dans le titre H1

**Jamais.** Le H1 est le titre de la page, pas un lien.

### Lien sortant déguisé en lien interne

Si tu mentionnes un produit / service externe, lie vers leur page **externe**, pas vers ta propre page interne qui en parle vaguement (sauf si la page interne apporte vraiment quelque chose).

---

## 7. Liens externes — note

Ce skill se concentre sur le maillage **interne**. Les liens **externes** suivent leurs propres règles :

- toujours `target="_blank" rel="noopener noreferrer"` ;
- `nofollow` si lien commercial / sponsorisé ;
- privilégier les sources **officielles** ;
- éviter de linker vers des concurrents en `dofollow` (mais ne pas mentir : si tu compares, tu cites).

---

## 8. Checklist liens internes (relecture finale)

- [ ] **3 à 6** liens internes (max 8) ;
- [ ] chaque lien **sert le lecteur** (pas du bourrage) ;
- [ ] ancres **descriptives** ;
- [ ] ancres **uniques** ;
- [ ] aucune ancre *"cliquez ici"* / *"en savoir plus"* sans contexte ;
- [ ] aucun lien dans le **H1** ;
- [ ] aucune duplication de lien vers la même URL ;
- [ ] **statut** des pages cibles vérifié (pas de lien vers une 404 prévisible) ;
- [ ] section **"Pour aller plus loin"** en fin d'article qui regroupe les liens principaux.

---

## 9. Format de sortie attendu

Dans la section **"Pour aller plus loin"** de l'article :

```markdown
## Pour aller plus loin

- [Guide complet du SEO technique](/blog/guide-seo-technique) — référence si vous voulez approfondir le sujet.
- [Notre service d'audit SEO](/services/audit-seo) — pour faire vérifier votre site par un humain.
- [Checklist contenu publiable](/blog/checklist-content) — étape suivante après ce guide.
```

Et dans le **brief éditorial** (avant rédaction) :

```markdown
## Liens internes prévus

| # | Slug cible | Ancre | Raison | Statut |
|---|---|---|---|---|
| 1 | /blog/guide-seo-technique | "guide complet du SEO technique" | référence pilier | OK |
| 2 | /services/audit-seo | "service d'audit SEO" | conversion possible | à créer |
| 3 | /blog/checklist-content | "checklist contenu publiable" | suite logique | OK |
```

---

Created by João de Almeida
