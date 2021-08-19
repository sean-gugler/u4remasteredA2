; Zero Page
; single-use locations, not shared by other semantics

kbd_buf_count = $46

key_buf = $b0
key_buf_len = $b8
gender_chosen = $bc
char_glyph = $bd
char_bitmap_row = $be
char_rows_left = $bf

magic_aura = $c6
aura_duration = $c7
tile_under_player = $c8
tile_north = $c9
tile_south = $ca
tile_east = $cb
tile_west = $cc
sfx_volume = $cd
console_xpos = $ce
console_ypos = $cf
disk_id = $d0
numdrives = $d1
currdisk_drive1 = $d2
currdisk_drive2 = $d3
curr_player = $d4
target_player = $d5
hexnum = $d6
bcdnum = $d7
;VARIANT $d8
;VARIANT $d9
;VARIANT $da
;VARIANT $db
damage = $dc
reqdisk = $de
currdrive = $df
diskio_track = $e0
diskio_sector = $e1
diskio_command = $e2
diskio_addr_hi = $e3
foe_type_combat = $e6
npc_type = $e6  ;FIXME
game_mode_pre_combat = $e8
turn_counter = $e9

current_draw_line = $f2
balloon_movement = $f4
wind_direction = $f5

temp2_x = $f6
temp2_y = $f7
delta_x = $f8
delta_y = $f9
temp_x = $fa
temp_y = $fb

ptr2 = $fc
;ptr2 + 1 = $fd
ptr1 = $fe
;ptr1 + 1 = $ff


; --- VALUES

aura_none = $25
aura_horn = $5f
aura_jinx = $ca
aura_negate = $ce
aura_protect = $d0
aura_protection = $d0
aura_quickness = $d1

balloon_landed = $01
balloon_steer = $00
balloon_drift = $ff

horse_walk = $00
horse_gallop = $ff

occlusion_on = $00
occlusion_off = $ff

volume_off = $00
volume_on  = $ff

wind_dir_west = $00
wind_dir_north = $01
wind_dir_east = $02
wind_dir_south = $03
