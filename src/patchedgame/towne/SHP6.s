	.include "uscii.i"
	.include "SHP6.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
player_xpos = $00
player_ypos = $01
current_location = $0a
player_transport = $0e
party_size = $0f
curr_player = $d4
zpd8 = $d8
zpda = $da
zp_shop_num = $ea
ptr1 = $fe
;ptr1 + 1 = $ff
;
; **** ZP POINTERS ****
;
;ptr1 = $fe
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
game_mode = $000b
dungeon_level = $000c
balloon_flying = $000d
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
zpd9 = $00d9
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
j_inn_combat = $4003
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
npc_can_move = $eec0
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
	lda player_transport
	cmp #$1f
	beq ask_lodging
	jsr j_primm  ;b'THE INNKEEPER\nSAYS: GET THAT\nHORSE OUT OF\nHERE!!!\n\x00'
	.byte "THE INNKEEPER", $8d
	.byte "SAYS: GET THAT", $8d
	.byte "HORSE OUT OF", $8d
	.byte "HERE!!!", $8d
	.byte 0
	rts

ask_lodging:
	jsr j_primm  ;b'\nTHE INNKEEPER\nSAYS: WELCOME TO\n\x00'
	.byte $8d
	.byte "THE INNKEEPER", $8d
	.byte "SAYS: WELCOME TO", $8d
	.byte 0
	ldx current_location
	dex
	lda location_table,x
	sta zp_shop_num
	dec zp_shop_num
	jsr print_string
	jsr j_primm  ;b'\n\nI AM \x00'
	.byte $8d
	.byte $8d
	.byte "I AM ", 0
	clc
	lda zp_shop_num
	adc #$08
	jsr print_string
	jsr j_primm  ;b'\nARE YOU IN NEED\nOF LODGING?\x00'
	.byte $8d
	.byte "ARE YOU IN NEED", $8d
	.byte "OF LODGING?", 0
	jsr input_char
	cmp #char_Y
	beq print_price
	jsr j_clearstatwindow
	jsr j_update_status
	jsr print_newline
	clc
	lda zp_shop_num
	adc #$08
	jsr print_string
	jsr j_primm  ;b' SAYS:\nTHEN YOU HAVE\nCOME TO THE\nWRONG PLACE!\nGOOD DAY.\n\x00'
	.byte " SAYS:", $8d
	.byte "THEN YOU HAVE", $8d
	.byte "COME TO THE", $8d
	.byte "WRONG PLACE!", $8d
	.byte "GOOD DAY.", $8d
	.byte 0
	rts

print_price:
	jsr print_newline
	clc
	lda zp_shop_num
	adc #$0f
	jsr print_string
	lda zp_shop_num
	cmp #$03     ;Minoc
	bne ask_pay
	jsr j_primm  ;b'\n1, 2 OR 3 BEDS?\x00'
	.byte $8d
	.byte "1, 2 OR 3 BEDS?", 0
	jsr input_char
	sec
	sbc #char_1
	cmp #$03
	bcs cancel
	tay
	ldx zp_shop_num
	lda hotel_bed_x,y
	sta table_bed_x,x
	lda hotel_bed_y,y
	sta table_bed_y,x
	lda hotel_price,y
	sta price,x
	jmp try_pay

ask_pay:
	jsr j_primm  ;b'\n\nTAKE IT?\x00'
	.byte $8d
	.byte $8d
	.byte "TAKE IT?", 0
	jsr input_char
	cmp #char_Y
	beq try_pay
cancel:
	jsr j_primm  ;b"\nYOU WON'T FIND\nA BETTER DEAL IN\nTHIS TOWNE!\n\x00"
	.byte $8d
	.byte "YOU WON'T FIND", $8d
	.byte "A BETTER DEAL IN", $8d
	.byte "THIS TOWNE!", $8d
	.byte 0
	rts

try_pay:
	ldx zp_shop_num
	lda price,x
	jsr dec_gold
	bpl @paid
	jsr j_primm  ;b"\nIF YOU CAN'T PAY\nYOU CAN'T STAY!\nGOOD BYE.\n\x00"
	.byte $8d
	.byte "IF YOU CAN'T PAY", $8d
	.byte "YOU CAN'T STAY!", $8d
	.byte "GOOD BYE.", $8d
	.byte 0
	rts

@paid:
	jsr j_update_status
	jsr j_primm  ;b'\nVERY GOOD, HAVE\nA PLEASANT\nNIGHT.\n\x00'
	.byte $8d
	.byte "VERY GOOD, HAVE", $8d
	.byte "A PLEASANT", $8d
	.byte "NIGHT.", $8d
	.byte 0
	jsr j_rand
	and #$03
	bne fall_asleep
	jsr j_primm  ;b"\nOH, AND DON'T\nMIND THE STRANGE\nNOISES, IT'S\nONLY RATS!\n\x00"
	.byte $8d
	.byte "OH, AND DON'T", $8d
	.byte "MIND THE STRANGE", $8d
	.byte "NOISES, IT'S", $8d
	.byte "ONLY RATS!", $8d
	.byte 0
fall_asleep:
	lda #$0a
	sta zpd8
:	jsr j_update_view
	dec zpd8
	bne :-
	ldx zp_shop_num
	lda table_bed_x,x
	sta player_xpos
	lda table_bed_y,x
	sta player_ypos
	lda #$0a
	sta zpd8
:	jsr j_update_view
	dec zpd8
	bne :-
	lda #tile_sleep
	sta player_transport
	lda #$32
	sta zpd8
:	jsr j_update_view
	dec zpd8
	bne :-
	lda #tile_walk
	sta player_transport
	lda party_size
	sta curr_player
@next_player:
	jsr is_alive
	bmi @skip
	ldy #player_status
	lda (ptr1),y
	cmp #status_Sleep
	bne @recover_hp
	lda #$c1     ;BUG: A should be G
	sta (ptr1),y
@recover_hp:
	lda #$32
	jsr rand_modulo
	adc #$32
	tax
	lda #$00
	sed
@dec:
	adc #$01
	dex
	bne @dec
	cld
	pha
	jsr inc_hp
	pla
	jsr inc_hp
@skip:
	dec curr_player
	bne @next_player
	jsr restore_mp
	lda #$01
	sta curr_player
	jsr is_alive
	bmi @not_attacked
	jsr j_rand
	and #$07
	bne @not_attacked
	jsr j_primm  ;b'\nIN THE MIDDLE\nOF THE NIGHT\nWHILE OUT FOR A\nSTROLL...\n\x00'
	.byte $8d
	.byte "IN THE MIDDLE", $8d
	.byte "OF THE NIGHT", $8d
	.byte "WHILE OUT FOR A", $8d
	.byte "STROLL...", $8d
	.byte 0
	jsr j_inn_combat
	jmp @morning

@not_attacked:
	lda zp_shop_num
	cmp #$05     ;Skara Brae
	bne @morning
	jsr j_rand
	and #$03
	bne @morning
	jsr j_primm  ;b'\nYOU WAKE TO AN\nEERIE NOISE!\n\x00'
	.byte $8d
	.byte "YOU WAKE TO AN", $8d
	.byte "EERIE NOISE!", $8d
	.byte 0
	ldx #$00
	lda #tile_ghost
	sta object_tile_type,x
	sta object_tile_sprite,x
	lda player_ypos
	sta object_ypos,x
	lda player_xpos
	sec
	sbc #$01
	sta object_xpos,x
	lda #$01
	sta npc_can_move,x
	lda #$10
	sta npc_dialogue,x
@morning:
	jsr j_update_view
	jsr j_primm  ;b'\nMORNING!\n\x00'
	.byte $8d
	.byte "MORNING!", $8d
	.byte 0
	rts

location_table:
	.byte $00,$00,$00,$00,$01,$02,$03,$00
	.byte $04,$05,$06,$00,$00,$00,$07,$00
table_bed_x:
	.byte $1c,$1d,$0a,$02,$1d,$1c,$19
table_bed_y:
	.byte $06,$06,$1a,$06,$02,$0b,$17
unused:
	.byte $01,$02,$03,$00
hotel_bed_x:
	.byte $02,$02,$08
hotel_bed_y:
	.byte $06,$02,$02
price:
	.byte $20,$15,$10,$30,$15,$05,$01
hotel_price:
	.byte $30,$60,$90

input_char:
	jsr j_waitkey
	beq input_char
	pha
	jsr j_console_out
	lda #char_enter
	jsr j_console_out
	pla
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
	.byte "THE HONEST INN", 0
	.byte "BRITANNIA MANOR", 0
	.byte "THE INN OF ENDS", 0
	.byte "WAYFARERS INN", 0
	.byte "HONORABLE INN", 0
	.byte "THE INN OF", $8d
	.byte "THE SPIRITS", 0
	.byte "THE SLEEP SHOP", 0
	.byte "SCATU", 0
	.byte "JASON", 0
	.byte "SMIRK", 0
	.byte "ESTRO", 0
	.byte "ZAJAC", 0
	.byte "TYRONE", 0
	.byte "TYMUS", 0
	.byte "WE HAVE A ROOM", $8d
	.byte "WITH 2 BEDS", $8d
	.byte "THAT RENTS FOR", $8d
	.byte "20gp.", 0
	.byte "WE HAVE A MODEST", $8d
	.byte "SIZED ROOM WITH", $8d
	.byte "1 BED FOR 15gp.", 0
	.byte "WE HAVE A VERY", $8d
	.byte "SECURE ROOM OF", $8d
	.byte "MODEST SIZE AND", $8d
	.byte "1 BED FOR 10gp.", 0
	.byte "WE HAVE THREE", $8d
	.byte "ROOMS AVAILABLE,", $8d
	.byte "A 1, 2 AND 3 BED", $8d
	.byte "ROOM FOR 30, 60", $8d
	.byte "AND 90gp EACH.", 0
	.byte "WE HAVE A SINGLE", $8d
	.byte "BED ROOM WITH", $8d
	.byte "A BACK DOOR", $8d
	.byte "FOR 15gp.", 0
	.byte "UNFORTUNATLY, I", $8d
	.byte "HAVE BUT ONLY", $8d
	.byte "A VERY SMALL", $8d
	.byte "ROOM WITH 1 BED,", $8d
	.byte "WORSE YET, IT IS", $8d
	.byte "HAUNTED! IF YOU", $8d
	.byte "DO WISH TO STAY", $8d
	.byte "IT COSTS 5gp.", 0
	.byte "ALL WE HAVE IS", $8d
	.byte "THAT COT OVER", $8d
	.byte "THERE, BUT IT IS", $8d
	.byte "COMFORTABLE, AND", $8d
	.byte "ONLY 1gp.", 0

dec_gold:
	sta zpd8
	sed
	ldy #party_stat_gold_hi
	lda party_stats + 1,y
	sec
	sbc zpd8
	sta party_stats + 1,y
	lda party_stats,y
	sbc #$00
	sta party_stats,y
	bcs @ok
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

@ok:
	lda #$00
	cld
	rts

inc_hp:
	sta zpda
	jsr j_get_stats_ptr
	ldy #player_cur_hp_lo
	sed
	clc
	lda (ptr1),y
	adc zpda
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

is_alive:
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Good
	beq @in_party
	cmp #status_Poison
	beq @in_party
	cmp #status_Sleep
	beq @in_party
@is_not:
	lda #$ff
	rts

@in_party:
	lda curr_player
	cmp party_size
	beq @is
	bcs @is_not
@is:
	lda #$00
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

restore_mp:
	lda party_size
	sta curr_player
@next_player:
	jsr is_alive
	bmi @skip
	ldy #player_class_index
	lda (ptr1),y
	sta zpd8
	ldy #player_intelligence
	lda (ptr1),y
	jsr decode_bcd_value
	asl
	ldx zpd8
	beq @add_mp
	dex
	beq @half
	dex
	beq @none
	dex
	beq @three_quarter
	dex
	beq @one_quarter
	dex
	beq @half
	dex
	beq @half
@none:
	lda #$00
	jmp @add_mp
@one_quarter:
	lsr
	lsr
	jmp @add_mp
@half:
	lsr
	jmp @add_mp
@three_quarter:
	lsr
	sta zpd8
	lsr
	adc zpd8
@add_mp:
	jsr encode_bcd_value
	ldy #$16
	sta (ptr1),y
@skip:
	dec curr_player
	bpl @next_player
	rts

; junk
	.byte $07,$f8,$18,$69,$01,$d8,$91,$fe
	.byte $c6,$d4,$10,$ab,$60,$0a
