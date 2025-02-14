	.include "uscii.i"

	.include "char.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "tables.i"
	.include "trainers.i"
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
	.byte "WELCOME FRIEND,", $8d
	.byte "ART THOU HERE TO", $8d
	.byte 0
	jsr j_primm
	.byte "BUY OR SELL?", 0
	jsr input_char
	cmp #char_B
	beq @buy
	cmp #char_S
	bne @buy_or_sell
	jmp sell

@buy:
	jsr j_primm
	.byte $8d
	.byte "VERY GOOD,", $8d
	.byte 0
buy_menu:
	jsr j_primm
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
	adc #char_alpha_first
	jsr j_console_out
	lda #char_hyphen
	jsr j_console_out
	lda zp_item_type
	clc
	adc #$0d
	jsr print_string
	jsr j_primm
	.byte "S", $8d
	.byte 0
	inc zp_inv_num
	lda zp_inv_num
	cmp #$04
	bcc @next_item

; prompt
	jsr j_primm
	.byte "YOUR INTEREST?", 0
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
	.byte $8d
	.byte "I FEAR YOU", $8d
	.byte "HAVE NOT THE", $8d
	.byte "FUNDS, PERHAPS", $8d
	.byte "SOMETHING ELSE.", $8d
	.byte 0
	jmp buy_menu

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
	jsr j_primm
	.byte " SAYS:", $8d
	.byte "A FINE CHOICE!", $8d
	.byte "ANYTHING ELSE?", $8d
	.byte 0
	jmp buy_menu

sell:
	jsr j_primm
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
	sbc #char_alpha_first
	sta zp_item_type
	beq @bye
	cmp #weapon_last
	bcs @bye
	tay
	lda weapons,y
	bne @make_offer
	jsr j_primm
	.byte $8d
	.byte "THOU DOST NOT", $8d
	.byte "OWN THAT.", $8d
	.byte "WHAT ELSE MIGHT", $8d
	.byte "YOU SELL?", 0
	jmp sell_menu

@bye:
	jmp bye

; PRICE_FIX: mace costs 100, sell for 50 not 0
@make_offer:
	lda zp_item_type
	asl
	tay
	lda price,y
	jsr decode_bcd_value
	lsr
	php                 ;PRICE_FIX preserve carry flag
	jsr encode_bcd_value
	sta payment
	lda price + 1,y
	jsr decode_bcd_value
	plp                 ;PRICE_FIX restore carry flag
	bcc :+              ;PRICE_FIX use carry flag ...
	ldx trainer_price   ;PRICE_FIX ... if option is enabled
	beq :+              ;PRICE_FIX
	adc #99             ;PRICE_FIX add 100 (bcc implies sec)
:	lsr
	jsr encode_bcd_value
	sta payment + 1
	jsr j_primm
	.byte $8d
	.byte "I WILL GIVE YOU", $8d
	.byte 0
	lda payment
	beq :+
	jsr j_printbcd
:	lda payment + 1
	jsr j_printbcd
	jsr j_primm
	.byte "gp FOR THAT.", $8d
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
	.byte "HMMPH, WHAT", $8d
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
	lda weapons,y
	sbc #$01
	sta weapons,y
	cld
	jsr j_update_status
	jsr j_primm
	.byte "FINE, WHAT", $8d
	.byte "ELSE?", 0
	jmp sell_menu

location_table:
	.byte $00,$00,$00,$00,$00,$01,$02,$00
	.byte $03,$04,$00,$00,$00,$05,$06,$00

inventory:
	.byte $01,$02,$03,$06  ;Britain
	.byte $05,$06,$08,$0a  ;Jhelom
	.byte $04,$0a,$0b,$0c  ;Minoc
	.byte $04,$05,$06,$07  ;Trinsic
	.byte $08,$09,$0d,$0e  ;Buccaneer's Den
	.byte $02,$03,$07,$09  ;Vesper

price:
	.byte $00,$00  ;$00 hands
	.byte $00,$20  ;$01 staff
	.byte $00,$02  ;$02 dagger
	.byte $00,$25  ;$03 sling
	.byte $01,$00  ;$04 mace
	.byte $02,$25  ;$05 axe
	.byte $03,$00  ;$06 sword
	.byte $02,$50  ;$07 bow
	.byte $06,$00  ;$08 crossbow
	.byte $00,$05  ;$09 flaming oil
	.byte $03,$50  ;$0a halberd
	.byte $15,$00  ;$0b magic axe
	.byte $25,$00  ;$0c magic sword
	.byte $20,$00  ;$0d magic bow
	.byte $50,$00  ;$0e magic wand
	.byte $70,$00  ;$0f mystic sword

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
	.byte "WINDSOR WEAPONRY", 0
; STRING $02 (2)
	.byte "WILLARD'S", $8d
	.byte "WEAPONRY", 0
; STRING $03 (3)
	.byte "THE IRON WORKS", 0
; STRING $04 (4)
	.byte "DUELLING WEAPONS", 0
; STRING $05 (5)
	.byte "HOOK'S ARMS", 0
; STRING $06 (6)
	.byte "VILLAGE ARMS", 0
; STRING $07 (7)
	.byte "WINSTON", 0
; STRING $08 (8)
	.byte "WILLARD", 0
; STRING $09 (9)
	.byte "PETER", 0
; STRING $0A (10)
	.byte "JUMAR", 0
; STRING $0B (11)
	.byte "HOOK", 0
; STRING $0C (12)
	.byte "WENDY", 0
; STRING $0D (13)
	.byte "HANDS", 0
; STRING $0E (14)
	.byte "STAFF", 0
; STRING $0F (15)
	.byte "DAGGER", 0
; STRING $10 (16)
	.byte "SLING", 0
; STRING $11 (17)
	.byte "MACE", 0
; STRING $12 (18)
	.byte "AXE", 0
; STRING $13 (19)
	.byte "SWORD", 0
; STRING $14 (20)
	.byte "BOW", 0
; STRING $15 (21)
	.byte "CROSSBOW", 0
; STRING $16 (22)
	.byte "FLAMING OIL", 0
; STRING $17 (23)
	.byte "HALBERD", 0
; STRING $18 (24)
	.byte "MAGIC AXE", 0
; STRING $19 (25)
	.byte "MAGIC SWORD", 0
; STRING $1A (26)
	.byte "MAGIC BOW", 0
; STRING $1B (27)
	.byte "MAGIC WAND", 0
; STRING $1C (28)
	.byte "MYSTIC SWORD", 0
; STRING $1D (29)
	.byte "HANDS", $8d
	.byte 0
; STRING $1E (30)
	.byte "WE ARE THE ONLY", $8d
	.byte "STAFF MAKERS IN", $8d
	.byte "BRITANNIA, YET", $8d
	.byte "SELL THEM FOR", $8d
	.byte "ONLY 20gp.", $8d
	.byte 0
; STRING $1F (31)
	.byte "WE SELL THE", $8d
	.byte "MOST DEADLY OF", $8d
	.byte "DAGGERS, A", $8d
	.byte "BARGAIN AT", $8d
	.byte "ONLY 2gp EACH.", $8d
	.byte 0
; STRING $20 (32)
	.byte "OUR SLINGS ARE", $8d
	.byte "MADE FROM ONLY", $8d
	.byte "THE FINEST GUT", $8d
	.byte "AND LEATHER,", $8d
	.byte "'TIS YOURS", $8d
	.byte "FOR 25gp.", $8d
	.byte 0
; STRING $21 (33)
	.byte "THESE MACES HAVE", $8d
	.byte "A HARDENED SHAFT", $8d
	.byte "AND A 5lb HEAD,", $8d
	.byte "FAIRLY PRICED", $8d
	.byte "AT 100gp.", $8d
	.byte 0
; STRING $22 (34)
	.byte "NOTICE THE FINE", $8d
	.byte "WORKMANSHIP ON", $8d
	.byte "THIS AXE, YOU'LL", $8d
	.byte "AGREE 225gp IS", $8d
	.byte "A GOOD PRICE.", $8d
	.byte 0
; STRING $23 (35)
	.byte "THE FINE WORK", $8d
	.byte "ON THESE SWORDS", $8d
	.byte "WILL BE THE", $8d
	.byte "DREAD OF THY", $8d
	.byte "FOES, FOR 300gp.", $8d
	.byte 0
; STRING $24 (36)
	.byte "OUR BOWS ARE", $8d
	.byte "MADE OF FINEST", $8d
	.byte "YEW, AND THE", $8d
	.byte "ARROWS WILLOW, A", $8d
	.byte "STEAL AT 250gp.", $8d
	.byte 0
; STRING $25 (37)
	.byte "CROSSBOWS MADE", $8d
	.byte "BY IOLO THE BARD", $8d
	.byte "ARE THE FINEST", $8d
	.byte "IN THE WORLD,", $8d
	.byte "YOURS FOR 600gp.", $8d
	.byte 0
; STRING $26 (38)
	.byte "FLASKS OF OIL", $8d
	.byte "MAKE GREAT", $8d
	.byte "WEAPONS AND", $8d
	.byte "CREATE A WALL", $8d
	.byte "OF FIRE TOO,", $8d
	.byte "5gp EACH.", $8d
	.byte 0
; STRING $27 (39)
	.byte "A HALBERD IS", $8d
	.byte "A MIGHTY WEAPON", $8d
	.byte "TO ATTACK OVER", $8d
	.byte "OBSTACLES; A", $8d
	.byte "MUST AND", $8d
	.byte "ONLY 350gp.", $8d
	.byte 0
; STRING $28 (40)
	.byte "THIS MAGICAL AXE", $8d
	.byte "CAN BE THROWN AT", $8d
	.byte "THY ENEMY AND", $8d
	.byte "WILL THEN", $8d
	.byte "RETURN, ALL FOR", $8d
	.byte "1500gp.", $8d
	.byte 0
; STRING $29 (41)
	.byte "MAGICAL SWORDS", $8d
	.byte "SUCH AS THESE", $8d
	.byte "ARE RARE INDEED!", $8d
	.byte "I WILL PART WITH", $8d
	.byte "ONE FOR 2500gp.", $8d
	.byte 0
; STRING $2A (42)
	.byte "A MAGICAL BOW", $8d
	.byte "WILL KEEP THY", $8d
	.byte "ENEMIES FAR AWAY", $8d
	.byte "OR DEAD! A", $8d
	.byte "MUST FOR 2000gp!", $8d
	.byte 0
; STRING $2B (43)
	.byte "THIS MAGIC WAND", $8d
	.byte "CASTS MIGHTY", $8d
	.byte "BLUE BOLTS TO", $8d
	.byte "STRIKE DOWN THY", $8d
	.byte "FOES, 5000gp.", $8d
	.byte 0
; STRING $2C (44)
	.byte "MYSTIC SWORDS", $8d
	.byte "ARE AN UNKNOWN", $8d
	.byte 0
; STRING $2D (45)
	.byte "HND", 0
; STRING $2E (46)
	.byte "STF", 0
; STRING $2F (47)
	.byte "DAG", 0
; STRING $30 (48)
	.byte "SLN", 0
; STRING $31 (49)
	.byte "MAC", 0
; STRING $32 (50)
	.byte "AXE", 0
; STRING $33 (51)
	.byte "SWD", 0
; STRING $34 (52)
	.byte "BOW", 0
; STRING $35 (53)
	.byte "XBO", 0
; STRING $36 (54)
	.byte "OIL", 0
; STRING $37 (55)
	.byte "HAL", 0
; STRING $38 (56)
	.byte "+AX", 0
; STRING $39 (57)
	.byte "+SW", 0
; STRING $3A (58)
	.byte "+BO", 0
; STRING $3B (59)
	.byte "WND", 0
; STRING $3C (60)
	.byte "^SW", 0

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

display_owned:
	jsr j_clearstatwindow
	jsr save_console_xy
	ldx #$1b
	ldy #$00
	sty zp_item_type
	sty zp_display_pos
	jsr j_primm_xy
	.byte glyph_greater_odd
	.byte "WEAPONS"
	.byte glyph_less_odd, 0
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
	adc #party_stat_weapons
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
	jsr j_primm
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
