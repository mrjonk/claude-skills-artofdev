# Exemples — `site-ux-guardian`

Created by João de Almeida

10 prompts prêts à copier. Public-ready, réutilisables tels quels.

---

## 1. Audit menus + footers

```txt
/site-ux-guardian Vérifie que le menu et le footer sont cohérents sur toutes
les pages, y compris mobile et admin.

Stack : à détecter.

Sortie attendue :
- liste des fichiers contenant menu / footer ;
- détection si menu hardcodé dans plusieurs fichiers ;
- vérification cohérence libellés FR/EN si multilingue ;
- vérification active state ;
- vérification mobile = desktop ;
- liens morts détectés ;
- recommandations de consolidation si menu dupliqué.

Mode : audit only.
```

---

## 2. Audit routes et pages orphelines

```txt
/site-ux-guardian Cartographie toutes les routes du site.

Vérifie :
- routes déclarées (router config) ;
- routes utilisées (liens dans le code) ;
- pages orphelines (présentes mais non liées) ;
- liens morts (vers 404 prévisibles) ;
- routes concurrentes (/about + /about-us) ;
- redirections en place ;
- liens vers # / javascript:void(0).

Produire la carte du site et signaler les problèmes.
Mode : audit only.
```

---

## 3. Audit doublons

```txt
/site-ux-guardian Audit doublons sur tout le repo.

Cherche :
- composants doublons (HeaderV2, NewFooter, etc.) ;
- fichiers .bak / *-old / *-copy ;
- pages quasi identiques ;
- menus / footers hardcodés dans plusieurs fichiers ;
- CSS redondant ;
- routes concurrentes.

Produire le tableau des doublons + plan de consolidation phasé.
Ne supprime rien sans accord.
Mode : audit only.
```

---

## 4. Audit cohérence front / admin

```txt
/site-ux-guardian Audit cohérence entre site public et admin.

Vérifie :
- séparation claire (URL distincte) ;
- pages admin protégées (auth) ;
- navigation admin présente sur toutes les pages admin ;
- pas de liens admin dans le menu public ;
- retour vers le site public depuis l'admin ;
- déconnexion visible ;
- pages admin avec états vides / chargement / erreur ;
- termes humains uniquement dans l'UI admin (pas "endpoint", "schema") ;
- design system partagé mais layouts distincts.

Mode : audit only.
```

---

## 5. Audit responsive navigation

```txt
/site-ux-guardian Audit responsive navigation.

Tester aux 4 breakpoints (320 / 768 / 1024 / 1440) :
- menu burger / drawer fonctionnel ;
- mêmes liens mobile / desktop ;
- sidebar admin collapsible ;
- footer lisible mobile ;
- tables admin scrollables ou converties en cards ;
- CTA atteignables au pouce (≥ 44 × 44 px) ;
- aucun overflow horizontal ;
- switch langue accessible mobile.

Mode : audit only.
```

---

## 6. Audit sécurité basique

```txt
/site-ux-guardian Audit sécurité basique.

Vérifie (uniquement les problèmes évidents — pas un audit sécurité profond) :
- admin protégé (middleware d'auth) ;
- pas de routes debug visibles (/debug, /info.php, /phpinfo) ;
- .env non exposé dans le webroot ;
- clé API non en clair côté front ;
- pages privées non indexables ;
- actions destructives avec confirmation ;
- formulaires avec CSRF (signaler si absent).

Pour audit sécurité profond, recommander production-auditor.
Mode : audit only.
```

---

## 7. Audit webdesign guidelines

```txt
/site-ux-guardian Audit webdesign guidelines (14 axes).

Vérifier :
A. Hiérarchie visuelle (un H1, structure H2/H3, CTA dominant)
B. Lisibilité (16 px+, contraste AA, line-height 1.4-1.6)
C. Typographie (max 2 familles, 3 poids, échelle géométrique)
D. Spacing (échelle géométrique, padding mobile ≥ 16 px)
E. Layout (grilles cohérentes, container max-width)
F. Buttons / CTA (3 variantes max, états hover/focus, libellés clairs)
G. Cards (radius / border / shadow / padding cohérents)
H. Formulaires (labels visibles, focus, erreurs localisées)
I. Tables / dashboards (pagination, états vides, responsive)
J. Images (cohérence, alt text, ratios, optimisation)
K. Responsive (4 breakpoints, no overflow horizontal)
L. Cohérence globale (mêmes composants partout)
M. Accessibilité visuelle (contraste, focus, alt)
N. Anti-template (test du logo enlevé)

Score visuel sur 100 + score par axe.
Mode : audit only.
```

---

## 8. Audit lecture seule (Mode 1, défaut)

```txt
/site-ux-guardian Audit complet, lecture seule.

Aucune modification. Juste un rapport avec :
- score cohérence site (0-100)
- score visuel (0-100)
- score par axe (navigation, footer, routes, liens, doublons, front/admin,
  responsive, sécurité, webdesign)
- problèmes critiques / importants / mineurs
- fichiers concernés
- corrections recommandées
- délégations vers premium-webdesigner / production-auditor si applicable
- prochaine étape actionnable.

Stack : à détecter.
```

---

## 9. Audit avec corrections sûres (Mode 2)

```txt
/site-ux-guardian Audit + corrections sûres autorisées.

Fais l'audit complet, puis applique uniquement les corrections SÛRES :
- ajouter <title> / <meta description> manquants ;
- ajouter alt non vide sur images informatives ;
- corriger typos évidentes ;
- ajouter aria-current="page" sur liens actifs ;
- retirer les console.log / var_dump oubliés ;
- harmoniser les radius des cards si évident.

Pas de :
- refonte massive ;
- suppression de pages ;
- modification de routes ;
- modification d'auth admin ;
- création de doublons.

Documenter chaque fichier modifié dans le rapport.
```

---

## 10. Plan de refonte ergonomique (Mode 3)

```txt
/site-ux-guardian Produire un plan de refonte ergonomique détaillé.

Audit complet, puis plan en phases :
1. Bloquants (priorité 1)
2. Navigation / menu / footer (priorité 2)
3. Sécurité basique (priorité 1-2)
4. Visuelles sûres (priorité 2)
5. Visuelles à valider (priorité 2-3)
6. Délégation premium-webdesigner si applicable
7. Tests finaux

Pour chaque phase :
- liste des actions ;
- fichiers concernés ;
- risque ;
- validation requise.

Pas de modification immédiate. Je validerai phase par phase.
```

---

## Notes d'utilisation

- **Tous ces prompts sont génériques** — réutilisables tels quels par n'importe qui.
- **Aucune référence privée** : pas de marque, site personnel, projet spécifique.
- **À adapter** selon la stack et le contexte du projet où on les utilise.

---

Created by João de Almeida
