	.include "uscii.i"

	.include "dungeon.i"
	.include "jump_subs.i"
	.include "sound.i"
	.include "tables.i"
	.include "zp_main.i"
	
	.include "PRTY.i"
	.include "ROST.i"


; --- Custom use of Zero Page

zp_save_reg = $d9
zp_amount = $da
zp_count = $f0


	.segment "OVERLAY"

j_overlay_entry:
	lda current_location
	sec
	sbc #loc_dng_first
	sta dungeon_number
	lda tile_under_player
	bne check_tile_type
print_find_nothing:
	jsr j_primm
	.byte $8d
	.byte "YOU FIND", $8d
	.byte "NOTHING!", $8d
	.byte 0
	rts

check_tile_type:
	and #dng_tile_type_mask
	cmp #dng_tile_orb
	beq find_orb
	cmp #dng_tile_fountain
	bne :+
	jmp find_fountain

:	cmp #dng_tile_altar
	bne print_find_nothing
	jmp find_altar

find_orb:
	jsr j_primm
	.byte $8d
	.byte "YOU FIND A", $8d
	.byte "MAGICAL BALL...", $8d
	.byte "WHO WILL TOUCH", $8d
	.byte "IT? ", 0
	jsr j_getplayernum
	jsr is_awake
	beq @use_orb
	jmp print_find_nothing

@use_orb:
	lda player_xpos
	sta dest_x
	lda player_ypos
	sta dest_y
	jsr j_gettile_dungeon
	lda #$00
	sta (ptr1),y
	ldy dungeon_number
	lda orb_damage,y
	jsr damage_player
	ldy dungeon_number
	lda orb_strength,y
	beq @check_dex
	ldy #player_strength
	jsr increment_stat
	jsr j_primm
	.byte "STRENGTH+5", $8d
	.byte 0
@check_dex:
	ldy dungeon_number
	lda orb_dexterity,y
	beq @check_int
	ldy #player_dexterity
	jsr increment_stat
	jsr j_primm
	.byte "DEXTERITY+5", $8d
	.byte 0
@check_int:
	ldy dungeon_number
	lda orb_intelligence,y
	beq @done
	ldy #player_intelligence
	jsr increment_stat
	jsr j_primm
	.byte "INTELLIGENCE+5", $8d
	.byte 0
@done:
	rts

find_fountain:
	jsr j_primm
	.byte $8d
	.byte "YOU FIND A", $8d
	.byte "FOUNTAIN, WHO", $8d
	.byte "WILL DRINK? ", 0
	jsr j_getplayernum
	jsr is_awake
	beq @drink
	jmp print_find_nothing

@drink:
	lda tile_under_player
	and #dng_tile_fountain_mask
	beq @water
	cmp #fountain_heal
	beq @heal
	cmp #fountain_harm
	beq @harm
	cmp #fountain_cure
	beq @cure
	cmp #fountain_poison
	beq @poison
@water:
	jsr j_primm
	.byte $8d
	.byte "HMMM--NO EFFECT!", $8d
	.byte 0
	rts

@heal:
	jsr j_primm
	.byte $8d
	.byte "AHH--REFRESHING!", $8d
	.byte 0
	jsr j_get_stats_ptr
	ldy #player_max_hp_hi
	lda (ptr1),y
	ldy #player_cur_hp_hi
	sta (ptr1),y
	lda #$00
	iny
	sta (ptr1),y
	rts

@harm:
	jsr j_primm
	.byte $8d
	.byte "BLECK--NASTY!", $8d
	.byte 0
	lda #$01
	jsr damage_player
	rts

@cure:
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Poison
	beq @do_cure
	jmp @water

@do_cure:
	lda #status_Good
	sta (ptr1),y
	jsr j_primm
	.byte $8d
	.byte "MMM--DELICIOUS!", $8d
	.byte 0
	rts

@poison:
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Poison
	bne @do_poison
	jmp @water

@do_poison:
	lda #status_Poison
	sta (ptr1),y
	jsr j_primm
	.byte $8d
	.byte "ARGH-CHOKE-GASP!", $8d
	.byte 0
	lda #$01
	jsr damage_player
	rts

find_altar:
	lda dungeon_number
	cmp #dng_abyss
	beq @find_nothing
	cmp #dng_hythloth
	bne @check_stone
@find_nothing:
	jmp print_find_nothing

@check_stone:
	ldy dungeon_number
	lda bit_msb,y
	and stones
	bne @find_nothing
	jsr j_primm
	.byte $8d
	.byte "YOU FIND THE", $8d
	.byte 0
	jsr print_color
	jsr j_primm
	.byte " STONE!", $8d
	.byte 0
	ldy dungeon_number
	lda bit_msb,y
	ora stones
	sta stones
	sed
	clc
	lda party_stats + virtue_honor
	beq @set_virtue
	adc #$05
	bcc @set_virtue
	lda #$99
@set_virtue:
	sta party_stats + virtue_honor
	cld
	lda #$01
	sta curr_player
	jsr j_get_stats_ptr
	ldy #player_experience_hi
	lda (ptr1),y
	sed
	clc
	adc #$02
	bcc @set_xp
	lda #$99
	iny
	sta (ptr1),y
	dey
@set_xp:
	sta (ptr1),y
	cld
	rts

print_color:
	lda dungeon_number
	beq @blue
	cmp #$01
	beq @yellow
	cmp #$02
	beq @red
	cmp #$03
	beq @green
	cmp #$04
	beq @orange
	jmp @purple

@blue:
	jsr j_primm
	.byte "BLUE", 0
	rts

@yellow:
	jsr j_primm
	.byte "YELLOW", 0
	rts

@red:
	jsr j_primm
	.byte "RED", 0
	rts

@green:
	jsr j_primm
	.byte "GREEN", 0
	rts

@orange:
	jsr j_primm
	.byte "ORANGE", 0
	rts

@purple:
	jsr j_primm
	.byte "PURPLE", 0
	rts

damage_player:
	sta zp_amount
	jsr invert_player
	lda #sound_firewalk
	jsr j_playsfx
	lda #sound_firewalk
	jsr j_playsfx
	lda #sound_firewalk
	jsr j_playsfx
	jsr invert_player
	jsr j_get_stats_ptr
	sed
	sec
	ldy #player_cur_hp_hi
	lda (ptr1),y
	sbc zp_amount
	cld
	bcs @survived
	lda #$00
	sta (ptr1),y
	iny
	sta (ptr1),y
	ldy #player_status
	lda #status_Dead
	sta (ptr1),y
	rts

@survived:
	sta (ptr1),y
	rts

is_awake:
	lda curr_player
	beq @no
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Good
	beq @yes
	cmp #status_Poison
	beq @yes
@no:
	lda #$ff
	rts

@yes:
	lda #$00
	rts

invert_player:
	lda curr_player
	asl
	asl
	asl
	tax
	lda #$08
	sta zp_count
@next_row:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	ldy #$26     ;column START
@next_col:
	lda (ptr1),y
	eor #$7f     ;preserve high-bit color palette
	sta (ptr1),y
	dey
	cpy #$18     ;column END
	bcs @next_col
	inx
	dec zp_count
	bne @next_row
	rts

increment_stat:
	sta zp_amount
	sty zp_save_reg
	jsr j_get_stats_ptr
	sed
	clc
	ldy zp_save_reg
	lda (ptr1),y
	adc zp_amount
	cld
	cmp #stat_max + 1
	bcc @set_stat
	lda #stat_max
@set_stat:
	sta (ptr1),y
	rts

bit_msb:
	.byte $80,$40,$20,$10,$08,$04,$02,$01
orb_strength:
	.byte $00,$00,$05,$00,$05,$05,$05,$00
orb_dexterity:
	.byte $00,$05,$00,$05,$05,$00,$05,$00
orb_intelligence:
	.byte $05,$00,$00,$05,$00,$05,$05,$00
orb_damage:
	.byte $02,$02,$02,$04,$04,$04,$08,$08
dungeon_number:
	.byte 0

; junk
;	lda #$4e
