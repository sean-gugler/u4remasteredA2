	.include "uscii.i"

	.include "char.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "tiles.i"

	.include "PRTY.i"
	.include "ROST.i"


	.segment "OVERLAY"

.assert * = j_overlay_entry, error, "Wrong start address"
	jsr j_primm
	.byte $8d
	.byte "WELCOME FRIEND!", $8d
	.byte "CAN I INTEREST", $8d
	.byte "THEE IN HORSES?", 0
	jsr input_char
	cmp #char_Y
	beq @show_price
@decline:
	jsr j_primm
	.byte $8d
	.byte "A SHAME, THOU", $8d
	.byte "LOOKS LIKE COULD", $8d
	.byte "USE A GOOD", $8d
	.byte "HORSE!", $8d
	.byte 0
	rts

@show_price:
	jsr j_primm
	.byte $8d
	.byte "FOR ONLY ", 0
	lda party_size
	jsr j_printdigit
	jsr j_primm
	.byte "00g.p.", $8d
	.byte "THOU CAN HAVE", $8d
	.byte "THE BEST! WILT", $8d
	.byte "THOU BUY?", 0
	jsr input_char
	cmp #char_Y
	beq @try_buy
	jmp @decline

@try_buy:
	sed
	sec
	lda gold_hi
	sbc party_size
	cld
	bcs @paid
	jsr j_primm
	.byte $8d
	.byte "IT SEEMS THOU", $8d
	.byte "HAST NOT GOLD", $8d
	.byte "ENOUGH TO PAY!", $8d
	.byte 0
	rts

@paid:
	sta gold_hi
	jsr j_primm
	.byte $8d
	.byte "HERE, A BETTER", $8d
	.byte "BREED THOU SHALT", $8d
	.byte "NOT FIND EVER!", $8d
	.byte 0
	lda #tile_horse_west
	sta player_transport
	rts

input_char:
	jsr j_waitkey
	beq input_char
	pha
	jsr j_console_out
	lda #char_enter
	jsr j_console_out
	pla
	rts

; junk
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	.byte $ff,$ff
