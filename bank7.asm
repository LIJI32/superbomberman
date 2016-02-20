.SEGMENT "BANK7"
.ORG $C70000

.I8
; e=1
animation_frame_C70000:.BYTE 5
stru_C70001:	frame_oam_tile $11, $F8, $201,	$20
		frame_oam_tile 6, $F8,	$2001, $20
		frame_oam_tile $FC, $F8, 3, $20
		frame_oam_tile $F4, $F8, $2200, $20
		frame_oam_tile $EC, $F8, 3, $20
animation_frame_C7001A:.BYTE 6
		frame_oam_tile $11, $F8, $601,	$20
		frame_oam_tile 7, $F8,	$2401, $20
		frame_oam_tile $FF, $F8, $2200, $20
		frame_oam_tile $F7, $F8, 1, $20
		frame_oam_tile $ED, $F8, $2401, $20
		frame_oam_tile $E3, $F8, $201,	$20
animation_frame_C70039:.BYTE 3
		frame_oam_tile 6, $F8,	2, $20
		frame_oam_tile $FC, $F8, $200,	$20
		frame_oam_tile $F1, $F8, $2201, $20
animation_frame_C70049:.BYTE 7
stru_C7004A:	frame_oam_tile $18, 0,	$3203, 0
		frame_oam_tile $18, $F8, $2203, 0
		frame_oam_tile $B, $F8, $201, $20
		frame_oam_tile 0, $F8,	$601, $20
		frame_oam_tile $F6, $F8, $200,	$20
		frame_oam_tile $EC, $F8, 3, $20
		frame_oam_tile $E2, $F8, $602,	$20
animation_frame_C7006D:.BYTE 7
		frame_oam_tile $18, 0,	$3303, 0
		frame_oam_tile $18, $F8, $2303, 0
		frame_oam_tile $B, $F8, $201, $20
		frame_oam_tile 0, $F8,	$601, $20
		frame_oam_tile $F6, $F8, $200,	$20
		frame_oam_tile $EC, $F8, 3, $20
		frame_oam_tile $E2, $F8, $602,	$20
animation_frame_C70091:.BYTE 7
		frame_oam_tile $18, 0,	$3403, 0
		frame_oam_tile $18, $F8, $2403, 0
		frame_oam_tile $B, $F8, $201, $20
		frame_oam_tile 0, $F8,	$601, $20
		frame_oam_tile $F6, $F8, $200,	$20
		frame_oam_tile $EC, $F8, 3, $20
		frame_oam_tile $E2, $F8, $602,	$20
animation_frame_C700B5:.BYTE 7
		frame_oam_tile $18, 0,	$3503, 0
		frame_oam_tile $18, $F8, $2503, 0
		frame_oam_tile $B, $F8, $201, $20
		frame_oam_tile 0, $F8,	$601, $20
		frame_oam_tile $F6, $F8, $200,	$20
		frame_oam_tile $EC, $F8, 3, $20
		frame_oam_tile $E2, $F8, $602,	$20
animation_frame_C700D9:.BYTE 7
stru_C700DA:	frame_oam_tile $18, 0,	$3603, 0
		frame_oam_tile $18, $F8, $2603, 0
		frame_oam_tile $B, $F8, $201, $20
		frame_oam_tile 0, $F8,	$601, $20
		frame_oam_tile $F6, $F8, $200,	$20
		frame_oam_tile $EC, $F8, 3, $20
		frame_oam_tile $E2, $F8, $602,	$20
animation_frame_C700FD:.BYTE 7
		frame_oam_tile $18, 0,	$3703, 0
		frame_oam_tile $18, $F8, $2703, 0
		frame_oam_tile $B, $F8, $201, $20
		frame_oam_tile 0, $F8,	$601, $20
		frame_oam_tile $F6, $F8, $200,	$20
		frame_oam_tile $EC, $F8, 3, $20
		frame_oam_tile $E2, $F8, $602,	$20
animation_frame_C70121:.BYTE 9
		frame_oam_tile $27, $F8, $201,	$20
		frame_oam_tile $1C, $F8, $601,	$20
		frame_oam_tile $12, $F8, $200,	$20
		frame_oam_tile 8, $F8,	3, $20
		frame_oam_tile $FE, $F8, $602,	$20
		frame_oam_tile $EE, $F8, $602,	$20
		frame_oam_tile $E4, $F8, $602,	$20
		frame_oam_tile $DA, $F8, $2601, $20
		frame_oam_tile $D0, $F8, $400,	$20
animation_frame_C7014F:.BYTE 6
		frame_oam_tile $16, $F8, 3, $20
		frame_oam_tile $C, $F8, $600, $20
		frame_oam_tile 2, $F8,	$201, $20
		frame_oam_tile $F7, $F8, $2001, $20
		frame_oam_tile $ED, $F8, $201,	$20
		frame_oam_tile $E3, $F8, $602,	$20
animation_frame_C7016E:.BYTE 6
		frame_oam_tile $16, $F8, $201,	$20
		frame_oam_tile $B, $F8, $2001,	$20
		frame_oam_tile 1, $F8,	3, $20
		frame_oam_tile $F7, $F8, 3, $20
		frame_oam_tile $ED, $F8, $200,	$20
		frame_oam_tile $E3, $F8, $400,	$20
animation_frame_C7018D:.BYTE 9
		frame_oam_tile $27, $F8, 3, $20
		frame_oam_tile $1D, $F8, $402,	$20
		frame_oam_tile $13, $F8, $200,	$20
		frame_oam_tile 9, $F8,	3, $20
		frame_oam_tile $FF, $F8, $602,	$20
		frame_oam_tile $F1, $F8, $201,	$20
		frame_oam_tile $E6, $F8, $2201, $20
		frame_oam_tile $DC, $F8, $200,	$20
		frame_oam_tile $D1, $F8, $601,	$20
animation_frame_C701BB:.BYTE $A
		frame_oam_tile $2C, $F8, $402,	$20
		frame_oam_tile $22, $F8, $200,	$20
		frame_oam_tile $18, $F8, $201,	$20
		frame_oam_tile $D, $F8, $2001,	$20
		frame_oam_tile 3, $F8,	$600, $20
		frame_oam_tile $F6, $F8, $201,	$20
		frame_oam_tile $EB, $F8, $601,	$20
		frame_oam_tile $E1, $F8, $200,	$20
		frame_oam_tile $D7, $F8, 3, $20
		frame_oam_tile $CD, $F8, $602,	$20
animation_frame_C701EE:.BYTE 8
stru_C701EF:	frame_oam_tile $1D, $F8, $201,	$20
		frame_oam_tile $13, $F8, $203,	$20
		frame_oam_tile 9, $F8,	$2401, $20
		frame_oam_tile 0, $F8,	$2200, $20
		frame_oam_tile $F8, $F8, 3, $20
		frame_oam_tile $EE, $F8, $2401, $20
		frame_oam_tile $E4, $F8, $2601, $20
		frame_oam_tile $DA, $F8, $600,	$20
animation_frame_C70217:.BYTE 8
		frame_oam_tile $21, $F8, $402,	$20
		frame_oam_tile $17, $F8, $201,	$20
		frame_oam_tile $D, $F8, $403, $20
		frame_oam_tile 3, $F8,	$2601, $20
		frame_oam_tile $F7, $F8, $201,	$20
		frame_oam_tile $EC, $F8, $2201, $20
		frame_oam_tile $E2, $F8, $200,	$20
		frame_oam_tile $D7, $F8, $601,	$20
byte_C70240:	.BYTE 1
		animation_frame animation_frame_C70000, $FF
byte_C70245:	.BYTE 1
		animation_frame animation_frame_C7001A, $FF
byte_C7024A:	.BYTE 1
		animation_frame animation_frame_C70039, $FF
byte_C7024F:	.BYTE 1
		animation_frame animation_frame_C70049, $FF
byte_C70254:	.BYTE 1
		animation_frame animation_frame_C7006D, $FF
byte_C70259:	.BYTE 1
		animation_frame animation_frame_C70091, $FF
byte_C7025E:	.BYTE 1
		animation_frame animation_frame_C700B5, $FF
byte_C70263:	.BYTE 1
		animation_frame animation_frame_C700D9, $FF
byte_C70268:	.BYTE 1
		animation_frame animation_frame_C700FD, $FF
byte_C7026D:	.BYTE 1
		animation_frame animation_frame_C70121, $FF
byte_C70272:	.BYTE 1
		animation_frame animation_frame_C7014F, $FF
byte_C70277:	.BYTE 1
		animation_frame animation_frame_C7016E, $FF
byte_C7027C:	.BYTE 1
		animation_frame animation_frame_C7018D, $FF
byte_C70281:	.BYTE 1
		animation_frame animation_frame_C701BB, $FF
byte_C70286:	.BYTE 1
		animation_frame animation_frame_C701EE, $FF
byte_C7028B:	.BYTE 1
		animation_frame animation_frame_C70217, $FF
animation_frame_C70290:.BYTE $F
		frame_oam_tile $3E, $F8, $201,	$20
		frame_oam_tile $34, $F8, $2001, $20
		frame_oam_tile $2B, $F8, 3, $20
		frame_oam_tile $22, $F8, 3, $20
		frame_oam_tile $19, $F8, $200,	$20
		frame_oam_tile $10, $F8, $400,	$20
		frame_oam_tile 4, $F8,	3, $20
		frame_oam_tile $FB, $F8, $402,	$20
		frame_oam_tile $F2, $F8, $200,	$20
		frame_oam_tile $E9, $F8, 3, $20
		frame_oam_tile $E0, $F8, $602,	$20
		frame_oam_tile $D3, $F8, $201,	$20
		frame_oam_tile $C9, $F8, $2201, $20
		frame_oam_tile $C0, $F8, $200,	$20
		frame_oam_tile $B6, $F8, $601,	$20
animation_frame_C702DC:.BYTE $10
		frame_oam_tile $48, $F8, $201,	$20
		frame_oam_tile $3E, $F8, $2001, $20
		frame_oam_tile $35, $F8, 3, $20
		frame_oam_tile $2C, $F8, 3, $20
		frame_oam_tile $23, $F8, $200,	$20
		frame_oam_tile $1A, $F8, $400,	$20
		frame_oam_tile $D, $F8, $402, $20
		frame_oam_tile 4, $F8,	$200, $20
		frame_oam_tile $FB, $F8, $201,	$20
		frame_oam_tile $F1, $F8, $2001, $20
		frame_oam_tile $E8, $F8, $600,	$20
		frame_oam_tile $DB, $F8, $201,	$20
		frame_oam_tile $D1, $F8, $601,	$20
		frame_oam_tile $C8, $F8, $200,	$20
		frame_oam_tile $BF, $F8, 3, $20
		frame_oam_tile $B6, $F8, $602,	$20
animation_frame_C7032D:.BYTE 4
		frame_oam_tile $B, $F8, $603, $20
		frame_oam_tile 1, $F8,	$200, $20
		frame_oam_tile $F7, $F8, $402,	$20
		frame_oam_tile $ED, $F8, 1, $20
animation_frame_C70342:.BYTE 6
		frame_oam_tile $13, $F8, $402,	$20
		frame_oam_tile 9, $F8,	$201, $20
		frame_oam_tile $FF, $F8, $2401, $20
		frame_oam_tile $F5, $F8, $2401, $20
		frame_oam_tile $ED, $F8, $2200, $20
		frame_oam_tile $E4, $F8, $603,	$20
animation_frame_C70361:.BYTE 6
		frame_oam_tile $15, $F8, $2601, $20
		frame_oam_tile $B, $F8, $201, $20
		frame_oam_tile 1, $F8,	$402, $20
		frame_oam_tile $F7, $F8, $201,	$20
		frame_oam_tile $ED, $F8, 3, $20
		frame_oam_tile $E3, $F8, $602,	$20
animation_frame_C70380:.BYTE 8
		frame_oam_tile $1F, $F8, $2001, $20
		frame_oam_tile $15, $F8, $200,	$20
		frame_oam_tile $B, $F8, $402, $20
		frame_oam_tile 1, $F8,	$203, $20
		frame_oam_tile $F7, $F8, $200,	$20
		frame_oam_tile $ED, $F8, $2401, $20
		frame_oam_tile $E3, $F8, $2601, $20
		frame_oam_tile $D8, $F8, $2201, $20
animation_frame_C703A9:.BYTE 9
		frame_oam_tile $2D, $FB, $2609, $20
		frame_oam_tile $22, $FB, $40A,	$20
		frame_oam_tile $16, $FB, $A, $20
		frame_oam_tile $A, $FB, $2609,	$20
		frame_oam_tile $FA, $FB, $B, $20
		frame_oam_tile $EE, $FB, $2008, $20
		frame_oam_tile $E2, $FB, $60B,	$20
		frame_oam_tile $D6, $FB, $2208, $20
		frame_oam_tile $CA, $FB, $40A,	$20
animation_frame_C703D7:.BYTE 4
		frame_oam_tile 8, $F8,	3, $20
		frame_oam_tile 0, $F8,	$2200, $20
		frame_oam_tile $F8, $F8, $2002, $20
		frame_oam_tile $EE, $F8, $201,	$20
		.BYTE 1
		animation_frame animation_frame_C70290, $FF
		.BYTE 1
		animation_frame animation_frame_C702DC, $FF
byte_C703F6:	.BYTE 1
		animation_frame animation_frame_C7032D, $FF
byte_C703FB:	.BYTE 1
		animation_frame animation_frame_C70342, $FF
byte_C70400:	.BYTE 1
		animation_frame animation_frame_C70361, $FF
byte_C70405:	.BYTE 1
		animation_frame animation_frame_C70380, $FF
byte_C7040A:	.BYTE 1
		animation_frame animation_frame_C703A9, $FF
byte_C7040F:	.BYTE 1
		animation_frame animation_frame_C703D7, $FF
animation_frame_C70414:.BYTE $11
		frame_oam_tile $10, $18, $3402, 0
		frame_oam_tile $10, $10, $2402, 0
		frame_oam_tile $10, 8,	$1402, 0
		frame_oam_tile $10, 0,	$402, 0
		frame_oam_tile $10, $F8, $3400, 0
		frame_oam_tile $10, $F0, $2400, 0
		frame_oam_tile $10, $E8, $1400, 0
		frame_oam_tile 0, $20,	$204, $20
		frame_oam_tile 0, $10,	$2202, $20
		frame_oam_tile 0, 0, $202, $20
		frame_oam_tile 0, $F0,	$2200, $20
		frame_oam_tile 0, $E0,	$200, $20
		frame_oam_tile $F0, $20, 4, $20
		frame_oam_tile $F0, $10, $2002, $20
		frame_oam_tile $F0, 0,	2, $20
		frame_oam_tile $F0, $F0, $2000, $20
		frame_oam_tile $F0, $E0, 0, $20
animation_frame_C7046A:.BYTE $13
		frame_oam_tile 8, $20,	5, $20
		frame_oam_tile 8, $10,	$2003, $20
		frame_oam_tile 8, 0, 3, $20
		frame_oam_tile 8, $F0,	$2001, $20
		frame_oam_tile 8, $E0,	1, $20
		frame_oam_tile $F8, $20, $604,	$20
		frame_oam_tile $F8, $10, $2602, $20
		frame_oam_tile $F8, 0,	$602, $20
		frame_oam_tile $F8, $F0, $2600, $20
		frame_oam_tile $F8, $E0, $600,	$20
		frame_oam_tile $F0, $20, $504,	0
		frame_oam_tile $F0, $18, $3502, 0
		frame_oam_tile $F0, $10, $2502, 0
		frame_oam_tile $F0, 8,	$1502, 0
		frame_oam_tile $F0, 0,	$502, 0
		frame_oam_tile $F0, $F8, $3500, 0
		frame_oam_tile $F0, $F0, $2500, 0
		frame_oam_tile $F0, $E8, $1500, 0
		frame_oam_tile $F0, $E0, $500,	0
animation_frame_C704CA:.BYTE $13
		frame_oam_tile $10, $20, $605,	0
		frame_oam_tile $10, $18, $3603, 0
		frame_oam_tile $10, $10, $2603, 0
		frame_oam_tile $10, 8,	$1603, 0
		frame_oam_tile $10, 0,	$603, 0
		frame_oam_tile $10, $F8, $3601, 0
		frame_oam_tile $10, $F0, $2601, 0
		frame_oam_tile $10, $E8, $1601, 0
		frame_oam_tile $10, $E0, $601,	0
		frame_oam_tile 0, $20,	$405, $20
		frame_oam_tile 0, $10,	$2403, $20
		frame_oam_tile 0, 0, $403, $20
		frame_oam_tile 0, $F0,	$2401, $20
		frame_oam_tile 0, $E0,	$401, $20
		frame_oam_tile $F0, $20, $205,	$20
		frame_oam_tile $F0, $10, $2203, $20
		frame_oam_tile $F0, 0,	$203, $20
		frame_oam_tile $F0, $F0, $2201, $20
		frame_oam_tile $F0, $E0, $201,	$20
animation_frame_C7052A:.BYTE $16
		frame_oam_tile $F0, $10, $2703, 0
		frame_oam_tile $F0, 8,	$1703, 0
		frame_oam_tile 8, $20,	$2606, $20
		frame_oam_tile $18, $20, $2605, 0
		frame_oam_tile 0, $20,	$706, 0
		frame_oam_tile $18, $10, $2405, $20
		frame_oam_tile 8, $10,	$2205, $20
		frame_oam_tile $F8, $10, $2005, $20
		frame_oam_tile $18, 0,	$2406, $20
		frame_oam_tile $18, $F0, $406,	$20
		frame_oam_tile 8, 0, $2206, $20
		frame_oam_tile 8, $F0,	$206, $20
		frame_oam_tile $F8, 0,	$2006, $20
		frame_oam_tile $F8, $F0, 6, $20
		frame_oam_tile $F0, 0,	$703, 0
		frame_oam_tile $F0, $F8, $3701, 0
		frame_oam_tile $F0, $F0, $2701, 0
		frame_oam_tile $F0, $E8, $1701, 0
		frame_oam_tile $F0, $E0, $701,	0
		frame_oam_tile $18, $E0, $2404, $20
		frame_oam_tile 8, $E0,	$2204, $20
		frame_oam_tile $F8, $E0, $2004, $20
		.BYTE 1
		animation_frame animation_frame_C70414, $FF
		.BYTE 1
		animation_frame animation_frame_C7046A, $FF
		.BYTE 1
		animation_frame animation_frame_C704CA, $FF
		.BYTE 1
		animation_frame animation_frame_C7052A, $FF
animation_frame_C705AD:.BYTE 1
		frame_oam_tile $F8, $E8, 4, $A0
animation_frame_C705B3:.BYTE 1
		frame_oam_tile $F8, $E6, $204,	$A0
animation_frame_C705B9:.BYTE 2
		frame_oam_tile $F8, $E6, $404,	$A0
		frame_oam_tile $F8, $E6, $2404, $A0
animation_frame_C705C4:.BYTE 2
		frame_oam_tile $F8, $E5, $604,	$A0
		frame_oam_tile $F8, $E5, $2604, $A0
byte_C705CF:	.BYTE 4
		animation_frame animation_frame_C705AD, 4
		animation_frame animation_frame_C705B3, 5
		animation_frame animation_frame_C705B9, 6
		animation_frame animation_frame_C705C4, 7
.A8
.I8

sub_C705E0:
		SEP	#$20
		LDA	#.LOBYTE(sub_C705F7)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C705F7)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C705F7)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		RTL
; End of function sub_C705E0

.A8
.I8

sub_C705F7:
		SEP	#$20
		LDA	#$17
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$17

loc_C70600:
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#0
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#0
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		REP	#$20
.A16
		LDA	#$3F8
		STA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		LDA	#$3E8
		STA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		LDA	#$48
		STA	z:$11,X
		LDA	#$30
		STA	z:$E,X
		LDA	#8
		STA	z:$1E,X
		LDA	#0
		STA	z:$20,X
		LDA	#0
		STA	z:$22,X
		LDA	#0
		STA	z:$24,X
		REP	#$20
		LDA	#.LOWORD(byte_C51749)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_C51749)
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C70667)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C70667)
		STA	z:2,X
		JSL	f:sub_C70751
		JSL	f:sub_C707ED
		JSL	f:sub_C70845
		JSL	f:sub_C7088B

loc_C70667:
		JSL	f:sub_C53955
		REP	#$20
.A16
		BIT	#$80
		BNE	loc_C7067D
		JSL	f:sub_C5395A
		REP	#$20
		BIT	#$90
		BEQ	loc_C706B7

loc_C7067D:
		REP	#$20
		LDA	z:$20,X
		BEQ	loc_C706A3
		CMP	#2
		BEQ	loc_C7068C
		JML	f:loc_C70735
; ---------------------------------------------------------------------------

loc_C7068C:
		SEP	#$20
.A8
		LDA	#$31
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C70735)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C70735)
		STA	z:2,X
		JMP	a:.LOWORD(loc_C70735)
; ---------------------------------------------------------------------------

loc_C706A3:
		REP	#$20
.A16
		LDA	z:$22,X
		AND	#$FF
		ASL
		PHX
		TAX

loc_C706AD:
		LDA	f:word_C707C9,X
		TAY
		PLX
		JSL	f:play_music

loc_C706B7:
		JSL	f:sub_C5395A
		SEP	#$20
.A8
		STA	z:$48
		BIT	#$C
		BNE	loc_C70712
		LDA	z:$30,X
		BEQ	loc_C706CB
		DEC	z:$30,X
		BRA	loc_C70735
; ---------------------------------------------------------------------------

loc_C706CB:
		JSL	f:sub_C53964
		SEP	#$20
		STA	z:$48
		BIT	#3
		BEQ	loc_C70735
		LDA	#$10
		STA	z:$30,X
		LDA	z:$20,X
		BEQ	loc_C706F4
		CMP	#1
		BNE	loc_C70735
		INC	z:$24,X
		LDA	z:$24,X
		AND	#1
		STA	z:$24,X
		AND	#$FF
		TAY
		JSL	f:dboot_19
		BRA	loc_C70735
; ---------------------------------------------------------------------------

loc_C706F4:
		LDA	z:$48
		BIT	#1
		BNE	loc_C70706
		DEC	z:$22,X
		LDA	z:$22,X
		BPL	loc_C70735
		LDA	#$11
		STA	z:$22,X
		BRA	loc_C70735
; ---------------------------------------------------------------------------

loc_C70706:
		INC	z:$22,X
		LDA	z:$22,X
		CMP	#$12
		BNE	loc_C70735
		STZ	z:$22,X
		BRA	loc_C70735
; ---------------------------------------------------------------------------

loc_C70712:
		SEP	#$20
		LDA	#1
		STA	z:$40
		LDA	z:$48
		BIT	#4
		BNE	loc_C70722
		LDA	#$FF
		STA	z:$40

loc_C70722:
		LDA	z:$40
		CLC
		ADC	z:$20,X
		STA	z:$20,X
		BPL	loc_C7072F
		LDA	#2
		STA	z:$20,X

loc_C7072F:
		CMP	#3
		BNE	loc_C70735
		STZ	z:$20,X
.A16

loc_C70735:
		REP	#$20
		LDA	z:$20,X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:word_C7074B,X
		PLX
		STA	z:$14,X
		JSL	f:advance_animation
		RTL
; End of function sub_C705F7

; ---------------------------------------------------------------------------
word_C7074B:	.WORD $5B, $73,	$8B
.A8
.I8

sub_C70751:
		SEP	#$20
		LDA	#.LOBYTE(sub_C7076E)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C7076E)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C7076E)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		TXA
		STA	a:.LOWORD($20),Y
		RTL
; End of function sub_C70751

.A16
.I8

sub_C7076E:
		REP	#$20
		LDA	#$88
		STA	z:$11,X
		LDA	#$58
		STA	z:$14,X
		LDA	#$830
		STA	z:$E,X
		LDA	#6
		STA	z:$1E,X
		LDY	z:$20,X
		LDA	a:.LOWORD($22),Y
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:off_C707A5,X
		STA	z:$50
		PLX
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		JSL	f:advance_animation
		RTL
; End of function sub_C7076E

; ---------------------------------------------------------------------------
off_C707A5:	.ADDR byte_C70240, byte_C70245,	byte_C7024A, byte_C7024F, byte_C70254
		.ADDR byte_C70259, byte_C7025E,	byte_C70263, byte_C70268, byte_C7026D
		.ADDR byte_C70272, byte_C70277,	byte_C7027C, byte_C70281, byte_C70286
		.ADDR byte_C7028B, byte_C703F6,	byte_C703FB
word_C707C9:	.WORD 0, 1, 7, 2, 4
		.WORD 6, $B, $14, 8, $A
		.WORD $12, $16,	$D, $E,	$C
		.WORD $F, $10, $11
.A8
.I8

sub_C707ED:
		SEP	#$20
		LDA	#.LOBYTE(sub_C7080A)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C7080A)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C7080A)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		TXA
		STA	a:.LOWORD($20),Y
		RTL
; End of function sub_C707ED

.A16
.I8

sub_C7080A:
		REP	#$20
		LDA	#$88
		STA	z:$11,X
		LDA	#$70
		STA	z:$14,X
		LDA	#$830
		STA	z:$E,X
		LDA	#6
		STA	z:$1E,X
		LDY	z:$20,X
		LDA	a:.LOWORD($24),Y
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:off_C70841,X
		STA	z:$50
		PLX
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		JSL	f:advance_animation
		RTL
; End of function sub_C7080A

; ---------------------------------------------------------------------------
off_C70841:	.ADDR byte_C70400, byte_C70405
.A8
.I8

sub_C70845:
		SEP	#$20
		LDA	#.LOBYTE(sub_C7085C)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C7085C)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C7085C)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		RTL
; End of function sub_C70845

.A8
.I8

sub_C7085C:
		REP	#$20
.A16
		LDA	#$88
		STA	z:$11,X
		LDA	#$38
		STA	z:$14,X
		LDA	#$830
		STA	z:$E,X
		LDA	#8
		STA	z:$1E,X
		LDA	#0
		STA	z:$20,X
		LDA	#.LOWORD(byte_C7040A)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		JSL	f:advance_animation
		RTL
; End of function sub_C7085C

.A8
.I8

sub_C7088B:
		SEP	#$20
		LDA	#.LOBYTE(sub_C708A2)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C708A2)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C708A2)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		RTL
; End of function sub_C7088B

.A8
.I8

sub_C708A2:
		REP	#$20
.A16
		LDA	#$88
		STA	z:$11,X
		LDA	#$88
		STA	z:$14,X
		LDA	#$830
		STA	z:$E,X
		LDA	#6
		STA	z:$1E,X
		LDA	#.LOWORD(byte_C7040F)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		JSL	f:advance_animation
		RTL
; End of function sub_C708A2

.A8
.I16
; e=0

sub_C708CC:
		SEP	#$20
		LDA	#.LOBYTE(sub_C708FE)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C708FE)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C708FE)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C708EA

loc_C708E6:
		JML	f:loc_C55264
; ---------------------------------------------------------------------------

loc_C708EA:
		LDA	#$20
		STA	a:.LOWORD($20),Y
		LDA	#0
		STA	a:.LOWORD($22),Y
		LDY	#$12
		JSL	f:play_sound
		RTL
; End of function sub_C708CC

.A16
.I16

sub_C708FE:
		REP	#$20
		DEC	z:$20,X
		BNE	locret_C70923
		LDA	z:$22,X
		PHX
		TAX
		LDA	f:word_C70924,X
		PLX
		CMP	#$FFFF
		BNE	loc_C70916
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C70916:
		STA	z:$20,X
		INC	z:$22,X
		INC	z:$22,X
		LDY	#$11
		JSL	f:play_sound

locret_C70923:
		RTL
; End of function sub_C708FE

; ---------------------------------------------------------------------------
word_C70924:	.WORD $20, $10,	1, $FFFF
animation_frame_C7092C:.BYTE 3
		frame_oam_tile 0, $F0,	$100, 0
		frame_oam_tile $F8, $F0, 0, 0
		frame_oam_tile $F8, $F8, $1000, $20
animation_frame_C7093C:.BYTE 3
		frame_oam_tile 0, $EF,	$100, 0
		frame_oam_tile $F8, $EF, 0, 0
		frame_oam_tile $F8, $F7, $1200, $20
animation_frame_C7094C:.BYTE 3
		frame_oam_tile $F8, $F7, $1400, $20
		frame_oam_tile 0, $EF,	$100, 0
		frame_oam_tile $F8, $EF, 0, 0
animation_frame_C7095C:.BYTE 3
		frame_oam_tile 0, 0, $2700, 0
		frame_oam_tile $F8, 0,	$2600, 0
		frame_oam_tile $F8, $F0, $600,	$20
animation_frame_C7096C:.BYTE 3
		frame_oam_tile 0, $EF,	$301, 0
		frame_oam_tile $F8, $EF, $201,	0
		frame_oam_tile $F8, $F7, $1001, $20
animation_frame_C7097C:.BYTE 3
		frame_oam_tile 0, $FF,	$2301, 0
		frame_oam_tile $F8, $FF, $2201, 0
		frame_oam_tile $F8, $EF, $201,	$20
animation_frame_C7098C:.BYTE 3
		frame_oam_tile 0, 0, $2700, 0
		frame_oam_tile $F8, 0,	$2600, 0
		frame_oam_tile $F8, $F0, $401,	$20
animation_frame_C7099C:.BYTE 3
		frame_oam_tile $F5, 0,	$3701, 0
		frame_oam_tile $F5, $F8, $2701, 0
		frame_oam_tile $FD, $F8, $601,	$20
animation_frame_C709AC:.BYTE 4
		frame_oam_tile 0, $F8,	$1301, 0
		frame_oam_tile $F8, $F8, $1001, 0
		frame_oam_tile 0, $F0,	$700, 0
		frame_oam_tile $F8, $F0, $600,	0
animation_frame_C709C1:.BYTE 4
		frame_oam_tile 0, $F0,	$301, 0
		frame_oam_tile $F8, $F0, $201,	0
		frame_oam_tile 0, $F8,	$1301, 0
		frame_oam_tile $F8, $F8, $1001, 0
animation_frame_C709D6:.BYTE 1
		frame_oam_tile $F8, $F8, 2, $20
animation_frame_C709DC:.BYTE 1
		frame_oam_tile $F8, $F8, $202,	$20
animation_frame_C709E2:.BYTE 1
		frame_oam_tile $F8, $FD, $402,	$20
animation_frame_C709E8:.BYTE 1
		frame_oam_tile $F8, $FD, $602,	$20
animation_frame_C709EE:.BYTE 4
		frame_oam_tile 0, $D, $3002, $40
		frame_oam_tile 0, 5, $2002, $40
		frame_oam_tile $F8, $D, $3002,	0
		frame_oam_tile $F8, 5,	$2002, 0
animation_frame_C70A03:.BYTE 1
		frame_oam_tile $F8, $F8, $2202, $20
animation_frame_C70A09:.BYTE 1
		frame_oam_tile $F8, $F8, $2402, $20
animation_frame_C70A0F:.BYTE 2
		frame_oam_tile $F8, 0,	$2402, $20
		frame_oam_tile $FC, $F8, $2602, 0
animation_frame_C70A1A:.BYTE 2
		frame_oam_tile $F8, 8,	$2402, $20
		frame_oam_tile $FC, $F8, $2602, $20
animation_frame_C70A25:.BYTE 3
		frame_oam_tile $F8, $10, $2402, $20
		frame_oam_tile $FC, 0,	$2602, $20
		frame_oam_tile $FC, $F8, $2602, $20
animation_frame_C70A35:.BYTE 3
		frame_oam_tile $F8, $18, $2402, $20
		frame_oam_tile $FC, 8,	$2602, $20
		frame_oam_tile $FC, $F8, $2602, $20
animation_frame_C70A45:.BYTE 4
		frame_oam_tile $F8, $20, $2402, $20
		frame_oam_tile $FC, $10, $2602, $20
		frame_oam_tile $FC, 8,	$2602, $20
		frame_oam_tile $FC, $F8, $2602, $20
animation_frame_C70A5A:.BYTE 4
		frame_oam_tile $F8, $28, $2402, $20
		frame_oam_tile $FC, $18, $2602, $20
		frame_oam_tile $FC, 8,	$2602, $20
		frame_oam_tile $FC, $F8, $2602, $20
animation_frame_C70A6F:.BYTE 5
		frame_oam_tile $F8, $30, $2402, $20
		frame_oam_tile $FC, $20, $2602, $20
		frame_oam_tile $FC, $18, $2602, $20
		frame_oam_tile $FC, 8,	$2602, $20
		frame_oam_tile $FC, $F8, $2602, $20
animation_frame_C70A89:.BYTE 5
		frame_oam_tile $F8, $38, $2402, $20
		frame_oam_tile $FC, $28, $2602, $20
		frame_oam_tile $FC, $18, $2602, $20
		frame_oam_tile $FC, 8,	$2602, $20
		frame_oam_tile $FC, $F8, $2602, $20
animation_frame_C70AA3:.BYTE 6
		frame_oam_tile $F8, $40, $2402, $20
		frame_oam_tile $FC, $30, $2602, $20
		frame_oam_tile $FC, $28, $2602, $20
		frame_oam_tile $FC, $18, $2602, $20
		frame_oam_tile $FC, 8,	$2602, $20
		frame_oam_tile $FC, $F8, $2602, $20
animation_frame_C70AC2:.BYTE 6
		frame_oam_tile $F8, $48, $2402, $20
		frame_oam_tile $FC, $38, $2602, $20
		frame_oam_tile $FC, $28, $2602, $20
		frame_oam_tile $FC, $18, $2602, $20
		frame_oam_tile $FC, 8,	$2602, $20
		frame_oam_tile $FC, $F8, $2602, $20
animation_frame_C70AE1:.BYTE 7
		frame_oam_tile $F8, $50, $2402, $20
		frame_oam_tile $FC, $40, $2602, $20
		frame_oam_tile $FC, $38, $2602, $20
		frame_oam_tile $FC, $28, $2602, $20
		frame_oam_tile $FC, $18, $2602, $20
		frame_oam_tile $FC, 8,	$2602, $20
		frame_oam_tile $FC, $F8, $2602, $20
animation_frame_C70B05:.BYTE 7
		frame_oam_tile $F8, $58, $2402, $20
		frame_oam_tile $FC, $48, $2602, $20
		frame_oam_tile $FC, $38, $2602, $20
		frame_oam_tile $FC, $28, $2602, $20
		frame_oam_tile $FC, $18, $2602, $20
		frame_oam_tile $FC, 8,	$2602, $20
		frame_oam_tile $FC, $F8, $2602, $20
animation_frame_C70B29:.BYTE 8
		frame_oam_tile $FC, $50, $2602, $20
		frame_oam_tile $F8, $60, $2402, $20
		frame_oam_tile $FC, $48, $2602, $20
		frame_oam_tile $FC, $38, $2602, $20
		frame_oam_tile $FC, $28, $2602, $20
		frame_oam_tile $FC, $18, $2602, $20
		frame_oam_tile $FC, 8,	$2602, $20
		frame_oam_tile $FC, $F8, $2602, $20
animation_frame_C70B52:.BYTE 8
		frame_oam_tile $F8, $68, $2402, $20
		frame_oam_tile $FC, $58, $2602, $20
		frame_oam_tile $FC, $48, $2602, $20
		frame_oam_tile $FC, $38, $2602, $20
		frame_oam_tile $FC, $28, $2602, $20
		frame_oam_tile $FC, $18, $2602, $20
		frame_oam_tile $FC, 8,	$2602, $20
		frame_oam_tile $FC, $F8, $2602, $20
animation_frame_C70B7B:.BYTE 6
		frame_oam_tile 0, 0, $3500, 0
		frame_oam_tile $F8, 0,	$3400, 0
		frame_oam_tile 0, $F8,	$3301, 0
		frame_oam_tile $F8, $F8, $3201, 0
		frame_oam_tile 0, $F0,	$101, 0
		frame_oam_tile $F8, $F0, 1, 0
animation_frame_C70B9A:.BYTE 6
		frame_oam_tile 0, $FF,	$3100, 0
		frame_oam_tile 0, $F7,	$3000, 0
		frame_oam_tile $F8, $FF, $3601, 0
		frame_oam_tile $F8, $F7, $2601, 0
		frame_oam_tile 0, $EF,	$101, 0
		frame_oam_tile $F8, $EF, 1, 0
animation_frame_C70BB9:.BYTE 6
		frame_oam_tile 0, $EF,	$101, 0
		frame_oam_tile $F8, $EF, 1, 0
		frame_oam_tile 0, $FF,	$3700, 0
		frame_oam_tile $F8, $FF, $3600, 0
		frame_oam_tile 0, $F7,	$3301, 0
		frame_oam_tile $F8, $F7, $3201, 0
animation_frame_C70BD8:.BYTE 6
		frame_oam_tile $F8, 0,	$3500, $40
		frame_oam_tile $F8, $F8, $3301, $40
		frame_oam_tile $F8, $F0, $101,	$40
		frame_oam_tile 0, 0, $3400, $40
		frame_oam_tile 0, $F8,	$3201, $40
		frame_oam_tile 0, $F0,	1, $40
animation_frame_C70BF7:.BYTE 6
		frame_oam_tile $F8, $FF, $3100, $40
		frame_oam_tile $F8, $F7, $3000, $40
		frame_oam_tile $F8, $EF, $101,	$40
		frame_oam_tile 0, $FF,	$3601, $40
		frame_oam_tile 0, $F7,	$2601, $40
		frame_oam_tile 0, $EF,	1, $40
animation_frame_C70C16:.BYTE 6
		frame_oam_tile 0, $EF,	1, $40
		frame_oam_tile 0, $FF,	$3600, $40
		frame_oam_tile 0, $F7,	$3201, $40
		frame_oam_tile $F8, $EF, $101,	$40
		frame_oam_tile $F8, $FF, $3700, $40
		frame_oam_tile $F8, $F7, $3301, $40
animation_frame_C70C35:.BYTE 6
		frame_oam_tile 0, 0, $3102, 0
		frame_oam_tile $F8, 0,	$2102, 0
		frame_oam_tile 0, $F0,	$501, 0
		frame_oam_tile $F8, $F0, $401,	0
		frame_oam_tile 0, $F8,	$3101, 0
		frame_oam_tile $F8, $F8, $3001, 0
animation_frame_C70C54:.BYTE 6
		frame_oam_tile 0, $F8,	$500, 0
		frame_oam_tile $F8, $F8, $400,	0
		frame_oam_tile 0, $F0,	$300, 0
		frame_oam_tile $F8, $F0, $200,	0
		frame_oam_tile 0, 0, $3300, 0
		frame_oam_tile $F8, 0,	$3200, 0
byte_C70C73:	.BYTE 4
		animation_frame animation_frame_C7092C, 8
		animation_frame animation_frame_C7093C, 8
		animation_frame animation_frame_C7092C, 8
		animation_frame animation_frame_C7094C, 8
byte_C70C84:	.BYTE 4
		animation_frame animation_frame_C7095C, 8
		animation_frame animation_frame_C7096C, 8
		animation_frame animation_frame_C7095C, 8
		animation_frame animation_frame_C7097C, 8
byte_C70C95:	.BYTE 1
		animation_frame animation_frame_C7098C, $FF
byte_C70C9A:	.BYTE 1
		animation_frame animation_frame_C7099C, $FF
byte_C70C9F:	.BYTE 4
		animation_frame animation_frame_C709AC, $30
		animation_frame animation_frame_C709C1, 8
		animation_frame animation_frame_C709AC, 8
		animation_frame animation_frame_C709C1, 8
byte_C70CB0:	.BYTE 3
		animation_frame animation_frame_C709DC, 4
		animation_frame animation_frame_C709E2, 4
		animation_frame animation_frame_C709E8, 4
byte_C70CBD:	.BYTE 1
		animation_frame animation_frame_C709D6, $FF
byte_C70CC2:	.BYTE 1
		animation_frame animation_frame_C709EE, $FF
byte_C70CC7:	.BYTE $E
		animation_frame animation_frame_C70A09, $30
		animation_frame animation_frame_C70A0F, 1
		animation_frame animation_frame_C70A1A, 1
		animation_frame animation_frame_C70A25, 1
		animation_frame animation_frame_C70A35, 1
		animation_frame animation_frame_C70A45, 1
		animation_frame animation_frame_C70A5A, 1
		animation_frame animation_frame_C70A6F, 1
		animation_frame animation_frame_C70A89, 1
		animation_frame animation_frame_C70AA3, 1
		animation_frame animation_frame_C70AC2, 1
		animation_frame animation_frame_C70AE1, 1
		animation_frame animation_frame_C70B05, 1
		animation_frame animation_frame_C70B29, 1
byte_C70D00:	.BYTE 1
		animation_frame animation_frame_C70A03, $FF
byte_C70D05:	.BYTE 1
		animation_frame animation_frame_C70B52, $15
byte_C70D0A:	.BYTE $E
		animation_frame animation_frame_C70B29, 1
		animation_frame animation_frame_C70B05, 1
		animation_frame animation_frame_C70AE1, 1
		animation_frame animation_frame_C70AC2, 1
		animation_frame animation_frame_C70AA3, 1
		animation_frame animation_frame_C70A89, 1
		animation_frame animation_frame_C70A6F, 1
		animation_frame animation_frame_C70A5A, 1
		animation_frame animation_frame_C70A45, 1
		animation_frame animation_frame_C70A35, 1
		animation_frame animation_frame_C70A25, 1
		animation_frame animation_frame_C70A1A, 1
		animation_frame animation_frame_C70A0F, 1
		animation_frame animation_frame_C70A09, 8
byte_C70D43:	.BYTE 3
		animation_frame animation_frame_C709E8, 4
		animation_frame animation_frame_C709E2, 4
		animation_frame animation_frame_C709DC, 4
byte_C70D50:	.BYTE 4
		animation_frame animation_frame_C70B7B, 8
		animation_frame animation_frame_C70B9A, 8
		animation_frame animation_frame_C70B7B, 8
		animation_frame animation_frame_C70BB9, 8
byte_C70D61:	.BYTE 4
		animation_frame animation_frame_C70BD8, 8
		animation_frame animation_frame_C70BF7, 8
		animation_frame animation_frame_C70BD8, 8
		animation_frame animation_frame_C70C16, 8
byte_C70D72:	.BYTE 2
		animation_frame animation_frame_C70C35, $10
		animation_frame animation_frame_C70C54, $10
animation_frame_C70D7B:.BYTE 3
		frame_oam_tile 0, 0, $2700, 0
		frame_oam_tile $F8, 0,	$2600, 0
		frame_oam_tile $F8, $F0, $401,	$20
animation_frame_C70D8B:.BYTE 6
		frame_oam_tile 0, $EF,	$501, 0
		frame_oam_tile $F8, $EF, $401,	0
		frame_oam_tile 0, $F7,	$3501, 0
		frame_oam_tile $F8, $F7, $3401, 0
		frame_oam_tile 0, $FF,	$2101, 0
		frame_oam_tile $F8, $FF, $2001, 0
animation_frame_C70DAA:.BYTE 6
		frame_oam_tile $F8, $EF, $401,	0
		frame_oam_tile 0, $EF,	$501, 0
		frame_oam_tile $F8, $F7, $2401, 0
		frame_oam_tile 0, $F7,	$2501, 0
		frame_oam_tile 0, $FF,	$2301, 0
		frame_oam_tile $F8, $FF, $2201, 0
byte_C70DC9:	.BYTE 4
		animation_frame animation_frame_C70D7B, 8
		animation_frame animation_frame_C70D8B, 8
		animation_frame animation_frame_C70D7B, 8
		animation_frame animation_frame_C70DAA, 8
animation_frame_C70DDA:.BYTE 3
		frame_oam_tile $F8, $D8, 0, $20
		frame_oam_tile $F8, $E8, $2000, $20
		frame_oam_tile $F8, $F8, $600,	$20
animation_frame_C70DEA:.BYTE 3
		frame_oam_tile $F8, $F9, $2201, $20
		frame_oam_tile $F8, $D9, 0, $20
		frame_oam_tile $F8, $E9, $2000, $20
animation_frame_C70DFA:.BYTE 3
		frame_oam_tile $F8, $F9, 1, $20
		frame_oam_tile $F8, $D9, 0, $20
		frame_oam_tile $F8, $E9, $2000, $20
animation_frame_C70E0A:.BYTE 3
		frame_oam_tile $F8, $D8, 0, $20
		frame_oam_tile $F8, $E8, $2600, $20
		frame_oam_tile $F8, $F8, $2401, $20
animation_frame_C70E1A:.BYTE 3
		frame_oam_tile $F8, $F7, $2400, $20
		frame_oam_tile $F8, $D7, 0, $20
		frame_oam_tile $F8, $E7, $2600, $20
animation_frame_C70E2A:.BYTE 3
		frame_oam_tile $F8, $F7, $400,	$20
		frame_oam_tile $F8, $D7, 0, $20
		frame_oam_tile $F8, $E7, $2600, $20
animation_frame_C70E3A:.BYTE 3
		frame_oam_tile $F8, $D8, 0, $60
		frame_oam_tile $F8, $E8, $2001, $60
		frame_oam_tile $F8, $F8, $201,	$60
animation_frame_C70E4A:.BYTE 3
		frame_oam_tile $F9, $F8, $401,	$60
		frame_oam_tile $F9, $D8, 0, $60
		frame_oam_tile $F9, $E8, $2001, $60
animation_frame_C70E5A:.BYTE 3
		frame_oam_tile $F9, $F8, $601,	$60
		frame_oam_tile $F9, $D8, 0, $60
		frame_oam_tile $F9, $E8, $2001, $60
animation_frame_C70E6A:.BYTE 3
		frame_oam_tile $F8, $D8, 0, $20
		frame_oam_tile $F8, $E8, $2001, $20
		frame_oam_tile $F8, $F8, $201,	$20
animation_frame_C70E7A:.BYTE 3
		frame_oam_tile $F7, $F8, $401,	$20
		frame_oam_tile $F7, $D8, 0, $20
		frame_oam_tile $F7, $E8, $2001, $20
animation_frame_C70E8A:.BYTE 3
		frame_oam_tile $F7, $F8, $601,	$20
		frame_oam_tile $F7, $D8, 0, $20
		frame_oam_tile $F7, $E8, $2001, $20
animation_frame_C70E9A:.BYTE 3
		frame_oam_tile $F8, $D8, 0, $20
		frame_oam_tile $F8, $E8, $200,	$20
		frame_oam_tile $F8, $F8, $600,	$20
animation_frame_C70EAA:.BYTE 3
		frame_oam_tile $F8, $E8, $2200, $20
		frame_oam_tile $F8, $D8, 0, $20
		frame_oam_tile $F8, $F8, $600,	$20
animation_frame_C70EBA:.BYTE 4
		frame_oam_tile 0, 0, $102, 0
		frame_oam_tile $F8, 0,	2, 0
		frame_oam_tile $F8, $E0, 0, $20
		frame_oam_tile $F8, $F0, $2601, $20
animation_frame_C70ECF:.BYTE 2
		frame_oam_tile $F8, $E8, $202,	$20
		frame_oam_tile $F8, $F8, $402,	$20
animation_frame_C70EDA:.BYTE 3
		frame_oam_tile $F8, $E8, $602,	$60
		frame_oam_tile $F8, $D8, 0, $60
		frame_oam_tile $F8, $F8, $201,	$60
animation_frame_C70EEA:.BYTE 3
		frame_oam_tile $F9, $E8, $602,	$60
		frame_oam_tile $F9, $F8, $401,	$60
		frame_oam_tile $F9, $D8, 0, $60
animation_frame_C70EFA:.BYTE 3
		frame_oam_tile $F9, $E8, $602,	$60
		frame_oam_tile $F9, $F8, $601,	$60
		frame_oam_tile $F9, $D8, 0, $60
animation_frame_C70F0A:.BYTE 3
		frame_oam_tile $F8, $E8, $2200, $20
		frame_oam_tile $F8, $D8, 0, $20
		frame_oam_tile $F8, $F8, $600,	$20
animation_frame_C70F1A:.BYTE 3
		frame_oam_tile $F8, $D9, 0, $20
		frame_oam_tile $F8, $E9, $2200, $20
		frame_oam_tile $F8, $F9, 1, $20
animation_frame_C70F2A:.BYTE 3
		frame_oam_tile $F8, $D9, 0, $20
		frame_oam_tile $F8, $E9, $2200, $20
		frame_oam_tile $F8, $F9, $2201, $20
animation_frame_C70F3A:.BYTE 3
		frame_oam_tile $F8, $E8, $602,	$20
		frame_oam_tile $F8, $D8, 0, $20
		frame_oam_tile $F8, $F8, $201,	$20
animation_frame_C70F4A:.BYTE 3
		frame_oam_tile $F7, $E8, $602,	$20
		frame_oam_tile $F7, $F8, $401,	$20
		frame_oam_tile $F7, $D8, 0, $20
animation_frame_C70F5A:.BYTE 3
		frame_oam_tile $F7, $E8, $602,	$20
		frame_oam_tile $F7, $F8, $601,	$20
		frame_oam_tile $F7, $D8, 0, $20
animation_frame_C70F6A:.BYTE 9
		frame_oam_tile $F8, $F0, $2602, 0
		frame_oam_tile $F0, $F0, $2502, 0
		frame_oam_tile $F0, $F8, $3502, 0
		frame_oam_tile $F0, 8,	$3402, 0
		frame_oam_tile $F0, 0,	$2402, 0
		frame_oam_tile 0, 8, $1102, 0
		frame_oam_tile $F8, 8,	$1002, 0
		frame_oam_tile $F8, $F8, $2202, $20
		frame_oam_tile 8, $F8,	$2002, $20
byte_C70F98:    .BYTE 4
                animation_frame animation_frame_C70E0A, $E
                animation_frame animation_frame_C70E1A, $14
                animation_frame animation_frame_C70E0A, $E
                animation_frame animation_frame_C70E2A, $14
byte_C70FA9:    .BYTE 4
                animation_frame animation_frame_C70E3A, $E
                animation_frame animation_frame_C70E4A, $14
                animation_frame animation_frame_C70E3A, $E
                animation_frame animation_frame_C70E5A, $14
byte_C70FBA:    .BYTE 4
                animation_frame animation_frame_C70DDA, $E
                animation_frame animation_frame_C70DEA, $14
                animation_frame animation_frame_C70DDA, $E
                animation_frame animation_frame_C70DFA, $14
byte_C70FCB:    .BYTE 4
                animation_frame animation_frame_C70E6A, $E
                animation_frame animation_frame_C70E7A, $14
                animation_frame animation_frame_C70E6A, $E
                animation_frame animation_frame_C70E8A, $14
byte_C70FDC:    .BYTE 4
                animation_frame animation_frame_C70E0A, 8
                animation_frame animation_frame_C70E1A, 8
                animation_frame animation_frame_C70E0A, 8
                animation_frame animation_frame_C70E2A, 8
byte_C70FED:    .BYTE 4
                animation_frame animation_frame_C70EDA, 8
                animation_frame animation_frame_C70EEA, 8
                animation_frame animation_frame_C70EDA, 8
                animation_frame animation_frame_C70EFA, 8
byte_C70FFE:    .BYTE 4
                animation_frame animation_frame_C70F0A, 8
                animation_frame animation_frame_C70F1A, 8
                animation_frame animation_frame_C70F0A, 8
                animation_frame animation_frame_C70F2A, 8
byte_C7100F:    .BYTE 4
                animation_frame animation_frame_C70F3A, 8
                animation_frame animation_frame_C70F4A, 8
                animation_frame animation_frame_C70F3A, 8
                animation_frame animation_frame_C70F5A, 8
byte_C71020:    .BYTE 2
                animation_frame animation_frame_C70E9A, $10
                animation_frame animation_frame_C70EAA, $10
byte_C71029:    .BYTE 2
                animation_frame animation_frame_C70EBA, $10
                animation_frame animation_frame_C70ECF, $10
byte_C71032:    .BYTE 1
                animation_frame animation_frame_C70F6A, $FF
.A16
.I16

create_crane_hand:
		REP	#$20
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(crane_hand)
		STA	z:$DB
		LDA	#.HIBYTE(crane_hand)
		STA	z:$DC
		LDA	#.BANKBYTE(crane_hand)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		LDA	z:$40
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($11),Y
		LDA	z:$42
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($14),Y
		LDA	z:$5F

loc_C7106B:
		STA	a:.LOWORD($3A),Y
		LDA	z:$60
		STA	a:.LOWORD($3B),Y
		SEP	#$20
.A8
		LDA	z:$48
		STA	a:.LOWORD($3E),Y
		LDA	#$30
		STA	a:.LOWORD($E),Y
		LDA	a:.LOWORD(3),Y
		ORA	#1
		STA	a:.LOWORD(3),Y
		REP	#$20
.A16
		LDA	#0
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	#$3E8
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		SEP	#$20
.A8
		LDA	#$17
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$17
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#0
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#0
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		RTL
; End of function create_crane_hand

.A8
.I16

crane_hand:
		REP	#$20
.A16
		LDY	z:$26,X
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		LDA	#$88
		STA	z:$11,X
		LDA	#$28
		STA	z:$14,X
		LDA	#0
		STA	z:$16,X
		LDA	#$200
		STA	z:$34,X
		LDA	#1
		STA	z:$36,X
		LDA	#0
		STA	z:$38,X
		LDA	#$D
		STA	z:$3A,X
		JSL	f:random2
		SEP	#$20
.A8
		AND	#$7F
		CLC
		ADC	#$20
		STA	z:$32,X
		LDA	#$30
		STA	z:$E,X
		LDA	#0
		STA	z:$20,X
		JSL	f:create_crane_hand_hand
		JSL	f:create_crane_hand_hand2
		REP	#$20
.A16
		STZ	z:$46
		JSL	f:sub_C71BDB
		INC	z:$46
		JSL	f:sub_C71BDB
		SEP	#$20
.A8
		LDA	#0
		STA	z:3,X
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		LDA	#$30
		STA	a:.LOWORD(player1_object+player::palette) ; orig=0x0D4E
		LDA	#$30
		STA	a:.LOWORD(player2_object+player::palette) ; orig=0x0D8E
		REP	#$20
.A16
		LDA	#.LOWORD(_crane_hand)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_crane_hand)
		STA	z:2,X

_crane_hand:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C71136
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C71136:
		BIT	#$41
		BEQ	loc_C7113E
		JML	f:loc_C71255
; ---------------------------------------------------------------------------

loc_C7113E:
		LDY	#7
		LDA	#$29
		STA	z:$40
		LDA	#1
		JSL	f:palette_related
		LDA	#$2A
		STA	z:$40
		LDA	#2
		JSL	f:palette_related
		LDA	#$2B
		STA	z:$40
		LDA	#3
		JSL	f:palette_related
		LDA	#$35
		STA	z:$40
		LDA	#4
		JSL	f:palette_related
		LDA	#$2C
		STA	z:$40
		LDA	#6
		JSL	f:palette_related
		LDA	#$2D
		STA	z:$40
		LDA	#7
		JSL	f:palette_related
		LDA	#.LOWORD(SHIRO_PALETTE)
		STA	z:$40
		LDA	#8
		JSL	f:palette_related
		LDA	#.LOWORD(KURO_PALETTE)
		STA	z:$40
		LDA	#9
		JSL	f:palette_related
		LDA	#.LOWORD(MOOK_PALETTE)
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		LDA	#.LOWORD(CRANE_PALETTE)
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C711B2)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C711B2)
		STA	z:2,X

loc_C711B2:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C711BF
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C711BF:
		BIT	#$41
		BEQ	loc_C711C7

loc_C711C3:
		JML	f:loc_C71255
; ---------------------------------------------------------------------------

loc_C711C7:
		REP	#$20
.A16
		DEC	z:$34,X
		BEQ	loc_C711D1
		JML	f:loc_C71255
; ---------------------------------------------------------------------------

loc_C711D1:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		AND	#$F7
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C711E8)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C711E8)
		STA	z:2,X

loc_C711E8:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C711F5
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C711F5:
		BIT	#$41
		BEQ	loc_C711FD
		JML	f:loc_C71255
; ---------------------------------------------------------------------------

loc_C711FD:
		REP	#$20
.A16
		LDA	z:$36,X
		BNE	loc_C71255
		SEP	#$20
.A8
		LDA	z:$20,X
		BNE	loc_C71255
		DEC	z:$32,X
		BPL	loc_C7121F
		JSL	f:random2
		SEP	#$20
		AND	#$7F
		STA	z:$32,X
		AND	#3
		STA	z:$20,X
		AND	#1
		STA	z:$30,X

loc_C7121F:
		REP	#$20
.A16
		LDA	#2
		STA	z:$40
		LDA	z:$30,X
		BIT	#1
		BNE	loc_C71232
		LDA	#$FFFE
		STA	z:$40

loc_C71232:
		LDA	z:$11,X
		CLC
		ADC	z:$40
		CMP	#$42
		BCS	loc_C71240
		JML	f:loc_C7155E
; ---------------------------------------------------------------------------

loc_C71240:
		CMP	#$CE
		BCC	loc_C71249
		JML	f:loc_C7155E
; ---------------------------------------------------------------------------

loc_C71249:
		STA	z:$11,X
		SEC
		SBC	#$88
		AND	#$3FF
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
.A8

loc_C71255:
		REP	#$20
.A16
		LDA	z:$16,X
		BNE	loc_C7129C
		LDA	z:$11,X
		PHA
		LDA	z:$11,X
		SEC
		SBC	#$88
		EOR	#$FFFF
		INC
		CLC
		ADC	#$88
		STA	z:$11,X
		LDA	#$2030
		STA	z:$42
		LDA	#$2020
		STA	z:$44
		JSL	f:sub_C6370B
		REP	#$20
		PLA
		STA	z:$11,X
		BCC	locret_C7129B
		REP	#$20
		LDA	#$80
		STA	z:$16,X
		DEC	z:$3A,X
		BNE	locret_C7129B
		REP	#$20
		LDA	#.LOWORD(loc_C71396)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C71396)
		STA	z:2,X

locret_C7129B:
		RTL
; ---------------------------------------------------------------------------

loc_C7129C:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C712A9
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C712A9:
		BIT	#$41
		BEQ	loc_C712B1
		JML	f:locret_C712DA
; ---------------------------------------------------------------------------
.A16

loc_C712B1:
		REP	#$20
		LDA	z:$16,X
		DEC	z:$16,X
		AND	#1
		PHX
		TAX
		SEP	#$20
.A8
		LDA	f:crane_fire_bg_palettes,X
		STA	z:$40
		LDY	#0
		LDA	#4
		JSL	f:palette_related
		LDA	f:crane_fire_palettes,X
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		PLX

locret_C712DA:
		RTL
; ---------------------------------------------------------------------------
		JSL	f:random2
		REP	#$20
.A16
		AND	#$3F
		BIT	#1
		BNE	locret_C712ED
		EOR	#$FFFF
		INC

locret_C712ED:
		RTL
; ---------------------------------------------------------------------------

loc_C712EE:
		SEP	#$20
.A8
		LDY	#4
		LDA	#$2E
		STA	z:$40
		LDA	#1
		JSL	f:palette_related
		LDA	#$2E
		STA	z:$40
		LDA	#2
		JSL	f:palette_related
		LDA	#$2E
		STA	z:$40
		LDA	#3
		JSL	f:palette_related
		LDA	#$2E
		STA	z:$40
		LDA	#4
		JSL	f:palette_related
		LDA	#$2E
		STA	z:$40
		LDA	#5
		JSL	f:palette_related
		LDA	#$2E
		STA	z:$40
		LDA	#6
		JSL	f:palette_related
		LDA	#$2E
		STA	z:$40
		LDA	#7
		JSL	f:palette_related
		LDA	#.LOWORD(WHITE_PALETTE)
		STA	z:$40
		LDA	#8
		JSL	f:palette_related
		LDA	#.LOWORD(WHITE_PALETTE)
		STA	z:$40
		LDA	#9
		JSL	f:palette_related
		LDA	#.LOWORD(WHITE_PALETTE)
		STA	z:$40
		LDA	#$A
		JSL	f:palette_related
		LDA	#.LOWORD(WHITE_PALETTE)
		STA	z:$40
		LDA	#$B
		JSL	f:palette_related
		LDA	#.LOWORD(WHITE_PALETTE)
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		LDA	#.LOWORD(WHITE_PALETTE)
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		LDA	#.LOWORD(WHITE_PALETTE)
		STA	z:$40
		LDA	#$E
		JSL	f:palette_related
		LDA	#.LOWORD(WHITE_PALETTE)
		STA	z:$40
		LDA	#$F
		JSL	f:palette_related
		REP	#$20
.A16
		DEC	z:$16,X
		RTL
; ---------------------------------------------------------------------------
word_C7138E:	.WORD $3F, $3F,	$80, $800F
; ---------------------------------------------------------------------------

loc_C71396:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		PHX
		LDX	#$D40
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	z:$20,X
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		SEP	#$20
		LDX	#$D80
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	z:$20,X
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		PLX
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C713CF)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C713CF)
		STA	z:2,X

loc_C713CF:
		REP	#$20
.A16
		LDA	z:$16,X
		BEQ	loc_C713D9
		JML	f:loc_C712B1
; ---------------------------------------------------------------------------

loc_C713D9:
		LDA	#$180
		STA	z:$16,X
		LDA	z:$11,X
		PHA
		LDA	z:$11,X
		SEC
		SBC	#$88
		EOR	#$FFFF
		INC
		CLC
		ADC	#$88
		STA	z:$11,X
		REP	#$20
		LDA	#.LOWORD(word_C7138E)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C7138E)
		STA	z:$52
		JSL	f:sub_C631D7
		REP	#$20
.A16
		PLA
		STA	z:$11,X
		REP	#$20
		LDA	#.LOWORD(loc_C71414)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C71414)
		STA	z:2,X

loc_C71414:
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#$20
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		LDA	z:$16,X
		CMP	#$141
		BNE	loc_C7142A
		JML	f:loc_C712EE
; ---------------------------------------------------------------------------

loc_C7142A:
		DEC	z:$16,X
		BEQ	loc_C71432
		JML	f:locret_C71559
; ---------------------------------------------------------------------------

loc_C71432:
		INC	z:$38,X
		LDA	#$100
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	#$68
		STA	a:.LOWORD(player1_object+player::x_position) ; orig=0x0D51
		LDA	#$B8
		STA	a:.LOWORD(player1_object+player::y_position) ; orig=0x0D54
		LDA	#$A8
		STA	a:.LOWORD(player2_object+player::x_position) ; orig=0x0D91
		LDA	#$B8
		STA	a:.LOWORD(player2_object+player::y_position) ; orig=0x0D94
		PHX
		LDX	#$D40
		REP	#$20
		LDA	#.LOWORD(up_walking_animation)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(up_walking_animation)
		STA	z:$52
		JSL	f:start_animation
		LDX	#$D80
		REP	#$20
.A16
		LDA	#.LOWORD(up_walking_animation)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(up_walking_animation)
		STA	z:$52
		JSL	f:start_animation
		PLX
		SEP	#$20
		LDY	#7
		LDA	#$29
		STA	z:$40
		LDA	#1
		JSL	f:palette_related
		LDA	#$2A
		STA	z:$40
		LDA	#2
		JSL	f:palette_related
		LDA	#$2B
		STA	z:$40
		LDA	#3
		JSL	f:palette_related
		LDA	#$35
		STA	z:$40
		LDA	#4
		JSL	f:palette_related
		LDA	#5
		STA	z:$40
		LDA	#5
		JSL	f:palette_related
		LDA	#$2C
		STA	z:$40
		LDA	#6
		JSL	f:palette_related
		LDA	#$2D
		STA	z:$40
		LDA	#7
		JSL	f:palette_related
		LDA	#.LOWORD(SHIRO_PALETTE)
		STA	z:$40
		LDA	#8
		JSL	f:palette_related
		LDA	#.LOWORD(KURO_PALETTE)
		STA	z:$40

loc_C714D5:
		LDA	#.LOWORD(AO_PALETTE)
		JSL	f:palette_related
		LDA	#.LOWORD(BOMB_PALETTE)
		STA	z:$40
		LDA	#$A
		JSL	f:palette_related
		LDA	#.LOWORD(RED_BOMB_PALETTE)
		STA	z:$40
		LDA	#$B
		JSL	f:palette_related
		LDA	#.LOWORD(MOOK_PALETTE)
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		LDA	#.LOWORD(CRANE_PALETTE)
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		LDA	#.LOWORD(MISSLE_PALETTE)
		STA	z:$40
		LDA	#$E
		JSL	f:palette_related
		LDA	#$E
		STA	z:$40
		LDA	#$F
		JSL	f:palette_related
		REP	#$20
.A16
		LDA	#$80
		STA	z:$30,X
		REP	#$20
		LDA	#.LOWORD(loc_C7152B)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C7152B)
		STA	z:2,X

loc_C7152B:
		REP	#$20
.A16
		DEC	z:$30,X
		BNE	locret_C71559
		PHX
		LDX	#$D40
		LDA	#0
		STA	z:$40
		LDA	#1
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		LDX	#$D80
		LDA	#0
		STA	z:$40
		LDA	#1
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		PLX
		JSL	f:delete_object

locret_C71559:
		RTL
; ---------------------------------------------------------------------------
crane_fire_bg_palettes:
		.BYTE $34
		.BYTE $35
crane_fire_palettes:
		.BYTE GENERIC_BOSS_FIRE_PALETTE
		.BYTE CRANE_PALETTE
; ---------------------------------------------------------------------------

loc_C7155E:
		SEP	#$20
.A8
		LDA	z:$30,X
		EOR	#1
		STA	z:$30,X
		RTL
; End of function crane_hand

.A8
.I16

create_crane_hand_hand:
		SEP	#$20
		LDA	#.LOBYTE(unknown_crane_object)
		STA	z:$DB
		LDA	#.HIBYTE(unknown_crane_object)
		STA	z:$DC
		LDA	#.BANKBYTE(unknown_crane_object)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		TXA
		STA	a:.LOWORD($34),Y
		RTL
; End of function create_crane_hand_hand

.A8
.I16

unknown_crane_object:
		REP	#$20
.A16
		LDA	#$88
		STA	z:$11,X
		LDA	#$78
		STA	z:$14,X
		LDA	#$FF
		STA	z:$32,X
		LDA	#$430
		STA	z:$E,X
		LDA	#8
		STA	z:$1E,X
		LDA	#.LOWORD(byte_C70C84)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C715BF)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C715BF)
		STA	z:2,X
		SEP	#$20
		LDA	#0
		STA	z:3,X

loc_C715BF:
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$80
		BEQ	loc_C715CD
		JML	f:locret_C71676
; ---------------------------------------------------------------------------

loc_C715CD:
		DEC	z:$32,X
		BEQ	loc_C715D5
		JML	f:loc_C71677
; ---------------------------------------------------------------------------

loc_C715D5:
		LDA	#.LOWORD(byte_C70C73)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C715F1)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C715F1)
		STA	z:2,X

loc_C715F1:
		REP	#$20
.A16
		LDA	z:$13,X
		CLC
		ADC	#$FF40
		STA	z:$13,X
		CMP	#$3B00
		BCC	loc_C71604
		JML	f:loc_C71672
; ---------------------------------------------------------------------------

loc_C71604:
		LDA	#$19
		STA	z:$14,X
		LDA	#$20
		STA	z:$32,X
		LDA	#.LOWORD(byte_C70C9F)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C7162A)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C7162A)
		STA	z:2,X

loc_C7162A:
		REP	#$20
.A16
		DEC	z:$32,X
		BNE	locret_C71676
		REP	#$20
		LDA	#.LOWORD(loc_C7163D)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C7163D)
		STA	z:2,X

loc_C7163D:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C7164A
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C7164A:
		BIT	#$41
		BEQ	loc_C71652
		JML	f:loc_C71672
; ---------------------------------------------------------------------------

loc_C71652:
		SEP	#$20
		LDY	z:$34,X
		LDA	a:.LOWORD($38),Y
		BEQ	loc_C7165F
		JML	f:loc_C7167C
; ---------------------------------------------------------------------------

loc_C7165F:
		REP	#$20
.A16
		LDA	a:.LOWORD($11),Y
		SEC
		SBC	#$88
		EOR	#$FFFF
		INC
		CLC
		ADC	#$88
		STA	z:$11,X
.A8

loc_C71672:
		JSL	f:advance_animation
.A16

locret_C71676:
		RTL
; ---------------------------------------------------------------------------

loc_C71677:
		JSL	f:advance_animation_2
		RTL
; ---------------------------------------------------------------------------
.A8

loc_C7167C:
		REP	#$20
.A16
		LDA	#$88
		STA	z:$11,X
		LDA	#$68
		STA	z:$14,X
		LDA	#$80
		STA	z:$20,X
		LDA	#.LOWORD(byte_C70C9A)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C716A9)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C716A9)
		STA	z:2,X

loc_C716A9:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	loc_C716EC
		LDA	#$80
		STA	z:$20,X
		JSL	f:sub_C71736
		REP	#$20
		LDA	#.LOWORD(loc_C716C5)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C716C5)
		STA	z:2,X

loc_C716C5:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	loc_C716EC
		LDA	#$80
		STA	z:$20,X
		LDA	#.LOWORD(byte_C70C95)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C716F1)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C716F1)
		STA	z:2,X
.A16

loc_C716EC:
		JSL	f:load_animation_frame
		RTL
; End of function unknown_crane_object

.A16
.I16

sub_C716F1:
		REP	#$20
		DEC	z:$20,X
		BNE	loc_C716EC
		LDA	#.LOWORD(byte_C70C73)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C71718)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C71718)
		STA	z:2,X
		JSL	f:load_animation_frame
		RTL
; End of function sub_C716F1

.A8
.I16

sub_C71718:
		REP	#$20
.A16
		DEC	z:$14,X
		LDA	z:$14,X
		CMP	#$FFE0
		BEQ	loc_C71727
		JML	f:loc_C716EC
; ---------------------------------------------------------------------------

loc_C71727:
		LDA	#$39
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		JSL	f:fade_out_music
		JSL	f:delete_object
		RTL
; End of function sub_C71718

.A16
.I16

sub_C71736:
		REP	#$20
		LDA	#0
		STA	z:$40
		LDA	#$58
		STA	z:$42
		LDA	#$A
		STA	z:$44
		LDA	#1
		STA	z:$46
		LDA	#8
		STA	z:$48
		JSL	f:sub_C7180C
		LDA	#0
		STA	z:$40
		LDA	#$78
		STA	z:$42
		LDA	#$A
		STA	z:$44
		LDA	#1
		STA	z:$46
		LDA	#8
		STA	z:$48
		JSL	f:sub_C7180C
		LDA	#0
		STA	z:$40
		LDA	#$98
		STA	z:$42
		LDA	#$A
		STA	z:$44
		LDA	#1
		STA	z:$46
		LDA	#8
		STA	z:$48
		JSL	f:sub_C7180C
		REP	#$20
		LDA	#$110
		STA	z:$40
		LDA	#$58
		STA	z:$42
		LDA	#$A
		STA	z:$44
		LDA	#2
		STA	z:$46
		LDA	#8
		STA	z:$48
		JSL	f:sub_C7180C
		LDA	#$110
		STA	z:$40
		LDA	#$78
		STA	z:$42
		LDA	#$A
		STA	z:$44
		LDA	#2
		STA	z:$46
		LDA	#8
		STA	z:$48
		JSL	f:sub_C7180C
		LDA	#$110
		STA	z:$40
		LDA	#$98
		STA	z:$42
		LDA	#$A
		STA	z:$44
		LDA	#2
		STA	z:$46
		LDA	#8
		STA	z:$48
		JSL	f:sub_C7180C
		SEP	#$20
.A8
		LDY	#0
		LDA	#.LOWORD(MECHA_BOMBER_BLUE_PALETTE)
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		LDA	#.LOWORD(MECHA_BOMBER_RED_PALETTE)
		STA	z:$40
		LDA	#$E
		JSL	f:palette_related
		LDA	#.LOWORD(MECHA_BOMBER_MAGENTA_PALETTE)
		STA	z:$40
		LDA	#$F
		JSL	f:palette_related
		RTL
; End of function sub_C71736

.A16
.I16

sub_C7180C:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C7184C)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C7184C)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C7184C)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	locret_C7184B
		LDA	#$30
		STA	a:.LOWORD($E),Y
		LDA	z:$40
		STA	a:.LOWORD($11),Y
		LDA	z:$42
		STA	a:.LOWORD($14),Y
		LDA	z:$44
		STA	a:.LOWORD($1E),Y
		LDA	z:$46
		STA	a:.LOWORD($20),Y
		LDA	z:$48
		STA	a:.LOWORD($24),Y
		LDA	#0
		STA	a:.LOWORD($22),Y

locret_C7184B:
		RTL
; End of function sub_C7180C

.A16
.I16

sub_C7184C:
		REP	#$20
		LDA	z:$20,X
		STA	z:$40
		JSL	f:start_animation_by_direction

loc_C71856:
		SEP	#$20
.A8
		STZ	z:$10,X
		REP	#$20
.A16
		LDA	z:$20,X
		DEC
		ASL
		ASL
		ASL
		ASL
		ORA	z:$22,X
		PHX
		TAX
		LDA	f:unk_C71978,X
		STA	z:$42
		LDA	f:unk_C7197A,X
		STA	z:$44
		LDA	f:unk_C71998,X
		STA	z:$46
		PLX
		LDA	z:$42
		STA	z:$16,X
		LDA	z:$44
		STA	z:$18,X
		LDA	z:$46
		STA	z:$26,X
		REP	#$20
		LDA	#.LOWORD(loc_C71893)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C71893)
		STA	z:2,X

loc_C71893:
		REP	#$20
.A16
		STZ	z:$40
		LDA	z:$18,X
		CLC
		ADC	z:$16,X
		STA	z:$16,X
		BPL	loc_C718A2
		DEC	z:$40

loc_C718A2:
		CLC
		ADC	z:$10,X
		STA	z:$10,X
		LDA	z:$40
		ADC	z:$12,X
		STA	z:$12,X
		LDA	z:$20,X
		AND	#$F
		CMP	#1
		BNE	loc_C718C1
		LDA	z:$11,X
		BMI	loc_C718C7
		CMP	z:$26,X
		BCS	loc_C718CC
		BRA	loc_C718C7
; ---------------------------------------------------------------------------

loc_C718C1:
		LDA	z:$11,X
		CMP	z:$26,X
		BCC	loc_C718CC

loc_C718C7:
		JSL	f:advance_animation_2
		RTL
; ---------------------------------------------------------------------------

loc_C718CC:
		REP	#$20
		LDA	#.LOWORD(sub_C7193A)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C7193A)
		STA	z:2,X
		REP	#$20
.A16
		LDA	z:$22,X
		CMP	z:$24,X
		BEQ	loc_C718C7
		LDA	z:$26,X
		STA	z:$11,X
		LDA	#$20
		STA	z:$30,X
		REP	#$20
		LDA	#.LOWORD(loc_C718F7)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C718F7)
		STA	z:2,X

loc_C718F7:
		REP	#$20
.A16
		DEC	z:$30,X
		BNE	loc_C718C7
		LDA	z:$22,X

loc_C718FF:
		CLC
		ADC	#4
		STA	z:$22,X
		CMP	#4
		BNE	loc_C71937
		LDA	z:$24,X
		BEQ	loc_C71937
		SEC
		SBC	#4
		STA	z:$48
		LDA	#0
		STA	z:$40
		LDA	z:$20,X
		CMP	#1
		BEQ	loc_C71925
		LDA	#$110
		STA	z:$40

loc_C71925:
		LDA	z:$14,X
		STA	z:$42
		LDA	z:$1E,X
		INC
		INC
		STA	z:$44
		LDA	z:$20,X
		STA	z:$46
		JSL	f:sub_C7180C

loc_C71937:
		JMP	a:.LOWORD(loc_C71856)
; End of function sub_C7184C

.A16
.I16

sub_C7193A:
		REP	#$20
		LDA	#$80
		STA	z:$30,X
		REP	#$20
		LDA	#.LOWORD(loc_C7194E)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C7194E)
		STA	z:2,X

loc_C7194E:
		REP	#$20
.A16
		DEC	z:$30,X
		BEQ	loc_C71958
		JML	f:loc_C718C7
; ---------------------------------------------------------------------------

loc_C71958:
		SEP	#$20
.A8
		LDA	#7
		STA	z:$F,X
		LDA	#$1C
		STA	z:$40
		JSL	f:start_animation_by_direction
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C71973)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C71973)
		STA	z:2,X

loc_C71973:
		JSL	f:load_animation_frame
		RTL
; End of function sub_C7193A

; ---------------------------------------------------------------------------
unk_C71978:	.BYTE	0
		.BYTE	4
unk_C7197A:	.BYTE $E0
		.BYTE $FF
		.BYTE	0
		.BYTE	4
		.BYTE $E0
		.BYTE $FF
		.BYTE	0
		.BYTE	4
		.BYTE $E0
		.BYTE $FF
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $FC
		.BYTE $20
		.BYTE	0
		.BYTE	0
		.BYTE $FC
		.BYTE $20
		.BYTE	0
		.BYTE	0
		.BYTE $FC
		.BYTE $20
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
unk_C71998:	.BYTE $28
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $48
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $68
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $E8
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $C8
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $A8
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
.A8
.I16

create_crane_hand_hand2:
		SEP	#$20
		LDA	#.LOBYTE(loc_C719D9)
		STA	z:$DB
		LDA	#.HIBYTE(loc_C719D9)
		STA	z:$DC
		LDA	#.BANKBYTE(loc_C719D9)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCC	loc_C719D4
		JML	f:loc_C71B1E
; ---------------------------------------------------------------------------

loc_C719D4:
		TXA
		STA	a:.LOWORD($34),Y
		RTL
; ---------------------------------------------------------------------------

loc_C719D9:
		SEP	#$20
		LDA	#0
		STA	z:3,X
		REP	#$20
.A16
		LDA	#$88
		STA	z:$11,X
		LDA	#$38
		STA	z:$14,X
		LDA	#0
		STA	z:$30,X
		LDA	#$180
		STA	z:$32,X
		LDA	#$200
		STA	z:$36,X
		LDA	#$430
		STA	z:$E,X
		LDA	#$A
		STA	z:$1E,X
		LDA	#.LOWORD(byte_C70CC2)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C71A20)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C71A20)
		STA	z:2,X

loc_C71A20:
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$80
		BEQ	loc_C71A2E
		JML	f:loc_C71B1E
; ---------------------------------------------------------------------------

loc_C71A2E:
		DEC	z:$32,X
		BEQ	loc_C71A36
		JML	f:loc_C71B1A
; ---------------------------------------------------------------------------

loc_C71A36:
		REP	#$20
		LDA	#.LOWORD(byte_C70D43)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C71A54)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C71A54)
		STA	z:2,X

loc_C71A54:
		JSL	f:loc_C71B1E
		JSL	f:advance_animation
		BCS	loc_C71A62
		JML	f:locret_C71B2B
; ---------------------------------------------------------------------------

loc_C71A62:
		REP	#$20
.A16
		LDA	#$10
		STA	z:$32,X
		LDA	#.LOWORD(byte_C70CBD)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		LDY	#$19
		JSL	f:play_sound
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C71A8D)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C71A8D)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C71A8D:
		REP	#$20
.A16
		DEC	z:$32,X
		BEQ	loc_C71A97
		JML	f:loc_C71B1A
; ---------------------------------------------------------------------------

loc_C71A97:
		LDY	z:$34,X
		LDA	#0
		STA	a:.LOWORD($36),Y
		REP	#$20
		LDA	#.LOWORD(loc_C71AAC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C71AAC)
		STA	z:2,X

loc_C71AAC:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C71AB9
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C71AB9:
		BIT	#$41
		BEQ	loc_C71AC1
		JML	f:loc_C71B1A
; ---------------------------------------------------------------------------

loc_C71AC1:
		REP	#$20
.A16
		LDY	z:$34,X
		LDA	a:.LOWORD($11),Y
		SEC
		SBC	#$88
		EOR	#$FFFF
		INC
		CLC
		ADC	#$88
		STA	z:$11,X
		DEC	z:$36,X
		BNE	loc_C71B1A
		JSL	f:is_object_aligned
		REP	#$20
		INC	z:$36,X
		BCS	loc_C71B1A
		LDA	#$E0
		STA	z:$42
		JSL	f:sub_C61586
		BNE	loc_C71B1A
		JSL	f:random2
		REP	#$20
		AND	#$7F
		CLC
		ADC	#$40
		STA	z:$36,X
		LDA	z:$30,X
		CMP	#3
		BCS	loc_C71B1A
		LDY	z:$34,X
		LDA	#1
		STA	a:.LOWORD($36),Y
		REP	#$20
		LDA	#.LOWORD(sub_C71B2C)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C71B2C)
		STA	z:2,X

loc_C71B1A:
		JSL	f:advance_animation
.A16

loc_C71B1E:
		SEP	#$20
.A8
		LDY	z:$34,X
		LDA	a:.LOWORD($38),Y
		BEQ	locret_C71B2B
		JSL	f:delete_object
.A16

locret_C71B2B:
		RTL
; End of function create_crane_hand_hand2

.A16
.I16

sub_C71B2C:
		REP	#$20
		LDA	#.LOWORD(byte_C70CB0)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		LDY	#$19
		JSL	f:play_sound
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C71B51)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C71B51)
		STA	z:2,X

loc_C71B51:
		JSL	f:loc_C71B1E
		JSL	f:advance_animation
		BCC	locret_C71B2B
		REP	#$20
.A16
		LDA	#$40
		STA	z:$32,X
		LDA	#.LOWORD(byte_C70CC2)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C71B7F)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C71B7F)
		STA	z:2,X
		RTL
; End of function sub_C71B2C

.A8
.I16

sub_C71B7F:
		JSL	f:loc_C71B1E
		JSL	f:advance_animation
		REP	#$20
.A16
		DEC	z:$32,X
		BEQ	loc_C71B91
		JML	f:locret_C71B2B
; ---------------------------------------------------------------------------

loc_C71B91:
		JSL	f:create_missle
		REP	#$20
		LDA	#.LOWORD(sub_C71BA3)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C71BA3)
		STA	z:2,X
		RTL
; End of function sub_C71B7F

.A8
.I16

sub_C71BA3:
		JSL	f:loc_C71B1E
		JSL	f:advance_animation
		REP	#$20
.A16
		LDA	z:$32,X
		BNE	loc_C71BB5
		JML	f:locret_C71B2B
; ---------------------------------------------------------------------------

loc_C71BB5:
		LDA	#$20
		STA	z:$32,X
		REP	#$20
		LDA	#.LOWORD(sub_C71BC8)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C71BC8)
		STA	z:2,X
		RTL
; End of function sub_C71BA3

.A8
.I16

sub_C71BC8:
		REP	#$20
.A16
		DEC	z:$32,X
		BNE	loc_C71BD2
		JML	f:loc_C71A36
; ---------------------------------------------------------------------------

loc_C71BD2:
		JSL	f:loc_C71B1E
		JSL	f:advance_animation
		RTL
; End of function sub_C71BC8

.A16
.I16

sub_C71BDB:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C71C28)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C71C28)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C71C28)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCC	loc_C71BF7
		JML	f:loc_C71B1E
; ---------------------------------------------------------------------------

loc_C71BF7:
		TXA
		STA	a:.LOWORD($34),Y
		REP	#$20
.A16
		LDA	#$74
		STA	a:.LOWORD($16),Y
		LDA	#$74
		STA	a:.LOWORD($11),Y
		LDA	#1
		STA	a:.LOWORD($20),Y
		LDA	z:$46
		BNE	loc_C71C25
		LDA	#$9C
		STA	a:.LOWORD($16),Y
		LDA	#$9C
		STA	a:.LOWORD($11),Y
		LDA	#2
		STA	a:.LOWORD($20),Y

loc_C71C25:
		REP	#$20
		RTL
; End of function sub_C71BDB

.A16
.I16

sub_C71C28:
		SEP	#$20
.A8
		LDA	#0
		STA	z:3,X
		REP	#$20
.A16
		LDA	#0
		STA	z:$22,X
		LDA	#$4A
		STA	z:$14,X
		LDA	#$FF
		STA	z:$32,X
		LDA	#$430
		STA	z:$E,X
		LDA	#$A
		STA	z:$1E,X
		LDA	#.LOWORD(byte_C70D00)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C71C65)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C71C65)
		STA	z:2,X

loc_C71C65:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$80
		BEQ	loc_C71C72
		JML	f:locret_C71D15
; ---------------------------------------------------------------------------

loc_C71C72:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C71C7F
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C71C7F:
		BIT	#$41
		BEQ	loc_C71C87
		JML	f:loc_C71CCE
; ---------------------------------------------------------------------------

loc_C71C87:
		SEP	#$20
		LDY	z:$34,X
		LDA	a:.LOWORD($38),Y
		BEQ	loc_C71C94
		JML	f:loc_C71D16
; ---------------------------------------------------------------------------

loc_C71C94:
		REP	#$20
.A16
		LDA	a:.LOWORD($11),Y
		SEC
		SBC	#$88
		EOR	#$FFFF
		INC
		CLC
		ADC	z:$16,X
		STA	z:$11,X
		LDA	a:.LOWORD($20),Y
		BIT	z:$20,X
		BEQ	loc_C71CCE
		LDA	#2
		STA	z:$22,X
		LDA	#.LOWORD(byte_C70CC7)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C71D1B)
		STA	z:0,X

loc_C71CC8:
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C71D1B)
		STA	z:2,X

loc_C71CCE:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C71D8B)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C71D8B)
		STA	z:$52
		REP	#$20
.A16
		LDA	z:$50
		CLC
		ADC	z:$22,X
		STA	z:$50
		LDA	[$50]
		CLC
		STA	z:$50
		LDA	z:$C,X
		AND	#$FF
		ASL
		CLC
		ADC	z:$50
		STA	z:$50
		LDA	[$50]
		STA	z:$44
		LDA	#$505
		STA	z:$42
		JSL	f:sub_C6353D
		REP	#$20
		LDA	z:$B,X
		CMP	#$30E
		BNE	loc_C71D11
		LDY	#$17
		JSL	f:play_sound

loc_C71D11:
		JSL	f:advance_animation
.A8

locret_C71D15:
		RTL
; ---------------------------------------------------------------------------

loc_C71D16:
		JSL	f:delete_object
		RTL
; End of function sub_C71C28

.A8
.I16

sub_C71D1B:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C71D28
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C71D28:
		BIT	#$41
		BEQ	loc_C71D30
		JML	f:loc_C71CCE
; ---------------------------------------------------------------------------

loc_C71D30:
		JSL	f:loc_C71CCE
		BCC	locret_C71D15
		REP	#$20
.A16
		INC	z:$22,X
		INC	z:$22,X
		LDA	z:$22,X
		CMP	#8
		BEQ	loc_C71D57
		PHX
		TAX
		LDA	f:off_C71D83,X
		PLX
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		RTL
; ---------------------------------------------------------------------------

loc_C71D57:
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C70D00)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C71C65)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C71C65)
		STA	z:2,X
		SEP	#$20
		LDY	z:$34,X
		LDA	#0
		STA	a:.LOWORD($20),Y
		LDA	#0
		STA	z:$22,X
		RTL
; End of function sub_C71D1B

; ---------------------------------------------------------------------------
off_C71D83: .ADDR 0, byte_C70CC7, byte_C70D05, byte_C70D0A
off_C71D8B:	.ADDR word_C71D93, word_C71D95,	word_C71DB1, word_C71DB3
word_C71D93:	.WORD 8
word_C71D95:	.WORD 8, $10, $18, $20,	$28
		.WORD $30, $38,	$40, $48, $50
		.WORD $58, $60,	$68, $70
word_C71DB1:	.WORD $70
word_C71DB3:	.WORD $70, $68,	$60, $58, $50
		.WORD $48, $40,	$38, $30, $28
		.WORD $20, $18,	$10, 8
.A16
.I16

sub_C71DCF:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C71E7A)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C71E7A)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C71E7A)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCC	loc_C71DEB
		JML	f:nullsub_11
; ---------------------------------------------------------------------------

loc_C71DEB:
		REP	#$20
.A16
		LDA	#$830
		STA	a:.LOWORD($E),Y
		LDA	#4
		STA	a:.LOWORD($1E),Y
		LDA	#$98
		STA	a:.LOWORD($11),Y
		LDA	#$FFA0
		STA	a:.LOWORD($14),Y
		LDA	#$38
		STA	a:.LOWORD($25),Y
		REP	#$20
		LDA	#.LOWORD(off_C71F25)
		STA	a:.LOWORD($18),Y
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C71F25)
		STA	a:.LOWORD($1A),Y
		LDY	#0
		LDA	#.LOWORD(MOOK_PALETTE)
		STA	z:$40
		LDA	#$A
		JSL	f:palette_related
		LDA	#.LOWORD(CARAT_DIAMOND_PALETTE)
		STA	z:$40
		LDA	#$B
		JSL	f:palette_related
		RTL
; End of function sub_C71DCF

.A16
.I16

sub_C71E32:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C71E7A)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C71E7A)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C71E7A)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCS	nullsub_11
		REP	#$20
.A16
		LDA	#$A30
		STA	a:.LOWORD($E),Y
		LDA	#6
		STA	a:.LOWORD($1E),Y
		LDA	#$78
		STA	a:.LOWORD($11),Y
		LDA	#$FFA0
		STA	a:.LOWORD($14),Y
		LDA	#$38
		STA	a:.LOWORD($25),Y
		REP	#$20
		LDA	#.LOWORD(off_C71F55)
		STA	a:.LOWORD($18),Y
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C71F55)
		STA	a:.LOWORD($1A),Y
		RTL
; End of function sub_C71E32

.A8
.I16

sub_C71E7A:
		LDY	#8
		JSL	f:sub_C71F0C
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C71E8E)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C71E8E)
		STA	z:2,X

loc_C71E8E:
		JSL	f:advance_animation
		REP	#$20
.A16
		INC	z:$14,X
		LDA	z:$14,X
		BMI	nullsub_11
		CMP	z:$25,X
		BNE	nullsub_11
		LDA	#$80
		STA	z:$20,X
		LDY	#8
		JSL	f:sub_C71F0C
		REP	#$20
		LDA	#.LOWORD(sub_C71EB8)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C71EB8)
		STA	z:2,X
; End of function sub_C71E7A

.A8
.I16
nullsub_11:
		RTL
.A8
.I16

sub_C71EB8:
		JSL	f:advance_animation_2
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	nullsub_11
		LDY	#$10
		JSL	f:sub_C71F0C
		REP	#$20
		LDA	#.LOWORD(sub_C71ED7)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C71ED7)
		STA	z:2,X
		RTL
; End of function sub_C71EB8

.A8
.I16

sub_C71ED7:
		JSL	f:advance_animation
		REP	#$20
.A16
		DEC	z:$14,X
		LDA	z:$14,X
		BPL	nullsub_11
		CMP	#$FFE0
		BNE	nullsub_11
		JSL	f:delete_object
		SEP	#$20
.A8
		LDA	z:$F,X
		CMP	#$A
		BNE	nullsub_11
		LDY	#0
		LDA	#.LOWORD(BOMB_PALETTE)
		STA	z:$40
		LDA	#$A
		JSL	f:palette_related
		LDA	#.LOWORD(RED_BOMB_PALETTE)
		STA	z:$40
		LDA	#$B
		JSL	f:palette_related
		RTL
; End of function sub_C71ED7

.A16
.I16

sub_C71F0C:
		REP	#$20
		LDA	z:$18,X
		STA	z:$50
		LDA	z:$19,X
		STA	z:$51
		LDA	[$50],Y
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		RTL
; End of function sub_C71F0C

; ---------------------------------------------------------------------------
off_C71F25:     .WORD 0
                .ADDR byte_C70D61
                .ADDR byte_C70D50
                .WORD 0
                .ADDR byte_C70C84
                .WORD 0
                .WORD 0
                .WORD 0
                .ADDR byte_C70C73
                .WORD 0
                .WORD 0
                .WORD 0
off_C71F3D:     .WORD 0
                .ADDR byte_C70D61
                .ADDR byte_C70D50
                .WORD 0
                .ADDR byte_C70DC9
                .WORD 0
                .WORD 0
                .WORD 0
                .ADDR byte_C70C73
                .ADDR byte_C70DC9
                .ADDR byte_C70D72
                .ADDR byte_C70C9A
off_C71F55:     .WORD 0
                .ADDR byte_C70FA9
                .ADDR byte_C70FCB
                .WORD 0
                .ADDR byte_C70FBA
                .WORD 0
                .WORD 0
                .WORD 0
                .ADDR byte_C70F98
                .WORD 0
                .WORD 0
                .WORD 0
off_C71F6D:     .WORD 0
                .ADDR byte_C70FED
                .ADDR byte_C7100F
                .WORD 0
                .ADDR byte_C70FFE
                .WORD 0
                .WORD 0
                .WORD 0
                .ADDR byte_C70FDC
                .ADDR byte_C71020
                .ADDR byte_C71029
                .ADDR byte_C71032
animation_frame_C71F85:.BYTE $17
		frame_oam_tile $E5, $B0, $2403, $20
		frame_oam_tile $D8, $F0, 5, $62
		frame_oam_tile $F8, $C0, $2400, $22
		frame_oam_tile $F8, $D0, $402,	$22
		frame_oam_tile $E8, $C0, $2200, $20
		frame_oam_tile $D8, $C0, $2000, $20
		frame_oam_tile $E8, $D0, $202,	$20
		frame_oam_tile $D8, $D0, 2, $20
		frame_oam_tile $D8, $E0, $2002, $20
		frame_oam_tile $E8, $E0, $2202, $20
		frame_oam_tile 8, $C0,	$2600, $20
		frame_oam_tile 8, $D0,	$602, $20
		frame_oam_tile $18, $D0, 3, $20
		frame_oam_tile $18, $E0, $2003, $20
		frame_oam_tile 8, $E0,	$2602, $20
		frame_oam_tile $F8, $E0, $2402, $22
		frame_oam_tile 8, 0, $2204, $62
		frame_oam_tile $E8, 0,	$2204, $22
		frame_oam_tile $E8, $F0, $204,	$22
		frame_oam_tile $18, $F0, 5, $22
		frame_oam_tile 8, $F0,	$604, $22
		frame_oam_tile $F8, $F0, $404,	$22
		frame_oam_tile $F8, 0,	$2404, $22
animation_frame_C71FF9:.BYTE $19
		frame_oam_tile $D8, $F0, 5, $62
		frame_oam_tile $FD, $98, $2403, $20
		frame_oam_tile $FD, $A8, $405,	$20
		frame_oam_tile 8, $B0,	$2203, $20
		frame_oam_tile $F8, $B0, $2601, $20
		frame_oam_tile $18, $E0, $201,	$20
		frame_oam_tile 8, $E0,	1, $20
		frame_oam_tile $E8, $E0, $600,	$20
		frame_oam_tile $D8, $E0, $400,	$20
		frame_oam_tile $D8, $D0, $401,	$20
		frame_oam_tile $E8, $D0, $601,	$20
		frame_oam_tile $E8, $C0, $203,	$20
		frame_oam_tile 8, $C0,	$603, $20
		frame_oam_tile $F8, $C0, $403,	$20
		frame_oam_tile $18, $D0, $2401, $20
		frame_oam_tile 8, $D0,	$2201, $20
		frame_oam_tile $F8, $D0, $2001, $20
		frame_oam_tile $F8, $E0, $2402, $22
		frame_oam_tile 8, 0, $2204, $62
		frame_oam_tile $E8, 0,	$2204, $22
		frame_oam_tile $E8, $F0, $204,	$22
		frame_oam_tile $18, $F0, 5, $22
		frame_oam_tile 8, $F0,	$604, $22
		frame_oam_tile $F8, $F0, $404,	$22
		frame_oam_tile $F8, 0,	$2404, $22
animation_frame_C72077:.BYTE $16
		frame_oam_tile $D8, $F0, 5, $62
		frame_oam_tile 8, $E0,	$2602, $22
		frame_oam_tile $F8, $D0, $402,	$22
		frame_oam_tile $18, $D0, $2405, $20
		frame_oam_tile $18, $E0, $407,	$20
		frame_oam_tile 8, $C0,	$2004, $20
		frame_oam_tile 8, $D0,	6, $20
		frame_oam_tile $E8, $C0, $2205, $20
		frame_oam_tile $D8, $D0, 7, $20
		frame_oam_tile $E8, $D0, $207,	$20
		frame_oam_tile $F8, $B0, $2605, $20
		frame_oam_tile $F8, $C0, $607,	$22
		frame_oam_tile $E8, $E0, $2207, $20
		frame_oam_tile $D8, $E0, $2007, $20
		frame_oam_tile $F8, $E0, $2402, $22
		frame_oam_tile 8, 0, $2204, $62
		frame_oam_tile $E8, 0,	$2204, $22
		frame_oam_tile $E8, $F0, $204,	$22
		frame_oam_tile $18, $F0, 5, $22
		frame_oam_tile 8, $F0,	$604, $22
		frame_oam_tile $F8, $F0, $404,	$22
		frame_oam_tile $F8, 0,	$2404, $22
animation_frame_C720E6:.BYTE $16
		frame_oam_tile 8, $10,	$205, 0
		frame_oam_tile $E0, $F0, $2603, $20
		frame_oam_tile $E0, 0,	$605, $20
		frame_oam_tile $10, $F0, $200,	$20
		frame_oam_tile 0, $F0,	0, $22
		frame_oam_tile $F0, $F0, $2006, $22
		frame_oam_tile $10, 0,	$2206, $20
		frame_oam_tile 0, 0, $2607, $20
		frame_oam_tile $F0, 0,	$2407, $20
		frame_oam_tile $F8, $40, $206,	$20
		frame_oam_tile $F8, $30, $2406, $20
		frame_oam_tile $F8, $20, $406,	$20
		frame_oam_tile $E8, $10, $2606, $20
		frame_oam_tile $F8, $10, $606,	$20
		frame_oam_tile $10, $D0, $608,	$20
		frame_oam_tile 0, $D0,	$408, $20
		frame_oam_tile $F0, $D0, $208,	$20
		frame_oam_tile $E0, $D0, 8, $20
		frame_oam_tile $10, $E0, $2608, $20
		frame_oam_tile $E0, $E0, $2008, $20
		frame_oam_tile 0, $E0,	$2408, $22
		frame_oam_tile $F0, $E0, $2208, $22
animation_frame_C72155:.BYTE $14
		frame_oam_tile $E5, $B8, $2403, $20
		frame_oam_tile $D8, $F8, 5, $62
		frame_oam_tile $F8, $C8, $2400, $22
		frame_oam_tile $F8, $D8, $402,	$22
		frame_oam_tile $E8, $C8, $2200, $20
		frame_oam_tile $D8, $C8, $2000, $20
		frame_oam_tile $E8, $D8, $202,	$20
		frame_oam_tile $D8, $D8, 2, $20
		frame_oam_tile $D8, $E8, $2002, $20
		frame_oam_tile $E8, $E8, $2202, $20
		frame_oam_tile 8, $C8,	$2600, $20
		frame_oam_tile 8, $D8,	$602, $20
		frame_oam_tile $18, $D8, 3, $20
		frame_oam_tile $18, $E8, $2003, $20
		frame_oam_tile 8, $E8,	$2602, $20
		frame_oam_tile $F8, $E8, $2402, $22
		frame_oam_tile $E8, $F8, $204,	$22
		frame_oam_tile $18, $F8, 5, $22
		frame_oam_tile 8, $F8,	$604, $22
		frame_oam_tile $F8, $F8, $404,	$22
animation_frame_C721BA:.BYTE $17
		frame_oam_tile $E5, $C0, $2403, $20
		frame_oam_tile $E0, 0,	5, $42
		frame_oam_tile $18, 0,	5, 2
		frame_oam_tile $10, 0,	$704, 2
		frame_oam_tile 8, 0, $604, 2
		frame_oam_tile 0, 0, $504, 2
		frame_oam_tile $F8, 0,	$404, 2
		frame_oam_tile $F0, 0,	$304, 2
		frame_oam_tile $E8, 0,	$204, 2
		frame_oam_tile $F8, $D0, $2400, $22
		frame_oam_tile $F8, $E0, $402,	$22
		frame_oam_tile $E8, $D0, $2200, $20
		frame_oam_tile $D8, $D0, $2000, $20
		frame_oam_tile $E8, $E0, $202,	$20
		frame_oam_tile $D8, $E0, 2, $20
		frame_oam_tile $D8, $F0, $2002, $20
		frame_oam_tile $E8, $F0, $2202, $20
		frame_oam_tile 8, $D0,	$2600, $20
		frame_oam_tile 8, $E0,	$602, $20
		frame_oam_tile $18, $E0, 3, $20
		frame_oam_tile $18, $F0, $2003, $20
		frame_oam_tile 8, $F0,	$2602, $20
		frame_oam_tile $F8, $F0, $2402, $22
animation_frame_C7222E:.BYTE $F
		frame_oam_tile $E5, $C8, $2403, $20
		frame_oam_tile $F8, $D8, $2400, $22
		frame_oam_tile $F8, $E8, $402,	$22
		frame_oam_tile $E8, $D8, $2200, $20
		frame_oam_tile $D8, $D8, $2000, $20
		frame_oam_tile $E8, $E8, $202,	$20
		frame_oam_tile $D8, $E8, 2, $20
		frame_oam_tile $D8, $F8, $2002, $20
		frame_oam_tile $E8, $F8, $2202, $20
		frame_oam_tile 8, $D8,	$2600, $20
		frame_oam_tile 8, $E8,	$602, $20
		frame_oam_tile $18, $E8, 3, $20
		frame_oam_tile $18, $F8, $2003, $20
		frame_oam_tile 8, $F8,	$2602, $20
		frame_oam_tile $F8, $F8, $2402, $22
animation_frame_C7227A:.BYTE $14
		frame_oam_tile $E5, $D0, $2403, $20
		frame_oam_tile $20, 0,	$2103, 0
		frame_oam_tile $18, 0,	$2003, 0
		frame_oam_tile $10, 0,	$2702, 0
		frame_oam_tile 8, 0, $2602, 2
		frame_oam_tile 0, 0, $2502, 2
		frame_oam_tile $F8, 0,	$2402, 2
		frame_oam_tile $F0, 0,	$2302, 0
		frame_oam_tile $E8, 0,	$2202, 0
		frame_oam_tile $E0, 0,	$2102, 0
		frame_oam_tile $D8, 0,	$2002, 0
		frame_oam_tile $F8, $E0, $2400, $22
		frame_oam_tile $F8, $F0, $402,	$22
		frame_oam_tile $E8, $E0, $2200, $20
		frame_oam_tile $D8, $E0, $2000, $20
		frame_oam_tile $E8, $F0, $202,	$20
		frame_oam_tile $D8, $F0, 2, $20
		frame_oam_tile 8, $E0,	$2600, $20
		frame_oam_tile 8, $F0,	$602, $20
		frame_oam_tile $18, $F0, 3, $20
animation_frame_C722DF:.BYTE $A
		frame_oam_tile $E5, $D8, $2403, $20
		frame_oam_tile $F8, $E8, $2400, $22
		frame_oam_tile $F8, $F8, $402,	$22
		frame_oam_tile $E8, $E8, $2200, $20
		frame_oam_tile $D8, $E8, $2000, $20
		frame_oam_tile $E8, $F8, $202,	$20
		frame_oam_tile $D8, $F8, 2, $20
		frame_oam_tile 8, $E8,	$2600, $20
		frame_oam_tile 8, $F8,	$602, $20
		frame_oam_tile $18, $F8, 3, $20
animation_frame_C72312:.BYTE $D
		frame_oam_tile $E5, $E0, $2403, $20
		frame_oam_tile $18, 0,	3, 0
		frame_oam_tile $10, 0,	$702, 0
		frame_oam_tile 8, 0, $602, 2
		frame_oam_tile 0, 0, $502, 2
		frame_oam_tile $F8, 0,	$402, 2
		frame_oam_tile $F0, 0,	$302, 0
		frame_oam_tile $E8, 0,	$202, 0
		frame_oam_tile $E0, 0,	$102, 0
		frame_oam_tile $F8, $F0, $2400, $22
		frame_oam_tile $E8, $F0, $2200, $20
		frame_oam_tile $D8, $F0, $2000, $20
		frame_oam_tile 8, $F0,	$2600, $20
animation_frame_C72354:.BYTE 5
		frame_oam_tile $E5, $E8, $2403, $20
		frame_oam_tile $F8, $F8, $2400, $22
		frame_oam_tile $E8, $F8, $2200, $20
		frame_oam_tile $D8, $F8, $2000, $20
		frame_oam_tile 8, $F8,	$2600, $20
animation_frame_C7236E:.BYTE 6
		frame_oam_tile $E5, $F0, $2403, $20
		frame_oam_tile 0, 0, $2500, 0
		frame_oam_tile $F8, 0,	$2400, 0
		frame_oam_tile $F0, 0,	$2300, 2
		frame_oam_tile $E8, 0,	$2200, 0
		frame_oam_tile $E0, 0,	$2100, 2
animation_frame_C7238D:.BYTE 1
		frame_oam_tile $E5, $F8, $2403, $20
animation_frame_C72393:.BYTE 2
		frame_oam_tile $ED, 0,	$2503, 0
		frame_oam_tile $E5, 0,	$2403, 0
animation_frame_C7239E:.BYTE 1
		frame_oam_tile $F8, $F8, $2005, $20
animation_frame_C723A4:.BYTE 1
		frame_oam_tile $FC, $FD, $1205, 0
bigaron_static_animation:.BYTE 1
		animation_frame animation_frame_C71F85, $FF
byte_C723AF:	.BYTE 5
		animation_frame animation_frame_C71FF9, 4
		animation_frame animation_frame_C72077, $E
		animation_frame animation_frame_C71FF9, 4
		animation_frame animation_frame_C720E6, $30
		animation_frame animation_frame_C71FF9, 8
byte_C723C4:	.BYTE $B
		animation_frame animation_frame_C71F85, $D
		animation_frame animation_frame_C72155, 4
		animation_frame animation_frame_C721BA, 4
		animation_frame animation_frame_C7222E, 3
		animation_frame animation_frame_C7227A, 3
		animation_frame animation_frame_C722DF, 2
		animation_frame animation_frame_C72312, 2
		animation_frame animation_frame_C72354, 2
		animation_frame animation_frame_C7236E, 2
		animation_frame animation_frame_C7238D, 1
		animation_frame animation_frame_C72393, 1
byte_C723F1:	.BYTE 1
		animation_frame animation_frame_C7239E, $FF
byte_C723F6:	.BYTE 1
		animation_frame animation_frame_C723A4, $FF
.A8
.I16

create_bigaron:
		REP	#$20
.A16
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(bigaron_intro)
		STA	z:$DB
		LDA	#.HIBYTE(bigaron_intro)
		STA	z:$DC
		LDA	#.BANKBYTE(bigaron_intro)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		LDA	z:$40
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($11),Y
		LDA	z:$42
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($14),Y
		LDA	z:$5F
		STA	a:.LOWORD($3A),Y
		LDA	z:$60
		STA	a:.LOWORD($3B),Y
		SEP	#$20
.A8
		LDA	z:$48
		STA	a:.LOWORD($3E),Y
		LDA	#$30
		STA	a:.LOWORD($E),Y
		LDA	a:.LOWORD(3),Y
		ORA	#1
		STA	a:.LOWORD(3),Y
		REP	#$20
.A16
		LDA	#9
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(bigaron_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(bigaron_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		RTL
; End of function create_bigaron

.A8
.I16

bigaron_intro:
		SEP	#$20
		LDA	#$17
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$17
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#0
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#0
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		REP	#$20
.A16
		LDA	#$88
		STA	z:enemy::x_position,X
		LDA	#$5E
		STA	z:enemy::y_position,X
		LDA	#$100
		STA	z:$34,X
		LDA	#.LOWORD(off_C72B28)
		STA	z:enemy::animation,X
		LDA	#.LOWORD(bigaron_static_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$C7
		STA	z:$18,X
		LDA	#0
		STA	z:$19,X
		LDA	#0
		STA	z:$36,X
		LDA	#0
		STA	z:$30,X
		LDA	#0
		STA	z:$31,X
		LDA	#$A
		STA	z:$32,X
		LDA	#0
		STA	z:$26,X
		LDA	#0
		STA	z:$27,X
		LDA	#8
		STA	z:$1E,X
		LDA	#$30
		STA	z:$E,X
		LDA	#2
		STA	z:$20,X
		LDA	#3
		STA	z:$21,X
		LDA	z:3,X
		ORA	#1
		STA	z:3,X
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		REP	#$20
.A16
		LDA	#.LOWORD(_bigaron)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_bigaron)
		STA	z:2,X

_bigaron:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C72502
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C72502:
		BIT	#$41
		BEQ	loc_C7250A
		JML	f:locret_C725B2
; ---------------------------------------------------------------------------

loc_C7250A:
		SEP	#$20
		LDY	#7
		LDA	#$10
		STA	z:$40
		LDA	#1
		JSL	f:palette_related
		LDA	#$11
		STA	z:$40
		LDA	#2
		JSL	f:palette_related
		LDA	#$12
		STA	z:$40
		LDA	#3
		JSL	f:palette_related
		LDA	#$13
		STA	z:$40
		LDA	#6
		JSL	f:palette_related
		LDA	#$14
		STA	z:$40
		LDA	#7
		JSL	f:palette_related
		LDA	#6
		STA	z:$40
		LDA	#8
		JSL	f:palette_related
		LDA	#7
		STA	z:$40
		LDA	#9
		JSL	f:palette_related
		LDA	#.LOWORD(BIGARON_PALETTE_1)
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		LDA	#.LOWORD(BIGARON_PALETTE_2)
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		LDA	#.LOWORD(BIGARON_FIRE_PALETTE)
		STA	z:$40
		LDA	#$E
		JSL	f:palette_related
		LDA	#.LOWORD(WHITE_PALETTE)
		STA	z:$40
		LDA	#$F
		JSL	f:palette_related
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C7258A)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C7258A)
		STA	z:2,X

loc_C7258A:
		REP	#$20
.A16
		INC	z:$30,X
		LDA	z:$30,X
		CMP	#$80
		BNE	loc_C725AE
		STZ	z:$30,X
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		AND	#$F7
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		REP	#$20
.A16
		LDA	#.LOWORD(bigaron_main)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(bigaron_main)
		STA	z:2,X

loc_C725AE:
		JSL	f:advance_animation

locret_C725B2:
		RTL
; End of function bigaron_intro

.A8
.I16

bigaron_main:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C725C0
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C725C0:
		BIT	#$41
		BEQ	loc_C725C8
		JML	f:bigaron_advance_animation
; ---------------------------------------------------------------------------

loc_C725C8:
		SEP	#$20
		LDA	z:$36,X
		BEQ	loc_C725D2
		JML	f:bigaron_hurt
; ---------------------------------------------------------------------------

loc_C725D2:
		REP	#$20
.A16
		DEC	z:$34,X
		BNE	loc_C725DC
		JML	f:sub_C726B9
; ---------------------------------------------------------------------------

loc_C725DC:
		LDY	#.LOWORD(player1_object)
		LDA	a:.LOWORD(4),Y
		BIT	#1
		BEQ	loc_C725FB
		LDA	#$B0B
		STA	z:$42
		LDA	#$130
		STA	z:$44
		JSL	f:sub_C6359F
		BCC	loc_C725FB
		JML	f:loc_C726C7
; ---------------------------------------------------------------------------

loc_C725FB:
		REP	#$20
		LDY	#.LOWORD(player2_object)
		LDA	a:.LOWORD(4),Y
		BIT	#1
		BEQ	loc_C7261C
		LDA	#$B0B
		STA	z:$42
		LDA	#$130
		STA	z:$44
		JSL	f:sub_C6359F
		BCC	loc_C7261C
		JML	f:loc_C726C7
; ---------------------------------------------------------------------------

loc_C7261C:
		SEP	#$20
.A8
		STZ	z:$27,X

loc_C72620:
		JSL	f:bigaron_straighten
		BCC	loc_C72634
		SEP	#$20
		BIT	#$20
		BEQ	loc_C72640
		LDA	z:enemy::direction,X
		EOR	#2
		STA	z:enemy::direction,X
		BRA	sub_C72644
; ---------------------------------------------------------------------------

loc_C72634:
		JSL	f:is_object_aligned
		BCS	sub_C72644
		SEP	#$20
		DEC	z:$33,X
		BPL	sub_C72644

loc_C72640:
		JSL	f:bigaron_movement
; End of function bigaron_main

.A8
.I16

sub_C72644:
		REP	#$20
.A16
		LDA	#$808
		STA	z:$42
		LDA	#$1002
		STA	z:$44
.A8

loc_C72650:
		JSL	f:sub_C6353D
		REP	#$20
.A16
		LDA	#$2020
		STA	z:$42
		LDA	#$1010
		STA	z:$44
		JSL	f:sub_C6370B
		BCS	loc_C7266A
		JML	f:bigaron_advance_animation
; ---------------------------------------------------------------------------

loc_C7266A:
		SEP	#$20
.A8
		LDA	z:$36,X
		BNE	bigaron_advance_animation
		LDA	#$40
		STA	z:$36,X
		DEC	z:$32,X
		BNE	bigaron_advance_animation
		JML	f:sub_C72842
; ---------------------------------------------------------------------------

bigaron_advance_animation:
		JSL	f:advance_animation
		RTL
; End of function sub_C72644

.A8
.I16

bigaron_hurt:
		SEP	#$20
		LDA	z:$36,X
		DEC	z:$36,X
; End of function bigaron_hurt

.A16
.I16

_bigaron_hurt:
		SEP	#$20
.A8
		PHX
		LDX	#0
		BIT	#1
		BNE	loc_C72694
		LDX	#2

loc_C72694:
		LDY	#0
		LDA	f:bigaron_palettes,X
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		LDA	f:bigaron_palettes+1,X
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		PLX
		JSL	f:advance_animation_2
		RTL
; End of function _bigaron_hurt

; ---------------------------------------------------------------------------
bigaron_palettes:.BYTE BIGARON_PALETTE_1, BIGARON_PALETTE_2
		.BYTE BIGARON_FIRE_PALETTE, BIGARON_FIRE_PALETTE
.A16
.I16

sub_C726B9:
		JSL	f:random2
		REP	#$20
		AND	#$FF
		ORA	#$100
		STA	z:$34,X

loc_C726C7:
		SEP	#$20
.A8
		LDA	z:$27,X
		BEQ	loc_C726D1
		JML	f:loc_C72620
; ---------------------------------------------------------------------------

loc_C726D1:
		INC	z:$27,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C723AF)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C726F1)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C726F1)
		STA	z:2,X

loc_C726F1:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C726FE
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C726FE:
		BIT	#$41
		BEQ	loc_C72706
		JML	f:bigaron_advance_animation
; ---------------------------------------------------------------------------

loc_C72706:
		SEP	#$20
		LDA	z:$36,X
		BEQ	loc_C72710
		JML	f:bigaron_hurt
; ---------------------------------------------------------------------------

loc_C72710:
		REP	#$20
.A16
		LDA	z:$C,X
		CMP	#$3003
		BNE	loc_C72735
		REP	#$20
		LDA	#.LOWORD(unk_C72B30)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_C72B30)
		STA	z:$52
		JSL	f:sub_C72916
		JSL	f:sub_C729AD
		LDY	#$13
		JSL	f:play_sound

loc_C72735:
		REP	#$20
.A16
		LDA	#$808
		STA	z:$42
		LDA	#$1030
		STA	z:$44
		SEP	#$20
.A8
		LDA	z:$C,X
		CMP	#3
		BNE	loc_C7274D
		JML	f:loc_C72650
; ---------------------------------------------------------------------------

loc_C7274D:
		JSL	f:sub_C72644
		BCC	locret_C72777
		SEP	#$20
		LDA	z:$32,X
		BEQ	locret_C72777
		REP	#$20
.A16
		LDA	#.LOWORD(bigaron_static_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(bigaron_main)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(bigaron_main)
		STA	z:2,X

locret_C72777:
		RTL
; End of function sub_C726B9

.A8
.I16

bigaron_movement:
		SEP	#$20
		LDA	z:$26,X
		BNE	loc_C72799
		JSL	f:follower_movement_2
		REP	#$20
.A16
		LDA	#3
		STA	z:$44
		LDA	z:enemy::x_position,X
		CMP	a:.LOWORD(player::x_position),Y
		BEQ	loc_C727D6
		BCS	loc_C727B2
		LDA	#1
		STA	z:$44
		BRA	loc_C727B2
; ---------------------------------------------------------------------------

loc_C72799:
		JSL	f:follower_movement_2
		REP	#$20
		LDA	#0
		STA	z:$44
		LDA	z:enemy::y_position,X
		CMP	a:.LOWORD(player::y_position),Y
		BEQ	loc_C727D6
		BCS	loc_C727B2
		LDA	#2
		STA	z:$44

loc_C727B2:
		REP	#$20
		LDA	z:$20,X
		PHA
		LDA	z:$44
		STA	z:$20,X
		LDA	#BOMB|SOFT_BLOCK|HARD_BLOCK
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		REP	#$20
		BNE	loc_C727DF
		PLA
		JSL	f:random2
		SEP	#enemy::direction
.A8
		AND	#3
		CLC
		ADC	#3
		STA	z:$33,X

loc_C727D6:
		SEP	#enemy::direction
		LDA	z:$26,X
		EOR	#1
		STA	z:$26,X
		RTL
; ---------------------------------------------------------------------------

loc_C727DF:
		PLA
		STA	z:enemy::direction,X
		RTL
; End of function bigaron_movement

.A8
.I16

bigaron_straighten:
		REP	#$20
.A16
		LDA	#BOMB|SOFT_BLOCK|HARD_BLOCK
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		BNE	loc_C72840
		SEP	#$20
.A8
		LDA	#.BANKBYTE(vectors_for_speed_and_direction)
		STA	z:$55
		REP	#$20
.A16
		LDA	z:$20,X
		AND	#$F
		ASL
		ASL
		CLC
		ADC	#.LOWORD(vectors_for_speed_and_direction)
		STA	z:$53
		LDA	z:$20,X
		BIT	#1
		BNE	loc_C72826
		JSL	f:straighten_x
		REP	#$20
		LDA	z:$10,X
		CLC
		ADC	[$53]
		STA	z:$10,X
		INC	z:$53
		INC	z:$53
		LDA	z:$13,X
		CLC
		ADC	[$53]
		STA	z:$13,X
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C72826:
		JSL	f:straighten_y
		REP	#$20
		LDA	z:$10,X
		CLC
		ADC	[$53]
		STA	z:$10,X
		INC	z:$53
		INC	z:$53
		LDA	z:$13,X
		CLC
		ADC	[$53]
		STA	z:$13,X
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C72840:
		SEC
		RTL
; End of function bigaron_straighten


; End of function sub_C727E3

.A8
.I16

sub_C72842:
		SEP	#$20
		PHX
		LDX	#.LOWORD(player1_object)
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	z:$20,X
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		SEP	#$20
		LDX	#.LOWORD(player2_object)
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	z:$20,X
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		PLX
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		LDA	#$181
		STA	z:$30,X
		REP	#$20
		LDA	#.LOWORD(unk_C72B50)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_C72B50)
		STA	z:$52
		JSL	f:sub_C631D7
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C72894)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C72894)
		STA	z:2,X

loc_C72894:
		REP	#$20
.A16
		DEC	z:$30,X
		LDA	z:$30,X
		BEQ	loc_C728A0
		JML	f:_bigaron_hurt
; ---------------------------------------------------------------------------

loc_C728A0:
		LDA	#.LOWORD(byte_C723C4)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C728C3)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C728C3)
		STA	z:2,X
		LDY	#$18
		JSL	f:play_sound

loc_C728C3:
		JSL	f:advance_animation
		BCC	locret_C72915
		REP	#$20
.A16
		PHX
		LDX	#.LOWORD(player1_object)
		LDA	#0
		STA	z:$40
		LDA	#1
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		LDX	#.LOWORD(player2_object)
		LDA	#0
		STA	z:$40
		LDA	#1
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		PLX
		REP	#$20
		LDA	#.LOWORD(loc_C72902)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C72902)
		STA	z:2,X
		SEP	#$20
		LDA	#$80
		STA	z:$30,X

loc_C72902:
		SEP	#$20
		DEC	z:$30,X
		BNE	locret_C72915
		LDA	#$39
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		JSL	f:fade_out_music
		JSL	f:delete_object

locret_C72915:
		RTL
; End of function sub_C72842

.A8
.I16

sub_C72916:
		SEP	#$20
		LDA	#.LOBYTE(sub_C7294D)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C7294D)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C7294D)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCS	locret_C7294C
		REP	#$20
.A16
		LDA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		STA	a:.LOWORD($30),Y
		LDA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		STA	a:.LOWORD($32),Y
		LDA	#1
		STA	a:.LOWORD($20),Y
		LDA	z:$50
		STA	a:.LOWORD($34),Y
		LDA	z:$51
		STA	a:.LOWORD($35),Y

locret_C7294C:
		RTL
; End of function sub_C72916

.A16
.I16

sub_C7294D:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C7295A
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C7295A:
		BIT	#$41
		BEQ	loc_C72962
		JML	f:locret_C729AC
; ---------------------------------------------------------------------------

loc_C72962:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	locret_C729AC
		LDA	z:$30,X
		STA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		LDA	z:$32,X
		STA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		LDA	z:$34,X
		STA	z:$50
		LDA	z:$35,X
		STA	z:$51
		INC	z:$34,X
		INC	z:$34,X
		INC	z:$34,X
		INC	z:$34,X
		INC	z:$34,X
		INC	z:$34,X
		INC	z:$34,X
		INC	z:$34,X
		LDY	#2
		LDA	[$50],Y
		CLC
		ADC	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		STA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		LDY	#4
		LDA	[$50],Y
		CLC
		ADC	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		STA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		LDA	[$50]
		STA	z:$20,X
		BNE	locret_C729AC
		JSL	f:delete_object
.A8

locret_C729AC:
		RTL
; End of function sub_C7294D

.A8
.I16

sub_C729AD:
		JSL	f:random2
		REP	#$20
.A16
		AND	#3
		CLC
		ADC	#4
		STA	z:$40

loc_C729BC:
		JSL	f:sub_C729C5
		DEC	z:$40
		BNE	loc_C729BC
		RTL
; End of function sub_C729AD

.A16
.I16

sub_C729C5:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C729EE)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C729EE)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C729EE)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	locret_C729ED
		LDA	z:$11,X
		STA	a:.LOWORD($11),Y
		LDA	z:$14,X
		CLC
		ADC	#$40
		STA	a:.LOWORD($14),Y

locret_C729ED:
		RTL
; End of function sub_C729C5

.A16
.I16

sub_C729EE:
		REP	#$20
		LDA	#$430
		STA	z:$E,X
		LDA	#0
		STA	z:$1E,X
		LDA	#$20
		STA	z:$18,X
		LDA	#0
		STA	z:$38,X
		JSL	f:random2
		REP	#$20
		AND	#$1FF
		CLC
		ADC	#$FC00
		STA	z:$16,X
		JSL	f:random2
		REP	#$20
		AND	#$1FF
		CLC
		ADC	#$FF00
		STA	z:$1A,X
		JSL	f:random2
		REP	#$20
		AND	#$F
		CLC
		ADC	#$10
		STA	z:$30,X
		LDA	#.LOWORD(byte_C723F1)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C72A4D)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C72A4D)
		STA	z:2,X

loc_C72A4D:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C72A5A
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C72A5A:
		BIT	#$41
		BEQ	loc_C72A62
		JML	f:loc_C72AEA
; ---------------------------------------------------------------------------

loc_C72A62:
		REP	#$20
.A16
		STZ	z:$40
		LDA	z:$16,X
		CLC
		ADC	z:$18,X
		STA	z:$16,X
		BPL	loc_C72A71
		DEC	z:$40

loc_C72A71:
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		SEP	#$20
.A8
		LDA	z:$15,X
		ADC	z:$40
		STA	z:$15,X
		REP	#$20
.A16
		STZ	z:$40
		LDA	z:$1A,X
		BPL	loc_C72A88
		DEC	z:$40

loc_C72A88:
		CLC
		ADC	z:$10,X
		STA	z:$10,X
		SEP	#$20
.A8
		LDA	z:$12,X
		ADC	z:$40
		STA	z:$12,X
		REP	#$20
.A16
		LDA	z:$16,X
		BMI	loc_C72AEA
		DEC	z:$30,X
		BNE	loc_C72AEA
		LDA	z:$38,X
		BEQ	loc_C72AA7
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C72AA7:
		INC	z:$38,X
		LDA	#$10
		STA	z:$18,X
		JSL	f:random2
		REP	#$20
		AND	#$7F
		CLC
		ADC	#$FE80
		STA	z:$16,X
		JSL	f:random2
		REP	#$20
		AND	#$7F
		CLC
		ADC	#$FFC0
		STA	z:$1A,X
		JSL	f:random2
		REP	#$20
		AND	#$F
		CLC
		ADC	#8
		STA	z:$30,X
		LDA	#.LOWORD(byte_C723F6)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation

loc_C72AEA:
		REP	#$20
.A16
		LDA	#$808
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:load_animation_frame
		RTL
; End of function sub_C729EE

; ---------------------------------------------------------------------------
		.BYTE	0
		.BYTE $FF
		.BYTE $50
		.BYTE	0
		.BYTE $20
		.BYTE	0
		.BYTE $80
		.BYTE	0
		.BYTE	0
		.BYTE $FB
		.BYTE	0
		.BYTE $FC
		.BYTE	0
		.BYTE $FD
		.BYTE	0
		.BYTE $FE
		.BYTE	4
		.BYTE	0
		.BYTE	8
		.BYTE	0
		.BYTE  $C
		.BYTE	0
		.BYTE $10
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $80
		.BYTE	0
		.BYTE	0
		.BYTE	1
		.BYTE $80
		.BYTE	1
		.BYTE	0
		.BYTE	0
		.BYTE $80
		.BYTE $FF
		.BYTE	0
		.BYTE $FF
		.BYTE $80
		.BYTE $FE
		.BYTE	0
		.BYTE $FF
		.BYTE	8
		.BYTE	0
		.BYTE	0
		.BYTE	0
off_C72B28:	.ADDR bigaron_static_animation,	bigaron_static_animation
		.ADDR bigaron_static_animation,	bigaron_static_animation
unk_C72B30:	.BYTE	6
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $FD
		.BYTE $FF
		.BYTE	0
		.BYTE	0
		.BYTE	3
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	3
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	2
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	1
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
unk_C72B50:	.BYTE $3F
		.BYTE	0
		.BYTE $3F
		.BYTE	0
		.BYTE $81
		.BYTE	1
		.BYTE	3
		.BYTE	0
animation_frame_C72B58:.BYTE $24
		frame_oam_tile $30, $ED, $3106, 0
		frame_oam_tile $30, $D5, $2006, 0
		frame_oam_tile $30, $DD, 3, $20
		frame_oam_tile $C8, $ED, $3106, $40
		frame_oam_tile $C8, $D5, $2006, $40
		frame_oam_tile $C0, $DD, 3, $60
		frame_oam_tile $F0, $FD, $2404, $64
		frame_oam_tile $F0, $ED, $404,	$64
		frame_oam_tile $F0, $DD, $2402, $62
		frame_oam_tile $F0, $CD, $402,	$62
		frame_oam_tile $F0, $BD, $2400, $62
		frame_oam_tile $F0, $AD, $400,	$62
		frame_oam_tile $E0, $FD, $2604, $64
		frame_oam_tile $E0, $ED, $604,	$64
		frame_oam_tile $E0, $DD, $2602, $62
		frame_oam_tile $E0, $CD, $602,	$62
		frame_oam_tile $E0, $BD, $2600, $62
		frame_oam_tile $E0, $AD, $600,	$62
		frame_oam_tile $D0, $ED, $2005, $60
		frame_oam_tile $D0, $DD, 5, $60
		frame_oam_tile $D0, $CD, $2003, $60
		frame_oam_tile $20, $ED, $2005, $20
		frame_oam_tile $20, $DD, 5, $20
		frame_oam_tile $20, $CD, $2003, $20
		frame_oam_tile $10, $FD, $2604, $24
		frame_oam_tile 0, $FD,	$2404, $24
		frame_oam_tile $10, $ED, $604,	$24
		frame_oam_tile 0, $ED,	$404, $24
		frame_oam_tile $10, $DD, $2602, $22
		frame_oam_tile 0, $DD,	$2402, $22
		frame_oam_tile $10, $CD, $602,	$22
		frame_oam_tile 0, $CD,	$402, $22
		frame_oam_tile $10, $BD, $2600, $24
		frame_oam_tile 0, $BD,	$2400, $22
		frame_oam_tile $10, $AD, $600,	$22
		frame_oam_tile 0, $AD,	$400, $22
animation_frame_C72C0D:.BYTE $24
		frame_oam_tile $10, $AD, $401,	$62
		frame_oam_tile $E0, $AD, $401,	$22
		frame_oam_tile 0, $AD,	$601, $62
		frame_oam_tile $F0, $AD, $601,	$22
		frame_oam_tile $F0, $BD, $2601, $22
		frame_oam_tile 0, $BD,	$2601, $62
		frame_oam_tile $10, $BD, $2401, $62
		frame_oam_tile $E0, $BD, $2401, $22
		frame_oam_tile $30, $ED, $3106, 0
		frame_oam_tile $30, $D5, $2006, 0
		frame_oam_tile $30, $DD, 3, $20
		frame_oam_tile $C8, $ED, $3106, $40
		frame_oam_tile $C8, $D5, $2006, $40
		frame_oam_tile $C0, $DD, 3, $60
		frame_oam_tile $F0, $FD, $2404, $64
		frame_oam_tile $F0, $ED, $404,	$64
		frame_oam_tile $F0, $DD, $2402, $62
		frame_oam_tile $F0, $CD, $402,	$62
		frame_oam_tile $E0, $FD, $2604, $64
		frame_oam_tile $E0, $ED, $604,	$64
		frame_oam_tile $E0, $DD, $2602, $62
		frame_oam_tile $E0, $CD, $602,	$62
		frame_oam_tile $D0, $ED, $2005, $60
		frame_oam_tile $D0, $DD, 5, $60
		frame_oam_tile $D0, $CD, $2003, $60
		frame_oam_tile $20, $ED, $2005, $20
		frame_oam_tile $20, $DD, 5, $20
		frame_oam_tile $20, $CD, $2003, $20
		frame_oam_tile $10, $FD, $2604, $24
		frame_oam_tile 0, $FD,	$2404, $24
		frame_oam_tile $10, $ED, $604,	$24
		frame_oam_tile 0, $ED,	$404, $24
		frame_oam_tile $10, $DD, $2602, $22
		frame_oam_tile 0, $DD,	$2402, $22
		frame_oam_tile $10, $CD, $602,	$22
		frame_oam_tile 0, $CD,	$402, $22
animation_frame_C72CC2:.BYTE 1
		frame_oam_tile $F8, $F8, $407,	$20
animation_frame_C72CC8:.BYTE $24
animation_frame_C72CC9:frame_oam_tile $10, $AD, $401, $64
		frame_oam_tile 0, $AD,	$601, $64
		frame_oam_tile $F0, $AD, $601,	$24
		frame_oam_tile $E0, $AD, $401,	$24
		frame_oam_tile 0, $BD,	$2601, $64
		frame_oam_tile $F0, $BD, $2601, $24
		frame_oam_tile $10, $BD, $2401, $64
		frame_oam_tile $E0, $BD, $2401, $24
		frame_oam_tile $10, $FD, $1707, $44
		frame_oam_tile $E8, $FD, $1707, 4
		frame_oam_tile 0, $FD,	$2607, $64
		frame_oam_tile $F0, $FD, $2607, $24
		frame_oam_tile $10, $ED, $403,	$64
		frame_oam_tile $E0, $ED, $403,	$24
		frame_oam_tile 0, $ED,	$603, $64
		frame_oam_tile $F0, $ED, $603,	$24
		frame_oam_tile $30, $ED, $3106, 0
		frame_oam_tile $30, $D5, $2006, 0
		frame_oam_tile $30, $DD, 3, $20
		frame_oam_tile $C8, $ED, $3106, $40
		frame_oam_tile $C8, $D5, $2006, $40
		frame_oam_tile $C0, $DD, 3, $60
		frame_oam_tile $F0, $DD, $2402, $62
		frame_oam_tile $F0, $CD, $402,	$62
		frame_oam_tile $E0, $DD, $2602, $62
		frame_oam_tile $E0, $CD, $602,	$62
		frame_oam_tile $D0, $ED, $2005, $60
		frame_oam_tile $D0, $DD, 5, $60
		frame_oam_tile $D0, $CD, $2003, $60
		frame_oam_tile $20, $ED, $2005, $20
		frame_oam_tile $20, $DD, 5, $20
		frame_oam_tile $20, $CD, $2003, $20
		frame_oam_tile $10, $DD, $2602, $22
		frame_oam_tile 0, $DD,	$2402, $22
		frame_oam_tile $10, $CD, $602,	$22
		frame_oam_tile 0, $CD,	$402, $22
animation_frame_C72D7D:.BYTE $24
		frame_oam_tile $C8, $E9, $3106, $40
		frame_oam_tile $C8, $D1, $2006, $40
		frame_oam_tile $C0, $D9, 3, $60
		frame_oam_tile $30, $E9, $3106, 0
		frame_oam_tile $30, $D1, $2006, 0
		frame_oam_tile $30, $D9, 3, $20
		frame_oam_tile $D0, $E9, $2005, $60
		frame_oam_tile $D0, $D9, 5, $60
		frame_oam_tile $D0, $C9, $2003, $60
		frame_oam_tile $20, $E9, $2005, $20
		frame_oam_tile $20, $D9, 5, $20
		frame_oam_tile $20, $C9, $2003, $20
		frame_oam_tile $10, $F9, $2004, $64
		frame_oam_tile $10, $E9, 4, $64
		frame_oam_tile $10, $D9, $2002, $62
		frame_oam_tile $10, $C9, 2, $64
		frame_oam_tile $10, $B9, $2000, $62
		frame_oam_tile $10, $A9, 0, $64
		frame_oam_tile 0, $F9,	$2204, $64
		frame_oam_tile 0, $E9,	$204, $64
		frame_oam_tile 0, $D9,	$2202, $62
		frame_oam_tile 0, $C9,	$202, $62
		frame_oam_tile 0, $B9,	$2200, $64
		frame_oam_tile 0, $A9,	$200, $62
		frame_oam_tile $F0, $F9, $2204, $24
		frame_oam_tile $E0, $F9, $2004, $24
		frame_oam_tile $F0, $E9, $204,	$24
		frame_oam_tile $E0, $E9, 4, $24
		frame_oam_tile $F0, $D9, $2202, $22
		frame_oam_tile $E0, $D9, $2002, $24
		frame_oam_tile $F0, $C9, $202,	$22
		frame_oam_tile $E0, $C9, 2, $22
		frame_oam_tile $F0, $B9, $2200, $22
		frame_oam_tile $E0, $B9, $2000, $24
		frame_oam_tile $F0, $A9, $200,	$22
		frame_oam_tile $E0, $A9, 0, $22
animation_frame_C72E32:.BYTE $28
		frame_oam_tile $10, 0,	$2106, $44
		frame_oam_tile $E8, 0,	$2106, 4
		frame_oam_tile $30, $E1, $3106, 0
		frame_oam_tile $30, $C8, $2006, 0
		frame_oam_tile $30, $D0, 3, $20
		frame_oam_tile $C8, $E1, $3106, $40
		frame_oam_tile $C8, $C8, $2006, $40
		frame_oam_tile $C0, $D0, 3, $60
		frame_oam_tile $10, $F0, 6, $64
		frame_oam_tile 0, 0, $2206, $64
		frame_oam_tile 0, $F0,	$206, $64
		frame_oam_tile $F0, 0,	$2206, $24
		frame_oam_tile $F0, $F0, $206,	$24
		frame_oam_tile $E0, $F0, 6, $24
		frame_oam_tile $D0, $E0, $2005, $60
		frame_oam_tile $D0, $D0, 5, $60
		frame_oam_tile $D0, $C0, $2003, $60
		frame_oam_tile $20, $E0, $2005, $20
		frame_oam_tile $20, $D0, 5, $20
		frame_oam_tile $20, $C0, $2003, $20
		frame_oam_tile $10, $E0, 4, $64
		frame_oam_tile $10, $D0, $2002, $62
		frame_oam_tile $10, $C0, 2, $64
		frame_oam_tile $10, $B0, $2000, $62
		frame_oam_tile $10, $A0, 0, $64
		frame_oam_tile 0, $E0,	$204, $64
		frame_oam_tile 0, $D0,	$2202, $62
		frame_oam_tile 0, $C0,	$202, $62
		frame_oam_tile 0, $B0,	$2200, $64
		frame_oam_tile 0, $A0,	$200, $62
		frame_oam_tile $F0, $E0, $204,	$24
		frame_oam_tile $E0, $E0, 4, $24
		frame_oam_tile $F0, $D0, $2202, $22
		frame_oam_tile $E0, $D0, $2002, $24
		frame_oam_tile $F0, $C0, $202,	$22
		frame_oam_tile $E0, $C0, 2, $22
		frame_oam_tile $F0, $B0, $2200, $22
		frame_oam_tile $E0, $B0, $2000, $24
		frame_oam_tile $F0, $A0, $200,	$22
		frame_oam_tile $E0, $A0, 0, $22
animation_frame_C72EFB:.BYTE $28
		frame_oam_tile $10, $FD, $3006, $44
		frame_oam_tile $10, $ED, $2001, $64
		frame_oam_tile $10, $DD, 1, $64
		frame_oam_tile 0, $FD,	$203, $64
		frame_oam_tile 0, $ED,	$2201, $64
		frame_oam_tile 0, $DD,	$201, $64
		frame_oam_tile $E8, $FD, $3006, 4
		frame_oam_tile 0, $CD,	$2202, $64
		frame_oam_tile $F0, $CD, $2202, $24
		frame_oam_tile $30, $DD, $3106, 0
		frame_oam_tile $30, $C5, $2006, 0
		frame_oam_tile $30, $CD, 3, $20
		frame_oam_tile $C8, $DD, $3106, $40
		frame_oam_tile $C8, $C5, $2006, $40
		frame_oam_tile $C0, $CD, 3, $60
		frame_oam_tile $10, $CD, $405,	$62
		frame_oam_tile $10, $BD, $2403, $62
		frame_oam_tile 0, $BD,	$2603, $62
		frame_oam_tile $F0, $FD, $203,	$24
		frame_oam_tile $F0, $ED, $2201, $24
		frame_oam_tile $E0, $ED, $2001, $24
		frame_oam_tile $F0, $DD, $201,	$24
		frame_oam_tile $E0, $DD, 1, $24
		frame_oam_tile $E0, $CD, $405,	$22
		frame_oam_tile $F0, $BD, $2603, $22
		frame_oam_tile $E0, $BD, $2403, $22
		frame_oam_tile $D0, $DD, $2005, $60
		frame_oam_tile $D0, $CD, 5, $60
		frame_oam_tile $D0, $BD, $2003, $60
		frame_oam_tile $20, $DD, $2005, $20
		frame_oam_tile $20, $CD, 5, $20
		frame_oam_tile $20, $BD, $2003, $20
		frame_oam_tile $10, $AD, $2000, $62
		frame_oam_tile $10, $9D, 0, $62
		frame_oam_tile 0, $AD,	$2200, $64
		frame_oam_tile 0, $9D,	$200, $62
		frame_oam_tile $F0, $AD, $2200, $22
		frame_oam_tile $E0, $AD, $2000, $22
		frame_oam_tile $F0, $9D, $200,	$22
		frame_oam_tile $E0, $9D, 0, $22
animation_frame_C72FC4:.BYTE $28
		frame_oam_tile 0, $F0,	$2201, $64
		frame_oam_tile 0, $E0,	$201, $64
		frame_oam_tile 0, $D0,	$2207, $64
		frame_oam_tile $10, 0,	$3006, $44
		frame_oam_tile $E8, 0,	$3006, 4
		frame_oam_tile $30, $E0, $3106, 0
		frame_oam_tile $30, $C8, $2006, 0
		frame_oam_tile $30, $D0, 3, $20
		frame_oam_tile $C8, $E0, $3106, $40
		frame_oam_tile $C8, $C8, $2006, $40
		frame_oam_tile $C0, $D0, 3, $60
		frame_oam_tile $F0, $E0, $2405, $24
		frame_oam_tile $10, $B0, $2406, $62
		frame_oam_tile $10, $A0, $406,	$64
		frame_oam_tile 0, $B0,	$2606, $62
		frame_oam_tile 0, $A0,	$606, $62
		frame_oam_tile $F0, $B0, $2606, $22
		frame_oam_tile $E0, $B0, $2406, $24
		frame_oam_tile $F0, $A0, $606,	$24
		frame_oam_tile $E0, $A0, $406,	$22
		frame_oam_tile $10, $D0, $2007, $62
		frame_oam_tile $10, $C0, 7, $62
		frame_oam_tile 0, $C0,	$207, $62
		frame_oam_tile $F0, $D0, $2207, $22
		frame_oam_tile $E0, $D0, $2007, $22
		frame_oam_tile $F0, $C0, $207,	$22
		frame_oam_tile $E0, $C0, 7, $22
		frame_oam_tile $10, $F0, $2001, $64
		frame_oam_tile $10, $E0, 1, $64
		frame_oam_tile 0, 0, $203, $64
		frame_oam_tile $F0, 0,	$203, $24
		frame_oam_tile $F0, $F0, $2201, $24
		frame_oam_tile $E0, $F0, $2001, $24
		frame_oam_tile $E0, $E0, 1, $24
		frame_oam_tile $D0, $E0, $2005, $60
		frame_oam_tile $D0, $D0, 5, $60
		frame_oam_tile $D0, $C0, $2003, $60
		frame_oam_tile $20, $E0, $2005, $20
		frame_oam_tile $20, $D0, 5, $20
		frame_oam_tile $20, $C0, $2003, $20
animation_frame_C7308D:.BYTE $24
		frame_oam_tile $30, $ED, $3106, 6
		frame_oam_tile $30, $D5, $2006, 6
		frame_oam_tile $30, $DD, 3, $26
		frame_oam_tile $C8, $ED, $3106, $46
		frame_oam_tile $C8, $D5, $2006, $46
		frame_oam_tile $C0, $DD, 3, $66
		frame_oam_tile $F0, $FD, $2404, $66
		frame_oam_tile $F0, $ED, $404,	$66
		frame_oam_tile $F0, $DD, $2402, $66
		frame_oam_tile $F0, $CD, $402,	$66
		frame_oam_tile $F0, $BD, $2400, $66
		frame_oam_tile $F0, $AD, $400,	$66
		frame_oam_tile $E0, $FD, $2604, $66
		frame_oam_tile $E0, $ED, $604,	$66
		frame_oam_tile $E0, $DD, $2602, $66
		frame_oam_tile $E0, $CD, $602,	$66
		frame_oam_tile $E0, $BD, $2600, $66
		frame_oam_tile $E0, $AD, $600,	$66
		frame_oam_tile $D0, $ED, $2005, $66
		frame_oam_tile $D0, $DD, 5, $66
		frame_oam_tile $D0, $CD, $2003, $66
		frame_oam_tile $20, $ED, $2005, $26
		frame_oam_tile $20, $DD, 5, $26
		frame_oam_tile $20, $CD, $2003, $26
		frame_oam_tile $10, $FD, $2604, $26
		frame_oam_tile 0, $FD,	$2404, $26
		frame_oam_tile $10, $ED, $604,	$26
		frame_oam_tile 0, $ED,	$404, $26
		frame_oam_tile $10, $DD, $2602, $26
		frame_oam_tile 0, $DD,	$2402, $26
		frame_oam_tile $10, $CD, $602,	$26
		frame_oam_tile 0, $CD,	$402, $26
		frame_oam_tile $10, $BD, $2600, $26
		frame_oam_tile 0, $BD,	$2400, $26
		frame_oam_tile $10, $AD, $600,	$26
		frame_oam_tile 0, $AD,	$400, $26
animation_frame_C73142:.BYTE $24
		frame_oam_tile $C8, $E9, $3106, $46
		frame_oam_tile $C8, $D1, $2006, $46
		frame_oam_tile $C0, $D9, 3, $66
		frame_oam_tile $30, $E9, $3106, 6
		frame_oam_tile $30, $D1, $2006, 6
		frame_oam_tile $30, $D9, 3, $26
		frame_oam_tile $D0, $E9, $2005, $66
		frame_oam_tile $D0, $D9, 5, $66
		frame_oam_tile $D0, $C9, $2003, $66
		frame_oam_tile $20, $E9, $2005, $26
		frame_oam_tile $20, $D9, 5, $26
		frame_oam_tile $20, $C9, $2003, $26
		frame_oam_tile $10, $F9, $2004, $66
		frame_oam_tile $10, $E9, 4, $66
		frame_oam_tile $10, $D9, $2002, $66
		frame_oam_tile $10, $C9, 2, $66
		frame_oam_tile $10, $B9, $2000, $66
		frame_oam_tile $10, $A9, 0, $66
		frame_oam_tile 0, $F9,	$2204, $66
		frame_oam_tile 0, $E9,	$204, $66
		frame_oam_tile 0, $D9,	$2202, $66
		frame_oam_tile 0, $C9,	$202, $66
		frame_oam_tile 0, $B9,	$2200, $66
		frame_oam_tile 0, $A9,	$200, $66
		frame_oam_tile $F0, $F9, $2204, $26
		frame_oam_tile $E0, $F9, $2004, $26
		frame_oam_tile $F0, $E9, $204,	$26
		frame_oam_tile $E0, $E9, 4, $26
		frame_oam_tile $F0, $D9, $2202, $26
		frame_oam_tile $E0, $D9, $2002, $26
		frame_oam_tile $F0, $C9, $202,	$26
		frame_oam_tile $E0, $C9, 2, $26
		frame_oam_tile $F0, $B9, $2200, $26
		frame_oam_tile $E0, $B9, $2000, $26
		frame_oam_tile $F0, $A9, $200,	$26
		frame_oam_tile $E0, $A9, 0, $26
animation_frame_C731F7:.BYTE $28
		frame_oam_tile $10, 0,	$2106, $46
		frame_oam_tile $E8, 0,	$2106, 6
		frame_oam_tile $30, $E1, $3106, 6
		frame_oam_tile $30, $C8, $2006, 6
		frame_oam_tile $30, $D0, 3, $26
		frame_oam_tile $C8, $E1, $3106, $46
		frame_oam_tile $C8, $C8, $2006, $46
		frame_oam_tile $C0, $D0, 3, $66
		frame_oam_tile $10, $F0, 6, $66
		frame_oam_tile 0, 0, $2206, $66
		frame_oam_tile 0, $F0,	$206, $66
		frame_oam_tile $F0, 0,	$2206, $26
		frame_oam_tile $F0, $F0, $206,	$26
		frame_oam_tile $E0, $F0, 6, $26
		frame_oam_tile $D0, $E0, $2005, $66
		frame_oam_tile $D0, $D0, 5, $66
		frame_oam_tile $D0, $C0, $2003, $66
		frame_oam_tile $20, $E0, $2005, $26
		frame_oam_tile $20, $D0, 5, $26
		frame_oam_tile $20, $C0, $2003, $26
		frame_oam_tile $10, $E0, 4, $66
		frame_oam_tile $10, $D0, $2002, $66
		frame_oam_tile $10, $C0, 2, $66
		frame_oam_tile $10, $B0, $2000, $66
		frame_oam_tile $10, $A0, 0, $66
		frame_oam_tile 0, $E0,	$204, $66
		frame_oam_tile 0, $D0,	$2202, $66
		frame_oam_tile 0, $C0,	$202, $66
		frame_oam_tile 0, $B0,	$2200, $66
		frame_oam_tile 0, $A0,	$200, $66
		frame_oam_tile $F0, $E0, $204,	$26
		frame_oam_tile $E0, $E0, 4, $26
		frame_oam_tile $F0, $D0, $2202, $26
		frame_oam_tile $E0, $D0, $2002, $26
		frame_oam_tile $F0, $C0, $202,	$26
		frame_oam_tile $E0, $C0, 2, $26
		frame_oam_tile $F0, $B0, $2200, $26
		frame_oam_tile $E0, $B0, $2000, $26
		frame_oam_tile $F0, $A0, $200,	$26
		frame_oam_tile $E0, $A0, 0, $26
animation_frame_C732C0:.BYTE $28
		frame_oam_tile $10, $FD, $3006, $46
		frame_oam_tile $10, $ED, $2001, $66
		frame_oam_tile $10, $DD, 1, $66
		frame_oam_tile 0, $FD,	$203, $66
		frame_oam_tile 0, $ED,	$2201, $66
		frame_oam_tile 0, $DD,	$201, $66
		frame_oam_tile $E8, $FD, $3006, 6
		frame_oam_tile 0, $CD,	$2202, $66
		frame_oam_tile $F0, $CD, $2202, $26
		frame_oam_tile $30, $DD, $3106, 6
		frame_oam_tile $30, $C5, $2006, 6
		frame_oam_tile $30, $CD, 3, $26
		frame_oam_tile $C8, $DD, $3106, $46
		frame_oam_tile $C8, $C5, $2006, $46
		frame_oam_tile $C0, $CD, 3, $66
		frame_oam_tile $10, $CD, $405,	$66
		frame_oam_tile $10, $BD, $2403, $66
		frame_oam_tile 0, $BD,	$2603, $66
		frame_oam_tile $F0, $FD, $203,	$26
		frame_oam_tile $F0, $ED, $2201, $26
		frame_oam_tile $E0, $ED, $2001, $26
		frame_oam_tile $F0, $DD, $201,	$26
		frame_oam_tile $E0, $DD, 1, $26
		frame_oam_tile $E0, $CD, $405,	$26
		frame_oam_tile $F0, $BD, $2603, $26
		frame_oam_tile $E0, $BD, $2403, $26
		frame_oam_tile $D0, $DD, $2005, $66
		frame_oam_tile $D0, $CD, 5, $66
		frame_oam_tile $D0, $BD, $2003, $66
		frame_oam_tile $20, $DD, $2005, $26
		frame_oam_tile $20, $CD, 5, $26
		frame_oam_tile $20, $BD, $2003, $26
		frame_oam_tile $10, $AD, $2000, $66
		frame_oam_tile $10, $9D, 0, $66
		frame_oam_tile 0, $AD,	$2200, $66
		frame_oam_tile 0, $9D,	$200, $66
		frame_oam_tile $F0, $AD, $2200, $26
		frame_oam_tile $E0, $AD, $2000, $26
		frame_oam_tile $F0, $9D, $200,	$26
		frame_oam_tile $E0, $9D, 0, $26
animation_frame_C73389:.BYTE $28
		frame_oam_tile 0, $F0,	$2201, $66
		frame_oam_tile 0, $E0,	$201, $66
		frame_oam_tile 0, $D0,	$2207, $66
		frame_oam_tile $10, 0,	$3006, $46
		frame_oam_tile $E8, 0,	$3006, 6
		frame_oam_tile $30, $E0, $3106, 6
		frame_oam_tile $30, $C8, $2006, 6
		frame_oam_tile $30, $D0, 3, $26
		frame_oam_tile $C8, $E0, $3106, $46
		frame_oam_tile $C8, $C8, $2006, $46
		frame_oam_tile $C0, $D0, 3, $66
		frame_oam_tile $F0, $E0, $2405, $26
		frame_oam_tile $10, $B0, $2406, $66
		frame_oam_tile $10, $A0, $406,	$66
		frame_oam_tile 0, $B0,	$2606, $66
		frame_oam_tile 0, $A0,	$606, $66
		frame_oam_tile $F0, $B0, $2606, $26
		frame_oam_tile $E0, $B0, $2406, $26
		frame_oam_tile $F0, $A0, $606,	$26
		frame_oam_tile $E0, $A0, $406,	$26
		frame_oam_tile $10, $D0, $2007, $66
		frame_oam_tile $10, $C0, 7, $66
		frame_oam_tile 0, $C0,	$207, $66
		frame_oam_tile $F0, $D0, $2207, $26
		frame_oam_tile $E0, $D0, $2007, $26
		frame_oam_tile $F0, $C0, $207,	$26
		frame_oam_tile $E0, $C0, 7, $26
		frame_oam_tile $10, $F0, $2001, $66
		frame_oam_tile $10, $E0, 1, $66
		frame_oam_tile 0, 0, $203, $66
		frame_oam_tile $F0, 0,	$203, $26
		frame_oam_tile $F0, $F0, $2201, $26
		frame_oam_tile $E0, $F0, $2001, $26
		frame_oam_tile $E0, $E0, 1, $26
		frame_oam_tile $D0, $E0, $2005, $66
		frame_oam_tile $D0, $D0, 5, $66
		frame_oam_tile $D0, $C0, $2003, $66
		frame_oam_tile $20, $E0, $2005, $26
		frame_oam_tile $20, $D0, 5, $26
		frame_oam_tile $20, $C0, $2003, $26
animation_frame_C73452:.BYTE $24
		frame_oam_tile $10, $AB, $401,	$64
		frame_oam_tile 0, $AB,	$601, $64
		frame_oam_tile $F0, $AB, $601,	$24
		frame_oam_tile $E0, $AB, $401,	$24
		frame_oam_tile 0, $BB,	$2601, $64
		frame_oam_tile $F0, $BB, $2601, $24
		frame_oam_tile $10, $BB, $2401, $64
		frame_oam_tile $E0, $BB, $2401, $24
		frame_oam_tile $10, $FB, $1707, $44
		frame_oam_tile $E8, $FB, $1707, 4
		frame_oam_tile 0, $FB,	$2607, $64
		frame_oam_tile $F0, $FB, $2607, $24
		frame_oam_tile $10, $EB, $403,	$64
		frame_oam_tile $E0, $EB, $403,	$24
		frame_oam_tile 0, $EB,	$603, $64
		frame_oam_tile $F0, $EB, $603,	$24
		frame_oam_tile $30, $EB, $3106, 0
		frame_oam_tile $30, $D3, $2006, 0
		frame_oam_tile $30, $DB, 3, $20
		frame_oam_tile $C8, $EB, $3106, $40
		frame_oam_tile $C8, $D3, $2006, $40
		frame_oam_tile $C0, $DB, 3, $60
		frame_oam_tile $F0, $DB, $2402, $62
		frame_oam_tile $F0, $CB, $402,	$62
		frame_oam_tile $E0, $DB, $2602, $62
		frame_oam_tile $E0, $CB, $602,	$62
		frame_oam_tile $D0, $EB, $2005, $60
		frame_oam_tile $D0, $DB, 5, $60
		frame_oam_tile $D0, $CB, $2003, $60
		frame_oam_tile $20, $EB, $2005, $20
		frame_oam_tile $20, $DB, 5, $20
		frame_oam_tile $20, $CB, $2003, $20
		frame_oam_tile $10, $DB, $2602, $22
		frame_oam_tile 0, $DB,	$2402, $22
		frame_oam_tile $10, $CB, $602,	$22
		frame_oam_tile 0, $CB,	$402, $22
animation_frame_C73507:.BYTE $24
		frame_oam_tile 0, $F8,	$2201, $64
		frame_oam_tile 0, $E8,	$201, $64
		frame_oam_tile 0, $D8,	$2207, $64
		frame_oam_tile $30, $E8, $3106, 0
		frame_oam_tile $30, $D0, $2006, 0
		frame_oam_tile $30, $D8, 3, $20
		frame_oam_tile $C8, $E8, $3106, $40
		frame_oam_tile $C8, $D0, $2006, $40
		frame_oam_tile $C0, $D8, 3, $60
		frame_oam_tile $F0, $E8, $2405, $24
		frame_oam_tile $10, $B8, $2406, $62
		frame_oam_tile $10, $A8, $406,	$64
		frame_oam_tile 0, $B8,	$2606, $62
		frame_oam_tile 0, $A8,	$606, $62
		frame_oam_tile $F0, $B8, $2606, $22
		frame_oam_tile $E0, $B8, $2406, $24
		frame_oam_tile $F0, $A8, $606,	$24
		frame_oam_tile $E0, $A8, $406,	$22
		frame_oam_tile $10, $D8, $2007, $62
		frame_oam_tile $10, $C8, 7, $62
		frame_oam_tile 0, $C8,	$207, $62
		frame_oam_tile $F0, $D8, $2207, $22
		frame_oam_tile $E0, $D8, $2007, $22
		frame_oam_tile $F0, $C8, $207,	$22
		frame_oam_tile $E0, $C8, 7, $22
		frame_oam_tile $10, $F8, $2001, $64
		frame_oam_tile $10, $E8, 1, $64
		frame_oam_tile $F0, $F8, $2201, $24
		frame_oam_tile $E0, $F8, $2001, $24
		frame_oam_tile $E0, $E8, 1, $24
		frame_oam_tile $D0, $E8, $2005, $60
		frame_oam_tile $D0, $D8, 5, $60
		frame_oam_tile $D0, $C8, $2003, $60
		frame_oam_tile $20, $E8, $2005, $20
		frame_oam_tile $20, $D8, 5, $20
		frame_oam_tile $20, $C8, $2003, $20
animation_frame_C735BC:.BYTE $28
		frame_oam_tile $18, 0,	$2001, $44
		frame_oam_tile $E0, 0,	$2001, 4
		frame_oam_tile $10, 0,	$2101, $44
		frame_oam_tile $E8, 0,	$2101, 4
		frame_oam_tile 8, 0, $2201, $44
		frame_oam_tile $F0, 0,	$2201, 4
		frame_oam_tile 0, 0, $2301, $44
		frame_oam_tile $F8, 0,	$2301, 4
		frame_oam_tile 0, $F0,	$201, $64
		frame_oam_tile 0, $E0,	$2207, $64
		frame_oam_tile $30, $F0, $3106, 0
		frame_oam_tile $30, $D8, $2006, 0
		frame_oam_tile $30, $E0, 3, $20
		frame_oam_tile $C8, $F0, $3106, $40
		frame_oam_tile $C8, $D8, $2006, $40
		frame_oam_tile $C0, $E0, 3, $60
		frame_oam_tile $F0, $F0, $2405, $24
		frame_oam_tile $10, $C0, $2406, $62
		frame_oam_tile $10, $B0, $406,	$64
		frame_oam_tile 0, $C0,	$2606, $62
		frame_oam_tile 0, $B0,	$606, $62
		frame_oam_tile $F0, $C0, $2606, $22
		frame_oam_tile $E0, $C0, $2406, $24
		frame_oam_tile $F0, $B0, $606,	$24
		frame_oam_tile $E0, $B0, $406,	$22
		frame_oam_tile $10, $E0, $2007, $62
		frame_oam_tile $10, $D0, 7, $62
		frame_oam_tile 0, $D0,	$207, $62
		frame_oam_tile $F0, $E0, $2207, $22
		frame_oam_tile $E0, $E0, $2007, $22
		frame_oam_tile $F0, $D0, $207,	$22
		frame_oam_tile $E0, $D0, 7, $22
		frame_oam_tile $10, $F0, 1, $64
		frame_oam_tile $E0, $F0, 1, $24
		frame_oam_tile $D0, $F0, $2005, $60
		frame_oam_tile $D0, $E0, 5, $60
		frame_oam_tile $D0, $D0, $2003, $60
		frame_oam_tile $20, $F0, $2005, $20
		frame_oam_tile $20, $E0, 5, $20
		frame_oam_tile $20, $D0, $2003, $20
animation_frame_C73685:.BYTE $20
		frame_oam_tile 0, $F8,	$201, $64
		frame_oam_tile 0, $E8,	$2207, $64
		frame_oam_tile $30, $F8, $3106, 0
		frame_oam_tile $30, $E0, $2006, 0
		frame_oam_tile $30, $E8, 3, $20
		frame_oam_tile $C8, $F8, $3106, $40
		frame_oam_tile $C8, $E0, $2006, $40
		frame_oam_tile $C0, $E8, 3, $60
		frame_oam_tile $F0, $F8, $2405, $24
		frame_oam_tile $10, $C8, $2406, $62
		frame_oam_tile $10, $B8, $406,	$64
		frame_oam_tile 0, $C8,	$2606, $62
		frame_oam_tile 0, $B8,	$606, $62
		frame_oam_tile $F0, $C8, $2606, $22
		frame_oam_tile $E0, $C8, $2406, $24
		frame_oam_tile $F0, $B8, $606,	$24
		frame_oam_tile $E0, $B8, $406,	$22
		frame_oam_tile $10, $E8, $2007, $62
		frame_oam_tile $10, $D8, 7, $62
		frame_oam_tile 0, $D8,	$207, $62
		frame_oam_tile $F0, $E8, $2207, $22
		frame_oam_tile $E0, $E8, $2007, $22
		frame_oam_tile $F0, $D8, $207,	$22
		frame_oam_tile $E0, $D8, 7, $22
		frame_oam_tile $10, $F8, 1, $64
		frame_oam_tile $E0, $F8, 1, $24
		frame_oam_tile $D0, $F8, $2005, $60
		frame_oam_tile $D0, $E8, 5, $60
		frame_oam_tile $D0, $D8, $2003, $60
		frame_oam_tile $20, $F8, $2005, $20
		frame_oam_tile $20, $E8, 5, $20
		frame_oam_tile $20, $D8, $2003, $20
animation_frame_C73726:.BYTE $26
		frame_oam_tile $F8, 0,	$301, 4
		frame_oam_tile $18, 0,	1, $44
		frame_oam_tile $E0, 0,	1, 4
		frame_oam_tile $10, 0,	$101, $44
		frame_oam_tile $E8, 0,	$101, 4
		frame_oam_tile 8, 0, $201, $44
		frame_oam_tile $F0, 0,	$201, 4
		frame_oam_tile 0, 0, $301, $44
		frame_oam_tile $D0, 0,	$2105, $40
		frame_oam_tile $28, 0,	$2105, 0
		frame_oam_tile $D8, 0,	$2005, $40
		frame_oam_tile $20, 0,	$2005, 0
		frame_oam_tile 0, $F0,	$2207, $64
		frame_oam_tile $30, 0,	$3106, 0
		frame_oam_tile $30, $E8, $2006, 0
		frame_oam_tile $30, $F0, 3, $20
		frame_oam_tile $C8, 0,	$3106, $40
		frame_oam_tile $C8, $E8, $2006, $40
		frame_oam_tile $C0, $F0, 3, $60
		frame_oam_tile $10, $D0, $2406, $62
		frame_oam_tile $10, $C0, $406,	$64
		frame_oam_tile 0, $D0,	$2606, $62
		frame_oam_tile 0, $C0,	$606, $62
		frame_oam_tile $F0, $D0, $2606, $22
		frame_oam_tile $E0, $D0, $2406, $24
		frame_oam_tile $F0, $C0, $606,	$24
		frame_oam_tile $E0, $C0, $406,	$22
		frame_oam_tile $10, $F0, $2007, $62
		frame_oam_tile $10, $E0, 7, $62
		frame_oam_tile 0, $E0,	$207, $62
		frame_oam_tile $F0, $F0, $2207, $22
		frame_oam_tile $E0, $F0, $2007, $22
		frame_oam_tile $F0, $E0, $207,	$22
		frame_oam_tile $E0, $E0, 7, $22
		frame_oam_tile $D0, $F0, 5, $60
		frame_oam_tile $D0, $E0, $2003, $60
		frame_oam_tile $20, $F0, 5, $20
		frame_oam_tile $20, $E0, $2003, $20
animation_frame_C737E5:.BYTE $18
		frame_oam_tile $C0, $F8, 3, $60
		frame_oam_tile $D0, $F8, 5, $60
		frame_oam_tile 0, $F8,	$2207, $64
		frame_oam_tile $30, $F0, $2006, 0
		frame_oam_tile $30, $F8, 3, $20
		frame_oam_tile $C8, $F0, $2006, $40
		frame_oam_tile $10, $D8, $2406, $62
		frame_oam_tile $10, $C8, $406,	$64
		frame_oam_tile 0, $D8,	$2606, $62
		frame_oam_tile 0, $C8,	$606, $62
		frame_oam_tile $F0, $D8, $2606, $22
		frame_oam_tile $E0, $D8, $2406, $24
		frame_oam_tile $F0, $C8, $606,	$24
		frame_oam_tile $E0, $C8, $406,	$22
		frame_oam_tile $10, $F8, $2007, $62
		frame_oam_tile $10, $E8, 7, $62
		frame_oam_tile 0, $E8,	$207, $62
		frame_oam_tile $F0, $F8, $2207, $22
		frame_oam_tile $E0, $F8, $2007, $22
		frame_oam_tile $F0, $E8, $207,	$22
		frame_oam_tile $E0, $E8, 7, $22
		frame_oam_tile $D0, $E8, $2003, $60
		frame_oam_tile $20, $F8, 5, $20
		frame_oam_tile $20, $E8, $2003, $20
animation_frame_C7385E:.BYTE $1E
		frame_oam_tile $18, 0,	$2007, $44
		frame_oam_tile $E0, 0,	$2007, 4
		frame_oam_tile $10, 0,	$2107, $44
		frame_oam_tile $E8, 0,	$2107, 4
		frame_oam_tile 8, 0, $2207, $44
		frame_oam_tile $F0, 0,	$2207, 4
		frame_oam_tile 0, 0, $2307, $44
		frame_oam_tile $F8, 0,	$2307, 4
		frame_oam_tile $C8, 0,	3, $40
		frame_oam_tile $30, 0,	3, 0
		frame_oam_tile $D0, 0,	$105, $40
		frame_oam_tile $28, 0,	$105, 0
		frame_oam_tile $D8, 0,	5, $40
		frame_oam_tile $20, 0,	5, 0
		frame_oam_tile $D0, $F0, $2003, $60
		frame_oam_tile $30, $F8, $2006, 0
		frame_oam_tile $C8, $F8, $2006, $40
		frame_oam_tile $10, $E0, $2406, $62
		frame_oam_tile $10, $D0, $406,	$64
		frame_oam_tile 0, $E0,	$2606, $62
		frame_oam_tile 0, $D0,	$606, $62
		frame_oam_tile $F0, $E0, $2606, $22
		frame_oam_tile $E0, $E0, $2406, $24
		frame_oam_tile $F0, $D0, $606,	$24
		frame_oam_tile $E0, $D0, $406,	$22
		frame_oam_tile $10, $F0, 7, $62
		frame_oam_tile 0, $F0,	$207, $62
		frame_oam_tile $F0, $F0, $207,	$22
		frame_oam_tile $E0, $F0, 7, $22
		frame_oam_tile $20, $F0, $2003, $20
animation_frame_C738F5:.BYTE $10
		frame_oam_tile $D0, $F8, $2003, $60
		frame_oam_tile $30, 0,	$2006, 0
		frame_oam_tile $C8, 0,	$2006, $40
		frame_oam_tile $10, $E8, $2406, $62
		frame_oam_tile $10, $D8, $406,	$64
		frame_oam_tile 0, $E8,	$2606, $62
		frame_oam_tile 0, $D8,	$606, $62
		frame_oam_tile $F0, $E8, $2606, $22
		frame_oam_tile $E0, $E8, $2406, $24
		frame_oam_tile $F0, $D8, $606,	$24
		frame_oam_tile $E0, $D8, $406,	$22
		frame_oam_tile $10, $F8, 7, $62
		frame_oam_tile 0, $F8,	$207, $62
		frame_oam_tile $F0, $F8, $207,	$22
		frame_oam_tile $E0, $F8, 7, $22
		frame_oam_tile $20, $F8, $2003, $20
animation_frame_C73946:.BYTE $12
		frame_oam_tile $D8, 0,	$2003, $40
		frame_oam_tile $20, 0,	$2003, 0
		frame_oam_tile $18, 0,	7, $44
		frame_oam_tile $10, 0,	$107, $44
		frame_oam_tile 8, 0, $207, $44
		frame_oam_tile 0, 0, $307, $44
		frame_oam_tile $E0, 0,	7, 4
		frame_oam_tile $E8, 0,	$107, 4
		frame_oam_tile $F8, 0,	$307, 4
		frame_oam_tile $F0, 0,	$207, 4
		frame_oam_tile $10, $F0, $2406, $62
		frame_oam_tile $10, $E0, $406,	$64
		frame_oam_tile 0, $F0,	$2606, $62
		frame_oam_tile 0, $E0,	$606, $62
		frame_oam_tile $F0, $F0, $2606, $22
		frame_oam_tile $E0, $F0, $2406, $24
		frame_oam_tile $F0, $E0, $606,	$24
		frame_oam_tile $E0, $E0, $406,	$22
animation_frame_C739A1:.BYTE 8
		frame_oam_tile $10, $F8, $2406, $62
		frame_oam_tile $10, $E8, $406,	$64
		frame_oam_tile 0, $F8,	$2606, $62
		frame_oam_tile 0, $E8,	$606, $62
		frame_oam_tile $F0, $F8, $2606, $22
		frame_oam_tile $E0, $F8, $2406, $24
		frame_oam_tile $F0, $E8, $606,	$24
		frame_oam_tile $E0, $E8, $406,	$22
animation_frame_C739CA:.BYTE $C
		frame_oam_tile $18, 0,	$2406, $44
		frame_oam_tile $E0, 0,	$2406, 4
		frame_oam_tile $10, 0,	$2506, $44
		frame_oam_tile $E8, 0,	$2506, 4
		frame_oam_tile 0, 0, $2706, $44
		frame_oam_tile $F8, 0,	$2706, 4
		frame_oam_tile 8, 0, $2606, $44
		frame_oam_tile $F0, 0,	$2606, 4
		frame_oam_tile $10, $F0, $406,	$64
		frame_oam_tile 0, $F0,	$606, $62
		frame_oam_tile $F0, $F0, $606,	$24
		frame_oam_tile $E0, $F0, $406,	$22
animation_frame_C73A07:.BYTE 4
		frame_oam_tile $10, $F8, $406,	$64
		frame_oam_tile 0, $F8,	$606, $62
		frame_oam_tile $F0, $F8, $606,	$24
		frame_oam_tile $E0, $F8, $406,	$22
animation_frame_C73A1C:.BYTE 6
		frame_oam_tile $10, 0,	$506, $44
		frame_oam_tile $E8, 0,	$506, 4
		frame_oam_tile 8, 0, $606, $44
		frame_oam_tile $F0, 0,	$606, 4
		frame_oam_tile 0, 0, $706, 4
		frame_oam_tile $F8, 0,	$706, 4
animation_frame_C73A3B:.BYTE 1
		frame_oam_tile $F8, $F8, $2205, $20
animation_frame_C73A41:.BYTE 1
		frame_oam_tile $F8, $F8, $2407, $20
animation_frame_C73A47:.BYTE 1
		frame_oam_tile $F8, $F8, $407,	$20
animation_frame_C73A4D:.BYTE 1
		frame_oam_tile $F8, $F8, $605,	$20
byte_C73A53:.BYTE 1
		animation_frame animation_frame_C72B58, $FF
byte_C73A58:	.BYTE $B
		animation_frame animation_frame_C72B58, $10
		animation_frame animation_frame_C72B58, 6
		animation_frame animation_frame_C72C0D, 6
		animation_frame animation_frame_C72B58, 4
		animation_frame animation_frame_C72C0D, 4
		animation_frame animation_frame_C72B58, 4
		animation_frame animation_frame_C72C0D, 4
		animation_frame animation_frame_C72C0D, 6
		animation_frame animation_frame_C72B58, 6
		animation_frame animation_frame_C72C0D, $A
		animation_frame animation_frame_C72B58, $2C
byte_C73A85:.BYTE 3
		animation_frame animation_frame_C72D7D, $A
		animation_frame animation_frame_C72E32, 7
		animation_frame animation_frame_C72EFB, $D
byte_C73A92:.BYTE 1
		animation_frame animation_frame_C72EFB, $80
byte_C73A97:.BYTE 1
		animation_frame animation_frame_C72FC4, $FF
byte_C73A9C:.BYTE $14
		animation_frame animation_frame_C72B58, 3
		animation_frame animation_frame_C7308D, 3
		animation_frame animation_frame_C72B58, 3
		animation_frame animation_frame_C7308D, 3
		animation_frame animation_frame_C72B58, 3
		animation_frame animation_frame_C7308D, 3
		animation_frame animation_frame_C72B58, 3
		animation_frame animation_frame_C7308D, 3
		animation_frame animation_frame_C72B58, 3
		animation_frame animation_frame_C7308D, 3
		animation_frame animation_frame_C72B58, 3
		animation_frame animation_frame_C7308D, 3
		animation_frame animation_frame_C72B58, 3
		animation_frame animation_frame_C7308D, 3
		animation_frame animation_frame_C72B58, 3
		animation_frame animation_frame_C7308D, 3
		animation_frame animation_frame_C72B58, 3
		animation_frame animation_frame_C7308D, 3
		animation_frame animation_frame_C72B58, 3
		animation_frame animation_frame_C7308D, 3
byte_C73AED:.BYTE $14
		animation_frame animation_frame_C72D7D, 3
		animation_frame animation_frame_C73142, 3
		animation_frame animation_frame_C72D7D, 3
		animation_frame animation_frame_C73142, 3
		animation_frame animation_frame_C72D7D, 3
		animation_frame animation_frame_C73142, 3
		animation_frame animation_frame_C72D7D, 3
		animation_frame animation_frame_C73142, 3
		animation_frame animation_frame_C72D7D, 3
		animation_frame animation_frame_C73142, 3
		animation_frame animation_frame_C72D7D, 3
		animation_frame animation_frame_C73142, 3
		animation_frame animation_frame_C72D7D, 3
		animation_frame animation_frame_C73142, 3
		animation_frame animation_frame_C72D7D, 3
		animation_frame animation_frame_C73142, 3
		animation_frame animation_frame_C72D7D, 3
		animation_frame animation_frame_C73142, 3
		animation_frame animation_frame_C72D7D, 3
		animation_frame animation_frame_C73142, 3
byte_C73B3E:.BYTE $14
		animation_frame animation_frame_C72E32, 3
		animation_frame animation_frame_C731F7, 3
		animation_frame animation_frame_C72E32, 3
		animation_frame animation_frame_C731F7, 3
		animation_frame animation_frame_C72E32, 3
		animation_frame animation_frame_C731F7, 3
		animation_frame animation_frame_C72E32, 3
		animation_frame animation_frame_C731F7, 3
		animation_frame animation_frame_C72E32, 3
		animation_frame animation_frame_C731F7, 3
		animation_frame animation_frame_C72E32, 3
		animation_frame animation_frame_C731F7, 3
		animation_frame animation_frame_C72E32, 3
		animation_frame animation_frame_C731F7, 3
		animation_frame animation_frame_C72E32, 3
		animation_frame animation_frame_C731F7, 3
		animation_frame animation_frame_C72E32, 3
		animation_frame animation_frame_C731F7, 3
		animation_frame animation_frame_C72E32, 3
		animation_frame animation_frame_C731F7, 3
byte_C73B8F:	.BYTE $18
		animation_frame animation_frame_C72FC4, 3
		animation_frame animation_frame_C73389, 3
		animation_frame animation_frame_C72FC4, 3
		animation_frame animation_frame_C73389, 3
		animation_frame animation_frame_C72FC4, 3
		animation_frame animation_frame_C73389, 3
		animation_frame animation_frame_C72FC4, 3
		animation_frame animation_frame_C73389, 3
		animation_frame animation_frame_C72FC4, 3
		animation_frame animation_frame_C73389, 3
		animation_frame animation_frame_C72FC4, 3
		animation_frame animation_frame_C73389, 3
		animation_frame animation_frame_C72FC4, 3
		animation_frame animation_frame_C73389, 3
		animation_frame animation_frame_C72FC4, 3
		animation_frame animation_frame_C73389, 3
		animation_frame animation_frame_C72FC4, 3
		animation_frame animation_frame_C73389, 3
		animation_frame animation_frame_C72FC4, 3
		animation_frame animation_frame_C73389, 3
		animation_frame animation_frame_C72FC4, 3
		animation_frame animation_frame_C73389, 3
		animation_frame animation_frame_C72FC4, 3
		animation_frame animation_frame_C73389, 3
byte_C73BF0:	.BYTE 2
		animation_frame animation_frame_C72B58, $1C
		animation_frame animation_frame_C73452, $16
byte_C73BF9:	.BYTE $D
		animation_frame animation_frame_C72FC4, $D
		animation_frame animation_frame_C73507, 4
		animation_frame animation_frame_C735BC, 4
		animation_frame animation_frame_C73685, 3
		animation_frame animation_frame_C73726, 3
		animation_frame animation_frame_C737E5, 2
		animation_frame animation_frame_C7385E, 2
		animation_frame animation_frame_C738F5, 2
		animation_frame animation_frame_C73946, 2
		animation_frame animation_frame_C739A1, 2
		animation_frame animation_frame_C739CA, 2
		animation_frame animation_frame_C73A07, 2
		animation_frame animation_frame_C73A1C, 1
byte_C73C2E:	.BYTE 4
		animation_frame animation_frame_C73A3B, 3
		animation_frame animation_frame_C73A41, 1
		animation_frame animation_frame_C73A47, 3
		animation_frame animation_frame_C73A4D, 1
.A16
.I16

create_clown_mask:
		REP	#$20
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(clown_mask)
		STA	z:$DB
		LDA	#.HIBYTE(clown_mask)
		STA	z:$DC
		LDA	#.BANKBYTE(clown_mask)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		LDA	z:$40
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($11),Y
		LDA	z:$42
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($14),Y
		LDA	z:$5F
		STA	a:.LOWORD($3A),Y
		LDA	z:$60
		STA	a:.LOWORD($3B),Y
		SEP	#$20
.A8
		LDA	z:$48
		STA	a:.LOWORD($3E),Y
		LDA	#$30
		STA	a:.LOWORD($E),Y
		LDA	a:.LOWORD(3),Y
		ORA	#1
		STA	a:.LOWORD(3),Y
		REP	#$20
.A16
		LDA	#8
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(clown_mask_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(clown_mask_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		REP	#$20
.A16
		LDA	#$380
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	#$B0
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		SEP	#$20
.A8
		LDA	#8
		STA	a:.LOWORD($1E),Y
		LDA	#$1D
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#2
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#2
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#$9F
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		RTL
; End of function create_clown_mask

.A8
.I16

clown_mask:
		REP	#$20
.A16
		LDY	z:$26,X
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		LDA	#$88
		STA	z:$11,X
		LDA	#$5E
		STA	z:$14,X
		LDA	#0
		STA	z:$16,X
		LDA	#0
		STA	z:$18,X
		LDA	#0
		STA	z:$30,X
		LDA	#$12
		STA	z:$32,X
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		LDA	#$30
		STA	z:$E,X
		LDA	#3
		STA	z:$21,X
		REP	#$20
.A16
		LDA	#.LOWORD(_clown_mask)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_clown_mask)
		STA	z:2,X

_clown_mask:
		REP	#$20
.A16
		INC	z:$30,X
		LDA	z:$30,X
		CMP	#$E0
		BEQ	loc_C73D30
		JML	f:locret_C73DBB
; ---------------------------------------------------------------------------

loc_C73D30:
		STZ	z:$30,X
		SEP	#$20
.A8
		LDY	#6
		LDA	#.LOWORD(CLOWN_MASK_SPOTLIGHT_PALETTE)
		STA	z:$40
; Modification: We now fade palette #0
		LDA	#0
		JSL	f:palette_related
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C73D4E)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C73D4E)
		STA	z:2,X

loc_C73D4E:
		REP	#$20
.A16
		INC	z:$30,X
		LDA	z:$30,X
		CMP	#$80
		BNE	locret_C73DBB
		LDA	#$80
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	#.LOWORD(byte_C73A58)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C73D7B)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C73D7B)
		STA	z:2,X

loc_C73D7B:
		JSL	f:advance_animation
		BCC	locret_C73DBB
		REP	#$20
.A16
		LDA	#$2400
		STA	z:$30,X
		LDA	#.LOWORD(byte_C73BF0)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		AND	#$F7
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		LDY	#3
; Modification: We now fade palette #0
		LDA	#STORY_HUD_PALETTE
		STA	z:$40
		LDA	#0
		JSL	f:palette_related
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C73DBC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C73DBC)
		STA	z:2,X
; Modification: Force fading all 16 colors
		LDA #5
		STA	a:.LOWORD(unk_7E1F80) + 3
.A16

locret_C73DBB:
		RTL
; End of function clown_mask

.A16
.I16

sub_C73DBC:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C73DC9
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C73DC9:
		BIT	#$41
		BEQ	loc_C73DD1
		JML	f:loc_C73E95
; ---------------------------------------------------------------------------

loc_C73DD1:
		SEP	#$20
		JSL	f:follower_movement_2
		REP	#$20
.A16
		LDA	#1
		STA	z:$40
		LDA	#$40
		STA	z:$42
		LDA	a:.LOWORD($11),Y
		CMP	z:$11,X
		BCS	loc_C73DF4
		LDA	#$FFFF
		STA	z:$40
		LDA	#$FFC0
		STA	z:$42

loc_C73DF4:
		LDA	z:$31,X
		AND	#$FF
		CMP	#$C
		BNE	loc_C73E02
		ASL	z:$40
		ASL	z:$42

loc_C73E02:
		LDA	z:$16,X
		CMP	z:$42
		BEQ	loc_C73E0D
		CLC
		ADC	z:$40
		STA	z:$16,X

loc_C73E0D:
		CLC
		ADC	z:$10,X
		CMP	#$3F00
		BCS	loc_C73E1A
		LDA	#$3F00
		BRA	loc_C73E22
; ---------------------------------------------------------------------------

loc_C73E1A:
		CMP	#$D000
		BCC	loc_C73E22
		LDA	#$D000

loc_C73E22:
		STA	z:$10,X
		LDA	#1
		STA	z:$40
		LDA	#$40
		STA	z:$42
		LDA	z:$14,X
		SEC
		SBC	#$20
		CMP	a:.LOWORD($14),Y
		BCC	loc_C73E43
		LDA	#$FFFF
		STA	z:$40
		LDA	#$FFC0
		STA	z:$42

loc_C73E43:
		LDA	z:$31,X
		AND	#$FF
		CMP	#$C
		BNE	loc_C73E51
		ASL	z:$40
		ASL	z:$42

loc_C73E51:
		LDA	z:$18,X
		CMP	z:$42
		BEQ	loc_C73E5C
		CLC
		ADC	z:$40
		STA	z:$18,X

loc_C73E5C:
		CLC
		ADC	z:$13,X
		CMP	#$5000
		BCS	loc_C73E69
		LDA	#$5000
		BRA	loc_C73E71
; ---------------------------------------------------------------------------

loc_C73E69:
		CMP	#$C000
		BCC	loc_C73E71
		LDA	#$C000

loc_C73E71:
		STA	z:$13,X
		REP	#$20
		LDA	#$2020
		STA	z:$42
		LDA	#$2020
		STA	z:$44
		LDA	z:$14,X
		PHA
		LDA	z:$14,X
		SEC
		SBC	#$20
		STA	z:$14,X
		JSL	f:sub_C6370B
		REP	#$20
		PLA
		STA	z:$14,X
		BCS	loc_C73EF1
.A8

loc_C73E95:
		REP	#$20
.A16
		LDA	#$1010
		STA	z:$42
		LDA	#$1010
		STA	z:$44
		LDA	z:$14,X
		PHA
		LDA	z:$14,X
		SEC
		SBC	#$20
		STA	z:$14,X
		JSL	f:sub_C6353D
		PLA
		STA	z:$14,X
		JSL	f:advance_animation
		BCC	locret_C73EF0
		REP	#$20
		LDA	z:$31,X
		AND	#$FF
		CMP	#$C
		BNE	loc_C73EC9
		STZ	z:$16,X
		STZ	z:$18,X

loc_C73EC9:
		REP	#$20
		LDA	z:$31,X
		AND	#$FF
		PHX
		TAX
		LDA	f:word_C7425E,X
		PLX
		SEP	#$20
.A8
		STA	z:$31,X
		PHX
		TAX
		REP	#$20
.A16
		LDA	f:off_C7425C,X
		PLX
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation

locret_C73EF0:
		RTL
; ---------------------------------------------------------------------------

loc_C73EF1:
		REP	#$20
.A16
		DEC	z:$32,X
		BNE	loc_C73EFB
		JML	f:loc_C73FF8
; ---------------------------------------------------------------------------

loc_C73EFB:
		LDA	#$60
		STA	z:$16,X
		LDA	z:$31,X
		AND	#$FF
		PHX
		TAX
		SEP	#$20
.A8
		LDA	f:word_C7428E,X
		PLX
		STA	z:$31,X
		JSL	f:loc_C73EC9
		REP	#$20
.A16
		LDA	#0
		STA	z:$40
		JSL	f:sub_C7412A
		LDA	#1
		STA	z:$40
		JSL	f:sub_C7412A
		LDA	#2
		STA	z:$40
		JSL	f:sub_C7412A
		LDA	#3
		STA	z:$40
		JSL	f:sub_C7412A
		LDA	#4
		STA	z:$40
		JSL	f:sub_C7412A
		LDA	#5
		STA	z:$40
		JSL	f:sub_C7412A
		LDA	#6
		STA	z:$40
		JSL	f:sub_C7412A
		LDA	#7
		STA	z:$40
		JSL	f:sub_C7412A
		REP	#$20
		LDA	#.LOWORD(loc_C73F6B)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C73F6B)
		STA	z:2,X

loc_C73F6B:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C73F78
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C73F78:
		BIT	#$41
		BEQ	loc_C73F80
		JML	f:loc_C73FCD
; ---------------------------------------------------------------------------

loc_C73F80:
		REP	#$20
.A16
		LDA	z:$16,X
		AND	#2
		ASL
		PHX
		TAX
		SEP	#$20
.A8
		LDY	#0
		LDA	f:clown_mask_palettes,X
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		LDA	f:clown_mask_palettes+1,X
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		LDA	f:clown_mask_palettes+2,X
		STA	z:$40
		LDA	#$E
		JSL	f:palette_related
		PLX
		REP	#$20
.A16
		DEC	z:$16,X
		BNE	loc_C73FCD
		STZ	z:$18,X
		JSL	f:loc_C73EC9
		REP	#$20
		LDA	#.LOWORD(sub_C73DBC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C73DBC)
		STA	z:2,X

loc_C73FCD:
		REP	#$20
.A16
		LDA	#$1010
		STA	z:$42
		LDA	#$1010
		STA	z:$44
		LDA	z:$14,X
		PHA
		LDA	z:$14,X
		SEC
		SBC	#$20
		STA	z:$14,X
		JSL	f:sub_C6353D
		PLA
		STA	z:$14,X
		JSL	f:advance_animation_2
		RTL
; ---------------------------------------------------------------------------
clown_mask_palettes:
		.BYTE CLOWN_MASK_PALETTE_0, CLOWN_MASK_PALETTE_1
		.BYTE CLOWN_MASK_PALETTE_2, UNKNOWN
		.BYTE GENERIC_BOSS_FIRE_PALETTE, GENERIC_BOSS_FIRE_PALETTE
		.BYTE GENERIC_BOSS_FIRE_PALETTE, GENERIC_BOSS_FIRE_PALETTE
; ---------------------------------------------------------------------------

loc_C73FF8:
		SEP	#$20
.A8
		PHX
		LDX	#$D40
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	z:$20,X
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		SEP	#$20
		LDX	#$D80
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	z:$20,X
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		PLX
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		LDA	#$181
		STA	z:$30,X
		LDA	z:$14,X
		PHA
		LDA	z:$14,X
		SEC
		SBC	#$20
		STA	z:$14,X
		REP	#$20
		LDA	#.LOWORD(unk_C740AA)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_C740AA)
		STA	z:$52
		JSL	f:sub_C631D7
		REP	#$20
.A16
		PLA
		STA	z:$14,X
		LDA	#.LOWORD(byte_C73B8F)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C74069)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C74069)
		STA	z:2,X

loc_C74069:
		REP	#$20
.A16
		DEC	z:$30,X
		BNE	loc_C74073
		JML	f:loc_C740B2
; ---------------------------------------------------------------------------

loc_C74073:
		LDA	z:$30,X
		AND	#2
		ASL
		PHX
		TAX
		SEP	#$20
.A8
		LDY	#0
		LDA	f:clown_mask_palettes,X
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		LDA	f:clown_mask_palettes+1,X
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		LDA	f:clown_mask_palettes+2,X
		STA	z:$40
		LDA	#$E
		JSL	f:palette_related
		PLX
		JSL	f:advance_animation_2
		RTL
; ---------------------------------------------------------------------------
unk_C740AA:	.BYTE $3F
		.BYTE	0
		.BYTE $3F
		.BYTE	0
		.BYTE $81
		.BYTE	1
		.BYTE	3
		.BYTE	0
; ---------------------------------------------------------------------------
.A16

loc_C740B2:
		REP	#$20
		LDA	#.LOWORD(byte_C73BF9)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C740D7)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C740D7)
		STA	z:2,X
		LDY	#$18
		JSL	f:play_sound

loc_C740D7:
		JSL	f:advance_animation
		BCC	locret_C74129
		REP	#$20
.A16
		PHX
		LDX	#$D40
		LDA	#0
		STA	z:$40
		LDA	#1
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		LDX	#$D80
		LDA	#0
		STA	z:$40
		LDA	#1
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		PLX
		REP	#$20
		LDA	#.LOWORD(loc_C74116)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C74116)
		STA	z:2,X
		SEP	#$20
		LDA	#$80
		STA	z:$30,X

loc_C74116:
		SEP	#$20
		DEC	z:$30,X
		BNE	locret_C74129
		LDA	#$39
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		JSL	f:fade_out_music
		JSL	f:delete_object

locret_C74129:
		RTL
; End of function sub_C73DBC

.A16
.I16

sub_C7412A:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C74158)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C74158)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C74158)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	locret_C74157
		LDA	z:$11,X
		STA	a:.LOWORD($11),Y
		LDA	z:$14,X
		SEC
		SBC	#$20
		STA	a:.LOWORD($14),Y
		LDA	z:$40
		STA	a:.LOWORD($20),Y

locret_C74157:
		RTL
; End of function sub_C7412A

.A16
.I16

sub_C74158:
		REP	#$20
		LDA	#$430
		STA	z:$E,X
		LDA	#0
		STA	z:$1E,X
		LDA	z:$20,X
		ASL
		ASL
		PHX
		TAX
		LDA	f:unk_C7421C,X
		STA	z:$40
		LDA	f:unk_C7421E,X
		STA	z:$42
		LDA	f:unk_C7423C,X
		STA	z:$44
		LDA	f:unk_C7423E,X
		STA	z:$46
		PLX
		LDA	z:$40
		STA	z:$30,X
		LDA	z:$42
		STA	z:$32,X
		LDA	z:$11,X
		CLC
		ADC	z:$44
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	z:$46
		STA	z:$14,X
		LDA	#.LOWORD(byte_C73C2E)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C741B5)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C741B5)
		STA	z:2,X

loc_C741B5:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C741C2
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C741C2:
		BIT	#$41
		BEQ	loc_C741CA
		JML	f:loc_C7420C
; ---------------------------------------------------------------------------

loc_C741CA:
		REP	#$20
.A16
		STZ	z:$40
		LDA	z:$30,X
		BPL	loc_C741D4
		DEC	z:$40

loc_C741D4:
		CLC
		LDA	z:$30,X
		ADC	z:$10,X
		STA	z:$10,X
		SEP	#$20
.A8
		LDA	z:$40
		ADC	z:$12,X
		STA	z:$12,X
		REP	#$20
.A16
		STZ	z:$40
		LDA	z:$32,X
		BPL	loc_C741ED
		DEC	z:$40

loc_C741ED:
		CLC
		LDA	z:$32,X
		ADC	z:$13,X
		STA	z:$13,X
		SEP	#$20
.A8
		LDA	z:$40
		ADC	z:$15,X
		STA	z:$15,X
		LDA	z:$12,X
		BEQ	loc_C74204
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C74204:
		LDA	z:$15,X
		BEQ	loc_C7420C
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C7420C:
		REP	#$20
.A16
		LDA	#$808
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:load_animation_frame
		RTL
; End of function sub_C74158

; ---------------------------------------------------------------------------
unk_C7421C:	.BYTE	0
		.BYTE	0
unk_C7421E:	.BYTE $10
		.BYTE $FF
		.BYTE $A0
		.BYTE	0
		.BYTE $60
		.BYTE $FF
		.BYTE $F0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $A0
		.BYTE	0
		.BYTE $A0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $F0
		.BYTE	0
		.BYTE $60
		.BYTE $FF
		.BYTE $A0
		.BYTE	0
		.BYTE $10
		.BYTE $FF
		.BYTE	0
		.BYTE	0
		.BYTE $60
		.BYTE $FF
		.BYTE $60
		.BYTE $FF
unk_C7423C:	.BYTE	0
		.BYTE	0
unk_C7423E:	.BYTE $D0
		.BYTE $FF
		.BYTE $1D
		.BYTE	0
		.BYTE $DD
		.BYTE $FF
		.BYTE $28
		.BYTE	0
		.BYTE $F8
		.BYTE $FF
		.BYTE $1D
		.BYTE	0
		.BYTE $13
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $20
		.BYTE	0
		.BYTE $E3
		.BYTE $FF
		.BYTE $13
		.BYTE	0
		.BYTE $D8
		.BYTE $FF
		.BYTE $F8
		.BYTE $FF
		.BYTE $E3
		.BYTE $FF
		.BYTE $DD
		.BYTE $FF
off_C7425C:	.ADDR byte_C73A53
word_C7425E:	.WORD 0
		.ADDR byte_C73A58
		.WORD 4
		.ADDR byte_C73A85
		.WORD $C
		.ADDR byte_C73A92
		.WORD $24
		.ADDR byte_C73A97
		.WORD 0
		.ADDR byte_C73A9C
		.WORD 8
		.ADDR byte_C73AED
		.WORD 8
		.ADDR byte_C73B3E
		.WORD 8
		.ADDR byte_C73B8F
		.WORD $10
		.ADDR byte_C73BF0
		.WORD $24
		.ADDR byte_C73A53
		.WORD $14
		.ADDR byte_C73A53
		.WORD $18
		.ADDR byte_C73A53
word_C7428E:	.WORD 0
		.ADDR byte_C73A58
		.WORD 4
		.ADDR byte_C73A85
		.WORD $2C
		.ADDR byte_C73A92
		.WORD $2C
		.ADDR byte_C73A97
		.WORD 0
		.ADDR byte_C73A9C
		.WORD 8
		.ADDR byte_C73AED
		.WORD 8
		.ADDR byte_C73B3E
		.WORD 8
		.ADDR byte_C73B8F
		.WORD $10
		.ADDR byte_C73BF0
		.WORD $28
		.ADDR byte_C73A53
		.WORD $14
		.BYTE  $D
		.BYTE $10
		.BYTE $11
		.BYTE	0
		.BYTE $12
		.BYTE $12
		.BYTE $12
		.BYTE	0
animation_frame_C742C0:.BYTE $15
		frame_oam_tile 8, 0, $2002, $20
		frame_oam_tile $10, $C0, $600,	$20
		frame_oam_tile 0, $C0,	$400, $20
		frame_oam_tile $F0, $C0, $200,	$20
		frame_oam_tile $E0, $C0, 0, $20
		frame_oam_tile $10, $D0, $601,	$20
		frame_oam_tile 0, $D0,	$401, $20
		frame_oam_tile $F0, $D0, $201,	$20
		frame_oam_tile $E0, $D0, 1, $20
		frame_oam_tile $D8, $E0, $2000, $20
		frame_oam_tile $E8, $E0, $2200, $20
		frame_oam_tile $18, $E0, $2001, $20
		frame_oam_tile 8, $E0,	$2600, $20
		frame_oam_tile $F8, $E0, $2400, $20
		frame_oam_tile $18, $F0, $202,	$20
		frame_oam_tile 8, $F0,	2, $20
		frame_oam_tile $D8, $F0, $2201, $20
		frame_oam_tile $E8, $F0, $2401, $20
		frame_oam_tile $F8, $F0, $2601, $20
		frame_oam_tile $E8, 0,	$402, $20
		frame_oam_tile $F8, 0,	$602, $20
animation_frame_C7432A:.BYTE $15
		frame_oam_tile 8, 0, $2002, $20
		frame_oam_tile 0, $D0,	$2402, $20
		frame_oam_tile $F0, $D0, $2202, $20
		frame_oam_tile $10, $C0, $600,	$20
		frame_oam_tile 0, $C0,	$400, $20
		frame_oam_tile $F0, $C0, $200,	$20
		frame_oam_tile $E0, $C0, 0, $20
		frame_oam_tile $10, $D0, $601,	$20
		frame_oam_tile $E0, $D0, 1, $20
		frame_oam_tile $D8, $E0, $2000, $20
		frame_oam_tile $E8, $E0, $2200, $20
		frame_oam_tile $18, $E0, $2001, $20
		frame_oam_tile 8, $E0,	$2600, $20
		frame_oam_tile $F8, $E0, $2400, $20
		frame_oam_tile $18, $F0, $202,	$20
		frame_oam_tile 8, $F0,	2, $20
		frame_oam_tile $D8, $F0, $2201, $20
		frame_oam_tile $E8, $F0, $2401, $20
		frame_oam_tile $F8, $F0, $2601, $20
		frame_oam_tile $E8, 0,	$402, $20
		frame_oam_tile $F8, 0,	$602, $20
animation_frame_C74394:.BYTE $15
		frame_oam_tile 8, 0, $2002, $22
		frame_oam_tile 0, $D0,	$2402, $22
		frame_oam_tile $F0, $D0, $2202, $22
		frame_oam_tile $10, $C0, $600,	$20
		frame_oam_tile 0, $C0,	$400, $22
		frame_oam_tile $F0, $C0, $200,	$22
		frame_oam_tile $E0, $C0, 0, $20
		frame_oam_tile $10, $D0, $601,	$22
		frame_oam_tile $E0, $D0, 1, $22
		frame_oam_tile $D8, $E0, $2000, $22
		frame_oam_tile $E8, $E0, $2200, $22
		frame_oam_tile $18, $E0, $2001, $22
		frame_oam_tile 8, $E0,	$2600, $22
		frame_oam_tile $F8, $E0, $2400, $22
		frame_oam_tile $18, $F0, $202,	$22
		frame_oam_tile 8, $F0,	2, $22
		frame_oam_tile $D8, $F0, $2201, $22
		frame_oam_tile $E8, $F0, $2401, $22
		frame_oam_tile $F8, $F0, $2601, $22
		frame_oam_tile $E8, 0,	$402, $22
		frame_oam_tile $F8, 0,	$602, $22
animation_frame_C743FE:.BYTE $12
		frame_oam_tile 0, $D8,	$2402, $20
		frame_oam_tile $F0, $D8, $2202, $20
		frame_oam_tile $10, $C8, $600,	$20
		frame_oam_tile 0, $C8,	$400, $20
		frame_oam_tile $F0, $C8, $200,	$20
		frame_oam_tile $E0, $C8, 0, $20
		frame_oam_tile $10, $D8, $601,	$20
		frame_oam_tile $E0, $D8, 1, $20
		frame_oam_tile $D8, $E8, $2000, $20
		frame_oam_tile $E8, $E8, $2200, $20
		frame_oam_tile $18, $E8, $2001, $20
		frame_oam_tile 8, $E8,	$2600, $20
		frame_oam_tile $F8, $E8, $2400, $20
		frame_oam_tile $18, $F8, $202,	$20
		frame_oam_tile 8, $F8,	2, $20
		frame_oam_tile $D8, $F8, $2201, $20
		frame_oam_tile $E8, $F8, $2401, $20
		frame_oam_tile $F8, $F8, $2601, $20
animation_frame_C74459:.BYTE $17
		frame_oam_tile $20, 0,	$302, 0
		frame_oam_tile $18, 0,	$202, 0
		frame_oam_tile $10, 0,	$102, 0
		frame_oam_tile 8, 0, 2, 0
		frame_oam_tile $D8, 0,	$2201, 0
		frame_oam_tile $E0, 0,	$2301, 0
		frame_oam_tile $E8, 0,	$2401, 0
		frame_oam_tile $F0, 0,	$2501, 0
		frame_oam_tile 0, 0, $2701, 0
		frame_oam_tile $F8, 0,	$2601, 0
		frame_oam_tile 0, $E0,	$2402, $20
		frame_oam_tile $F0, $E0, $2202, $20
		frame_oam_tile $10, $D0, $600,	$20
		frame_oam_tile 0, $D0,	$400, $20
		frame_oam_tile $F0, $D0, $200,	$20
		frame_oam_tile $E0, $D0, 0, $20
		frame_oam_tile $10, $E0, $601,	$20
		frame_oam_tile $E0, $E0, 1, $20
		frame_oam_tile $D8, $F0, $2000, $20
		frame_oam_tile $E8, $F0, $2200, $20
		frame_oam_tile $18, $F0, $2001, $20
		frame_oam_tile 8, $F0,	$2600, $20
		frame_oam_tile $F8, $F0, $2400, $20
animation_frame_C744CD:.BYTE $D
		frame_oam_tile 0, $E8,	$2402, $20
		frame_oam_tile $F0, $E8, $2202, $20
		frame_oam_tile $10, $D8, $600,	$20
		frame_oam_tile 0, $D8,	$400, $20
		frame_oam_tile $F0, $D8, $200,	$20
		frame_oam_tile $E0, $D8, 0, $20
		frame_oam_tile $10, $E8, $601,	$20
		frame_oam_tile $E0, $E8, 1, $20
		frame_oam_tile $D8, $F8, $2000, $20
		frame_oam_tile $E8, $F8, $2200, $20
		frame_oam_tile $18, $F8, $2001, $20
		frame_oam_tile 8, $F8,	$2600, $20
		frame_oam_tile $F8, $F8, $2400, $20
animation_frame_C7450F:.BYTE $12
		frame_oam_tile $D8, 0,	$2000, 0
		frame_oam_tile $E0, 0,	$2100, 0
		frame_oam_tile $E8, 0,	$2200, 0
		frame_oam_tile $F0, 0,	$2300, 0
		frame_oam_tile $20, 0,	$2101, 0
		frame_oam_tile $18, 0,	$2001, 0
		frame_oam_tile $10, 0,	$2700, 0
		frame_oam_tile 8, 0, $2600, 0
		frame_oam_tile 0, 0, $2500, 0
		frame_oam_tile $F8, 0,	$2400, 0
		frame_oam_tile 0, $F0,	$2402, $20
		frame_oam_tile $F0, $F0, $2202, $20
		frame_oam_tile $10, $E0, $600,	$20
		frame_oam_tile 0, $E0,	$400, $20
		frame_oam_tile $F0, $E0, $200,	$20
		frame_oam_tile $E0, $E0, 0, $20
		frame_oam_tile $10, $F0, $601,	$20
		frame_oam_tile $E0, $F0, 1, $20
animation_frame_C7456A:.BYTE 8
		frame_oam_tile 0, $F8,	$2402, $20
		frame_oam_tile $F0, $F8, $2202, $20
		frame_oam_tile $10, $E8, $600,	$20
		frame_oam_tile 0, $E8,	$400, $20
		frame_oam_tile $F0, $E8, $200,	$20
		frame_oam_tile $E0, $E8, 0, $20
		frame_oam_tile $10, $F8, $601,	$20
		frame_oam_tile $E0, $F8, 1, $20
animation_frame_C74593:.BYTE $A
		frame_oam_tile $E8, 0,	$101, 0
		frame_oam_tile $10, 0,	$601, 0
		frame_oam_tile $F0, 0,	$2202, 0
		frame_oam_tile 8, 0, $2502, 0
		frame_oam_tile 0, 0, $2402, 0
		frame_oam_tile $F8, 0,	$2302, 0
		frame_oam_tile $10, $F0, $600,	$20
		frame_oam_tile 0, $F0,	$400, $20
		frame_oam_tile $F0, $F0, $200,	$20
		frame_oam_tile $E0, $F0, 0, $20
animation_frame_C745C6:.BYTE 4
		frame_oam_tile $10, $F8, $600,	$20
		frame_oam_tile 0, $F8,	$400, $20
		frame_oam_tile $F0, $F8, $200,	$20
		frame_oam_tile $E0, $F8, 0, $20
animation_frame_C745DB:.BYTE 4
		frame_oam_tile $F8, 0,	$300, 0
		frame_oam_tile 0, 0, $400, 0
		frame_oam_tile $10, 0,	$600, $20
		frame_oam_tile $E0, 0,	0, $20
byte_C745F0:	.BYTE 1
		animation_frame animation_frame_C742C0, $FF
byte_C745F5:	.BYTE 1
		animation_frame animation_frame_C7432A, $FF
		.BYTE $18
		animation_frame animation_frame_C7432A, 2
		animation_frame animation_frame_C74394, 2
		animation_frame animation_frame_C7432A, 2
		animation_frame animation_frame_C74394, 2
		animation_frame animation_frame_C7432A, 2
		animation_frame animation_frame_C74394, 2
		animation_frame animation_frame_C7432A, 2
		animation_frame animation_frame_C74394, 2
		animation_frame animation_frame_C7432A, 2
		animation_frame animation_frame_C74394, 2
		animation_frame animation_frame_C7432A, 2
		animation_frame animation_frame_C74394, 2
		animation_frame animation_frame_C7432A, 2
		animation_frame animation_frame_C74394, 2
		animation_frame animation_frame_C7432A, 2
		animation_frame animation_frame_C74394, 2
		animation_frame animation_frame_C7432A, 2
		animation_frame animation_frame_C74394, 2
		animation_frame animation_frame_C7432A, 2
		animation_frame animation_frame_C74394, 2
		animation_frame animation_frame_C7432A, 2
		animation_frame animation_frame_C74394, 2
		animation_frame animation_frame_C7432A, 2
		animation_frame animation_frame_C74394, 2
byte_C7465B:	.BYTE 9
		animation_frame animation_frame_C7432A, $D
		animation_frame animation_frame_C743FE, 4
		animation_frame animation_frame_C74459, 4
		animation_frame animation_frame_C744CD, 3
		animation_frame animation_frame_C7450F, 3
		animation_frame animation_frame_C7456A, 2
		animation_frame animation_frame_C74593, 2
		animation_frame animation_frame_C745C6, 1
		animation_frame animation_frame_C745DB, 1
word_C74680:	.WORD 1, 2, 2, 2, 2
		.WORD 2, 4, 9
.A16
.I16

create_mecha_onita:
		REP	#$20
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(mecha_onita)
		STA	z:$DB
		LDA	#.HIBYTE(mecha_onita)
		STA	z:$DC
		LDA	#.BANKBYTE(mecha_onita)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		LDA	z:$40
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($11),Y
		LDA	z:$42
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($14),Y
		LDA	z:$5F
		STA	a:.LOWORD($3A),Y
		LDA	z:$60
		STA	a:.LOWORD($3B),Y
		SEP	#$20
.A8
		LDA	z:$48
		STA	a:.LOWORD($3E),Y
		LDA	#$30
		STA	a:.LOWORD($E),Y
		LDA	a:.LOWORD(3),Y
		ORA	#1
		STA	a:.LOWORD(3),Y
		REP	#$20
.A16
		LDA	#3
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(mecha_onita_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(mecha_onita_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		RTL
; End of function create_mecha_onita

.A8
.I16

mecha_onita:
		SEP	#$20
		LDA	#$17
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$10
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#2
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#1
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		LDA	#8
		STA	z:$1E,X
		REP	#$20
.A16
		LDA	#$88
		STA	z:$11,X
		LDA	#$5E
		STA	z:$14,X
		LDA	#$11
		STA	z:$32,X
		LDY	z:$26,X
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		LDA	#.LOWORD(byte_C745F0)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#0
		STA	z:$36,X
		LDA	#0
		STA	z:$30,X
		LDA	#5
		STA	z:$31,X
		LDA	#$30
		STA	z:$E,X
		LDA	#2
		STA	z:$20,X
		LDA	#3
		STA	z:$21,X
		LDA	#1
		STA	z:$1A,X
		LDA	#1
		STA	z:$1B,X
		LDA	#0
		STA	z:$3E,X
		LDA	z:3,X
		ORA	#1
		STA	z:3,X
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		REP	#$20
.A16
		LDA	#.LOWORD(word_C74680)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C74680)
		STA	z:$52
		JSL	f:sub_C769AE
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C74796)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C74796)
		STA	z:2,X

loc_C74796:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C747A3
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C747A3:
		BIT	#$41
		BEQ	loc_C747AB
		JML	f:locret_C74851
; ---------------------------------------------------------------------------

loc_C747AB:
		SEP	#$20
		LDY	#7
		LDA	#$3B
		STA	z:$40
		LDA	#1
		JSL	f:palette_related
		LDA	#0
		STA	z:$40
		LDA	#2
		JSL	f:palette_related
		LDA	#$3C
		STA	z:$40
		LDA	#3
		JSL	f:palette_related
		LDA	#4
		STA	z:$40
		LDA	#4
		JSL	f:palette_related
		LDA	#5
		STA	z:$40
		LDA	#5
		JSL	f:palette_related
		LDA	#$3D
		STA	z:$40
		LDA	#6
		JSL	f:palette_related
		LDA	#$3E
		STA	z:$40
		LDA	#7
		JSL	f:palette_related
		LDA	#.LOWORD(SHIRO_PALETTE)
		STA	z:$40
		LDA	#8
		JSL	f:palette_related
		LDA	#.LOWORD(KURO_PALETTE)
		STA	z:$40
		LDA	#9
		JSL	f:palette_related
		LDA	#.LOWORD(MECHA_ONITA_PALETTE)
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		REP	#$20
.A16
		STZ	z:$30,X
		REP	#$20
		LDA	#.LOWORD(loc_C74825)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C74825)
		STA	z:2,X

loc_C74825:
		REP	#$20
.A16
		INC	z:$30,X
		LDA	z:$30,X
		CMP	#$80
		BNE	loc_C7484D
		STZ	z:$30,X
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		AND	#$F7
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		JSL	f:sub_C74CD2
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C74852)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C74852)
		STA	z:2,X

loc_C7484D:
		JSL	f:advance_animation

locret_C74851:
		RTL
; End of function mecha_onita

.A8
.I16

sub_C74852:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C7485F
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C7485F:
		BIT	#$41
		BEQ	loc_C74867
		JML	f:loc_C74887
; ---------------------------------------------------------------------------

loc_C74867:
		REP	#$20
.A16
		LDA	#$1010
		STA	z:$42
		LDA	#$1010
		STA	z:$44
		JSL	f:sub_C6370B
		BCC	loc_C7487D
		JML	f:loc_C74A1C
; ---------------------------------------------------------------------------

loc_C7487D:
		JSL	f:sub_C74C32
		BCC	loc_C74887
		JSL	f:sub_C74CD2
.A8

loc_C74887:
		REP	#$20
.A16
		LDA	#$1010
		STA	z:$42
		LDA	#$1010
		STA	z:$44
		JSL	f:sub_C6353D
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C7489C:
		REP	#$20
		LDA	#$2E
		STA	z:$34,X
		REP	#$20
		LDA	#.LOWORD(loc_C748B0)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C748B0)
		STA	z:2,X

loc_C748B0:
		REP	#$20
.A16
		LDA	#$1010
		STA	z:$42
		LDA	#$1010
		STA	z:$44
		JSL	f:sub_C6353D
		JSL	f:advance_animation
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C748D1
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C748D1:
		BIT	#$41
		BEQ	loc_C748D9
		JML	f:locret_C748F9
; ---------------------------------------------------------------------------

loc_C748D9:
		REP	#$20
.A16
		DEC	z:$34,X
		LDA	z:$34,X
		BEQ	loc_C748FA
		AND	#2
		ASL
		PHX
		TAX
		SEP	#$20
.A8
		LDY	#0
		LDA	f:mecha_onita_palettes,X
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		PLX

locret_C748F9:
		RTL
; ---------------------------------------------------------------------------

loc_C748FA:
		REP	#$20
.A16
		DEC	z:$32,X
		BNE	loc_C74904
		JML	f:loc_C74925
; ---------------------------------------------------------------------------

loc_C74904:
		LDA	#.LOWORD(byte_C745F0)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		JSL	f:sub_C74CD2
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C74852)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C74852)
		STA	z:2,X
.A16

locret_C74924:
		RTL
; ---------------------------------------------------------------------------

loc_C74925:
		SEP	#$20
.A8
		PHX
		LDX	#$D40
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	z:$20,X
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		SEP	#$20
		LDX	#$D80
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	z:$20,X
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		PLX
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		LDA	#$100
		STA	z:$30,X
		LDA	z:$14,X
		PHA
		LDA	z:$14,X
		SEC
		SBC	#$20
		STA	z:$14,X
		REP	#$20
		LDA	#.LOWORD(word_C74A0C)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C74A0C)
		STA	z:$52
		JSL	f:sub_C631D7
		REP	#$20
.A16
		PLA
		STA	z:$14,X
		REP	#$20
		LDA	#.LOWORD(loc_C74987)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C74987)
		STA	z:2,X

loc_C74987:
		JSL	f:advance_animation
		REP	#$20
.A16
		DEC	z:$30,X
		BEQ	loc_C74995
		JML	f:locret_C74924
; ---------------------------------------------------------------------------

loc_C74995:
		LDA	#.LOWORD(byte_C7465B)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C749B9)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C749B9)
		STA	z:2,X
		LDY	#$18
		JSL	f:play_sound
		RTL
; ---------------------------------------------------------------------------

loc_C749B9:
		JSL	f:advance_animation
		BCC	locret_C74A0B
		REP	#$20
.A16
		PHX
		LDX	#$D40
		LDA	#0
		STA	z:$40
		LDA	#1
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		LDX	#$D80
		LDA	#0
		STA	z:$40
		LDA	#1
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		PLX
		REP	#$20
		LDA	#.LOWORD(loc_C749F8)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C749F8)
		STA	z:2,X
		SEP	#$20
		LDA	#$80
		STA	z:$30,X

loc_C749F8:
		SEP	#$20
		DEC	z:$30,X
		BNE	locret_C74A0B
		LDA	#$39
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		JSL	f:fade_out_music
		JSL	f:delete_object

locret_C74A0B:
		RTL
; ---------------------------------------------------------------------------
word_C74A0C:	.WORD $3F, $3F,	$100, 3
mecha_onita_palettes:
		.BYTE MECHA_ONITA_PALETTE, ONITA_FADE_PALETTE_1
		.BYTE ONITA_FADE_PALETTE_2, UNKNOWN
		.BYTE MECHA_ONITA_SHOCK_PALETTE, MECHA_ONITA_SHOCK_PALETTE
		.BYTE MECHA_ONITA_SHOCK_PALETTE, UNKNOWN
; ---------------------------------------------------------------------------
.A16

loc_C74A1C:
		REP	#$20
		LDA	#.LOWORD(loc_C74A46)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C74A46)
		STA	z:2,X
		REP	#$20
.A16
		LDA	#0
		STA	z:$34,X
		LDA	#.LOWORD(byte_C745F5)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		LDY	#6
		JSL	f:play_sound

loc_C74A46:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C74A53
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C74A53:
		BIT	#$41
		BEQ	loc_C74A5B
		JML	f:loc_C74A98
; ---------------------------------------------------------------------------

loc_C74A5B:
		REP	#$20
.A16
		LDA	z:$34,X
		INC	z:$34,X
		BIT	#7
		BNE	loc_C74A74
		SEP	#$20
.A8
		LDA	z:$3E,X
		CMP	#2
		BCS	loc_C74A74
		INC	z:$3E,X
		JSL	f:sub_C74B29

loc_C74A74:
		REP	#$20
.A16
		LDA	#$1010
		STA	z:$42
		LDA	#$1010
		STA	z:$44
		JSL	f:sub_C6370B
		BCC	loc_C74AAD
		REP	#$20
		LDA	a:.LOWORD(collision_map),Y
		AND	#$1F
		SEC
		SBC	#$1B
		STA	z:$40
		JSL	f:sub_C74BB0
.A8

loc_C74A98:
		REP	#$20
.A16
		LDA	#$1010
		STA	z:$42
		LDA	#$1010
		STA	z:$44
		JSL	f:sub_C6353D
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C74AAD:
		REP	#$20
		LDA	#.LOWORD(loc_C74AC3)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C74AC3)
		STA	z:2,X
		REP	#$20
.A16
		LDA	#$80
		STA	z:$34,X
		BRA	loc_C74B14
; ---------------------------------------------------------------------------

loc_C74AC3:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C74AD0
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C74AD0:
		BIT	#$41
		BEQ	loc_C74AD8
		JML	f:loc_C74B14
; ---------------------------------------------------------------------------

loc_C74AD8:
		REP	#$20
.A16
		LDA	#$1010
		STA	z:$42
		LDA	#$1010
		STA	z:$44
		JSL	f:sub_C6370B
		BCC	loc_C74AEE
		JML	f:loc_C74A1C
; ---------------------------------------------------------------------------

loc_C74AEE:
		REP	#$20
		DEC	z:$34,X
		BNE	loc_C74B14
		LDA	#.LOWORD(byte_C745F0)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		JSL	f:sub_C74CD2
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C74852)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C74852)
		STA	z:2,X

loc_C74B14:
		REP	#$20
.A16
		LDA	#$1010
		STA	z:$42
		LDA	#$1010
		STA	z:$44
		JSL	f:sub_C6353D
		JSL	f:advance_animation
		RTL
; End of function sub_C74852

.A8
.I16

sub_C74B29:
		SEP	#$20
		LDA	#.LOBYTE(sub_C74B73)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C74B73)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C74B73)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	locret_C74B72
		TXA
		STA	a:.LOWORD($3E),Y
		LDA	z:8,X
		STA	a:.LOWORD(8),Y
		LDA	z:$A,X
		STA	a:.LOWORD($A),Y
		LDA	z:$C,X
		STA	a:.LOWORD($C),Y
		LDA	z:$11,X
		STA	a:.LOWORD($11),Y
		LDA	z:$14,X
		STA	a:.LOWORD($14),Y
		LDA	#$400
		STA	a:.LOWORD($E),Y
		LDA	#8
		STA	a:.LOWORD($1E),Y
		LDA	#0
		STA	a:.LOWORD($20),Y

locret_C74B72:
		RTL
; End of function sub_C74B29

.A16
.I16

sub_C74B73:
		REP	#$20
		INC	z:$20,X
		LDA	z:$20,X
		CMP	#$20
		BNE	loc_C74B8E
		STZ	z:$20,X
		INC	z:$1E,X
		INC	z:$1E,X
		LDA	z:$1E,X
		AND	#$FF
		CMP	#$E
		BEQ	loc_C74B9E

loc_C74B8E:
		LDA	z:$14,X
		PHA
		LDA	#1
		STA	z:$14,X
		JSL	f:advance_animation
		PLA
		STA	z:$14,X
		RTL
; ---------------------------------------------------------------------------

loc_C74B9E:
		REP	#$20
		LDY	z:$3E,X
		SEP	#$20
.A8
		LDA	a:.LOWORD($3E),Y
		DEC
		STA	a:.LOWORD($3E),Y
		JSL	f:delete_object
		RTL
; End of function sub_C74B73

.A16
.I16

sub_C74BB0:
		REP	#$20
		LDA	z:$40
		ASL
		ASL
		ASL
		PHX
		TAX
		LDA	f:unk_C74D17,X
		STA	z:$40
		LDA	f:unk_C74D19,X
		STA	z:$42
		LDA	f:unk_C74D1B,X
		STA	z:$44
		PLX
		SEP	#$20
.A8
		LDA	z:$45
		BMI	loc_C74BD4
		STA	z:$1A,X

loc_C74BD4:
		LDA	z:$44
		BMI	loc_C74BDA
		STA	z:$1B,X

loc_C74BDA:
		REP	#$20
.A16
		LDA	z:$40
		BMI	loc_C74BF4
		CLC
		ADC	z:$11,X
		CMP	#$DC
		BCS	loc_C74BEC
		STA	z:$11,X
		BRA	loc_C74C08
; ---------------------------------------------------------------------------

loc_C74BEC:
		LDA	#$DC
		STA	z:$11,X
		JMP	a:.LOWORD(loc_C7489C)
; ---------------------------------------------------------------------------

loc_C74BF4:
		CLC
		ADC	z:$11,X
		CMP	#$34
		BCC	loc_C74C00
		STA	z:$11,X
		BRA	loc_C74C08
; ---------------------------------------------------------------------------

loc_C74C00:
		LDA	#$34
		STA	z:$11,X
		JMP	a:.LOWORD(loc_C7489C)
; ---------------------------------------------------------------------------

loc_C74C08:
		LDA	z:$42
		BMI	loc_C74C1F
		CLC
		ADC	z:$14,X
		CMP	#$C9
		BCS	loc_C74C17
		STA	z:$14,X
		RTL
; ---------------------------------------------------------------------------

loc_C74C17:
		LDA	#$C9
		STA	z:$14,X
		JMP	a:.LOWORD(loc_C7489C)
; ---------------------------------------------------------------------------

loc_C74C1F:
		CLC
		ADC	z:$14,X
		CMP	#$38
		BCC	loc_C74C2A
		STA	z:$14,X
		RTL
; ---------------------------------------------------------------------------

loc_C74C2A:
		LDA	#$38
		STA	z:$14,X
		JMP	a:.LOWORD(loc_C7489C)
; End of function sub_C74BB0

.A16
.I16

sub_C74C32:
		REP	#$20
		LDA	z:$16,X
		BMI	loc_C74C5C
		LSR
		LSR
		LSR
		LSR
		LSR
		CLC
		ADC	z:$16,X
		STA	z:$16,X
		CLC
		ADC	z:$10,X
		CMP	#$CC00
		BCS	loc_C74C4E
		STA	z:$10,X
		BRA	loc_C74C83
; ---------------------------------------------------------------------------

loc_C74C4E:
		LDA	#$CC00
		STA	z:$10,X
		LDA	z:$1A,X
		EOR	#1
		STA	z:$1A,X
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C74C5C:
		LSR
		LSR
		LSR
		LSR
		LSR
		ORA	#$F800
		CLC
		ADC	z:$16,X
		STA	z:$16,X
		CLC
		ADC	z:$10,X
		CMP	#$4400
		BCC	loc_C74C75
		STA	z:$10,X
		BRA	loc_C74C83
; ---------------------------------------------------------------------------

loc_C74C75:
		LDA	#$4400
		STA	z:$10,X
		LDA	z:$1A,X
		EOR	#1
		STA	z:$1A,X
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C74C83:
		LDA	z:$18,X
		BMI	loc_C74CAB
		LSR
		LSR
		LSR
		LSR
		LSR
		CLC
		ADC	z:$18,X
		STA	z:$18,X
		CLC
		ADC	z:$13,X
		CMP	#$B900
		BCS	loc_C74C9D
		STA	z:$13,X
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C74C9D:
		LDA	#$B900
		STA	z:$13,X
		LDA	z:$1B,X
		EOR	#1
		STA	z:$1B,X
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C74CAB:
		LSR
		LSR
		LSR
		LSR
		LSR
		ORA	#$F800
		CLC
		ADC	z:$18,X
		STA	z:$18,X
		CLC
		ADC	z:$13,X
		CMP	#$4800
		BCC	loc_C74CC4
		STA	z:$13,X
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C74CC4:
		LDA	#$4800
		STA	z:$13,X
		LDA	z:$1B,X
		EOR	#1
		STA	z:$1B,X
		SEC
		RTL
; End of function sub_C74C32

.A8
.I16

sub_C74CD2:
		JSL	f:random2
		REP	#$20
.A16
		AND	#$3F
		CLC
		ADC	#$20
		STA	z:$40
		LDA	z:$1A,X
		AND	#$FF
		BNE	loc_C74CF0
		LDA	z:$40
		EOR	#$FFFF
		INC
		STA	z:$40

loc_C74CF0:
		LDA	z:$40
		STA	z:$16,X
		JSL	f:random2
		REP	#$20
		AND	#$3F
		CLC
		ADC	#$20
		STA	z:$40
		LDA	z:$1B,X
		AND	#$FF
		BNE	loc_C74D12
		LDA	z:$40
		EOR	#$FFFF
		INC
		STA	z:$40

loc_C74D12:
		LDA	z:$40
		STA	z:$18,X
		RTL
; End of function sub_C74CD2

; ---------------------------------------------------------------------------
unk_C74D17:	.BYTE	0
		.BYTE	0
unk_C74D19:	.BYTE $F7
		.BYTE $FF
unk_C74D1B:	.BYTE	1
		.BYTE $FF
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $F7
		.BYTE $FF
		.BYTE	1
		.BYTE $FF
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	9
		.BYTE	0
		.BYTE	0
		.BYTE $FF
		.BYTE	0
		.BYTE	0
		.BYTE	9
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $FF
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $F7
		.BYTE $FF
		.BYTE	0
		.BYTE	0
		.BYTE $FF
		.BYTE	1
		.BYTE	0
		.BYTE	0
animation_frame_C74D3F:.BYTE $1E
		frame_oam_tile $CC, $24, $603,	$60
		frame_oam_tile $CC, $14, $204,	$60
		frame_oam_tile $CC, 4,	4, $60
		frame_oam_tile $24, $24, $603,	$20
		frame_oam_tile $24, $14, $204,	$20
		frame_oam_tile $24, 4,	4, $20
		frame_oam_tile $D0, 1,	$2402, $60
		frame_oam_tile $E0, 1,	$2202, $60
		frame_oam_tile $20, 1,	$2402, $20
		frame_oam_tile $10, 1,	$2202, $20
		frame_oam_tile $C8, $16, $603,	$60
		frame_oam_tile $C8, 7,	$204, $60
		frame_oam_tile $C8, $F7, 4, $60
		frame_oam_tile $28, $17, $603,	$20
		frame_oam_tile $28, 7,	$204, $20
		frame_oam_tile $28, $F7, 4, $20
		frame_oam_tile $CB, $F2, $2402, $60
		frame_oam_tile $DB, $F2, $2202, $60
		frame_oam_tile $25, $F2, $2402, $20
		frame_oam_tile $15, $F2, $2202, $20
		frame_oam_tile $CC, 6,	$603, $60
		frame_oam_tile $CC, $F6, $204,	$60
		frame_oam_tile $CC, $E6, 4, $60
		frame_oam_tile $24, 6,	$603, $20
		frame_oam_tile $24, $F6, $204,	$20
		frame_oam_tile $24, $E6, 4, $20
		frame_oam_tile $D0, $E3, $2402, $60
		frame_oam_tile $E0, $E3, $2202, $60
		frame_oam_tile $20, $E3, $2402, $20
		frame_oam_tile $10, $E3, $2202, $20
animation_frame_C74DD6:.BYTE $1E
		frame_oam_tile $CC, $1B, $603,	$60
		frame_oam_tile $CC, $B, $204, $60
		frame_oam_tile $CC, $FB, 4, $60
		frame_oam_tile $D0, 0,	$604, $60
		frame_oam_tile $E0, 0,	$404, $60
		frame_oam_tile $24, $1B, $603,	$20
		frame_oam_tile $24, $B, $204, $20
		frame_oam_tile $24, $FB, 4, $20
		frame_oam_tile $20, 0,	$604, $20
		frame_oam_tile $10, 0,	$404, $20
		frame_oam_tile $C8, $16, $603,	$60
		frame_oam_tile $C8, 7,	$204, $60
		frame_oam_tile $C8, $F7, 4, $60
		frame_oam_tile $28, $17, $603,	$20
		frame_oam_tile $28, 7,	$204, $20
		frame_oam_tile $28, $F7, 4, $20
		frame_oam_tile $CB, $F2, $2402, $60
		frame_oam_tile $DB, $F2, $2202, $60
		frame_oam_tile $25, $F2, $2402, $20
		frame_oam_tile $15, $F2, $2202, $20
		frame_oam_tile $CC, 6,	$603, $60
		frame_oam_tile $CC, $F6, $204,	$60
		frame_oam_tile $CC, $E6, 4, $60
		frame_oam_tile $24, 6,	$603, $20
		frame_oam_tile $24, $F6, $204,	$20
		frame_oam_tile $24, $E6, 4, $20
		frame_oam_tile $D0, $E3, $2402, $60
		frame_oam_tile $E0, $E3, $2202, $60
		frame_oam_tile $20, $E3, $2402, $20
		frame_oam_tile $10, $E3, $2202, $20
animation_frame_C74E6D:.BYTE $20
		frame_oam_tile $CE, $13, $603,	$60
		frame_oam_tile $CE, 3,	$204, $60
		frame_oam_tile $CE, $F3, 4, $60
		frame_oam_tile $D0, $F8, $2601, $60
		frame_oam_tile $E0, 8,	$2002, $60
		frame_oam_tile $E0, $F8, $2401, $60
		frame_oam_tile $C7, $C, $603, $60
		frame_oam_tile $C7, $FC, $204,	$60
		frame_oam_tile $C7, $EC, 4, $60
		frame_oam_tile $CB, $F1, $604,	$60
		frame_oam_tile $DB, $F1, $404,	$60
		frame_oam_tile $22, $13, $603,	$20
		frame_oam_tile $22, 3,	$204, $20
		frame_oam_tile $22, $F3, 4, $20
		frame_oam_tile $20, $F8, $2601, $20
		frame_oam_tile $10, 8,	$2002, $20
		frame_oam_tile $10, $F8, $2401, $20
		frame_oam_tile $29, $C, $603, $20
		frame_oam_tile $29, $FC, $204,	$20
		frame_oam_tile $29, $EC, 4, $20
		frame_oam_tile $25, $F1, $604,	$20
		frame_oam_tile $15, $F1, $404,	$20
		frame_oam_tile $CC, 6,	$603, $60
		frame_oam_tile $CC, $F6, $204,	$60
		frame_oam_tile $CC, $E6, 4, $60
		frame_oam_tile $24, 6,	$603, $20
		frame_oam_tile $24, $F6, $204,	$20
		frame_oam_tile $24, $E6, 4, $20
		frame_oam_tile $D0, $E3, $2402, $60
		frame_oam_tile $E0, $E3, $2202, $60
		frame_oam_tile $20, $E3, $2402, $20
		frame_oam_tile $10, $E3, $2202, $20
animation_frame_C74F0E:.BYTE $20
		frame_oam_tile $CC, $1B, $603,	$60
		frame_oam_tile $CC, $B, $204, $60
		frame_oam_tile $CC, $FB, 4, $60
		frame_oam_tile $D0, 0,	$604, $60
		frame_oam_tile $E0, 0,	$404, $60
		frame_oam_tile $C9, 5,	$603, $60
		frame_oam_tile $C9, $F5, $204,	$60
		frame_oam_tile $C9, $E5, 4, $60
		frame_oam_tile $CB, $E9, $2601, $60
		frame_oam_tile $DB, $F9, $2002, $60
		frame_oam_tile $DB, $E9, $2401, $60
		frame_oam_tile $CC, $FD, $603,	$60
		frame_oam_tile $CC, $ED, $204,	$60
		frame_oam_tile $CC, $DD, 4, $60
		frame_oam_tile $D0, $E2, $604,	$60
		frame_oam_tile $E0, $E2, $404,	$60
		frame_oam_tile $24, $1B, $603,	$20
		frame_oam_tile $24, $B, $204, $20
		frame_oam_tile $24, $FB, 4, $20
		frame_oam_tile $20, 0,	$604, $20
		frame_oam_tile $10, 0,	$404, $20
		frame_oam_tile $27, 4,	$603, $20
		frame_oam_tile $27, $F4, $204,	$20
		frame_oam_tile $27, $E4, 4, $20
		frame_oam_tile $25, $E9, $2601, $20
		frame_oam_tile $15, $F9, $2002, $20
		frame_oam_tile $15, $E9, $2401, $20
		frame_oam_tile $24, $FD, $603,	$20
		frame_oam_tile $24, $ED, $204,	$20
		frame_oam_tile $24, $DD, 4, $20
		frame_oam_tile $20, $E2, $604,	$20
		frame_oam_tile $10, $E2, $404,	$20
animation_frame_C74FAF:.BYTE $20
		frame_oam_tile $CC, $24, $603,	$60
		frame_oam_tile $CC, $14, $204,	$60
		frame_oam_tile $CC, 4,	4, $60
		frame_oam_tile $D0, 1,	$2402, $60
		frame_oam_tile $E0, 1,	$2202, $60
		frame_oam_tile $C7, $C, $603, $60
		frame_oam_tile $C7, $FC, $204,	$60
		frame_oam_tile $C7, $EC, 4, $60
		frame_oam_tile $CB, $F1, $604,	$60
		frame_oam_tile $DB, $F1, $404,	$60
		frame_oam_tile $CE, $F5, $603,	$60
		frame_oam_tile $CE, $E5, $204,	$60
		frame_oam_tile $CE, $D5, 4, $60
		frame_oam_tile $D0, $DA, $2601, $60
		frame_oam_tile $E0, $EA, $2002, $60
		frame_oam_tile $E0, $DA, $2401, $60
		frame_oam_tile $24, $24, $603,	$20
		frame_oam_tile $24, $14, $204,	$20
		frame_oam_tile $24, 4,	4, $20
		frame_oam_tile $20, 1,	$2402, $20
		frame_oam_tile $10, 1,	$2202, $20
		frame_oam_tile $29, $C, $603, $20
		frame_oam_tile $29, $FC, $204,	$20
		frame_oam_tile $29, $EC, 4, $20
		frame_oam_tile $25, $F1, $604,	$20
		frame_oam_tile $15, $F1, $404,	$20
		frame_oam_tile $22, $F5, $603,	$20
		frame_oam_tile $22, $E5, $204,	$20
		frame_oam_tile $22, $D5, 4, $20
		frame_oam_tile $20, $DA, $2601, $20
		frame_oam_tile $10, $EA, $2002, $20
		frame_oam_tile $10, $DA, $2401, $20
animation_frame_C75050:.BYTE $1E
		frame_oam_tile $CC, $24, $603,	$60
		frame_oam_tile $CC, $14, $204,	$60
		frame_oam_tile $CC, 4,	4, $60
		frame_oam_tile $D0, 1,	$2402, $60
		frame_oam_tile $E0, 1,	$2202, $60
		frame_oam_tile $C7, $15, $603,	$60
		frame_oam_tile $C7, 5,	$204, $60
		frame_oam_tile $C7, $F5, 4, $60
		frame_oam_tile $CB, $F2, $2402, $60
		frame_oam_tile $DB, $F2, $2202, $60
		frame_oam_tile $CC, $FD, $603,	$60
		frame_oam_tile $CC, $ED, $204,	$60
		frame_oam_tile $CC, $DD, 4, $60
		frame_oam_tile $D0, $E2, $604,	$60
		frame_oam_tile $E0, $E2, $404,	$60
		frame_oam_tile $24, $24, $603,	$20
		frame_oam_tile $24, $14, $204,	$20
		frame_oam_tile $24, 4,	4, $20
		frame_oam_tile $20, 1,	$2402, $20
		frame_oam_tile $10, 1,	$2202, $20
		frame_oam_tile $29, $15, $603,	$20
		frame_oam_tile $29, 5,	$204, $20
		frame_oam_tile $29, $F5, 4, $20
		frame_oam_tile $25, $F2, $2402, $20
		frame_oam_tile $15, $F2, $2202, $20
		frame_oam_tile $24, $FD, $603,	$20
		frame_oam_tile $23, $ED, $204,	$20
		frame_oam_tile $24, $DD, 4, $20
		frame_oam_tile $20, $E2, $604,	$20
		frame_oam_tile $10, $E2, $404,	$20
animation_frame_C750E7:.BYTE 2
		frame_oam_tile 0, $F8,	0, $60
		frame_oam_tile $F0, $F8, 0, $20
animation_frame_C750F2:.BYTE 2
		frame_oam_tile 0, $F8,	$200, $60
		frame_oam_tile $F0, $F8, $200,	$20
animation_frame_C750FD:.BYTE 2
		frame_oam_tile 0, $F8,	$400, $60
		frame_oam_tile $F0, $F8, $400,	$20
animation_frame_C75108:.BYTE 2
		frame_oam_tile 0, $F8,	$600, $60
		frame_oam_tile $F0, $F8, $600,	$20
animation_frame_C75113:.BYTE 2
		frame_oam_tile 0, $F8,	1, $60
		frame_oam_tile $F0, $F8, 1, $20
animation_frame_C7511E:.BYTE 2
		frame_oam_tile 0, $F8,	$201, $60
		frame_oam_tile $F0, $F8, $201,	$20
animation_frame_C75129:.BYTE 2
		frame_oam_tile 0, $F8,	$401, $60
		frame_oam_tile $F0, $F8, $401,	$20
animation_frame_C75134:.BYTE 4
		frame_oam_tile 0, $F0,	$2000, $60
		frame_oam_tile 0, 0, 2, $60
		frame_oam_tile $F0, 0,	2, $20
		frame_oam_tile $F0, $F0, $2000, $20
animation_frame_C75149:.BYTE 4
		frame_oam_tile 1, $F0,	$2000, $60
		frame_oam_tile 1, 0, 2, $60
		frame_oam_tile $EF, 0,	2, $20
		frame_oam_tile $EF, $F0, $2000, $20
animation_frame_C7515E:.BYTE 4
		frame_oam_tile 2, $F0,	$2000, $60
		frame_oam_tile 2, 0, 2, $60
		frame_oam_tile $EE, 0,	2, $20
		frame_oam_tile $EE, $F0, $2000, $20
animation_frame_C75173:.BYTE 4
		frame_oam_tile 3, $F0,	$2000, $60
		frame_oam_tile 3, 0, 2, $60
		frame_oam_tile $ED, 0,	2, $20
		frame_oam_tile $ED, $F0, $2000, $20
animation_frame_C75188:.BYTE 4
		frame_oam_tile 4, $F0,	$2000, $60
		frame_oam_tile 4, 0, 2, $60
		frame_oam_tile $EC, 0,	2, $20
		frame_oam_tile $EC, $F0, $2000, $20
animation_frame_C7519D:.BYTE 4
		frame_oam_tile 5, $F0,	$2000, $60
		frame_oam_tile 5, 0, 2, $60
		frame_oam_tile $EB, 0,	2, $20
		frame_oam_tile $EB, $F0, $2000, $20
animation_frame_C751B2:.BYTE 4
		frame_oam_tile 6, $F0,	$2000, $60
		frame_oam_tile 6, 0, 2, $60
		frame_oam_tile $EA, 0,	2, $20
		frame_oam_tile $EA, $F0, $2000, $20
animation_frame_C751C7:.BYTE 4
		frame_oam_tile 7, $F0,	$2000, $60
		frame_oam_tile 7, 0, 2, $60
		frame_oam_tile $E9, 0,	2, $20
		frame_oam_tile $E9, $F0, $2000, $20
animation_frame_C751DC:.BYTE 4
		frame_oam_tile 8, $F0,	$2000, $60
		frame_oam_tile 8, 0, 2, $60
		frame_oam_tile $E8, 0,	2, $20
		frame_oam_tile $E8, $F0, $2000, $20
animation_frame_C751F1:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile $C, $F6, $2400,	$22
		frame_oam_tile $F, $EF, $602, $22
		frame_oam_tile $13, $E7, $2400, $22
		frame_oam_tile $11, $E0, $402,	$62
		frame_oam_tile $B, $D7, $601, $62
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E4, $F6, $2400, $22
		frame_oam_tile $E1, $EF, $602,	$62
		frame_oam_tile $DD, $E7, $2400, $22
		frame_oam_tile $DF, $E0, $402,	$22
		frame_oam_tile $E5, $D7, $601,	$22
animation_frame_C7522E:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile $C, $F6, $2400,	$22
		frame_oam_tile $F, $EF, $602, $22
		frame_oam_tile $13, $E7, $2400, $22
		frame_oam_tile $11, $E0, $402,	$62
		frame_oam_tile $C, $D7, $601, $62
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E4, $F6, $2400, $22
		frame_oam_tile $E1, $EF, $602,	$62
		frame_oam_tile $DD, $E7, $2400, $22
		frame_oam_tile $DF, $E0, $402,	$22
		frame_oam_tile $E4, $D7, $601,	$22
animation_frame_C7526B:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile $C, $F6, $2400,	$22
		frame_oam_tile $F, $EF, $602, $22
		frame_oam_tile $13, $E7, $2400, $22
		frame_oam_tile $12, $E0, $402,	$62
		frame_oam_tile $D, $D7, $601, $62
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E4, $F6, $2400, $22
		frame_oam_tile $E1, $EF, $602,	$62
		frame_oam_tile $DD, $E7, $2400, $22
		frame_oam_tile $DE, $E0, $402,	$22
		frame_oam_tile $E3, $D7, $601,	$22
animation_frame_C752A8:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile $C, $F6, $2400,	$22
		frame_oam_tile $F, $EF, $602, $22
		frame_oam_tile $14, $E7, $2400, $22
		frame_oam_tile $14, $E0, $402,	$62
		frame_oam_tile $10, $D7, $601,	$62
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E4, $F6, $2400, $22
		frame_oam_tile $E1, $EF, $602,	$62
		frame_oam_tile $DC, $E7, $2400, $22
		frame_oam_tile $DC, $E0, $402,	$22
		frame_oam_tile $E0, $D7, $601,	$22
animation_frame_C752E5:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile $C, $F6, $2400,	$22
		frame_oam_tile $10, $EF, $602,	$22
		frame_oam_tile $16, $E7, $2400, $22
		frame_oam_tile $17, $E0, $402,	$62
		frame_oam_tile $14, $D7, $601,	$62
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E4, $F6, $2400, $22
		frame_oam_tile $E0, $EF, $602,	$62
		frame_oam_tile $DA, $E7, $2400, $22
		frame_oam_tile $D9, $E0, $402,	$22
		frame_oam_tile $DC, $D7, $601,	$22
animation_frame_C75322:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile $D, $F6, $2400,	$22
		frame_oam_tile $11, $EF, $602,	$22
		frame_oam_tile $17, $E7, $2400, $22
		frame_oam_tile $18, $E0, $402,	$62
		frame_oam_tile $15, $D7, $601,	$62
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E3, $F6, $2400, $22
		frame_oam_tile $DF, $EF, $602,	$62
		frame_oam_tile $D9, $E7, $2400, $22
		frame_oam_tile $D8, $E0, $402,	$22
		frame_oam_tile $DB, $D7, $601,	$22
animation_frame_C7535F:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile $D, $F6, $2400,	$22
		frame_oam_tile $11, $EF, $602,	$22
		frame_oam_tile $16, $E7, $2400, $22
		frame_oam_tile $18, $DF, $2400, $22
		frame_oam_tile $14, $D5, $601,	$62
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E3, $F6, $2400, $22
		frame_oam_tile $DF, $EF, $602,	$62
		frame_oam_tile $DA, $E7, $2400, $22
		frame_oam_tile $D8, $DF, $2400, $22
		frame_oam_tile $DC, $D5, $601,	$22
animation_frame_C7539C:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile $D, $F6, $2400,	$22
		frame_oam_tile $11, $EF, $602,	$22
		frame_oam_tile $15, $E7, $2400, $22
		frame_oam_tile $16, $DF, $402,	$22
		frame_oam_tile $16, $D4, $203,	$62
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E3, $F6, $2400, $22
		frame_oam_tile $DF, $EF, $602,	$62
		frame_oam_tile $DB, $E7, $2400, $22
		frame_oam_tile $DA, $DF, $402,	$62
		frame_oam_tile $DA, $D4, $203,	$22
animation_frame_C753D9:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile $D, $F6, $2400,	$62
		frame_oam_tile $10, $EE, $402,	$22
		frame_oam_tile $14, $E6, $402,	$22
		frame_oam_tile $19, $DF, $602,	$22
		frame_oam_tile $1D, $D7, $2201, $62
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E3, $F6, $2400, $22
		frame_oam_tile $E0, $EE, $402,	$62
		frame_oam_tile $DC, $E6, $402,	$62
		frame_oam_tile $D7, $DF, $602,	$62
		frame_oam_tile $D3, $D7, $2201, $22
animation_frame_C75416:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile $C, $F6, $2400,	$62
		frame_oam_tile $E, $EE, $402, $22
		frame_oam_tile $13, $E7, $602,	$22
		frame_oam_tile $1D, $E2, $2200, $22
		frame_oam_tile $22, $D8, $203,	$22
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E4, $F6, $2400, $22
		frame_oam_tile $E2, $EE, $402,	$62
		frame_oam_tile $DD, $E7, $602,	$62
		frame_oam_tile $D3, $E2, $2200, $62
		frame_oam_tile $CE, $D8, $203,	$62
animation_frame_C75453:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile $C, $F6, $2400,	$62
		frame_oam_tile $E, $EE, $402, $22
		frame_oam_tile $13, $E7, $602,	$22
		frame_oam_tile $1D, $E2, $2200, $22
		frame_oam_tile $25, $D8, $601,	$22
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E4, $F6, $2400, $22
		frame_oam_tile $E2, $EE, $402,	$62
		frame_oam_tile $DD, $E7, $602,	$62
		frame_oam_tile $D3, $E2, $2200, $62
		frame_oam_tile $CB, $D8, $601,	$62
animation_frame_C75490:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile $C, $F6, $2400,	$62
		frame_oam_tile $E, $EE, $402, $22
		frame_oam_tile $13, $E7, $602,	$22
		frame_oam_tile $1D, $E2, $2200, $22
		frame_oam_tile $25, $DA, $2001, $22
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E4, $F6, $2400, $22
		frame_oam_tile $E2, $EE, $402,	$62
		frame_oam_tile $DD, $E7, $602,	$62
		frame_oam_tile $D3, $E2, $2200, $62
		frame_oam_tile $CB, $DA, $2001, $62
animation_frame_C754CD:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile $C, $F6, $2400,	$62
		frame_oam_tile $D, $EE, $402, $22
		frame_oam_tile $13, $E7, $602,	$22
		frame_oam_tile $1D, $E2, $2200, $22
		frame_oam_tile $25, $DA, $2001, $22
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E4, $F6, $2400, $22
		frame_oam_tile $E3, $EE, $402,	$62
		frame_oam_tile $DD, $E7, $602,	$62
		frame_oam_tile $D3, $E2, $2200, $62
		frame_oam_tile $CB, $DA, $2001, $62
animation_frame_C7550A:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile $B, $F6, $2400,	$62
		frame_oam_tile $B, $EE, $402, $22
		frame_oam_tile $12, $E7, $602,	$22
		frame_oam_tile $1D, $E2, $2200, $22
		frame_oam_tile $25, $DA, $2001, $22
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E5, $F6, $2400, $22
		frame_oam_tile $E5, $EE, $402,	$62
		frame_oam_tile $DE, $E7, $602,	$62
		frame_oam_tile $D3, $E2, $2200, $62
		frame_oam_tile $CB, $DA, $2001, $62
animation_frame_C75547:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile 9, $F6,	$2400, $62
		frame_oam_tile 8, $EE,	$402, $22
		frame_oam_tile $10, $E7, $602,	$22
		frame_oam_tile $1C, $E2, $2200, $22
		frame_oam_tile $25, $DA, $2001, $22
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E7, $F6, $2400, $22
		frame_oam_tile $E8, $EE, $402,	$62
		frame_oam_tile $E0, $E7, $602,	$62
		frame_oam_tile $D4, $E2, $2200, $62
		frame_oam_tile $CB, $DA, $2001, $62
animation_frame_C75584:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile 9, $F6,	$2400, $62
		frame_oam_tile 8, $EE,	$402, $22
		frame_oam_tile $F, $E7, $602, $22
		frame_oam_tile $1B, $E3, $2200, $22
		frame_oam_tile $25, $DF, 3, $22
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E7, $F6, $2400, $22
		frame_oam_tile $E8, $EE, $402,	$62
		frame_oam_tile $E1, $E7, $602,	$62
		frame_oam_tile $D5, $E3, $2200, $62
		frame_oam_tile $CB, $DF, 3, $62
animation_frame_C755C1:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile 9, $F6,	$2400, $62
		frame_oam_tile 8, $EE,	$402, $22
		frame_oam_tile $E, $E7, $602, $22
		frame_oam_tile $19, $E3, $2200, $22
		frame_oam_tile $23, $DF, 3, $22
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E7, $F6, $2400, $22
		frame_oam_tile $E8, $EE, $402,	$62
		frame_oam_tile $E2, $E7, $602,	$62
		frame_oam_tile $D7, $E3, $2200, $62
		frame_oam_tile $CD, $DF, 3, $62
animation_frame_C755FE:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile 9, $F6,	$2400, $62
		frame_oam_tile 8, $EE,	$402, $22
		frame_oam_tile $D, $E7, $602, $22
		frame_oam_tile $17, $E3, $2200, $22
		frame_oam_tile $21, $DF, 3, $22
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E7, $F6, $2400, $22
		frame_oam_tile $E8, $EE, $402,	$62
		frame_oam_tile $E3, $E7, $602,	$62
		frame_oam_tile $D9, $E3, $2200, $62
		frame_oam_tile $CF, $DF, 3, $62
animation_frame_C7563B:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile 9, $F6,	$2400, $62
		frame_oam_tile 8, $EE,	$402, $22
		frame_oam_tile $D, $E7, $602, $22
		frame_oam_tile $17, $E2, $2200, $22
		frame_oam_tile $20, $D9, $2001, $22
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E7, $F6, $2400, $22
		frame_oam_tile $E8, $EE, $402,	$62
		frame_oam_tile $E3, $E7, $602,	$62
		frame_oam_tile $D9, $E2, $2200, $62
		frame_oam_tile $D0, $D9, $2001, $62
animation_frame_C75678:.BYTE $C
		frame_oam_tile $A, $FF, $2600,	$62
		frame_oam_tile 9, $F6,	$2400, $62
		frame_oam_tile 8, $EE,	$402, $22
		frame_oam_tile $D, $E7, $602, $22
		frame_oam_tile $14, $E1, $602,	$22
		frame_oam_tile $1F, $D8, $601,	$22
		frame_oam_tile $E6, $FF, $2600, $22
		frame_oam_tile $E7, $F6, $2400, $22
		frame_oam_tile $E8, $EE, $402,	$62
		frame_oam_tile $E3, $E7, $602,	$62
		frame_oam_tile $DC, $E1, $602,	$62
		frame_oam_tile $D2, $D7, $601,	$62
animation_frame_C756B5:.BYTE 1
		frame_oam_tile $F8, $F8, $2004, $20
animation_frame_C756BB:.BYTE 1
		frame_oam_tile $F8, $F8, $2204, $20
animation_frame_C756C1:.BYTE 1
		frame_oam_tile $F8, $F8, $2404, $20
animation_frame_C756C7:.BYTE 1
		frame_oam_tile $F8, $F8, $2604, $20
animation_frame_C756CD:.BYTE 2
		frame_oam_tile 0, $F8,	$2602, $60
		frame_oam_tile $F0, $F8, $2602, $20
animation_frame_C756D8:.BYTE 0
byte_C756D9:	.BYTE 5
		animation_frame animation_frame_C74DD6, 8
		animation_frame animation_frame_C74E6D, 8
		animation_frame animation_frame_C74F0E, 8
		animation_frame animation_frame_C74FAF, 8
		animation_frame animation_frame_C75050, 8
byte_C756EE:	.BYTE 1
		animation_frame animation_frame_C750E7, $FF
byte_C756F3:	.BYTE 5
		animation_frame animation_frame_C750F2, 3
		animation_frame animation_frame_C750FD, 3
		animation_frame animation_frame_C75108, 3
		animation_frame animation_frame_C75113, 3
		animation_frame animation_frame_C7511E, 3
byte_C75708:	.BYTE 1
		animation_frame animation_frame_C75129, $FF
byte_C7570D:	.BYTE 5
		animation_frame animation_frame_C7511E, 3
		animation_frame animation_frame_C75113, 3
		animation_frame animation_frame_C75108, 3
		animation_frame animation_frame_C750FD, 3
		animation_frame animation_frame_C750F2, 3
byte_C75722:	.BYTE 1
		animation_frame animation_frame_C75134, $FF
byte_C75727:	.BYTE 9
		animation_frame animation_frame_C75149, 3
		animation_frame animation_frame_C7515E, 3
		animation_frame animation_frame_C75173, 3
		animation_frame animation_frame_C75188, 3
		animation_frame animation_frame_C7519D, 3
		animation_frame animation_frame_C751B2, 3
		animation_frame animation_frame_C751C7, 3
		animation_frame animation_frame_C751DC, 3
		animation_frame animation_frame_C751C7, 3
byte_C7574C:	.BYTE 1
		animation_frame animation_frame_C751DC, $FF
byte_C75751:	.BYTE 7
		animation_frame animation_frame_C751C7, 3
		animation_frame animation_frame_C751B2, 3
		animation_frame animation_frame_C7519D, 3
		animation_frame animation_frame_C75188, 3
		animation_frame animation_frame_C75173, 3
		animation_frame animation_frame_C7515E, 3
		animation_frame animation_frame_C75149, 3
byte_C7576E:	.BYTE $14
		animation_frame animation_frame_C751F1, $D
		animation_frame animation_frame_C7522E, $A
		animation_frame animation_frame_C7526B, 8
		animation_frame animation_frame_C752A8, 7
		animation_frame animation_frame_C752E5, 5
		animation_frame animation_frame_C75322, 3
		animation_frame animation_frame_C7535F, 3
		animation_frame animation_frame_C7539C, 3
		animation_frame animation_frame_C753D9, 3
		animation_frame animation_frame_C75416, 3
		animation_frame animation_frame_C75453, 5
		animation_frame animation_frame_C75490, 8
		animation_frame animation_frame_C754CD, $A
		animation_frame animation_frame_C7550A, $B
		animation_frame animation_frame_C75547, 8
		animation_frame animation_frame_C75584, 7
		animation_frame animation_frame_C755C1, 6
		animation_frame animation_frame_C755FE, 5
		animation_frame animation_frame_C7563B, 3
		animation_frame animation_frame_C75678, 3
		.BYTE 1
		animation_frame animation_frame_C74D3F, $FF
byte_C757C4:	.BYTE 2
		animation_frame animation_frame_C756B5, 2
		animation_frame animation_frame_C756BB, 2
		.BYTE 2
		animation_frame animation_frame_C756C1, 2
		animation_frame animation_frame_C756C7, 2
byte_C757D6:	.BYTE 2
		animation_frame animation_frame_C756CD, 1
		animation_frame animation_frame_C756D8, 1
.A16
.I16

create_spiderer:
		REP	#$20
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C75851)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C75851)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C75851)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		LDA	z:$40
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($11),Y
		LDA	z:$42
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($14),Y
		LDA	z:$5F
		STA	a:.LOWORD($3A),Y
		LDA	z:$60
		STA	a:.LOWORD($3B),Y
		SEP	#$20
.A8
		LDA	z:$48
		STA	a:.LOWORD($3E),Y
		LDA	#$30
		STA	a:.LOWORD($E),Y
		LDA	a:.LOWORD(3),Y
		ORA	#1
		STA	a:.LOWORD(3),Y
		REP	#$20
.A16
		LDA	#5
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(spiderer_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(spiderer_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		RTL
; End of function create_spiderer

.A8
.I16

sub_C75851:
		SEP	#$20
		LDA	#$17
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$10
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#2
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#$81
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		REP	#$20
.A16
		LDA	#$88
		STA	z:$11,X
		LDA	#$88
		STA	z:$16,X
		LDA	#$58
		STA	z:$14,X
		LDA	#$58
		STA	z:$19,X
		LDA	#$58
		STA	z:$3A,X
		LDA	#$100
		STA	z:$30,X
		LDA	#0
		STA	z:$22,X
		LDA	#0
		STA	z:$24,X
		LDA	#0
		STA	z:$26,X
		LDA	#0
		STA	z:$38,X
		LDA	#0
		STA	z:$3E,X
		LDA	#0
		STA	z:$3C,X
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		JSL	f:sub_C75CBB
		JSL	f:sub_C75E56
		JSL	f:sub_C75C34
		JSL	f:sub_C75BB2
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C758CC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C758CC)
		STA	z:2,X

loc_C758CC:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C758D9
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C758D9:
		BIT	#$41
		BEQ	loc_C758E1
		JML	f:loc_C75967
; ---------------------------------------------------------------------------

loc_C758E1:
		JSL	f:sub_C75FE0
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C758F2)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C758F2)
		STA	z:2,X

loc_C758F2:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C758FF
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C758FF:
		BIT	#$41
		BEQ	loc_C75907
		JML	f:loc_C75967
; ---------------------------------------------------------------------------

loc_C75907:
		REP	#$20
.A16
		DEC	z:$30,X
		BEQ	loc_C75911
		JML	f:loc_C75967
; ---------------------------------------------------------------------------

loc_C75911:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		AND	#$F7
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C75928)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C75928)
		STA	z:2,X

loc_C75928:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C75935
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C75935:
		BIT	#$41
		BEQ	loc_C7593D
		JML	f:loc_C75967
; ---------------------------------------------------------------------------

loc_C7593D:
		JSL	f:sub_C759FC
		JSL	f:sub_C75AD6
		JSL	f:sub_C6153E
		REP	#$20
.A16
		AND	#$1FF
		CMP	#$11C
		BNE	loc_C75967
		LDA	z:$30,X
		BIT	#$7FFF
		BNE	loc_C75967
		LDA	z:$24,X
		BNE	loc_C75967
		LDA	z:$30,X
		ORA	#$80
		STA	z:$30,X
		INC	z:$3E,X

loc_C75967:
		REP	#$20
		LDA	#.LOWORD(byte_C759DA)
		STA	z:$DB
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_C759DA)
		STA	z:$DD
		REP	#$20
.A16
		LDA	z:$11,X
		SEC
		SBC	#$80
		EOR	#$FFFF
		INC
		CLC
		ADC	#$88
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDY	#0
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C75997
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C75997:
		BIT	#$41
		BEQ	loc_C7599F
		JML	f:loc_C759C1
; ---------------------------------------------------------------------------

loc_C7599F:
		REP	#$20
.A16
		LDA	z:$30,X
		BNE	loc_C759C1
		LDA	z:$38,X
		DEC	z:$38,X
		AND	#$F
		ASL
		TAY
		LDA	[$DB],Y
		BEQ	loc_C759C1
		INY
		INY
		LDA	[$DB],Y
		BEQ	loc_C759C1
		PHY
		LDY	#$1C
		JSL	f:play_sound
		PLY
.A8

loc_C759C1:
		REP	#$20
.A16
		LDA	z:$14,X
		CLC
		ADC	[$DB],Y
		STA	z:$3A,X
		SEC
		SBC	#$70
		EOR	#$FFFF
		INC
		CLC
		ADC	#$88
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		RTL
; End of function sub_C75851

; ---------------------------------------------------------------------------
byte_C759DA:	.BYTE 0, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0, 1, 0
		.BYTE 1, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
.A8
.I16

sub_C759FC:
		REP	#$20
.A16
		LDA	z:$30,X
		BIT	#$7FFF
		BEQ	locret_C75A67
		DEC
		STA	z:$30,X
		PHX
		LDX	#0
		BIT	#1
		BEQ	loc_C75A14
		LDX	#4

loc_C75A14:
		SEP	#$20
.A8
		LDY	#0
		LDA	f:unk_C7604A,X
		STA	z:$40
		LDA	#3
		JSL	f:palette_related
		LDA	f:unk_C7604B,X
		STA	z:$40
		LDA	#4
		JSL	f:palette_related
		LDA	f:spiderer_palettes,X
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		LDA	f:spiderer_palettes+1,X
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		PLX
		REP	#$20
.A16
		LDA	z:$30,X
		BIT	#$7FFF
		BNE	locret_C75A67
		LDA	z:$3E,X
		CMP	#7
		BCC	locret_C75A67
		REP	#$20
		LDA	#.LOWORD(sub_C75A70)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C75A70)
		STA	z:2,X

locret_C75A67:
		RTL
; End of function sub_C759FC

; ---------------------------------------------------------------------------
word_C75A68:	.WORD $3F, $3F,	$180, 3
.A8
.I16

sub_C75A70:
		REP	#$20
.A16
		LDA	#$180
		STA	z:$3E,X
		LDA	#$FFFF
		STA	z:$3C,X
		REP	#$20
		LDA	#.LOWORD(word_C75A68)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C75A68)
		STA	z:$52
		JSL	f:sub_C631D7
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C75A9A)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C75A9A)
		STA	z:2,X

loc_C75A9A:
		REP	#$20
.A16
		STZ	z:$38,X
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C75AAB
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C75AAB:
		BIT	#$41
		BEQ	loc_C75AB3
		JML	f:loc_C75967
; ---------------------------------------------------------------------------

loc_C75AB3:
		REP	#$20
.A16
		LDA	z:$3E,X
		DEC	z:$3E,X
		BNE	loc_C75ABF
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C75ABF:
		CMP	#$80
		BEQ	loc_C75AC8
		JML	f:loc_C75967
; ---------------------------------------------------------------------------

loc_C75AC8:
		JSL	f:create_uiteru_v
		REP	#$20
		LDA	#$100
		STA	z:$11,X
		JMP	a:.LOWORD(loc_C75967)
; End of function sub_C75A70

.A8
.I16

sub_C75AD6:
		REP	#$20
.A16
		LDA	z:$30,X
		BEQ	loc_C75AE0
		JML	f:locret_C75B44
; ---------------------------------------------------------------------------

loc_C75AE0:
		LDA	z:$1B,X
		BEQ	loc_C75B12
		LDA	#$FFFF
		STA	z:$40
		LDA	z:$11,X
		CMP	z:$16,X
		BCS	loc_C75AF4
		LDA	#1
		STA	z:$40

loc_C75AF4:
		JSL	f:sub_C75B4F
		LDA	z:$11,X
		CMP	z:$16,X
		BNE	locret_C75B44
		JSL	f:sub_C75B45
		LDA	#1
		STA	z:$22,X
		LDA	z:$14,X
		CMP	z:$19,X
		BNE	locret_C75B44
		JSL	f:sub_C75B71
		RTL
; ---------------------------------------------------------------------------

loc_C75B12:
		LDA	#$FFFF
		STA	z:$40
		LDA	z:$14,X
		CMP	z:$19,X
		BCS	loc_C75B22
		LDA	#1
		STA	z:$40

loc_C75B22:
		PHX
		INX
		INX
		INX
		JSL	f:sub_C75B4F
		PLX
		LDA	z:$14,X
		CMP	z:$19,X
		BNE	locret_C75B44
		JSL	f:sub_C75B45
		LDA	#1
		STA	z:$22,X
		LDA	z:$11,X
		CMP	z:$16,X
		BNE	locret_C75B44
		JSL	f:sub_C75B71

locret_C75B44:
		RTL
; End of function sub_C75AD6

.A16
.I16

sub_C75B45:
		REP	#$20
		LDA	z:$1B,X
		EOR	#$20
		STA	z:$1B,X
		RTL
; End of function sub_C75B45

.A16
.I16

sub_C75B4F:
		REP	#$20
		LDA	z:$40
		BMI	loc_C75B63
		CLC
		ADC	z:$11,X
		STA	z:$11,X
		CMP	z:$16,X
		BCC	locret_C75B62
		LDA	z:$16,X
		STA	z:$11,X

locret_C75B62:
		RTL
; ---------------------------------------------------------------------------

loc_C75B63:
		CLC
		ADC	z:$11,X
		STA	z:$11,X
		CMP	z:$16,X
		BCS	locret_C75B62
		LDA	z:$16,X
		STA	z:$11,X
		RTL
; End of function sub_C75B4F

.A16
.I16

sub_C75B71:
		JSL	f:sub_C75B83
		LDA	z:$40
		STA	z:$16,X
		LDA	z:$42
		STA	z:$19,X
		AND	#$20
		STA	z:$1B,X
		RTL
; End of function sub_C75B71

.A16
.I16

sub_C75B83:
		REP	#$20
		PHX
		LDX	#7
		JSL	f:random
		INC
		ASL
		ASL
		ASL
		ASL
		ASL
		ORA	#8
		STA	z:$40
		LDA	z:$40
		PHA
		LDX	#4
		JSL	f:random
		INC
		ASL
		ASL
		ASL
		ASL
		ASL
		ORA	#$18
		STA	z:$42
		PLA
		STA	z:$40
		PLX
		RTL
; End of function sub_C75B83

.A8
.I16

sub_C75BB2:
		SEP	#$20
		LDA	#.LOBYTE(sub_C75BCF)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C75BCF)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C75BCF)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		TXA
		STA	a:.LOWORD($38),Y
		RTL
; End of function sub_C75BB2

.A16
.I16

sub_C75BCF:
		REP	#$20
		LDA	#$420
		STA	z:$E,X
		LDA	#8
		STA	z:$1E,X
		LDA	#.LOWORD(byte_C756D9)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C75BF7)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C75BF7)
		STA	z:2,X

loc_C75BF7:
		REP	#$20
.A16
		LDY	z:$38,X
		LDA	a:.LOWORD($3C),Y
		BNE	loc_C75C26
		LDA	a:.LOWORD($11),Y
		STA	z:$11,X
		LDA	a:.LOWORD($14),Y
		CLC
		ADC	#$FFF0
		STA	z:$14,X
		LDA	a:.LOWORD($30),Y
		BNE	loc_C75C18
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C75C18:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$80
		BNE	locret_C75C25
		JSL	f:advance_animation_2

locret_C75C25:
		RTL
; ---------------------------------------------------------------------------

loc_C75C26:
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C75FA8)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C75FA8)
		STA	z:2,X
		RTL
; End of function sub_C75BCF

.A8
.I16

sub_C75C34:
		SEP	#$20
		LDA	#.LOBYTE(sub_C75C51)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C75C51)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C75C51)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		TXA
		STA	a:.LOWORD($38),Y
		RTL
; End of function sub_C75C34

.A16
.I16

sub_C75C51:
		REP	#$20
		LDA	#$420
		STA	z:$E,X
		LDA	#8
		STA	z:$1E,X
		LDA	#.LOWORD(byte_C7576E)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C75C79)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C75C79)
		STA	z:2,X

loc_C75C79:
		REP	#$20
.A16
		LDY	z:$38,X
		LDA	a:.LOWORD($3C),Y
		BNE	loc_C75CAD
		LDA	a:.LOWORD($11),Y
		STA	z:$11,X
		LDA	a:.LOWORD($14),Y
		CLC
		ADC	#$FFD0
		STA	z:$14,X
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$80
		BNE	locret_C75CAC
		REP	#$20
		LDA	#$2020
		STA	z:$42
		LDA	#$38
		STA	z:$44
		JSL	f:sub_C6353D
		JSL	f:advance_animation

locret_C75CAC:
		RTL
; ---------------------------------------------------------------------------

loc_C75CAD:
		REP	#$20
		LDA	#.LOWORD(sub_C75FA8)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C75FA8)
		STA	z:2,X
		RTL
; End of function sub_C75C51

.A8
.I16

sub_C75CBB:
		SEP	#$20
		LDA	#.LOBYTE(sub_C75CE4)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C75CE4)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C75CE4)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		TXA
		STA	a:.LOWORD($38),Y
		LDA	#$430
		STA	a:.LOWORD($E),Y
		LDA	#8
		STA	a:.LOWORD($1E),Y
		RTL
; End of function sub_C75CBB

.A16
.I16

sub_C75CE4:
		REP	#$20
		LDA	#.LOWORD(byte_C75722)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C75D02)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C75D02)
		STA	z:2,X

loc_C75D02:
		REP	#$20
.A16
		LDY	z:$38,X
		LDA	a:.LOWORD($11),Y
		STA	z:$11,X
		LDA	a:.LOWORD($3A),Y
		CLC
		ADC	#$FFDE
		STA	z:$14,X
		LDA	a:.LOWORD($22),Y
		BEQ	loc_C75D5A
		LDA	#0
		STA	a:.LOWORD($22),Y
		LDA	a:.LOWORD($30),Y
		ORA	#$8000
		STA	a:.LOWORD($30),Y
		LDA	#$10
		STA	z:$20,X
		LDA	#.LOWORD(byte_C75727)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		JSL	f:random2
		REP	#$20
.A16
		AND	#3
		CLC
		ADC	#8
		STA	z:$22,X
		STA	z:$24,X
		REP	#$20
		LDA	#.LOWORD(sub_C75D75)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C75D75)
		STA	z:2,X

loc_C75D5A:
		JSL	f:load_animation_frame
.A16

loc_C75D5E:
		REP	#$20
		LDY	z:$38,X
		LDA	a:.LOWORD($3C),Y
		BEQ	locret_C75D74
		REP	#$20
		LDA	#.LOWORD(sub_C75FA8)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C75FA8)
		STA	z:2,X

locret_C75D74:
		RTL
; End of function sub_C75CE4

.A8
.I16

sub_C75D75:
		REP	#$20
.A16
		LDY	z:$38,X
		LDA	a:.LOWORD($11),Y
		STA	z:$11,X
		LDA	a:.LOWORD($3A),Y
		CLC
		ADC	#$FFDE
		STA	z:$14,X
		JSL	f:load_animation_frame
		BCC	loc_C75D5E
		REP	#$20
		LDA	#.LOWORD(byte_C7574C)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C75DAC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C75DAC)
		STA	z:2,X
		RTL
; End of function sub_C75D75

.A8
.I16

sub_C75DAC:
		JSL	f:load_animation_frame
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C75DBD
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C75DBD:
		BIT	#$41
		BEQ	loc_C75DC5
		JML	f:loc_C75D5E
; ---------------------------------------------------------------------------

loc_C75DC5:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	loc_C75D5E
		LDA	#$10
		STA	z:$20,X
		LDY	#8
		JSL	f:play_sound
		JSL	f:sub_C45E15
		REP	#$20
		DEC	z:$22,X
		BEQ	loc_C75DE5
		JML	f:loc_C75D5E
; ---------------------------------------------------------------------------

loc_C75DE5:
		LDA	#.LOWORD(byte_C75751)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C75E02)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C75E02)
		STA	z:2,X
		RTL
; End of function sub_C75DAC

.A8
.I16

sub_C75E02:
		JSL	f:load_animation_frame
		BCS	loc_C75E0C
		JML	f:loc_C75D5E
; ---------------------------------------------------------------------------

loc_C75E0C:
		REP	#$20
.A16
		LDY	z:$38,X
		LDA	#1
		STA	a:.LOWORD($24),Y
		LDA	#.LOWORD(byte_C75722)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C75E32)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C75E32)
		STA	z:2,X

loc_C75E32:
		JSL	f:load_animation_frame
		REP	#$20
.A16
		LDA	z:$24,X
		BEQ	loc_C75E40
		JML	f:loc_C75D5E
; ---------------------------------------------------------------------------

loc_C75E40:
		LDY	z:$38,X
		LDA	#0
		STA	a:.LOWORD($24),Y
		REP	#$20
		LDA	#.LOWORD(loc_C75D02)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C75D02)
		STA	z:2,X
		RTL
; End of function sub_C75E02

.A8
.I16

sub_C75E56:
		SEP	#$20
		LDA	#.LOBYTE(sub_C75E73)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C75E73)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C75E73)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		TXA
		STA	a:.LOWORD($38),Y
		RTL
; End of function sub_C75E56

.A16
.I16

sub_C75E73:
		REP	#$20
		LDA	#$420
		STA	z:$E,X
		LDA	#8
		STA	z:$1E,X
		LDA	#.LOWORD(byte_C756EE)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C75E9B)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C75E9B)
		STA	z:2,X

loc_C75E9B:
		REP	#$20
.A16
		LDY	z:$38,X
		LDA	a:.LOWORD($11),Y
		STA	z:$11,X
		LDA	a:.LOWORD($3A),Y
		CLC
		ADC	#5
		STA	z:$14,X
		LDA	a:.LOWORD($24),Y
		BEQ	loc_C75ECE
		LDA	#.LOWORD(byte_C756F3)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C75EE9)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C75EE9)
		STA	z:2,X

loc_C75ECE:
		JSL	f:advance_animation

loc_C75ED2:
		REP	#$20
.A16
		LDY	z:$38,X
		LDA	a:.LOWORD($3C),Y
		BEQ	locret_C75EE8
		REP	#$20
		LDA	#.LOWORD(sub_C75FA8)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C75FA8)
		STA	z:2,X

locret_C75EE8:
		RTL
; End of function sub_C75E73

.A8
.I16

sub_C75EE9:
		JSL	f:advance_animation
		BCC	loc_C75F13
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C75708)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C75F0F)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C75F0F)
		STA	z:2,X
		BRA	loc_C75F13
; ---------------------------------------------------------------------------

loc_C75F0F:
		JSL	f:advance_animation

loc_C75F13:
		REP	#$20
.A16
		LDY	z:$38,X
		LDA	a:.LOWORD($24),Y
		BNE	loc_C75F34
		LDA	#1
		STA	a:.LOWORD($24),Y
		LDA	#$40
		STA	z:$20,X
		REP	#$20
		LDA	#.LOWORD(sub_C75F36)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C75F36)
		STA	z:2,X

loc_C75F34:
		BRA	loc_C75ED2
; End of function sub_C75EE9

.A8
.I16

sub_C75F36:
		JSL	f:advance_animation
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C75F47
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C75F47:
		BIT	#$41
		BEQ	loc_C75F4F
		JML	f:loc_C75F34
; ---------------------------------------------------------------------------

loc_C75F4F:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	loc_C75F34
		LDA	#.LOWORD(byte_C7570D)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C75F72)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C75F72)
		STA	z:2,X
		RTL
; End of function sub_C75F36

.A8
.I16

sub_C75F72:
		JSL	f:advance_animation
		BCC	loc_C75F34
		REP	#$20
.A16
		LDY	z:$38,X
		LDA	a:.LOWORD($30),Y
		AND	#$7FFF
		STA	a:.LOWORD($30),Y
		LDA	#0
		STA	a:.LOWORD($24),Y
		LDA	#.LOWORD(byte_C756EE)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C75E9B)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C75E9B)
		STA	z:2,X
		RTL
; End of function sub_C75F72

.A8
.I16

sub_C75FA8:
		REP	#$20
.A16
		LDA	#$100
		STA	z:$30,X
		REP	#$20
		LDA	#.LOWORD(loc_C75FBC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C75FBC)
		STA	z:2,X

loc_C75FBC:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C75FC9
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C75FC9:
		BIT	#$41
		BEQ	loc_C75FD1
		JML	f:loc_C75FDB
; ---------------------------------------------------------------------------

loc_C75FD1:
		REP	#$20
.A16
		DEC	z:$30,X
		BNE	loc_C75FDB
		JSL	f:delete_object
.A8

loc_C75FDB:
		JSL	f:advance_animation_2
		RTL
; End of function sub_C75FA8

.A8
.I16

sub_C75FE0:
		SEP	#$20
		LDY	#7
		LDA	#$40
		STA	z:$40
		LDA	#1
		JSL	f:palette_related
		LDA	#$41
		STA	z:$40
		LDA	#2
		JSL	f:palette_related
		LDA	#$73
		STA	z:$40
		LDA	#3
		JSL	f:palette_related
		LDA	#5
		STA	z:$40
		LDA	#5
		JSL	f:palette_related
		LDA	#$42
		STA	z:$40
		LDA	#6
		JSL	f:palette_related
		LDA	#$43
		STA	z:$40
		LDA	#7
		JSL	f:palette_related
		LDA	#.LOWORD(SHIRO_PALETTE)
		STA	z:$40
		LDA	#8
		JSL	f:palette_related
		LDA	#.LOWORD(KURO_PALETTE)
		STA	z:$40
		LDA	#9
		JSL	f:palette_related
		LDA	#.LOWORD(SPIDERER_PALETTE_0)
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		LDA	#.LOWORD(SPIDERER_PALETTE_1)
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		RTL
; End of function sub_C75FE0

; ---------------------------------------------------------------------------
unk_C7604A:	.BYTE $73
unk_C7604B:	.BYTE $74
spiderer_palettes:.BYTE	SPIDERER_PALETTE_0, SPIDERER_PALETTE_1
		.BYTE SCOREBOARD_PALETTE_1, SCOREBOARD_PALETTE_2
		.BYTE SPIDERER_FIRE_PALETTE, SPIDERER_FIRE_PALETTE

animation_frame_C76052:

.BYTE $2B + FIX_CREDITS_GRAMMAR ; 1 Letter added
.IF FIX_CREDITS_GRAMMAR
		frame_oam_tile $FB, $C8, $1204, 0
.ENDIF
		frame_oam_tile $3A, $D, $2200,	$20
		frame_oam_tile $32, $D, $200, $20
		frame_oam_tile $28, $D, $402, $20
		frame_oam_tile $20, $D, $2200,	$20
		frame_oam_tile $18, $D, $2000,	$20
		frame_oam_tile 4, $D, $2200, $20
		frame_oam_tile $FC, $D, $2600,	$20
		frame_oam_tile $F2, $D, $203, $20
		frame_oam_tile $E8, $D, $2202,	$20
		frame_oam_tile $DE, $D, $200, $20
		frame_oam_tile $D4, $D, $2600,	$20
		frame_oam_tile $CA, $D, $200, $20
		frame_oam_tile $C0, $D, 3, $20
		frame_oam_tile $2E, $F6, $2200, $20
		frame_oam_tile $26, $F6, $200,	$20
		frame_oam_tile $1C, $F6, $2600, $20
		frame_oam_tile $12, $F6, $200,	$20
		frame_oam_tile 8, $F6,	$602, $20
		frame_oam_tile $F3, $F7, $2601, $20
		frame_oam_tile $E9, $F7, 3, $20
		frame_oam_tile $DF, $F7, $2601, $20
		frame_oam_tile $D5, $F7, $2600, $20
		frame_oam_tile $CB, $F7, $200,	$20
		frame_oam_tile $C0, $F7, $2201, $20
		frame_oam_tile $E, $E0, $2401,	$20
		frame_oam_tile 4, $E0,	$2601, $20
		frame_oam_tile $FA, $E0, $2202, $20
		frame_oam_tile $F0, $E0, $2600, $20
		frame_oam_tile $DE, $E0, $2401, $20
		frame_oam_tile $D4, $E0, $2601, $20
		frame_oam_tile $CA, $E0, $2202, $20
		frame_oam_tile $C0, $E0, $2600, $20
		frame_oam_tile $B9, $C8, $404,	0
		frame_oam_tile $B1, $C8, $405,	0
		frame_oam_tile $A8, $C8, 4, 0
		frame_oam_tile $A0, $CA, $604,	0
		frame_oam_tile $F3, $C8, $1104, 0
		frame_oam_tile $EB, $C8, $404,	0
		frame_oam_tile $E3, $C8, $505,	0
		frame_oam_tile $DB, $C8, $505,	0
		frame_oam_tile $D3, $C8, 4, 0
		frame_oam_tile $CD, $C8, $305,	0
		frame_oam_tile $C8, $CA, $705,	0
animation_frame_C7612F:.BYTE $1D - FIX_CREDITS_GRAMMAR ; 1 Less letter
		frame_oam_tile $3A, $F6, $2200, $20
		frame_oam_tile $32, $F6, $200,	$20
		frame_oam_tile $28, $F6, $402,	$20
		frame_oam_tile $20, $F6, $2200, $20
		frame_oam_tile $18, $F6, $2000, $20
		frame_oam_tile 4, $F6,	$2200, $20
		frame_oam_tile $FC, $F6, $2600, $20
		frame_oam_tile $F2, $F6, $203,	$20
		frame_oam_tile $E8, $F6, $2202, $20
		frame_oam_tile $DE, $F6, $200,	$20
		frame_oam_tile $D4, $F6, $2600, $20
		frame_oam_tile $CA, $F6, $200,	$20
		frame_oam_tile $C0, $F6, 3, $20
.IF FIX_CREDITS_GRAMMAR
		frame_oam_tile $D, $E1, $1104,	0
		frame_oam_tile 5, $E1,	$605, 0
		frame_oam_tile $FD, $E1, $1304, 0
		frame_oam_tile $F5, $E1, $204,	0
		frame_oam_tile $ED, $E1, $404,	0
		frame_oam_tile $E5, $E1, $1104, 0
		frame_oam_tile $DF, $E1, 5, 0
		frame_oam_tile $DA, $E1, $304,	0
.ELSE
        frame_oam_tile $13, $E1, $1104, 0
        frame_oam_tile $B, $E1, $605, 0
        frame_oam_tile 3, $E1, $1304, 0
        frame_oam_tile $FB, $E1, $204, 0
        frame_oam_tile $F3, $E1, $404, 0
        frame_oam_tile $EB, $E1, $1104, 0
        frame_oam_tile $E5, $E1, 5, 0
        frame_oam_tile $E0, $E1, $304, 0
        frame_oam_tile $D3, $E1, $1204, 0
.ENDIF
        frame_oam_tile $CB, $E1, $204, 0
        frame_oam_tile $C5, $E1, 5, 0
        frame_oam_tile $C0, $E1, $704, 0
        frame_oam_tile $B8, $E3, $705, 0
        frame_oam_tile $B0, $E1, 4, 0
        frame_oam_tile $A8, $E1, $1104, 0
        frame_oam_tile $A0, $E3, $604, 0
animation_frame_C761BC:.BYTE $21
.IF FIX_CREDITS_GRAMMAR
		frame_oam_tile $15, $D7, $1204, 0
.ENDIF
		frame_oam_tile $C0, 1,	$2401, $20
		frame_oam_tile $DC, 1,	$2200, $20
		frame_oam_tile $D4, 1,	$400, $20
		frame_oam_tile $CA, 1,	$2601, $20
		frame_oam_tile $18, 1,	$2200, $20
		frame_oam_tile $10, 1,	$2400, $20
		frame_oam_tile 6, 1, $200, $20
		frame_oam_tile $FC, 1,	$402, $20
		frame_oam_tile $F4, 1,	$2200, $20
		frame_oam_tile $EC, 1,	$2000, $20
		frame_oam_tile 4, $EB,	$2401, $20
		frame_oam_tile $FA, $EB, $203,	$20
		frame_oam_tile $F0, $EB, $2400, $20
		frame_oam_tile $DF, $EB, $2600, $20
		frame_oam_tile $D4, $EB, $2001, $20
		frame_oam_tile $CA, $EB, $2601, $20
		frame_oam_tile $C0, $EB, $403,	$20
; Shift these letters by 6 pixels
		frame_oam_tile $13 - FIX_CREDITS_GRAMMAR * 6, $D7, $1104,	0
		frame_oam_tile $0B - FIX_CREDITS_GRAMMAR * 6, $D7,	$404, 0
		frame_oam_tile $03 - FIX_CREDITS_GRAMMAR * 6, $D7, $505,	0
		frame_oam_tile $FB - FIX_CREDITS_GRAMMAR * 6, $D9, $604,	0
		frame_oam_tile $F5 - FIX_CREDITS_GRAMMAR * 6, $D7, 5, 0
		frame_oam_tile $F0 - FIX_CREDITS_GRAMMAR * 6, $D7, $1204, 0
		frame_oam_tile $E8 - FIX_CREDITS_GRAMMAR * 6, $D7, $404,	0
		frame_oam_tile $E0 - FIX_CREDITS_GRAMMAR * 6, $D7, $304,	0
.IF !FIX_CREDITS_GRAMMAR
		frame_oam_tile $D3, $D7, $1204,	0
.ENDIF
		frame_oam_tile $CB, $D7, $204,	0
		frame_oam_tile $C5, $D7, 5, 0
		frame_oam_tile $C0, $D7, $704,	0
		frame_oam_tile $B8, $D9, $705,	0
		frame_oam_tile $B0, $D7, 4, 0
		frame_oam_tile $A8, $D7, $1104, 0
		frame_oam_tile $A0, $D9, $604,	0
animation_frame_C76262:.BYTE $19
		frame_oam_tile $2E, $F5, $2200, $20
		frame_oam_tile $26, $F5, $200,	$20
		frame_oam_tile $1C, $F5, $2600, $20
		frame_oam_tile $12, $F5, $200,	$20
		frame_oam_tile 8, $F5,	$602, $20
		frame_oam_tile $F3, $F6, $2601, $20
		frame_oam_tile $E9, $F6, 3, $20
		frame_oam_tile $DF, $F6, $2601, $20
		frame_oam_tile $D5, $F6, $2600, $20
		frame_oam_tile $CB, $F6, $200,	$20
		frame_oam_tile $C0, $F6, $2201, $20
		frame_oam_tile $A, $DF, $1104,	0
		frame_oam_tile 2, $DF,	$404, 0
		frame_oam_tile $FA, $DF, $405,	0
		frame_oam_tile $F1, $DF, $405,	0
		frame_oam_tile $E8, $DF, 4, 0
		frame_oam_tile $E0, $DF, $1104, 0
		frame_oam_tile $D8, $E1, $604,	0
		frame_oam_tile $D0, $DF, $605,	0
		frame_oam_tile $C8, $DF, $1104, 0
		frame_oam_tile $C0, $E1, $705,	0
		frame_oam_tile $B3, $DF, $505,	0
		frame_oam_tile $AD, $DF, 5, 0
		frame_oam_tile $A8, $DF, 4, 0
		frame_oam_tile $A0, $DF, $405,	0
animation_frame_C762E0:.BYTE $22 + FIX_CREDITS_GRAMMAR ; 1 Extra letter
.IF FIX_CREDITS_GRAMMAR
		frame_oam_tile $12, $D7, $1204, 0
.ENDIF
		frame_oam_tile $4C, 3,	$2200, $20
		frame_oam_tile $44, 3,	$2600, $20
		frame_oam_tile $3A, 3,	$203, $20
		frame_oam_tile $2F, 3,	$2402, $20
		frame_oam_tile $25, 3,	$203, $20
		frame_oam_tile $1B, 3,	$602, $20
		frame_oam_tile $A, 3, $2200, $20
		frame_oam_tile 2, 3, $2600, $20
		frame_oam_tile $F8, 3,	$203, $20
		frame_oam_tile $EE, 3,	$2202, $20
		frame_oam_tile $E6, 3,	$2200, $20
		frame_oam_tile $DE, 3,	$2000, $20
		frame_oam_tile $D4, 3,	$602, $20
		frame_oam_tile $CA, 3,	$2601, $20
		frame_oam_tile $C0, 3,	3, $20
		frame_oam_tile $F3, $EB, $200,	$20
		frame_oam_tile $E9, $EB, 3, $20
		frame_oam_tile $DF, $EB, $2601, $20
		frame_oam_tile $D5, $EB, $2600, $20
		frame_oam_tile $CB, $EB, $200,	$20
		frame_oam_tile $C0, $EB, $2201, $20
		frame_oam_tile $B0, $D7, $104,	0
		frame_oam_tile $A8, $D7, $1404, 0
		frame_oam_tile $A0, $D7, $1204, 0
		frame_oam_tile $A, $D7, $1104,	0
		frame_oam_tile 2, $D7,	$404, 0
		frame_oam_tile $FA, $D7, $405,	0
		frame_oam_tile $F1, $D7, $405,	0
		frame_oam_tile $E8, $D7, 4, 0
		frame_oam_tile $E0, $D7, $1104, 0
		frame_oam_tile $D8, $D9, $604,	0
		frame_oam_tile $D0, $D7, $605,	0
		frame_oam_tile $C8, $D7, $1104, 0
		frame_oam_tile $C0, $D9, $705,	0
animation_frame_C76390:.BYTE $15
		frame_oam_tile $CE, $F6, $2602, $20
		frame_oam_tile $B, $F6, $200, $20
		frame_oam_tile 0, $F6,	$603, $20
		frame_oam_tile $F6, $F6, $200,	$20
		frame_oam_tile $EC, $F6, $2401, $20
		frame_oam_tile $E2, $F6, $200,	$20
		frame_oam_tile $D8, $F6, $2000, $20
		frame_oam_tile $C0, $F6, $400,	$20
		frame_oam_tile 8, $DF,	$1304, 0
		frame_oam_tile 0, $DF,	$1104, 0
		frame_oam_tile $F8, $DF, $605,	0
		frame_oam_tile $F0, $E1, $705,	0
		frame_oam_tile $E8, $E1, $705,	0
		frame_oam_tile $E0, $DF, $1404, 0
		frame_oam_tile $D8, $DF, $1204, 0
		frame_oam_tile $C9, $DF, $405,	0
		frame_oam_tile $C0, $DF, $404,	0
		frame_oam_tile $B8, $DF, $1304, 0
		frame_oam_tile $B0, $DF, $1204, 0
		frame_oam_tile $A8, $E1, $1005, 0
		frame_oam_tile $A0, $DF, $1204, 0
animation_frame_C763FA:.BYTE $19
		frame_oam_tile $E, $F6, $2401,	$20
		frame_oam_tile 4, $F6,	$2601, $20
		frame_oam_tile $F0, $F6, $2600, $20
		frame_oam_tile $FA, $F6, $2202, $20
		frame_oam_tile $DE, $F6, $2401, $20
		frame_oam_tile $D4, $F6, $2601, $20
		frame_oam_tile $C0, $F6, $2600, $20
		frame_oam_tile $CA, $F6, $2202, $20
		frame_oam_tile $1E, $DF, $1104, 0
		frame_oam_tile $16, $DF, $605,	0
		frame_oam_tile $E, $DF, $1304,	0
		frame_oam_tile 6, $DF,	$204, 0
		frame_oam_tile $FE, $DF, $404,	0
		frame_oam_tile $F6, $DF, $1104, 0
		frame_oam_tile $F0, $DF, 5, 0
		frame_oam_tile $EB, $DF, $304,	0
		frame_oam_tile $DB, $DF, $1304, 0
		frame_oam_tile $D3, $DF, $505,	0
		frame_oam_tile $CB, $DF, 4, 0
		frame_oam_tile $C3, $DF, $1304, 0
		frame_oam_tile $BB, $DF, $1204, 0
		frame_oam_tile $B5, $DF, 5, 0
		frame_oam_tile $A0, $DF, 4, 0
		frame_oam_tile $A8, $DF, $1204, 0
		frame_oam_tile $B0, $DF, $1204, 0
animation_frame_C76478:.BYTE $1D + FIX_CREDITS_GRAMMAR * 2 ; 2 Extra letters
.IF FIX_CREDITS_GRAMMAR
		frame_oam_tile $10, $DF, $1204, 0
		frame_oam_tile 8, $DF,	$1104, 0
.ENDIF
		frame_oam_tile $18, $E, $602, $20
		frame_oam_tile $E, $E,	1, $20
		frame_oam_tile 4, $E, $200, $20
		frame_oam_tile $FA, $E, $201, $20
		frame_oam_tile $F0, $E, $2000,	$20
		frame_oam_tile $DE, $E, $601, $20
		frame_oam_tile $D4, $E, $2401,	$20
		frame_oam_tile $CA, $E, $200, $20
		frame_oam_tile $C0, $E, $400, $20
		frame_oam_tile $D, $F6, $600, $20
		frame_oam_tile 5, $F6,	$2200, $20
		frame_oam_tile $FD, $F6, $602,	$20
		frame_oam_tile $F3, $F6, $203,	$20
		frame_oam_tile $E8, $F6, $2201, $20
		frame_oam_tile $D0, $F6, $602,	$20
		frame_oam_tile $C0, $F6, 3, $20
		frame_oam_tile $CA, $EC, $2003, $20
		frame_oam_tile 0, $DF,	$404, 0
		frame_oam_tile $F8, $DF, $204,	0
		frame_oam_tile $F0, $DF, $1404, 0
		frame_oam_tile $E8, $DF, $304,	0
		frame_oam_tile $E0, $DF, $605,	0
		frame_oam_tile $D8, $DF, $1104, 0
		frame_oam_tile $D0, $E1, $705,	0
		frame_oam_tile $C0, $DF, $304,	0
		frame_oam_tile $B8, $DF, $505,	0
		frame_oam_tile $B0, $DF, $1404, 0
		frame_oam_tile $A0, $DF, $1204, 0
		frame_oam_tile $A8, $DF, $605,	0
animation_frame_C76514:.BYTE $29 + FIX_CREDITS_GRAMMAR ; 1 Extra letter
        ; Move some letters 1 pixel to the right
		frame_oam_tile $46 + FIX_CREDITS_GRAMMAR, $F6, $200,	$20
		frame_oam_tile $3B + FIX_CREDITS_GRAMMAR, $F6, $2201, $20
		frame_oam_tile $31 + FIX_CREDITS_GRAMMAR, $F6, $203,	$20
		frame_oam_tile $27 + FIX_CREDITS_GRAMMAR, $F6, $2600, $20
		frame_oam_tile $1F + FIX_CREDITS_GRAMMAR, $F6, $2200, $20
		frame_oam_tile $17 + FIX_CREDITS_GRAMMAR, $F6, $2000, $20
		frame_oam_tile $0D + FIX_CREDITS_GRAMMAR, $F6, $600, $20
		frame_oam_tile $F9 + FIX_CREDITS_GRAMMAR, $F6, $2200, $20
.IF FIX_CREDITS_GRAMMAR
		frame_oam_tile $D4, $F6, $602,	$20
.ENDIF
		frame_oam_tile $F1 + FIX_CREDITS_GRAMMAR, $F6, $2000, $20
		frame_oam_tile $E7 + FIX_CREDITS_GRAMMAR, $F6, $602,	$20
		frame_oam_tile $DD + FIX_CREDITS_GRAMMAR, $F6, $203,	$20
.IF !FIX_CREDITS_GRAMMAR
        frame_oam_tile $D3, $F6, $0602, $20
.ENDIF
		frame_oam_tile $C9 + FIX_CREDITS_GRAMMAR, $F6, 3, $20
		frame_oam_tile $C0, $F6, $200,	$20
.IF FIX_CREDITS_GRAMMAR
		frame_oam_tile $10, $DF, $1204, 0
.ENDIF
		frame_oam_tile $4B, $E, $200, $20
		frame_oam_tile $41, $E, 1, $20
		frame_oam_tile $37, $E, $200, $20
		frame_oam_tile $2C, $E, $2201,	$20
		frame_oam_tile $22, $E, $200, $20
		frame_oam_tile $18, $E, $2000,	$20
		frame_oam_tile 5, $E, $2200, $20
		frame_oam_tile $FD, $E, $2600,	$20
		frame_oam_tile $F3, $E, $203, $20
		frame_oam_tile $E9, $E, $2202,	$20
		frame_oam_tile $DF, $E, $2601,	$20
		frame_oam_tile $D4, $E, $2201,	$20
		frame_oam_tile $CA, $E, $2601,	$20
		frame_oam_tile $C0, $E, 3, $20
		frame_oam_tile 8, $DF,	$1104, 0
		frame_oam_tile 0, $DF,	$404, 0
		frame_oam_tile $F8, $DF, $1204, 0
		frame_oam_tile $F0, $DF, $605,	0
		frame_oam_tile $E8, $E1, $705,	0
		frame_oam_tile $E0, $DF, $405,	0
		frame_oam_tile $D8, $DF, $605,	0
		frame_oam_tile $D0, $DF, $204,	0
		frame_oam_tile $C0, $DF, $304,	0
		frame_oam_tile $B8, $DF, $505,	0
		frame_oam_tile $B0, $DF, $1404, 0
		frame_oam_tile $A0, $DF, $1204, 0
		frame_oam_tile $A8, $DF, $605,	0
animation_frame_C765E7:.BYTE $1B
		frame_oam_tile $DF, $DF, $605,	0
		frame_oam_tile $D7, $DF, $1304, 0
		frame_oam_tile $D1, $DF, 5, 0
		frame_oam_tile $CC, $DF, $104,	0
		frame_oam_tile $C6, $DF, 5, 0
		frame_oam_tile $C1, $DF, $605,	0
		frame_oam_tile $B9, $DF, $404,	0
		frame_oam_tile $B1, $DF, $405,	0
		frame_oam_tile $A0, $E1, $1005, 0
		frame_oam_tile $A8, $DF, $1404, 0
		frame_oam_tile $63, $F6, $2200, $20
		frame_oam_tile $5B, $F6, $2600, $20
		frame_oam_tile $51, $F6, $200,	$20
		frame_oam_tile $46, $F6, $603,	$20
		frame_oam_tile $3C, $F6, $2601, $20
		frame_oam_tile $32, $F6, 1, $20
		frame_oam_tile $28, $F6, $200,	$20
		frame_oam_tile $1E, $F6, $2600, $20
		frame_oam_tile 9, $F6,	$2601, $20
		frame_oam_tile $FF, $F6, $402,	$20
		frame_oam_tile $F7, $F6, $2200, $20
		frame_oam_tile $EF, $F6, $2000, $20
		frame_oam_tile $E5, $F6, $203,	$20
		frame_oam_tile $DB, $F6, $602,	$20
		frame_oam_tile $D1, $F6, 3, $20
		frame_oam_tile $C9, $F6, $2200, $20
		frame_oam_tile $C0, $F6, $2201, $20
animation_frame_C7666F:.BYTE $17
		frame_oam_tile $3C, $F6, $2601, $20
		frame_oam_tile $34, $F6, $2200, $20
		frame_oam_tile $2C, $F6, $402,	$20
		frame_oam_tile $22, $F6, $2601, $20
		frame_oam_tile $18, $F6, $2000, $20
		frame_oam_tile 5, $F6,	$2200, $20
		frame_oam_tile $FC, $F6, $2201, $20
		frame_oam_tile $F2, $F6, $203,	$20
		frame_oam_tile $E8, $F6, $401,	$20
		frame_oam_tile $DE, $F6, $200,	$20
		frame_oam_tile $D4, $F6, $2600, $20
		frame_oam_tile $C0, $F6, 3, $20
		frame_oam_tile $CA, $F6, $200,	$20
		frame_oam_tile $E3, $DF, $1104, 0
		frame_oam_tile $DB, $DF, $605,	0
		frame_oam_tile $D3, $DF, $1204, 0
		frame_oam_tile $CD, $DF, 5, 0
		frame_oam_tile $C8, $DF, $1504, 0
		frame_oam_tile $C0, $DF, $1104, 0
		frame_oam_tile $B8, $DF, $404,	0
		frame_oam_tile $B0, $E1, $705,	0
		frame_oam_tile $A0, $DF, $1204, 0
		frame_oam_tile $A8, $DF, $1404, 0
animation_frame_C766E3:.BYTE $37
		frame_oam_tile $2E, $E, $200, $20
		frame_oam_tile $23, $E, $603, $20
		frame_oam_tile $19, $E, $200, $20
		frame_oam_tile $E, $E,	$2402, $20
		frame_oam_tile 4, $E, $203, $20
		frame_oam_tile $FA, $E, $2202,	$20
		frame_oam_tile $E8, $E, $200, $20
		frame_oam_tile $DE, $E, 2, $20
		frame_oam_tile $D4, $E, 2, $20
		frame_oam_tile $CA, $E, $200, $20
		frame_oam_tile $C0, $E, $2600,	$20
		frame_oam_tile $54, $F6, $2601, $20
		frame_oam_tile $4A, $F6, 3, $20
		frame_oam_tile $40, $F6, $2601, $20
		frame_oam_tile $35, $F6, $2201, $20
		frame_oam_tile $2B, $F6, $200,	$20
		frame_oam_tile $21, $F6, $2202, $20
		frame_oam_tile $19, $F6, $2200, $20
		frame_oam_tile $10, $F6, $2201, $20
		frame_oam_tile $FE, $F6, $2601, $20
		frame_oam_tile $F4, $F6, 3, $20
		frame_oam_tile $EC, $F6, $2200, $20
		frame_oam_tile $E4, $F6, $2000, $20
		frame_oam_tile $DC, $F6, $2200, $20
		frame_oam_tile $D4, $F6, $402,	$20
		frame_oam_tile $C0, $F6, $2401, $20
		frame_oam_tile $CA, $F6, $2601, $20
		frame_oam_tile $4D, $DE, $200,	$20
		frame_oam_tile $43, $DE, $402,	$20
		frame_oam_tile $39, $DE, $200,	$20
		frame_oam_tile $2E, $DE, $603,	$20
		frame_oam_tile $26, $DE, $2200, $20
		frame_oam_tile $1E, $DE, $2400, $20
		frame_oam_tile $14, $DE, $203,	$20
		frame_oam_tile $A, $DE, $401, $20
		frame_oam_tile $F8, $DE, $2200, $20
		frame_oam_tile $F0, $DE, $2600, $20
		frame_oam_tile $E6, $DE, $201,	$20
		frame_oam_tile $DB, $DE, $601,	$20
		frame_oam_tile $D3, $DE, $2200, $20
		frame_oam_tile $C0, $DE, $602,	$20
		frame_oam_tile $CB, $DE, $2000, $20
		frame_oam_tile 0, $C8,	$1204, 0
		frame_oam_tile $F8, $C8, $205,	0
		frame_oam_tile $F0, $C8, $505,	0
		frame_oam_tile $E8, $C8, 4, 0
		frame_oam_tile $E0, $C8, $704,	0
		frame_oam_tile $D8, $C8, $1304, 0
		frame_oam_tile $C8, $C8, $305,	0
		frame_oam_tile $C3, $C8, 4, 0
		frame_oam_tile $BD, $C8, 5, 0
		frame_oam_tile $B8, $C8, $204,	0
		frame_oam_tile $B0, $C8, $404,	0
		frame_oam_tile $A8, $CA, $705,	0
		frame_oam_tile $A0, $C8, $1204, 0
animation_frame_C767F7:.BYTE $13
		frame_oam_tile $26, $F6, $200,	$20
		frame_oam_tile $1B, $F6, $2201, $20
		frame_oam_tile $11, $F6, $200,	$20
		frame_oam_tile 7, $F6,	$2202, $20
		frame_oam_tile $FD, $F6, $201,	$20
		frame_oam_tile $F3, $F6, $203,	$20
		frame_oam_tile $E1, $F6, $2601, $20
		frame_oam_tile $D9, $F6, $2200, $20
		frame_oam_tile $D1, $F6, $2600, $20
		frame_oam_tile $C0, $F6, $2201, $20
		frame_oam_tile $C9, $F6, $2200, $20
		frame_oam_tile $D3, $DC, $1104, 0
		frame_oam_tile $CB, $DC, $605,	0
		frame_oam_tile $C3, $DC, $1304, 0
		frame_oam_tile $BB, $DC, $204,	0
		frame_oam_tile $B3, $DC, $404,	0
		frame_oam_tile $AB, $DC, $1104, 0
		frame_oam_tile $A0, $DC, $304,	0
		frame_oam_tile $A5, $DC, 5, 0
animation_frame_C76857:.BYTE $21 + FIX_CREDITS_GRAMMAR ; 1 Extra letter
.IF FIX_CREDITS_GRAMMAR
		frame_oam_tile $E0, $D7, $1204, 0
.ENDIF
		frame_oam_tile $51, 3,	$2200, $20
		frame_oam_tile $49, 3,	$2000, $20
		frame_oam_tile $3F, 3,	$602, $20
		frame_oam_tile $35, 3,	$200, $20
		frame_oam_tile $2B, 3,	$2202, $20
		frame_oam_tile $21, 3,	$200, $20
		frame_oam_tile $17, 3,	$400, $20
		frame_oam_tile $D, 3, $2601, $20
		frame_oam_tile 3, 3, $2600, $20
		frame_oam_tile $F1, 3,	$2200, $20
		frame_oam_tile $E9, 3,	$2600, $20
		frame_oam_tile $DF, 3,	$200, $20
		frame_oam_tile $D5, 3,	$602, $20
		frame_oam_tile $CB, 3,	$200, $20
		frame_oam_tile $C0, 3,	$2201, $20
		frame_oam_tile $1E, $EB, $200,	$20
		frame_oam_tile $13, $EB, $2201, $20
		frame_oam_tile 9, $EB,	$200, $20
		frame_oam_tile $FF, $EB, $2202, $20
		frame_oam_tile $F5, $EB, $2601, $20
		frame_oam_tile $EB, $EB, $200,	$20
		frame_oam_tile $D0, $EB, $2400, $20
		frame_oam_tile $C0, $EB, $201,	$20
		frame_oam_tile $D8, $D7, $1104, 0
		frame_oam_tile $D0, $D7, $404,	0
		frame_oam_tile $C8, $D7, $204,	0
		frame_oam_tile $C0, $D7, $1404, 0
		frame_oam_tile $B8, $D7, $304,	0
		frame_oam_tile $B0, $D7, $605,	0
		frame_oam_tile $A0, $D9, $705,	0
		frame_oam_tile $D8, $EB, $2200, $20
		frame_oam_tile $C8, $EB, $2200, $20
		frame_oam_tile $A8, $D7, $1104, 0
animation_frame_C76902:.BYTE $C
		frame_oam_tile $2E, $F6, 3, $20
		frame_oam_tile $24, $F6, $401,	$20
		frame_oam_tile $1A, $F6, $2601, $20
		frame_oam_tile $10, $F6, $602,	$20
		frame_oam_tile $CA, $F6, $2000, $20
		frame_oam_tile $DE, $F6, 1, $20
		frame_oam_tile $D4, $F6, $203,	$20
		frame_oam_tile $E8, $F6, $602,	$20
		frame_oam_tile $F2, $F6, $2601, $20
		frame_oam_tile $FC, $F6, $2401, $20
		frame_oam_tile $B0, $DF, $104,	0
		frame_oam_tile $B8, $E1, $1005, 0
animation_frame_C7693F:.BYTE 6
		frame_oam_tile $DC, $F7, $2203, $20
		frame_oam_tile $E6, $F6, $2403, $20
		frame_oam_tile $F0, $F6, $2603, $20
		frame_oam_tile $1C, $F6, $2204, $20
		frame_oam_tile $12, $F6, $2004, $20
		frame_oam_tile 8, $F6,	$2603, $20
byte_C7695E:	.BYTE 1
		animation_frame animation_frame_C76052, $FF
byte_C76963:	.BYTE 1
		animation_frame animation_frame_C7612F, $FF
byte_C76968:	.BYTE 1
		animation_frame animation_frame_C761BC, $FF
byte_C7696D:	.BYTE 1
		animation_frame animation_frame_C76262, $FF
byte_C76972:	.BYTE 1
		animation_frame animation_frame_C762E0, $FF
byte_C76977:	.BYTE 1
		animation_frame animation_frame_C76390, $FF
byte_C7697C:	.BYTE 1
		animation_frame animation_frame_C763FA, $FF
byte_C76981:	.BYTE 1
		animation_frame animation_frame_C76478, $FF
byte_C76986:	.BYTE 1
		animation_frame animation_frame_C76514, $FF
byte_C7698B:	.BYTE 1
		animation_frame animation_frame_C765E7, $FF
byte_C76990:	.BYTE 1
		animation_frame animation_frame_C7666F, $FF
byte_C76995:	.BYTE 1
		animation_frame animation_frame_C766E3, $FF
byte_C7699A:	.BYTE 1
		animation_frame animation_frame_C767F7, $FF
byte_C7699F:	.BYTE 1
		animation_frame animation_frame_C76857, $FF
byte_C769A4:	.BYTE 1
		animation_frame animation_frame_C76902, $FF
		.BYTE 1
		animation_frame animation_frame_C7693F, $FF
.A8
.I16

sub_C769AE:
		SEP	#$20
		LDA	#.LOBYTE(sub_C769DD)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C769DD)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C769DD)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C769CC
		JML	f:locret_C769DC
; ---------------------------------------------------------------------------

loc_C769CC:
		LDA	#$500
		STA	a:.LOWORD($20),Y
		LDA	z:$50
		STA	a:.LOWORD($30),Y
		LDA	z:$51
		STA	a:.LOWORD($31),Y

locret_C769DC:
		RTL
; End of function sub_C769AE

.A16
.I16

sub_C769DD:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C769EA
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C769EA:
		BIT	#$41
		BEQ	loc_C769F2
		JML	f:locret_C76A34
; ---------------------------------------------------------------------------

loc_C769F2:
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#8
		BNE	locret_C76A34
		LDA	a:.LOWORD(number_of_visible_bonuses) ; orig=0x0C91

loc_C769FF:
		CMP	#$20
		BCS	locret_C76A34
		DEC	z:$20,X
		BNE	locret_C76A34
		LDA	#1
		STA	z:$20,X
		JSL	f:sub_C43B6E
		BCS	locret_C76A34
		REP	#$20
		LDA	#$800
		STA	z:$20,X
		LDA	z:$30,X
		STA	z:$50
		LDA	z:$31,X
		STA	z:$51
		JSL	f:random2
		REP	#$20
		AND	#$E
		PHY
		TAY
		LDA	[$50],Y
		PLY
		JSL	f:create_bonus_object
.A8

locret_C76A34:
		RTL
; End of function sub_C769DD

; ---------------------------------------------------------------------------
word_C76A35:	.WORD 2, 2
		.WORD 9, $11
		.WORD $11, $D
		.WORD $D, $D
.A8
.I16

sub_C76A45:
		SEP	#$20
		LDA	#.LOBYTE(sub_C76A7B)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C76A7B)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C76A7B)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C76A63
		JML	f:locret_C769DC
; ---------------------------------------------------------------------------

loc_C76A63:
		TXA
		STA	a:.LOWORD($32),Y
		LDA	z:$11,X
		STA	a:.LOWORD($11),Y
		LDA	z:$14,X
		CLC
		ADC	#0
		STA	a:.LOWORD($14),Y
		LDA	z:$30,X
		STA	a:.LOWORD($30),Y
		RTL
; End of function sub_C76A45

.A16
.I16

sub_C76A7B:
		REP	#$20
		LDA	#$410
		STA	z:$E,X
		LDA	#8
		STA	z:$1E,X
		LDA	#.LOWORD(byte_C757D6)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDY	#7
		LDA	#.LOWORD(INTRO_BALOON_PALETTE)
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C76AB2)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C76AB2)
		STA	z:2,X

loc_C76AB2:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C76ABF
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C76ABF:
		BIT	#$41
		BEQ	loc_C76AC7
		JML	f:loc_C76ADD
; ---------------------------------------------------------------------------

loc_C76AC7:
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#8
		BEQ	loc_C76AD5
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C76AD5:
		LDA	z:$30,X
		BEQ	loc_C76ADD
		DEC	z:$30,X
		BRA	loc_C76B01
; ---------------------------------------------------------------------------
.A8

loc_C76ADD:
		REP	#$20
.A16
		LDY	z:$32,X
		LDA	a:.LOWORD($11),Y
		CLC
		ADC	#0
		STA	z:$11,X
		LDA	a:.LOWORD($14),Y
		CLC
		ADC	#$18
		STA	z:$14,X
		LDA	#$1010
		STA	z:$42
		LDA	#$2002
		STA	z:$44
		JSL	f:sub_C6353D

loc_C76B01:
		REP	#$20
		LDA	z:$14,X
		PHA
		LDA	#1
		STA	z:$14,X
		JSL	f:advance_animation_2
		REP	#$20
		PLA
		STA	z:$14,X
		RTL
; End of function sub_C76A7B

.A16
.I16

create_uiteru_v:
		SEP	#$20
.A8
		LDA	#.LOBYTE(uiteru_v)
		STA	z:$DB
		LDA	#.HIBYTE(uiteru_v)
		STA	z:$DC
		LDA	#.BANKBYTE(uiteru_v)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		TXA
		STA	a:.LOWORD($38),Y
		LDA	#$430
		STA	a:.LOWORD($E),Y
		LDA	#8
		STA	a:.LOWORD($1E),Y
		LDA	z:$11,X
		STA	a:.LOWORD($11),Y
		LDA	z:$14,X
		STA	a:.LOWORD($14),Y
		LDA	#$C0
		STA	a:.LOWORD($30),Y
		RTL
; End of function create_uiteru_v

.A16
.I16

uiteru_v:
		REP	#$20
		LDA	#.LOWORD(word_C76A35)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C76A35)
		STA	z:$52
		JSL	f:sub_C769AE
		JSL	f:sub_C76A45
		REP	#$20
.A16
		LDA	#0
		STA	z:$20,X
		LDA	#$10
		STA	z:$32,X
		LDA	#$100
		STA	z:$34,X
		LDA	#5
		STA	z:$36,X
		REP	#$20
		LDA	#.LOWORD(loc_C76BD5)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C76BD5)
		STA	z:2,X
		SEP	#$20
		LDY	#0
		LDA	#$75
		STA	z:$40
		LDA	#3
		JSL	f:palette_related
		LDA	#$79
		STA	z:$40
		LDA	#4
		JSL	f:palette_related
		LDA	#.LOWORD(POISON_PALETTE)
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		LDA	#.LOWORD(POISON_PALETTE)
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		REP	#$20
.A16
		LDA	#.LOWORD(compressed_spiderer_tilemap+$FC)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(compressed_spiderer_tilemap+$FC)
		STA	z:$55
		JSL	f:tilemap_decompression
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C77137)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C77137)
		STA	z:$52
		JSL	f:sub_C62514

loc_C76BD5:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C76BE2
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C76BE2:
		BIT	#$41
		BEQ	loc_C76BEA
		JML	f:loc_C76D6C
; ---------------------------------------------------------------------------

loc_C76BEA:
		REP	#$20
.A16
		LDA	z:$13,X
		SEC
		SBC	#$20
		STA	z:$13,X
		DEC	z:$30,X
		BEQ	loc_C76BFC
		JML	f:loc_C76D6C
; ---------------------------------------------------------------------------

loc_C76BFC:
		LDA	#$80
		STA	z:$30,X
		REP	#$20
		LDA	#.LOWORD(loc_C76C0E)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C76C0E)
		STA	z:2,X

loc_C76C0E:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C76C1B
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C76C1B:
		BIT	#$41
		BEQ	loc_C76C23
		JML	f:loc_C76D6C
; ---------------------------------------------------------------------------

loc_C76C23:
		REP	#$20
.A16
		DEC	z:$30,X
		BEQ	loc_C76C2D
		JML	f:loc_C76D6C
; ---------------------------------------------------------------------------

loc_C76C2D:
		REP	#$20
		LDA	#.LOWORD(loc_C76C3A)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C76C3A)
		STA	z:2,X

loc_C76C3A:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C76C47
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C76C47:
		BIT	#$41
		BEQ	loc_C76C4F
		JML	f:loc_C76D6C
; ---------------------------------------------------------------------------

loc_C76C4F:
		REP	#$20
.A16
		LDA	#.LOWORD(word_C76D91)
		STA	z:$DB
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C76D91)
		STA	z:$DD
		REP	#$20
.A16
		DEC	z:$32,X
		BMI	loc_C76C66
		JML	f:loc_C76CF6
; ---------------------------------------------------------------------------

loc_C76C66:
		JSL	f:follower_movement_2
		REP	#$20
		LDA	z:$2A,X
		PHA
		JSL	f:sub_C63BF9
		REP	#$20
		STA	z:$40
		PLA
		STA	z:$2A,X
		LDA	z:$40
		AND	#$F
		ASL
		ASL
		ASL
		PHA
		JSL	f:sub_C76F62
		PLY
		INC	z:$20,X
		LDA	z:$20,X
		AND	#$1F
		ASL
		ASL
		PHX
		TAX
		LDA	z:$53
		STA	z:$40
		LDA	f:word_C76D91,X
		BPL	loc_C76CA1
		EOR	#$FFFF
		INC

loc_C76CA1:
		STA	z:$42
		LDA	f:word_C76D91,X
		EOR	[$DB],Y
		BIT	#$8000
		BEQ	loc_C76CB2
		LSR	z:$42
		LSR	z:$42

loc_C76CB2:
		JSL	f:sub_C76F41
		STA	z:$53
		LDA	z:$56
		STA	z:$40
		LDA	f:word_C76D91+2,X
		BPL	loc_C76CC6
		EOR	#$FFFF
		INC

loc_C76CC6:
		STA	z:$42
		LDA	f:word_C76D91+2,X
		INY
		INY
		EOR	[$DB],Y
		BIT	#$8000
		BEQ	loc_C76CD9
		LSR	z:$42
		LSR	z:$42

loc_C76CD9:
		JSL	f:sub_C76F41
		CLC
		ADC	z:$53
		LSR
		CMP	#2
		BPL	loc_C76CEB
		LDA	#2
		BRA	loc_C76CF3
; ---------------------------------------------------------------------------

loc_C76CEB:
		CMP	#$18
		BCC	loc_C76CF3
		LDA	#$18

loc_C76CF3:
		PLX
		STA	z:$32,X

loc_C76CF6:
		REP	#$20
		LDA	z:$20,X
		AND	#$1F
		ASL
		ASL
		TAY
		STZ	z:$40
		LDA	[$DB],Y
		BPL	loc_C76D08
		DEC	z:$40

loc_C76D08:
		CLC
		ADC	z:$10,X
		STA	z:$10,X
		SEP	#$20
.A8
		LDA	z:$40
		ADC	z:$12,X
		STA	z:$12,X
		REP	#$20
.A16
		STZ	z:$40
		INY
		INY
		LDA	[$DB],Y
		BPL	loc_C76D21
		DEC	z:$40

loc_C76D21:
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		SEP	#$20
.A8
		LDA	z:$40
		ADC	z:$15,X
		STA	z:$15,X
		JSL	f:sub_C76EE6
		REP	#$20
.A16
		LDA	z:$46
		BEQ	loc_C76D4C
		LDY	#$17
		JSL	f:play_sound
		REP	#$20
		LDA	#.LOWORD(sub_C76E11)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C76E11)
		STA	z:2,X

loc_C76D4C:
		REP	#$20
.A16
		DEC	z:$34,X
		BNE	loc_C76D6C
		LDA	#$100
		STA	z:$34,X
		LDA	a:.LOWORD(number_of_visible_bonuses) ; orig=0x0C91
		CMP	#$20
		BCS	loc_C76D6C
		JSL	f:sub_C76F8F
		REP	#$20
		BCC	loc_C76D6C
		LDA	#$80
		STA	z:$34,X
.A8

loc_C76D6C:
		REP	#$20
.A16
		LDA	z:$11,X
		SEC
		SBC	#$78
		EOR	#$FFFF
		INC
		CLC
		ADC	#$88
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	z:$14,X
		SEC
		SBC	#$70
		EOR	#$FFFF
		INC
		CLC
		ADC	#$88
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		RTL
; End of function uiteru_v

; ---------------------------------------------------------------------------
word_C76D91:	.WORD 0, $FF00
		.WORD $20, $FF20
		.WORD $40, $FF40
		.WORD $60, $FF60
		.WORD $80, $FF80
		.WORD $A0, $FFA0
		.WORD $C0, $FFC0
		.WORD $E0, $FFE0
		.WORD $100, 0
		.WORD $E0, $20
		.WORD $C0, $40
		.WORD $A0, $60
		.WORD $80, $80
		.WORD $60, $A0
		.WORD $40, $C0
		.WORD $20, $E0
		.WORD 0, $100
		.WORD $FFE0, $E0
		.WORD $FFC0, $C0
		.WORD $FFA0, $A0
		.WORD $FF80, $80
		.WORD $FF60, $60
		.WORD $FF40, $40
		.WORD $FF20, $20
		.WORD $FF00, 0
		.WORD $FF20, $FFE0
		.WORD $FF40, $FFC0
		.WORD $FF60, $FFA0
		.WORD $FF80, $FF80
		.WORD $FFA0, $FF60
		.WORD $FFC0, $FF40
		.WORD $FFE0, $FF20
.A16
.I16

sub_C76E11:
		REP	#$20
		LDA	#$80
		STA	z:$30,X
		REP	#$20
		LDA	#.LOWORD(word_C76EDE)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C76EDE)
		STA	z:$55
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C76EAF+1)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C76EAF+1)
		STA	z:$52
		JSL	f:sub_C62514
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C76E43)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C76E43)
		STA	z:2,X

loc_C76E43:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C76E50
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C76E50:
		BIT	#$41
		BEQ	loc_C76E58
		JML	f:loc_C76D6C
; ---------------------------------------------------------------------------

loc_C76E58:
		REP	#$20
.A16
		LDA	z:$30,X
		AND	#1
		PHX
		TAX
		LDA	f:sub_C76EAE,X
		STA	z:$40
		PLX
		LDY	#0
		LDA	#3
		JSL	f:palette_related
		REP	#$20
		DEC	z:$30,X
		BNE	loc_C76EAB
		DEC	z:$36,X
		BNE	loc_C76E80
		JML	f:sub_C77161
; ---------------------------------------------------------------------------

loc_C76E80:
		REP	#$20
		LDA	#.LOWORD(word_C76ED6)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C76ED6)
		STA	z:$55
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C76EAF+1)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C76EAF+1)
		STA	z:$52
		JSL	f:sub_C62514
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C76C3A)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C76C3A)
		STA	z:2,X

loc_C76EAB:
		JMP	a:.LOWORD(loc_C76D6C)
; End of function sub_C76E11

.A8
.I16

sub_C76EAE:
		SEI

loc_C76EAF:
		ADC	z:$E2,X
		JSR	a:$81A9 ; That's sound data? What's going on...?
		STA	a:.LOWORD(VRAM_ADDRESS_INCREMENT_VALUE)
		REP	#$20
.A16
		LDA	#$55AF
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDY	#0

loc_C76EC2:
		LDA	[$53],Y
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		INY
		INY
		CPY	#6
		BNE	loc_C76EC2
		SEP	#$20
.A8
		LDA	#$80
		STA	a:.LOWORD(VRAM_ADDRESS_INCREMENT_VALUE)
		RTL
; End of function sub_C76EAE

; ---------------------------------------------------------------------------
word_C76ED6:	.WORD $3240, $3242, $3244, 0
word_C76EDE:	.WORD $3246, $3248, $324A, 0
.A8
.I16

sub_C76EE6:
		JSL	f:get_object_square_index
		REP	#$20
.A16
		SEC
		SBC	#$42
		TAY
		LDA	#0
		STA	z:$46
		LDA	#2
		STA	z:$42

loc_C76EFB:
		LDA	#3
		STA	z:$40

loc_C76F00:
		TYA
		BMI	loc_C76F29
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$20
		BEQ	loc_C76F29
		AND	#$23F
		CMP	#$23F
		BEQ	loc_C76F3A
		PHY
		SEP	#$20
.A8
		LDA	z:2,X
		PHA
		LDA	#1
		STA	z:2,X
		JSL	f:sub_C45B9A
		SEP	#$20
		PLA
		STA	z:2,X
		PLY
		REP	#$20
.A16

loc_C76F29:
		INY
		INY
		DEC	z:$40
		BNE	loc_C76F00
		TYA
		CLC
		ADC	#$3A
		TAY
		DEC	z:$42
		BNE	loc_C76EFB
		RTL
; ---------------------------------------------------------------------------

loc_C76F3A:
		LDA	#1
		STA	z:$46
		BRA	loc_C76F29
; End of function sub_C76EE6

.A16
.I16

sub_C76F41:
		REP	#$20
		LDA	z:$42
		LSR
		LSR
		LSR
		LSR
		LSR
		SEP	#$20
.A8
		STA	a:.LOWORD(MULTIPLICAND_A)
		LDA	z:$40
		STA	a:.LOWORD(MULTPLIER_B)
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		REP	#$20
.A16
		LDA	a:.LOWORD(PRODUCT_REMAINDER_RESULT_LOW_BYTE)
		RTL
; End of function sub_C76F41

.A16
.I16

sub_C76F62:
		REP	#$20
		LDA	a:.LOWORD($11),Y
		AND	#$FF
		SEC
		SBC	z:$11,X
		BPL	loc_C76F73
		EOR	#$FFFF
		INC

loc_C76F73:
		LSR
		LSR
		LSR
		LSR
		STA	z:$53
		LDA	a:.LOWORD($14),Y
		AND	#$FF
		SEC
		SBC	z:$14,X
		BPL	loc_C76F88
		EOR	#$FFFF
		INC

loc_C76F88:
		LSR
		LSR
		LSR
		LSR
		STA	z:$56
		RTL
; End of function sub_C76F62

.A16
.I16

sub_C76F8F:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C76FD6)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C76FD6)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C76FD6)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	locret_C76FD5
		LDA	z:$11,X
		STA	a:.LOWORD($11),Y
		LDA	z:$14,X
		STA	a:.LOWORD($14),Y
		LDA	#$430
		STA	a:.LOWORD($E),Y
		LDA	#$A
		STA	a:.LOWORD($1E),Y
		LDA	#$20
		STA	a:.LOWORD($20),Y
		LDA	#$FFFF
		STA	z:$48
		JSL	f:sub_C45DB3
		BCC	locret_C76FD5
		JSL	f:delete_object
		SEC

locret_C76FD5:
		RTL
; End of function sub_C76F8F

.A16
.I16

sub_C76FD6:
		REP	#$20
		LDA	#.LOWORD(byte_C757C4)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		LDY	#7
		JSL	f:play_sound
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C76FFB)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C76FFB)
		STA	z:2,X

loc_C76FFB:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C77008
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C77008:
		BIT	#$41
		BEQ	loc_C77010
		JML	f:loc_C77072
; ---------------------------------------------------------------------------

loc_C77010:
		REP	#$20
.A16
		LDA	z:$10,X
		CLC
		ADC	z:$1A,X
		STA	z:$10,X
		STZ	z:$42
		LDA	z:$1C,X
		CLC
		ADC	z:$18,X
		STA	z:$1C,X
		BPL	loc_C77026
		DEC	z:$42

loc_C77026:
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		SEP	#$20
.A8
		LDA	z:$42
		ADC	z:$15,X
		STA	z:$15,X
		DEC	z:$20,X
		BNE	loc_C77072
		LDA	z:$16,X
		STA	z:$11,X
		LDA	z:$17,X
		STA	z:$14,X
		STZ	z:$12,X
		STZ	z:$15,X
		LDA	#8
		STA	z:$3E,X
		LDA	z:$1B,X
		BPL	loc_C7704F
		LDA	#$18
		STA	z:$3E,X

loc_C7704F:
		LDA	z:$3E,X
		STZ	z:$3F,X
		REP	#$20
.A16
		AND	#$18
		PHX
		TAX
		LDA	f:byte_C3075F,X
		STA	z:$40
		PLX
		LDA	z:$40
		STA	z:$16,X
		REP	#$20
		LDA	#.LOWORD(sub_C77077)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C77077)
		STA	z:2,X

loc_C77072:
		JSL	f:advance_animation
		RTL
; End of function sub_C76FD6

.A8
.I16

sub_C77077:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C77084
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C77084:
		BIT	#$41
		BEQ	loc_C7708C
		JML	f:loc_C77121
; ---------------------------------------------------------------------------

loc_C7708C:
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C3075F)
		STA	z:$DB
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_C3075F)
		STA	z:$DD
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C3075F+6)
		STA	z:$DE
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_C3075F+6)
		STA	z:$E0
		REP	#$20
.A16
		LDA	z:$3E,X
		AND	#$38
		TAY
		SEP	#$20
.A8
		LDA	z:$3F,X
		AND	#$3F
		CMP	[$DE],Y
		BEQ	loc_C770BC
		JML	f:loc_C770F5
; ---------------------------------------------------------------------------

loc_C770BC:
		JSL	f:get_object_square_index
		REP	#$20
.A16
		TAY
		LDA	a:.LOWORD(collision_map),Y
		AND	#$3FF
		BNE	loc_C770CF
		JML	f:loc_C77126
; ---------------------------------------------------------------------------

loc_C770CF:
		SEP	#$20
.A8
		LDA	z:$3E,X
		ORA	#$20
		STA	z:$3E,X
		LDA	z:$11,X
		AND	#$F0
		ORA	#8
		STA	z:$11,X
		LDA	z:$14,X
		AND	#$F0
		ORA	#8
		STA	z:$14,X
		STZ	z:$3F,X
		REP	#$20
.A16
		LDA	z:$3E,X
		AND	#$38
		TAY
		LDA	[$DB],Y
		STA	z:$16,X
.A8

loc_C770F5:
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C3075F+2)
		STA	z:$DB
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_C3075F+2)
		STA	z:$DD
		REP	#$20
.A16
		LDA	[$DB],Y
		STA	z:$40
		JSL	f:sub_C4572E
		BCS	locret_C77125
		INY
		INY
		LDA	[$DB],Y
		CLC
		ADC	z:$10,X
		STA	z:$10,X
		SEP	#$20
.A8
		INC	z:$3F,X
		LDA	z:$3F,X
		AND	#$3F
		STA	z:$3F,X

loc_C77121:
		JSL	f:advance_animation

locret_C77125:
		RTL
; ---------------------------------------------------------------------------
.A16

loc_C77126:
		REP	#$20
		LDA	#$F
		STA	a:.LOWORD(collision_map),Y
		JSL	f:create_bonus_object
		JSL	f:delete_object
		RTL
; End of function sub_C77077

.A16
.I16

sub_C77137:
		REP	#$20
		LDA	#$5400
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$800
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(unexpanded_collision_map)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unexpanded_collision_map)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		RTL
; End of function sub_C77137

; ---------------------------------------------------------------------------
word_C77159:	.WORD $1F, $1F,	$120, 3
.A16
.I16

sub_C77161:
		REP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		LDA	#$200
		STA	z:$3E,X
		LDA	z:$14,X
		PHA
		LDA	z:$14,X
		SEC
		SBC	#$20
		STA	z:$14,X
		REP	#$20
		LDA	#.LOWORD(word_C77159)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C77159)
		STA	z:$52
		JSL	f:sub_C631D7
		REP	#$20
.A16
		PLA
		STA	z:$14,X
		SEP	#$20
.A8
		PHX
		LDX	#$D40
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	z:$20,X
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		SEP	#$20
		LDX	#$D80
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	z:$20,X
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		PLX
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C771C3)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C771C3)
		STA	z:2,X

loc_C771C3:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C771D0
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C771D0:
		BIT	#$41
		BEQ	loc_C771D8
		JML	f:loc_C771F7
; ---------------------------------------------------------------------------

loc_C771D8:
		REP	#$20
.A16
		LDA	z:$3E,X
		DEC	z:$3E,X
		BNE	loc_C771E4
		JML	f:sub_C77292
; ---------------------------------------------------------------------------

loc_C771E4:
		CMP	#$100
		BNE	loc_C771F7
		LDA	#$2E
		STA	z:$40
		LDA	#.LOWORD(WHITE_PALETTE)
		STA	z:$42
		JSL	f:sub_C77490
.A8

loc_C771F7:
		REP	#$20
.A16
		LDA	z:$3E,X
		CMP	#$60
		BNE	nullsub_10
		REP	#$20
		LDA	#$FFFF
		STA	z:$40
		JSL	f:sub_C7720C
; End of function sub_C77161

.A16
.I16
nullsub_10:
		RTL
.A16
.I16

sub_C7720C:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C77232)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C77232)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C77232)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	nullsub_10
		LDA	#1
		STA	a:.LOWORD($10),Y
		LDA	z:$40
		STA	a:.LOWORD($12),Y
		RTL
; End of function sub_C7720C

.A16
.I16

sub_C77232:
		REP	#$20
		DEC	z:$12,X
		BNE	loc_C7723C
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C7723C:
		DEC	z:$10,X
		BNE	nullsub_10
		LDA	#$10
		STA	z:$10,X
		LDY	#4
		JSL	f:play_sound
		RTL
; End of function sub_C77232

.A16
.I16

sub_C7724D:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C77277)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C77277)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C77277)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C7726B
		JML	f:nullsub_10
; ---------------------------------------------------------------------------

loc_C7726B:
		LDA	#1
		STA	a:.LOWORD($10),Y
		LDA	z:$40
		STA	a:.LOWORD($12),Y
		RTL
; End of function sub_C7724D

.A16
.I16

sub_C77277:
		REP	#$20
		DEC	z:$12,X
		BNE	loc_C77281
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C77281:
		DEC	z:$10,X
		BNE	nullsub_10
		LDA	#$10
		STA	z:$10,X
		LDY	#$1A
		JSL	f:play_sound
		RTL
; End of function sub_C77277

.A16
.I16

sub_C77292:
		PHX
		JSL	f:sub_C4245D
		LDX	#$D40
		REP	#$20
		LDA	#$68
		STA	z:$11,X
		LDA	#$B8
		STA	z:$14,X
		REP	#$20
		LDA	#.LOWORD(sub_C4273F)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C4273F)
		STA	z:2,X
		LDX	#$D80
		REP	#$20
.A16
		LDA	#$A8
		STA	z:$11,X
		LDA	#$B8
		STA	z:$14,X
		REP	#$20
		LDA	#.LOWORD(sub_C4273F)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C4273F)
		STA	z:2,X
		PLX
		JSL	f:sub_C774F0
		REP	#$20
.A16
		LDA	#$150
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	#$C30
		STA	z:$40
		LDA	#8
		STA	z:$42
		LDA	#0
		STA	z:$44
		LDA	#$A8
		STA	z:$46
		LDA	#$58
		STA	z:$48
		REP	#$20
		LDA	#.LOWORD(off_C71F3D)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C71F3D)
		STA	z:$52
		JSL	f:sub_C773D7
		REP	#$20
.A16
		LDA	#$930
		STA	z:$40
		LDA	#$A
		STA	z:$42
		LDA	#1
		STA	z:$44
		LDA	#$68
		STA	z:$46
		LDA	#$58
		STA	z:$48
		REP	#$20
		LDA	#.LOWORD(off_C71F6D)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C71F6D)
		STA	z:$52
		JSL	f:sub_C773D7
		REP	#$20
.A16
		LDA	#$408
		STA	a:.LOWORD(bg1_tilemap+$30E) ; orig=0x0802
		LDA	#$408
		STA	a:.LOWORD(bg1_tilemap+$310) ; orig=0x0804
		LDA	#$408
		STA	a:.LOWORD(bg1_tilemap+$312) ; orig=0x0806
		LDA	#$280
		STA	z:$20,X
		LDA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		STA	z:$22,X
		REP	#$20
		LDA	#.LOWORD(loc_C7735D)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C7735D)
		STA	z:2,X

loc_C7735D:
		REP	#$20
.A16
		DEC	z:$20,X
		LDA	z:$20,X
		AND	#$F
		ASL
		PHX
		TAX
		LDA	f:word_C773B7,X
		PLX
		CLC
		ADC	z:$22,X
		STA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		LDA	z:$20,X
		CMP	#$180
		BEQ	loc_C77390
		CMP	#0
		BNE	locret_C7738F
		SEP	#$20
.A8
		LDA	#$39
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		JSL	f:fade_out_music
		JSL	f:delete_object

locret_C7738F:
		RTL
; ---------------------------------------------------------------------------

loc_C77390:
		REP	#$20
.A16
		PHX
		LDX	#$D40
		LDA	#0
		STA	z:$40
		LDA	#1
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		LDX	#$D80
		LDA	#0
		STA	z:$40
		LDA	#1
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		PLX
		RTL
; End of function sub_C77292

; ---------------------------------------------------------------------------
word_C773B7:	.WORD $FFFC, $0001, $0003, $FFFF
		.WORD $0002, $0000, $0001, $FFFE
		.WORD $FFFF, $FFFC, $0000, $0002
		.WORD $FFFF, $0002, $FFFE, $FFFF
.A8
.I16

sub_C773D7:
		SEP	#$20
		LDA	#.LOBYTE(sub_C77415)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C77415)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C77415)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCS	locret_C77414
		REP	#$20
.A16
		LDA	z:$50
		STA	a:.LOWORD($18),Y
		LDA	z:$51
		STA	a:.LOWORD($19),Y
		LDA	z:$40
		STA	a:.LOWORD($E),Y
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		LDA	z:$44
		STA	a:.LOWORD($20),Y
		LDA	z:$46
		STA	a:.LOWORD($11),Y
		LDA	z:$48
		STA	a:.LOWORD($14),Y

locret_C77414:
		RTL
; End of function sub_C773D7

.A16
.I16

sub_C77415:
		REP	#$20
		LDA	#$60
		STA	z:$30,X
		LDA	#9
		STA	z:$40
		JSL	f:sub_C57F9F
		REP	#$20
		LDA	#.LOWORD(loc_C77432)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C77432)
		STA	z:2,X

loc_C77432:
		REP	#$20
.A16
		DEC	z:$30,X
		BNE	loc_C7745C
		LDA	#8
		STA	z:$30,X
		LDA	#$FFFF
		STA	z:$32,X
		LDA	z:$20,X
		BNE	loc_C7744B
		LDA	#1
		STA	z:$32,X

loc_C7744B:
		REP	#$20
		LDA	#.LOWORD(loc_C77461)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C77461)
		STA	z:2,X
		REP	#$20
.A16
		BRA	loc_C77473
; ---------------------------------------------------------------------------

loc_C7745C:
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C77461:
		REP	#$20
		LDA	z:$11,X
		CLC
		ADC	z:$32,X
		STA	z:$11,X
		DEC	z:$30,X
		BNE	loc_C7748B
		LDA	#$10
		STA	z:$30,X

loc_C77473:
		LDA	#1
		STA	z:$40
		LDA	z:$32,X
		EOR	#$FFFF
		INC
		STA	z:$32,X
		BPL	loc_C77487
		LDA	#2
		STA	z:$40

loc_C77487:
		JSL	f:sub_C57F9F

loc_C7748B:
		JSL	f:advance_animation
		RTL
; End of function sub_C77415

.A16
.I16

sub_C77490:
		SEP	#$20
.A8
		LDY	#7
		LDA	#0
		JSL	f:palette_related
		LDA	#1
		JSL	f:palette_related
		LDA	#2
		JSL	f:palette_related
		LDA	#3
		JSL	f:palette_related
		LDA	#4
		JSL	f:palette_related
		LDA	#5
		JSL	f:palette_related
		LDA	#6
		JSL	f:palette_related
		LDA	#7
		JSL	f:palette_related
		LDA	z:$42
		STA	z:$40
		LDA	#8
		JSL	f:palette_related
		LDA	#9
		JSL	f:palette_related
		LDA	#$A
		JSL	f:palette_related
		LDA	#$B
		JSL	f:palette_related
		LDA	#$C
		JSL	f:palette_related
		LDA	#$D
		JSL	f:palette_related
		REP	#$20
.A16
		RTL
; End of function sub_C77490

.A8
.I16

sub_C774F0:
		SEP	#$20
		LDY	#7
		LDA	#0
		STA	z:$40
		LDA	#0
		JSL	f:palette_related
		LDA	#$40
		STA	z:$40
		LDA	#1
		JSL	f:palette_related
		LDA	#$41
		STA	z:$40
		LDA	#2
		JSL	f:palette_related
		LDA	#4
		STA	z:$40
		LDA	#4
		JSL	f:palette_related
		LDA	#5
		STA	z:$40
		LDA	#5
		JSL	f:palette_related
		LDA	#$42
		STA	z:$40
		LDA	#6
		JSL	f:palette_related
		LDA	#$43
		STA	z:$40
		LDA	#7
		JSL	f:palette_related
		LDA	#.LOWORD(SHIRO_PALETTE)
		STA	z:$40
		LDA	#8
		JSL	f:palette_related
		LDA	#.LOWORD(KURO_PALETTE)
		STA	z:$40
		LDA	#9
		JSL	f:palette_related
		LDA	#.LOWORD(MOOK_PALETTE)
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		LDA	#.LOWORD(CARAT_DIAMOND_PALETTE)
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		RTL
; End of function sub_C774F0

.A8
.I16

sub_C77564:
		SEP	#$20
		LDA	#$F
		STA	a:.LOWORD(V_COUNT_TIMER)
		LDA	#$80
		STA	a:.LOWORD(H_COUNT_TIMER)
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C77580)
		STA	a:.LOWORD(unknown_function_pointer) ; orig=0x00D0
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C77580)
		STA	a:.LOWORD(unknown_function_pointer+2) ; orig=0x00D2
		RTL
; End of function sub_C77564

.A8
.I16

sub_C77580:
		SEP	#$20
		LDA	#$9F
		STA	a:.LOWORD(V_COUNT_TIMER)
		LDA	#$80
		STA	a:.LOWORD(H_COUNT_TIMER)
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C7759C)
		STA	a:.LOWORD(unknown_function_pointer) ; orig=0x00D0
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C7759C)
		STA	a:.LOWORD(unknown_function_pointer+2) ; orig=0x00D2
		RTL
; End of function sub_C77580

.A8
.I16

sub_C7759C:
		SEP	#$20
		LDA	#$4F
		STA	a:.LOWORD(V_COUNT_TIMER)
		LDA	#$80
		STA	a:.LOWORD(H_COUNT_TIMER)
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C77580)
		STA	a:.LOWORD(unknown_function_pointer) ; orig=0x00D0
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C77580)
		STA	a:.LOWORD(unknown_function_pointer+2) ; orig=0x00D2
		LDA	#$10
		STA	a:.LOWORD(BG_AND_OBJECT_ENABLE_MAIN_SCREEN)
		LDA	#0
		STA	a:.LOWORD(BG_AND_OBJECT_ENABLE_SUB_SCREEN)
		LDA	#0
		STA	a:.LOWORD(INITIAL_SETTINGS_FOR_COLOR_ADDITION)
		LDA	#0
		STA	a:.LOWORD(ADD_SUBTRACT_SELECT_AND_ENABLE)
		RTL
; End of function sub_C7759C

.A8
.I16

sub_C775CC:
		SEP	#$20
		LDA	#.LOBYTE(sub_C775FF)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C775FF)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C775FF)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		REP	#$20
.A16
		LDA	#$20
		STA	a:.LOWORD($20),Y
		LDA	#0
		STA	a:.LOWORD($22),Y
		JSL	f:sub_C77734
		RTL
; End of function sub_C775CC

.A16
.I16

sub_C775FF:
		SEP	#$20
.A8
		LDA	#$11
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$12
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#2
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#1
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C77638)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C77638)
		STA	z:2,X
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C77564)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C77564)
		STA	z:$52
		PHX
		PHY
		JSL	f:sub_C62514
		PLY
		PLX
		RTL
; End of function sub_C775FF

.A8
.I16

sub_C77638:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	locret_C77656
		LDA	#$A0
		STA	z:$20,X
		JSL	f:sub_C77657
		REP	#$20
		INC	z:$22,X
		LDA	z:$22,X
		CMP	#$F
		BNE	locret_C77656
		JML	f:delete_object
; ---------------------------------------------------------------------------

locret_C77656:
		RTL
; End of function sub_C77638

.A16
.I16

sub_C77657:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C77675)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C77675)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C77675)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		LDA	z:$22,X
		STA	a:.LOWORD($22),Y
		RTL
; End of function sub_C77657

.A16
.I16

sub_C77675:
		REP	#$20
		LDA	#$30
		STA	z:$E,X
		LDA	#0
		STA	z:$1E,X
		LDA	#$80
		STA	z:$11,X
		LDA	#$180
		STA	z:$14,X
		LDA	#$100
		STA	z:$20,X
		LDA	z:$22,X
		ASL
		PHX
		TAX
		LDA	f:off_C778E3,X
		STA	z:$50
		PLX
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C776B3)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C776B3)
		STA	z:2,X

loc_C776B3:
		REP	#$20
.A16
		LDA	z:$13,X
		CLC
		ADC	#$FF00
		STA	z:$13,X
		LDA	z:$15,X
		ADC	#$FF
		STA	z:$15,X
		LDA	z:$14,X
		CMP	#$FF80
		BNE	loc_C776CF
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C776CF:
		JSL	f:load_animation_frame
		RTL
; End of function sub_C77675

.A16
.I16

sub_C776D4:
		SEP	#$20
.A8
		DEC	z:$20,X
		BNE	locret_C776EB
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C776E7)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C776E7)
		STA	z:2,X

loc_C776E7:
		JSL	f:load_animation_frame

locret_C776EB:
		RTL
; End of function sub_C776D4

; ---------------------------------------------------------------------------
unk_C776EC:	.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $7D
		.BYTE	0
		.BYTE	1
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $A0
		.BYTE	0
		.BYTE $81
		.BYTE	0
		.BYTE	5
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $40
		.BYTE	1
		.BYTE $7E
		.BYTE	0
		.BYTE	2
		.BYTE	0
		.BYTE	0
		.BYTE	1
		.BYTE	0
		.BYTE	0
		.BYTE $82
		.BYTE	0
		.BYTE	6
		.BYTE	0
		.BYTE	0
		.BYTE	1
		.BYTE	0
		.BYTE	1
byte_C77710:	.BYTE 0
		.BYTE 0
		.BYTE $50
		.BYTE 0
		.ADDR CREDITS_SEPIA_PALETTE_2
		.BYTE 3
		.BYTE 0
		.BYTE 0
		.BYTE 0
		.BYTE $F0
		.BYTE 0
		.ADDR CREDITS_SEPIA_PALETTE_3
		.BYTE 4
		.BYTE 0
		.BYTE 0
		.BYTE 0
		.BYTE $90
		.BYTE 1
		.ADDR CREDITS_SEPIA_PALETTE_1
		.BYTE 1
		.BYTE 0
		.BYTE 0
		.BYTE 1
		.BYTE $50
		.BYTE 0
		.ADDR CREDITS_END_PALETTE
		.BYTE 7
		.BYTE 0
		.BYTE 0
		.BYTE 1
		.BYTE 0
		.BYTE 1
.A16
.I16

sub_C77734:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C7774F)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C7774F)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C7774F)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		JSL	f:sub_C777E6
		RTL
; End of function sub_C77734

.A8
.I16

sub_C7774F:
		REP	#$20
.A16
		LDA	#$20
		STA	z:$20,X
		LDA	#0
		STA	z:$22,X
		LDA	#0
		STA	z:$30,X
		LDA	#$100
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	#$100
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		REP	#$20
		LDA	#.LOWORD(loc_C77779)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C77779)
		STA	z:2,X

loc_C77779:
		REP	#$20
.A16
		DEC	z:$20,X
		BEQ	loc_C77783
		JML	f:locret_C777E5
; ---------------------------------------------------------------------------

loc_C77783:
		LDA	#$180
		STA	z:$20,X
		LDY	#0
		REP	#$20
		LDA	#.LOWORD(unk_C776EC)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_C776EC)
		STA	z:$52
		JSL	f:sub_C77822
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C777AA)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C777AA)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C777AA:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	locret_C777E5
		LDA	#$180
		STA	z:$20,X
		LDY	#4
		REP	#$20
		LDA	#.LOWORD(byte_C77710)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_C77710)
		STA	z:$52
		JSL	f:sub_C77822
		REP	#$20
.A16
		INC	z:$22,X
		LDA	z:$22,X
		CMP	#4
		BNE	loc_C777D8
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C777D8:
		REP	#$20
		LDA	#.LOWORD(loc_C77779)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C77779)
		STA	z:2,X
.A16

locret_C777E5:
		RTL
; End of function sub_C7774F

.A8
.I16

sub_C777E6:
		SEP	#$20
		LDA	#.LOBYTE(sub_C777FD)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C777FD)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C777FD)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		RTL
; End of function sub_C777E6

.A8
.I16

sub_C777FD:
		REP	#$20
.A16
		LDA	#$FFF
		STA	z:$40
		LDA	a:.LOWORD(screen_flags) ; orig=0x0312
		BIT	#1
		BNE	loc_C7781D
		SEP	#$20
.A8
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C77811:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C77811
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16

loc_C7781D:
		DEC	z:$40
		BNE	loc_C7781D
		RTL
; End of function sub_C777FD

.A8
.I16

sub_C77822:
		REP	#$20
.A16
		LDA	z:$22,X
		ASL
		ASL
		ASL
		CLC
		ADC	z:$50
		STA	z:$50
		LDA	[$50]
		STA	a:.LOWORD($C9D),Y
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		SEC
		SBC	#$50
		AND	#$3FF
		STA	a:.LOWORD($C9F),Y
		INC	z:$50
		INC	z:$50
		SEP	#$20
.A8
		LDA	[$50]
		STA	z:$40
		LDY	#2
		LDA	[$50],Y
		STA	z:$D3
		LDY	#7
		JSL	f:palette_related
		LDA	#$F
		STA	z:$40
		LDA	z:$30,X
		JSL	f:palette_related
		LDA	z:$D3
		STA	z:$30,X
		RTL
; End of function sub_C77822

.A8
.I16

sub_C7786A:
		SEP	#$20
		LDA	#1
		JSL	f:palette_related
		LDA	#2
		JSL	f:palette_related
		LDA	#3
		JSL	f:palette_related
		LDA	#4
		JSL	f:palette_related
		LDA	#5
		JSL	f:palette_related
		LDA	#6
		JSL	f:palette_related
		LDA	#7
		JSL	f:palette_related
		RTL
; End of function sub_C7786A

.A8
.I16

sub_C77897:
		SEP	#$20
		LDY	#7
		LDA	#$7D
		STA	z:$40
		LDA	#1
		JSL	f:palette_related
		LDA	#$7E
		STA	z:$40
		LDA	#2
		JSL	f:palette_related
		LDA	#$7F
		STA	z:$40
		LDA	#3
		JSL	f:palette_related
		LDA	#$80
		STA	z:$40
		LDA	#4
		JSL	f:palette_related
		LDA	#$81
		STA	z:$40
		LDA	#5
		JSL	f:palette_related
		LDA	#$82
		STA	z:$40
		LDA	#6
		JSL	f:palette_related
		LDA	#$83
		STA	z:$40
		LDA	#7
		JSL	f:palette_related
		RTL
; End of function sub_C77897

; ---------------------------------------------------------------------------
off_C778E3:	.ADDR byte_C7695E, byte_C76963,	byte_C76968, byte_C7696D, byte_C76972, byte_C76977, byte_C7697C, byte_C76981
		.ADDR byte_C76986, byte_C7698B,	byte_C76990, byte_C76995, byte_C7699A, byte_C7699F, byte_C769A4
		
ASSET2 graphics, backgrounds, spotlights_graphic
ASSET tilemaps, compressed_clown_spotlight_tilemap
ASSET tilemaps, compressed_story_spotlight_tilemap
DATA_END