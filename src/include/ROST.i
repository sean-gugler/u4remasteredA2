; Save game status file "ROST"
; spans two memory pages

;----------------------------
; Each player character occupies $20 bytes
; $ec00  slot 1
; $ec20  slot 2
; $ec40  slot 3
; $ec60  slot 4
; $ec80  slot 5
; $eca0  slot 6
; $ecc0  slot 7
; $ece0  slot 8

; --- ADDRESSES

player_stats = $ec00

player_max  = $07
player_last = $08

player_gender        = $10
player_class_index   = $11
player_status        = $12
player_strength      = $13
player_dexterity     = $14
player_intelligence  = $15
player_magic_points  = $16
player_class_bit     = $17
player_cur_hp_hi     = $18
player_cur_hp_lo     = $19
player_max_hp_hi     = $1a
player_max_hp_lo     = $1b
player_experience_hi = $1c
player_experience_lo = $1d
player_weapon        = $1e
player_armour        = $1f
player_stat_max      = $1f

; --- VALUES

stat_max = $50  ;STR, DEX, INT

status_Dead = 'D'
status_Good = 'G'
status_Poison = 'P'
status_Sleep = 'S'


;----------------------------
; All-party data occupies $5a bytes
; although $100 bytes are stored on disk

; --- ADDRESSES

party_stats = $ed00

virtue_honesty      = $00
virtue_compassion   = $01
virtue_valor        = $02
virtue_justice      = $03
virtue_sacrifice    = $04
virtue_honor        = $05
virtue_spirituality = $06
virtue_humility     = $07

virtue_last         = $08

reagent_max = $08
spells_max = $1a

party_items = party_stats + virtue_last

torches          = $ed08
gems             = $ed09
keys             = $ed0a
sextant          = $ed0b
stones           = $ed0c
runes            = $ed0d
bell_book_candle = $ed0e
threepartkey     = $ed0f
food_hi          = $ed10  ; Only 4 digits of food
food_lo          = $ed11  ; are displayed, although
food_frac        = $ed12  ; 6 digits are tracked.
gold_hi          = $ed13
gold_lo          = $ed14
horn             = $ed15
wheel            = $ed16
skull            = $ed17
armour           = $ed18
weapons          = $ed20
reagents         = $ed38
mixtures         = $ed40

party_stat_torches  = torches  - party_stats
party_stat_gems     = gems     - party_stats
party_stat_keys     = keys     - party_stats
party_stat_sextant  = sextant  - party_stats
party_stat_food_hi  = food_hi  - party_stats
party_stat_food_lo  = food_lo  - party_stats
party_stat_gold_hi  = gold_hi  - party_stats
party_stat_gold_lo  = gold_lo  - party_stats
party_stat_armour   = armour   - party_stats
party_stat_weapons  = weapons  - party_stats
party_stat_reagents = reagents - party_stats
party_stat_spells   = mixtures - party_stats

armour_none = $00
armour_last = $08

armour_mystic = armour + $07

weapon_none = $00
weapon_dagger = $02
weapon_flaming_oil = $09
weapon_halberd = $0a
weapon_magic_axe = $0b
weapon_magic_wand = $0e
weapon_last = $10

weapon_mystic = weapons + $0f   ; FIXME

reagent_nightshade = $06
reagent_mandrake = $07


; --- VALUES

.linecont +

item_have_candle = $01
item_have_book   = $02
item_have_bell   = $04
item_used_candle = $10
item_used_book   = $20
item_used_bell   = $40

items_have_all = \
    item_have_candle + \
    item_have_book   + \
    item_have_bell

items_opened_abyss = \
    items_have_all   + \
    item_used_candle + \
    item_used_book   + \
    item_used_bell

key3_have_courage = $01
key3_have_love    = $02
key3_have_truth   = $04

key3_have_all = \
    key3_have_courage + \
    key3_have_love    + \
    key3_have_truth

stone_blue   = %10000000
stone_yellow = %01000000
stone_red    = %00100000
stone_green  = %00010000
stone_orange = %00001000
stone_purple = %00000100
stone_white  = %00000010
stone_black  = %00000001

.linecont -
