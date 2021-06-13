	.include "uscii.i"
	.include "MIX.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
console_xpos = $ce
console_ypos = $cf
zp_index = $d8
zp_display_line = $d9
zp_reagent_count = $ea
zp_reagent_index = $f0
;
; **** USER LABELS ****
;
tile_xpos = $0002
dest_x = $0006
j_waitkey = $0800
j_primm_xy = $081e
j_primm = $0821
j_console_out = $0824
j_mulax = $082a
j_printbcd = $0833
j_update_status = $0845
j_printdigit = $0866
j_clearstatwindow = $0869
j_printstring = $087e
party_stats = $ed00
;party_stats + reag = $ed38
;party_stats + spells = $ed40

;party_stat_reagents = $38
party_stat_spells = $40



	.segment "OVERLAY"

	jmp prompt_spell

prompt_mix:
	jsr display_spells
	jsr j_primm  ;b'Mix reagents\r\x00'
	.byte "Mix reagents", $8d
	.byte 0
prompt_spell:
	jsr j_primm  ;b'For spell:\x00'
	.byte "For spell:", 0
	jsr input_char
	sec
	sbc #char_A
	cmp #$1a     ;spell_max
	bcc @set_spell
	jsr j_primm  ;b'NONE!\r\x00'
	.byte "NONE!", $8d
	.byte 0
	jsr j_clearstatwindow
	jsr j_update_status
	jmp exit

@set_spell:
	sta spell
	jsr print_newline
	lda spell
	clc
	adc #string_spell_first
	jsr j_printstring
	jsr print_newline
	lda #$00
	sta mixture
prompt_reagents:
	jsr display_reagents
	jsr j_primm  ;b'REAGENT:\x00'
	.byte "REAGENT:", 0
:	jsr input_char
	beq :-
	cmp #char_enter
	beq @do_mix
	sec
	sbc #char_A
	cmp #reagent_max
	bcs @none_owned
	tay
	lda party_stats + party_stat_reagents,y
	bne @use_reagent
@none_owned:
	jsr j_primm  ;b'NONE OWNED!\r\x00'
	.byte "NONE OWNED!", $8d
	.byte 0
	jmp prompt_reagents

@use_reagent:
	sed
	sec
	sbc #$01
	cld
	sta party_stats + party_stat_reagents,y
	lda bit_msb,y
	ora mixture
	sta mixture
	jmp prompt_reagents

@do_mix:
	jsr j_primm  ;b'YOU MIX THE\rREAGENTS AND...\r\x00'
	.byte "YOU MIX THE", $8d
	.byte "REAGENTS AND...", $8d
	.byte 0
	ldy spell
	lda mixture_table,y
	cmp mixture
	beq @success
@failure:
	jsr j_primm  ;b'IT FIZZLES!\r\x00'
	.byte "IT FIZZLES!", $8d
	.byte 0
	jsr print_newline
	jmp prompt_mix

@success:
	jsr j_primm  ;b'SUCCESS!\r\x00'
	.byte "SUCCESS!", $8d
	.byte 0
	ldy spell
	sed
	clc
	lda party_stats + party_stat_spells,y
	adc #$01
	bcc :+
	lda #$99
:	sta party_stats + party_stat_spells,y
	cld
	jsr print_newline
	jmp prompt_mix

mixture:
	.byte 0
bit_msb:
	.byte $80,$40,$20,$10,$08,$04,$02,$01

input_char:
	jsr j_waitkey
	bpl input_char
	pha
	jsr j_console_out
	jsr print_newline
	pla
	rts

print_newline:
	lda #$8d
	jsr j_console_out
	rts

display_reagents:
	jsr j_clearstatwindow
	jsr save_console_xy
	ldx #$1a
	ldy #$00
	sty zp_reagent_index
	jsr j_primm_xy ;b'\x1eREAGENTS\x1d\x00'
	.byte $1e,"REAGENTS",$1d, 0
@next:
	clc
	lda zp_reagent_index
	adc #party_stat_reagents
	tay
	lda party_stats,y
	beq @skip
	sta zp_reagent_count
	jsr next_line
	clc
	lda zp_reagent_index
	adc #char_A
	jsr j_console_out
	lda zp_reagent_count
	cmp #$10
	bcs @two_digit
	lda #char_hyphen
	jsr j_console_out
	lda zp_reagent_count
	jsr j_printdigit
	jmp :+

@two_digit:
	jsr j_printbcd
:	lda #char_hyphen
	jsr j_console_out
	clc
	lda zp_reagent_index
	adc #$5d
	jsr j_printstring
@skip:
	inc zp_reagent_index
	lda zp_reagent_index
	cmp #$08
	bcc @next
	jsr restore_console_xy
	rts

display_spells:
	jsr j_clearstatwindow
	jsr save_console_xy
	ldx #$1a
	ldy #$00
	sty zp_index
	sty zp_display_line
	jsr j_primm_xy ;b'\x1eMIXTURES\x1d\x00'
	.byte $1e,"MIXTURES",$1d, 0
@next:
	lda zp_display_line
	lsr
	lsr
	lsr
	ldx #$05     ;column width
	jsr j_mulax
	clc
	adc #$18     ;left margin
	sta console_xpos
	cmp #$24
	bcs @skip
	lda zp_display_line
	and #$07     ;wrap after 8 rows
	sta console_ypos
	inc console_ypos
	ldy zp_index
	lda party_stats + party_stat_spells,y
	beq @skip
	lda zp_index
	clc
	adc #char_A
	jsr j_console_out
	lda #char_hyphen
	jsr j_console_out
	ldy zp_index
	lda party_stats + party_stat_spells,y
	jsr j_printbcd
	inc zp_display_line
@skip:
	inc zp_index
	lda zp_index
	cmp #spells_max
	bcc @next
	jsr restore_console_xy
	rts

save_console_xy:
	lda console_xpos
	sta prev_console_x
	lda console_ypos
	sta prev_console_y
	rts

restore_console_xy:
	lda prev_console_x
	sta console_xpos
	lda prev_console_y
	sta console_ypos
	rts

next_line:
	inc console_ypos
	lda #$18
	sta console_xpos
	rts

prev_console_x:
	.byte 0
prev_console_y:
	.byte 0
spell:
	.byte 0

exit:
	rts

mixture_table:
	.byte $60,$18,$60,$a4,$94,$84,$85,$50
	.byte $05,$07,$06,$80,$84,$a1,$88,$e0
	.byte $c8,$f9,$50,$89,$a0,$03,$88,$98
	.byte $18,$18

; junk
;	.byte $ff,$00,$00,$ff,$ff,$00,$00,$ff
;	.byte $ff,$00,$00
