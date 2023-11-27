	.include "uscii.i"

	.include "apple.i"
	.include "char.i"
	.include "jump_subs.i"
	.include "trainers.i"


; --- Custom use of Zero Page

ptr1 = $80
line = $d6


	.export menu


	.segment "MENU"

menu:
	jsr draw_menu
	lda #0
	jsr set_all_flags
	jsr draw_selections
	jsr selectline
	bmi waitkey

all:
	lda #1
	jsr set_all_flags
done:
	jsr deselectline
	jsr j_primm_cout
	.byte $84,"BRUN BOOT,A$6000", $8d, 0

set_all_flags:
	ldx #num_trainers
:	sta trainer_first,x
	dex
	bpl :-
	rts

waitkey:
	lda hw_KEYBOARD
	bpl waitkey
	bit hw_STROBE

	cmp #'A'
	beq all

	cmp #char_right_arrow
	beq @down
	cmp #char_left_arrow
	beq @up
	cmp #char_down_arrow
	beq @down
	cmp #char_up_arrow
	beq @up

	cmp #' '
	beq @toggle
	cmp #'N'
	beq @no
	cmp #'Y'
	beq @yes

	cmp #char_enter
	beq done

	bne waitkey


@toggle:
	ldx line
	lda trainer_first,x
	eor #$01
	bne @yes

@no:
	ldx line
	lda #0
	sta trainer_first,x
	jsr noline
	jmp waitkey

@yes:
	ldx line
	lda #1
	sta trainer_first,x
	jsr yesline
	jmp waitkey

@up:
	lda line
	beq waitkey

	jsr deselectline
	dec line
	jsr selectline

	jmp waitkey

@down:
	lda line
	cmp #num_trainers
	bcs waitkey

	jsr deselectline
	inc line
	jsr selectline

	jmp waitkey


draw_selections:
	lda #num_trainers
	sta line
:	jsr noline
	dec line
	bpl :-
	inc line
	rts
	
yesline:
	ldx #$17
	jsr primm_at_line
	.byte "YES no", 0
	rts

noline:
	ldx #$17
	jsr primm_at_line
	.byte "yes NO", 0
	rts

selectline:
	ldx #2
	jsr primm_at_line
	.byte $5f, 0
	rts

deselectline:
	ldx #2
	jsr primm_at_line
	.byte $1b, 0
	rts

primm_at_line:
	lda line
	clc
	adc #5
	tay
	jmp j_primm_xy


draw_menu:
	jsr clear_screen
	bit hw_PAGE1
	bit hw_HIRES
	bit hw_FULLSCREEN
	bit hw_GRAPHICS

	lda #$00
	jsr set_wrap_column

	ldx #0
	ldy #0
	jsr j_primm_xy
	.byte "     Ultima IV Remastered v1.2.9", $8d
	.byte "         S.Gugler, MagerValp", $8d
	.byte $8d
	.byte "Arrow Keys, Y-N-Space, A=All, Return", $8d
	.byte $8d
	.byte "  ", $1b, " Unlimited Magic", $8d
	.byte "  ", $1b, " Unlimited Food", $8d
	.byte "  ", $1b, " Unlimited Torches", $8d
	.byte "  ", $1b, " Unlimited Keys", $8d
	.byte "  ", $1b, " Unlimited Gems", $8d
	.byte "  ", $1b, " Avoid Combat", $8d
	.byte "  ", $1b, " Control Balloon", $8d
	.byte "  ", $1b, " Ingame Keys", $8d
	.byte "  ", $1b, " Idle Without Pass", $8d
	.byte "  ", $1b, " Confirm Towne Exit", $8d
	.byte "  ", $1b, " Fair Resell Price", $8d
	.byte $8d
	.byte "               Ingame Keys", $8d
	.byte $8d
	.byte "Key Effect           Args", $8d
	.byte $8d
	.byte " T  Teleport         Twn-Dgn-Shr-Coord", $8d
	.byte " B  Create Transport Horse-Ship-Balloon", 0

	ldx #30
	ldy #12
	jsr j_primm_xy
	.byte "see below", 0

	lda #$18
	jsr set_wrap_column
	rts

clear_screen:
	ldx #>screen_HGR1
	stx ptr1 + 1
	ldy #<screen_HGR1
	sty ptr1
	tya
@loop:
	sta (ptr1),y
	iny
	bne @loop
	inc ptr1 + 1
	dex
	bne @loop
	rts

set_wrap_column:
	; Hack console_newline
	pha
	lda j_primm_cout + 1
	sta ptr1
	lda j_primm_cout + 2
	sta ptr1 + 1
	dec ptr1 + 1
	pla
	ldy #256-17
	sta (ptr1),y
	rts
