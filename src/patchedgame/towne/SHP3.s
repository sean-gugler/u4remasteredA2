	.include "uscii.i"

	.include "char.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "tables.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


; --- Custom use of Zero Page

zp_amount = $d8
zp_input_index = $d8  ;why different? it's $ea in all other files
zp_index = $ea
zp_count = $f0
zp_mismatches = $f0


	.segment "OVERLAY"

.assert * = j_overlay_entry, error, "Wrong start address"
	jsr print_newline
	ldx current_location
	dex
	lda location_table,x
	sta zp_index
	dec zp_index
	jsr print_string
	jsr j_primm
	.byte " SAYS:", $8d
	.byte "WELCOME MATE TO", $8d
	.byte 0
	clc
	lda zp_index
	adc #$07
	jsr print_string
	jsr print_newline
	jmp ask_food_or_ale

ask_again:
	clc
	lda zp_index
	adc #$01
	jsr print_string
	jsr j_primm
	.byte " SAYS:", 0
ask_food_or_ale:
	jsr j_primm
	.byte $8d
	.byte "WHAT'L IT BE,", $8d
	.byte 0
@prompt:
	jsr j_primm
	.byte "FOOD ER ALE?", 0
	jsr input_char
	cmp #char_F
	beq buy_food
	cmp #char_A
	bne @prompt
	jmp buy_ale

buy_food:
	jsr j_primm
	.byte $8d
	.byte "OUR SPECIALTY IS", $8d
	.byte 0
	clc
	lda zp_index
	adc #$0d
	jsr print_string
	jsr j_primm
	.byte $8d
	.byte "WHICH COSTS ", 0
	ldy zp_index
	lda price_food,y
	sta price_current
	jsr j_printdigit
	jsr j_primm
	.byte "gp.", $8d
	.byte 0
	jsr j_primm
	.byte $8d
	.byte "HOW MANY PLATES", $8d
	.byte "WOULD YOU", $8d
	.byte "LIKE?", 0
	jsr j_getnumber
	jsr print_newline
	lda bcdnum
	beq bye
	jsr decode_bcd_value
	sta hexnum
	lda #$00
	sta zp_count
	sed
@try_spend:
	ldy #party_stat_gold_hi
	sec
	lda party_stats + 1,y
	sbc price_current
	sta party_stats + 1,y
	lda party_stats,y
	sbc #$00
	sta party_stats,y
	bcc cannot_afford
	ldy #party_stat_food_lo
	clc
	lda party_stats,y
	adc #$01
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
	inc zp_count
	dec hexnum
	bne @try_spend
	cld
ask_more:
	jsr j_update_status
	jsr j_primm
	.byte $8d
	.byte "HERE YE ARR", $8d
	.byte "SOMETHIN ELSE?", 0
	jsr input_char
	cmp #char_Y
	bne bye
	jsr print_newline
	jmp ask_again

bye:
	jsr j_primm
	.byte $8d
	.byte "SEE YA MATE!", $8d
	.byte 0
	rts

cannot_afford:
	clc
	lda party_stats + 1,y
	adc price_current
	sta party_stats + 1,y
	lda party_stats,y
	adc #$00
	sta party_stats,y
	cld
	lda zp_count
	bne @partial_afford
	jsr j_primm
	.byte $8d
	.byte "YA CANNOT", $8d
	.byte "AFFORD ANY!", 0
	jmp bye

@partial_afford:
	jsr j_primm
	.byte $8d
	.byte "YA CAN ONLY", $8d
	.byte "AFFORD ", 0
	lda zp_count
	jsr j_printbcd
	jsr j_primm
	.byte " PLATES.", $8d
	.byte 0
	jmp ask_more

buy_ale:
	lda count_drinks
	cmp #$03
	bcc :+
	jmp drunk

:	inc count_drinks
	jsr j_primm
	.byte $8d
	.byte "HERE'S A MUG", $8d
	.byte "OF OUR BEST", $8d
	.byte "THAT'L BE 2gp.", $8d
	.byte "YOU PAY?", 0
	jsr j_getnumber
	jsr print_newline
	lda bcdnum
	sta zp_count
	cmp #$02
	bcs @fair_offer
	jsr j_primm
	.byte $8d
	.byte "WON'T PAY, EH", $8d
	.byte "YA SCUM, BE GONE", $8d
	.byte "FORE EY CALL", $8d
	.byte "THE GUARDS!", $8d
	.byte 0
	rts

@fair_offer:
	jsr try_spend
	bpl @paid
	jsr j_primm
	.byte $8d
	.byte "IT SEEMS THAT", $8d
	.byte "YOU HAVE NOT", $8d
	.byte "THE GOLD,", $8d
	.byte "GOOD DAY!", $8d
	.byte 0
	rts

@paid:
	jsr j_update_status
	lda hexnum
	cmp #$03
	bcs @ask_rumor
	jmp anything_else

@ask_rumor:
	jsr j_primm
	.byte $8d
	.byte "WHAT'D YA LIKE", $8d
	.byte "TO KNOW FRIEND?", $8d
	.byte 0
	jsr get_input
	jsr match_input_inline ;"BLAC"
	.byte "BLAC", 0
	beq @black_stone
	jsr match_input_inline ;"SEXT"
	.byte "SEXT", 0
	beq @sextant
	jsr match_input_inline ;"WHIT"
	.byte "WHIT", 0
	beq @white_stone
	jsr match_input_inline ;"MAND"
	.byte "MAND", 0
	beq @mandrake
	jsr match_input_inline ;"SKUL"
	.byte "SKUL", 0
	beq @skull
	jsr match_input_inline ;"NIGH"
	.byte "NIGH", 0
	beq @nightshade
@cant_help:
	jsr j_primm
	.byte $8d
	.byte "'FRAID I CAN'T", $8d
	.byte "HELP YA THERE", $8d
	.byte "FRIEND!", $8d
	.byte 0
	jmp anything_else
@black_stone:
	lda #$00
	jmp @check_location
@sextant:
	lda #$01
	jmp @check_location
@white_stone:
	lda #$02
	jmp @check_location
@mandrake:
	lda #$03
	jmp @check_location
@skull:
	lda #$04
	jmp @check_location
@nightshade:
	lda #$05
@check_location:
	cmp zp_index
	bne @cant_help
	lda bcdnum
	sta paid_rumor
@check_bribe:
	lda paid_rumor
	ldy zp_index
	cmp price_rumor,y
	bcc @price_not_met
	jmp print_rumor

@price_not_met:
	jsr j_primm
	.byte $8d
	.byte "THAT SUBJECT IS", $8d
	.byte "A BIT FOGGY,", $8d
	.byte "PERHAPS MORE", $8d
	.byte "GOLD WILL", $8d
	.byte "REFRESH MY", $8d
	.byte "MEMORY.", $8d
	.byte 0
	jsr j_primm
	.byte $8d
	.byte "YOU GIVE:", 0
	jsr j_getnumber
	jsr print_newline
	lda bcdnum
	beq bribe_not_met
	jsr try_spend
	bpl @paid_more
	jsr j_primm
	.byte $8d
	.byte "YER DON'T HAVE", $8d
	.byte "THAT MATE!", $8d
	.byte 0
	jmp bribe_not_met

@paid_more:
	sed
	clc
	lda bcdnum
	adc paid_rumor
	bcc @set_value
	lda #$99
@set_value:
	sta paid_rumor
	cld
	jmp @check_bribe

print_rumor:
	jsr print_newline
	lda zp_index
	clc
	adc #$01
	jsr print_string
	jsr j_primm
	.byte " SAYS:", $8d
	.byte 0
	clc
	lda zp_index
	adc #$13
	jsr print_string
	jsr print_newline
	jmp anything_else

bribe_not_met:
	jsr j_primm
	.byte $8d
	.byte "SORRY, I COULD", $8d
	.byte "NOT HEP YA MATE!", $8d
	.byte 0
	jmp bye

anything_else:
	jsr j_primm
	.byte $8d
	.byte "ANYTHIN' ELSE?", 0
	jsr input_char
	cmp #char_Y
	beq @yes
	cmp #char_N
	beq @no
	bne anything_else
@yes:
	jsr print_newline
	jmp ask_again

@no:
	jmp bye

drunk:
	jsr print_newline
	clc
	lda zp_index
	adc #$01
	jsr print_string
	jsr j_primm
	.byte " SAYS:", $8d
	.byte "SORRY, YOU SEEM", $8d
	.byte "TO HAVE TOO", $8d
	.byte "MANY, BYE!", $8d
	.byte 0
	rts

price_current:
	.byte 0
unused:
	.byte 0
count_drinks:
	.byte 0
paid_rumor:
	.byte 0
location_table:
	.byte $00,$00,$00,$00,$00,$01,$02,$00
	.byte $00,$03,$00,$00,$04,$05,$06,$00
price_food:
	.byte $04  ;Britain
	.byte $02  ;Jhelom
	.byte $03  ;Trinsic
	.byte $02  ;Paws
	.byte $04  ;Buccaneer's Den
	.byte $02  ;Vesper
price_rumor:
	.byte $20  ;Britain
	.byte $30  ;Jhelom
	.byte $10  ;Trinsic
	.byte $40  ;Paws
	.byte $99  ;Buccaneer's Den
	.byte $25  ;Vesper

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
	.byte "SAM", 0
; STRING $02 (2)
	.byte "CELESTIAL", 0
; STRING $03 (3)
	.byte "TERRAN", 0
; STRING $04 (4)
	.byte "GREG N ROB", 0
; STRING $05 (5)
	.byte "THE CAP'N", 0
; STRING $06 (6)
	.byte "ARRON", 0
; STRING $07 (7)
	.byte "JOLLY SPIRITS", 0
; STRING $08 (8)
	.byte "THE BLOODY PUB", 0
; STRING $09 (9)
	.byte "THE KEG TAP", 0
; STRING $0A (10)
	.byte "FOLLEY TAVERN", 0
; STRING $0B (11)
	.byte "CAPTAIN BLACK", $8d
	.byte "TAVERN", 0
; STRING $0C (12)
	.byte "AXE N ALE", 0
; STRING $0D (13)
	.byte "LAMB CHOPS", 0
; STRING $0E (14)
	.byte "DRAGON TARTAR", 0
; STRING $0F (15)
	.byte "BROWN BEANS", 0
; STRING $10 (16)
	.byte "FOLLEY FILET", 0
; STRING $11 (17)
	.byte "DOG MEAT PIE", 0
; STRING $12 (18)
	.byte "GREEN GRANUKIT", 0
; STRING $13 (19)
	.byte "AH, THE BLACK", $8d
	.byte "STONE, YES I'VE", $8d
	.byte "HEARD OF IT.", $8d
	.byte "BUT, ONLY THE", $8d
	.byte "ONE WHO KNOWS", $8d
	.byte "WHERE IT LIES", $8d
	.byte "IS THE WIZARD", $8d
	.byte "MERLIN.", $8d
	.byte 0
; STRING $14 (20)
	.byte "FOR NAVAGATION", $8d
	.byte "A SEXTANT IS", $8d
	.byte "VITAL... ASK", $8d
	.byte "FOR ITEM 'D'", $8d
	.byte "IN THE GUILD", $8d
	.byte "SHOPS!", $8d
	.byte 0
; STRING $15 (21)
	.byte "HMMM, NOW LET", $8d
	.byte "ME SEE...", $8d
	.byte "YES, IT WAS THE", $8d
	.byte "OLD HERMIT...", $8d
	.byte "SLOVEN! HE IS", $8d
	.byte "TOUGH TO FIND,", $8d
	.byte "LIVES NEAR LOCK", $8d
	.byte "LAKE I HEAR.", $8d
	.byte 0
; STRING $16 (22)
	.byte "THE LAST PERSON", $8d
	.byte "I KNEW THAT HAD", $8d
	.byte "ANY MANDRAKE", $8d
	.byte "WAS AN OLD", $8d
	.byte "ALCHEMIST NAMED", $8d
	.byte "CALUMNY.", $8d
	.byte 0
; STRING $17 (23)
	.byte "IF THOU MUST", $8d
	.byte "KNOW OF THAT", $8d
	.byte "EVILEST OF ALL", $8d
	.byte "THINGS... FIND", $8d
	.byte "THE BEGGAR", $8d
	.byte "JUDE. HE IS VERY", $8d
	.byte "VERY POOR!", $8d
	.byte 0
; STRING $18 (24)
	.byte "OF NIGHTSHADE I", $8d
	.byte "KNOW BUT THIS...", $8d
	.byte "SEEK OUT VIRGIL", $8d
	.byte "OR THOU SHALT", $8d
	.byte "MISS!", $8d
	.byte "TRY IN TRINSIC!", $8d
	.byte 0

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
	bcs @paid_ok
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

@paid_ok:
	lda #$00
	cld
	rts

; junk
	.byte 0
