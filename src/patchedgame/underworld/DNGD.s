	.include "uscii.i"

	.include "apple.i"
	.include "dungeon.i"
	.include "map_objects.i"
	.include "tables.i"
	.include "tiles.i"
	.include "zp_main.i"

	.include "PRTY.i"


; Placeholder operands that get altered
; by self-modifying code.

TMP_PAGE = $ff00
TMP_ADDR = $ffff


; --- Custom use of Zero Page

tile_forward_1 = $c9
tile_forward_2 = $ca
tile_forward_3 = $cb
tile_behind = $cc



	.segment "DUNGEON_DRAW"

	jmp dungeon_check_update

	jmp draw_items_monsters

	jsr get_neighbor_tiles
	jmp dungeon_render

dungeon_check_update:
	jsr get_neighbor_tiles
	lda dungeon_level
	cmp last_drawn_dungeon_level
	bne dungeon_render
	lda player_xpos
	cmp last_drawn_player_xpos
	bne dungeon_render
	lda player_ypos
	cmp last_drawn_player_ypos
	bne dungeon_render
	lda dng_direction
	cmp last_drawn_dng_direction
	bne dungeon_render
	lda tile_under_player
	cmp last_drawn_tile_under_player
	bne dungeon_render
	and #dng_tile_type_mask
	cmp #dng_tile_field
	beq update_items_monsters
	cmp #dng_tile_room
	bcs update_items_monsters
	lda tile_forward_1
	cmp last_drawn_forward_1
	bne dungeon_render
	and #dng_tile_type_mask
	cmp #dng_tile_field
	beq update_items_monsters
	cmp #dng_tile_door
	bcs update_items_monsters
	lda tile_forward_2
	cmp last_drawn_forward_2
	bne dungeon_render
	and #dng_tile_type_mask
	cmp #dng_tile_field
	beq update_items_monsters
	cmp #dng_tile_door
	bcs update_items_monsters
	lda tile_forward_3
	cmp last_drawn_forward_3
	bne dungeon_render
	beq update_items_monsters
dungeon_render:
	lda dungeon_level
	sta last_drawn_dungeon_level
	lda player_xpos
	sta last_drawn_player_xpos
	lda player_ypos
	sta last_drawn_player_ypos
	lda dng_direction
	sta last_drawn_dng_direction
	lda tile_behind
	sta last_drawn_under_player
	lda tile_under_player
	sta last_drawn_tile_under_player
	lda tile_forward_1
	sta last_drawn_forward_1
	lda tile_forward_2
	sta last_drawn_forward_2
	lda tile_forward_3
	sta last_drawn_forward_3
	jsr draw_dungeon
update_items_monsters:
	jsr draw_items_monsters
	rts

draw_dungeon:
	jsr clear_view
	lda light_duration
	bne @light
	rts

@light:
	lda #$00
	sta render_distance
render_forward:
	jsr get_coords_in_front
	jsr get_dungeon_tile_type
	bne @ladder_up
	jmp render_left

@ladder_up:
	tax
	dex
	bne @ladder_down
	jsr render_ladder_up
	jmp render_left

@ladder_down:
	dex
	bne @ladder_up_down
	jsr render_ladder_down
	jmp render_left

@ladder_up_down:
	dex
	bne @chest
	jsr render_ladder_up
	jsr render_ladder_down
	jmp render_left

@chest:
	dex
	bne @ceiling_hole
	jmp render_left

@ceiling_hole:
	dex
	bne @floor_hole
	jsr render_ceiling_hole
	jmp render_left

@floor_hole:
	dex
	bne @check_field
	jsr render_floor_hole
	jmp render_left

@check_field:
	dex
	dex
	dex
	dex
	bmi render_left
	bne @door
	jsr get_dungeon_tile
	jsr render_field
	jmp render_done

@door:
	dex
	beq render_left
	dex
	bne @dungeon_room
	jsr render_front_wall
	jsr render_front_door
	lda render_distance
	beq render_next_step
	jmp render_done

@dungeon_room:
	dex
	bne @wall
	jsr render_front_wall
	jsr render_front_door
	jmp render_done

@wall:
	jsr render_front_wall
	jmp render_done

render_left:
	jsr get_coords_front_left
	jsr get_dungeon_tile_type
	cmp #dng_tile_door / $10
	bcs @door_or_wall
	jsr render_left_corridor
	jmp render_right

@door_or_wall:
	cmp #dng_tile_secret_door / $10
	bcs @wall
	jsr render_left_wall
	jsr render_left_door
	jmp render_right

@wall:
	jsr render_left_wall
	jmp render_right

render_right:
	jsr get_coords_front_right
	jsr get_dungeon_tile_type
	cmp #dng_tile_door / $10
	bcs @door_or_wall
	jsr render_right_corridor
	jmp render_next_step

@door_or_wall:
	cmp #dng_tile_secret_door / $10
	bcs @wall
	jsr render_right_wall
	jsr render_right_door
	jmp render_next_step

@wall:
	jsr render_right_wall
	jmp render_next_step

render_next_step:
	inc render_distance
	lda render_distance
	cmp #$04
	bcs render_done
	jmp render_forward

render_done:
	rts

get_neighbor_tiles:
	ldx dng_direction
	sec
	lda player_xpos
	sbc dir_delta_x,x
	and #xy_max_dungeon
	sta gdt_x
	sec
	lda player_ypos
	sbc dir_delta_y,x
	and #xy_max_dungeon
	sta gdt_y
	jsr get_dungeon_tile
	sta tile_behind
	lda player_xpos
	sta gdt_x
	lda player_ypos
	sta gdt_y
	jsr get_dungeon_tile
	sta tile_under_player
	ldx dng_direction
	clc
	lda gdt_x
	adc dir_delta_x,x
	and #xy_max_dungeon
	sta gdt_x
	clc
	lda gdt_y
	adc dir_delta_y,x
	and #xy_max_dungeon
	sta gdt_y
	jsr get_dungeon_tile
	sta tile_forward_1
	ldx dng_direction
	clc
	lda gdt_x
	adc dir_delta_x,x
	and #xy_max_dungeon
	sta gdt_x
	clc
	lda gdt_y
	adc dir_delta_y,x
	and #xy_max_dungeon
	sta gdt_y
	jsr get_dungeon_tile
	sta tile_forward_2
	ldx dng_direction
	clc
	lda gdt_x
	adc dir_delta_x,x
	and #xy_max_dungeon
	sta gdt_x
	clc
	lda gdt_y
	adc dir_delta_y,x
	and #xy_max_dungeon
	sta gdt_y
	jsr get_dungeon_tile
	sta tile_forward_3
	rts

init_dy_with_distance:
	sec
	lda #$00
	sbc render_distance
	sta draw_height
	rts

get_coords_in_front:
	jsr init_dy_with_distance
	lda #$00
	sta draw_width
	jsr rotate_coords
	rts

get_coords_front_left:
	jsr init_dy_with_distance
	lda #$ff
	sta draw_width
	jsr rotate_coords
	rts

get_coords_front_right:
	jsr init_dy_with_distance
	lda #$01
	sta draw_width
	jsr rotate_coords
	rts

rotate_coords:
	ldy dng_direction
	beq @done
@rotate:
	ldx draw_width
	lda draw_height
	eor #$ff
	sta draw_width
	inc draw_width
	stx draw_height
	dey
	bne @rotate
@done:
	clc
	lda player_xpos
	adc draw_width
	and #xy_max_dungeon
	sta gdt_x
	clc
	lda player_ypos
	adc draw_height
	and #xy_max_dungeon
	sta gdt_y
	rts

clear_view:
	ldx #$08     ;line_min
@next_row:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	ldy #$16     ;col_max
	lda #$80
@next_col:
	sta (ptr1),y
	dey
	bne @next_col
	inx
	cpx #$b8     ;line_max
	bcc @next_row
	rts

get_dungeon_tile_type:
	jsr get_dungeon_tile
	lsr
	lsr
	lsr
	lsr
	rts

get_dungeon_tile:
	lda dungeon_level
	lsr
	lsr
	clc
	adc #>dng_map
	sta ptr2 + 1
	lda dungeon_level
	and #$03
	asl
	asl
	asl
	ora gdt_y
	asl
	asl
	asl
	ora gdt_x
	sta ptr2
	ldy #$00
	lda (ptr2),y
	rts

render_left_wall:
	ldx render_distance
	lda wall_left_x,x
	sta draw_x1
	lda wall_left_x+1,x
	sta draw_x2
	lda wall_top_y,x
	sta draw_top_y1
	lda wall_top_y+1,x
	sta draw_top_y2
	lda wall_bottom_y,x
	sta draw_bottom_y1
	lda wall_bottom_y+1,x
	sta draw_bottom_y2
	jsr set_wall_pattern_a
	jmp draw_wall

render_right_wall:
	ldx render_distance
	lda wall_right_x,x
	sta draw_x1
	lda wall_right_x+1,x
	sta draw_x2
	lda wall_top_y,x
	sta draw_top_y1
	lda wall_top_y+1,x
	sta draw_top_y2
	lda wall_bottom_y,x
	sta draw_bottom_y1
	lda wall_bottom_y+1,x
	sta draw_bottom_y2
	jsr set_wall_pattern_a
	jmp draw_wall

render_front_wall:
	ldx render_distance
	lda wall_left_x,x
	sta draw_x1
	lda wall_right_x,x
	sta draw_x2
	lda wall_top_y,x
	sta draw_top_y1
	sta draw_top_y2
	lda wall_bottom_y,x
	sta draw_bottom_y1
	sta draw_bottom_y2
	jsr set_wall_pattern_b
	jmp draw_wall

render_left_door:
	jsr @set_coords
	lda #$ff
	sta column_draw_mode
	jmp draw_wall

@set_coords:
	ldx render_distance
	lda door_left_start_x,x
	sta draw_x1
	lda door_left_end_x,x
	sta draw_x2
	lda door_top_start_y,x
	sta draw_top_y1
	lda door_top_end_y,x
	sta draw_top_y2
	lda door_bottom_start_y,x
	sta draw_bottom_y1
	lda door_bottom_end_y,x
	sta draw_bottom_y2
	rts

render_right_door:
	jsr @set_coords
	lda #$ff
	sta column_draw_mode
	jmp draw_wall

@set_coords:
	ldx render_distance
	lda door_right_start_x,x
	sta draw_x1
	lda door_right_end_x,x
	sta draw_x2
	lda door_top_start_y,x
	sta draw_top_y1
	lda door_top_end_y,x
	sta draw_top_y2
	lda door_bottom_start_y,x
	sta draw_bottom_y1
	lda door_bottom_end_y,x
	sta draw_bottom_y2
	rts

render_front_door:
	ldx render_distance
	beq @inside
	jsr @draw_wall
	lda #$ff
	sta column_draw_mode
	jmp draw_wall

@inside:
	jsr @draw_wall
	lda #$00
	sta column_draw_mode
	jmp draw_wall

@draw_wall:
	ldx render_distance
	lda wall_left_x+1,x
	sta draw_x1
	lda wall_right_x+1,x
	sta draw_x2
	lda wall_top_y+1,x
	sta draw_top_y1
	sta draw_top_y2
	lda wall_bottom_y,x
	sta draw_bottom_y1
	sta draw_bottom_y2
	rts

render_left_corridor:
	ldx render_distance
	lda wall_left_x,x
	sta draw_x1
	lda wall_left_x+1,x
	sta draw_x2
	lda wall_top_y+1,x
	sta draw_top_y1
	sta draw_top_y2
	lda wall_bottom_y+1,x
	sta draw_bottom_y1
	sta draw_bottom_y2
	jsr set_wall_pattern_b
	jmp draw_wall

render_right_corridor:
	ldx render_distance
	lda wall_right_x,x
	sta draw_x1
	lda wall_right_x+1,x
	sta draw_x2
	lda wall_top_y+1,x
	sta draw_top_y1
	sta draw_top_y2
	lda wall_bottom_y+1,x
	sta draw_bottom_y1
	sta draw_bottom_y2
	jsr set_wall_pattern_b
	jmp draw_wall

render_ladder_up:
	jsr render_ceiling_hole
	lda dng_direction
	lsr
	bcs @head_on
	jmp @from_side

@head_on:
	ldx render_distance
	lda ladder_left_x,x
	sta pixel_x
	lda ceiling_hole_top_y,x
	sta pixel_column_start_y
	lda #$5f
	sta pixel_column_end_y
	jsr set_pixel_column
	inc pixel_x
	jsr set_pixel_column
	ldx render_distance
	lda ladder_right_x,x
	sta pixel_x
	lda ceiling_hole_top_y,x
	sta pixel_column_start_y
	lda #$5f
	sta pixel_column_end_y
	jsr set_pixel_column
	dec pixel_x
	jsr set_pixel_column
	ldx render_distance
	lda ladder_left_x,x
	sta draw_x1
	lda ladder_right_x,x
	sta draw_x2
	lda ladder_up_top_rung_y,x
	sta draw_y1
	sta draw_y2
	jsr draw_line
	ldx render_distance
	lda ladder_up_middle_rung_y,x
	sta draw_y1
	sta draw_y2
	jsr draw_line
	ldx render_distance
	lda ladder_up_bottom_rung_y,x
	sta draw_y1
	sta draw_y2
	jsr draw_line
	rts

@from_side:
	ldx render_distance
	lda #$53
	sta pixel_x
	lda ceiling_hole_top_y,x
	sta pixel_column_start_y
	lda #$5f
	sta pixel_column_end_y
	jsr set_pixel_column
	inc pixel_x
	jsr set_pixel_column
	rts

render_ladder_down:
	jsr render_floor_hole
	lda dng_direction
	lsr
	bcs @head_on
	jmp @from_side

@head_on:
	ldx render_distance
	lda ladder_left_x,x
	sta pixel_x
	lda floor_hole_bottom_y,x
	sta pixel_column_end_y
	lda #$60
	sta pixel_column_start_y
	jsr set_pixel_column
	inc pixel_x
	jsr set_pixel_column
	ldx render_distance
	lda ladder_right_x,x
	sta pixel_x
	lda floor_hole_bottom_y,x
	sta pixel_column_end_y
	lda #$60
	sta pixel_column_start_y
	jsr set_pixel_column
	dec pixel_x
	jsr set_pixel_column
	ldx render_distance
	lda ladder_left_x,x
	sta draw_x1
	lda ladder_right_x,x
	sta draw_x2
	lda ladder_down_top_rung_y,x
	sta draw_y1
	sta draw_y2
	jsr draw_line
	ldx render_distance
	lda ladder_down_middle_rung_y,x
	sta draw_y1
	sta draw_y2
	jsr draw_line
	ldx render_distance
	lda ladder_down_bottom_rung_y,x
	sta draw_y1
	sta draw_y2
	jsr draw_line
	rts

@from_side:
	ldx render_distance
	lda #$53
	sta pixel_x
	lda #$60
	sta pixel_column_start_y
	lda floor_hole_bottom_y,x
	sta pixel_column_end_y
	jsr set_pixel_column
	inc pixel_x
	jsr set_pixel_column
	rts

render_ceiling_hole:
	ldx render_distance
	lda hole_bottom_left_x,x
	sta draw_x1
	lda ceiling_hole_top_y,x
	sta draw_y1
	lda hole_top_left_x,x
	sta draw_x2
	lda ceiling_hole_bottom_y,x
	sta draw_y2
	jsr draw_line
	inc draw_x1
	inc draw_x2
	jsr draw_line
	ldx render_distance
	lda hole_top_right_x,x
	sta draw_x1
	lda ceiling_hole_bottom_y,x
	sta draw_y1
	jsr draw_line
	ldx render_distance
	lda hole_bottom_right_x,x
	sta draw_x2
	lda ceiling_hole_top_y,x
	sta draw_y2
	jsr draw_line
	dec draw_x1
	dec draw_x2
	jsr draw_line
	ldx render_distance
	lda hole_bottom_left_x,x
	sta draw_x1
	lda ceiling_hole_top_y,x
	sta draw_y1
	jsr draw_line
	rts

render_floor_hole:
	ldx render_distance
	lda hole_bottom_left_x,x
	sta draw_x1
	lda floor_hole_bottom_y,x
	sta draw_y1
	lda hole_top_left_x,x
	sta draw_x2
	lda floor_hole_top_y,x
	sta draw_y2
	jsr draw_line
	inc draw_x1
	inc draw_x2
	jsr draw_line
	ldx render_distance
	lda hole_top_right_x,x
	sta draw_x1
	lda floor_hole_top_y,x
	sta draw_y1
	jsr draw_line
	ldx render_distance
	lda hole_bottom_right_x,x
	sta draw_x2
	lda floor_hole_bottom_y,x
	sta draw_y2
	jsr draw_line
	dec draw_x1
	dec draw_x2
	jsr draw_line
	ldx render_distance
	lda hole_bottom_left_x,x
	sta draw_x1
	lda floor_hole_bottom_y,x
	sta draw_y1
	jsr draw_line
	rts

set_wall_pattern_a:
	lda dng_direction
	and #$01
	sta column_draw_mode
	inc column_draw_mode
	rts

set_wall_pattern_b:
	lda dng_direction
	and #$01
	eor #$01
	sta column_draw_mode
	inc column_draw_mode
	rts

draw_wall:
	lda draw_top_y1
	sta pixel_column_start_y
	lda draw_bottom_y1
	sta pixel_column_end_y
	lda draw_x1
	sta pixel_x
	lda draw_x1
	cmp draw_x2
	bcs @step_left
	lda #$01
	sta step_x
	sec
	lda draw_x2
	sbc draw_x1
	sta draw_width
	jmp @top

@step_left:
	lda #$ff
	sta step_x
	sec
	lda draw_x1
	sbc draw_x2
	sta draw_width
@top:
	lda #$ff
	sta draw_top_step_y
	sec
	lda draw_top_y1
	sbc draw_top_y2
	sta draw_top_height
	bcs @bottom
	eor #$ff
	sta draw_top_height
	inc draw_top_height
	lda #$01
	sta draw_top_step_y
@bottom:
	lda #$ff
	sta draw_bottom_step_y
	sec
	lda draw_bottom_y1
	sbc draw_bottom_y2
	sta draw_bottom_height
	bcs @draw_column
	eor #$ff
	sta draw_bottom_height
	inc draw_bottom_height
	lda #$01
	sta draw_bottom_step_y
	lda draw_top_height
	lsr
	sta error_delta_top
	lda draw_bottom_height
	lsr
	sta error_delta_bottom
@draw_column:
	jsr set_or_clear_column
	sec
	lda error_delta_top
	sbc draw_top_height
	sta error_delta_top
	bcs @top_step_y_done
@step_top_y:
	clc
	lda pixel_column_start_y
	adc draw_top_step_y
	sta pixel_column_start_y
	clc
	lda error_delta_top
	adc draw_width
	sta error_delta_top
	bmi @step_top_y
@top_step_y_done:
	sec
	lda error_delta_bottom
	sbc draw_bottom_height
	sta error_delta_bottom
	bcs @bottom_step_y_done
@step_bottom_y:
	clc
	lda pixel_column_end_y
	adc draw_bottom_step_y
	sta pixel_column_end_y
	clc
	lda error_delta_bottom
	adc draw_width
	sta error_delta_bottom
	bmi @step_bottom_y
@bottom_step_y_done:
	clc
	lda pixel_x
	adc step_x
	sta pixel_x
	cmp draw_x2
	bne @draw_column
	jsr set_or_clear_column
	rts

set_or_clear_column:
	lda column_draw_mode
	bmi set_pixel_column
	beq clear_pixel_column
set_with_color:
	eor pixel_x
	and #$01
	bne set_done
set_pixel_column:
	ldx pixel_x
	lda bmpcol_bit,x
	ora #$80
	sta temp1
	ldy bmpcol_byte,x
	ldx pixel_column_start_y
@next_row:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	lda temp1
	ora (ptr1),y
	sta (ptr1),y
	inx
	cpx pixel_column_end_y
	bcc @next_row
	beq @next_row
set_done:
	rts

clear_pixel_column:
	ldx pixel_x
	lda bmpcol_bit,x
	eor #$ff
	sta temp1
	ldy bmpcol_byte,x
	ldx pixel_column_start_y
@next_row:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	lda temp1
	and (ptr1),y
	sta (ptr1),y
	inx
	cpx pixel_column_end_y
	bcc @next_row
	beq @next_row
	rts

draw_line:
	sec
	lda draw_x2
	sbc draw_x1
	sta draw_width
	bcs @right
	eor #$ff
	sta draw_width
	inc draw_width
	lda #$ff
	sta step_x
	jmp @get_dy

@right:
	lda #$01
	sta step_x
@get_dy:
	sec
	lda draw_y2
	sbc draw_y1
	sta draw_height
	bcs @down
	eor #$ff
	sta draw_height
	inc draw_height
	lda #$ff
	sta step_y
	jmp @start_draw

@down:
	lda #$01
	sta step_y
@start_draw:
	lda draw_x1
	sta pixel_x
	lda draw_y1
	sta pixel_y
	jsr set_pixel
	lda draw_width
	cmp draw_height
	bcs draw_line_horizontal
	jmp draw_line_vertical

draw_line_horizontal:
	lda draw_width
	sta temp2
	lsr
	sta error_delta_line
@next:
	clc
	lda error_delta_line
	adc draw_height
	sta error_delta_line
	sec
	sbc draw_width
	bcc @skipy
	sta error_delta_line
	clc
	lda pixel_y
	adc step_y
	sta pixel_y
@skipy:
	clc
	lda pixel_x
	adc step_x
	sta pixel_x
	jsr set_pixel
	dec temp2
	bne @next
	rts

draw_line_vertical:
	lda draw_height
	sta temp2
	lsr
	sta error_delta_line
@next:
	clc
	lda error_delta_line
	adc draw_width
	sta error_delta_line
	sec
	sbc draw_height
	bcc @skipx
	sta error_delta_line
	clc
	lda pixel_x
	adc step_x
	sta pixel_x
@skipx:
	clc
	lda pixel_y
	adc step_y
	sta pixel_y
	jsr set_pixel
	dec temp2
	bne @next
	rts

set_pixel:
	ldy pixel_y
	lda bmplineaddr_lo,y
	sta ptr1
	lda bmplineaddr_hi,y
	sta ptr1 + 1
	ldx pixel_x
	ldy bmpcol_byte,x
	lda bmpcol_bit,x
	ora (ptr1),y
	sta (ptr1),y
	rts

draw_items_monsters:
	lda light_duration
	bne @light
	jsr clear_view
	rts

@light:
	lda #$00
	sta render_distance
	lda tile_under_player
	beq @forward_1
	jsr get_monster_type
	beq @no_monster_0
	jsr get_monster_sprite
	jmp draw_sprite_0

@no_monster_0:
	lda tile_under_player
	jsr get_item_sprite
	beq @forward_1
	bmi @check_door
	jmp draw_sprite_0

@check_door:
	lda tile_under_player
	cmp #dng_tile_room
	bcs @done    ;door (room-1) is transparent; room and secret door (room+1) are opaque
@forward_1:
	inc render_distance
	lda tile_forward_1
	beq @forward_2
	jsr get_monster_type
	beq @no_monster_1
	jsr get_monster_sprite
	jmp draw_sprite_1

@no_monster_1:
	lda tile_forward_1
	jsr get_item_sprite
	bmi @done
	beq @forward_2
	jmp draw_sprite_1

@forward_2:
	inc render_distance
	lda tile_forward_2
	beq @forward_3
	jsr get_monster_type
	beq @no_monster_2
	jsr get_monster_sprite
	jmp draw_sprite_2

@no_monster_2:
	lda tile_forward_2
	jsr get_item_sprite
	bmi @done
	beq @forward_3
	jmp draw_sprite_2

@forward_3:
	inc render_distance
	lda tile_forward_3
	beq @done
	jsr get_monster_type
	beq @no_monster_3
	jsr get_monster_sprite
	jmp draw_sprite_3

@no_monster_3:
	lda tile_forward_3
	jsr get_item_sprite
	bmi @done
	beq @done
	jmp draw_sprite_3

@done:
	rts

get_monster_sprite:
	asl
	asl
	clc
	adc #tile_monster_dungeon - 4
	sta temp1
	jsr getrand
	and #$03
	ora temp1
	rts

get_item_sprite:
	sta temp2
	and #dng_tile_type_mask
	cmp #dng_tile_chest
	beq @chest
	cmp #dng_tile_orb
	beq @orb
	cmp #dng_tile_trap
	beq @its_a_trap
	cmp #dng_tile_fountain
	beq @fountain
	cmp #dng_tile_field
	beq @field
	cmp #dng_tile_altar
	beq @altar
	cmp #dng_tile_door
	bcc @empty
	lda #$ff
	rts

@empty:
	lda #$00
	rts

@chest:
	lda #tile_chest
	rts

@orb:
	lda #tile_attack_blue
	rts

@its_a_trap:
	jsr rand_1_in_64
	bmi @empty
	lda temp2
	and #$0f
	beq @empty
	cmp #$08
	bcs @pit
	jsr render_ceiling_hole
	jmp @empty

@pit:
	jsr render_floor_hole
	jmp @empty

@fountain:
	lda #$02
	rts

@field:
	lda temp2
	jsr render_field
	pla
	pla
	rts

@altar:
	lda #$4a
	rts

rand_1_in_64:
	jsr getrand
	and #$3f
	beq @zero
	lda #$ff
@zero:
	rts

get_monster_type:
	sta temp2
	and #dng_tile_type_mask
	cmp #dng_tile_trap
	beq @empty
	cmp #dng_tile_fountain
	beq @empty
	cmp #dng_tile_field
	beq @empty
	cmp #dng_tile_room
	bcs @empty
	lda temp2
	and #dng_tile_foe_mask
	rts

@empty:
	lda #$00
	rts

render_field:
	and #$0f
	sta column_draw_mode
	ldx render_distance
	lda field_y1,x
	sta draw_y1
	lda field_y2,x
	sta draw_y2
	lda field_x1,x
	sta draw_x1
	lda field_x2,x
	sta draw_x2
@next_row:
	ldx draw_y2
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	ldy draw_x2
@next_col:
	jsr rand_field_byte
	sta (ptr1),y
	dey
	cpy draw_x1
	bcs @next_col
	dec draw_y2
	lda draw_y2
	cmp draw_y1
	bcs @next_row
	rts

rand_field_byte:
	jsr getrand
	ldx column_draw_mode
	and field_color_mask,x
	tax
	tya
	lsr
	txa
	bcs @parity_match
	lsr
@parity_match:
	and #$7f
	ldx column_draw_mode
	cpx #$00
	beq @done
	cpx #$03
	beq @done
	ora #$80     ;palette 2
@done:
	rts

; Poison, Lightning, Fire, Sleep
field_color_mask:
	.byte $55,$aa,$55,$aa

; indexed by distance
field_y1:
	.byte $08,$28,$48,$58
field_y2:
	.byte $b7,$97,$77,$67
field_x1:
	.byte $01,$05,$09,$0b
field_x2:
	.byte $16,$12,$0e,$0c

getrand:
	lda rand_data
	adc rand_data+2
	sta rand_data+2
	eor rand_data+1
	sta rand_data+1
	adc rand_data
	sta rand_data
	rts

rand_data:
	.byte $49,$2f,$15

draw_sprite_3:
	tay
	lda #$60     ;first line
	sta sprite_line
	lda #>tilemap
	sta @src1_hi
	sta @src2_hi
@next_line:
	ldx sprite_line
	lda bmplineaddr_lo,x
	sta @dst1_lo
	sta @dst2_lo
	lda bmplineaddr_hi,x
	sta @dst1_hi
	sta @dst2_hi
	ldx #$0b
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
	inc sprite_line
	inc @src1_hi
	inc @src1_hi
	inc @src2_hi
	inc @src2_hi
	lda @src1_hi
	cmp #>tilemap + $10
	bcc @next_line
	rts

draw_sprite_2:
	tay
	lda #$60     ;first line
	sta sprite_line
	lda #>tilemap
	sta @src1_hi
	sta @src2_hi
@next_line:
	ldx sprite_line
	lda bmplineaddr_lo,x
	sta @dst1_lo
	sta @dst2_lo
	lda bmplineaddr_hi,x
	sta @dst1_hi
	sta @dst2_hi
	ldx #$0b
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
	inc sprite_line
	inc @src1_hi
	inc @src2_hi
	lda @src1_hi
	cmp #>tilemap + $10
	bcc @next_line
	rts

draw_sprite_1:
	tay
	lda #$68
	sta sprite_line
	lda #>tilemap
	sta @src1_hi
	sta @src2_hi
	lda #$02
	sta temp2
@next_src_line:
	bit hw_LCBANK1
@src1_hi=*+$02
	lda TMP_PAGE,y
	sta sprite1x_byte1
	and #$80
	sta sprite_palette
	bit hw_LCBANK2
@src2_hi=*+$02
	lda TMP_PAGE,y
	sta sprite1x_byte2
	jsr double_sprite_width
@next_dst_line:
	ldx sprite_line
	lda bmplineaddr_lo,x
	sta @dst1_lo
	sta @dst2_lo
	sta @dst3_lo
	sta @dst4_lo
	lda bmplineaddr_hi,x
	sta @dst1_hi
	sta @dst2_hi
	sta @dst3_hi
	sta @dst4_hi
	ldx #$0a
	lda sprite2x_byte0
@dst1_lo=*+$01
@dst1_hi=*+$02
	sta TMP_ADDR,x
	inx
	lda sprite2x_byte1
@dst2_lo=*+$01
@dst2_hi=*+$02
	sta TMP_ADDR,x
	inx
	lda sprite2x_byte2
@dst3_lo=*+$01
@dst3_hi=*+$02
	sta TMP_ADDR,x
	inx
	lda sprite2x_byte3
@dst4_lo=*+$01
@dst4_hi=*+$02
	sta TMP_ADDR,x
	inc sprite_line
	dec temp2
	bne @next_dst_line
	lda #$02
	sta temp2
	inc @src1_hi
	inc @src2_hi
	lda @src1_hi
	cmp #>tilemap + $10
	bcc @next_src_line
	rts

draw_sprite_0:
	tay
	lda #$70
	sta sprite_line
	lda #>tilemap
	sta @src1_hi
	sta @src2_hi
	lda #$04
	sta temp2
@next_src_line:
	bit hw_LCBANK1
@src1_hi=*+$02
	lda TMP_PAGE,y
	sta sprite1x_byte1
	and #$80
	sta sprite_palette
	bit hw_LCBANK2
@src2_hi=*+$02
	lda TMP_PAGE,y
	sta sprite1x_byte2
	jsr double_sprite_width
@next_dst_line:
	ldx sprite_line
	lda bmplineaddr_lo,x
	sta @dst1_lo
	sta @dst2_lo
	sta @dst3_lo
	sta @dst4_lo
	lda bmplineaddr_hi,x
	sta @dst1_hi
	sta @dst2_hi
	sta @dst3_hi
	sta @dst4_hi
	ldx #$0a
	lda sprite2x_byte0
@dst1_lo=*+$01
@dst1_hi=*+$02
	sta TMP_ADDR,x
	inx
	lda sprite2x_byte1
@dst2_lo=*+$01
@dst2_hi=*+$02
	sta TMP_ADDR,x
	inx
	lda sprite2x_byte2
@dst3_lo=*+$01
@dst3_hi=*+$02
	sta TMP_ADDR,x
	inx
	lda sprite2x_byte3
@dst4_lo=*+$01
@dst4_hi=*+$02
	sta TMP_ADDR,x
	inc sprite_line
	dec temp2
	bne @next_dst_line
	lda #$04
	sta temp2
	inc @src1_hi
	inc @src2_hi
	lda @src1_hi
	cmp #>tilemap + $10
	bcc @next_src_line
	rts

double_sprite_width:
	asl sprite1x_byte1
	asl sprite1x_byte1
	rol sprite1x_byte2
	lda #$00
	sta sprite1x_byteW
	sta sprite2x_byte0
	sta sprite2x_byte1
	sta sprite2x_byte2
	sta sprite2x_byte3
	jsr input_bit ;Center bit of Window is the key.
	jsr input_bit ;Shift in its two neighbors before starting.
	lda #$0e
	sta bit_count
@next_in_bit:
	jsr input_bit
	lda sprite1x_byteW
	and #$1f
	tax
	lda window_table,x
	pha
	jsr output_bit
	pla
	lsr
	jsr output_bit
	dec bit_count
	bne @next_in_bit

	lda sprite2x_byte0
	and #$7f
	ora sprite_palette
	sta sprite2x_byte0
	lda sprite2x_byte1
	and #$7f
	ora sprite_palette
	sta sprite2x_byte1
	lda sprite2x_byte2
	and #$7f
	ora sprite_palette
	sta sprite2x_byte2
	lda sprite2x_byte3
	and #$7f
	ora sprite_palette
	sta sprite2x_byte3
	rts

input_bit:
	asl sprite1x_byte1
	rol sprite1x_byte2
	rol sprite1x_byteW
	rts

; Left-shift 1 bit through a bank of four 7-bit values
output_bit:
	tax
	lda bit_count ;odd/even chooses bit 0/1 from A
	lsr
	txa
	bcs :+
	lsr
:	lsr
	rol sprite2x_byte0
	bpl :+        ;Verbose way of replicating bit 8 into Carry  (CMP $80 is shorter and faster)
	sec
	bcs @1
:	clc
@1:
	rol sprite2x_byte1
	bpl :+
	sec
	bcs @2
:	clc
@2:
	rol sprite2x_byte2
	bpl :+
	sec
	bcs @3
:	clc
@3:
	rol sprite2x_byte3
	rts

window_table:
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte $ff,$55,$ff,$ff,$00,$00,$aa,$00
	.byte $ff,$ff,$ff,$ff,$00,$00,$00,$00
	.byte $55,$55,$ff,$ff,$00,$00,$00,$00
	.byte $ff,$ff,$ff,$ff

; Source bits are multi-byte shifted W << 2 << 1
bit_count:
	.byte $00    ;How many bits remain to be shifted (starts at 14)
sprite1x_byteW:
	.byte $00    ;5-bit Window for table lookup of expansion pattern.
sprite1x_byte1:
	.byte $00    ;1/2 are initialized with bytes from Bank 1/2, then
sprite1x_byte2:
	.byte $00    ;stripped to 7 bits and left-packed during set up.

; This is treated as a single 28-bit value (4 bytes x 7 bits each), constructed by left-shifting
sprite2x_byte0:
	.byte 0
sprite2x_byte1:
	.byte 0
sprite2x_byte2:
	.byte 0
sprite2x_byte3:
	.byte 0

sprite_palette:
	.byte 0
sprite_line:
	.byte 0

render_distance:
	.byte 0
temp1:
	.byte 0
column_draw_mode:
	.byte 0
pixel_x:
	.byte 0
pixel_y:
	.byte 0
gdt_x:
	.byte 0
gdt_y:
	.byte 0
step_x:
	.byte 0
step_y:
	.byte 0
temp2:
	.byte 0
error_delta_line:
	.byte 0
draw_x1:
	.byte 0
draw_x2:
	.byte 0
draw_y1:
	.byte 0
draw_y2:
	.byte 0
draw_width:
	.byte 0
draw_height:
	.byte 0
error_delta_top:
	.byte 0
error_delta_bottom:
	.byte 0
draw_top_y1:
	.byte 0
draw_top_y2:
	.byte 0
draw_top_step_y:
	.byte 0
pixel_column_start_y:
	.byte 0
draw_top_height:
	.byte 0
draw_bottom_y1:
	.byte 0
draw_bottom_y2:
	.byte 0
draw_bottom_step_y:
	.byte 0
pixel_column_end_y:
	.byte 0
draw_bottom_height:
	.byte 0
dir_delta_x:
	.byte 0
	.byte $01,$00,$ff
dir_delta_y:
	.byte $ff
	.byte 0
	.byte $01,$00
wall_left_x:
	.byte $07,$23,$3f,$4d,$53
wall_right_x:
	.byte $a0,$84,$68,$5a,$54
wall_top_y:
	.byte $08,$28,$48,$58,$5f
wall_bottom_y:
	.byte $b7,$97,$77,$67,$60
door_left_start_x:
	.byte $07,$2a,$43,$4f
door_left_end_x:
	.byte $15,$38,$4a,$51
door_right_start_x:
	.byte $a0,$7d,$64,$58
door_right_end_x:
	.byte $92,$6f,$5d,$56
door_top_start_y:
	.byte $34,$48,$56,$5a
door_top_end_y:
	.byte $3d,$51,$5b,$5f
door_bottom_start_y:
	.byte $b7,$8f,$73,$65
door_bottom_end_y:
	.byte $a7,$7f,$6b,$62
ceiling_hole_top_y:
	.byte $08,$30,$4c,$5a
ceiling_hole_bottom_y:
	.byte $18,$40,$54,$5d
floor_hole_bottom_y:
	.byte $b7,$8f,$73,$65
floor_hole_top_y:
	.byte $a7,$7f,$6b,$62
hole_bottom_left_x:
	.byte $2e,$3f,$4b,$51
hole_top_left_x:
	.byte $35,$46,$4f,$52
hole_bottom_right_x:
	.byte $7a,$69,$5d,$56
hole_top_right_x:
	.byte $73,$62,$59,$55
ladder_left_x:
	.byte $3f,$4a,$51,$53
ladder_right_x:
	.byte $68,$5e,$57,$54
ladder_up_top_rung_y:
	.byte $10,$38,$50,$5d
ladder_up_middle_rung_y:
	.byte $30,$48,$56,$5e
ladder_up_bottom_rung_y:
	.byte $50,$58,$5c,$5f
ladder_down_top_rung_y:
	.byte $af,$87,$6f,$62
ladder_down_middle_rung_y:
	.byte $8f,$77,$69,$61
ladder_down_bottom_rung_y:
	.byte $6f,$67,$63,$60
last_drawn_dungeon_level:
	.byte 0
last_drawn_player_xpos:
	.byte 0
last_drawn_player_ypos:
	.byte 0
last_drawn_dng_direction:
	.byte 0
last_drawn_under_player:
	.byte 0
last_drawn_tile_under_player:
	.byte 0
last_drawn_forward_1:
	.byte 0
last_drawn_forward_2:
	.byte 0
last_drawn_forward_3:
	.byte 0

; junk
	.byte $00,$00,$ff,$ff,$00,$00
