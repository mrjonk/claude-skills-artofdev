# Cohérence front / admin — `site-ux-guardian`

Comment garantir une séparation claire **et** une cohérence raisonnable entre le site public et l'admin.

Created by João de Almeida

---

## 1. Pourquoi front et admin sont **différents**

Le site **public** :
- vise la **conversion** ou l'**information** ;
- design **expressif**, **engageant** ;
- navigation **simplifiée** ;
- ton **commercial** ou **éditorial**.

L'**admin** :
- vise l'**efficacité** opérationnelle ;
- design **dense**, **lisible** ;
- navigation **fonctionnelle** (sidebar, menus profonds) ;
- ton **neutre** et **technique**.

→ Les deux **doivent partager** le design system (couleurs, typo) **mais pas** la mise en page ou les patterns d'interaction.

---

## 2. Séparation claire — règles

### URL

| Pattern | Recommandé |
|---|---|
| `/` (front) + `/admin` (admin) | ✅ classique et clair |
| `/` + `/dashboard` | ✅ |
| `/` + `/manage` | ✅ |
| `/admin.example.com` | ✅ sous-domaine séparé |
| `/page` + `/page-admin` | ❌ confusion |

### Layouts séparés

```
- public layout : header public + footer public
- admin layout  : sidebar admin + topbar admin + footer minimal (ou pas de footer)
- auth layout   : minimal (logo, formulaire, lien de récupération)
```

→ **3 layouts maximum** dans la majorité des cas.

---

## 3. Navigation admin — règles

### Sidebar (recommandée)

- **toujours présente** sur les pages admin ;
- **collapsible** sur tablet / mobile ;
- regroupement logique :
  - **Dashboard** (accueil) ;
  - **Contenu** (pages, articles, médias) ;
  - **Utilisateurs** (admins, clients, rôles) ;
  - **Commandes / Données** (orders, leads) ;
  - **Paramètres** (config, intégrations) ;
- **active state** clair sur la page courante ;
- icônes **cohérentes** (une seule famille) ;
- **liens secondaires** (ouvrir le site public, déconnexion).

### Topbar admin

- **profil** utilisateur (avatar + nom + dropdown) ;
- **notifications** si applicable ;
- **recherche globale** si applicable ;
- **breadcrumbs** si arborescence profonde.

---

## 4. Pages admin — états et patterns

### États obligatoires

- [ ] **état chargement** (skeleton ou spinner) ;
- [ ] **état vide** (avec CTA d'ajout) ;
- [ ] **état erreur** (message + retry) ;
- [ ] **état succès** post-action (toast vert) ;
- [ ] **état confirmation** sur action destructive (modal).

### Patterns CRUD

Pour chaque entité (articles, utilisateurs, commandes…) :

- [ ] **Liste** avec recherche, filtres, pagination ;
- [ ] **Détail** ou édition (formulaire pré-rempli) ;
- [ ] **Création** (formulaire vide) ;
- [ ] **Suppression** (confirmation modal obligatoire) ;
- [ ] **Restauration** ou corbeille (si entités importantes).

---

## 5. Protection admin — règles

### Authentification

- **toutes** les pages admin protégées (middleware d'auth) ;
- redirection vers `/login` si non auth ;
- **session** expire après inactivité (30 min – 2 h) ;
- **logout** fonctionnel et immédiat.

### Autorisation

- **rôles** distincts si nécessaire (admin, éditeur, lecteur) ;
- vérification **côté serveur** (jamais côté client uniquement) ;
- **politiques** d'accès par ressource (un éditeur peut éditer ses articles, pas ceux d'un autre).

### Règles `site-ux-guardian`

Le skill **signale** uniquement (pas modifier sans accord) :

- pages admin **non protégées** (signal critique) ;
- middleware d'auth **manquant** sur certaines routes ;
- pages admin **indexables** (sans `noindex,nofollow`) ;
- liens admin **visibles** dans le menu public si non souhaité.

→ Pour audit auth profond → **`production-auditor`**.

---

## 6. Liens admin dans le menu public

### Règle

- **par défaut** : aucun lien admin dans le menu public ;
- **exception** : lien *"Espace pro"* / *"Mon compte"* si SaaS B2B (mais c'est un menu utilisateur, pas un menu admin) ;
- **JAMAIS** : `<a href="/admin">Admin</a>` dans le footer public.

### Si l'utilisateur est connecté

- afficher éventuellement un lien `Dashboard` dans le menu utilisateur (dropdown profil) ;
- **conditionnel** : visible uniquement aux utilisateurs ayant les droits.

---

## 7. Cohérence design front / admin

### Ce qui doit être **commun**

- **couleurs primaires** (mêmes tokens) ;
- **typographie** (mêmes familles de polices, échelle adaptée) ;
- **icônes** (même famille : Lucide, Heroicons, etc.) ;
- **boutons** (mêmes variantes : primary, secondary, ghost) ;
- **forms** (mêmes patterns : label visible, error inline, submit clair) ;
- **toasts** (mêmes positions, mêmes types) ;
- **modals** (mêmes patterns d'ouverture/fermeture).

### Ce qui doit être **différent**

- **densité visuelle** : front aéré, admin plus compact ;
- **layout** : front = sections marketing, admin = sidebar + main ;
- **CTA** : front = orientés conversion, admin = orientés action métier ;
- **animations** : front peut en avoir, admin doit être sobre ;
- **photos hero** : front = visuel fort, admin = pas de hero ;
- **typographie display** : front peut utiliser un display font, admin = sans-serif sobre.

---

## 8. Erreurs fréquentes à signaler

### Front qui ressemble à un admin

- pas de hero, juste un dashboard frontal ;
- design dense même sur la home ;
- pas de CTA dominant.

### Admin qui ressemble à un front

- header public au-dessus de la sidebar admin ;
- typo display sur les titres admin ;
- gradients et animations dans les pages admin ;
- pas de séparation visuelle claire.

### Confusion utilisateur

- l'utilisateur ne sait pas s'il est sur le site public ou dans l'admin ;
- le logo est identique sans variante (admin a souvent un mode dark ou un badge "ADMIN") ;
- les boutons "Retour au site" et "Déconnexion" sont absents ou cachés.

### Sécurité oubliée

- page admin accessible directement par URL sans login ;
- formulaires admin sans CSRF ;
- routes `/api/admin/*` non protégées ;
- liens admin présents dans le menu public et indexés.

---

## 9. États vides — patterns

Pour chaque liste admin **vide** :

```html
<div class="empty-state">
  <Icon name="inbox" />
  <h3>Aucun lead pour le moment</h3>
  <p>Les leads apparaîtront ici dès qu'un visiteur remplira le formulaire.</p>
  <button>Ajouter un premier lead manuellement</button>
</div>
```

→ **Toujours** : icône légère + titre + description courte + CTA.

---

## 10. Filtres / recherche / pagination — patterns

### Filtres

- **toujours** dans une zone dédiée (au-dessus du tableau ou dans une sidebar) ;
- **conservés dans l'URL** (partagable, rechargeable) ;
- **reset** en un clic.

### Recherche

- **debounced** (300–500 ms) ;
- résultats **filtrés en place** (pas de page rechargée) ;
- **message clair** si aucun résultat.

### Pagination

- **toujours** dès > 25 lignes ;
- choix du **nombre par page** (10 / 25 / 50 / 100) ;
- conservée dans l'URL.

---

## 11. Badges / counters

- pastille discrète, **pas** une bombe rouge à 8 chiffres ;
- couleur sémantique (rouge = action requise, jaune = warning) ;
- **max 99+** (au-delà, afficher "99+") ;
- accessible (`aria-label="3 notifications non lues"`).

---

## 12. Cohérence inter-pages admin

- **chaque page admin** suit le même layout (sidebar + topbar + main) ;
- **chaque liste** a la même structure (filtres + tableau + pagination) ;
- **chaque détail** a la même structure (breadcrumb + titre + actions + tabs) ;
- **chaque formulaire** a la même structure (groupes de champs + boutons en bas).

---

## 13. Termes humains — `CLAUDE_PROJECT_FACTORY` style

(Référence générale, pas spécifique à un VPS.)

Préférer dans l'UI admin :

| ❌ Termes techniques | ✅ Termes humains |
|---|---|
| Endpoint | (à éviter complètement dans l'UI) |
| Schema | (à éviter) |
| Database, DB | (à éviter) |
| JSON, payload | (à éviter) |
| Migration | (à éviter sauf doc dev) |
| Update | Modifier, Sauvegarder |
| Delete | Supprimer (avec confirmation) |
| Submit | Envoyer, Valider |
| Configure | Configurer, Paramétrer |

→ Le skill peut signaler la présence de termes techniques dans l'UI admin destinée à des utilisateurs non techniques.

---

## 14. Checklist front / admin

### Front

- [ ] header public présent partout ;
- [ ] footer public présent partout (sauf checkout simplifié) ;
- [ ] aucun lien admin visible (sauf intentionnel) ;
- [ ] navigation orientée conversion ;
- [ ] design expressif, pas dense.

### Admin

- [ ] sidebar présente sur toutes les pages admin ;
- [ ] toutes les pages **protégées** ;
- [ ] retour vers le site public visible ;
- [ ] déconnexion visible ;
- [ ] états vides / chargement / erreur gérés ;
- [ ] CRUD complet par entité ;
- [ ] filtres / recherche / pagination si applicable ;
- [ ] termes humains uniquement.

### Cohérence

- [ ] design tokens partagés (couleurs, typo) ;
- [ ] icônes d'une seule famille ;
- [ ] boutons cohérents ;
- [ ] forms cohérents ;
- [ ] séparation visuelle claire (l'utilisateur sait où il est).

---

Created by João de Almeida
