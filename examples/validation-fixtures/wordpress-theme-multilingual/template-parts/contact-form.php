<?php
// Created by João de Almeida
// Template part — formulaire contact, traduit via __() et esc_attr_e()

if ( ! defined( 'ABSPATH' ) ) {
    exit;
}
?>

<section class="contact-form-wrap">
  <h2><?php esc_html_e( 'Contact us', 'mytheme' ); ?></h2>
  <p><?php esc_html_e( 'A question, a project? We reply within 48 hours.', 'mytheme' ); ?></p>

  <form method="POST" action="" class="contact-form">
    <label for="cf-name"><?php esc_html_e( 'Full name', 'mytheme' ); ?></label>
    <input type="text" id="cf-name" name="cf_name"
      placeholder="<?php esc_attr_e( 'Jane Doe', 'mytheme' ); ?>" required>

    <label for="cf-email"><?php esc_html_e( 'Email address', 'mytheme' ); ?></label>
    <input type="email" id="cf-email" name="cf_email"
      placeholder="<?php esc_attr_e( 'you@email.com', 'mytheme' ); ?>" required>

    <label for="cf-message"><?php esc_html_e( 'Your message', 'mytheme' ); ?></label>
    <textarea id="cf-message" name="cf_message" rows="6"
      placeholder="<?php esc_attr_e( 'Describe your project in a few lines...', 'mytheme' ); ?>"></textarea>

    <button type="submit" class="btn-primary">
      <?php esc_html_e( 'Send message', 'mytheme' ); ?>
    </button>

    <p class="form-help">
      <?php
      printf(
        /* translators: %s is a required indicator. */
        esc_html__( 'Fields marked with %s are required.', 'mytheme' ),
        '<span class="required">*</span>'
      );
      ?>
    </p>
  </form>
</section>
