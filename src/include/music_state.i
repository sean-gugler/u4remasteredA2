;Abbreviations
;  MB = Mockingboard
;  PSG = programmable sound generator (AY-3-8913 chip)

; --- DATA

psg1_next_values = $0480
psg2_next_values = $0490
psg1_cur_values = $04a0
psg2_cur_values = $04b0
chan_next_addr = $04c0
chan_cur_addr = $04cc
chan_io_base = $04d8
chan_freq_reg = $04e4
chan_level_reg = $04e5
num_psgs = $04f0
mb_num_channels = $04f1

; --- ROUTINES

music_start = $0400
mb_irq_handler = $0500
music_update = $fd00
music_data = $f000

; --- VALUES

max_mb_type = $04
max_slot = $08
max_channels = $06
