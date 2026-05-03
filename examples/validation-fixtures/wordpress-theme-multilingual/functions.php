<?php
// Created by João de Almeida
// functions.php — bootstrap du thème, déclaration du textdomain.

if ( ! defined( 'ABSPATH' ) ) {
    exit;
}

/**
 * Charge le textdomain `mytheme` depuis /languages.
 */
function mytheme_load_textdomain() {
    load_theme_textdomain( 'mytheme', get_template_directory() . '/languages' );
}
add_action( 'after_setup_theme', 'mytheme_load_textdomain' );

/**
 * Enregistre les emplacements de menu utilisés par le thème.
 */
function mytheme_register_menus() {
    register_nav_menus( array(
        'primary' => __( 'Primary menu', 'mytheme' ),
        'footer'  => __( 'Footer menu', 'mytheme' ),
    ) );
}
add_action( 'after_setup_theme', 'mytheme_register_menus' );

/**
 * Active les supports basiques.
 */
function mytheme_setup() {
    add_theme_support( 'title-tag' );
    add_theme_support( 'post-thumbnails' );
    add_theme_support( 'html5', array( 'search-form', 'comment-form', 'comment-list', 'gallery', 'caption' ) );
}
add_action( 'after_setup_theme', 'mytheme_setup' );
