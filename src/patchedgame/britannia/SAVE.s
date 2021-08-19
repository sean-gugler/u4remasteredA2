	.include "uscii.i"

	.include "char.i"
	.include "disks.i"
	.include "jump_subs.i"
	.include "map_objects.i"
	.include "places.i"
	.include "tiles.i"
	.include "view_map.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


	.segment "OVERLAY"

j_overlay_entry:
	lda party_size
	sta curr_player
	jsr j_get_stats_ptr
	ldy #player_status
	lda #status_Dead
	sta (ptr1),y
	ldy #player_cur_hp_hi
	lda #$00
	sta (ptr1),y
	iny
	sta (ptr1),y
	jsr j_update_status
	jsr j_clearview
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "ALL IS DARK...", $8d
	.byte 0
	jsr delay_long
	jsr j_primm
	.byte $8d
	.byte "But wait...", $8d
	.byte 0
	jsr delay_long
	jsr j_primm
	.byte "Where am I?...", $8d
	.byte 0
	jsr delay_long
	jsr j_primm
	.byte "Am I dead?...", $8d
	.byte 0
	jsr delay_long
	jsr j_primm
	.byte "Afterlife?...", $8d
	.byte 0
	jsr delay_long
	jsr j_primm
	.byte "YOU HEAR:", $8d
	.byte 0
	lda #$01
	sta curr_player
	jsr j_centername
	lda #char_newline
	jsr j_console_out
	jsr delay_long
	jsr j_primm
	.byte "I feel motion...", $8d
	.byte 0

; Teleport to the chamber of Lord British
	lda #tile_walk
	sta player_transport
	lda #xpos_lord_british
	sta player_xpos
	lda #ypos_lord_british
	sta player_ypos
	lda #xpos_castle_britannia
	sta britannia_x
	lda #ypos_castle_britannia
	sta britannia_y
	lda #loc_castle_britannia
	sta current_location
	lda #mode_suspended
	sta game_mode
	sta horse_mode
	lda #disk_towne
	jsr j_request_disk
	jsr j_primm_cout
	.byte $84,"BLOAD MAP@,A$8B00", $8d
	.byte 0
	ldx #$00
@next_map_cell:
	lda load_buf + $000,x
	sta view_buf + $000,x
	lda load_buf + $100,x
	sta view_buf + $100,x
	lda load_buf + $200,x
	sta view_buf + $200,x
	lda load_buf + $300,x
	sta view_buf + $300,x
	lda load_buf + $400,x
	sta object_tile_sprite,x
	inx
	bne @next_map_cell

	lda #mode_towne
	sta game_mode
	jsr j_update_view
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "LORD BRITISH", $8d
	.byte "SAYS: I HAVE", $8d
	.byte "PULLED THY", $8d
	.byte "SPIRIT AND SOME", $8d
	.byte "POSSESSIONS FROM", $8d
	.byte "THE VOID. BE", $8d
	.byte "MORE CAREFUL IN", $8d
	.byte "THE FUTURE!", $8d
	.byte 0

	lda party_size
	sta curr_player
@next_player:
	jsr j_get_stats_ptr
	ldy #player_status
	lda #status_Good
	sta (ptr1),y
	ldy #player_max_hp_hi
	lda (ptr1),y
	ldy #player_cur_hp_hi
	sta (ptr1),y
	ldy #player_max_hp_lo
	lda (ptr1),y
	ldy #player_cur_hp_lo
	sta (ptr1),y
	dec curr_player
	bne @next_player

	lda #$00
	ldx #weapon_last - 1
@next_weapon:
	sta weapons,x
	dex
	bne @next_weapon

	ldx #armour_last - 1
@next_armour:
	sta armour,x
	dex
	bne @next_armour

	sta food_lo
	sta gold_lo
	lda #$02
	sta food_hi
	sta gold_hi
	rts

delay_long:
	ldx #$0a
@1:
	ldy #$ff
@2:
	lda #$ff
@3:
	sec
	sbc #$01
	bne @3
	dey
	bne @2
	dex
	bne @1
	rts

; junk  "\nTHE QUES"
;	.byte $8d,$54,$48,$45,$20,$51,$55,$45
;	.byte $53
