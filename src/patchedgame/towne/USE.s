	.include "uscii.i"

	.include "apple.i"
	.include "char.i"
	.include "map_objects.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "sound.i"
	.include "tables.i"
	.include "tiles.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


; --- Custom use of Zero Page

zp_save_reg = $d9
zp_dec_amount = $da
zp_index = $ea
zp_input_index = $ea


	.segment "OVERLAY"

.assert * = j_overlay_entry, error, "Wrong start address"
	jsr j_primm
	.byte "WHICH ITEM:", $8d
	.byte 0
	jsr get_input
	jsr compare_keywords
	bpl keyword_matched
	jsr j_primm
	.byte $8d
	.byte "NOT USABLE ITEM!", $8d
	.byte 0
	rts

print_none_owned:
	jsr j_primm
	.byte $8d
	.byte "NONE OWNED!", $8d
	.byte 0
	rts

print_no_effect:
	jsr j_primm
	.byte $8d
	.byte "HMM...NO EFFECT!", $8d
	.byte 0
	rts

keyword_matched:
	asl
	tay
	lda keyword_handlers,y
	sta ptr1
	lda keyword_handlers+1,y
	sta ptr1 + 1
	jmp (ptr1)

keyword_handlers:
	.addr use_stone
	.addr use_bell
	.addr use_book
	.addr use_candle
	.addr use_key
	.addr use_horn
	.addr use_wheel
	.addr use_skull

use_stone:
	lda stones
	bne @have_stone
	jmp print_none_owned

@have_stone:
	jsr j_primm
	.byte $8d
	.byte "NO PLACE TO", $8d
	.byte "USE THEM!", $8d
	.byte 0
	rts

use_bell:
	lda bell_book_candle
	and #item_have_bell
	bne @have_bell
	jmp print_none_owned

@have_bell:
	jmp print_no_effect

use_book:
	lda bell_book_candle
	and #item_have_book
	bne @have_book
	jmp print_none_owned

@have_book:
	jmp print_no_effect

use_candle:
	lda bell_book_candle
	and #item_have_candle
	bne @have_candle
	jmp print_none_owned

@have_candle:
	jmp print_no_effect

use_key:
	lda threepartkey
	bne @no_effect
	jmp print_none_owned

@no_effect:
	jmp print_no_effect

use_horn:
	lda horn
	bne @have_horn
	jmp print_none_owned

@have_horn:
	jmp print_no_effect

use_wheel:
	lda wheel
	bne @have_wheel
	jmp print_none_owned

@have_wheel:
	jmp print_no_effect

use_skull:
	lda skull
	cmp #$01
	beq @have_skull
	jmp print_none_owned

@have_skull:
	jsr j_primm
	.byte $8d
	.byte "YOU HOLD THE", $8d
	.byte "EVIL SKULL OF", $8d
	.byte "MONDAIN THE", $8d
	.byte "WIZARD ALOFT....", $8d
	.byte 0
	jsr shake_screen
	jsr j_invertview
	jsr shake_screen
	jsr j_invertview
	jsr shake_screen
	
	lda game_mode   ; ENHANCED: skull in combat
	bmi @combat     ; ENHANCED: skull in combat

	ldx #object_max
@clear:
	lda #$00
	ldy object_tile_type,x
	cpy #tile_lord_british
	beq @lord_british
	sta object_tile_type,x
	sta object_tile_sprite,x
	sta object_dng_level,x
	sta npc_dialogue,x
	jmp @next_object
@lord_british:
	lda #$ff
	sta object_dng_level,x
@next_object:
	dex
	bpl @clear

	jsr j_update_view
@penalty:
	lda #virtue_last - 1
	sta zp_index
@next_virtue:
	ldy zp_index
	lda #$05
	jsr dec_virtue
	dec zp_index
	bpl @next_virtue
	jsr j_update_status
	rts

; ENHANCED: skull in combat kills combatants, not out-of-combat mobs
@combat:
	ldx #foes_max
@next:
	lda combat_foe_tile_type,x
	beq @skip
	cmp #tile_lord_british
	beq @skip
@kill_foe:
	stx zp_index
	lda combat_foe_cur_x,x
	sta target_x
	lda combat_foe_cur_y,x
	sta target_y
	lda #tile_attack_red
	sta attack_sprite
	jsr j_update_view_combat
	lda #sound_damage
	jsr j_playsfx
	ldx zp_index
	lda #$00
	sta attack_sprite
	sta combat_foe_hp,x
	sta combat_foe_tile_type,x
@skip:
	dex
	bpl @next
	bmi @penalty

get_input:
	lda #char_question
	jsr j_console_out
	lda #$00
	sta zp_input_index
@get_char:
	jsr j_waitkey
	cmp #char_enter
	beq @got_input
	cmp #char_left_arrow
	beq @backspace
	cmp #char_space
	bcc @get_char
	ldx zp_input_index
	sta inbuffer,x
	jsr j_console_out
	inc zp_input_index
	lda zp_input_index
	cmp #$0f
	bcc @get_char
	bcs @got_input
@backspace:
	lda zp_input_index
	beq @get_char
	dec zp_input_index
	dec console_xpos
	lda #char_space
	jsr j_console_out
	dec console_xpos
	jmp @get_char

@got_input:
	ldx zp_input_index
	lda #char_space
@pad_spaces:
	sta inbuffer,x
	inx
	cpx #$06
	bcc @pad_spaces
	lda #char_enter
	jsr j_console_out
	rts

compare_keywords:
	lda #keyword_last - 1
	sta zp_index
@start_keyword:
	lda zp_index
	asl
	asl
	tay
	ldx #$00
@next_char:
	lda keywords,y
	cmp inbuffer,x
	bne @next_keyword
	iny
	inx
	cpx #$04
	bcc @next_char
	lda zp_index
	rts

@next_keyword:
	dec zp_index
	bpl @start_keyword
	lda zp_index
	rts

keywords:
	.byte "STON"
	.byte "BELL"
	.byte "BOOK"
	.byte "CAND"
	.byte "KEY "
	.byte "HORN"
	.byte "WHEE"
	.byte "SKUL"
keyword_last = (* - keywords) / 4

shake_screen:
	lda #sound_damage
	jsr j_playsfx
	jsr shake_up
	jsr shake_down
	jsr shake_up
	jsr shake_down
	jsr shake_up
	jsr shake_down
	jsr shake_up
	jsr shake_down
	rts

shake_down:
	ldx #$ae
@next:
	lda bmplineaddr_lo + 9,x
	sta ptr1
	lda bmplineaddr_hi + 9,x
	sta ptr1 + 1
	lda bmplineaddr_lo + 7,x
	sta ptr2
	lda bmplineaddr_hi + 7,x
	sta ptr2 + 1
	ldy #$16
@copy:
	lda (ptr2),y
	sta (ptr1),y
	dey
	bne @copy
	bit sfx_volume
	bpl @skip
	jsr j_rand
	bmi @skip
	bit hw_SPEAKER
@skip:
	dex
	bne @next
	rts

shake_up:
	ldx #$00
@next:
	lda bmplineaddr_lo + 8,x
	sta ptr1
	lda bmplineaddr_hi + 8,x
	sta ptr1 + 1
	lda bmplineaddr_lo + 10,x
	sta ptr2
	lda bmplineaddr_hi + 10,x
	sta ptr2 + 1
	ldy #$16
@copy:
	lda (ptr2),y
	sta (ptr1),y
	dey
	bne @copy
	bit sfx_volume
	bpl @skip
	jsr j_rand
	bmi @skip
	bit hw_SPEAKER
@skip:
	inx
	cpx #$ae
	bcc @next
	rts

dec_virtue:
	sta zp_dec_amount
	sty zp_save_reg
	lda party_stats,y
	beq @lost_an_eighth
@continue:
	sed
	sec
	sbc zp_dec_amount
	beq @underflow
	bcs @set_value
@underflow:
	lda #$01
@set_value:
	sta party_stats,y
	cld
	rts

@lost_an_eighth:
	jsr j_primm
	.byte $8d
	.byte "THOU HAST LOST", $8d
	.byte "AN EIGHTH!", $8d
	.byte 0
	lda #$99
	ldy zp_save_reg
	jmp @continue

; junk
;	.byte $d9,$f0
