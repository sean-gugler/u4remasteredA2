; Save game status file "PRTY"
; is located in Zero Page

; --- ADDRESSES

player_xpos = $00
player_ypos = $01
tile_xpos = $02
tile_ypos = $03
map_x = $04
map_y = $05
dest_x = $06
dest_y = $07
britannia_x = $08
britannia_y = $09
current_location = $0a
game_mode = $0b
dungeon_level = $0c
terrain_occlusion = $0d  ;strange that this is saved rather than balloon_movement. Oh well.
player_transport = $0e
party_size = $0f
dng_direction = $10
light_duration = $11
moon_phase_trammel = $12
moon_phase_felucca = $13
horse_mode = $14
player_has_spoken_to_lb = $15
last_sleep = $16
last_humility_check = $17
altar_room_principle = $18  ;waste of Zero Page; this could be in ROST
last_meditated = $19
last_found_reagent = $1a
ship_hull = $1b
move_counter = $1c
;move_counter + 1 = $1d
;move_counter + 2 = $1e
;move_counter + 3 = $1f


; --- VALUES


; current_location

loc_world = $00
loc_castle_britannia = $01
loc_towne_first = $05
loc_village_paws = $0d
loc_dng_first = $11
loc_dng_hythloth = $17
loc_dng_abyss = $18
loc_shrine_first = $19
loc_shrine_sacrifice = $1f

towne_minoc = $03
towne_skara_brae = $05

num_townes = loc_village_paws - loc_towne_first

dng_abyss    = loc_dng_abyss    - loc_dng_first
dng_hythloth = loc_dng_hythloth - loc_dng_first


; game_mode (here)
; game_mode_pre_combat (zp_main.i)

mode_suspended = $00
mode_world = $01
mode_towne = $02
mode_dungeon = $03
mode_combat_wandering = $80
mode_combat_dng_room = $81
mode_combat_inn = $82
mode_shrine = $ff


; altar_room_principle

principle_truth = $00
principle_love = $01
principle_courage = $02
principle_none = $ff


ship_hull_full = $50
ship_hull_with_wheel = $99
