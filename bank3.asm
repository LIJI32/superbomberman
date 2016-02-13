.SEGMENT "BANK3"
.ORG $C30000

.A8
.I8

init_dboot:
		REP	#$20 ; ' '
.A16
		PHX
		LDA	#0

loc_C30006:
		JSL	dboot_command
		REP	#$10
.I16
		PLX
		SEP	#$20 ; ' '
.A8

loc_C3000F:
		LDA	#0
		PHA
		PLB
		REP	#$20 ; ' '
; e=0

locret_C30015:
		RTL
; End of function init_dboot

.A16
.I16

dboot_related_:
		REP	#$20 ; ' '
		PHX
		LDA	#1
		JSL	dboot_command
		REP	#$10
		PLX
		SEP	#$20 ; ' '
.A8
		LDA	#0
		PHA
		PLB
		REP	#$20 ; ' '
.A16
		RTL
; End of function dboot_related_

.A16
.I16

; Y = Music Index

play_music:
		REP	#$20 ; ' '
		PHX
		LDA	#$13
		JSL	dboot_command
		REP	#$10
		PLX
		SEP	#$20 ; ' '
.A8
		LDA	#0
		PHA

loc_C3003E:
		PLB
		REP	#$20 ; ' '
.A16
		RTL
; End of function play_music

.A8
.I16

play_sound:
		REP	#$20 ; ' '
.A16
		PHX
		LDA	#$14
		JSL	dboot_command
		REP	#$10
		PLX
		SEP	#$20 ; ' '
.A8
		LDA	#0
		PHA
		PLB

loc_C30055:
		REP	#$20 ; ' '
.A16
		RTL
; End of function play_sound

.A8
.I16

fade_out_music:
		REP	#$20 ; ' '
.A16
		PHX
		LDA	#$15
		JSL	dboot_command
		REP	#$10
		PLX

loc_C30065:
		SEP	#$20 ; ' '
.A8
		LDA	#0
		PHA
		PLB
		REP	#$20 ; ' '
.A16
		RTL
; End of function fade_out_music

.A16
.I16

dboot_16:
		REP	#$20 ; ' '
		PHX
		LDA	#$16

loc_C30074:
		JSL	dboot_command
		REP	#$10
		PLX
		SEP	#$20 ; ' '
.A8

loc_C3007D:
		LDA	#0
		PHA
		PLB
		REP	#$20 ; ' '
.A16
		RTL
; End of function dboot_16

.A16
.I16

dboot_17:
		REP	#$20 ; ' '
		PHX
		LDA	#$17
		JSL	dboot_command
		REP	#$10
		PLX
		SEP	#$20 ; ' '
.A8
		LDA	#0
		PHA
		PLB
		REP	#$20 ; ' '
.A16
		RTL
; End of function dboot_17

.A16
.I16

dboot_18:
		REP	#$20 ; ' '
		PHX
		LDA	#$18
		JSL	dboot_command
		REP	#$10
		PLX
		SEP	#$20 ; ' '
.A8
		LDA	#0
		PHA
		PLB
		REP	#$20 ; ' '
.A16
		RTL
; End of function dboot_18

.A16
.I16

dboot_19:
		REP	#$20 ; ' '
		PHX

loc_C300B3:
		LDA	#$19
		JSL	dboot_command
		REP	#$10
		PLX
		SEP	#$20 ; ' '
.A8
		LDA	#0
		PHA
		PLB

loc_C300C3:
		REP	#$20 ; ' '
.A16
		RTL
; End of function dboot_19

; ---------------------------------------------------------------------------
shield_palette_sequence:.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, $E, $E, 0, 0, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, $E, 0, 0, $E,	$E, 0, 0
		.BYTE $E, 0, $E, 0, $E,	0, $E, 0
		.BYTE $E, 0, $E, 0, $E,	0, $E, 0
		.BYTE $E, 0, $E, 0, $E,	0, $E, 0
		.BYTE $E, 0, $E, 0, $E,	0, $E, 0
		.BYTE $E, 0, $E, 0, $E,	0, $E, 0
		.BYTE $E, 0, $E, 0, $E,	0, $E, 0
		.BYTE $E, 0, $E, 0, $E,	0, $E, 0
		.BYTE $E, 0, $E, 0, $E,	0, $E, 0
bomb_animation:	.BYTE $80, $80,	$80, $80, $80, $80, $80, $80
		.BYTE $80, $80,	$80, $80, $80, $80, $80, $80
		.BYTE $82, $82,	$82, $82, $82, $82, $82, $82
		.BYTE $82, $82,	$82, $82, $82, $82, $82, $82
		.BYTE $84, $84,	$84, $84, $84, $84, $84, $84
		.BYTE $84, $84,	$84, $84, $84, $84, $84, $84
		.BYTE $82, $82,	$82, $82, $82, $82, $82, $82
		.BYTE $82, $82,	$82, $82, $82, $82, $82, $82
remocon_bomb_animation:.BYTE $6A, $6A, $6A, $6A, $6A, $6A, $6A,	$6A
		.BYTE $6A, $6A,	$6A, $6A, $6A, $6A, $6A, $6A
		.BYTE $6C, $6C,	$6C, $6C, $6C, $6C, $6C, $6C
		.BYTE $6C, $6C,	$6C, $6C, $6C, $6C, $6C, $6C
		.BYTE $6A, $6A,	$6A, $6A, $6A, $6A, $6A, $6A
		.BYTE $6A, $6A,	$6A, $6A, $6A, $6A, $6A, $6A
		.BYTE $6C, $6C,	$6C, $6C, $6C, $6C, $6C, $6C
		.BYTE $6C, $6C,	$6C, $6C, $6C, $6C, $6C, $6C
explosion_tiles:.WORD $1CC8, $1CE6, $1CC4, $1CE6, $1CC4, $1C88,	$1CC6, $1C86, $1C60
		.WORD $1CAE, $1CE4, $1CA4, $1CE4, $1CA4, $1C8A,	$1CA6, $1CE8, $1C62
		.WORD $1CAC, $1CCE, $1CE0, $1CCE, $1CE0, $1C8C,	$1CE2, $1CEE, $1C64
		.WORD $1CAA, $1CCC, $1CC0, $1CCC, $1CC0, $1C8E,	$1CC2, $1CEC, $1C66
		.WORD $1CA8, $1CCA, $1CA0, $1CCA, $1CA0, $1C6E,	$1CA2, $1CEA, $1C68
		.WORD $0C08, $0C08, $0C08, $0C08, $0C08, $0C08,	$0C08, $0C08, $0C08
explosion_animation:
		.WORD 2
		.ADDR explosion_tiles
		.WORD 3
		.ADDR explosion_tiles+$12
		.WORD 4
		.ADDR explosion_tiles+$24
		.WORD 4
		.ADDR explosion_tiles+$36
		.WORD 5
		.ADDR explosion_tiles+$48
		.WORD 4
		.ADDR explosion_tiles+$36
		.WORD 4
		.ADDR explosion_tiles+$24
		.WORD 3
		.ADDR explosion_tiles+$12
		.WORD 1
		.ADDR explosion_tiles
		.WORD 1
		.ADDR explosion_tiles
		.WORD 1
		.ADDR explosion_tiles+$5A
byte_C3047E:	.BYTE $F0, $20,	3, $24,	$24
byte_C30483:	.BYTE $F0, $20,	3, $26,	$24
byte_C30488:	.BYTE $F0, $20,	$E, $22, $24
byte_C3048D:	.BYTE $F0, $20,	$E, $24, $24
byte_C30492:	.BYTE $F0, $20,	$E, $26, $24
byte_C30497:	.BYTE $F0, $20,	$E, $22, $26
byte_C3049C:	.BYTE $F0, $20,	$E, $24, $26
byte_C304A1:	.BYTE $F0, $20,	$E, $26, $26
byte_C304A6:	.BYTE $F0, $20,	3, $24,	$26
byte_C304AB:	.BYTE $F0, $20,	3, $26,	$26
byte_C304B0:	.BYTE $F0, $20,	$E, $22, $34
byte_C304B5:	.BYTE $F0, $20,	$E, $24, $34
byte_C304BA:	.BYTE $F0, $20,	$E, $26, $34
off_C304BF:
		.ADDR byte_C30488, byte_C30488,	byte_C30488, byte_C30488, byte_C30488, byte_C30488, byte_C30488, byte_C30488
		.ADDR byte_C30488, byte_C30488,	byte_C30488, byte_C30488, byte_C30488, byte_C30488, byte_C30488, byte_C30488
		.ADDR byte_C3048D, byte_C3048D,	byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D
		.ADDR byte_C3048D, byte_C3048D,	byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D
		.ADDR byte_C30492, byte_C30492,	byte_C30492, byte_C30492, byte_C30492, byte_C30492, byte_C30492, byte_C30492
		.ADDR byte_C30492, byte_C30492,	byte_C30492, byte_C30492, byte_C30492, byte_C30492, byte_C30492, byte_C30492
		.ADDR byte_C3048D, byte_C3048D,	byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D
		.ADDR byte_C3048D, byte_C3048D,	byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D, byte_C3048D
		.ADDR byte_C3047E, byte_C3047E,	byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E
		.ADDR byte_C3047E, byte_C3047E,	byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E
		.ADDR byte_C30483, byte_C30483,	byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483
		.ADDR byte_C30483, byte_C30483,	byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483
		.ADDR byte_C3047E, byte_C3047E,	byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E
		.ADDR byte_C3047E, byte_C3047E,	byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E, byte_C3047E
		.ADDR byte_C30483, byte_C30483,	byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483
		.ADDR byte_C30483, byte_C30483,	byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483, byte_C30483
		.ADDR byte_C30497, byte_C30497,	byte_C30497, byte_C30497, byte_C30497, byte_C30497, byte_C30497, byte_C30497
		.ADDR byte_C30497, byte_C30497,	byte_C30497, byte_C30497, byte_C30497, byte_C30497, byte_C30497, byte_C30497
		.ADDR byte_C3049C, byte_C3049C,	byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C
		.ADDR byte_C3049C, byte_C3049C,	byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C
		.ADDR byte_C304A1, byte_C304A1,	byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1
		.ADDR byte_C304A1, byte_C304A1,	byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1, byte_C304A1
		.ADDR byte_C3049C, byte_C3049C,	byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C
		.ADDR byte_C3049C, byte_C3049C,	byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C, byte_C3049C
		.ADDR byte_C304A6, byte_C304A6,	byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6
		.ADDR byte_C304A6, byte_C304A6,	byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6
		.ADDR byte_C304AB, byte_C304AB,	byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB
		.ADDR byte_C304AB, byte_C304AB,	byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB
		.ADDR byte_C304A6, byte_C304A6,	byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6
		.ADDR byte_C304A6, byte_C304A6,	byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6, byte_C304A6
		.ADDR byte_C304AB, byte_C304AB,	byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB
		.ADDR byte_C304AB, byte_C304AB,	byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB, byte_C304AB
		.ADDR byte_C304B0, byte_C304B0,	byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0
		.ADDR byte_C304B0, byte_C304B0,	byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0, byte_C304B0
		.ADDR byte_C304B5, byte_C304B5,	byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5
		.ADDR byte_C304B5, byte_C304B5,	byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5
		.ADDR byte_C304BA, byte_C304BA,	byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA
		.ADDR byte_C304BA, byte_C304BA,	byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA, byte_C304BA
		.ADDR byte_C304B5, byte_C304B5,	byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5
		.ADDR byte_C304B5, byte_C304B5,	byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5, byte_C304B5
word_C3073F:	.WORD $F900, $6E
		.WORD $F900, $76
		.WORD $F900, $7E
		.WORD $F900, $87
		.WORD $F900, $6E
		.WORD $F900, $66
		.WORD $F900, $5E
		.WORD $F900, $56
byte_C3075F:	.BYTE $00, $FA,	$50, $00, $00, $00, $18, $00
		.BYTE $00, $FC,	$70, $00, $00, $03, $11, $00
		.BYTE $00, $FE,	$70, $00, $00, $00, $13, $00
		.BYTE $00, $FC,	$70, $00, $00, $FD, $11, $00
		.BYTE $00, $FC,	$60, $00, $00, $00, $0C, $00
		.BYTE $00, $FD,	$70, $00, $50, $01, $0C, $00
		.BYTE $00, $FE,	$70, $00, $00, $00, $0C, $00
		.BYTE $00, $FD,	$70, $00, $B0, $FE, $0C, $00
		.BYTE $00, $00,	$00, $00, $00, $00, $00, $00
		.BYTE $00, $FC,	$70, $00, $00, $03, $11, $00
		.BYTE $00, $FC,	$70, $00, $00, $FD, $11, $00
		.BYTE $00, $00,	$00, $00, $00, $00, $00, $00
		.BYTE $00, $FE,	$70, $00, $00, $00, $13, $00
		.BYTE $00, $00,	$00, $00, $00, $00, $00, $00
		.BYTE $00, $00,	$00, $00, $00, $00, $00, $00
byte_C307D7:	.BYTE $00, $00,	$00, $00, $00, $00, $00, $00
		.BYTE $00, $FA,	$50, $00, $00, $00, $18, $00
		.BYTE $00, $00,	$00, $00, $00, $00, $00, $00
		.BYTE $00, $FD,	$70, $00, $50, $01, $0C, $00
		.BYTE $00, $FD,	$70, $00, $B0, $FE, $0C, $00
		.BYTE $00, $00,	$00, $00, $00, $00, $00, $00
		.BYTE $00, $FE,	$70, $00, $00, $00, $0C, $00
		.BYTE $00, $00,	$00, $00, $00, $00, $00, $00
		.BYTE $00, $00,	$00, $00, $00, $00, $00, $00
		.BYTE $00, $00,	$00, $00, $00, $00, $00, $00
		.BYTE $00, $FC,	$60, $00, $00, $00, $0C, $00
		.BYTE $00, $08,	$40, $48, $80, $88, $C0, $C8
		.BYTE $00, $08,	$40, $48, $80, $88, $C0, $C8
		.BYTE $00, $08,	$40, $48, $80, $88, $C0, $C8
		.BYTE $00, $08,	$40, $48, $80, $88, $C0, $C8
		.BYTE $02, $00,	$00, $08, $00, $40, $00, $48
		.BYTE $00, $80,	$00, $88, $00, $C0, $00, $C8
		.BYTE $00, $00,	$01, $08, $01, $40, $01, $48
		.BYTE $01, $80,	$01, $88, $01, $C0, $01, $C8
		.BYTE $01
bonus_tiles:	.BYTE 0			; 0
		.BYTE 0			; 1
		.BYTE 0			; 2
		.BYTE $11		; 3
		.BYTE 2			; 4
		.BYTE $15		; 5
		.BYTE $E		; 6
		.BYTE $15		; 7
		.BYTE $42		; 8
		.BYTE $11		; 9
		.BYTE $C		; $A
		.BYTE $15		; $B
		.BYTE $4C		; $C
		.BYTE $11		; $D
		.BYTE 8			; $E
		.BYTE $11		; $F
		.BYTE $40		; $10
		.BYTE $15		; $11
		.BYTE $4E		; $12
		.BYTE $15		; $13
		.BYTE 6			; $14
		.BYTE $15		; $15
		.BYTE 4			; $16
		.BYTE $15		; $17
		.BYTE $44		; $18
		.BYTE $15		; $19
		.BYTE $48		; $1A
		.BYTE $15		; $1B
		.BYTE $46		; $1C
		.BYTE $11		; $1D
		.BYTE $A		; $1E
		.BYTE $15		; $1F
		.BYTE $4A		; $20
		.BYTE $11		; $21
		.BYTE $80		; $22
		.BYTE $15		; $23
		.BYTE $82		; $24
		.BYTE $15		; $25
		.BYTE $84		; $26
		.BYTE $15		; $27
		.BYTE $86		; $28
		.BYTE $15		; $29
		.BYTE $88		; $2A
		.BYTE $15		; $2B
		.BYTE $8A		; $2C
		.BYTE $15		; $2D
		.BYTE $8C		; $2E
		.BYTE $15		; $2F
		.BYTE $8E		; $30
		.BYTE $15		; $31
invisibility_poison_related:.BYTE 0, 1,	1, 1, 1, 0, 0, 0
		.BYTE 0, 1, 1, 1, 1, 0,	0, 0
		.BYTE 0, 1, 1, 1, 0, 0,	0, 1
		.BYTE 1, 1, 0, 0, 0, 1,	1, 0
		.BYTE 0, 1, 1, 0, 0, 1,	0, 1
word_C308CA:	.WORD $100, $140, $180,	$1C0, $200, $300, $400,	$400
storymode_spawn_spots_array:
		.ADDR storymode_normal_spawn_spot ;	...
		.ADDR storymode_boss_spawn_spot
		.ADDR storymode_arena_spawn_spot
		.ADDR 0
		.ADDR 0
		.ADDR 0
storymode_normal_spawn_spot:.WORD $28
		.WORD $18
		.WORD 0
		.WORD $FF
		.WORD $E8
		.WORD $18
		.WORD $202
		.WORD $1FF
storymode_boss_spawn_spot:.WORD	$68
		.WORD $B8
		.WORD 0
		.WORD $FF
		.WORD $A8
		.WORD $B8
		.WORD $202
		.WORD $1FF
storymode_arena_spawn_spot:.WORD $28
		.WORD $38
		.WORD 0
		.WORD $FF
		.WORD $E8
		.WORD $38
		.WORD $202
		.WORD $1FF
directions_for_spawn_spots:.WORD 4, 8, 4, 4	   ; 0
		.WORD 0, 0, 0
word_C30924:	.WORD 2, 1, 1, 2	; 0
byte_C3092C:	.BYTE $46, $52,	$68, $74
byte_C30930:	.BYTE $80, $20,	$A4, $2C, $A8, $28, $AA, $2C
byte_C30938:	.BYTE $60, $20,	$62, $2C, $64, $28, $66, $2C
byte_C30940:	.BYTE $68, $20,	$6A, $2C, $6C, $28, $6E, $2C
some_array_of_scores:.WORD 0, $100	     ; 0
		.WORD 0, $200		; 2
		.WORD 0, $400		; 4
		.WORD 0, $800		; 6
		.WORD 0, $1600		; 8
		.WORD 0, $3200		; $A
		.WORD 0, $6400		; $C
		.WORD 0, 0		; $E
		.WORD 0, 0		; $10
		.WORD 0, 0		; $12

gpu_registers_init_table:
		registers_init_table_entry SCREEN_DISPLAY_REGISTER, $8F
		registers_init_table_entry OAM_SIZE_AND_DATA_AREA_DESIGNATION, 3
		registers_init_table_entry ADDRESS_FOR_ACCESSING_OAM_LOW, 0
		registers_init_table_entry ADDRESS_FOR_ACCESSING_OAM_HIGH,	0
		registers_init_table_entry BG_MODE_AND_TILE_SIZE_SETTING, $31
		registers_init_table_entry MOSAIC_SIZE_AND_BG_ENABLE, 0
		registers_init_table_entry BG_1_ADDRESS_AND_SIZE, $50
		registers_init_table_entry BG_2_ADDRESS_AND_SIZE, $54
		registers_init_table_entry BG_3_ADDRESS_AND_SIZE, $5A
		registers_init_table_entry BG_4_ADDRESS_AND_SIZE, $58
		registers_init_table_entry BG_1_AND_2_TILE_DATA_DESIGNATION, 0
		registers_init_table_entry BG_3_AND_4_TILE_DATA_DESIGNATION, $44
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
		registers_init_table_entry VRAM_ADDRESS_INCREMENT_VALUE, $80
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
		registers_init_table_entry BG_AND_OBJECT_ENABLE_MAIN_SCREEN, $17
		registers_init_table_entry BG_AND_OBJECT_ENABLE_SUB_SCREEN, $17
		registers_init_table_entry WINDOW_MASK_DESIGNATION_FOR_MAIN_SCREEN, 0
		registers_init_table_entry WINDOW_MASK_DESIGNATION_FOR_SUB_SCREEN, 0
		registers_init_table_entry INITIAL_SETTINGS_FOR_COLOR_ADDITION, 0
		registers_init_table_entry ADD_SUBTRACT_SELECT_AND_ENABLE,	0
		registers_init_table_entry FIXED_COLOR_DATA, $E0
		registers_init_table_entry SCREEN_INITIAL_SETTINGS, 0
		; Terminator
		.BYTE $FF
interrupt_registers_init_table:
		registers_init_table_entry NMI_V_H_COUNT_AND_JOYPAD_ENABLE, 0
		registers_init_table_entry PROGRAMMABLE_I_O_PORT_OUTPUT, $FF
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
		.BYTE $FF
battle_menu_items:
		battle_menu_item $D0, $18,	3, player_type,
		battle_menu_item $D0, $38, 3, player_type,
		battle_menu_item $D0, $58, 3, player_type,
		battle_menu_item $D0, $78, 3, player_type,
		battle_menu_item $E0, $98, $A,	cpu_level,
		battle_menu_item $48, $118, 5,	match_count,
		battle_menu_item $C4, $138, $C, stage_numbers,
cpu_level:      .ADDR byte_C500A6, byte_C500AB, byte_C500B0, byte_C500B5, byte_C500BA, byte_C500BF, byte_C500C4, byte_C500C9
                .ADDR byte_C500CE, byte_C500D3
match_count:    .ADDR byte_C500A6, byte_C500AB, byte_C500B0, byte_C500B5, byte_C500BA
stage_numbers:  .ADDR byte_C500A6, byte_C500AB, byte_C500B0, byte_C500B5, byte_C500BA, byte_C500BF, byte_C500C4, byte_C500C9
                .ADDR byte_C500CE, byte_C500D3, byte_C500D8, byte_C500DD
player_type:    .ADDR byte_C500E2, byte_C500E7, byte_C500EC
battle_stages_labels:
		.ADDR normal_zone_label	; 0
		.ADDR western_zone_label	; 1
		.ADDR bomb_zone_label	; 2
		.ADDR jump_zone_label	; 3
		.ADDR belt_zone_label	; 4
		.ADDR tunnel_zone_label	; 5
		.ADDR duel_zone_label	; 6
		.ADDR flower_zone_label	; 7
		.ADDR light_zone_label	; 8
		.ADDR power_zone_label	; 9
		.ADDR warp_zone_label	; 10
		.ADDR speed_zone_label	; 11
explosion_related:.WORD	0, $FFC0, $40, 0
		.WORD 0, $40, $FFC0, 0
		.WORD 0, $FE00,	$200, 0
		.WORD 0, $200, $FE00, 0
explosion_related2:.WORD 0, $F7, 8, 0
		.WORD 0, 8, $F7, 0

ASSET tilemaps, gameover_tilemap_top
ASSET tilemaps, gameover_tilemap_bottom

word_C30B2A:	.WORD $4A0, $4A1, $4AE,	$484, $484, $4A6, $484,	$4AF, $482, $4A1, $4AF,	$4B0, $4B1, $4BE, $494,	$494; 0
		.WORD $4A6, $494, $4BF,	$492, $4B1, $4BF; $10
byte_C30B56:	.BYTE $06, $06,	$00, $00, $10, $00, $06, $F8, $00, $00
		.BYTE $00, $FD,	$00, $00, $10, $00, $FD, $F8, $00, $00
		.BYTE $00, $F5,	$00, $00, $11, $00, $F5, $F8, $00, $01
		.BYTE $00
byte_C30B75:	.BYTE 6, $F4, 0, 0, $12, 0, $F4, $F8, 0, 2
		.BYTE 0, 6, 0, 0, $10, 0, 6, $F8, 0, 0
		.BYTE 0, $FD, 0, 0, $10, 0, $FD, $F8, 0, 0
		.BYTE 0
byte_C30B94:	.BYTE 6, $F4, 0, 0, $14, 0, $F4, $F8, 0, 4
		.BYTE 0, 6, 0, 0, $10, 0, 6, $F8, 0, 0
		.BYTE 0, $FD, 0, 0, $10, 0, $FD, $F8, 0, 0
		.BYTE 0
byte_C30BB3:	.BYTE 6, $F4, 0, 0, $30, 0, $F4, $F8, 0, $20
		.BYTE 0, 6, 0, 0, $10, 0, 6, $F8, 0, 0
		.BYTE 0, $FD, 0, 0, $10, 0, $FD, $F8, 0, 0
		.BYTE 0
byte_C30BD2:	.BYTE 8, 8, 0, 0, $10, 0, 8, $F8, 0, 0
		.BYTE 0, 0, 0, 0, $10, 0, 0, $F8, 0, 0
		.BYTE 0, $F8, 0, 0, $16, 0, $F8, $F8, 0, 6
		.BYTE 0, $F1, 0, 0, $11, 0, $F1, $F8, 0, 1
		.BYTE 0
byte_C30BFB:	.BYTE 8, 8, 0, 0, $10, 0, 8, $F8, 0, 0
		.BYTE 0, 0, 0, 0, $10, 0, 0, $F8, 0, 0
		.BYTE 0, $F8, 0, 0, $12, 0, $F8, $F8, 0, 2
		.BYTE 0, $F0, 0, 0, $13, 0, $F0, $F8, 0, 3
		.BYTE 0
byte_C30C24:	.BYTE 8, 8, $F8, 0, 0, 0, 8, 0,	0, $10
		.BYTE 0, 0, 0, 0, $10, 0, 0, $F8, 0, 0
		.BYTE 0, $F8, 0, 0, $14, 0, $F8, $F8, 0, 4
		.BYTE 0, $F0, 0, 0, $16, 0, $F0, $F8, 0, 6
		.BYTE 0
		.BYTE 1
		.FARADDR byte_C30B56
		.BYTE $FF
		.BYTE 1
		.FARADDR byte_C30B75
		.BYTE $FF
		.BYTE 1
		.FARADDR byte_C30B94
		.BYTE $FF
		.BYTE 1
		.FARADDR byte_C30BB3
		.BYTE $FF
		.BYTE 1
		.FARADDR byte_C30BD2
		.BYTE $FF
		.BYTE 1
		.FARADDR byte_C30BFB
		.BYTE $FF
		.BYTE 1
		.FARADDR byte_C30C24
		.BYTE $FF
score_popup_related:.WORD $C4D,	$C52, $C57, $C5C, $C61,	$C66, $C6B, $C6B, $C6B,	$C6B
.A8
.I16

transfer_oam:
		SEP	#$20 ; ' '
		LDA	#0
		STA	ADDRESS_FOR_ACCESSING_OAM_LOW
		LDA	#0
		STA	DMA_6_PARAMS	; ab0cdeee a = Direction b = Type c = Inc/Dec d	= Auto/Fixed e = Word Size Select
		LDA	#0
		STA	DMA_6_A_ADDRESS_LOW_BYTE
		LDA	#0
		STA	DMA_6_A_ADDRESS_HIGH_BYTE
		LDA	#$7F ; ''
		STA	DMA_6_A_ADDRESS_BANK
		LDA	#4
		STA	DMA_6_B_ADDRESS
		LDA	#$20 ; ' '
		STA	DMA_6_BYTES_COUNT_LOW_BYTE
		LDA	#2
		STA	DMA_6_BYTES_COUNT_HIGH_BYTE
		LDA	#$40 ; '@'
		STA	REGULAR_DMA_CHANNEL_ENABLE ; abcdefgh a	= Channel 7...h	= Channel 0: 1 = Enable	0 = Disable
		RTL
; End of function transfer_oam

.A16
.I16

interrupt_register_init:
		SEP	#$30 ; '0'
.A8
.I8
		LDX	#0

loc_C30CB8:
		LDA	interrupt_registers_init_table,X
		CMP	#$FF
		BEQ	loc_C30CCC
		TAY
		INX
		LDA	interrupt_registers_init_table,X
		INX
		STA	$4200,Y
		BRA	loc_C30CB8
; ---------------------------------------------------------------------------

loc_C30CCC:
		REP	#$30 ; '0'
.A16
.I16
		RTL
; End of function interrupt_register_init

.A16
.I16

gpu_registers_init:
		SEP	#$30 ; '0'
.A8
.I8
		LDX	#0

loc_C30CD3:
		LDA	gpu_registers_init_table,X
		CMP	#$FF
		BEQ	loc_C30CE7
		TAY
		INX
		LDA	gpu_registers_init_table,X
		INX
		STA	$2100,Y
		BRA	loc_C30CD3
; ---------------------------------------------------------------------------

loc_C30CE7:
		REP	#$30 ; '0'
.A16
.I16
		RTL
; End of function gpu_registers_init

; ---------------------------------------------------------------------------
empty_tile_after_explosion_related:
    	.WORD 8, $A, $C
.IFNDEF J
; Moved from bank 5
sudden_death_related_data:
        .WORD $28, $18, 0, $FFF0, $E8, $18, $10
		.WORD 0, $E8, $B8, 0, $10, $38,	$B8, $FFF0, 0, $38
		.WORD $28, 0, $FFF0, $D8, $28, $10, 0, $D8, $A8, 0
		.WORD $10, $38,	$A8, $FFF0, 0

; Moved from bank 5
password_encryption_key:.WORD 5, 0, 4, 1, 2, 6,	3, 7
password_decryption_key:.WORD 1, 3, 4, 6, 2, 0,	5, 7

; These moves weren't enough to prevent the overflow. :(
.ENDIF
		.WORD 0
.INCLUDE "stages/world1.asm"

; Common to all worlds, but annoyingly it's directly after the world 1 level definitions.
standard_level_graphics:.FARADDR bomberman_graphic_0
		.FARADDR bomberman_graphic_1
		.FARADDR bomberman_graphic_2
		.FARADDR bomberman_graphic_3
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.FARADDR score_banner_and_bomb_graphic
		.FARADDR enemy_explosion_graphic
boss_level_graphics:.FARADDR bomberman_graphic_0;	...
		.FARADDR bomberman_graphic_1
		.FARADDR bomberman_graphic_2
		.FARADDR bomberman_graphic_3
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.WORD 0
		.BYTE 0
		.FARADDR score_banner_and_bomb_graphic
		.FARADDR explosion_graphic

.INCLUDE "stages/world2.asm"
.INCLUDE "stages/world3.asm"
.INCLUDE "stages/world4.asm"
.INCLUDE "stages/world5.asm"
.INCLUDE "stages/world6.asm"
.INCLUDE "stages/battle.asm"
.INCLUDE "special_screens.asm"

screens_table:
		.ADDR stage_1_1, stage_1_2, stage_1_3, stage_1_4, stage_1_5, stage_1_6,	stage_1_7, stage_1_8; 0
		.ADDR stage_2_1, stage_2_2, stage_2_3, stage_2_4, stage_2_5, stage_2_6,	stage_2_7, stage_2_8; 8
		.ADDR stage_3_1, stage_3_2, stage_3_3, stage_3_4, stage_3_5, stage_3_6,	stage_3_7, stage_3_8; $10
		.ADDR stage_4_1, stage_4_2, stage_4_3, stage_4_4, stage_4_5, stage_4_6,	stage_4_7, stage_4_8; $18
		.ADDR stage_5_1, stage_5_2, stage_5_3, stage_5_4, stage_5_5, stage_5_6,	stage_5_7, stage_5_8; $20
		.ADDR stage_6_1, stage_6_2, stage_6_3, stage_6_4, stage_6_5, stage_6_6,	stage_6_7, stage_6_8; $28
		.ADDR credits_screen, title_screen, battle_screen, introduction_screen,	light_zone_demo, warp_zone_demo, jump_zone_demo, continue_screen; $30
		.ADDR password_screen, map_screen, draw_screen,	victory_screen,	sound_test, normal_zone, western_zone, bomb_zone; $38
		.ADDR jump_zone, belt_zone, tunnel_zone, duel_zone, flower_zone, light_zone, power_zone, warp_zone; $40
		.ADDR speed_zone	; $48
word_C32F81:
        .WORD $3D
screen_music_table:.WORD $0002,	$0002, $0002, $0002, $0002, $0002, $0002, $000A; 0
		.WORD $0004, $0004, $0004, $0004, $0004, $0004,	$0004, $000A; 8
		.WORD $0006, $0006, $0006, $0006, $0006, $0006,	$0006, $0017; $10
		.WORD $000B, $000B, $000B, $000B, $000B, $000B,	$000B, $0018; $18
		.WORD $0014, $0014, $0014, $0014, $0014, $0014,	$0014, $0019; $20
		.WORD $0008, $0008, $0008, $0008, $0008, $0008,	$0008, $001A; $28
		.WORD $0001, $0000, $0012, $0001, $0016, $0016,	$0016, $000C; $30
		.WORD $000C, $0007, $0010, $0011, $0012, $0016,	$0016, $0016; $38
		.WORD $0016, $0016, $0016, $0016, $0016, $0016,	$0016, $0016; $40
		.WORD $0016		; $48
kuwagen_graphic_pointers:.FARADDR kuwagen_graphic_0
		.FARADDR kuwagen_graphic_1
senshiyan_graphics:.FARADDR senshiyan_graphic_0
		.FARADDR senshiyan_graphic_1
		.FARADDR senshiyan_graphic_2
propene_graphics:.FARADDR propen_graphic_0
		.FARADDR propen_graphic_1
banen_graphics:	.FARADDR banen_graphic_0
		.FARADDR banen_graphic_1
cuppen_graphics:.FARADDR cuppen_graphic_0
		.FARADDR cuppen_graphic_1
anzenda_graphics:.FARADDR anzenda_graphic_0
		.FARADDR anzenda_graphic_1
yoroisu_graphics:.FARADDR yoroisu_graphic_0
		.FARADDR yoroisu_graphic_1
		.FARADDR yoroisu_graphic_2
		.FARADDR yoroisu_graphic_3
		.FARADDR yoroisu_graphic_4
		.FARADDR yoroisu_graphic_5
chameleoman_graphics:.FARADDR chameloman_graphic
moving_platform_graphics:
		.FARADDR moving_platform_graphic
		.FARADDR mecha_bomberman_graphic_0
		.FARADDR mecha_bomberman_graphic_1
		.FARADDR mecha_bomberman_graphic_2
		.FARADDR mecha_bomberman_graphic_3
		.FARADDR carat_diamond_graphic_0
		.FARADDR carat_diamond_graphic_1
		.FARADDR carat_diamond_graphic_2
missle_graphics:
    	.FARADDR missle_graphic_0
		.FARADDR missle_graphic_1
metal_propene_graphics:.FARADDR metal_propene_graphic_0
		.FARADDR metal_propene_graphic_1
kouraru_graphics:.FARADDR kouraru_graphic
pakupa_graphics:.FARADDR pakupa_graphic_0
		.FARADDR pakupa_graphic_1
		.FARADDR pakupa_graphic_2
douken_graphics:.FARADDR douken_graphic
dengurin_graphics:.FARADDR	dengurin_graphic_0
		.FARADDR dengurin_graphic_1
		.FARADDR dengurin_graphic_2
robocom_graphics:.FARADDR robocom_graphic_0
		.FARADDR robocom_graphic_1
		.FARADDR robocom_graphic_2
moguchan_graphics:.FARADDR moguchan_graphic_0
		.FARADDR moguchan_graphic_1
		.FARADDR moguchan_graphic_2
bakuda_graphics:.FARADDR bakuda_graphic_0
		.FARADDR bakuda_graphic_1
kierun_graphics:.FARADDR kierun_graphic_0
		.FARADDR kierun_graphic_1
bigaron_graphics:.FARADDR bigaron_graphic_0
		.FARADDR bigaron_graphic_1
		.FARADDR bigaron_graphic_2
		.FARADDR bigaron_graphic_3
		.FARADDR bigaron_graphic_4
		.FARADDR bigaron_graphic_5
		.FARADDR bigaron_graphic_6
		.FARADDR bigaron_graphic_7
		.FARADDR bigaron_graphic_8
clown_mask_graphics:.FARADDR clown_mask_graphic_0
		.FARADDR clown_mask_graphic_1
		.FARADDR clown_mask_graphic_2
		.FARADDR clown_mask_graphic_3
		.FARADDR clown_mask_graphic_4
		.FARADDR clown_mask_graphic_5
		.FARADDR clown_mask_graphic_6
		.FARADDR clown_mask_graphic_7
mecha_onita_graphics:.FARADDR mecha_onita_graphic_0
		.FARADDR mecha_onita_graphic_1
		.FARADDR mecha_onita_graphic_2
spiderer_graphics:.FARADDR spiderer_graphic_0
		.FARADDR spiderer_graphic_1
		.FARADDR spiderer_graphic_2
		.FARADDR spiderer_graphic_3
		.FARADDR spiderer_graphic_4
keibin_graphics:.FARADDR keibin_graphic_0
		.FARADDR keibin_graphic_1
starnuts_graphics:.FARADDR starnuts_graphic_0
		.FARADDR starnuts_graphic_1
		.FARADDR starnuts_graphic_2
kinkaru_graphics:.FARADDR kinkaru_graphic_0
		.FARADDR kinkaru_graphic_1
metal_u_graphics:.FARADDR metal_u_graphic
denkyun_graphics:.FARADDR denkyun_graphic
DATA_END

; More graphics
ASSET2 graphics, sprites, bigaron_graphic_0
ASSET2 graphics, sprites, bigaron_graphic_1
ASSET2 graphics, sprites, bigaron_graphic_2
ASSET2 graphics, sprites, bigaron_graphic_3
ASSET2 graphics, sprites, bigaron_graphic_4
ASSET2 graphics, sprites, bigaron_graphic_5
ASSET2 graphics, sprites, bigaron_graphic_6
ASSET2 graphics, sprites, bigaron_graphic_7
ASSET2 graphics, sprites, bigaron_graphic_8
ASSET2 graphics, sprites, clown_mask_graphic_0
ASSET2 graphics, sprites, clown_mask_graphic_1
ASSET2 graphics, sprites, clown_mask_graphic_2
ASSET2 graphics, sprites, clown_mask_graphic_3
ASSET2 graphics, sprites, clown_mask_graphic_4
ASSET2 graphics, sprites, clown_mask_graphic_5
ASSET2 graphics, sprites, clown_mask_graphic_6
ASSET2 graphics, sprites, clown_mask_graphic_7
ASSET2 graphics, sprites, falling_bombermen_graphic_0
ASSET2 graphics, sprites, falling_bombermen_graphic_1
ASSET2 graphics, sprites, falling_bombermen_graphic_2
ASSET2 graphics, sprites, falling_bombermen_graphic_3
ASSET2 graphics, sprites, falling_bombermen_graphic_4
ASSET2 graphics, sprites, falling_bombermen_graphic_5
ASSET2 graphics, sprites, falling_bombermen_graphic_6
ASSET2 graphics, sprites, spiderer_graphic_0
ASSET2 graphics, sprites, spiderer_graphic_1
ASSET2 graphics, sprites, spiderer_graphic_2
ASSET2 graphics, sprites, spiderer_graphic_3
ASSET2 graphics, sprites, spiderer_graphic_4
ASSET2 graphics, sprites, bomberman_mini_graphic_0
ASSET2 graphics, sprites, bomberman_mini_graphic_1
ASSET2 graphics, sprites, bomberman_mini_graphic_2
ASSET2 graphics, sprites, bomberman_mini_graphic_3
ASSET2 graphics, sprites, bomberman_mini_graphic_4
ASSET2 graphics, sprites, bomberman_mini_warp_graphic
ASSET2 graphics, sprites, bakuda_graphic_0
ASSET2 graphics, sprites, bakuda_graphic_1
ASSET2 graphics, backgrounds, title_background_graphic
ASSET2 graphics, backgrounds, tunnel_zone_graphic
ASSET2 graphics, sprites, cuppen_graphic_0
ASSET2 graphics, sprites, cuppen_graphic_1
ASSET2 graphics, sprites, diamond_tower_graphic_0
ASSET2 graphics, sprites, diamond_tower_graphic_1
ASSET2 graphics, sprites, diamond_tower_graphic_2
ASSET2 graphics, sprites, diamond_tower_graphic_3
ASSET2 graphics, sprites, intro_1_graphic_0
ASSET2 graphics, sprites, intro_1_graphic_1
ASSET2 graphics, sprites, intro_1_graphic_2
ASSET2 graphics, sprites, intro_1_graphic_3
ASSET2 graphics, sprites, intro_1_graphic_4
ASSET2 graphics, sprites, intro_1_graphic_5
ASSET2 graphics, sprites, intro_2_graphic_0
ASSET2 graphics, sprites, intro_2_graphic_1
ASSET2 graphics, sprites, intro_2_graphic_2
ASSET2 graphics, sprites, intro_2_graphic_3
ASSET2 graphics, sprites, intro_2_graphic_4
ASSET2 graphics, sprites, intro_2_graphic_5
ASSET2 graphics, sprites, intro_3_graphic_0
ASSET2 graphics, sprites, intro_3_graphic_1
ASSET2 graphics, sprites, intro_3_graphic_2
ASSET2 graphics, sprites, intro_3_graphic_3
ASSET2 graphics, sprites, intro_3_graphic_4
ASSET2 graphics, sprites, intro_3_graphic_5
ASSET2 graphics, sprites, intro_4_graphic_0
ASSET2 graphics, sprites, intro_4_graphic_1
ASSET2 graphics, sprites, intro_4_graphic_2
ASSET2 graphics, sprites, intro_4_graphic_3
ASSET2 graphics, sprites, intro_4_graphic_4
ASSET2 graphics, sprites, intro_4_graphic_5
ASSET2 graphics, sprites, big_font_graphic_0
ASSET2 graphics, sprites, big_font_graphic_1
ASSET2 graphics, sprites, big_font_graphic_2
ASSET2 graphics, sprites, big_font_graphic_3
ASSET2 graphics, sprites, small_font_graphic_0
ASSET2 graphics, sprites, small_font_graphic_1
ASSET2 graphics, sprites, metal_propene_graphic_0
ASSET2 graphics, sprites, metal_propene_graphic_1
ASSET2 graphics, sprites, keibin_graphic_0
ASSET2 graphics, sprites, keibin_graphic_1
ASSET2 graphics, sprites, hot_air_baloon_graphic
ASSET2 graphics, sprites, airship_graphic_0
ASSET2 graphics, sprites, airship_graphic_1
ASSET2 graphics, sprites, airship_graphic_2
ASSET2 graphics, sprites, metal_u_graphic
.IF !FALLING_BOMBERMEN_DRAW
ASSET2 graphics, backgrounds, draw_screen_gradient_graphic
.ENDIF

DATA_END