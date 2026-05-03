# Checklist finale de cohérence du site — `site-ux-guardian`

Checklist exhaustive à dérouler avant de rendre le rapport final.

Created by João de Almeida

---

## 1. Stack et architecture

- [ ] **stack identifiée** (framework, structure des pages, composants, routes) ;
- [ ] **layouts** principaux repérés (public, admin, auth) ;
- [ ] **CSS** global vs spécifique repéré ;
- [ ] **design system** existant identifié (variables, tokens) si présent.

---

## 2. Cartographie

- [ ] **toutes les pages** listées (publiques, admin, auth, légales, blog, produit, dynamiques, multilingues) ;
- [ ] **pages orphelines** identifiées ;
- [ ] **routes déclarées** vs **routes utilisées** comparées.

---

## 3. Menus

- [ ] menu **desktop** identifié, fichier source repéré ;
- [ ] menu **mobile** identifié, cohérent avec desktop ;
- [ ] menu **admin** identifié si applicable ;
- [ ] **active state** présent ;
- [ ] **libellés cohérents** entre pages ;
- [ ] **liens valides** (pas vers 404) ;
- [ ] **pas de doublons** ;
- [ ] **pas de liens admin** dans le menu public si non souhaité ;
- [ ] **switch langue** présent et fonctionnel si multilingue.

---

## 4. Footers

- [ ] footer **principal** identifié, fichier source repéré ;
- [ ] footer **présent** sur toutes les pages attendues ;
- [ ] **3 colonnes minimum** ;
- [ ] **liens légaux** présents (mentions, RGPD, CGV si applicable) ;
- [ ] **liens sociaux** fonctionnels ;
- [ ] **copyright** avec année dynamique ;
- [ ] **mobile** : colonnes empilées proprement ;
- [ ] **cohérence** entre langues.

---

## 5. Routes et liens

- [ ] **carte du site** établie (pages → liens entrants → liens sortants) ;
- [ ] **aucun lien mort** ;
- [ ] **aucune ancre cassée** ;
- [ ] **aucun bouton sans destination** (`href="#"` non justifié) ;
- [ ] **redirections** fonctionnelles (si présentes) ;
- [ ] **pages orphelines** signalées.

---

## 6. Doublons

- [ ] **composants** doublonnés identifiés (`HeaderV2`, `NewFooter`, etc.) ;
- [ ] **pages quasi identiques** signalées (`/about` + `/about-us`) ;
- [ ] **menus / footers hardcodés** dans plusieurs fichiers signalés ;
- [ ] **fichiers obsolètes** (`.bak`, `*-old`, `*-copy`) signalés ;
- [ ] **CSS redondant** détecté ;
- [ ] **routes concurrentes** signalées.

---

## 7. Discipline fichier

- [ ] pour chaque modification proposée, **fichier exact** identifié ;
- [ ] **layout global** identifié et utilisé prioritairement ;
- [ ] **aucune modification** prévue dans `node_modules/`, `vendor/`, `dist/`, `build/`, fichiers minifiés ;
- [ ] **aucun hardcoding** prévu pour ce qui devrait venir d'une config / DB.

---

## 8. Front / admin

- [ ] **séparation claire** (URL distincte) ;
- [ ] **layouts** distincts (public, admin, auth) ;
- [ ] **navigation admin** présente et cohérente sur toutes les pages admin ;
- [ ] **pages admin protégées** (middleware d'auth) ;
- [ ] **pas de liens admin** dans le menu public ;
- [ ] **retour au site public** depuis l'admin ;
- [ ] **déconnexion** visible.

---

## 9. Multilingue (si applicable)

- [ ] **mêmes pages** disponibles dans chaque langue ;
- [ ] **switch langue** mène à la version équivalente (pas à la home) ;
- [ ] **menus traduits** ;
- [ ] **footers traduits** ;
- [ ] **balises `<html lang>`** correctes ;
- [ ] **`<link rel="alternate" hreflang>`** présentes.

---

## 10. Sécurité basique

- [ ] **admin protégé** ;
- [ ] **pas de routes debug** visibles ;
- [ ] **`.env`** non exposé ;
- [ ] **clé API** non en clair côté front ;
- [ ] **page privée** non indexable ;
- [ ] **action destructive** avec confirmation.

---

## 11. Responsive

- [ ] **4 breakpoints** testés (320 / 768 / 1024 / 1440) ;
- [ ] **menu mobile** fonctionnel ;
- [ ] **aucun overflow horizontal** ;
- [ ] **footer** lisible mobile ;
- [ ] **tables admin** scrollables ou converties en cards ;
- [ ] **CTA** atteignables au pouce ;
- [ ] **images** responsives.

---

## 12. Webdesign guidelines (14 axes)

- [ ] **A.** hiérarchie visuelle ;
- [ ] **B.** lisibilité ;
- [ ] **C.** typographie ;
- [ ] **D.** espacement ;
- [ ] **E.** layout ;
- [ ] **F.** boutons / CTA ;
- [ ] **G.** cards ;
- [ ] **H.** formulaires ;
- [ ] **I.** tables / dashboards ;
- [ ] **J.** images ;
- [ ] **K.** responsive (déjà §11) ;
- [ ] **L.** cohérence visuelle globale ;
- [ ] **M.** accessibilité visuelle ;
- [ ] **N.** anti-template / anti-amateur (test du logo enlevé).

---

## 13. Scoring

- [ ] **score cohérence** site calculé (sur 100) ;
- [ ] **score visuel** calculé (sur 100) ;
- [ ] **score par axe** détaillé (navigation, footer, routes, liens, doublons, front/admin, responsive, sécurité, qualité visuelle).

---

## 14. Rapport final

- [ ] **résumé exécutif** (5 lignes max) ;
- [ ] **problèmes critiques / importants / mineurs** listés ;
- [ ] **fichiers concernés** identifiés ;
- [ ] **corrections appliquées** (Mode 2) listées ;
- [ ] **corrections recommandées** listées ;
- [ ] **délégations** explicites (`premium-webdesigner`, `production-auditor`) si nécessaire ;
- [ ] **prochaine étape** (1 ligne actionnable).

---

## 15. Mode d'exécution respecté

- [ ] **Mode 1** (audit only) si l'utilisateur n'a pas demandé de modifier ;
- [ ] **Mode 2** (corrections sûres) uniquement si demandé explicitement ;
- [ ] **Mode 3** (plan de refonte) avec validation requise.

---

## 16. Règles non-destructives

- [ ] **aucun fichier supprimé** sans accord explicite ;
- [ ] **aucune route cassée** par les corrections ;
- [ ] **aucune donnée dynamique remplacée** par du hardcodé ;
- [ ] **aucune modification massive** sans validation utilisateur ;
- [ ] **chaque correction** annulable par un seul `git revert`.

---

## 17. Public-ready (pour ce skill spécifiquement)

- [ ] aucune référence à un site personnel ;
- [ ] aucune mention d'une marque privée ;
- [ ] signature **"Created by João de Almeida"** uniquement ;
- [ ] exemples génériques.

---

Created by João de Almeida
