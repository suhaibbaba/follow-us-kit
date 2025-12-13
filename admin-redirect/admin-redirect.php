<?php
/**
 * Plugin Name: Admin Only Access - Nginx Redirect
 * Description: Redirects all non-admin users to /follow-us location (handled by Nginx)
 * Version: 1.0
 * Author: Your Name
 */

// Prevent direct access
if (!defined('ABSPATH')) exit;

// Redirect non-admin users to nginx-defined follow-us location
function redirect_non_admins_to_nginx_location() {
    // Skip if user is admin
    if (current_user_can('administrator')) {
        return;
    }
    
    // Skip if on admin area
    if (is_admin()) {
        return;
    }
    
    // Skip for AJAX requests
    if (wp_doing_ajax()) {
        return;
    }
    
    // Skip if already on follow-us path
    $request_uri = $_SERVER['REQUEST_URI'];
    if (strpos($request_uri, '/follow-us') === 0) {
        return;
    }
    
    // Redirect to nginx location
    wp_redirect('/follow-us', 302);
    exit;
}
add_action('template_redirect', 'redirect_non_admins_to_nginx_location');

// Block WordPress from processing follow-us URLs
function block_wordpress_follow_us_processing() {
    $request_uri = $_SERVER['REQUEST_URI'];
    if (strpos($request_uri, '/follow-us') === 0) {
        // Let Nginx handle it, don't let WordPress process
        exit;
    }
}
add_action('init', 'block_wordpress_follow_us_processing', 1);
?>