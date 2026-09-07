# openstreetmap-website favicons and logo

The OGF-branded replacements for `app/assets/favicons/*` and
`app/assets/images/osm_logo*` in the Rails port. They are copied over the
upstream files at deploy time (see *Creating an OSM server* on the admin wiki)
rather than committed to the `ogf` branch of the openstreetmap-website fork,
so a rebase onto upstream never touches them.

The committed set is what the site has served since 2021. `generate.sh`
re-renders the whole set from `../ogf_logo_icon.svg` when the logo changes.

Not included: `browserconfig.xml.erb` and `manifest.json.erb` stay upstream's;
the deploy step edits the tile colour and the app name in place.
