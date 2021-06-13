	.include "uscii.i"
	.include "SHP2.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
current_location = $0a
console_xpos = $ce
hexnum = $d6
bcdnum = $d7
zp_char_count = $ea
zp_shop_num = $ea
zp_attempts = $f0
zp_mismatches = $f0
ptr1 = $fe
;ptr1 + 1 = $ff
;
; **** ZP POINTERS ****
;
;ptr1 = $fe
;
; **** USER LABELS ****
;
player_xpos = $0000
player_ypos = $0001
tile_xpos = $0002
tile_ypos = $0003
map_x = $0004
map_y = $0005
dest_x = $0006
dest_y = $0007
britannia_x = $0008
britannia_y = $0009
game_mode = $000b
dungeon_level = $000c
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
altar_room_principle = $0018
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
tile_under_player = $00c8
tile_north = $00c9
tile_south = $00ca
tile_east = $00cb
tile_west = $00cc
music_volume = $00cd
console_ypos = $00cf
diskid = $00d0
numdrives = $00d1
currdisk_drive1 = $00d2
currdisk_drive2 = $00d3
curr_player = $00d4
target_player = $00d5
zpd8 = $00d8
zpd9 = $00d9
zpda = $00da
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
tilerow = $00f2
movement_mode = $00f4
direction = $00f5
temp2_x = $00f6
temp2_y = $00f7
delta_x = $00f8
delta_y = $00f9
temp_x = $00fa
temp_y = $00fb
ptr2 = $00fc
;ptr2 + 1 = $00fd
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



	.segment "OVERLAY"

j_overlay_entry:
	jsr j_primm  ;b'\nWELCOME TO\n\x00'
	.byte $8d
	.byte "WELCOME TO", $8d
	.byte 0
	ldx current_location
	dex
	lda location_table,x
	sta zp_shop_num
	dec zp_shop_num
	jsr print_string
	jsr print_newline
	jsr print_newline
	clc
	lda zp_shop_num
	adc #$06
	jsr print_string
	jsr j_primm  ;b' SAYS:\nGOOD DAY, AND\nWELCOME FRIEND.\n\nMAY I INTEREST\nYOU IN SOME\nRATIONS?\x00'
	.byte " SAYS:", $8d
	.byte "GOOD DAY, AND", $8d
	.byte "WELCOME FRIEND.", $8d
	.byte $8d
	.byte "MAY I INTEREST", $8d
	.byte "YOU IN SOME", $8d
	.byte "RATIONS?", 0
	jsr input_char
	cmp #char_Y
	beq @buy
	jmp bye

@buy:
	jsr j_primm  ;b'\nWE HAVE THE\nBEST ADVENTURE\nRATIONS, 25 FOR\nONLY \x00'
	.byte $8d
	.byte "WE HAVE THE", $8d
	.byte "BEST ADVENTURE", $8d
	.byte "RATIONS, 25 FOR", $8d
	.byte "ONLY ", 0
	ldy zp_shop_num
	lda price_table,y
	sta price
	jsr j_printbcd
	jsr j_primm  ;b'gp.\n\x00'
	.byte "gp.", $8d
	.byte 0
input_count:
	jsr j_primm  ;b'\nHOW MANY PACKS\nOF 25 WOULD\nYOU LIKE?\x00'
	.byte $8d
	.byte "HOW MANY PACKS", $8d
	.byte "OF 25 WOULD", $8d
	.byte "YOU LIKE?", 0
	jsr j_getnumber
	jsr print_newline
	lda bcdnum
	beq bye
	jsr decode_bcd_value
	sta hexnum
	lda #$00
	sta zp_attempts
	sed
try_spend:
	ldy #party_stat_gold
	sec
	lda party_stats + 1,y
	sbc price
	sta party_stats + 1,y
	lda party_stats,y
	sbc #$00
	sta party_stats,y
	bcc cannot_afford
	ldy #party_stat_food
	clc
	lda party_stats,y
	adc #$25
	sta party_stats,y
	dey
	lda party_stats,y
	adc #$00
	sta party_stats,y
	bcc @skip_overflow
	lda #$99
	sta party_stats,y
	sta party_stats + 1,y
@skip_overflow:
	inc zp_attempts
	dec hexnum
	bne try_spend
	cld
ask_more:
	jsr j_update_status
	jsr j_primm  ;b'\nTHANK YOU,\nANYTHING ELSE?\x00'
	.byte $8d
	.byte "THANK YOU,", $8d
	.byte "ANYTHING ELSE?", 0
	jsr input_char
	cmp #char_Y
	bne bye
	jmp input_count

bye:
	jsr j_primm  ;b'\nGOODBYE,\nCOME AGAIN!\n\x00'
	.byte $8d
	.byte "GOODBYE,", $8d
	.byte "COME AGAIN!", $8d
	.byte 0
	rts

cannot_afford:
	clc
	lda party_stats + 1,y
	adc price
	sta party_stats + 1,y
	lda party_stats,y
	adc #$00
	sta party_stats,y
	cld
	lda zp_attempts
	bne @partial_afford
	jsr j_primm  ;b'\nYOU CANNOT\nAFFORD ANY!\x00'
	.byte $8d
	.byte "YOU CANNOT", $8d
	.byte "AFFORD ANY!", 0
	jmp bye

@partial_afford:
	jsr j_primm  ;b'\nYOU CAN ONLY\nAFFORD \x00'
	.byte $8d
	.byte "YOU CAN ONLY", $8d
	.byte "AFFORD ", 0
	lda zp_attempts
	jsr encode_bcd_value
	jsr j_printbcd
	jsr j_primm  ;b' PACKS.\n\x00'
	.byte " PACKS.", $8d
	.byte 0
	jmp ask_more

price:
	.byte 0
location_table:
	.byte $00,$00,$00,$00,$01,$02,$00,$03
	.byte $00,$00,$04,$00,$05,$00,$00,$00
price_table:
	.byte $25,$40,$35,$20,$30

input_char:
	jsr j_waitkey
	beq input_char
	pha
	jsr j_console_out
	lda #char_enter
	jsr j_console_out
	pla
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

print_newline:
	lda #char_enter
	jsr j_console_out
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
	jsr j_console_out
	jmp @print_char

@done:
	rts

inc_ptr:
	inc ptr1
	bne :+
	inc ptr1 + 1
:	rts

string_table:
	.byte 0
	.byte "THE SAGE DELI", 0
	.byte "ADVENTURE FOOD", 0
	.byte "THE DRY GOODS", 0
	.byte "FOOD FOR THOUGHT", 0
	.byte "THE MARKET", 0
	.byte "SHAMAN", 0
	.byte "WINDRICK", 0
	.byte "DONNAR", 0
	.byte "MINTOL", 0
	.byte "MAX", 0

; unused
get_input:
	lda #char_question
	jsr j_console_out
	lda #$00
	sta zp_char_count
@get_char:
	jsr j_waitkey
	cmp #char_enter
	beq @got_input
	cmp #char_left_arrow
	beq @backspace
	cmp #char_space
	bcc @get_char
	ldx zp_char_count
	sta inbuffer,x
	jsr j_console_out
	inc zp_char_count
	lda zp_char_count
	cmp #$0f
	bcc @get_char
	bcs @got_input
@backspace:
	lda zp_char_count
	beq @get_char
	dec zp_char_count
	dec console_xpos
	lda #char_space
	jsr j_console_out
	dec console_xpos
	jmp @get_char

@got_input:
	ldx zp_char_count
	lda #char_space
@pad_spaces:
	sta inbuffer,x
	inx
	cpx #$06
	bcc @pad_spaces
	lda #char_enter
	jsr j_console_out
	rts

; unused
check_inline_keyword:
	pla
	sta ptr1
	pla
	sta ptr1 + 1
	ldy #$00
	sty zp_mismatches
	ldx #$ff
@next:
	inx
	inc ptr1
	bne :+
	inc ptr1 + 1
:	lda (ptr1),y
	beq @done
	cmp inbuffer,x
	beq @next
	inc zp_mismatches
	jmp @next

@done:
	lda ptr1 + 1
	pha
	lda ptr1
	pha
	lda zp_mismatches
	rts

; junk
	.byte $04,$20,$54,$08,$ee,$4f,$7d,$20
	.byte $db,$82,$10
