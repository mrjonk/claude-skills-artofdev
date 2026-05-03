# Guide de réutilisation de composants — `site-ux-guardian`

Quand créer un composant partagé, quand modifier un composant existant, comment éviter le copier-coller.

Created by João de Almeida

---

## 1. Quand créer un composant partagé

Critères pour **extraire** un composant :

- la même structure HTML / JSX apparaît **3 fois ou plus** ;
- la structure a une **logique** propre (état interne, événements, props) ;
- la structure est **susceptible d'évoluer** (un changement doit s'appliquer partout) ;
- la structure est **identifiable** par son rôle (Header, Card, Button, FormField).

**Règle des 3** : si on copie-colle 3 fois, c'est un composant.

### Exemples qui méritent un composant

- header / footer du site ;
- card produit ;
- card testimonial ;
- bouton CTA primaire ;
- champ de formulaire avec label + input + error ;
- modal / dialog ;
- toast / notification ;
- table avec pagination.

### Exemples qui ne méritent **pas** un composant

- un titre H2 utilisé 1 fois ;
- une div utilitaire qui n'a aucune logique ;
- une combinaison Tailwind / CSS qui n'apparaît qu'une fois ;
- un texte fixe qui ne sera jamais réutilisé.

---

## 2. Quand modifier un composant existant

### Préférer modifier plutôt que dupliquer

Si un composant existant fait **80 %** de ce qu'on veut :

1. Ajouter une **prop** pour les variations (`variant="primary" | "secondary"`).
2. Ajouter un **slot** / `children` pour le contenu spécifique.
3. **Documenter** les variantes.

### Exemples

- `<Button>` qui devient `<Button variant="primary | secondary | ghost">` ;
- `<Card>` qui devient `<Card variant="default | highlighted">` ;
- `<Header>` qui devient `<Header mode="public | admin | minimal">`.

### Quand **ne pas** modifier

Si le besoin est **fondamentalement différent** (ex: un menu admin ≠ menu public), créer un composant **séparé** mais avec un **nom clair** :

- ✅ `<HeaderPublic />` + `<HeaderAdmin />` (rôles distincts)
- ❌ `<Header />` + `<HeaderV2 />` (relation peu claire, signal de duplication non maîtrisée)

---

## 3. Comment éviter le copier-coller

### Symptômes du copier-coller

- 12 fichiers HTML avec exactement le même `<header>` ;
- 5 templates PHP avec le même bloc footer ;
- 3 composants React avec une logique de modal légèrement variée mais 90 % identique.

### Solutions par stack

#### HTML / PHP

Utiliser des **includes** :

```php
<?php include 'partials/header.php'; ?>
```

Ou un **layout master** :

```php
<?php require 'layouts/main.php'; ?>
```

#### WordPress

Utiliser `header.php` + `footer.php` du thème enfant :

```php
<?php get_header(); ?>
<?php get_footer(); ?>
```

#### React / Next

Composant + layout :

```tsx
// app/layout.tsx
export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        <Header />
        {children}
        <Footer />
      </body>
    </html>
  );
}
```

#### Vue / Nuxt

Layout + composant :

```vue
<!-- layouts/default.vue -->
<template>
  <Header />
  <slot />
  <Footer />
</template>
```

#### Astro

Layout + slot :

```astro
---
import Header from '../components/Header.astro';
import Footer from '../components/Footer.astro';
---
<html>
  <body>
    <Header />
    <slot />
    <Footer />
  </body>
</html>
```

#### Templates Jinja / Twig

```jinja
{% extends "base.html" %}
{% block content %}
  <!-- contenu spécifique -->
{% endblock %}
```

---

## 4. Hiérarchie des composants

### Atomic design (référence utile)

| Niveau | Exemples |
|---|---|
| **Atomes** | Button, Input, Label, Icon |
| **Molécules** | FormField (label + input + error), SearchBar (input + button) |
| **Organismes** | Header, Footer, ProductCard, FormBlock |
| **Templates** | Layout, AdminLayout, AuthLayout |
| **Pages** | HomePage, ContactPage |

→ Idéalement, un composant **organisme** est composé de **molécules**, qui sont composées d'**atomes**.

### Anti-pattern

- créer une `<HomePageButton />` qui ne sera utilisée que sur la home (overkill : utiliser `<Button>` standard) ;
- créer un atome `<Spacing />` (les utilitaires CSS / Tailwind suffisent).

---

## 5. Règles de naming

### Composants

- **PascalCase** (`Header`, `ProductCard`) ;
- **descriptif** (pas `Comp1`, `MyComponent`) ;
- **clair sur le rôle** (`Header` > `Top`, `ProductCard` > `Item`).

### Variantes

- préférer **prop variant** : `<Button variant="primary" />` ;
- éviter **suffixes** : `<ButtonPrimary />`, `<ButtonSecondary />` (multiplie les fichiers).

### Versions

- **éviter** `HeaderV2`, `HeaderNew`, `HeaderModern` ;
- préférer **migrer en place** (renommer l'ancien après validation, ou utiliser un nom de mode `<Header mode="modern" />`).

---

## 6. Quand 2 composants doivent rester séparés

| Cas | Composants séparés OK |
|---|---|
| Public vs Admin | `<HeaderPublic />` + `<HeaderAdmin />` |
| Auth vs Connecté | `<HeaderAuth />` + `<HeaderConnected />` |
| Mobile vs Desktop (si très différents) | `<MobileMenu />` + `<DesktopMenu />` |
| Variantes massivement différentes | `<HeroLanding />` + `<HeroBlog />` + `<HeroProduct />` |

→ Dans ces cas, le **nom doit refléter** le rôle, pas la version.

---

## 7. Refactorisation — phasée et prudente

Si on doit consolider plusieurs composants en un seul :

### Phase 1 — Inventaire

- lister tous les composants concurrents ;
- identifier le **canonique** ;
- lister tous les usages (où chaque composant est importé / inclus).

### Phase 2 — Adapter le canonique

- ajouter les **props** nécessaires pour couvrir tous les cas ;
- tester chaque cas individuellement.

### Phase 3 — Migrer un usage à la fois

- remplacer **une** utilisation ;
- tester ;
- commiter ;
- passer à la suivante.

### Phase 4 — Nettoyer

- une fois **tous** les usages migrés, supprimer les anciens composants ;
- vérifier qu'aucun import ne pointe encore vers eux ;
- commit final.

**Règle :** ne jamais sauter de phase. Une refacto en bloc casse souvent quelque chose d'invisible.

---

## 8. Quand `site-ux-guardian` peut-il consolider lui-même ?

**Jamais sans validation utilisateur.** Le skill peut :

- **détecter** les doublons ;
- **proposer** un plan de consolidation ;
- **lister** les fichiers à modifier.

Mais la **modification réelle** doit être validée explicitement, et faite **phase par phase**.

---

## 9. Anti-patterns finaux à signaler

- composant qui prend 12 props pour gérer toutes les variantes (signal qu'il faudrait 2 composants) ;
- composant qui contient `if (isAdmin)` 5 fois (signal qu'il faudrait 2 composants) ;
- composant utilisé 1 seule fois (signal qu'il pourrait être inline) ;
- composant nommé `Generic`, `Custom`, `Box`, `Wrapper` (vide de sens) ;
- composant identique en `Atom`, `Molecule`, `Organism` selon le contexte (sur-architecture).

---

Created by João de Almeida
