	.include "uscii.i"
	.include "SEL.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
a80 = $80
a81 = $81
a82 = $82
a84 = $84
a85 = $85
diskid = $d0
e0400 = $0400
;
; **** USER LABELS ****
;
j_primm_cout = $081b
disk_slot = $b7e9   ; IBSLOT: CONTROLLER SLOT NO. in DOS IOB (I/O Block) N * $10
drive_motor_off = $c088
drive_motor_on = $c089
music_header = $f000



	.segment "MAIN"

	jmp music_ctl

	jmp spin_drive_motor

err_resume_addr:
	.byte 0, 0
err_resume_stack:
	.byte 0
on_cout_error:
	ldx err_resume_stack
	txs
	lda err_resume_addr + 1
	pha
	lda err_resume_addr
	pha
	jmp j_primm_cout

music_ctl:
	tax
	bmi load_music
	cmp music_header
	bcs @done
	sta a80
	sta a81
	cmp #$00
	bne play_tune
@wait:
	lda a82
	bne @wait
@done:
	rts

play_tune:
	lda a82
	bne @done
	lda #<music_header
	sta a84
	lda #>music_header
	sta a85
	jsr e0400
@done:
	rts

load_music:
	sta file_char_music
	lda diskid
	cmp #$01
	bne @normal_filename
@cryptic_filename:
	lda #char_M
	sta file_char_first
	lda #$81     ;magic hidden file char on Disk 1
	sta file_char_second
	bne @load_file
@normal_filename:
	lda #char_space
	sta file_char_first
	lda #char_M
	sta file_char_second
@load_file:
	lda #$00
	jsr music_ctl
	jsr j_primm_cout ;b'\x04BLOAD MUSA,A$F000\n\x00'
	.byte $84,"BLOAD"
file_char_first:
	.byte " "
file_char_second:
	.byte "MUS"
file_char_music:
	.byte "A,A$F000", $8d
	.byte 0
	lda #$01
	bne music_ctl

spin_drive_motor:
	pha
	ldx disk_slot
	lda drive_motor_on,x
	ldx #$05
@delay:
	ldy #$00
:	iny
	bne :-
	dex
	bne @delay
	ldx disk_slot
	lda drive_motor_off,x
	pla
	rts

