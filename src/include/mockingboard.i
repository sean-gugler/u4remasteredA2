;Abbreviations
;  MB = Mockingboard
;  PSG = programmable sound generator (AY-3-8913 chip)


;Rockwell 6522 VIA (Versatile Interface Adapter)
;is the gatekeeper to the Mockingboard PSG
;
;Offsets in Apple II I/O page, for use with: STA (psg_io),y
;e.g. $C48E raw address
;      C = I/O pages
;       4 = slot 4
;        8 = PSG 2  (0 = PSG 1)
;         E = reg IER

mb_reg_ORB    = $00  ;Output Register for Port B (psg command)
mb_reg_ORA    = $01  ;Output Register for Port A (psg data)
mb_reg_DDRB   = $02  ;Data Direction Register for Port B  [2]
mb_reg_DDRA   = $03  ;Data Direction Register for Port A  [2]
mb_reg_T1LLc  = $04  ;Timer 1 Latch (LO)   [Write]
mb_reg_T1CL   = $04  ;Timer 1 Counter (LO) [Read]   [1]
mb_reg_T1CH   = $05  ;Timer 1 Counter (HI)          [1]
mb_reg_T1LL   = $06  ;Timer 1 Latch (LO)
mb_reg_T1LH   = $07  ;Timer 1 Latch (HI)
mb_reg_T2LL   = $08  ;Timer 2 Latch (LO)   [Write]
mb_reg_T2CL   = $08  ;Timer 2 Counter (LO) [Read]   [1]
mb_reg_T2CH   = $09  ;Timer 2 Counter (HI)          [1]
mb_reg_SR     = $0a  ;Shift Register                [3]
mb_reg_ACR    = $0b  ;Auxiliary Control Register
mb_reg_PCR    = $0c  ;Peripheral Control Register
mb_reg_IFR    = $0d  ;Interrupt Flag Register  (Read mask $FF poll, Write mask $7F clear)
mb_reg_IER    = $0e  ;Interrupt Enable Register
mb_reg_ORA_nh = $0f  ;Same as reg 1 but with No Handshake

ACR_T1_PB7             = %10000000   ;[3]  0 = ignore PB7, 1 = when counter expires, raise it (one-shot) or toggle it (repeat)
ACR_T1_reload_counters = %01000000   ;     0 = one-shot, 1 = repeat
ACR_T2_from_PB6        = %00100000   ;     0 = one-shot, 1 = clock from PB6
ACR_SR_direction_out   = %00010000   ;[3]  0 = in, 1 = out, through CB2
ACR_PB_latch_enable    = %00000010
ACR_PA_latch_enable    = %00000001

VIA_IFR_any     = %10000000

; Combine one of these with any of the bits below to set or clear those bits
VIA_IER_set     = %10000000
VIA_IER_clr     = %00000000

VIA_INT_timer_1 = %01000000
VIA_INT_timer_2 = %00100000
VIA_INT_CB1     = %00010000   ; [3]
VIA_INT_CB2     = %00001000   ; [3]
VIA_INT_SR      = %00000100   ; [3]
VIA_INT_CA1     = %00000010   ; [3]
VIA_INT_CA2     = %00000001   ; [3]

; NOTES
;
; General VIA
; [1] Read TxCL or Write TxCH will reset Tx Interrupt Flag.
;
; The way VIA is wired to a PSG on Mockingboard
; [2] DDR must be OUT. PSG does not send anything useful to INA/INB.
; [3] PB7,PB6,CA1,CA2,CB1,CB2 are unused. These pins are connected to nothing.
; (Some of these are used when wired to a speech chip)

;-------
; Set these values on mb_reg_ORB

psg_cmd_reset        = $00
psg_cmd_inactive     = $04
psg_cmd_write        = $06  ;set psg register value
psg_cmd_latch        = $07  ;select psg register


;-------
; Set these values on mb_reg_ORA, for use with psg_cmd_latch

psg_reg_freq_lo_A    = $00
psg_reg_freq_hi_A    = $01
psg_reg_freq_lo_B    = $02
psg_reg_freq_hi_B    = $03
psg_reg_freq_lo_C    = $04
psg_reg_freq_hi_C    = $05
psg_reg_freq_noise   = $06
psg_reg_voice_enable = $07
psg_reg_level_A      = $08
psg_reg_level_B      = $09
psg_reg_level_C      = $0a
psg_reg_env_freq_hi  = $0b
psg_reg_env_freq_lo  = $0c
psg_reg_env_shape    = $0d

psg_reg_last         = $0a

;-------
; Set these values on mb_reg_ORA, for use with psg_cmd_write
; after latching to specified psg register

; psg_reg_voice_enable:

voice_disable_noise_A = %00100000
voice_disable_noise_B = %00010000
voice_disable_noise_C = %00001000
voice_disable_tone_A  = %00000100
voice_disable_tone_B  = %00000010
voice_disable_tone_C  = %00000001

.linecont +
	voice_disable_noise_ABC = \
		voice_disable_noise_A + \
		voice_disable_noise_B + \
		voice_disable_noise_C
.linecont -
