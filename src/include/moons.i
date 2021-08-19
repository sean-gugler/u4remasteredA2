; --- ADDRESSES

moongate_tile = $ed
moongate_xpos = $ee
moongate_ypos = $ef
moongate_sprite = $f1

; --- VALUES

; moon_glyph_row = $00
trammel_col = $0b
felucca_col = $0c

.macro sta_moon_line N, COL
 	sta screen_HGR1 + ($400 * N) + COL
.endmacro

.macro sta_trammel_line N
 	sta_moon_line N, trammel_col
.endmacro

.macro sta_felucca_line N
 	sta_moon_line N, felucca_col
.endmacro
