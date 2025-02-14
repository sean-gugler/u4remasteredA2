; --- VALUES

music_off = $00

; In the order played by the demo
music_Overworld = 'O'
music_Towne = 'T'
music_Dungeon = 'D'
music_Castles = 'C'
music_British = 'B'

; Overworld
music_adventure = $01
music_combat = $02
music_peer = $03
music_u3_castle = $04  ;unused arrangement of a tune from Ultima III!
music_shrine = music_peer

; Towne
music_explore = $01
;music_combat = $02
;music_peer = $03
music_shop = $04

; Dungeon
music_dungeon = $01
;music_combat = $02
;music_peer = $03
;music_u3_castle = $04

; Castles
music_castle = $01
;music_combat = $02
;music_peer = $03
;music_shop = $04

; Lord British
music_hail_britannia = $01
music_test2 = $02
music_test3 = $03
music_test4 = $04

; Some situations (such as Search) turn off music,
; then return to whatever the "main" tune is,
; depending on which bank file has been loaded.
music_main = $01
