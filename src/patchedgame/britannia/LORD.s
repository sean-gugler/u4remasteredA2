	.include "uscii.i"
	.include "LORD.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
party_size = $0f
player_has_spoken_to_lb = $15
console_xpos = $ce
curr_player = $d4
zp_level_or_index = $ea
zpf0 = $f0
ptr1 = $fe
;ptr1 + 1 = $ff
;
; **** ZP POINTERS ****
;
;ptr1 = $fe
;
; **** USER LABELS ****
;
player_xpos = $0000
player_ypos = $0001
tile_xpos = $0002
tile_ypos = $0003
map_x = $0004
map_y = $0005
dest_x = $0006
dest_y = $0007
britannia_x = $0008
britannia_y = $0009
current_location = $000a
game_mode = $000b
dungeon_level = $000c
balloon_flying = $000d
player_transport = $000e
dng_direction = $0010
light_duration = $0011
moon_phase_trammel = $0012
moon_phase_felucca = $0013
horse_mode = $0014
last_sleep = $0016
last_humility_check = $0017
altar_room_principle = $0018
last_meditated = $0019
last_found_reagent = $001a
ship_hull = $001b
move_counter = $001c
;move_counter + 1 = $001d
;move_counter + 2 = $001e
;move_counter + 3 = $001f
kbd_buf_count = $0046
key_buf = $00b0
;key_buf+1 = $00b1
key_buf_len = $00b8
charptr = $00bd
;charptr+1 = $00be
foe_type_encountered = $00c0
pre_combat_x = $00c1
pre_combat_y = $00c2
pre_combat_tile = $00c3
curr_player_turn = $00c5
magic_aura = $00c6
aura_duration = $00c7
tile_under_player = $00c8
tile_north = $00c9
tile_south = $00ca
tile_east = $00cb
tile_west = $00cc
music_volume = $00cd
console_ypos = $00cf
diskid = $00d0
numdrives = $00d1
currdisk_drive1 = $00d2
currdisk_drive2 = $00d3
target_player = $00d5
hexnum = $00d6
bcdnum = $00d7
zpd8 = $00d8
zpd9 = $00d9
zpda = $00da
zpdb = $00db
damage = $00dc
reqdisk = $00de
currdrive = $00df
lt_track = $00e0
lt_sector = $00e1
lt_rwflag = $00e2
lt_addr_hi = $00e3
foe_type_combat = $00e6
game_mode_pre_combat = $00e8
turn_counter = $00e9
moongate_tile = $00ed
moongate_xpos = $00ee
moongate_ypos = $00ef
tilerow = $00f2
movement_mode = $00f4
direction = $00f5
temp2_x = $00f6
temp2_y = $00f7
delta_x = $00f8
delta_y = $00f9
temp_x = $00fa
temp_y = $00fb
ptr2 = $00fc
;ptr2 + 1 = $00fd
draw_stack = $0200
room_start_foe_type = $0210
room_start_foe_x = $0220
room_start_foe_y = $0230
map_start_foe_x = $0240
room_start_player_y = $0248
map_start_foe_y = $0250
map_start_player_x = $0260
map_start_player_y = $0268
tempmap = $0280
inbuffer = $0300
dng_trigger_new_tile = $0310
dng_trigger_pos = $0311
dng_trigger_new_pos1 = $0312
dng_trigger_new_pos2 = $0313
music_ctl = $0320
spin_drive_motor = $0323
screen = $0400
j_waitkey = $0800
j_player_teleport = $0803
j_move_east = $0806
j_move_west = $0809
j_move_south = $080c
j_move_north = $080f
j_drawinterface = $0812
j_drawview = $0815
j_update_britannia = $0818
j_primm_cout = $081b
j_primm_xy = $081e
j_primm = $0821
j_console_out = $0824
j_clearbitmap = $0827
j_mulax = $082a
j_get_stats_ptr = $082d
j_printname = $0830
j_printbcd = $0833
j_drawcursor = $0836
j_drawcursor_xy = $0839
j_drawvert = $083c
j_drawhoriz = $083f
j_request_disk = $0842
j_update_status = $0845
j_blocked_tile = $0848
j_update_view = $084b
j_rand = $084e
j_loadsector = $0851
j_playsfx = $0854
j_update_view_combat = $0857
j_getnumber = $085a
j_getplayernum = $085d
j_update_wind = $0860
j_animate_view = $0863
j_printdigit = $0866
j_clearstatwindow = $0869
j_animate_tiles = $086c
j_centername = $086f
j_print_direction = $0872
j_clearview = $0875
j_invertview = $0878
j_centerstring = $087b
j_printstring = $087e
j_gettile_bounds = $0881
j_gettile_britannia = $0884
j_gettile_opposite = $0887
j_gettile_currmap = $088a
j_gettile_tempmap = $088d
j_get_player_tile = $0890
j_gettile_towne = $0893
j_gettile_dungeon = $0896
bitmap = $2000
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
hw_lcbank1 = $c08b
bmplineaddr_lo = $e000
;bmplineaddr_lo + 7 = $e007
;bmplineaddr_lo + 8 = $e008
;bmplineaddr_lo + 9 = $e009
;bmplineaddr_lo + 10 = $e00a
bmplineaddr_hi = $e0c0
;bmplineaddr_hi + 7 = $e0c7
;bmplineaddr_hi + 8 = $e0c8
;bmplineaddr_hi + 9 = $e0c9
;bmplineaddr_hi + 10 = $e0ca
player_stats = $ec00
party_stats = $ed00
;party_stats + 1 = $ed01
torches = $ed08
gems = $ed09
keys = $ed0a
sextant = $ed0b
stones = $ed0c
runes = $ed0d
bell_book_candle = $ed0e
threepartkey = $ed0f
food_hi = $ed10
food_lo = $ed11
food_frac = $ed12
gold_hi = $ed13
gold_lo = $ed14
horn = $ed15
wheel = $ed16
skull = $ed17
armour = $ed18
weapons = $ed20
reagents = $ed38
mixtures = $ed40
object_tile_sprite = $ee00
;object_tile_sprite + object_max = $ee1f
object_xpos = $ee20
;object_xpos + object_max = $ee3f
object_ypos = $ee40
;object_ypos + object_max = $ee5f
object_tile_type = $ee60
;object_tile_type + object_max = $ee7f
object_xpos_prev = $ee80
object_ypos_prev = $eea0
object_dng_level = $eec0
npc_dialogue = $eee0
combat_foe_cur_x = $ef00
combat_foe_cur_y = $ef10
combat_foe_prev_x = $ef20
combat_foe_prev_y = $ef30
combat_foe_hp = $ef40
combat_foe_tile = $ef50
combat_foe_drawn_tile = $ef60
combat_foe_slept = $ef70
;combat_player_xpos-1 = $ef7f
combat_player_xpos = $ef80
;combat_player_ypos-1 = $ef8f
combat_player_ypos = $ef90
;combat_player_tile-1 = $ef9f
combat_player_tile = $efa0
attack_sprite = $effd
target_x = $effe
target_y = $efff



	.segment "OVERLAY"

j_overlay_entry:
	pla   ; pop 2 frames left from entering by BRUN from HELP
	pla
	pla
	pla
	jmp next_question

; Entry point from ULT4, which uses BLOAD not BRUN
talk_lord_british:
	lda player_has_spoken_to_lb
	bne @check_alive
	inc player_has_spoken_to_lb
	jmp lb_intro

@check_alive:
; This routine is non-functional because of the BUG below.
	lda #$01
	sta curr_player
	jsr j_get_stats_ptr
	ldy #$45     ;BUG: should be #$12 - no idea where #$45 came from.
	lda (ptr1),y
	cmp #status_Dead
	bne @alive
	lda #status_Good
	sta (ptr1),y
	jsr j_printname
	jsr j_primm  ;b'THOU SHALT\nLIVE AGAIN!\n\x00'
	.byte "THOU SHALT", $8d
	.byte "LIVE AGAIN!", $8d
	.byte 0
	ldx #$14
	lda #sound_cast
	jsr j_playsfx
	jsr j_invertview
	lda #sound_spell_effect
	ldx #$c0
	jsr j_playsfx
	jsr j_invertview
	jsr restore_party_hp
	jsr j_update_status
@alive:
	jsr j_primm  ;b'LORD BRITISH\nSAYS: WELCOME\n\x00'
	.byte "LORD BRITISH", $8d
	.byte "SAYS: WELCOME", $8d
	.byte 0
	lda #$01
	sta curr_player
	jsr j_printname
	lda party_size
	cmp #$02
	bcc @alone
	beq @one_companion
	bcs @three_or_more
@alone:
	jsr j_primm  ;b'\nMY FRIEND!\n\x00'
	.byte $8d
	.byte "MY FRIEND!", $8d
	.byte 0
	jmp check_xp

@one_companion:
	jsr j_primm  ;b'\nAND THEE ALSO\n\x00'
	.byte $8d
	.byte "AND THEE ALSO", $8d
	.byte 0
	inc curr_player
	jsr j_printname
	jsr j_primm  ;b'!\n\x00'
	.byte "!", $8d
	.byte 0
	jmp check_xp

@three_or_more:
	jsr j_primm  ;b'\nAND THY WORTHY\nADVENTURERS!\n\x00'
	.byte $8d
	.byte "AND THY WORTHY", $8d
	.byte "ADVENTURERS!", $8d
	.byte 0

check_xp:
	lda party_size
	sta curr_player
@next:
	jsr j_get_stats_ptr
	ldy #player_experience_hi
	lda (ptr1),y
	jsr decode_bcd_value
	ldx #$01
@log_2:
	cmp #$00
	beq @check_level
	lsr
	inx
	jmp @log_2

@check_level:
	txa
	ldy #player_max_hp_hi
	cmp (ptr1),y
	beq @already_at_level
	sta (ptr1),y
	sta zp_level_or_index
	ldy #$18
	sta (ptr1),y
	lda #$00
	iny
	sta (ptr1),y
	jsr j_get_stats_ptr
	ldy #player_status
	lda #$c7     ;status_Good
	sta (ptr1),y
	ldy #player_intelligence
@inc_stat:
	jsr j_rand
	and #$07
	sed
	sec
	adc (ptr1),y
	cld
	cmp #$51
	bcc @less_than_51
	lda #$50
@less_than_51:
	sta (ptr1),y
	dey
	cpy #player_strength
	bcs @inc_stat
	jsr print_newline
	jsr j_printname
	jsr j_primm  ;b'\nTHOU ART NOW\nLEVEL \x00'
	.byte $8d
	.byte "THOU ART NOW", $8d
	.byte "LEVEL ", 0
	lda zp_level_or_index
	jsr j_printdigit
	jsr print_newline
	jsr j_invertview
	lda #sound_spell_effect
	ldx #$c0
	jsr j_playsfx
	jsr j_invertview
	jsr j_update_status
@already_at_level:
	dec curr_player
	beq @ask_me
	jmp @next

@ask_me:
	jsr j_primm  ;b'\nWHAT WOULD THOU\nASK OF ME?\n\x00'
	.byte $8d
	.byte "WHAT WOULD THOU", $8d
	.byte "ASK OF ME?", $8d
	.byte 0
	jmp input_word

next_question:
	lda #$01
	jsr music_ctl
	jsr j_primm  ;b'\nWHAT ELSE?\n\x00'
	.byte $8d
	.byte "WHAT ELSE?", $8d
	.byte 0
input_word:
	jsr get_input
	jsr check_keyword
	bpl jump_to_keyword
	jsr print_he_says
	jsr j_primm  ;b'I CANNOT HELP\nTHEE WITH THAT.\n\x00'
	.byte "I CANNOT HELP", $8d
	.byte "THEE WITH THAT.", $8d
	.byte 0
	jmp next_question

jump_to_keyword:
	asl
	tay
	lda keyword_jumptable,y
	sta ptr1
	lda keyword_jumptable+1,y
	sta ptr1 + 1
	jmp (ptr1)

keyword_jumptable:
	.addr answer_bye
	.addr answer_bye
	.addr answer_name
	.addr answer_look
	.addr answer_job
	.addr answer_heal
	.addr answer_truth
	.addr answer_love
	.addr answer_courage
	.addr answer_honesty
	.addr answer_compassion
	.addr answer_valor
	.addr answer_justice
	.addr answer_sacrifice
	.addr answer_honor
	.addr answer_spirituality
	.addr answer_humility
	.addr answer_pride
	.addr answer_avatar
	.addr answer_quest
	.addr answer_britannia
	.addr answer_ankh
	.addr answer_help
	.addr answer_abyss
	.addr answer_mondain
	.addr answer_minax
	.addr answer_exodus
	.addr answer_virtue

print_lb_says:
	jsr j_primm  ;b'\nLORD BRITISH\nSAYS: \n\x00'
	.byte $8d
	.byte "LORD BRITISH", $8d
	.byte "SAYS: ", $8d
	.byte 0
	rts

print_he_says:
	jsr j_primm  ;b'\nHE SAYS:\n\x00'
	.byte $8d
	.byte "HE SAYS:", $8d
	.byte 0
	rts

print_he_asks:
	jsr j_primm  ;b'\nHE ASKS:\n\x00'
	.byte $8d
	.byte "HE ASKS:", $8d
	.byte 0
print_newline:
	lda #$8d
	jsr j_console_out
	rts

ask_y_or_n:
	jsr get_input
	lda inbuffer
	cmp #char_Y
	beq @yes
	cmp #char_N
	beq @no
	jsr j_primm  ;b'\nYES OR NO:\n\x00'
	.byte $8d
	.byte "YES OR NO:", $8d
	.byte 0
	rts

	jmp ask_y_or_n

@yes:
	lda #$00
	rts

@no:
	lda #$01
	rts

answer_bye:
	jsr print_lb_says
	jsr j_primm  ;b'FARE THEE\nWELL MY FRIEND\x00'
	.byte "FARE THEE", $8d
	.byte "WELL MY FRIEND", 0
	lda party_size
	cmp #$01
	bne @plural
	jsr j_primm  ;b'!\n\x00'
	.byte "!", $8d
	.byte 0
	jmp exit_conversation

@plural:
	jsr j_primm  ;b'S!\n\x00'
	.byte "S!", $8d
	.byte 0
	jmp exit_conversation

answer_name:
	jsr print_he_says
	jsr j_primm  ;b'MY NAME IS\nLORD BRITISH,\nSOVEREIGN OF\nALL BRITANNIA!\n\x00'
	.byte "MY NAME IS", $8d
	.byte "LORD BRITISH,", $8d
	.byte "SOVEREIGN OF", $8d
	.byte "ALL BRITANNIA!", $8d
	.byte 0
	jmp next_question

answer_look:
	jsr j_primm  ;b'THOU SEE THE\nKING WITH THE\nROYAL SCEPTRE.\n\x00'
	.byte "THOU SEE THE", $8d
	.byte "KING WITH THE", $8d
	.byte "ROYAL SCEPTRE.", $8d
	.byte 0
	jmp next_question

answer_job:
	jsr print_he_says
	jsr j_primm  ;b'I RULE ALL\nBRITANNIA, AND\nSHALL DO MY BEST\nTO HELP THEE!\n\x00'
	.byte "I RULE ALL", $8d
	.byte "BRITANNIA, AND", $8d
	.byte "SHALL DO MY BEST", $8d
	.byte "TO HELP THEE!", $8d
	.byte 0
	jmp next_question

answer_heal:
	jsr print_he_says
	jsr j_primm  ;b'I AM WELL,\nTHANK YE.\n\x00'
	.byte "I AM WELL,", $8d
	.byte "THANK YE.", $8d
	.byte 0
	jsr print_he_asks
	jsr j_primm  ;b'ART THOU WELL?\n\x00'
	.byte "ART THOU WELL?", $8d
	.byte 0
	jsr ask_y_or_n
	bne @notwell
	jsr print_he_says
	jsr j_primm  ;b'THAT IS GOOD.\n\x00'
	.byte "THAT IS GOOD.", $8d
	.byte 0
	jmp next_question

@notwell:
	jsr print_he_says
	jsr j_primm  ;b'LET ME HEAL\nTHY WOUNDS!\n\x00'
	.byte "LET ME HEAL", $8d
	.byte "THY WOUNDS!", $8d
	.byte 0
	ldx #$14
	lda #sound_cast
	jsr j_playsfx
	jsr j_invertview
	lda #sound_spell_effect
	ldx #$c0
	jsr j_playsfx
	jsr j_invertview
	jsr restore_party_hp
	jsr j_update_status
	jmp next_question

answer_truth:
	jsr print_he_says
	jsr j_primm  ;b'MANY TRUTHS CAN\nBE LEARNED AT\nTHE LYCAEUM. IT\nLIES ON THE\nNORTHWESTERN\nSHORE OF VERITY\nISLE!\n\x00'
	.byte "MANY TRUTHS CAN", $8d
	.byte "BE LEARNED AT", $8d
	.byte "THE LYCAEUM. IT", $8d
	.byte "LIES ON THE", $8d
	.byte "NORTHWESTERN", $8d
	.byte "SHORE OF VERITY", $8d
	.byte "ISLE!", $8d
	.byte 0
	jmp next_question

answer_love:
	jsr print_he_says
	jsr j_primm  ;b'LOOK FOR THE\nMEANING OF LOVE\nAT EMPATH ABBEY.\nTHE ABBEY SITS\nON THE WESTERN\nEDGE OF THE DEEP\nFOREST!\n\x00'
	.byte "LOOK FOR THE", $8d
	.byte "MEANING OF LOVE", $8d
	.byte "AT EMPATH ABBEY.", $8d
	.byte "THE ABBEY SITS", $8d
	.byte "ON THE WESTERN", $8d
	.byte "EDGE OF THE DEEP", $8d
	.byte "FOREST!", $8d
	.byte 0
	jmp next_question

answer_courage:
	jsr print_he_says
	jsr j_primm  ;b'SERPENT CASTLE\nON THE ISLE OF\nDEEDS IS WHERE\nCOURAGE SHOULD\nBE SOUGHT!\n\x00'
	.byte "SERPENT CASTLE", $8d
	.byte "ON THE ISLE OF", $8d
	.byte "DEEDS IS WHERE", $8d
	.byte "COURAGE SHOULD", $8d
	.byte "BE SOUGHT!", $8d
	.byte 0
	jmp next_question

answer_honesty:
	jsr print_he_says
	jsr j_primm  ;b'THE FAIR TOWNE\nOF MOONGLOW ON\nDAGGER ISLE, IS\nWHERE THE VIRTUE\nOF HONESTY\nTHRIVES!\n\x00'
	.byte "THE FAIR TOWNE", $8d
	.byte "OF MOONGLOW ON", $8d
	.byte "DAGGER ISLE, IS", $8d
	.byte "WHERE THE VIRTUE", $8d
	.byte "OF HONESTY", $8d
	.byte "THRIVES!", $8d
	.byte 0
	jmp next_question

answer_compassion:
	jsr print_he_says
	jsr j_primm  ;b'THE BARDS IN THE\nTOWNE OF BRITAIN\nARE WELL VERSED\nIN THE VIRTUE OF\nCOMPASSION!\n\x00'
	.byte "THE BARDS IN THE", $8d
	.byte "TOWNE OF BRITAIN", $8d
	.byte "ARE WELL VERSED", $8d
	.byte "IN THE VIRTUE OF", $8d
	.byte "COMPASSION!", $8d
	.byte 0
	jmp next_question

answer_valor:
	jsr print_he_says
	jsr j_primm  ;b'MANY VALIANT\nFIGHTERS COME\nFROM JHELOM,\nIN THE VALARIAN\nISLES!\n\x00'
	.byte "MANY VALIANT", $8d
	.byte "FIGHTERS COME", $8d
	.byte "FROM JHELOM,", $8d
	.byte "IN THE VALARIAN", $8d
	.byte "ISLES!", $8d
	.byte 0
	jmp next_question

answer_justice:
	jsr print_he_says
	jsr j_primm  ;b'IN THE CITY OF\nYEW, IN THE DEEP\nFOREST, JUSTICE\nIS SERVED!\n\x00'
	.byte "IN THE CITY OF", $8d
	.byte "YEW, IN THE DEEP", $8d
	.byte "FOREST, JUSTICE", $8d
	.byte "IS SERVED!", $8d
	.byte 0
	jmp next_question

answer_sacrifice:
	jsr print_he_says
	jsr j_primm  ;b'MINOC, TOWNE OF\nSELF-SACRIFICE,\nLIES ON THE\nEASTERN SHORES\nOF LOST HOPE\nBAY!\n\x00'
	.byte "MINOC, TOWNE OF", $8d
	.byte "SELF-SACRIFICE,", $8d
	.byte "LIES ON THE", $8d
	.byte "EASTERN SHORES", $8d
	.byte "OF LOST HOPE", $8d
	.byte "BAY!", $8d
	.byte 0
	jmp next_question

answer_honor:
	jsr print_he_says
	jsr j_primm  ;b'THE PALADINS WHO\nSTRIVE FOR HONOR\nARE OFT SEEN IN\nTRINSIC, NORTH\nOF THE CAPE OF\nHEROES!\n\x00'
	.byte "THE PALADINS WHO", $8d
	.byte "STRIVE FOR HONOR", $8d
	.byte "ARE OFT SEEN IN", $8d
	.byte "TRINSIC, NORTH", $8d
	.byte "OF THE CAPE OF", $8d
	.byte "HEROES!", $8d
	.byte 0
	jmp next_question

answer_spirituality:
	jsr print_he_says
	jsr j_primm  ;b'IN SKARA BRAE\nTHE SPIRITUAL\nPATH IS TAUGHT,\nFIND IT ON AN\nISLE NEAR\nSPIRITWOOD!\n\x00'
	.byte "IN SKARA BRAE", $8d
	.byte "THE SPIRITUAL", $8d
	.byte "PATH IS TAUGHT,", $8d
	.byte "FIND IT ON AN", $8d
	.byte "ISLE NEAR", $8d
	.byte "SPIRITWOOD!", $8d
	.byte 0
	jmp next_question

answer_humility:
	jsr print_he_says
	jsr j_primm  ;b'HUMILITY IS THE\nFOUNDATION OF\nVIRTUE! THE\nRUINS OF PROUD\nMAGINCIA ARE A\nTESTIMONY UNTO\nTHE VIRTUE OF\nHUMILITY!\n\x00'
	.byte "HUMILITY IS THE", $8d
	.byte "FOUNDATION OF", $8d
	.byte "VIRTUE! THE", $8d
	.byte "RUINS OF PROUD", $8d
	.byte "MAGINCIA ARE A", $8d
	.byte "TESTIMONY UNTO", $8d
	.byte "THE VIRTUE OF", $8d
	.byte "HUMILITY!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nFIND THE RUINS\nOF MAGINCIA FAR\nOFF THE SHORES\nOF BRITANNIA,\nON A SMALL ISLE\nIN THE VAST\nOCEAN!\n\x00'
	.byte $8d
	.byte "FIND THE RUINS", $8d
	.byte "OF MAGINCIA FAR", $8d
	.byte "OFF THE SHORES", $8d
	.byte "OF BRITANNIA,", $8d
	.byte "ON A SMALL ISLE", $8d
	.byte "IN THE VAST", $8d
	.byte "OCEAN!", $8d
	.byte 0
	jmp next_question

answer_pride:
	jsr print_he_says
	jsr j_primm  ;b'OF THE EIGHT\nCOMBINATIONS OF\nTRUTH, LOVE AND\nCOURAGE, THAT\nWHICH CONTAINS\nNEITHER TRUTH,\nLOVE NOR COURAGE\nIS PRIDE.\n\x00'
	.byte "OF THE EIGHT", $8d
	.byte "COMBINATIONS OF", $8d
	.byte "TRUTH, LOVE AND", $8d
	.byte "COURAGE, THAT", $8d
	.byte "WHICH CONTAINS", $8d
	.byte "NEITHER TRUTH,", $8d
	.byte "LOVE NOR COURAGE", $8d
	.byte "IS PRIDE.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nPRIDE BEING NOT\nA VIRTUE MUST BE\nSHUNNED IN FAVOR\nOF HUMILITY, THE\nVIRTUE WHICH IS\nTHE ANTITHESIS\nOF PRIDE!\n\x00'
	.byte $8d
	.byte "PRIDE BEING NOT", $8d
	.byte "A VIRTUE MUST BE", $8d
	.byte "SHUNNED IN FAVOR", $8d
	.byte "OF HUMILITY, THE", $8d
	.byte "VIRTUE WHICH IS", $8d
	.byte "THE ANTITHESIS", $8d
	.byte "OF PRIDE!", $8d
	.byte 0
	jmp next_question

answer_avatar:
	jsr print_lb_says
	jsr j_primm  ;b'TO BE AN AVATAR\nIS TO BE THE\nEMBODIMENT OF\nTHE EIGHT\nVIRTUES.\n\x00'
	.byte "TO BE AN AVATAR", $8d
	.byte "IS TO BE THE", $8d
	.byte "EMBODIMENT OF", $8d
	.byte "THE EIGHT", $8d
	.byte "VIRTUES.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nIT IS TO LIVE A\nLIFE CONSTANTLY\nAND FOREVER IN\nTHE QUEST TO\nBETTER THYSELF\nAND THE WORLD IN\nWHICH WE LIVE.\n\x00'
	.byte $8d
	.byte "IT IS TO LIVE A", $8d
	.byte "LIFE CONSTANTLY", $8d
	.byte "AND FOREVER IN", $8d
	.byte "THE QUEST TO", $8d
	.byte "BETTER THYSELF", $8d
	.byte "AND THE WORLD IN", $8d
	.byte "WHICH WE LIVE.", $8d
	.byte 0
	jmp next_question

answer_quest:
	jsr print_lb_says
	jsr j_primm  ;b'THE QUEST OF\nTHE AVATAR IS\nIS TO KNOW AND\nBECOME THE\nEMBODIMENT OF\nTHE EIGHT\nVIRTUES OF\nGOODNESS!\n\x00'
	.byte "THE QUEST OF", $8d
	.byte "THE AVATAR IS", $8d
	.byte "IS TO KNOW AND", $8d
	.byte "BECOME THE", $8d
	.byte "EMBODIMENT OF", $8d
	.byte "THE EIGHT", $8d
	.byte "VIRTUES OF", $8d
	.byte "GOODNESS!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nIT IS KNOWN THAT\nALL WHO TAKE ON\nTHIS QUEST MUST\nPROVE THEMSELVES\nBY CONQUERING\nTHE ABYSS AND\nVIEWING THE\nCODEX OF\nULTIMATE WISDOM!\n\x00'
	.byte $8d
	.byte "IT IS KNOWN THAT", $8d
	.byte "ALL WHO TAKE ON", $8d
	.byte "THIS QUEST MUST", $8d
	.byte "PROVE THEMSELVES", $8d
	.byte "BY CONQUERING", $8d
	.byte "THE ABYSS AND", $8d
	.byte "VIEWING THE", $8d
	.byte "CODEX OF", $8d
	.byte "ULTIMATE WISDOM!", $8d
	.byte 0
	jmp next_question

answer_britannia:
	jsr print_he_says
	jsr j_primm  ;b'EVEN THOUGH THE\nGREAT EVIL LORDS\nHAVE BEEN ROUTED\nEVIL YET REMAINS\nIN BRITANNIA.\n\x00'
	.byte "EVEN THOUGH THE", $8d
	.byte "GREAT EVIL LORDS", $8d
	.byte "HAVE BEEN ROUTED", $8d
	.byte "EVIL YET REMAINS", $8d
	.byte "IN BRITANNIA.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nIF BUT ONE SOUL\nCOULD COMPLETE\nTHE QUEST OF THE\nAVATAR, OUR\nPEOPLE WOULD\nHAVE A NEW HOPE,\nA NEW GOAL FOR\nLIFE.\n\x00'
	.byte $8d
	.byte "IF BUT ONE SOUL", $8d
	.byte "COULD COMPLETE", $8d
	.byte "THE QUEST OF THE", $8d
	.byte "AVATAR, OUR", $8d
	.byte "PEOPLE WOULD", $8d
	.byte "HAVE A NEW HOPE,", $8d
	.byte "A NEW GOAL FOR", $8d
	.byte "LIFE.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nTHERE WOULD BE A\nSHINING EXAMPLE\nTHAT THERE IS\nMORE TO LIFE\nTHAN THE ENDLESS\nSTRUGGLE FOR\nPOSSESSIONS\nAND GOLD!\n\x00'
	.byte $8d
	.byte "THERE WOULD BE A", $8d
	.byte "SHINING EXAMPLE", $8d
	.byte "THAT THERE IS", $8d
	.byte "MORE TO LIFE", $8d
	.byte "THAN THE ENDLESS", $8d
	.byte "STRUGGLE FOR", $8d
	.byte "POSSESSIONS", $8d
	.byte "AND GOLD!", $8d
	.byte 0
	jmp next_question

answer_ankh:
	jsr print_he_says
	jsr j_primm  ;b'THE ANKH IS THE\nSYMBOL OF ONE\nWHO STRIVES FOR\nVIRTUE, KEEP IT\nWITH THEE AT\nTIMES FOR BY\nTHIS MARK THOU\nSHALT BE KNOWN!\n\x00'
	.byte "THE ANKH IS THE", $8d
	.byte "SYMBOL OF ONE", $8d
	.byte "WHO STRIVES FOR", $8d
	.byte "VIRTUE, KEEP IT", $8d
	.byte "WITH THEE AT", $8d
	.byte "TIMES FOR BY", $8d
	.byte "THIS MARK THOU", $8d
	.byte "SHALT BE KNOWN!", $8d
	.byte 0
	jmp next_question

answer_help:
	lda #$00
	jsr music_ctl
	jsr j_primm_cout ;b'\x04BRUN HELP,A$8800\n\x00'
	.byte $84,"BRUN HELP,A$8800", $8d
	.byte 0

answer_abyss:
	jsr print_he_says
	jsr j_primm  ;b'THE GREAT\nSTYGIAN ABYSS\nIS THE DARKEST\nPOCKET OF EVIL\nREMAINING IN\nBRITANNIA!\n\x00'
	.byte "THE GREAT", $8d
	.byte "STYGIAN ABYSS", $8d
	.byte "IS THE DARKEST", $8d
	.byte "POCKET OF EVIL", $8d
	.byte "REMAINING IN", $8d
	.byte "BRITANNIA!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nIT IS SAID THAT\nIN THE DEEPEST\nRECESSES OF THE\nABYSS IS THE\nCHAMBER OF THE\nCODEX!\n\x00'
	.byte $8d
	.byte "IT IS SAID THAT", $8d
	.byte "IN THE DEEPEST", $8d
	.byte "RECESSES OF THE", $8d
	.byte "ABYSS IS THE", $8d
	.byte "CHAMBER OF THE", $8d
	.byte "CODEX!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nIT IS ALSO SAID\nTHAT ONLY ONE OF\nHIGHEST VIRTUE\nMAY ENTER THIS\nCHAMBER, ONE\nSUCH AS AN\nAVATAR!!!\n\x00'
	.byte $8d
	.byte "IT IS ALSO SAID", $8d
	.byte "THAT ONLY ONE OF", $8d
	.byte "HIGHEST VIRTUE", $8d
	.byte "MAY ENTER THIS", $8d
	.byte "CHAMBER, ONE", $8d
	.byte "SUCH AS AN", $8d
	.byte "AVATAR!!!", $8d
	.byte 0
	jmp next_question

answer_mondain:
	jsr print_he_says
	jsr j_primm  ;b'MONDAIN IS DEAD!\n\x00'
	.byte "MONDAIN IS DEAD!", $8d
	.byte 0
	jmp next_question

answer_minax:
	jsr print_he_says
	jsr j_primm  ;b'MINAX IS DEAD!\n\x00'
	.byte "MINAX IS DEAD!", $8d
	.byte 0
	jmp next_question

answer_exodus:
	jsr print_he_says
	jsr j_primm  ;b'EXODUS IS DEAD!\n\x00'
	.byte "EXODUS IS DEAD!", $8d
	.byte 0
	jmp next_question

answer_virtue:
	jsr print_he_says
	jsr j_primm  ;b'THE EIGHT\nVIRTUES OF THE\nAVATAR ARE:\n\x00'
	.byte "THE EIGHT", $8d
	.byte "VIRTUES OF THE", $8d
	.byte "AVATAR ARE:", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'HONESTY,\nCOMPASSION,\nVALOR,\nJUSTICE,\nSACRIFICE,\nHONOR,\nSPIRITUALITY,\nAND HUMILITY!\n\x00'
	.byte "HONESTY,", $8d
	.byte "COMPASSION,", $8d
	.byte "VALOR,", $8d
	.byte "JUSTICE,", $8d
	.byte "SACRIFICE,", $8d
	.byte "HONOR,", $8d
	.byte "SPIRITUALITY,", $8d
	.byte "AND HUMILITY!", $8d
	.byte 0
	jmp next_question

lb_intro:
	jsr j_primm  ;b'LORD BRITISH\nRISES AND SAYS\nAT LONG LAST!\n\x00'
	.byte "LORD BRITISH", $8d
	.byte "RISES AND SAYS", $8d
	.byte "AT LONG LAST!", $8d
	.byte 0
	lda #$01
	sta curr_player
	jsr j_printname
	jsr j_primm  ;b'\nTHOU HAST COME!\nWE HAVE WAITED\nSUCH A LONG,\nLONG TIME...\n\x00'
	.byte $8d
	.byte "THOU HAST COME!", $8d
	.byte "WE HAVE WAITED", $8d
	.byte "SUCH A LONG,", $8d
	.byte "LONG TIME...", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nLORD BRITISH\nSITS AND SAYS:\nA NEW AGE IS\nUPON BRITANNIA.\nTHE GREAT EVIL\nLORDS ARE GONE\nBUT OUR PEOPLE\nLACK DIRECTION\nAND PURPOSE IN\nTHEIR LIVES...\x00'
	.byte $8d
	.byte "LORD BRITISH", $8d
	.byte "SITS AND SAYS:", $8d
	.byte "A NEW AGE IS", $8d
	.byte "UPON BRITANNIA.", $8d
	.byte "THE GREAT EVIL", $8d
	.byte "LORDS ARE GONE", $8d
	.byte "BUT OUR PEOPLE", $8d
	.byte "LACK DIRECTION", $8d
	.byte "AND PURPOSE IN", $8d
	.byte "THEIR LIVES...", 0
	jsr j_waitkey
	jsr j_primm  ;b'\n\nA CHAMPION OF\nVIRTUE IS CALLED\nFOR. THOU MAY BE\nTHIS CHAMPION,\nBUT ONLY TIME\nSHALL TELL. I\nWILL AID THEE\nANY WAY THAT I\nCAN!\n\x00'
	.byte $8d
	.byte $8d
	.byte "A CHAMPION OF", $8d
	.byte "VIRTUE IS CALLED", $8d
	.byte "FOR. THOU MAY BE", $8d
	.byte "THIS CHAMPION,", $8d
	.byte "BUT ONLY TIME", $8d
	.byte "SHALL TELL. I", $8d
	.byte "WILL AID THEE", $8d
	.byte "ANY WAY THAT I", $8d
	.byte "CAN!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nHOW MAY I\nHELP THEE?\n\x00'
	.byte $8d
	.byte "HOW MAY I", $8d
	.byte "HELP THEE?", $8d
	.byte 0
	jmp input_word

keywords:
	.byte "    "
	.byte "BYE "
	.byte "NAME"
	.byte "LOOK"
	.byte "JOB "
	.byte "HEAL"
	.byte "TRUT"
	.byte "LOVE"
	.byte "COUR"
	.byte "HONE"
	.byte "COMP"
	.byte "VALO"
	.byte "JUST"
	.byte "SACR"
	.byte "HONO"
	.byte "SPIR"
	.byte "HUMI"
	.byte "PRID"
	.byte "AVAT"
	.byte "QUES"
	.byte "BRIT"
	.byte "ANKH"
	.byte "HELP"
	.byte "ABYS"
	.byte "MOND"
	.byte "MINA"
	.byte "EXOD"
	.byte "VIRT"
	.byte 0, 0, 0, 0

check_keyword:
	lda #$00
	sta zp_level_or_index
@check:
	lda zp_level_or_index
	asl
	asl
	tay
	ldx #$00
@compare:
	lda keywords,y
	beq @nomatch
	cmp inbuffer,x
	bne @next
	iny
	inx
	cpx #$04
	bcc @compare
	lda zp_level_or_index
	rts

@next:
	inc zp_level_or_index
	jmp @check

@nomatch:
	lda #$ff
	rts

get_input:
	lda #char_question
	jsr j_console_out
	lda #$00
	sta zp_level_or_index
@getkey:
	jsr j_waitkey
	cmp #char_enter
	beq @enter
	cmp #char_left_arrow
	beq @backspace
	cmp #char_space
	bcc @getkey
	ldx zp_level_or_index
	sta inbuffer,x
	jsr j_console_out
	inc zp_level_or_index
	lda zp_level_or_index
	cmp #$0f
	bcc @getkey
	bcs @enter
@backspace:
	lda zp_level_or_index
	beq @getkey
	dec zp_level_or_index
	dec console_xpos
	lda #char_space
	jsr j_console_out
	dec console_xpos
	jmp @getkey

@enter:
	ldx zp_level_or_index
	lda #char_space
@pad_spaces:
	sta inbuffer,x
	inx
	cpx #$06
	bcc @pad_spaces
	lda #char_enter
	jsr j_console_out
	rts

; unused
check_keyword_inline:
	pla
	sta ptr1
	pla
	sta ptr1 + 1
	ldy #$00
	sty zpf0
	ldx #$ff
@next_char:
	inx
	inc ptr1
	bne :+
	inc ptr1 + 1
:	lda (ptr1),y
	beq @done
	cmp inbuffer,x
	beq @next_char
	inc zpf0
	jmp @next_char

@done:
	lda ptr1 + 1
	pha
	lda ptr1
	pha
	lda zpf0
	rts

restore_party_hp:
	lda party_size
	sta curr_player
@next:
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Dead
	beq @skip
	lda #status_Good
	sta (ptr1),y
	ldy #player_max_hp_hi
	lda (ptr1),y
	ldy #player_cur_hp_hi
	sta (ptr1),y
	ldy #player_max_hp_lo
	lda (ptr1),y
	ldy #player_cur_hp_lo
	sta (ptr1),y
@skip:
	dec curr_player
	bne @next
	rts

decode_bcd_value:
	cmp #$00
	beq @done
	ldx #$00
	sed
@inc:
	inx
	sec
	sbc #$01
	bne @inc
	txa
	cld
@done:
	rts

exit_conversation:
	rts

; junk
	.byte $02
