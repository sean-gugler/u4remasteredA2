	.include "uscii.i"
	.include "SUBS.i"

;
; **** ZP FIELDS ****
;
numdrives = $d1
;
; **** ZP ABSOLUTE ADRESSES ****
;
player_xpos = $00
player_ypos = $01
tile_xpos = $02
tile_ypos = $03
map_x = $04
map_y = $05
dest_x = $06
dest_y = $07
game_mode = $0b
dungeon_level = $0c
balloon_flying = $0d
player_transport = $0e
party_size = $0f
dng_direction = $10
moon_phase_trammel = $12
moon_phase_felucca = $13
ship_hull = $1b
a48 = $48
a4e = $4e
key_buf = $b0
key_buf_len = $b8
charptr = $bd
;charptr+1 = $be
abf = $bf
first_x = $c0
first_y = $c1
count_x = $c2
count_y = $c3
curr_x = $c4
curr_y = $c5
magic_aura = $c6
tile_under_player = $c8
tile_north = $c9
tile_south = $ca
tile_east = $cb
tile_west = $cc
acd = $cd
console_xpos = $ce
console_ypos = $cf
diskid = $d0
;numdrives = $d1
currdisk_drive1 = $d2
currdisk_drive2 = $d3
currplayer = $d4
hexnum = $d6
bcdnum = $d7
ad8 = $d8
ada = $da
reqdisk = $de
currdrive = $df
lt_y = $e0
lt_x = $e1
lt_rwflag = $e2
lt_addr_hi = $e3
moongate_tile = $ed
moongate_xpos = $ee
moongate_ypos = $ef
af0 = $f0
af1 = $f1
tilerow = $f2
movement_mode = $f4
direction = $f5
temp_x = $fa
temp_y = $fb
ptr2 = $fc
;ptr2+1 = $fd
ptr1 = $fe
;ptr1 + 1 = $ff
;
; **** ZP POINTERS ****
;
;ptr2 = $fc
;ptr1 = $fe
;
; **** FIELDS ****
;
fd000 = $d000
fd100 = $d100
fd200 = $d200
fd300 = $d300
fd400 = $d400
fd500 = $d500
fd600 = $d600
fd700 = $d700
fd800 = $d800
fd900 = $d900
fda00 = $da00
fdb00 = $db00
fdc00 = $dc00
fdd00 = $dd00
fde00 = $de00
fdf00 = $df00
fff00 = $ff00
fffff = $ffff
;
; **** ABSOLUTE ADRESSES ****
;
a200b = $200b
a200c = $200c
a240b = $240b
a240c = $240c
a280b = $280b
a280c = $280c
a2c0b = $2c0b
a2c0c = $2c0c
a300b = $300b
a300c = $300c
a340b = $340b
a340c = $340c
a380b = $380b
a380c = $380c
a3c0b = $3c0b
a3c0c = $3c0c
abd5d = $bd5d
abf2c = $bf2c
ac083 = $c083
ac08b = $c08b
ad10b = $d10b
ad10e = $d10e
ad20b = $d20b
ad20e = $d20e
ad210 = $d210
ad212 = $d212
ad30a = $d30a
ad310 = $d310
ad312 = $d312
ad40a = $d40a
;
; **** POINTERS ****
;
pe400 = $e400
;
; **** EXTERNAL JUMPS ****
;
e8c03 = $8c03
;
; **** USER LABELS ****
;
CSWL = $0036
;key_buf+1 = $00b1
currmap = $0200
tempmap = $0280
;tempmap+49 = $02b1
;tempmap+59 = $02bb
;tempmap+60 = $02bc
;tempmap+61 = $02bd
;tempmap+71 = $02c7
music_ctl = $0320
spin_drive_motor = $0323
err_resume_addr = $0326
;err_resume_addr + 1 = $0327
err_resume_stack = $0328
hgr = $2000
j_readblock = $b7b5
rwts_volume = $b7eb
rwts_track = $b7ec
rwts_sector = $b7ed
rwts_buf_lo = $b7f0
rwts_buf_hi = $b7f1
rwts_command = $b7f4
hw_keyboard = $c000
hw_strobe = $c010
togglesnd = $c030
bmplineaddr_lo = $e000
;bmplineaddr_lo+8 = $e008
bmplineaddr_hi = $e0c0
;bmplineaddr_hi+8 = $e0c8
towne_map = $e800
dng_map = $e800
world_map_nw = $e800
world_map_ne = $e900
world_map_sw = $ea00
world_map_se = $eb00
virtues_and_stats = $ed00
map_status = $ee00
object_xpos = $ee20
object_ypos = $ee40
object_tile = $ee60
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



	.segment "SUBS"

j_waitkey:
	jmp waitkey

j_player_teleport:
	jmp player_teleport

j_move_east:
	jmp move_east

j_move_west:
	jmp move_west

j_move_south:
	jmp move_south

j_move_north:
	jmp move_north

j_drawinterface:
	jmp drawinterface

j_drawview:
	jmp drawview

j_update_britannia:
	jmp update_britannia

j_primm_cout:
	jmp primm_cout

j_primm_xy:
	jmp primm_xy

j_primm:
	jmp primm

j_console_out:
	jmp console_out

j_clearbitmap:
	jmp clearbitmap

j_mulax:
	jmp mulax

j_get_stats_ptr:
	jmp get_stats_ptr

j_printname:
	jmp printname

j_printbcd:
	jmp printbcd

j_drawcursor:
	jmp drawcursor

j_drawcursor_xy:
	jmp drawcursor_xy

j_drawvert:
	jmp drawvert

j_drawhoriz:
	jmp drawhoriz

j_request_disk:
	jmp request_disk

j_update_status:
	jmp update_status

j_blocked_tile:
	jmp blocked_tile

j_update_view:
	jmp idle

j_rand:
	jmp rand

j_loadsector:
	jmp loadsector

j_playsfx:
	jmp playsfx

j_update_view_combat:
	jmp idle_combat

j_getnumber:
	jmp getnumber

j_getplayernum:
	jmp getplayernum

j_update_wind:
	jmp update_wind

j_animate_view:
	jmp animate_view

j_printdigit:
	jmp printdigit

j_clearstatwindow:
	jmp clearstatwindow

j_animate_tiles:
	jmp animate_tiles

j_centername:
	jmp centername

j_print_direction:
	jmp print_direction

j_clearview:
	jmp clearview

j_invertview:
	jmp invertview

j_centerstring:
	jmp centerstring

j_printstring:
	jmp printstring

j_gettile_bounds:
	jmp gettile_bounds

j_gettile_britannia:
	jmp gettile_britannia

j_gettile_opposite:
	jmp gettile_opposite

j_gettile_currmap:
	jmp gettile_currmap

j_gettile_tempmap:
	jmp gettile_tempmap

j_get_player_tile:
	jmp get_player_tile

j_gettile_towne:
	jmp gettile_towne

j_gettile_dungeon:
	jmp gettile_dungeon

move_east:
	inc player_xpos
	inc tile_xpos
	lda tile_xpos
	cmp #$18
	bcc @notileborder
	jsr spin_drive_motor
@notileborder:
	cmp #$1b
	bcc movedone
	and #$0f
	sta tile_xpos
	jsr map_scroll_east
	inc map_x
	lda map_x
	and #$0f
	sta map_x
	jsr loadtiles_east
movedone:
	rts

move_west:
	dec player_xpos
	dec tile_xpos
	lda tile_xpos
	cmp #$08
	bcs @notileborder
	jsr spin_drive_motor
@notileborder:
	cmp #$05
	bcs movedone
	ora #$10
	sta tile_xpos
	jsr map_scroll_west
	dec map_x
	lda map_x
	and #$0f
	sta map_x
	jmp loadtiles_west

move_south:
	inc player_ypos
	inc tile_ypos
	lda tile_ypos
	cmp #$18
	bcc @notileborder
	jsr spin_drive_motor
@notileborder:
	cmp #$1b
	bcc @done
	and #$0f
	sta tile_ypos
	jsr map_scroll_south
	inc map_y
	lda map_y
	and #$0f
	sta map_y
	jsr loadtiles_south
@done:
	rts

move_north:
	dec player_ypos
	dec tile_ypos
	lda tile_ypos
	cmp #$08
	bcs @notileborder
	jsr spin_drive_motor
@notileborder:
	cmp #$05
	bcs @done
	ora #$10
	sta tile_ypos
	jsr map_scroll_north
	dec map_y
	lda map_y
	and #$0f
	sta map_y
	jsr loadtiles_north
@done:
	rts

map_scroll_east:
	ldx #$00
@scroll:
	lda world_map_ne,x
	sta world_map_nw,x
	lda world_map_se,x
	sta world_map_sw,x
	inx
	bne @scroll
	rts

map_scroll_west:
	ldx #$00
@scroll:
	lda world_map_nw,x
	sta world_map_ne,x
	lda world_map_sw,x
	sta world_map_se,x
	inx
	bne @scroll
	rts

map_scroll_south:
	ldx #$00
@scroll:
	lda world_map_sw,x
	sta world_map_nw,x
	lda world_map_se,x
	sta world_map_ne,x
	inx
	bne @scroll
	rts

map_scroll_north:
	ldx #$00
@scroll:
	lda world_map_nw,x
	sta world_map_sw,x
	lda world_map_ne,x
	sta world_map_se,x
	inx
	bne @scroll
	rts

loadtiles_east:
	lda #$01
	sta lt_rwflag
	clc
	lda map_x
	adc #$01
	and #$0f
	sta lt_x
	lda map_y
	sta lt_y
	lda #>world_map_ne
	sta lt_addr_hi
	jsr loadsector
	clc
	lda map_y
	adc #$01
	and #$0f
	sta lt_y
	lda #>world_map_se
	sta lt_addr_hi
	jmp loadsector

loadtiles_west:
	lda #$01
	sta lt_rwflag
	clc
	lda map_x
	sta lt_x
	lda map_y
	sta lt_y
	lda #>world_map_nw
	sta lt_addr_hi
	jsr loadsector
	clc
	lda map_y
	adc #$01
	and #$0f
	sta lt_y
	lda #>world_map_sw
	sta lt_addr_hi
	jmp loadsector

loadtiles_south:
	lda #$01
	sta lt_rwflag
	clc
	lda map_y
	adc #$01
	and #$0f
	sta lt_y
	lda map_x
	sta lt_x
	lda #>world_map_sw
	sta lt_addr_hi
	jsr loadsector
	clc
	lda map_x
	adc #$01
	and #$0f
	sta lt_x
	lda #>world_map_se
	sta lt_addr_hi
	jmp loadsector

loadtiles_north:
	lda #$01
	sta lt_rwflag
	clc
	lda map_y
	sta lt_y
	lda map_x
	sta lt_x
	lda #>world_map_nw
	sta lt_addr_hi
	jsr loadsector
	clc
	lda map_x
	adc #$01
	and #$0f
	sta lt_x
	lda #>world_map_ne
	sta lt_addr_hi
	jmp loadsector

player_teleport:
	lda player_xpos
	jsr div16
	sta map_x
	lda player_xpos
	and #$0f
	sta tile_xpos
	cmp #$08
	bcs @eastern
	clc
	adc #$10
	sta tile_xpos
	dec map_x
	lda map_x
	and #$0f
	sta map_x
@eastern:
	lda player_ypos
	jsr div16
	sta map_y
	lda player_ypos
	and #$0f
	sta tile_ypos
	cmp #$08
	bcs @southern
	clc
	adc #$10
	sta tile_ypos
	dec map_y
	lda map_y
	and #$0f
	sta map_y
@southern:
	lda #$01
	sta lt_rwflag
	lda map_x
	sta lt_x
	lda map_y
	sta lt_y
	lda #>world_map_nw
	sta lt_addr_hi
	jsr loadsector
	clc
	lda map_x
	adc #$01
	and #$0f
	sta lt_x
	lda #>world_map_ne
	sta lt_addr_hi
	jsr loadsector
	clc
	lda map_y
	adc #$01
	and #$0f
	sta lt_y
	lda #>world_map_se
	sta lt_addr_hi
	jsr loadsector
	lda map_x
	sta lt_x
	lda #>world_map_sw
	sta lt_addr_hi
loadsector:
	lda #$00
	sta rwts_volume
	sta rwts_buf_lo
	lda lt_y
	sta rwts_track
	lda lt_x
	sta rwts_sector
	lda lt_addr_hi
	sta rwts_buf_hi
	lda lt_rwflag
	sta rwts_command
	lda #$ad     ;sector header marker for DATA
	sta a4e
	sta abd5d    ;RWTS_marker_byte_3
	lda #$9b
	sta abf2c
	lda #$e8     ;RWTS_param_LO
	ldy #$b7     ;RWTS_param_HI
	jsr j_readblock
	lda #$00
	sta a48
	bcs loadsector
	rts

waitkey:
	lda #$80
	sta idletimeout
@wait:
	jsr scankey
	jsr drawcursor
	jsr getkey
	bmi @gotkey
	jsr idle
	dec idletimeout
	bne @wait
	jsr clearcursor
	lda #$00
	rts

@gotkey:
	pha
	jsr clearcursor
	pla
	cmp #$00
	rts

idletimeout:
	.byte 0

idle:
	lda game_mode
	beq delay
	bmi idle_other
idle_britannia:
	cmp #$01
	bne idle_towne
	jsr update_wind
	jsr update_balloon
	jsr update_britannia
	rts

idle_towne:
	cmp #$02
	bne idle_dungeon
	jsr update_towne
	rts

idle_dungeon:
	cmp #$03
	bne idle_delay
	jsr scroll_tiles
	jsr animate_fields
	jsr e8c03
idle_delay:
	jmp delay

idle_other:
	cmp #$ff
	beq @animate
	jmp idle_combat

@animate:
	jmp animate_view

delay:
	ldx #$4b
	ldy #$00
@delay:
	dey
	bne @delay
	dex
	bne @delay
	rts

update_balloon:
	lda player_transport
	cmp #tile_balloon
	bne @done
	lda movement_mode
	beq @done
	dec movement_counter
	lda movement_counter
	and #$03
	bne @done
@east:
	ldx direction
	bne @south
	jmp move_east

@south:
	dex
	bne @west
	jmp move_south

@west:
	dex
	bne @north
	jmp move_west

@north:
	jmp move_north

@done:
	rts

movement_counter:
	.byte 0

animate_view:
	jsr scroll_tiles
	jsr animate_fields
	jmp drawview

idle_combat:
	jsr scroll_tiles
	jsr animate_fields
	ldx #$7f
@copy:
	lda tempmap,x
	sta currmap,x
	dex
	bpl @copy
	ldx #$0f
@nextmonster:
	ldy combat_foe_cur_y,x
	lda mul_11,y
	clc
	adc combat_foe_cur_x,x
	tay
	lda combat_foe_tile,x
	beq @next
	cmp #tile_anhk          ; BUGFIX
	beq @dontanim           ; BUGFIX
	cmp #tile_camp_fire     ; BUGFIX
	beq @dontanim           ; BUGFIX
	lda combat_foe_slept,x
	bne @dontanim
	lda combat_foe_tile,x
	cmp #$90
	bcs @checkmimic
	jsr rand
	and #$01
@settile:
	clc
	adc combat_foe_tile,x
	sta combat_foe_drawn_tile,x
	sta currmap,y
	jmp @next

@checkmimic:
	cmp #$ac
	bne @anim4
	lda combat_foe_drawn_tile,x
	cmp #$3c
	bne @anim4
	sta currmap,y
	jmp @next

@anim4:
	jsr rand
	and #$01
	beq @dontanim
	inc combat_foe_drawn_tile,x
	lda combat_foe_drawn_tile,x
	and #$03
	jmp @settile

@dontanim:
	lda combat_foe_drawn_tile,x
	sta currmap,y
@next:
	dex
	bpl @nextmonster
animateplayers:
	ldx party_size
@nextplayer:
	lda combat_player_tile-1,x
	beq @next
	ldy combat_player_ypos-1,x
	lda mul_11,y
	clc
	adc combat_player_xpos-1,x
	tay
	lda combat_player_tile-1,x
	cmp #$38
	beq @settile
	cpx curr_y
	bne @animate
	dec movement_counter
	lda movement_counter
	and #$03
	bne @animate
	lda #$7d
	jmp @settile

@animate:
	jsr rand
	and #$01
	clc
	adc combat_player_tile-1,x
@settile:
	sta currmap,y
@next:
	dex
	bne @nextplayer
	lda attack_sprite
	beq @done
	ldx target_y
	lda mul_11,x
	clc
	adc target_x
	tay
	lda attack_sprite
	sta currmap,y
@done:
	jmp drawview

update_towne:
	jsr animate_tiles
	sec
	lda player_xpos
	sbc #xy_center_screen
	sta first_x
	sec
	lda player_ypos
	sbc #xy_center_screen
	sta first_y
	lda #$00
	sta count_x
	sta count_y
	tay
	tax
@nexttile:
	clc
	lda first_x
	adc count_x
	sta curr_x
	cmp #xy_last_towne
	bcs @out_of_bounds
	clc
	lda first_y
	adc count_y
	sta curr_y
	cmp #xy_last_towne
	bcs @out_of_bounds
	sta ptr2+1
	lda #$00
	lsr ptr2+1
	ror
	lsr ptr2+1
	ror
	lsr ptr2+1
	ror
	adc curr_x
	sta ptr2
	clc
	lda ptr2+1
	adc #>world_map_nw
	sta ptr2+1
	lda (ptr2),y
	jmp @settile

@out_of_bounds:
	lda #tile_grass
@settile:
	sta tempmap,x
	inx
	inc count_x
	lda count_x
	cmp #xy_last_screen
	bne @nexttile
	sty count_x
	inc count_y
	lda count_y
	cmp #xy_last_screen
	bne @nexttile
	jmp update_monsters

update_britannia:
	jsr animate_tiles
	jsr update_moons
	sec
	lda tile_xpos
	sbc #xy_center_screen
	sta first_x
	sec
	lda tile_ypos
	sbc #xy_center_screen
	sta first_y
	lda #$00
	sta count_x
	sta count_y
	tay
	tax
@copymap:
	clc
	lda first_x
	adc count_x
	sta curr_x
	clc
	lda first_y
	adc count_y
	sta curr_y
	jsr mul16
	sta ptr2
	lda curr_x
	and #$0f
	ora ptr2
	sta ptr2
	lda curr_y
	and #$10
	asl
	ora curr_x
	jsr div16
	clc
	adc #>world_map_nw
	sta ptr2+1
	lda (ptr2),y
	sta tempmap,x
	inx
	inc count_x
	lda count_x
	cmp #xy_last_screen
	bne @copymap
	sty count_x
	inc count_y
	lda count_y
	cmp #xy_last_screen
	bne @copymap
update_monsters:
	ldx #$1f
@nextmonster:
	lda map_status,x
	beq @nomonster
	lda object_xpos,x
	clc
	adc #xy_center_screen
	sec
	sbc player_xpos
	cmp #xy_last_screen
	bcs @nomonster
	sta curr_x
	lda object_ypos,x
	clc
	adc #xy_center_screen
	sec
	sbc player_ypos
	cmp #xy_last_screen
	bcs @nomonster
	sta curr_y
	ldy curr_y
	lda mul_11,y
	clc
	adc curr_x
	tay
	lda map_status,x
	sta tempmap,y
@nomonster:
	dex
	bpl @nextmonster
	lda moongate_tile
	beq @skipmoongates
	lda moongate_xpos
	clc
	adc #xy_center_screen
	sec
	sbc player_xpos
	cmp #xy_last_screen
	bcs @skipmoongates
	sta curr_x
	lda moongate_ypos
	clc
	adc #xy_center_screen
	sec
	sbc player_ypos
	cmp #xy_last_screen
	bcs @skipmoongates
	sta curr_y
	ldy curr_y
	lda mul_11,y
	clc
	adc curr_x
	tay
	lda moongate_tile
	sta tempmap,y
@skipmoongates:
	lda tempmap+(xy_last_screen * (xy_center_screen - 1) + xy_center_screen)
	sta tile_north
	lda tempmap+(xy_last_screen * (xy_center_screen + 1) + xy_center_screen)
	sta tile_south
	lda tempmap+(xy_last_screen * (xy_center_screen) + xy_center_screen + 1)
	sta tile_east
	lda tempmap+(xy_last_screen * (xy_center_screen) + xy_center_screen - 1)
	sta tile_west
	lda tempmap+(xy_last_screen * (xy_center_screen) + xy_center_screen)
	sta tile_under_player
	lda player_transport
	sta tempmap+(xy_last_screen * (xy_center_screen) + xy_center_screen)
	lda balloon_flying
	beq lineofsight
	ldx #(xy_last_screen * xy_last_screen - 1)
@copy:
	lda tempmap,x
	sta currmap,x
	dex
	bpl @copy
	jmp drawview

lineofsight:
	ldx #(xy_last_screen * xy_last_screen - 1)
	lda #tile_blank
@clear:
	sta currmap,x
	dex
	bpl @clear
	lda #(xy_last_screen * xy_last_screen - 1)
	sta af0
	lda #$0a
	sta curr_x
	sta curr_y
lospass1:
	lda curr_x
	sta first_x
	lda curr_y
	sta first_y
	lda af0
	sta af1
@nexttile:
	ldx first_x
	ldy first_y
	lda af1
	clc
	adc deltax,x
	clc
	adc deltay,y
	cmp #$3c
	beq @playertile
	sta af1
	tax
	lda tempmap,x
	cmp #tile_forest
	beq @blocking
	cmp #tile_mountain
	beq @blocking
	cmp #tile_secret_panel
	beq @blocking
	cmp #tile_blank
	beq @blocking
	cmp #tile_wall
	beq @blocking
	lda first_x
	tax
	clc
	adc deltax,x
	sta first_x
	lda first_y
	tax
	clc
	adc deltax,x
	sta first_y
	jmp @nexttile

@playertile:
	ldx af0
	lda tempmap,x
	sta currmap,x
@blocking:
	dec af0
	dec curr_x
	bpl lospass1
	lda #xy_last_screen - 1
	sta curr_x
	dec curr_y
	bpl lospass1
lospass2:
	lda #$78
	sta af0
	lda #xy_last_screen - 1
	sta curr_x
	sta curr_y
@next:
	lda curr_x
	sta first_x
	lda curr_y
	sta first_y
	lda af0
	sta af1
	tax
	lda currmap,x
	cmp #tile_blank
	bne @blocking
@continue:
	ldx first_x
	ldy first_y
	lda distance,x
	cmp distance,y
	beq @diagonal
	bcc @vertical
	bcs @horizontal
@diagonal:
	lda af1
	clc
	adc deltax,x
	clc
	adc deltay,y
	jsr nexthoriz
	jsr nextvert
	jmp @checkblock

@horizontal:
	lda af1
	clc
	adc deltax,x
	jsr nexthoriz
	jmp @checkblock

@vertical:
	lda af1
	clc
	adc deltay,y
	jsr nextvert
@checkblock:
	cmp #$3c
	beq @playertile
	sta af1
	tax
	lda tempmap,x
	cmp #tile_forest
	beq @blocking
	cmp #tile_mountain
	beq @blocking
	cmp #tile_secret_panel
	beq @blocking
	cmp #tile_blank
	beq @blocking
	cmp #tile_wall
	beq @blocking
	jmp @continue

@playertile:
	ldx af0
	lda tempmap,x
	sta currmap,x
@blocking:
	dec af0
	dec curr_x
	bpl @next
	lda #$0a
	sta curr_x
	dec curr_y
	bmi drawview
	jmp @next

drawview:
	lda #$00
	sta tilerow
	sta a0e9d
b0e7b:
	ldy tilerow
	lda bmplineaddr_lo+8,y
	sta a0ea6
	sta a0eb0
	lda bmplineaddr_hi+8,y
	sta a0ea7
	sta a0eb1
	tya
	and #$0f
	ora #$d0
	sta a0ea4
	sta a0eae
	ldx #$01
a0e9d=*+$01
b0e9c:
	ldy currmap
	bit ac08b
a0ea4=*+$02
	lda fff00,y
a0ea6=*+$01
a0ea7=*+$02
	sta fffff,x
	inx
	bit ac083
a0eae=*+$02
	lda fff00,y
a0eb0=*+$01
a0eb1=*+$02
	sta fffff,x
	inc a0e9d
	inx
	cpx #$17
	bcc b0e9c
	inc tilerow
	lda tilerow
	cmp #$b0
	beq @done
	and #$0f
	beq b0e7b
	lda a0e9d
	sec
	sbc #$0b
	sta a0e9d
	jsr scankey
	jmp b0e7b

@done:
	rts

deltax:
	.byte 1, 1, 1, 1, 1, 0, <-1, <-1, <-1, <-1, <-1
deltay:
	.byte 11, 11, 11, 11, 11, 0, <-11, <-11, <-11, <-11, <-11
distance:
	.byte 5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5

nexthoriz:
	pha
	lda first_x
	tax
	clc
	adc deltax,x
	sta first_x
	pla
	rts

nextvert:
	pha
	lda first_y
	tax
	clc
	adc deltax,x
	sta first_y
	pla
	rts

animate_tiles:
	ldx #$00
@animate_next:
	lda object_tile,x
	beq @animend
	bpl @animate_nonmonster
	cmp #$90
	bcs @animate_monster
	cmp #$80
	beq @animdone
@animate_seamonster:
	jsr fastrand
	cmp #$c0
	bcs @animdone
	lda map_status,x
	eor #$01
	and #$01
	ora object_tile,x
	sta map_status,x
	jmp @animdone

@animate_monster:
	jsr fastrand
	cmp #$c0
	bcs @animdone
	lda map_status,x
	clc
	adc #$01
	and #$03
	ora object_tile,x
	sta map_status,x
	jmp @animdone

@animate_nonmonster:
	cmp #$50
	bcc @animate_player
	cmp #$60
	bcs @dontanim
@animate_npc:
	jmp @animate_seamonster

@animate_player:
	cmp #$20
	bcc @dontanim
	cmp #$30
	bcs @dontanim
	jmp @animate_seamonster

@dontanim:
	lda object_tile,x
	sta map_status,x
	jmp @animdone

@animend:
	lda #$00
	sta map_status,x
@animdone:
	inx
	cpx #$20
	bcc @animate_next
	jsr scroll_tiles
	jsr animate_fields
	jmp animate_flags

primm_xy:
	stx console_xpos
	sty console_ypos
primm:
	pla
	sta @primmaddr
	pla
	sta @primmaddr + 1
@next:
	inc @primmaddr
	bne @skip
	inc @primmaddr + 1
@primmaddr=*+$01
@skip:
	lda fffff
	beq @done
	jsr console_out
	jmp @next

@done:
	lda @primmaddr + 1
	pha
	lda @primmaddr
	pha
	rts

console_out:
	cmp #$8d
	beq console_newline
	and #$7f
	ldx console_xpos
	cpx #$28
	bcc @noteol
	pha
	jsr console_newline
	pla
@noteol:
	jsr drawchar
	inc console_xpos
	rts

console_newline:
	lda #$18
	sta console_xpos
	inc console_ypos
	lda console_ypos
	cmp #$18
	bcc @notbottom
	dec console_ypos
	jsr console_scroll
@notbottom:
	rts

primm_cout:
	pla
	sta err_resume_addr
	sta ptr1
	pla
	sta err_resume_addr + 1
	sta ptr1 + 1
	tsx
	stx err_resume_stack
	ldy #$00
@next:
	inc ptr1
	bne @skip
	inc ptr1 + 1
@skip:
	lda (ptr1),y
	beq @done
	ora #$80
	jsr @cout
	jmp @next

@done:
	sta key_buf_len
	lda ptr1 + 1
	pha
	lda ptr1
	pha
	rts

@cout:
	jmp (CSWL)  ; character output hook

get_stats_ptr:
	lda currplayer
	sec
	sbc #$01
	jsr mul32
	sta ptr1
	lda #$ec
	sta ptr1 + 1
	rts

centername:
	jsr get_stats_ptr
	lda #$00
	sta ada
@count:
	ldy ada
	lda (ptr1),y
	beq @gotlen
	inc ada
	lda ada
	cmp #$0f
	bcc @count
@gotlen:
	lda #$0f
	sec
	sbc ada
	lsr
	clc
	adc console_xpos
	sta console_xpos
printname:
	jsr get_stats_ptr
	lda #$00
	sta ada
@print:
	ldy ada
	lda (ptr1),y
	beq @done
	jsr console_out
	inc ada
	lda ada
	cmp #$0f
	bcc @print
@done:
	rts

printname8:
	jsr get_stats_ptr
	lda #$00
	sta ada
@print:
	ldy ada
	lda (ptr1),y
	beq @done
	jsr console_out
	inc ada
	lda ada
	cmp #$08
	bcc @print
@done:
	rts

drawcursor_xy:
	stx console_xpos
	sty console_ypos
drawcursor:
	dec cursor_ctr
	lda cursor_ctr
	and #$7f
	ora #$7c
	bne dodrawcursor
clearcursor:
	lda #$20
dodrawcursor:
	jsr console_out
	dec console_xpos
	rts

cursor_ctr:
	.byte 0

printbcd:
	sta ada
	jsr div16
	clc
	adc #$30
	jsr console_out
	lda ada
	and #$0f
printdigit:
	clc
	adc #$30
	jmp console_out

clearstatwindow:
	jsr drawhoriz
	.byte $18,$00,$04,$05,$04,$05,$04,$05
	.byte $04,$05,$04,$05,$04,$05,$04,$05
	.byte $04,$ff
	ldx #$08
@clearstatline:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	ldy #$18
	lda #$80
@clear:
	sta (ptr1),y
	iny
	cpy #$27
	bcc @clear
	inx
	cpx #$48
	bcc @clearstatline
	rts

update_status:
	lda #>pe400
	sta ptr1 + 1
	lda #<pe400
	sta ptr1
	ldx #$00
@next_virtue:
	lda virtues_and_stats,x
	beq @partial_avatar
	lda #$00
	beq @not_avatar
@partial_avatar:
	ldy #$2f
	lda (ptr1),y
@not_avatar:
	ldy #$25
	sta (ptr1),y
	clc
	lda ptr1
	adc #$80
	sta ptr1
	bcc :+
	inc ptr1 + 1
:	inx
	cpx #$08
	bne @next_virtue
	jsr stats_save_pos
	lda currplayer
	pha
	lda party_size
	sta currplayer
@nextplayer:
	ldx currplayer
	jsr get_stats_ptr
	lda currplayer
	sta console_ypos
	lda #$18
	sta console_xpos
	lda currplayer
	jsr printdigit
	lda #$ad
	jsr console_out
	jsr printname8
	lda #$23
	sta console_xpos
	jsr get_stats_ptr
	ldy #$18
	lda (ptr1),y
	jsr printdigit
	ldy #$19
	lda (ptr1),y
	jsr printbcd
	ldy #$12
	lda (ptr1),y
	jsr console_out
	jsr scankey
	dec currplayer
	bne @nextplayer
@printfood:
	ldx #$18
	ldy #$0a
	jsr primm_xy ;"F:"
	.byte "F:", 0
	ldy #$10
	lda virtues_and_stats,y
	jsr printbcd
	ldy #$11
	lda virtues_and_stats,y
	jsr printbcd
	lda #$a0
	jsr console_out
	lda magic_aura
	jsr console_out
	lda player_transport
	cmp #$14
	bcc @ship
	jsr primm    ;" G:"
	.byte " G:", 0
	ldy #$13
	lda virtues_and_stats,y
	jsr printbcd
	ldy #$14
	lda virtues_and_stats,y
	jsr printbcd
	jmp @done

@ship:
	jsr primm    ;" SHP:"
	.byte " SHP:", 0
	lda ship_hull
	jsr printbcd
@done:
	pla
	sta currplayer
	jmp stats_rest_pos

stats_saved_xpos:
	.byte 0
stats_saved_ypos:
	.byte 0

update_wind:
	jsr rand
	bne @nochange
	jsr rand
	jsr getsign
	clc
	adc direction
	and #$03
	sta direction
@nochange:
	jsr stats_save_pos
	lda #$17
	sta console_ypos
	lda #$06
	sta console_xpos
	jsr primm    ;"WIND "
	.byte $1e,$d7,$c9,$ce,$c4,$a0,$00
	ldx direction
	beq @west
	dex
	beq @north
	dex
	beq @east
	dex
	beq @south
	bne @done
@west:
	jsr printwest
	jmp @done

@north:
	jsr printnorth
	jmp @done

@east:
	jsr printeast
	jmp @done

@south:
	jsr printsouth
@done:
	lda #$1d
	jsr console_out
	jmp stats_rest_pos

print_direction:
	jsr stats_save_pos
	lda #$17
	sta console_ypos
	lda #$07
	sta console_xpos
	jsr primm    ;"DIR: "
	.byte "DIR: ", 0
	ldx dng_direction
	beq @north
	dex
	beq @east
	dex
	beq @south
	bne @west
@north:
	jsr printnorth
	jmp @printlevel

@east:
	jsr printeast
	jmp @printlevel

@south:
	jsr printsouth
	jmp @printlevel

@west:
	jsr printwest
@printlevel:
	lda #$00
	sta console_ypos
	lda #$0b
	sta console_xpos
	lda #$cc
	jsr console_out
	lda dungeon_level
	clc
	adc #$01
	jsr printdigit
	jmp stats_rest_pos

printnorth:
	jsr primm    ;"NORTH"
	.byte "NORTH", 0
	rts

printsouth:
	jsr primm    ;"SOUTH"
	.byte "SOUTH", 0
	rts

printeast:
	jsr primm    ;" EAST"
	.byte " EAST", 0
	rts

printwest:
	jsr primm    ;" WEST"
	.byte " WEST", 0
	rts

getsign:
	cmp #$00
	beq @zero
	bmi @negative
	lda #$01
	rts

@negative:
	lda #$ff
@zero:
	rts

stats_save_pos:
	lda console_xpos
	sta stats_saved_xpos
	lda console_ypos
	sta stats_saved_ypos
	rts

stats_rest_pos:
	lda stats_saved_xpos
	sta console_xpos
	lda stats_saved_ypos
	sta console_ypos
	rts

getnumdel:
	dec console_xpos
getnumber:
	jsr waitkey
	sec
	sbc #$b0
	cmp #$0a
	bcs getnumber
	sta bcdnum
	sta hexnum
	jsr printdigit
@seconddigit:
	jsr waitkey
	cmp #$8d
	beq @done
	cmp #$88
	beq getnumdel
	sec
	sbc #$b0
	cmp #$0a
	bcs @seconddigit
	sta hexnum
	jsr printdigit
@notretordel:
	jsr waitkey
	cmp #$8d
	beq @convhex
	cmp #$88
	bne @notretordel
	dec console_xpos
	bpl @seconddigit
@convhex:
	lda bcdnum
	jsr mul16
	ora hexnum
	sta bcdnum
	ldx #$00
	sed
	sec
@count:
	sbc #$01
	bcc @counted
	inx
	bne @count
@counted:
	stx hexnum
	cld
@done:
	rts

getplayernum:
	jsr waitkey
	beq @gotnum
	sec
	sbc #$b0
	cmp #$09
	bcc @gotnum
	lda #$00
@gotnum:
	sta currplayer
	jsr printdigit
	jsr console_newline
	lda currplayer
	rts

blocked_tile:
	ldx #$28
@next:
	dex
	bmi @blocked
	cmp walkable_tiles,x
	bne @next
	rts

@blocked:
	lda #$ff
	rts

walkable_tiles:
	.byte $03,$04,$05,$06,$07,$09,$0a,$0b
	.byte $0c,$10,$11,$12,$13,$14,$15,$16
	.byte $17,$18,$19,$1a,$1b,$1c,$1d,$1e
	.byte $3c,$3e,$3f,$43,$44,$46,$47,$49
	.byte $4a,$4c,$4c,$4c,$8c,$8d,$8e,$8f

clearbitmap:
	lda #>hgr
	sta ptr1 + 1
	ldy #<hgr
	sty ptr1
	lda #$80
@clear:
	sta (ptr1),y
	iny
	bne @clear
	inc ptr1 + 1
	ldx ptr1 + 1
	cpx #$40
	bcc @clear
	rts

clearview:
	ldx #$08
@nextline:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	ldy #$16
	lda #$00
@clear:
	sta (ptr1),y
	dey
	bne @clear
	inx
	cpx #$b8
	bcc @nextline
	rts

invertview:
	ldx #$08
@nextline:
	lda bmplineaddr_lo,x
	sta ptr1
	lda bmplineaddr_hi,x
	sta ptr1 + 1
	ldy #$16
@invert:
	lda (ptr1),y
	eor #$ff
	sta (ptr1),y
	dey
	bne @invert
	inx
	cpx #$b8
	bcc @nextline
	rts

mulax:
	sta ada
	lda #$00
	cpx #$00
	beq @zero
@add:
	clc
	adc ada
	dex
	bne @add
@zero:
	rts

; unused. To save even more memory, consider adjusting
; both 'update_britannia' and 'gettile_britannia'.
;	lda tile_ypos
;	jsr mul16
;	sta ptr2
;	lda tile_xpos
;	and #$0f
;	ora ptr2
;	sta ptr2
;	lda tile_ypos
;	and #$10
;	asl
;	ora tile_xpos
;	jsr div16
;	clc
;	adc #>world_map_nw
;	sta ptr2+1
;	rts

scroll_tiles:
	lda #$00
	jsr @save_and_scroll
	lda #$01
	jsr @save_and_scroll
	lda #$02
	jsr @save_and_scroll
	lda #$4c
	jmp @save_and_scroll

@save_and_scroll:
	tay
	bit ac083
	jsr s13b5
	bit ac08b
s13b5:
	lda fdf00,y
	pha
	lda fde00,y
	sta fdf00,y
	lda fdd00,y
	sta fde00,y
	lda fdc00,y
	sta fdd00,y
	lda fdb00,y
	sta fdc00,y
	lda fda00,y
	sta fdb00,y
	lda fd900,y
	sta fda00,y
	lda fd800,y
	sta fd900,y
	lda fd700,y
	sta fd800,y
	lda fd600,y
	sta fd700,y
	lda fd500,y
	sta fd600,y
	lda fd400,y
	sta fd500,y
	lda fd300,y
	sta fd400,y
	lda fd200,y
	sta fd300,y
	lda fd100,y
	sta fd200,y
	lda fd000,y
	sta fd100,y
	pla
	sta fd000,y
	rts

animate_fields:
	ldx #>fd000
	lda #<fd000
	sta ptr1
b141e:
	stx ptr1 + 1
	jsr fastrand
	and #$55
	bit ac08b
	ldy #$44
	sta (ptr1),y
	ora #$80
	ldy #$46
	sta (ptr1),y
	pha
	ldy #$4a
	and (ptr1),y
	ldy #$4b
	eor (ptr1),y
	ora #$80
	sta (ptr1),y
	pla
	bit ac083
	ldy #$45
	sta (ptr1),y
	and #$7f
	ldy #$47
	sta (ptr1),y
	jsr fastrand
	and #$2a
	ldy #$44
	sta (ptr1),y
	ora #$80
	ldy #$46
	sta (ptr1),y
	pha
	ldy #$4a
	and (ptr1),y
	ldy #$4b
	eor (ptr1),y
	ora #$80
	sta (ptr1),y
	pla
	bit ac08b
	ldy #$45
	sta (ptr1),y
	and #$7f
	ldy #$47
	sta (ptr1),y
	inx
	cpx #$e0
	bcc b141e
	rts

animate_flags:
	jsr fastrand
	bmi @castle
	bit ac08b
	ldx ad30a
	ldy ad40a
	sty ad30a
	stx ad40a
@castle:
	jsr fastrand
	bmi @shipwest
	bit ac083
	ldx ad10b
	ldy ad20b
	sty ad10b
	stx ad20b
@shipwest:
	jsr fastrand
	bmi @shipeast
	bit ac08b
	ldx ad212
	ldy ad312
	sty ad212
	stx ad312
	bit ac083
	ldx ad212
	ldy ad312
	sty ad212
	stx ad312
@shipeast:
	jsr fastrand
	bmi @lbcastle
	bit ac08b
	ldx ad210
	ldy ad310
	sty ad210
	stx ad310
	bit ac083
	ldx ad210
	ldy ad310
	sty ad210
	stx ad310
@lbcastle:
	jsr fastrand
	bmi @flagsdone
	bit ac08b
	ldx ad10e
	ldy ad20e
	sty ad10e
	stx ad20e
@flagsdone:
	rts

div32:
	lsr
div16:
	lsr
	lsr
	lsr
	lsr
	rts

mul32:
	asl
mul16:
	asl
	asl
	asl
	asl
	rts

scankey:
	lda hw_keyboard
	bpl @done
	cmp #$a0
	bne @notspace
	ldy #$00
	sty key_buf_len
@notspace:
	cmp #$ff
	bne @notdel
	lda #$88
@notdel:
	ldy key_buf_len
	cpy #$08
	bcs @done
	sta key_buf,y
	inc key_buf_len
	bit hw_strobe
@done:
	rts

getkey:
	lda key_buf_len
	beq @empty
	lda key_buf
	pha
	dec key_buf_len
	beq @gotkey
	ldy #$00
@movebuf:
	lda key_buf+1,y
	sta key_buf,y
	iny
	cpy key_buf_len
	bcc @movebuf
@gotkey:
	pla
	cmp #$00
@empty:
	rts

rand:
	txa
	pha
	clc
	ldx #$0e
	lda rndf
@add:
	adc rnd0,x
	sta rnd0,x
	dex
	bpl @add
	ldx #$0f
@inc:
	inc rnd0,x
	bne @done
	dex
	bpl @inc
@done:
	pla
	tax
	lda rnd0
	rts

rnd0:
	.byte $64
rnd1:
	.byte $76
rnd2:
	.byte $85
rnd3:
	.byte $54,$f6,$5c,$76,$1f,$e7,$12,$a7
	.byte $6b,$93,$c4,$6e
rndf:
	.byte $1b

fastrand:
	lda rnd3
	adc rnd2
	sta rnd2
	eor rnd1
	sta rnd1
	adc rnd0
	sta rnd0
	sta rnd3
	rts

console_scroll:
	ldx #$60
doscroll:
	ldy #$18
	lda bmplineaddr_lo,x
	sta @scrolldst
	lda bmplineaddr_hi,x
	sta @scrolldst+1
	lda bmplineaddr_lo+8,x
	sta @scrollsrc
	lda bmplineaddr_hi+8,x
	sta @scrollsrc+1
@scrollsrc=*+$01
@scroll:
	lda fffff,y
@scrolldst=*+$01
	sta fffff,y
	iny
	cpy #$28
	bcc @scroll
	inx
	cpx #$b8
	bcc doscroll
	jsr drawhoriz
	.byte $18,$17,$20,$20,$20,$20,$20,$20
	.byte $20,$20,$20,$20,$20,$20,$20,$20
	.byte $20,$20,$ff
	rts

drawchar:
	sta charptr
	lda console_ypos
	asl
	asl
	asl
	sta charptr+1
	lda #$e4
	sta @charsrc+1
	lda #$08
	sta abf
	ldy console_xpos
@drawchar:
	ldx charptr+1
	lda bmplineaddr_lo,x
	sta @chardst
	lda bmplineaddr_hi,x
	sta @chardst+1
	ldx charptr
@charsrc=*+$01
	lda fff00,x
@chardst=*+$01
	sta fffff,y
	clc
	lda @charsrc
	adc #$80
	sta @charsrc
	bcc :+
	inc @charsrc+1
:	inc charptr+1
	dec abf
	bne @drawchar
	ldy #$00
	rts

drawvert:
	lda #$80
	sta draw_hvflag
	jmp dodrawvh

drawhoriz:
	lda #$00
	sta draw_hvflag
dodrawvh:
	lda console_xpos
	sta draw_savex
	lda console_ypos
	sta draw_savey
	pla
	sta ptr2
	pla
	sta ptr2+1
	jsr @next
	ldy #$00
	lda (ptr2),y
	sta console_xpos
	jsr @next
	lda (ptr2),y
	sta console_ypos
@draw:
	jsr @next
	lda (ptr2),y
	bmi @drawdone
	jsr drawchar
	bit draw_hvflag
	bmi @vert
	inc console_xpos
	jmp @draw

@vert:
	inc console_ypos
	jmp @draw

@drawdone:
	lda ptr2+1
	pha
	lda ptr2
	pha
	lda draw_savex
	sta console_xpos
	lda draw_savey
	sta console_ypos
	rts

@next:
	inc ptr2
	bne @gotnext
	inc ptr2+1
@gotnext:
	rts

draw_hvflag:
	.byte 0
draw_savex:
	.byte 0
draw_savey:
	.byte 0

drawinterface:
	jsr clearbitmap
	jsr drawhoriz
	.byte $00,$00,$10,$05,$04,$05,$04,$05
	.byte $04,$05,$04,$05,$1e,$20,$20,$1d
	.byte $04,$05,$04,$05,$04,$05,$04,$05
	.byte $04,$01,$04,$05,$04,$05,$04,$05
	.byte $04,$05,$04,$05,$04,$05,$04,$05
	.byte $04,$13,$ff
	jsr drawvert
	.byte $00,$01,$0a,$0a,$0a,$0a,$0a,$0a
	.byte $0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a
	.byte $0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a
	.byte $14,$ff
	jsr drawhoriz
	.byte $01,$17,$03,$02,$03,$02,$03,$02
	.byte $03,$02,$03,$02,$03,$02,$03,$02
	.byte $03,$02,$03,$02,$03,$02,$03,$02
	.byte $ff
	jsr drawvert
	.byte $17,$01,$0d,$0d,$0d,$0d,$0d,$0d
	.byte $0d,$0d,$09,$0d,$09,$0d,$0d,$0d
	.byte $0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d
	.byte $0b,$ff
	jsr drawvert
	.byte $27,$01,$09,$09,$09,$09,$09,$09
	.byte $09,$09,$01,$09,$05,$ff
	jsr drawhoriz
	.byte $18,$09,$06,$07,$06,$07,$06,$07
	.byte $06,$07,$06,$07,$06,$07,$06,$07
	.byte $06,$ff
	jsr drawhoriz
	.byte $18,$0b,$06,$07,$06,$07,$06,$07
	.byte $06,$07,$06,$07,$06,$07,$06,$07
	.byte $06,$ff
	rts

moon_gfx:
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$04,$02,$01,$01,$02,$04,$00
	.byte $00,$04,$06,$07,$07,$06,$04,$00
	.byte $00,$0c,$0e,$1f,$1f,$0e,$0c,$00
	.byte $00,$0c,$1e,$3f,$3f,$1e,$0c,$00
	.byte $00,$0c,$1c,$3e,$3e,$1c,$0c,$00
	.byte $00,$08,$18,$38,$38,$18,$08,$00
	.byte $00,$08,$10,$20,$20,$10,$08,$00
update_moons:
	clc
	lda moon_counter
	adc #$40
	sta moon_counter
	bne @noupdate
	inc moon_ctr_trammel
	inc moon_ctr_trammel
	lda moon_ctr_trammel
	and #$e0
	lsr
	lsr
	tay
	lda moon_gfx,y
	sta a200b
	lda moon_gfx+1,y
	sta a240b
	lda moon_gfx+2,y
	sta a280b
	lda moon_gfx+3,y
	sta a2c0b
	lda moon_gfx+4,y
	sta a300b
	lda moon_gfx+5,y
	sta a340b
	lda moon_gfx+6,y
	sta a380b
	lda moon_gfx+7,y
	sta a3c0b
	clc
	lda moon_ctr_felucca
	adc #$06
	sta moon_ctr_felucca
	and #$e0
	lsr
	lsr
	tay
	lda moon_gfx,y
	sta a200c
	lda moon_gfx+1,y
	sta a240c
	lda moon_gfx+2,y
	sta a280c
	lda moon_gfx+3,y
	sta a2c0c
	lda moon_gfx+4,y
	sta a300c
	lda moon_gfx+5,y
	sta a340c
	lda moon_gfx+6,y
	sta a380c
	lda moon_gfx+7,y
	sta a3c0c
@noupdate:
	lda moon_ctr_trammel
	jsr div32
	sta moon_phase_trammel
	lda moon_ctr_felucca
	jsr div32
	sta moon_phase_felucca
	lda moon_ctr_trammel
	and #$1f
	beq @moongate_appears
	cmp #$1e
	beq @moongate_disappears
	rts

@moongate_appears:
	jsr moongate_update
	lda af1
	clc
	adc #$40
	sta moongate_tile
	rts

@moongate_disappears:
	jsr moongate_update
	lda af1
	eor #$03
	clc
	adc #$40
	sta moongate_tile
	rts

moongate_update:
	lda moon_ctr_trammel
	and #$e0
	jsr div32
	tax
	lda moongate_xtab,x
	sta moongate_xpos
	lda moongate_ytab,x
	sta moongate_ypos
	lda moon_counter
	and #$c0
	rol
	rol
	rol
	sta af1
	rts

moon_counter:
	.byte 0
moon_ctr_trammel:
	.byte 0
moon_ctr_felucca:
	.byte 0
moongate_xtab:
	.byte $e0,$60,$26,$32,$a6,$68,$17,$bb
moongate_ytab:
	.byte $85,$66,$e0,$25,$13,$c2,$7e,$a7

request_disk:
	sta reqdisk
@request:
	lda reqdisk
	cmp #$02
	beq @twodrives
	cmp #$04
	beq @twodrives
@onedrive:
	lda #$01
	sta currdrive
	lda reqdisk
	cmp currdisk_drive1
	beq @checkdisk
@askchange:
	jsr primm    ;"\nPLEASE PLACE THE\n"
	.byte $8d
	.byte "PLEASE PLACE THE", $8d
	.byte 0
	jsr askdisk
	jsr primm    ;" DISK\nINTO DRIVE "
	.byte " DISK", $8d
	.byte "INTO DRIVE ", 0
	lda currdrive
	jsr printdigit
	jsr primm    ;"\nAND PRESS [ESC]\n"
	.byte $8d
	.byte "AND PRESS [ESC]", $8d
	.byte 0
@wait:
	jsr waitkey
	cmp #$9b
	bne @wait
	beq @checkdisk
@twodrives:
	lda numdrives
	cmp #$02
	bcc @onedrive
	lda #$02
	sta currdrive
	lda reqdisk
	cmp currdisk_drive2
	beq @checkdisk
	bne @askchange
@checkdisk:
	lda currdrive
	clc
	adc #$b0
	sta @file_char_drive
	jsr primm_cout ;"^dBLOADDISK,D1\n"
	.byte $84, "BLOADDISK,D"
@file_char_drive:
	.byte "1", $8d
	.byte 0
	ldx currdrive
	lda diskid
	sta numdrives,x
	cmp reqdisk
	beq @done
	jmp @request

@done:
	rts

askdisk:
	ldx reqdisk
	dex
	dex
	bne @towne
	jsr primm    ;"BRITANNIA"
	.byte "BRITANNIA", 0
	rts

@towne:
	dex
	bne @underworld
	jsr primm    ;"TOWNE"
	.byte "TOWNE", 0
	rts

@underworld:
	jsr primm    ;"UNDERWORLD"
	.byte "UNDERWORLD", 0
	rts

playsfx:
	asl
	tay
	lda acd
	beq @done
	lda sfxtab+1,y
	pha
	lda sfxtab,y
	pha
@done:
	rts

sfxtab:
	.word sfx_walk-1
	.word sfx_error2-1
	.word sfx_error1-1
	.word sfx_ship_fire-1
	.word sfx_attack-1
	.word sfx_unknown-1
	.word sfx_player_hits-1
	.word sfx_monster_hits-1
	.word sfx_flee-1
	.word sfx_magic2-1
	.word sfx_magic1-1
	.word sfx_whirlpool-1
	.word sfx_storm-1

sfx_walk:
	ldy #$06
@repeat:
	jsr rand
	and #$3f
	ora #$20
	tax
@delay:
	dex
	bne @delay
	bit togglesnd
	dey
	bne @repeat
	rts

sfx_error2:
	ldy #$32
@delay:
	pha
	pla
	dex
	bne @delay
	bit togglesnd
	dey
	bne @delay
	rts

sfx_error1:
	ldy #$32
@delay:
	nop
	nop
	dex
	bne @delay
	bit togglesnd
	dey
	bne @delay
	jmp sfx_error2

sfx_ship_fire:
	ldx #$00
	stx ada
@delay:
	inx
	bne @delay
	bit togglesnd
	dec ada
	ldx ada
	bne @delay
	rts

sfx_attack:
	lda #$ff
	tax
	tay
@delay:
	dex
	bne @delay
	bit togglesnd
	dey
	tya
	tax
	bmi @delay
	rts

sfx_unknown:
	lda #$80
	tax
	tay
@delay:
	dex
	bne @delay
	bit togglesnd
	iny
	tya
	tax
	bmi @delay
	rts

sfx_player_hits:
	ldy #$ff
@repeat:
	jsr rand
	and #$7f
	tax
@delay:
	dex
	bne @delay
	bit togglesnd
	dey
	bne @repeat
	rts

sfx_monster_hits:
	ldy #$ff
@repeat:
	jsr rand
	ora #$80
	tax
@delay:
	dex
	bne @delay
	bit togglesnd
	dey
	bne @repeat
	rts

sfx_flee:
	ldx #$7f
	stx ada
@delay:
	dex
	bne @delay
	bit togglesnd
	dec ada
	ldx ada
	bne @delay
	rts

sfx_magic1:
	stx af0
b19fc:
	jsr rand
	ldx #$28
b1a01:
	tay
b1a02:
	dey
	bne b1a02
	bit togglesnd
	dex
	bne b1a01
	dec af0
	bne b19fc
	rts

sfx_whirlpool:
	lda #$40
@1:
	ldy #$20
@2:
	tax
@3:
	pha
	pla
	dex
	bne @3
	bit togglesnd
	dey
	bne @2
	clc
	adc #$01
	cmp #$c0
	bcc @1
	rts

sfx_magic2:
	stx sfx_m2_ctr2
	lda #$01
	sta sfx_m2_ctr1
@1:
	lda #$30
	sta af0
@2:
	ldx sfx_m2_ctr2
@3:
	dex
	bne @3
	bit togglesnd
	ldx sfx_m2_ctr1
@4:
	dex
	bne @4
	bit togglesnd
	dec af0
	bne @2
	dec sfx_m2_ctr2
	inc sfx_m2_ctr1
	lda sfx_m2_ctr1
	cmp #$1b
	bne @1
@5:
	lda #$30
	sta af0
@6:
	ldx sfx_m2_ctr2
@7:
	dex
	bne @7
	bit togglesnd
	ldx sfx_m2_ctr1
@8:
	dex
	bne @8
	bit togglesnd
	dec af0
	bne @6
	dec sfx_m2_ctr1
	inc sfx_m2_ctr2
	lda sfx_m2_ctr1
	cmp #$00
	bne @5
	rts

sfx_m2_ctr1:
	.byte 0
sfx_m2_ctr2:
	.byte 0

sfx_storm:
	lda #$c0
@1:
	ldy #$20
@2:
	tax
@3:
	pha
	pla
	dex
	bne @3
	bit togglesnd
	dey
	bne @2
	sec
	sbc #$01
	cmp #$40
	bcs @1
	rts

centerstring:
	pha
	tay
	lda #<strings
	sta ptr1
	lda #>strings
	sta ptr1 + 1
	ldx #$00
	stx ad8
@checkeos:
	lda (ptr1,x)
	bpl @endofstr
@next:
	jsr nextstrchar
	jmp @checkeos

@endofstr:
	dey
	beq @foundstr
	jmp @next

@foundstr:
	jsr nextstrchar
	ldx #$00
	lda (ptr1,x)
	bpl @lastchar
	inc ad8
	jmp @foundstr

@lastchar:
	inc ad8
	lda #$0f
	sec
	sbc ad8
	lsr
	clc
	adc console_xpos
	sta console_xpos
	pla
printstring:
	tay
	lda #<strings
	sta ptr1
	lda #>strings
	sta ptr1 + 1
	ldx #$00
@checkeos:
	lda (ptr1,x)
	bpl @endofstr
@next:
	jsr nextstrchar
	jmp @checkeos

@endofstr:
	dey
	beq @foundstr
	jmp @next

@foundstr:
	jsr nextstrchar
	ldx #$00
	lda (ptr1,x)
	bpl @lastchar
	jsr console_out
	jmp @foundstr

@lastchar:
	ora #$80
	jmp console_out

nextstrchar:
	inc ptr1
	bne @nomsb
	inc ptr1 + 1
@nomsb:
	rts

; String terminated by most significant bit in last character.
  .macro msbstring str
    .repeat (.strlen(str) - 1), I
	.byte .strat(str, I)
    .endrepeat
	.byte .strat(str, (.strlen(str) - 1)) ^ $80
  .endmacro


strings:
	.byte 0
	msbstring "PIRATE"
	msbstring "PIRATE"
	msbstring "NIXIE"
	msbstring "SQUID"
	msbstring "SERPENT"
	msbstring "SEAHORSE"
	msbstring "WHIRLPOOL"
	msbstring "TWISTER"
	msbstring "RAT"
	msbstring "BAT"
	msbstring "SPIDER"
	msbstring "GHOST"
	msbstring "SLIME"
	msbstring "TROLL"
	msbstring "GREMLIN"
	msbstring "MIMIC"
	msbstring "REAPER"
	msbstring "INSECTS"
	msbstring "GAZER"
	msbstring "PHANTOM"
	msbstring "ORC"
	msbstring "SKELETON"
	msbstring "ROGUE"
	msbstring "PYTHON"
	msbstring "ETTIN"
	msbstring "HEADLESS"
	msbstring "CYCLOPS"
	msbstring "WISP"
	msbstring "MAGE"
	msbstring "LICHE"
	msbstring "LAVA LIZARD"
	msbstring "ZORN"
	msbstring "DAEMON"
	msbstring "HYDRA"
	msbstring "DRAGON"
	msbstring "BALRON"
	msbstring "HANDS"
	msbstring "STAFF"
	msbstring "DAGGER"
	msbstring "SLING"
	msbstring "MACE"
	msbstring "AXE"
	msbstring "SWORD"
	msbstring "BOW"
	msbstring "CROSSBOW"
	msbstring "FLAMING OIL"
	msbstring "HALBERD"
	msbstring "MAGIC AXE"
	msbstring "MAGIC SWORD"
	msbstring "MAGIC BOW"
	msbstring "MAGIC WAND"
	msbstring "MYSTIC SWORD"
	msbstring "SKIN"
	msbstring "CLOTH"
	msbstring "LEATHER"
	msbstring "CHAIN MAIL"
	msbstring "PLATE MAIL"
	msbstring "MAGIC CHAIN"
	msbstring "MAGIC PLATE"
	msbstring "MYSTIC ROBE"
	msbstring "HND"
	msbstring "STF"
	msbstring "DAG"
	msbstring "SLN"
	msbstring "MAC"
	msbstring "AXE"
	msbstring "SWD"
	msbstring "BOW"
	msbstring "XBO"
	msbstring "OIL"
	msbstring "HAL"
	msbstring "+AX"
	msbstring "+SW"
	msbstring "+BO"
	msbstring "WND"
	msbstring "^SW"
	msbstring "MAGE"
	msbstring "BARD"
	msbstring "FIGHTER"
	msbstring "DRUID"
	msbstring "TINKER"
	msbstring "PALADIN"
	msbstring "RANGER"
	msbstring "SHEPHERD"
	msbstring "GUARD"
	msbstring "MERCHANT"
	msbstring "BARD"
	msbstring "JESTER"
	msbstring "BEGGAR"
	msbstring "CHILD"
	msbstring "BULL"
	msbstring "LORD BRITISH"
	msbstring "SULFUR ASH"
	msbstring "GINSENG"
	msbstring "GARLIC"
	msbstring "SPIDER SILK"
	msbstring "BLOOD MOSS"
	msbstring "BLACK PEARL"
	msbstring "NIGHTSHADE"
	msbstring "MANDRAKE"
	msbstring "AWAKEN"
	msbstring "BLINK"
	msbstring "CURE"
	msbstring "DISPEL"
	msbstring "ENERGY"
	msbstring "FIREBALL"
	msbstring "GATE"
	msbstring "HEAL"
	msbstring "ICEBALL"
	msbstring "JINX"
	msbstring "KILL"
	msbstring "LIGHT"
	msbstring "MAGIC MISL"
	msbstring "NEGATE"
	msbstring "OPEN"
	msbstring "PROTECTION"
	msbstring "QUICKNESS"
	msbstring "RESURRECT"
	msbstring "SLEEP"
	msbstring "TREMOR"
	msbstring "UNDEAD"
	msbstring "VIEW"
	msbstring "WINDS"
	msbstring "X-IT"
	msbstring "Y-UP"
	msbstring "Z-DOWN"
	msbstring "BRITANNIA"
	msbstring "THE LYCAEUM"
	msbstring "EMPATH ABBEY"
	msbstring "SERPENT'S HOLD"
	msbstring "MOONGLOW"
	msbstring "BRITAIN"
	msbstring "JHELOM"
	msbstring "YEW"
	msbstring "MINOC"
	msbstring "TRINSIC"
	msbstring "SKARA BRAE"
	msbstring "MAGINCIA"
	msbstring "PAWS"
	msbstring "BUCCANEER'S DEN"
	msbstring "VESPER"
	msbstring "COVE"
	msbstring "DECEIT"
	msbstring "DESPISE"
	msbstring "DESTARD"
	msbstring "WRONG"
	msbstring "COVETOUS"
	msbstring "SHAME"
	msbstring "HYTHLOTH"
	.byte "THE GREAT", $8D
	msbstring "STYGIAN ABYSS!"
	msbstring "HONESTY"
	msbstring "COMPASSION"
	msbstring "VALOR"
	msbstring "JUSTICE"
	msbstring "SACRIFICE"
	msbstring "HONOR"
	msbstring "SPIRITUALITY"
	msbstring "HUMILITY"

gettile_bounds:
	lda map_x
	jsr mul16
	eor #$ff
	sec
	adc temp_x
	sta dest_x
	cmp #xy_last_tile_cache
	bcs @out_of_bounds
	lda map_y
	jsr mul16
	eor #$ff
	sec
	adc temp_y
	sta dest_y
	cmp #xy_last_tile_cache
	bcs @out_of_bounds
	jmp gettile_britannia

@out_of_bounds:
	lda #$ff
	rts

gettile_britannia:
	lda dest_y
	jsr mul16
	sta ptr2
	lda dest_x
	and #$0f
	ora ptr2
	sta ptr2
	lda dest_y
	and #$10
	asl
	ora dest_x
	jsr div16
	clc
	adc #>world_map_nw
	sta ptr2+1
	ldy #<world_map_nw
	lda (ptr2),y
	rts

mul_11:
	.byte $00,$0b,$16,$21,$2c,$37,$42,$4d
	.byte $58,$63,$6e

gettile_opposite:
	sec
	lda temp_y
	sbc player_ypos
	clc
	adc #xy_center_screen
	tay
	lda mul_11,y
	sta ada
	sec
	lda temp_x
	sbc player_xpos
	clc
	adc #xy_center_screen
	clc
	adc ada
	sta ptr1
	lda #$02
	sta ptr1 + 1
	ldy #$00
	lda (ptr1),y
	rts

gettile_currmap:
	ldy dest_y
	lda mul_11,y
	clc
	adc dest_x
	tay
	lda currmap,y
	rts

gettile_tempmap:
	jsr gettile_currmap
	lda tempmap,y
	rts

get_player_tile:
	lda game_mode
	cmp #mode_world
	beq @world
	cmp #mode_towne
	beq @towne
	lda #$ff
	rts

@world:
	lda player_xpos
	sta dest_x
	lda player_ypos
	sta dest_y
	jmp gettile_britannia

@towne:
	lda player_xpos
	sta temp_x
	lda player_ypos
	sta temp_y
	jmp gettile_towne

gettile_towne:
	lda temp_y
	sta ptr2+1
	lda #$00
	lsr ptr2+1
	ror
	lsr ptr2+1
	ror
	lsr ptr2+1
	ror
	adc temp_x
	sta ptr2
	clc
	lda ptr2+1
	adc #>towne_map
	sta ptr2+1
	ldy #<towne_map
	lda (ptr2),y
	rts

gettile_dungeon:
	lda dungeon_level
	lsr
	lsr
	clc
	adc #>dng_map
	sta ptr1 + 1
	lda dungeon_level
	and #$03
	asl
	asl
	asl
	ora dest_y
	asl
	asl
	asl
	ora dest_x
	sta ptr1
	ldy #$00
	lda (ptr1),y
	rts
