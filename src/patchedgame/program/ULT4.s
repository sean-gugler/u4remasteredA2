	.include "uscii.i"
	.include "ULT4.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
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
balloon_flying = $0d
player_transport = $0e
party_size = $0f
dng_direction = $10
light_duration = $11
moon_phase_trammel = $12
moon_phase_felucca = $13
horse_mode = $14
altar_room_principle = $18
ship_hull = $1b
move_counter = $1c
;move_counter + 1 = $1d
;move_counter + 2 = $1e
;move_counter + 3 = $1f
key_buf_len = $b8
foe_type_encountered = $c0
pre_combat_x = $c1
pre_combat_y = $c2
pre_combat_tile = $c3
curr_player_turn = $c5
magic_aura = $c6
aura_duration = $c7
tile_under_player = $c8
tile_north = $c9
tile_south = $ca
tile_east = $cb
tile_west = $cc
music_volume = $cd
console_xpos = $ce
console_ypos = $cf
curr_player = $d4
target_player = $d5
zpd8 = $d8
zpd9 = $d9
zpda = $da
zpdb = $db
damage = $dc
lt_track = $e0
lt_sector = $e1
lt_rwflag = $e2
lt_addr_hi = $e3
foe_type_combat = $e6
game_mode_pre_combat = $e8
turn_counter = $e9
zpea = $ea
zpf0 = $f0
movement_mode = $f4
direction = $f5
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
;
; **** ZP POINTERS ****
;
;ptr2 = $fc
;ptr1 = $fe
;
; **** USER LABELS ****
;
player_has_spoken_to_lb = $0015
last_sleep = $0016
last_humility_check = $0017
last_meditated = $0019
last_found_reagent = $001a
kbd_buf_count = $0046
key_buf = $00b0
charptr = $00bd
diskid = $00d0
numdrives = $00d1
currdisk_drive1 = $00d2
currdisk_drive2 = $00d3
hexnum = $00d6
bcdnum = $00d7
reqdisk = $00de
currdrive = $00df
moongate_tile = $00ed
moongate_xpos = $00ee
moongate_ypos = $00ef
tilerow = $00f2
room_start_triggers = $0200
room_start_foe_type = $0210
room_start_foe_x = $0220
room_start_foe_y = $0230
map_start_foe_x = $0240
room_start_player_y = $0248
map_start_foe_y = $0250
map_start_player_x = $0260
map_start_player_y = $0268
kbd_buffer = $0277
tempmap = $0280
kernal_color = $0286
inbuffer = $0300
dng_trigger_new_tile = $0310
dng_trigger_pos = $0311
dng_trigger_new_pos1 = $0312
dng_trigger_new_pos2 = $0313
music_ctl = $0320
spin_drive_motor = $0323
screen = $0400
j_waitkey = $0800
j_player_teleport = $0803
j_move_east = $0806
j_move_west = $0809
j_move_south = $080c
j_move_north = $080f
j_drawinterface = $0812
j_drawview = $0815
j_update_britannia = $0818
j_primm_cout = $081b
j_primm_xy = $081e
j_primm = $0821
j_console_out = $0824
j_clearbitmap = $0827
j_mulax = $082a
j_get_stats_ptr = $082d
j_printname = $0830
j_printbcd = $0833
j_drawcursor = $0836
j_drawcursor_xy = $0839
j_drawvert = $083c
j_drawhoriz = $083f
j_request_disk = $0842
j_update_status = $0845
j_blocked_tile = $0848
j_update_view = $084b
j_rand = $084e
j_loadsector = $0851
j_playsfx = $0854
j_update_view_combat = $0857
j_getnumber = $085a
j_getplayernum = $085d
j_update_wind = $0860
j_animate_view = $0863
j_printdigit = $0866
j_clearstatwindow = $0869
j_animate_creatures = $086c
j_centername = $086f
j_print_direction = $0872
j_clearview = $0875
j_invertview = $0878
j_centerstring = $087b
j_printstring = $087e
j_gettile_bounds = $0881
j_gettile_britannia = $0884
j_gettile_opposite = $0887
j_gettile_currmap = $088a
j_gettile_tempmap = $088d
j_get_player_tile = $0890
j_gettile_towne = $0893
j_gettile_dungeon = $0896
bitmap = $2000
j_overlay_entry = $8800
talk_lord_british = $8807
file_buf = $8b00
j_dng_check_update = $8c00
j_dng_neighbor_tiles = $8c06
;file_buf+$200 = $8d00
;file_buf+$300 = $8e00
;file_buf+$400 = $8f00
j_peer = $9000
j_fileio = $a100
j_readblock = $a103
j_loadtitle = $a106
j_togglesnd = $a109
j_kernalin = $a10c
j_setirqv = $a10f
j_clearkbd = $a112
j_irqhandler = $a115
j_init_tempmap_cache = $a118
j_flush_tempmap_cache = $a11b
j_save_7e_7f = $a11e
tilecolors1 = $a800
tilecolors2 = $a900
hw_strobe = $c010
hw_speaker = $c030
hw_lcbank1 = $c08b
vic_bordercol = $d020
vic_screencol = $d021
sid_start = $d400
sid_volume = $d418
bmplineaddr_lo = $e000
;bmplineaddr_lo + 7 = $e007
;bmplineaddr_lo + 8 = $e008
;bmplineaddr_lo + 9 = $e009
;bmplineaddr_lo + 10 = $e00a
bmplineaddr_hi = $e0c0
;bmplineaddr_hi + 7 = $e0c7
;bmplineaddr_hi + 8 = $e0c8
;bmplineaddr_hi + 9 = $e0c9
;bmplineaddr_hi + 10 = $e0ca
chrlineaddr_lo = $e180
chrlineaddr_hi = $e198
tilecolors0 = $e1b0
towne_map = $e800
;towne_map+$100 = $e900
;towne_map+$200 = $ea00
;towne_map+$300 = $eb00
player_stats = $ec00
party_stats = $ed00
torches = $ed08
gems = $ed09
keys = $ed0a
sextant = $ed0b
stones = $ed0c
runes = $ed0d
bell_book_candle = $ed0e
threepartkey = $ed0f
food_hi = $ed10
food_lo = $ed11
food_frac = $ed12
gold_hi = $ed13
gold_lo = $ed14
horn = $ed15
wheel = $ed16
skull = $ed17
armour = $ed18
weapons = $ed20
reagents = $ed38
mixtures = $ed40
object_tile_sprite = $ee00
;object_tile_sprite + object_max = $ee1f
object_xpos = $ee20
;object_xpos + object_max = $ee3f
object_ypos = $ee40
;object_ypos + object_max = $ee5f
object_tile_type = $ee60
;object_tile_type + object_max = $ee7f
object_xpos_prev = $ee80
object_ypos_prev = $eea0
object_dng_level = $eec0
npc_dialogue = $eee0
combat_foe_cur_x = $ef00
combat_foe_cur_y = $ef10
combat_foe_prev_x = $ef20
combat_foe_prev_y = $ef30
combat_foe_hp = $ef40
combat_foe_tile = $ef50
combat_foe_drawn_tile = $ef60
combat_foe_slept = $ef70
;combat_player_xpos-1 = $ef7f
combat_player_xpos = $ef80
;combat_player_ypos-1 = $ef8f
combat_player_ypos = $ef90
;combat_player_tile-1 = $ef9f
combat_player_tile = $efa0
attack_sprite = $effd
target_x = $effe
target_y = $efff
tilecolors3 = $f300
kernal_cint = $ff81
kernal_ioinit = $ff84
kernal_ramtas = $ff87
kernal_restor = $ff8a
kernal_vector = $ff8d
kernal_setmsg = $ff90
kernal_second = $ff93
kernal_tksa = $ff96
kernal_memtop = $ff99
kernal_membot = $ff9c
kernal_scnkey = $ff9f
kernal_settmo = $ffa2
kernal_acptr = $ffa5
kernal_ciout = $ffa8
kernal_untlk = $ffab
kernal_unlsn = $ffae
kernal_listen = $ffb1
kernal_talk = $ffb4
kernal_readst = $ffb7
kernal_setlfs = $ffba
kernal_setnam = $ffbd
kernal_open = $ffc0
kernal_close = $ffc3
kernal_chkin = $ffc6
kernal_ckout = $ffc9
kernal_clrch = $ffcc
kernal_basin = $ffcf
kernal_bsout = $ffd2
kernal_load = $ffd5
kernal_save = $ffd8
kernal_settim = $ffdb
kernal_rdtim = $ffde
kernal_stop = $ffe1
kernal_getin = $ffe4
kernal_clall = $ffe7
kernal_udtim = $ffea
kernal_scrorg = $ffed
kernal_plot = $fff0
kernal_iobase = $fff3



	.segment "MAIN"

; main jump table
	jmp game_init

	jmp inn_combat

	jmp initialize_arena

game_init:
	lda #music_off
	jsr music_ctl
	bit hw_lcbank1
	bit hw_lcbank1
	jsr j_drawinterface
	lda #$0d
	sta console_ypos
	lda #$18
	sta console_xpos
	lda #mode_loading
	sta game_mode
	lda #aura_none
	sta magic_aura
	lda #disk_britannia
	jsr j_request_disk
	lda party_size
	beq load_saved_game
	jmp game_start

load_saved_game:
	jsr j_primm_cout ;b'\x84BLOAD PRTY,A$0\n\x00'
	.byte $84,"BLOAD PRTY,A$0", $8d
	.byte 0
	lda party_size
	bne load_saved_map
	jsr j_primm  ;b'\nNO ACTIVE GAME!\n\x00'
	.byte $8d
	.byte "NO ACTIVE GAME!", $8d
	.byte 0
halt:
	jmp halt

load_saved_map:
	jsr j_primm_cout ;b'\x84BLOAD LIST,A$EE00\n\x84BLOAD ROST,A$EC00\n\x00'
	.byte $84,"BLOAD LIST,A$EE00", $8d
	.byte $84,"BLOAD ROST,A$EC00", $8d
	.byte 0
game_start:
	lda #$00
	sta balloon_flying
	sta movement_mode
	sta current_location
	sta horse_mode
	lda #mode_world
	sta game_mode
	sta direction
	jsr j_update_status
	jsr j_player_teleport
	lda #$ff
	sta music_volume
	lda #music_Overworld
	jsr music_ctl
next_turn:
	jsr j_update_view
	jsr tile_effect
	jsr anyone_awake
	bpl @prompt
	jmp cmd_timeout

@prompt:
	jsr j_primm  ;b'\n>\x00'
	.byte $8d,$1e,$00
	jsr j_waitkey
	cmp #char_none
	bne :+
	jmp done_pass

:	cmp #char_space
	bne :+
	jmp done_pass

:	cmp #char_enter
	bne :+
	jmp cmd_direction_up

:	cmp #char_up_arrow
	bne :+
	jmp cmd_direction_up

:	cmp #char_down_arrow
	bne :+
	jmp cmd_direction_down

:	cmp #char_slash
	bne :+
	jmp cmd_direction_down

:	cmp #char_left_arrow
	bne :+
	jmp cmd_direction_left

:	cmp #char_right_arrow
	bne :+
	jmp cmd_direction_right

:	cmp #char_ctrl_S
	bne check_cmd_alpha

; debug print virtue levels
	jsr print_newline
	lda #$00
	sta zpea
@next:
	ldx zpea
	lda party_stats,x
	jsr j_printbcd
	inc zpea
	lda zpea
	cmp #virtue_last
	bcc @next
	jsr print_newline
	jmp next_turn

check_cmd_alpha:
	cmp #char_alpha_first
	bcc done_what
	cmp #char_alpha_last
	bcs done_what
	sec
	sbc #char_alpha_first
	asl
	tay
	lda cmd_table,y
	sta ptr1
	lda cmd_table + 1,y
	sta ptr1 + 1
	jmp (ptr1)

cmd_timeout:
	jsr j_primm  ;b'\n>Zzzzz\n\x00'
	.byte $8d,$1e,"Zzzzz", $8d
	.byte 0
	jmp cmd_done

done_pass:
	jsr j_primm  ;b'Pass\n\x00'
	.byte "Pass", $8d
	.byte 0
	jmp cmd_done

done_what:
	jsr j_primm  ;b'WHAT?\n\x00'
	.byte "WHAT?", $8d
	.byte 0
done_sound_deny:
	lda #sound_what
	jsr j_playsfx
	jmp cmd_done

done_not_a_player:
	jsr j_primm  ;b'NOT A PLAYER!\n\x00'
	.byte "NOT A PLAYER!", $8d
	.byte 0
	jmp cmd_done

done_only_on_foot:
	jsr j_primm  ;b'ONLY ON FOOT!\n\x00'
	.byte "ONLY ON FOOT!", $8d
	.byte 0
	jmp done_sound_deny

done_slow_progress:
	jsr j_primm  ;b'SLOW PROGRESS!\n\x00'
	.byte "SLOW PROGRESS!", $8d
	.byte 0
	rts

done_not_here:
	jsr j_primm  ;b'NOT HERE!\n\x00'
	.byte "NOT HERE!", $8d
	.byte 0
	jmp cmd_done

done_cant:
	jsr j_primm  ;b"CAN'T!\n\x00"
	.byte "CAN'T!", $8d
	.byte 0
	jmp cmd_done

done_aborted:
	jsr j_primm  ;b'ABORTED!\n\x00'
	.byte "ABORTED!", $8d
	.byte 0
	jmp cmd_done

done_done:
	jsr j_update_status
	jsr j_primm  ;b'DONE.\n\x00'
	.byte "DONE.", $8d
	.byte 0
	jmp cmd_done

done_have_none:
	jsr j_primm  ;b'YOU HAVE NONE!\n\x00'
	.byte "YOU HAVE NONE!", $8d
	.byte 0
	jmp cmd_done

done_disabled:
	jsr j_primm  ;b'DISABLED!\n\x00'
	.byte "DISABLED!", $8d
	.byte 0
	jmp cmd_done

done_blocked:
	jsr j_primm  ;b'BLOCKED!\n\x00'
	.byte "BLOCKED!", $8d
	.byte 0
	lda #sound_blocked
	jsr j_playsfx
	lda #$00
	sta key_buf_len
	jmp cmd_done

done_drift_only:
	jsr j_primm  ;b'DRIFT ONLY!\n\x00'
	.byte "DRIFT ONLY!", $8d
	.byte 0
	jmp cmd_done

cmd_table:
	.word cmd_attack
	.word cmd_board
	.word cmd_cast
	.word cmd_descend
	.word cmd_enter
	.word cmd_fire
	.word cmd_get_chest
	.word cmd_hole_up
	.word cmd_ignite
	.word cmd_jimmy_lock
	.word cmd_klimb
	.word cmd_locate
	.word cmd_mix_reagents
	.word cmd_new_order
	.word cmd_open_door
	.word cmd_peer_gem
	.word cmd_quit
	.word cmd_ready_weapon
	.word cmd_search
	.word cmd_talk
	.word cmd_use_item
	.word cmd_volume
	.word cmd_wear_armour
	.word cmd_x_it
	.word cmd_yell_horse
	.word cmd_ztats

cmd_direction_up:
	lda game_mode
	cmp #mode_dungeon
	bne @check_transport
	jmp @dng_try_advance

@check_transport:
	lda player_transport
	cmp #tile_balloon
	bne :+
	jmp done_drift_only

:	cmp #tile_ship_north
	bne :+
	jmp @move_ship

:	cmp #tile_ship_west
	beq @set_ship_facing
	cmp #tile_ship_east
	beq @set_ship_facing
	cmp #tile_ship_south
	beq @set_ship_facing
@move_on_land:
	lda #sound_footstep
	jsr j_playsfx
	jsr print_north
	lda horse_mode
	beq :+
	jsr @try_move
	jsr j_update_view
:	jsr @try_move
	jmp cmd_done

@set_ship_facing:
	lda #tile_ship_north
	sta player_transport
	jsr print_turn
	jsr print_north
	jmp cmd_done

@move_ship:
	jsr print_sail
	jsr print_north
	lda tile_north
	jsr can_ship_move_here
	bpl :+
	jmp done_blocked

:	lda #wind_dir_north
	jsr is_wind_favorable
	beq :+
	jsr done_slow_progress
	jmp cmd_done

:	jsr j_move_north
	jmp cmd_done

@try_move:
	lda tile_under_player
	cmp #tile_castle_center
	beq @denied
	lda tile_north
	cmp #tile_castle_center
	beq @allowed
	jsr j_blocked_tile
	bpl @allowed
@denied:
	pla
	pla
	jmp done_blocked

@allowed:
	lda tile_north
	jsr check_slow_terrain
	beq :+
	jsr done_slow_progress
	jmp @done

:	lda #sound_footstep
	jsr j_playsfx
	lda game_mode
	cmp #mode_world
	bne @towne
	jsr j_move_north
	lda tile_north
	jmp check_enter_moongate

@towne:
	dec player_ypos
	lda player_ypos
	bpl @done
	pla
	pla
	jmp leave_to_world

@done:
	rts

@dng_try_advance:
	jsr j_primm  ;b'Advance\n\x00'
	.byte "Advance", $8d
	.byte 0
	lda tile_north
	jsr dng_can_advance
	bpl :+
	jmp done_blocked

:	ldx dng_direction
dng_move:
	clc
	lda player_xpos
	adc dng_dir_delta_x,x
	and #$07     ;modulo
	sta player_xpos
	clc
	lda player_ypos
	adc dng_dir_delta_y,x
	and #$07     ;modulo
	sta player_ypos
	jmp cmd_done

dng_dir_delta_x:
	.byte $00,$01,$00,$ff
dng_dir_delta_y:
	.byte $ff,$00,$01,$00

cmd_direction_down:
	lda game_mode
	cmp #mode_dungeon
	bne @check_transport
	jsr j_primm  ;b'Retreat\n\x00'
	.byte "Retreat", $8d
	.byte 0
	lda tile_west
	jsr dng_can_retreat
	bpl :+
	jmp done_blocked

:	lda dng_direction
	eor #$02
	tax
	jmp dng_move

@check_transport:
	lda player_transport
	cmp #tile_balloon
	bne :+
	jmp done_drift_only

:	cmp #tile_ship_south
	bne :+
	jmp @move_ship

:	cmp #tile_ship_east
	beq @set_ship_facing
	cmp #tile_ship_west
	beq @set_ship_facing
	cmp #tile_ship_north
	beq @set_ship_facing
@move_on_land:
	lda #sound_footstep
	jsr j_playsfx
	jsr print_south
	lda horse_mode
	beq :+
	jsr @try_move
	jsr j_update_view
:	jsr @try_move
@check_shrine_humility:
	lda player_xpos
	cmp #$e5
	bcc @cmd_done
	cmp #$ea
	bcs @cmd_done
	lda player_ypos
	cmp #$d4
	bcc @cmd_done
	cmp #$d9
	bcs @cmd_done
	jmp spawn_daemon_guard

@cmd_done:
	jmp cmd_done

@set_ship_facing:
	lda #tile_ship_south
	sta player_transport
	jsr print_turn
	jsr print_south
	jmp cmd_done

@move_ship:
	jsr print_sail
	jsr print_south
	lda tile_south
	jsr can_ship_move_here
	bpl :+
	jmp done_blocked

:	lda #wind_dir_south
	jsr is_wind_favorable
	beq :+
	jsr done_slow_progress
	jmp cmd_done

:	jsr j_move_south
	jmp cmd_done

@try_move:
	lda tile_south
	jsr j_blocked_tile
	bpl :+
	pla
	pla
	jmp done_blocked

:	lda tile_south
	jsr check_slow_terrain
	beq :+
	jsr done_slow_progress
	jmp @done

:	lda #sound_footstep
	jsr j_playsfx
	lda game_mode
	cmp #mode_world
	bne @towne
	jsr j_move_south
	lda tile_south
	jmp check_enter_moongate

@towne:
	inc player_ypos
	lda player_ypos
	cmp #xy_last_towne
	bcc @done
	pla
	pla
	jmp leave_to_world

@done:
	rts

cmd_direction_left:
	lda game_mode
	cmp #mode_dungeon
	bne @check_transport
	jsr print_turn
	jsr j_primm  ;b'left\n\x00'
	.byte "left", $8d
	.byte 0
	sec
	lda dng_direction
	sbc #$01
	and #$03
	sta dng_direction
	jsr j_dng_check_update
	jsr j_print_direction
	jmp next_turn

@check_transport:
	lda player_transport
	cmp #tile_balloon
	bne :+
	jmp done_drift_only

:	cmp #tile_ship_west
	bne :+
	jmp @move_ship

:	cmp #tile_ship_north
	beq @set_ship_facing
	cmp #tile_ship_south
	beq @set_ship_facing
	cmp #tile_ship_east
	beq @set_ship_facing
	cmp #tile_horse_east
	bne @move_on_land
	lda #tile_horse_west
	sta player_transport
@move_on_land:
	lda #sound_footstep
	jsr j_playsfx
	jsr print_west
	lda horse_mode
	beq :+
	jsr @try_move
	jsr j_update_view
:	jsr @try_move
	jmp cmd_done

@set_ship_facing:
	lda #tile_ship_west
	sta player_transport
	jsr print_turn
	jsr print_west
	jmp cmd_done

@move_ship:
	jsr print_sail
	jsr print_west
	lda tile_west
	jsr can_ship_move_here
	bpl :+
	jmp done_blocked

:	lda #wind_dir_west
	jsr is_wind_favorable
	beq :+
	jsr done_slow_progress
	jmp cmd_done

:	jsr j_move_west
	jmp cmd_done

@try_move:
	lda tile_west
	jsr j_blocked_tile
	bpl :+
	pla
	pla
	jmp done_blocked

:	lda tile_west
	jsr check_slow_terrain
	beq :+
	jsr done_slow_progress
	jmp @done

:	lda #sound_footstep
	jsr j_playsfx
	lda game_mode
	cmp #mode_world
	bne @towne
	jsr j_move_west
	lda tile_west
	jmp check_enter_moongate

@towne:
	dec player_xpos
	lda player_xpos
	bpl @done
	pla
	pla
	jmp leave_to_world

@done:
	rts

cmd_direction_right:
	lda game_mode
	cmp #mode_dungeon
	bne @check_transport
	jsr print_turn
	jsr j_primm  ;b'right\n\x00'
	.byte "right", $8d
	.byte 0
	clc
	lda dng_direction
	adc #$01
	and #$03
	sta dng_direction
	jsr j_dng_check_update
	jsr j_print_direction
	jmp next_turn

@check_transport:
	lda player_transport
	cmp #tile_balloon
	bne :+
	jmp done_drift_only

:	cmp #tile_ship_east
	bne :+
	jmp @move_ship

:	cmp #tile_ship_north
	beq @set_ship_facing
	cmp #tile_ship_south
	beq @set_ship_facing
	cmp #tile_ship_west
	beq @set_ship_facing
	cmp #tile_horse_west
	bne @move_on_land
	lda #tile_horse_east
	sta player_transport
@move_on_land:
	lda #sound_footstep
	jsr j_playsfx
	jsr print_east
	lda horse_mode
	beq :+
	jsr @try_move
	jsr j_update_view
:	jsr @try_move
	jmp cmd_done

@set_ship_facing:
	jsr print_turn
	jsr print_east
	lda #tile_ship_east
	sta player_transport
	jmp cmd_done

@move_ship:
	jsr print_sail
	jsr print_east
	lda tile_east
	jsr can_ship_move_here
	bpl :+
	jmp done_blocked

:	lda #wind_dir_east
	jsr is_wind_favorable
	beq :+
	jsr done_slow_progress
	jmp cmd_done

:	jsr j_move_east
@check_abyss_cove:
	lda player_xpos
	cmp #$dd
	bne @cmd_done
	lda player_ypos
	cmp #$e0
	bne @cmd_done
	jmp spawn_pirate_fleet

@cmd_done:
	jmp cmd_done

@try_move:
	lda tile_east
	jsr j_blocked_tile
	bpl :+
	pla
	pla
	jmp done_blocked

:	lda tile_east
	jsr check_slow_terrain
	beq :+
	jsr done_slow_progress
	jmp @done

:	lda #sound_footstep
	jsr j_playsfx
	lda game_mode
	cmp #mode_world
	bne @towne
	jsr j_move_east
	lda tile_east
	jmp check_enter_moongate

@towne:
	inc player_xpos
	lda player_xpos
	cmp #xy_last_towne
	bcc @done
	pla
	pla
	jmp leave_to_world

@done:
	rts

print_turn:
	jsr j_primm  ;b'Turn \x00'
	.byte "Turn ", 0
	rts

print_sail:
	jsr j_primm  ;b'Sail \x00'
	.byte "Sail ", 0
	rts

spawn_pirate_fleet:
	ldy #$07
@next:
	lda pirate_fleet_x,y
	sta object_xpos,y
	lda pirate_fleet_y,y
	sta object_ypos,y
	lda #tile_pirate
	sta object_tile_type,y
	lda pirate_fleet_sprite,y
	sta object_tile_sprite,y
	dey
	bpl @next
	jmp cmd_done

pirate_fleet_x:
	.byte $e0,$e0,$e2,$e3,$e4,$e5,$e5,$e4
pirate_fleet_y:
	.byte $dc,$e4,$dc,$e4,$e3,$e1,$df,$de
pirate_fleet_sprite:
	.byte $82,$82,$82,$82,$83,$83,$81,$81

spawn_daemon_guard:
	lda magic_aura
	cmp #aura_horn
	beq @done
	ldy #$07
@next:
	lda #tile_daemon
	sta object_tile_type,y
	sta object_tile_sprite,y
	lda #$e7
	sta object_xpos,y
	lda player_ypos
	clc
	adc #$01
	sta object_ypos,y
	dey
	bpl @next
@done:
	jmp cmd_done

leave_to_world:
	lda #music_off
	jsr music_ctl
	jsr j_primm  ;b'LEAVING...\n\x00'
	.byte "LEAVING...", $8d
	.byte 0
	bit hw_strobe
	lda #mode_loading
	sta game_mode
	lda #disk_britannia
	jsr j_request_disk
	jsr j_primm_cout ;b'\x84BLOAD TLST\n\x00'
	.byte $84,"BLOAD TLST", $8d
	.byte 0
	lda britannia_x
	sta player_xpos
	lda britannia_y
	sta player_ypos
	jsr j_player_teleport
	lda #mode_world
	sta game_mode
	lda #loc_world
	sta current_location
@check_exit_hythloth:
	lda player_xpos
	cmp #$ef
	bne @done
	lda player_ypos
	cmp #$f0
	bne @done
@spawn_balloon:
	lda #tile_balloon
	sta object_tile_type + object_max
	sta object_tile_sprite + object_max
	lda #$e9
	sta object_xpos + object_max
	lda #$f2
	sta object_ypos + object_max
@done:
	jsr j_update_britannia
	lda #music_Overworld
	jsr music_ctl
	lda #$00
	sta key_buf_len
	jmp cmd_done

check_slow_terrain:
	cmp #tile_swamp
	beq @chance_4
	cmp #tile_bushes
	beq @chance_8
	cmp #tile_forest
	beq @chance_4
	cmp #tile_hills
	beq @chance_2
	cmp #tile_field_fire
	beq @chance_2
@allowed:
	lda #$00
	rts

@slowed:
	lda #$ff
	rts

@chance_8:
	jsr j_rand
	and #$07
	beq @slowed
	bne @allowed
@chance_4:
	jsr j_rand
	and #$03
	beq @slowed
	bne @allowed
@chance_2:
	jsr j_rand
	and #$01
	beq @allowed
	bne @slowed
can_ship_move_here:
	cmp #tile_water_shallow
	bcc @yes
	cmp #tile_whirlpool
	bcc @no
	cmp #tile_monster
	bcs @no
@yes:
	lda #$00
	rts

@no:
	lda #$ff
	rts

cmd_attack:
	jsr j_primm  ;b'Attack-\x00'
	.byte "Attack-", 0
	lda game_mode
	cmp #mode_dungeon
	bne :+
	jmp done_what

:	jsr input_direction
	bne :+
	jmp done_pass

:	jsr get_mob_at_temp_xy
	bpl :+
@nothing_there:
	jmp done_what

:	stx zp_index
	lda object_tile_type,x
	cmp #tile_whirlpool
	beq @nothing_there
	cmp #tile_twister
	beq @nothing_there
	lda game_mode
	cmp #mode_towne
	bne @check_virtue
	ldx #object_max
@next:
	lda object_tile_type,x
	cmp #tile_guard
	beq @hostile
	cmp #tile_lord_british
	bne @skip
@hostile:
	lda #$ff
	sta object_dng_level,x
	lda #$00
	sta npc_dialogue,x
@skip:
	dex
	bpl @next
@check_virtue:
	lda game_mode
	cmp #mode_towne
	beq @penalty
	ldx zp_index
	lda object_tile_type,x
	jsr is_evil
	bmi do_attack
@penalty:
	ldy #virtue_compassion
	lda #$05
	jsr dec_virtue
	ldy #virtue_justice
	lda #$03
	jsr dec_virtue
	ldy #virtue_honor
	lda #$03
	jsr dec_virtue
do_attack:
	ldx zp_index
	lda object_tile_type,x
	sta foe_type_encountered
	lda object_xpos,x
	sta pre_combat_x
	sta temp_x
	lda object_ypos,x
	sta pre_combat_y
	sta temp_y
	lda game_mode
	cmp #mode_world
	bne @mini_map
	jsr j_gettile_bounds
	sta pre_combat_tile
	jmp @init_foe

@mini_map:
	jsr j_gettile_towne
	sta pre_combat_tile
@init_foe:
	lda #$00
	ldx zp_index
	sta object_tile_type,x
	sta object_tile_sprite,x
	sta object_dng_level,x
	jmp init_combat

cmd_board:
	lda player_transport
	cmp #tile_walk
	beq @on_foot
	jsr j_primm  ;b'Board <-\x00'
	.byte "Board <-", 0
	jmp done_cant

@on_foot:
	lda tile_under_player
	cmp #tile_horse_west
	beq board_horse
	cmp #tile_horse_east
	beq board_horse
	jsr j_primm  ;b'Board \x00'
	.byte "Board ", 0
	lda tile_under_player
	cmp #tile_ship_west
	beq @board_ship
	cmp #tile_ship_north
	beq @board_ship
	cmp #tile_ship_east
	beq @board_ship
	cmp #tile_ship_south
	beq @board_ship
	cmp #tile_balloon
	bne @nothing_boardable
	jmp board_balloon

@nothing_boardable:
	jmp done_what

@board_ship:
	lda #tile_ship_first
	jsr do_board
	jsr j_primm  ;b'frigate!\n\x00'
	.byte "frigate!", $8d
	.byte 0
	lda player_xpos
	cmp last_ship_x
	bne @new_ship
	lda player_ypos
	cmp last_ship_y
	bne @new_ship
	jmp cmd_done

@new_ship:
	lda #$50
	sta ship_hull
	jmp cmd_done

last_ship_x:
	.byte 0
last_ship_y:
	.byte 0
board_horse:
	lda #tile_horse_west
	jsr do_board
	jsr j_primm  ;b'Mount horse!\n\x00'
	.byte "Mount horse!", $8d
	.byte 0
	jmp cmd_done

board_balloon:
	lda #tile_balloon
	jsr do_board
	jsr j_primm  ;b'balloon\n\x00'
	.byte "balloon", $8d
	.byte 0
	lda #balloon_landed
	sta movement_mode
	jmp cmd_done

do_board:
	sta zp_transport
	ldx #object_max
@next:
	lda object_tile_type,x
	and #animation_mask
	cmp zp_transport
	bne @skip
	lda object_xpos,x
	cmp player_xpos
	bne @skip
	lda object_ypos,x
	cmp player_ypos
	beq @remove_from_map
@skip:
	dex
	cpx #object_inanimate_first
	bcs @next
	bcc @done
@remove_from_map:
	lda #$00
	sta object_tile_type,x
	sta object_tile_sprite,x
@done:
	lda tile_under_player
	sta player_transport
	rts

cmd_cast:
	jsr j_primm  ;b'Cast spell:\nplayer-\x00'
	.byte "Cast spell:", $8d
	.byte "player-", 0
	jsr j_getplayernum
	bne :+
@not_a_player:
	jmp done_not_a_player

:	cmp party_size
	beq :+
	bcs @not_a_player
:	sta curr_player
	jsr is_awake
	bpl choose_spell
	jmp done_disabled

choose_spell:
	jsr display_spells
	jsr j_primm  ;b'SPELL-\x00'
	.byte "SPELL-", 0
	jsr input_char
	pha
	jsr j_clearstatwindow
	jsr j_update_status
	lda game_mode
	bpl @not_combat
	jsr invert_player_name
@not_combat:
	pla
	sec
	sbc #char_alpha_first
	cmp #$1a     ;26, A-Z spells
	bcc :+
	jmp done_what

:	sta current_spell
	clc
	adc #string_spells
	jsr j_printstring
	jsr j_primm  ;b'!\n\x00'
	.byte "!", $8d
	.byte 0
	ldy current_spell
	lda mixtures,y
	bne :+
	jmp done_have_none

:	sed
	sec
	sbc #$01
	sta mixtures,y
	cld
	jsr j_get_stats_ptr
	ldy #player_magic_points
	lda (ptr1),y
	ldx current_spell
	sed
	sec
	sbc spell_mp_cost,x
	cld
	bcs @deduct_mp
	jsr j_primm  ;b'M.P. TOO LOW!\n\x00'
	.byte "M.P. TOO LOW!", $8d
	.byte 0
	jmp failed

@deduct_mp:
	sta (ptr1),y
	lda current_spell
	asl
	tay
	lda spell_jump_table,y
	sta ptr1
	lda spell_jump_table+1,y
	sta ptr1 + 1
	jmp (ptr1)

current_spell:
	.byte 0
spell_jump_table:
	.word spell_awake
	.word spell_blink
	.word spell_cure
	.word spell_dispel_field
	.word spell_energy_field
	.word spell_fireball
	.word spell_gate
	.word spell_heal
	.word spell_iceball
	.word spell_jinx
	.word spell_kill
	.word spell_light
	.word spell_missile
	.word spell_negate
	.word spell_open_chest
	.word spell_protect
	.word spell_quickness
	.word spell_resurrect
	.word spell_sleep
	.word spell_tremor
	.word spell_undead
	.word spell_view
	.word spell_wind
	.word spell_x_it
	.word spell_y_up
	.word spell_z_down
spell_mp_cost:
	.byte $05  ; awake
	.byte $15  ; blink
	.byte $05  ; cure
	.byte $20  ; dispel_field
	.byte $10  ; energy_field
	.byte $15  ; fireball
	.byte $40  ; gate
	.byte $10  ; heal
	.byte $20  ; iceball
	.byte $30  ; jinx
	.byte $25  ; kill
	.byte $05  ; light
	.byte $05  ; missile
	.byte $20  ; negate
	.byte $05  ; open_chest
	.byte $15  ; protect
	.byte $20  ; quickness
	.byte $45  ; resurrect
	.byte $15  ; sleep
	.byte $30  ; tremor
	.byte $15  ; undead
	.byte $15  ; view
	.byte $10  ; wind
	.byte $15  ; x_it
	.byte $10  ; y_up
	.byte $05  ; z_down

spell_awake:
	jsr j_primm  ;b'WHO-\x00'
	.byte "WHO-", 0
	jsr j_getplayernum
	bne :+
@fail:
	jmp failed

:	jsr spell_effect
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Sleep
	bne @fail
	lda #status_Good
	sta (ptr1),y
	lda game_mode
	bpl @not_in_combat
	jsr get_player_sprite
	ldx curr_player
	sta combat_player_tile-1,x
@not_in_combat:
	jmp done_done

spell_blink:
	lda player_transport
	cmp #tile_ship_last
	bcs @not_in_ship
@fail:
	jmp failed

@not_in_ship:
	jsr outdoors_only
	jsr prompt_direction
	jsr input_direction
	jsr spell_effect
	lda player_xpos
	and player_ypos
	cmp #$c0     ;no blink near abyss isle
	bcc @find_patch_edge
	jmp failed

@find_patch_edge:
	jsr add_delta
	cmp #$ff
	bne @find_patch_edge
@find_farthest_legal:
	jsr sub_delta
	cmp #$ff
	beq @fail
	jsr j_blocked_tile
	bmi @find_farthest_legal
	lda temp_x
	sta player_xpos
	lda temp_y
	sta player_ypos
	jsr spin_drive_motor
	jsr j_player_teleport
	jmp done_done

add_delta:
	clc
	lda temp_x
	adc delta_x
	sta temp_x
	clc
	lda temp_y
	adc delta_y
	sta temp_y
	jsr j_gettile_bounds
	rts

sub_delta:
	sec
	lda temp_x
	sbc delta_x
	sta temp_x
	sec
	lda temp_y
	sbc delta_y
	sta temp_y
	jsr j_gettile_bounds
	rts

spell_cure:
	jsr j_primm  ;b'WH0-\x00'
	.byte "WH0-", 0
	jsr j_getplayernum
	bne :+
@fail:
	jmp failed

:	jsr spell_effect
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Poison
	bne @fail
	lda #status_Good
	sta (ptr1),y
	jmp done_done

spell_dispel_field:
	lda game_mode
	cmp #mode_dungeon
	beq @dungeon
	jsr prompt_direction
	lda game_mode
	bmi @combat
	cmp #mode_world
	bne @towne
	beq @world
@fail:
	jmp failed

@world:
	jsr input_direction
	beq @fail
	jsr spell_effect
	jsr j_gettile_bounds
@try_dispel:
	cmp #tile_field_first
	bcc @fail
	cmp #tile_field_last
	bcs @fail
	lda tile_under_player
	sta (ptr2),y
	jmp done_done

@towne:
	jsr input_direction
	beq @fail
	jsr spell_effect
	jsr j_gettile_towne
	jmp @try_dispel

@combat:
	jsr input_target_xy
	beq @fail
	jsr spell_effect
	jsr j_gettile_tempmap
	sta tile_under_player
	clc
	lda dest_x
	adc delta_x
	sta dest_x
	clc
	lda dest_y
	adc delta_y
	sta dest_y
	jsr j_gettile_tempmap
	cmp #tile_field_first
	bcc @fail
	cmp #tile_field_last
	bcs @fail
	lda tile_under_player
	sta tempmap,y
	jmp done_done

@dungeon:
	jsr spell_effect
	clc
	ldx dng_direction
	lda player_xpos
	adc dng_dir_delta_x,x
	sta dest_x
	clc
	lda player_ypos
	adc dng_dir_delta_y,x
	sta dest_y
	jsr j_gettile_dungeon
	and #dng_tile_type_mask
	cmp #dng_tile_field
	bne @fail
	lda #$00
	sta (ptr1),y
	jmp done_done

spell_energy_field:
	jsr j_primm  ;b'TYPE-\x00'
	.byte "TYPE-", 0
	jsr input_char
	ldx #tile_field_first
	cmp #char_P
	beq @allowed
	inx
	cmp #char_L
	beq @allowed
	inx
	cmp #char_F
	beq @allowed
	inx
	cmp #char_S
	beq @allowed
@fail:
	jmp failed

@allowed:
	stx zp_field_type
	lda game_mode
	bmi @combat
	cmp #mode_dungeon
	bne @fail
@dungeon:
	jsr spell_effect
	ldx dng_direction
	clc
	lda player_xpos
	adc dng_dir_delta_x,x
	sta dest_x
	clc
	lda player_ypos
	adc dng_dir_delta_y,x
	sta dest_y
	jsr j_gettile_dungeon
	bne @fail
	lda zp_field_type
	and #$03
	ora #dng_tile_field
	sta (ptr1),y
	jmp done_done

@combat:
	jsr prompt_direction
	jsr input_target_xy
	beq @fail
	clc
	lda dest_x
	adc delta_x
	sta dest_x
	cmp #xy_last_screen
	bcs @fail
	clc
	lda dest_y
	adc delta_y
	sta dest_y
	cmp #xy_last_screen
	bcs @fail
	jsr spell_effect
	jsr j_gettile_tempmap
	jsr j_blocked_tile
	bmi @fail
	lda zp_field_type
	sta tempmap,y
	jmp done_done

spell_fireball:
	jsr combat_only
	jsr prompt_direction
	jsr input_target_xy
	bne do_fireball
spell_attack_failed:
	lda #$00
	sta attack_sprite
	jmp failed

do_fireball:
	jsr spell_effect
	lda #tile_attack_red
	sta attack_sprite
launch_attack_spell:
	lda dest_x
	sta target_x
	lda dest_y
	sta target_y
@travel:
	jsr next_arena_tile
	bmi spell_attack_failed
	jsr j_update_view_combat
	jsr check_hit_foe
	bmi @travel
	lda #sound_damage
	jsr j_playsfx
	lda attack_sprite
	cmp #tile_attack_small
	beq @damage_low
	cmp #tile_attack_blue
	beq @damage_high
	cmp #tile_attack_red
	beq @damage_medium
	lda #$e8     ;232 fixed damage for Kill
	jmp @clear_sprite

@damage_medium:
	lda #$80
	jsr rand_modulo
	ora #$18     ;24-31,56-63,88-95,120-127
	jmp @clear_sprite

@damage_high:
	lda #$e0
	jsr rand_modulo
	ora #$20     ;32-63,96-127,160-191,224-255
	jmp @clear_sprite

@damage_low:
	lda #$40
	jsr rand_modulo
	ora #$10     ;16-31,48-63
@clear_sprite:
	ldx #$00
	stx attack_sprite
	sta damage
	jsr inflict_damage
	jmp done_done

spell_gate:
	lda player_transport
	cmp #tile_ship_last
	bcc @fail
	lda game_mode
	cmp #mode_world
	beq :+
	jmp outdoors_only

:	jsr j_primm  ;b'TO PHASE-\x00'
	.byte "TO PHASE-", 0
	jsr input_char
	sec
	sbc #char_1
	cmp #$08
	bcc :+
@fail:
	jmp failed

:	sta zpea
	jsr spell_effect
	ldx zpea
	lda moongate_x,x
	sta player_xpos
	lda moongate_y,x
	sta player_ypos
	jsr spin_drive_motor
	jsr j_player_teleport
	jmp done_done

moongate_x:
	.byte $e0,$60,$26,$32,$a6,$68,$17,$bb
moongate_y:
	.byte $85,$66,$e0,$25,$13,$c2,$7e,$a7

spell_heal:
	jsr j_primm  ;b'WHO-\x00'
	.byte "WHO-", 0
	jsr j_getplayernum
	bne :+
@fail:
	jmp failed

:	jsr spell_effect
	jsr is_alive
	bmi @fail
	lda #$19
	jsr rand_modulo
	clc
	adc #$4b     ;75 - 99 pts
	jsr encode_bcd_value
	jsr inc_player_hp
	jmp done_done

spell_iceball:
	jsr combat_only
	jsr prompt_direction
	jsr input_target_xy
	bne :+
	jmp failed

:	jsr spell_effect
	lda #tile_attack_blue
	sta attack_sprite
	jmp launch_attack_spell

spell_jinx:
	jsr spell_effect
	lda #aura_jinx
set_spell_aura:
	sta magic_aura
	lda #$0a
	sta aura_duration
	jmp done_done

spell_kill:
	jsr combat_only
	jsr prompt_direction
	jsr input_target_xy
	bne :+
	jmp failed

:	jsr spell_effect
	lda #tile_whirlpool
	sta attack_sprite
	jmp launch_attack_spell

spell_light:
	jsr spell_effect
	lda #$64
	sta light_duration
	lda game_mode
	cmp #mode_dungeon
	bne :+
	jsr j_dng_neighbor_tiles
:	jmp done_done

spell_missile:
	jsr combat_only
	jsr prompt_direction
	jsr input_target_xy
	bne :+
	jmp failed

:	jsr spell_effect
	lda #tile_attack_small
	sta attack_sprite
	jmp launch_attack_spell

spell_negate:
	jsr spell_effect
	lda #aura_negate
	jmp set_spell_aura

spell_open_chest:
	jsr spell_effect
	lda game_mode
	bmi :+
	lda #$00
	sta curr_player
	jmp try_get_chest

:	jmp try_get_chest_combat

spell_protect:
	jsr spell_effect
	lda #aura_protect
	jmp set_spell_aura

spell_quickness:
	jsr spell_effect
	lda #aura_quickness
	jmp set_spell_aura

spell_resurrect:
	lda game_mode
	bpl try_resurrect ;not allowed in combat!
res_view_fail:
	jmp failed

try_resurrect:
	jsr j_primm  ;b'WHO-\x00'
	.byte "WHO-", 0
	jsr j_getplayernum
	bne :+
	jmp failed

:	jsr spell_effect
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Dead
	beq :+
	jmp failed

:	lda #status_Good
	sta (ptr1),y
	jmp done_done

spell_sleep:
	jsr combat_only
	jsr spell_effect
	ldx #foes_max
@next:
	lda combat_foe_tile,x
	beq @skip
	jsr is_undead
	beq @skip
	cmp #tile_balron
	beq @skip
	jsr j_rand
	cmp combat_foe_hp,x
	bcc @skip
	lda #$01
	sta combat_foe_slept,x
@skip:
	dex
	bpl @next
	jmp done_done

spell_tremor:
	jsr combat_only
	jsr spell_effect
	jsr shake_screen
	ldx #foes_max
@next:
	lda combat_foe_tile,x
	beq @skip
	cmp #tile_lord_british
	beq @skip
	lda combat_foe_hp,x
	cmp #$c0     ;192+ hp == immune!
	bcs @skip
	jsr j_rand
	bmi @hit     ;2/4 chance
	and #$01     ;1/4 chance
	bne @skip
	lda #hp_fleeing
	sta combat_foe_hp,x
	jmp @skip

@hit:
	stx zpea
	lda combat_foe_cur_x,x
	sta target_x
	lda combat_foe_cur_y,x
	sta target_y
	lda #tile_attack_red
	sta attack_sprite
	jsr j_update_view_combat
	lda #sound_damage
	jsr j_playsfx
	lda #$00
	sta attack_sprite
	lda #$ff
	sta damage
	jsr inflict_damage
	ldx zpea
@skip:
	dex
	bpl @next
	jmp done_done

spell_undead:
	jsr combat_only
	jsr spell_effect
	ldx #foes_max
@next:
	lda combat_foe_tile,x
	jsr is_undead
	bne @skip
	jsr j_rand
	bmi @skip    ;1/2 chance
	lda #hp_fleeing
	sta combat_foe_hp,x
@skip:
	dex
	bpl @next
	jmp done_done

spell_view:
	lda game_mode
	bpl :+
	jmp res_view_fail

:	jsr spell_effect
	jsr do_view
	jmp done_done

spell_wind:
	jsr outdoors_only
	jsr prompt_direction
	jsr input_direction
	bne :+
	jmp failed

:	jsr spell_effect
	lda delta_x
	bne @east_west
	lda delta_y
	bpl @south
	lda #wind_dir_north
	jmp @done

@south:
	lda #wind_dir_south
	jmp @done

@east_west:
	bpl @east
	lda #wind_dir_west
	jmp @done

@east:
	lda #wind_dir_east
@done:
	sta direction
	jmp done_done

spell_x_it:
	jsr dungeon_only
	jsr spell_effect
	jmp leave_to_world

spell_y_up:
	jsr dungeon_only
	jsr spell_effect
	jsr not_abyss
	dec dungeon_level
	bpl :+
	jmp leave_to_world

:	lda #$20     ;32 attempts
	sta zp_attempts
@try_random:
	jsr j_rand
	and #$07
	sta dest_x
	jsr j_rand
	and #$07
	sta dest_y
	jsr j_gettile_dungeon
	beq @ok
	dec zp_attempts
	bne @try_random
	inc dungeon_level
	jmp failed

@ok:
	lda dest_x
	sta player_xpos
	lda dest_y
	sta player_ypos
	jmp done_done

spell_z_down:
	jsr dungeon_only
	jsr spell_effect
	jsr not_abyss
	lda dungeon_level
	cmp #$07
	bcc :+
	jsr failed   ;BUG: stack overflow
:	inc dungeon_level
	lda #$20     ;32 attempts
	sta zp_attempts
@try_random:
	jsr j_rand
	and #$07
	sta dest_x
	jsr j_rand
	and #$07
	sta dest_y
	jsr j_gettile_dungeon
	beq @ok
	dec zp_attempts
	bne @try_random
	dec dungeon_level
	jmp failed

@ok:
	lda dest_x
	sta player_xpos
	lda dest_y
	sta player_ypos
	jmp done_done

not_abyss:
	lda current_location
	cmp #loc_dng_abyss
	bne @ok
	pla
	pla
	jmp failed

@ok:
	rts

dungeon_only:
	lda game_mode
	cmp #mode_dungeon
	beq @ok
	jsr j_primm  ;b'DUNGEON ONLY!\n\x00'
	.byte "DUNGEON ONLY!", $8d
	.byte 0
	pla
	pla
	jmp failed

@ok:
	rts

combat_only:
	lda game_mode
	bmi @ok
	jsr j_primm  ;b'COMBAT ONLY!\n\x00'
	.byte "COMBAT ONLY!", $8d
	.byte 0
	pla
	pla
	jmp failed

@ok:
	rts

outdoors_only:
	lda game_mode
	cmp #mode_world
	beq @ok
	jsr j_primm  ;b'OUTDOORS ONLY!\n\x00'
	.byte "OUTDOORS ONLY!", $8d
	.byte 0
	pla
	pla
	jmp failed

@ok:
	rts

spell_effect:
	ldy current_spell
	ldx spell_mp_cost,y
	lda #sound_cast
	jsr j_playsfx
	jsr j_invertview
	lda current_spell
	clc
	adc #$60     ;base pitch
	tax
	lda #sound_spell_effect
	jsr j_playsfx
	jsr j_invertview
	lda magic_aura
	cmp #aura_negate
	bne @ok
	pla
	pla
	jmp failed

@ok:
	rts

failed:
	jsr j_primm  ;b'FAILED!\n\x00'
	.byte "FAILED!", $8d
	.byte 0
	lda #sound_alert
	jsr j_playsfx
	jmp cmd_done

is_undead:
	cmp #tile_ghost
	beq @yes
	cmp #tile_phantom
	beq @yes
	cmp #tile_skeleton
	beq @yes
	cmp #tile_liche
	beq @yes
@no:
	lda #$ff
	rts

@yes:
	lda #$00
	rts

prompt_direction:
	jsr j_primm  ;b'DIRECTION-\x00'
	.byte "DIRECTION-", 0
	rts

cmd_descend:
	lda player_transport
	cmp #tile_balloon
	beq @balloon
	jsr j_primm  ;b'Descend \x00'
	.byte "Descend ", 0
	lda current_location
	cmp #loc_castle_britannia
	beq @castle_britannia
	lda game_mode
	cmp #mode_dungeon
	beq @dungeon
	jmp done_what

@dungeon:
	lda tile_under_player
	and #dng_tile_type_mask
	cmp #dng_tile_ladder_d
	beq :+
	cmp #dng_tile_ladder_du
	beq :+
	jmp done_what

:	inc dungeon_level
	jsr j_primm  ;b'down!\nTo level \x00'
	.byte "down!", $8d
	.byte "To level ", 0
	clc
	lda dungeon_level
	adc #$01
	jsr j_printdigit
	jsr print_newline
	jmp cmd_done

@balloon:
	jsr j_primm  ;b'Land Balloon\n\x00'
	.byte "Land Balloon", $8d
	.byte 0
	lda tile_under_player
	cmp #tile_grass
	bne @not_here
	lda #balloon_landed
	sta movement_mode
	sta balloon_flying
	jmp cmd_done

@not_here:
	jmp done_not_here

@nope:
	jmp done_what

@castle_britannia:
	lda player_transport
	cmp #tile_walk
	beq :+
	jmp done_only_on_foot

:	lda tile_under_player
	cmp #tile_ladder_down
	bne @nope
	lda player_ypos
	cmp #$02
	beq @to_dungeon
	jsr j_primm  ;b'to\nfirst floor!\n\x00'
	.byte "to", $8d
	.byte "first floor!", $8d
	.byte 0
	lda #music_off
	jsr music_ctl
	lda #char_A
	jsr load_letter_location
	lda #music_explore
	jsr music_ctl
	jmp cmd_done

@to_dungeon:
	jsr j_primm  ;b'into\nthe depths!\n\x00'
	.byte "into", $8d
	.byte "the depths!", $8d
	.byte 0
	lda #$05     ;start in the middle, not usual 1,1
	sta temp_x
	sta temp_y
	lda #$ef     ;hythloth longitude
	sta britannia_x
	lda #$f0     ;hythloth latitude
	sta britannia_y
	lda #loc_dng_hythloth
	sta current_location
	jmp begin_dng_load

cmd_enter:
	jsr j_primm  ;b'Enter \x00'
	.byte "Enter ", 0
	lda current_location
	beq :+        ;only in world
	jmp done_what

:	ldx #object_last
@next:
	dex
	bpl :+
	jmp done_what

:	lda location_map_x,x
	cmp player_xpos
	bne @next
	lda location_map_y,x
	cmp player_ypos
	bne @next
	stx current_location
	inc current_location
	lda player_xpos
	sta britannia_x
	lda player_ypos
	sta britannia_y
	lda tile_under_player
	cmp #tile_dungeon_entrance
	beq enter_dungeon
	cmp #tile_towne
	bne :+
	jmp print_towne

:	cmp #tile_castle
	bne :+
	jmp print_castle

:	cmp #tile_village
	bne :+
	jmp print_village

:	cmp #tile_castle_center
	bne :+
	jmp print_castle

:	cmp #tile_ruin
	bne :+
	jmp print_ruin

:	cmp #tile_shrine
	bne :+
	jmp print_shrine

:	cmp #tile_field_fire
	beq enter_abyss
	lda #location_world
	sta current_location
	jmp done_what

enter_abyss:
	lda bell_book_candle
	cmp #$77
	beq :+
	lda #location_world
	sta current_location
	jmp done_cant

:	jsr print_location_name
	jmp check_on_foot

enter_dungeon:
	jsr j_primm  ;b'dungeon!\n\x00'
	.byte "dungeon!", $8d
	.byte 0
	jsr print_location_name
check_on_foot:
	lda player_transport
	cmp #tile_walk
	beq :+
	lda #$00
	sta current_location
	jmp done_only_on_foot

:	lda #$01     ;start at 1,1
	sta temp_x
	sta temp_y
	lda #music_off
	jsr music_ctl
	jsr file_write_temp_map
begin_dng_load:
	lda #music_off
	jsr music_ctl
	lda #disk_dungeon
	jsr j_request_disk
	jsr j_primm_cout ;b'\x84BLOAD DNGD,A$8C00\n\x00'
	.byte $84,"BLOAD DNGD,A$8C00", $8d
	.byte 0
	jsr load_map_dungeon
	lda #mode_dungeon
	sta game_mode
	lda #dng_dir_east
	sta dng_direction
	lda temp_x
	sta player_xpos
	lda temp_y
	sta player_ypos
	lda #$00
	sta dungeon_level
	lda #music_Dungeon
	jsr music_ctl
	jmp cmd_done

load_map_dungeon:
	clc
	lda current_location
	adc #char_0 - loc_dng_first
	sta @file_char_dungeon
	jsr j_primm_cout ;b'\x84BLOAD DNG@,A$E800\n\x00'
	.byte $84,"BLOAD DNG"
@file_char_dungeon:
	.byte "@,A$E800", $8d
	.byte 0
	ldx #$00
	txa
@reset_map:
	sta object_tile_sprite,x
	inx
	bne @reset_map
	rts

print_ruin:
	jsr j_primm  ;b'ruin!\n\x00'
	.byte "ruin!", $8d
	.byte 0
	jmp enter_towne

print_towne:
	jsr j_primm  ;b'towne!\n\x00'
	.byte "towne!", $8d
	.byte 0
enter_towne:
	lda #music_off
	jsr music_ctl
	jsr print_location_name
	jsr load_towne
	lda #$0f
	sta player_ypos
	lda #$01
	sta player_xpos
	lda current_location
	sec
	sbc #towne_first
	cmp #num_townes
	bcs @play_towne_music
	sta zp_index
	lda party_size
	sta curr_player
@check_npc_joined:
	lda curr_player
	cmp #$02
	bcc @play_towne_music
	jsr j_get_stats_ptr
	ldy #player_class_index
	lda (ptr1),y
	cmp zp_index
	beq @remove_joinable_npc
	dec curr_player
	jmp @check_npc_joined

@remove_joinable_npc:
	lda #$00
	ldx #object_max
	sta object_tile_type,x
	sta object_tile_sprite,x
	sta object_dng_level,x
@play_towne_music:
	lda #music_Towne
	jsr music_ctl
	jmp cmd_done

print_village:
	jsr j_primm  ;b'village!\n\x00'
	.byte "village!", $8d
	.byte 0
	jmp enter_towne

print_castle:
	lda #music_off
	jsr music_ctl
	jsr j_primm  ;b'castle!\n\x00'
	.byte "castle!", $8d
	.byte 0
	jsr print_location_name
	jsr load_towne
	lda #$0f
	sta player_xpos
	lda #$1e
	sta player_ypos
	lda #$00
	sta dungeon_level
	lda #music_Castles
	jsr music_ctl
	jmp cmd_done

print_shrine:
	jsr j_primm  ;b'the\nshrine of\n\x00'
	.byte "the", $8d
	.byte "shrine of", $8d
	.byte 0
	lda current_location
	clc
	adc #string_shrines
	jsr j_printstring
	jsr print_newline
load_shrine:
	lda #music_off
	jsr music_ctl
	jsr j_primm_cout ;b'\x84BLOAD SHRN,A$8800\n\x00'
	.byte $84,"BLOAD SHRN,A$8800", $8d
	.byte 0
	jsr j_overlay_entry
	lda #music_explore
	jsr music_ctl
	jmp cmd_done

location_map_x:
	.byte $56,$da,$1c,$92,$e8,$52,$24,$3a
	.byte $9f,$6a,$16,$bb,$62,$88,$c9,$88
	.byte $f0,$5b,$48,$7e,$9c,$3a,$ef,$e9
	.byte $e9,$80,$24,$49,$cd,$51,$e7,$e7
location_map_y:
	.byte $6b,$6b,$32,$f1,$87,$6a,$de,$2b
	.byte $14,$b8,$80,$a9,$91,$9e,$3b,$5a
	.byte $49,$43,$a8,$14,$1b,$66,$f0,$e9
	.byte $42,$5c,$e5,$0b,$2d,$cf,$d8,$d8

print_location_name:
	jsr print_newline
	lda current_location
	clc
	adc #string_locations
	jsr j_centerstring
	jsr print_newline
	rts

file_write_temp_map:
	lda #disk_britannia
	jsr j_request_disk
	jsr j_primm_cout ;b'\x84BSAVE TLST,A$EE00,L$100\n\x00'
	.byte $84,"BSAVE TLST,A$EE00,L$100", $8d
	.byte 0
	rts

load_towne:
	jsr file_write_temp_map
	lda #disk_towne
	jsr j_request_disk
	lda current_location
	clc
	adc #char_at_sign
load_letter_location:
	sta @map_number
	jsr j_primm_cout ;b'\n\x84BLOAD MAP@,A$8B00\n\x00'
	.byte $8d,$84,"BLOAD MAP"
@map_number:
	.byte "@,A$8B00", $8d
	.byte 0
	ldx #$00
@copy_map:
	lda file_buf,x
	sta towne_map,x
	lda file_buf+$100,x
	sta towne_map+$100,x
	lda file_buf+$200,x
	sta towne_map+$200,x
	lda file_buf+$300,x
	sta towne_map+$300,x
	lda file_buf+$400,x
	sta object_tile_sprite,x
	inx
	bne @copy_map
	lda #mode_towne
	sta game_mode
	rts

fire_at_what:
	jmp done_what

cmd_fire:
	jsr j_primm  ;b'Fire-\x00'
	.byte "Fire-", 0
	lda player_transport
	cmp #tile_ship_first
	bcc fire_at_what
	cmp #tile_ship_last
	bcs fire_at_what
	jsr input_direction
	bne :+
	jmp done_pass

:	lda delta_x
	beq @moving_n_s
	lda player_transport
	cmp #tile_ship_north
	beq @do_fire
	cmp #tile_ship_south
	beq @do_fire
@only_broadsides:
	jsr j_primm  ;b'ONLY BROADSIDES!\n\x00'
	.byte "ONLY BROADSIDES!", $8d
	.byte 0
	lda #sound_what
	jsr j_playsfx
	jmp cmd_done

@moving_n_s:
	lda player_transport
	cmp #tile_ship_west
	beq @do_fire
	cmp #tile_ship_east
	beq @do_fire
	jmp @only_broadsides

@do_fire:
	lda #sound_cannon
	jsr j_playsfx
	lda #range_missile_travel
	sta zpea
@next:
	jsr any_obj_at_temp_xy
	bpl @cannon_hit
	jsr j_gettile_opposite
	pha
	lda #tile_attack_small
	sta (ptr1),y
	jsr j_animate_view
	jsr j_gettile_opposite
	pla
	sta (ptr1),y
	clc
	lda temp_x
	adc delta_x
	sta temp_x
	clc
	lda temp_y
	adc delta_y
	sta temp_y
	dec zpea
	bne @next
	jmp cmd_done

@cannon_hit:
	stx zpd9
	jsr j_gettile_opposite
	pha
	lda #tile_attack_red
	sta (ptr1),y
	jsr j_animate_view
	lda #sound_damage
	jsr j_playsfx
	jsr j_gettile_opposite
	pla
	sta (ptr1),y
	lda zpd9
	cmp #$08     ;characters roll chance, objects instant obliterate
	bcs @destroyed
	jsr j_rand
	and #$03     ;1/4 chance
	bne @done
@destroyed:
	lda #$00
	ldx zpd9
	ldy object_tile_type,x
	cpy #tile_lord_british
	beq @done
	sta object_tile_type,x
	sta object_tile_sprite,x
@done:
	jmp cmd_done

cmd_get_chest:
	jsr j_primm  ;b'Get chest, who\nwill open-\x00'
	.byte "Get chest, who", $8d
	.byte "will open-", 0
	jsr j_getplayernum
	bne :+
	jmp done_aborted

:	cmp party_size
	bcc :+
	beq :+
	jmp done_not_a_player

:	jsr is_awake
	beq try_get_chest
	jmp done_disabled

try_get_chest:
	lda game_mode
	cmp #mode_dungeon
	beq get_in_dungeon
	lda tile_under_player
	cmp #tile_chest
	beq :+
	jmp done_not_here

:	lda current_location
	beq get_in_world
	jsr j_get_player_tile
	cmp #tile_chest
	bne get_in_world
	lda #tile_floor_brick
	sta (ptr2),y
	ldy #virtue_honesty
	lda #$01
	jsr dec_virtue
	ldy #virtue_justice
	lda #$01
	jsr dec_virtue
	ldy #virtue_honor
	lda #$01
	jsr dec_virtue
	jmp get_chest

get_in_world:
	ldx #object_max
@next:
	lda object_tile_type,x
	cmp #tile_chest
	bne @skip
	lda object_xpos,x
	cmp player_xpos
	bne @skip
	lda object_ypos,x
	cmp player_ypos
	beq @found_chest
@skip:
	dex
	bpl @next
	bmi get_chest
@found_chest:
	lda #$00
	sta object_tile_type,x
	sta object_tile_sprite,x
get_chest:
	jmp do_get_chest

get_in_dungeon:
	lda tile_under_player
	cmp #dng_tile_chest
	beq :+
	jmp done_not_here

:	lda player_xpos
	sta dest_x
	lda player_ypos
	sta dest_y
	jsr j_gettile_dungeon
	lda #$00
	sta (ptr1),y
do_get_chest:
	jsr j_rand
	bpl @trapped
	jmp collect_gold

@trapped:
	and #$03
	sta zp_trap_type
	jsr j_rand   ;1/16 bomb, 3/16 poison, 3/16 sleep, 9/16 acid
	and zp_trap_type
	sta zp_trap_type
	bne :+
	jsr j_primm  ;b'ACID\x00'
	.byte "ACID", 0
	jmp @try_evade

:	cmp #trap_sleep
	bne :+
	jsr j_primm  ;b'SLEEP\x00'
	.byte "SLEEP", 0
	jmp @try_evade

:	cmp #trap_poison
	bne :+
	jsr j_primm  ;b'POISON\x00'
	.byte "POISON", 0
	jmp @try_evade

:	jsr j_primm  ;b'BOMB\x00'
	.byte "BOMB", 0
@try_evade:
	jsr j_primm  ;b' TRAP!\n\x00'
	.byte " TRAP!", $8d
	.byte 0
	lda curr_player
	beq trap_evaded
	jsr j_get_stats_ptr
	ldy #player_dexterity
	lda (ptr1),y
	jsr decode_bcd_value
	clc
	adc #$19     ;DEX + 25
	sta zpd9
	lda #$64
	jsr rand_modulo
	cmp zpd9
	bcs check_acid
trap_evaded:
	jsr j_primm  ;b'EVADED!\n\x00'
	.byte "EVADED!", $8d
	.byte 0
	lda #sound_alert
	jsr j_playsfx
	jmp collect_gold

check_acid:
	lda zp_trap_type
	bne @check_sleep
	jsr burn_player
	jmp collect_gold

@check_sleep:
	cmp #trap_sleep
	bne @check_poison
	jsr j_get_stats_ptr
	ldy #player_status
	lda #status_Sleep
	sta (ptr1),y
	jsr hilight_damaged_plr
	lda game_mode
	bpl collect_gold
	lda #tile_human_prone
	ldx curr_player
	sta combat_player_tile-1,x
	jmp collect_gold

@check_poison:
	cmp #trap_poison
	bne check_bomb
	jsr j_get_stats_ptr
	ldy #player_status
	lda #status_Poison
	sta (ptr1),y
	jsr hilight_damaged_plr
	jmp collect_gold

check_bomb:
	jsr damage_party

collect_gold:
	jsr j_primm  ;b'THE CHEST HOLDS:\n\x00'
	.byte "THE CHEST HOLDS:", $8d
	.byte 0
	lda #$64
	jsr rand_modulo
	jsr encode_bcd_value
	jsr inc_party_gold
	lda zp_amount
	jsr j_printbcd
	jsr j_primm  ;b'-GOLD!\n\x00'
	.byte "-GOLD!", $8d
	.byte 0
	jmp cmd_done

cmd_hole_up:
	jsr j_primm  ;b'Hole up & camp\n\x00'
	.byte "Hole up & camp", $8d
	.byte 0
	lda current_location
	beq @check_transport ;loc_world
	lda game_mode
	cmp #mode_dungeon
	beq @check_transport
	jmp done_not_here

@check_transport:
	lda player_transport
	cmp #tile_walk
	beq @load_file_camp
	jsr j_primm  ;b'MUST BE ON FOOT!\n\x00'
	.byte "MUST BE ON FOOT!", $8d
	.byte 0
	jmp cmd_done

@load_file_camp:
	lda #music_off
	jsr music_ctl
	jsr j_primm_cout ;b'\x84BLOAD HOLE,A$8800\n\x00'
	.byte $84,"BLOAD HOLE,A$8800", $8d
	.byte 0
	jsr j_overlay_entry
	jsr j_update_status
	lda #music_explore
	jsr music_ctl
	lda game_mode
	cmp #mode_dungeon
	bne :+
	jsr j_dng_neighbor_tiles
:	jmp cmd_done

cmd_ignite:
	jsr j_primm  ;b'Ignite torch!\n\x00'
	.byte "Ignite torch!", $8d
	.byte 0
	ldy #party_stat_torches
	jsr dec_stat
	bcs :+
	jmp done_have_none

:	lda #$64
	sta light_duration
	lda game_mode
	cmp #mode_dungeon
	bne :+
	jsr j_dng_neighbor_tiles
:	jmp cmd_done

cmd_jimmy_lock:
	jsr j_primm  ;b'Jimmy lock-\x00'
	.byte "Jimmy lock-", 0
	jsr input_direction
	lda game_mode
	cmp #mode_world
	bne :+
	jmp done_not_here

:	jsr j_gettile_towne
	cmp #tile_door_locked
	beq :+
	jmp done_not_here

:	ldy #party_stat_keys
	jsr dec_stat
	bcs :+
	jmp done_have_none

:	lda #tile_door_unlocked
	ldy #$00
	sta (ptr2),y
	jmp done_done

cmd_klimb:
	jsr j_primm  ;b'Klimb \x00'
	.byte "Klimb ", 0
	lda current_location
	beq @world
	cmp #loc_castle_britannia
	beq @castle_britannia
	lda game_mode
	cmp #mode_dungeon
	beq @dungeon
@deny:
	jmp done_what

@dungeon:
	lda tile_under_player
	and #dng_tile_type_mask
	cmp #dng_tile_ladder_u
	beq :+
	cmp #dng_tile_ladder_du
	bne @deny
:	jsr j_primm  ;b'up!\n\x00'
	.byte "up!", $8d
	.byte 0
	dec dungeon_level
	bpl :+
	jmp leave_to_world

:	jsr j_primm  ;b'To level \x00'
	.byte "To level ", 0
	clc
	lda dungeon_level
	adc #$01
	jsr j_printdigit
	jsr print_newline
	jmp cmd_done

@world:
	lda player_transport
	cmp #tile_balloon
	bne @deny
	jsr j_primm  ;b'altitude\n\x00'
	.byte "altitude", $8d
	.byte 0
	lda #balloon_aloft
	sta movement_mode
	sta balloon_flying
	jmp cmd_done

@castle_britannia:
	lda tile_under_player
	cmp #tile_ladder_up
	bne @deny
	lda player_transport
	cmp #tile_walk
	beq :+
	jsr print_newline
	jmp done_only_on_foot

:	jsr j_primm  ;b'to\nsecond floor!\n\x00'
	.byte "to", $8d
	.byte "second floor!", $8d
	.byte 0
	lda #music_off
	jsr music_ctl
	lda #$c0     ;second floor of castle britannia
	jsr load_letter_location
	lda #music_explore
	jsr music_ctl
	jmp cmd_done

cmd_locate:
	jsr j_primm  ;b'Locate position\n\x00'
	.byte "Locate position", $8d
	.byte 0
	lda sextant
	bne @have_sextant
	jsr j_primm  ;b'WITH \x00'
	.byte "WITH ", 0
	jmp done_what

@have_sextant:
	jsr j_primm  ;b'with sextant:\n\n latitude:\x00'
	.byte "with sextant:", $8d
	.byte $8d
	.byte " latitude:", 0
	lda player_ypos
	lsr
	lsr
	lsr
	lsr
	clc
	adc #char_alpha_first
	jsr j_console_out
	lda #$a7
	jsr j_console_out
	lda player_ypos
	and #$0f
	clc
	adc #char_alpha_first
	jsr j_console_out
	jsr j_primm  ;b'"\nlongitude:\x00'
	.byte $a2, $8d  ; double-quote (")
	.byte "longitude:", 0
	lda player_xpos
	lsr
	lsr
	lsr
	lsr
	clc
	adc #char_alpha_first
	jsr j_console_out
	lda #$a7
	jsr j_console_out
	lda player_xpos
	and #$0f
	clc
	adc #char_alpha_first
	jsr j_console_out
	lda #$a2
	jsr j_console_out
	jsr print_newline
	jmp cmd_done

cmd_mix_reagents:
	jsr display_spells
	jsr j_primm  ;b'Mix reagents\n\x00'
	.byte "Mix reagents", $8d
	.byte 0
	lda #music_off
	jsr music_ctl
	jsr j_primm_cout ;b'\x84BLOAD MIX,A$8800\n\x00'
	.byte $84,"BLOAD MIX,A$8800", $8d
	.byte 0
	jsr j_overlay_entry
	lda #music_explore
	jsr music_ctl
	jmp cmd_done

cmd_new_order:
	jsr j_primm  ;b'New order:\nexchange #\x00'
	.byte "New order:", $8d
	.byte "exchange #", 0
	jsr j_getplayernum
	bne :+
	jmp done_aborted

:	cmp #$01
	beq you_must_lead
	cmp party_size
	bcc :+
	beq :+
	jmp done_not_here

:	sta target_player
	jsr j_get_stats_ptr
	lda ptr1
	sta new_order_stat_ptr
	lda ptr1 + 1
	sta new_order_stat_ptr+1
	jsr j_primm  ;b'    with #\x00'
	.byte "    with #", 0
	jsr j_getplayernum
	bne :+
	jmp done_aborted

:	cmp #$01
	beq you_must_lead
	cmp target_player
	bne :+
	jmp done_done

:	cmp party_size
	bcc :+
	beq :+
	jmp done_not_here

:	jsr j_get_stats_ptr
	ldy #player_stat_max
	lda new_order_stat_ptr
	sta ptr2
	lda new_order_stat_ptr+1
	sta ptr2 + 1
@next:
	lda (ptr1),y
	pha
	lda (ptr2),y
	sta (ptr1),y
	pla
	sta (ptr2),y
	dey
	bpl @next
	jsr j_clearstatwindow
	jsr j_update_status
	jmp done_done

you_must_lead:
	jsr j_printname
	jsr j_primm  ;b'\nYOU MUST LEAD!\n\x00'
	.byte $8d
	.byte "YOU MUST LEAD!", $8d
	.byte 0
	jmp done_aborted

new_order_stat_ptr:
	.byte 0
	.byte 0

cmd_open_door:
	jsr close_open_door
	lda door_open_countdown
	bne cmd_open_door
	jsr j_primm  ;b'Open-\x00'
	.byte "Open-", 0
	jsr input_direction
	lda game_mode
	cmp #mode_towne
	beq :+
@not_here:
	jmp done_not_here

:	jsr j_gettile_towne
	cmp #tile_door_unlocked
	beq :+
	cmp #tile_door_locked
	bne @not_here
	jmp done_cant

:	lda temp_x
	sta door_open_x
	lda temp_y
	sta door_open_y
	lda #$05     ;self close after N turns
	sta door_open_countdown
	lda #tile_floor_brick
	sta (ptr2),y
	jsr j_primm  ;b'OPENED!\n\x00'
	.byte "OPENED!", $8d
	.byte 0
	jmp cmd_done

cmd_peer_gem:
	jsr j_primm  ;b'Peer at \x00'
	.byte "Peer at ", 0
	ldy #party_stat_gems
	jsr dec_stat
	bcs :+
	jmp done_what

:	jsr j_primm  ;b'a gem!\n\x00'
	.byte "a gem!", $8d
	.byte 0
	jsr do_view
	jmp cmd_done

do_view:
	lda #music_off
	jsr music_ctl
	jsr j_primm_cout ;b'\x84BLOAD TMAP,A$9000\n\x00'
	.byte $84,"BLOAD TMAP,A$9000", $8d
	.byte 0
	lda #music_peer
	jsr music_ctl
	jsr j_peer
	lda game_mode
	cmp #mode_dungeon
	bne @skip
	lda #music_off
	jsr music_ctl
	jsr j_primm_cout ;b'\x84BLOAD DNGD,A$8C00\n\x00'
	.byte $84,"BLOAD DNGD,A$8C00", $8d
	.byte 0
@skip:
	lda #music_explore
	jsr music_ctl
	rts

cmd_quit:
	jsr j_primm  ;b'Quit & save...\n\x00'
	.byte "Quit & save...", $8d
	.byte 0
	jsr @print_move_count
	lda current_location
	beq :+
	jmp done_not_here

:	lda #music_off
	jsr music_ctl
	lda #disk_britannia
	jsr j_request_disk
	jsr j_primm_cout ;b'\x84BSAVE LIST,A$EE00,L$100\n\x84BSAVE ROST,A$EC00,L$200\n\x84BSAVE PRTY,A$0,L$20\n\x00'
	.byte $84,"BSAVE LIST,A$EE00,L$100", $8d
	.byte $84,"BSAVE ROST,A$EC00,L$200", $8d
	.byte $84,"BSAVE PRTY,A$0,L$20", $8d
	.byte 0
	lda #music_explore
	jsr music_ctl
	jmp cmd_done

@print_move_count:
	lda move_counter
	cmp #$10
	bcs @digits_8
	cmp #$00
	bne @digits_7
	lda move_counter + 1
	cmp #$10
	bcs @digits_6
	cmp #$00
	bne @digits_5
	lda move_counter + 2
	cmp #$10
	bcs @digits_4
	cmp #$00
	bne @digits_3
	lda move_counter + 3
	cmp #$10
	bcs @digits_2
	cmp #$00
	bne @digits_1
@digits_8:
	lda move_counter
	jsr @print_hi_bcd
@digits_7:
	lda move_counter
	jsr @print_lo_bcd
@digits_6:
	lda move_counter + 1
	jsr @print_hi_bcd
@digits_5:
	lda move_counter + 1
	jsr @print_lo_bcd
@digits_4:
	lda move_counter + 2
	jsr @print_hi_bcd
@digits_3:
	lda move_counter + 2
	jsr @print_lo_bcd
@digits_2:
	lda move_counter + 3
	jsr @print_hi_bcd
@digits_1:
	lda move_counter + 3
	jsr @print_lo_bcd
	jsr j_primm  ;b' moves!\n\x00'
	.byte " moves!", $8d
	.byte 0
	rts

@print_hi_bcd:
	lsr
	lsr
	lsr
	lsr
	jsr j_printdigit
	rts

@print_lo_bcd:
	and #$0f
	jsr j_printdigit
	rts

cmd_ready_weapon:
	jsr j_primm  ;b'Ready a weapon\nfor player-\x00'
	.byte "Ready a weapon", $8d
	.byte "for player-", 0
	jsr j_getplayernum
	beq :+
	cmp party_size
	bcc ask_weapon
	beq ask_weapon
:	jmp done_not_a_player

ask_weapon:
	jsr ztats_1_weapons
	jsr j_primm  ;b'Weapon:\x00'
	.byte "Weapon:", 0
	jsr input_char
	pha
	jsr j_clearstatwindow
	jsr j_update_status
	lda game_mode
	bpl :+
	jsr invert_player_name
:	pla
	sec
	sbc #char_alpha_first
	cmp #weapon_last
	bcc @check_inv
	jmp done_aborted

@check_inv:
	sta zp_selected
	cmp #weapon_none
	beq @check_class_legal
	clc
	adc #party_stat_weapons
	tay
	lda party_stats,y
	bne @check_class_legal
	jmp done_have_none

@check_class_legal:
	jsr j_get_stats_ptr
	ldy #player_class_bit
	lda (ptr1),y
	ldx zp_selected
	and weapon_class_masks,x
	bne @unequip_current
	jmp weap_arm_disallowed

@unequip_current:
	ldy #player_weapon
	lda (ptr1),y
	beq @equip_new
	clc
	adc #party_stat_weapons
	tay
	jsr inc_stat
@equip_new:
	ldy #player_weapon
	lda zp_selected
	sta (ptr1),y
	beq @print_weapon_name
	clc
	adc #party_stat_weapons
	tay
	jsr dec_stat
@print_weapon_name:
	lda zp_selected
	clc
	adc #string_weapon_first
	jsr j_printstring
	jsr print_newline
	jmp done_done

weapon_class_masks:
	.byte $ff,$ff,$ff,$ff,$7f,$6f,$6f,$7e
	.byte $7e,$ff,$2c,$0c,$2e,$5e,$d0,$ff

weap_arm_disallowed:
	jsr print_newline
	jsr j_primm  ;b'A \x00'
	.byte "A ", 0
	jsr j_get_stats_ptr
	ldy #player_class_index
	lda (ptr1),y
	clc
	adc #string_class_first
	jsr j_printstring
	jsr j_primm  ;b'\nMAY NOT USE A\n\x00'
	.byte $8d
	.byte "MAY NOT USE A", $8d
	.byte 0
	lda zp_selected
	clc
	adc #string_weapon_first
	jsr j_printstring
	jsr print_newline
	jmp done_aborted

cmd_search:
	jsr j_primm  ;b'Search...\n\x00'
	.byte "Search...", $8d
	.byte 0
	lda #music_off
	jsr music_ctl
	jsr j_primm_cout ;b'\x84BLOAD SEAR,A$8800\n\x00'
	.byte $84,"BLOAD SEAR,A$8800", $8d
	.byte 0
	jsr j_overlay_entry
	lda #music_explore
	jsr music_ctl
	jmp cmd_done

cmd_talk:
	jsr j_primm  ;b'Talk-\x00'
	.byte "Talk-", 0
	jsr input_direction
	bne check_through_sign
	jmp done_pass

check_through_sign:
	jsr j_gettile_towne
	cmp #tile_sign_first
	bcc check_direct
	cmp #tile_sign_last
	bcs check_direct
	clc
	lda temp_x
	adc delta_x
	sta temp_x
	clc
	lda temp_y
	adc delta_y
	sta temp_y
	jsr get_mob_at_temp_xy
	bmi no_response
	lda object_tile_type,x
	cmp #tile_shopkeeper
	bne no_response
	jmp check_shop

check_direct:
	jsr get_mob_at_temp_xy
	bmi no_response
	stx zpea
	lda current_location
	beq no_response
	cmp #loc_dng_first
	bcc :+
no_response:
	jsr j_primm  ;b'FUNNY, NO\nRESPONSE!\n\x00'
	.byte "FUNNY, NO", $8d
	.byte "RESPONSE!", $8d
	.byte 0
	jmp cmd_done

:	sta lt_track
	dec lt_track
	ldx zpea
	lda npc_dialogue,x
	sta lt_sector
	beq no_response
	dec lt_sector
	lda #lt_rwflag_read
	sta lt_rwflag
	lda #$ef
	sta lt_addr_hi
	lda #music_off
	jsr music_ctl
	ldx zpea
	lda object_tile_type,x
	cmp #tile_lord_british
	bne @talk_non_british
	lda #disk_britannia
	jsr j_request_disk
	jsr j_primm_cout ;b'\x84BLOAD LORD,A$8800\n\x00'
	.byte $84,"BLOAD LORD,A$8800", $8d
	.byte 0
	lda #music_British
	jsr music_ctl
	jsr talk_lord_british
	lda #music_off
	jsr music_ctl
	lda #disk_towne
	jsr j_request_disk
	lda #music_Castles
	jsr music_ctl
	jmp @end_talk

@talk_non_british:
	jsr j_loadsector
	jsr j_primm_cout ;b'\x84BLOAD TALK,A$8800\n\x00'
	.byte $84,"BLOAD TALK,A$8800", $8d
	.byte 0
	jsr j_overlay_entry
@end_talk:
	lda #music_explore
	jsr music_ctl
	jmp cmd_done

check_shop:
	lda #music_off
	jsr music_ctl
	jsr j_primm_cout ;b'\x84BLOAD SHPS,A$8800\n\x00'
	.byte $84,"BLOAD SHPS,A$8800", $8d
	.byte 0
	lda #$88
	sta ptr1 + 1
	lda current_location
	sec
	sbc #$01
	asl
	asl
	asl
	sta ptr1
	ldy #$07     ;try 8 types of shop
@next:
	lda (ptr1),y
	cmp dest_y
	beq load_shop
	dey
	bpl @next
	lda dest_y
	cmp #$18     ;row 24
	bne :+
	lda current_location
	cmp #loc_village_paws
	bne :+
	ldy #shop_horse
	bne load_shop
:	lda dest_y
	cmp #$19     ;row 25
	bne @no_response
	lda current_location
	cmp #loc_castle_britannia
	bne @no_response
	ldy #shop_hawkwind
	jmp load_shop

@no_response:
	jmp no_response

load_shop:
	tya
	clc
	adc #char_0
	sta @file_char_shop
	jsr j_primm_cout ;b'\x84BLOAD SHP@,A$8800\n\x00'
	.byte $84,"BLOAD SHP"
@file_char_shop:
	.byte "@,A$8800", $8d
	.byte 0
	lda #music_shop
	jsr music_ctl
	jsr j_overlay_entry
	lda #music_explore
	jsr music_ctl
	jmp cmd_done

cmd_use_item:
	jsr j_primm  ;b'Use...\n\x00'
	.byte "Use...", $8d
	.byte 0
	lda #music_off
	jsr music_ctl
	jsr j_primm_cout ;b'\x84BLOAD USE,A$8800\n\x00'
	.byte $84,"BLOAD USE,A$8800", $8d
	.byte 0
	jsr j_overlay_entry
	lda game_mode
	bmi @combat
	lda #music_explore
	jsr music_ctl
	jmp cmd_done

@combat:
	lda #music_combat
	jsr music_ctl
	jmp cmd_done

cmd_volume:
	jsr j_primm  ;b'Volume \x00'
	.byte "Volume ", 0
	lda music_volume
	bne @off
	lda #$ff
	sta music_volume
	jsr j_primm  ;b'ON\n\x00'
	.byte "ON", $8d
	.byte 0
	jmp cmd_done

@off:
	lda #$00
	sta music_volume
	jsr j_primm  ;b'OFF\n\x00'
	.byte "OFF", $8d
	.byte 0
	jmp cmd_done

cmd_wear_armour:
	jsr j_primm  ;b'Wear armour\nfor player-\x00'
	.byte "Wear armour", $8d
	.byte "for player-", 0
	jsr j_getplayernum
	beq :+
	cmp party_size
	bcc ask_armour
	beq ask_armour
:	jmp done_not_a_player

ask_armour:
	jsr display_armour
	jsr j_primm  ;b'Armour:\x00'
	.byte "Armour:", 0
	jsr input_char
	pha
	jsr j_clearstatwindow
	jsr j_update_status
	lda game_mode
	bpl :+
	jsr invert_player_name
:	pla
	sec
	sbc #char_alpha_first
	cmp #armour_last
	bcc @check_inv
	jmp done_aborted

@check_inv:
	sta zp_selected
	cmp #armour_none
	beq @check_class_legal
	clc
	adc #party_stat_armour
	tay
	lda party_stats,y
	bne @check_class_legal
	jmp done_have_none

@check_class_legal:
	jsr j_get_stats_ptr
	ldy #player_class_bit
	lda (ptr1),y
	ldx zp_selected
	and armour_class_masks,x
	bne @unequip_current
	lda zp_selected
	clc
	adc #$10     ;adjust to re-use same code as weapon
	sta zp_selected
	jmp weap_arm_disallowed

@unequip_current:
	ldy #player_armour
	lda (ptr1),y
	beq @eqiup_new
	clc
	adc #party_stat_armour
	tay
	jsr inc_stat
@eqiup_new:
	ldy #player_armour
	lda zp_selected
	sta (ptr1),y
	beq @print_armour_name
	clc
	adc #party_stat_armour
	tay
	jsr dec_stat
@print_armour_name:
	lda zp_selected
	clc
	adc #string_armour_first
	jsr j_printstring
	jsr print_newline
	jmp done_done

armour_class_masks:
	.byte $ff,$ff,$7f,$2c,$2c,$24,$04,$ff

cmd_x_it:
	jsr j_primm  ;b'X-it \x00'
	.byte "X-it ", 0
	lda player_transport
	cmp #tile_ship_first
	bcc @what
	cmp #tile_ship_last
	bcc @ship
	cmp #tile_horse_last
	bcc @horse
	cmp #tile_balloon
	beq @balloon
@what:
	jmp done_what

@ship:
	lda player_xpos
	sta last_ship_x
	lda player_ypos
	sta last_ship_y
	jmp @find_empty_slot

@horse:
	lda #$00
	sta horse_mode
@balloon:
	lda movement_mode
	beq @find_empty_slot
	jmp done_not_here

@find_empty_slot:
	ldx #object_max
@next:
	lda object_tile_type,x
	beq @exit_transport
	dex
	cpx #object_inanimate_first
	bcs @next
	jsr j_rand
	and #$0f
	ora #$10     ;overwrite random slot 10-1F
	tax
@exit_transport:
	lda player_transport
	sta object_tile_type,x
	sta object_tile_sprite,x
	lda player_xpos
	sta object_xpos,x
	lda player_ypos
	sta object_ypos,x
	lda #$00
	sta object_dng_level,x
	sta npc_dialogue,x
	lda #tile_walk
	sta player_transport
	jsr print_newline
	jmp cmd_done

cmd_yell_horse:
	jsr j_primm  ;b'Yell \x00'
	.byte "Yell ", 0
	lda player_transport
	cmp #tile_horse_west
	beq :+
	cmp #tile_horse_east
	beq :+
	jmp done_what

:	lda horse_mode
	eor #$ff
	sta horse_mode
	bmi :+
	jsr j_primm  ;b'whoa!\n\x00'
	.byte "whoa!", $8d
	.byte 0
	jmp cmd_done

:	jsr j_primm  ;b'giddyup!\n\x00'
	.byte "giddyup!", $8d
	.byte 0
	jmp cmd_done

cmd_ztats:
	jsr j_primm  ;b'Ztats for-\x00'
	.byte "Ztats for-", 0
	jsr j_getplayernum
	bne @check_valid_player
	jmp zstats_page_1

@check_valid_player:
	cmp party_size
	bcc zstats_for_player
	beq zstats_for_player
	jmp done_not_a_player

zstats_for_player:
	jsr j_clearstatwindow
	jsr save_cursor
	ldx #$1c
	ldy #$00
	jsr j_primm_xy ;b'>PLR-\x00'
	.byte $1e,"PLR-", 0
	lda curr_player
	jsr j_printdigit
	lda #char_less
	jsr j_console_out
	ldx #$18
	stx console_xpos
	ldy #$01
	sty console_ypos
	jsr j_centername
	ldx #$18
	stx console_xpos
	ldy #$02
	sty console_ypos
	jsr j_get_stats_ptr
	ldy #player_gender
	lda (ptr1),y
	jsr j_console_out
	lda #char_space
	jsr j_console_out
	ldx #$18
	stx console_xpos
	jsr j_get_stats_ptr
	ldy #player_class_index
	lda (ptr1),y
	clc
	adc #string_class
	jsr j_centerstring
	ldx #$26
	stx console_xpos
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	jsr j_console_out
	ldx #$19
	ldy #$03
	jsr j_primm_xy ;b'MP:\x00'
	.byte "MP:", 0
	jsr j_get_stats_ptr
	ldy #player_magic_points
	lda (ptr1),y
	jsr j_printbcd
	ldx #$20
	ldy #$03
	jsr j_primm_xy ;b'LV:\x00'
	.byte "LV:", 0
	jsr j_get_stats_ptr
	ldy #player_max_hp_hi
	lda (ptr1),y
	jsr j_printdigit
	ldx #$18
	ldy #$04
	jsr j_primm_xy ;b'STR:\x00'
	.byte "STR:", 0
	jsr j_get_stats_ptr
	ldy #player_strength
	lda (ptr1),y
	jsr j_printbcd
	ldx #$18
	ldy #$05
	jsr j_primm_xy ;b'DEX:\x00'
	.byte "DEX:", 0
	jsr j_get_stats_ptr
	ldy #player_dexterity
	lda (ptr1),y
	jsr j_printbcd
	ldx #$18
	ldy #$06
	jsr j_primm_xy ;b'INT:\x00'
	.byte "INT:", 0
	jsr j_get_stats_ptr
	ldy #player_intelligence
	lda (ptr1),y
	jsr j_printbcd
	ldx #$20
	ldy #$04
	jsr j_primm_xy ;b'HP:\x00'
	.byte "HP:", 0
	jsr j_get_stats_ptr
	ldy #player_cur_hp_hi
	lda (ptr1),y
	jsr j_printbcd
	ldy #player_cur_hp_lo
	lda (ptr1),y
	jsr j_printbcd
	ldx #$20
	ldy #$05
	jsr j_primm_xy ;b'HM:\x00'
	.byte "HM:", 0
	jsr j_get_stats_ptr
	ldy #player_max_hp_hi
	lda (ptr1),y
	jsr j_printbcd
	ldy #player_max_hp_lo
	lda (ptr1),y
	jsr j_printbcd
	ldx #$20
	ldy #$06
	jsr j_primm_xy ;b'EX:\x00'
	.byte "EX:", 0
	jsr j_get_stats_ptr
	ldy #player_experience_hi
	lda (ptr1),y
	jsr j_printbcd
	ldy #player_experience_lo
	lda (ptr1),y
	jsr j_printbcd
	ldx #$18
	ldy #$07
	jsr j_primm_xy ;b'W:\x00'
	.byte "W:", 0
	jsr j_get_stats_ptr
	ldy #player_weapon
	lda (ptr1),y
	clc
	adc #string_weapon_first
	jsr j_printstring
	ldx #$18
	ldy #$08
	jsr j_primm_xy ;b'A:\x00'
	.byte "A:", 0
	jsr j_get_stats_ptr
	ldy #player_armour
	lda (ptr1),y
	clc
	adc #string_armour
	jsr j_printstring
	jsr restore_cursor
	jsr input_ztats_key
	beq quit_view
	bmi @prev_page
	inc curr_player
	lda party_size
	cmp curr_player
	bcc zstats_page_1
	jmp zstats_for_player

@prev_page:
	dec curr_player
	beq ztats_page_6
	jmp zstats_for_player

zstats_page_1:
	jsr ztats_1_weapons
	jsr input_ztats_key
	beq quit_view
	bpl ztats_page_2
	lda party_size
	sta curr_player
	jmp zstats_for_player

ztats_page_2:
	jsr display_armour
	jsr input_ztats_key
	beq quit_view
	bmi zstats_page_1
ztats_page_3:
	jsr display_tools
	jsr input_ztats_key
	beq quit_view
	bmi ztats_page_2
ztats_page_4:
	jsr display_quests
	jsr input_ztats_key
	beq quit_view
	bmi ztats_page_3
ztats_page_5:
	jsr display_reagents
	jsr input_ztats_key
	beq quit_view
	bmi ztats_page_4
ztats_page_6:
	jsr display_spells
	jsr input_ztats_key
	beq quit_view
	bmi ztats_page_5
	lda #$01
	sta curr_player
	jmp zstats_for_player

quit_view:
	jsr j_clearstatwindow
	jsr j_update_status
	lda game_mode
	bpl @done
	lda curr_player_turn ;combat restore
	sta curr_player
	jsr invert_player_name
@done:
	jmp cmd_done

input_ztats_key:
	jsr j_waitkey
	bpl input_ztats_key
	cmp #char_left_arrow
	beq @key_prev
	cmp #char_right_arrow
	beq @key_next
	lda #$00
	rts

@key_prev:
	lda #$ff
	rts

@key_next:
	lda #$01
	rts

ztats_1_weapons:
	jsr j_clearstatwindow
	jsr save_cursor
	ldx #$1b
	ldy #$00
	sty zp_index
	sty zp_display_line
	jsr j_primm_xy ;b'>WEAPONS<\x00'
	.byte $1f,"WEAPONS",$1d, 0
@next:
	lda zp_display_line
	and #$08
	clc
	adc #$18
	sta console_xpos
	lda zp_display_line
	and #$07
	sta console_ypos
	inc console_ypos
	lda zp_index
	beq @nothing
	clc
	adc #party_stat_weapons
	tay
	lda party_stats,y
	beq @skip
	pha
	lda zp_index
	clc
	adc #char_alpha_first
	jsr j_console_out
	pla
	cmp #$10
	bcs @two_digit
	pha
	lda #char_hyphen
	jsr j_console_out
	pla
	jsr j_printdigit
	jmp :+

@two_digit:
	jsr j_printbcd
:	lda #char_hyphen
	jsr j_console_out
	lda zp_index
	clc
	adc #string_weapons_short
	jsr j_printstring
	inc zp_display_line
@skip:
	inc zp_index
	lda zp_index
	cmp #$10
	bcc @next
	jsr restore_cursor
	rts

@nothing:
	jsr j_primm  ;b'A-HANDS\x00'
	.byte "A-HANDS", 0
	inc zp_display_line
	jmp @skip

display_armour:
	jsr j_clearstatwindow
	jsr save_cursor
	ldx #$1b
	ldy #$00
	sty zp_index
	sty zp_display_line
	jsr j_primm_xy ;b'>ARMOUR<\x00'
	.byte $1f,"ARMOUR",$1c, 0
@next:
	lda #$18
	sta console_xpos
	lda zp_display_line
	sta console_ypos
	inc console_ypos
	lda zp_index
	beq @no_armour
	clc
	adc #$18
	tay
	lda party_stats,y
	beq @skip
	pha
	lda zp_index
	clc
	adc #char_alpha_first
	jsr j_console_out
	pla
	cmp #$10
	bcs @two_digit
	pha
	lda #char_hyphen
	jsr j_console_out
	pla
	jsr j_printdigit
	jmp :+

@two_digit:
	jsr j_printbcd
:	lda #char_hyphen
	jsr j_console_out
	lda zp_index
	clc
	adc #string_armour
	jsr j_printstring
	inc zp_display_line
@skip:
	inc zp_index
	lda zp_index
	cmp #$08
	bcc @next
	jsr restore_cursor
	rts

@no_armour:
	jsr j_primm  ;b'A-NO ARMOUR\x00'
	.byte "A-NO ARMOUR", 0
	inc zp_display_line
	jmp @skip

display_tools:
	jsr j_clearstatwindow
	jsr save_cursor
	ldx #$1a
	ldy #$00
	jsr j_primm_xy ;b'>EQUIPMENT<\x00'
	.byte $1e,"EQUIPMENT",$1c, 0
	jsr next_line
	ldy #party_stat_torches
	lda party_stats,y
	jsr j_printbcd
	jsr j_primm  ;b'-TORCHES\x00'
	.byte "-TORCHES", 0
	jsr next_line
	ldy #party_stat_gems
	lda party_stats,y
	jsr j_printbcd
	jsr j_primm  ;b'-GEMS\x00'
	.byte "-GEMS", 0
	jsr next_line
	ldy #party_stat_keys
	lda party_stats,y
	jsr j_printbcd
	jsr j_primm  ;b'-KEYS\x00'
	.byte "-KEYS", 0
	jsr next_line
	ldy #party_stat_sextant
	lda party_stats,y
	beq :+
	jsr j_printbcd
	jsr j_primm  ;b'-SEXTANTS\x00'
	.byte "-SEXTANTS", 0
:	jsr restore_cursor
	rts

display_quests:
	jsr j_clearstatwindow
	jsr save_cursor
	ldx #$1c
	ldy #$00
	jsr j_primm_xy ;b'>ITEMS<\x00'
	.byte $1e,"ITEMS",$1c, 0
	lda #$00
	sta console_ypos
	lda stones
	beq display_runes
	sta zp_item_flags
	jsr next_line
	jsr j_primm  ;b'STONES:\x00'
	.byte "STONES:", 0
	ldy #$07
@next:
	rol zp_item_flags
	bcc @skip
	sty zpd9
	lda stone_sym,y
	jsr j_console_out
	ldy zpd9
@skip:
	dey
	bpl @next
display_runes:
	lda runes
	beq display_items
	sta zp_item_flags
	jsr next_line
	jsr j_primm  ;b'RUNES:\x00'
	.byte "RUNES:", 0
	ldy #$07
@next:
	rol zp_item_flags
	bcc @skip
	sty zpd9
	lda rune_sym,y
	jsr j_console_out
	ldy zpd9
@skip:
	dey
	bpl @next
display_items:
	lda bell_book_candle
	beq display_3_part_key
	jsr next_line
	lda bell_book_candle
	and #item_flag_bell
	beq :+
	jsr j_primm  ;b'BELL \x00'
	.byte "BELL ", 0
:	lda bell_book_candle
	and #item_flag_book
	beq :+
	jsr j_primm  ;b'BOOK \x00'
	.byte "BOOK ", 0
:	lda bell_book_candle
	and #item_flag_candle
	beq :+
	jsr j_primm  ;b'CANDL\x00'
	.byte "CANDL", 0
display_3_part_key:
	lda threepartkey
	beq display_horn_etc
	jsr next_line
	jsr j_primm  ;b'3 PART KEY:\x00'
	.byte "3 PART KEY:", 0
	lda threepartkey
	and #key3_flag_truth
	beq :+
	lda #char_T
	jsr j_console_out
:	lda threepartkey
	and #key3_flag_love
	beq :+
	lda #char_L
	jsr j_console_out
:	lda threepartkey
	and #key3_flag_courage
	beq display_horn_etc
	lda #char_C
	jsr j_console_out
display_horn_etc:
	lda horn
	beq :+
	jsr next_line
	jsr j_primm  ;b'HORN\x00'
	.byte "HORN", 0
:	lda wheel
	beq :+
	jsr next_line
	jsr j_primm  ;b'WHEEL\x00'
	.byte "WHEEL", 0
:	lda skull
	beq :+
	bmi :+
	jsr next_line
	jsr j_primm  ;b'SKULL\x00'
	.byte "SKULL", 0
:	jsr restore_cursor
	rts

next_line:
	inc console_ypos
	ldx #$18
	stx console_xpos
	rts

stone_sym:
	.byte $c2,$d7,$d0,$cf,$c7,$d2,$d9,$c2 ;BWPOGRYB
rune_sym:
	.byte $c8,$d3,$c8,$d3,$ca,$d6,$c3,$c8 ;HSHSJVCH

display_reagents:
	jsr j_clearstatwindow
	jsr save_cursor
	ldx #$1a
	ldy #$00
	sty zp_reagent_index
	jsr j_primm_xy ;b'>REAGENTS<\x00'
	.byte $1e,"REAGENTS",$1d, 0
@next:
	clc
	lda zp_reagent_index
	adc #party_stat_reagents
	tay
	lda party_stats,y
	beq @skip
	sta zp_reagent_count
	jsr next_line
	clc
	lda zp_reagent_index
	adc #char_A
	jsr j_console_out
	lda zp_reagent_count
	cmp #$10
	bcs @two_digit
	lda #char_hyphen
	jsr j_console_out
	lda zp_reagent_count
	jsr j_printdigit
	jmp :+

@two_digit:
	jsr j_printbcd
:	lda #char_hyphen
	jsr j_console_out
	clc
	lda zp_reagent_index
	adc #string_reagent_first
	jsr j_printstring
@skip:
	inc zp_reagent_index
	lda zp_reagent_index
	cmp #$08
	bcc @next
	jsr restore_cursor
	rts

display_spells:
	jsr j_clearstatwindow
	jsr save_cursor
	ldx #$1a
	ldy #$00
	sty zp_index
	sty zp_display_line
	jsr j_primm_xy ;b'>MIXTURES<\x00'
	.byte $1e,"MIXTURES",$1d, 0
@next:
	lda zp_display_line
	lsr
	lsr
	lsr
	ldx #$05     ;column width
	jsr j_mulax
	clc
	adc #$18     ;left margin
	sta console_xpos
	cmp #$24
	bcs @skip
	lda zp_display_line
	and #$07     ;wrap after 8 rows
	sta console_ypos
	inc console_ypos
	ldy zp_index
	lda mixtures,y
	beq @skip
	lda zp_index
	clc
	adc #char_A
	jsr j_console_out
	lda #char_hyphen
	jsr j_console_out
	ldy zp_index
	lda mixtures,y
	jsr j_printbcd
	inc zp_display_line
@skip:
	inc zp_index
	lda zp_index
	cmp #$1a     ;26, A-Z spells
	bcc @next
	jsr restore_cursor
	rts

save_cursor:
	lda console_xpos
	sta saved_cursor_x
	lda console_ypos
	sta saved_cursor_y
	rts

restore_cursor:
	lda saved_cursor_x
	sta console_xpos
	lda saved_cursor_y
	sta console_ypos
	rts

saved_cursor_x:
	.byte 0
saved_cursor_y:
	.byte 0

cmd_done:
	jsr anyone_awake
	lda game_mode
	bpl :+
	jmp combat_cmd_done

:	lda ship_hull
	cmp #$50     ;full hull strength
	bcs update_player_health
	jsr j_rand
	and #$03     ;1/4 chance
	bne update_player_health
	lda ship_hull
	sed
	clc
	adc #$01     ;repair 1 hull
	cld
	sta ship_hull
update_player_health:
	lda party_size
	sta curr_player
@next:
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Sleep
	bne @check_poison
	jsr j_rand
	and #$07     ;1/8 chance
	bne @player_done
	lda #status_Good
	sta (ptr1),y ;wake up
	jmp @player_done

@check_poison:
	cmp #status_Poison
	bne @player_done
	lda #$02
	jsr dec_player_hp
	jsr invert_player_name
	lda #sound_damage
	jsr j_playsfx
	jsr invert_player_name
@player_done:
	dec curr_player
	bne @next
	lda party_size
	jsr eat_food
	bcs :+
	jsr starving
:	jsr recover_mp
	lda movement_mode
	bmi @update_dungeon
	jsr check_water_hazards
	jsr spawn_monsters
	jsr mobs_act
	jsr check_water_hazards
@update_dungeon:
	lda game_mode
	cmp #mode_dungeon
	bne @update_light
	jsr j_print_direction
	jsr dng_check_attacked
	lda tile_under_player
	and #dng_tile_type_mask
	cmp #dng_tile_room
	bne @update_light
	jmp do_dungeon_room

@update_light:
	lda light_duration
	beq :+
	dec light_duration
:	jmp end_turn

tile_effect:
	lda game_mode
	cmp #mode_world
	bne @no_trolls
	lda tile_under_player
	cmp #tile_bridge_narrow
	bne @no_trolls
	jsr j_rand
	and #chance_8
	bne @no_trolls
	jsr j_primm  ;b'\nBRIDGE TROLLS!\n\x00'
	.byte $8d
	.byte "BRIDGE TROLLS!", $8d
	.byte 0
	lda #tile_troll
	sta foe_type_encountered
	lda player_xpos
	sta pre_combat_x
	lda player_ypos
	sta pre_combat_y
	lda #tile_bridge_narrow
	sta pre_combat_tile
	jmp init_combat

@no_trolls:
	lda movement_mode
	bpl :+
	rts          ;airborne

:	lda game_mode
	bmi @in_combat
	cmp #mode_dungeon
	beq @in_dungeon
	lda tile_under_player
	jmp @check_field

@in_combat:
	ldx curr_player
	lda combat_player_tile-1,x
	beq @end_effect
	lda combat_player_xpos-1,x
	sta dest_x
	lda combat_player_ypos-1,x
	sta dest_y
	jsr j_gettile_tempmap
	cmp #tile_swamp
	beq @poison1
	cmp #tile_field_poison
	beq @poison1
	cmp #tile_field_fire
	beq @burn
	cmp #tile_field_sleep
	beq @sleep1
	cmp #tile_lava
	bne @end_effect
@burn:
	jsr burn_player
	jmp @end_effect

@poison1:
	jsr is_awake
	lda (ptr1),y
	cmp #status_Good
	bne @end_effect
	lda #status_Poison
	sta (ptr1),y
	jsr hilight_damaged_plr
	jsr j_update_status
	jmp @end_effect

@sleep1:
	jsr is_awake
	bmi @end_effect
	lda #status_Sleep
	sta (ptr1),y
	ldx curr_player
	lda #tile_human_prone
	sta combat_player_tile-1,x
	jsr hilight_damaged_plr
	jsr j_update_status
@end_effect:
	jmp @field_done

@in_dungeon:
	lda tile_under_player
	and #dng_tile_type_mask
	cmp #dng_tile_field
	bne @check_trap
	lda tile_under_player
	and #$03
	beq @poison_all
	cmp #$02
	beq @damage_all
	cmp #$03
	bne @field_done
	jmp @sleep_all

@check_trap:
	cmp #dng_tile_trap
	bne @field_done
	lda tile_under_player
	and #$0f
	beq @winds
	cmp #$08
	bcc @falling_rocks
	bcs @pit
@winds:
	jsr j_primm  ;b'\nWINDS!\n\x00'
	.byte $8d
	.byte "WINDS!", $8d
	.byte 0
	lda #$00
	sta light_duration
	jmp @field_done

@falling_rocks:
	jsr j_primm  ;b'\nFALLING ROCKS!\n\x00'
	.byte $8d
	.byte "FALLING ROCKS!", $8d
	.byte 0
	jmp @damage_all

@pit:
	jsr j_primm  ;b'\nPIT!\n\x00'
	.byte $8d
	.byte "PIT!", $8d
	.byte 0
	jmp @damage_all

@check_field:
	cmp #tile_swamp
	beq @poison_all
	cmp #tile_field_poison
	beq @poison_all
	cmp #tile_field_fire
	beq @damage_all
	cmp #tile_field_sleep
	beq @sleep_all
	cmp #tile_lava
	bne @field_done
@damage_all:
	jsr damage_party
@field_done:
	jmp @done

@poison_all:
	lda party_size
	sta curr_player
@next_p:
	jsr is_awake
	lda (ptr1),y
	cmp #status_Good
	bne @done
	jsr j_rand
	and #chance_8
	bne @skip_p
	lda #status_Poison
	ldy #player_status
	sta (ptr1),y
	jsr hilight_damaged_plr
	jsr j_update_status
@skip_p:
	dec curr_player
	bne @next_p
	jmp @done

@sleep_all:
	lda party_size
	sta curr_player
@next_s:
	jsr is_awake
	bmi @skip_s
	jsr j_rand
	and #chance_4
	bne @skip_s
	lda #status_Sleep
	ldy #player_status
	sta (ptr1),y
	jsr hilight_damaged_plr
	jsr j_update_status
@skip_s:
	dec curr_player
	bne @next_s
	jmp @done

@done:
	rts

starving:
	jsr j_primm  ;b'\nSTARVING!!!\n\x00'
	.byte $8d
	.byte "STARVING!!!", $8d
	.byte 0
	lda party_size
	sta curr_player
@next:
	jsr is_alive
	bmi :+
	lda #$02
	jsr dec_player_hp
:	dec curr_player
	bne @next
	jsr invert_all_players
	lda #sound_damage
	jsr j_playsfx
	jsr invert_all_players
	rts

recover_mp:
	lda party_size
	sta curr_player
@next:
	jsr is_alive
	bmi @skip
	ldy #player_class_index
	lda (ptr1),y
	sta zp_index
	ldy #player_intelligence
	lda (ptr1),y
	jsr decode_bcd_value
	asl
	ldx zp_index ;mage
	beq @mp_4_of_4
	dex          ;bard
	beq @mp_2_of_4
	dex          ;fighter
	beq @mp_0
	dex          ;druid
	beq @mp_3_of_4
	dex          ;tinker
	beq @mp_1_of_4
	dex          ;paladin
	beq @mp_2_of_4
	dex          ;ranger
	beq @mp_2_of_4
@mp_0:
	lda #$00     ;shepherd
	jmp @mp_4_of_4

@mp_1_of_4:
	lsr
	lsr
	jmp @mp_4_of_4

@mp_2_of_4:
	lsr
	jmp @mp_4_of_4

@mp_3_of_4:
	lsr
	sta zpd8
	lsr
	adc zpd8
@mp_4_of_4:
	jsr encode_bcd_value
	sta zp_mp_max
	ldy #player_magic_points
	lda (ptr1),y
	cmp zp_mp_max
	bcs @skip
	sed
	clc
	adc #$01
	cld
	sta (ptr1),y
@skip:
	dec curr_player
	bpl @next
	rts

eat_food:
	sta zpd8
	sed
	sec
	lda food_frac
	sbc zpd8
	sta food_frac
	bcs @done
	lda food_lo
	sbc #$00
	sta food_lo
	bcs @done
	lda food_hi
	sbc #$00
	sta food_hi
	bcs @done
	lda #$00
	sta food_frac
	sta food_lo
	sta food_hi
	clc
@done:
	cld
	rts

spawn_monsters:
	lda game_mode
	cmp #mode_world
	bne :+
	jmp spawn_world

:	cmp #mode_dungeon
	bne :+
	jmp spawn_dungeon

:	rts

spawn_world:
	jsr j_rand
	and #chance_16
	beq :+
	jmp @done

:	lda map_x    ;set temp2 to world-space coord of loaded region's origin
	asl
	asl
	asl
	asl
	sta temp2_x
	lda map_y
	asl
	asl
	asl
	asl
	sta temp2_y
	sec
	lda tile_xpos
	sbc #xy_center_screen
	sta delta_x
	sec
	lda tile_ypos
	sbc #xy_center_screen
	sta delta_y
	ldx #object_wandering_max
@try_spawn:
	lda object_tile_type,x
	bne @no_spawn ;slot already occupied
	jsr j_rand
	and #xy_max_tile_cache
	sta dest_x
	sec
	sbc delta_x
	cmp #xy_last_screen
	bcc @no_spawn ;don't spawn in view, always off-screen
	jsr j_rand
	and #xy_max_tile_cache
	sta dest_y
	sec
	sbc delta_y
	cmp #xy_last_screen
	bcc @no_spawn
	jsr j_gettile_britannia
	cmp #tile_water_shallow
	bcc @water   ;allowed in deep or coast water
	cmp #tile_grass
	bcc @no_spawn ;not in shallow water or swamp
	cmp #tile_mountain
	bcs @no_spawn ;not in anything mountain or higher
@land:
	clc          ;Convert from cache coordinate (tile_x,y) to absolute coordinate (player_x,y)
	lda dest_x
	adc temp2_x
	sta object_xpos,x
	clc
	lda dest_y
	adc temp2_y
	sta object_ypos,x

; Set difficulty based on how long you've been playing
	lda move_counter
	bne @foes_hard ;moves >= 1,000,000
	lda move_counter + 1
	cmp #$01
	bcc @foes_easy ;moves < 10,000
	beq @foes_medium ;moves < 20,000
	cmp #$03
	bcs @foes_hard ;moves >= 30,000
@foes_medium:
	lda #$07     ;mask, orc - wisp
	jmp @choose_monster

@foes_easy:
	lda #$03     ;mask, orc - snake
	jmp @choose_monster

@foes_hard:
	lda #$0f     ;mask, orc - balron
@choose_monster:
	sta zpd8
	jsr j_rand
	and zpd8
	sta zpd8
	jsr j_rand
	and zpd8     ;rand AND rand => each bit has 1/4 chance of being set
	asl
	asl
	adc #tile_monster_land
	sta object_tile_type,x
	sta object_tile_sprite,x
@no_spawn:
	jmp @next_spawn_slot

@water:
	jsr j_rand
	and #chance_8
	bne @next_spawn_slot
	clc
	lda dest_x
	adc temp2_x
	sta object_xpos,x
	clc
	lda dest_y
	adc temp2_y
	sta object_ypos,x
	jsr j_rand
	and #$07     ;random water monster
	asl
	adc #tile_monster_water
	cmp #tile_pirate_east
	bne :+
	lda #tile_pirate_west
:	sta object_tile_type,x
	sta object_tile_sprite,x
@next_spawn_slot:
	dex
	bmi @done
	jmp @try_spawn

@done:
	rts

spawn_dungeon:
	lda dungeon_level
	asl
	asl
	adc #$01
	tax
@try_spawn:
	lda object_tile_type,x
	bne @next_spawn_slot
	stx zp_index
	jsr j_rand
	and #xy_max_dungeon
	sta dest_x
	cmp player_xpos
	beq @next_spawn_slot
	jsr j_rand
	and #xy_max_dungeon
	sta dest_y
	cmp player_ypos
	beq @next_spawn_slot
	jsr j_gettile_dungeon
	bne @next_spawn_slot ;space occupied
	jsr j_rand
	and #$03     ;4 possibilities, starting from index = dungeon level
	clc
	adc dungeon_level
	asl
	asl
	adc #tile_monster_dungeon
	cmp #tile_monster_mimic
	beq @next_spawn_slot
	ldx zp_index
	sta object_tile_type,x
	lda dest_x
	sta object_xpos,x
	sta object_xpos_prev,x
	lda dest_y
	sta object_ypos,x
	sta object_ypos_prev,x
	lda dungeon_level
	sta object_dng_level,x
	lda object_tile_type,x
	jsr tile_to_monster_num
	ora (ptr1),y
	sta (ptr1),y
@next_spawn_slot:
	dex
	bmi @done
	txa
	lsr
	lsr
	cmp dungeon_level
	bcs @try_spawn
@done:
	rts

mobs_act:
	lda game_mode
	cmp #mode_world
	bne :+
	jmp mobs_act_world

:	cmp #mode_towne
	bne :+
	jmp mobs_act_towne

:	cmp #mode_dungeon
	bne :+
	jmp mobs_act_dungeon

:	rts

mobs_act_world:
	lda map_x
	asl
	asl
	asl
	asl
	sta temp2_x
	lda map_y
	asl
	asl
	asl
	asl
	sta temp2_y
	ldx #object_mobs_max
@next:
	lda object_tile_type,x
	beq @skip
	sec
	lda object_xpos,x
	sbc temp2_x
	cmp #$20
	bcs @out_of_range
	sec
	lda object_ypos,x
	sbc temp2_y
	cmp #$20
	bcs @out_of_range
	stx zp_index
	jsr mob_world_take_turn
	ldx zp_index
	jmp @skip

@out_of_range:
	lda #$00
	sta object_tile_type,x
	sta object_tile_sprite,x
@skip:
	dex
	bpl @next
	rts

mob_world_take_turn:
	lda object_tile_type,x
	cmp #tile_whirlpool
	beq check_range
	cmp #tile_twister
	beq check_range
	jsr manhattan_dist_foe
	cmp #$02
	bcs check_range
player_attacked:
	jsr j_update_view
	jsr j_primm  ;b'\nATTACKED BY\n\x00'
	.byte $8d
	.byte "ATTACKED BY", $8d
	.byte 0
	jsr print_attacker_name
	ldx zp_index
	lda object_xpos,x
	sta temp_x
	lda object_ypos,x
	sta temp_y
	pla    ; not returning from "jsr mob_world_take_turn" in "mobs_act"
	pla
	jmp do_attack

check_range:
	cmp #range_missile_travel + 1
	bcs @try_ship_move
	lda object_tile_type,x
	cmp #tile_pirate
	beq @check_cannon
	jmp @not_pirate

@check_cannon:
	lda object_tile_sprite,x
	cmp #tile_pirate_west
	beq @facing_e_w
	cmp #tile_pirate_north
	beq @facing_n_s
	cmp #tile_pirate_east
	beq @facing_e_w
@facing_n_s:
	lda delta_y
	bne @try_ship_move
	jmp fire_cannon_pirate

@facing_e_w:
	lda delta_x
	bne @try_ship_move
	jmp fire_cannon_pirate

@try_ship_move:
	lda object_tile_type,x
	cmp #tile_pirate
	beq @facing_west
	jmp @not_pirate

@facing_west:
	lda object_tile_sprite,x
	cmp #tile_pirate_west
	bne @facing_north
	lda delta_x
	bmi @try_sail_e_w
	bpl @turn_or_sail
@facing_north:
	cmp #tile_pirate_north
	bne @facing_east
	lda delta_y
	bmi @try_sail_n_s
	bpl @turn_or_sail
@facing_east:
	cmp #tile_pirate_east
	bne @facing_south
	lda delta_x
	beq @turn_or_sail
	bpl @try_sail_e_w
	bmi @turn_or_sail
@facing_south:
	lda delta_y
	beq @turn_or_sail
	bpl @try_sail_n_s
	bmi @turn_or_sail
@turn_or_sail:
	jsr manhattan_dist_foe
	cmp #$06
	bcs @turn_ship
	jsr j_rand
	and #$03     ;chance_4
	beq @turn_ship
	lda object_tile_sprite,x
	cmp #tile_pirate_west
	bne @try_sail_north
	lda #$ff
	sta delta_x
	jmp @try_sail_e_w

@try_sail_north:
	cmp #tile_pirate_north
	bne @try_sail_east
	lda #$ff
	sta delta_y
	jmp @try_sail_n_s

@try_sail_east:
	cmp #tile_pirate_east
	bne @try_sail_south
	lda #$01
	sta delta_x
	jmp @try_sail_e_w

@try_sail_south:
	lda #$01
	sta delta_y
	jmp @try_sail_n_s

@try_sail_e_w:
	clc
	lda object_xpos,x
	adc delta_x
	sta temp_x
	lda object_ypos,x
	sta temp_y
	jsr j_gettile_bounds
	jsr legal_move_world_twn
	bne @turn_ship_random
	lda object_tile_sprite,x
	and #$03
	jsr is_wind_favorable
	bne @no_move
	jmp @do_move

@try_sail_n_s:
	clc
	lda object_xpos,x
	sta temp_x
	lda object_ypos,x
	adc delta_y
	sta temp_y
	jsr j_gettile_bounds
	jsr legal_move_world_twn
	bne @turn_ship_random
	lda object_tile_sprite,x
	and #$03
	jsr is_wind_favorable
	bne @no_move
	jmp @do_move

@no_move:
	rts

@turn_ship:
	lda temp_x
	cmp temp_y
	bcs @turn_east_or_west
	lda temp_y
	bpl @turn_south
	lda #tile_pirate_north
	sta object_tile_sprite,x
	rts

@turn_south:
	lda #tile_pirate_south
	sta object_tile_sprite,x
	rts

@turn_east_or_west:
	lda temp_x
	bpl @turn_east
	lda #tile_pirate_west
	sta object_tile_sprite,x
	rts

@turn_east:
	lda #tile_pirate_east
	sta object_tile_sprite,x
	rts

@turn_ship_random:
	jsr j_rand
	jsr math_sign
	clc
	adc object_tile_sprite,x
	and #$03
	ora #tile_pirate
	sta object_tile_sprite,x
	rts

@not_pirate:
	lda object_tile_type,x
	cmp #tile_serpent
	beq @range_attack
	cmp #tile_lava_lizard
	beq @range_attack
	cmp #tile_hydra
	bcc @try_move
@range_attack:
	jsr manhattan_dist_foe
	lda temp_x
	jsr math_abs
	cmp #range_missile_attack
	bcs @try_move
	lda temp_y
	jsr math_abs
	cmp #range_missile_attack
	bcs @try_move
	jsr j_rand
	bmi @try_move
	jsr fire_red_missile
	ldx zp_index
@try_move:
	lda #$02
	sta zp_attempts
	lda object_tile_type,x
	cmp #tile_whirlpool
	beq @try_random
	cmp #tile_twister
	beq @try_random
	jsr is_evil
	bmi @x_or_y
	jsr j_rand
	and #chance_4
	bne @try_random
@x_or_y:
	jsr j_rand
	bmi @try_y
	lda delta_x
	beq @try_y
	clc
	lda object_xpos,x
	adc delta_x
	sta temp_x
	lda object_ypos,x
	sta temp_y
	jsr j_gettile_bounds
	jsr legal_move_world_twn
	beq @do_move
@try_y:
	lda delta_y
	beq @try_x
	lda object_xpos,x
	sta temp_x
	clc
	lda object_ypos,x
	adc delta_y
	sta temp_y
	jsr j_gettile_bounds
	jsr legal_move_world_twn
	beq @do_move
@try_x:
	lda delta_x
	beq @try_random
	clc
	lda object_xpos,x
	adc delta_x
	sta temp_x
	lda object_ypos,x
	sta temp_y
	jsr j_gettile_bounds
	jsr legal_move_world_twn
	beq @do_move
@try_random:
	jsr j_rand
	jsr math_sign
	sta delta_x
	jsr j_rand
	jsr math_sign
	sta delta_y
	dec zp_attempts
	bne @x_or_y
	rts

@do_move:
	lda object_xpos,x
	sta object_xpos_prev,x
	lda object_ypos,x
	sta object_ypos_prev,x
	lda temp_x
	sta object_xpos,x
	lda temp_y
	sta object_ypos,x
	rts

mobs_act_towne:
	cmp #$10     ;mode non-combat
	bcc :+
	rts

:	ldx #object_max
@next:
	lda #$02
	sta zp_attempts
	lda object_tile_type,x
	beq @no_move
	lda object_dng_level,x
	beq @no_move
	bmi @toward_player
	jsr j_rand
	bmi @no_move
@try_random:
	jsr j_rand
	jsr math_sign
	sta delta_x
	jsr j_rand
	jsr math_sign
	sta delta_y
	jmp @x_or_y

@toward_player:
	jsr manhattan_dist_towne
	cmp #$02
	bcs @x_or_y
	lda object_dng_level,x
	cmp #$ff
	bne @x_or_y
	stx zp_index
	jsr player_attacked
@no_move:
	jmp @skip

@x_or_y:
	jsr j_rand
	bmi @try_y
	lda delta_x
	beq @try_y
	clc
	lda object_xpos,x
	adc delta_x
	sta temp_x
	lda object_ypos,x
	sta temp_y
	jsr j_gettile_towne
	jsr legal_move_world_twn
	beq @do_move
@try_y:
	lda delta_y
	beq @try_x
	clc
	lda object_ypos,x
	adc delta_y
	sta temp_y
	lda object_xpos,x
	sta temp_x
	jsr j_gettile_towne
	jsr legal_move_world_twn
	beq @do_move
@try_x:
	clc
	lda object_xpos,x
	adc delta_x
	sta temp_x
	lda object_ypos,x
	sta temp_y
	jsr j_gettile_towne
	jsr legal_move_world_twn
	beq @do_move
	lda object_dng_level,x
	cmp #ai_toward_only
	beq @skip
	dec zp_attempts
	bmi @skip
	jmp @try_random

@do_move:
	lda temp_x
	cmp #xy_last_towne
	bcs @skip
	lda temp_y
	cmp #xy_last_towne
	bcs @skip
	lda object_xpos,x
	sta object_xpos_prev,x
	lda object_ypos,x
	sta object_ypos_prev,x
	lda temp_x
	sta object_xpos,x
	lda temp_y
	sta object_ypos,x
@skip:
	dex
	bmi @done
	jmp @next

@done:
	rts

mobs_act_dungeon:
	ldx #object_max
@next:
	lda object_tile_type,x
	beq @skip
	lda object_dng_level,x
	cmp dungeon_level
	bne @skip
	lda object_tile_type,x
	cmp #tile_mimic
	beq @skip
	cmp #tile_reaper
	beq @skip
	lda #$07
	sta zp_attempts
	jmp @check_at_player

@skip:
	jmp @no_move

@check_at_player:
	lda object_xpos,x
	cmp player_xpos
	bne @try_random
	lda object_ypos,x
	cmp player_ypos
	beq @skip
@try_random:
	jsr j_rand
	jsr math_sign
	sta delta_x
	jsr j_rand
	jsr math_sign
	sta delta_y
	jsr j_rand
	bmi @try_y
	lda delta_x
	beq @try_y
	clc
	adc object_xpos,x
	and #xy_max_dungeon
	sta dest_x
	lda object_ypos,x
	sta dest_y
	jsr j_gettile_dungeon
	jsr legal_move_dungeon
	beq @do_move
@try_y:
	lda delta_y
	beq @try_x
	clc
	adc object_ypos,x
	and #xy_max_dungeon
	sta dest_y
	lda object_xpos,x
	sta dest_x
	jsr j_gettile_dungeon
	jsr legal_move_dungeon
	beq @do_move
@try_x:
	clc
	lda object_xpos,x
	adc delta_x
	and #xy_max_dungeon
	sta dest_x
	lda object_ypos,x
	sta dest_y
	jsr j_gettile_dungeon
	jsr legal_move_dungeon
	beq @do_move
	dec zp_attempts
	bpl @try_random
	jmp @no_move

@do_move:
	lda object_tile_type,x
	jsr tile_to_monster_num
	ora (ptr1),y
	sta (ptr1),y
	lda object_xpos,x
	sta object_xpos_prev,x
	lda object_ypos,x
	sta object_ypos_prev,x
	lda dest_x
	sta object_xpos,x
	lda dest_y
	sta object_ypos,x
	lda object_xpos_prev,x
	sta dest_x
	lda object_ypos_prev,x
	sta dest_y
	jsr j_gettile_dungeon
	and #dng_tile_type_mask
	sta (ptr1),y
@no_move:
	dex
	bmi @done
	jmp @next

@done:
	jsr j_dng_check_update
	rts

tile_to_monster_num:
	sec
	sbc #tile_monster_dungeon
	lsr
	lsr
	clc
	adc #$01
	ldy #$00
	rts

; unused
wind_dir_delta_x:
	.byte $ff,$00,$01,$00
wind_dir_delta_y:
	.byte $00,$ff,$00,$01

is_wind_favorable:
	cmp direction
	beq @upwind
	clc
	adc #$02     ;opposite
	and #$03     ;modulo
	cmp direction
	bne @yes
@downwind:
	lda turn_counter
	and #$03
	bne @yes
	beq @no
@upwind:
	lda turn_counter
	and #$03
	beq @yes
@no:
	lda #$ff
	rts

@yes:
	lda #$00
	rts

check_water_hazards:
	lda game_mode
	cmp #mode_world
	beq :+
	rts

:	ldx #object_wandering_max
@next_obj:
	lda object_tile_type,x
	cmp #tile_whirlpool
	beq @whirlpool
	cmp #tile_twister
	beq @twister
@next_hazard:
	dex
	bpl @next_obj
	rts

@whirlpool:
	lda #sound_drown
	sta zp_sound
	lda object_xpos,x
	cmp player_xpos
	bne @check_objects
	lda object_ypos,x
	cmp player_ypos
	bne @check_objects
	jsr enter_whirlpool

@check_objects:
	ldy #object_max
@next_victim:
	stx zp_index
	cpy zp_index
	beq @skip    ;doesn't affect itself
	lda object_tile_type,y
	beq @skip    ;nothing there
	lda object_xpos,x
	cmp object_xpos,y
	bne @skip
	lda object_ypos,x
	cmp object_ypos,y
	bne @skip
	lda #$00     ;destroy what's there
	sta object_tile_type,y
	sta object_tile_sprite,y
	stx zp_index
	sty zpd9
	jsr j_update_view
	lda zp_sound
	jsr j_playsfx
	ldx zp_index
	ldy zpd9
@skip:
	dey
	bpl @next_victim
	jmp @next_hazard

@twister:
	lda #sound_twister
	sta zp_sound
	lda object_xpos,x
	cmp player_xpos
	bne @check_objects
	lda object_ypos,x
	cmp player_ypos
	bne @check_objects
	jsr enter_twister
	jmp @check_objects

enter_whirlpool:
	stx zpd8
	jsr j_update_view
	lda #tile_whirlpool
	sta player_transport
	jsr j_update_view
	lda #$7f     ;center of Lock Lake
	sta player_xpos
	lda #$4e
	sta player_ypos
	lda #sound_drown
	jsr j_playsfx
	jsr damage_party
	ldx zpd8
	lda #tile_ship_west
	sta player_transport
	jsr j_player_teleport
	rts

enter_twister:
	stx zpd8
	lda player_transport
	pha
	lda #tile_twister
	sta player_transport
	jsr j_update_view
	lda #sound_twister
	jsr j_playsfx
	jsr damage_party
	jsr damage_party
	jsr damage_party
	jsr damage_party
	pla
	sta player_transport
	ldx zpd8
	rts

fire_cannon_pirate:
	lda #tile_attack_small
	sta attack_sprite
	jsr fire_world_missile
	bpl :+
	rts

:	jsr j_gettile_opposite
	pha
	lda #tile_attack_red
	sta (ptr1),y
	jsr j_animate_view
	jsr damage_party
	jsr j_gettile_opposite
	pla
	sta (ptr1),y
	rts

fire_red_missile:
	lda #tile_attack_red
	sta attack_sprite
	jsr fire_world_missile
	bpl :+
	rts

:	jsr j_gettile_opposite
	pha
	lda #tile_attack_red
	sta (ptr1),y
	jsr j_animate_view
	jsr damage_party
	jsr j_gettile_opposite
	pla
	sta (ptr1),y
	rts

fire_world_missile:
	lda #range_missile_travel
	sta zp_missile_travel
	lda object_xpos,x
	sta temp_x
	lda object_ypos,x
	sta temp_y
	jsr j_update_view
	lda #sound_cannon
	jsr j_playsfx
@next:
	clc
	lda temp_x
	adc delta_x
	sta temp_x
	clc
	lda temp_y
	adc delta_y
	sta temp_y
	cmp player_ypos
	bne @check_other_object
	lda temp_x
	cmp player_xpos
	bne @check_other_object
	lda #$00     ;hit player
	rts

@check_other_object:
	jsr any_obj_at_temp_xy
	bpl @missile_impact
	jsr j_gettile_opposite
	pha
	lda attack_sprite
	sta (ptr1),y
	jsr j_animate_view
	jsr j_gettile_opposite
	pla
	sta (ptr1),y
	dec zp_missile_travel
	bne @next
	lda #$ff     ;miss
	rts

@missile_impact:
	stx zpd9
	lda #sound_damage
	jsr j_playsfx
	ldx zpd9
	cpx #$08     ;characters roll chance, objects instant obliterate
	bcs @destroyed
	jsr j_rand
	and #chance_4
	bne @no_player_damage
@destroyed:
	lda #$00
	sta object_tile_type,x
	sta object_tile_sprite,x
@no_player_damage:
	lda #$ff
	rts

manhattan_dist_foe:
	sec
	lda player_xpos
	sbc object_xpos,x
	sta temp_x
	jsr math_sign
	sta delta_x
	sec
	lda player_ypos
	sbc object_ypos,x
	sta temp_y
	jsr math_sign
	sta delta_y
	lda temp_x
	jsr math_abs
	sta zpd9
	lda temp_y
	jsr math_abs
	clc
	adc zpd9
	sta zpd9
	rts

; strange, same routine pasted twice!
manhattan_dist_towne:
	sec
	lda player_xpos
	sbc object_xpos,x
	sta temp_x
	jsr math_sign
	sta delta_x
	sec
	lda player_ypos
	sbc object_ypos,x
	sta temp_y
	jsr math_sign
	sta delta_y
	lda temp_x
	jsr math_abs
	sta zpd9
	lda temp_y
	jsr math_abs
	clc
	adc zpd9
	sta zpd9
	rts

end_turn:
	inc turn_counter
	sed
	clc
	lda move_counter + 3
	adc #$01
	sta move_counter + 3
	lda move_counter + 2
	adc #$00
	sta move_counter + 2
	lda move_counter + 1
	adc #$00
	sta move_counter + 1
	lda move_counter
	adc #$00
	sta move_counter
	cld
	lda aura_duration
	beq @check_light
	dec aura_duration
	bne @check_light
	lda #aura_none
	sta magic_aura
@check_light:
	lda game_mode
	cmp #mode_dungeon
	bne @update
	lda light_duration
	bne @update
	jsr j_primm  ;b"IT'S DARK!\n\x00"
	.byte "IT'S DARK!", $8d
	.byte 0
@update:
	jsr j_update_status
	jsr close_open_door
	jmp next_turn

inn_combat:
	ldx #$00
	lda #$00
:	sta combat_foe_cur_x,x
	inx
	bne :-
	lda #$01     ;inn combat is only with main player
	sta curr_player
	lda game_mode
	sta game_mode_pre_combat
	lda #mode_combat_inn
	sta game_mode
	lda #tile_rogue
	sta foe_type_encountered
	sta foe_type_combat
	lda #arena_inn
	jmp load_arena

dng_check_attacked:
	lda tile_under_player
	and #$0f
	beq @nope
	lda tile_under_player
	and #dng_tile_type_mask
	cmp #dng_tile_trap
	beq @nope
	cmp #dng_tile_fountain
	beq @nope
	cmp #dng_tile_field
	beq @nope
	cmp #dng_tile_room
	beq @nope
	cmp #dng_tile_wall
	beq @nope
	lda tile_under_player
	and #$0f
	asl
	asl
	adc #tile_monster_dungeon - 4
	sta foe_type_encountered
	sta foe_type_combat
	lda player_xpos
	sta dest_x
	lda player_ypos
	sta dest_y
	jsr j_gettile_dungeon
	and #dng_tile_type_mask
	sta (ptr1),y
	ldx #object_max
@next:
	lda object_dng_level,x
	cmp dungeon_level
	bne @skip
	lda object_xpos,x
	cmp player_xpos
	bne @skip
	lda object_ypos,x
	cmp player_ypos
	bne @skip
	lda #$00
	sta object_dng_level,x
	sta object_tile_type,x
	sta object_xpos,x
	sta object_ypos,x
	jmp @attacked

@skip:
	dex
	bpl @next
@attacked:
	ldx #$00
	txa
:	sta combat_foe_cur_x,x
	dex
	bne :-
	pla          ;not returning from "jsr dng_check_attacked" in "cmd_done"
	pla
	lda tile_under_player
	lsr
	lsr
	lsr
	lsr
	tax
	lda dungeon_arena,x
	jmp load_arena

@nope:
	rts

dungeon_arena:
	.byte arena_dng_hall ; hall
	.byte arena_dng_ladder_up
	.byte arena_dng_ladder_down
	.byte arena_dng_ladder_both
	.byte arena_dng_chest
	.byte arena_dng_hall ; hole up
	.byte arena_dng_hall ; hole down
	.byte arena_dng_hall ; orb
	.byte arena_dng_hall ; trap
	.byte arena_dng_hall ; fountain
	.byte arena_dng_hall ; field
	.byte arena_dng_hall ; altar
	.byte arena_dng_door
	.byte arena_dng_hall ; room
	.byte arena_dng_secret_door
	.byte arena_dng_hall ; wall

do_dungeon_room:
	lda #music_off
	jsr music_ctl
	sec
	lda current_location
	sbc #loc_dng_first
	sta lt_track ;up to 16 rooms per dungeon
	cmp #$07     ;except abyss, 16 rooms per 2 levels
	bne :+
	lda dungeon_level
	lsr
	clc
	adc lt_track
	sta lt_track
:	lda tile_under_player
	and #$0f
	sta lt_sector
	lda #lt_rwflag_read
	sta lt_rwflag
	lda #$02
	sta lt_addr_hi
	jsr j_loadsector
	lda game_mode
	sta game_mode_pre_combat
	lda #mode_combat_dng_room
	sta game_mode
	lda #$00
	sta flee_x
	sta flee_y
	ldx #$ff
	lda lt_sector
	cmp #$0f     ;room index "altar"
	bne @init_arena
	lda lt_track
	cmp #$07     ;except in abyss
	bcs @init_arena
	jsr j_primm  ;b'\nTHE ALTER ROOM\nOF \x00'
	.byte $8d
	.byte "THE ALTER ROOM", $8d
	.byte "OF ", 0
	lda player_xpos
	cmp #$03
	beq @love
	bcs @courage
	jsr j_primm  ;b'TRUTH\n\x00'
	.byte "TRUTH", $8d
	.byte 0
	ldx #principle_truth
	beq @init_arena
@love:
	jsr j_primm  ;b'LOVE\n\x00'
	.byte "LOVE", $8d
	.byte 0
	ldx #principle_love
	bne @init_arena
@courage:
	jsr j_primm  ;b'COURAGE\n\x00'
	.byte "COURAGE", $8d
	.byte 0
	ldx #principle_courage
@init_arena:
	stx altar_room_principle
	lda #$00
	tax
:	sta combat_foe_cur_x,x
	inx
	bne :-
	ldx #foes_max
:	lda room_start_triggers,x
	sta dng_trigger_new_tile,x
	dex
	bpl :-
	lda dng_direction
	eor #$02     ;reverse facing to choose entrance
	asl
	asl
	asl
	asl
	sta zpd8     ;00 south  10 west  20 north  30 east
	lda party_size
	sta curr_player
@next_player:
	jsr get_player_sprite
	bmi @inactive
	pha
	clc
	lda curr_player
	adc zpd8
	tay
	dey
	pla
	ldx curr_player
	dex
	sta combat_player_tile,x
	lda map_start_foe_x,y
	sta combat_player_xpos,x
	lda room_start_player_y,y
	sta combat_player_ypos,x
	jsr is_alive
	beq :+
@inactive:
	ldx curr_player
	lda #$00     ;dead
	sta combat_player_tile-1,x
:	dec curr_player
	bne @next_player
	ldx #foes_max
@next_foe:
	lda room_start_foe_type,x
	beq @skip_foe
	sta combat_foe_tile,x
	sta combat_foe_drawn_tile,x
	lda room_start_foe_x,x
	sta combat_foe_cur_x,x
	lda room_start_foe_y,x
	sta combat_foe_cur_y,x
	lda combat_foe_tile,x
	jsr foe_index_from_tile
	tay
	lda foe_power_table,y ;HP = P/2 | rand(P)
	sta zpd8
	jsr rand_modulo
	lsr zpd8
	ora zpd8
	sta combat_foe_hp,x
	lda combat_foe_tile,x
	cmp #tile_mimic
	bne @skip_foe
	lda #tile_chest
	sta combat_foe_drawn_tile,x
@skip_foe:
	dex
	bpl @next_foe
	jmp begin_combat

init_combat:
	jsr j_primm  ;b'\n\n**** COMBAT ****\n\n\x00'
	.byte $8d
	.byte $8d
	.byte "**** COMBAT ****", $8d
	.byte $8d
	.byte 0
	lda foe_type_encountered
	sta foe_type_combat
	ldx #$00
	txa
@clear:
	sta combat_foe_cur_x,x
	dex
	bne @clear
	lda player_transport
	cmp #tile_ship_last
	bcc @ship
	lda tile_under_player
	cmp #tile_ship_last
	bcs @not_ship
	cmp #tile_ship_first
	bcc @not_ship
@ship:
	lda foe_type_encountered
	cmp #tile_pirate
	bne @pirate
	lda #tile_rogue
	sta foe_type_combat
	lda #arena_ship_v_ship
	jmp load_arena

@pirate:
	lda pre_combat_tile
	cmp #tile_water_last
	bcc :+
	lda #arena_ship_s_shore
	jmp load_arena

:	lda #arena_ship_at_sea
	jmp load_arena

@not_ship:
	lda foe_type_encountered
	cmp #tile_pirate
	bne @land_arena
	lda #tile_rogue
	sta foe_type_combat
	lda #arena_ship_n_shore
	jmp load_arena

@land_arena:
	lda pre_combat_tile
	cmp #tile_water_last
	bcs :+
	lda #arena_shore
	jmp load_arena

:	lda tile_under_player
	cmp #tile_swamp
	bne :+
	lda #arena_swamp
	jmp load_arena

:	cmp #tile_brush
	bne :+
	lda #arena_brush
	jmp load_arena

:	cmp #tile_forest
	bne :+
	lda #arena_forest
	jmp load_arena

:	cmp #tile_hills
	bne :+
	lda #arena_mountains
	jmp load_arena

:	cmp #tile_floor_stone
	bne :+
	lda #arena_floor_stone
	jmp load_arena

:	cmp #tile_floor_brick
	bne :+
	lda #arena_floor_brick
	jmp load_arena

:	cmp #tile_bridge_narrow
	beq @bridge
	cmp #tile_bridge_top
	beq @bridge
	cmp #tile_bridge_bottom
	beq @bridge
	cmp #tile_bridge_middle
	bne @default
@bridge:
	lda #arena_bridge
	jmp load_arena

@default:
	lda #arena_grass
load_arena:
	sta @file_char_arena
	lda #music_off
	jsr music_ctl
	jsr j_primm_cout ;b'\x84BLOAD CON@,A$240\n\x00'
	.byte $84,"BLOAD CON"
@file_char_arena:
	.byte "@,A$240", $8d
	.byte 0
initialize_arena:
	lda game_mode
	cmp #mode_combat_inn
	beq :+
	sta game_mode_pre_combat
	lda #mode_combat_wandering
	sta game_mode
:	lda game_mode_pre_combat
	cmp #mode_towne
	bne set_foe_count
	lda game_mode
	cmp #mode_combat_inn
	beq set_foe_count
@towne_arena:
	lda foe_type_encountered
	cmp #tile_guard
	beq @maximize_foes
	lda #$00     ;max index 0 = just one foe
	jmp clamp_foe_count

@maximize_foes:
	lda party_size
	asl
	sec
	sbc #$01     ;Party * 2 (index 0 through P*2-1)
	jmp clamp_foe_count

set_foe_count:
	lda foe_type_combat
	bmi @lookup_max_foes ;Dead code? Never encounter characters outside a towne.
	jsr j_rand
	and #$07     ;2-8 character foes
	bne clamp_foe_count ;idx 0 overruns table[24], previous foe_count as new max (BUG?)
@lookup_max_foes:
	jsr foe_index_from_tile
	tax
	lda foe_max_count,x
	jsr rand_modulo
	clc
	adc foe_max_count,x
	lsr
clamp_foe_count:
	sta zp_cur_foe_index
	sta foe_count
	lsr          ;Must be less than 2x party size
	cmp party_size
	bcc @choose_foe_slot
	lda party_size
	asl
	jsr rand_modulo
	jmp clamp_foe_count

@choose_foe_slot:
	jsr j_rand
	and #foes_max
	tax
	lda combat_foe_cur_x,x
	bne @choose_foe_slot
	lda map_start_foe_x,x
	sta combat_foe_cur_x,x
	lda map_start_foe_y,x
	sta combat_foe_cur_y,x
	lda foe_type_combat
	bpl @commit_foe
	lda zp_cur_foe_index
	beq @no_companion
	jsr j_rand
	and #$1f     ;1/32 chance
	beq @companion_double
	and #$07     ;3/32 chance
	beq @companion
@no_companion:
	lda foe_type_combat
	jmp @commit_foe

@companion:
	lda foe_type_combat
	jsr foe_index_from_tile
	tay
	lda foe_companion_table,y
	jmp @commit_foe

@companion_double:
	lda foe_type_combat
	jsr foe_index_from_tile
	tay
	lda foe_companion_table,y
	jsr foe_index_from_tile
	tay
	lda foe_companion_table,y
@commit_foe:
	sta combat_foe_tile,x
	sta combat_foe_drawn_tile,x
	jsr foe_index_from_tile
	tay
	lda foe_power_table,y ;HP = P/2 | rand(P)
	sta zpd8
	jsr rand_modulo
	lsr zpd8
	ora zpd8
	sta combat_foe_hp,x
	dec zp_cur_foe_index
	bpl @choose_foe_slot

@place_players:
	lda game_mode
	cmp #mode_combat_inn
	beq @next_player
	lda party_size
	sta curr_player
@next_player:
	jsr get_player_sprite
	bmi @remove_player
	ldx curr_player
	dex
	sta combat_player_tile,x
	lda map_start_player_x,x
	sta combat_player_xpos,x
	lda map_start_player_y,x
	sta combat_player_ypos,x
	jsr is_alive
	beq :+
@remove_player:
	ldx curr_player
	lda #$00
	sta combat_player_tile-1,x
:	dec curr_player
	bne @next_player
begin_combat:
	lda #music_combat
	jsr music_ctl
	bit hw_strobe
	lda #$00
	sta key_buf_len
start_players_turn:
	lda #$01
	sta curr_player
	sta curr_player_turn
combat_take_turn:
	jsr is_alive
	beq @check_fled_or_slept
	ldx curr_player
	lda combat_player_tile-1,x
	beq @end_turn
	lda #$00
	sta combat_player_tile-1,x
@end_turn:
	jmp combat_end_turn

@check_fled_or_slept:
	ldx curr_player
	lda combat_player_tile-1,x
	beq @end_turn
	cmp #tile_human_prone
	beq @end_turn
	jsr j_update_view
	jsr invert_player_name
	jsr print_newline
	jsr j_printname
	jsr j_primm  ;b'\nW:\x00'
	.byte $8d
	.byte "W:", 0
	jsr j_get_stats_ptr
	ldy #player_weapon
	lda (ptr1),y
	sta current_weapon
	clc
	adc #string_weapon_first
	jsr j_printstring
	jsr j_primm  ;b'\n>\x00'
	.byte $8d,$1e,$00
	jsr j_waitkey
	bne :+
	jmp done_pass

:	cmp #char_space
	bne :+
	jmp done_pass

:	cmp #char_enter
	bne :+
	jmp combat_move_up

:	cmp #char_up_arrow
	bne :+
	jmp combat_move_up

:	cmp #char_down_arrow
	bne :+
	jmp combat_move_down

:	cmp #char_slash
	bne :+
	jmp combat_move_down

:	cmp #char_left_arrow
	bne :+
	jmp combat_move_left

:	cmp #char_right_arrow
	bne :+
	jmp combat_move_right

:	cmp #char_alpha_first
	bcc @invalid_key
	cmp #char_alpha_last
	bcs @invalid_key
	sec
	sbc #char_alpha_first
	asl
	tay
	lda combat_cmd_table,y
	sta ptr1
	lda combat_cmd_table + 1,y
	sta ptr1 + 1
	jmp (ptr1)

@invalid_key:
	jmp done_what

combat_cmd_done:
	lda curr_player_turn
	sta curr_player
	jsr invert_player_name
	jsr tile_effect
	jsr j_update_status
	lda magic_aura
	cmp #aura_quickness
	bne combat_end_turn
	jsr j_rand
	bmi combat_end_turn
	jmp combat_take_turn ;1/2 chance

combat_end_turn:
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Sleep
	bne @end_wake_up
	jsr j_rand
	and #$07     ;1/8 chance
	bne @end_wake_up
	lda #status_Good
	sta (ptr1),y
	jsr get_player_sprite
	ldx curr_player
	sta combat_player_tile-1,x
@end_wake_up:
	jsr check_scene_over
	inc curr_player
	inc curr_player_turn
	lda curr_player
	cmp party_size
	bcc @next_turn
	beq @next_turn
	jmp @players_done

@next_turn:
	jmp combat_take_turn

@players_done:
	lda #$00
	sta curr_player_turn
	jsr j_update_view
	lda #foes_max
	sta zp_cur_foe_index
foe_take_turn:
	ldx zp_cur_foe_index
	lda combat_foe_tile,x
	bne :+
	jmp next_foe

:	lda combat_foe_slept,x
	beq @check_zorn
	jsr j_rand
	and #$07     ;1/8 chance
	beq @wake_up
	jmp check_tile_effect

@wake_up:
	lda #$00
	sta combat_foe_slept,x
@check_zorn:
	lda combat_foe_tile,x
	cmp #tile_zorn
	bne @check_wisp
	lda #aura_negate
	sta magic_aura
	lda #$02
	sta aura_duration
	jmp calc_nearest_player

@check_wisp:
	cmp #tile_wisp
	bne calc_nearest_player
	jsr j_rand
	and #chance_8
	bne calc_nearest_player
@wisp_teleport:
	lda #xy_last_screen
	jsr rand_modulo
	sta dest_x
	lda #xy_last_screen
	jsr rand_modulo
	sta dest_y
	jsr j_gettile_tempmap
	jsr legal_move_combat
	bmi @wisp_teleport
	ldx zp_cur_foe_index
	lda dest_x
	sta combat_foe_cur_x,x
	lda dest_y
	sta combat_foe_cur_y,x
	jmp check_tile_effect

calc_nearest_player:
	lda combat_foe_cur_x,x
	sta temp_x
	lda combat_foe_cur_y,x
	sta temp_y
	lda party_size
	sta curr_player
	lda #$ff
	sta zp_nearest_dist
	lda #$00
	sta target_player
@next:
	jsr is_alive
	bne @skip
	ldx curr_player
	dex
	lda combat_player_tile,x
	beq @skip
	sec
	lda combat_player_xpos,x
	sbc temp_x
	jsr math_abs
	sta zp_dist
	sec
	lda combat_player_ypos,x
	sbc temp_y
	jsr math_abs
	clc
	adc zp_dist
	cmp zp_nearest_dist
	bcs @skip
	sta zp_nearest_dist
	lda curr_player
	sta target_player
@skip:
	dec curr_player
	bne @next
	lda target_player
	bne calc_direction
	jmp check_tile_effect

calc_direction:
	sta curr_player
	tax
	dex
	sec
	lda combat_player_xpos,x
	sbc temp_x
	jsr math_sign
	sta delta_x
	sec
	lda combat_player_ypos,x
	sbc temp_y
	jsr math_sign
	sta delta_y
	ldx zp_cur_foe_index
	lda combat_foe_tile,x
	cmp #tile_mimic
	bne calc_attack_type
	lda #tile_chest
	sta combat_foe_drawn_tile,x
	lda zp_nearest_dist
	cmp #$05
	bcs no_range_attack
	lda #tile_mimic
	sta combat_foe_drawn_tile,x
calc_attack_type:
	jsr j_rand
	and #chance_4
	bne no_range_attack
	lda combat_foe_tile,x
	jsr get_rangeattack_type
	beq no_range_attack
	cmp #tile_attack_blue
	bne @attack_allowed
	ldy magic_aura
	cpy #aura_negate
	beq no_range_attack
@attack_allowed:
	jsr do_foe_range_attack
	jsr j_update_view
	jmp check_tile_effect

no_range_attack:
	jsr j_rand
	and #chance_4
	bne @check_flee
	ldx zp_cur_foe_index
	lda combat_foe_tile,x
	cmp #tile_balron
	beq @cast_sleep
	cmp #tile_reaper
	bne @check_flee
@cast_sleep:
	lda magic_aura
	cmp #aura_negate
	beq @check_flee
	jsr j_update_view
	jsr j_invertview
	ldx #$80
	lda #sound_spell_effect
	jsr j_playsfx
	jsr j_invertview
	lda #player_last
	sta curr_player
@next:
	ldx curr_player
	lda combat_player_tile-1,x
	beq @skip
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Good
	bne @skip
	jsr j_rand
	bmi @skip
	lda #status_Sleep
	sta (ptr1),y
	lda #tile_human_prone
	ldx curr_player
	sta combat_player_tile-1,x
@skip:
	dec curr_player
	bne @next
	jmp check_tile_effect

@check_flee:
	ldx zp_cur_foe_index
	lda combat_foe_hp,x
	cmp #hp_fleeing + 1
	bcs @check_is_adjacent
	lda delta_x
	jsr math_negate
	sta delta_x
	lda delta_y
	jsr math_negate
	sta delta_y
	jmp @try_foe_move

@check_is_adjacent:
	lda zp_nearest_dist
	cmp #$02
	bcs @try_foe_move
	ldx zp_cur_foe_index
	lda combat_foe_tile,x
	cmp #tile_gremlin
	bne @check_rogue
	jsr steal_food
	jmp :+

@check_rogue:
	cmp #tile_rogue
	bne :+
	jsr try_steal_gold
:	jmp do_foe_melee_attack

@try_foe_move:
	ldx zp_cur_foe_index
	lda combat_foe_tile,x
	cmp #tile_mimic
	bne :+
	jmp check_tile_effect

:	cmp #tile_reaper
	bne :+
	jmp check_tile_effect

:	lda #$02
	sta zp_attempts
@x_or_y:
	jsr j_rand
	bmi @try_y
	lda delta_x
	beq @try_y
	clc
	adc temp_x
	sta dest_x
	lda temp_y
	sta dest_y
	jsr do_jinx
	jsr j_gettile_currmap
	jsr legal_move_combat
	beq do_foe_move
@try_y:
	lda delta_y
	beq @try_x
	clc
	adc temp_y
	sta dest_y
	lda temp_x
	sta dest_x
	jsr do_jinx
	jsr j_gettile_currmap
	jsr legal_move_combat
	beq do_foe_move
@try_x:
	lda delta_x
	beq @try_random
	clc
	adc temp_x
	sta dest_x
	lda temp_y
	sta dest_y
	jsr do_jinx
	jsr j_gettile_currmap
	jsr legal_move_combat
	beq do_foe_move
@try_random:
	jsr j_rand
	jsr math_sign
	sta delta_x
	jsr j_rand
	jsr math_sign
	sta delta_y
	dec zp_attempts
	bne @x_or_y
	lda zp_nearest_dist
	cmp #$02
	bcs check_tile_effect
	jmp do_foe_melee_attack

do_foe_move:
	ldx zp_cur_foe_index
	lda combat_foe_cur_x,x
	sta combat_foe_prev_x,x
	lda combat_foe_cur_y,x
	sta combat_foe_prev_y,x
	lda dest_x
	cmp #xy_last_screen
	bcs fleeing
	sta combat_foe_cur_x,x
	lda dest_y
	cmp #xy_last_screen
	bcs fleeing
	sta combat_foe_cur_y,x
	jsr j_update_view_combat
check_tile_effect:
	lda #$00
	sta curr_player
	ldx zp_cur_foe_index
	lda combat_foe_cur_x,x
	sta dest_x
	lda combat_foe_cur_y,x
	sta dest_y
	jsr j_gettile_tempmap
	ldx zp_cur_foe_index
	cmp #tile_field_poison
	beq @effect_poison
	cmp #tile_field_fire
	beq @effect_fire
	cmp #tile_field_sleep
	beq @effect_sleep
	cmp #tile_lava
	beq @effect_fire
	bne next_foe
@effect_sleep:
	lda combat_foe_tile,x
	jsr is_undead
	beq next_foe
	jsr j_rand
	cmp combat_foe_hp,x
	bcc next_foe
	lda #$01
	sta combat_foe_slept,x
	lda #sound_damage
	jsr j_playsfx
	jmp next_foe

@effect_fire:
	lda combat_foe_tile,x
	cmp #tile_lava_lizard
	beq next_foe
	cmp #tile_daemon
	bcs next_foe
@effect_poison:
	jsr j_rand
	and #$7f     ;0..127
	sta damage
	lda #sound_damage
	jsr j_playsfx
	jsr inflict_damage
next_foe:
	dec zp_cur_foe_index
	bmi :+
	jmp foe_take_turn

:	jmp end_foes_turn

fleeing:
	jsr print_newline
	ldx zp_cur_foe_index
	lda combat_foe_tile,x
	jsr print_target_name
	jsr j_primm  ;b'FLEES!\n\x00'
	.byte "FLEES!", $8d
	.byte 0
	ldx zp_cur_foe_index
	lda combat_foe_tile,x
	jsr is_evil
	bmi @fled
	ldy #virtue_compassion
	lda #$01
	jsr inc_virtue
	ldy #virtue_justice
	lda #$01
	jsr inc_virtue
@fled:
	lda #$00
	ldx zp_cur_foe_index
	sta combat_foe_tile,x
	sta combat_foe_hp,x
	lda #sound_alert
	jsr j_playsfx
	jmp check_tile_effect

do_jinx:
	lda magic_aura
	cmp #aura_jinx
	beq :+
	rts

:	lda zp_cur_foe_index
	pha
	jsr check_hit_foe
	bmi @miss
	lda #tile_attack_red
	sta attack_sprite
	lda dest_x
	sta target_x
	lda dest_y
	sta target_y
	jsr j_update_view_combat
	lda #sound_damage
	jsr j_playsfx
	lda #$00
	sta attack_sprite
	sta curr_player
	jsr j_rand
	and #$3f
	sta damage
	jsr inflict_damage
	jsr j_update_view_combat
	pla
	sta zp_cur_foe_index
	pla
	pla
	jmp check_tile_effect

@miss:
	pla
	sta zp_cur_foe_index
	rts

end_foes_turn:
	jsr recover_mp
	jsr j_update_view_combat
	inc turn_counter
	jsr check_scene_over
	lda aura_duration
	beq :+
	dec aura_duration
	bne :+
	lda #aura_none
	sta magic_aura
:	jsr j_update_status
	jmp start_players_turn

steal_food:
	lda #$25
	jsr eat_food
	jsr j_update_status
	lda #sound_alert
	jsr j_playsfx
	rts

try_steal_gold:
	jsr j_rand
	and #chance_4
	bne @done
	jsr j_rand
	and #$3f
	jsr encode_bcd_value
	sta zpd8
	sed
	sec
	lda gold_lo
	sbc zpd8
	sta gold_lo
	lda gold_hi
	sbc #$00
	sta gold_hi
	bcs :+
	lda #$00
	sta gold_lo
	sta gold_hi
:	cld
	lda #sound_alert
	jsr j_playsfx
	jsr j_update_status
@done:
	rts

check_scene_over:
	lda game_mode
	cmp #mode_combat_dng_room
	beq check_players_gone
	ldx #foes_max
:	lda combat_foe_tile,x
	bne check_players_gone
	dex
	bpl :-
	pla
	pla
	jmp foes_vanquished

check_players_gone:
	ldx #player_max
:	lda combat_player_tile,x
	bne @still_here
	dex
	bpl :-
	pla
	pla
	jmp player_flee

@still_here:
	rts

player_flee:
	lda game_mode
	cmp #mode_combat_dng_room
	beq combat_exit_room
combat_players_fled:
	lda foe_type_encountered
	jsr is_evil
	bpl @not_evil
	jsr j_primm  ;b'\nBATTLE IS LOST!\n\x00'
	.byte $8d
	.byte "BATTLE IS LOST!", $8d
	.byte 0
	ldy #virtue_valor
	lda #$02
	jsr dec_virtue
	jmp combat_over

@not_evil:
	ldy #virtue_compassion
	lda #$02
	jsr inc_virtue
	ldy #virtue_justice
	lda #$02
	jsr inc_virtue
	jmp combat_over

combat_exit_room:
	jsr j_primm  ;b'\nLEAVE ROOM!\n\x00'
	.byte $8d
	.byte "LEAVE ROOM!", $8d
	.byte 0
	lda flee_x
	beq @north
	bpl @east
@west:
	lda #dng_dir_west
	jmp do_exit_room

@east:
	lda #dng_dir_east
	jmp do_exit_room

@north:
	lda flee_y
	bpl @south
	lda #dng_dir_north
	jmp do_exit_room

@south:
	lda #dng_dir_south
do_exit_room:
	sta dng_direction
	lda game_mode_pre_combat
	sta game_mode
	lda altar_room_principle ;T,L,C == 0,1,2
	bmi @dungeon
	asl
	asl
	clc
	adc dng_direction
	tay
	lda altar_room_exits,y
	sta current_location
	tay
	dey
	lda location_map_x,y
	sta britannia_x
	lda location_map_y,y
	sta britannia_y
	lda #music_off
	jsr music_ctl
	jsr load_map_dungeon
	jsr j_primm  ;b'INTO DUNGEON\n\x00'
	.byte "INTO DUNGEON", $8d
	.byte 0
	jsr print_location_name
@dungeon:
	jsr print_newline
	lda #music_explore
	jsr music_ctl
	lda dng_direction
	tax
	lda #$00
	sta key_buf_len
	jmp dng_move

altar_room_exits:
	.byte $11    ;North of Truth   is Deceit
	.byte $16    ;East  of Truth   is Shame
	.byte $17    ;South of Truth   is Hythloth
	.byte $14    ;West  of Truth   is Wrong
	.byte $12    ;North of Love    is Despise
	.byte $14    ;East  of Love    is Wrong
	.byte $17    ;South of Love    is Hythloth
	.byte $15    ;West  of Love    is Covetous
	.byte $13    ;North of Courage is Destard
	.byte $15    ;East  of Courage is Covetous
	.byte $17    ;South of Courage is Hythloth
	.byte $16    ;West  of Courage is Shame

foes_vanquished:
	jsr j_primm  ;b'\nVICTORY!\n\x00'
	.byte $8d
	.byte "VICTORY!", $8d
	.byte 0
	lda foe_type_encountered
	jsr is_evil
	bpl :+
	ldy #virtue_valor
	jsr j_rand
	and #$01     ;0-1
	jsr inc_virtue
:	lda game_mode
	cmp #mode_combat_inn
	bne :+
	jmp combat_over

:	lda game_mode_pre_combat
	cmp #mode_dungeon
	beq @dungeon

; town or world
	lda foe_type_encountered
	cmp #tile_monster
	bcs @monster
	cmp #tile_pirate
	beq @pirate
	cmp #$20     ;20 <= n < 30  or  50 <= n < 60  then monster
	bcc @done
	cmp #$60
	bcs @done
	cmp #$30
	bcc @monster
	cmp #$50
	bcs @monster
	bcc @done
@monster:
	cmp #tile_bat
	beq @done
	cmp #tile_slime
	beq @done
	cmp #tile_gazer
	beq @done
	cmp #tile_insects
	beq @done
	cmp #tile_wisp
	beq @done
	lda pre_combat_tile
	jsr j_blocked_tile
	bmi @done
	bcc @done
@drop_loot:
	jsr get_free_object_slot
	lda pre_combat_x
	sta object_xpos,x
	lda pre_combat_y
	sta object_ypos,x
	lda #tile_chest
	sta object_tile_type,x
	sta object_tile_sprite,x
	jmp combat_over

@pirate:
	jsr get_free_object_slot
	lda pre_combat_x
	sta object_xpos,x
	lda pre_combat_y
	sta object_ypos,x
	lda #tile_ship_west
	sta object_tile_type,x
	sta object_tile_sprite,x
@done:
	jmp combat_over

@dungeon:
	lda foe_type_encountered
	cmp #tile_bat
	beq @done
	cmp #tile_insects
	beq @done
	cmp #tile_slime
	beq @done
	lda player_xpos
	sta dest_x
	lda player_ypos
	sta dest_y
	jsr j_gettile_dungeon
	bne @done
	lda #dng_tile_chest
	sta (ptr1),y
	jmp combat_over

get_free_object_slot:
	ldx #object_max
@next:
	lda object_tile_type,x
	beq @done
	dex
	bmi @replace_random
	lda game_mode_pre_combat
	cmp #mode_world
	bne @next
	cpx #object_inanimate_first
	bcs @next
@replace_random:
	lda #object_last - object_inanimate_first
	jsr rand_modulo
	clc
	adc #object_inanimate_first
	tax
@done:
	rts

combat_over:
	lda game_mode
	cmp #mode_combat_inn
	beq @restore_towne
	lda game_mode_pre_combat
	sta game_mode
	cmp #mode_dungeon
	bne :+
	jsr j_dng_neighbor_tiles
:	lda #music_explore
	jsr music_ctl
	lda #$00
	sta key_buf_len
	jmp cmd_done

@restore_towne:
	lda game_mode_pre_combat
	sta game_mode
	lda #music_explore
	jsr music_ctl
	rts

do_foe_melee_attack:
	ldx curr_player
	lda combat_player_xpos-1,x
	sta target_x
	lda combat_player_ypos-1,x
	sta target_y
	lda #tile_attack_small
	sta attack_sprite
	jsr j_update_view_combat
	lda #sound_foe_attack
	jsr j_playsfx
	lda #$00
	sta attack_sprite
	lda magic_aura
	cmp #aura_protection
	bne @check_armour
	jsr j_rand
	bmi @no_damage ;1/2 chance
@check_armour:
	jsr j_get_stats_ptr
	lda #player_armour
	lda (ptr1),y
	tax
	lda armour_table,x
	sta zpda
	jsr j_rand
	cmp zpda
	bcs @yes_damage
@no_damage:
	jsr j_update_view_combat
	jmp check_tile_effect

@yes_damage:
	jsr player_injured
	jmp check_tile_effect

player_injured:
	lda #tile_attack_red
	sta attack_sprite
	jsr invert_player_name
	jsr j_update_view_combat
	lda #sound_firewalk
	jsr j_playsfx
	lda #$00
	sta attack_sprite
	jsr j_update_view_combat
	ldx zp_cur_foe_index
	lda combat_foe_tile,x
	jsr foe_index_from_tile
	tax
	lda foe_power_table,x ;Attack = rand(P/4)
	lsr
	lsr
	jsr rand_modulo
	jsr encode_bcd_value
	jsr dec_player_hp
	bne @done
	jsr j_printname
	jsr j_primm  ;b'\nIS KILLED!\n\x00'
	.byte $8d
	.byte "IS KILLED!", $8d
	.byte 0
	ldy #virtue_sacrifice
	lda #$01
	jsr inc_virtue
@done:
	jsr invert_player_name
	jsr j_update_status
	rts

combat_cmd_table:
	.word combat_cmd_attack
	.word done_what ;b
	.word combat_cmd_cast
	.word done_what ;d
	.word done_what ;e
	.word done_what ;f
	.word combat_cmd_get
	.word done_what ;h
	.word done_what ;i
	.word done_what ;j
	.word done_what ;k
	.word done_what ;l
	.word done_what ;m
	.word done_what ;n
	.word done_what ;o
	.word done_what ;p
	.word done_what ;q
	.word combat_cmd_ready
	.word done_what ;s
	.word done_what ;t
	.word cmd_use_item
	.word cmd_volume
	.word done_what ;w
	.word done_what ;x
	.word done_what ;y
	.word combat_cmd_ztats

combat_move_up:
	jsr j_primm  ;b'North\n\x00'
	.byte "North", $8d
	.byte 0
	ldx curr_player
	dex
	lda combat_player_xpos,x
	sta dest_x
	ldy combat_player_ypos,x
	dey
	sty dest_y
	jmp try_move

combat_move_down:
	jsr j_primm  ;b'South\n\x00'
	.byte "South", $8d
	.byte 0
	ldx curr_player
	dex
	lda combat_player_xpos,x
	sta dest_x
	ldy combat_player_ypos,x
	iny
	sty dest_y
	jmp try_move

combat_move_right:
	jsr j_primm  ;b'East\n\x00'
	.byte "East", $8d
	.byte 0
	ldx curr_player
	dex
	lda combat_player_ypos,x
	sta dest_y
	ldy combat_player_xpos,x
	iny
	sty dest_x
	jmp try_move

combat_move_left:
	jsr j_primm  ;b'West\n\x00'
	.byte "West", $8d
	.byte 0
	ldx curr_player
	dex
	lda combat_player_ypos,x
	sta dest_y
	ldy combat_player_xpos,x
	dey
	sty dest_x
	jmp try_move

try_move:
	lda #sound_footstep
	jsr j_playsfx
	lda dest_x
	cmp #xy_last_screen
	bcc :+
	jmp try_flee

:	lda dest_y
	cmp #xy_last_screen
	bcc :+
	jmp try_flee

:	jsr j_gettile_currmap
	jsr j_blocked_tile
	bpl :+
	jmp done_blocked

:	jsr j_gettile_currmap
	jsr check_slow_terrain
	beq :+
	jsr done_slow_progress
	jmp combat_cmd_done

:	ldx curr_player
	dex
	lda dest_x
	sta combat_player_xpos,x
	lda dest_y
	sta combat_player_ypos,x
	lda #sound_footstep
	jsr j_playsfx
	lda game_mode
	cmp #mode_combat_dng_room
	bne @cmd_done
@floor_triggers:
	ldx #$00
	stx zp_index
@next:
	lda dng_trigger_new_tile,x
	beq @skip
	lda dng_trigger_pos,x
	beq @skip
	lsr
	lsr
	lsr
	lsr
	cmp dest_x
	bne @skip
	lda dng_trigger_pos,x
	and #$0f
	cmp dest_y
	bne @skip
	lda dng_trigger_new_pos1,x
	beq :+
	jsr xy_to_offset
	lda dng_trigger_new_tile,x
	sta tempmap,y
:	lda dng_trigger_new_pos2,x
	beq @skip
	jsr xy_to_offset
	lda dng_trigger_new_tile,x
	sta tempmap,y
@skip:
	lda zp_index
	clc
	adc #$04
	sta zp_index
	tax
	cmp #$10     ;up to 4 triggers
	bcc @next
@cmd_done:
	jmp combat_cmd_done

xy_to_offset:
	pha
	lsr
	lsr
	lsr
	lsr
	sta zpd9
	pla
	and #$0f
	tay
	lda mult_by_11,y
	clc
	adc zpd9
	tay
	rts

mult_by_11:
	.byte $00,$0b,$16,$21,$2c,$37,$42,$4d
	.byte $58,$63,$6e

try_flee:
	lda game_mode
	cmp #mode_combat_dng_room
	bne do_flee
	lda flee_x
	bne @already_fleeing_x
	lda flee_y
	bne @already_fleeing_y
	lda dest_x
	cmp #xy_last_screen
	bcc :+
	sta flee_x
	jmp do_flee

:	lda dest_y
	sta flee_y
	jmp do_flee

@already_fleeing_x:
	cmp dest_x
	beq do_flee
	bne @cannot_split_party
@already_fleeing_y:
	cmp dest_y
	beq do_flee
	bne @cannot_split_party
@cannot_split_party:
	pla    ; BUG: not entered via JSR,
	pla    ; BUG: nothing on stack to pop
	jsr j_primm  ;b'ALL MUST USE\nTHE SAME EXIT!\n\x00'
	.byte "ALL MUST USE", $8d
	.byte "THE SAME EXIT!", $8d
	.byte 0
	lda #sound_blocked
	jsr j_playsfx
	jmp combat_cmd_done

do_flee:
	ldx curr_player
	dex
	lda #xy_fled
	sta combat_player_xpos,x
	sta combat_player_ypos,x
	lda #$00
	sta combat_player_tile,x
	lda #sound_alert
	jsr j_playsfx
	lda game_mode
	cmp #mode_combat_wandering
	bne @no_penalty
	lda foe_type_encountered
	jsr is_evil
	bpl @no_penalty
	jsr j_get_stats_ptr
	ldy #player_cur_hp_hi
	lda (ptr1),y
	ldy #player_max_hp_hi
	cmp (ptr1),y
	bne @no_penalty
	ldy #virtue_valor
	lda #$02
	jsr dec_virtue
	ldy #virtue_sacrifice
	lda #$02
	jsr dec_virtue
@no_penalty:
	jmp combat_cmd_done

flee_x:
	.byte 0
flee_y:
	.byte 0

combat_cmd_attack:
	lda #$00
	sta missile_traveled
	jsr j_primm  ;b'Attack-\x00'
	.byte "Attack-", 0
	jsr input_target_xy
	bne :+
	jmp done_pass

:	lda dest_x
	sta target_x
	lda dest_y
	sta target_y
	ldx current_weapon
	lda is_ranged_table,x
	bne ranged_attack
	cpx #weapon_halberd
	bne @skip_inc
	clc
	lda target_x
	adc delta_x
	sta target_x
	clc
	lda target_y
	adc delta_y
	sta target_y
@skip_inc:
	jsr next_arena_tile
	bpl melee_attack
	jmp missed

melee_attack:
	lda #tile_attack_small
	sta attack_sprite
	jsr j_update_view_combat
	lda #$00
	sta attack_sprite
	lda #sound_player_attack
	jsr j_playsfx
	jsr check_hit_foe
	bpl did_hit
	lda #$01
	sta missile_traveled
	lda current_weapon
	cmp #weapon_dagger
	beq ranged_attack
	jmp missed

did_hit:
	inc missile_traveled
	jmp target_hit

ranged_attack:
	lda #xy_last_screen
	sta aim_range
	lda current_weapon
	cmp #weapon_flaming_oil
	bne use_weapon
	jsr j_primm  ;b'RANGE-\x00'
	.byte "RANGE-", 0
	jsr input_char
	sec
	sbc #char_num_first
	cmp #$0a     ;< 10
	bcc @valid_digit
	jmp missed

@valid_digit:
	sta aim_range
use_weapon:
	lda current_weapon
	cmp #weapon_dagger
	beq @deduct_thrown
	cmp #weapon_flaming_oil
	bne check_target
@deduct_thrown:
	clc
	adc #party_stat_weapons
	tay
	lda party_stats,y
	beq last_one
	jsr dec_stat
	jmp check_target

last_one:
	lda #$00     ;dead code
	jsr j_get_stats_ptr
	ldy #player_weapon
	lda #weapon_none
	sta (ptr1),y
	jsr j_primm  ;b'LAST ONE!\n\x00'
	.byte "LAST ONE!", $8d
	.byte 0
check_target:
	jsr next_arena_tile
	bpl :+
	jmp missed

:	lda #tile_attack_small
	sta attack_sprite
	lda current_weapon
	cmp #weapon_magic_wand
	bne :+
	lda #tile_attack_blue
	sta attack_sprite
:	jsr j_update_view_combat
	lda #$00
	sta attack_sprite
	lda missile_traveled
	bne :+
	lda #sound_player_attack
	jsr j_playsfx
:	inc missile_traveled
	jsr check_hit_foe
	bpl target_hit
	dec aim_range
	bne check_target
	jmp missed

target_hit:
	lda current_location
	cmp #loc_dng_abyss
	bne @can_damage
	lda current_weapon
	cmp #weapon_magic_axe ; or better
	bcs @can_damage
	jmp missed

@can_damage:
	lda current_weapon
	cmp #weapon_flaming_oil
	bne @no_oil_fire
	jsr j_gettile_tempmap
	cmp #tile_water_last
	bcc @no_oil_fire
	lda #tile_field_fire
	sta tempmap,y
@no_oil_fire:
	lda #tile_attack_red
	sta attack_sprite
	lda current_weapon
	cmp #weapon_magic_wand
	bne :+
	lda #tile_attack_blue
	sta attack_sprite
:	jsr j_get_stats_ptr
	ldy #player_dexterity
	lda (ptr1),y
	jsr decode_bcd_value
	asl
	clc
	adc #$80     ;hit chance = (128 + DEX * 2) / 255
	bcs @calc_damage
	sta zpda
	jsr j_rand
	cmp zpda
	bcc @calc_damage
	jmp missed

@calc_damage:
	jsr j_get_stats_ptr
	ldy #player_strength
	lda (ptr1),y
	jsr decode_bcd_value
	ldx current_weapon
	clc
	adc weapon_damage_table,x
	bcc :+
	lda #$ff     ;damage = max(255, STR + weapon)
:	jsr rand_modulo
	sta damage
	jsr j_update_view_combat
	lda #sound_damage
	jsr j_playsfx
	lda #$00
	sta attack_sprite
	jsr inflict_damage
	jmp end_attack

inflict_damage:
	jsr print_newline
	ldx zp_cur_foe_index
	lda combat_foe_tile,x
	sta foe_type_combat
	jsr print_target_name
	ldx zp_cur_foe_index
	lda combat_foe_tile,x
	cmp #tile_lord_british
	bne :+
	jmp still_alive

:	lda combat_foe_hp,x
	sec
	sbc damage
	sta combat_foe_hp,x
	bcs still_alive
	lda #$00
	sta combat_foe_hp,x
	sta combat_foe_tile,x
	jsr j_primm  ;b'KILLED!\n\x00'
	.byte "KILLED!", $8d
	.byte 0
	lda curr_player
	beq @done
	lda foe_type_combat
	jsr foe_index_from_tile
	tay
	lda foe_power_table,y ;Exp = hi(P) + 1
	lsr
	lsr
	lsr
	lsr
	clc
	adc #$01
	jsr encode_bcd_value
	jsr inc_player_exp
	jsr j_primm  ;b'EXP.+\x00'
	.byte "EXP.+", 0
	lda zpd8
	cmp #$10
	bcs :+
	jsr j_printdigit
	jmp @done

:	jsr j_printbcd
@done:
	jsr print_newline
	rts

still_alive:
	ldx zp_cur_foe_index
	lda combat_foe_tile,x
	jsr foe_index_from_tile
	tax
	lda foe_power_table,x ;calc percentages
	lsr
	sta zp_percent_50
	sta zp_percent_25
	lsr zp_percent_25
	clc
	adc zp_percent_25
	sta zp_percent_75
	ldx zp_cur_foe_index
	lda combat_foe_hp,x
	cmp #hp_fleeing + 1
	bcs @percent_25
	jsr j_primm  ;b'FLEEING!\n\x00'
	.byte "FLEEING!", $8d
	.byte 0
	jmp @done

@percent_25:
	cmp zp_percent_25
	bcs @percent_50
	jsr j_primm  ;b'CRITICAL!\n\x00'
	.byte "CRITICAL!", $8d
	.byte 0
	jmp @done

@percent_50:
	cmp zp_percent_50
	bcs @percent_75
	jsr j_primm  ;b'HEAVILY\x00'
	.byte "HEAVILY", 0
	jmp @wounded

@percent_75:
	cmp zp_percent_75
	bcs @percent_hi
	jsr j_primm  ;b'LIGHTLY\x00'
	.byte "LIGHTLY", 0
	jmp @wounded

@percent_hi:
	jsr j_primm  ;b'BARELY\x00'
	.byte "BARELY", 0
@wounded:
	jsr j_primm  ;b' WOUNDED!\n\x00'
	.byte " WOUNDED!", $8d
	.byte 0
@done:
	rts

missed:
	lda missile_traveled
	bne :+
	lda #sound_player_attack
	jsr j_playsfx
:	lda #$00
	sta attack_sprite
	jsr j_primm  ;b'MISSED!\n\x00'
	.byte "MISSED!", $8d
	.byte 0
	lda current_weapon
	cmp #weapon_flaming_oil
	bne @end_attack
	lda target_x
	cmp #xy_last_screen
	bcs @end_attack
	sta dest_x
	lda target_y
	cmp #xy_last_screen
	bcs @end_attack
	sta dest_y
	jsr j_gettile_tempmap
	cmp #tile_water_last
	bcc @end_attack
	lda #tile_field_fire
	sta tempmap,y
@end_attack:
	jmp end_attack

end_attack:
	lda current_weapon
	cmp #weapon_magic_axe
	bne @cmd_done
	lda missile_traveled
	cmp #$02
	bcc @cmd_done
	dec missile_traveled
	lda delta_x
	jsr math_negate
	sta delta_x
	lda delta_y
	jsr math_negate
	sta delta_y
	lda #tile_attack_small
	sta attack_sprite
:	jsr next_arena_tile
	jsr j_update_view_combat
	dec missile_traveled
	bne :-
	lda #$00
	sta attack_sprite
@cmd_done:
	jmp combat_cmd_done

current_weapon:
	.byte 0
aim_range:
	.byte 0
missile_traveled:
	.byte 0

combat_cmd_cast:
	jsr j_primm  ;b'Cast, \x00'
	.byte "Cast, ", 0
	jmp choose_spell

combat_cmd_get:
	jsr j_primm  ;b'Get chest!\n\x00'
	.byte "Get chest!", $8d
	.byte 0
try_get_chest_combat:
	ldx curr_player
	dex
	lda combat_player_xpos,x
	sta dest_x
	lda combat_player_ypos,x
	sta dest_y
	jsr j_gettile_tempmap
	cmp #tile_chest
	beq :+
	jmp done_not_here

:	lda #tile_floor_stone
	sta tempmap,y
	lda game_mode_pre_combat
	cmp #mode_dungeon
	bne @skip
	lda player_xpos
	sta dest_x
	lda player_ypos
	sta dest_y
	jsr j_gettile_dungeon
	cmp #dng_tile_chest
	bne @skip
	lda #$00
	sta (ptr1),y
@skip:
	jmp do_get_chest

combat_cmd_ready:
	jsr j_primm  ;b'Ready weapon:\n\x00'
	.byte "Ready weapon:", $8d
	.byte 0
	jmp ask_weapon

combat_cmd_ztats:
	jsr j_primm  ;b'Ztats\n\x00'
	.byte "Ztats", $8d
	.byte 0
	jsr zstats_for_player ;BUG: stack overflow, never RTS
	jsr j_update_status
	jsr invert_player_name
	jmp combat_cmd_done

foe_power_table:
	.byte $ff,$ff,$40,$60,$80,$60,$ff,$ff
	.byte $30,$30,$40,$50,$30,$60,$30,$c0
	.byte $ff,$30,$f0,$80,$50,$30,$50,$30
	.byte $70,$40,$80,$40,$b0,$c0,$60,$f0
	.byte $70,$d0,$e0,$ff,$70,$30,$60,$40
	.byte $60,$80,$90,$30,$80,$30,$30,$30
	.byte $20,$20,$80,$ff
foe_companion_table:
	.byte $c8,$c8,$8a,$88,$86,$84,$8c,$8e
	.byte $c4,$e4,$90,$e4,$a0,$d0,$a8,$ac
	.byte $b0,$90,$bc,$9c,$a4,$e0,$c8,$90
	.byte $f0,$b8,$ec,$bc,$f0,$f0,$f4,$b8
	.byte $fc,$f8,$fc,$fc
foe_max_count:
	.byte $01,$01,$0c,$04,$04,$08,$01,$01
	.byte $0c,$0c,$06,$04,$0f,$06,$0f,$01
	.byte $01,$0f,$04,$08,$0a,$0c,$0a,$0c
	.byte $06,$08,$06,$0c,$06,$04,$08,$04
	.byte $06,$04,$04,$01
foe_count:
	.byte $00
weapon_damage_table:
	.byte $08,$10,$18,$20,$28,$30,$40,$28
	.byte $38,$40,$60,$60,$80,$50,$a0,$ff
armour_table:
	.byte $60,$80,$90,$a0,$b0,$c0,$d0,$f8
is_ranged_table:
	.byte $00,$00,$00,$ff,$00,$00,$00,$ff
	.byte $ff,$ff,$00,$ff,$00,$ff,$ff,$00

foe_index_from_tile:
	bpl @not_monster
	and #$7f
	lsr
	cmp #$08     ;1000NNNx
	bcc @done
	lsr          ;1NNNNNxx + 4
	clc
	adc #$04
@done:
	rts
@not_monster:
	and #$1f     ;000NNNNN + 24  (BUG: should be 000NNNNx)
	clc
	adc #$24
	rts

is_awake:
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Good
	beq in_party
	cmp #status_Poison
	beq in_party
	lda #$ff
	rts

is_alive:
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Good
	beq in_party
	cmp #status_Poison
	beq in_party
	cmp #status_Sleep
	beq in_party
is_not:
	lda #$ff
	rts

in_party:
	lda curr_player
	cmp party_size
	beq @is
	bcs is_not
@is:
	lda #$00
	rts

get_player_sprite:
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Good
	beq @normal
	cmp #status_Poison
	beq @normal
	cmp #status_Dead
	beq @dead
	lda #tile_human_prone
	rts

@normal:
	ldy #player_class_index
	lda (ptr1),y
	asl
	adc #tile_human_class
	rts          ;tile(humans + class * 2)

@dead:
	lda #$ff
	rts

rand_modulo:
	cmp #$00
	beq @done
	sta modulus
	jsr j_rand
@subtract:
	cmp modulus
	bcc @clear_flags
	sec
	sbc modulus
	jmp @subtract

@clear_flags:
	cmp #$00
@done:
	rts

modulus:
	.byte 0

legal_move_world_twn:
	sta zp_tile_type
	stx zp_save_xreg
	jsr check_slow_terrain
	bpl @collide_other_foe
	jmp @deny

@collide_other_foe:
	lda object_tile_type,x
	cmp #tile_whirlpool
	beq @avoid_repeat_move
	cmp #tile_twister
	beq @avoid_repeat_move
	ldy #object_max
@next:
	lda object_tile_type,y
	beq @skip
	lda object_xpos,y
	cmp temp_x
	bne @skip
	lda object_ypos,y
	cmp temp_y
	bne @skip
	lda object_tile_type,y
	cmp #tile_chest
	beq @skip
	jmp @deny

@skip:
	dey
	bpl @next

; collide player
	lda temp_x
	cmp player_xpos
	bne @check_pirate
	lda temp_y
	cmp player_ypos
	bne @check_pirate
	jmp @deny

@check_pirate:
	lda object_tile_type,x
	cmp #tile_pirate
	beq @collide_terrain
@avoid_repeat_move:
	lda temp_x
	cmp object_xpos_prev,x
	bne @collide_terrain
	lda temp_y
	cmp object_ypos_prev,x
	bne @collide_terrain
	jsr j_rand
	and #chance_4
	bne @deny
@collide_terrain:
	lda object_tile_type,x
	bpl @land
	cmp #tile_twister
	bcc @water
	beq @fly
	cmp #tile_bat
	beq @fly
	cmp #tile_ghost
	beq @phase
	cmp #tile_insects
	beq @fly
	cmp #tile_zorn
	beq @phase
	cmp #tile_daemon
	beq @fly
	cmp #tile_dragon
	beq @fly
	cmp #tile_balron
	beq @fly
	bne @land
@phase:
	lda zp_tile_type
	cmp #tile_water_last
	bcc @deny
	cmp #tile_field_lightning
	bne @allow
	beq @deny
@land:
	lda zp_tile_type
	jsr j_blocked_tile
	bpl @allow
	bmi @deny
@water:
	cmp #tile_pirate
	bne @water_creature
	lda zp_tile_type
	cmp #tile_water_shallow
	bcc @allow
	bcs @deny
@water_creature:
	lda zp_tile_type
	cmp #tile_water_last
	bcc @allow
	bcs @deny
@fly:
	lda zp_tile_type
	cmp #tile_water_last
	bcc @allow
	jsr j_blocked_tile
	bpl @allow
	bmi @deny
@allow:
	ldx zp_save_xreg
	lda #$00
	rts

@deny:
	ldx zp_save_xreg
	lda #$ff
	rts

legal_move_combat:
	sta zp_tile_type
	jsr check_slow_terrain
	bmi @deny
	lda dest_x
	cmp #xy_last_screen
	bcs @is_fleeing
	lda dest_y
	cmp #xy_last_screen
	bcc @avoid_repeat_move
@is_fleeing:
	ldx zp_cur_foe_index
	lda combat_foe_hp,x
	cmp #hp_fleeing + 1
	bcc @allow
@deny:
	jmp @return_false

@allow:
	jmp @return_true

@avoid_repeat_move:
	ldx zp_cur_foe_index
	lda combat_foe_prev_x,x
	cmp dest_x
	bne @collide_other_foe
	lda combat_foe_prev_y,x
	cmp dest_y
	bne @collide_other_foe
	jsr j_rand
	and #chance_4
	bne @deny
@collide_other_foe:
	ldx #foes_max
@next:
	lda combat_foe_tile,x
	beq @collide_player
	lda combat_foe_cur_x,x
	cmp dest_x
	bne @collide_player
	lda combat_foe_cur_y,x
	cmp dest_y
	beq @return_false
@collide_player:
	cpx #player_last
	bcs @skip
	lda combat_player_tile,x
	beq @skip
	lda combat_player_xpos,x
	cmp dest_x
	bne @skip
	lda combat_player_ypos,x
	cmp dest_y
	beq @return_false
@skip:
	dex
	bpl @next

; collide_terrain
	ldx zp_cur_foe_index
	lda combat_foe_tile,x
	bpl @land
	cmp #tile_twister
	bcc @water
	beq @fly
	cmp #tile_bat
	beq @fly
	cmp #tile_ghost
	beq @phase
	cmp #tile_insects
	beq @fly
	cmp #tile_zorn
	beq @phase
	cmp #tile_daemon
	beq @fly
	cmp #tile_dragon
	beq @fly
	cmp #tile_balron
	beq @fly
	bne @land
@phase:
	lda zp_tile_type
	cmp #tile_water_last
	bcc @return_false
	cmp #tile_field_lightning
	bne @return_true
	beq @return_false
@land:
	lda zp_tile_type
	jsr j_blocked_tile
	bpl @return_true
	bmi @return_false
@water:
	lda zp_tile_type
	cmp #tile_water_last
	bcc @return_true
	bcs @return_false
@fly:
	lda zp_tile_type
	cmp #tile_water_last
	bcc @return_true
	jsr j_blocked_tile
	jsr j_blocked_tile
	bpl @return_true
	bmi @return_false
@return_true:
	lda #$00
	rts

@return_false:
	lda #$ff
	rts

legal_move_dungeon:
	pha
	and #dng_tile_foe_mask
	bne @pop_deny
	pla
	and #dng_tile_type_mask
	cmp #dng_tile_trap
	beq @deny
	cmp #dng_tile_fountain
	beq @deny
	cmp #dng_tile_field
	beq @deny
	cmp #dng_tile_room
	beq @deny
	cmp #dng_tile_wall
	beq @deny
	jsr j_rand
	and #chance_8
	beq @allow
	lda dest_x
	cmp object_xpos_prev,x
	bne @allow
	lda dest_y
	cmp object_ypos_prev,x
	beq @deny
@allow:
	lda #$00
	rts

@pop_deny:
	pla
@deny:
	lda #$ff
	rts

dng_can_advance:
	sta zpd8
	and #dng_tile_type_mask
	cmp #dng_tile_door
	beq adv_retreat_yes
	cmp #dng_tile_secret_door
	beq adv_retreat_yes
	cmp #dng_tile_room
	beq adv_retreat_yes
	lda zpd8
dng_can_retreat:
	cmp #$a1
	beq adv_retreat_no
	cmp #dng_tile_door ; or higher
	bcs adv_retreat_no
	bcc adv_retreat_yes
adv_retreat_yes:
	lda #$00
	rts

adv_retreat_no:
	lda #$ff
	rts

close_open_door:
	lda game_mode
	cmp #mode_towne
	bne @done
	lda door_open_countdown
	bne @countdown
	rts

@countdown:
	dec door_open_countdown
	beq @close
	rts

@close:
	lda door_open_x
	sta temp_x
	lda door_open_y
	sta temp_y
	jsr j_gettile_towne
	lda #tile_door_unlocked
	sta (ptr2),y
@done:
	lda #$00
	sta door_open_countdown
	rts

door_open_x:
	.byte 0
door_open_y:
	.byte 0
door_open_countdown:
	.byte 0

get_rangeattack_type:
	cmp #tile_class_mage
	beq @attack_blue
	cmp #tile_lord_british
	beq @attack_blue
	cmp #tile_nixie
	beq @attack_small
	cmp #tile_squid
	beq @lightning
	cmp #tile_serpent
	beq @attack_red
	cmp #tile_seahorse
	beq @attack_blue
	cmp #tile_spider
	beq @poison
	cmp #tile_troll
	beq @attack_small
	cmp #tile_mimic
	beq @poison
	cmp #tile_gazer
	beq @sleep
	cmp #tile_python
	beq @poison
	cmp #tile_ettin
	beq @boulder
	cmp #tile_cyclops
	beq @boulder
	cmp #tile_mage
	beq @attack_blue
	cmp #tile_liche
	beq @attack_blue
	cmp #tile_lava_lizard
	beq @lava
	cmp #tile_daemon
	beq @attack_blue
	cmp #tile_hydra
	bcs @attack_red
	cmp #tile_dragon
	beq @attack_red
	cmp #tile_reaper
	beq @rand_field
	cmp #tile_balron
	beq @rand_field
	lda #$00
	rts

@poison:
	lda #tile_field_poison
	rts

@lightning:
	lda #tile_field_lightning
	rts

	lda #tile_field_fire
	rts

@sleep:
	lda #tile_field_sleep
	rts

@boulder:
	lda #tile_boulder
	rts

@attack_blue:
	lda #tile_attack_blue
	rts

@attack_red:
	lda #tile_attack_red
	rts

@lava:
	lda #tile_lava
	rts

@attack_small:
	lda #tile_attack_small
	rts

@rand_field:
	jsr j_rand
	and #$03
	clc
	adc #tile_field_first
	rts

do_foe_range_attack:
	sta attack_sprite
	lda combat_foe_cur_x,x
	sta target_x
	lda combat_foe_cur_y,x
	sta target_y
	lda #sound_cannon
	jsr j_playsfx
@move_missile:
	jsr next_arena_tile
	bmi @clear_sprite
	jsr check_hit_player
	bne hit_player
	jsr j_update_view_combat
	jmp @move_missile

@clear_sprite:
	lda attack_sprite
	ldx #$00
	stx attack_sprite
	cmp #tile_lava
	beq @create_lava
	rts

@create_lava:
	lda target_x
	sta dest_x
	lda target_y
	sta dest_y
	jsr j_gettile_currmap
	lda #tile_lava
	sta tempmap,y
	rts

hit_player:
	jsr print_newline
	jsr j_printname
	jsr print_newline
	lda attack_sprite
	cmp #tile_field_poison
	bne @check_lightning
	jsr j_primm  ;b'POISONED!\n\x00'
	.byte "POISONED!", $8d
	.byte 0
	jsr effect_poison_sleep
	jsr j_rand
	bpl @fail    ;chance 50%
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Good
	bne @fail
	lda #status_Poison
	sta (ptr1),y
	rts

@check_lightning:
	cmp #tile_field_lightning
	bne @check_fire
	jsr j_primm  ;b'ELECTRIFIED!\n\x00'
	.byte "ELECTRIFIED!", $8d
	.byte 0
	jsr player_injured
	rts

@check_fire:
	cmp #tile_field_fire
	bne @check_sleep
	jsr j_primm  ;b'FIERY \x00'
	.byte "FIERY ", 0
	jmp @hit

@check_sleep:
	cmp #tile_field_sleep
	bne @check_lava
	jsr j_primm  ;b'SLEPT!\n\x00'
	.byte "SLEPT!", $8d
	.byte 0
	jsr effect_poison_sleep
	jsr j_rand
	bmi :+
@fail:
	jsr j_primm  ;b'FAILED.\n\x00'
	.byte "FAILED.", $8d
	.byte 0
	rts

:	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Good
	bne @fail
	lda #status_Sleep
	sta (ptr1),y
	lda #tile_human_prone
	ldx curr_player
	sta combat_player_tile-1,x
	rts

@check_lava:
	cmp #tile_lava
	bne @check_magic
	jsr j_primm  ;b'LAVA \x00'
	.byte "LAVA ", 0
	jmp @hit

@check_magic:
	cmp #tile_attack_blue
	bne @hit
	jsr j_primm  ;b'MAGICAL \x00'
	.byte "MAGICAL ", 0
	jmp @hit

@hit:
	jsr j_primm  ;b'HIT!\n\x00'
	.byte "HIT!", $8d
	.byte 0
	jsr player_injured
	rts

effect_poison_sleep:
	jsr invert_player_name
	lda dest_x
	sta target_x
	lda dest_y
	sta target_y
	jsr j_update_view_combat
	lda #sound_firewalk
	jsr j_playsfx
	jsr invert_player_name
	lda #$00
	sta attack_sprite
	rts

check_hit_player:
	lda party_size
	sta curr_player
@next:
	jsr is_alive
	bne @skip
	ldx curr_player
	dex
	lda target_x
	cmp combat_player_xpos,x
	bne @skip
	lda target_y
	cmp combat_player_ypos,x
	bne @skip
	lda curr_player
	rts

@skip:
	dec curr_player
	bne @next
	rts

check_hit_foe:
	ldy #foes_max
@next:
	lda combat_foe_tile,y
	beq @skip
	lda combat_foe_cur_x,y
	cmp dest_x
	bne @skip
	lda combat_foe_cur_y,y
	cmp dest_y
	beq @done
@skip:
	dey
	bpl @next
@done:
	tya
	sta zp_cur_foe_index
	cmp #$00
	rts

next_arena_tile:
	clc
	lda target_x
	adc delta_x
	sta dest_x
	clc
	lda target_y
	adc delta_y
	sta dest_y
	lda dest_x
	cmp #xy_last_screen
	bcs @fail
	lda dest_y
	cmp #xy_last_screen
	bcs @fail
	jsr j_gettile_tempmap
	bmi @ok
	cmp #tile_water_last
	bcc @ok
	cmp #tile_white_space
	beq @ok
	cmp #tile_secret_panel
	beq @fail
	cmp #tile_diagonal_first
	bcc @blocked
	cmp #tile_diagonal_last
	bcc @ok
@blocked:
	jsr j_blocked_tile
	bmi @fail
@ok:
	lda dest_x
	sta target_x
	lda dest_y
	sta target_y
	lda #$00
	rts

@fail:
	lda #$ff
	rts

math_sign:
	cmp #$00
	beq @done
	bmi :+
	lda #$01
	rts

:	lda #$ff
@done:
	rts

math_abs:
	cmp #$00
	bmi @negate
	rts

@negate:
	eor #$ff
	clc
	adc #$01
	rts

math_negate:
	eor #$ff
	clc
	adc #$01
	rts

input_target_xy:
	jsr input_direction
	beq @done
	ldx curr_player
	dex
	lda combat_player_xpos,x
	sta dest_x
	lda combat_player_ypos,x
	sta dest_y
	lda #$01
@done:
	rts

input_direction:
	jsr j_waitkey
	bne @check_input_key
@return_none:
	jsr print_newline
	lda #$00
	rts

@check_input_key:
	pha
	lda #$00
	sta delta_x
	sta delta_y
	pla
	cmp #char_enter
	beq @up
	cmp #char_up_arrow
	beq @up
	cmp #char_slash
	beq @down
	cmp #char_down_arrow
	beq @down
	cmp #char_left_arrow
	beq @left
	cmp #char_right_arrow
	beq @right
	cmp #char_space
	beq @return_none
	jsr j_console_out
	jmp @return_none

@up:
	jsr print_north
	lda #$ff
	sta delta_y
	jmp @set_new_xy

@down:
	jsr print_south
	lda #$01
	sta delta_y
	jmp @set_new_xy

@left:
	jsr print_west
	lda #$ff
	sta delta_x
	jmp @set_new_xy

@right:
	jsr print_east
	lda #$01
	sta delta_x
@set_new_xy:
	clc
	lda player_xpos
	adc delta_x
	sta temp_x
	sta dest_x
	clc
	lda player_ypos
	adc delta_y
	sta temp_y
	sta dest_y
	lda #$01
	rts

print_north:
	jsr j_primm  ;b'North\n\x00'
	.byte "North", $8d
	.byte 0
	rts

print_south:
	jsr j_primm  ;b'South\n\x00'
	.byte "South", $8d
	.byte 0
	rts

print_east:
	jsr j_primm  ;b'East\n\x00'
	.byte "East", $8d
	.byte 0
	rts

print_west:
	jsr j_primm  ;b'West\n\x00'
	.byte "West", $8d
	.byte 0
	rts

get_mob_at_temp_xy:
	lda current_location
	bne @not_world
	ldx #object_mobs_max
	jmp check_next_object

@not_world:
	cmp #loc_dng_first
	bcs temp_xy_none
any_obj_at_temp_xy:
	ldx #object_max
check_next_object:
	lda temp_x
	cmp object_xpos,x
	bne temp_xy_skip
	lda temp_y
	cmp object_ypos,x
	bne temp_xy_skip
	lda object_tile_type,x
	beq temp_xy_skip
	txa
	rts

temp_xy_skip:
	dex
	bpl check_next_object
temp_xy_none:
	lda #$ff
	rts

print_attacker_name:
	ldx zp_index
	lda object_tile_type,x
print_target_name:
	bpl @non_monster
	sec
	sbc #tile_monster_first
	cmp #monster_water_last
	bcs @monster_non_water
	lsr          ;1000NNNx  print(N+1)
@print:
	clc
	adc #$01
	jsr j_printstring
	lda #char_newline
	jsr j_console_out
	rts

@monster_non_water:
	lsr
	lsr
	clc
	adc #$04
	jmp @print

@non_monster:
	cmp #$20     ;20 <= n < 30  or  50 <= n < 60
	bcc @inanimate
	cmp #$60
	bcs @inanimate
	cmp #$30
	bcc @npc
	cmp #$50
	bcc @inanimate
@npc:
	and #$1f     ;0xxNNNNx
	lsr
	clc
	adc #$4c     ;print(N + 4D)
	jmp @print

@inanimate:
	lda #$13     ;phantom
	jmp @print

input_char:
	jsr j_waitkey
	pha
	beq :+
	jsr j_console_out
:	lda #char_newline
	jsr j_console_out
	pla
	rts

anyone_awake:
	lda party_size
	sta curr_player
@next_alive:
	jsr is_alive
	beq @next_awake
	dec curr_player
	bne @next_alive
	jmp run_file_dead

@next_awake:
	jsr is_awake
	beq @yes
	dec curr_player
	bne @next_awake
	lda #$ff
	rts

@yes:
	lda #$00
	rts

run_file_dead:
	lda #music_off
	jsr music_ctl
	lda #disk_britannia
	jsr j_request_disk
	jsr j_primm_cout ;b'\x84BLOAD SAVE,A$8800\n\x00'
	.byte $84,"BLOAD SAVE,A$8800", $8d
	.byte 0
	jsr j_overlay_entry
	lda #music_explore
	jsr music_ctl
	jmp cmd_done

invert_all_players:
	lda party_size
	sta curr_player
@next:
	jsr invert_player_name
	dec curr_player
	bne @next
	rts

invert_player_name:
	lda curr_player
	asl
	asl
	asl
	tax
	lda #$08
	sta zpf0
@next_row:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	ldy #$26     ;column START
@next_col:
	lda (ptr1),y
	eor #$7f     ;preserve high-bit color palette
	sta (ptr1),y
	dey
	cpy #$18     ;column END
	bcs @next_col
	inx
	dec zpf0
	bne @next_row
	rts

encode_bcd_value:
	cmp #$00
	beq @done
	cmp #$63
	bcs @max
	sed
	tax
	lda #$00
@dec:
	clc
	adc #$01
	dex
	bne @dec
	beq @done
@max:
	lda #$99
@done:
	cld
	rts

decode_bcd_value:
	cmp #$00
	beq @done
	ldx #$00
	sed
@inc:
	inx
	sec
	sbc #$01
	bne @inc
	txa
	cld
@done:
	rts

inc_stat:
	sed
	clc
	lda party_stats,y
	adc #$01
	bcs :+
	sta party_stats,y
:	cld
	rts

dec_stat:
	sed
	sec
	lda party_stats,y
	sbc #$01
	bcc :+
	sta party_stats,y
:	cld
	rts

inc_virtue:
	sta zpd9
	sed
	clc
	lda party_stats,y
	beq @done    ;00 == Avatar
	adc zpd9
	bcc @done
	lda #$99     ;99 == clamp max
@done:
	sta party_stats,y
	cld
	rts

dec_virtue:
	sta zp_amount
	sty zpd9
	lda party_stats,y
	beq @lost_eighth
@lost_eighth_rts:
	sed
	sec
	sbc zp_amount
	beq @underflow
	bcs :+
@underflow:
	lda #$01     ;01 == clamp min
:	sta party_stats,y
	cld
	rts

@lost_eighth:
	jsr j_primm  ;b'\nTHOU HAST LOST\nAN EIGHTH!\n\x00'
	.byte $8d
	.byte "THOU HAST LOST", $8d
	.byte "AN EIGHTH!", $8d
	.byte 0
	ldy zpd9
	lda #$99
	jmp @lost_eighth_rts

dec_player_hp:
	sta zp_amount
	jsr j_get_stats_ptr
	ldy #player_cur_hp_lo
	sed
	sec
	lda (ptr1),y
	sbc zp_amount
	sta (ptr1),y
	dey
	lda (ptr1),y
	sbc #$00
	sta (ptr1),y
	cld
	bcc @died
	lda #$01
	rts

@died:
	lda #$00
	sta (ptr1),y
	iny
	sta (ptr1),y
	jsr j_get_stats_ptr
	ldy #player_status
	lda #status_Dead
	sta (ptr1),y
	lda game_mode
	bpl @done
	lda #tile_human_prone
	ldx curr_player
	sta combat_player_tile-1,x
@done:
	lda #$00
	rts

inc_player_hp:
	sta zp_amount
	jsr j_get_stats_ptr
	ldy #player_cur_hp_lo
	sed
	clc
	lda (ptr1),y
	adc zp_amount
	sta (ptr1),y
	dey
	lda (ptr1),y
	adc #$00
	sta (ptr1),y
	cld
	ldy #player_cur_hp_hi
	lda (ptr1),y
	ldy #player_max_hp_hi
	cmp (ptr1),y
	bcc @done
	ldy #player_cur_hp_lo
	lda (ptr1),y
	ldy #player_max_hp_lo
	cmp (ptr1),y
	bcc @done
	ldy #player_max_hp_hi
	lda (ptr1),y
	ldy #player_cur_hp_hi
	sta (ptr1),y
	ldy #player_max_hp_lo
	lda (ptr1),y
	ldy #player_cur_hp_lo
	sta (ptr1),y
@done:
	rts

inc_party_gold:
	sta zp_amount
	ldy #party_stat_gold_lo
	sed
	clc
	lda party_stats,y
	adc zp_amount
	sta party_stats,y
	dey
	lda party_stats,y
	adc #$00
	sta party_stats,y
	cld
	bcc @no_overflow
	lda #$99
	sta party_stats,y
	iny
	sta party_stats,y
@no_overflow:
	rts

inc_player_exp:
	sta zpd8
	jsr j_get_stats_ptr
	ldy #player_experience_lo
	sed
	clc
	lda (ptr1),y
	adc zpd8
	sta (ptr1),y
	dey
	lda (ptr1),y
	adc #$00
	sta (ptr1),y
	cld
	bcc @no_overflow
	lda #$99
	sta (ptr1),y
	iny
	sta (ptr1),y
@no_overflow:
	rts

burn_player:
	jsr hilight_damaged_plr
	lda #$1e     ;0 - 29
	jsr rand_modulo
	jsr encode_bcd_value
	jsr dec_player_hp
	rts

damage_party:
	jsr invert_all_players
	lda #sound_damage
	jsr j_playsfx
	jsr shake_screen
	lda game_mode
	bmi @check_each_player
	lda player_transport
	cmp #tile_ship_last
	bcs @check_each_player
	sed
	sec
	lda ship_hull
	sbc #$0a     ;fixed damage 10
	cld
	bcs @damage_ship
	lda #$00
	sta ship_hull
	jsr invert_all_players
	jsr j_update_status
	jsr j_primm  ;b'\nTHY SHIP SINKS!\n\x00'
	.byte $8d
	.byte "THY SHIP SINKS!", $8d
	.byte 0
	jmp run_file_dead

@damage_ship:
	sta ship_hull
@check_each_player:
	lda party_size
	sta curr_player
@next:
	jsr j_rand
	bmi @skip    ;1/2 chance
	jsr is_alive
	bne @skip
	lda game_mode
	bpl @damage_player
	ldx curr_player
	lda combat_player_tile-1,x
	beq @skip
@damage_player:
	lda #$19     ;0-25 damage
	jsr rand_modulo
	jsr encode_bcd_value
	jsr dec_player_hp
@skip:
	dec curr_player
	bne @next
	jsr invert_all_players
	jsr j_update_status
	rts

hilight_damaged_plr:
	jsr invert_player_name
	lda #sound_firewalk
	jsr j_playsfx
	jsr invert_player_name
	rts

print_newline:
	lda #char_newline
	jsr j_console_out
	rts

shake_screen:
	jsr move_view_up
	jsr move_view_down
	jsr move_view_up
	jsr move_view_down
	jsr move_view_up
	jsr move_view_down
	jsr move_view_up
	jsr move_view_down
	rts

move_view_down:
	ldx #$ae
@next_x:
	lda bmplineaddr_lo + 9,x
	sta ptr1
	lda bmplineaddr_hi + 9,x
	sta ptr1 + 1
	lda bmplineaddr_lo + 7,x
	sta ptr2
	lda bmplineaddr_hi + 7,x
	sta ptr2 + 1
	ldy #$16     ;11 tiles (22 columns)
@next_y:
	lda (ptr2),y
	sta (ptr1),y
	dey
	bne @next_y
	bit music_volume
	bpl :+
	jsr j_rand
	bmi :+
	bit hw_speaker
:	dex
	bne @next_x
	rts

move_view_up:
	ldx #$00
@next_x:
	lda bmplineaddr_lo + 8,x
	sta ptr1
	lda bmplineaddr_hi + 8,x
	sta ptr1 + 1
	lda bmplineaddr_lo + 10,x
	sta ptr2
	lda bmplineaddr_hi + 10,x
	sta ptr2 + 1
	ldy #$16     ;11 tiles (22 columns)
@next_y:
	lda (ptr2),y
	sta (ptr1),y
	dey
	bne @next_y
	bit music_volume
	bpl :+
	jsr j_rand
	bmi :+
	bit hw_speaker
:	inx
	cpx #$ae
	bcc @next_x
	rts

check_enter_moongate:
	cmp #tile_moongate_full
	beq :+
	rts

; BUG: stack overflow. Entered here via JSR but exit via JMP to load_shrine or cmd_done
:	lda moon_phase_trammel
	cmp #$04
	bne gate_to_gate
	lda moon_phase_felucca
	cmp #$04
	bne gate_to_gate
	jsr j_update_view
	jsr j_invertview
	lda #sound_spell_effect
	ldx #$a0
	jsr j_playsfx
	lda #loc_shrine_sacrifice
	sta current_location
	jmp load_shrine

gate_to_gate:
	jsr j_update_view
	ldx moon_phase_felucca
	lda moongate_x,x
	sta player_xpos
	lda moongate_y,x
	sta player_ypos
	jsr j_invertview
	lda #sound_spell_effect
	ldx #$a0
	jsr j_playsfx
	jsr j_invertview
	jsr j_player_teleport
	jsr j_update_view
	jsr j_invertview
	lda #sound_spell_effect
	ldx #$a0
	jsr j_playsfx
	jsr j_invertview
	jmp cmd_done

is_evil:
	cmp #$00     ;non-monster
	bpl @not_evil
	cmp #tile_seahorse
	beq @not_evil
	cmp #tile_rat
	beq @not_evil
	cmp #tile_bat
	beq @not_evil
	cmp #tile_spider
	beq @not_evil
	cmp #tile_insects
	beq @not_evil
	cmp #tile_python
	beq @not_evil
	lda #$ff
	rts

@not_evil:
	lda #$00
	rts

; junk:  ON OF\nVIRTUE IS CA
	.byte $cf,$ce,$a0,$cf,$c6,$8d,$d6,$c9
	.byte $d2,$d4,$d5,$c5,$a0,$c9,$d3,$a0
	.byte $c3,$c1
