	.include "uscii.i"

	.include "apple.i"
	.include "char.i"
	.include "disks.i"
	.include "map_objects.i"
	.include "music.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "jump_system.i"
	.include "tables.i"
	.include "tiles.i"
	.include "zp_demo.i"
	.include "zp_main.i"
	.include "zp_music.i"


; Placeholder operands that get altered
; by self-modifying code.

TMP_PAGE = $ff00
TMP_ADDR = $ffff


; --- Custom use of Zero Page

zp_keybuf_count = $ea


	.segment "MAIN"

boot:
	jsr j_primm_cout
	.byte $84,"BLOAD A", $81, "NIM,A$4000", $8d
	.byte $84,"BLOAD B", $81, "GND,A$7A00", $8d
	.byte 0
	jsr clear_screen
	bit hw_PAGE1
	bit hw_HIRES
	bit hw_FULLSCREEN
	bit hw_GRAPHICS
	lda #<demo_cmd_table
	sta ptr_demo
	lda #>demo_cmd_table
	sta ptr_demo + 1
	lda #$00
	sta demo_hold_count
	ldx #$00
	txa
init_map_objects:
	sta object_tile_sprite,x
	dex
	bne init_map_objects
	jsr draw_signature
	jsr long_pause
	jsr draw_and
	jsr long_pause
	jsr draw_blue_separator
	jsr long_pause
	jsr draw_origin_systems
	jsr draw_present
	jsr long_pause
	jsr draw_ultima_logo
	jsr long_pause
	jsr draw_quest_title
	jsr long_pause
	jsr draw_map_window
	jsr draw_captive_scroll
	jmp start_attract_mode

plot_column:
	.byte $30
plot_row:
	.byte $0d
src_column:
	.byte $da
src_row:
	.byte $08
dst_column:
	.byte $db
dst_row:
	.byte $20
num_rows:
	.byte $24
num_columns:
	.byte $38
blit_page_offset:
	.byte $30

clear_screen:
	ldx #>screen_HGR1
	stx ptr1_bitmap + 1
	ldy #<screen_HGR1
	sty ptr1_bitmap
	tya
@loop:
	sta (ptr1_bitmap),y
	iny
	bne @loop
	inc ptr1_bitmap + 1
	dex
	bne @loop
	rts

draw_signature:
	lda #<pixel_writing
	sta ptr1_bitmap
	lda #>pixel_writing
	sta ptr1_bitmap + 1
@next_pixel:
	ldx #$00
	lda (ptr1_bitmap,x)
	beq @done
	sta plot_column
	jsr inc_ptr_table
	lda #$bf     ;invert Y-axis
	sec
	sbc (ptr1_bitmap,x)
	sta plot_row
	jsr inc_ptr_table
	jsr hplot_white
	lda #$40
	jsr short_pause
	jmp @next_pixel

@done:
	rts

draw_and:
	lda #$00     ;mode solid
	sta blit_mode
	lda #$13
	sta src_column
	sta dst_column
	lda #$11
	sta src_row
	sta dst_row
	ldx #$04
	ldy #$04
	jsr blit_image
	rts

draw_blue_separator:
	lda #$40
	sta plot_column
	lda #$1f
	sta plot_row
@loop:
	jsr hplot_xy
	lda #$30
	jsr short_pause
	inc plot_column
	inc plot_column
	lda plot_column
	cmp #$d9
	bcc @loop
	rts

draw_ultima_logo:
	lda #$ff     ;mode random
	sta blit_mode
	lda #$00
	sta blit_progress
@next_progress:
	lda #$05
	sta src_column
	sta dst_column
	lda #$22
	sta src_row
	sta dst_row
	bit hw_KEYBOARD
	bpl :+
	lda #$38
	sta blit_progress
:	ldx #$1e     ;width of logo, in bytes
	ldy #$2d     ;height of logo, in pixels
	jsr blit_image
	lda blit_progress
	clc
	adc #$01
	sta blit_progress
	cmp #$39
	bcc @next_progress
	rts

blit_image:
	stx blit_width
	sty num_rows
@do_row:
	lda blit_width
	sta num_columns
	ldy src_row
	lda bmplineaddr_lo,y
	sta ptr1_bitmap
	lda bmplineaddr_hi,y
	clc
	adc #$5a     ;ptr1 = BGND
	sta ptr1_bitmap + 1
	ldy dst_row
	lda bmplineaddr_lo,y
	sta ptr2_bitmap
	lda bmplineaddr_hi,y
	sta ptr2_bitmap + 1
	ldy dst_column
@do_column:
	lda (ptr1_bitmap),y
	and #$7f
	beq @next_column
	bit blit_mode
	beq @write_byte
	pha
	lda mask_rand1
	adc #$1d
	tax
	adc mask_rand2
	sta mask_rand1
	stx mask_rand2
	pha
	and #$07
	sta rand_8
	pla
	clc
	adc blit_progress
	bcc :+
	bit hw_SPEAKER
:	lda blit_progress
	clc
	adc rand_8
	tax
	lda blit_mask_table,x
	sta blit_mask
	pla
	and blit_mask
	ora #$80
@write_byte:
	sta (ptr2_bitmap),y
@next_column:
	iny
	dec num_columns
	bne @do_column
	inc src_row
	inc dst_row
	dec num_rows
	bne @do_row
	rts

mask_rand1:
	.byte $35
mask_rand2:
	.byte $9b
blit_width:
	.byte $dc
blit_mode:
	.byte $20
blit_progress:
	.byte $24
rand_8:
	.byte $31
blit_mask:
	.byte $45
blit_mask_table:
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$01,$02,$04,$08,$12,$20,$21
	.byte $10,$18,$40,$24,$42,$25,$14,$1a
	.byte $48,$29,$14,$52,$54,$55,$4a,$59
	.byte $45,$5a,$2a,$6c,$36,$37,$6a,$67
	.byte $4d,$5e,$39,$6d,$3b,$6f,$57,$7d
	.byte $5d,$7e,$6b,$7b,$77,$ff,$5f,$3f
	.byte $7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f

hplot_white:
	inc plot_column
	jsr hplot_xy
	dec plot_column
hplot_xy:
	lda plot_row
	tay
	lsr
	lda #$00
	ror
	sta row_parity
	lda bmplineaddr_lo,y
	sta ptr_bitmap
	lda bmplineaddr_hi,y
	sta ptr_bitmap + 1
	ldx plot_column
	lda bmpcol_bit,x
	ldy bmpcol_byte,x
	ora (ptr_bitmap),y
	ora row_parity
	sta (ptr_bitmap),y
	rts

row_parity:
	.byte $55
inc_ptr_table:
	inc ptr1_bitmap
	bne :+
	inc ptr1_bitmap + 1
:	rts

long_pause:
	ldy #$04
@delay:
	lda #$ff
	jsr short_pause
	dey
	bne @delay
	rts

short_pause:
	bit hw_KEYBOARD
	bmi @done
	sec
@delay:
	pha
:	sbc #$01
	bne :-
	pla
	sbc #$01
	bne @delay
@done:
	rts

; Table of X,Y coordinates with (0,0) at bottom left.
pixel_writing:
	.byte $54,$bd,$55,$bc,$57,$bc,$59,$bc
	.byte $5b,$bc,$5c,$bd,$5c,$be,$5b,$bf
	.byte $59,$bf,$58,$be,$58,$bd,$57,$bb
	.byte $56,$ba,$56,$b9,$55,$b8,$55,$b7
	.byte $54,$b6,$54,$b5,$53,$b4,$53,$b3
	.byte $52,$b2,$52,$b1,$51,$b0,$4f,$b0
	.byte $4e,$b0,$4d,$b1,$4d,$b2,$4e,$b3
	.byte $50,$b3,$51,$b2,$54,$b2,$55,$b1
	.byte $56,$b1,$57,$b0,$59,$b0,$5b,$b0
	.byte $5d,$b0,$5f,$b0,$61,$b0,$63,$b0
	.byte $65,$b0,$67,$b0,$69,$b0,$6b,$b0
	.byte $6d,$b0,$6f,$b0,$71,$b0,$73,$b0
	.byte $75,$b0,$77,$b0,$79,$b0,$7b,$b0
	.byte $7d,$b0,$7f,$b0,$81,$b0,$83,$b0
	.byte $85,$b0,$87,$b0,$89,$b0,$8b,$b0
	.byte $8d,$b0,$8f,$b0,$91,$b0,$93,$b0
	.byte $95,$b0,$97,$b0,$99,$b0,$9b,$b0
	.byte $9d,$b0,$9f,$b0,$a1,$b0,$a3,$b0
	.byte $a5,$b0,$a7,$b0,$a9,$b0,$ab,$b0
	.byte $ad,$b0,$af,$b0,$b1,$b0,$b3,$b0
	.byte $b5,$b0,$b7,$b0,$b9,$b0,$bb,$b0
	.byte $bd,$b0,$bf,$b0,$c1,$b0,$c3,$b0
	.byte $c5,$b0,$c7,$b0,$c9,$b0,$ca,$b0
	.byte $cb,$b1,$cc,$b1,$cd,$b2,$5e,$b8
	.byte $5e,$b7,$5d,$b6,$5d,$b5,$5c,$b4
	.byte $5c,$b3,$5d,$b2,$5f,$b2,$60,$b2
	.byte $61,$b3,$61,$b4,$62,$b5,$62,$b6
	.byte $63,$b7,$63,$b8,$62,$b9,$60,$b9
	.byte $5f,$b9,$69,$b9,$6a,$b8,$6a,$b7
	.byte $69,$b6,$69,$b5,$68,$b4,$68,$b3
	.byte $67,$b2,$6b,$b8,$6c,$b9,$6e,$b9
	.byte $77,$b9,$75,$b9,$74,$b9,$73,$b8
	.byte $73,$b7,$72,$b6,$72,$b5,$71,$b4
	.byte $71,$b3,$72,$b2,$74,$b2,$75,$b3
	.byte $76,$b4,$77,$b5,$77,$b6,$78,$b7
	.byte $78,$b8,$79,$b9,$79,$ba,$7a,$bb
	.byte $7a,$bc,$7b,$bd,$7b,$be,$76,$b3
	.byte $77,$b2,$8b,$be,$8b,$bd,$8a,$bc
	.byte $8a,$bb,$89,$ba,$89,$b9,$88,$b8
	.byte $88,$b7,$87,$b6,$87,$b5,$86,$b4
	.byte $86,$b3,$85,$b2,$8c,$bf,$8e,$bf
	.byte $8f,$bf,$90,$be,$90,$bd,$8f,$bc
	.byte $8f,$bb,$8e,$ba,$8e,$b9,$8c,$b9
	.byte $8f,$b8,$8f,$b7,$8e,$b6,$8e,$b5
	.byte $8d,$b4,$8d,$b3,$8c,$b2,$8a,$b2
	.byte $88,$b2,$87,$b3,$96,$b9,$97,$b8
	.byte $97,$b7,$96,$b6,$96,$b5,$95,$b4
	.byte $95,$b3,$94,$b2,$98,$b8,$99,$b9
	.byte $9b,$b9,$a1,$b9,$a0,$b8,$a0,$b7
	.byte $9f,$b6,$9f,$b5,$9e,$b4,$9e,$b3
	.byte $9d,$b2,$a2,$bc,$a2,$bb,$a9,$bc
	.byte $a9,$bb,$a8,$ba,$a8,$b9,$a7,$b8
	.byte $a7,$b7,$a6,$b6,$a6,$b5,$a5,$b4
	.byte $a5,$b3,$a6,$b2,$a8,$b2,$a9,$b2
	.byte $aa,$b3,$a5,$b9,$a6,$b9,$aa,$b9
	.byte $b2,$b9,$b1,$b8,$b1,$b7,$b0,$b6
	.byte $b0,$b5,$af,$b4,$af,$b3,$ae,$b2
	.byte $b3,$bc,$b3,$bb,$bb,$b8,$ba,$b9
	.byte $b8,$b9,$b7,$b9,$b6,$b8,$b6,$b7
	.byte $b7,$b6,$b8,$b5,$b9,$b4,$b9,$b3
	.byte $b8,$b2,$b6,$b2,$b5,$b2,$b4,$b3
	.byte $c5,$be,$c5,$bd,$c4,$bc,$c4,$bb
	.byte $c3,$ba,$c3,$b9,$c2,$b8,$c2,$b7
	.byte $c1,$b6,$c1,$b5,$c0,$b4,$c0,$b3
	.byte $bf,$b2,$c5,$b9,$c6,$b9,$c7,$b8
	.byte $c7,$b7,$c6,$b6,$c6,$b5,$c5,$b4
	.byte $c5,$b3,$c6,$b2,$00

draw_origin_systems:
	lda #$5a
	sta blit_page_offset
	lda #$00
	sta blitanim_loop_I
@scroll:
	lda #$00
	sta blitanim_loop_J
@next_row:
	lda #$09     ;column start
	sta blitanim_loop_K
@next_column:
	lda blitanim_loop_K
	sta src_column
	sta dst_column
	lda #$15
	clc
	adc blitanim_loop_J
	sta src_row
	lda #$1d
	clc
	adc blitanim_loop_J
	sec
	sbc blitanim_loop_I
	sta dst_row
	jsr blit_from_slowpaint
	inc blitanim_loop_K
	lda blitanim_loop_K
	cmp #$1e     ;column end
	bcc @next_column
	beq @next_column
	inc blitanim_loop_J
	lda blitanim_loop_J
	cmp blitanim_loop_I
	bcc @next_row
	beq @next_row
	lda #$c0
	jsr short_pause
	inc blitanim_loop_I
	lda blitanim_loop_I
	cmp #$08
	bcc @scroll
	beq @scroll
	rts

blitanim_loop_I:
	.byte $44
blitanim_loop_J:
	.byte $54
blitanim_loop_K:
	.byte $20

blit_from_slowpaint:
	lda #$5a     ;file BGND at $7A00
	jmp :+

blit_from_animsheet:
	lda #$20     ;file ANIM at $4000
:	sta blit_page_offset
	ldy src_row
	lda bmplineaddr_lo,y
	sta ptr1_bitmap
	lda bmplineaddr_hi,y
	clc
	adc blit_page_offset
	sta ptr1_bitmap + 1
	ldy dst_row
	lda bmplineaddr_lo,y
	sta ptr2_bitmap
	lda bmplineaddr_hi,y
	sta ptr2_bitmap + 1
	ldy src_column
	lda (ptr1_bitmap),y
	ldy dst_column
	sta (ptr2_bitmap),y
	rts

; unused
get_bitmap_byte:
	ldy src_row
	lda bmplineaddr_lo,y
	sta ptr1_bitmap
	lda bmplineaddr_hi,y
	clc
	adc blit_page_offset
	sta ptr1_bitmap + 1
	ldy src_column
	lda (ptr1_bitmap),y
	rts

; unused
mystery_routine:
	txa
	pha
	clc
	ldx #$06
	lda mystery_accumulator
@add:
	adc mystery_table,x
	sta mystery_table,x
	dex
	bpl @add
	ldx #$07
@inc:
	inc mystery_table,x
	bne @done
	dex
	bpl @inc
@done:
	pla
	tax
	lda mystery_table
	rts

mystery_table:
	.byte $09,$0a,$0b,$0c,$0d,$0e,$0f
mystery_accumulator:
	.byte $10

draw_present:
	lda #$00
	sta blitanim_loop_I
@next_scroll:
	lda #$00
	sta blitanim_loop_J
@next_row:
	lda #$10
	sta blitanim_loop_K
@next_column:
	lda blitanim_loop_K
	sta src_column
	sta dst_column
	lda #$04
	clc
	adc blitanim_loop_J
	sec
	sbc blitanim_loop_I
	sta src_row
	lda #$21
	clc
	adc blitanim_loop_J
	sta dst_row
	jsr blit_from_slowpaint
	inc blitanim_loop_K
	lda blitanim_loop_K
	cmp #$18
	bcc @next_column
	beq @next_column
	inc blitanim_loop_J
	lda blitanim_loop_J
	cmp blitanim_loop_I
	bcc @next_row
	beq @next_row
	lda #$c0
	jsr short_pause
	inc blitanim_loop_I
	lda blitanim_loop_I
	cmp #$04
	bcc @next_scroll
	beq @next_scroll
	rts

draw_quest_title:
	lda #$5a
	sta blit_page_offset
	lda #$00
	sta blitanim_loop_I
@next_scroll:
	lda #$00
	sta blitanim_loop_J
@next_row:
	lda #$03
	sta blitanim_loop_K
@next_column:
	lda blitanim_loop_K
	sta src_column
	sta dst_column
	lda #$51
	clc
	adc blitanim_loop_J
	sta src_row
	lda #$56
	clc
	adc blitanim_loop_J
	sec
	sbc blitanim_loop_I
	sta dst_row
	jsr blit_from_slowpaint
	lda #$5c
	clc
	adc blitanim_loop_J
	sec
	sbc blitanim_loop_I
	sta src_row
	lda #$57
	clc
	adc blitanim_loop_J
	sta dst_row
	jsr blit_from_slowpaint
	inc blitanim_loop_K
	lda blitanim_loop_K
	cmp #$24
	bcc @next_column
	beq @next_column
	inc blitanim_loop_J
	lda blitanim_loop_J
	cmp blitanim_loop_I
	bcc @next_row
	beq @next_row
	lda #$c0
	jsr short_pause
	inc blitanim_loop_I
	lda blitanim_loop_I
	cmp #$05
	bcc @next_scroll
	beq @next_scroll
	rts

draw_map_window:
	lda #$5a
	sta blit_page_offset
	lda #$00
	sta blitanim_loop_J
@next_column:
	lda #$60
	sta blitanim_loop_K
@next_row:
	lda blitanim_loop_K
	sta src_row
	sta dst_row
	lda #$13
	sec
	sbc blitanim_loop_J
	sta src_column
	lda #$13
	sec
	sbc blitanim_loop_J
	sta dst_column
	jsr blit_from_slowpaint
	lda #$14
	clc
	adc blitanim_loop_J
	sta src_column
	sta dst_column
	jsr blit_from_slowpaint
	inc blitanim_loop_K
	lda blitanim_loop_K
	cmp #$bf
	bcc @next_row
	beq @next_row
	lda #$c0
	jsr short_pause
	inc blitanim_loop_J
	lda blitanim_loop_J
	cmp #$13
	bcc @next_column
	beq @next_column
	rts

; Should have used I,J,K instead of plot_row,I,J in my opinion
draw_captive_scroll:
	lda #$e1
	sta plot_row
	lda #$1e
	sta balron_anim_cur
	sta dragon_anim_cur
@next_scroll:
	jsr draw_captive_frame
	jsr next_captive_frame
	jsr update_attract
	jsr update_attract
	bit hw_KEYBOARD
	bpl :+
	rts
:	inc plot_row
	lda plot_row
	cmp #$01
	bne @next_scroll
	rts

draw_captive_frame:
	ldx balron_anim_cur
	ldy balron_anim_sequence,x
	lda sheet_balron_col,y
	sta @balron_sheet_x
	lda sheet_balron_row,y
	sta @balron_sheet_y
	ldx dragon_anim_cur
	ldy dragon_anim_sequence,x
	lda sheet_dragon_col,y
	sta @dragon_sheet_x
	lda sheet_dragon_row,y
	sta @dragon_sheet_y
	lda #$00
	sta blitanim_loop_I
@next_row:
	lda #$00
	sta blitanim_loop_J
@next_column:
	lda blitanim_loop_J
	clc
@balron_sheet_x=*+$01
	adc #$ff
	sta src_column
	lda blitanim_loop_J
	sta dst_column
	lda blitanim_loop_I
	clc
@balron_sheet_y=*+$01
	adc #$ff
	sta src_row
	lda blitanim_loop_I
	clc
	adc plot_row
	bmi @clip_balron
	sta dst_row
	jsr blit_from_animsheet
@clip_balron:
	lda blitanim_loop_J
	clc
@dragon_sheet_x=*+$01
	adc #$ff
	sta src_column
	lda blitanim_loop_J
	clc
	adc #$22
	cmp #$28
	bcs @clip_dragon
	sta dst_column
	lda blitanim_loop_I
	clc
@dragon_sheet_y=*+$01
	adc #$ff
	sta src_row
	lda blitanim_loop_I
	clc
	adc plot_row
	bmi @clip_dragon
	sta dst_row
	jsr blit_from_animsheet
@clip_dragon:
	inc blitanim_loop_J
	lda blitanim_loop_J
	cmp #$07
	bcc @next_column
	inc blitanim_loop_I
	lda blitanim_loop_I
	cmp #$1f
	bcc @next_row
	rts

next_captive_frame:
	inc balron_anim_cur
	lda balron_anim_cur
	and #$7f
	sta balron_anim_cur
	inc dragon_anim_cur
	lda dragon_anim_cur
	and #$3f
	sta dragon_anim_cur
	rts

mockingboard_active:
	.byte 0

start_attract_mode:
	lda #$00
	sta game_mode        ;mode_suspended
	sta currdisk_drive2  ;disk_none
	lda #$01
	sta numdrives
	sta currdisk_drive1  ;disk_program
	jsr return
return_to_view:
	jsr attract_loop
	php
	cli
	lda tune_playing
	sta tune_queue_next
	plp
menu_main:
	jsr clear_window
draw_menu:
	lda #$10
	sta cursor_y
	lda #$17
	sta cursor_x
	ldx #$02
	ldy #$0e
	jsr j_primm_xy
	.byte "IN ANOTHER WORLD, IN A TIME TO COME.", 0
	ldx #$0f
	ldy #$10
	jsr j_primm_xy
	.byte "OPTIONS:", 0
	ldx #$0b
	ldy #$11
	jsr j_primm_xy
	.byte "Return to the view", 0
	ldx #$0b
	ldy #$12
	jsr j_primm_xy
	.byte "Number of drives-"
num_drives:
	.byte "1", 0
	ldx #$0d
	ldy #$13
	jsr j_primm_xy
	.byte "Journey onward", 0
	ldx #$0b
	ldy #$14
	jsr j_primm_xy
	.byte "Initiate new game", 0
	bit mockingboard_active
	bmi @get_input
	ldx #$09
	ldy #$15
	jsr j_primm_xy
	.byte "Activate Mockingboard", 0
@get_input:
	jsr input_char
	cmp #char_0
	bcc @get_input
	cmp #char_9 + 1
	bcs @check_alpha
	sec
	sbc #char_0
	jsr load_music
	jmp @get_input

@check_alpha:
	cmp #char_T
	beq @load_music
	cmp #char_O
	beq @load_music
	cmp #char_D
	beq @load_music
	cmp #char_B
	beq @load_music
	cmp #char_C
	bne :+
@load_music:
	jsr load_music
	jmp @get_input
:	cmp #char_R
	bne :+
	jmp return_to_view
:	cmp #char_N
	bne :+
	jmp number_of_drives
:	cmp #char_J
	bne :+
	jmp journey_onward
:	cmp #char_I
	bne :+
	jmp init_new_game
:	cmp #char_A
	bne @get_input
	bit mockingboard_active
	bmi @get_input
@activate_mockingboard:
	lda #music_off
	jsr load_music
	lda hw_ROMIN
	lda rom_signature
	ldx rom_ZIDBYTE
	bit hw_LCBANK1
	bit hw_LCBANK1
	cmp #$06     ;Apple //e
	bne :+
	cpx #$00
	beq @get_input
:	lda #$00
	sta mb_1_slot
	sta mb_1_type
	sta mb_2_slot
	sta mb_2_type
	inc cursor_x
	jsr clear_window
	ldx #$0f
	ldy #$10
how_many:
	jsr j_primm_xy
	.byte "How many?", 0
	ldx #$0c
	ldy #$12
	jsr j_primm_xy
	.byte "One Mockingboard", 0
	ldx #$0c
	ldy #$13
	jsr j_primm_xy
	.byte "Two Mockingboards", 0
@get_input:
	jsr input_char
	cmp #char_O
	beq one_mockingboard
	cmp #char_T
	beq two_mockingboards
	cmp #char_ESC
	bne @get_input
	jmp menu_main

one_mockingboard:
	lda #$00
	beq :+
two_mockingboards:
	lda #$80
:	sta mb_count
menu_kind_mocking:
	jsr clear_window
	jsr print_mockboard_1_2
	ldy #$10
	ldx #$0d
	jsr j_primm_xy
	.byte "Which kind?", 0
	ldy #$12
	ldx #$0a
	jsr j_primm_xy
	.byte "1- Sound 1", 0
	ldy #$13
	ldx #$0a
	jsr j_primm_xy
	.byte "2- Sound-Speech", 0
	ldy #$14
	ldx #$0a
	jsr j_primm_xy
	.byte "3- Mockingboard A or C", 0
@get_input:
	jsr input_char
	cmp #char_ESC
	bne :+
	jmp menu_main
:	cmp #char_1
	bcc @get_input
	cmp #char_3 + 1
	bcs @get_input
@set_type:
	sec
	sbc #char_num_first
	tay
	lda mb_count
	and #$02
	tax
	sty mb_1_type,x
menu_which_slot:
	jsr clear_window
	jsr print_mockboard_1_2
	ldy #$10
	ldx #$0d
	jsr j_primm_xy
	.byte "Which slot?", 0
	ldy #$13
	ldx #$0b
	jsr j_primm_xy
	.byte "Enter a number 1-7", 0
@get_input:
	jsr input_char
	cmp #char_ESC
	bne :+
	jmp menu_main
:	cmp #char_1
	bcc @get_input
	cmp #char_7 + 1
	bcs @get_input
@set_slot:
	sec
	sbc #char_num_first
	tay
	lda mb_count
	and #$02
	tax
	sty mb_1_slot,x
	bit mb_count
	bpl load_sound_drivers
@do_second_card:
	inc mb_count
	inc mb_count
	lda mb_count
	cmp #$84
	bcs load_sound_drivers
	jmp menu_kind_mocking

load_sound_drivers:
	jsr j_primm_cout
	.byte $84,"BLOAD M", $81, "BSM,A$F000", $8d
	.byte $84,"BLOAD M", $81, "BSI,A$8000", $8d
	.byte 0
	jsr j_mbsi
	bcc @skip
	lda #opcode_JMP ;reactivate SEL driver
	sta music_ctl
	lda #music_off
	sta tune_playing
	lda #music_Towne
	jsr load_music
	lda #music_explore
	jsr load_music
	dec mockingboard_active
@skip:
	jmp menu_main

print_mockboard_1_2:
	ldy #$0e
	ldx #$08
	lda mb_count
	bpl @no_key
	and #$02
	bne @odd
	jsr j_primm_xy
	.byte "First Mockingboard:", 0
@no_key:
	rts

@odd:
	jsr j_primm_xy
	.byte "Second Mockingboard:", 0
	rts

load_music:
	tax
	bpl @digit
	sta music_bank
	ldx #music_main
	stx music_tune
	jmp music_ctl

@digit:
	sta music_tune
	jmp music_ctl

music_tune:
	.byte $ff
music_bank:
	.byte $ff
music_bank_letter:
	.byte "OTDCB", 0
music_bank_tunes:
	.byte $01,$02,$03,$00
	.byte $01,$00,$00,$04
	.byte $01,$00,$00,$00
	.byte $01,$00,$00,$00
	.byte $01,$00,$00,$00
	.byte $ff

update_music:
	lda tune_playing
	cmp tune_queue_next
	beq :+
	rts
:	cmp #music_off
	beq @get_bank_index
	sta music_tune
@get_bank_index:
	ldx #$00
	lda music_bank
@next:
	cmp music_bank_letter,x
	beq @get_tune_number
	inx
	bne @next    ;benign BUG: should test (X) instead of X
@get_tune_number:
	txa
	asl
	asl
	clc
	adc music_tune
	tax
@get_next_tune:
	lda music_bank_tunes,x
	bne @check_eol
	inx
	bne @get_next_tune
@check_eol:
	bpl @advance_demo_tune
	ldx #$00
	beq @check_eol ;not necessary
@advance_demo_tune:
	txa
	lsr
	lsr
	tay
	lda music_bank_letter,y
	cmp music_bank
	beq @same_bank
	ldy #music_off
	sty tune_queue_next
	ldy tune_playing
	bne :+
	jsr load_music
:	rts
@same_bank:
	lda music_bank_tunes,x
	sta tune_queue_next
	rts

input_char:
	ldx cursor_x
	ldy cursor_y
	jsr j_drawcursor_xy
	jsr update_captives
	jsr j_rand   ;unused
	jsr delay_96
	lda hw_KEYBOARD
	bpl input_char
	bit hw_STROBE
	pha
	jsr j_console_out
	pla
	rts

cursor_x:
	.byte 0
cursor_y:
	.byte 0
journey_onward:
	lda #$00
	sta party_size
	sta key_buf_len
	lda #music_off
	jsr load_music
	jsr j_primm_cout
	.byte $84,"BRUN U", $81, "LT4,A$4000", $8d
	.byte 0

init_new_game:
	lda #music_off
	jsr load_music
	lda numdrives
	cmp #$01
	beq @ask_name
	lda #disk_britannia
	jsr insert_disk
	lda #disk_program
	sta disk_id
@ask_name:
	jsr clear_window
	ldx #$04
	ldy #$10
	jsr j_primm_xy
	.byte "By what name shalt thou be known", 0
	ldx #$04
	ldy #$11
	jsr j_primm_xy
	.byte "in this world and time? ", 0
	lda #$13
	sta console_ypos
	lda #$0c
	sta console_xpos
	jsr input_text
	jsr clear_window
	ldx #$04
	ldy #$11
	jsr j_primm_xy
	.byte "Art thou Male or Female? ", 0
	lda console_xpos
	sta cursor_x
	lda console_ypos
	sta cursor_y
@input_sex:
	jsr input_char
	cmp #char_M
	beq @male
	cmp #char_F
	bne @input_sex
	lda #glyph_female
	bne @run_newgame
@male:
	lda #glyph_male
@run_newgame:
	sta gender_chosen
	jsr clear_window
	lda #music_off
	jsr load_music
	jsr j_primm_cout
	.byte $84,"BRUN N", $81, "EWGAME,A$6400,D1", $8d
	.byte 0
return:
	rts

attract_loop:
	jsr update_attract_and_captives
	jsr update_music
	lda hw_KEYBOARD
	bpl attract_loop
	bit hw_STROBE
	rts

update_attract_and_captives:
	jsr update_attract
	lda attract_twice
	eor #$ff
	sta attract_twice
	bpl update_attract_and_captives
update_captives:
	lda #$00
	sta captive_row_cur
	inc balron_anim_cur
	lda balron_anim_cur
	and #$7f
	tax
	ldy balron_anim_sequence,x
	lda sheet_balron_row,y
	sta captive_sheet_y
	lda sheet_balron_col,y
	sta captive_sheet_x
@balron_set_dst:
	ldx captive_row_cur
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
@balron_set_src:
	clc
	lda captive_sheet_y
	adc captive_row_cur
	tax
	lda bmplineaddr_hi,x
	clc
	adc #$20     ;file ANIM at $4000
	sta ptr2 + 1
	lda bmplineaddr_lo,x
	clc
	adc captive_sheet_x
	sta ptr2
	ldy #$06
@balron_blit:
	lda (ptr2),y
	sta (ptr1),y
	dey
	bpl @balron_blit
	inc captive_row_cur
	lda captive_row_cur
	cmp #$20
	bcc @balron_set_dst
	lda #$00
	sta captive_row_cur
@update_dragon:
	inc dragon_anim_cur
	lda dragon_anim_cur
	and #$3f
	tax
	ldy dragon_anim_sequence,x
	lda sheet_dragon_row,y
	sta captive_sheet_y
	lda sheet_dragon_col,y
	sta captive_sheet_x
@dragon_set_dst:
	ldx captive_row_cur
	lda bmplineaddr_lo,x
	clc
	adc #$22
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
@dragon_set_src:
	clc
	lda captive_sheet_y
	adc captive_row_cur
	tax
	lda bmplineaddr_hi,x
	clc
	adc #$20     ;file ANIM at $4000
	sta ptr2 + 1
	lda bmplineaddr_lo,x
	clc
	adc captive_sheet_x
	sta ptr2
	ldy #$05
@dragon_blit:
	lda (ptr2),y
	sta (ptr1),y
	dey
	bpl @dragon_blit
	inc captive_row_cur
	lda captive_row_cur
	cmp #$20
	bcc @dragon_set_dst
	rts

attract_twice:
	.byte 0
captive_row_cur:
	.byte 0
captive_unused1:
	.byte $ff
captive_unused2:
	.byte $ff
captive_sheet_y:
	.byte 0
captive_sheet_x:
	.byte 0
balron_anim_cur:
	.byte $ff
dragon_anim_cur:
	.byte $ff
balron_anim_sequence:
	.byte $01,$01,$01,$00,$00,$01,$01,$01
	.byte $00,$00,$01,$01,$02,$02,$03,$03
	.byte $04,$04,$01,$02,$03,$04,$01,$02
	.byte $05,$06,$07,$08,$05,$06,$07,$08
	.byte $05,$06,$07,$08,$05,$06,$07,$08
	.byte $05,$06,$07,$08,$05,$06,$07,$08
	.byte $09,$0a,$09,$0a,$09,$0a,$0b,$0b
	.byte $0b,$0b,$0c,$0c,$0d,$0d,$0c,$0d
	.byte $0c,$0d,$0c,$0b,$0b,$0b,$00,$00
	.byte $01,$02,$03,$04,$01,$02,$05,$06
	.byte $07,$08,$05,$06,$07,$08,$09,$0a
	.byte $0b,$0b,$0b,$00,$00,$0e,$0e,$0e
	.byte $0f,$10,$10,$10,$11,$11,$11,$10
	.byte $10,$10,$11,$11,$11,$10,$10,$10
	.byte $0f,$0e,$0e,$00,$00,$0b,$0b,$0b
dragon_anim_sequence:
	.byte $01,$00,$01,$02,$03,$04,$03,$02
	.byte $01,$00,$01,$02,$03,$04,$05,$06
	.byte $05,$06,$05,$06,$04,$07,$08,$09
	.byte $0a,$09,$08,$07,$08,$09,$0a,$0b
	.byte $0c,$0b,$0c,$0d,$0b,$0c,$0d,$01
	.byte $0d,$01,$0e,$01,$0f,$01,$0e,$01
	.byte $0f,$0a,$09,$08,$10,$11,$10,$11
	.byte $10,$11,$09,$08,$07,$04,$03,$02
sheet_balron_row:
	.byte $00,$20,$40,$60,$80,$a0
	.byte $00,$20,$40,$60,$80,$a0
	.byte $00,$20,$40,$60,$80,$a0
sheet_balron_col:
	.byte $00,$00,$00,$00,$00,$00
	.byte $07,$07,$07,$07,$07,$07
	.byte $0e,$0e,$0e,$0e,$0e,$0e
sheet_dragon_row:
	.byte $00,$20,$40,$60,$80,$a0
	.byte $00,$20,$40,$60,$80,$a0
	.byte $00,$20,$40,$60,$80,$a0
sheet_dragon_col:
	.byte $22,$22,$22,$22,$22,$22
	.byte $1c,$1c,$1c,$1c,$1c,$1c
	.byte $16,$16,$16,$16,$16,$16

draw_world_tiles:
	ldx #$5e
@copy_map:
	lda attract_map,x
	sta drawn_tiles,x
	dex
	bpl @copy_map
	ldx #$00
@next_object:
	lda object_tile_sprite,x
	beq @skip
	ldy object_ypos,x
	lda world_row_index,y
	clc
	adc object_xpos,x
	tay
	lda object_tile_sprite,x
	sta drawn_tiles,y
@skip:
	inx
	cpx #object_last
	bne @next_object
	rts

update_attract:
	jsr update_demo
	jsr j_animate_tiles
	jsr draw_world_tiles
	lda #$00
	sta current_draw_line
	sta @tile_index
@next_row:
	ldy current_draw_line
	lda bmplineaddr_lo + $68,y
	sta @dst1_lo
	sta @dst2_lo
	lda bmplineaddr_hi + $68,y
	sta @dst1_hi
	sta @dst2_hi
	tya
	and #$0f
	ora #$d0
	sta @src1_hi
	sta @src2_hi
	ldx #$01
@tile_index=*+$01
@next_column:
	ldy drawn_tiles
	bit hw_LCBANK1
@src1_hi=*+$02
	lda TMP_PAGE,y
@dst1_lo=*+$01
@dst1_hi=*+$02
	sta TMP_ADDR,x
	inx
	bit hw_LCBANK2
@src2_hi=*+$02
	lda TMP_PAGE,y
@dst2_lo=*+$01
@dst2_hi=*+$02
	sta TMP_ADDR,x
	inc @tile_index
	inx
	cpx #$27     ;world width
	bcc @next_column
	inc current_draw_line
	lda current_draw_line
	cmp #$50
	beq @done
	and #$0f
	beq @next_row
	lda @tile_index
	sec
	sbc #$13
	sta @tile_index
	jmp @next_row

@done:
	rts

world_row_index:
	.byte $00,$13,$26,$39,$4c
attract_map:
	.byte 6,6,6,4,4,4,1,1,0,0,0,0,1,4,4,13,14,15,4
	.byte 6,6,4,4,4,1,1,1,1,0,0,1,1,4,4,4,4,4,4
	.byte 6,4,4,1,1,1,2,2,1,1,1,1,1,1,10,4,4,4,6
	.byte 6,4,4,1,1,2,2,1,1,9,8,1,1,1,1,4,6,6,6
	.byte 4,4,4,4,1,1,1,1,4,4,8,8,1,1,1,1,1,6,6

update_demo:
	dec demo_hold_count
	bpl @done
	ldy #$00
@next_cmd:
	lda (ptr_demo),y
	bpl @do_mob_cmd
	tax
	and #$f0
	cmp #$80
	bne @repeat_from_start
	txa
	and #$0f
	asl
	sta demo_hold_count
@inc_ptr:
	inc ptr_demo
	bne @done
	inc ptr_demo + 1
@done:
	rts

@repeat_from_start:
	lda #<demo_cmd_table
	sta ptr_demo
	lda #>demo_cmd_table
	sta ptr_demo + 1
	bne @next_cmd
@do_mob_cmd:
	pha
	and #$0f
	tax
	pla
	and #$f0
	lsr
	lsr
	lsr
	lsr
	cmp #$07
	beq @remove_mob
	sta object_ypos,x
	jsr @inc_ptr
	lda (ptr_demo),y
	pha
	and #$1f
	sta object_xpos,x
	pla
	lsr
	lsr
	lsr
	lsr
	lsr
	clc
	adc demo_mob_type,x
	sta object_tile_sprite,x
	cpx #$01     ;for object 1, sprite is type, not just anim frame
	bne :+
	lda demo_mob_type,x
:	sta object_tile_type,x
	jsr @inc_ptr
	jmp @next_cmd

@remove_mob:
	lda #$00
	sta object_tile_sprite,x
	sta object_tile_type,x
	jsr @inc_ptr
	jmp @next_cmd

demo_mob_type:
	.byte tile_moongate
	.byte tile_pirate
	.byte tile_ship_west
	.byte tile_human_prone
	.byte tile_human_prone
	.byte tile_rogue
	.byte tile_rogue
	.byte tile_class_tinker
	.byte tile_class_mage
	.byte tile_serpent
	.byte tile_daemon
	.byte tile_dragon
	.byte tile_attack_small
	.byte tile_attack_red
	.byte tile_attack_blue

input_text:
	lda #$00
	sta zp_keybuf_count
@next_cursor:
	ldx console_xpos
	ldy console_ypos
	jsr j_drawcursor_xy
	jsr update_captives
	lda #$00
	sta cursor_hold
@elapse_cursor:
	inc cursor_hold
	bmi @next_cursor
	ldy #$00
@delay:
	dey
	bne @delay
	lda hw_KEYBOARD
	bpl @elapse_cursor
	bit hw_STROBE
	cmp #char_DEL
	bne :+
	lda #char_left_arrow
:	cmp #char_enter
	beq @enter
	cmp #char_left_arrow
	beq @backspace
	cmp #char_space
	bcc @elapse_cursor
	ldx zp_keybuf_count
	cpx #$0f
	beq @elapse_cursor
	sta inbuffer,x
	jsr j_console_out
	inc zp_keybuf_count
	jmp @elapse_cursor

@backspace:
	lda zp_keybuf_count
	beq @elapse_cursor
	dec zp_keybuf_count
	lda #char_space
	jsr j_console_out
	dec console_xpos
	dec console_xpos
	lda #char_space
	jsr j_console_out
	dec console_xpos
	jmp @elapse_cursor

@enter:
	ldx zp_keybuf_count
	beq @elapse_cursor
	lda #$00
@pad_buf:
	sta inbuffer,x
	inx
	cpx #$10
	bcc @pad_buf
	lda #char_enter
	jsr j_console_out
	rts

clear_window:
	ldx #$4f
@next_row:
	lda bmplineaddr_lo + $68,x
	sta ptr1
	lda bmplineaddr_hi + $68,x
	sta ptr1 + 1
	ldy #$26
	lda #$00
@next_col:
	sta (ptr1),y
	dey
	bne @next_col
	dex
	bpl @next_row
	rts

number_of_drives:
	lda numdrives
	eor #$03
	sta numdrives
	lda num_drives
	eor #$03
	sta num_drives
	jmp draw_menu

delay_96:
	ldx #$96
	ldy #$00
:	dey
	bne :-
	dex
	bne :-
	rts

; unused
remove_window:
	ldx #$bf
@next_row:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	lda #$00
	ldy #$27
@next_col:
	sta (ptr1),y
	dey
	bpl @next_col
	dex
	cpx #$90
	bcs @next_row
	lda #$00
	sta console_xpos
	lda #$12
	sta console_ypos
	rts

insert_disk:
	sta reqdisk
@display_prompt:
	jsr clear_window
	lda #$10
	sta console_ypos
	lda reqdisk
	cmp #disk_britannia
	beq @drive2
	cmp #disk_dungeon
	beq @drive2
@drive1:
	lda #$01
	sta currdrive
	lda reqdisk
	cmp currdisk_drive1
	beq @have_disk
	ldy console_ypos
	ldx #$0b
	jsr j_primm_xy
	.byte "PLEASE PLACE THE", 0
	inc console_ypos
	jsr print_disk_name
	ldy console_ypos
	ldx #$0d
	jsr j_primm_xy
	.byte "INTO DRIVE 1", 0
@wait_key:
	inc console_ypos
	ldy console_ypos
	ldx #$0b
	jsr j_primm_xy
	.byte "AND PRESS [ESC]", 0
	lda console_xpos
	sta cursor_x
	lda console_ypos
	sta cursor_y
:	jsr input_char
	cmp #char_ESC
	bne :-
@have_disk:
	jmp @load_disk_id

@drive2:
	lda numdrives
	cmp #$02
	bcc @drive1
	lda #$02
	sta currdrive
	lda reqdisk
	cmp currdisk_drive2
	beq @load_disk_id
	ldy console_ypos
	ldx #$0b
	jsr j_primm_xy
	.byte "PLEASE PLACE THE", 0
	inc console_ypos
	jsr print_disk_name
	ldy console_ypos
	ldx #$0d
	jsr j_primm_xy
	.byte "INTO DRIVE 2", 0
	jmp @wait_key

@load_disk_id:
	lda currdrive
	clc
	adc #char_num_first
	sta @drive_number
	jsr j_primm_cout
	.byte $84,"BLOAD DISK,D"
@drive_number:
	.byte "1", $8d
	.byte 0
	ldx currdrive
	lda disk_id
	sta numdrives,x
	cmp reqdisk
	beq @ok
	dec console_ypos
	dec console_ypos
	jmp @display_prompt

@ok:
	rts

print_disk_name:
	ldx reqdisk
@program:
	dex
	bne @britannia
	ldy console_ypos
	ldx #$0d
	jsr j_primm_xy
	.byte "ULTIMA DISK", 0
	inc console_ypos
	rts

@britannia:
	dex
	bne @towne
	ldy console_ypos
	ldx #$0c
	jsr j_primm_xy
	.byte "BRITANNIA DISK", 0
	inc console_ypos
	rts

@towne:
	dex
	bne @dungeon
	ldy console_ypos
	ldx #$0e
	jsr j_primm_xy
	.byte "TOWN DISK", 0
	inc console_ypos
	rts

@dungeon:
	dex
	bne @done
	ldy console_ypos
	ldx #$0d
	jsr j_primm_xy
	.byte "DUNGEON DISK", 0
	inc console_ypos
@done:
	rts

demo_cmd_table:
	.byte $88,$20,$11,$80,$20,$31,$80,$20
	.byte $51,$80,$20,$71,$88,$27,$11,$84
	.byte $27,$10,$84,$17,$10,$84,$07,$10
	.byte $84,$77,$88,$20,$51,$80,$20,$31
	.byte $80,$20,$11,$80,$70,$88,$01,$66
	.byte $84,$11,$66,$84,$07,$10,$84,$17
	.byte $10,$82,$11,$46,$82,$17,$0f,$82
	.byte $11,$47,$82,$17,$0e,$82,$11,$48
	.byte $27,$0e,$84,$11,$49,$77,$84,$11
	.byte $4a,$88,$27,$0e,$84,$17,$0e,$84
	.byte $17,$0d,$84,$28,$0e,$84,$18,$0e
	.byte $84,$11,$2a,$80,$1c,$0b,$80,$1c
	.byte $0c,$80,$7c,$1d,$0d,$81,$7d,$84
	.byte $1e,$0d,$80,$1e,$0c,$80,$1e,$0b
	.byte $80,$1e,$0a,$81,$7e,$84,$11,$4a
	.byte $84,$11,$4b,$07,$0d,$84,$11,$4c
	.byte $07,$0e,$84,$15,$0c,$84,$15,$0d
	.byte $84,$05,$0d,$16,$0c,$84,$16,$0d
	.byte $84,$0d,$0e,$81,$7d,$84,$1d,$0e
	.byte $81,$7d,$84,$0d,$0d,$81,$7d,$84
	.byte $1c,$0d,$81,$7c,$84,$0d,$0e,$81
	.byte $7d,$84,$1d,$0e,$81,$7d,$84,$0d
	.byte $0d,$81,$7d,$75,$03,$0d,$84,$1d
	.byte $0d,$81,$7d,$84,$1c,$0e,$81,$7c
	.byte $84,$1d,$0d,$81,$7d,$76,$14,$0d
	.byte $88,$18,$0d,$84,$18,$0c,$17,$0e
	.byte $84,$78,$17,$0d,$84,$17,$0c,$84
	.byte $77,$88,$71,$12,$4c,$84,$12,$6c
	.byte $84,$12,$0c,$84,$4b,$00,$73,$82
	.byte $3b,$01,$82,$2b,$02,$12,$0b,$82
	.byte $2b,$03,$82,$12,$0a,$1b,$04,$74
	.byte $82,$1b,$05,$82,$1b,$06,$12,$6a
	.byte $82,$1b,$07,$82,$1c,$09,$80,$1c
	.byte $08,$80,$7c,$1d,$07,$81,$7d,$88
	.byte $1b,$08,$82,$1c,$09,$80,$7c,$1d
	.byte $08,$81,$7d,$7b,$84,$3a,$09,$84
	.byte $4a,$09,$84,$4a,$08,$12,$0a,$84
	.byte $12,$09,$84,$12,$08,$84,$2c,$08
	.byte $80,$3c,$08,$80,$7c,$4d,$08,$81
	.byte $7d,$7a,$88,$12,$68,$84,$22,$68
	.byte $84,$32,$68,$84,$32,$08,$84,$32
	.byte $07,$84,$32,$67,$84,$42,$67,$88
	.byte $47,$07,$84,$47,$08,$84,$47,$09
	.byte $48,$07,$84,$37,$09,$48,$08,$84
	.byte $77,$48,$09,$84,$38,$09,$84,$78
	.byte $88,$37,$09,$84,$47,$09,$84,$47
	.byte $08,$38,$09,$84,$47,$07,$48,$09
	.byte $84,$77,$48,$08,$84,$48,$07,$84
	.byte $78,$88,$42,$07,$84,$42,$06,$84
	.byte $42,$05,$84,$42,$04,$84,$42,$24
	.byte $84,$32,$24,$84,$32,$04,$84,$32
	.byte $03,$88,$37,$03,$84,$37,$02,$84
	.byte $37,$01,$38,$03,$84,$47,$01,$38
	.byte $02,$82,$09,$09,$82,$47,$00,$48
	.byte $02,$19,$08,$82,$29,$07,$82,$47
	.byte $01,$39,$06,$82,$3e,$05,$80,$3e
	.byte $04,$80,$3e,$03,$81,$7e,$72,$82
	.byte $39,$05,$82,$39,$04,$48,$03,$37
	.byte $01,$82,$39,$03,$82,$3e,$03,$37
	.byte $02,$81,$7e,$83,$4d,$03,$81,$7d
	.byte $78,$44,$03,$84,$3d,$03,$81,$7d
	.byte $82,$3d,$02,$81,$7d,$82,$3d,$03
	.byte $81,$7d,$79,$88,$47,$02,$84,$47
	.byte $03,$74,$88,$20,$01,$80,$20,$21
	.byte $80,$20,$41,$80,$20,$61,$85,$47
	.byte $02,$84,$37,$02,$84,$27,$02,$84
	.byte $27,$01,$84,$77,$88,$20,$61,$80
	.byte $20,$41,$80,$20,$21,$80,$20,$01
	.byte $80,$70,$88,$ff
