	.include "uscii.i"

	.include "apple.i"
	.include "mockingboard.i"
;	.include "music.i"
	.include "music_state.i"
	.include "zp_music.i"



	.segment "MB_INIT"

	jmp init_mockingboards

; NOTE: PSG = programmable sound generator (AY-3-8913 chip)

vectors_save:
	.byte 0, 0, 0, 0, 0, 0
vectors_save_size = * - vectors_save
cur_psg:
	.byte 0
chan:
	.res 12
psg_next_table:
	.addr psg1_next_values
	.addr psg2_next_values
psg_cur_table:
	.addr psg1_cur_values
	.addr psg2_cur_values
psg1_base:
	.addr $0000
psg2_base:
	.addr $0000

init_mockingboards:
	jsr select_bank2
	jsr relocate_MBSM
	jsr set_psg_addresses
	jsr set_channel_tables
	jsr set_psg_lines_output
	jsr init_psg_registers
	jsr activate_irq
	sec
	rts

select_bank2:
	lda hw_LCBANK2
	lda hw_LCBANK2
	rts

relocate_MBSM:
	; F000..F3F7 -> 0400..07F7
	; F400..F7FF -> FD00..FFFF

	lda #<music_data
	sta relocate_src
	lda #>music_data
	sta relocate_src + 1
	lda #<screen_TEXT
	sta relocate_dst
	lda #>screen_TEXT
	sta relocate_dst + 1

; In TEXT region, skip final 8 bytes of each half-page (reserved for DOS)
copy_page:
	ldy #$00
copy_part1:
	lda (relocate_src),y
	sta (relocate_dst),y
	iny
	cpy #$78
	bcc copy_part1

	ldy #$80
copy_part2:
	lda (relocate_src),y
	sta (relocate_dst),y
	iny
	cpy #$f8
	bcc copy_part2

	inc relocate_src + 1
	inc relocate_dst + 1
	lda relocate_src + 1
	cmp #>music_data + 4
	bcc copy_page

; Preserve interrupt vectors
	ldx #vectors_save_size - 1
save_vectors:
	lda vector_NMI,x
	sta vectors_save,x
	dex
	bpl save_vectors

	lda #>music_update
	sta relocate_dst + 1
	ldy #$00
copy_part3:
	lda (relocate_src),y
	sta (relocate_dst),y
	iny
	bne copy_part3
	inc relocate_src + 1
	inc relocate_dst + 1
	lda relocate_src + 1
	cmp #>music_data + 7
	bcc copy_part3

	ldx #vectors_save_size - 1
restore_vectors:
	lda vectors_save,x
	sta vector_NMI,x
	dex
	bpl restore_vectors
	rts


; Two PSGs are supported, either on a pair of cards (type 1 or 2)
; or both on a single type 3 card.
;
; Every Mockingboard type has two chip sockets, for PSG music or speech.
;   $Cx00 socket A
;   $Cx80 socket B
; Card type 1: A has the music PSG
; Card type 2: B has the music PSG
; Card type 3: A + B both have music PSGs
;   You can also think of Type as a bitfield "BA" for presence of PSG music chip.

set_psg_addresses:
	ldx #$02
@validate_slot_type:
	ldy #$00     ;clear slot to 00 unless validated
	lda mb_1_slot,x
	cmp #max_slot
	bcs @set_slot
	lda mb_1_type,x
	beq @set_slot
	cmp #max_mb_type
	bcs @set_slot
	ldy mb_1_slot,x ;VALID. Use specified slot.
@set_slot:
	sty mb_1_slot,x
	dex
	dex
	bpl @validate_slot_type
@count_mbs:
	ldy mb_1_slot
	bne check_mb_types
	lda mb_2_slot
	bne @only_use_mb_2
@abort:
	pla
	pla
	clc
	rts
; Dormant block. Menu input validation guarantees mb_1 is valid.
@only_use_mb_2:
	sta mb_1_slot
;	tay  ;Adding this would fix a dormant BUG in case type=3, see below.
	lda mb_2_type
	sta mb_1_type
	lda #$00
	sta mb_2_slot
check_mb_types:
	lda mb_1_type
	cmp #$03     ;see BUG above
	bcs @both_psg_same_slot
	ldy mb_2_slot
	bne @have_two_mb
	lda mb_1_slot
	sta mb_2_slot
	lda mb_1_type
	sta mb_2_type
	lda #$01
	bne @set_addr
@have_two_mb:
	lda mb_2_type
	cmp #$03
	bcc @use_two_mb_slots
@both_psg_same_slot:
	sty mb_1_slot ;see BUG above
	sty mb_2_slot
	lda #$01
	sta mb_1_type
	lda #$02
	sta mb_2_type
@use_two_mb_slots:
	lda #$02
@set_addr:
	sta num_psgs
	lda #$c0
	ora mb_1_slot
	sta psg1_base + 1
	sta mb_io_base + 1
	lda #$c0
	ora mb_2_slot
	sta psg2_base + 1
	lda #$00
	sta mb_io_base
	ldx mb_1_type
	cpx #$02
	ror
	sta psg1_base
	lda #$00
	ldx mb_2_type
	cpx #$02
	ror
	sta psg2_base
	rts

set_channel_tables:
	lda num_psgs
	cmp #$01
	beq @start
	cmp #$02
	beq @start
@abort:
	pla
	pla
	clc
	rts
@start:
	asl
	adc num_psgs
	sta mb_num_channels ;3 per board
	lsr
	ldx #max_channels * 2 - 1
@copy_table:
	lda one_mb_table,x
	bcs :+
	lda two_mb_table,x
:	sta chan,x
	dex
	bpl @copy_table
	ldx #max_channels * 2 - 2
@next_pair:
	lda chan,x   ;which psg chip
	asl
	tay
	lda psg_next_table,y
	sta chan_next_addr,x
	lda psg_next_table + 1,y
	sta chan_next_addr + 1,x
	lda psg_cur_table,y
	sta chan_cur_addr,x
	lda psg_cur_table + 1,y
	sta chan_cur_addr + 1,x
	lda psg1_base,y
	sta chan_io_base,x
	lda psg1_base + 1,y
	sta chan_io_base + 1,x
	lda chan + 1,x ;which voice in that chip
	asl
	sta chan_freq_reg,x
	lda chan + 1,x
	ora #$08
	sta chan_level_reg,x
	dex
	dex
	bpl @next_pair
	rts

; 6 pairs of [chip#,voice#] for 1- or 2-card configurations
one_mb_table:
	.byte 0,0, 0,1, 0,2  ; Important voices
	.byte 1,0, 1,1, 1,2  ; Supplementary voices, ok to be absent
two_mb_table:
	;Route all 6 voices for best stereo experience
	.byte 0,0, 1,0
	.byte 0,1, 1,1
	.byte 1,2, 0,2  ; Why are these reversed?

set_psg_lines_output:
	ldx num_psgs
	dex
	stx cur_psg
@next:
	lda cur_psg
	asl
	tax
	nop          ;last-minute patch before release?
	nop          ;seems unnecessary.
	lda chan_io_base,x
	sta psg_io
	lda chan_io_base + 1,x
	sta psg_io + 1

	ldy #mb_reg_DDRA
	lda #$ff     ;port A (data) all bits output
	sta (psg_io),y

	ldy #mb_reg_DDRB
	lda #$07     ;port B (cmd) 3 bits output (valid cmds 0-7)
	sta (psg_io),y

	dec cur_psg
	bpl @next
	rts

init_psg_registers:
	ldx num_psgs
	dex
	stx cur_psg
@next_psg:
	lda cur_psg
	asl
	tax
	lda chan_next_addr,x
	sta next_values
	lda chan_next_addr + 1,x
	sta next_values + 1
	lda chan_cur_addr,x
	sta cur_values
	lda chan_cur_addr + 1,x
	sta cur_values + 1
	lda chan_io_base,x
	sta psg_io
	lda chan_io_base + 1,x
	sta psg_io + 1
	ldy #mb_reg_ORB
	lda #psg_cmd_reset
	sta (psg_io),y
	lda #psg_cmd_inactive
	sta (psg_io),y
	ldy #psg_reg_last
@next_register:
	lda #$00
	cpy #psg_reg_voice_enable
	bne :+
	lda #voice_disable_noise_ABC
:	sta (next_values),y
	lda #$ff
	sta (cur_values),y
	dey
	bpl @next_register
	dec cur_psg
	bpl @next_psg
	jsr set_psg_registers
	rts

activate_irq:
	sei
	lda #<mb_irq_handler
	sta vector_IRQ
	lda #>mb_irq_handler
	sta vector_IRQ + 1

; Make sure ROM is banked out and vector_IRQ is writable
	lda vector_IRQ
	cmp #<mb_irq_handler
	bne @abort
	lda vector_IRQ + 1
	cmp #>mb_irq_handler
	bne @abort

	ldy #mb_reg_IER
	lda #VIA_IER_set + VIA_INT_timer_1
	sta (mb_io_base),y
	cli
	rts

@abort:
	pla
	pla
	clc
	rts

set_psg_registers:
	ldx num_psgs
	dex
	stx cur_psg
@next_psg:
	lda cur_psg
	asl
	tax
	lda chan_next_addr,x
	sta next_values
	lda chan_next_addr + 1,x
	sta next_values + 1
	lda chan_cur_addr,x
	sta cur_values
	lda chan_cur_addr + 1,x
	sta cur_values + 1
	lda chan_io_base,x
	sta psg_io
	lda chan_io_base + 1,x
	sta psg_io + 1
	ldx #$0a
@next_register:
	txa
	tay
	lda (next_values),y
	cmp (cur_values),y
	beq @skip
	sta (cur_values),y
	pha
	ldy #mb_reg_ORA
	txa          ;select register X in cur_psg
	sta (psg_io),y
	ldy #mb_reg_ORB
	lda #psg_cmd_latch
	sta (psg_io),y
	lda #psg_cmd_inactive
	sta (psg_io),y
	ldy #mb_reg_ORA
	pla          ;set register X to value A
	sta (psg_io),y
	ldy #mb_reg_ORB
	lda #psg_cmd_write
	sta (psg_io),y
	lda #psg_cmd_inactive
	sta (psg_io),y
@skip:
	dex
	bpl @next_register
	dec cur_psg
	bpl @next_psg
	rts

