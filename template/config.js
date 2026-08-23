/* -----------------------------------------------------------------------
 * Follow Us — client configuration (starter).
 * This is the ONLY file you edit per client. Never edit index.html.
 *
 * icon:    one of the built-in icons —
 *          phone, whatsapp, facebook, instagram, tiktok,
 *          snapchat, x, youtube, email, website
 * iconUrl: use instead of `icon` to point at your own SVG/PNG file
 * --------------------------------------------------------------------- */
window.SITE_CONFIG = {
  name: "Client Name",
  tagline: "", // optional — the line is hidden when empty
  logo: "./logo.svg",

  theme: {
    primary: "#235c63", // re-themes the whole page
    radius: 18 // corner rounding in px (a CSS value like "1rem" also works)
  },

  links: [
    { icon: "phone", label: "Call Us", href: "tel:+970000000000" },
    { icon: "whatsapp", label: "WhatsApp", href: "https://wa.me/970000000000" },
    { icon: "instagram", label: "Instagram", href: "https://www.instagram.com/username" },
    { icon: "facebook", label: "Facebook", href: "https://www.facebook.com/username" },
    { icon: "website", label: "Website", href: "https://example.com" },
    { icon: "email", label: "Email Us", href: "mailto:hello@example.com" }
  ],

  // Remove or comment out the whole `map` key to hide the map section.
  map: {
    title: "Find Us Here",
    embedUrl: "" // Google Maps → Share → Embed a map → copy the iframe `src`
  }
};
