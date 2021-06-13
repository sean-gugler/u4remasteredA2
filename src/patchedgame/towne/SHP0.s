	.include "uscii.i"
	.include "SHP0.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
current_location = $0a
console_xpos = $ce
console_ypos = $cf
zp_item_type = $d8
zp_display_pos = $d9
;zp_char_count = $ea
;zp_mismatches = $f0
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
bcdnum = $00d7
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
@buy_or_sell:
	jsr print_newline
	clc
	lda zp_shop_num
	adc #$07
	jsr print_string
	jsr j_primm  ;b' SAYS:\nWELCOME FRIEND,\nART THOU HERE TO\n\x00'
	.byte " SAYS:", $8d
	.byte "WELCOME FRIEND,", $8d
	.byte "ART THOU HERE TO", $8d
	.byte 0
	jsr j_primm  ;b'BUY OR SELL?\x00'
	.byte "BUY OR SELL?", 0
	jsr input_char
	cmp #char_B
	beq @buy
	cmp #char_S
	bne @buy_or_sell
	jmp sell

@buy:
	jsr j_primm  ;b'\nVERY GOOD,\n\x00'
	.byte $8d
	.byte "VERY GOOD,", $8d
	.byte 0
buy_menu:
	jsr j_primm  ;b'WE HAVE:\nA-NOTHING\n\x00'
	.byte "WE HAVE:", $8d
	.byte "A-NOTHING", $8d
	.byte 0
	lda #$00
	sta zp_inv_num
@next_item:
	lda zp_shop_num
	asl
	asl
	adc zp_inv_num
	tay
	lda inventory,y
	sta zp_item_type
	clc
	adc #char_A
	jsr j_console_out
	lda #char_hyphen
	jsr j_console_out
	lda zp_item_type
	clc
	adc #$0d
	jsr print_string
	jsr j_primm  ;b'S\n\x00'
	.byte "S", $8d
	.byte 0
	inc zp_inv_num
	lda zp_inv_num
	cmp #$04
	bcc @next_item

; prompt
	jsr j_primm  ;b'YOUR INTEREST?\x00'
	.byte "YOUR INTEREST?", 0
	jsr display_owned
	jsr input_char
	pha
	jsr j_clearstatwindow
	jsr j_update_status
	pla
	sec
	sbc #char_A
	bne :+
	jmp bye

:	sta zp_item_type
	jsr print_newline
	lda #$03
	sta zp_inv_num
@find_stock:
	lda zp_shop_num
	asl
	asl
	adc zp_inv_num
	tay
	lda inventory,y
	cmp zp_item_type
	beq @found
	dec zp_inv_num
	bpl @find_stock
	jmp buy_menu

@found:
	lda zp_item_type
	clc
	adc #$1d
	jsr print_string
@ask_buy:
	jsr j_primm  ;b'\nWOULD YOU LIKE\nTO BUY ONE?\x00'
	.byte $8d
	.byte "WOULD YOU LIKE", $8d
	.byte "TO BUY ONE?", 0
	jsr input_char
	pha
	jsr print_newline
	pla
	cmp #char_Y
	beq try_spend
	cmp #char_N
	bne @ask_buy
	jsr j_primm  ;b'TOO BAD.\n\x00'
	.byte "TOO BAD.", $8d
	.byte 0
@more:
	jsr j_primm  ;b'ANYTHING ELSE?\x00'
	.byte "ANYTHING ELSE?", 0
	jsr input_char
	cmp #char_Y
	bne :+
	jmp buy_menu

:	cmp #char_N
	bne @more
bye:
	jsr print_newline
	clc
	lda zp_shop_num
	adc #$07
	jsr print_string
	jsr j_primm  ;b' SAYS:\nFARE THEE WELL!\n\x00'
	.byte " SAYS:", $8d
	.byte "FARE THEE WELL!", $8d
	.byte 0
	rts

try_spend:
	lda zp_item_type
	asl
	tay
	lda price,y
	sta payment
	lda price + 1,y
	sta payment + 1
	ldy #party_stat_gold
	sed
	sec
	lda party_stats + 1,y
	sbc payment + 1
	lda party_stats,y
	sbc payment
	cld
	bcs do_spend
	jsr j_primm  ;b'\nI FEAR YOU\nHAVE NOT THE\nFUNDS, PERHAPS\nSOMETHING ELSE.\n\x00'
	.byte $8d
	.byte "I FEAR YOU", $8d
	.byte "HAVE NOT THE", $8d
	.byte "FUNDS, PERHAPS", $8d
	.byte "SOMETHING ELSE.", $8d
	.byte 0
	jmp buy_menu

payment:
	.byte $00,$00

do_spend:
	sed
	sec
	lda party_stats + 1,y
	sbc payment + 1
	sta party_stats + 1,y
	lda party_stats,y
	sbc payment
	sta party_stats,y
	clc
	ldy zp_item_type
	lda weapons,y
	adc #$01
	bcs :+
	sta weapons,y
:	cld
	jsr j_update_status
	clc
	lda zp_shop_num
	adc #$07
	jsr print_string
	jsr j_primm  ;b' SAYS:\nA FINE CHOICE!\nANYTHING ELSE?\n\x00'
	.byte " SAYS:", $8d
	.byte "A FINE CHOICE!", $8d
	.byte "ANYTHING ELSE?", $8d
	.byte 0
	jmp buy_menu

sell:
	jsr j_primm  ;b'\nEXCELLENT, WHAT\nWOULDST THOU\nLIKE TO SELL?\x00'
	.byte $8d
	.byte "EXCELLENT, WHAT", $8d
	.byte "WOULDST THOU", $8d
	.byte "LIKE TO SELL?", 0
sell_menu:
	jsr display_owned
	jsr input_char
	pha
	jsr j_clearstatwindow
	jsr j_update_status
	pla
	sec
	sbc #char_A
	sta zp_item_type
	beq @bye
	cmp #$10
	bcs @bye
	tay
	lda weapons,y
	bne @make_offer
	jsr j_primm  ;b'\nTHOU DOST NOT\nOWN THAT.\nWHAT ELSE MIGHT\nYOU SELL?\x00'
	.byte $8d
	.byte "THOU DOST NOT", $8d
	.byte "OWN THAT.", $8d
	.byte "WHAT ELSE MIGHT", $8d
	.byte "YOU SELL?", 0
	jmp sell_menu

@bye:
	jmp bye

@make_offer:
	lda zp_item_type
	asl
	tay
	lda price,y
	jsr decode_bcd_value
	lsr
	jsr encode_bcd_value
	sta payment
	lda price + 1,y
	jsr decode_bcd_value
	lsr
	jsr encode_bcd_value
	sta payment + 1
	jsr j_primm  ;b'\nI WILL GIVE YOU\n\x00'
	.byte $8d
	.byte "I WILL GIVE YOU", $8d
	.byte 0
	lda payment
	beq :+
	jsr j_printbcd
:	lda payment + 1
	jsr j_printbcd
	jsr j_primm  ;b'gp FOR THAT.\n\x00'
	.byte "gp FOR THAT.", $8d
	.byte 0
	lda zp_item_type
	clc
	adc #$0d
	jsr print_string
	jsr print_newline
@confirm:
	jsr j_primm  ;b'DEAL?\x00'
	.byte "DEAL?", 0
	jsr input_char
	cmp #char_Y
	beq @sell_item
	cmp #char_N
	bne @confirm
	jsr j_primm  ;b'HMMPH, WHAT\nELSE THEN?\x00'
	.byte "HMMPH, WHAT", $8d
	.byte "ELSE THEN?", 0
	jmp sell_menu

@sell_item:
	sed
	clc
	ldy #$13
	lda party_stats + 1,y
	adc payment + 1
	sta party_stats + 1,y
	lda party_stats,y
	adc payment
	sta party_stats,y
	bcc @skip_overflow
	lda #$99
	sta party_stats,y
	sta party_stats + 1,y
@skip_overflow:
	sec
	ldy zp_item_type
	lda weapons,y
	sbc #$01
	sta weapons,y
	cld
	jsr j_update_status
	jsr j_primm  ;b'FINE, WHAT\nELSE?\x00'
	.byte "FINE, WHAT", $8d
	.byte "ELSE?", 0
	jmp sell_menu

location_table:
	.byte $00,$00,$00,$00,$00,$01,$02,$00
	.byte $03,$04,$00,$00,$00,$05,$06,$00

inventory:
	.byte $01,$02,$03,$06
	.byte $05,$06,$08,$0a
	.byte $04,$0a,$0b,$0c
	.byte $04,$05,$06,$07
	.byte $08,$09,$0d,$0e
	.byte $02,$03,$07,$09

price:
	.byte $00,$00
	.byte $00,$20
	.byte $00,$02
	.byte $00,$25
	.byte $01,$00
	.byte $02,$25
	.byte $03,$00
	.byte $02,$50
	.byte $06,$00
	.byte $00,$05
	.byte $03,$50
	.byte $15,$00
	.byte $25,$00
	.byte $20,$00
	.byte $50,$00
	.byte $70,$00

input_char:
	jsr j_waitkey
	beq input_char
	pha
	jsr j_console_out
	lda #$8d
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
	lda #$8d
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
	.byte "WINDSOR WEAPONRY", 0
	.byte "WILLARD'S", $8d
	.byte "WEAPONRY", 0
	.byte "THE IRON WORKS", 0
	.byte "DUELLING WEAPONS", 0
	.byte "HOOK'S ARMS", 0
	.byte "VILLAGE ARMS", 0
	.byte "WINSTON", 0
	.byte "WILLARD", 0
	.byte "PETER", 0
	.byte "JUMAR", 0
	.byte "HOOK", 0
	.byte "WENDY", 0
	.byte "HANDS", 0
	.byte "STAFF", 0
	.byte "DAGGER", 0
	.byte "SLING", 0
	.byte "MACE", 0
	.byte "AXE", 0
	.byte "SWORD", 0
	.byte "BOW", 0
	.byte "CROSSBOW", 0
	.byte "FLAMING OIL", 0
	.byte "HALBERD", 0
	.byte "MAGIC AXE", 0
	.byte "MAGIC SWORD", 0
	.byte "MAGIC BOW", 0
	.byte "MAGIC WAND", 0
	.byte "MYSTIC SWORD", 0
	.byte "HANDS", $8d
	.byte 0
	.byte "WE ARE THE ONLY", $8d
	.byte "STAFF MAKERS IN", $8d
	.byte "BRITANNIA, YET", $8d
	.byte "SELL THEM FOR", $8d
	.byte "ONLY 20gp.", $8d
	.byte 0
	.byte "WE SELL THE", $8d
	.byte "MOST DEADLY OF", $8d
	.byte "DAGGERS, A", $8d
	.byte "BARGAIN AT", $8d
	.byte "ONLY 2gp EACH.", $8d
	.byte 0
	.byte "OUR SLINGS ARE", $8d
	.byte "MADE FROM ONLY", $8d
	.byte "THE FINEST GUT", $8d
	.byte "AND LEATHER,", $8d
	.byte "'TIS YOURS", $8d
	.byte "FOR 25gp.", $8d
	.byte 0
	.byte "THESE MACES HAVE", $8d
	.byte "A HARDENED SHAFT", $8d
	.byte "AND A 5lb HEAD,", $8d
	.byte "FAIRLY PRICED", $8d
	.byte "AT 100gp.", $8d
	.byte 0
	.byte "NOTICE THE FINE", $8d
	.byte "WORKMANSHIP ON", $8d
	.byte "THIS AXE, YOU'LL", $8d
	.byte "AGREE 225gp IS", $8d
	.byte "A GOOD PRICE.", $8d
	.byte 0
	.byte "THE FINE WORK", $8d
	.byte "ON THESE SWORDS", $8d
	.byte "WILL BE THE", $8d
	.byte "DREAD OF THY", $8d
	.byte "FOES, FOR 300gp.", $8d
	.byte 0
	.byte "OUR BOWS ARE", $8d
	.byte "MADE OF FINEST", $8d
	.byte "YEW, AND THE", $8d
	.byte "ARROWS WILLOW, A", $8d
	.byte "STEAL AT 250gp.", $8d
	.byte 0
	.byte "CROSSBOWS MADE", $8d
	.byte "BY IOLO THE BARD", $8d
	.byte "ARE THE FINEST", $8d
	.byte "IN THE WORLD,", $8d
	.byte "YOURS FOR 600gp.", $8d
	.byte 0
	.byte "FLASKS OF OIL", $8d
	.byte "MAKE GREAT", $8d
	.byte "WEAPONS AND", $8d
	.byte "CREATE A WALL", $8d
	.byte "OF FIRE TOO,", $8d
	.byte "5gp EACH.", $8d
	.byte 0
	.byte "A HALBERD IS", $8d
	.byte "A MIGHTY WEAPON", $8d
	.byte "TO ATTACK OVER", $8d
	.byte "OBSTACLES; A", $8d
	.byte "MUST AND", $8d
	.byte "ONLY 350gp.", $8d
	.byte 0
	.byte "THIS MAGICAL AXE", $8d
	.byte "CAN BE THROWN AT", $8d
	.byte "THY ENEMY AND", $8d
	.byte "WILL THEN", $8d
	.byte "RETURN, ALL FOR", $8d
	.byte "1500gp.", $8d
	.byte 0
	.byte "MAGICAL SWORDS", $8d
	.byte "SUCH AS THESE", $8d
	.byte "ARE RARE INDEED!", $8d
	.byte "I WILL PART WITH", $8d
	.byte "ONE FOR 2500gp.", $8d
	.byte 0
	.byte "A MAGICAL BOW", $8d
	.byte "WILL KEEP THY", $8d
	.byte "ENEMIES FAR AWAY", $8d
	.byte "OR DEAD! A", $8d
	.byte "MUST FOR 2000gp!", $8d
	.byte 0
	.byte "THIS MAGIC WAND", $8d
	.byte "CASTS MIGHTY", $8d
	.byte "BLUE BOLTS TO", $8d
	.byte "STRIKE DOWN THY", $8d
	.byte "FOES, 5000gp.", $8d
	.byte 0
	.byte "MYSTIC SWORDS", $8d
	.byte "ARE AN UNKNOWN", $8d
	.byte 0
	.byte "HND", 0
	.byte "STF", 0
	.byte "DAG", 0
	.byte "SLN", 0
	.byte "MAC", 0
	.byte "AXE", 0
	.byte "SWD", 0
	.byte "BOW", 0
	.byte "XBO", 0
	.byte "OIL", 0
	.byte "HAL", 0
	.byte "+AX", 0
	.byte "+SW", 0
	.byte "+BO", 0
	.byte "WND", 0
	.byte "^SW", 0

; unused
get_input:
	lda #$bf
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

display_owned:
	jsr j_clearstatwindow
	jsr save_console_xy
	ldx #$1b
	ldy #$00
	sty zp_item_type
	sty zp_display_pos
	jsr j_primm_xy ;b'>WEAPONS<\x00'
	.byte $1f,"WEAPONS",$1d,$00
@next_row:
	lda zp_display_pos
	and #$08
	clc
	adc #$18
	sta console_xpos
	lda zp_display_pos
	and #$07
	sta console_ypos
	inc console_ypos
	lda zp_item_type
	beq @nothing
	clc
	adc #$20
	tay
	lda party_stats,y
	beq @next_item
	pha
	lda zp_item_type
	clc
	adc #char_A
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
	lda zp_item_type
	clc
	adc #$2d
	jsr print_string
	inc zp_display_pos
@next_item:
	inc zp_item_type
	lda zp_item_type
	cmp #$10
	bcc @next_row
	jsr restore_console_xy
	rts

@nothing:
	jsr j_primm  ;b'A-HANDS\x00'
	.byte "A-HANDS", 0
	inc zp_display_pos
	jmp @next_item

save_console_xy:
	lda console_xpos
	sta prev_console_x
	lda console_ypos
	sta prev_console_y
	rts

restore_console_xy:
	lda prev_console_x
	sta console_xpos
	lda prev_console_y
	sta console_ypos
	rts

prev_console_x:
	.byte 0
prev_console_y:
	.byte 0

; junk [ FIRE TOO,",$8]
;	.byte $20,$46,$49,$52,$45,$20,$54,$4f
;	.byte $4f,$2c,$22,$2c,$24,$38
