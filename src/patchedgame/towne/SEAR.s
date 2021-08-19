	.include "uscii.i"

	.include "char.i"
	.include "strings.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "view_map.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


; --- Custom use of Zero Page

zp_index = $d8


	.segment "OVERLAY"

.assert * = j_overlay_entry, error, "Wrong start address"

search:
	ldy #item_last - 1
@next:
	jsr compare_position
	beq item_at_coordinate
	dey
	bpl @next
print_nothing_here:
	jsr j_primm
	.byte "NOTHING HERE!", $8d
	.byte 0
	rts

item_at_coordinate:
	cpy #$08
	bcc find_rune
	beq find_book
	cpy #$09
	beq find_candle
	cpy #$0a
	bne @check_armour
	jmp find_telescope

@check_armour:
	cpy #$0b
	bne @check_weapons
	jmp find_mystic_armour

@check_weapons:
	jmp find_mystic_weapons

find_rune:
	lda bit_msb,y
	and runes
	bne print_nothing_here
	lda runes
	ora bit_msb,y
	sta runes
	sty zp_index
	jsr print_you_find
	jsr j_primm
	.byte "THE RUNE OF", $8d
	.byte 0
	lda zp_index
	clc
	adc #string_virtues
	jsr j_printstring
	jsr j_primm
	.byte "!", $8d
	.byte 0
	lda #$01
	jsr add_xp100
	rts

find_book:
	lda bell_book_candle
	and #item_have_book
	beq @found
	jmp print_nothing_here

@found:
	lda bell_book_candle
	ora #item_have_book
	sta bell_book_candle
	jsr print_you_find
	jsr j_primm
	.byte "THE BOOK", $8d
	.byte "OF TRUTH!", $8d
	.byte 0
	lda #$04
	jsr add_xp100
	rts

find_candle:
	lda bell_book_candle
	and #item_have_candle
	beq @found
	jmp print_nothing_here

@found:
	lda bell_book_candle
	ora #item_have_candle
	sta bell_book_candle
	jsr print_you_find
	jsr j_primm
	.byte "THE CANDLE", $8d
	.byte "OF LOVE!", $8d
	.byte 0
	lda #$04
	jsr add_xp100
	rts

find_telescope:
	jsr j_primm
	.byte "YOU SEE A KNOB", $8d
	.byte "ON THE TELESCOPE", $8d
	.byte "MARKED A-P", $8d
	.byte "YOU SELECT:", 0
@waitkey:
	jsr j_waitkey
	beq @waitkey
	pha
	jsr j_console_out
	lda #char_enter
	jsr j_console_out
	pla
	cmp #char_A
	bcc @nothing_here
	cmp #char_P + 1
	bcc @view_location
@nothing_here:
	jmp print_nothing_here

@view_location:
	sta file_char_map
	jsr j_primm_cout
	.byte $84,"BLOAD MAP"
file_char_map:
	.byte "@,A$8B00", $8d
	.byte 0
	jsr copymap
	jsr j_primm_cout
	.byte $84,"BLOAD TMAP,A$9000", $8d
	.byte 0
	lda #mode_suspended
	sta game_mode
	jsr j_viewmap
	lda #mode_towne
	sta game_mode
	jsr j_primm_cout
	.byte $84,"BLOAD MAPB,A$8B00", $8d
	.byte 0
	jsr copymap
	rts

copymap:
	ldx #$00
@copy:
	lda load_buf,x
	sta view_buf,x
	lda load_buf+$100,x
	sta view_buf+$100,x
	lda load_buf+$200,x
	sta view_buf+$200,x
	lda load_buf+$300,x
	sta view_buf+$300,x
	inx
	bne @copy
	rts

find_mystic_armour:
	ldx #virtue_last - 1
	lda #$00
@next_virtue:
	ora party_stats,x
	dex
	bpl @next_virtue
	cmp #$00
	beq @avatar
	jmp print_nothing_here

@avatar:
	lda armour_mystic
	beq @found
	jmp print_nothing_here

@found:
	jsr print_you_find
	jsr j_primm
	.byte "MYSTIC ARMOUR!", $8d
	.byte 0
	lda #$08
	sta armour_mystic
	lda #$04
	jsr add_xp100
	rts

find_mystic_weapons:
	ldx #virtue_last - 1
	lda #$00
@next_virtue:
	ora party_stats,x
	dex
	bpl @next_virtue
	cmp #$00
	beq @avatar
	jmp print_nothing_here

@avatar:
	lda weapon_mystic
	beq @found
	jmp print_nothing_here

@found:
	jsr print_you_find
	jsr j_primm
	.byte "MYSTIC WEAPONS!", $8d
	.byte 0
	lda #$08
	sta weapon_mystic
	lda #$04
	jsr add_xp100
	rts

print_you_find:
	jsr j_primm
	.byte "YOU FIND...", $8d
	.byte 0
	sed
	clc
	lda party_stats + virtue_honor
	beq @set_value
	adc #$05
	bcc @set_value
	lda #$99
@set_value:
	sta party_stats + virtue_honor
	cld
	rts

bit_msb:
	.byte $80,$40,$20,$10,$08,$04,$02,$01

compare_position:
	lda player_xpos
	cmp item_xpos,y
	bne @nothing_here
	lda player_ypos
	cmp item_ypos,y
	bne @nothing_here
	lda current_location
	cmp item_location,y
	bne @nothing_here
	lda #$00
	rts

@nothing_here:
	lda #$ff
	rts

item_xpos:
	.byte $08,$19,$1e,$0d,$1c,$02,$11,$1d
	.byte $06,$16,$16,$16,$08
item_ypos:
	.byte $06,$01,$1e,$06,$1e,$1d,$08,$1d
	.byte $06,$01,$03,$04,$0f
item_location:
	.byte $05,$06,$07,$08,$09,$0a,$01,$0d
	.byte $02,$10,$02,$03,$04
item_last = * - item_location

add_xp100:
	pha
	lda #$01
	sta curr_player
	jsr j_get_stats_ptr
	ldy #player_experience_hi
	sed
	pla
	clc
	adc (ptr1),y
	bcc @set_value
	lda #$99
	iny
	sta (ptr1),y
	dey
@set_value:
	sta (ptr1),y
	cld
	rts

;junk
;	.byte 0
