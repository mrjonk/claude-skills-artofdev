# Guide de cartographie des routes — `site-ux-guardian`

Comment cartographier toutes les routes d'un site et détecter les pages orphelines.

Created by João de Almeida

---

## 1. Sources de routes selon la stack

| Stack | Où chercher |
|---|---|
| **WordPress** | structure `wp-content/themes/<theme>/`, custom post types, pages dans WP admin |
| **Next.js (Pages Router)** | `pages/*.tsx` |
| **Next.js (App Router)** | `app/**/page.tsx`, `app/**/route.ts` |
| **Remix** | `app/routes/**/*.tsx` |
| **Vue / Nuxt** | `pages/**/*.vue`, ou `router/index.ts` |
| **Astro** | `src/pages/**/*.astro` |
| **Laravel** | `routes/web.php`, `routes/api.php` |
| **Symfony** | `config/routes.yaml`, annotations `#[Route]` |
| **Django** | `urls.py` au niveau projet et apps |
| **FastAPI** | décorateurs `@app.get`, `@router.get` |
| **PHP custom** | fichiers `.php` directement, ou un router maison |
| **Static HTML** | tous les `.html` dans le dossier public |

---

## 2. Cartographie en 3 étapes

### Étape 1 — Routes déclarées

Lister **toutes les routes** définies par la stack.

Pour chaque route :
- chemin (ex: `/about`, `/blog/[slug]`, `/admin/users`) ;
- type (publique / admin / auth / API) ;
- fichier source.

### Étape 2 — Routes utilisées

Lister tous les **liens internes** présents dans le code.

Outils :
```bash
grep -rIE 'href="(/[^"]*)"|to="(/[^"]*)"' --include="*.html" --include="*.tsx" --include="*.jsx" --include="*.vue" --include="*.php" .
```

Pour chaque lien :
- URL ;
- fichier où il apparaît ;
- ancre / texte du lien.

### Étape 3 — Comparaison

Croiser les deux listes :

| Route déclarée | Liée depuis ? | Liens entrants (combien) | Liens sortants | Statut |
|---|---|---|---|---|
| `/` | menu, footer, logo | nombreux | nombreux | ✅ accessible |
| `/about` | menu | 1 | 3 | ✅ accessible |
| `/legacy-page` | nulle part | 0 | 2 | ⚠️ orpheline |
| `/admin/old-dashboard` | nulle part | 0 | 0 | ⚠️ orpheline |

→ Output : `templates/site-map-audit.template.md`.

---

## 3. Détecter les pages orphelines

**Page orpheline** = route déclarée mais aucun lien dans le code ne pointe vers elle.

### Cas légitimes

- pages **redirigées** automatiquement (la route existe pour back-compat) ;
- pages accessibles **uniquement** via mail / lien direct (page de paiement réussi) ;
- pages **admin** réservées (accessibles seulement depuis le dashboard admin protégé).

### Cas problématiques

- vieille page laissée après refonte ;
- page cassée jamais terminée ;
- duplication non nettoyée.

### Action

- pour chaque orpheline : poser la question à l'utilisateur ;
- **ne pas supprimer** sans validation explicite ;
- documenter dans le rapport.

---

## 4. Détecter les liens morts

**Lien mort** = lien interne pointant vers une route qui n'existe pas.

### Détection

```bash
# Pour chaque lien interne trouvé, vérifier que la route existe
# (le scan-orphan-pages.sh fait une approximation)
bash skills/site-ux-guardian/scripts/scan-orphan-pages.sh
```

### Cas typiques

- typo dans l'URL (`/contat` au lieu de `/contact`) ;
- route renommée mais lien pas mis à jour ;
- lien copié d'un autre site sans adaptation.

### Action

- lister les liens morts avec fichier:ligne ;
- proposer la **route correcte** si évidente ;
- **corriger en Mode 2** uniquement si la correction est triviale et sans ambiguïté.

---

## 5. Détecter les routes concurrentes

**Routes concurrentes** = plusieurs routes différentes qui rendent le même contenu (ou similaire).

### Cas typiques

- `/about` + `/about-us` + `/qui-sommes-nous` (3 routes pour la même page) ;
- `/contact` + `/nous-contacter` (FR/EN mélangés sans système multilingue clair) ;
- `/products` + `/products/all` + `/catalog` (refonte non finie).

### Action

- lister les routes concurrentes ;
- **proposer** une URL canonique ;
- recommander des **redirections 301** depuis les anciennes vers la canonique ;
- ne jamais supprimer sans validation.

---

## 6. Détecter les liens vers `#`, `javascript:void(0)`, `null`

**Liens sans destination** = boutons / liens dont l'URL n'a pas été branchée.

### Détection

```bash
grep -rIE 'href="#"|href="javascript:void\(0\)"|to="#"|onClick=\{null\}' \
  --include="*.html" --include="*.tsx" --include="*.jsx" --include="*.vue" --include="*.php" .
```

### Cas légitimes

- lien JavaScript qui déclenche une action via `onClick` (ex: ouvrir un modal) — alors mieux d'utiliser `<button>` ;
- ancre interne (`href="#section"`) — mais la cible doit exister.

### Cas problématiques

- bouton CTA dont l'URL n'a jamais été configurée ;
- lien copié d'une démo qui pointe vers `#`.

---

## 7. Détecter les redirections

### Sources de redirections

| Stack | Où chercher |
|---|---|
| Apache | `.htaccess` |
| Nginx | config nginx (`server` block) |
| WordPress | plugin Redirection ou Yoast |
| Next.js | `next.config.js` (`redirects()`) |
| Netlify / Vercel | `_redirects`, `vercel.json` |
| Express | middleware |
| Laravel | `routes/web.php` |

### À vérifier

- toutes les redirections sont **fonctionnelles** ;
- pas de **chaîne** de redirections (A → B → C → D = perte de SEO et perf) ;
- pas de **boucle** de redirection ;
- redirections **301** pour les changements permanents (pas 302).

---

## 8. Détecter les liens externes

À vérifier :

- `target="_blank"` accompagné de `rel="noopener noreferrer"` ;
- aucun lien externe en `dofollow` vers un concurrent (sauf intentionnel) ;
- aucun lien vers un domaine **expiré** ou **piraté**.

---

## 9. Site multilingue — règles spéciales

Pour chaque page, vérifier qu'elle existe dans **chaque langue** (sauf pages volontairement monolingues).

| Pattern | Exemple |
|---|---|
| Préfixe URL | `/fr/contact` + `/en/contact` |
| Sous-domaine | `fr.example.com/contact` + `en.example.com/contact` |
| Suffixe | `/contact` (FR) + `/contact-en` (EN) — déconseillé |
| Subdir avec rewrite | géré côté serveur |

### À vérifier

- chaque page principale a sa version dans chaque langue ;
- le **switch langue** mène à la version équivalente, pas toujours à la home ;
- balise `<link rel="alternate" hreflang="...">` présente ;
- balise `<html lang="fr">` correcte.

---

## 10. Format de sortie

Après cartographie complète, remplir :

```markdown
| Page | Type | Route | Accessible depuis | Liens entrants | Liens sortants | Problème |
|---|---|---|---|---|---|---|
| Home | publique | `/` | menu, footer, logo | très nombreux | très nombreux | aucun |
| About | publique | `/about` | menu, footer | 5 | 4 | aucun |
| Legacy | publique | `/legacy` | nulle part | 0 | 2 | orpheline (à supprimer ou rediriger) |
```

→ `templates/site-map-audit.template.md`.

---

## 11. Règles de correction (Mode 2)

**Corrections sûres** :
- correction d'une typo évidente dans une URL (`/contat` → `/contact`) ;
- ajout de `rel="noopener noreferrer"` sur un lien externe `target="_blank"`.

**Corrections à proposer (pas Mode 2)** :
- suppression d'une page orpheline ;
- création de redirections 301 ;
- consolidation de routes concurrentes ;
- ajout de pages manquantes en multilingue.

---

Created by João de Almeida
