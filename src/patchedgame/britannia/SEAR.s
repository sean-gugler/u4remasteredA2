	.include "uscii.i"

	.include "jump_subs.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


	.segment "OVERLAY"

j_overlay_entry:
	ldy #item_count - 1
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
	tya
	asl
	tay
	lda jump_table,y
	sta ptr1
	lda jump_table + 1,y
	sta ptr1 + 1
	jmp (ptr1)

jump_table:
	.addr find_mandrake
	.addr find_mandrake
	.addr find_nightshade
	.addr find_nightshade
	.addr find_bell
	.addr find_horn
	.addr find_wheel
	.addr find_skull
	.addr find_black_stone
	.addr find_white_stone

print_you_find:
	jsr j_primm
	.byte "YOU FIND...", $8d
	.byte 0
	lda move_counter + 3
	and #$f0
	sta last_found_reagent
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

find_mandrake:
	lda moon_phase_trammel
	ora moon_phase_felucca
	beq @dark_moons
	jmp print_nothing_here

@dark_moons:
	lda move_counter + 3
	and #$f0
	cmp last_found_reagent
	bne @found
	jmp print_nothing_here

@found:
	jsr print_you_find
	jsr j_primm
	.byte "MANDRAKE ROOT!", $8d
	.byte 0
	ldy #reagent_mandrake
award_reagent:
	jsr j_rand
	and #$07
	clc
	adc #$02
	sed
	clc
	adc reagents,y
	bcc @set_value
	lda #$99
@set_value:
	sta reagents,y
	cld
	rts

find_nightshade:
	lda moon_phase_trammel
	ora moon_phase_felucca
	beq @dark_moons
	jmp print_nothing_here

@dark_moons:
	lda move_counter + 3
	and #$f0
	cmp last_found_reagent
	bne @found
	jmp print_nothing_here

@found:
	jsr print_you_find
	jsr j_primm
	.byte "NIGHTSHADE!", $8d
	.byte 0
	ldy #reagent_nightshade
	jmp award_reagent

find_bell:
	lda bell_book_candle
	and #item_have_bell
	beq @found
	jmp print_nothing_here

@found:
	lda bell_book_candle
	ora #item_have_bell
	sta bell_book_candle
	jsr print_you_find
	jsr j_primm
	.byte "THE BELL OF", $8d
	.byte "COURAGE!", $8d
	.byte 0
	lda #$04
	jsr add_xp100
	rts

find_black_stone:
	lda moon_phase_trammel
	ora moon_phase_felucca
	bne @dark_moons
	lda stones
	and #stone_black
	beq @found
@dark_moons:
	jmp print_nothing_here

@found:
	lda stones
	ora #stone_black
	sta stones
	jsr print_you_find
	jsr j_primm
	.byte "THE BLACK STONE!", $8d
	.byte 0
	lda #$02
	jsr add_xp100
	rts

find_white_stone:
	lda stones
	and #stone_white
	beq @found
	jmp print_nothing_here

@found:
	lda stones
	ora #stone_white
	sta stones
	jsr print_you_find
	jsr j_primm
	.byte "THE WHITE STONE!", $8d
	.byte 0
	lda #$02
	jsr add_xp100
	rts

find_horn:
	lda horn
	beq @found
	jmp print_nothing_here

@found:
	inc horn
	jsr print_you_find
	jsr j_primm
	.byte "A SILVER HORN!", $8d
	.byte 0
	lda #$04
	jsr add_xp100
	rts

find_wheel:
	lda wheel
	beq @found
	jmp print_nothing_here

@found:
	inc wheel
	jsr print_you_find
	jsr j_primm
	.byte "THE WHEEL FROM", $8d
	.byte "THE H.M.S. CAPE!", 0
	lda #$04
	jsr add_xp100
	rts

find_skull:
	lda moon_phase_trammel
	ora moon_phase_felucca
	beq @dark_moons
	jmp print_nothing_here

@dark_moons:
	lda skull
	beq @found
	jmp print_nothing_here

@found:
	inc skull
	jsr print_you_find
	jsr j_primm
	.byte "THE SKULL", $8d
	.byte "OF MONDAIN", $8d
	.byte "THE WIZARD!", $8d
	.byte 0
	lda #$04
	jsr add_xp100
	rts

compare_position:
	lda player_xpos
	cmp item_xpos,y
	bne @nothing_here
	lda player_ypos
	cmp item_ypos,y
	bne @nothing_here
	lda #$00
	rts

@nothing_here:
	lda #$ff
	rts

item_xpos:
	.byte $b6,$64,$2e,$cd,$b0,$2d,$60,$c5
	.byte $e0,$40
item_ypos:
	.byte $36,$a5,$95,$2c,$d0,$ad,$d7,$f5
	.byte $85,$50
item_count = * - item_ypos

add_xp100:
	pha
	lda #$01
	sta curr_player
	jsr j_get_stats_ptr
	ldy #player_experience_hi
	sed
	clc
	pla
	adc (ptr1),y
	cld
	bcc @set_value
	lda #$99
	iny
	sta (ptr1),y
	dey
@set_value:
	sta (ptr1),y
	rts

; junk
;	and $A008
;	clc
;	lda (ptr1),y
;	ldy #$1a
;	cmp (ptr1),y
;	.byte $d0,$0e  ;bne +14
