;----------------------------
; Local map within view area
; plus related design data.

drawn_tiles = $0200
world_tiles = $0280

; CONx combat arena files: load address $0240

map_start_foe_x = $0240
map_start_foe_y = $0250
map_start_player_x = $0260
map_start_player_y = $0268

; DNGx room sectors

room_load_addr = $0200

room_start_triggers = $0200
room_start_foe_type = $0210
room_start_foe_x = $0220
room_start_foe_y = $0230
room_start_player_x = $0240
room_start_player_y = $0248

; Trigger status, initialized from DNGx data.
; These symbols are accessed with indexing
; by 0,4,8,C for a total of 4 triggers (16 bytes)

dng_trigger_new_tile = $0310
dng_trigger_pos = $0311
dng_trigger_new_pos1 = $0312
dng_trigger_new_pos2 = $0313


; --- VALUES

xy_center_screen = $05
xy_max_dungeon = $07
xy_last_screen = $0b
xy_last_tile_cache = $20
xy_last_towne = $20
xy_fled = $80

xy_max_tile_cache = xy_last_tile_cache - 1


;----------------------------
; Map data in all three contexts
; occupy all 4 pages

towne_map = $e800

dng_map = $e800

world_map_NW = $e800
world_map_NE = $e900
world_map_SW = $ea00
world_map_SE = $eb00


;----------------------------
; (note: see ROST.i for these pages)
; player_stats = $ec00
; party_stats = $ed00


;----------------------------
; Objects (and "mobs", movable-objects or actors)
; Up to 32 can exist.
; Tracking values are sliced by purpose,
; indexed by object ID  0 - 31

object_tile_sprite = $ee00
object_xpos        = $ee20
object_ypos        = $ee40
object_tile_type   = $ee60
object_xpos_prev   = $ee80
object_ypos_prev   = $eea0
; Dungeon only
object_dng_level   = $eec0
; Towne only
npc_movement_ai    = $eec0
npc_dialogue       = $eee0

ai_stationary = $00
ai_random = $01
ai_toward_only = $80
ai_hostile = $ff


; Object ID ranges are grouped by purpose

object_wandering_max = $03
object_mobs_max = $07
object_inanimate_first = $08
object_max = $1f
object_last = $20

;----------------------------
; Up to 16 foes can exist.
; Tracking values are sliced by purpose,
; indexed by foe ID  0 - 15

foes_max = $0f

combat_foe_cur_x       = $ef00
combat_foe_cur_y       = $ef10
combat_foe_prev_x      = $ef20
combat_foe_prev_y      = $ef30
combat_foe_hp          = $ef40
combat_foe_tile_type   = $ef50
combat_foe_tile_sprite = $ef60
combat_foe_slept       = $ef70
combat_player_xpos     = $ef80
combat_player_ypos     = $ef90
combat_player_tile     = $efa0

combat_unused          = $efb0

attack_sprite          = $effd
target_x               = $effe
target_y               = $efff
