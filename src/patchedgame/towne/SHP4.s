	.include "uscii.i"

	.include "char.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


; --- Custom use of Zero Page

zp_amount = $d8
zp_index = $ea

zp_save_reg = $d9
; for consistency these should have been the same
zp_dec_amount = $da
zp_inc_amount = $d9


	.segment "OVERLAY"

.assert * = j_overlay_entry, error, "Wrong start address"
	jsr j_primm
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
	jsr j_primm
	.byte $8d, $8d, "I AM ", 0
	clc
	lda zp_index
	adc #$05
	jsr print_string
	jsr j_primm
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
	jsr j_primm
	.byte " SAYS:", $8d
	.byte "PERHAPS ANOTHER", $8d
	.byte "TIME THEN....", $8d
	.byte "AND SLOWLY", $8d
	.byte "TURNS AWAY.", $8d
	.byte 0
	rts

buy_menu:
	jsr j_primm
	.byte $8d
	.byte "VERY WELL,", $8d
	.byte 0
	jsr j_primm
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
	sbc #char_alpha_first
	cmp #$06
	bcc @print_price
	jmp bye

@print_price:
	sta reagent_to_buy
	jsr j_primm
	.byte $8d
	.byte "VERY WELL,", $8d
	.byte "WE SELL", $8d
	.byte 0
	clc
	lda reagent_to_buy
	adc #$09
	jsr print_string
	jsr j_primm
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
	jsr j_primm
	.byte "gp.", $8d
	.byte $8d
	.byte "HOW MANY WOULD", $8d
	.byte "YOU LIKE,", $8d
	.byte "(0-9)?", 0
	jsr input_digit
	bne @print_cost
	jsr j_primm
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
	jsr j_primm
	.byte $8d
	.byte "VERY GOOD, THAT", $8d
	.byte "WILL BE ", 0
	lda reagent_price
	jsr j_printbcd
	jsr j_primm
	.byte "g.p.", $8d
	.byte 0
@make_offer:
	jsr j_primm
	.byte $8d
	.byte "YOU PAY:", 0
	jsr j_getnumber
	lda bcdnum
	cmp reagent_price
	bcs @spend
	cmp #$00
	bne @penalty
	jsr j_primm
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
	jsr j_primm
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
	bcc @set_value
	lda #$99
@set_value:
	sta reagents,y
	cld
	jsr j_primm
	.byte $8d
	.byte "VERY GOOD,", $8d
	.byte 0
	jmp more

more:
	jsr j_update_status
	jsr j_primm
	.byte "ANYTHING ELSE?", 0
	jsr input_char
	cmp #char_Y
	bne bye
	jmp buy_menu

bye:
	jsr j_primm
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
	.byte $02,$05,$06,$03,$06,$09,$00,$00  ;Moonglow
	.byte $02,$04,$09,$06,$04,$08,$00,$00  ;Skara Brae
	.byte $03,$04,$02,$09,$06,$07,$00,$00  ;Paws
	.byte $06,$07,$09,$09,$09,$01,$00,$00  ;Buccaneer's Den
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
	.byte "MAGICAL HERBS", 0
; STRING $02 (2)
	.byte "HERBS AND SPICE", 0
; STRING $03 (3)
	.byte "THE MAGICS", 0
; STRING $04 (4)
	.byte "MAGIC MENTAR", 0
; STRING $05 (5)
	.byte "MARGOT", 0
; STRING $06 (6)
	.byte "SASHA", 0
; STRING $07 (7)
	.byte "SHIELA", 0
; STRING $08 (8)
	.byte "SHANNON", 0
; STRING $09 (9)
	.byte "SULFER ASH", 0
; STRING $0A (10)
	.byte "GINSENG", 0
; STRING $0B (11)
	.byte "GARLIC", 0
; STRING $0C (12)
	.byte "SPIDER SILK", 0
; STRING $0D (13)
	.byte "BLOOD MOSS", 0
; STRING $0E (14)
	.byte "BLACK PEARL", 0
; STRING $0F (15)
	.byte "NIGHTSHADE", 0
; STRING $10 (16)
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
	.byte 0
saved_cursor_y:
	.byte 0

display_owned:
	jsr j_clearstatwindow
	jsr save_cursor
	ldx #$1a
	ldy #$00
	sty reagent_type
	jsr j_primm_xy
	.byte glyph_greater_even
	.byte "REAGENTS"
	.byte glyph_less_odd, 0
@next:
	clc
	lda reagent_type
	adc #party_stat_reagents
	tay
	lda party_stats,y
	beq @skip
	sta reagent_amount
	inc console_ypos
	lda #$18
	sta console_xpos
	clc
	lda reagent_type
	adc #char_alpha_first
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
	cmp #reagent_max
	bcc @next
	jsr restore_cursor
	rts

try_spend:
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
	bcs @paid
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

@paid:
	lda #$00
	cld
	rts

inc_virtue:
	sta zp_inc_amount
	sed
	clc
	lda party_stats,y
	beq @set_value
	adc zp_inc_amount
	bcc @set_value
	lda #$99
@set_value:
	sta party_stats,y
	cld
	rts

dec_virtue:
	sta zp_dec_amount
	sty zp_save_reg
	lda party_stats,y
	beq @lost_an_eighth
@continue:
	sed
	sec
	sbc zp_dec_amount
	beq @underflow
	bcs @set_value
@underflow:
	lda #$01
@set_value:
	sta party_stats,y
	cld
	rts

@lost_an_eighth:
	jsr j_primm
	.byte $8d
	.byte "THOU HAST LOST", $8d
	.byte "AN EIGHTH!", $8d
	.byte 0
	ldy zp_save_reg
	lda #$99
	jmp @continue

input_digit:
	jsr j_waitkey
	beq input_digit
	sec
	sbc #char_num_first
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
