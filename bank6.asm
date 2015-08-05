.SEGMENT "BANK6"
.ORG $C60000

.A8
.I16

handle_pause:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$98
		BNE	locret_C60043

loc_C60009:
		LDA	z:$20,X
		BEQ	loc_C60011

loc_C6000D:
		JML	f:loc_C60045
; ---------------------------------------------------------------------------

loc_C60011:
		JSL	f:should_toggle_pause
		BCS	loc_C6001B
.IFNDEF DEBUG
		JML	f:locret_C60044
.ELSE
        LDA	a:.LOWORD(game_flags) ; orig=0x0314 ; Deleted debug menu activation
        BIT	#1
        BEQ locret_C60044
        JSL f:handle_debug_menu_input
        RTL
.ENDIF
; ---------------------------------------------------------------------------

loc_C6001B:
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		EOR	#$40

loc_C60020:
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$40
		BEQ	loc_C6003F
		LDY	#$E
		JSL	f:play_sound
		SEP	#$20
		LDA	#1

loc_C60032:
		STA	z:$20,X

loc_C60034:
		STZ	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#3
		STA	z:$23,X

locret_C6003E:
		RTL
; ---------------------------------------------------------------------------

loc_C6003F:
		LDA	#2
		STA	z:$20,X

locret_C60043:
		RTL
; ---------------------------------------------------------------------------

locret_C60044:
		RTL
; ---------------------------------------------------------------------------

loc_C60045:
		REP	#$20
.A16
		LDA	z:$20,X
		BIT	#1
		BNE	loc_C60065
		LDA	z:$22,X
		SEC

loc_C60051:
		SBC	#5
		CMP	#$3FF
		STA	z:$22,X
		BCS	loc_C60079
		LDA	#$3FF
		STA	z:$22,X
		STZ	z:$20,X
		BRA	loc_C60079
; ---------------------------------------------------------------------------
		RTL
; ---------------------------------------------------------------------------

loc_C60065:
		LDA	z:$22,X
		CLC
		ADC	#5
		CMP	#$428
		STA	z:$22,X
		BCC	loc_C60079
		LDA	#$428
		STA	z:$22,X

loc_C60077:
		STZ	z:$20,X

loc_C60079:
		REP	#$20
		LDA	z:$22,X
		STA	a:.LOWORD(bg3_v_scroll_2) ; orig=0x0CA7
		RTL
; End of function handle_pause

.A8
.I16

should_toggle_pause:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#4
		BNE	loc_C600CE
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#3
		BEQ	loc_C60095
		CMP	#2
		BNE	loc_C600CE

loc_C60095:
		LDA	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		CMP	#$34
		BEQ	loc_C600CE
		CMP	#$35
		BEQ	loc_C600CE
		CMP	#$36
		BEQ	loc_C600CE
		LDA	#0
		XBA
		LDA	#0
		STA	z:$40

loc_C600AB:
		TAY
		LDA	a:.LOWORD(player1_object+player::is_ai),Y
		BNE	loc_C600B6
		LDA	a:.LOWORD(player1_object+player::gameover_related),Y
		BEQ	loc_C600C6

loc_C600B6:
		TYA
		LSR
		LSR
		LSR
		LSR
		LSR
		PHY
		TAY
		LDA	a:.LOWORD(joypad_1_pressed+1),Y
		PLY
		BIT	#$30

loc_C600C4:
		BNE	loc_C600D0

loc_C600C6:
		INC	z:$40
		TYA
		CLC
		ADC	#$40
		BNE	loc_C600AB

loc_C600CE:
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C600D0:
.IFDEF DEBUG
        BIT #$20
        BNE activate_debug
.ENDIF
		SEC
		RTL
activate_debug:
; ---------------------------------------------------------------------------
		LDA	a:.LOWORD(game_flags) ; orig=0x0314 ; Deleted debug menu activation
		EOR	#1
		BIT	#1
		BNE	open_debug_menu
		JML	f:close_debug_menu
; End of function should_toggle_pause

.A8
.I16

open_debug_menu:
		REP	#$20
.A16
		TYA
		CLC
		ADC	#$D40
		STA	z:$10,X
		LDA	z:$40
		PHA
		PHX

loc_C600EC:
		JSL	f:sub_C609F5
		PLX
		JSL	f:sub_C6033D
		REP	#$20
		PLA
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(unk_7E21E6)

loc_C600FF:
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7E21E6)
		STA	z:$55
		LDA	z:$40
		ORA	#$20
		STA	[$53]
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C6011B)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C6011B)
		STA	z:2,X
		RTL
; End of function open_debug_menu

.A8
.I16

sub_C6011B:
		REP	#$20
.A16
		LDA	#.LOWORD(handle_pause)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(handle_pause)
		STA	z:2,X
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#1
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		JSL	f:sub_C605EE
		SEP	#$20
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		PHA
		LDA	#0
		STA	a:.LOWORD(word_7E0316) ; orig=0x0316

loc_C60141:
		REP	#$20
.A16
		PHX
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		AND	#$FF
		TAX
		SEP	#$20
.A8
		LDA	f:debug_menu_value_types,X
		STA	z:$40
		REP	#$20
.A16
		PLX
		SEP	#$20
.A8
		LDA	z:$40
		BEQ	loc_C60177
		BIT	#$80
		BEQ	loc_C60164
		JML	f:loc_C60186
; ---------------------------------------------------------------------------

loc_C60164:
		BRA	loc_C60195
; ---------------------------------------------------------------------------

loc_C60166:
		SEP	#$20
		INC	a:.LOWORD(word_7E0316) ; orig=0x0316
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		CMP	#$13
		BNE	loc_C60141
		PLA
		STA	a:.LOWORD(word_7E0316) ; orig=0x0316
		RTL
; ---------------------------------------------------------------------------

loc_C60177:
		SEP	#$20
		JSL	f:sub_C601A4
		LDA	[$50]
		JSL	f:sub_C6036B
		JMP	a:.LOWORD(loc_C60166)
; ---------------------------------------------------------------------------

loc_C60186:
		SEP	#$20
		JSL	f:sub_C601A4
		LDA	[$50]
		JSL	f:sub_C60475
		JMP	a:.LOWORD(loc_C60166)
; ---------------------------------------------------------------------------

loc_C60195:
		SEP	#$20
		JSL	f:sub_C601A4
		LDA	[$50]
		JSL	f:sub_C603D9
		JMP	a:.LOWORD(loc_C60166)
; End of function sub_C6011B

.A8
.I16

sub_C601A4:
		SEP	#$20
		STZ	z:$52
		REP	#$20
.A16
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		AND	#$FF
		CLC
		ADC	#$A4
		STA	z:$50
		SEP	#$20
.A8
		RTL
; End of function sub_C601A4

.A8
.I16

handle_debug_menu_input:
		SEP	#$20
		LDY	z:$10,X
		LDA	a:.LOWORD($22),Y
		BIT	#$30
		BNE	loc_C601C8
		INY
		INY
		INY
		INY

loc_C601C8:
		PHY
		LDA	a:.LOWORD($22),Y
		BIT	#$80
		BEQ	loc_C6020E
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		CMP	#$11
		BNE	loc_C601EE
		REP	#$20
.A16
		PHX
		LDA	a:.LOWORD(debug_bgm) ; orig=0x00B5
		AND	#$FF
		TAX
		LDA	f:sounds_list,X
		PLX
		AND	#$FF
		TAY
		JSL	f:play_music

loc_C601EE:
		SEP	#$20
.A8
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		CMP	#$12
		BNE	loc_C6020E

loc_C601F7:
		REP	#$20
.A16
		PHX
		LDA	a:.LOWORD(debug_se) ; orig=0x00B6
		AND	#$FF
		TAX
		LDA	f:musics_lists,X
		PLX
		AND	#$FF
		TAY
		JSL	f:play_sound

loc_C6020E:
		SEP	#$20
.A8
		PLY
		LDA	a:.LOWORD($23),Y
		STA	z:$4E
		AND	#$C
		BEQ	loc_C60247
		JSL	f:sub_C6030F
		SEP	#$20
		LDA	z:$4E
		BIT	#8
		BEQ	loc_C60235
		DEC	a:.LOWORD(word_7E0316) ; orig=0x0316
		BPL	loc_C60230
		LDA	#$12
		STA	a:.LOWORD(word_7E0316) ; orig=0x0316

loc_C60230:
		JSL	f:sub_C6033D
		RTL
; ---------------------------------------------------------------------------

loc_C60235:
		INC	a:.LOWORD(word_7E0316) ; orig=0x0316
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		CMP	#$13
		BNE	loc_C60242
		STZ	a:.LOWORD(word_7E0316) ; orig=0x0316

loc_C60242:
		JSL	f:sub_C6033D

locret_C60246:
		RTL
; ---------------------------------------------------------------------------

loc_C60247:
		SEP	#$20
		LDA	z:$4E
		AND	#3
		BEQ	locret_C60246
		REP	#$20
.A16
		PHX
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		AND	#$FF
		TAX
		SEP	#$20
.A8
		LDA	f:debug_menu_value_types,X

loc_C6025F:
		STA	z:$40
		REP	#$20
.A16
		PLX
		SEP	#$20
.A8
		LDA	z:$40
		BEQ	loc_C60274
		BIT	#$80
		BEQ	loc_C60272
		JML	f:loc_C602D3
; ---------------------------------------------------------------------------

loc_C60272:
		BRA	loc_C60293
; ---------------------------------------------------------------------------

loc_C60274:
		SEP	#$20
		STZ	z:$52
		REP	#$20
.A16
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		AND	#$FF
		CLC
		ADC	#$A4
		STA	z:$50
		SEP	#$20
.A8
		LDA	[$50]
		EOR	#1
		STA	[$50]
		JSL	f:sub_C6036B
		RTL
; ---------------------------------------------------------------------------

loc_C60293:
		SEP	#$20
		STA	z:$40
		STZ	z:$52
		REP	#$20
.A16
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		AND	#$FF
		CLC
		ADC	#$A4
		STA	z:$50
		SEP	#$20
.A8
		LDA	z:$4E
		BIT	#1
		BNE	loc_C602C1
		LDA	[$50]
		DEC
		BPL	loc_C602CA
		DEC	z:$40
		LDA	z:$40
		STA	[$50]
		STA	z:$40
		JSL	f:sub_C603D9
		RTL
; ---------------------------------------------------------------------------

loc_C602C1:
		LDA	[$50]
		INC
		CMP	z:$40
		BNE	loc_C602CA
		LDA	z:0

loc_C602CA:
		STA	[$50]
		STA	z:$40
		JSL	f:sub_C603D9
		RTL
; ---------------------------------------------------------------------------

loc_C602D3:
		SEP	#$20
		EOR	#$FF
		INC
		STA	z:$40
		STZ	z:$52
		REP	#$20
.A16
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		AND	#$FF
		CLC
		ADC	#$A4
		STA	z:$50
		SEP	#$20
.A8
		LDA	z:$4E

loc_C602EE:
		BIT	#1
		BNE	loc_C602FF
		LDA	[$50]
		DEC
		BPL	loc_C602FB

loc_C602F7:
		DEC	z:$40
		LDA	z:$40

loc_C602FB:
		STA	[$50]
		BRA	loc_C6030A
; ---------------------------------------------------------------------------

loc_C602FF:
		LDA	[$50]
		INC
		CMP	z:$40
		BNE	loc_C60308
.A8
		LDA	#0

loc_C60308:
		STA	[$50]

loc_C6030A:
		JSL	f:sub_C60475
		RTL
; End of function handle_debug_menu_input

.A8
.I16

sub_C6030F:
		REP	#$20
.A16
		LDA	#.LOWORD(unk_7E2020)
		STA	z:$53
		PHX
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7E2020)
		STA	z:$55
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		CLC
		ADC	#8
		REP	#$20
.A16
		AND	#$FF
		ASL
		TAX

loc_C6032A:
		LDA	f:offsets_to_debug_menu_map,X
		CLC
		ADC	z:$53
		STA	z:$53
		SEP	#$20
.A8
		LDA	#$36
		STA	[$53]
		REP	#$20
.A16
		PLX
		RTL
; End of function sub_C6030F

.A8
.I16

sub_C6033D:
		REP	#$20
.A16
		LDA	#.LOWORD(unk_7E2020)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7E2020)
		STA	z:$55
		PHX
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		CLC
		ADC	#8
		REP	#$20
.A16
		AND	#$FF
		ASL
		TAX
		LDA	f:offsets_to_debug_menu_map,X
		CLC
		ADC	z:$53
		STA	z:$53
		SEP	#$20
.A8
		LDA	#$1F
		STA	[$53]
		REP	#$20
.A16
		PLX
		RTL
; End of function sub_C6033D

.A8
.I16

sub_C6036B:
		SEP	#$20
		STA	z:$40
		REP	#$20
.A16
		LDA	#.LOWORD(unk_7E2038)
		STA	z:$53
		PHX
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7E2038)
		STA	z:$55
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		CLC
		ADC	#8
		REP	#$20
.A16
		AND	#$FF
		ASL
		TAX
		LDA	f:offsets_to_debug_menu_map,X
		CLC
		ADC	z:$53
		STA	z:$53
		SEP	#$20
.A8
		LDA	z:$40
		BNE	loc_C603B7
		LDA	#$F
		STA	[$53]
		REP	#$20
.A16
		INC	z:$53
		INC	z:$53
		SEP	#$20
.A8
		LDA	#6
		STA	[$53]
		REP	#$20
.A16
		INC	z:$53
		INC	z:$53
		SEP	#$20
.A8
		LDA	#6
		STA	[$53]
		BRA	loc_C603D5
; ---------------------------------------------------------------------------

loc_C603B7:
		SEP	#$20
		LDA	#$36
		STA	[$53]
		REP	#$20
.A16
		INC	z:$53
		INC	z:$53
		SEP	#$20
.A8
		LDA	#$F
		STA	[$53]
		REP	#$20
.A16
		INC	z:$53
		INC	z:$53
		SEP	#$20
.A8
		LDA	#$E
		STA	[$53]

loc_C603D5:
		REP	#$20
.A16
		PLX
		RTL
; End of function sub_C6036B

.A8
.I16

sub_C603D9:
		REP	#$20
.A16
		AND	#$FF
		STA	z:$40
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7E203A)
		STA	z:$55
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		CLC
		ADC	#8
		REP	#$20
.A16
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:offsets_to_debug_menu_map,X
		CLC
		ADC	#.LOWORD(unk_7E203A)
		STA	z:$53
		SEP	#$20
.A8
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		CMP	#$11
		BEQ	loc_C6040B
		CMP	#$12
		BNE	loc_C6041B

loc_C6040B:
		REP	#$20
.A16
		LDA	z:$40
		AND	#$FF
		TAX
		SEP	#$20
.A8
		LDA	f:byte_C60447,X
		STA	z:$40

loc_C6041B:
		REP	#$20
.A16
		LDA	z:$40
		AND	#$F0
		LSR
		LSR
		LSR
		LSR
		TAX
		SEP	#$20
.A8
		LDA	f:hex_digits,X
		STA	[$53]
		REP	#$20
.A16
		LDA	z:$40
		AND	#$F
		TAX
		INC	z:$53
		INC	z:$53
		SEP	#$20
.A8
		LDA	f:hex_digits,X
		STA	[$53]
		REP	#$20
.A16
		PLX
		RTL
; End of function sub_C603D9

; ---------------------------------------------------------------------------
byte_C60447:	.BYTE 0, 1, 2, 3, 4, 5,	6, 7
		.BYTE 8, 9, $10, $11, $12, $13,	$14, $15
		.BYTE $16, $17,	$18, $19, $20, $21, $22, $23
		.BYTE $24, $25,	$26, $27, $28, $29, $30, $31
		.BYTE $32, $33,	$34, $35, $36, $37, $38, $39
		.BYTE $40, $41,	$42, $43, $44, $45
.A8
.I16

sub_C60475:
		SEP	#$20
		STA	z:$40
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		BEQ	loc_C604D4
		REP	#$20
.A16
		LDA	#.LOWORD(unk_7E2038)
		STA	z:$53
		PHX
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7E2038)
		STA	z:$55
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		CLC
		ADC	#8
		REP	#$20
.A16
		AND	#$FF
		ASL
		TAX
		LDA	f:offsets_to_debug_menu_map,X
		CLC
		ADC	z:$53
		STA	z:$53
		LDA	z:$40
		AND	#$FF
		ASL
		ASL
		TAX
		SEP	#$20
.A8
		LDA	f:speed_names,X
		STA	[$53]
		REP	#$20
.A16
		INC	z:$53
		INC	z:$53
		INX
		SEP	#$20
.A8
		LDA	f:speed_names,X
		STA	[$53]
		REP	#$20
.A16
		INC	z:$53

loc_C604C5:
		INC	z:$53
		INX
		SEP	#$20
.A8
		LDA	f:speed_names,X
		STA	[$53]
		REP	#$20
.A16
		PLX
		RTL
; ---------------------------------------------------------------------------

loc_C604D4:
		REP	#$20
		LDA	#.LOWORD(unk_7E2038)
		STA	z:$53
		PHX
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7E2038)
		STA	z:$55
		LDA	a:.LOWORD(word_7E0316) ; orig=0x0316
		CLC
		ADC	#8
		REP	#$20
.A16
		AND	#$FF
		ASL
		TAX
		LDA	f:offsets_to_debug_menu_map,X
		CLC
		ADC	z:$53
		STA	z:$53
		LDA	z:$40
		AND	#$FF
		ASL
		ASL
		TAX
		SEP	#$20
.A8
		LDA	f:screen_names,X
		STA	[$53]
		REP	#$20
.A16
		INC	z:$53
		INC	z:$53
		INX
		SEP	#$20
.A8
		LDA	f:screen_names,X
		STA	[$53]
		REP	#$20
.A16
		INC	z:$53
		INC	z:$53
		INX
		SEP	#$20
.A8
		LDA	f:screen_names,X
		STA	[$53]
		REP	#$20
.A16
		PLX
		RTL
; End of function sub_C60475

.A8
.I16

close_debug_menu:
		JSL	f:remove_debug_menu_from_tilemap
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C6053C)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C6053C)
		STA	z:2,X
		RTL
; End of function close_debug_menu

.A8
.I16

sub_C6053C:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		AND	#$FE
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		REP	#$20
.A16
		PHX
		LDA	z:$10,X
		TAX
		SEP	#$20
.A8
		LDA	a:.LOWORD(debug_no_death) ; orig=0x00A5
		STA	z:$2E,X
		LDA	a:.LOWORD(debug_bomb_up) ;	orig=0x00A7
		STA	z:$30,X
		LDA	z:$31,X
		AND	#$80
		ORA	a:.LOWORD(debug_fire_up) ;	orig=0x00A8
		STA	z:$31,X
		LDA	a:.LOWORD(debug_speed_up) ; orig=0x00A9
		STA	z:$32,X
		LDA	a:.LOWORD(debug_remocon) ;	orig=0x00AA
		STA	z:$33,X
		STZ	z:$39,X
		LDA	a:.LOWORD(debug_wall_pass)	; orig=0x00AB
		ASL
		ASL
		ASL
		ASL
		ASL
		ASL
		AND	#$40
		ORA	z:$39,X
		STA	z:$39,X
		LDA	a:.LOWORD(debug_bomb_pass)	; orig=0x00AC
		ASL
		ASL
		ASL
		ASL
		ASL
		AND	#$20
		ORA	z:$39,X
		STA	z:$39,X
		LDA	a:.LOWORD(debug_fire_pass)	; orig=0x00AD
		STA	z:$36,X
		BEQ	loc_C6059A
		REP	#$20
.A16
		LDA	#$160
		STA	z:$36,X
		SEP	#$20
.A8

loc_C6059A:
		LDA	a:.LOWORD(debug_full_fire)	; orig=0x00AE
		BEQ	loc_C605A5
		LDA	z:$31,X
		ORA	#$80
		BRA	loc_C605A9
; ---------------------------------------------------------------------------

loc_C605A5:
		LDA	z:$31,X
		AND	#$7F

loc_C605A9:
		STA	z:$31,X
		LDA	a:.LOWORD(debug_break_thr)	; orig=0x00AF
		STA	z:$38,X
		LDA	a:.LOWORD(debug_power) ; orig=0x00B0
		AND	#1
		ORA	z:$39,X
		STA	z:$39,X
		LDA	a:.LOWORD(debug_kick) ; orig=0x00B1
		ASL
		AND	#2
		ORA	z:$39,X
		STA	z:$39,X
		LDA	a:.LOWORD(debug_skull) ; orig=0x00B2
		BEQ	loc_C605DD
		JSL	f:sub_C6113D
		SEP	#$20
		PLX
		REP	#$20
.A16
		LDA	#.LOWORD(handle_pause)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(handle_pause)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C605DD:
		STA	z:$3C,X
		PLX
		REP	#$20
.A16
		LDA	#.LOWORD(handle_pause)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(handle_pause)
		STA	z:2,X
		RTL
; End of function sub_C6053C

.A8
.I16

sub_C605EE:
		REP	#$20
.A16
		PHX
		LDA	z:$10,X
		TAX
		SEP	#$20
.A8
		LDA	z:$2E,X
		STA	a:.LOWORD(debug_no_death) ; orig=0x00A5
		LDA	z:$30,X
		STA	a:.LOWORD(debug_bomb_up) ;	orig=0x00A7
		LDA	z:$31,X
		AND	#$7F
		STA	a:.LOWORD(debug_fire_up) ;	orig=0x00A8
		LDA	z:$32,X
		STA	a:.LOWORD(debug_speed_up) ; orig=0x00A9
		LDA	z:$33,X
		STA	a:.LOWORD(debug_remocon) ;	orig=0x00AA
		LDA	z:$39,X
		LSR
		LSR
		LSR
		LSR
		LSR
		LSR
		AND	#1
		STA	a:.LOWORD(debug_wall_pass)	; orig=0x00AB
		LDA	z:$39,X
		LSR
		LSR
		LSR
		LSR
		LSR
		AND	#1
		STA	a:.LOWORD(debug_bomb_pass)	; orig=0x00AC
		LDA	z:$36,X
		BEQ	loc_C60630
		LDA	#1

loc_C60630:
		STA	a:.LOWORD(debug_fire_pass)	; orig=0x00AD
		LDA	z:$31,X
		AND	#$80
		BEQ	loc_C6063B
		LDA	#1

loc_C6063B:
		STA	a:.LOWORD(debug_full_fire)	; orig=0x00AE
		LDA	z:$38,X
		STA	a:.LOWORD(debug_break_thr)	; orig=0x00AF
		LDA	z:$39,X
		AND	#1
		STA	a:.LOWORD(debug_power) ; orig=0x00B0
		LDA	z:$39,X
		LSR
		AND	#1
		STA	a:.LOWORD(debug_kick) ; orig=0x00B1
		LDA	z:$3C,X
		STA	a:.LOWORD(debug_skull) ; orig=0x00B2
		PLX
		RTL
; End of function sub_C605EE

; ---------------------------------------------------------------------------
screen_names:	.BYTE $21, $34,	$21, $36
		.BYTE $21, $34,	$22, $36
		.BYTE $21, $34,	$23, $36
		.BYTE $21, $34,	$24, $36
		.BYTE $21, $34,	$25, $36
		.BYTE $21, $34,	$26, $36
		.BYTE $21, $34,	$27, $36
		.BYTE $21, $34,	$28, $36
		.BYTE $22, $34,	$21, $36
		.BYTE $22, $34,	$22, $36
		.BYTE $22, $34,	$23, $36
		.BYTE $22, $34,	$24, $36
		.BYTE $22, $34,	$25, $36
		.BYTE $22, $34,	$26, $36
		.BYTE $22, $34,	$27, $36
		.BYTE $22, $34,	$28, $36
		.BYTE $23, $34,	$21, $36
		.BYTE $23, $34,	$22, $36
		.BYTE $23, $34,	$23, $36
		.BYTE $23, $34,	$24, $36
		.BYTE $23, $34,	$25, $36
		.BYTE $23, $34,	$26, $36
		.BYTE $23, $34,	$27, $36
		.BYTE $23, $34,	$28, $36
		.BYTE $24, $34,	$21, $36
		.BYTE $24, $34,	$22, $36
		.BYTE $24, $34,	$23, $36
		.BYTE $24, $34,	$24, $36
		.BYTE $24, $34,	$25, $36
		.BYTE $24, $34,	$26, $36
		.BYTE $24, $34,	$27, $36
		.BYTE $24, $34,	$28, $36
		.BYTE $25, $34,	$21, $36
		.BYTE $25, $34,	$22, $36
		.BYTE $25, $34,	$23, $36
		.BYTE $25, $34,	$24, $36
		.BYTE $25, $34,	$25, $36
		.BYTE $25, $34,	$26, $36
		.BYTE $25, $34,	$27, $36
		.BYTE $25, $34,	$28, $36
		.BYTE $26, $34,	$21, $36
		.BYTE $26, $34,	$22, $36
		.BYTE $26, $34,	$23, $36
		.BYTE $26, $34,	$24, $36
		.BYTE $26, $34,	$25, $36
		.BYTE $26, $34,	$26, $36
		.BYTE $26, $34,	$27, $36
		.BYTE $26, $34,	$28, $36
		.BYTE 5, $E, 4,	$36
		.BYTE $14, 9, $14, $36
		.BYTE $13, 5, $C, $36
		.BYTE 4, $D, $21, $36
		.BYTE 4, $D, $22, $36
		.BYTE 4, $D, $23, $36
		.BYTE 4, $D, $24, $36
		.BYTE 3, $F, $E, $36
		.BYTE $10, 1, $13, $36
		.BYTE $10, $12,	$D, $36
		.BYTE 4, $12, $17, $36
		.BYTE $17, 9, $E, $36
		.BYTE 2, $34, $21, $36
		.BYTE 2, $34, $22, $36
		.BYTE 2, $34, $23, $36
		.BYTE 2, $34, $24, $36
		.BYTE 2, $34, $25, $36
		.BYTE 2, $34, $26, $36
		.BYTE 2, $34, $27, $36
		.BYTE 2, $34, $28, $36
		.BYTE 2, $34, $29, $36
		.BYTE 2, $34, 1, $36
		.BYTE 2, $34, 2, $36
		.BYTE 2, $34, 3, $36
		.BYTE 4, $12, $36, $36
		.BYTE $17, 9, $E, $36
		.BYTE $22, $34,	$21, $36
		.BYTE $22, $34,	$22, $36
		.BYTE $22, $34,	$23, $36
		.BYTE $22, $34,	$24, $36
		.BYTE $22, $34,	$25, $36
		.BYTE $22, $34,	$26, $36
		.BYTE $22, $34,	$27, $36
		.BYTE $22, $34,	$28, $36
speed_names:	.BYTE $36, $18,	$21, $36
		.BYTE $36, $18,	$22, $36
		.BYTE $36, $18,	$23, $36
		.BYTE $36, $18,	$24, $36
hex_digits:	.BYTE $20, $21,	$22, $23
		.BYTE $24, $25,	$26, $27
		.BYTE $28, $29,	1, 2
		.BYTE 3, 4, 5, 6
debug_menu_value_types:.BYTE $B2, 0, $FC, $A
		.BYTE $A, 8, 0,	0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, $2A, $28, 2
debug_menu_map:	.BYTE $10, $07,	$36, $10, $1E, $36, $36, $36, $36, $36,	$36, $36, $36, $36, $36, $36, $36
		.BYTE $10, $08,	$36, $13, $14, $01, $07, $05, $36, $0E,	$0F, $1C, $36, $36, $21, $34, $21
		.BYTE $10, $09,	$36, $0E, $0F, $36, $04, $05, $01, $14,	$08, $36, $36, $36, $0F, $06, $06
		.BYTE $10, $0A,	$36, $07, $01, $0D, $05, $36, $13, $10,	$05, $05, $04, $36, $36, $18, $21
		.BYTE $10, $0B,	$36, $02, $0F, $0D, $02, $36, $15, $10,	$36, $36, $36, $36, $36, $20, $20
		.BYTE $10, $0C,	$36, $06, $09, $12, $05, $36, $15, $10,	$36, $36, $36, $36, $36, $20, $20
		.BYTE $10, $0D,	$36, $13, $10, $05, $05, $04, $36, $15,	$10, $36, $36, $36, $36, $20, $20
		.BYTE $10, $0E,	$36, $12, $05, $0D, $0F, $03, $0F, $0E,	$36, $36, $36, $36, $0F, $06, $06
		.BYTE $10, $0F,	$36, $17, $01, $0C, $0C, $36, $10, $01,	$13, $13, $36, $36, $0F, $06, $06
		.BYTE $10, $10,	$36, $02, $0F, $0D, $02, $36, $10, $01,	$13, $13, $36, $36, $0F, $06, $06
		.BYTE $10, $11,	$36, $06, $09, $12, $05, $36, $10, $01,	$13, $13, $36, $36, $0F, $06, $06
		.BYTE $10, $12,	$36, $06, $09, $12, $05, $36, $06, $15,	$0C, $0C, $36, $36, $0F, $06, $06
		.BYTE $10, $13,	$36, $02, $12, $05, $01, $0B, $36, $14,	$08, $12, $1C, $36, $0F, $06, $06
		.BYTE $10, $14,	$36, $10, $0F, $17, $05, $12, $36, $36,	$36, $36, $36, $36, $0F, $06, $06
		.BYTE $10, $15,	$36, $0B, $09, $03, $0B, $36, $36, $36,	$36, $36, $36, $36, $0F, $06, $06
		.BYTE $10, $16,	$36, $13, $0B, $15, $0C, $0C, $36, $36,	$36, $36, $36, $36, $0F, $06, $06
		.BYTE $10, $17,	$36, $14, $09, $0D, $05, $36, $03, $08,	$05, $03, $0B, $36, $0F, $06, $06
		.BYTE $10, $18,	$36, $16, $13, $36, $03, $08, $05, $03,	$0B, $36, $36, $36, $0F, $06, $06
		.BYTE $10, $19,	$36, $02, $07, $0D, $36, $0E, $0F, $1C,	$36, $36, $36, $36, $36, $20, $20
		.BYTE $10, $1A,	$36, $13, $05, $36, $0E, $0F, $1C, $36,	$36, $36, $36, $36, $36, $20, $20
		.BYTE $FF
offsets_to_debug_menu_map:.WORD 0, $40, $80, $C0, $100, $140, $180, $1C0, $200, $240, $280, $2C0, $300, $340, $380, $3C0, $400
		.WORD $440, $480, $4C0,	$500, $540, $580, $5C0,	$600, $640, $680, $6C0,	$700, $740, $780, $7C0
musics_lists:	.BYTE 0, 1, 2, 3, 4, 5,	6, 7, 8, 9, $A,	$B, $C,	$D, $E,	$F, $10
		.BYTE $11, $12,	$13, $14, $15, $16, $17, $18, $19, $1A,	$1B, $1C, $1D, $1E, $1F, $20, $21
		.BYTE $22, $23,	$24, $25, $26, $27, $28, $28, $28, $28
sounds_list:	.BYTE 0, 1, 2, 3, 4, 5,	6, 7, 8, 9, $A,	$B, $C,	$D, $E,	$F, $10
		.BYTE $11, $12,	$13, $14, $15, $16, $17, $18, $19, $1A,	$1B, $1C, $1D, $1E, $1F, $20, $21
		.BYTE $22, $23,	$24, $25, $26, $27, $28, $29
unknown_debug_related:.BYTE 0, 1, 3, 4,	5, $1B,	7, $1C,	$A, $D,	2, $E, $F, $10,	$11, $12, $19
		.BYTE $14, $15,	$16, $17, $18, $1A, $1D, $1E
.A8
.I16

remove_debug_menu_from_tilemap:
		REP	#$20
.A16
		LDA	#.LOWORD(bg3_ram_map)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(bg3_ram_map)
		STA	z:$52
		REP	#$20
.A16
		LDY	#$680
		LDA	#0

loc_C609EE:
		STA	[$50],Y
		DEY
		DEY
		BNE	loc_C609EE
		RTL
; End of function remove_debug_menu_from_tilemap

.A16
.I16

sub_C609F5:
		REP	#$20
		LDA	#.LOWORD(debug_menu_map)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(debug_menu_map)
		STA	z:$52

loc_C60A02:
		REP	#$20
.A16
		LDA	#.LOWORD(unk_7E2000)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7E2000)
		STA	z:$55
		LDA	[$50]
		CMP	#$FF
		BNE	loc_C60A16
		RTL
; ---------------------------------------------------------------------------

loc_C60A16:
		REP	#$20
.A16
		AND	#$FF
		ASL
		CLC
		ADC	z:$53
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		AND	#$FF
		ASL
		TAX
		LDA	f:offsets_to_debug_menu_map,X
		CLC

loc_C60A2F:
		ADC	z:$53
		STA	z:$53
		INC	z:$50
		SEP	#$20
.A8
		LDA	#$F
		STA	z:$40

loc_C60A3B:
		LDA	[$50]
		STA	[$53]
		REP	#$20
.A16
		INC	z:$53
		SEP	#$20
.A8
		LDA	#$20
		STA	[$53]
		REP	#$20
.A16
		INC	z:$53
		INC	z:$50
		SEP	#$20
.A8
		DEC	z:$40
		BNE	loc_C60A3B
		BRA	loc_C60A02
; End of function sub_C609F5

.A8
.I16

create_object:
		SEP	#$20
		PHX
		LDA	z:$D3
		CMP	#$FF
		REP	#$20
.A16
		BNE	loc_C60A66
		JML	f:loc_C60ABA
; ---------------------------------------------------------------------------

loc_C60A66:
		LDX	a:.LOWORD(free_offset_in_object_pointer_array) ; orig=0x00BA
		CPX	a:.LOWORD(max_object_pointer_object) ; orig=0x00BC
		BNE	loc_C60A72
		JML	f:loc_C60ABA
; ---------------------------------------------------------------------------

loc_C60A72:
		TXA
		INC
		INC
		CMP	#$68
		BNE	loc_C60A7D
		LDA	#0

loc_C60A7D:
		STA	a:.LOWORD(free_offset_in_object_pointer_array) ; orig=0x00BA
		LDY	a:.LOWORD(object_pointer_array),X
		LDA	z:.LOBYTE(unk_7E00DB)
		STA	a:.LOWORD(0),Y
		LDA	z:.LOBYTE(unk_7E00DC)
		STA	a:.LOWORD(1),Y
		LDX	#$F40

loc_C60A90:
		SEP	#$20
.A8
		LDA	z:3,X
		CMP	z:$D3
		REP	#$20
.A16
		BEQ	loc_C60AB0
		BCC	loc_C60AB0
		LDA	z:4,X
		STA	a:.LOWORD(4),Y
		PHA
		TYA
		STA	z:4,X
		TXA
		STA	a:.LOWORD(6),Y
		PLX
		TYA
		STA	z:6,X
		PLX
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C60AB0:
		LDA	z:6,X
		TAX
		CMP	#$FFFF
		BEQ	loc_C60ABA
		BRA	loc_C60A90
; ---------------------------------------------------------------------------

loc_C60ABA:
		LDY	#$1C40
		PLX
		SEC
		RTL
; End of function create_object

.A16
.I16

sub_C60AC0:
		REP	#$20
		PHX
		LDX	a:.LOWORD(word_7E0078) ; orig=0x0078
		CPX	a:.LOWORD(word_7E007A) ; orig=0x007A
		BNE	loc_C60ACF
		JML	f:loc_C60B08
; ---------------------------------------------------------------------------

loc_C60ACF:
		TXA
		INC
		INC
		CMP	#$30
		BNE	loc_C60ADA
		LDA	#0

loc_C60ADA:
		STA	a:.LOWORD(word_7E0078) ; orig=0x0078
		LDY	a:.LOWORD($4C4),X
		LDA	z:$40
		STA	a:.LOWORD(0),Y
		LDX	#$1C80

loc_C60AE8:
		LDA	z:0,X
		BNE	loc_C60B02
		LDA	z:4,X
		STA	a:.LOWORD(4),Y
		STA	z:$44
		TYA
		STA	z:4,X
		TXA
		STA	a:.LOWORD(6),Y
		LDX	z:$44
		TYA
		STA	z:6,X
		PLX
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C60B02:
		LDA	z:6,X
		TAX
		INC
		BNE	loc_C60AE8

loc_C60B08:
		PLX
		SEC
		RTL
; End of function sub_C60AC0

.A8
.I16

delete_object:
		REP	#$20
.A16
		LDA	a:.LOWORD(max_object_pointer_object) ; orig=0x00BC
		TAY
		INC
		INC
		CMP	#$68
		BNE	loc_C60B1B
		LDA	#0

loc_C60B1B:
		STA	a:.LOWORD(max_object_pointer_object) ; orig=0x00BC
		TXA
		STA	a:.LOWORD(object_pointer_array),Y
		LDY	z:player::gameover_related,X
		LDA	z:object::handler+6,X
		STA	a:.LOWORD(6),Y
		PHA
		PHY
		PLA
		PLY
		STA	a:.LOWORD(4),Y
		STZ	z:object::handler,X
		STZ	z:object::handler+2,X
		RTL
; End of function delete_object

.A8
.I16

sub_C60B35:
		REP	#$20
.A16
		LDA	a:.LOWORD(word_7E007A) ; orig=0x007A
		TAY
		INC
		INC
		CMP	#$30
		BNE	loc_C60B45
		LDA	#0

loc_C60B45:
		STA	a:.LOWORD(word_7E007A) ; orig=0x007A
		TXA
		STA	a:.LOWORD($4C4),Y
		LDY	z:4,X
		LDA	z:6,X
		STA	a:.LOWORD(6),Y
		PHA
		PHY
		PLA
		PLY
		STA	a:.LOWORD(4),Y
		STZ	z:0,X
		RTL
; End of function sub_C60B35

; ---------------------------------------------------------------------------
byte_C60B5D:	.BYTE 0, 0, 0, 0, 0, $FF, $FF, 0, 0, $FF, $FF, 0, 0, 0,	0, 0
.A16
.I16

sub_C60B6D:
		REP	#$20
		LDA	z:$39,X
		AND	#$60
		EOR	#$FF
		AND	#$E0
		STA	z:$42
		LDA	z:$11,X
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$40
		LDA	z:$14,X
		AND	#$F0
		ASL
		ASL
		ADC	z:$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		AND	z:$42
		BNE	loc_C60B99
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C60B99:
		SEC
		RTL
; End of function sub_C60B6D

.A16
.I16

get_collision_mask_for_position:
		REP	#$20
		LDA	z:$40
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$44
		LDA	z:$42
		AND	#$F0
		ASL
		ASL
		ADC	z:$44
		TAY
		LDA	a:.LOWORD(collision_map),Y
		RTL
; End of function get_collision_mask_for_position

.A16
.I16

get_object_square_index:
		REP	#$20
		LDA	z:player::x_position,X
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$40
		LDA	z:player::y_position,X
		AND	#$F0
		ASL
		ASL
		ADC	z:$40
		RTL
; End of function get_object_square_index

.A8
.I16

sub_C60BCB:
		SEP	#$20
		LDA	z:$11,X
		AND	#$F0
		ORA	#8
		STA	z:$11,X
		LDA	z:$14,X
		AND	#$F0
		ORA	#8
		STA	z:$14,X
		RTL
; End of function sub_C60BCB

.A8
.I16

should_kill_enemy:
		SEP	#$20
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	z:$1B,X
		BEQ	loc_C60BF4
		DEC	z:$1B,X
		BIT	#1
		BEQ	loc_C60C33
		LDA	#$E
		STA	z:$1E,X
		BRA	loc_C60C33
; ---------------------------------------------------------------------------

loc_C60BF4:
		REP	#$20
.A16
		LDA	z:$11,X
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$40
		LDA	z:$14,X
		AND	#$F0
		ASL
		ASL
		ADC	z:$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$100
		BNE	loc_C60C23
		AND	#$3F
		CMP	#$3F
		BNE	loc_C60C33
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$F03F
		STA	a:.LOWORD(collision_map),Y

loc_C60C23:
		SEP	#$20
.A8
		LDA	z:$1A,X
		BEQ	loc_C60C31
		DEC	z:$1A,X
		LDA	#$20
		STA	z:$1B,X
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C60C31:
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C60C33:
		CLC
		RTL
; End of function should_kill_enemy

.A8
.I16

sub_C60C35:
		REP	#$20
.A16
		LDA	z:$11,X
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$40
		LDA	z:$14,X
		AND	#$F0
		ASL
		ASL
		ADC	z:$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		AND	#$1FF
		BEQ	loc_C60C89
		BIT	#$20
		BEQ	loc_C60C5C
		JML	f:loc_C60D0D
; ---------------------------------------------------------------------------

loc_C60C5C:
		BIT	#$100
		BEQ	loc_C60C65
		JML	f:sub_C60FFF
; ---------------------------------------------------------------------------

loc_C60C65:
		BIT	#$E0
		BNE	loc_C60C80
		AND	#$1F
		PHX
		ASL
		TAX
		LDA	#.BANKBYTE(bomb_up_bonus)
		STA	z:$55
		LDA	f:bonus_handlers,X
		STA	z:$53
		PLX
		JSL	f:call_function_at_0053

loc_C60C80:
		SEP	#$20
.A8
		LDA	z:4,X
		ORA	#$80
		STA	z:4,X
		RTL
; ---------------------------------------------------------------------------

loc_C60C89:
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$20
		BNE	loc_C60CD2
		BIT	#$40
		BEQ	loc_C60C80
		LDA	a:.LOWORD(bg1_tilemap),Y
		CMP	#$A40
		BNE	loc_C60C80
		SEP	#$20
.A8
		LDA	z:4,X
		BIT	#$80
		BEQ	locret_C60D0A
		AND	#$7F
		STA	z:4,X
		JSL	f:sub_C61373
		SEP	#$20
		LDA	z:7,X
		BNE	loc_C60CC4
		REP	#$20
.A16
		LDA	#.LOWORD(do_trampoline)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(do_trampoline)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C60CC4:
		REP	#$20
.A16
		LDA	#.LOWORD(do_trampoline)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(do_trampoline)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C60CD2:
		REP	#$20
.A16
		LDA	a:.LOWORD(bg1_tilemap),Y
		CMP	#$826
		BNE	loc_C60C80
		LDA	z:4,X
		BIT	#$80
		BEQ	locret_C60D0A
		SEP	#$20
.A8
		LDA	z:4,X
		AND	#$7F
		STA	z:4,X
		LDA	z:7,X
		BNE	loc_C60CFD
		REP	#$20
.A16
		LDA	#.LOWORD(enter_warp)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(enter_warp)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C60CFD:
		REP	#$20
.A16
		LDA	#.LOWORD(wrap_related)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(wrap_related)
		STA	z:2,X

locret_C60D0A:
		RTL
; ---------------------------------------------------------------------------
		REP	#$20
.A16

loc_C60D0D:
		AND	#$3F
		CMP	#$3F
		BNE	locret_C60D25
		LDA	z:$2F,X
		ORA	#$80
		STA	z:$2F,X
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$F03F
		STA	a:.LOWORD(collision_map),Y

locret_C60D25:
		RTL
; End of function sub_C60C35

; ---------------------------------------------------------------------------
bonus_handlers:	.ADDR handle_pause, bomb_up_bonus, fire_up_bonus, sub_C60DC3, sub_C60DEA, sub_C60E13, sub_C60E34, sub_C60E5E
		.ADDR sub_C60E84, sub_C60EA8, sub_C60EFD, sub_C60F21, sub_C60F45, sub_C60F6E, sub_C60F95, sub_C60FB1
		.ADDR sub_C60FD1, sub_C61006, sub_C6102A, question_mark_bonus, sub_C61077, sub_C610AF, sub_C610CB, sub_C610F1
		.ADDR sub_C6110D, sub_C60FB1, sub_C60FB1, nullsub_12, nullsub_12, nullsub_12, nullsub_12, nullsub_12
		.ADDR sub_C60FFF, sub_C60FFF, sub_C60FFF, sub_C60FFF, sub_C60FFF
.A16
.I16

bomb_up_bonus:
		REP	#$20
		LDA	#$10
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed

loc_C60D80:
		JSL	f:sub_C61129
		SEP	#$20
.A8
		INC	a:.LOWORD($130),X
		LDA	z:$30,X
		CMP	#9
		BEQ	loc_C60D91
		INC	z:$30,X

loc_C60D91:
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function bomb_up_bonus

.A8
.I16
nullsub_12:
		RTL
.A8
.I16

fire_up_bonus:
		REP	#$20
.A16
		LDA	#$200

loc_C60D9F:
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		SEP	#$20
.A8
		INC	a:.LOWORD($131),X
		LDA	z:$31,X
		CMP	#9
		BEQ	loc_C60DBB
		INC	z:$31,X

loc_C60DBB:
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function fire_up_bonus

.A8
.I16

sub_C60DC3:
		REP	#$20
.A16
		LDA	#$300
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		SEP	#$20
.A8
		LDA	z:$33,X
		ORA	#1

loc_C60DDD:
		STA	z:$33,X
		INC	a:.LOWORD($133),X
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C60DC3

.A8
.I16

sub_C60DEA:
		REP	#$20
.A16
		LDA	#$400
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		SEP	#$20
.A8

loc_C60E00:
		INC	a:.LOWORD($132),X
		LDA	z:$32,X
		CMP	#3
		BCS	loc_C60E0B
		INC	z:$32,X

loc_C60E0B:
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C60DEA

.A8
.I16

sub_C60E13:
		REP	#$20
.A16
		LDA	#$2A0
		STA	z:$36,X
		LDA	#$500
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C60E13

.A16
.I16

sub_C60E34:
		REP	#$20
		LDA	#$600
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
; End of function sub_C60E34

.A16
.I16

add_extra_life:
		SEP	#$20
.A8
		LDA	z:$3D,X
		CMP	#9
		BEQ	loc_C60E52
		INC	z:$3D,X

loc_C60E52:
		JSL	f:write_number_of_lives
		LDY	#3
		JSL	f:play_sound
		RTL
; End of function add_extra_life

.A8
.I16

sub_C60E5E:
		REP	#$20
.A16
		LDA	#$700
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		SEP	#$20
.A8
		LDA	z:$39,X
		ORA	#$20
		AND	#$FE
		STA	z:$39,X
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C60E5E

.A8
.I16

sub_C60E84:
		REP	#$20
.A16
		LDA	#$800
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		SEP	#$20
.A8
		LDA	z:$39,X
		ORA	#$40
		STA	z:$39,X
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C60E84

.A8
.I16

sub_C60EA8:
		REP	#$20
.A16
		LDA	z:7,X
		AND	#$FF
		BNE	loc_C60EF1
		LDA	z:5,X
		AND	#$FF
		ASL
		TAY
		LDA	#0
		STA	a:.LOWORD($CAA),Y
		LDY	#$C2
		LDA	z:5,X
		AND	#$FF
		BEQ	loc_C60ECB
		LDY	#$E2

loc_C60ECB:
		LDA	#$E
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(storymode_hud_tilemap+$C2)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(storymode_hud_tilemap+$C2)
		STA	z:$52
		JSL	f:copy_to_bg3_tilemap
		REP	#$20
.A16
		LDA	#$900
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed

loc_C60EF1:
		JSL	f:sub_C61129
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C60EA8

.A16
.I16

sub_C60EFD:
		REP	#$20
		LDA	#$1000
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		SEP	#$20
.A8
		LDA	z:$31,X
		ORA	#$80
		STA	z:$31,X
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C60EFD

.A8
.I16

sub_C60F21:
		REP	#$20
.A16
		LDA	#$2000
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		SEP	#$20
.A8
		LDA	z:$38,X
		ORA	#1
		STA	z:$38,X
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C60F21

.A8
.I16

sub_C60F45:
		REP	#$20
.A16
		LDA	#$3000
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		SEP	#$20
.A8
		INC	a:.LOWORD($134),X
		LDA	z:$39,X
		ORA	#1
		AND	#$DF
		STA	z:$39,X
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C60F45

.A8
.I16

sub_C60F6E:
		REP	#$20
.A16
		LDA	#$4000
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		SEP	#$20
.A8
		INC	a:.LOWORD($135),X
		LDA	z:$39,X
		ORA	#2
		STA	z:$39,X
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C60F6E

.A8
.I16

sub_C60F95:
		REP	#$20
.A16
		LDA	#$5000
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C60F95

.A16
.I16

sub_C60FB1:
		REP	#$20
		LDA	#$6000
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		JSL	f:sub_C6113D
		LDY	#$A
		JSL	f:play_sound
		RTL
; End of function sub_C60FB1

.A16
.I16

sub_C60FD1:
		SEP	#$20
.A8
		LDA	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		BNE	locret_C60FFE
		JSL	f:is_object_aligned
		BCS	locret_C60FFE
		REP	#$20
.A16
		LDA	#.LOWORD(enter_level_exit)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(enter_level_exit)
		STA	z:2,X
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#4
		BNE	locret_C60FFE
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		AND	#$80
		ORA	#4
		STA	a:.LOWORD(game_flags) ; orig=0x0314

locret_C60FFE:
		RTL
; End of function sub_C60FD1

.A16
.I16

sub_C60FFF:
		SEP	#$20
.A8
		LDA	#1
		STA	z:$2F,X
		RTL
; End of function sub_C60FFF

.A8
.I16

sub_C61006:
		SEP	#$20
		LDA	z:$39,X
		ORA	#$80
		STA	z:$39,X
		REP	#$20
.A16
		LDA	#$800
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed

loc_C6101E:
		JSL	f:sub_C61129
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C61006

.A16
.I16

sub_C6102A:
		REP	#$20
		LDA	#$9900
		STA	z:$40

loc_C61031:
		LDA	#$99
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C6102A

.A16
.I16

question_mark_bonus:
		SEP	#$20
.A8
		LDA	#.BANKBYTE(bomb_up_bonus)
		STA	z:$55
		PHX
		LDX	#$17
		JSL	f:random
		REP	#$20
.A16
		INC
		CMP	#.LOWORD(POISON)
		BEQ	loc_C61066
		CMP	#.LOWORD(EXIT)
		BEQ	loc_C61066
		CMP	#$13
		BNE	loc_C61069

loc_C61066:
		LDA	#6

loc_C61069:
		ASL
		TAX
		LDA	f:bonus_handlers,X
		PLX
		STA	z:$53
		JSL	f:call_function_at_0053
		RTL
; End of function question_mark_bonus

.A16
.I16

sub_C61077:
		REP	#$20
		LDA	#$100
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C61077

.A16
.I16

sub_C61093:
		REP	#$20
		LDA	#$100
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C61093

.A16
.I16

sub_C610AF:
		REP	#$20
		LDA	#$8000
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C610AF

.A16
.I16

sub_C610CB:
		SEP	#$20
.A8
		LDA	#9
		STA	z:$3D,X
		REP	#$20
.A16
		LDA	#$9000
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:write_number_of_lives
		JSL	f:sub_C61129
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C610CB

.A16
.I16

sub_C610F1:
		REP	#$20
		LDA	#$500
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		LDY	#2

loc_C61108:
		JSL	f:play_sound
		RTL
; End of function sub_C610F1

.A16
.I16

sub_C6110D:
		REP	#$20
		LDA	#0
		STA	z:$40
		LDA	#5
		STA	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:sub_C61129
		LDY	#2
		JSL	f:play_sound
		RTL
; End of function sub_C6110D

.A16
.I16

sub_C61129:
		JSL	f:get_object_square_index
		TAY
		REP	#$20
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		RTL
; End of function sub_C61129

.A8
.I16

sub_C6113D:
		REP	#$20
.A16
		PHX
		LDX	#7
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		AND	#$FF
		CMP	#3
		BEQ	loc_C6115C
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		AND	#$F0
		CMP	#$50
		BNE	loc_C6115C
		LDX	#6

loc_C6115C:
		JSL	f:random
		AND	#$FF
		ASL
		ASL
		TAX
		LDA	f:sub_C6117E,X
		STA	z:$40
		LDA	f:sub_C6117E+2,X
		STA	z:$42
		PLX
		LDA	z:$40
		STA	a:.LOWORD($13A),X
		LDA	z:$42
		STA	a:.LOWORD($13C),X
		RTL
; End of function sub_C6113D

.A16
.I16

sub_C6117E:
		SBC	f:$13,X
		SBC	f:$23,X
		SBC	f:$43,X
		SBC	f:$83,X
		SBC	f:$63,X
		SBC	f:$103,X
		SBC	f:$B,X
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C611BA)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C611BA)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C611BA)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCS	nullsub_3
		SEP	#$20
		LDA	#2
		TSB	a:.LOWORD(game_flags) ; orig=0x0314
; End of function sub_C6117E

.A16
.I16
nullsub_3:
		RTL
.A16
.I16

sub_C611BA:
		SEP	#$20
.A8
		LDY	#0
		LDA	#$2E
		STA	z:$40

loc_C611C3:
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
		LDA	#.LOWORD(WHITE_PALETTE)
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
		LDA	#.LOWORD(sub_C61223)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C61223)
		STA	z:2,X
		RTL
; End of function sub_C611BA

.A8
.I16

sub_C61223:
		REP	#$20
.A16
		LDA	#.LOWORD(palette_allocation_related_array)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(palette_allocation_related_array)
		STA	z:$55
		REP	#$20
.A16
		INC	z:$53
		LDA	#1
		STA	z:$42
		LDA	#0
		STA	z:$44
		LDA	#8
		STA	z:$46
		JSL	f:loc_C475C8
		REP	#$20
		LDA	#.LOWORD(palette_allocation_related_array)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(palette_allocation_related_array)
		STA	z:$55
		REP	#$20
.A16
		LDA	#$660
		CLC
		ADC	#8
		STA	z:$53
		LDA	#8
		STA	z:$42
		LDA	#0
		STA	z:$44
		LDA	#$10
		STA	z:$46
		JSL	f:loc_C475C8
		REP	#$20
		LDA	#.LOWORD(loc_C612AC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C612AC)
		STA	z:2,X
		REP	#$20
.A16
		LDA	#$20
		STA	z:$10,X
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		AND	#$F0
		CMP	#$50
		BNE	loc_C612AC
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		AND	#$F
		DEC
		PHX
		TAX
		SEP	#$20
.A8
		LDA	f:palette_per_mecha_bomber,X
		STA	z:$40
		LDY	#0
		LDA	#$C
		JSL	f:palette_related
		PLX

loc_C612AC:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C612B9
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C612B9:
		BIT	#$41
		BEQ	loc_C612C1
		JML	f:locret_C61308
; ---------------------------------------------------------------------------

loc_C612C1:
		REP	#$20
.A16
		DEC	z:$10,X
		BNE	locret_C61308
		JSL	f:sub_C61309
		REP	#$20
		LDA	#$10
		STA	z:$10,X
		REP	#$20
		LDA	#.LOWORD(loc_C612DF)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C612DF)
		STA	z:2,X

loc_C612DF:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C612EC
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C612EC:
		BIT	#$41
		BEQ	loc_C612F4
		JML	f:locret_C61308
; ---------------------------------------------------------------------------

loc_C612F4:
		REP	#$20
.A16
		DEC	z:$10,X
		BNE	locret_C61308
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		AND	#$FD
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		JSL	f:delete_object

locret_C61308:
		RTL
; End of function sub_C61223

.A16
.I16

sub_C61309:
		REP	#$20
		PHX
		LDX	#$1C80

loc_C6130F:
		LDA	z:0,X
		CMP	#.LOWORD(loc_C44DA9)
		BNE	loc_C61324
		SEP	#$20
.A8
		LDA	#8
		STA	z:3,X
		LDA	z:$C,X
		ORA	#$10
		STA	z:$C,X
		REP	#$20
.A16

loc_C61324:
		LDA	z:6,X
		TAX
		INC
		BNE	loc_C6130F
		PLX
		RTL
; End of function sub_C61309

; ---------------------------------------------------------------------------
byte_C6132C:
		.BYTE $23
word_C6132D:	.WORD $A40, $A48, $A48,	$A48, $A4A, $A4A, $A4A,	$A4C, $A4C, $A4C, $A4C,	$A4C, $A4C, $A4C, $A4A,	$A4A, $A48
		.WORD $A40, $A42, $A44,	$A46, $A46, $A44, $A42,	$A40, $A48, $A4A, $A4C,	$A4A, $A48, $A40, $A42,	$A40, $A48
		.WORD $A40
.A8
.I16

sub_C61373:
		STY	z:$40
		SEP	#$20
		LDA	#.LOBYTE(sub_C6139F)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C6139F)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C6139F)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C61393
		JML	f:nullsub_3
; ---------------------------------------------------------------------------

loc_C61393:
		LDA	z:$40
		STA	a:.LOWORD($20),Y
		LDA	#0
		STA	a:.LOWORD($22),Y
		RTL
; End of function sub_C61373

.A16
.I16

sub_C6139F:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C613AC
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C613AC:
		BIT	#$41
		BEQ	loc_C613B4
		JML	f:locret_C613EC
; ---------------------------------------------------------------------------

loc_C613B4:
		REP	#$20
.A16
		LDY	z:$20,X
		LDA	z:$22,X
		ASL
		PHX
		TAX
		SEP	#$20
.A8
		LDA	f:word_C6132D,X
		STA	z:$40
		PLX
		LDA	z:$40
		STA	a:.LOWORD(bg1_tilemap+$20),Y
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$20
		BNE	loc_C613DE
		LDA	a:.LOWORD($917),Y
		BIT	#1
		BNE	loc_C613DE
		LDA	z:$40
		STA	a:.LOWORD(bg1_tilemap),Y

loc_C613DE:
		INC	z:$22,X
		LDA	z:$22,X
		CMP	f:byte_C6132C
		BNE	locret_C613EC
		JML	f:delete_object
; ---------------------------------------------------------------------------

locret_C613EC:
		RTL
; End of function sub_C6139F

.A8
.I16

sub_C613ED:
		REP	#$20
.A16
		PHX
		LDA	z:$4E
		AND	#$F
		TAX
		SEP	#$20
.A8
		LDA	f:byte_C60B5D,X
		STA	z:$40
		PLX
		LDA	z:$40
		BEQ	loc_C6143F
		LDA	z:$21,X
		AND	z:$4E
		BNE	loc_C61427
		LDA	z:$20,X
		AND	#3
		BEQ	loc_C61419
		LDA	z:$4E
		AND	#3
		STA	z:$20,X
		STA	z:$21,X
		BRA	loc_C61421
; ---------------------------------------------------------------------------

loc_C61419:
		LDA	z:$4E
		AND	#$C
		STA	z:$20,X
		STA	z:$21,X

loc_C61421:
		JSL	f:start_animation_by_index
		SEP	#$20

loc_C61427:
		LDA	z:$4E
		CMP	#6
		BNE	loc_C61431
		JML	f:loc_C6147C
; ---------------------------------------------------------------------------

loc_C61431:
		CMP	#5
		BNE	loc_C61439
		JML	f:loc_C61499
; ---------------------------------------------------------------------------

loc_C61439:
		CMP	#9
		BEQ	loc_C61442
		BRA	loc_C6145F
; ---------------------------------------------------------------------------

loc_C6143F:
		STZ	z:$21,X
		RTL
; ---------------------------------------------------------------------------

loc_C61442:
		JSL	f:sub_C6151D
		BCC	loc_C6144C
		JML	f:loc_C614AE
; ---------------------------------------------------------------------------

loc_C6144C:
		JSL	f:sub_C614BE
		BCC	loc_C61456
		JML	f:loc_C614AE
; ---------------------------------------------------------------------------

loc_C61456:
		SEP	#$20
		LDA	z:$21,X
		EOR	#9
		STA	z:$4E
		RTL
; ---------------------------------------------------------------------------

loc_C6145F:
		JSL	f:sub_C6151D
		BCC	loc_C61469
		JML	f:loc_C614AE
; ---------------------------------------------------------------------------

loc_C61469:
		JSL	f:sub_C614DD
		BCC	loc_C61473
		JML	f:loc_C614AE
; ---------------------------------------------------------------------------

loc_C61473:
		SEP	#$20
		LDA	z:$21,X
		EOR	#$A
		STA	z:$4E
		RTL
; ---------------------------------------------------------------------------

loc_C6147C:
		JSL	f:sub_C614FC
		BCC	loc_C61486
		JML	f:loc_C614AE
; ---------------------------------------------------------------------------

loc_C61486:
		JSL	f:sub_C614DD
		BCC	loc_C61490
		JML	f:loc_C614AE
; ---------------------------------------------------------------------------

loc_C61490:
		SEP	#$20
		LDA	z:$21,X
		EOR	#6
		STA	z:$4E
		RTL
; ---------------------------------------------------------------------------

loc_C61499:
		JSL	f:sub_C614FC
		BCS	loc_C614AE
		JSL	f:sub_C614BE
		BCS	loc_C614AE
		SEP	#$20
		LDA	z:$21,X
		EOR	#5
		STA	z:$4E
		RTL
; ---------------------------------------------------------------------------

loc_C614AE:
		SEP	#$20
		LDA	z:$20,X
		CMP	z:$21,X
		BNE	loc_C614B9
		STA	z:$4E
		RTL
; ---------------------------------------------------------------------------

loc_C614B9:
		STA	z:$21,X
		STA	z:$4E
		RTL
; End of function sub_C613ED

.A8
.I16

sub_C614BE:
		SEP	#$20
		LDA	z:$11,X
		AND	#$F
		CMP	#8
		BNE	loc_C614D9
		JSL	f:get_object_square_index
		REP	#$20
.A16
		INC
		INC
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$80
		BNE	loc_C614DB

loc_C614D9:
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C614DB:
		SEC
		RTL
; End of function sub_C614BE

.A8
.I16

sub_C614DD:
		SEP	#$20
		LDA	z:$11,X
		AND	#$F
		CMP	#8
		BNE	loc_C614F8
		JSL	f:get_object_square_index
		REP	#$20
.A16
		DEC
		DEC
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$80
		BNE	loc_C614FA

loc_C614F8:
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C614FA:
		SEC
		RTL
; End of function sub_C614DD

.A8
.I16

sub_C614FC:
		SEP	#$20
		LDA	z:$14,X
		AND	#$F
		CMP	#8
		BNE	loc_C61519
		JSL	f:get_object_square_index
		REP	#$20
.A16
		CLC
		ADC	#$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$80
		BNE	loc_C6151B

loc_C61519:
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C6151B:
		SEC
		RTL
; End of function sub_C614FC

.A8
.I16

sub_C6151D:
		SEP	#$20
		LDA	z:$14,X
		AND	#$F
		CMP	#8
		BNE	loc_C6153A
		JSL	f:get_object_square_index
		REP	#$20
.A16
		SEC
		SBC	#$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$80
		BNE	loc_C6153C

loc_C6153A:
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C6153C:
		SEC
		RTL
; End of function sub_C6151D

.A16
.I16

sub_C6153E:
		REP	#$20
		LDA	z:$11,X
		CLC
		ADC	#0
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$40
		LDA	z:$14,X
		CLC
		ADC	#0
		AND	#$F0
		ASL
		ASL
		ADC	z:$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$42
		RTL
; End of function sub_C6153E

.A16
.I16

sub_C61562:
		REP	#$20
		LDA	z:enemy::x_position,X
		CLC
		ADC	#0
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$40
		LDA	z:enemy::y_position,X
		CLC
		ADC	#.LOWORD(-9)
		AND	#$F0
		ASL
		ASL
		ADC	z:$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$42
		RTL
; End of function sub_C61562

.A16
.I16

sub_C61586:
		REP	#$20
		LDA	z:$11,X
		CLC
		ADC	#0
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$40
		LDA	z:$14,X
		CLC
		ADC	#8
		AND	#$F0
		ASL
		ASL
		ADC	z:$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$42
		RTL
; End of function sub_C61586

.A16
.I16

sub_C615AA:
		REP	#$20
		LDA	z:$11,X
		CLC
		ADC	#$FFF7
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$40
		LDA	z:$14,X
		CLC
		ADC	#0
		AND	#$F0
		ASL
		ASL
		ADC	z:$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$42
		RTL
; End of function sub_C615AA

.A16
.I16

sub_C615CE:
		REP	#$20
		LDA	z:enemy::x_position,X
		CLC
		ADC	#8
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$40
		LDA	z:enemy::y_position,X
		CLC
		ADC	#0
		AND	#$F0
		ASL
		ASL
		ADC	z:$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$42
		RTL
; End of function sub_C615CE

.A8
.I16

random2:
		REP	#$20
.A16
		LDA	z:$76
		SEC
		SBC	#$18
		BCS	loc_C61600
		CLC
		ADC	#$37

loc_C61600:
		STA	z:$74
		PHX
		TAX
		LDA	f:random_data,X
		LDX	z:$76
		EOR	f:random_data,X
		PLX
		PHA
		INC	z:$76
		LDA	z:$76
		CMP	#$37
		BCC	loc_C6161B
		STZ	z:$76

loc_C6161B:
		PLA
		RTL
; End of function random2

; ---------------------------------------------------------------------------
random_data:	.BYTE $6B, $7A,	$32, $74, 2, $FE, $6A, $27; 0
		.BYTE $F6, $FA,	$91, $36, $39, $1D, $43, $6D; 8
		.BYTE $3D, $B4,	$B5, 1,	$16, $7F, $16, $7C; $10
		.BYTE $B4, $20,	$80, $78, $88, $12, $1E, $F0; $18
		.BYTE $2E, $1B,	$DA, $EB, $B0, $6B, $BD, $A9; $20
		.BYTE $FC, $D9,	$B3, $EB, $43, $5D, $3A, $BD; $28
		.BYTE $A7, $99,	$58, $7C, $80, $44, $8C; $30
		.BYTE 0, 0, 0, 0, 0, 0,	0, 0, 0
.A16
.I16

call_screen_init_functions:
		SEP	#$20
.A8
		STZ	a:.LOWORD(byte_7E0C3E) ; orig=0x0C3E

loc_C61662:
		REP	#$20
.A16
		LDA	[$50]
		CMP	#$F0F0
		BEQ	loc_C6168B
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		LDA	z:$53
		PHA
		LDA	z:$56
		PHA
		JSL	f:call_function_at_0053
		REP	#$20
		PLA
		STA	z:$56
		PLA
		STA	z:$53
		BRA	loc_C61662
; ---------------------------------------------------------------------------

loc_C6168B:
		INC	z:$50
		INC	z:$50
		RTL
; End of function call_screen_init_functions

.A16
.I16

sub_C61690:
		REP	#$20
		LDX	#0
		LDA	#0

loc_C61698:
		STA	f:$7F0600,X
		INX
		INX
		CPX	#$60
		BNE	loc_C61698
		LDX	#0
		LDA	#$FFFF

loc_C616A9:
		STA	f:$7F0660,X
		INX
		INX

loc_C616AF:
		CPX	#$10
		BNE	loc_C616A9
		LDX	#0
		LDA	#$FFFF

loc_C616BA:
		STA	f:$7F0670,X
		INX
		INX
		CPX	#$40
		BNE	loc_C616BA

loc_C616C5:
		LDX	#0
		LDA	#0

loc_C616CB:
		STA	f:$C3F,X
		INX
		INX
		CPX	#$10
		BNE	loc_C616CB
		RTL
; End of function sub_C61690

.A8
.I16

create_enemies:
		REP	#$20
.A16
		LDA	#.LOWORD(unk_7F06B0)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7F06B0)
		STA	z:$61
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::pointer_to_enemy_list) ; orig=0x0D18
		STA	z:$56
		LDA	a:.LOWORD(level_manager_object+level_manager_object::pointer_to_enemy_list+1) ; orig=0x0D19
		STA	z:$57
		LDA	#.BANKBYTE(stage_1_1)
		STA	z:$58
		LDA	a:.LOWORD(level_manager_object+level_manager_object::pointer_to_bonus_list) ; orig=0x0D1A
		STA	z:$5C
		LDA	a:.LOWORD(level_manager_object+level_manager_object::pointer_to_bonus_list+1) ; orig=0x0D1B
		STA	z:$5D
		LDA	#.BANKBYTE(stage_1_1)
		STA	z:$5E
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_8) ; orig=0x0D30
		CMP	#3
		BNE	loc_C6170D
		JML	f:locret_C61774
; ---------------------------------------------------------------------------

loc_C6170D:
		JSL	f:generate_random_position
		JSL	f:get_collision_mask_for_position
		REP	#$20
.A16
		BIT	#$60F0
		BNE	loc_C6170D
		LDA	[$56]
		BEQ	locret_C61774
		STA	z:$53
		INC	z:$56
		LDA	[$56]
		STA	z:$54
		INC	z:$56
		INC	z:$56
		LDA	#$2000
		STA	a:.LOWORD(collision_map),Y
		STZ	z:$48
		LDA	z:$4A
		BEQ	loc_C61748
		DEC	z:$4A
		LDA	[$59]
		INC	z:$59
		INC	z:$59
		PHY
		ASL
		TAY
		LDA	[$5C],Y
		STA	z:$48
		PLY

loc_C61748:
		LDA	z:$50
		PHA
		LDA	z:$53
		PHA
		LDA	z:$56
		PHA
		LDA	z:$5F
		PHA
		LDA	z:$60
		PHA
		JSL	f:call_function_at_0053
		REP	#$20
		PLA
		STA	z:$60
		PLA
		STA	z:$5F
		PLA
		STA	z:$56
		PLA
		STA	z:$53
		PLA
		STA	z:$50
		INC	z:$5F
		INC	z:$5F
		INC	z:$5F
		BRA	loc_C6170D
; ---------------------------------------------------------------------------
.A8

locret_C61774:
		RTL
; End of function create_enemies

.A16
.I16

call_function_at_0053:
		JMP	[$53]
; End of function call_function_at_0053

; ---------------------------------------------------------------------------
		.BYTE $40
.A16
.I16

load_global_sprites:
		REP	#$20
		LDA	[$50]
		STA	z:$5F
		INC	z:$50
		LDA	[$50]
		STA	z:$60
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	z:$40
		INC	z:$50
		INC	z:$50
		INC	z:$50
		PHY
		PHX
		JSL	f:allocate_graphics
		SEP	#$20
.A8
		LDA	a:.LOWORD(word_7E0C8F+1) ;	orig=0x0C90
		BEQ	loc_C617C2
		REP	#$20
.A16
		LDA	#graphics_table	- unk_7F0000
		STA	z:$62
		SEP	#$20
.A8
		LDA	#.BANKBYTE(graphics_table)
		STA	z:$64
		REP	#$20
.A16
		LDA	#$F
		STA	z:$40

loc_C617B4:
		JSL	f:sub_C617C5
		INC	z:$62
		INC	z:$62
		INC	z:$62
		DEC	z:$40
		BNE	loc_C617B4

loc_C617C2:
		PLX
		PLY
		RTL
; End of function load_global_sprites

.A16
.I16

sub_C617C5:
		REP	#$20
		LDX	#0
		LDY	#1
		LDA	#6
		STA	z:$42

loc_C617D2:
		LDA	[$62]
		CMP	f:bomberman_graphics_2,X
		BNE	loc_C617EF
		LDA	[$62],Y
		CMP	f:bomberman_graphics_2+1,X
		BNE	loc_C617EF
		LDA	f:bomberman_mini_graphics,X
		STA	[$62]
		LDA	f:bomberman_mini_graphics+1,X
		STA	[$62],Y
		RTL
; ---------------------------------------------------------------------------

loc_C617EF:
		INX
		INX
		INX
		DEC	z:$42
		BNE	loc_C617D2
		RTL
; End of function sub_C617C5

; ---------------------------------------------------------------------------
bomberman_graphics_2:.FARADDR bomberman_graphic_0
		.FARADDR bomberman_graphic_1
		.FARADDR bomberman_graphic_2
		.FARADDR bomberman_graphic_3
		.FARADDR bomberman_extra_graphic_0
		.FARADDR bomberman_extra_graphic_1
bomberman_mini_graphics:.FARADDR bomberman_mini_graphic_0
		.FARADDR bomberman_mini_graphic_1
		.FARADDR bomberman_mini_graphic_2
		.FARADDR bomberman_mini_graphic_3
		.FARADDR bomberman_mini_graphic_4
		.FARADDR bomberman_mini_warp_graphic
.A8
.I16

allocate_graphics:
		REP	#$20
.A16
		STZ	z:$42
		REP	#$20
		LDA	#graphics_table	- unk_7F0000
		STA	z:$62
		SEP	#$20
.A8
		LDA	#.BANKBYTE(graphics_table)
		STA	z:$64

loc_C6182C:
		REP	#$20
.A16
		LDA	[$5F]
		CMP	[$62]
		BNE	loc_C6183E
		LDY	#1
		LDA	[$5F],Y
		CMP	[$62],Y
		BNE	loc_C6183E
		RTL
; ---------------------------------------------------------------------------

loc_C6183E:
		LDA	[$62]
		BEQ	loc_C6184C
		INC	z:$62
		INC	z:$62
		INC	z:$62
		INC	z:$42
		BRA	loc_C6182C
; ---------------------------------------------------------------------------

loc_C6184C:
		LDA	[$5F]
		STA	[$62]
		LDY	#1
		LDA	[$5F],Y
		STA	[$62],Y
		INC	z:$5F
		INC	z:$5F
		INC	z:$5F
		INC	z:$62
		INC	z:$62
		INC	z:$62
		DEC	z:$40
		BNE	loc_C6184C
		RTL
; End of function allocate_graphics

.A16
.I16

load_palettes:
		REP	#$20
		LDA	[$50]
		STA	z:$5F
		INC	z:$50
		LDA	[$50]
		STA	z:$60
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	z:$44
		INC	z:$50
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDA	#.LOWORD(palette_allocation_related_array)
		STA	z:$62
		SEP	#$20
.A8
		LDA	#.BANKBYTE(palette_allocation_related_array)
		STA	z:$64
		SEP	#$20

loc_C61891:
		LDA	[$5F]
		STA	[$62]
		REP	#$20
.A16
		INC	z:$5F
		INC	z:$62
		SEP	#$20
.A8
		DEC	z:$44
		BNE	loc_C61891
		RTL
; End of function load_palettes

.A8
.I16

palette_allocation_related:
		REP	#$20
.A16
		STZ	z:$42
		REP	#$20
		LDA	#.LOWORD(palette_allocation_related_array+8)
		STA	z:$62
		SEP	#$20
.A8
		LDA	#.BANKBYTE(palette_allocation_related_array+8)
		STA	z:$64

loc_C618B3:
		LDA	[$62]
		CMP	z:$40
		BEQ	locret_C618D4
		CMP	#$FF
		BEQ	loc_C618D0
		REP	#$20
.A16
		INC	z:$62
		LDA	z:$62
		CMP	#$670
		BEQ	locret_C618D4
		INC	z:$42
		INC	z:$42
		SEP	#$20
.A8
		BRA	loc_C618B3
; ---------------------------------------------------------------------------

loc_C618D0:
		LDA	z:$40
		STA	[$62]

locret_C618D4:
		RTL
; End of function palette_allocation_related

; ---------------------------------------------------------------------------
		.WORD $28, $18,	$E8, $B8, $E8
		.WORD $18, $28,	$B8, $28, $38
		.WORD $E8, $A8,	$E8, $38, $28
		.WORD $A8, 0, 0, 0, $101
		.WORD $100, $101, $101,	$202, $201
		.WORD $202, $202, $303,	$302, $303
		.WORD $303, $404, $403,	$404, $404
		.WORD $404
word_C6191D:	.WORD $88, $806, $40
		.WORD $98, $806, $40
		.WORD $C8, $806, $40
		.WORD $CC, $806, $40
		.WORD $D0, $806, $40
		.WORD $D4, $806, $40
		.WORD $D8, $806, $40
		.WORD $10C, $806, $40
		.WORD $110, $806, $40
		.WORD $114, $806, $40
		.WORD $148, $806, $40
		.WORD $14A, $806, $40
		.WORD $156, $806, $40
		.WORD $158, $806, $40
		.WORD $1C8, $806, $40
		.WORD $1CA, $806, $40
		.WORD $1D6, $806, $40
		.WORD $1D8, $806, $40
		.WORD $20C, $806, $40
		.WORD $214, $806, $40
		.WORD $210, $806, $40
		.WORD $248, $806, $40
		.WORD $24C, $806, $40
		.WORD $250, $806, $40
		.WORD $254, $806, $40
		.WORD $258, $806, $40
		.WORD $288, $806, $40
		.WORD $298, $806, $40
word_C619C5:	.WORD $44, 1
		.WORD $C4, 1
		.WORD $144, $C
		.WORD $1C4, $D
		.WORD $244, 1
		.WORD $2C4, 1
		.WORD $48, 1
		.WORD $4C, 4
		.WORD $50, $A
		.WORD $54, 4
		.WORD $58, 1
		.WORD $5C, 1
		.WORD $DC, 1
		.WORD $15C, $D
		.WORD $1DC, $C
		.WORD $25C, 1
		.WORD $2DC, 1
		.WORD $2C8, 1
		.WORD $2CC, 4
		.WORD $2D0, $A
		.WORD $2D4, 4
		.WORD $2D8, 1
.A8
.I16

generate_soft_blocks:
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::soft_blocks) ; orig=0x0D3C
		STA	z:$46
		BNE	loc_C61A6F
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$200
		BEQ	locret_C61A6E
		PHX
		PHY
		LDX	#0

loc_C61A33:
		LDA	f:word_C6191D,X
		TAY
		LDA	f:word_C6191D+2,X
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	f:word_C6191D+4,X
		STA	a:.LOWORD(collision_map),Y
		INX
		INX
		INX
		INX
		INX
		INX
		CPX	#$A8
		BNE	loc_C61A33
		LDX	#0

loc_C61A54:
		LDA	f:word_C619C5,X
		TAY
		LDA	f:word_C619C5+2,X
		PHX
		JSL	f:create_bonus_object
		PLX
		INX
		INX
		INX
		INX
		CPX	#$58
		BNE	loc_C61A54
		PLY
		PLX

locret_C61A6E:
		RTL
; ---------------------------------------------------------------------------

loc_C61A6F:
		SEP	#$20
.A8
		LDA	a:.LOWORD(level_manager_object+level_manager_object::pointer_to_bonus_list) ; orig=0x0D1A
		STA	z:$53
		LDA	a:.LOWORD(level_manager_object+level_manager_object::pointer_to_bonus_list+1) ; orig=0x0D1B
		STA	z:$54
		LDA	#.BANKBYTE(stage_1_1)
		STA	z:$55
.A16

loc_C61A7F:
		JSL	f:generate_random_position
		JSL	f:get_collision_mask_for_position
		REP	#$20
		BIT	#EXIT|BOMB|SOFT_BLOCK|HARD_BLOCK|$4000
		BNE	loc_C61A7F
		REP	#$20
		LDA	#$806
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	z:$48
		BEQ	loc_C61AA8
		DEC	z:$48
		LDA	[$59]
		INC	z:$59
		INC	z:$59
		PHY
		ASL
		TAY
		LDA	[$53],Y
		PLY

loc_C61AA8:
		ORA	#SOFT_BLOCK
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$46
		BEQ	loc_C61AB6
		JML	f:loc_C61A7F
; ---------------------------------------------------------------------------

loc_C61AB6:
		SEP	#$20
.A8
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT #$40       ; Trampolines flag
		BNE	loc_C61AC0
		RTL
; ---------------------------------------------------------------------------

loc_C61AC0:
		REP	#$20
.A16
		LDA	#$10
		STA	z:$48

loc_C61AC7:				; Generate Trampolines
		JSL	f:generate_random_position
		JSL	f:get_collision_mask_for_position
		REP	#$20
		BIT	#EXIT|BOMB|SOFT_BLOCK|HARD_BLOCK|$4000
		BNE	loc_C61AC7
		REP	#$20
		LDA	#$A40
		STA	a:.LOWORD(bg1_tilemap),Y
		STA	a:.LOWORD(bg1_tilemap+$20),Y
		DEC	z:$48
		BNE	loc_C61AC7
		RTL
; End of function generate_soft_blocks

.A16
.I16

copy_enemy_creation_functions:
		REP	#$20
		LDA	#.LOWORD(unk_7F06B0)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7F06B0)
		STA	z:$55
		REP	#$20
.A16
		LDA	z:$50
		STA	a:.LOWORD(level_manager_object+level_manager_object::pointer_to_enemy_list) ; orig=0x0D18

loc_C61AFA:
		LDA	[$50]
		STA	[$53]
		BEQ	loc_C61B15
		INC	z:$50
		INC	z:$53
		LDA	[$50]
		STA	[$53]
		INC	z:$50
		INC	z:$50
		INC	z:$53
		INC	z:$53
		INC	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		BRA	loc_C61AFA
; ---------------------------------------------------------------------------

loc_C61B15:
		INC	z:$50
		INC	z:$50
		RTL
; End of function copy_enemy_creation_functions

.A16
.I16

process_bonuses:
		REP	#$20
		LDA	z:$50
		STA	a:.LOWORD(level_manager_object+level_manager_object::pointer_to_bonus_list) ; orig=0x0D1A
		STZ	z:$46

loc_C61B23:
		LDA	[$50]
		BEQ	loc_C61B2F
		INC	z:$50
		INC	z:$50
		INC	z:$46
		BRA	loc_C61B23
; ---------------------------------------------------------------------------

loc_C61B2F:
		INC	z:$50
		INC	z:$50
		RTL
; End of function process_bonuses

.A16
.I16

related_to_enemy_bonuses:
		REP	#$20
		LDA	z:$46
		STA	z:$48
		LDA	z:$46
		STA	a:.LOWORD(level_manager_object+level_manager_object::bonus_count) ; orig=0x0D03
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_8) ; orig=0x0D30
		CMP	#3
		BEQ	loc_C61B69
		LDA	#0
		STA	z:$48
		LDA	#0
		STA	z:$4A
		LDA	z:$46
		BEQ	loc_C61BA3
		LDX	z:$46
		JSL	f:random
		STA	z:$48
		LDA	z:$46
		SEC
		SBC	z:$48
		CMP	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		BCS	related_to_enemy_bonuses
		STA	z:$4A

loc_C61B69:
		STZ	z:$D3
		LDA	z:$46
		BEQ	loc_C61BA3

loc_C61B6F:
		LDA	z:$D3
		STA	z:$D5
		LDX	z:$46
		JSL	f:random
		LDX	#$FFFE
		JSL	f:sub_C61B95
		BCS	loc_C61B6F
		PHA
		LDA	z:$D3
		ASL
		TAX
		PLA
		STA	f:$7F0670,X
		INC	z:$D3
		LDA	z:$D3
		CMP	z:$46
		BNE	loc_C61B6F
		RTL
; End of function related_to_enemy_bonuses

.A16
.I16

sub_C61B95:
		INX
		INX
		DEC	z:$D5
		BMI	loc_C61BA3
		CMP	f:$7F0670,X
		BNE	sub_C61B95
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C61BA3:
		CLC
		RTL
; End of function sub_C61B95

; ---------------------------------------------------------------------------
word_C61BA5:	.WORD $104, $144
		.WORD $146, $184
		.WORD $52, $54
		.WORD $56, $94
		.WORD $110, $150
		.WORD $14E, $152
		.WORD $190, $1D0
		.WORD $1CE, $1D2
		.WORD $210, $19C
		.WORD $1DC, $1DA
		.WORD $21C, $2CA
		.WORD $2CC, $28C
		.WORD $2CE
word_C61BD7:	.WORD $48, $4A
		.WORD $88, $C8
		.WORD $C6, $C4
		.WORD $104, $58
		.WORD $56, $98
		.WORD $D8, $DA
		.WORD $DC, $11C
word_C61BF3:	.WORD $44, $46
		.WORD $48, $84
		.WORD $C4, $58
		.WORD $5A, $5C
		.WORD $9C, $DC
		.WORD $244, $284
		.WORD $2C4, $2C6
		.WORD $2C8, $25C
		.WORD $29C, $2DC
		.WORD $2DA, $2D8
word_C61C1B:	.WORD $44, $46
		.WORD $84, $5A
		.WORD $5C, $9C
		.WORD $284, $2C4
		.WORD $2C6, $29C
		.WORD $2DC, $2DA
word_C61C33:	.WORD $14C, $14E
		.WORD $150, $152
		.WORD $154, $18C
		.WORD $190, $194
		.WORD $1CC, $1CE
		.WORD $1D0, $1D2
		.WORD $1D4
word_C61C4D:	.WORD $C8, $C6
		.WORD $88, $CA
		.WORD $108, $D8
		.WORD $D6, $98
		.WORD $DA, $118
		.WORD $248, $208
		.WORD $246, $24A
		.WORD $288, $258
		.WORD $256, $218
		.WORD $25A, $298
		.WORD $150, $190
		.WORD $1D0
.A16
.I16

sub_C61C7B:
		REP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_8) ; orig=0x0D30
		AND	#$FF
		CMP	#2
		BNE	loc_C61C97
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		AND	#$F
		CMP	#8
		BNE	loc_C61C97
		JML	f:locret_C61D1F
; ---------------------------------------------------------------------------

loc_C61C97:
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#4
		BEQ	loc_C61CA3
		JML	f:locret_C61D1F
; ---------------------------------------------------------------------------

loc_C61CA3:
		BIT	#8
		BEQ	loc_C61CAC
		JML	f:sub_C61D20
; ---------------------------------------------------------------------------

loc_C61CAC:
		BIT	#$20
		BEQ	loc_C61CB5
		JML	f:sub_C61D3B
; ---------------------------------------------------------------------------

loc_C61CB5:
		BIT	#$1000
		BEQ	loc_C61CBE
		JML	f:sub_C61D73
; ---------------------------------------------------------------------------

loc_C61CBE:
		BIT	#$800
		BEQ	loc_C61CC7
		JML	f:sub_C61D8E
; ---------------------------------------------------------------------------

loc_C61CC7:
		REP	#$20
		LDA	#.LOWORD(word_C61C1B)
		STA	z:$5C
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C61C1B)
		STA	z:$5E
		REP	#$20
.A16
		LDA	#$4000
		STA	z:$DB
		LDA	#$C
		STA	z:$4A
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_8) ; orig=0x0D30
		CMP	#3
		BEQ	set_unallowed_soft_blocks
		LDA	#6
		STA	z:$4A
		LDA	#$6000
		STA	z:$DB
		JSL	f:set_unallowed_soft_blocks
		REP	#$20
		LDA	#.LOWORD(word_C61BD7)
		STA	z:$5C
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C61BD7)
		STA	z:$5E
		REP	#$20
.A16
		LDA	#$E
		STA	z:$4A
		LDA	#$2000
		STA	z:$DB
; End of function sub_C61C7B

.A16
.I16

set_unallowed_soft_blocks:
		LDA	[$5C]
		TAY
		LDA	z:$DB
		STA	a:.LOWORD(collision_map),Y
		INC	z:$5C
		INC	z:$5C
		DEC	z:$4A
		BNE	set_unallowed_soft_blocks

locret_C61D1F:
		RTL
; End of function set_unallowed_soft_blocks

.A16
.I16

sub_C61D20:
		REP	#$20
		LDA	#.LOWORD(word_C61C33)
		STA	z:$5C
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C61C33)
		STA	z:$5E
		REP	#$20
.A16
		LDA	#$4000
		STA	z:$DB
		LDA	#$D
		STA	z:$4A
		BRA	set_unallowed_soft_blocks
; End of function sub_C61D20

.A16
.I16

sub_C61D3B:
		REP	#$20
		LDA	#.LOWORD(word_C61C4D)
		STA	z:$5C
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C61C4D)
		STA	z:$5E
		REP	#$20
.A16
		LDA	#$4000
		STA	z:$DB
		LDA	#$17
		STA	z:$4A
		JSL	f:set_unallowed_soft_blocks
		REP	#$20
		LDA	#.LOWORD(word_C61C1B)
		STA	z:$5C
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C61C1B)
		STA	z:$5E
		REP	#$20
.A16
		LDA	#$4000
		STA	z:$DB
		LDA	#$C
		STA	z:$4A
		BRA	set_unallowed_soft_blocks
; End of function sub_C61D3B

.A16
.I16

sub_C61D73:
		REP	#$20
		LDA	#.LOWORD(word_C61BF3)
		STA	z:$5C
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C61BF3)
		STA	z:$5E
		REP	#$20
.A16
		LDA	#$4000
		STA	z:$DB
		LDA	#$14
		STA	z:$4A
		BRA	set_unallowed_soft_blocks
; End of function sub_C61D73

.A16
.I16

sub_C61D8E:
		REP	#$20
		LDA	#.LOWORD(word_C61BA5)
		STA	z:$5C
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C61BA5)
		STA	z:$5E
		REP	#$20
.A16
		LDA	#$4000
		STA	z:$DB
		LDA	#$19
		STA	z:$4A
		JSL	f:set_unallowed_soft_blocks
		REP	#$20
		LDA	#.LOWORD(word_C61C1B)
		STA	z:$5C
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C61C1B)
		STA	z:$5E
		REP	#$20
.A16
		LDA	#$4000
		STA	z:$DB
		LDA	#$C
		STA	z:$4A
		JMP	a:.LOWORD(set_unallowed_soft_blocks)
; End of function sub_C61D8E

.A16
.I16

generate_hard_blocks_and_exit:
		REP	#$20
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#2
		BNE	locret_C61E1F
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#6
		BNE	locret_C61E1F
		LDA	#$70       ; Number of free tiles + 1
		STA	z:$4A		; Used later in	verification
		BRA	loc_C61DE6
; ---------------------------------------------------------------------------

loc_C61DE0:
		LDA	#0
		STA	a:.LOWORD(collision_map),Y

loc_C61DE6:
		JSL	f:generate_random_position
		JSL	f:get_collision_mask_for_position
		REP	#$20
		BIT	#EXIT|BOMB|SOFT_BLOCK|HARD_BLOCK|$4000
		BNE	loc_C61DE6
		REP	#$20
		LDA	#.LOWORD(HARD_BLOCK)
		STA	a:.LOWORD(collision_map),Y
		PHY

loc_C61DFE:
		JSL	f:is_map_non_continous
		PLY
		BCS	loc_C61DE0
		REP	#$20
		LDA	a:.LOWORD(bg1_tilemap+$24)	; orig=0x0518
		STA	a:.LOWORD(bg1_tilemap),Y
		DEC	z:$4A
		DEC	z:$48
		BPL	loc_C61DE6
		LDA	#EXIT|SOFT_BLOCK
		STA	a:.LOWORD(collision_map),Y
		LDA	#$806
		STA	a:.LOWORD(bg1_tilemap),Y

locret_C61E1F:
		RTL
; End of function generate_hard_blocks_and_exit

.A16
.I16

generate_random_position:
		REP	#$20
		LDX	#$D
		JSL	f:random
		SEP	#$20
.A8
		INC
		INC
		ASL
		ASL
		ASL
		ASL
		STA	z:$40
		REP	#$20
.A16
		LDX	#$B
		LDA	z:$40
		PHA
		JSL	f:random
		SEP	#$20
.A8
		INC
		ASL
		ASL
		ASL
		ASL
		STA	z:$42
		REP	#$20
.A16
		PLA
		STA	z:$40
		RTL
; End of function generate_random_position

.A16
.I16

is_map_non_continous:
		REP	#$20
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	z:$61
		LDY	#$44       ; Default Player 1 start position
		STZ	z:$5C
		STZ	z:$4C

loc_C61E5C:
		JSL	f:add_unprocessed_neighbor_tiles_to_stack
		LDA	z:$44
		BEQ	loc_C61E7C
		LDA	z:$4C
		CMP	z:$4A
		BNE	loc_C61E5C
		LDA	#.LOWORD(~(PLAYER))
		JSL	f:apply_mask_to_collision_map
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C61E73:
		LDA	#.LOWORD(~(PLAYER))
		JSL	f:apply_mask_to_collision_map
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C61E7C:
		REP	#$20
		LDA	z:$5C
		BEQ	loc_C61E73
		DEC	z:$5C
		DEC	z:$5C
		LDA	z:$5C
		CLC
		ADC	#.LOWORD(temp_uncompressed_graphics) ; Reused as	a stack	to queue (yes...) unprocessed tiles
		STA	z:$5F
		LDA	[$5F]
		TAY
		BRA	loc_C61E5C
; End of function is_map_non_continous

.A16
.I16

add_unprocessed_neighbor_tiles_to_stack:
		REP	#$20
		STZ	z:$44
		LDA	#3
		STA	z:$46
		STY	z:$53

loc_C61E9E:
		PHY
		LDA	z:$46
		ASL
		TAX
		TYA
		CLC
		ADC	f:collision_map_direction_offsets,X
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#PLAYER
		BNE	loc_C61EDA
		AND	#BONUS_MASK|BOMB|SOFT_BLOCK|HARD_BLOCK
		BNE	loc_C61EDA
		INC	z:$44
		LDA	z:$44
		CMP	#1
		BEQ	loc_C61EE2
		LDA	z:$5C
		CLC
		ADC	#.LOWORD(temp_uncompressed_graphics)
		STA	z:$5F
		TYA
		STA	[$5F]
		INC	z:$5C
		INC	z:$5C
		LDA	a:.LOWORD(collision_map),Y
		ORA	#PLAYER
		STA	a:.LOWORD(collision_map),Y
		INC	z:$4C

loc_C61EDA:
		PLY
		DEC	z:$46
		BPL	loc_C61E9E
		LDY	z:$53
		RTL
; ---------------------------------------------------------------------------

loc_C61EE2:
		STY	z:$53
		LDA	a:.LOWORD(collision_map),Y
		ORA	#PLAYER
		STA	a:.LOWORD(collision_map),Y
		INC	z:$4C
		PLY
		DEC	z:$46
		BPL	loc_C61E9E
		LDY	z:$53
		RTL
; End of function add_unprocessed_neighbor_tiles_to_stack

.A16
.I16

apply_mask_to_collision_map:
		REP	#$20
		STA	z:$40
		LDY	#$320		; .SIZEOF(collision_map)

loc_C61EFE:
		LDA	a:.LOWORD(collision_map),Y
		AND	z:$40
		STA	a:.LOWORD(collision_map),Y
		DEY
		DEY
		BPL	loc_C61EFE
		RTL
; End of function apply_mask_to_collision_map

; ---------------------------------------------------------------------------
collision_map_direction_offsets:
		.WORD .LOWORD(-$40)
		.WORD .LOWORD(-2)
		.WORD 2
		.WORD $40
.A16
.I16

random:
		REP	#$20
		LDA	z:$7C
		ORA	#1
		STA	z:$40
		LDA	#$383
		STA	z:$42
		JSL	f:sub_C61F54
		LDA	z:$44
		STA	z:$42
		STA	z:$7C
		TXA
		XBA
		STA	z:$DB
		JSL	f:sub_C61F36
		LDA	z:$40
		RTL
; End of function random

.A16
.I16

sub_C61F36:
		STZ	z:$44
		STZ	z:$40
		LDY	#8

loc_C61F3D:
		ASL	z:$44
		ROL	z:$40
		ASL	z:$DB
		BCC	loc_C61F50
		LDA	z:$42
		CLC
		ADC	z:$44
		STA	z:$44
		BCC	loc_C61F50
		INC	z:$40

loc_C61F50:
		DEY
		BNE	loc_C61F3D
		RTL
; End of function sub_C61F36

.A16
.I16

sub_C61F54:
		LDY	#$10

loc_C61F57:
		ASL	z:$44
		ASL	z:$40
		BCC	loc_C61F64
		LDA	z:$42
		CLC
		ADC	z:$44
		STA	z:$44

loc_C61F64:
		DEY
		BNE	loc_C61F57
		RTL
; End of function sub_C61F54

.A16
.I16

sub_C61F68:
		REP	#$20
		LDY	#$D40
		SEP	#$20
.A8
		LDA	a:.LOWORD($11),Y
		SEC
		SBC	z:$11,X
		BCS	loc_C61F7A
		EOR	#$FF
		INC

loc_C61F7A:
		CMP	#$40
		BCS	loc_C61F8F
		LDA	a:.LOWORD($14),Y
		SEC
		SBC	z:$14,X
		BCS	loc_C61F89
		EOR	#$FF
		INC

loc_C61F89:
		CMP	#$40
		BCS	loc_C61F8F
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C61F8F:
		CLC
		RTL
; End of function sub_C61F68

.A8
.I16

sub_C61F91:
		SEP	#$20
		LDA	#$80
		STA	a:.LOWORD(VRAM_ADDRESS_INCREMENT_VALUE)
		REP	#$20
.A16
		LDA	#$58CC
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$4E8
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$4E9
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$4EA
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$4EB
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$4EC
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$4ED
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$4EE
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$4EF
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$58EC
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$4F8
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$4F9
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$4FA
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$4FB
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$4FC
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$4FD
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$4FE
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$4FF

loc_C62003:
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		RTL
; End of function sub_C61F91

.A8
.I16

sub_C62007:
		SEP	#$20
		LDA	#$80
		STA	a:.LOWORD(VRAM_ADDRESS_INCREMENT_VALUE)
		REP	#$20
.A16
		LDA	#$58CC
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#0

loc_C6201F:
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)

loc_C62022:
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#$58EC
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		RTL
; End of function sub_C62007

.A16
.I16

sub_C6207D:
		REP	#$20
		LDA	#0
		STA	z:$40
		JSL	f:sub_C620A4
		LDA	#1
		STA	z:$40
		JSL	f:sub_C620A4
		LDA	#2
		STA	z:$40
		JSL	f:sub_C620A4
		LDA	#3
		STA	z:$40
		JSL	f:sub_C620A4
		RTL
; End of function sub_C6207D

.A16
.I8

sub_C620A4:
		SEP	#$20
.A8

loc_C620A6:
		LDA	#.LOBYTE(sub_C620C4)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C620C4)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C620C4)
		STA	z:$DD
		LDA	#$80

loc_C620B4:
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	locret_C620C3
		LDA	z:$40
		STA	a:.LOWORD($20),Y

locret_C620C3:
		RTL
; End of function sub_C620A4

.A8
.I16

sub_C620C4:
		REP	#$20
.A16
		LDY	#$D40

loc_C620C9:
		SEP	#$20
.A8
		LDA	a:.LOWORD(4),Y
		BEQ	loc_C620FA
		LDA	a:.LOWORD($11),Y
		SEC
		SBC	z:$11,X
		BEQ	loc_C620F2
		BCS	loc_C620DD
		EOR	#$FF
		INC

loc_C620DD:
		CMP	#$10
		BCS	loc_C620FA
		LDA	a:.LOWORD($14),Y
		SEC
		SBC	z:$14,X

loc_C620E7:
		BCS	loc_C620EC
		EOR	#$FF
		INC

loc_C620EC:
		CMP	#$10
		BCS	loc_C620FA
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C620F2:
		LDA	a:.LOWORD($14),Y
		SEC
		SBC	z:$14,X
		BNE	loc_C620E7

loc_C620FA:
		REP	#$20
.A16
		LDA	a:.LOWORD(6),Y
		TAY
		CMP	#$FFFF
		BNE	loc_C620C9
		CLC
		RTL
; End of function sub_C620C4

.A16
.I16

sub_C62107:
		SEP	#$20
.A8
		STZ	z:$4E

loc_C6210B:
		REP	#$20
.A16
		LDA	z:$40
		PHA
		LDA	z:$50
		PHA
		SEP	#$20
.A8
		LDA	[$50]
		STA	z:$40
		LDA	z:$4E
		LDY	#0
		JSL	f:palette_related
		REP	#$20
.A16
		PLA
		STA	z:$50
		PLA
		STA	z:$40
		INC	z:$50
		SEP	#$20
.A8
		INC	z:$4E
		LDA	z:$4E
		CMP	#$10
		BNE	loc_C6210B
		RTL
; End of function sub_C62107

.A16
.I16

update_palettes:
		SEP	#$20
.A8
		LDX	#.LOWORD(unk_7E1F80)

loc_C6213C:
		LDA	z:3,X
		BIT	#1
		BEQ	loc_C62156
		CMP	#3
		BNE	loc_C6214E
		JSL	f:load_a_palette
		SEP	#$20
		BRA	loc_C62156
; ---------------------------------------------------------------------------

loc_C6214E:
		STA	z:3,X
		JSL	f:fade_a_palette
		SEP	#$20

loc_C62156:
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		CPX	#.LOWORD(unk_7E1FC0)
		BNE	loc_C6213C

loc_C62163:
		LDA	z:3,X
		BIT	#1
		BEQ	loc_C6217D
		CMP	#3
		BNE	loc_C62175
		JSL	f:load_b_palette
		SEP	#$20
		BRA	loc_C6217D
; ---------------------------------------------------------------------------

loc_C62175:
		STA	z:3,X
		JSL	f:fade_b_palette
		SEP	#$20

loc_C6217D:
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		CPX	#$2000
		BNE	loc_C62163
		LDA	a:.LOWORD(word_7E0318) ; orig=0x0318
		BEQ	locret_C621A3
		STZ	a:.LOWORD(word_7E0318) ; orig=0x0318
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C624AF)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C624AF)
		STA	z:$52
		JSL	f:sub_C62514

locret_C621A3:
		RTL
; End of function update_palettes

.A8
.I16

load_a_palette:
		REP	#$20
.A16
		LDA	#.LOWORD(a_palettes)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(a_palettes)
		STA	z:$55
		BRA	load_palette_at_53
; End of function load_a_palette

.A8
.I16

load_b_palette:
		REP	#$20
.A16
		LDA	#.LOWORD(b_palettes)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(b_palettes)
		STA	z:$55

load_palette_at_53:
		SEP	#$20
		STZ	z:2,X
		LDA	z:3,X
		AND	#$FE
		STA	z:3,X
		REP	#$20
.A16
		LDA	z:4,X
		CLC
		ADC	#.LOWORD(unk_7F0400)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7F0400)
		STA	z:$52
		REP	#$20
.A16
		LDA	z:0,X
		AND	#$FF
		ASL
		ASL
		ASL
		ASL
		ASL
		STA	z:$42
		CLC
		ADC	z:$53
		STA	z:$53
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53

loc_C621FF:
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		LDA	a:.LOWORD(word_7E0318) ; orig=0x0318
		ORA	#1
		STA	a:.LOWORD(word_7E0318) ; orig=0x0318
		RTL
; End of function load_b_palette

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR fade_b_palette

locret_C622B7:
		RTL
; END OF FUNCTION CHUNK	FOR fade_b_palette
.A8
.I16

fade_a_palette:
		REP	#$20
.A16
		LDA	#.LOWORD(a_palettes)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(a_palettes)
		STA	z:$55
		BRA	fade_palette
; End of function fade_a_palette

; ---------------------------------------------------------------------------
		SEP	#$20
.A8
.I16

fade_b_palette:

; FUNCTION CHUNK AT 22B7 SIZE 00000001 BYTES

		REP	#$20
.A16
		LDA	#.LOWORD(b_palettes)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(b_palettes)
		STA	z:$55

fade_palette:
		REP	#$20
.A16
		LDA	z:1,X
		PHX
		AND	#$F
		TAX
		TAY
		SEP	#$20
.A8
		LDA	f:byte_C62426,X
		PLX
		AND	a:.LOWORD(word_7E0304) ; orig=0x0304
		BNE	locret_C622B7
		PHX
		REP	#$20
.A16
		TYA
		TAX
		SEP	#$20
.A8
		LDA	f:byte_C62416,X
		PLX
		STA	z:$40
		LDA	z:2,X
		SEC
		SBC	z:$40

loc_C622FF:
		STA	z:2,X
		BCS	loc_C6230B
		STZ	z:2,X
		LDA	z:3,X
		AND	#$FE
		STA	z:3,X

loc_C6230B:
		REP	#$20
.A16
		LDA	z:4,X
		CLC
		ADC	#.LOWORD(unk_7F0400)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7F0400)
		STA	z:$52
		REP	#$20
.A16
		LDA	z:0,X
		AND	#$FF
		ASL
		ASL
		ASL
		ASL
		ASL
		STA	z:$42
		CLC
		ADC	z:$53
		STA	z:$53
		LDA	#$10
		STA	z:$4A

loc_C62333:
		JSL	f:sub_C62357
		REP	#$20
		DEC	z:$4A
		BNE	loc_C62333
		RTL
; End of function fade_b_palette

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_C62357

loc_C6233E:
		REP	#$20
		LDA	[$53]
		STA	[$50]
		INC	z:$53
		INC	z:$53
		INC	z:$50
		INC	z:$50
		SEP	#$20
.A8
		LDA	a:.LOWORD(word_7E0318) ; orig=0x0318
		ORA	#1
		STA	a:.LOWORD(word_7E0318) ; orig=0x0318
		RTL
; END OF FUNCTION CHUNK	FOR sub_C62357
.A16
.I16

sub_C62357:

; FUNCTION CHUNK AT 233E SIZE 00000019 BYTES

		REP	#$20
		LDA	z:3,X
		AND	#1
		BEQ	loc_C6233E
		LDA	[$50]
		STA	z:$42
		LDA	[$53]
		STA	z:$48
		STZ	z:$46
		SEP	#$20
.A8
		LDA	z:$48
		AND	#$1F
		STA	z:$41
		LDA	z:$42
		AND	#$1F
		STA	z:$44
		JSL	f:sub_C623E1
		SEP	#$20
		AND	#$1F
		STA	z:$46
		REP	#$20
.A16
		LDA	z:$48
		LSR
		LSR
		LSR
		LSR
		LSR
		SEP	#$20
.A8
		AND	#$1F
		STA	z:$41
		REP	#$20
.A16
		LDA	z:$42
		LSR
		LSR
		LSR
		LSR
		LSR
		SEP	#$20
.A8
		AND	#$1F
		STA	z:$44
		JSL	f:sub_C623E1
		REP	#$20
.A16
		AND	#$1F
		ASL
		ASL
		ASL
		ASL
		ASL
		ORA	z:$46
		STA	z:$46
		LDA	z:$49
		LSR
		LSR
		AND	#$1F
		STA	z:$41
		LDA	z:$43
		LSR
		LSR
		AND	#$1F
		STA	z:$44
		JSL	f:sub_C623E1
		SEP	#$20
.A8
		AND	#$1F
		ASL
		ASL
		ORA	z:$47
		STA	z:$47
		REP	#$20
.A16
		LDA	z:$46
		STA	[$50]
		INC	z:$50
		INC	z:$50
		INC	z:$53
		INC	z:$53
		RTL
; End of function sub_C62357

.A16
.I16

sub_C623E1:
		SEP	#$20
.A8
		SEC
		SBC	z:$41
		BCS	loc_C623F1
		LDA	z:$41
		SEC
		SBC	z:$44
		CMP	z:2,X
		BCC	loc_C62413

loc_C623F1:
		LDA	a:.LOWORD(word_7E0318) ; orig=0x0318
		ORA	#1
		STA	a:.LOWORD(word_7E0318) ; orig=0x0318
		LDA	z:$44
		CMP	z:$41
		BEQ	locret_C62412

loc_C623FF:
		BCC	loc_C62409
		SEC
		SBC	z:$40
		BCS	locret_C62408
		LDA	z:$41

locret_C62408:
		RTL
; ---------------------------------------------------------------------------

loc_C62409:
		CLC
		ADC	z:$40
		CMP	#$1F
		BCC	locret_C62412
		LDA	z:$41

locret_C62412:
		RTL
; ---------------------------------------------------------------------------

loc_C62413:
		LDA	z:$44
		RTL
; End of function sub_C623E1

; ---------------------------------------------------------------------------
byte_C62416:	.BYTE $20, $10
		.BYTE 8, 4
		.BYTE 2, 1
		.BYTE 1, 1
		.BYTE 1, 1
		.BYTE 1, 1
		.BYTE 1, 1
		.BYTE 1, 1
byte_C62426:	.BYTE 0, 0
		.BYTE 0, 0
		.BYTE 0, 0
		.BYTE 1, 3
		.BYTE 7, $F
		.BYTE $1F, $3F
		.BYTE $7F, $FF
		.BYTE $FF, $FF
.A8
.I16

palette_related:
		REP	#$20
.A16
		PHX
		AND	#$F
		ASL
		ASL
		ASL
		CLC
		ADC	#$1F80
		TAX
		SEP	#$20
.A8
		LDA	z:$40
		STA	z:0,X
		TYA
		STA	z:1,X
		LDA	#$20
		STA	z:2,X
		LDA	#1
		STA	z:3,X
		TYA
		AND	#$FF
		BNE	loc_C6245E
		LDA	#3
		STA	z:3,X

loc_C6245E:
		PLX
		RTL
; End of function palette_related

.A16
.I16

sub_C62460:
		REP	#$20
		LDA	a:.LOWORD(word_7E030C) ; orig=0x030C
		CMP	a:.LOWORD(word_7E030E) ; orig=0x030E
		BNE	loc_C6246B
		RTL
; ---------------------------------------------------------------------------

loc_C6246B:
		TAX
		CLC
		ADC	#$A
		CMP	#$140
		BCC	loc_C62478
		LDA	#0

loc_C62478:
		STA	a:.LOWORD(word_7E030C) ; orig=0x030C
		SEP	#$20
.A8
		LDA	a:.LOWORD($31C),X
		STA	z:$50
		LDA	a:.LOWORD($31D),X
		STA	z:$51
		LDA	a:.LOWORD($31E),X
		STA	z:$52
		LDA	a:.LOWORD($31F),X
		STA	z:$53
		LDA	a:.LOWORD($320),X
		STA	z:$54
		LDA	a:.LOWORD($321),X
		STA	z:$55
		REP	#$20
.A16
		LDA	a:.LOWORD($322),X
		STA	z:$40
		LDA	a:.LOWORD($324),X
		STA	z:$42
		JSL	f:call_function_at_0050
		JML	f:sub_C62460
; End of function sub_C62460

.A16
.I16

sub_C624AF:
		SEP	#$20
.A8
		LDA	#0
		STA	a:.LOWORD(ADDRESS_FOR_CG_RAM_WRITE)
		LDA	#0
		STA	a:.LOWORD(DMA_5_PARAMS)
		LDA	#$22
		STA	a:.LOWORD(DMA_5_B_ADDRESS)
		LDA	#.LOBYTE(unk_7F0400)
		STA	a:.LOWORD(DMA_5_A_ADDRESS_LOW_BYTE)
		LDA	#.HIBYTE(unk_7F0400)
		STA	a:.LOWORD(DMA_5_A_ADDRESS_HIGH_BYTE)
		LDA	#.BANKBYTE(unk_7F0400)
		STA	a:.LOWORD(DMA_5_A_ADDRESS_BANK)
		LDA	#0
		STA	a:.LOWORD(DMA_5_BYTES_COUNT_LOW_BYTE)
		LDA	#2
		STA	a:.LOWORD(DMA_5_BYTES_COUNT_HIGH_BYTE)
		LDA	#$20
		STA	a:.LOWORD(REGULAR_DMA_CHANNEL_ENABLE)
		RTL
; End of function sub_C624AF

.A8
.I16

sub_C624DF:
		SEP	#$20
		LDA	#0
		STA	a:.LOWORD(ADDRESS_FOR_CG_RAM_WRITE)
		SEP	#$20
		LDA	#0
		STA	a:.LOWORD(DMA_5_PARAMS)
		LDA	#$22
		STA	a:.LOWORD(DMA_5_B_ADDRESS)
		LDA	a:.LOWORD(word_7E0053) ; orig=0x0053
		STA	a:.LOWORD(DMA_5_A_ADDRESS_LOW_BYTE)
		LDA	a:.LOWORD(word_7E0053+1) ;	orig=0x0054
		STA	a:.LOWORD(DMA_5_A_ADDRESS_HIGH_BYTE)

loc_C624FE:
		LDA	a:.LOWORD(word_7E0055) ; orig=0x0055
		STA	a:.LOWORD(DMA_5_A_ADDRESS_BANK)
		LDA	#$20
		STA	a:.LOWORD(DMA_5_BYTES_COUNT_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DMA_5_BYTES_COUNT_HIGH_BYTE)
		LDA	#$20
		STA	a:.LOWORD(REGULAR_DMA_CHANNEL_ENABLE)
		RTL
; End of function sub_C624DF

.A8
.I16

sub_C62514:
		REP	#$20
.A16
		PHX
		LDA	a:.LOWORD(word_7E030E) ; orig=0x030E
		TAX
		CLC
		ADC	#$A
		CMP	#$140
		BCC	loc_C62527
		LDA	#0

loc_C62527:
		CMP	a:.LOWORD(word_7E030C) ; orig=0x030C
		BEQ	loc_C6255F
		TAY
		SEP	#$20
.A8
		LDA	z:$50
		STA	a:.LOWORD($31C),X
		LDA	z:$51
		STA	a:.LOWORD($31D),X
		LDA	z:$52
		STA	a:.LOWORD($31E),X
		LDA	z:$53
		STA	a:.LOWORD($31F),X
		LDA	z:$54
		STA	a:.LOWORD($320),X
		LDA	z:$55
		STA	a:.LOWORD($321),X
		REP	#$20
.A16
		LDA	z:$40
		STA	a:.LOWORD($322),X
		LDA	z:$42
		STA	a:.LOWORD($324),X
		TYA
		STA	a:.LOWORD(word_7E030E) ; orig=0x030E

loc_C6255D:
		PLX
		RTL
; ---------------------------------------------------------------------------

loc_C6255F:
		INC	a:.LOWORD(word_7E030A) ; orig=0x030A
		BRA	loc_C6255D
; End of function sub_C62514

.A16
.I16

unknown_init_:
		REP	#$20
		STZ	a:.LOWORD(word_7E030C) ; orig=0x030C
		STZ	a:.LOWORD(word_7E030E) ; orig=0x030E
		RTL
; End of function unknown_init_

.A8
.I16

advance_animation_2:
		REP	#$20
.A16
		LDA	#$FF
		STA	z:$40
		BRA	loc_C6257D
; End of function advance_animation_2

.A16
.I16

advance_animation:
		REP	#$20
		LDA	#0
		STA	z:$40

loc_C6257D:
		LDA	#.LOWORD(level_manager_object+level_manager_object::anonymous_7)
		STA	z:$56
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_7) ; orig=0x0D28

loc_C62585:
		TAY
		LDA	a:.LOWORD(4),Y
		AND	#$FF
		CMP	z:player::y_position,X
		BCC	loc_C6259A
		STY	z:$56
		LDA	a:.LOWORD(0),Y
		CMP	#$FFFF
		BNE	loc_C62585

loc_C6259A:
		LDY	a:.LOWORD(word_7E00BE) ; orig=0x00BE
		LDA	($56)
		STA	a:.LOWORD(0),Y
		TYA
		STA	($56)
		LDA	z:player::y_position,X
		STA	a:.LOWORD(4),Y
		TXA
		STA	a:.LOWORD(2),Y
		LDA	a:.LOWORD(word_7E00BE) ; orig=0x00BE
		CLC
		ADC	#$40
		STA	a:.LOWORD(word_7E00BE) ; orig=0x00BE
		SEP	#$20
.A8
		LDA	z:$40
		STA	a:.LOWORD(5),Y
		LDA	z:player::ticks_left_for_frames,X
		DEC
		BNE	loc_C625CF
		LDA	z:player::current_frame,X
		INC
		CMP	z:player::max_frame,X
		BCC	loc_C625CF
		REP	#$20
.A16
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C625CF:
		REP	#$20
		CLC
		RTL
; End of function advance_animation

.A8
.I16

sub_C625D3:
		SEP	#$20
		LDA	a:.LOWORD(5),Y
		BEQ	load_animation_frame
		REP	#$20
.A16
		LDA	z:$C,X
		PHA
		JSL	f:load_animation_frame
		REP	#$20
		PLA
		STA	z:$C,X
		CLC
		RTL
; End of function sub_C625D3

.A8
.I16

load_animation_frame:
		SEP	#$20
		LDA	a:.LOWORD(word_7E0308+1) ;	orig=0x0309
		BIT	#$C0
		BEQ	loc_C62601
		BIT	#$80
		BEQ	loc_C625FB
		JML	f:loc_C62729
; ---------------------------------------------------------------------------

loc_C625FB:
		EOR	#1
		STA	a:.LOWORD(word_7E0308+1) ;	orig=0x0309
		RTL
; ---------------------------------------------------------------------------

loc_C62601:
		LDA	z:$C,X
		ASL
		ASL
		CLC
		ADC	z:8,X
		STA	z:$50
		LDA	#0
		ADC	z:9,X
		STA	z:$51
		LDA	z:$A,X
		STA	z:$52
		LDY	#1
		LDA	[$50]
		STA	z:$53
		LDA	[$50],Y
		INY
		STA	z:$54
		LDA	[$50],Y
		STA	z:$55
		LDA	[$53]
		BNE	loc_C6262C
		JML	f:loc_C62731
; ---------------------------------------------------------------------------

loc_C6262C:
		STA	z:$4C
		INC	z:$53
		BNE	loc_C62634
		INC	z:$54

loc_C62634:
		LDA	a:.LOWORD(word_7E0306) ; orig=0x0306
		STA	z:$56
		LDA	a:.LOWORD(word_7E0306+1) ;	orig=0x0307
		STA	z:$57
		LDA	a:.LOWORD(word_7E0308) ; orig=0x0308
		STA	z:$58
		REP	#$20
.A16
		LDA	z:$11,X
		SEC
		SBC	#8
		STA	z:$4A
		LDA	z:$14,X
		CLC
		ADC	#$18
		STA	z:$D3
		SEP	#$20
.A8

loc_C62657:
		STZ	z:$41
		LDA	[$53]
		BPL	loc_C6265F
		DEC	z:$41

loc_C6265F:
		CLC
		ADC	z:$4A
		STA	[$56]
		INC	z:$56
		LDA	z:$41
		ADC	z:$4B
		AND	#1
		STA	z:$4D
		LDY	#1
		LDA	[$53],Y
		CLC
		ADC	z:$D3
		STA	[$56]
		INC	z:$56
		STZ	z:$41
		LDA	[$53],Y
		STA	z:$40
		BPL	loc_C62684
		DEC	z:$41

loc_C62684:
		REP	#$20
.A16
		LDA	z:$D3
		CLC
		ADC	z:$40
		BPL	loc_C62698
		CMP	#$FFE0
		BCS	loc_C62696
		JML	f:loc_C62712
; ---------------------------------------------------------------------------

loc_C62696:
		BRA	loc_C626A1
; ---------------------------------------------------------------------------

loc_C62698:
		CMP	#$F0
		BCC	loc_C626A1
		JML	f:loc_C62712
; ---------------------------------------------------------------------------

loc_C626A1:
		SEP	#$20
.A8
		INY
		LDA	#0
		XBA
		LDA	[$53],Y
		CLC
		ADC	z:$F,X
		AND	#$F
		PHX
		TAX
		STZ	z:$47
		BIT	#8
		BEQ	loc_C626B8
		INC	z:$47

loc_C626B8:
		LDA	f:byte_C307D7+$58,X
		PLX
		LDY	#3
		ORA	[$53],Y
		STA	[$56]
		INC	z:$56
		INY
		LDA	[$53],Y
		AND	#$CF
		ORA	z:$E,X
		ORA	z:$47
		CLC
		ADC	z:$1E,X
		STA	[$56]
		LDA	[$53],Y
		AND	#$20
		PHX
		TAX
		LDA	f:byte_C307D7+$58,X
		PLX
		ORA	z:$4D
		LDY	#$200
		STA	[$56],Y
		INC	z:$56
		LDA	a:.LOWORD(word_7E0306) ; orig=0x0306
		CLC
		ADC	#4
		STA	a:.LOWORD(word_7E0306) ; orig=0x0306
		BNE	loc_C626FF
		LDA	a:.LOWORD(word_7E0306+1) ;	orig=0x0307
		BIT	#1
		BNE	loc_C62729
		INC	a:.LOWORD(word_7E0306+1) ;	orig=0x0307
		INC	z:$57

loc_C626FF:
		REP	#$20
.A16
		LDA	z:$53
		CLC
		ADC	#5
		STA	z:$53
		SEP	#$20
.A8
		DEC	z:$4C
		BEQ	loc_C62731
		JMP	a:.LOWORD(loc_C62657)
; ---------------------------------------------------------------------------
.A16

loc_C62712:
		REP	#$20
		DEC	z:$56
		DEC	z:$56
		LDA	z:$53
		CLC
		ADC	#5
		STA	z:$53
		SEP	#$20
.A8
		DEC	z:$4C
		BEQ	loc_C62731
		JMP	a:.LOWORD(loc_C62657)
; ---------------------------------------------------------------------------

loc_C62729:
		LDA	a:.LOWORD(word_7E0308+1) ;	orig=0x0309
		ORA	#$80
		STA	a:.LOWORD(word_7E0308+1) ;	orig=0x0309

loc_C62731:
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$C1
		BNE	loc_C6273F
		LDA	z:$D,X
		DEC
		BEQ	loc_C62743
		STA	z:$D,X

loc_C6273F:
		REP	#$20
.A16
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C62743:
		LDA	z:$C,X
		INC
		CMP	z:$B,X
		BCC	loc_C62763
		STZ	z:$C,X
		LDA	z:8,X
		STA	z:$50
		LDA	z:9,X
		STA	z:$51
		LDA	z:$A,X
		STA	z:$52
		LDY	#3
		LDA	[$50],Y
		STA	z:$D,X
		REP	#$20
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C62763:
		STA	z:$C,X
		ASL
		ASL
		CLC
		ADC	z:8,X
		STA	z:$50
		LDA	#$7500
		ORA	#$5185
		LDA	z:$A,X
		STA	z:$52
		LDY	#3
		LDA	[$50],Y
		STA	z:$D,X
		REP	#$20
		CLC
		RTL
; End of function load_animation_frame

.A16
.I16

sub_C62781:
		SEP	#$20
.A8
		DEC	z:$56
		DEC	z:$56
		JML	f:loc_C626FF
; End of function sub_C62781

.A16
.I16

sub_C6278B:
		SEP	#$20
.A8
		LDA	a:.LOWORD(word_7E0308+1) ;	orig=0x0309
		BIT	#$C0
		BEQ	loc_C627A2
		BIT	#$80
		BEQ	loc_C6279C
		JML	f:loc_C6280B
; ---------------------------------------------------------------------------

loc_C6279C:
		EOR	#1
		STA	a:.LOWORD(word_7E0308+1) ;	orig=0x0309
		RTL
; ---------------------------------------------------------------------------

loc_C627A2:
		LDA	a:.LOWORD(word_7E0306) ; orig=0x0306
		STA	z:$56
		LDA	a:.LOWORD(word_7E0306+1) ;	orig=0x0307
		STA	z:$57
		LDA	a:.LOWORD(word_7E0308) ; orig=0x0308
		STA	z:$58
		LDA	#$F0
		CLC
		ADC	z:$42
		STA	[$56]
		INC	z:$56
		LDA	#$10
		CLC
		ADC	z:$45
		STA	[$56]
		INC	z:$56
		LDY	#2
		LDA	#0
		STA	z:$47
		XBA
		LDA	[$50],Y
		PHX
		TAX
		BIT	#8
		BEQ	loc_C627D5
		INC	z:$47

loc_C627D5:
		LDA	f:byte_C307D7+$58,X
		PLX
		LDY	#3
		ORA	[$50],Y
		STA	[$56]
		INC	z:$56
		INY
		LDA	[$50],Y
		AND	#$F
		ORA	z:$48
		ORA	z:$47
		STA	[$56]
		LDA	#2
		LDY	#$200
		STA	[$56],Y
		LDA	a:.LOWORD(word_7E0306) ; orig=0x0306
		CLC
		ADC	#4
		STA	a:.LOWORD(word_7E0306) ; orig=0x0306
		BNE	locret_C6280A
		LDA	a:.LOWORD(word_7E0306+1) ;	orig=0x0307
		BIT	#1
		BNE	loc_C6280B
		INC	a:.LOWORD(word_7E0306+1) ;	orig=0x0307

locret_C6280A:
		RTL
; ---------------------------------------------------------------------------

loc_C6280B:
		LDA	a:.LOWORD(word_7E0308+1) ;	orig=0x0309
		ORA	#$80
		STA	a:.LOWORD(word_7E0308+1) ;	orig=0x0309
		RTL
; End of function sub_C6278B

.A8
.I16

start_animation:
		SEP	#$20
		LDA	[$50]
		STA	z:player::max_frame,X
		STZ	z:player::current_frame,X
		REP	#$20
.A16
		INC	z:$50
		LDA	z:$50
		STA	z:player::current_animation,X
		SEP	#$20
.A8
		LDA	z:$52
		STA	z:player::current_animation+2,X
		LDY	#3
		LDA	[$50],Y
		STA	z:player::ticks_left_for_frames,X
		REP	#$20
.A16
		RTL
; End of function start_animation

.A16
.I16

sub_C62834:
		REP	#$30
		LDX	a:.LOWORD(byte_7E00A0) ; orig=0x00A0
		CPX	a:.LOWORD(byte_7E00A2) ; orig=0x00A2
		BEQ	loc_C6288D
		SEP	#$20
.A8
		LDA	z:$6C
		BNE	loc_C6288D
		LDA	a:.LOWORD($80),X
		STA	z:$40
		REP	#$20
.A16
		AND	#$FF
		TAX
		SEP	#$20
.A8
		LDA	f:byte_C62896,X
		CMP	z:$6E
		BCS	loc_C6285D
		LDA	z:$6F
		BNE	loc_C62881

loc_C6285D:
		LDA	f:byte_C62896,X
		STA	z:$6E
		LDA	z:$40
		CMP	z:$70
		BNE	loc_C62876
		LDA	#0
		STA	a:.LOWORD(APU_I_O_PORT_2)
		STA	z:$6F
		STA	z:$6E
		DEC
		STA	z:$70
		RTL
; ---------------------------------------------------------------------------

loc_C62876:
		STA	z:$70
		STA	a:.LOWORD(APU_I_O_PORT_2)
		LDA	f:byte_C628C8,X
		STA	z:$6F

loc_C62881:
		REP	#$20
.A16
		LDA	a:.LOWORD(byte_7E00A0) ; orig=0x00A0
		INC
		AND	#$1F
		STA	a:.LOWORD(byte_7E00A0) ; orig=0x00A0

loc_C6288D:
		SEP	#$20
.A8
		LDA	z:$6F
		BEQ	locret_C62895
		DEC	z:$6F

locret_C62895:
		RTL
; End of function sub_C62834

; ---------------------------------------------------------------------------
byte_C62896:	.BYTE $28, $A, $A, $A, $14, $14, $A, $14, $14, $14, $14
		.BYTE $1E, $14,	$1E, $A, $14, $14, $1E,	$14, $A, $14, $14
		.BYTE $A, $14, $14, $14, $14, $14, $14,	$A, $1E, $1E, $14
		.BYTE $A, $A, $A, $A, $A, $A, $A, $A, $A, $A, $A, $A, $A
		.BYTE $A, $A, $A, $A
byte_C628C8:	.BYTE 0, $10, $10, $10,	$10, $10, $10, $10, $10, $10, $10
		.BYTE $10, $10,	$10, $10, $10, $10, $30, $10, $10, $10
		.BYTE $10, $10,	$10, $10, $10, $10, $10, $10, $10, $10
		.BYTE $10, $10,	$10, $10, $10, $10, $10, $10, $10, $10
		.BYTE $10, $10,	$10, $10, $10, $10, $10, $10, $10, $E2
		.BYTE $20, $A5,	$40, $C2, $20, $DA, $AD, $A2, 0, $AA, $1A
		.BYTE $CD, $A0,	0, $F0,	$10, $E2, $20, $A5, $40, $9D, $80
		.BYTE 0, $AD, $A2, 0, $1A, $29,	$1F, $8D, $A2, 0, $FA
		.BYTE $6B, $E2,	$20, $A9, $80, $8D, $15, $21, $A9, 1, $8D
		.BYTE $40, $43,	$A9, $18, $8D, $41, $43, $C2, $20, $AD
		.BYTE $9B, $C, $85, $5C, $22, $3A, $29,	$C6, $6B, $E2
		.BYTE $20, $A5,	$5C, $8D, $16, $21, $A5, $5D, $8D, $17
		.BYTE $21, $AD,	$50, 0,	$8D, $42, $43, $AD, $51, 0, $8D
		.BYTE $43, $43,	$AD, $52, 0, $8D, $44, $43, $A5, $40, $8D
		.BYTE $45, $43,	$A5, $41, $8D, $46, $43, $A9, $10, $8D
		.BYTE $B, $42, $6B
.A8
.I16

graphics_decompression_8192_bytes:
		REP	#$20
.A16
		LDA	#0
		STA	z:$48

loc_C6296F:
		LDA	[$53]
		TAY
		INC	z:$53
		INC	z:$53
		SEP	#$20
.A8
		LDA	[$53]
		STA	z:$52
		REP	#$20
.A16
		INC	z:$53
		JSL	f:graphics_decompression_1024_bytes
		REP	#$20
		INC	z:$48
		LDA	z:$48
		CMP	#4
		BNE	loc_C6296F
		RTL
; End of function graphics_decompression_8192_bytes

.A16
.I16

sub_C62990:
		REP	#$20
		STZ	z:$48
		LDA	z:$53
		TAY
		SEP	#$20
.A8
		LDA	z:$55
		STA	z:$52

loc_C6299D:
		JSL	f:graphics_decompression_1024_bytes
		REP	#$20
.A16
		INC	z:$48
		LDA	z:$48
		CMP	#8
		BNE	loc_C6299D
		RTL
; End of function sub_C62990

.A8
.I16

graphics_decompression_1024_bytes:
		REP	#$20
.A16
		LDA	z:$48
		AND	#$F
		ASL
		TAX
		LDA	f:graphic_load_offsets,X
		TAX
		SEP	#$20
.A8
		LDA	z:$52
		PHA
		PLB
		PHX
		JSL	f:graphics_decompression_128_bytes
		JSL	f:graphics_decompression_128_bytes
		JSL	f:graphics_decompression_128_bytes
		JSL	f:graphics_decompression_128_bytes
		PLX
		INX
		JSL	f:graphics_decompression_128_bytes
		JSL	f:graphics_decompression_128_bytes
		JSL	f:graphics_decompression_128_bytes
		JSL	f:graphics_decompression_128_bytes
		SEP	#$20
		LDA	#0
		PHA
		PLB
		REP	#$20
.A16
		RTL
; End of function graphics_decompression_1024_bytes

.A8
.I16

graphics_decompression_128_bytes:
		SEP	#$20
		LDA	#$10
		STA	z:$46

loc_C629F3:
		LDA	#8
		STA	z:$44
		STZ	z:$42
		LDA	a:.LOWORD(0),Y
		STA	z:$43
		INY

loc_C629FF:
		ASL	z:$43
		BCS	loc_C62A07
		LDA	z:$42
		BRA	loc_C62A0D
; ---------------------------------------------------------------------------

loc_C62A07:
		LDA	a:.LOWORD(0),Y
		STA	z:$42
		INY

loc_C62A0D:
		STA	f:$7E2800,X
		INX
		INX
		DEC	z:$44
		BNE	loc_C629FF
		DEC	z:$46
		BNE	loc_C629F3
		REP	#$20
.A16
		TXA
		CLC
		ADC	#$100
		TAX
		RTL
; End of function graphics_decompression_128_bytes

.A16
.I16

graphics_decompression_81aa_terminated_interleaved:
		REP	#$20
		LDY	z:$53
		SEP	#$20
.A8
		LDA	z:$55
		PHA
		PLB
		PHX
		JSL	f:graphics_decompression_81aa_terminated
		PLX
		INX
		JSL	f:graphics_decompression_81aa_terminated
		SEP	#$20
		LDA	#0
		PHA
		PLB
		REP	#$20
.A16
		RTL
; End of function graphics_decompression_81aa_terminated_interleaved

.A8
.I16

graphics_decompression_81aa_terminated:
		SEP	#$20
		LDA	#8
		STA	z:$44
		STZ	z:$42
		LDA	a:.LOWORD(0),Y
		STA	z:$43
		INY
		CMP	#$81
		BNE	loc_C62A5F
		LDA	a:.LOWORD(0),Y
		CMP	#$AA
		BNE	loc_C62A5F
		INY
		INY
		BRA	locret_C62A7E
; ---------------------------------------------------------------------------

loc_C62A5F:
		ASL	z:$43
		BCS	loc_C62A67
		LDA	z:$42
		BRA	loc_C62A6D
; ---------------------------------------------------------------------------

loc_C62A67:
		LDA	a:.LOWORD(0),Y
		STA	z:$42
		INY

loc_C62A6D:
		STA	f:$7E2800,X
		INX
		INX
		DEC	z:$44
		BNE	loc_C62A5F
		REP	#$20
.A16
		TXA
		CMP	z:$40
		BCC	graphics_decompression_81aa_terminated

locret_C62A7E:
		RTL
; End of function graphics_decompression_81aa_terminated

; ---------------------------------------------------------------------------
graphic_load_offsets:.WORD 0		     ; 0
		.WORD $100		; 1
		.WORD $800		; 2
		.WORD $900		; 3
		.WORD $1000		; 4
		.WORD $1100		; 5
		.WORD $1800		; 6
		.WORD $1900		; 7
		.WORD $2000		; 8
		.WORD $2100		; 9
		.WORD $2800		; $A
		.WORD $2900		; $B
		.WORD $3000		; $C
		.WORD $3100		; $D
		.WORD $3800		; $E
		.WORD $3900		; $F
some_graphic_offsets_array:.WORD $3900,	$3800, $3100, $3000, $2900, $2800, $2100
		.WORD $2000, $1900, $1800, $1100, $1000, $900, $800, $100
		.WORD 0
.A16
.I16

hidden_bonus_object:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C62B03)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C62B03)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C62B03)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		LDA	[$50]
		STA	a:.LOWORD($16),Y
		INC	z:$50
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD($18),Y
		INC	z:$50
		INC	z:$50
		INC	z:$50
		LDA	#0
		STA	a:.LOWORD($20),Y
		STA	a:.LOWORD($22),Y
		STA	a:.LOWORD($24),Y
		STA	a:.LOWORD($26),Y
		STA	a:.LOWORD($28),Y
		STA	a:.LOWORD($2A),Y

locret_C62B02:
		RTL
; End of function hidden_bonus_object

.A16
.I16

sub_C62B03:
		REP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$80
		BNE	locret_C62B02
		LDA	#.BANKBYTE(is_dying_bonus)
		STA	z:$55
		LDA	z:$16,X
		ASL
		PHX
		TAX
		LDA	f:hidden_bonus_verifiers_array,X
		STA	z:$53
		PLX
		LDY	#.LOWORD(player1_object)
		JSL	f:call_function_at_0053
		BCS	loc_C62B35
		LDY	#.LOWORD(player2_object)
		PHX
		INX
		INX
		JSL	f:call_function_at_0053
		PLX
		BCS	loc_C62B35
		RTL
; ---------------------------------------------------------------------------

loc_C62B35:
		REP	#$20
		LDA	#.LOWORD(loc_C62B42)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C62B42)
		STA	z:2,X

loc_C62B42:
		JSL	f:sub_C43B6E
		BCS	locret_C62B02
		REP	#$20
.A16
		LDA	z:$18,X
		JSL	f:create_bonus_object
		LDY	#4
		JSL	f:play_sound
		JSL	f:delete_object
		RTL
; End of function sub_C62B03

.A16
.I16

is_dying_bonus:
		REP	#$20
		LDA	a:.LOWORD(object::handler),Y
		CMP	#.LOWORD(_player_death)
		BNE	loc_C62B71
		SEP	#$20
.A8
		LDA	a:.LOWORD($3D),Y
		CMP	#1
		BNE	loc_C62B71

loc_C62B6F:
		SEC
		RTL
; ---------------------------------------------------------------------------
.A16

loc_C62B71:
		CLC
		RTL
; End of function is_dying_bonus

.A16
.I16

dont_move_bonus:
		REP	#%100000
		LDA	a:.LOWORD(4),Y
		AND	#$FF
		BEQ	loc_C62B71
		LDA	a:.LOWORD(player::down_keys),Y
		BEQ	loc_C62B84
		STZ	z:$20,X

loc_C62B84:
		INC	z:$20,X
		LDA	z:$20,X
		CMP	#$500
		BEQ	loc_C62B6F
		CLC
		RTL
; End of function dont_move_bonus

.A16
.I16

dont_move_on_exit_bonus:
		REP	#$20
		LDA	a:.LOWORD(4),Y
		AND	#$FF
		BEQ	loc_C62B71
		PHX
		TYX
		JSL	f:get_object_square_index
		PLX
		TAY
		LDA	a:.LOWORD(collision_map),Y
		AND	#BONUS_MASK
		CMP	#.LOWORD(EXIT)
		BEQ	loc_C62BAE
		STZ	z:$20,X

loc_C62BAE:
		INC	z:$20,X
		LDA	z:$20,X
		CMP	#$500
		BNE	loc_C62BBB
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62BBB:
		CLC
		RTL
; End of function dont_move_on_exit_bonus

.A16
.I16

press_start_bonus:
		SEP	#$20
.A8
		LDA	a:.LOWORD(player::down_keys+1),Y
		BIT	#$10
		BNE	loc_C62BCA
		JML	f:loc_C62B71
; ---------------------------------------------------------------------------

loc_C62BCA:
		SEC
		RTL
; End of function press_start_bonus

.A8
.I16

bombs_in_corners_bonus:
		SEP	#$20
		LDY	#$44
		LDA	#1
		JSL	f:verify_bomb_in_location
		LDY	#$5C
		LDA	#2
		JSL	f:verify_bomb_in_location
		LDY	#$2C4
		LDA	#4
		JSL	f:verify_bomb_in_location
		LDY	#$2DC
		LDA	#8
		JSL	f:verify_bomb_in_location
		LDA	z:$20,X
		CMP	#$F
		BEQ	loc_C62BFC
		JML	f:loc_C62B71
; ---------------------------------------------------------------------------

loc_C62BFC:
		SEC
		RTL
; End of function bombs_in_corners_bonus

.A8
.I16

verify_bomb_in_location:
		STA	z:$40
		LDA	a:.LOWORD(collision_map),Y
		AND	#EXIT|BOMB|SOFT_BLOCK|HARD_BLOCK
		CMP	#.LOWORD(BOMB)
		BNE	locret_C62C0F
		LDA	z:$20,X
		ORA	z:$40
		STA	z:$20,X

locret_C62C0F:
		RTL
; End of function verify_bomb_in_location

.A8
.I16

uncover_all_bonuses_bonus:
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::bonus_count) ; orig=0x0D03
		INC
		CMP	a:.LOWORD(number_of_visible_bonuses) ; orig=0x0C91
		BEQ	loc_C62C1F
		JML	f:loc_C62B71
; ---------------------------------------------------------------------------

loc_C62C1F:
		SEC
		RTL
; End of function uncover_all_bonuses_bonus

.A8
.I16

combo_of_3_bonus:
		REP	#$20
.A16
		TYA
		AND	#$80
		LSR
		LSR
		LSR
		TAY
		SEP	#$20
.A8
		LDA	a:.LOWORD(combo_counter),Y
		CMP	#3
		BCC	loc_C62C38
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62C38:
		LDA	a:.LOWORD(combo_counter+1),Y
		CMP	#3
		BCC	loc_C62C43
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62C43:
		LDA	a:.LOWORD(combo_counter+2),Y
		CMP	#3
		BCC	loc_C62C4E
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62C4E:
		LDA	a:.LOWORD(combo_counter+3),Y
		CMP	#3
		BCC	loc_C62C59
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62C59:
		LDA	a:.LOWORD(combo_counter+4),Y
		CMP	#3
		BCC	loc_C62C64
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62C64:
		LDA	a:.LOWORD(combo_counter+5),Y
		CMP	#3
		BCC	loc_C62C6F
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62C6F:
		LDA	a:.LOWORD(combo_counter+6),Y
		CMP	#3
		BCC	loc_C62C7A
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62C7A:
		LDA	a:.LOWORD(combo_counter+7),Y
		CMP	#3
		BCC	loc_C62C85
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62C85:
		LDA	a:.LOWORD(combo_counter+8),Y
		CMP	#3
		BCC	loc_C62C90
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62C90:
		LDA	a:.LOWORD(combo_counter+9),Y
		CMP	#3
		BCC	loc_C62C9B
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62C9B:
		LDA	a:.LOWORD(combo_counter+$A),Y
		CMP	#3
		BCC	loc_C62CA6
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62CA6:
		LDA	a:.LOWORD(combo_counter+$B),Y
		CMP	#3
		BCC	loc_C62CB1
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62CB1:
		LDA	a:.LOWORD(combo_counter+$C),Y
		CMP	#3
		BCC	loc_C62CBC
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62CBC:
		LDA	a:.LOWORD(combo_counter+$D),Y
		CMP	#3
		BCC	loc_C62CC7
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62CC7:
		LDA	a:.LOWORD(combo_counter+$E),Y
		CMP	#3
		BCC	loc_C62CD2
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62CD2:
		LDA	a:.LOWORD(combo_counter+$F),Y
		CMP	#3
		BCC	loc_C62CDD
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62CDD:
		CLC
		RTL
; End of function combo_of_3_bonus

.A8
.I16

spawn_enemy_bonus:
		SEP	#$20
		LDA	z:$24,X
		BEQ	loc_C62CE9
		JML	f:loc_C62CF0
; ---------------------------------------------------------------------------

loc_C62CE9:
		INC	z:$24,X
		LDA	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		STA	z:$20,X

loc_C62CF0:
		LDA	z:$20,X
		CMP	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		BCS	loc_C62CFB
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62CFB:
		LDA	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		STA	z:$20,X
		CLC
		RTL
; End of function spawn_enemy_bonus

.A8
.I16

punch_5_bonus:
		REP	#$20
.A16
		LDA	a:.LOWORD(0),Y
		CMP	#.LOWORD(punch)
		BEQ	loc_C62D10
		JML	f:loc_C62B71
; ---------------------------------------------------------------------------

loc_C62D10:
		INC	z:$20,X
		LDA	z:$20,X
		CMP	#5
		BEQ	loc_C62D1D
		JML	f:loc_C62B71
; ---------------------------------------------------------------------------

loc_C62D1D:
		SEC
		RTL
; End of function punch_5_bonus

.A16
.I16

bomb_hit_bonus:
		REP	#$20
		LDA	a:.LOWORD(0),Y
		CMP	#.LOWORD(_play_hit_by_bomb_animation)
		BNE	loc_C62D2D
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62D2D:
		CLC
		RTL
; End of function bomb_hit_bonus

.A16
.I16

place_6_bombs_bonus:
		SEP	#$20
.A8
		LDA	a:.LOWORD(player::current_bomb_count),Y
		CMP	#6
		BNE	loc_C62D3C
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62D3C:
		CLC
		RTL
; End of function place_6_bombs_bonus

.A8
.I16

score_20_bonus:
		SEP	#$20
		LDA	a:.LOWORD(player::socre_digits_12),Y
		CMP	#$20
		BNE	loc_C62D4B
		JML	f:loc_C62B6F
; ---------------------------------------------------------------------------

loc_C62D4B:
		CLC
		RTL
; End of function score_20_bonus

; ---------------------------------------------------------------------------
hidden_bonus_verifiers_array:.ADDR is_dying_bonus    ; 0
		.ADDR dont_move_bonus	; 1
		.ADDR dont_move_on_exit_bonus;	2
		.ADDR press_start_bonus	; 3
		.ADDR bombs_in_corners_bonus; 4
		.ADDR uncover_all_bonuses_bonus; 5
		.ADDR combo_of_3_bonus	; 6
		.ADDR spawn_enemy_bonus	; 7
		.ADDR punch_5_bonus	; 8
		.ADDR bomb_hit_bonus	; 9
		.ADDR place_6_bombs_bonus; $A
		.ADDR score_20_bonus	; $B
animation_frame_C62D65:.BYTE 6
		frame_oam_tile 0, $F0,	$701, $40
		frame_oam_tile 0, $F8,	$1701, $40
		frame_oam_tile 0, 0, $3701, $40
		frame_oam_tile $F8, $F0, $701,	0
		frame_oam_tile $F8, $F8, $1701, 0
		frame_oam_tile $F8, 0,	$3701, 0
animation_frame_C62D84:.BYTE 8
		frame_oam_tile 0, $E8,	$701, $40
		frame_oam_tile 0, $F0,	$1701, $40
		frame_oam_tile 0, $F8,	$2701, $40
		frame_oam_tile 0, 0, $3701, $40
		frame_oam_tile $F8, $E8, $701,	0
		frame_oam_tile $F8, $F0, $1701, 0
		frame_oam_tile $F8, $F8, $2701, 0
		frame_oam_tile $F8, 0,	$3701, 0
animation_frame_C62DAD:.BYTE $A
		frame_oam_tile 0, $E0,	$701, $40
		frame_oam_tile $F8, $E0, $701,	0
		frame_oam_tile 0, $E8,	$1701, $40
		frame_oam_tile $F8, $E8, $1701, 0
		frame_oam_tile 0, $F0,	$1101, $40
		frame_oam_tile $F8, $F0, $1101, 0
		frame_oam_tile 0, $F8,	$2701, $40
		frame_oam_tile 0, 0, $3701, $40
		frame_oam_tile $F8, $F8, $2701, 0
		frame_oam_tile $F8, 0,	$3701, 0
animation_frame_C62DE0:.BYTE $A
		frame_oam_tile 8, $E8,	1, $40
		frame_oam_tile 0, $E8,	$101, $40
		frame_oam_tile 0, $F0,	$1101, $40
		frame_oam_tile 0, $F8,	$2101, $40
		frame_oam_tile 0, 0, $3101, $40
		frame_oam_tile $F0, $E8, 1, 0
		frame_oam_tile $F8, $E8, $101,	0
		frame_oam_tile $F8, $F0, $1101, 0
		frame_oam_tile $F8, $F8, $2101, 0
		frame_oam_tile $F8, 0,	$3101, 0
animation_frame_C62E13:.BYTE 8
		frame_oam_tile 8, $E8,	$1001, $40
		frame_oam_tile 0, $E8,	$2001, $40
		frame_oam_tile 0, $F0,	$3001, $40
		frame_oam_tile 0, $F8,	$3101, $40
		frame_oam_tile $F0, $E8, $1001, 0
		frame_oam_tile $F8, $E8, $2001, 0
		frame_oam_tile $F8, $F0, $3001, 0
		frame_oam_tile $F8, $F8, $3101, 0
animation_frame_C62E3C:.BYTE $A
		frame_oam_tile 8, $E8,	$1301, $40
		frame_oam_tile 8, $E0,	$301, $40
		frame_oam_tile 0, $E0,	$401, $40
		frame_oam_tile 0, $E8,	$1401, $40
		frame_oam_tile 0, $F0,	$2401, $40
		frame_oam_tile $F0, $E8, $1301, 0
		frame_oam_tile $F0, $E0, $301,	0
		frame_oam_tile $F8, $E0, $401,	0
		frame_oam_tile $F8, $E8, $1401, 0
		frame_oam_tile $F8, $F0, $2401, 0
animation_frame_C62E6F:.BYTE 6
		frame_oam_tile 0, $F0,	$2301, $40
		frame_oam_tile 0, $E0,	$2201, $40
		frame_oam_tile 0, $E8,	$3201, $40
		frame_oam_tile $F8, $F0, $2301, 0
		frame_oam_tile $F8, $E0, $2201, 0
		frame_oam_tile $F8, $E8, $3201, 0
animation_frame_C62E8E:.BYTE 2
		frame_oam_tile 0, $EE,	$2601, 0
		frame_oam_tile $F8, $DE, $501,	$20
byte_C62E99:	.BYTE 8
		animation_frame animation_frame_C62D65, 2
		animation_frame animation_frame_C62D84, 2
		animation_frame animation_frame_C62DAD, 2
		animation_frame animation_frame_C62DE0, 2
		animation_frame animation_frame_C62E13, 2
		animation_frame animation_frame_C62E3C, 2
		animation_frame animation_frame_C62E6F, 2
		animation_frame animation_frame_C62E8E, 2
animation_frame_C62EBA:.BYTE 4
		frame_oam_tile $F0, 0,	1, $60
		frame_oam_tile $F0, $F0, 1, $E0
		frame_oam_tile 0, $F0,	1, $A0
		frame_oam_tile 0, 0, 1, $20
animation_frame_C62ECF:.BYTE 4
		frame_oam_tile 0, 0, $201, $E0
		frame_oam_tile $F0, 0,	$201, $A0
		frame_oam_tile 0, $F0,	$201, $60
		frame_oam_tile $F0, $F0, $201,	$20
animation_frame_C62EE4:.BYTE 4
		frame_oam_tile $F0, 0,	$2001, $E0
		frame_oam_tile $F0, $F0, $2001, $60
		frame_oam_tile 0, 0, $2001, $A0
		frame_oam_tile 0, $F0,	$2001, $20
animation_frame_C62EF9:.BYTE 4
		frame_oam_tile 0, 0, $2201, $E0
		frame_oam_tile $F0, 0,	$2201, $A0
		frame_oam_tile 0, $F0,	$2201, $60
		frame_oam_tile $F0, $F0, $2201, $20
animation_frame_C62F0E:.BYTE 4
		frame_oam_tile $F0, 0,	$401, $A0
		frame_oam_tile 0, 0, $401, $E0
		frame_oam_tile 0, $F0,	$401, $60
		frame_oam_tile $F0, $F0, $401,	$20
byte_C62F23:.BYTE 5
		animation_frame animation_frame_C62EBA, 5
		animation_frame animation_frame_C62ECF, 4
		animation_frame animation_frame_C62EE4, 2
		animation_frame animation_frame_C62EF9, 1
		animation_frame animation_frame_C62F0E, 1
animation_frame_C62F38:.BYTE 8
		frame_oam_tile 0, $F8,	$2000, $E0
		frame_oam_tile 0, 8, 0, $E0
		frame_oam_tile $F0, 8,	0, $A0
		frame_oam_tile $F0, $F8, $2000, $A0
		frame_oam_tile 0, $E8,	0, $60
		frame_oam_tile 0, $F8,	$2000, $60
		frame_oam_tile $F0, $E8, 0, $20
		frame_oam_tile $F0, $F8, $2000, $20
animation_frame_C62F61:.BYTE $1C
		frame_oam_tile $20, 0,	$2400, $60
		frame_oam_tile $10, 0,	$2600, $E0
		frame_oam_tile 0, 0, $2001, $E0
		frame_oam_tile $D0, 0,	$2400, $20
		frame_oam_tile $E0, 0,	$2600, $A0
		frame_oam_tile $F0, 0,	$2001, $A0
		frame_oam_tile $10, $10, 1, $E0
		frame_oam_tile 0, $10,	$201, $E0
		frame_oam_tile $E0, $10, 1, $A0
		frame_oam_tile $F0, $10, $201,	$A0
		frame_oam_tile $10, $20, $400,	$E0
		frame_oam_tile 0, $20,	$600, $E0
		frame_oam_tile $E0, $20, $400,	$A0
		frame_oam_tile $F0, $20, $600,	$A0
		frame_oam_tile $20, $F0, $2400, $60
		frame_oam_tile $10, $D0, $400,	$60
		frame_oam_tile $10, $E0, 1, $60
		frame_oam_tile $10, $F0, $2600, $60
		frame_oam_tile 0, $D0,	$600, $60
		frame_oam_tile 0, $E0,	$201, $60
		frame_oam_tile 0, $F0,	$2001, $60
		frame_oam_tile $E0, $D0, $400,	$20
		frame_oam_tile $F0, $D0, $600,	$20
		frame_oam_tile $E0, $E0, 1, $20
		frame_oam_tile $F0, $E0, $201,	$20
		frame_oam_tile $D0, $F0, $2400, $20
		frame_oam_tile $E0, $F0, $2600, $20
		frame_oam_tile $F0, $F0, $2001, $20
animation_frame_C62FEE:.BYTE $28
stru_C62FEF:	frame_oam_tile $10, 0,	$2002, $E0
		frame_oam_tile $10, $F0, $2002, $60
		frame_oam_tile $E0, 0,	$2002, $A0
		frame_oam_tile $E0, $F0, $2002, $20
		frame_oam_tile $20, 0,	$602, $E0
		frame_oam_tile $D0, 0,	$602, $A0
		frame_oam_tile $20, $10, 2, $E0
		frame_oam_tile $10, $10, $202,	$E0
		frame_oam_tile 0, $10,	$402, $E0
		frame_oam_tile $F0, $10, $402,	$A0
		frame_oam_tile $E0, $10, $202,	$A0
		frame_oam_tile $D0, $10, 2, $A0
		frame_oam_tile $20, $20, $2201, $E0
		frame_oam_tile $10, $20, $2401, $E0
		frame_oam_tile 0, $20,	$2601, $E0
		frame_oam_tile $F0, $20, $2601, $A0
		frame_oam_tile $E0, $20, $2401, $A0
		frame_oam_tile $D0, $20, $2201, $A0
		frame_oam_tile $10, $30, $401,	$E0
		frame_oam_tile 0, $30,	$601, $E0
		frame_oam_tile $F0, $30, $601,	$A0
		frame_oam_tile $E0, $30, $401,	$A0
		frame_oam_tile $20, $D0, $2201, $60
		frame_oam_tile $20, $E0, 2, $60
		frame_oam_tile $20, $F0, $602,	$60
		frame_oam_tile $10, $C0, $401,	$6E
		frame_oam_tile $10, $D0, $2401, $60
		frame_oam_tile $10, $E0, $202,	$60
		frame_oam_tile 0, $C0,	$601, $60
		frame_oam_tile 0, $D0,	$2601, $60
		frame_oam_tile 0, $E0,	$402, $60
		frame_oam_tile $F0, $C0, $601,	$20
		frame_oam_tile $E0, $C0, $401,	$20
		frame_oam_tile $F0, $D0, $2601, $20
		frame_oam_tile $E0, $D0, $2401, $20
		frame_oam_tile $D0, $D0, $2201, $20
		frame_oam_tile $F0, $E0, $402,	$20
		frame_oam_tile $E0, $E0, $202,	$20
		frame_oam_tile $D0, $E0, 2, $20
		frame_oam_tile $D0, $F0, $602,	$20
animation_frame_C630B7:.BYTE $30
stru_C630B8:	frame_oam_tile 0, $F8,	$2000, $E0
		frame_oam_tile 0, 8, 0, $E0
		frame_oam_tile $F0, 8,	0, $A0
		frame_oam_tile $F0, $F8, $2000, $A0
		frame_oam_tile 0, $E8,	0, $60
		frame_oam_tile 0, $F8,	$2000, $60
		frame_oam_tile $F0, $E8, 0, $20
		frame_oam_tile $F0, $F8, $2000, $20
		frame_oam_tile $10, 0,	$2002, $E0
		frame_oam_tile $10, $F0, $2002, $60
		frame_oam_tile $E0, 0,	$2002, $A0
		frame_oam_tile $E0, $F0, $2002, $20
		frame_oam_tile $20, 0,	$602, $E0
		frame_oam_tile $D0, 0,	$602, $A0
		frame_oam_tile $20, $10, 2, $E0
		frame_oam_tile $10, $10, $202,	$E0
		frame_oam_tile 0, $10,	$402, $E0
		frame_oam_tile $F0, $10, $402,	$A0
		frame_oam_tile $E0, $10, $202,	$A0
		frame_oam_tile $D0, $10, 2, $A0
		frame_oam_tile $20, $20, $2201, $E0
		frame_oam_tile $10, $20, $2401, $E0
		frame_oam_tile 0, $20,	$2601, $E0
		frame_oam_tile $F0, $20, $2601, $A0
		frame_oam_tile $E0, $20, $2401, $A0
		frame_oam_tile $D0, $20, $2201, $A0
		frame_oam_tile $10, $30, $401,	$E0
		frame_oam_tile 0, $30,	$601, $E0
		frame_oam_tile $F0, $30, $601,	$A0
		frame_oam_tile $E0, $30, $401,	$A0
		frame_oam_tile $20, $D0, $2201, $60
		frame_oam_tile $20, $E0, 2, $60
		frame_oam_tile $20, $F0, $602,	$60
		frame_oam_tile $10, $C0, $401,	$60
		frame_oam_tile $10, $D0, $2401, $60
		frame_oam_tile $10, $E0, $202,	$60
		frame_oam_tile 0, $C0,	$601, $60
		frame_oam_tile 0, $D0,	$2601, $60
		frame_oam_tile 0, $E0,	$402, $60
		frame_oam_tile $F0, $C0, $601,	$20
		frame_oam_tile $E0, $C0, $401,	$20
		frame_oam_tile $F0, $D0, $2601, $20
		frame_oam_tile $E0, $D0, $2401, $20
		frame_oam_tile $D0, $D0, $2201, $20
		frame_oam_tile $F0, $E0, $402,	$20
		frame_oam_tile $E0, $E0, $202,	$20
		frame_oam_tile $D0, $E0, 2, $20
		frame_oam_tile $D0, $F0, $602,	$20
byte_C631A8:.BYTE 6
		animation_frame animation_frame_C62F38, 3
		animation_frame animation_frame_C62F61, 3
		animation_frame animation_frame_C62FEE, 3
		animation_frame animation_frame_C630B7, 3
		animation_frame animation_frame_C62F61, 3
		animation_frame animation_frame_C62FEE, 3
.A8
.I16

sub_C631C1:
		REP	#$20
.A16
		LDA	z:$11,X
		AND	#$F0
		LSR
		LSR
		LSR
		LSR
		STA	z:$40
		LDA	z:$14,X
		AND	#$F0
		ADC	z:$40
		TAY
; End of function sub_C631C1

.A8
.I16
nullsub_6:
		RTL
.A8
.I16

sub_C631D7:
		SEP	#$20
		LDA	#.LOBYTE(sub_C6326B)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C6326B)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C6326B)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCC	loc_C631F3
		JML	f:nullsub_6
; ---------------------------------------------------------------------------

loc_C631F3:
		REP	#$20
.A16
		LDA	z:$11,X
		STA	a:.LOWORD($11),Y
		LDA	z:$14,X
		STA	a:.LOWORD($14),Y

loc_C631FF:
		LDA	[$50]
		STA	a:.LOWORD($16),Y
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD($19),Y
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD($20),Y
		INC	z:$50
		INC	z:$50
		LDA	#0
		STA	a:.LOWORD($24),Y
		LDA	#0
		STA	a:.LOWORD($26),Y
		LDA	#0
		STA	a:.LOWORD($28),Y
		LDA	[$50]
		PHA
		AND	#$7FFF
		STA	a:.LOWORD($22),Y
		LDA	#.LOWORD(byte_C62F23)
		STA	z:$50
		LDA	#$E30
		STA	a:.LOWORD($E),Y
		LDA	#6
		STA	a:.LOWORD($1E),Y
		PLA
		BIT	#$8000
		BEQ	loc_C6325D
		LDA	#.LOWORD(byte_C631A8)
		STA	z:$50
		LDA	#$B30
		STA	a:.LOWORD($E),Y
		LDA	#6
		STA	a:.LOWORD($1E),Y

loc_C6325D:
		PHX
		TYX
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		PLX
		RTL
; End of function sub_C631D7

.A8
.I16

sub_C6326B:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C63278
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C63278:
		BIT	#$41
		BEQ	loc_C63280
		JML	f:locret_C632C7
; ---------------------------------------------------------------------------

loc_C63280:
		REP	#$20
.A16
		LDA	z:$26,X
		INC	z:$26,X
		BIT	#$1F
		BNE	loc_C63292
		LDY	#$1B
		JSL	f:play_sound

loc_C63292:
		REP	#$20
		LDA	z:$28,X
		INC	z:$28,X
		BIT	#$F
		BNE	loc_C632A4
		LDY	#$15
		JSL	f:play_sound

loc_C632A4:
		REP	#$20
		DEC	z:$20,X
		BNE	loc_C632AE
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C632AE:
		DEC	z:$24,X
		BPL	locret_C632C7
		LDA	z:$22,X
		STA	z:$24,X
		JSL	f:sub_C632C8
		PHX
		INX
		INX
		INX
		JSL	f:sub_C632C8
		PLX
		JSL	f:sub_C632DF
.A8

locret_C632C7:
		RTL
; End of function sub_C6326B

.A16
.I16

sub_C632C8:
		JSL	f:random2
		REP	#$20
		AND	z:$16,X
		BIT	#1
		BNE	loc_C632D9
		EOR	#$FFFF
		INC

loc_C632D9:
		CLC
		ADC	z:$11,X
		STA	z:$30,X
		RTL
; End of function sub_C632C8

.A16
.I16

sub_C632DF:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C63321)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C63321)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C63321)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C632FD
		JML	f:nullsub_6
; ---------------------------------------------------------------------------

loc_C632FD:
		LDA	z:$30,X

loc_C632FF:
		STA	a:.LOWORD($11),Y
		LDA	z:$33,X
		STA	a:.LOWORD($14),Y
		LDA	z:8,X
		STA	a:.LOWORD(8),Y
		LDA	z:$A,X
		STA	a:.LOWORD($A),Y
		LDA	z:$C,X
		STA	a:.LOWORD($C),Y
		LDA	z:$E,X
		STA	a:.LOWORD($E),Y
		LDA	z:$1E,X
		STA	a:.LOWORD($1E),Y
		RTL
; End of function sub_C632DF

.A16
.I16

sub_C63321:
		JSL	f:load_animation_frame
		BCC	locret_C6332B
		JML	f:delete_object
; ---------------------------------------------------------------------------

locret_C6332B:
		RTL
; End of function sub_C63321

.A8
.I16

create_enemy_explosion:
		SEP	#$20
		LDA	#.LOBYTE(enemy_explosion)
		STA	z:$DB
		LDA	#.HIBYTE(enemy_explosion)
		STA	z:$DC
		LDA	#.BANKBYTE(enemy_explosion)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCC	loc_C63348
		JML	f:nullsub_6
; ---------------------------------------------------------------------------

loc_C63348:
		REP	#$20
.A16
		LDA	z:enemy::x_position,X
		STA	a:.LOWORD(enemy::x_position),Y
		LDA	z:enemy::y_position,X
		STA	a:.LOWORD(enemy::y_position),Y
		LDA	z:$46
		STA	a:.LOWORD(enemy::animation),Y
		SEP	#$20
.A8
		LDA	z:enemy::flags,X
		STA	a:.LOWORD(enemy::flags),Y
		RTL
; End of function create_enemy_explosion

.A8
.I16

enemy_explosion:
		LDY	#$16
		JSL	f:play_sound
		SEP	#$20
		LDA	#6
		STA	z:enemy::effective_palette,X
		LDA	#$E
		STA	z:enemy::palette+1,X
		LDA	#$30
		STA	z:enemy::palette,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C62E99)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(_enemy_explosion)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_enemy_explosion)
		STA	z:object::handler+2,X

_enemy_explosion:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C633A1
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C633A1:
		BIT	#$41
		BEQ	loc_C633A9
		JML	f:locret_C633BF
; ---------------------------------------------------------------------------

loc_C633A9:
		JSL	f:advance_animation
		BCC	locret_C633BF
		SEP	#$20
		LDA	z:enemy::flags,X
		BIT	#4
		BNE	loc_C633BB
		JSL	f:create_score_popup

loc_C633BB:
		JSL	f:delete_object

locret_C633BF:
		RTL
; End of function enemy_explosion

.A8
.I16

kill_enemy:
		SEP	#$20
		LDA	#$20
		STA	z:$20,X
		LDA	#0
		STA	z:enemy::hits_left_for_direction_switch,X
		LDA	a:.LOWORD(collision_map+1),Y
		STA	z:enemy::flags,X
		REP	#$20
.A16
		LDA	#.LOWORD(_kill_enemy)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_kill_enemy)
		STA	z:2,X

_kill_enemy:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C633E9
		JML	f:locret_C63455
; ---------------------------------------------------------------------------

loc_C633E9:
		JSL	f:advance_animation_2
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C633FA
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C633FA:
		BIT	#$41
		BEQ	loc_C63402

loc_C633FE:
		JML	f:loc_C63406
; ---------------------------------------------------------------------------

loc_C63402:
		DEC	z:enemy::direction,X
		BEQ	loc_C63417

loc_C63406:
		LDA	#$E
		STA	z:enemy::effective_palette,X
		LDA	z:enemy::hits_left_for_direction_switch,X
		EOR	#1
		STA	z:enemy::hits_left_for_direction_switch,X
		BNE	locret_C63455
		LDA	z:enemy::real_palette,X
		STA	z:enemy::effective_palette,X
		RTL
; ---------------------------------------------------------------------------

loc_C63417:
		JSL	f:calculate_score_for_enemy
		JSL	f:create_enemy_explosion
		REP	#$20
.A16
		JSL	f:get_object_square_index
		TAY
		LDA	a:.LOWORD(collision_map),Y
		AND	#BONUS_MASK|BOMB|SOFT_BLOCK|HARD_BLOCK|$100
		BNE	loc_C63439
		LDA	z:enemy::carried_bonus,X
		AND	#$1F
		BEQ	loc_C63439
		JSL	f:create_bonus_object

loc_C63439:
		REP	#$20
		LDA	z:enemy::position_related,X
		STA	z:$50
		LDA	z:$3B,X
		STA	z:$51
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		ORA	#$10
		STA	[$50]
		DEC	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		JSL	f:delete_object
.A8

locret_C63455:
		RTL
; End of function kill_enemy

.A8
.I16

calculate_score_for_enemy:
		REP	#$20
.A16
		LDA	#0
		STA	z:$40
		LDA	z:enemy::flags,X
		BIT	#4
		BNE	locret_C63494
		BIT	#2
		BEQ	loc_C6346E
		LDA	#$10
		STA	z:$40

loc_C6346E:
		LDA	z:enemy::flags,X
		AND	#$F0
		LSR
		LSR
		LSR
		LSR
		ORA	z:$40
		TAY
		SEP	#$20
.A8
		LDA	a:.LOWORD(combo_counter),Y
		CMP	#4
		BCC	loc_C63485
		LDA	#4

loc_C63485:
		STA	z:$46
		INC
		STA	a:.LOWORD(combo_counter),Y
		LDA	z:enemy::score_index,X
		CLC
		ADC	z:$46
		STA	z:$46
		STZ	z:$47

locret_C63494:
		RTL
; End of function calculate_score_for_enemy

.A16
.I16

test_collision_mask_for_enemy_next_square:
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C61562)
		STA	z:$52
		LDA	#.BANKBYTE(sub_C61562)
		STA	z:$55
		REP	#$20
.A16
		LDA	z:enemy::direction,X
		AND	#$FF
		ASL
		CLC
		ADC	#.LOWORD(off_C634B5)
		STA	z:$50
		LDA	[$50]
		STA	z:$53
		JMP	[$53]
; End of function test_collision_mask_for_enemy_next_square

; ---------------------------------------------------------------------------
		RTI
; ---------------------------------------------------------------------------
off_C634B5:	.ADDR sub_C61562, sub_C615CE, sub_C61586, sub_C615AA; 0
.A16
.I16

check_for_enemy_with_enemy_collision:
		LDY	#.LOWORD(enemy_objects)
		STX	z:$50

loc_C634C2:
		SEP	#$20
.A8
		LDA	a:.LOWORD(3),Y
		BIT	#1
		BEQ	loc_C634EB
		LDA	a:enemy::x_position,Y
		SEC
		SBC	z:enemy::x_position,X
		BCS	loc_C634D6
		EOR	#$FF
		INC

loc_C634D6:
		CMP	#$10
		BCS	loc_C634EB
		LDA	a:enemy::y_position,Y
		SEC
		SBC	z:enemy::y_position,X
		BCS	loc_C634E5
		EOR	#$FF
		INC

loc_C634E5:
		CMP	#$10
		BCS	loc_C634EB
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C634EB:
		REP	#$20
.A16
		LDA	a:enemy::next,Y
		TAY
		CMP	z:$50
		BEQ	loc_C634EB
		CMP	#$FFFF
		BNE	loc_C634C2
		CLC
		RTL
; End of function check_for_enemy_with_enemy_collision

.A16
.I16

sub_C634FC:
		REP	#$20

loc_C634FE:
		LDY	#$D40

loc_C63501:
		SEP	#$20
.A8
		LDA	a:.LOWORD(4),Y
		BIT	#1
		BEQ	loc_C6352F
		LDA	a:.LOWORD($11),Y
		SEC
		SBC	z:$11,X
		BCS	loc_C63515
		EOR	#$FF
		INC

loc_C63515:
		CMP	z:$41
		BCS	loc_C6352F
		LDA	a:.LOWORD($14),Y
		SEC
		SBC	z:$14,X
		BCS	loc_C63524
		EOR	#$FF
		INC

loc_C63524:
		CMP	z:$40
		BCS	loc_C6352F
		SEP	#$20
		LDA	#1
		STA	a:.LOWORD($2F),Y

loc_C6352F:
		REP	#$20
.A16
		TYA
		CLC
		ADC	#$40
		TAY
		CMP	#$DC0
		BNE	loc_C63501
		RTL
; End of function sub_C634FC

.A16
.I16

sub_C6353D:
		REP	#$20
		LDY	#$D40

loc_C63542:
		LDA	a:.LOWORD(4),Y
		BIT	#$FF
		BEQ	loc_C63593
		LDA	z:$42
		AND	#$FF
		STA	z:$46
		LDA	a:.LOWORD($11),Y
		SEC
		SBC	z:$11,X
		BCS	loc_C63566
		EOR	#$FFFF
		INC
		PHA
		LDA	z:$43
		AND	#$FF
		STA	z:$46
		PLA

loc_C63566:
		CMP	z:$46
		BCS	loc_C63593
		LDA	z:$44
		AND	#$FF
		STA	z:$46
		LDA	a:.LOWORD($14),Y
		SEC
		SBC	z:$14,X
		BCS	loc_C63586
		EOR	#$FFFF
		INC
		PHA
		LDA	z:$45
		AND	#$FF
		STA	z:$46
		PLA

loc_C63586:
		CMP	z:$46
		BCS	loc_C63593
		LDA	a:.LOWORD($2F),Y
		ORA	#1
		STA	a:.LOWORD($2F),Y

loc_C63593:
		TYA
		CLC
		ADC	#$40
		TAY
		CMP	#$DC0
		BNE	loc_C63542
		RTL
; End of function sub_C6353D

.A16
.I16

sub_C6359F:
		SEP	#$20
.A8
		LDA	a:.LOWORD(4),Y
		BIT	#1
		BEQ	loc_C635DE
		LDA	z:$42
		STA	z:$41
		LDA	a:.LOWORD($11),Y
		SEC
		SBC	z:$11,X
		BCS	loc_C635BD
		PHA
		LDA	z:$43
		STA	z:$41
		PLA
		EOR	#$FF
		INC

loc_C635BD:
		CMP	z:$41
		BCS	loc_C635DE
		LDA	z:$44
		STA	z:$40
		LDA	a:.LOWORD($14),Y
		SEC
		SBC	z:$14,X
		BCS	loc_C635D6
		PHA
		LDA	z:$45
		STA	z:$40
		PLA
		EOR	#$FF
		INC

loc_C635D6:
		CMP	z:$40
		BCS	loc_C635DE
		REP	#$20
.A16
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C635DE:
		REP	#$20
		CLC
		RTL
; End of function sub_C6359F

.A16
.I16

sub_C635E2:
		SEP	#$20
.A8
		LDA	z:$42
		CMP	#$50
		BNE	sub_C635FD
; End of function sub_C635E2

.A8
.I16

sub_C635EA:
		SEP	#$20
		LDA	#1
		STA	z:$44
		LDA	a:.LOWORD($11),Y
		SEC
		SBC	z:$11,X
		BCS	locret_C635FC
		LDA	#3
		STA	z:$44

locret_C635FC:
		RTL
; End of function sub_C635EA

.A8
.I16

sub_C635FD:
		SEP	#$20

loc_C635FF:
		LDA	#2
		STA	z:$44
		LDA	a:.LOWORD($14),Y
		SEC
		SBC	z:$14,X
		BCS	locret_C6360D
		STZ	z:$44

locret_C6360D:
		RTL
; End of function sub_C635FD

.A16
.I16

straight_movement:
		SEP	#$20
.A8
		LDA	#.BANKBYTE(vectors_for_speed_and_direction)
		STA	z:$55
		LDA	z:enemy::speed,X
		REP	#$20
.A16
		AND	#$FF
		ASL
		ASL
		ASL
		ASL
		STA	z:$40
		LDA	z:enemy::direction,X
		AND	#$F
		ASL
		ASL
		CLC
		ADC	#.LOWORD(vectors_for_speed_and_direction)
		ADC	z:$40
		STA	z:$53
		LDA	z:enemy::fractional_x,X
		PHA
		LDA	z:enemy::fractional_y,X
		PHA
		LDA	z:enemy::direction,X
		BIT	#1
		BNE	loc_C63643
		JSL	f:straighten_x
		BRA	loc_C63647
; ---------------------------------------------------------------------------

loc_C63643:
		JSL	f:straighten_y

loc_C63647:
		REP	#$20
		LDA	z:enemy::fractional_x,X
		CLC
		ADC	[$53]
		STA	z:enemy::fractional_x,X
		INC	z:$53
		INC	z:$53
		LDA	z:enemy::fractional_y,X
		CLC
		ADC	[$53]
		STA	z:enemy::fractional_y,X
		JSL	f:check_for_enemy_with_enemy_collision
		REP	#$20
		BCS	loc_C63667
		PLA
		PLA
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C63667:
		PLA
		STA	z:enemy::fractional_y,X
		PLA
		STA	z:enemy::fractional_x,X
		JSL	f:random2
		SEP	#$20
.A8
		AND	#3
		CMP	z:enemy::direction,X
		BNE	loc_C63681

loc_C63679:
		LDA	z:enemy::direction,X
		EOR	#2
		STA	z:enemy::direction,X
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C63681:
		JSL	f:test_collision_mask_for_enemy_next_square
		SEP	#$20
		BNE	loc_C63679
		SEC
		RTL
; End of function straight_movement

; ---------------------------------------------------------------------------
		LDA	z:$20,X
		INC
		AND	#3
		STA	z:$20,X
		SEC
		RTL
; ---------------------------------------------------------------------------
		JMP	a:.LOWORD(loc_C63818)
.A16
.I16

straighten_x:
		SEP	#$20
.A8
		LDA	z:enemy::x_position,X
		AND	#$F
		CMP	#8
		BEQ	locret_C636A8
		BCC	loc_C636A6
		DEC	z:enemy::x_position,X
		RTL
; ---------------------------------------------------------------------------

loc_C636A6:
		INC	z:enemy::x_position,X

locret_C636A8:
		RTL
; End of function straighten_x

.A16
.I16

straighten_y:
		SEP	#$20
.A8
		LDA	z:enemy::y_position,X
		AND	#$F
		CMP	#8
		BEQ	locret_C636BA
		BCC	loc_C636B8
		DEC	z:enemy::y_position,X
		RTL
; ---------------------------------------------------------------------------

loc_C636B8:
		INC	z:enemy::y_position,X

locret_C636BA:
		RTL
; End of function straighten_y

; ---------------------------------------------------------------------------
vectors_for_speed_and_direction:.WORD 0, $FF80,	$80, 0,	0, $80,	$FF80, 0; 0
		.WORD 0, $FF00,	$100, 0, 0, $100, $FF00, 0; 8
		.WORD 0, $FF00,	$100, 0, 0, $100, $FF00, 0; $10
		.WORD 0, $FF20,	$E0, 0,	0, $E0,	$FF20, 0; $18
		.WORD 0, $FE80,	$180, 0, 0, $180, $FE80, 0; $20
.A16
.I16

sub_C6370B:
		REP	#$20
		LDA	z:$42
		CLC
		ADC	z:$11,X
		AND	#$1F0
		LSR
		LSR
		LSR
		STA	z:$40
		LDA	z:$44
		CLC
		ADC	z:$14,X
		AND	#$F0
		ASL
		ASL
		ORA	z:$40
		TAY
		LSR	z:$42
		LSR	z:$42
		LSR	z:$42
		LSR	z:$42
		LSR	z:$44
		LSR	z:$44
		LSR	z:$44
		LSR	z:$44
		SEP	#$20
.A8
		LDA	z:$43
		CLC
		ADC	z:$42
		INC
		STA	z:$42
		LDA	z:$45
		CLC
		ADC	z:$44
		INC
		STA	z:$45

loc_C63749:
		STY	z:$46
		LDA	z:$42
		STA	z:$43

loc_C6374F:
		CPY	#$2DE
		BCS	loc_C6375B
		LDA	a:.LOWORD($917),Y
		BIT	#1
		BNE	loc_C63772

loc_C6375B:
		DEY
		DEY
		DEC	z:$43
		BNE	loc_C6374F
		REP	#$20
.A16
		LDA	z:$46
		SEC
		SBC	#$40
		TAY
		SEP	#$20
.A8
		DEC	z:$45
		BNE	loc_C63749
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C63772:
		SEC
		RTL
; End of function sub_C6370B

.A16
.I16

wanderer_movement:
		REP	#$20
		LDA	#BOMB|SOFT_BLOCK|HARD_BLOCK
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		BEQ	loc_C63785
		JML	f:enemy_hit_deadend
; ---------------------------------------------------------------------------

loc_C63785:
		JSL	f:straight_movement
		BCC	loc_C6378F
		JML	f:locret_C63ADE
; ---------------------------------------------------------------------------

loc_C6378F:
		SEP	#$20
.A8
		LDA	z:$18,X
		STA	z:$52
		LDA	z:enemy::direction,X
		CMP	z:enemy::animation_direction,X
		BEQ	locret_C637AF
		STA	z:enemy::animation_direction,X
		REP	#$20
.A16
		AND	#$FF
		ASL
		ADC	z:enemy::animation,X
		STA	z:$50
		LDA	[$50]
		STA	z:$50
		JSL	f:start_animation

locret_C637AF:
		RTL
; End of function wanderer_movement

.A8
.I16

random_wanderer_movement:
		SEP	#$20
		DEC	z:$21,X
		BNE	loc_C637CF
		INC	z:$21,X
		JSL	f:is_object_aligned
		BCS	loc_C637CF
		JSL	f:random2
		SEP	#$20
		AND	#$3F
		CLC
		ADC	#$10
		STA	z:$21,X
		JSL	f:sub_C6382F

loc_C637CF:
		REP	#$20
.A16
		LDA	#BOMB|HARD_BLOCK
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		BNE	sub_C6382F
		JSL	f:straight_movement
		BCC	loc_C637E6
		JML	f:locret_C63ADE
; ---------------------------------------------------------------------------

loc_C637E6:
		SEP	#$20
.A8
		LDA	z:$18,X
		STA	z:$52
		LDA	z:$20,X
		CMP	z:$22,X
		BEQ	locret_C63806
		STA	z:$22,X
		REP	#$20
.A16
		AND	#$FF
		ASL
		ADC	z:$16,X
		STA	z:$50
		LDA	[$50]
		STA	z:$50
		JSL	f:start_animation

locret_C63806:
		RTL
; End of function random_wanderer_movement

.A16
.I16

enemy_hit_deadend:
		SEP	#$20
.A8
		DEC	z:enemy::hits_left_for_direction_switch,X
		BNE	loc_C63811
		JML	f:loc_C63818
; ---------------------------------------------------------------------------

loc_C63811:
		LDA	z:enemy::direction,X
		EOR	#2
		STA	z:enemy::direction,X
		RTL
; ---------------------------------------------------------------------------

loc_C63818:
		SEP	#$20
		LDA	z:enemy::direction,X
		INC
		AND	#3
		STA	z:enemy::direction,X
		JSL	f:random2
		SEP	#$20
		AND	#3
		INC
		INC
		INC
		STA	z:enemy::hits_left_for_direction_switch,X
		RTL
; End of function enemy_hit_deadend

.A8
.I16

sub_C6382F:
		JSL	f:random2
		SEP	#$20
		AND	#3
		STA	z:$20,X
		RTL
; End of function sub_C6382F

.A16
.I16

follower_movement:
		REP	#$20
		JSL	f:is_object_aligned
		BCC	loc_C6388E
		REP	#$20
		LDA	z:enemy::collision_mask,X
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		BEQ	loc_C63852
		JML	f:loc_C6388E
; ---------------------------------------------------------------------------
.A8

loc_C63852:
		JSL	f:straight_movement
		BCC	loc_C6385C
		JML	f:locret_C63ADE
; ---------------------------------------------------------------------------

loc_C6385C:
		SEP	#$20
		LDA	z:$18,X
		STA	z:$52
		LDA	z:enemy::direction,X
		CMP	z:enemy::animation_direction,X
		BEQ	locret_C6387C
		STA	z:enemy::animation_direction,X
		REP	#$20
.A16
		AND	#$FF
		ASL
		ADC	z:enemy::animation,X
		STA	z:$50
		LDA	[$50]
		STA	z:$50
		JSL	f:start_animation

locret_C6387C:
		RTL
; ---------------------------------------------------------------------------

loc_C6387D:
		SEP	#$20
.A8
		INC	z:enemy::hits_left_for_direction_switch,X
		REP	#$20
.A16
		LDA	z:enemy::collision_mask,X
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		BEQ	loc_C63852
		RTL
; ---------------------------------------------------------------------------

loc_C6388E:
		JSL	f:follower_movement_2
		SEP	#$20
.A8
		LDA	z:enemy::hits_left_for_direction_switch,X
		BEQ	loc_C6387D
		STZ	z:enemy::hits_left_for_direction_switch,X
		LDA	z:$20,X
		BIT	#1
		BNE	loc_C638A8
		JSL	f:sub_C635EA
		BEQ	loc_C638C6
		BRA	loc_C638AE
; ---------------------------------------------------------------------------

loc_C638A8:
		JSL	f:sub_C635FD
		BEQ	loc_C638C6

loc_C638AE:
		LDA	z:$20,X
		PHA
		LDA	z:$44
		STA	z:enemy::direction,X
		REP	#$20
.A16
		LDA	z:enemy::collision_mask,X
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		SEP	#$20
.A8
		BEQ	loc_C638E0
		PLA
		STA	z:enemy::direction,X

loc_C638C6:
		REP	#$20
.A16
		LDA	z:enemy::collision_mask,X
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		BNE	loc_C638D6
		JML	f:loc_C63852
; ---------------------------------------------------------------------------

loc_C638D6:
		SEP	#$20
.A8
		LDA	z:enemy::direction,X
		INC
		AND	#3
		STA	z:enemy::direction,X
		RTL
; ---------------------------------------------------------------------------

loc_C638E0:
		PLA
		JMP	a:.LOWORD(loc_C63852)
; End of function follower_movement

.A8
.I16

missle_movement:
		REP	#$20
.A16
		LDA	#BOMB|SOFT_BLOCK|HARD_BLOCK
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		BEQ	loc_C638F5
		JML	f:loc_C63920
; ---------------------------------------------------------------------------

loc_C638F5:
		JSL	f:straight_movement
		BCC	loc_C638FF
		JML	f:locret_C63ADE
; ---------------------------------------------------------------------------

loc_C638FF:
		SEP	#$20
.A8
		LDA	z:$18,X
		STA	z:$52
		LDA	z:$20,X
		CMP	z:$22,X
		BEQ	locret_C6391F
		STA	z:$22,X
		REP	#$20
.A16
		AND	#$FF
		ASL
		ADC	z:$16,X
		STA	z:$50
		LDA	[$50]
		STA	z:$50
		JSL	f:start_animation

locret_C6391F:
		RTL
; ---------------------------------------------------------------------------

loc_C63920:
		REP	#$20
		BIT	#$20
		BEQ	sub_C63983
		LDA	z:$20,X
		PHA
		AND	#$FF
		PHX
		TAX
		SEP	#$20
.A8
		LDA	f:byte_C63943,X
		PLX
		STA	z:$20,X
		JSL	f:loc_C41D24
		REP	#$20
.A16
		PLA
		STA	z:$20,X
		BRA	loc_C638F5
; ---------------------------------------------------------------------------
byte_C63943:	.BYTE 8, 1, 4, 2
; End of function missle_movement

.A8
.I16

wanderer_movement2:
		REP	#$20
.A16
		LDA	#BOMB|SOFT_BLOCK|HARD_BLOCK
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		BEQ	loc_C63958
		JML	f:sub_C63983
; ---------------------------------------------------------------------------

loc_C63958:
		JSL	f:straight_movement
		BCC	loc_C63962
		JML	f:locret_C63ADE
; ---------------------------------------------------------------------------

loc_C63962:
		SEP	#$20
.A8
		LDA	z:$18,X
		STA	z:$52
		LDA	z:$20,X
		CMP	z:$22,X
		BEQ	locret_C63982
		STA	z:$22,X
		REP	#$20
.A16
		AND	#$FF
		ASL
		ADC	z:$16,X
		STA	z:$50
		LDA	[$50]
		STA	z:$50
		JSL	f:start_animation

locret_C63982:
		RTL
; End of function wanderer_movement2

.A16
.I16

sub_C63983:
		JSL	f:follower_movement_2
		SEP	#$20
.A8
		LDA	z:$20,X
		BIT	#1
		BNE	loc_C63997
		JSL	f:sub_C635EA
		BEQ	loc_C639B6
		BRA	loc_C6399D
; ---------------------------------------------------------------------------

loc_C63997:
		JSL	f:sub_C635FD
		BEQ	loc_C639B6

loc_C6399D:
		LDA	z:$20,X
		PHA
		LDA	z:$44
		STA	z:$20,X
		REP	#$20
.A16
		LDA	#BOMB|SOFT_BLOCK|HARD_BLOCK
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		SEP	#$20
.A8
		BEQ	loc_C639BE
		PLA
		STA	z:$20,X

loc_C639B6:
		LDA	z:$20,X
		INC
		AND	#3
		STA	z:$20,X
		RTL
; ---------------------------------------------------------------------------

loc_C639BE:
		PLA
		RTL
; End of function sub_C63983

.A16
.I16

follower_movement_2:
		REP	#$20
		LDY	#.LOWORD(player2_object)
		LDA	a:.LOWORD(player1_object+player::gameover_related)	; orig=0x0D44
		AND	#$FF
		BEQ	locret_C63A1B
		LDY	#.LOWORD(player1_object)
		LDA	a:.LOWORD(player2_object+player::gameover_related)	; orig=0x0D84
		AND	#$FF
		BEQ	locret_C63A1B
		LDA	z:enemy::x_position,X
		SEC
		SBC	a:.LOWORD(player1_object+player::x_position) ; orig=0x0D51
		BPL	loc_C639E4
		EOR	#$FFFF
		INC

loc_C639E4:
		STA	z:$40
		LDA	z:enemy::y_position,X
		SEC
		SBC	a:.LOWORD(player1_object+player::y_position) ; orig=0x0D54
		BPL	loc_C639F2
		EOR	#$FFFF
		INC

loc_C639F2:
		CLC
		ADC	z:$40
		STA	z:$42
		LDA	z:enemy::x_position,X
		SEC
		SBC	a:.LOWORD(player2_object+player::x_position) ; orig=0x0D91
		BPL	loc_C63A03
		EOR	#$FFFF
		INC

loc_C63A03:
		STA	z:$40
		LDA	z:enemy::y_position,X
		SEC
		SBC	a:.LOWORD(player2_object+player::y_position) ; orig=0x0D94
		BPL	loc_C63A11
		EOR	#$FFFF
		INC

loc_C63A11:
		CLC
		ADC	z:$40
		CMP	z:$42
		BCS	locret_C63A1B
		LDY	#.LOWORD(player2_object)

locret_C63A1B:
		RTL
; End of function follower_movement_2

.A16
.I16

pakupa_is_bomb_in_direction:
		REP	#$20
		LDA	z:$40
		PHA
		JSL	f:get_object_square_index
		TAY
		PLA
		STA	z:$40
		LDA	#8
		STA	z:$42

loc_C63A2E:
		TYA
		CLC
		ADC	z:$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#SOFT_BLOCK|HARD_BLOCK
		BNE	loc_C63A55
		BIT	#BOMB
		BNE	loc_C63A57
		LDA	a:.LOWORD(debug_vs_check) ; orig=0x00B4 ; Color the tiles if debug_vs_check is on
		AND	#$FF
		BEQ	loc_C63A51
		LDA	a:.LOWORD(bg1_tilemap),Y
		ORA	#$200
		STA	a:.LOWORD(bg1_tilemap),Y

loc_C63A51:
		DEC	z:$42
		BNE	loc_C63A2E

loc_C63A55:
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C63A57:
		SEC
		RTL
; End of function pakupa_is_bomb_in_direction

; ---------------------------------------------------------------------------
line_of_sight_offsets:.WORD .LOWORD(-$40)
		.WORD 2
		.WORD $40
		.WORD .LOWORD(-2)
.A16
.I16

pakupa_is_bomb_in_line_of_sight:
		REP	#$20
		LDA	#0
		STA	z:$44
		LDA	z:enemy::direction,X
		PHA

loc_C63A6B:
		SEP	#$20
.A8
		LDA	z:enemy::direction,X
		AND	#3
		STA	z:enemy::direction,X
		INC	z:enemy::direction,X
		REP	#$20
.A16
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:line_of_sight_offsets,X
		PLX
		STA	z:$40
		JSL	f:pakupa_is_bomb_in_direction
		BCS	loc_C63A98
		INC	z:$44
		LDA	z:$44
		CMP	#4
		BNE	loc_C63A6B
		PLA
		STA	z:enemy::direction,X
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C63A98:
		PLA
		DEC	z:enemy::direction,X
		SEC
		RTL
; End of function pakupa_is_bomb_in_line_of_sight

.A8
.I16

pakupa_movement:
		REP	#$20
.A16
		JSL	f:pakupa_is_bomb_in_line_of_sight
		REP	#$20
		LDA	#SOFT_BLOCK|HARD_BLOCK
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		BEQ	loc_C63AB4
		JML	f:enemy_hit_deadend
; ---------------------------------------------------------------------------

loc_C63AB4:
		JSL	f:straight_movement
		BCC	loc_C63ABE
		JML	f:locret_C63ADE
; ---------------------------------------------------------------------------

loc_C63ABE:
		SEP	#$20
.A8
		LDA	z:$18,X
		STA	z:$52
		LDA	z:enemy::direction,X
		CMP	z:enemy::animation_direction,X
		BEQ	locret_C63ADE
		STA	z:enemy::animation_direction,X
		REP	#$20
.A16
		AND	#$FF
		ASL
		ADC	z:enemy::animation,X
		STA	z:$50
		LDA	[$50]
		STA	z:$50
		JSL	f:start_animation
; End of function pakupa_movement

locret_C63ADE:
		RTL
; End of function wanderer_movement

.A16
.I16

kuwagen_movement:
		REP	#$20
		LDA	z:enemy::speed,X
		PHA
		LDY	#.LOWORD(player1_object)
		JSL	f:is_in_line_of_sight
		BCC	loc_C63B39
		LDY	#.LOWORD(player2_object)
		JSL	f:is_in_line_of_sight
		BCC	loc_C63B39
		REP	#$20
		STZ	z:$30,X
		LDA	#BOMB|SOFT_BLOCK|HARD_BLOCK
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		BEQ	loc_C63B0D
		REP	#$20
		PLA
		STA	z:$19,X
		JMP	a:.LOWORD(enemy_hit_deadend)
; ---------------------------------------------------------------------------

loc_C63B0D:
		JSL	f:straight_movement
		BCS	loc_C63B33

loc_C63B13:
		SEP	#$20
.A8
		LDA	z:$18,X
		STA	z:$52
		LDA	z:$20,X
		CMP	z:$22,X
		BEQ	loc_C63B33
		STA	z:$22,X
		REP	#$20
.A16
		AND	#$FF
		ASL
		ADC	z:$16,X
		STA	z:$50
		LDA	[$50]
		STA	z:$50
		JSL	f:start_animation

loc_C63B33:
		REP	#$20
		PLA
		STA	z:$19,X
		RTL
; ---------------------------------------------------------------------------

loc_C63B39:
		SEP	#$20
.A8
		LDA	z:enemy::direction,X
		BIT	#1
		BNE	loc_C63B4B
		LDA	z:enemy::x_position,X
		AND	#$F
		CMP	#8
		BNE	loc_C63B0D
		BRA	loc_C63B53
; ---------------------------------------------------------------------------

loc_C63B4B:
		LDA	z:enemy::y_position,X
		AND	#$F
		CMP	#8
		BNE	loc_C63B0D

loc_C63B53:
		REP	#$20
.A16
		INC	z:enemy::field_30,X
		LDA	z:enemy::field_30,X
		CMP	#$20
		BNE	loc_C63B13
		DEC	z:enemy::field_30,X
		INC	z:enemy::speed,X
		BRA	loc_C63B0D
; End of function kuwagen_movement

.A16
.I16

is_in_line_of_sight:
		REP	#$20
		LDA	#$5050
		STA	z:$42
		LDA	#$C0C
		STA	z:$44
		LDA	z:$20,X
		BIT	#1
		BNE	loc_C63B81
		LDA	#$C0C
		STA	z:$42
		LDA	#$5050
		STA	z:$44

loc_C63B81:
		LDA	z:$42
		PHA
		LDA	z:$44
		PHA
		JSL	f:sub_C6359F
		BCS	loc_C63B91
		JML	f:loc_C63BC0
; ---------------------------------------------------------------------------

loc_C63B91:
		JSL	f:sub_C635E2
		REP	#$20
		PLA
		PLA
		SEP	#$20
.A8
		LDA	z:$44
		EOR	#2
		CMP	z:$20,X
		BEQ	loc_C63BBE
		LDA	z:$20,X
		STA	z:$45
		LDA	z:$44
		STA	z:$20,X
		REP	#$20
.A16
		LDA	#BOMB|SOFT_BLOCK|HARD_BLOCK
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		SEP	#$20
.A8
		BEQ	loc_C63BF7

loc_C63BBA:
		LDA	z:$45
		STA	z:$20,X
.A16

loc_C63BBE:
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C63BC0:
		REP	#$20
		PLA
		STA	z:$42
		PLA
		STA	z:$44
		JSL	f:sub_C6359F
		BCS	loc_C63BD2
		JML	f:loc_C63BBE
; ---------------------------------------------------------------------------

loc_C63BD2:
		JSL	f:sub_C635E2
		SEP	#$20
.A8
		LDA	z:$44
		EOR	#2
		CMP	z:$20,X
		BEQ	loc_C63BBE
		LDA	z:$20,X
		STA	z:$45
		LDA	z:$44
		STA	z:$20,X
		REP	#$20
.A16
		LDA	#BOMB|SOFT_BLOCK|HARD_BLOCK
		STA	z:$42
		JSL	f:test_collision_mask_for_enemy_next_square
		SEP	#$20
.A8
		BNE	loc_C63BBA

loc_C63BF7:
		CLC
		RTL
; End of function is_in_line_of_sight

.A16
.I16

sub_C63BF9:
		REP	#$20
		LDA	z:$11,X
		CLC
		ADC	#$200
		STA	z:$48
		LDA	z:$14,X
		CLC
		ADC	#$200
		STA	z:$4A
		LDA	a:.LOWORD($11),Y
		AND	#$FF
		CLC
		ADC	#$200
		STA	z:$4C
		LDA	a:.LOWORD($14),Y
		CLC
		ADC	#$200
		STA	z:$4E
		LDA	z:$4A
		SEC
		SBC	#6
		CMP	z:$4E
		BCS	loc_C63C44
		CLC
		ADC	#$C
		CMP	z:$4E
		BCS	loc_C63C36
		JML	f:loc_C63CAA
; ---------------------------------------------------------------------------

loc_C63C36:
		LDA	z:$48
		CMP	z:$4C
		BCC	loc_C63C40
		LDA	#$C
		RTL
; ---------------------------------------------------------------------------

loc_C63C40:
		LDA	#4
		RTL
; ---------------------------------------------------------------------------

loc_C63C44:
		LDA	z:$48
		CLC
		ADC	#6
		CMP	z:$4C
		BCC	loc_C63C5A
		SEC
		SBC	#$C
		CMP	z:$4C
		BCS	loc_C63C82
		LDA	#0
		RTL
; ---------------------------------------------------------------------------

loc_C63C5A:
		LDA	z:$4C
		SEC
		SBC	z:$48
		STA	z:$46
		LDA	z:$4A
		SEC
		SBC	z:$4E
		SEC
		SBC	z:$46
		BCC	loc_C63C74
		CMP	#$18
		BCC	loc_C63C7E
		LDA	#1
		RTL
; ---------------------------------------------------------------------------

loc_C63C74:
		CLC
		ADC	#$20
		BCS	loc_C63C7E
		LDA	#3
		RTL
; ---------------------------------------------------------------------------

loc_C63C7E:
		LDA	#2
		RTL
; ---------------------------------------------------------------------------

loc_C63C82:
		LDA	z:$48
		SEC
		SBC	z:$4C
		STA	z:$46
		LDA	z:$4A
		SEC
		SBC	z:$4E
		SEC
		SBC	z:$46
		BCC	loc_C63C9C
		CMP	#$18
		BCC	loc_C63CA6
		LDA	#$F
		RTL
; ---------------------------------------------------------------------------

loc_C63C9C:
		CLC
		ADC	#$20
		BCS	loc_C63CA6
		LDA	#$D
		RTL
; ---------------------------------------------------------------------------

loc_C63CA6:
		LDA	#$E
		RTL
; ---------------------------------------------------------------------------

loc_C63CAA:
		LDA	z:$48
		CLC
		ADC	#6
		CMP	z:$4C
		BCC	loc_C63CC0
		SEC
		SBC	#$C
		CMP	z:$4C
		BCS	loc_C63CDA
		LDA	#8
		RTL
; ---------------------------------------------------------------------------

loc_C63CC0:
		LDA	z:$4C
		SEC
		SBC	z:$48
		STA	z:$46
		LDA	z:$4E
		SEC
		SBC	z:$4A
		SEC
		SBC	z:$46
		BCC	loc_C63D02
		CMP	#$18
		BCC	loc_C63D0C
		LDA	#7
		RTL
; ---------------------------------------------------------------------------

loc_C63CDA:
		LDA	z:$48
		SEC
		SBC	z:$4C
		STA	z:$46
		LDA	z:$4E
		SEC
		SBC	z:$4A
		SEC
		SBC	z:$46
		BCC	loc_C63CF4
		CMP	#$18
		BCC	loc_C63CFE
		LDA	#9
		RTL
; ---------------------------------------------------------------------------

loc_C63CF4:
		CLC
		ADC	#$20
		BCS	loc_C63CFE
		LDA	#$B
		RTL
; ---------------------------------------------------------------------------

loc_C63CFE:
		LDA	#$A
		RTL
; ---------------------------------------------------------------------------

loc_C63D02:
		CLC
		ADC	#$20
		BCS	loc_C63D0C
		LDA	#5
		RTL
; ---------------------------------------------------------------------------

loc_C63D0C:
		LDA	#6
		RTL
; End of function sub_C63BF9

; ---------------------------------------------------------------------------
animation_frame_C63D10:.BYTE 3
		frame_oam_tile 0, 0, $2000, $40
		frame_oam_tile $F8, 0,	$2000, 0
		frame_oam_tile $F8, $F0, $2200, $20
animation_frame_C63D20:.BYTE 3
		frame_oam_tile 0, 0, $3000, $40
		frame_oam_tile $F8, 0,	$3000, 0
		frame_oam_tile $F8, $F0, $2200, $20
animation_frame_C63D30:.BYTE 3
		frame_oam_tile $F8, 0,	$3100, $40
		frame_oam_tile 0, 0, $3100, 0
		frame_oam_tile $F8, $F0, $2200, $20
animation_frame_C63D40:.BYTE 3
		frame_oam_tile $FC, $F8, $2600, $60
		frame_oam_tile $F9, $E8, $2201, $60
		frame_oam_tile $EC, $F8, $401,	$60
animation_frame_C63D50:.BYTE 3
		frame_oam_tile $FC, $F8, $2001, $60
		frame_oam_tile $F9, $E8, $2201, $60
		frame_oam_tile $EC, $F8, $401,	$60
animation_frame_C63D60:.BYTE 3
		frame_oam_tile $FC, $F8, $2400, $60
		frame_oam_tile $F9, $E8, $2201, $60
		frame_oam_tile $EC, $F8, $401,	$60
animation_frame_C63D70:.BYTE 3
		frame_oam_tile $FC, $F8, $201,	$60
		frame_oam_tile $F9, $E8, $2201, $60
		frame_oam_tile $EC, $F8, $401,	$60
animation_frame_C63D80:.BYTE 3
		frame_oam_tile $FC, $F8, $601,	$60
		frame_oam_tile $F9, $E8, $2201, $60
		frame_oam_tile $EC, $F8, $401,	$60
animation_frame_C63D90:.BYTE 3
		frame_oam_tile $FC, $F8, $2401, $60
		frame_oam_tile $F9, $E8, $2201, $60
		frame_oam_tile $EC, $F8, $401,	$60
animation_frame_C63DA0:.BYTE 4
		frame_oam_tile $F8, $E8, $600,	$20
		frame_oam_tile 0, $F8,	$100, 0
		frame_oam_tile $F8, $F8, 0, 0
		frame_oam_tile $F8, 0,	1, $20
animation_frame_C63DB5:.BYTE 4
		frame_oam_tile 0, $F8,	$1100, 0
		frame_oam_tile $F8, $F8, $1000, 0
		frame_oam_tile $F8, $E8, $600,	$20
		frame_oam_tile $F8, 0,	1, $20
animation_frame_C63DCA:.BYTE 4
		frame_oam_tile 0, $F8,	$300, 0
		frame_oam_tile $F8, $F8, $200,	0
		frame_oam_tile $F8, $E8, $600,	$20
		frame_oam_tile $F8, 0,	1, $20
animation_frame_C63DDF:.BYTE 4
		frame_oam_tile 0, $F8,	$1300, 0
		frame_oam_tile $F8, $F8, $1200, 0
		frame_oam_tile $F8, $E8, $600,	$20
		frame_oam_tile $F8, 0,	1, $20
animation_frame_C63DF4:.BYTE 4
		frame_oam_tile 0, $F8,	$500, 0
		frame_oam_tile $F8, $F8, $400,	0
		frame_oam_tile $F8, $E8, $600,	$20
		frame_oam_tile $F8, 0,	1, $20
animation_frame_C63E09:.BYTE 4
		frame_oam_tile 0, $F8,	$1500, 0
		frame_oam_tile $F8, $F8, $1400, 0
		frame_oam_tile $F8, $E8, $600,	$20
		frame_oam_tile $F8, 0,	1, $20
animation_frame_C63E1E:.BYTE 3
		frame_oam_tile $F4, $F8, $2600, $20
		frame_oam_tile 4, $F8,	$401, $20
		frame_oam_tile $F7, $E8, $2201, $20
animation_frame_C63E2E:.BYTE 3
		frame_oam_tile $F4, $F8, $2001, $20
		frame_oam_tile 4, $F8,	$401, $20
		frame_oam_tile $F7, $E8, $2201, $20
animation_frame_C63E3E:.BYTE 3
		frame_oam_tile $F4, $F8, $2400, $20
		frame_oam_tile 4, $F8,	$401, $20
		frame_oam_tile $F7, $E8, $2201, $20
animation_frame_C63E4E:.BYTE 3
		frame_oam_tile $F4, $F8, $201,	$20
		frame_oam_tile 4, $F8,	$401, $20
		frame_oam_tile $F7, $E8, $2201, $20
animation_frame_C63E5E:.BYTE 3
		frame_oam_tile $F4, $F8, $601,	$20
		frame_oam_tile 4, $F8,	$401, $20
		frame_oam_tile $F7, $E8, $2201, $20
animation_frame_C63E6E:.BYTE 3
		frame_oam_tile $F4, $F8, $2401, $20
		frame_oam_tile 4, $F8,	$401, $20
		frame_oam_tile $F7, $E8, $2201, $20
byte_C63E7E:	.BYTE 4
		animation_frame animation_frame_C63D10, 2
		animation_frame animation_frame_C63D20, 2
		animation_frame animation_frame_C63D30, 2
		animation_frame animation_frame_C63D20, 2
byte_C63E8F:	.BYTE $A
		animation_frame animation_frame_C63D40, $10
		animation_frame animation_frame_C63D50, 3
		animation_frame animation_frame_C63D60, 3
		animation_frame animation_frame_C63D70, 3
		animation_frame animation_frame_C63D80, 3
		animation_frame animation_frame_C63D90, $10
		animation_frame animation_frame_C63D80, 3
		animation_frame animation_frame_C63D70, 3
		animation_frame animation_frame_C63D60, 3
		animation_frame animation_frame_C63D50, 3
byte_C63EB8:	.BYTE $B
		animation_frame animation_frame_C63DA0, $10
		animation_frame animation_frame_C63DB5, 3
		animation_frame animation_frame_C63DCA, 3
		animation_frame animation_frame_C63DDF, 3
		animation_frame animation_frame_C63DF4, 3
		animation_frame animation_frame_C63E09, $10
		animation_frame animation_frame_C63DF4, 3
		animation_frame animation_frame_C63DDF, 3
		animation_frame animation_frame_C63DCA, 3
		animation_frame animation_frame_C63DB5, 3
		animation_frame animation_frame_C63DA0, 3
byte_C63EE5:	.BYTE $B
		animation_frame animation_frame_C63E1E, $10
		animation_frame animation_frame_C63E2E, 3
		animation_frame animation_frame_C63E3E, 3
		animation_frame animation_frame_C63E4E, 3
		animation_frame animation_frame_C63E5E, 3
		animation_frame animation_frame_C63E6E, $10
		animation_frame animation_frame_C63E5E, 3
		animation_frame animation_frame_C63E4E, 3
		animation_frame animation_frame_C63E3E, 3
		animation_frame animation_frame_C63E2E, 3
		animation_frame animation_frame_C63E1E, 3
animation_frame_C63F12:.BYTE 4
		frame_oam_tile 0, $EB,	$201, $20
		frame_oam_tile $F0, $EB, 1, $20
		frame_oam_tile 0, $FB,	$2201, $20
		frame_oam_tile $F0, $FB, $2001, $20
animation_frame_C63F27:.BYTE 4
		frame_oam_tile 0, $FB,	$601, $20
		frame_oam_tile $F0, $FB, $401,	$20
		frame_oam_tile 0, $EB,	$201, $20
		frame_oam_tile $F0, $EB, 1, $20
animation_frame_C63F3C:.BYTE 4
		frame_oam_tile 0, $FB,	$2000, $60
		frame_oam_tile $F0, $FB, $2200, $60
		frame_oam_tile $F0, $EB, $200,	$60
		frame_oam_tile 0, $EB,	0, $60
animation_frame_C63F51:.BYTE 4
		frame_oam_tile $F0, $FB, $202,	$60
		frame_oam_tile 0, $FB,	2, $60
		frame_oam_tile $F0, $EB, $200,	$60
		frame_oam_tile 0, $EB,	0, $60
animation_frame_C63F66:.BYTE 4
		frame_oam_tile 0, $EB,	$600, $20
		frame_oam_tile $F0, $EB, $400,	$20
		frame_oam_tile 0, $FB,	$2600, $20
		frame_oam_tile $F0, $FB, $2400, $20
animation_frame_C63F7B:.BYTE 4
		frame_oam_tile 0, $FB,	$2601, $20
		frame_oam_tile $F0, $FB, $2401, $20
		frame_oam_tile 0, $EB,	$600, $20
		frame_oam_tile $F0, $EB, $400,	$20
animation_frame_C63F90:.BYTE 4
		frame_oam_tile 0, $FB,	$2200, $20
		frame_oam_tile $F0, $FB, $2000, $20
		frame_oam_tile 0, $EB,	$200, $20
		frame_oam_tile $F0, $EB, 0, $20
animation_frame_C63FA5:.BYTE 4
		frame_oam_tile 0, $FB,	$202, $20
		frame_oam_tile $F0, $FB, 2, $20
		frame_oam_tile 0, $EB,	$200, $20
		frame_oam_tile $F0, $EB, 0, $20
animation_frame_C63FBA:.BYTE 1
		frame_oam_tile $FD, $FD, $402,	2
animation_frame_C63FC0:.BYTE 1
		frame_oam_tile $FD, $FD, $402,	$42
animation_frame_C63FC6:.BYTE 1
		frame_oam_tile $FD, $FD, $402,	$C2
animation_frame_C63FCC:.BYTE 1
		frame_oam_tile $FD, $FD, $402,	$82
animation_frame_C63FD2:.BYTE 1
		frame_oam_tile $F8, $F8, $602,	$22
animation_frame_C63FD8:.BYTE 1
		frame_oam_tile $F8, $F8, $602,	$62
animation_frame_C63FDE:.BYTE 1
		frame_oam_tile $F8, $F8, $602,	$E2
animation_frame_C63FE4:.BYTE 1
		frame_oam_tile $F8, $F8, $602,	$A2
animation_frame_C63FEA:.BYTE 1
		frame_oam_tile $F8, $F8, $2602, $22
animation_frame_C63FF0:.BYTE 1
		frame_oam_tile $F8, $F8, $2602, $62
animation_frame_C63FF6:.BYTE 1
		frame_oam_tile $F8, $F9, $2602, $E2
animation_frame_C63FFC:.BYTE 1
		frame_oam_tile $F8, $F9, $2602, $A2
animation_frame_C64002:.BYTE 1
		frame_oam_tile $FF, $F3, $2002, 0
animation_frame_C64008:.BYTE 1
		frame_oam_tile $F9, $F2, $2202, 0
animation_frame_C6400E:.BYTE 1
		frame_oam_tile $F8, $F0, $2102, 0
animation_frame_C64014:.BYTE 1
		frame_oam_tile $FA, $EB, $2302, 0
animation_frame_C6401A:.BYTE 1
		frame_oam_tile $FF, $EB, $3002, 0
animation_frame_C64020:.BYTE 1
		frame_oam_tile $FF, $EB, $2302, $40
animation_frame_C64026:.BYTE 1
		frame_oam_tile 1, $F0,	$2102, $40
animation_frame_C6402C:.BYTE 1
		frame_oam_tile 0, $F2,	$2202, $40
byte_C64032:	.BYTE 2
stru_C64033:	animation_frame animation_frame_C63F12, $E
		animation_frame animation_frame_C63F27, $E
byte_C6403B:	.BYTE 2
		animation_frame animation_frame_C63F3C, $E
		animation_frame animation_frame_C63F51, $E
byte_C64044:	.BYTE 2
		animation_frame animation_frame_C63F66, $E
		animation_frame animation_frame_C63F7B, $E
byte_C6404D:	.BYTE 2
		animation_frame animation_frame_C63F90, $E
		animation_frame animation_frame_C63FA5, $E
byte_C64056:	.BYTE 4
		animation_frame animation_frame_C63FBA, 3
		animation_frame animation_frame_C63FC0, 3
		animation_frame animation_frame_C63FC6, 3
		animation_frame animation_frame_C63FCC, 3
byte_C64067:	.BYTE 4
		animation_frame animation_frame_C63FD2, 3
		animation_frame animation_frame_C63FD8, 3
		animation_frame animation_frame_C63FDE, 3
		animation_frame animation_frame_C63FE4, 3
byte_C64078:	.BYTE 4
		animation_frame animation_frame_C63FEA, 3
		animation_frame animation_frame_C63FF0, 3
		animation_frame animation_frame_C63FF6, 3
		animation_frame animation_frame_C63FFC, 3
		.BYTE 1
		animation_frame animation_frame_C63F12, $FF
		.BYTE 1
		animation_frame animation_frame_C63F3C, $FF
		.BYTE 1
		animation_frame animation_frame_C63F66, $FF
		.BYTE 1
		animation_frame animation_frame_C63F90, $FF
byte_C6409D:	.BYTE 8
		animation_frame animation_frame_C6401A, 4
		animation_frame animation_frame_C64020, 4
		animation_frame animation_frame_C64026, 4
		animation_frame animation_frame_C6402C, 4
		animation_frame animation_frame_C64002, 4
		animation_frame animation_frame_C64008, 4
		animation_frame animation_frame_C6400E, 4
		animation_frame animation_frame_C64014, 4
animation_frame_C640BE:.BYTE 3
		frame_oam_tile 0, 0, $1301, 0
		frame_oam_tile $F8, 0,	$1201, 0
		frame_oam_tile $F8, $F0, $401,	$20
animation_frame_C640CE:.BYTE 3
		frame_oam_tile $F8, $F0, $2001, $20
		frame_oam_tile 0, 0, $1301, 0
		frame_oam_tile $F8, 0,	$1201, 0
animation_frame_C640DE:.BYTE 3
		frame_oam_tile 0, 0, $1301, 0
		frame_oam_tile $F8, 0,	$1201, 0
		frame_oam_tile $F8, $F0, $601,	$20
animation_frame_C640EE:.BYTE 3
		frame_oam_tile $F8, $F0, $2201, $20
		frame_oam_tile 0, 0, $1301, 0
		frame_oam_tile $F8, 0,	$1201, 0
animation_frame_C640FE:.BYTE 3
		frame_oam_tile 0, 0, $101, 0
		frame_oam_tile $F8, 0,	1, 0
		frame_oam_tile $F8, $F0, $400,	$60
animation_frame_C6410E:.BYTE 3
		frame_oam_tile 0, 0, $101, 0
		frame_oam_tile $F8, 0,	1, 0
		frame_oam_tile $F8, $F0, $2400, $60
animation_frame_C6411E:.BYTE 3
		frame_oam_tile 0, 0, $101, 0
		frame_oam_tile $F8, 0,	1, 0
		frame_oam_tile $F8, $F0, $600,	$60
animation_frame_C6412E:.BYTE 3
		frame_oam_tile 0, 0, $101, 0
		frame_oam_tile $F8, 0,	1, 0
		frame_oam_tile $F8, $F0, $2600, $60
animation_frame_C6413E:.BYTE 3
		frame_oam_tile 0, 0, $1101, 0
		frame_oam_tile $F8, 0,	$1001, 0
		frame_oam_tile $F8, $F0, 0, $20
animation_frame_C6414E:.BYTE 3
		frame_oam_tile 0, 0, $1101, 0
		frame_oam_tile $F8, 0,	$1001, 0
		frame_oam_tile $F8, $F0, $2000, $20
animation_frame_C6415E:.BYTE 3
		frame_oam_tile 0, 0, $1101, 0
		frame_oam_tile $F8, 0,	$1001, 0
		frame_oam_tile $F8, $F0, $200,	$20
animation_frame_C6416E:.BYTE 3
		frame_oam_tile 0, 0, $1101, 0
		frame_oam_tile $F8, 0,	$1001, 0
		frame_oam_tile $F8, $F0, $2200, $20
animation_frame_C6417E:.BYTE 3
		frame_oam_tile 0, 0, 1, $40
		frame_oam_tile $F8, 0,	$101, $40
		frame_oam_tile $F8, $F0, $400,	$20
animation_frame_C6418E:.BYTE 3
		frame_oam_tile 0, 0, 1, $40
		frame_oam_tile $F8, 0,	$101, $40
		frame_oam_tile $F8, $F0, $2400, $20
animation_frame_C6419E:.BYTE 3
		frame_oam_tile 0, 0, 1, $40
		frame_oam_tile $F8, 0,	$101, $40
		frame_oam_tile $F8, $F0, $600,	$20
animation_frame_C641AE:.BYTE 3
		frame_oam_tile 0, 0, 1, $40
		frame_oam_tile $F8, 0,	$101, $40
		frame_oam_tile $F8, $F0, $2600, $20
byte_C641BE:	.BYTE 4
		animation_frame animation_frame_C640BE, 1
		animation_frame animation_frame_C640CE, 1
		animation_frame animation_frame_C640DE, 1
		animation_frame animation_frame_C640EE, 1
byte_C641CF:	.BYTE 4
		animation_frame animation_frame_C640FE, 1
		animation_frame animation_frame_C6410E, 1
		animation_frame animation_frame_C6411E, 1
		animation_frame animation_frame_C6412E, 1
propene_animation:.BYTE	4
		animation_frame animation_frame_C6413E, 1; 0
		animation_frame animation_frame_C6414E, 1; 1
		animation_frame animation_frame_C6415E, 1; 2
		animation_frame animation_frame_C6416E, 1; 3
byte_C641F1:	.BYTE 4
		animation_frame animation_frame_C6417E, 1; 0
		animation_frame animation_frame_C6418E, 1; 1
		animation_frame animation_frame_C6419E, 1; 2
		animation_frame animation_frame_C641AE, 1; 3
animation_frame_C64202:.BYTE 4
		frame_oam_tile 0, 0, $2200, $20
		frame_oam_tile $F0, 0,	$2000, $20
		frame_oam_tile 0, $F0,	$200, $20
		frame_oam_tile $F0, $F0, 0, $20
animation_frame_C64217:.BYTE 2
		frame_oam_tile $F8, 0,	$2400, $20
		frame_oam_tile $F8, $F0, $400,	$20
animation_frame_C64222:.BYTE 2
		frame_oam_tile $F8, 0,	$2600, $20
		frame_oam_tile $F8, $F0, $600,	$20
animation_frame_C6422D:.BYTE 4
		frame_oam_tile 0, 0, $2000, $60
		frame_oam_tile 0, $F0,	0, $60
		frame_oam_tile $F0, 0,	$2200, $60
		frame_oam_tile $F0, $F0, $200,	$60
		.BYTE 4
		.BYTE 0, 0, 1, $22, 0, $F0, 0, 1
		.BYTE $20, $20,	0, $F0,	1, 2, $20, $F0
		.BYTE $F0, 1, 0, $20
		.BYTE 4
		.BYTE 0, 0, 1, $22, 0
		.BYTE 0, $F0, 1, 2, $20
		.BYTE $F0, 0, 1, $24, $20
		.BYTE $F0, $F0,	1, 4, $20
		.BYTE 4
		.BYTE 0, $F0, 1, 2, $20
		.BYTE 0, 0, 1, $22, 0
		.BYTE $F0, 0, 1, $26, $20
		.BYTE $F0, $F0,	1, 6, $20
		.BYTE 4
		.BYTE 0, 0, 1, $22, 0
		.BYTE 0, $F0, 1, 2, $20
		.BYTE $F0, $F0,	1, 6, $20
		.BYTE $F0, 0, 2, 0, $20
		.BYTE 1
		animation_frame animation_frame_C64222, $FF
		.BYTE 1
		animation_frame animation_frame_C64202, $FF
		.BYTE 1
		animation_frame animation_frame_C64217, $FF
		.BYTE 1
		animation_frame animation_frame_C6422D, $FF
animation_frame_C642AA:.BYTE 2
		frame_oam_tile $F8, $F7, $2000, $20
		frame_oam_tile $F8, $E7, 0, $20
animation_frame_C642B5:.BYTE 2
		frame_oam_tile $F8, $FC, $2200, $20
		frame_oam_tile $F8, $EC, $200,	$20
animation_frame_C642C0:.BYTE 2
		frame_oam_tile $F8, 0,	$2400, $20
		frame_oam_tile $F8, $F0, $400,	$20
animation_frame_C642CB:.BYTE 2
		frame_oam_tile $F8, $F5, $2000, $20
		frame_oam_tile $F8, $E5, 0, $20
animation_frame_C642D6:.BYTE 2
		frame_oam_tile $F8, $F3, $2000, $20
		frame_oam_tile $F8, $E3, 0, $20
animation_frame_C642E1:.BYTE 2
		frame_oam_tile $F8, $F0, $201,	$20
		frame_oam_tile $F8, 0,	$2400, $20
animation_frame_C642EC:.BYTE 2
		frame_oam_tile $F8, $EC, 1, $20
		frame_oam_tile $F8, $FC, $2200, $20
animation_frame_C642F7:.BYTE 2
		frame_oam_tile $F8, $E7, $600,	$20
		frame_oam_tile $F8, $F7, $2000, $20
animation_frame_C64302:.BYTE 2
		frame_oam_tile $F8, $F5, $2000, $20
		frame_oam_tile $F8, $E5, $600,	$20
animation_frame_C6430D:.BYTE 2
		frame_oam_tile $F8, $F3, $2000, $20
		frame_oam_tile $F8, $E3, $600,	$20
animation_frame_C64318:.BYTE 2
		frame_oam_tile $F8, $F0, $2201, $20
		frame_oam_tile $F8, 0,	$2400, $20
animation_frame_C64323:.BYTE 2
		frame_oam_tile $F8, $EC, $2001, $20
		frame_oam_tile $F8, $FC, $2200, $20
animation_frame_C6432E:.BYTE 2
		frame_oam_tile $F8, $E7, $2600, $20
		frame_oam_tile $F8, $F7, $2000, $20
animation_frame_C64339:.BYTE 2
		frame_oam_tile $F8, $E5, $2600, $20
		frame_oam_tile $F8, $F5, $2000, $20
animation_frame_C64344:.BYTE 2
		frame_oam_tile $F8, $E3, $2600, $20
		frame_oam_tile $F8, $F3, $2000, $20
animation_frame_C6434F:.BYTE 2
		frame_oam_tile $F8, $F0, $201,	$60
		frame_oam_tile $F8, 0,	$2400, $60
animation_frame_C6435A:.BYTE 2
		frame_oam_tile $F8, $EC, 1, $60
		frame_oam_tile $F8, $FC, $2200, $60
animation_frame_C64365:.BYTE 2
		frame_oam_tile $F8, $E7, $600,	$60
		frame_oam_tile $F8, $F7, $2000, $60
animation_frame_C64370:.BYTE 2
		frame_oam_tile $F8, $E5, $600,	$60
		frame_oam_tile $F8, $F5, $2000, $60
animation_frame_C6437B:.BYTE 2
		frame_oam_tile $F8, $E3, $600,	$60
		frame_oam_tile $F8, $F3, $2000, $60
byte_C64386:	.BYTE 8
		animation_frame animation_frame_C642C0, $10
		animation_frame animation_frame_C642B5, 3
		animation_frame animation_frame_C642AA, 4
		animation_frame animation_frame_C642CB, 6
		animation_frame animation_frame_C642D6, 8
		animation_frame animation_frame_C642CB, 6
		animation_frame animation_frame_C642AA, 4
		animation_frame animation_frame_C642B5, 3
byte_C643A7:	.BYTE 8
		animation_frame animation_frame_C6434F, $10
		animation_frame animation_frame_C6435A, 3
		animation_frame animation_frame_C64365, 4
		animation_frame animation_frame_C64370, 6
		animation_frame animation_frame_C6437B, 8
		animation_frame animation_frame_C64370, 6
		animation_frame animation_frame_C64365, 4
		animation_frame animation_frame_C6435A, 3
byte_C643C8:	.BYTE 8
		animation_frame animation_frame_C64318, $10
		animation_frame animation_frame_C64323, 3
		animation_frame animation_frame_C6432E, 4
		animation_frame animation_frame_C64339, 6
		animation_frame animation_frame_C64344, 8
		animation_frame animation_frame_C64339, 6
		animation_frame animation_frame_C6432E, 4
		animation_frame animation_frame_C64323, 3
byte_C643E9:	.BYTE 8
		animation_frame animation_frame_C642E1, $10
		animation_frame animation_frame_C642EC, 3
		animation_frame animation_frame_C642F7, 4
		animation_frame animation_frame_C64302, 6
		animation_frame animation_frame_C6430D, 8
		animation_frame animation_frame_C64302, 6
		animation_frame animation_frame_C642F7, 4
		animation_frame animation_frame_C642EC, 3
animation_frame_C6440A:.BYTE 3
		frame_oam_tile 0, $F0,	$3100, 0
		frame_oam_tile $F8, $F0, $3000, 0
		frame_oam_tile $F8, $F8, 0, $20
animation_frame_C6441A:.BYTE 3
		frame_oam_tile 0, $F0,	$3300, 0
		frame_oam_tile $F8, $F0, $3200, 0
		frame_oam_tile $F8, $F8, $200,	$20
animation_frame_C6442A:.BYTE 3
		frame_oam_tile 0, $F0,	$3500, 0
		frame_oam_tile $F8, $F0, $3400, 0
		frame_oam_tile $F8, $F8, $400,	$20
animation_frame_C6443A:.BYTE 3
		frame_oam_tile 0, $F0,	$3700, 0
		frame_oam_tile $F8, $F0, $3600, 0
		frame_oam_tile $F8, $F8, $600,	$20
animation_frame_C6444A:.BYTE 3
		frame_oam_tile $FE, $F0, $2100, 0
		frame_oam_tile $F6, $F0, $2000, 0
		frame_oam_tile $F6, $F8, 1, $20
animation_frame_C6445A:.BYTE 3
		frame_oam_tile 0, $F0,	$2300, 0
		frame_oam_tile $F8, $F0, $2200, 0
		frame_oam_tile $F8, $F8, $201,	$20
animation_frame_C6446A:.BYTE 3
		frame_oam_tile 0, $F0,	$2500, 0
		frame_oam_tile $F8, $F0, $2400, 0
		frame_oam_tile $F8, $F8, $401,	$20
animation_frame_C6447A:.BYTE 3
		frame_oam_tile 0, $F0,	$2700, 0
		frame_oam_tile $F8, $F0, $2600, 0
		frame_oam_tile $F8, $F8, $601,	$20
byte_C6448A:	.BYTE 8
		animation_frame animation_frame_C6440A, 9
		animation_frame animation_frame_C6441A, 9
		animation_frame animation_frame_C6442A, 9
		animation_frame animation_frame_C6443A, 9
		animation_frame animation_frame_C6444A, 9
		animation_frame animation_frame_C6445A, 9
		animation_frame animation_frame_C6446A, 9
		animation_frame animation_frame_C6447A, 9
animation_frame_C644AB:.BYTE 3
		frame_oam_tile 0, 0, $2300, 0
		frame_oam_tile $F8, 0,	$2200, 0
		frame_oam_tile $F8, $F0, $600,	$20
animation_frame_C644BB:.BYTE 3
		frame_oam_tile 0, $FF,	$2500, 0
		frame_oam_tile $F8, $FF, $2400, 0
		frame_oam_tile $F8, $EF, 1, $20
animation_frame_C644CB:.BYTE 3
		frame_oam_tile $F8, $FF, $3400, 0
		frame_oam_tile 0, $FF,	$3500, 0
		frame_oam_tile $F8, $EF, $201,	$20
animation_frame_C644DB:.BYTE 3
		frame_oam_tile $F8, 0,	$2700, $40
		frame_oam_tile 0, 0, $2600, $40
		frame_oam_tile $F8, $F0, $401,	$60
animation_frame_C644EB:.BYTE 3
		frame_oam_tile $F8, $FF, $3700, $40
		frame_oam_tile 0, $FF,	$3600, $40
		frame_oam_tile $F8, $EF, $601,	$60
animation_frame_C644FB:.BYTE 3
		frame_oam_tile $F8, $FF, $2301, $40
		frame_oam_tile 0, $FF,	$2201, $40
		frame_oam_tile $F8, $EF, $2001, $60
animation_frame_C6450B:.BYTE 3
		frame_oam_tile 0, 0, $2100, 0
		frame_oam_tile $F8, 0,	$2000, 0
		frame_oam_tile $F8, $F0, 0, $20
animation_frame_C6451B:.BYTE 3
		frame_oam_tile 0, $FF,	$3100, 0
		frame_oam_tile $F8, $FF, $3000, 0
		frame_oam_tile $F8, $EF, $200,	$20
animation_frame_C6452B:.BYTE 3
		frame_oam_tile $F8, $FF, $3200, 0
		frame_oam_tile 0, $FF,	$3300, 0
		frame_oam_tile $F8, $EF, $400,	$20
animation_frame_C6453B:.BYTE 3
		frame_oam_tile 0, 0, $2700, 0
		frame_oam_tile $F8, 0,	$2600, 0
		frame_oam_tile $F8, $F0, $401,	$20
animation_frame_C6454B:.BYTE 3
		frame_oam_tile 0, $FF,	$3700, 0
		frame_oam_tile $F8, $FF, $3600, 0
		frame_oam_tile $F8, $EF, $601,	$20
animation_frame_C6455B:.BYTE 3
		frame_oam_tile 0, $FF,	$2301, 0
		frame_oam_tile $F8, $FF, $2201, 0
		frame_oam_tile $F8, $EF, $2001, $20
byte_C6456B:	.BYTE 4
		animation_frame animation_frame_C644AB, $E
		animation_frame animation_frame_C644BB, $E
		animation_frame animation_frame_C644AB, $E
		animation_frame animation_frame_C644CB, $E
byte_C6457C:	.BYTE 4
		animation_frame animation_frame_C644DB, $E
		animation_frame animation_frame_C644EB, $E
		animation_frame animation_frame_C644DB, $E
		animation_frame animation_frame_C644FB, $E
byte_C6458D:	.BYTE 4
		animation_frame animation_frame_C6450B, $E
		animation_frame animation_frame_C6451B, $E
		animation_frame animation_frame_C6450B, $E
		animation_frame animation_frame_C6452B, $E
byte_C6459E:	.BYTE 4
		animation_frame animation_frame_C6453B, $E
		animation_frame animation_frame_C6454B, $E
		animation_frame animation_frame_C6453B, $E
		animation_frame animation_frame_C6455B, $E
animation_frame_C645AF:.BYTE 8
		frame_oam_tile $FE, $FF, $202,	$20
		frame_oam_tile $EE, $FF, 2, $20
		frame_oam_tile $E, $EF, $2400,	$20
		frame_oam_tile $FE, $EF, $2200, $20
		frame_oam_tile $EE, $EF, $2000, $20
		frame_oam_tile $E, $DF, $400, $20
		frame_oam_tile $FE, $DF, $200,	$20
		frame_oam_tile $EE, $DF, 0, $20
animation_frame_C645D8:.BYTE 8
		frame_oam_tile $EE, $F0, $2405, $20
		frame_oam_tile $EE, $E0, $2205, $20
		frame_oam_tile $FE, 0,	$202, $20
		frame_oam_tile $EE, 0,	2, $20
		frame_oam_tile $E, $F0, $2400,	$20
		frame_oam_tile $FE, $F0, $2200, $20
		frame_oam_tile $E, $E0, $400, $20
		frame_oam_tile $FE, $E0, $200,	$20
animation_frame_C64601:.BYTE 8
		frame_oam_tile $FE, $F0, $2600, $20
		frame_oam_tile $E, $F0, $2001,	$20
		frame_oam_tile $E, $E0, 1, $20
		frame_oam_tile $FE, $E0, $600,	$20
		frame_oam_tile $FE, 0,	$202, $20
		frame_oam_tile $EE, 0,	2, $20
		frame_oam_tile $EE, $F0, $2000, $20
		frame_oam_tile $EE, $E0, 0, $20
animation_frame_C6462A:.BYTE 8
		frame_oam_tile $10, $FC, $203,	$60
		frame_oam_tile $10, $EC, $2201, $60
		frame_oam_tile 0, $FC,	$403, $60
		frame_oam_tile 0, $EC,	$2401, $60
		frame_oam_tile 0, $DC,	$401, $60
		frame_oam_tile $F0, $DC, $601,	$60
		frame_oam_tile $F0, $EC, $2601, $60
		frame_oam_tile $F0, $FC, $603,	$60
animation_frame_C64653:.BYTE 8
		frame_oam_tile $F0, $DD, $201,	$60
		frame_oam_tile $10, $FD, $203,	$60
		frame_oam_tile $10, $ED, $2201, $60
		frame_oam_tile 0, $FD,	$403, $60
		frame_oam_tile 0, $ED,	$2401, $60
		frame_oam_tile 0, $DD,	$401, $60
		frame_oam_tile $F0, $ED, $2601, $60
		frame_oam_tile $F0, $FD, $603,	$60
animation_frame_C6467C:.BYTE 8
		frame_oam_tile $10, $FD, $2602, $60
		frame_oam_tile $10, $ED, $602,	$60
		frame_oam_tile 0, $FD,	$2003, $60
		frame_oam_tile 0, $ED,	3, $60
		frame_oam_tile 0, $DD,	$401, $60
		frame_oam_tile $F0, $DD, $601,	$60
		frame_oam_tile $F0, $ED, $2601, $60
		frame_oam_tile $F0, $FD, $603,	$60
animation_frame_C646A5:.BYTE $B
		frame_oam_tile 8, $DF,	$2402, $20
		frame_oam_tile $F8, $DF, $2202, $20
		frame_oam_tile $E8, $FF, $402,	$20
		frame_oam_tile $A, $10, $2204,	$20
		frame_oam_tile $F8, $F, $2004,	$20
		frame_oam_tile $A, 0, $204, $20
		frame_oam_tile $F8, $FF, 4, $20
		frame_oam_tile 8, $EF,	$2603, $20
		frame_oam_tile $F8, $EF, $2403, $20
		frame_oam_tile $E8, $EF, $2203, $20
		frame_oam_tile $E8, $DF, $2002, $20
animation_frame_C646DD:.BYTE $B
		frame_oam_tile $FC, $E0, $604,	$20
		frame_oam_tile $EC, $E0, $404,	$20
		frame_oam_tile $E8, 0,	$402, $20
		frame_oam_tile $A, $10, $2204,	$20
		frame_oam_tile $F8, $10, $2004, $20
		frame_oam_tile $A, 0, $204, $20
		frame_oam_tile $F8, 0,	4, $20
		frame_oam_tile 8, $E0,	$2402, $20
		frame_oam_tile 8, $F0,	$2603, $20
		frame_oam_tile $F8, $F0, $2403, $20
		frame_oam_tile $E8, $F0, $2203, $20
animation_frame_C64715:.BYTE 9
		frame_oam_tile $FC, $10, $2005, $20
		frame_oam_tile $FC, 0,	$2604, $20
		frame_oam_tile $EC, 0,	$2404, $20
		frame_oam_tile $C, $F0, $605, $20
		frame_oam_tile $FC, $F0, $405,	$20
		frame_oam_tile $EC, $F0, $205,	$20
		frame_oam_tile $C, $E0, $2402,	$20
		frame_oam_tile $FC, $E0, $2202, $20
		frame_oam_tile $EC, $E0, $2002, $20
animation_frame_C64743:.BYTE 8
		frame_oam_tile 0, $DC,	$601, $20
		frame_oam_tile 0, $EC,	$2601, $20
		frame_oam_tile 0, $FC,	$603, $20
		frame_oam_tile $F0, $FC, $403,	$20
		frame_oam_tile $F0, $EC, $2401, $20
		frame_oam_tile $F0, $DC, $401,	$20
		frame_oam_tile $E0, $FC, $203,	$20
		frame_oam_tile $E0, $EC, $2201, $20
animation_frame_C6476C:.BYTE 8
		frame_oam_tile 0, $DD,	$201, $20
		frame_oam_tile 0, $ED,	$2601, $20
		frame_oam_tile 0, $FD,	$603, $20
		frame_oam_tile $F0, $FD, $403,	$20
		frame_oam_tile $F0, $ED, $2401, $20
		frame_oam_tile $F0, $DD, $401,	$20
		frame_oam_tile $E0, $FD, $203,	$20
		frame_oam_tile $E0, $ED, $2201, $20
animation_frame_C64795:.BYTE 8
		frame_oam_tile $E0, $FD, $2602, $20
		frame_oam_tile $E0, $ED, $602,	$20
		frame_oam_tile $F0, $FD, $2003, $20
		frame_oam_tile $F0, $ED, 3, $20
		frame_oam_tile 0, $DD,	$601, $20
		frame_oam_tile 0, $ED,	$2601, $20
		frame_oam_tile 0, $FD,	$603, $20
		frame_oam_tile $F0, $DD, $401,	$20
byte_C647BE:	.BYTE 2
		animation_frame animation_frame_C645AF, $10
		animation_frame animation_frame_C645D8, $10
byte_C647C7:	.BYTE 2
		animation_frame animation_frame_C6462A, $10
		animation_frame animation_frame_C64653, $10
byte_C647D0:	.BYTE 2
		animation_frame animation_frame_C646A5, $10
		animation_frame animation_frame_C646DD, $10
byte_C647D9:	.BYTE 2
		animation_frame animation_frame_C64743, $10
		animation_frame animation_frame_C6476C, $10
byte_C647E2:	.BYTE 1
		animation_frame animation_frame_C64601, $FF
byte_C647E7:	.BYTE 1
		animation_frame animation_frame_C6467C, $FF
byte_C647EC:	.BYTE 1
		animation_frame animation_frame_C64715, $FF
byte_C647F1:	.BYTE 1
		animation_frame animation_frame_C64795, $FF
animation_frame_C647F6:.BYTE 3
		frame_oam_tile $F0, $F8, $2201, $60
		frame_oam_tile 0, $F8,	$2201, $20
		frame_oam_tile $F8, $E8, 1, $20
animation_frame_C64806:.BYTE 3
		frame_oam_tile 0, $F8,	$2001, $60
		frame_oam_tile $F0, $F8, $2001, $20
		frame_oam_tile $F8, $E8, 1, $20
animation_frame_C64816:.BYTE 4
		frame_oam_tile $F0, $F8, $200,	$E0
		frame_oam_tile $F0, $E8, $200,	$60
		frame_oam_tile 0, $F8,	$2000, $60
		frame_oam_tile 0, $E8,	0, $60
animation_frame_C6482B:.BYTE 4
		frame_oam_tile $F0, $F8, $2200, $E0
		frame_oam_tile $F0, $E8, $2200, $60
		frame_oam_tile 0, $F8,	$2000, $60
		frame_oam_tile 0, $E8,	0, $60
animation_frame_C64840:.BYTE 4
		frame_oam_tile 0, $E8,	$400, $60
		frame_oam_tile $F0, $E8, $400,	$20
		frame_oam_tile 0, $F8,	$2600, $20
		frame_oam_tile $F0, $F8, $2400, $20
animation_frame_C64855:.BYTE 4
		frame_oam_tile $F0, $E8, $600,	$60
		frame_oam_tile 0, $E8,	$600, $20
		frame_oam_tile 0, $F8,	$2600, $20
		frame_oam_tile $F0, $F8, $2400, $20
animation_frame_C6486A:.BYTE 4
		frame_oam_tile 0, $F8,	$200, $A0
		frame_oam_tile 0, $E8,	$200, $20
		frame_oam_tile $F0, $F8, $2000, $20
		frame_oam_tile $F0, $E8, 0, $20
animation_frame_C6487F:.BYTE 4
		frame_oam_tile 0, $F8,	$2200, $A0
		frame_oam_tile 0, $E8,	$2200, $20
		frame_oam_tile $F0, $F8, $2000, $20
		frame_oam_tile $F0, $E8, 0, $20
byte_C64894:	.BYTE 2
		animation_frame animation_frame_C647F6, 2
		animation_frame animation_frame_C64806, 3
byte_C6489D:	.BYTE 2
		animation_frame animation_frame_C64816, 3
		animation_frame animation_frame_C6482B, 2
byte_C648A6:	.BYTE 2
		animation_frame animation_frame_C64840, 2
		animation_frame animation_frame_C64855, 3
byte_C648AF:	.BYTE 2
		animation_frame animation_frame_C6486A, 3
		animation_frame animation_frame_C6487F, 2
animation_frame_C648B8:.BYTE 1
		frame_oam_tile $F8, $F8, 0, $20
animation_frame_C648BE:.BYTE 1
		frame_oam_tile $F8, $F8, $200,	$20
animation_frame_C648C4:.BYTE 1
		frame_oam_tile $F8, $F8, $2200, $20
animation_frame_C648CA:.BYTE 1
		frame_oam_tile $F8, $F8, $2000, $20
animation_frame_C648D0:.BYTE 3
		frame_oam_tile 0, $F5,	$100, 0
		frame_oam_tile $F8, $F5, 0, 0
		frame_oam_tile $F8, $FD, $2600, $20
animation_frame_C648E0:.BYTE 3
		frame_oam_tile $F8, $FB, $2400, $20
		frame_oam_tile 0, $F3,	$100, 0
		frame_oam_tile $F8, $F3, 0, 0
animation_frame_C648F0:.BYTE 3
		frame_oam_tile 0, $F2,	$100, 0
		frame_oam_tile $F8, $F2, 0, 0
		frame_oam_tile $F8, $FA, $600,	$20
animation_frame_C64900:.BYTE 3
		frame_oam_tile $F8, $F8, $400,	$20
		frame_oam_tile 0, $F0,	$100, 0
		frame_oam_tile $F8, $F0, 0, 0
byte_C64910:	.BYTE 9
		animation_frame animation_frame_C648B8, 8
		animation_frame animation_frame_C648BE, 8
		animation_frame animation_frame_C648C4, 8
		animation_frame animation_frame_C648CA, 8
		animation_frame animation_frame_C648B8, 8
		animation_frame animation_frame_C648D0, 3
		animation_frame animation_frame_C648E0, 3
		animation_frame animation_frame_C648F0, 3
		animation_frame animation_frame_C64900, 5
animation_frame_C64935:.BYTE 1
		frame_oam_tile $F8, $F8, 0, $20
animation_frame_C6493B:.BYTE 1
		frame_oam_tile $F8, $F8, $200,	$20
animation_frame_C64941:.BYTE 1
		frame_oam_tile $F8, $F8, $400,	$20
animation_frame_C64947:.BYTE 1
		frame_oam_tile $F8, $F8, $600,	$20
animation_frame_C6494D:.BYTE 1
		frame_oam_tile $F8, $F8, 1, $20
animation_frame_C64953:.BYTE 1
		frame_oam_tile $F8, $F8, $201,	$20
animation_frame_C64959:.BYTE 1
		frame_oam_tile $F8, $F8, $401,	$20
animation_frame_C6495F:.BYTE 1
		frame_oam_tile $F8, $F8, $601,	$20
animation_frame_C64965:.BYTE 1
		frame_oam_tile $F8, $F8, $2000, $20
animation_frame_C6496B:.BYTE 1
		frame_oam_tile $F8, $F8, $2200, $20
animation_frame_C64971:.BYTE 1
		frame_oam_tile $F8, $F8, $2400, $20
animation_frame_C64977:.BYTE 1
		frame_oam_tile $F8, $F8, $2600, $20
animation_frame_C6497D:.BYTE 1
		frame_oam_tile $F8, $F8, $2001, $20
animation_frame_C64983:.BYTE 1
		frame_oam_tile $F8, $F8, $2201, $20
animation_frame_C64989:.BYTE 1
		frame_oam_tile $F8, $F8, $2401, $20
animation_frame_C6498F:.BYTE 1
		frame_oam_tile $F8, $F8, $2601, $20
animation_frame_C64995:.BYTE 1
		frame_oam_tile $F8, $F8, 2, $20
animation_frame_C6499B:.BYTE 1
		frame_oam_tile $F8, $F8, $202,	$20
animation_frame_C649A1:.BYTE 1
		frame_oam_tile $F8, $F8, $402,	$20
animation_frame_C649A7:.BYTE 1
		frame_oam_tile $F8, $F8, $602,	$20
animation_frame_C649AD:.BYTE 1
		frame_oam_tile $F8, $F8, $2401, $60
animation_frame_C649B3:.BYTE 1
		frame_oam_tile $F8, $F8, $2601, $60
animation_frame_C649B9:.BYTE 1
		frame_oam_tile $F8, $F8, 2, $60
animation_frame_C649BF:.BYTE 1
		frame_oam_tile $F8, $F8, $202,	$60
animation_frame_C649C5:.BYTE 1
		frame_oam_tile $F8, $F8, $402,	$60
animation_frame_C649CB:.BYTE 1
		frame_oam_tile $F8, $F8, $602,	$60
byte_C649D1:	.BYTE 6
		animation_frame animation_frame_C64971, $10
		animation_frame animation_frame_C64977, 2
		animation_frame animation_frame_C6497D, 2
		animation_frame animation_frame_C64983, 2
		animation_frame animation_frame_C6497D, 2
		animation_frame animation_frame_C64977, 2
byte_C649EA:	.BYTE $A
		animation_frame animation_frame_C649AD, 2
		animation_frame animation_frame_C649B3, 2
		animation_frame animation_frame_C649B9, 2
		animation_frame animation_frame_C649BF, 2
		animation_frame animation_frame_C649C5, 2
		animation_frame animation_frame_C649CB, 2
		animation_frame animation_frame_C649C5, 2
		animation_frame animation_frame_C649BF, 2
		animation_frame animation_frame_C649B9, 2
		animation_frame animation_frame_C649B3, 2
byte_C64A13:	.BYTE $12
		animation_frame animation_frame_C64935, 1
		animation_frame animation_frame_C6493B, 1
		animation_frame animation_frame_C64941, 1
		animation_frame animation_frame_C64947, 1
		animation_frame animation_frame_C6494D, 1
		animation_frame animation_frame_C64953, 1
		animation_frame animation_frame_C64959, 1
		animation_frame animation_frame_C6495F, 1
		animation_frame animation_frame_C64965, 1
		animation_frame animation_frame_C6496B, 1
		animation_frame animation_frame_C64965, 1
		animation_frame animation_frame_C6495F, 1
		animation_frame animation_frame_C64959, 1
		animation_frame animation_frame_C64953, 1
		animation_frame animation_frame_C6494D, 1
		animation_frame animation_frame_C64947, 1
		animation_frame animation_frame_C64941, 1
		animation_frame animation_frame_C6493B, 1
byte_C64A5C:	.BYTE $A
		animation_frame animation_frame_C64989, 2
		animation_frame animation_frame_C6498F, 2
		animation_frame animation_frame_C64995, 2
		animation_frame animation_frame_C6499B, 2
		animation_frame animation_frame_C649A1, 2
		animation_frame animation_frame_C649A7, 2
		animation_frame animation_frame_C649A1, 2
		animation_frame animation_frame_C6499B, 2
		animation_frame animation_frame_C64995, 2
		animation_frame animation_frame_C6498F, 2
animation_frame_C64A85:.BYTE 3
		frame_oam_tile 0, 0, $1100, 0
		frame_oam_tile $F8, 0,	$1000, 0
		frame_oam_tile $F8, $F0, $2000, $20
animation_frame_C64A95:.BYTE 3
		frame_oam_tile 0, 0, $300, 0
		frame_oam_tile $F8, 0,	$200, 0
		frame_oam_tile $F8, $F0, $2000, $20
		.BYTE 3
		.BYTE 0, 0, 0, 1, 0
		.BYTE $F8, 0, 0, 0, 0
		.BYTE $F8, $F0,	0, $20,	$20
animation_frame_C64AB5:.BYTE 2
		frame_oam_tile $F8, $FD, $400,	$20
		frame_oam_tile $F8, $ED, $2000, $20
animation_frame_C64AC0:.BYTE 2
		frame_oam_tile $F8, $FB, $2600, $20
		frame_oam_tile $F8, $EB, $2000, $20
animation_frame_C64ACB:.BYTE 2
		frame_oam_tile $F8, $FC, $600,	$20
		frame_oam_tile $F8, $EC, $2000, $20
animation_frame_C64AD6:.BYTE 2
		frame_oam_tile $F8, $F8, $2200, $20
		frame_oam_tile $F8, $E8, $2000, $20
animation_frame_C64AE1:.BYTE 2
		frame_oam_tile $F8, $FC, $2400, $20
		frame_oam_tile $F8, $EC, $2000, $20
animation_frame_C64AEC:.BYTE 3
		frame_oam_tile 0, 0, $1300, 0
		frame_oam_tile $F8, 0,	$1200, 0
		frame_oam_tile $F8, $F0, $2000, $20
byte_C64AFC:	.BYTE $D
		animation_frame animation_frame_C64A85, $15
		animation_frame animation_frame_C64A95, 7
		animation_frame animation_frame_C64AB5, 7
		animation_frame animation_frame_C64AC0, 7
		animation_frame animation_frame_C64AB5, 7
		animation_frame animation_frame_C64A95, 7
		animation_frame animation_frame_C64A85, $15
		animation_frame animation_frame_C64ACB, $A
		animation_frame animation_frame_C64AD6, $C
		animation_frame animation_frame_C64ACB, $A
		animation_frame animation_frame_C64A85, $15
		animation_frame animation_frame_C64AE1, $D
		animation_frame animation_frame_C64AEC, $C
animation_frame_C64B31:.BYTE 3
		frame_oam_tile 0, 6, $2100, 0
		frame_oam_tile $F8, 6,	$2000, 0
		frame_oam_tile $F8, $F6, 0, $20
animation_frame_C64B41:.BYTE 3
		frame_oam_tile $F8, $F5, $2600, $20
		frame_oam_tile 0, 5, $3100, 0
		frame_oam_tile $F8, 5,	$3000, 0
animation_frame_C64B51:.BYTE 3
		frame_oam_tile $F8, $F5, $2001, $20
		frame_oam_tile 0, 5, $3100, 0
		frame_oam_tile $F8, 5,	$3000, 0
animation_frame_C64B61:.BYTE 3
		frame_oam_tile $F8, $F5, $2201, $20
		frame_oam_tile 0, 5, $3100, 0
		frame_oam_tile $F8, 5,	$3000, 0
animation_frame_C64B71:.BYTE 3
		frame_oam_tile $F8, $F5, $2401, $20
		frame_oam_tile 0, 5, $3100, 0
		frame_oam_tile $F8, 5,	$3000, 0
animation_frame_C64B81:.BYTE 3
		frame_oam_tile $F8, $F5, $2601, $20
		frame_oam_tile 0, 5, $3100, 0
		frame_oam_tile $F8, 5,	$3000, 0
animation_frame_C64B91:.BYTE 3
		frame_oam_tile $F8, $F5, 2, $20
		frame_oam_tile 0, 5, $3100, 0
		frame_oam_tile $F8, 5,	$3000, 0
animation_frame_C64BA1:.BYTE 3
		frame_oam_tile $F8, $F5, $202,	$20
		frame_oam_tile 0, 5, $3100, 0
		frame_oam_tile $F8, 5,	$3000, 0
animation_frame_C64BB1:.BYTE 3
		frame_oam_tile $F8, $F5, $402,	$20
		frame_oam_tile 0, 5, $3100, 0
		frame_oam_tile $F8, 5,	$3000, 0
animation_frame_C64BC1:.BYTE 3
		frame_oam_tile $F8, $F6, $200,	$20
		frame_oam_tile 0, 6, $2100, 0
		frame_oam_tile $F8, 6,	$2000, 0
animation_frame_C64BD1:.BYTE 3
		frame_oam_tile $F8, $F6, $400,	$20
		frame_oam_tile 0, 6, $2100, 0
		frame_oam_tile $F8, 6,	$2000, 0
animation_frame_C64BE1:.BYTE 3
		frame_oam_tile $F8, $F6, $600,	$20
		frame_oam_tile 0, 6, $2100, 0
		frame_oam_tile $F8, 6,	$2000, 0
animation_frame_C64BF1:.BYTE 3
		frame_oam_tile $F8, $F6, 1, $20
		frame_oam_tile 0, 6, $2100, 0
		frame_oam_tile $F8, 6,	$2000, 0
animation_frame_C64C01:.BYTE 3
		frame_oam_tile $F8, $F6, $201,	$20
		frame_oam_tile 0, 6, $2100, 0
		frame_oam_tile $F8, 6,	$2000, 0
animation_frame_C64C11:.BYTE 3
		frame_oam_tile $F8, $F6, $401,	$20
		frame_oam_tile 0, 6, $2100, 0
		frame_oam_tile $F8, 6,	$2000, 0
animation_frame_C64C21:.BYTE 3
		frame_oam_tile $F8, $F6, $601,	$20
		frame_oam_tile 0, 6, $2100, 0
		frame_oam_tile $F8, 6,	$2000, 0
animation_frame_C64C31:.BYTE 3
		frame_oam_tile $F8, $F6, $2200, $20
		frame_oam_tile 0, 6, $2100, 0
		frame_oam_tile $F8, 6,	$2000, 0
animation_frame_C64C41:.BYTE 3
		frame_oam_tile $F8, $F6, $2400, $20
		frame_oam_tile 0, 6, $2100, 0
		frame_oam_tile $F8, 6,	$2000, 0
byte_C64C51:	.BYTE 9
		animation_frame animation_frame_C64B31, 4
		animation_frame animation_frame_C64BB1, 4
		animation_frame animation_frame_C64BA1, 4
		animation_frame animation_frame_C64B91, 4
		animation_frame animation_frame_C64B81, 4
		animation_frame animation_frame_C64B71, 5
		animation_frame animation_frame_C64B61, 6
		animation_frame animation_frame_C64B51, 7
		animation_frame animation_frame_C64B41, $A
byte_C64C76:	.BYTE $A
		animation_frame animation_frame_C64B31, 8
		animation_frame animation_frame_C64C41, 5
		animation_frame animation_frame_C64C31, 5
		animation_frame animation_frame_C64C21, 5
		animation_frame animation_frame_C64C11, 4
		animation_frame animation_frame_C64C01, 4
		animation_frame animation_frame_C64BF1, 4
		animation_frame animation_frame_C64BE1, 5
		animation_frame animation_frame_C64BD1, 5
		animation_frame animation_frame_C64BC1, 5
byte_C64C9F:	.BYTE 9
		animation_frame animation_frame_C64B31, 4
		animation_frame animation_frame_C64B41, $A
		animation_frame animation_frame_C64B51, 7
		animation_frame animation_frame_C64B61, 6
		animation_frame animation_frame_C64B71, 5
		animation_frame animation_frame_C64B81, 4
		animation_frame animation_frame_C64B91, 4
		animation_frame animation_frame_C64BA1, 4
		animation_frame animation_frame_C64BB1, 4
byte_C64CC4:	.BYTE $A
		animation_frame animation_frame_C64B31, 8
		animation_frame animation_frame_C64BC1, 5
		animation_frame animation_frame_C64BD1, 5
		animation_frame animation_frame_C64BE1, 5
		animation_frame animation_frame_C64BF1, 4
		animation_frame animation_frame_C64C01, 4
		animation_frame animation_frame_C64C11, 4
		animation_frame animation_frame_C64C21, 5
		animation_frame animation_frame_C64C31, 5
		animation_frame animation_frame_C64C41, 5
animation_frame_C64CED:.BYTE 3
		frame_oam_tile 0, 0, $2700, 0
		frame_oam_tile $F8, 0,	$2600, 0
		frame_oam_tile $F8, $F0, $600,	$20
animation_frame_C64CFD:.BYTE 3
		frame_oam_tile 0, $FF,	$2101, 0
		frame_oam_tile $F8, $FF, $2001, 0
		frame_oam_tile $F8, $EF, 1, $20
animation_frame_C64D0D:.BYTE 3
		frame_oam_tile 0, $FF,	$2301, 0
		frame_oam_tile $F8, $FF, $2201, 0
		frame_oam_tile $F8, $EF, $201,	$20
animation_frame_C64D1D:.BYTE 3
		frame_oam_tile 0, 0, $3101, 0
		frame_oam_tile $F8, 0,	$3001, 0
		frame_oam_tile $F8, $F0, $401,	$20
animation_frame_C64D2D:.BYTE 3
		frame_oam_tile 0, $FF,	$3301, 0
		frame_oam_tile $F8, $FF, $3201, 0
		frame_oam_tile $F8, $EF, $601,	$20
animation_frame_C64D3D:.BYTE 3
		frame_oam_tile $F8, $FF, $3000, 0
		frame_oam_tile 0, $FF,	$3100, 0
		frame_oam_tile $F8, $EF, 2, $20
animation_frame_C64D4D:.BYTE 3
		frame_oam_tile $F8, $FF, $2200, 0
		frame_oam_tile 0, $FF,	$2300, 0
		frame_oam_tile $F8, $EF, $200,	$20
animation_frame_C64D5D:.BYTE 3
		frame_oam_tile 0, 0, $2100, 0
		frame_oam_tile $F8, 0,	$2000, 0
		frame_oam_tile $F8, $F0, 0, $20
animation_frame_C64D6D:.BYTE 3
		frame_oam_tile 0, $FF,	$2500, 0
		frame_oam_tile $F8, $FF, $2400, 0
		frame_oam_tile $F8, $EF, $400,	$20
animation_frame_C64D7D:.BYTE 3
		frame_oam_tile $F8, 0,	$3200, 0
		frame_oam_tile 0, 0, $3300, 0
		frame_oam_tile $F8, $F0, $202,	$20
animation_frame_C64D8D:.BYTE 3
		frame_oam_tile $F8, $FF, $3400, 0
		frame_oam_tile 0, $FF,	$3500, 0
		frame_oam_tile $F8, $EF, $402,	$20
animation_frame_C64D9D:.BYTE 3
		frame_oam_tile $F8, $FF, $3600, 0
		frame_oam_tile 0, $FF,	$3700, 0
		frame_oam_tile $F8, $EF, $602,	$20
animation_frame_C64DAD:.BYTE 3
		frame_oam_tile 0, 0, $3300, 0
		frame_oam_tile $F8, 0,	$3200, 0
		frame_oam_tile $F8, $F0, $2002, $20
animation_frame_C64DBD:.BYTE 3
		frame_oam_tile 0, $FF,	$3500, 0
		frame_oam_tile $F8, $FF, $3400, 0
		frame_oam_tile $F8, $EF, $2401, $20
animation_frame_C64DCD:.BYTE 3
		frame_oam_tile 0, $FF,	$3700, 0
		frame_oam_tile $F8, $FF, $3600, 0
		frame_oam_tile $F8, $EF, $2601, $20
animation_frame_C64DDD:.BYTE 3
		frame_oam_tile 0, 0, $3200, $40
		frame_oam_tile $F8, 0,	$3300, $40
		frame_oam_tile $F8, $F0, $202,	$60
animation_frame_C64DED:.BYTE 3
		frame_oam_tile 0, 0, $3200, $40
		frame_oam_tile $F8, 0,	$3300, $40
		frame_oam_tile $F8, $F0, $2002, $60
animation_frame_C64DFD:.BYTE 3
		frame_oam_tile 0, $FF,	$3400, $40
		frame_oam_tile $F8, $FF, $3500, $40
		frame_oam_tile $F8, $EF, $402,	$60
animation_frame_C64E0D:.BYTE 3
		frame_oam_tile 0, $FF,	$3400, $40
		frame_oam_tile $F8, $FF, $3500, $40
		frame_oam_tile $F8, $EF, $2401, $60
animation_frame_C64E1D:.BYTE 3
		frame_oam_tile 0, $FF,	$3600, $40
		frame_oam_tile $F8, $FF, $3700, $40
		frame_oam_tile $F8, $EF, $602,	$60
animation_frame_C64E2D:.BYTE 3
		frame_oam_tile 0, $FF,	$3600, $40
		frame_oam_tile $F8, $FF, $3700, $40
		frame_oam_tile $F8, $EF, $2601, $60
byte_C64E3D:	.BYTE 4
		animation_frame animation_frame_C64D1D, $E
		animation_frame animation_frame_C64D2D, $E
		animation_frame animation_frame_C64D1D, $E
		animation_frame animation_frame_C64D3D, $E
byte_C64E4E:	.BYTE 8
		animation_frame animation_frame_C64D7D, 7
		animation_frame animation_frame_C64DAD, 7
		animation_frame animation_frame_C64D8D, 7
		animation_frame animation_frame_C64DBD, 7
		animation_frame animation_frame_C64D7D, 7
		animation_frame animation_frame_C64DAD, 7
		animation_frame animation_frame_C64D9D, 7
		animation_frame animation_frame_C64DCD, 7
byte_C64E6F:	.BYTE 8
		animation_frame animation_frame_C64D5D, 7
		animation_frame animation_frame_C64CED, 7
		animation_frame animation_frame_C64D4D, 7
		animation_frame animation_frame_C64CFD, 7
		animation_frame animation_frame_C64D5D, 7
		animation_frame animation_frame_C64CED, 7
		animation_frame animation_frame_C64D6D, 7
		animation_frame animation_frame_C64D0D, 7
byte_C64E90:	.BYTE 8
		animation_frame animation_frame_C64DDD, 7
		animation_frame animation_frame_C64DED, 7
		animation_frame animation_frame_C64DFD, 7
		animation_frame animation_frame_C64E0D, 7
		animation_frame animation_frame_C64DDD, 7
		animation_frame animation_frame_C64DED, 7
		animation_frame animation_frame_C64E1D, 7
		animation_frame animation_frame_C64E2D, 7
animation_frame_C64EB1:.BYTE 3
		frame_oam_tile 0, 0, $2301, 0
		frame_oam_tile $F8, 0,	$2201, 0
		frame_oam_tile $F8, $F0, $201,	$20
animation_frame_C64EC1:.BYTE 3
		frame_oam_tile $F8, $EF, 1, $20
		frame_oam_tile 0, $FF,	$2101, 0
		frame_oam_tile $F8, $FF, $2001, 0
animation_frame_C64ED1:.BYTE 3
		frame_oam_tile $F8, $EF, $600,	$20
		frame_oam_tile $F8, $FF, $2600, 0
		frame_oam_tile 0, $FF,	$2700, 0
animation_frame_C64EE1:.BYTE 3
		frame_oam_tile $F8, $FF, $2501, $40
		frame_oam_tile 0, $FF,	$2401, $40
		frame_oam_tile $F8, $EF, $401,	$60
animation_frame_C64EF1:.BYTE 3
		frame_oam_tile $F8, $EF, $601,	$60
		frame_oam_tile 0, $FF,	$2601, $40
		frame_oam_tile $F8, $FF, $2701, $40
animation_frame_C64F01:.BYTE 3
		frame_oam_tile $F8, 0,	$2102, $40
		frame_oam_tile 0, 0, $2002, $40
		frame_oam_tile $F8, $F0, 2, $60
animation_frame_C64F11:.BYTE 3
		frame_oam_tile $F8, $F0, $400,	$20
		frame_oam_tile 0, 0, $2500, 0
		frame_oam_tile $F8, 0,	$2400, 0
animation_frame_C64F21:.BYTE 3
		frame_oam_tile 0, $FF,	$2300, 0
		frame_oam_tile $F8, $FF, $2200, 0
		frame_oam_tile $F8, $EF, $200,	$20
animation_frame_C64F31:.BYTE 3
		frame_oam_tile $F8, $EF, 0, $20
		frame_oam_tile 0, $FF,	$2100, 0
		frame_oam_tile $F8, $FF, $2000, 0
animation_frame_C64F41:.BYTE 3
		frame_oam_tile $F8, $F0, 2, $20
		frame_oam_tile 0, 0, $2102, 0
		frame_oam_tile $F8, 0,	$2002, 0
animation_frame_C64F51:.BYTE 3
		frame_oam_tile $F8, $EF, $601,	$20
		frame_oam_tile 0, $FF,	$2701, 0
		frame_oam_tile $F8, $FF, $2601, 0
animation_frame_C64F61:.BYTE 3
		frame_oam_tile $F8, $EF, $401,	$20
		frame_oam_tile 0, $FF,	$2501, 0
		frame_oam_tile $F8, $FF, $2401, 0
animation_frame_C64F71:.BYTE 1
		frame_oam_tile $F8, $F8, $202,	$20
animation_frame_C64F77:.BYTE 1
		frame_oam_tile $F8, $F8, $402,	$20
animation_frame_C64F7D:.BYTE 3
		frame_oam_tile 0, $F8,	$3300, 0
		frame_oam_tile 0, 0, $3700, 0
		frame_oam_tile $F8, 0,	$3600, 0
animation_frame_C64F8D:.BYTE 3
		frame_oam_tile $F8, $F8, $3400, 0
		frame_oam_tile 0, 0, $3101, 0
		frame_oam_tile $F8, 0,	$3001, 0
animation_frame_C64F9D:.BYTE 2
		frame_oam_tile 0, 0, $3301, 0
		frame_oam_tile $F8, 0,	$3201, 0
animation_frame_C64FA8:.BYTE 2
		frame_oam_tile 0, 0, $3501, 0
		frame_oam_tile $F8, 0,	$3401, 0
animation_frame_C64FB3:.BYTE 2
		frame_oam_tile 0, 0, $3701, 0
		frame_oam_tile $F8, 0,	$3601, 0
animation_frame_C64FBE:.BYTE 2
		frame_oam_tile 0, 0, $3102, 0
		frame_oam_tile $F8, 0,	$3002, 0
animation_frame_C64FC9:.BYTE 2
		frame_oam_tile 0, 0, $3100, 0
		frame_oam_tile $F8, 0,	$3000, 0
animation_frame_C64FD4:.BYTE 1
		frame_oam_tile $F8, $F8, $602,	$20
animation_frame_C64FDA:.BYTE 1
		frame_oam_tile $F8, $F8, $2402, $20
animation_frame_C64FE0:.BYTE 3
		frame_oam_tile 0, 0, $3100, 0
		frame_oam_tile $F8, 0,	$3000, 0
		frame_oam_tile $F8, $F0, $2602, $20
animation_frame_C64FF0:.BYTE 3
		frame_oam_tile 0, 0, $3100, 0
		frame_oam_tile $F8, 0,	$3000, 0
		frame_oam_tile $F8, $EE, $2602, $20
animation_frame_C65000:.BYTE 3
		frame_oam_tile 0, 0, $3100, 0
		frame_oam_tile $F8, 0,	$3000, 0
		frame_oam_tile $F8, $EB, $2602, $20
animation_frame_C65010:.BYTE 1
		frame_oam_tile $F8, $F6, $2202, $20
byte_C65016:	.BYTE 4
		animation_frame animation_frame_C64EB1, 9
		animation_frame animation_frame_C64EC1, $10
		animation_frame animation_frame_C64EB1, 9
		animation_frame animation_frame_C64ED1, $10
byte_C65027:	.BYTE 4
		animation_frame animation_frame_C64F01, 9
		animation_frame animation_frame_C64EE1, $10
		animation_frame animation_frame_C64F01, 9
		animation_frame animation_frame_C64EF1, $10
byte_C65038:	.BYTE 4
		animation_frame animation_frame_C64F11, 9
		animation_frame animation_frame_C64F21, $10
		animation_frame animation_frame_C64F11, 9
		animation_frame animation_frame_C64F31, $10
byte_C65049:	.BYTE 4
		animation_frame animation_frame_C64F41, 9
		animation_frame animation_frame_C64F51, $10
		animation_frame animation_frame_C64F41, 9
		animation_frame animation_frame_C64F61, $10
byte_C6505A:	.BYTE $B
		animation_frame animation_frame_C64F11, $20
		animation_frame animation_frame_C65010, 8
		animation_frame animation_frame_C64F71, 7
		animation_frame animation_frame_C64F77, 7
		animation_frame animation_frame_C64F7D, 7
		animation_frame animation_frame_C64F8D, 6
		animation_frame animation_frame_C64F9D, 5
		animation_frame animation_frame_C64FA8, 5
		animation_frame animation_frame_C64FB3, 5
		animation_frame animation_frame_C64FBE, 5
		animation_frame animation_frame_C64FC9, $30
byte_C65087:	.BYTE $A
		animation_frame animation_frame_C64FC9, $20
		animation_frame animation_frame_C64FD4, 8
		animation_frame animation_frame_C64FDA, 6
		animation_frame animation_frame_C64FE0, 4
		animation_frame animation_frame_C64FF0, 4
		animation_frame animation_frame_C65000, $C
		animation_frame animation_frame_C64FF0, 5
		animation_frame animation_frame_C64FE0, 4
		animation_frame animation_frame_C65010, $10
		animation_frame animation_frame_C64F11, $20
animation_frame_C650B0:.BYTE 3
		frame_oam_tile 0, 0, $701, 0
		frame_oam_tile $F8, 0,	$601, 0
		frame_oam_tile $F8, $F0, $2200, $20
animation_frame_C650C0:.BYTE 3
		frame_oam_tile 0, 0, $701, 0
		frame_oam_tile $F8, 0,	$601, 0
		frame_oam_tile $F8, $F0, $2000, $20
animation_frame_C650D0:.BYTE 2
		frame_oam_tile $FC, 0,	$1601, 0
		frame_oam_tile $F8, $EF, $2200, $20
animation_frame_C650DB:.BYTE 2
		frame_oam_tile $FC, 0,	$1601, 0
		frame_oam_tile $F8, $EF, $2000, $20
animation_frame_C650E6:.BYTE 2
		frame_oam_tile $FC, 0,	$1701, 0
		frame_oam_tile $F8, $EE, $2200, $20
animation_frame_C650F1:.BYTE 2
		frame_oam_tile $FC, 0,	$1701, 0
		frame_oam_tile $F8, $EE, $2000, $20
animation_frame_C650FC:.BYTE 3
		frame_oam_tile 0, 0, $701, 0
		frame_oam_tile $F8, 0,	$601, 0
		frame_oam_tile $F8, $F0, $600,	$60
animation_frame_C6510C:.BYTE 3
		frame_oam_tile 0, 0, $701, 0
		frame_oam_tile $F8, 0,	$601, 0
		frame_oam_tile $F8, $F0, 1, $60
animation_frame_C6511C:.BYTE 2
		frame_oam_tile $FC, 0,	$1601, 0
		frame_oam_tile $F8, $EF, $600,	$60
animation_frame_C65127:.BYTE 2
		frame_oam_tile $FC, 0,	$1601, 0
		frame_oam_tile $F8, $EF, 1, $60
animation_frame_C65132:.BYTE 2
		frame_oam_tile $FC, 0,	$1701, 0
		frame_oam_tile $F8, $EE, $600,	$60
animation_frame_C6513D:.BYTE 2
		frame_oam_tile $FC, 0,	$1701, 0
		frame_oam_tile $F8, $EE, 1, $60
animation_frame_C65148:.BYTE 3
		frame_oam_tile 0, 0, $701, 0
		frame_oam_tile $F8, 0,	$601, 0
		frame_oam_tile $F8, $F0, $201,	$20
animation_frame_C65158:.BYTE 3
		frame_oam_tile 0, 0, $701, 0
		frame_oam_tile $F8, 0,	$601, 0
		frame_oam_tile $F8, $F0, $401,	$20
animation_frame_C65168:.BYTE 2
		frame_oam_tile $FC, 0,	$1601, 0
		frame_oam_tile $F8, $EF, $201,	$20
animation_frame_C65173:.BYTE 2
		frame_oam_tile $FC, 0,	$1601, 0
		frame_oam_tile $F8, $EF, $401,	$20
animation_frame_C6517E:.BYTE 2
		frame_oam_tile $FC, 0,	$1701, 0
		frame_oam_tile $F8, $EE, $201,	$20
animation_frame_C65189:.BYTE 2
		frame_oam_tile $FC, 0,	$1701, 0
		frame_oam_tile $F8, $EE, $401,	$20
animation_frame_C65194:.BYTE 3
		frame_oam_tile 0, 0, $701, 0
		frame_oam_tile $F8, 0,	$601, 0
		frame_oam_tile $F8, $F0, $600,	$20
animation_frame_C651A4:.BYTE 3
		frame_oam_tile 0, 0, $701, 0
		frame_oam_tile $F8, 0,	$601, 0
		frame_oam_tile $F8, $F0, 1, $20
animation_frame_C651B4:.BYTE 2
		frame_oam_tile $FC, 0,	$1601, 0
		frame_oam_tile $F8, $EF, $600,	$20
animation_frame_C651BF:.BYTE 2
		frame_oam_tile $FC, 0,	$1601, 0
		frame_oam_tile $F8, $EF, 1, $20
animation_frame_C651CA:.BYTE 2
		frame_oam_tile $FC, 0,	$1701, 0
		frame_oam_tile $F8, $EE, $600,	$20
animation_frame_C651D5:.BYTE 2
		frame_oam_tile $FC, 0,	$1701, 0
		frame_oam_tile $F8, $EE, 1, $20
animation_frame_C651E0:.BYTE 3
		frame_oam_tile 0, 0, $701, 0
		frame_oam_tile $F8, 0,	$601, 0
		frame_oam_tile $F8, $F0, $200,	$20
animation_frame_C651F0:.BYTE 3
		frame_oam_tile 0, 0, $701, 0
		frame_oam_tile $F8, 0,	$601, 0
		frame_oam_tile $F8, $F2, $200,	$20
animation_frame_C65200:.BYTE 3
		frame_oam_tile 0, 0, $701, 0
		frame_oam_tile $F8, 0,	$601, 0
		frame_oam_tile $F8, $F4, $200,	$20
animation_frame_C65210:.BYTE 1
		frame_oam_tile $F8, $F8, $200,	$20
animation_frame_C65216:.BYTE 3
		frame_oam_tile $F8, $F0, $400,	$20
		frame_oam_tile 0, 0, $701, 0
		frame_oam_tile $F8, 0,	$601, 0
animation_frame_C65226:.BYTE 3
		frame_oam_tile $F8, $F0, 0, $20
		frame_oam_tile 0, 0, $701, 0
		frame_oam_tile $F8, 0,	$601, 0
byte_C65236:	.BYTE $A
		animation_frame animation_frame_C650B0, 3
		animation_frame animation_frame_C650C0, 3
		animation_frame animation_frame_C650D0, 3
		animation_frame animation_frame_C650DB, 3
		animation_frame animation_frame_C650E6, 3
		animation_frame animation_frame_C650F1, 3
		animation_frame animation_frame_C650DB, 3
		animation_frame animation_frame_C650D0, 3
		animation_frame animation_frame_C650C0, 3
		animation_frame animation_frame_C650B0, 3
byte_C6525F:	.BYTE $B
		animation_frame animation_frame_C650FC, 3
		animation_frame animation_frame_C6510C, 3
		animation_frame animation_frame_C6511C, 3
		animation_frame animation_frame_C65127, 3
		animation_frame animation_frame_C65132, 3
		animation_frame animation_frame_C6513D, 3
		animation_frame animation_frame_C65132, 3
		animation_frame animation_frame_C65127, 3
		animation_frame animation_frame_C6511C, 3
		animation_frame animation_frame_C6510C, 3
		animation_frame animation_frame_C650FC, 3
byte_C6528C:	.BYTE $B
		animation_frame animation_frame_C65148, 3
		animation_frame animation_frame_C65158, 3
		animation_frame animation_frame_C65168, 3
		animation_frame animation_frame_C65173, 3
		animation_frame animation_frame_C6517E, 3
		animation_frame animation_frame_C65189, 3
		animation_frame animation_frame_C6517E, 3
		animation_frame animation_frame_C65173, 3
		animation_frame animation_frame_C65168, 3
		animation_frame animation_frame_C65158, 3
		animation_frame animation_frame_C65148, 3
byte_C652B9:	.BYTE $B
		animation_frame animation_frame_C65194, 3
		animation_frame animation_frame_C651A4, 3
		animation_frame animation_frame_C651B4, 3
		animation_frame animation_frame_C651BF, 3
		animation_frame animation_frame_C651CA, 3
		animation_frame animation_frame_C651D5, 3
		animation_frame animation_frame_C651CA, 3
		animation_frame animation_frame_C651BF, 3
		animation_frame animation_frame_C651B4, 3
		animation_frame animation_frame_C651A4, 3
		animation_frame animation_frame_C65194, 3
byte_C652E6:	.BYTE $A		; Wrong	count!
		animation_frame animation_frame_C651E0, $10
stru_C652EB:	animation_frame animation_frame_C65216, $D
		animation_frame animation_frame_C651E0, $B
		animation_frame animation_frame_C65226, $D
		animation_frame animation_frame_C651E0, $B
		animation_frame animation_frame_C65216, $D
		animation_frame animation_frame_C651E0, $10
		animation_frame animation_frame_C651F0, 3
		animation_frame animation_frame_C65200, 2
		animation_frame animation_frame_C65210, $20
byte_C6530F:	.BYTE $A
		animation_frame animation_frame_C65210, $20
		animation_frame animation_frame_C65200, 2
		animation_frame animation_frame_C651F0, 3
		animation_frame animation_frame_C651E0, $10
		animation_frame animation_frame_C65216, $D
		animation_frame animation_frame_C651E0, $B
		animation_frame animation_frame_C65226, $D
		animation_frame animation_frame_C651E0, $B
		animation_frame animation_frame_C65216, $D
		animation_frame animation_frame_C651E0, $10
animation_frame_C65338:.BYTE 1
		frame_oam_tile $F8, $F8, 0, $20
animation_frame_C6533E:.BYTE 1
		frame_oam_tile $F8, $F8, $200,	$20
animation_frame_C65344:.BYTE 1
		frame_oam_tile $F8, $F8, $400,	$20
animation_frame_C6534A:.BYTE 1
		frame_oam_tile $F8, $F8, $600,	$20
animation_frame_C65350:.BYTE 1
		frame_oam_tile $F8, $F8, 1, $20
animation_frame_C65356:.BYTE 1
		frame_oam_tile $F8, $F8, $201,	$20
animation_frame_C6535C:.BYTE 1
		frame_oam_tile $F8, $F8, $401,	$20
animation_frame_C65362:.BYTE 1
		frame_oam_tile $F8, $F8, $601,	$20
animation_frame_C65368:.BYTE 1
		frame_oam_tile $F8, $F8, $2000, $20
animation_frame_C6536E:.BYTE 1
		frame_oam_tile $F8, $F8, $2200, $20
animation_frame_C65374:.BYTE 1
		frame_oam_tile $F8, $F8, $2400, $20
animation_frame_C6537A:.BYTE 1
		frame_oam_tile $F8, $F8, $2600, $20
animation_frame_C65380:.BYTE 1
		frame_oam_tile $F8, $F8, $2001, $20
animation_frame_C65386:.BYTE 1
		frame_oam_tile $FC, $FD, $2201, 0
animation_frame_C6538C:.BYTE 1
		frame_oam_tile $FC, $FD, $2301, 0
animation_frame_C65392:.BYTE 1
		frame_oam_tile $FC, $FD, $2401, 0
animation_frame_C65398:.BYTE 1
		frame_oam_tile $FC, $FD, $2501, 0
animation_frame_C6539E:.BYTE 1
		frame_oam_tile $FC, $FD, $2601, 0
animation_frame_C653A4:.BYTE 1
		frame_oam_tile $FC, $FD, $2701, 0
animation_frame_C653AA:.BYTE 1
		frame_oam_tile $FC, $FD, $3201, 0
animation_frame_C653B0:.BYTE 1
		frame_oam_tile $FC, $FD, $3301, 0
animation_frame_C653B6:.BYTE 1
		frame_oam_tile $FC, $FD, $3401, 0
animation_frame_C653BC:.BYTE 1
		frame_oam_tile $FC, $FD, $3501, 0
animation_frame_C653C2:.BYTE 1
		frame_oam_tile $FC, $FD, $3601, 0
animation_frame_C653C8:.BYTE 1
		frame_oam_tile $FC, $FD, $3701, 0
byte_C653CE:	.BYTE 2
		animation_frame animation_frame_C65338, $18
		animation_frame animation_frame_C6533E, $18
byte_C653D7:	.BYTE $C
		animation_frame animation_frame_C65344, $20
		animation_frame animation_frame_C6534A, $20
		animation_frame animation_frame_C65350, $20
		animation_frame animation_frame_C65356, $30
		animation_frame animation_frame_C6535C, 5
		animation_frame animation_frame_C65362, 5
		animation_frame animation_frame_C65368, 5
		animation_frame animation_frame_C6536E, 5
		animation_frame animation_frame_C65374, 5
		animation_frame animation_frame_C6537A, 5
		animation_frame animation_frame_C65380, 5
		animation_frame animation_frame_C65386, 5
byte_C65408:	.BYTE $10
		animation_frame animation_frame_C65386, $30
		animation_frame animation_frame_C6538C, 4
		animation_frame animation_frame_C65392, $20
		animation_frame animation_frame_C6538C, 4
		animation_frame animation_frame_C65386, 4
		animation_frame animation_frame_C65398, 4
		animation_frame animation_frame_C6539E, $20
		animation_frame animation_frame_C65398, 4
		animation_frame animation_frame_C65386, $20
		animation_frame animation_frame_C653A4, 4
		animation_frame animation_frame_C653AA, 4
		animation_frame animation_frame_C653B0, 4
		animation_frame animation_frame_C653B6, 4
		animation_frame animation_frame_C653BC, 4
		animation_frame animation_frame_C653C2, 4
		animation_frame animation_frame_C653C8, 4
byte_C65449:	.BYTE $D
		animation_frame animation_frame_C65386, 5
		animation_frame animation_frame_C65380, 5
		animation_frame animation_frame_C65380, 5
		animation_frame animation_frame_C6537A, 5
		animation_frame animation_frame_C65374, 5
		animation_frame animation_frame_C6536E, 5
		animation_frame animation_frame_C65368, 5
		animation_frame animation_frame_C65362, 5
		animation_frame animation_frame_C6535C, 5
		animation_frame animation_frame_C65356, $30
		animation_frame animation_frame_C65350, $20
		animation_frame animation_frame_C6534A, $20
		animation_frame animation_frame_C65344, $20
animation_frame_C6547E:.BYTE 2
		frame_oam_tile $F8, $FC, 1, $20
		frame_oam_tile $F8, $EC, 0, $20
animation_frame_C65489:.BYTE 2
		frame_oam_tile $F8, $FC, $2001, $20
		frame_oam_tile $F8, $EC, $200,	$20
animation_frame_C65494:.BYTE 2
		frame_oam_tile $F8, $FC, 1, $20
		frame_oam_tile $F8, $EC, $400,	$20
animation_frame_C6549F:.BYTE 2
		frame_oam_tile $F8, $FC, $2001, $20
		frame_oam_tile $F8, $EC, $600,	$20
animation_frame_C654AA:.BYTE 2
		frame_oam_tile $F8, $FC, 1, $20
		frame_oam_tile $F8, $EC, $2000, $20
animation_frame_C654B5:.BYTE 2
		frame_oam_tile $F8, $FC, $2001, $20
		frame_oam_tile $F8, $EC, $2600, $20
animation_frame_C654C0:.BYTE 2
		frame_oam_tile $F8, $FC, 1, $20
		frame_oam_tile $F8, $EC, $2400, $20
animation_frame_C654CB:.BYTE 2
		frame_oam_tile $F8, $FC, $2001, $20
		frame_oam_tile $F8, $EC, $2200, $20
byte_C654D6:	.BYTE 8
		animation_frame animation_frame_C6547E, 9
		animation_frame animation_frame_C65489, 9
		animation_frame animation_frame_C65494, 9
		animation_frame animation_frame_C6549F, 9
		animation_frame animation_frame_C654AA, 9
		animation_frame animation_frame_C654B5, 9
		animation_frame animation_frame_C654C0, 9
		animation_frame animation_frame_C654CB, 9
animation_frame_C654F7:.BYTE 3
		frame_oam_tile $F8, $F7, $2200, $20
		frame_oam_tile 0, $EF,	$300, 0
		frame_oam_tile $F8, $EF, $200,	0
animation_frame_C65507:.BYTE 3
		frame_oam_tile $F8, $F8, $2200, $20
		frame_oam_tile 0, $F0,	$1300, 0
		frame_oam_tile $F8, $F0, $1200, 0
animation_frame_C65517:.BYTE 3
		frame_oam_tile $F8, $F8, $2200, $20
		frame_oam_tile 0, $F0,	$500, 0
		frame_oam_tile $F8, $F0, $400,	0
animation_frame_C65527:.BYTE 3
		frame_oam_tile $F8, $F8, $2200, $20
		frame_oam_tile 0, $F0,	$1500, 0
		frame_oam_tile $F8, $F0, $1400, 0
animation_frame_C65537:.BYTE 3
		frame_oam_tile $F8, $F8, $2200, $20
		frame_oam_tile 0, $F0,	$700, 0
		frame_oam_tile $F8, $F0, $600,	0
animation_frame_C65547:.BYTE 3
		frame_oam_tile $F8, $F8, $2200, $20
		frame_oam_tile 0, $F0,	$1700, 0
		frame_oam_tile $F8, $F0, $1600, 0
animation_frame_C65557:.BYTE 3
		frame_oam_tile $F8, $F7, $2200, $20
		frame_oam_tile 0, $EF,	$101, 0
		frame_oam_tile $F8, $EF, 1, 0
animation_frame_C65567:.BYTE 3
		frame_oam_tile $F8, $F6, $2200, $20
		frame_oam_tile 0, $EE,	$1101, 0
		frame_oam_tile $F8, $EE, $1001, 0
animation_frame_C65577:.BYTE 3
		frame_oam_tile $F8, $F6, $2200, $20
		frame_oam_tile 0, $EE,	$2100, 0
		frame_oam_tile $F8, $EE, $2000, 0
animation_frame_C65587:.BYTE 3
		frame_oam_tile $F8, $FE, $3100, $40
		frame_oam_tile 0, $FE,	$3200, $40
		frame_oam_tile $F8, $EE, $2400, $60
animation_frame_C65597:.BYTE 3
		frame_oam_tile $F8, $FF, $3100, $40
		frame_oam_tile 0, $FF,	$3200, $40
		frame_oam_tile $F8, $EF, $2600, $60
animation_frame_C655A7:.BYTE 3
		frame_oam_tile $F8, $F0, $2001, $60
		frame_oam_tile $F8, 0,	$3100, $40
		frame_oam_tile 0, 0, $3200, $40
animation_frame_C655B7:.BYTE 3
		frame_oam_tile $F8, $F0, $2201, $60
		frame_oam_tile $F8, 0,	$3100, $40
		frame_oam_tile 0, 0, $3200, $40
animation_frame_C655C7:.BYTE 3
		frame_oam_tile $F8, $EF, $2401, $60
		frame_oam_tile $F8, $FF, $3100, $40
		frame_oam_tile 0, $FF,	$3200, $40
animation_frame_C655D7:.BYTE 3
		frame_oam_tile $F8, $EE, $2601, $60
		frame_oam_tile $F8, $FE, $3100, $40
		frame_oam_tile 0, $FE,	$3200, $40
animation_frame_C655E7:.BYTE 3
		frame_oam_tile $F8, $EE, 2, $60
		frame_oam_tile $F8, $FE, $3100, $40
		frame_oam_tile 0, $FE,	$3200, $40
animation_frame_C655F7:.BYTE 3
		frame_oam_tile 0, $EF,	$300, 0
		frame_oam_tile $F8, $EF, $200,	0
		frame_oam_tile $F8, $F7, 0, $20
animation_frame_C65607:.BYTE 3
		frame_oam_tile $F8, $F8, 0, $20
		frame_oam_tile 0, $F0,	$1300, 0
		frame_oam_tile $F8, $F0, $1200, 0
animation_frame_C65617:.BYTE 3
		frame_oam_tile $F8, $F8, 0, $20
		frame_oam_tile 0, $F0,	$500, 0
		frame_oam_tile $F8, $F0, $400,	0
animation_frame_C65627:.BYTE 3
		frame_oam_tile $F8, $F8, 0, $20
		frame_oam_tile 0, $F0,	$1500, 0
		frame_oam_tile $F8, $F0, $1400, 0
animation_frame_C65637:.BYTE 3
		frame_oam_tile $F8, $F8, 0, $20
		frame_oam_tile 0, $F0,	$700, 0
		frame_oam_tile $F8, $F0, $600,	0
animation_frame_C65647:.BYTE 3
		frame_oam_tile $F8, $F8, 0, $20
		frame_oam_tile 0, $F0,	$1700, 0
		frame_oam_tile $F8, $F0, $1600, 0
animation_frame_C65657:.BYTE 3
		frame_oam_tile $F8, $F7, 0, $20
		frame_oam_tile 0, $EF,	$101, 0
		frame_oam_tile $F8, $EF, 1, 0
animation_frame_C65667:.BYTE 3
		frame_oam_tile $F8, $F6, 0, $20
		frame_oam_tile 0, $EE,	$1101, 0
		frame_oam_tile $F8, $EE, $1001, 0
animation_frame_C65677:.BYTE 3
		frame_oam_tile $F8, $F6, 0, $20
		frame_oam_tile 0, $EE,	$2100, 0
		frame_oam_tile $F8, $EE, $2000, 0
animation_frame_C65687:.BYTE 3
		frame_oam_tile 0, $FE,	$3100, 0
		frame_oam_tile $F8, $FE, $3000, 0
		frame_oam_tile $F8, $EE, $2400, $20
animation_frame_C65697:.BYTE 3
		frame_oam_tile 0, $FF,	$3100, 0
		frame_oam_tile $F8, $FF, $3000, 0
		frame_oam_tile $F8, $EF, $2600, $20
animation_frame_C656A7:.BYTE 3
		frame_oam_tile 0, 0, $3100, 0
		frame_oam_tile $F8, 0,	$3000, 0
		frame_oam_tile $F8, $F0, $2001, $20
animation_frame_C656B7:.BYTE 3
		frame_oam_tile $F8, $F0, $2201, $20
		frame_oam_tile 0, 0, $3100, 0
		frame_oam_tile $F8, 0,	$3000, 0
animation_frame_C656C7:.BYTE 3
		frame_oam_tile $F8, $EF, $2401, $20
		frame_oam_tile 0, $FF,	$3100, 0
		frame_oam_tile $F8, $FF, $3000, 0
animation_frame_C656D7:.BYTE 3
		frame_oam_tile $F8, $EE, $2601, $20
		frame_oam_tile 0, $FE,	$3100, 0
		frame_oam_tile $F8, $FE, $3000, 0
animation_frame_C656E7:.BYTE 3
		frame_oam_tile $F8, $EE, 2, $20
		frame_oam_tile 0, $FE,	$3100, 0
		frame_oam_tile $F8, $FE, $3000, 0
byte_C656F7:	.BYTE 9
		animation_frame animation_frame_C654F7, 4
		animation_frame animation_frame_C65507, 4
		animation_frame animation_frame_C65517, 4
		animation_frame animation_frame_C65527, 5
		animation_frame animation_frame_C65537, 3
		animation_frame animation_frame_C65547, 3
		animation_frame animation_frame_C65557, 3
		animation_frame animation_frame_C65567, 3
		animation_frame animation_frame_C65577, 4
byte_C6571C:	.BYTE 7
		animation_frame animation_frame_C65587, 6
		animation_frame animation_frame_C65597, 5
		animation_frame animation_frame_C655A7, 5
		animation_frame animation_frame_C655B7, 6
		animation_frame animation_frame_C655C7, 4
		animation_frame animation_frame_C655D7, 4
		animation_frame animation_frame_C655E7, 4
byte_C65739:	.BYTE 9
		animation_frame animation_frame_C655F7, 4
		animation_frame animation_frame_C65607, 4
		animation_frame animation_frame_C65617, 5
		animation_frame animation_frame_C65627, 3
		animation_frame animation_frame_C65637, 3
		animation_frame animation_frame_C65647, 3
		animation_frame animation_frame_C65657, 3
		animation_frame animation_frame_C65667, 3
		animation_frame animation_frame_C65677, 4
byte_C6575E:	.BYTE 7
		animation_frame animation_frame_C65687, 6
		animation_frame animation_frame_C65697, 5
		animation_frame animation_frame_C656A7, 5
		animation_frame animation_frame_C656B7, 6
		animation_frame animation_frame_C656C7, 4
		animation_frame animation_frame_C656D7, 4
		animation_frame animation_frame_C656E7, 4
animation_frame_C6577B:.BYTE 1
		frame_oam_tile $F8, $F8, $2000, $60
animation_frame_C65781:.BYTE 1
		frame_oam_tile $F8, $F8, $2200, $60
animation_frame_C65787:.BYTE 1
		frame_oam_tile $F8, $F8, $2400, $60
animation_frame_C6578D:.BYTE 1
		frame_oam_tile $F7, $F8, $2600, $60
animation_frame_C65793:.BYTE 1
		frame_oam_tile $F8, $F8, 1, $60
animation_frame_C65799:.BYTE 1
		frame_oam_tile $F8, $F8, $201,	$20
animation_frame_C6579F:.BYTE 1
		frame_oam_tile $F8, $F8, 1, $20
animation_frame_C657A5:.BYTE 1
		frame_oam_tile $F9, $F8, $600,	$20
animation_frame_C657AB:.BYTE 1
		frame_oam_tile $F8, $F8, $400,	$20
animation_frame_C657B1:.BYTE 1
		frame_oam_tile $F8, $F8, $200,	$20
animation_frame_C657B7:.BYTE 1
		frame_oam_tile $F8, $F8, 0, $20
animation_frame_C657BD:.BYTE 1
		frame_oam_tile $F8, $F8, $200,	$60
animation_frame_C657C3:.BYTE 1
		frame_oam_tile $F8, $F8, $400,	$60
animation_frame_C657C9:.BYTE 1
		frame_oam_tile $F7, $F8, $600,	$60
animation_frame_C657CF:.BYTE 1
		frame_oam_tile $F8, $F8, $2600, $20
animation_frame_C657D5:.BYTE 1
		frame_oam_tile $F8, $F8, $2400, $20
animation_frame_C657DB:.BYTE 1
		frame_oam_tile $F8, $F8, $2200, $20
byte_C657E1:	.BYTE $12
		animation_frame animation_frame_C6577B, 3
		animation_frame animation_frame_C65781, 3
		animation_frame animation_frame_C65787, 3
		animation_frame animation_frame_C6578D, 3
		animation_frame animation_frame_C65793, 3
		animation_frame animation_frame_C65799, 3
		animation_frame animation_frame_C6579F, 3
		animation_frame animation_frame_C657A5, 3
		animation_frame animation_frame_C657AB, 3
		animation_frame animation_frame_C657B1, 3
		animation_frame animation_frame_C657B7, 3
		animation_frame animation_frame_C657BD, 3
		animation_frame animation_frame_C657C3, 3
		animation_frame animation_frame_C657C9, 3
		animation_frame animation_frame_C65799, 3
		animation_frame animation_frame_C657CF, 3
		animation_frame animation_frame_C657D5, 3
		animation_frame animation_frame_C657DB, 3
animation_frame_C6582A:.BYTE 1
		frame_oam_tile $F8, $F8, 0, $20
animation_frame_C65830:.BYTE 1
		frame_oam_tile $F8, $F8, $200,	$20
animation_frame_C65836:.BYTE 1
		frame_oam_tile $F8, $F8, $2000, $20
animation_frame_C6583C:.BYTE 1
		frame_oam_tile $F8, $F8, $2200, $20
byte_C65842:	.BYTE 6
		animation_frame animation_frame_C6582A, $C
		animation_frame animation_frame_C65830, $C
		animation_frame animation_frame_C65836, $C
		animation_frame animation_frame_C6583C, $C
		animation_frame animation_frame_C65836, $C
		animation_frame animation_frame_C65830, $C
animation_frame_C6585B:.BYTE 2
		frame_oam_tile $F8, $F6, 0, $20
		frame_oam_tile $F8, 0,	$600, $20
animation_frame_C65866:.BYTE 2
		frame_oam_tile $F8, $F5, $2000, $20
		frame_oam_tile $F8, 0,	$600, $20
animation_frame_C65871:.BYTE 2
		frame_oam_tile $F8, $F4, $200,	$20
		frame_oam_tile $F8, 0,	$600, $20
animation_frame_C6587C:.BYTE 2
		frame_oam_tile $F8, $F3, $2200, $20
		frame_oam_tile $F8, 0,	$600, $20
animation_frame_C65887:.BYTE 2
		frame_oam_tile $F8, $F2, $400,	$20
		frame_oam_tile $F8, 0,	$600, $20
animation_frame_C65892:.BYTE 2
		frame_oam_tile $F8, $F1, $2400, $20
		frame_oam_tile $F8, 0,	$600, $20
denkyun_animation:.BYTE	$A
		animation_frame animation_frame_C6585B, $10; 0
		animation_frame animation_frame_C65866, 4; 1
		animation_frame animation_frame_C65871, 4; 2
		animation_frame animation_frame_C6587C, 4; 3
		animation_frame animation_frame_C65887, 4; 4
		animation_frame animation_frame_C65892, $10; 5
		animation_frame animation_frame_C65887, 4; 6
		animation_frame animation_frame_C6587C, 4; 7
		animation_frame animation_frame_C65871, 4; 8
		animation_frame animation_frame_C65866, 4; 9
.A8
.I16

create_metal_kuwagen:
		STY	z:$56
		SEP	#$20
		LDA	#.LOBYTE(kuwagen)
		STA	z:$DB
		LDA	#.HIBYTE(kuwagen)
		STA	z:$DC
		LDA	#.BANKBYTE(kuwagen)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C658E6
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C658E6:
		LDA	#1
		STA	a:.LOWORD(enemy::hitpoints_left),Y
		LDA	#2
		STA	a:.LOWORD(enemy::direction),Y
		REP	#$20
		LDA	z:$40
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD(enemy::x_position),Y
		LDA	z:$42
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD(enemy::y_position),Y
		LDA	z:$5F
		STA	a:.LOWORD(enemy::position_related),Y
		LDA	z:$60
		STA	a:.LOWORD($3B),Y
		SEP	#$20
.A8
		LDA	z:$48
		STA	a:.LOWORD(enemy::carried_bonus),Y
		LDA	#$30
		STA	a:.LOWORD(enemy::palette),Y
		LDA	a:.LOWORD(3),Y
		ORA	#1
		STA	a:.LOWORD(3),Y
		REP	#$20
.A16
		LDA	#2
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(kuwagen_graphic_pointers)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(kuwagen_graphic_pointers)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD(enemy::palette+1),Y
		SEP	#$20
		LDA	#.LOWORD(METAL_KUWAGEN_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD(player::effective_palette),Y
		STA	a:.LOWORD(player::real_palette),Y
		RTL
; End of function create_metal_kuwagen

.A8
.I16

create_kuwagen:
		STY	z:$56
		SEP	#$20
		LDA	#.LOBYTE(kuwagen)
		STA	z:$DB
		LDA	#.HIBYTE(kuwagen)
		STA	z:$DC
		LDA	#.BANKBYTE(kuwagen)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	locret_C659F1
		LDA	#0
		STA	a:.LOWORD(enemy::hitpoints_left),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#2
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(kuwagen_graphic_pointers)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(kuwagen_graphic_pointers)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(KUWAGEN_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD(player::effective_palette),Y
		STA	a:.LOWORD(player::real_palette),Y
.A16

locret_C659F1:
		RTL
; End of function create_kuwagen

.A16
.I16

kuwagen:
		REP	#$20
		LDA	#0
		STA	z:$30,X
		LDA	#.LOWORD(byte_C63EB8)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D03)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D03)
		STA	z:$18,X
		SEP	#$20
		LDA	#2
		STA	z:$3D,X
		LDA	#3
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		REP	#$20
.A16
		LDA	#.LOWORD(_kuwagen)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_kuwagen)
		STA	z:2,X

_kuwagen:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C65A41
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C65A41:
		BIT	#$90
		BEQ	loc_C65A49
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C65A49:
		BIT	#$41
		BEQ	loc_C65A51
		JML	f:loc_C65A5F
; ---------------------------------------------------------------------------

loc_C65A51:
		JSL	f:kuwagen_movement
		JSL	f:should_kill_enemy
		BCC	loc_C65A5F
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C65A5F:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function kuwagen

.A16
.I16

create_senshiyan:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(senshiyan)
		STA	z:$DB
		LDA	#.HIBYTE(senshiyan)
		STA	z:$DC
		LDA	#.BANKBYTE(senshiyan)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C65A8F
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C65A8F:
		LDA	#2
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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

loc_C65ABD:
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
		LDA	#.LOWORD(senshiyan_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(senshiyan_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(SENSHIYAN_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_senshiyan

.A8
.I16

senshiyan:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D0B)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D0B)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#0
		STA	z:$34,X
		LDA	#.LOWORD(byte_C64044)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#3
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#4
		STA	z:$3D,X
		JSL	f:create_senshiyan_part
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C65B5D)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C65B5D)
		STA	z:2,X
.A16

loc_C65B4D:
		JSL	f:random2
		REP	#$20
		AND	#$FF
		CLC
		ADC	#$40
		STA	z:$30,X
		RTL
; End of function senshiyan

.A16
.I16

sub_C65B5D:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C65B6A
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C65B6A:
		BIT	#$90
		BEQ	loc_C65B72
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C65B72:
		BIT	#$41
		BEQ	loc_C65B7A
		JML	f:loc_C65B9F
; ---------------------------------------------------------------------------

loc_C65B7A:
		REP	#$20
.A16
		LDA	z:$34,X
		BNE	loc_C65BAF
		JSL	f:wanderer_movement
		JSL	f:should_kill_enemy
		BCC	loc_C65B8E
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C65B8E:
		REP	#$20
		DEC	z:$30,X
		BNE	loc_C65B9F
		LDA	#$81
		STA	z:$34,X
		JSL	f:loc_C65B4D
		BRA	loc_C65BAF
; ---------------------------------------------------------------------------
.A8

loc_C65B9F:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C65BAF:
		JSL	f:should_kill_enemy
		BCC	loc_C65BB9
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C65BB9:
		REP	#$20
		DEC	z:$34,X
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation_2
		RTL
; End of function sub_C65B5D

.A8
.I16

sub_C65BCB:
		REP	#$20
.A16
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$22,X
		AND	#$FF
		CMP	#$FF
		BNE	loc_C65BE0
		LDA	#2

loc_C65BE0:
		ASL
		PHX
		TAX
		LDA	f:unk_C65EB9,X
		PLX
		SEP	#$20
.A8
		CLC
		ADC	z:$11,X
		STA	z:$11,X
		XBA
		CLC
		ADC	z:$14,X
		STA	z:$14,X
		STZ	z:$32,X
		JSL	f:sub_C65D5E
		REP	#$20
.A16
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		RTL
; End of function sub_C65BCB

.A8
.I16

create_senshiyan_part:
		SEP	#$20
		LDA	#.LOBYTE(sub_C65C3B)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C65C3B)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C65C3B)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCC	loc_C65C20
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C65C20:
		REP	#$20
.A16
		LDA	z:$E,X
		STA	a:.LOWORD($E),Y
		LDA	z:$1E,X
		STA	a:.LOWORD($1E),Y
		LDA	z:$11,X
		STA	a:.LOWORD($11),Y
		LDA	z:$14,X
		STA	a:.LOWORD($14),Y
		TXA
		STA	a:.LOWORD($34),Y
		RTL
; End of function create_senshiyan_part

.A16
.I16

sub_C65C3B:
		REP	#$20
		LDA	#.LOWORD(byte_C6409D)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C65C59)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C65C59)
		STA	z:2,X

loc_C65C59:
		SEP	#$20
		LDY	z:$34,X
		LDA	a:.LOWORD($20),Y
		STA	z:$20,X
		LDA	a:.LOWORD($22),Y
		STA	z:$22,X
		REP	#$20
.A16
		LDA	a:.LOWORD($11),Y
		STA	z:$11,X
		LDA	a:.LOWORD($14),Y
		STA	z:$14,X
		LDA	a:.LOWORD(0),Y
		BNE	loc_C65C7C
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C65C7C:
		LDA	a:.LOWORD($34),Y
		CMP	#$80
		BNE	loc_C65C9B
		SEP	#$20
.A8
		LDA	#$FF
		STA	z:$23,X
		LDA	#9
		STA	z:$24,X
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C65CC2)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C65CC2)
		STA	z:2,X

loc_C65C9B:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$80
		BNE	locret_C65CC1
		SEP	#$20
		LDA	z:$22,X
		CMP	#$FF
		BNE	loc_C65CAE
		LDA	#2

loc_C65CAE:
		ASL
		STA	z:$C,X
		REP	#$20
.A16
		LDA	z:$14,X
		PHA
		INC	z:$14,X
		JSL	f:advance_animation_2
		REP	#$20
		PLA
		STA	z:$14,X

locret_C65CC1:
		RTL
; End of function sub_C65C3B

.A16
.I16

sub_C65CC2:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C65CCF
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C65CCF:
		BIT	#$41
		BEQ	loc_C65CD7

loc_C65CD3:
		JML	f:loc_C65D03
; ---------------------------------------------------------------------------

loc_C65CD7:
		REP	#$20
.A16
		LDY	z:$34,X
		LDA	a:.LOWORD(0),Y
		BNE	loc_C65CE4
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C65CE4:
		SEP	#$20
.A8
		LDA	z:$C,X
		CMP	z:$23,X
		BEQ	loc_C65D03
		STA	z:$23,X
		DEC	z:$24,X
		BNE	loc_C65D03
		LDA	#$20
		STA	z:$23,X
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C65D14)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C65D14)
		STA	z:2,X

loc_C65D03:
		REP	#$20
.A16
		LDA	z:$14,X
		PHA
		INC	z:$14,X
		JSL	f:advance_animation
		REP	#$20
		PLA
		STA	z:$14,X
		RTL
; End of function sub_C65CC2

.A16
.I16

sub_C65D14:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C65D21
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C65D21:
		BIT	#$41
		BEQ	loc_C65D29
		JML	f:loc_C65D4D
; ---------------------------------------------------------------------------

loc_C65D29:
		REP	#$20
.A16
		LDY	z:$34,X
		LDA	a:.LOWORD(0),Y
		BNE	loc_C65D36
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C65D36:
		SEP	#$20
.A8
		DEC	z:$23,X
		BNE	loc_C65D4D
		JSL	f:sub_C65BCB
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C65C59)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C65C59)
		STA	z:2,X

loc_C65D4D:
		REP	#$20
.A16
		LDA	z:$14,X
		PHA
		INC	z:$14,X
		JSL	f:advance_animation_2
		REP	#$20
		PLA
		STA	z:$14,X
		RTL
; End of function sub_C65D14

.A8
.I16

sub_C65D5E:
		SEP	#$20
		LDA	#.LOBYTE(sub_C65DB6)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C65DB6)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C65DB6)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCC	loc_C65D7A
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C65D7A:
		SEP	#$20
		LDA	a:.LOWORD(3),Y
		AND	#$FE
		STA	a:.LOWORD(3),Y
		LDA	z:$22,X
		CMP	#$FF
		BNE	loc_C65D8C
		LDA	#2

loc_C65D8C:
		STA	a:.LOWORD($22),Y
		LDA	z:$32,X
		STA	a:.LOWORD($32),Y
		LDA	#4
		STA	a:.LOWORD($1E),Y
		REP	#$20
.A16
		LDA	z:$34,X
		STA	a:.LOWORD($34),Y
		LDA	z:$E,X
		STA	a:.LOWORD($E),Y
		LDA	z:$11,X
		STA	a:.LOWORD($11),Y
		LDA	z:$14,X
		STA	a:.LOWORD($14),Y
		LDA	#0
		STA	a:.LOWORD($30),Y
		RTL
; End of function sub_C65D5E

.A16
.I16

sub_C65DB6:
		REP	#$20
		LDY	z:$34,X
		LDA	a:.LOWORD(0),Y
		BNE	loc_C65DC3
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C65DC3:
		LDA	z:$32,X
		AND	#$FE
		STA	z:$40
		ASL	z:$40
		PHX
		TAX
		LDA	f:off_C65F01,X
		STA	z:$50
		PLX
		LDA	z:$22,X
		AND	#$FF
		ASL
		ASL
		ASL
		ASL
		CLC
		ADC	z:$40
		PHX
		TAX
		LDA	f:unk_C65EC1,X
		ASL
		ASL
		STA	z:$40
		LDA	f:unk_C65EC3,X
		ASL
		ASL
		PLX
		STA	z:$18,X
		LDA	z:$40
		STA	z:$16,X
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C65E0F)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C65E0F)
		STA	z:2,X

loc_C65E0F:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C65E1C
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C65E1C:
		BIT	#$41
		BEQ	loc_C65E24
		JML	f:loc_C65E84
; ---------------------------------------------------------------------------

loc_C65E24:
		REP	#$20
.A16
		LDY	z:$34,X
		LDA	a:.LOWORD(0),Y
		BNE	loc_C65E31
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C65E31:
		INC	z:$30,X
		LDA	z:$30,X
		CMP	#$40
		BNE	loc_C65E3E
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C65E3E:
		CMP	#7
		BCS	loc_C65E84
		CMP	#6
		BNE	loc_C65E56
		SEP	#$20
.A8
		INC	z:$32,X
		LDA	z:$32,X
		CMP	#6
		BEQ	loc_C65E84
		JSL	f:sub_C65D5E

loc_C65E56:
		REP	#$20
.A16
		STZ	z:$40
		LDA	z:$16,X
		BPL	loc_C65E60
		DEC	z:$40

loc_C65E60:
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
		LDA	z:$18,X
		BPL	loc_C65E77
		DEC	z:$40

loc_C65E77:
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		SEP	#$20
.A8
		LDA	z:$40
		ADC	z:$15,X
		STA	z:$15,X

loc_C65E84:
		REP	#$20
.A16
		LDA	z:$12,X
		ORA	z:$15,X
		AND	#$FF
		BNE	loc_C65E98
		LDA	#$404
		STA	z:$40
		JSL	f:sub_C634FC

loc_C65E98:
		REP	#$20
		LDA	z:$14,X
		PHA
		LDA	z:$22,X
		AND	#$FF
		CMP	#2
		BNE	loc_C65EAF
		LDA	z:$14,X
		CLC
		ADC	#$10
		STA	z:$14,X

loc_C65EAF:
		JSL	f:advance_animation
		REP	#$20
		PLA
		STA	z:$14,X
		RTL
; End of function sub_C65DB6

; ---------------------------------------------------------------------------
unk_C65EB9:	.BYTE	0
		.BYTE $F0
		.BYTE	8
		.BYTE $F0
		.BYTE	0
		.BYTE $F0
		.BYTE $F8
		.BYTE $F0
unk_C65EC1:	.BYTE	0
		.BYTE	0
unk_C65EC3:	.BYTE $C0
		.BYTE $FF
		.BYTE	0
		.BYTE	0
		.BYTE $80
		.BYTE $FF
		.BYTE	0
		.BYTE	0
		.BYTE $60
		.BYTE $FF
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $40
		.BYTE	0
		.BYTE $40
		.BYTE	0
		.BYTE $80
		.BYTE	0
		.BYTE $20
		.BYTE	0
		.BYTE $A0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $40
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $80
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $A0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE $C0
		.BYTE $FF
		.BYTE $40
		.BYTE	0
		.BYTE $80
		.BYTE $FF
		.BYTE $20
		.BYTE	0
		.BYTE $60
		.BYTE $FF
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0
off_C65F01:	.ADDR byte_C64056, byte_C64067,	byte_C64078
.A16
.I16

create_metal_propene:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(metal_propene)
		STA	z:$DB
		LDA	#.HIBYTE(metal_propene)
		STA	z:$DC
		LDA	#.BANKBYTE(metal_propene)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C65F27
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C65F27:
		LDA	#4
		STA	a:.LOWORD(enemy::hitpoints_left),Y
		LDA	#2
		STA	a:.LOWORD(enemy::direction),Y
		REP	#$20
		LDA	z:$40
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD(enemy::x_position),Y
		LDA	z:$42
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD(enemy::y_position),Y
		LDA	z:$5F
		STA	a:.LOWORD(enemy::position_related),Y
		LDA	z:$60
		STA	a:.LOWORD($3B),Y
		SEP	#$20
.A8
		LDA	z:$48
		STA	a:.LOWORD(enemy::carried_bonus),Y
		LDA	#$30
		STA	a:.LOWORD(enemy::palette),Y
		LDA	a:.LOWORD(3),Y
		ORA	#1
		STA	a:.LOWORD(3),Y
		REP	#$20
.A16
		LDA	#2
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(metal_propene_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(metal_propene_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD(enemy::palette+1),Y
		SEP	#$20
		LDA	#.LOWORD(METAL_PROPENE_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD(enemy::effective_palette),Y
		STA	a:.LOWORD(enemy::real_palette),Y
		RTL
; End of function create_metal_propene

.A8
.I16

metal_propene:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D13)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D13)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C641BE)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$40
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#2
		STA	z:$19,X
		LDA	#6
		STA	z:$3D,X
		STZ	z:$30,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C65FDE)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C65FDE)
		STA	z:2,X

loc_C65FDE:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C65FEB
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C65FEB:
		BIT	#$90
		BEQ	loc_C65FF3
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C65FF3:
		BIT	#$41
		BEQ	loc_C65FFB
		JML	f:loc_C66009
; ---------------------------------------------------------------------------

loc_C65FFB:
		JSL	f:wanderer_movement

loc_C65FFF:
		JSL	f:should_kill_enemy
		BCC	loc_C66009

loc_C66005:
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66009:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function metal_propene

.A8
.I16

create_propene:
		STY	z:$56
		SEP	#$20
		LDA	#.LOBYTE(propene)
		STA	z:$DB
		LDA	#.HIBYTE(propene)
		STA	z:$DC
		LDA	#.BANKBYTE(propene)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C66039
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C66039:
		LDA	#0
		STA	a:.LOWORD(enemy::hitpoints_left),Y
		LDA	#2
		STA	a:.LOWORD(enemy::direction),Y
		REP	#$20
		LDA	z:$40
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD(enemy::x_position),Y
		LDA	z:$42
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD(enemy::y_position),Y
		LDA	z:$5F
		STA	a:.LOWORD(enemy::position_related),Y
		LDA	z:$60
		STA	a:.LOWORD($3B),Y
		SEP	#$20
.A8
		LDA	z:$48
		STA	a:.LOWORD(enemy::carried_bonus),Y
		LDA	#$30
		STA	a:.LOWORD(enemy::palette),Y
		LDA	a:.LOWORD(3),Y
		ORA	#1
		STA	a:.LOWORD(3),Y
		REP	#$20
.A16
		LDA	#2
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(propene_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(propene_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD(enemy::palette+1),Y
		SEP	#$20
		LDA	#.LOWORD(PROPENE_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD(enemy::effective_palette),Y
		STA	a:.LOWORD(enemy::real_palette),Y
		RTL
; End of function create_propene

.A8
.I16

propene:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D13)
		STA	z:object::handler+$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D13)
		STA	z:object::handler+$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(propene_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#3
		STA	z:enemy::hits_left_for_direction_switch,X
		LDA	#$FF
		STA	z:enemy::animation_direction,X
		LDA	#0
		STA	z:enemy::speed,X
		LDA	#0
		STA	z:enemy::score_index,X
		STZ	z:enemy::field_30,X
		REP	#$20
.A16
		LDA	#.LOWORD(_propene)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_propene)
		STA	z:object::handler+2,X

_propene:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C660FD
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C660FD:
		BIT	#$90

loc_C660FF:
		BEQ	loc_C66105
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C66105:
		BIT	#$41
		BEQ	loc_C6610D
		JML	f:loc_C6611B
; ---------------------------------------------------------------------------

loc_C6610D:
		JSL	f:wanderer_movement
		JSL	f:should_kill_enemy
		BCC	loc_C6611B
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C6611B:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function propene

.A16
.I16

create_denkyun:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(denkyun)
		STA	z:$DB
		LDA	#.HIBYTE(denkyun)
		STA	z:$DC
		LDA	#.BANKBYTE(denkyun)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C6614B
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C6614B:
		LDA	#1
		STA	a:.LOWORD(enemy::hitpoints_left),Y
		LDA	#2
		STA	a:.LOWORD(enemy::direction),Y
		REP	#$20
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
		LDA	#1
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(denkyun_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(denkyun_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(DENKYUN_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_denkyun

.A8
.I16

denkyun:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67DAB)
		STA	z:object::handler+$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67DAB)
		STA	z:object::handler+$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(denkyun_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#3
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#2
		STA	z:enemy::score_index,X
		STZ	z:$30,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C66202)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C66202)
		STA	z:2,X

loc_C66202:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C6620F
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C6620F:
		BIT	#$90
		BEQ	loc_C66217
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C66217:
		BIT	#$41
		BEQ	loc_C6621F
		JML	f:loc_C6622D
; ---------------------------------------------------------------------------

loc_C6621F:
		JSL	f:wanderer_movement
		JSL	f:should_kill_enemy
		BCC	loc_C6622D
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C6622D:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function denkyun

.A16
.I16

create_starnuts:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(starnuts)
		STA	z:$DB
		LDA	#.HIBYTE(starnuts)
		STA	z:$DC
		LDA	#.BANKBYTE(starnuts)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C6625D
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C6625D:
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#.LOWORD(starnuts_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(starnuts_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(STARNUTS_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_starnuts

.A8
.I16

starnuts:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D93)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D93)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C65739)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#3
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#1
		STA	z:$3D,X
		STZ	z:$30,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C66314)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C66314)
		STA	z:2,X

loc_C66314:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C66321
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66321:
		BIT	#$90
		BEQ	loc_C66329
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C66329:
		BIT	#$41
		BEQ	loc_C66331
		JML	f:loc_C6633F
; ---------------------------------------------------------------------------

loc_C66331:
		JSL	f:wanderer_movement
		JSL	f:should_kill_enemy
		BCC	loc_C6633F
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C6633F:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function starnuts

.A16
.I16

create_banen:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(banen)
		STA	z:$DB
		LDA	#.HIBYTE(banen)
		STA	z:$DC
		LDA	#.BANKBYTE(banen)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C6636F
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C6636F:
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#2
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(banen_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(banen_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(BANEN_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_banen

.A8
.I16

banen:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D1B)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D1B)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C643C8)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$30
		STA	z:$E,X
		LDA	#3
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#1
		STA	z:$3D,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C66428)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C66428)
		STA	z:2,X

loc_C66428:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C66435
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66435:
		BIT	#$90
		BEQ	loc_C6643D
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C6643D:
		BIT	#$41
		BEQ	loc_C66445
		JML	f:loc_C66453
; ---------------------------------------------------------------------------

loc_C66445:
		JSL	f:wanderer_movement2
		JSL	f:should_kill_enemy
		BCC	loc_C66453
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66453:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function banen

.A16
.I16

create_cuppen:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(cuppen)
		STA	z:$DB
		LDA	#.HIBYTE(cuppen)
		STA	z:$DC
		LDA	#.BANKBYTE(cuppen)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C66483
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C66483:
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#2
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(cuppen_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(cuppen_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(CUPPEN_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_cuppen

.A8
.I16

cuppen:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D23)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D23)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C6448A)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$40
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#2
		STA	z:$3D,X
		STZ	z:$30,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C6653A)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C6653A)
		STA	z:2,X

loc_C6653A:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C66547
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66547:
		BIT	#$90
		BEQ	loc_C6654F
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C6654F:
		BIT	#$41
		BEQ	loc_C66557
		JML	f:loc_C66565
; ---------------------------------------------------------------------------

loc_C66557:
		JSL	f:random_wanderer_movement
		JSL	f:should_kill_enemy
		BCC	loc_C66565
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66565:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function cuppen

.A16
.I16

create_keibin:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(keibin)
		STA	z:$DB
		LDA	#.HIBYTE(keibin)
		STA	z:$DC
		LDA	#.BANKBYTE(keibin)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C66595
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C66595:
		LDA	#2
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#2
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(keibin_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(keibin_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(KEIBIN_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_keibin

.A8
.I16

keibin:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D8B)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D8B)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C654D6)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$40
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#2
		STA	z:$3D,X
		STZ	z:$30,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C6664C)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C6664C)
		STA	z:2,X

loc_C6664C:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C66659
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66659:
		BIT	#$90
		BEQ	loc_C66661
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C66661:
		BIT	#$41
		BEQ	loc_C66669
		JML	f:loc_C66677
; ---------------------------------------------------------------------------

loc_C66669:
		JSL	f:random_wanderer_movement
		JSL	f:should_kill_enemy
		BCC	loc_C66677
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66677:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function keibin

.A16
.I16

create_anzenda:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(anzenda)
		STA	z:$DB
		LDA	#.HIBYTE(anzenda)
		STA	z:$DC
		LDA	#.BANKBYTE(anzenda)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C666A7
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C666A7:
		LDA	#1
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#2
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(anzenda_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(anzenda_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(ANZENDA_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_anzenda

.A8
.I16

anzenda:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D2B)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D2B)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C6458D)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#3
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#3
		STA	z:$3D,X
		STZ	z:$30,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C6675E)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C6675E)
		STA	z:2,X

loc_C6675E:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C6676B
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C6676B:
		BIT	#$90
		BEQ	loc_C66773
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C66773:
		BIT	#$41
		BEQ	loc_C6677B
		JML	f:loc_C66789
; ---------------------------------------------------------------------------

loc_C6677B:
		JSL	f:wanderer_movement
		JSL	f:should_kill_enemy
		BCC	loc_C66789
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66789:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function anzenda

.A16
.I16

create_yoroisu:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(yoroisu)
		STA	z:$DB
		LDA	#.HIBYTE(yoroisu)
		STA	z:$DC
		LDA	#.BANKBYTE(yoroisu)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C667B9
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C667B9:
		LDA	#7
		STA	a:enemy::hitpoints_left,Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#6
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(yoroisu_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(yoroisu_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(YOROISO_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_yoroisu

.A8
.I16

yoroisu:
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C647D0)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D33)

loc_C66847:
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D33)
		STA	z:$18,X
		SEP	#$20
		LDA	#$30
		STA	z:$E,X
		LDA	#3
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#5
		STA	z:$3D,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C66872)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C66872)
		STA	z:2,X

loc_C66872:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C6687F
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C6687F:
		BIT	#$90
		BEQ	loc_C66887
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C66887:
		BIT	#$41
		BEQ	loc_C6688F
		JML	f:loc_C668AC
; ---------------------------------------------------------------------------

loc_C6688F:
		JSL	f:get_object_square_index
		REP	#$20
.A16
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$100
		BNE	loc_C668BC

loc_C6689E:
		JSL	f:should_kill_enemy
		BCC	loc_C668A8
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C668A8:
		JSL	f:kuwagen_movement
.A8

loc_C668AC:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C668BC:
		REP	#$20
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F
		SEC
		SBC	#$C
		STA	z:$40
		LDA	z:$20,X
		AND	#$FF
		PHX
		TAX
		SEP	#$20
.A8
		LDA	f:byte_C668F9,X
		PLX
		CMP	z:$40
		BNE	loc_C6689E
		REP	#$20
.A16
		LDA	z:$20,X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:off_C67D3B,X
		STA	z:$50
		PLX
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		BRA	loc_C668AC
; End of function yoroisu

; ---------------------------------------------------------------------------
byte_C668F9:	.BYTE 1, 3, 0, 2
.A8
.I16

create_chameleoman:
		STY	z:$56
		SEP	#$20
		LDA	#.LOBYTE(chameleoman)
		STA	z:$DB
		LDA	#.HIBYTE(chameleoman)
		STA	z:$DC
		LDA	#.BANKBYTE(chameleoman)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C6691D
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C6691D:
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#1
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(chameleoman_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(chameleoman_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(CHAMELEOMAN_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_chameleoman

.A8
.I16

chameleoman:
		REP	#$20
.A16
		LDA	#.LOWORD(player_animation_list+$42)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(player_animation_list+$42)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#$E0
		STA	z:$1C,X
		REP	#$20
		LDA	#.LOWORD(wrapping_animation)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(wrapping_animation)
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	z:$1E,X
		STA	z:$33,X
		LDA	z:$F,X
		STA	z:$34,X
		LDA	#$30
		STA	z:$E,X
		LDA	#3
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#1
		STA	z:$31,X
		LDA	#0
		STA	z:$32,X
		LDA	#2
		STA	z:$3D,X
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C669FB)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C669FB)
		STA	z:2,X

loc_C669ED:
		JSL	f:random2
		SEP	#$20
		AND	#$3F
		CLC
		ADC	#$C0
		STA	z:$30,X
		RTL
; End of function chameleoman

.A8
.I16

sub_C669FB:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C66A08
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66A08:
		BIT	#$90
		BEQ	loc_C66A10
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C66A10:
		BIT	#$41
		BEQ	loc_C66A18
		JML	f:loc_C66A30
; ---------------------------------------------------------------------------

loc_C66A18:
		SEP	#$20
		DEC	z:$30,X
		BNE	loc_C66A22
		JML	f:loc_C66AE3
; ---------------------------------------------------------------------------

loc_C66A22:
		LDA	z:$31,X
		BEQ	loc_C66A2C
		JSL	f:wanderer_movement2
		BRA	loc_C66A30
; ---------------------------------------------------------------------------

loc_C66A2C:
		JSL	f:follower_movement

loc_C66A30:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
.A8

loc_C66A3F:
		JSL	f:should_kill_enemy
		BCS	loc_C66A49
		JML	f:locret_C66A6A
; ---------------------------------------------------------------------------

loc_C66A49:
		SEP	#$20
		LDA	z:$33,X
		CMP	z:$1E,X
		BNE	loc_C66A55
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66A55:
		LDA	#0
		STA	z:$3E,X
		LDA	#$20
		STA	z:$3F,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C66A6B)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C66A6B)
		STA	z:2,X

locret_C66A6A:
		RTL
; ---------------------------------------------------------------------------

loc_C66A6B:
		SEP	#$20
		LDA	#.BANKBYTE(player_animation_list)
		STA	z:$52
		REP	#$20
.A16
		LDA	z:$20,X
		AND	#$FF
		ASL
		ADC	#.LOWORD(player_animation_list+$3A)
		STA	z:$50
		LDA	[$50]
		STA	z:$50
		JSL	f:start_animation
		REP	#$20
		LDA	#.LOWORD(loc_C66A93)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C66A93)
		STA	z:2,X

loc_C66A93:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C66AA0
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66AA0:
		BIT	#$90
		BEQ	loc_C66AA8
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C66AA8:
		BIT	#$41
		BEQ	loc_C66AB0
		JML	f:loc_C66AC1
; ---------------------------------------------------------------------------

loc_C66AB0:
		DEC	z:$3F,X
		BNE	loc_C66AC1
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C66AE3)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C66AE3)
		STA	z:2,X

loc_C66AC1:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation_2
		SEP	#$20
.A8
		LDA	#$E
		STA	z:$1E,X
		LDA	z:$3E,X
		EOR	#1
		STA	z:$3E,X
		BEQ	locret_C66A6A
		LDA	z:$32,X
		STA	z:$1E,X
		RTL
; ---------------------------------------------------------------------------

loc_C66AE3:
		JSL	f:loc_C669ED
		SEP	#$20
		LDA	z:$31,X
		EOR	#1
		STA	z:$31,X
		BNE	loc_C66AFB
		JSL	f:random2
		SEP	#$20
		AND	#2
		STA	z:$32,X

loc_C66AFB:
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C66B29)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C66B29)
		STA	z:2,X
		SEP	#$20
		LDA	#$20
		STA	z:$36,X
		LDA	#0
		STA	z:$37,X
		LDA	#.BANKBYTE(player_animation_list+$42)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(player_animation_list+$42)
		STA	z:$16,X
		LDA	z:$31,X
		BIT	#1
		BNE	loc_C66B29
		LDA	#.LOWORD(player_animation_list+$3A)
		STA	z:$16,X

loc_C66B29:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C66B36
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66B36:
		BIT	#$90
		BEQ	loc_C66B3E
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C66B3E:
		BIT	#$41
		BEQ	loc_C66B46
		JML	f:loc_C66A3F
; ---------------------------------------------------------------------------

loc_C66B46:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation_2
		JSL	f:sub_C66B64
		JSL	f:should_kill_enemy
		BCC	locret_C66B63
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

locret_C66B63:
		RTL
; End of function sub_C669FB

.A16
.I16

sub_C66B64:
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_C66BFC)
		STA	z:$DD
		DEC	z:$36,X
		BNE	locret_C66BE5
		LDA	z:$37,X
		CMP	#$20
		BEQ	loc_C66BE6
		INC	z:$37,X
		STA	z:$40
		LDA	z:$31,X
		BIT	#1
		BNE	loc_C66B88
		LDA	z:$40
		SEC
		SBC	#$1F
		EOR	#$FF
		INC
		STA	z:$40

loc_C66B88:
		LDA	z:$40
		ASL
		REP	#$20
.A16
		AND	#$FF
		CLC
		ADC	#.LOWORD(byte_C66BFC)
		STA	z:$DB
		SEP	#$20
.A8
		LDA	z:$32,X
		STA	z:$1F,X
		LDA	#0
		STA	z:$F,X
		LDA	#.BANKBYTE(player_animation_list)
		STA	z:$55
		LDY	#1
		LDA	[$DB],Y
		STA	z:$36,X
		LDA	[$DB]
		BEQ	loc_C66BBB
		LDA	z:$33,X
		STA	z:$1F,X
		LDA	z:$34,X
		STA	z:$F,X
		LDA	#.BANKBYTE(player_animation_list)
		STA	z:$55

loc_C66BBB:
		SEP	#$20
		LDA	#.BANKBYTE(player_animation_list)
		STA	z:$52
		REP	#$20
.A16
		LDA	[$DB]

loc_C66BC5:
		AND	#$FF
		ASL
		ASL
		ASL
		TAY
		LDA	z:$20,X
		AND	#$FF
		ASL
		ADC	#.LOWORD(player_animation_list+$3A)
		STA	z:$50
		LDA	[$50],Y
		STA	z:$50
		SEP	#$20
.A8
		LDA	z:$55
		STA	z:$52
		JSL	f:start_animation

locret_C66BE5:
		RTL
; ---------------------------------------------------------------------------

loc_C66BE6:
		SEP	#$20
		LDA	#$FF
		STA	z:$22,X
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C669FB)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C669FB)
		STA	z:2,X
		JMP	a:.LOWORD(loc_C66A3F)
; End of function sub_C66B64

; ---------------------------------------------------------------------------
byte_C66BFC:	.BYTE 0, $20, 1, 1, 0, 3, 1, 1
		.BYTE 0, 3, 1, 1, 0, 3,	1, 1
		.BYTE 0, 2, 1, 1, 0, 2,	1, 1
		.BYTE 0, 2, 1, 1, 0, 1,	1, 1
		.BYTE 0, 1, 1, 1, 0, 1,	1, 2
		.BYTE 0, 1, 1, 2, 0, 1,	1, 2
		.BYTE 0, 1, 1, 3, 0, 1,	1, 3
		.BYTE 0, 1, 1, 3, 0, 1,	1, $20
.A16
.I16

create_missle:
		REP	#$20
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(missle)
		STA	z:$DB
		LDA	#.HIBYTE(missle)
		STA	z:$DC
		LDA	#.BANKBYTE(missle)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C66C5E
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C66C5E:
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		TXA
		STA	a:.LOWORD($38),Y
		INC	z:$30,X
		PHX
		LDA	z:$34,X
		TAX
		LDA	z:$11,X
		PLX
		SEC
		SBC	#$88
		EOR	#$FFFF
		INC
		CLC
		ADC	#$88
		STA	a:.LOWORD($11),Y
		LDA	#$40
		STA	a:.LOWORD($14),Y
		REP	#$20
		LDA	#.LOWORD(unk_7F06B0)
		STA	a:.LOWORD($3A),Y
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7F06B0)
		STA	a:.LOWORD($3C),Y
		SEP	#$20
		LDA	#1
		STA	a:.LOWORD(3),Y
		LDA	#$30
		STA	a:.LOWORD($E),Y
		LDA	#8
		STA	a:.LOWORD($F),Y
		LDA	#$C
		STA	a:.LOWORD($1E),Y
		LDA	#$C
		STA	a:.LOWORD($1F),Y
		LDA	#0
		STA	a:.LOWORD($3E),Y
		LDA	#0
		STA	a:.LOWORD($3F),Y
		RTL
; End of function create_missle

.A8
.I16

missle:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D63)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D63)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#0
		STA	z:$1A,X
		LDA	#.LOWORD(byte_C648A6)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$10
		STA	z:$30,X
		LDA	#0
		STA	z:$19,X
		LDA	#2
		STA	z:$20,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C66CFF)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C66CFF)
		STA	z:2,X

loc_C66CFF:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C66D0C
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66D0C:
		BIT	#$90
		BEQ	loc_C66D14
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C66D14:
		BIT	#$41
		BEQ	loc_C66D1C
		JML	f:loc_C66E56
; ---------------------------------------------------------------------------

loc_C66D1C:
		REP	#$20
.A16
		LDA	#$C0
		STA	z:$42
		JSL	f:straight_movement
		BCC	loc_C66D2D
		JML	f:loc_C66E56
; ---------------------------------------------------------------------------

loc_C66D2D:
		SEP	#$20
.A8
		DEC	z:$30,X
		BEQ	loc_C66D37
		JML	f:loc_C66E56
; ---------------------------------------------------------------------------

loc_C66D37:
		LDY	z:$38,X
		LDA	a:.LOWORD($32),Y
		DEC
		STA	a:.LOWORD($32),Y
		JMP	a:.LOWORD(loc_C66DE1)
; ---------------------------------------------------------------------------
		STY	z:$56
		SEP	#$20
		LDA	#.LOBYTE(loc_C66DE1)
		STA	z:$DB
		LDA	#.HIBYTE(loc_C66DE1)
		STA	z:$DC
		LDA	#.BANKBYTE(loc_C66DE1)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C66D63
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C66D63:
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#2
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(missle_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(missle_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(MISSLE_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		REP	#$20
.A16
		TYA
		STA	a:.LOWORD($38),Y
		RTL
; ---------------------------------------------------------------------------

loc_C66DE1:
		REP	#$20
		LDA	#.LOWORD(off_C67D63)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D63)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C648A6)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#3
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#2
		STA	z:$3D,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C66E1E)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C66E1E)
		STA	z:2,X

loc_C66E1E:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C66E2B
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66E2B:
		BIT	#$90
		BEQ	loc_C66E33
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C66E33:
		BIT	#$41
		BEQ	loc_C66E3B
		JML	f:loc_C66E56
; ---------------------------------------------------------------------------

loc_C66E3B:
		JSL	f:missle_movement
		JSL	f:should_kill_enemy
		BCC	loc_C66E56
		SEP	#$20
		PHY
		LDY	z:$38,X
		LDA	a:.LOWORD($30),Y
		DEC
		STA	a:.LOWORD($30),Y
		PLY
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66E56:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function missle

.A16
.I16

create_kouraru:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(kouraru)
		STA	z:$DB
		LDA	#.HIBYTE(kouraru)
		STA	z:$DC
		LDA	#.BANKBYTE(kouraru)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C66E86
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C66E86:
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#.LOWORD(kouraru_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(kouraru_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(KOURARU_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_kouraru

.A8
.I16

kouraru:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D43)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D43)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C64910)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#3
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#1
		STA	z:$3D,X
		STZ	z:$30,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C66F3D)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C66F3D)
		STA	z:2,X

loc_C66F3D:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C66F4A
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66F4A:
		BIT	#$90
		BEQ	loc_C66F52
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C66F52:
		BIT	#$41
		BEQ	loc_C66F5A
		JML	f:loc_C66F68
; ---------------------------------------------------------------------------

loc_C66F5A:
		JSL	f:wanderer_movement
		JSL	f:should_kill_enemy
		BCC	loc_C66F68
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C66F68:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function kouraru

.A16
.I16

create_pakupa:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(pakupa)
		STA	z:$DB
		LDA	#.HIBYTE(pakupa)
		STA	z:$DC
		LDA	#.BANKBYTE(pakupa)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C66F98
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C66F98:
		LDA	#2
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#.LOWORD(pakupa_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(pakupa_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(PAKUPA_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_pakupa

.A8
.I16

pakupa:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D4B)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D4B)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C64A13)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$30
		STA	z:$E,X
		LDA	#3
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#2
		STA	z:$3D,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C67051)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C67051)
		STA	z:2,X

loc_C67051:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C6705E
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C6705E:
		BIT	#$90
		BEQ	loc_C67066
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C67066:
		BIT	#$41
		BEQ	loc_C6706E
		JML	f:loc_C67080
; ---------------------------------------------------------------------------

loc_C6706E:
		JSL	f:pakupa_movement
		JSL	f:should_kill_enemy
		BCC	loc_C6707C
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C6707C:
		JSL	f:replace_bomb_with_hard_block

loc_C67080:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function pakupa

.A8
.I16

replace_bomb_with_hard_block:
		JSL	f:get_object_square_index
		REP	#$20
.A16
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#BOMB
		BEQ	locret_C670A5
		LDA	#HARD_BLOCK|$500
		STA	a:.LOWORD(collision_map),Y

locret_C670A5:
		RTL
; End of function replace_bomb_with_hard_block

.A16
.I16

create_douken:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(douken)
		STA	z:$DB
		LDA	#.HIBYTE(douken)
		STA	z:$DC
		LDA	#.BANKBYTE(douken)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C670C6
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C670C6:
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#1
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(douken_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(douken_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(DOUKEN_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_douken

.A8
.I16

douken:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D53)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D53)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C64AFC)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$30
		STA	z:$E,X
		LDA	#3
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#0
		STA	z:$3D,X
		STZ	z:$30,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C67181)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C67181)
		STA	z:2,X

loc_C67181:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C6718E
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C6718E:
		BIT	#$90
		BEQ	loc_C67196
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C67196:
		BIT	#$41
		BEQ	loc_C6719E
		JML	f:loc_C671AC
; ---------------------------------------------------------------------------

loc_C6719E:
		JSL	f:wanderer_movement
		JSL	f:should_kill_enemy
		BCC	loc_C671AC
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C671AC:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function douken

.A16
.I16

create_dengurin:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(dengurin)
		STA	z:$DB
		LDA	#.HIBYTE(dengurin)
		STA	z:$DC
		LDA	#.BANKBYTE(dengurin)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C671DC
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C671DC:
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#.LOWORD(dengurin_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(dengurin_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(DENGURIN_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_dengurin

.A8
.I16

dengurin:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D5B)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D5B)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C64C51)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$40
		STA	z:$21,X
		LDA	#$40
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#2
		STA	z:$3D,X
		STZ	z:$30,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C67293)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C67293)
		STA	z:2,X

loc_C67293:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C672A0
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C672A0:
		BIT	#$90
		BEQ	loc_C672A8
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C672A8:
		BIT	#$41
		BEQ	loc_C672B0
		JML	f:loc_C672BE
; ---------------------------------------------------------------------------

loc_C672B0:
		JSL	f:random_wanderer_movement
		JSL	f:should_kill_enemy
		BCC	loc_C672BE
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C672BE:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function dengurin

.A16
.I16

create_robocom:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(robocom)
		STA	z:$DB
		LDA	#.HIBYTE(robocom)
		STA	z:$DC
		LDA	#.BANKBYTE(robocom)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C672EE
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C672EE:
		LDA	#2
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#.LOWORD(robocom_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(robocom_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(ROBOCOM_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_robocom

.A8
.I16

robocom:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D6B)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D6B)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#$E0
		STA	z:$1C,X
		LDA	#.LOWORD(byte_C64E6F)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$30
		STA	z:$E,X
		LDA	#1
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#3
		STA	z:$3D,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C673AC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C673AC)
		STA	z:2,X

loc_C673AC:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C673B9
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C673B9:
		BIT	#$90
		BEQ	loc_C673C1
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C673C1:
		BIT	#$41
		BEQ	loc_C673C9
		JML	f:loc_C673D7
; ---------------------------------------------------------------------------

loc_C673C9:
		JSL	f:follower_movement
		JSL	f:should_kill_enemy
		BCC	loc_C673D7
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C673D7:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function robocom

.A16
.I16

create_metal_u:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(metal_u)
		STA	z:$DB
		LDA	#.HIBYTE(metal_u)
		STA	z:$DC
		LDA	#.BANKBYTE(metal_u)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C67407
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C67407:
		LDA	#1
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#1
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(metal_u_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(metal_u_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(METAL_U_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_metal_u

.A8
.I16

metal_u:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67DA3)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67DA3)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#BOMB|SOFT_BLOCK|HARD_BLOCK
		STA	z:enemy::collision_mask,X
		LDA	#.LOWORD(byte_C65842)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$30
		STA	z:$E,X
		LDA	#1
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#5
		STA	z:$3D,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C674C5)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C674C5)
		STA	z:2,X

loc_C674C5:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C674D2
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C674D2:
		BIT	#$90
		BEQ	loc_C674DA
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C674DA:
		BIT	#$41
		BEQ	loc_C674E2
		JML	f:loc_C674F0
; ---------------------------------------------------------------------------

loc_C674E2:
		JSL	f:follower_movement
		JSL	f:should_kill_enemy
		BCC	loc_C674F0
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C674F0:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function metal_u

.A16
.I16

create_kinkaru:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(kinkaru)
		STA	z:$DB
		LDA	#.HIBYTE(kinkaru)
		STA	z:$DC
		LDA	#.BANKBYTE(kinkaru)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C67520
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C67520:
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#2
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(kinkaru_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(kinkaru_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(KINKARU_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_kinkaru

.A8
.I16

kinkaru:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D9B)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D9B)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#$A0
		STA	z:$1C,X
		LDA	#.LOWORD(byte_C657E1)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$30
		STA	z:$E,X
		LDA	#1
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#3
		STA	z:$19,X
		LDA	#4
		STA	z:$3D,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C675DE)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C675DE)
		STA	z:2,X

loc_C675DE:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C675EB
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C675EB:
		BIT	#$90
		BEQ	loc_C675F3
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C675F3:
		BIT	#$41
		BEQ	loc_C675FB
		JML	f:loc_C67609
; ---------------------------------------------------------------------------

loc_C675FB:
		JSL	f:follower_movement
		JSL	f:should_kill_enemy
		BCC	loc_C67609
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C67609:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; End of function kinkaru

.A16
.I16

create_moguchan:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(moguchan)
		STA	z:$DB
		LDA	#.HIBYTE(moguchan)
		STA	z:$DC
		LDA	#.BANKBYTE(moguchan)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C67639
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C67639:
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#.LOWORD(moguchan_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(moguchan_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(MOGUCHAN_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_moguchan

.A8
.I16

moguchan:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D73)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D73)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#$E0
		STA	z:$1C,X
		LDA	#.LOWORD(byte_C65038)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$30
		STA	z:$E,X
		LDA	#1
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#2
		STA	z:$3D,X
		JSL	f:random2
		REP	#$20
.A16
		AND	#$FF
		CLC
		ADC	#$400
		STA	z:$30,X
		REP	#$20
		LDA	#.LOWORD(loc_C67706)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C67706)
		STA	z:2,X

loc_C67706:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C67713
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C67713:
		BIT	#$90
		BEQ	loc_C6771B
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C6771B:
		BIT	#$41
		BEQ	loc_C67723
		JML	f:loc_C67737
; ---------------------------------------------------------------------------

loc_C67723:
		REP	#$20
.A16
		DEC	z:$30,X
		BEQ	loc_C67747
		JSL	f:follower_movement
		JSL	f:should_kill_enemy
		BCC	loc_C67737
		JML	f:kill_enemy
; ---------------------------------------------------------------------------
.A8

loc_C67737:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C67747:
		JSL	f:random2
		SEP	#$20
.A8
		AND	#$1F
		CLC
		ADC	#$60
		STA	z:$30,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C6505A)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C67772)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C67772)
		STA	z:2,X

loc_C67772:
		JSL	f:advance_animation
		BCC	locret_C67785
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C67786)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C67786)
		STA	z:2,X

locret_C67785:
		RTL
; End of function moguchan

.A8
.I16

sub_C67786:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C67793
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C67793:
		BIT	#$41
		BEQ	loc_C6779B
		JML	f:locret_C67785
; ---------------------------------------------------------------------------

loc_C6779B:
		REP	#$20
.A16
		DEC	z:$30,X
		BNE	locret_C67785
		PHX
		JSL	f:generate_random_position
		PLX
		JSL	f:sub_C67825
		BNE	loc_C677C9
		REP	#$20
		LDA	z:$40
		AND	#$FF
		ORA	#8
		STA	z:$11,X
		LDA	z:$42
		AND	#$FF
		ORA	#8
		STA	z:$14,X
		JSL	f:check_for_enemy_with_enemy_collision
		BCC	loc_C677CE

loc_C677C9:
		SEP	#$20
.A8
		INC	z:$30,X
		RTL
; ---------------------------------------------------------------------------

loc_C677CE:
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C65087)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C677EC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C677EC)
		STA	z:2,X

loc_C677EC:
		JSL	f:advance_animation
		BCS	loc_C677F6
		JML	f:locret_C67785
; ---------------------------------------------------------------------------

loc_C677F6:
		JSL	f:random2
		SEP	#$20
		AND	#$3F
		ORA	#$C0
		STA	z:$30,X
		LDA	#$FF
		STA	z:$22,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C65038)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C67706)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C67706)
		STA	z:2,X
		RTL
; End of function sub_C67786

.A16
.I16

sub_C67825:
		REP	#$20
		LDA	z:$40
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$44
		LDA	z:$42
		AND	#$F0
		ASL
		ASL
		ADC	z:$44
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$FF
		RTL
; End of function sub_C67825

.A16
.I16

create_red_bakuda:
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(bakuda)
		STA	z:$DB
		LDA	#.HIBYTE(bakuda)
		STA	z:$DC
		LDA	#.BANKBYTE(bakuda)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C67862
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C67862:
		LDA	#1
		STA	a:.LOWORD($38),Y
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#2
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(bakuda_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(bakuda_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(RED_BAKUDA_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_red_bakuda

.A8
.I16

create_bakuda:
		STY	z:$56
		SEP	#$20
		LDA	#.LOBYTE(bakuda)
		STA	z:$DB
		LDA	#.HIBYTE(bakuda)
		STA	z:$DC
		LDA	#.BANKBYTE(bakuda)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C67900
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C67900:
		LDA	#0
		STA	a:.LOWORD($38),Y
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#2
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(bakuda_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(bakuda_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(BAKUDA_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_bakuda

.A8
.I16

bakuda:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D7B)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D7B)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C6528C)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#3
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#3
		STA	z:$3D,X
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C679C8)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C679C8)
		STA	z:2,X
.A16

loc_C679BB:
		JSL	f:random2
		SEP	#$20
.A8
		AND	#$3F
		ORA	#$C0
		STA	z:$30,X
		RTL
; End of function bakuda

.A8
.I16

sub_C679C8:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C679D5
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C679D5:
		BIT	#$90
		BEQ	loc_C679DD
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C679DD:
		BIT	#$41
		BEQ	loc_C679E5
		JML	f:loc_C679FB
; ---------------------------------------------------------------------------

loc_C679E5:
		SEP	#$20
		LDA	z:$30,X
		BEQ	loc_C67A0B
		DEC	z:$30,X
.A16

loc_C679ED:
		JSL	f:wanderer_movement
		JSL	f:should_kill_enemy
		BCC	loc_C679FB
		JML	f:kill_enemy
; ---------------------------------------------------------------------------
.A8

loc_C679FB:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C67A0B:
		JSL	f:is_object_aligned
		BCC	loc_C67A15
		JML	f:loc_C679ED
; ---------------------------------------------------------------------------

loc_C67A15:
		JSL	f:get_object_square_index
		REP	#$20
		TAY
		LDA	a:.LOWORD(collision_map),Y
		AND	#$FF
		BEQ	loc_C67A28
		JML	f:loc_C679ED
; ---------------------------------------------------------------------------

loc_C67A28:
		STY	z:$26,X
		LDA	#.LOWORD(byte_C652E6)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C67A46)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C67A46)
		STA	z:2,X

loc_C67A46:
		JSL	f:should_kill_enemy
		BCC	loc_C67A50
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C67A50:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		BCS	loc_C67A65
		JML	f:locret_C67B10
; ---------------------------------------------------------------------------

loc_C67A65:
		REP	#$20
		LDA	z:$26,X
		STA	z:$56
		LDA	#.LOWORD(byte_C6530F)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	z:5,X
		PHA
		LDA	#2
		STA	z:$31,X
		LDA	#0
		STA	z:$33,X
		LDA	#2
		STA	z:5,X
		JSL	f:sub_C44BA4
		JSL	f:sub_C60BCB
		SEP	#$20
		LDA	#$20
		STA	z:$31,X
		LDA	#$FF
		STA	z:$22,X
		PLA
		STA	z:5,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C67AAD)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C67AAD)
		STA	z:2,X

loc_C67AAD:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C67ABA
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C67ABA:
		BIT	#$90
		BEQ	loc_C67AC2
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C67AC2:
		BIT	#$41
		BEQ	loc_C67ACA
		JML	f:locret_C67B10
; ---------------------------------------------------------------------------

loc_C67ACA:
		SEP	#$20
		DEC	z:$31,X
		BNE	locret_C67B10
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C67ADD)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C67ADD)
		STA	z:2,X

loc_C67ADD:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		BCC	locret_C67B10
		JSL	f:loc_C679BB
		REP	#$20
		LDA	#.LOWORD(byte_C6528C)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C679C8)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C679C8)
		STA	z:2,X

locret_C67B10:
		RTL
; End of function sub_C679C8

.A8
.I16

create_kierun:
		STY	z:$56
		SEP	#$20
		LDA	#.LOBYTE(kierun)
		STA	z:$DB
		LDA	#.HIBYTE(kierun)
		STA	z:$DC
		LDA	#.BANKBYTE(kierun)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C67B31
		JML	f:locret_C659F1
; ---------------------------------------------------------------------------

loc_C67B31:
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#2
		STA	a:.LOWORD($20),Y
		REP	#$20
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
		LDA	#2
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(kierun_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(kierun_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(KIERUN_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		RTL
; End of function create_kierun

.A8
.I16

kierun:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C67D83)
		STA	z:$16,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C67D83)
		STA	z:$18,X
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C653CE)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$40
		STA	z:$21,X
		LDA	#$FF
		STA	z:$22,X
		LDA	#0
		STA	z:$19,X
		LDA	#3
		STA	z:$3D,X
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C67BF3)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C67BF3)
		STA	z:2,X

loc_C67BE6:
		JSL	f:random2
		SEP	#$20
		AND	#$3F
		ORA	#$C0
		STA	z:$30,X
		RTL
; End of function kierun

.A8
.I16

sub_C67BF3:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C67C00
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C67C00:
		BIT	#$90
		BEQ	loc_C67C08
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C67C08:
		BIT	#$41
		BEQ	loc_C67C10
		JML	f:loc_C67C1A
; ---------------------------------------------------------------------------

loc_C67C10:
		SEP	#$20
		DEC	z:$30,X
		BEQ	loc_C67C34
		JSL	f:random_wanderer_movement

loc_C67C1A:
		JSL	f:should_kill_enemy
		BCC	loc_C67C24
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C67C24:
		REP	#$20
.A16
		LDA	#$C0C
		STA	z:$40
		JSL	f:sub_C634FC
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C67C34:
		REP	#$20
		LDA	#.LOWORD(byte_C653D7)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C67C52)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C67C52)
		STA	z:2,X

loc_C67C52:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C67C5F
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C67C5F:
		BIT	#$90
		BEQ	loc_C67C67
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C67C67:
		BIT	#$41
		BEQ	loc_C67C6F
		JML	f:loc_C67C1A
; ---------------------------------------------------------------------------

loc_C67C6F:
		JSL	f:loc_C67C1A
		BCC	locret_C67C93
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C65408)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C67C94)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C67C94)
		STA	z:2,X

locret_C67C93:
		RTL
; End of function sub_C67BF3

.A8
.I16

sub_C67C94:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$20
		BEQ	loc_C67CA1
		JML	f:kill_enemy
; ---------------------------------------------------------------------------

loc_C67CA1:
		BIT	#$90
		BEQ	loc_C67CA9
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C67CA9:
		BIT	#$41
		BEQ	loc_C67CB1
		JML	f:loc_C67C1A
; ---------------------------------------------------------------------------

loc_C67CB1:
		JSL	f:loc_C67C1A
		BCC	locret_C67C93
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C65449)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C67CD6)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C67CD6)
		STA	z:2,X
		RTL
; End of function sub_C67C94

.A8
.I16

sub_C67CD6:
		JSL	f:loc_C67C1A
		BCS	loc_C67CE0
		JML	f:locret_C67C93
; ---------------------------------------------------------------------------

loc_C67CE0:
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C653CE)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C67BF3)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C67BF3)
		STA	z:2,X
		JSL	f:loc_C67BE6
		RTL
; End of function sub_C67CD6

; ---------------------------------------------------------------------------
off_C67D03:	.ADDR byte_C63E7E, byte_C63E8F,	byte_C63EB8, byte_C63EE5
off_C67D0B:	.ADDR byte_C64032, byte_C6403B,	byte_C64044, byte_C6404D
off_C67D13:	.ADDR byte_C641BE, byte_C641CF,	propene_animation, byte_C641F1
off_C67D1B:	.ADDR byte_C64386, byte_C643A7,	byte_C643C8, byte_C643E9
off_C67D23:	.ADDR byte_C6448A, byte_C6448A,	byte_C6448A, byte_C6448A
off_C67D2B:	.ADDR byte_C6456B, byte_C6457C,	byte_C6458D, byte_C6459E
off_C67D33:	.ADDR byte_C647BE, byte_C647C7,	byte_C647D0, byte_C647D9
off_C67D3B:	.ADDR byte_C647E2, byte_C647E7,	byte_C647EC, byte_C647F1
off_C67D43:	.ADDR byte_C64910, byte_C64910,	byte_C64910, byte_C64910
off_C67D4B:	.ADDR byte_C649D1, byte_C649EA,	byte_C64A13, byte_C64A5C
off_C67D53:	.ADDR byte_C64AFC, byte_C64AFC,	byte_C64AFC, byte_C64AFC
off_C67D5B:	.ADDR byte_C64C51, byte_C64C76,	byte_C64C9F, byte_C64CC4
off_C67D63:	.ADDR byte_C64894, byte_C6489D,	byte_C648A6, byte_C648AF
off_C67D6B:	.ADDR byte_C64E3D, byte_C64E4E,	byte_C64E6F, byte_C64E90
off_C67D73:	.ADDR byte_C65016, byte_C65027,	byte_C65038, byte_C65049
off_C67D7B:	.ADDR byte_C65236, byte_C6525F,	byte_C6528C, byte_C652B9
off_C67D83:	.ADDR byte_C653CE, byte_C653CE,	byte_C653CE, byte_C653CE
off_C67D8B:	.ADDR byte_C654D6, byte_C654D6,	byte_C654D6, byte_C654D6
off_C67D93:	.ADDR byte_C656F7, byte_C6571C,	byte_C65739, byte_C6575E
off_C67D9B:	.ADDR byte_C657E1, byte_C657E1,	byte_C657E1, byte_C657E1
off_C67DA3:	.ADDR byte_C65842, byte_C65842,	byte_C65842, byte_C65842
off_C67DAB:	.ADDR denkyun_animation, denkyun_animation, denkyun_animation, denkyun_animation
DATA_END
