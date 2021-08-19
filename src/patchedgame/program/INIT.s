	.include "uscii.i"
	
	.include "apple.i"
	.include "disks.i"
	.include "dos.i"
	.include "trainers.i"
	.include "jump_subs.i"
	.include "jump_system.i"
	.include "zp_main.i"


; Unknown purpose. Not specific to Ultima;
; possibly related to some Apple state.
zp_33 = $33
zp_76 = $76
zp_d8 = $d8
zp_d9 = $d9

; Fixed address to place a known RTS.
cout_stub = $1fff


	.segment "MAIN"

	jsr rom_HOME ;$FC58 HOME & CLEAR SCREEN (Destroys ACCUMULATOR & Y-REG)
	jsr print_cout
	.byte $8d
	.byte $84,"NOMON I,O,C", $8d
	.byte $84,"MAXFILES 1", $8d
	.byte 0
	jsr rom_HOME ;$FC58 HOME & CLEAR SCREEN (Destroys ACCUMULATOR & Y-REG)
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

	lda #disk_program
	sta disk_id

	lda #$40        ; ROM AppleSoft
	sta DOS_ASIBSW  ; AppleSoft/IntBasic Switch

	lda #<on_dos_error
	sta DOS_BREAK
	lda #>on_dos_error
	sta DOS_BREAK + 1

; unsure what this is for
	lda #$80
	sta zp_d8
	sta zp_d9
	sta zp_33
	sta zp_76

; Disable music until re-enabled by option in intro menu.
	lda #opcode_RTS
	sta music_ctl

; silence COUT, leaving it active for DOS commands
	sta cout_stub
	lda #<cout_stub
	sta zp_CSWL
	lda #>cout_stub
	sta zp_CSWL + 1
	jsr DOS_hook_cout

; copy hi 4K of ROM to underlying RAM
	bit hw_ROMIN ;read twice to
	bit hw_ROMIN ;write-enable LC RAM bank2 ("Language Card")
	lda #$00
	sta key_buf_len
	ldy #<rom_SHADOW
	sty ptr1
	lda #>rom_SHADOW
	sta ptr1 + 1
:	lda (ptr1),y
	sta (ptr1),y
	iny
	bne :-
	inc ptr1 + 1
	bne :-

; clear trainers
	lda #$00
	ldx #num_trainers
:	sta trainer_first,x
	dex
	bpl :-

; load game files. SHP0:bank1, SHP1:bank2
	bit hw_LCBANK2 ;read-enable LC RAM bank2
	bit hw_LCBANK1 ;read twice to
	bit hw_LCBANK1 ;RW-enable LC RAM bank1
	jsr j_primm_cout
	.byte $84,"BLOAD SHP0", $8d
	.byte 0
	bit hw_LCBANK2 ;read twice to RW-enable LC RAM bank2
	jsr j_primm_cout
	.byte $84,"BLOAD SHP1", $8d
	.byte $84,"BLOAD TBLS,A$E000", $8d
	.byte $84,"BLOAD HTXT,A$E400", $8d
	.byte 0

	lda hw_KEYBOARD
	cmp #$54  ; T
	beq trainer_menu
	jsr j_primm_cout
	.byte $84,"BRUN BOOT,A$6000", $8d, 0
trainer_menu:
	jsr j_primm_cout
	.byte $84,"BRUN MENU,A$6000", $8d, 0

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
	jsr rom_COUT ;$FDED OUTPUT CHARACTER IN ACCUMULATOR. (Destroys A & Y-REG COUNT)
	jmp @inc_ptr

@done:
	lda ptr1 + 1
	pha
	lda ptr1
	pha
	rts

