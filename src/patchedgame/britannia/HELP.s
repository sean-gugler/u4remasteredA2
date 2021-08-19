	.include "uscii.i"

	.include "jump_overlay.i"
	.include "jump_subs.i"
	.include "jump_system.i"
	.include "music.i"

	.include "PRTY.i"
	.include "ROST.i"
	

	.segment "OVERLAY"

.assert * = j_overlay_entry, error, "Wrong start address"
	pla          ;pop 2 frames left from entering by BRUN
	pla
	pla
	pla
	lda #music_hail_britannia
	jsr music_ctl
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
	ldx #virtue_last - 1
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
	ldx #virtue_last
@next_virtue:
	dex
	bmi check_items
	lda party_stats,x
	beq @next_virtue
	jmp help_avatarhood

check_items:
	lda bell_book_candle
	and #items_have_all
	cmp #items_have_all
	beq check_threepartkey
	jmp help_items

check_threepartkey:
	lda threepartkey
	cmp #key3_have_all
	beq ready
	jmp help_threepartkey

ready:
	jmp help_ready

print_he_says:
	jsr j_primm
	.byte "HE SAYS:", $8d
	.byte 0
	rts

help_early:
	jsr print_he_says
	jsr j_primm
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
	jsr j_primm
	.byte $8d
	.byte "TAKE GREAT CARE", $8d
	.byte "IN THESE THY", $8d
	.byte "FIRST TRAVELS", $8d
	.byte "IN BRITANNIA.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
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
	jsr j_primm
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
	jsr j_primm
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
	jsr j_primm
	.byte "LEARN YE THE", $8d
	.byte "PATHS OF VIRTUE,", $8d
	.byte "SEEK TO GAIN", $8d
	.byte "ENTRY UNTO THE", $8d
	.byte "EIGHT SHRINES!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
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
	jsr j_primm
	.byte $8d
	.byte "WITHIN THE", $8d
	.byte "SHRINES THOU", $8d
	.byte "SHALT LEARN OF", $8d
	.byte "THE DEEDS WHICH", $8d
	.byte "SHOW THY INNER", $8d
	.byte "VIRTUE OR VICE!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
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
	jsr j_primm
	.byte "VISIT THE SEER", $8d
	.byte "HAWKWIND OFTEN", $8d
	.byte "AND USE HIS", $8d
	.byte "WISDOM TO HELP", $8d
	.byte "THEE PROVE THY", $8d
	.byte "VIRTUE.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
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
	jsr j_primm
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
	jsr j_primm
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
	jsr j_primm
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
	jsr j_primm
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
	jsr j_primm
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
	jsr j_primm
	.byte "BEFORE THOU DOST", $8d
	.byte "ENTER THE ABYSS", $8d
	.byte "THOU SHALT NEED", $8d
	.byte "THE KEY OF THREE", $8d
	.byte "PARTS, AND THE", $8d
	.byte "WORD OF PASSAGE.", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
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
	jsr j_primm
	.byte "THOU DOST NOW", $8d
	.byte "SEEM READY TO", $8d
	.byte "MAKE THE FINAL", $8d
	.byte "JOURNEY INTO THE", $8d
	.byte "DARK ABYSS!", $8d
	.byte "GO ONLY WITH A", $8d
	.byte "PARTY OF EIGHT!", $8d
	.byte 0
	jsr j_waitkey
	jsr j_primm
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
	jsr j_primm
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
	lda #music_off
	jsr music_ctl
	jsr j_primm_cout
	.byte $84,"BRUN LORD,A$8800", $8d
	.byte 0

; junk
	sta $fa    ;temp_x
	lda $811f
	.byte $85  ;sta ...
