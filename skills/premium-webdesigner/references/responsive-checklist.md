# Checklist responsive — `premium-webdesigner`

Tester à **4 breakpoints minimum**. Mobile-first par défaut.

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Breakpoints standards

| Nom | Largeur | Cible |
|---|---|---|
| **xs** | 320–375 px | mobile S (iPhone SE, Galaxy A) |
| **sm** | 376–639 px | mobile M (iPhone, Pixel) |
| **md** | 640–1023 px | tablet (iPad portrait, Surface) |
| **lg** | 1024–1279 px | laptop (MacBook 13") |
| **xl** | 1280–1535 px | desktop (MacBook 16", écran 1080p) |
| **2xl** | 1536+ px | grand écran (4K, ultra-wide) |

**Tester au minimum** : 320 / 768 / 1024 / 1440.

---

## 1. Mobile first (320–639 px)

- [ ] aucun **overflow horizontal** (zéro scroll horizontal involontaire) ;
- [ ] menu **burger** ou **drawer** fonctionnel ;
- [ ] taille de police body **≥ 16 px** (pas plus petit) ;
- [ ] CTA atteignable au pouce (zone ≥ 44 × 44 px) ;
- [ ] images responsives (`max-width: 100%`) ;
- [ ] pas de hover-only critique (mobile = pas de hover) ;
- [ ] formulaires accessibles ;
- [ ] sticky CTA bottom si pertinent (e-commerce, booking) ;
- [ ] hero : image fonctionne en portrait (recadrage adapté) ;
- [ ] sections empilées verticalement, lisibles ;
- [ ] tables transformées en **cards** (1 ligne = 1 card).

---

## 2. Tablet (640–1023 px)

- [ ] grille passe en 2 colonnes (cards, features) ;
- [ ] menu : burger ou menu horizontal selon préférence ;
- [ ] hero : version tablet ou bascule desktop selon contenu ;
- [ ] espacement ajusté (entre mobile et desktop) ;
- [ ] formulaires : labels + champs alignés correctement.

---

## 3. Desktop (1024–1279 px)

- [ ] menu **horizontal** complet, lisible ;
- [ ] grille 3 ou 4 colonnes (selon densité) ;
- [ ] hero : version desktop avec espace ;
- [ ] container max-width respecté ;
- [ ] padding latéral confortable (32–48 px+).

---

## 4. Grandes résolutions (1280+ px)

- [ ] container **borné** (max-width 1280 ou 1440 px) — sinon les lignes deviennent illisibles ;
- [ ] arrière-plan ou fond unifié au-delà du container ;
- [ ] pas d'éléments qui "flottent" perdus dans l'espace ;
- [ ] images hero avec **version large** ou crop intelligent (object-fit: cover).

---

## 5. Menus

- [ ] menu **mobile** : burger ou drawer, animation propre ;
- [ ] menu **mobile** : bouton fermer visible, fermeture au tap hors menu ;
- [ ] menu **desktop** : items visibles directement ;
- [ ] **indicateur de page active** identique sur tous les breakpoints ;
- [ ] pas de **mega-menu** sur mobile (préférer drawer simple).

---

## 6. Cards

- [ ] **mobile** : empilées en 1 colonne ;
- [ ] **tablet** : 2 colonnes ;
- [ ] **desktop** : 3 ou 4 colonnes selon contenu ;
- [ ] padding interne **proportionnel** à la taille de la card ;
- [ ] images dans les cards : ratio cohérent à tous les breakpoints.

---

## 7. Tables

- [ ] **mobile** : transformées en cards (1 row = 1 card avec labels visibles) ;
- [ ] OU scroll horizontal **assumé** (avec gradient indicatif sur les bords) ;
- [ ] **tablet+** : table normale ;
- [ ] colonnes prioritaires identifiées (le moins critique caché en mobile).

---

## 8. Images

- [ ] `srcset` pour servir la bonne résolution ;
- [ ] `<picture>` pour WebP + JPEG fallback ;
- [ ] `width` et `height` explicites pour éviter CLS ;
- [ ] **lazy-load** sous la ligne de flottaison (`loading="lazy"`) ;
- [ ] **eager** + `fetchpriority="high"` sur le hero LCP ;
- [ ] crop intelligent : ne pas afficher une photo paysage en portrait sans recadrage ;
- [ ] mobile : versions plus petites pour économiser bande passante.

---

## 9. Hero

- [ ] **mobile** : texte lisible, CTA visible, image cadrée ;
- [ ] **tablet** : transition harmonieuse ;
- [ ] **desktop** : pleine puissance, animation si applicable ;
- [ ] hauteur **bornée** (pas un hero qui prend 200 vh sur mobile) ;
- [ ] texte centré ou aligné selon ambiance, mais cohérent à tous les breakpoints.

---

## 10. Formulaires

- [ ] **mobile** : champs en colonne unique ;
- [ ] **tablet+** : possibilité 2 colonnes pour champs courts (prénom + nom) ;
- [ ] champ tel : `type="tel"` (clavier numérique mobile) ;
- [ ] champ email : `type="email"` ;
- [ ] champ date : `type="date"` (picker natif) ;
- [ ] champ nombre : `type="number"` ou `inputmode="numeric"` ;
- [ ] **autocomplete** activé (`autocomplete="given-name"`, etc.) ;
- [ ] focus du premier champ **non automatique** sur mobile (évite le scroll auto vers le formulaire au chargement).

---

## 11. Admin / Dashboard

- [ ] **mobile** : navigation latérale convertie en drawer ;
- [ ] **mobile** : stat cards en 1 ou 2 colonnes ;
- [ ] **mobile** : filtres en accordéon ou modal ;
- [ ] **tablet** : grille 2 colonnes ;
- [ ] **desktop** : layout complet (sidebar + main + panel).

---

## 12. Modals / overlays

- [ ] **mobile** : pleine largeur ou full-screen ;
- [ ] **desktop** : centré avec max-width ;
- [ ] padding interne proportionnel ;
- [ ] bouton fermer (X) toujours accessible ;
- [ ] scroll interne si contenu dépasse la hauteur de l'écran.

---

## 13. Footer

- [ ] **mobile** : colonnes empilées, accordéons si nombreuses sections ;
- [ ] **desktop** : 3–4 colonnes ;
- [ ] copyright et liens légaux toujours visibles ;
- [ ] réseaux sociaux alignés.

---

## Outils de test

- **Chrome DevTools** : Toggle device toolbar (Ctrl+Shift+M / Cmd+Shift+M) ;
- **Firefox** : Responsive Design Mode (Ctrl+Shift+M) ;
- **Safari** : Develop > Enter Responsive Design Mode ;
- **BrowserStack** / **LambdaTest** : tests sur vrais devices ;
- **Lighthouse** : audit responsive ;
- **resizing manuel** de la fenêtre : test final.

---

## Sortie attendue

Après vérification, lister dans le `redesign-report.template.md` :

- breakpoints **testés** ;
- problèmes détectés et **corrigés** ;
- problèmes détectés et **non corrigés** (avec raison) ;
- captures d'écran si possible (3 minimum : mobile, tablet, desktop).

---

Created by João de Almeida — Art of Dev — https://artofdev.space
