	.include "uscii.i"
	.include "SEAR.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
player_xpos = $00
player_ypos = $01
current_location = $0a
game_mode = $0b
curr_player = $d4
zp_index = $d8
;
; **** ZP POINTERS ****
;
ptr1 = $fe
;
; **** USER LABELS ****
;
j_waitkey = $0800
j_primm_exact = $081b
j_primm = $0821
j_console_out = $0824
j_get_stats_ptr = $082d
j_printstring = $087e
map_buf = $8b00
;map_buf+$100 = $8c00
;map_buf+$200 = $8d00
;map_buf+$300 = $8e00
j_viewmap = $9000
gem_buf = $e800
;gem_buf+$100 = $e900
;gem_buf+$200 = $ea00
;gem_buf+$300 = $eb00
party_stats = $ed00
;party_stats + virtue_honor = $ed05
runes = $ed0d
bell_book_candle = $ed0e
mystic_armour = $ed1f
mystic_weapons = $ed2f


	.segment "OVERLAY"

search:
	ldy #$0c
@next:
	jsr compare_position
	beq item_at_coordinate
	dey
	bpl @next
print_nothing_here:
	jsr j_primm  ;b'NOTHING HERE!\r\x00'
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
	jsr j_primm  ;b'THE RUNE OF\r\x00'
	.byte "THE RUNE OF", $8d
	.byte 0
	lda zp_index
	clc
	adc #string_virtues
	jsr j_printstring
	jsr j_primm  ;b'!\r\x00'
	.byte "!", $8d
	.byte 0
	lda #$01
	jsr add_xp100
	rts

find_book:
	lda bell_book_candle
	and #$02
	beq @found
	jmp print_nothing_here

@found:
	lda bell_book_candle
	ora #$02
	sta bell_book_candle
	jsr print_you_find
	jsr j_primm  ;b'THE BOOK\rOF TRUTH!\r\x00'
	.byte "THE BOOK", $8d
	.byte "OF TRUTH!", $8d
	.byte 0
	lda #$04
	jsr add_xp100
	rts

find_candle:
	lda bell_book_candle
	and #$01
	beq @found
	jmp print_nothing_here

@found:
	lda bell_book_candle
	ora #$01
	sta bell_book_candle
	jsr print_you_find
	jsr j_primm  ;b'THE CANDLE\rOF LOVE!\r\x00'
	.byte "THE CANDLE", $8d
	.byte "OF LOVE!", $8d
	.byte 0
	lda #$04
	jsr add_xp100
	rts

find_telescope:
	jsr j_primm  ;b'YOU SEE A KNOB\rON THE TELESCOPE\rMARKED A-P\rYOU SELECT:\x00'
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
	cmp #char_Q
	bcc @view_location
@nothing_here:
	jmp print_nothing_here

@view_location:
	sta file_char_map
	jsr j_primm_exact ;b'\x04BLOAD MAP@,A$8B00\r\x00'
	.byte $84,"BLOAD MAP"
file_char_map:
	.byte "@,A$8B00", $8d
	.byte 0
	jsr copymap
	jsr j_primm_exact ;b'\x04BLOAD TMAP,A$9000\r\x00'
	.byte $84,"BLOAD TMAP,A$9000", $8d
	.byte 0
	lda #$00
	sta game_mode
	jsr j_viewmap
	lda #$02
	sta game_mode
	jsr j_primm_exact ;b'\x04BLOAD MAPB,A$8B00\r\x00'
	.byte $84,"BLOAD MAPB,A$8B00", $8d
	.byte 0
	jsr copymap
	rts

copymap:
	ldx #$00
@copy:
	lda map_buf,x
	sta gem_buf,x
	lda map_buf+$100,x
	sta gem_buf+$100,x
	lda map_buf+$200,x
	sta gem_buf+$200,x
	lda map_buf+$300,x
	sta gem_buf+$300,x
	inx
	bne @copy
	rts

find_mystic_armour:
	ldx #$07
	lda #$00
@next_virtue:
	ora party_stats,x
	dex
	bpl @next_virtue
	cmp #$00
	beq @avatar
	jmp print_nothing_here

@avatar:
	lda mystic_armour
	beq @found
	jmp print_nothing_here

@found:
	jsr print_you_find
	jsr j_primm  ;b'MYSTIC ARMOUR!\r\x00'
	.byte "MYSTIC ARMOUR!", $8d
	.byte 0
	lda #$08
	sta mystic_armour
	lda #$04
	jsr add_xp100
	rts

find_mystic_weapons:
	ldx #$07
	lda #$00
@next_virtue:
	ora party_stats,x
	dex
	bpl @next_virtue
	cmp #$00
	beq @avatar
	jmp print_nothing_here

@avatar:
	lda mystic_weapons
	beq @found
	jmp print_nothing_here

@found:
	jsr print_you_find
	jsr j_primm  ;b'MYSTIC WEAPONS!\r\x00'
	.byte "MYSTIC WEAPONS!", $8d
	.byte 0
	lda #$08
	sta mystic_weapons
	lda #$04
	jsr add_xp100
	rts

print_you_find:
	jsr j_primm  ;b'YOU FIND...\r\x00'
	.byte "YOU FIND...", $8d
	.byte 0
	sed
	clc
	lda party_stats + virtue_honor
	beq @overflow
	adc #$05
	bcc @overflow
	lda #$99
@overflow:
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

add_xp100:
	pha
	lda #$01
	sta curr_player
	jsr j_get_stats_ptr
	ldy #$1c
	sed
	pla
	clc
	adc (ptr1),y
	bcc @overflow
	lda #$99
	iny
	sta (ptr1),y
	dey
@overflow:
	sta (ptr1),y
	cld
	rts

	.byte 0
