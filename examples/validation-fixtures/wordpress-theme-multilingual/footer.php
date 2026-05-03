<?php
// Created by João de Almeida
// Footer WordPress — texte traduisible via __() et _e()
?>
  <footer class="site-footer">
    <div class="footer-cols">
      <div>
        <h3><?php _e( 'Studio', 'mytheme' ); ?></h3>
        <p><?php _e( 'Independent web studio building bespoke websites.', 'mytheme' ); ?></p>
      </div>
      <div>
        <h3><?php _e( 'Resources', 'mytheme' ); ?></h3>
        <p>
          <?php
          printf(
            /* translators: %s is the current year. */
            esc_html__( 'Last update: %s', 'mytheme' ),
            esc_html( date_i18n( 'Y' ) )
          );
          ?>
        </p>
      </div>
    </div>

    <p class="copyright">
      <?php
      printf(
        /* translators: %1$s is the current year, %2$s is the site name. */
        esc_html__( '© %1$s %2$s. All rights reserved.', 'mytheme' ),
        esc_html( date_i18n( 'Y' ) ),
        esc_html( get_bloginfo( 'name' ) )
      );
      ?>
    </p>

    <?php wp_footer(); ?>
  </footer>
</body>
</html>
