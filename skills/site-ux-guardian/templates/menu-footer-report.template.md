# Menu / Footer report — {{PROJECT_NAME}}

> Rapport spécifique à la cohérence menu / footer.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Stack** : {{...}}

---

## Footers détectés

| Footer | Fichier source | Pages couvertes | Justification |
|---|---|---|---|
| Footer principal | `app/components/Footer.tsx` | toutes les pages publiques | défaut |
| Footer minimal | `app/components/FooterMinimal.tsx` | `/checkout`, `/login`, `/register` | volontaire (pas distraire pendant action critique) |
| Footer admin | (absent) | n/a | non requis (admin n'a pas besoin de footer) |

---

## Détail footer principal

### Source

`app/components/Footer.tsx`

### Structure (4 colonnes)

```
[Logo + tagline]      [Navigation]     [Contact]      [Légal]
                                                        - Mentions
- {{tagline}}          - Accueil        - email          - RGPD
                       - À propos       - téléphone      - CGV
                       - Tarifs         - adresse        - Cookies
                       - Blog
                       - Contact
                                       [Sociaux]
                                        - Twitter
                                        - LinkedIn
                                        - GitHub

[Copyright © {{année dynamique}} {{Nom}}]
```

### Vérifications

- [✓] présent sur toutes les pages publiques attendues ;
- [✓] **3+ colonnes** ;
- [✓] **liens légaux** présents ;
- [✓] **liens sociaux** fonctionnels ;
- [✓] **copyright** avec année dynamique ;
- [✓] **mobile** : colonnes empilées (2 sur tablet, 1 sur mobile) ;
- [✓] **cohérence** entre langues (fichiers traduits OK) ;
- [✓] **pas de doublons** ;
- [✓] **pas de footer différent** sans raison.

### Liens dans le footer

| # | Libellé | Route | Statut |
|---|---|---|---|
| 1 | Accueil | `/` | OK |
| 2 | À propos | `/about` | OK |
| 3 | Tarifs | `/pricing` | OK |
| 4 | Blog | `/blog` | OK |
| 5 | Contact | `/contact` | OK |
| 6 | Mentions légales | `/mentions` | OK |
| 7 | RGPD | `/rgpd` | OK |
| 8 | CGV | `/cgv` | OK |
| 9 | Twitter | https://twitter.com/... | OK (externe) |
| 10 | LinkedIn | https://linkedin.com/... | OK (externe) |
| 11 | GitHub | https://github.com/... | OK (externe) |

---

## Cohérence menu ↔ footer

| Lien menu | Présent dans footer ? |
|---|---|
| Accueil | ✓ |
| À propos | ✓ |
| Tarifs | ✓ |
| Blog | ✓ |
| Contact | ✓ |

→ **Tous** les liens du menu sont présents dans le footer. ✓

---

## Footer minimal — détail

### Source

`app/components/FooterMinimal.tsx`

### Justification

Sur les pages **checkout / login / register**, on réduit le footer pour ne pas distraire l'utilisateur pendant une action critique (conversion).

### Contenu

- copyright ;
- liens légaux (mentions, RGPD, CGV) ;
- pas de navigation, pas de sociaux.

### Vérification

- [✓] documenté (commentaire dans le composant) ;
- [✓] utilisé uniquement sur pages volontaires.

---

## Problèmes détectés

### Footer pauvre

Aucun. Le footer principal est riche (4 colonnes).

→ Si détecté, lister :

```
- Footer pauvre détecté sur : {{pages}}
- Recommandation : utiliser Footer.tsx au lieu de footer hardcodé
```

### Footers différents sans raison

Aucun.

### Liens légaux manquants

Aucun.

→ Si page légale manquante, lister :

```
- Mentions légales manquantes
- CGV manquantes alors que e-commerce
- Politique cookies manquante alors que trackers présents
```

### Copyright statique

Aucun. Année dynamique en place.

→ Si statique :
```html
<!-- ✗ Mauvais -->
<p>© 2024 Mon Site</p>

<!-- ✓ Bon -->
<p>© {{ new Date().getFullYear() }} Mon Site</p>
```

---

## Cohérence multilingue

| Langue | Fichier traduction | Liens traduits | Statut |
|---|---|---|---|
| fr | `locales/fr/footer.json` | tous | OK |
| en | `locales/en/footer.json` | tous | OK |

---

## Recommandations

### Mode 2 — Corrections sûres

- aucune nécessaire (footer cohérent).

### Mode 3 — À proposer

- {{ex: ajouter une newsletter en colonne 5 si pertinent}} ;
- {{ex: ajouter un sélecteur de langue dans le footer en plus du header}}.

---

## Score footer

**{{X / 100}}** — {{Verdict}}

| Critère | Score |
|---|---|
| Présence sur toutes les pages attendues | {{X / 20}} |
| 3+ colonnes | {{X / 15}} |
| Liens légaux complets | {{X / 15}} |
| Liens sociaux fonctionnels | {{X / 10}} |
| Copyright dynamique | {{X / 10}} |
| Mobile lisible | {{X / 10}} |
| Cohérence multilingue | {{X / 10}} |
| Pas de doublons | {{X / 10}} |

---

## Prochaine étape

> {{Une phrase actionnable.}}

---

Created by João de Almeida
