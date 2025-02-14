	.include "uscii.i"

	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "map_objects.i"
	.include "tiles.i"
	.include "zp_combat.i"
	.include "zp_main.i"
	
	.include "PRTY.i"
	.include "ROST.i"

; --- Custom use of Zero Page

zp_number = $da
zp_count = $ea
zp_mp_number = $d8
zp_mp_class = $d8


	.segment "OVERLAY"

.assert * = j_overlay_entry, error, "Wrong start address"
	jsr j_primm_cout
	.byte $84,"BLOAD CAMP,A$240", $8d
	.byte 0
	lda #$00
	tax
@clear:
	sta combat_foe_cur_x,x
	dex
	bne @clear
	lda party_size
	sta curr_player
@place_next:
	jsr is_alive
	bmi @skip
	lda #tile_human_prone
	ldx curr_player
	dex
	sta combat_player_tile,x
	lda map_start_player_x,x
	sta combat_player_xpos,x
	lda map_start_player_y,x
	sta combat_player_ypos,x
@skip:
	dec curr_player
	bne @place_next
	jsr j_primm
	.byte "RESTING...", $8d
	.byte 0
	lda #$4b
	sta zp_count
@sleep:
	jsr j_update_view_combat
	dec zp_count
	bne @sleep
	jsr j_rand
	and #$07
	bne check_sleep_effect

	jsr j_primm
	.byte "AMBUSHED!", $8d
	.byte 0
	jsr j_rand
	and #$07
	tay
	lda ambush_monsters,y
	sta foe_type_encountered
	sta foe_type_combat
	lda player_xpos
	sta pre_combat_x
	lda player_ypos
	sta pre_combat_y
	lda party_size
	sta curr_player
@next_player:
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Good
	bne :+
	lda #status_Sleep
	sta (ptr1),y
:	dec curr_player
	bne @next_player
	jsr j_primm_cout
	.byte $84,"BLOAD CAMP,A$240", $8d
	.byte 0
	pla
	pla
	jmp j_initialize_arena

check_sleep_effect:
	lda move_counter + 2
	cmp last_sleep
	bne @rested
	jsr j_primm
	.byte "NO EFFECT.", $8d
	.byte 0
	jmp @camp_done

@rested:
	sta last_sleep
	lda party_size
	sta curr_player
@next_player:
	jsr is_alive
	bmi @skip
	ldy #player_status
	lda (ptr1),y
	cmp #status_Sleep
	bne @not_sleeping
	lda #status_Good
	sta (ptr1),y
@not_sleeping:
	jsr j_rand
	and #$77
	jsr increase_hp
	lda #$99
	jsr increase_hp
@skip:
	dec curr_player
	bne @next_player
	jsr restore_mp
	jsr j_primm
	.byte "PLAYERS HEALED!", $8d
	.byte 0
@camp_done:
	rts

ambush_monsters:
	.byte tile_orc
	.byte tile_skeleton
	.byte tile_rogue
	.byte tile_python
	.byte tile_insects
	.byte tile_slime
	.byte tile_troll
	.byte tile_wisp

is_alive:
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Good
	beq @alive
	cmp #status_Poison
	beq @alive
	cmp #status_Sleep
	beq @alive
	lda #$ff
	rts

@alive:
	lda #$00
	rts

increase_hp:
	sta zp_number
	jsr j_get_stats_ptr
	ldy #player_cur_hp_lo
	sed
	clc
	lda (ptr1),y
	adc zp_number
	sta (ptr1),y
	dey
	lda (ptr1),y
	adc #$00
	sta (ptr1),y
	cld
	ldy #player_cur_hp_hi
	lda (ptr1),y
	ldy #player_max_hp_hi
	cmp (ptr1),y
	bcc @done
	ldy #player_cur_hp_lo
	lda (ptr1),y
	ldy #player_max_hp_lo
	cmp (ptr1),y
	bcc @done
	ldy #player_max_hp_hi
	lda (ptr1),y
	ldy #player_cur_hp_hi
	sta (ptr1),y
	ldy #player_max_hp_lo
	lda (ptr1),y
	ldy #player_cur_hp_lo
	sta (ptr1),y
@done:
	rts

restore_mp:
	lda party_size
	sta curr_player
@next_player:
	jsr is_alive
	bmi @skip
	ldy #player_class_index
	lda (ptr1),y
	sta zp_mp_class
	ldy #player_intelligence
	lda (ptr1),y
	jsr decode_bcd_value
	asl          ;INT * 2
	ldx zp_mp_class ;mage
	beq @set_mp
	dex          ;bard
	beq @2_of_4
	dex          ;fighter
	beq @0_of_4
	dex          ;druid
	beq @3_of_4
	dex          ;tinker
	beq @1_of_4
	dex          ;paladin
	beq @2_of_4
	dex          ;ranger
	beq @2_of_4
@0_of_4:
	lda #$00     ;shepherd
	jmp @set_mp

@1_of_4:
	lsr
	lsr
	jmp @set_mp

@2_of_4:
	lsr
	jmp @set_mp

@3_of_4:
	lsr
	sta zp_mp_number
	lsr
	adc zp_mp_number
@set_mp:
	jsr encode_bcd_value
	ldy #player_magic_points
	sta (ptr1),y
@skip:
	dec curr_player
	bpl @next_player
	rts

encode_bcd_value:
	cmp #$00
	beq @done
	cmp #$63     ;99
	bcs @max
	sed
	tax
	lda #$00
@dec:
	clc
	adc #$01
	dex
	bne @dec
	beq @done
@max:
	lda #$99
@done:
	cld
	rts

decode_bcd_value:
	cmp #$00
	beq @done
	ldx #$00
	sed
@inc:
	inx
	sec
	sbc #$01
	bne @inc
	txa
	cld
@done:
	rts

