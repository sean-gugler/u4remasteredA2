	.include "uscii.i"
	
	.include "apple.i"
	.include "char.i"
	.include "disks.i"
	.include "dos.i"
	.include "music.i"
	.include "music_state.i"
	.include "jump_subs.i"
;	.include "jump_system.i"
	.include "zp_main.i"
	.include "zp_music.i"



	.segment "MAIN"

j_music_ctl:
	jmp music_ctl

j_spin_drive_motor:
	jmp spin_drive_motor


err_resume_addr:
	.addr $0000
err_resume_stack:
	.byte 0
on_dos_error:
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
	cmp music_data
	bcs @done
	sta tune_req_now
	sta tune_queue_next ;By default, loop same tune. Demo changes this value.
	cmp #music_off
	bne play_tune
@wait:
	lda tune_playing
	bne @wait
@done:
	rts

play_tune:
	lda tune_playing
	bne @done
	lda #<music_data
	sta mus_ptr
	lda #>music_data
	sta mus_ptr + 1
	jsr music_start
@done:
	rts

load_music:
	sta file_char_music
;	lda disk_id
;	cmp #disk_program
;	bne @normal_filename
;@cryptic_filename:
;	lda #char_M
;	sta file_char_first
;	lda #$81     ;magic hidden file char on Program Disk
;	sta file_char_second
;	bne @load_file
;@normal_filename:
;	lda #char_space
;	sta file_char_first
;	lda #char_M
;	sta file_char_second
;@load_file:
	lda #music_off    ;stop current music before replacing data
	jsr music_ctl
	jsr j_primm_cout
	.byte $84,"BLOAD"
file_char_first:
	.byte " "
file_char_second:
	.byte "MUS"
file_char_music:
	.byte "A,A$F000", $8d
	.byte 0
	lda #music_main
	bne music_ctl

spin_drive_motor:
	pha
	ldx RWTS_slot
	lda drive_motor_on,x
	ldx #$05
@delay:
	ldy #$00
:	iny
	bne :-
	dex
	bne @delay
	ldx RWTS_slot
	lda drive_motor_off,x
	pla
	rts

