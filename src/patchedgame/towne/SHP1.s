	.include "uscii.i"

	.include "char.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "tables.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


; --- Custom use of Zero Page

zp_item_type = $d8
zp_display_pos = $d9
zp_shop_num = $ea
zp_input_index = $ea
zp_inv_num = $f0
zp_mismatches = $f0


	.segment "OVERLAY"

.assert * = j_overlay_entry, error, "Wrong start address"
	jsr j_primm
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
	jsr j_primm
	.byte " SAYS:", $8d
	.byte "WANT TO BUY", $8d
	.byte "OR SELL?", 0
	jsr input_char
	cmp #char_B
	beq @buy
	cmp #char_S
	bne @buy_or_sell
	jmp sell

@buy:
	jsr j_primm
	.byte $8d
	.byte "WELL THEN,", $8d
	.byte 0
buy_menu:
	jsr j_primm
	.byte "WE'VE GOT:", $8d
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
	beq @skip
	sta zp_item_type
	clc
	adc #char_alpha_first
	jsr j_console_out
	lda #char_hyphen
	jsr j_console_out
	lda zp_item_type
	clc
	adc #$0d
	jsr print_string
	jsr print_newline
@skip:
	inc zp_inv_num
	lda zp_inv_num
	cmp #$04
	bcc @next_item

; prompt
	jsr j_primm
	.byte "WHAT'LL IT BE?", 0
	jsr display_owned
	jsr input_char
	pha
	jsr j_clearstatwindow
	jsr j_update_status
	pla
	sec
	sbc #char_alpha_first
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
	jsr j_primm
	.byte $8d
	.byte "DO YOU WANT", $8d
	.byte "TO BUY IT?", 0
:	jsr input_char
	beq :-
	pha
	jsr print_newline
	pla
	cmp #char_Y
	beq try_spend
	cmp #char_N
	bne @ask_buy
	jsr j_primm
	.byte "TOO BAD.", $8d
	.byte 0
@more:
	jsr j_primm
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
	jsr j_primm
	.byte " SAYS:", $8d
	.byte "GOOD BYE.", $8d
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
	ldy #party_stat_gold_hi
	sed
	sec
	lda party_stats + 1,y
	sbc payment + 1
	lda party_stats,y
	sbc payment
	cld
	bcs do_spend
	jsr j_primm
	.byte "WHAT YOU TRY'N", $8d
	.byte "TO PULL? YOU", $8d
	.byte "CAN'T PAY.", $8d
	.byte 0
	jmp bye

payment:
	.word $0000

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
	lda armour,y
	adc #$01
	bcs :+
	sta armour,y
:	cld
	jsr j_update_status
	clc
	lda zp_shop_num
	adc #$07
	jsr print_string
	jsr j_primm
	.byte " SAYS:", $8d
	.byte "GOOD CHOICE!", $8d
	.byte "ANYTHING ELSE?", $8d
	.byte 0
	jmp buy_menu

sell:
	jsr j_primm
	.byte $8d
	.byte "WHAT DO YOU WANT", $8d
	.byte "TO SELL?", 0
sell_menu:
	jsr display_owned
	jsr input_char
	pha
	jsr j_clearstatwindow
	jsr j_update_status
	pla
	sec
	sbc #char_alpha_first
	sta zp_item_type
	beq @bye
	cmp #armour_last
	bcs @bye
	tay
	lda armour,y
	bne @make_offer
	jsr j_primm
	.byte $8d
	.byte "COME ON, YOU", $8d
	.byte "DON'T EVEN OWN", $8d
	.byte "ANY! WHAT ELSE?", 0
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
	jsr j_primm
	.byte $8d
	.byte "I'LL GIVE YA", $8d
	.byte 0
	lda payment
	beq :+
	jsr j_printbcd
:	lda payment + 1
	jsr j_printbcd
	jsr j_primm
	.byte "gp FOR THAT", $8d
	.byte 0
	lda zp_item_type
	clc
	adc #$0d
	jsr print_string
	jsr print_newline
@confirm:
	jsr j_primm
	.byte "DEAL?", 0
	jsr input_char
	cmp #char_Y
	beq @sell_item
	cmp #char_N
	bne @confirm
	jsr j_primm
	.byte "HARUMPH, WHAT", $8d
	.byte "ELSE THEN?", 0
	jmp sell_menu

@sell_item:
	sed
	clc
	ldy #party_stat_gold_hi
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
	lda armour,y
	sbc #$01
	sta armour,y
	cld
	jsr j_update_status
	jsr j_primm
	.byte "GOOD, WHAT", $8d
	.byte "ELSE?", 0
	jmp sell_menu

location_table:
	.byte $00,$00,$00,$00,$00,$01,$02,$00
	.byte $00,$03,$00,$00,$04,$05,$00,$00

inventory:
	.byte $01,$02,$03,$00  ;Britain
	.byte $03,$04,$05,$06  ;Jhelom
	.byte $01,$03,$05,$00  ;Trinsic
	.byte $01,$02,$00,$00  ;Paws
	.byte $01,$02,$03,$00  ;Buccaneer's Den

price:
	.byte $00,$00  ;$00 skin
	.byte $00,$50  ;$01 cloth
	.byte $02,$00  ;$02 leather
	.byte $06,$00  ;$03 chain mail
	.byte $20,$00  ;$04 plate mail
	.byte $40,$00  ;$05 magic chain
	.byte $70,$00  ;$06 magic plate
	.byte $90,$00  ;$07 mystic robe

print_newline:
	lda #char_enter
	jsr j_console_out
	rts

input_char:
	jsr j_waitkey
	beq input_char
	pha
	jsr j_console_out
	jsr print_newline
	pla
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
	.byte "WINDSOR ARMOUR", 0
; STRING $02 (2)
	.byte "VALIANT'S ARMOUR", 0
; STRING $03 (3)
	.byte "DUELLING ARMOUR", 0
; STRING $04 (4)
	.byte "LIGHT ARMOUR", 0
; STRING $05 (5)
	.byte "BASIC ARMOUR", 0
; STRING $06 (6)
	.byte 0
; STRING $07 (7)
	.byte "JEAN", 0
; STRING $08 (8)
	.byte "VALIANT", 0
; STRING $09 (9)
	.byte "PIERRE", 0
; STRING $0A (10)
	.byte "LIMPY", 0
; STRING $0B (11)
	.byte "BIG JOHN", 0
; STRING $0C (12)
	.byte 0
; STRING $0D (13)
	.byte "SKIN", 0
; STRING $0E (14)
	.byte "CLOTH", 0
; STRING $0F (15)
	.byte "LEATHER", 0
; STRING $10 (16)
	.byte "CHAIN MAIL", 0
; STRING $11 (17)
	.byte "PLATE MAIL", 0
; STRING $12 (18)
	.byte "MAGIC CHAIN", 0
; STRING $13 (19)
	.byte "MAGIC PLATE", 0
; STRING $14 (20)
	.byte "MYSTIC ROBE", 0
; STRING $15 (21)
	.byte 0
; STRING $16 (22)
	.byte 0
; STRING $17 (23)
	.byte 0
; STRING $18 (24)
	.byte 0
; STRING $19 (25)
	.byte 0
; STRING $1A (26)
	.byte 0
; STRING $1B (27)
	.byte 0
; STRING $1C (28)
	.byte 0
; STRING $1D (29)
	.byte "SKIN", $8d
	.byte 0
; STRING $1E (30)
	.byte "CLOTH ARMOUR IS", $8d
	.byte "GOOD FOR A TIGHT", $8d
	.byte "BUDGET, FAIRLY", $8d
	.byte "PRICED AT 50gp.", $8d
	.byte 0
; STRING $1F (31)
	.byte "LEATHER ARMOUR", $8d
	.byte "IS BOTH SUPPLE", $8d
	.byte "AND STRONG, AND", $8d
	.byte "COSTS A MERE", $8d
	.byte "200gp, A BARGAN!", $8d
	.byte 0
; STRING $20 (32)
	.byte "CHAIN MAIL IS", $8d
	.byte "THE ARMOUR USED", $8d
	.byte "BY MORE WARRIORS", $8d
	.byte "THAN ALL OTHERS", $8d
	.byte "OURS COSTS 600gp", $8d
	.byte 0
; STRING $21 (33)
	.byte "FULL PLATE", $8d
	.byte "ARMOUR IS THE", $8d
	.byte "ULTIMA IN NON-", $8d
	.byte "MAGIC ARMOUR,", $8d
	.byte "GET YOURS", $8d
	.byte "FOR 2000gp.", $8d
	.byte 0
; STRING $22 (34)
	.byte "MAGIC ARMOUR IS", $8d
	.byte "RARE AND", $8d
	.byte "EXPENSIVE THIS", $8d
	.byte "CHAIN SELLS FOR", $8d
	.byte "4000gp", $8d
	.byte 0
; STRING $23 (35)
	.byte "MAGICAL PLATE", $8d
	.byte "ARMOUR IS THE", $8d
	.byte "BEST KNOWN", $8d
	.byte "PROTECTION, ONLY", $8d
	.byte "WE HAVE IT.", $8d
	.byte "COST: 7000gp.", $8d
	.byte 0
; STRING $24 (36)
	.byte "MYSTIC ROBES!", $8d
	.byte 0

; unused
get_input:
	lda #char_question
	jsr j_console_out
	lda #$00
	sta zp_input_index
@get_char:
	jsr j_waitkey
	cmp #char_enter
	beq @got_input
	cmp #char_left_arrow
	beq @backspace
	cmp #char_space
	bcc @get_char
	ldx zp_input_index
	sta inbuffer,x
	jsr j_console_out
	inc zp_input_index
	lda zp_input_index
	cmp #$0f
	bcc @get_char
	bcs @got_input
@backspace:
	lda zp_input_index
	beq @get_char
	dec zp_input_index
	dec console_xpos
	lda #char_space
	jsr j_console_out
	dec console_xpos
	jmp @get_char

@got_input:
	ldx zp_input_index
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
match_input_inline:
	pla
	sta ptr1
	pla
	sta ptr1 + 1
	ldy #$00
	sty zp_mismatches
	ldx #$ff
@next_char:
	inx
	inc ptr1
	bne :+
	inc ptr1 + 1
:	lda (ptr1),y
	beq @end
	cmp inbuffer,x
	beq @next_char
	inc zp_mismatches
	jmp @next_char

@end:
	lda ptr1 + 1
	pha
	lda ptr1
	pha
	lda zp_mismatches
	rts

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

encode_bcd_value:
	cmp #$00
	beq @done
	cmp #$63     ;99
	beq @max
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

display_owned:
	jsr j_clearstatwindow
	jsr save_console_xy
	ldx #$1b
	ldy #$00
	sty zp_item_type
	sty zp_display_pos
	jsr j_primm_xy
	.byte glyph_greater_odd
	.byte "ARMOUR"
	.byte glyph_less_even, 0
@next_row:
	lda #$18
	sta console_xpos
	lda zp_display_pos
	sta console_ypos
	inc console_ypos
	lda zp_item_type
	beq @nothing
	clc
	adc #party_stat_armour
	tay
	lda party_stats,y
	beq @next_item
	pha
	lda zp_item_type
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
	lda zp_item_type
	clc
	adc #$0d
	jsr print_string
	inc zp_display_pos
@next_item:
	inc zp_item_type
	lda zp_item_type
	cmp #$08
	bcc @next_row
	jsr restore_console_xy
	rts

@nothing:
	jsr j_primm
	.byte "A-NO ARMOUR", 0
	inc zp_display_pos
	jmp @next_item

; junk
	.byte $00,$00,$FF,$FF,$00,$00,$FF,$FF
	.byte $00,$00,$FF,$FF,$00,$00
