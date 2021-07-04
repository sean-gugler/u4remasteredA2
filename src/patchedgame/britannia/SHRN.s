	.include "uscii.i"
	.include "SHRN.i"

;
; **** ZP FIELDS ****
;
spk_pattern_ptr = $b0
;
; **** ZP ABSOLUTE ADRESSES ****
;
current_location = $0a
game_mode = $0b
last_meditated = $19
;move_counter + 2 = $1e
;spk_pattern_ptr = $b0
;spk_pattern_ptr+1 = $b1
spk_byte = $b2
spk_pattern_length = $b3
spk_repeat_code = $b4
spk_pattern_code = $b5
spk_row = $b6
spk_repeat_count = $b7
spk_repeat_flag = $b8
spk_pattern_count = $b9
spk_pattern_flag = $ba
spk_pattern_len_cur = $bb
console_xpos = $ce
zpd9 = $d9
zpda = $da
zpea = $ea
zpf0 = $f0
ptr2 = $fc
;ptr2 + 1 = $fd
ptr1 = $fe
;ptr1 + 1 = $ff
;
; **** ZP POINTERS ****
;
;ptr2 = $fc
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
dungeon_level = $000c
balloon_flying = $000d
player_transport = $000e
party_size = $000f
dng_direction = $0010
light_duration = $0011
moon_phase_trammel = $0012
moon_phase_felucca = $0013
horse_mode = $0014
player_has_spoken_to_lb = $0015
last_sleep = $0016
last_humility_check = $0017
altar_room_principle = $0018
last_found_reagent = $001a
ship_hull = $001b
move_counter = $001c
;move_counter + 1 = $001d
;move_counter + 3 = $001f
kbd_buf_count = $0046
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
curr_player = $00d4
target_player = $00d5
hexnum = $00d6
bcdnum = $00d7
zpd8 = $00d8
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
currmap = $0200
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
music_init = $ec00
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

key_buf = $b0



	.segment "OVERLAY"

j_overlay_entry:
	lda current_location
	sec
	sbc #loc_shrine_first
	sta shrine_num
	tay
	lda runes
	and bit_msb,y
	bne @haverune
	jsr j_primm  ;b'\nTHOU DOST NOT\nBEAR THE RUNE\nOF ENTRY! A\nSTRANGE FORCE\nKEEPS YOU OUT!\n\x00'
	.byte $8d
	.byte "THOU DOST NOT", $8d
	.byte "BEAR THE RUNE", $8d
	.byte "OF ENTRY! A", $8d
	.byte "STRANGE FORCE", $8d
	.byte "KEEPS YOU OUT!", $8d
	.byte 0
	jmp exit_shrine

@haverune:
	jsr j_primm_cout ;b'\x04BLOAD SHRI,A$280\n\x00'
	.byte $84,"BLOAD SHRI,A$280", $8d
	.byte 0
	ldx #$7f
@copymap:
	lda tempmap,x
	sta currmap,x
	dex
	bpl @copymap
	lda #$ff
	sta game_mode
	jsr j_update_view
	lda #music_shrine
	jsr music_ctl
	jsr j_primm  ;b'\nYOU ENTER THE\nANCIENT SHRINE\nAND SIT BEFORE\nTHE ALTAR...\n\nUPON WHAT VIRTUE\nDOST THOU\nMEDITATE?\n\x00'
	.byte $8d
	.byte "YOU ENTER THE", $8d
	.byte "ANCIENT SHRINE", $8d
	.byte "AND SIT BEFORE", $8d
	.byte "THE ALTAR...", $8d
	.byte $8d
	.byte "UPON WHAT VIRTUE", $8d
	.byte "DOST THOU", $8d
	.byte "MEDITATE?", $8d
	.byte 0
	lda #$00
	sta num_cycles
	jsr get_string
@askcycles:
	jsr j_primm  ;b'\nFOR HOW MANY\nCYCLES (0-3):\x00'
	.byte $8d
	.byte "FOR HOW MANY", $8d
	.byte "CYCLES (0-3):", 0
	jsr get_number
	cmp #$04
	bcs @askcycles
	sta num_cycles
	sta cycle_ctr
	bne :+
	jmp no_focus

:	lda #$00
	sta unused
	jsr compare_string
	cmp shrine_num
	beq @virtue_shrine_match
	jmp no_focus

@virtue_shrine_match:
	lda move_counter + 2
	cmp last_meditated
	bne @begin
	jmp still_weary

@begin:
	sta last_meditated
	jsr j_primm  ;b'\nBEGIN MEDITATION\n\x00'
	.byte $8d
	.byte "BEGIN MEDITATION", $8d
	.byte 0
@slowdots:
	lda #$10
	sta zpf0
@print:
	jsr delay
	lda #char_period
	jsr j_console_out
	dec zpf0
	bne @print
	bit hw_strobe
	lda #$00
	sta key_buf_len
	jsr j_primm  ;b'\nMANTRA\x00'
	.byte $8d
	.byte "MANTRA", 0
	jsr get_string
	jsr compare_string
	sec
	sbc #$08
	cmp shrine_num
	beq @correctmantra
	jmp @wrongmantra

@correctmantra:
	dec cycle_ctr
	bne @slowdots
	jmp @checkresult

@wrongmantra:
	jsr j_primm  ;b'\nTHOU ART NOT\nABLE TO FOCUS\nTHY THOUGHTS\nWITH THAT\nMANTRA!\n\x00'
	.byte $8d
	.byte "THOU ART NOT", $8d
	.byte "ABLE TO FOCUS", $8d
	.byte "THY THOUGHTS", $8d
	.byte "WITH THAT", $8d
	.byte "MANTRA!", $8d
	.byte 0
	ldy #$06
	lda #$03
	jsr decrease_virtue
	jmp exit_shrine

@checkresult:
	lda num_cycles
	cmp #$03
	bne @vision
	ldy shrine_num
	lda party_stats,y
	cmp #$99
	bne @vision
	jmp partial_avatar

@vision:
	jsr j_primm  ;b'\nTHY THOUGHTS\nARE PURE,\nTHOU ART GRANTED\nA VISION!\n\x00'
	.byte $8d
	.byte "THY THOUGHTS", $8d
	.byte "ARE PURE,", $8d
	.byte "THOU ART GRANTED", $8d
	.byte "A VISION!", $8d
	.byte 0
	ldy #$06
	lda num_cycles
	asl
	adc num_cycles
	jsr increase_virtue
	jsr j_waitkey
	lda #char_enter
	jsr j_console_out
	ldy shrine_num
	lda shrine_msg_idx,y
	clc
	ldy num_cycles
	adc shrine_msg_per_cycle,y
	clc
	adc #$01
	jsr print_hint
	jsr j_waitkey
exit_shrine:
	lda #char_enter
	jsr j_console_out
	lda #loc_world
	sta current_location
	lda #mode_world
	sta game_mode
	jsr j_update_view
	rts

; unused
longdelay:
	ldx #$0a
:	jsr short_delay
	dex
	bne :-
	rts

delay:
	ldx #$05
:	jsr short_delay
	dex
	bne :-
	rts

short_delay:
	ldy #$ff
@outer:
	lda #$ff
@inner:
	sec
	sbc #$01
	bne @inner
	dey
	bne @outer
	bit hw_strobe
	rts

no_focus:
	jsr j_primm  ;b'\nTHOU ART UNABLE\nTO FOCUS THY\nTHOUGHTS ON\nTHIS SUBJECT!\n\x00'
	.byte $8d
	.byte "THOU ART UNABLE", $8d
	.byte "TO FOCUS THY", $8d
	.byte "THOUGHTS ON", $8d
	.byte "THIS SUBJECT!", $8d
	.byte 0
	jsr j_waitkey
	jmp exit_shrine

still_weary:
	jsr j_primm  ;b'\nTHY MIND IS\nSTILL WEARY\nFROM THY LAST\nMEDITATION!\n\x00'
	.byte $8d
	.byte "THY MIND IS", $8d
	.byte "STILL WEARY", $8d
	.byte "FROM THY LAST", $8d
	.byte "MEDITATION!", $8d
	.byte 0
	jsr j_waitkey
	jmp exit_shrine

increase_virtue:
	sta zpd9
	sed
	clc
	lda party_stats,y
	beq @nooverflow
	adc zpd9
	bcc @nooverflow
	lda #$99
@nooverflow:
	sta party_stats,y
	cld
	rts

decrease_virtue:
	sta zpda
	sty zpd9
	lda party_stats,y
	beq @lost_an_eighth
@subtract:
	sed
	sec
	sbc zpda
	beq :+
	bcs @positive
:	lda #$01
@positive:
	sta party_stats,y
	cld
	rts

@lost_an_eighth:
	jsr j_primm  ;b'\nTHOU HAST LOST\nAN EIGHTH!\n\x00'
	.byte $8d
	.byte "THOU HAST LOST", $8d
	.byte "AN EIGHTH!", $8d
	.byte 0
	ldy zpd9
	lda #$99
	jmp @subtract

partial_avatar:
	jsr j_primm  ;b'\nTHOU HAST\nACHIEVED PARTIAL\nAVATARHOOD IN\nTHE VIRTUE OF\n\x00'
	.byte $8d
	.byte "THOU HAST", $8d
	.byte "ACHIEVED PARTIAL", $8d
	.byte "AVATARHOOD IN", $8d
	.byte "THE VIRTUE OF", $8d
	.byte 0
	lda #$97
	clc
	adc shrine_num
	jsr j_printstring
	jsr j_invertview
	ldx #sound_spell_effect
	lda #$09
	jsr j_playsfx
	jsr j_invertview
	lda #char_enter
	jsr j_console_out
	ldy shrine_num
	lda #$00
	sta party_stats,y
	jsr j_waitkey
	jsr j_primm  ;b'\nTHOU ART GRANTED\nA VISION!\n\x00'
	.byte $8d
	.byte "THOU ART GRANTED", $8d
	.byte "A VISION!", $8d
	.byte 0
	lda #$00
	sta game_mode
	lda shrine_num
	jsr draw_rune
	jsr j_waitkey
	jmp exit_shrine

get_number:
	jsr j_waitkey
	beq get_number
	sec
	sbc #char_0
	cmp #$0a
	bcc @ok
	lda #$00
@ok:
	pha
	jsr j_printdigit
	lda #char_enter
	jsr j_console_out
	pla
	rts

shrine_num:
	.byte 0
num_cycles:
	.byte 0
cycle_ctr:
	.byte 0
unused:
	.byte 0
shrine_msg_idx:
	.byte $00,$03,$06,$09,$0c,$0f,$12,$15
shrine_msg_per_cycle:
;	.byte $18, 0, 0, 0, 1, 1, 1, 2, 2, 2	; BUG: always msg 0. @vision does not multiply num_cycles by 3
	.byte $18, 0, 1, 2, 1, 1, 1, 2, 2, 2	; BUGFIX: only indices 1-3 matter.
bit_msb:
	.byte $80,$40,$20,$10,$08,$04,$02,$01

get_string:
	lda #$bf
	jsr j_console_out
	lda #$00
	sta zpea
@waitkey:
	jsr j_waitkey
	beq @timeout
@checkkey:
	cmp #char_enter
	beq @done
	cmp #char_left_arrow
	beq @del
	cmp #$a0     ;@char_space
	bcc @waitkey
	ldx zpea
	sta inbuffer,x
	jsr j_console_out
	inc zpea
	lda zpea
	cmp #$0f
	bcc @waitkey
	bcs @done
@del:
	lda zpea
	beq @waitkey
	dec zpea
	dec console_xpos
	lda #char_space
	jsr j_console_out
	dec console_xpos
	jmp @waitkey

@timeout:
	lda num_cycles
	beq @checkkey
@done:
	ldx zpea
	lda #$a0
@clearend:
	sta inbuffer,x
	inx
	cpx #$06
	bcc @clearend
	lda #char_enter
	jsr j_console_out
	rts

compare_string:
	lda #$0f
	sta zpea
@nextstring:
	lda zpea
	asl
	asl
	tay
	ldx #$00
@compare:
	lda virtues_and_mantras,y
	cmp inbuffer,x
	bne @differ
	iny
	inx
	cpx #$04
	bcc @compare
	lda zpea
	rts

@differ:
	dec zpea
	bpl @nextstring
	lda zpea
	rts

virtues_and_mantras:
	.byte "HONE"
	.byte "COMP"
	.byte "VALO"
	.byte "JUST"
	.byte "SACR"
	.byte "HONO"
	.byte "SPIR"
	.byte "HUMI"
	.byte "AHM "
	.byte "MU  "
	.byte "RA  "
	.byte "BEH "
	.byte "CAH "
	.byte "SUMM"
	.byte "OM  "
	.byte "LUM "

print_hint:
	tay
	lda #<string_table
	sta ptr1
	lda #>string_table
	sta ptr1 + 1
	ldx #$00
@checknext:
	lda (ptr1,x)
	beq @possiblestring
@wrongstring:
	jsr @incptr
	jmp @checknext

@possiblestring:
	dey
	beq @gotstring
	jmp @wrongstring

@gotstring:
	jsr @incptr
	ldx #$00
	lda (ptr1,x)
	beq @done
	jsr j_console_out
	jmp @gotstring

@done:
	rts

@incptr:
	inc ptr1
	bne :+
	inc ptr1 + 1
:	rts

string_table:
; STRING $00 (0)
	.byte 0
; STRING $01 (1)
	.byte "TAKE NOT THE", $8d
	.byte "GOLD OF OTHERS", $8d
	.byte "FOUND IN TOWNS", $8d
	.byte "AND CASTLES FOR", $8d
	.byte "YOURS IT IS NOT!", $8d
	.byte 0
; STRING $02 (2)
	.byte "CHEAT NOT THE", $8d
	.byte "MERCHANTS AND", $8d
	.byte "PEDDLERS FOR", $8d
	.byte "'TIS AN EVIL", $8d
	.byte "THING TO DO!", $8d
	.byte 0
; STRING $03 (3)
	.byte "SECOND, READ THE", $8d
	.byte "BOOK OF TRUTH AT", $8d
	.byte "THE ENTRANCE TO", $8d
	.byte "THE GREAT", $8d
	.byte "STYGIAN ABYSS!", $8d
	.byte 0
; STRING $04 (4)
	.byte "KILL NOT THE", $8d
	.byte "NON-EVIL BEASTS", $8d
	.byte "OF THE LAND, AND", $8d
	.byte "DO NOT ATTACK", $8d
	.byte "THE FAIR PEOPLE!", $8d
	.byte 0
; STRING $05 (5)
	.byte "GIVE OF THY", $8d
	.byte "PURSE TO THOSE", $8d
	.byte "WHO BEG AND THY", $8d
	.byte "DEED SHALL NOT", $8d
	.byte "BE FORGOTTEN!", $8d
	.byte 0
; STRING $06 (6)
	.byte "THIRD, LIGHT THE", $8d
	.byte "CANDLE OF LOVE", $8d
	.byte "AT THE ENTRANCE", $8d
	.byte "TO THE GREAT", $8d
	.byte "STYGIAN ABYSS!", $8d
	.byte 0
; STRING $07 (7)
	.byte "VICTORIES SCORED", $8d
	.byte "OVER EVIL", $8d
	.byte "CREATURES HELP", $8d
	.byte "TO BUILD A", $8d
	.byte "VALOROUS SOUL!", $8d
	.byte 0
; STRING $08 (8)
	.byte "TO FLEE FROM", $8d
	.byte "BATTLE WITH LESS", $8d
	.byte "THAN GRIEVOUS", $8d
	.byte "WOUNDS OFTEN", $8d
	.byte "SHOWS A COWARD!", $8d
	.byte 0
; STRING $09 (9)
	.byte "FIRST, RING THE", $8d
	.byte "BELL OF COURAGE", $8d
	.byte "AT THE ENTRANCE", $8d
	.byte "TO THE GREAT", $8d
	.byte "STYGIAN ABYSS!", $8d
	.byte 0
; STRING $0A (10)
	.byte "TO TAKE THE GOLD", $8d
	.byte "OF OTHERS IS", $8d
	.byte "INJUSTICE NOT", $8d
	.byte "SOON FORGOTTEN,", $8d
	.byte "TAKE ONLY THY", $8d
	.byte "DUE!", $8d
	.byte 0
; STRING $0B (11)
	.byte "ATTACK NOT A", $8d
	.byte "PEACEFUL CITIZEN", $8d
	.byte "FOR THAT ACTION", $8d
	.byte "DESERVES STRICT", $8d
	.byte "PUNISHMENT!", $8d
	.byte 0
; STRING $0C (12)
	.byte "KILL NOT A", $8d
	.byte "NON-EVIL BEAST", $8d
	.byte "FOR THEY DESERVE", $8d
	.byte "NOT DEATH EVEN", $8d
	.byte "IF IN HUNGER", $8d
	.byte "THEY ATTACK", $8d
	.byte "THEE!", $8d
	.byte 0
; STRING $0D (13)
	.byte "TO GIVE THY LAST", $8d
	.byte "GOLD PIECE UNTO", $8d
	.byte "THE NEEDY SHOWS", $8d
	.byte "GOOD MEASURE OF", $8d
	.byte "SELF-SACRIFICE!", $8d
	.byte 0
; STRING $0E (14)
	.byte "FOR THEE TO FLEE", $8d
	.byte "AND LEAVE THY", $8d
	.byte "COMPANIONS IS A", $8d
	.byte "SELF-SEEKING", $8d
	.byte "ACTION TO BE", $8d
	.byte "AVOIDED!", $8d
	.byte 0
; STRING $0F (15)
	.byte "TO GIVE OF THY", $8d
	.byte "LIFE'S BLOOD SO", $8d
	.byte "THAT OTHERS MAY", $8d
	.byte "LIVE IS A VIRTUE", $8d
	.byte "OF GREAT PRAISE!", $8d
	.byte 0
; STRING $10 (16)
	.byte "TAKE NOT THE", $8d
	.byte "GOLD OF OTHERS", $8d
	.byte "FOR THIS SHALL", $8d
	.byte "BRING DISHONOR", $8d
	.byte "UPON THEE!", $8d
	.byte 0
; STRING $11 (17)
	.byte "TO STRIKE FIRST", $8d
	.byte "A NON-EVIL BEING", $8d
	.byte "IS BY NO MEANS", $8d
	.byte "AN HONORABLE", $8d
	.byte "DEED!", $8d
	.byte 0
; STRING $12 (18)
	.byte "SEEK YE TO SOLVE", $8d
	.byte "THE MANY QUESTS", $8d
	.byte "BEFORE THEE, AND", $8d
	.byte "HONOR SHALL BE", $8d
	.byte "A REWARD!", $8d
	.byte 0
; STRING $13 (19)
	.byte "SEEK YE TO KNOW", $8d
	.byte "THYSELF, VISIT", $8d
	.byte "THE SEER OFTEN", $8d
	.byte "FOR HE CAN", $8d
	.byte "SEE INTO THY", $8d
	.byte "INNER BEING!", $8d
	.byte 0
; STRING $14 (20)
	.byte "MEDITATION", $8d
	.byte "LEADS TO", $8d
	.byte "ENLIGHTENMENT.", $8d
	.byte "SEEK YE ALL", $8d
	.byte "WISDOM AND", $8d
	.byte "KNOWLEDGE!", $8d
	.byte 0
; STRING $15 (21)
	.byte "IF THOU DOST", $8d
	.byte "SEEK THE WHITE", $8d
	.byte "STONE, SEARCH YE", $8d
	.byte "NOT UNDER THE", $8d
	.byte "GROUND, BUT IN", $8d
	.byte "THE SKY NEAR", $8d
	.byte "SERPENTS SPINE!", $8d
	.byte 0
; STRING $16 (22)
	.byte "CLAIM NOT TO BE", $8d
	.byte "THAT WHICH THOU", $8d
	.byte "ART NOT, HUMBLE", $8d
	.byte "ACTIONS SPEAK", $8d
	.byte "WELL OF THEE!", $8d
	.byte 0
; STRING $17 (23)
	.byte "STRIVE NOT TO", $8d
	.byte "WIELD THE GREAT", $8d
	.byte "FORCE OF EVIL", $8d
	.byte "FOR ITS POWER", $8d
	.byte "WILL OVERCOME", $8d
	.byte "THEE!", $8d
	.byte 0
; STRING $18 (24)
	.byte "IF THOU DOST", $8d
	.byte "SEEK THE BLACK", $8d
	.byte "STONE, SEARCH YE", $8d
	.byte "AT THE TIME AND", $8d
	.byte "PLACE OF THE", $8d
	.byte "GATE ON THE", $8d
	.byte "DARKEST OF ALL", $8d
	.byte "NIGHTS!", $8d
	.byte 0

draw_rune:
	pha
	jsr swap_buf
	jsr j_clearview
	pla

	asl
	tax
	lda rune_addr + 1,x
	sta ptr2 + 1
	lda rune_addr,x
	sta ptr2

	ldx #$00
	stx spk_repeat_flag
	stx spk_pattern_flag
	stx spk_pattern_len_cur

	lda (ptr2,x)
	sta spk_repeat_code
	inc ptr2
	bne :+
	inc ptr2 + 1

:	lda (ptr2,x)
	sta spk_pattern_code
	inc ptr2
	bne :+        ; BUGFIX: only manifests if data is
	inc ptr2 + 1  ; BUGFIX: exactly on a page boundary

:	ldy #max_spk_col
@next_col:
	ldx #max_spk_row
	stx spk_row
@next_row:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	jsr spk_write_byte
	dec spk_row
	ldx spk_row
	cpx #min_spk_row
	bne @next_row
	dey
	cpy #min_spk_col
	bne @next_col
	jsr swap_buf
	rts

spk_write_byte:
	ldx #$00
	bit spk_repeat_flag
	bmi @do_repeat
	bit spk_pattern_flag
	bmi @do_pattern
@read_byte:
	lda (ptr2,x)
	sta spk_byte
	cmp spk_repeat_code
	bne @check_pattern
@set_repeat:
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda (ptr2,x)
	sta spk_repeat_count
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda (ptr2,x)
	sta spk_byte
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda #$80
	sta spk_repeat_flag
	bne @do_repeat
@check_pattern:
	cmp spk_pattern_code
	bne @do_literal
@set_pattern:
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda (ptr2,x)
	sta spk_pattern_length
	sta spk_pattern_len_cur
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda (ptr2,x)
	sta spk_pattern_count
	inc ptr2
	bne :+
	inc ptr2 + 1
:	lda ptr2
	sta spk_pattern_ptr
	lda ptr2 + 1
	sta spk_pattern_ptr+1
	lda #$80
	sta spk_pattern_flag
	bne @do_pattern
@do_literal:
	lda spk_byte
	ora (ptr1),y
	sta (ptr1),y
	inc ptr2
	bne @continue
	inc ptr2 + 1
@continue:
	rts

@do_repeat:
	lda spk_byte
	ora (ptr1),y
	sta (ptr1),y
	dec spk_repeat_count
	bne @continue
	lda #$00
	sta spk_repeat_flag
	bit spk_pattern_flag
	bpl @continue
	dec spk_pattern_len_cur
	dec spk_pattern_len_cur
	bne @next_pattern
@do_pattern:
	lda (ptr2,x)
	cmp spk_repeat_code
	bne @pattern_literal
	lda spk_pattern_len_cur
:	bne @set_repeat
@dead_code:
	lda spk_pattern_ptr
	sta ptr2
	lda spk_pattern_ptr+1
	sta ptr2 + 1
	bne :-
@pattern_literal:
	ora (ptr1),y
	sta (ptr1),y
	inc ptr2
	bne @next_pattern
	inc ptr2 + 1
@next_pattern:
	dec spk_pattern_len_cur
	bne @continue
	lda spk_pattern_length
	sta spk_pattern_len_cur
	dec spk_pattern_count
	beq @pattern_done
	lda spk_pattern_ptr
	sta ptr2
	lda spk_pattern_ptr+1
	sta ptr2 + 1
	rts

@pattern_done:
	lda #$00
	sta spk_pattern_flag
	rts

	.byte "SUPER UNPACKER COPYRIGHT 1983 BY STEVEN MEUSE"

swap_buf:
	ldx #$0f
:	lda key_buf,x
	tay
	lda key_buf_tmp,x
	sta key_buf,x
	tya
	sta key_buf_tmp,x
	dex
	bpl :-
	rts

key_buf_tmp:
	.res 16, 0
rune_addr:
	.word rune_i,rune_n,rune_f,rune_i,rune_n
	.word rune_i,rune_t,rune_y
rune_i:
	.byte $fb,$fd,$fd,$03,$07,$fb,$ff,$80
	.byte $fb,$e2,$80,$9c,$fc,$f8,$fb,$16
	.byte $b8,$bc,$fc,$f0,$fd,$03,$07,$fb
	.byte $ff,$80,$fb,$30,$80
rune_n:
	.byte $fb,$fd,$fd,$03,$07,$fb,$ff,$80
	.byte $fb,$3b,$80,$8f,$9f,$b9,$b0,$b0
	.byte $b8,$9c,$fb,$a0,$80,$9c,$fc,$f8
	.byte $fb,$07,$b8,$f8,$f8,$f8,$bc,$be
	.byte $bf,$bb,$fb,$09,$b8,$bc,$fc,$f0
	.byte $fb,$9d,$80,$f0,$b8,$98,$98,$b8
	.byte $f0,$e0,$fd,$03,$06,$fb,$ff,$80
	.byte $fb,$8a,$80
rune_f:
	.byte $fb,$fd,$fd,$03,$07,$fb,$ff,$80
	.byte $fb,$42,$80,$83,$87,$8e,$8c,$9c
	.byte $fb,$05,$98,$bc,$bc,$fb,$95,$80
	.byte $81,$81,$fb,$0c,$80,$ff,$ff,$c0
	.byte $80,$80,$8f,$9f,$b8,$b0,$b0,$b0
	.byte $f9,$f9,$fb,$94,$80,$b8,$f8,$fb
	.byte $17,$f0,$f8,$f8,$e0,$fd,$03,$06
	.byte $fb,$ff,$80,$fb,$7f,$80
rune_t:
	.byte $fb,$fd,$fd,$03,$07,$fb,$ff,$80
	.byte $fb,$48,$80,$f0,$fc,$9f,$87,$81
	.byte $fb,$95,$80,$9c,$fc,$f8,$fb,$15
	.byte $b8,$bb,$ff,$fe,$b8,$fb,$aa,$80
	.byte $9c,$fc,$f0,$c0,$fd,$03,$06,$fb
	.byte $ff,$80,$fb,$81,$80
rune_y:
	.byte $fb,$fd,$fd,$03,$06,$fb,$ff,$80
	.byte $fb,$81,$80,$83,$87,$87,$fb,$10
	.byte $83,$87,$87,$fb,$9b,$80,$e0,$e0
	.byte $fb,$0a,$c0,$ff,$ff,$fb,$06,$c0
	.byte $f8,$ff,$8f,$81,$fb,$98,$80,$b8
	.byte $f8,$f0,$fb,$09,$b0,$ff,$ff,$fb
	.byte $08,$80,$f0,$fe,$9f,$83,$fb,$96
	.byte $80,$87,$9f,$9e,$fb,$09,$8e,$fe
	.byte $fe,$fb,$0a,$8e,$ee,$fe,$bf,$87
	.byte $fd,$03,$06,$fb,$ff,$80,$fb,$7f
	.byte $80,$02
