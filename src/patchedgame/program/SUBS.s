	.include "uscii.i"

	.include "apple.i"
	.include "char.i"
	.include "dos.i"
	.include "jump_overlay.i"
	.include "jump_system.i"
	.include "map_objects.i"
	.include "moons.i"
	.include "tables.i"
	.include "tiles.i"
	.include "zp_main.i"
	.include "zp_map_scroll.i"
	.include "zp_line_of_sight.i"

	.include "PRTY.i"
	.include "ROST.i"


; Placeholder operands that get altered
; by self-modifying code.

TMP_PAGE = $ff00
TMP_ADDR = $ffff


; --- Custom use of Zero Page

zp_count = $d8
zp_name_count = $da
zp_number = $da

zp_sfx_freq = $da
zp_sfx_duration = $f0


	.segment "SUBS"

j_waitkey:
	jmp waitkey

j_player_teleport:
	jmp player_teleport

j_move_east:
	jmp move_east

j_move_west:
	jmp move_west

j_move_south:
	jmp move_south

j_move_north:
	jmp move_north

j_drawinterface:
	jmp drawinterface

j_drawview:
	jmp drawview

j_update_britannia:
	jmp update_britannia

j_primm_cout:
	jmp primm_cout

j_primm_xy:
	jmp primm_xy

j_primm:
	jmp primm

j_console_out:
	jmp console_out

j_clearbitmap:
	jmp clearbitmap

j_mulax:
	jmp mulax

j_get_stats_ptr:
	jmp get_stats_ptr

j_printname:
	jmp printname

j_printbcd:
	jmp printbcd

j_drawcursor:
	jmp drawcursor

j_drawcursor_xy:
	jmp drawcursor_xy

j_drawvert:
	jmp drawvert

j_drawhoriz:
	jmp drawhoriz

j_request_disk:
	jmp request_disk

j_update_status:
	jmp update_status

j_blocked_tile:
	jmp blocked_tile

j_update_view:
	jmp idle

j_rand:
	jmp rand

j_loadsector:
	jmp loadsector

j_playsfx:
	jmp playsfx

j_update_view_combat:
	jmp idle_combat

j_getnumber:
	jmp getnumber

j_getplayernum:
	jmp getplayernum

j_update_wind:
	jmp update_wind

j_animate_view:
	jmp animate_view

j_printdigit:
	jmp printdigit

j_clearstatwindow:
	jmp clearstatwindow

j_animate_tiles:
	jmp animate_tiles

j_centername:
	jmp centername

j_print_direction:
	jmp print_direction

j_clearview:
	jmp clearview

j_invertview:
	jmp invertview

j_centerstring:
	jmp centerstring

j_printstring:
	jmp printstring

j_gettile_bounds:
	jmp gettile_bounds

j_gettile_britannia:
	jmp gettile_britannia

j_gettile_opposite:
	jmp gettile_opposite

j_gettile_drawn_map:
	jmp gettile_drawn_map

j_gettile_actual_map:
	jmp gettile_actual_map

j_get_player_tile:
	jmp get_player_tile

j_gettile_towne:
	jmp gettile_towne

j_gettile_dungeon:
	jmp gettile_dungeon

;SIZE_OPT: exposed for ULT4 to re-use instead of having its own duplicate
j_math_sign:
	jmp getsign

move_east:
	inc player_xpos
	inc tile_xpos
	lda tile_xpos
	cmp #(xy_last_tile_cache - $08)
	bcc @notileborder
	jsr spin_drive_motor
@notileborder:
	cmp #(xy_last_tile_cache - xy_center_screen)
	bcc movedone
	and #$0f
	sta tile_xpos
	jsr map_scroll_east
	inc map_x
	lda map_x
	and #$0f
	sta map_x
	jsr loadtiles_east
movedone:
	rts

move_west:
	dec player_xpos
	dec tile_xpos
	lda tile_xpos
	cmp #$08
	bcs @notileborder
	jsr spin_drive_motor
@notileborder:
	cmp #xy_center_screen
	bcs movedone
	ora #$10
	sta tile_xpos
	jsr map_scroll_west
	dec map_x
	lda map_x
	and #$0f
	sta map_x
	jmp loadtiles_west

move_south:
	inc player_ypos
	inc tile_ypos
	lda tile_ypos
	cmp #(xy_last_tile_cache - $08)
	bcc @notileborder
	jsr spin_drive_motor
@notileborder:
	cmp #(xy_last_tile_cache - xy_center_screen)
	bcc @done
	and #$0f
	sta tile_ypos
	jsr map_scroll_south
	inc map_y
	lda map_y
	and #$0f
	sta map_y
	jsr loadtiles_south
@done:
	rts

move_north:
	dec player_ypos
	dec tile_ypos
	lda tile_ypos
	cmp #$08
	bcs @notileborder
	jsr spin_drive_motor
@notileborder:
	cmp #xy_center_screen
	bcs @done
	ora #$10
	sta tile_ypos
	jsr map_scroll_north
	dec map_y
	lda map_y
	and #$0f
	sta map_y
	jsr loadtiles_north
@done:
	rts

map_scroll_east:
	ldx #$00
@scroll:
	lda world_map_NE,x
	sta world_map_NW,x
	lda world_map_SE,x
	sta world_map_SW,x
	inx
	bne @scroll
	rts

map_scroll_west:
	ldx #$00
@scroll:
	lda world_map_NW,x
	sta world_map_NE,x
	lda world_map_SW,x
	sta world_map_SE,x
	inx
	bne @scroll
	rts

map_scroll_south:
	ldx #$00
@scroll:
	lda world_map_SW,x
	sta world_map_NW,x
	lda world_map_SE,x
	sta world_map_NE,x
	inx
	bne @scroll
	rts

map_scroll_north:
	ldx #$00
@scroll:
	lda world_map_NW,x
	sta world_map_SW,x
	lda world_map_NE,x
	sta world_map_SE,x
	inx
	bne @scroll
	rts

loadtiles_east:
	lda #RWTS_command_read
	sta diskio_command
	clc
	lda map_x
	adc #$01
	and #$0f
	sta diskio_sector
	lda map_y
	sta diskio_track
	lda #>world_map_NE
	sta diskio_addr_hi
	jsr loadsector
	clc
	lda map_y
	adc #$01
	and #$0f
	sta diskio_track
	lda #>world_map_SE
	sta diskio_addr_hi
	jmp loadsector

loadtiles_west:
	lda #RWTS_command_read
	sta diskio_command
	clc
	lda map_x
	sta diskio_sector
	lda map_y
	sta diskio_track
	lda #>world_map_NW
	sta diskio_addr_hi
	jsr loadsector
	clc
	lda map_y
	adc #$01
	and #$0f
	sta diskio_track
	lda #>world_map_SW
	sta diskio_addr_hi
	jmp loadsector

loadtiles_south:
	lda #RWTS_command_read
	sta diskio_command
	clc
	lda map_y
	adc #$01
	and #$0f
	sta diskio_track
	lda map_x
	sta diskio_sector
	lda #>world_map_SW
	sta diskio_addr_hi
	jsr loadsector
	clc
	lda map_x
	adc #$01
	and #$0f
	sta diskio_sector
	lda #>world_map_SE
	sta diskio_addr_hi
	jmp loadsector

loadtiles_north:
	lda #RWTS_command_read
	sta diskio_command
	clc
	lda map_y
	sta diskio_track
	lda map_x
	sta diskio_sector
	lda #>world_map_NW
	sta diskio_addr_hi
	jsr loadsector
	clc
	lda map_x
	adc #$01
	and #$0f
	sta diskio_sector
	lda #>world_map_NE
	sta diskio_addr_hi
	jmp loadsector

player_teleport:
	lda player_xpos
	jsr div16
	sta map_x
	lda player_xpos
	and #$0f
	sta tile_xpos
	cmp #$08
	bcs @eastern
	clc
	adc #$10
	sta tile_xpos
	dec map_x
	lda map_x
	and #$0f
	sta map_x
@eastern:
	lda player_ypos
	jsr div16
	sta map_y
	lda player_ypos
	and #$0f
	sta tile_ypos
	cmp #$08
	bcs @southern
	clc
	adc #$10
	sta tile_ypos
	dec map_y
	lda map_y
	and #$0f
	sta map_y
@southern:
	lda #RWTS_command_read
	sta diskio_command
	lda map_x
	sta diskio_sector
	lda map_y
	sta diskio_track
	lda #>world_map_NW
	sta diskio_addr_hi
	jsr loadsector
	clc
	lda map_x
	adc #$01
	and #$0f
	sta diskio_sector
	lda #>world_map_NE
	sta diskio_addr_hi
	jsr loadsector
	clc
	lda map_y
	adc #$01
	and #$0f
	sta diskio_track
	lda #>world_map_SE
	sta diskio_addr_hi
	jsr loadsector
	lda map_x
	sta diskio_sector
	lda #>world_map_SW
	sta diskio_addr_hi
loadsector:
	lda #$00
	sta RWTS_volume
	sta RWTS_buf_LO
	lda diskio_track
	sta RWTS_track
	lda diskio_sector
	sta RWTS_sector
	lda diskio_addr_hi
	sta RWTS_buf_HI
	lda diskio_command
	sta RWTS_command
	lda #RWTS_data_epilogue_byte3
	sta DOS_data_prologue_3 ;part of copy protection
	sta RWTS_write_data_epilogue3
	lda #$9b     ;restore normal decode value (presumed part of copy protect on disk 1)
	sta DOS_NIBL+3
	lda #<RWTS_params
	ldy #>RWTS_params
	jsr RWTS_readblock ;sets IOBP H/L to $YYAA
	lda #$00
	sta RWTS_IOBPL ;why clear this? protect against snooping?
	bcs loadsector
	rts

waitkey:
	lda #$80
	sta idletimeout
@wait:
	jsr scankey
	jsr drawcursor
	jsr getkey
	bmi @gotkey
	jsr idle
	dec idletimeout
	bne @wait
	jsr clearcursor
	lda #$00
	rts

@gotkey:
	pha
	jsr clearcursor
	pla
	cmp #$00
	rts

idletimeout:
	.byte 0

idle:
	lda game_mode
	beq delay
	bmi idle_other
idle_britannia:
	cmp #mode_world
	bne idle_towne
	jsr update_wind
	jsr update_balloon
	jsr update_britannia
	rts

idle_towne:
	cmp #mode_towne
	bne idle_dungeon
	jsr update_towne
	rts

idle_dungeon:
	cmp #mode_dungeon
	bne idle_delay
	jsr scroll_tiles
	jsr animate_fields
	jsr j_dng_draw_items_monsters
idle_delay:
	jmp delay

idle_other:
	cmp #mode_shrine
	beq @animate
	jmp idle_combat

@animate:
	jmp animate_view

delay:
	ldx #$4b
	ldy #$00
@delay:
	dey
	bne @delay
	dex
	bne @delay
	rts

update_balloon:
; TRAINER: balloon_steer
	lda balloon_movement
	bpl @no_drift
; TRAINER END
; retail logic
;	lda player_transport
;	cmp #tile_balloon
;	bne @no_drift
;	lda balloon_movement
;	beq @no_drift    ;balloon_landed

	dec movement_counter
	lda movement_counter
	and #$03
	bne @no_drift
@east:
	ldx wind_direction
	bne @south
	jmp move_east
@south:
	dex
	bne @west
	jmp move_south
@west:
	dex
	bne @north
	jmp move_west
@north:
	jmp move_north
@no_drift:
	rts

movement_counter:
	.byte 0

animate_view:
	jsr scroll_tiles
	jsr animate_fields
	jmp drawview

idle_combat:
	jsr scroll_tiles
	jsr animate_fields
	ldx #$7f
@copy:
	lda world_tiles,x
	sta drawn_tiles,x
	dex
	bpl @copy
	ldx #foes_max
@nextmonster:
	ldy combat_foe_cur_y,x
	lda mul_11,y
	clc
	adc combat_foe_cur_x,x
	tay
	lda combat_foe_tile_type,x
	beq @next
	cmp #tile_anhk          ; BUGFIX
	beq @dontanim           ; BUGFIX
	cmp #tile_camp_fire     ; BUGFIX
	beq @dontanim           ; BUGFIX
	lda combat_foe_slept,x
	bne @dontanim
	lda combat_foe_tile_type,x
	cmp #tile_monster_land
	bcs @checkmimic
	jsr rand
	and #$01
@settile:
	clc
	adc combat_foe_tile_type,x
	sta combat_foe_tile_sprite,x
	sta drawn_tiles,y
	jmp @next

@checkmimic:
	cmp #tile_mimic
	bne @anim4
	lda combat_foe_tile_sprite,x
	cmp #tile_chest
	bne @anim4
	sta drawn_tiles,y
	jmp @next

@anim4:
	jsr rand
	and #$01
	beq @dontanim
	inc combat_foe_tile_sprite,x
	lda combat_foe_tile_sprite,x
	and #$03
	jmp @settile

@dontanim:
	lda combat_foe_tile_sprite,x
	sta drawn_tiles,y
@next:
	dex
	bpl @nextmonster
animateplayers:
	ldx party_size
@nextplayer:
	lda combat_player_tile-1,x
	beq @next
	ldy combat_player_ypos-1,x
	lda mul_11,y
	clc
	adc combat_player_xpos-1,x
	tay
	lda combat_player_tile-1,x
	cmp #tile_human_prone
	beq @settile
	cpx curr_y
	bne @animate
	dec movement_counter
	lda movement_counter
	and #$03
	bne @animate
	lda #tile_cursor
	jmp @settile

@animate:
	jsr rand
	and #$01
	clc
	adc combat_player_tile-1,x
@settile:
	sta drawn_tiles,y
@next:
	dex
	bne @nextplayer
	lda attack_sprite
	beq @done
	ldx target_y
	lda mul_11,x
	clc
	adc target_x
	tay
	lda attack_sprite
	sta drawn_tiles,y
@done:
	jmp drawview

update_towne:
	jsr animate_tiles
	sec
	lda player_xpos
	sbc #xy_center_screen
	sta first_x
	sec
	lda player_ypos
	sbc #xy_center_screen
	sta first_y
	lda #$00
	sta count_x
	sta count_y
	tay
	tax
@nexttile:
	clc
	lda first_x
	adc count_x
	sta curr_x
	cmp #xy_last_towne
	bcs @out_of_bounds
	clc
	lda first_y
	adc count_y
	sta curr_y
	cmp #xy_last_towne
	bcs @out_of_bounds
	sta ptr2 + 1
	lda #$00
	lsr ptr2 + 1
	ror
	lsr ptr2 + 1
	ror
	lsr ptr2 + 1
	ror
	adc curr_x
	sta ptr2
	clc
	lda ptr2 + 1
	adc #>world_map_NW
	sta ptr2 + 1
	lda (ptr2),y
	jmp @settile

@out_of_bounds:
	lda #tile_grass
@settile:
	sta world_tiles,x
	inx
	inc count_x
	lda count_x
	cmp #xy_last_screen
	bne @nexttile
	sty count_x
	inc count_y
	lda count_y
	cmp #xy_last_screen
	bne @nexttile
	jmp update_monsters

update_britannia:
	jsr animate_tiles
	jsr update_moons
	sec
	lda tile_xpos
	sbc #xy_center_screen
	sta first_x
	sec
	lda tile_ypos
	sbc #xy_center_screen
	sta first_y
	lda #$00
	sta count_x
	sta count_y
	tay
	tax
@copymap:
	clc
	lda first_x
	adc count_x
	sta curr_x
	clc
	lda first_y
	adc count_y
	sta curr_y
	jsr mul16
	sta ptr2
	lda curr_x
	and #$0f
	ora ptr2
	sta ptr2
	lda curr_y
	and #$10
	asl
	ora curr_x
	jsr div16
	clc
	adc #>world_map_NW
	sta ptr2 + 1
	lda (ptr2),y
	sta world_tiles,x
	inx
	inc count_x
	lda count_x
	cmp #xy_last_screen
	bne @copymap
	sty count_x
	inc count_y
	lda count_y
	cmp #xy_last_screen
	bne @copymap
update_monsters:
	ldx #object_max
@nextmonster:
	lda object_tile_sprite,x
	beq @nomonster
	lda object_xpos,x
	clc
	adc #xy_center_screen
	sec
	sbc player_xpos
	cmp #xy_last_screen
	bcs @nomonster
	sta curr_x
	lda object_ypos,x
	clc
	adc #xy_center_screen
	sec
	sbc player_ypos
	cmp #xy_last_screen
	bcs @nomonster
	sta curr_y
	ldy curr_y
	lda mul_11,y
	clc
	adc curr_x
	tay
	lda object_tile_sprite,x
	sta world_tiles,y
@nomonster:
	dex
	bpl @nextmonster

	lda moongate_tile
	beq @skipmoongates
	lda moongate_xpos
	clc
	adc #xy_center_screen
	sec
	sbc player_xpos
	cmp #xy_last_screen
	bcs @skipmoongates
	sta curr_x
	lda moongate_ypos
	clc
	adc #xy_center_screen
	sec
	sbc player_ypos
	cmp #xy_last_screen
	bcs @skipmoongates
	sta curr_y
	ldy curr_y
	lda mul_11,y
	clc
	adc curr_x
	tay
	lda moongate_tile
	sta world_tiles,y
@skipmoongates:
	lda world_tiles+(xy_last_screen * (xy_center_screen - 1) + xy_center_screen)
	sta tile_north
	lda world_tiles+(xy_last_screen * (xy_center_screen + 1) + xy_center_screen)
	sta tile_south
	lda world_tiles+(xy_last_screen * (xy_center_screen) + xy_center_screen + 1)
	sta tile_east
	lda world_tiles+(xy_last_screen * (xy_center_screen) + xy_center_screen - 1)
	sta tile_west
	lda world_tiles+(xy_last_screen * (xy_center_screen) + xy_center_screen)
	sta tile_under_player
	lda player_transport
	sta world_tiles+(xy_last_screen * (xy_center_screen) + xy_center_screen)
	lda terrain_occlusion
	beq line_of_sight    ;occlusion_on
	ldx #(xy_last_screen * xy_last_screen - 1)
@copy:
	lda world_tiles,x
	sta drawn_tiles,x
	dex
	bpl @copy
	jmp drawview

line_of_sight:
	ldx #(xy_last_screen * xy_last_screen - 1)
	lda #tile_blank
@clear:
	sta drawn_tiles,x
	dex
	bpl @clear

	lda #(xy_last_screen * xy_last_screen - 1)
	sta los_candidate_idx
	lda #xy_last_screen - 1
	sta los_candidate_x
	sta los_candidate_y
los_pass1:
	lda los_candidate_x
	sta los_probe_x
	lda los_candidate_y
	sta los_probe_y
	lda los_candidate_idx
	sta los_probe_idx
@next_probe:
	ldx los_probe_x
	ldy los_probe_y
	lda los_probe_idx
	clc
	adc toward_center_1,x
	clc
	adc toward_center_row,y
	cmp #(xy_last_screen * (xy_center_screen) + xy_center_screen)
	beq @candidate_visible
	sta los_probe_idx
	tax
	lda world_tiles,x
	cmp #tile_forest
	beq @next_candidate
	cmp #tile_mountain
	beq @next_candidate
	cmp #tile_secret_panel
	beq @next_candidate
	cmp #tile_blank
	beq @next_candidate
	cmp #tile_wall
	beq @next_candidate
	lda los_probe_x
	tax
	clc
	adc toward_center_1,x
	sta los_probe_x
	lda los_probe_y
	tax
	clc
	adc toward_center_1,x
	sta los_probe_y
	jmp @next_probe

@candidate_visible:
	ldx los_candidate_idx
	lda world_tiles,x
	sta drawn_tiles,x
@next_candidate:
	dec los_candidate_idx
	dec los_candidate_x
	bpl los_pass1
	lda #xy_last_screen - 1
	sta los_candidate_x
	dec los_candidate_y
	bpl los_pass1
los_pass2:
	lda #(xy_last_screen * xy_last_screen - 1)
	sta los_candidate_idx
	lda #xy_last_screen - 1
	sta los_candidate_x
	sta los_candidate_y
@next:
	lda los_candidate_x
	sta los_probe_x
	lda los_candidate_y
	sta los_probe_y
	lda los_candidate_idx
	sta los_probe_idx
	tax
	lda drawn_tiles,x
	cmp #tile_blank
	bne @next_candidate
@next_probe:
	ldx los_probe_x
	ldy los_probe_y
	lda distance,x
	cmp distance,y
	beq @diagonal
	bcc @vertical
	bcs @horizontal
@diagonal:
	lda los_probe_idx
	clc
	adc toward_center_1,x
	clc
	adc toward_center_row,y
	jsr nexthoriz
	jsr nextvert
	jmp @check_blocked

@horizontal:
	lda los_probe_idx
	clc
	adc toward_center_1,x
	jsr nexthoriz
	jmp @check_blocked

@vertical:
	lda los_probe_idx
	clc
	adc toward_center_row,y
	jsr nextvert
@check_blocked:
	cmp #(xy_last_screen * (xy_center_screen) + xy_center_screen)
	beq @candidate_visible
	sta los_probe_idx
	tax
	lda world_tiles,x
	cmp #tile_forest
	beq @next_candidate
	cmp #tile_mountain
	beq @next_candidate
	cmp #tile_secret_panel
	beq @next_candidate
	cmp #tile_blank
	beq @next_candidate
	cmp #tile_wall
	beq @next_candidate
	jmp @next_probe

@candidate_visible:
	ldx los_candidate_idx
	lda world_tiles,x
	sta drawn_tiles,x
@next_candidate:
	dec los_candidate_idx
	dec los_candidate_x
	bpl @next
	lda #xy_last_screen - 1
	sta los_candidate_x
	dec los_candidate_y
	bmi drawview
	jmp @next

drawview:
	lda #$00
	sta current_draw_line
	sta @src_tile
@next_line:
	ldy current_draw_line
	lda bmplineaddr_lo + 8,y
	sta @dst1_lo
	sta @dst2_lo
	lda bmplineaddr_hi + 8,y
	sta @dst1_hi
	sta @dst2_hi
	tya
	and #$0f
	ora #>tilemap
	sta @src1_hi
	sta @src2_hi
	ldx #$01
@src_tile=*+$01
@next_col:
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
	inc @src_tile
	inx
	cpx #(xy_last_screen * 2) + 1
	bcc @next_col
	inc current_draw_line
	lda current_draw_line
	cmp #$b0
	beq @done
	and #$0f
	beq @next_line
	lda @src_tile
	sec
	sbc #xy_last_screen
	sta @src_tile
	jsr scankey
	jmp @next_line

@done:
	rts

toward_center_1:
	.byte 1, 1, 1, 1, 1, 0, <-1, <-1, <-1, <-1, <-1
toward_center_row:
	.byte 11, 11, 11, 11, 11, 0, <-11, <-11, <-11, <-11, <-11
distance:
	.byte 5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5

nexthoriz:
	pha
	lda los_probe_x
	tax
	clc
	adc toward_center_1,x
	sta los_probe_x
	pla
	rts

nextvert:
	pha
	lda los_probe_y
	tax
	clc
	adc toward_center_1,x
	sta los_probe_y
	pla
	rts

animate_tiles:
	ldx #$00
@animate_next:
	lda object_tile_type,x
	beq @animend
	bpl @animate_non_monster
	cmp #tile_monster_land
	bcs @animate_4_frames
	cmp #tile_monster_water
	beq @animdone

@animate_2_frames:
	jsr fastrand
	cmp #$c0
	bcs @animdone
	lda object_tile_sprite,x
	eor #$01
	and #$01
	ora object_tile_type,x
	sta object_tile_sprite,x
	jmp @animdone

@animate_4_frames:
	jsr fastrand
	cmp #$c0
	bcs @animdone
	lda object_tile_sprite,x
	clc
	adc #$01
	and #$03
	ora object_tile_type,x
	sta object_tile_sprite,x
	jmp @animdone

@animate_non_monster:
	cmp #tile_npc_first
	bcc @animate_player
	cmp #tile_npc_last
	bcs @dontanim
@animate_npc:
	jmp @animate_2_frames

@animate_player:
	cmp #tile_class_first
	bcc @dontanim
	cmp #tile_class_last
	bcs @dontanim
	jmp @animate_2_frames

@dontanim:
	lda object_tile_type,x
	sta object_tile_sprite,x
	jmp @animdone

@animend:
	lda #$00
	sta object_tile_sprite,x
@animdone:
	inx
	cpx #object_last
	bcc @animate_next
	jsr scroll_tiles
	jsr animate_fields
	jmp animate_flags

primm_xy:
	stx console_xpos
	sty console_ypos
primm:
	pla
	sta @primmaddr
	pla
	sta @primmaddr + 1
@next:
	inc @primmaddr
	bne @skip
	inc @primmaddr + 1
@primmaddr=*+$01
@skip:
	lda TMP_ADDR
	beq @done
	jsr console_out
	jmp @next

@done:
	lda @primmaddr + 1
	pha
	lda @primmaddr
	pha
	rts

console_out:
	cmp #char_newline
	beq console_newline
	and #$7f
	ldx console_xpos
	cpx #$28
	bcc @noteol
	pha
	jsr console_newline
	pla
@noteol:
	jsr drawchar
	inc console_xpos
	rts

console_newline:
	lda #$18
	sta console_xpos
	inc console_ypos
	lda console_ypos
	cmp #$18
	bcc @notbottom
	dec console_ypos
	jsr console_scroll
@notbottom:
	rts

primm_cout:
	pla
	sta err_resume_addr
	sta ptr1
	pla
	sta err_resume_addr + 1
	sta ptr1 + 1
	tsx
	stx err_resume_stack
	ldy #$00
@next:
	inc ptr1
	bne @skip
	inc ptr1 + 1
@skip:
	lda (ptr1),y
	beq @done
	ora #$80
	jsr @cout
	jmp @next

@done:
	sta key_buf_len
	lda ptr1 + 1
	pha
	lda ptr1
	pha
	rts

@cout:
	jmp (zp_CSWL) ;character output hook

get_stats_ptr:
	lda curr_player
	sec
	sbc #$01
	jsr mul32
	sta ptr1
	lda #>player_stats
	sta ptr1 + 1
	rts

centername:
	jsr get_stats_ptr
	lda #$00
	sta zp_name_count
@count:
	ldy zp_name_count
	lda (ptr1),y
	beq @gotlen
	inc zp_name_count
	lda zp_name_count
	cmp #$0f
	bcc @count
@gotlen:
	lda #$0f
	sec
	sbc zp_name_count
	lsr
	clc
	adc console_xpos
	sta console_xpos
printname:
	jsr get_stats_ptr
	lda #$00
	sta zp_name_count
@print:
	ldy zp_name_count
	lda (ptr1),y
	beq @done
	jsr console_out
	inc zp_name_count
	lda zp_name_count
	cmp #$0f
	bcc @print
@done:
	rts

printname8:
	jsr get_stats_ptr
	lda #$00
	sta zp_name_count
@print:
	ldy zp_name_count
	lda (ptr1),y
	beq @done
	jsr console_out
	inc zp_name_count
	lda zp_name_count
	cmp #$08
	bcc @print
@done:
	rts

drawcursor_xy:
	stx console_xpos
	sty console_ypos
drawcursor:
	dec cursor_ctr
	lda cursor_ctr
	and #$7f
	ora #$7c
	bne dodrawcursor
clearcursor:
	lda #$20
dodrawcursor:
	jsr console_out
	dec console_xpos
	rts

cursor_ctr:
	.byte 0

printbcd:
	sta zp_number
	jsr div16
	jsr printdigit    ;SIZE_OPT: duplicate code was inline here
	lda zp_number
	and #$0f
printdigit:
	clc
	adc #$30
	jmp console_out

clearstatwindow:
	jsr drawhoriz
	.byte $18,$00,$04,$05,$04,$05,$04,$05
	.byte $04,$05,$04,$05,$04,$05,$04,$05
	.byte $04,$ff
	ldx #$08
@clearstatline:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	ldy #$18
	lda #$80
@clear:
	sta (ptr1),y
	iny
	cpy #$27
	bcc @clear
	inx
	cpx #$48
	bcc @clearstatline
	rts

update_status:
	lda #>font_data
	sta ptr1 + 1
	lda #<font_data
	sta ptr1
	ldx #$00
@next_virtue:
	lda party_stats,x
	beq @partial_avatar
	lda #$00
	beq @not_avatar
@partial_avatar:
	ldy #glyph_ankh
	lda (ptr1),y
@not_avatar:
	ldy #glyph_virtues
	sta (ptr1),y
	clc
	lda ptr1
	adc #$80
	sta ptr1
	bcc :+
	inc ptr1 + 1
:	inx
	cpx #$08
	bne @next_virtue
	jsr stats_save_pos
	lda curr_player
	pha
	lda party_size
	sta curr_player
@nextplayer:
	ldx curr_player
	jsr get_stats_ptr
	lda curr_player
	sta console_ypos
	lda #$18
	sta console_xpos
	lda curr_player
	jsr printdigit
	lda #$ad
	jsr console_out
	jsr printname8
	lda #$23
	sta console_xpos
	jsr get_stats_ptr
	ldy #$18
	lda (ptr1),y
	jsr printdigit
	ldy #$19
	lda (ptr1),y
	jsr printbcd
	ldy #$12
	lda (ptr1),y
	jsr console_out
	jsr scankey
	dec curr_player
	bne @nextplayer
@printfood:
	ldx #$18
	ldy #$0a
	jsr primm_xy
	.byte "F:", 0
	ldy #party_stat_food_hi
	lda party_stats,y
	jsr printbcd
	ldy #party_stat_food_lo
	lda party_stats,y
	jsr printbcd
	lda #char_space
	jsr console_out
	lda magic_aura
	jsr console_out
	lda player_transport
	cmp #tile_ship_last
	bcc @ship
	jsr primm
	.byte " G:", 0
	ldy #party_stat_gold_hi
	lda party_stats,y
	jsr printbcd
	ldy #party_stat_gold_lo
	lda party_stats,y
	jsr printbcd
	jmp @done

@ship:
	jsr primm
	.byte " SHP:", 0
	lda ship_hull
	jsr printbcd
@done:
	pla
	sta curr_player
	jmp stats_rest_pos

stats_saved_xpos:
	.byte 0
stats_saved_ypos:
	.byte 0

update_wind:
	jsr rand
	bne @nochange
	jsr rand
	jsr getsign
	clc
	adc wind_direction
	and #$03
	sta wind_direction
@nochange:
	jsr stats_save_pos
	lda #$17
	sta console_ypos
	lda #$06
	sta console_xpos
	jsr primm
	.byte glyph_greater_even,"WIND ", 0
	ldx wind_direction
	beq @west
	dex
	beq @north
	dex
	beq @east
	dex
	beq @south
	bne @done
@west:
	jsr printwest
	jmp @done

@north:
	jsr printnorth
	jmp @done

@east:
	jsr printeast
	jmp @done

@south:
	jsr printsouth
@done:
	lda #glyph_less_odd
	jsr console_out
	jmp stats_rest_pos

print_direction:
	jsr stats_save_pos
	lda #$17
	sta console_ypos
	lda #$07
	sta console_xpos
	jsr primm
	.byte "DIR: ", 0
	ldx dng_direction
	beq @north
	dex
	beq @east
	dex
	beq @south
	bne @west
@north:
	jsr printnorth
	jmp @printlevel

@east:
	jsr printeast
	jmp @printlevel

@south:
	jsr printsouth
	jmp @printlevel

@west:
	jsr printwest
@printlevel:
	lda #$00
	sta console_ypos
	lda #$0b
	sta console_xpos
	lda #char_L
	jsr console_out
	lda dungeon_level
	clc
	adc #$01
	jsr printdigit
	jmp stats_rest_pos

printnorth:
	jsr primm
	.byte "NORTH", 0
	rts

printsouth:
	jsr primm
	.byte "SOUTH", 0
	rts

printeast:
	jsr primm
	.byte " EAST", 0
	rts

printwest:
	jsr primm
	.byte " WEST", 0
	rts

getsign:
	cmp #$00
	beq @zero
	bmi @negative
	lda #$01
	rts
@negative:
	lda #$ff
@zero:
	rts

stats_save_pos:
	lda console_xpos
	sta stats_saved_xpos
	lda console_ypos
	sta stats_saved_ypos
	rts

stats_rest_pos:
	lda stats_saved_xpos
	sta console_xpos
	lda stats_saved_ypos
	sta console_ypos
	rts

getnumdel:
	dec console_xpos
getnumber:
	jsr waitkey
	sec
	sbc #char_num_first
	cmp #$0a     ;10
	bcs getnumber
	sta bcdnum
	sta hexnum
	jsr printdigit
@seconddigit:
	jsr waitkey
	cmp #char_enter
	beq @done
	cmp #char_left_arrow
	beq getnumdel
	sec
	sbc #char_num_first
	cmp #$0a     ;10
	bcs @seconddigit
	sta hexnum
	jsr printdigit
@notretordel:
	jsr waitkey
	cmp #char_enter
	beq @convhex
	cmp #char_left_arrow
	bne @notretordel
	dec console_xpos
	bpl @seconddigit
@convhex:
	lda bcdnum
	jsr mul16
	ora hexnum
	sta bcdnum
	ldx #$00
	sed
	sec
@count:
	sbc #$01
	bcc @counted
	inx
	bne @count
@counted:
	stx hexnum
	cld
@done:
	rts

getplayernum:
	jsr waitkey
;	beq @gotnum  ; SIZE_OPT, unnecessary
	sec
	sbc #char_num_first
	cmp #$09
	bcc @gotnum
	lda #$00
@gotnum:
	sta curr_player
	jsr printdigit
	jsr console_newline
	lda curr_player
	rts

; INPUT: A = tile type to check
; OUTPUT: N = bmi blocked, bpl not
; AFFECTS: X
blocked_tile:
	ldx #walkable_tiles_last
@next:
	dex
	bmi @done    ;SIZE_OPT, was @blocked
	cmp walkable_tiles,x
	bne @next
@done:
	rts
;SIZE_OPT: unnecessary, BMI already sets N flag
;@blocked:
;	lda #$ff
;	rts

walkable_tiles:
	.byte $03,$04,$05,$06,$07,$09,$0a,$0b
	.byte $0c,$10,$11,$12,$13,$14,$15,$16
	.byte $17,$18,$19,$1a,$1b,$1c,$1d,$1e
	.byte $3c,$3e,$3f,$43,$44,$46,$47,$49
	.byte $4a,$4c,$4c,$4c,$8c,$8d,$8e,$8f
walkable_tiles_last = * - walkable_tiles

clearbitmap:
	lda #>screen_HGR1
	sta ptr1 + 1
	ldy #<screen_HGR1
	sty ptr1
	lda #$80
@clear:
	sta (ptr1),y
	iny
	bne @clear
	inc ptr1 + 1
	ldx ptr1 + 1
	cpx #$40
	bcc @clear
	rts

clearview:
	ldx #$08
@nextline:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	ldy #$16
	lda #$00
@clear:
	sta (ptr1),y
	dey
	bne @clear
	inx
	cpx #$b8
	bcc @nextline
	rts

invertview:
	ldx #$08
@nextline:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	ldy #$16
@invert:
	lda (ptr1),y
	eor #$ff
	sta (ptr1),y
	dey
	bne @invert
	inx
	cpx #$b8
	bcc @nextline
	rts

mulax:
	sta zp_number
	lda #$00
	cpx #$00
	beq @zero
@add:
	clc
	adc zp_number
	dex
	bne @add
@zero:
	rts

; unused. To save more memory, could be called from
; both 'update_britannia' and 'gettile_britannia'.
;	lda tile_ypos
;	jsr mul16
;	sta ptr2
;	lda tile_xpos
;	and #$0f
;	ora ptr2
;	sta ptr2
;	lda tile_ypos
;	and #$10
;	asl
;	ora tile_xpos
;	jsr div16
;	clc
;	adc #>world_map_NW
;	sta ptr2 + 1
;	rts

scroll_tiles:
	lda #tile_water_deep
	jsr @save_and_scroll
	lda #tile_water_coast
	jsr @save_and_scroll
	lda #tile_water_shallow
	jsr @save_and_scroll
	lda #tile_lava
	jmp @save_and_scroll

@save_and_scroll:
	tay
	bit hw_LCBANK2
	jsr @scroll_half
	bit hw_LCBANK1
@scroll_half:
	lda tilemap + $f00,y
	pha
	lda tilemap + $e00,y
	sta tilemap + $f00,y
	lda tilemap + $d00,y
	sta tilemap + $e00,y
	lda tilemap + $c00,y
	sta tilemap + $d00,y
	lda tilemap + $b00,y
	sta tilemap + $c00,y
	lda tilemap + $a00,y
	sta tilemap + $b00,y
	lda tilemap + $900,y
	sta tilemap + $a00,y
	lda tilemap + $800,y
	sta tilemap + $900,y
	lda tilemap + $700,y
	sta tilemap + $800,y
	lda tilemap + $600,y
	sta tilemap + $700,y
	lda tilemap + $500,y
	sta tilemap + $600,y
	lda tilemap + $400,y
	sta tilemap + $500,y
	lda tilemap + $300,y
	sta tilemap + $400,y
	lda tilemap + $200,y
	sta tilemap + $300,y
	lda tilemap + $100,y
	sta tilemap + $200,y
	lda tilemap,y
	sta tilemap + $100,y
	pla
	sta tilemap,y
	rts

animate_fields:
	ldx #>tilemap
	lda #<tilemap
	sta ptr1
@next_line:
	stx ptr1 + 1
	jsr fastrand
	and #$55
	bit hw_LCBANK1
	ldy #tile_field_poison
	sta (ptr1),y
	ora #$80
	ldy #tile_field_fire
	sta (ptr1),y
	pha
	ldy #tile_altar
	and (ptr1),y
	ldy #tile_camp_fire
	eor (ptr1),y
	ora #$80
	sta (ptr1),y
	pla
	bit hw_LCBANK2
	ldy #tile_field_lightning
	sta (ptr1),y
	and #$7f
	ldy #tile_field_sleep
	sta (ptr1),y
	jsr fastrand
	and #$2a
	ldy #tile_field_poison
	sta (ptr1),y
	ora #$80
	ldy #tile_field_fire
	sta (ptr1),y
	pha
	ldy #tile_altar
	and (ptr1),y
	ldy #tile_camp_fire
	eor (ptr1),y
	ora #$80
	sta (ptr1),y
	pla
	bit hw_LCBANK1
	ldy #tile_field_lightning
	sta (ptr1),y
	and #$7f
	ldy #tile_field_sleep
	sta (ptr1),y
	inx
	cpx #$e0
	bcc @next_line
	rts

.macro SpriteSwapLines Line1, Line2, Tile
	ldx tilemap + ($100 * Line1) + Tile
	ldy tilemap + ($100 * Line2) + Tile
	sty tilemap + ($100 * Line1) + Tile
	stx tilemap + ($100 * Line2) + Tile
.endmacro

animate_flags:
	jsr fastrand
	bmi @castle
	bit hw_LCBANK1
	SpriteSwapLines 3, 4, tile_towne
@castle:
	jsr fastrand
	bmi @shipwest
	bit hw_LCBANK2
	SpriteSwapLines 1, 2, tile_castle
@shipwest:
	jsr fastrand
	bmi @shipeast
	bit hw_LCBANK1
	SpriteSwapLines 2, 3, tile_ship_east
	bit hw_LCBANK2
	SpriteSwapLines 2, 3, tile_ship_east
@shipeast:
	jsr fastrand
	bmi @lbcastle
	bit hw_LCBANK1
	SpriteSwapLines 2, 3, tile_ship_west
	bit hw_LCBANK2
	SpriteSwapLines 2, 3, tile_ship_west
@lbcastle:
	jsr fastrand
	bmi @flagsdone
	bit hw_LCBANK1
	SpriteSwapLines 1, 2, tile_castle_center
@flagsdone:
	rts

div32:
	lsr
div16:
	lsr
	lsr
	lsr
	lsr
	rts

mul32:
	asl
mul16:
	asl
	asl
	asl
	asl
	rts

scankey:
	lda hw_KEYBOARD
	bpl @done
	cmp #char_space
	bne @notspace
	ldy #$00     ;space clears unprocessed inputs from buffer
	sty key_buf_len
@notspace:
	cmp #char_DEL
	bne @notdel
	lda #char_left_arrow
@notdel:
	ldy key_buf_len
	cpy #$08
	bcs @done
	sta key_buf,y
	inc key_buf_len
	bit hw_STROBE
@done:
	rts

getkey:
	lda key_buf_len
	beq @empty
	lda key_buf
	pha
	dec key_buf_len
	beq @gotkey
	ldy #$00
@movebuf:
	lda key_buf+1,y
	sta key_buf,y
	iny
	cpy key_buf_len
	bcc @movebuf
@gotkey:
	pla
	cmp #$00
@empty:
	rts

rand:
	txa
	pha
	clc
	ldx #$0e
	lda rndf
@add:
	adc rnd0,x
	sta rnd0,x
	dex
	bpl @add
	ldx #$0f
@inc:
	inc rnd0,x
	bne @done
	dex
	bpl @inc
@done:
	pla
	tax
	lda rnd0
	rts

rnd0:
	.byte $64
rnd1:
	.byte $76
rnd2:
	.byte $85
rnd3:
	.byte $54,$f6,$5c,$76,$1f,$e7,$12,$a7
	.byte $6b,$93,$c4,$6e
rndf:
	.byte $1b

fastrand:
	lda rnd3
	adc rnd2
	sta rnd2
	eor rnd1
	sta rnd1
	adc rnd0
	sta rnd0
	sta rnd3
	rts

console_scroll:
	ldx #$60
doscroll:
	ldy #$18
	lda bmplineaddr_lo,x
	sta @scrolldst
	lda bmplineaddr_hi,x
	sta @scrolldst+1
	lda bmplineaddr_lo + 8,x
	sta @scrollsrc
	lda bmplineaddr_hi + 8,x
	sta @scrollsrc+1
@scrollsrc=*+$01
@scroll:
	lda TMP_ADDR,y
@scrolldst=*+$01
	sta TMP_ADDR,y
	iny
	cpy #$28
	bcc @scroll
	inx
	cpx #$b8
	bcc doscroll
	jsr drawhoriz
	.byte $18,$17,$20,$20,$20,$20,$20,$20
	.byte $20,$20,$20,$20,$20,$20,$20,$20
	.byte $20,$20,$ff
	rts

drawchar:
	sta char_glyph
	lda console_ypos
	asl
	asl
	asl
	sta char_bitmap_row
	lda #>font_data
	sta @charsrc+1
	lda #$08
	sta char_rows_left
	ldy console_xpos
@drawchar:
	ldx char_bitmap_row
	lda bmplineaddr_lo,x
	sta @chardst
	lda bmplineaddr_hi,x
	sta @chardst+1
	ldx char_glyph
@charsrc=*+$01
	lda TMP_PAGE,x
@chardst=*+$01
	sta TMP_ADDR,y
	clc
	lda @charsrc
	adc #$80
	sta @charsrc
	bcc :+
	inc @charsrc+1
:	inc char_bitmap_row
	dec char_rows_left
	bne @drawchar
	ldy #$00
	rts

drawvert:
	lda #$80
	sta draw_hvflag
	jmp dodrawvh

drawhoriz:
	lda #$00
	sta draw_hvflag
dodrawvh:
	lda console_xpos
	sta draw_savex
	lda console_ypos
	sta draw_savey
	pla
	sta ptr2
	pla
	sta ptr2 + 1
	jsr @next
	ldy #$00
	lda (ptr2),y
	sta console_xpos
	jsr @next
	lda (ptr2),y
	sta console_ypos
@draw:
	jsr @next
	lda (ptr2),y
	bmi @drawdone
	jsr drawchar
	bit draw_hvflag
	bmi @vert
	inc console_xpos
	jmp @draw

@vert:
	inc console_ypos
	jmp @draw

@drawdone:
	lda ptr2 + 1
	pha
	lda ptr2
	pha
	lda draw_savex
	sta console_xpos
	lda draw_savey
	sta console_ypos
	rts

@next:
	inc ptr2
	bne @gotnext
	inc ptr2 + 1
@gotnext:
	rts

draw_hvflag:
	.byte 0
draw_savex:
	.byte 0
draw_savey:
	.byte 0

drawinterface:
	jsr clearbitmap
	jsr drawhoriz
	.byte $00,$00,$10,$05,$04,$05,$04,$05
	.byte $04,$05,$04,$05,$1e,$20,$20,$1d
	.byte $04,$05,$04,$05,$04,$05,$04,$05
	.byte $04,$01,$04,$05,$04,$05,$04,$05
	.byte $04,$05,$04,$05,$04,$05,$04,$05
	.byte $04,$13,$ff
	jsr drawvert
	.byte $00,$01,$0a,$0a,$0a,$0a,$0a,$0a
	.byte $0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a
	.byte $0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a
	.byte $14,$ff
	jsr drawhoriz
	.byte $01,$17,$03,$02,$03,$02,$03,$02
	.byte $03,$02,$03,$02,$03,$02,$03,$02
	.byte $03,$02,$03,$02,$03,$02,$03,$02
	.byte $ff
	jsr drawvert
	.byte $17,$01,$0d,$0d,$0d,$0d,$0d,$0d
	.byte $0d,$0d,$09,$0d,$09,$0d,$0d,$0d
	.byte $0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d
	.byte $0b,$ff
	jsr drawvert
	.byte $27,$01,$09,$09,$09,$09,$09,$09
	.byte $09,$09,$01,$09,$05,$ff
	jsr drawhoriz
	.byte $18,$09,$06,$07,$06,$07,$06,$07
	.byte $06,$07,$06,$07,$06,$07,$06,$07
	.byte $06,$ff
	jsr drawhoriz
	.byte $18,$0b,$06,$07,$06,$07,$06,$07
	.byte $06,$07,$06,$07,$06,$07,$06,$07
	.byte $06,$ff
	rts

moon_gfx:
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$04,$02,$01,$01,$02,$04,$00
	.byte $00,$04,$06,$07,$07,$06,$04,$00
	.byte $00,$0c,$0e,$1f,$1f,$0e,$0c,$00
	.byte $00,$0c,$1e,$3f,$3f,$1e,$0c,$00
	.byte $00,$0c,$1c,$3e,$3e,$1c,$0c,$00
	.byte $00,$08,$18,$38,$38,$18,$08,$00
	.byte $00,$08,$10,$20,$20,$10,$08,$00
update_moons:
	clc
	lda moon_counter
	adc #$40
	sta moon_counter
	bne @noupdate
	inc moon_ctr_trammel
	inc moon_ctr_trammel
	lda moon_ctr_trammel
	and #$e0
	lsr
	lsr
	tay
	lda moon_gfx,y
	sta_trammel_line 0
	lda moon_gfx+1,y
	sta_trammel_line 1
	lda moon_gfx+2,y
	sta_trammel_line 2
	lda moon_gfx+3,y
	sta_trammel_line 3
	lda moon_gfx+4,y
	sta_trammel_line 4
	lda moon_gfx+5,y
	sta_trammel_line 5
	lda moon_gfx+6,y
	sta_trammel_line 6
	lda moon_gfx+7,y
	sta_trammel_line 7
	clc
	lda moon_ctr_felucca
	adc #$06
	sta moon_ctr_felucca
	and #$e0
	lsr
	lsr
	tay
	lda moon_gfx,y
	sta_felucca_line 0
	lda moon_gfx+1,y
	sta_felucca_line 1
	lda moon_gfx+2,y
	sta_felucca_line 2
	lda moon_gfx+3,y
	sta_felucca_line 3
	lda moon_gfx+4,y
	sta_felucca_line 4
	lda moon_gfx+5,y
	sta_felucca_line 5
	lda moon_gfx+6,y
	sta_felucca_line 6
	lda moon_gfx+7,y
	sta_felucca_line 7
@noupdate:
	lda moon_ctr_trammel
	jsr div32
	sta moon_phase_trammel
	lda moon_ctr_felucca
	jsr div32
	sta moon_phase_felucca
	lda moon_ctr_trammel
	and #$1f
	beq @moongate_appears
	cmp #$1e
	beq @moongate_disappears
	rts

@moongate_appears:
	jsr moongate_update
	lda moongate_sprite
	clc
	adc #tile_moongate
	sta moongate_tile
	rts

@moongate_disappears:
	jsr moongate_update
	lda moongate_sprite
	eor #$03
	clc
	adc #tile_moongate
	sta moongate_tile
	rts

moongate_update:
	lda moon_ctr_trammel
	and #$e0
	jsr div32
	tax
	lda moongate_xtab,x
	sta moongate_xpos
	lda moongate_ytab,x
	sta moongate_ypos
	lda moon_counter
	and #$c0
	rol
	rol
	rol
	sta moongate_sprite
	rts

moon_counter:
	.byte 0
moon_ctr_trammel:
	.byte 0
moon_ctr_felucca:
	.byte 0
moongate_xtab:
	.byte $e0,$60,$26,$32,$a6,$68,$17,$bb
moongate_ytab:
	.byte $85,$66,$e0,$25,$13,$c2,$7e,$a7

request_disk:
	sta reqdisk
@request:
	lda reqdisk
	cmp #$02
	beq @twodrives
	cmp #$04
	beq @twodrives
@onedrive:
	lda #$01
	sta currdrive
	lda reqdisk
	cmp currdisk_drive1
	beq @checkdisk
@askchange:
	jsr primm
	.byte $8d
	.byte "PLEASE PLACE THE", $8d
	.byte 0
	jsr askdisk
	jsr primm
	.byte " DISK", $8d
	.byte "INTO DRIVE ", 0
	lda currdrive
	jsr printdigit
	jsr primm
	.byte $8d
	.byte "AND PRESS [ESC]", $8d
	.byte 0
@wait:
	jsr waitkey
	cmp #char_ESC
	bne @wait
	beq @checkdisk
@twodrives:
	lda numdrives
	cmp #$02
	bcc @onedrive
	lda #$02
	sta currdrive
	lda reqdisk
	cmp currdisk_drive2
	beq @checkdisk
	bne @askchange
@checkdisk:
	lda currdrive
	clc
	adc #char_num_first
	sta @file_char_drive
	jsr primm_cout
	.byte $84, "BLOADDISK,D"
@file_char_drive:
	.byte "1", $8d
	.byte 0
	ldx currdrive
	lda disk_id
	sta numdrives,x
	cmp reqdisk
	beq @done
	jmp @request

@done:
	rts

askdisk:
	ldx reqdisk
	dex
	dex
	bne @towne
	jsr primm
	.byte "BRITANNIA", 0
	rts

@towne:
	dex
	bne @underworld
	jsr primm
	.byte "TOWNE", 0
	rts

@underworld:
	jsr primm
	.byte "UNDERWORLD", 0
	rts

playsfx:
	asl
	tay
	lda sfx_volume
	beq @done
	lda sfxtab+1,y
	pha
	lda sfxtab,y
	pha
@done:
	rts

sfxtab:
	.addr sfx_walk-1
	.addr sfx_error2-1
	.addr sfx_error1-1
	.addr sfx_ship_fire-1
	.addr sfx_attack-1
	.addr sfx_unknown-1
	.addr sfx_player_hits-1
	.addr sfx_monster_hits-1
	.addr sfx_flee-1
	.addr sfx_magic2-1
	.addr sfx_magic1-1
	.addr sfx_whirlpool-1
	.addr sfx_storm-1

sfx_walk:
	ldy #$06
@repeat:
	jsr rand
	and #$3f
	ora #$20
	tax
@delay:
	dex
	bne @delay
	bit hw_SPEAKER
	dey
	bne @repeat
	rts

sfx_error2:
	ldy #$32
@delay:
	pha
	pla
	dex
	bne @delay
	bit hw_SPEAKER
	dey
	bne @delay
	rts

sfx_error1:
	ldy #$32
@delay:
	nop
	nop
	dex
	bne @delay
	bit hw_SPEAKER
	dey
	bne @delay
	jmp sfx_error2

sfx_ship_fire:
	ldx #$00
	stx zp_sfx_freq
@delay:
	inx
	bne @delay
	bit hw_SPEAKER
	dec zp_sfx_freq
	ldx zp_sfx_freq
	bne @delay
	rts

sfx_attack:
	lda #$ff
	tax
	tay
@delay:
	dex
	bne @delay
	bit hw_SPEAKER
	dey
	tya
	tax
	bmi @delay
	rts

sfx_unknown:
	lda #$80
	tax
	tay
@delay:
	dex
	bne @delay
	bit hw_SPEAKER
	iny
	tya
	tax
	bmi @delay
	rts

sfx_player_hits:
	ldy #$ff
@repeat:
	jsr rand
	and #$7f
	tax
@delay:
	dex
	bne @delay
	bit hw_SPEAKER
	dey
	bne @repeat
	rts

sfx_monster_hits:
	ldy #$ff
@repeat:
	jsr rand
	ora #$80
	tax
@delay:
	dex
	bne @delay
	bit hw_SPEAKER
	dey
	bne @repeat
	rts

sfx_flee:
	ldx #$7f
	stx zp_sfx_freq
@delay:
	dex
	bne @delay
	bit hw_SPEAKER
	dec zp_sfx_freq
	ldx zp_sfx_freq
	bne @delay
	rts

sfx_magic1:
	stx zp_sfx_duration
@1:
	jsr rand
	ldx #$28
@2:
	tay
@3:
	dey
	bne @3
	bit hw_SPEAKER
	dex
	bne @2
	dec zp_sfx_duration
	bne @1
	rts

sfx_whirlpool:
	lda #$40
@1:
	ldy #$20
@2:
	tax
@3:
	pha
	pla
	dex
	bne @3
	bit hw_SPEAKER
	dey
	bne @2
	clc
	adc #$01
	cmp #$c0
	bcc @1
	rts

sfx_magic2:
	stx sfx_m2_ctr2
	lda #$01
	sta sfx_m2_ctr1
@1:
	lda #$30
	sta zp_sfx_duration
@2:
	ldx sfx_m2_ctr2
@3:
	dex
	bne @3
	bit hw_SPEAKER
	ldx sfx_m2_ctr1
@4:
	dex
	bne @4
	bit hw_SPEAKER
	dec zp_sfx_duration
	bne @2
	dec sfx_m2_ctr2
	inc sfx_m2_ctr1
	lda sfx_m2_ctr1
	cmp #$1b
	bne @1
@5:
	lda #$30
	sta zp_sfx_duration
@6:
	ldx sfx_m2_ctr2
@7:
	dex
	bne @7
	bit hw_SPEAKER
	ldx sfx_m2_ctr1
@8:
	dex
	bne @8
	bit hw_SPEAKER
	dec zp_sfx_duration
	bne @6
	dec sfx_m2_ctr1
	inc sfx_m2_ctr2
	lda sfx_m2_ctr1
	cmp #$00
	bne @5
	rts

sfx_m2_ctr1:
	.byte 0
sfx_m2_ctr2:
	.byte 0

sfx_storm:
	lda #$c0
@1:
	ldy #$20
@2:
	tax
@3:
	pha
	pla
	dex
	bne @3
	bit hw_SPEAKER
	dey
	bne @2
	sec
	sbc #$01
	cmp #$40
	bcs @1
	rts

centerstring:
	pha
	tay
	lda #<strings
	sta ptr1
	lda #>strings
	sta ptr1 + 1
	ldx #$00
	stx zp_count
@checkeos:
	lda (ptr1,x)
	bpl @endofstr
@next:
	jsr nextstrchar
	jmp @checkeos

@endofstr:
	dey
	beq @foundstr
	jmp @next

@foundstr:
	jsr nextstrchar
	ldx #$00
	lda (ptr1,x)
	bpl @lastchar
	inc zp_count
	jmp @foundstr

@lastchar:
	inc zp_count
	lda #$0f
	sec
	sbc zp_count
	lsr
	clc
	adc console_xpos
	sta console_xpos
	pla
printstring:
	tay
	lda #<strings
	sta ptr1
	lda #>strings
	sta ptr1 + 1
	ldx #$00
@checkeos:
	lda (ptr1,x)
	bpl @endofstr
@next:
	jsr nextstrchar
	jmp @checkeos

@endofstr:
	dey
	beq @foundstr
	jmp @next

@foundstr:
	jsr nextstrchar
	ldx #$00
	lda (ptr1,x)
	bpl @lastchar
	jsr console_out
	jmp @foundstr

@lastchar:
	ora #$80
	jmp console_out

nextstrchar:
	inc ptr1
	bne :+
	inc ptr1 + 1
:	rts

; String terminated by most significant bit in last character.
  .macro msbstring str
    .repeat (.strlen(str) - 1), I
	.byte .strat(str, I)
    .endrepeat
	.byte .strat(str, (.strlen(str) - 1)) ^ $80
  .endmacro


strings:
	.byte 0
	msbstring "PIRATE"
	msbstring "PIRATE"
	msbstring "NIXIE"
	msbstring "SQUID"
	msbstring "SERPENT"
	msbstring "SEAHORSE"
	msbstring "WHIRLPOOL"
	msbstring "TWISTER"
	msbstring "RAT"
	msbstring "BAT"
	msbstring "SPIDER"
	msbstring "GHOST"
	msbstring "SLIME"
	msbstring "TROLL"
	msbstring "GREMLIN"
	msbstring "MIMIC"
	msbstring "REAPER"
	msbstring "INSECTS"
	msbstring "GAZER"
	msbstring "PHANTOM"
	msbstring "ORC"
	msbstring "SKELETON"
	msbstring "ROGUE"
	msbstring "PYTHON"
	msbstring "ETTIN"
	msbstring "HEADLESS"
	msbstring "CYCLOPS"
	msbstring "WISP"
	msbstring "MAGE"
	msbstring "LICHE"
	msbstring "LAVA LIZARD"
	msbstring "ZORN"
	msbstring "DAEMON"
	msbstring "HYDRA"
	msbstring "DRAGON"
	msbstring "BALRON"
	msbstring "HANDS"
	msbstring "STAFF"
	msbstring "DAGGER"
	msbstring "SLING"
	msbstring "MACE"
	msbstring "AXE"
	msbstring "SWORD"
	msbstring "BOW"
	msbstring "CROSSBOW"
	msbstring "FLAMING OIL"
	msbstring "HALBERD"
	msbstring "MAGIC AXE"
	msbstring "MAGIC SWORD"
	msbstring "MAGIC BOW"
	msbstring "MAGIC WAND"
	msbstring "MYSTIC SWORD"
	msbstring "SKIN"
	msbstring "CLOTH"
	msbstring "LEATHER"
	msbstring "CHAIN MAIL"
	msbstring "PLATE MAIL"
	msbstring "MAGIC CHAIN"
	msbstring "MAGIC PLATE"
	msbstring "MYSTIC ROBE"
	msbstring "HND"
	msbstring "STF"
	msbstring "DAG"
	msbstring "SLN"
	msbstring "MAC"
	msbstring "AXE"
	msbstring "SWD"
	msbstring "BOW"
	msbstring "XBO"
	msbstring "OIL"
	msbstring "HAL"
	msbstring "+AX"
	msbstring "+SW"
	msbstring "+BO"
	msbstring "WND"
	msbstring "^SW"
	msbstring "MAGE"
	msbstring "BARD"
	msbstring "FIGHTER"
	msbstring "DRUID"
	msbstring "TINKER"
	msbstring "PALADIN"
	msbstring "RANGER"
	msbstring "SHEPHERD"
	msbstring "GUARD"
	msbstring "MERCHANT"
	msbstring "BARD"
	msbstring "JESTER"
	msbstring "BEGGAR"
	msbstring "CHILD"
	msbstring "BULL"
	msbstring "LORD BRITISH"
	msbstring "SULFUR ASH"
	msbstring "GINSENG"
	msbstring "GARLIC"
	msbstring "SPIDER SILK"
	msbstring "BLOOD MOSS"
	msbstring "BLACK PEARL"
	msbstring "NIGHTSHADE"
	msbstring "MANDRAKE"
	msbstring "AWAKEN"
	msbstring "BLINK"
	msbstring "CURE"
	msbstring "DISPEL"
	msbstring "ENERGY"
	msbstring "FIREBALL"
	msbstring "GATE"
	msbstring "HEAL"
	msbstring "ICEBALL"
	msbstring "JINX"
	msbstring "KILL"
	msbstring "LIGHT"
	msbstring "MAGIC MISL"
	msbstring "NEGATE"
	msbstring "OPEN"
	msbstring "PROTECTION"
	msbstring "QUICKNESS"
	msbstring "RESURRECT"
	msbstring "SLEEP"
	msbstring "TREMOR"
	msbstring "UNDEAD"
	msbstring "VIEW"
	msbstring "WINDS"
	msbstring "X-IT"
	msbstring "Y-UP"
	msbstring "Z-DOWN"
	msbstring "BRITANNIA"
	msbstring "THE LYCAEUM"
	msbstring "EMPATH ABBEY"
	msbstring "SERPENT'S HOLD"
	msbstring "MOONGLOW"
	msbstring "BRITAIN"
	msbstring "JHELOM"
	msbstring "YEW"
	msbstring "MINOC"
	msbstring "TRINSIC"
	msbstring "SKARA BRAE"
	msbstring "MAGINCIA"
	msbstring "PAWS"
	msbstring "BUCCANEER'S DEN"
	msbstring "VESPER"
	msbstring "COVE"
	msbstring "DECEIT"
	msbstring "DESPISE"
	msbstring "DESTARD"
	msbstring "WRONG"
	msbstring "COVETOUS"
	msbstring "SHAME"
	msbstring "HYTHLOTH"
	.byte "THE GREAT", $8D
	msbstring "STYGIAN ABYSS!"
	msbstring "HONESTY"
	msbstring "COMPASSION"
	msbstring "VALOR"
	msbstring "JUSTICE"
	msbstring "SACRIFICE"
	msbstring "HONOR"
	msbstring "SPIRITUALITY"
	msbstring "HUMILITY"
	; BUGFIX: added for special NPCs so they're not "phantoms"
	msbstring "WATER"
	msbstring "HORSE"
	msbstring "ANKH"
	msbstring "CAMPFIRE"

gettile_bounds:
	lda map_x
	jsr mul16
	eor #$ff
	sec
	adc temp_x
	sta dest_x
	cmp #xy_last_tile_cache
	bcs @out_of_bounds
	lda map_y
	jsr mul16
	eor #$ff
	sec
	adc temp_y
	sta dest_y
	cmp #xy_last_tile_cache
	bcs @out_of_bounds
	jmp gettile_britannia

@out_of_bounds:
	lda #$ff
	rts

gettile_britannia:
	lda dest_y
	jsr mul16
	sta ptr2
	lda dest_x
	and #$0f
	ora ptr2
	sta ptr2
	lda dest_y
	and #$10
	asl
	ora dest_x
	jsr div16
	clc
	adc #>world_map_NW
	sta ptr2 + 1
	ldy #<world_map_NW
	lda (ptr2),y
	rts

mul_11:
	.byte $00,$0b,$16,$21,$2c,$37,$42,$4d
	.byte $58,$63,$6e

gettile_opposite:
	sec
	lda temp_y
	sbc player_ypos
	clc
	adc #xy_center_screen
	tay
	lda mul_11,y
	sta zp_number
	sec
	lda temp_x
	sbc player_xpos
	clc
	adc #xy_center_screen
	clc
	adc zp_number
	sta ptr1
	lda #$02
	sta ptr1 + 1
	ldy #$00
	lda (ptr1),y
	rts

gettile_drawn_map:
	ldy dest_y
	lda mul_11,y
	clc
	adc dest_x
	tay
	lda drawn_tiles,y
	rts

gettile_actual_map:
	jsr gettile_drawn_map
	lda world_tiles,y
	rts

get_player_tile:
	lda game_mode
	cmp #mode_world
	beq @world
	cmp #mode_towne
	beq @towne
	lda #$ff
	rts

@world:
	lda player_xpos
	sta dest_x
	lda player_ypos
	sta dest_y
	jmp gettile_britannia

@towne:
	lda player_xpos
	sta temp_x
	lda player_ypos
	sta temp_y
	jmp gettile_towne

gettile_towne:
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
	adc #>towne_map
	sta ptr2 + 1
	ldy #<towne_map
	lda (ptr2),y
	rts

gettile_dungeon:
	lda dungeon_level
	lsr
	lsr
	clc
	adc #>dng_map
	sta ptr1 + 1
	lda dungeon_level
	and #$03
	asl
	asl
	asl
	ora dest_y
	asl
	asl
	asl
	ora dest_x
	sta ptr1
	ldy #$00
	lda (ptr1),y
	rts

; Junk from segment padding
;	.byte $30,$41,$30,$41,$30,$41,$30,$41
;	.byte $30,$41,$30,$41
