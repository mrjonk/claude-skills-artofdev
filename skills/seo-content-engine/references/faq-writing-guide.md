# Guide de rédaction de FAQ — `seo-content-engine`

Comment écrire une FAQ **utile** et pas une FAQ **artificielle**.

Created by João de Almeida

---

## 1. Pourquoi une FAQ

- **SEO** : Google met les FAQ en avant dans les SERPs (rich results, People Also Ask).
- **UX** : le lecteur trouve une réponse rapide sans relire l'article.
- **Conversion** : traite les **objections** courantes.
- **Documentation** : réduit les questions répétées au support.

---

## 2. Quand mettre une FAQ

### Toujours pertinent

- **page produit** / page service (objections clients) ;
- **tutoriel** complexe (questions pratiques) ;
- **guide débutant** (questions sur les bases) ;
- **comparatif** (questions sur les critères) ;
- **article SaaS** orienté décision ;
- **page pricing**.

### Optionnel

- **article éditorial / opinion** (FAQ moins naturelle) ;
- **article très court** (< 600 mots — la FAQ devient disproportionnée).

---

## 3. Comment trouver les bonnes questions

### Sources réelles (à privilégier)

1. **Support / SAV** — questions vraiment posées.
2. **Forums** : Reddit (sub correspondant), Stack Overflow, Hacker News, Discord communautaires.
3. **Google "People Also Ask"** sur le mot-clé principal.
4. **Suggestions Google** (autocomplete).
5. **Questions de l'équipe commerciale** (objections récurrentes).
6. **AnswerThePublic.com** ou outils similaires.
7. **Reviews / commentaires** sur le produit ou les concurrents.

### Sources artificielles (à éviter)

- ❌ inventer des questions "logiques".
- ❌ reformuler 5 fois la même question.
- ❌ poser des questions auxquelles l'article répond déjà littéralement.
- ❌ créer des questions juste pour caser des mots-clés.

---

## 4. Combien de questions

| Type d'article | Nombre de questions FAQ |
|---|---|
| Article court (< 800 mots) | 0–3 |
| Article standard (800–1500) | 3–5 |
| Guide complet (1500–3000) | 5–8 |
| Pilier / référence (> 3000) | 8–12 |
| FAQ standalone | 10–25 (groupées par catégories) |

**Règle** : plus de 12 questions dans une FAQ d'article = la FAQ devrait être une **page standalone**.

---

## 5. Structure d'une question

### Question

- **commence** par un mot interrogatif explicite : *"Comment..."*, *"Pourquoi..."*, *"Quel..."*, *"Est-ce que..."*, *"Quand..."* ;
- **formulée** comme la poserait un utilisateur (pas comme un titre marketing) ;
- **courte** (≤ 100 caractères) ;
- **uniques** (pas de variations cosmétiques) ;
- en **français correct** (pas de "tu" sauf si le ton du site le permet).

### Réponse

- **claire** ;
- **autonome** (lisible sans avoir lu l'article) ;
- **2 à 5 phrases** typiquement ;
- **pas de "ça dépend"** sans précision (si ça dépend, expliquer **de quoi**) ;
- **pas de redirection** systématique vers l'article (sauf si vraiment trop complexe).

---

## 6. FAQ artificielle vs FAQ utile — exemples

### Sur un article "Comment installer Next.js"

#### Mauvaises questions (artificielles)

- ❌ *"Qu'est-ce que Next.js ?"* — l'article doit déjà répondre à ça.
- ❌ *"Pourquoi utiliser Next.js ?"* — vague, pas une question pratique.
- ❌ *"Next.js est-il bon ?"* — opinion non factuelle.
- ❌ *"Comment installer Next.js facilement ?"* — variante de la question principale.

#### Bonnes questions (utiles)

- ✅ *"Quelle version de Node.js est requise pour Next.js ?"*
- ✅ *"Comment résoudre l'erreur 'Cannot find module' après install ?"*
- ✅ *"Faut-il installer TypeScript séparément ou est-ce automatique ?"*
- ✅ *"Comment utiliser un proxy npm derrière un firewall d'entreprise ?"*

→ Ces questions sont **précises**, **techniques**, **réellement** posées par les développeurs.

---

## 7. Format SEO de la FAQ

### Markdown standard

```markdown
## FAQ

### Quelle version de Node.js est requise pour Next.js ?

Next.js 14+ nécessite Node.js 18.17 ou supérieur. Versions antérieures non supportées
officiellement.

### Comment résoudre l'erreur "Cannot find module" après install ?

Cette erreur survient généralement après un changement de version Node. Supprimez
`node_modules` et `package-lock.json`, puis relancez `npm install`.
```

### Schema.org `FAQPage` (à activer côté CMS)

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [{
    "@type": "Question",
    "name": "Quelle version de Node.js est requise pour Next.js ?",
    "acceptedAnswer": {
      "@type": "Answer",
      "text": "Next.js 14+ nécessite Node.js 18.17 ou supérieur. ..."
    }
  }]
}
</script>
```

La plupart des plugins SEO (Yoast, Rank Math) génèrent automatiquement ce balisage si la FAQ est marquée correctement (blocs FAQ Gutenberg, par exemple).

---

## 8. Catégorisation (FAQ standalone)

Pour une FAQ longue (> 8 questions), regrouper :

```markdown
## FAQ

### Concepts / définitions

#### Question 1
Réponse.

#### Question 2
Réponse.

### Mise en place

#### Question 3
…

### Dépannage

#### Question N
…
```

Catégories courantes : **concepts**, **installation**, **utilisation**, **configuration**, **dépannage**, **sécurité**, **prix / abonnement**, **support**.

---

## 9. Anti-patterns

### "FAQ pour faire long"

Ajouter 10 questions creuses pour atteindre une longueur d'article. **Signal IA** classique.

### Questions répétées

- *"Comment installer X ?"*
- *"Quelle est la procédure d'installation de X ?"*
- *"Comment mettre en place X ?"*

→ Ces 3 questions sont **la même**. Garder **une seule** version.

### Réponses qui bottent en touche

- ❌ *"Cela dépend de votre cas."*
- ❌ *"Consultez la documentation officielle."*
- ❌ *"Référez-vous à votre administrateur système."*

→ Si la réponse est *"ça dépend"*, **expliquer** : *de quoi* ça dépend, **quels** sont les cas typiques, **comment** décider.

### Réponses trop longues

Si une question demande 8 paragraphes de réponse → c'est probablement une **section entière** de l'article, pas une question FAQ. La FAQ traite les questions auxquelles on peut répondre **brièvement**.

### Tone marketing dans la FAQ

- ❌ *"Notre solution est conçue pour répondre à toutes vos attentes !"*
- ❌ *"Avec X, vous bénéficiez d'une expérience inégalée !"*

→ La FAQ est un espace **factuel**, pas un argumentaire commercial.

---

## 10. Format de sortie attendu

Dans le brief éditorial (avant rédaction) :

```markdown
## FAQ prévue

| # | Question | Source de la question | Réponse synthétique |
|---|---|---|---|
| 1 | Quelle version de Node.js est requise pour Next.js ? | Stack Overflow | Node 18.17+ |
| 2 | Comment résoudre "Cannot find module" ? | issue GitHub commune | nettoyer node_modules + relock |
| 3 | TypeScript automatique ou séparé ? | Reddit r/nextjs | automatique depuis 12+ |
```

Dans l'article final :

```markdown
## FAQ

### Quelle version de Node.js est requise pour Next.js ?
Next.js 14+ nécessite Node.js 18.17 ou supérieur (cf. [doc officielle](URL)).

### Comment résoudre l'erreur "Cannot find module" ?
Supprimez `node_modules` et `package-lock.json`, puis relancez `npm install`.
Cette erreur survient souvent après un changement de version Node.

### TypeScript est-il automatiquement installé ?
Depuis Next.js 12+, oui. Lancez le projet et Next.js détecte un fichier `.ts`
puis propose d'installer les dépendances TypeScript automatiquement.
```

---

## 11. Checklist FAQ (relecture finale)

- [ ] **3 à 8 questions** pour un article standard ;
- [ ] questions **réellement** posées (sources : forum, support, PAA) ;
- [ ] aucune question **redondante** avec le corps de l'article ;
- [ ] aucune **variation** cosmétique de la même question ;
- [ ] réponses **claires** et **autonomes** ;
- [ ] pas de **"ça dépend"** sans précision ;
- [ ] pas de **tone marketing** ;
- [ ] **Schema.org `FAQPage`** activé côté CMS si applicable.

---

Created by João de Almeida
