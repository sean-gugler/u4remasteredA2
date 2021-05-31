	.include "uscii.i"
	.include "NEWGAME.i"

;
; **** ZP FIELDS ****
;
numdrives = $d1
;
; **** ZP ABSOLUTE ADRESSES ****
;
player_xpos = $00
player_ypos = $01
game_mode = $0b
party_size = $0f
spk_pattern_ptr = $b0
;spk_pattern_ptr+1 = $b1
spk_byte = $b2
spk_pattern_length = $b3
spk_repeat_code = $b4
spk_pattern_code = $b5
spk_row = $b6
spk_repeat_count = $b7
spk_repeat_flag = $b8
spk_pattern_count = $b9
spk_pattern_flag = $ba
spk_pattern_len_cur = $bb
gender_chosen = $bc
draw_col = $c0
draw_row = $c1
draw_ptr = $c2
;draw_ptr + 1 = $c3
col_count = $c4
console_xpos = $ce
console_ypos = $cf
diskid = $d0
;numdrives = $d1
currdisk_drive1 = $d2
currdisk_drive2 = $d3
curr_player = $d4
reqdisk = $de
currdrive = $df
game_mode_pre_combat = $e8
temp_y = $fb
ptr2 = $fc
;ptr2 + 1 = $fd
ptr1 = $fe
;ptr1 + 1 = $ff
;
; **** ZP POINTERS ****
;
;draw_ptr = $c2
;ptr2 = $fc
;ptr1 = $fe
;
; **** FIELDS ****
;
;fffff = $ffff
;
; **** ABSOLUTE ADRESSES ****
;
card_honesty = $4000
card_compassion = $4460
card_valor = $48c0
card_justice = $4d20
card_sacrifice = $5180
card_honor = $55e0
card_spirituality = $5a40
card_humility = $5ea0
;
; **** USER LABELS ****
;
tile_xpos = $0002
tile_ypos = $0003
map_x = $0004
map_y = $0005
dest_x = $0006
dest_y = $0007
britannia_x = $0008
britannia_y = $0009
current_location = $000a
dungeon_level = $000c
balloon_flying = $000d
player_transport = $000e
dng_direction = $0010
light_duration = $0011
moon_phase_trammel = $0012
moon_phase_felucca = $0013
horse_mode = $0014
player_has_spoken_to_lb = $0015
last_sleep = $0016
last_humility_check = $0017
altar_room_principle = $0018
last_meditated = $0019
last_found_reagent = $001a
ship_hull = $001b
move_counter = $001c
;move_counter + 1 = $001d
;move_counter + 2 = $001e
;move_counter + 3 = $001f
kbd_buf_count = $0046
charptr = $00bd
;charptr+1 = $00be
curr_player_turn = $00c5
magic_aura = $00c6
aura_duration = $00c7
tile_under_player = $00c8
tile_north = $00c9
tile_south = $00ca
tile_east = $00cb
tile_west = $00cc
music_volume = $00cd
target_player = $00d5
hexnum = $00d6
bcdnum = $00d7
zpd8 = $00d8
zpd9 = $00d9
zpda = $00da
zpdb = $00db
damage = $00dc
lt_track = $00e0
lt_sector = $00e1
lt_rwflag = $00e2
lt_addr_hi = $00e3
foe_type_combat = $00e6
turn_counter = $00e9
zpea = $00ea
moongate_tile = $00ed
moongate_xpos = $00ee
moongate_ypos = $00ef
zpf0 = $00f0
tilerow = $00f2
movement_mode = $00f4
direction = $00f5
temp2_x = $00f6
temp2_y = $00f7
delta_x = $00f8
delta_y = $00f9
temp_x = $00fa
draw_stack = $0200
room_start_foe_type = $0210
room_start_foe_x = $0220
room_start_foe_y = $0230
map_start_foe_x = $0240
room_start_player_y = $0248
map_start_foe_y = $0250
map_start_player_x = $0260
map_start_player_y = $0268
tempmap = $0280
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
j_animate_tiles = $086c
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
save_portal_backgnd = $6000
j_readblock = $b7b5
rwts_volume = $b7eb
rwts_track = $b7ec
rwts_sector = $b7ed
rwts_buf_lo = $b7f0
rwts_buf_hi = $b7f1
rwts_command = $b7f4
hw_keyboard = $c000
hw_strobe = $c010
hw_speaker = $c030
hw_lcbank1 = $c08b
bmplineaddr_lo = $e000
;bmplineaddr_lo + 7 = $e007
;bmplineaddr_lo + 8 = $e008
;bmplineaddr_lo + 9 = $e009
;bmplineaddr_lo + 10 = $e00a
;bmplineaddr_lo + $68 = $e068
bmplineaddr_hi = $e0c0
;bmplineaddr_hi + 7 = $e0c7
;bmplineaddr_hi + 8 = $e0c8
;bmplineaddr_hi + 9 = $e0c9
;bmplineaddr_hi + 10 = $e0ca
;bmplineaddr_hi + $68 = $e128
music_init = $ec00
party_stats = $ed00
;party_stats + 1 = $ed01
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

key_buf_len = $b8
hgr_page2 = $4000


	.segment "MAIN"

	bit hw_lcbank1
	bit hw_lcbank1
	jmp init_scene

start_game:
	lda #$00
	sta key_buf_len
	lda #$00
	jsr music_ctl
	jsr j_primm_cout ;b'\x04BRUN ULT4,A$4000\n\x00'
	.byte $84,"BRUN ULT4,A$4000",$8d, 0

wait_key:
	jsr j_waitkey
	bpl wait_key
	rts

scene:
	.byte 0

init_scene:
	lda #$00
	sta question_number
	lda #$10
	sta console_ypos
	jsr j_primm_cout ;b'\x04BLOAD TREE.SPK,A$4000\n\x00'
	.byte $84,"BLOAD TREE.SPK,A$4000",$8d, 0
	jsr clear_text_area
@s1d_show_tree:
	jsr spk_unpack
	lda #$1d
	sta scene
	jmp start_scene

next_scene:
	jsr wait_key
	jsr clear_text_area
	lda scene
start_scene:
	jsr print_string
	inc scene
	lda scene
	cmp #$21
	bne @s32_portal
	jsr portal_appear
	jmp next_scene

@s32_portal:
	cmp #$23
	bne @s24_show_clearing
	jsr portal_vanish
	jsr j_primm_cout ;b'\x04BLOAD PRTL.SPK,A$4000\n\x00'
	.byte $84,"BLOAD PRTL.SPK,A$4000",$8d, 0
	jmp next_scene

@s24_show_clearing:
	cmp #$24
	bne @s29_show_tree
	jsr spk_unpack
	jsr j_primm_cout ;b'\x04BLOAD TREE.SPK,A$4000\n\x00'
	.byte $84,"BLOAD TREE.SPK,A$4000",$8d, 0
	jmp next_scene

@s29_show_tree:
	cmp #$29
	bne @s2c_music_towne
	jsr spk_unpack
	jsr j_primm_cout ;b'\x04BLOAD LOOK.SPK,A$4000\n\x00'
	.byte $84,"BLOAD LOOK.SPK,A$4000",$8d, 0
	jmp next_scene

@s2c_music_towne:
	cmp #$2c
	bne @s2d_show_book
	lda #char_T
	jsr music_ctl
	jmp next_scene

@s2d_show_book:
	cmp #$2d
	bne @s2f_show_fair
	jsr spk_unpack
	jsr j_primm_cout ;b'\x04BLOAD FAIR.SPK,A$4000\n\x00'
	.byte $84,"BLOAD FAIR.SPK,A$4000",$8d, 0
	jmp next_scene

@s2f_show_fair:
	cmp #$2f
	bne @s32_show_wagon
	jsr spk_unpack
	jsr j_primm_cout ;b'\x04BLOAD WAGN.SPK,A$4000\n\x00'
	.byte $84,"BLOAD WAGN.SPK,A$4000",$8d, 0
	jmp next_scene

@s32_show_wagon:
	cmp #$32
	bne @s33_show_gypsy
	jsr spk_unpack
	jsr j_primm_cout ;b'\x04BLOAD GYPS.SPK,A$4000\n\x00'
	.byte $84,"BLOAD GYPS.SPK,A$4000",$8d, 0
	jmp next_scene

@s33_show_gypsy:
	cmp #$33
	bne @s35_show_table
	jsr spk_unpack
	jsr j_primm_cout ;b'\x04BLOAD TABL.SPK,A$4000\n\x00'
	.byte $84,"BLOAD TABL.SPK,A$4000",$8d, 0
@next_scene:
	jmp next_scene

@s35_show_table:
	cmp #$35
	bne @next_scene
	jsr spk_unpack
	jsr j_primm_cout ;b'\x04BLOAD CRDS,A$4000\n\x00'
	.byte $84,"BLOAD CRDS,A$4000",$8d, 0
	jsr wait_key

; Begin fortune telling
	lda #$00
	sta question_number
	ldx #$07
	lda #$00
@clear_virtues:
	sta card_eligible,x
	dex
	bpl @clear_virtues
fill_green:
	ldx #$0f
@next_row:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	ldy #card1_col_min
@next_col:
	lda #gfx_green_even
	sta (ptr1),y
	iny
	lda #gfx_green_odd
	sta (ptr1),y
	iny
	cpy #card1_col_max
	bne :+
	ldy #card2_col_min
	bne @next_col
:	cpy #$26
	bcc @next_col
	inx
	bpl @next_row
	lda question_number
	cmp #$04
	beq @runoff
	cmp #$06
	bne @pick_cards
@runoff:
	jsr mark_runoff_cards
@pick_cards:
	jsr clear_text_area
	jsr choose_fresh_card
	stx card_left
:	jsr choose_fresh_card
	cpx card_left
	beq :-
	stx card_right
	cpx card_left
	bcs @in_order
	ldy card_left
	stx card_left
	sty card_right
@in_order:
	lda question_number
	bne @not_first
	lda #string_cards_first
	jsr print_string
	jmp @cards_of

@not_first:
	cmp #$06
	beq @cards_last
	lda #string_cards_more
	jsr print_string
	jmp @cards_of

@cards_last:
	lda #string_cards_last
	jsr print_string
@cards_of:
	lda #string_cards_of
	jsr print_string
	lda card_left
	clc
	adc #string_virtue_first
	jsr print_string
	lda card_left
	ldx #$00
	jsr draw_card
	jsr j_primm  ;b' and \x00'
	.byte " and ", 0
	lda card_right
	clc
	adc #string_virtue_first
	jsr print_string
	jsr j_primm  ;b'. She says,\x00'
	.byte ". She says,", 0
	lda #$00
	sta console_xpos
	inc console_ypos
	jsr j_primm  ;b"'Consider this:'\x00"
	.byte "'Consider this:'", 0
	lda card_right
	ldx #$01
	jsr draw_card
	jsr wait_key
	jsr clear_text_area
	ldx card_left
	lda question_table,x
	clc
	adc card_right
	jsr print_string
@input_ab:
	jsr wait_key
	cmp #char_A
	beq @chosen_on_left
	cmp #char_B
	bne @input_ab
	ldx card_right
	ldy card_left
	stx card_left
	sty card_right
@chosen_on_left:
	ldx card_left
	stx card_chosen
	lda #$01     ;set aside for runoff
	sta card_eligible,x
	clc
	sed
	lda virtue_level,x
	adc #$05
	sta virtue_level,x
	lda virtue_str,x
	adc cur_str
	sta cur_str
	lda virtue_dex,x
	adc cur_dex
	sta cur_dex
	lda virtue_int,x
	adc cur_int
	sta cur_int
	cld
	ldy question_number
	lda #$00
	jsr draw_bead
	ldx card_right
	lda #$ff     ;discard
	sta card_eligible,x
	ldy question_number
	lda #$01
	jsr draw_bead
	inc question_number
	lda question_number
	cmp #$07
	beq conclusion
	jmp fill_green

conclusion:
	jsr clear_text_area
	lda #string_farewell
	jsr print_string
	jsr wait_key
	jsr clear_text_area
	lda #$00
	jsr music_ctl
	lda #string_transport
	jsr print_string
	jsr wait_key
	lda #$00
	jsr music_ctl
	jsr j_primm_cout ;b'\x04BLOAD NPRT,A$0\n\x04BLOAD NLST,A$EE00\n\x04BLOAD NRST,A$EC00\n\x00'
	.byte $84,"BLOAD NPRT,A$0",$8d
	.byte $84,"BLOAD NLST,A$EE00",$8d
	.byte $84,"BLOAD NRST,A$EC00",$8d
	.byte 0
	lda game_mode
	sta game_mode_pre_combat
	lda #$00
	sta game_mode
	lda card_chosen
	sta curr_player
	inc curr_player
	jsr j_get_stats_ptr
	lda ptr1
	sta ptr2
	lda ptr1 + 1
	sta ptr2 + 1
	lda #$01
	sta curr_player
	jsr j_get_stats_ptr
	ldy #$1f
@set_player_class:
	lda (ptr1),y
	pha
	lda (ptr2),y
	sta (ptr1),y
	pla
	sta (ptr2),y
	dey
	bpl @set_player_class
	ldy #$0f
@set_player_name:
	lda inbuffer,y
	sta (ptr1),y
	dey
	bpl @set_player_name
	ldy #$10     ;player_gender
	lda gender_chosen
	sta (ptr1),y
	clc
	ldy #player_strength
	lda cur_str
	sta (ptr1),y
	ldy #player_dexterity
	lda cur_dex
	sta (ptr1),y
	ldy #player_intelligence
	lda cur_int
	sta (ptr1),y
	ldx #$07
@set_virtues:
	lda virtue_level,x
	sta party_stats,x
	dex
	bpl @set_virtues
	lda #$01
	sta party_size
	ldx card_chosen
	lda start_world_x,x
	sta player_xpos
	lda start_world_y,x
	sta player_ypos
	jmp start_game

card_eligible:
	.res 8
question_table:
	.byte $00,$06,$0b,$0f,$12,$14,$15
card_chosen:
	.byte $00
card_left:
	.byte $00
card_right:
	.byte $00
question_number:
	.byte $00
start_world_x:
	.byte $e7,$53,$23,$3b,$9e,$69,$17,$ba
start_world_y:
	.byte $88,$69,$dd,$2c,$15,$b7,$81,$ab
cur_str:
	.byte $0f
cur_dex:
	.byte $0f
cur_int:
	.byte $0f
virtue_str:
	.byte $00,$00,$03,$00,$01,$01,$01,$00
virtue_dex:
	.byte $00,$03,$00,$01,$01,$00,$01,$00
virtue_int:
	.byte $03,$00,$00,$01,$00,$01,$01,$00
virtue_level:
	.byte $50,$50,$50,$50,$50,$50,$50,$50

choose_fresh_card:
	jsr j_rand
	and #$07
	tax
	lda card_eligible,x
	bne choose_fresh_card
	rts

sound_portal_line:
	ldy #$28
	bit hw_speaker
@dur:
	ldx temp_y
@freq:
	dex
	bne @freq
	bit hw_speaker
	dey
	bne @dur
set_ptr1_line:
	ldx temp_y
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	lda bmplineaddr_lo,x
	sta ptr1
	rts

portal_appear:
	lda #<save_portal_backgnd
	sta ptr2
	lda #>save_portal_backgnd
	sta ptr2 + 1
	ldx #portal_row_min
	stx temp_y
@next_row:
	jsr set_ptr1_line
	ldy #portal_col_min
	ldx #$00
@next_col:
	lda (ptr1),y
	sta (ptr2,x)
	inc ptr2
	bne :+
	inc ptr2 + 1
:	iny
	cpy #portal_col_max
	bcc @next_col
	inc temp_y
	lda temp_y
	cmp #portal_row_max
	bcc @next_row
	dec temp_y
@rise:
	jsr sound_portal_line
	ldy #portal_col_min
	lda #gfx_blue_even
	sta (ptr1),y
	iny
	lda #gfx_blue_odd
	sta (ptr1),y
	iny
	lda #gfx_blue_even
	sta (ptr1),y
	dec temp_y
	lda temp_y
	cmp #portal_row_min
	bcs @rise
	rts

portal_vanish:
	lda #<save_portal_backgnd
	sta ptr2
	lda #>save_portal_backgnd
	sta ptr2 + 1
	ldx #portal_row_min
	stx temp_y
@fall:
	jsr sound_portal_line
	ldy #portal_col_min
	ldx #$00
@next_col:
	lda (ptr2,x)
	sta (ptr1),y
	inc ptr2
	bne :+
	inc ptr2 + 1
:	iny
	cpy #portal_col_max
	bcc @next_col
	inc temp_y
	lda temp_y
	cmp #portal_row_max
	bcc @fall
	rts

clear_window:
	ldx #$4f
@next_row:
	lda bmplineaddr_lo + $68,x
	sta ptr1
	lda bmplineaddr_hi + $68,x
	sta ptr1 + 1
	ldy #$26
	lda #$00
@next_col:
	sta (ptr1),y
	dey
	bne @next_col
	dex
	bpl @next_row
	rts

mark_runoff_cards:
	ldx #$07
@next:
	lda card_eligible,x
	bmi @skip
	lda #$00
	sta card_eligible,x
@skip:
	dex
	bpl @next
	rts

clear_text_area:
	ldx #$bf
@next_row:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	lda #$00
	ldy #$27
@next_col:
	sta (ptr1),y
	dey
	bpl @next_col
	dex
	cpx #$90
	bcs @next_row
	lda #$00
	sta console_xpos
	lda #$12
	sta console_ypos
	rts

; unused
insert_disk:
	sta reqdisk
@display_prompt:
	lda reqdisk
	cmp #disk_britannia
	beq @drive2
	cmp #disk_dungeon
	beq @drive2
@drive1:
	lda #$01
	sta currdrive
	lda reqdisk
	cmp currdisk_drive1
	beq @have_disk
	lda question_number
	cmp #$07
	bne @d1_clear
	jsr clear_text_area
	jmp @d1_prompt

@d1_clear:
	jsr clear_window
@d1_prompt:
	ldy console_ypos
	ldx #$0b
	jsr j_primm_xy ;b'PLEASE PLACE THE\x00'
	.byte "PLEASE PLACE THE", 0
	inc console_ypos
	jsr print_disk_name
	ldy console_ypos
	ldx #$0d
	jsr j_primm_xy ;b'INTO DRIVE 1\x00'
	.byte "INTO DRIVE 1", 0
@wait_key:
	inc console_ypos
	ldy console_ypos
	ldx #$0b
	jsr j_primm_xy ;b'AND PRESS [ESC]\x00'
	.byte "AND PRESS [ESC]", 0
:	jsr j_waitkey
	cmp #char_ESC
	bne :-
@have_disk:
	jmp @load_disk_id

@drive2:
	lda numdrives
	cmp #$02
	bcc @drive1
	lda #$02
	sta currdrive
	lda reqdisk
	cmp currdisk_drive2
	beq @load_disk_id
	lda question_number
	cmp #$07
	bne @d2_clear
	jsr clear_text_area
	jmp @d2_prompt

@d2_clear:
	jsr clear_window
@d2_prompt:
	ldy console_ypos
	ldx #$0b
	jsr j_primm_xy ;b'PLEASE PLACE THE\x00'
	.byte "PLEASE PLACE THE", 0
	inc console_ypos
	jsr print_disk_name
	ldy console_ypos
	ldx #$0d
	jsr j_primm_xy ;b'INTO DRIVE 2\x00'
	.byte "INTO DRIVE 2", 0
	jmp @wait_key

@load_disk_id:
	lda currdrive
	clc
	adc #$b0
	sta @drive_number
	jsr j_primm_cout ;b'\x04BLOAD DISK,D1\n\x00'
	.byte $84,"BLOAD DISK,D"
@drive_number:
	.byte "1", $8d
	.byte 0
	ldx currdrive
	lda diskid
	sta numdrives,x
	cmp reqdisk
	beq @ok
	dec console_ypos
	dec console_ypos
	jmp @display_prompt

@ok:
	rts

print_disk_name:
	ldx reqdisk
@program:
	dex
	bne @britannia
	ldy console_ypos
	ldx #$0d
	jsr j_primm_xy ;b'ULTIMA DISK\x00'
	.byte "ULTIMA DISK", 0
	inc console_ypos
	rts

@britannia:
	dex
	bne @towne
	ldy console_ypos
	ldx #$0c
	jsr j_primm_xy ;b'BRITANNIA DISK\x00'
	.byte "BRITANNIA DISK", 0
	inc console_ypos
	rts

@towne:
	dex
	bne @dungeon
	ldy console_ypos
	ldx #$0e
	jsr j_primm_xy ;b'TOWN DISK\x00'
	.byte "TOWN DISK", 0
	inc console_ypos
	rts

@dungeon:
	dex
	bne @done
	ldy console_ypos
	ldx #$0d
	jsr j_primm_xy ;b'DUNGEON DISK\x00'
	.byte "DUNGEON DISK", 0
	inc console_ypos
@done:
	rts

print_string:
	tay
	lda #<string_table
	sta ptr1
	lda #>string_table
	sta ptr1 + 1
	ldx #$00
@next_char:
	lda (ptr1,x)
	beq @end_string
@next_string:
	jsr inc_ptr
	jmp @next_char

@end_string:
	dey
	beq @print_char
	jmp @next_string

@print_char:
	jsr inc_ptr
	ldx #$00
	lda (ptr1,x)
	beq @done
	cmp #$ff
	bne @no_newline
	inc console_ypos
	lda #$00
	sta console_xpos
	jmp @print_char

@no_newline:
	jsr j_console_out
	jmp @print_char

@done:
	rts

inc_ptr:
	inc ptr1
	bne :+
	inc ptr1 + 1
:	rts

; INPUT: A = color, X = column, Y = row
draw_bead:
	pha
	lda bead_row,y
	sta draw_row
	lda bead_col,x
	sta draw_col
	lsr
	pla
	rol
	asl
	tax
	lda bead_addr,x
	sta @src_ptr
	lda bead_addr + 1,x
	sta @src_ptr + 1
	ldx #$00
@next_row:
	ldy draw_row
	lda bmplineaddr_lo,y
	sta draw_ptr
	lda bmplineaddr_hi,y
	sta draw_ptr + 1
	ldy draw_col
@src_ptr = * + $01
	lda $ffff,x
	sta (draw_ptr),y
	inc draw_row
	inx
	cpx #$0e
	bcc @next_row
	rts

bead_row:
	.byte $11,$21,$31,$41,$51,$61,$71
bead_col:
	.byte $10,$11,$12,$13,$14,$15,$16,$17
bead_addr:
	.word bead_white_even
	.word bead_white_odd
	.word bead_black_even
	.word bead_black_odd
bead_white_even:
	.byte $3a,$7e,$7e,$7e,$7e,$7e,$7f,$7f
	.byte $7e,$7e,$7e,$7e,$7e,$3a
bead_white_odd:
	.byte $5d,$7f,$7f,$7f,$7f,$7f,$7f,$7f
	.byte $7f,$7f,$7f,$7f,$7f,$5d
bead_black_even:
	.byte $22,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$22
bead_black_odd:
	.byte $45,$01,$01,$01,$01,$01,$01,$01
	.byte $01,$01,$01,$01,$01,$45

; INPUT: A = card#, X = 0 left | 1 right
draw_card:
	pha
	lda #card_row_top
	sta draw_row
	lda card_col_table,x
	sta draw_col
	pla
	asl
	tax
	lda card_addr,x
	sta @src_ptr
	lda card_addr + 1,x
	sta @src_ptr + 1
	ldx #$00
@next_row:
	ldy draw_row
	lda bmplineaddr_lo,y
	sta draw_ptr
	lda bmplineaddr_hi,y
	sta draw_ptr + 1
	lda #card_col_count
	sta col_count
	ldy draw_col
@src_ptr = * + $01
@next_col:
	lda $ffff,x
	sta (draw_ptr),y
	inx
	bne :+
	inc @src_ptr + 1
:	iny
	dec col_count
	bne @next_col
	inc draw_row
	lda draw_row
	cmp #card_row_bottom
	bne @next_row
	rts

card_col_table:
	.byte $02,$1c
card_addr:
	.word card_honesty
	.word card_compassion
	.word card_valor
	.word card_justice
	.word card_sacrifice
	.word card_honor
	.word card_spirituality
	.word card_humility

	.byte "SUPER-PACKER COPYRIGHT 1983 BY STEVEN MEUSE"
spk_unpack:
	lda #>hgr_page2
	sta ptr2 + 1
	ldx #$00
	stx spk_repeat_flag
	stx spk_pattern_flag
	stx ptr2
	stx spk_pattern_len_cur
	lda (ptr2,x)
	sta spk_repeat_code
	inc ptr2
	lda (ptr2,x)
	sta spk_pattern_code
	inc ptr2
	ldy #max_spk_column
@next_col:
	ldx #max_spk_row
	stx spk_row
@next_row:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	jsr spk_write_byte
	dec spk_row
	ldx spk_row
	cpx #$ff
	bne @next_row
	dey
	cpy #$ff
	bne @next_col
	rts

spk_write_byte:
	ldx #$00
	bit spk_repeat_flag
	bmi @do_repeat
	bit spk_pattern_flag
	bmi @do_pattern
@read_byte:
	lda (ptr2,x)
	sta spk_byte
	cmp spk_repeat_code
	bne @check_pattern
@set_repeat:
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda (ptr2,x)
	sta spk_repeat_count
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda (ptr2,x)
	sta spk_byte
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda #$80
	sta spk_repeat_flag
	bne @do_repeat
@check_pattern:
	cmp spk_pattern_code
	bne @do_literal
@set_pattern:
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda (ptr2,x)
	sta spk_pattern_length
	sta spk_pattern_len_cur
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda (ptr2,x)
	sta spk_pattern_count
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda ptr2
	sta spk_pattern_ptr
	lda ptr2 + 1
	sta spk_pattern_ptr+1
	lda #$80
	sta spk_pattern_flag
	bne @do_pattern
@do_literal:
	lda spk_byte
	sta (ptr1),y
	inc ptr2
	bne @continue
	inc ptr2 + 1
@continue:
	rts

@do_repeat:
	lda spk_byte
	sta (ptr1),y
	dec spk_repeat_count
	bne @continue
	lda #$00
	sta spk_repeat_flag
	bit spk_pattern_flag
	bpl @continue
	dec spk_pattern_len_cur
	dec spk_pattern_len_cur
	bne @next_pattern
@do_pattern:
	lda (ptr2,x)
	cmp spk_repeat_code
	bne @pattern_literal
	lda spk_pattern_len_cur
:	bne @set_repeat
@dead_code:
	lda spk_pattern_ptr
	sta ptr2
	lda spk_pattern_ptr+1
	sta ptr2 + 1
	bne :-
@pattern_literal:
	sta (ptr1),y
	inc ptr2
	bne @next_pattern
	inc ptr2 + 1
@next_pattern:
	dec spk_pattern_len_cur
	bne @continue
	lda spk_pattern_length
	sta spk_pattern_len_cur
	dec spk_pattern_count
	beq @pattern_done
	lda spk_pattern_ptr
	sta ptr2
	lda spk_pattern_ptr+1
	sta ptr2 + 1
	rts

@pattern_done:
	lda #$00
	sta spk_pattern_flag
	rts

string_table:
; STRING $00 (0)
	.byte 0
; STRING $01 (1)
	.byte "Entrusted to deliver an uncounted purse", $ff
	.byte "of gold, thou dost meet a poor beggar.", $ff
	.byte "Dost thou A) deliver the gold knowing", $ff
	.byte "the Trust in thee was well-placed; or", $ff
	.byte "B) show Compassion, giving the Beggar a", $ff
	.byte "coin, knowing it won't be missed?", 0
; STRING $02 (2)
	.byte "Thou has been prohibited by thy absent", $ff
	.byte "Lord from joining thy friends in a close", $ff
	.byte "pitched battle. Dost thou A) refrain, so", $ff
	.byte "thou may Honestly claim obedience; or", $ff
	.byte "B) show Valor, and aid thy comrades,", $ff
	.byte "knowing thou may deny it later?", 0
; STRING $03 (3)
	.byte "A merchant owes thy friend money, now", $ff
	.byte "long past due. Thou dost see the same", $ff
	.byte "merchant drop a purse of gold. Dost thou", $ff
	.byte "A) Honestly return the purse intact; or", $ff
	.byte "B) Justly give thy friend a portion of", $ff
	.byte "the gold first?", 0
; STRING $04 (4)
	.byte "Thee and thy friend are valiant but", $ff
	.byte "penniless warriors. Thou both go out to", $ff
	.byte "slay a mighty dragon. Thy friend thinks", $ff
	.byte "he slew it, thee did. When asked, dost", $ff
	.byte "thou A) Truthfully claim the gold; or", $ff
	.byte "B) Allow thy friend the large reward?", 0
; STRING $05 (5)
	.byte "Thou art sworn to protect thy Lord at", $ff
	.byte "any cost, yet thou knowest he hath", $ff
	.byte "committed a crime. Authorities ask thee", $ff
	.byte "of the affair, dost thou A) break thine", $ff
	.byte "oath by Honestly speaking; or B) uphold", $ff
	.byte "Honor by silently keeping thine oath?", 0
; STRING $06 (6)
	.byte "Thy friend seeks admittance to thy", $ff
	.byte "Spiritual order. Thou art asked to vouch", $ff
	.byte "for his purity of Spirit, of which thou", $ff
	.byte "art unsure. Dost thou A) Honestly", $ff
	.byte "express thy doubt; or B) Vouch for him,", $ff
	.byte "hoping for his Spiritual improvement?", 0
; STRING $07 (7)
	.byte "Thy Lord mistakenly believes he slew a", $ff
	.byte "dragon. Thou hast proof that thy lance", $ff
	.byte "felled the beast.  When asked, dost thou", $ff
	.byte "A) Honestly claim the kill and the", $ff
	.byte "prize; or B) Humbly permit thy Lord his", $ff
	.byte "belief?", 0
; STRING $08 (8)
	.byte "Thou dost manage to disarm thy mortal", $ff
	.byte "enemy in a duel. He is at thy mercy.", $ff
	.byte "Dost thou A) show Compassion by", $ff
	.byte "permitting him to yield; or B) slay him", $ff
	.byte "as expected of a Valiant duelist?", 0
; STRING $09 (9)
	.byte "After 20 years thou hast found the", $ff
	.byte "slayer of thy best friends. The villain", $ff
	.byte "proves to be a man who provides the sole", $ff
	.byte "support for a young girl. Dost thou", $ff
	.byte "A) spare him in Compassion for the girl;", $ff
	.byte "or B) slay him in the name of Justice?", 0
; STRING $0A (10)
	.byte "Thee and thy friends have been routed", $ff
	.byte "and ordered to retreat. In defiance of", $ff
	.byte "thy orders, dost thou A) stop in", $ff
	.byte "Compassion to aid a wounded companion;", $ff
	.byte "or B) Sacrifice thyself to slow the", $ff
	.byte "pursuing enemy, so others can escape?", 0
; STRING $0B (11)
	.byte "Thou art sworn to uphold a Lord who", $ff
	.byte "participates in the forbidden torture of", $ff
	.byte "prisoners. Each night their cries of", $ff
	.byte "pain reach thee. Dost thou A) Show", $ff
	.byte "Compassion by reporting the deeds; or", $ff
	.byte "B) Honor thy oath and ignore the deeds?", 0
; STRING $0C (12)
	.byte "Thou hast been taught to preserve all", $ff
	.byte "life as sacred. A man lies fatally stung", $ff
	.byte "by a venomous serpent. He pleads for a", $ff
	.byte "merciful death. Dost thou A) show", $ff
	.byte "Compassion and end his pain; or B) heed", $ff
	.byte "thy Spiritual beliefs and refuse?", 0
; STRING $0D (13)
	.byte "As one of the King's Guard, thy Captain", $ff
	.byte "has asked that one amongst you visit", $ff
	.byte "a hospital to cheer the children with", $ff
	.byte "tales of thy valiant deeds. Dost thou", $ff
	.byte "A) Show thy Compassion and play the", $ff
	.byte "braggart; or B) Humbly let another go?", 0
; STRING $0E (14)
	.byte "Thou hast been sent to secure a needed", $ff
	.byte "treaty with a distant Lord. Thy host is", $ff
	.byte "agreeable to the proposal but insults", $ff
	.byte "thy country at dinner. Dost thou", $ff
	.byte "A) Valiantly bear the slurs; or", $ff
	.byte "B) Justly rise and demand an apology?", 0
; STRING $0F (15)
	.byte "A mighty knight accosts thee and demands", $ff
	.byte "thy food. Dost thou A) Valiantly refuse", $ff
	.byte "and engage the knight; or B) Sacrifice", $ff
	.byte "thy food unto the hungry knight?", 0
; STRING $10 (16)
	.byte "During battle thou art ordered to guard", $ff
	.byte "thy commander's empty tent. The battle", $ff
	.byte "goes poorly and thou dost yearn to aid", $ff
	.byte "thy fellows. Dost thou A) Valiantly", $ff
	.byte "enter the battle to aid thy companions;", $ff
	.byte "or B) Honor thy post as guard?", 0
; STRING $11 (17)
	.byte "A local bully pushes for a fight. Dost", $ff
	.byte "thou A) Valiantly trounce the rogue; or", $ff
	.byte "B) Decline, knowing in thy Spirit that", $ff
	.byte "no lasting good will come of it?", 0
; STRING $12 (18)
	.byte "Although a teacher of music, thou art", $ff
	.byte "a skillful wrestler. Thou hast been ", $ff
	.byte "asked to fight in a local championship.", $ff
	.byte "Dost thou A) accept the invitation and", $ff
	.byte "Valiantly fight to win; or B) Humbly", $ff
	.byte "decline knowing thou art sure to win?", 0
; STRING $13 (19)
	.byte "During a pitched battle, thou dost see", $ff
	.byte "a fellow desert his post, endangering", $ff
	.byte "many. As he flees, he is set upon by", $ff
	.byte "several enemies. Dost thou A) Justly let", $ff
	.byte "him fight alone; or B) Risk Sacrificing", $ff
	.byte "thine own life to aid him?", 0
; STRING $14 (20)
	.byte "Thou hast sworn to do thy Lord's", $ff
	.byte "bidding in all. He covets a piece of", $ff
	.byte "land and orders the owner removed. Dost", $ff
	.byte "thou A) serve Justice, refusing to act,", $ff
	.byte "thus being disgraced; or B) Honor thine", $ff
	.byte "oath and unfairly evict the landowner?", 0
; STRING $15 (21)
	.byte "Thou dost believe that virtue resides", $ff
	.byte "in all people. Thou dost see a rogue", $ff
	.byte "steal from thy Lord. Dost thou A) call", $ff
	.byte "him to Justice; or B) personally try to", $ff
	.byte "sway him back to the Spiritual path of", $ff
	.byte "good?", 0
; STRING $16 (22)
	.byte "Unwitnessed, thou hast slain a great", $ff
	.byte "dragon in self defense. A poor warrior", $ff
	.byte "claims the offered reward. Dost thou", $ff
	.byte "A) Justly step forward to claim the ", $ff
	.byte "reward; or B) Humbly go about life,", $ff
	.byte "secure in thy self-esteem?", 0
; STRING $17 (23)
	.byte "Thou art a bounty hunter sworn to return", $ff
	.byte "an alleged murderer. After his capture,", $ff
	.byte "thou believest him to be innocent.  Dost", $ff
	.byte "thou A) Sacrifice thy sizeable bounty", $ff
	.byte "for thy belief; or B) Honor thy oath to", $ff
	.byte "return him as thou hast promised?", 0
; STRING $18 (24)
	.byte "Thou hast spent thy life in charitable", $ff
	.byte "and righteous work. Thine uncle the", $ff
	.byte "innkeeper lies ill and asks you to take", $ff
	.byte "over his tavern. Dost thou A) Sacrifice", $ff
	.byte "thy life of purity to aid thy kin; or", $ff
	.byte "B) decline & follow thy Spirit's call?", 0
; STRING $19 (25)
	.byte "Thou art an elderly, wealthy eccentric.", $ff
	.byte "Thy end is near. Dost thou A) donate all", $ff
	.byte "thy wealth to feed hundreds of starving", $ff
	.byte "children, and receive public adulation;", $ff
	.byte "or B) Humbly live out thy life, willing", $ff
	.byte "thy fortune to thy heirs?", 0
; STRING $1A (26)
	.byte "In thy youth thou pledged to marry thy", $ff
	.byte "sweetheart. Now thou art on a sacred", $ff
	.byte "quest in distant lands. Thy sweetheart ", $ff
	.byte "asks thee to keep thy vow. Dost thou", $ff
	.byte "A) Honor thy pledge to wed; or B) follow", $ff
	.byte "thy Spiritual crusade?", 0
; STRING $1B (27)
	.byte "Thou art at a crossroads in thy life.", $ff
	.byte "Dost thou A) Choose the Honorable life", $ff
	.byte "of a Paladin, striving for Truth and", $ff
	.byte "Courage; or B) Choose the Humble life", $ff
	.byte "of a Shepherd, and a world of simplicity", $ff
	.byte "and peace?", 0
; STRING $1C (28)
	.byte "Thy parents wish thee to become an", $ff
	.byte "apprentice. Two positions are available.", $ff
	.byte "Dost thou A) Become an acolyte in the", $ff
	.byte "Spiritual order; or B) Become an", $ff
	.byte "assistant to a humble village cobbler?", 0
; STRING $1D (29)
	.byte "  The day is warm, yet there is a", $ff
	.byte "cooling breeze. The latest in a series", $ff
	.byte "of personal crises seems insurmountable.", $ff
	.byte "You are being pulled apart in all", $ff
	.byte "directions.", 0
; STRING $1E (30)
	.byte "Yet this afternoon walk in the country-", $ff
	.byte "side slowly brings relaxation to your", $ff
	.byte "harried mind. The soil and stain of", $ff
	.byte "modern high-tech living begins to wash", $ff
	.byte "off in layers. That willow tree near the", $ff
	.byte "stream looks comfortable and inviting.", 0
; STRING $1F (31)
	.byte "The buzz of dragonflies and the whisper", $ff
	.byte "of the willow's swaying branches bring", $ff
	.byte "a deep peace. Searching inward for", $ff
	.byte "tranquility and happiness, you close", $ff
	.byte "your eyes.", 0
; STRING $20 (32)
	.byte "A high-pitched cascading sound like", $ff
	.byte "crystal wind chimes impinges on your", $ff
	.byte "floating awareness. As you open your", $ff
	.byte "eyes, you see a shimmering blueness rise", $ff
	.byte "from the ground. The sound seems to be", $ff
	.byte "emanating from this glowing portal.", 0
; STRING $21 (33)
	.byte "It is difficult to look at the blueness.", $ff
	.byte "Light seems to bend and distort around", $ff
	.byte "it, while the sound waves become so", $ff
	.byte "intense, they appear to become visible.", 0
; STRING $22 (34)
	.byte "The portal hangs there for a moment,", $ff
	.byte "then, with the rush of an imploding", $ff
	.byte "vacuum, it sinks into the ground.", $ff
	.byte "Something remains suspended in midair", $ff
	.byte "for a moment, before falling to earth", $ff
	.byte "with a heavy thud.", 0
; STRING $23 (35)
	.byte "Somewhat shaken by this vision, you", $ff
	.byte "rise to your feet to investigate. A", $ff
	.byte "crude circle of stones surrounds the", $ff
	.byte "spot where the portal appeared. There is", $ff
	.byte "something glinting in the grass.", 0
; STRING $24 (36)
	.byte "You pick up an amulet shaped like a", $ff
	.byte "cross with a loop at the top. It is an", $ff
	.byte "Ankh, the sacred symbol of life and", $ff
	.byte "rebirth. But this could not have made", $ff
	.byte "the thud, so you look again and find", $ff
	.byte "a large book wrapped in thick cloth!", 0
; STRING $25 (37)
	.byte "With trembling hands you unwrap the", $ff
	.byte "book. Behold, the cloth is a map, and", $ff
	.byte "within lies not one book, but two. The", $ff
	.byte "map is of a land strange to you, and the", $ff
	.byte "style speaks of ancient cartography.", 0
; STRING $26 (38)
	.byte "The script on the cover of the first", $ff
	.byte "book is arcane but readable. The title", $ff
	.byte "is:", $ff
	.byte "        The History of Britannia", $ff
	.byte "               as told by", $ff
	.byte "            Kyle the Younger", 0
; STRING $27 (39)
	.byte "The other book is disturbing to look at.", $ff
	.byte "Its small cover appears to be fashioned", $ff
	.byte "out of some form of leathery hide, but", $ff
	.byte "from what creature is uncertain. The", $ff
	.byte "reddish black skin radiates an intense", $ff
	.byte "aura suggestive of ancient power.", 0
; STRING $28 (40)
	.byte "The tongue of the title is beyond your", $ff
	.byte "keen. You dare not open the book and", $ff
	.byte "disturb whatever sleeps within. You", $ff
	.byte "decide to peruse the History. Settling", $ff
	.byte "back under the willow tree, you open the", $ff
	.byte "book.", 0
; STRING $29 (41)
	.byte $ff
	.byte $ff
	.byte "    (You read the Book of History)", 0
; STRING $2A (42)
	.byte $ff
	.byte $ff
	.byte "(No, really! Read the Book of History!)", 0
; STRING $2B (43)
	.byte "Closing the book, you again pick up", $ff
	.byte "the Ankh. As you hold it, you begin to", $ff
	.byte "hear a hauntingly familiar, lute-like", $ff
	.byte "sound wafting over a nearby hill. Still", $ff
	.byte "clutching the strange artifacts, you", $ff
	.byte "rise unbidden and climb the slope.", 0
; STRING $2C (44)
	.byte "In the valley below you see what appears", $ff
	.byte "to be a fair. It seems strange that you", $ff
	.byte "came that way earlier and noticed", $ff
	.byte "nothing. As you mull this over, your", $ff
	.byte "feet carry you down toward the site.", 0
; STRING $2D (45)
	.byte "This is no ordinary travelling", $ff
	.byte "carnival, but a Renaissance Fair. The", $ff
	.byte "pennants on the tent tops blow briskly", $ff
	.byte "in the late afternoon breeze.", 0
; STRING $2E (46)
	.byte "The ticket taker at the RenFair's gate", $ff
	.byte "starts to ask you for money, but upon", $ff
	.byte "spotting your Ankh says, 'Welcome,", $ff
	.byte "friend. Enter in peace and find your", $ff
	.byte "path.'", 0
; STRING $2F (47)
	.byte "The music continues to pull you", $ff
	.byte "forward amongst the merchants and", $ff
	.byte "vendors. Glimpses of fabulous treasures", $ff
	.byte "can be seen in some of the shadowy", $ff
	.byte "booths.", 0
; STRING $30 (48)
	.byte "These people are very happy. They seem", $ff
	.byte "to glow with an inner light. Some look", $ff
	.byte "up as you pass and smile, but you cannot", $ff
	.byte "stop-- the music compels you to move", $ff
	.byte "onward through the crowd.", 0
; STRING $31 (49)
	.byte "Through the gathering dusk you see a", $ff
	.byte "secluded gypsy wagon sitting off in the", $ff
	.byte "woods. The music seems to emanate from", $ff
	.byte "the wagon. As you draw nearer, a woman's", $ff
	.byte "voice weaves into the music, saying:", $ff
	.byte "'You may approach, O seeker.'", 0
; STRING $32 (50)
	.byte "You enter to find an old gypsy sitting", $ff
	.byte "in a small, curtained room. She wears an", $ff
	.byte "Ankh around her neck. In front of her is", $ff
	.byte "a round table covered in deep green", $ff
	.byte "velvet. The room smells so heavily of", $ff
	.byte "incense that you feel dizzy.", 0
; STRING $33 (51)
	.byte "Seeing the Ankh, the ancient gypsy", $ff
	.byte "smiles and warns you never to part with", $ff
	.byte "it. 'We have been waiting such a long", $ff
	.byte "time, but at last you have come. Sit", $ff
	.byte "here and I shall read the path of your", $ff
	.byte "future.'", 0
; STRING $34 (52)
	.byte "Upon the table she places a curious", $ff
	.byte "wooden object like an abacus but without", $ff
	.byte "beads. In her hands she holds eight", $ff
	.byte "unusual cards. 'Let us begin the", $ff
	.byte "casting.'", 0
; STRING $35 (53)
	.byte "The gypsy places the first two cards", $ff
	.byte 0
; STRING $36 (54)
	.byte "The gypsy places two more of the cards", $ff
	.byte 0
; STRING $37 (55)
	.byte "The gypsy places the last two cards", $ff
	.byte 0
; STRING $38 (56)
	.byte "upon the table, they are the cards of", $ff
	.byte 0
; STRING $39 (57)
	.byte "honesty", 0
; STRING $3A (58)
	.byte "compassion", 0
; STRING $3B (59)
	.byte "valor", 0
; STRING $3C (60)
	.byte "justice", 0
; STRING $3D (61)
	.byte "sacrifice", 0
; STRING $3E (62)
	.byte "honor", 0
; STRING $3F (63)
	.byte "spirituality", 0
; STRING $40 (64)
	.byte "humility", 0
; STRING $41 (65)
	.byte 0
; STRING $42 (66)
	.byte "With the final choice, the incense", $ff
	.byte "swells up around you. The gypsy speaks", $ff
	.byte "as if from a great distance, her voice", $ff
	.byte "growing fainter with each word:", $ff
	.byte "'So be it! Thy path is chosen!'", 0
; STRING $43 (67)
	.byte "There is a moment of intense, wrenching", $ff
	.byte "vertigo.  As you close your eyes, a", $ff
	.byte "voice whispers within your mind, 'Seek", $ff
	.byte "the counsel of thy sovereign.' After a", $ff
	.byte "moment, the spinning subsides, and you", $ff
	.byte "open your eyes to...", 0
