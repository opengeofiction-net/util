# openstreetmap-website favicons and logo

The OGF-branded replacements for `app/assets/favicons/*` and
`app/assets/images/osm_logo*` in the Rails port. They are copied over the
upstream files at deploy time (see *Creating an OSM server* on the admin wiki)
rather than committed to the `ogf` branch of the openstreetmap-website fork,
so a rebase onto upstream never touches them.

The committed set is rendered by `generate.sh` from `../ogf_logo_icon.svg`, the
square icon with solid `#f4e3e3` insides, so it reads on a dark theme. The set
the site served from 2021 to 2026 had translucent insides from an older
render; do not copy icons back from a server, regenerate them here.

Not included: `browserconfig.xml.erb` and `manifest.json.erb` stay upstream's;
the deploy step edits the tile colour and the app name in place.
