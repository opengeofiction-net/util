#!/bin/bash
# Regenerate the openstreetmap-website favicon and logo set from the OGF icon.
#
# The committed files in this directory are what opengeofiction.net has served
# since 2021 (made with RealFaviconGenerator from the OGF logo, then dropped over
# the upstream files in app/assets/favicons and app/assets/images). Run this only
# when the logo changes; the output will differ from the committed set in
# antialiasing detail, not in design.
#
# Needs: librsvg2-bin (rsvg-convert) and imagemagick (for the .ico).
#   sudo apt install -y librsvg2-bin imagemagick
#
# Usage: logo/favicons/generate.sh [source.svg]   (default ../ogf_logo_icon.svg)
set -euo pipefail
cd "$(dirname "$0")"
SRC=${1:-../ogf_logo_icon.svg}

render() { rsvg-convert -w "$2" -h "$2" -o "$1" "$SRC"; }

# Android / web app manifest
for s in 36 48 72 96 144 192; do render android-chrome-${s}x${s}.png $s; done
# Apple touch icons
for s in 57 60 72 76 114 120 144 152 180; do render apple-touch-icon-${s}x${s}.png $s; done
cp apple-touch-icon-180x180.png apple-touch-icon.png
cp apple-touch-icon-180x180.png apple-touch-icon-precomposed.png
# favicons
for s in 16 32 96 194; do render favicon-${s}x${s}.png $s; done
convert favicon-16x16.png favicon-32x32.png favicon-48x48.tmp.png favicon.ico 2>/dev/null || {
	render favicon-48x48.tmp.png 48
	convert favicon-16x16.png favicon-32x32.png favicon-48x48.tmp.png favicon.ico
}
rm -f favicon-48x48.tmp.png
# Windows tiles - square, and the wide one centred on a transparent canvas
for s in 70 144 150 310; do render mstile-${s}x${s}.png $s; done
rsvg-convert -w 150 -h 150 "$SRC" | convert - -background none -gravity center -extent 310x150 mstile-310x150.png
# site logo: the header uses the SVG, the feeds the PNGs
cp "$SRC" osm_logo.svg
for s in 30 100 256; do render osm_logo_${s}.png $s; done

ls -l
