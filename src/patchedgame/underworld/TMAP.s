	.include "uscii.i"

	.include "apple.i"
	.include "char.i"
	.include "dungeon.i"
	.include "map_objects.i"
	.include "jump_subs.i"
	.include "tables.i"
	.include "view_map.i"
	.include "zp_main.i"

	.include "PRTY.i"


cell_max_x = $17
cell_max_y = $17

line_min = $08
line_max = $b8

xy_center_cell = $0b
;xy_base_offset = (-xy_center_cell) .MOD 8   ;results in negative value
xy_base_offset = ($100 - xy_center_cell) .MOD 8   ;$100 = 0 mod 8


	.segment "VIEWMAP"

.assert * = j_viewmap, error, "Wrong start address"
	lda console_xpos
	sta saved_console_xpos
	lda console_ypos
	sta saved_console_ypos
	jsr clear_view

; initialize variables
	ldx #$00
	txa
@clear_buffer:
	sta visited_buffer,x
	sta visited_buffer + $100,x
	inx
	bne @clear_buffer

	lda #$00
	sta explore_head     ;BUGFIX - breadth-first search
	sta explore_tail

	clc                  ;BUGFIX - greater search depth
	lda player_xpos
	adc #xy_base_offset  ;BUGFIX - greater search depth
	sta view_offset_x
;	sta current_x
	lda player_ypos
	adc #xy_base_offset  ;BUGFIX - greater search depth
	sta view_offset_y
;	sta current_y

	lda #xy_center_cell
	sta console_xpos
	sta console_ypos

	lda #glyph_diamond
	jsr j_console_out
	dec console_xpos

@draw_all_neighbors:
	lda #$ff
	sta neighbor_x
	sta neighbor_y
@draw_neighbor:
	lda neighbor_x
	bne @print
	lda neighbor_y
	beq @next_neighbor
@print:
	clc
	lda console_xpos   ;BUGFIX - greater search depth
	adc view_offset_x  ;BUGFIX - greater search depth
;	lda current_x      ;BUGFIX - greater search depth
	adc neighbor_x
	and #$07
	sta dungeon_x
	clc
	lda console_ypos   ;BUGFIX - greater search depth
	adc view_offset_y  ;BUGFIX - greater search depth
;	lda current_y
	adc neighbor_y
	and #$07
	sta dungeon_y
;ENHANCEMENT: defer fetching tile, to exclude visited cells
;	jsr get_dng_tile
	jsr explore_cell
@next_neighbor:
	inc neighbor_x
	lda neighbor_x
	cmp #$02
	bcc @draw_neighbor
	lda #$ff
	sta neighbor_x
	inc neighbor_y
	lda neighbor_y
	cmp #$02
	bcc @draw_neighbor
;BUGFIX - breadth-first search
	jsr pop_explore
	beq @done
; (original code)
;	lda stack_pos
;	beq @done
;	jsr pop_explore
;BUGFIX END
	jmp @draw_all_neighbors

@done:
	lda #xy_center_cell
	sta console_xpos
	sta console_ypos
	lda #glyph_diamond
	jsr j_console_out
	lda saved_console_xpos
	sta console_xpos
	lda saved_console_ypos
	sta console_ypos
@waitkey:
	lda hw_KEYBOARD
	bpl @waitkey
	bit hw_STROBE
	rts

clear_view:
	ldx #line_min
@next_row:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	ldy #cell_max_x - 1
	lda #$80
@next_col:
	sta (ptr1),y
	dey
	bne @next_col
	inx
	cpx #line_max
	bcc @next_row
	rts

;BUGFIX: double the search depth
; by removing dungeon_x,y from storage,
; instead calulating them directly from
; console_xpos,ypos and constant view_offset_x,y

push_explore:
	ldx explore_tail
;	lda dungeon_x
;	sta explore_buffer,x
;	inx
;	lda dungeon_y
;	sta explore_buffer,x
;	inx
	lda console_xpos
	sta explore_buffer,x
	inx
	lda console_ypos
	sta explore_buffer,x
	inx
	stx explore_tail
	rts

;BUGFIX BFS: breadth-first search
pop_explore:
	ldx explore_head
	cpx explore_tail
	beq @done
	lda explore_buffer,x
	sta console_xpos
	inx
	lda explore_buffer,x
	sta console_ypos
	inx
	stx explore_head
	lda #$ff   ;return NE
@done:
	rts

;(original code)
;pop_explore:
;	ldx stack_pos
;	dex
;	lda explore_buffer,x
;	sta console_ypos
;	dex
;	lda explore_buffer,x
;	sta console_xpos
;	dex
;	lda explore_buffer,x
;	sta current_y
;	dex
;	lda explore_buffer,x
;	sta current_x
;	stx stack_pos
;	rts

get_dng_tile:
	lda dungeon_level
	lsr
	lsr
	clc
	adc #>view_buf
	sta ptr2 + 1
	lda dungeon_level
	and #$03
	asl
	asl
	asl
	ora dungeon_y
	asl
	asl
	asl
	ora dungeon_x
	sta ptr2
	ldy #$00
	lda (ptr2),y
	rts

explore_cell:
;	sta dng_tile
	clc
	lda console_xpos
	adc neighbor_x
	sta console_xpos
	clc
	lda console_ypos
	adc neighbor_y
	sta console_ypos
	lda console_xpos
	beq @done
	cmp #cell_max_x
	bcs @done
	lda console_ypos
	beq @done
	cmp #cell_max_y
	bcs @done
	jsr get_visited_ptr
	lda (ptr1),y
	bne @done
;ENHANCEMENT BEGIN
; mark visited now, eliminate repeat jsr get_visited_ptr
	lda #$ff
	sta (ptr1),y
; only fetch tile type for unvisited cells
	jsr get_dng_tile
; eliminate need for 'dng_tile' variable
	pha
	jsr plot_char
	pla
	cmp #dng_tile_wall
	beq @done
	jsr push_explore

; (original code)
;	lda dng_tile
;	jsr plot_char
;	lda dng_tile
;	cmp #dng_tile_wall
;	beq @dont_push
;	jsr push_explore
;@dont_push:
;	jsr get_visited_ptr
;	lda #$ff
;	sta (ptr1),y
;ENHANCEMENT END
@done:
	sec
	lda console_xpos
	sbc neighbor_x
	sta console_xpos
	sec
	lda console_ypos
	sbc neighbor_y
	sta console_ypos
	rts

plot_char:
	lsr
	lsr
	lsr
	lsr
	tax
	lda tile_chars,x
	jsr j_console_out
	dec console_xpos
	rts

tile_chars:
	.byte glyph_space           ;dng_tile_empty
	.byte glyph_up_arrow        ;dng_tile_ladder_u
	.byte glyph_down_arrow      ;dng_tile_ladder_d
	.byte glyph_up_down_arrow   ;dng_tile_ladder_du
	.byte glyph_dollar_sign     ;dng_tile_chest
	.byte glyph_space           ;dng_tile_hole_up
	.byte glyph_space           ;dng_tile_hole_down
	.byte glyph_dot             ;dng_tile_orb
	.byte char_T                ;dng_tile_trap
	.byte char_F                ;dng_tile_fountain
	.byte char_carat            ;dng_tile_field
	.byte glyph_altar           ;dng_tile_altar
	.byte glyph_box             ;dng_tile_door
	.byte glyph_box             ;dng_tile_room
	.byte glyph_corners         ;dng_tile_secret_door
	.byte glyph_block           ;dng_tile_wall

; Set up (ptr),Y to access 22x22 "flat array" in visited_buffer
; for the cell specified by console_xpos,ypos (range 1..22 each)
get_visited_ptr:
	ldx console_ypos
;ENHANCEMENT:
; Since 2 pages (512 bytes) are reserved for visited_buffer
; we can reduce code by NOT decrementing xpos,ypos to range 0..21
; thus occupying region 23..506 of the buffer instead of 0..483
	lda row_offset_hi,x
	sta ptr1 + 1
	lda row_offset_lo,x
	sta ptr1
;ENHANCEMENT: set up "(ptr),Y" as "(row),col" instead of "(cell),0"
	ldy console_xpos
	rts

; Look-up table for row offsets in the 22x22 'visited' buffer at $9200
row_offset_hi:
	.repeat 23, line
;ENHANCEMENT: pre-calculate absolute buffer addresses instead of relative
		.byte >visited_buffer + >(line * 22)
	.endrepeat
row_offset_lo:
	.repeat 23, line
		.byte <visited_buffer + <(line * 22)
	.endrepeat


;ENHANCEMENT: put the following in a BSS segment to exclude them from prg file

	.segment "VIEWVARS"

explore_head:   ;was stack_pos
	.byte 0
explore_tail:   ;was dng_tile
	.byte 0
view_offset_x:  ;was current_x
	.byte 0
view_offset_y:  ;was current_y
	.byte 0
neighbor_x:
	.byte 0
neighbor_y:
	.byte 0
dungeon_x:
	.byte 0
dungeon_y:
	.byte 0
saved_console_xpos:
	.byte 0
saved_console_ypos:
	.byte 0

.assert * <= visited_buffer, error, "View segment is too large"
