; keyboard INPUT queue, 16 bytes
inbuffer = $0300

; Sprite sheet for tiles
tilemap = $d000


; Pre-calculated tables for HGR bitmap rendering.

; Address of each raster line (8 * 24 = 192 total)
bmplineaddr_lo = $e000
bmplineaddr_hi = $e0c0

; Offsets of each hplot column (7 * 41 = 287 total)
;   Why 41? It covers 0 through 40 inclusive.
;   Really only needs 0 through 39.
bmpcol_byte = $e180
bmpcol_bit = $e29f


TBLS_load_addr = $e000
.assert bmplineaddr_lo = TBLS_load_addr           , error, "TBLS length miscalculated"
.assert bmplineaddr_hi = bmplineaddr_lo + (8 * 24), error, "TBLS length miscalculated"
.assert bmpcol_byte    = bmplineaddr_hi + (8 * 24), error, "TBLS length miscalculated"
.assert bmpcol_bit     = bmpcol_byte    + (7 * 41), error, "TBLS length miscalculated"
.assert $e3be          = bmpcol_bit     + (7 * 41), error, "TBLS length miscalculated"


font_data = $e400
