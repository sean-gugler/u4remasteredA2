; MBSM might mean "Mockingboard Sound Module"

	.include "uscii.i"

	.include "mockingboard.i"
	.include "zp_music.i"


; Only part of the driver will fit in high memory.
; The rest is sprinkled into the Apple II TEXT
; memory region, fitting in between the chunks that
; DOS 3.3 uses.

; Declaring these DOS segments lets the linker warn us
; if our code would overrun those reserved areas.
	.segment "DOS_1"
	.segment "DOS_2"
	.segment "DOS_3"
	.segment "DOS_4"
	.segment "DOS_5"
	.segment "DOS_6"
	.segment "DOS_7"
	.segment "DOS_8"


env_attack  = $01
env_decay   = $02
env_sustain = $03
env_release = $04

mus_cmd_env_rel_dur = $10
mus_cmd_transpose = $11
mus_cmd_env_pitch_bend = $12
mus_cmd_env_atk_rate = $18
mus_cmd_env_decay = $20
mus_cmd_env_sus_lev = $28
mus_cmd_env_rel_rate = $30
mus_cmd_env_atk_lev = $38
mus_cmd_jsr_pattern = $80
mus_cmd_rts_pattern = $81
mus_cmd_end_pattern = $82
mus_cmd_poll_interval = $83


clock_default = $429a  ;17050 CPU clocks ~= 1 video frame

; FORMULA for number of CPU cycles per NTSC vertical blank interval:
;    clocks / v_blank = CPU clock cycles per second / NTSC fields per second
;
; EXACTLY 17050 = 1023000 / 60
;    retail shipped with this value, but it is based on very rough
;    approximations of 1.023 MHz CPU clock rate and 60 frames per second.
;
; EXACTLY 17062.5 = 1000000 * 315/88 * 4 / 14 * 1001 / 60000
;    more accurate measurement based on precise specifications of NTSC
;      where   CPU clock = 315/88 MHz NTSC color carrier frequency * 4 / 14
;        and   NTSC fields per second = 60000 / 1001
;
; EXACTLY 17062.5 = 65 CPU cycles per line * 262.5 lines per NTSC field
;    alternate calculation based on Woz engineering to synchronize CPU with
;    NTSC colorburst phase, according to:
;    http://www1.cs.columbia.edu/~sedwards/apple2fpga/


;-------------------
	.segment "PRG_1"

music_start:
	lda #$ff
	sta tune_playing
	ldy #$00
	lda (mus_ptr),y
	tax
	sta num_tunes
@next_tune:
	iny
	clc
	lda (mus_ptr),y
	adc mus_ptr
	sta tune_addr - 1,y
	iny
	lda (mus_ptr),y
	adc mus_ptr + 1
	sta tune_addr - 1,y
	dex
	bne @next_tune

;	ldx mb_num_channels
	lda mb_num_channels ;BUGFIX
	asl                 ;BUGFIX: channel data is two bytes wide
	tax                 ;BUGFIX: make sure to clear it ALL
	dex                 ;BUGFIX
	dex
	lda #$00
@next_channel:
	sta chan_env_stage,x
	sta chan_level,x
	sta chan_level + 1,x
	dex
	dex                 ;BUGFIX: channel data is two bytes wide
	bpl @next_channel

	ldy #mb_reg_ACR ; Auxiliary Control Register
	lda #ACR_T1_reload_counters ;Timer 1 => auto repeat
	sta (mb_io_base),y

	ldy #mb_reg_T1CL
	lda mb_irq_clock
	sta (mb_io_base),y

	ldy #mb_reg_T1CH
	lda mb_irq_clock + 1
	sta (mb_io_base),y ;writing to HI starts the timer

	ldy #mb_reg_IER ; Interrupt Enable Register
	lda #VIA_IER_set + VIA_INT_timer_1
	sta (mb_io_base),y

	rts

cur_psg:
	.byte 0
cur_echo_psg:  ; ENHANCEMENT
	.byte 0	
chan_current:
	.byte 0
tune_channels_inuse:
	.byte 0
tune_channels_exist:
	.byte 0
num_patterns:
	.byte 0
pattern_table_size:
	.byte 0
unused:
	.byte 0
num_tunes:
	.byte 0
any_channel_active:
	.byte 0
frequency:
	.word $0000
mb_irq_clock:
	.word clock_default

;-------------------
	.segment "PRG_2"

psg1_next_values:
	.res 16
psg2_next_values:
	.res 16
psg1_cur_values:
	.res 16
psg2_cur_values:
	.res 16
chan_next_addr:
	.word $0000,$0000,$0000,$0000,$0000,$0000
chan_cur_addr:
	.word $0000,$0000,$0000,$0000,$0000,$0000
chan_io_base:
	.word $0000,$0000,$0000,$0000,$0000,$0000
chan_freq_reg:
	.byte 0
chan_level_reg:
	.byte 0
	.word $0000,$0000,$0000,$0000,$0000
num_psgs:
	.byte 0
mb_num_channels:
	.byte 0
music_mute:   ;ENHANCEMENT
	.byte $ff
echo_psg:     ;ENHANCEMENT - bit value to address first psg on Echo+ card
	.byte 0

;-------------------
	.segment "PRG_3"

mb_irq_handler:
	pha
	txa
	pha
	tya
	pha
	cld

	jsr music_update
	jsr set_psg_registers

	ldy #mb_reg_T1LL  ;timer 1 latch LO
	lda mb_irq_clock
	sta (mb_io_base),y

	iny ;mb_reg_T1LH  ;timer 1 latch HI
	lda mb_irq_clock + 1
	sta (mb_io_base),y

	ldy #mb_reg_T1CL  ;reading clock LO starts the timer
	lda (mb_io_base),y

	pla
	tay
	pla
	tax
	pla
	rti

read_channel_byte:
	lda (chan_cursor,x)
	inc chan_cursor,x
	bne :+
	inc chan_cursor + 1,x
:	ora #$00
	rts

music_stop:
	lda tune_playing
	beq @done
	lda #$00
	sta tune_playing
	ldx num_psgs
	dex
	txa
	asl
	tax
@next_psg:
	lda chan_next_addr,x
	sta next_values
	lda chan_next_addr + 1,x
	sta next_values + 1
	ldy #psg_reg_level_C
@next_register:
	lda #$00
	cpy #psg_reg_voice_enable
	bne :+
	lda #voice_disable_noise_ABC
:	sta (next_values),y
	dey
	bpl @next_register
	dex
	dex
	bpl @next_psg

	ldy #mb_reg_IER
	lda #VIA_IER_clr + VIA_INT_timer_1
	sta (mb_io_base),y
@done:
	rts

;-------------------
	.segment "PRG_4"

set_psg_registers:
	lda echo_psg        ; ENHANCEMENT  if Echo+, this will be 0x08 for CHN1
	ldx num_psgs
	dex
	stx cur_psg
	beq :+              ; ENHANCEMENT
	asl                 ; ENHANCEMENT  if Echo+, adjust to 0x10 for CHN2
:	sta cur_echo_psg    ; ENHANCEMENT
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
	ldx #psg_reg_level_C
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
	ora cur_echo_psg  ; ENHANCEMENT
	sta (psg_io),y
	lda #psg_cmd_inactive
	ora cur_echo_psg  ; ENHANCEMENT
	sta (psg_io),y
	ldy #mb_reg_ORA
	pla          ;set register X to value A
	sta (psg_io),y
	ldy #mb_reg_ORB
	lda #psg_cmd_write
	ora cur_echo_psg  ; ENHANCEMENT
	sta (psg_io),y
	lda #psg_cmd_inactive
	ora cur_echo_psg  ; ENHANCEMENT
	sta (psg_io),y
@skip:
	dex
	bpl @next_register
	lsr cur_echo_psg  ; ENHANCEMENT
	dec cur_psg
	bpl @next_psg
	rts

;-------------------
	.segment "PRG_5"

; 8 octaves, G# 0 through G 8
freq_table_lo:
	.byte $15,$93,$17,$a3,$35,$ce,$6c,$10
	.byte $b9,$66,$19,$d0,$8b,$49,$0c,$d2
	.byte $9b,$67,$36,$08,$dc,$b3,$8c,$68
	.byte $45,$25,$06,$e9,$cd,$b3,$9b,$84
	.byte $6e,$5a,$46,$34,$23,$12,$03,$f4
	.byte $e7,$da,$ce,$c2,$b7,$ad,$a3,$9a
	.byte $91,$89,$81,$7a,$73,$6d,$67,$61
	.byte $5c,$56,$52,$4d,$49,$45,$41,$3d
	.byte $3a,$36,$33,$30,$2e,$2b,$29,$26
	.byte $24,$22,$20,$1f,$1d,$1b,$1a,$18
	.byte $17,$16,$14,$13,$12,$11,$10,$0f
	.byte $0e,$0e,$0d,$0c,$0b,$0b,$0a,$0a

;-------------------
	.segment "PRG_6"

freq_table_hi:
	.byte $09,$08,$08,$07,$07,$06,$06,$06
	.byte $05,$05,$05,$04,$04,$04,$04,$03
	.byte $03,$03,$03,$03,$02,$02,$02,$02
	.byte $02,$02,$02,$01,$01,$01,$01,$01
	.byte $01,$01,$01,$01,$01,$01,$01,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00

;-------------------
	.segment "PRG_7"

chan_env_stage:
	.byte 0
chan_active:
	.byte 0
	.word $0000,$0000,$0000,$0000,$0000
chan_env_duration:
	.byte 0
chan_note_duration:
	.byte 0
	.word $0000,$0000,$0000,$0000,$0000
chan_env_rel_dur:
	.byte 0
chan_transpose:
	.byte 0
	.word $0000,$0000,$0000,$0000,$0000
chan_pitch_bend:
	.word $0000,$0000,$0000,$0000,$0000,$0000
chan_env_atk_rate:
	.word $0000,$0000,$0000,$0000,$0000,$0000
chan_env_decay:
	.word $0000,$0000,$0000,$0000,$0000,$0000
chan_env_sus_lev:
	.word $0000,$0000,$0000,$0000,$0000,$0000
chan_env_rel_rate:
	.word $0000,$0000,$0000,$0000,$0000,$0000
chan_env_atk_lev:
	.word $0000,$0000,$0000,$0000,$0000,$0000
chan_level:
	.word $0000,$0000,$0000,$0000,$0000,$0000

;-------------------
	.segment "PRG_8"

tune_addr:
	.word $0000,$0000,$0000,$0000
	.word $0000,$0000,$0000,$0000
pattern_addr:
	.word $0000,$0000,$0000,$0000,$0000
	.word $0000,$0000,$0000,$0000,$0000
	.word $0000,$0000,$0000,$0000,$0000
	.word $0000,$0000,$0000,$0000,$0000
	.word $0000,$0000,$0000,$0000,$0000
	.word $0000,$0000,$0000,$0000,$0000
	.word $0000,$0000,$0000,$0000,$0000
	.word $0000,$0000,$0000,$0000,$0000
	.word $0000,$0000,$0000,$0000,$0000
	.word $0000,$0000,$0000,$0000,$0000
	.word $0000,$0000

;-------------------
	.segment "MAIN"

; Called from IRQ handler
music_update:
	lda tune_req_now
	bne @req_play
	jmp music_stop

@req_play:
	cmp num_tunes
	bcc @tune_exists
	lda tune_playing
	sta tune_req_now
@tune_exists:
	cmp tune_playing
	bne change_tune
	jmp update_tune

change_tune:
	sta tune_playing
	asl
	tax
	lda tune_addr,x
	sta mus_ptr
	lda tune_addr + 1,x
	sta mus_ptr + 1
	ldy #$00
	lda (mus_ptr),y
	sta tune_channels_exist
	tax
	dex
	cmp mb_num_channels
	bcc :+
	lda mb_num_channels
:	sta tune_channels_inuse
@next_cursor:
	iny
	clc
	lda (mus_ptr),y
	adc mus_ptr
	sta chan_cursor - 1,y
	iny
	lda (mus_ptr),y
	adc mus_ptr + 1
	sta chan_cursor - 1,y
	dex
	bpl @next_cursor
	iny
	lda (mus_ptr),y
	sta num_patterns
	beq @initialize_channels
	asl
	sta pattern_table_size
	ldx #$00
@next_pattern:
	iny
	clc
	lda (mus_ptr),y
	adc mus_ptr
	sta pattern_addr,x
	iny
	inx
	lda (mus_ptr),y
	adc mus_ptr + 1
	sta pattern_addr,x
	inx
	cpx pattern_table_size
	bne @next_pattern
@initialize_channels:
	ldx tune_channels_inuse
	ldy #$00
@next_channel:
	lda #$00
	sta chan_transpose,y
	sta chan_pitch_bend,y
	sta chan_pitch_bend+1,y
	sta chan_active,y
	lda #$01
	sta chan_env_duration,y
	iny
	iny
	dex
	bne @next_channel
	lda #<clock_default
	sta mb_irq_clock
	lda #>clock_default
	sta mb_irq_clock + 1

update_tune:
	lda #$ff
	sta any_channel_active
	ldx tune_channels_inuse
	dex
	stx chan_current
update_next_channel:
	lda chan_current
	asl
	tax
	lda chan_next_addr,x
	sta next_values
	lda chan_next_addr + 1,x
	sta next_values + 1
	lda chan_active,x
	bne update_envelope ;inactive
	sta any_channel_active
	dec chan_env_duration,x
	bne update_envelope
next_channel_data:
	jsr read_channel_byte
	bne @note_length
	jmp next_channel_cmd

@note_length:
	bpl @note_pitch
	and #$7f
	beq @note_stop
	sta chan_note_duration,x
	bne next_channel_data
@note_stop:
	lda #env_release
	sta chan_env_stage,x
	bne @start_env_duration
@note_pitch:
	clc
	adc chan_transpose,x
	tay
	clc
	lda freq_table_lo,y
	adc chan_pitch_bend,x
	sta frequency
	lda freq_table_hi,y
	adc chan_pitch_bend+1,x
	sta frequency + 1

	ldy chan_freq_reg,x
	lda frequency
	sta (next_values),y
	iny
	lda frequency + 1
	sta (next_values),y

	lda #env_attack
	sta chan_env_stage,x
@start_env_duration:
	lda chan_note_duration,x
	sta chan_env_duration,x

update_envelope:
	lda chan_env_stage,x
	bne @attack
	jmp env_done

@attack:
	cmp #env_attack
	bne @decay
	clc
	lda chan_level,x
	adc chan_env_atk_rate,x
	sta chan_level,x
	lda chan_level + 1,x
	adc chan_env_atk_rate+1,x
	sta chan_level + 1,x
	bcs @attack_end
	cmp chan_env_atk_lev+1,x
	bne :+
	lda chan_level,x
	cmp chan_env_atk_lev,x
:	bcc :+
@attack_end:
	lda chan_env_atk_lev,x
	sta chan_level,x
	lda chan_env_atk_lev+1,x
	sta chan_level + 1,x
	inc chan_env_stage,x
:	jmp @sustain

@decay:
	cmp #env_decay
	bne @release
	sec
	lda chan_level,x
	sbc chan_env_decay,x
	sta chan_level,x
	lda chan_level + 1,x
	sbc chan_env_decay + 1,x
	sta chan_level + 1,x
	bcc @decay_end
	cmp chan_env_sus_lev+1,x
	bne :+
	lda chan_level,x
	cmp chan_env_sus_lev,x
:	bcs :+
@decay_end:
	lda chan_env_sus_lev,x
	sta chan_level,x
	lda chan_env_sus_lev+1,x
	sta chan_level + 1,x
	inc chan_env_stage,x
:	jmp @sustain

@release:
	cmp #env_release
	bne @sustain
	sec
	lda chan_level,x
	sbc chan_env_rel_rate,x
	sta chan_level,x
	lda chan_level + 1,x
	sbc chan_env_rel_rate+1,x
	sta chan_level + 1,x
	bcs :+
	lda #$00
	sta chan_level,x
	sta chan_level + 1,x
	sta chan_env_stage,x
:	jmp @set_level

@sustain:
	lda chan_env_duration,x
	cmp chan_env_rel_dur,x
	bcs @set_level
	lda #env_release
	sta chan_env_stage,x
@set_level:
	ldy chan_level_reg,x
	lda chan_level + 1,x
	and music_mute    ;ENHANCEMENT
	sta (next_values),y
env_done:
	dec chan_current
	bmi @check_tune_done
	jmp update_next_channel

@check_tune_done:
	lda any_channel_active
	beq update_done
next_tune:
	lda tune_queue_next
	bne @validate
	jmp music_stop

@validate:
	cmp num_tunes
	bcc @valid
	lda tune_playing
@valid:
	sta tune_req_now
	jmp change_tune

update_done:
	rts

next_channel_cmd:
	jsr read_channel_byte
	beq next_tune
	bpl @set_parameter
	jmp @do_cmd

@set_parameter:
	cmp #mus_cmd_env_rel_dur
	beq @set_env_rel_dur
	cmp #mus_cmd_transpose
	beq @set_transpose
	cmp #mus_cmd_env_pitch_bend
	beq @set_pitch_bend
	cmp #mus_cmd_env_atk_rate
	beq @set_env_atk_rate
	cmp #mus_cmd_env_decay
	beq @set_env_decay
	cmp #mus_cmd_env_sus_lev
	beq @set_env_sus_lev
	cmp #mus_cmd_env_rel_rate
	beq @set_env_rel_rate
	cmp #mus_cmd_env_atk_lev
	beq @set_env_atk_lev
	jmp next_channel_data

@set_env_rel_dur:
	jsr read_channel_byte
	sta chan_env_rel_dur,x
	jmp next_channel_cmd

@set_transpose:
	jsr read_channel_byte
	sta chan_transpose,x
	jmp next_channel_cmd

@set_pitch_bend:
	jsr read_channel_byte
	sta chan_pitch_bend,x
	jsr read_channel_byte
	sta chan_pitch_bend+1,x
	jmp next_channel_cmd

@set_env_atk_rate:
	jsr read_channel_byte
	sta chan_env_atk_rate,x
	jsr read_channel_byte
	sta chan_env_atk_rate+1,x
	jmp next_channel_cmd

@set_env_decay:
	jsr read_channel_byte
	sta chan_env_decay,x
	jsr read_channel_byte
	sta chan_env_decay + 1,x
	jmp next_channel_cmd

@set_env_sus_lev:
	jsr read_channel_byte
	sta chan_env_sus_lev,x
	jsr read_channel_byte
	sta chan_env_sus_lev+1,x
	jmp next_channel_cmd

@set_env_rel_rate:
	jsr read_channel_byte
	sta chan_env_rel_rate,x
	jsr read_channel_byte
	sta chan_env_rel_rate+1,x
	jmp next_channel_cmd

@set_env_atk_lev:
	jsr read_channel_byte
	sta chan_env_atk_lev,x
	jsr read_channel_byte
	sta chan_env_atk_lev+1,x
	jmp next_channel_cmd

@do_cmd:
	cmp #mus_cmd_jsr_pattern
	bne @rts_pattern
	jsr read_channel_byte
	cmp num_patterns
	bcc @jsr_pattern
	jmp next_channel_data

; Store this channel's cursor in its entry in the pattern's return_address table, then start that pattern.
@jsr_pattern:
	asl
	tay
	lda pattern_addr,y
	sta mus_ptr
	lda pattern_addr + 1,y
	sta mus_ptr + 1
	txa
	tay
	lda chan_cursor,x
	sta (mus_ptr),y
	iny
	lda chan_cursor + 1,x
	sta (mus_ptr),y
	lda tune_channels_exist
	asl
	adc mus_ptr
	sta chan_cursor,x
	lda #$00
	adc mus_ptr + 1
	sta chan_cursor + 1,x
	jmp next_channel_data

; Restore this channel's cursor from its entry in the pattern return address table, then continue from there.
@rts_pattern:
	cmp #mus_cmd_rts_pattern
	bne @end_pattern
	jsr read_channel_byte
	asl
	tay
	lda pattern_addr,y
	sta mus_ptr
	lda pattern_addr + 1,y
	sta mus_ptr + 1
	txa
	tay
	lda (mus_ptr),y
	sta chan_cursor,x
	iny
	lda (mus_ptr),y
	sta chan_cursor + 1,x
	jmp next_channel_data

@end_pattern:
	cmp #mus_cmd_end_pattern
	bne @set_irq_rate
	lda #$ff
	sta chan_active,x
	lda #env_release
	sta chan_env_stage,x
	jmp env_done

@set_irq_rate:
	cmp #mus_cmd_poll_interval
	bne @done
	jsr read_channel_byte
	sta mb_irq_clock
	jsr read_channel_byte
	sta mb_irq_clock + 1
@done:
	jmp next_channel_data

; junk
;	.byte 0
