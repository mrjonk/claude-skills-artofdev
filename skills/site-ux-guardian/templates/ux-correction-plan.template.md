# UX correction plan — {{PROJECT_NAME}}

> Plan structuré des corrections UX par priorité.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Score cohérence actuel** : {{X / 100}}
- **Score visuel actuel** : {{X / 100}}
- **Cible** : {{score post-corrections}}

---

## Phase 1 — Corrections UX critiques (priorité 1)

> Bloquent une utilisation propre du site. À traiter en premier.

- [ ] **C-001** : ajouter le H1 manquant sur `/contact`
- [ ] **C-002** : retirer le lien admin visible dans le menu public (`/admin` ne doit pas être listé)
- [ ] **C-003** : corriger l'overflow horizontal sur mobile (page `/pricing`)
- [ ] **C-004** : ajouter le `<meta robots noindex>` sur les pages admin

---

## Phase 2 — Corrections navigation (priorité 1–2)

- [ ] **N-001** : retirer le lien `/old-blog` du footer (404)
- [ ] **N-002** : ajouter le lien `Pricing` au footer (présent dans le menu, absent du footer)
- [ ] **N-003** : ajouter `aria-current="page"` sur les liens actifs du menu
- [ ] **N-004** : corriger la typo dans l'URL `/contat` → `/contact`

---

## Phase 3 — Corrections menu / footer (priorité 2)

- [ ] **M-001** : harmoniser les libellés ("Contact" partout, plus de "Nous contacter")
- [ ] **M-002** : centraliser le menu dans un composant partagé (actuellement hardcodé dans 3 fichiers)
- [ ] **M-003** : compléter le footer en y ajoutant une 4ème colonne (sociaux + newsletter)
- [ ] **M-004** : ajouter les mentions légales si manquantes

---

## Phase 4 — Corrections visuelles sûres (priorité 2)

> Mode 2 OK : corrections évidentes, sans risque.

- [ ] **V-001** : ajout du `<title>` manquant sur `/services`
- [ ] **V-002** : compléter les `alt` text vides sur 5 images informatives
- [ ] **V-003** : harmoniser les radius des cards (3 valeurs détectées : 4, 8, 12 → choisir une)
- [ ] **V-004** : corriger l'alignement du CTA primaire dans la section "Features"
- [ ] **V-005** : retirer les 3 `console.log` oubliés dans `app/page.tsx`

---

## Phase 5 — Corrections visuelles à valider (priorité 2–3)

> Nécessite validation utilisateur avant action.

- [ ] **VV-001** : refonte du hero (actuellement vide, pas d'effet wow) → **valider la direction**
- [ ] **VV-002** : refonte du dashboard admin (cards inégales, pas de hiérarchie) → **valider**
- [ ] **VV-003** : changement de palette (3 couleurs concurrentes détectées) → **valider la nouvelle palette**
- [ ] **VV-004** : remplacement des photos stock corporate → **valider la direction**

---

## Phase 6 — Recommandations `premium-webdesigner`

> Si refonte créative requise, déléguer.

Le score visuel est de **{{X}} / 100**. Si **< 60**, recommander explicitement le skill `premium-webdesigner` :

> *"Le score visuel actuel est {{X}}/100. Les principaux problèmes sont {{liste}}. La correction des incohérences seules ne suffira pas. Je recommande d'utiliser le skill `premium-webdesigner` pour produire une vraie direction artistique avant de continuer."*

Si **≥ 76**, pas de recommandation `premium-webdesigner` nécessaire.

---

## Phase 7 — Tests après corrections

### Tests fonctionnels

- [ ] navigation : tous les liens du menu fonctionnent ;
- [ ] mobile : menu burger / drawer fonctionnel sur 4 breakpoints ;
- [ ] admin : sidebar présente sur toutes les pages admin ;
- [ ] formulaires : envoi + validation + erreurs OK ;
- [ ] pages 404 / 500 : custom et sympas.

### Tests visuels

- [ ] **4 breakpoints** : 320 / 768 / 1024 / 1440 sur 5 pages clés ;
- [ ] **dark mode** (si activé) ;
- [ ] **toutes les langues** (si multilingue).

### Tests d'accessibilité

- [ ] Lighthouse Accessibility ≥ 90 ;
- [ ] navigation **clavier** (Tab uniquement) sur 3 pages ;
- [ ] **focus visible** partout ;
- [ ] **contraste AA** vérifié.

---

## Critères de sortie

Pour chaque phase :

| Phase | Critère de sortie |
|---|---|
| Phase 1 | tous les CRIT corrigés, score cohérence ≥ 70 |
| Phase 2 | aucun lien mort, aucun lien admin public visible |
| Phase 3 | menu/footer cohérents, composant partagé en place |
| Phase 4 | toutes corrections sûres appliquées, 0 erreur visible |
| Phase 5 | refonte validée par utilisateur, plan détaillé |
| Phase 6 | délégation à `premium-webdesigner` si applicable |
| Phase 7 | tous tests passés, score visuel ≥ 76, score cohérence ≥ 76 |

---

## Suivi

| Phase | Statut | Démarré | Terminé |
|---|---|---|---|
| 1 — Corrections critiques | `pending` / `in-progress` / `done` | YYYY-MM-DD | YYYY-MM-DD |
| 2 — Navigation | `pending` | | |
| 3 — Menu / footer | `pending` | | |
| 4 — Visuelles sûres | `pending` | | |
| 5 — Visuelles à valider | `pending` | | |
| 6 — `premium-webdesigner` | `pending` ou `n/a` | | |
| 7 — Tests | `pending` | | |

---

## Prochaine étape

> {{Une phrase actionnable. Ex: "Démarrer Phase 1 — corriger les 4 problèmes critiques. Re-scorer après pour passer en Phase 2."}}

---

Created by João de Almeida
