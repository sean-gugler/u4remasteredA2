	.include "uscii.i"

	.include "apple.i"
	.include "char.i"
	.include "map_objects.i"
	.include "music.i"
	.include "sound.i"
	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "jump_system.i"
	.include "super_packer.i"
	.include "tables.i"
	.include "zp_main.i"

	.include "PRTY.i"
	.include "ROST.i"


; --- Custom use of Zero Page

zp_index = $ea
zp_count = $f0

zp_save_reg = $d9
; for consistency these should have been the same
zp_dec_amount = $da
zp_inc_amount = $d9


; --- Configure Super-Packer

max_spk_col = $16
max_spk_row = $b7

min_spk_col = $00
min_spk_row = $07


	.segment "OVERLAY"

.assert * = j_overlay_entry, error, "Wrong start address"
	lda current_location
	sec
	sbc #loc_shrine_first
	sta shrine_num
	tay
	lda runes
	and bit_msb,y
	bne @haverune
	jsr j_primm
	.byte $8d
	.byte "THOU DOST NOT", $8d
	.byte "BEAR THE RUNE", $8d
	.byte "OF ENTRY! A", $8d
	.byte "STRANGE FORCE", $8d
	.byte "KEEPS YOU OUT!", $8d
	.byte 0
	jmp exit_shrine

@haverune:
	jsr j_primm_cout
	.byte $84,"BLOAD SHRI,A$280", $8d
	.byte 0
	ldx #$7f
@copymap:
	lda world_tiles,x
	sta drawn_tiles,x
	dex
	bpl @copymap
	lda #mode_shrine
	sta game_mode
	jsr j_update_view
	lda #music_shrine
	jsr music_ctl
	jsr j_primm
	.byte $8d
	.byte "YOU ENTER THE", $8d
	.byte "ANCIENT SHRINE", $8d
	.byte "AND SIT BEFORE", $8d
	.byte "THE ALTAR...", $8d
	.byte $8d
	.byte "UPON WHAT VIRTUE", $8d
	.byte "DOST THOU", $8d
	.byte "MEDITATE?", $8d
	.byte 0
	lda #$00
	sta num_cycles
	jsr get_string
@askcycles:
	jsr j_primm
	.byte $8d
	.byte "FOR HOW MANY", $8d
	.byte "CYCLES (0-3):", 0
	jsr get_number
	cmp #$04
	bcs @askcycles
	sta num_cycles
	sta cycle_ctr
	bne :+
	jmp no_focus

:	lda #$00
	sta unused
	jsr compare_string
	cmp shrine_num
	beq @virtue_shrine_match
	jmp no_focus

@virtue_shrine_match:
	lda move_counter + 2
	cmp last_meditated
	bne @begin
	jmp still_weary

@begin:
	sta last_meditated
	jsr j_primm
	.byte $8d
	.byte "BEGIN MEDITATION", $8d
	.byte 0
@slowdots:
	lda #$10
	sta zp_count
@print:
	jsr delay
	lda #char_period
	jsr j_console_out
	dec zp_count
	bne @print
	bit hw_STROBE
	lda #$00
	sta key_buf_len
	jsr j_primm
	.byte $8d
	.byte "MANTRA", 0
	jsr get_string
	jsr compare_string
	sec
	sbc #$08
	cmp shrine_num
	beq @correctmantra
	jmp @wrongmantra

@correctmantra:
	dec cycle_ctr
	bne @slowdots
	jmp @checkresult

@wrongmantra:
	jsr j_primm
	.byte $8d
	.byte "THOU ART NOT", $8d
	.byte "ABLE TO FOCUS", $8d
	.byte "THY THOUGHTS", $8d
	.byte "WITH THAT", $8d
	.byte "MANTRA!", $8d
	.byte 0
	ldy #virtue_spirituality
	lda #$03
	jsr dec_virtue
	jmp exit_shrine

@checkresult:
	lda num_cycles
	cmp #$03
	bne @vision
	ldy shrine_num
	lda party_stats,y
	cmp #$99
	bne @vision
	jmp partial_avatar

@vision:
	jsr j_primm
	.byte $8d
	.byte "THY THOUGHTS", $8d
	.byte "ARE PURE,", $8d
	.byte "THOU ART GRANTED", $8d
	.byte "A VISION!", $8d
	.byte 0
	ldy #virtue_spirituality
	lda num_cycles
	asl
	adc num_cycles
	jsr inc_virtue
	jsr j_waitkey
	lda #char_enter
	jsr j_console_out
	ldy shrine_num
	lda shrine_msg_idx,y
	clc
	ldy num_cycles
	adc shrine_msg_per_cycle,y
	clc
	adc #$01
	jsr print_hint
	jsr j_waitkey
exit_shrine:
	lda #char_enter
	jsr j_console_out
	lda #loc_world
	sta current_location
	lda #mode_world
	sta game_mode
	jsr j_update_view
	rts

; unused
longdelay:
	ldx #$0a
:	jsr short_delay
	dex
	bne :-
	rts

delay:
	ldx #$05
:	jsr short_delay
	dex
	bne :-
	rts

short_delay:
	ldy #$ff
@outer:
	lda #$ff
@inner:
	sec
	sbc #$01
	bne @inner
	dey
	bne @outer
	bit hw_STROBE
	rts

no_focus:
	jsr j_primm
	.byte $8d
	.byte "THOU ART UNABLE", $8d
	.byte "TO FOCUS THY", $8d
	.byte "THOUGHTS ON", $8d
	.byte "THIS SUBJECT!", $8d
	.byte 0
	jsr j_waitkey
	jmp exit_shrine

still_weary:
	jsr j_primm
	.byte $8d
	.byte "THY MIND IS", $8d
	.byte "STILL WEARY", $8d
	.byte "FROM THY LAST", $8d
	.byte "MEDITATION!", $8d
	.byte 0
	jsr j_waitkey
	jmp exit_shrine

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
	ldy zp_save_reg
	lda #$99
	jmp @continue

partial_avatar:
	jsr j_primm
	.byte $8d
	.byte "THOU HAST", $8d
	.byte "ACHIEVED PARTIAL", $8d
	.byte "AVATARHOOD IN", $8d
	.byte "THE VIRTUE OF", $8d
	.byte 0
	lda #$97
	clc
	adc shrine_num
	jsr j_printstring
	jsr j_invertview
	ldx #$ff
	lda #sound_spell_effect
	jsr j_playsfx
	jsr j_invertview
	lda #char_enter
	jsr j_console_out
	ldy shrine_num
	lda #$00
	sta party_stats,y
	jsr j_waitkey
	jsr j_primm
	.byte $8d
	.byte "THOU ART GRANTED", $8d
	.byte "A VISION!", $8d
	.byte 0
	lda #mode_suspended
	sta game_mode
	lda shrine_num
	jsr draw_rune
	jsr j_waitkey
	jmp exit_shrine

get_number:
	jsr j_waitkey
	beq get_number
	sec
	sbc #char_num_first
	cmp #$0a     ;10
	bcc @ok
	lda #$00
@ok:
	pha
	jsr j_printdigit
	lda #char_enter
	jsr j_console_out
	pla
	rts

shrine_num:
	.byte 0
num_cycles:
	.byte 0
cycle_ctr:
	.byte 0
unused:
	.byte 0
shrine_msg_idx:
	.byte $00,$03,$06,$09,$0c,$0f,$12,$15
shrine_msg_per_cycle:
	.byte $18, 0, 0, 0, 1, 1, 1, 2, 2, 2	; BUG: always msg 0. @vision does not multiply num_cycles by 3
bit_msb:
	.byte $80,$40,$20,$10,$08,$04,$02,$01

get_string:
	lda #char_question
	jsr j_console_out
	lda #$00
	sta zp_index
@waitkey:
	jsr j_waitkey
	beq @timeout
@checkkey:
	cmp #char_enter
	beq @done
	cmp #char_left_arrow
	beq @del
	cmp #char_space
	bcc @waitkey
	ldx zp_index
	sta inbuffer,x
	jsr j_console_out
	inc zp_index
	lda zp_index
	cmp #$0f
	bcc @waitkey
	bcs @done
@del:
	lda zp_index
	beq @waitkey
	dec zp_index
	dec console_xpos
	lda #char_space
	jsr j_console_out
	dec console_xpos
	jmp @waitkey

@timeout:
	lda num_cycles
	beq @checkkey
@done:
	ldx zp_index
	lda #char_space
@clearend:
	sta inbuffer,x
	inx
	cpx #$06
	bcc @clearend
	lda #char_enter
	jsr j_console_out
	rts

compare_string:
	lda #$0f
	sta zp_index
@nextstring:
	lda zp_index
	asl
	asl
	tay
	ldx #$00
@compare:
	lda virtues_and_mantras,y
	cmp inbuffer,x
	bne @differ
	iny
	inx
	cpx #$04
	bcc @compare
	lda zp_index
	rts

@differ:
	dec zp_index
	bpl @nextstring
	lda zp_index
	rts

virtues_and_mantras:
	.byte "HONE"
	.byte "COMP"
	.byte "VALO"
	.byte "JUST"
	.byte "SACR"
	.byte "HONO"
	.byte "SPIR"
	.byte "HUMI"
	.byte "AHM "
	.byte "MU  "
	.byte "RA  "
	.byte "BEH "
	.byte "CAH "
	.byte "SUMM"
	.byte "OM  "
	.byte "LUM "

print_hint:
	tay
	lda #<string_table
	sta ptr1
	lda #>string_table
	sta ptr1 + 1
	ldx #$00
@checknext:
	lda (ptr1,x)
	beq @possiblestring
@wrongstring:
	jsr @incptr
	jmp @checknext

@possiblestring:
	dey
	beq @gotstring
	jmp @wrongstring

@gotstring:
	jsr @incptr
	ldx #$00
	lda (ptr1,x)
	beq @done
	jsr j_console_out
	jmp @gotstring

@done:
	rts

@incptr:
	inc ptr1
	bne :+
	inc ptr1 + 1
:	rts

string_table:
; STRING $00 (0)
	.byte 0
; STRING $01 (1)
	.byte "TAKE NOT THE", $8d
	.byte "GOLD OF OTHERS", $8d
	.byte "FOUND IN TOWNS", $8d
	.byte "AND CASTLES FOR", $8d
	.byte "YOURS IT IS NOT!", $8d
	.byte 0
; STRING $02 (2)
	.byte "CHEAT NOT THE", $8d
	.byte "MERCHANTS AND", $8d
	.byte "PEDDLERS FOR TIS", $8d
	.byte "AN EVIL THING", $8d
	.byte "TO DO!", $8d
	.byte 0
; STRING $03 (3)
	.byte "SECOND, READ THE", $8d
	.byte "BOOK OF TRUTH AT", $8d
	.byte "THE ENTRANCE TO", $8d
	.byte "THE GREAT", $8d
	.byte "STYGIAN ABYSS!", $8d
	.byte 0
; STRING $04 (4)
	.byte "KILL NOT THE", $8d
	.byte "NON-EVIL BEASTS", $8d
	.byte "OF THE LAND, AND", $8d
	.byte "DO NOT ATTACK", $8d
	.byte "THE FAIR PEOPLE!", $8d
	.byte 0
; STRING $05 (5)
	.byte "GIVE OF THY", $8d
	.byte "PURSE TO THOSE", $8d
	.byte "WHO BEG AND THY", $8d
	.byte "DEED SHALL NOT", $8d
	.byte "BE FORGOTTEN!", $8d
	.byte 0
; STRING $06 (6)
	.byte "THIRD, LIGHT THE", $8d
	.byte "CANDLE OF LOVE", $8d
	.byte "AT THE ENTRANCE", $8d
	.byte "TO THE GREAT", $8d
	.byte "STYGIAN ABYSS!", $8d
	.byte 0
; STRING $07 (7)
	.byte "VICTORIES SCORED", $8d
	.byte "OVER EVIL", $8d
	.byte "CREATURES HELP", $8d
	.byte "TO BUILD A", $8d
	.byte "VALOROUS SOUL!", $8d
	.byte 0
; STRING $08 (8)
	.byte "TO FLEE FROM", $8d
	.byte "BATTLE WITH LESS", $8d
	.byte "THAN GRIEVOUS", $8d
	.byte "WOUNDS OFTEN", $8d
	.byte "SHOWS A COWARD!", $8d
	.byte 0
; STRING $09 (9)
	.byte "FIRST, RING THE", $8d
	.byte "BELL OF COURAGE", $8d
	.byte "AT THE ENTRANCE", $8d
	.byte "TO THE GREAT", $8d
	.byte "STYGIAN ABYSS!", $8d
	.byte 0
; STRING $0A (10)
	.byte "TO TAKE THE GOLD", $8d
	.byte "OF OTHERS IS", $8d
	.byte "INJUSTICE NOT", $8d
	.byte "SOON FORGOTTEN,", $8d
	.byte "TAKE ONLY THY", $8d
	.byte "DUE!", $8d
	.byte 0
; STRING $0B (11)
	.byte "ATTACK NOT A", $8d
	.byte "PEACEFUL CITIZEN", $8d
	.byte "FOR THAT ACTION", $8d
	.byte "DESERVES STRICT", $8d
	.byte "PUNISHMENT!", $8d
	.byte 0
; STRING $0C (12)
	.byte "KILL NOT A", $8d
	.byte "NON-EVIL BEAST", $8d
	.byte "FOR THEY DESERVE", $8d
	.byte "NOT DEATH EVEN", $8d
	.byte "IF IN HUNGER", $8d
	.byte "THEY ATTACK", $8d
	.byte "THEE!", $8d
	.byte 0
; STRING $0D (13)
	.byte "TO GIVE THY LAST", $8d
	.byte "GOLD PIECE UNTO", $8d
	.byte "THE NEEDY, SHOWS", $8d
	.byte "GOOD MEASURE OF", $8d
	.byte "SELF-SACRIFICE!", $8d
	.byte 0
; STRING $0E (14)
	.byte "FOR THEE TO FLEE", $8d
	.byte "AND LEAVE THY", $8d
	.byte "COMPANIONS IS A", $8d
	.byte "SELFSEEKING ACTION", $8d
	.byte "TO BE AVIODED!", $8d
	.byte 0
; STRING $0F (15)
	.byte "TO GIVE OF THY", $8d
	.byte "LIFES BLOOD SO", $8d
	.byte "THAT OTHERS MAY", $8d
	.byte "LIVE IS A VIRTUE", $8d
	.byte "OF GREAT PRAISE!", $8d
	.byte 0
; STRING $10 (16)
	.byte "TAKE NOT THE", $8d
	.byte "GOLD OF OTHERS", $8d
	.byte "FOR THIS SHALL", $8d
	.byte "BRING DISHONOR", $8d
	.byte "UPON THEE!", $8d
	.byte 0
; STRING $11 (17)
	.byte "TO STRIKE FIRST", $8d
	.byte "A NON-EVIL BEING", $8d
	.byte "IS BY NO MEANS", $8d
	.byte "AN HONORABLE", $8d
	.byte "DEED!", $8d
	.byte 0
; STRING $12 (18)
	.byte "SEEK YE TO SOLVE", $8d
	.byte "THE MANY QUESTS", $8d
	.byte "BEFORE THEE, AND", $8d
	.byte "HONOR SHALL BE", $8d
	.byte "A REWARD!", $8d
	.byte 0
; STRING $13 (19)
	.byte "SEEK YE TO KNOW", $8d
	.byte "THYSELF, VISIT", $8d
	.byte "THE SEER OFTEN", $8d
	.byte "FOR HE CAN", $8d
	.byte "SEE INTO THY", $8d
	.byte "INNER BEING!", $8d
	.byte 0
; STRING $14 (20)
	.byte "MEDITATION LEADS", $8d
	.byte "TO ENLIGHTENMENT", $8d
	.byte "SEEK YE ALL", $8d
	.byte "WISDOM AND", $8d
	.byte "KNOWLEDGE!", $8d
	.byte 0
; STRING $15 (21)
	.byte "IF THOU DOST", $8d
	.byte "SEEK THE WHITE", $8d
	.byte "STONE, SEARCH YE", $8d
	.byte "NOT UNDER THE", $8d
	.byte "GROUND, BUT IN", $8d
	.byte "THE SKY NEAR", $8d
	.byte "SERPENTS SPINE!", $8d
	.byte 0
; STRING $16 (22)
	.byte "CLAIM NOT TO BE", $8d
	.byte "THAT WHICH THOU", $8d
	.byte "ART NOT, HUMBLE", $8d
	.byte "ACTIONS SPEAK", $8d
	.byte "WELL THEE!", $8d
	.byte 0
; STRING $17 (23)
	.byte "STRIVE NOT TO", $8d
	.byte "WIELD THE GREAT", $8d
	.byte "FORCE OF EVIL", $8d
	.byte "FOR ITS POWER", $8d
	.byte "WILL OVERCOME", $8d
	.byte "THEE!", $8d
	.byte 0
; STRING $18 (24)
	.byte "IF THOU DOST", $8d
	.byte "SEEK THE BLACK", $8d
	.byte "STONE, SEARCH YE", $8d
	.byte "AT THE TIME AND", $8d
	.byte "PLACE OF THE", $8d
	.byte "GATE ON THE", $8d
	.byte "DARKEST OF ALL", $8d
	.byte "NIGHTS!", $8d
	.byte 0

draw_rune:
	pha
	jsr swap_buf
	jsr j_clearview
	pla

	asl
	tax
	lda rune_addr + 1,x
	sta ptr2 + 1
	lda rune_addr,x
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
	jsr swap_buf
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

	.byte "SUPER UNPACKER COPYRIGHT 1983 BY STEVEN MEUSE"

swap_buf:
	ldx #$0f
:	lda key_buf,x
	tay
	lda key_buf_tmp,x
	sta key_buf,x
	tya
	sta key_buf_tmp,x
	dex
	bpl :-
	rts

key_buf_tmp:
	.res 16, 0
rune_addr:
	.addr rune_i,rune_n,rune_f,rune_i,rune_n
	.addr rune_i,rune_t,rune_y
rune_i:
	.byte $fb,$fd,$fd,$03,$07,$fb,$ff,$80
	.byte $fb,$e2,$80,$9c,$fc,$f8,$fb,$16
	.byte $b8,$bc,$fc,$f0,$fd,$03,$07,$fb
	.byte $ff,$80,$fb,$30,$80
rune_n:
	.byte $fb,$fd,$fd,$03,$07,$fb,$ff,$80
	.byte $fb,$3b,$80,$8f,$9f,$b9,$b0,$b0
	.byte $b8,$9c,$fb,$a0,$80,$9c,$fc,$f8
	.byte $fb,$07,$b8,$f8,$f8,$f8,$bc,$be
	.byte $bf,$bb,$fb,$09,$b8,$bc,$fc,$f0
	.byte $fb,$9d,$80,$f0,$b8,$98,$98,$b8
	.byte $f0,$e0,$fd,$03,$06,$fb,$ff,$80
	.byte $fb,$8a,$80
rune_f:
	.byte $fb,$fd,$fd,$03,$07,$fb,$ff,$80
	.byte $fb,$42,$80,$83,$87,$8e,$8c,$9c
	.byte $fb,$05,$98,$bc,$bc,$fb,$95,$80
	.byte $81,$81,$fb,$0c,$80,$ff,$ff,$c0
	.byte $80,$80,$8f,$9f,$b8,$b0,$b0,$b0
	.byte $f9,$f9,$fb,$94,$80,$b8,$f8,$fb
	.byte $17,$f0,$f8,$f8,$e0,$fd,$03,$06
	.byte $fb,$ff,$80,$fb,$7f,$80
rune_t:
	.byte $fb,$fd,$fd,$03,$07,$fb,$ff,$80
	.byte $fb,$48,$80,$f0,$fc,$9f,$87,$81
	.byte $fb,$95,$80,$9c,$fc,$f8,$fb,$15
	.byte $b8,$bb,$ff,$fe,$b8,$fb,$aa,$80
	.byte $9c,$fc,$f0,$c0,$fd,$03,$06,$fb
	.byte $ff,$80,$fb,$81,$80
rune_y:
	.byte $fb,$fd,$fd,$03,$06,$fb,$ff,$80
	.byte $fb,$81,$80,$83,$87,$87,$fb,$10
	.byte $83,$87,$87,$fb,$9b,$80,$e0,$e0
	.byte $fb,$0a,$c0,$ff,$ff,$fb,$06,$c0
	.byte $f8,$ff,$8f,$81,$fb,$98,$80,$b8
	.byte $f8,$f0,$fb,$09,$b0,$ff,$ff,$fb
	.byte $08,$80,$f0,$fe,$9f,$83,$fb,$96
	.byte $80,$87,$9f,$9e,$fb,$09,$8e,$fe
	.byte $fe,$fb,$0a,$8e,$ee,$fe,$bf,$87
	.byte $fd,$03,$06,$fb,$ff,$80,$fb,$7f
	.byte $80,$02
