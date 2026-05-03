# Fixture 3 — `wordpress-theme-multilingual`

> Created by João de Almeida
> Fixture de validation pour le skill `multilingual-site-engine`.

## Stack simulée

Thème WordPress classique avec textdomain `mytheme`, prêt pour `.po`/`.mo`.

```
wordpress-theme-multilingual/
├── style.css                           # Header WP officiel + Theme Name / Text Domain
├── header.php                          # Menu via wp_nav_menu, language switcher (Polylang)
├── footer.php                          # Texte via __() et _e(), printf avec placeholders %1$s
├── functions.php                       # load_theme_textdomain + register_nav_menus
├── languages/
│   ├── mytheme.pot                     # Template gettext (~16 entrées msgid)
│   └── mytheme-fr_FR.po                # Traduction partielle (certaines msgstr vides)
└── template-parts/
    └── contact-form.php                # Formulaire avec __() et esc_attr_e()
```

## Demande utilisateur simulée

> *"Complète la traduction française et ajoute l'allemand (de_DE) à ce thème WordPress."*

## Ce que le skill devrait faire

1. **Détecter la stack** WordPress thème + gettext (présence du header `Text Domain: mytheme`).
2. **Lire le `.pot`** pour avoir la liste complète des entrées msgid.
3. **Lire le `.po` français** pour identifier les entrées **vides** ou **manquantes**.
4. **Demander confirmation** : la régionalité allemande est `de_DE` (le sujet le précise) — si non précisée, il aurait fallu demander.
5. **Compléter `mytheme-fr_FR.po`** :
   - `Language switcher unavailable` → *"Sélecteur de langue indisponible"* ;
   - `Resources` → *"Ressources"* ;
   - `© %1$s %2$s. All rights reserved.` → *"© %1$s %2$s. Tous droits réservés."* (placeholders préservés) ;
   - `Email address` → *"Adresse e-mail"* ;
   - `Send message` → *"Envoyer le message"* ;
   - et les autres entrées manquantes.
6. **Créer `mytheme-de_DE.po`** miroir du `.pot`, avec traductions allemandes complètes.
7. **Préserver les placeholders** `%s`, `%1$s`, `%2$s` dans toutes les langues.
8. **Préserver le textdomain `mytheme`** — il est figé dans le code PHP, pas traduisible.
9. **Préserver les codes locale** (`fr_FR`, `de_DE`) — c'est de la donnée WordPress, pas du texte UI.
10. **Documenter dans le rapport** :
    - la nécessité de générer les `.mo` (`msgfmt mytheme-fr_FR.po -o mytheme-fr_FR.mo`) ;
    - l'arbitrage WPML / Polylang / TranslatePress (le code utilise `pll_the_languages` → Polylang) ;
    - les bonnes pratiques i18n WP (textdomain unique, `load_theme_textdomain` en `after_setup_theme`).

## Ce qu'il NE DOIT PAS faire

- traduire les fonctions PHP (`__()`, `_e()`, `esc_html_e()`, `esc_attr_e()`) ;
- traduire le textdomain `mytheme` ni les noms de hooks ;
- traduire les commentaires `/* translators: ... */` (ils sont des notes pour le traducteur, à laisser intacts dans le `.po`) ;
- traduire le header WordPress dans `style.css` (`Theme Name`, `Author`, `License`) ;
- modifier les noms de fichiers (`mytheme-fr_FR.po` doit rester avec ce code locale strict) ;
- toucher aux noms de champs (`cf_name`, `cf_email`) ;
- générer un `.mo` binaire à la main (laisser le soin à `msgfmt`).

## Points de friction attendus

- **Format `.po`** : la syntaxe est stricte (références `#:`, commentaires `#.`, en-têtes obligatoires). Le skill doit les respecter.
- **Placeholders numérotés** `%1$s` et `%2$s` : à préserver dans le **bon ordre** ; en allemand, l'ordre de la phrase peut différer mais on garde les positions de placeholder.
- **Pluriels gettext** : la fixture n'a pas d'entrée `msgid_plural`, mais le skill devrait le mentionner si on étend le thème.
- **Sélecteur de langue Polylang** : le code utilise `pll_the_languages`, qui ne fonctionne que si Polylang est installé. Le skill devrait signaler la dépendance plugin.
- **Régénération du `.pot`** : si on ajoute des chaînes au code PHP plus tard, il faut relancer `wp i18n make-pot` — à mentionner dans le rapport.

## Score readiness attendu (estimation manuelle)

- Translation Quality Score : ~70-85 selon la qualité de l'allemand (registre WordPress propre, pas de calque).
- Multilingual Site Readiness Score : ~55-70 (architecture i18n correcte côté code, mais switch langue dépend du plugin, hreflang doit être confirmé via Polylang, et les `.mo` doivent être compilés).

## Comment tester ce fixture en runtime (humain)

1. Ouvrir une session Claude Code dans ce dossier.
2. Lancer : *"Complète la traduction française et ajoute l'allemand (de_DE) à ce thème WordPress."*
3. Vérifier que le skill :
   - a complété **toutes** les entrées msgstr vides du `.po` français ;
   - a créé `mytheme-de_DE.po` avec les mêmes msgid que le `.pot` ;
   - n'a **pas** modifié les `__()`, `_e()`, ni le textdomain `mytheme` ;
   - a préservé les placeholders `%1$s`, `%2$s`, `%s` ;
   - a documenté la commande `msgfmt` à exécuter ;
   - a signalé la dépendance Polylang dans le rapport ;
   - a calculé les deux scores.
