# Guide de sélection de composants — `premium-webdesigner`

Comment choisir le bon composant selon le besoin. Pas de catalogue exhaustif : une **grille de décision** par usage.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Grille de décision (pour chaque composant retenu)

```
| Composant            | Source        | URL                       | Usage prévu              |
| Pourquoi pertinent   | Risques       | Adaptations nécessaires    | Dépendances              |
| Impact responsive    | Impact perf   |
```

À remplir dans `templates/component-selection.template.md`.

---

## 1. Hero section

**Pour quoi :** la première impression. Doit transmettre **l'ambiance** + **la valeur** + un **CTA** principal.

**Variations possibles :**

| Style | Quand l'utiliser |
|---|---|
| **Texte-dominant** (gros titre + sous-titre + CTA) | SaaS B2B, produit conceptuel, agence |
| **Split image / texte** (50/50) | produit visuel, app mobile, e-commerce |
| **Hero immersif** (image plein écran + texte overlay) | restaurant, voyage, label musical, portfolio artiste |
| **Hero animé** (Lottie / Motion / vidéo) | SaaS tech premium, agence créative |
| **Hero produit** (mockup app / dashboard preview) | SaaS, application mobile |
| **Hero éditorial** (typographie marquée, layout magazine) | blog premium, site média |

**Règles :**
- **un seul** hero par page ;
- **un seul** H1 dans le hero ;
- **un CTA primaire** + max 1 CTA secondaire ;
- pas de carousel auto-rotatif (UX et SEO mauvais) ;
- visible et lisible **mobile first** ;
- LCP < 2.5 s (image hero optimisée).

---

## 2. CTA (Call to Action)

**Variations :**

| Style | Quand |
|---|---|
| **Bouton plein** (primary, couleur d'accent) | action principale |
| **Bouton outline** | action secondaire |
| **Lien souligné** | action tertiaire / reading |
| **Bouton + texte de réassurance** ("Commencer gratuit · Sans CB") | conversion saas |

**Règles :**
- verbe d'action clair (`Réserver`, `Commencer`, `Demander un devis`) — **pas** `Cliquez ici` ;
- 1 seul CTA primaire par section ;
- contraste fort avec le fond ;
- focus visible (clavier) ;
- état hover subtil (couleur ou élévation) ;
- état disabled distinct ;
- état loading si requête asynchrone.

---

## 3. Pricing

**Variations :**

| Style | Quand |
|---|---|
| **Cards 3 plans** (Free / Pro / Team) | SaaS standard |
| **Toggle annuel/mensuel** | SaaS abonnement |
| **Card "highlight" centrale** | mettre en avant un plan |
| **Pricing matrix / table** | si feature comparison nécessaire |

**Règles :**
- prix bien lisible (taille + poids) ;
- mention HT / TTC clair ;
- liste features cohérente entre plans (pas une feature ici, manquante là) ;
- CTA différencié par plan ;
- mention satisfait ou remboursé / essai gratuit si applicable ;
- **cohérence prix** entre /pricing, checkout, factures (cf. skill `production-auditor`).

---

## 4. Feature cards

**Variations :**

| Style | Quand |
|---|---|
| **Grille 3 cards** (icône + titre + description) | feature simple |
| **Bento grid** (cards de tailles variables) | features riches, look moderne |
| **Cards alternées image/texte** | features avec preview produit |
| **Tabs verticaux** | features qui méritent une démo détaillée |

**Règles :**
- 3, 6, ou 9 cards (multiples de 3 = grille équilibrée) ;
- icônes **cohérentes** (même famille, même taille) ;
- texte de feature **bénéfice utilisateur**, pas description technique ;
- **éviter** : 12 cards identiques sans hiérarchie.

---

## 5. Testimonials

**Variations :**

| Style | Quand |
|---|---|
| **Carousel auto** | éviter (mauvais UX) |
| **Grille 3 ou 6** | clean, lisible |
| **Featured testimonial** (1 grand) + grille | un testimonial fort en avant |
| **Logos clients + 1 quote** | B2B, social proof rapide |

**Règles :**
- testimonials **réels** uniquement (jamais inventés) ;
- nom + photo + entreprise + poste = + crédible que nom seul ;
- citation courte (2–4 phrases max) ;
- **pas** de testimonial fake "Marie, 32 ans" qui n'existe pas.

---

## 6. Bento grid

**Variations :**

| Style | Quand |
|---|---|
| **3×3 mixte** (1 grande + petites) | hero alternatif moderne (Apple, Linear) |
| **2 lignes asymétriques** | features avec hiérarchie visuelle |

**Règles :**
- 1 cellule "vedette" + 2–4 cellules secondaires ;
- chaque cellule a un visuel ou icône ;
- couleurs / contrastes différenciés mais cohérents ;
- mobile : empile en colonnes, conserve la cellule vedette en premier.

---

## 7. Dashboard cards / stats cards

**Variations :**

| Style | Quand |
|---|---|
| **Stat brute** (chiffre + label) | KPI simple |
| **Stat + delta** (chiffre + variation %) | comparaison période |
| **Stat + sparkline** | tendance visuelle |
| **Card double** (KPI + mini-graphique) | dashboard riche |

**Règles :**
- chiffre en taille dominante ;
- label en texte secondaire ;
- delta en couleur sémantique (vert ↑, rouge ↓) ;
- **état vide** géré (pas de "0" qui semble cassé) ;
- **état chargement** géré (skeleton).

---

## 8. Data table

**Variations :**

| Style | Quand |
|---|---|
| **Table classique** (header + rows) | listing administratif |
| **Table + filters + search** | volume important |
| **Table + actions inline** | CRUD rapide |
| **Table groupée / pivot** | reporting |

**Règles :**
- pagination toujours (10/25/50/100) ;
- recherche **debounced** ;
- filtres conservés dans l'URL ;
- état vide géré ;
- responsive : sur mobile, transformer en cards (chaque row = 1 card).

---

## 9. Timeline

**Variations :**

| Style | Quand |
|---|---|
| **Timeline verticale** | historique, processus |
| **Timeline horizontale** | étapes courtes, "How it works" |
| **Timeline avec icônes** | visualisation parcours |

**Règles :**
- max 5–7 étapes ;
- chaque étape : titre + description courte + visuel ;
- responsive : verticale en mobile.

---

## 10. FAQ

**Règles :**
- **accordéons** (un seul ouvert à la fois ou multi selon UX) ;
- max 8–12 questions par page ;
- questions **réelles** (issues du support, pas inventées) ;
- réponses **complètes** (pas un teaser) ;
- structurer en 2–3 groupes si > 6 questions.

---

## 11. Navbar

**Règles :**
- max **5 items** dans le menu principal ;
- logo à gauche, items au centre ou à droite, CTA primaire à l'extrême droite ;
- mobile : burger ou drawer ;
- **indicateur de page active** (souligné, fond, ou couleur) ;
- sticky on scroll OK si lisible (fond opaque, pas transparent + flou seul) ;
- pas de mega-menu pour un site < 30 pages.

---

## 12. Footer

**Règles (cohérence avec UX checklist) :**
- **3 colonnes minimum** : navigation + contact/social + légal ;
- mention copyright avec **année dynamique** (`new Date().getFullYear()`) ;
- liens vers pages légales ;
- réseaux sociaux fonctionnels (pas vers `#`) ;
- newsletter optionnelle ;
- pas de footer pauvre (juste un copyright = signal de paresse).

---

## 13. Modal / Dialog

**Règles :**
- usage **rare** (modal = interruption forte) ;
- titre clair ;
- bouton fermer (X) en haut à droite ;
- **fermer au clic hors modal** + touche `Escape` ;
- focus trap (le clavier ne sort pas) ;
- empêche le scroll du body en arrière-plan ;
- max 1 modal à la fois.

---

## 14. Form

**Règles :**
- labels **toujours visibles** (placeholders ne suffisent pas) ;
- champs obligatoires marqués (`*` ou texte) ;
- validation **côté client** + **côté serveur** ;
- erreurs **localisées au champ** (pas un toast vague) ;
- bouton submit **désactivé pendant l'envoi** (anti double-soumission) ;
- feedback succès clair ;
- accessibilité clavier complète.

---

## 15. Upload area

**Règles :**
- drag-and-drop visible + bouton de fallback ;
- preview avant upload ;
- progression d'upload ;
- gestion d'erreur (taille trop grande, mauvais format) ;
- côté serveur : MIME, taille, sanitisation nom de fichier (cf. `production-auditor` checklist sécurité).

---

## 16. Auth screens

**Règles :**
- formulaire centré, court, focus immédiat sur premier champ ;
- mot de passe oublié visible mais discret ;
- distinction visuelle Login / Register ;
- providers OAuth bien identifiés (logos officiels) ;
- pas de design tape-à-l'œil sur ces pages — la confiance prime.

---

## 17. Empty states

**Règles :**
- **toujours** géré (jamais une liste vide muette) ;
- message clair ("Aucun élément pour le moment") ;
- **call-to-action** ("Ajouter un premier élément") ;
- illustration ou icône légère ;
- ne pas surcharger : 1 illustration, 1 phrase, 1 bouton.

---

## 18. Notification badges

**Règles :**
- pastille discrète (pas une bombe rouge à 8 chiffres) ;
- couleur sémantique (rouge = action requise) ;
- max 99+ (au-delà, afficher "99+") ;
- accessible (`aria-label="3 notifications non lues"`).

---

## 19. Progress states

**Règles :**
- progression linéaire (`<progress>` ou barre) pour upload, paiement ;
- progression circulaire pour dashboards ;
- skeleton pour chargements > 300 ms ;
- spinner uniquement pour < 300 ms.

---

## 20. Before/after comparison

**Règles :**
- slider horizontal (curseur déplaçable) ;
- accessibilité clavier (flèches gauche/droite) ;
- légendes "Avant" / "Après" claires ;
- mobile : version empilée si slider gênant.

---

## Règle générale

**Cohérence > diversité.** Mieux vaut 5 composants alignés (mêmes proportions, mêmes radius, même style d'icônes) qu'un patchwork de 12 composants stylistiquement distincts. Un design premium se reconnaît à sa **discipline visuelle**.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
