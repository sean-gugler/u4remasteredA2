; --- ADDRESSES

zp_CSWL = $0036

screen_TEXT = $0400
screen_HGR1 = $2000
screen_HGR2 = $4000

hw_KEYBOARD = $c000
hw_STROBE   = $c010
hw_SPEAKER  = $c030

hw_GRAPHICS   = $c050
hw_FULLSCREEN = $c052
hw_PAGE1      = $c054
hw_HIRES      = $c057

hw_ROMIN    = $c081
hw_LCBANK2  = $c083
hw_LCBANK1  = $c08b

drive_motor_off = $c088
drive_motor_on  = $c089

rom_SHADOW = $f000
rom_signature = $fbb3
rom_ZIDBYTE = $fbc0
rom_HOME   = $fc58
rom_COUT   = $fded

vector_NMI   = $fffa
vector_RESET = $fffc
vector_IRQ   = $fffe


; --- VALUES

opcode_JSR = $20  ; JSR $hhll
opcode_BIT = $2c  ; BIT $hhll
opcode_JMP = $4c  ; JMP $hhll
opcode_RTS = $60  ; RTS
opcode_BCC = $90  ; BCC $rr

gfx_green_even = $2a
gfx_green_odd = $55
gfx_blue_odd = $aa
gfx_blue_even = $d5
