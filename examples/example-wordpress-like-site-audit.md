# Exemple — Audit d'un site WordPress

## Contexte

Site WordPress 6.x avec thème enfant custom + 12 plugins.
~25 pages, blog actif, formulaire de contact (Contact Form 7), boutique en cours d'évaluation (WooCommerce désactivé).

## Demande originale

> *"Audit ergonomique complet du site WordPress. Vérifie cohérence menus / footers, doublons, pages orphelines, sécurité basique, webdesign guidelines. Mode : audit only."*

## Analyse attendue

### Stack identifiée

- **WordPress 6.x** ;
- **thème enfant** custom basé sur un thème parent ;
- 12 plugins actifs ;
- formulaire via **Contact Form 7** ;
- SEO via **Yoast SEO** ;
- caching via **WP Super Cache**.

### Pages détectées

- pages WordPress : home, services, équipe, blog, contact, mentions, RGPD, CGV ;
- articles de blog : 47 articles ;
- pages auth : `/wp-login.php` (par défaut WordPress).

## Fichiers à inspecter

- `wp-content/themes/<theme-enfant>/header.php`
- `wp-content/themes/<theme-enfant>/footer.php`
- `wp-content/themes/<theme-enfant>/functions.php`
- `wp-content/themes/<theme-enfant>/style.css`
- `wp-config.php` (vérifier structure, **pas le contenu**)
- `.htaccess` à la racine
- `robots.txt`

## Problèmes typiques détectés (WordPress)

### Menus

- **Menu primary** créé via WordPress (`wp_nav_menu()`), partagé via `header.php` ;
- **Menu mobile** : utilise le même menu (responsive géré par CSS) ;
- → **OK** (pas de duplication).

### Footers

- **Footer** géré via `footer.php` du thème enfant ;
- widgets footer (4 colonnes) : navigation, contact, réseaux, légal ;
- → **OK**.

### Liens admin dans le menu public

- vérifier qu'il n'y a pas de `wp_nav_menu` qui inclut une URL `/wp-admin/` ;
- vérifier le `Yoast SEO` : `wp-admin` doit être dans `Disallow` du `robots.txt` ;
- → **OK** dans la majorité des cas (WordPress par défaut).

### Plugins doublons

- **Yoast SEO** + **Rank Math** : les deux activés → **conflit**, à signaler.
- **WP Super Cache** + **W3 Total Cache** : ne doivent pas coexister.
- → vérifier la liste des plugins activés.

### Sécurité basique WordPress

- **utilisateur "admin"** : à vérifier. Si présent, drapeau rouge.
- **`wp-config.php`** : doit avoir `AUTH_KEY`, `SECURE_AUTH_KEY`, etc. **uniques** (pas les valeurs par défaut).
- **limit-login-attempts** : présent (plugin recommandé).
- **2FA** : optionnel, recommandé pour les admins.
- **`disallow_file_edit`** : doit être à `true` dans `wp-config.php` (`define('DISALLOW_FILE_EDIT', true);`).
- **préfixe DB** : doit être différent de `wp_` (recommandation OWASP).
- **uploads** : `.htaccess` qui empêche l'exécution PHP dans `/wp-content/uploads/`.

→ Si l'un de ces points manque, signaler.

### Pages légales

- mentions légales : présente ✓
- RGPD / politique de confidentialité : présente ✓
- CGV : présente ✓
- politique cookies : **vérifier** (si Google Analytics activé, doit y avoir un bandeau cookies).

### Webdesign

- thème enfant : direction artistique propre (à évaluer) ;
- typographie : 2 familles (Google Fonts) + sans-serif system ;
- responsive : **OK** théoriquement (thème child de thème responsive) ;
- mais certaines pages **page-builder** (Elementor, Bricks) peuvent avoir des problèmes spécifiques.

### Problèmes WP-spécifiques à signaler

- **`<title>`** : géré par Yoast (vérifier qu'il est unique par page) ;
- **schema.org** : généré par Yoast ;
- **shortcodes orphelins** : si shortcodes utilisés mais le plugin a été désactivé → texte brut affiché ;
- **commentaires** : activés ou désactivés selon la stratégie.

## Corrections sûres (Mode 2)

**Aucune corrections automatiques sur WordPress** car :
- modifier le thème **parent** est interdit (sera écrasé à la mise à jour) ;
- modifier `wp-config.php` est sensible ;
- modifier les plugins est dangereux (sera écrasé) ;
- modifier la base de données est risqué.

→ Toutes les corrections doivent passer par :
- thème **enfant** uniquement ;
- ou par l'admin WordPress (paramètres, widgets, menus).

## Corrections à valider

- [ ] résoudre le conflit Yoast SEO + Rank Math (désactiver l'un) ;
- [ ] vérifier la liste des plugins (potentiel doublons) ;
- [ ] activer `DISALLOW_FILE_EDIT` dans `wp-config.php` ;
- [ ] ajouter le bandeau cookies si Google Analytics activé ;
- [ ] vérifier l'utilisateur "admin" (renommer ou supprimer) ;
- [ ] limit-login-attempts à activer si pas en place.

## Recommandation `production-auditor`

Pour un audit profond WordPress :
- vérifier toutes les protections sécurité (Wordfence ou similaire) ;
- audit des plugins (CVE) ;
- vérifier les backups configurés ;
- vérifier le HTTPS + HSTS ;
- audit de performance (Lighthouse).

→ **`production-auditor`** est plus adapté pour ces points profonds.

## Score cohérence attendu

- **Navigation** : 13 / 15 (WP gère bien les menus) ;
- **Footer** : 9 / 10 (widgets cohérents) ;
- **Routes** : 13 / 15 (WP gère les permalinks) ;
- **Sécurité basique** : 6 / 10 (Yoast + Rank Math conflit, + à vérifier) ;
- **Doublons** : 6 / 10 (plugins potentiellement en doublon) ;
- **Multilingue** : N/A ou variable ;
- **Total cohérence** : ~70 / 100.

## Score visuel attendu

- 70–80 / 100 selon la qualité du thème enfant.

## Rapport final attendu

```markdown
# Final coherence report — Site WordPress

Score cohérence : 70 / 100
Score visuel : 78 / 100
Verdict : Correct avec corrections nécessaires

Top 3 actions :
1. Résoudre le conflit Yoast SEO + Rank Math (désactiver l'un).
2. Activer DISALLOW_FILE_EDIT dans wp-config.php.
3. Vérifier l'utilisateur "admin" (renommer si présent).

Délégations :
- production-auditor : recommandé pour audit profond (CVE plugins, backups, perf).
- premium-webdesigner : optionnel, dépend de la qualité du thème enfant.

Notes WordPress-spécifiques :
- Toutes les corrections doivent passer par le thème enfant ou l'admin WP.
- Ne JAMAIS modifier le thème parent ou les plugins directement.
```

---

Created by João de Almeida
