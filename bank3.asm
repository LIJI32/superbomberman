segment "BANK3"

init_dboot:
    REP #0x20
    PHX
    LDA #0

.loc_C30006:
    JSL dboot_command
    REP #0x10
    PLX
    SEP #0x20

.loc_C3000F:
    LDA #0
    PHA
    PLB
    REP #0x20
    ; fallthrough

nullsub_C30015:
    RTL

dboot_related_:
    REP #0x20
    PHX
    LDA #1
    JSL dboot_command
    REP #0x10
    PLX
    SEP #0x20
    LDA #0
    PHA
    PLB
    REP #0x20
    RTL

; Y = Music Index

play_music:
    REP #0x20
    PHX
    LDA #0x13
    JSL dboot_command
    REP #0x10
    PLX
    SEP #0x20
    LDA #0
    PHA

.loc_C3003E:
    PLB
    REP #0x20
    RTL

play_sound:
    REP #0x20
    PHX
    LDA #0x14
    JSL dboot_command
    REP #0x10
    PLX
    SEP #0x20
    LDA #0
    PHA
    PLB

.loc_C30055:
    REP #0x20
    RTL

fade_out_music:
    REP #0x20
    PHX
    LDA #0x15
    JSL dboot_command
    REP #0x10
    PLX

.loc_C30065:
    SEP #0x20
    LDA #0
    PHA
    PLB
    REP #0x20
    RTL

dboot_16:
    REP #0x20
    PHX
    LDA #0x16

.loc_C30074:
    JSL dboot_command
    REP #0x10
    PLX
    SEP #0x20

.loc_C3007D:
    LDA #0
    PHA
    PLB
    REP #0x20
    RTL

dboot_17:
    REP #0x20
    PHX
    LDA #0x17
    JSL dboot_command
    REP #0x10
    PLX
    SEP #0x20
    LDA #0
    PHA
    PLB
    REP #0x20
    RTL

dboot_18:
    REP #0x20
    PHX
    LDA #0x18
    JSL dboot_command
    REP #0x10
    PLX
    SEP #0x20
    LDA #0
    PHA
    PLB
    REP #0x20
    RTL

dboot_19:
    REP #0x20
    PHX

.loc_C300B3:
    LDA #0x19
    JSL dboot_command
    REP #0x10
    PLX
    SEP #0x20
    LDA #0
    PHA
    PLB

.loc_C300C3:
    REP #0x20
    RTL

shield_palette_sequence:
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0xE, 0xE, 0, 0, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0xE, 0, 0, 0xE, 0xE, 0, 0
    db 0xE, 0, 0xE, 0, 0xE, 0, 0xE, 0
    db 0xE, 0, 0xE, 0, 0xE, 0, 0xE, 0
    db 0xE, 0, 0xE, 0, 0xE, 0, 0xE, 0
    db 0xE, 0, 0xE, 0, 0xE, 0, 0xE, 0
    db 0xE, 0, 0xE, 0, 0xE, 0, 0xE, 0
    db 0xE, 0, 0xE, 0, 0xE, 0, 0xE, 0
    db 0xE, 0, 0xE, 0, 0xE, 0, 0xE, 0
    db 0xE, 0, 0xE, 0, 0xE, 0, 0xE, 0
bomb_animation:
db 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
    db 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
    db 0x82, 0x82, 0x82, 0x82, 0x82, 0x82, 0x82, 0x82
    db 0x82, 0x82, 0x82, 0x82, 0x82, 0x82, 0x82, 0x82
    db 0x84, 0x84, 0x84, 0x84, 0x84, 0x84, 0x84, 0x84
    db 0x84, 0x84, 0x84, 0x84, 0x84, 0x84, 0x84, 0x84
    db 0x82, 0x82, 0x82, 0x82, 0x82, 0x82, 0x82, 0x82
    db 0x82, 0x82, 0x82, 0x82, 0x82, 0x82, 0x82, 0x82
remocon_bomb_animation:
    db 0x6A, 0x6A, 0x6A, 0x6A, 0x6A, 0x6A, 0x6A, 0x6A
    db 0x6A, 0x6A, 0x6A, 0x6A, 0x6A, 0x6A, 0x6A, 0x6A
    db 0x6C, 0x6C, 0x6C, 0x6C, 0x6C, 0x6C, 0x6C, 0x6C
    db 0x6C, 0x6C, 0x6C, 0x6C, 0x6C, 0x6C, 0x6C, 0x6C
    db 0x6A, 0x6A, 0x6A, 0x6A, 0x6A, 0x6A, 0x6A, 0x6A
    db 0x6A, 0x6A, 0x6A, 0x6A, 0x6A, 0x6A, 0x6A, 0x6A
    db 0x6C, 0x6C, 0x6C, 0x6C, 0x6C, 0x6C, 0x6C, 0x6C
    db 0x6C, 0x6C, 0x6C, 0x6C, 0x6C, 0x6C, 0x6C, 0x6C
explosion_tiles:
    dw 0x1CC8, 0x1CE6, 0x1CC4, 0x1CE6, 0x1CC4, 0x1C88, 0x1CC6, 0x1C86, 0x1C60
    dw 0x1CAE, 0x1CE4, 0x1CA4, 0x1CE4, 0x1CA4, 0x1C8A, 0x1CA6, 0x1CE8, 0x1C62
    dw 0x1CAC, 0x1CCE, 0x1CE0, 0x1CCE, 0x1CE0, 0x1C8C, 0x1CE2, 0x1CEE, 0x1C64
    dw 0x1CAA, 0x1CCC, 0x1CC0, 0x1CCC, 0x1CC0, 0x1C8E, 0x1CC2, 0x1CEC, 0x1C66
    dw 0x1CA8, 0x1CCA, 0x1CA0, 0x1CCA, 0x1CA0, 0x1C6E, 0x1CA2, 0x1CEA, 0x1C68
    dw 0x0C08, 0x0C08, 0x0C08, 0x0C08, 0x0C08, 0x0C08, 0x0C08, 0x0C08, 0x0C08
explosion_animation:
    dw 2
    da explosion_tiles
    dw 3
    da explosion_tiles+0x12
    dw 4
    da explosion_tiles+0x24
    dw 4
    da explosion_tiles+0x36
    dw 5
    da explosion_tiles+0x48
    dw 4
    da explosion_tiles+0x36
    dw 4
    da explosion_tiles+0x24
    dw 3
    da explosion_tiles+0x12
    dw 1
    da explosion_tiles
    dw 1
    da explosion_tiles
    dw 1
    da explosion_tiles+0x5A
byte_C3047E:
    db 0xF0, 0x20, 3, 0x24, 0x24
byte_C30483:
    db 0xF0, 0x20, 3, 0x26, 0x24
byte_C30488:
    db 0xF0, 0x20, 0xE, 0x22, 0x24
byte_C3048D:
    db 0xF0, 0x20, 0xE, 0x24, 0x24
byte_C30492:
    db 0xF0, 0x20, 0xE, 0x26, 0x24
byte_C30497:
    db 0xF0, 0x20, 0xE, 0x22, 0x26
byte_C3049C:
    db 0xF0, 0x20, 0xE, 0x24, 0x26
byte_C304A1:
    db 0xF0, 0x20, 0xE, 0x26, 0x26
byte_C304A6:
    db 0xF0, 0x20, 3, 0x24, 0x26
byte_C304AB:
    db 0xF0, 0x20, 3, 0x26, 0x26
byte_C304B0:
    db 0xF0, 0x20, 0xE, 0x22, 0x34
byte_C304B5:
    db 0xF0, 0x20, 0xE, 0x24, 0x34
byte_C304BA:
    db 0xF0, 0x20, 0xE, 0x26, 0x34
off_C304BF:
    da byte_C30488, byte_C30488, byte_C30488, byte_C30488, byte_C30488, byte_C30488, byte_C30488, byte_C30488
    da byte_C30488, byte_C30488, byte_C30488, byte_C30488, byte_C30488, byte_C30488, byte_C30488, byte_C30488
    da byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D
    da byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D
    da byte_C30492, byte_C30492, byte_C30492, byte_C30492, byte_C30492, byte_C30492, byte_C30492, byte_C30492
    da byte_C30492, byte_C30492, byte_C30492, byte_C30492, byte_C30492, byte_C30492, byte_C30492, byte_C30492
    da byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D
    da byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D
    da byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E
    da byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E
    da byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483
    da byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483
    da byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E
    da byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E
    da byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483
    da byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483
    da byte_C30497, byte_C30497, byte_C30497, byte_C30497, byte_C30497, byte_C30497, byte_C30497, byte_C30497
    da byte_C30497, byte_C30497, byte_C30497, byte_C30497, byte_C30497, byte_C30497, byte_C30497, byte_C30497
    da byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C
    da byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C
    da byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1
    da byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1
    da byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C
    da byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C
    da byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6
    da byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6
    da byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB
    da byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB
    da byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6
    da byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6
    da byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB
    da byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB
    da byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0
    da byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0
    da byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5
    da byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5
    da byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA
    da byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA
    da byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5
    da byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5
word_C3073F:
    dw 0xF900, 0x6E
    dw 0xF900, 0x76
    dw 0xF900, 0x7E
    dw 0xF900, 0x87
    dw 0xF900, 0x6E
    dw 0xF900, 0x66
    dw 0xF900, 0x5E
    dw 0xF900, 0x56
byte_C3075F:
    db 0x00, 0xFA, 0x50, 0x00, 0x00, 0x00, 0x18, 0x00
    db 0x00, 0xFC, 0x70, 0x00, 0x00, 0x03, 0x11, 0x00
    db 0x00, 0xFE, 0x70, 0x00, 0x00, 0x00, 0x13, 0x00
    db 0x00, 0xFC, 0x70, 0x00, 0x00, 0xFD, 0x11, 0x00
    db 0x00, 0xFC, 0x60, 0x00, 0x00, 0x00, 0x0C, 0x00
    db 0x00, 0xFD, 0x70, 0x00, 0x50, 0x01, 0x0C, 0x00
    db 0x00, 0xFE, 0x70, 0x00, 0x00, 0x00, 0x0C, 0x00
    db 0x00, 0xFD, 0x70, 0x00, 0xB0, 0xFE, 0x0C, 0x00
    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    db 0x00, 0xFC, 0x70, 0x00, 0x00, 0x03, 0x11, 0x00
    db 0x00, 0xFC, 0x70, 0x00, 0x00, 0xFD, 0x11, 0x00
    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    db 0x00, 0xFE, 0x70, 0x00, 0x00, 0x00, 0x13, 0x00
    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
byte_C307D7:
    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    db 0x00, 0xFA, 0x50, 0x00, 0x00, 0x00, 0x18, 0x00
    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    db 0x00, 0xFD, 0x70, 0x00, 0x50, 0x01, 0x0C, 0x00
    db 0x00, 0xFD, 0x70, 0x00, 0xB0, 0xFE, 0x0C, 0x00
    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    db 0x00, 0xFE, 0x70, 0x00, 0x00, 0x00, 0x0C, 0x00
    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    db 0x00, 0xFC, 0x60, 0x00, 0x00, 0x00, 0x0C, 0x00
    db 0x00, 0x08, 0x40, 0x48, 0x80, 0x88, 0xC0, 0xC8
    db 0x00, 0x08, 0x40, 0x48, 0x80, 0x88, 0xC0, 0xC8
    db 0x00, 0x08, 0x40, 0x48, 0x80, 0x88, 0xC0, 0xC8
    db 0x00, 0x08, 0x40, 0x48, 0x80, 0x88, 0xC0, 0xC8
    db 0x02, 0x00, 0x00, 0x08, 0x00, 0x40, 0x00, 0x48
    db 0x00, 0x80, 0x00, 0x88, 0x00, 0xC0, 0x00, 0xC8
    db 0x00, 0x00, 0x01, 0x08, 0x01, 0x40, 0x01, 0x48
    db 0x01, 0x80, 0x01, 0x88, 0x01, 0xC0, 0x01, 0xC8
    db 0x01
bonus_tiles:
    db 0       ; 0
    db 0       ; 1
    db 0       ; 2
    db 0x11    ; 3
    db 2       ; 4
    db 0x15    ; 5
    db 0xE     ; 6
    db 0x15    ; 7
    db 0x42    ; 8
    db 0x11    ; 9
    db 0xC     ; 0xA
    db 0x15    ; 0xB
    db 0x4C    ; 0xC
    db 0x11    ; 0xD
    db 8       ; 0xE
    db 0x11    ; 0xF
    db 0x40    ; 0x10
    db 0x15    ; 0x11
    db 0x4E    ; 0x12
    db 0x15    ; 0x13
    db 6       ; 0x14
    db 0x15    ; 0x15
    db 4       ; 0x16
    db 0x15    ; 0x17
    db 0x44    ; 0x18
    db 0x15    ; 0x19
    db 0x48    ; 0x1A
    db 0x15    ; 0x1B
    db 0x46    ; 0x1C
    db 0x11    ; 0x1D
    db 0xA     ; 0x1E
    db 0x15    ; 0x1F
    db 0x4A    ; 0x20
    db 0x11    ; 0x21
    db 0x80    ; 0x22
    db 0x15    ; 0x23
    db 0x82    ; 0x24
    db 0x15    ; 0x25
    db 0x84    ; 0x26
    db 0x15    ; 0x27
    db 0x86    ; 0x28
    db 0x15    ; 0x29
    db 0x88    ; 0x2A
    db 0x15    ; 0x2B
    db 0x8A    ; 0x2C
    db 0x15    ; 0x2D
    db 0x8C    ; 0x2E
    db 0x15    ; 0x2F
    db 0x8E    ; 0x30
    db 0x15    ; 0x31
invisibility_poison_related:
    db 0, 1, 1, 1, 1, 0, 0, 0
    db 0, 1, 1, 1, 1, 0, 0, 0
    db 0, 1, 1, 1, 0, 0, 0, 1
    db 1, 1, 0, 0, 0, 1, 1, 0
    db 0, 1, 1, 0, 0, 1, 0, 1
word_C308CA:
    dw 0x100, 0x140, 0x180, 0x1C0, 0x200, 0x300, 0x400, 0x400
storymode_spawn_spots_array:
    da storymode_normal_spawn_spot
    da storymode_boss_spawn_spot
    da storymode_arena_spawn_spot
    da 0
    da 0
    da 0
storymode_normal_spawn_spot:
    dw 0x28
    dw 0x18
    dw 0
    dw 0xFF
    dw 0xE8
    dw 0x18
    dw 0x202
    dw 0x1FF
storymode_boss_spawn_spot:
    dw 0x68
    dw 0xB8
    dw 0
    dw 0xFF
    dw 0xA8
    dw 0xB8
    dw 0x202
    dw 0x1FF
storymode_arena_spawn_spot:
    dw 0x28
    dw 0x38
    dw 0
    dw 0xFF
    dw 0xE8
    dw 0x38
    dw 0x202
    dw 0x1FF
directions_for_spawn_spots:
    dw 4, 8, 4, 4        ; 0
    dw 0, 0, 0
word_C30924:
    dw 2, 1, 1, 2
byte_C3092C:
    db 0x46, 0x52, 0x68, 0x74
byte_C30930:
    db 0x80, 0x20, 0xA4, 0x2C, 0xA8, 0x28, 0xAA, 0x2C
byte_C30938:
    db 0x60, 0x20, 0x62, 0x2C, 0x64, 0x28, 0x66, 0x2C
byte_C30940:
    db 0x68, 0x20, 0x6A, 0x2C, 0x6C, 0x28, 0x6E, 0x2C
some_array_of_scores:
    dw 0, 0x100     ; 0
    dw 0, 0x200     ; 2
    dw 0, 0x400     ; 4
    dw 0, 0x800     ; 6
    dw 0, 0x1600    ; 8
    dw 0, 0x3200    ; 0xA
    dw 0, 0x6400    ; 0xC
    dw 0, 0         ; 0xE
    dw 0, 0         ; 0x10
    dw 0, 0         ; 0x12

gpu_registers_init_table:
    registers_init_table_entry SCREEN_DISPLAY_REGISTER, 0x8F
    registers_init_table_entry OAM_SIZE_AND_DATA_AREA_DESIGNATION, 3
    registers_init_table_entry ADDRESS_FOR_ACCESSING_OAM_LOW, 0
    registers_init_table_entry ADDRESS_FOR_ACCESSING_OAM_HIGH, 0
    registers_init_table_entry BG_MODE_AND_TILE_SIZE_SETTING, 0x31
    registers_init_table_entry MOSAIC_SIZE_AND_BG_ENABLE, 0
    registers_init_table_entry BG_1_ADDRESS_AND_SIZE, 0x50
    registers_init_table_entry BG_2_ADDRESS_AND_SIZE, 0x54
    registers_init_table_entry BG_3_ADDRESS_AND_SIZE, 0x5A
    registers_init_table_entry BG_4_ADDRESS_AND_SIZE, 0x58
    registers_init_table_entry BG_1_AND_2_TILE_DATA_DESIGNATION, 0
    registers_init_table_entry BG_3_AND_4_TILE_DATA_DESIGNATION, 0x44
    registers_init_table_entry BG_1_H_SCROLL_OFFSET, 0
    registers_init_table_entry BG_1_H_SCROLL_OFFSET, 0
    registers_init_table_entry BG_1_V_SCROLL_OFFSET, 0
    registers_init_table_entry BG_1_V_SCROLL_OFFSET, 0
    registers_init_table_entry BG_2_H_SCROLL_OFFSET, 0
    registers_init_table_entry BG_2_H_SCROLL_OFFSET, 0
    registers_init_table_entry BG_2_V_SCROLL_OFFSET, 0
    registers_init_table_entry BG_2_V_SCROLL_OFFSET, 0
    registers_init_table_entry BG_3_H_SCROLL_OFFSET, 0
    registers_init_table_entry BG_3_H_SCROLL_OFFSET, 0
    registers_init_table_entry BG_3_V_SCROLL_OFFSET, 0
    registers_init_table_entry BG_3_V_SCROLL_OFFSET, 0
    registers_init_table_entry BG_4_H_SCROLL_OFFSET, 0
    registers_init_table_entry BG_4_H_SCROLL_OFFSET, 0
    registers_init_table_entry BG_4_V_SCROLL_OFFSET, 0
    registers_init_table_entry BG_4_V_SCROLL_OFFSET, 0
    registers_init_table_entry VRAM_ADDRESS_INCREMENT_VALUE, 0x80
    registers_init_table_entry ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE, 0
    registers_init_table_entry ADDRESS_FOR_VRAM_READ_WRITE_HIGH_BYTE, 0
    registers_init_table_entry INITIAL_SETTING_FOR_MODE_7, 0
    registers_init_table_entry MODE_7_MATRIX_PARAMETER_A, 0
    registers_init_table_entry MODE_7_MATRIX_PARAMETER_A, 0
    registers_init_table_entry MODE_7_MATRIX_PARAMETER_B, 0
    registers_init_table_entry MODE_7_MATRIX_PARAMETER_B, 0
    registers_init_table_entry MODE_7_MATRIX_PARAMETER_C, 0
    registers_init_table_entry MODE_7_MATRIX_PARAMETER_C, 0
    registers_init_table_entry MODE_7_MATRIX_PARAMETER_D, 0
    registers_init_table_entry MODE_7_MATRIX_PARAMETER_D, 0
    registers_init_table_entry MODE_7_CENTER_POSITION_X, 0
    registers_init_table_entry MODE_7_CENTER_POSITION_X, 0
    registers_init_table_entry MODE_7_CENTER_POSITION_Y, 0
    registers_init_table_entry MODE_7_CENTER_POSITION_Y, 0
    registers_init_table_entry ADDRESS_FOR_CG_RAM_WRITE, 0
    registers_init_table_entry BG_1_AND_2_WINDOW_MASK_SETTINGS, 0
    registers_init_table_entry BG_3_AND_4_WINDOW_MASK_SETTINGS, 0
    registers_init_table_entry OBJ_AND_COLOR_WINDOW_SETTINGS, 0
    registers_init_table_entry WINDOW_1_LEFT_POSITION_DESIGNATION, 0
    registers_init_table_entry WINDOW_1_RIGHT_POSITION_DESIGNATION, 0
    registers_init_table_entry WINDOW_2_LEFT_POSTION_DESIGNATION, 0
    registers_init_table_entry WINDOW_2_RIGHT_POSTION_DESIGNATION, 0
    registers_init_table_entry BG_1_2_3_4_WINDOW_LOGIC_SETTINGS, 0
    registers_init_table_entry COLOR_AND_OBJ_WINDOW_LOGIC_SETTINGS, 0;
    registers_init_table_entry BG_AND_OBJECT_ENABLE_MAIN_SCREEN, 0x17
    registers_init_table_entry BG_AND_OBJECT_ENABLE_SUB_SCREEN, 0x17
    registers_init_table_entry WINDOW_MASK_DESIGNATION_FOR_MAIN_SCREEN, 0
    registers_init_table_entry WINDOW_MASK_DESIGNATION_FOR_SUB_SCREEN, 0
    registers_init_table_entry INITIAL_SETTINGS_FOR_COLOR_ADDITION, 0
    registers_init_table_entry ADD_SUBTRACT_SELECT_AND_ENABLE, 0
    registers_init_table_entry FIXED_COLOR_DATA, 0xE0
    registers_init_table_entry SCREEN_INITIAL_SETTINGS, 0
    ; Terminator
    db 0xFF
interrupt_registers_init_table:
    registers_init_table_entry NMI_V_H_COUNT_AND_JOYPAD_ENABLE, 0
    registers_init_table_entry PROGRAMMABLE_I_O_PORT_OUTPUT, 0xFF
    registers_init_table_entry MULTIPLICAND_A, 0
    registers_init_table_entry MULTPLIER_B, 0
    registers_init_table_entry DIVIDEND_LOW_BYTE, 0
    registers_init_table_entry DIVIDEND_HIGH_BYTE, 0
    registers_init_table_entry DIVISOR_B, 0
    registers_init_table_entry H_COUNT_TIMER, 0
    registers_init_table_entry H_COUNT_TIMER_MSB, 0
    registers_init_table_entry V_COUNT_TIMER, 0
    registers_init_table_entry V_COUNT_TIMER_MSB, 0
    registers_init_table_entry REGULAR_DMA_CHANNEL_ENABLE, 0
    registers_init_table_entry H_DMA_CHANNEL_ENABLE, 0
    registers_init_table_entry CYCLE_SPEED_DESIGNATION, 0
    ; Terminator
    db 0xFF
battle_menu_items:
    battle_menu_item 0xD0, 0x18, 3, player_type
    battle_menu_item 0xD0, 0x38, 3, player_type
    battle_menu_item 0xD0, 0x58, 3, player_type
    battle_menu_item 0xD0, 0x78, 3, player_type
    battle_menu_item 0xE0, 0x98, 0xA, cpu_level
    battle_menu_item 0x48, 0x118, 5, match_count
    battle_menu_item 0xC4, 0x138, 0xC, stage_numbers
cpu_level:
    da byte_C500A6, byte_C500AB, byte_C500B0, byte_C500B5, byte_C500BA, byte_C500BF, byte_C500C4, byte_C500C9
    da byte_C500CE, byte_C500D3
match_count:
    da byte_C500A6, byte_C500AB, byte_C500B0, byte_C500B5, byte_C500BA
stage_numbers:
    da byte_C500A6, byte_C500AB, byte_C500B0, byte_C500B5, byte_C500BA, byte_C500BF, byte_C500C4, byte_C500C9
    da byte_C500CE, byte_C500D3, byte_C500D8, byte_C500DD
player_type:
    da byte_C500E2, byte_C500E7, byte_C500EC
battle_stages_labels:
    da normal_zone_label  ; 0
    da western_zone_label ; 1
    da bomb_zone_label    ; 2
    da jump_zone_label    ; 3
    da belt_zone_label    ; 4
    da tunnel_zone_label  ; 5
    da duel_zone_label    ; 6
    da flower_zone_label  ; 7
    da light_zone_label   ; 8
    da power_zone_label   ; 9
    da warp_zone_label    ; 10
    da speed_zone_label   ; 11
explosion_related:
    dw 0, 0xFFC0, 0x40, 0
    dw 0, 0x40, 0xFFC0, 0
    dw 0, 0xFE00, 0x200, 0
    dw 0, 0x200, 0xFE00, 0
explosion_related2:
    dw 0, 0xF7, 8, 0
    dw 0, 8, 0xF7, 0

asset tilemaps, gameover_tilemap_top
asset tilemaps, gameover_tilemap_bottom

word_C30B2A:
    dw 0x4A0, 0x4A1, 0x4AE, 0x484, 0x484, 0x4A6, 0x484, 0x4AF, 0x482, 0x4A1, 0x4AF, 0x4B0, 0x4B1, 0x4BE, 0x494, 0x494; 0
    dw 0x4A6, 0x494, 0x4BF, 0x492, 0x4B1, 0x4BF; 0x10
byte_C30B56:
    db 0x06, 0x06, 0x00, 0x00, 0x10, 0x00, 0x06, 0xF8, 0x00, 0x00
    db 0x00, 0xFD, 0x00, 0x00, 0x10, 0x00, 0xFD, 0xF8, 0x00, 0x00
    db 0x00, 0xF5, 0x00, 0x00, 0x11, 0x00, 0xF5, 0xF8, 0x00, 0x01
    db 0x00
byte_C30B75:
    db 6, 0xF4, 0, 0, 0x12, 0, 0xF4, 0xF8, 0, 2
    db 0, 6, 0, 0, 0x10, 0, 6, 0xF8, 0, 0
    db 0, 0xFD, 0, 0, 0x10, 0, 0xFD, 0xF8, 0, 0
    db 0
byte_C30B94:
    db 6, 0xF4, 0, 0, 0x14, 0, 0xF4, 0xF8, 0, 4
    db 0, 6, 0, 0, 0x10, 0, 6, 0xF8, 0, 0
    db 0, 0xFD, 0, 0, 0x10, 0, 0xFD, 0xF8, 0, 0
    db 0
byte_C30BB3:
    db 6, 0xF4, 0, 0, 0x30, 0, 0xF4, 0xF8, 0, 0x20
    db 0, 6, 0, 0, 0x10, 0, 6, 0xF8, 0, 0
    db 0, 0xFD, 0, 0, 0x10, 0, 0xFD, 0xF8, 0, 0
    db 0
byte_C30BD2:
    db 8, 8, 0, 0, 0x10, 0, 8, 0xF8, 0, 0
    db 0, 0, 0, 0, 0x10, 0, 0, 0xF8, 0, 0
    db 0, 0xF8, 0, 0, 0x16, 0, 0xF8, 0xF8, 0, 6
    db 0, 0xF1, 0, 0, 0x11, 0, 0xF1, 0xF8, 0, 1
    db 0
byte_C30BFB:
    db 8, 8, 0, 0, 0x10, 0, 8, 0xF8, 0, 0
    db 0, 0, 0, 0, 0x10, 0, 0, 0xF8, 0, 0
    db 0, 0xF8, 0, 0, 0x12, 0, 0xF8, 0xF8, 0, 2
    db 0, 0xF0, 0, 0, 0x13, 0, 0xF0, 0xF8, 0, 3
    db 0
byte_C30C24:
    db 8, 8, 0xF8, 0, 0, 0, 8, 0, 0, 0x10
    db 0, 0, 0, 0, 0x10, 0, 0, 0xF8, 0, 0
    db 0, 0xF8, 0, 0, 0x14, 0, 0xF8, 0xF8, 0, 4
    db 0, 0xF0, 0, 0, 0x16, 0, 0xF0, 0xF8, 0, 6
    db 0
    db 1
    df byte_C30B56
    db 0xFF
    db 1
    df byte_C30B75
    db 0xFF
    db 1
    df byte_C30B94
    db 0xFF
    db 1
    df byte_C30BB3
    db 0xFF
    db 1
    df byte_C30BD2
    db 0xFF
    db 1
    df byte_C30BFB
    db 0xFF
    db 1
    df byte_C30C24
    db 0xFF
score_popup_related:
    dw 0xC4D, 0xC52, 0xC57, 0xC5C, 0xC61, 0xC66, 0xC6B, 0xC6B, 0xC6B, 0xC6B
transfer_oam:
    SEP #0x20
    LDA #0
    STA ADDRESS_FOR_ACCESSING_OAM_LOW
    LDA #0
    STA DMA_6_PARAMS ; ab0cdeee a = Direction b = Type c = Inc/Dec d = Auto/Fixed e = Word Size Select
    LDA #0
    STA DMA_6_A_ADDRESS_LOW_BYTE
    LDA #0
    STA DMA_6_A_ADDRESS_HIGH_BYTE
    LDA #0x7F
    STA DMA_6_A_ADDRESS_BANK
    LDA #4
    STA DMA_6_B_ADDRESS
    LDA #0x20
    STA DMA_6_BYTES_COUNT_LOW_BYTE
    LDA #2
    STA DMA_6_BYTES_COUNT_HIGH_BYTE
    LDA #0x40
    STA REGULAR_DMA_CHANNEL_ENABLE ; abcdefgh a = Channel 7...h = Channel 0: 1 = Enable 0 = Disable
    RTL

interrupt_register_init:
    SEP #0x30
    LDX #0

.loc_C30CB8:
    LDA interrupt_registers_init_table,X
    CMP #0xFF
    BEQ .loc_C30CCC
    TAY
    INX
    LDA interrupt_registers_init_table,X
    INX
    STA 0x4200,Y
    BRA .loc_C30CB8

.loc_C30CCC:
    REP #0x30
    RTL

gpu_registers_init:
    SEP #0x30
    LDX #0

.loc_C30CD3:
    LDA gpu_registers_init_table,X
    CMP #0xFF
    BEQ .loc_C30CE7
    TAY
    INX
    LDA gpu_registers_init_table,X
    INX
    STA 0x2100,Y
    BRA .loc_C30CD3

.loc_C30CE7:
    REP #0x30
    RTL

empty_tile_after_explosion_related:
    dw 8, 0xA, 0xC
ifndef J
; Moved from bank 5
sudden_death_related_data:
    dw 0x28, 0x18, 0, 0xFFF0, 0xE8, 0x18, 0x10
    dw 0, 0xE8, 0xB8, 0, 0x10, 0x38, 0xB8, 0xFFF0, 0, 0x38
    dw 0x28, 0, 0xFFF0, 0xD8, 0x28, 0x10, 0, 0xD8, 0xA8, 0
    dw 0x10, 0x38, 0xA8, 0xFFF0, 0

; Moved from bank 5
password_encryption_key:
    dw 5, 0, 4, 1, 2, 6, 3, 7
password_decryption_key:
    dw 1, 3, 4, 6, 2, 0, 5, 7

; These moves weren't enough to prevent the overflow. :(
endif
    dw 0
include "stages/world1.asm"

; Common to all worlds, but annoyingly it's directly after the world 1 level definitions.
standard_level_graphics:
    df bomberman_graphic_0
    df bomberman_graphic_1
    df bomberman_graphic_2
    df bomberman_graphic_3
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    df score_banner_and_bomb_graphic
    df enemy_explosion_graphic
boss_level_graphics:
    df bomberman_graphic_0
    df bomberman_graphic_1
    df bomberman_graphic_2
    df bomberman_graphic_3
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    df score_banner_and_bomb_graphic
    df explosion_graphic

include "stages/world2.asm"
include "stages/world3.asm"
include "stages/world4.asm"
include "stages/world5.asm"
include "stages/world6.asm"
include "stages/battle.asm"
include "special_screens.asm"

screens_table:
    da stage_1_1, stage_1_2, stage_1_3, stage_1_4, stage_1_5, stage_1_6, stage_1_7, stage_1_8; 0
    da stage_2_1, stage_2_2, stage_2_3, stage_2_4, stage_2_5, stage_2_6, stage_2_7, stage_2_8; 8
    da stage_3_1, stage_3_2, stage_3_3, stage_3_4, stage_3_5, stage_3_6, stage_3_7, stage_3_8; 0x10
    da stage_4_1, stage_4_2, stage_4_3, stage_4_4, stage_4_5, stage_4_6, stage_4_7, stage_4_8; 0x18
    da stage_5_1, stage_5_2, stage_5_3, stage_5_4, stage_5_5, stage_5_6, stage_5_7, stage_5_8; 0x20
    da stage_6_1, stage_6_2, stage_6_3, stage_6_4, stage_6_5, stage_6_6, stage_6_7, stage_6_8; 0x28
    da credits_screen, title_screen, battle_screen, introduction_screen, light_zone_demo, warp_zone_demo, jump_zone_demo, continue_screen; 0x30
    da password_screen, map_screen, draw_screen, victory_screen, sound_test, normal_zone, western_zone, bomb_zone; 0x38
    da jump_zone, belt_zone, tunnel_zone, duel_zone, flower_zone, light_zone, power_zone, warp_zone; 0x40
    da speed_zone ; 0x48
word_C32F81:
    dw 0x3D
screen_music_table:
    dw 0x0002, 0x0002, 0x0002, 0x0002, 0x0002, 0x0002, 0x0002, 0x000A; 0
    dw 0x0004, 0x0004, 0x0004, 0x0004, 0x0004, 0x0004, 0x0004, 0x000A; 8
    dw 0x0006, 0x0006, 0x0006, 0x0006, 0x0006, 0x0006, 0x0006, 0x0017; 0x10
    dw 0x000B, 0x000B, 0x000B, 0x000B, 0x000B, 0x000B, 0x000B, 0x0018; 0x18
    dw 0x0014, 0x0014, 0x0014, 0x0014, 0x0014, 0x0014, 0x0014, 0x0019; 0x20
    dw 0x0008, 0x0008, 0x0008, 0x0008, 0x0008, 0x0008, 0x0008, 0x001A; 0x28
    dw 0x0001, 0x0000, 0x0012, 0x0001, 0x0016, 0x0016, 0x0016, 0x000C; 0x30
    dw 0x000C, 0x0007, 0x0010, 0x0011, 0x0012, 0x0016, 0x0016, 0x0016; 0x38
    dw 0x0016, 0x0016, 0x0016, 0x0016, 0x0016, 0x0016, 0x0016, 0x0016; 0x40
    dw 0x0016    ; 0x48
kuwagen_graphic_pointers:
    df kuwagen_graphic_0
    df kuwagen_graphic_1
senshiyan_graphics:
    df senshiyan_graphic_0
    df senshiyan_graphic_1
    df senshiyan_graphic_2
propene_graphics:
    df propen_graphic_0
    df propen_graphic_1
banen_graphics:
    df banen_graphic_0
    df banen_graphic_1
cuppen_graphics:
    df cuppen_graphic_0
    df cuppen_graphic_1
anzenda_graphics:
    df anzenda_graphic_0
    df anzenda_graphic_1
yoroisu_graphics:
    df yoroisu_graphic_0
    df yoroisu_graphic_1
    df yoroisu_graphic_2
    df yoroisu_graphic_3
    df yoroisu_graphic_4
    df yoroisu_graphic_5
chameleoman_graphics:
    df chameloman_graphic
moving_platform_graphics:
    df moving_platform_graphic
    df mecha_bomberman_graphic_0
    df mecha_bomberman_graphic_1
    df mecha_bomberman_graphic_2
    df mecha_bomberman_graphic_3
    df carat_diamond_graphic_0
    df carat_diamond_graphic_1
    df carat_diamond_graphic_2
missle_graphics:
    df missle_graphic_0
    df missle_graphic_1
metal_propene_graphics:
    df metal_propene_graphic_0
    df metal_propene_graphic_1
kouraru_graphics:
    df kouraru_graphic
pakupa_graphics:
    df pakupa_graphic_0
    df pakupa_graphic_1
    df pakupa_graphic_2
douken_graphics:
    df douken_graphic
dengurin_graphics:
    df dengurin_graphic_0
    df dengurin_graphic_1
    df dengurin_graphic_2
robocom_graphics:
    df robocom_graphic_0
    df robocom_graphic_1
    df robocom_graphic_2
moguchan_graphics:
    df moguchan_graphic_0
    df moguchan_graphic_1
    df moguchan_graphic_2
bakuda_graphics:
    df bakuda_graphic_0
    df bakuda_graphic_1
kierun_graphics:
    df kierun_graphic_0
    df kierun_graphic_1
bigaron_graphics:
    df bigaron_graphic_0
    df bigaron_graphic_1
    df bigaron_graphic_2
    df bigaron_graphic_3
    df bigaron_graphic_4
    df bigaron_graphic_5
    df bigaron_graphic_6
    df bigaron_graphic_7
    df bigaron_graphic_8
clown_mask_graphics:
    df clown_mask_graphic_0
    df clown_mask_graphic_1
    df clown_mask_graphic_2
    df clown_mask_graphic_3
    df clown_mask_graphic_4
    df clown_mask_graphic_5
    df clown_mask_graphic_6
    df clown_mask_graphic_7
mecha_onita_graphics:
    df mecha_onita_graphic_0
    df mecha_onita_graphic_1
    df mecha_onita_graphic_2
spiderer_graphics:
    df spiderer_graphic_0
    df spiderer_graphic_1
    df spiderer_graphic_2
    df spiderer_graphic_3
    df spiderer_graphic_4
keibin_graphics:
    df keibin_graphic_0
    df keibin_graphic_1
starnuts_graphics:
    df starnuts_graphic_0
    df starnuts_graphic_1
    df starnuts_graphic_2
kinkaru_graphics:
    df kinkaru_graphic_0
    df kinkaru_graphic_1
metal_u_graphics:
    df metal_u_graphic
denkyun_graphics:
    df denkyun_graphic
data_end

; More graphics
asset graphics/sprites, bigaron_graphic_0
asset graphics/sprites, bigaron_graphic_1
asset graphics/sprites, bigaron_graphic_2
asset graphics/sprites, bigaron_graphic_3
asset graphics/sprites, bigaron_graphic_4
asset graphics/sprites, bigaron_graphic_5
asset graphics/sprites, bigaron_graphic_6
asset graphics/sprites, bigaron_graphic_7
asset graphics/sprites, bigaron_graphic_8
asset graphics/sprites, clown_mask_graphic_0
asset graphics/sprites, clown_mask_graphic_1
asset graphics/sprites, clown_mask_graphic_2
asset graphics/sprites, clown_mask_graphic_3
asset graphics/sprites, clown_mask_graphic_4
asset graphics/sprites, clown_mask_graphic_5
asset graphics/sprites, clown_mask_graphic_6
asset graphics/sprites, clown_mask_graphic_7
asset graphics/sprites, falling_bombermen_graphic_0
asset graphics/sprites, falling_bombermen_graphic_1
asset graphics/sprites, falling_bombermen_graphic_2
asset graphics/sprites, falling_bombermen_graphic_3
asset graphics/sprites, falling_bombermen_graphic_4
asset graphics/sprites, falling_bombermen_graphic_5
asset graphics/sprites, falling_bombermen_graphic_6
asset graphics/sprites, spiderer_graphic_0
asset graphics/sprites, spiderer_graphic_1
asset graphics/sprites, spiderer_graphic_2
asset graphics/sprites, spiderer_graphic_3
asset graphics/sprites, spiderer_graphic_4
asset graphics/sprites, bomberman_mini_graphic_0
asset graphics/sprites, bomberman_mini_graphic_1
asset graphics/sprites, bomberman_mini_graphic_2
asset graphics/sprites, bomberman_mini_graphic_3
asset graphics/sprites, bomberman_mini_graphic_4
asset graphics/sprites, bomberman_mini_warp_graphic
asset graphics/sprites, bakuda_graphic_0
asset graphics/sprites, bakuda_graphic_1
asset graphics/backgrounds, title_background_graphic
asset graphics/backgrounds, tunnel_zone_graphic
asset graphics/sprites, cuppen_graphic_0
asset graphics/sprites, cuppen_graphic_1
asset graphics/sprites, diamond_tower_graphic_0
asset graphics/sprites, diamond_tower_graphic_1
asset graphics/sprites, diamond_tower_graphic_2
asset graphics/sprites, diamond_tower_graphic_3
asset graphics/sprites, intro_1_graphic_0
asset graphics/sprites, intro_1_graphic_1
asset graphics/sprites, intro_1_graphic_2
asset graphics/sprites, intro_1_graphic_3
asset graphics/sprites, intro_1_graphic_4
asset graphics/sprites, intro_1_graphic_5
asset graphics/sprites, intro_2_graphic_0
asset graphics/sprites, intro_2_graphic_1
asset graphics/sprites, intro_2_graphic_2
asset graphics/sprites, intro_2_graphic_3
asset graphics/sprites, intro_2_graphic_4
asset graphics/sprites, intro_2_graphic_5
asset graphics/sprites, intro_3_graphic_0
asset graphics/sprites, intro_3_graphic_1
asset graphics/sprites, intro_3_graphic_2
asset graphics/sprites, intro_3_graphic_3
asset graphics/sprites, intro_3_graphic_4
asset graphics/sprites, intro_3_graphic_5
asset graphics/sprites, intro_4_graphic_0
asset graphics/sprites, intro_4_graphic_1
asset graphics/sprites, intro_4_graphic_2
asset graphics/sprites, intro_4_graphic_3
asset graphics/sprites, intro_4_graphic_4
asset graphics/sprites, intro_4_graphic_5
asset graphics/sprites, big_font_graphic_0
asset graphics/sprites, big_font_graphic_1
asset graphics/sprites, big_font_graphic_2
asset graphics/sprites, big_font_graphic_3
asset graphics/sprites, small_font_graphic_0
asset graphics/sprites, small_font_graphic_1
asset graphics/sprites, metal_propene_graphic_0
asset graphics/sprites, metal_propene_graphic_1
asset graphics/sprites, keibin_graphic_0
asset graphics/sprites, keibin_graphic_1
asset graphics/sprites, hot_air_baloon_graphic
asset graphics/sprites, airship_graphic_0
asset graphics/sprites, airship_graphic_1
asset graphics/sprites, airship_graphic_2
asset graphics/sprites, metal_u_graphic
if !FALLING_BOMBERMEN_DRAW
asset graphics/backgrounds, draw_screen_gradient_graphic
endif

data_end
