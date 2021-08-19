	.include "uscii.i"

	.include "char.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "tables.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


; --- Custom use of Zero Page

zp_shop_num = $ea
zp_input_index = $ea
zp_attempts = $f0
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
	jsr print_newline
	clc
	lda zp_shop_num
	adc #$06
	jsr print_string
	jsr j_primm
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
	jsr j_primm
	.byte $8d
	.byte "WE HAVE THE", $8d
	.byte "BEST ADVENTURE", $8d
	.byte "RATIONS, 25 FOR", $8d
	.byte "ONLY ", 0
	ldy zp_shop_num
	lda price_table,y
	sta price
	jsr j_printbcd
	jsr j_primm
	.byte "gp.", $8d
	.byte 0
input_count:
	jsr j_primm
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
	ldy #party_stat_gold_hi
	sec
	lda party_stats + 1,y
	sbc price
	sta party_stats + 1,y
	lda party_stats,y
	sbc #$00
	sta party_stats,y
	bcc cannot_afford
	ldy #party_stat_food_lo
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
	jsr j_primm
	.byte $8d
	.byte "THANK YOU,", $8d
	.byte "ANYTHING ELSE?", 0
	jsr input_char
	cmp #char_Y
	bne bye
	jmp input_count

bye:
	jsr j_primm
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
	jsr j_primm
	.byte $8d
	.byte "YOU CANNOT", $8d
	.byte "AFFORD ANY!", 0
	jmp bye

@partial_afford:
	jsr j_primm
	.byte $8d
	.byte "YOU CAN ONLY", $8d
	.byte "AFFORD ", 0
	lda zp_attempts
	jsr encode_bcd_value
	jsr j_printbcd
	jsr j_primm
	.byte " PACKS.", $8d
	.byte 0
	jmp ask_more

price:
	.byte 0
location_table:
	.byte $00,$00,$00,$00,$01,$02,$00,$03
	.byte $00,$00,$04,$00,$05,$00,$00,$00
price_table:
	.byte $25  ;Moonglow
	.byte $40  ;Britain
	.byte $35  ;Yew
	.byte $20  ;Skara Brae
	.byte $30  ;Paws

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
	.byte "THE SAGE DELI", 0
; STRING $02 (2)
	.byte "ADVENTURE FOOD", 0
; STRING $03 (3)
	.byte "THE DRY GOODS", 0
; STRING $04 (4)
	.byte "FOOD FOR THOUGHT", 0
; STRING $05 (5)
	.byte "THE MARKET", 0
; STRING $06 (6)
	.byte "SHAMAN", 0
; STRING $07 (7)
	.byte "WINDRICK", 0
; STRING $08 (8)
	.byte "DONNAR", 0
; STRING $09 (9)
	.byte "MINTOL", 0
; STRING $0A (10)
	.byte "MAX", 0

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

; junk
	.byte $04,$20,$54,$08,$ee,$4f,$7d,$20
	.byte $db,$82,$10
