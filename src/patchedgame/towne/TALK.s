	.include "uscii.i"
	.include "TALK.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
current_location = $0a
party_size = $0f
last_humility_check = $17
move_counter = $1c
;move_counter + 3 = $1f
console_xpos = $ce
currplayer = $d4
towne_virtue = $d5
bcdnum = $d7
zpdb = $d8
zpd9 = $d9
zpda = $da
lt_x = $e1
monster_type = $e6
zpea = $ea
ptr2 = $fc
;ptr2 + 1 = $fd
ptr1 = $fe
;ptr1 + 1 = $ff
;
; **** ZP POINTERS ****
;
;ptr2 = $fc
;ptr1 = $fe
;
; **** USER LABELS ****
;
inbuffer = $0300
j_waitkey = $0800
j_primm = $0821
j_console_out = $0824
j_get_stats_ptr = $082d
j_update_status = $0845
j_update_view = $084b
j_rand = $084e
j_getnumber = $085a
j_clearstatwindow = $0869
player_stats = $ec00
;player_stats + player_max_hp_hi = $ec1a
game_stats = $ed00
gold = $ed13
;gold + 1 = $ed14
object_tile_sprite = $ee00
object_tile_type = $ee60
npc_can_move = $eec0
npc_dialogue = $eee0


	.segment "DIALOG"

dialog_strings:                 .res $f0
dialog_keyword_1:               .res 6
dialog_keyword_2:               .res 6
dialog_question_trigger:        .res 1
dialog_special:                 .res 1
dialog_humility:                .res 1
dialog_turns_away_probability:  .res 1


	.segment "TALK"

talk:
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
	ldx zpea
	lda object_tile_type,x
	sta monster_type
	jsr j_primm  ;b'\rYOU MEET\r\x00'
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
	jsr j_primm  ;b' I AM\r\x00'
	.byte " I AM", $8d
	.byte 0
	lda #$01
	jsr print_string
	lda #char_enter
	jsr j_console_out
	jmp talk_prompt

maybe_fight:
	sta zpdb
	lda dialog_turns_away_probability
	sec
	sbc zpdb
	cmp #$40
	bcs @fight
	jmp pronoun_turns_away

@fight:
	jmp start_combat

	jsr pronoun_says_newline
	jsr j_primm  ;b'GO AWAY!\r\x00'
	.byte "GO AWAY!", $8d
	.byte 0
talk_prompt:
	jsr j_primm  ;b'\rYour interest:\r\x00'
	.byte $8d
	.byte "Your interest:", $8d
	.byte 0
	jsr get_input
	lda #char_enter
	jsr j_console_out
	jsr j_rand
	cmp dialog_turns_away_probability
	bcs @check_input
	sta zpdb
	sec
	lda dialog_turns_away_probability
	sbc zpdb
	cmp #$80
	bcs @fight
	jmp pronoun_turns_away

@fight:
	jmp start_combat

@check_input:
	jsr compare_keywords
	bpl @found_keyword
	jsr pronoun_says
	jsr j_primm  ;b' THAT,\rI CANNOT HELP\rTHEE WITH.\r\x00'
	.byte " THAT,", $8d
	.byte "I CANNOT HELP", $8d
	.byte "THEE WITH.", $8d
	.byte 0
	jmp check_question_trigger

@found_keyword:
	cmp #$00
	beq @bye
	cmp #$09
	bne @name
@bye:
	jsr pronoun_says
	jsr j_primm  ;b' BYE.\r\x00'
	.byte " BYE.", $8d
	.byte 0
	jmp talk_done

@name:
	cmp #$01
	bne @look
	jmp print_name

@look:
	cmp #$02
	bne @join
	jsr j_primm  ;b'YOU SEE A\r\x00'
	.byte "YOU SEE A", $8d
	.byte 0
	lda #$03
	jmp print_response_newline

@join:
	cmp #$07
	bne @give
	jmp check_join

@give:
	cmp #$08
	bne @keyword
	jmp check_give

@keyword:
	jsr pronoun_says_newline
	lda zpea
	clc
	adc #$01
print_response_newline:
	jsr print_string
	lda #char_enter
	jsr j_console_out
	jmp check_question_trigger

check_question_trigger:
	lda zpea
	cmp dialog_question_trigger
	beq ask_question
	cmp dialog_special ;unused, no data sets this flag.
	beq special        ;unused
	jmp talk_prompt

ask_question:
	jsr j_waitkey
	lda #char_enter
	jsr j_console_out
	lda #$02
	jsr print_string
	jsr j_primm  ;b' ASKS:\r\x00'
	.byte " ASKS:", $8d
	.byte 0
	lda #$08
	jsr print_string
@get_response:
	jsr j_primm  ;b'\r\rYou respond:\r\x00'
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
	jsr subtract_humility
	jsr pronoun_says_newline
	lda #$09
	sta zpea
	jmp print_response_newline

@no:
	jsr add_humility
	jsr pronoun_says_newline
	lda #$0a
	sta zpea
	jmp print_response_newline

@yes_or_no:
	jsr pronoun_says_newline
	jsr j_primm  ;b'YES, OR NO:\x00'
	.byte "YES, OR NO:", 0
	jmp @get_response

; unused original code, maybe stub for second virtue, like honesty?
special:
	jsr j_primm  ;b'SPECIAL!\r\x00'
	.byte "SPECIAL!", $8d
	.byte 0
	jmp talk_prompt

pronoun_turns_away:
	lda #$02
	jsr print_string
	jsr j_primm  ;b' TURNS AWAY!\r\r\x00'
	.byte " TURNS AWAY!", $8d
	.byte $8d
	.byte 0
	jmp talk_done

start_combat:
	lda #$02
	jsr print_string
	jsr j_primm  ;b' SAYS:\rON GUARD! FOOL!\r\x00'
	.byte " SAYS:", $8d
	.byte "ON GUARD! FOOL!", $8d
	.byte 0
	ldx zpea
	lda #$ff
	sta npc_can_move,x
	jmp talk_done

pronoun_says:
	lda #$02
	jsr print_string
	jsr j_primm  ;b' SAYS:\x00'
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
	sta input_ctr
@get_char:
	jsr j_waitkey
	cmp #char_enter
	beq @got_input
	cmp #char_left_arrow
	beq @backspace
	cmp #char_space
	bcc @get_char
	ldx input_ctr
	sta inbuffer,x
	jsr j_console_out
	inc input_ctr
	lda input_ctr
	cmp #$0f
	bcc @get_char
	bcs @got_input
@backspace:
	lda input_ctr
	beq @get_char
	dec input_ctr
	dec console_xpos
	lda #char_space
	jsr j_console_out
	dec console_xpos
	jmp @get_char

@got_input:
	ldx input_ctr
	lda #char_space
@pad_spaces:
	sta inbuffer,x
	inx
	cpx #$06
	bcc @pad_spaces
	lda #char_enter
	jsr j_console_out
	rts

input_ctr:
	.byte 0

compare_keywords:
	lda #$09
	sta zpea
@next:
	lda zpea
	asl
	asl
	tay
	ldx #$00
@compare:
	lda keywords,y
	cmp inbuffer,x
	bne @nomatch
	iny
	inx
	cpx #$04
	bcc @compare
	lda zpea
	rts

@nomatch:
	dec zpea
	bpl @next
	lda zpea
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

; original scheme uses 00 as separators.
print_string:
	tay
	lda #<dialog_strings
	sta ptr1
	lda #>dialog_strings
	sta ptr1 + 1
	ldx #$00
@check:
	lda (ptr1,x)
	beq @eos
@next:
	jsr @inc_ptr
	jmp @check
@eos:
	dey
	beq @print
	jmp @next
@print:
	jsr @inc_ptr
	ldx #$00
	lda (ptr1,x)
	beq @done
	jsr j_console_out
	jmp @print
@done:
	rts
@inc_ptr:
	inc ptr1
	bne @skip
	inc ptr1 + 1
@skip:
	rts

check_join:
	lda lt_x
	bne @cant_join
	lda current_location
	sec
	sbc #$05
	cmp #$08
	bcs @cant_join
	sta towne_virtue
	lda #$01
	sta currplayer
	jsr j_get_stats_ptr
	ldy #$11
	lda (ptr1),y
	cmp towne_virtue
	beq @cant_join
	ldx towne_virtue
	lda game_stats,x
	beq @part_avatar
	cmp #$40
	bcc @decline
@part_avatar:
	lda party_size
	cmp player_stats + player_max_hp_hi
	bcs @not_enough_xp
	jmp accept_join

@cant_join:
	jsr pronoun_says_newline
	jsr j_primm  ;b'I CANNOT\rJOIN THEE.\r\x00'
	.byte "I CANNOT", $8d
	.byte "JOIN THEE.", $8d
	.byte 0
	jmp talk_prompt

@decline:
	stx zpdb
@print_decline:
	jsr pronoun_says_newline
	jsr j_primm  ;b'THOU ART NOT\r\x00'
	.byte "THOU ART NOT", $8d
	.byte 0
	jsr decline_reason
	jsr j_primm  ;b'\rENOUGH FOR ME\rTO JOIN THEE.\r\x00'
	.byte $8d
	.byte "ENOUGH FOR ME", $8d
	.byte "TO JOIN THEE.", $8d
	.byte 0
	jmp talk_prompt

@not_enough_xp:
	lda #$08
	sta zpdb
	jmp @print_decline

accept_join:
	jsr pronoun_says_newline
	jsr j_primm  ;b'I AM HONORED\rTO JOIN THEE!\r\x00'
	.byte "I AM HONORED", $8d
	.byte "TO JOIN THEE!", $8d
	.byte 0
	ldx #$1f
	lda #$00
	sta object_tile_type,x
	sta object_tile_sprite,x
	sta npc_can_move,x
	sta npc_dialogue,x
	jsr j_update_view
	lda #$08
	sta currplayer
@next:
	jsr j_get_stats_ptr
	ldy #$11
	lda (ptr1),y
	cmp towne_virtue
	beq @found_slot
	dec currplayer
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
	sta currplayer
	jsr j_get_stats_ptr
	ldy #$1f
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
	lda monster_type
	cmp #$58
	beq @how_much
	jsr pronoun_says
	jsr j_primm  ;b' I DO\rNOT NEED THY\rGOLD, KEEP IT!\r\x00'
	.byte " I DO", $8d
	.byte "NOT NEED THY", $8d
	.byte "GOLD, KEEP IT!", $8d
	.byte 0
	jmp check_question_trigger

@how_much:
	jsr j_primm  ;b'How much-\x00'
	.byte "How much-", 0
	jsr j_getnumber
	lda #char_enter
	jsr j_console_out
	lda bcdnum
	bne @give_amount
	jmp check_question_trigger

@give_amount:
	jsr subtract_gold
	bpl @has_gold
	jsr j_primm  ;b'\rTHOU HAST NOT\rTHAT MUCH GOLD!\r\x00'
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
	jsr j_primm  ;b' OH,\rTHANK THEE!\rI SHALL NEVER\rFORGET THY\rKINDNESS!\r\x00'
	.byte " OH,", $8d
	.byte "THANK THEE!", $8d
	.byte "I SHALL NEVER", $8d
	.byte "FORGET THY", $8d
	.byte "KINDNESS!", $8d
	.byte 0
	jmp check_question_trigger

give_gold_add_virtue:
	lda gold + 1
	ora gold
	bne @has_gold_left
	lda #$03
	ldy #virtue_honor     ;BUG: awarded HONOR (5), but advice to give last gold comes from shrine of SACRIFICE (4).
	jsr add_virtue
@has_gold_left:
	lda move_counter + 3
	and #$f0
	cmp last_humility_check
	beq @too_soon
	sta last_humility_check
	lda #$02
	ldy #virtue_compassion
	jsr add_virtue
@too_soon:
	rts

decline_reason:
	ldx zpdb
	bne @compassionate
	jsr j_primm  ;b'HONEST\x00'
	.byte "HONEST", 0
	rts

@compassionate:
	dex
	bne @valiant
	jsr j_primm  ;b'COMPASSIONATE\x00'
	.byte "COMPASSIONATE", 0
	rts

@valiant:
	dex
	bne @just
	jsr j_primm  ;b'VALIANT\x00'
	.byte "VALIANT", 0
	rts

@just:
	dex
	bne @sacrificial
	jsr j_primm  ;b'JUST\x00'
	.byte "JUST", 0
	rts

@sacrificial:
	dex
	bne @honorable
	jsr j_primm  ;b'SACRIFICIAL\x00'
	.byte "SACRIFICIAL", 0
	rts

@honorable:
	dex
	bne @spiritual
	jsr j_primm  ;b'HONORABLE\x00'
	.byte "HONORABLE", 0
	rts

@spiritual:
	dex
	bne @humble
	jsr j_primm  ;b'SPIRITUAL\x00'
	.byte "SPIRITUAL", 0
	rts

@humble:
	dex
	bne @experienced
	jsr j_primm  ;b'HUMBLE\x00'
	.byte "HUMBLE", 0
; BUG. rts missing

@experienced:
	jsr j_primm  ;b'EXPERIENCED\x00'
	.byte "EXPERIENCED", 0
	rts

subtract_humility:
	lda dialog_humility
	cmp #$01
	bne @not_humility
	lda #$05
	ldy #$07
	jsr subtract_virtue
	lda move_counter + 3
	and #$f0
	sta last_humility_check
@not_humility:
	rts

add_humility:
	lda dialog_humility
	cmp #$01
	bne @not_humility
	lda move_counter + 3
	and #$f0
	cmp last_humility_check
	beq @not_humility
	sta last_humility_check
	lda #$0a
	ldy #$07
	jsr add_virtue
@not_humility:
	rts

subtract_gold:
	sed
	sec
	lda gold + 1
	sbc bcdnum
	sta gold + 1
	lda gold
	sbc #$00
	bcc @underflow
	sta gold
	cld
	jsr j_update_status
	lda #$00
	rts

@underflow:
	clc
	lda gold + 1
	adc bcdnum
	sta gold + 1
	cld
	lda #$ff
	rts

add_virtue:
	sta zpd9
	sed
	clc
	lda game_stats,y
	beq @overflow
	adc zpd9
	bcc @overflow
	lda #$99
@overflow:
	sta game_stats,y
	cld
	rts

subtract_virtue:
	sta zpda
	sty zpd9
	lda game_stats,y
	beq @lost_an_eigth
@set_virtue:
	sed
	sec
	sbc zpda
	bcs @underflow
	bne @underflow
	lda #$01
@underflow:
	sta game_stats,y
	cld
	rts

@lost_an_eigth:
	jsr j_primm  ;b'\rTHOU HAST LOST\rAN EIGHTH!\r\x00'
	.byte $8d
	.byte "THOU HAST LOST", $8d
	.byte "AN EIGHTH!", $8d
	.byte 0
	ldy zpd9
	lda #$99
	jmp @set_virtue

talk_done:
	rts

; Junk from segment alignment
	.byte "Y", $8d
	.byte "LOST.", $8d
	.byte 0
	.byte $4c,$30
