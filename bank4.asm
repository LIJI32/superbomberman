.SEGMENT "BANK4"
.ORG $C40000

.DEFINE score_popup_s 0

.IF USE_MULTI5_BIOS
aStartOfMulti5B:.BYTE "START OF MULTI5 BIOS"
.A8
.I16
; e=0

multi5_read_input:
		PHP
		SEP	#$30
.I8
		STZ	a:.LOWORD(multitap_status)	; orig=0x0CE0

loc_C4001A:				; Wait for auto-joypad to complete
		LDA	a:.LOWORD(H_V_BLANK_FLAGS_AND_JOYPAD_STATUS)
		AND	#1
		BNE	loc_C4001A
		LDA	a:.LOWORD(JOYPAD_1_DATA_HIGH_BYTE)
		STA	a:.LOWORD(joypad_1+1) ; orig=0x0CE2
		LDA	a:.LOWORD(JOYPAD_1_DATA_LOW_BYTE)
		STA	a:.LOWORD(joypad_1) ; orig=0x0CE1
		AND	#$F
		STA	a:.LOWORD(joypad_1_connected) ; orig=0x0CEB
		LDA	a:.LOWORD($4016)
		LSR
		ROL	a:.LOWORD(joypad_1_connected) ; orig=0x0CEB
		LDA	a:.LOWORD(JOYPAD_2_DATA_HIGH_BYTE)

loc_C4003C:
		STA	a:.LOWORD(joypad_2+1) ; orig=0x0CE4
		LDA	a:.LOWORD(JOYPAD_2_DATA_LOW_BYTE)
		STA	a:.LOWORD(joypad_2) ; orig=0x0CE3
		AND	#$F
		STA	a:.LOWORD(joypad_2_connected) ; orig=0x0CEC
		LDA	a:.LOWORD(JOYPAD_4_DATA_HIGH_BYTE)
		STA	a:.LOWORD(joypad_3+1) ; orig=0x0CE6
		LDA	a:.LOWORD(JOYPAD_4_DATA_LOW_BYTE)
		STA	a:.LOWORD(joypad_3) ; orig=0x0CE5
		AND	#$F
		STA	a:.LOWORD(joypad_3_connected) ; orig=0x0CED
		LDA	a:.LOWORD($4017)
		LSR
		ROL	a:.LOWORD(joypad_2_connected) ; orig=0x0CEC
		LSR
		ROL	a:.LOWORD(joypad_3_connected) ; orig=0x0CED
		STZ	a:.LOWORD(PROGRAMMABLE_I_O_PORT_OUTPUT)
		LDY	#$10

loc_C4006B:
		LDA	a:.LOWORD($4017)
		REP	#$20
.A16
		LSR
		ROL	a:.LOWORD(joypad_4) ; orig=0x0CE7
		LSR
		ROL	a:.LOWORD(joypad_5) ; orig=0x0CE9
		SEP	#$20
.A8
		DEY
		BNE	loc_C4006B
		LDA	a:.LOWORD(joypad_4) ; orig=0x0CE7
		AND	#$F
		STA	a:.LOWORD(joypad_4_connected) ; orig=0x0CEE
		LDA	a:.LOWORD(joypad_5) ; orig=0x0CE9
		AND	#$F
		STA	a:.LOWORD(joypad_5_connected) ; orig=0x0CEF
		LDA	a:.LOWORD($4017)
		LSR
		ROL	a:.LOWORD(joypad_4_connected) ; orig=0x0CEE
		LSR
		ROL	a:.LOWORD(joypad_5_connected) ; orig=0x0CEF
		LDA	#$80
		STA	a:.LOWORD(PROGRAMMABLE_I_O_PORT_OUTPUT)
		PLP
.I16
		RTS
; End of function multi5_read_input

; ---------------------------------------------------------------------------
.BYTE "MODIFIED FROM SHVC MULTI5 BIOS Ver2.00"
.BYTE "END OF MULTI5 BIOS"
.A8
.I16

multi5_update_multitap_status:
		PHP
		SEP	#$30
.I8
		STZ	a:.LOWORD(multitap_status)	; orig=0x0CE0

loc_C400DD:				; Wait for auto-joypad to finish
		LDA	a:.LOWORD(H_V_BLANK_FLAGS_AND_JOYPAD_STATUS)
		AND	#1
		BNE	loc_C400DD
		STZ	a:.LOWORD($4016)
		LDA	#1
		STA	a:.LOWORD($4016)
		LDX	#8

loc_C400EE:
		LDA	a:.LOWORD($4016)
		LSR
		LSR
		ROL	AZ .LOWORD(word_7E0040+1) ;	orig=0x0041

loc_C400F6:
		LDA	a:.LOWORD($4017)
		LSR
		LSR
		ROL	AZ .LOWORD(word_7E0042+1) ;	orig=0x0043
		DEX
		BNE	loc_C400EE
		STZ	a:.LOWORD($4016)
		LDX	#8

loc_C40106:
		LDA	a:.LOWORD($4016)
		LSR
		LSR
		ROL	AZ .LOWORD(word_7E0040) ; orig=0x0040
		LDA	a:.LOWORD($4017)
		LSR
		LSR
		ROL	AZ .LOWORD(word_7E0042) ; orig=0x0042
		DEX
		BNE	loc_C40106
		LDA	AZ .LOWORD(word_7E0040+1) ;	orig=0x0041
		CMP	#$FF
		BNE	loc_C4012C
		LDA	AZ .LOWORD(word_7E0040) ; orig=0x0040
		CMP	#$FF
		BEQ	loc_C4012C
		LDA	#$80
		STA	a:.LOWORD(multitap_status)	; orig=0x0CE0

loc_C4012C:
		LDA	AZ .LOWORD(word_7E0042+1) ;	orig=0x0043
		CMP	#$FF
		BNE	loc_C40142
		LDA	AZ .LOWORD(word_7E0042) ; orig=0x0042
		CMP	#$FF
		BEQ	loc_C40142

loc_C4013A:
		LDA	#$40
		ORA	a:.LOWORD(multitap_status)	; orig=0x0CE0
		STA	a:.LOWORD(multitap_status)	; orig=0x0CE0

loc_C40142:
		PLP
.I16
		RTS
; End of function multi5_update_multitap_status

; ---------------------------------------------------------------------------
aModifiedFromSh:.BYTE "MODIFIED FROM SHVC MULTI5 CONNECT CHECK Ver1.00"
aEndOfMulti5Con:.BYTE "END OF MULTI5 CONNECT CHECK"
.ENDIF ; USE_MULTI5_BIOS

.A8
.I8

main:
.IFNDEF J
		SEP	#$20
.ENDIF
		STZ	a:.LOWORD(NMI_V_H_COUNT_AND_JOYPAD_ENABLE)
		STZ	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		STZ	a:.LOWORD(REGULAR_DMA_CHANNEL_ENABLE)
		STZ	a:.LOWORD(REGULAR_DMA_CHANNEL_ENABLE)
		STZ	a:.LOWORD(APU_I_O_PORT_0)
		STZ	a:.LOWORD(APU_I_O_PORT_1)
		STZ	a:.LOWORD(APU_I_O_PORT_2)
		STZ	a:.LOWORD(APU_I_O_PORT_3)
		LDA	#$8F
		STA	a:.LOWORD(SCREEN_DISPLAY_REGISTER)
.IFDEF J
        CLC
        XCE
        SEI
		SEP	#$20
.ENDIF
		LDA	#0
		PHA
		PLB
		REP	#$30
.A16
.I16
		LDA	#$2FF
		TCS
		REP	#$20
		LDA	#0
		TAX			; Clear	RAM

loc_C401BD:
		STA	f:$7F0000,X
		INX
		INX
		BNE	loc_C401BD
		LDA	#$2000
		TAX

loc_C401C9:				; Clear	tilemaps
		STA	f:$7E0000,X
		INX
		INX
		BNE	loc_C401C9
		LDA	a:.LOWORD(word_7E0C7F) ; orig=0x0C7F
		STA	f:temp_uncompressed_graphics
		LDA	a:.LOWORD(word_7E0C81) ; orig=0x0C81
		STA	f:temp_uncompressed_graphics+2
		LDA	a:.LOWORD(word_7E0C83) ; orig=0x0C83
		STA	f:byte3_7E2804
		LDA	a:.LOWORD(word_7E0C85) ; orig=0x0C85
		STA	f:byte3_7E2804+2
		LDA	a:.LOWORD(word_7E0C87) ; orig=0x0C87
		STA	f:byte3_7E2808
		LDA	a:.LOWORD(word_7E0C89) ; orig=0x0C89
		STA	f:byte3_7E2808+2
		LDA	a:.LOWORD(word_7E0C8B) ; orig=0x0C8B
		STA	f:byte3_7E280C
		LDA	a:.LOWORD(word_7E0C8D) ; orig=0x0C8D
		STA	f:byte3_7E280C+2
		LDA	#0
		TAX

loc_C4020D:
		STA	f:0,X
		INX
		INX
		CPX	#$2000
		BNE	loc_C4020D
		LDA	f:byte3_7E280C
		STA	a:.LOWORD(word_7E0C8B) ; orig=0x0C8B
		LDA	f:byte3_7E280C+2
		STA	a:.LOWORD(word_7E0C8D) ; orig=0x0C8D
		LDA	a:.LOWORD(word_7E0C8B) ; orig=0x0C8B
		CMP	#$6D61
		BNE	loc_C40280
		LDA	a:.LOWORD(word_7E0C8D) ; orig=0x0C8D
		CMP	#$6B6F
		BNE	loc_C40280
		LDA	f:temp_uncompressed_graphics
		CMP	f:byte3_7E2804
		BNE	loc_C40280
		CMP	f:byte3_7E2808
		BNE	loc_C40280
		LDA	f:temp_uncompressed_graphics+2
		CMP	f:byte3_7E2804+2
		BNE	loc_C40280
		CMP	f:byte3_7E2808+2
		BNE	loc_C40280
		LDA	f:temp_uncompressed_graphics
		STA	a:.LOWORD(word_7E0C7F) ; orig=0x0C7F
		LDA	f:temp_uncompressed_graphics+2
		STA	a:.LOWORD(word_7E0C81) ; orig=0x0C81
		LDA	f:byte3_7E2804
		STA	a:.LOWORD(word_7E0C83) ; orig=0x0C83
		LDA	f:byte3_7E2804+2
		STA	a:.LOWORD(word_7E0C85) ; orig=0x0C85
		LDA	f:byte3_7E2808
		STA	a:.LOWORD(word_7E0C87) ; orig=0x0C87
		LDA	f:byte3_7E2808+2
		STA	a:.LOWORD(word_7E0C89) ; orig=0x0C89

loc_C40280:
		LDA	#$6D61
		STA	a:.LOWORD(word_7E0C8B) ; orig=0x0C8B
		LDA	#$6B6F
		STA	a:.LOWORD(word_7E0C8D) ; orig=0x0C8D
		JSL	f:interrupt_register_init
		JSL	f:gpu_registers_init
		JSL	f:init_dboot
		JSL	f:dboot_related_
		JSL	f:unknown_init_
		JSL	f:dma_reset
		REP	#$20
		LDA	#$4000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(bg3_tileset_graphic)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(bg3_tileset_graphic)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		REP	#$20
.A16
		LDA	#$58C0
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$680
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(bg3_ram_map)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(bg3_ram_map)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		REP	#$20
.A16
		LDA	#$3FF
		STA	a:.LOWORD(bg3_v_scroll_2) ; orig=0x0CA7
		REP	#$20
		LDA	#.LOWORD(sub_C4633F)
		STA	a:.LOWORD(level_manager_object+object::handler) ; orig=0x0D00
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C4633F)
		STA	a:.LOWORD(level_manager_object+object::handler+2) ; orig=0x0D02
.IFNDEF J
; Moved up
		REP	#$20
.A16
		LDA	#.LOWORD(nullsub_1)
		STA	AZ2 .LOWORD(unknown_function_pointer) ; orig=0x00D0
		SEP	#$20
.A8
		LDA	#.BANKBYTE(nullsub_1)
		STA	AZ2 .LOWORD(unknown_function_pointer+2) ; orig=0x00D2
.ENDIF
		SEP	#$20
		CLI
.IFDEF J
        LDA	#$B1
        STA	a:.LOWORD(NMI_V_H_COUNT_AND_JOYPAD_ENABLE)
.ENDIF
		LDA	#$20
		STA	a:.LOWORD(V_COUNT_TIMER)
		LDA	#$B8
		STA	a:.LOWORD(H_COUNT_TIMER)
.IFDEF J
		REP	#$20
.A16
		LDA	#.LOWORD(nullsub_1)
		STA	a:.LOWORD(unknown_function_pointer) ; orig=0x00D0
		SEP	#$20
.A8
		LDA	#.BANKBYTE(nullsub_1)
		STA	a:.LOWORD(unknown_function_pointer+2) ; orig=0x00D2
		SEP	#$20
.ELSE
        LDA	#$B1
        STA	a:.LOWORD(NMI_V_H_COUNT_AND_JOYPAD_ENABLE)
.ENDIF
		LDA	#$17
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$17
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#1
		STA	a:.LOWORD(CYCLE_SPEED_DESIGNATION)
		LDA	#%111001
		STA	a:.LOWORD(BG_MODE_AND_TILE_SIZE_SETTING)
		LDA	#$8F
		STA	a:.LOWORD(word_7E031A) ; orig=0x031A
		REP	#$20
.A16
		LDY	#0
		JSL	f:dboot_19
		REP	#$30
.A8

wait_for_vblank:
		SEP	#$20
		LDA	a:.LOWORD(screen_flags) ; orig=0x0312
		BIT	#1
		BEQ	wait_for_vblank
		SEP	#$20
		LDA	#$8F
		STA	a:.LOWORD(SCREEN_DISPLAY_REGISTER)
		STZ	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		JSL	f:transfer_oam
		JSL	f:transfer_bg1_bg3_tilemaps
		JSL	f:sub_C62460
		SEP	#$20
		LDA	a:.LOWORD(word_7E031A) ; orig=0x031A
		STA	a:.LOWORD(SCREEN_DISPLAY_REGISTER)
		LDA	a:.LOWORD(byte_7E0CA9) ; orig=0x0CA9
		STA	a:.LOWORD(MOSAIC_SIZE_AND_BG_ENABLE)
		JSL	f:update_bg_scrolling
		JSL	f:handle_player_input
.IFDEF DEBUG
        JSL f:transfer_debug_menu_to_vram
        JSL f:clear_vs_check_graphics
.ENDIF
		REP	#$20
.A16
		LDA	#.LOWORD(player2_object+player::anonymous_6)
		STA	a:.LOWORD(word_7E00BE) ; orig=0x00BE
		LDA	#.LOWORD(player1_object+player::anonymous_6)
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_7) ; orig=0x0D28
		LDA	#$FFFF
		STA	a:.LOWORD(player1_object+player::anonymous_6) ; orig=0x0D68
		REP	#$20
		LDA	#.LOWORD(unk_7F0000)
		STA	a:.LOWORD(word_7E0306) ; orig=0x0306
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7F0000)
		STA	a:.LOWORD(word_7E0308) ; orig=0x0308
		REP	#$20
.A16
		LDX	#.LOWORD(level_manager_object)
		LDA	a:.LOWORD(level_manager_object+object::handler+1) ; orig=0x0D01
		STA	AZ .LOWORD(byte_7E0051)
		LDA	a:.LOWORD(level_manager_object+object::handler) ; orig=0x0D00
		STA	AZ .LOWORD(byte_7E0050) ; orig=0x0050
		JSL	f:call_function_at_0050
		REP	#$20
		LDX	#.LOWORD(player1_object)
		LDA	#4

loc_C403B7:
		PHA
		STX	a:.LOWORD(word_7E0310) ; orig=0x0310
		LDA	AZ .LOWORD(player::gameover_related),X
		BIT	#1
		BEQ	loc_C403D5
		LDA	AZ .LOWORD(object::handler+1),X
		STA	AZ .LOWORD(byte_7E0051) ; orig=0x0051
		LDA	AZ .LOWORD(object::handler),X
		STA	AZ .LOWORD(byte_7E0050) ; orig=0x0050
		JSL	f:call_function_at_0050
		REP	#$20

loc_C403D5:
		LDA	a:.LOWORD(word_7E0310) ; orig=0x0310
		CLC
		ADC	#$40
		TAX
		PLA
		DEC
		BNE	loc_C403B7
		LDX	#.LOWORD(enemy_objects)

loc_C403E4:
		LDA	AZ .LOWORD(1),X
		STA	AZ .LOWORD(byte_7E0051) ; orig=0x0051
		LDA	AZ .LOWORD(0),X
		STA	AZ .LOWORD(byte_7E0050) ; orig=0x0050
		JSL	f:call_function_at_0050
		REP	#$20
		LDA	AZ .LOWORD(6),X
		TAX
		INC
		BNE	loc_C403E4
		REP	#$20
		LDY	a:.LOWORD(level_manager_object+level_manager_object::anonymous_7) ; orig=0x0D28

loc_C40402:
		LDX	a: .LOWORD(2),Y
		LDA	a: .LOWORD(0),Y
		CMP	#$FFFF
		BEQ	loc_C40417
		PHA
		JSL	f:sub_C625D3
		PLY
		REP	#$20
		BRA	loc_C40402
; ---------------------------------------------------------------------------

loc_C40417:
		REP	#$20
		LDX	#.LOWORD(unk_7E1C80)

loc_C4041C:
		LDA	AZ .LOWORD(6),X
		CMP	#$FFFF
		BEQ	loc_C4043A
		PHA
		LDA	#$C4
		STA	AZ .LOWORD(byte_7E0052) ; orig=0x0052
		LDA	AZ .LOWORD(0),X
		STA	AZ .LOWORD(byte_7E0050) ; orig=0x0050
		JSL	f:call_function_at_0050
		REP	#$20
		PLX
		BRA	loc_C4041C
; ---------------------------------------------------------------------------

loc_C4043A:
		JSL	f:related_to_oam_transfer
		JSL	f:update_palettes
		SEP	#$20
.A8
		LDA	a:.LOWORD(screen_flags) ; orig=0x0312
		AND	#$FE
		STA	a:.LOWORD(screen_flags) ; orig=0x0312
		JMP	a:.LOWORD(wait_for_vblank)
; End of function main

.A16
.I16

call_function_at_0050:
		JMP	[$50]
; ---------------------------------------------------------------------------
		RTI
; End of function call_function_at_0050

.A8
.I16

update_bg_scrolling:
		SEP	#$20
		LDA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		STA	a:.LOWORD(BG_1_H_SCROLL_OFFSET)
		LDA	a:.LOWORD(bg1_h_scroll+1) ; orig=0x0C9E
		STA	a:.LOWORD(BG_1_H_SCROLL_OFFSET)
		LDA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		STA	a:.LOWORD(BG_1_V_SCROLL_OFFSET)
		LDA	a:.LOWORD(bg1_v_scroll+1) ; orig=0x0CA0
		STA	a:.LOWORD(BG_1_V_SCROLL_OFFSET)
		LDA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		STA	a:.LOWORD(BG_2_H_SCROLL_OFFSET)
		LDA	a:.LOWORD(bg2_h_scroll+1) ; orig=0x0CA2
		STA	a:.LOWORD(BG_2_H_SCROLL_OFFSET)
		LDA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		STA	a:.LOWORD(BG_2_V_SCROLL_OFFSET)
		LDA	a:.LOWORD(bg2_v_scroll+1) ; orig=0x0CA4
		STA	a:.LOWORD(BG_2_V_SCROLL_OFFSET)
		RTL
; End of function update_bg_scrolling

.A8
.I16

transfer_bg1_bg3_tilemaps:
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		CMP	#$30
		BEQ	locret_C404DF
		LDA	#1
		STA	a:.LOWORD(DMA_5_PARAMS)
		STA	a:.LOWORD(DMA_6_PARAMS)
		LDA	#$18
		STA	a:.LOWORD(DMA_5_B_ADDRESS)
		STA	a:.LOWORD(DMA_6_B_ADDRESS)
		REP	#$20
.A16
		LDA	#$5000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$322
		STA	a:.LOWORD(DMA_5_BYTES_COUNT_LOW_BYTE)
		LDA	#.LOWORD(bg1_tilemap)
		STA	a:.LOWORD(DMA_5_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#0
		STA	a:.LOWORD(DMA_5_A_ADDRESS_BANK)
		LDA	#$20
		STA	a:.LOWORD(REGULAR_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$5800
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$100
		STA	a:.LOWORD(DMA_6_BYTES_COUNT_LOW_BYTE)
		LDA	#$816
		STA	a:.LOWORD(DMA_6_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#0
		STA	a:.LOWORD(DMA_6_A_ADDRESS_BANK)
		LDA	#$40
		STA	a:.LOWORD(REGULAR_DMA_CHANNEL_ENABLE)

locret_C404DF:
		RTL
; End of function transfer_bg1_bg3_tilemaps

.A8
.I8

vblank:
		REP	#$30
.A16
.I16
		PHB
		PHA
		PHX
		PHY
		SEP	#$30
.A8
.I8
		LDA	#0
		PHA
		PLB
		CMP	f:NMI_ENABLE
		LDA	f:.LOWORD(screen_flags) ; orig=0x0312
		BIT	#1
		BNE	loc_C404FE
		ORA	#1
		STA	f:.LOWORD(screen_flags) ; orig=0x0312

loc_C404FE:
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		BIT	#2
		BEQ	loc_C40525
		LDA	#4
		STA	a:.LOWORD(BG_AND_OBJECT_ENABLE_MAIN_SCREEN)
		LDA	#0
		STA	a:.LOWORD(BG_AND_OBJECT_ENABLE_SUB_SCREEN)
		LDA	#0
		STA	a:.LOWORD(INITIAL_SETTINGS_FOR_COLOR_ADDITION)
		LDA	#0
		STA	a:.LOWORD(ADD_SUBTRACT_SELECT_AND_ENABLE)
		LDA	a:.LOWORD(bg3_v_scroll_2) ; orig=0x0CA7
		STA	a:.LOWORD(BG_3_V_SCROLL_OFFSET)
		LDA	a:.LOWORD(bg3_v_scroll_2+1) ; orig=0x0CA8
		STA	a:.LOWORD(BG_3_V_SCROLL_OFFSET)

loc_C40525:
		REP	#$30
.A16
.I16
		INC	a:.LOWORD(frame_count) ; orig=0x0300
		PLY
		PLX
		PLA
		PLB
		RTI
; End of function vblank

.A8
.I8

irq:
		REP	#$30
.A16
.I16
		PHB
		PHA
		PHX
		PHY
		SEP	#$30
.A8
.I8
		LDA	#0
		PHA
		PLB
		LDA	a:.LOWORD(IRQ_FLAG_BY_H_V_COUNT_TIMER)
		BPL	loc_C40572
		LDA	a:.LOWORD(bg3_v_scroll) ; orig=0x0CA5
		STA	a:.LOWORD(BG_3_V_SCROLL_OFFSET)
		LDA	a:.LOWORD(bg3_v_scroll+1) ; orig=0x0CA6
		STA	a:.LOWORD(BG_3_V_SCROLL_OFFSET)
		LDA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		STA	a:.LOWORD(BG_AND_OBJECT_ENABLE_MAIN_SCREEN)
		LDA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		STA	a:.LOWORD(BG_AND_OBJECT_ENABLE_SUB_SCREEN)
		LDA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		STA	a:.LOWORD(INITIAL_SETTINGS_FOR_COLOR_ADDITION)
		LDA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		STA	a:.LOWORD(ADD_SUBTRACT_SELECT_AND_ENABLE)
		JSL	f:call_function_at_00d0
		LDA	#$81
		STA	a:.LOWORD(NMI_V_H_COUNT_AND_JOYPAD_ENABLE)
		LDA	#$B1
		STA	a:.LOWORD(NMI_V_H_COUNT_AND_JOYPAD_ENABLE)

loc_C40572:
		REP	#$30
.A16
.I16
		PLY
		PLX
		PLA
		PLB
		RTI
; End of function irq

.A8
.I8

call_function_at_00d0:
		JMP	[$D0]
; ---------------------------------------------------------------------------
		RTI
; End of function call_function_at_00d0

.A8
.I8

nullsub_1:
		RTL
; End of function nullsub_1

.A8
.I16

gameover_writing_object:
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C40592)
		STA	AZ .LOWORD(0),X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C40592)
		STA	AZ .LOWORD(2),X
		REP	#$20
.A16
		STZ	AZ .LOWORD($20),X

loc_C40592:
		SEP	#$20
.A8
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#2		; single object::handler
		BEQ	loc_C4059F
		JML	f:nullsub_2
; ---------------------------------------------------------------------------

loc_C4059F:
		REP	#$20
.A16
		INC	AZ .LOWORD($20),X
		LDA	AZ .LOWORD($20),X
		STA	AZ .LOWORD(word_7E0048) ; orig=0x0048
		PHX
		LDX	#.LOWORD(player1_object)
		JSL	f:write_gameover_for_player_if_needed
		LDX	#.LOWORD(player2_object)
		JSL	f:write_gameover_for_player_if_needed
		PLX
		RTL
; End of function gameover_writing_object

.A16
.I16

write_gameover_for_player_if_needed:
		REP	#$20
		LDA	AZ .LOWORD(4),X
		BIT	#$FF
		BEQ	loc_C405C9
		JML	f:nullsub_2
; ---------------------------------------------------------------------------

loc_C405C9:
		TXA
		EOR	#$C0       ; Clever way to get the other object::handler
		TAY
		LDA	#$46
		STA	AZ .LOWORD(word_7E0040) ; orig=0x0040
		LDA	AZ .LOWORD(5),X
		AND	#$FF
		BEQ	loc_C405E2
		LDA	#$68
		STA	AZ .LOWORD(word_7E0040) ; orig=0x0040

loc_C405E2:
		LDA	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		AND	#$FF
.IF SHORT_GAMEOVER_BRANCH
    BEQ write_gameover
.ELSE
		BNE	loc_C405EE
		JML	f:write_gameover
.ENDIF
; ---------------------------------------------------------------------------

loc_C405EE:
		LDA	a:.LOWORD($3D),Y
		AND	#$FF
		BNE	loc_C405FA
		JML	f:write_gameover
; ---------------------------------------------------------------------------

loc_C405FA:
		LDY	AZ .LOWORD(word_7E0040) ; orig=0x0040
		LDA	#$B
		STA	AZ .LOWORD(word_7E0040) ; orig=0x0040
		REP	#$20
		LDA	#.LOWORD(word_C30B2A)
		STA	AZ .LOWORD(byte_7E0050) ; orig=0x0050
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C30B2A)
		STA	AZ .LOWORD(byte_7E0052) ; orig=0x0052
		JSL	f:copy_to_bg3_tilemap
		REP	#$20
.A16
		TYA
		CLC
		ADC	#$2A
		TAY
		LDA	#$B
		STA	AZ .LOWORD(word_7E0040) ; orig=0x0040
		JSL	f:copy_to_bg3_tilemap
		RTL
; End of function write_gameover_for_player_if_needed

.A16
.I16

hud_related:
		REP	#$20
		LDA	#$B
		STA	AZ .LOWORD(word_7E0040) ; orig=0x0040
		REP	#$20
		LDA	#.LOWORD(storymode_hud_tilemap+$46)
		STA	AZ .LOWORD(byte_7E0050) ; orig=0x0050
		SEP	#$20
.A8
		LDA	#.BANKBYTE(storymode_hud_tilemap+$46)
		STA	AZ .LOWORD(byte_7E0052) ; orig=0x0052
		JSL	f:copy_to_bg3_tilemap
		REP	#$20
.A16
		TYA
		CLC
		ADC	#$2A
		TAY
		LDA	#$B
		STA	AZ .LOWORD(word_7E0040) ; orig=0x0040
		REP	#$20
		LDA	#.LOWORD(storymode_hud_tilemap+$86)
		STA	AZ .LOWORD(byte_7E0050) ; orig=0x0050
		SEP	#$20
.A8
		LDA	#.BANKBYTE(storymode_hud_tilemap+$86)
		STA	AZ .LOWORD(byte_7E0052) ; orig=0x0052
		JSL	f:copy_to_bg3_tilemap
		REP	#$20
.A16
		STZ	AZ .LOWORD(word_7E0040) ; orig=0x0040
		STZ	AZ .LOWORD(word_7E0042) ; orig=0x0042
		JSL	f:add_to_score
		RTL
; End of function hud_related

.A16
.I16

write_gameover:
		REP	#$20
		LDY	AZ .LOWORD(word_7E0040) ; orig=0x0040
		LDA	#$B
		STA	AZ .LOWORD(word_7E0040) ; orig=0x0040
		REP	#$20
		LDA	#.LOWORD(gameover_tilemap_top)
		STA	AZ .LOWORD(byte_7E0050) ; orig=0x0050
		SEP	#$20
.A8
		LDA	#.BANKBYTE(gameover_tilemap_top)
		STA	AZ .LOWORD(byte_7E0052) ; orig=0x0052
		JSL	f:copy_to_bg3_tilemap
		REP	#$20
.A16
		TYA
		CLC
		ADC	#$2A
		TAY
		LDA	#$B
		STA	AZ .LOWORD(word_7E0040) ; orig=0x0040
		JSL	f:copy_to_bg3_tilemap
; End of function write_gameover

.A16
.I16

nullsub_2:
		RTL
; End of function nullsub_2

; ---------------------------------------------------------------------------
		SEP	#$20
.A8
.I16

hud_related_object:
		REP	#$20
.A16
		STZ	AZ .LOWORD($10),X
		STZ	AZ .LOWORD($12),X
		REP	#$20
		LDA	#.LOWORD(loc_C406BC)
		STA	AZ .LOWORD(0),X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C406BC)
		STA	AZ .LOWORD(2),X

loc_C406BC:
		SEP	#$20
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#2		; story	mode
		BEQ	loc_C406D0
		CMP	#3		; battle mode
		BNE	loc_C406CD
		JML	f:loc_C407C9
; ---------------------------------------------------------------------------

loc_C406CD:
		JMP	a:.LOWORD(locret_C40768)
; ---------------------------------------------------------------------------

loc_C406D0:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C406DD
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C406DD:				; is paused or debug-paused
		BIT	#$41
		BEQ	loc_C406E5
		JML	f:locret_C40768
; ---------------------------------------------------------------------------

loc_C406E5:
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$C
		BEQ	loc_C406F3
		JML	f:locret_C40768
; ---------------------------------------------------------------------------

loc_C406F3:
		INC	AZ .LOWORD($12),X
		LDA	AZ .LOWORD($12),X
		CMP	a:.LOWORD(level_manager_object+level_manager_object::anonymous_10) ; orig=0x0D3A
		BNE	locret_C40768
		STZ	AZ .LOWORD($12),X
		SEP	#$20
.A8
		LDY	#$5E
		INC	AZ .LOWORD($10),X
		LDA	AZ .LOWORD($10),X
		AND	#7
		STA	AZ .LOWORD($10),X
		ASL
		ADC	#$C0
		STA	a:.LOWORD(bg3_tilemap),Y
		INC
		STA	a:.LOWORD(bg3_tilemap+2),Y
		CLC
		ADC	#$F
		STA	a:.LOWORD(bg3_tilemap+$40),Y
		INC
		STA	a:.LOWORD(bg3_tilemap+$42),Y
		LDA	AZ .LOWORD($10),X
		BNE	locret_C40768
		LDA	a:.LOWORD(player1_object+player::gameover_related)	; orig=0x0D44
		BEQ	loc_C40746
		LDY	a:.LOWORD(word_7E0CAA) ; orig=0x0CAA
		CPY	#$1C
		BNE	loc_C4073B
		JML	f:hurry_up
; ---------------------------------------------------------------------------

loc_C4073B:
		LDA	#$A7
		STA	a:.LOWORD(bg3_tilemap+$C2),Y
		INC	a:.LOWORD(word_7E0CAA) ; orig=0x0CAA
		INC	a:.LOWORD(word_7E0CAA) ; orig=0x0CAA

loc_C40746:
		LDA	a:.LOWORD(player2_object+player::gameover_related)	; orig=0x0D84
		BEQ	locret_C40768
		LDA	a:.LOWORD(word_7E0CAC) ; orig=0x0CAC
		CMP	#$1C
		BNE	loc_C40756
		JML	f:hurry_up
; ---------------------------------------------------------------------------

loc_C40756:
		SEC
		SBC	#$BC
		EOR	#$FF
		INC
		TAY
		LDA	#$A7
		STA	a:.LOWORD(bg3_tilemap+$40),Y
		INC	a:.LOWORD(word_7E0CAC) ; orig=0x0CAC
		INC	a:.LOWORD(word_7E0CAC) ; orig=0x0CAC

locret_C40768:
		RTL
; ---------------------------------------------------------------------------
.A16

loc_C40769:
		REP	#$20
		LDA	#.LOWORD(locret_C407C8)
		STA	AZ .LOWORD(0),X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(locret_C407C8)
		STA	AZ .LOWORD(2),X
		JSL	f:sub_C53BF7
		REP	#$20
.A16
		PHX
		LDX	#.LOWORD(player1_object)

loc_C40782:
		LDA	AZ .LOWORD(4),X
		AND	#$FF
		BEQ	loc_C407BA
		LDA	AZ .LOWORD($2F),X
		BIT	#1
		BNE	loc_C407BA
		LDA	AZ .LOWORD(7),X
		BIT	#1
		BNE	loc_C407AB
		REP	#$20
		LDA	#.LOWORD(player_death)
		STA	AZ .LOWORD(0),X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(player_death)
		STA	AZ .LOWORD(2),X
		BRA	loc_C407BA
; ---------------------------------------------------------------------------

loc_C407AB:
		REP	#$20
.A16
		LDA	#.LOWORD(death_related)
		STA	AZ .LOWORD(0),X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(death_related)
		STA	AZ .LOWORD(2),X

loc_C407BA:
		REP	#$20
.A16
		TXA
		CLC
		ADC	#$40
		TAX
		CMP	#$E40
		BNE	loc_C40782
		PLX

locret_C407C8:
		RTL
; ---------------------------------------------------------------------------
.A8

loc_C407C9:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C407D6
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C407D6:
		BIT	#$41
		BEQ	loc_C407DE
		JML	f:loc_C40816
; ---------------------------------------------------------------------------

loc_C407DE:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$C
		BEQ	loc_C407EB
		JML	f:loc_C40816
; ---------------------------------------------------------------------------

loc_C407EB:
		REP	#$20
.A16
		INC	AZ .LOWORD($10),X
		LDA	AZ .LOWORD($10),X
		; Since the FPS is dropped in the PAL version, but each match still takes 2
		; minutes, it means that gameplay-wise, each match is shorter in the PAL
		; version!
		CMP	#.LOWORD(FPS)
		BEQ	loc_C407FC
		JML	f:locret_C40887
; ---------------------------------------------------------------------------

loc_C407FC:
		STZ	AZ .LOWORD($10),X
		SED
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_10) ; orig=0x0D3A
		SEC
		SBC	#1
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_10) ; orig=0x0D3A
		CLD
		SEP	#$20
.A8
		CMP	#$60
		BCC	loc_C40816
		LDA	#$59
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_10) ; orig=0x0D3A

loc_C40816:
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_10) ; orig=0x0D3A
		AND	#$F
		ASL
		PHX
		TAX
		LDA	f:hud_digits_tilenos_upper,X
		STA	a:.LOWORD(bg3_tilemap+$62)	; orig=0x0878
		CLC
		ADC	#$10
		STA	a:.LOWORD(bg3_tilemap+$A2)	; orig=0x08B8
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_10) ; orig=0x0D3A
		AND	#$F0
		LSR
		LSR
		LSR
		TAX
		LDA	f:hud_digits_tilenos_upper,X
		STA	a:.LOWORD(bg3_tilemap+$60)	; orig=0x0876
		CLC
		ADC	#$10
		STA	a:.LOWORD(bg3_tilemap+$A0)	; orig=0x08B6
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_10+1) ; orig=0x0D3B
		AND	#$F
		ASL
		TAX
		LDA	f:hud_digits_tilenos_upper,X
		STA	a:.LOWORD(bg3_tilemap+$5C)	; orig=0x0872
		CLC
		ADC	#$10
		STA	a:.LOWORD(bg3_tilemap+$9C)	; orig=0x08B2
		PLX
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C4086B
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C4086B:
		BIT	#$41
		BEQ	loc_C40873
		JML	f:locret_C40887
; ---------------------------------------------------------------------------

loc_C40873:
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_10) ; orig=0x0D3A
		BNE	loc_C4087E
		JML	f:loc_C40769
; ---------------------------------------------------------------------------

loc_C4087E:
		CMP	#$100
		BNE	locret_C40887
		JSL	f:sub_C53B5D
.A8

locret_C40887:
		RTL
; End of function hud_related_object

.A8
.I16

hurry_up:
		REP	#$20
.A16
		LDA	#$100
		STA	AZ .LOWORD($12),X
		LDY	#5
		JSL	f:play_sound
		REP	#$20
		LDA	#.LOWORD(loc_C408A6)
		STA	AZ .LOWORD(0),X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C408A6)
		STA	AZ .LOWORD(2),X

loc_C408A6:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C408B3
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C408B3:				; is paused or debug-paused
		BIT	#$41
		BEQ	loc_C408BB
		JML	f:locret_C40768
; ---------------------------------------------------------------------------

loc_C408BB:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$C
		BEQ	loc_C408C8
		JML	f:locret_C40768
; ---------------------------------------------------------------------------

loc_C408C8:
		LDA	a:.LOWORD(word_7E0CAA) ; orig=0x0CAA
		CMP	#$1C
		BEQ	loc_C408D6
		LDA	a:.LOWORD(word_7E0CAC) ; orig=0x0CAC
		CMP	#$1C
		BNE	loc_C40953

loc_C408D6:
		LDY	#$DE
		INC	AZ .LOWORD($10),X
		LDA	AZ .LOWORD($10),X
		ROR
		LDA	#$BC
		BCS	loc_C408E6
		LDA	#$AC

loc_C408E6:
		STA	a:.LOWORD(bg3_tilemap),Y
		INC
		STA	a:.LOWORD(bg3_tilemap+2),Y
		LDY	#$5E
		LDA	AZ .LOWORD($10),X
		AND	#3
		STA	AZ .LOWORD($10),X
		ASL
		ADC	#$E0
		STA	a:.LOWORD(bg3_tilemap),Y
		INC
		STA	a:.LOWORD(bg3_tilemap+2),Y
		CLC
		ADC	#$F
		STA	a:.LOWORD(bg3_tilemap+$40),Y
		INC
		STA	a:.LOWORD(bg3_tilemap+$42),Y
		REP	#$20
.A16
		DEC	AZ .LOWORD($12),X
		BNE	locret_C40962
		LDA	a:.LOWORD(word_7E0CAA) ; orig=0x0CAA
		CMP	#$1C
		BNE	loc_C40934
		LDA	a:.LOWORD(player1_object+player::anonymous_7) ; orig=0x0D6F
		BIT	#1
		BNE	loc_C40934
		REP	#$20
		LDA	#.LOWORD(player_death)
		STA	a:.LOWORD(player1_object+object::handler) ; orig=0x0D40
		SEP	#$20
.A8
		LDA	#.BANKBYTE(player_death)
		STA	a:.LOWORD(player1_object+object::handler+2) ; orig=0x0D42
		REP	#$20
.A16

loc_C40934:
		LDA	a:.LOWORD(word_7E0CAC) ; orig=0x0CAC
		CMP	#$1C
		BNE	loc_C40953
		LDA	a:.LOWORD(player2_object+player::anonymous_7) ; orig=0x0DAF
		BIT	#1
		BNE	loc_C40953
		REP	#$20
		LDA	#.LOWORD(player_death)
		STA	a:.LOWORD(player2_object+object::handler) ; orig=0x0D80
		SEP	#$20
.A8
		LDA	#.BANKBYTE(player_death)
		STA	a:.LOWORD(player2_object+object::handler+2) ; orig=0x0D82

loc_C40953:
		REP	#$20
.A16
		LDA	#.LOWORD(hud_related_object)
		STA	AZ .LOWORD(0),X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(hud_related_object)
		STA	AZ .LOWORD(2),X

locret_C40962:
		RTL
; End of function hurry_up

.A8
.I16

handle_player_input:
.IF USE_MULTI5_BIOS
		JSR	a:.LOWORD(.LOWORD(multi5_read_input))
		JSR	a:.LOWORD(.LOWORD(multi5_update_multitap_status))
		JMP	a:.LOWORD(loc_C409FE)
.ENDIF
; This code never runs if MULTI5 BIOS is used.
		SEP	#$20
		LDX	#0

loc_C40971:
		STZ	a:.LOWORD($CE0),X
		INX
.IF !USE_MULTI5_BIOS
        CPX	#$10
.ENDIF
		BNE	loc_C40971
		STZ	a:.LOWORD(PROGRAMMABLE_I_O_PORT_OUTPUT)
		LDA	#1
		STA	a:.LOWORD($4016)
		LDX	#8

loc_C40982:
		LDA	a:.LOWORD($4017)
		LSR
		LSR
		ROL	a:.LOWORD(multitap_status)	; orig=0x0CE0
		DEX
		BNE	loc_C40982
		STZ	a:.LOWORD($4016)
		LDA	#$80
		STA	a:.LOWORD(PROGRAMMABLE_I_O_PORT_OUTPUT)
		LDA	#1
		STA	a:.LOWORD($4016)
		STZ	a:.LOWORD($4016)
		LDX	#$10

loc_C409A0:
		LDA	a:.LOWORD($4016)
		LSR
		ROL	a:.LOWORD(joypad_1) ; orig=0x0CE1
		ROL	a:.LOWORD(joypad_1+1) ; orig=0x0CE2
		LDA	a:.LOWORD($4017)
		LSR
		ROL	a:.LOWORD(joypad_2) ; orig=0x0CE3
		ROL	a:.LOWORD(joypad_2+1) ; orig=0x0CE4
		LSR
		ROL	a:.LOWORD(joypad_3) ; orig=0x0CE5
		ROL	a:.LOWORD(joypad_3+1) ; orig=0x0CE6
		DEX
		BNE	loc_C409A0
		LDA	a:.LOWORD($4016)
		AND	#1
		STA	a:.LOWORD(joypad_1_connected) ; orig=0x0CEB
		LDA	a:.LOWORD($4017)
		LSR
		ROL	a:.LOWORD(joypad_2_connected) ; orig=0x0CEC
		AND	#1
		STA	a:.LOWORD(joypad_3_connected) ; orig=0x0CED
		STZ	a:.LOWORD(PROGRAMMABLE_I_O_PORT_OUTPUT)
		LDA	a:.LOWORD(multitap_status)	; orig=0x0CE0
		INC
		BNE	loc_C409FE
		LDX	#$10

loc_C409DE:
		LDA	a:.LOWORD($4017)
		LSR
		ROL	a:.LOWORD(joypad_4) ; orig=0x0CE7
		ROL	a:.LOWORD(joypad_4+1) ; orig=0x0CE8
		LSR
		ROL	a:.LOWORD(joypad_5) ; orig=0x0CE9
		ROL	a:.LOWORD(joypad_5+1) ; orig=0x0CEA
		DEX
		BNE	loc_C409DE
		LDA	a:.LOWORD($4017)
		LSR
		ROL	a:.LOWORD(joypad_4_connected) ; orig=0x0CEE
		AND	#1
		STA	a:.LOWORD(joypad_5_connected) ; orig=0x0CEF

loc_C409FE:
.IF !USE_MULTI5_BIOS
        LDA a:.LOWORD(word_7E0CE0) ; orig=0x0CE0
        AND #1
        ORA #$B0
        STA NMI_V_H_COUNT_AND_JOYPAD_ENABLE
.ENDIF
		REP	#$20
.A16
		LDX	#$D40
		LDY	#0
		JSL	f:update_input_for_player_object
		LDX	#$D80
		LDY	#2
		JSL	f:update_input_for_player_object
		LDX	#$DC0
		LDY	#4
		JSL	f:update_input_for_player_object
		LDX	#$E00
		LDY	#6
		JSL	f:update_input_for_player_object
		RTL
; End of function handle_player_input

; ---------------------------------------------------------------------------
		REP	#$20
.A16
.I16

update_input_for_player_object:
.IF USE_MULTI5_BIOS
		PHY
		TYA
		LSR
		TAY
		LDA	a:.LOWORD(joypad_1_connected),Y
		PLY
		AND	#$1F
		CMP	#1
		BEQ	loc_C40A41
		LDA	#0
		STA	a:.LOWORD(joypad_1),Y
.ENDIF
loc_C40A41:
		LDA	a:.LOWORD(joypad_1_previous),Y
		EOR	a:.LOWORD(joypad_1),Y
		AND	a:.LOWORD(joypad_1),Y
		STA	a:.LOWORD(joypad_1_pressed),Y
		LDA	a:.LOWORD(joypad_1),Y
		STA	a:.LOWORD(joypad_1_previous),Y
		LDA	AZ .LOWORD(7),X
		BIT	#1
		BNE	locret_C40A67
		LDA	a:.LOWORD(joypad_1),Y
		STA	AZ .LOWORD($22),X
		LDA	a:.LOWORD(joypad_1_pressed),Y
		STA	AZ .LOWORD($26),X

locret_C40A67:
		RTL
; End of function update_input_for_player_object

.A16
.I16

related_to_oam_transfer:
		REP	#$20
		LDA	a:.LOWORD(word_7E0306) ; orig=0x0306
		STA	AZ .LOWORD(word_7E0055+1) ;	orig=0x0056
		SEP	#$20
.A8
		LDA	a:.LOWORD(word_7E0308) ; orig=0x0308
		STA	AZ .LOWORD(word_7E0058) ; orig=0x0058
		LDA	a:.LOWORD(word_7E0308+1) ;	orig=0x0309
		AND	#$80
		BEQ	loc_C40A8D
		LDA	#$F0
		STA	a:.LOWORD(word_7E0306) ; orig=0x0306
		LDA	#1
		STA	a:.LOWORD(word_7E0306+1) ;	orig=0x0307
		JML	f:loc_C40ACA
; ---------------------------------------------------------------------------

loc_C40A8D:
		LDA	#$EE
		LDY	#1
		STA	[$56],Y
		LDY	#$203
		LDA	#1
		STA	[$56],Y
		LDA	AZ .LOWORD(word_7E0055+1) ;	orig=0x0056
		CLC
		ADC	#4
		STA	AZ .LOWORD(word_7E0055+1) ;	orig=0x0056
		BIT	#$F
		BNE	loc_C40A8D
		LDY	#1
		BIT	#$FF
		BEQ	loc_C40ABE

loc_C40AAF:
		LDA	#$EE
		STA	[$56],Y
		LDA	AZ .LOWORD(word_7E0055+1) ;	orig=0x0056
		CLC
		ADC	#4
		STA	AZ .LOWORD(word_7E0055+1) ;	orig=0x0056
		BNE	loc_C40AAF

loc_C40ABE:
		LDA	AZ .LOWORD(unk_7E0057) ; orig=0x0057
		BIT	#1
		BNE	loc_C40ACA
		INC	AZ .LOWORD(unk_7E0057) ; orig=0x0057
		BRA	loc_C40AAF
; ---------------------------------------------------------------------------

loc_C40ACA:
		SEP	#$20
		LDA	#0
		STA	AZ .LOWORD(word_7E0053) ; orig=0x0053
		INC
		INC
		INC
		STA	AZ .LOWORD(byte_7E0050) ; orig=0x0050
		LDA	#2
		STA	AZ .LOWORD(byte_7E0051) ; orig=0x0051
		STA	AZ .LOWORD(word_7E0053+1) ;	orig=0x0054
		LDA	#$7F
		STA	AZ .LOWORD(byte_7E0052) ; orig=0x0052
		STA	AZ .LOWORD(word_7E0055) ; orig=0x0055
		LDY	#0
		REP	#$20
.A16
		LDA	a:.LOWORD(word_7E0306) ; orig=0x0306
		LSR
		LSR
		LSR
		LSR
		AND	#$FF
		INC
		TAX
		SEP	#$20
.A8

loc_C40AFA:
		STZ	AZ .LOWORD(word_7E0040) ; orig=0x0040
		LDA	[$50],Y
		INY
		INY
		INY
		INY
		LSR
		ROR	AZ .LOWORD(word_7E0040) ; orig=0x0040
		LSR
		ROR	AZ .LOWORD(word_7E0040) ; orig=0x0040
		LDA	[$50],Y
		INY
		INY
		INY
		INY
		LSR
		ROR	AZ .LOWORD(word_7E0040) ; orig=0x0040
		LSR
		ROR	AZ .LOWORD(word_7E0040) ; orig=0x0040
		LDA	[$50],Y
		INY
		INY
		INY
		INY
		LSR
		ROR	AZ .LOWORD(word_7E0040) ; orig=0x0040
		LSR
		ROR	AZ .LOWORD(word_7E0040) ; orig=0x0040
		LDA	[$50],Y
		INY
		INY
		INY
		INY
		LSR
		ROR	AZ .LOWORD(word_7E0040) ; orig=0x0040
		LSR
		ROR	AZ .LOWORD(word_7E0040) ; orig=0x0040
		LDA	AZ .LOWORD(word_7E0040) ; orig=0x0040
		STA	[$53]
		INC	AZ .LOWORD(word_7E0053) ; orig=0x0053
		DEX
		BNE	loc_C40AFA
		SEP	#$20
		BRA	loc_C40B4B
; ---------------------------------------------------------------------------

loc_C40B44:
		LDA	#$55
		STA	[$53]
		INC	AZ .LOWORD(word_7E0053) ; orig=0x0053

loc_C40B4B:
		LDA	AZ .LOWORD(word_7E0053) ; orig=0x0053
		CMP	#$20
		BCC	loc_C40B44
		SEP	#$20
		STZ	a:.LOWORD(word_7E0308+1) ;	orig=0x0309
		RTL
; End of function related_to_oam_transfer

.A8
.I16

dma_related_:
		SEP	#$20
		LDA	#$80
		STA	a:.LOWORD(VRAM_ADDRESS_INCREMENT_VALUE)
		LDA	#1
		STA	a:.LOWORD(DMA_4_PARAMS)
		LDA	#$18
		STA	a:.LOWORD(DMA_4_B_ADDRESS)
		LDA	#$10
		STA	a:.LOWORD(REGULAR_DMA_CHANNEL_ENABLE)
		RTL
; End of function dma_related_

.A8
.I16

transfer_debug_menu_to_vram:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		AND	#$DF
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		AND	#1
		BEQ	locret_C40B9E
		REP	#$20
.A16
		LDA	#$58C0
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$680
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(bg3_ram_map)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(bg3_ram_map)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_

locret_C40B9E:
		RTL
; End of function transfer_debug_menu_to_vram

.A8
.I16

clear_vs_check_graphics:
		SEP	#$20
		LDA	a:.LOWORD(debug_vs_check) ; orig=0x00B4
		BEQ	locret_C40BB5
		LDY	#$3FF

loc_C40BA9:
		LDA	a:.LOWORD(bg1_tilemap),Y
		AND	#$FD
		STA	a:.LOWORD(bg1_tilemap),Y
		DEY
		DEY
		BPL	loc_C40BA9

locret_C40BB5:
		RTL
; End of function clear_vs_check_graphics

.A16
.I16

dma_reset:
		REP	#$20
		LDA	#0
		STA	AZ .LOWORD(word_7E0040) ; orig=0x0040
		SEP	#$20
.A8
		LDA	#0
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_HIGH_BYTE)
		LDA	#$80
		STA	a:.LOWORD(VRAM_ADDRESS_INCREMENT_VALUE)
		LDA	#9
		STA	a:.LOWORD(DMA_4_PARAMS)
		LDA	#%11000
		STA	a:.LOWORD(DMA_4_B_ADDRESS)
		LDA	#$40
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DMA_4_A_ADDRESS_HIGH_BYTE)
		LDA	#0
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		LDA	#0
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_HIGH_BYTE)
		LDA	#$10
		STA	a:.LOWORD(REGULAR_DMA_CHANNEL_ENABLE)
		RTL
; End of function dma_reset

; ---------------------------------------------------------------------------
animation_frame_C40BF4:.BYTE 3
		frame_oam_tile $F8, $EF, $600,	$20; 0
		frame_oam_tile 0, $FF,	$2700, 0; 1
		frame_oam_tile $F8, $FF, $2600, 0; 2
animation_frame_C40C04:.BYTE 3		       ; 0
		frame_oam_tile 0, 0, $2101, 0
		frame_oam_tile $F8, 0,	$2001, 0
		frame_oam_tile $F8, $F0, 1, $20
animation_frame_C40C14:.BYTE 3		       ; 0
		frame_oam_tile 0, 0, $2301, 0
		frame_oam_tile $F8, 0,	$2201, 0
		frame_oam_tile $F8, $F0, $201,	$20
animation_frame_C40C24:.BYTE 3		       ; 0
		frame_oam_tile $F8, $F8, $202,	$20
		frame_oam_tile 0, $F0,	$3300, 0
		frame_oam_tile $F8, $F0, $3200, 0
animation_frame_C40C34:.BYTE 3		       ; 0
		frame_oam_tile 0, $F0,	$3500, 0
		frame_oam_tile $F8, $F0, $3400, 0
		frame_oam_tile $F8, $F8, $402,	$20
animation_frame_C40C44:.BYTE 3		       ; 0
		frame_oam_tile $F8, $F8, $602,	$20
		frame_oam_tile 0, $F0,	$3700, 0
		frame_oam_tile $F8, $F0, $3600, 0
animation_frame_C40C54:.BYTE 3		       ; 0
		frame_oam_tile 0, 0, $2300, 0
		frame_oam_tile $F8, 0,	$2200, 0
		frame_oam_tile $F8, $F0, $200,	$20
animation_frame_C40C64:.BYTE 3		       ; 0
		frame_oam_tile 0, 0, $2100, 0
		frame_oam_tile $F8, 0,	$2000, 0
		frame_oam_tile $F8, $F0, 0, $20
animation_frame_C40C74:.BYTE 3		       ; 0
		frame_oam_tile $F8, $F0, $400,	$20
		frame_oam_tile 0, 0, $2500, 0
		frame_oam_tile $F8, 0,	$2400, 0
animation_frame_C40C84:.BYTE 3		       ; 0
		frame_oam_tile 0, 0, $2501, 0
		frame_oam_tile $F8, 0,	$2401, 0
		frame_oam_tile $F8, $F0, $401,	$20
animation_frame_C40C94:.BYTE 3		       ; 0
		frame_oam_tile $F8, $F0, $601,	$20
		frame_oam_tile 0, 0, $2701, 0
		frame_oam_tile $F8, 0,	$2601, 0
animation_frame_C40CA4:.BYTE 3		       ; 0
		frame_oam_tile $F8, $F8, 2, $20
		frame_oam_tile 0, $F0,	$3100, 0
		frame_oam_tile $F8, $F0, $3000, 0
animation_frame_C40CB4:.BYTE 3		       ; 0
		frame_oam_tile $F8, $F8, 3, $20
		frame_oam_tile 0, $F0,	$3101, 0
		frame_oam_tile $F8, $F0, $3001, 0
animation_frame_C40CC4:.BYTE 3		       ; 0
		frame_oam_tile 0, 0, $1103, 0
		frame_oam_tile $F8, 0,	$1003, 0
		frame_oam_tile $F8, $F0, $403,	$20
animation_frame_C40CD4:.BYTE 6		       ; 0
		frame_oam_tile $F8, $F0, $403,	0
		frame_oam_tile 0, $F0,	$503, 0
		frame_oam_tile 0, $F8,	$1703, 0
		frame_oam_tile $F8, $F8, $1603, 0
		frame_oam_tile 0, 0, $1103, 0
		frame_oam_tile $F8, 0,	$1003, 0
animation_frame_C40CF3:.BYTE 6		       ; 0
		frame_oam_tile 0, $F0,	$503, 0
		frame_oam_tile $F8, $F0, $403,	0
		frame_oam_tile 0, $F8,	$3102, 0
		frame_oam_tile $F8, $F8, $3002, 0
		frame_oam_tile 0, 0, $1103, 0
		frame_oam_tile $F8, 0,	$1003, 0
animation_frame_C40D12:.BYTE 3		       ; 0
		frame_oam_tile $F8, $F8, $203,	$20
		frame_oam_tile 0, $F0,	$3301, 0
		frame_oam_tile $F8, $F0, $3201, 0
animation_frame_C40D22:.BYTE 3		       ; 0
		frame_oam_tile $F8, $EE, $2602, $20
		frame_oam_tile 0, $FE,	$3502, 0
		frame_oam_tile $F8, $FE, $3402, 0
animation_frame_C40D32:.BYTE 6		       ; 0
		frame_oam_tile $FB, $F0, $3200, 0
		frame_oam_tile $FB, $F8, $3202, 0
		frame_oam_tile 3, $F8,	$3302, 0
		frame_oam_tile 3, $F0,	$2302, 0
		frame_oam_tile $FB, 0,	$2402, 0
		frame_oam_tile 3, 0, $2502, 0
animation_frame_C40D51:.BYTE 3		       ; 0
		frame_oam_tile 0, 1, $2103, 0
		frame_oam_tile $F8, 1,	$2003, 0
		frame_oam_tile $F8, $F1, $2203, $20
animation_frame_C40D61:.BYTE 6		       ; 0
		frame_oam_tile $FD, $F0, $3200, $40
		frame_oam_tile $FD, $F8, $3202, $40
		frame_oam_tile $F5, $F0, $2302, $40
		frame_oam_tile $F5, $F8, $3302, $40
		frame_oam_tile $FD, 0,	$2402, $40
		frame_oam_tile $F5, 0,	$2502, $40
animation_frame_C40D80:.BYTE 6		       ; 0
		frame_oam_tile 0, 0, $2300, 0
		frame_oam_tile $F8, 0,	$2200, 0
		frame_oam_tile 0, $F0,	$3501, 0
		frame_oam_tile $F8, $F0, $3401, 0
		frame_oam_tile 0, $F8,	$3701, 0
		frame_oam_tile $F8, $F8, $3601, 0
animation_frame_C40D9F:.BYTE 6		       ; 0
		frame_oam_tile 0, 0, $1302, 0
		frame_oam_tile $F8, 0,	$1202, 0
		frame_oam_tile $F8, $F8, $202,	0
		frame_oam_tile $F8, $F0, $3200, 0
		frame_oam_tile 0, $F8,	$3103, 0
		frame_oam_tile 0, $F0,	$3003, 0
animation_frame_C40DBE:.BYTE 6		       ; 0
		frame_oam_tile 0, 0, $1202, $40
		frame_oam_tile 0, $F8,	$202, $40
		frame_oam_tile 0, $F0,	$3200, $40
		frame_oam_tile $F8, 0,	$1302, $40
		frame_oam_tile $F8, $F8, $3103, $40
		frame_oam_tile $F8, $F0, $3003, $40
animation_frame_C40DDD:.BYTE 3		       ; 0
		frame_oam_tile 0, 0, $2104, 0
		frame_oam_tile $F8, 0,	$2004, 0
		frame_oam_tile $F8, $F0, 4, $20
animation_frame_C40DED:.BYTE 3		       ; 0
		frame_oam_tile 0, 0, $2304, 0
		frame_oam_tile $F8, 0,	$2204, 0
		frame_oam_tile $F8, $F0, $204,	$20
animation_frame_C40DFD:.BYTE 3		       ; 0
		frame_oam_tile 0, 0, $2504, 0
		frame_oam_tile $F8, 0,	$2404, 0
		frame_oam_tile $F8, $F0, $404,	$20
animation_frame_C40E0D:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $604,	$20
animation_frame_C40E13:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $2604, $20
animation_frame_C40E19:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, 5, $20
animation_frame_C40E1F:.BYTE 2		       ; 0
		frame_oam_tile $F8, 0,	$3404, 0
		frame_oam_tile 0, 0, $3504, 0
animation_frame_C40E2A:.BYTE 2		       ; 0
		frame_oam_tile 0, 0, $3104, 0
		frame_oam_tile $F8, 0,	$3004, 0
animation_frame_C40E35:.BYTE 2		       ; 0
		frame_oam_tile 0, 0, $3304, 0
		frame_oam_tile $F8, 0,	$3204, 0
animation_frame_C40E40:.BYTE 4		       ; 0
		frame_oam_tile $F8, $F0, $400,	$20
		frame_oam_tile $F8, 0,	$2400, $20
		frame_oam_tile 0, 0, $1200, $40
		frame_oam_tile $F8, 0,	$1200, 0
animation_frame_C40E55:.BYTE 4		       ; 0
		frame_oam_tile $F8, $F0, $600,	$20
		frame_oam_tile $F8, 0,	$2600, $20
		frame_oam_tile 0, 0, $1200, $40
		frame_oam_tile $F8, 0,	$1200, 0
animation_frame_C40E6A:.BYTE 4		       ; 0
		frame_oam_tile $F8, $EE, $2200, $20
		frame_oam_tile $F8, $FE, $2000, $20
		frame_oam_tile 0, 0, $1200, $40
		frame_oam_tile $F8, 0,	$1200, 0
animation_frame_C40E7F:.BYTE 4		       ; 0
		frame_oam_tile $F8, $EC, $2200, $20
		frame_oam_tile $F8, $FC, $2000, $20
		frame_oam_tile $F8, 0,	$200, $40
		frame_oam_tile 0, 0, $200, 0
animation_frame_C40E94:.BYTE 4		       ; 0
		frame_oam_tile $F8, $E9, $2200, $20
		frame_oam_tile $F8, $F9, $2000, $20
		frame_oam_tile $F8, 0,	$200, $40
		frame_oam_tile 0, 0, $200, 0
animation_frame_C40EA9:.BYTE 3		       ; 0
		frame_oam_tile $F8, $E6, $2200, $20
		frame_oam_tile $F8, $F6, $2000, $20
		frame_oam_tile $FC, 0,	$300, 0
animation_frame_C40EB9:.BYTE 3		       ; 0
		frame_oam_tile $F8, $E3, $2200, $20
		frame_oam_tile $F8, $F3, $2000, $20
		frame_oam_tile $FC, 0,	$300, 0
animation_frame_C40EC9:.BYTE 8		       ; 0
		frame_oam_tile 0, 0, $2002, $40
		frame_oam_tile 0, $DD,	$703, 0
		frame_oam_tile $F8, $DD, $603,	0
		frame_oam_tile $F8, 0,	$2002, 0
		frame_oam_tile 0, $CD,	$3501, 0
		frame_oam_tile $F8, $CD, $3401, 0
		frame_oam_tile 0, $D5,	$3701, 0
		frame_oam_tile $F8, $D5, $3601, 0
animation_frame_C40EF2:.BYTE 8		       ; 0
		frame_oam_tile 0, 0, $2002, $40
		frame_oam_tile 0, $DF,	$703, 0
		frame_oam_tile $F8, $DF, $603,	0
		frame_oam_tile $F8, 0,	$2002, 0
		frame_oam_tile 0, $CF,	$3501, 0
		frame_oam_tile $F8, $CF, $3401, 0
		frame_oam_tile 0, $D7,	$3701, 0
		frame_oam_tile $F8, $D7, $3601, 0
animation_frame_C40F1B:.BYTE 8		       ; 0
		frame_oam_tile 0, 0, $2002, $40
		frame_oam_tile 0, $E4,	$703, 0
		frame_oam_tile $F8, $E4, $603,	0
		frame_oam_tile $F8, 0,	$2002, 0
		frame_oam_tile 0, $D4,	$3501, 0
		frame_oam_tile $F8, $D4, $3401, 0
		frame_oam_tile 0, $DC,	$3701, 0
		frame_oam_tile $F8, $DC, $3601, 0
animation_frame_C40F44:.BYTE 8		       ; 0
		frame_oam_tile 0, 0, $2002, $40
		frame_oam_tile 0, $E8,	$703, 0
		frame_oam_tile $F8, $E8, $603,	0
		frame_oam_tile $F8, 0,	$2002, 0
		frame_oam_tile 0, $D8,	$3501, 0
		frame_oam_tile $F8, $D8, $3401, 0
		frame_oam_tile 0, $E0,	$3701, 0
		frame_oam_tile $F8, $E0, $3601, 0
animation_frame_C40F6D:.BYTE 8		       ; 0
		frame_oam_tile 0, 0, $2002, $40
		frame_oam_tile 0, $EC,	$703, 0
		frame_oam_tile $F8, $EC, $603,	0
		frame_oam_tile $F8, 0,	$2002, 0
		frame_oam_tile 0, $DC,	$3501, 0
		frame_oam_tile $F8, $DC, $3401, 0
		frame_oam_tile 0, $E4,	$3701, 0
		frame_oam_tile $F8, $E4, $3601, 0
animation_frame_C40F96:.BYTE 8		       ; 0
		frame_oam_tile 0, 0, $2002, $40
		frame_oam_tile 0, $EF,	$703, 0
		frame_oam_tile $F8, $EF, $603,	0
		frame_oam_tile $F8, 0,	$2002, 0
		frame_oam_tile 0, $DF,	$3501, 0
		frame_oam_tile $F8, $DF, $3401, 0
		frame_oam_tile 0, $E7,	$3701, 0
		frame_oam_tile $F8, $E7, $3601, 0
animation_frame_C40FBF:.BYTE 8		       ; 0
		frame_oam_tile 0, 0, $2002, $40
		frame_oam_tile 0, $F3,	$703, 0
		frame_oam_tile $F8, $F3, $603,	0
		frame_oam_tile $F8, 0,	$2002, 0
		frame_oam_tile 0, $E3,	$3501, 0
		frame_oam_tile $F8, $E3, $3401, 0
		frame_oam_tile 0, $EB,	$3701, 0
		frame_oam_tile $F8, $EB, $3601, 0
animation_frame_C40FE8:.BYTE 8		       ; 0
		frame_oam_tile 0, 0, $2002, $40
		frame_oam_tile 0, $F7,	$703, 0
		frame_oam_tile $F8, $F7, $603,	0
		frame_oam_tile $F8, 0,	$2002, 0
		frame_oam_tile 0, $E7,	$3501, 0
		frame_oam_tile $F8, $E7, $3401, 0
		frame_oam_tile 0, $EF,	$3701, 0
		frame_oam_tile $F8, $EF, $3601, 0
animation_frame_C41011:.BYTE 1		       ; 0
		frame_oam_tile $FC, $FC, $2102, 0
animation_frame_C41017:.BYTE 5		       ; 0
		frame_oam_tile $FF, $F6, $2202, 0
		frame_oam_tile $FB, $F6, $2202, 0
		frame_oam_tile $F8, $F8, $203,	$20
		frame_oam_tile 0, $F0,	$3301, 0
		frame_oam_tile $F8, $F0, $3201, 0
up_walking_animation:.BYTE 4
		animation_frame animation_frame_C40BF4, $B; 0
		animation_frame animation_frame_C40C04, $E; 1
		animation_frame animation_frame_C40BF4, $B; 2
		animation_frame animation_frame_C40C14, $E; 3
right_walking_animation:.BYTE 4
		animation_frame animation_frame_C40C24, $B; 0
		animation_frame animation_frame_C40C34, $E; 1
		animation_frame animation_frame_C40C24, $B; 2
		animation_frame animation_frame_C40C44, $E; 3
down_walking_animation:.BYTE 4
		animation_frame animation_frame_C40C54, $B; 0
		animation_frame animation_frame_C40C64, $E; 1
		animation_frame animation_frame_C40C54, $B; 2
		animation_frame animation_frame_C40C74, $E; 3
left_walking_animation:.BYTE 4
		animation_frame animation_frame_C40C84, $B; 0
		animation_frame animation_frame_C40C94, $E; 1
		animation_frame animation_frame_C40C84, $B; 2
		animation_frame animation_frame_C40CA4, $E; 3
death_animation:.BYTE $25
		animation_frame animation_frame_C40D80, 4; 0
		animation_frame animation_frame_C40FE8, 1; 1
		animation_frame animation_frame_C40FBF, 1; 2
		animation_frame animation_frame_C40F96, 1; 3
		animation_frame animation_frame_C40F6D, 1; 4
		animation_frame animation_frame_C40F44, 1; 5
		animation_frame animation_frame_C40F1B, 1; 6
		animation_frame animation_frame_C40EF2, 1; 7
		animation_frame animation_frame_C40EC9, 2; 8
		animation_frame animation_frame_C40EF2, 1; 9
		animation_frame animation_frame_C40F1B, 1; $A
		animation_frame animation_frame_C40F44, 1; $B
		animation_frame animation_frame_C40F6D, 1; $C
		animation_frame animation_frame_C40FBF, 1; $D
		animation_frame animation_frame_C40FE8, 1; $E
		animation_frame animation_frame_C40D80, 1; $F
		animation_frame animation_frame_C40CB4, 6; $10
		animation_frame animation_frame_C40CC4, 2; $11
		animation_frame animation_frame_C40CD4, 2; $12
		animation_frame animation_frame_C40CF3, $A; $13
		animation_frame animation_frame_C40D12, $15; $14
		animation_frame animation_frame_C41017, 1; $15
		animation_frame animation_frame_C40D12, 1; $16
		animation_frame animation_frame_C41017, 1; $17
		animation_frame animation_frame_C40D12, 1; $18
		animation_frame animation_frame_C41017, 2; $19
		animation_frame animation_frame_C40D12, 2; $1A
		animation_frame animation_frame_C41017, 2; $1B
		animation_frame animation_frame_C40D12, 2; $1C
		animation_frame animation_frame_C41017, 2; $1D
		animation_frame animation_frame_C40D12, 2; $1E
		animation_frame animation_frame_C41017, 2; $1F
		animation_frame animation_frame_C40D12, 2; $20
		animation_frame animation_frame_C41017, 2; $21
		animation_frame animation_frame_C40D12, 2; $22
		animation_frame animation_frame_C41017, $20; $23
		animation_frame animation_frame_C41011, $20; $24
up_punch_animation:.BYTE 1
		animation_frame animation_frame_C40D22, $B
right_punch_animation:.BYTE 1
		animation_frame animation_frame_C40D32, $B
down_punch_animation:.BYTE 1
		animation_frame animation_frame_C40D51, $B
left_punch_animation:.BYTE 1
		animation_frame animation_frame_C40D61, $B
hit_by_bomb_animation:.BYTE 9		; Animation structure:
					;
					; uint8	n_frames
					; An array of n_frames structures:
					; addr24 frame_offset
					; uint8	length
		animation_frame animation_frame_C40D80, 1; 0
		animation_frame animation_frame_C40D9F, 1; 1
		animation_frame animation_frame_C40BF4, 2; 2
		animation_frame animation_frame_C40DBE, 2; 3
		animation_frame animation_frame_C40D80, 3; 4
		animation_frame animation_frame_C40D9F, 4; 5
		animation_frame animation_frame_C40BF4, 5; 6
		animation_frame animation_frame_C40DBE, 6; 7
		animation_frame animation_frame_C40D80, 6; 8
enter_wrap_animation:.BYTE 9
		animation_frame animation_frame_C40DDD, 7; 0
		animation_frame animation_frame_C40DED, 6; 1
		animation_frame animation_frame_C40DFD, 5; 2
		animation_frame animation_frame_C40E0D, 5; 3
		animation_frame animation_frame_C40E13, 5; 4
		animation_frame animation_frame_C40E19, 4; 5
		animation_frame animation_frame_C40E1F, 3; 6
		animation_frame animation_frame_C40E2A, 2; 7
		animation_frame animation_frame_C40E35, 2; 8
unknown_animation:.BYTE	9
		animation_frame animation_frame_C40E35, 2; 0
		animation_frame animation_frame_C40E2A, 2; 1
		animation_frame animation_frame_C40E1F, 3; 2
		animation_frame animation_frame_C40E19, 4; 3
		animation_frame animation_frame_C40E13, 5; 4
		animation_frame animation_frame_C40E0D, 5; 5
		animation_frame animation_frame_C40DFD, 5; 6
		animation_frame animation_frame_C40DED, 6; 7
		animation_frame animation_frame_C40DDD, 7; 8
jumping_animation:.BYTE	$C
		animation_frame animation_frame_C40E40, 9; 0
		animation_frame animation_frame_C40E55, 2; 1
		animation_frame animation_frame_C40E6A, 2; 2
		animation_frame animation_frame_C40E7F, 2; 3
		animation_frame animation_frame_C40E94, 3; 4
		animation_frame animation_frame_C40EA9, 4; 5
		animation_frame animation_frame_C40EB9, 8; 6
		animation_frame animation_frame_C40EA9, 4; 7
		animation_frame animation_frame_C40E94, 3; 8
		animation_frame animation_frame_C40E7F, 2; 9
		animation_frame animation_frame_C40E6A, 2; $A
		animation_frame animation_frame_C40E55, 2; $B
.A8
.I16

init_player_handler:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314

loc_C411C3:
		BIT	#$80
		BEQ	loc_C411CB
		JML	f:locret_C412A1
; ---------------------------------------------------------------------------

loc_C411CB:
		STZ	a:.LOWORD($12F),X
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#1
		BNE	loc_C411D9
		JML	f:locret_C412A1
; ---------------------------------------------------------------------------

loc_C411D9:
		LDA	z:player::real_palette,X
		STA	z:player::effective_palette,X
		LDA	#0
		STA	z:object::handler+$12,X
		LDA	#0
		STA	z:player::anonymous_7,X
		REP	#$20
.A16
		STZ	a:.LOWORD($13A),X
		STZ	a:.LOWORD($13C),X
		LDY	#6
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#3
		BEQ	loc_C41271
		LDA	z:player::player_index,X
		AND	#$FF
		ASL
		TAY
		LDA	#0
		STA	a:.LOWORD(word_7E0CAA),Y
		LDY	#$C2
		LDA	z:player::player_index,X
		AND	#$FF
		BEQ	loc_C41212
		LDY	#$E2

loc_C41212:
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
		SEP	#$20
		LDA	#.BANKBYTE(storymode_normal_spawn_spot)
		STA	z:$55
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		AND	#$E
		PHX
		TAX
		LDA	f:storymode_spawn_spots_array,X
		STA	z:$53
		LDA	f:directions_for_spawn_spots,X
		STA	z:$40
		PLX
		JSL	f:change_direction_and_start_animation
		REP	#$20
		LDA	#$2A0
		STA	z:object::handler+$36,X
		LDA	z:player::player_index,X
		AND	#$FF
		ASL
		ASL
		ASL
		TAY
		LDA	[$53],Y
		STA	z:player::x_position,X
		INY
		INY
		LDA	[$53],Y
		STA	z:player::y_position,X
		REP	#$20
		LDA	#.LOWORD(handle_player_movement)
		STA	z:0,X
		SEP	#player::direction
.A8
		LDA	#.BANKBYTE(handle_player_movement)
		STA	z:object::handler+2,X
		RTL
; ---------------------------------------------------------------------------

loc_C41271:
		REP	#$20
.A16
		LDA	#4
		STA	z:$40
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$208
		BEQ	loc_C41290
		LDA	a:.LOWORD($13E),X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:word_C30924,X
		STA	z:$40
		PLX

loc_C41290:
		JSL	f:change_direction_and_start_animation
		REP	#$20
		LDA	#.LOWORD(handle_player_movement)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(handle_player_movement)
		STA	z:object::handler+2,X

locret_C412A1:
		RTL
; End of function init_player_handler

.A8
.I16

handle_player_movement:

; FUNCTION CHUNK AT 2098 SIZE 000000A7 BYTES

		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C412AF
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C412AF:
		BIT	#$41
		BEQ	loc_C412B7
		JML	f:loc_C413B0
; ---------------------------------------------------------------------------

loc_C412B7:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#8
		BEQ	loc_C412C4
		JML	f:loc_C413B5
; ---------------------------------------------------------------------------

loc_C412C4:
		JSL	f:clear_playerquare_in_collision_map
		JSL	f:sub_C43BE9
		JSL	f:sub_C431A0
		SEP	#$20
		LDA	a:.LOWORD($13B),X
		BIT	#$80
		BNE	loc_C412EE
		LDA	a:.LOWORD($13B),X
		BIT	#$40
		BEQ	loc_C412E4
		JML	f:sub_C4240D
; ---------------------------------------------------------------------------

loc_C412E4:
		LDA	z:$26,X
		BIT	#$80
		BEQ	loc_C412EE
		JML	f:loc_C4241A
; ---------------------------------------------------------------------------
.A16

loc_C412EE:
		SEP	#$20
.A8
		LDA	z:$23,X
		AND	#$F
		BNE	loc_C412FA
		JML	f:loc_C413BA
; ---------------------------------------------------------------------------

loc_C412FA:
		STA	z:$4E
		JSL	f:sub_C613ED
		SEP	#$20
		LDA	z:$4E
		CMP	#1
		BNE	loc_C4130C
		JML	f:sub_C41E16
; ---------------------------------------------------------------------------

loc_C4130C:
		CMP	#2
		BNE	loc_C41314
		JML	f:sub_C41EEC
; ---------------------------------------------------------------------------

loc_C41314:
		CMP	#4
		BNE	loc_C4131C
		JML	f:sub_C41FC2
; ---------------------------------------------------------------------------

loc_C4131C:
		JMP	a:.LOWORD(loc_C42098)
; ---------------------------------------------------------------------------
.A16

loc_C4131F:
		SEP	#$20
.A8
		LDA	z:$4E
		AND	#$F
		CMP	z:$20,X
		BEQ	_handle_player_movement
		STA	z:$20,X
		REP	#$20
.A16
		AND	#$F
		ASL
		PHX
		TAX
		LDA	f:player_animation_list,X
		STA	z:$50
		PLX
		SEP	#$20
.A8
		LDA	z:$D,X
		PHA
		SEP	#$20
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		PLA
		STA	z:$D,X

_handle_player_movement:
		REP	#$20
.A16
		LDA	z:$26,X
		BIT	#$4020
		BEQ	loc_C4135B
		JSL	f:sub_C41D0B

loc_C4135B:
		JSL	f:mark_playerquare_in_collision_map
		JSL	f:sub_C60C35
		SEP	#$20
.A8
		LDA	z:$1F,X
		STA	z:$1E,X
		JSL	f:poison_related
		JSL	f:infect_poison
		SEP	#$20
		LDA	z:$2F,X
		BNE	loc_C4137B
		JML	f:loc_C4139D
; ---------------------------------------------------------------------------

loc_C4137B:
		LDA	z:$2F,X
		BIT	#$80
		BEQ	loc_C41385
		JML	f:play_hit_by_bomb_animation
; ---------------------------------------------------------------------------

loc_C41385:
		LDA	z:$39,X
		BIT	#$80
		BNE	loc_C4138F
		JML	f:player_death
; ---------------------------------------------------------------------------

loc_C4138F:
		AND	#$7F
		STA	z:$39,X
		STZ	z:$2F,X
		LDA	#$A0
		STA	z:$36,X
		LDA	#2
		STA	z:$37,X

loc_C4139D:
		SEP	#$20
		INC	a:.LOWORD($13F),X
		LDA	a:.LOWORD($13F),X
		BIT	#$F
		BNE	loc_C413B0
		LDY	#$C
		JSL	f:play_sound

loc_C413B0:
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C413B5:
		JSL	f:advance_animation_2
		RTL
; ---------------------------------------------------------------------------

loc_C413BA:
		REP	#$20
.A16
		LDA	z:$26,X
		BIT	#$4020
		BEQ	loc_C413C7
		JSL	f:sub_C41D0B

loc_C413C7:
		JSL	f:mark_playerquare_in_collision_map
		JSL	f:sub_C60C35
		SEP	#$20
.A8
		LDA	z:$1F,X
		STA	z:$1E,X
		JSL	f:poison_related
		JSL	f:infect_poison
		SEP	#$20
		LDA	z:$2F,X
		BEQ	loc_C41405
		LDA	z:$2F,X
		BIT	#$80
		BEQ	loc_C413ED
		JML	f:play_hit_by_bomb_animation
; ---------------------------------------------------------------------------

loc_C413ED:
		LDA	z:$39,X
		BIT	#$80
		BNE	loc_C413F7
		JML	f:player_death
; ---------------------------------------------------------------------------

loc_C413F7:
		AND	#$7F
		STA	z:$39,X
		STZ	z:$2F,X
		LDA	#$A0
		STA	z:$36,X
		LDA	#2
		STA	z:$37,X

loc_C41405:
		SEP	#$20
		STZ	z:$21,X
		STZ	z:$C,X
		STZ	z:$25,X
		LDA	z:$D,X
		PHA
		JSL	f:advance_animation
		SEP	#$20
		PLA
		STA	z:$D,X
		RTL
; End of function handle_player_movement

.A8
.I16

mark_playerquare_in_collision_map:
		JSL	f:get_object_square_index
		REP	#$20
.A16
		TAY
		LDA	a:.LOWORD(collision_map),Y
		ORA	#PLAYER
		STA	a:.LOWORD(collision_map),Y
		RTL
; End of function mark_playerquare_in_collision_map

.A8
.I16

clear_playerquare_in_collision_map:
		JSL	f:get_object_square_index
		REP	#$20
.A16
		TAY
		LDA	a:.LOWORD(collision_map),Y
		AND	#.LOWORD(~(PLAYER))
		STA	a:.LOWORD(collision_map),Y
		RTL
; End of function clear_playerquare_in_collision_map

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR poison_related

loc_C4143C:
		SEP	#$20
.A8
		LDA	a:.LOWORD(frame_count) ; orig=0x0300
		AND	#$F
		BEQ	loc_C41449
		JML	f:loc_C414A6
; ---------------------------------------------------------------------------

loc_C41449:
		JSL	f:random2
		SEP	#$20
		AND	#$F0
		CMP	#$40
		BEQ	loc_C41459
		JML	f:loc_C414A6
; ---------------------------------------------------------------------------

loc_C41459:
		LDA	a:.LOWORD($13B),X
		ORA	#4
		STA	a:.LOWORD($13B),X
		JMP	a:.LOWORD(loc_C414A6)
; END OF FUNCTION CHUNK	FOR poison_related
.A8
.I16

poison_related:

; FUNCTION CHUNK AT 143C SIZE 00000028 BYTES

		SEP	#$20
		LDA	#0
		XBA
		LDA	a:.LOWORD(poison_related_0) - player1_object,X
		BIT	#4
		BNE	loc_C41487
		BIT	#8
		BEQ	loc_C41487
		LDA	z:player::position_related,X
		CMP	#$28
		BEQ	loc_C4143C
		INC	z:$3A,X
		PHX
		TAX
		LDA	f:invisibility_poison_related,X
		PLX
		STA	z:object::handler+$12,X
		BRA	loc_C414A6
; ---------------------------------------------------------------------------

loc_C41487:
		LDA	z:player::position_related,X
		BEQ	loc_C414A6
		SEC
		SBC	#$27
		EOR	#$FF
		INC
		PHX
		TAX
		LDA	f:invisibility_poison_related,X
		PLX
		STA	z:object::handler+$12,X
		DEC	z:player::position_related,X
		BNE	loc_C414A6
		LDA	a:.LOWORD($13B),X
		AND	#$FB
		STA	a:.LOWORD($13B),X

loc_C414A6:
		REP	#$20
.A16
		LDA	z:object::handler+$36,X
		BEQ	loc_C414E2
		DEC	z:object::handler+$36,X
		SEC
		SBC	#$2A0
		EOR	#$FFFF
		INC
		PHX
		TAX
		SEP	#$20
.A8
		LDA	f:shield_palette_sequence,X
		PLX
		CMP	#0
		BNE	loc_C414C5
		LDA	z:$1F,X

loc_C414C5:
		STA	z:player::effective_palette,X
		STZ	z:player::anonymous_7,X
		REP	#$20
.A16
		LDA	a:.LOWORD($13A),X
		BEQ	loc_C414DF
		DEC
		BIT	#$3FF
		BNE	loc_C414DC
		LDA	#0
		STA	a:.LOWORD($13C),X

loc_C414DC:
		STA	a:.LOWORD($13A),X

loc_C414DF:
		SEP	#$20
.A8
		RTL
; ---------------------------------------------------------------------------

loc_C414E2:
		REP	#$20
.A16
		LDA	a:.LOWORD($13A),X
		BEQ	loc_C414DF
		DEC
		BIT	#$3FF
		BNE	loc_C414F5
		LDA	#0
		STA	a:.LOWORD($13C),X

loc_C414F5:
		STA	a:.LOWORD($13A),X
		SEP	#$20
.A8
		AND	#$10
		BNE	loc_C41503
		LDA	z:player::real_palette,X
		STA	z:player::effective_palette,X
		RTL
; ---------------------------------------------------------------------------

loc_C41503:
		LDA	#$C
		STA	z:player::effective_palette,X
		RTL
; End of function poison_related

.A8
.I16

infect_poison:
		REP	#$20
.A16
		LDA	a:.LOWORD($13B),X
		BEQ	locret_C41579
		STX	z:$40
		TXY

loc_C41512:
		REP	#$20
		TYA
		CLC
		ADC	#$40
		CMP	#.LOWORD(unk_7E0E40)
		BNE	loc_C41521
		LDA	#.LOWORD(player1_object)

loc_C41521:
		TAY
		CMP	z:$40
		BEQ	locret_C41579
		SEP	#$20
.A8
		LDA	a:.LOWORD(4),Y
		BEQ	loc_C41512
		LDA	a:.LOWORD($13B),Y
		BNE	loc_C41512
		LDA	a:.LOWORD($2F),Y
		BIT	#1
		BNE	loc_C41512
		LDA	a:.LOWORD($12F),Y
		BNE	loc_C41512
		LDA	a:.LOWORD($11),Y
		SEC
		SBC	z:$11,X
		BCS	loc_C41549
		EOR	#$FF
		INC

loc_C41549:
		CMP	#$10
		BCS	loc_C41512
		LDA	a:.LOWORD($14),Y
		SEC
		SBC	z:$14,X
		BCS	loc_C41558
		EOR	#$FF
		INC

loc_C41558:
		CMP	#$10
		BCS	loc_C41512
		REP	#$20
.A16
		LDA	a:.LOWORD($13A),X
		BIT	#$800
		BEQ	loc_C41569
		AND	#$BFF

loc_C41569:
		STA	a:.LOWORD($13A),Y
		LDA	a:.LOWORD($13C),X
		STA	a:.LOWORD($13C),Y
		LDY	#$A
		JSL	f:play_sound

locret_C41579:
		RTL
; End of function infect_poison

.A8
.I16

play_hit_by_bomb_animation:
		SEP	#$20
		LDA	z:player::real_palette,X
		STA	z:player::effective_palette,X
		REP	#$20
.A16
		LDA	#.LOWORD(hit_by_bomb_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(_play_hit_by_bomb_animation)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_play_hit_by_bomb_animation)
		STA	z:object::handler+2,X

_play_hit_by_bomb_animation:
		JSL	f:advance_animation
		BCC	locret_C415BD
		SEP	#$20
		STZ	z:$2F,X
		LDA	#4
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(handle_player_movement)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(handle_player_movement)
		STA	z:object::handler+2,X

locret_C415BD:
		RTL
; End of function play_hit_by_bomb_animation

; ---------------------------------------------------------------------------
		RTL
.A8
.I16

enter_warp:
		SEP	#$20
		INC	a:.LOWORD($12F),X
		JSL	f:clear_playerquare_in_collision_map
		LDY	#9
		JSL	f:play_sound
		SEP	#$20
		LDA	z:player::x_position,X	; Round	position to whole tile
		AND	#$F0
		ORA	#8
		STA	z:player::x_position,X
		LDA	z:player::y_position,X
		AND	#$F0
		ORA	#8
		STA	z:player::y_position,X
		REP	#$20
.A16
		LDA	#.LOWORD(enter_wrap_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(_enter_wrap)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_enter_wrap)
		STA	z:2,X

_enter_wrap:
		JSL	f:advance_animation
		BCC	locret_C41612
		REP	#$20
.A16
		LDA	#.LOWORD(wrap_delay)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(wrap_delay)
		STA	z:2,X

locret_C41612:
		RTL
; End of function enter_warp

.A8
.I16

wrap_delay:
		SEP	#$20
		LDA	#$40
		STA	z:player::wrap_delay,X
		REP	#$20
.A16
		LDA	#.LOWORD(_wrap_delay)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_wrap_delay)
		STA	z:object::handler+2,X

_wrap_delay:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C41633
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C41633:
		BIT	#$41
		BEQ	loc_C4163B
		JML	f:locret_C4164E
; ---------------------------------------------------------------------------

loc_C4163B:
		SEP	#$20
		DEC	z:player::wrap_delay,X
		BNE	locret_C4164E
		REP	#$20
.A16
		LDA	#.LOWORD(exit_wrap)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(exit_wrap)
		STA	z:object::handler+2,X

locret_C4164E:
		RTL
; End of function wrap_delay

.A8
.I16

play_exit_wrap_animation:
		REP	#$20
.A16
		LDA	#.LOWORD(unknown_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(_play_exit_wrap_animation)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_play_exit_wrap_animation)
		STA	z:object::handler+2,X

_play_exit_wrap_animation:
		JSL	f:advance_animation
		BCC	locret_C4168A
		SEP	#$20
		LDA	z:$20,X
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(handle_player_movement)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(handle_player_movement)
		STA	z:object::handler+2,X

locret_C4168A:
		RTL
; End of function play_exit_wrap_animation

.A8
.I16

exit_wrap:
		PHX
		LDX	#5
		JSL	f:random
		REP	#$20
.A16
		AND	#$FF
		ASL
		ASL
		TAX
		LDA	f:wrap_positions,X
		STA	z:$40
		LDA	f:wrap_positions+2,X
		STA	z:$42
		PLX
		SEP	#$20
.A8
		LDA	z:$40
		CMP	z:player::x_position,X
		BNE	loc_C416B6
		LDA	z:$42
		CMP	z:player::y_position,X
		BEQ	locret_C416D0

loc_C416B6:
		SEP	#$20
		LDA	z:$40
		STA	z:player::x_position,X
		LDA	z:$42
		STA	z:player::y_position,X
		STZ	a:.LOWORD($12F),X
		REP	#$20
.A16
		LDA	#.LOWORD(play_exit_wrap_animation)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(play_exit_wrap_animation)
		STA	z:object::handler+2,X

locret_C416D0:
		RTL
; End of function exit_wrap

; ---------------------------------------------------------------------------
wrap_positions:	.WORD $48, $38		; 0
		.WORD $C8, $38		; 2
		.WORD $48, $98		; 4
		.WORD $C8, $98		; 6
		.WORD $88, $68		; 8
.A8
.I16

do_trampoline:
		SEP	#$20
		INC	a:.LOWORD($12F),X
		JSL	f:clear_playerquare_in_collision_map
		LDY	#$B
		JSL	f:play_sound
		REP	#$20
.A16
		LDA	z:player::y_position,X
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($114),X
		LDA	#$F000
		STA	z:player::trampoline_state,X
		REP	#$20
		LDA	#.LOWORD(_do_trampoline)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_do_trampoline)
		STA	z:object::handler+2,X

_do_trampoline:
		REP	#$20
.A16
		STZ	z:$42
		LDA	z:player::trampoline_state,X
		CLC
		ADC	#$80
		STA	z:player::trampoline_state,X
		BPL	loc_C41724
		DEC	z:$42

loc_C41724:
		CLC
		ADC	z:object::handler+$13,X
		STA	z:object::handler+$13,X
		SEP	#$20
.A8
		LDA	z:$42
		ADC	z:object::handler+$15,X
		STA	z:object::handler+$15,X
		REP	#$20
.A16
		LDA	z:player::y_position,X
		BPL	loc_C4174A
		CMP	#$FFF0
		BCS	loc_C4174A
		REP	#$20
		LDA	#.LOWORD(trampoline_delay)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(trampoline_delay)
		STA	z:object::handler+2,X
		RTL
; ---------------------------------------------------------------------------

loc_C4174A:
		JSL	f:load_animation_frame
		RTL
; End of function do_trampoline

.A8
.I16

trampoline_delay:
		REP	#$20
.A16
		LDA	#$30
		STA	z:player::trampoline_state,X
		REP	#$20
		LDA	#.LOWORD(_trampoline_delay)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_trampoline_delay)
		STA	z:object::handler+2,X

_trampoline_delay:
		REP	#$20
.A16
		DEC	z:player::trampoline_state,X
		BNE	locret_C41776
		REP	#$20
		LDA	#.LOWORD(trampoline_land)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(trampoline_land)
		STA	z:object::handler+2,X

locret_C41776:
		RTL
; End of function trampoline_delay

.A8
.I16

trampoline_land:
		JSL	f:random2
		REP	#$20
.A16
		AND	#$C
		STA	z:$40
		JSL	f:random2
		REP	#$20
		AND	#3
		INC
		STA	z:$42
		SEP	#$20
.A8
		LDA	z:player::x_position,X
		AND	#$F0
		ORA	#8
		STA	z:player::x_position,X
		JSL	f:randomize_landing
		REP	#$20
.A16
		LDA	#0
		STA	z:player::trampoline_state,X
		REP	#$20
		LDA	#.LOWORD(_trampoline_land)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_trampoline_land)
		STA	z:object::handler+2,X

_trampoline_land:
		REP	#$20
.A16
		STZ	z:$42
		LDA	z:player::trampoline_state,X
		CLC
		ADC	#$80
		STA	z:player::trampoline_state,X
		BPL	loc_C417C0
		DEC	z:$42

loc_C417C0:
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		SEP	#$20
.A8
		LDA	z:$42
		ADC	z:$15,X
		STA	z:$15,X
		REP	#$20
.A16
		LDA	z:$14,X
		BMI	loc_C417FF
		LDA	a:.LOWORD($114),X
		CMP	z:$14,X
		BCS	loc_C417FF
		SEP	#$20
.A8
		LDA	a:.LOWORD($114),X
		STA	z:player::y_position,X
		LDA	z:player::direction,X
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		SEP	#$20
		STZ	a:.LOWORD($12F),X
		LDA	z:player::is_ai,X
		BNE	loc_C41804
		REP	#$20
.A16
		LDA	#.LOWORD(handle_player_movement)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(handle_player_movement)
		STA	z:2,X

loc_C417FF:
		JSL	f:load_animation_frame
		RTL
; ---------------------------------------------------------------------------

loc_C41804:
		REP	#$20
.A16
		LDA	#.LOWORD(_handle_player_movement_0)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_handle_player_movement_0)
		STA	z:2,X
		JSL	f:load_animation_frame
		RTL
; End of function trampoline_land

.A8
.I16

randomize_landing:
		REP	#$20
.A16
		LDA	z:player::wrap_delay,X
		PHA
		LDA	a:.LOWORD($114),X
		PHA
		PHX
		LDX	z:$40
		LDA	f:trampoline_deltas+2,X
		STA	z:$44
		LDA	f:trampoline_deltas,X
		PLX
		CLC
		ADC	z:player::x_position,X
		STA	z:player::x_position,X
		LDA	z:$44
		CLC
		ADC	a:.LOWORD($114),X
		STA	a:.LOWORD($114),X
		AND	#$F0
		ASL
		ASL
		STA	z:$44
		LDA	z:player::x_position,X
		AND	#$F0
		LSR
		LSR
		LSR
		ADC	z:$44
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#BOMB|SOFT_BLOCK|HARD_BLOCK
		BNE	loc_C4185C
		PLA
		PLA
		DEC	z:$42
		BNE	randomize_landing
		RTL
; ---------------------------------------------------------------------------

loc_C4185C:
		PLA
		STA	a:.LOWORD($114),X
		PLA
		STA	z:player::wrap_delay,X
		RTL
; End of function randomize_landing

; ---------------------------------------------------------------------------
trampoline_deltas:.WORD	0, $FFF0	  ; 0
		.WORD $10, 0		; 2
		.WORD 0, $10		; 4
		.WORD $FFF0, 0		; 6
level_end_musics:.BYTE 0, $E		 ; 0
		.BYTE $1F, $21		; 2
		.BYTE $23, $25		; 4
		.BYTE $27		; 6
.A16
.I16

enter_level_exit:
		JSL	f:clear_playerquare_in_collision_map
		LDA	#.BANKBYTE(level_end_musics)
		STA	z:$52
		REP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		AND	#$F0
		LSR
		LSR
		LSR
		LSR
		CLC
		ADC	#.LOWORD(level_end_musics) ; It seems like the plan was to give each world its own intro and ending sequences
		STA	z:$50
		LDA	[$50]
		AND	#$FF
		TAY
		JSL	f:play_music
		PHX
		REP	#$20
		LDA	#.LOWORD(warp_graphics)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(warp_graphics)
		STA	z:$55
		SEP	#$20
		LDA	a:.LOWORD(word_7E0C8F+1) ;	orig=0x0C90
		BEQ	loc_C418C2
		REP	#$20
.A16
		LDA	#.LOWORD(warp_mini_graphics)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(warp_mini_graphics)
		STA	z:$55

loc_C418C2:
		JSL	f:graphics_decompression_8192_bytes
		SEP	#$20
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C418CB:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C418CB
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$6800
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		PLX
		REP	#$20
.A16
		LDA	#.LOWORD(enter_wrap_animation)
		STA	z:$50

loc_C418FE:
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C41915)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C41915)
		STA	z:object::handler+2,X

loc_C41915:
		JSL	f:advance_animation
		BCS	loc_C4191F
		JML	f:locret_C41947
; ---------------------------------------------------------------------------

loc_C4191F:
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C41934)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C41934)
		STA	z:2,X
		REP	#$20
.A16
		LDA	#$80
		STA	z:$10,X
		RTL
; ---------------------------------------------------------------------------

loc_C41934:
		REP	#$20
		DEC	z:$10,X
		BNE	locret_C41947
		SEP	#$20
.A8
		LDA	a:.LOWORD(level_manager_object+level_manager_object::current_screen) ;	orig=0x0D3F
		BNE	locret_C41947
		INC	a:.LOWORD(level_manager_object+level_manager_object::current_screen) ;	orig=0x0D3F
		INC	a:.LOWORD(current_screen) ; orig=0x00A4

locret_C41947:
		RTL
; End of function enter_level_exit

.A8
.I16

; Choose a random living AI enemy, and increase	its level

last_human_death:
		PHX
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::number_of_ai_players) ; orig=0x0D37
		INC
		AND	#$FF
		TAX
		JSL	f:random
		PLX
		REP	#$20
		AND	#$FF
		STA	z:$40
		STZ	z:$42
		SEP	#$20
.A8
		LDY	#.LOWORD(player1_object)

loc_C41966:
		LDA	a:.LOWORD(player::gameover_related),Y
		BEQ	loc_C41982
		LDA	a:.LOWORD(player::is_ai),Y
		BEQ	loc_C41982
		LDA	#0
		STA	a:.LOWORD(player::number_of_lives),Y
		LDA	z:$42
		INC	z:$42
		CMP	z:$40
		BNE	loc_C41982
		LDA	#4
		STA	a:.LOWORD(player::number_of_lives),Y

loc_C41982:
		REP	#$20
.A16
		TYA
		CLC
		ADC	#$40
		TAY
		CMP	#.LOWORD(unk_7E0E40)
		SEP	#$20
.A8
		BNE	loc_C41966
		RTL
; End of function last_human_death

.A8
.I16

player_death:
		JSL	f:clear_playerquare_in_collision_map
		LDY	#$1F
		JSL	f:play_sound
		SEP	#$20
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#3
		BNE	loc_C419BB
		JSL	f:sub_C44945
		SEP	#$20
		DEC	a:.LOWORD(level_manager_object+level_manager_object::number_of_human_players) ; orig=0x0D36
		DEC	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		LDA	a:.LOWORD(level_manager_object+level_manager_object::number_of_human_players) ; orig=0x0D36
		BNE	loc_C419BB
		JSL	f:last_human_death

loc_C419BB:
		SEP	#$20
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	#0
		STA	z:$12,X
		REP	#$20
.A16
		LDA	#.LOWORD(death_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(_player_death)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_player_death)
		STA	z:2,X

_player_death:
		JSL	f:advance_animation
		BCC	locret_C41A07
		SEP	#$20
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#3
		BEQ	loc_C41A08
		STZ	z:$2F,X
		JSL	f:sub_C4775B
		SEP	#$20
		LDA	z:$3D,X
		BEQ	loc_C41A40
		DEC	z:$3D,X
		JSL	f:write_number_of_lives
		JMP	a:.LOWORD(init_player_handler)
; ---------------------------------------------------------------------------

locret_C41A07:
		RTL
; ---------------------------------------------------------------------------

loc_C41A08:
		REP	#$20
.A16
		LDA	z:5,X
		AND	#$FF
		PHX
		TAX
		LDA	f:byte_C3092C,X
		PLX
		AND	#$FF
		TAY
		LDA	z:player::player_index,X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:byte_C30938,X
		PLX
		STA	a:.LOWORD(bg3_tilemap),Y
		INC
		STA	a:.LOWORD(bg3_tilemap+2),Y
		CLC
		ADC	#$F
		STA	a:.LOWORD(bg3_tilemap+$40),Y
		INC
		STA	a:.LOWORD(bg3_tilemap+$42),Y
		SEP	#$20
.A8
		STZ	z:4,X
		STZ	z:player::anonymous_7,X
		RTL
; ---------------------------------------------------------------------------

loc_C41A40:
		REP	#$20
.A16
		LDA	z:5,X
		AND	#$FF
		ASL
		TAY
		LDA	#0
		STA	a:.LOWORD($CAA),Y
		SEP	#$20
.A8
		DEC	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		STZ	z:4,X
		RTL
; End of function player_death

.A8
.I16

copy_to_bg3_tilemap:
		REP	#$20
.A16

loc_C41A59:
		LDA	[$50]
		STA	a:.LOWORD(bg3_tilemap),Y
		INY
		INY
		INC	z:$50
		INC	z:$50
		DEC	z:$40
		BNE	loc_C41A59
		RTL
; End of function copy_to_bg3_tilemap

.A8
.I16

change_direction_and_start_animation:
		SEP	#$20
		LDA	z:$40
		STA	z:player::direction,X

start_animation_by_index:
		REP	#$20
.A16
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:player_animation_list,X
		STA	z:$50
		PLX
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		RTL
; End of function change_direction_and_start_animation

.A8
.I16

start_animation_by_direction:
		SEP	#$20
		LDA	#.BANKBYTE(up_walking_animation)
		STA	z:$52
		LDA	z:$40
		STA	z:player::direction,X
		REP	#$20
.A16
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:player_animation_list,X
		STA	z:$50
		PLX
		JSL	f:start_animation
		RTL
; End of function start_animation_by_direction

.A16
.I16

write_number_of_lives:
		SEP	#$20
.A8
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#3
		BNE	loc_C41AB4
		JML	f:locret
; ---------------------------------------------------------------------------

loc_C41AB4:
		LDY	#$46
		LDA	z:player::player_index,X
		BEQ	loc_C41ABE
		LDY	#$68

loc_C41ABE:
		REP	#$20
.A16
		LDA	z:player::number_of_lives,X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:hud_digits_tilenos_upper,X
		PLX
		STA	a:.LOWORD(bg3_tilemap),Y
		CLC
		ADC	#$10
		STA	a:.LOWORD(bg3_tilemap+$40),Y
		RTL
; End of function write_number_of_lives

.A16
.I16

add_to_score_if_allowed:
		SEP	#$20
.A8
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#3
		BNE	loc_C41AE5
		JML	f:locret
; ---------------------------------------------------------------------------

loc_C41AE5:
		LDA	z:player::gameover_related,X
		BNE	loc_C41AED
		JML	f:locret
; ---------------------------------------------------------------------------

loc_C41AED:
		LDA	z:player::is_ai,X
		BEQ	add_to_score
		JML	f:locret
; End of function add_to_score_if_allowed

.A16
.I16

add_to_score:
		SEP	#$20
.A8
		LDY	#$4C
		LDA	z:player::player_index,X
		BEQ	loc_C41B01
		LDY	#$6E

loc_C41B01:
		REP	#$20
.A16
		SED
		LDA	z:player::socre_digits_12,X
		CLC
		ADC	z:$40
		STA	z:player::socre_digits_12,X
		LDA	z:player::score_digits_56,X
		ADC	z:$42
		STA	z:player::score_digits_56,X
		CLD
		BCC	loc_C41B1E
		LDA	#$9999
		STA	z:player::socre_digits_12,X
		LDA	#$9999
		STA	z:player::score_digits_56,X

loc_C41B1E:
		LDA	#1
		STA	z:$44
		LDA	z:player::score_digits_78,X
		AND	#$F0
		LSR
		LSR
		LSR
		BNE	loc_C41B33
		LDA	z:$44
		BEQ	loc_C41B33
		BRA	loc_C41B46
; ---------------------------------------------------------------------------

loc_C41B33:
		STZ	z:$44
		PHX
		TAX
		LDA	f:hud_digits_tilenos_upper,X
		PLX
		STA	a:.LOWORD(bg3_tilemap),Y
		CLC
		ADC	#$10
		STA	a:.LOWORD(bg3_tilemap+$40),Y

loc_C41B46:
		INY
		INY
		LDA	z:player::score_digits_78,X
		AND	#$F
		ASL
		BNE	loc_C41B56
		LDA	z:$44
		BEQ	loc_C41B56
		BRA	loc_C41B69
; ---------------------------------------------------------------------------

loc_C41B56:
		STZ	z:$44
		PHX
		TAX
		LDA	f:hud_digits_tilenos_upper,X
		PLX
		STA	a:.LOWORD(bg3_tilemap),Y
		CLC
		ADC	#$10
		STA	a:.LOWORD(bg3_tilemap+$40),Y

loc_C41B69:
		INY
		INY
		LDA	z:player::score_digits_56,X
		AND	#$F0
		LSR
		LSR
		LSR
		BNE	loc_C41B7B
		LDA	z:$44
		BEQ	loc_C41B7B
		BRA	loc_C41B8E
; ---------------------------------------------------------------------------

loc_C41B7B:
		STZ	z:$44
		PHX
		TAX
		LDA	f:hud_digits_tilenos_upper,X
		PLX
		STA	a:.LOWORD(bg3_tilemap),Y
		CLC
		ADC	#$10
		STA	a:.LOWORD(bg3_tilemap+$40),Y

loc_C41B8E:
		INY
		INY
		LDA	z:player::score_digits_56,X
		AND	#$F
		ASL
		BNE	loc_C41B9E
		LDA	z:$44
		BEQ	loc_C41B9E
		BRA	loc_C41BB1
; ---------------------------------------------------------------------------

loc_C41B9E:
		STZ	z:$44
		PHX
		TAX
		LDA	f:hud_digits_tilenos_upper,X
		PLX
		STA	a:.LOWORD(bg3_tilemap),Y
		CLC
		ADC	#$10
		STA	a:.LOWORD(bg3_tilemap+$40),Y

loc_C41BB1:
		INY
		INY
		LDA	z:player::score_digits_34,X
		AND	#$F0
		LSR
		LSR
		LSR
		BNE	loc_C41BC3
		LDA	z:$44
		BEQ	loc_C41BC3
		BRA	loc_C41BD6
; ---------------------------------------------------------------------------

loc_C41BC3:
		STZ	z:$44
		PHX
		TAX
		LDA	f:hud_digits_tilenos_upper,X
		PLX
		STA	a:.LOWORD(bg3_tilemap),Y
		CLC
		ADC	#$10
		STA	a:.LOWORD(bg3_tilemap+$40),Y

loc_C41BD6:
		INY
		INY
		LDA	z:player::score_digits_34,X
		AND	#$F
		ASL
		BNE	loc_C41BE6
		LDA	z:$44
		BEQ	loc_C41BE6
		BRA	loc_C41BF9
; ---------------------------------------------------------------------------

loc_C41BE6:
		STZ	z:$44
		PHX
		TAX
		LDA	f:hud_digits_tilenos_upper,X
		PLX
		STA	a:.LOWORD(bg3_tilemap),Y
		CLC
		ADC	#$10
		STA	a:.LOWORD(bg3_tilemap+$40),Y

loc_C41BF9:
		INY
		INY
		LDA	z:player::socre_digits_12,X
		AND	#$F0
		LSR
		LSR
		LSR
		BNE	loc_C41C0B
		LDA	z:$44
		BEQ	loc_C41C0B
		BRA	loc_C41C1E
; ---------------------------------------------------------------------------

loc_C41C0B:
		STZ	z:$44
		PHX
		TAX
		LDA	f:hud_digits_tilenos_upper,X
		PLX
		STA	a:.LOWORD(bg3_tilemap),Y
		CLC
		ADC	#$10
		STA	a:.LOWORD(bg3_tilemap+$40),Y

loc_C41C1E:
		INY
		INY
		LDA	z:player::socre_digits_12,X
		AND	#$F
		ASL
		BNE	loc_C41C2E
		LDA	z:$44
		BEQ	loc_C41C2E
		BRA	loc_C41C41
; ---------------------------------------------------------------------------

loc_C41C2E:
		STZ	z:$44
		PHX
		TAX
		LDA	f:hud_digits_tilenos_upper,X
		PLX
		STA	a:.LOWORD(bg3_tilemap),Y
		CLC
		ADC	#$10
		STA	a:.LOWORD(bg3_tilemap+$40),Y

loc_C41C41:
		INY
		INY

loc_C41C43:
		REP	#$20
		LDA	z:player::socre_digits_12,X
		SEC
		SBC	a:.LOWORD($11C),X
		LDA	z:player::score_digits_56,X
		SBC	a:.LOWORD($11A),X
		BCC	locret
		SED
		LDA	a:.LOWORD($11C),X
		CLC
		ADC	a:.LOWORD($11C),X
		STA	a:.LOWORD($11C),X
		LDA	a:.LOWORD($11A),X
		ADC	a:.LOWORD($11A),X

loc_C41C63:
		STA	a:.LOWORD($11A),X
		CLD

loc_C41C67:
		JSL	f:add_extra_life
		LDA	a:.LOWORD($11C),X
		SEC
		SBC	#0
		LDA	a:.LOWORD($11A),X
		SBC	#$1000
		BCC	loc_C41C43
		LDA	#0
		STA	a:.LOWORD($11C),X
		LDA	#$1000
		STA	a:.LOWORD($11A),X
		BRA	loc_C41C43
; End of function add_to_score

.A8
.I16

locret:
		REP	#$20
.A16
		RTL
; End of function locret

; ---------------------------------------------------------------------------
hud_digits_tilenos_upper:.WORD $208F, $2086, $2087, $2088, $2089, $208A, $208B,	$208C, $208D, $208E; 0
.A16
.I16

punch:
		REP	#$20

loc_C41CA1:
		LDA	z:player::direction,X

loc_C41CA3:
		AND	#$F
		ASL
		PHX
		TAX

loc_C41CA9:
		LDA	f:player_animation_list+$18,X

loc_C41CAD:
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
		LDA	#.LOWORD(loc_C41CC7)

loc_C41CBF:
		STA	z:object::handler,X

loc_C41CC1:
		SEP	#$20
.A8

loc_C41CC3:
		LDA	#.BANKBYTE(loc_C41CC7)

loc_C41CC5:
		STA	z:object::handler+2,X

loc_C41CC7:
		JSL	f:_handle_player_movement

loc_C41CCB:
		BCC	locret_C41D08

loc_C41CCD:
		REP	#$20
.A16
		LDA	z:player::direction,X
		AND	#$F
		ASL
		PHX
		TAX
		LDA	f:player_animation_list,X
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
		LDA	#.LOWORD(handle_player_movement)

loc_C41CED:
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(handle_player_movement)
		STA	z:object::handler+2,X
		SEP	#$20
		LDA	z:player::is_ai,X
		BEQ	locret_C41D08
		REP	#$20
.A16
		LDA	#.LOWORD(_handle_player_movement_0)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_handle_player_movement_0)
		STA	z:object::handler+2,X

locret_C41D08:
		RTL
; End of function punch

; ---------------------------------------------------------------------------
		SEP	#$20
.A8
.I16

sub_C41D0B:
		SEP	#$20
		LDA	z:object::handler+$39,X
		BIT	#2
		BNE	loc_C41D17
		JML	f:locret_C41E15
; ---------------------------------------------------------------------------

loc_C41D17:
		REP	#$20
.A16
		LDA	#.LOWORD(punch)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(punch)
		STA	z:2,X

loc_C41D24:
		SEP	#$20
		LDA	z:$20,X
		BIT	#1
		BEQ	loc_C41D30
		JML	f:loc_C41DE1
; ---------------------------------------------------------------------------

loc_C41D30:
		BIT	#2
		BEQ	loc_C41D38
		JML	f:loc_C41DAC
; ---------------------------------------------------------------------------

loc_C41D38:
		BIT	#4
		BEQ	loc_C41D40
		JML	f:loc_C41D77
; ---------------------------------------------------------------------------

loc_C41D40:
		REP	#$20
.A16
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$FFF3
		STA	z:player::y_position,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:player::y_position,X
		PLA
		STA	z:player::x_position,X
		LDA	a:.LOWORD(collision_map),Y
		BIT	#BOMB
		BNE	loc_C41D70
		JML	f:locret_C41E15
; ---------------------------------------------------------------------------

loc_C41D70:
		ORA	#$200
		STA	a:.LOWORD(collision_map),Y
		RTL
; ---------------------------------------------------------------------------
.A8

loc_C41D77:
		REP	#$20
.A16
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$D
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		LDA	a:.LOWORD(collision_map),Y
		BIT	#BOMB
		BNE	loc_C41DA5
		JML	f:locret_C41E15
; ---------------------------------------------------------------------------

loc_C41DA5:
		ORA	#$2200
		STA	a:.LOWORD(collision_map),Y
		RTL
; ---------------------------------------------------------------------------
.A8

loc_C41DAC:
		REP	#$20
.A16
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$FFF3
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		LDA	a:.LOWORD(collision_map),Y
		BIT	#BOMB
		BNE	loc_C41DDA
		JML	f:locret_C41E15
; ---------------------------------------------------------------------------

loc_C41DDA:
		ORA	#$3200
		STA	a:.LOWORD(collision_map),Y
		RTL
; ---------------------------------------------------------------------------
.A8

loc_C41DE1:
		REP	#$20
.A16
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$D
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		LDA	a:.LOWORD(collision_map),Y
		BIT	#BOMB
		BNE	loc_C41E0F
		JML	f:locret_C41E15
; ---------------------------------------------------------------------------

loc_C41E0F:
		ORA	#$1200
		STA	a:.LOWORD(collision_map),Y

locret_C41E15:
		RTL
; End of function sub_C41D0B

.A8
.I16

sub_C41E16:
		JSL	f:sub_C4225E
		BCS	loc_C41E20
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41E20:
		JSL	f:is_object_aligned
		BCS	loc_C41E2A
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41E2A:
		SEP	#$20
		LDA	z:$20,X
		AND	#$C
		BNE	loc_C41E36
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41E36:
		LDA	z:$14,X
		AND	#$F
		CMP	#8
		BCS	loc_C41E95
		REP	#$20
.A16
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#.LOWORD(-9)
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C41E66
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41E66:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$10
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$FFF0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C41E8E
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41E8E:
		JSL	f:sub_C423BD
		JMP	a:.LOWORD(_handle_player_movement)
; ---------------------------------------------------------------------------

loc_C41E95:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#8
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C41EBD
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41EBD:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$10
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$10
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C41EE5
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41EE5:
		JSL	f:sub_C423BD
		JMP	a:.LOWORD(_handle_player_movement)
; End of function sub_C41E16

.A8
.I16

sub_C41EEC:
		JSL	f:sub_C4220E
		BCS	loc_C41EF6
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41EF6:
		JSL	f:is_object_aligned
		BCS	loc_C41F00
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41F00:
		SEP	#$20
		LDA	z:player::direction,X
		AND	#$C
		BNE	loc_C41F0C
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41F0C:
		LDA	z:player::y_position,X
		AND	#$F
		CMP	#8
		BCS	loc_C41F6B
		REP	#$20
.A16
		LDA	z:player::x_position,X
		PHA
		LDA	z:player::y_position,X
		PHA
		LDA	z:player::x_position,X
		CLC
		ADC	#0
		STA	z:player::x_position,X
		LDA	z:player::y_position,X
		CLC
		ADC	#$FFF7
		STA	z:player::y_position,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:player::y_position,X
		PLA
		STA	z:player::x_position,X
		BCC	loc_C41F3C
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41F3C:
		REP	#$20
		LDA	z:player::x_position,X
		PHA
		LDA	z:player::y_position,X
		PHA
		LDA	z:player::x_position,X
		CLC
		ADC	#$FFF0
		STA	z:player::x_position,X
		LDA	z:player::y_position,X
		CLC
		ADC	#$FFF0
		STA	z:player::y_position,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:player::y_position,X
		PLA
		STA	z:player::x_position,X
		BCC	loc_C41F64
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41F64:
		JSL	f:sub_C423BD
		JMP	a:.LOWORD(_handle_player_movement)
; ---------------------------------------------------------------------------

loc_C41F6B:
		REP	#$20
		LDA	z:player::x_position,X
		PHA
		LDA	z:player::y_position,X
		PHA
		LDA	z:player::x_position,X
		CLC
		ADC	#0
		STA	z:player::x_position,X
		LDA	z:player::y_position,X
		CLC
		ADC	#8
		STA	z:player::y_position,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:player::y_position,X
		PLA
		STA	z:player::x_position,X
		BCC	loc_C41F93
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41F93:
		REP	#$20
		LDA	z:player::x_position,X
		PHA
		LDA	z:player::y_position,X
		PHA
		LDA	z:player::x_position,X
		CLC
		ADC	#$FFF0
		STA	z:player::x_position,X
		LDA	z:player::y_position,X
		CLC
		ADC	#$10
		STA	z:player::y_position,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:player::y_position,X
		PLA
		STA	z:player::x_position,X
		BCC	loc_C41FBB
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41FBB:
		JSL	f:sub_C423BD
		JMP	a:.LOWORD(_handle_player_movement)
; End of function sub_C41EEC

.A8
.I16

sub_C41FC2:
		JSL	f:sub_C421BE
		BCS	loc_C41FCC
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41FCC:
		JSL	f:is_object_aligned
		BCS	loc_C41FD6
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41FD6:
		SEP	#$20
		LDA	z:player::direction,X
		AND	#3
		BNE	loc_C41FE2
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C41FE2:
		LDA	z:player::x_position,X
		AND	#$F
		CMP	#8
		BCS	loc_C42041
		REP	#$20
.A16
		LDA	z:player::x_position,X
		PHA
		LDA	z:player::y_position,X
		PHA
		LDA	z:player::x_position,X
		CLC
		ADC	#$FFF7
		STA	z:player::x_position,X
		LDA	z:player::y_position,X
		CLC
		ADC	#0
		STA	z:player::y_position,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:player::y_position,X
		PLA
		STA	z:player::x_position,X
		BCC	loc_C42012
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C42012:
		REP	#$20
		LDA	z:player::x_position,X
		PHA
		LDA	z:player::y_position,X
		PHA
		LDA	z:player::x_position,X
		CLC
		ADC	#$FFF0
		STA	z:player::x_position,X
		LDA	z:player::y_position,X
		CLC
		ADC	#$10
		STA	z:player::y_position,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:player::y_position,X
		PLA
		STA	z:player::x_position,X
		BCC	loc_C4203A
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C4203A:
		JSL	f:sub_C42364
		JMP	a:.LOWORD(_handle_player_movement)
; ---------------------------------------------------------------------------

loc_C42041:
		REP	#$20
		LDA	z:player::x_position,X
		PHA
		LDA	z:player::y_position,X
		PHA
		LDA	z:player::x_position,X
		CLC
		ADC	#8
		STA	z:player::x_position,X
		LDA	z:player::y_position,X
		CLC
		ADC	#0
		STA	z:player::y_position,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:player::y_position,X
		PLA
		STA	z:player::x_position,X
		BCC	loc_C42069
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C42069:
		REP	#$20
		LDA	z:player::x_position,X
		PHA
		LDA	z:player::y_position,X
		PHA
		LDA	z:player::x_position,X
		CLC
		ADC	#$10
		STA	z:player::x_position,X
		LDA	z:player::y_position,X
		CLC
		ADC	#$10
		STA	z:player::y_position,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:player::y_position,X
		PLA
		STA	z:player::x_position,X
		BCC	loc_C42091
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C42091:
		JSL	f:sub_C42364
		JMP	a:.LOWORD(_handle_player_movement)
; End of function sub_C41FC2

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR handle_player_movement
.A8

loc_C42098:
		JSL	f:sub_C4216E
		BCS	loc_C420A2
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C420A2:
		JSL	f:is_object_aligned

loc_C420A6:
		BCS	loc_C420AC
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C420AC:
		SEP	#$20
		LDA	z:$20,X
		AND	#3
		BNE	loc_C420B8
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C420B8:
		LDA	z:$11,X
		AND	#$F
		CMP	#8
		BCS	loc_C42117
		REP	#$20
.A16
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$FFF7
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C420E8
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C420E8:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$FFF0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$FFF0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C42110
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C42110:
		JSL	f:sub_C42364
		JMP	a:.LOWORD(_handle_player_movement)
; ---------------------------------------------------------------------------

loc_C42117:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#8
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	sub_C4213F
		JML	f:loc_C4131F
; END OF FUNCTION CHUNK	FOR handle_player_movement
.A16
.I16

sub_C4213F:
		REP	#$20
		LDA	z:player::x_position,X
		PHA
		LDA	z:player::y_position,X
		PHA
		LDA	z:player::x_position,X
		CLC
		ADC	#$10
		STA	z:player::x_position,X
		LDA	z:player::y_position,X
		CLC
		ADC	#$FFF0
		STA	z:player::y_position,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:player::y_position,X
		PLA
		STA	z:player::x_position,X
		BCC	loc_C42167
		JML	f:loc_C4131F
; ---------------------------------------------------------------------------

loc_C42167:
		JSL	f:sub_C42364
		JMP	a:.LOWORD(_handle_player_movement)
; End of function sub_C4213F

.A8
.I16

sub_C4216E:
		REP	#$20
.A16
		LDA	z:player::x_position,X
		PHA
		LDA	z:player::y_position,X
		PHA
		LDA	z:player::x_position,X
		CLC
		ADC	#0
		STA	z:player::x_position,X
		LDA	z:player::y_position,X
		CLC
		ADC	#$FFF3
		STA	z:player::y_position,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:player::y_position,X
		PLA
		STA	z:player::x_position,X
		BCC	loc_C421B4
		LDA	z:player::y_position,X
		AND	#$F
		CMP	#8
		BEQ	loc_C421AE
		BCC	loc_C421A8
		JSL	f:sub_C422F1
		JSL	f:sub_C4239D
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C421A8:
		JSL	f:sub_C422AE
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C421AE:
		JSL	f:sub_C422AE
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C421B4:
		JSL	f:sub_C422F1
		JSL	f:sub_C4239D
		CLC
		RTL
; End of function sub_C4216E

.A8
.I16

sub_C421BE:
		REP	#$20
.A16
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$D
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C42204
		LDA	z:$14,X
		AND	#$F
		CMP	#8
		BEQ	loc_C421FE
		BCS	loc_C421F8
		JSL	f:sub_C422F1
		JSL	f:sub_C423CE
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C421F8:
		JSL	f:sub_C422AE
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C421FE:
		JSL	f:sub_C422AE
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C42204:
		JSL	f:sub_C422F1
		JSL	f:sub_C423CE
		CLC
		RTL
; End of function sub_C421BE

.A8
.I16

sub_C4220E:
		REP	#$20
.A16
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$FFF3
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C42254
		LDA	z:$11,X
		AND	#$F
		CMP	#8
		BEQ	loc_C4224E
		BCC	loc_C42248
		JSL	f:sub_C4230B
		JSL	f:sub_C42375
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C42248:
		JSL	f:sub_C422AE
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C4224E:
		JSL	f:sub_C422AE
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C42254:
		JSL	f:sub_C4230B
		JSL	f:sub_C42375
		CLC
		RTL
; End of function sub_C4220E

.A8
.I16

sub_C4225E:
		REP	#$20
.A16
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$D
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C422A4
		LDA	z:$11,X
		AND	#$F
		CMP	#8
		BEQ	loc_C4229E
		BCS	loc_C42298
		JSL	f:sub_C4230B
		JSL	f:sub_C42325
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C42298:
		JSL	f:sub_C422AE
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C4229E:
		JSL	f:sub_C422AE
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C422A4:
		JSL	f:sub_C4230B
		JSL	f:sub_C42325
		CLC
		RTL
; End of function sub_C4225E

.A16
.I16

sub_C422AE:
		SEP	#$20
.A8
		LDA	z:object::handler+$39,X
		BIT	#1
		BEQ	locret_C422E7
		LDA	a:.LOWORD(collision_map),Y
		BIT	#BOMB
		BEQ	locret_C422E7
		LDA	a:.LOWORD(collision_map+1),Y
		BIT	#2
		BNE	locret_C422E7
		LDA	#0
		XBA
		LDA	z:$20,X
		PHX
		TAX
		LDA	f:byte_C422E8,X
		PLX
		ORA	#8
		CMP	a:.LOWORD(collision_map+1),Y
		BEQ	loc_C422DF
		STA	a:.LOWORD(collision_map+1),Y
		LDA	#.LOWORD(BOMB)
		STA	a:.LOWORD(collision_map),Y

loc_C422DF:
		LDA	a:.LOWORD(collision_map),Y
		ORA	#EXIT
		STA	a:.LOWORD(collision_map),Y

locret_C422E7:
		RTL
; End of function sub_C422AE

; ---------------------------------------------------------------------------
byte_C422E8:	.BYTE 0, $10		; 0
		.BYTE $30, 0		; 2
		.BYTE $20, 0		; 4
		.BYTE 0, 0		; 6
		.BYTE 0			; 8
.A16
.I16

sub_C422F1:
		SEP	#$20
.A8
		LDA	z:$11,X
		AND	#$F
		CMP	#8
		BEQ	loc_C42308
		BCC	loc_C42304
		JSL	f:sub_C42375
		REP	#$20
.A16
		RTL
; ---------------------------------------------------------------------------

loc_C42304:
		JSL	f:sub_C42325

loc_C42308:
		REP	#$20
		RTL
; End of function sub_C422F1

.A16
.I16

sub_C4230B:
		SEP	#$20
.A8
		LDA	z:$14,X
		AND	#$F
		CMP	#8
		BEQ	loc_C42322
		BCC	loc_C4231E
		JSL	f:sub_C4239D
		REP	#$20
.A16
		RTL
; ---------------------------------------------------------------------------

loc_C4231E:
		JSL	f:sub_C423CE

loc_C42322:
		REP	#$20
		RTL
; End of function sub_C4230B

.A16
.I16

sub_C42325:
		REP	#$20
		LDA	z:$10,X
		AND	#$F00
		CMP	#$700
		BCS	loc_C4236D
		AND	#$700
		EOR	#$700
		CMP	z:$3E,X
		BCS	loc_C4236D
		LDA	z:$10,X
		AND	#$F800
		ORA	#$800
		STA	z:$10,X
		RTL
; End of function sub_C42325

.A16
.I16

sub_C42346:
		REP	#$20
		LDA	z:$10,X
		BIT	#$800
		BNE	loc_C4236D
		AND	#$700
		EOR	#$700
		CMP	z:$3E,X
		BCS	loc_C4236D
		LDA	z:$10,X
		AND	#$F800
		ORA	#$800
		STA	z:$10,X
		RTL
; End of function sub_C42346

.A16
.I16

sub_C42364:
		REP	#$20
		LDA	z:$20,X
		BIT	#1
		BEQ	loc_C42395

loc_C4236D:
		LDA	z:$10,X
		CLC
		ADC	z:$3E,X
		STA	z:$10,X
		RTL
; End of function sub_C42364

.A16
.I16

sub_C42375:
		REP	#$20
		LDA	z:player::wrap_delay,X
		AND	#$F00
		CMP	#$900
		BCC	loc_C42395
		LDA	z:player::wrap_delay,X
		AND	#$700
		CMP	z:$3E,X
		BCS	loc_C42395
		LDA	z:player::wrap_delay,X
		AND	#$F800
		ORA	#$800
		STA	z:player::wrap_delay,X
		RTL
; ---------------------------------------------------------------------------

loc_C42395:
		LDA	z:player::wrap_delay,X
		SEC
		SBC	z:$3E,X
		STA	z:player::wrap_delay,X
		RTL
; End of function sub_C42375

.A16
.I16

sub_C4239D:
		REP	#$20
		LDA	z:$13,X
		AND	#$F00
		CMP	#$900
		BCC	loc_C423C6
		LDA	z:$13,X
		AND	#$700
		CMP	z:$3E,X
		BCS	loc_C423C6
		LDA	z:$13,X
		AND	#$F800
		ORA	#$800
		STA	z:$13,X
		RTL
; End of function sub_C4239D

.A16
.I16

sub_C423BD:
		REP	#$20
		LDA	z:$20,X
		BIT	#4
		BNE	loc_C423EF

loc_C423C6:
		LDA	z:$13,X
		SEC
		SBC	z:$3E,X
		STA	z:$13,X
		RTL
; End of function sub_C423BD

.A16
.I16

sub_C423CE:
		REP	#$20
		LDA	z:$13,X
		AND	#$F00
		CMP	#$700
		BCS	loc_C423EF
		AND	#$700
		EOR	#$700
		CMP	z:$3E,X
		BCS	loc_C423EF
		LDA	z:$13,X
		AND	#$F800
		ORA	#$800
		STA	z:$13,X
		RTL
; ---------------------------------------------------------------------------

loc_C423EF:
		LDA	z:$13,X
		CLC
		ADC	z:$3E,X
		STA	z:$13,X
		RTL
; End of function sub_C423CE

.A8
.I16

is_object_aligned:
		SEP	#$20
.A8
		LDA	z:player::x_position,X
		AND	#$F
		CMP	#8
		BNE	loc_C4240B
		LDA	z:player::y_position,X
		AND	#$F
		CMP	#8
		BNE	loc_C4240B
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C4240B:
		SEC
		RTL
; End of function is_object_aligned

.A8
.I16

sub_C4240D:
		SEP	#$20
		LDA	a:.LOWORD(frame_count) ; orig=0x0300
		AND	#3
		BEQ	loc_C4241A
		JML	f:loc_C412EE
; ---------------------------------------------------------------------------

loc_C4241A:
		SEP	#$20
		LDA	z:$30,X
		STA	z:$40
		LDA	a:.LOWORD($13C),X
		BIT	#1
		BEQ	loc_C4242B
		LDA	#0
		STA	z:$40

loc_C4242B:
		LDA	z:$40
		CMP	z:$24,X
		BCS	loc_C42435
		JML	f:loc_C412EE
; ---------------------------------------------------------------------------

loc_C42435:
		JSL	f:get_object_square_index
		REP	#$20
.A16
		TAY
		LDA	a:.LOWORD(collision_map),Y
		AND	#$2FF
		CMP	#$210
		BNE	loc_C4244B
		JML	f:loc_C412EE
; ---------------------------------------------------------------------------

loc_C4244B:
		AND	#$E0
		BEQ	loc_C42454
		JML	f:loc_C412EE
; ---------------------------------------------------------------------------

loc_C42454:
		STY	z:$56
		JSL	f:drop_bomb
		JMP	a:.LOWORD(loc_C412EE)
; End of function sub_C4240D

.A8
.I16

sub_C4245D:
		REP	#$20
.A16
		LDX	#$F40

loc_C42462:
		LDA	z:0,X
		CMP	#.LOWORD(bonus_handling_object)
		BEQ	loc_C42473
		LDA	z:6,X
		CMP	#$FFFF
		BEQ	locret_C42482
		TAX
		BRA	loc_C42462
; ---------------------------------------------------------------------------

loc_C42473:
		REP	#$20
		LDA	#.LOWORD(sub_C42506)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C42506)
		STA	z:2,X
		BRA	sub_C4245D
; ---------------------------------------------------------------------------

locret_C42482:
		RTL
; End of function sub_C4245D

.A16
.I16

create_bonus_object:
		REP	#$20
		PHA
		STY	z:$46
		SEP	#$20
.A8
		LDA	#.LOBYTE(bonus_handling_object)
		STA	z:$DB
		LDA	#.HIBYTE(bonus_handling_object)
		STA	z:$DC
		LDA	#.BANKBYTE(bonus_handling_object)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		PLA
		BCS	locret_C424D2
		PHY
		LDY	z:$46
		ORA	#$200
		STA	a:.LOWORD(collision_map),Y
		AND	#BONUS_MASK
		ASL
		PHX
		TAX
		LDA	f:bonus_tiles,X
		PLX
		STA	a:.LOWORD(bg1_tilemap),Y
		PLY
		STA	a:.LOWORD($20),Y
		ORA	#$20
		STA	a:.LOWORD($21),Y
		LDA	z:$46
		STA	a:.LOWORD($12),Y
		LDA	#0
		STA	a:.LOWORD($14),Y
		INC	a:.LOWORD(number_of_visible_bonuses) ; orig=0x0C91

locret_C424D2:
		RTL
; End of function create_bonus_object

.A16
.I16

bonus_handling_object:
		REP	#$20
		LDY	z:$12,X
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$400
		BNE	loc_C424FC
		AND	#$FF
		BEQ	loc_C424FC
		CMP	#.LOWORD(BONUS_MASK)
		BEQ	loc_C424FC
		SEP	#$20
.A8
		PHX
		INC	z:$14,X
		LDA	z:$14,X
		BIT	#2
		BNE	loc_C424F5
		INX

loc_C424F5:
		LDA	z:$20,X
		STA	a:.LOWORD(bg1_tilemap),Y
		PLX
		RTL
; ---------------------------------------------------------------------------

loc_C424FC:
		REP	#$20
.A16
		DEC	a:.LOWORD(number_of_visible_bonuses) ; orig=0x0C91
		JSL	f:delete_object
		RTL
; End of function bonus_handling_object

.A16
.I16

sub_C42506:
		REP	#$20
		LDY	z:$12,X
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		RTL
; End of function sub_C42506

.A16
.I16

sub_C42517:
		REP	#$20
		STY	z:$56
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C4257B)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C4257B)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C4257B)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	loc_C42553
		LDA	z:$42
		STA	a:.LOWORD($C),Y
		LDA	z:$4A
		STA	a:.LOWORD($E),Y
		LDA	#1
		STA	a:.LOWORD($A),Y
		LDA	#0
		STA	a:.LOWORD($10),Y
		LDA	z:$56
		STA	a:.LOWORD(8),Y
		LDY	z:$56
		RTL
; ---------------------------------------------------------------------------

loc_C42553:
		LDY	z:$56
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$40
		BEQ	loc_C4256E
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		JSL	f:sub_C42654
		RTL
; ---------------------------------------------------------------------------

loc_C4256E:
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		RTL
; End of function sub_C42517

.A16
.I16

sub_C4257B:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C42588
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C42588:
		BIT	#$41
		BEQ	loc_C42590
		JML	f:locret_C4262D
; ---------------------------------------------------------------------------

loc_C42590:
		REP	#$20
.A16
		LDY	z:8,X
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$80
		BEQ	loc_C425A0
		JML	f:loc_C42629
; ---------------------------------------------------------------------------

loc_C425A0:
		DEC	z:$A,X
		BEQ	loc_C425A8
		JML	f:locret_C4262D
; ---------------------------------------------------------------------------

loc_C425A8:
		LDA	z:$E,X
		PHX
		TAX
		LDA	f:byte_C428C1,X
		STA	z:$40
		LDA	f:byte_C428C1+2,X
		STA	z:$42
		PLX
		LDA	z:$40
		STA	z:$A,X
		LDA	z:$42
		STA	a:.LOWORD(bg1_tilemap),Y
		INC	z:$E,X
		INC	z:$E,X
		INC	z:$E,X
		INC	z:$E,X
		LDA	z:$E,X
		BIT	#$1F
		BNE	locret_C4262D
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$40
		BEQ	loc_C4262E
		LDA	z:$C,X
		BEQ	loc_C4263F
		LDA	#$200
		STA	a:.LOWORD(collision_map),Y
		JSL	f:sub_C42654
		REP	#$20
		LDA	#$5F
		STA	a:.LOWORD(collision_map),Y
		LDA	z:$C,X
		AND	#$1F
		ASL
		PHX
		TAX
		LDA	f:bonus_tiles,X
		PLX
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	#6
		STA	z:$A,X
		REP	#$20
		LDA	#.LOWORD(loc_C42611)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C42611)
		STA	z:2,X

loc_C42611:
		REP	#$20
.A16
		LDY	z:8,X
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$80
		BNE	loc_C42629
		DEC	z:$A,X
		BNE	locret_C4262D
		LDA	z:$C,X
		PHY
		JSL	f:create_bonus_object
		PLY

loc_C42629:
		JSL	f:delete_object

locret_C4262D:
		RTL
; ---------------------------------------------------------------------------

loc_C4262E:
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		JSL	f:delete_object
		RTL
; ---------------------------------------------------------------------------

loc_C4263F:
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		JSL	f:sub_C42654
		JSL	f:delete_object
		RTL
; End of function sub_C4257B

.A16
.I16

sub_C42654:
		REP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$40
		BNE	locret_C426C8
		BIT	#$1000
		BNE	locret_C426C8
		PHX
		PHY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$C0
		BNE	loc_C426DC
		LDA	a:.LOWORD($956),Y
		BIT	#$C0
		BEQ	loc_C42682
		BIT	#$80
		BNE	loc_C4269E
		LDA	#$806
		STA	a:.LOWORD($534),Y
		BRA	loc_C4269E
; ---------------------------------------------------------------------------

loc_C42682:
		BIT	#$320
		BNE	loc_C42695
		LDA	a:.LOWORD(bg1_tilemap+$22)	; orig=0x0516
		ORA	#8
		STA	a:.LOWORD($534),Y
		STA	a:.LOWORD($554),Y
		BRA	loc_C4269E
; ---------------------------------------------------------------------------

loc_C42695:
		LDA	a:.LOWORD(bg1_tilemap+$22)	; orig=0x0516
		ORA	#8
		STA	a:.LOWORD($554),Y

loc_C4269E:
		LDX	#0
		LDA	a:.LOWORD($8D6),Y
		BIT	#$C0
		BEQ	loc_C426B9
		LDX	#2
		BIT	#$40
		BNE	loc_C426D2
		CPY	#$5D
		BCC	loc_C426C9
		LDX	#4

loc_C426B9:
		LDA	f:empty_tile_after_explosion_related,X
		ORA	a:.LOWORD(bg1_tilemap+$22)	; orig=0x0516
		STA	a:.LOWORD(bg1_tilemap),Y

loc_C426C3:
		STA	a:.LOWORD(bg1_tilemap+$20),Y

loc_C426C6:
		PLY
		PLX

locret_C426C8:
		RTL
; ---------------------------------------------------------------------------

loc_C426C9:
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		PLY
		PLX
		RTL
; ---------------------------------------------------------------------------

loc_C426D2:
		AND	#$1F
		CMP	#$1F
		BNE	loc_C426B9
		BRA	loc_C426C6
; ---------------------------------------------------------------------------

loc_C426DC:
		BIT	#$80
		BNE	loc_C426EF
		LDA	a:.LOWORD($8D6),Y
		BIT	#$C0
		BEQ	loc_C426EF
		LDA	#$802
		STA	a:.LOWORD(bg1_tilemap),Y

loc_C426EF:
		LDA	a:.LOWORD($956),Y
		BIT	#$C0
		BNE	loc_C426FF
		TYA
		CLC
		ADC	#$40
		TAY
		BRA	loc_C4269E
; ---------------------------------------------------------------------------

loc_C426FF:
		PLY
		PLX
		RTL
; End of function sub_C42654

.A16
.I16

sub_C42702:
		REP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_8) ; orig=0x0D30
		CMP	#3
		BEQ	loc_C42714
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$8000
		BNE	locret_C4273E

loc_C42714:
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$200
		BNE	locret_C4273E
		LDY	#$44

loc_C4271F:
		LDA	#$D
		STA	z:$40

loc_C42724:
		LDA	a:.LOWORD(collision_map),Y
		BEQ	loc_C4272D
		JSL	f:sub_C42654

loc_C4272D:
		INY
		INY
		DEC	z:$40
		BNE	loc_C42724
		TYA
		CLC
		ADC	#$26
		TAY
		CPY	#$304
		BNE	loc_C4271F

locret_C4273E:
		RTL
; End of function sub_C42702

.A16
.I16

sub_C4273F:
		REP	#$20
		LDA	#$80
		STA	z:$32,X
		LDA	#8
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		REP	#$20
		LDA	#.LOWORD(loc_C4275C)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C4275C)
		STA	z:2,X

loc_C4275C:
		REP	#$20
.A16
		DEC	z:$32,X
		BNE	loc_C427DC
		LDA	#$10
		STA	z:$32,X
		LDA	#2
		STA	z:$40
		LDA	#$FFFF
		STA	z:$30,X
		LDA	z:5,X
		AND	#$FF
		BNE	loc_C42782
		LDA	#1
		STA	z:$40
		LDA	#1
		STA	z:$30,X

loc_C42782:
		JSL	f:change_direction_and_start_animation
		REP	#$20
		LDA	#.LOWORD(loc_C42793)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C42793)
		STA	z:2,X

loc_C42793:
		REP	#$20
.A16
		LDA	z:$30,X
		CLC
		ADC	z:$11,X
		STA	z:$11,X
		DEC	z:$32,X
		BNE	loc_C427B6
		LDA	#4
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		REP	#$20
		LDA	#.LOWORD(loc_C427BB)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C427BB)
		STA	z:2,X

loc_C427B6:
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C427BB:
		REP	#$20
.A16
		LDA	#2
		CLC
		ADC	z:$14,X
		STA	z:$14,X
		CMP	#$110
		BCC	loc_C427D7
		REP	#$20
		LDA	#.LOWORD(loc_C427D7)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C427D7)
		STA	z:2,X

loc_C427D7:
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C427DC:
		JSL	f:advance_animation_2
		RTL
; End of function sub_C4273F

.A8
.I16

create_score_popup:
		SEP	#$20
		LDA	#.LOBYTE(score_popup)
		STA	z:$DB
		LDA	#.HIBYTE(score_popup)
		STA	z:$DC
		LDA	#.BANKBYTE(score_popup)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCC	loc_C427FD
		JML	f:locret_C42815
; ---------------------------------------------------------------------------

loc_C427FD:
		REP	#$20
.A16
		LDA	z:enemy::x_position,X
		STA	a:.LOWORD(enemy::x_position),Y
		LDA	z:enemy::y_position,X
		STA	a:.LOWORD(enemy::y_position),Y
		LDA	z:enemy::animation,X
		STA	a:.LOWORD(enemy::animation),Y
		SEP	#$20
.A8
		LDA	z:enemy::flags,X
		STA	a:.LOWORD(enemy::flags),Y

locret_C42815:
		RTL
; End of function create_score_popup

.A8
.I16

score_popup:
		SEP	#$20
		LDA	#.BANKBYTE(score_popup_related)
		STA	z:$52
		LDA	#$E
		STA	z:player::palette+1,X
		LDA	#$30
		STA	z:player::palette,X
		REP	#$20
.A16
		LDA	z:score_popup_object::score_index,X
		CMP	#6
		BCC	loc_C42830
		LDA	#6

loc_C42830:
		AND	#$FF
		STA	z:score_popup_object::score_index,X
		ASL
		PHX
		TAX
		LDA	f:score_popup_related,X
		STA	z:$50
		PLX
		JSL	f:start_animation
		REP	#$20
		LDA	#.LOWORD(player1_object)
		STA	z:$44
		LDA	z:score_popup_object::flags,X
		BIT	#2
		BEQ	loc_C42856
		LDA	#.LOWORD(player2_object)
		STA	z:$44

loc_C42856:
		LDA	z:score_popup_object::score_index,X
		ASL
		ASL
		PHX
		TAX
		LDA	f:some_array_of_scores,X
		STA	z:$42
		LDA	f:some_array_of_scores+2,X
		STA	z:$40
		PLX
		STZ	z:score_popup_object::score_index,X ;	Now reused to make the popup flash
		PHX
		LDX	z:$44
		JSL	f:add_to_score_if_allowed
		PLX
		REP	#$20
		LDA	#.LOWORD(flash_score_popup)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(flash_score_popup)
		STA	z:object::handler+2,X

flash_score_popup:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C4288D
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C4288D:
		BIT	#$41
		BEQ	loc_C42895
		JML	f:loc_C428AC
; ---------------------------------------------------------------------------

loc_C42895:
		REP	#$20
.A16
		LDA	z:score_popup_s+$13,X
		CLC
		ADC	#$FFD0
		STA	z:score_popup_s+$13,X
		INC	z:score_popup_object::score_index,X
		LDA	z:score_popup_object::score_index,X
		CMP	#$80
		BNE	loc_C428AC
		JSL	f:delete_object
.A8

loc_C428AC:
		SEP	#$20
		LDA	#6
		STA	z:score_popup_object::effective_palette,X
		LDA	z:score_popup_object::score_index,X
		BIT	#4
		BEQ	loc_C428BC
		LDA	#$E
		STA	z:score_popup_object::effective_palette,X

loc_C428BC:
		JSL	f:advance_animation
		RTL
; End of function score_popup

; ---------------------------------------------------------------------------
byte_C428C1:	.BYTE $C, 0, $C0, $1D	; 0
		.BYTE $A, 0, $C2, $1D	; 4
		.BYTE 8, 0, $C4, $1D	; 8
		.BYTE 6, 0, $C6, $1D	; $C
		.BYTE 2, 0, $C8, $1D	; $10
		.BYTE 2, 0, $C8, $1D	; $14
		.BYTE 2, 0, $CA, $1D	; $18
		.BYTE 1, 0, $38, $C	; $1C
		.BYTE $C, 0, $E0, $1D	; $20
		.BYTE $A, 0, $E2, $1D	; $24
		.BYTE 8, 0, $E4, $1D	; $28
		.BYTE 6, 0, $E6, $1D	; $2C
		.BYTE 4, 0, $E8, $1D	; $30
		.BYTE 3, 0, $EA, $1D	; $34
		.BYTE 2, 0, $EC, $1D	; $38
		.BYTE 1, 0, $38, $C	; $3C
player_animation_list:
		.ADDR up_walking_animation; 0
		.ADDR right_walking_animation; 1
		.ADDR left_walking_animation; 2
		.ADDR up_walking_animation; 3
		.ADDR down_walking_animation; 4
		.ADDR up_walking_animation; 5
		.ADDR up_walking_animation; 6
		.ADDR up_walking_animation; 7
		.ADDR up_walking_animation; 8
		.ADDR up_walking_animation; 9
		.ADDR up_walking_animation; $A
		.ADDR up_walking_animation; $B
		.ADDR up_punch_animation; $C
		.ADDR right_punch_animation; $D
		.ADDR left_punch_animation; $E
		.ADDR up_punch_animation; $F
		.ADDR down_punch_animation; $10
		.ADDR up_punch_animation; $11
		.ADDR up_punch_animation; $12
		.ADDR up_punch_animation; $13
		.ADDR up_punch_animation; $14
		.ADDR up_punch_animation; $15
		.ADDR up_punch_animation; $16
		.ADDR up_punch_animation; $17
		.ADDR up_punch_animation; $18
		.ADDR up_punch_animation; $19
		.ADDR up_punch_animation; $1A
		.ADDR up_punch_animation; $1B
		.ADDR jumping_animation	; $1C
		.ADDR up_walking_animation; $1D
		.ADDR right_walking_animation; $1E
		.ADDR down_walking_animation; $1F
		.ADDR left_walking_animation; $20
		.ADDR wrapping_animation; $21
		.ADDR wrapping_animation; $22
		.ADDR wrapping_animation; $23
		.ADDR wrapping_animation; $24
animation_frame_C4294B:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, 0, $20
animation_frame_C42951:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $200,	$20
animation_frame_C42957:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $400,	$20
animation_frame_C4295D:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $2400, $20
animation_frame_C42963:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $2200, $20
animation_frame_C42969:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $2000, $20
wrapping_animation:.BYTE $12
		animation_frame animation_frame_C4294B, $30; 0
		animation_frame animation_frame_C42951, 6; 1
		animation_frame animation_frame_C42957, 6; 2
		animation_frame animation_frame_C4294B, $30; 3
		animation_frame animation_frame_C42957, 6; 4
		animation_frame animation_frame_C42951, 6; 5
		animation_frame animation_frame_C4294B, $30; 6
		animation_frame animation_frame_C4295D, 5; 7
		animation_frame animation_frame_C42963, 5; 8
		animation_frame animation_frame_C42969, 5; 9
		animation_frame animation_frame_C42963, 5; $A
		animation_frame animation_frame_C42969, 5; $B
		animation_frame animation_frame_C42963, 5; $C
		animation_frame animation_frame_C42969, 5; $D
		animation_frame animation_frame_C42963, 5; $E
		animation_frame animation_frame_C42969, 5; $F
		animation_frame animation_frame_C42963, 5; $10
		animation_frame animation_frame_C4295D, 5; $11
animation_frame_C429B8:.BYTE 2		       ; 0
		frame_oam_tile $18, $F0, 0, $20
		frame_oam_tile $D8, $F0, 0, $20
animation_frame_C429C3:.BYTE 2		       ; 0
		frame_oam_tile $17, $F0, 0, $20
		frame_oam_tile $D9, $F0, 0, $20
animation_frame_C429CE:.BYTE 2		       ; 0
		frame_oam_tile $16, $F0, 0, $20
		frame_oam_tile $DA, $F0, 0, $20
animation_frame_C429D9:.BYTE 2		       ; 0
		frame_oam_tile $15, $F0, 0, $20
		frame_oam_tile $DB, $F0, 0, $20
animation_frame_C429E4:.BYTE 2		       ; 0
		frame_oam_tile $14, $F0, 0, $20
		frame_oam_tile $DC, $F0, 0, $20
animation_frame_C429EF:.BYTE 2		       ; 0
		frame_oam_tile $13, $F0, 0, $20
		frame_oam_tile $DD, $F0, 0, $20
animation_frame_C429FA:.BYTE 2		       ; 0
		frame_oam_tile $12, $F0, 0, $20
		frame_oam_tile $DE, $F0, 0, $20
animation_frame_C42A05:.BYTE 2		       ; 0
		frame_oam_tile $11, $F0, 0, $20
		frame_oam_tile $DF, $F0, 0, $20
animation_frame_C42A10:.BYTE 2		       ; 0
		frame_oam_tile $10, $F0, 0, $20
		frame_oam_tile $E0, $F0, 0, $20
animation_frame_C42A1B:.BYTE 2		       ; 0
		frame_oam_tile $F, $F0, 0, $20
		frame_oam_tile $E1, $F0, 0, $20
animation_frame_C42A26:.BYTE 2		       ; 0
		frame_oam_tile $E, $F0, 0, $20
		frame_oam_tile $E2, $F0, 0, $20
animation_frame_C42A31:.BYTE 2		       ; 0
		frame_oam_tile $D, $F0, 0, $20
		frame_oam_tile $E3, $F0, 0, $20
animation_frame_C42A3C:.BYTE 2		       ; 0
		frame_oam_tile $C, $F0, 0, $20
		frame_oam_tile $E4, $F0, 0, $20
animation_frame_C42A47:.BYTE 2		       ; 0
		frame_oam_tile $B, $F0, 0, $20
		frame_oam_tile $E5, $F0, 0, $20
animation_frame_C42A52:.BYTE 2		       ; 0
		frame_oam_tile $A, $F0, 0, $20
		frame_oam_tile $E6, $F0, 0, $20
animation_frame_C42A5D:.BYTE 2		       ; 0
		frame_oam_tile 9, $F0,	0, $20
		frame_oam_tile $E7, $F0, 0, $20
animation_frame_C42A68:.BYTE 6		       ; 0
		frame_oam_tile 8, $F0,	0, $20
		frame_oam_tile $E8, $F0, 0, $20
		frame_oam_tile 8, $F0,	$200, $40
		frame_oam_tile 8, $F8,	$1200, $40
		frame_oam_tile $F0, $F8, $1200, 0
		frame_oam_tile $F0, $F0, $200,	0
animation_frame_C42A87:.BYTE 6		       ; 0
		frame_oam_tile 8, $F0,	0, $20
		frame_oam_tile $E8, $F0, 0, $20
		frame_oam_tile 7, $F0,	$200, $40
		frame_oam_tile 7, $F8,	$1200, $40
		frame_oam_tile $F1, $F8, $1200, 0
		frame_oam_tile $F1, $F0, $200,	0
animation_frame_C42AA6:.BYTE 6		       ; 0
		frame_oam_tile 8, $F0,	0, $20
		frame_oam_tile $E8, $F0, 0, $20
		frame_oam_tile 6, $F0,	$200, $40
		frame_oam_tile 6, $F8,	$1200, $40
		frame_oam_tile $F2, $F8, $1200, 0
		frame_oam_tile $F2, $F0, $200,	0
animation_frame_C42AC5:.BYTE 6		       ; 0
		frame_oam_tile 8, $F0,	0, $20
		frame_oam_tile $E8, $F0, 0, $20
		frame_oam_tile 5, $F0,	$200, $40
		frame_oam_tile 5, $F8,	$1200, $40
		frame_oam_tile $F3, $F8, $1200, 0
		frame_oam_tile $F3, $F0, $200,	0
animation_frame_C42AE4:.BYTE 6		       ; 0
		frame_oam_tile 8, $F0,	0, $20
		frame_oam_tile $E8, $F0, 0, $20
		frame_oam_tile 4, $F0,	$200, $40
		frame_oam_tile 4, $F8,	$1200, $40
		frame_oam_tile $F4, $F8, $1200, 0
		frame_oam_tile $F4, $F0, $200,	0
animation_frame_C42B03:.BYTE 6		       ; 0
		frame_oam_tile 8, $F0,	0, $20
		frame_oam_tile $E8, $F0, 0, $20
		frame_oam_tile 3, $F0,	$200, $40
		frame_oam_tile 3, $F8,	$1200, $40
		frame_oam_tile $F5, $F8, $1200, 0
		frame_oam_tile $F5, $F0, $200,	0
animation_frame_C42B22:.BYTE 6		       ; 0
		frame_oam_tile 8, $F0,	0, $20
		frame_oam_tile $E8, $F0, 0, $20
		frame_oam_tile 2, $F0,	$200, $40
		frame_oam_tile 2, $F8,	$1200, $40
		frame_oam_tile $F6, $F8, $1200, 0
		frame_oam_tile $F6, $F0, $200,	0
animation_frame_C42B41:.BYTE 6		       ; 0
		frame_oam_tile 8, $F0,	0, $20
		frame_oam_tile $E8, $F0, 0, $20
		frame_oam_tile 1, $F0,	$200, $40
		frame_oam_tile 1, $F8,	$1200, $40
		frame_oam_tile $F7, $F8, $1200, 0
		frame_oam_tile $F7, $F0, $200,	0
animation_frame_C42B60:.BYTE 6		       ; 0
		frame_oam_tile 8, $F0,	0, $20
		frame_oam_tile $E8, $F0, 0, $20
		frame_oam_tile 0, $F0,	$200, $40
		frame_oam_tile 0, $F8,	$1200, $40
		frame_oam_tile $F8, $F8, $1200, 0
		frame_oam_tile $F8, $F0, $200,	0
byte_C42B7F:	.BYTE 1
		animation_frame animation_frame_C429B8, $FF
byte_C42B84:	.BYTE $18
		animation_frame animation_frame_C429C3, 2; 0
		animation_frame animation_frame_C429CE, 2; 1
		animation_frame animation_frame_C429D9, 2; 2
		animation_frame animation_frame_C429E4, 2; 3
		animation_frame animation_frame_C429EF, 2; 4
		animation_frame animation_frame_C429FA, 2; 5
		animation_frame animation_frame_C42A05, 2; 6
		animation_frame animation_frame_C42A10, 2; 7
		animation_frame animation_frame_C42A1B, 2; 8
		animation_frame animation_frame_C42A26, 2; 9
		animation_frame animation_frame_C42A31, 2; $A
		animation_frame animation_frame_C42A3C, 2; $B
		animation_frame animation_frame_C42A47, 2; $C
		animation_frame animation_frame_C42A52, 2; $D
		animation_frame animation_frame_C42A5D, 2; $E
		animation_frame animation_frame_C42A68, 4; $F
		animation_frame animation_frame_C42A87, 2; $10
		animation_frame animation_frame_C42AA6, 2; $11
		animation_frame animation_frame_C42AC5, 2; $12
		animation_frame animation_frame_C42AE4, 2; $13
		animation_frame animation_frame_C42B03, 2; $14
		animation_frame animation_frame_C42B22, 2; $15
		animation_frame animation_frame_C42B41, 2; $16
		animation_frame animation_frame_C42B60, 2; $17
byte_C42BE5:	.BYTE $18
		animation_frame animation_frame_C42B60, 2; 0
		animation_frame animation_frame_C42B41, 2; 1
		animation_frame animation_frame_C42B22, 2; 2
		animation_frame animation_frame_C42B03, 2; 3
		animation_frame animation_frame_C42AE4, 2; 4
		animation_frame animation_frame_C42AC5, 2; 5
		animation_frame animation_frame_C42AA6, 2; 6
		animation_frame animation_frame_C42A87, 2; 7
		animation_frame animation_frame_C42A68, 4; 8
		animation_frame animation_frame_C42A5D, 2; 9
		animation_frame animation_frame_C42A52, 2; $A
		animation_frame animation_frame_C42A47, 2; $B
		animation_frame animation_frame_C42A3C, 2; $C
		animation_frame animation_frame_C42A31, 2; $D
		animation_frame animation_frame_C42A26, 2; $E
		animation_frame animation_frame_C42A1B, 2; $F
		animation_frame animation_frame_C42A10, 2; $10
		animation_frame animation_frame_C42A05, 2; $11
		animation_frame animation_frame_C429FA, 2; $12
		animation_frame animation_frame_C429EF, 2; $13
		animation_frame animation_frame_C429E4, 2; $14
		animation_frame animation_frame_C429D9, 2; $15
		animation_frame animation_frame_C429CE, 2; $16
		animation_frame animation_frame_C429C3, 2; $17
byte_C42C46:	.BYTE 1
		animation_frame animation_frame_C42B60, $FF
.A8
.I16

sub_C42C4B:
		JSL	f:sub_C4774A
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		AND	#$F
		CMP	#8
		BNE	loc_C42C72
		LDA	#$8003
		STA	z:$30,X
		LDA	#$300
		STA	z:$38,X
		LDA	#3
		STA	a:.LOWORD($130),X
		LDA	#0
		STA	a:.LOWORD($138),X

loc_C42C72:
		LDA	#$FF90
		STA	z:$14,X
		LDA	#$98
		STA	z:$25,X
		CPX	#$DC0
		BNE	loc_C42C8B
		LDA	#$FF80
		STA	z:$14,X
		LDA	#$58
		STA	z:$25,X

loc_C42C8B:
		LDA	#$88
		STA	z:$11,X
		LDA	#$160
		STA	z:$36,X
		LDA	#$430
		STA	z:$E,X
		LDA	#$808
		STA	z:$1E,X
		LDA	#.LOWORD(down_walking_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C42CDF)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C42CDF)
		STA	z:2,X
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		CMP	#$58
		BNE	loc_C42CDF
		LDA	#$28
		STA	z:$25,X
		CPX	#$DC0
		BNE	loc_C42CD1
		LDA	#$18
		STA	z:$25,X

loc_C42CD1:
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C42D27)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C42D27)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C42CDF:
		REP	#$20
.A16
		INC	z:$14,X
		LDA	z:$14,X
		BMI	loc_C42D07
		CMP	z:$25,X
		BNE	loc_C42D07
		LDA	#.LOWORD(down_walking_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C42D0C)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C42D0C)
		STA	z:2,X

loc_C42D07:
		JSL	f:advance_animation
		RTL
; End of function sub_C42C4B

.A8
.I16

sub_C42D0C:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#8
		BNE	loc_C42D22
		REP	#$20
.A16
		LDA	#.LOWORD(handle_player_movement_0)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(handle_player_movement_0)
		STA	z:2,X

loc_C42D22:
		JSL	f:advance_animation_2
		RTL
; End of function sub_C42D0C

.A8
.I16

sub_C42D27:
		REP	#$20
.A16
		INC	z:$14,X
		LDA	z:$14,X
		BMI	loc_C42D07
		CMP	z:$25,X
		BNE	loc_C42D07
		LDA	#$80
		STA	z:$20,X
		LDA	#.LOWORD(down_walking_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C42D56)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C42D56)
		STA	z:2,X
		BRA	loc_C42D07
; End of function sub_C42D27

.A8
.I16

sub_C42D56:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	loc_C42D22
		LDA	#$98
		STA	z:$25,X
		CPX	#$DC0
		BNE	loc_C42D6B
		LDA	#$58
		STA	z:$25,X

loc_C42D6B:
		REP	#$20
		LDA	#.LOWORD(loc_C42CDF)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C42CDF)
		STA	z:2,X
		BRA	loc_C42D22
; End of function sub_C42D56

.A8
.I16

sub_C42D7A:
		SEP	#$20
		LDA	#$FF
		STA	a:.LOWORD(4),Y
		LDA	#1
		STA	a:.LOWORD(7),Y
		LDA	#$20
		STA	a:.LOWORD($E),Y
		LDA	#0
		STA	a:.LOWORD($F),Y
		REP	#$20
.A16
		LDA	#.LOWORD(handle_player_movement_0)
		STA	a:.LOWORD(0),Y
		SEP	#$20
.A8
		LDA	#.BANKBYTE(handle_player_movement_0)
		STA	a:.LOWORD(2),Y
		RTL
; End of function sub_C42D7A

.A8
.I16

handle_player_movement_0:

; FUNCTION CHUNK AT 3415 SIZE 000000C2 BYTES

		SEP	#32
		STZ	a:.LOWORD($12F),X
		REP	#$20
.A16
		LDA	#4
		STA	z:$40
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$208
		BEQ	loc_C42DC4
		LDA	a:.LOWORD($13E),X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:word_C30924,X
		STA	z:$40
		PLX

loc_C42DC4:
		JSL	f:start_animation_by_direction
		SEP	#$20
.A8
		STZ	z:$1A,X
		STZ	z:$1C,X
		STZ	z:$1D,X
		STZ	z:$2F,X
		STZ	z:$3F,X
		STZ	z:$27,X
		LDA	#0
		STA	z:$25,X
		LDA	#0
		STA	z:$26,X
		JSL	f:sub_C448DD
		JSL	f:sub_C447F2
		JSL	f:sub_C448F5
		REP	#$20
.A16
		STZ	a:.LOWORD($13A),X
		STZ	a:.LOWORD($13C),X
		LDA	#$10
		STA	z:$D9
		SEP	#$20
.A8
		LDA	z:$1F,X
		STA	z:$1E,X
		REP	#$20
.A16
		LDA	#.LOWORD(_handle_player_movement_0)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_handle_player_movement_0)
		STA	z:2,X

_handle_player_movement_0:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C42E17
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C42E17:
		BIT	#$41
		BEQ	loc_C42E1F
		JML	f:loc_C42EC8
; ---------------------------------------------------------------------------

loc_C42E1F:
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#8
		BEQ	loc_C42E2A
		JML	f:loc_C42EF9
; ---------------------------------------------------------------------------

loc_C42E2A:
		JSL	f:clear_playerquare_in_collision_map
		JSL	f:sub_C43BE9
		JSL	f:sub_C431A0
		SEP	#$20
		LDA	a:.LOWORD($13B),X
		BIT	#$40
		BEQ	loc_C42E43
		JSL	f:sub_C43074

loc_C42E43:
		JSL	f:sub_C43D4D
		BCC	loc_C42E4C
		JMP	a:.LOWORD(loc_C42ED2)
; ---------------------------------------------------------------------------

loc_C42E4C:
		SEP	#$20
		LDA	z:$4E
		CMP	#1
		BNE	loc_C42E58
		JML	f:sub_C431CF
; ---------------------------------------------------------------------------

loc_C42E58:
		CMP	#2
		BNE	loc_C42E60
		JML	f:sub_C43291
; ---------------------------------------------------------------------------

loc_C42E60:
		CMP	#4
		BNE	loc_C42E68
		JML	f:sub_C43353
; ---------------------------------------------------------------------------

loc_C42E68:
		JMP	a:.LOWORD(loc_C43415)
; ---------------------------------------------------------------------------
.A16

loc_C42E6B:
		SEP	#$20
.A8
		LDA	z:$4E
		CMP	z:$20,X
		BEQ	loc_C42E8E
		STA	z:$20,X
		REP	#$20
.A16
		AND	#$F
		ASL
		PHX
		TAX
		LDA	f:player_animation_list,X
		STA	z:$50
		PLX
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
.A16

loc_C42E8E:
		JSL	f:mark_playerquare_in_collision_map
		JSL	f:sub_C60C35
		SEP	#$20
.A8
		LDA	z:$1F,X
		STA	z:$1E,X
		JSL	f:poison_related
		JSL	f:infect_poison
		SEP	#$20
		LDA	z:$2F,X
		BEQ	loc_C42EB5
		BIT	#$80
		BEQ	loc_C42EB2
		JML	f:loc_C42F13
; ---------------------------------------------------------------------------

loc_C42EB2:
		JMP	a:.LOWORD(death_related)
; ---------------------------------------------------------------------------

loc_C42EB5:
		SEP	#$20
		INC	a:.LOWORD($13F),X
		LDA	a:.LOWORD($13F),X
		BIT	#$F
		BNE	loc_C42EC8
		LDY	#$C
		JSL	f:play_sound

loc_C42EC8:
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------
		JSL	f:advance_animation_2
		RTL
; ---------------------------------------------------------------------------

loc_C42ED2:
		JSL	f:mark_playerquare_in_collision_map
		JSL	f:sub_C60C35
		SEP	#$20
		LDA	z:$1F,X
		STA	z:$1E,X
		JSL	f:poison_related
		JSL	f:infect_poison
		SEP	#$20
		LDA	z:$2F,X
		BEQ	loc_C42EF9
		BIT	#$80
		BEQ	loc_C42EF6
		JML	f:loc_C42F13
; ---------------------------------------------------------------------------

loc_C42EF6:
		JMP	a:.LOWORD(death_related)
; ---------------------------------------------------------------------------

loc_C42EF9:
		SEP	#$20
		STZ	z:$C,X
		LDA	z:$D,X
		PHA
		JSL	f:advance_animation
		SEP	#$20
		PLA
		STA	z:$D,X
		RTL
; ---------------------------------------------------------------------------
		.BYTE $80, $60,	$40, $20, $10, 0, 1, 2
		.BYTE 5
; ---------------------------------------------------------------------------

loc_C42F13:
		SEP	#$20
		LDA	z:$1F,X
		STA	z:$1E,X
		REP	#$20
.A16
		LDA	#.LOWORD(hit_by_bomb_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C42F37)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C42F37)
		STA	z:2,X

loc_C42F37:
		JSL	f:advance_animation
		BCC	locret_C42F56
		SEP	#$20
		STZ	z:$2F,X
		LDA	#4
		STA	z:$40
		JSL	f:change_direction_and_start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(_handle_player_movement_0)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_handle_player_movement_0)
		STA	z:2,X

locret_C42F56:
		RTL
; End of function handle_player_movement_0

.A8
.I16

wrap_related:
		SEP	#$20
		INC	a:.LOWORD($12F),X
		JSL	f:clear_playerquare_in_collision_map
		LDY	#9
		JSL	f:play_sound
		SEP	#$20
		LDA	z:$11,X

loc_C42F6B:
		AND	#$F0
		ORA	#8
		STA	z:$11,X
		LDA	z:$14,X
		AND	#$F0
		ORA	#8
		STA	z:$14,X
		REP	#$20
.A16
		LDA	#.LOWORD(enter_wrap_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C42F97)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C42F97)
		STA	z:2,X

loc_C42F97:
		JSL	f:advance_animation
		BCC	locret_C42FAA
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C42FAB)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C42FAB)
		STA	z:2,X

locret_C42FAA:
		RTL
; End of function wrap_related

.A8
.I16

sub_C42FAB:
		SEP	#$20
		LDA	#$40
		STA	z:$10,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C42FBE)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C42FBE)
		STA	z:2,X

loc_C42FBE:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C42FCB
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C42FCB:
		BIT	#$41
		BEQ	loc_C42FD3
		JML	f:locret_C42FE6
; ---------------------------------------------------------------------------

loc_C42FD3:
		SEP	#$20
		DEC	z:$10,X
		BNE	locret_C42FE6
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C4302A)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C4302A)
		STA	z:2,X

locret_C42FE6:
		RTL
; End of function sub_C42FAB

.A8
.I16

sub_C42FE7:
		REP	#$20
.A16
		LDA	#.LOWORD(unknown_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C43005)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C43005)
		STA	z:2,X

loc_C43005:
		JSL	f:advance_animation
		BCC	locret_C43029
		REP	#$20
.A16
		LDA	#.LOWORD(down_walking_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(_handle_player_movement_0)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_handle_player_movement_0)
		STA	z:2,X

locret_C43029:
		RTL
; End of function sub_C42FE7

; ---------------------------------------------------------------------------

loc_C4302A:				; Dead code
		PHX
		LDX	#5
		JSL	f:random
		REP	#$20
.A16
		AND	#$FF
		ASL
		ASL
		TAX
		LDA	f:wrap_positions,X
		STA	z:$40
		LDA	f:wrap_positions+2,X
		STA	z:$42
		PLX
		SEP	#$20
.A8
		LDA	z:$40
		CMP	z:$11,X
		BNE	loc_C43055
		LDA	z:$42
		CMP	z:$14,X
		BEQ	locret_C43073

loc_C43055:
		SEP	#$20
		LDA	z:$40
		STA	z:$11,X
		LDA	z:$42
		STA	z:$14,X
		STZ	a:.LOWORD($12F),X
		LDA	#4
		STA	z:$20,X
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C42FE7)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C42FE7)
		STA	z:2,X

locret_C43073:
		RTL
.A8
.I16

sub_C43074:
		SEP	#$20
		LDA	a:.LOWORD(frame_count) ; orig=0x0300
		AND	#3
		BEQ	loc_C43081
		JML	f:locret_C430B5
; ---------------------------------------------------------------------------

loc_C43081:
		SEP	#$20
		LDA	z:$30,X
		INC
		CMP	z:$24,X
		BEQ	locret_C430B5
		JSL	f:get_object_square_index
		REP	#$20
.A16
		TAY
		LDA	a:.LOWORD(collision_map),Y
		AND	#$E0
		BNE	locret_C430B5
		STY	z:$56
		JSL	f:drop_bomb
		BCS	locret_C430B5
		SEP	#$20
.A8
		INC	z:$25,X
		LDA	z:$33,X
		BEQ	locret_C430B5
		INC	z:$1A,X
		LDA	z:$1A,X
		CMP	#1
		BNE	locret_C430B5
		JSL	f:sub_C44911

locret_C430B5:
		RTL
; End of function sub_C43074

.A8
.I16

death_related:
		SEP	#$20
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	#0
		STA	z:$12,X
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#3
		BEQ	loc_C430E4
		DEC	a:.LOWORD($106),X
		BMI	loc_C430D1
		STZ	z:$2F,X
		JMP	a:.LOWORD(loc_C43150)
; ---------------------------------------------------------------------------

loc_C430D1:
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		CMP	#$58
		BNE	loc_C430DE
		JML	f:loc_C430EB
; ---------------------------------------------------------------------------

loc_C430DE:
		JSL	f:sub_C708CC
		BRA	loc_C430EB
; ---------------------------------------------------------------------------

loc_C430E4:
		LDY	#$1F
		JSL	f:play_sound

loc_C430EB:
		JSL	f:clear_playerquare_in_collision_map
		JSL	f:sub_C44945
		REP	#$20
.A16
		REP	#$20
		LDA	#.LOWORD(death_animation)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(death_animation)
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C4311B)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C4311B)
		STA	z:2,X
		SEP	#$20
		DEC	a:.LOWORD(level_manager_object+level_manager_object::number_of_ai_players) ; orig=0x0D37
		DEC	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25

loc_C4311B:
		JSL	f:advance_animation
		BCC	locret_C4314D
		REP	#$20
.A16
		JSL	f:get_object_square_index
		TAY
		LDA	a:.LOWORD(collision_map),Y
		AND	#$1FF
		BNE	loc_C4313E
		LDA	z:$19,X
		AND	#$1F
		BEQ	loc_C4313E
		STA	a:.LOWORD(collision_map),Y
		JSL	f:create_bonus_object

loc_C4313E:
		SEP	#$20
.A8
		STZ	z:4,X
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#3
		BNE	locret_C4314D
		JSL	f:loc_C41A08

locret_C4314D:
		RTL
; ---------------------------------------------------------------------------
byte_C4314E:	.BYTE 8, $E
; ---------------------------------------------------------------------------

loc_C43150:
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C43163)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C43163)
		STA	z:2,X
		SEP	#$20
		LDA	#$40
		STA	z:$10,X

loc_C43163:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C43170
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C43170:
		BIT	#$41
		BEQ	loc_C43178
		JML	f:loc_C4319B
; ---------------------------------------------------------------------------

loc_C43178:
		REP	#$20
.A16
		LDA	z:$10,X
		AND	#1
		PHX
		TAX
		SEP	#$20
.A8
		LDA	f:byte_C4314E,X
		PLX
		STA	z:$1E,X
		DEC	z:$10,X
		BNE	loc_C4319B
		REP	#$20
.A16
		LDA	#.LOWORD(_handle_player_movement_0)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_handle_player_movement_0)
		STA	z:2,X

loc_C4319B:
		JSL	f:advance_animation
		RTL
; End of function death_related

.A8
.I16

sub_C431A0:
		REP	#$20
.A16
		LDA	a:.LOWORD($13A),X
		BIT	#$1000
		BNE	loc_C431C3
		BIT	#$2000
		BNE	loc_C431C9
		LDA	z:$32,X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:word_C308CA,X
		STA	z:$40
		PLX
		LDA	z:$40
		STA	z:object::handler+$3E,X
		RTL
; ---------------------------------------------------------------------------

loc_C431C3:
		LDA	#$60
		STA	z:$3E,X
		RTL
; ---------------------------------------------------------------------------

loc_C431C9:
		LDA	#$400
		STA	z:$3E,X
		RTL
; End of function sub_C431A0

.A8
.I16

sub_C431CF:
		JSL	f:sub_C4225E
		BCS	loc_C431D9
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C431D9:
		SEP	#$20
		LDA	z:$14,X
		AND	#$F
		CMP	#8
		BCS	loc_C4323A
		REP	#$20
.A16
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$FFF7
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C4320B
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C4320B:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$10
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$FFF0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C43233
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C43233:
		JSL	f:sub_C423BD
		JMP	a:.LOWORD(loc_C42E8E)
; ---------------------------------------------------------------------------

loc_C4323A:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#8
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C43262
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C43262:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$10
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$10
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C4328A
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C4328A:
		JSL	f:sub_C423BD
		JMP	a:.LOWORD(loc_C42E8E)
; End of function sub_C431CF

.A8
.I16

sub_C43291:
		JSL	f:sub_C4220E
		BCS	loc_C4329B
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C4329B:
		SEP	#$20
		LDA	z:$14,X
		AND	#$F
		CMP	#8
		BCS	loc_C432FC
		REP	#$20
.A16
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$FFF7
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C432CD
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C432CD:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$FFF0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$FFF0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C432F5
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C432F5:
		JSL	f:sub_C423BD
		JMP	a:.LOWORD(loc_C42E8E)
; ---------------------------------------------------------------------------

loc_C432FC:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#8
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C43324
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C43324:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$FFF0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$10
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C4334C
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C4334C:
		JSL	f:sub_C423BD
		JMP	a:.LOWORD(loc_C42E8E)
; End of function sub_C43291

.A8
.I16

sub_C43353:
		JSL	f:sub_C421BE
		BCS	loc_C4335D
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C4335D:
		SEP	#$20
		LDA	z:$11,X
		AND	#$F
		CMP	#8
		BCS	loc_C433BE
		REP	#$20
.A16
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$FFF7
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C4338F
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C4338F:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$FFF0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$10
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C433B7
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C433B7:
		JSL	f:sub_C42364
		JMP	a:.LOWORD(loc_C42E8E)
; ---------------------------------------------------------------------------

loc_C433BE:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#8
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C433E6
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C433E6:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$10
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$10
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C4340E
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C4340E:
		JSL	f:sub_C42364
		JMP	a:.LOWORD(loc_C42E8E)
; End of function sub_C43353

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR handle_player_movement_0
.A8

loc_C43415:
		JSL	f:sub_C4216E
		BCS	loc_C4341F
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C4341F:
		SEP	#$20
		LDA	z:$11,X
		AND	#$F
		CMP	#8
		BCS	loc_C43480
		REP	#$20
.A16
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$FFF7
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C43451
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C43451:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$FFF0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$FFF0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C43479
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C43479:
		JSL	f:sub_C42364
		JMP	a:.LOWORD(loc_C42E8E)
; ---------------------------------------------------------------------------

loc_C43480:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#8
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C434A8
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C434A8:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$10
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$FFF0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C434D0
		JML	f:loc_C42E6B
; ---------------------------------------------------------------------------

loc_C434D0:
		JSL	f:sub_C42364
		JMP	a:.LOWORD(loc_C42E8E)
; END OF FUNCTION CHUNK	FOR handle_player_movement_0
.A16
.I16

sub_C434D7:
		SEP	#$20
.A8
		LDA	#.LOBYTE(loc_C434FC)
		STA	z:$DB
		LDA	#.HIBYTE(loc_C434FC)
		STA	z:$DC
		LDA	#.BANKBYTE(loc_C434FC)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C434F5
		JML	f:locret_C436FC
; ---------------------------------------------------------------------------

loc_C434F5:
		LDA	#$500
		STA	a:.LOWORD($20),Y
		RTL
; ---------------------------------------------------------------------------

loc_C434FC:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C43509
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C43509:
		BIT	#$41
		BEQ	loc_C43511
		JML	f:locret_C43552
; ---------------------------------------------------------------------------

loc_C43511:
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#8
		BNE	locret_C43552
		LDA	a:.LOWORD(number_of_visible_bonuses) ; orig=0x0C91
		CMP	#$20
		BCS	locret_C43552
		DEC	z:$20,X
		BNE	locret_C43552
		LDA	#1
		STA	z:$20,X
		JSL	f:sub_C43B6E
		BCS	locret_C43552
		REP	#$20
		LDA	#$280
		STA	z:$20,X
		PHX
		PHY
		LDX	#$10
		JSL	f:random
		ASL
		TAX
		LDA	f:unknown_random_bonus_list,X
		PLY
		PLX
		JSL	f:create_bonus_object
		JSL	f:sub_C539E2
.A8

locret_C43552:
		RTL
; ---------------------------------------------------------------------------
unknown_random_bonus_list:
		.WORD 1			; 0
		.WORD 1			; 1
		.WORD 2			; 2
		.WORD 2			; 3
		.WORD 3			; 4
		.WORD 4			; 5
		.WORD 5			; 6
		.WORD $A		; 7
		.WORD $B		; 8
		.WORD $C		; 9
		.WORD $D		; $A
		.WORD 9			; $B
		.WORD 9			; $C
		.WORD 9			; $D
		.WORD $F		; $E
		.WORD $F		; $F
; ---------------------------------------------------------------------------
.A16

loc_C43573:
		STY	z:$40
		SEP	#$20
.A8
		LDA	#.LOBYTE(loc_C43599)
		STA	z:$DB
		LDA	#.HIBYTE(loc_C43599)
		STA	z:$DC
		LDA	#.BANKBYTE(loc_C43599)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCC	loc_C43591
		JML	f:locret_C436FC
; ---------------------------------------------------------------------------

loc_C43591:
		REP	#$20
.A16
		LDA	z:$40
		STA	a:.LOWORD($30),Y
		RTL
; ---------------------------------------------------------------------------

loc_C43599:
		REP	#$20
		LDA	#$88
		STA	z:$11,X
		LDA	#$30
		STA	z:$14,X
		LDA	#$D30
		STA	z:$E,X
		LDA	#$A
		STA	z:$1E,X
		LDA	#$100
		STA	z:$20,X
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		AND	#$FF
		CMP	#$58
		BNE	loc_C435C4
		LDA	#$380
		STA	z:$20,X

loc_C435C4:
		LDA	#.LOWORD(byte_C42B7F)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C43648)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C43648)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C435E1:
		REP	#$20
.A16
		LDY	z:$30,X
		LDA	a:.LOWORD($30),Y
		BNE	loc_C435EE
		JML	f:loc_C436BC
; ---------------------------------------------------------------------------

loc_C435EE:
		LDA	#.LOWORD(byte_C42BE5)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C4360A)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C4360A)
		STA	z:2,X

loc_C4360A:
		JSL	f:advance_animation
		BCS	loc_C43614
		JML	f:locret_C436C0
; ---------------------------------------------------------------------------

loc_C43614:
		REP	#$20
.A16
		LDA	#$80
		STA	z:$20,X
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		AND	#$FF
		CMP	#$58
		BNE	loc_C4362B
		LDA	#$300
		STA	z:$20,X

loc_C4362B:
		LDA	#.LOWORD(byte_C42B7F)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C43648)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C43648)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C43648:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C43655
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C43655:
		BIT	#$41
		BEQ	loc_C4365D
		JML	f:loc_C436BC
; ---------------------------------------------------------------------------

loc_C4365D:
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$80
		BEQ	loc_C4366B
		JML	f:locret_C436C0
; ---------------------------------------------------------------------------

loc_C4366B:
		DEC	z:$20,X
		BEQ	loc_C43673
		JML	f:loc_C436BC
; ---------------------------------------------------------------------------

loc_C43673:
		LDA	#.LOWORD(byte_C42B84)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C4368F)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C4368F)
		STA	z:2,X

loc_C4368F:
		JSL	f:advance_animation
		BCC	locret_C436C0
		REP	#$20
.A16
		LDY	z:$30,X
		LDA	#0
		STA	a:.LOWORD($30),Y
		LDA	#.LOWORD(byte_C42C46)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C435E1)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C435E1)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------
.A16

loc_C436BC:
		JSL	f:advance_animation

locret_C436C0:
		RTL
; ---------------------------------------------------------------------------

loc_C436C1:
		SEP	#$20
.A8
		LDA	#.LOBYTE(loc_C4375E)
		STA	z:$DB
		LDA	#.HIBYTE(loc_C4375E)
		STA	z:$DC
		LDA	#.BANKBYTE(loc_C4375E)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCS	locret_C436FC
		SEP	#$20
		LDA	#$FF
		STA	a:.LOWORD(level_manager_object+level_manager_object::number_of_human_players) ; orig=0x0D36
		REP	#$20
.A16
		LDA	#$10
		STA	a:.LOWORD($10),Y
		LDA	#0
		STA	a:.LOWORD($30),Y
		LDA	#$400
		STA	a:.LOWORD(bg1_tilemap+$22)	; orig=0x0516
		JSL	f:loc_C43573
		JSL	f:sub_C434D7
.A8

locret_C436FC:
		RTL
; End of function sub_C434D7

.A8
.I16

mecha_bomberman_related:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C4370A
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C4370A:
		BIT	#$41
		BEQ	loc_C43712
		JML	f:locret_C436FC
; ---------------------------------------------------------------------------

loc_C43712:
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		BNE	locret_C436FC
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		CMP	#$58
		BNE	loc_C43724
		JML	f:loc_C4384A
; ---------------------------------------------------------------------------

loc_C43724:
		REP	#$20
.A16
		LDA	#$80
		STA	z:$10,X
		REP	#$20
		LDA	#.LOWORD(loc_C43738)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C43738)
		STA	z:2,X

loc_C43738:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C43745
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C43745:
		BIT	#$41
		BEQ	loc_C4374D
		JML	f:locret_C436FC
; ---------------------------------------------------------------------------

loc_C4374D:
		REP	#$20
.A16
		DEC	z:$10,X
		BNE	locret_C436FC
		SEP	#$20
.A8
		INC	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		INC	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		INC	a:.LOWORD(current_screen) ; orig=0x00A4

loc_C4375E:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C4376B
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C4376B:
		BIT	#$41
		BEQ	loc_C43773
		JML	f:locret_C436FC
; ---------------------------------------------------------------------------

loc_C43773:
		REP	#$20
.A16
		LDA	#$140
		STA	z:$10,X
		LDA	#1
		STA	z:$30,X
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
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
		SEP	#$20
		LDX	#$D40
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	z:$20,X
		STA	z:$40
		JSL	f:sub_C43BDE
		SEP	#$20
		LDX	#$D80
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	z:$20,X
		STA	z:$40
		JSL	f:sub_C43BDE
		PLX
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		CMP	#$58
		BNE	loc_C43807
		REP	#$20
.A16
		LDA	#$F
		STA	z:$10,X
		LDA	#$80
		STA	z:$12,X
		REP	#$20
		LDA	#.LOWORD(loc_C437E7)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C437E7)
		STA	z:2,X

loc_C437E7:
		REP	#$20
.A16
		DEC	z:$12,X
		BNE	locret_C43849
		LDA	#$18
		STA	z:$12,X
		DEC	z:$10,X
		BMI	loc_C437FA
		JML	f:loc_C438BA
; ---------------------------------------------------------------------------

loc_C437FA:
		LDA	#$200
		STA	z:$10,X
		JSL	f:sub_C71DCF
		JSL	f:sub_C71E32

loc_C43807:
		JSL	f:sub_C43B09
		REP	#$20
		LDA	#.LOWORD(loc_C43818)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C43818)
		STA	z:2,X

loc_C43818:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C43825
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C43825:
		BIT	#$41
		BEQ	loc_C4382D
		JML	f:locret_C43849
; ---------------------------------------------------------------------------

loc_C4382D:
		REP	#$20
.A16
		DEC	z:$10,X
		BNE	locret_C43849
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		AND	#$F7
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		REP	#$20
		LDA	#.LOWORD(mecha_bomberman_related)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(mecha_bomberman_related)
		STA	z:2,X

locret_C43849:
		RTL
; ---------------------------------------------------------------------------

loc_C4384A:
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C4385E)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C4385E)
		STA	z:2,X
		REP	#$20
.A16
		LDA	#$180
		STA	z:$10,X

loc_C4385E:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C4386B
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C4386B:
		BIT	#$41
		BEQ	loc_C43873
		JML	f:locret_C43849
; ---------------------------------------------------------------------------

loc_C43873:
		REP	#$20
.A16
		DEC	z:$10,X
		LDA	z:$10,X
		CMP	#$100
		BEQ	loc_C43893
		CMP	#0
		BNE	locret_C43892
		SEP	#$20
.A8
		LDA	#$39
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		JSL	f:delete_object
		JSL	f:fade_out_music

locret_C43892:
		RTL
; ---------------------------------------------------------------------------

loc_C43893:
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
		RTL
; ---------------------------------------------------------------------------

loc_C438BA:
		REP	#$20
		LDA	z:$10,X
		BNE	loc_C438F4
		SEP	#$20
.A8
		PHX
		LDX	#$D40
		LDA	#$68
		STA	z:$11,X
		LDA	#$B8
		STA	z:$14,X
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	#8
		STA	z:$40
		JSL	f:sub_C43BDE
		SEP	#$20
		LDX	#$D80
		LDA	#$A8
		STA	z:$11,X
		LDA	#$B8
		STA	z:$14,X
		LDA	z:$1F,X
		STA	z:$1E,X
		LDA	#8
		STA	z:$40
		JSL	f:sub_C43BDE
		PLX

loc_C438F4:
		REP	#$20
.A16
		LDA	z:$10,X
		AND	#1
		ASL
		ASL
		ASL
		ASL
		PHX
		TAX
		LDY	#3
		SEP	#$20
.A8
		LDA	f:stru_C43984+1,X
		STA	z:$40
		LDA	#1
		JSL	f:palette_related
		LDA	f:stru_C43984+2,X
		STA	z:$40
		LDA	#2
		JSL	f:palette_related
		LDA	f:stru_C43984+3,X
		STA	z:$40
		LDA	#3
		JSL	f:palette_related
		LDA	f:stru_C43984+4,X
		STA	z:$40
		LDA	#4
		JSL	f:palette_related
		LDA	f:stru_C43984+5,X
		STA	z:$40
		LDA	#5
		JSL	f:palette_related
		LDA	f:stru_C43984+6,X
		STA	z:$40
		LDA	#6
		JSL	f:palette_related
		LDA	f:stru_C43984+7,X
		STA	z:$40
		LDA	#7
		JSL	f:palette_related
		LDA	f:stru_C43984+8,X
		STA	z:$40
		LDA	#8
		JSL	f:palette_related
		LDA	f:stru_C43984+8+1,X
		STA	z:$40
		LDA	#9
		JSL	f:palette_related
		LDA	f:stru_C43984+8+5,X
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		PLX
		JSL	f:sub_C439C5
		RTL
; End of function mecha_bomberman_related

; ---------------------------------------------------------------------------
stru_C43984:	.BYTE HUD_PALETTE, ARENA_PALETTE_1, ARENA_PALETTE_2, ARENA_PALETTE_3; a_palettes
		.BYTE BONUS_PALETTE_1, BONUS_PALETTE_2,	ARENA_BOMB_PALETTE; a_palettes
		.BYTE ARENA_FIRE_PALETTE; a_palettes
		.BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
		.BYTE MECHA_BOMBER_GOLD_PALETTE, ARENA_GATE_PALETTE, BLACK_PALETTE; b_palettes
		.BYTE WHITE_PALETTE	; b_palettes
		.BYTE HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
		.BYTE BACKGROUND_BLACK_PALETTE,	BACKGROUND_BLACK_PALETTE; a_palettes
		.BYTE BACKGROUND_BLACK_PALETTE,	BACKGROUND_BLACK_PALETTE; a_palettes
		.BYTE BACKGROUND_BLACK_PALETTE;	a_palettes
		.BYTE BLACK_PALETTE, BLACK_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
		.BYTE MECHA_BOMBER_GOLD_PALETTE, BLACK_PALETTE,	BLACK_PALETTE; b_palettes
		.BYTE WHITE_PALETTE	; b_palettes
		.BYTE HUD_PALETTE, ARENA_PALETTE_1, BACKGROUND_BLACK_PALETTE; a_palettes
		.BYTE CREDITS_SEPIA_PALETTE_3, BONUS_PALETTE_1,	BONUS_PALETTE_2; a_palettes
		.BYTE ARENA_BOMB_PALETTE, ARENA_FIRE_PALETTE; a_palettes
		.BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
		.BYTE MECHA_BOMBER_GOLD_PALETTE, ARENA_GATE_PALETTE, BLACK_PALETTE; b_palettes
		.BYTE WHITE_PALETTE	; b_palettes
		.BYTE HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
		.BYTE BACKGROUND_BLACK_PALETTE,	BACKGROUND_BLACK_PALETTE; a_palettes
		.BYTE BACKGROUND_BLACK_PALETTE,	BACKGROUND_BLACK_PALETTE; a_palettes
		.BYTE ARENA_FIRE_PALETTE; a_palettes
		.BYTE BLACK_PALETTE, BLACK_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
		.BYTE MECHA_BOMBER_GOLD_PALETTE, BLACK_PALETTE,	BLACK_PALETTE; b_palettes
		.BYTE WHITE_PALETTE	; b_palettes
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_C439C5

locret_C439C4:
		RTL
; END OF FUNCTION CHUNK	FOR sub_C439C5
.A8
.I16

sub_C439C5:

; FUNCTION CHUNK AT 39C4 SIZE 00000001 BYTES

		SEP	#$20
		LDA	z:$10,X
		BIT	#1
		BNE	locret_C439C4
		BIT	#2
		BEQ	loc_C439D5
		JML	f:loc_C43A6C
; ---------------------------------------------------------------------------

loc_C439D5:
		LDA	#$A
		STA	a:.LOWORD(bg1_tilemap+2) ;	orig=0x04F6
		STA	a:.LOWORD(bg1_tilemap+4) ;	orig=0x04F8
		STA	a:.LOWORD(bg1_tilemap+6) ;	orig=0x04FA
		STA	a:.LOWORD(bg1_tilemap+8) ;	orig=0x04FC
		STA	a:.LOWORD(bg1_tilemap+$A) ; orig=0x04FE
		STA	a:.LOWORD(bg1_tilemap+$42)	; orig=0x0536
		STA	a:.LOWORD(bg1_tilemap+$44)	; orig=0x0538
		STA	a:.LOWORD(bg1_tilemap+$46)	; orig=0x053A
		STA	a:.LOWORD(bg1_tilemap+$48)	; orig=0x053C
		STA	a:.LOWORD(bg1_tilemap+$4A)	; orig=0x053E
		STA	a:.LOWORD(bg1_tilemap+$16)	; orig=0x050A
		STA	a:.LOWORD(bg1_tilemap+$18)	; orig=0x050C
		STA	a:.LOWORD(bg1_tilemap+$1A)	; orig=0x050E
		STA	a:.LOWORD(bg1_tilemap+$1C)	; orig=0x0510
		STA	a:.LOWORD(bg1_tilemap+$1E)	; orig=0x0512
		STA	a:.LOWORD(bg1_tilemap+$56)	; orig=0x054A
		STA	a:.LOWORD(bg1_tilemap+$58)	; orig=0x054C
		STA	a:.LOWORD(bg1_tilemap+$5A)	; orig=0x054E
		STA	a:.LOWORD(bg1_tilemap+$5C)	; orig=0x0550
		STA	a:.LOWORD(bg1_tilemap+$5E)	; orig=0x0552
		LDA	#$2E
		STA	a:.LOWORD(bg1_tilemap) ; orig=0x04F4
		STA	a:.LOWORD(bg1_tilemap+$40)	; orig=0x0534
		STA	a:.LOWORD(bg1_tilemap+$80)	; orig=0x0574
		STA	a:.LOWORD(bg1_tilemap+$C0)	; orig=0x05B4
		STA	a:.LOWORD(bg1_tilemap+$100) ; orig=0x05F4
		STA	a:.LOWORD(bg1_tilemap+$140) ; orig=0x0634
		STA	a:.LOWORD(bg1_tilemap+$180) ; orig=0x0674
		STA	a:.LOWORD(bg1_tilemap+$1C0) ; orig=0x06B4
		STA	a:.LOWORD(bg1_tilemap+$200) ; orig=0x06F4
		STA	a:.LOWORD(bg1_tilemap+$240) ; orig=0x0734
		STA	a:.LOWORD(bg1_tilemap+$280) ; orig=0x0774
		STA	a:.LOWORD(bg1_tilemap+$2C0) ; orig=0x07B4
		STA	a:.LOWORD(bg1_tilemap+$300) ; orig=0x07F4
		STA	a:.LOWORD(bg1_tilemap+$20)	; orig=0x0514
		STA	a:.LOWORD(bg1_tilemap+$60)	; orig=0x0554
		STA	a:.LOWORD(bg1_tilemap+$A0)	; orig=0x0594
		STA	a:.LOWORD(bg1_tilemap+$E0)	; orig=0x05D4
		STA	a:.LOWORD(bg1_tilemap+$120) ; orig=0x0614
		STA	a:.LOWORD(bg1_tilemap+$160) ; orig=0x0654
		STA	a:.LOWORD(bg1_tilemap+$1A0) ; orig=0x0694
		STA	a:.LOWORD(bg1_tilemap+$1E0) ; orig=0x06D4
		STA	a:.LOWORD(bg1_tilemap+$220) ; orig=0x0714
		STA	a:.LOWORD(bg1_tilemap+$260) ; orig=0x0754
		STA	a:.LOWORD(bg1_tilemap+$2A0) ; orig=0x0794
		STA	a:.LOWORD(bg1_tilemap+$2E0) ; orig=0x07D4
		STA	a:.LOWORD(bg1_tilemap+$320) ; orig=0x0814
		LDA	#$2A
		STA	a:.LOWORD(bg1_tilemap+$82)	; orig=0x0576
		STA	a:.LOWORD(bg1_tilemap+$9E)	; orig=0x0592
		RTL
; ---------------------------------------------------------------------------

loc_C43A6C:
		SEP	#$20
		LDA	#$24
		STA	a:.LOWORD(bg1_tilemap) ; orig=0x04F4
		STA	a:.LOWORD(bg1_tilemap+$80)	; orig=0x0574
		STA	a:.LOWORD(bg1_tilemap+$100) ; orig=0x05F4
		STA	a:.LOWORD(bg1_tilemap+$180) ; orig=0x0674
		STA	a:.LOWORD(bg1_tilemap+$200) ; orig=0x06F4
		STA	a:.LOWORD(bg1_tilemap+$280) ; orig=0x0774
		STA	a:.LOWORD(bg1_tilemap+$300) ; orig=0x07F4
		STA	a:.LOWORD(bg1_tilemap+$20)	; orig=0x0514
		STA	a:.LOWORD(bg1_tilemap+$A0)	; orig=0x0594
		STA	a:.LOWORD(bg1_tilemap+$120) ; orig=0x0614
		STA	a:.LOWORD(bg1_tilemap+$1A0) ; orig=0x0694
		STA	a:.LOWORD(bg1_tilemap+$220) ; orig=0x0714
		STA	a:.LOWORD(bg1_tilemap+$2A0) ; orig=0x0794
		STA	a:.LOWORD(bg1_tilemap+$320) ; orig=0x0814
		LDA	#$26
		STA	a:.LOWORD(bg1_tilemap+$40)	; orig=0x0534
		STA	a:.LOWORD(bg1_tilemap+$C0)	; orig=0x05B4
		STA	a:.LOWORD(bg1_tilemap+$140) ; orig=0x0634
		STA	a:.LOWORD(bg1_tilemap+$1C0) ; orig=0x06B4
		STA	a:.LOWORD(bg1_tilemap+$240) ; orig=0x0734
		STA	a:.LOWORD(bg1_tilemap+$2C0) ; orig=0x07B4
		STA	a:.LOWORD(bg1_tilemap+$60)	; orig=0x0554
		STA	a:.LOWORD(bg1_tilemap+$E0)	; orig=0x05D4
		STA	a:.LOWORD(bg1_tilemap+$160) ; orig=0x0654
		STA	a:.LOWORD(bg1_tilemap+$1E0) ; orig=0x06D4
		STA	a:.LOWORD(bg1_tilemap+$260) ; orig=0x0754
		STA	a:.LOWORD(bg1_tilemap+$2E0) ; orig=0x07D4
		LDA	#$22
		STA	a:.LOWORD(bg1_tilemap+2) ;	orig=0x04F6
		STA	a:.LOWORD(bg1_tilemap+6) ;	orig=0x04FA
		STA	a:.LOWORD(bg1_tilemap+$A) ; orig=0x04FE
		STA	a:.LOWORD(bg1_tilemap+$44)	; orig=0x0538
		STA	a:.LOWORD(bg1_tilemap+$48)	; orig=0x053C
		STA	a:.LOWORD(bg1_tilemap+$16)	; orig=0x050A
		STA	a:.LOWORD(bg1_tilemap+$1A)	; orig=0x050E
		STA	a:.LOWORD(bg1_tilemap+$1E)	; orig=0x0512
		STA	a:.LOWORD(bg1_tilemap+$58)	; orig=0x054C
		STA	a:.LOWORD(bg1_tilemap+$5C)	; orig=0x0550
		LDA	#$20
		STA	a:.LOWORD(bg1_tilemap+4) ;	orig=0x04F8
		STA	a:.LOWORD(bg1_tilemap+8) ;	orig=0x04FC
		STA	a:.LOWORD(bg1_tilemap+$42)	; orig=0x0536
		STA	a:.LOWORD(bg1_tilemap+$46)	; orig=0x053A
		STA	a:.LOWORD(bg1_tilemap+$4A)	; orig=0x053E
		STA	a:.LOWORD(bg1_tilemap+$18)	; orig=0x050C
		STA	a:.LOWORD(bg1_tilemap+$1C)	; orig=0x0510
		STA	a:.LOWORD(bg1_tilemap+$56)	; orig=0x054A
		STA	a:.LOWORD(bg1_tilemap+$5A)	; orig=0x054E
		STA	a:.LOWORD(bg1_tilemap+$5E)	; orig=0x0552
		LDA	#$28
		STA	a:.LOWORD(bg1_tilemap+$82)	; orig=0x0576
		STA	a:.LOWORD(bg1_tilemap+$9E)	; orig=0x0592
		RTL
; End of function sub_C439C5

.A16
.I16

sub_C43B09:
		SEP	#$20
.A8
		PHX
		LDX	#.LOWORD(player2_object)
		LDA	#.BANKBYTE(byte_C43D2C)
		STA	z:$55
		LDA	#.BANKBYTE(hits_per_mecha_bomber)
		STA	z:$52
		LDA	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		STA	z:$40
		LDA	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		BNE	loc_C43B23
		INC	z:$40

loc_C43B23:
		REP	#$20
.A16
		TXA
		CLC
		ADC	#$40
		TAX
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		AND	#$F
		DEC
		ADC	#.LOWORD(hits_per_mecha_bomber)
		STA	z:$50
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		AND	#$F
		DEC
		ADC	#.LOWORD(byte_C43D2C)
		STA	z:$53
		REP	#$20
		LDA	#.LOWORD(sub_C42C4B)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C42C4B)
		STA	z:2,X
		LDA	[$50]
		STA	a:.LOWORD($106),X
		LDA	[$53]
		STA	z:$3D,X
		LDA	#0
		STA	z:$19,X
		LDA	#$FF
		STA	z:4,X
		LDA	#1
		STA	z:7,X
		INC	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		DEC	z:$40
		BNE	loc_C43B23
		PLX
		RTL
; End of function sub_C43B09

.A16
.I16

sub_C43B6E:
		PHX
		JSL	f:generate_random_position
		PLX
		REP	#$20
		LDA	z:$40
		AND	#$FF
		ORA	#8
		STA	z:$11,X
		LDA	z:$42
		AND	#$FF
		ORA	#8
		STA	z:$14,X
		LDA	#$FFFF
		STA	z:$42
		JSL	f:sub_C6153E
		BNE	loc_C43BA1
		REP	#$20
		PHY
		JSL	f:sub_C43BA3
		PLY
		BCS	loc_C43BA1
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C43BA1:
		SEC
		RTL
; End of function sub_C43B6E

.A16
.I16

sub_C43BA3:
		REP	#$20
		LDY	#$D40

loc_C43BA8:
		SEP	#$20
.A8
		LDA	a:.LOWORD(4),Y
		BEQ	loc_C43BCF
		LDA	a:.LOWORD($11),Y
		SEC
		SBC	z:$11,X
		BCS	loc_C43BBA
		EOR	#$FF
		INC

loc_C43BBA:
		CMP	#8
		BCS	loc_C43BCF
		LDA	a:.LOWORD($14),Y
		SEC
		SBC	z:$14,X
		BCS	loc_C43BC9
		EOR	#$FF
		INC

loc_C43BC9:
		CMP	#8
		BCS	loc_C43BCF
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C43BCF:
		REP	#$20
.A16
		TYA
		CLC
		ADC	#$40
		TAY
		CMP	#$E40
		BNE	loc_C43BA8
		CLC
		RTL
; End of function sub_C43BA3

.A8
.I16

sub_C43BDE:
		SEP	#$20
		LDA	z:$2F,X
		BNE	locret_C43BE8
		JSL	f:start_animation_by_direction

locret_C43BE8:
		RTL
; End of function sub_C43BDE

.A8
.I16

sub_C43BE9:
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$1000
		BEQ	locret_C43C2B
		JSL	f:get_object_square_index
		TAY
		REP	#$20
		LDA	#$40
		STA	z:$3E,X
		LDA	a:.LOWORD(bg1_tilemap),Y
		STA	z:$DB
		AND	#$3FF
		CMP	#$48
		BNE	loc_C43C10
		JML	f:loc_C43C2C
; ---------------------------------------------------------------------------

loc_C43C10:
		CMP	#$4A
		BNE	loc_C43C19
		JML	f:loc_C43CEC
; ---------------------------------------------------------------------------

loc_C43C19:
		CMP	#$4C
		BNE	loc_C43C22
		JML	f:loc_C43C6C
; ---------------------------------------------------------------------------

loc_C43C22:
		CMP	#$4E
		BNE	locret_C43C2B
		JML	f:loc_C43CAC
; ---------------------------------------------------------------------------

locret_C43C2B:
		RTL
; ---------------------------------------------------------------------------

loc_C43C2C:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$FFF7
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C43C5C
		LDA	z:$14,X
		AND	#$F
		CMP	#8
		BEQ	locret_C43C6B
		BCC	locret_C43C6B

loc_C43C5C:
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		CMP	z:$DB
		BNE	locret_C43C6B
		JSL	f:sub_C422F1
		JSL	f:sub_C4239D

locret_C43C6B:
		RTL
; ---------------------------------------------------------------------------

loc_C43C6C:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#0
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#8
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C43C9C
		LDA	z:$14,X
		AND	#$F
		CMP	#8
		BEQ	locret_C43CAB
		BCS	locret_C43CAB

loc_C43C9C:
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		CMP	z:$DB
		BNE	locret_C43CAB
		JSL	f:sub_C422F1
		JSL	f:sub_C423CE

locret_C43CAB:
		RTL
; ---------------------------------------------------------------------------

loc_C43CAC:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#$FFF7
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C43CDC
		LDA	z:$11,X
		AND	#$F
		CMP	#8
		BEQ	locret_C43CEB
		BCC	locret_C43CEB

loc_C43CDC:
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		CMP	z:$DB
		BNE	locret_C43CEB
		JSL	f:sub_C4230B
		JSL	f:sub_C42375

locret_C43CEB:
		RTL
; ---------------------------------------------------------------------------

loc_C43CEC:
		REP	#$20
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#8
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#0
		STA	z:$14,X
		JSL	f:sub_C60B6D
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		BCC	loc_C43D1C
		LDA	z:$11,X
		AND	#$F
		CMP	#8
		BEQ	locret_C43D2B
		BCS	locret_C43D2B

loc_C43D1C:
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		CMP	z:$DB
		BNE	locret_C43D2B
		JSL	f:sub_C4230B
		JSL	f:sub_C42325

locret_C43D2B:
		RTL
; End of function sub_C43BE9

; ---------------------------------------------------------------------------
byte_C43D2C:	.BYTE 0, 1, 1, 2, 2, 3,	3, 4
hits_per_mecha_bomber:.BYTE 0, 0, 0, 0,	1, 1, 1, 4
palette_per_mecha_bomber:.BYTE MECHA_BOMBER_WHITE_PALETTE, MECHA_BOMBER_BLACK_PALETTE, MECHA_BOMBER_RED_PALETTE, MECHA_BOMBER_BLUE_PALETTE, MECHA_BOMBER_GREEN_PALETTE,	MECHA_BOMBER_MAGENTA_PALETTE, MECHA_BOMBER_PURPLE_PALETTE, MECHA_BOMBER_GOLD_PALETTE
		.BYTE 1, 4, 1, $C, 2
		.BYTE $D, 2
; ---------------------------------------------------------------------------
		REP	#$20
.A8
.I16

sub_C43D4D:
		JSL	f:get_object_square_index
		STA	z:$50
		TAY
		SEP	#$20
		LDA	z:$26,X
		CMP	#9
		BCC	loc_C43D60
		JML	f:loc_C43EC5
; ---------------------------------------------------------------------------

loc_C43D60:
		CMP	#7
		BCS	loc_C43DA2
		STZ	z:$1B,X
		LDA	a:.LOWORD($917),Y
		BIT	#8
		BEQ	loc_C43D7C
		DEC	a:.LOWORD($138),X
		BNE	loc_C43D8E
		LDA	#2
		STA	z:$26,X
		JSL	f:sub_C448F5
		BRA	loc_C43DA2
; ---------------------------------------------------------------------------

loc_C43D7C:
		LDA	z:7,X
		BIT	#$80
		BNE	loc_C43D8E
		LDA	z:$1C,X
		BEQ	loc_C43D8E
		DEC	z:$1C,X
		BNE	loc_C43D8E
		LDA	#$80
		STA	z:$27,X

loc_C43D8E:
		SEP	#$20
		LDA	z:$26,X
		CMP	#4
		BNE	loc_C43D9A
		JML	f:loc_C43E75
; ---------------------------------------------------------------------------

loc_C43D9A:
		CMP	#6
		BNE	loc_C43DA2
		JML	f:loc_C43E75
; ---------------------------------------------------------------------------
.A16

loc_C43DA2:
		JSL	f:random2
		SEP	#$20
.A8
		AND	#$80
		STA	z:$D5
		JSL	f:sub_C447CF
		SEP	#$20
		LDA	z:$20,X
		STA	z:$4A
		LDA	#4
		STA	z:$49
		LDA	#$FF
		STA	z:$48
		LDA	#0
		STA	z:$4E
		LDA	#0
		STA	z:$4F
		LDA	#0
		STA	z:$4D
		LDA	#0
		STA	z:$D7
		LDA	#0
		STA	z:$D8
		LDA	#0
		STA	z:$17,X
		JSL	f:get_object_square_index
		STA	z:$50
		TAY
		SEP	#$20
		LDA	z:$26,X
		BNE	loc_C43DEF
		STZ	z:$1B,X
		CPY	z:$53
		BNE	loc_C43DEF
		LDA	#6
		STA	z:$26,X
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C43DEF:
		SEP	#$20
		LDA	z:$4A
		ASL
		STA	z:$4C
		LDA	#.BANKBYTE(off_C441D0)
		STA	z:$61
		REP	#$20
.A16
		LDA	z:$26,X
		AND	#$FF
		ASL
		CLC
		ADC	#.LOWORD(off_C441D0)
		STA	z:$5F
		LDA	[$5F]
		STA	z:$5F
		JSL	f:call_function_at_5f
		SEP	#$20
.A8
		LDA	z:$D5
		BNE	loc_C43E24
		LSR	z:$4A
		BCC	loc_C43E1E
		LDA	#8
		STA	z:$4A

loc_C43E1E:
		DEC	z:$49
		BNE	loc_C43DEF
		BRA	loc_C43E34
; ---------------------------------------------------------------------------

loc_C43E24:
		ASL	z:$4A
		LDA	z:$4A
		CMP	#$10
		BNE	loc_C43E30
		LDA	#1
		STA	z:$4A

loc_C43E30:
		DEC	z:$49
		BNE	loc_C43DEF

loc_C43E34:
		LDA	z:$17,X
		BNE	loc_C43E3A
		STZ	z:$16,X

loc_C43E3A:
		LDA	#.BANKBYTE(off_C441E2)
		STA	z:$61
		REP	#$20
.A16
		LDA	z:$26,X
		AND	#$FF
		ASL
		CLC
		ADC	#.LOWORD(off_C441E2)
		STA	z:$5F
		LDA	[$5F]
		STA	z:$5F
		JSL	f:call_function_at_5f
		BCS	locret_C43E72
		REP	#$20
		LDA	z:$4E
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	z:$50
		CLC
		ADC	f:byte_C44246,X
		TAY
		PLX
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$100
		BEQ	loc_C43E73
		SEC

locret_C43E72:
		RTL
; ---------------------------------------------------------------------------

loc_C43E73:
		CLC
		RTL
; ---------------------------------------------------------------------------
.A8

loc_C43E75:
		SEP	#$20
		LDA	#.LOBYTE(loc_C43E99)
		STA	z:$DB
		LDA	#.HIBYTE(loc_C43E99)
		STA	z:$DC
		LDA	#.BANKBYTE(loc_C43E99)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C43E93
		JML	f:loc_C43E97
; ---------------------------------------------------------------------------

loc_C43E93:
		TXA
		STA	a:.LOWORD($30),Y

loc_C43E97:
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C43E99:
		REP	#$20
		PHX
		LDA	z:$30,X
		TAX
		JSL	f:get_object_square_index
		STA	z:$50
		JSL	f:sub_C4453B
		BCC	loc_C43EAF
		JML	f:loc_C43EB9
; ---------------------------------------------------------------------------

loc_C43EAF:
		JSL	f:loc_C43DA2
		PLX
		JSL	f:delete_object
		RTL
; ---------------------------------------------------------------------------

loc_C43EB9:
		SEP	#$20
.A8
		LDA	#3
		STA	z:$26,X
		PLX
		JSL	f:delete_object
		RTL
; ---------------------------------------------------------------------------

loc_C43EC5:
		SEP	#$20
		LDA	z:$26,X
		CMP	#$B
		BEQ	loc_C43F0C
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$20
		BNE	loc_C43F06
		LDA	z:$26,X
		CMP	#$A
		BEQ	loc_C43EF2
		LDA	z:$20,X
		BIT	#3
		BNE	loc_C43EE4
		EOR	#$C
		BRA	loc_C43EE6
; ---------------------------------------------------------------------------

loc_C43EE4:
		EOR	#3

loc_C43EE6:
		STA	z:$20,X
		LDA	#2
		STA	z:$26,X
		JSL	f:sub_C41D0B
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C43EF2:
		LDA	z:$20,X
		BIT	#3
		BNE	loc_C43EFC
		EOR	#$C
		BRA	loc_C43EFE
; ---------------------------------------------------------------------------

loc_C43EFC:
		EOR	#3

loc_C43EFE:
		STA	z:$4E
		LDA	#$B
		STA	z:$26,X
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C43F06:
		LDA	z:$20,X
		STA	z:$4E
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C43F0C:
		REP	#$20
.A16
		LDA	z:$20,X
		AND	#$FF
		ASL
		PHX
		TAX
		TYA
		CLC
		ADC	f:byte_C44246,X
		TAY
		PLX
		SEP	#$20
.A8
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$20
		BEQ	loc_C43F2B
		CMP	#$3F
		BNE	loc_C43F06

loc_C43F2B:
		LDA	#2
		STA	z:$26,X
		SEC
		RTL
; End of function sub_C43D4D

.A8
.I16

sub_C43F31:
		SEP	#$20
		LDA	z:$3D,X
		CMP	#1
		BCC	loc_C43F43
		LDA	z:$D8
		BEQ	loc_C43F43
		LDA	#5
		STA	z:$26,X
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C43F43:
		LDA	z:$4E
		BEQ	loc_C43F6E
		BIT	z:$4F
		BNE	loc_C43F6C
		CPX	#$E40
		BCS	loc_C43F5B
		LDA	a:.LOWORD($13C),X
		BIT	#1
		BEQ	loc_C43F5B
		LDA	#0
		BRA	loc_C43F63
; ---------------------------------------------------------------------------

loc_C43F5B:
		LDA	z:$31,X
		BIT	#$80
		BEQ	loc_C43F63
		LDA	#9

loc_C43F63:
		INC
		CMP	z:$48
		BCC	loc_C43F6C
		LDA	#6
		STA	z:$26,X

loc_C43F6C:
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C43F6E:
		LDA	#1
		STA	z:$26,X
		SEC
		RTL
; End of function sub_C43F31

.A8
.I16

sub_C43F74:
		SEP	#$20
		LDA	z:$4E
		BEQ	loc_C43F84
		LDA	z:$48
		BNE	loc_C43F8A
		LDA	#4
		STA	z:$26,X
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C43F84:
		LDA	#0
		STA	z:$26,X
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C43F8A:
		CLC
		RTL
; End of function sub_C43F74

.A8
.I16

sub_C43F8C:
		SEP	#$20
		LDA	#.BANKBYTE(up_walking_animation)
		STA	z:$52
		LDA	z:$4E
		BEQ	loc_C43FC3
		BIT	#3
		BNE	loc_C43F9E
		EOR	#$C
		BRA	loc_C43FA0
; ---------------------------------------------------------------------------

loc_C43F9E:
		EOR	#3

loc_C43FA0:
		STA	z:$20,X
		REP	#$20
.A16
		AND	#$F
		ASL
		PHX
		TAX
		LDA	f:player_animation_list,X
		STA	z:$50
		PLX
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#9
		STA	z:$26,X
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C43FC3:
		LDA	#2
		STA	z:$26,X
		SEC
		RTL
; End of function sub_C43F8C

.A8
.I16

sub_C43FC9:
		SEP	#$20
		LDA	#.BANKBYTE(up_walking_animation)
		STA	z:$52
		LDA	z:$4E
		BEQ	loc_C44000
		BIT	#3
		BNE	loc_C43FDB
		EOR	#$C
		BRA	loc_C43FDD
; ---------------------------------------------------------------------------

loc_C43FDB:
		EOR	#3

loc_C43FDD:
		STA	z:$20,X
		REP	#$20
.A16
		AND	#$F
		ASL
		PHX
		TAX
		LDA	f:player_animation_list,X
		STA	z:$50
		PLX
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	#$A
		STA	z:$26,X
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C44000:
		SEP	#$20
		LDA	#2
		STA	z:$26,X
		SEC
		RTL
; End of function sub_C43FC9

.A8
.I16

sub_C44008:
		REP	#$20
.A16
		LDY	z:$50
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$800
		BNE	loc_C4401F
		JSL	f:sub_C44047
		BCS	loc_C4401F
		JSL	f:sub_C4402B
		RTL
; ---------------------------------------------------------------------------

loc_C4401F:
		SEP	#$20
.A8
		LDA	z:$4E
		BNE	loc_C44029
		LDA	z:$18,X
		STA	z:$4E

loc_C44029:
		CLC
		RTL
; End of function sub_C44008

.A16
.I16

sub_C4402B:
		SEP	#$20
.A8
		LDA	#0
		STA	z:$26,X
		LDA	z:$3D,X
		BEQ	loc_C4403F
		DEC	z:$22,X
		LDA	z:$22,X
		BNE	loc_C44045
		LDA	#5
		STA	z:$26,X

loc_C4403F:
		JSL	f:sub_C448DD
		SEP	#$20

loc_C44045:
		SEC
		RTL
; End of function sub_C4402B

.A16
.I16

sub_C44047:
		REP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$1000
		BEQ	loc_C4406B
		LDA	a:.LOWORD(bg1_tilemap),Y
		AND	#$3FF
		CMP	#$48
		BEQ	loc_C4406D
		CMP	#$4A
		BEQ	loc_C4406D
		CMP	#$4C
		BEQ	loc_C4406D
		CMP	#$4E
		BEQ	loc_C4406D

loc_C4406B:
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C4406D:
		LDA	a:.LOWORD($8D6),Y
		ORA	a:.LOWORD($918),Y
		ORA	a:.LOWORD($956),Y
		ORA	a:.LOWORD($914),Y
		BIT	#$800
		BNE	loc_C44080
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C44080:
		SEC
		RTL
; End of function sub_C44047

.A16
.I16

sub_C44082:
		SEP	#$20
.A8
		LDA	z:$4E
		BEQ	loc_C4408E
		LDA	#0
		STA	z:$26,X
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C4408E:
		LDA	#4
		STA	z:$26,X
		SEC
		RTL
; End of function sub_C44082

.A8
.I16

sub_C44094:
		SEP	#$20
		LDA	z:$4E
		BEQ	loc_C440B8
		BIT	z:$21,X
		BNE	loc_C440E7
		JSL	f:sub_C44519
		SEP	#$20
		LDA	#2
		STA	z:$26,X
		LDA	z:$20,X
		BIT	#3
		BNE	loc_C440B2
		EOR	#$C
		BRA	loc_C440B4
; ---------------------------------------------------------------------------

loc_C440B2:
		EOR	#3

loc_C440B4:
		STA	z:$18,X
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C440B8:
		LDA	z:$20,X
		BIT	#3
		BNE	loc_C440C2
		EOR	#$C
		BRA	loc_C440C4
; ---------------------------------------------------------------------------

loc_C440C2:
		EOR	#3

loc_C440C4:
		STA	z:$4E
		REP	#$20
.A16
		PHX
		AND	#$FF
		ASL
		TAX
		LDA	z:$50
		CLC
		ADC	f:byte_C44246,X
		TAY
		PLX
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$1E0
		SEP	#$20
.A8
		BNE	loc_C440E7
		LDA	z:$24,X
		BNE	loc_C440E7
		BRA	sub_C44094
; ---------------------------------------------------------------------------

loc_C440E7:
		JSL	f:sub_C446AB
		LDA	#3
		STA	z:$26,X
		SEC
		RTL
; End of function sub_C44094

.A8
.I16

sub_C440F1:
		SEP	#$20
		LDA	z:$20,X
		BIT	#3
		BNE	loc_C440FD
		EOR	#$C
		BRA	loc_C440FF
; ---------------------------------------------------------------------------

loc_C440FD:
		EOR	#3

loc_C440FF:
		STA	z:$18,X
		SEC
		RTL
; End of function sub_C440F1

.A8
.I16

sub_C44103:
		SEP	#$20
		LDA	z:$4E
		BEQ	loc_C4416A
		BIT	z:$21,X
		BEQ	loc_C44111
		JML	f:loc_C4419A
; ---------------------------------------------------------------------------

loc_C44111:
		JSL	f:sub_C44519
		JSL	f:sub_C441A4
		SEP	#$20
		BCC	sub_C440F1
		LDA	#2
		STA	z:$26,X
		LDA	z:$20,X
		BIT	#3
		BNE	loc_C4412B
		EOR	#$C
		BRA	loc_C4412D
; ---------------------------------------------------------------------------

loc_C4412B:
		EOR	#3

loc_C4412D:
		STA	z:$18,X
		LDA	z:$3D,X
		CMP	#3
		BCC	loc_C44164
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C44166)
		STA	z:$DB
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_C44166)
		STA	z:$DD
		SEP	#$20
		LDA	#0
		XBA

loc_C44147:
		LDA	z:$25,X
		AND	#3
		TAY
		LDA	[$DB],Y
		CMP	z:$20,X
		BNE	loc_C44156
		INC	z:$25,X
		BRA	loc_C44147
; ---------------------------------------------------------------------------

loc_C44156:
		LDA	[$DB],Y
		STA	z:$40
		LDA	z:$1B,X
		BIT	z:$40
		BEQ	loc_C44164
		LDA	[$DB],Y
		STA	z:$4E

loc_C44164:
		CLC
		RTL
; ---------------------------------------------------------------------------
byte_C44166:	.BYTE 8, 1, 4, 2	; 0
; ---------------------------------------------------------------------------

loc_C4416A:
		LDA	z:$20,X
		BIT	#3
		BNE	loc_C44174
		EOR	#$C
		BRA	loc_C44176
; ---------------------------------------------------------------------------

loc_C44174:
		EOR	#3

loc_C44176:
		STA	z:$4E
		REP	#$20
.A16
		PHX
		AND	#$FF
		ASL
		TAX
		LDA	z:$50
		CLC
		ADC	f:byte_C44246,X
		TAY
		PLX
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$1E0
		SEP	#$20
.A8
		BNE	loc_C4419A
		LDA	z:$24,X
		BNE	loc_C4419A
		JMP	a:.LOWORD(sub_C44103)
; ---------------------------------------------------------------------------

loc_C4419A:
		JSL	f:sub_C446AB
		LDA	#3
		STA	z:$26,X
		SEC
		RTL
; End of function sub_C44103

.A8
.I16

sub_C441A4:
		SEP	#$20
		LDA	z:$39,X
		AND	#3
		BEQ	loc_C441C0
		CMP	#3
		BNE	loc_C441B9
		JSL	f:random2
		SEP	#$20
		AND	#1
		INC

loc_C441B9:
		CLC
		ADC	#6
		STA	z:$26,X
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C441C0:
		SEC
		RTL
; End of function sub_C441A4

.A8
.I16

sub_C441C2:
		SEP	#$20
		LDA	z:$4E
		BEQ	loc_C441CA
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C441CA:
		LDA	#0
		STA	z:$26,X
		SEC
		RTL
; End of function sub_C441C2

; ---------------------------------------------------------------------------
off_C441D0:	.ADDR sub_C442B8, sub_C44325, sub_C443C3, sub_C442B8, sub_C443C3, sub_C4437A, sub_C443C3, sub_C4426A, sub_C441F8
off_C441E2:	.ADDR sub_C43F31, sub_C43F74, sub_C44008, sub_C44082, sub_C44094, sub_C441C2, sub_C44103, sub_C43FC9, sub_C43F8C
.A16
.I16

call_function_at_5f:
		JMP	[$5F]
; ---------------------------------------------------------------------------
		RTI
; End of function call_function_at_5f

.A16
.I16

sub_C441F8:
		SEP	#$20
.A8
		LDA	z:$4A
		BIT	#3
		BNE	loc_C44204
		EOR	#$C
		BRA	loc_C44206
; ---------------------------------------------------------------------------

loc_C44204:
		EOR	#3

loc_C44206:
		STA	z:$40
		LDA	z:$1B,X
		BIT	z:$40
		BEQ	locret_C44245
		REP	#$20
.A16
		STZ	z:$44
		LDA	z:$50
		PHX
		LDX	z:$4C
		CLC
		ADC	f:byte_C44246+$12,X
		TAY
		PLX

loc_C4421E:
		CPY	z:$53
		BEQ	loc_C44237
		TYA
		PHX
		LDX	z:$4C
		CLC
		ADC	f:byte_C44246,X
		TAY
		PLX
		INC	z:$44
		LDA	z:$44
		CMP	#8
		BCC	loc_C4421E
		RTL
; ---------------------------------------------------------------------------

loc_C44237:
		SEP	#$20
.A8
		LDA	z:$44
		CMP	z:$48
		BCS	locret_C44245
		STA	z:$48
		LDA	z:$4A
		STA	z:$4E

locret_C44245:
		RTL
; End of function sub_C441F8

; ---------------------------------------------------------------------------
byte_C44246:	.BYTE 0, 0, 2, 0	; 0
		.BYTE $FE, $FF,	0, 0	; 4
		.BYTE $40, 0, 0, 0	; 8
		.BYTE 0, 0, 0, 0	; $C
		.BYTE $C0, $FF,	0, 0	; $10
		.BYTE 4, 0, $FC, $FF	; $14
		.BYTE 0, 0, $80, 0	; $18
		.BYTE 0, 0, 0, 0	; $1C
		.BYTE 0, 0, $80, $FF	; $20
.A8
.I16

sub_C4426A:
		SEP	#$20
		LDA	z:$4A
		BIT	#3
		BNE	loc_C44276
		EOR	#$C
		BRA	loc_C44278
; ---------------------------------------------------------------------------

loc_C44276:
		EOR	#3

loc_C44278:
		STA	z:$40
		LDA	z:$1B,X
		BIT	z:$40
		BEQ	locret_C442B7
		REP	#$20
.A16
		STZ	z:$44
		LDA	z:$50
		PHX
		LDX	z:$4C
		CLC
		ADC	f:byte_C44246+$12,X
		TAY
		PLX

loc_C44290:
		CPY	z:$53
		BEQ	loc_C442A9
		TYA
		PHX
		LDX	z:$4C
		CLC
		ADC	f:byte_C44246,X
		TAY
		PLX
		INC	z:$44
		LDA	z:$44
		CMP	#$A
		BCC	loc_C44290
		RTL
; ---------------------------------------------------------------------------

loc_C442A9:
		SEP	#$20
.A8
		LDA	z:$44
		CMP	z:$48
		BCS	locret_C442B7
		STA	z:$48
		LDA	z:$4A
		STA	z:$4E

locret_C442B7:
		RTL
; End of function sub_C4426A

.A8
.I16

sub_C442B8:
		REP	#$20
.A16
		LDA	#$1E0
		STA	z:$42
		LDA	z:$3D,X
		CMP	#2
		BCC	loc_C442CB
		LDA	#$9E0
		STA	z:$42

loc_C442CB:
		LDY	z:$50
		STZ	z:$44

loc_C442CF:
		JSL	f:sub_C44440
		BCS	locret_C4430D
		REP	#$20
		CPY	z:$53
		BEQ	loc_C442FB
		BIT	#$200
		BEQ	loc_C442E2
		INC	z:$D8

loc_C442E2:
		JSL	f:sub_C444A2
		REP	#$20
		CPY	z:$53
		BEQ	loc_C442FB
		BIT	#$200
		BEQ	loc_C442F3
		INC	z:$D8

loc_C442F3:
		LDA	z:$44
		CMP	#$16
		BCC	loc_C442CF
		RTL
; ---------------------------------------------------------------------------

loc_C442FB:
		SEP	#$20
.A8
		LDA	z:$44
		BEQ	locret_C4430D
		CMP	z:$48
		BEQ	loc_C4430E
		BCS	locret_C4430D
		STA	z:$48
		LDA	z:$4A
		STA	z:$4E

locret_C4430D:
		RTL
; ---------------------------------------------------------------------------

loc_C4430E:
		INC	z:$17,X
		LDA	z:$16,X
		BNE	locret_C4430D
		INC	z:$16,X
		LDA	z:$25,X
		AND	#1
		BNE	locret_C4430D
		LDA	z:$44
		STA	z:$48
		LDA	z:$4A
		STA	z:$4E
		RTL
; End of function sub_C442B8

.A8
.I16

sub_C44325:
		REP	#$20
.A16
		LDA	#$9E0
		STA	z:$42
		STZ	z:$44
		LDY	z:$50

loc_C44330:
		JSL	f:sub_C44440
		BCS	loc_C4434A
		JSL	f:sub_C444A2
		SEP	#$20
.A8
		BIT	#$40
		BNE	loc_C44350
		REP	#$20
.A16
		LDA	z:$44
		CMP	#$16
		BCC	loc_C44330
		RTL
; ---------------------------------------------------------------------------

loc_C4434A:
		SEP	#$20
.A8
		BIT	#$40
		BEQ	locret_C44379

loc_C44350:
		LDA	z:$3D,X
		CMP	#4
		BCC	loc_C4436D
		AND	#$1F
		BNE	loc_C4436D
		LDA	z:$D7
		BNE	locret_C44379
		INC	z:$D7
		LDA	z:$44
		CMP	z:$48
		BCS	locret_C44379
		STA	z:$48
		LDA	z:$4A
		STA	z:$4E
		RTL
; ---------------------------------------------------------------------------

loc_C4436D:
		LDA	z:$44
		CMP	z:$48
		BCS	locret_C44379
		STA	z:$48
		LDA	z:$4A
		STA	z:$4E

locret_C44379:
		RTL
; End of function sub_C44325

.A8
.I16

sub_C4437A:
		REP	#$20
.A16
		LDA	#$BE0
		STA	z:$42
		STZ	z:$44
		LDY	z:$50

loc_C44385:
		JSL	f:sub_C44440
		BCS	loc_C4439F
		JSL	f:sub_C444A2
		REP	#$20
		BIT	#$200
		BNE	loc_C443A6
		SEP	#$20
.A8
		LDA	z:$44
		CMP	#$16
		BCC	loc_C44385
		RTL
; ---------------------------------------------------------------------------

loc_C4439F:
		REP	#$20
.A16
		BIT	#$200
		BEQ	locret_C443C2

loc_C443A6:
		STA	z:$40
		SEP	#$20
.A8
		LDA	z:$3D,X
		CMP	#3
		BCC	loc_C443B6
		LDA	z:$41
		BIT	#8
		BNE	locret_C443C2

loc_C443B6:
		LDA	z:$44
		CMP	z:$48
		BCS	locret_C443C2
		STA	z:$48
		LDA	z:$4A
		STA	z:$4E

locret_C443C2:
		RTL
; End of function sub_C4437A

.A8
.I16

sub_C443C3:
		REP	#$20
.A16
		LDA	#$1E0
		STA	z:$42
		LDY	z:$50
		STZ	z:$44

loc_C443CE:
		JSL	f:sub_C44440
		BCS	locret_C44405
		REP	#$20
		BIT	#$800
		BEQ	loc_C443F1
		JSL	f:sub_C444A2
		REP	#$20
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$800
		BEQ	loc_C443F1
		LDA	z:$44
		CMP	#$16
		BCC	loc_C443CE
		RTL
; ---------------------------------------------------------------------------

loc_C443F1:
		SEP	#$20
.A8
		LDA	z:$1B,X
		ORA	z:$4A
		STA	z:$1B,X
		LDA	z:$44
		CMP	z:$48
		BCS	locret_C44405
		STA	z:$48
		LDA	z:$4A
		STA	z:$4E

locret_C44405:
		RTL
; End of function sub_C443C3

.A8
.I16

sub_C44406:
		REP	#$20
.A16
		LDA	#$1E0
		STA	z:$42
		LDY	z:$50
		STZ	z:$44

loc_C44411:
		JSL	f:sub_C44440
		BCS	locret_C4443F
		REP	#$20
		BIT	#$800
		BEQ	loc_C44431
		JSL	f:sub_C444A2
		REP	#$20
		BIT	#$800
		BEQ	loc_C44431
		LDA	z:$44
		CMP	#$16
		BCC	loc_C44411
		RTL
; ---------------------------------------------------------------------------

loc_C44431:
		SEP	#$20
.A8
		LDA	z:$44
		CMP	z:$48
		BCS	locret_C4443F
		STA	z:$48
		LDA	z:$4A
		STA	z:$4E

locret_C4443F:
		RTL
; End of function sub_C44406

.A8
.I16

sub_C44440:
		REP	#$20
.A16
		TYA
		STA	z:$5F
		PHX
		LDX	z:$4C
		CLC
		ADC	f:byte_C44246,X
		TAY
		PLX
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$42
		SEP	#$20
.A8
		BNE	loc_C4445C
		INC	z:$44
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C4445C:
		LDY	z:$5F
		SEC
		RTL
; End of function sub_C44440

.A16
.I16

sub_C44460:
		SEP	#$20
.A8
		LDA	z:$4C
		BIT	#2
		BNE	loc_C44479
		BIT	#8
		BNE	loc_C44483
		BIT	#$10
		BNE	loc_C44492
		TYA
		AND	#$1E
		CMP	a:.LOWORD($120),X
		BEQ	loc_C444A0
		RTL
; ---------------------------------------------------------------------------

loc_C44479:
		TYA
		AND	#$1E
		CMP	a:.LOWORD($120),X
		BCS	loc_C444A0
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C44483:
		REP	#$20
.A16
		TYA
		AND	#$3C0
		CMP	a:.LOWORD($122),X
		SEP	#$20
.A8
		BCS	loc_C444A0
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C44492:
		REP	#$20
.A16
		TYA
		AND	#$3C0
		CMP	a:.LOWORD($122),X
		SEP	#$20
.A8
		BEQ	loc_C444A0
		RTL
; ---------------------------------------------------------------------------

loc_C444A0:
		CLC
		RTL
; End of function sub_C44460

.A16
.I16

sub_C444A2:
		REP	#$20
		TYA
		CLC
		ADC	#$40
		BIT	#$42
		BNE	loc_C44505
		JSL	f:sub_C44460
		BCS	loc_C44505
		SEP	#$20
.A8
		LDA	z:$4C
		AND	#6
		BEQ	loc_C444E3
		REP	#$20
.A16
		TYA
		AND	#$3C0
		CMP	a:.LOWORD($122),X
		SEP	#$20
.A8
		BEQ	loc_C44505
		LDA	z:$4C
		STA	z:$40
		LDA	#$10
		BCS	loc_C444D3
		LDA	#8

loc_C444D3:
		STA	z:$4C
		JSL	f:sub_C44440
		BCC	loc_C4450E
		PHA
		LDA	z:$40
		STA	z:$4C
		PLA
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C444E3:
		TYA
		AND	#$1E
		CMP	a:.LOWORD($120),X
		BEQ	loc_C44505
		LDA	z:$4C
		STA	z:$40
		LDA	#4
		BCS	loc_C444F5
		LDA	#2

loc_C444F5:
		STA	z:$4C
		JSL	f:sub_C44440
		BCC	loc_C4450E
		PHA
		LDA	z:$40
		STA	z:$4C
		PLA
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C44505:
		REP	#$20
.A16
		LDA	a:.LOWORD(collision_map),Y
		SEP	#$20
.A8
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C4450E:
		LDA	z:$4F
		ORA	z:$4A
		STA	z:$4F
		LDA	a:.LOWORD(collision_map),Y
		SEC
		RTL
; End of function sub_C444A2

.A8
.I16

sub_C44519:
		REP	#$20
.A16
		LDA	z:$50
		STA	z:$56
		TAY
		JSL	f:drop_bomb
		BCS	locret_C4453A
		SEP	#$20
.A8
		INC	z:$25,X
		LDA	z:$33,X
		BEQ	locret_C4453A
		INC	z:$1A,X
		LDA	z:$1A,X
		CMP	#1
		BNE	locret_C4453A
		JSL	f:sub_C44911

locret_C4453A:
		RTL
; End of function sub_C44519

.A16
.I16

sub_C4453B:
		SEP	#$20
.A8
		LDA	a:.LOWORD($13B),X
		BIT	#$80
		BEQ	loc_C44548
		JML	f:loc_C446A7
; ---------------------------------------------------------------------------

loc_C44548:
		LDA	z:$30,X
		STA	z:$40
		LDA	a:.LOWORD($13C),X
		BIT	#1
		BEQ	loc_C44557
		LDA	#0
		STA	z:$40

loc_C44557:
		LDA	z:$40
		CMP	z:$24,X
		BCS	loc_C44561
		JML	f:loc_C446A7
; ---------------------------------------------------------------------------

loc_C44561:
		LDY	z:$50
		LDA	a:.LOWORD(collision_map),Y
		AND	#$E0
		BEQ	loc_C4456E
		JML	f:loc_C446A7
; ---------------------------------------------------------------------------

loc_C4456E:
		REP	#$20
.A16
		LDA	z:$A,X
		PHA
		STY	z:$A,X
		CPX	#$E40
		BCS	loc_C44587
		LDA	a:.LOWORD($13C),X
		BIT	#1
		BEQ	loc_C44587
		LDA	#0
		BRA	loc_C44591
; ---------------------------------------------------------------------------

loc_C44587:
		LDA	z:$31,X
		BIT	#$80
		BEQ	loc_C44591
		LDA	#9

loc_C44591:
		INC
		AND	#$FF
		STA	z:$42
		SEP	#$20
.A8
		STZ	z:$21,X
		REP	#$20
.A16
		LDA	#$2E0
		STA	z:$44
		LDA	z:$38,X
		BIT	#1
		BEQ	loc_C445AE
		LDA	#$A0
		STA	z:$44

loc_C445AE:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C445B4:
		TYA
		CLC
		ADC	#$FFC0
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$800
		BEQ	loc_C445CC
		LDA	z:$21,X
		ORA	#8
		STA	z:$21,X
		LDA	a:.LOWORD(collision_map),Y

loc_C445CC:
		BIT	z:$44
		BNE	loc_C445EA
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C445EA
		CMP	#$11D
		BEQ	loc_C445EA
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$800
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C445B4

loc_C445EA:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C445F0:
		TYA
		CLC
		ADC	#2
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$800
		BEQ	loc_C44608
		LDA	z:$21,X
		ORA	#1
		STA	z:$21,X
		LDA	a:.LOWORD(collision_map),Y

loc_C44608:
		BIT	z:$44
		BNE	loc_C44626
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C44626
		CMP	#$11F
		BEQ	loc_C44626
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$800
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C445F0

loc_C44626:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C4462C:
		TYA
		CLC
		ADC	#$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$800
		BEQ	loc_C44644
		LDA	z:$21,X
		ORA	#4
		STA	z:$21,X
		LDA	a:.LOWORD(collision_map),Y

loc_C44644:
		BIT	z:$44
		BNE	loc_C44662
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C44662
		CMP	#$11C
		BEQ	loc_C44662
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$800
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C4462C

loc_C44662:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C44668:
		TYA
		CLC
		ADC	#$FFFE
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$800
		BEQ	loc_C44680
		LDA	z:$21,X
		ORA	#2
		STA	z:$21,X
		LDA	a:.LOWORD(collision_map),Y

loc_C44680:
		BIT	z:$44
		BNE	loc_C4469E
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C4469E
		CMP	#$11E
		BEQ	loc_C4469E
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$800
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C44668

loc_C4469E:
		REP	#$20
		PLA
		STA	z:$A,X
		SEP	#$20
.A8
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C446A7:
		SEP	#$20
		SEC
		RTL
; End of function sub_C4453B

.A8
.I16

sub_C446AB:
		REP	#$20
.A16
		LDA	z:$A,X
		PHA
		LDA	z:$50
		STA	z:$A,X
		CPX	#$E40
		BCS	loc_C446C6
		LDA	a:.LOWORD($13C),X
		BIT	#1
		BEQ	loc_C446C6
		LDA	#0
		BRA	loc_C446D0
; ---------------------------------------------------------------------------

loc_C446C6:
		LDA	z:$31,X
		BIT	#$80
		BEQ	loc_C446D0
		LDA	#9

loc_C446D0:
		INC
		AND	#$FF
		STA	z:$42
		SEP	#$20
.A8
		LDA	#0
		PHA
		PLB
		REP	#$20
.A16
		LDA	#$2E0
		STA	z:$44
		LDA	z:$38,X
		BIT	#1
		BEQ	loc_C446EF
		LDA	#$A0
		STA	z:$44

loc_C446EF:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C446F5:
		TYA
		CLC
		ADC	#$FFC0
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C44706
		STZ	z:$40
		INC	z:$40

loc_C44706:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C44720
		CMP	#$11D
		BEQ	loc_C44720
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C446F5

loc_C44720:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C44726:
		TYA
		CLC
		ADC	#2
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C44737
		STZ	z:$40
		INC	z:$40

loc_C44737:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C44751
		CMP	#$11F
		BEQ	loc_C44751
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C44726

loc_C44751:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C44757:
		TYA
		CLC
		ADC	#$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C44768
		STZ	z:$40
		INC	z:$40

loc_C44768:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C44782
		CMP	#$11C
		BEQ	loc_C44782
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C44757

loc_C44782:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C44788:
		TYA
		CLC
		ADC	#$FFFE
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C44799
		STZ	z:$40
		INC	z:$40

loc_C44799:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C447B3
		CMP	#$11E
		BEQ	loc_C447B3
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C44788

loc_C447B3:
		REP	#$20
		PLA
		STA	z:$A,X
		SEP	#$20
.A8
		LDA	#0
		PHA
		PLB
		RTL
; End of function sub_C446AB

; ---------------------------------------------------------------------------
byte_C447BF:	.BYTE $40, $D, $80, $D	; 0
		.BYTE $C0, $D, 0, $E	; 4
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_C447CF

loc_C447C7:
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		BNE	loc_C447E3
		RTL
; END OF FUNCTION CHUNK	FOR sub_C447CF
.A8
.I16

sub_C447CF:

; FUNCTION CHUNK AT 47C7 SIZE 00000008 BYTES

		SEP	#$20
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#2
		BEQ	loc_C447C7
		LDA	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		CMP	#1
		BNE	loc_C447E3
		JML	f:locret_C44864
; ---------------------------------------------------------------------------

loc_C447E3:
		LDY	a:.LOWORD($100),X
		LDA	a:.LOWORD(4),Y
		REP	#$20
.A16
		BEQ	sub_C447F2
		DEC	a:.LOWORD($126),X
		BNE	loc_C44840
; End of function sub_C447CF

.A8
.I16

sub_C447F2:
		REP	#$20
.A16
		LDA	#$100
		STA	a:.LOWORD($126),X
		LDA	#$FF
		STA	z:$4A
		LDA	a:.LOWORD(level_manager_object+level_manager_object::number_of_human_players) ; orig=0x0D36
		AND	#$FF
		BNE	loc_C4480C
		LDA	#0
		STA	z:$4A

loc_C4480C:
		JSL	f:random2
		REP	#$20
		AND	#6
		STA	z:$40

loc_C44817:
		LDA	z:$40
		INC
		INC
		AND	#6
		STA	z:$40
		PHX
		TAX
		LDA	f:byte_C447BF,X
		PLX
		STA	z:$42
		CPX	z:$42
		BEQ	loc_C44817
		TAY
		STA	a:.LOWORD($100),X
		LDA	a:.LOWORD(4),Y
		AND	#$FF
		BEQ	loc_C44817
		LDA	a:.LOWORD(7),Y
		AND	z:$4A
		BNE	loc_C44817

loc_C44840:
		REP	#$20
		LDY	a:.LOWORD($100),X
		LDA	a:.LOWORD($11),Y
		AND	#$F0
		LSR
		LSR
		LSR
		STA	a:.LOWORD($120),X
		LDA	a:.LOWORD($14),Y
		AND	#$F0
		ASL
		ASL
		STA	a:.LOWORD($122),X
		ORA	a:.LOWORD($120),X
		STA	a:.LOWORD($124),X
		STA	z:$53
.A8

locret_C44864:
		RTL
; End of function sub_C447F2

.A8
.I16

sub_C44865:
		REP	#$20
.A16
		LDA	#$FF
		STA	z:$4A
		LDA	a:.LOWORD(level_manager_object+level_manager_object::number_of_human_players) ; orig=0x0D36
		AND	#$FF
		BNE	loc_C4480C
		LDA	#0
		STA	z:$4A
		STX	z:$5F
		LDA	z:$14,X
		AND	#$FF
		CLC
		ADC	z:$11,X
		STA	z:$40
		LDA	#$FFFF
		STA	z:$42
		LDA	#$D40

loc_C4488D:
		TAX
		CMP	z:$5F
		BEQ	loc_C448B5
		LDA	z:4,X
		AND	#$FF
		BEQ	loc_C448B5
		LDA	z:7,X
		AND	z:$4A
		BNE	loc_C448B5
		LDA	z:$11,X
		CLC
		ADC	z:$14,X
		SEC
		SBC	z:$40
		BPL	loc_C448AD
		EOR	#$FFFF
		INC

loc_C448AD:
		CMP	z:$42
		BCS	loc_C448B5
		STA	z:$42
		STX	z:$62

loc_C448B5:
		TXA
		CLC
		ADC	#$40
		CMP	#$E40
		BNE	loc_C4488D
		LDX	z:$62
		LDA	z:$11,X
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$46
		LDA	z:$14,X
		AND	#$F0
		ASL
		ASL
		STA	z:$D3
		JSL	f:get_object_square_index
		STA	z:$53
		LDX	z:$5F
		RTL
; End of function sub_C44865

.A8
.I16

sub_C448DD:
		REP	#$20
.A16
		LDA	z:$3D,X
		AND	#$FF
		PHX
		TAX
		JSL	f:random2
		SEP	#$20
.A8
		CLC
		ADC	f:byte_C4493B+5,X
		PLX
		STA	z:$22,X
		RTL
; End of function sub_C448DD

.A8
.I16

sub_C448F5:
		REP	#$20
.A16
		LDA	z:$3D,X
		AND	#$FF
		PHX
		TAX
		JSL	f:random2
		SEP	#$20
.A8
		AND	f:byte_C44936,X
		ORA	f:byte_C4493B,X
		PLX
		STA	a:.LOWORD($138),X
		RTL
; End of function sub_C448F5

.A8
.I16

sub_C44911:
		REP	#$20
.A16
		LDA	z:$3D,X
		AND	#$FF
		PHX
		TAX
		JSL	f:random2
		SEP	#$20
.A8
		AND	f:byte_C4492C,X
		ORA	f:byte_C44931,X
		PLX
		STA	z:$1C,X
		RTL
; End of function sub_C44911

; ---------------------------------------------------------------------------
byte_C4492C:	.BYTE $7F, $7F,	$3F, $3F; 0
		.BYTE $3F		; 4
byte_C44931:	.BYTE $60, $40,	$30, $20; 0
		.BYTE $20		; 4
byte_C44936:	.BYTE $7F, $3F,	$1F, $F	; 0
		.BYTE 0			; 4
byte_C4493B:	.BYTE $3F, $1F,	$F, 7	; 0
		.BYTE 1, $FF, 4, 3	; 4
		.BYTE 2, 2		; 8
.A8
.I16

sub_C44945:
		SEP	#$20
		CLC
		LDA	a:.LOWORD($130),X
		ADC	a:.LOWORD($131),X
		ADC	a:.LOWORD($132),X
		ADC	a:.LOWORD($133),X
		ADC	a:.LOWORD($134),X
		ADC	a:.LOWORD($135),X
		STA	z:$40
		BEQ	locret_C44997
		SEP	#$20
		LDA	#.LOBYTE(sub_C44998)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C44998)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C44998)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C4497C
		JML	f:locret_C44997
; ---------------------------------------------------------------------------

loc_C4497C:
		LDA	#1
		STA	a:.LOWORD($20),Y
		LDA	#0
		STA	a:.LOWORD($22),Y
		LDA	#0
		STA	a:.LOWORD($34),Y
		LDA	z:$40
		STA	a:.LOWORD($32),Y
		TXA
		STA	a:.LOWORD($30),Y

locret_C44997:
		RTL
; End of function sub_C44945

.A16
.I16

sub_C44998:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C449A5
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C449A5:
		BIT	#$41
		BEQ	loc_C449AD
		JML	f:locret_C44A05
; ---------------------------------------------------------------------------

loc_C449AD:
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#8
		BNE	locret_C44A05
		DEC	z:$20,X
		BNE	locret_C44A05
		LDA	#1
		STA	z:$20,X
		JSL	f:sub_C43B6E
		BCS	locret_C44A05
		REP	#$20
		STY	z:$50
		LDA	#1
		STA	z:$20,X

loc_C449CF:
		REP	#$20
		LDA	z:$30,X
		ORA	z:$34,X
		TAY
		SEP	#$20
.A8
		LDA	a:.LOWORD($130),Y
		BNE	loc_C449E1
		INC	z:$34,X
		BRA	loc_C449CF
; ---------------------------------------------------------------------------

loc_C449E1:
		DEC
		STA	a:.LOWORD($130),Y
		REP	#$20
.A16
		LDA	z:$34,X
		ASL
		PHX
		TAX
		LDA	f:byte_C44A06,X
		PLX
		LDY	z:$50
		JSL	f:create_bonus_object
		JSL	f:sub_C539E2
		SEP	#$20
.A8
		DEC	z:$32,X
		BNE	locret_C44A05
		JSL	f:delete_object

locret_C44A05:
		RTL
; End of function sub_C44998

; ---------------------------------------------------------------------------
byte_C44A06:	.BYTE 1, 0, 2, 0	; 0
		.BYTE 4, 0, 3, 0	; 4
		.BYTE $C, 0, $D, 0	; 8
		.BYTE $22, $B, $B, $C6	; $C
		.BYTE $6B		; $10
.A16
.I16

sub_C44A17:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C44A68)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C44A68)
		STA	z:$DC

loc_C44A21:
		LDA	#.BANKBYTE(sub_C44A68)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C44A35
		JML	f:locret_C44A67
; ---------------------------------------------------------------------------

loc_C44A35:
		LDA	z:$56
		STA	a:.LOWORD($A),Y
		SEP	#$20
.A8
		CPX	#$E40
		BCS	loc_C44A4C
		LDA	a:.LOWORD($13C),X
		BIT	#1
		BEQ	loc_C44A4C
		LDA	#0
		BRA	loc_C44A54
; ---------------------------------------------------------------------------

loc_C44A4C:
		LDA	z:$31,X
		BIT	#$80
		BEQ	loc_C44A54
		LDA	#9

loc_C44A54:
		INC
		STA	a:.LOWORD($C),Y
		LDA	z:$33,X
		CLC
		ROR
		ORA	z:$38,X
		ROR
		ROR
		ORA	a:.LOWORD($C),Y
		STA	a:.LOWORD($C),Y
		CLC
.A16

locret_C44A67:
		RTL
; End of function sub_C44A17

.A16
.I16

sub_C44A68:
		REP	#$20
		LDY	z:$A,X
		LDA	#$D
		STA	z:$40
		LDA	z:$A,X
		AND	#$FFC0
		ORA	#4
		TAY

loc_C44A7A:
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		TYA
		CLC
		ADC	#2
		TAY
		DEC	z:$40
		BNE	loc_C44A7A
		LDA	#$B
		STA	z:$40
		LDA	z:$A,X
		AND	#$3F
		ORA	#$40
		TAY

loc_C44A9B:
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		TYA
		CLC
		ADC	#$40
		TAY
		DEC	z:$40
		BNE	loc_C44A9B
		REP	#$20
		LDA	z:$C,X
		AND	#$F
		STA	z:$42
		LDA	#$2E0
		STA	z:$44
		LDA	z:$C,X
		BIT	#$80
		BEQ	loc_C44AC8
		LDA	#$A0
		STA	z:$44

loc_C44AC8:
		LDY	z:$A,X
		LDA	#$820
		STA	a:.LOWORD(collision_map),Y
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C44AD6:
		TYA
		CLC
		ADC	#$FFC0
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C44AE7
		STZ	z:$40
		INC	z:$40

loc_C44AE7:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C44B01
		CMP	#$11D
		BEQ	loc_C44B01
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$800
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C44AD6

loc_C44B01:
		LDY	z:$A,X
		LDA	z:$42

loc_C44B05:
		STA	z:$40

loc_C44B07:
		TYA
		CLC
		ADC	#2
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C44B18
		STZ	z:$40
		INC	z:$40

loc_C44B18:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C44B32
		CMP	#$11F
		BEQ	loc_C44B32
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$800
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C44B07

loc_C44B32:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C44B38:
		TYA
		CLC
		ADC	#$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C44B49
		STZ	z:$40
		INC	z:$40

loc_C44B49:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C44B63
		CMP	#$11C
		BEQ	loc_C44B63
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$800
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C44B38

loc_C44B63:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C44B69:
		TYA
		CLC
		ADC	#$FFFE
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C44B7A
		STZ	z:$40
		INC	z:$40

loc_C44B7A:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C44B94
		CMP	#$11E
		BEQ	loc_C44B94
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$800
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C44B69

loc_C44B94:
		JSL	f:delete_object
		RTL
; End of function sub_C44A68

.A16
.I16

sub_C44B99:
		REP	#$20
		LDY	z:$50
		LDA	#.LOWORD(byte_C44A06+$C)
		STA	a:.LOWORD(0),Y
		RTL
; End of function sub_C44B99

.A8
.I16

sub_C44BA4:
		REP	#$20
.A16
		REP	#$20
		LDA	#.LOWORD(explode_bomb)
		STA	z:$40
		JSL	f:sub_C60AC0
		BCC	loc_C44BB7
		JML	f:locret_C44BBA
; ---------------------------------------------------------------------------

loc_C44BB7:
		JMP	a:.LOWORD(loc_C44C23)
; ---------------------------------------------------------------------------

locret_C44BBA:
		RTL
; End of function sub_C44BA4

.A16
.I16

drop_bomb:
		REP	#$20
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$100
		BNE	sub_C44BA4
		JSL	f:sub_C44A17
		BCC	loc_C44BCF
		JML	f:locret_C44CAF
; ---------------------------------------------------------------------------

loc_C44BCF:
		REP	#$20
		TYA
		STA	z:$50
		REP	#$20
		LDA	#.LOWORD(loc_C44DA9)
		STA	z:$40
		JSL	f:sub_C60AC0
		BCC	loc_C44BE5
		JML	f:sub_C44B99
; ---------------------------------------------------------------------------

loc_C44BE5:
		REP	#$20
		PHY
		LDY	z:$56
		LDA	#$820
		STA	a:.LOWORD(collision_map),Y
		LDA	#$1880
		STA	a:.LOWORD(bg1_tilemap),Y
		LDY	#$1E
		JSL	f:play_sound
		PLY
		SEP	#$20
.A8
		LDA	#$78
		STA	a:.LOWORD(3),Y
		REP	#$20
.A16
		LDA	#0
		STA	a:.LOWORD($1E),Y
		LDA	z:$11,X
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($11),Y
		LDA	z:$14,X
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($14),Y

loc_C44C23:
		REP	#$20
		LDA	z:$56
		STA	a:.LOWORD($A),Y
		TXA
		STA	a:.LOWORD(8),Y
		SEP	#$20
.A8
		CPX	#$E40
		BCS	loc_C44C40
		LDA	a:.LOWORD($13C),X
		BIT	#1
		BEQ	loc_C44C40
		LDA	#0
		BRA	loc_C44C48
; ---------------------------------------------------------------------------

loc_C44C40:
		LDA	z:$31,X
		BIT	#$80
		BEQ	loc_C44C48
		LDA	#9

loc_C44C48:
		INC
		STA	a:.LOWORD($C),Y
		LDA	z:$33,X
		CLC
		ROR
		ORA	z:$38,X
		ROR
		ROR
		ORA	a:.LOWORD($C),Y
		STA	a:.LOWORD($C),Y
		LDA	z:0
		STA	a:.LOWORD($D),Y
		LDA	#1
		STA	a:.LOWORD(2),Y
		INC	z:$24,X
		CPX	#$E40
		BCS	loc_C44C74
		INC	a:.LOWORD($108),X
		LDA	a:.LOWORD($108),X
		STA	a:.LOWORD($1C),Y

loc_C44C74:
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#3
		BEQ	loc_C44CAD
		CPX	#$DC0
		BEQ	loc_C44CAD
		CPX	#$E00
		BEQ	loc_C44CAD
		LDA	a:.LOWORD($108),X
		AND	#7
		STA	z:$40
		ASL
		ASL
		ASL
		ORA	z:5,X
		ASL
		INC
		STA	a:.LOWORD(2),Y
		LDA	z:5,X
		BEQ	loc_C44CA4
		BIT	#2
		BNE	loc_C44CAD
		LDA	z:$40
		ORA	#$10
		STA	z:$40

loc_C44CA4:
		STZ	z:$41
		LDY	z:$40
		LDA	#0
		STA	a:.LOWORD($C3F),Y

loc_C44CAD:
		CLC
		RTL
; ---------------------------------------------------------------------------
.A16

locret_C44CAF:
		RTL
; End of function drop_bomb

.A16
.I16

sub_C44CB0:

; FUNCTION CHUNK AT 4DE6 SIZE 000001E5 BYTES
; FUNCTION CHUNK AT 5202 SIZE 00000197 BYTES

		REP	#$20
		LDA	#.LOWORD(explosion_related)
		STA	z:$DB
		SEP	#$20
.A8
		LDA	#.BANKBYTE(explosion_related)
		STA	z:$DD
		REP	#$20
.A16
		LDA	#.LOWORD(explosion_related2)
		STA	z:$DE
		SEP	#$20
.A8
		LDA	#.BANKBYTE(explosion_related2)
		STA	z:$E0
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$1000
		BEQ	loc_C44D02
		LDY	z:$A,X
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	z:$50
		AND	#$3FF
		CMP	#$48
		BNE	loc_C44CE7
		JML	f:loc_C44D05
; ---------------------------------------------------------------------------

loc_C44CE7:
		CMP	#$4A
		BNE	loc_C44CF0
		JML	f:loc_C44D23
; ---------------------------------------------------------------------------

loc_C44CF0:
		CMP	#$4C
		BNE	loc_C44CF9
		JML	f:loc_C44D41
; ---------------------------------------------------------------------------

loc_C44CF9:
		CMP	#$4E
		BNE	loc_C44D02
		JML	f:loc_C44D5F
; ---------------------------------------------------------------------------

loc_C44D02:
		JMP	a:.LOWORD(loc_C44DE6)
; ---------------------------------------------------------------------------

loc_C44D05:
		LDA	#$820
		STA	z:$46
		LDA	#$820
		STA	z:$48
		JSL	f:sub_C4539E
		LDY	#0
		JSL	f:sub_C44D7D
		BCC	loc_C44D20
		JML	f:loc_C45354
; ---------------------------------------------------------------------------

loc_C44D20:
		JMP	a:.LOWORD(loc_C45202)
; ---------------------------------------------------------------------------

loc_C44D23:
		LDA	#$1820
		STA	z:$46
		LDA	#$820
		STA	z:$48
		JSL	f:sub_C4539E
		LDY	#4
		JSL	f:sub_C44D7D
		BCC	loc_C44D3E
		JML	f:loc_C45354
; ---------------------------------------------------------------------------

loc_C44D3E:
		JMP	a:.LOWORD(loc_C45202)
; ---------------------------------------------------------------------------

loc_C44D41:
		LDA	#$2820
		STA	z:$46
		LDA	#$820
		STA	z:$48
		JSL	f:sub_C4539E
		LDY	#8
		JSL	f:sub_C44D7D
		BCC	loc_C44D5C
		JML	f:loc_C45354
; ---------------------------------------------------------------------------

loc_C44D5C:
		JMP	a:.LOWORD(loc_C45202)
; ---------------------------------------------------------------------------

loc_C44D5F:
		LDA	#$3820
		STA	z:$46
		LDA	#$820
		STA	z:$48
		JSL	f:sub_C4539E
		LDY	#$C
		JSL	f:sub_C44D7D
		BCC	loc_C44D7A
		JML	f:loc_C45354
; ---------------------------------------------------------------------------

loc_C44D7A:
		JMP	a:.LOWORD(loc_C45202)
; End of function sub_C44CB0

.A16
.I16

sub_C44D7D:
		REP	#$20
		LDA	[$DE],Y
		STA	z:$42
		INY
		INY
		LDA	[$DE],Y
		STA	z:$43
		JSL	f:sub_C453AB
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		CMP	z:$50
		BNE	loc_C44D96
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C44D96:
		SEC
		RTL
; End of function sub_C44D7D

.A16
.I16

sub_C44D98:
		REP	#$20
		LDY	z:$A,X
		LDA	#BOMB|POTENTIAL_BLAST
		STA	a:.LOWORD(collision_map),Y
		REP	#$20
		LDA	#.LOWORD(loc_C44DA9)
		STA	z:0,X

loc_C44DA9:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C44DB6
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C44DB6:
		BIT	#$41
		BEQ	loc_C44DBE
		JML	f:locret_C44F4D
; ---------------------------------------------------------------------------

loc_C44DBE:
		REP	#$20
.A16
		LDY	z:$A,X
		LDA	a:.LOWORD(collision_map),Y
		AND	#BONUS_MASK|BOMB|SOFT_BLOCK|HARD_BLOCK|$700
		CMP	#HARD_BLOCK|$500
		BNE	loc_C44DD1
		JML	f:sub_C453C8
; ---------------------------------------------------------------------------

loc_C44DD1:
		BIT	#$200
		BEQ	loc_C44DDA
		JML	f:punching_glove_related
; ---------------------------------------------------------------------------

loc_C44DDA:
		BIT	#BONUS_MASK
		BEQ	loc_C44DE3
		JML	f:sudden_death_related
; ---------------------------------------------------------------------------

loc_C44DE3:
		JMP	a:.LOWORD(sub_C44CB0)
; End of function sub_C44D98

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_C44CB0

loc_C44DE6:
		SEP	#$20
.A8
		LDA	#0
		XBA
		LDA	z:3,X
		AND	#$3F
		STA	z:$40
		LDA	z:$C,X
		AND	#$40
		ORA	z:$40
		PHX
		TAX
		LDA	f:bomb_animation,X
		STA	a:.LOWORD(bg1_tilemap),Y
		PLX
		LDA	#$18
		STA	a:.LOWORD(bg1_tilemap+1),Y
		LDA	z:$C,X
		BIT	#$80
		BEQ	loc_C44E11
		LDA	#$1C
		STA	a:.LOWORD($4F5),Y
.A16

loc_C44E11:
		REP	#$20
		LDA	z:$C,X
		AND	#$F
		STA	z:$42
		LDA	#$2E0
		STA	z:$44
		LDA	z:$C,X
		BIT	#$80
		BEQ	loc_C44E2B
		LDA	#$A0
		STA	z:$44

loc_C44E2B:
		LDY	z:$A,X
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$800
		STA	a:.LOWORD(collision_map),Y
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C44E3C:
		TYA
		CLC
		ADC	#$FFC0
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C44E4D
		STZ	z:$40
		INC	z:$40

loc_C44E4D:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C44E67
		CMP	#$11D
		BEQ	loc_C44E67
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$800
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C44E3C

loc_C44E67:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C44E6D:
		TYA
		CLC
		ADC	#2
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C44E7E
		STZ	z:$40
		INC	z:$40

loc_C44E7E:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C44E98
		CMP	#$11F
		BEQ	loc_C44E98
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$800
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C44E6D

loc_C44E98:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C44E9E:
		TYA
		CLC
		ADC	#$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C44EAF
		STZ	z:$40
		INC	z:$40

loc_C44EAF:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C44EC9
		CMP	#$11C
		BEQ	loc_C44EC9
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$800
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C44E9E

loc_C44EC9:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C44ECF:
		TYA
		CLC
		ADC	#$FFFE
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C44EE0
		STZ	z:$40
		INC	z:$40

loc_C44EE0:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C44EFA
		CMP	#$11E
		BEQ	loc_C44EFA
		LDA	a:.LOWORD(collision_map),Y
		ORA	#$800
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C44ECF

loc_C44EFA:
		REP	#$20
		LDA	z:$1E,X
		BEQ	loc_C44F04
		JML	f:loc_C44FBD
; ---------------------------------------------------------------------------

loc_C44F04:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#4
		BNE	loc_C44F4E
		LDA	z:$C,X
		BIT	#$40
		BEQ	loc_C44F57
		LDY	z:8,X
		LDA	a:.LOWORD(4),Y
		BNE	loc_C44F1E
		JML	f:explode_bomb
; ---------------------------------------------------------------------------

loc_C44F1E:
		LDA	a:.LOWORD($27),Y
		BIT	#$80
		BEQ	loc_C44F2D
		AND	#$7F
		STA	a:.LOWORD($27),Y
		JMP	a:.LOWORD(explode_bomb)
; ---------------------------------------------------------------------------

loc_C44F2D:
		DEC	z:3,X
		BNE	locret_C44F4D
		LDA	z:$C,X
		BIT	#$10
		BEQ	loc_C44F3B
		JML	f:explode_bomb
; ---------------------------------------------------------------------------

loc_C44F3B:
		CPY	#$F40
		BCS	locret_C44F4D
		LDA	a:.LOWORD(7),Y
		BEQ	locret_C44F4D
		DEC	z:$D,X
		BNE	locret_C44F4D
		JML	f:explode_bomb
; ---------------------------------------------------------------------------

locret_C44F4D:
		RTL
; ---------------------------------------------------------------------------

loc_C44F4E:
		LDA	z:$C,X
		BIT	#$10
		BNE	loc_C44F57
		DEC	z:3,X
		RTL
; ---------------------------------------------------------------------------

loc_C44F57:
		DEC	z:3,X
		BNE	locret_C44FBC
		LDA	z:$C,X
		BIT	#$10
		BEQ	loc_C44F65
		JML	f:explode_bomb
; ---------------------------------------------------------------------------

loc_C44F65:
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#3
		BEQ	loc_C44F70
		JML	f:explode_bomb
; ---------------------------------------------------------------------------

loc_C44F70:
		LDA	z:$1C,X
		CMP	#3
		BCS	loc_C44F7A
		JML	f:explode_bomb
; ---------------------------------------------------------------------------

loc_C44F7A:
		LDA	a:.LOWORD(word_7E0CAE+1) ;	orig=0x0CAF
		BNE	loc_C44F83
		JML	f:explode_bomb
; ---------------------------------------------------------------------------

loc_C44F83:
		JSL	f:random2
		REP	#$20
.A16
		AND	#$FF
		CMP	#$AE
		BEQ	loc_C44F95
		JML	f:explode_bomb
; ---------------------------------------------------------------------------

loc_C44F95:
		DEC	a:.LOWORD(word_7E0CAE+1) ;	orig=0x0CAF
		PHX
		LDX	#$B
		JSL	f:random
		PLX
		REP	#$20
		CLC
		ADC	#5
		ASL
		ASL
		ASL
		ASL
		ASL
		ASL
		STA	z:$1E,X
		PHY
		LDY	#$F
		JSL	f:play_sound
		JSL	f:sub_C53976
		PLY

locret_C44FBC:
		RTL
; ---------------------------------------------------------------------------

loc_C44FBD:
		REP	#$20
		DEC	z:$1E,X
		LDA	z:$C,X
		BIT	#$10
		BEQ	locret_C44FBC
		STZ	z:$1E,X
		RTL
; END OF FUNCTION CHUNK	FOR sub_C44CB0
.A16
.I16

sub_C44FCB:
		REP	#$20
		LDA	z:$C,X
		AND	#$F
		STA	z:$42
		LDA	#$2E0
		STA	z:$44
		LDA	z:$C,X
		BIT	#$80
		BEQ	loc_C44FE5
		LDA	#$A0
		STA	z:$44

loc_C44FE5:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C44FEB:
		TYA
		CLC
		ADC	#$FFC0
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C44FFC
		STZ	z:$40
		INC	z:$40

loc_C44FFC:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C45016
		CMP	#$11D
		BEQ	loc_C45016
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C44FEB

loc_C45016:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C4501C:
		TYA
		CLC
		ADC	#2
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C4502D
		STZ	z:$40
		INC	z:$40

loc_C4502D:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C45047
		CMP	#$11F
		BEQ	loc_C45047
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C4501C

loc_C45047:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C4504D:
		TYA
		CLC
		ADC	#$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C4505E
		STZ	z:$40
		INC	z:$40

loc_C4505E:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C45078
		CMP	#$11C
		BEQ	loc_C45078
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C4504D

loc_C45078:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C4507E:
		TYA
		CLC
		ADC	#$FFFE
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C4508F
		STZ	z:$40
		INC	z:$40

loc_C4508F:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C450A9
		CMP	#$11E
		BEQ	loc_C450A9
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C4507E

loc_C450A9:
		REP	#$20
		LDY	z:$A,X
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		JSL	f:sub_C45110
		SEP	#$20
.A8
		LDA	z:$42
		STA	z:$11,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C450CA)
		STA	z:0,X

loc_C450CA:
		SEP	#$20
.A8
		LDA	z:$11,X
		STA	z:$42
		LDA	#$20
		STA	z:$48
		LDA	#.BANKBYTE(byte_C30488)
		STA	z:$52
		REP	#$20
.A16
		LDY	z:8,X
		LDA	a:.LOWORD($14),Y
		CLC
		ADC	z:$18,X
		CLC
		ADC	#8
		STA	z:$45
		CMP	#$100
		BCC	loc_C450F1
		JML	f:sub_C60B35
; ---------------------------------------------------------------------------

loc_C450F1:
		REP	#$20
		LDA	z:3,X
		AND	#$3F
		STA	z:$40
		LDA	z:$C,X
		AND	#$C0
		ORA	z:$40
		ASL
		PHX
		TAX
		LDA	f:off_C304BF,X
		STA	z:$50
		PLX
		JSL	f:sub_C6278B
		RTL
; End of function sub_C44FCB

.A16
.I16

sub_C45110:
		REP	#$20
		TYA
		PHA
		AND	#$1E
		ASL
		ASL
		ASL
		ORA	#8
		STA	z:$42
		PLA
		AND	#$3C0
		LSR
		LSR
		ORA	#8
		STA	z:$45
		RTL
; End of function sub_C45110

.A16
.I16

sudden_death_related:
		SEP	#$20
.A8
		BIT	#$10

loc_C4512F:
		BNE	loc_C45139
		LDA	#$20
		STA	a:.LOWORD(collision_map),Y
		JMP	a:.LOWORD(loc_C44DE6)
; ---------------------------------------------------------------------------

loc_C45139:
		CMP	#$32
		BCC	loc_C45141
		JML	f:loc_C451AB
; ---------------------------------------------------------------------------

loc_C45141:
		INC
		AND	#$2F
		STA	a:.LOWORD(collision_map),Y
		JSL	f:sub_C45110
		SEP	#$20
		LDA	z:$42
		STA	z:$11,X
		LDA	z:$45
		STA	z:$14,X
		STZ	z:$13,X
		STZ	z:$12,X
		LDA	z:$11,X

loc_C4515B:
		AND	#$F0
		ORA	#8
		STA	z:$11,X
		LDA	z:$14,X
		AND	#$F0
		ORA	#8
		STA	z:$14,X
		LDA	#.BANKBYTE(byte_C30488)
		STA	z:$52
		LDA	#$20
		STA	z:$48
		LDA	z:3,X
		BIT	#1
		BNE	loc_C45184
		INC	z:$42
		LDA	a:.LOWORD($917),Y
		AND	#$10
		BNE	loc_C45184
		DEC	z:$42
		INC	z:$45

loc_C45184:
		REP	#$20
.A16
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	z:3,X
		AND	#$3F
		STA	z:$40
		LDA	z:$C,X
		AND	#$C0
		ORA	z:$40
		ASL
		PHX
		TAX
		LDA	f:off_C304BF,X
		STA	z:$50
		PLX
		JSL	f:sub_C6278B
		JMP	a:.LOWORD(loc_C44E11)
; ---------------------------------------------------------------------------
.A8

loc_C451AB:
		PHY
		LDY	#7
		JSL	f:play_sound
		PLY
		SEP	#$20
		LDA	#$3F
		STA	a:.LOWORD(collision_map),Y
		REP	#$20
.A16
		LDA	z:8,X
		PHX
		TAX
		SEP	#$20
.A8
		LDA	z:$26,X
		BIT	#$50
		BEQ	loc_C451D5
		AND	#$BF
		STA	z:$26,X
		LDA	a:.LOWORD($917),Y
		ORA	#$70
		STA	a:.LOWORD($917),Y

loc_C451D5:
		PLX
		REP	#$20
.A16
		LDA	#.LOWORD(explosion_related+$10)
		STA	z:$DB
		SEP	#$20
.A8
		LDA	#.BANKBYTE(explosion_related+$10)
		STA	z:$DD
		REP	#$20
.A16
		LDA	#.LOWORD(explosion_related2)
		STA	z:$DE
		SEP	#$20
.A8
		LDA	#.BANKBYTE(explosion_related2)
		STA	z:$E0
		REP	#$20
.A16
		LDY	z:$A,X
		LDA	a:.LOWORD(collision_map),Y
		STA	z:$46
		LDA	a:.LOWORD(collision_map),Y
		STA	z:$48
		JSL	f:sub_C4539E
; End of function sudden_death_related

; START	OF FUNCTION CHUNK FOR sub_C44CB0

loc_C45202:
		REP	#$20
		LDA	z:$C,X
		BIT	#$10
		BEQ	loc_C4520F
		JML	f:loc_C45394
; ---------------------------------------------------------------------------

loc_C4520F:
		AND	#$F
		STA	z:$42
		LDA	#$2E0
		STA	z:$44
		LDA	z:$C,X
		BIT	#$80
		BNE	loc_C45224
		JML	f:loc_C45229
; ---------------------------------------------------------------------------

loc_C45224:
		LDA	#$A0
		STA	z:$44

loc_C45229:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C4522F:
		TYA
		CLC
		ADC	#$FFC0
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C45240
		STZ	z:$40
		INC	z:$40

loc_C45240:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C4525A
		CMP	#$11D
		BEQ	loc_C4525A
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C4522F

loc_C4525A:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C45260:
		TYA
		CLC
		ADC	#2
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C45271
		STZ	z:$40
		INC	z:$40

loc_C45271:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C4528B
		CMP	#$11F
		BEQ	loc_C4528B
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C45260

loc_C4528B:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C45291:
		TYA
		CLC
		ADC	#$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C452A2
		STZ	z:$40
		INC	z:$40

loc_C452A2:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C452BC
		CMP	#$11C
		BEQ	loc_C452BC
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C45291

loc_C452BC:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C452C2:
		TYA
		CLC
		ADC	#$FFFE
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C452D3
		STZ	z:$40
		INC	z:$40

loc_C452D3:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C452ED
		CMP	#$11E
		BEQ	loc_C452ED
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C452C2

loc_C452ED:
		REP	#$20
		LDA	z:$47
		AND	#$70
		CMP	#$70
		BEQ	loc_C4533B
		LSR
		LSR
		TAY
		PHY
		LDA	[$DE],Y
		STA	z:$42
		INY
		INY
		LDA	[$DE],Y
		STA	z:$43
		JSL	f:sub_C453AB
		LDA	a:.LOWORD(collision_map),Y
		PLY
		BIT	#$82E0
		BNE	loc_C4533B
		LDA	z:$10,X
		ADC	[$DB],Y
		STA	z:$10,X
		INY
		INY
		LDA	z:$13,X
		CLC
		ADC	[$DB],Y
		STA	z:$13,X
		DEY
		DEY
		LDA	[$DE],Y
		STA	z:$42
		INY
		INY
		LDA	[$DE],Y
		STA	z:$43
		JSL	f:sub_C453AB
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$82E0
		BEQ	loc_C45354

loc_C4533B:
		LDA	#$820
		STA	z:$48
		SEP	#$20
.A8
		LDA	z:$11,X
		AND	#$F0
		ORA	#8
		STA	z:$11,X
		LDA	z:$14,X
		AND	#$F0
		ORA	#8
		STA	z:$14,X
		REP	#$20
.A16

loc_C45354:
		STZ	z:$42
		JSL	f:sub_C453AB
		STY	z:$A,X
		LDA	z:$48
		STA	a:.LOWORD(collision_map),Y

loc_C45361:
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_C30488)
		STA	z:$52
		LDA	#$20
		STA	z:$48
		LDA	z:$11,X
		STA	z:$42
		LDA	z:$14,X
		STA	z:$45
		REP	#$20
.A16
		LDA	z:3,X
		AND	#$3F
		STA	z:$40
		LDA	z:$C,X
		AND	#$C0
		ORA	z:$40
		ASL
		PHX
		TAX
		LDA	f:off_C304BF,X
		STA	z:$50
		PLX
		JSL	f:sub_C6278B
		JMP	a:.LOWORD(loc_C44E11)
; ---------------------------------------------------------------------------

loc_C45394:
		REP	#$20
		JMP	a:.LOWORD(loc_C45354)
; END OF FUNCTION CHUNK	FOR sub_C44CB0
; ---------------------------------------------------------------------------
		JMP	a:.LOWORD(loc_C45361)
; ---------------------------------------------------------------------------
		REP	#$20
.A16
.I16

sub_C4539E:
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		RTL
; End of function sub_C4539E

.A16
.I16

sub_C453AB:
		REP	#$20
		LDA	z:$11,X
		CLC
		ADC	z:$42
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$40
		LDA	z:$14,X
		CLC
		ADC	z:$43
		AND	#$F0
		ASL
		ASL
		ADC	z:$40
		TAY
		RTL
; End of function sub_C453AB

.A16
.I16

sub_C453C8:
		REP	#$20
		LDA	z:$C,X
		AND	#$F
		STA	z:$42
		LDA	#$2E0
		STA	z:$44
		LDA	z:$C,X
		BIT	#$80
		BEQ	loc_C453E2
		LDA	#$A0
		STA	z:$44

loc_C453E2:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C453E8:
		TYA
		CLC
		ADC	#$FFC0
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C453F9
		STZ	z:$40
		INC	z:$40

loc_C453F9:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C45413
		CMP	#$11D
		BEQ	loc_C45413
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C453E8

loc_C45413:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C45419:
		TYA
		CLC
		ADC	#2
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C4542A
		STZ	z:$40
		INC	z:$40

loc_C4542A:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C45444
		CMP	#$11F
		BEQ	loc_C45444
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C45419

loc_C45444:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C4544A:
		TYA
		CLC
		ADC	#$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C4545B
		STZ	z:$40
		INC	z:$40

loc_C4545B:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C45475
		CMP	#$11C
		BEQ	loc_C45475
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C4544A

loc_C45475:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C4547B:
		TYA
		CLC
		ADC	#$FFFE
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C4548C
		STZ	z:$40
		INC	z:$40

loc_C4548C:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C454A6
		CMP	#$11E
		BEQ	loc_C454A6
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C4547B

loc_C454A6:
		LDY	z:$A,X
		JSL	f:sub_C4539E
		JSL	f:sub_C4576B
		JSL	f:sub_C60B35
		RTL
; End of function sub_C453C8

.A16
.I16

punching_glove_related:
		REP	#$20
		LDA	z:$C,X
		AND	#$F
		STA	z:$42
		LDA	#$2E0
		STA	z:$44
		LDA	z:$C,X
		BIT	#$80
		BEQ	loc_C454CF
		LDA	#$A0
		STA	z:$44

loc_C454CF:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C454D5:
		TYA
		CLC
		ADC	#$FFC0
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C454E6
		STZ	z:$40
		INC	z:$40

loc_C454E6:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C45500
		CMP	#$11D
		BEQ	loc_C45500
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C454D5

loc_C45500:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C45506:
		TYA
		CLC
		ADC	#2
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C45517
		STZ	z:$40
		INC	z:$40

loc_C45517:
		AND	#$1FF
		CMP	#$11B
		BEQ	loc_C45531
		CMP	#$11F
		BEQ	loc_C45531
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C45506

loc_C45531:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C45537:
		TYA
		CLC
		ADC	#$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C45548
		STZ	z:$40
		INC	z:$40

loc_C45548:
		AND	#$1FF
		CMP	#$1B|$100
		BEQ	loc_C45562
		CMP	#$11C
		BEQ	loc_C45562
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C45537

loc_C45562:
		LDY	z:$A,X
		LDA	z:$42
		STA	z:$40

loc_C45568:
		TYA
		CLC
		ADC	#$FFFE
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	z:$44
		BEQ	loc_C45579
		STZ	z:$40
		INC	z:$40

loc_C45579:
		AND	#$1FF
		CMP	#$1B|$100
		BEQ	loc_C45593
		CMP	#$1E|$100
		BEQ	loc_C45593
		LDA	a:.LOWORD(collision_map),Y
		AND	#$F7FF
		STA	a:.LOWORD(collision_map),Y
		DEC	z:$40
		BNE	loc_C45568

loc_C45593:
		SEP	#$20
.A8
		STZ	z:$F,X
		LDY	z:$A,X
		LDA	a:.LOWORD(collision_map+1),Y
		AND	#$30
		LSR
		STA	z:$E,X
		REP	#$20
.A16
		AND	#$18
		PHX
		TAX
		LDA	f:byte_C3075F,X
		STA	z:$DB
		PLX
		LDA	z:$DB
		STA	z:$16,X
		JSL	f:sub_C4539E
		JSL	f:sub_C45110
		SEP	#$20
.A8
		LDA	z:$42
		STA	z:$11,X
		LDA	z:$45
		STA	z:$14,X
		STZ	z:$13,X
		STZ	z:$12,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C455EA)
		STA	z:0,X
		LDY	#8
		JSL	f:play_sound
		SEP	#$20
.A8
		LDY	z:8,X
		CPY	#$E40
		BCS	loc_C455EA
		LDA	a:.LOWORD(7),Y
		BEQ	loc_C455EA
		ORA	#$80
		STA	a:.LOWORD(7),Y

loc_C455EA:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C455F7
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C455F7:
		BIT	#$41
		BEQ	loc_C455FF
		JML	f:loc_C4569E
; ---------------------------------------------------------------------------

loc_C455FF:
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
		LDA	z:$E,X
		AND	#$38
		TAY
		SEP	#$20
.A8
		LDA	z:$F,X
		AND	#$3F
		CMP	[$DE],Y
		BEQ	loc_C4562F
		JML	f:loc_C45674
; ---------------------------------------------------------------------------

loc_C4562F:
		REP	#$20
.A16
		STZ	z:$42
		JSL	f:sub_C453AB
		REP	#$20
		LDA	a:.LOWORD(collision_map),Y
		AND	#$71FF
		BNE	loc_C45645
		JML	f:loc_C456EE
; ---------------------------------------------------------------------------

loc_C45645:
		PHY
		LDY	#4
		JSL	f:play_sound
		PLY
		SEP	#$20
.A8
		LDA	z:$E,X
		ORA	#$20
		STA	z:$E,X
		LDA	z:$11,X
		AND	#$F0
		ORA	#8
		STA	z:$11,X
		LDA	z:$14,X
		AND	#$F0
		ORA	#8
		STA	z:$14,X
		STZ	z:$F,X
		REP	#$20
.A16
		LDA	z:$E,X
		AND	#$38
		TAY
		LDA	[$DB],Y
		STA	z:$16,X
.A8

loc_C45674:
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
		BCS	locret_C456ED
		REP	#$20
		INY
		INY
		STZ	z:$42
		LDA	[$DB],Y
		BPL	loc_C45699
		DEC	z:$42

loc_C45699:
		CLC
		ADC	z:$10,X
		STA	z:$10,X
.A8

loc_C4569E:
		SEP	#$20
		LDA	#.BANKBYTE(byte_C30488)
		STA	z:$52
		LDA	#$30
		STA	z:$48
		LDA	z:$11,X
		STA	z:$42
		LDA	z:$12,X
		STA	z:$43
		LDA	z:$14,X
		STA	z:$45
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C456C1
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C456C1:
		BIT	#$41
		BEQ	loc_C456C9
		JML	f:loc_C456D3
; ---------------------------------------------------------------------------

loc_C456C9:
		SEP	#$20
		INC	z:$F,X
		LDA	z:$F,X
		AND	#$3F
		STA	z:$F,X

loc_C456D3:
		REP	#$20
.A16
		LDA	z:$C,X
		AND	#$C0
		ORA	z:$F,X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:off_C304BF,X
		STA	z:$50
		PLX
		JSL	f:sub_C6278B

locret_C456ED:
		RTL
; ---------------------------------------------------------------------------

loc_C456EE:
		PHY
		LDY	#4
		JSL	f:play_sound
		SEP	#$20
.A8
		LDY	z:8,X
		CPY	#$E40
		BCS	loc_C45709
		LDA	a:.LOWORD(7),Y
		BEQ	loc_C45709
		AND	#1
		STA	a:.LOWORD(7),Y

loc_C45709:
		LDA	z:$11,X
		AND	#$F0
		ORA	#8
		STA	z:$11,X
		LDA	z:$14,X
		AND	#$F0
		ORA	#8
		STA	z:$14,X
		REP	#$20
.A16
		PLY
		STY	z:$A,X
		LDA	#$A3F
		STA	a:.LOWORD(collision_map),Y
		REP	#$20
		LDA	#.LOWORD(sub_C44D98)
		STA	z:0,X
		JMP	a:.LOWORD(loc_C44DE6)
; End of function punching_glove_related

.A16
.I16

sub_C4572E:
		REP	#$20
		STZ	z:$42
		LDA	z:$16,X
		CLC
		ADC	z:$40
		STA	z:$16,X
		BPL	loc_C4573D
		DEC	z:$42

loc_C4573D:
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		SEP	#$20
.A8
		LDA	z:$42
		ADC	z:$15,X
		STA	z:$15,X
		REP	#$20
.A16
		LDA	z:$14,X
		BPL	loc_C4575F
		CMP	#$FFFA
		BCS	loc_C4575D
		AND	#$F
		ORA	#$C0
		STA	z:$14,X

loc_C4575D:
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C4575F:
		CMP	#$D0
		BCC	loc_C45769
		AND	#$F
		STA	z:$14,X

loc_C45769:
		CLC
		RTL
; End of function sub_C4572E

.A16
.I16

sub_C4576B:
		SEP	#$20
.A8
		REP	#$20
.A16
		LDA	z:8,X
		PHX
		TAX
		SEP	#$20
.A8
		DEC	z:$24,X
		PLX
		LDY	z:8,X
		CPY	#$F40
		BCS	locret_C4579D
		LDA	a:.LOWORD(7),Y
		BEQ	locret_C4579D
		LDA	z:$C,X
		BIT	#$40
		BEQ	locret_C4579D
		PHX
		PHY
		LDA	z:8,X
		TAX
		STZ	z:$1C,X
		DEC	z:$1A,X
		LDA	z:$1A,X
		BEQ	loc_C4579B
		JSL	f:sub_C44911

loc_C4579B:
		PLY
		PLX

locret_C4579D:
		RTL
; End of function sub_C4576B

.A16
.I16

explode_bomb:
		REP	#$20
		LDY	z:$A,X

loc_C457A2:
		TYA
		CLC
		ADC	#$FFC0
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$80
		BNE	loc_C457C6
		AND	#$1FF
		CMP	#$11C
		BNE	loc_C457A2
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		BRA	loc_C457A2
; ---------------------------------------------------------------------------

loc_C457C6:
		LDY	z:$A,X

loc_C457C8:
		TYA
		CLC
		ADC	#2
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$80
		BNE	loc_C457EC
		AND	#$1FF
		CMP	#$11E
		BNE	loc_C457C8
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		BRA	loc_C457C8
; ---------------------------------------------------------------------------

loc_C457EC:
		LDY	z:$A,X

loc_C457EE:
		TYA
		CLC
		ADC	#$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$80
		BNE	loc_C45812
		AND	#$1FF
		CMP	#$11D
		BNE	loc_C457EE
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		BRA	loc_C457EE
; ---------------------------------------------------------------------------

loc_C45812:
		LDY	z:$A,X

loc_C45814:
		TYA
		CLC
		ADC	#$FFFE
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$80
		BNE	loc_C45838
		AND	#$1FF
		CMP	#$11F
		BNE	loc_C45814
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	#0
		STA	a:.LOWORD(collision_map),Y
		BRA	loc_C45814
; ---------------------------------------------------------------------------

loc_C45838:
		PHY
		LDY	#$15
		JSL	f:play_sound
		PLY
		JSL	f:sub_C4576B
		SEP	#$20
.A8
		LDA	#1
		STA	z:3,X
		LDA	z:$C,X
		STA	z:8,X
		STZ	z:9,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C45858)
		STA	z:0,X
loc_C45858:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C45865
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C45865:
		BIT	#$41
		BEQ	loc_C4586D
		JML	f:locret_C458A6
; ---------------------------------------------------------------------------

loc_C4586D:
		SEP	#$20
		DEC	z:3,X
		LDA	z:3,X
		BEQ	loc_C45879
		JML	f:sub_C45ADB
; ---------------------------------------------------------------------------

loc_C45879:
		LDA	#.BANKBYTE(explosion_animation)
		STA	z:$52
		REP	#$20
.A16
		LDA	z:9,X
		AND	#$FF
		ASL
		ASL
		CLC
		ADC	#.LOWORD(explosion_animation)
		STA	z:$50
		LDA	[$50]
		INC	z:$50
		INC	z:$50
		SEP	#$20
.A8
		STA	z:3,X
		JSL	f:sub_C458B0
		INC	z:9,X
		LDA	z:9,X
		CMP	#$B
		BNE	locret_C458A6
		JSL	f:sub_C60B35

locret_C458A6:
		RTL
; End of function explode_bomb

.A16
.I16

sub_C458A7:
		REP	#$20
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$80
		RTL
; End of function sub_C458A7

.A8
.I16

sub_C458B0:
		SEP	#$20
		LDY	z:$A,X
		LDA	z:9,X
		CMP	#$A
		BNE	loc_C458BE
		JML	f:loc_C45A00
; ---------------------------------------------------------------------------

loc_C458BE:
		REP	#$20
.A16
		LDA	[$50]
		STA	z:$50
		JSL	f:sub_C458A7
		BNE	loc_C458D5
		LDA	[$50]
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	#$1B|$100
		STA	a:.LOWORD(collision_map),Y

loc_C458D5:
		SEP	#$20
.A8
		LDA	z:2,X
		STA	z:$45
		LDA	#$1C
		STA	z:$44
		REP	#$20
.A16
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	z:$46
		LDY	#8
		LDA	[$50],Y
		STA	z:$48
		LDA	z:8,X
		AND	#$F
		STA	z:$40
		LDY	z:$A,X

loc_C458F9:
		TYA
		CLC
		ADC	#$FFC0
		TAY
		LDA	a:.LOWORD(collision_map),Y
		JSR	a:.LOWORD(.LOWORD(sub_C45BDA))
		BCC	loc_C45922
		BNE	loc_C4591E
		LDA	z:$44
		STA	a:.LOWORD(collision_map),Y
		LDA	z:$46
		STA	a:.LOWORD(bg1_tilemap),Y
		DEC	z:$40
		BNE	loc_C458F9
		LDA	z:$48
		STA	a:.LOWORD(bg1_tilemap),Y
		BRA	loc_C45922
; ---------------------------------------------------------------------------

loc_C4591E:
		DEC	z:$40
		BNE	loc_C458F9

loc_C45922:
		SEP	#$20
.A8
		LDA	#$1E
		STA	z:$44
		REP	#$20
.A16
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	z:$46
		LDY	#8
		LDA	[$50],Y
		STA	z:$48
		LDA	z:8,X
		AND	#$F
		STA	z:$40
		LDY	z:$A,X

loc_C45942:
		TYA
		CLC
		ADC	#2
		TAY
		LDA	a:.LOWORD(collision_map),Y
		JSR	a:.LOWORD(.LOWORD(sub_C45BDA))
		BCC	loc_C4596B
		BNE	loc_C45967
		LDA	z:$44
		STA	a:.LOWORD(collision_map),Y
		LDA	z:$46
		STA	a:.LOWORD(bg1_tilemap),Y
		DEC	z:$40
		BNE	loc_C45942
		LDA	z:$48
		STA	a:.LOWORD(bg1_tilemap),Y
		BRA	loc_C4596B
; ---------------------------------------------------------------------------

loc_C45967:
		DEC	z:$40
		BNE	loc_C45942

loc_C4596B:
		SEP	#$20
.A8
		LDA	#$1D
		STA	z:$44
		REP	#$20
.A16
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	z:$46
		LDY	#8
		LDA	[$50],Y
		STA	z:$48
		LDA	z:8,X
		AND	#$F
		STA	z:$40
		LDY	z:$A,X

loc_C4598B:
		TYA
		CLC
		ADC	#$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		JSR	a:.LOWORD(.LOWORD(sub_C45BDA))
		BCC	loc_C459B4
		BNE	loc_C459B0
		LDA	z:$44
		STA	a:.LOWORD(collision_map),Y
		LDA	z:$46
		STA	a:.LOWORD(bg1_tilemap),Y
		DEC	z:$40
		BNE	loc_C4598B
		LDA	z:$48
		STA	a:.LOWORD(bg1_tilemap),Y
		BRA	loc_C459B4
; ---------------------------------------------------------------------------

loc_C459B0:
		DEC	z:$40
		BNE	loc_C4598B

loc_C459B4:
		SEP	#$20
.A8
		LDA	#$1F
		STA	z:$44
		REP	#$20
.A16
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	z:$46
		LDY	#8
		LDA	[$50],Y
		STA	z:$48
		LDA	z:8,X
		AND	#$F
		STA	z:$40
		LDY	z:$A,X

loc_C459D4:
		TYA
		CLC
		ADC	#$FFFE
		TAY
		LDA	a:.LOWORD(collision_map),Y
		JSR	a:.LOWORD(.LOWORD(sub_C45BDA))
		BCC	loc_C459FD
		BNE	loc_C459F9
		LDA	z:$44
		STA	a:.LOWORD(collision_map),Y
		LDA	z:$46
		STA	a:.LOWORD(bg1_tilemap),Y
		DEC	z:$40
		BNE	loc_C459D4
		LDA	z:$48
		STA	a:.LOWORD(bg1_tilemap),Y
		BRA	loc_C459FD
; ---------------------------------------------------------------------------

loc_C459F9:
		DEC	z:$40
		BNE	loc_C459D4

loc_C459FD:
		SEP	#$20
.A8
		RTL
; ---------------------------------------------------------------------------

loc_C45A00:
		JSL	f:sub_C458A7
		BNE	loc_C45A14
		REP	#$20
.A16
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	#0
		STA	a:.LOWORD(collision_map),Y

loc_C45A14:
		SEP	#$20
.A8
		LDA	#$1C
		STA	z:$44
		REP	#$20
.A16
		LDA	z:8,X
		AND	#$F
		STA	z:$40
		LDY	z:$A,X

loc_C45A25:
		TYA
		CLC
		ADC	#$FFC0
		TAY
		LDA	a:.LOWORD(collision_map),Y
		JSR	a:.LOWORD(.LOWORD(sub_C45BDA))
		BCC	loc_C45A45
		BNE	loc_C45A41
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	#0
		STA	a:.LOWORD(collision_map),Y

loc_C45A41:
		DEC	z:$40
		BNE	loc_C45A25

loc_C45A45:
		SEP	#$20
.A8
		LDA	#$1E
		STA	z:$44
		REP	#$20
.A16
		LDA	z:8,X
		AND	#$F
		STA	z:$40
		LDY	z:$A,X

loc_C45A56:
		TYA
		CLC
		ADC	#2
		TAY
		LDA	a:.LOWORD(collision_map),Y
		JSR	a:.LOWORD(.LOWORD(sub_C45BDA))
		BCC	loc_C45A76
		BNE	loc_C45A72
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	#0
		STA	a:.LOWORD(collision_map),Y

loc_C45A72:
		DEC	z:$40
		BNE	loc_C45A56

loc_C45A76:
		SEP	#$20
.A8
		LDA	#$1D
		STA	z:$44
		REP	#$20
.A16
		LDA	z:8,X
		AND	#$F
		STA	z:$40
		LDY	z:$A,X

loc_C45A87:
		TYA
		CLC
		ADC	#$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		JSR	a:.LOWORD(.LOWORD(sub_C45BDA))
		BCC	loc_C45AA7
		BNE	loc_C45AA3
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	#0
		STA	a:.LOWORD(collision_map),Y

loc_C45AA3:
		DEC	z:$40
		BNE	loc_C45A87

loc_C45AA7:
		SEP	#$20
.A8
		LDA	#$1F
		STA	z:$44
		REP	#$20
.A16
		LDA	z:8,X
		AND	#$F
		STA	z:$40
		LDY	z:$A,X

loc_C45AB8:
		TYA
		CLC
		ADC	#$FFFE
		TAY
		LDA	a:.LOWORD(collision_map),Y
		JSR	a:.LOWORD(.LOWORD(sub_C45BDA))
		BCC	loc_C45AD8
		BNE	loc_C45AD4
		LDA	a:.LOWORD(bg1_tilemap+$20),Y
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	#0
		STA	a:.LOWORD(collision_map),Y

loc_C45AD4:
		DEC	z:$40
		BNE	loc_C45AB8

loc_C45AD8:
		SEP	#$20
.A8
		RTL
; End of function sub_C458B0

.A8
.I16

sub_C45ADB:
		REP	#$20
.A16
		LDY	z:$A,X
		JSL	f:sub_C458A7
		BNE	loc_C45AEB
		LDA	#$11B
		STA	a:.LOWORD(collision_map),Y

loc_C45AEB:
		SEP	#$20
.A8
		LDA	z:2,X
		STA	z:$45
		LDA	#$1C
		STA	z:$44
		REP	#$20
.A16
		LDA	z:8,X
		AND	#$F
		STA	z:$40
		LDY	z:$A,X

loc_C45B00:
		TYA
		CLC
		ADC	#$FFC0
		TAY
		LDA	a:.LOWORD(collision_map),Y
		JSR	a:.LOWORD(.LOWORD(sub_C45BDA))
		BCC	loc_C45B19
		BNE	loc_C45B15
		LDA	z:$44
		STA	a:.LOWORD(collision_map),Y

loc_C45B15:
		DEC	z:$40
		BNE	loc_C45B00

loc_C45B19:
		SEP	#$20
.A8
		LDA	#$1E
		STA	z:$44
		REP	#$20
.A16
		LDA	z:8,X
		AND	#$F
		STA	z:$40
		LDY	z:$A,X

loc_C45B2A:
		TYA
		CLC
		ADC	#2
		TAY
		LDA	a:.LOWORD(collision_map),Y
		JSR	a:.LOWORD(.LOWORD(sub_C45BDA))
		BCC	loc_C45B43
		BNE	loc_C45B3F
		LDA	z:$44
		STA	a:.LOWORD(collision_map),Y

loc_C45B3F:
		DEC	z:$40
		BNE	loc_C45B2A

loc_C45B43:
		SEP	#$20
.A8
		LDA	#$1D
		STA	z:$44
		REP	#$20
.A16
		LDA	z:8,X
		AND	#$F
		STA	z:$40
		LDY	z:$A,X

loc_C45B54:
		TYA
		CLC
		ADC	#$40
		TAY
		LDA	a:.LOWORD(collision_map),Y
		JSR	a:.LOWORD(.LOWORD(sub_C45BDA))
		BCC	loc_C45B6D
		BNE	loc_C45B69
		LDA	z:$44
		STA	a:.LOWORD(collision_map),Y

loc_C45B69:
		DEC	z:$40
		BNE	loc_C45B54

loc_C45B6D:
		SEP	#$20
.A8
		LDA	#$1F
		STA	z:$44
		REP	#$20
.A16
		LDA	z:8,X
		AND	#$F
		STA	z:$40
		LDY	z:$A,X

loc_C45B7E:
		TYA
		CLC
		ADC	#$FFFE
		TAY
		LDA	a:.LOWORD(collision_map),Y
		JSR	a:.LOWORD(.LOWORD(sub_C45BDA))
		BCC	loc_C45B97
		BNE	loc_C45B93
		LDA	z:$44
		STA	a:.LOWORD(collision_map),Y

loc_C45B93:
		DEC	z:$40
		BNE	loc_C45B7E

loc_C45B97:
		SEP	#$20
.A8
		RTL
; End of function sub_C45ADB

.A16
.I16

sub_C45B9A:
		REP	#$20
		STY	z:$56
		LDY	#$1C80

loc_C45BA1:
		LDA	a:.LOWORD($C),Y
		BIT	#$10
		BNE	loc_C45BD0
		LDA	a:.LOWORD($A),Y
		CMP	z:$56
		BNE	loc_C45BD0
		SEP	#$20
.A8
		LDA	#8
		STA	a:.LOWORD(3),Y
		LDA	a:.LOWORD($C),Y
		ORA	#$10
		STA	a:.LOWORD($C),Y
		LDA	z:2,X
		EOR	a:.LOWORD(2),Y
		AND	#4
		BNE	loc_C45BCD
		LDA	z:2,X
		STA	a:.LOWORD(2),Y

loc_C45BCD:
		REP	#$20
.A16
		RTL
; ---------------------------------------------------------------------------

loc_C45BD0:
		LDA	a:.LOWORD(6),Y
		TAY
		INC
		BNE	loc_C45BA1
		RTL
; End of function sub_C45B9A

; ---------------------------------------------------------------------------
		REP	#$20
.A16
.I16

sub_C45BDA:
		BIT	#$1FF
		BEQ	loc_C45C34
		CMP	#$580
		BEQ	loc_C45C36
		BIT	#$20
		BNE	loc_C45C5C
		BIT	#$40
		BNE	loc_C45C62
		BIT	#$80
		BNE	loc_C45C32
		BIT	#$100
		BNE	loc_C45C3B
		LDA	z:9,X
		AND	#$FF
		BEQ	loc_C45C29
		LDA	a:.LOWORD(collision_map),Y
		AND	#$1F
		CMP	#$10
		BNE	loc_C45C0E
		JML	f:loc_C45C92
; ---------------------------------------------------------------------------

loc_C45C0E:
		CMP	#$1F
		BEQ	loc_C45C29
		LDA	#$21F
		STA	a:.LOWORD(collision_map),Y
		LDA	#$20
		STA	z:$4A
		LDA	#0
		STA	z:$42
		JSL	f:sub_C42517
		REP	#$20

loc_C45C29:
		LDA	z:8,X
		BIT	#$80
		BEQ	loc_C45C32
		SEC
		RTS
; ---------------------------------------------------------------------------

loc_C45C32:
		CLC
		RTS
; ---------------------------------------------------------------------------

loc_C45C34:
		SEC
		RTS
; ---------------------------------------------------------------------------

loc_C45C36:
		LDA	#$FF
		SEC
		RTS
; ---------------------------------------------------------------------------

loc_C45C3B:
		SEP	#$20
.A8
		LDA	a:.LOWORD(collision_map),Y
		CMP	#$1B
		BEQ	loc_C45C51
		EOR	#1
		CMP	z:$44
		BEQ	loc_C45C51
		REP	#$20
.A16
		LDA	#0
		SEC
		RTS
; ---------------------------------------------------------------------------

loc_C45C51:
		REP	#$20
		CLC
		RTS
; ---------------------------------------------------------------------------
		REP	#$20
		LDA	#$FF
		SEC
		RTS
; ---------------------------------------------------------------------------

loc_C45C5C:
		JSL	f:sub_C45B9A
		CLC
		RTS
; ---------------------------------------------------------------------------

loc_C45C62:
		LDA	z:9,X
		AND	#$FF
		BEQ	loc_C45C87
		LDA	a:.LOWORD(collision_map),Y
		AND	#$1F
		CMP	#$1F
		BEQ	loc_C45C87
		STA	z:$42
		LDA	#0
		STA	z:$4A
		LDA	#$5F
		STA	a:.LOWORD(collision_map),Y
		JSL	f:sub_C42517
		REP	#$20

loc_C45C87:
		LDA	z:8,X
		BIT	#$80
		BEQ	loc_C45C90
		SEC
		RTS
; ---------------------------------------------------------------------------

loc_C45C90:
		CLC
		RTS
; ---------------------------------------------------------------------------

loc_C45C92:
		REP	#$20
		LDA	#.LOWORD(unk_7F06AE)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7F06AE)
		STA	z:$61
		REP	#$20
.A16
		LDA	z:$40
		PHA
		LDA	z:$46
		PHA
		LDA	z:$48
		PHA
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#4
		BNE	loc_C45D2C

loc_C45CB2:
		INC	z:$5F
		INC	z:$5F
		LDA	[$5F]
		BEQ	loc_C45D2C
		STA	z:$53
		INC	z:$5F
		LDA	[$5F]
		BIT	#$1000
		BEQ	loc_C45CB2
		TYA
		AND	#$1E
		ASL
		ASL
		ASL
		ORA	#8
		STA	z:$40
		TYA
		AND	#$3C0
		LSR
		LSR
		ORA	#8
		STA	z:$42
		PHY
		JSL	f:sub_C45D39
		REP	#$20
		PLY
		BCS	loc_C45D2C
		LDA	[$5F]
		AND	#$EFFF
		STA	[$5F]
		STA	z:$54
		DEC	z:$5F
		INC	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		STZ	z:$48
		PHY
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
		JSL	f:random2
		SEP	#$20
.A8
		AND	#3
		STA	a:.LOWORD($20),Y
		LDA	#$FF
		STA	a:.LOWORD($1B),Y
		REP	#$20
.A16
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
		PLY

loc_C45D2C:
		PLA
		STA	z:$48
		PLA
		STA	z:$46
		PLA
		STA	z:$40
		JMP	a:.LOWORD(loc_C45C29)
; End of function sub_C45BDA

; ---------------------------------------------------------------------------
		RTL
.A16
.I16

sub_C45D39:
		LDY	#$F40

loc_C45D3C:
		SEP	#$20
.A8
		LDA	a:.LOWORD(3),Y
		BIT	#1
		BEQ	loc_C45D65
		LDA	a:.LOWORD($11),Y
		SEC
		SBC	z:$40
		BCS	loc_C45D50
		EOR	#$FF
		INC

loc_C45D50:
		CMP	#$10
		BCS	loc_C45D65
		LDA	a:.LOWORD($14),Y
		SEC
		SBC	z:$42
		BCS	loc_C45D5F
		EOR	#$FF
		INC

loc_C45D5F:
		CMP	#$10
		BCS	loc_C45D65
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C45D65:
		REP	#$20
.A16
		LDA	a:.LOWORD(6),Y
		TAY
		CMP	#$FFFF
		BNE	loc_C45D3C
		CLC
		RTL
; End of function sub_C45D39

.A16
.I16

sub_C45D72:
		REP	#$20

loc_C45D74:
		LDX	#8
		REP	#$20
		LDA	z:$44
		PHA
		LDA	z:$46
		PHA
		LDA	z:$48
		PHA
		PHY
		JSL	f:random
		PLY
		REP	#$20
		AND	#$FF
		STA	z:$40
		PLA
		STA	z:$48
		PLA
		STA	z:$46
		PLA
		STA	z:$44
		LDA	z:$40
		BIT	#4
		BEQ	loc_C45DA3
		EOR	#$FFFB
		INC

loc_C45DA3:
		ASL
		ASL
		ASL
		ASL
		STA	z:$42
		CLC
		ADC	z:$44
		AND	#$F0
		ORA	#8
		RTL
; End of function sub_C45D72

.A16
.I16

sub_C45DB3:
		REP	#$20
		PHX
		LDA	#0
		STA	z:$46
		LDA	a:.LOWORD($11),Y
		STA	z:$44
		JSL	f:loc_C45D74
		STA	a:.LOWORD($16),Y
		LDA	z:$42
		ASL
		ASL
		ASL
		STA	a:.LOWORD($1A),Y

loc_C45DCF:
		LDA	z:$46
		INC	z:$46
		CMP	z:$48
		BEQ	loc_C45E12
		LDA	a:.LOWORD($14),Y
		STA	z:$44
		JSL	f:loc_C45D74
		BMI	loc_C45DCF
		CMP	#$10
		BCC	loc_C45DCF
		CMP	#$B9
		BCS	loc_C45DCF
		SEP	#$20
.A8
		STA	a:.LOWORD($17),Y
		LDA	#.BANKBYTE(byte_C30488)
		STA	z:$52
		REP	#$20
.A16
		LDA	z:$40
		ASL
		ASL
		CLC
		ADC	#.LOWORD(word_C3073F)
		STA	z:$50
		LDA	[$50]
		STA	a:.LOWORD($1C),Y
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD($18),Y
		PLX
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C45E12:
		PLX
		SEC
		RTL
; End of function sub_C45DB3

.A16
.I16

sub_C45E15:
		REP	#$20
		LDA	#.LOWORD(sub_C45E5B)
		STA	z:$40
		JSL	f:sub_C60AC0
		BCC	loc_C45E26
		JML	f:loc_C45E56
; ---------------------------------------------------------------------------

loc_C45E26:
		SEP	#$20
.A8
		LDA	#$81
		STA	a:.LOWORD(2),Y
		LDA	#$78
		STA	a:.LOWORD(3),Y
		LDA	#$A
		STA	a:.LOWORD($C),Y
		LDA	#$20
		STA	a:.LOWORD($1E),Y
		REP	#$20
.A16
		TXA
		STA	a:.LOWORD(8),Y
		LDA	z:$11,X
		STA	a:.LOWORD($11),Y
		LDA	z:$14,X
		STA	a:.LOWORD($14),Y
		LDA	#$FFFF
		STA	z:$48
		JSL	f:sub_C45DB3
		RTL
; ---------------------------------------------------------------------------

loc_C45E56:
		SEP	#$20
.A8
		DEC	z:$24,X
		RTL
; End of function sub_C45E15

.A8
.I16

sub_C45E5B:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C45E68
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C45E68:
		BIT	#$41
		BEQ	loc_C45E70
		JML	f:loc_C45ECC
; ---------------------------------------------------------------------------

loc_C45E70:
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
		BPL	loc_C45E86
		DEC	z:$42

loc_C45E86:
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		SEP	#$20
.A8
		LDA	z:$42
		ADC	z:$15,X
		STA	z:$15,X
		DEC	z:$1E,X
		BNE	loc_C45ECC
		LDA	z:$16,X
		STA	z:$11,X
		LDA	z:$17,X
		STA	z:$14,X
		STZ	z:$12,X
		STZ	z:$15,X
		LDA	#8
		STA	z:$E,X
		LDA	z:$1B,X
		BPL	loc_C45EAF
		LDA	#$18
		STA	z:$E,X

loc_C45EAF:
		LDA	z:$E,X
		STZ	z:$F,X
		REP	#$20
.A16
		AND	#$18
		PHX
		TAX
		LDA	f:byte_C3075F,X
		STA	z:$DB
		PLX
		LDA	z:$DB
		STA	z:$16,X
		REP	#$20
		LDA	#.LOWORD(loc_C455EA)
		STA	z:0,X
.A8

loc_C45ECC:
		SEP	#$20
		LDA	#.BANKBYTE(byte_C30488)
		STA	z:$52
		LDA	#$30
		STA	z:$48
		LDA	z:$11,X
		STA	z:$42
		LDA	z:$14,X
		STA	z:$45
		REP	#$20
.A16
		LDA	z:3,X
		AND	#$3F
		STA	z:$40
		LDA	z:$C,X
		AND	#$C0
		ORA	z:$40
		ASL
		PHX
		TAX
		LDA	f:off_C304BF+$200,X
		STA	z:$50
		PLX
		JSL	f:sub_C6278B
		RTL
; End of function sub_C45E5B

.A16
.I16

create_random_bomb_drop:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C45F1E)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C45F1E)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C45F1E)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	locret_C45F1D
		LDA	#$100
		STA	a:.LOWORD($20),Y
.A8

locret_C45F1D:
		RTL
; End of function create_random_bomb_drop

.A8
.I16

sub_C45F1E:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C45F2B
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C45F2B:
		BIT	#$41
		BEQ	loc_C45F33
		JML	f:locret_C45F1D
; ---------------------------------------------------------------------------

loc_C45F33:
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_10) ; orig=0x0D3A
		CMP	#$100
		BCS	loc_C45F41
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C45F41:
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#4
		BEQ	loc_C45F4D
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C45F4D:
		DEC	z:$20,X
		BNE	locret_C45F1D
		JSL	f:random2
		REP	#$20
		AND	#$FF
		CLC
		ADC	#$40
		STA	z:$20,X
		REP	#$20
		LDA	#.LOWORD(sub_C45F89)
		STA	z:$40
		JSL	f:sub_C60AC0
		BCC	loc_C45F71
		JML	f:locret_C44CAF
; ---------------------------------------------------------------------------

loc_C45F71:
		REP	#$20
		TXA
		STA	a:.LOWORD(8),Y
		SEP	#$20
.A8
		LDA	#$81
		STA	a:.LOWORD(2),Y
		LDA	#$78
		STA	a:.LOWORD(3),Y
		LDA	#1
		STA	a:.LOWORD($C),Y
		RTL
; End of function sub_C45F1E

.A8
.I16

sub_C45F89:
		REP	#$20
.A16
		PHX
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
		ORA	#8
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
		ORA	#8
		STA	z:$42
		REP	#$20
.A16
		PLA
		STA	z:$40
		PLX
		LDA	z:$40
		STA	z:$11,X
		LDA	#$FFF0
		STA	z:$14,X
		LDA	z:$42
		STA	z:$1A,X
		LDA	#0
		STA	z:$16,X
		REP	#$20
		LDA	#.LOWORD(loc_C45FD5)
		STA	z:0,X
loc_C45FD5:
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C45FE2
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C45FE2:
		BIT	#$41
		BEQ	loc_C45FEA
		JML	f:loc_C46059
; ---------------------------------------------------------------------------

loc_C45FEA:
		REP	#$20
.A16
		STZ	z:$42
		LDA	z:$16,X
		CLC
		ADC	#$80
		STA	z:$16,X
		BPL	loc_C45FFA
		DEC	z:$42

loc_C45FFA:
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		SEP	#$20
.A8
		LDA	z:$42
		ADC	z:$15,X
		STA	z:$15,X
		REP	#$20
.A16
		LDA	z:$14,X
		BPL	loc_C46011
		JML	f:loc_C46059
; ---------------------------------------------------------------------------

loc_C46011:
		LDA	z:$1A,X
		AND	#$FF
		CMP	z:$14,X
		BCC	loc_C4601E
		JML	f:loc_C46059
; ---------------------------------------------------------------------------

loc_C4601E:
		SEP	#$20
.A8
		LDA	z:$1A,X
		STA	z:$14,X
		STZ	z:$F,X
		LDA	#8
		STA	z:$42
		JSL	f:random2
		SEP	#$20
		AND	#3
		BEQ	loc_C4603C
		STA	z:$40

loc_C46036:
		ASL	z:$42
		DEC	z:$40
		BNE	loc_C46036

loc_C4603C:
		LDA	z:$42
		STA	z:$E,X
		REP	#$20
.A16
		AND	#$78
		PHX
		TAX
		LDA	f:byte_C3075F,X
		STA	z:$DB
		PLX
		LDA	z:$DB
		STA	z:$16,X
		REP	#$20
		LDA	#.LOWORD(loc_C455EA)
		STA	z:0,X

loc_C46059:
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_C30488)
		STA	z:$52
		LDA	#$30
		STA	z:$48
		LDA	z:$11,X
		STA	z:$42
		LDA	z:$14,X
		STA	z:$45
		REP	#$20
.A16
		LDA	z:3,X
		AND	#$3F
		STA	z:$40
		LDA	z:$C,X
		AND	#$C0
		ORA	z:$40
		ASL
		PHX
		TAX
		LDA	f:off_C304BF,X
		STA	z:$50
		PLX
		JSL	f:sub_C6278B
		RTL
; End of function sub_C45F89

; ---------------------------------------------------------------------------
animation_frame_C4608A:.BYTE 8
		frame_oam_tile 0, $10,	$2202, $20
		frame_oam_tile $F0, $10, $2002, $20
		frame_oam_tile $F8, 0,	$102, $20
		frame_oam_tile $F8, $F0, $2100, $20
		frame_oam_tile $F0, $F0, $2000, 0
		frame_oam_tile 0, $E8,	$1200, 0
		frame_oam_tile 0, $E0,	$200, 0
		frame_oam_tile $F0, $E0, 0, $20
animation_frame_C460B3:.BYTE 8
		frame_oam_tile 0, $10,	$2602, $20
		frame_oam_tile $F0, $10, $2402, $20
		frame_oam_tile 0, 0, $602, $20
		frame_oam_tile $F0, 0,	$402, $20
		frame_oam_tile 0, $F0,	$2600, $20
		frame_oam_tile $F0, $F0, $2400, $20
		frame_oam_tile 0, $E0,	$201, $20
		frame_oam_tile $F0, $E0, 1, $20
animation_frame_C460DC:.BYTE 8
		frame_oam_tile 0, $10,	$2203, $20
		frame_oam_tile $F0, $10, $2003, $20
		frame_oam_tile 0, 0, $203, $20
		frame_oam_tile $F0, 0,	3, $20
		frame_oam_tile 0, $F0,	$2201, $20
		frame_oam_tile $F0, $F0, $2001, $20
		frame_oam_tile 0, $E0,	$201, $20
		frame_oam_tile $F0, $E0, 1, $20
animation_frame_C46105:.BYTE 8
		frame_oam_tile 0, $10,	$2603, $20
		frame_oam_tile $F0, $10, $2403, $20
		frame_oam_tile 0, 0, $603, $20
		frame_oam_tile $F0, 0,	$403, $20
		frame_oam_tile 0, $F0,	$2601, $20
		frame_oam_tile $F0, $F0, $2401, $20
		frame_oam_tile 0, $E0,	$601, $20
		frame_oam_tile $F0, $E0, $401,	$20
animation_frame_C4612E:.BYTE $E
		frame_oam_tile 8, $18,	$3303, 0
		frame_oam_tile 0, $18,	$3203, 0
		frame_oam_tile $F8, $18, $3103, 0
		frame_oam_tile $F0, $18, $3003, 0
		frame_oam_tile 8, $10,	$2306, 0
		frame_oam_tile 0, $10,	$2206, 0
		frame_oam_tile $F8, $10, $2106, 0
		frame_oam_tile $F0, $10, $2006, 0
		frame_oam_tile 0, 0, $206, $20
		frame_oam_tile $F0, 0,	6, $20
		frame_oam_tile 0, $F0,	$2204, $20
		frame_oam_tile $F0, $F0, $2004, $20
		frame_oam_tile 0, $E0,	$204, $20
		frame_oam_tile $F0, $E0, 4, $20
animation_frame_C46175:.BYTE 8
		frame_oam_tile 0, $10,	$2607, $20
		frame_oam_tile $F0, $10, $2407, $20
		frame_oam_tile 0, 0, $606, $20
		frame_oam_tile $F0, 0,	$406, $20
		frame_oam_tile 0, $F0,	$2604, $20
		frame_oam_tile $F0, $F0, $2404, $20
		frame_oam_tile 0, $E0,	$604, $20
		frame_oam_tile $F0, $E0, $404,	$20
animation_frame_C4619E:.BYTE $C
		frame_oam_tile 8, 0, $307, 0
		frame_oam_tile 0, 0, $207, 0
		frame_oam_tile 0, 8, $2207, 0
		frame_oam_tile $F8, $10, $2107, $20
		frame_oam_tile $F8, 8,	$1107, 0
		frame_oam_tile $F8, 0,	$107, 0
		frame_oam_tile 0, $F0,	$2205, $20
		frame_oam_tile $F8, $F8, $3105, 0
		frame_oam_tile $F8, $F0, $2105, 0
		frame_oam_tile $F0, $F0, $2005, 0
		frame_oam_tile 0, $E0,	$205, $20
		frame_oam_tile $F0, $E0, 5, $20
animation_frame_C461DB:.BYTE 8
		frame_oam_tile 0, $10,	$2607, $20
		frame_oam_tile $F0, $10, $2407, $20
		frame_oam_tile 0, 0, $607, $20
		frame_oam_tile $F0, 0,	$407, $20
		frame_oam_tile 0, $F0,	$2605, $20
		frame_oam_tile $F0, $F0, $2405, $20
		frame_oam_tile 0, $E0,	$605, $20
		frame_oam_tile $F0, $E0, $405,	$20
animation_frame_C46204:.BYTE 2
		frame_oam_tile 0, $F8,	$2606, $20
		frame_oam_tile $F0, $F8, $2406, $20
animation_frame_C4620F:.BYTE $18
		frame_oam_tile $38, 8,	$1002, 0
		frame_oam_tile $38, 0,	2, 0
		frame_oam_tile $38, $F8, $3000, 0
		frame_oam_tile $28, 8,	$3106, 0
		frame_oam_tile $20, 8,	$3006, 0
		frame_oam_tile $20, $F8, $500,	$20
		frame_oam_tile $10, 8,	$302, 0
		frame_oam_tile $10, 0,	$3300, 0
		frame_oam_tile $10, $F8, $2300, 0
		frame_oam_tile 8, 8, $3307, 0
		frame_oam_tile 8, 0, $2307, 0
		frame_oam_tile 8, $F8,	$1307, 0
		frame_oam_tile $F8, 8,	$2007, 0
		frame_oam_tile $F0, 8,	7, 0
		frame_oam_tile $F8, 0,	$1007, 0
		frame_oam_tile $F0, 0,	$3005, 0
		frame_oam_tile $F8, $F8, $3306, 0
		frame_oam_tile $F0, $F8, $3206, 0
		frame_oam_tile $E0, 8,	$3106, 0
		frame_oam_tile $D8, 8,	$3006, 0
		frame_oam_tile $C8, 8,	$1700, 0
		frame_oam_tile $C0, 8,	$700, 0
		frame_oam_tile $D8, $F8, $500,	$20
		frame_oam_tile $C0, $F8, $300,	$20
byte_C46288:	.BYTE 1
		animation_frame animation_frame_C4608A, $FF
byte_C4628D:	.BYTE 1
		animation_frame animation_frame_C460B3, $FF
byte_C46292:	.BYTE 1
		animation_frame animation_frame_C460DC, $FF
byte_C46297:	.BYTE 1
		animation_frame animation_frame_C46105, $FF
byte_C4629C:	.BYTE 1
		animation_frame animation_frame_C4612E, $FF
byte_C462A1:	.BYTE 1
		animation_frame animation_frame_C46175, $FF
byte_C462A6:	.BYTE 1
		animation_frame animation_frame_C4619E, $FF
byte_C462AB:	.BYTE 1
		animation_frame animation_frame_C461DB, $FF
byte_C462B0:	.BYTE 1
		animation_frame animation_frame_C46204, $FF
byte_C462B5:	.BYTE 1
		animation_frame animation_frame_C4620F, $FF
.A8
.I16

sub_C462BA:
		REP	#$20
.A16
		LDA	#$5000
		STA	a:.LOWORD(unk_7E0E5C) ; orig=0x0E5C
		LDA	#0
		STA	a:.LOWORD(unk_7E0E5A) ; orig=0x0E5A
		LDA	#$5000
		STA	a:.LOWORD(unk_7E0E9C) ; orig=0x0E9C
		LDA	#0
		STA	a:.LOWORD(unk_7E0E9A) ; orig=0x0E9A
		SEP	#$20
.A8
		PHX
		LDX	#$D40
		STZ	z:6,X
		STZ	z:7,X
		STZ	z:5,X
		LDA	#$20
		STA	z:$E,X
		STZ	z:$1F,X
		REP	#$20
.A16
		STZ	z:$1A,X
		STZ	z:$1C,X
		JSL	f:sub_C4774A
		SEP	#$20
.A8
		LDX	#$D80
		STZ	z:6,X
		STZ	z:7,X
		LDA	#1
		STA	z:5,X
		LDA	#$20
		STA	z:$E,X
		LDA	#2
		STA	z:$1F,X
		REP	#$20
.A16
		STZ	z:$1A,X
		STZ	z:$1C,X
		JSL	f:sub_C4774A
		SEP	#$20
.A8
		LDX	#$DC0
		STZ	z:6,X
		LDA	#2
		STA	z:5,X
		LDA	#$20
		STA	z:$E,X
		LDA	#$A
		STA	z:$1F,X
		JSL	f:sub_C4774A
		SEP	#$20
		LDX	#$E00
		STZ	z:6,X
		LDA	#3
		STA	z:5,X
		LDA	#$20
		STA	z:$E,X
		LDA	#8
		STA	z:$1F,X
		JSL	f:sub_C4774A
		PLX
		RTL
; End of function sub_C462BA

.A8
.I16

sub_C4633F:
		JSL	f:stage_related_init
		JSL	f:sub_C462BA
		SEP	#$20
		LDA	#$31
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		LDA	#$31
		STA	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		STZ	a:.LOWORD(game_flags) ; orig=0x0314
		JMP	a:.LOWORD(loc_C46896)
; ---------------------------------------------------------------------------

loc_C46359:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$41
		BEQ	loc_C46365
		JMP	a:.LOWORD(locret_C463DD)
; ---------------------------------------------------------------------------

loc_C46365:
		SEP	#$20
		LDA	z:$10,X
		CMP	#$34
		BEQ	loc_C46388
		CMP	#$35
		BEQ	loc_C46388
		CMP	#$36
		BEQ	loc_C46388
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#3
		BNE	loc_C46388
		LDA	z:$25,X
		CMP	#2
		BCS	loc_C46388
		STZ	z:$35,X
		JMP	a:.LOWORD(loc_C463DE)
; ---------------------------------------------------------------------------
		RTL
; ---------------------------------------------------------------------------

loc_C46388:
		SEP	#$20
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#2
		BNE	loc_C463A5
		LDA	z:$32,X
		BNE	loc_C463A5
		STZ	z:$35,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C4667D)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C4667D)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C463A5:
		JSL	f:loc_C466D8
		SEP	#$20
		LDX	#$D00
		LDA	a:.LOWORD(current_screen) ; orig=0x00A4
		CMP	z:$10,X
		BEQ	locret_C463DD
		LDA	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2) ; orig=0x0D16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2+1) ; orig=0x0D17
		LDA	a:.LOWORD(current_screen) ; orig=0x00A4
		STA	z:$10,X
		LDA	#$80
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		LDA	#$F
		STA	a:.LOWORD(word_7E031A) ; orig=0x031A
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C46872)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C46872)
		STA	z:2,X

locret_C463DD:
		RTL
; ---------------------------------------------------------------------------

loc_C463DE:
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C46406)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C46406)
		STA	z:2,X
		JSL	f:loc_C4669F
		BCS	locret_C463DD
		REP	#$20
.A16
		LDA	#$2A0
		STA	z:$36,X
		SEP	#$20
.A8
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		ORA	#4
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		STZ	a:.LOWORD(level_manager_object+level_manager_object::anonymous_9) ; orig=0x0D35
		RTL
; ---------------------------------------------------------------------------

loc_C46406:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$41
		BEQ	loc_C46412
		JMP	a:.LOWORD(locret_C463DD)
; ---------------------------------------------------------------------------

loc_C46412:
		SEP	#$20
		INC	z:$35,X
		LDA	z:$35,X
		CMP	#$FF
		BEQ	loc_C46420
		JML	f:locret_C463DD
; ---------------------------------------------------------------------------

loc_C46420:
		STZ	z:$35,X
		PHX
		JSL	f:loc_C4669F
		PLX
		BCC	loc_C4642E
		JML	f:loc_C46662
; ---------------------------------------------------------------------------

loc_C4642E:
		SEP	#$20
		LDY	#7
		LDA	#.LOWORD(BLACK_PALETTE)
		STA	z:$40
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
		LDA	#$F
		JSL	f:palette_related
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C46498)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C46498)
		STA	z:2,X

loc_C46498:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$41
		BEQ	loc_C464A4
		JMP	a:.LOWORD(locret_C463DD)
; ---------------------------------------------------------------------------

loc_C464A4:
		SEP	#$20
		INC	z:$35,X
		LDA	z:$35,X
		CMP	#$40
		BEQ	loc_C464B2
		JML	f:locret_C463DD
; ---------------------------------------------------------------------------

loc_C464B2:
		JSL	f:sub_C4245D
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C464C6)
		STA	a:.LOWORD(level_manager_object+object::handler) ; orig=0x0D00
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C464C6)
		STA	a:.LOWORD(level_manager_object+object::handler+2) ; orig=0x0D02
		RTL
; ---------------------------------------------------------------------------

loc_C464C6:
		JSL	f:loc_C4669F
		SEP	#$20
		INC	z:6,X
		LDA	z:6,X
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_1) ; orig=0x0D12
		LDA	z:5,X
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_1+1) ; orig=0x0D13
		JSL	f:sub_C55C7F
		REP	#$20
.A16
		LDA	#$42D8
		STA	z:$40
		LDA	#0
		STA	z:$42
		JSL	f:loc_C465EB
		REP	#$20
		LDA	#$42E0
		STA	z:$40
		LDA	#1
		STA	z:$42
		JSL	f:loc_C465EB
		REP	#$20
		LDA	#$42E8
		STA	z:$40
		LDA	#2
		STA	z:$42
		JSL	f:loc_C465EB
		REP	#$20
		LDA	#.LOWORD(loc_C465A9)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C465A9)
		STA	z:$52
		JSL	f:sub_C62514
		REP	#$20
.A16
		LDX	#$D00
		LDA	#8
		STA	z:$3E,X
		LDA	#0
		STA	a:.LOWORD(bg3_v_scroll) ; orig=0x0CA5
		SEP	#$20
.A8
		LDY	#0
		LDA	#$40
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		LDA	#$41
		STA	z:$40
		LDA	#$D
		JSL	f:palette_related
		LDA	#$79
		STA	z:$40
		LDA	#$E
		JSL	f:palette_related
		LDA	f:palette_allocation_related_array+8
		STA	z:$40
		LDA	#8
		JSL	f:palette_related
		LDA	f:palette_allocation_related_array+9
		STA	z:$40
		LDA	#9
		JSL	f:palette_related
		STZ	a:.LOWORD(player1_object+player::gameover_related)	; orig=0x0D44
		STZ	a:.LOWORD(player2_object+player::gameover_related)	; orig=0x0D84
		STZ	a:.LOWORD(player3_object+player::gameover_related)	; orig=0x0DC4
		STZ	a:.LOWORD(player4_object+player::gameover_related)	; orig=0x0E04
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C46582)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C46582)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C46582:
		REP	#$20
.A16
		LDA	z:$3E,X
		CLC
		ADC	#$10
		STA	z:$3E,X
		STA	a:.LOWORD(bg3_v_scroll) ; orig=0x0CA5
		CMP	#$E8
		BNE	locret_C465A8
		SEP	#$20
.A8
		LDA	#6
		STA	a:.LOWORD(current_mode) ; orig=0x0C3C
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C46359)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C46359)
		STA	z:2,X

locret_C465A8:
		RTL
; ---------------------------------------------------------------------------

loc_C465A9:
		REP	#$20
.A16
		LDA	#$5CC0
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$600
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(scoreboard_tilemap)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(scoreboard_tilemap)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		RTL
; ---------------------------------------------------------------------------

loc_C465CB:
		REP	#$20
.A16
		LDA	z:$40
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$10
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	z:$53
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	z:$55
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		RTL
; ---------------------------------------------------------------------------
.A16

loc_C465EB:
		SEP	#$20
.A8
		LDA	#.LOBYTE(loc_C46616)
		STA	z:$DB
		LDA	#.HIBYTE(loc_C46616)
		STA	z:$DC
		LDA	#.BANKBYTE(loc_C46616)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCS	locret_C46615
		REP	#$20
.A16
		LDA	z:$40
		STA	a:.LOWORD($30),Y
		LDA	z:$42
		STA	a:.LOWORD($32),Y
		LDA	#4
		STA	a:.LOWORD($20),Y

locret_C46615:
		RTL
; ---------------------------------------------------------------------------

loc_C46616:
		REP	#$20
		DEC	z:$20,X
		BNE	locret_C46655
		INC	z:$32,X
		LDA	z:$32,X
		CMP	#3
		BNE	loc_C4662A
		LDA	#0
		STA	z:$32,X

loc_C4662A:
		ASL
		ASL
		PHX
		TAX
		LDA	f:loc_C46656,X
		STA	z:$53
		LDA	f:loc_C46656+1,X
		STA	z:$54
		PLX
		LDA	#8
		STA	z:$20,X
		LDA	z:$30,X
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(loc_C465CB)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C465CB)
		STA	z:$52
		JSL	f:sub_C62514

locret_C46655:
		RTL
; ---------------------------------------------------------------------------

loc_C46656:
		LDA	[$5D],Y
		CMP	(0,X)
		CMP	[$5D]
		CMP	(0,X)
		CMP	[$5D],Y
		CMP	(0,X)

loc_C46662:
		SEP	#$20
		LDX	#.LOWORD(level_manager_object)
		LDA	#$3A
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		STZ	a:.LOWORD(current_mode) ; orig=0x0C3C
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C46359)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C46359)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C4667D:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$41
		BEQ	loc_C46689
		JMP	a:.LOWORD(locret_C463DD)
; ---------------------------------------------------------------------------

loc_C46689:
		SEP	#$20
		INC	z:$35,X
		LDA	z:$35,X
		CMP	#$40
		BEQ	loc_C46697
		JML	f:locret_C463DD
; ---------------------------------------------------------------------------

loc_C46697:
		LDA	#$37
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		JMP	a:.LOWORD(loc_C463A5)
; ---------------------------------------------------------------------------

loc_C4669F:
		REP	#$20
.A16
		LDX	#$D40

loc_C466A4:
		LDA	z:4,X
		BIT	#1
		BEQ	loc_C466B2
		LDA	z:$2F,X
		AND	#$FF
		BEQ	loc_C466BF

loc_C466B2:
		TXA
		CLC
		ADC	#$40
		TAX
		CMP	#$E40
		BNE	loc_C466A4
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C466BF:
		CLC
		RTL
; ---------------------------------------------------------------------------
.A8

loc_C466C1:
		SEP	#$20
		LDA	z:$40
		LSR
		EOR	#$FF
		AND	#$F
		STA	z:$42
		LDA	z:$40
		CLC
		ADC	a:.LOWORD(word_7E031A) ; orig=0x031A
		STA	a:.LOWORD(word_7E031A) ; orig=0x031A
		CMP	z:$42
		RTL
; ---------------------------------------------------------------------------

loc_C466D8:
		SEP	#$20
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#3
		BNE	loc_C466E5
		JML	f:loc_C467EE
; ---------------------------------------------------------------------------

loc_C466E5:
		CMP	#2
		BEQ	loc_C466ED
		JML	f:loc_C467DF
; ---------------------------------------------------------------------------

loc_C466ED:
		LDA	z:$32,X
		CMP	#1
		BEQ	loc_C466F7
		JML	f:loc_C467DF
; ---------------------------------------------------------------------------

loc_C466F7:
		LDY	#$D40
		LDX	#$D80
		LDA	a:.LOWORD(4),Y
		BEQ	loc_C46708
		LDY	#$D80
		LDX	#$D40

loc_C46708:
		LDA	a:.LOWORD($22),Y
		ORA	a:.LOWORD($23),Y
		BIT	#$C0
		BNE	loc_C46739
		LDA	a:.LOWORD($23),Y
		BIT	#$10
		BNE	loc_C4671D
		JML	f:loc_C467DF
; ---------------------------------------------------------------------------

loc_C4671D:
		TYA
		PHY
		LDY	#0
		BIT	#$40
		BNE	loc_C46729
		LDY	#2

loc_C46729:
		LDA	#$10
		STA	a:.LOWORD($CF1),Y
		LDA	#0
		STA	a:.LOWORD($CF8),Y
		LDA	#0
		STA	a:.LOWORD($CF9),Y
		PLY

loc_C46739:
		LDA	#0
		XBA
		LDA	z:$3D,X
		BNE	loc_C46744
		JML	f:loc_C467DF
; ---------------------------------------------------------------------------

loc_C46744:
		PHX
		TAX
		LDA	f:byte_C467E3,X
		STA	z:$40
		PLX
		LDA	z:$3D,X
		SEC
		SBC	z:$40
		STA	z:$3D,X
		LDA	z:$40
		DEC
		STA	a:.LOWORD($3D),Y
		LDA	#$FF
		STA	a:.LOWORD(4),Y
		REP	#$20
.A16
		LDA	#0
		STA	a:.LOWORD($1A),Y
		LDA	#0
		STA	a:.LOWORD($1C),Y
		LDA	#$5000
		STA	a:.LOWORD($11C),Y
		LDA	#0
		STA	a:.LOWORD($11A),Y
		SEP	#$20
.A8
		PHY
		LDA	a:.LOWORD(5),Y
		STA	z:$40
		LDY	#$46
		LDA	z:$40
		BEQ	loc_C4678B
		LDY	#$68

loc_C4678B:
		REP	#$20
.A16
		LDA	#$B
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(storymode_hud_tilemap+$46)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(storymode_hud_tilemap+$46)
		STA	z:$52
		JSL	f:copy_to_bg3_tilemap
		REP	#$20
.A16
		TYA
		CLC
		ADC	#$2A
		TAY
		LDA	#$B
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(storymode_hud_tilemap+$86)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(storymode_hud_tilemap+$86)
		STA	z:$52
		JSL	f:copy_to_bg3_tilemap
		PLY
		PHY
		JSL	f:write_number_of_lives
		PLY
		TYX
		REP	#$20
.A16
		LDA	#.LOWORD(init_player_handler)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(init_player_handler)
		STA	z:2,X
		STZ	z:7,X
		JSL	f:write_number_of_lives
		INC	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32

loc_C467DF:
		LDX	#.LOWORD(level_manager_object)
		RTL
; ---------------------------------------------------------------------------
byte_C467E3:	.BYTE 0, 1, 1, 2, 2, 3,	3, 4
		.BYTE 4, 5, 5
; ---------------------------------------------------------------------------

loc_C467EE:
		LDX	#$D40

loc_C467F1:
		REP	#$20
.A16
		LDA	z:5,X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	a:.LOWORD($CF0),X
		PLX

loc_C467FF:
		BIT	#$C0C0
		BEQ	loc_C46861
		LDA	z:5,X
		AND	#$FF
		PHX
		TAX
		LDA	f:byte_C3092C,X
		AND	#$FF
		STA	z:$40
		LDA	a:.LOWORD($C5F),X
		BIT	#2
		BEQ	loc_C4686F
		SEP	#$20
.A8
		LDA	#0
		STA	a:.LOWORD($C5F),X
		PLX
		REP	#$20
.A16
		LDA	z:5,X
		AND	#$FF
		ASL

loc_C4682C:
		PHX
		TAX
		LDA	f:byte_C30930,X
		PLX
		LDY	z:$40
		STA	a:.LOWORD($816),Y
		INC
		STA	a:.LOWORD($818),Y
		CLC
		ADC	#$F
		STA	a:.LOWORD($856),Y
		INC
		STA	a:.LOWORD($858),Y

loc_C46847:
		REP	#$20
		LDA	#.LOWORD(init_player_handler)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(init_player_handler)
		STA	z:2,X
		LDA	#$FF
		STA	z:4,X
		INC	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		INC	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		INC	a:.LOWORD(level_manager_object+level_manager_object::number_of_human_players) ; orig=0x0D36

loc_C46861:
		REP	#$20
.A16
		TXA
		CLC
		ADC	#$40
		TAX
		CMP	#$E40
		BNE	loc_C467F1
		RTL
; ---------------------------------------------------------------------------

loc_C4686F:
		PLX
		BRA	loc_C46861
; ---------------------------------------------------------------------------

loc_C46872:
		SEP	#$20
.A8
		LDA	#$FF
		STA	z:$40
		JSL	f:loc_C466C1
		LDA	z:$38,X
		BIT	#1
		BEQ	loc_C46890
		LDA	a:.LOWORD(word_7E031A) ; orig=0x031A
		AND	#$F
		ASL
		ASL
		ASL
		ASL
		EOR	#$FF
		STA	a:.LOWORD(byte_7E0CA9) ; orig=0x0CA9

loc_C46890:
		LDA	a:.LOWORD(word_7E031A) ; orig=0x031A
		BEQ	loc_C46896
		RTL
; ---------------------------------------------------------------------------

loc_C46896:
		REP	#$20
.A16
		LDA	#.LOWORD(screen_load_related)
		STA	a:.LOWORD(level_manager_object+object::handler) ; orig=0x0D00
		SEP	#$20
.A8
		LDA	#.BANKBYTE(screen_load_related)
		STA	a:.LOWORD(level_manager_object+object::handler+2) ; orig=0x0D02
		REP	#$20
.A16
		LDA	#$3FF
		STA	a:.LOWORD(bg3_v_scroll) ; orig=0x0CA5
		STZ	a:.LOWORD(number_of_visible_bonuses) ; orig=0x0C91
		JSL	f:stage_related_init
		SEP	#$20
.A8
		STZ	a:.LOWORD(byte_7E0CA9) ; orig=0x0CA9
		STZ	a:.LOWORD(byte_7E0C3E) ; orig=0x0C3E
		LDA	#8
		STA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		LDA	#0
		STA	a:.LOWORD(bg1_h_scroll+1) ; orig=0x0C9E
		LDA	#0
		STA	a:.LOWORD(word_7E031A) ; orig=0x031A
		LDY	#0
		LDA	#.LOWORD(BLACK_PALETTE)
		STA	z:$40
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
		LDA	#$F
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
		LDA	#$E
		JSL	f:palette_related
		LDA	#$F
		JSL	f:palette_related
		RTL
; End of function sub_C4633F

.A8
.I16

screen_load_related:
		SEP	#$20
		LDA	#$8F
		STA	a:.LOWORD(SCREEN_DISPLAY_REGISTER)
		LDA	#.BANKBYTE(stage_1_1)
		STA	z:$52
		JSL	f:sub_C62007
		REP	#$20
.A16
		LDA	z:$10,X
		AND	#$FF
		ASL
		TAX
		LDA	f:screens_table,X
		STA	z:$50
		LDA	[$50]
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_5) ; orig=0x0D1C
		INC	z:$50
		INC	z:$50
		LDX	#$D00
		LDA	[$50]
		STA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		INC	z:$50
		INC	z:$50
		STA	z:$30,X
		STA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#6
		BNE	loc_C4697E
		JML	f:menu_screens_related
; ---------------------------------------------------------------------------

loc_C4697E:
		CMP	#1
		BNE	loc_C46987
		JML	f:menu_screens_related
; ---------------------------------------------------------------------------

loc_C46987:
		LDA	[$50]
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_10) ; orig=0x0D3A
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDX	#0
		LDA	#$2000
		STA	z:$40
		JSL	f:graphics_decompression_81aa_terminated_interleaved
		REP	#$20
		LDA	#$1C00
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$800
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(byte_7E3400)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_7E3400)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		REP	#$20
.A16
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDX	#$C00
		LDA	#$2000
		STA	z:$40
		JSL	f:graphics_decompression_81aa_terminated_interleaved
		JSL	f:sub_C47C58
		REP	#$20
		LDA	#0
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$2000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		REP	#$20
.A16
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDX	#0
		LDA	#$2000
		STA	z:$40
		JSL	f:graphics_decompression_81aa_terminated_interleaved
		REP	#$20
		LDA	#$2000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$2000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		REP	#$20
.A16
		LDX	#0
		LDA	#$2000
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(bonuses_graphic)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(bonuses_graphic)
		STA	z:$55
		JSL	f:graphics_decompression_81aa_terminated_interleaved
		REP	#$20
.A16
		LDA	#$1000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1800
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:sub_C47B11
		REP	#$20
.A16
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		JSL	f:sub_C47B33
		REP	#$20
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		JSL	f:sub_C47A8D
		SEP	#$20
.A8
		LDA	[$50]
		STA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		JSL	f:level_initialization_related
		JSL	f:hud_related_0
		JSL	f:sub_C61C7B
		JSL	f:sub_C61690
		REP	#$20
.A16
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	z:$48		; hard_blocks
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD(level_manager_object+level_manager_object::soft_blocks) ; orig=0x0D3C
		INC	z:$50
		INC	z:$50
		JSL	f:generate_hard_blocks_and_exit
		JSL	f:call_screen_init_functions
		JSL	f:copy_enemy_creation_functions
		JSL	f:process_bonuses
		JSL	f:related_to_enemy_bonuses
		REP	#$20
		LDA	#.LOWORD(unk_7F0670)
		STA	z:$59
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7F0670)
		STA	z:$5B
		JSL	f:generate_soft_blocks
		JSL	f:create_enemies
		REP	#$20
.A16
		LDA	#.LOWORD(~(PLAYER|$6000))
		JSL	f:apply_mask_to_collision_map
		JSL	f:sub_C42702
		SEP	#$20
.A8
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#3
		BNE	loc_C46B2A
		JML	f:sub_C46E2A
; ---------------------------------------------------------------------------

loc_C46B2A:
		REP	#$20
.A16
		LDA	#.LOWORD(off_C47087)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C47087)
		STA	z:$55
		JSL	f:graphics_decompression_8192_bytes
		REP	#$20
.A16
		LDA	#$7000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		REP	#$20
.A16
		LDA	#.LOWORD(splash_graphics)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(splash_graphics)
		STA	z:$55
		JSL	f:graphics_decompression_8192_bytes
		REP	#$20
.A16
		LDA	#$7800
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		SEP	#$20
		LDA	#$F
		STA	a:.LOWORD(word_7E031A) ; orig=0x031A
		LDA	#$1F
		STA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		LDA	#3
		STA	a:.LOWORD(bg1_v_scroll+1) ; orig=0x0CA0
		LDA	#$20
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_6) ; orig=0x0D20
		LDY	#4
		LDA	#0
		STA	z:$40
		LDA	#0
		JSL	f:palette_related
		LDY	#0
		LDA	#.LOWORD(SPLASH_PALETTE)
		STA	z:$40
		LDA	#8
		JSL	f:palette_related
		REP	#$20
.A16
		LDA	#0
		STA	a:.LOWORD(unknown_object+$20) ; orig=0x0FE0
		LDA	#$3FF
		STA	a:.LOWORD(unknown_object+$22) ; orig=0x0FE2
		LDA	a:.LOWORD(unknown_object+$22) ; orig=0x0FE2
		STA	a:.LOWORD(bg3_v_scroll_2) ; orig=0x0CA7
		REP	#$20
		LDA	#.LOWORD(sub_C46C0B)
		STA	a:.LOWORD(level_manager_object+object::handler) ; orig=0x0D00
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C46C0B)
		STA	a:.LOWORD(level_manager_object+object::handler+2) ; orig=0x0D02
		SEP	#$20
		LDA	#.BANKBYTE(stage_intro_music_list)
		STA	z:$52
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		AND	#$F0
		LSR
		LSR
		LSR
		LSR
		CLC
		ADC	#.LOWORD(stage_intro_music_list)
		STA	z:$50
		LDA	[$50]
		AND	#$FF
		TAY
		JSL	f:play_music
		RTL
; End of function screen_load_related

; ---------------------------------------------------------------------------
stage_intro_music_list:.BYTE 0,	$D, $1E, $20, $22, $24,	$26; 0
.A16
.I16

sub_C46C0B:
		SEP	#$20
.A8
		DEC	z:$20,X
		BEQ	loc_C46C15
		JML	f:locret_C463DD
; ---------------------------------------------------------------------------

loc_C46C15:
		REP	#$20
.A16
		LDA	#$830
		STA	z:$E,X
		LDA	#$FFD0
		STA	z:$11,X
		LDA	#$50
		STA	z:$14,X
		REP	#$20
		LDA	#.LOWORD(loc_C46C33)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C46C33)
		STA	z:2,X

loc_C46C33:
		REP	#$20
.A16
		LDA	z:$11,X
		CLC
		ADC	#$10
		STA	z:$11,X
		BMI	loc_C46C5C
		CMP	#$50
		BCC	loc_C46C5C
		LDA	#$50
		STA	z:$11,X
		SEP	#$20
.A8
		LDA	#$20
		STA	z:$21,X
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C46C61)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C46C61)
		STA	z:2,X

loc_C46C5C:
		JSL	f:sub_C46FD8
		RTL
; End of function sub_C46C0B

.A8
.I16

sub_C46C61:
		SEP	#$20
		DEC	z:$21,X
		BEQ	loc_C46C6B
		JML	f:loc_C46CBB
; ---------------------------------------------------------------------------

loc_C46C6B:
		JSL	f:sub_C4757D
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C46C7C)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C46C7C)
		STA	z:2,X

loc_C46C7C:
		SEP	#$20
		LDA	#$1F
		STA	z:$20,X
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C46C8F)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C46C8F)
		STA	z:2,X

loc_C46C8F:
		SEP	#$20
		LDA	z:$20,X
		CLC
		ADC	#8
		CMP	#$E8
		STA	z:$20,X
		BCC	loc_C46CB1
		LDA	#$E7
		STA	z:$20,X
		LDA	#$40
		STA	z:$21,X
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C46CC0)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C46CC0)
		STA	z:2,X

loc_C46CB1:
		LDA	z:$20,X
		STA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		LDA	#3
		STA	a:.LOWORD(bg1_v_scroll+1) ; orig=0x0CA0

loc_C46CBB:
		JSL	f:sub_C46FD8
		RTL
; End of function sub_C46C61

.A8
.I16

sub_C46CC0:
		SEP	#$20
		DEC	z:$21,X
		BEQ	loc_C46CCA
		JML	f:loc_C46CBB
; ---------------------------------------------------------------------------

loc_C46CCA:
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C46CD7)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C46CD7)
		STA	z:2,X

loc_C46CD7:
		REP	#$20
.A16
		LDA	z:$11,X
		CLC
		ADC	#$10
		STA	z:$11,X
		CMP	#$150
		BCC	loc_C46CBB
		REP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		AND	#$FF
		ASL
		TAX
		LDA	f:screen_music_table,X
		AND	#$FF
		TAY
		JSL	f:play_music
; End of function sub_C46CC0

.A8
.I16

sub_C46CFC:
		JSL	f:sub_C475A1
		SEP	#$20
		LDA	#$7F
		STA	z:$55
		REP	#$20
.A16
		LDA	#$600
		STA	z:$53
		JSL	f:graphics_decompression_8192_bytes
		SEP	#$20
.A8
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C46D16:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C46D16
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$6000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:graphics_decompression_8192_bytes
		SEP	#$20
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C46D4A:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C46D4A
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$6800
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:graphics_decompression_8192_bytes
		SEP	#$20
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C46D7E:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C46D7E
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$7000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:graphics_decompression_8192_bytes
		SEP	#$20
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C46DB2:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C46DB2
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$7800
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:sub_C61F91
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C46DF1)
		STA	a:.LOWORD(level_manager_object+object::handler) ; orig=0x0D00
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C46DF1)
		STA	a:.LOWORD(level_manager_object+object::handler+2) ; orig=0x0D02
		RTL
; End of function sub_C46CFC

.A8
.I16

sub_C46DF1:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		AND	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		STZ	a:.LOWORD(level_manager_object+level_manager_object::current_screen) ;	orig=0x0D3F
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C46359)
		STA	a:.LOWORD(level_manager_object+object::handler) ; orig=0x0D00
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C46359)
		STA	a:.LOWORD(level_manager_object+object::handler+2) ; orig=0x0D02
		RTL
; End of function sub_C46DF1

.A8
.I16

sub_C46E0E:
		SEP	#$20
		STZ	a:.LOWORD(word_7E0CAE+1) ;	orig=0x0CAF
		JSL	f:random2
		SEP	#$20
		BIT	#1
		BNE	locret_C46E29
		JSL	f:random2
		SEP	#$20
		AND	#1
		INC
		STA	a:.LOWORD(word_7E0CAE+1) ;	orig=0x0CAF

locret_C46E29:
		RTL
; End of function sub_C46E0E

.A8
.I16

sub_C46E2A:
		JSL	f:sub_C46E0E
		REP	#$20
.A16
		LDA	[$50]
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		INC	z:$50
		INC	z:$50
		LDA	#$E0
		STA	a:.LOWORD(FIXED_COLOR_DATA)
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		SEP	#$20
.A8
		LDA	#0
		STA	a:.LOWORD(word_7E031A) ; orig=0x031A
		LDA	#$E7
		STA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		LDA	#3
		STA	a:.LOWORD(bg1_v_scroll+1) ; orig=0x0CA0
		LDA	#$20
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_6+1) ; orig=0x0D21
		LDY	#0
		LDA	#0
		STA	z:$40
		LDA	#0
		JSL	f:palette_related
		SEP	#$20
		LDA	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		JSL	f:sub_C4757D
		JSL	f:sub_C46CFC
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C46EBD)
		STA	a:.LOWORD(level_manager_object+object::handler) ; orig=0x0D00
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C46EBD)
		STA	a:.LOWORD(level_manager_object+object::handler+2) ; orig=0x0D02
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2) ; orig=0x0D16
		INC
		CMP	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		BEQ	locret_C46EBC
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		AND	#$FF
		ASL
		TAX
		LDA	f:screen_music_table,X
		AND	#$FF
		TAY
		JSL	f:play_music

locret_C46EBC:
		RTL
; End of function sub_C46E2A

.A16
.I16

sub_C46EBD:
		SEP	#$20
.A8
		LDA	#1
		STA	z:$40
		JSL	f:loc_C466C1
		BEQ	loc_C46ECD
		JML	f:locret_C463DD
; ---------------------------------------------------------------------------

loc_C46ECD:
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C46EDA)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C46EDA)
		STA	z:2,X

loc_C46EDA:
		SEP	#$20
		DEC	z:$21,X
		BEQ	loc_C46EE4
		JML	f:locret_C463DD
; ---------------------------------------------------------------------------

loc_C46EE4:
		LDA	#0
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C46359)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C46359)
		STA	z:2,X
		RTL
; End of function sub_C46EBD

.A8
.I16

hud_related_0:
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_8) ; orig=0x0D30
		CMP	#3
		BEQ	loc_C46F4C
		CMP	#1
		BEQ	loc_C46F3A
		REP	#$20
		LDA	#.LOWORD(storymode_hud_tilemap)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(storymode_hud_tilemap)
		STA	z:$55
		JSL	f:sub_C46FC9
		REP	#$20
.A16
		LDX	#.LOWORD(player1_object)
		STZ	z:$40
		STZ	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:write_number_of_lives
		REP	#$20
		LDX	#.LOWORD(player2_object)
		STZ	z:$40
		STZ	z:$42
		JSL	f:add_to_score_if_allowed
		JSL	f:write_number_of_lives
		RTL
; ---------------------------------------------------------------------------

loc_C46F3A:
		REP	#$20
		LDA	#.LOWORD(empty_tilemap)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(empty_tilemap)
		STA	z:$55
		JSL	f:sub_C46FC9
		RTL
; ---------------------------------------------------------------------------

loc_C46F4C:
		REP	#$20
.A16
		LDA	#.LOWORD(battlemode_hud_tilemap)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(battlemode_hud_tilemap)
		STA	z:$55
		JSL	f:sub_C46FC9
		LDX	#$D40
		REP	#$20
.A16

loc_C46F62:
		LDA	z:5,X
		AND	#$FF
		PHX
		TAX
		LDA	a:.LOWORD(word_7E0C5F),X
		STA	z:$40
		LDA	f:byte_C3092C,X
		PLX
		AND	#$FF
		STA	z:$42
		LDA	z:$40
		BIT	#2
		BEQ	loc_C46FA0
		LDA	z:5,X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:byte_C30940,X
		PLX
		LDY	z:$42
		STA	a:.LOWORD(bg3_tilemap),Y
		INC
		STA	a:.LOWORD(bg3_tilemap+2),Y
		CLC
		ADC	#$F
		STA	a:.LOWORD(bg3_tilemap+$40),Y
		INC
		STA	a:.LOWORD(bg3_tilemap+$42),Y

loc_C46FA0:
		LDY	z:$42
		INY
		INY
		INY
		INY
		LDA	z:object::handler+6,X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:hud_digits_tilenos_upper,X
		PLX
		STA	a:.LOWORD(bg3_tilemap),Y
		CLC
		ADC	#$10
		STA	a:.LOWORD(bg3_tilemap+$40),Y
		TXA
		CLC
		ADC	#$40
		TAX
		CMP	#$E40
		BNE	loc_C46F62
		RTL
; End of function hud_related_0

.A8
.I16

sub_C46FC9:
		REP	#$20
.A16
		LDY	#$FE

loc_C46FCE:
		LDA	[$53],Y
		STA	a:.LOWORD(bg3_tilemap),Y
		DEY
		DEY
		BPL	loc_C46FCE
		RTL
; End of function sub_C46FC9

.A8
.I16

sub_C46FD8:
		SEP	#$20
		LDA	#.BANKBYTE(word_C4709F)
		STA	z:$52
		REP	#$20
.A16
		LDA	z:$11,X
		PHA
		LDA	z:$14,X
		PHA
		LDA	z:$11,X
		CLC
		ADC	#8
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$10
		STA	z:$14,X
		LDA	z:$24,X
		AND	#$F0
		LSR
		LSR
		LSR
		ADC	#.LOWORD(word_C4709F)
		STA	z:$50
		LDA	[$50]
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		JSL	f:sub_C625D3
		REP	#$20
.A16
		LDA	z:$11,X
		CLC
		ADC	#$30
		STA	z:$11,X
		LDA	#.LOWORD(byte_C462B0)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		JSL	f:sub_C625D3
		REP	#$20
.A16
		LDA	z:$11,X
		CLC
		ADC	#$30
		STA	z:$11,X
		LDA	z:$24,X
		AND	#$F
		ASL
		ADC	#.LOWORD(word_C4709F)
		STA	z:$50
		LDA	[$50]
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		JSL	f:sub_C625D3
		REP	#$20
.A16
		LDA	z:$11,X
		SEC
		SBC	#$30
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	#$30
		STA	z:$14,X
		LDA	#.LOWORD(byte_C462B5)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		JSL	f:sub_C625D3
		REP	#$20
.A16
		PLA
		STA	z:$14,X
		PLA
		STA	z:$11,X
		RTL
; End of function sub_C46FD8

; ---------------------------------------------------------------------------
off_C47087:	.FARADDR splash_graphic_0
		.FARADDR splash_graphic_1
		.FARADDR splash_graphic_2
		.FARADDR splash_graphic_3
splash_graphics:.FARADDR splash_graphic_4
		.FARADDR splash_graphic_5
		.FARADDR splash_graphic_6
		.FARADDR splash_graphic_7
word_C4709F:	.WORD 0
		.ADDR byte_C46288
		.ADDR byte_C4628D
		.ADDR byte_C46292
		.ADDR byte_C46297
		.ADDR byte_C4629C
		.ADDR byte_C462A1
		.ADDR byte_C462A6
		.ADDR byte_C462AB
.A16
.I16

menu_screens_related:
		REP	#$20
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDX	#0
		LDA	#$2000
		STA	z:$40
		JSL	f:graphics_decompression_81aa_terminated_interleaved
		REP	#$20
		LDA	#0
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$2000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		REP	#$20
.A16
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDX	#0
		LDA	#$2000
		STA	z:$40
		JSL	f:graphics_decompression_81aa_terminated_interleaved
		REP	#$20
		LDA	#$1000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$2000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		REP	#$20
.A16
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDX	#0
		LDA	#$2000
		STA	z:$40
		JSL	f:graphics_decompression_81aa_terminated_interleaved
		REP	#$20
		LDA	#$2000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$2000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		REP	#$20
.A16
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDX	#0
		LDA	#$2000
		STA	z:$40
		JSL	f:graphics_decompression_81aa_terminated_interleaved
		REP	#$20
		LDA	#$3000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$2000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:sub_C47B11
		REP	#$20
.A16
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		JSL	f:sub_C47B33
		REP	#$20
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		JSL	f:sub_C47A8D
		JSL	f:level_initialization_related
		JSL	f:hud_related_0
		JSL	f:sub_C61C7B
		JSL	f:sub_C61690
		JSL	f:call_screen_init_functions
		REP	#$20
		LDA	#graphics_table	- unk_7F0000
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(graphics_table)
		STA	z:$55
		LDA	#$10
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		LDA	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		CMP	#$32
		BEQ	loc_C4720F
		CMP	#$39
		BEQ	loc_C4720F
		LDA	#0
		STA	a:.LOWORD(game_flags) ; orig=0x0314

loc_C4720F:
		JSL	f:graphics_decompression_8192_bytes
		REP	#$20
.A16
		LDA	#$6000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:graphics_decompression_8192_bytes
		REP	#$20
.A16
		LDA	#$6800
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:graphics_decompression_8192_bytes
		REP	#$20
.A16
		LDA	#$7000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:graphics_decompression_8192_bytes
		REP	#$20
.A16
		LDA	#$7800
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		SEP	#$20
		LDY	#0
		LDA	#0
		STA	z:$40
		LDA	#0
		JSL	f:palette_related
		LDA	#0
		STA	a:.LOWORD(word_7E031A) ; orig=0x031A
		LDA	#$E7
		STA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		LDA	#3
		STA	a:.LOWORD(bg1_v_scroll+1) ; orig=0x0CA0
		JSL	f:sub_C4757D
		JSL	f:sub_C475A1
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C472EF)
		STA	a:.LOWORD(level_manager_object+object::handler) ; orig=0x0D00
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C472EF)
		STA	a:.LOWORD(level_manager_object+object::handler+2) ; orig=0x0D02
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		AND	#$FF
		ASL
		TAX
		LDA	f:screen_music_table,X
		AND	#$FF
		TAY
		JSL	f:play_music
		RTL
; End of function menu_screens_related

.A16
.I16

sub_C472EF:
		SEP	#$20
.A8
		LDA	#1
		STA	z:$40
		JSL	f:loc_C466C1
		BEQ	loc_C472FF
		JML	f:locret_C463DD
; ---------------------------------------------------------------------------

loc_C472FF:
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C46359)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C46359)
		STA	z:2,X
		RTL
; End of function sub_C472EF

.A8
.I16

sub_C4730D:
		REP	#$20
.A16
		PHX
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$200
		BEQ	loc_C4731C
		JSL	f:sub_C47560

loc_C4731C:
		SEP	#$20
.A8
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_8) ; orig=0x0D30
		PHA
		LDA	#3
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_8) ; orig=0x0D30
		LDA	#.BANKBYTE(stage_1_1)
		STA	z:$52
		REP	#$20
.A16
		LDA	z:$40
		AND	#$FF
		ASL
		TAX
		LDA	f:screens_table+$7A,X
		STA	z:$50
		LDA	[$50]
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_5) ; orig=0x0D1C
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		INC	z:$50
		INC	z:$50
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_10) ; orig=0x0D3A
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDX	#0
		LDA	#$2000
		STA	z:$40
		JSL	f:graphics_decompression_81aa_terminated_interleaved
		REP	#$20
		INC	z:$50
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$4000
		BEQ	loc_C473A4
		REP	#$20
		LDA	#.LOWORD(empty_tilemap)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(empty_tilemap)
		STA	z:$55

loc_C473A4:
		REP	#$20
.A16
		LDX	#$1000
		LDA	#$2002
		STA	z:$40
		JSL	f:graphics_decompression_81aa_terminated_interleaved
		REP	#$20
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		JSL	f:sub_C47B33
		REP	#$20
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		JSL	f:tilemap_decompression
		JSL	f:sub_C61C7B
		JSL	f:sub_C61690
		REP	#$20
		INC	z:$50
		INC	z:$50
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD(level_manager_object+level_manager_object::soft_blocks) ; orig=0x0D3C
		INC	z:$50
		INC	z:$50
		INC	z:$50
		INC	z:$50
		INC	z:$50
		JSL	f:sub_C4753D
		JSL	f:call_screen_init_functions
		JSL	f:copy_enemy_creation_functions
		JSL	f:process_bonuses
		REP	#$20
		LDA	z:$46
		STA	z:$48
		JSL	f:related_to_enemy_bonuses
		REP	#$20
		LDA	#.LOWORD(unk_7F0670)
		STA	z:$59
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7F0670)
		STA	z:$5B
		JSL	f:generate_soft_blocks
		REP	#$20
.A16
		LDA	z:$50
		PHA
		LDA	z:$51
		PHA
		JSL	f:sub_C4757D
		JSL	f:update_palettes
		REP	#$20
		PLA
		STA	z:$51
		PLA
		STA	z:$50
		LDA	#.LOWORD(~(PLAYER|$6000))
		JSL	f:apply_mask_to_collision_map
		JSL	f:sub_C42702
		SEP	#$20
.A8
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C4744E:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C4744E
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		SEP	#$20
		LDA	#$8F
		STA	a:.LOWORD(SCREEN_DISPLAY_REGISTER)
		LDY	#6
		LDA	[$50],Y
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		STA	a:.LOWORD(BG_2_H_SCROLL_OFFSET)
		INY
		LDA	[$50],Y
		STA	a:.LOWORD(bg2_h_scroll+1) ; orig=0x0CA2
		STA	a:.LOWORD(BG_2_H_SCROLL_OFFSET)
		INY
		LDA	[$50],Y
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		STA	a:.LOWORD(BG_2_V_SCROLL_OFFSET)
		INY
		LDA	[$50],Y
		STA	a:.LOWORD(bg2_v_scroll+1) ; orig=0x0CA4
		STA	a:.LOWORD(BG_2_V_SCROLL_OFFSET)
		REP	#$20
.A16
		LDY	#0
		LDA	[$50],Y
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDY	#2
		LDA	[$50],Y
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDY	#4
		LDA	[$50],Y
		STA	a:.LOWORD(FIXED_COLOR_DATA)
		JSL	f:sub_C62460
		REP	#$20
		LDA	#0
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$C00
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		REP	#$20
.A16
		LDA	#$2400
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$400
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(unk_7E4000)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(unk_7E4000)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		REP	#$20
.A16
		LDA	#$5000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$322
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(bg1_tilemap)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#0
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		REP	#$20
.A16
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
		SEP	#$20
		LDA	#$60
		STA	z:$40

loc_C4752D:
		DEC	z:$40
		BNE	loc_C4752D
		LDA	a:.LOWORD(word_7E031A) ; orig=0x031A
		STA	a:.LOWORD(SCREEN_DISPLAY_REGISTER)
		PLA
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_8) ; orig=0x0D30
		PLX
		RTL
; End of function sub_C4730D

.A16
.I16

sub_C4753D:
		REP	#$20
		PHX
		LDX	#$F00

loc_C47543:
		TXA
		CLC
		ADC	#$40
		CMP	#$1C40
		BEQ	loc_C4755E
		TAX
		LDA	z:3,X
		AND	#$FF
		CMP	#2
		BNE	loc_C47543
		JSL	f:delete_object
		BRA	loc_C47543
; ---------------------------------------------------------------------------

loc_C4755E:
		PLX
		RTL
; End of function sub_C4753D

.A16
.I16

sub_C47560:
		REP	#$20
		LDX	#$F40

loc_C47565:
		LDA	z:0,X
		CMP	#.LOWORD(bonus_handling_object)
		BEQ	loc_C47576
		LDA	z:6,X
		CMP	#$FFFF
		BEQ	locret_C4757C
		TAX
		BRA	loc_C47565
; ---------------------------------------------------------------------------

loc_C47576:
		JSL	f:delete_object
		BRA	sub_C47560
; ---------------------------------------------------------------------------

locret_C4757C:
		RTL
; End of function sub_C47560

.A16
.I16

sub_C4757D:
		REP	#$20
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
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_5) ; orig=0x0D1C
		STA	z:$44
		LSR	z:$44
		LDA	#8
		STA	z:$46
		BRA	loc_C475C8
; End of function sub_C4757D

.A16
.I16

sub_C475A1:
		REP	#$20
		LDA	#.LOWORD(palette_allocation_related_array)
		STA	z:$53
		SEP	#$20
.A8
		LDA	#.BANKBYTE(palette_allocation_related_array)
		STA	z:$55
		REP	#$20
.A16
		LDA	#.LOWORD(palette_allocation_related_array)
		CLC
		ADC	#8
		STA	z:$53
		LDA	#8
		STA	z:$42
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_5+1) ; orig=0x0D1D
		STA	z:$44
		LDA	#$10
		STA	z:$46

loc_C475C8:
		REP	#$20
		LDY	#6
		ROR	z:$44
		BCS	loc_C475D4
		LDY	#0

loc_C475D4:
		SEP	#$20
.A8
		LDA	[$53]
		STA	z:$40
		LDA	z:$42
		JSL	f:palette_related
		REP	#$20
.A16
		INC	z:$53
		INC	z:$42
		LDA	z:$42
		CMP	z:$46
		BNE	loc_C475C8
		RTL
; End of function sub_C475A1

.A16
.I16

stage_related_init:
		REP	#$20
		STZ	a:.LOWORD(free_offset_in_object_pointer_array) ; orig=0x00BA
		LDA	#$64
		STA	a:.LOWORD(max_object_pointer_object) ; orig=0x00BC
		LDY	#0
		LDX	#.LOWORD(unknown_object)

loc_C475FE:
		TXA
		STA	a:.LOWORD(object_pointer_array),Y
		INY
		INY
		STZ	z:0,X
		STZ	z:2,X
		TXA
		CLC
		ADC	#.SIZEOF(player)
		TAX
		CMP	#.LOWORD(unk_7E1C40)
		BNE	loc_C475FE
		LDA	#0
		STA	a:.LOWORD(unk_7E0F44) ; orig=0x0F44
		LDA	#0
		STA	a:.LOWORD(word_7E0F42+1) ;	orig=0x0F43
		LDA	#.LOWORD(unk_7E0F80)
		STA	a:.LOWORD(word_7E0F46) ; orig=0x0F46
		REP	#$20
		LDA	#.LOWORD(gameover_writing_object)
		STA	a:.LOWORD(enemy_objects) ; orig=0x0F40
		SEP	#$20
.A8
		LDA	#.BANKBYTE(gameover_writing_object)
		STA	a:.LOWORD(word_7E0F42) ; orig=0x0F42
		REP	#$20
.A16
		LDX	#.LOWORD(unk_7E0F80)
		LDA	#.LOWORD(enemy_objects)
		STA	z:4,X
		LDA	#$FFFF
		STA	z:6,X
		REP	#$20
		LDA	#.LOWORD(hud_related_object)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(hud_related_object)
		STA	z:2,X
		LDA	#$FE
		STA	z:3,X
		REP	#$20
.A16
		LDX	#$D00
		SEP	#$20
.A8
		LDA	#.LOBYTE(handle_pause)
		STA	z:$DB
		LDA	#.HIBYTE(handle_pause)
		STA	z:$DC
		LDA	#.BANKBYTE(handle_pause)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		STZ	a:.LOWORD(word_7E0078) ; orig=0x0078
		LDA	#$2C
		STA	a:.LOWORD(word_7E007A) ; orig=0x007A
		LDY	#0
		LDX	#$1CC0

loc_C47680:
		TXA
		STA	a:.LOWORD(unk_7E04C4),Y
		INY
		INY
		STZ	z:0,X
		TXA
		CLC
		ADC	#$20
		TAX
		CMP	#.LOWORD(unk_7E1F80)
		BNE	loc_C47680
		LDX	#.LOWORD(unk_7E1C80)
		LDA	#.LOWORD(locret_C4757C)
		STA	z:0,X
		LDA	#0
		STA	z:4,X
		LDA	#$1CA0
		STA	z:6,X
		LDX	#$1CA0
		LDA	#0
		STA	z:0,X
		LDA	#$1C80
		STA	z:4,X
		LDA	#$FFFF
		STA	z:6,X
		STZ	z:$40
		LDX	#$1F80
		LDY	#$10

loc_C476BF:
		LDA	#$FF
		STA	z:0,X
		LDA	z:$40
		STA	z:4,X
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		LDA	z:$40
		CLC
		ADC	#$20
		STA	z:$40
		DEY
		BNE	loc_C476BF
		REP	#$20
		LDA	#.LOWORD(init_player_handler)
		STA	a:.LOWORD(player1_object+object::handler) ; orig=0x0D40
		SEP	#$20
.A8
		LDA	#.BANKBYTE(init_player_handler)
		STA	a:.LOWORD(player1_object+object::handler+2) ; orig=0x0D42
		REP	#$20
.A16
		LDA	#.LOWORD(init_player_handler)
		STA	a:.LOWORD(player2_object+object::handler) ; orig=0x0D80
		SEP	#$20
.A8
		LDA	#.BANKBYTE(init_player_handler)
		STA	a:.LOWORD(player2_object+object::handler+2) ; orig=0x0D82
		REP	#$20
.A16
		LDA	#.LOWORD(init_player_handler)
		STA	a:.LOWORD(player3_object+object::handler) ; orig=0x0DC0
		SEP	#$20
.A8
		LDA	#.BANKBYTE(init_player_handler)
		STA	a:.LOWORD(player3_object+object::handler+2) ; orig=0x0DC2
		REP	#$20
.A16
		LDA	#.LOWORD(init_player_handler)
		STA	a:.LOWORD(player4_object+object::handler) ; orig=0x0E00
		SEP	#$20
.A8
		LDA	#.BANKBYTE(init_player_handler)
		STA	a:.LOWORD(player4_object+object::handler+2) ; orig=0x0E02
		LDA	#0
		STA	a:.LOWORD(player1_object+player::current_bomb_count) ; orig=0x0D64
		LDA	#0
		STA	a:.LOWORD(player2_object+player::current_bomb_count) ; orig=0x0DA4
		LDA	#0
		STA	a:.LOWORD(player3_object+player::current_bomb_count) ; orig=0x0DE4
		LDA	#0
		STA	a:.LOWORD(player4_object+player::current_bomb_count) ; orig=0x0E24
		LDA	#0
		STA	a:.LOWORD(word_7E0E48) ; orig=0x0E48
		LDA	#0
		STA	a:.LOWORD(word_7E0E88) ; orig=0x0E88
		LDA	#0
		STA	a:.LOWORD(word_7E0EC8) ; orig=0x0EC8
		LDA	#0
		STA	a:.LOWORD(word_7E0F08) ; orig=0x0F08
		LDA	#0
		STA	a:.LOWORD(player3_object+player::gameover_related)	; orig=0x0DC4
		LDA	#0
		STA	a:.LOWORD(player4_object+player::gameover_related)	; orig=0x0E04
		RTL
; End of function stage_related_init

.A8
.I16

sub_C4774A:
		REP	#$20
.A16
		STZ	z:$30,X
		STZ	z:$32,X
		STZ	z:$34,X
		STZ	z:$36,X
		STZ	z:$38,X
		STZ	z:$3A,X
		STZ	z:$3B,X
		RTL
; End of function sub_C4774A

.A8
.I16

sub_C4775B:
		SEP	#$20
		LDA	z:$31,X
		AND	#$7F
		STA	z:$31,X
		DEC	z:$32,X
		BPL	loc_C47769
		STZ	z:$32,X

loc_C47769:
		STZ	z:$33,X
		STZ	z:$38,X
		STZ	z:$39,X
		RTL
; End of function sub_C4775B

.A16
.I16

sub_C47770:
		REP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$10
		BNE	loc_C477AB
		BIT	#$100
		BNE	loc_C477D2
		BIT	#8
		BNE	loc_C477F9
		LDA	#$100
		STA	z:$30,X
		LDA	#1
		STA	z:$32,X
		STZ	z:$34,X
		LDA	#0
		STA	z:$36,X
		STZ	z:$38,X
		STZ	z:$3A,X
		STZ	z:$3B,X
		LDA	#0
		STA	a:.LOWORD($130),X
		LDA	#0
		STA	a:.LOWORD($132),X
		STZ	a:.LOWORD($134),X
		RTL
; ---------------------------------------------------------------------------

loc_C477AB:
		LDA	#$100
		STA	z:$30,X
		LDA	#6
		STA	z:$32,X
		STZ	z:$34,X
		LDA	#0
		STA	z:$36,X
		STZ	z:$38,X
		STZ	z:$3A,X
		STZ	z:$3B,X
		LDA	#0
		STA	a:.LOWORD($130),X
		LDA	#0
		STA	a:.LOWORD($132),X
		STZ	a:.LOWORD($134),X
		RTL
; ---------------------------------------------------------------------------

loc_C477D2:
		LDA	#$905
		STA	z:$30,X
		LDA	#3
		STA	z:$32,X
		STZ	z:$34,X
		STZ	z:$36,X
		LDA	#$300
		STA	z:$38,X
		STZ	z:$3A,X
		STZ	z:$3B,X
		LDA	#0
		STA	a:.LOWORD($130),X
		LDA	#0
		STA	a:.LOWORD($132),X
		STZ	a:.LOWORD($134),X
		RTL
; ---------------------------------------------------------------------------

loc_C477F9:
		LDA	#$100
		STA	z:$30,X
		LDA	#1
		STA	z:$32,X
		STZ	z:$34,X
		LDA	#0
		STA	z:$36,X
		STZ	z:$38,X
		STZ	z:$3A,X
		STZ	z:$3B,X
		LDA	#0
		STA	a:.LOWORD($130),X
		LDA	#0
		STA	a:.LOWORD($132),X
		STZ	a:.LOWORD($134),X
		RTL
; End of function sub_C47770

; ---------------------------------------------------------------------------
byte_C47820:	.BYTE $28, 0, $18, 0, 0, 0, $FF, 0
		.BYTE $E8, 0, $B8, 0, 2, 2, $FF, 1
		.BYTE $E8, 0, $18, 0, 8, 8, $FF, 2
		.BYTE $28, 0, $B8, 0, $A, $A, $FF, 3
byte_C47840:	.BYTE $68, 0, $58, 0, 0, 0, $FF, 0
		.BYTE $A8, 0, $78, 0, 2, 2, $FF, 1
		.BYTE $A8, 0, $58, 0, 8, 8, $FF, 2
		.BYTE $68, 0, $78, 0, $A, $A, $FF, 3
		.BYTE $48, 0, $38, 0, 0, 0, $FF, 0
		.BYTE $C8, 0, $98, 0, 2, 2, $FF, 1
		.BYTE $C8, 0, $38, 0, 8, 8, $FF, 2
		.BYTE $48, 0, $98, 0, $A, $A, $FF, 3
		.BYTE $28, 0, $18, 0, 0, 0, $FF, 0
		.BYTE $E8, 0, $18, 0, 2, 2, $FF, 1
		.BYTE $28, 0, $38, 0, 0, 0, $FF, 0
		.BYTE $E8, 0, $38, 0, 2, 2, $FF, 1
byte_C478A0:	.BYTE 0, 0, 0, 0, 0, 0,	1, 1
		.BYTE 0, 1, 1, 1, 1, 1,	2, 2
		.BYTE 1, 2, 2, 2, 2, 2,	3, 3
		.BYTE 2, 3, 3, 3, 3, 3,	4, 4
		.BYTE 3, 4, 4, 4, 4, 4,	4, 4
.A8
.I16

level_initialization_related:
		SEP	#$20
		STZ	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		STZ	a:.LOWORD(player1_object+player::is_ai) ;	orig=0x0D47
		STZ	a:.LOWORD(player2_object+player::is_ai) ;	orig=0x0D87
		STZ	a:.LOWORD(player3_object+player::is_ai) ;	orig=0x0DC7
		STZ	a:.LOWORD(player4_object+player::is_ai) ;	orig=0x0E07
		LDA	#$20
		STA	a:.LOWORD(player1_object+player::palette) ; orig=0x0D4E
		LDA	#$20
		STA	a:.LOWORD(player2_object+player::palette) ; orig=0x0D8E
		LDA	#$20
		STA	a:.LOWORD(player3_object+player::palette) ; orig=0x0DCE
		LDA	#$20
		STA	a:.LOWORD(player4_object+player::palette) ; orig=0x0E0E
		STZ	a:.LOWORD(player1_object+player::palette+1) ; orig=0x0D4F
		STZ	a:.LOWORD(player2_object+player::palette+1) ; orig=0x0D8F
		STZ	a:.LOWORD(player3_object+player::palette+1) ; orig=0x0DCF
		STZ	a:.LOWORD(player4_object+player::palette+1) ; orig=0x0E0F
		LDA	#0
		STA	a:.LOWORD(player1_object+player::real_palette) ; orig=0x0D5F
		LDA	#2
		STA	a:.LOWORD(player2_object+player::real_palette) ; orig=0x0D9F
		LDA	#$A
		STA	a:.LOWORD(player3_object+player::real_palette) ; orig=0x0DDF
		LDA	#8
		STA	a:.LOWORD(player4_object+player::real_palette) ; orig=0x0E1F
		LDA	a:.LOWORD(current_mode) ; orig=0x0C3C
		CMP	#3
		BEQ	loc_C47918
		JML	f:locret_C47A28
; ---------------------------------------------------------------------------

loc_C47918:
		STZ	a:.LOWORD(player1_object+player::gameover_related)	; orig=0x0D44
		STZ	a:.LOWORD(player2_object+player::gameover_related)	; orig=0x0D84
		STZ	a:.LOWORD(player3_object+player::gameover_related)	; orig=0x0DC4
		STZ	a:.LOWORD(player4_object+player::gameover_related)	; orig=0x0E04
		LDA	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		CLC
		ADC	a:.LOWORD(level_manager_object+level_manager_object::gameover_related+1) ; orig=0x0D33
		STA	a:.LOWORD(level_manager_object+level_manager_object::enemy_count) ; orig=0x0D25
		LDA	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		STA	a:.LOWORD(level_manager_object+level_manager_object::number_of_human_players) ; orig=0x0D36
		LDA	a:.LOWORD(level_manager_object+level_manager_object::gameover_related+1) ; orig=0x0D33
		STA	a:.LOWORD(level_manager_object+level_manager_object::number_of_ai_players) ; orig=0x0D37
		LDA	#.BANKBYTE(byte_C47820)
		STA	z:$5E
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C47820)
		STA	z:$5C
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$208
		BEQ	loc_C47952
		LDA	#.LOWORD(byte_C47840)
		STA	z:$5C

loc_C47952:
		REP	#$20
		LDA	z:$53
		PHA
		LDA	z:$50
		PHA
		LDA	z:$51
		PHA
		LDA	#$C5F
		STA	z:$53
		LDX	#$D40
		LDY	#0

loc_C47968:
		SEP	#$20
.A8
		LDA	($53)
		BEQ	loc_C479A8
		CMP	#2
		BNE	loc_C47976
		JML	f:loc_C479CC
; ---------------------------------------------------------------------------

loc_C47976:
		REP	#$20
.A16
		LDA	#.LOWORD(handle_player_movement_0)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(handle_player_movement_0)
		STA	z:2,X
		LDA	#1
		STA	z:7,X
		LDA	a:.LOWORD(word_7E0C63) ; orig=0x0C63
		ASL
		ASL
		STA	z:$40
		LDA	#0
		XBA
		LDA	z:5,X
		SEC
		SBC	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		SEC
		SBC	#3
		EOR	#$FF
		INC
		ORA	z:$40
		PHX
		TAX
		LDA	f:byte_C478A0,X
		PLX
		STA	z:$3D,X

loc_C479A8:
		SEP	#$20
		LDA	#$FF
		STA	z:4,X
		REP	#$20
.A16
		LDA	[$5C],Y
		STA	z:$11,X
		INY
		INY
		LDA	[$5C],Y
		STA	z:$14,X
		INY
		INY
		INY
		INY
		INY
		INY
		TYA
		LSR
		LSR
		LSR
		DEC
		STA	a:.LOWORD($13E),X
		JSL	f:sub_C47770
.A8

loc_C479CC:
		REP	#$20
.A16
		TXA
		CLC
		ADC	#$40
		TAX
		INC	z:$53
		LDA	z:$53
		CMP	#$C63
		BEQ	loc_C479E1
		JML	f:loc_C47968
; ---------------------------------------------------------------------------

loc_C479E1:
		LDX	#$D40
		LDA	#$C5F
		STA	z:$53

loc_C479E9:
		LDA	($53)
		BIT	#2
		BEQ	loc_C47A0C
		LDA	[$5C],Y
		STA	z:$11,X
		INY
		INY
		LDA	[$5C],Y
		STA	z:$14,X
		INY
		INY
		INY
		INY
		INY
		INY
		TYA
		LSR
		LSR
		LSR
		DEC
		STA	a:.LOWORD($13E),X
		JSL	f:sub_C47770

loc_C47A0C:
		TXA
		CLC
		ADC	#$40
		TAX
		INC	z:$53
		LDA	z:$53
		CMP	#$C63
		BEQ	loc_C47A1F
		JML	f:loc_C479E9
; ---------------------------------------------------------------------------

loc_C47A1F:
		PLA
		STA	z:$51
		PLA
		STA	z:$50
		PLA
		STA	z:$53
.A8

locret_C47A28:
		RTL
; End of function level_initialization_related

.A16
.I16

sub_C47A29:
		REP	#$20
		JSL	f:tilemap_decompression
		LDA	#$5000
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
; End of function sub_C47A29

.A16
.I16

sub_C47A4F:
		REP	#$20
		JSL	f:tilemap_decompression
		LDA	#$5000
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
		REP	#$20
.A16
		LDX	#0
		LDY	#0

loc_C47A7C:
		LDA	f:$7E4800,X
		STA	a:.LOWORD(bg1_tilemap),Y
		INX
		INX
		INY
		INY
		CPY	#$322
		BNE	loc_C47A7C
		RTL
; End of function sub_C47A4F

.A16
.I16

sub_C47A8D:
		REP	#$20
		JSL	f:tilemap_decompression
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
; End of function sub_C47A8D

.A16
.I16

tilemap_decompression:
		SEP	#$20
.A8
		LDA	z:$55
		PHA
		PLB
		REP	#$20
.A16
		LDY	z:$53
		PHX
		LDX	#0
		LDA	#1
		STA	z:$44

loc_C47AC6:
		DEC	z:$44
		BNE	loc_C47AE0
		LDA	#$10
		STA	z:$44
		LDA	#0
		STA	z:$46
		LDA	#0
		STA	z:$48
		LDA	a:.LOWORD(0),Y
		STA	z:$40
		INY
		INY

loc_C47AE0:
		ASL	z:$40
		BCC	loc_C47AF2
		LDA	a:.LOWORD(0),Y
		STA	z:$46
		INY
		INY
		LDA	a:.LOWORD(0),Y
		STA	z:$48
		INY
		INY

loc_C47AF2:
		LDA	z:$46
		STA	f:$7E4800,X
		LDA	z:$48
		STA	f:$7E4802,X
		INX
		INX
		INX
		INX
		CPX	#$800
		BNE	loc_C47AC6
		PLX
		SEP	#$20
.A8
		LDA	#0
		PHA
		PLB
		REP	#$20
.A16
		RTL
; End of function tilemap_decompression

.A8
.I16

sub_C47B11:
		REP	#$20
.A16
		LDA	#$5000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$800
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(empty_tilemap)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(empty_tilemap)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		RTL
; End of function sub_C47B11

.A16
.I16

sub_C47B33:
		REP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		AND	#$FF
		CMP	#$30
		BNE	loc_C47B44
		JML	f:sub_C47A29
; ---------------------------------------------------------------------------

loc_C47B44:
		CMP	#$39
		BNE	loc_C47B4D
		JML	f:sub_C47A4F
; ---------------------------------------------------------------------------

loc_C47B4D:
		PHX
		LDX	#0
		LDA	#1
		STA	z:$44

loc_C47B56:
		DEC	z:$44
		BNE	loc_C47B67
		LDA	#$10
		STA	z:$44
		LDA	[$53]
		STA	z:$40
		INC	z:$53
		INC	z:$53

loc_C47B67:
		LDA	#0
		STA	z:$42
		ASL	z:$40
		BCC	loc_C47B75
		LDA	#HARD_BLOCK
		STA	z:$42

loc_C47B75:
		LDA	z:$42
		STA	f:$7E4800,X
		INX
		INX
		CPX	#$1C0
		BNE	loc_C47B56
		LDX	#0
		LDA	#1
		STA	z:$44
		LDA	#0
		STA	z:$46
		LDA	#0
		STA	z:$48

loc_C47B94:
		DEC	z:$44
		BNE	loc_C47BA5
		LDA	#$10
		STA	z:$44
		LDA	[$53]
		STA	z:$40
		INC	z:$53
		INC	z:$53

loc_C47BA5:
		ASL	z:$40
		BCC	loc_C47BB9
		LDA	[$53]
		STA	z:$46
		INC	z:$53
		INC	z:$53
		LDA	[$53]
		STA	z:$48
		INC	z:$53
		INC	z:$53

loc_C47BB9:
		LDA	z:$46
		STA	f:$7E4A00,X
		LDA	z:$48
		STA	f:$7E4A02,X
		INX
		INX
		INX
		INX
		CPX	#$1BC
		BNE	loc_C47B94
		LDX	#0
		LDY	#0
		LDA	#13		; 13 rows
		STA	z:$44

loc_C47BD9:				; Expand the maps from 17 rows to 32 rows
		LDA	#17
		STA	z:$42

loc_C47BDE:
		LDA	f:$7E4A00,X
		STA	a:.LOWORD(bg1_tilemap),Y
		STA	a:.LOWORD(bg1_tilemap+$20),Y
		LDA	f:$7E4800,X
		STA	a:.LOWORD(collision_map),Y
		INX
		INX
		INY
		INY
		DEC	z:$42
		BNE	loc_C47BDE
		TYA
		CLC
		ADC	#(32 - 17) * 2
		TAY
		DEC	z:$44
		BNE	loc_C47BD9
		PLX
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ; orig=0x0D38
		BIT	#$8000
		BNE	loc_C47C25
		SEP	#$20
.A8
		LDA	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		CMP	#$31
		BEQ	loc_C47C32
		REP	#$20
.A16
		LDA	a:.LOWORD(bg1_tilemap+$86)	; orig=0x057A ;	The first (top left) hard block
		STA	a:.LOWORD(bg1_tilemap+$24)	; orig=0x0518 ;	Special	place in the tile map to store the Hard	Block tile
		LDA	a:.LOWORD(bg1_tilemap+$44)	; orig=0x0538 ;	The top	left empty spot
		AND	#$1C00		; Only take the	palette. Shadow	tiles are always:
					; 4 for	no shadow
					; 5 for	soft-block shadow
					; 6 for	hard-block shadow
		STA	a:.LOWORD(bg1_tilemap+$22)	; orig=0x0516 ;	And another one	for the	empty tile.
		RTL
; ---------------------------------------------------------------------------

loc_C47C25:
		LDA	#$804
		STA	a:.LOWORD(bg1_tilemap+$24)	; orig=0x0518 ;	Special	place in the tile map to store the Hard	Block tile
		LDA	#$808
		STA	a:.LOWORD(bg1_tilemap+$22)	; orig=0x0516 ;	And another one	for the	empty tile.
		RTL
; ---------------------------------------------------------------------------

loc_C47C32:				; clear	screen	AFTER ALL THE HARD WORK
		REP	#$20
		LDY	#0
		LDA	#13
		STA	z:$44

loc_C47C3C:
		LDA	#17
		STA	z:$42
		LDA	#0

loc_C47C44:
		STA	a:.LOWORD(bg1_tilemap+$20),Y
		INY
		INY
		DEC	z:$42
		BNE	loc_C47C44
		TYA
		CLC
		ADC	#(32 - 17) * 2
		TAY
		DEC	z:$44
		BNE	loc_C47C3C
		RTL
; End of function sub_C47B33
; End of function sub_C47B33

.A16
.I16

sub_C47C58:
		SEP	#$20
.A8
		LDA	z:$52
		PHA
		LDA	#.BANKBYTE(byte_7E3400)
		STA	z:$52
		STA	z:$55
		LDA	#$60
		STA	z:$40
		REP	#$20
.A16
		LDA	z:$50
		PHA
		LDA	#.LOWORD(byte_7E3400)
		STA	z:$50
		LDA	#.LOWORD(byte_7E3400+$10)
		STA	z:$53
		LDY	#$FFF0

loc_C47C79:
		REP	#$20
		TYA
		CLC
		ADC	#$10
		TAY
		LDA	z:$40
		AND	#$11
		ASL
		TAX
		LDA	f:byte_C47F9E,X
		TAX
		SEP	#$20
.A8
		LDA	#7
		STA	z:$41

loc_C47C93:
		LDA	[$50],Y
		ORA	[$53],Y
		INY
		ORA	[$50],Y
		ORA	[$53],Y
		EOR	#$FF
		STA	z:$44
		STA	z:$45
		DEY
		REP	#$20
.A16
		LDA	f:$7E2800,X
		AND	z:$44
		ORA	[$50],Y
		STA	[$50],Y
		LDA	f:$7E2810,X
		AND	z:$44
		ORA	[$53],Y
		STA	[$53],Y
		SEP	#$20
.A8
		INY
		INY
		INX
		INX
		DEC	z:$41
		BPL	loc_C47C93
		INC	z:$40
		BNE	loc_C47C79
		REP	#$20
.A16
		PLA
		STA	z:$50
		SEP	#$20
.A8
		PLA
		STA	z:$52
		RTL
; End of function sub_C47C58

.A8
.I16

battle_stage_loader:
		JSL	f:sub_C46E0E
		SEP	#$20
		LDA	#.BANKBYTE(stage_1_1)
		STA	z:$52
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:screen_music_table,X
		AND	#$FF
		TAY
		JSL	f:play_music
		REP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		AND	#$FF
		ASL
		TAX
		LDA	f:screens_table,X
		STA	z:$50
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_8) ; orig=0x0D30
		STA	a:.LOWORD(current_mode) ; orig=0x0C3C
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_10) ; orig=0x0D3A
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDX	#0
		LDA	#$2000
		STA	z:$40
		JSL	f:graphics_decompression_81aa_terminated_interleaved
		SEP	#$20
.A8
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C47D48:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C47D48
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$1C00
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$800
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(byte_7E3400)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_7E3400)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		REP	#$20
.A16
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDX	#$C00
		LDA	#$2000
		STA	z:$40
		JSL	f:graphics_decompression_81aa_terminated_interleaved
		JSL	f:sub_C47C58
		SEP	#$20
.A8
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C47D9A:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C47D9A
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$600
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1400
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(byte_7E3400)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_7E3400)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		REP	#$20
.A16
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDX	#0
		LDA	#$2000
		STA	z:$40
		JSL	f:graphics_decompression_81aa_terminated_interleaved
		SEP	#$20
.A8
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C47DE8:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C47DE8
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$2000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		SEP	#$20
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C47E18:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C47E18
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$2800
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(byte_7E3400+$400)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_7E3400+$400)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		LDX	#$D00
		JSL	f:level_initialization_related
		JSL	f:hud_related_0
		REP	#$20
.A16
		LDA	z:$50
		CLC
		ADC	#$C
		STA	z:$50
		LDA	[$50]
		STA	z:$53
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		REP	#$20
		LDA	z:$50
		PHA
		JSL	f:call_function_at_0053
		REP	#$20
		PLA
		STA	z:$50
		JSL	f:sub_C475A1
		REP	#$20
		LDA	z:$50
		PHA
		LDA	z:$51
		PHA
		JSL	f:update_palettes
		REP	#$20
		PLA
		STA	z:$51
		PLA
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(graphics_table)
		STA	z:$55
		REP	#$20
.A16
		LDA	#graphics_table	- unk_7F0000
		STA	z:$53
		JSL	f:graphics_decompression_8192_bytes
		SEP	#$20
.A8
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C47EA2:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C47EA2
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$6000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:graphics_decompression_8192_bytes
		SEP	#$20
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C47ED6:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C47ED6
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$6800
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:graphics_decompression_8192_bytes
		SEP	#$20
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C47F0A:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C47F0A
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$7000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:graphics_decompression_8192_bytes
		SEP	#$20
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C47F3E:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C47F3E
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$7800
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:sub_C61F91
		PLX
		SEP	#$20
		LDA	#$20
		STA	z:$21,X
		LDA	#%11100000
		STA	a:.LOWORD(FIXED_COLOR_DATA)
		LDA	#8
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		REP	#$20
.A16
		LDA	#.LOWORD(_screen_loader_object)
		STA	z:object::handler,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_screen_loader_object)
		STA	z:object::handler+2,X

_screen_loader_object:
		SEP	#$20
		DEC	z:$21,X
		BEQ	loc_C47F95
		JML	f:locret_C463DD
; ---------------------------------------------------------------------------

loc_C47F95:
		LDA	#0
		STA	a:.LOWORD(game_flags) ; orig=0x0314
		JML	f:delete_object
; End of function battle_stage_loader

; ---------------------------------------------------------------------------
byte_C47F9E:	.BYTE 0, 1, $20, 1, 0, 0, 0, 0
		.BYTE 0, 0, 0, 0, 0, 0,	0, 0
		.BYTE 0, 0, 0, 0, 0, 0,	0, 0
		.BYTE 0, 0, 0, 0, 0, 0,	0, 0
		.BYTE 0, 3, $20, 3
DATA_END