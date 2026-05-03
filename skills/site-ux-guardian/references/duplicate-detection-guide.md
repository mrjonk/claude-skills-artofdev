# Guide de détection des doublons — `site-ux-guardian`

Comment détecter les doublons de composants, pages, CSS, et signaler les anti-patterns classiques.

Created by João de Almeida

---

## 1. Pourquoi traquer les doublons

- **Maintenance** : modifier 12 fichiers identiques au lieu d'1 = source d'erreurs, de désynchronisation ;
- **Performance** : duplication CSS / JS = bundle plus lourd ;
- **SEO** : pages quasi-identiques = duplicate content pénalisé ;
- **Lisibilité** : un repo plein de `HeaderV2`, `NewFooter` est un projet qui s'est duplicaté plutôt que refondu ;
- **Cohérence** : 2 menus en parallèle = inévitablement un sera oublié à la mise à jour.

---

## 2. Anti-patterns de noms

Signaler **immédiatement** la présence de fichiers / composants nommés :

| Pattern | Exemple | Cause typique |
|---|---|---|
| `*V2`, `*V3` | `HeaderV2`, `NewHeaderV2` | refonte non finie |
| `New*` | `NewHeader`, `NewFooter` | intention de refonte abandonnée |
| `Modern*` | `ModernNavbar`, `ModernCard` | tentative de modernisation partielle |
| `Final*`, `*Final` | `FinalFooter`, `LayoutFinal` | reluctance à finaliser |
| `*-real-final*`, `*-final-final*` | `index-final-final-2.html` | détresse |
| `*-old`, `*-legacy` | `Header-old.tsx`, `style-legacy.css` | non nettoyé |
| `*-backup`, `*.bak` | `Footer.bak.php`, `wp-config-backup.php` | sauvegardes oubliées |
| `*-copy`, `*-duplicate` | `index-copy.html`, `Hero-duplicate.tsx` | copy-paste oublié |
| `test-*`, `temp-*` | `test-final.html`, `temp-page.tsx` | tests jamais nettoyés |
| `untitled*`, `Document*` | `Untitled-1.html`, `Document.tsx` | éditeur défaut |
| `index-Numeric*` | `index-2.html`, `index2.php` | duplication manuelle |

→ Détection automatique :
```bash
bash skills/site-ux-guardian/scripts/scan-duplicate-links.sh
```

→ Action : lister, signaler, **demander à l'utilisateur** si c'est intentionnel.

---

## 3. Doublons de composants

### Symptômes

- 2+ fichiers avec un nom similaire (`Header.tsx` + `HeaderV2.tsx`) ;
- 2+ composants qui rendent **visuellement** la même chose mais avec du code différent ;
- 2+ fichiers de menu qui définissent les mêmes liens.

### Détection

```bash
# Lister les fichiers de composants
find . -type f \( -name "Header*" -o -name "Footer*" -o -name "Menu*" -o -name "Navbar*" \) \
  -not -path './node_modules/*' -not -path './vendor/*' -not -path './.git/*'
```

### Recommandations

1. **Identifier** le composant **canonique** (le plus utilisé, le mieux maintenu).
2. **Lister** tous les imports / utilisations des autres.
3. **Proposer** un plan de migration (utilisation par utilisation).
4. **Ne jamais** supprimer le doublon avant migration complète.

---

## 4. Doublons de pages

### Symptômes

- `/about` + `/about-us` qui ont le même contenu ;
- `index.html` + `home.html` ;
- `services.php` + `nos-services.php`.

### Détection manuelle

- comparer les `<title>`, `<meta description>`, et le contenu du H1 ;
- si très similaires → doublon potentiel.

### Action

- proposer une **redirection 301** vers la version canonique ;
- ne pas supprimer la page elle-même tant que la redirection n'est pas testée.

---

## 5. Doublons de menus / footers

### Symptômes

- 2+ fichiers contenant les mêmes `<nav>` ou `<footer>` ;
- menu hardcodé dans 12 pages au lieu d'être un composant partagé ;
- `header.php` + `header-v2.php` selon les pages.

### Détection

```bash
bash skills/site-ux-guardian/scripts/scan-hardcoded-navigation.sh
```

Le script repère les **mêmes labels de menu** présents dans plusieurs fichiers — signal qu'un composant partagé n'est pas utilisé.

### Action

- **lister** les fichiers concernés ;
- **recommander** la création d'un composant `<Header />` / `<Footer />` global ;
- **plan de refactorisation** phasé (jamais en bloc) ;
- attendre validation avant action.

---

## 6. Doublons de liens

### Symptômes

- même lien (`/contact`) présent **15 fois** dans le menu ;
- même lien dans le menu **et** le footer **et** une sidebar **et** un CTA — ce qui est OK si justifié, problématique sinon.

### Détection

```bash
bash skills/site-ux-guardian/scripts/scan-duplicate-links.sh
```

### Cas légitimes

- lien important qui se retrouve dans le menu **et** le footer (CTA principal) ;
- lien légal qui se retrouve dans le footer **et** sur les pages auth.

### Cas problématiques

- 5 boutons "Inscription" dans la même section ;
- bouton dupliqué par maladresse (copy-paste) ;
- lien identique avec **ancres différentes** (incohérent pour l'utilisateur).

---

## 7. Doublons de textes

### Symptômes

- même paragraphe répété sur 5 pages ;
- même bloc CTA recopié partout ;
- même section *"À propos de nous"* dans la home et la page about.

### Détection

```bash
bash skills/site-ux-guardian/scripts/scan-duplicate-links.sh  # détecte aussi les textes répétés
```

### Cas légitimes

- micro-copy court répété (CTA, footer copyright) ;
- pied de page de mentions légales sur toutes les pages.

### Cas problématiques

- bloc de 200 mots copié sur 8 pages → SEO duplicate content ;
- même slogan répété 5 fois dans la home (paresse rédactionnelle).

---

## 8. Doublons CSS

### Symptômes

- même règle définie dans 2+ fichiers CSS ;
- variables `--primary` redéfinies différemment ;
- `style.css` + `style-old.css` chargés simultanément.

### Détection

```bash
# Variables CSS définies plusieurs fois
grep -rIE '^\s*--[a-z-]+\s*:' --include="*.css" --include="*.scss" . | sort
```

### Cas légitimes

- override sur un composant spécifique (ex: bouton dans une section dark) ;
- styles spécifiques par page.

### Cas problématiques

- 3 définitions différentes de `--primary` selon le fichier ;
- règles répétées identiquement (signal d'un design system absent).

---

## 9. Doublons de logique

### Symptômes

- même fonction utilitaire (`formatDate()`) dupliquée dans 5 fichiers ;
- même appel API copié partout au lieu d'un service centralisé ;
- même validation de formulaire répétée client-side et server-side avec divergences.

### Action

- **signaler** sans imposer une refonte ;
- proposer la création d'un module / service / helper.

---

## 10. Doublons de routes

### Symptômes

- `routes/web.php` qui définit `/about` **deux fois** ;
- annotations `#[Route('/contact')]` dupliquées dans 2 controllers ;
- `pages/about.tsx` + `pages/about/index.tsx` qui se concurrencent.

### Action

- détecter via lecture des configs ;
- **demander** à l'utilisateur quelle est la route canonique ;
- proposer la suppression / migration de l'autre.

---

## 11. Format de rapport — `templates/duplicate-report.template.md`

```markdown
## Doublons détectés

### Composants

| Fichier 1 | Fichier 2 | Type | Recommandation |
|---|---|---|---|
| `src/Header.tsx` | `src/HeaderV2.tsx` | composant | identifier le canonique, migrer les usages, supprimer après validation |

### Pages

| Page 1 | Page 2 | Recommandation |
|---|---|---|
| `/about` | `/about-us` | redirection 301 vers `/about` |

### Menus / footers hardcodés

| Fichier | Type | Recommandation |
|---|---|---|
| `pages/home.html` | menu hardcodé | extraire dans `partials/header.html` |
| `pages/about.html` | menu hardcodé | utiliser `partials/header.html` |
| ... | ... | ... |

### Fichiers obsolètes

| Fichier | Type | Recommandation |
|---|---|---|
| `Footer.bak.php` | sauvegarde | demander si à supprimer |
| `index-old.html` | page legacy | demander si à supprimer ou rediriger |
```

---

## 12. Règles de correction (Mode 2)

**Corrections sûres** :
- aucune. Les doublons demandent toujours une décision humaine (lequel garder, comment migrer).

**Corrections à proposer** :
- consolidation d'un composant (avec plan de migration phasé) ;
- redirection 301 entre pages doublon ;
- suppression de fichiers `.bak`, `*-old`, `*-copy` (avec validation explicite).

**Règle d'or :** ne jamais supprimer un doublon sans **avoir vérifié** qu'il n'est plus utilisé nulle part.

---

Created by João de Almeida
