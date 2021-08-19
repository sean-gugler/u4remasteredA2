	.include "uscii.i"

	.include "apple.i"
	.include "char.i"
	.include "cstring.i"
	.include "disks.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "jump_system.i"
	.include "music.i"
	.include "super_packer.i"
	.include "tables.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


; Placeholder operands that get altered
; by self-modifying code.

TMP_ADDR = $ffff


; --- Custom use of Zero Page

zp_input_index = $ea

; No conflict with X,Y coords because
; game_mode == mode_suspended

end_left = $f9
end_right = $fa
cur_row = $fb


; --- Configure Super-Packer

max_spk_col = $16
max_spk_row = $b7

min_spk_col = $00
min_spk_row = $07


	.segment "OVERLAY"

.assert * = j_overlay_entry, error, "Wrong start address"
	bit hw_LCBANK1
	bit hw_LCBANK1
	jsr j_primm_cout
	.byte $84,"BLOAD CSTRING,A$4000", $8d
	.byte 0
	lda party_size
	sta save_party_size
	lda #$01
	sta party_size
	lda #mode_suspended
	sta game_mode
	jsr j_update_status
	jsr j_clearview
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte $8d
	.byte "There is a", $8d
	.byte "sudden darkness,", $8d
	.byte "and you find", $8d
	.byte "yourself alone", $8d
	.byte "in an empty", $8d
	.byte "chamber.", $8d
	.byte 0
	lda #$04
	jsr delay
	lda #spk_LOCK
	jsr draw_spk
	lda threepartkey
	and #key3_have_all
	cmp #key3_have_all
	beq @have_three_part_key
	jsr j_primm
	.byte $8d
	.byte "Thou dost not", $8d
	.byte "have the key of", $8d
	.byte "three parts.", $8d
	.byte 0
	lda #$0c     ;abyss
	jmp return_to_world

@have_three_part_key:
	jsr j_primm
	.byte $8d
	.byte "You use your", $8d
	.byte "key of three", $8d
	.byte "parts.", $8d
	.byte 0
	lda #$03
	jsr delay
	jsr j_primm
	.byte $8d
	.byte "A voice rings", $8d
	.byte "out, 'What is", $8d
	.byte "the Word of", $8d
	.byte "Passage?'", $8d
	.byte $8d
	.byte 0
	jsr get_input
	jsr match_input_inline
	.byte "VERAMOCOR", 0
	php
	lda #$03
	jsr delay
	plp
	bne @denied
	lda save_party_size
	cmp #$08
	beq @check_virtues
	jsr j_primm
	.byte $8d
	.byte "Thou hast not", $8d
	.byte "proved thy", $8d
	.byte "leadership in", $8d
	.byte "all eight", $8d
	.byte "virtues.", $8d
	.byte 0
	lda #$08
	jsr delay
	jmp @denied

@check_virtues:
	ldy #$07
:	lda party_stats,y
	bne @not_avatar
	dey
	bpl :-
	bmi @granted
@not_avatar:
	jsr j_primm
	.byte $8d
	.byte "Thou art not", $8d
	.byte "ready.", $8d
	.byte 0
@denied:
	jsr j_primm
	.byte $8d
	.byte "Passage is not", $8d
	.byte "granted.", $8d
	.byte 0
	lda #$0c     ;abyss
	jmp return_to_world

@granted:
	jsr j_primm
	.byte $8d
	.byte "Passage is", $8d
	.byte "granted.", $8d
	.byte 0
	lda #$05
	jsr delay
	jsr j_clearview
	lda #$01
	sta question_number
@ask_question:
	jsr voice_asks
	beq @correct
	jsr j_primm
	.byte $8d
	.byte "Thy quest is not", $8d
	.byte "yet complete.", $8d
	.byte 0
	dec question_number
	lda question_number
	jmp return_to_world

@correct:
	ldx question_number
	dex
	txa
	jsr draw_spk
	inc question_number
	lda question_number
	cmp #$09
	bne @next_question
	lda #$03
	jsr delay
	jsr j_primm
	.byte $8d
	.byte "The voice says:", $8d
	.byte 0
	lda #$03
	jsr delay
	jsr j_primm
	.byte $8d
	.byte "Thou art well", $8d
	.byte "versed in the", $8d
	.byte "virtues of the", $8d
	.byte "Avatar.", $8d
	.byte 0
	lda #$05
	jsr delay
	jmp @ask_question

@next_question:
	cmp #$0c
	bcs @ask_final_question
	jmp @ask_question

@ask_final_question:
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "The floor", $8d
	.byte "rumbles beneath", $8d
	.byte "your feet.", $8d
	.byte 0
	jsr shake_screen
	jsr shake_screen
	lda #$05
	jsr delay
	jsr j_primm
	.byte $8d
	.byte "Above the din,", $8d
	.byte "the voice asks:", $8d
	.byte 0
	lda question_number
	jsr print_string
	jsr waitkey
	inc question_number ;skip unused answer "SELF"
	jsr input_answer
	beq game_over_win
	jsr j_primm
	.byte $8d
	.byte "Thou dost not", $8d
	.byte "know the true", $8d
	.byte "nature of the", $8d
	.byte "Universe.", $8d
	.byte 0
	lda #$0b     ;castle Britannia
	jmp return_to_world

game_over_win:
	lda #$02
	jsr delay
	jsr shake_screen
	jsr shake_screen
	jsr shake_screen
	jsr shake_screen
	lda #$03
	jsr delay
	jsr anim_open_door
	lda #$03
	jsr delay
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "The boundless", $8d
	.byte "knowledge of the", $8d
	.byte "Codex of", $8d
	.byte "Ultimate Wisdom", $8d
	.byte "is revealed unto", $8d
	.byte "thee.", 0
	lda #music_British
	jsr music_ctl
	jsr waitkey
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "The voice says:", $8d
	.byte "Thou hast proven", $8d
	.byte "thyself to be", $8d
	.byte "truly good in", $8d
	.byte "nature.", 0
	jsr waitkey
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "Thou must know", $8d
	.byte "that thy quest", $8d
	.byte "to become an", $8d
	.byte "Avatar is the", $8d
	.byte "endless quest of", $8d
	.byte "a lifetime.", 0
	jsr waitkey
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "Avatarhood is a", $8d
	.byte "living gift. It", $8d
	.byte "must always and", $8d
	.byte "forever be", $8d
	.byte "nurtured to", $8d
	.byte "flourish.", 0
	jsr waitkey
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "For if thou dost", $8d
	.byte "stray from the", $8d
	.byte "paths of virtue,", $8d
	.byte "thy way may be", $8d
	.byte "lost forever.", 0
	jsr waitkey
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "Return now unto", $8d
	.byte "thine own world,", $8d
	.byte "live there as an", $8d
	.byte "example to thy", $8d
	.byte "people, as our", $8d
	.byte "memory of thy", $8d
	.byte "gallant deeds", $8d
	.byte "serves us.", 0
	jsr waitkey
	jsr j_clearview
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "As the sound of", $8d
	.byte "the voice trails", $8d
	.byte "off, darkness", $8d
	.byte "seems to rise", $8d
	.byte "around you.", $8d
	.byte "There is a", $8d
	.byte "moment of", $8d
	.byte "intense, ", $8d
	.byte "wrenching", $8d
	.byte "vertigo.", 0
	jsr waitkey
	lda #spk_WIN
	jsr draw_spk
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "You open your", $8d
	.byte "eyes to a", $8d
	.byte "familiar circle", $8d
	.byte "of stones. You", $8d
	.byte "wonder of your", $8d
	.byte "recent", $8d
	.byte "adventures.", 0
	jsr waitkey
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "It seems a time", $8d
	.byte "and place very", $8d
	.byte "distant. You", $8d
	.byte "wonder if it", $8d
	.byte "really happened.", $8d
	.byte "Then you realize", $8d
	.byte "that in your", $8d
	.byte "hand you hold", $8d
	.byte "The Ankh.", 0
	jsr waitkey
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "You walk away", $8d
	.byte "from the circle,", $8d
	.byte "knowing that", $8d
	.byte "you can always", $8d
	.byte "return from", $8d
	.byte "whence you came,", $8d
	.byte "since you now", $8d
	.byte "know the secret", $8d
	.byte "of the gates.", 0
	jsr waitkey
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "CONGRATULATIONS!", $8d
	.byte "   Thou hast", $8d
	.byte "   completed", $8d
	.byte "   ULTIMA IV", $8d
	.byte "  Quest of the", $8d
	.byte "     AVATAR", $8d
	.byte "  in ", 0
	lda #$00
	sta leading_spaces
	lda move_counter
	jsr print_bcd
	lda move_counter + 1
	jsr print_bcd
	lda move_counter + 2
	jsr print_bcd
	lda move_counter + 3
	jsr print_bcd
	jsr j_primm
	.byte $8d
	.byte " turns! Report", $8d
	.byte " thy feat unto", $8d
	.byte "Lord British at", $8d
	.byte "Origin Systems!", 0
halt:
	jmp halt

leading_spaces:
	.byte 0

print_bcd:
	pha
	lsr
	lsr
	lsr
	lsr
	jsr print_digit
	pla
	and #$0f
print_digit:
	cmp #$00
	bne @end_spaces
	ldx leading_spaces
	bne @allow_zeroes
	lda #char_space
	bne @print
@end_spaces:
	inc leading_spaces
@allow_zeroes:
	clc
	adc #char_num_first
@print:
	jsr j_console_out
	rts

return_to_world:
	pha
	lda #$05
	jsr delay
	jsr j_primm
	.byte $8d
	.byte 0
	lda #disk_program
	jsr insert_disk
	jsr j_primm_cout
	.byte $84, "BLOADU",$81,"LT4,A$4000", $8d
	.byte 0
	lda #disk_britannia
	jsr j_request_disk
	pla
	tay
	lda world_location_y,y
	sta player_ypos
	lda world_location_x,y
	sta player_xpos
	lda save_party_size
	sta party_size
	lda #loc_world
	sta current_location
	lda #mode_world
	sta game_mode
	jsr j_player_teleport
	jmp j_game_init

world_location_x:
	.byte $e7,$53,$23,$3b,$9e,$69,$17,$ba
	.byte $d8,$1d,$91,$59,$e9
world_location_y:
	.byte $88,$69,$dd,$2c,$15,$b7,$81,$ac
	.byte $6a,$30,$f3,$6a,$e9

insert_disk:
	sta reqdisk
@check_disk:
	lda reqdisk
	cmp #disk_britannia
	beq @drive2
	cmp #disk_dungeon
	beq @drive2
@drive1:
	lda #$01
	sta currdrive
	lda reqdisk
	cmp currdisk_drive1
	beq @load_disk_id
@print_prompt:
	jsr j_primm
	.byte $8d
	.byte "PLEASE PLACE THE", $8d
	.byte "ULTIMA DISK", $8d
	.byte "INTO DRIVE ", 0
	lda currdrive
	jsr j_printdigit
	jsr j_primm
	.byte $8d
	.byte "AND PRESS [ESC]", $8d
	.byte 0
:	jsr j_waitkey
	cmp #char_ESC
	bne :-
	beq @load_disk_id
@drive2:
	lda numdrives
	cmp #$02
	bcc @drive1
	lda #$02
	sta currdrive
	lda reqdisk
	cmp currdisk_drive2
	beq @load_disk_id
	bne @print_prompt
@load_disk_id:
	lda currdrive
	clc
	adc #char_num_first
	sta @drive_number
	jsr j_primm_cout
	.byte $84, "BLOADD",$81,"ISK,D"
@drive_number:
	.byte "1", $8d
	.byte 0
	ldx currdrive
	lda disk_id
	sta numdrives,x
	cmp reqdisk
	beq @ok
	jmp @check_disk

@ok:
	rts

voice_asks:
	lda #$02
	jsr delay
	jsr j_primm
	.byte $8d
	.byte $8d
	.byte "The voice asks:", $8d
	.byte 0
input_answer:
	lda #$02
	jsr delay
	lda question_number
	jsr print_string
	jsr get_input
	lda question_number
	sec
	sbc #$01
	asl
	asl
	clc
	adc #<answer_table
	sta ptr1
	lda #>answer_table
	adc #$00
	sta ptr1 + 1
	ldy #$03
@copy_keyword:
	lda (ptr1),y
	sta keyword_compare,y
	dey
	bpl @copy_keyword
	jsr match_input_inline
keyword_compare:
	.byte $00,$00,$00,$00
	.byte 0
	rts

answer_table:
	.byte "HONE"
	.byte "COMP"
	.byte "VALO"
	.byte "JUST"
	.byte "SACR"
	.byte "HONO"
	.byte "SPIR"
	.byte "HUMI"
	.byte "TRUT"
	.byte "LOVE"
	.byte "COUR"
	.byte "SELF"   ; unused
	.byte "INFI"

waitkey:
	jsr j_waitkey
	bpl waitkey
	rts

save_party_size:
	.byte 0
question_number:
	.byte 0

delay:
	sta ptr1
@count:
	ldy #$c0
@outer:
	ldx #$ff
@inner:
	pha
	pla
	dex
	bne @inner
	dey
	bne @outer
	dec ptr1
	bne @count
	rts

match_input_inline:
	lda #$00
	sta @mismatch
	pla
	sta @ptr
	pla
	sta @ptr + 1
	ldx #$ff
@next:
	inc @ptr
	bne :+
	inc @ptr + 1
:	inx
@ptr = * + $01
	lda TMP_ADDR
	beq @done
	cmp inbuffer,x
	beq @next
	lda #$01
	sta @mismatch
	bne @next
@done:
	lda @ptr + 1
	pha
	lda @ptr
	pha
	lda @mismatch
	rts

@mismatch:
	.byte 0

get_input:
	lda #$00
	sta zp_input_index
	lda #char_question
	jsr j_console_out
@get_char:
	jsr waitkey
	cmp #char_enter
	beq @got_input
	cmp #char_left_arrow
	beq @backspace
	cmp #char_space
	bcc @get_char
	ldx zp_input_index
	cpx #$0e
	beq @get_char
	sta inbuffer,x
	jsr j_console_out
	inc zp_input_index
	jmp @get_char

@backspace:
	lda zp_input_index
	beq @get_char
	dec zp_input_index
	lda #char_space
	jsr j_console_out
	dec console_xpos
	dec console_xpos
	lda #char_space
	jsr j_console_out
	dec console_xpos
	jmp @get_char

@got_input:
	ldx zp_input_index
	beq @get_char
	lda #$00
@pad_zeroes:
	sta inbuffer,x
	inx
	cpx #$0f
	bcc @pad_zeroes
	lda #char_enter
	jsr j_console_out
	rts

shake_screen:
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

print_string:
	tay
	lda #<string_table
	sta ptr1
	lda #>string_table
	sta ptr1 + 1
	ldx #$00
@next_char:
	lda (ptr1,x)
	beq @end_string
@next_string:
	jsr inc_ptr
	jmp @next_char

@end_string:
	dey
	beq @print_char
	jmp @next_string

@print_char:
	jsr inc_ptr
	ldx #$00
	lda (ptr1,x)
	beq @done
	jsr j_console_out
	jmp @print_char

@done:
	rts

inc_ptr:
	inc ptr1
	bne :+
	inc ptr1 + 1
:	rts

anim_open_door:
	ldx #$b7
@next_row:
	jsr set_ptr2_line
	ldy #$0b
	lda (ptr2),y
	ora #$60     ;left door edge
	sta (ptr2),y
	iny
	lda (ptr2),y
	ora #$03     ;right door edge
	sta (ptr2),y
	dex
	cpx #$07
	bne @next_row
begin_scroll:
	lda #<cstring_addr
	sta ptr1
	lda #>cstring_addr
	sta ptr1 + 1
	lda #$0c
	sta end_left
	lda #$0b
	sta end_right
@next_scroll:
	ldx #$b7
@next_row:
	stx cur_row
	jsr set_ptr2_line
	ldy #$02
@scroll_left_out:
	lda (ptr2),y
	dey
	sta (ptr2),y
	iny
	iny
	cpy end_left
	bne @scroll_left_out
	dey
	jsr next_ptr1
	sta (ptr2),y
	ldy #$15
@scroll_right_out:
	lda (ptr2),y
	iny
	sta (ptr2),y
	dey
	dey
	cpy end_right
	bne @scroll_right_out
	iny
	jsr next_ptr1
	sta (ptr2),y
	ldx cur_row
	dex
	cpx #$07
	bne @next_row
	ldy #$ff
@delay:
	ldx #$ff
:	dex
	bne :-
	dey
	bne @delay
	inc end_right
	dec end_left
	lda end_left
	cmp #$02
	beq end_scroll
	jmp @next_scroll

end_scroll:
	ldx #$b7
@next_row:
	stx cur_row
	jsr set_ptr2_line
	jsr next_ptr1
	ldy #$01
	sta (ptr2),y
	jsr next_ptr1
	ldy #$16
	sta (ptr2),y
	ldx cur_row
	dex
	cpx #$07
	bne @next_row
	rts

next_ptr1:
	ldx #$00
	lda (ptr1,x)
	inc ptr1
	bne :+
	inc ptr1 + 1
:	rts

set_ptr2_line:
	lda bmplineaddr_hi,x
	sta ptr2 + 1
	lda bmplineaddr_lo,x
	sta ptr2
	rts

	.byte "SUPER UNPACKER COPYRIGHT 1983 BY STEVEN MEUSE"
draw_spk:
	asl
	tax
	lda spk_addr_table + 1,x
	sta ptr2 + 1
	lda spk_addr_table,x
	sta ptr2
	ldx #$00
	stx spk_repeat_flag
	stx spk_pattern_flag
	stx spk_pattern_len_cur
	lda (ptr2,x)
	sta spk_repeat_code
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda (ptr2,x)
	sta spk_pattern_code
	inc ptr2
	ldy #max_spk_col
@next_col:
	ldx #max_spk_row
	stx spk_row
@next_row:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	jsr spk_write_byte
	dec spk_row
	ldx spk_row
	cpx #min_spk_row
	bne @next_row
	dey
	cpy #min_spk_col
	bne @next_col
	rts

spk_write_byte:
	ldx #$00
	bit spk_repeat_flag
	bmi @do_repeat
	bit spk_pattern_flag
	bmi @do_pattern
@read_byte:
	lda (ptr2,x)
	sta spk_byte
	cmp spk_repeat_code
	bne @check_pattern
@set_repeat:
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda (ptr2,x)
	sta spk_repeat_count
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda (ptr2,x)
	sta spk_byte
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda #$80
	sta spk_repeat_flag
	bne @do_repeat
@check_pattern:
	cmp spk_pattern_code
	bne @do_literal
@set_pattern:
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda (ptr2,x)
	sta spk_pattern_length
	sta spk_pattern_len_cur
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda (ptr2,x)
	sta spk_pattern_count
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda ptr2
	sta spk_pattern_ptr
	lda ptr2 + 1
	sta spk_pattern_ptr+1
	lda #$80
	sta spk_pattern_flag
	bne @do_pattern
@do_literal:
	lda spk_byte
	ora (ptr1),y
	sta (ptr1),y
	inc ptr2
	bne @continue
	inc ptr2 + 1
@continue:
	rts

@do_repeat:
	lda spk_byte
	ora (ptr1),y
	sta (ptr1),y
	dec spk_repeat_count
	bne @continue
	lda #$00
	sta spk_repeat_flag
	bit spk_pattern_flag
	bpl @continue
	dec spk_pattern_len_cur
	dec spk_pattern_len_cur
	bne @next_pattern
@do_pattern:
	lda (ptr2,x)
	cmp spk_repeat_code
	bne @pattern_literal
	lda spk_pattern_len_cur
:	bne @set_repeat
@dead_code:
	lda spk_pattern_ptr
	sta ptr2
	lda spk_pattern_ptr+1
	sta ptr2 + 1
	bne :-
@pattern_literal:
	ora (ptr1),y
	sta (ptr1),y
	inc ptr2
	bne @next_pattern
	inc ptr2 + 1
@next_pattern:
	dec spk_pattern_len_cur
	bne @continue
	lda spk_pattern_length
	sta spk_pattern_len_cur
	dec spk_pattern_count
	beq @pattern_done
	lda spk_pattern_ptr
	sta ptr2
	lda spk_pattern_ptr+1
	sta ptr2 + 1
	rts

@pattern_done:
	lda #$00
	sta spk_pattern_flag
	rts

spk_addr_table:
	.addr spk_addr_00
	.addr spk_addr_01
	.addr spk_addr_02
	.addr spk_addr_03
	.addr spk_addr_04
	.addr spk_addr_05
	.addr spk_addr_06
	.addr spk_addr_07
	.addr spk_addr_08
	.addr spk_addr_09
	.addr spk_addr_0a
	.addr spk_addr_0b
	.addr spk_addr_0c

string_table:
; STRING $00 (0)
	.byte 0
; STRING $01 (1)
	.byte $8d
	.byte "What dost thou", $8d
	.byte "possess if all", $8d
	.byte "may rely upon", $8d
	.byte "your every word?", $8d
	.byte 0
; STRING $02 (2)
	.byte $8d
	.byte "What quality", $8d
	.byte "compels one to", $8d
	.byte "share in the", $8d
	.byte "journeys of", $8d
	.byte "others?", $8d
	.byte 0
; STRING $03 (3)
	.byte $8d
	.byte "What answers", $8d
	.byte "when great deeds", $8d
	.byte "are called for?", $8d
	.byte 0
; STRING $04 (4)
	.byte $8d
	.byte "What should be", $8d
	.byte "the same for", $8d
	.byte "Lord and Serf", $8d
	.byte "alike?", $8d
	.byte 0
; STRING $05 (5)
	.byte $8d
	.byte "What is loath", $8d
	.byte "to place the", $8d
	.byte "self above aught", $8d
	.byte "else?", $8d
	.byte 0
; STRING $06 (6)
	.byte $8d
	.byte "What shirks no", $8d
	.byte "duty?", $8d
	.byte 0
; STRING $07 (7)
	.byte $8d
	.byte "What, in knowing", $8d
	.byte "the true self,", $8d
	.byte "knows all?", $8d
	.byte 0
; STRING $08 (8)
	.byte $8d
	.byte "What is that", $8d
	.byte "which Serfs are", $8d
	.byte "born with but", $8d
	.byte "Nobles must", $8d
	.byte "strive to", $8d
	.byte "obtain?", $8d
	.byte 0
; STRING $09 (9)
	.byte $8d
	.byte "If all else is", $8d
	.byte "imaginary, this", $8d
	.byte "is real...", $8d
	.byte 0
; STRING $0A (10)
	.byte $8d
	.byte "What plunges to", $8d
	.byte "the depths,", $8d
	.byte "while soaring on", $8d
	.byte "the heights?", $8d
	.byte 0
; STRING $0B (11)
	.byte $8d
	.byte "What turns not", $8d
	.byte "away from any", $8d
	.byte "peril?", $8d
	.byte 0
; STRING $0C (12)
	.byte $8d
	.byte "If all eight", $8d
	.byte "virtues of the", $8d
	.byte "Avatar combine", $8d
	.byte "into and are", $8d
	.byte "derived from the", $8d
	.byte "three principles", $8d
	.byte "of Truth, Love,", $8d
	.byte "and Courage...", 0
; STRING $0D (13)
	.byte $8d
	.byte $8d
	.byte "then what is the", $8d
	.byte "one thing which", $8d
	.byte "encompasses and", $8d
	.byte "is the whole of", $8d
	.byte "all undeniable", $8d
	.byte "Truth, unending", $8d
	.byte "Love, and", $8d
	.byte "unyielding", $8d
	.byte "Courage?", $8d
	.byte 0

; junk - insights into SUPER UNPACKER source code!
; 
;     BL   $B0
;BYTE      $B2
;PATLEN    $B3
;REPCODE   $B4
;PATCODE   $B5
;Y         $B6
;REPCOUNT  $B7
;REPFLAG   $B8
;PATCOUNT  $B9
;PATFLAG   $BA
;PATLEN2   $BB
;
;STRING    $4000
; 
;UNPACK  :
;×
;OFFSETS+1,X
;DATAPTR+1
;OF
	.byte $42,$4c,$20,$dc,$20,$24,$42,$30
	.byte $0d,$20,$0f,$42,$59,$54,$45,$20
	.byte $20,$20,$20,$dc,$20,$24,$42,$32
	.byte $0d,$20,$0f,$50,$41,$54,$4c,$45
	.byte $4e,$20,$20,$dc,$20,$24,$42,$33
	.byte $0d,$20,$0f,$52,$45,$50,$43,$4f
	.byte $44,$45,$20,$dc,$20,$24,$42,$34
	.byte $0d,$20,$0f,$50,$41,$54,$43,$4f
	.byte $44,$45,$20,$dc,$20,$24,$42,$35
	.byte $0d,$20,$0f,$59,$20,$20,$20,$20
	.byte $20,$20,$20,$dc,$20,$24,$42,$36
	.byte $0d,$20,$0f,$52,$45,$50,$43,$4f
	.byte $55,$4e,$54,$dc,$20,$24,$42,$37
	.byte $0d,$20,$0f,$52,$45,$50,$46,$4c
	.byte $41,$47,$20,$dc,$20,$24,$42,$38
	.byte $0d,$20,$0f,$50,$41,$54,$43,$4f
	.byte $55,$4e,$54,$dc,$20,$24,$42,$39
	.byte $0d,$20,$0f,$50,$41,$54,$46,$4c
	.byte $41,$47,$20,$dc,$20,$24,$42,$41
	.byte $0d,$20,$0f,$50,$41,$54,$4c,$45
	.byte $4e,$32,$20,$dc,$20,$24,$42,$42
	.byte $0d,$20,$03,$3b,$0d,$20,$11,$53
	.byte $54,$52,$49,$4e,$47,$20,$20,$d9
	.byte $20,$24,$34,$30,$30,$30,$0d,$20
	.byte $03,$3b,$0d,$20,$03,$3b,$0d,$20
	.byte $0a,$55,$4e,$50,$41,$43,$4b,$20
	.byte $20,$3a,$0d,$04,$d7,$00,$0d,$20
	.byte $04,$ac,$00,$0d,$20,$0f,$cd,$06
	.byte $4f,$46,$46,$53,$45,$54,$53,$2b
	.byte $31,$2c,$58,$0d,$45,$0d,$d0,$01
	.byte $44,$41,$54,$41,$50,$54,$52,$2b
	.byte $31,$0d,$54,$0d,$cd,$06,$4f,$46
