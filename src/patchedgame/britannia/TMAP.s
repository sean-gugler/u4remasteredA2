	.include "uscii.i"

	.include "apple.i"
	.include "tables.i"
	.include "view_map.i"
	.include "zp_main.i"

	.include "PRTY.i"


; 32 x 32 grid of 4x4-pixel cells
view_max_x = $20
view_max_y = $20


	.segment "VIEWMAP"

.assert * = j_viewmap, error, "Wrong start address"
	jsr clear_view
	lda #$00
	sta temp_x
	sta temp_y
next_tile:
	jsr get_at_xy
	bpl :+
	jsr pattern_05
	jmp next_row

:	tax
	ldy tile_pattern_table,x
	bne :+
	jsr pattern_00
	jmp next_row

:	dey
	bne :+
	jsr pattern_01
	jmp next_row

:	dey
	bne :+
	jsr pattern_02
	jmp next_row

:	dey
	bne :+
	jsr pattern_03
	jmp next_row

:	dey
	bne :+
	jsr pattern_04
	jmp next_row

:	dey
	bne :+
	jsr pattern_05
	jmp next_row

:	dey
	bne :+
	jsr pattern_06
	jmp next_row

:	dey
	bne :+
	jsr pattern_07
	jmp next_row

:	dey
	bne :+
	jsr pattern_08
	jmp next_row

:	dey
	bne :+
	jsr pattern_09
	jmp next_row

:	dey
	bne :+
	jsr pattern_0a
	jmp next_row

:	dey
	bne :+
	jsr pattern_0b
	jmp next_row

:	dey
	bne next_row ;leave cell black
	jsr pattern_0c
	jmp next_row

next_row:
	inc temp_y
	lda temp_y
	cmp #view_max_y
	bcs @column_done
	jmp next_tile

@column_done:
	lda #$00
	sta temp_y
	inc temp_x
	lda temp_x
	cmp #view_max_x
	bcs @done
	jmp next_tile

@done:
	lda current_location
	beq @britannia ;loc_world
	lda player_xpos
	sta temp_x
	lda player_ypos
	sta temp_y
	jmp @waitkey

@britannia:
	lda tile_xpos
	sta temp_x
	lda tile_ypos
	sta temp_y
@waitkey:
	jsr flash_location
	lda hw_KEYBOARD
	bpl @waitkey
	bit hw_STROBE
	rts

clear_view:
	ldx #$08     ;line_min
@next_row:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	ldy #$16     ;col_max
	lda #$00
@next_col:
	sta (ptr1),y
	dey
	bne @next_col
	inx
	cpx #$b8     ;line_max
	bcc @next_row
	rts

get_at_xy:
	lda current_location
	beq @britannia ;loc_world

; X,Y range 0..31
; Their 5 bits are used as buffer offsets as follows:
; ptr2 = view_buf + [0000 00yy yyyx xxxx]
	lda temp_y
	sta ptr2 + 1
	lda #$00
	lsr ptr2 + 1
	ror
	lsr ptr2 + 1
	ror
	lsr ptr2 + 1
	ror
	adc temp_x
	sta ptr2
	clc
	lda ptr2 + 1
	adc #>view_buf
	sta ptr2 + 1
	ldy #$00
	lda (ptr2),y
	rts

; X,Y range 0..31
; Their 5 bits are used as buffer offsets as follows:
; ptr2 = view_buf + [0000 00yx yyyy xxxx]
@britannia:
	lda temp_y
	asl
	asl
	asl
	asl
	sta ptr2
	lda temp_x
	and #$0f
	ora ptr2
	sta ptr2
	lda temp_y
	and #$10
	asl
	ora temp_x
	lsr
	lsr
	lsr
	lsr
	clc
	adc #>view_buf
	sta ptr2 + 1
	ldy #$00
	lda (ptr2),y
	rts

; PATTERNS
;  00    01    02    03    04    05
; ++++  +#++  +++#  #+#+  ####  ++++
; ++++  +++#  +#++  #+#+  ++++  +##+
; ++++  +#++  +++#  #+#+  ++++  +##+
; ++++  +++#  +#++  #+#+  ####  ++++
;
;  06    07    08    09    0a    0b
; ####  ####  ##++  +#+#  #+++  #+++
; #++#  ####  ##++  +#++  ++#+  ++++
; #++#  ####  ++##  +#+#  #+++  ++#+
; ####  ####  ++##  +++#  ++#+  ++++
;
;  0c (odd)    0c (even)
; ++++        ++#+
; ++++        ++++
; ++#+        ++++
; ++++        ++++

pattern_00:
	rts

pattern_01:
	lda #$10
	jsr set_bit
	lda #$31
	jsr set_bit
	lda #$12
	jsr set_bit
	lda #$33
	jsr set_bit
	rts

pattern_02:
	jsr pattern_01
	lda #$30
	jsr set_bit
	lda #$11
	jsr set_bit
	lda #$32
	jsr set_bit
	lda #$13
	jsr set_bit
	rts

pattern_03:
	lda #$00
	jsr set_bit
	lda #$01
	jsr set_bit
	lda #$02
	jsr set_bit
	lda #$03
	jsr set_bit
	lda #$20
	jsr set_bit
	lda #$21
	jsr set_bit
	lda #$22
	jsr set_bit
	lda #$23
	jsr set_bit
	rts

pattern_04:
	lda #$00
	jsr set_bit
	lda #$10
	jsr set_bit
	lda #$20
	jsr set_bit
	lda #$30
	jsr set_bit
	lda #$03
	jsr set_bit
	lda #$13
	jsr set_bit
	lda #$23
	jsr set_bit
	lda #$33
	jsr set_bit
	rts

pattern_05:
	lda #$11
	jsr set_bit
	lda #$12
	jsr set_bit
	lda #$21
	jsr set_bit
	lda #$22
	jsr set_bit
	rts

pattern_06:
	jsr pattern_04
	lda #$01
	jsr set_bit
	lda #$02
	jsr set_bit
	lda #$31
	jsr set_bit
	lda #$32
	jsr set_bit
	rts

pattern_07:
	jsr pattern_05
	jsr pattern_06
	rts

pattern_08:
	lda #$00
	jsr set_bit
	lda #$01
	jsr set_bit
	lda #$10
	jsr set_bit
	lda #$11
	jsr set_bit
	lda #$22
	jsr set_bit
	lda #$23
	jsr set_bit
	lda #$32
	jsr set_bit
	lda #$33
	jsr set_bit
	rts

pattern_09:
	lda #$10
	jsr set_bit
	lda #$11
	jsr set_bit
	lda #$12
	jsr set_bit
	lda #$30
	jsr set_bit
	lda #$32
	jsr set_bit
	lda #$33
	jsr set_bit
	rts

pattern_0a:
	lda #$00
	jsr set_bit
	lda #$02
	jsr set_bit
	lda #$21
	jsr set_bit
	lda #$23
	jsr set_bit
	rts

pattern_0b:
	lda #$00
	jsr set_bit
	lda #$22
	jsr set_bit
	rts

pattern_0c:
	lda temp_x
	lsr
	bcc @alternate
	lda #$22
	jsr set_bit
	rts

@alternate:
	lda #$20
	jsr set_bit
	rts

; NOTE: These bit routines use the TBLS data file
; to address the display in absolute pixel columns.
; Even though Apple II has only 7 columns per HGR byte,
; view_map cells are truly 4 pixels wide, straddling
; bytes when necessary.

; With A = [00xx 00yy],
; set a bit within the 4x4 display cell
; for the current terrain coordinate (temp_x,y)
set_bit:
	pha
	and #$0f
	sta delta_y
	pla
	lsr
	lsr
	lsr
	lsr
	sta delta_x
	lda temp_x
	asl
	asl
	adc delta_x
	sta temp2_x
	lda temp_y
	asl
	asl
	adc delta_y
	sta temp2_y
	ldy temp2_y
	lda bmplineaddr_lo + 30,y
	sta ptr1
	lda bmplineaddr_hi + 30,y
	sta ptr1 + 1
	ldx temp2_x
	ldy bmpcol_byte + 20,x
	lda bmpcol_bit + 20,x
	ora (ptr1),y
	and #$7f
	sta (ptr1),y
	rts

flash_location:
	lda #$00
	jsr @invert_bit
	lda #$01
	jsr @invert_bit
	lda #$02
	jsr @invert_bit
	lda #$03
	jsr @invert_bit
	lda #$10
	jsr @invert_bit
	lda #$11
	jsr @invert_bit
	lda #$12
	jsr @invert_bit
	lda #$13
	jsr @invert_bit
	lda #$20
	jsr @invert_bit
	lda #$21
	jsr @invert_bit
	lda #$22
	jsr @invert_bit
	lda #$23
	jsr @invert_bit
	lda #$30
	jsr @invert_bit
	lda #$31
	jsr @invert_bit
	lda #$32
	jsr @invert_bit
	lda #$33
	jsr @invert_bit
	rts

; With A = [00xx 00yy],
; toggle a bit within the 4x4 display cell
; for the current terrain coordinate (temp_x,y)
@invert_bit:
	pha
	and #$0f
	sta delta_y
	pla
	lsr
	lsr
	lsr
	lsr
	sta delta_x
	lda temp_x
	asl
	asl
	adc delta_x
	sta temp2_x
	lda temp_y
	asl
	asl
	adc delta_y
	sta temp2_y
	ldy temp2_y
	lda bmplineaddr_lo + 30,y
	sta ptr1
	lda bmplineaddr_hi + 30,y
	sta ptr1 + 1
	ldx temp2_x
	ldy bmpcol_byte + 20,x
	lda bmpcol_bit + 20,x
	eor (ptr1),y
	sta (ptr1),y
	rts

tile_pattern_table:
	.byte $0c,$0b,$0a,$01,$01,$09,$02,$08
	.byte $07,$05,$05,$05,$05,$04,$04,$04
	.byte $05,$05,$05,$05,$05,$05,$05,$04
	.byte $05,$04,$04,$05,$05,$06,$06,$05
	.byte $06,$06,$06,$06,$06,$06,$06,$06
	.byte $06,$06,$06,$06,$06,$06,$06,$06
	.byte $07,$07,$07,$07,$07,$07,$07,$05
	.byte $05,$07,$06,$06,$05,$00,$03,$04
	.byte $03,$03,$03,$03,$03,$03,$03,$03
	.byte $03,$07,$03,$03,$03,$03,$03,$03
	.byte $05,$05,$05,$05,$05,$05,$05,$05
	.byte $05,$05,$05,$05,$05,$05,$05,$05
	.byte $04,$04,$04,$04,$04,$04,$04,$04
	.byte $04,$04,$04,$04,$04,$04,$04,$04
	.byte $04,$04,$04,$04,$04,$04,$04,$04
	.byte $04,$04,$04,$04,$04,$06,$00,$07

; junk - leftover partial table after code was condensed, presumably
;	.byte $0c,$0b,$0a,$01,$01,$09,$02,$08
;	.byte $07,$05,$05,$05,$05,$04,$04,$04
;	.byte $05,$05,$05,$05,$05,$05,$05,$04
;	.byte $05,$04,$04,$05,$05,$06,$06,
	.byte                             $05
	.byte $06,$06,$06,$06,$06,$06,$06,$06
	.byte $06,$06,$06,$06,$06,$06,$06,$06
	.byte $07,$07,$07,$07,$07,$07,$07,$05
	.byte $05,$07,$06,$06,$05,$00,$03,$04
	.byte $03,$03,$03,$03,$03,$03,$03,$03
	.byte $03,$07,$03,$03,$03,$03,$03,$03
	.byte $05,$05,$05,$05,$05,$05,$05,$05
	.byte $05,$05,$05,$05,$05,$05,$05,$05
	.byte $04,$04,$04,$04,$04,$04,$04,$04
	.byte $04,$04,$04,$04,$04,$04,$04,$04
	.byte $04,$04,$04,$04,$04,$04,$04,$04
	.byte $04,$04,$04,$04,$04,$06,$00,$07

; junk
	.byte $92
	beq :+
	lda #$01
	sta $97
:	lda #$0d
