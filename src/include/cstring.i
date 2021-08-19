; CSTRING is deceptively named.
; It contains image data for END.s

cstring_addr = $4000

; Super-Packer compressed images are at these offsets.
spk_addr_00 = cstring_addr + $0f36
spk_addr_01 = cstring_addr + $0ffb
spk_addr_02 = cstring_addr + $10ab
spk_addr_03 = cstring_addr + $10c8
spk_addr_04 = cstring_addr + $10e5
spk_addr_05 = cstring_addr + $11b0
spk_addr_06 = cstring_addr + $126d
spk_addr_07 = cstring_addr + $12ac
spk_addr_08 = cstring_addr + $146e
spk_addr_09 = cstring_addr + $14eb
spk_addr_0a = cstring_addr + $156e
spk_addr_0b = cstring_addr + $15ec
spk_addr_0c = cstring_addr + $181b

; 8 virtue questions
spk_HONE = $00
spk_COMP = $01
spk_VALO = $02
spk_JUST = $03
spk_SACR = $04
spk_HONO = $05
spk_SPIR = $06
spk_HUMI = $07

; 3 principle questions
spk_TRUT = $08
spk_LOVE = $09
spk_COUR = $0a

; Special images
spk_WIN  = $0b
spk_LOCK = $0c
