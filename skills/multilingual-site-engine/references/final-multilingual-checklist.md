# Checklist multilingue finale — `multilingual-site-engine`

Liste de contrôle complète à appliquer avant de considérer un site multilingue *"prêt"*.

Created by João de Almeida

---

## 1. Cadrage langues

- [ ] langue **source** confirmée ;
- [ ] langues **cibles** confirmées ;
- [ ] langue **par défaut** définie ;
- [ ] **fallbacks** documentés ;
- [ ] **variantes régionales** précisées si pertinent (`fr-CH`, `pt-BR`).

---

## 2. Architecture i18n

- [ ] bibliothèque **i18n choisie** et installée ;
- [ ] **fichiers de traduction** par langue créés ;
- [ ] **clés** cohérentes entre langues (mêmes clés partout) ;
- [ ] **namespaces** organisés par feature (pas un fichier monolithique) ;
- [ ] **lazy loading** par locale si bundle > 200 KB ;
- [ ] **fallback** explicite (pas de crash si clé manquante) ;
- [ ] **détection de langue** documentée (URL, cookie, sélecteur) ;
- [ ] aucune **chaîne hardcodée** non extraite dans le code de production.

---

## 3. Pages traduites

- [ ] **home** ;
- [ ] **about / à propos** ;
- [ ] **services / produits** ;
- [ ] **pricing / tarifs** ;
- [ ] **blog / articles** ;
- [ ] **contact** ;
- [ ] **mentions légales** ;
- [ ] **politique de confidentialité** ;
- [ ] **CGV / CGU** si applicable ;
- [ ] **politique cookies** si trackers ;
- [ ] **pages auth** (login, register, reset, MFA) ;
- [ ] **pages erreur** (404, 500, maintenance) ;
- [ ] **pages compte** (profil, settings, billing) ;
- [ ] **pages dashboard** si applicable ;
- [ ] **pages catégorie** si blog / e-commerce ;
- [ ] **pages dynamiques** (articles, produits) — toutes les entrées critiques ont une version par langue.

---

## 4. Menus et footers

- [ ] **menu** traduit dans toutes les langues ;
- [ ] **mêmes liens, même ordre** dans chaque langue ;
- [ ] **switch langue** présent sur toutes les pages ;
- [ ] **switch langue** redirige vers la même page traduite ;
- [ ] **CTA principal** traduit ;
- [ ] **footer** traduit ;
- [ ] **mentions légales** traduites par langue ;
- [ ] **liens internes** du footer pointent vers la bonne version ;
- [ ] **liens sociaux** présents dans chaque langue (URL identiques) ;
- [ ] **copyright** avec année dynamique et marque traduite ;
- [ ] **newsletter** traduite (label, bouton, succès, erreur) ;
- [ ] **mobile** identique aux desktops ;
- [ ] **composant unique** partagé (pas un Header par langue).

---

## 5. Formulaires

- [ ] **labels** traduits ;
- [ ] **placeholders** traduits ;
- [ ] **aide contextuelle** traduite ;
- [ ] **boutons** traduits ;
- [ ] **erreurs validation client** traduites ;
- [ ] **erreurs validation serveur** traduites ou mappées ;
- [ ] **messages succès** traduits ;
- [ ] **CTA conditions** traduits.

---

## 6. Emails et notifications

- [ ] **emails transactionnels** traduits par langue ;
- [ ] **sujet** traduit ;
- [ ] **préheader** traduit ;
- [ ] **corps** traduit ;
- [ ] **CTA** traduit ;
- [ ] **footer email** (désinscription, adresse) traduit ;
- [ ] **gabarit par langue** existe ;
- [ ] **langue de l'email** définie (langue du compte recommandée) ;
- [ ] **notifications push** traduites ;
- [ ] **notifications in-app** (toast, modal, snackbar) traduites ;
- [ ] **SMS** traduits si applicable ;
- [ ] **emails marketing** traduits si dans le scope.

---

## 7. Microcopies

- [ ] **tooltips** traduits ;
- [ ] **breadcrumbs** traduits ;
- [ ] **états vides** traduits ;
- [ ] **loaders** traduits ;
- [ ] **badges** traduits ;
- [ ] **tooltips d'icônes** traduits ;
- [ ] **textes alt** des images traduits ;
- [ ] **legends** des images traduites.

---

## 8. SEO multilingue

- [ ] balises `<title>` traduites ;
- [ ] balises `<meta description>` traduites ;
- [ ] balises `hreflang` réciproques sur chaque page ;
- [ ] `x-default` présent ;
- [ ] balise `<html lang>` correcte sur chaque page ;
- [ ] `canonical` correct sur chaque version ;
- [ ] balises **OpenGraph** (`og:locale`, `og:locale:alternate`) ;
- [ ] balises **Twitter Card** ;
- [ ] **sitemap** multilingue avec `xhtml:link` ;
- [ ] **structured data** (JSON-LD) traduit si applicable ;
- [ ] **robots.txt** cohérent ;
- [ ] **pas de redirection** automatique par `Accept-Language`.

---

## 9. Routes et slugs

- [ ] **stratégie unique** appliquée ;
- [ ] **slugs traduits** (si stratégie choisie) avec mapping ;
- [ ] aucune **collision** de slug ;
- [ ] **redirections 301** en place pour les anciens slugs ;
- [ ] **liens internes** localisés ;
- [ ] **switch langue** redirige vers la même page traduite ;
- [ ] aucune **route cassée** dans une langue.

---

## 10. CMS et contenu dynamique

- [ ] modèle de DB / CMS adapté multi-locale ;
- [ ] **toutes les entrées critiques** traduites ;
- [ ] **catégories** traduites ;
- [ ] **tags** traduits ;
- [ ] **slugs** configurés par locale ;
- [ ] **alt text** des images traduit ;
- [ ] **excerpts** / descriptions traduits ;
- [ ] **metadata SEO custom** (Yoast, RankMath) traduits ;
- [ ] **fallback** géré (pas de version → langue par défaut).

---

## 11. Formats locaux

- [ ] **dates** au format local ;
- [ ] **heures** au format local ;
- [ ] **nombres** au format local ;
- [ ] **monnaie** au format local ;
- [ ] **pluriels** gérés par MessageFormat ou équivalent ;
- [ ] **adresses** au format local ;
- [ ] **téléphones** avec préfixe international ;
- [ ] **noms** au bon ordre ;
- [ ] **fuseau horaire** géré ;
- [ ] **premier jour de la semaine** localisé ;
- [ ] **CSV** avec séparateur adapté.

---

## 12. RTL (si applicable)

- [ ] `dir="rtl"` sur les pages RTL ;
- [ ] **CSS logique** (`margin-inline-start`) ou variantes RTL ;
- [ ] **icônes directionnelles** inversées ;
- [ ] **sidebar** / menu inversés ;
- [ ] **police compatible** chargée ;
- [ ] **alignement texte** adapté ;
- [ ] **formulaires** testés en RTL ;
- [ ] **emails** préparés en RTL ;
- [ ] **animations** adaptées ;
- [ ] relecture par locuteur natif si possible.

---

## 13. Qualité de traduction

- [ ] **fidèle au sens** (pas de littéralisme) ;
- [ ] **naturelle** (lecture fluide pour un natif) ;
- [ ] **culturellement adaptée** (idiomes, ton) ;
- [ ] **variables préservées** (`{name}`, `%s`, `{{count}}`) ;
- [ ] **terminologie cohérente** (un terme = une traduction) ;
- [ ] **registre UI** adapté (bouton court, erreur claire) ;
- [ ] **pas de style IA** (tirets longs en boucle, phrases creuses) ;
- [ ] **ponctuation locale** correcte (espaces insécables FR) ;
- [ ] **tutoiement / vouvoiement** cohérent ;
- [ ] aucune **faute** d'orthographe ou de grammaire.

---

## 14. Humanisation

- [ ] **tirets longs** comptés et corrigés (≤ 1 par paragraphe sauf rhétorique) ;
- [ ] **phrases creuses** supprimées ;
- [ ] **adjectifs marketing** remplacés par des faits ;
- [ ] **introductions** raccourcies ;
- [ ] **conclusions vides** supprimées ;
- [ ] **voix de marque** cohérente.

---

## 15. Tests

- [ ] **navigation** dans chaque langue OK ;
- [ ] **formulaires** soumis dans chaque langue ;
- [ ] **emails** reçus dans chaque langue ;
- [ ] **switch langue** depuis chaque page testé ;
- [ ] **mobile** fonctionne ;
- [ ] **performances** équivalentes par langue ;
- [ ] **bundle** par locale raisonnable ;
- [ ] **404 / 500** custom par langue.

---

## 16. Scores

- [ ] **Translation Quality Score** calculé ;
- [ ] **Multilingual Site Readiness Score** calculé ;
- [ ] **rapport final** rendu (`final-multilingual-report.template.md`) ;
- [ ] **prochaine étape** actionnable communiquée.

---

Created by João de Almeida
