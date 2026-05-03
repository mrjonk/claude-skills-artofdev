# Navigation audit guide — `site-ux-guardian`

Comment auditer **chaque type de menu** d'un site.

Created by João de Almeida

---

## 1. Menu desktop (header)

### À vérifier

- [ ] présent sur **toutes** les pages publiques attendues ;
- [ ] **5 items maximum** dans le menu principal (au-delà : mega-menu ou drawer) ;
- [ ] logo cliquable vers la home ;
- [ ] CTA primaire visible (souvent à droite) ;
- [ ] **active state** : indicateur visuel de la page courante (souligné, fond, couleur) ;
- [ ] hover state sur chaque lien ;
- [ ] focus visible au clavier ;
- [ ] cohérence des libellés (*"Contact"* partout, pas *"Nous contacter"* ailleurs) ;
- [ ] **un seul** menu principal (pas 2 navs concurrentes).

### Anti-patterns

- 12 items qui débordent ou s'enroulent ;
- mega-menu sur un site de 8 pages ;
- libellés qui changent selon la page (*"À propos"* / *"Qui sommes-nous"* / *"Notre histoire"*) ;
- CTA primaire absent.

---

## 2. Menu mobile (burger / drawer)

### À vérifier

- [ ] **bouton burger** visible et fonctionnel sur mobile ;
- [ ] menu **identique** au menu desktop (mêmes liens dans le même ordre) ;
- [ ] bouton **fermer** visible une fois ouvert ;
- [ ] **fermeture au tap hors menu** (overlay cliquable) ;
- [ ] **fermeture à la touche Escape** au clavier ;
- [ ] CTA primaire visible (en haut ou bas du drawer) ;
- [ ] menu **scrollable** si trop long ;
- [ ] **pas de désynchronisation** : si on ajoute un lien au menu desktop, il doit apparaître en mobile.

### Anti-patterns

- menu mobile avec moins de liens que le desktop ;
- burger qui n'ouvre rien ;
- menu mobile qui prend 100 vh sans bouton fermer ;
- menu mobile dans un fichier différent qui n'est pas synchronisé avec le desktop.

---

## 3. Menu admin (sidebar)

### À vérifier

- [ ] **présent sur toutes les pages admin** ;
- [ ] regroupement logique des liens (Dashboard / Contenu / Utilisateurs / Paramètres) ;
- [ ] **active state** clair ;
- [ ] icônes cohérentes (une seule famille) ;
- [ ] **collapsible** sur tablet / mobile (drawer) ;
- [ ] retour rapide vers le **dashboard** depuis chaque page ;
- [ ] retour vers le **site public** depuis l'admin ;
- [ ] **déconnexion** visible.

### Anti-patterns

- sidebar admin qui copie le menu public (l'admin n'a pas les mêmes besoins) ;
- pages admin sans sidebar ;
- icônes mixtes (Lucide + Font Awesome + emojis) ;
- aucune option pour revenir au site public.

---

## 4. Menu utilisateur connecté (dropdown profil)

### À vérifier

- [ ] avatar / nom de l'utilisateur ;
- [ ] **mon compte** ;
- [ ] **mes paramètres** ;
- [ ] **déconnexion** ;
- [ ] **changement de langue** si applicable ;
- [ ] cohérent sur **toutes les pages connecté**.

### Anti-patterns

- déconnexion absente ;
- profil dans un coin caché ;
- dropdown qui se ferme au moindre mouvement de souris ;
- couleurs non distinctives entre dropdown utilisateur et menu principal.

---

## 5. Menu utilisateur non connecté

### À vérifier

- [ ] CTA **Sign in / Login** visible ;
- [ ] CTA **Sign up / S'inscrire** visible ou regroupé ;
- [ ] **pas** d'options réservées aux utilisateurs connectés.

---

## 6. Menu multilingue

### À vérifier

- [ ] switch langue **visible** (souvent en haut à droite) ;
- [ ] indication claire de la **langue courante** (FR / EN / drapeau / texte) ;
- [ ] switch fonctionnel : `/fr/contact` → `/en/contact` (pas `/en/`) ;
- [ ] **fallback** si la page n'est pas traduite (avertissement clair) ;
- [ ] cohérence : si le menu desktop a un switch, le mobile aussi.

### Anti-patterns

- switch langue qui ramène toujours à la home ;
- pas d'indication de la langue active ;
- 5 langues affichées dans le header alors que 2 suffisent (utiliser dropdown si > 3).

---

## 7. Sidebar (autre que admin)

Cas : doc, blog avec catégories, app avec navigation latérale.

### À vérifier

- [ ] présente sur les pages où elle est utile ;
- [ ] **collapsible** sur mobile ;
- [ ] groupement logique ;
- [ ] active state ;
- [ ] cohérence des libellés.

---

## 8. Breadcrumbs

### Quand les utiliser

- site > 30 pages ;
- arborescence profonde (> 3 niveaux) ;
- doc / blog avec catégories.

### À vérifier

- [ ] **chaque niveau** est un lien fonctionnel (sauf le dernier qui est la page courante) ;
- [ ] séparateur cohérent (`/`, `>`, `›`) ;
- [ ] **schema.org `BreadcrumbList`** activé pour SEO ;
- [ ] **lisible** mobile (peut tronquer le milieu si chemin long).

### Anti-patterns

- breadcrumb à 1 niveau (inutile) ;
- breadcrumb sur **toutes** les pages d'un site de 8 pages (overkill) ;
- séparateurs inconsistants ;
- breadcrumb qui n'est plus à jour après un déplacement de page.

---

## 9. Quick actions (top toolbar)

Cas : SaaS avec actions rapides (créer, rechercher, notifications).

### À vérifier

- [ ] **icônes claires** + tooltip sur hover ;
- [ ] **shortcut clavier** documenté (ex: `⌘K` pour recherche) ;
- [ ] cohérent sur toutes les pages où ils ont du sens.

---

## 10. Footer navigation

Cf. [`menu-footer-consistency-guide.md`](menu-footer-consistency-guide.md). Résumé :

- au moins 3 colonnes ;
- liens principaux du site (sitemap implicite) ;
- liens légaux ;
- réseaux sociaux ;
- copyright avec année dynamique.

---

## Liens morts / liens cassés

Outils :
```bash
bash skills/site-ux-guardian/scripts/scan-orphan-pages.sh
bash skills/site-ux-guardian/scripts/scan-duplicate-links.sh
```

À détecter :
- liens vers des routes 404 prévisibles ;
- liens vers `#` (sans destination) ;
- liens `javascript:void(0)` non remplacés ;
- liens vers des fichiers qui n'existent pas.

---

## Active state

Pattern recommandé selon stack :

| Stack | Pattern |
|---|---|
| HTML/CSS classique | classe `is-active` ou `current` ajoutée côté serveur |
| WordPress | `current-menu-item` (déjà géré par WP) |
| React / Next | hook `usePathname()` + comparaison |
| Vue | `<router-link>` + `exact-active-class` |
| PHP custom | comparaison avec `$_SERVER['REQUEST_URI']` |

**Style :**
- soulignement, fond, couleur, ou point indicateur ;
- accessible (`aria-current="page"`).

---

## Sortie attendue

Pour chaque menu audité, remplir une ligne dans `templates/navigation-report.template.md` :

```
| Menu | Fichier source | Pages couvertes | Liens manquants | Doublons | Mobile OK | Active state |
```

---

Created by João de Almeida
