	.include "uscii.i"

	.include "apple.i"
	.include "char.i"
	.include "dungeon.i"
	.include "map_objects.i"
	.include "sound.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "tables.i"
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
	lda game_mode
	cmp #mode_dungeon
	bne @ask_which
	sta saved_game_mode
	lda #mode_suspended
	sta game_mode
@ask_which:
	jsr j_primm
	.byte "WHICH ITEM:", $8d
	.byte 0
	jsr get_input
	jsr compare_keywords_all
	bpl keyword_matched
print_not_usable:
	jsr j_primm
	.byte $8d
	.byte "NOT USABLE!", $8d
	.byte 0
	jmp return_to_dungeon

print_none_owned:
	jsr j_primm
	.byte $8d
	.byte "NONE OWNED!", $8d
	.byte 0
	jmp return_to_dungeon

print_no_effect:
	jsr j_primm
	.byte $8d
	.byte "HMM...NO EFFECT!", $8d
	.byte 0
	jmp return_to_dungeon

keyword_matched:
	cmp #keyword_item_last
	bcs print_not_usable
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

return_to_dungeon:
	jsr j_primm_cout
	.byte $84,"BLOAD DNGD,A$8C00", $8d
	.byte 0
	lda saved_game_mode
	cmp #mode_dungeon
	bne @skip
	sta game_mode
@skip:
	rts

saved_game_mode:
	.byte 0

use_stone:
	lda stones
	bne @have_stone
	jmp print_none_owned

@have_stone:
	lda current_location
	cmp #loc_dng_abyss
	bne @regular_dungeon
	jmp use_stone_in_abyss

@regular_dungeon:
	lda game_mode
	cmp #mode_combat_dng_room
	beq @check_center
@no_effect:
	jmp print_no_effect

@check_center:
	ldx curr_player
	lda #$05
	cmp combat_player_xpos-1,x
	bne @no_effect
	cmp combat_player_ypos-1,x
	bne @no_effect
	jsr j_primm
	.byte $8d
	.byte "THERE ARE HOLES", $8d
	.byte "FOR 4 STONES,", $8d
	.byte "WHAT COLORS:", $8d
	.byte 0
	lda #$00
	sta placed_stone_mask
	lda #$03
	sta placed_stone_counter
@next_stone:
	lda #$04
	sec
	sbc placed_stone_counter
	jsr j_printdigit
	jsr get_input
	jsr compare_keywords_colors
	sec
	sbc #$08
	cmp #$08
	bcs @none_owned
	tay
	lda bit_msb,y
	and stones
	beq @none_owned
	lda bit_msb,y
	and placed_stone_mask
	bne @none_owned
	lda bit_msb,y
	ora placed_stone_mask
	sta placed_stone_mask
	dec placed_stone_counter
	bmi @check_stones
	jmp @next_stone

@none_owned:
	jmp print_none_owned

@check_stones:
	lda placed_stone_mask
	ldy altar_room_principle
	cmp principle_colors,y
	beq @all_stones_match
@already_have_keypart:
	jmp print_no_effect

@all_stones_match:
	ldy altar_room_principle
	lda principle_keypart,y
	and threepartkey
	bne @already_have_keypart
	lda principle_keypart,y
	ora threepartkey
	sta threepartkey
	jsr j_primm
	.byte "THOU DOTH FIND", $8d
	.byte "ONE THIRD OF THE", $8d
	.byte "THREE PART KEY!", $8d
	.byte 0
	jmp return_to_dungeon

use_stone_in_abyss:
	lda saved_game_mode
	cmp #mode_dungeon
	beq @check_for_altar
@no_effect:
	jmp print_no_effect

@check_for_altar:
	lda tile_under_player
	cmp #dng_tile_altar
	bne @no_effect
	jsr j_primm
	.byte $8d
	.byte "AS THOU", $8d
	.byte "DOTH APPROACH", $8d
	.byte 0
	jsr ask_virtue
	bne @no_effect
	jsr j_primm
	.byte $8d
	.byte "THE VOICE SAYS:", $8d
	.byte "USE THY STONE.", $8d
	.byte $8d
	.byte "COLOR:", $8d
	.byte 0
	jsr get_input
	jsr compare_keywords_colors
	sec
	sbc #$08
	cmp #$08
	bcs @no_effect
	sta abyss_altar_stone_used
	tay
	lda bit_msb,y
	and stones
	bne @have_stone
	jmp print_none_owned

@have_stone:
	lda abyss_altar_stone_used
	cmp dungeon_level
	bne @no_effect
	cmp #$07
	beq @load_end_game
	lda player_xpos
	sta dest_x
	lda player_ypos
	sta dest_y
	jsr j_gettile_dungeon
	lda #dng_tile_ladder_d
	sta (ptr1),y
	jsr j_primm
	.byte $8d
	.byte "THE ALTER", $8d
	.byte "CHANGES BEFORE", $8d
	.byte "THYNE EYES!", $8d
	.byte 0
	jmp return_to_dungeon

@load_end_game:
	jsr j_primm_cout
	.byte $84,"BRUN END,A$8800", $8d
	.byte 0

placed_stone_mask:
	.byte 0
placed_stone_counter:
	.byte 0

use_bell:
	lda bell_book_candle
	and #item_have_bell
	bne use_no_effect
	beq use_none_owned

use_book:
	lda bell_book_candle
	and #item_have_book
	bne use_no_effect

use_none_owned:
	jmp print_none_owned
use_no_effect:
	jmp print_no_effect

use_candle:
	lda bell_book_candle
	and #item_have_candle
	bne use_no_effect
	beq use_none_owned

use_key:
	lda threepartkey
	bne j_print_no_effect
	jmp print_none_owned

use_horn:
	lda horn
	bne j_print_no_effect
	jmp print_none_owned

use_wheel:
	lda wheel
	bne j_print_no_effect
	jmp print_none_owned

j_print_no_effect:
	jmp print_no_effect

use_skull:
	lda skull
	cmp #$01
	beq @have_skull
	jmp print_none_owned

@have_skull:
	lda game_mode
	bmi j_print_no_effect
	jsr j_primm
	.byte $8d
	.byte "HOLDING THE EVIL", $8d
	.byte "SKULL ALOFT...", $8d
	.byte 0
	jsr shake_screen
	jsr j_invertview
	jsr shake_screen
	jsr j_invertview
	jsr shake_screen
	ldx #object_max
	lda #$00
@clear:
	sta object_tile_type,x
	sta object_tile_sprite,x
	dex
	bpl @clear
	jsr j_update_view
	lda #virtue_last - 1
	sta zp_index
@next_virtue:
	ldy zp_index
	lda #$05
	jsr dec_virtue
	dec zp_index
	bpl @next_virtue
	jsr j_update_status
	jmp return_to_dungeon

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

compare_keywords_colors:
	lda #keyword_color_last - 1
	sta zp_index
	jmp start_keyword

compare_keywords_all:
	lda #keyword_virtue_last - 1
	sta zp_index
start_keyword:
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
	bpl start_keyword
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
keyword_item_last = (* - keywords) / 4

	.byte "BLUE"
	.byte "YELL"
	.byte "RED "
	.byte "GREE"
	.byte "ORAN"
	.byte "PURP"
	.byte "WHIT"
	.byte "BLAC"
keyword_color_last = (* - keywords) / 4

	.byte "HONE"
	.byte "COMP"
	.byte "VALO"
	.byte "JUST"
	.byte "SACR"
	.byte "HONO"
	.byte "SPIR"
	.byte "HUMI"
keyword_virtue_last = (* - keywords) / 4

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
	.byte "AN EIGHTH LOST!", $8d
	.byte 0
	lda #$99
	ldy zp_save_reg
	jmp @continue

bit_msb:
	.byte $80,$40,$20,$10,$08,$04,$02,$01
principle_keypart:
	.byte 4, 2, 1
principle_colors:
	.byte %10010110
	.byte %01011010
	.byte %00101110

ask_virtue:
	lda dungeon_level
	cmp #$07
	bne @level1
	jmp @level8

@level1:
	jsr j_primm
	.byte $8d
	.byte "A VOICE RINGS", $8d
	.byte "OUT: WHAT VIRTUE", $8d
	.byte "DOST STEM FROM", $8d
	.byte 0
	ldx dungeon_level
	bne @level2
	jsr j_primm
	.byte "TRUTH?", $8d
	.byte 0
	jmp @get_reply

@level2:
	dex
	bne @level3
	jsr j_primm
	.byte "LOVE?", $8d
	.byte 0
	jmp @get_reply

@level3:
	dex
	bne @level4
	jsr j_primm
	.byte "COURAGE?", $8d
	.byte 0
	jmp @get_reply

@level4:
	dex
	bne @level5
	jsr j_primm
	.byte "TRUTH AND LOVE?", $8d
	.byte 0
	jmp @get_reply

@level5:
	dex
	bne @level6
	jsr j_primm
	.byte "LOVE AND", $8d
	.byte "COURAGE?", $8d
	.byte 0
	jmp @get_reply

@level6:
	dex
	bne @level7
	jsr j_primm
	.byte "COURAGE AND", $8d
	.byte "TRUTH?", $8d
	.byte 0
	jmp @get_reply

@level7:
	dex
	bne @level8
	jsr j_primm
	.byte "TRUTH, LOVE", $8d
	.byte "AND COURAGE?", $8d
	.byte 0
	jmp @get_reply

@level8:
	jsr j_primm
	.byte "A VOICE RINGS", $8d
	.byte "OUT: WHAT", $8d
	.byte "VIRTUE EXISTS", $8d
	.byte "INDEPENDENTLY OF", $8d
	.byte "TRUTH, LOVE AND", $8d
	.byte "COURAGE!", $8d
	.byte 0

@get_reply:
	jsr get_input
	jsr compare_keywords_all
	sec
	sbc #$10
	cmp dungeon_level
	rts

abyss_altar_stone_used:
	.byte 0

; junk
	.byte $ff,$ff
