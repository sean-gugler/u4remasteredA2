	.include "uscii.i"
	.include "HELP.i"

;
; **** ZP ABSOLUTE ADRESSES ****
;
player_xpos = $00
party_size = $0f
;move_counter + 2 = $1e
temp_x = $fa
;
; **** ABSOLUTE ADRESSES ****
;
a811f = $811f
;
; **** USER LABELS ****
;
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
player_has_spoken_to_lb = $0015
last_sleep = $0016
last_humility_check = $0017
altar_room_principle = $0018
last_meditated = $0019
last_found_reagent = $001a
ship_hull = $001b
move_counter = $001c
;move_counter + 1 = $001d
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
console_xpos = $00ce
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
zpea = $00ea
moongate_tile = $00ed
moongate_xpos = $00ee
moongate_ypos = $00ef
zpf0 = $00f0
tilerow = $00f2
movement_mode = $00f4
direction = $00f5
temp2_x = $00f6
temp2_y = $00f7
delta_x = $00f8
delta_y = $00f9
temp_y = $00fb
ptr2 = $00fc
;ptr2 + 1 = $00fd
ptr1 = $00fe
;ptr1 + 1 = $00ff
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
	pla   ; pop 2 frames left from entering by BRUN
	pla
	pla
	pla
	lda #$01
	jsr music_ctl
	lda move_counter        ; BUFFIX Only give early help while
	ora move_counter+1      ; BUGFIX move counter < 1,000 - not just
	bne check_companions    ; BUGFIX simply when thousands digit is 0
	lda move_counter + 2
	and #$f0
	bne check_companions
	jmp help_early

check_companions:
	lda party_size
	cmp #$01
	bne check_runes
	jmp help_companions

check_runes:
	lda runes
	bne check_virtue
	jmp help_runes

check_virtue:
	ldx #$07
@next_virtue:
	lda party_stats,x
	beq check_stones
	dex
	bpl @next_virtue
	jmp help_virtues

check_stones:
	lda stones
	bne check_avatar
	jmp help_stones

check_avatar:
	ldx #$08
@next_virtue:
	dex
	bmi check_items
	lda party_stats,x
	beq @next_virtue
	jmp help_avatarhood

check_items:
	lda bell_book_candle
	and #$07
	cmp #$07
	beq check_threepartkey
	jmp help_items

check_threepartkey:
	lda threepartkey
	cmp #$07
	beq ready
	jmp help_threepartkey

ready:
	jmp help_ready

print_he_says:
	jsr j_primm  ;b'HE SAYS:\n\x00'
	.byte "HE SAYS:", $8d
	.byte 0
	rts

help_early:
	jsr print_he_says
	jsr j_primm  ;b'TO SURVIVE IN\nTHIS HOSTILE\nLAND THOU MUST\nFIRST KNOW\nTHYSELF! SEEK YE\nTO MASTER THY\nWEAPONS AND THY\nMAGICAL ABILITY!\n\x00'
	.byte "TO SURVIVE IN", $8d
	.byte "THIS HOSTILE", $8d
	.byte "LAND THOU MUST", $8d
	.byte "FIRST KNOW", $8d
	.byte "THYSELF! SEEK YE", $8d
	.byte "TO MASTER THY", $8d
	.byte "WEAPONS AND THY", $8d
	.byte "MAGICAL ABILITY!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nTAKE GREAT CARE\nIN THESE THY\nFIRST TRAVELS\nIN BRITANNIA.\n\x00'
	.byte $8d
	.byte "TAKE GREAT CARE", $8d
	.byte "IN THESE THY", $8d
	.byte "FIRST TRAVELS", $8d
	.byte "IN BRITANNIA.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nUNTIL THOU DOST\nWELL KNOW\nTHYSELF TRAVEL\nNOT FAR FROM THE\nSAFETY OF THE\nTOWNES!\n\x00'
	.byte $8d
	.byte "UNTIL THOU DOST", $8d
	.byte "WELL KNOW", $8d
	.byte "THYSELF TRAVEL", $8d
	.byte "NOT FAR FROM THE", $8d
	.byte "SAFETY OF THE", $8d
	.byte "TOWNES!", $8d
	.byte 0
	jmp return_to_main_conv

help_companions:
	jsr print_he_says
	jsr j_primm  ;b'TRAVEL NOT THE\nOPEN LANDS\nALONE, THERE ARE\nMANY WORTHY\nPEOPLE IN THE\nDIVERSE TOWNES\nWHOM IT WOULD BE\nWISE TO ASK TO\nJOIN THEE!\n\x00'
	.byte "TRAVEL NOT THE", $8d
	.byte "OPEN LANDS", $8d
	.byte "ALONE, THERE ARE", $8d
	.byte "MANY WORTHY", $8d
	.byte "PEOPLE IN THE", $8d
	.byte "DIVERSE TOWNES", $8d
	.byte "WHOM IT WOULD BE", $8d
	.byte "WISE TO ASK TO", $8d
	.byte "JOIN THEE!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nBUILD THY PARTY\nUNTO EIGHT\nTRAVELLERS, FOR\nONLY A TRUE\nLEADER CAN WIN\nTHE QUEST!\n\x00'
	.byte $8d
	.byte "BUILD THY PARTY", $8d
	.byte "UNTO EIGHT", $8d
	.byte "TRAVELLERS, FOR", $8d
	.byte "ONLY A TRUE", $8d
	.byte "LEADER CAN WIN", $8d
	.byte "THE QUEST!", $8d
	.byte 0
	jmp return_to_main_conv

help_runes:
	jsr print_he_says
	jsr j_primm  ;b'LEARN YE THE\nPATHS OF VIRTUE,\nSEEK TO GAIN\nENTRY UNTO THE\nEIGHT SHRINES!\n\x00'
	.byte "LEARN YE THE", $8d
	.byte "PATHS OF VIRTUE,", $8d
	.byte "SEEK TO GAIN", $8d
	.byte "ENTRY UNTO THE", $8d
	.byte "EIGHT SHRINES!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b"\nFIND YE THE\nRUNES, NEEDED\nFOR ENTRY INTO\nEACH SHRINE, AND\nLEARN EACH CHANT\nOR 'MANTRA' USED\nTO FOCUS THY\nMEDITATIONS.\n\x00"
	.byte $8d
	.byte "FIND YE THE", $8d
	.byte "RUNES, NEEDED", $8d
	.byte "FOR ENTRY INTO", $8d
	.byte "EACH SHRINE, AND", $8d
	.byte "LEARN EACH CHANT", $8d
	.byte "OR 'MANTRA' USED", $8d
	.byte "TO FOCUS THY", $8d
	.byte "MEDITATIONS.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nWITHIN THE\nSHRINES THOU\nSHALT LEARN OF\nTHE DEEDS WHICH\nSHOW THY INNER\nVIRTUE OR VICE!\n\x00'
	.byte $8d
	.byte "WITHIN THE", $8d
	.byte "SHRINES THOU", $8d
	.byte "SHALT LEARN OF", $8d
	.byte "THE DEEDS WHICH", $8d
	.byte "SHOW THY INNER", $8d
	.byte "VIRTUE OR VICE!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nCHOOSE THY PATH\nWISELY FOR ALL\nTHY DEEDS OF\nGOOD OR EVIL ARE\nREMEMBERED AND\nCAN RETURN TO\nHINDER THEE!\n\x00'
	.byte $8d
	.byte "CHOOSE THY PATH", $8d
	.byte "WISELY FOR ALL", $8d
	.byte "THY DEEDS OF", $8d
	.byte "GOOD OR EVIL ARE", $8d
	.byte "REMEMBERED AND", $8d
	.byte "CAN RETURN TO", $8d
	.byte "HINDER THEE!", $8d
	.byte 0
	jmp return_to_main_conv

help_virtues:
	jsr print_he_says
	jsr j_primm  ;b'VISIT THE SEER\nHAWKWIND OFTEN\nAND USE HIS\nWISDOM TO HELP\nTHEE PROVE THY\nVIRTUE.\n\x00'
	.byte "VISIT THE SEER", $8d
	.byte "HAWKWIND OFTEN", $8d
	.byte "AND USE HIS", $8d
	.byte "WISDOM TO HELP", $8d
	.byte "THEE PROVE THY", $8d
	.byte "VIRTUE.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nWHEN THOU ART\nREADY, HAWKWIND\nWILL ADVISE\nTHEE TO SEEK\nTHE ELEVATION\nUNTO PARTIAL\nAVATARHOOD IN A\nVIRTUE.\n\x00'
	.byte $8d
	.byte "WHEN THOU ART", $8d
	.byte "READY, HAWKWIND", $8d
	.byte "WILL ADVISE", $8d
	.byte "THEE TO SEEK", $8d
	.byte "THE ELEVATION", $8d
	.byte "UNTO PARTIAL", $8d
	.byte "AVATARHOOD IN A", $8d
	.byte "VIRTUE.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nSEEK YE TO\nBECOME A PARTIAL\nAVATAR IN ALL\nEIGHT VIRTUES,\nFOR ONLY THEN\nSHALT THOU BE\nREADY TO SEEK\nTHE CODEX!\n\x00'
	.byte $8d
	.byte "SEEK YE TO", $8d
	.byte "BECOME A PARTIAL", $8d
	.byte "AVATAR IN ALL", $8d
	.byte "EIGHT VIRTUES,", $8d
	.byte "FOR ONLY THEN", $8d
	.byte "SHALT THOU BE", $8d
	.byte "READY TO SEEK", $8d
	.byte "THE CODEX!", $8d
	.byte 0
	jmp return_to_main_conv

help_stones:
	jsr print_he_says
	jsr j_primm  ;b'GO YE NOW INTO\nTHE DEPTHS OF\nTHE DUNGEONS,\nTHEREIN RECOVER\nTHE 8 COLOURED\nSTONES FROM THE\nALTAR PEDESTALS\nIN THE HALLS\nOF THE DUNGEONS.\n\x00'
	.byte "GO YE NOW INTO", $8d
	.byte "THE DEPTHS OF", $8d
	.byte "THE DUNGEONS,", $8d
	.byte "THEREIN RECOVER", $8d
	.byte "THE 8 COLOURED", $8d
	.byte "STONES FROM THE", $8d
	.byte "ALTAR PEDESTALS", $8d
	.byte "IN THE HALLS", $8d
	.byte "OF THE DUNGEONS.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nFIND THE USES OF\nTHESE STONES FOR\nTHEY CAN HELP\nTHEE IN THE\nABYSS!\n\x00'
	.byte $8d
	.byte "FIND THE USES OF", $8d
	.byte "THESE STONES FOR", $8d
	.byte "THEY CAN HELP", $8d
	.byte "THEE IN THE", $8d
	.byte "ABYSS!", $8d
	.byte 0
	jmp return_to_main_conv

help_avatarhood:
	jsr print_he_says
	jsr j_primm  ;b'THOU ART DOING\nVERY WELL INDEED\nON THE PATH TO\nAVATARHOOD!\nSTRIVE YE TO\nACHIEVE THE\nELEVATION IN ALL\nEIGHT VIRTUES!\n\x00'
	.byte "THOU ART DOING", $8d
	.byte "VERY WELL INDEED", $8d
	.byte "ON THE PATH TO", $8d
	.byte "AVATARHOOD!", $8d
	.byte "STRIVE YE TO", $8d
	.byte "ACHIEVE THE", $8d
	.byte "ELEVATION IN ALL", $8d
	.byte "EIGHT VIRTUES!", $8d
	.byte 0
	jmp return_to_main_conv

help_items:
	jsr print_he_says
	jsr j_primm  ;b'FIND YE THE\nBELL, BOOK AND\nCANDLE! WITH\nTHESE THREE\nTHINGS, ONE MAY\nENTER THE GREAT\nSTYGIAN ABYSS!\n\x00'
	.byte "FIND YE THE", $8d
	.byte "BELL, BOOK AND", $8d
	.byte "CANDLE! WITH", $8d
	.byte "THESE THREE", $8d
	.byte "THINGS, ONE MAY", $8d
	.byte "ENTER THE GREAT", $8d
	.byte "STYGIAN ABYSS!", $8d
	.byte 0
	jmp return_to_main_conv

help_threepartkey:
	jsr print_he_says
	jsr j_primm  ;b'BEFORE THOU DOST\nENTER THE ABYSS\nTHOU SHALT NEED\nTHE KEY OF THREE\nPARTS, AND THE\nWORD OF PASSAGE.\n\x00'
	.byte "BEFORE THOU DOST", $8d
	.byte "ENTER THE ABYSS", $8d
	.byte "THOU SHALT NEED", $8d
	.byte "THE KEY OF THREE", $8d
	.byte "PARTS, AND THE", $8d
	.byte "WORD OF PASSAGE.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nTHEN MIGHT THOU\nENTER THE\nCHAMBER OF THE\nCODEX OF\nULTIMATE WISDOM!\n\x00'
	.byte $8d
	.byte "THEN MIGHT THOU", $8d
	.byte "ENTER THE", $8d
	.byte "CHAMBER OF THE", $8d
	.byte "CODEX OF", $8d
	.byte "ULTIMATE WISDOM!", $8d
	.byte 0
	jmp return_to_main_conv

help_ready:
	jsr print_he_says
	jsr j_primm  ;b'THOU DOST NOW\nSEEM READY TO\nMAKE THE FINAL\nJOURNEY INTO THE\nDARK ABYSS!\nGO ONLY WITH A\nPARTY OF EIGHT!\n\x00'
	.byte "THOU DOST NOW", $8d
	.byte "SEEM READY TO", $8d
	.byte "MAKE THE FINAL", $8d
	.byte "JOURNEY INTO THE", $8d
	.byte "DARK ABYSS!", $8d
	.byte "GO ONLY WITH A", $8d
	.byte "PARTY OF EIGHT!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nGOOD LUCK, AND\nMAY THE POWERS\nOF GOOD WATCH\nOVER THEE ON\nTHIS THY MOST\nPERILOUS\nENDEAVOUR!\n\x00'
	.byte $8d
	.byte "GOOD LUCK, AND", $8d
	.byte "MAY THE POWERS", $8d
	.byte "OF GOOD WATCH", $8d
	.byte "OVER THEE ON", $8d
	.byte "THIS THY MOST", $8d
	.byte "PERILOUS", $8d
	.byte "ENDEAVOUR!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm  ;b'\nTHE HEARTS AND\nSOULS OF ALL\nBRITANNIA GO\nWITH THEE NOW.\nTAKE CARE,\nMY FRIEND.\n\x00'
	.byte $8d
	.byte "THE HEARTS AND", $8d
	.byte "SOULS OF ALL", $8d
	.byte "BRITANNIA GO", $8d
	.byte "WITH THEE NOW.", $8d
	.byte "TAKE CARE,", $8d
	.byte "MY FRIEND.", $8d
	.byte 0
	jmp return_to_main_conv

return_to_main_conv:
	lda #$00
	jsr music_ctl
	jsr j_primm_cout ;b'\x04BRUN LORD,A$8800\n\x00'
	.byte $84,"BRUN LORD,A$8800", $8d
	.byte 0

; junk
;	sta temp_x
;	lda a811f
;	.byte $85  ;sta ...
