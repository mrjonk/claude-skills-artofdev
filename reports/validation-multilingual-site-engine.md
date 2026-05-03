# Validation — `multilingual-site-engine`

> Date : 2026-05-03
> Type : validation **statique** + fixtures testables
> Runtime non observé dans cette session
> Created by João de Almeida

---

## Avertissement honnête

Cette validation est **statique uniquement**. Le skill `multilingual-site-engine` n'a **pas** été exécuté en runtime dans une vraie session Claude Code. Ce rapport décrit :

1. ce que la spec écrite **promet** ;
2. ce que la spec **devrait** produire face aux fixtures ;
3. les **trous** détectés dans la spec en confrontant les fixtures à la documentation existante ;
4. les **fixtures testables** qu'un humain peut utiliser pour confirmer ou infirmer ces conclusions en runtime.

**Ce rapport ne prétend pas que le skill a été testé en live.** Le test runtime fait l'objet d'une session séparée et est documenté comme « à faire » dans la section finale.

---

## Méthodologie d'évaluation

### Lecture de la spec

Lecture intégrale des fichiers suivants du skill :

- `skills/multilingual-site-engine/SKILL.md` (417 lignes) ;
- `skills/multilingual-site-engine/README.md` (235 lignes) ;
- `skills/multilingual-site-engine/references/multilingual-methodology.md` (12 étapes) ;
- `skills/multilingual-site-engine/references/i18n-architecture-guide.md` (couvre 12 stacks) ;
- `skills/multilingual-site-engine/references/anti-ai-style-guide.md` (détection style IA) ;
- `skills/multilingual-site-engine/references/seo-hreflang-guide.md` ;
- `skills/multilingual-site-engine/references/forms-errors-emails-localization.md`.

### Simulation manuelle sur fixtures

Pour chaque fixture créée (PHP statique, Next.js, WordPress thème), j'ai :

1. simulé la **demande utilisateur** la plus probable ;
2. confronté chaque étape de la méthode 12-étapes du skill au contenu de la fixture ;
3. listé ce que le skill **devrait** faire selon la spec ;
4. identifié les **risques** où le skill pourrait échouer ou produire un mauvais output ;
5. estimé manuellement les deux scores attendus (Translation Quality + Multilingual Site Readiness).

### Fixtures testables

Trois fixtures complètes sont fournies dans `examples/validation-fixtures/` pour permettre à un humain de tester le skill en runtime dans une session Claude Code dédiée. Chaque fixture a son `README.md` avec :

- la stack ;
- la demande utilisateur simulée ;
- ce qu'il faut tester ;
- ce qui doit être préservé ;
- le score attendu en estimation manuelle.

---

## Fixture 1 — PHP statique

### Localisation

`examples/validation-fixtures/php-static-multilingual/`

### Contenu

- `index.php` (homepage hero + 3 cards) ;
- `header.php` (menu : Accueil / À propos / Services / Contact) ;
- `footer.php` (4 liens, copyright statique « © 2024 ») ;
- `contact.php` (formulaire labels / placeholders / erreurs / succès) ;
- `services.php` (3 sections, 2 paragraphes au style IA, tirets longs en boucle) ;
- `lang/fr.php` (amorce i18n minimale) ;
- `email-templates/welcome.php` (placeholders `{{user_name}}`, `{{verification_link}}`) ;
- `assets/style.css` (commentaire piège « to be translated »).

### Demande utilisateur simulée

> *"Traduis ce site PHP en anglais. La langue source est le français."*

### Comportement attendu (selon SKILL.md)

#### §5 — Demande des langues

Les langues source (FR) et cible (EN) sont **précisées dans la demande**. Le skill **ne doit donc PAS reposer la question**. La spec §5 dit explicitement *« si l'utilisateur n'a pas précisé »* → ici l'utilisateur a précisé, le skill enchaîne directement.

#### §6 Étape 1 — Cadrage langues

- Source : `fr` ;
- Cible : `en` ;
- Langue par défaut : `fr` (déduction logique : c'est la langue du contenu existant) ;
- Locale régionale : non précisé → le skill devrait demander si une variante est nécessaire (`en-US` vs `en-GB`).

#### §6 Étape 2 — Détection de la stack

Indices : pas de `package.json`, pas de `composer.json`, pas de `wp-config.php`, fichiers `.php` à la racine, `lang/fr.php` minimal. Le skill devrait conclure : **PHP statique sans framework**.

#### §6 Étape 3 — Inventaire i18n existant

Présence de `lang/fr.php` minimal → amorce i18n détectée. Le skill devrait :

- repérer la convention `lang/{locale}.php` ;
- proposer de la compléter (extraire toutes les chaînes hardcodées) ou de basculer sur une duplication par dossier (`/fr/`, `/en/`).

#### §6 Étape 4 — Cartographie textuelle

Lister les zones :

- titre `<title>ArtOfDev — Studio web premium</title>` dans `header.php` ;
- nav 4 entrées dans `header.php` ;
- hero + 3 cards dans `index.php` ;
- 3 sections + 2 paragraphes IA dans `services.php` ;
- formulaire complet dans `contact.php` (titre, intro, 3 labels, 3 placeholders, 3 messages d'erreur, 1 message de succès, bouton) ;
- footer 4 liens + copyright ;
- email transactionnel `welcome.php` (sujet, salutation, corps, CTA, footer email).

#### §6 Étape 5 — Variables et placeholders

- `{{user_name}}` et `{{verification_link}}` dans `welcome.php` → à préserver ;
- pas d'autre placeholder dans le code.

#### §6 Étape 6 — Style IA

Détection attendue dans `services.php` :

- paragraphe 1 : *« dans le monde d'aujourd'hui »* + 3 tirets longs ;
- paragraphe 2 : *« solution innovante / révolutionnaire / expérience fluide / interface intuitive »* + 3 tirets longs.

Le skill doit **humaniser le source FR avant de traduire** (cf. §6 étape 6 du SKILL.md : *« si le source est généré par IA, traduire fidèlement va propager le bullshit dans toutes les langues »*).

#### §6 Étape 7 — Plan routes

Site PHP statique sans router → deux options :

1. duplication par dossier (`/fr/`, `/en/`) ;
2. front controller léger via `.htaccess` + `index.php`.

Le skill doit **choisir** et **justifier**.

#### §6 Étape 8 — Plan SEO

À ajouter :

- `<html lang="fr">` (déjà présent en dur, à dynamiser) ;
- balises `hreflang` réciproques ;
- canonical par version ;
- sitemap multilingue.

#### §11 — Footer / formulaires / emails

- footer copyright `© 2024` → **statique, à signaler** (date courante : 2026) ;
- formulaire `contact.php` complet → tout traduire ;
- email `welcome.php` → traduire sujet + corps + footer email + CTA, **préserver les placeholders**.

### Risques détectés (revue spec)

| # | Risque | Sévérité |
|---|---|---|
| 1 | Le skill pourrait traduire le commentaire CSS *« to be translated »* (faux positif si lecture trop littérale du fichier) | mineur |
| 2 | Le skill pourrait toucher aux placeholders `{{user_name}}` si la détection de pattern `{{...}}` n'est pas faite | majeur |
| 3 | Le skill pourrait oublier de signaler le copyright statique « © 2024 » (la spec ne couvre pas explicitement le cas du copyright daté) | mineur |
| 4 | Le skill pourrait choisir une stratégie de routes sans la documenter (oubli §6 étape 7) | majeur |
| 5 | Le skill pourrait traduire littéralement les 2 paragraphes IA au lieu d'humaniser **avant** de traduire | majeur |
| 6 | Le skill pourrait proposer d'extraire tout vers `lang/{locale}.php` sans considérer la duplication par dossier comme alternative valide | mineur |
| 7 | Le skill pourrait hardcoder `<html lang="en">` dans le fichier traduit au lieu de **dynamiser** la valeur | majeur |
| 8 | Le skill pourrait traduire `name="email"`, `id="cf-name"` (attributs techniques) | majeur |

### Score readiness attendu (estimation manuelle)

- **Translation Quality** : ~75-85 si la passe humanisation est correctement faite avant traduction. ~55-65 si le skill traduit directement les paragraphes IA sans les humaniser (ils restent au style IA en EN).
- **Multilingual Readiness** : ~30-50 sur l'état brut (pas de routes locale, pas de hreflang, pas de switch langue, pas de `<html lang>` dynamique). Le skill doit **proposer un plan** pour passer à 75+. La sortie attendue est un plan + scores, pas nécessairement l'exécution complète.

### Trous spec à corriger

- la spec **ne couvre pas explicitement** les conventions PHP statique sans framework (le `i18n-architecture-guide.md` mentionne *« site statique pur »* en §2.12 mais reste très court). → Référence ajoutée : `stack-php-static-guide.md`.
- la spec **ne dit pas explicitement** quoi faire d'un copyright daté statique. → Documenté dans le nouveau guide PHP statique §7.1.
- la spec **ne consolide pas** les placeholders dans une référence unique. → Référence ajoutée : `placeholders-and-dynamic-content-rules.md`.

---

## Fixture 2 — Next.js

### Localisation

`examples/validation-fixtures/nextjs-multilingual/`

### Contenu

- `app/page.tsx` (homepage hero + 3 cards + plural ICU) ;
- `app/layout.tsx` (header + footer + `useTranslations`) ;
- `app/contact/page.tsx` (formulaire React avec messages d'erreur) ;
- `messages/en.json` + `messages/fr.json` (clés miroir) ;
- `next-intl.config.ts` (config minimale) ;
- `app/api/contact/route.ts` (API route — code technique).

### Demande utilisateur simulée

> *"Ajoute l'allemand (de) à ce site Next.js. Conserve les mêmes clés et le même format ICU pour les pluriels."*

### Comportement attendu (selon SKILL.md)

#### §5 — Demande des langues

L'utilisateur a précisé : ajout de `de`. Le skill **ne doit pas redemander** la liste de cibles. Il **peut demander** la régionalité (`de-DE` vs `de-CH` vs `de-AT`). La spec §5.2 (méthode) le justifie.

#### §6 Étape 2 — Détection de la stack

Indices clairs : `app/` avec `page.tsx`, `layout.tsx`, `next-intl.config.ts`, `messages/{locale}.json`. Le skill doit conclure : **Next.js App Router + next-intl**.

#### §6 Étape 3 — Inventaire i18n existant

`messages/en.json` et `messages/fr.json` existent. Le skill doit les **diff** pour vérifier que les clés sont identiques. Dans la fixture, elles le sont — mais en runtime, le skill doit le confirmer.

#### §6 Étape 5 — Variables et placeholders

Patterns présents :

- `{count}` dans `home.projects_count` (interpolation simple) ;
- `{name}` (placeholder potentiel, pas dans la fixture mais à anticiper) ;
- `{year}` dans `footer.copyright` (interpolation simple) ;
- ICU plural complet : `{count, plural, =0 {...} one {# ...} other {# ...}}`.

Le skill doit **préserver** ces patterns intacts en allemand.

#### §6 Étape 10 — Traduction

Création de `messages/de.json`. L'allemand a deux catégories de pluriel (`one`, `other`), comme l'anglais — le format ICU peut être copié et seules les chaînes traduites changent.

#### §6 Étape 8 — SEO

Le skill doit **étendre** :

- `next-intl.config.ts` avec `locales: ['en', 'fr', 'de']` ;
- la stratégie hreflang à 3 langues, réciproque ;
- la liste des locales dans `generateMetadata` (si présente) ou la documenter à ajouter.

#### Préservation API route

`app/api/contact/route.ts` contient `INVALID_PAYLOAD` qui est un **code machine**. Le skill **ne doit pas** le traduire. Cf. nouveau guide `stack-nextjs-guide.md` §5.

### Risques détectés (revue spec)

| # | Risque | Sévérité |
|---|---|---|
| 1 | Le skill pourrait casser la syntaxe ICU dans `de.json` (oublier une accolade, mal nommer une catégorie) | majeur |
| 2 | Le skill pourrait traduire les **clés** JSON (`hero` → `held`, `cards` → `karten`) — bug fatal | critique |
| 3 | Le skill pourrait toucher au fichier `app/api/contact/route.ts` et traduire `INVALID_PAYLOAD` | majeur |
| 4 | Le skill pourrait ne pas mettre à jour `next-intl.config.ts` après création de `de.json` | majeur |
| 5 | Le skill pourrait oublier de documenter la stratégie hreflang étendue à 3 langues | mineur |
| 6 | Le skill pourrait calquer le pluriel allemand sur l'anglais sans vérifier que les catégories sont identiques (pour `de` c'est `one`/`other`, mais pour `ru` ce serait différent — le skill doit savoir le détecter) | mineur |
| 7 | Le skill pourrait choisir `de-DE` sans demander à l'utilisateur si une autre variante est attendue | mineur |
| 8 | Le skill pourrait toucher à `useTranslations`, `getMessages`, `NextIntlClientProvider` (code technique) | majeur |

### Score readiness attendu (estimation manuelle)

- **Translation Quality** : ~80-90. L'allemand est une langue facile à traiter pour le skill (langue commune, registre web maîtrisé), à condition qu'il ne calque pas l'anglais.
- **Multilingual Readiness** : ~70-85. L'archi est saine (next-intl bien configuré). Il manque : extension config, recalcul hreflang, vérification du middleware, sitemap. Avec ces ajouts → 85+.

### Trous spec à corriger

- la spec couvre Next.js dans `i18n-architecture-guide.md` §2.2 et §2.3, mais **ne consolide pas** les règles de préservation JSX vs interpolation de chaîne. → Référence ajoutée : `stack-nextjs-guide.md`.
- la spec ne traite pas explicitement la **distinction entre code d'erreur API et message UI**. → Documenté dans `stack-nextjs-guide.md` §5.

---

## Fixture 3 — WordPress thème

### Localisation

`examples/validation-fixtures/wordpress-theme-multilingual/`

### Contenu

- `style.css` (header WP avec `Theme Name`, `Text Domain: mytheme`) ;
- `header.php` (menu via `wp_nav_menu`, switcher Polylang) ;
- `footer.php` (texte via `__()`, `_e()`, `printf` avec placeholders `%1$s`, `%2$s`) ;
- `functions.php` (`load_theme_textdomain`, `register_nav_menus`) ;
- `languages/mytheme.pot` (~16 entrées msgid) ;
- `languages/mytheme-fr_FR.po` (traduction partielle, certaines msgstr vides) ;
- `template-parts/contact-form.php` (formulaire avec `__()` et `esc_attr_e()`).

### Demande utilisateur simulée

> *"Complète la traduction française et ajoute l'allemand (de_DE) à ce thème WordPress."*

### Comportement attendu (selon SKILL.md)

#### §6 Étape 2 — Détection de la stack

Indices : header `Theme Name:` dans `style.css`, `Text Domain: mytheme`, usage de `__()`, `_e()`, `wp_nav_menu`, dossier `languages/`. Le skill doit conclure : **thème WordPress + gettext + plugin Polylang détecté** (présence de `pll_the_languages`).

#### §6 Étape 3 — Inventaire i18n existant

- lecture du `.pot` → 16 entrées ;
- lecture du `.po` français → certaines msgstr vides : `Language switcher unavailable`, `Resources`, `© %1$s %2$s. All rights reserved.`, `Email address`, `Send message`, `Describe your project in a few lines...`, `Jane Doe`, `you@email.com`, `Your message`, `Fields marked with %s are required.`, `Independent web studio building bespoke websites.` (partiellement traduit), `Primary menu`, `Footer menu`, `Contact us` est OK.

#### §6 Étape 5 — Préservation

- textdomain `mytheme` : **jamais traduit** ;
- placeholders `%s`, `%1$s`, `%2$s` : préservés ;
- commentaires `/* translators: ... */` : laissés intacts dans le `.po` (annotations pour traducteur, pas du contenu UI) ;
- header WP dans `style.css` : non traduit (sauf si stratégie locale, hors scope ici) ;
- nom du textdomain dans le nom de fichier : `mytheme-fr_FR.po` doit garder l'underscore et la majuscule (format WP, pas BCP 47).

#### §6 Étape 10 — Traduction

- compléter chaque `msgstr` vide en français ;
- créer `mytheme-de_DE.po` complet ;
- préserver l'ordre des positionnels `%1$s`, `%2$s` (l'allemand a aussi cet ordre dans la phrase « © 2026 ArtOfDev. Alle Rechte vorbehalten. ») ;
- préserver l'en-tête `Plural-Forms` correct pour chaque langue.

#### §6 Étape 12 — Rapport

Le skill doit documenter :

- la commande `msgfmt mytheme-fr_FR.po -o mytheme-fr_FR.mo` (sinon le `.po` ne sera pas chargé par WordPress) ;
- la dépendance Polylang (le switcher dans `header.php` ne fonctionne que si Polylang est installé) ;
- la stratégie hreflang (gérée par Polylang automatiquement, à confirmer dans les options) ;
- la régénération du `.pot` si on étend le thème (`wp i18n make-pot`).

### Risques détectés (revue spec)

| # | Risque | Sévérité |
|---|---|---|
| 1 | Le skill pourrait nommer le `.po` au format BCP 47 (`mytheme-fr-FR.po`) au lieu de `mytheme-fr_FR.po` → WordPress ne le charge pas | critique |
| 2 | Le skill pourrait modifier le textdomain `mytheme` dans le code | critique |
| 3 | Le skill pourrait traduire les commentaires `/* translators: ... */` | mineur |
| 4 | Le skill pourrait oublier l'en-tête `Plural-Forms` correct pour l'allemand | mineur |
| 5 | Le skill pourrait inverser ou casser les positionnels `%1$s`, `%2$s` | majeur |
| 6 | Le skill pourrait générer un `.mo` à la main au lieu de documenter la commande `msgfmt` | majeur |
| 7 | Le skill pourrait essayer de traduire les fonctions `__()`, `_e()` (impossible mais à vérifier) | mineur |
| 8 | Le skill pourrait ne pas signaler la dépendance Polylang du switcher | mineur |
| 9 | Le skill pourrait essayer d'utiliser WPML en parallèle de Polylang (anti-pattern explicitement banni par la spec §12) | majeur |

### Score readiness attendu (estimation manuelle)

- **Translation Quality** : ~70-85 selon la qualité de l'allemand. La fidélité aux conventions WordPress (textdomain figé, format de locale strict) est cruciale.
- **Multilingual Readiness** : ~55-70. L'architecture est correcte côté code, mais le switcher dépend de Polylang (à valider en runtime), les `.mo` doivent être compilés, et le hreflang dépend du plugin.

### Trous spec à corriger

- la spec couvre WordPress dans `i18n-architecture-guide.md` §2.9, mais **ne détaille pas** la convention de nommage `xx_XX` (avec underscore) vs BCP 47 — un piège classique. → Référence ajoutée : `stack-wordpress-theme-guide.md` §4.2.
- la spec ne consolide pas les règles `Plural-Forms` par langue. → Documenté dans `stack-wordpress-theme-guide.md` §9.

---

## Trous spec identifiés (consolidé)

Liste honnête des manques détectés en confrontant la spec aux 3 fixtures :

### Trous mineurs

1. La spec ne dit pas explicitement quoi faire des **copyright dynamiques vs statiques** (date dans le footer).
2. La spec ne consolide pas les **placeholders** dans une référence unique. `i18n-architecture-guide.md` les liste par stack mais sans tableau récap.
3. La spec ne détaille pas les **conventions de nommage de fichiers** par stack (`fr_FR.po` vs `fr-FR.json` vs `fr.json`).

### Trous majeurs

4. La spec **ne couvre pas en profondeur** le PHP statique sans framework. `i18n-architecture-guide.md` §2.12 mentionne le cas en 5 lignes seulement.
5. La spec **ne consolide pas** les règles spécifiques Next.js App Router (App Router vs Pages Router, JSX vs interpolation, API routes).
6. La spec **ne détaille pas** les pièges WordPress (`xx_XX` vs `xx-XX`, Plural-Forms, dépendance plugin pour le switcher hreflang).

### Trous absents (la spec est OK)

- Détection du style IA : très complète (`anti-ai-style-guide.md`).
- SEO multilingue : très complet (`seo-hreflang-guide.md`).
- Formulaires / emails : très complet (`forms-errors-emails-localization.md`).
- Méthode 12 étapes : claire et reproductible.

---

## Fixes appliqués au skill

### Nouvelles références créées

- `skills/multilingual-site-engine/references/stack-php-static-guide.md` (~290 lignes — conventions PHP statique, helper `t()`, structure recommandée, SEO hreflang en PHP, pièges).
- `skills/multilingual-site-engine/references/stack-nextjs-guide.md` (~280 lignes — App Router vs Pages Router, next-intl vs next-i18next, ICU plural par langue, JSX vs interpolation, API routes non traduites, hreflang via `generateMetadata`).
- `skills/multilingual-site-engine/references/stack-wordpress-theme-guide.md` (~290 lignes — textdomain, fonctions `__()`/`_e()`, format `.po`/`.mo`, plugins WPML/Polylang/TranslatePress, Plural-Forms par langue).
- `skills/multilingual-site-engine/references/placeholders-and-dynamic-content-rules.md` (~280 lignes — récap consolidé tous patterns, tableau par stack, procédure de vérification).

### Nouveau template

- `skills/multilingual-site-engine/templates/multilingual-validation-report.template.md` — template pour produire un rapport de validation futur.

### Modification du SKILL.md

- ajout d'une sous-section *"Guides stack-spécifiques"* dans la §18 pointant vers les 4 nouvelles références ;
- ajout d'une mention du nouveau template ;
- aucune suppression, aucune modification du contenu existant.

Le SKILL.md reste sous le seuil de 480 lignes.

---

## Reste à tester en runtime

Liste claire de ce qu'un humain doit confirmer dans une vraie session Claude Code :

### Pour les 3 fixtures

1. Ouvrir une session Claude Code dans le dossier d'une fixture.
2. Lancer la demande utilisateur simulée (cf. README de la fixture).
3. Vérifier que le skill **détecte la stack correctement**.
4. Vérifier qu'il **ne repose pas les questions** déjà répondues dans la demande.
5. Vérifier qu'il **préserve** tous les placeholders / variables / codes machine listés dans le README.
6. Vérifier qu'il **calcule les deux scores**.
7. Vérifier qu'il **produit un rapport** structuré.

### Spécifique fixture 1 (PHP statique)

- [ ] le skill ne traduit pas le commentaire CSS `to be translated` ;
- [ ] le skill préserve `{{user_name}}` et `{{verification_link}}` dans `welcome.php` ;
- [ ] le skill humanise les paragraphes IA de `services.php` **avant** de traduire ;
- [ ] le skill signale le copyright statique « © 2024 » ;
- [ ] le skill propose une stratégie de routes documentée.

### Spécifique fixture 2 (Next.js)

- [ ] le skill ne touche pas à `app/api/contact/route.ts` ;
- [ ] le skill préserve `{count}`, `{year}` dans les chaînes JSON ;
- [ ] le skill préserve la syntaxe ICU plural sans la casser ;
- [ ] le skill met à jour `next-intl.config.ts` pour ajouter `de` ;
- [ ] le skill ne traduit pas les clés JSON ;
- [ ] le skill demande la régionalité allemande (`de-DE` vs `de-CH`) si non précisée.

### Spécifique fixture 3 (WordPress thème)

- [ ] le skill nomme le `.po` allemand `mytheme-de_DE.po` (avec underscore) ;
- [ ] le skill préserve `%1$s`, `%2$s` dans toutes les langues ;
- [ ] le skill complète **toutes** les msgstr vides du `.po` français ;
- [ ] le skill documente la commande `msgfmt` dans le rapport ;
- [ ] le skill signale la dépendance Polylang du switcher ;
- [ ] le skill ne touche pas au textdomain `mytheme`.

### Confiance de la spec après ajouts

Avec les 4 nouvelles références (`stack-php-static-guide.md`, `stack-nextjs-guide.md`, `stack-wordpress-theme-guide.md`, `placeholders-and-dynamic-content-rules.md`), le skill devrait disposer de la documentation suffisante pour traiter les 3 cas correctement, **à condition** que le moteur charge effectivement les bonnes références au bon moment — ce qui ne peut être confirmé qu'en runtime.

---

## Verdict

| Item | Statut |
|---|---|
| Validation **statique** de la spec | ✓ tient la route, problèmes mineurs |
| Trous spec critiques | aucun |
| Trous spec majeurs | 3 identifiés, **tous corrigés** par les nouvelles références |
| Trous spec mineurs | 3 identifiés, partiellement corrigés (consolidations) |
| Fixtures testables | 3 fixtures complètes, README détaillé pour chacune |
| Validation **runtime** | non effectuée dans cette session |

### Conclusion

La spec écrite du skill `multilingual-site-engine` est **solide** sur les sujets transverses (méthodologie, anti-style IA, SEO, formulaires/emails), mais manquait de **profondeur stack-spécifique** sur PHP statique, Next.js App Router, et thèmes WordPress. Les 4 nouvelles références comblent ces trous sans toucher au contenu existant.

Les 3 fixtures fournies sont **réalistes** (taille raisonnable, cas typiques) et **testables** : un humain peut ouvrir une session Claude Code dans n'importe laquelle et vérifier en quelques minutes si le skill se comporte comme la spec le promet.

**Validation runtime : non effectuée dans cette session — voir `reports/v1.0-readiness-audit.md` pour la suite du processus de release.**

---

Created by João de Almeida
