	.include "uscii.i"

	.include "char.i"
	.include "sound.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "jump_system.i"
	.include "music.i"
	.include "tables.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


; --- Custom use of Zero Page

zp_level = $ea
zp_index = $ea
zp_input_index = $ea
zp_mismatches = $f0


	.segment "OVERLAY"

.assert * = j_overlay_entry, error, "Wrong start address"
	pla          ;pop 2 frames left from entering by BRUN from HELP
	pla
	pla
	pla
	jmp next_question

; Entry point from ULT4, which uses BLOAD not BRUN
.assert * = talk_lord_british, error, "Wrong jump address"
	lda player_has_spoken_to_lb
	bne @check_alive
	inc player_has_spoken_to_lb
	jmp lb_intro

@check_alive:
; This routine is non-functional because of the BUG below.
	lda #$01
	sta curr_player
	jsr j_get_stats_ptr
	ldy #$45     ;BUG: should be #$12 - no idea where #$45 came from.
	lda (ptr1),y
	cmp #status_Dead
	bne @alive
	lda #status_Good
	sta (ptr1),y
	jsr j_printname
	jsr j_primm
	.byte "THOU SHALT", $8d
	.byte "LIVE AGAIN!", $8d
	.byte 0
	ldx #$14
	lda #sound_cast
	jsr j_playsfx
	jsr j_invertview
	lda #sound_spell_effect
	ldx #$c0
	jsr j_playsfx
	jsr j_invertview
	jsr restore_party_hp
	jsr j_update_status
@alive:
	jsr j_primm
	.byte "LORD BRITISH", $8d
	.byte "SAYS: WELCOME", $8d
	.byte 0
	lda #$01
	sta curr_player
	jsr j_printname
	lda party_size
	cmp #$02
	bcc @alone
	beq @one_companion
	bcs @three_or_more
@alone:
	jsr j_primm
	.byte $8d
	.byte "MY FRIEND!", $8d
	.byte 0
	jmp check_xp

@one_companion:
	jsr j_primm
	.byte $8d
	.byte "AND THEE ALSO", $8d
	.byte 0
	inc curr_player
	jsr j_printname
	jsr j_primm
	.byte "!", $8d
	.byte 0
	jmp check_xp

@three_or_more:
	jsr j_primm
	.byte $8d
	.byte "AND THY WORTHY", $8d
	.byte "ADVENTURERS!", $8d
	.byte 0

check_xp:
	lda party_size
	sta curr_player
@next:
	jsr j_get_stats_ptr
	ldy #player_experience_hi
	lda (ptr1),y
	jsr decode_bcd_value
	ldx #$01
@log_2:
	cmp #$00
	beq @check_level
	lsr
	inx
	jmp @log_2

@check_level:
	txa
	ldy #player_max_hp_hi
	cmp (ptr1),y
	beq @already_at_level
	sta (ptr1),y
	sta zp_level
	ldy #player_cur_hp_hi
	sta (ptr1),y
	lda #$00
	iny
	sta (ptr1),y
	jsr j_get_stats_ptr
	ldy #player_status
	lda #status_Good
	sta (ptr1),y
	ldy #player_intelligence
@inc_stat:
	jsr j_rand
	and #$07
	sed
	sec
	adc (ptr1),y
	cld
	cmp #stat_max + 1
	bcc @set_stat
	lda #stat_max
@set_stat:
	sta (ptr1),y
	dey
	cpy #player_strength
	bcs @inc_stat
	jsr print_newline
	jsr j_printname
	jsr j_primm
	.byte $8d
	.byte "THOU ART NOW", $8d
	.byte "LEVEL ", 0
	lda zp_level
	jsr j_printdigit
	jsr print_newline
	jsr j_invertview
	lda #sound_spell_effect
	ldx #$c0
	jsr j_playsfx
	jsr j_invertview
	jsr j_update_status
@already_at_level:
	dec curr_player
	beq @ask_me
	jmp @next

@ask_me:
	jsr j_primm
	.byte $8d
	.byte "WHAT WOULD THOU", $8d
	.byte "ASK OF ME?", $8d
	.byte 0
	jmp input_word

next_question:
	lda #music_hail_britannia
	jsr music_ctl
	jsr j_primm
	.byte $8d
	.byte "WHAT ELSE?", $8d
	.byte 0
input_word:
	jsr get_input
	jsr check_keywords
	bpl @keyword_matched
	jsr print_he_says
	jsr j_primm
	.byte "I CANNOT HELP", $8d
	.byte "THEE WITH THAT.", $8d
	.byte 0
	jmp next_question

@keyword_matched:
	asl
	tay
	lda keyword_handlers,y
	sta ptr1
	lda keyword_handlers+1,y
	sta ptr1 + 1
	jmp (ptr1)

keyword_handlers:
	.addr answer_bye
	.addr answer_bye
	.addr answer_name
	.addr answer_look
	.addr answer_job
	.addr answer_heal
	.addr answer_truth
	.addr answer_love
	.addr answer_courage
	.addr answer_honesty
	.addr answer_compassion
	.addr answer_valor
	.addr answer_justice
	.addr answer_sacrifice
	.addr answer_honor
	.addr answer_spirituality
	.addr answer_humility
	.addr answer_pride
	.addr answer_avatar
	.addr answer_quest
	.addr answer_britannia
	.addr answer_ankh
	.addr answer_help
	.addr answer_abyss
	.addr answer_mondain
	.addr answer_minax
	.addr answer_exodus
	.addr answer_virtue

print_lb_says:
	jsr j_primm
	.byte $8d
	.byte "LORD BRITISH", $8d
	.byte "SAYS: ", $8d
	.byte 0
	rts

print_he_says:
	jsr j_primm
	.byte $8d
	.byte "HE SAYS:", $8d
	.byte 0
	rts

print_he_asks:
	jsr j_primm
	.byte $8d
	.byte "HE ASKS:", $8d
	.byte 0
print_newline:
	lda #char_enter
	jsr j_console_out
	rts

ask_y_or_n:
	jsr get_input
	lda inbuffer
	cmp #char_Y
	beq @yes
	cmp #char_N
	beq @no
	jsr j_primm
	.byte $8d
	.byte "YES OR NO:", $8d
	.byte 0
	rts

	jmp ask_y_or_n

@yes:
	lda #$00
	rts

@no:
	lda #$01
	rts

answer_bye:
	jsr print_lb_says
	jsr j_primm
	.byte "FARE THEE", $8d
	.byte "WELL MY FRIEND", 0
	lda party_size
	cmp #$01
	bne @plural
	jsr j_primm
	.byte "!", $8d
	.byte 0
	jmp exit_conversation

@plural:
	jsr j_primm
	.byte "S!", $8d
	.byte 0
	jmp exit_conversation

answer_name:
	jsr print_he_says
	jsr j_primm
	.byte "MY NAME IS", $8d
	.byte "LORD BRITISH,", $8d
	.byte "SOVEREIGN OF", $8d
	.byte "ALL BRITANNIA!", $8d
	.byte 0
	jmp next_question

answer_look:
	jsr j_primm
	.byte "THOU SEE THE", $8d
	.byte "KING WITH THE", $8d
	.byte "ROYAL SCEPTRE.", $8d
	.byte 0
	jmp next_question

answer_job:
	jsr print_he_says
	jsr j_primm
	.byte "I RULE ALL", $8d
	.byte "BRITANNIA, AND", $8d
	.byte "SHALL DO MY BEST", $8d
	.byte "TO HELP THEE!", $8d
	.byte 0
	jmp next_question

answer_heal:
	jsr print_he_says
	jsr j_primm
	.byte "I AM WELL,", $8d
	.byte "THANK YE.", $8d
	.byte 0
	jsr print_he_asks
	jsr j_primm
	.byte "ART THOU WELL?", $8d
	.byte 0
	jsr ask_y_or_n
	bne @notwell
	jsr print_he_says
	jsr j_primm
	.byte "THAT IS GOOD.", $8d
	.byte 0
	jmp next_question

@notwell:
	jsr print_he_says
	jsr j_primm
	.byte "LET ME HEAL", $8d
	.byte "THY WOUNDS!", $8d
	.byte 0
	ldx #$14
	lda #sound_cast
	jsr j_playsfx
	jsr j_invertview
	lda #sound_spell_effect
	ldx #$c0
	jsr j_playsfx
	jsr j_invertview
	jsr restore_party_hp
	jsr j_update_status
	jmp next_question

answer_truth:
	jsr print_he_says
	jsr j_primm
	.byte "MANY TRUTHS CAN", $8d
	.byte "BE LEARNED AT", $8d
	.byte "THE LYCAEUM. IT", $8d
	.byte "LIES ON THE", $8d
	.byte "NORTHWESTERN", $8d
	.byte "SHORE OF VERITY", $8d
	.byte "ISLE!", $8d
	.byte 0
	jmp next_question

answer_love:
	jsr print_he_says
	jsr j_primm
	.byte "LOOK FOR THE", $8d
	.byte "MEANING OF LOVE", $8d
	.byte "AT EMPATH ABBEY.", $8d
	.byte "THE ABBEY SITS", $8d
	.byte "ON THE WESTERN", $8d
	.byte "EDGE OF THE DEEP", $8d
	.byte "FOREST!", $8d
	.byte 0
	jmp next_question

answer_courage:
	jsr print_he_says
	jsr j_primm
	.byte "SERPENT CASTLE", $8d
	.byte "ON THE ISLE OF", $8d
	.byte "DEEDS IS WHERE", $8d
	.byte "COURAGE SHOULD", $8d
	.byte "BE SOUGHT!", $8d
	.byte 0
	jmp next_question

answer_honesty:
	jsr print_he_says
	jsr j_primm
	.byte "THE FAIR TOWNE", $8d
	.byte "OF MOONGLOW ON", $8d
	.byte "DAGGER ISLE, IS", $8d
	.byte "WHERE THE VIRTUE", $8d
	.byte "OF HONESTY", $8d
	.byte "THRIVES!", $8d
	.byte 0
	jmp next_question

answer_compassion:
	jsr print_he_says
	jsr j_primm
	.byte "THE BARDS IN THE", $8d
	.byte "TOWNE OF BRITAIN", $8d
	.byte "ARE WELL VERSED", $8d
	.byte "IN THE VIRTUE OF", $8d
	.byte "COMPASSION!", $8d
	.byte 0
	jmp next_question

answer_valor:
	jsr print_he_says
	jsr j_primm
	.byte "MANY VALIANT", $8d
	.byte "FIGHTERS COME", $8d
	.byte "FROM JHELOM,", $8d
	.byte "IN THE VALARIAN", $8d
	.byte "ISLES!", $8d
	.byte 0
	jmp next_question

answer_justice:
	jsr print_he_says
	jsr j_primm
	.byte "IN THE CITY OF", $8d
	.byte "YEW, IN THE DEEP", $8d
	.byte "FOREST, JUSTICE", $8d
	.byte "IS SERVED!", $8d
	.byte 0
	jmp next_question

answer_sacrifice:
	jsr print_he_says
	jsr j_primm
	.byte "MINOC, TOWNE OF", $8d
	.byte "SELF-SACRIFICE,", $8d
	.byte "LIES ON THE", $8d
	.byte "EASTERN SHORES", $8d
	.byte "OF LOST HOPE", $8d
	.byte "BAY!", $8d
	.byte 0
	jmp next_question

answer_honor:
	jsr print_he_says
	jsr j_primm
	.byte "THE PALADINS WHO", $8d
	.byte "STRIVE FOR HONOR", $8d
	.byte "ARE OFT SEEN IN", $8d
	.byte "TRINSIC, NORTH", $8d
	.byte "OF THE CAPE OF", $8d
	.byte "HEROES!", $8d
	.byte 0
	jmp next_question

answer_spirituality:
	jsr print_he_says
	jsr j_primm
	.byte "IN SKARA BRAE", $8d
	.byte "THE SPIRITUAL", $8d
	.byte "PATH IS TAUGHT,", $8d
	.byte "FIND IT ON AN", $8d
	.byte "ISLE NEAR", $8d
	.byte "SPIRITWOOD!", $8d
	.byte 0
	jmp next_question

answer_humility:
	jsr print_he_says
	jsr j_primm
	.byte "HUMILITY IS THE", $8d
	.byte "FOUNDATION OF", $8d
	.byte "VIRTUE! THE", $8d
	.byte "RUINS OF PROUD", $8d
	.byte "MAGINCIA ARE A", $8d
	.byte "TESTIMONY UNTO", $8d
	.byte "THE VIRTUE OF", $8d
	.byte "HUMILITY!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
	.byte $8d
	.byte "FIND THE RUINS", $8d
	.byte "OF MAGINCIA FAR", $8d
	.byte "OFF THE SHORES", $8d
	.byte "OF BRITANNIA,", $8d
	.byte "ON A SMALL ISLE", $8d
	.byte "IN THE VAST", $8d
	.byte "OCEAN!", $8d
	.byte 0
	jmp next_question

answer_pride:
	jsr print_he_says
	jsr j_primm
	.byte "OF THE EIGHT", $8d
	.byte "COMBINATIONS OF", $8d
	.byte "TRUTH, LOVE AND", $8d
	.byte "COURAGE, THAT", $8d
	.byte "WHICH CONTAINS", $8d
	.byte "NEITHER TRUTH,", $8d
	.byte "LOVE NOR COURAGE", $8d
	.byte "IS PRIDE.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
	.byte $8d
	.byte "PRIDE BEING NOT", $8d
	.byte "A VIRTUE MUST BE", $8d
	.byte "SHUNNED IN FAVOR", $8d
	.byte "OF HUMILITY, THE", $8d
	.byte "VIRTUE WHICH IS", $8d
	.byte "THE ANTITHESIS", $8d
	.byte "OF PRIDE!", $8d
	.byte 0
	jmp next_question

answer_avatar:
	jsr print_lb_says
	jsr j_primm
	.byte "TO BE AN AVATAR", $8d
	.byte "IS TO BE THE", $8d
	.byte "EMBODIMENT OF", $8d
	.byte "THE EIGHT", $8d
	.byte "VIRTUES.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
	.byte $8d
	.byte "IT IS TO LIVE A", $8d
	.byte "LIFE CONSTANTLY", $8d
	.byte "AND FOREVER IN", $8d
	.byte "THE QUEST TO", $8d
	.byte "BETTER THYSELF", $8d
	.byte "AND THE WORLD IN", $8d
	.byte "WHICH WE LIVE.", $8d
	.byte 0
	jmp next_question

answer_quest:
	jsr print_lb_says
	jsr j_primm
	.byte "THE QUEST OF", $8d
	.byte "THE AVATAR IS", $8d
	.byte "IS TO KNOW AND", $8d
	.byte "BECOME THE", $8d
	.byte "EMBODIMENT OF", $8d
	.byte "THE EIGHT", $8d
	.byte "VIRTUES OF", $8d
	.byte "GOODNESS!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
	.byte $8d
	.byte "IT IS KNOWN THAT", $8d
	.byte "ALL WHO TAKE ON", $8d
	.byte "THIS QUEST MUST", $8d
	.byte "PROVE THEMSELVES", $8d
	.byte "BY CONQUERING", $8d
	.byte "THE ABYSS AND", $8d
	.byte "VIEWING THE", $8d
	.byte "CODEX OF", $8d
	.byte "ULTIMATE WISDOM!", $8d
	.byte 0
	jmp next_question

answer_britannia:
	jsr print_he_says
	jsr j_primm
	.byte "EVEN THOUGH THE", $8d
	.byte "GREAT EVIL LORDS", $8d
	.byte "HAVE BEEN ROUTED", $8d
	.byte "EVIL YET REMAINS", $8d
	.byte "IN BRITANNIA.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
	.byte $8d
	.byte "IF BUT ONE SOUL", $8d
	.byte "COULD COMPLETE", $8d
	.byte "THE QUEST OF THE", $8d
	.byte "AVATAR, OUR", $8d
	.byte "PEOPLE WOULD", $8d
	.byte "HAVE A NEW HOPE,", $8d
	.byte "A NEW GOAL FOR", $8d
	.byte "LIFE.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
	.byte $8d
	.byte "THERE WOULD BE A", $8d
	.byte "SHINING EXAMPLE", $8d
	.byte "THAT THERE IS", $8d
	.byte "MORE TO LIFE", $8d
	.byte "THAN THE ENDLESS", $8d
	.byte "STRUGGLE FOR", $8d
	.byte "POSSESSIONS", $8d
	.byte "AND GOLD!", $8d
	.byte 0
	jmp next_question

answer_ankh:
	jsr print_he_says
	jsr j_primm
	.byte "THE ANKH IS THE", $8d
	.byte "SYMBOL OF ONE", $8d
	.byte "WHO STRIVES FOR", $8d
	.byte "VIRTUE, KEEP IT", $8d
	.byte "WITH THEE AT", $8d
	.byte "TIMES FOR BY", $8d
	.byte "THIS MARK THOU", $8d
	.byte "SHALT BE KNOWN!", $8d
	.byte 0
	jmp next_question

answer_help:
	lda #music_off
	jsr music_ctl
	jsr j_primm_cout
	.byte $84,"BRUN HELP,A$8800", $8d
	.byte 0

answer_abyss:
	jsr print_he_says
	jsr j_primm
	.byte "THE GREAT", $8d
	.byte "STYGIAN ABYSS", $8d
	.byte "IS THE DARKEST", $8d
	.byte "POCKET OF EVIL", $8d
	.byte "REMAINING IN", $8d
	.byte "BRITANNIA!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
	.byte $8d
	.byte "IT IS SAID THAT", $8d
	.byte "IN THE DEEPEST", $8d
	.byte "RECESSES OF THE", $8d
	.byte "ABYSS IS THE", $8d
	.byte "CHAMBER OF THE", $8d
	.byte "CODEX!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
	.byte $8d
	.byte "IT IS ALSO SAID", $8d
	.byte "THAT ONLY ONE OF", $8d
	.byte "HIGHEST VIRTUE", $8d
	.byte "MAY ENTER THIS", $8d
	.byte "CHAMBER, ONE", $8d
	.byte "SUCH AS AN", $8d
	.byte "AVATAR!!!", $8d
	.byte 0
	jmp next_question

answer_mondain:
	jsr print_he_says
	jsr j_primm
	.byte "MONDAIN IS DEAD!", $8d
	.byte 0
	jmp next_question

answer_minax:
	jsr print_he_says
	jsr j_primm
	.byte "MINAX IS DEAD!", $8d
	.byte 0
	jmp next_question

answer_exodus:
	jsr print_he_says
	jsr j_primm
	.byte "EXODUS IS DEAD!", $8d
	.byte 0
	jmp next_question

answer_virtue:
	jsr print_he_says
	jsr j_primm
	.byte "THE EIGHT", $8d
	.byte "VIRTUES OF THE", $8d
	.byte "AVATAR ARE:", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
	.byte "HONESTY,", $8d
	.byte "COMPASSION,", $8d
	.byte "VALOR,", $8d
	.byte "JUSTICE,", $8d
	.byte "SACRIFICE,", $8d
	.byte "HONOR,", $8d
	.byte "SPIRITUALITY,", $8d
	.byte "AND HUMILITY!", $8d
	.byte 0
	jmp next_question

lb_intro:
	jsr j_primm
	.byte "LORD BRITISH", $8d
	.byte "RISES AND SAYS", $8d
	.byte "AT LONG LAST!", $8d
	.byte 0
	lda #$01
	sta curr_player
	jsr j_printname
	jsr j_primm
	.byte $8d
	.byte "THOU HAST COME!", $8d
	.byte "WE HAVE WAITED", $8d
	.byte "SUCH A LONG,", $8d
	.byte "LONG TIME...", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
	.byte $8d
	.byte "LORD BRITISH", $8d
	.byte "SITS AND SAYS:", $8d
	.byte "A NEW AGE IS", $8d
	.byte "UPON BRITANNIA.", $8d
	.byte "THE GREAT EVIL", $8d
	.byte "LORDS ARE GONE", $8d
	.byte "BUT OUR PEOPLE", $8d
	.byte "LACK DIRECTION", $8d
	.byte "AND PURPOSE IN", $8d
	.byte "THEIR LIVES...", 0
	jsr j_waitkey
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "A CHAMPION OF", $8d
	.byte "VIRTUE IS CALLED", $8d
	.byte "FOR. THOU MAY BE", $8d
	.byte "THIS CHAMPION,", $8d
	.byte "BUT ONLY TIME", $8d
	.byte "SHALL TELL. I", $8d
	.byte "WILL AID THEE", $8d
	.byte "ANY WAY THAT I", $8d
	.byte "CAN!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
	.byte $8d
	.byte "HOW MAY I", $8d
	.byte "HELP THEE?", $8d
	.byte 0
	jmp input_word

keywords:
	.byte "    "
	.byte "BYE "
	.byte "NAME"
	.byte "LOOK"
	.byte "JOB "
	.byte "HEAL"
	.byte "TRUT"
	.byte "LOVE"
	.byte "COUR"
	.byte "HONE"
	.byte "COMP"
	.byte "VALO"
	.byte "JUST"
	.byte "SACR"
	.byte "HONO"
	.byte "SPIR"
	.byte "HUMI"
	.byte "PRID"
	.byte "AVAT"
	.byte "QUES"
	.byte "BRIT"
	.byte "ANKH"
	.byte "HELP"
	.byte "ABYS"
	.byte "MOND"
	.byte "MINA"
	.byte "EXOD"
	.byte "VIRT"
	.byte 0, 0, 0, 0

check_keywords:
	lda #$00
	sta zp_index
@start_keyword:
	lda zp_index
	asl
	asl
	tay
	ldx #$00
@next_char:
	lda keywords,y
	beq @not_found
	cmp inbuffer,x
	bne @next_keyword
	iny
	inx
	cpx #$04
	bcc @next_char
	lda zp_index
	rts

@next_keyword:
	inc zp_index
	jmp @start_keyword

@not_found:
	lda #$ff
	rts

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

; unused
match_input_inline:
	pla
	sta ptr1
	pla
	sta ptr1 + 1
	ldy #$00
	sty zp_mismatches
	ldx #$ff
@next_char:
	inx
	inc ptr1
	bne :+
	inc ptr1 + 1
:	lda (ptr1),y
	beq @end
	cmp inbuffer,x
	beq @next_char
	inc zp_mismatches
	jmp @next_char

@end:
	lda ptr1 + 1
	pha
	lda ptr1
	pha
	lda zp_mismatches
	rts

restore_party_hp:
	lda party_size
	sta curr_player
@next:
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Dead
	beq @skip
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
@skip:
	dec curr_player
	bne @next
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

exit_conversation:
	rts

; junk
	.byte $02
