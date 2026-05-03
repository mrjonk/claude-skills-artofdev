<?php
// Created by João de Almeida
// Header WordPress — menu via wp_nav_menu, language switcher placeholder
?>
<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
  <meta charset="<?php bloginfo( 'charset' ); ?>">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
  <header class="site-header">
    <a href="<?php echo esc_url( home_url( '/' ) ); ?>" class="brand">
      <?php bloginfo( 'name' ); ?>
    </a>

    <nav aria-label="<?php esc_attr_e( 'Main navigation', 'mytheme' ); ?>">
      <?php
      wp_nav_menu( array(
        'theme_location' => 'primary',
        'menu_class'     => 'main-menu',
        'fallback_cb'    => false,
      ) );
      ?>
    </nav>

    <?php
    // Placeholder pour le switch langue : sera fourni par WPML / Polylang
    // Le skill doit signaler que ce switcher dépend du plugin choisi.
    ?>
    <ul class="lang-switcher">
      <?php if ( function_exists( 'pll_the_languages' ) ) : ?>
        <?php pll_the_languages( array( 'show_flags' => 0, 'show_names' => 1 ) ); ?>
      <?php else : ?>
        <li><span><?php esc_html_e( 'Language switcher unavailable', 'mytheme' ); ?></span></li>
      <?php endif; ?>
    </ul>
  </header>
