	.include "uscii.i"

	.include "char.i"
	.include "sound.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "tables.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


; --- Custom use of Zero Page

zp_price = $d8
zp_index = $ea
zp_count = $f0

zp_save_reg = $d9
; for consistency these should have been the same
zp_dec_amount = $da
zp_inc_amount = $d9


	.segment "OVERLAY"

.assert * = j_overlay_entry, error, "Wrong start address"
	jsr j_primm
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
	jsr j_primm
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
	jsr j_primm
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
	jsr j_primm
	.byte $8d
	.byte "THOU SUFFERS NOT", $8d
	.byte "FROM POISON!", $8d
	.byte 0
	jmp ask_more

is_poisoned:
	jsr j_primm
	.byte $8d
	.byte "A CURING WILL", $8d
	.byte "COST THEE 100gp.", $8d
	.byte 0
	lda gold_hi
	beq @no_money
	jmp try_cure

@no_money:
	jsr j_primm
	.byte $8d
	.byte "I SEE BY THY", $8d
	.byte "PURSE THAT THOU", $8d
	.byte "HAST NOT ENOUGH", $8d
	.byte "GOLD.", 0
	jsr j_waitkey
	jsr j_primm
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
	jsr j_primm
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
	jsr j_primm
	.byte $8d
	.byte "THOU ART NOT", $8d
	.byte "DEAD FOOL!", $8d
	.byte 0
	jmp ask_more

is_dead:
	jsr j_primm
	.byte $8d
	.byte "RESURRECTION", $8d
	.byte "WILL COST THEE", $8d
	.byte "300gp.", $8d
	.byte 0
	lda gold_hi
	cmp #$03
	bcs do_resurrect
cannot_afford:
	jsr j_primm
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
	jsr j_primm
	.byte " ASKS:", $8d
	.byte "WHO IS IN NEED?", 0
	jsr j_getplayernum
	bne @validate
	jsr j_primm
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
	jsr j_primm
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
	ldy #player_cur_hp_hi
	lda (ptr1),y
	cmp #$04
	bcs ask_donate
bye:
	jsr print_newline
	clc
	lda zp_index
	adc #$0b
	jsr print_string
	jsr j_primm
	.byte " SAYS:", $8d
	.byte "MAY THY LIFE", $8d
	.byte "BE GUARDED BY", $8d
	.byte "THE POWERS OF", $8d
	.byte "GOOD.", $8d
	.byte 0
	rts

ask_donate:
	jsr j_primm
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
	jsr j_primm
	.byte $8d
	.byte "THOU ART A", $8d
	.byte "GREAT HELP, WE", $8d
	.byte "ARE IN DIRE", $8d
	.byte "NEED!", $8d
	.byte 0
	jsr j_get_stats_ptr
	ldy #player_cur_hp_hi
	lda (ptr1),y
	sec
	sed
	sbc #$01
	cld
	sta (ptr1),y
	lda #$0a     ;delay 10 update cycles
	sta zp_index
:	jsr j_update_view
	dec zp_index
	bne :-
	jmp bye

ask_pay:
	sta zp_price
	jsr j_primm
	.byte $8d
	.byte "WILT THOU PAY?", 0
	jsr input_char
	cmp #char_Y
	beq dec_gold
	pla
	pla
	jsr j_primm
	.byte $8d
	.byte "THEN I CANNOT", $8d
	.byte "AID THEE.", $8d
	.byte 0
	jmp ask_more

dec_gold:
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

price_unused:  ;copy-pasted from SHP2
	.byte 0
location_table:
	.byte $01,$02,$03,$04,$05,$06,$07,$08
	.byte $00,$00,$09,$00,$00,$00,$00,$0a
price_table_unused:  ;copy-pasted from SHP2
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
; STRING $00 (0)
	.byte 0
; STRING $01 (1)
	.byte "THE ROYAL HEALER", 0
; STRING $02 (2)
	.byte "THE TRUTH HEALER", 0
; STRING $03 (3)
	.byte "THE LOVE HEALER", 0
; STRING $04 (4)
	.byte "COURAGE HEALER", 0
; STRING $05 (5)
	.byte "THE HEALER", 0
; STRING $06 (6)
	.byte "WOUND HEALING", 0
; STRING $07 (7)
	.byte "HEAL AND HEALTH", 0
; STRING $08 (8)
	.byte "JUST HEALING", 0
; STRING $09 (9)
	.byte "THE MYSTIC HEAL", 0
; STRING $0A (10)
	.byte "THE HEALER SHOP", 0
; STRING $0B (11)
	.byte "PENDRAGON", 0
; STRING $0C (12)
	.byte "STARFIRE", 0
; STRING $0D (13)
	.byte "SALLE'", 0
; STRING $0E (14)
	.byte "WINDWALKER", 0
; STRING $0F (15)
	.byte "HARMONY", 0
; STRING $10 (16)
	.byte "CELEST", 0
; STRING $11 (17)
	.byte "TRIPLET", 0
; STRING $12 (18)
	.byte "JUSTIN", 0
; STRING $13 (19)
	.byte "SPIRAN", 0
; STRING $14 (20)
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

; junk "RI AM VERY SO"
;	.byte $52,$49,$20,$41,$4d,$20,$56,$45
;	.byte $52,$59,$20,$53,$4f

; NOTE: file length field is truncated in 4am source disks by 20 bytes.
; It cuts off after "LOST" even though remainder is present in full sector.
