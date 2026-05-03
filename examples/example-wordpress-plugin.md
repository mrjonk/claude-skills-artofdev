# Exemple — Plugin WordPress

## Prompt utilisateur

> *"Prépare un repo plugin WordPress pour un widget de réservation pour coiffeurs."*

## Type détecté

`wordpress-plugin`

## Ce que le skill doit produire

- arborescence `wordpress-plugin` (cf. `references/repo-structure-guide.md` §4) ;
- fichier principal `<slug>.php` avec **header plugin standard** ;
- `readme.txt` au format wordpress.org (Tags, Stable tag, Tested up to, etc.) ;
- structure `includes/`, `admin/`, `public/`, `languages/` ;
- `uninstall.php` minimal mais propre ;
- `LICENSE` : **GPL-2.0-or-later** (compatible wordpress.org), pas MIT ;
- documentation des hooks WordPress utilisés (nonces, capabilities, sanitisation, échappement).

## Structure attendue

```txt
wp-coiffeur-booking/
├── README.md
├── readme.txt
├── CHANGELOG.md
├── ROADMAP.md
├── LICENSE
├── .gitignore
├── wp-coiffeur-booking.php
├── uninstall.php
├── includes/
│   ├── class-wp-coiffeur-booking.php
│   ├── class-wp-coiffeur-booking-loader.php
│   └── class-wp-coiffeur-booking-i18n.php
├── admin/
│   ├── class-wp-coiffeur-booking-admin.php
│   ├── css/
│   ├── js/
│   └── partials/
├── public/
│   ├── class-wp-coiffeur-booking-public.php
│   ├── css/
│   ├── js/
│   └── partials/
├── languages/
│   └── wp-coiffeur-booking.pot
└── docs/
    └── architecture.md
```

## Header de `wp-coiffeur-booking.php` attendu

```php
<?php
/**
 * Plugin Name:       WP Coiffeur Booking
 * Plugin URI:        https://artofdev.space/plugins/wp-coiffeur-booking
 * Description:       Widget de réservation pour salons de coiffure.
 * Version:           0.1.0
 * Requires at least: 6.0
 * Requires PHP:      8.0
 * Author:            João de Almeida — Art of Dev
 * Author URI:        https://artofdev.space
 * License:           GPL-2.0-or-later
 * License URI:       https://www.gnu.org/licenses/gpl-2.0.html
 * Text Domain:       wp-coiffeur-booking
 * Domain Path:       /languages
 */

if ( ! defined( 'ABSPATH' ) ) {
    exit;
}
```

## Points de contrôle qualité

- [ ] header de plugin complet et conforme (Plugin Name, Version, Author, License, Text Domain, Domain Path) ;
- [ ] `readme.txt` au format wordpress.org (sections obligatoires : Tags, Stable tag, Tested up to, Description, Installation, Changelog) ;
- [ ] `uninstall.php` présent, sécurisé (`if ( ! defined( 'WP_UNINSTALL_PLUGIN' ) ) exit;`) ;
- [ ] aucun appel direct à `$_GET` / `$_POST` sans `sanitize_*()` et nonces ;
- [ ] toutes les sorties `echo` doivent passer par `esc_html()`, `esc_attr()`, `esc_url()` ;
- [ ] aucun fichier de config CDN tiers non documenté ;
- [ ] license GPL-2.0-or-later (pas MIT) ;
- [ ] `docs/architecture.md` mentionne nonces, capabilities, sanitisation, échappement ;
- [ ] `check-repo-safety.sh` ne déclenche aucune alerte.

## Commandes Git/GitHub préparées (non exécutées)

```bash
cd wp-coiffeur-booking
git init -b main
git add README.md readme.txt CHANGELOG.md ROADMAP.md LICENSE .gitignore \
        wp-coiffeur-booking.php uninstall.php \
        includes/ admin/ public/ languages/ docs/
git status
git commit -m "init: scaffolding plugin WP via repo-builder"

# À valider avant exécution :
gh repo create wp-coiffeur-booking --private --source=. --remote=origin
git push -u origin main
```

## Hypothèses faites

- préfixe `wp-` (convention WordPress).
- license GPL-2.0-or-later (recommandé pour publication wordpress.org).
- structure orientée objet (convention "WordPress Plugin Boilerplate").
- pas d'asset compilé : CSS/JS écrits à la main.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
