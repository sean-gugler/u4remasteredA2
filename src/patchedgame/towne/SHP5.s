	.include "uscii.i"
	.include "SHP5.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
current_location = $0a
party_size = $0f
curr_player = $d4
zp_price = $d8
zp_virtue_type = $d9
zp_virtue_amount = $da
zp_index = $ea
zp_count = $f0
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
console_xpos = $00ce
console_ypos = $00cf
diskid = $00d0
numdrives = $00d1
currdisk_drive1 = $00d2
currdisk_drive2 = $00d3
target_player = $00d5
hexnum = $00d6
bcdnum = $00d7
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
	jsr j_primm  ;b'\nWELCOME UNTO\n\x00'
	.byte $8d
	.byte "WELCOME UNTO", $8d
	.byte 0
	ldx current_location
	dex
	lda location_table,x
	sta zp_index
	dec zp_index
	jsr print_string
	jsr print_newline
	jsr print_newline
	clc
	lda zp_index
	adc #$0b
	jsr print_string
	jsr j_primm  ;b' SAYS:\nPEACE AND JOY BE\nWITH YOU FRIEND.\nARE YOU IN NEED\nOF HELP?\x00'
	.byte " SAYS:", $8d
	.byte "PEACE AND JOY BE", $8d
	.byte "WITH YOU FRIEND.", $8d
	.byte "ARE YOU IN NEED", $8d
	.byte "OF HELP?", 0
	jsr input_char
	cmp #char_Y
	beq menu
	jmp try_donate

menu:
	jsr print_newline
	clc
	lda zp_index
	adc #$0b
	jsr print_string
	jsr j_primm  ;b' SAYS:\nWE CAN PERFORM:\nA-CURING\nB-HEALING\nC-RESURRECTION\nYOUR NEED:\x00'
	.byte " SAYS:", $8d
	.byte "WE CAN PERFORM:", $8d
	.byte "A-CURING", $8d
	.byte "B-HEALING", $8d
	.byte "C-RESURRECTION", $8d
	.byte "YOUR NEED:", 0
	jsr input_char
	cmp #char_A
	bne :+
	jmp ask_cure

:	cmp #char_B
	bne :+
	jmp ask_heal

:	cmp #char_C
	bne :+
	jmp ask_resurrect

:	jmp try_donate

ask_cure:
	jsr ask_which_player
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Poison
	beq is_poisoned
	jsr j_primm  ;b'\nTHOU SUFFERS NOT\nFROM POISON!\n\x00'
	.byte $8d
	.byte "THOU SUFFERS NOT", $8d
	.byte "FROM POISON!", $8d
	.byte 0
	jmp ask_more

is_poisoned:
	jsr j_primm  ;b'\nA CURING WILL\nCOST THEE 100gp.\n\x00'
	.byte $8d
	.byte "A CURING WILL", $8d
	.byte "COST THEE 100gp.", $8d
	.byte 0
	lda gold_hi
	beq @no_money
	jmp try_cure

@no_money:
	jsr j_primm  ;b'\nI SEE BY THY\nPURSE THAT THOU\nHAST NOT ENOUGH\nGOLD.\x00'
	.byte $8d
	.byte "I SEE BY THY", $8d
	.byte "PURSE THAT THOU", $8d
	.byte "HAST NOT ENOUGH", $8d
	.byte "GOLD.", 0
	jsr j_waitkey
	jsr j_primm  ;b'\nI WILL\nCURE THEE FOR\nFREE, BUT GIVE\nUNTO OTHERS WHEN\nEVER THOU MAY!\n\x00'
	.byte $8d
	.byte "I WILL", $8d
	.byte "CURE THEE FOR", $8d
	.byte "FREE, BUT GIVE", $8d
	.byte "UNTO OTHERS WHEN", $8d
	.byte "EVER THOU MAY!", $8d
	.byte 0
	jmp do_cure

try_cure:
	lda #$01
	jsr ask_pay
do_cure:
	jsr j_get_stats_ptr
	ldy #player_status
	lda #status_Good
	sta (ptr1),y
	jsr special_fx
	jsr j_update_status
	jmp ask_more

ask_heal:
	jsr ask_which_player
	jsr j_primm  ;b'\nA HEALING WILL\nCOST THEE 200gp.\n\x00'
	.byte $8d
	.byte "A HEALING WILL", $8d
	.byte "COST THEE 200gp.", $8d
	.byte 0
	lda gold_hi
	cmp #$02
	bcs try_heal
	jmp cannot_afford

try_heal:
	lda #$02
	jsr ask_pay
	jsr j_get_stats_ptr
	ldy #player_max_hp_hi
	lda (ptr1),y
	ldy #player_cur_hp_hi
	sta (ptr1),y
	ldy #player_max_hp_lo
	lda (ptr1),y
	ldy #player_cur_hp_lo
	sta (ptr1),y
	jsr special_fx
	jsr j_update_status
	jmp ask_more

ask_resurrect:
	jsr ask_which_player
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Dead
	beq is_dead
	jsr j_primm  ;b'\nTHOU ART NOT\nDEAD FOOL!\n\x00'
	.byte $8d
	.byte "THOU ART NOT", $8d
	.byte "DEAD FOOL!", $8d
	.byte 0
	jmp ask_more

is_dead:
	jsr j_primm  ;b'\nRESURECTION WILL\nCOST THEE 300gp.\n\x00'
	.byte $8d
	.byte "RESURECTION WILL", $8d
	.byte "COST THEE 300gp.", $8d
	.byte 0
	lda gold_hi
	cmp #$03
	bcs do_resurrect
cannot_afford:
	jsr j_primm  ;b'\nI SEE BY THY\nPURSE THAT THOU\nHAST NOT ENOUGH\nGOLD. I CANNOT\nAID THEE.\n\x00'
	.byte $8d
	.byte "I SEE BY THY", $8d
	.byte "PURSE THAT THOU", $8d
	.byte "HAST NOT ENOUGH", $8d
	.byte "GOLD. I CANNOT", $8d
	.byte "AID THEE.", $8d
	.byte 0
	jmp ask_more

do_resurrect:
	lda #$03
	jsr ask_pay
	jsr j_get_stats_ptr
	ldy #player_status
	lda #status_Good
	sta (ptr1),y
	jsr special_fx
	jsr j_update_status
	jmp ask_more

ask_which_player:
	jsr print_newline
	clc
	lda zp_index
	adc #$0b
	jsr print_string
	jsr j_primm  ;b' ASKS:\nWHO IS IN NEED?\x00'
	.byte " ASKS:", $8d
	.byte "WHO IS IN NEED?", 0
	jsr j_getplayernum
	bne @validate
	jsr j_primm  ;b'\nNO ONE?\n\x00'
	.byte $8d
	.byte "NO ONE?", $8d
	.byte 0
	pla
	pla
	jmp ask_more

@validate:
	cmp party_size
	bcc @valid
	beq @valid
	jmp ask_which_player

@valid:
	rts

ask_more:
	jsr print_newline
	clc
	lda zp_index
	adc #$0b
	jsr print_string
	jsr j_primm  ;b' ASKS:\nDO YOU NEED\nMORE HELP?\x00'
	.byte " ASKS:", $8d
	.byte "DO YOU NEED", $8d
	.byte "MORE HELP?", 0
	jsr input_char
	cmp #char_Y
	bne try_donate
	jmp menu

try_donate:
	lda #$01
	sta curr_player
	jsr j_get_stats_ptr
	ldy #$18
	lda (ptr1),y
	cmp #$04
	bcs ask_donate
bye:
	jsr print_newline
	clc
	lda zp_index
	adc #$0b
	jsr print_string
	jsr j_primm  ;b' SAYS:\nMAY THY LIFE\nBE GUARDED BY\nTHE POWERS OF\nGOOD.\n\x00'
	.byte " SAYS:", $8d
	.byte "MAY THY LIFE", $8d
	.byte "BE GUARDED BY", $8d
	.byte "THE POWERS OF", $8d
	.byte "GOOD.", $8d
	.byte 0
	rts

ask_donate:
	jsr j_primm  ;b'\nART THOU WILLING\nTO GIVE 100pts\nOF THY BLOOD TO\nAID OTHERS?\x00'
	.byte $8d
	.byte "ART THOU WILLING", $8d
	.byte "TO GIVE 100pts", $8d
	.byte "OF THY BLOOD TO", $8d
	.byte "AID OTHERS?", 0
	jsr input_char
	cmp #char_N
	beq no_donate
	cmp #char_Y
	beq yes_donate
	jmp ask_donate

no_donate:
	ldy #virtue_sacrifice
	lda #$05
	jsr dec_virtue
	jmp bye

yes_donate:
	ldy #virtue_sacrifice
	lda #$05
	jsr inc_virtue
	jsr j_primm  ;b'\nTHOU ART A\nGREAT HELP, WE\nARE IN DIRE\nNEED!\n\x00'
	.byte $8d
	.byte "THOU ART A", $8d
	.byte "GREAT HELP, WE", $8d
	.byte "ARE IN DIRE", $8d
	.byte "NEED!", $8d
	.byte 0
	jsr j_get_stats_ptr
	ldy #$18
	lda (ptr1),y
	sec
	sed
	sbc #$01
	cld
	sta (ptr1),y
	lda #$0a
	sta zp_index
:	jsr j_update_view
	dec zp_index
	bne :-
	jmp bye

ask_pay:
	sta zp_price
	jsr j_primm  ;b'\nWILT THOU PAY?\x00'
	.byte $8d
	.byte "WILT THOU PAY?", 0
	jsr input_char
	cmp #char_Y
	beq deduct_gold
	pla
	pla
	jsr j_primm  ;b'\nTHEN I CANNOT\nAID THEE.\n\x00'
	.byte $8d
	.byte "THEN I CANNOT", $8d
	.byte "AID THEE.", $8d
	.byte 0
	jmp ask_more

deduct_gold:
	sed
	sec
	lda gold_hi
	sbc zp_price
	sta gold_hi
	cld
	rts

special_fx:
	jsr invert_view
	jsr invert_player
	lda #sound_spell_effect
	ldx #$c0
	jsr j_playsfx
	jsr invert_player
	jsr invert_view
	rts

unused:
	.byte 0
location_table:
	.byte $01,$02,$03,$04,$05,$06,$07,$08
	.byte $00,$00,$09,$00,$00,$00,$00,$0a
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

; unused
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

; unused
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
	.byte "THE ROYAL HEALER", 0
	.byte "THE TRUTH HEALER", 0
	.byte "THE LOVE HEALER", 0
	.byte "COURAGE HEALER", 0
	.byte "THE HEALER", 0
	.byte "WOUND HEALING", 0
	.byte "HEAL AND HEALTH", 0
	.byte "JUST HEALING", 0
	.byte "THE MYSTIC HEAL", 0
	.byte "THE HEALER SHOP", 0
	.byte "PENDRAGON", 0
	.byte "STARFIRE", 0
	.byte "SALLE'", 0
	.byte "WINDWALKER", 0
	.byte "HARMONY", 0
	.byte "CELEST", 0
	.byte "TRIPLET", 0
	.byte "JUSTIN", 0
	.byte "SPIRAN", 0
	.byte "QUAT", 0

; unused
invert_all_players:
	lda party_size
	sta curr_player
@next:
	jsr invert_player
	dec curr_player
	bne @next
	rts

invert_player:
	lda curr_player
	asl
	asl
	asl
	tax
	lda #$08
	sta zp_count
@next_row:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	ldy #$26
@next_col:
	lda (ptr1),y
	eor #$7f
	sta (ptr1),y
	dey
	cpy #$18
	bcs @next_col
	inx
	dec zp_count
	bne @next_row
	rts

invert_view:
	ldx #$08
@next_row:
	lda bmplineaddr_lo,x
	sta ptr2
	lda bmplineaddr_hi,x
	sta ptr2 + 1
	ldy #$16
@next_col:
	lda (ptr2),y
	eor #$ff
	sta (ptr2),y
	dey
	bne @next_col
	inx
	cpx #$b8
	bcc @next_row
	rts

inc_virtue:
	sta zp_virtue_type
	sed
	clc
	lda party_stats,y
	beq @store
	adc zp_virtue_type
	bcc @store
	lda #$99
@store:
	sta party_stats,y
	cld
	rts

dec_virtue:
	sta zp_virtue_amount
	sty zp_virtue_type
	lda party_stats,y
	beq @lost_an_eighth
@continue:
	sed
	sec
	sbc zp_virtue_amount
	beq @underflow
	bcs @store
@underflow:
	lda #$01
@store:
	sta party_stats,y
	cld
	rts

@lost_an_eighth:
	jsr j_primm
	.byte $8d
	.byte "THOU HAST LOST", $8d
;	.byte "AN EIGHTH!", $8d
;	.byte 0
;	ldy zp_virtue_type
;	lda #$99
;	jmp @continue

; junk "RI AM VERY SO"
;	.byte $52,$49,$20,$41,$4d,$20,$56,$45
;	.byte $52,$59,$20,$53,$4f

; NOTE: file length field is truncated in 4am source disks by 20 bytes.
; It cuts off after "LOST" even though remainder is present in full sector.
