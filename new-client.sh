#!/usr/bin/env bash
#
# Scaffold a new "Follow Us" client folder from the shared template.
#
#   ./new-client.sh <client-name>
#
# Creates clients/<client-name>/ containing:
#   index.html  — copy of template/index.html (never edit this per client)
#   config.js   — copy of template/config.js  (the only file you edit)
#   logo.svg    — placeholder logo, replace it with the client's own
#
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$ROOT/template"
CLIENTS_DIR="$ROOT/clients"

usage() {
  echo "Usage: $(basename "$0") <client-name>" >&2
  echo "Example: $(basename "$0") acme-cafe" >&2
}

if [ "$#" -ne 1 ] || [ -z "${1:-}" ]; then
  usage
  exit 1
fi

NAME="$1"

if ! printf '%s' "$NAME" | grep -Eq '^[A-Za-z0-9][A-Za-z0-9._-]*$'; then
  echo "Error: '$NAME' is not a valid folder name." >&2
  echo "Use letters, digits, dots, dashes and underscores only." >&2
  exit 1
fi

TARGET="$CLIENTS_DIR/$NAME"

if [ -e "$TARGET" ]; then
  echo "Error: $TARGET already exists — pick another name or delete it first." >&2
  exit 1
fi

for f in index.html config.js; do
  if [ ! -f "$TEMPLATE_DIR/$f" ]; then
    echo "Error: missing $TEMPLATE_DIR/$f" >&2
    exit 1
  fi
done

mkdir -p "$TARGET"
cp "$TEMPLATE_DIR/index.html" "$TARGET/index.html"
cp "$TEMPLATE_DIR/config.js" "$TARGET/config.js"

# Placeholder logo so the page renders before the real artwork arrives.
cat > "$TARGET/logo.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120" role="img" aria-label="Logo placeholder">
  <circle cx="60" cy="60" r="58" fill="#e8eef0"/>
  <text x="60" y="74" text-anchor="middle" font-family="Segoe UI, Arial, sans-serif"
        font-size="42" font-weight="700" fill="#235c63">LOGO</text>
</svg>
SVG

# Pre-fill the client name so the page is not called "Client Name".
if command -v perl >/dev/null 2>&1; then
  perl -pi -e "s/^(\s*name: )\"Client Name\"/\${1}\"$NAME\"/" "$TARGET/config.js"
fi

echo "Created $TARGET"
echo
echo "Next steps:"
echo "  1. Replace $TARGET/logo.svg with the client logo"
echo "  2. Edit    $TARGET/config.js (name, tagline, theme.primary, links, map)"
echo "  3. Preview: open $TARGET/index.html in a browser"
