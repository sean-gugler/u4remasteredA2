	.include "uscii.i"

	.include "char.i"
	.include "map_objects.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "tables.i"
	.include "tiles.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


; --- Custom use of Zero Page

towne_virtue = $d5
zp_number = $d8
zp_index = $ea
zp_string = $ea

zp_save_reg = $d9
; for consistency these should have been the same
zp_dec_amount = $da
zp_inc_amount = $d9


	.segment "DIALOG"

dialog_strings:                 .res $f5
dialog_keyword_1:               .res 4
dialog_keyword_2:               .res 4
dialog_question_trigger:        .res 1
;dialog_special:                 .res 1
dialog_humility:                .res 1
dialog_turns_away_probability:  .res 1


	.segment "TALK"

.assert * = j_overlay_entry, error, "Wrong start address"
	ldx #$03
@copy_keywords:
	lda dialog_keyword_1,x
	ora #$80
	sta keyword_1,x
	lda dialog_keyword_2,x
	ora #$80
	sta keyword_2,x
	dex
	bpl @copy_keywords
	ldx zp_index
	lda object_tile_type,x
	sta npc_type
	jsr j_primm
	.byte $8d
	.byte "YOU MEET", $8d
	.byte 0
	lda #$03
	jsr print_string
	lda #char_enter
	jsr j_console_out
	jsr j_rand
	cmp dialog_turns_away_probability
	bcc maybe_fight
	jsr j_rand
	bmi talk_prompt
	lda #char_enter
	jsr j_console_out
print_name:
	jsr pronoun_says
	jsr j_primm
	.byte " I AM", $8d
	.byte 0
	lda #$01
	jsr print_string
	lda #char_period   ;TEXTFIX period after name, always
	jsr j_console_out  ;TEXTFIX
	lda #char_enter
	jsr j_console_out
	jmp talk_prompt

maybe_fight:
	sta zp_number
	lda dialog_turns_away_probability
	sec
	sbc zp_number
	cmp #$40
	bcs @fight
	jmp pronoun_turns_away

@fight:
	jmp start_combat

; dead code, unused in original game
;	jsr pronoun_says_newline
;	jsr j_primm
;	.byte "GO AWAY!", $8d
;	.byte 0
talk_prompt:
	jsr j_primm
	.byte $8d
	.byte "Your interest:", $8d
	.byte 0
	jsr get_input
	lda #char_enter
	jsr j_console_out
	jsr j_rand
	cmp dialog_turns_away_probability
	bcs @check_input
	sta zp_number
	sec
	lda dialog_turns_away_probability
	sbc zp_number
	cmp #$80
	bcs @fight
	jmp pronoun_turns_away

@fight:
	jmp start_combat

@check_input:
	jsr compare_keywords
	bpl @keyword_matched
	jsr pronoun_says
	jsr j_primm
	.byte " THAT,", $8d
	.byte "I CANNOT HELP", $8d
	.byte "THEE WITH.", $8d
	.byte 0
	jmp check_question_trigger

@keyword_matched:
	cmp #keyword_bye
	beq @bye
	cmp #keyword_empty
	bne @name
@bye:
	jsr pronoun_says
	jsr j_primm
	.byte " BYE.", $8d
	.byte 0
	jmp talk_done

@name:
	cmp #keyword_name
	bne @look
	jmp print_name

@look:
	cmp #keyword_look
	bne @join
	jsr j_primm
	.byte "YOU SEE A", $8d
	.byte 0
	lda #$03
	jmp print_response_newline

@join:
	cmp #keyword_join
	bne @give
	jmp check_join

@give:
	cmp #keyword_give
	bne @keyword
	jmp check_give

@keyword:
	jsr pronoun_says_newline
	lda zp_string
	clc
	adc #$01
print_response_newline:
	jsr print_string
	lda #char_enter
	jsr j_console_out
	jmp check_question_trigger

check_question_trigger:
	lda zp_string
	cmp dialog_question_trigger
	beq ask_question
;	cmp dialog_special ;unused, no data sets this flag.
;	beq special        ;unused
	jmp talk_prompt

ask_question:
	jsr j_waitkey
	lda #char_enter
	jsr j_console_out
	lda #$02
	jsr print_string
	jsr j_primm
	.byte " ASKS:", $8d
	.byte 0
	lda #$08
	jsr print_string
@get_response:
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "You respond:", $8d
	.byte 0
	jsr get_input
	lda #char_enter
	jsr j_console_out
	lda inbuffer
	cmp #char_N
	beq @no
	cmp #char_Y
	bne @yes_or_no
	jsr dec_humility
	jsr pronoun_says_newline
	lda #$09
	sta zp_string
	jmp print_response_newline

@no:
	jsr inc_humility
	jsr pronoun_says_newline
	lda #$0a
	sta zp_string
	jmp print_response_newline

@yes_or_no:
	jsr pronoun_says_newline
	jsr j_primm
	.byte "YES, OR NO:", 0
	jmp @get_response

; unused original code, maybe stub for second virtue, like honesty?
;special:
;	jsr j_primm
;	.byte "SPECIAL!", $8d
;	.byte 0
;	jmp talk_prompt

pronoun_turns_away:
	lda #$02
	jsr print_string
	jsr j_primm
	.byte " TURNS AWAY!", $8d
	.byte $8d
	.byte 0
	jmp talk_done

start_combat:
	lda #$02
	jsr print_string
	jsr j_primm
	.byte " SAYS:", $8d
	.byte "EN GARDE! FOOL!", $8d
	.byte 0
	ldx zp_index
	lda #ai_hostile
	sta npc_movement_ai,x
	jmp talk_done

pronoun_says:
	lda #$02
	jsr print_string
	jsr j_primm
	.byte " SAYS:", 0
	rts

pronoun_says_newline:
	jsr pronoun_says
	lda #char_enter
	jsr j_console_out
	rts

get_input:
	lda #char_question
	jsr j_console_out
	lda #$00
	sta input_index
@get_char:
	jsr j_waitkey
	cmp #char_enter
	beq @got_input
	cmp #char_left_arrow
	beq @backspace
	cmp #char_space
	bcc @get_char
	ldx input_index
	sta inbuffer,x
	jsr j_console_out
	inc input_index
	lda input_index
	cmp #$0f
	bcc @get_char
	bcs @got_input
@backspace:
	lda input_index
	beq @get_char
	dec input_index
	dec console_xpos
	lda #char_space
	jsr j_console_out
	dec console_xpos
	jmp @get_char

@got_input:
	ldx input_index
	lda #char_space
@pad_spaces:
	sta inbuffer,x
	inx
	cpx #$06
	bcc @pad_spaces
	lda #char_enter
	jsr j_console_out
	rts

input_index:
	.byte 0

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
	.byte "BYE "
	.byte "NAME"
	.byte "LOOK"
	.byte "JOB "
	.byte "HEAL"
keyword_1:
	.byte "    "
keyword_2:
	.byte "    "
	.byte "JOIN"
	.byte "GIVE"
	.byte "    "
keyword_last = (* - keywords) / 4

keyword_bye   = $00
keyword_name  = $01
keyword_look  = $02
keyword_job   = $03
keyword_heal  = $04
keyword_one   = $05
keyword_two   = $06
keyword_join  = $07
keyword_give  = $08
keyword_empty = $09

; original scheme uses 00 as separators.
;print_string:
;	tay
;	lda #<dialog_strings
;	sta ptr1
;	lda #>dialog_strings
;	sta ptr1 + 1
;	ldx #$00
;@check:
;	lda (ptr1,x)
;	beq @eos
;@next:
;	jsr @inc_ptr
;	jmp @check
;@eos:
;	dey
;	beq @print
;	jmp @next
;@print:
;	jsr @inc_ptr
;	ldx #$00
;	lda (ptr1,x)
;	beq @done
;	jsr j_console_out
;	jmp @print
;@done:
;	rts
;@inc_ptr:
;	inc ptr1
;	bne @skip
;	inc ptr1 + 1
;@skip:
;	rts
;
; Patch makes room for longer strings to fix language mistakes
; by using high bit as separator. (and cutting keywords from
; 6 chars to 4, since that's all the parser checks anyway)
; As a bonus, the following routine is also a few bytes smaller
; than the original above.

print_string:
	tax
	lda #<dialog_strings
	sta ptr1
	lda #>dialog_strings
	sta ptr1 + 1
@next:
	dex
	beq @print
	ldy #0
@check:
	lda (ptr1),y
	bpl @eos
	iny
	bne @check
@eos:
	tya
	sec
	adc ptr1
	sta ptr1
	bne @next
@print:
	ldy #0
	lda (ptr1),y
	bpl @last
	jsr j_console_out
	inc ptr1
	bne @print
@last:
	ora #$80
	jmp j_console_out


check_join:
	lda diskio_sector ;clever! Joinables are always NPC #0 of their towne.
	bne @cant_join
	lda current_location
	sec
	sbc #$05
	cmp #$08
	bcs @cant_join
	sta towne_virtue
	lda #$01
	sta curr_player
	jsr j_get_stats_ptr
	ldy #player_class_index
	lda (ptr1),y
	cmp towne_virtue
	beq @cant_join
	ldx towne_virtue
	lda party_stats,x
	beq @part_avatar
	cmp #$40     ;matching virtue must be this high to join
	bcc @decline
@part_avatar:
	lda party_size
	cmp player_stats + player_max_hp_hi
	bcs @not_enough_xp
	jmp accept_join

@cant_join:
	jsr pronoun_says_newline
	jsr j_primm
	.byte "I CANNOT", $8d
	.byte "JOIN THEE.", $8d
	.byte 0
	jmp talk_prompt

@decline:
	stx zp_number
@print_decline:
	jsr pronoun_says_newline
	jsr j_primm
	.byte "THOU ART NOT", $8d
	.byte 0
	jsr decline_reason
	jsr j_primm
	.byte $8d
	.byte "ENOUGH FOR ME", $8d
	.byte "TO JOIN THEE.", $8d
	.byte 0
	jmp talk_prompt

@not_enough_xp:
	lda #$08
	sta zp_number
	jmp @print_decline

accept_join:
	jsr pronoun_says_newline
	jsr j_primm
	.byte "I AM HONORED", $8d
	.byte "TO JOIN THEE!", $8d
	.byte 0
	ldx #object_max    ;clever! Joinables are always last object slot of their towne.
	lda #$00
	sta object_tile_type,x
	sta object_tile_sprite,x
	sta npc_movement_ai,x
	sta npc_dialogue,x
	jsr j_update_view
	lda #player_last
	sta curr_player
@next:
	jsr j_get_stats_ptr
	ldy #player_class_index
	lda (ptr1),y
	cmp towne_virtue
	beq @found_slot
	dec curr_player
	bpl @next
	jmp @done

@found_slot:
	jsr j_get_stats_ptr
	lda ptr1
	sta ptr2
	lda ptr1 + 1
	sta ptr2 + 1
	inc party_size
	lda party_size
	sta curr_player
	jsr j_get_stats_ptr
	ldy #player_stat_max
@move:
	lda (ptr1),y
	pha
	lda (ptr2),y
	sta (ptr1),y
	pla
	sta (ptr2),y
	dey
	bpl @move
	jsr j_clearstatwindow
	jsr j_update_status
@done:
	jmp talk_done

check_give:
	lda npc_type
	cmp #tile_beggar
	beq @how_much
	jsr pronoun_says
	jsr j_primm
	.byte " I DO", $8d
	.byte "NOT NEED THY", $8d
	.byte "GOLD, KEEP IT!", $8d
	.byte 0
	jmp check_question_trigger

@how_much:
	jsr j_primm
	.byte "How much-", 0
	jsr j_getnumber
	lda #char_enter
	jsr j_console_out
	lda bcdnum
	bne @give_amount
	jmp check_question_trigger

@give_amount:
	jsr dec_gold
	bpl @has_gold
	jsr j_primm
	.byte $8d
	.byte "THOU HAST NOT", $8d
	.byte "THAT MUCH GOLD!", $8d
	.byte 0
	jmp check_question_trigger

@has_gold:
	jsr give_gold_add_virtue
	lda #char_enter
	jsr j_console_out
	jsr pronoun_says
	jsr j_primm
	.byte " OH,", $8d
	.byte "THANK THEE!", $8d
	.byte "I SHALL NEVER", $8d
	.byte "FORGET THY", $8d
	.byte "KINDNESS!", $8d
	.byte 0
	jmp check_question_trigger

give_gold_add_virtue:
	lda gold_lo
	ora gold_hi
	bne @has_gold_left
	lda #$03
	ldy #virtue_sacrifice     ;BUGFIX. Original value was 5 (honor)
	jsr inc_virtue
@has_gold_left:
	lda move_counter + 3
	and #$f0
	cmp last_humility_check
	beq @too_soon
	sta last_humility_check
	lda #$02
	ldy #virtue_compassion
	jsr inc_virtue
@too_soon:
	rts

decline_reason:
	ldx zp_number
	bne @compassionate
	jsr j_primm
	.byte "HONEST", 0
	rts

@compassionate:
	dex
	bne @valiant
	jsr j_primm
	.byte "COMPASSIONATE", 0
	rts

@valiant:
	dex
	bne @just
	jsr j_primm
	.byte "VALIANT", 0
	rts

@just:
	dex
	bne @sacrificial
	jsr j_primm
	.byte "JUST", 0
	rts

@sacrificial:
	dex
	bne @honorable
	jsr j_primm
	.byte "SACRIFICIAL", 0
	rts

@honorable:
	dex
	bne @spiritual
	jsr j_primm
	.byte "HONORABLE", 0
	rts

@spiritual:
	dex
	bne @humble
	jsr j_primm
	.byte "SPIRITUAL", 0
	rts

@humble:
	dex
	bne @experienced
	jsr j_primm
	.byte "HUMBLE", 0
	rts    ; BUGFIX. rts missing in original.

@experienced:
	jsr j_primm
	.byte "EXPERIENCED", 0
	rts

dec_humility:
	lda dialog_humility
	cmp #$01
	bne @not_humility
	lda #$05
	ldy #virtue_humility
	jsr dec_virtue
	lda move_counter + 3
	and #$f0
	sta last_humility_check
@not_humility:
	rts

inc_humility:
	lda dialog_humility
	cmp #$01
	bne @not_humility
	lda move_counter + 3
	and #$f0
	cmp last_humility_check
	beq @not_humility
	sta last_humility_check
	lda #$0a
	ldy #virtue_humility
	jsr inc_virtue
@not_humility:
	rts

dec_gold:
	sed
	sec
	lda gold_lo
	sbc bcdnum
	sta gold_lo
	lda gold_hi
	sbc #$00
	bcc @underflow
	sta gold_hi
	cld
	jsr j_update_status
	lda #$00
	rts

@underflow:
	clc
	lda gold_lo
	adc bcdnum
	sta gold_lo
	cld
	lda #$ff
	rts

inc_virtue:
	sta zp_inc_amount
	sed
	clc
	lda party_stats,y
	beq @set_value
	adc zp_inc_amount
	bcc @set_value
	lda #$99
@set_value:
	sta party_stats,y
	cld
	rts

dec_virtue:
	sta zp_dec_amount
	sty zp_save_reg
	lda party_stats,y
	beq @lost_an_eigth
@set_virtue:
	sed
	sec
	sbc zp_dec_amount
	bcs @set_value
	bne @set_value
	lda #$01
@set_value:
	sta party_stats,y
	cld
	rts

@lost_an_eigth:
	jsr j_primm
	.byte $8d
	.byte "THOU HAST LOST", $8d
	.byte "AN EIGHTH!", $8d
	.byte 0
	ldy zp_save_reg
	lda #$99
	jmp @set_virtue

talk_done:
	rts

; Junk from segment alignment
;	.byte "Y", $8d
;	.byte "LOST.", $8d
;	.byte 0
;	.byte $4c,$30
