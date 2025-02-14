	.include "uscii.i"
;	.include "u4loader.i"

	.include "jump_subs.i"
	.include "map_objects.i"
	.include "tiles.i"
	.include "trainers.i"
	.include "zp_main.i"

	.include "PRTY.i"


	.import done_what
	.import done_only_on_foot
	.import done_not_here
	.import cmd_done
	.import combat_end_turn
	.import is_awake
	.import input_char
	.import location_map_x
	.import location_map_y

	.export j_trainer_teleport
	.export j_trainer_board
	.export j_active_char_combat_start
	.export j_active_char_player_turn
	.export j_active_char_check
	.export j_active_char_check_command
;	.export j_fixed_getkey
;	.export j_dirkey_trans_tab


; --- Custom use of Zero Page

zp_teleport_index = $d8


	.segment "TRAINERS"

j_trainer_teleport:
	jmp trainer_teleport

j_trainer_board:
	jmp trainer_board

j_active_char_combat_start:
	jmp active_char_combat_start

j_active_char_player_turn:
	jmp active_char_player_turn

j_active_char_check:
	jmp active_char_check

j_active_char_check_command:
	jmp active_char_check_command

;j_fixed_getkey:
;	jmp fixed_getkey

;j_dirkey_trans_tab:
;	jmp dirkey_trans_tab


	;.segment "TELEPORT1"

trainer_teleport:
	lda trainer_travel
	beq @abort
	lda game_mode			; check if we're in britannia
	cmp #mode_world
	beq :+
@abort:
	rts				; nope, continue talk command
:
	pla				; pull return address
	pla

	lda player_transport
	cmp #tile_ship_last
	bcs :+
	jmp done_only_on_foot
:
	jsr j_primm
	.byte "Teleport-", 0

	jsr input_char
	cmp #'T'
	beq @towne
	cmp #'D'
	beq @dungeon
	cmp #'S'
	beq @shrine
	cmp #'C'
	beq @coordinate

@done:
	jmp cmd_done

@towne:
	jsr j_primm
	.byte "Towne-", 0
	lda #$00
	jmp teleport_to_location

@dungeon:
	jsr j_primm
	.byte "Dungeon-", 0
	lda #$01
	jmp teleport_to_location

@shrine:
	jsr j_primm
	.byte "Shrine-", 0
	lda #$02
	jmp teleport_to_location

@coordinate:
	jsr j_primm
	.byte "Coord:",0
	jsr @pair
	lda temp_x
	sta temp_y
	jsr @pair
	lda temp_x
	ldy temp_y
	jmp teleport

@pair:
	lda #$20
	jsr j_console_out

	jsr getcoord
	asl
	asl
	asl
	asl
	sta temp_x

	lda #$27
	jsr j_console_out

	jsr getcoord
	ora temp_x
	sta temp_x

	lda #$22
	jmp j_console_out
	; rts implicit

	;.segment "TELEPORT2"

teleport_loc_offset:
	.byte $00,$10,$18
teleport_loc_mask:
	.byte $0f,$07,$07

teleport_to_location:
	sta zp_teleport_index
	jsr getcoord
	ldx zp_teleport_index
	clc
	and teleport_loc_mask,x
	adc teleport_loc_offset,x
	tax

	lda location_map_y,x
	tay
	lda location_map_x,x
	; continue

teleport:
	sta player_xpos
	sty player_ypos
	ldx #7
	lda #$00
:	sta object_tile_type,x
	dex
	bpl :-
	jsr j_player_teleport
	jmp cmd_done


getcoord:
	jsr j_waitkey
;	beq abort
	pha
	jsr j_console_out
	pla
	sec
	sbc #'A'
	cmp #$10
	bcs abort
	rts
abort:
	pla
	pla
	jmp cmd_done


	;.segment "KEYBOARDFIX"

;fixed_getkey:
;	sei
;	ldy $c6
;	beq checkjoy
;	ldy $0277
;	ldx #0
;:	lda $0278,x
;	sta $0277,x
;	inx
;	cpx $c6
;	bne :-
;	dec $c6
;checktrans:
;	tya
;	ldy #3
;:	cmp dirkey_trans_tab,y
;	beq @trans
;	dey
;	bpl :-
;	bmi :+
;@trans:
;	lda @dirkeys,y
;:	cli
;	rts
;
;@dirkeys:
;	.byte $40, $2f, $3a, $3b
;dirkey_trans_tab:
;	.byte $40, $2f, $3a, $3b
;
;checkjoy:
;	lda $a2
;	sec
;	sbc @lastscan
;	cmp #5
;	bcc checktrans
;
;	lda $a2
;	sta @lastscan
;
;	lda $dc00
;
;	lsr
;	bcc @up
;	lsr
;	bcc @down
;	lsr
;	bcc @left
;	lsr
;	bcc @right
;	lsr
;	bcs checktrans
;@fire:
;	lda game_mode
;	bmi @combat
;	cmp #1
;	beq @britannia
;	cmp #2
;	beq @towne
;	cmp #3
;	beq @dungeon
;
;	ldy #$00
;	.byte $2c
;@britannia:
;	ldy #$45
;	.byte $2c
;@towne:
;	ldy #$54
;	.byte $2c
;@dungeon:
;	ldy #$00
;	.byte $2c
;@combat:
;	ldy #$41
;	.byte $2c
;@up:
;	ldy #$40
;	.byte $2c
;@down:
;	ldy #$2f
;	.byte $2c
;@left:
;	ldy #$3a
;	.byte $2c
;@right:
;	ldy #$3b
;	jmp checktrans
;
;@lastscan:
;	.byte 0


	;.segment "TRAINERBOARD"

trainer_board:
	lda current_location
	beq @ask
	jmp done_not_here
@ask:
	jsr j_primm
	.byte "what? ", 0
	jsr input_char
	beq @done

	ldx #tile_walk
@horse:
	cmp #'H'
	bne @ship
	ldx #tile_horse_west
@ship:
	cmp #'S'
	bne @balloon
	jmp @trainer_ship
@ship_ok:
	ldx #tile_ship_first
@balloon:
	cmp #'B'
	bne @none
	lda #occlusion_off
	sta terrain_occlusion
;	lda #balloon_drift    ;same value
	clc
	adc trainer_balloon   ;balloon_steer
:	sta balloon_movement
	ldx #tile_balloon
@none:
	stx player_transport
@done:
	jmp cmd_done


	;.segment "TRAINERSHIP"

@trainer_ship:
	ldx #3
:	lda tile_north,x
	cmp #tile_water_shallow
	bcc @ship_ok
	dex
	bpl :-
	jmp done_not_here


	;.segment "ACTIVECHAR"

active_char_combat_start:
	lda #0
	sta combat_active_char
	rts


active_char_player_turn:
	lda combat_active_char
	bne @selected
@return_no_active:
	lda #0
	sta combat_active_char
	lda #1
	sta curr_player
	rts
@selected:
	sta curr_player
	jsr active_char_check_awake
	bne @return_no_active
	lda curr_player
	rts


active_char_check:
	lda combat_active_char
	beq @play_turn

	cmp curr_player
	beq @play_turn

	jsr active_char_check_awake
	beq @skip_char
	lda #0
	sta combat_active_char
	beq @play_turn
@skip_char:
	pla
	pla
	jmp combat_end_turn
@play_turn:
	jmp j_update_view


active_char_check_command:
	cmp #'0'
	bcc @unknown
	cmp #'9'
	bcs @unknown

	and #$0f
	beq @deselect

	cmp party_size
	bcc :+
	bne @deselect
:
	pha
	jsr is_awake
	bne @not_awake
	pla
	sta combat_active_char
	ora #'0'
	jsr j_console_out
	jsr j_primm
	.byte " active", $8d, 0
	pha
@not_awake:
	pla
	jmp cmd_done

@deselect:
	lda #0
	sta combat_active_char
	jsr j_primm
	.byte "Party mode", $8d, 0
	jmp cmd_done

@unknown:
	jmp done_what


active_char_check_awake:
	ldx curr_player
	stx @restoreplayer
	sta curr_player
	jsr is_awake
	sta @result
	ldx curr_player
	lda combat_player_tile - 1,x
	beq @exited
	cmp #tile_human_prone
	beq @asleep
@done:
@restoreplayer = * + 1
	ldx #$00
	stx curr_player
@result = * + 1
	lda #$00
	rts
@exited:
@asleep:
	lda #$ff
	sta @result
	bne @done

combat_active_char:
	.byte 0
