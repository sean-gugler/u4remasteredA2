	.include "uscii.i"
	.include "SHP9.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
last_meditated = $19
;move_counter + 3 = $1f
console_xpos = $ce
curr_player = $d4
zp_index = $ea
zp_mismatches = $f0
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
;move_counter + 2 = $001e
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
virtue_spirituality = $ed06
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
	lda #$01
	sta curr_player
	jsr j_get_stats_ptr
	ldy #player_status
	lda (ptr1),y
	cmp #status_Good
	beq welcome
	cmp #status_Poison
	beq welcome
	jsr j_primm  ;b'\nTHE SEER SAYS:\nI WILL SPEAK\nONLY WITH\n\x00'
	.byte $8d
	.byte "THE SEER SAYS:", $8d
	.byte "I WILL SPEAK", $8d
	.byte "ONLY WITH", $8d
	.byte 0
	jsr j_printname
	jsr j_primm  ;b'\nRETURN WHEN\n\x00'
	.byte $8d
	.byte "RETURN WHEN", $8d
	.byte 0
	jsr j_printname
	jsr j_primm  ;b'\nIS REVIVED!\n\x00'
	.byte $8d
	.byte "IS REVIVED!", $8d
	.byte 0
	rts

welcome:
	jsr j_primm  ;b'\nWELCOME,\n\x00'
	.byte $8d
	.byte "WELCOME,", $8d
	.byte 0
	jsr j_printname
	jsr j_primm  ;b'\nI AM HAWKWIND\nSEER OF SOULS\nI SEE THAT WHICH\nIS WITHIN THEE\nAND DRIVES THEE\nTO DEEDS OF GOOD\nOR EVIL...\n\x00'
	.byte $8d
	.byte "I AM HAWKWIND", $8d
	.byte "SEER OF SOULS", $8d
	.byte "I SEE THAT WHICH", $8d
	.byte "IS WITHIN THEE", $8d
	.byte "AND DRIVES THEE", $8d
	.byte "TO DEEDS OF GOOD", $8d
	.byte "OR EVIL...", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nFOR WHAT PATH\nDOTH THOU SEEK\nENLIGHTENMENT?\n\x00'
	.byte $8d
	.byte "FOR WHAT PATH", $8d
	.byte "DOTH THOU SEEK", $8d
	.byte "ENLIGHTENMENT?", $8d
	.byte 0
	jmp input_word

ask_again:
	jsr j_primm  ;b'\nHAWKWIND ASKS:\nWHAT OTHER PATH\nSEEKS CLARITY?\n\x00'
	.byte $8d
	.byte "HAWKWIND ASKS:", $8d
	.byte "WHAT OTHER PATH", $8d
	.byte "SEEKS CLARITY?", $8d
	.byte 0
input_word:
	jsr get_input
	jsr check_inline_keyword
	.byte "    ", 0
	beq @bye
	jsr check_inline_keyword
	.byte "BYE", 0
	beq @bye
	jsr check_inline_keyword
	.byte "NONE", 0
	beq @bye
	jsr find_token
	bpl @found
	jsr j_primm  ;b'\nHE SAYS:\nTHAT IS NOT A\nSUBJECT FOR\nENLIGHTENMENT.\n\x00'
	.byte $8d
	.byte "HE SAYS:", $8d
	.byte "THAT IS NOT A", $8d
	.byte "SUBJECT FOR", $8d
	.byte "ENLIGHTENMENT.", $8d
	.byte 0
	jmp ask_again

@found:
	jmp check_avatar

@bye:
	jsr j_primm  ;b'\nHAWKWIND SAYS:\nFARE THE WELL\nAND MAY THOU\nCOMPLETE THE\nQUEST OF\nTHE AVATAR!\n\x00'
	.byte $8d
	.byte "HAWKWIND SAYS:", $8d
	.byte "FARE THE WELL", $8d
	.byte "AND MAY THOU", $8d
	.byte "COMPLETE THE", $8d
	.byte "QUEST OF", $8d
	.byte "THE AVATAR!", $8d
	.byte 0
	lda move_counter + 3
	cmp last_meditated
	beq @done
	sta last_meditated
	sed
	clc
	lda virtue_spirituality
	beq @skip
	adc #$03
	bcc @skip
	lda #$99
@skip:
	sta virtue_spirituality
	cld
@done:
	rts

check_avatar:
	jsr print_newline
	ldy zp_index
	lda party_stats,y
	bne lookup_advice
	jsr j_primm  ;b'HE SAYS:\nTHOU HAST BECOME\nA PARTIAL AVATAR\nIN THAT ATRIBUTE\nTHOU NEED NOT MY\nINSIGHTS.\n\x00'
	.byte "HE SAYS:", $8d
	.byte "THOU HAST BECOME", $8d
	.byte "A PARTIAL AVATAR", $8d
	.byte "IN THAT ATRIBUTE", $8d
	.byte "THOU NEED NOT MY", $8d
	.byte "INSIGHTS.", $8d
	.byte 0
	jmp ask_again

lookup_advice:
	ldy zp_index
	lda party_stats,y
	tax
	lda #$01
	cpx #$20
	bcc print_advice
	lda #$09
	cpx #$40
	bcc print_advice
	lda #$11
	cpx #$60
	bcc print_advice
	lda #$19
	cpx #$99
	bcc print_advice
	lda #$21
print_advice:
	clc
	adc zp_index
	jsr print_string
	ldy zp_index
	lda party_stats,y
	cmp #$99
	bne @done
	jsr j_primm  ;b'\nGO TO THE SHRINE\nAND MEDITATE FOR\nTHREE CYCLES!\n\x00'
	.byte $8d
	.byte "GO TO THE SHRINE", $8d
	.byte "AND MEDITATE FOR", $8d
	.byte "THREE CYCLES!", $8d
	.byte 0
	jsr j_waitkey
@done:
	jmp ask_again

tokens:
	.byte "HONE"
	.byte "COMP"
	.byte "VALO"
	.byte "JUST"
	.byte "SACR"
	.byte "HONO"
	.byte "SPIR"
	.byte "HUMI"
	.byte 0, 0, 0, 0

find_token:
	lda #$00
	sta zp_index
@compare_token:
	lda zp_index
	asl
	asl
	tay
	ldx #$00
@next_char:
	lda tokens,y
	beq @not_found
	cmp inbuffer,x
	bne @next_token
	iny
	inx
	cpx #$04
	bcc @next_char
	lda zp_index
	rts

@next_token:
	inc zp_index
	jmp @compare_token

@not_found:
	lda #$ff
	sta zp_index
	rts

get_input:
	lda #char_question
	jsr j_console_out
	lda #$00
	sta zp_index
@get_char:
	jsr j_waitkey
	cmp #char_enter
	beq @got_input
	cmp #char_left_arrow
	beq @backspace
	cmp #char_space
	bcc @get_char
	ldx zp_index
	sta inbuffer,x
	jsr j_console_out
	inc zp_index
	lda zp_index
	cmp #$0f
	bcc @get_char
	bcs @got_input
@backspace:
	lda zp_index
	beq @get_char
	dec zp_index
	dec console_xpos
	lda #char_space
	jsr j_console_out
	dec console_xpos
	jmp @get_char

@got_input:
	ldx zp_index
	lda #char_space
@pad_spaces:
	sta inbuffer,x
	inx
	cpx #$06
	bcc @pad_spaces
	lda #char_enter
	jsr j_console_out
	rts

check_inline_keyword:
	pla
	sta ptr1
	pla
	sta ptr1 + 1
	ldy #$00
	sty zp_mismatches
	ldx #$ff
@next:
	inx
	inc ptr1
	bne :+
	inc ptr1 + 1
:	lda (ptr1),y
	beq @done
	cmp inbuffer,x
	beq @next
	inc zp_mismatches
	jmp @next

@done:
	lda ptr1 + 1
	pha
	lda ptr1
	pha
	lda zp_mismatches
	rts

	rts

print_newline:
	lda #char_enter
	jsr j_console_out
	rts

print_string:
	tay
	lda #<string_table
	sta ptr1
	lda #>string_table
	sta ptr1 + 1
	ldx #$00
@next_char:
	lda (ptr1,x)
	beq @end_string
@next_string:
	jsr inc_ptr
	jmp @next_char

@end_string:
	dey
	beq @print_char
	jmp @next_string

@print_char:
	jsr inc_ptr
	ldx #$00
	lda (ptr1,x)
	beq @done
	jsr j_console_out
	jmp @print_char

@done:
	rts

inc_ptr:
	inc ptr1
	bne :+
	inc ptr1 + 1
:	rts

string_table:
	.byte 0
	.byte "THOU ART A THIEF", $8d
	.byte "AND A SCOUNDREL", $8d
	.byte "THOU MAY NOT", $8d
	.byte "EVER BECOME AN", $8d
	.byte "AVATAR!", $8d
	.byte 0
	.byte "THOU ART A COLD", $8d
	.byte "AND CRUEL BRUTE", $8d
	.byte "THOU SHOULDST GO", $8d
	.byte "TO PRISON FOR", $8d
	.byte "THY CRIMES!", $8d
	.byte 0
	.byte "THOU ART A", $8d
	.byte "COWARD THOU DOST", $8d
	.byte "FLEE FROM THE", $8d
	.byte "HINT OF DANGER!", $8d
	.byte 0
	.byte "THOU ART AN", $8d
	.byte "UNJUST WRETCH", $8d
	.byte "THOU ART A", $8d
	.byte "FULSOME MEDDLER!", $8d
	.byte 0
	.byte "THOU ART A", $8d
	.byte "SELF-SERVING", $8d
	.byte "TUFTHUNTER, THOU", $8d
	.byte "DESERVETH NOT", $8d
	.byte "MY HELP, YET I", $8d
	.byte "GRANT IT!", $8d
	.byte 0
	.byte "THOU ART A CAD", $8d
	.byte "AND A BOUNDER", $8d
	.byte "THY PRESENCE IS", $8d
	.byte "AN AFFRONT, THOU", $8d
	.byte "ART LOW AS A", $8d
	.byte "SLUG!", $8d
	.byte 0
	.byte "THY SPIRIT IS", $8d
	.byte "WEAK AND FEEBLE", $8d
	.byte "THOU DOST NOT", $8d
	.byte "STRIVE FOR", $8d
	.byte "PERFECTION!", $8d
	.byte 0
	.byte "THOU ART PROUD", $8d
	.byte "AND VAIN,", $8d
	.byte "ALL OTHER VIRTUE", $8d
	.byte "IN THEE IS", $8d
	.byte "A LOSS!", $8d
	.byte 0
	.byte "THOU ART NOT", $8d
	.byte "AN HONEST SOUL,", $8d
	.byte "THOU MUST LIVE", $8d
	.byte "A MORE HONEST", $8d
	.byte "LIFE TO BE", $8d
	.byte "AN AVATAR!", $8d
	.byte 0
	.byte "THOU DOST KILL", $8d
	.byte "WHERE THERE IS", $8d
	.byte "NO NEED AND GIVE", $8d
	.byte "TOO LITTLE UNTO", $8d
	.byte "OTHERS!", $8d
	.byte 0
	.byte "THOU DOST NOT", $8d
	.byte "DISPLAY A GREAT", $8d
	.byte "DEAL OF VALOR", $8d
	.byte "THOU DOST FLEE", $8d
	.byte "BEFORE THE NEED!", $8d
	.byte 0
	.byte "THOU ART CRUEL", $8d
	.byte "AND UNJUST, IN", $8d
	.byte "TIME THOU WILL", $8d
	.byte "SUFFER FOR THY", $8d
	.byte "CRIMES!", $8d
	.byte 0
	.byte "THOU DOST NEED", $8d
	.byte "TO THINK MORE", $8d
	.byte "OF THE LIFE OF", $8d
	.byte "OTHERS AND LESS", $8d
	.byte "OF THY OWN!", $8d
	.byte 0
	.byte "THOU DOST NOT", $8d
	.byte "FIGHT WITH HONOR", $8d
	.byte "BUT WITH MALICE", $8d
	.byte "AND DECEIT!", $8d
	.byte 0
	.byte "THOU DOST NOT", $8d
	.byte "TAKE THE TIME TO", $8d
	.byte "CARE ABOUT THY", $8d
	.byte "INNER BEING A", $8d
	.byte "MUST TO BE AN", $8d
	.byte "AVATAR!", $8d
	.byte 0
	.byte "THOU ART TOO", $8d
	.byte "PROUD OF THY", $8d
	.byte "LITTLE DEEDS,", $8d
	.byte "HUMILITY IS THE", $8d
	.byte "ROOT OF ALL", $8d
	.byte "VIRTUE!", $8d
	.byte 0
	.byte "THOU HAST MADE", $8d
	.byte "LITTLE PROGRESS", $8d
	.byte "ON THE PATHS", $8d
	.byte "OF HONESTY,", $8d
	.byte "STRIVE TO PROVE", $8d
	.byte "THY WORTH!", $8d
	.byte 0
	.byte "THOU HAST NOT", $8d
	.byte "SHOWN THY", $8d
	.byte "COMPASSION WELL", $8d
	.byte "BE MORE KIND", $8d
	.byte "UNTO OTHERS!", $8d
	.byte 0
	.byte "THOU ART NOT YET", $8d
	.byte "A VALIANT", $8d
	.byte "WARRIOR, FIGHT", $8d
	.byte "TO DEFEATE EVIL", $8d
	.byte "AND PROVE", $8d
	.byte "THYSELF!", $8d
	.byte 0
	.byte "THOU HAST NOT", $8d
	.byte "PROVEN THYSELF", $8d
	.byte "TO BE JUST.", $8d
	.byte "STRIVE TO DO", $8d
	.byte "JUSTICE UNTO", $8d
	.byte "ALL THINGS!", $8d
	.byte 0
	.byte "THY SACRIFICE", $8d
	.byte "IS SMALL.", $8d
	.byte "GIVE OF THY", $8d
	.byte "LIFES BLOOD SO", $8d
	.byte "THAT OTHERS MAY", $8d
	.byte "LIVE.", $8d
	.byte 0
	.byte "THOU DOST NEED", $8d
	.byte "TO SHOW THYSELF", $8d
	.byte "TO BE MORE", $8d
	.byte "HONORABLE, THE", $8d
	.byte "PATH LIES BEFORE", $8d
	.byte "THEE!", $8d
	.byte 0
	.byte "STRIVE TO KNOW", $8d
	.byte "AND MASTER MORE", $8d
	.byte "OF THINE INNER", $8d
	.byte "BEING.", $8d
	.byte "MEDITATION", $8d
	.byte "LIGHTS THE PATH!", $8d
	.byte 0
	.byte "THY PROGRESS ON", $8d
	.byte "THIS PATH IS", $8d
	.byte "MOST UNCERTAIN.", $8d
	.byte "WITHOUT HUMILITY", $8d
	.byte "THOU ART", $8d
	.byte "EMPTY!", $8d
	.byte 0
	.byte "THOU DOST SEEM", $8d
	.byte "TO BE AN HONEST", $8d
	.byte "SOUL, CONTINUED", $8d
	.byte "HONESTY WILL", $8d
	.byte "REWARD THEE!", $8d
	.byte 0
	.byte "THOU DOST SHOW", $8d
	.byte "THY COMPASSION", $8d
	.byte "WELL, CONTINUED", $8d
	.byte "GOODWILL SHOULD", $8d
	.byte "BE THY GUIDE!", $8d
	.byte 0
	.byte "THOU ART SHOWING", $8d
	.byte "VALOR IN THE", $8d
	.byte "FACE OF DANGER", $8d
	.byte "STRIVE TO BECOME", $8d
	.byte "YET MORE SO!", $8d
	.byte 0
	.byte "THOU DOST SEEM", $8d
	.byte "FAIR AND JUST", $8d
	.byte "STRIVE TO UPHOLD", $8d
	.byte "JUSTICE EVEN", $8d
	.byte "MORE STERNLY!", $8d
	.byte 0
	.byte "THOU ART GIVING", $8d
	.byte "OF THYSELF IN", $8d
	.byte "SOME WAYS, SEEK", $8d
	.byte "YE NOW TO FIND", $8d
	.byte "YET MORE!", $8d
	.byte 0
	.byte "THOU DOST SEEM", $8d
	.byte "TO BE HONORABLE", $8d
	.byte "IN NATURE, SEEK", $8d
	.byte "TO BRING HONOR", $8d
	.byte "UPON OTHERS AS", $8d
	.byte "WELL!", $8d
	.byte 0
	.byte "THOU ART DOING", $8d
	.byte "WELL ON THE PATH", $8d
	.byte "TO INNER SIGHT", $8d
	.byte "CONTINUE TO SEEK", $8d
	.byte "THE INNER LIGHT!", $8d
	.byte 0
	.byte "THOU DOST SEEM", $8d
	.byte "A HUMBLE SOUL", $8d
	.byte "THOU ART SETTING", $8d
	.byte "STRONG STONES TO", $8d
	.byte "BUILD VIRTUES", $8d
	.byte "UPON!", $8d
	.byte 0
	.byte "THOU ART TRULY", $8d
	.byte "AN HONEST SOUL", $8d
	.byte "SEEK YE NOW TO", $8d
	.byte "REACH ELEVATION!", $8d
	.byte 0
	.byte "COMPASSION IS", $8d
	.byte "A VIRTUE THAT", $8d
	.byte "THOU HAST SHOWN", $8d
	.byte "WELL. SEEK YE", $8d
	.byte "NOW ELEVATION!", $8d
	.byte 0
	.byte "THOU ART A TRULY", $8d
	.byte "VALIANT WARRIOR", $8d
	.byte "SEEK YE NOW", $8d
	.byte "ELEVATION IN THE", $8d
	.byte "VIRTUE OF VALOR!", $8d
	.byte 0
	.byte "THOU ART JUST", $8d
	.byte "AND FAIR SEEK", $8d
	.byte "YE NOW THE", $8d
	.byte "ELEVATION!", $8d
	.byte 0
	.byte "THOU ART GIVING", $8d
	.byte "AND GOOD. THY", $8d
	.byte "SELF-SACRIFICE IS", $8d
	.byte "GREAT. SEEK", $8d
	.byte "NOW ELEVATION!", $8d
	.byte 0
	.byte "THOU HAST PROVEN", $8d
	.byte "THYSELF TO BE", $8d
	.byte "HONORABLE, SEEK", $8d
	.byte "YE NOW FOR THE", $8d
	.byte "ELEVATION!", $8d
	.byte 0
	.byte "SPIRITUALITY", $8d
	.byte "IS IN THY NATURE", $8d
	.byte "SEEK YE KNOW", $8d
	.byte "THE ELEVATION!", $8d
	.byte 0
	.byte "THY HUMILITY", $8d
	.byte "SHINES BRIGHT", $8d
	.byte "UPON THY BEING", $8d
	.byte "SEEK YE NOW FOR", $8d
	.byte "ELEVATION!", $8d
	.byte 0

; junk:  ,"HINT O
	.byte $2c,$22,$48,$49,$4e,$54,$20,$4f
