# Guide de cohérence menu / footer — `site-ux-guardian`

Comment garantir que menu et footer **se complètent** sans se contredire.

Created by João de Almeida

---

## 1. Pourquoi menu + footer comptent ensemble

- Le **menu** sert la navigation **rapide** (les pages clés).
- Le **footer** sert la navigation **complète** (sitemap implicite, liens légaux).

Un site cohérent a un **menu court** (≤ 5 items) et un **footer riche** (≥ 3 colonnes).

---

## 2. Règle de cohérence

| Élément | Menu | Footer |
|---|---|---|
| Logo | oui (cliquable home) | oui (parfois plus discret) |
| Liens principaux | oui (≤ 5) | oui (groupés par colonne) |
| CTA primaire | oui | optionnel |
| Liens légaux | non | **oui obligatoire** |
| Liens sociaux | non (sauf sticky) | **oui** |
| Newsletter | non | optionnel |
| Copyright | non | **oui** (année dynamique) |
| Switch langue | oui (haut) | optionnel (bas) |

**Règle :** chaque lien du menu **doit** se retrouver quelque part dans le footer (pas l'inverse).

---

## 3. Composants partagés

### Bonne architecture

Selon la stack :

| Stack | Pattern |
|---|---|
| WordPress | `header.php` + `footer.php` du thème enfant |
| React / Next | `<Header />` + `<Footer />` dans le layout |
| Vue / Nuxt | composants globaux `default.vue` layout |
| Astro | composants `<Header />` + `<Footer />` dans `Layout.astro` |
| HTML/PHP custom | `includes/header.php` + `includes/footer.php` |
| Bootstrap statique | partials inclus via `include` ou build static |

### Mauvaise architecture (à signaler)

- menu hardcodé dans **chaque page** (`index.html`, `about.html`, `contact.html` ont chacun leur copie) ;
- footer copié-collé dans 12 fichiers ;
- composant `<Header />` qui existe **mais** que la moitié des pages n'utilisent pas (oublié) ;
- conditionals complexes (`{isAdmin ? <AdminHeader /> : <PublicHeader />}` partout au lieu d'un layout admin séparé).

---

## 4. Variantes justifiées

Cas où **plusieurs** menus / footers sont **acceptables** :

| Variante | Cas |
|---|---|
| `<HeaderPublic />` + `<HeaderAdmin />` | site avec admin séparé |
| Footer principal + Footer minimal | page checkout / page auth (réduit pour ne pas distraire) |
| Footer FR + Footer EN | site multilingue avec contenus légaux différents |
| Header sticky + Header normal | comportement de scroll spécifique |

**Règle :** si une variante existe, elle doit être **documentée** (commentaire dans le code ou README).

---

## 5. Liens légaux dans le footer

### Obligatoires (ou recommandés selon contexte)

| Page | Quand |
|---|---|
| **Mentions légales** | obligatoire en France pour tout site avec activité commerciale |
| **Politique de confidentialité** | dès qu'on collecte des données utilisateur |
| **CGV / CGU** | site marchand ou avec abonnement |
| **Politique cookies** | si trackers / analytics |
| **Crédits** | optionnel (auteur, photos, etc.) |

### Format recommandé

- liens **regroupés** dans une colonne du footer (souvent la dernière) ;
- libellés **clairs** (pas *"Mentions"* mais *"Mentions légales"*) ;
- pages **réelles** (pas vers `#`).

---

## 6. Cohérence mobile / desktop

### Menu

- mêmes liens, **même ordre** ;
- même libellés ;
- même CTA primaire visible ;
- switch langue accessible mobile aussi.

### Footer

- colonnes **empilées** sur mobile (1 colonne) ou accordéons (si nombreuses sections) ;
- liens légaux **toujours visibles** (souvent en bas) ;
- copyright lisible.

---

## 7. Cohérence multilingue

### Menu

- **mêmes liens** dans chaque langue (ordre identique) ;
- libellés **traduits** (pas un mix FR/EN dans un même menu) ;
- switch langue **présent partout**.

### Footer

- **mêmes sections** dans chaque langue ;
- liens **internes traduits** (le lien *"Contact"* en FR mène à `/fr/contact`, pas à `/en/contact`) ;
- liens **externes** identiques (les réseaux sociaux ne sont pas traduits) ;
- mentions légales **traduites** (RGPD si UE) ou en version multilingue.

---

## 8. Anti-patterns à signaler

### Menu / Footer désynchronisés

- nouveau lien ajouté dans le menu mais oublié dans le footer ;
- footer qui pointe vers une ancienne URL (le menu pointe vers la nouvelle).

### Footer pauvre

- juste un copyright (signal de site inachevé) ;
- 1 seule colonne ;
- aucun lien légal ;
- aucun lien social.

### Menu surchargé

- 12 items qui débordent ;
- mega-menu sur un site de 8 pages ;
- doublons (*"Accueil"* + *"Home"*).

### Conditionnels chaotiques

- header qui change selon 5 conditions (`isAdmin && !isOnboarding && lang === 'fr'`) au lieu de 2–3 layouts dédiés.

---

## 9. Checklist menu / footer

### Menu

- [ ] présent sur toutes les pages publiques ;
- [ ] ≤ 5 items ;
- [ ] logo cliquable ;
- [ ] CTA primaire ;
- [ ] active state ;
- [ ] cohérent mobile / desktop ;
- [ ] cohérent entre langues ;
- [ ] composant partagé (pas hardcodé partout) ;
- [ ] aucun lien admin visible (sauf si volontaire) ;
- [ ] aucun lien mort.

### Footer

- [ ] présent sur toutes les pages publiques (sauf checkout / auth simplifiés) ;
- [ ] ≥ 3 colonnes ;
- [ ] liens légaux complets ;
- [ ] liens sociaux fonctionnels ;
- [ ] copyright avec année dynamique ;
- [ ] composant partagé ;
- [ ] lisible mobile ;
- [ ] cohérent entre langues.

---

## 10. Recommandations de correction

Si menu / footer hardcodés dans plusieurs fichiers :

1. **Signaler** la liste des fichiers concernés.
2. **Recommander** la création d'un composant partagé (selon stack).
3. **Proposer** une refactorisation phasée (1 layout à la fois, validation).
4. **Ne jamais** refactoriser massivement sans accord.

---

Created by João de Almeida
