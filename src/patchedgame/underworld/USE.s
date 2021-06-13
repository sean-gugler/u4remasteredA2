	.include "uscii.i"
	.include "USE.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
player_xpos = $00
player_ypos = $01
dest_x = $06
dest_y = $07
current_location = $0a
game_mode = $0b
dungeon_level = $0c
altar_room_principle = $18
tile_under_player = $c8
music_volume = $cd
console_xpos = $ce
curr_player = $d4
zpd9 = $d9
zpda = $da
zpea = $ea
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
tile_xpos = $0002
tile_ypos = $0003
map_x = $0004
map_y = $0005
britannia_x = $0008
britannia_y = $0009
balloon_flying = $000d
player_transport = $000e
party_size = $000f
dng_direction = $0010
light_duration = $0011
moon_phase_trammel = $0012
moon_phase_felucca = $0013
horse_mode = $0014
player_has_spoken_to_lb = $0015
last_sleep = $0016
last_humility_check = $0017
last_meditated = $0019
last_found_reagent = $001a
ship_hull = $001b
move_counter = $001c
;move_counter + 1 = $001d
;move_counter + 2 = $001e
;move_counter + 3 = $001f
kbd_buf_count = $0046
key_buf = $00b0
;key_buf+1 = $00b1
key_buf_len = $00b8
charptr = $00bd
;charptr+1 = $00be
foe_type_encountered = $00c0
pre_combat_x = $00c1
pre_combat_y = $00c2
pre_combat_tile = $00c3
curr_player_turn = $00c5
magic_aura = $00c6
aura_duration = $00c7
tile_north = $00c9
tile_south = $00ca
tile_east = $00cb
tile_west = $00cc
console_ypos = $00cf
diskid = $00d0
numdrives = $00d1
currdisk_drive1 = $00d2
currdisk_drive2 = $00d3
target_player = $00d5
hexnum = $00d6
bcdnum = $00d7
zpd8 = $00d8
zpdb = $00db
damage = $00dc
reqdisk = $00de
currdrive = $00df
lt_track = $00e0
lt_sector = $00e1
lt_rwflag = $00e2
lt_addr_hi = $00e3
foe_type_combat = $00e6
game_mode_pre_combat = $00e8
turn_counter = $00e9
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
temp_y = $00fb
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
bmplineaddr_hi = $e0c0
;bmplineaddr_hi + 7 = $e0c7
;bmplineaddr_hi + 8 = $e0c8
;bmplineaddr_hi + 9 = $e0c9
;bmplineaddr_hi + 10 = $e0ca
player_stats = $ec00
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



	.segment "OVERLAY"

j_overlay_entry:
	lda game_mode
	cmp #$03
	bne @ask_which
	sta saved_game_mode
	lda #mode_loading
	sta game_mode
@ask_which:
	jsr j_primm  ;b'WHICH ITEM:\n\x00'
	.byte "WHICH ITEM:", $8d
	.byte 0
	jsr get_input
	jsr compare_keywords_all
	bpl keyword_matched
print_not_usable:
	jsr j_primm  ;b'\nNOT USABLE!\n\x00'
	.byte $8d
	.byte "NOT USABLE!", $8d
	.byte 0
	jmp return_to_dungeon

print_none_owned:
	jsr j_primm  ;b'\nNONE OWNED!\n\x00'
	.byte $8d
	.byte "NONE OWNED!", $8d
	.byte 0
	jmp return_to_dungeon

print_no_effect:
	jsr j_primm  ;b'\nHMM...NO EFFECT!\n\x00'
	.byte $8d
	.byte "HMM...NO EFFECT!", $8d
	.byte 0
	jmp return_to_dungeon

keyword_matched:
	cmp #$08
	bcs print_not_usable
	asl
	tay
	lda keyword_handlers,y
	sta ptr1
	lda keyword_handlers+1,y
	sta ptr1 + 1
	jmp (ptr1)

keyword_handlers:
	.addr use_stone
	.addr use_bell
	.addr use_book
	.addr use_candle
	.addr use_key
	.addr use_horn
	.addr use_wheel
	.addr use_skull

return_to_dungeon:
	jsr j_primm_cout ;b'\x04BLOAD DNGD,A$8C00\n\x00'
	.byte $84,"BLOAD DNGD,A$8C00", $8d
	.byte 0
	lda saved_game_mode
	cmp #mode_dungeon
	bne @skip
	sta game_mode
@skip:
	rts

saved_game_mode:
	.byte 0

use_stone:
	lda stones
	bne @have_stone
	jmp print_none_owned

@have_stone:
	lda current_location
	cmp #loc_dng_abyss
	bne @regular_dungeon
	jmp use_stone_in_abyss

@regular_dungeon:
	lda game_mode
	cmp #mode_combat_dng_room
	beq @check_center
@no_effect:
	jmp print_no_effect

@check_center:
	ldx curr_player
	lda #$05
	cmp combat_player_xpos-1,x
	bne @no_effect
	cmp combat_player_ypos-1,x
	bne @no_effect
	jsr j_primm  ;b'\nTHERE ARE HOLES\nFOR 4 STONES,\nWHAT COLORS:\n\x00'
	.byte $8d
	.byte "THERE ARE HOLES", $8d
	.byte "FOR 4 STONES,", $8d
	.byte "WHAT COLORS:", $8d
	.byte 0
	lda #$00
	sta placed_stone_mask
	lda #$03
	sta placed_stone_counter
@next_stone:
	lda #$04
	sec
	sbc placed_stone_counter
	jsr j_printdigit
	jsr get_input
	jsr compare_keywords_colors
	sec
	sbc #$08
	cmp #$08
	bcs @none_owned
	tay
	lda bit_msb,y
	and stones
	beq @none_owned
	lda bit_msb,y
	and placed_stone_mask
	bne @none_owned
	lda bit_msb,y
	ora placed_stone_mask
	sta placed_stone_mask
	dec placed_stone_counter
	bmi @check_stones
	jmp @next_stone

@none_owned:
	jmp print_none_owned

@check_stones:
	lda placed_stone_mask
	ldy altar_room_principle
	cmp principle_colors,y
	beq @all_stones_match
@already_have_keypart:
	jmp print_no_effect

@all_stones_match:
	ldy altar_room_principle
	lda principle_keypart,y
	and threepartkey
	bne @already_have_keypart
	lda principle_keypart,y
	ora threepartkey
	sta threepartkey
	jsr j_primm  ;b'THOU DOTH FIND\nONE THIRD OF THE\nTHREE PART KEY!\n\x00'
	.byte "THOU DOTH FIND", $8d
	.byte "ONE THIRD OF THE", $8d
	.byte "THREE PART KEY!", $8d
	.byte 0
	jmp return_to_dungeon

use_stone_in_abyss:
	lda saved_game_mode
	cmp #mode_dungeon
	beq @check_for_altar
@no_effect:
	jmp print_no_effect

@check_for_altar:
	lda tile_under_player
	cmp #dng_tile_altar
	bne @no_effect
	jsr j_primm  ;b'\nAS THOU\nDOTH APPROACH\n\x00'
	.byte $8d
	.byte "AS THOU", $8d
	.byte "DOTH APPROACH", $8d
	.byte 0
	jsr ask_virtue
	bne @no_effect
	jsr j_primm  ;b'\nTHE VOICE SAYS:\nUSE THY STONE.\n\nCOLOR:\n\x00'
	.byte $8d
	.byte "THE VOICE SAYS:", $8d
	.byte "USE THY STONE.", $8d
	.byte $8d
	.byte "COLOR:", $8d
	.byte 0
	jsr get_input
	jsr compare_keywords_colors
	sec
	sbc #$08
	cmp #$08
	bcs @no_effect
	sta abyss_altar_stone_used
	tay
	lda bit_msb,y
	and stones
	bne @have_stone
	jmp print_none_owned

@have_stone:
	lda abyss_altar_stone_used
	cmp dungeon_level
	bne @no_effect
	cmp #$07
	beq @load_end_game
	lda player_xpos
	sta dest_x
	lda player_ypos
	sta dest_y
	jsr j_gettile_dungeon
	lda #dng_tile_ladder_d
	sta (ptr1),y
	jsr j_primm  ;b'\nTHE ALTER\nCHANGES BEFORE\nTHYNE EYES!\n\x00'
	.byte $8d
	.byte "THE ALTER", $8d
	.byte "CHANGES BEFORE", $8d
	.byte "THYNE EYES!", $8d
	.byte 0
	jmp return_to_dungeon

@load_end_game:
	jsr j_primm_cout ;b'\x04BRUN END,A$8800\n\x00'
	.byte $84,"BRUN END,A$8800", $8d
	.byte 0

placed_stone_mask:
	.byte 0
placed_stone_counter:
	.byte 0

use_bell:
	lda bell_book_candle
	and #item_have_bell
	bne use_no_effect
	beq use_none_owned

use_book:
	lda bell_book_candle
	and #item_have_book
	bne use_no_effect

use_none_owned:
	jmp print_none_owned
use_no_effect:
	jmp print_no_effect

use_candle:
	lda bell_book_candle
	and #item_have_candle
	bne use_no_effect
	beq use_none_owned

use_key:
	lda threepartkey
	bne j_print_no_effect
	jmp print_none_owned

use_horn:
	lda horn
	bne j_print_no_effect
	jmp print_none_owned

use_wheel:
	lda wheel
	bne j_print_no_effect
	jmp print_none_owned

j_print_no_effect:
	jmp print_no_effect

use_skull:
	lda skull
	cmp #$01
	beq @have_skull
	jmp print_none_owned

@have_skull:
	lda game_mode
	bmi j_print_no_effect
	jsr j_primm  ;b'\nHOLDING THE EVIL\nSKULL ALOFT...\n\x00'
	.byte $8d
	.byte "HOLDING THE EVIL", $8d
	.byte "SKULL ALOFT...", $8d
	.byte 0
	jsr shake_screen
	jsr j_invertview
	jsr shake_screen
	jsr j_invertview
	jsr shake_screen
	ldx #object_max
	lda #$00
@clear:
	sta object_tile_type,x
	sta object_tile_sprite,x
	dex
	bpl @clear
	jsr j_update_view
	lda #virtue_last - 1
	sta zpea
@next_virtue:
	ldy zpea
	lda #$05
	jsr dec_virtue
	dec zpea
	bpl @next_virtue
	jsr j_update_status
	jmp return_to_dungeon

get_input:
	lda #char_question
	jsr j_console_out
	lda #$00
	sta zpea
@get_char:
	jsr j_waitkey
	cmp #char_enter
	beq @got_input
	cmp #char_left_arrow
	beq @backspace
	cmp #char_space
	bcc @get_char
	ldx zpea
	sta inbuffer,x
	jsr j_console_out
	inc zpea
	lda zpea
	cmp #$0f
	bcc @get_char
	bcs @got_input
@backspace:
	lda zpea
	beq @get_char
	dec zpea
	dec console_xpos
	lda #char_space
	jsr j_console_out
	dec console_xpos
	jmp @get_char

@got_input:
	ldx zpea
	lda #char_space
@pad_spaces:
	sta inbuffer,x
	inx
	cpx #$06
	bcc @pad_spaces
	lda #char_enter
	jsr j_console_out
	rts

compare_keywords_colors:
	lda #$0f
	sta zpea
	jmp check_keyword

compare_keywords_all:
	lda #$17
	sta zpea
check_keyword:
	lda zpea
	asl
	asl
	tay
	ldx #$00
@compare:
	lda keywords,y
	cmp inbuffer,x
	bne @nomatch
	iny
	inx
	cpx #$04
	bcc @compare
	lda zpea
	rts

@nomatch:
	dec zpea
	bpl check_keyword
	lda zpea
	rts

keywords:
	.byte "STON"
	.byte "BELL"
	.byte "BOOK"
	.byte "CAND"
	.byte "KEY "
	.byte "HORN"
	.byte "WHEE"
	.byte "SKUL"

	.byte "BLUE"
	.byte "YELL"
	.byte "RED "
	.byte "GREE"
	.byte "ORAN"
	.byte "PURP"
	.byte "WHIT"
	.byte "BLAC"

	.byte "HONE"
	.byte "COMP"
	.byte "VALO"
	.byte "JUST"
	.byte "SACR"
	.byte "HONO"
	.byte "SPIR"
	.byte "HUMI"

shake_screen:
	lda #sound_damage
	jsr j_playsfx
	jsr shake_up
	jsr shake_down
	jsr shake_up
	jsr shake_down
	jsr shake_up
	jsr shake_down
	jsr shake_up
	jsr shake_down
	rts

shake_down:
	ldx #$ae
@next:
	lda bmplineaddr_lo + 9,x
	sta ptr1
	lda bmplineaddr_hi + 9,x
	sta ptr1 + 1
	lda bmplineaddr_lo + 7,x
	sta ptr2
	lda bmplineaddr_hi + 7,x
	sta ptr2 + 1
	ldy #$16
@copy:
	lda (ptr2),y
	sta (ptr1),y
	dey
	bne @copy
	bit music_volume
	bpl @skip
	jsr j_rand
	bmi @skip
	bit hw_speaker
@skip:
	dex
	bne @next
	rts

shake_up:
	ldx #$00
@next:
	lda bmplineaddr_lo + 8,x
	sta ptr1
	lda bmplineaddr_hi + 8,x
	sta ptr1 + 1
	lda bmplineaddr_lo + 10,x
	sta ptr2
	lda bmplineaddr_hi + 10,x
	sta ptr2 + 1
	ldy #$16
@copy:
	lda (ptr2),y
	sta (ptr1),y
	dey
	bne @copy
	bit music_volume
	bpl @skip
	jsr j_rand
	bmi @skip
	bit hw_speaker
@skip:
	inx
	cpx #$ae
	bcc @next
	rts

dec_virtue:
	sta zpda
	sty zpd9
	lda party_stats,y
	beq @lost_an_eighth
@continue:
	sed
	sec
	sbc zpda
	beq @underflow
	bcs @store
@underflow:
	lda #$01
@store:
	sta party_stats,y
	cld
	rts

@lost_an_eighth:
	jsr j_primm  ;b'\nAN EIGHTH LOST!\n\x00'
	.byte $8d
	.byte "AN EIGHTH LOST!", $8d
	.byte 0
	lda #$99
	ldy zpd9
	jmp @continue

bit_msb:
	.byte $80,$40,$20,$10,$08,$04,$02,$01
principle_keypart:
	.byte 4, 2, 1
principle_colors:
	.byte %10010110
	.byte %01011010
	.byte %00101110

ask_virtue:
	lda dungeon_level
	cmp #$07
	bne @level1
	jmp @level8

@level1:
	jsr j_primm  ;b'\nA VOICE RINGS\nOUT: WHAT VIRTUE\nDOST STEM FROM\n\x00'
	.byte $8d
	.byte "A VOICE RINGS", $8d
	.byte "OUT: WHAT VIRTUE", $8d
	.byte "DOST STEM FROM", $8d
	.byte 0
	ldx dungeon_level
	bne @level2
	jsr j_primm  ;b'TRUTH?\n\x00'
	.byte "TRUTH?", $8d
	.byte 0
	jmp @get_reply

@level2:
	dex
	bne @level3
	jsr j_primm  ;b'LOVE?\n\x00'
	.byte "LOVE?", $8d
	.byte 0
	jmp @get_reply

@level3:
	dex
	bne @level4
	jsr j_primm  ;b'COURAGE?\n\x00'
	.byte "COURAGE?", $8d
	.byte 0
	jmp @get_reply

@level4:
	dex
	bne @level5
	jsr j_primm  ;b'TRUTH AND LOVE?\n\x00'
	.byte "TRUTH AND LOVE?", $8d
	.byte 0
	jmp @get_reply

@level5:
	dex
	bne @level6
	jsr j_primm  ;b'LOVE AND\nCOURAGE?\n\x00'
	.byte "LOVE AND", $8d
	.byte "COURAGE?", $8d
	.byte 0
	jmp @get_reply

@level6:
	dex
	bne @level7
	jsr j_primm  ;b'COURAGE AND\nTRUTH?\n\x00'
	.byte "COURAGE AND", $8d
	.byte "TRUTH?", $8d
	.byte 0
	jmp @get_reply

@level7:
	dex
	bne @level8
	jsr j_primm  ;b'TRUTH, LOVE\nAND COURAGE?\n\x00'
	.byte "TRUTH, LOVE", $8d
	.byte "AND COURAGE?", $8d
	.byte 0
	jmp @get_reply

@level8:
	jsr j_primm  ;b'A VOICE RINGS\nOUT: WHAT\nVIRTUE EXISTS\nINDEPENDENTLY OF\nTRUTH, LOVE AND\nCOURAGE!\n\x00'
	.byte "A VOICE RINGS", $8d
	.byte "OUT: WHAT", $8d
	.byte "VIRTUE EXISTS", $8d
	.byte "INDEPENDENTLY OF", $8d
	.byte "TRUTH, LOVE AND", $8d
	.byte "COURAGE!", $8d
	.byte 0

@get_reply:
	jsr get_input
	jsr compare_keywords_all
	sec
	sbc #$10
	cmp dungeon_level
	rts

abyss_altar_stone_used:
	.byte 0

; junk
	.byte $ff,$ff
