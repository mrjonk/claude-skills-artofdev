# Duplicate report — {{PROJECT_NAME}}

> Rapport sur les doublons détectés.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Stack** : {{...}}

---

## Résumé

- **Composants doublonnés** : {{N}}
- **Pages doublons** : {{N}}
- **Menus / footers hardcodés** : {{N fichiers}}
- **Routes concurrentes** : {{N}}
- **Fichiers obsolètes** (`.bak`, `*-old`, `*-copy`) : {{N}}

---

## 1. Composants doublonnés

| Type | Fichier 1 | Fichier 2 | Fichier 3 | Recommandation |
|---|---|---|---|---|
| Header | `app/components/Header.tsx` | `app/components/HeaderV2.tsx` | — | identifier le canonique, migrer les usages, supprimer après validation |
| Footer | `app/components/Footer.tsx` | `app/components/FooterNew.tsx` | — | comparer les 2 versions, choisir la définitive |
| Card produit | `app/components/ProductCard.tsx` | `app/components/Card.tsx` | `app/components/ItemCard.tsx` | consolider en un seul `Card` avec props variant |

---

## 2. Pages doublons

| Page 1 | Page 2 | Contenu | Recommandation |
|---|---|---|---|
| `/about` | `/about-us` | identique à 90 % | redirection 301 vers `/about` |
| `/contact` | `/nous-contacter` | identique | redirection 301 vers `/contact` |
| `/services` | `/services/all` | similaires | merger en `/services` |

---

## 3. Menus / footers hardcodés

### Menus hardcodés

| Fichier | Lignes du menu | Recommandation |
|---|---|---|
| `pages/old-home.html` | 120-145 | extraire dans composant partagé |
| `pages/contact.html` | 80-105 | utiliser le composant partagé existant |
| `pages/services/index.html` | 95-120 | utiliser le composant partagé |

→ Plan de migration phasé recommandé. Voir `templates/file-change-plan.template.md`.

### Footers hardcodés

| Fichier | Lignes | Recommandation |
|---|---|---|
| `pages/legacy.html` | 250-310 | utiliser composant Footer partagé |

---

## 4. Routes concurrentes

| Route 1 | Route 2 | Statut | Recommandation |
|---|---|---|---|
| `/about` | `/about-us` | les deux fonctionnelles | choisir canonique, redirection 301 |
| `/blog` | `/blogs` | les deux fonctionnelles | merger |
| `/products/all` | `/catalog` | les deux fonctionnelles | refonte non finie, demander à l'utilisateur |

---

## 5. Fichiers obsolètes

| Fichier | Type | Date dernière modif | Recommandation |
|---|---|---|---|
| `Footer.bak.php` | sauvegarde | 6 mois | demander si à supprimer |
| `index-old.html` | page legacy | 1 an | supprimer ou rediriger |
| `style-v2.css` | css legacy | 3 mois | vérifier qu'il n'est plus chargé |
| `script.min.js.bak` | sauvegarde | 1 an | supprimer |
| `header-final-final-2.tsx` | composant | 2 mois | choisir la version canonique |

---

## 6. Doublons CSS

| Variable / règle | Fichiers | Valeurs |
|---|---|---|
| `--primary` | `style.css`, `theme.css` | `#1e40af` vs `#2563eb` |
| `.btn-primary` | `style.css:120`, `components.css:45` | définitions divergentes |

→ Recommandation : centraliser les tokens dans un seul fichier (`tokens.css` ou `tailwind.config.js`).

---

## 7. Logique dupliquée

| Pattern | Fichiers | Recommandation |
|---|---|---|
| `formatDate()` | 5 fichiers différents | extraire dans `lib/utils/date.ts` |
| Validation email regex | 3 fichiers | extraire dans `lib/validators/email.ts` |
| Appel API Stripe | 4 endroits | extraire dans `services/stripe.ts` |

---

## Plan de consolidation (par ordre de priorité)

### Phase 1 — Bloquants (priorité 1)

- [ ] consolider les **routes concurrentes** (rediriger `/about-us` vers `/about`) ;
- [ ] supprimer les **fichiers `.bak`** validés (avec accord) ;
- [ ] **désactiver** les chargements CSS legacy (`style-v2.css`).

### Phase 2 — Refactoring (priorité 2)

- [ ] consolider les **composants Header / Footer** ;
- [ ] **migrer** les pages avec menu hardcodé vers le composant partagé ;
- [ ] **centraliser** les tokens CSS.

### Phase 3 — Nettoyage (priorité 3)

- [ ] **extraire** les utilitaires dupliqués (`formatDate`, validators) ;
- [ ] **supprimer** les fichiers obsolètes (avec accord) ;
- [ ] **simplifier** les routes (merger `/services/all` dans `/services`).

---

## Règles d'or

- **ne jamais supprimer** un doublon avant d'avoir vérifié qu'il n'est plus utilisé ;
- **migrer une utilisation à la fois** (jamais en bloc) ;
- **valider à chaque étape** avant de passer à la suivante ;
- **tester** après chaque migration.

---

## Prochaine étape

> {{Une phrase actionnable. Ex: "Démarrer Phase 1 — supprimer les fichiers .bak après validation utilisateur."}}

---

Created by João de Almeida
