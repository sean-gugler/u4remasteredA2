	.include "uscii.i"

	.include "char.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


; --- Custom use of Zero Page

zp_shop_num = $ea


	.segment "OVERLAY"

.assert * = j_overlay_entry, error, "Wrong start address"
	jsr j_primm
	.byte $8d
	.byte "AVAST YE MATE", $8d
	.byte "SHURE YE WISHES", $8d
	.byte "TO BUY FROM OL'", $8d
	.byte 0
	ldx current_location
	dex
	lda location_table,x
	sta zp_shop_num
	dec zp_shop_num
	lda zp_shop_num
	clc
	adc #$03
	jsr print_string
	jsr print_newline
	jsr print_newline
	clc
	lda zp_shop_num
	adc #$03
	jsr print_string
	jsr j_primm
	.byte $8d
	.byte "SAYS: WELCOME TO", $8d
	.byte 0
	lda zp_shop_num
	clc
	adc #$01
	jsr print_string
	jsr j_primm
	.byte $8d
	.byte "LIKE TO SEE MY", $8d
	.byte "GOODS?", 0
	jsr input_char
	cmp #char_Y
	beq menu
	jmp bye

menu:
	jsr print_newline
	clc
	lda zp_shop_num
	adc #$03
	jsr print_string
	jsr j_primm
	.byte $8d
	.byte "SAYS: GOOD MATE!", $8d
	.byte "YA SEE I GOTS:", $8d
	.byte "A-TORCHES", $8d
	.byte "B-MAGIC GEMS", $8d
	.byte "C-MAGIC KEYS", $8d
	.byte "WAT'L IT BE?", 0
	jsr display_owned
	jsr input_char
	pha
	jsr j_clearstatwindow
	jsr j_update_status
	pla
	sec
	sbc #char_alpha_first
	cmp #$04
	bcc ask_buy
	jmp bye

ask_buy:
	sta item_number
	jsr print_newline
	lda item_number
	clc
	adc #$05
	jsr print_string
	jsr j_primm
	.byte $8d
	.byte "WILL YA BUY?", 0
	jsr input_char
	cmp #char_Y
	beq try_spend
	jsr j_primm
	.byte $8d
	.byte "HMMM...GRMBL...", $8d
	.byte 0
	jmp ask_more

try_spend:
	lda item_number
	asl
	tay
	sed
	sec
	lda gold_lo
	sbc price_lo,y
	sta gold_lo
	lda gold_hi
	sbc price_hi,y
	sta gold_hi
	bcs @paid
	clc
	lda gold_lo
	adc price_lo,y
	sta gold_lo
	lda gold_hi
	adc price_hi,y
	sta gold_hi
	cld
	jsr j_primm
	.byte $8d
	.byte "WHAT? CAN'T PAY!", $8d
	.byte "BUZZ OFF SWINE!", $8d
	.byte 0
	rts

@paid:
	clc
	ldy item_number
	lda party_items,y
	adc item_count,y
	bcc :+
	lda #$99
:	sta party_items,y
	cld
	jsr j_primm
	.byte $8d
	.byte "FINE...FINE...", $8d
	.byte 0
	jsr j_update_status
	jmp ask_more

ask_more:
	jsr print_newline
	clc
	lda zp_shop_num
	adc #$03
	jsr print_string
	jsr j_primm
	.byte $8d
	.byte "SAYS: SEE MORE?", 0
	jsr input_char
	cmp #char_Y
	bne bye
	jmp menu

bye:
	jsr print_newline
	clc
	lda zp_shop_num
	adc #$03
	jsr print_string
	jsr j_primm
	.byte $8d
	.byte "SAYS: SEE YA", $8d
	.byte "MATIE!", $8d
	.byte 0
	rts

item_number:
	.byte $00
location_table:
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$01,$02,$00
price_hi:
price_lo = price_hi + 1
	.byte $00,$50  ; torch
	.byte $00,$60  ; gem
	.byte $00,$60  ; key
	.byte $09,$00  ; sextant
item_count:
	.byte $05,$05,$06,$01
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
	.byte "PIRATES GUILD", 0
; STRING $02 (2)
	.byte "THE GUILD SHOP", 0
; STRING $03 (3)
	.byte "ONE EYED WILLEY", 0
; STRING $04 (4)
	.byte "LONG JOHN LEARY", 0
; STRING $05 (5)
	.byte "I CAN GIVE YA 5", $8d
	.byte "LONG LASTING", $8d
	.byte "TORCHES FOR A", $8d
	.byte "MERE 50gp.", $8d
	.byte 0
; STRING $06 (6)
	.byte "I'VE GOT MACICAL", $8d
	.byte "MAPPING GEMS", $8d
	.byte "5 FOR ONLY 60gp.", $8d
	.byte 0
; STRING $07 (7)
	.byte "MAGICAL KEYS 1", $8d
	.byte "USE EACH, A FAIR", $8d
	.byte "PRICE AT 60gp.", $8d
	.byte "FOR 6.", $8d
	.byte 0
; STRING $08 (8)
	.byte "SO...YA WANT A", $8d
	.byte "SEXTANT...WELL I", $8d
	.byte "GOTS ONE WHICH I", $8d
	.byte "MIGHT PART WITH", $8d
	.byte "FER 900 GOLD!", $8d
	.byte 0

display_owned:
	jsr j_clearstatwindow
	jsr save_cursor
	ldx #$1a
	ldy #$00
	jsr j_primm_xy
	.byte glyph_greater_even
	.byte "EQUIPMENT"
	.byte glyph_less_even, 0
	inc console_ypos
	lda #$18
	sta console_xpos
	ldy #party_stat_torches
	lda party_stats,y
	jsr j_printbcd
	jsr j_primm
	.byte "-TORCHES", 0
	inc console_ypos
	lda #$18
	sta console_xpos
	ldy #party_stat_gems
	lda party_stats,y
	jsr j_printbcd
	jsr j_primm
	.byte "-GEMS", 0
	inc console_ypos
	lda #$18
	sta console_xpos
	ldy #party_stat_keys
	lda party_stats,y
	jsr j_printbcd
	jsr j_primm
	.byte "-KEYS", 0
	inc console_ypos
	lda #$18
	sta console_xpos
	ldy #party_stat_sextant
	lda party_stats,y
	beq @done
	jsr j_printbcd
	jsr j_primm
	.byte "-SEXTANTS", 0
@done:
	jsr restore_cursor
	rts

save_cursor:
	lda console_xpos
	sta prev_cursor_x
	lda console_ypos
	sta prev_cursor_y
	rts

restore_cursor:
	lda prev_cursor_x
	sta console_xpos
	lda prev_cursor_y
	sta console_ypos
	rts

prev_cursor_x:
	.byte 0
prev_cursor_y:
	.byte 0

; junk
	.byte $a2,$00,$a1,$fe,$f0,$06,$20,$69,$8c
; [disassembly of above]
;	ldx #$00
;	lda (ptr1,x)
;	beq e8c53
;	jsr e8c69
