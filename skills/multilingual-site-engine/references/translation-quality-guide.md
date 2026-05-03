# Guide qualité de traduction — `multilingual-site-engine`

Critères et règles pour produire une traduction **naturelle**, pas littérale.

Created by João de Almeida

---

## 1. Le piège du littéralisme

Une traduction littérale est :

- techniquement correcte ;
- grammaticalement valide ;
- **mais** sonne artificielle pour un natif.

Exemples de littéralisme à éviter :

| Source EN | Littéral FR | Naturel FR |
|---|---|---|
| *"Get started"* | *"Obtenez commencé"* | *"Commencer"* / *"Démarrer"* |
| *"Sign up for free"* | *"Inscrivez-vous pour gratuit"* | *"Créer un compte gratuit"* |
| *"Learn more"* | *"Apprenez plus"* | *"En savoir plus"* |
| *"Reach out to us"* | *"Tendez la main à nous"* | *"Nous contacter"* |
| *"You're all set"* | *"Vous êtes tout réglé"* | *"C'est prêt"* / *"Tout est configuré"* |
| *"Coming soon"* | *"Venant bientôt"* | *"Bientôt disponible"* |
| *"Drop us a line"* | *"Laissez-nous tomber une ligne"* | *"Écrivez-nous"* |

Une bonne traduction part du **sens**, pas des mots.

---

## 2. Adapter au registre UI

Une UI a son propre registre, différent d'un article ou d'une conversation :

- **boutons** : 1 à 3 mots, infinitif ou substantif (FR : *"Enregistrer"*, *"Modifier"*) ;
- **labels de formulaire** : 1 à 4 mots, neutre (*"Adresse e-mail"*, *"Mot de passe"*) ;
- **erreurs** : claires, actionnables (*"Le mot de passe doit contenir au moins 8 caractères"*) ;
- **messages de succès** : courts, positifs (*"Modifications enregistrées"*) ;
- **placeholders** : exemple ou indication (*"votre@email.com"*) ;
- **tooltips** : explication brève (*"Visible uniquement par toi"*) ;
- **états vides** : ton encourageant (*"Aucune commande pour le moment"*).

---

## 3. Cohérence terminologique

### Règle d'or

Si tu traduis *"cart"* par *"panier"* une fois, **toujours** *"panier"*. Pas alterner avec *"caddie"*, *"sélection"*, *"corbeille"*.

### Comment l'appliquer

- **glossaire** par projet (cf. `templates/translation-brief.template.md`) ;
- liste des termes clés et leur traduction validée ;
- relecture rapide pour repérer les variantes sauvages.

### Termes à fixer dès le début

- éléments d'UI : login / log out / sign up / sign in / dashboard / settings / profile / account / inbox / notifications ;
- e-commerce : cart / checkout / order / payment / shipping / refund / coupon ;
- SaaS : workspace / team / member / role / permission / billing / plan / invoice ;
- contenu : article / post / category / tag / author / comment.

---

## 4. Préservation des variables

Liste exhaustive (cf. `multilingual-methodology.md`) :

| Pattern | À ne **jamais** traduire |
|---|---|
| `{name}` | i18next |
| `{{count}}` | Vue / Mustache |
| `%s`, `%d`, `%1$s` | gettext / printf |
| `:user`, `:count` | Laravel |
| `${var}` | template literals |
| `<0>...</0>` | Trans component |
| `[link]...[/link]` | BBCode |
| `<strong>...</strong>` | balises HTML |

Exemple :

```json
// EN
"welcome": "Welcome back, {name}!",

// FR (correct)
"welcome": "Bon retour, {name} !",

// FR (faux — variable cassée)
"welcome": "Bon retour, {nom} !"
```

---

## 5. Gestion des pluriels

### ICU MessageFormat (recommandé)

```json
{
  "items": "{count, plural, =0 {Aucun article} =1 {Un article} other {# articles}}"
}
```

### i18next plurals

```json
{
  "items_zero": "Aucun article",
  "items_one": "Un article",
  "items_other": "{{count}} articles"
}
```

### Pièges

- l'anglais a 2 formes (1 vs autre) ;
- le français a 2 formes (≤ 1 vs > 1) ;
- l'arabe a 6 formes (zero, one, two, few, many, other) ;
- le russe a 4 formes ;
- le japonais a 1 forme.

Une traduction i18n pro **gère ces variations**, pas juste *"1 item / X items"*.

---

## 6. Adaptation culturelle

### Idiomes
- *"It's raining cats and dogs"* → *"Il pleut des cordes"* (pas *"Il pleut des chats et des chiens"*).
- *"Break a leg"* → *"Bonne chance"* / *"Merde"* (théâtre).
- *"Once in a blue moon"* → *"Très rarement"* / *"Tous les 36 du mois"*.

### Humour
- l'humour anglo-saxon ne traverse pas toujours ;
- préférer un ton **neutre** dans une UI, sauf si la marque a une voix forte assumée.

### CTA
- *"Buy now"* → *"Acheter"* / *"Commander"* (FR souvent moins direct) ;
- *"Try for free"* → *"Essayer gratuitement"* ;
- *"Get the app"* → *"Télécharger l'app"*.

### Mesures
- imperial → métrique (miles → km, pounds → kg, °F → °C) ;
- monnaies (USD → EUR, GBP, CHF selon contexte).

### Adresses et noms
- ordre **prénom + nom** vs **nom + prénom** (Asie de l'Est) ;
- formats de code postal ;
- préfixes téléphoniques internationaux.

---

## 7. Ne pas traduire

| Catégorie | Exemples |
|---|---|
| Noms propres | Apple, Google, Microsoft |
| Marques internes | nom du produit, nom de la société |
| Commandes / codes | `npm install`, `git commit`, `SELECT *` |
| Classes CSS / IDs | `.btn-primary`, `#header` |
| Clés JSON | `"home_title"` reste `"home_title"` |
| Variables | `{name}`, `%s` |
| Slogans signature | si la marque les utilise tels quels à l'international |
| Citations originales | sauf si demande explicite + mention de la version originale |

---

## 8. Signaux de mauvaise traduction

À détecter en relecture :

- **calques** (anglicismes involontaires : *"opportunité"* pour *"opportunity"* alors que *"occasion"* serait plus naturel) ;
- **traductions automatiques visibles** (Google Translate sent à plein nez) ;
- **incohérence terminologique** (*"panier"* puis *"caddie"* dans la même page) ;
- **variables cassées** (`{name}` traduit en `{nom}`) ;
- **ponctuation incorrecte** (espace insécable manquant en FR avant ! ? : ;) ;
- **majuscules incorrectes** (titres à l'anglaise gardés à l'anglaise alors qu'en FR seule la première lettre est en majuscule) ;
- **textes coupés** dans les boutons (UI cassée par traduction trop longue) ;
- **idiomes mal rendus** ;
- **registre incohérent** (tutoiement / vouvoiement qui change en cours de page).

---

## 9. Tutoiement vs vouvoiement (FR)

| Contexte | Choix |
|---|---|
| Produit grand public, jeune, social | tutoiement (*"Crée ton compte"*) |
| Produit pro, B2B, corporate | vouvoiement (*"Créez votre compte"*) |
| SaaS productivité (Notion, Slack-like) | tutoiement |
| Banque, assurance, juridique | vouvoiement |
| Site associatif | dépend du ton de la marque |

**Règle :** un seul choix par site. Pas alterner.

---

## 10. Score qualité de traduction (rappel)

Cf. `SKILL.md §15.1`.

Critères pondérés :

| Critère | Poids |
|---|---|
| Fidélité au sens | 18 |
| Naturel | 16 |
| Adaptation culturelle | 12 |
| Préservation des variables | 12 |
| Cohérence terminologique | 10 |
| Adaptation au registre UI | 8 |
| Absence de style IA | 10 |
| Ponctuation locale | 6 |
| Pas de fautes | 8 |

---

## 11. Relecture finale

Avant de livrer une traduction :

- [ ] tester l'UI avec la nouvelle langue (rien ne déborde) ;
- [ ] tester les **pluriels** ;
- [ ] tester les **variables** (`{name}`, `%s`) avec des valeurs réelles ;
- [ ] vérifier les **espaces insécables** (FR) ;
- [ ] vérifier la **cohérence** terminologique ;
- [ ] vérifier le **tutoiement / vouvoiement** ;
- [ ] passer une **relecture** par un natif si possible ;
- [ ] mesurer la **longueur** vs source (langues comme l'allemand prennent +30 % de place).

---

Created by João de Almeida
