# Checklist admin / dashboard — `production-auditor`

Created by João de Almeida — Art of Dev — https://artofdev.space

À dérouler en phase 7 (côté admin / backoffice).

---

## 1. Protection admin

- [ ] `/admin/` redirige vers `/admin/login` si non authentifié ;
- [ ] aucune page admin n'est accessible en direct sans session ;
- [ ] vérification de session / CSRF sur **toutes** les actions ;
- [ ] déconnexion (`logout`) fonctionnelle et invalide la session ;
- [ ] timeout d'inactivité raisonnable (30 min – 2 h selon contexte).

---

## 2. CRUD complet

Pour chaque entité principale (services, produits, articles, utilisateurs…) :

- [ ] **Create** : formulaire + validation + feedback ;
- [ ] **Read** : liste + détail ;
- [ ] **Update** : formulaire pré-rempli + sauvegarde + feedback ;
- [ ] **Delete** : action confirmée (modal de confirmation) ;
- [ ] **Restore** ou **Trash** si destructif (corbeille avant suppression définitive).

---

## 3. Filtres

- [ ] filtres pertinents par entité (statut, date, catégorie) ;
- [ ] filtres conservés en URL (partageable / rechargeable) ;
- [ ] reset filtres en un clic.

---

## 4. Recherche

- [ ] champ recherche présent sur les listes principales ;
- [ ] recherche **debounced** (pas de requête à chaque touche) ;
- [ ] résultats filtrés en place (pas de re-render brutal) ;
- [ ] message clair si aucun résultat.

---

## 5. Pagination

- [ ] **toutes les listes** ont une pagination (ou un scroll infini propre) ;
- [ ] page courante visible ;
- [ ] navigation premier/dernier/précédent/suivant ;
- [ ] choix du nombre par page (10, 25, 50) si volumes importants ;
- [ ] pagination conservée dans l'URL.

---

## 6. États vides

- [ ] aucune liste vide sans message ("Aucun élément pour le moment") ;
- [ ] message d'état vide accompagné d'une action ("Ajouter un premier service") ;
- [ ] illustration ou icône légère.

---

## 7. Confirmations

- [ ] suppression : modal de confirmation **obligatoire** ;
- [ ] action en lot (suppression multiple) : double confirmation (cocher + valider) ;
- [ ] action irréversible : phrase explicite ("Cette action est irréversible.").

---

## 8. Badges / notifications

- [ ] badge sur les éléments en attente (demandes de contact non traitées, commandes nouvelles) ;
- [ ] notifications post-action (toast vert / rouge) ;
- [ ] auto-dismiss après quelques secondes ;
- [ ] log des notifications si admin doit les retrouver.

---

## 9. Statistiques utiles

(Cf. `CLAUDE_PROJECT_FACTORY.md` §6.) Le dashboard ne doit pas être un tableau vide.

- [ ] nombre d'éléments par entité principale ;
- [ ] activité récente (derniers ajouts/modifications) ;
- [ ] état de configuration du site (checklist de lancement) ;
- [ ] to-do list interne ;
- [ ] alertes (mot de passe par défaut non changé, logo manquant, photos placeholder, etc.) ;
- [ ] raccourcis vers actions fréquentes ;
- [ ] graphique simple si données pertinentes (visites, ventes, demandes).

---

## 10. Exports

- [ ] export CSV des listes principales (commandes, demandes, utilisateurs) ;
- [ ] format CSV correct (UTF-8 BOM, séparateur clair) ;
- [ ] PDF ou impression propre des fiches détaillées (factures, devis) si applicable ;
- [ ] export ZIP du site complet si mini CMS (cf. `tools/export-zip.sh`).

---

## 11. Gestion utilisateurs

- [ ] ajout / suppression / modification d'utilisateurs admin ;
- [ ] rôles et permissions assignables ;
- [ ] reset de mot de passe par admin (sans voir l'ancien) ;
- [ ] log des connexions admin ;
- [ ] suspension de compte sans suppression.

---

## 12. Gestion contenus

- [ ] édition WYSIWYG ou Markdown selon le besoin (pas de raw HTML pour un client non technique) ;
- [ ] upload d'images intégré à l'éditeur ;
- [ ] aperçu avant publication ;
- [ ] enregistrement automatique (draft auto-save) si formulaires longs ;
- [ ] historique des modifications (versioning) si critique ;
- [ ] preview du rendu public depuis l'admin.

---

## 13. Gestion médias

(Cf. `CLAUDE_PROJECT_FACTORY.md` §21.)

- [ ] upload (drag and drop) ;
- [ ] remplacement / suppression ;
- [ ] prévisualisation ;
- [ ] tri drag and drop si galerie ;
- [ ] alt / titre / légende éditables ;
- [ ] vérification taille / format / MIME.

---

## 14. Cohérence front / back

- [ ] toute modification admin se reflète sur le front (cache invalidé proprement) ;
- [ ] aucun "fantôme" : un service supprimé en admin n'apparaît plus côté public ;
- [ ] liens internes admin → public corrects (preview du rendu) ;
- [ ] pas de différence de slug entre front et admin ;
- [ ] pas de différence de pricing entre front et admin/billing.

---

## 15. UX admin

- [ ] termes humains (cf. `CLAUDE_PROJECT_FACTORY.md` §11) :
  - "Modifier l'accueil" plutôt que "Update home_page record" ;
  - "Tâches à faire" plutôt que "Tasks queue" ;
- [ ] aucun terme technique visible (`database`, `endpoint`, `JSON`, `schema`, `migration`) ;
- [ ] menu admin clair, action principale en évidence ;
- [ ] navigation rapide entre sections ;
- [ ] retour rapide au site public depuis l'admin.

---

## Sortie attendue

Pour chaque item failed :

- **section admin** concernée (`/admin/services`, `/admin/users`…) ;
- **gravité** : `critique` / `important` / `mineur` ;
- **impact** : 1 phrase **côté admin** ("L'admin doit deviner que la liste est vide.") ;
- **correction recommandée** : 1 phrase actionnable.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
