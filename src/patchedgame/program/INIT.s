	.include "uscii.i"
	.include "INIT.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
a33 = $33
cout_lo = $36
cout_hi = $37
a76 = $76
key_buf_len = $b8
disk_id = $d0
ad8 = $d8
ad9 = $d9
ptr1 = $fe
;ptr1 + 1 = $ff
;
; **** ZP POINTERS ****
;
;ptr1 = $fe
;
; **** ABSOLUTE ADRESSES ****
;
cout_stub = $1fff
DOS_BREAK = $9d58
;DOS_BREAK + 1 = $9d59
DOS_ASIBSW = $aaae
;
; **** USER LABELS ****
;
kbd_buf_count = $0046
key_buf = $00b0
;key_buf+1 = $00b1
charptr = $00bd
;charptr+1 = $00be
ptr2 = $00fc
;ptr2 + 1 = $00fd
music_ctl = $0320
on_dos_error = $0329
dos_hook_cout = $03ea
screen = $0400
j_primm_cout = $081b
j_readblock = $b7b5
rwts_volume = $b7eb
rwts_track = $b7ec
rwts_sector = $b7ed
rwts_buf_lo = $b7f0
rwts_buf_hi = $b7f1
rwts_command = $b7f4
hw_keyboard = $c000
hw_strobe = $c010
hw_speaker = $c030
hw_romin = $c081
hw_lcbank2 = $c083
hw_lcbank1 = $c08b
rom_shadow = $f000
rom_home = $fc58
rom_cout = $fded

tbls = $e000
htxt = $e400


	.segment "MAIN"

	jsr rom_home ;$FC58 HOME & CLEAR SCREEN (Destroys ACCUMULATOR & Y-REG)
	jsr print_cout
	.byte $8d
	.byte $84,"NOMON I,O,C", $8d
	.byte $84,"MAXFILES 1", $8d
	.byte 0
	jsr rom_home ;$FC58 HOME & CLEAR SCREEN (Destroys ACCUMULATOR & Y-REG)
	jsr print_cout
	.byte $8d
	.byte $8d
	.byte $8d
	.byte $8d
	.byte $8d
	.byte $8d
	.byte $8d
	.byte $8d
	.byte "               ULTIMA IV", $8d
	.byte $8d
	.byte "          QUEST OF THE AVATAR", $8d
	.byte $8d
	.byte $8d
	.byte $8d
	.byte "  COPYRIGHT 1985, ORIGIN SYSTEMS, INC.", $8d
	.byte 0
	jsr print_cout
	.byte $84, "BLOAD SEL,A$320", $8d
	.byte $84, "BLOAD SUBS", $8d
	.byte 0
	lda #$01
	sta disk_id
	lda #$40        ; ROM AppleSoft
	sta DOS_ASIBSW  ; AppleSoft/IntBasic Switch
	lda #<on_dos_error
	sta DOS_BREAK
	lda #>on_dos_error
	sta DOS_BREAK + 1
	lda #$80
	sta ad8
	sta ad9
	sta a33
	sta a76
	lda #$60     ;RTS
	sta music_ctl

; silence COUT, leaving it active for DOS commands
	sta cout_stub
	lda #<cout_stub
	sta cout_lo
	lda #>cout_stub
	sta cout_hi
	jsr dos_hook_cout

; copy hi 4K of ROM to underlying RAM
	bit hw_romin ;read twice to
	bit hw_romin ;write-enable LC RAM bank2 ("Language Card")
	lda #$00
	sta key_buf_len
	ldy #<rom_shadow
	sty ptr1
	lda #>rom_shadow
	sta ptr1 + 1
:	lda (ptr1),y
	sta (ptr1),y
	iny
	bne :-
	inc ptr1 + 1
	bne :-

; load game files. SHP0:bank1, SHP1:bank2
	bit hw_lcbank2 ;read-enable LC RAM bank2
	bit hw_lcbank1 ;read twice to
	bit hw_lcbank1 ;RW-enable LC RAM bank1
	jsr j_primm_cout ;b'\x04BLOAD SHP0\n\x00'
	.byte $84,"BLOAD SHP0", $8d
	.byte 0
	bit hw_lcbank2 ;read twice to RW-enable LC RAM bank2
	jsr j_primm_cout ;b'\x04BLOAD SHP1\n\x04BLOAD TBLS,A$E000\n\x04BLOAD HTXT,A$E400\n\x04BRUN BOOT,A$6000\n\x00'
	.byte $84,"BLOAD SHP1", $8d
	.byte $84,"BLOAD TBLS,A$E000", $8d
	.byte $84,"BLOAD HTXT,A$E400", $8d
	.byte $84,"BRUN BOOT,A$6000", $8d
	.byte 0

print_cout:
	pla
	sta ptr1
	pla
	sta ptr1 + 1
	ldy #$00
@inc_ptr:
	inc ptr1
	bne :+
	inc ptr1 + 1
:	lda (ptr1),y
	beq @done
	ora #$80
	jsr rom_cout ;$FDED OUTPUT CHARACTER IN ACCUMULATOR. (Destroys A & Y-REG COUNT)
	jmp @inc_ptr

@done:
	lda ptr1 + 1
	pha
	lda ptr1
	pha
	rts

