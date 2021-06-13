	.include "uscii.i"
	.include "SHP4.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
current_location = $0a
console_xpos = $ce
console_ypos = $cf
bcdnum = $d7
zpd8 = $d8
zpd9 = $d9
zpda = $da
zp_index = $ea
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
diskid = $00d0
numdrives = $00d1
currdisk_drive1 = $00d2
currdisk_drive2 = $00d3
curr_player = $00d4
target_player = $00d5
hexnum = $00d6
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
	jsr j_primm  ;b'\nA BLIND WOMAN\nTURNS TO YOU AND\nSAYS: WELCOME TO\n\x00'
	.byte $8d
	.byte "A BLIND WOMAN", $8d
	.byte "TURNS TO YOU AND", $8d
	.byte "SAYS: WELCOME TO", $8d
	.byte 0
	ldx current_location
	dex
	lda location_table,x
	sta zp_index
	dec zp_index
	jsr print_string
	jsr j_primm  ;b'\n\nI AM \x00'
	.byte $8d, $8d, "I AM ", 0
	clc
	lda zp_index
	adc #$05
	jsr print_string
	jsr j_primm  ;b'\nARE YOU IN NEED\nOF REAGENTS?\x00'
	.byte $8d
	.byte "ARE YOU IN NEED", $8d
	.byte "OF REAGENTS?", 0
	jsr input_char
	cmp #char_Y
	beq buy_menu
	jsr j_clearstatwindow
	jsr j_update_status
	jsr print_newline
	clc
	lda zp_index
	adc #$05
	jsr print_string
	jsr j_primm  ;b' SAYS:\nPERHAPS ANOTHER\nTIME THEN....\nAND SLOWLY\nTURNS AWAY.\n\x00'
	.byte " SAYS:", $8d
	.byte "PERHAPS ANOTHER", $8d
	.byte "TIME THEN....", $8d
	.byte "AND SLOWLY", $8d
	.byte "TURNS AWAY.", $8d
	.byte 0
	rts

buy_menu:
	jsr j_primm  ;b'\nVERY WELL,\n\x00'
	.byte $8d
	.byte "VERY WELL,", $8d
	.byte 0
	jsr j_primm  ;b'I HAVE\nA-SULFEROUS ASH\nB-GINSENG\nC-GARLIC\nD-SPIDER SILK\nE-BLOOD MOSS\nF-BLACK PEARL\nYOUR INTEREST:\x00'
	.byte "I HAVE", $8d
	.byte "A-SULFEROUS ASH", $8d
	.byte "B-GINSENG", $8d
	.byte "C-GARLIC", $8d
	.byte "D-SPIDER SILK", $8d
	.byte "E-BLOOD MOSS", $8d
	.byte "F-BLACK PEARL", $8d
	.byte "YOUR INTEREST:", 0
	jsr display_owned
	jsr input_char
	pha
	jsr j_clearstatwindow
	jsr j_update_status
	pla
	sec
	sbc #char_A
	cmp #$06
	bcc @print_price
	jmp bye

@print_price:
	sta reagent_to_buy
	jsr j_primm  ;b'\nVERY WELL,\nWE SELL\n\x00'
	.byte $8d
	.byte "VERY WELL,", $8d
	.byte "WE SELL", $8d
	.byte 0
	clc
	lda reagent_to_buy
	adc #$09
	jsr print_string
	jsr j_primm  ;b'\nFOR \x00'
	.byte $8d
	.byte "FOR ", 0
	lda zp_index
	asl
	asl
	asl
	adc reagent_to_buy
	tay
	lda price_table,y
	sta reagent_price
	jsr j_printbcd
	lda reagent_price
	jsr decode_bcd_value
	sta reagent_price
	jsr j_primm  ;b'gp.\n\nHOW MANY WOULD\nYOU LIKE,\n(0-9)?\x00'
	.byte "gp.", $8d
	.byte $8d
	.byte "HOW MANY WOULD", $8d
	.byte "YOU LIKE,", $8d
	.byte "(0-9)?", 0
	jsr input_digit
	bne @print_cost
	jsr j_primm  ;b'\nI SEE, THEN\n\x00'
	.byte $8d
	.byte "I SEE, THEN", $8d
	.byte 0
	jmp more

@print_cost:
	sta how_many
	tax
	lda reagent_price
	jsr j_mulax
	jsr encode_bcd_value
	sta reagent_price
	jsr j_primm  ;b'\nVERY GOOD, THAT\nWILL BE \x00'
	.byte $8d
	.byte "VERY GOOD, THAT", $8d
	.byte "WILL BE ", 0
	lda reagent_price
	jsr j_printbcd
	jsr j_primm  ;b'g.p.\n\x00'
	.byte "g.p.", $8d
	.byte 0
@make_offer:
	jsr j_primm  ;b'\nYOU PAY:\x00'
	.byte $8d
	.byte "YOU PAY:", 0
	jsr j_getnumber
	lda bcdnum
	cmp reagent_price
	bcs @spend
	cmp #$00
	bne @penalty
	jsr j_primm  ;b'\nHEY, COME ON\nLETS HEAR THE\nGOLD DROP!\n\x00'
	.byte $8d
	.byte "HEY, COME ON", $8d
	.byte "LETS HEAR THE", $8d
	.byte "GOLD DROP!", $8d
	.byte 0
	jmp @make_offer

@penalty:
	ldy #virtue_honesty
	lda #$04
	jsr dec_virtue
	ldy #virtue_justice
	lda #$04
	jsr dec_virtue
	ldy #virtue_honor
	lda #$04
	jsr dec_virtue
@spend:
	lda bcdnum
	jsr try_spend
	bpl @do_spend
	jsr j_primm  ;b'\nIT SEEMS YOU\nHAVE NOT THE\nGOLD!\n\x00'
	.byte $8d
	.byte "IT SEEMS YOU", $8d
	.byte "HAVE NOT THE", $8d
	.byte "GOLD!", $8d
	.byte 0
	jmp more

@do_spend:
	ldy #virtue_honesty
	lda #$02
	jsr inc_virtue
	ldy #virtue_justice
	lda #$02
	jsr inc_virtue
	ldy #virtue_honor
	lda #$02
	jsr inc_virtue
	ldy reagent_to_buy
	sed
	clc
	lda reagents,y
	clc
	adc how_many
	bcc @overflow
	lda #$99
@overflow:
	sta reagents,y
	cld
	jsr j_primm  ;b'\nVERY GOOD,\n\x00'
	.byte $8d
	.byte "VERY GOOD,", $8d
	.byte 0
	jmp more

more:
	jsr j_update_status
	jsr j_primm  ;b'ANYTHING ELSE?\x00'
	.byte "ANYTHING ELSE?", 0
	jsr input_char
	cmp #char_Y
	bne bye
	jmp buy_menu

bye:
	jsr j_primm  ;b'\nSHE SAYS:\nPERHAPS ANOTHER\nTIME.... AND\nSLOWLY TURNS\nAWAY.\n\x00'
	.byte $8d
	.byte "SHE SAYS:", $8d
	.byte "PERHAPS ANOTHER", $8d
	.byte "TIME.... AND", $8d
	.byte "SLOWLY TURNS", $8d
	.byte "AWAY.", $8d
	.byte 0
	rts

location_table:
	.byte $00,$00,$00,$00,$01,$00,$00,$00
	.byte $00,$00,$02,$00,$03,$04,$00,$00
unused_stock_table:
	.byte $01,$02,$03,$06
	.byte $01,$02,$03,$05
	.byte $01,$02,$03,$04
	.byte $01,$02,$03,$00
price_table:
	.byte $02,$05,$06,$03,$06,$09,$00,$00
	.byte $02,$04,$09,$06,$04,$08,$00,$00
	.byte $03,$04,$02,$09,$06,$07,$00,$00
	.byte $06,$07,$09,$09,$09,$01,$00,$00
reagent_price:
	.byte 0
reagent_type:
	.byte 0
reagent_amount:
	.byte 0
reagent_to_buy:
	.byte 0
how_many:
	.byte 0

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
	.byte "MAGICAL HERBS", 0
	.byte "HERBS AND SPICE", 0
	.byte "THE MAGICS", 0
	.byte "MAGIC MENTAR", 0
	.byte "MARGOT", 0
	.byte "SASHA", 0
	.byte "SHIELA", 0
	.byte "SHANNON", 0
	.byte "SULFER ASH", 0
	.byte "GINSENG", 0
	.byte "GARLIC", 0
	.byte "SPIDER SILK", 0
	.byte "BLOOD MOSS", 0
	.byte "BLACK PEARL", 0
	.byte "NIGHTSHADE", 0
	.byte "MANDRAKE", 0

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
	brk
saved_cursor_y:
	brk

display_owned:
	jsr j_clearstatwindow
	jsr save_cursor
	ldx #$1a
	ldy #$00
	sty reagent_type
	jsr j_primm_xy ;b'>REAGENTS<\x00'
	.byte $1e,"REAGENTS",$1d,$00
@next:
	clc
	lda reagent_type
	adc #$38
	tay
	lda party_stats,y
	beq @skip
	sta reagent_amount
	inc console_ypos
	lda #$18
	sta console_xpos
	clc
	lda reagent_type
	adc #char_A
	jsr j_console_out
	lda reagent_amount
	cmp #$10
	bcs @two_digit
	lda #char_hyphen
	jsr j_console_out
	lda reagent_amount
	jsr j_printdigit
	jmp :+

@two_digit:
	jsr j_printbcd
:	lda #char_hyphen
	jsr j_console_out
	clc
	lda reagent_type
	adc #$09
	jsr print_string
@skip:
	inc reagent_type
	lda reagent_type
	cmp #$08
	bcc @next
	jsr restore_cursor
	rts

try_spend:
	sta zpd8
	sed
	ldy #party_stat_gold
	lda party_stats + 1,y
	sec
	sbc zpd8
	sta party_stats + 1,y
	lda party_stats,y
	sbc #$00
	sta party_stats,y
	bcs @paid
	clc
	lda party_stats + 1,y
	adc zpd8
	sta party_stats + 1,y
	lda party_stats,y
	adc #$00
	sta party_stats,y
	lda #$ff
	cld
	rts

@paid:
	lda #$00
	cld
	rts

inc_virtue:
	sta zpd9
	sed
	clc
	lda party_stats,y
	beq @store
	adc zpd9
	bcc @store
	lda #$99
@store:
	sta party_stats,y
	cld
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
	jsr j_primm  ;b'\nTHOU HAST LOST\nAN EIGHTH!\n\x00'
	.byte $8d
	.byte "THOU HAST LOST", $8d
	.byte "AN EIGHTH!", $8d
	.byte 0
	ldy zpd9
	lda #$99
	jmp @continue

input_digit:
	jsr j_waitkey
	beq input_digit
	sec
	sbc #char_0
	cmp #$0a
	bcc :+
	lda #$00
:	pha
	jsr j_printdigit
	lda #char_enter
	jsr j_console_out
	pla
	cmp #$00
	rts

; junk
	.byte $ff,$00,$00,$ff,$ff,$00,$00,$ff
	.byte $ff,$00,$00
