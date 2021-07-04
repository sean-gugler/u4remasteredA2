;	.include "kernal.i"
;	.include "trainer.i"
	.include "uscii.i"


	.export menu

char_left_arrow = $88
char_down_arrow = $8a
char_up_arrow = $8b
char_enter = $8d
char_right_arrow = $95

ptr1 = $80
line = $d6

j_waitkey = $0800
j_player_teleport = $0803
j_move_east = $0806
j_move_west = $0809
j_move_south = $080c
j_move_north = $080f
j_drawinterface = $0812
j_drawview = $0815
j_update_britannia = $0818
j_primm_cout = $081b
j_primm_xy = $081e
j_primm = $0821
j_console_out = $0824
j_clearbitmap = $0827
j_mulax = $082a
j_get_stats_ptr = $082d
j_printname = $0830
j_printbcd = $0833
j_drawcursor = $0836
j_drawcursor_xy = $0839
j_drawvert = $083c
j_drawhoriz = $083f
j_request_disk = $0842
j_update_status = $0845
j_blocked_tile = $0848
j_update_view = $084b
j_rand = $084e
j_loadsector = $0851
j_playsfx = $0854
j_update_view_combat = $0857
j_getnumber = $085a
j_getplayernum = $085d
j_update_wind = $0860
j_animate_view = $0863
j_printdigit = $0866
j_clearstatwindow = $0869
j_animate_creatures = $086c
j_centername = $086f
j_print_direction = $0872
j_clearview = $0875
j_invertview = $0878
j_centerstring = $087b
j_printstring = $087e
j_gettile_bounds = $0881
j_gettile_britannia = $0884
j_gettile_opposite = $0887
j_gettile_currmap = $088a
j_gettile_tempmap = $088d
j_get_player_tile = $0890
j_gettile_towne = $0893
j_gettile_dungeon = $0896

bitmap = $2000

trainer_first = $9a90
max_trainer = $09

hw_keyboard = $c000
hw_strobe = $c010
io_graphics = $c050
io_fullscreen = $c052
io_page1 = $c054
io_hires = $c057

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
	jsr j_primm_cout
	.byte $84,"BRUN BOOT,A$6000", $8d, 0

set_all_flags:
	ldx #max_trainer
:	sta trainer_first,x
	dex
	bpl :-
	rts

waitkey:
	lda hw_keyboard
	bpl waitkey
	bit hw_strobe

	cmp #'A'
	beq all

	cmp #char_right_arrow
	beq @down
	cmp #char_left_arrow
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
	cmp #max_trainer
	bcs waitkey

	jsr deselectline
	inc line
	jsr selectline

	jmp waitkey


draw_selections:
	lda #max_trainer
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
	bit io_page1
	bit io_hires
	bit io_fullscreen
	bit io_graphics

	lda #$00
	jsr set_wrap_column

	ldx #0
	ldy #0
	jsr j_primm_xy
	.byte "     Ultima IV Remastered v1.1.0", $8d
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
	ldx #>bitmap
	stx ptr1 + 1
	ldy #<bitmap
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
