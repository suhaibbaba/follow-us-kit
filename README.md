# Follow Us — link-in-bio kit

A reusable "Follow Us" page for client businesses: one shared template, one config
file per client. No build step, no dependencies, no framework — just static files
that work from `file://` or any static host.

**Adding a client = copy a folder, edit one config file, drop in a logo.**

```
template/
  index.html        # the shared design: CSS + inline SVG icon set + renderer
  config.js         # starter config, copied into every new client
clients/
  organza/
    index.html      # copy of template/index.html — never edit per client
    config.js       # THE ONLY FILE YOU EDIT
    logo.svg        # the client's logo
new-client.sh       # scaffolds clients/<name>/ from the template
```

## Add a client

```bash
./new-client.sh acme-cafe
```

Then:

1. Replace `clients/acme-cafe/logo.svg` with the client's logo (SVG or PNG — point
   `logo` at whatever filename you use).
2. Edit `clients/acme-cafe/config.js`.
3. Open `clients/acme-cafe/index.html` in a browser to preview.

## config.js

```js
window.SITE_CONFIG = {
  name: "Acme Cafe",                 // also becomes the browser tab title
  tagline: "Coffee & pastries",      // optional — hidden when empty or omitted
  logo: "./logo.svg",

  theme: {
    primary: "#235c63",              // re-themes the ENTIRE page
    radius: 18                       // px number, or any CSS length like "1rem"
  },

  links: [
    { icon: "phone",    label: "Call Us",   href: "tel:+972592701910" },
    { icon: "whatsapp", label: "WhatsApp",  href: "https://wa.me/972592701910" },
    { iconUrl: "./tripadvisor.svg", label: "Reviews", href: "https://..." }
  ],

  map: {                             // omit the whole key to hide the map section
    title: "Find Us Here",
    embedUrl: "https://www.google.com/maps/embed?pb=..."
  }
};
```

### Theming

`theme.primary` is the only color you set. The page background, header gradient,
button tints, icons, map frame and focus rings are all derived from it at runtime
as CSS variables, and the header text flips to dark automatically on very light
primaries.

### Icons

Built-in names: `phone`, `whatsapp`, `facebook`, `instagram`, `tiktok`,
`snapchat`, `x`, `youtube`, `email`, `website`. They are inline SVGs in the
template, filled with the theme color. An unknown name falls back to `website`.

For anything not in the set, use `iconUrl` instead of `icon` and point it at a
file in the client folder:

```js
{ iconUrl: "./telegram.svg", label: "Telegram", href: "https://t.me/acme" }
```

To add an icon for *every* client, add it to the `ICONS` object in
`template/index.html` and re-sync (below).

### Link behaviour

`tel:`, `mailto:` and `sms:` links open in the same tab. Everything else gets
`target="_blank"` with `rel="noopener noreferrer"`.

### Google Maps embed

In Google Maps: **Share → Embed a map → Copy HTML**, then paste only the `src`
value of the iframe into `map.embedUrl`.

## Re-sync the template into all clients

After any design change in `template/index.html`, push it to every client folder:

```bash
for d in clients/*/; do cp template/index.html "$d/index.html"; done
```

Client `config.js` and `logo.svg` files are never touched by this — only
`index.html` is replaced, which is why no client-specific edits belong there.

## Deploy

Each client folder is a complete, self-contained site. Upload the folder and
point the domain at it — all paths are relative, so it works from a subdirectory
or from `file://` too.

- **Netlify / Vercel / Cloudflare Pages**: drag-and-drop `clients/<name>/`, or set
  it as the publish directory. No build command.
- **GitHub Pages**: serve the repo and share
  `https://<user>.github.io/<repo>/clients/<name>/`.
- **Any web host / cPanel**: copy the three files into the site root.

## Notes

`follow-us.html` and `public/` are the original single-client page this kit was
built from. `clients/organza/` supersedes them and they can be deleted whenever
you're ready.
