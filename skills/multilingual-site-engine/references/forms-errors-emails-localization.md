# Guide localisation formulaires / erreurs / emails — `multilingual-site-engine`

Comment traiter les zones les plus oubliées d'un site multilingue.

Created by João de Almeida

---

## 1. Pourquoi ces zones sont oubliées

Les **textes visibles** d'un site (pages, menus, footers) sont souvent traduits. Ce qui reste régulièrement en langue source :

- **labels** de formulaires ;
- **placeholders** ;
- **messages d'erreur** (champ requis, format invalide, mot de passe trop court) ;
- **messages de succès** ;
- **emails transactionnels** (welcome, reset password, invoice, notification) ;
- **emails marketing** (newsletter, drip campaign) ;
- **notifications** (push, in-app, snackbar) ;
- **erreurs API** exposées à l'utilisateur ;
- **bots / chatbots** (réponses pré-écrites) ;
- **microcopies** (tooltips, badges, états vides).

Un site dont tout le contenu est traduit **sauf** les emails transactionnels casse l'expérience.

---

## 2. Formulaires

### 2.1 Éléments à traduire

| Élément | Exemple FR | Exemple EN |
|---|---|---|
| **Titre formulaire** | *"Créer un compte"* | *"Create an account"* |
| **Description** | *"Quelques secondes suffisent."* | *"Takes just a few seconds."* |
| **Labels** | *"Adresse e-mail"* | *"Email address"* |
| **Placeholders** | *"votre@email.com"* | *"you@email.com"* |
| **Aide contextuelle** | *"Utilisé uniquement pour la connexion."* | *"Only used for login."* |
| **Bouton submit** | *"Créer mon compte"* | *"Sign up"* |
| **Bouton cancel** | *"Annuler"* | *"Cancel"* |
| **Liens conditions** | *"En continuant, vous acceptez nos CGV."* | *"By continuing, you accept our Terms."* |

### 2.2 Validation côté client

Erreurs typiques à traduire :

- *"Ce champ est requis"* / *"This field is required"* ;
- *"Format d'e-mail invalide"* / *"Invalid email format"* ;
- *"Le mot de passe doit contenir au moins 8 caractères"* / *"Password must contain at least 8 characters"* ;
- *"Les mots de passe ne correspondent pas"* / *"Passwords don't match"* ;
- *"Numéro de téléphone invalide"* / *"Invalid phone number"* ;
- *"La date est invalide"* / *"Invalid date"*.

### 2.3 Validation côté serveur

Erreurs renvoyées par l'API (à traduire si exposées au front) :

- *"Cet e-mail est déjà utilisé"* ;
- *"Le mot de passe a déjà été utilisé"* ;
- *"Le code de vérification a expiré"* ;
- *"Captcha invalide"* ;
- *"Trop de tentatives, réessayez dans X minutes"*.

### 2.4 Messages de succès

- *"Compte créé avec succès"* / *"Account created"* ;
- *"E-mail de confirmation envoyé"* / *"Confirmation email sent"* ;
- *"Vos modifications sont enregistrées"* / *"Your changes are saved"*.

### 2.5 Pièges

- formulaires construits avec des **libellés hardcodés** (`<label>Email</label>` dans le JSX) ;
- placeholders **non traduits** parce qu'oubliés ;
- erreurs **côté serveur** affichées brutes (en EN) sur l'UI traduite ;
- messages de **rate limiting** non traduits (et pourtant visibles à l'utilisateur).

---

## 3. Emails transactionnels

### 3.1 Liste d'emails à traduire

- **welcome** (bienvenue / création de compte) ;
- **email verification** (confirmer l'adresse) ;
- **password reset** ;
- **MFA / 2FA** (code envoyé) ;
- **invoice / receipt** ;
- **subscription** (renouvellement, expiration, échec de paiement) ;
- **notification** (nouvelle activité, mention, message) ;
- **comment / reply** ;
- **invitation** (rejoindre une équipe) ;
- **expiration** (essai gratuit qui se termine) ;
- **cancelation** ;
- **legal updates** (changement CGV / privacy).

### 3.2 Composants d'un email à traduire

| Élément | À traduire |
|---|---|
| **Sujet** | oui |
| **Préheader** (preview text) | oui |
| **Salutation** (*"Bonjour {name}"*) | oui |
| **Corps** | oui |
| **CTA** | oui |
| **Footer** (mentions, désinscription, adresse) | oui |
| **Logo / branding** | non |
| **Liens sociaux** | URLs non, libellés oui |

### 3.3 Stratégie de fichiers

Approche typique :

```
emails/
├── fr/
│   ├── welcome.html
│   ├── reset-password.html
│   ├── invoice.html
│   └── ...
└── en/
    └── (mêmes fichiers)
```

Ou avec un système type MJML / Handlebars + variables i18n.

### 3.4 Choix de la langue de l'email

Trois approches :

1. **langue du compte** — l'utilisateur a choisi sa langue lors de l'inscription, tous les emails dans cette langue ;
2. **langue de la dernière session** — moins fiable mais simple ;
3. **langue par défaut** + **lien vers la version traduite** dans l'email.

→ La 1re est la plus propre.

### 3.5 Test des emails

- envoyer chaque email en **chaque langue** ;
- vérifier le **rendu** (Litmus, Email on Acid, Mailtrap) ;
- vérifier la **longueur du sujet** (les variantes longues coupent dans la liste de mails) ;
- vérifier les **CTA** (boutons ne débordent pas) ;
- vérifier le **lien désinscription** (obligatoire).

---

## 4. Notifications

### 4.1 Push (mobile / web)

- titre traduit ;
- corps traduit ;
- action (deep link) cohérente avec la langue de l'app.

### 4.2 In-app

- snackbars / toasts traduits ;
- modaux traduits ;
- bannières traduites.

### 4.3 SMS

- contenu traduit ;
- attention à la longueur (160 caractères).

---

## 5. Microcopies

### 5.1 Tooltips

Aide contextuelle au survol. Traduire **toutes**.

### 5.2 Breadcrumbs

`Accueil > Services > Conseil` ↔ `Home > Services > Consulting`.

### 5.3 États vides

- *"Aucune commande pour le moment"* ;
- *"Pas de message"* ;
- *"Liste vide"*.

### 5.4 Loaders

- *"Chargement..."* / *"Loading..."*.

### 5.5 Pages d'erreur

- 404 traduite par langue ;
- 500 traduite par langue ;
- maintenance traduite par langue.

---

## 6. Variables dans les chaînes

Cf. `translation-quality-guide.md`.

```json
// EN
"welcome_email_subject": "Welcome, {name}!",
"items_count": "{count, plural, =0 {No items} one {# item} other {# items}}"

// FR (correct)
"welcome_email_subject": "Bienvenue, {name} !",
"items_count": "{count, plural, =0 {Aucun article} one {# article} other {# articles}}"
```

Variables **identiques** dans toutes les langues. Pluriels gérés par la langue.

---

## 7. Erreurs API exposées

Si l'API renvoie des erreurs **textuelles** affichées à l'utilisateur, il faut :

- soit **traduire côté front** (mapping code d'erreur → message localisé) ;
- soit **renvoyer côté serveur** un message dans la langue de l'utilisateur (en passant la locale dans le header `Accept-Language`).

L'option 1 est plus contrôlée.

```ts
const errorMessages = {
  AUTH_INVALID_CREDENTIALS: t('errors.invalid_credentials'),
  AUTH_RATE_LIMIT: t('errors.rate_limit'),
  // ...
};
```

---

## 8. Anti-patterns

- email *welcome* en français pour un user EN ;
- erreur API *"Internal server error"* affichée brute à l'utilisateur français ;
- formulaire avec labels traduits mais placeholders en EN ;
- newsletter dont le footer (désinscription, adresse postale) reste en source ;
- bot chat qui répond en EN à un user FR ;
- notification push *"You got a message"* envoyée à un user FR ;
- modal de confirmation *"Are you sure?"* dans une UI traduite.

---

## 9. Checklist formulaires / erreurs / emails

### Formulaires
- [ ] tous les labels traduits ;
- [ ] tous les placeholders traduits ;
- [ ] aide contextuelle traduite ;
- [ ] boutons traduits ;
- [ ] erreurs validation client traduites ;
- [ ] erreurs validation serveur traduites ;
- [ ] messages succès traduits.

### Emails
- [ ] sujet traduit ;
- [ ] préheader traduit ;
- [ ] corps traduit ;
- [ ] CTA traduit ;
- [ ] footer email traduit (désinscription, adresse) ;
- [ ] gabarit par langue ;
- [ ] choix de la langue de l'email documenté.

### Notifications
- [ ] push traduit ;
- [ ] in-app (toast, modal) traduit ;
- [ ] SMS traduit (si applicable).

### Microcopies
- [ ] tooltips traduits ;
- [ ] breadcrumbs traduits ;
- [ ] états vides traduits ;
- [ ] loaders traduits ;
- [ ] erreurs (404, 500) traduites par langue.

---

Created by João de Almeida
