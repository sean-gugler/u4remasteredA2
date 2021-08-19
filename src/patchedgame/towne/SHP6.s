	.include "uscii.i"

	.include "char.i"
	.include "map_objects.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "tiles.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


; --- Custom use of Zero Page

zp_amount = $d8
zp_class = $d8
zp_delay = $d8
zp_amount_hp = $da
zp_shop_num = $ea


	.segment "OVERLAY"

.assert * = j_overlay_entry, error, "Wrong start address"
	lda player_transport
	cmp #tile_walk
	beq ask_lodging
	jsr j_primm
	.byte "THE INNKEEPER", $8d
	.byte "SAYS: GET THAT", $8d
	.byte "HORSE OUT OF", $8d
	.byte "HERE!!!", $8d
	.byte 0
	rts

ask_lodging:
	jsr j_primm
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
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "I AM ", 0
	clc
	lda zp_shop_num
	adc #$08
	jsr print_string
	jsr j_primm
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
	jsr j_primm
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
	cmp #towne_minoc
	bne ask_pay
	jsr j_primm
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
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "TAKE IT?", 0
	jsr input_char
	cmp #char_Y
	beq try_pay
cancel:
	jsr j_primm
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
	jsr j_primm
	.byte $8d
	.byte "IF YOU CAN'T PAY", $8d
	.byte "YOU CAN'T STAY!", $8d
	.byte "GOOD BYE.", $8d
	.byte 0
	rts

@paid:
	jsr j_update_status
	jsr j_primm
	.byte $8d
	.byte "VERY GOOD, HAVE", $8d
	.byte "A PLEASANT", $8d
	.byte "NIGHT.", $8d
	.byte 0
	jsr j_rand
	and #$03
	bne fall_asleep
	jsr j_primm
	.byte $8d
	.byte "OH, AND DON'T", $8d
	.byte "MIND THE STRANGE", $8d
	.byte "NOISES, IT'S", $8d
	.byte "ONLY RATS!", $8d
	.byte 0
fall_asleep:
	lda #$0a
	sta zp_delay
:	jsr j_update_view
	dec zp_delay
	bne :-
	ldx zp_shop_num
	lda table_bed_x,x
	sta player_xpos
	lda table_bed_y,x
	sta player_ypos
	lda #$0a
	sta zp_delay
:	jsr j_update_view
	dec zp_delay
	bne :-
	lda #tile_human_prone
	sta player_transport
	lda #$32
	sta zp_delay
:	jsr j_update_view
	dec zp_delay
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
	lda #char_A     ;BUG: should be G
	sta (ptr1),y
@recover_hp:
	lda #$32     ;50-99
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
	jsr j_primm
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
	cmp #towne_skara_brae
	bne @morning
	jsr j_rand
	and #$03
	bne @morning
	jsr j_primm
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
	lda #ai_random
	sta npc_movement_ai,x
	lda #$10
	sta npc_dialogue,x
@morning:
	jsr j_update_view
	jsr j_primm
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
; STRING $00 (0)
	.byte 0
; STRING $01 (1)
	.byte "THE HONEST INN", 0
; STRING $02 (2)
	.byte "BRITANNIA MANOR", 0
; STRING $03 (3)
	.byte "THE INN OF ENDS", 0
; STRING $04 (4)
	.byte "WAYFARERS INN", 0
; STRING $05 (5)
	.byte "HONORABLE INN", 0
; STRING $06 (6)
	.byte "THE INN OF", $8d
	.byte "THE SPIRITS", 0
; STRING $07 (7)
	.byte "THE SLEEP SHOP", 0
; STRING $08 (8)
	.byte "SCATU", 0
; STRING $09 (9)
	.byte "JASON", 0
; STRING $0A (10)
	.byte "SMIRK", 0
; STRING $0B (11)
	.byte "ESTRO", 0
; STRING $0C (12)
	.byte "ZAJAC", 0
; STRING $0D (13)
	.byte "TYRONE", 0
; STRING $0E (14)
	.byte "TYMUS", 0
; STRING $0F (15)
	.byte "WE HAVE A ROOM", $8d
	.byte "WITH 2 BEDS", $8d
	.byte "THAT RENTS FOR", $8d
	.byte "20gp.", 0
; STRING $10 (16)
	.byte "WE HAVE A MODEST", $8d
	.byte "SIZED ROOM WITH", $8d
	.byte "1 BED FOR 15gp.", 0
; STRING $11 (17)
	.byte "WE HAVE A VERY", $8d
	.byte "SECURE ROOM OF", $8d
	.byte "MODEST SIZE AND", $8d
	.byte "1 BED FOR 10gp.", 0
; STRING $12 (18)
	.byte "WE HAVE THREE", $8d
	.byte "ROOMS AVAILABLE,", $8d
	.byte "A 1, 2 AND 3 BED", $8d
	.byte "ROOM FOR 30, 60", $8d
	.byte "AND 90gp EACH.", 0
; STRING $13 (19)
	.byte "WE HAVE A SINGLE", $8d
	.byte "BED ROOM WITH", $8d
	.byte "A BACK DOOR", $8d
	.byte "FOR 15gp.", 0
; STRING $14 (20)
	.byte "UNFORTUNATLY, I", $8d
	.byte "HAVE BUT ONLY", $8d
	.byte "A VERY SMALL", $8d
	.byte "ROOM WITH 1 BED,", $8d
	.byte "WORSE YET, IT IS", $8d
	.byte "HAUNTED! IF YOU", $8d
	.byte "DO WISH TO STAY", $8d
	.byte "IT COSTS 5gp.", 0
; STRING $15 (21)
	.byte "ALL WE HAVE IS", $8d
	.byte "THAT COT OVER", $8d
	.byte "THERE, BUT IT IS", $8d
	.byte "COMFORTABLE, AND", $8d
	.byte "ONLY 1gp.", 0

dec_gold:
	sta zp_amount
	sed
	ldy #party_stat_gold_hi
	lda party_stats + 1,y
	sec
	sbc zp_amount
	sta party_stats + 1,y
	lda party_stats,y
	sbc #$00
	sta party_stats,y
	bcs @ok
	clc
	lda party_stats + 1,y
	adc zp_amount
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
	sta zp_amount_hp
	jsr j_get_stats_ptr
	ldy #player_cur_hp_lo
	sed
	clc
	lda (ptr1),y
	adc zp_amount_hp
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
	cmp #$63     ;99
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
	sta zp_class
	ldy #player_intelligence
	lda (ptr1),y
	jsr decode_bcd_value
	asl
	ldx zp_class
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
	sta zp_amount
	lsr
	adc zp_amount
@add_mp:
	jsr encode_bcd_value
	ldy #player_magic_points
	sta (ptr1),y
@skip:
	dec curr_player
	bpl @next_player
	rts

; junk
	.byte $07,$f8,$18,$69,$01,$d8,$91,$fe
	.byte $c6,$d4,$10,$ab,$60,$0a
