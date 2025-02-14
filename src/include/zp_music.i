; For MSBI set up only

mb_1_slot = $80
mb_1_type = $81
mb_2_slot = $82
mb_2_type = $83

mb_count = $b0

; While driver is active

tune_req_now = $80
tune_queue_next = $81
tune_playing = $82

; Two-byte pointers

mus_ptr = $84
mb_io_base = $86
psg_io = $88
chan_cursor = $8a
;chan1_cursor = $8a
;chan2_cursor = $8c
;chan3_cursor = $8e
;chan4_cursor = $90
;chan5_cursor = $92
;chan6_cursor = $94
next_values = $96
cur_values = $98
relocate_src = $9a
relocate_dst = $9c
