segment "BANK4"

score_popup_s = 0

if USE_MULTI5_BIOS
aStartOfMulti5B:
 db "START OF MULTI5 BIOS"
multi5_read_input:
    PHP
    SEP #0x30
    STZ a:addr(multitap_status) ; orig=0x0CE0

.loc_C4001A:        ; Wait for auto-joypad to complete
    LDA a:addr(H_V_BLANK_FLAGS_AND_JOYPAD_STATUS)
    AND #1
    BNE .loc_C4001A
    LDA a:addr(JOYPAD_1_DATA_HIGH_BYTE)
    STA a:addr(joypad_1+1) ; orig=0x0CE2
    LDA a:addr(JOYPAD_1_DATA_LOW_BYTE)
    STA a:addr(joypad_1) ; orig=0x0CE1
    AND #0xF
    STA a:addr(joypad_1_connected) ; orig=0x0CEB
    LDA a:addr(0x4016)
    LSR A
    ROL a:addr(joypad_1_connected) ; orig=0x0CEB
    LDA a:addr(JOYPAD_2_DATA_HIGH_BYTE)
    STA a:addr(joypad_2+1) ; orig=0x0CE4
    LDA a:addr(JOYPAD_2_DATA_LOW_BYTE)
    STA a:addr(joypad_2) ; orig=0x0CE3
    AND #0xF
    STA a:addr(joypad_2_connected) ; orig=0x0CEC
    LDA a:addr(JOYPAD_4_DATA_HIGH_BYTE)
    STA a:addr(joypad_3+1) ; orig=0x0CE6
    LDA a:addr(JOYPAD_4_DATA_LOW_BYTE)
    STA a:addr(joypad_3) ; orig=0x0CE5
    AND #0xF
    STA a:addr(joypad_3_connected) ; orig=0x0CED
    LDA a:addr(0x4017)
    LSR A
    ROL a:addr(joypad_2_connected) ; orig=0x0CEC
    LSR A
    ROL a:addr(joypad_3_connected) ; orig=0x0CED
    STZ a:addr(PROGRAMMABLE_I_O_PORT_OUTPUT)
    LDY #0x10

.loc_C4006B:
    LDA a:addr(0x4017)
    REP #0x20
    LSR A
    ROL a:addr(joypad_4) ; orig=0x0CE7
    LSR A
    ROL a:addr(joypad_5) ; orig=0x0CE9
    SEP #0x20
    DEY
    BNE .loc_C4006B
    LDA a:addr(joypad_4) ; orig=0x0CE7
    AND #0xF
    STA a:addr(joypad_4_connected) ; orig=0x0CEE
    LDA a:addr(joypad_5) ; orig=0x0CE9
    AND #0xF
    STA a:addr(joypad_5_connected) ; orig=0x0CEF
    LDA a:addr(0x4017)
    LSR A
    ROL a:addr(joypad_4_connected) ; orig=0x0CEE
    LSR A
    ROL a:addr(joypad_5_connected) ; orig=0x0CEF
    LDA #0x80
    STA a:addr(PROGRAMMABLE_I_O_PORT_OUTPUT)
    PLP
    RTS

db "MODIFIED FROM SHVC MULTI5 BIOS Ver2.00"
db "END OF MULTI5 BIOS"
multi5_update_multitap_status:
    PHP
    SEP #0x30
    STZ a:addr(multitap_status) ; orig=0x0CE0

.loc_C400DD:        ; Wait for auto-joypad to finish
    LDA a:addr(H_V_BLANK_FLAGS_AND_JOYPAD_STATUS)
    AND #1
    BNE .loc_C400DD
    STZ a:addr(0x4016)
    LDA #1
    STA a:addr(0x4016)
    LDX #8

.loc_C400EE:
    LDA a:addr(0x4016)
    LSR A
    LSR A
    ROL $az:addr(word_7E0040+1) ; orig=0x0041
    LDA a:addr(0x4017)
    LSR A
    LSR A
    ROL $az:addr(word_7E0042+1) ; orig=0x0043
    DEX
    BNE .loc_C400EE
    STZ a:addr(0x4016)
    LDX #8

.loc_C40106:
    LDA a:addr(0x4016)
    LSR A
    LSR A
    ROL $az:addr(word_7E0040) ; orig=0x0040
    LDA a:addr(0x4017)
    LSR A
    LSR A
    ROL $az:addr(word_7E0042) ; orig=0x0042
    DEX
    BNE .loc_C40106
    LDA $az:addr(word_7E0040+1) ; orig=0x0041
    CMP #0xFF
    BNE .loc_C4012C
    LDA $az:addr(word_7E0040) ; orig=0x0040
    CMP #0xFF
    BEQ .loc_C4012C
    LDA #0x80
    STA a:addr(multitap_status) ; orig=0x0CE0

.loc_C4012C:
    LDA $az:addr(word_7E0042+1) ; orig=0x0043
    CMP #0xFF
    BNE .loc_C40142
    LDA $az:addr(word_7E0042) ; orig=0x0042
    CMP #0xFF
    BEQ .loc_C40142
    LDA #0x40
    ORA a:addr(multitap_status) ; orig=0x0CE0
    STA a:addr(multitap_status) ; orig=0x0CE0

.loc_C40142:
    PLP
    RTS

aModifiedFromSh:
    db "MODIFIED FROM SHVC MULTI5 CONNECT CHECK Ver1.00"
aEndOfMulti5Con:
    db "END OF MULTI5 CONNECT CHECK"
endif ; USE_MULTI5_BIOS

main:
ifndef J
    SEP #0x20
endif
    STZ a:addr(NMI_V_H_COUNT_AND_JOYPAD_ENABLE)
    STZ a:addr(H_DMA_CHANNEL_ENABLE)
    STZ a:addr(REGULAR_DMA_CHANNEL_ENABLE)
    STZ a:addr(REGULAR_DMA_CHANNEL_ENABLE)
    STZ a:addr(APU_I_O_PORT_0)
    STZ a:addr(APU_I_O_PORT_1)
    STZ a:addr(APU_I_O_PORT_2)
    STZ a:addr(APU_I_O_PORT_3)
    LDA #0x8F
    STA a:addr(SCREEN_DISPLAY_REGISTER)
ifdef J
    CLC
    XCE
    SEI
    SEP #0x20
endif
    LDA #0
    PHA
    PLB
    REP #0x30
    LDA #0x2FF
    TCS
    REP #0x20
    LDA #0
    TAX     ; Clear RAM

.loc_C401BD:
    STA f:0x7F0000,X
    INX
    INX
    BNE .loc_C401BD
    LDA #0x2000
    TAX

.loc_C401C9:        ; Clear tilemaps
    STA f:0x7E0000,X
    INX
    INX
    BNE .loc_C401C9
    LDA a:addr(word_7E0C7F) ; orig=0x0C7F
    STA f:temp_uncompressed_graphics
    LDA a:addr(word_7E0C81) ; orig=0x0C81
    STA f:temp_uncompressed_graphics+2
    LDA a:addr(word_7E0C83) ; orig=0x0C83
    STA f:byte3_7E2804
    LDA a:addr(word_7E0C85) ; orig=0x0C85
    STA f:byte3_7E2804+2
    LDA a:addr(word_7E0C87) ; orig=0x0C87
    STA f:byte3_7E2808
    LDA a:addr(word_7E0C89) ; orig=0x0C89
    STA f:byte3_7E2808+2
    LDA a:addr(word_7E0C8B) ; orig=0x0C8B
    STA f:byte3_7E280C
    LDA a:addr(word_7E0C8D) ; orig=0x0C8D
    STA f:byte3_7E280C+2
    LDA #0
    TAX

.loc_C4020D:
    STA f:0,X
    INX
    INX
    CPX #0x2000
    BNE .loc_C4020D
    LDA f:byte3_7E280C
    STA a:addr(word_7E0C8B) ; orig=0x0C8B
    LDA f:byte3_7E280C+2
    STA a:addr(word_7E0C8D) ; orig=0x0C8D
    LDA a:addr(word_7E0C8B) ; orig=0x0C8B
    CMP #0x6D61
    BNE .loc_C40280
    LDA a:addr(word_7E0C8D) ; orig=0x0C8D
    CMP #0x6B6F
    BNE .loc_C40280
    LDA f:temp_uncompressed_graphics
    CMP f:byte3_7E2804
    BNE .loc_C40280
    CMP f:byte3_7E2808
    BNE .loc_C40280
    LDA f:temp_uncompressed_graphics+2
    CMP f:byte3_7E2804+2
    BNE .loc_C40280
    CMP f:byte3_7E2808+2
    BNE .loc_C40280
    LDA f:temp_uncompressed_graphics
    STA a:addr(word_7E0C7F) ; orig=0x0C7F
    LDA f:temp_uncompressed_graphics+2
    STA a:addr(word_7E0C81) ; orig=0x0C81
    LDA f:byte3_7E2804
    STA a:addr(word_7E0C83) ; orig=0x0C83
    LDA f:byte3_7E2804+2
    STA a:addr(word_7E0C85) ; orig=0x0C85
    LDA f:byte3_7E2808
    STA a:addr(word_7E0C87) ; orig=0x0C87
    LDA f:byte3_7E2808+2
    STA a:addr(word_7E0C89) ; orig=0x0C89

.loc_C40280:
    LDA #0x6D61
    STA a:addr(word_7E0C8B) ; orig=0x0C8B
    LDA #0x6B6F
    STA a:addr(word_7E0C8D) ; orig=0x0C8D
    JSL interrupt_register_init
    JSL gpu_registers_init
    JSL init_dboot
    JSL dboot_related_
    JSL unknown_init_
    JSL dma_reset
    REP #0x20
    LDA #0x4000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(bg3_tileset_graphic)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(bg3_tileset_graphic)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDA #0x58C0
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x680
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(bg3_ram_map)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(bg3_ram_map)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDA #0x3FF
    STA a:addr(bg3_v_scroll_2) ; orig=0x0CA7
    REP #0x20
    LDA #addr(sub_C4633F)
    STA a:addr(level_manager_object+object.handler) ; orig=0x0D00
    SEP #0x20
    LDA #bank(sub_C4633F)
    STA a:addr(level_manager_object+object.handler+2) ; orig=0x0D02
ifndef J
; Moved up
    REP #0x20
    LDA #addr(nullsub_1)
    STA $az2:addr(unknown_function_pointer) ; orig=0x00D0
    SEP #0x20
    LDA #bank(nullsub_1)
    STA $az2:addr(unknown_function_pointer+2) ; orig=0x00D2
endif
    SEP #0x20
    CLI
ifdef J
    LDA #0xB1
    STA a:addr(NMI_V_H_COUNT_AND_JOYPAD_ENABLE)
endif
    LDA #0x20
    STA a:addr(V_COUNT_TIMER)
    LDA #0xB8
    STA a:addr(H_COUNT_TIMER)
ifdef J
    REP #0x20
    LDA #addr(nullsub_1)
    STA a:addr(unknown_function_pointer) ; orig=0x00D0
    SEP #0x20
    LDA #bank(nullsub_1)
    STA a:addr(unknown_function_pointer+2) ; orig=0x00D2
    SEP #0x20
else
    LDA #0xB1
    STA a:addr(NMI_V_H_COUNT_AND_JOYPAD_ENABLE)
endif
    LDA #0x17
    STA a:addr(main_screen_status) ; orig=0x0C97
    LDA #0x17
    STA a:addr(subscreen_status) ; orig=0x0C98
    LDA #1
    STA a:addr(CYCLE_SPEED_DESIGNATION)
    LDA #0b111001
    STA a:addr(BG_MODE_AND_TILE_SIZE_SETTING)
    LDA #0x8F
    STA a:addr(word_7E031A) ; orig=0x031A
    REP #0x20
    LDY #0
    JSL dboot_19
    REP #0x30
wait_for_vblank:
    SEP #0x20
    LDA a:addr(screen_flags) ; orig=0x0312
    BIT #1
    BEQ wait_for_vblank
    SEP #0x20
    LDA #0x8F
    STA a:addr(SCREEN_DISPLAY_REGISTER)
    STZ a:addr(H_DMA_CHANNEL_ENABLE)
    JSL transfer_oam
    JSL transfer_bg1_bg3_tilemaps
    JSL sub_C62460
    SEP #0x20
    LDA a:addr(word_7E031A) ; orig=0x031A
    STA a:addr(SCREEN_DISPLAY_REGISTER)
    LDA a:addr(byte_7E0CA9) ; orig=0x0CA9
    STA a:addr(MOSAIC_SIZE_AND_BG_ENABLE)
    JSL update_bg_scrolling
    JSL handle_player_input
ifdef DEBUG
    JSL transfer_debug_menu_to_vram
    JSL clear_vs_check_graphics
endif
    REP #0x20
    LDA #addr(player_2.anonymous_6)
    STA a:addr(word_7E00BE) ; orig=0x00BE
    LDA #addr(player_1.anonymous_6)
    STA a:addr(level_manager_object.hit_flags) ; orig=0x0D28
    LDA #0xFFFF
    STA a:addr(player_1.anonymous_6) ; orig=0x0D68
    REP #0x20
    LDA #addr(unk_7F0000)
    STA a:addr(word_7E0306) ; orig=0x0306
    SEP #0x20
    LDA #bank(unk_7F0000)
    STA a:addr(word_7E0308) ; orig=0x0308
    REP #0x20
    LDX #addr(level_manager_object)
    LDA a:addr(level_manager_object+object.handler+1) ; orig=0x0D01
    STA $az:addr(byte_7E0051)
    LDA a:addr(level_manager_object+object.handler) ; orig=0x0D00
    STA $az:addr(byte_7E0050) ; orig=0x0050
    JSL call_function_at_0050
    REP #0x20
    LDX #addr(player_1)
    LDA #4

.loc_C403B7:
    PHA
    STX a:addr(word_7E0310) ; orig=0x0310
    LDA $az:addr(player.gameover_related),X
    BIT #1
    BEQ .loc_C403D5
    LDA $az:addr(object.handler+1),X
    STA $az:addr(byte_7E0051) ; orig=0x0051
    LDA $az:addr(object.handler),X
    STA $az:addr(byte_7E0050) ; orig=0x0050
    JSL call_function_at_0050
    REP #0x20

.loc_C403D5:
    LDA a:addr(word_7E0310) ; orig=0x0310
    CLC
    ADC #0x40
    TAX
    PLA
    DEC A
    BNE .loc_C403B7
    LDX #addr(enemy_objects)

.loc_C403E4:
    LDA $az:addr(1),X
    STA $az:addr(byte_7E0051) ; orig=0x0051
    LDA $az:addr(0),X
    STA $az:addr(byte_7E0050) ; orig=0x0050
    JSL call_function_at_0050
    REP #0x20
    LDA $az:addr(6),X
    TAX
    INC A
    BNE .loc_C403E4
    REP #0x20
    LDY a:addr(level_manager_object.hit_flags) ; orig=0x0D28

.loc_C40402:
    LDX a: addr(2),Y
    LDA a: addr(0),Y
    CMP #0xFFFF
    BEQ .loc_C40417
    PHA
    JSL sub_C625D3
    PLY
    REP #0x20
    BRA .loc_C40402

.loc_C40417:
    REP #0x20
    LDX #addr(unk_7E1C80)

.loc_C4041C:
    LDA $az:addr(6),X
    CMP #0xFFFF
    BEQ .loc_C4043A
    PHA
    LDA #0xC4
    STA $az:addr(byte_7E0052) ; orig=0x0052
    LDA $az:addr(0),X
    STA $az:addr(byte_7E0050) ; orig=0x0050
    JSL call_function_at_0050
    REP #0x20
    PLX
    BRA .loc_C4041C

.loc_C4043A:
    JSL related_to_oam_transfer
    JSL update_palettes
    SEP #0x20
    LDA a:addr(screen_flags) ; orig=0x0312
    AND #0xFE
    STA a:addr(screen_flags) ; orig=0x0312
    JMP a:addr(wait_for_vblank)

call_function_at_0050:
    JML [0x50]
    RTI

update_bg_scrolling:
    SEP #0x20
    LDA a:addr(bg1_h_scroll) ; orig=0x0C9D
    STA a:addr(BG_1_H_SCROLL_OFFSET)
    LDA a:addr(bg1_h_scroll+1) ; orig=0x0C9E
    STA a:addr(BG_1_H_SCROLL_OFFSET)
    LDA a:addr(bg1_v_scroll) ; orig=0x0C9F
    STA a:addr(BG_1_V_SCROLL_OFFSET)
    LDA a:addr(bg1_v_scroll+1) ; orig=0x0CA0
    STA a:addr(BG_1_V_SCROLL_OFFSET)
    LDA a:addr(bg2_h_scroll) ; orig=0x0CA1
    STA a:addr(BG_2_H_SCROLL_OFFSET)
    LDA a:addr(bg2_h_scroll+1) ; orig=0x0CA2
    STA a:addr(BG_2_H_SCROLL_OFFSET)
    LDA a:addr(bg2_v_scroll) ; orig=0x0CA3
    STA a:addr(BG_2_V_SCROLL_OFFSET)
    LDA a:addr(bg2_v_scroll+1) ; orig=0x0CA4
    STA a:addr(BG_2_V_SCROLL_OFFSET)
    RTL

transfer_bg1_bg3_tilemaps:
    SEP #0x20
    LDA a:addr(level_manager_object.fade_related_) ; orig=0x0D10
    CMP #0x30
    BEQ .locret_C404DF
    LDA #1
    STA a:addr(DMA_5_PARAMS)
    STA a:addr(DMA_6_PARAMS)
    LDA #0x18
    STA a:addr(DMA_5_B_ADDRESS)
    STA a:addr(DMA_6_B_ADDRESS)
    REP #0x20
    LDA #0x5000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x322
    STA a:addr(DMA_5_BYTES_COUNT_LOW_BYTE)
    LDA #addr(bg1_tilemap)
    STA a:addr(DMA_5_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #0
    STA a:addr(DMA_5_A_ADDRESS_BANK)
    LDA #0x20
    STA a:addr(REGULAR_DMA_CHANNEL_ENABLE)
    REP #0x20
    LDA #0x5800
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x100
    STA a:addr(DMA_6_BYTES_COUNT_LOW_BYTE)
    LDA #0x816
    STA a:addr(DMA_6_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #0
    STA a:addr(DMA_6_A_ADDRESS_BANK)
    LDA #0x40
    STA a:addr(REGULAR_DMA_CHANNEL_ENABLE)

.locret_C404DF:
    RTL

vblank:
    REP #0x30
    PHB
    PHA
    PHX
    PHY
    SEP #0x30
    LDA #0
    PHA
    PLB
    CMP f:NMI_ENABLE
    LDA f:addr(screen_flags) ; orig=0x0312
    BIT #1
    BNE .loc_C404FE
    ORA #1
    STA f:addr(screen_flags) ; orig=0x0312

.loc_C404FE:
    LDA a:addr(current_mode) ; orig=0x0C3C
    BIT #2
    BEQ .loc_C40525
    LDA #4
    STA a:addr(BG_AND_OBJECT_ENABLE_MAIN_SCREEN)
    LDA #0
    STA a:addr(BG_AND_OBJECT_ENABLE_SUB_SCREEN)
    LDA #0
    STA a:addr(INITIAL_SETTINGS_FOR_COLOR_ADDITION)
    LDA #0
    STA a:addr(ADD_SUBTRACT_SELECT_AND_ENABLE)
    LDA a:addr(bg3_v_scroll_2) ; orig=0x0CA7
    STA a:addr(BG_3_V_SCROLL_OFFSET)
    LDA a:addr(bg3_v_scroll_2+1) ; orig=0x0CA8
    STA a:addr(BG_3_V_SCROLL_OFFSET)

.loc_C40525:
    REP #0x30
    INC a:addr(frame_count) ; orig=0x0300
    PLY
    PLX
    PLA
    PLB
    RTI

irq:
    REP #0x30
    PHB
    PHA
    PHX
    PHY
    SEP #0x30
    LDA #0
    PHA
    PLB
    LDA a:addr(IRQ_FLAG_BY_H_V_COUNT_TIMER)
    BPL .loc_C40572
    LDA a:addr(bg3_v_scroll) ; orig=0x0CA5
    STA a:addr(BG_3_V_SCROLL_OFFSET)
    LDA a:addr(bg3_v_scroll+1) ; orig=0x0CA6
    STA a:addr(BG_3_V_SCROLL_OFFSET)
    LDA a:addr(main_screen_status) ; orig=0x0C97
    STA a:addr(BG_AND_OBJECT_ENABLE_MAIN_SCREEN)
    LDA a:addr(subscreen_status) ; orig=0x0C98
    STA a:addr(BG_AND_OBJECT_ENABLE_SUB_SCREEN)
    LDA a:addr(color_addition_settings) ; orig=0x0C99
    STA a:addr(INITIAL_SETTINGS_FOR_COLOR_ADDITION)
    LDA a:addr(add_substract_select_and_enable) ; orig=0x0C9A
    STA a:addr(ADD_SUBTRACT_SELECT_AND_ENABLE)
    JSL call_function_at_00d0
    LDA #0x81
    STA a:addr(NMI_V_H_COUNT_AND_JOYPAD_ENABLE)
    LDA #0xB1
    STA a:addr(NMI_V_H_COUNT_AND_JOYPAD_ENABLE)

.loc_C40572:
    REP #0x30
    PLY
    PLX
    PLA
    PLB
    RTI

call_function_at_00d0:
    JML [0xD0]
    RTI

nullsub_1:
    RTL

gameover_writing_object:
i16
    REP #0x20
    LDA #addr(.loc_C40592)
    STA $az:addr(0),X
    SEP #0x20
    LDA #bank(.loc_C40592)
    STA $az:addr(2),X
    REP #0x20
    STZ $az:addr(0x20),X

.loc_C40592:
    SEP #0x20
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #2    ; single object.handler
    BEQ .loc_C4059F
    JML nullsub_2

.loc_C4059F:
    REP #0x20
    INC $az:addr(0x20),X
    LDA $az:addr(0x20),X
    STA $az:addr(word_7E0048) ; orig=0x0048
    PHX
    LDX #addr(player_1)
    JSL write_gameover_for_player_if_needed
    LDX #addr(player_2)
    JSL write_gameover_for_player_if_needed
    PLX
    RTL

write_gameover_for_player_if_needed:
    REP #0x20
    LDA $az:addr(4),X
    BIT #0xFF
    BEQ .loc_C405C9
    JML nullsub_2

.loc_C405C9:
    TXA
    EOR #0xC0        ; Clever way to get the other object.handler
    TAY
    LDA #0x46
    STA $az:addr(word_7E0040) ; orig=0x0040
    LDA $az:addr(5),X
    AND #0xFF
    BEQ .loc_C405E2
    LDA #0x68
    STA $az:addr(word_7E0040) ; orig=0x0040

.loc_C405E2:
    LDA a:addr(level_manager_object.gameover_related) ; orig=0x0D32
    AND #0xFF
if SHORT_GAMEOVER_BRANCH
 BEQ write_gameover
else
    BNE .loc_C405EE
    JML write_gameover
endif

.loc_C405EE:
    LDA a:addr(0x3D),Y
    AND #0xFF
    BNE .loc_C405FA
    JML write_gameover

.loc_C405FA:
    LDY $az:addr(word_7E0040) ; orig=0x0040
    LDA #0xB
    STA $az:addr(word_7E0040) ; orig=0x0040
    REP #0x20
    LDA #addr(word_C30B2A)
    STA $az:addr(byte_7E0050) ; orig=0x0050
    SEP #0x20
    LDA #bank(word_C30B2A)
    STA $az:addr(byte_7E0052) ; orig=0x0052
    JSL copy_to_bg3_tilemap
    REP #0x20
    TYA
    CLC
    ADC #0x2A
    TAY
    LDA #0xB
    STA $az:addr(word_7E0040) ; orig=0x0040
    JSL copy_to_bg3_tilemap
    RTL

hud_related:
    REP #0x20
    LDA #0xB
    STA $az:addr(word_7E0040) ; orig=0x0040
    REP #0x20
    LDA #addr(storymode_hud_tilemap+0x46)
    STA $az:addr(byte_7E0050) ; orig=0x0050
    SEP #0x20
    LDA #bank(storymode_hud_tilemap+0x46)
    STA $az:addr(byte_7E0052) ; orig=0x0052
    JSL copy_to_bg3_tilemap
    REP #0x20
    TYA
    CLC
    ADC #0x2A
    TAY
    LDA #0xB
    STA $az:addr(word_7E0040) ; orig=0x0040
    REP #0x20
    LDA #addr(storymode_hud_tilemap+0x86)
    STA $az:addr(byte_7E0050) ; orig=0x0050
    SEP #0x20
    LDA #bank(storymode_hud_tilemap+0x86)
    STA $az:addr(byte_7E0052) ; orig=0x0052
    JSL copy_to_bg3_tilemap
    REP #0x20
    STZ $az:addr(word_7E0040) ; orig=0x0040
    STZ $az:addr(word_7E0042) ; orig=0x0042
    JSL add_to_score
    RTL

write_gameover:
    REP #0x20
    LDY $az:addr(word_7E0040) ; orig=0x0040
    LDA #0xB
    STA $az:addr(word_7E0040) ; orig=0x0040
    REP #0x20
    LDA #addr(gameover_tilemap_top)
    STA $az:addr(byte_7E0050) ; orig=0x0050
    SEP #0x20
    LDA #bank(gameover_tilemap_top)
    STA $az:addr(byte_7E0052) ; orig=0x0052
    JSL copy_to_bg3_tilemap
    REP #0x20
    TYA
    CLC
    ADC #0x2A
    TAY
    LDA #0xB
    STA $az:addr(word_7E0040) ; orig=0x0040
    JSL copy_to_bg3_tilemap

nullsub_2:
    RTL

    SEP #0x20
hud_related_object:
i16
    REP #0x20
    STZ $az:addr(0x10),X
    STZ $az:addr(0x12),X
    REP #0x20
    LDA #addr(.loc_C406BC)
    STA $az:addr(0),X
    SEP #0x20
    LDA #bank(.loc_C406BC)
    STA $az:addr(2),X

.loc_C406BC:
    SEP #0x20
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #2    ; story mode
    BEQ .loc_C406D0
    CMP #3    ; battle mode
    BNE .loc_C406CD
    JML sub_C407C9

.loc_C406CD:
    JMP a:addr(.locret_C40768)

.loc_C406D0:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C406DD
    JML nullsub_C30015

.loc_C406DD:        ; is paused or debug-paused
    BIT #0x41
    BEQ .loc_C406E5
    JML .locret_C40768

.loc_C406E5:
    REP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0xC
    BEQ .loc_C406F3
    JML .locret_C40768

.loc_C406F3:
    INC $az:addr(0x12),X
    LDA $az:addr(0x12),X
    CMP a:addr(level_manager_object.anonymous_10) ; orig=0x0D3A
    BNE .locret_C40768
    STZ $az:addr(0x12),X
    SEP #0x20
    LDY #0x5E
    INC $az:addr(0x10),X
    LDA $az:addr(0x10),X
    AND #7
    STA $az:addr(0x10),X
    ASL A
    ADC #0xC0
    STA a:addr(bg3_tilemap),Y
    INC A
    STA a:addr(bg3_tilemap+2),Y
    CLC
    ADC #0xF
    STA a:addr(bg3_tilemap+0x40),Y
    INC A
    STA a:addr(bg3_tilemap+0x42),Y
    LDA $az:addr(0x10),X
    BNE .locret_C40768
    LDA a:addr(player_1.gameover_related) ; orig=0x0D44
    BEQ .loc_C40746
    LDY a:addr(story_mode_timers) ; orig=0x0CAA
    CPY #0x1C
    BNE .loc_C4073B
    JML hurry_up

.loc_C4073B:
    LDA #0xA7
    STA a:addr(bg3_tilemap+0xC2),Y
    INC a:addr(story_mode_timers) ; orig=0x0CAA
    INC a:addr(story_mode_timers) ; orig=0x0CAA

.loc_C40746:
    LDA a:addr(player_2.gameover_related) ; orig=0x0D84
    BEQ .locret_C40768
    LDA a:addr(word_7E0CAC) ; orig=0x0CAC
    CMP #0x1C
    BNE .loc_C40756
    JML hurry_up

.loc_C40756:
    SEC
    SBC #0xBC
    EOR #0xFF
    INC A
    TAY
    LDA #0xA7
    STA a:addr(bg3_tilemap+0x40),Y
    INC a:addr(word_7E0CAC) ; orig=0x0CAC
    INC a:addr(word_7E0CAC) ; orig=0x0CAC

.locret_C40768:
nullsub_C40768:
    RTL

sub_C40769:
    REP #0x20
    LDA #addr(.locret_C407C8)
    STA $az:addr(0),X
    SEP #0x20
    LDA #bank(.locret_C407C8)
    STA $az:addr(2),X
    JSL sub_C53BF7
    REP #0x20
    PHX
    LDX #addr(player_1)

.loc_C40782:
    LDA $az:addr(4),X
    AND #0xFF
    BEQ .loc_C407BA
    LDA $az:addr(0x2F),X
    BIT #1
    BNE .loc_C407BA
    LDA $az:addr(7),X
    BIT #1
    BNE .loc_C407AB
    REP #0x20
    LDA #addr(player_death)
    STA $az:addr(0),X
    SEP #0x20
    LDA #bank(player_death)
    STA $az:addr(2),X
    BRA .loc_C407BA

.loc_C407AB:
    REP #0x20
    LDA #addr(death_related)
    STA $az:addr(0),X
    SEP #0x20
    LDA #bank(death_related)
    STA $az:addr(2),X

.loc_C407BA:
    REP #0x20
    TXA
    CLC
    ADC #0x40
    TAX
    CMP #addr(player_4 + player.sizeof)
    BNE .loc_C40782
    PLX

.locret_C407C8:
    RTL

sub_C407C9:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C407D6
    JML nullsub_C30015

.loc_C407D6:
    BIT #0x41
    BEQ .loc_C407DE
    JML sub_C40816

.loc_C407DE:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0xC
    BEQ .loc_C407EB
    JML sub_C40816

.loc_C407EB:
    REP #0x20
    INC $az:addr(0x10),X
    LDA $az:addr(0x10),X
    ; Since the FPS is dropped in the PAL version, but each match still takes 2
    ; minutes, it means that gameplay-wise, each match is shorter in the PAL
    ; version!
    CMP #addr(FPS)
    BEQ .loc_C407FC
    JML sub_C40816.locret_C40887

.loc_C407FC:
    STZ $az:addr(0x10),X
    SED
    LDA a:addr(level_manager_object.anonymous_10) ; orig=0x0D3A
    SEC
    SBC #1
    STA a:addr(level_manager_object.anonymous_10) ; orig=0x0D3A
    CLD
    SEP #0x20
    CMP #0x60
    BCC sub_C40816
    LDA #0x59
    STA a:addr(level_manager_object.anonymous_10) ; orig=0x0D3A

sub_C40816:
    REP #0x20
    LDA a:addr(level_manager_object.anonymous_10) ; orig=0x0D3A
    AND #0xF
    ASL A
    PHX
    TAX
    LDA f:hud_digits_tilenos_upper,X
    STA a:addr(bg3_tilemap+0x62) ; orig=0x0878
    CLC
    ADC #0x10
    STA a:addr(bg3_tilemap+0xA2) ; orig=0x08B8
    LDA a:addr(level_manager_object.anonymous_10) ; orig=0x0D3A
    AND #0xF0
    LSR A
    LSR A
    LSR A
    TAX
    LDA f:hud_digits_tilenos_upper,X
    STA a:addr(bg3_tilemap+0x60) ; orig=0x0876
    CLC
    ADC #0x10
    STA a:addr(bg3_tilemap+0xA0) ; orig=0x08B6
    LDA a:addr(level_manager_object.anonymous_10+1) ; orig=0x0D3B
    AND #0xF
    ASL A
    TAX
    LDA f:hud_digits_tilenos_upper,X
    STA a:addr(bg3_tilemap+0x5C) ; orig=0x0872
    CLC
    ADC #0x10
    STA a:addr(bg3_tilemap+0x9C) ; orig=0x08B2
    PLX
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C4086B
    JML nullsub_C30015

.loc_C4086B:
    BIT #0x41
    BEQ .loc_C40873
    JML .locret_C40887

.loc_C40873:
    REP #0x20
    LDA a:addr(level_manager_object.anonymous_10) ; orig=0x0D3A
    BNE .loc_C4087E
    JML sub_C40769

.loc_C4087E:
    CMP #0x100
    BNE .locret_C40887
    JSL sub_C53B5D
.locret_C40887:
    RTL

hurry_up:
i16
    REP #0x20
    LDA #0x100
    STA $az:addr(0x12),X
    LDY #5
    JSL play_sound
    REP #0x20
    LDA #addr(.loc_C408A6)
    STA $az:addr(0),X
    SEP #0x20
    LDA #bank(.loc_C408A6)
    STA $az:addr(2),X

.loc_C408A6:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C408B3
    JML nullsub_C30015

.loc_C408B3:        ; is paused or debug-paused
    BIT #0x41
    BEQ .loc_C408BB
    JML nullsub_C40768

.loc_C408BB:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0xC
    BEQ .loc_C408C8
    JML nullsub_C40768

.loc_C408C8:
    LDA a:addr(story_mode_timers) ; orig=0x0CAA
    CMP #0x1C
    BEQ .loc_C408D6
    LDA a:addr(word_7E0CAC) ; orig=0x0CAC
    CMP #0x1C
    BNE .loc_C40953

.loc_C408D6:
    LDY #0xDE
    INC $az:addr(0x10),X
    LDA $az:addr(0x10),X
    ROR A
    LDA #0xBC
    BCS .loc_C408E6
    LDA #0xAC

.loc_C408E6:
    STA a:addr(bg3_tilemap),Y
    INC A
    STA a:addr(bg3_tilemap+2),Y
    LDY #0x5E
    LDA $az:addr(0x10),X
    AND #3
    STA $az:addr(0x10),X
    ASL A
    ADC #0xE0
    STA a:addr(bg3_tilemap),Y
    INC A
    STA a:addr(bg3_tilemap+2),Y
    CLC
    ADC #0xF
    STA a:addr(bg3_tilemap+0x40),Y
    INC A
    STA a:addr(bg3_tilemap+0x42),Y
    REP #0x20
    DEC $az:addr(0x12),X
    BNE .locret_C40962
    LDA a:addr(story_mode_timers) ; orig=0x0CAA
    CMP #0x1C
    BNE .loc_C40934
    LDA a:addr(player_1.hit_flags) ; orig=0x0D6F
    BIT #1
    BNE .loc_C40934
    REP #0x20
    LDA #addr(player_death)
    STA a:addr(player_1+object.handler) ; orig=0x0D40
    SEP #0x20
    LDA #bank(player_death)
    STA a:addr(player_1+object.handler+2) ; orig=0x0D42
    REP #0x20

.loc_C40934:
    LDA a:addr(word_7E0CAC) ; orig=0x0CAC
    CMP #0x1C
    BNE .loc_C40953
    LDA a:addr(player_2.hit_flags) ; orig=0x0DAF
    BIT #1
    BNE .loc_C40953
    REP #0x20
    LDA #addr(player_death)
    STA a:addr(player_2+object.handler) ; orig=0x0D80
    SEP #0x20
    LDA #bank(player_death)
    STA a:addr(player_2+object.handler+2) ; orig=0x0D82

.loc_C40953:
    REP #0x20
    LDA #addr(hud_related_object)
    STA $az:addr(0),X
    SEP #0x20
    LDA #bank(hud_related_object)
    STA $az:addr(2),X

.locret_C40962:
    RTL

handle_player_input:
i16
if USE_MULTI5_BIOS
    JSR a:addr(addr(multi5_read_input))
    JSR a:addr(addr(multi5_update_multitap_status))
    JMP a:addr(.loc_C409FE)
endif
; This code never runs if MULTI5 BIOS is used.
    SEP #0x20
    LDX #0

.loc_C40971:
    STZ a:addr(0xCE0),X
    INX
if !USE_MULTI5_BIOS
    CPX #0x10
endif
    BNE .loc_C40971
    STZ a:addr(PROGRAMMABLE_I_O_PORT_OUTPUT)
    LDA #1
    STA a:addr(0x4016)
    LDX #8

.loc_C40982:
    LDA a:addr(0x4017)
    LSR A
    LSR A
    ROL a:addr(multitap_status) ; orig=0x0CE0
    DEX
    BNE .loc_C40982
    STZ a:addr(0x4016)
    LDA #0x80
    STA a:addr(PROGRAMMABLE_I_O_PORT_OUTPUT)
    LDA #1
    STA a:addr(0x4016)
    STZ a:addr(0x4016)
    LDX #0x10

.loc_C409A0:
    LDA a:addr(0x4016)
    LSR A
    ROL a:addr(joypad_1) ; orig=0x0CE1
    ROL a:addr(joypad_1+1) ; orig=0x0CE2
    LDA a:addr(0x4017)
    LSR A
    ROL a:addr(joypad_2) ; orig=0x0CE3
    ROL a:addr(joypad_2+1) ; orig=0x0CE4
    LSR A
    ROL a:addr(joypad_3) ; orig=0x0CE5
    ROL a:addr(joypad_3+1) ; orig=0x0CE6
    DEX
    BNE .loc_C409A0
    LDA a:addr(0x4016)
    AND #1
    STA a:addr(joypad_1_connected) ; orig=0x0CEB
    LDA a:addr(0x4017)
    LSR A
    ROL a:addr(joypad_2_connected) ; orig=0x0CEC
    AND #1
    STA a:addr(joypad_3_connected) ; orig=0x0CED
    STZ a:addr(PROGRAMMABLE_I_O_PORT_OUTPUT)
    LDA a:addr(multitap_status) ; orig=0x0CE0
    INC A
    BNE .loc_C409FE
    LDX #0x10

.loc_C409DE:
    LDA a:addr(0x4017)
    LSR A
    ROL a:addr(joypad_4) ; orig=0x0CE7
    ROL a:addr(joypad_4+1) ; orig=0x0CE8
    LSR A
    ROL a:addr(joypad_5) ; orig=0x0CE9
    ROL a:addr(joypad_5+1) ; orig=0x0CEA
    DEX
    BNE .loc_C409DE
    LDA a:addr(0x4017)
    LSR A
    ROL a:addr(joypad_4_connected) ; orig=0x0CEE
    AND #1
    STA a:addr(joypad_5_connected) ; orig=0x0CEF

.loc_C409FE:
if !USE_MULTI5_BIOS
    LDA a:addr(word_7E0CE0) ; orig=0x0CE0
    AND #1
    ORA #0xB0
    STA NMI_V_H_COUNT_AND_JOYPAD_ENABLE
endif
    REP #0x20
    LDX #0xD40
    LDY #0
    JSL update_input_for_player_object
    LDX #0xD80
    LDY #2
    JSL update_input_for_player_object
    LDX #0xDC0
    LDY #4
    JSL update_input_for_player_object
    LDX #0xE00
    LDY #6
    JSL update_input_for_player_object
    RTL

    REP #0x20
update_input_for_player_object:
if USE_MULTI5_BIOS
    PHY
    TYA
    LSR A
    TAY
    LDA a:addr(joypad_1_connected),Y
    PLY
    AND #0x1F
    CMP #1
    BEQ .loc_C40A41
    LDA #0
    STA a:addr(joypad_1),Y
endif
.loc_C40A41:
    LDA a:addr(joypad_1_previous),Y
    EOR a:addr(joypad_1),Y
    AND a:addr(joypad_1),Y
    STA a:addr(joypad_1_pressed),Y
    LDA a:addr(joypad_1),Y
    STA a:addr(joypad_1_previous),Y
    LDA $az:addr(7),X
    BIT #1
    BNE .locret_C40A67
    LDA a:addr(joypad_1),Y
    STA $az:addr(0x22),X
    LDA a:addr(joypad_1_pressed),Y
    STA $az:addr(0x26),X

.locret_C40A67:
    RTL

related_to_oam_transfer:
i16
    REP #0x20
    LDA a:addr(word_7E0306) ; orig=0x0306
    STA $az:addr(word_7E0055+1) ; orig=0x0056
    SEP #0x20
    LDA a:addr(word_7E0308) ; orig=0x0308
    STA $az:addr(word_7E0058) ; orig=0x0058
    LDA a:addr(word_7E0308+1) ; orig=0x0309
    AND #0x80
    BEQ .loc_C40A8D
    LDA #0xF0
    STA a:addr(word_7E0306) ; orig=0x0306
    LDA #1
    STA a:addr(word_7E0306+1) ; orig=0x0307
    JML .loc_C40ACA

.loc_C40A8D:
    LDA #0xEE
    LDY #1
    STA f:[z:0x56],Y
    LDY #0x203
    LDA #1
    STA f:[z:0x56],Y
    LDA $az:addr(word_7E0055+1) ; orig=0x0056
    CLC
    ADC #4
    STA $az:addr(word_7E0055+1) ; orig=0x0056
    BIT #0xF
    BNE .loc_C40A8D
    LDY #1
    BIT #0xFF
    BEQ .loc_C40ABE

.loc_C40AAF:
    LDA #0xEE
    STA f:[z:0x56],Y
    LDA $az:addr(word_7E0055+1) ; orig=0x0056
    CLC
    ADC #4
    STA $az:addr(word_7E0055+1) ; orig=0x0056
    BNE .loc_C40AAF

.loc_C40ABE:
    LDA $az:addr(unk_7E0057) ; orig=0x0057
    BIT #1
    BNE .loc_C40ACA
    INC $az:addr(unk_7E0057) ; orig=0x0057
    BRA .loc_C40AAF

.loc_C40ACA:
    SEP #0x20
    LDA #0
    STA $az:addr(word_7E0053) ; orig=0x0053
    INC A
    INC A
    INC A
    STA $az:addr(byte_7E0050) ; orig=0x0050
    LDA #2
    STA $az:addr(byte_7E0051) ; orig=0x0051
    STA $az:addr(word_7E0053+1) ; orig=0x0054
    LDA #0x7F
    STA $az:addr(byte_7E0052) ; orig=0x0052
    STA $az:addr(word_7E0055) ; orig=0x0055
    LDY #0
    REP #0x20
    LDA a:addr(word_7E0306) ; orig=0x0306
    LSR A
    LSR A
    LSR A
    LSR A
    AND #0xFF
    INC A
    TAX
    SEP #0x20

.loc_C40AFA:
    STZ $az:addr(word_7E0040) ; orig=0x0040
    LDA f:[z:0x50],Y
    INY
    INY
    INY
    INY
    LSR A
    ROR $az:addr(word_7E0040) ; orig=0x0040
    LSR A
    ROR $az:addr(word_7E0040) ; orig=0x0040
    LDA f:[z:0x50],Y
    INY
    INY
    INY
    INY
    LSR A
    ROR $az:addr(word_7E0040) ; orig=0x0040
    LSR A
    ROR $az:addr(word_7E0040) ; orig=0x0040
    LDA f:[z:0x50],Y
    INY
    INY
    INY
    INY
    LSR A
    ROR $az:addr(word_7E0040) ; orig=0x0040
    LSR A
    ROR $az:addr(word_7E0040) ; orig=0x0040
    LDA f:[z:0x50],Y
    INY
    INY
    INY
    INY
    LSR A
    ROR $az:addr(word_7E0040) ; orig=0x0040
    LSR A
    ROR $az:addr(word_7E0040) ; orig=0x0040
    LDA $az:addr(word_7E0040) ; orig=0x0040
    STA f:[z:0x53]
    INC $az:addr(word_7E0053) ; orig=0x0053
    DEX
    BNE .loc_C40AFA
    SEP #0x20
    BRA .loc_C40B4B

.loc_C40B44:
    LDA #0x55
    STA f:[z:0x53]
    INC $az:addr(word_7E0053) ; orig=0x0053

.loc_C40B4B:
    LDA $az:addr(word_7E0053) ; orig=0x0053
    CMP #0x20
    BCC .loc_C40B44
    SEP #0x20
    STZ a:addr(word_7E0308+1) ; orig=0x0309
    RTL

dma_related_:
    SEP #0x20
    LDA #0x80
    STA a:addr(VRAM_ADDRESS_INCREMENT_VALUE)
    LDA #1
    STA a:addr(DMA_4_PARAMS)
    LDA #0x18
    STA a:addr(DMA_4_B_ADDRESS)
    LDA #0x10
    STA a:addr(REGULAR_DMA_CHANNEL_ENABLE)
    RTL

transfer_debug_menu_to_vram:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    AND #0xDF
    STA a:addr(game_flags) ; orig=0x0314
    AND #1
    BEQ .locret_C40B9E
    REP #0x20
    LDA #0x58C0
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x680
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(bg3_ram_map)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(bg3_ram_map)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_

.locret_C40B9E:
    RTL

clear_vs_check_graphics:
i16
    SEP #0x20
    LDA a:addr(debug_vs_check) ; orig=0x00B4
    BEQ .locret_C40BB5
    LDY #0x3FF

.loc_C40BA9:
    LDA a:addr(bg1_tilemap),Y
    AND #0xFD
    STA a:addr(bg1_tilemap),Y
    DEY
    DEY
    BPL .loc_C40BA9

.locret_C40BB5:
    RTL

dma_reset:
    REP #0x20
    LDA #0
    STA $az:addr(word_7E0040) ; orig=0x0040
    SEP #0x20
    LDA #0
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_HIGH_BYTE)
    LDA #0x80
    STA a:addr(VRAM_ADDRESS_INCREMENT_VALUE)
    LDA #9
    STA a:addr(DMA_4_PARAMS)
    LDA #0b11000
    STA a:addr(DMA_4_B_ADDRESS)
    LDA #0x40
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    LDA #0
    STA a:addr(DMA_4_A_ADDRESS_HIGH_BYTE)
    LDA #0
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    LDA #0
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    STA a:addr(DMA_4_BYTES_COUNT_HIGH_BYTE)
    LDA #0x10
    STA a:addr(REGULAR_DMA_CHANNEL_ENABLE)
    RTL

animation_frame_C40BF4:
    db 3
    frame_oam_tile 0xF8, 0xEF, 0x600, 0x20; 0
    frame_oam_tile 0, 0xFF, 0x2700, 0; 1
    frame_oam_tile 0xF8, 0xFF, 0x2600, 0; 2
animation_frame_C40C04:
    db 3            ; 0
    frame_oam_tile 0, 0, 0x2101, 0
    frame_oam_tile 0xF8, 0, 0x2001, 0
    frame_oam_tile 0xF8, 0xF0, 1, 0x20
animation_frame_C40C14:
    db 3            ; 0
    frame_oam_tile 0, 0, 0x2301, 0
    frame_oam_tile 0xF8, 0, 0x2201, 0
    frame_oam_tile 0xF8, 0xF0, 0x201, 0x20
animation_frame_C40C24:
    db 3            ; 0
    frame_oam_tile 0xF8, 0xF8, 0x202, 0x20
    frame_oam_tile 0, 0xF0, 0x3300, 0
    frame_oam_tile 0xF8, 0xF0, 0x3200, 0
animation_frame_C40C34:
    db 3            ; 0
    frame_oam_tile 0, 0xF0, 0x3500, 0
    frame_oam_tile 0xF8, 0xF0, 0x3400, 0
    frame_oam_tile 0xF8, 0xF8, 0x402, 0x20
animation_frame_C40C44:
    db 3            ; 0
    frame_oam_tile 0xF8, 0xF8, 0x602, 0x20
    frame_oam_tile 0, 0xF0, 0x3700, 0
    frame_oam_tile 0xF8, 0xF0, 0x3600, 0
animation_frame_C40C54:
    db 3            ; 0
    frame_oam_tile 0, 0, 0x2300, 0
    frame_oam_tile 0xF8, 0, 0x2200, 0
    frame_oam_tile 0xF8, 0xF0, 0x200, 0x20
animation_frame_C40C64:
    db 3            ; 0
    frame_oam_tile 0, 0, 0x2100, 0
    frame_oam_tile 0xF8, 0, 0x2000, 0
    frame_oam_tile 0xF8, 0xF0, 0, 0x20
animation_frame_C40C74:
    db 3            ; 0
    frame_oam_tile 0xF8, 0xF0, 0x400, 0x20
    frame_oam_tile 0, 0, 0x2500, 0
    frame_oam_tile 0xF8, 0, 0x2400, 0
animation_frame_C40C84:
    db 3            ; 0
    frame_oam_tile 0, 0, 0x2501, 0
    frame_oam_tile 0xF8, 0, 0x2401, 0
    frame_oam_tile 0xF8, 0xF0, 0x401, 0x20
animation_frame_C40C94:
    db 3            ; 0
    frame_oam_tile 0xF8, 0xF0, 0x601, 0x20
    frame_oam_tile 0, 0, 0x2701, 0
    frame_oam_tile 0xF8, 0, 0x2601, 0
animation_frame_C40CA4:
    db 3            ; 0
    frame_oam_tile 0xF8, 0xF8, 2, 0x20
    frame_oam_tile 0, 0xF0, 0x3100, 0
    frame_oam_tile 0xF8, 0xF0, 0x3000, 0
animation_frame_C40CB4:
    db 3            ; 0
    frame_oam_tile 0xF8, 0xF8, 3, 0x20
    frame_oam_tile 0, 0xF0, 0x3101, 0
    frame_oam_tile 0xF8, 0xF0, 0x3001, 0
animation_frame_C40CC4:
    db 3            ; 0
    frame_oam_tile 0, 0, 0x1103, 0
    frame_oam_tile 0xF8, 0, 0x1003, 0
    frame_oam_tile 0xF8, 0xF0, 0x403, 0x20
animation_frame_C40CD4:
    db 6            ; 0
    frame_oam_tile 0xF8, 0xF0, 0x403, 0
    frame_oam_tile 0, 0xF0, 0x503, 0
    frame_oam_tile 0, 0xF8, 0x1703, 0
    frame_oam_tile 0xF8, 0xF8, 0x1603, 0
    frame_oam_tile 0, 0, 0x1103, 0
    frame_oam_tile 0xF8, 0, 0x1003, 0
animation_frame_C40CF3:
    db 6            ; 0
    frame_oam_tile 0, 0xF0, 0x503, 0
    frame_oam_tile 0xF8, 0xF0, 0x403, 0
    frame_oam_tile 0, 0xF8, 0x3102, 0
    frame_oam_tile 0xF8, 0xF8, 0x3002, 0
    frame_oam_tile 0, 0, 0x1103, 0
    frame_oam_tile 0xF8, 0, 0x1003, 0
animation_frame_C40D12:
    db 3            ; 0
    frame_oam_tile 0xF8, 0xF8, 0x203, 0x20
    frame_oam_tile 0, 0xF0, 0x3301, 0
    frame_oam_tile 0xF8, 0xF0, 0x3201, 0
animation_frame_C40D22:
    db 3            ; 0
    frame_oam_tile 0xF8, 0xEE, 0x2602, 0x20
    frame_oam_tile 0, 0xFE, 0x3502, 0
    frame_oam_tile 0xF8, 0xFE, 0x3402, 0
animation_frame_C40D32:
    db 6            ; 0
    frame_oam_tile 0xFB, 0xF0, 0x3200, 0
    frame_oam_tile 0xFB, 0xF8, 0x3202, 0
    frame_oam_tile 3, 0xF8, 0x3302, 0
    frame_oam_tile 3, 0xF0, 0x2302, 0
    frame_oam_tile 0xFB, 0, 0x2402, 0
    frame_oam_tile 3, 0, 0x2502, 0
animation_frame_C40D51:
    db 3            ; 0
    frame_oam_tile 0, 1, 0x2103, 0
    frame_oam_tile 0xF8, 1, 0x2003, 0
    frame_oam_tile 0xF8, 0xF1, 0x2203, 0x20
animation_frame_C40D61:
    db 6            ; 0
    frame_oam_tile 0xFD, 0xF0, 0x3200, 0x40
    frame_oam_tile 0xFD, 0xF8, 0x3202, 0x40
    frame_oam_tile 0xF5, 0xF0, 0x2302, 0x40
    frame_oam_tile 0xF5, 0xF8, 0x3302, 0x40
    frame_oam_tile 0xFD, 0, 0x2402, 0x40
    frame_oam_tile 0xF5, 0, 0x2502, 0x40
animation_frame_C40D80:
    db 6            ; 0
    frame_oam_tile 0, 0, 0x2300, 0
    frame_oam_tile 0xF8, 0, 0x2200, 0
    frame_oam_tile 0, 0xF0, 0x3501, 0
    frame_oam_tile 0xF8, 0xF0, 0x3401, 0
    frame_oam_tile 0, 0xF8, 0x3701, 0
    frame_oam_tile 0xF8, 0xF8, 0x3601, 0
animation_frame_C40D9F:
    db 6            ; 0
    frame_oam_tile 0, 0, 0x1302, 0
    frame_oam_tile 0xF8, 0, 0x1202, 0
    frame_oam_tile 0xF8, 0xF8, 0x202, 0
    frame_oam_tile 0xF8, 0xF0, 0x3200, 0
    frame_oam_tile 0, 0xF8, 0x3103, 0
    frame_oam_tile 0, 0xF0, 0x3003, 0
animation_frame_C40DBE:
    db 6            ; 0
    frame_oam_tile 0, 0, 0x1202, 0x40
    frame_oam_tile 0, 0xF8, 0x202, 0x40
    frame_oam_tile 0, 0xF0, 0x3200, 0x40
    frame_oam_tile 0xF8, 0, 0x1302, 0x40
    frame_oam_tile 0xF8, 0xF8, 0x3103, 0x40
    frame_oam_tile 0xF8, 0xF0, 0x3003, 0x40
animation_frame_C40DDD:
    db 3            ; 0
    frame_oam_tile 0, 0, 0x2104, 0
    frame_oam_tile 0xF8, 0, 0x2004, 0
    frame_oam_tile 0xF8, 0xF0, 4, 0x20
animation_frame_C40DED:
    db 3            ; 0
    frame_oam_tile 0, 0, 0x2304, 0
    frame_oam_tile 0xF8, 0, 0x2204, 0
    frame_oam_tile 0xF8, 0xF0, 0x204, 0x20
animation_frame_C40DFD:
    db 3            ; 0
    frame_oam_tile 0, 0, 0x2504, 0
    frame_oam_tile 0xF8, 0, 0x2404, 0
    frame_oam_tile 0xF8, 0xF0, 0x404, 0x20
animation_frame_C40E0D:
    db 1            ; 0
    frame_oam_tile 0xF8, 0xF8, 0x604, 0x20
animation_frame_C40E13:
    db 1            ; 0
    frame_oam_tile 0xF8, 0xF8, 0x2604, 0x20
animation_frame_C40E19:
    db 1            ; 0
    frame_oam_tile 0xF8, 0xF8, 5, 0x20
animation_frame_C40E1F:
    db 2            ; 0
    frame_oam_tile 0xF8, 0, 0x3404, 0
    frame_oam_tile 0, 0, 0x3504, 0
animation_frame_C40E2A:
    db 2            ; 0
    frame_oam_tile 0, 0, 0x3104, 0
    frame_oam_tile 0xF8, 0, 0x3004, 0
animation_frame_C40E35:
    db 2            ; 0
    frame_oam_tile 0, 0, 0x3304, 0
    frame_oam_tile 0xF8, 0, 0x3204, 0
animation_frame_C40E40:
    db 4            ; 0
    frame_oam_tile 0xF8, 0xF0, 0x400, 0x20
    frame_oam_tile 0xF8, 0, 0x2400, 0x20
    frame_oam_tile 0, 0, 0x1200, 0x40
    frame_oam_tile 0xF8, 0, 0x1200, 0
animation_frame_C40E55:
    db 4            ; 0
    frame_oam_tile 0xF8, 0xF0, 0x600, 0x20
    frame_oam_tile 0xF8, 0, 0x2600, 0x20
    frame_oam_tile 0, 0, 0x1200, 0x40
    frame_oam_tile 0xF8, 0, 0x1200, 0
animation_frame_C40E6A:
    db 4            ; 0
    frame_oam_tile 0xF8, 0xEE, 0x2200, 0x20
    frame_oam_tile 0xF8, 0xFE, 0x2000, 0x20
    frame_oam_tile 0, 0, 0x1200, 0x40
    frame_oam_tile 0xF8, 0, 0x1200, 0
animation_frame_C40E7F:
    db 4            ; 0
    frame_oam_tile 0xF8, 0xEC, 0x2200, 0x20
    frame_oam_tile 0xF8, 0xFC, 0x2000, 0x20
    frame_oam_tile 0xF8, 0, 0x200, 0x40
    frame_oam_tile 0, 0, 0x200, 0
animation_frame_C40E94:
    db 4            ; 0
    frame_oam_tile 0xF8, 0xE9, 0x2200, 0x20
    frame_oam_tile 0xF8, 0xF9, 0x2000, 0x20
    frame_oam_tile 0xF8, 0, 0x200, 0x40
    frame_oam_tile 0, 0, 0x200, 0
animation_frame_C40EA9:
    db 3            ; 0
    frame_oam_tile 0xF8, 0xE6, 0x2200, 0x20
    frame_oam_tile 0xF8, 0xF6, 0x2000, 0x20
    frame_oam_tile 0xFC, 0, 0x300, 0
animation_frame_C40EB9:
    db 3            ; 0
    frame_oam_tile 0xF8, 0xE3, 0x2200, 0x20
    frame_oam_tile 0xF8, 0xF3, 0x2000, 0x20
    frame_oam_tile 0xFC, 0, 0x300, 0
animation_frame_C40EC9:
    db 8            ; 0
    frame_oam_tile 0, 0, 0x2002, 0x40
    frame_oam_tile 0, 0xDD, 0x703, 0
    frame_oam_tile 0xF8, 0xDD, 0x603, 0
    frame_oam_tile 0xF8, 0, 0x2002, 0
    frame_oam_tile 0, 0xCD, 0x3501, 0
    frame_oam_tile 0xF8, 0xCD, 0x3401, 0
    frame_oam_tile 0, 0xD5, 0x3701, 0
    frame_oam_tile 0xF8, 0xD5, 0x3601, 0
animation_frame_C40EF2:
    db 8            ; 0
    frame_oam_tile 0, 0, 0x2002, 0x40
    frame_oam_tile 0, 0xDF, 0x703, 0
    frame_oam_tile 0xF8, 0xDF, 0x603, 0
    frame_oam_tile 0xF8, 0, 0x2002, 0
    frame_oam_tile 0, 0xCF, 0x3501, 0
    frame_oam_tile 0xF8, 0xCF, 0x3401, 0
    frame_oam_tile 0, 0xD7, 0x3701, 0
    frame_oam_tile 0xF8, 0xD7, 0x3601, 0
animation_frame_C40F1B:
    db 8            ; 0
    frame_oam_tile 0, 0, 0x2002, 0x40
    frame_oam_tile 0, 0xE4, 0x703, 0
    frame_oam_tile 0xF8, 0xE4, 0x603, 0
    frame_oam_tile 0xF8, 0, 0x2002, 0
    frame_oam_tile 0, 0xD4, 0x3501, 0
    frame_oam_tile 0xF8, 0xD4, 0x3401, 0
    frame_oam_tile 0, 0xDC, 0x3701, 0
    frame_oam_tile 0xF8, 0xDC, 0x3601, 0
animation_frame_C40F44:
    db 8            ; 0
    frame_oam_tile 0, 0, 0x2002, 0x40
    frame_oam_tile 0, 0xE8, 0x703, 0
    frame_oam_tile 0xF8, 0xE8, 0x603, 0
    frame_oam_tile 0xF8, 0, 0x2002, 0
    frame_oam_tile 0, 0xD8, 0x3501, 0
    frame_oam_tile 0xF8, 0xD8, 0x3401, 0
    frame_oam_tile 0, 0xE0, 0x3701, 0
    frame_oam_tile 0xF8, 0xE0, 0x3601, 0
animation_frame_C40F6D:
    db 8            ; 0
    frame_oam_tile 0, 0, 0x2002, 0x40
    frame_oam_tile 0, 0xEC, 0x703, 0
    frame_oam_tile 0xF8, 0xEC, 0x603, 0
    frame_oam_tile 0xF8, 0, 0x2002, 0
    frame_oam_tile 0, 0xDC, 0x3501, 0
    frame_oam_tile 0xF8, 0xDC, 0x3401, 0
    frame_oam_tile 0, 0xE4, 0x3701, 0
    frame_oam_tile 0xF8, 0xE4, 0x3601, 0
animation_frame_C40F96:
    db 8            ; 0
    frame_oam_tile 0, 0, 0x2002, 0x40
    frame_oam_tile 0, 0xEF, 0x703, 0
    frame_oam_tile 0xF8, 0xEF, 0x603, 0
    frame_oam_tile 0xF8, 0, 0x2002, 0
    frame_oam_tile 0, 0xDF, 0x3501, 0
    frame_oam_tile 0xF8, 0xDF, 0x3401, 0
    frame_oam_tile 0, 0xE7, 0x3701, 0
    frame_oam_tile 0xF8, 0xE7, 0x3601, 0
animation_frame_C40FBF:
    db 8            ; 0
    frame_oam_tile 0, 0, 0x2002, 0x40
    frame_oam_tile 0, 0xF3, 0x703, 0
    frame_oam_tile 0xF8, 0xF3, 0x603, 0
    frame_oam_tile 0xF8, 0, 0x2002, 0
    frame_oam_tile 0, 0xE3, 0x3501, 0
    frame_oam_tile 0xF8, 0xE3, 0x3401, 0
    frame_oam_tile 0, 0xEB, 0x3701, 0
    frame_oam_tile 0xF8, 0xEB, 0x3601, 0
animation_frame_C40FE8:
    db 8            ; 0
    frame_oam_tile 0, 0, 0x2002, 0x40
    frame_oam_tile 0, 0xF7, 0x703, 0
    frame_oam_tile 0xF8, 0xF7, 0x603, 0
    frame_oam_tile 0xF8, 0, 0x2002, 0
    frame_oam_tile 0, 0xE7, 0x3501, 0
    frame_oam_tile 0xF8, 0xE7, 0x3401, 0
    frame_oam_tile 0, 0xEF, 0x3701, 0
    frame_oam_tile 0xF8, 0xEF, 0x3601, 0
animation_frame_C41011:
    db 1            ; 0
    frame_oam_tile 0xFC, 0xFC, 0x2102, 0
animation_frame_C41017:
    db 5            ; 0
    frame_oam_tile 0xFF, 0xF6, 0x2202, 0
    frame_oam_tile 0xFB, 0xF6, 0x2202, 0
    frame_oam_tile 0xF8, 0xF8, 0x203, 0x20
    frame_oam_tile 0, 0xF0, 0x3301, 0
    frame_oam_tile 0xF8, 0xF0, 0x3201, 0
up_walking_animation:
    db 4
    animation_frame animation_frame_C40BF4, 0xB; 0
    animation_frame animation_frame_C40C04, 0xE; 1
    animation_frame animation_frame_C40BF4, 0xB; 2
    animation_frame animation_frame_C40C14, 0xE; 3
right_walking_animation:
    db 4
    animation_frame animation_frame_C40C24, 0xB; 0
    animation_frame animation_frame_C40C34, 0xE; 1
    animation_frame animation_frame_C40C24, 0xB; 2
    animation_frame animation_frame_C40C44, 0xE; 3
down_walking_animation:
    db 4
    animation_frame animation_frame_C40C54, 0xB; 0
    animation_frame animation_frame_C40C64, 0xE; 1
    animation_frame animation_frame_C40C54, 0xB; 2
    animation_frame animation_frame_C40C74, 0xE; 3
left_walking_animation:
    db 4
    animation_frame animation_frame_C40C84, 0xB; 0
    animation_frame animation_frame_C40C94, 0xE; 1
    animation_frame animation_frame_C40C84, 0xB; 2
    animation_frame animation_frame_C40CA4, 0xE; 3
death_animation:
    db 0x25
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
    animation_frame animation_frame_C40F1B, 1; 0xA
    animation_frame animation_frame_C40F44, 1; 0xB
    animation_frame animation_frame_C40F6D, 1; 0xC
    animation_frame animation_frame_C40FBF, 1; 0xD
    animation_frame animation_frame_C40FE8, 1; 0xE
    animation_frame animation_frame_C40D80, 1; 0xF
    animation_frame animation_frame_C40CB4, 6; 0x10
    animation_frame animation_frame_C40CC4, 2; 0x11
    animation_frame animation_frame_C40CD4, 2; 0x12
    animation_frame animation_frame_C40CF3, 0xA; 0x13
    animation_frame animation_frame_C40D12, 0x15; 0x14
    animation_frame animation_frame_C41017, 1; 0x15
    animation_frame animation_frame_C40D12, 1; 0x16
    animation_frame animation_frame_C41017, 1; 0x17
    animation_frame animation_frame_C40D12, 1; 0x18
    animation_frame animation_frame_C41017, 2; 0x19
    animation_frame animation_frame_C40D12, 2; 0x1A
    animation_frame animation_frame_C41017, 2; 0x1B
    animation_frame animation_frame_C40D12, 2; 0x1C
    animation_frame animation_frame_C41017, 2; 0x1D
    animation_frame animation_frame_C40D12, 2; 0x1E
    animation_frame animation_frame_C41017, 2; 0x1F
    animation_frame animation_frame_C40D12, 2; 0x20
    animation_frame animation_frame_C41017, 2; 0x21
    animation_frame animation_frame_C40D12, 2; 0x22
    animation_frame animation_frame_C41017, 0x20; 0x23
    animation_frame animation_frame_C41011, 0x20; 0x24
up_punch_animation:
    db 1
    animation_frame animation_frame_C40D22, 0xB
right_punch_animation:
    db 1
    animation_frame animation_frame_C40D32, 0xB
down_punch_animation:
    db 1
    animation_frame animation_frame_C40D51, 0xB
left_punch_animation:
    db 1
    animation_frame animation_frame_C40D61, 0xB
hit_by_bomb_animation:
    db 9
    ; Animation structure:
    ;
    ; uint8 n_frames
    ; An array of n_frames structures:
    ; addr24 frame_offset
    ; uint8 length
    animation_frame animation_frame_C40D80, 1; 0
    animation_frame animation_frame_C40D9F, 1; 1
    animation_frame animation_frame_C40BF4, 2; 2
    animation_frame animation_frame_C40DBE, 2; 3
    animation_frame animation_frame_C40D80, 3; 4
    animation_frame animation_frame_C40D9F, 4; 5
    animation_frame animation_frame_C40BF4, 5; 6
    animation_frame animation_frame_C40DBE, 6; 7
    animation_frame animation_frame_C40D80, 6; 8
enter_wrap_animation:
    db 9
    animation_frame animation_frame_C40DDD, 7; 0
    animation_frame animation_frame_C40DED, 6; 1
    animation_frame animation_frame_C40DFD, 5; 2
    animation_frame animation_frame_C40E0D, 5; 3
    animation_frame animation_frame_C40E13, 5; 4
    animation_frame animation_frame_C40E19, 4; 5
    animation_frame animation_frame_C40E1F, 3; 6
    animation_frame animation_frame_C40E2A, 2; 7
    animation_frame animation_frame_C40E35, 2; 8
unknown_animation:
    db 9
    animation_frame animation_frame_C40E35, 2; 0
    animation_frame animation_frame_C40E2A, 2; 1
    animation_frame animation_frame_C40E1F, 3; 2
    animation_frame animation_frame_C40E19, 4; 3
    animation_frame animation_frame_C40E13, 5; 4
    animation_frame animation_frame_C40E0D, 5; 5
    animation_frame animation_frame_C40DFD, 5; 6
    animation_frame animation_frame_C40DED, 6; 7
    animation_frame animation_frame_C40DDD, 7; 8
jumping_animation:
    db 0xC
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
    animation_frame animation_frame_C40E6A, 2; 0xA
    animation_frame animation_frame_C40E55, 2; 0xB
init_player_handler:
i16
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x80
    BEQ .loc_C411CB
    JML .locret_C412A1

.loc_C411CB:
    STZ a:addr(0x12F),X
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #1
    BNE .loc_C411D9
    JML .locret_C412A1

.loc_C411D9:
    LDA z:player.real_palette,X
    STA z:player.effective_palette,X
    LDA #0
    STA z:object.handler+0x12,X
    LDA #0
    STA z:player.hit_flags,X
    REP #0x20
    STZ a:player.poison_state,X
    STZ a:player.poison_state + 2,X
    LDY #6
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #3
    BEQ .loc_C41271
    LDA z:player.player_index,X
    AND #0xFF
    ASL A
    TAY
    LDA #0
    STA a:addr(story_mode_timers),Y
    LDY #0xC2
    LDA z:player.player_index,X
    AND #0xFF
    BEQ .loc_C41212
    LDY #0xE2

.loc_C41212:
    LDA #0xE
    STA z:0x40
    REP #0x20
    LDA #addr(storymode_hud_tilemap+0xC2)
    STA z:0x50
    SEP #0x20
    LDA #bank(storymode_hud_tilemap+0xC2)
    STA z:0x52
    JSL copy_to_bg3_tilemap
    SEP #0x20
    LDA #bank(storymode_normal_spawn_spot)
    STA z:0x55
    REP #0x20
    LDA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    AND #0xE
    PHX
    TAX
    LDA f:storymode_spawn_spots_array,X
    STA z:0x53
    LDA f:directions_for_spawn_spots,X
    STA z:0x40
    PLX
    JSL change_direction_and_start_animation
    REP #0x20
    LDA #INVINCIBILITY_FRAMES
    STA z:player.invincibility_countdown,X
    LDA z:player.player_index,X
    AND #0xFF
    ASL A
    ASL A
    ASL A
    TAY
    LDA f:[z:0x53],Y
    STA z:player.x_position,X
    INY
    INY
    LDA f:[z:0x53],Y
    STA z:player.y_position,X
    REP #0x20
    LDA #addr(handle_player_movement)
    STA z:0,X
    SEP #0x20
    LDA #bank(handle_player_movement)
    STA z:object.handler+2,X
    RTL

.loc_C41271:
    REP #0x20
    LDA #4
    STA z:0x40
    LDA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    BIT #0x208
    BEQ .loc_C41290
    LDA a:addr(0x13E),X
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:word_C30924,X
    STA z:0x40
    PLX

.loc_C41290:
    JSL change_direction_and_start_animation
    REP #0x20
    LDA #addr(handle_player_movement)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(handle_player_movement)
    STA z:object.handler+2,X

.locret_C412A1:
    RTL

handle_player_movement:
i16
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C412AF
    JML nullsub_C30015

.loc_C412AF:
    BIT #0x41
    BEQ .loc_C412B7
    JML .loc_C413B0

.loc_C412B7:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #8
    BEQ .loc_C412C4
    JML .loc_C413B5

.loc_C412C4:
    JSL clear_playerquare_in_collision_map
    JSL sub_C43BE9
    JSL update_effective_speed
    SEP #0x20
    LDA a:player.poison_state + 1,X
    BIT #high(POISON_NO_BOMBS)
    BNE .loc_C412EE
    LDA a:player.poison_state + 1,X
    BIT #high(POISON_AUTO_BOMB_DROP)
    BEQ .loc_C412E4
    JML try_drop_bomb

.loc_C412E4:
    LDA z:0x26,X
    BIT #0x80
    BEQ .loc_C412EE
    JML try_drop_bomb.loc_C4241A
.loc_C412EE:
    SEP #0x20
    LDA z:0x23,X
    AND #0xF
    BNE .loc_C412FA
    JML .loc_C413BA

.loc_C412FA:
    STA z:0x4E
    JSL sub_C613ED
    SEP #0x20
    LDA z:0x4E
    CMP #1
    BNE .loc_C4130C
    JML sub_C41E16

.loc_C4130C:
    CMP #2
    BNE .loc_C41314
    JML sub_C41EEC

.loc_C41314:
    CMP #4
    BNE .loc_C4131C
    JML sub_C41FC2

.loc_C4131C:
    JMP a:addr(sub_C42098)
.inner2:
    SEP #0x20
    LDA z:0x4E
    AND #0xF
    CMP z:0x20,X
    BEQ .inner
    STA z:0x20,X
    REP #0x20
    AND #0xF
    ASL A
    PHX
    TAX
    LDA f:player_animation_list,X
    STA z:0x50
    PLX
    SEP #0x20
    LDA z:0xD,X
    PHA
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    PLA
    STA z:0xD,X

.inner:
    REP #0x20
    LDA z:0x26,X
    BIT #0x4020
    BEQ .loc_C4135B
    JSL sub_C41D0B

.loc_C4135B:
    JSL mark_playerquare_in_collision_map
    JSL sub_C60C35
    SEP #0x20
    LDA z:0x1F,X
    STA z:0x1E,X
    JSL poison_rendering
    JSL try_infect_poison
    SEP #0x20
    LDA z:0x2F,X
    BNE .loc_C4137B
    JML .loc_C4139D

.loc_C4137B:
    LDA z:0x2F,X
    BIT #0x80
    BEQ .loc_C41385
    JML play_hit_by_bomb_animation

.loc_C41385:
    LDA z:0x39,X
    BIT #0x80
    BNE .loc_C4138F
    JML player_death

.loc_C4138F:
    AND #0x7F
    STA z:0x39,X
    STZ z:0x2F,X
    LDA #low(INVINCIBILITY_FRAMES)
    STA z:player.invincibility_countdown,X
    LDA #high(INVINCIBILITY_FRAMES)
    STA z:player.invincibility_countdown + 1,X

.loc_C4139D:
    SEP #0x20
    INC a:addr(0x13F),X
    LDA a:addr(0x13F),X
    BIT #0xF
    BNE .loc_C413B0
    LDY #0xC
    JSL play_sound

.loc_C413B0:
    JSL advance_animation
    RTL

.loc_C413B5:
    JSL advance_animation_2
    RTL

.loc_C413BA:
    REP #0x20
    LDA z:0x26,X
    BIT #0x4020
    BEQ .loc_C413C7
    JSL sub_C41D0B

.loc_C413C7:
    JSL mark_playerquare_in_collision_map
    JSL sub_C60C35
    SEP #0x20
    LDA z:0x1F,X
    STA z:0x1E,X
    JSL poison_rendering
    JSL try_infect_poison
    SEP #0x20
    LDA z:0x2F,X
    BEQ .loc_C41405
    LDA z:0x2F,X
    BIT #0x80
    BEQ .loc_C413ED
    JML play_hit_by_bomb_animation

.loc_C413ED:
    LDA z:0x39,X
    BIT #0x80
    BNE .loc_C413F7
    JML player_death

.loc_C413F7:
    AND #0x7F
    STA z:0x39,X
    STZ z:0x2F,X
    LDA #low(INVINCIBILITY_FRAMES)
    STA z:player.invincibility_countdown,X
    LDA #high(INVINCIBILITY_FRAMES)
    STA z:player.invincibility_countdown + 1,X

.loc_C41405:
    SEP #0x20
    STZ z:0x21,X
    STZ z:0xC,X
    STZ z:0x25,X
    LDA z:0xD,X
    PHA
    JSL advance_animation
    SEP #0x20
    PLA
    STA z:0xD,X
    RTL

mark_playerquare_in_collision_map:
    JSL get_object_square_index
    REP #0x20
    TAY
    LDA a:addr(collision_map),Y
    ORA #PLAYER
    STA a:addr(collision_map),Y
    RTL

clear_playerquare_in_collision_map:
    JSL get_object_square_index
    REP #0x20
    TAY
    LDA a:addr(collision_map),Y
    AND #addr(~(PLAYER))
    STA a:addr(collision_map),Y
    RTL

poison_rendering_invisibile:
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300
    AND #0xF
    BEQ + ; Every 16 frames
    JML handle_player_flashing_and_invincibility

+
    JSL random2
    SEP #0x20
    AND #0xF0
    CMP #0x40
    BEQ +
    JML handle_player_flashing_and_invincibility

+
    ; Randomly make the player flash visible
    LDA a:player.poison_state + 1,X
    ORA #high(POISON_FLASHING_VISIBLE)
    STA a:player.poison_state + 1,X
    JMP a:handle_player_flashing_and_invincibility

poison_rendering:
    SEP #0x20
    LDA #0
    XBA
    LDA a:player.poison_state + 1,X
    BIT #high(POISON_FLASHING_VISIBLE)
    BNE .not_invisible
    BIT #high(POISON_INVISIBILITY)
    BEQ .not_invisible
    LDA z:player.invisibility_poison_flashing,X
    CMP #INVISIBILITY_FLASHING_LEGNTH
    BEQ poison_rendering_invisibile
    
    ; Flash into invisible
    INC z:player.invisibility_poison_flashing,X
    
    PHX
    TAX
    LDA f:invisibility_flashing_sequence,X
    PLX
    STA z:player.x_position + 1,X
    
    BRA handle_player_flashing_and_invincibility

.not_invisible:
    LDA z:player.invisibility_poison_flashing,X
    BEQ handle_player_flashing_and_invincibility ; Completely visible
    
    ; Flash into visible
    
    ; INVISIBILITY_FLASHING_LEGNTH - .invisibility_poison_flashing
    SEC
    SBC #INVISIBILITY_FLASHING_LEGNTH - 1
    EOR #0xFF
    INC A
    
    PHX
    TAX
    LDA f:invisibility_flashing_sequence,X
    PLX
    STA z:player.x_position + 1,X
    
    DEC z:player.invisibility_poison_flashing,X
    BNE handle_player_flashing_and_invincibility
    
    ; Done flashing visible, clear the flag so we either become fully visible or flash invisible again
    LDA a:player.poison_state + 1,X
    AND #high(~POISON_FLASHING_VISIBLE)
    STA a:player.poison_state + 1,X
    
    ; fallthrough

handle_player_flashing_and_invincibility:
    REP #0x20
    LDA z:player.invincibility_countdown,X
    BEQ .not_invincible
    DEC z:player.invincibility_countdown,X
    
    ; INVINCIBILITY_FRAMES - invincibility_countdown
    SEC
    SBC #INVINCIBILITY_FRAMES
    EOR #0xFFFF
    INC A
    
    PHX
    TAX
    SEP #0x20
    LDA f:shield_palette_sequence,X
    PLX
    
    CMP #0
    BNE +
    LDA z:player.real_palette,X
+
    STA z:player.effective_palette,X
    STZ z:player.hit_flags,X ; Makes the player immune to all damage types
    
    REP #0x20
    LDA a:player.poison_state,X
    BEQ .no_poison
    DEC A
    BIT #0x3FF
    BNE +
    ; Poison ran out, clear state
    LDA #0
    STA a:player.poison_state + 2,X

+
    STA a:player.poison_state,X

.no_poison:
    SEP #0x20
    RTL

.not_invincible:
    REP #0x20
    LDA a:player.poison_state,X
    BEQ .no_poison
    DEC A
    BIT #0x3FF
    BNE +
    ; Poison ran out, clear state
    LDA #0
    STA a:player.poison_state + 2,X

    ; Flash in black
+
    STA a:player.poison_state,X
    SEP #0x20
    AND #0x10
    BNE +
    LDA z:player.real_palette,X
    STA z:player.effective_palette,X
    RTL

+
    LDA #PALETTE_STATIC_BLACK
    STA z:player.effective_palette,X
    RTL

try_infect_poison:
i16
    REP #0x20
    LDA a:player.poison_state + 1,X
    BEQ .ret ; Not even poisoned
    STX z:0x40
    TXY

.loop:
    REP #0x20
    TYA
    CLC
    ADC #player.sizeof
    CMP #addr(player_4 + player.sizeof)
    BNE +
    LDA #addr(player_1) ; Wrap around

+
    TAY
    CMP z:0x40
    BEQ .ret ; Looped back, return
    
    SEP #0x20
    
    ; Second player already dead
    LDA a:player.gameover_related,Y
    BEQ .loop
    
    ; Second player not poisoned
    LDA a:player.poison_state + 1,Y
    BNE .loop
    
    ; Second player is being hit
    LDA a:player.hit_flags,Y
    BIT #1
    BNE .loop
    
    LDA a:player.unknown_poison_related,Y
    BNE .loop
    
    ; Difference between X positions
    LDA player.x_position,Y
    SEC
    SBC z:player.x_position,X
    
    ; Absolute value
    BCS +
    EOR #0xFF
    INC A
+

    ; Not within 16 pixels
    CMP #0x10
    BCS .loop
    
    ; Difference between Y positions
    LDA a:player.y_position,Y
    SEC
    SBC z:player.y_position,X
    
    ; Absolute value
    BCS +
    EOR #0xFF
    INC A
    +
    
    ; Not within 16 pixels
    CMP #0x10
    BCS .loop
    
    REP #0x20
    LDA a:player.poison_state,X
    BIT #POISON_INVISIBILITY
    BEQ +
    AND #POISON_TIMER_MASK | POISON_INVISIBILITY ; Removes the flash visible flag

+
    ; Copy poison state
    STA a:player.poison_state,Y
    LDA a:player.poison_state + 2,X
    STA a:player.poison_state + 2,Y
    LDY #SOUND_POISON
    JSL play_sound

.ret:
    RTL

play_hit_by_bomb_animation:
    SEP #0x20
    LDA z:player.real_palette,X
    STA z:player.effective_palette,X
    REP #0x20
    LDA #addr(hit_by_bomb_animation)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(_play_hit_by_bomb_animation)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(_play_hit_by_bomb_animation)
    STA z:object.handler+2,X

_play_hit_by_bomb_animation:
    JSL advance_animation
    BCC .locret_C415BD
    SEP #0x20
    STZ z:0x2F,X
    LDA #4
    STA z:0x40
    JSL change_direction_and_start_animation
    REP #0x20
    LDA #addr(handle_player_movement)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(handle_player_movement)
    STA z:object.handler+2,X

.locret_C415BD:
    RTL

    RTL
enter_warp:
i16
    SEP #0x20
    INC a:addr(0x12F),X
    JSL clear_playerquare_in_collision_map
    LDY #9
    JSL play_sound
    SEP #0x20
    LDA z:player.x_position,X ; Round position to whole tile
    AND #0xF0
    ORA #8
    STA z:player.x_position,X
    LDA z:player.y_position,X
    AND #0xF0
    ORA #8
    STA z:player.y_position,X
    REP #0x20
    LDA #addr(enter_wrap_animation)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(_enter_wrap)
    STA z:0,X
    SEP #0x20
    LDA #bank(_enter_wrap)
    STA z:2,X

_enter_wrap:
    JSL advance_animation
    BCC .locret_C41612
    REP #0x20
    LDA #addr(wrap_delay)
    STA z:0,X
    SEP #0x20
    LDA #bank(wrap_delay)
    STA z:2,X

.locret_C41612:
    RTL

wrap_delay:
    SEP #0x20
    LDA #0x40
    STA z:player.wrap_delay,X
    REP #0x20
    LDA #addr(_wrap_delay)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(_wrap_delay)
    STA z:object.handler+2,X

_wrap_delay:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C41633
    JML nullsub_C30015

.loc_C41633:
    BIT #0x41
    BEQ .loc_C4163B
    JML .locret_C4164E

.loc_C4163B:
    SEP #0x20
    DEC z:player.wrap_delay,X
    BNE .locret_C4164E
    REP #0x20
    LDA #addr(exit_wrap)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(exit_wrap)
    STA z:object.handler+2,X

.locret_C4164E:
    RTL

play_exit_wrap_animation:
    REP #0x20
    LDA #addr(unknown_animation)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(_play_exit_wrap_animation)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(_play_exit_wrap_animation)
    STA z:object.handler+2,X

_play_exit_wrap_animation:
    JSL advance_animation
    BCC .locret_C4168A
    SEP #0x20
    LDA z:0x20,X
    STA z:0x40
    JSL change_direction_and_start_animation
    REP #0x20
    LDA #addr(handle_player_movement)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(handle_player_movement)
    STA z:object.handler+2,X

.locret_C4168A:
    RTL

exit_wrap:
i16
    PHX
    LDX #5
    JSL random
    REP #0x20
    AND #0xFF
    ASL A
    ASL A
    TAX
    LDA f:wrap_positions,X
    STA z:0x40
    LDA f:wrap_positions+2,X
    STA z:0x42
    PLX
    SEP #0x20
    LDA z:0x40
    CMP z:player.x_position,X
    BNE .loc_C416B6
    LDA z:0x42
    CMP z:player.y_position,X
    BEQ .locret_C416D0

.loc_C416B6:
    SEP #0x20
    LDA z:0x40
    STA z:player.x_position,X
    LDA z:0x42
    STA z:player.y_position,X
    STZ a:addr(0x12F),X
    REP #0x20
    LDA #addr(play_exit_wrap_animation)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(play_exit_wrap_animation)
    STA z:object.handler+2,X

.locret_C416D0:
    RTL

wrap_positions:
    dw 0x48, 0x38    ; 0
    dw 0xC8, 0x38    ; 2
    dw 0x48, 0x98    ; 4
    dw 0xC8, 0x98    ; 6
    dw 0x88, 0x68    ; 8
do_trampoline:
i16
    SEP #0x20
    INC a:addr(0x12F),X
    JSL clear_playerquare_in_collision_map
    LDY #0xB
    JSL play_sound
    REP #0x20
    LDA z:player.y_position,X
    AND #0xF0
    ORA #8
    STA a:addr(0x114),X
    LDA #0xF000
    STA z:player.trampoline_state,X
    REP #0x20
    LDA #addr(_do_trampoline)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(_do_trampoline)
    STA z:object.handler+2,X

_do_trampoline:
    REP #0x20
    STZ z:0x42
    LDA z:player.trampoline_state,X
    CLC
    ADC #0x80
    STA z:player.trampoline_state,X
    BPL .loc_C41724
    DEC z:0x42

.loc_C41724:
    CLC
    ADC z:object.handler+0x13,X
    STA z:object.handler+0x13,X
    SEP #0x20
    LDA z:0x42
    ADC z:object.handler+0x15,X
    STA z:object.handler+0x15,X
    REP #0x20
    LDA z:player.y_position,X
    BPL .loc_C4174A
    CMP #0xFFF0
    BCS .loc_C4174A
    REP #0x20
    LDA #addr(trampoline_delay)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(trampoline_delay)
    STA z:object.handler+2,X
    RTL

.loc_C4174A:
    JSL load_animation_frame
    RTL

trampoline_delay:
    REP #0x20
    LDA #0x30
    STA z:player.trampoline_state,X
    REP #0x20
    LDA #addr(_trampoline_delay)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(_trampoline_delay)
    STA z:object.handler+2,X

_trampoline_delay:
    REP #0x20
    DEC z:player.trampoline_state,X
    BNE .locret_C41776
    REP #0x20
    LDA #addr(trampoline_land)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(trampoline_land)
    STA z:object.handler+2,X

.locret_C41776:
    RTL

trampoline_land:
    JSL random2
    REP #0x20
    AND #0xC
    STA z:0x40
    JSL random2
    REP #0x20
    AND #3
    INC A
    STA z:0x42
    SEP #0x20
    LDA z:player.x_position,X
    AND #0xF0
    ORA #8
    STA z:player.x_position,X
    JSL randomize_landing
    REP #0x20
    LDA #0
    STA z:player.trampoline_state,X
    REP #0x20
    LDA #addr(_trampoline_land)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(_trampoline_land)
    STA z:object.handler+2,X

_trampoline_land:
    REP #0x20
    STZ z:0x42
    LDA z:player.trampoline_state,X
    CLC
    ADC #0x80
    STA z:player.trampoline_state,X
    BPL .loc_C417C0
    DEC z:0x42

.loc_C417C0:
    CLC
    ADC z:0x13,X
    STA z:0x13,X
    SEP #0x20
    LDA z:0x42
    ADC z:0x15,X
    STA z:0x15,X
    REP #0x20
    LDA z:0x14,X
    BMI .loc_C417FF
    LDA a:addr(0x114),X
    CMP z:0x14,X
    BCS .loc_C417FF
    SEP #0x20
    LDA a:addr(0x114),X
    STA z:player.y_position,X
    LDA z:player.direction,X
    STA z:0x40
    JSL change_direction_and_start_animation
    SEP #0x20
    STZ a:addr(0x12F),X
    LDA z:player.is_ai,X
    BNE .loc_C41804
    REP #0x20
    LDA #addr(handle_player_movement)
    STA z:0,X
    SEP #0x20
    LDA #bank(handle_player_movement)
    STA z:2,X

.loc_C417FF:
    JSL load_animation_frame
    RTL

.loc_C41804:
    REP #0x20
    LDA #addr(handle_player_movement_1)
    STA z:0,X
    SEP #0x20
    LDA #bank(handle_player_movement_1)
    STA z:2,X
    JSL load_animation_frame
    RTL

randomize_landing:
    REP #0x20
    LDA z:player.wrap_delay,X
    PHA
    LDA a:addr(0x114),X
    PHA
    PHX
    LDX z:0x40
    LDA f:trampoline_deltas+2,X
    STA z:0x44
    LDA f:trampoline_deltas,X
    PLX
    CLC
    ADC z:player.x_position,X
    STA z:player.x_position,X
    LDA z:0x44
    CLC
    ADC a:addr(0x114),X
    STA a:addr(0x114),X
    AND #0xF0
    ASL A
    ASL A
    STA z:0x44
    LDA z:player.x_position,X
    AND #0xF0
    LSR A
    LSR A
    LSR A
    ADC z:0x44
    TAY
    LDA a:addr(collision_map),Y
    BIT #BOMB|SOFT_BLOCK|HARD_BLOCK
    BNE .loc_C4185C
    PLA
    PLA
    DEC z:0x42
    BNE randomize_landing
    RTL

.loc_C4185C:
    PLA
    STA a:addr(0x114),X
    PLA
    STA z:player.wrap_delay,X
    RTL

trampoline_deltas:
    dw 0, 0xFFF0     ; 0
    dw 0x10, 0    ; 2
    dw 0, 0x10    ; 4
    dw 0xFFF0, 0    ; 6
level_end_musics:
    db 0, 0xE     ; 0
    db 0x1F, 0x21    ; 2
    db 0x23, 0x25    ; 4
    db 0x27    ; 6
enter_level_exit:
a16
    JSL clear_playerquare_in_collision_map
    LDA #bank(level_end_musics)
    STA z:0x52
    REP #0x20
    LDA a:addr(level_manager_object.level_representation) ; orig=0x0D24
    AND #0xF0
    LSR A
    LSR A
    LSR A
    LSR A
    CLC
    ADC #addr(level_end_musics) ; It seems like the plan was to give each world its own intro and ending sequences
    STA z:0x50
    LDA f:[z:0x50]
    AND #0xFF
    TAY
    JSL play_music
    PHX
    REP #0x20
    LDA #addr(warp_graphics)
    STA z:0x53
    SEP #0x20
    LDA #bank(warp_graphics)
    STA z:0x55
    SEP #0x20
    LDA a:addr(word_7E0C8F+1) ; orig=0x0C90
    BEQ .loc_C418C2
    REP #0x20
    LDA #addr(warp_mini_graphics)
    STA z:0x53
    SEP #0x20
    LDA #bank(warp_mini_graphics)
    STA z:0x55

.loc_C418C2:
    JSL graphics_decompression_8192_bytes
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300

.loc_C418CB:
    CMP a:addr(frame_count) ; orig=0x0300
    BEQ .loc_C418CB
    LDA #0
    STA a:addr(H_DMA_CHANNEL_ENABLE)
    REP #0x20
    LDA #0x6800
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    PLX
    REP #0x20
    LDA #addr(enter_wrap_animation)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C41915)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(.loc_C41915)
    STA z:object.handler+2,X

.loc_C41915:
    JSL advance_animation
    BCS .loc_C4191F
    JML .locret_C41947

.loc_C4191F:
    REP #0x20
    LDA #addr(.loc_C41934)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C41934)
    STA z:2,X
    REP #0x20
    LDA #0x80
    STA z:0x10,X
    RTL

.loc_C41934:
    REP #0x20
    DEC z:0x10,X
    BNE .locret_C41947
    SEP #0x20
    LDA a:addr(level_manager_object.current_screen) ; orig=0x0D3F
    BNE .locret_C41947
    INC a:addr(level_manager_object.current_screen) ; orig=0x0D3F
    INC a:addr(current_screen) ; orig=0x00A4

.locret_C41947:
    RTL

i16

; Choose a random living AI enemy, and increase its level

last_human_death:
    PHX
    REP #0x20
    LDA a:addr(level_manager_object.number_of_ai_players) ; orig=0x0D37
    INC A
    AND #0xFF
    TAX
    JSL random
    PLX
    REP #0x20
    AND #0xFF
    STA z:0x40
    STZ z:0x42
    SEP #0x20
    LDY #addr(player_1)

.loc_C41966:
    LDA a:addr(player.gameover_related),Y
    BEQ .loc_C41982
    LDA a:addr(player.is_ai),Y
    BEQ .loc_C41982
    LDA #0
    STA a:addr(player.lives),Y
    LDA z:0x42
    INC z:0x42
    CMP z:0x40
    BNE .loc_C41982
    LDA #4
    STA a:addr(player.lives),Y

.loc_C41982:
    REP #0x20
    TYA
    CLC
    ADC #0x40
    TAY
    CMP #addr(player_4 + player.sizeof)
    SEP #0x20
    BNE .loc_C41966
    RTL

player_death:
i16
    JSL clear_playerquare_in_collision_map
    LDY #0x1F
    JSL play_sound
    SEP #0x20
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #3
    BNE .loc_C419BB
    JSL sub_C44945
    SEP #0x20
    DEC a:addr(level_manager_object.number_of_human_players) ; orig=0x0D36
    DEC a:addr(level_manager_object.enemy_count) ; orig=0x0D25
    LDA a:addr(level_manager_object.number_of_human_players) ; orig=0x0D36
    BNE .loc_C419BB
    JSL last_human_death

.loc_C419BB:
    SEP #0x20
    LDA z:0x1F,X
    STA z:0x1E,X
    LDA #0
    STA z:0x12,X
    REP #0x20
    LDA #addr(death_animation)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(_player_death)
    STA z:0,X
    SEP #0x20
    LDA #bank(_player_death)
    STA z:2,X

_player_death:
    JSL advance_animation
    BCC .locret_C41A07
    SEP #0x20
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #3
    BEQ sub_C41A08
    STZ z:0x2F,X
    JSL sub_C4775B
    SEP #0x20
    LDA z:0x3D,X
    BEQ sub_C41A40
    DEC z:0x3D,X
    JSL draw_number_of_lives
    JMP a:addr(init_player_handler)

.locret_C41A07:
    RTL

sub_C41A08:
    REP #0x20
    LDA z:5,X
    AND #0xFF
    PHX
    TAX
    LDA f:byte_C3092C,X
    PLX
    AND #0xFF
    TAY
    LDA z:player.player_index,X
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:byte_C30938,X
    PLX
    STA a:addr(bg3_tilemap),Y
    INC A
    STA a:addr(bg3_tilemap+2),Y
    CLC
    ADC #0xF
    STA a:addr(bg3_tilemap+0x40),Y
    INC A
    STA a:addr(bg3_tilemap+0x42),Y
    SEP #0x20
    STZ z:4,X
    STZ z:player.hit_flags,X
    RTL

sub_C41A40:
    REP #0x20
    LDA z:5,X
    AND #0xFF
    ASL A
    TAY
    LDA #0
    STA a:addr(0xCAA),Y
    SEP #0x20
    DEC a:addr(level_manager_object.gameover_related) ; orig=0x0D32
    STZ z:4,X
    RTL

copy_to_bg3_tilemap:
    REP #0x20

.loc_C41A59:
    LDA f:[z:0x50]
    STA a:addr(bg3_tilemap),Y
    INY
    INY
    INC z:0x50
    INC z:0x50
    DEC z:0x40
    BNE .loc_C41A59
    RTL

change_direction_and_start_animation:
    SEP #0x20
    LDA z:0x40
    STA z:player.direction,X

start_animation_by_index:
    REP #0x20
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:player_animation_list,X
    STA z:0x50
    PLX
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    RTL

start_animation_by_direction:
    SEP #0x20
    LDA #bank(up_walking_animation)
    STA z:0x52
    LDA z:0x40
    STA z:player.direction,X
    REP #0x20
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:player_animation_list,X
    STA z:0x50
    PLX
    JSL start_animation
    RTL

draw_number_of_lives:
i16
    SEP #0x20
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #3
    BNE .loc_C41AB4
    JML locret

.loc_C41AB4:
    LDY #0x46
    LDA z:player.player_index,X
    BEQ .loc_C41ABE
    LDY #0x68

.loc_C41ABE:
    REP #0x20
    LDA z:player.lives,X
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:hud_digits_tilenos_upper,X
    PLX
    STA a:addr(bg3_tilemap),Y
    CLC
    ADC #0x10
    STA a:addr(bg3_tilemap+0x40),Y
    RTL

add_to_score_if_allowed:
    SEP #0x20
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #3
    BNE .loc_C41AE5
    JML locret

.loc_C41AE5:
    LDA z:player.gameover_related,X
    BNE .loc_C41AED
    JML locret

.loc_C41AED:
    LDA z:player.is_ai,X
    BEQ add_to_score
    JML locret

add_to_score:
i16
    SEP #0x20
    LDY #0x4C
    LDA z:player.player_index,X
    BEQ .loc_C41B01
    LDY #0x6E

.loc_C41B01:
    REP #0x20
    SED
    LDA z:player.score_digits_12,X
    CLC
    ADC z:0x40
    STA z:player.score_digits_12,X
    LDA z:player.score_digits_56,X
    ADC z:0x42
    STA z:player.score_digits_56,X
    CLD
    BCC .loc_C41B1E
    LDA #0x9999
    STA z:player.score_digits_12,X
    LDA #0x9999
    STA z:player.score_digits_56,X

.loc_C41B1E:
    LDA #1
    STA z:0x44
    LDA z:player.score_digits_78,X
    AND #0xF0
    LSR A
    LSR A
    LSR A
    BNE .loc_C41B33
    LDA z:0x44
    BEQ .loc_C41B33
    BRA .loc_C41B46

.loc_C41B33:
    STZ z:0x44
    PHX
    TAX
    LDA f:hud_digits_tilenos_upper,X
    PLX
    STA a:addr(bg3_tilemap),Y
    CLC
    ADC #0x10
    STA a:addr(bg3_tilemap+0x40),Y

.loc_C41B46:
    INY
    INY
    LDA z:player.score_digits_78,X
    AND #0xF
    ASL A
    BNE .loc_C41B56
    LDA z:0x44
    BEQ .loc_C41B56
    BRA .loc_C41B69

.loc_C41B56:
    STZ z:0x44
    PHX
    TAX
    LDA f:hud_digits_tilenos_upper,X
    PLX
    STA a:addr(bg3_tilemap),Y
    CLC
    ADC #0x10
    STA a:addr(bg3_tilemap+0x40),Y

.loc_C41B69:
    INY
    INY
    LDA z:player.score_digits_56,X
    AND #0xF0
    LSR A
    LSR A
    LSR A
    BNE .loc_C41B7B
    LDA z:0x44
    BEQ .loc_C41B7B
    BRA .loc_C41B8E

.loc_C41B7B:
    STZ z:0x44
    PHX
    TAX
    LDA f:hud_digits_tilenos_upper,X
    PLX
    STA a:addr(bg3_tilemap),Y
    CLC
    ADC #0x10
    STA a:addr(bg3_tilemap+0x40),Y

.loc_C41B8E:
    INY
    INY
    LDA z:player.score_digits_56,X
    AND #0xF
    ASL A
    BNE .loc_C41B9E
    LDA z:0x44
    BEQ .loc_C41B9E
    BRA .loc_C41BB1

.loc_C41B9E:
    STZ z:0x44
    PHX
    TAX
    LDA f:hud_digits_tilenos_upper,X
    PLX
    STA a:addr(bg3_tilemap),Y
    CLC
    ADC #0x10
    STA a:addr(bg3_tilemap+0x40),Y

.loc_C41BB1:
    INY
    INY
    LDA z:player.score_digits_34,X
    AND #0xF0
    LSR A
    LSR A
    LSR A
    BNE .loc_C41BC3
    LDA z:0x44
    BEQ .loc_C41BC3
    BRA .loc_C41BD6

.loc_C41BC3:
    STZ z:0x44
    PHX
    TAX
    LDA f:hud_digits_tilenos_upper,X
    PLX
    STA a:addr(bg3_tilemap),Y
    CLC
    ADC #0x10
    STA a:addr(bg3_tilemap+0x40),Y

.loc_C41BD6:
    INY
    INY
    LDA z:player.score_digits_34,X
    AND #0xF
    ASL A
    BNE .loc_C41BE6
    LDA z:0x44
    BEQ .loc_C41BE6
    BRA .loc_C41BF9

.loc_C41BE6:
    STZ z:0x44
    PHX
    TAX
    LDA f:hud_digits_tilenos_upper,X
    PLX
    STA a:addr(bg3_tilemap),Y
    CLC
    ADC #0x10
    STA a:addr(bg3_tilemap+0x40),Y

.loc_C41BF9:
    INY
    INY
    LDA z:player.score_digits_12,X
    AND #0xF0
    LSR A
    LSR A
    LSR A
    BNE .loc_C41C0B
    LDA z:0x44
    BEQ .loc_C41C0B
    BRA .loc_C41C1E

.loc_C41C0B:
    STZ z:0x44
    PHX
    TAX
    LDA f:hud_digits_tilenos_upper,X
    PLX
    STA a:addr(bg3_tilemap),Y
    CLC
    ADC #0x10
    STA a:addr(bg3_tilemap+0x40),Y

.loc_C41C1E:
    INY
    INY
    LDA z:player.score_digits_12,X
    AND #0xF
    ASL A
    BNE .loc_C41C2E
    LDA z:0x44
    BEQ .loc_C41C2E
    BRA .loc_C41C41

.loc_C41C2E:
    STZ z:0x44
    PHX
    TAX
    LDA f:hud_digits_tilenos_upper,X
    PLX
    STA a:addr(bg3_tilemap),Y
    CLC
    ADC #0x10
    STA a:addr(bg3_tilemap+0x40),Y

.loc_C41C41:
    INY
    INY

.loc_C41C43:
    REP #0x20
    LDA z:player.score_digits_12,X
    SEC
    SBC a:addr(0x11C),X
    LDA z:player.score_digits_56,X
    SBC a:addr(0x11A),X
    BCC locret
    SED
    LDA a:addr(0x11C),X
    CLC
    ADC a:addr(0x11C),X
    STA a:addr(0x11C),X
    LDA a:addr(0x11A),X
    ADC a:addr(0x11A),X
    STA a:addr(0x11A),X
    CLD
    JSL add_extra_life
    LDA a:addr(0x11C),X
    SEC
    SBC #0
    LDA a:addr(0x11A),X
    SBC #0x1000
    BCC .loc_C41C43
    LDA #0
    STA a:addr(0x11C),X
    LDA #0x1000
    STA a:addr(0x11A),X
    BRA .loc_C41C43

locret:
    REP #0x20
    RTL

hud_digits_tilenos_upper:
    dw 0x208F, 0x2086, 0x2087, 0x2088, 0x2089, 0x208A, 0x208B, 0x208C, 0x208D, 0x208E
punch:
    REP #0x20
    LDA z:player.direction,X
    AND #0xF
    ASL A
    PHX
    TAX
    LDA f:player_animation_list+0x18,X
    STA z:0x50
    PLX
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C41CC7)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(.loc_C41CC7)
    STA z:object.handler+2,X

.loc_C41CC7:
    JSL handle_player_movement.inner
    BCC .locret_C41D08
    REP #0x20
    LDA z:player.direction,X
    AND #0xF
    ASL A
    PHX
    TAX
    LDA f:player_animation_list,X
    STA z:0x50
    PLX
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(handle_player_movement)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(handle_player_movement)
    STA z:object.handler+2,X
    SEP #0x20
    LDA z:player.is_ai,X
    BEQ .locret_C41D08
    REP #0x20
    LDA #addr(handle_player_movement_1)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(handle_player_movement_1)
    STA z:object.handler+2,X

.locret_C41D08:
    RTL

    SEP #0x20
sub_C41D0B:
    SEP #0x20
    LDA z:object.handler+0x39,X
    BIT #2
    BNE .loc_C41D17
    JML sub_C41D24.locret_C41E15

.loc_C41D17:
    REP #0x20
    LDA #addr(punch)
    STA z:0,X
    SEP #0x20
    LDA #bank(punch)
    STA z:2,X

sub_C41D24:
    SEP #0x20
    LDA z:0x20,X
    BIT #1
    BEQ .loc_C41D30
    JML .loc_C41DE1

.loc_C41D30:
    BIT #2
    BEQ .loc_C41D38
    JML .loc_C41DAC

.loc_C41D38:
    BIT #4
    BEQ .loc_C41D40
    JML .loc_C41D77

.loc_C41D40:
    REP #0x20
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0xFFF3
    STA z:player.y_position,X
    JSL sub_C60B6D
    PLA
    STA z:player.y_position,X
    PLA
    STA z:player.x_position,X
    LDA a:addr(collision_map),Y
    BIT #BOMB
    BNE .loc_C41D70
    JML .locret_C41E15

.loc_C41D70:
    ORA #0x200
    STA a:addr(collision_map),Y
    RTL
.loc_C41D77:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0xD
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    LDA a:addr(collision_map),Y
    BIT #BOMB
    BNE .loc_C41DA5
    JML .locret_C41E15

.loc_C41DA5:
    ORA #0x2200
    STA a:addr(collision_map),Y
    RTL
.loc_C41DAC:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0xFFF3
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    LDA a:addr(collision_map),Y
    BIT #BOMB
    BNE .loc_C41DDA
    JML .locret_C41E15

.loc_C41DDA:
    ORA #0x3200
    STA a:addr(collision_map),Y
    RTL
.loc_C41DE1:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0xD
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    LDA a:addr(collision_map),Y
    BIT #BOMB
    BNE .loc_C41E0F
    JML .locret_C41E15

.loc_C41E0F:
    ORA #0x1200
    STA a:addr(collision_map),Y

.locret_C41E15:
    RTL

sub_C41E16:
    JSL sub_C4225E
    BCS .loc_C41E20
    JML handle_player_movement.inner2

.loc_C41E20:
    JSL is_object_aligned
    BCS .loc_C41E2A
    JML handle_player_movement.inner2

.loc_C41E2A:
    SEP #0x20
    LDA z:0x20,X
    AND #0xC
    BNE .loc_C41E36
    JML handle_player_movement.inner2

.loc_C41E36:
    LDA z:0x14,X
    AND #0xF
    CMP #8
    BCS .loc_C41E95
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #addr(-9)
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C41E66
    JML handle_player_movement.inner2

.loc_C41E66:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0x10
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0xFFF0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C41E8E
    JML handle_player_movement.inner2

.loc_C41E8E:
    JSL sub_C423BD
    JMP a:addr(handle_player_movement.inner)

.loc_C41E95:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #8
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C41EBD
    JML handle_player_movement.inner2

.loc_C41EBD:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0x10
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0x10
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C41EE5
    JML handle_player_movement.inner2

.loc_C41EE5:
    JSL sub_C423BD
    JMP a:addr(handle_player_movement.inner)

sub_C41EEC:
    JSL sub_C4220E
    BCS .loc_C41EF6
    JML handle_player_movement.inner2

.loc_C41EF6:
    JSL is_object_aligned
    BCS .loc_C41F00
    JML handle_player_movement.inner2

.loc_C41F00:
    SEP #0x20
    LDA z:player.direction,X
    AND #0xC
    BNE .loc_C41F0C
    JML handle_player_movement.inner2

.loc_C41F0C:
    LDA z:player.y_position,X
    AND #0xF
    CMP #8
    BCS .loc_C41F6B
    REP #0x20
    LDA z:player.x_position,X
    PHA
    LDA z:player.y_position,X
    PHA
    LDA z:player.x_position,X
    CLC
    ADC #0
    STA z:player.x_position,X
    LDA z:player.y_position,X
    CLC
    ADC #0xFFF7
    STA z:player.y_position,X
    JSL sub_C60B6D
    PLA
    STA z:player.y_position,X
    PLA
    STA z:player.x_position,X
    BCC .loc_C41F3C
    JML handle_player_movement.inner2

.loc_C41F3C:
    REP #0x20
    LDA z:player.x_position,X
    PHA
    LDA z:player.y_position,X
    PHA
    LDA z:player.x_position,X
    CLC
    ADC #0xFFF0
    STA z:player.x_position,X
    LDA z:player.y_position,X
    CLC
    ADC #0xFFF0
    STA z:player.y_position,X
    JSL sub_C60B6D
    PLA
    STA z:player.y_position,X
    PLA
    STA z:player.x_position,X
    BCC .loc_C41F64
    JML handle_player_movement.inner2

.loc_C41F64:
    JSL sub_C423BD
    JMP a:addr(handle_player_movement.inner)

.loc_C41F6B:
    REP #0x20
    LDA z:player.x_position,X
    PHA
    LDA z:player.y_position,X
    PHA
    LDA z:player.x_position,X
    CLC
    ADC #0
    STA z:player.x_position,X
    LDA z:player.y_position,X
    CLC
    ADC #8
    STA z:player.y_position,X
    JSL sub_C60B6D
    PLA
    STA z:player.y_position,X
    PLA
    STA z:player.x_position,X
    BCC .loc_C41F93
    JML handle_player_movement.inner2

.loc_C41F93:
    REP #0x20
    LDA z:player.x_position,X
    PHA
    LDA z:player.y_position,X
    PHA
    LDA z:player.x_position,X
    CLC
    ADC #0xFFF0
    STA z:player.x_position,X
    LDA z:player.y_position,X
    CLC
    ADC #0x10
    STA z:player.y_position,X
    JSL sub_C60B6D
    PLA
    STA z:player.y_position,X
    PLA
    STA z:player.x_position,X
    BCC .loc_C41FBB
    JML handle_player_movement.inner2

.loc_C41FBB:
    JSL sub_C423BD
    JMP a:addr(handle_player_movement.inner)

sub_C41FC2:
    JSL sub_C421BE
    BCS .loc_C41FCC
    JML handle_player_movement.inner2

.loc_C41FCC:
    JSL is_object_aligned
    BCS .loc_C41FD6
    JML handle_player_movement.inner2

.loc_C41FD6:
    SEP #0x20
    LDA z:player.direction,X
    AND #3
    BNE .loc_C41FE2
    JML handle_player_movement.inner2

.loc_C41FE2:
    LDA z:player.x_position,X
    AND #0xF
    CMP #8
    BCS .loc_C42041
    REP #0x20
    LDA z:player.x_position,X
    PHA
    LDA z:player.y_position,X
    PHA
    LDA z:player.x_position,X
    CLC
    ADC #0xFFF7
    STA z:player.x_position,X
    LDA z:player.y_position,X
    CLC
    ADC #0
    STA z:player.y_position,X
    JSL sub_C60B6D
    PLA
    STA z:player.y_position,X
    PLA
    STA z:player.x_position,X
    BCC .loc_C42012
    JML handle_player_movement.inner2

.loc_C42012:
    REP #0x20
    LDA z:player.x_position,X
    PHA
    LDA z:player.y_position,X
    PHA
    LDA z:player.x_position,X
    CLC
    ADC #0xFFF0
    STA z:player.x_position,X
    LDA z:player.y_position,X
    CLC
    ADC #0x10
    STA z:player.y_position,X
    JSL sub_C60B6D
    PLA
    STA z:player.y_position,X
    PLA
    STA z:player.x_position,X
    BCC .loc_C4203A
    JML handle_player_movement.inner2

.loc_C4203A:
    JSL sub_C42364
    JMP a:addr(handle_player_movement.inner)

.loc_C42041:
    REP #0x20
    LDA z:player.x_position,X
    PHA
    LDA z:player.y_position,X
    PHA
    LDA z:player.x_position,X
    CLC
    ADC #8
    STA z:player.x_position,X
    LDA z:player.y_position,X
    CLC
    ADC #0
    STA z:player.y_position,X
    JSL sub_C60B6D
    PLA
    STA z:player.y_position,X
    PLA
    STA z:player.x_position,X
    BCC .loc_C42069
    JML handle_player_movement.inner2

.loc_C42069:
    REP #0x20
    LDA z:player.x_position,X
    PHA
    LDA z:player.y_position,X
    PHA
    LDA z:player.x_position,X
    CLC
    ADC #0x10
    STA z:player.x_position,X
    LDA z:player.y_position,X
    CLC
    ADC #0x10
    STA z:player.y_position,X
    JSL sub_C60B6D
    PLA
    STA z:player.y_position,X
    PLA
    STA z:player.x_position,X
    BCC .loc_C42091
    JML handle_player_movement.inner2

.loc_C42091:
    JSL sub_C42364
    JMP a:addr(handle_player_movement.inner)

sub_C42098:
    JSL sub_C4216E
    BCS .loc_C420A2
    JML handle_player_movement.inner2

.loc_C420A2:
    JSL is_object_aligned
    BCS .loc_C420AC
    JML handle_player_movement.inner2

.loc_C420AC:
    SEP #0x20
    LDA z:0x20,X
    AND #3
    BNE .loc_C420B8
    JML handle_player_movement.inner2

.loc_C420B8:
    LDA z:0x11,X
    AND #0xF
    CMP #8
    BCS .loc_C42117
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0xFFF7
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C420E8
    JML handle_player_movement.inner2

.loc_C420E8:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0xFFF0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0xFFF0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C42110
    JML handle_player_movement.inner2

.loc_C42110:
    JSL sub_C42364
    JMP a:addr(handle_player_movement.inner)

.loc_C42117:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #8
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C4213F
    JML handle_player_movement.inner2
.loc_C4213F:
    REP #0x20
    LDA z:player.x_position,X
    PHA
    LDA z:player.y_position,X
    PHA
    LDA z:player.x_position,X
    CLC
    ADC #0x10
    STA z:player.x_position,X
    LDA z:player.y_position,X
    CLC
    ADC #0xFFF0
    STA z:player.y_position,X
    JSL sub_C60B6D
    PLA
    STA z:player.y_position,X
    PLA
    STA z:player.x_position,X
    BCC .loc_C42167
    JML handle_player_movement.inner2

.loc_C42167:
    JSL sub_C42364
    JMP a:addr(handle_player_movement.inner)

sub_C4216E:
    REP #0x20
    LDA z:player.x_position,X
    PHA
    LDA z:player.y_position,X
    PHA
    LDA z:player.x_position,X
    CLC
    ADC #0
    STA z:player.x_position,X
    LDA z:player.y_position,X
    CLC
    ADC #0xFFF3
    STA z:player.y_position,X
    JSL sub_C60B6D
    PLA
    STA z:player.y_position,X
    PLA
    STA z:player.x_position,X
    BCC .loc_C421B4
    LDA z:player.y_position,X
    AND #0xF
    CMP #8
    BEQ .loc_C421AE
    BCC .loc_C421A8
    JSL sub_C422F1
    JSL sub_C4239D
    CLC
    RTL

.loc_C421A8:
    JSL sub_C422AE
    CLC
    RTL

.loc_C421AE:
    JSL sub_C422AE
    SEC
    RTL

.loc_C421B4:
    JSL sub_C422F1
    JSL sub_C4239D
    CLC
    RTL

sub_C421BE:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0xD
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C42204
    LDA z:0x14,X
    AND #0xF
    CMP #8
    BEQ .loc_C421FE
    BCS .loc_C421F8
    JSL sub_C422F1
    JSL sub_C423CE
    CLC
    RTL

.loc_C421F8:
    JSL sub_C422AE
    CLC
    RTL

.loc_C421FE:
    JSL sub_C422AE
    SEC
    RTL

.loc_C42204:
    JSL sub_C422F1
    JSL sub_C423CE
    CLC
    RTL

sub_C4220E:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0xFFF3
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C42254
    LDA z:0x11,X
    AND #0xF
    CMP #8
    BEQ .loc_C4224E
    BCC .loc_C42248
    JSL sub_C4230B
    JSL sub_C42375
    CLC
    RTL

.loc_C42248:
    JSL sub_C422AE
    CLC
    RTL

.loc_C4224E:
    JSL sub_C422AE
    SEC
    RTL

.loc_C42254:
    JSL sub_C4230B
    JSL sub_C42375
    CLC
    RTL

sub_C4225E:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0xD
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C422A4
    LDA z:0x11,X
    AND #0xF
    CMP #8
    BEQ .loc_C4229E
    BCS .loc_C42298
    JSL sub_C4230B
    JSL sub_C42325
    CLC
    RTL

.loc_C42298:
    JSL sub_C422AE
    CLC
    RTL

.loc_C4229E:
    JSL sub_C422AE
    SEC
    RTL

.loc_C422A4:
    JSL sub_C4230B
    JSL sub_C42325
    CLC
    RTL

sub_C422AE:
    SEP #0x20
    LDA z:object.handler+0x39,X
    BIT #1
    BEQ .locret_C422E7
    LDA a:addr(collision_map),Y
    BIT #BOMB
    BEQ .locret_C422E7
    LDA a:addr(collision_map+1),Y
    BIT #2
    BNE .locret_C422E7
    LDA #0
    XBA
    LDA z:0x20,X
    PHX
    TAX
    LDA f:byte_C422E8,X
    PLX
    ORA #8
    CMP a:addr(collision_map+1),Y
    BEQ .loc_C422DF
    STA a:addr(collision_map+1),Y
    LDA #addr(BOMB)
    STA a:addr(collision_map),Y

.loc_C422DF:
    LDA a:addr(collision_map),Y
    ORA #EXIT
    STA a:addr(collision_map),Y

.locret_C422E7:
    RTL

byte_C422E8:
    db 0, 0x10    ; 0
    db 0x30, 0    ; 2
    db 0x20, 0    ; 4
    db 0, 0    ; 6
    db 0     ; 8
sub_C422F1:
    SEP #0x20
    LDA z:0x11,X
    AND #0xF
    CMP #8
    BEQ .loc_C42308
    BCC .loc_C42304
    JSL sub_C42375
    REP #0x20
    RTL

.loc_C42304:
    JSL sub_C42325

.loc_C42308:
    REP #0x20
    RTL

sub_C4230B:
    SEP #0x20
    LDA z:0x14,X
    AND #0xF
    CMP #8
    BEQ .loc_C42322
    BCC .loc_C4231E
    JSL sub_C4239D
    REP #0x20
    RTL

.loc_C4231E:
    JSL sub_C423CE

.loc_C42322:
    REP #0x20
    RTL

sub_C42325:
    REP #0x20
    LDA z:0x10,X
    AND #0xF00
    CMP #0x700
    BCS sub_C4236D
    AND #0x700
    EOR #0x700
    CMP z:0x3E,X
    BCS sub_C4236D
    LDA z:0x10,X
    AND #0xF800
    ORA #0x800
    STA z:0x10,X
    RTL

sub_C42346:
    REP #0x20
    LDA z:0x10,X
    BIT #0x800
    BNE sub_C4236D
    AND #0x700
    EOR #0x700
    CMP z:0x3E,X
    BCS sub_C4236D
    LDA z:0x10,X
    AND #0xF800
    ORA #0x800
    STA z:0x10,X
    RTL

sub_C42364:
    REP #0x20
    LDA z:0x20,X
    BIT #1
    BEQ sub_C42395
    ; fallthrough

sub_C4236D:
    LDA z:0x10,X
    CLC
    ADC z:0x3E,X
    STA z:0x10,X
    RTL

sub_C42375:
    REP #0x20
    LDA z:player.wrap_delay,X
    AND #0xF00
    CMP #0x900
    BCC sub_C42395
    LDA z:player.wrap_delay,X
    AND #0x700
    CMP z:0x3E,X
    BCS sub_C42395
    LDA z:player.wrap_delay,X
    AND #0xF800
    ORA #0x800
    STA z:player.wrap_delay,X
    RTL

sub_C42395:
    LDA z:player.wrap_delay,X
    SEC
    SBC z:0x3E,X
    STA z:player.wrap_delay,X
    RTL

sub_C4239D:
    REP #0x20
    LDA z:0x13,X
    AND #0xF00
    CMP #0x900
    BCC sub_C423C6
    LDA z:0x13,X
    AND #0x700
    CMP z:0x3E,X
    BCS sub_C423C6
    LDA z:0x13,X
    AND #0xF800
    ORA #0x800
    STA z:0x13,X
    RTL

sub_C423BD:
    REP #0x20
    LDA z:0x20,X
    BIT #4
    BNE sub_C423EF
    ; fallthrough

sub_C423C6:
    LDA z:0x13,X
    SEC
    SBC z:0x3E,X
    STA z:0x13,X
    RTL

sub_C423CE:
    REP #0x20
    LDA z:0x13,X
    AND #0xF00
    CMP #0x700
    BCS sub_C423EF
    AND #0x700
    EOR #0x700
    CMP z:0x3E,X
    BCS sub_C423EF
    LDA z:0x13,X
    AND #0xF800
    ORA #0x800
    STA z:0x13,X
    RTL
    ; fallthrough
    
sub_C423EF:
    LDA z:0x13,X
    CLC
    ADC z:0x3E,X
    STA z:0x13,X
    RTL

is_object_aligned:
    SEP #0x20
    LDA z:player.x_position,X
    AND #0xF
    CMP #8
    BNE .loc_C4240B
    LDA z:player.y_position,X
    AND #0xF
    CMP #8
    BNE .loc_C4240B
    CLC
    RTL

.loc_C4240B:
    SEC
    RTL

try_drop_bomb:
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300
    AND #3
    BEQ .loc_C4241A
    JML handle_player_movement.loc_C412EE

.loc_C4241A:
    SEP #0x20
    LDA z:player.bombups,X
    STA z:0x40
    LDA a:player.poison_state + 2,X
    BIT #(POISON_MIN_FIRE_SINGLE_BOMB >> 16)
    BEQ .loc_C4242B
    LDA #0
    STA z:0x40

.loc_C4242B:
    LDA z:0x40
    CMP z:player.current_bomb_count,X
    BCS .loc_C42435
    JML handle_player_movement.loc_C412EE

.loc_C42435:
    JSL get_object_square_index
    REP #0x20
    TAY
    LDA a:addr(collision_map),Y
    AND #0x2FF
    CMP #0x210
    BNE .loc_C4244B
    JML handle_player_movement.loc_C412EE

.loc_C4244B:
    AND #0xE0
    BEQ .loc_C42454
    JML handle_player_movement.loc_C412EE

.loc_C42454:
    STY z:0x56
    JSL drop_bomb
    JMP a:addr(handle_player_movement.loc_C412EE)

sub_C4245D:
i16
    REP #0x20
    LDX #0xF40

.loc_C42462:
    LDA z:0,X
    CMP #addr(bonus_handling_object)
    BEQ .loc_C42473
    LDA z:6,X
    CMP #0xFFFF
    BEQ .locret_C42482
    TAX
    BRA .loc_C42462

.loc_C42473:
    REP #0x20
    LDA #addr(sub_C42506)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C42506)
    STA z:2,X
    BRA sub_C4245D

.locret_C42482:
    RTL

create_bonus_object:
    REP #0x20
    PHA
    STY z:0x46
    SEP #0x20
    LDA #low(bonus_handling_object)
    STA z:0xDB
    LDA #high(bonus_handling_object)
    STA z:0xDC
    LDA #bank(bonus_handling_object)
    STA z:0xDD
    LDA #0x80
    STA z:0xD3
    JSL create_object
    REP #0x20
    PLA
    BCS .locret_C424D2
    PHY
    LDY z:0x46
    ORA #0x200
    STA a:addr(collision_map),Y
    AND #BONUS_MASK
    ASL A
    PHX
    TAX
    LDA f:bonus_tiles,X
    PLX
    STA a:addr(bg1_tilemap),Y
    PLY
    STA a:addr(0x20),Y
    ORA #0x20
    STA a:addr(0x21),Y
    LDA z:0x46
    STA a:addr(0x12),Y
    LDA #0
    STA a:addr(0x14),Y
    INC a:addr(number_of_visible_bonuses) ; orig=0x0C91

.locret_C424D2:
    RTL

bonus_handling_object:
    REP #0x20
    LDY z:0x12,X
    LDA a:addr(collision_map),Y
    BIT #0x400
    BNE .loc_C424FC
    AND #0xFF
    BEQ .loc_C424FC
    CMP #addr(BONUS_MASK)
    BEQ .loc_C424FC
    SEP #0x20
    PHX
    INC z:0x14,X
    LDA z:0x14,X
    BIT #2
    BNE .loc_C424F5
    INX

.loc_C424F5:
    LDA z:0x20,X
    STA a:addr(bg1_tilemap),Y
    PLX
    RTL

.loc_C424FC:
    REP #0x20
    DEC a:addr(number_of_visible_bonuses) ; orig=0x0C91
    JSL delete_object
    RTL

sub_C42506:
    REP #0x20
    LDY z:0x12,X
    LDA #0
    STA a:addr(collision_map),Y
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    RTL

sub_C42517:
    REP #0x20
    STY z:0x56
    SEP #0x20
    LDA #low(sub_C4257B)
    STA z:0xDB
    LDA #high(sub_C4257B)
    STA z:0xDC
    LDA #bank(sub_C4257B)
    STA z:0xDD
    LDA #0x80
    STA z:0xD3
    JSL create_object
    REP #0x20
    BCS .loc_C42553
    LDA z:0x42
    STA a:addr(0xC),Y
    LDA z:0x4A
    STA a:addr(0xE),Y
    LDA #1
    STA a:addr(0xA),Y
    LDA #0
    STA a:addr(0x10),Y
    LDA z:0x56
    STA a:addr(8),Y
    LDY z:0x56
    RTL

.loc_C42553:
    LDY z:0x56
    LDA a:addr(collision_map),Y
    BIT #0x40
    BEQ .loc_C4256E
    LDA #0
    STA a:addr(collision_map),Y
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    JSL sub_C42654
    RTL

.loc_C4256E:
    LDA #0
    STA a:addr(collision_map),Y
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    RTL

sub_C4257B:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C42588
    JML nullsub_C30015

.loc_C42588:
    BIT #0x41
    BEQ .loc_C42590
    JML .locret_C4262D

.loc_C42590:
    REP #0x20
    LDY z:8,X
    LDA a:addr(collision_map),Y
    BIT #0x80
    BEQ .loc_C425A0
    JML .loc_C42629

.loc_C425A0:
    DEC z:0xA,X
    BEQ .loc_C425A8
    JML .locret_C4262D

.loc_C425A8:
    LDA z:0xE,X
    PHX
    TAX
    LDA f:byte_C428C1,X
    STA z:0x40
    LDA f:byte_C428C1+2,X
    STA z:0x42
    PLX
    LDA z:0x40
    STA z:0xA,X
    LDA z:0x42
    STA a:addr(bg1_tilemap),Y
    INC z:0xE,X
    INC z:0xE,X
    INC z:0xE,X
    INC z:0xE,X
    LDA z:0xE,X
    BIT #0x1F
    BNE .locret_C4262D
    LDA a:addr(collision_map),Y
    BIT #0x40
    BEQ .loc_C4262E
    LDA z:0xC,X
    BEQ .loc_C4263F
    LDA #0x200
    STA a:addr(collision_map),Y
    JSL sub_C42654
    REP #0x20
    LDA #0x5F
    STA a:addr(collision_map),Y
    LDA z:0xC,X
    AND #0x1F
    ASL A
    PHX
    TAX
    LDA f:bonus_tiles,X
    PLX
    STA a:addr(bg1_tilemap),Y
    LDA #6
    STA z:0xA,X
    REP #0x20
    LDA #addr(.loc_C42611)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C42611)
    STA z:2,X

.loc_C42611:
    REP #0x20
    LDY z:8,X
    LDA a:addr(collision_map),Y
    BIT #0x80
    BNE .loc_C42629
    DEC z:0xA,X
    BNE .locret_C4262D
    LDA z:0xC,X
    PHY
    JSL create_bonus_object
    PLY

.loc_C42629:
    JSL delete_object

.locret_C4262D:
    RTL

.loc_C4262E:
    LDA #0
    STA a:addr(collision_map),Y
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    JSL delete_object
    RTL

.loc_C4263F:
    LDA #0
    STA a:addr(collision_map),Y
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    JSL sub_C42654
    JSL delete_object
    RTL

sub_C42654:
i16
    REP #0x20
    LDA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    BIT #0x40
    BNE .locret_C426C8
    BIT #0x1000
    BNE .locret_C426C8
    PHX
    PHY
    LDA a:addr(collision_map),Y
    BIT #0xC0
    BNE .loc_C426DC
    LDA a:addr(0x956),Y
    BIT #0xC0
    BEQ .loc_C42682
    BIT #0x80
    BNE .loc_C4269E
    LDA #0x806
    STA a:addr(0x534),Y
    BRA .loc_C4269E

.loc_C42682:
    BIT #0x320
    BNE .loc_C42695
    LDA a:addr(bg1_tilemap+0x22) ; orig=0x0516
    ORA #8
    STA a:addr(0x534),Y
    STA a:addr(0x554),Y
    BRA .loc_C4269E

.loc_C42695:
    LDA a:addr(bg1_tilemap+0x22) ; orig=0x0516
    ORA #8
    STA a:addr(0x554),Y

.loc_C4269E:
    LDX #0
    LDA a:addr(0x8D6),Y
    BIT #0xC0
    BEQ .loc_C426B9
    LDX #2
    BIT #0x40
    BNE .loc_C426D2
    CPY #0x5D
    BCC .loc_C426C9
    LDX #4

.loc_C426B9:
    LDA f:empty_tile_after_explosion_related,X
    ORA a:addr(bg1_tilemap+0x22) ; orig=0x0516
    STA a:addr(bg1_tilemap),Y
    STA a:addr(bg1_tilemap+0x20),Y

.loc_C426C6:
    PLY
    PLX

.locret_C426C8:
    RTL

.loc_C426C9:
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    PLY
    PLX
    RTL

.loc_C426D2:
    AND #0x1F
    CMP #0x1F
    BNE .loc_C426B9
    BRA .loc_C426C6

.loc_C426DC:
    BIT #0x80
    BNE .loc_C426EF
    LDA a:addr(0x8D6),Y
    BIT #0xC0
    BEQ .loc_C426EF
    LDA #0x802
    STA a:addr(bg1_tilemap),Y

.loc_C426EF:
    LDA a:addr(0x956),Y
    BIT #0xC0
    BNE .loc_C426FF
    TYA
    CLC
    ADC #0x40
    TAY
    BRA .loc_C4269E

.loc_C426FF:
    PLY
    PLX
    RTL

sub_C42702:
i16
    REP #0x20
    LDA a:addr(level_manager_object.anonymous_8) ; orig=0x0D30
    CMP #3
    BEQ .loc_C42714
    LDA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    BIT #0x8000
    BNE .locret_C4273E

.loc_C42714:
    LDA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    BIT #0x200
    BNE .locret_C4273E
    LDY #0x44

.loc_C4271F:
    LDA #0xD
    STA z:0x40

.loc_C42724:
    LDA a:addr(collision_map),Y
    BEQ .loc_C4272D
    JSL sub_C42654

.loc_C4272D:
    INY
    INY
    DEC z:0x40
    BNE .loc_C42724
    TYA
    CLC
    ADC #0x26
    TAY
    CPY #0x304
    BNE .loc_C4271F

.locret_C4273E:
    RTL

sub_C4273F:
    REP #0x20
    LDA #0x80
    STA z:0x32,X
    LDA #8
    STA z:0x40
    JSL change_direction_and_start_animation
    REP #0x20
    LDA #addr(.loc_C4275C)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C4275C)
    STA z:2,X

.loc_C4275C:
    REP #0x20
    DEC z:0x32,X
    BNE .loc_C427DC
    LDA #0x10
    STA z:0x32,X
    LDA #2
    STA z:0x40
    LDA #0xFFFF
    STA z:0x30,X
    LDA z:5,X
    AND #0xFF
    BNE .loc_C42782
    LDA #1
    STA z:0x40
    LDA #1
    STA z:0x30,X

.loc_C42782:
    JSL change_direction_and_start_animation
    REP #0x20
    LDA #addr(.loc_C42793)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C42793)
    STA z:2,X

.loc_C42793:
    REP #0x20
    LDA z:0x30,X
    CLC
    ADC z:0x11,X
    STA z:0x11,X
    DEC z:0x32,X
    BNE .loc_C427B6
    LDA #4
    STA z:0x40
    JSL change_direction_and_start_animation
    REP #0x20
    LDA #addr(.loc_C427BB)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C427BB)
    STA z:2,X

.loc_C427B6:
    JSL advance_animation
    RTL

.loc_C427BB:
    REP #0x20
    LDA #2
    CLC
    ADC z:0x14,X
    STA z:0x14,X
    CMP #0x110
    BCC .loc_C427D7
    REP #0x20
    LDA #addr(.loc_C427D7)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C427D7)
    STA z:2,X

.loc_C427D7:
    JSL advance_animation
    RTL

.loc_C427DC:
    JSL advance_animation_2
    RTL

create_score_popup:
    SEP #0x20
    LDA #low(score_popup)
    STA z:0xDB
    LDA #high(score_popup)
    STA z:0xDC
    LDA #bank(score_popup)
    STA z:0xDD
    LDA #0x80
    STA z:0xD3
    JSL create_object
    BCC .loc_C427FD
    JML .locret_C42815

.loc_C427FD:
    REP #0x20
    LDA z:enemy.x_position,X
    STA a:addr(enemy.x_position),Y
    LDA z:enemy.y_position,X
    STA a:addr(enemy.y_position),Y
    LDA z:enemy.animation,X
    STA a:addr(enemy.animation),Y
    SEP #0x20
    LDA z:enemy.flags,X
    STA a:addr(enemy.flags),Y

.locret_C42815:
    RTL

score_popup:
    SEP #0x20
    LDA #bank(score_popup_related)
    STA z:0x52
    LDA #0xE
    STA z:player.palette+1,X
    LDA #0x30
    STA z:player.palette,X
    REP #0x20
    LDA z:score_popup_object.score_index,X
    CMP #6
    BCC .loc_C42830
    LDA #6

.loc_C42830:
    AND #0xFF
    STA z:score_popup_object.score_index,X
    ASL A
    PHX
    TAX
    LDA f:score_popup_related,X
    STA z:0x50
    PLX
    JSL start_animation
    REP #0x20
    LDA #addr(player_1)
    STA z:0x44
    LDA z:score_popup_object.flags,X
    BIT #2
    BEQ .loc_C42856
    LDA #addr(player_2)
    STA z:0x44

.loc_C42856:
    LDA z:score_popup_object.score_index,X
    ASL A
    ASL A
    PHX
    TAX
    LDA f:some_array_of_scores,X
    STA z:0x42
    LDA f:some_array_of_scores+2,X
    STA z:0x40
    PLX
    STZ z:score_popup_object.score_index,X ; Now reused to make the popup flash
    PHX
    LDX z:0x44
    JSL add_to_score_if_allowed
    PLX
    REP #0x20
    LDA #addr(flash_score_popup)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(flash_score_popup)
    STA z:object.handler+2,X

flash_score_popup:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C4288D
    JML nullsub_C30015

.loc_C4288D:
    BIT #0x41
    BEQ .loc_C42895
    JML .loc_C428AC

.loc_C42895:
    REP #0x20
    LDA z:score_popup_s+0x13,X
    CLC
    ADC #0xFFD0
    STA z:score_popup_s+0x13,X
    INC z:score_popup_object.score_index,X
    LDA z:score_popup_object.score_index,X
    CMP #0x80
    BNE .loc_C428AC
    JSL delete_object
.loc_C428AC:
    SEP #0x20
    LDA #6
    STA z:score_popup_object.effective_palette,X
    LDA z:score_popup_object.score_index,X
    BIT #4
    BEQ .loc_C428BC
    LDA #0xE
    STA z:score_popup_object.effective_palette,X

.loc_C428BC:
    JSL advance_animation
    RTL

byte_C428C1:
    db 0xC, 0, 0xC0, 0x1D ; 0
    db 0xA, 0, 0xC2, 0x1D ; 4
    db 8, 0, 0xC4, 0x1D ; 8
    db 6, 0, 0xC6, 0x1D ; 0xC
    db 2, 0, 0xC8, 0x1D ; 0x10
    db 2, 0, 0xC8, 0x1D ; 0x14
    db 2, 0, 0xCA, 0x1D ; 0x18
    db 1, 0, 0x38, 0xC ; 0x1C
    db 0xC, 0, 0xE0, 0x1D ; 0x20
    db 0xA, 0, 0xE2, 0x1D ; 0x24
    db 8, 0, 0xE4, 0x1D ; 0x28
    db 6, 0, 0xE6, 0x1D ; 0x2C
    db 4, 0, 0xE8, 0x1D ; 0x30
    db 3, 0, 0xEA, 0x1D ; 0x34
    db 2, 0, 0xEC, 0x1D ; 0x38
    db 1, 0, 0x38, 0xC ; 0x3C
player_animation_list:
    da up_walking_animation; 0
    da right_walking_animation; 1
    da left_walking_animation; 2
    da up_walking_animation; 3
    da down_walking_animation; 4
    da up_walking_animation; 5
    da up_walking_animation; 6
    da up_walking_animation; 7
    da up_walking_animation; 8
    da up_walking_animation; 9
    da up_walking_animation; 0xA
    da up_walking_animation; 0xB
    da up_punch_animation; 0xC
    da right_punch_animation; 0xD
    da left_punch_animation; 0xE
    da up_punch_animation; 0xF
    da down_punch_animation; 0x10
    da up_punch_animation; 0x11
    da up_punch_animation; 0x12
    da up_punch_animation; 0x13
    da up_punch_animation; 0x14
    da up_punch_animation; 0x15
    da up_punch_animation; 0x16
    da up_punch_animation; 0x17
    da up_punch_animation; 0x18
    da up_punch_animation; 0x19
    da up_punch_animation; 0x1A
    da up_punch_animation; 0x1B
    da jumping_animation ; 0x1C
    da up_walking_animation; 0x1D
    da right_walking_animation; 0x1E
    da down_walking_animation; 0x1F
    da left_walking_animation; 0x20
    da wrapping_animation; 0x21
    da wrapping_animation; 0x22
    da wrapping_animation; 0x23
    da wrapping_animation; 0x24
animation_frame_C4294B:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0, 0x20
animation_frame_C42951:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x200, 0x20
animation_frame_C42957:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x400, 0x20
animation_frame_C4295D:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2400, 0x20
animation_frame_C42963:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2200, 0x20
animation_frame_C42969:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2000, 0x20
wrapping_animation:
    db 0x12
    animation_frame animation_frame_C4294B, 0x30; 0
    animation_frame animation_frame_C42951, 6; 1
    animation_frame animation_frame_C42957, 6; 2
    animation_frame animation_frame_C4294B, 0x30; 3
    animation_frame animation_frame_C42957, 6; 4
    animation_frame animation_frame_C42951, 6; 5
    animation_frame animation_frame_C4294B, 0x30; 6
    animation_frame animation_frame_C4295D, 5; 7
    animation_frame animation_frame_C42963, 5; 8
    animation_frame animation_frame_C42969, 5; 9
    animation_frame animation_frame_C42963, 5; 0xA
    animation_frame animation_frame_C42969, 5; 0xB
    animation_frame animation_frame_C42963, 5; 0xC
    animation_frame animation_frame_C42969, 5; 0xD
    animation_frame animation_frame_C42963, 5; 0xE
    animation_frame animation_frame_C42969, 5; 0xF
    animation_frame animation_frame_C42963, 5; 0x10
    animation_frame animation_frame_C4295D, 5; 0x11
animation_frame_C429B8:
    db 2
    frame_oam_tile 0x18, 0xF0, 0, 0x20
    frame_oam_tile 0xD8, 0xF0, 0, 0x20
animation_frame_C429C3:
    db 2
    frame_oam_tile 0x17, 0xF0, 0, 0x20
    frame_oam_tile 0xD9, 0xF0, 0, 0x20
animation_frame_C429CE:
    db 2
    frame_oam_tile 0x16, 0xF0, 0, 0x20
    frame_oam_tile 0xDA, 0xF0, 0, 0x20
animation_frame_C429D9:
    db 2
    frame_oam_tile 0x15, 0xF0, 0, 0x20
    frame_oam_tile 0xDB, 0xF0, 0, 0x20
animation_frame_C429E4:
    db 2
    frame_oam_tile 0x14, 0xF0, 0, 0x20
    frame_oam_tile 0xDC, 0xF0, 0, 0x20
animation_frame_C429EF:
    db 2
    frame_oam_tile 0x13, 0xF0, 0, 0x20
    frame_oam_tile 0xDD, 0xF0, 0, 0x20
animation_frame_C429FA:
    db 2
    frame_oam_tile 0x12, 0xF0, 0, 0x20
    frame_oam_tile 0xDE, 0xF0, 0, 0x20
animation_frame_C42A05:
    db 2
    frame_oam_tile 0x11, 0xF0, 0, 0x20
    frame_oam_tile 0xDF, 0xF0, 0, 0x20
animation_frame_C42A10:
    db 2
    frame_oam_tile 0x10, 0xF0, 0, 0x20
    frame_oam_tile 0xE0, 0xF0, 0, 0x20
animation_frame_C42A1B:
    db 2
    frame_oam_tile 0xF, 0xF0, 0, 0x20
    frame_oam_tile 0xE1, 0xF0, 0, 0x20
animation_frame_C42A26:
    db 2
    frame_oam_tile 0xE, 0xF0, 0, 0x20
    frame_oam_tile 0xE2, 0xF0, 0, 0x20
animation_frame_C42A31:
    db 2
    frame_oam_tile 0xD, 0xF0, 0, 0x20
    frame_oam_tile 0xE3, 0xF0, 0, 0x20
animation_frame_C42A3C:
    db 2
    frame_oam_tile 0xC, 0xF0, 0, 0x20
    frame_oam_tile 0xE4, 0xF0, 0, 0x20
animation_frame_C42A47:
    db 2
    frame_oam_tile 0xB, 0xF0, 0, 0x20
    frame_oam_tile 0xE5, 0xF0, 0, 0x20
animation_frame_C42A52:
    db 2
    frame_oam_tile 0xA, 0xF0, 0, 0x20
    frame_oam_tile 0xE6, 0xF0, 0, 0x20
animation_frame_C42A5D:
    db 2
    frame_oam_tile 9, 0xF0, 0, 0x20
    frame_oam_tile 0xE7, 0xF0, 0, 0x20
animation_frame_C42A68:
    db 6
    frame_oam_tile 8, 0xF0, 0, 0x20
    frame_oam_tile 0xE8, 0xF0, 0, 0x20
    frame_oam_tile 8, 0xF0, 0x200, 0x40
    frame_oam_tile 8, 0xF8, 0x1200, 0x40
    frame_oam_tile 0xF0, 0xF8, 0x1200, 0
    frame_oam_tile 0xF0, 0xF0, 0x200, 0
animation_frame_C42A87:
    db 6
    frame_oam_tile 8, 0xF0, 0, 0x20
    frame_oam_tile 0xE8, 0xF0, 0, 0x20
    frame_oam_tile 7, 0xF0, 0x200, 0x40
    frame_oam_tile 7, 0xF8, 0x1200, 0x40
    frame_oam_tile 0xF1, 0xF8, 0x1200, 0
    frame_oam_tile 0xF1, 0xF0, 0x200, 0
animation_frame_C42AA6:
    db 6
    frame_oam_tile 8, 0xF0, 0, 0x20
    frame_oam_tile 0xE8, 0xF0, 0, 0x20
    frame_oam_tile 6, 0xF0, 0x200, 0x40
    frame_oam_tile 6, 0xF8, 0x1200, 0x40
    frame_oam_tile 0xF2, 0xF8, 0x1200, 0
    frame_oam_tile 0xF2, 0xF0, 0x200, 0
animation_frame_C42AC5:
    db 6
    frame_oam_tile 8, 0xF0, 0, 0x20
    frame_oam_tile 0xE8, 0xF0, 0, 0x20
    frame_oam_tile 5, 0xF0, 0x200, 0x40
    frame_oam_tile 5, 0xF8, 0x1200, 0x40
    frame_oam_tile 0xF3, 0xF8, 0x1200, 0
    frame_oam_tile 0xF3, 0xF0, 0x200, 0
animation_frame_C42AE4:
    db 6
    frame_oam_tile 8, 0xF0, 0, 0x20
    frame_oam_tile 0xE8, 0xF0, 0, 0x20
    frame_oam_tile 4, 0xF0, 0x200, 0x40
    frame_oam_tile 4, 0xF8, 0x1200, 0x40
    frame_oam_tile 0xF4, 0xF8, 0x1200, 0
    frame_oam_tile 0xF4, 0xF0, 0x200, 0
animation_frame_C42B03:
    db 6
    frame_oam_tile 8, 0xF0, 0, 0x20
    frame_oam_tile 0xE8, 0xF0, 0, 0x20
    frame_oam_tile 3, 0xF0, 0x200, 0x40
    frame_oam_tile 3, 0xF8, 0x1200, 0x40
    frame_oam_tile 0xF5, 0xF8, 0x1200, 0
    frame_oam_tile 0xF5, 0xF0, 0x200, 0
animation_frame_C42B22:
    db 6
    frame_oam_tile 8, 0xF0, 0, 0x20
    frame_oam_tile 0xE8, 0xF0, 0, 0x20
    frame_oam_tile 2, 0xF0, 0x200, 0x40
    frame_oam_tile 2, 0xF8, 0x1200, 0x40
    frame_oam_tile 0xF6, 0xF8, 0x1200, 0
    frame_oam_tile 0xF6, 0xF0, 0x200, 0
animation_frame_C42B41:
    db 6
    frame_oam_tile 8, 0xF0, 0, 0x20
    frame_oam_tile 0xE8, 0xF0, 0, 0x20
    frame_oam_tile 1, 0xF0, 0x200, 0x40
    frame_oam_tile 1, 0xF8, 0x1200, 0x40
    frame_oam_tile 0xF7, 0xF8, 0x1200, 0
    frame_oam_tile 0xF7, 0xF0, 0x200, 0
animation_frame_C42B60:
    db 6
    frame_oam_tile 8, 0xF0, 0, 0x20
    frame_oam_tile 0xE8, 0xF0, 0, 0x20
    frame_oam_tile 0, 0xF0, 0x200, 0x40
    frame_oam_tile 0, 0xF8, 0x1200, 0x40
    frame_oam_tile 0xF8, 0xF8, 0x1200, 0
    frame_oam_tile 0xF8, 0xF0, 0x200, 0
byte_C42B7F:
    db 1
    animation_frame animation_frame_C429B8, 0xFF
byte_C42B84:
    db 0x18
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
    animation_frame animation_frame_C42A31, 2; 0xA
    animation_frame animation_frame_C42A3C, 2; 0xB
    animation_frame animation_frame_C42A47, 2; 0xC
    animation_frame animation_frame_C42A52, 2; 0xD
    animation_frame animation_frame_C42A5D, 2; 0xE
    animation_frame animation_frame_C42A68, 4; 0xF
    animation_frame animation_frame_C42A87, 2; 0x10
    animation_frame animation_frame_C42AA6, 2; 0x11
    animation_frame animation_frame_C42AC5, 2; 0x12
    animation_frame animation_frame_C42AE4, 2; 0x13
    animation_frame animation_frame_C42B03, 2; 0x14
    animation_frame animation_frame_C42B22, 2; 0x15
    animation_frame animation_frame_C42B41, 2; 0x16
    animation_frame animation_frame_C42B60, 2; 0x17
byte_C42BE5:
    db 0x18
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
    animation_frame animation_frame_C42A52, 2; 0xA
    animation_frame animation_frame_C42A47, 2; 0xB
    animation_frame animation_frame_C42A3C, 2; 0xC
    animation_frame animation_frame_C42A31, 2; 0xD
    animation_frame animation_frame_C42A26, 2; 0xE
    animation_frame animation_frame_C42A1B, 2; 0xF
    animation_frame animation_frame_C42A10, 2; 0x10
    animation_frame animation_frame_C42A05, 2; 0x11
    animation_frame animation_frame_C429FA, 2; 0x12
    animation_frame animation_frame_C429EF, 2; 0x13
    animation_frame animation_frame_C429E4, 2; 0x14
    animation_frame animation_frame_C429D9, 2; 0x15
    animation_frame animation_frame_C429CE, 2; 0x16
    animation_frame animation_frame_C429C3, 2; 0x17
byte_C42C46:
    db 1
    animation_frame animation_frame_C42B60, 0xFF
sub_C42C4B:
    JSL sub_C4774A
    REP #0x20
    LDA a:addr(level_manager_object.level_representation) ; orig=0x0D24
    AND #0xF
    CMP #8
    BNE .loc_C42C72
    LDA #0x8003
    STA z:0x30,X
    LDA #0x300
    STA z:0x38,X
    LDA #3
    STA a:addr(0x130),X
    LDA #0
    STA a:addr(0x138),X

.loc_C42C72:
    LDA #0xFF90
    STA z:0x14,X
    LDA #0x98
    STA z:0x25,X
    CPX #0xDC0
    BNE .loc_C42C8B
    LDA #0xFF80
    STA z:0x14,X
    LDA #0x58
    STA z:0x25,X

.loc_C42C8B:
    LDA #0x88
    STA z:0x11,X
    LDA #0x160
    STA z:0x36,X
    LDA #0x430
    STA z:0xE,X
    LDA #0x808
    STA z:0x1E,X
    LDA #addr(down_walking_animation)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C42CDF)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C42CDF)
    STA z:2,X
    SEP #0x20
    LDA a:addr(level_manager_object.level_representation) ; orig=0x0D24
    CMP #0x58
    BNE .loc_C42CDF
    LDA #0x28
    STA z:0x25,X
    CPX #0xDC0
    BNE .loc_C42CD1
    LDA #0x18
    STA z:0x25,X

.loc_C42CD1:
    REP #0x20
    LDA #addr(sub_C42D27)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C42D27)
    STA z:2,X
    RTL

.loc_C42CDF:
    REP #0x20
    INC z:0x14,X
    LDA z:0x14,X
    BMI .loc_C42D07
    CMP z:0x25,X
    BNE .loc_C42D07
    LDA #addr(down_walking_animation)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(sub_C42D0C)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C42D0C)
    STA z:2,X

.loc_C42D07:
    JSL advance_animation
    RTL

sub_C42D0C:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #8
    BNE .loc_C42D22
    REP #0x20
    LDA #addr(handle_player_movement_0)
    STA z:0,X
    SEP #0x20
    LDA #bank(handle_player_movement_0)
    STA z:2,X

.loc_C42D22:
    JSL advance_animation_2
    RTL

sub_C42D27:
    REP #0x20
    INC z:0x14,X
    LDA z:0x14,X
    BMI sub_C42C4B.loc_C42D07
    CMP z:0x25,X
    BNE sub_C42C4B.loc_C42D07
    LDA #0x80
    STA z:0x20,X
    LDA #addr(down_walking_animation)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(sub_C42D56)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C42D56)
    STA z:2,X
    BRA sub_C42C4B.loc_C42D07

sub_C42D56:
    REP #0x20
    DEC z:0x20,X
    BNE sub_C42D0C.loc_C42D22
    LDA #0x98
    STA z:0x25,X
    CPX #0xDC0
    BNE .loc_C42D6B
    LDA #0x58
    STA z:0x25,X

.loc_C42D6B:
    REP #0x20
    LDA #addr(sub_C42C4B.loc_C42CDF)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C42C4B.loc_C42CDF)
    STA z:2,X
    BRA sub_C42D0C.loc_C42D22

sub_C42D7A:
    SEP #0x20
    LDA #0xFF
    STA a:addr(4),Y
    LDA #1
    STA a:addr(7),Y
    LDA #0x20
    STA a:addr(0xE),Y
    LDA #0
    STA a:addr(0xF),Y
    REP #0x20
    LDA #addr(handle_player_movement_0)
    STA a:addr(0),Y
    SEP #0x20
    LDA #bank(handle_player_movement_0)
    STA a:addr(2),Y
    RTL

handle_player_movement_0:
i16

    SEP #32
    STZ a:addr(0x12F),X
    REP #0x20
    LDA #4
    STA z:0x40
    LDA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    BIT #0x208
    BEQ .loc_C42DC4
    LDA a:addr(0x13E),X
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:word_C30924,X
    STA z:0x40
    PLX

.loc_C42DC4:
    JSL start_animation_by_direction
    SEP #0x20
    STZ z:0x1A,X
    STZ z:0x1C,X
    STZ z:0x1D,X
    STZ z:0x2F,X
    STZ z:0x3F,X
    STZ z:0x27,X
    LDA #0
    STA z:0x25,X
    LDA #0
    STA z:0x26,X
    JSL sub_C448DD
    JSL sub_C447F2
    JSL sub_C448F5
    REP #0x20
    STZ a:player.poison_state,X
    STZ a:player.poison_state + 2,X
    LDA #0x10
    STA z:0xD9
    SEP #0x20
    LDA z:0x1F,X
    STA z:0x1E,X
    REP #0x20
    LDA #addr(handle_player_movement_1)
    STA z:0,X
    SEP #0x20
    LDA #bank(handle_player_movement_1)
    STA z:2,X

handle_player_movement_1:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C42E17
    JML nullsub_C30015

.loc_C42E17:
    BIT #0x41
    BEQ .loc_C42E1F
    JML sub_C42EC8

.loc_C42E1F:
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #8
    BEQ .loc_C42E2A
    JML sub_C42EF9

.loc_C42E2A:
    JSL clear_playerquare_in_collision_map
    JSL sub_C43BE9
    JSL update_effective_speed
    SEP #0x20
    LDA a:player.poison_state + 1,X
    BIT #high(POISON_AUTO_BOMB_DROP)
    BEQ .loc_C42E43
    JSL sub_C43074

.loc_C42E43:
    JSL sub_C43D4D
    BCC .loc_C42E4C
    JMP a:addr(sub_C42ED2)

.loc_C42E4C:
    SEP #0x20
    LDA z:0x4E
    CMP #1
    BNE .loc_C42E58
    JML sub_C431CF

.loc_C42E58:
    CMP #2
    BNE .loc_C42E60
    JML sub_C43291

.loc_C42E60:
    CMP #4
    BNE .loc_C42E68
    JML sub_C43353

.loc_C42E68:
    JMP a:addr(sub_C43415)
    
sub_C42E6B:
    SEP #0x20
    LDA z:0x4E
    CMP z:0x20,X
    BEQ sub_C42E6B.loc_C42E8E
    STA z:0x20,X
    REP #0x20
    AND #0xF
    ASL A
    PHX
    TAX
    LDA f:player_animation_list,X
    STA z:0x50
    PLX
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
sub_C42E6B.loc_C42E8E:
    JSL mark_playerquare_in_collision_map
    JSL sub_C60C35
    SEP #0x20
    LDA z:0x1F,X
    STA z:0x1E,X
    JSL poison_rendering
    JSL try_infect_poison
    SEP #0x20
    LDA z:0x2F,X
    BEQ .loc_C42EB5
    BIT #0x80
    BEQ .loc_C42EB2
    JML sub_C42F13

.loc_C42EB2:
    JMP a:addr(death_related)

.loc_C42EB5:
    SEP #0x20
    INC a:addr(0x13F),X
    LDA a:addr(0x13F),X
    BIT #0xF
    BNE sub_C42EC8
    LDY #0xC
    JSL play_sound
    ; fallthrough

sub_C42EC8:
    JSL advance_animation
    RTL
    JSL advance_animation_2
    RTL

sub_C42ED2:
    JSL mark_playerquare_in_collision_map
    JSL sub_C60C35
    SEP #0x20
    LDA z:0x1F,X
    STA z:0x1E,X
    JSL poison_rendering
    JSL try_infect_poison
    SEP #0x20
    LDA z:0x2F,X
    BEQ sub_C42EF9
    BIT #0x80
    BEQ .loc_C42EF6
    JML sub_C42F13

.loc_C42EF6:
    JMP a:addr(death_related)

sub_C42EF9:
    SEP #0x20
    STZ z:0xC,X
    LDA z:0xD,X
    PHA
    JSL advance_animation
    SEP #0x20
    PLA
    STA z:0xD,X
    RTL
    db 0x80, 0x60, 0x40, 0x20, 0x10, 0, 1, 2
    db 5

sub_C42F13:
    SEP #0x20
    LDA z:0x1F,X
    STA z:0x1E,X
    REP #0x20
    LDA #addr(hit_by_bomb_animation)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C42F37)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C42F37)
    STA z:2,X

.loc_C42F37:
    JSL advance_animation
    BCC .locret_C42F56
    SEP #0x20
    STZ z:0x2F,X
    LDA #4
    STA z:0x40
    JSL change_direction_and_start_animation
    REP #0x20
    LDA #addr(handle_player_movement_1)
    STA z:0,X
    SEP #0x20
    LDA #bank(handle_player_movement_1)
    STA z:2,X

.locret_C42F56:
    RTL

wrap_related:
i16
    SEP #0x20
    INC a:addr(0x12F),X
    JSL clear_playerquare_in_collision_map
    LDY #9
    JSL play_sound
    SEP #0x20
    LDA z:0x11,X
    AND #0xF0
    ORA #8
    STA z:0x11,X
    LDA z:0x14,X
    AND #0xF0
    ORA #8
    STA z:0x14,X
    REP #0x20
    LDA #addr(enter_wrap_animation)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C42F97)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C42F97)
    STA z:2,X

.loc_C42F97:
    JSL advance_animation
    BCC .locret_C42FAA
    REP #0x20
    LDA #addr(sub_C42FAB)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C42FAB)
    STA z:2,X

.locret_C42FAA:
    RTL

sub_C42FAB:
    SEP #0x20
    LDA #0x40
    STA z:0x10,X
    REP #0x20
    LDA #addr(.loc_C42FBE)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C42FBE)
    STA z:2,X

.loc_C42FBE:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C42FCB
    JML nullsub_C30015

.loc_C42FCB:
    BIT #0x41
    BEQ .loc_C42FD3
    JML .locret_C42FE6

.loc_C42FD3:
    SEP #0x20
    DEC z:0x10,X
    BNE .locret_C42FE6
    REP #0x20
    LDA #addr(sub_C42FE7.loc_C4302A)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C42FE7.loc_C4302A)
    STA z:2,X

.locret_C42FE6:
    RTL

sub_C42FE7:
i16
    REP #0x20
    LDA #addr(unknown_animation)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C43005)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C43005)
    STA z:2,X

.loc_C43005:
    JSL advance_animation
    BCC .locret_C43029
    REP #0x20
    LDA #addr(down_walking_animation)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(handle_player_movement_1)
    STA z:0,X
    SEP #0x20
    LDA #bank(handle_player_movement_1)
    STA z:2,X

.locret_C43029:
    RTL

.loc_C4302A:        ; Dead code
    PHX
    LDX #5
    JSL random
    REP #0x20
    AND #0xFF
    ASL A
    ASL A
    TAX
    LDA f:wrap_positions,X
    STA z:0x40
    LDA f:wrap_positions+2,X
    STA z:0x42
    PLX
    SEP #0x20
    LDA z:0x40
    CMP z:0x11,X
    BNE .loc_C43055
    LDA z:0x42
    CMP z:0x14,X
    BEQ .locret_C43073

.loc_C43055:
    SEP #0x20
    LDA z:0x40
    STA z:0x11,X
    LDA z:0x42
    STA z:0x14,X
    STZ a:addr(0x12F),X
    LDA #4
    STA z:0x20,X
    REP #0x20
    LDA #addr(sub_C42FE7)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C42FE7)
    STA z:2,X

.locret_C43073:
    RTL

sub_C43074:
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300
    AND #3
    BEQ .loc_C43081
    JML .locret_C430B5

.loc_C43081:
    SEP #0x20
    LDA z:0x30,X
    INC A
    CMP z:0x24,X
    BEQ .locret_C430B5
    JSL get_object_square_index
    REP #0x20
    TAY
    LDA a:addr(collision_map),Y
    AND #0xE0
    BNE .locret_C430B5
    STY z:0x56
    JSL drop_bomb
    BCS .locret_C430B5
    SEP #0x20
    INC z:0x25,X
    LDA z:0x33,X
    BEQ .locret_C430B5
    INC z:0x1A,X
    LDA z:0x1A,X
    CMP #1
    BNE .locret_C430B5
    JSL sub_C44911

.locret_C430B5:
    RTL

death_related:
i16
    SEP #0x20
    LDA z:0x1F,X
    STA z:0x1E,X
    LDA #0
    STA z:0x12,X
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #3
    BEQ .loc_C430E4
    DEC a:addr(0x106),X
    BMI .loc_C430D1
    STZ z:0x2F,X
    JMP a:addr(.loc_C43150)

.loc_C430D1:
    SEP #0x20
    LDA a:addr(level_manager_object.level_representation) ; orig=0x0D24
    CMP #0x58
    BNE .loc_C430DE
    JML .loc_C430EB

.loc_C430DE:
    JSL sub_C708CC
    BRA .loc_C430EB

.loc_C430E4:
    LDY #0x1F
    JSL play_sound

.loc_C430EB:
    JSL clear_playerquare_in_collision_map
    JSL sub_C44945
    REP #0x20
    REP #0x20
    LDA #addr(death_animation)
    STA z:0x50
    SEP #0x20
    LDA #bank(death_animation)
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C4311B)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C4311B)
    STA z:2,X
    SEP #0x20
    DEC a:addr(level_manager_object.number_of_ai_players) ; orig=0x0D37
    DEC a:addr(level_manager_object.enemy_count) ; orig=0x0D25

.loc_C4311B:
    JSL advance_animation
    BCC .locret_C4314D
    REP #0x20
    JSL get_object_square_index
    TAY
    LDA a:addr(collision_map),Y
    AND #0x1FF
    BNE .loc_C4313E
    LDA z:0x19,X
    AND #0x1F
    BEQ .loc_C4313E
    STA a:addr(collision_map),Y
    JSL create_bonus_object

.loc_C4313E:
    SEP #0x20
    STZ z:4,X
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #3
    BNE .locret_C4314D
    JSL sub_C41A08

.locret_C4314D:
    RTL
.byte_C4314E:
    db 8, 0xE

.loc_C43150:
    REP #0x20
    LDA #addr(.loc_C43163)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C43163)
    STA z:2,X
    SEP #0x20
    LDA #0x40
    STA z:0x10,X

.loc_C43163:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C43170
    JML nullsub_C30015

.loc_C43170:
    BIT #0x41
    BEQ .loc_C43178
    JML .loc_C4319B

.loc_C43178:
    REP #0x20
    LDA z:0x10,X
    AND #1
    PHX
    TAX
    SEP #0x20
    LDA f:.byte_C4314E,X
    PLX
    STA z:0x1E,X
    DEC z:0x10,X
    BNE .loc_C4319B
    REP #0x20
    LDA #addr(handle_player_movement_1)
    STA z:0,X
    SEP #0x20
    LDA #bank(handle_player_movement_1)
    STA z:2,X

.loc_C4319B:
    JSL advance_animation
    RTL

update_effective_speed:
    REP #0x20
    LDA a:player.poison_state,X
    BIT #POISON_MIN_SPEED
    BNE .min_speed
    BIT #POISON_MAX_SPEED
    BNE .max_speed
    LDA z:player.speedups,X
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:speed_table,X
    STA z:0x40
    PLX
    LDA z:0x40
    STA z:player.effective_speed,X
    RTL

.min_speed:
    LDA #0x60
    STA z:player.effective_speed,X
    RTL

.max_speed:
    LDA #0x400
    STA z:player.effective_speed,X
    RTL

sub_C431CF:
    JSL sub_C4225E
    BCS .loc_C431D9
    JML sub_C42E6B

.loc_C431D9:
    SEP #0x20
    LDA z:0x14,X
    AND #0xF
    CMP #8
    BCS .loc_C4323A
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0xFFF7
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C4320B
    JML sub_C42E6B

.loc_C4320B:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0x10
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0xFFF0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C43233
    JML sub_C42E6B

.loc_C43233:
    JSL sub_C423BD
    JMP a:addr(sub_C42E6B.loc_C42E8E)

.loc_C4323A:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #8
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C43262
    JML sub_C42E6B

.loc_C43262:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0x10
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0x10
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C4328A
    JML sub_C42E6B

.loc_C4328A:
    JSL sub_C423BD
    JMP a:addr(sub_C42E6B.loc_C42E8E)

sub_C43291:
    JSL sub_C4220E
    BCS .loc_C4329B
    JML sub_C42E6B

.loc_C4329B:
    SEP #0x20
    LDA z:0x14,X
    AND #0xF
    CMP #8
    BCS .loc_C432FC
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0xFFF7
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C432CD
    JML sub_C42E6B

.loc_C432CD:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0xFFF0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0xFFF0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C432F5
    JML sub_C42E6B

.loc_C432F5:
    JSL sub_C423BD
    JMP a:addr(sub_C42E6B.loc_C42E8E)

.loc_C432FC:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #8
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C43324
    JML sub_C42E6B

.loc_C43324:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0xFFF0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0x10
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C4334C
    JML sub_C42E6B

.loc_C4334C:
    JSL sub_C423BD
    JMP a:addr(sub_C42E6B.loc_C42E8E)

sub_C43353:
    JSL sub_C421BE
    BCS .loc_C4335D
    JML sub_C42E6B

.loc_C4335D:
    SEP #0x20
    LDA z:0x11,X
    AND #0xF
    CMP #8
    BCS .loc_C433BE
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0xFFF7
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C4338F
    JML sub_C42E6B

.loc_C4338F:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0xFFF0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0x10
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C433B7
    JML sub_C42E6B

.loc_C433B7:
    JSL sub_C42364
    JMP a:addr(sub_C42E6B.loc_C42E8E)

.loc_C433BE:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #8
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C433E6
    JML sub_C42E6B

.loc_C433E6:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0x10
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0x10
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C4340E
    JML sub_C42E6B

.loc_C4340E:
    JSL sub_C42364
    JMP a:addr(sub_C42E6B.loc_C42E8E)

sub_C43415:
    JSL sub_C4216E
    BCS .loc_C4341F
    JML sub_C42E6B

.loc_C4341F:
    SEP #0x20
    LDA z:0x11,X
    AND #0xF
    CMP #8
    BCS .loc_C43480
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0xFFF7
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C43451
    JML sub_C42E6B

.loc_C43451:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0xFFF0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0xFFF0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C43479
    JML sub_C42E6B

.loc_C43479:
    JSL sub_C42364
    JMP a:addr(sub_C42E6B.loc_C42E8E)

.loc_C43480:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #8
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C434A8
    JML sub_C42E6B

.loc_C434A8:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0x10
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0xFFF0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C434D0
    JML sub_C42E6B

.loc_C434D0:
    JSL sub_C42364
    JMP a:addr(sub_C42E6B.loc_C42E8E)
sub_C434D7:
i16
    SEP #0x20
    LDA #low(.loc_C434FC)
    STA z:0xDB
    LDA #high(.loc_C434FC)
    STA z:0xDC
    LDA #bank(.loc_C434FC)
    STA z:0xDD
    LDA #0x80
    STA z:0xD3
    JSL create_object
    REP #0x20
    BCC .loc_C434F5
    JML sub_C436C1.locret_C436FC

.loc_C434F5:
    LDA #0x500
    STA a:addr(0x20),Y
    RTL

.loc_C434FC:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C43509
    JML nullsub_C30015

.loc_C43509:
    BIT #0x41
    BEQ .loc_C43511
    JML .locret_C43552

.loc_C43511:
    REP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #8
    BNE .locret_C43552
    LDA a:addr(number_of_visible_bonuses) ; orig=0x0C91
    CMP #0x20
    BCS .locret_C43552
    DEC z:0x20,X
    BNE .locret_C43552
    LDA #1
    STA z:0x20,X
    JSL sub_C43B6E
    BCS .locret_C43552
    REP #0x20
    LDA #0x280
    STA z:0x20,X
    PHX
    PHY
    LDX #0x10
    JSL random
    ASL A
    TAX
    LDA f:unknown_random_bonus_list,X
    PLY
    PLX
    JSL create_bonus_object
    JSL sub_C539E2
.locret_C43552:
    RTL
unknown_random_bonus_list:
    dw 1     ; 0
    dw 1     ; 1
    dw 2     ; 2
    dw 2     ; 3
    dw 3     ; 4
    dw 4     ; 5
    dw 5     ; 6
    dw 0xA    ; 7
    dw 0xB    ; 8
    dw 0xC    ; 9
    dw 0xD    ; 0xA
    dw 9     ; 0xB
    dw 9     ; 0xC
    dw 9     ; 0xD
    dw 0xF    ; 0xE
    dw 0xF    ; 0xF
sub_C43573:
    STY z:0x40
    SEP #0x20
    LDA #low(.loc_C43599)
    STA z:0xDB
    LDA #high(.loc_C43599)
    STA z:0xDC
    LDA #bank(.loc_C43599)
    STA z:0xDD
    LDA #0x80
    STA z:0xD3
    JSL create_object
    BCC .loc_C43591
    JML sub_C436C1.locret_C436FC

.loc_C43591:
    REP #0x20
    LDA z:0x40
    STA a:addr(0x30),Y
    RTL

.loc_C43599:
    REP #0x20
    LDA #0x88
    STA z:0x11,X
    LDA #0x30
    STA z:0x14,X
    LDA #0xD30
    STA z:0xE,X
    LDA #0xA
    STA z:0x1E,X
    LDA #0x100
    STA z:0x20,X
    LDA a:addr(level_manager_object.level_representation) ; orig=0x0D24
    AND #0xFF
    CMP #0x58
    BNE .loc_C435C4
    LDA #0x380
    STA z:0x20,X

.loc_C435C4:
    LDA #addr(byte_C42B7F)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C43648)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C43648)
    STA z:2,X
    RTL

.loc_C435E1:
    REP #0x20
    LDY z:0x30,X
    LDA a:addr(0x30),Y
    BNE .loc_C435EE
    JML .loc_C436BC

.loc_C435EE:
    LDA #addr(byte_C42BE5)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C4360A)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C4360A)
    STA z:2,X

.loc_C4360A:
    JSL advance_animation
    BCS .loc_C43614
    JML .locret_C436C0

.loc_C43614:
    REP #0x20
    LDA #0x80
    STA z:0x20,X
    LDA a:addr(level_manager_object.level_representation) ; orig=0x0D24
    AND #0xFF
    CMP #0x58
    BNE .loc_C4362B
    LDA #0x300
    STA z:0x20,X

.loc_C4362B:
    LDA #addr(byte_C42B7F)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C43648)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C43648)
    STA z:2,X
    RTL

.loc_C43648:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C43655
    JML nullsub_C30015

.loc_C43655:
    BIT #0x41
    BEQ .loc_C4365D
    JML .loc_C436BC

.loc_C4365D:
    REP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x80
    BEQ .loc_C4366B
    JML .locret_C436C0

.loc_C4366B:
    DEC z:0x20,X
    BEQ .loc_C43673
    JML .loc_C436BC

.loc_C43673:
    LDA #addr(byte_C42B84)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C4368F)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C4368F)
    STA z:2,X

.loc_C4368F:
    JSL advance_animation
    BCC .locret_C436C0
    REP #0x20
    LDY z:0x30,X
    LDA #0
    STA a:addr(0x30),Y
    LDA #addr(byte_C42C46)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C435E1)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C435E1)
    STA z:2,X
    RTL
.loc_C436BC:
    JSL advance_animation

.locret_C436C0:
    RTL

sub_C436C1:
    SEP #0x20
    LDA #low(mecha_bomberman_related.loc_C4375E)
    STA z:0xDB
    LDA #high(mecha_bomberman_related.loc_C4375E)
    STA z:0xDC
    LDA #bank(mecha_bomberman_related.loc_C4375E)
    STA z:0xDD
    LDA #0x80
    STA z:0xD3
    JSL create_object
    BCS .locret_C436FC
    SEP #0x20
    LDA #0xFF
    STA a:addr(level_manager_object.number_of_human_players) ; orig=0x0D36
    REP #0x20
    LDA #0x10
    STA a:addr(0x10),Y
    LDA #0
    STA a:addr(0x30),Y
    LDA #0x400
    STA a:addr(bg1_tilemap+0x22) ; orig=0x0516
    JSL sub_C43573
    JSL sub_C434D7
.locret_C436FC:
    RTL

mecha_bomberman_related:
i16
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C4370A
    JML nullsub_C30015

.loc_C4370A:
    BIT #0x41
    BEQ .loc_C43712
    JML sub_C436C1.locret_C436FC

.loc_C43712:
    SEP #0x20
    LDA a:addr(level_manager_object.enemy_count) ; orig=0x0D25
    BNE sub_C436C1.locret_C436FC
    LDA a:addr(level_manager_object.level_representation) ; orig=0x0D24
    CMP #0x58
    BNE .loc_C43724
    JML .loc_C4384A

.loc_C43724:
    REP #0x20
    LDA #0x80
    STA z:0x10,X
    REP #0x20
    LDA #addr(.loc_C43738)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C43738)
    STA z:2,X

.loc_C43738:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C43745
    JML nullsub_C30015

.loc_C43745:
    BIT #0x41
    BEQ .loc_C4374D
    JML sub_C436C1.locret_C436FC

.loc_C4374D:
    REP #0x20
    DEC z:0x10,X
    BNE sub_C436C1.locret_C436FC
    SEP #0x20
    INC a:addr(level_manager_object.level_representation) ; orig=0x0D24
    INC a:addr(level_manager_object.fade_related_) ; orig=0x0D10
    INC a:addr(current_screen) ; orig=0x00A4

.loc_C4375E:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C4376B
    JML nullsub_C30015

.loc_C4376B:
    BIT #0x41
    BEQ .loc_C43773
    JML sub_C436C1.locret_C436FC

.loc_C43773:
    REP #0x20
    LDA #0x140
    STA z:0x10,X
    LDA #1
    STA z:0x30,X
    LDA a:addr(game_flags) ; orig=0x0314
    ORA #8
    STA a:addr(game_flags) ; orig=0x0314
    LDA a:addr(level_manager_object.level_representation) ; orig=0x0D24
    AND #0xF
    DEC A
    PHX
    TAX
    SEP #0x20
    LDA f:palette_per_mecha_bomber,X
    STA z:0x40
    LDY #0
    LDA #0xC
    JSL palette_related
    SEP #0x20
    LDX #0xD40
    LDA z:0x1F,X
    STA z:0x1E,X
    LDA z:0x20,X
    STA z:0x40
    JSL sub_C43BDE
    SEP #0x20
    LDX #0xD80
    LDA z:0x1F,X
    STA z:0x1E,X
    LDA z:0x20,X
    STA z:0x40
    JSL sub_C43BDE
    PLX
    SEP #0x20
    LDA a:addr(level_manager_object.level_representation) ; orig=0x0D24
    CMP #0x58
    BNE .loc_C43807
    REP #0x20
    LDA #0xF
    STA z:0x10,X
    LDA #0x80
    STA z:0x12,X
    REP #0x20
    LDA #addr(.loc_C437E7)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C437E7)
    STA z:2,X

.loc_C437E7:
    REP #0x20
    DEC z:0x12,X
    BNE .locret_C43849
    LDA #0x18
    STA z:0x12,X
    DEC z:0x10,X
    BMI .loc_C437FA
    JML .loc_C438BA

.loc_C437FA:
    LDA #0x200
    STA z:0x10,X
    JSL sub_C71DCF
    JSL sub_C71E32

.loc_C43807:
    JSL sub_C43B09
    REP #0x20
    LDA #addr(.loc_C43818)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C43818)
    STA z:2,X

.loc_C43818:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C43825
    JML nullsub_C30015

.loc_C43825:
    BIT #0x41
    BEQ .loc_C4382D
    JML .locret_C43849

.loc_C4382D:
    REP #0x20
    DEC z:0x10,X
    BNE .locret_C43849
    LDA a:addr(game_flags) ; orig=0x0314
    AND #0xF7
    STA a:addr(game_flags) ; orig=0x0314
    REP #0x20
    LDA #addr(mecha_bomberman_related)
    STA z:0,X
    SEP #0x20
    LDA #bank(mecha_bomberman_related)
    STA z:2,X

.locret_C43849:
    RTL

.loc_C4384A:
    REP #0x20
    LDA #addr(.loc_C4385E)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C4385E)
    STA z:2,X
    REP #0x20
    LDA #0x180
    STA z:0x10,X

.loc_C4385E:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C4386B
    JML nullsub_C30015

.loc_C4386B:
    BIT #0x41
    BEQ .loc_C43873
    JML .locret_C43849

.loc_C43873:
    REP #0x20
    DEC z:0x10,X
    LDA z:0x10,X
    CMP #0x100
    BEQ .loc_C43893
    CMP #0
    BNE .locret_C43892
    SEP #0x20
    LDA #0x39
    STA a:addr(current_screen) ; orig=0x00A4
    JSL delete_object
    JSL fade_out_music

.locret_C43892:
    RTL

.loc_C43893:
    REP #0x20
    PHX
    LDX #addr(player_1)
    LDA #0
    STA z:0x40
    LDA #1
    STA z:0x42
    JSL add_to_score_if_allowed
    LDX #addr(player_2)
    LDA #0
    STA z:0x40
    LDA #1
    STA z:0x42
    JSL add_to_score_if_allowed
    PLX
    RTL

.loc_C438BA:
    REP #0x20
    LDA z:0x10,X
    BNE .loc_C438F4
    SEP #0x20
    PHX
    LDX #0xD40
    LDA #0x68
    STA z:0x11,X
    LDA #0xB8
    STA z:0x14,X
    LDA z:0x1F,X
    STA z:0x1E,X
    LDA #8
    STA z:0x40
    JSL sub_C43BDE
    SEP #0x20
    LDX #0xD80
    LDA #0xA8
    STA z:0x11,X
    LDA #0xB8
    STA z:0x14,X
    LDA z:0x1F,X
    STA z:0x1E,X
    LDA #8
    STA z:0x40
    JSL sub_C43BDE
    PLX

.loc_C438F4:
    REP #0x20
    LDA z:0x10,X
    AND #1
    ASL A
    ASL A
    ASL A
    ASL A
    PHX
    TAX
    LDY #3
    SEP #0x20
    LDA f:stru_C43984+1,X
    STA z:0x40
    LDA #1
    JSL palette_related
    LDA f:stru_C43984+2,X
    STA z:0x40
    LDA #2
    JSL palette_related
    LDA f:stru_C43984+3,X
    STA z:0x40
    LDA #3
    JSL palette_related
    LDA f:stru_C43984+4,X
    STA z:0x40
    LDA #4
    JSL palette_related
    LDA f:stru_C43984+5,X
    STA z:0x40
    LDA #5
    JSL palette_related
    LDA f:stru_C43984+6,X
    STA z:0x40
    LDA #6
    JSL palette_related
    LDA f:stru_C43984+7,X
    STA z:0x40
    LDA #7
    JSL palette_related
    LDA f:stru_C43984+8,X
    STA z:0x40
    LDA #8
    JSL palette_related
    LDA f:stru_C43984+8+1,X
    STA z:0x40
    LDA #9
    JSL palette_related
    LDA f:stru_C43984+8+5,X
    STA z:0x40
    LDA #0xD
    JSL palette_related
    PLX
    JSL sub_C439C5
    RTL

stru_C43984:
    db HUD_PALETTE, ARENA_PALETTE_1, ARENA_PALETTE_2, ARENA_PALETTE_3; a_palettes
    db BONUS_PALETTE_1, BONUS_PALETTE_2, ARENA_BOMB_PALETTE; a_palettes
    db ARENA_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db MECHA_BOMBER_GOLD_PALETTE, ARENA_GATE_PALETTE, BLACK_PALETTE; b_palettes
    db WHITE_PALETTE ; b_palettes
    db HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE; a_palettes
    db BLACK_PALETTE, BLACK_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db MECHA_BOMBER_GOLD_PALETTE, BLACK_PALETTE, BLACK_PALETTE; b_palettes
    db WHITE_PALETTE ; b_palettes
    db HUD_PALETTE, ARENA_PALETTE_1, BACKGROUND_BLACK_PALETTE; a_palettes
    db CREDITS_SEPIA_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db ARENA_BOMB_PALETTE, ARENA_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db MECHA_BOMBER_GOLD_PALETTE, ARENA_GATE_PALETTE, BLACK_PALETTE; b_palettes
    db WHITE_PALETTE ; b_palettes
    db HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db ARENA_FIRE_PALETTE; a_palettes
    db BLACK_PALETTE, BLACK_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db MECHA_BOMBER_GOLD_PALETTE, BLACK_PALETTE, BLACK_PALETTE; b_palettes
    db WHITE_PALETTE ; b_palettes

-
    RTL
sub_C439C5:
    SEP #0x20
    LDA z:0x10,X
    BIT #1
    BNE -
    BIT #2
    BEQ .loc_C439D5
    JML .loc_C43A6C

.loc_C439D5:
    LDA #0xA
    STA a:addr(bg1_tilemap+2) ; orig=0x04F6
    STA a:addr(bg1_tilemap+4) ; orig=0x04F8
    STA a:addr(bg1_tilemap+6) ; orig=0x04FA
    STA a:addr(bg1_tilemap+8) ; orig=0x04FC
    STA a:addr(bg1_tilemap+0xA) ; orig=0x04FE
    STA a:addr(bg1_tilemap+0x42) ; orig=0x0536
    STA a:addr(bg1_tilemap+0x44) ; orig=0x0538
    STA a:addr(bg1_tilemap+0x46) ; orig=0x053A
    STA a:addr(bg1_tilemap+0x48) ; orig=0x053C
    STA a:addr(bg1_tilemap+0x4A) ; orig=0x053E
    STA a:addr(bg1_tilemap+0x16) ; orig=0x050A
    STA a:addr(bg1_tilemap+0x18) ; orig=0x050C
    STA a:addr(bg1_tilemap+0x1A) ; orig=0x050E
    STA a:addr(bg1_tilemap+0x1C) ; orig=0x0510
    STA a:addr(bg1_tilemap+0x1E) ; orig=0x0512
    STA a:addr(bg1_tilemap+0x56) ; orig=0x054A
    STA a:addr(bg1_tilemap+0x58) ; orig=0x054C
    STA a:addr(bg1_tilemap+0x5A) ; orig=0x054E
    STA a:addr(bg1_tilemap+0x5C) ; orig=0x0550
    STA a:addr(bg1_tilemap+0x5E) ; orig=0x0552
    LDA #0x2E
    STA a:addr(bg1_tilemap) ; orig=0x04F4
    STA a:addr(bg1_tilemap+0x40) ; orig=0x0534
    STA a:addr(bg1_tilemap+0x80) ; orig=0x0574
    STA a:addr(bg1_tilemap+0xC0) ; orig=0x05B4
    STA a:addr(bg1_tilemap+0x100) ; orig=0x05F4
    STA a:addr(bg1_tilemap+0x140) ; orig=0x0634
    STA a:addr(bg1_tilemap+0x180) ; orig=0x0674
    STA a:addr(bg1_tilemap+0x1C0) ; orig=0x06B4
    STA a:addr(bg1_tilemap+0x200) ; orig=0x06F4
    STA a:addr(bg1_tilemap+0x240) ; orig=0x0734
    STA a:addr(bg1_tilemap+0x280) ; orig=0x0774
    STA a:addr(bg1_tilemap+0x2C0) ; orig=0x07B4
    STA a:addr(bg1_tilemap+0x300) ; orig=0x07F4
    STA a:addr(bg1_tilemap+0x20) ; orig=0x0514
    STA a:addr(bg1_tilemap+0x60) ; orig=0x0554
    STA a:addr(bg1_tilemap+0xA0) ; orig=0x0594
    STA a:addr(bg1_tilemap+0xE0) ; orig=0x05D4
    STA a:addr(bg1_tilemap+0x120) ; orig=0x0614
    STA a:addr(bg1_tilemap+0x160) ; orig=0x0654
    STA a:addr(bg1_tilemap+0x1A0) ; orig=0x0694
    STA a:addr(bg1_tilemap+0x1E0) ; orig=0x06D4
    STA a:addr(bg1_tilemap+0x220) ; orig=0x0714
    STA a:addr(bg1_tilemap+0x260) ; orig=0x0754
    STA a:addr(bg1_tilemap+0x2A0) ; orig=0x0794
    STA a:addr(bg1_tilemap+0x2E0) ; orig=0x07D4
    STA a:addr(bg1_tilemap+0x320) ; orig=0x0814
    LDA #0x2A
    STA a:addr(bg1_tilemap+0x82) ; orig=0x0576
    STA a:addr(bg1_tilemap+0x9E) ; orig=0x0592
    RTL

.loc_C43A6C:
    SEP #0x20
    LDA #0x24
    STA a:addr(bg1_tilemap) ; orig=0x04F4
    STA a:addr(bg1_tilemap+0x80) ; orig=0x0574
    STA a:addr(bg1_tilemap+0x100) ; orig=0x05F4
    STA a:addr(bg1_tilemap+0x180) ; orig=0x0674
    STA a:addr(bg1_tilemap+0x200) ; orig=0x06F4
    STA a:addr(bg1_tilemap+0x280) ; orig=0x0774
    STA a:addr(bg1_tilemap+0x300) ; orig=0x07F4
    STA a:addr(bg1_tilemap+0x20) ; orig=0x0514
    STA a:addr(bg1_tilemap+0xA0) ; orig=0x0594
    STA a:addr(bg1_tilemap+0x120) ; orig=0x0614
    STA a:addr(bg1_tilemap+0x1A0) ; orig=0x0694
    STA a:addr(bg1_tilemap+0x220) ; orig=0x0714
    STA a:addr(bg1_tilemap+0x2A0) ; orig=0x0794
    STA a:addr(bg1_tilemap+0x320) ; orig=0x0814
    LDA #0x26
    STA a:addr(bg1_tilemap+0x40) ; orig=0x0534
    STA a:addr(bg1_tilemap+0xC0) ; orig=0x05B4
    STA a:addr(bg1_tilemap+0x140) ; orig=0x0634
    STA a:addr(bg1_tilemap+0x1C0) ; orig=0x06B4
    STA a:addr(bg1_tilemap+0x240) ; orig=0x0734
    STA a:addr(bg1_tilemap+0x2C0) ; orig=0x07B4
    STA a:addr(bg1_tilemap+0x60) ; orig=0x0554
    STA a:addr(bg1_tilemap+0xE0) ; orig=0x05D4
    STA a:addr(bg1_tilemap+0x160) ; orig=0x0654
    STA a:addr(bg1_tilemap+0x1E0) ; orig=0x06D4
    STA a:addr(bg1_tilemap+0x260) ; orig=0x0754
    STA a:addr(bg1_tilemap+0x2E0) ; orig=0x07D4
    LDA #0x22
    STA a:addr(bg1_tilemap+2) ; orig=0x04F6
    STA a:addr(bg1_tilemap+6) ; orig=0x04FA
    STA a:addr(bg1_tilemap+0xA) ; orig=0x04FE
    STA a:addr(bg1_tilemap+0x44) ; orig=0x0538
    STA a:addr(bg1_tilemap+0x48) ; orig=0x053C
    STA a:addr(bg1_tilemap+0x16) ; orig=0x050A
    STA a:addr(bg1_tilemap+0x1A) ; orig=0x050E
    STA a:addr(bg1_tilemap+0x1E) ; orig=0x0512
    STA a:addr(bg1_tilemap+0x58) ; orig=0x054C
    STA a:addr(bg1_tilemap+0x5C) ; orig=0x0550
    LDA #0x20
    STA a:addr(bg1_tilemap+4) ; orig=0x04F8
    STA a:addr(bg1_tilemap+8) ; orig=0x04FC
    STA a:addr(bg1_tilemap+0x42) ; orig=0x0536
    STA a:addr(bg1_tilemap+0x46) ; orig=0x053A
    STA a:addr(bg1_tilemap+0x4A) ; orig=0x053E
    STA a:addr(bg1_tilemap+0x18) ; orig=0x050C
    STA a:addr(bg1_tilemap+0x1C) ; orig=0x0510
    STA a:addr(bg1_tilemap+0x56) ; orig=0x054A
    STA a:addr(bg1_tilemap+0x5A) ; orig=0x054E
    STA a:addr(bg1_tilemap+0x5E) ; orig=0x0552
    LDA #0x28
    STA a:addr(bg1_tilemap+0x82) ; orig=0x0576
    STA a:addr(bg1_tilemap+0x9E) ; orig=0x0592
    RTL

sub_C43B09:
i16
    SEP #0x20
    PHX
    LDX #addr(player_2)
    LDA #bank(byte_C43D2C)
    STA z:0x55
    LDA #bank(hits_per_mecha_bomber)
    STA z:0x52
    LDA a:addr(level_manager_object.gameover_related) ; orig=0x0D32
    STA z:0x40
    LDA a:addr(level_manager_object.gameover_related) ; orig=0x0D32
    BNE .loc_C43B23
    INC z:0x40

.loc_C43B23:
    REP #0x20
    TXA
    CLC
    ADC #0x40
    TAX
    LDA a:addr(level_manager_object.level_representation) ; orig=0x0D24
    AND #0xF
    DEC A
    ADC #addr(hits_per_mecha_bomber)
    STA z:0x50
    LDA a:addr(level_manager_object.level_representation) ; orig=0x0D24
    AND #0xF
    DEC A
    ADC #addr(byte_C43D2C)
    STA z:0x53
    REP #0x20
    LDA #addr(sub_C42C4B)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C42C4B)
    STA z:2,X
    LDA f:[z:0x50]
    STA a:addr(0x106),X
    LDA f:[z:0x53]
    STA z:0x3D,X
    LDA #0
    STA z:0x19,X
    LDA #0xFF
    STA z:4,X
    LDA #1
    STA z:7,X
    INC a:addr(level_manager_object.enemy_count) ; orig=0x0D25
    DEC z:0x40
    BNE .loc_C43B23
    PLX
    RTL

sub_C43B6E:
    PHX
    JSL generate_random_position
    PLX
    REP #0x20
    LDA z:0x40
    AND #0xFF
    ORA #8
    STA z:0x11,X
    LDA z:0x42
    AND #0xFF
    ORA #8
    STA z:0x14,X
    LDA #0xFFFF
    STA z:0x42
    JSL sub_C6153E
    BNE .loc_C43BA1
    REP #0x20
    PHY
    JSL sub_C43BA3
    PLY
    BCS .loc_C43BA1
    CLC
    RTL

.loc_C43BA1:
    SEC
    RTL

sub_C43BA3:
i16
    REP #0x20
    LDY #0xD40

.loc_C43BA8:
    SEP #0x20
    LDA a:addr(4),Y
    BEQ .loc_C43BCF
    LDA a:addr(0x11),Y
    SEC
    SBC z:0x11,X
    BCS .loc_C43BBA
    EOR #0xFF
    INC A

.loc_C43BBA:
    CMP #8
    BCS .loc_C43BCF
    LDA a:addr(0x14),Y
    SEC
    SBC z:0x14,X
    BCS .loc_C43BC9
    EOR #0xFF
    INC A

.loc_C43BC9:
    CMP #8
    BCS .loc_C43BCF
    SEC
    RTL

.loc_C43BCF:
    REP #0x20
    TYA
    CLC
    ADC #0x40
    TAY
    CMP #addr(player_4 + player.sizeof)
    BNE .loc_C43BA8
    CLC
    RTL

sub_C43BDE:
    SEP #0x20
    LDA z:0x2F,X
    BNE .locret_C43BE8
    JSL start_animation_by_direction

.locret_C43BE8:
    RTL

sub_C43BE9:
    REP #0x20
    LDA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    BIT #0x1000
    BEQ .locret_C43C2B
    JSL get_object_square_index
    TAY
    REP #0x20
    LDA #0x40
    STA z:0x3E,X
    LDA a:addr(bg1_tilemap),Y
    STA z:0xDB
    AND #0x3FF
    CMP #0x48
    BNE .loc_C43C10
    JML .loc_C43C2C

.loc_C43C10:
    CMP #0x4A
    BNE .loc_C43C19
    JML .loc_C43CEC

.loc_C43C19:
    CMP #0x4C
    BNE .loc_C43C22
    JML .loc_C43C6C

.loc_C43C22:
    CMP #0x4E
    BNE .locret_C43C2B
    JML .loc_C43CAC

.locret_C43C2B:
    RTL

.loc_C43C2C:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0xFFF7
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C43C5C
    LDA z:0x14,X
    AND #0xF
    CMP #8
    BEQ .locret_C43C6B
    BCC .locret_C43C6B

.loc_C43C5C:
    LDA a:addr(bg1_tilemap+0x20),Y
    CMP z:0xDB
    BNE .locret_C43C6B
    JSL sub_C422F1
    JSL sub_C4239D

.locret_C43C6B:
    RTL

.loc_C43C6C:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #8
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C43C9C
    LDA z:0x14,X
    AND #0xF
    CMP #8
    BEQ .locret_C43CAB
    BCS .locret_C43CAB

.loc_C43C9C:
    LDA a:addr(bg1_tilemap+0x20),Y
    CMP z:0xDB
    BNE .locret_C43CAB
    JSL sub_C422F1
    JSL sub_C423CE

.locret_C43CAB:
    RTL

.loc_C43CAC:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #0xFFF7
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C43CDC
    LDA z:0x11,X
    AND #0xF
    CMP #8
    BEQ .locret_C43CEB
    BCC .locret_C43CEB

.loc_C43CDC:
    LDA a:addr(bg1_tilemap+0x20),Y
    CMP z:0xDB
    BNE .locret_C43CEB
    JSL sub_C4230B
    JSL sub_C42375

.locret_C43CEB:
    RTL

.loc_C43CEC:
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #8
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0
    STA z:0x14,X
    JSL sub_C60B6D
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    BCC .loc_C43D1C
    LDA z:0x11,X
    AND #0xF
    CMP #8
    BEQ .locret_C43D2B
    BCS .locret_C43D2B

.loc_C43D1C:
    LDA a:addr(bg1_tilemap+0x20),Y
    CMP z:0xDB
    BNE .locret_C43D2B
    JSL sub_C4230B
    JSL sub_C42325

.locret_C43D2B:
    RTL

byte_C43D2C:
    db 0, 1, 1, 2, 2, 3, 3, 4
hits_per_mecha_bomber:
    db 0, 0, 0, 0, 1, 1, 1, 4
palette_per_mecha_bomber:
    db MECHA_BOMBER_WHITE_PALETTE, MECHA_BOMBER_BLACK_PALETTE, MECHA_BOMBER_RED_PALETTE, MECHA_BOMBER_BLUE_PALETTE, MECHA_BOMBER_GREEN_PALETTE, MECHA_BOMBER_MAGENTA_PALETTE, MECHA_BOMBER_PURPLE_PALETTE, MECHA_BOMBER_GOLD_PALETTE
    db 1, 4, 1, 0xC, 2
    db 0xD, 2
    REP #0x20
sub_C43D4D:
    JSL get_object_square_index
    STA z:0x50
    TAY
    SEP #0x20
    LDA z:0x26,X
    CMP #9
    BCC .loc_C43D60
    JML sub_C43EC5

.loc_C43D60:
    CMP #7
    BCS sub_C43DA2
    STZ z:0x1B,X
    LDA a:addr(0x917),Y
    BIT #8
    BEQ .loc_C43D7C
    DEC a:addr(0x138),X
    BNE .loc_C43D8E
    LDA #2
    STA z:0x26,X
    JSL sub_C448F5
    BRA sub_C43DA2

.loc_C43D7C:
    LDA z:7,X
    BIT #0x80
    BNE .loc_C43D8E
    LDA z:0x1C,X
    BEQ .loc_C43D8E
    DEC z:0x1C,X
    BNE .loc_C43D8E
    LDA #0x80
    STA z:0x27,X

.loc_C43D8E:
    SEP #0x20
    LDA z:0x26,X
    CMP #4
    BNE .loc_C43D9A
    JML sub_C43E75

.loc_C43D9A:
    CMP #6
    BNE sub_C43DA2
    JML sub_C43E75

sub_C43DA2:
    JSL random2
    SEP #0x20
    AND #0x80
    STA z:0xD5
    JSL sub_C447CF
    SEP #0x20
    LDA z:0x20,X
    STA z:0x4A
    LDA #4
    STA z:0x49
    LDA #0xFF
    STA z:0x48
    LDA #0
    STA z:0x4E
    LDA #0
    STA z:0x4F
    LDA #0
    STA z:0x4D
    LDA #0
    STA z:0xD7
    LDA #0
    STA z:0xD8
    LDA #0
    STA z:0x17,X
    JSL get_object_square_index
    STA z:0x50
    TAY
    SEP #0x20
    LDA z:0x26,X
    BNE .loc_C43DEF
    STZ z:0x1B,X
    CPY z:0x53
    BNE .loc_C43DEF
    LDA #6
    STA z:0x26,X
    SEC
    RTL

.loc_C43DEF:
    SEP #0x20
    LDA z:0x4A
    ASL A
    STA z:0x4C
    LDA #bank(off_C441D0)
    STA z:0x61
    REP #0x20
    LDA z:0x26,X
    AND #0xFF
    ASL A
    CLC
    ADC #addr(off_C441D0)
    STA z:0x5F
    LDA f:[z:0x5F]
    STA z:0x5F
    JSL call_function_at_5f
    SEP #0x20
    LDA z:0xD5
    BNE .loc_C43E24
    LSR z:0x4A
    BCC .loc_C43E1E
    LDA #8
    STA z:0x4A

.loc_C43E1E:
    DEC z:0x49
    BNE .loc_C43DEF
    BRA .loc_C43E34

.loc_C43E24:
    ASL z:0x4A
    LDA z:0x4A
    CMP #0x10
    BNE .loc_C43E30
    LDA #1
    STA z:0x4A

.loc_C43E30:
    DEC z:0x49
    BNE .loc_C43DEF

.loc_C43E34:
    LDA z:0x17,X
    BNE .loc_C43E3A
    STZ z:0x16,X

.loc_C43E3A:
    LDA #bank(off_C441E2)
    STA z:0x61
    REP #0x20
    LDA z:0x26,X
    AND #0xFF
    ASL A
    CLC
    ADC #addr(off_C441E2)
    STA z:0x5F
    LDA f:[z:0x5F]
    STA z:0x5F
    JSL call_function_at_5f
    BCS .locret_C43E72
    REP #0x20
    LDA z:0x4E
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA z:0x50
    CLC
    ADC f:byte_C44246,X
    TAY
    PLX
    LDA a:addr(collision_map),Y
    BIT #0x100
    BEQ .loc_C43E73
    SEC

.locret_C43E72:
    RTL

.loc_C43E73:
    CLC
    RTL
    
sub_C43E75:
    SEP #0x20
    LDA #low(.loc_C43E99)
    STA z:0xDB
    LDA #high(.loc_C43E99)
    STA z:0xDC
    LDA #bank(.loc_C43E99)
    STA z:0xDD
    LDA #0x80
    STA z:0xD3
    JSL create_object
    REP #0x20
    BCC .loc_C43E93
    JML .loc_C43E97

.loc_C43E93:
    TXA
    STA a:addr(0x30),Y

.loc_C43E97:
    SEC
    RTL

.loc_C43E99:
    REP #0x20
    PHX
    LDA z:0x30,X
    TAX
    JSL get_object_square_index
    STA z:0x50
    JSL sub_C4453B
    BCC .loc_C43EAF
    JML .loc_C43EB9

.loc_C43EAF:
    JSL sub_C43DA2
    PLX
    JSL delete_object
    RTL

.loc_C43EB9:
    SEP #0x20
    LDA #3
    STA z:0x26,X
    PLX
    JSL delete_object
    RTL

sub_C43EC5:
    SEP #0x20
    LDA z:0x26,X
    CMP #0xB
    BEQ .loc_C43F0C
    LDA a:addr(collision_map),Y
    BIT #0x20
    BNE .loc_C43F06
    LDA z:0x26,X
    CMP #0xA
    BEQ .loc_C43EF2
    LDA z:0x20,X
    BIT #3
    BNE .loc_C43EE4
    EOR #0xC
    BRA .loc_C43EE6

.loc_C43EE4:
    EOR #3

.loc_C43EE6:
    STA z:0x20,X
    LDA #2
    STA z:0x26,X
    JSL sub_C41D0B
    SEC
    RTL

.loc_C43EF2:
    LDA z:0x20,X
    BIT #3
    BNE .loc_C43EFC
    EOR #0xC
    BRA .loc_C43EFE

.loc_C43EFC:
    EOR #3

.loc_C43EFE:
    STA z:0x4E
    LDA #0xB
    STA z:0x26,X
    CLC
    RTL

.loc_C43F06:
    LDA z:0x20,X
    STA z:0x4E
    CLC
    RTL

.loc_C43F0C:
    REP #0x20
    LDA z:0x20,X
    AND #0xFF
    ASL A
    PHX
    TAX
    TYA
    CLC
    ADC f:byte_C44246,X
    TAY
    PLX
    SEP #0x20
    LDA a:addr(collision_map),Y
    BIT #0x20
    BEQ .loc_C43F2B
    CMP #0x3F
    BNE .loc_C43F06

.loc_C43F2B:
    LDA #2
    STA z:0x26,X
    SEC
    RTL

sub_C43F31:
    SEP #0x20
    LDA z:0x3D,X
    CMP #1
    BCC .loc_C43F43
    LDA z:0xD8
    BEQ .loc_C43F43
    LDA #5
    STA z:0x26,X
    SEC
    RTL

.loc_C43F43:
    LDA z:0x4E
    BEQ .loc_C43F6E
    BIT z:0x4F
    BNE .loc_C43F6C
    CPX #addr(player_4 + player.sizeof)
    BCS .loc_C43F5B
    LDA a:player.poison_state + 2,X
    BIT #POISON_MIN_FIRE_SINGLE_BOMB >> 16
    BEQ .loc_C43F5B
    LDA #0
    BRA .loc_C43F63

.loc_C43F5B:
    LDA z:player.fireups,X
    BIT #0x80 ; Max fire bit
    BEQ .loc_C43F63
    LDA #9

.loc_C43F63:
    INC A
    CMP z:0x48
    BCC .loc_C43F6C
    LDA #6
    STA z:0x26,X

.loc_C43F6C:
    CLC
    RTL

.loc_C43F6E:
    LDA #1
    STA z:0x26,X
    SEC
    RTL

sub_C43F74:
    SEP #0x20
    LDA z:0x4E
    BEQ .loc_C43F84
    LDA z:0x48
    BNE .loc_C43F8A
    LDA #4
    STA z:0x26,X
    SEC
    RTL

.loc_C43F84:
    LDA #0
    STA z:0x26,X
    SEC
    RTL

.loc_C43F8A:
    CLC
    RTL

sub_C43F8C:
    SEP #0x20
    LDA #bank(up_walking_animation)
    STA z:0x52
    LDA z:0x4E
    BEQ .loc_C43FC3
    BIT #3
    BNE .loc_C43F9E
    EOR #0xC
    BRA .loc_C43FA0

.loc_C43F9E:
    EOR #3

.loc_C43FA0:
    STA z:0x20,X
    REP #0x20
    AND #0xF
    ASL A
    PHX
    TAX
    LDA f:player_animation_list,X
    STA z:0x50
    PLX
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #9
    STA z:0x26,X
    SEC
    RTL

.loc_C43FC3:
    LDA #2
    STA z:0x26,X
    SEC
    RTL

sub_C43FC9:
    SEP #0x20
    LDA #bank(up_walking_animation)
    STA z:0x52
    LDA z:0x4E
    BEQ .loc_C44000
    BIT #3
    BNE .loc_C43FDB
    EOR #0xC
    BRA .loc_C43FDD

.loc_C43FDB:
    EOR #3

.loc_C43FDD:
    STA z:0x20,X
    REP #0x20
    AND #0xF
    ASL A
    PHX
    TAX
    LDA f:player_animation_list,X
    STA z:0x50
    PLX
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #0xA
    STA z:0x26,X
    SEC
    RTL

.loc_C44000:
    SEP #0x20
    LDA #2
    STA z:0x26,X
    SEC
    RTL

sub_C44008:
    REP #0x20
    LDY z:0x50
    LDA a:addr(collision_map),Y
    BIT #0x800
    BNE .loc_C4401F
    JSL sub_C44047
    BCS .loc_C4401F
    JSL sub_C4402B
    RTL

.loc_C4401F:
    SEP #0x20
    LDA z:0x4E
    BNE .loc_C44029
    LDA z:0x18,X
    STA z:0x4E

.loc_C44029:
    CLC
    RTL

sub_C4402B:
    SEP #0x20
    LDA #0
    STA z:0x26,X
    LDA z:0x3D,X
    BEQ .loc_C4403F
    DEC z:0x22,X
    LDA z:0x22,X
    BNE .loc_C44045
    LDA #5
    STA z:0x26,X

.loc_C4403F:
    JSL sub_C448DD
    SEP #0x20

.loc_C44045:
    SEC
    RTL

sub_C44047:
    REP #0x20
    LDA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    BIT #0x1000
    BEQ .loc_C4406B
    LDA a:addr(bg1_tilemap),Y
    AND #0x3FF
    CMP #0x48
    BEQ .loc_C4406D
    CMP #0x4A
    BEQ .loc_C4406D
    CMP #0x4C
    BEQ .loc_C4406D
    CMP #0x4E
    BEQ .loc_C4406D

.loc_C4406B:
    CLC
    RTL

.loc_C4406D:
    LDA a:addr(0x8D6),Y
    ORA a:addr(0x918),Y
    ORA a:addr(0x956),Y
    ORA a:addr(0x914),Y
    BIT #0x800
    BNE .loc_C44080
    CLC
    RTL

.loc_C44080:
    SEC
    RTL

sub_C44082:
    SEP #0x20
    LDA z:0x4E
    BEQ .loc_C4408E
    LDA #0
    STA z:0x26,X
    CLC
    RTL

.loc_C4408E:
    LDA #4
    STA z:0x26,X
    SEC
    RTL

sub_C44094:
    SEP #0x20
    LDA z:0x4E
    BEQ .loc_C440B8
    BIT z:0x21,X
    BNE .loc_C440E7
    JSL sub_C44519
    SEP #0x20
    LDA #2
    STA z:0x26,X
    LDA z:0x20,X
    BIT #3
    BNE .loc_C440B2
    EOR #0xC
    BRA .loc_C440B4

.loc_C440B2:
    EOR #3

.loc_C440B4:
    STA z:0x18,X
    SEC
    RTL

.loc_C440B8:
    LDA z:0x20,X
    BIT #3
    BNE .loc_C440C2
    EOR #0xC
    BRA .loc_C440C4

.loc_C440C2:
    EOR #3

.loc_C440C4:
    STA z:0x4E
    REP #0x20
    PHX
    AND #0xFF
    ASL A
    TAX
    LDA z:0x50
    CLC
    ADC f:byte_C44246,X
    TAY
    PLX
    LDA a:addr(collision_map),Y
    BIT #0x1E0
    SEP #0x20
    BNE .loc_C440E7
    LDA z:0x24,X
    BNE .loc_C440E7
    BRA sub_C44094

.loc_C440E7:
    JSL sub_C446AB
    LDA #3
    STA z:0x26,X
    SEC
    RTL

sub_C440F1:
    SEP #0x20
    LDA z:0x20,X
    BIT #3
    BNE .loc_C440FD
    EOR #0xC
    BRA .loc_C440FF

.loc_C440FD:
    EOR #3

.loc_C440FF:
    STA z:0x18,X
    SEC
    RTL

sub_C44103:
    SEP #0x20
    LDA z:0x4E
    BEQ .loc_C4416A
    BIT z:0x21,X
    BEQ .loc_C44111
    JML .loc_C4419A

.loc_C44111:
    JSL sub_C44519
    JSL sub_C441A4
    SEP #0x20
    BCC sub_C440F1
    LDA #2
    STA z:0x26,X
    LDA z:0x20,X
    BIT #3
    BNE .loc_C4412B
    EOR #0xC
    BRA .loc_C4412D

.loc_C4412B:
    EOR #3

.loc_C4412D:
    STA z:0x18,X
    LDA z:0x3D,X
    CMP #3
    BCC .loc_C44164
    REP #0x20
    LDA #addr(.byte_C44166)
    STA z:0xDB
    SEP #0x20
    LDA #bank(.byte_C44166)
    STA z:0xDD
    SEP #0x20
    LDA #0
    XBA

.loc_C44147:
    LDA z:0x25,X
    AND #3
    TAY
    LDA f:[z:0xDB],Y
    CMP z:0x20,X
    BNE .loc_C44156
    INC z:0x25,X
    BRA .loc_C44147

.loc_C44156:
    LDA f:[z:0xDB],Y
    STA z:0x40
    LDA z:0x1B,X
    BIT z:0x40
    BEQ .loc_C44164
    LDA f:[z:0xDB],Y
    STA z:0x4E

.loc_C44164:
    CLC
    RTL
    
.byte_C44166:
    db 8, 1, 4, 2

.loc_C4416A:
    LDA z:0x20,X
    BIT #3
    BNE .loc_C44174
    EOR #0xC
    BRA .loc_C44176

.loc_C44174:
    EOR #3

.loc_C44176:
    STA z:0x4E
    REP #0x20
    PHX
    AND #0xFF
    ASL A
    TAX
    LDA z:0x50
    CLC
    ADC f:byte_C44246,X
    TAY
    PLX
    LDA a:addr(collision_map),Y
    BIT #0x1E0
    SEP #0x20
    BNE .loc_C4419A
    LDA z:0x24,X
    BNE .loc_C4419A
    JMP a:addr(sub_C44103)

.loc_C4419A:
    JSL sub_C446AB
    LDA #3
    STA z:0x26,X
    SEC
    RTL

sub_C441A4:
    SEP #0x20
    LDA z:0x39,X
    AND #3
    BEQ .loc_C441C0
    CMP #3
    BNE .loc_C441B9
    JSL random2
    SEP #0x20
    AND #1
    INC A

.loc_C441B9:
    CLC
    ADC #6
    STA z:0x26,X
    CLC
    RTL

.loc_C441C0:
    SEC
    RTL

sub_C441C2:
    SEP #0x20
    LDA z:0x4E
    BEQ .loc_C441CA
    CLC
    RTL

.loc_C441CA:
    LDA #0
    STA z:0x26,X
    SEC
    RTL

off_C441D0:
    da sub_C442B8, sub_C44325, sub_C443C3, sub_C442B8, sub_C443C3, sub_C4437A, sub_C443C3, sub_C4426A, sub_C441F8
off_C441E2:
    da sub_C43F31, sub_C43F74, sub_C44008, sub_C44082, sub_C44094, sub_C441C2, sub_C44103, sub_C43FC9, sub_C43F8C
call_function_at_5f:
    JML [0x5F]
    RTI

sub_C441F8:
    SEP #0x20
    LDA z:0x4A
    BIT #3
    BNE .loc_C44204
    EOR #0xC
    BRA .loc_C44206

.loc_C44204:
    EOR #3

.loc_C44206:
    STA z:0x40
    LDA z:0x1B,X
    BIT z:0x40
    BEQ .locret_C44245
    REP #0x20
    STZ z:0x44
    LDA z:0x50
    PHX
    LDX z:0x4C
    CLC
    ADC f:byte_C44246+0x12,X
    TAY
    PLX

.loc_C4421E:
    CPY z:0x53
    BEQ .loc_C44237
    TYA
    PHX
    LDX z:0x4C
    CLC
    ADC f:byte_C44246,X
    TAY
    PLX
    INC z:0x44
    LDA z:0x44
    CMP #8
    BCC .loc_C4421E
    RTL

.loc_C44237:
    SEP #0x20
    LDA z:0x44
    CMP z:0x48
    BCS .locret_C44245
    STA z:0x48
    LDA z:0x4A
    STA z:0x4E

.locret_C44245:
    RTL

byte_C44246:
    db 0, 0, 2, 0 ; 0
    db 0xFE, 0xFF, 0, 0 ; 4
    db 0x40, 0, 0, 0 ; 8
    db 0, 0, 0, 0 ; 0xC
    db 0xC0, 0xFF, 0, 0 ; 0x10
    db 4, 0, 0xFC, 0xFF ; 0x14
    db 0, 0, 0x80, 0 ; 0x18
    db 0, 0, 0, 0 ; 0x1C
    db 0, 0, 0x80, 0xFF ; 0x20
sub_C4426A:
    SEP #0x20
    LDA z:0x4A
    BIT #3
    BNE .loc_C44276
    EOR #0xC
    BRA .loc_C44278

.loc_C44276:
    EOR #3

.loc_C44278:
    STA z:0x40
    LDA z:0x1B,X
    BIT z:0x40
    BEQ .locret_C442B7
    REP #0x20
    STZ z:0x44
    LDA z:0x50
    PHX
    LDX z:0x4C
    CLC
    ADC f:byte_C44246+0x12,X
    TAY
    PLX

.loc_C44290:
    CPY z:0x53
    BEQ .loc_C442A9
    TYA
    PHX
    LDX z:0x4C
    CLC
    ADC f:byte_C44246,X
    TAY
    PLX
    INC z:0x44
    LDA z:0x44
    CMP #0xA
    BCC .loc_C44290
    RTL

.loc_C442A9:
    SEP #0x20
    LDA z:0x44
    CMP z:0x48
    BCS .locret_C442B7
    STA z:0x48
    LDA z:0x4A
    STA z:0x4E

.locret_C442B7:
    RTL

sub_C442B8:
    REP #0x20
    LDA #0x1E0
    STA z:0x42
    LDA z:0x3D,X
    CMP #2
    BCC .loc_C442CB
    LDA #0x9E0
    STA z:0x42

.loc_C442CB:
    LDY z:0x50
    STZ z:0x44

.loc_C442CF:
    JSL sub_C44440
    BCS .locret_C4430D
    REP #0x20
    CPY z:0x53
    BEQ .loc_C442FB
    BIT #0x200
    BEQ .loc_C442E2
    INC z:0xD8

.loc_C442E2:
    JSL sub_C444A2
    REP #0x20
    CPY z:0x53
    BEQ .loc_C442FB
    BIT #0x200
    BEQ .loc_C442F3
    INC z:0xD8

.loc_C442F3:
    LDA z:0x44
    CMP #0x16
    BCC .loc_C442CF
    RTL

.loc_C442FB:
    SEP #0x20
    LDA z:0x44
    BEQ .locret_C4430D
    CMP z:0x48
    BEQ .loc_C4430E
    BCS .locret_C4430D
    STA z:0x48
    LDA z:0x4A
    STA z:0x4E

.locret_C4430D:
    RTL

.loc_C4430E:
    INC z:0x17,X
    LDA z:0x16,X
    BNE .locret_C4430D
    INC z:0x16,X
    LDA z:0x25,X
    AND #1
    BNE .locret_C4430D
    LDA z:0x44
    STA z:0x48
    LDA z:0x4A
    STA z:0x4E
    RTL

sub_C44325:
    REP #0x20
    LDA #0x9E0
    STA z:0x42
    STZ z:0x44
    LDY z:0x50

.loc_C44330:
    JSL sub_C44440
    BCS .loc_C4434A
    JSL sub_C444A2
    SEP #0x20
    BIT #0x40
    BNE .loc_C44350
    REP #0x20
    LDA z:0x44
    CMP #0x16
    BCC .loc_C44330
    RTL

.loc_C4434A:
    SEP #0x20
    BIT #0x40
    BEQ .locret_C44379

.loc_C44350:
    LDA z:0x3D,X
    CMP #4
    BCC .loc_C4436D
    AND #0x1F
    BNE .loc_C4436D
    LDA z:0xD7
    BNE .locret_C44379
    INC z:0xD7
    LDA z:0x44
    CMP z:0x48
    BCS .locret_C44379
    STA z:0x48
    LDA z:0x4A
    STA z:0x4E
    RTL

.loc_C4436D:
    LDA z:0x44
    CMP z:0x48
    BCS .locret_C44379
    STA z:0x48
    LDA z:0x4A
    STA z:0x4E

.locret_C44379:
    RTL

sub_C4437A:
    REP #0x20
    LDA #0xBE0
    STA z:0x42
    STZ z:0x44
    LDY z:0x50

.loc_C44385:
    JSL sub_C44440
    BCS .loc_C4439F
    JSL sub_C444A2
    REP #0x20
    BIT #0x200
    BNE .loc_C443A6
    SEP #0x20
    LDA z:0x44
    CMP #0x16
    BCC .loc_C44385
    RTL

.loc_C4439F:
    REP #0x20
    BIT #0x200
    BEQ .locret_C443C2

.loc_C443A6:
    STA z:0x40
    SEP #0x20
    LDA z:0x3D,X
    CMP #3
    BCC .loc_C443B6
    LDA z:0x41
    BIT #8
    BNE .locret_C443C2

.loc_C443B6:
    LDA z:0x44
    CMP z:0x48
    BCS .locret_C443C2
    STA z:0x48
    LDA z:0x4A
    STA z:0x4E

.locret_C443C2:
    RTL

sub_C443C3:
    REP #0x20
    LDA #0x1E0
    STA z:0x42
    LDY z:0x50
    STZ z:0x44

.loc_C443CE:
    JSL sub_C44440
    BCS .locret_C44405
    REP #0x20
    BIT #0x800
    BEQ .loc_C443F1
    JSL sub_C444A2
    REP #0x20
    LDA a:addr(collision_map),Y
    BIT #0x800
    BEQ .loc_C443F1
    LDA z:0x44
    CMP #0x16
    BCC .loc_C443CE
    RTL

.loc_C443F1:
    SEP #0x20
    LDA z:0x1B,X
    ORA z:0x4A
    STA z:0x1B,X
    LDA z:0x44
    CMP z:0x48
    BCS .locret_C44405
    STA z:0x48
    LDA z:0x4A
    STA z:0x4E

.locret_C44405:
    RTL

sub_C44406:
    REP #0x20
    LDA #0x1E0
    STA z:0x42
    LDY z:0x50
    STZ z:0x44

.loc_C44411:
    JSL sub_C44440
    BCS .locret_C4443F
    REP #0x20
    BIT #0x800
    BEQ .loc_C44431
    JSL sub_C444A2
    REP #0x20
    BIT #0x800
    BEQ .loc_C44431
    LDA z:0x44
    CMP #0x16
    BCC .loc_C44411
    RTL

.loc_C44431:
    SEP #0x20
    LDA z:0x44
    CMP z:0x48
    BCS .locret_C4443F
    STA z:0x48
    LDA z:0x4A
    STA z:0x4E

.locret_C4443F:
    RTL

sub_C44440:
    REP #0x20
    TYA
    STA z:0x5F
    PHX
    LDX z:0x4C
    CLC
    ADC f:byte_C44246,X
    TAY
    PLX
    LDA a:addr(collision_map),Y
    BIT z:0x42
    SEP #0x20
    BNE .loc_C4445C
    INC z:0x44
    CLC
    RTL

.loc_C4445C:
    LDY z:0x5F
    SEC
    RTL

sub_C44460:
    SEP #0x20
    LDA z:0x4C
    BIT #2
    BNE .loc_C44479
    BIT #8
    BNE .loc_C44483
    BIT #0x10
    BNE .loc_C44492
    TYA
    AND #0x1E
    CMP a:addr(0x120),X
    BEQ .loc_C444A0
    RTL

.loc_C44479:
    TYA
    AND #0x1E
    CMP a:addr(0x120),X
    BCS .loc_C444A0
    SEC
    RTL

.loc_C44483:
    REP #0x20
    TYA
    AND #0x3C0
    CMP a:addr(0x122),X
    SEP #0x20
    BCS .loc_C444A0
    SEC
    RTL

.loc_C44492:
    REP #0x20
    TYA
    AND #0x3C0
    CMP a:addr(0x122),X
    SEP #0x20
    BEQ .loc_C444A0
    RTL

.loc_C444A0:
    CLC
    RTL

sub_C444A2:
    REP #0x20
    TYA
    CLC
    ADC #0x40
    BIT #0x42
    BNE .loc_C44505
    JSL sub_C44460
    BCS .loc_C44505
    SEP #0x20
    LDA z:0x4C
    AND #6
    BEQ .loc_C444E3
    REP #0x20
    TYA
    AND #0x3C0
    CMP a:addr(0x122),X
    SEP #0x20
    BEQ .loc_C44505
    LDA z:0x4C
    STA z:0x40
    LDA #0x10
    BCS .loc_C444D3
    LDA #8

.loc_C444D3:
    STA z:0x4C
    JSL sub_C44440
    BCC .loc_C4450E
    PHA
    LDA z:0x40
    STA z:0x4C
    PLA
    CLC
    RTL

.loc_C444E3:
    TYA
    AND #0x1E
    CMP a:addr(0x120),X
    BEQ .loc_C44505
    LDA z:0x4C
    STA z:0x40
    LDA #4
    BCS .loc_C444F5
    LDA #2

.loc_C444F5:
    STA z:0x4C
    JSL sub_C44440
    BCC .loc_C4450E
    PHA
    LDA z:0x40
    STA z:0x4C
    PLA
    CLC
    RTL

.loc_C44505:
    REP #0x20
    LDA a:addr(collision_map),Y
    SEP #0x20
    CLC
    RTL

.loc_C4450E:
    LDA z:0x4F
    ORA z:0x4A
    STA z:0x4F
    LDA a:addr(collision_map),Y
    SEC
    RTL

sub_C44519:
    REP #0x20
    LDA z:0x50
    STA z:0x56
    TAY
    JSL drop_bomb
    BCS .locret_C4453A
    SEP #0x20
    INC z:0x25,X
    LDA z:0x33,X
    BEQ .locret_C4453A
    INC z:0x1A,X
    LDA z:0x1A,X
    CMP #1
    BNE .locret_C4453A
    JSL sub_C44911

.locret_C4453A:
    RTL

sub_C4453B:
    SEP #0x20
    LDA a:player.poison_state + 1,X
    BIT #high(POISON_NO_BOMBS)
    BEQ .loc_C44548
    JML .loc_C446A7

.loc_C44548:
    LDA z:player.bombups,X
    STA z:0x40
    LDA a:player.poison_state + 2,X
    BIT #POISON_MIN_FIRE_SINGLE_BOMB >> 16
    BEQ .loc_C44557
    LDA #0
    STA z:0x40

.loc_C44557:
    LDA z:0x40
    CMP z:player.current_bomb_count,X
    BCS .loc_C44561
    JML .loc_C446A7

.loc_C44561:
    LDY z:0x50
    LDA a:addr(collision_map),Y
    AND #0xE0
    BEQ .loc_C4456E
    JML .loc_C446A7

.loc_C4456E:
    REP #0x20
    LDA z:0xA,X
    PHA
    STY z:0xA,X
    CPX #addr(player_4 + player.sizeof)
    BCS .loc_C44587
    LDA a:player.poison_state + 2,X
    BIT #POISON_MIN_FIRE_SINGLE_BOMB >> 16
    BEQ .loc_C44587
    LDA #0
    BRA .loc_C44591

.loc_C44587:
    LDA z:0x31,X
    BIT #0x80
    BEQ .loc_C44591
    LDA #9

.loc_C44591:
    INC A
    AND #0xFF
    STA z:0x42
    SEP #0x20
    STZ z:0x21,X
    REP #0x20
    LDA #0x2E0
    STA z:0x44
    LDA z:0x38,X
    BIT #1
    BEQ .loc_C445AE
    LDA #0xA0
    STA z:0x44

.loc_C445AE:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C445B4:
    TYA
    CLC
    ADC #0xFFC0
    TAY
    LDA a:addr(collision_map),Y
    BIT #0x800
    BEQ .loc_C445CC
    LDA z:0x21,X
    ORA #8
    STA z:0x21,X
    LDA a:addr(collision_map),Y

.loc_C445CC:
    BIT z:0x44
    BNE .loc_C445EA
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C445EA
    CMP #0x11D
    BEQ .loc_C445EA
    LDA a:addr(collision_map),Y
    ORA #0x800
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C445B4

.loc_C445EA:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C445F0:
    TYA
    CLC
    ADC #2
    TAY
    LDA a:addr(collision_map),Y
    BIT #0x800
    BEQ .loc_C44608
    LDA z:0x21,X
    ORA #1
    STA z:0x21,X
    LDA a:addr(collision_map),Y

.loc_C44608:
    BIT z:0x44
    BNE .loc_C44626
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C44626
    CMP #0x11F
    BEQ .loc_C44626
    LDA a:addr(collision_map),Y
    ORA #0x800
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C445F0

.loc_C44626:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C4462C:
    TYA
    CLC
    ADC #0x40
    TAY
    LDA a:addr(collision_map),Y
    BIT #0x800
    BEQ .loc_C44644
    LDA z:0x21,X
    ORA #4
    STA z:0x21,X
    LDA a:addr(collision_map),Y

.loc_C44644:
    BIT z:0x44
    BNE .loc_C44662
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C44662
    CMP #0x11C
    BEQ .loc_C44662
    LDA a:addr(collision_map),Y
    ORA #0x800
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C4462C

.loc_C44662:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C44668:
    TYA
    CLC
    ADC #0xFFFE
    TAY
    LDA a:addr(collision_map),Y
    BIT #0x800
    BEQ .loc_C44680
    LDA z:0x21,X
    ORA #2
    STA z:0x21,X
    LDA a:addr(collision_map),Y

.loc_C44680:
    BIT z:0x44
    BNE .loc_C4469E
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C4469E
    CMP #0x11E
    BEQ .loc_C4469E
    LDA a:addr(collision_map),Y
    ORA #0x800
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C44668

.loc_C4469E:
    REP #0x20
    PLA
    STA z:0xA,X
    SEP #0x20
    CLC
    RTL

.loc_C446A7:
    SEP #0x20
    SEC
    RTL

sub_C446AB:
    REP #0x20
    LDA z:0xA,X
    PHA
    LDA z:0x50
    STA z:0xA,X
    CPX #addr(player_4 + player.sizeof)
    BCS .loc_C446C6
    LDA a:player.poison_state + 2,X
    BIT #POISON_MIN_FIRE_SINGLE_BOMB >> 16
    BEQ .loc_C446C6
    LDA #0
    BRA .loc_C446D0

.loc_C446C6:
    LDA z:player.fireups,X
    BIT #0x80 ; Max fire flag
    BEQ .loc_C446D0
    LDA #9

.loc_C446D0:
    INC A
    AND #0xFF
    STA z:0x42
    SEP #0x20
    LDA #0
    PHA
    PLB
    REP #0x20
    LDA #0x2E0
    STA z:0x44
    LDA z:0x38,X
    BIT #1
    BEQ .loc_C446EF
    LDA #0xA0
    STA z:0x44

.loc_C446EF:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C446F5:
    TYA
    CLC
    ADC #0xFFC0
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C44706
    STZ z:0x40
    INC z:0x40

.loc_C44706:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C44720
    CMP #0x11D
    BEQ .loc_C44720
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C446F5

.loc_C44720:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C44726:
    TYA
    CLC
    ADC #2
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C44737
    STZ z:0x40
    INC z:0x40

.loc_C44737:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C44751
    CMP #0x11F
    BEQ .loc_C44751
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C44726

.loc_C44751:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C44757:
    TYA
    CLC
    ADC #0x40
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C44768
    STZ z:0x40
    INC z:0x40

.loc_C44768:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C44782
    CMP #0x11C
    BEQ .loc_C44782
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C44757

.loc_C44782:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C44788:
    TYA
    CLC
    ADC #0xFFFE
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C44799
    STZ z:0x40
    INC z:0x40

.loc_C44799:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C447B3
    CMP #0x11E
    BEQ .loc_C447B3
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C44788

.loc_C447B3:
    REP #0x20
    PLA
    STA z:0xA,X
    SEP #0x20
    LDA #0
    PHA
    PLB
    RTL

byte_C447BF:
    db 0x40, 0xD, 0x80, 0xD ; 0
    db 0xC0, 0xD, 0, 0xE ; 4

-
    SEP #0x20
    LDA a:addr(level_manager_object.gameover_related) ; orig=0x0D32
    BNE +
    RTL
sub_C447CF:
    SEP #0x20
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #2
    BEQ -
    LDA a:addr(level_manager_object.enemy_count) ; orig=0x0D25
    CMP #1
    BNE +
    JML sub_C447F2.locret_C44864

+
    LDY a:0x100,X
    LDA a:4,Y
    REP #0x20
    BEQ sub_C447F2
    DEC a:addr(0x126),X
    BNE sub_C447F2.loc_C44840
    ; fallthrough

sub_C447F2:
    REP #0x20
    LDA #0x100
    STA a:addr(0x126),X
    LDA #0xFF
    STA z:0x4A
    LDA a:addr(level_manager_object.number_of_human_players) ; orig=0x0D36
    AND #0xFF
    BNE .loc_C4480C
    LDA #0
    STA z:0x4A

.loc_C4480C:
    JSL random2
    REP #0x20
    AND #6
    STA z:0x40

.loc_C44817:
    LDA z:0x40
    INC A
    INC A
    AND #6
    STA z:0x40
    PHX
    TAX
    LDA f:byte_C447BF,X
    PLX
    STA z:0x42
    CPX z:0x42
    BEQ .loc_C44817
    TAY
    STA a:addr(0x100),X
    LDA a:addr(4),Y
    AND #0xFF
    BEQ .loc_C44817
    LDA a:addr(7),Y
    AND z:0x4A
    BNE .loc_C44817

.loc_C44840:
    REP #0x20
    LDY a:addr(0x100),X
    LDA a:addr(0x11),Y
    AND #0xF0
    LSR A
    LSR A
    LSR A
    STA a:addr(0x120),X
    LDA a:addr(0x14),Y
    AND #0xF0
    ASL A
    ASL A
    STA a:addr(0x122),X
    ORA a:addr(0x120),X
    STA a:addr(0x124),X
    STA z:0x53
.locret_C44864:
    RTL

sub_C44865:
    REP #0x20
    LDA #0xFF
    STA z:0x4A
    LDA a:addr(level_manager_object.number_of_human_players) ; orig=0x0D36
    AND #0xFF
    BNE sub_C447F2.loc_C4480C
    LDA #0
    STA z:0x4A
    STX z:0x5F
    LDA z:0x14,X
    AND #0xFF
    CLC
    ADC z:0x11,X
    STA z:0x40
    LDA #0xFFFF
    STA z:0x42
    LDA #0xD40

.loc_C4488D:
    TAX
    CMP z:0x5F
    BEQ .loc_C448B5
    LDA z:4,X
    AND #0xFF
    BEQ .loc_C448B5
    LDA z:7,X
    AND z:0x4A
    BNE .loc_C448B5
    LDA z:0x11,X
    CLC
    ADC z:0x14,X
    SEC
    SBC z:0x40
    BPL .loc_C448AD
    EOR #0xFFFF
    INC A

.loc_C448AD:
    CMP z:0x42
    BCS .loc_C448B5
    STA z:0x42
    STX z:0x62

.loc_C448B5:
    TXA
    CLC
    ADC #0x40
    CMP #addr(player_4 + player.sizeof)
    BNE .loc_C4488D
    LDX z:0x62
    LDA z:0x11,X
    AND #0xF0
    LSR A
    LSR A
    LSR A
    STA z:0x46
    LDA z:0x14,X
    AND #0xF0
    ASL A
    ASL A
    STA z:0xD3
    JSL get_object_square_index
    STA z:0x53
    LDX z:0x5F
    RTL

sub_C448DD:
    REP #0x20
    LDA z:0x3D,X
    AND #0xFF
    PHX
    TAX
    JSL random2
    SEP #0x20
    CLC
    ADC f:byte_C4493B+5,X
    PLX
    STA z:0x22,X
    RTL

sub_C448F5:
    REP #0x20
    LDA z:0x3D,X
    AND #0xFF
    PHX
    TAX
    JSL random2
    SEP #0x20
    AND f:byte_C44936,X
    ORA f:byte_C4493B,X
    PLX
    STA a:addr(0x138),X
    RTL

sub_C44911:
    REP #0x20
    LDA z:0x3D,X
    AND #0xFF
    PHX
    TAX
    JSL random2
    SEP #0x20
    AND f:byte_C4492C,X
    ORA f:byte_C44931,X
    PLX
    STA z:0x1C,X
    RTL

byte_C4492C:
    db 0x7F, 0x7F, 0x3F, 0x3F; 0
    db 0x3F    ; 4
byte_C44931:
    db 0x60, 0x40, 0x30, 0x20; 0
    db 0x20    ; 4
byte_C44936:
    db 0x7F, 0x3F, 0x1F, 0xF ; 0
    db 0     ; 4
byte_C4493B:
    db 0x3F, 0x1F, 0xF, 7 ; 0
    db 1, 0xFF, 4, 3 ; 4
    db 2, 2    ; 8
sub_C44945:
    SEP #0x20
    CLC
    LDA a:addr(0x130),X
    ADC a:addr(0x131),X
    ADC a:addr(0x132),X
    ADC a:addr(0x133),X
    ADC a:addr(0x134),X
    ADC a:addr(0x135),X
    STA z:0x40
    BEQ .locret_C44997
    SEP #0x20
    LDA #low(sub_C44998)
    STA z:0xDB
    LDA #high(sub_C44998)
    STA z:0xDC
    LDA #bank(sub_C44998)
    STA z:0xDD
    LDA #0x80
    STA z:0xD3
    JSL create_object
    REP #0x20
    BCC .loc_C4497C
    JML .locret_C44997

.loc_C4497C:
    LDA #1
    STA a:addr(0x20),Y
    LDA #0
    STA a:addr(0x22),Y
    LDA #0
    STA a:addr(0x34),Y
    LDA z:0x40
    STA a:addr(0x32),Y
    TXA
    STA a:addr(0x30),Y

.locret_C44997:
    RTL

sub_C44998:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C449A5
    JML nullsub_C30015

.loc_C449A5:
    BIT #0x41
    BEQ .loc_C449AD
    JML .locret_C44A05

.loc_C449AD:
    REP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #8
    BNE .locret_C44A05
    DEC z:0x20,X
    BNE .locret_C44A05
    LDA #1
    STA z:0x20,X
    JSL sub_C43B6E
    BCS .locret_C44A05
    REP #0x20
    STY z:0x50
    LDA #1
    STA z:0x20,X

.loc_C449CF:
    REP #0x20
    LDA z:0x30,X
    ORA z:0x34,X
    TAY
    SEP #0x20
    LDA a:addr(0x130),Y
    BNE .loc_C449E1
    INC z:0x34,X
    BRA .loc_C449CF

.loc_C449E1:
    DEC A
    STA a:addr(0x130),Y
    REP #0x20
    LDA z:0x34,X
    ASL A
    PHX
    TAX
    LDA f:byte_C44A06,X
    PLX
    LDY z:0x50
    JSL create_bonus_object
    JSL sub_C539E2
    SEP #0x20
    DEC z:0x32,X
    BNE .locret_C44A05
    JSL delete_object

.locret_C44A05:
    RTL

byte_C44A06:
    db 1, 0, 2, 0 ; 0
    db 4, 0, 3, 0 ; 4
    db 0xC, 0, 0xD, 0 ; 8
    db 0x22, 0xB, 0xB, 0xC6 ; 0xC
    db 0x6B    ; 0x10
sub_C44A17:
    SEP #0x20
    LDA #low(sub_C44A68)
    STA z:0xDB
    LDA #high(sub_C44A68)
    STA z:0xDC
    LDA #bank(sub_C44A68)
    STA z:0xDD
    LDA #0x80
    STA z:0xD3
    JSL create_object
    REP #0x20
    BCC .loc_C44A35
    JML .locret_C44A67

.loc_C44A35:
    LDA z:0x56
    STA a:addr(0xA),Y
    SEP #0x20
    CPX #addr(player_4 + player.sizeof)
    BCS .loc_C44A4C
    LDA a:player.poison_state + 2,X
    BIT #POISON_MIN_FIRE_SINGLE_BOMB >> 16
    BEQ .loc_C44A4C
    LDA #0
    BRA .loc_C44A54

.loc_C44A4C:
    LDA z:player.fireups,X
    BIT #0x80 ; Max fire flag
    BEQ .loc_C44A54
    LDA #9

.loc_C44A54:
    INC A
    STA a:addr(0xC),Y
    LDA z:0x33,X
    CLC
    ROR A
    ORA z:0x38,X
    ROR A
    ROR A
    ORA a:addr(0xC),Y
    STA a:addr(0xC),Y
    CLC
.locret_C44A67:
    RTL

sub_C44A68:
    REP #0x20
    LDY z:0xA,X
    LDA #0xD
    STA z:0x40
    LDA z:0xA,X
    AND #0xFFC0
    ORA #4
    TAY

.loc_C44A7A:
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    TYA
    CLC
    ADC #2
    TAY
    DEC z:0x40
    BNE .loc_C44A7A
    LDA #0xB
    STA z:0x40
    LDA z:0xA,X
    AND #0x3F
    ORA #0x40
    TAY

.loc_C44A9B:
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    TYA
    CLC
    ADC #0x40
    TAY
    DEC z:0x40
    BNE .loc_C44A9B
    REP #0x20
    LDA z:0xC,X
    AND #0xF
    STA z:0x42
    LDA #0x2E0
    STA z:0x44
    LDA z:0xC,X
    BIT #0x80
    BEQ .loc_C44AC8
    LDA #0xA0
    STA z:0x44

.loc_C44AC8:
    LDY z:0xA,X
    LDA #0x820
    STA a:addr(collision_map),Y
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C44AD6:
    TYA
    CLC
    ADC #0xFFC0
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C44AE7
    STZ z:0x40
    INC z:0x40

.loc_C44AE7:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C44B01
    CMP #0x11D
    BEQ .loc_C44B01
    LDA a:addr(collision_map),Y
    ORA #0x800
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C44AD6

.loc_C44B01:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C44B07:
    TYA
    CLC
    ADC #2
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C44B18
    STZ z:0x40
    INC z:0x40

.loc_C44B18:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C44B32
    CMP #0x11F
    BEQ .loc_C44B32
    LDA a:addr(collision_map),Y
    ORA #0x800
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C44B07

.loc_C44B32:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C44B38:
    TYA
    CLC
    ADC #0x40
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C44B49
    STZ z:0x40
    INC z:0x40

.loc_C44B49:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C44B63
    CMP #0x11C
    BEQ .loc_C44B63
    LDA a:addr(collision_map),Y
    ORA #0x800
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C44B38

.loc_C44B63:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C44B69:
    TYA
    CLC
    ADC #0xFFFE
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C44B7A
    STZ z:0x40
    INC z:0x40

.loc_C44B7A:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C44B94
    CMP #0x11E
    BEQ .loc_C44B94
    LDA a:addr(collision_map),Y
    ORA #0x800
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C44B69

.loc_C44B94:
    JSL delete_object
    RTL

sub_C44B99:
    REP #0x20
    LDY z:0x50
    LDA #addr(byte_C44A06+0xC)
    STA a:addr(0),Y
    RTL

sub_C44BA4:
    REP #0x20
    REP #0x20
    LDA #addr(explode_bomb)
    STA z:0x40
    JSL sub_C60AC0
    BCC .loc_C44BB7
    JML .locret_C44BBA

.loc_C44BB7:
    JMP a:addr(drop_bomb.loc_C44C23)

.locret_C44BBA:
    RTL

drop_bomb:
i16
    REP #0x20
    LDA a:addr(collision_map),Y
    BIT #0x100
    BNE sub_C44BA4
    JSL sub_C44A17
    BCC .loc_C44BCF
    JML .locret_C44CAF

.loc_C44BCF:
    REP #0x20
    TYA
    STA z:0x50
    REP #0x20
    LDA #addr(sub_C44DA9)
    STA z:0x40
    JSL sub_C60AC0
    BCC .loc_C44BE5
    JML sub_C44B99

.loc_C44BE5:
    REP #0x20
    PHY
    LDY z:0x56
    LDA #0x820
    STA a:addr(collision_map),Y
    LDA #0x1880
    STA a:addr(bg1_tilemap),Y
    LDY #0x1E
    JSL play_sound
    PLY
    SEP #0x20
    LDA #0x78
    STA a:addr(3),Y
    REP #0x20
    LDA #0
    STA a:addr(0x1E),Y
    LDA z:0x11,X
    AND #0xF0
    ORA #8
    STA a:addr(0x11),Y
    LDA z:0x14,X
    AND #0xF0
    ORA #8
    STA a:addr(0x14),Y

.loc_C44C23:
    REP #0x20
    LDA z:0x56
    STA a:addr(0xA),Y
    TXA
    STA a:addr(8),Y
    SEP #0x20
    CPX #addr(player_4 + player.sizeof)
    BCS .loc_C44C40
    LDA a:player.poison_state + 2,X
    BIT #POISON_MIN_FIRE_SINGLE_BOMB >> 16
    BEQ .loc_C44C40
    LDA #0
    BRA .loc_C44C48

.loc_C44C40:
    LDA z:player.fireups,X
    BIT #0x80 ; Max fire flag
    BEQ .loc_C44C48
    LDA #9

.loc_C44C48:
    INC A
    STA a:addr(0xC),Y
    LDA z:0x33,X
    CLC
    ROR A
    ORA z:0x38,X
    ROR A
    ROR A
    ORA a:addr(0xC),Y
    STA a:addr(0xC),Y
    LDA z:0
    STA a:addr(0xD),Y
    LDA #1
    STA a:addr(2),Y
    INC z:0x24,X
    CPX #addr(player_4 + player.sizeof)
    BCS .loc_C44C74
    INC a:addr(0x108),X
    LDA a:addr(0x108),X
    STA a:addr(0x1C),Y

.loc_C44C74:
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #3
    BEQ .loc_C44CAD
    CPX #0xDC0
    BEQ .loc_C44CAD
    CPX #0xE00
    BEQ .loc_C44CAD
    LDA a:addr(0x108),X
    AND #7
    STA z:0x40
    ASL A
    ASL A
    ASL A
    ORA z:5,X
    ASL A
    INC A
    STA a:addr(2),Y
    LDA z:5,X
    BEQ .loc_C44CA4
    BIT #2
    BNE .loc_C44CAD
    LDA z:0x40
    ORA #0x10
    STA z:0x40

.loc_C44CA4:
    STZ z:0x41
    LDY z:0x40
    LDA #0
    STA a:addr(0xC3F),Y

.loc_C44CAD:
    CLC
    RTL
.locret_C44CAF:
    RTL

sub_C44CB0:
i16

    REP #0x20
    LDA #addr(explosion_related)
    STA z:0xDB
    SEP #0x20
    LDA #bank(explosion_related)
    STA z:0xDD
    REP #0x20
    LDA #addr(explosion_related2)
    STA z:0xDE
    SEP #0x20
    LDA #bank(explosion_related2)
    STA z:0xE0
    REP #0x20
    LDA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    BIT #0x1000
    BEQ .loc_C44D02
    LDY z:0xA,X
    LDA a:addr(bg1_tilemap+0x20),Y
    STA z:0x50
    AND #0x3FF
    CMP #0x48
    BNE .loc_C44CE7
    JML .loc_C44D05

.loc_C44CE7:
    CMP #0x4A
    BNE .loc_C44CF0
    JML .loc_C44D23

.loc_C44CF0:
    CMP #0x4C
    BNE .loc_C44CF9
    JML .loc_C44D41

.loc_C44CF9:
    CMP #0x4E
    BNE .loc_C44D02
    JML .loc_C44D5F

.loc_C44D02:
    JMP a:addr(sub_C44DA9.loc_C44DE6)

.loc_C44D05:
    LDA #0x820
    STA z:0x46
    LDA #0x820
    STA z:0x48
    JSL sub_C4539E
    LDY #0
    JSL sub_C44D7D
    BCC .loc_C44D20
    JML sub_C45354

.loc_C44D20:
    JMP a:addr(sub_C45202)

.loc_C44D23:
    LDA #0x1820
    STA z:0x46
    LDA #0x820
    STA z:0x48
    JSL sub_C4539E
    LDY #4
    JSL sub_C44D7D
    BCC .loc_C44D3E
    JML sub_C45354

.loc_C44D3E:
    JMP a:addr(sub_C45202)

.loc_C44D41:
    LDA #0x2820
    STA z:0x46
    LDA #0x820
    STA z:0x48
    JSL sub_C4539E
    LDY #8
    JSL sub_C44D7D
    BCC .loc_C44D5C
    JML sub_C45354

.loc_C44D5C:
    JMP a:addr(sub_C45202)

.loc_C44D5F:
    LDA #0x3820
    STA z:0x46
    LDA #0x820
    STA z:0x48
    JSL sub_C4539E
    LDY #0xC
    JSL sub_C44D7D
    BCC .loc_C44D7A
    JML sub_C45354

.loc_C44D7A:
    JMP a:addr(sub_C45202)

sub_C44D7D:
    REP #0x20
    LDA f:[z:0xDE],Y
    STA z:0x42
    INY
    INY
    LDA f:[z:0xDE],Y
    STA z:0x43
    JSL sub_C453AB
    LDA a:addr(bg1_tilemap+0x20),Y
    CMP z:0x50
    BNE .loc_C44D96
    CLC
    RTL

.loc_C44D96:
    SEC
    RTL

sub_C44D98:
i16
    REP #0x20
    LDY z:0xA,X
    LDA #BOMB|POTENTIAL_BLAST
    STA a:addr(collision_map),Y
    REP #0x20
    LDA #addr(sub_C44DA9)
    STA z:0,X
    ; fallthrough

sub_C44DA9:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C44DB6
    JML nullsub_C30015

.loc_C44DB6:
    BIT #0x41
    BEQ .loc_C44DBE
    JML .locret_C44F4D

.loc_C44DBE:
    REP #0x20
    LDY z:0xA,X
    LDA a:addr(collision_map),Y
    AND #BONUS_MASK|BOMB|SOFT_BLOCK|HARD_BLOCK|0x700
    CMP #HARD_BLOCK|0x500
    BNE .loc_C44DD1
    JML sub_C453C8

.loc_C44DD1:
    BIT #0x200
    BEQ .loc_C44DDA
    JML punching_glove_related

.loc_C44DDA:
    BIT #BONUS_MASK
    BEQ .loc_C44DE3
    JML sudden_death_related

.loc_C44DE3:
    JMP a:addr(sub_C44CB0)

.loc_C44DE6:
    SEP #0x20
    LDA #0
    XBA
    LDA z:3,X
    AND #0x3F
    STA z:0x40
    LDA z:0xC,X
    AND #0x40
    ORA z:0x40
    PHX
    TAX
    LDA f:bomb_animation,X
    STA a:addr(bg1_tilemap),Y
    PLX
    LDA #0x18
    STA a:addr(bg1_tilemap+1),Y
    LDA z:0xC,X
    BIT #0x80
    BEQ .loc_C44E11
    LDA #0x1C
    STA a:addr(0x4F5),Y
.loc_C44E11:
    REP #0x20
    LDA z:0xC,X
    AND #0xF
    STA z:0x42
    LDA #0x2E0
    STA z:0x44
    LDA z:0xC,X
    BIT #0x80
    BEQ .loc_C44E2B
    LDA #0xA0
    STA z:0x44

.loc_C44E2B:
    LDY z:0xA,X
    LDA a:addr(collision_map),Y
    ORA #0x800
    STA a:addr(collision_map),Y
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C44E3C:
    TYA
    CLC
    ADC #0xFFC0
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C44E4D
    STZ z:0x40
    INC z:0x40

.loc_C44E4D:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C44E67
    CMP #0x11D
    BEQ .loc_C44E67
    LDA a:addr(collision_map),Y
    ORA #0x800
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C44E3C

.loc_C44E67:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C44E6D:
    TYA
    CLC
    ADC #2
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C44E7E
    STZ z:0x40
    INC z:0x40

.loc_C44E7E:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C44E98
    CMP #0x11F
    BEQ .loc_C44E98
    LDA a:addr(collision_map),Y
    ORA #0x800
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C44E6D

.loc_C44E98:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C44E9E:
    TYA
    CLC
    ADC #0x40
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C44EAF
    STZ z:0x40
    INC z:0x40

.loc_C44EAF:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C44EC9
    CMP #0x11C
    BEQ .loc_C44EC9
    LDA a:addr(collision_map),Y
    ORA #0x800
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C44E9E

.loc_C44EC9:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C44ECF:
    TYA
    CLC
    ADC #0xFFFE
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C44EE0
    STZ z:0x40
    INC z:0x40

.loc_C44EE0:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C44EFA
    CMP #0x11E
    BEQ .loc_C44EFA
    LDA a:addr(collision_map),Y
    ORA #0x800
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C44ECF

.loc_C44EFA:
    REP #0x20
    LDA z:0x1E,X
    BEQ .loc_C44F04
    JML .loc_C44FBD

.loc_C44F04:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #4
    BNE .loc_C44F4E
    LDA z:0xC,X
    BIT #0x40
    BEQ .loc_C44F57
    LDY z:8,X
    LDA a:addr(4),Y
    BNE .loc_C44F1E
    JML explode_bomb

.loc_C44F1E:
    LDA a:addr(0x27),Y
    BIT #0x80
    BEQ .loc_C44F2D
    AND #0x7F
    STA a:addr(0x27),Y
    JMP a:addr(explode_bomb)

.loc_C44F2D:
    DEC z:3,X
    BNE .locret_C44F4D
    LDA z:0xC,X
    BIT #0x10
    BEQ .loc_C44F3B
    JML explode_bomb

.loc_C44F3B:
    CPY #0xF40
    BCS .locret_C44F4D
    LDA a:addr(7),Y
    BEQ .locret_C44F4D
    DEC z:0xD,X
    BNE .locret_C44F4D
    JML explode_bomb

.locret_C44F4D:
    RTL

.loc_C44F4E:
    LDA z:0xC,X
    BIT #0x10
    BNE .loc_C44F57
    DEC z:3,X
    RTL

.loc_C44F57:
    DEC z:3,X
    BNE .locret_C44FBC
    LDA z:0xC,X
    BIT #0x10
    BEQ .loc_C44F65
    JML explode_bomb

.loc_C44F65:
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #3
    BEQ .loc_C44F70
    JML explode_bomb

.loc_C44F70:
    LDA z:0x1C,X
    CMP #3
    BCS .loc_C44F7A
    JML explode_bomb

.loc_C44F7A:
    LDA a:addr(word_7E0CAE+1) ; orig=0x0CAF
    BNE .loc_C44F83
    JML explode_bomb

.loc_C44F83:
    JSL random2
    REP #0x20
    AND #0xFF
    CMP #0xAE
    BEQ .loc_C44F95
    JML explode_bomb

.loc_C44F95:
    DEC a:addr(word_7E0CAE+1) ; orig=0x0CAF
    PHX
    LDX #0xB
    JSL random
    PLX
    REP #0x20
    CLC
    ADC #5
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    STA z:0x1E,X
    PHY
    LDY #0xF
    JSL play_sound
    JSL sub_C53976
    PLY

.locret_C44FBC:
    RTL

.loc_C44FBD:
    REP #0x20
    DEC z:0x1E,X
    LDA z:0xC,X
    BIT #0x10
    BEQ .locret_C44FBC
    STZ z:0x1E,X
    RTL
sub_C44FCB:
    REP #0x20
    LDA z:0xC,X
    AND #0xF
    STA z:0x42
    LDA #0x2E0
    STA z:0x44
    LDA z:0xC,X
    BIT #0x80
    BEQ .loc_C44FE5
    LDA #0xA0
    STA z:0x44

.loc_C44FE5:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C44FEB:
    TYA
    CLC
    ADC #0xFFC0
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C44FFC
    STZ z:0x40
    INC z:0x40

.loc_C44FFC:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C45016
    CMP #0x11D
    BEQ .loc_C45016
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C44FEB

.loc_C45016:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C4501C:
    TYA
    CLC
    ADC #2
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C4502D
    STZ z:0x40
    INC z:0x40

.loc_C4502D:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C45047
    CMP #0x11F
    BEQ .loc_C45047
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C4501C

.loc_C45047:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C4504D:
    TYA
    CLC
    ADC #0x40
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C4505E
    STZ z:0x40
    INC z:0x40

.loc_C4505E:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C45078
    CMP #0x11C
    BEQ .loc_C45078
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C4504D

.loc_C45078:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C4507E:
    TYA
    CLC
    ADC #0xFFFE
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C4508F
    STZ z:0x40
    INC z:0x40

.loc_C4508F:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C450A9
    CMP #0x11E
    BEQ .loc_C450A9
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C4507E

.loc_C450A9:
    REP #0x20
    LDY z:0xA,X
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    LDA #0
    STA a:addr(collision_map),Y
    JSL sub_C45110
    SEP #0x20
    LDA z:0x42
    STA z:0x11,X
    REP #0x20
    LDA #addr(.loc_C450CA)
    STA z:0,X

.loc_C450CA:
    SEP #0x20
    LDA z:0x11,X
    STA z:0x42
    LDA #0x20
    STA z:0x48
    LDA #bank(byte_C30488)
    STA z:0x52
    REP #0x20
    LDY z:8,X
    LDA a:addr(0x14),Y
    CLC
    ADC z:0x18,X
    CLC
    ADC #8
    STA z:0x45
    CMP #0x100
    BCC .loc_C450F1
    JML sub_C60B35

.loc_C450F1:
    REP #0x20
    LDA z:3,X
    AND #0x3F
    STA z:0x40
    LDA z:0xC,X
    AND #0xC0
    ORA z:0x40
    ASL A
    PHX
    TAX
    LDA f:off_C304BF,X
    STA z:0x50
    PLX
    JSL sub_C6278B
    RTL

sub_C45110:
    REP #0x20
    TYA
    PHA
    AND #0x1E
    ASL A
    ASL A
    ASL A
    ORA #8
    STA z:0x42
    PLA
    AND #0x3C0
    LSR A
    LSR A
    ORA #8
    STA z:0x45
    RTL

sudden_death_related:
i16
    SEP #0x20
    BIT #0x10
    BNE .loc_C45139
    LDA #0x20
    STA a:addr(collision_map),Y
    JMP a:addr(sub_C44DA9.loc_C44DE6)

.loc_C45139:
    CMP #0x32
    BCC .loc_C45141
    JML .loc_C451AB

.loc_C45141:
    INC A
    AND #0x2F
    STA a:addr(collision_map),Y
    JSL sub_C45110
    SEP #0x20
    LDA z:0x42
    STA z:0x11,X
    LDA z:0x45
    STA z:0x14,X
    STZ z:0x13,X
    STZ z:0x12,X
    LDA z:0x11,X
    AND #0xF0
    ORA #8
    STA z:0x11,X
    LDA z:0x14,X
    AND #0xF0
    ORA #8
    STA z:0x14,X
    LDA #bank(byte_C30488)
    STA z:0x52
    LDA #0x20
    STA z:0x48
    LDA z:3,X
    BIT #1
    BNE .loc_C45184
    INC z:0x42
    LDA a:addr(0x917),Y
    AND #0x10
    BNE .loc_C45184
    DEC z:0x42
    INC z:0x45

.loc_C45184:
    REP #0x20
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    LDA z:3,X
    AND #0x3F
    STA z:0x40
    LDA z:0xC,X
    AND #0xC0
    ORA z:0x40
    ASL A
    PHX
    TAX
    LDA f:off_C304BF,X
    STA z:0x50
    PLX
    JSL sub_C6278B
    JMP a:addr(sub_C44DA9.loc_C44E11)
.loc_C451AB:
    PHY
    LDY #7
    JSL play_sound
    PLY
    SEP #0x20
    LDA #0x3F
    STA a:addr(collision_map),Y
    REP #0x20
    LDA z:8,X
    PHX
    TAX
    SEP #0x20
    LDA z:0x26,X
    BIT #0x50
    BEQ .loc_C451D5
    AND #0xBF
    STA z:0x26,X
    LDA a:addr(0x917),Y
    ORA #0x70
    STA a:addr(0x917),Y

.loc_C451D5:
    PLX
    REP #0x20
    LDA #addr(explosion_related+0x10)
    STA z:0xDB
    SEP #0x20
    LDA #bank(explosion_related+0x10)
    STA z:0xDD
    REP #0x20
    LDA #addr(explosion_related2)
    STA z:0xDE
    SEP #0x20
    LDA #bank(explosion_related2)
    STA z:0xE0
    REP #0x20
    LDY z:0xA,X
    LDA a:addr(collision_map),Y
    STA z:0x46
    LDA a:addr(collision_map),Y
    STA z:0x48
    JSL sub_C4539E
    ; fallthrough

sub_C45202:
    REP #0x20
    LDA z:0xC,X
    BIT #0x10
    BEQ .loc_C4520F
    JML sub_C45394

.loc_C4520F:
    AND #0xF
    STA z:0x42
    LDA #0x2E0
    STA z:0x44
    LDA z:0xC,X
    BIT #0x80
    BNE .loc_C45224
    JML .loc_C45229

.loc_C45224:
    LDA #0xA0
    STA z:0x44

.loc_C45229:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C4522F:
    TYA
    CLC
    ADC #0xFFC0
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C45240
    STZ z:0x40
    INC z:0x40

.loc_C45240:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C4525A
    CMP #0x11D
    BEQ .loc_C4525A
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C4522F

.loc_C4525A:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C45260:
    TYA
    CLC
    ADC #2
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C45271
    STZ z:0x40
    INC z:0x40

.loc_C45271:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C4528B
    CMP #0x11F
    BEQ .loc_C4528B
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C45260

.loc_C4528B:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C45291:
    TYA
    CLC
    ADC #0x40
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C452A2
    STZ z:0x40
    INC z:0x40

.loc_C452A2:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C452BC
    CMP #0x11C
    BEQ .loc_C452BC
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C45291

.loc_C452BC:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C452C2:
    TYA
    CLC
    ADC #0xFFFE
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C452D3
    STZ z:0x40
    INC z:0x40

.loc_C452D3:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C452ED
    CMP #0x11E
    BEQ .loc_C452ED
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C452C2

.loc_C452ED:
    REP #0x20
    LDA z:0x47
    AND #0x70
    CMP #0x70
    BEQ .loc_C4533B
    LSR A
    LSR A
    TAY
    PHY
    LDA f:[z:0xDE],Y
    STA z:0x42
    INY
    INY
    LDA f:[z:0xDE],Y
    STA z:0x43
    JSL sub_C453AB
    LDA a:addr(collision_map),Y
    PLY
    BIT #0x82E0
    BNE .loc_C4533B
    LDA z:0x10,X
    ADC f:[z:0xDB],Y
    STA z:0x10,X
    INY
    INY
    LDA z:0x13,X
    CLC
    ADC f:[z:0xDB],Y
    STA z:0x13,X
    DEY
    DEY
    LDA f:[z:0xDE],Y
    STA z:0x42
    INY
    INY
    LDA f:[z:0xDE],Y
    STA z:0x43
    JSL sub_C453AB
    LDA a:addr(collision_map),Y
    BIT #0x82E0
    BEQ sub_C45354

.loc_C4533B:
    LDA #0x820
    STA z:0x48
    SEP #0x20
    LDA z:0x11,X
    AND #0xF0
    ORA #8
    STA z:0x11,X
    LDA z:0x14,X
    AND #0xF0
    ORA #8
    STA z:0x14,X
    REP #0x20
    ; fallthrough

sub_C45354:
    STZ z:0x42
    JSL sub_C453AB
    STY z:0xA,X
    LDA z:0x48
    STA a:addr(collision_map),Y
    ; fallthrough

sub_C45361:
    SEP #0x20
    LDA #bank(byte_C30488)
    STA z:0x52
    LDA #0x20
    STA z:0x48
    LDA z:0x11,X
    STA z:0x42
    LDA z:0x14,X
    STA z:0x45
    REP #0x20
    LDA z:3,X
    AND #0x3F
    STA z:0x40
    LDA z:0xC,X
    AND #0xC0
    ORA z:0x40
    ASL A
    PHX
    TAX
    LDA f:off_C304BF,X
    STA z:0x50
    PLX
    JSL sub_C6278B
    JMP a:addr(sub_C44DA9.loc_C44E11)
    ;falltrhough

sub_C45394:
    REP #0x20
    JMP a:addr(sub_C45354)
    JMP a:addr(sub_C45361)
    REP #0x20
    
sub_C4539E:
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    LDA #0
    STA a:addr(collision_map),Y
    RTL

sub_C453AB:
    REP #0x20
    LDA z:0x11,X
    CLC
    ADC z:0x42
    AND #0xF0
    LSR A
    LSR A
    LSR A
    STA z:0x40
    LDA z:0x14,X
    CLC
    ADC z:0x43
    AND #0xF0
    ASL A
    ASL A
    ADC z:0x40
    TAY
    RTL

sub_C453C8:
    REP #0x20
    LDA z:0xC,X
    AND #0xF
    STA z:0x42
    LDA #0x2E0
    STA z:0x44
    LDA z:0xC,X
    BIT #0x80
    BEQ .loc_C453E2
    LDA #0xA0
    STA z:0x44

.loc_C453E2:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C453E8:
    TYA
    CLC
    ADC #0xFFC0
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C453F9
    STZ z:0x40
    INC z:0x40

.loc_C453F9:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C45413
    CMP #0x11D
    BEQ .loc_C45413
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C453E8

.loc_C45413:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C45419:
    TYA
    CLC
    ADC #2
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C4542A
    STZ z:0x40
    INC z:0x40

.loc_C4542A:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C45444
    CMP #0x11F
    BEQ .loc_C45444
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C45419

.loc_C45444:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C4544A:
    TYA
    CLC
    ADC #0x40
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C4545B
    STZ z:0x40
    INC z:0x40

.loc_C4545B:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C45475
    CMP #0x11C
    BEQ .loc_C45475
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C4544A

.loc_C45475:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C4547B:
    TYA
    CLC
    ADC #0xFFFE
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C4548C
    STZ z:0x40
    INC z:0x40

.loc_C4548C:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C454A6
    CMP #0x11E
    BEQ .loc_C454A6
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C4547B

.loc_C454A6:
    LDY z:0xA,X
    JSL sub_C4539E
    JSL sub_C4576B
    JSL sub_C60B35
    RTL

punching_glove_related:
i16
    REP #0x20
    LDA z:0xC,X
    AND #0xF
    STA z:0x42
    LDA #0x2E0
    STA z:0x44
    LDA z:0xC,X
    BIT #0x80
    BEQ .loc_C454CF
    LDA #0xA0
    STA z:0x44

.loc_C454CF:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C454D5:
    TYA
    CLC
    ADC #0xFFC0
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C454E6
    STZ z:0x40
    INC z:0x40

.loc_C454E6:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C45500
    CMP #0x11D
    BEQ .loc_C45500
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C454D5

.loc_C45500:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C45506:
    TYA
    CLC
    ADC #2
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C45517
    STZ z:0x40
    INC z:0x40

.loc_C45517:
    AND #0x1FF
    CMP #0x11B
    BEQ .loc_C45531
    CMP #0x11F
    BEQ .loc_C45531
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C45506

.loc_C45531:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C45537:
    TYA
    CLC
    ADC #0x40
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C45548
    STZ z:0x40
    INC z:0x40

.loc_C45548:
    AND #0x1FF
    CMP #0x1B|0x100
    BEQ .loc_C45562
    CMP #0x11C
    BEQ .loc_C45562
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C45537

.loc_C45562:
    LDY z:0xA,X
    LDA z:0x42
    STA z:0x40

.loc_C45568:
    TYA
    CLC
    ADC #0xFFFE
    TAY
    LDA a:addr(collision_map),Y
    BIT z:0x44
    BEQ .loc_C45579
    STZ z:0x40
    INC z:0x40

.loc_C45579:
    AND #0x1FF
    CMP #0x1B|0x100
    BEQ .loc_C45593
    CMP #0x1E|0x100
    BEQ .loc_C45593
    LDA a:addr(collision_map),Y
    AND #0xF7FF
    STA a:addr(collision_map),Y
    DEC z:0x40
    BNE .loc_C45568

.loc_C45593:
    SEP #0x20
    STZ z:0xF,X
    LDY z:0xA,X
    LDA a:addr(collision_map+1),Y
    AND #0x30
    LSR A
    STA z:0xE,X
    REP #0x20
    AND #0x18
    PHX
    TAX
    LDA f:byte_C3075F,X
    STA z:0xDB
    PLX
    LDA z:0xDB
    STA z:0x16,X
    JSL sub_C4539E
    JSL sub_C45110
    SEP #0x20
    LDA z:0x42
    STA z:0x11,X
    LDA z:0x45
    STA z:0x14,X
    STZ z:0x13,X
    STZ z:0x12,X
    REP #0x20
    LDA #addr(sub_C455EA)
    STA z:0,X
    LDY #8
    JSL play_sound
    SEP #0x20
    LDY z:8,X
    CPY #addr(player_4 + player.sizeof)
    BCS sub_C455EA
    LDA a:addr(7),Y
    BEQ sub_C455EA
    ORA #0x80
    STA a:addr(7),Y
    ; fallthrough
    
sub_C455EA:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C455F7
    JML nullsub_C30015

.loc_C455F7:
    BIT #0x41
    BEQ .loc_C455FF
    JML .loc_C4569E

.loc_C455FF:
    REP #0x20
    LDA #addr(byte_C3075F)
    STA z:0xDB
    SEP #0x20
    LDA #bank(byte_C3075F)
    STA z:0xDD
    REP #0x20
    LDA #addr(byte_C3075F+6)
    STA z:0xDE
    SEP #0x20
    LDA #bank(byte_C3075F+6)
    STA z:0xE0
    REP #0x20
    LDA z:0xE,X
    AND #0x38
    TAY
    SEP #0x20
    LDA z:0xF,X
    AND #0x3F
    CMP f:[z:0xDE],Y
    BEQ .loc_C4562F
    JML .loc_C45674

.loc_C4562F:
    REP #0x20
    STZ z:0x42
    JSL sub_C453AB
    REP #0x20
    LDA a:addr(collision_map),Y
    AND #0x71FF
    BNE .loc_C45645
    JML .loc_C456EE

.loc_C45645:
    PHY
    LDY #4
    JSL play_sound
    PLY
    SEP #0x20
    LDA z:0xE,X
    ORA #0x20
    STA z:0xE,X
    LDA z:0x11,X
    AND #0xF0
    ORA #8
    STA z:0x11,X
    LDA z:0x14,X
    AND #0xF0
    ORA #8
    STA z:0x14,X
    STZ z:0xF,X
    REP #0x20
    LDA z:0xE,X
    AND #0x38
    TAY
    LDA f:[z:0xDB],Y
    STA z:0x16,X
.loc_C45674:
    REP #0x20
    LDA #addr(byte_C3075F+2)
    STA z:0xDB
    SEP #0x20
    LDA #bank(byte_C3075F+2)
    STA z:0xDD
    REP #0x20
    LDA f:[z:0xDB],Y
    STA z:0x40
    JSL sub_C4572E
    BCS .locret_C456ED
    REP #0x20
    INY
    INY
    STZ z:0x42
    LDA f:[z:0xDB],Y
    BPL .loc_C45699
    DEC z:0x42

.loc_C45699:
    CLC
    ADC z:0x10,X
    STA z:0x10,X
.loc_C4569E:
    SEP #0x20
    LDA #bank(byte_C30488)
    STA z:0x52
    LDA #0x30
    STA z:0x48
    LDA z:0x11,X
    STA z:0x42
    LDA z:0x12,X
    STA z:0x43
    LDA z:0x14,X
    STA z:0x45
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C456C1
    JML nullsub_C30015

.loc_C456C1:
    BIT #0x41
    BEQ .loc_C456C9
    JML .loc_C456D3

.loc_C456C9:
    SEP #0x20
    INC z:0xF,X
    LDA z:0xF,X
    AND #0x3F
    STA z:0xF,X

.loc_C456D3:
    REP #0x20
    LDA z:0xC,X
    AND #0xC0
    ORA z:0xF,X
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:off_C304BF,X
    STA z:0x50
    PLX
    JSL sub_C6278B

.locret_C456ED:
    RTL

.loc_C456EE:
    PHY
    LDY #4
    JSL play_sound
    SEP #0x20
    LDY z:8,X
    CPY #addr(player_4 + player.sizeof)
    BCS .loc_C45709
    LDA a:addr(7),Y
    BEQ .loc_C45709
    AND #1
    STA a:addr(7),Y

.loc_C45709:
    LDA z:0x11,X
    AND #0xF0
    ORA #8
    STA z:0x11,X
    LDA z:0x14,X
    AND #0xF0
    ORA #8
    STA z:0x14,X
    REP #0x20
    PLY
    STY z:0xA,X
    LDA #0xA3F
    STA a:addr(collision_map),Y
    REP #0x20
    LDA #addr(sub_C44D98)
    STA z:0,X
    JMP a:addr(sub_C44DA9.loc_C44DE6)

sub_C4572E:
    REP #0x20
    STZ z:0x42
    LDA z:0x16,X
    CLC
    ADC z:0x40
    STA z:0x16,X
    BPL .loc_C4573D
    DEC z:0x42

.loc_C4573D:
    CLC
    ADC z:0x13,X
    STA z:0x13,X
    SEP #0x20
    LDA z:0x42
    ADC z:0x15,X
    STA z:0x15,X
    REP #0x20
    LDA z:0x14,X
    BPL .loc_C4575F
    CMP #0xFFFA
    BCS .loc_C4575D
    AND #0xF
    ORA #0xC0
    STA z:0x14,X

.loc_C4575D:
    CLC
    RTL

.loc_C4575F:
    CMP #0xD0
    BCC .loc_C45769
    AND #0xF
    STA z:0x14,X

.loc_C45769:
    CLC
    RTL

sub_C4576B:
    SEP #0x20
    REP #0x20
    LDA z:8,X
    PHX
    TAX
    SEP #0x20
    DEC z:0x24,X
    PLX
    LDY z:8,X
    CPY #0xF40
    BCS .locret_C4579D
    LDA a:addr(7),Y
    BEQ .locret_C4579D
    LDA z:0xC,X
    BIT #0x40
    BEQ .locret_C4579D
    PHX
    PHY
    LDA z:8,X
    TAX
    STZ z:0x1C,X
    DEC z:0x1A,X
    LDA z:0x1A,X
    BEQ .loc_C4579B
    JSL sub_C44911

.loc_C4579B:
    PLY
    PLX

.locret_C4579D:
    RTL

explode_bomb:
i16
    REP #0x20
    LDY z:0xA,X

.loc_C457A2:
    TYA
    CLC
    ADC #0xFFC0
    TAY
    LDA a:addr(collision_map),Y
    BIT #0x80
    BNE .loc_C457C6
    AND #0x1FF
    CMP #0x11C
    BNE .loc_C457A2
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    LDA #0
    STA a:addr(collision_map),Y
    BRA .loc_C457A2

.loc_C457C6:
    LDY z:0xA,X

.loc_C457C8:
    TYA
    CLC
    ADC #2
    TAY
    LDA a:addr(collision_map),Y
    BIT #0x80
    BNE .loc_C457EC
    AND #0x1FF
    CMP #0x11E
    BNE .loc_C457C8
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    LDA #0
    STA a:addr(collision_map),Y
    BRA .loc_C457C8

.loc_C457EC:
    LDY z:0xA,X

.loc_C457EE:
    TYA
    CLC
    ADC #0x40
    TAY
    LDA a:addr(collision_map),Y
    BIT #0x80
    BNE .loc_C45812
    AND #0x1FF
    CMP #0x11D
    BNE .loc_C457EE
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    LDA #0
    STA a:addr(collision_map),Y
    BRA .loc_C457EE

.loc_C45812:
    LDY z:0xA,X

.loc_C45814:
    TYA
    CLC
    ADC #0xFFFE
    TAY
    LDA a:addr(collision_map),Y
    BIT #0x80
    BNE .loc_C45838
    AND #0x1FF
    CMP #0x11F
    BNE .loc_C45814
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    LDA #0
    STA a:addr(collision_map),Y
    BRA .loc_C45814

.loc_C45838:
    PHY
    LDY #0x15
    JSL play_sound
    PLY
    JSL sub_C4576B
    SEP #0x20
    LDA #1
    STA z:3,X
    LDA z:0xC,X
    STA z:8,X
    STZ z:9,X
    REP #0x20
    LDA #addr(.loc_C45858)
    STA z:0,X
.loc_C45858:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C45865
    JML nullsub_C30015

.loc_C45865:
    BIT #0x41
    BEQ .loc_C4586D
    JML .locret_C458A6

.loc_C4586D:
    SEP #0x20
    DEC z:3,X
    LDA z:3,X
    BEQ .loc_C45879
    JML sub_C45ADB

.loc_C45879:
    LDA #bank(explosion_animation)
    STA z:0x52
    REP #0x20
    LDA z:9,X
    AND #0xFF
    ASL A
    ASL A
    CLC
    ADC #addr(explosion_animation)
    STA z:0x50
    LDA f:[z:0x50]
    INC z:0x50
    INC z:0x50
    SEP #0x20
    STA z:3,X
    JSL sub_C458B0
    INC z:9,X
    LDA z:9,X
    CMP #0xB
    BNE .locret_C458A6
    JSL sub_C60B35

.locret_C458A6:
    RTL

sub_C458A7:
    REP #0x20
    LDA a:addr(collision_map),Y
    BIT #0x80
    RTL

sub_C458B0:
i16
    SEP #0x20
    LDY z:0xA,X
    LDA z:9,X
    CMP #0xA
    BNE .loc_C458BE
    JML .loc_C45A00

.loc_C458BE:
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x50
    JSL sub_C458A7
    BNE .loc_C458D5
    LDA f:[z:0x50]
    STA a:addr(bg1_tilemap),Y
    LDA #0x1B|0x100
    STA a:addr(collision_map),Y

.loc_C458D5:
    SEP #0x20
    LDA z:2,X
    STA z:0x45
    LDA #0x1C
    STA z:0x44
    REP #0x20
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x46
    LDY #8
    LDA f:[z:0x50],Y
    STA z:0x48
    LDA z:8,X
    AND #0xF
    STA z:0x40
    LDY z:0xA,X

.loc_C458F9:
    TYA
    CLC
    ADC #0xFFC0
    TAY
    LDA a:addr(collision_map),Y
    JSR a:addr(addr(sub_C45BDA))
    BCC .loc_C45922
    BNE .loc_C4591E
    LDA z:0x44
    STA a:addr(collision_map),Y
    LDA z:0x46
    STA a:addr(bg1_tilemap),Y
    DEC z:0x40
    BNE .loc_C458F9
    LDA z:0x48
    STA a:addr(bg1_tilemap),Y
    BRA .loc_C45922

.loc_C4591E:
    DEC z:0x40
    BNE .loc_C458F9

.loc_C45922:
    SEP #0x20
    LDA #0x1E
    STA z:0x44
    REP #0x20
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x46
    LDY #8
    LDA f:[z:0x50],Y
    STA z:0x48
    LDA z:8,X
    AND #0xF
    STA z:0x40
    LDY z:0xA,X

.loc_C45942:
    TYA
    CLC
    ADC #2
    TAY
    LDA a:addr(collision_map),Y
    JSR a:addr(addr(sub_C45BDA))
    BCC .loc_C4596B
    BNE .loc_C45967
    LDA z:0x44
    STA a:addr(collision_map),Y
    LDA z:0x46
    STA a:addr(bg1_tilemap),Y
    DEC z:0x40
    BNE .loc_C45942
    LDA z:0x48
    STA a:addr(bg1_tilemap),Y
    BRA .loc_C4596B

.loc_C45967:
    DEC z:0x40
    BNE .loc_C45942

.loc_C4596B:
    SEP #0x20
    LDA #0x1D
    STA z:0x44
    REP #0x20
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x46
    LDY #8
    LDA f:[z:0x50],Y
    STA z:0x48
    LDA z:8,X
    AND #0xF
    STA z:0x40
    LDY z:0xA,X

.loc_C4598B:
    TYA
    CLC
    ADC #0x40
    TAY
    LDA a:addr(collision_map),Y
    JSR a:addr(addr(sub_C45BDA))
    BCC .loc_C459B4
    BNE .loc_C459B0
    LDA z:0x44
    STA a:addr(collision_map),Y
    LDA z:0x46
    STA a:addr(bg1_tilemap),Y
    DEC z:0x40
    BNE .loc_C4598B
    LDA z:0x48
    STA a:addr(bg1_tilemap),Y
    BRA .loc_C459B4

.loc_C459B0:
    DEC z:0x40
    BNE .loc_C4598B

.loc_C459B4:
    SEP #0x20
    LDA #0x1F
    STA z:0x44
    REP #0x20
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x46
    LDY #8
    LDA f:[z:0x50],Y
    STA z:0x48
    LDA z:8,X
    AND #0xF
    STA z:0x40
    LDY z:0xA,X

.loc_C459D4:
    TYA
    CLC
    ADC #0xFFFE
    TAY
    LDA a:addr(collision_map),Y
    JSR a:addr(addr(sub_C45BDA))
    BCC .loc_C459FD
    BNE .loc_C459F9
    LDA z:0x44
    STA a:addr(collision_map),Y
    LDA z:0x46
    STA a:addr(bg1_tilemap),Y
    DEC z:0x40
    BNE .loc_C459D4
    LDA z:0x48
    STA a:addr(bg1_tilemap),Y
    BRA .loc_C459FD

.loc_C459F9:
    DEC z:0x40
    BNE .loc_C459D4

.loc_C459FD:
    SEP #0x20
    RTL

.loc_C45A00:
    JSL sub_C458A7
    BNE .loc_C45A14
    REP #0x20
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    LDA #0
    STA a:addr(collision_map),Y

.loc_C45A14:
    SEP #0x20
    LDA #0x1C
    STA z:0x44
    REP #0x20
    LDA z:8,X
    AND #0xF
    STA z:0x40
    LDY z:0xA,X

.loc_C45A25:
    TYA
    CLC
    ADC #0xFFC0
    TAY
    LDA a:addr(collision_map),Y
    JSR a:addr(addr(sub_C45BDA))
    BCC .loc_C45A45
    BNE .loc_C45A41
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    LDA #0
    STA a:addr(collision_map),Y

.loc_C45A41:
    DEC z:0x40
    BNE .loc_C45A25

.loc_C45A45:
    SEP #0x20
    LDA #0x1E
    STA z:0x44
    REP #0x20
    LDA z:8,X
    AND #0xF
    STA z:0x40
    LDY z:0xA,X

.loc_C45A56:
    TYA
    CLC
    ADC #2
    TAY
    LDA a:addr(collision_map),Y
    JSR a:addr(addr(sub_C45BDA))
    BCC .loc_C45A76
    BNE .loc_C45A72
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    LDA #0
    STA a:addr(collision_map),Y

.loc_C45A72:
    DEC z:0x40
    BNE .loc_C45A56

.loc_C45A76:
    SEP #0x20
    LDA #0x1D
    STA z:0x44
    REP #0x20
    LDA z:8,X
    AND #0xF
    STA z:0x40
    LDY z:0xA,X

.loc_C45A87:
    TYA
    CLC
    ADC #0x40
    TAY
    LDA a:addr(collision_map),Y
    JSR a:addr(addr(sub_C45BDA))
    BCC .loc_C45AA7
    BNE .loc_C45AA3
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    LDA #0
    STA a:addr(collision_map),Y

.loc_C45AA3:
    DEC z:0x40
    BNE .loc_C45A87

.loc_C45AA7:
    SEP #0x20
    LDA #0x1F
    STA z:0x44
    REP #0x20
    LDA z:8,X
    AND #0xF
    STA z:0x40
    LDY z:0xA,X

.loc_C45AB8:
    TYA
    CLC
    ADC #0xFFFE
    TAY
    LDA a:addr(collision_map),Y
    JSR a:addr(addr(sub_C45BDA))
    BCC .loc_C45AD8
    BNE .loc_C45AD4
    LDA a:addr(bg1_tilemap+0x20),Y
    STA a:addr(bg1_tilemap),Y
    LDA #0
    STA a:addr(collision_map),Y

.loc_C45AD4:
    DEC z:0x40
    BNE .loc_C45AB8

.loc_C45AD8:
    SEP #0x20
    RTL

sub_C45ADB:
    REP #0x20
    LDY z:0xA,X
    JSL sub_C458A7
    BNE .loc_C45AEB
    LDA #0x11B
    STA a:addr(collision_map),Y

.loc_C45AEB:
    SEP #0x20
    LDA z:2,X
    STA z:0x45
    LDA #0x1C
    STA z:0x44
    REP #0x20
    LDA z:8,X
    AND #0xF
    STA z:0x40
    LDY z:0xA,X

.loc_C45B00:
    TYA
    CLC
    ADC #0xFFC0
    TAY
    LDA a:addr(collision_map),Y
    JSR a:addr(addr(sub_C45BDA))
    BCC .loc_C45B19
    BNE .loc_C45B15
    LDA z:0x44
    STA a:addr(collision_map),Y

.loc_C45B15:
    DEC z:0x40
    BNE .loc_C45B00

.loc_C45B19:
    SEP #0x20
    LDA #0x1E
    STA z:0x44
    REP #0x20
    LDA z:8,X
    AND #0xF
    STA z:0x40
    LDY z:0xA,X

.loc_C45B2A:
    TYA
    CLC
    ADC #2
    TAY
    LDA a:addr(collision_map),Y
    JSR a:addr(addr(sub_C45BDA))
    BCC .loc_C45B43
    BNE .loc_C45B3F
    LDA z:0x44
    STA a:addr(collision_map),Y

.loc_C45B3F:
    DEC z:0x40
    BNE .loc_C45B2A

.loc_C45B43:
    SEP #0x20
    LDA #0x1D
    STA z:0x44
    REP #0x20
    LDA z:8,X
    AND #0xF
    STA z:0x40
    LDY z:0xA,X

.loc_C45B54:
    TYA
    CLC
    ADC #0x40
    TAY
    LDA a:addr(collision_map),Y
    JSR a:addr(addr(sub_C45BDA))
    BCC .loc_C45B6D
    BNE .loc_C45B69
    LDA z:0x44
    STA a:addr(collision_map),Y

.loc_C45B69:
    DEC z:0x40
    BNE .loc_C45B54

.loc_C45B6D:
    SEP #0x20
    LDA #0x1F
    STA z:0x44
    REP #0x20
    LDA z:8,X
    AND #0xF
    STA z:0x40
    LDY z:0xA,X

.loc_C45B7E:
    TYA
    CLC
    ADC #0xFFFE
    TAY
    LDA a:addr(collision_map),Y
    JSR a:addr(addr(sub_C45BDA))
    BCC .loc_C45B97
    BNE .loc_C45B93
    LDA z:0x44
    STA a:addr(collision_map),Y

.loc_C45B93:
    DEC z:0x40
    BNE .loc_C45B7E

.loc_C45B97:
    SEP #0x20
    RTL

sub_C45B9A:
i16
    REP #0x20
    STY z:0x56
    LDY #0x1C80

.loc_C45BA1:
    LDA a:addr(0xC),Y
    BIT #0x10
    BNE .loc_C45BD0
    LDA a:addr(0xA),Y
    CMP z:0x56
    BNE .loc_C45BD0
    SEP #0x20
    LDA #8
    STA a:addr(3),Y
    LDA a:addr(0xC),Y
    ORA #0x10
    STA a:addr(0xC),Y
    LDA z:2,X
    EOR a:addr(2),Y
    AND #4
    BNE .loc_C45BCD
    LDA z:2,X
    STA a:addr(2),Y

.loc_C45BCD:
    REP #0x20
    RTL

.loc_C45BD0:
    LDA a:addr(6),Y
    TAY
    INC A
    BNE .loc_C45BA1
    RTL

    REP #0x20
sub_C45BDA:
    BIT #0x1FF
    BEQ .loc_C45C34
    CMP #0x580
    BEQ .loc_C45C36
    BIT #0x20
    BNE .loc_C45C5C
    BIT #0x40
    BNE .loc_C45C62
    BIT #0x80
    BNE .loc_C45C32
    BIT #0x100
    BNE .loc_C45C3B
    LDA z:9,X
    AND #0xFF
    BEQ .loc_C45C29
    LDA a:addr(collision_map),Y
    AND #0x1F
    CMP #0x10
    BNE .loc_C45C0E
    JML .loc_C45C92

.loc_C45C0E:
    CMP #0x1F
    BEQ .loc_C45C29
    LDA #0x21F
    STA a:addr(collision_map),Y
    LDA #0x20
    STA z:0x4A
    LDA #0
    STA z:0x42
    JSL sub_C42517
    REP #0x20

.loc_C45C29:
    LDA z:8,X
    BIT #0x80
    BEQ .loc_C45C32
    SEC
    RTS

.loc_C45C32:
    CLC
    RTS

.loc_C45C34:
    SEC
    RTS

.loc_C45C36:
    LDA #0xFF
    SEC
    RTS

.loc_C45C3B:
    SEP #0x20
    LDA a:addr(collision_map),Y
    CMP #0x1B
    BEQ .loc_C45C51
    EOR #1
    CMP z:0x44
    BEQ .loc_C45C51
    REP #0x20
    LDA #0
    SEC
    RTS

.loc_C45C51:
    REP #0x20
    CLC
    RTS
    REP #0x20
    LDA #0xFF
    SEC
    RTS

.loc_C45C5C:
    JSL sub_C45B9A
    CLC
    RTS

.loc_C45C62:
    LDA z:9,X
    AND #0xFF
    BEQ .loc_C45C87
    LDA a:addr(collision_map),Y
    AND #0x1F
    CMP #0x1F
    BEQ .loc_C45C87
    STA z:0x42
    LDA #0
    STA z:0x4A
    LDA #0x5F
    STA a:addr(collision_map),Y
    JSL sub_C42517
    REP #0x20

.loc_C45C87:
    LDA z:8,X
    BIT #0x80
    BEQ .loc_C45C90
    SEC
    RTS

.loc_C45C90:
    CLC
    RTS

.loc_C45C92:
    REP #0x20
    LDA #addr(unk_7F06AE)
    STA z:0x5F
    SEP #0x20
    LDA #bank(unk_7F06AE)
    STA z:0x61
    REP #0x20
    LDA z:0x40
    PHA
    LDA z:0x46
    PHA
    LDA z:0x48
    PHA
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #4
    BNE .loc_C45D2C

.loc_C45CB2:
    INC z:0x5F
    INC z:0x5F
    LDA f:[z:0x5F]
    BEQ .loc_C45D2C
    STA z:0x53
    INC z:0x5F
    LDA f:[z:0x5F]
    BIT #0x1000
    BEQ .loc_C45CB2
    TYA
    AND #0x1E
    ASL A
    ASL A
    ASL A
    ORA #8
    STA z:0x40
    TYA
    AND #0x3C0
    LSR A
    LSR A
    ORA #8
    STA z:0x42
    PHY
    JSL sub_C45D39
    REP #0x20
    PLY
    BCS .loc_C45D2C
    LDA f:[z:0x5F]
    AND #0xEFFF
    STA f:[z:0x5F]
    STA z:0x54
    DEC z:0x5F
    INC a:addr(level_manager_object.enemy_count) ; orig=0x0D25
    STZ z:0x48
    PHY
    LDA z:0x50
    PHA
    LDA z:0x53
    PHA
    LDA z:0x56
    PHA
    LDA z:0x5F
    PHA
    LDA z:0x60
    PHA
    JSL call_function_at_0053
    JSL random2
    SEP #0x20
    AND #3
    STA a:addr(0x20),Y
    LDA #0xFF
    STA a:addr(0x1B),Y
    REP #0x20
    PLA
    STA z:0x60
    PLA
    STA z:0x5F
    PLA
    STA z:0x56
    PLA
    STA z:0x53
    PLA
    STA z:0x50
    PLY

.loc_C45D2C:
    PLA
    STA z:0x48
    PLA
    STA z:0x46
    PLA
    STA z:0x40
    JMP a:addr(.loc_C45C29)

    RTL
sub_C45D39:
i16
    LDY #0xF40

.loc_C45D3C:
    SEP #0x20
    LDA a:addr(3),Y
    BIT #1
    BEQ .loc_C45D65
    LDA a:addr(0x11),Y
    SEC
    SBC z:0x40
    BCS .loc_C45D50
    EOR #0xFF
    INC A

.loc_C45D50:
    CMP #0x10
    BCS .loc_C45D65
    LDA a:addr(0x14),Y
    SEC
    SBC z:0x42
    BCS .loc_C45D5F
    EOR #0xFF
    INC A

.loc_C45D5F:
    CMP #0x10
    BCS .loc_C45D65
    SEC
    RTL

.loc_C45D65:
    REP #0x20
    LDA a:addr(6),Y
    TAY
    CMP #0xFFFF
    BNE .loc_C45D3C
    CLC
    RTL

    REP #0x20

sub_C45D74:
    LDX #8
    REP #0x20
    LDA z:0x44
    PHA
    LDA z:0x46
    PHA
    LDA z:0x48
    PHA
    PHY
    JSL random
    PLY
    REP #0x20
    AND #0xFF
    STA z:0x40
    PLA
    STA z:0x48
    PLA
    STA z:0x46
    PLA
    STA z:0x44
    LDA z:0x40
    BIT #4
    BEQ .loc_C45DA3
    EOR #0xFFFB
    INC A

.loc_C45DA3:
    ASL A
    ASL A
    ASL A
    ASL A
    STA z:0x42
    CLC
    ADC z:0x44
    AND #0xF0
    ORA #8
    RTL

sub_C45DB3:
    REP #0x20
    PHX
    LDA #0
    STA z:0x46
    LDA a:addr(0x11),Y
    STA z:0x44
    JSL sub_C45D74
    STA a:addr(0x16),Y
    LDA z:0x42
    ASL A
    ASL A
    ASL A
    STA a:addr(0x1A),Y

.loc_C45DCF:
    LDA z:0x46
    INC z:0x46
    CMP z:0x48
    BEQ .loc_C45E12
    LDA a:addr(0x14),Y
    STA z:0x44
    JSL sub_C45D74
    BMI .loc_C45DCF
    CMP #0x10
    BCC .loc_C45DCF
    CMP #0xB9
    BCS .loc_C45DCF
    SEP #0x20
    STA a:addr(0x17),Y
    LDA #bank(byte_C30488)
    STA z:0x52
    REP #0x20
    LDA z:0x40
    ASL A
    ASL A
    CLC
    ADC #addr(word_C3073F)
    STA z:0x50
    LDA f:[z:0x50]
    STA a:addr(0x1C),Y
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:addr(0x18),Y
    PLX
    CLC
    RTL

.loc_C45E12:
    PLX
    SEC
    RTL

sub_C45E15:
    REP #0x20
    LDA #addr(sub_C45E5B)
    STA z:0x40
    JSL sub_C60AC0
    BCC .loc_C45E26
    JML .loc_C45E56

.loc_C45E26:
    SEP #0x20
    LDA #0x81
    STA a:addr(2),Y
    LDA #0x78
    STA a:addr(3),Y
    LDA #0xA
    STA a:addr(0xC),Y
    LDA #0x20
    STA a:addr(0x1E),Y
    REP #0x20
    TXA
    STA a:addr(8),Y
    LDA z:0x11,X
    STA a:addr(0x11),Y
    LDA z:0x14,X
    STA a:addr(0x14),Y
    LDA #0xFFFF
    STA z:0x48
    JSL sub_C45DB3
    RTL

.loc_C45E56:
    SEP #0x20
    DEC z:0x24,X
    RTL

sub_C45E5B:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C45E68
    JML nullsub_C30015

.loc_C45E68:
    BIT #0x41
    BEQ .loc_C45E70
    JML .loc_C45ECC

.loc_C45E70:
    REP #0x20
    LDA z:0x10,X
    CLC
    ADC z:0x1A,X
    STA z:0x10,X
    STZ z:0x42
    LDA z:0x1C,X
    CLC
    ADC z:0x18,X
    STA z:0x1C,X
    BPL .loc_C45E86
    DEC z:0x42

.loc_C45E86:
    CLC
    ADC z:0x13,X
    STA z:0x13,X
    SEP #0x20
    LDA z:0x42
    ADC z:0x15,X
    STA z:0x15,X
    DEC z:0x1E,X
    BNE .loc_C45ECC
    LDA z:0x16,X
    STA z:0x11,X
    LDA z:0x17,X
    STA z:0x14,X
    STZ z:0x12,X
    STZ z:0x15,X
    LDA #8
    STA z:0xE,X
    LDA z:0x1B,X
    BPL .loc_C45EAF
    LDA #0x18
    STA z:0xE,X

.loc_C45EAF:
    LDA z:0xE,X
    STZ z:0xF,X
    REP #0x20
    AND #0x18
    PHX
    TAX
    LDA f:byte_C3075F,X
    STA z:0xDB
    PLX
    LDA z:0xDB
    STA z:0x16,X
    REP #0x20
    LDA #addr(sub_C455EA)
    STA z:0,X
.loc_C45ECC:
    SEP #0x20
    LDA #bank(byte_C30488)
    STA z:0x52
    LDA #0x30
    STA z:0x48
    LDA z:0x11,X
    STA z:0x42
    LDA z:0x14,X
    STA z:0x45
    REP #0x20
    LDA z:3,X
    AND #0x3F
    STA z:0x40
    LDA z:0xC,X
    AND #0xC0
    ORA z:0x40
    ASL A
    PHX
    TAX
    LDA f:off_C304BF+0x200,X
    STA z:0x50
    PLX
    JSL sub_C6278B
    RTL

create_random_bomb_drop:
    SEP #0x20
    LDA #low(sub_C45F1E)
    STA z:0xDB
    LDA #high(sub_C45F1E)
    STA z:0xDC
    LDA #bank(sub_C45F1E)
    STA z:0xDD
    LDA #0x80
    STA z:0xD3
    JSL create_object
    REP #0x20
    BCS .locret_C45F1D
    LDA #0x100
    STA a:addr(0x20),Y
.locret_C45F1D:
    RTL

sub_C45F1E:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C45F2B
    JML nullsub_C30015

.loc_C45F2B:
    BIT #0x41
    BEQ .loc_C45F33
    JML create_random_bomb_drop.locret_C45F1D

.loc_C45F33:
    REP #0x20
    LDA a:addr(level_manager_object.anonymous_10) ; orig=0x0D3A
    CMP #0x100
    BCS .loc_C45F41
    JML delete_object

.loc_C45F41:
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #4
    BEQ .loc_C45F4D
    JML delete_object

.loc_C45F4D:
    DEC z:0x20,X
    BNE create_random_bomb_drop.locret_C45F1D
    JSL random2
    REP #0x20
    AND #0xFF
    CLC
    ADC #0x40
    STA z:0x20,X
    REP #0x20
    LDA #addr(sub_C45F89)
    STA z:0x40
    JSL sub_C60AC0
    BCC .loc_C45F71
    JML drop_bomb.locret_C44CAF

.loc_C45F71:
    REP #0x20
    TXA
    STA a:addr(8),Y
    SEP #0x20
    LDA #0x81
    STA a:addr(2),Y
    LDA #0x78
    STA a:addr(3),Y
    LDA #1
    STA a:addr(0xC),Y
    RTL

sub_C45F89:
i16
    REP #0x20
    PHX
    LDX #0xD
    JSL random
    SEP #0x20
    INC A
    INC A
    ASL A
    ASL A
    ASL A
    ASL A
    ORA #8
    STA z:0x40
    REP #0x20
    LDX #0xB
    LDA z:0x40
    PHA
    JSL random
    SEP #0x20
    INC A
    ASL A
    ASL A
    ASL A
    ASL A
    ORA #8
    STA z:0x42
    REP #0x20
    PLA
    STA z:0x40
    PLX
    LDA z:0x40
    STA z:0x11,X
    LDA #0xFFF0
    STA z:0x14,X
    LDA z:0x42
    STA z:0x1A,X
    LDA #0
    STA z:0x16,X
    REP #0x20
    LDA #addr(.loc_C45FD5)
    STA z:0,X
.loc_C45FD5:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x90
    BEQ .loc_C45FE2
    JML nullsub_C30015

.loc_C45FE2:
    BIT #0x41
    BEQ .loc_C45FEA
    JML .loc_C46059

.loc_C45FEA:
    REP #0x20
    STZ z:0x42
    LDA z:0x16,X
    CLC
    ADC #0x80
    STA z:0x16,X
    BPL .loc_C45FFA
    DEC z:0x42

.loc_C45FFA:
    CLC
    ADC z:0x13,X
    STA z:0x13,X
    SEP #0x20
    LDA z:0x42
    ADC z:0x15,X
    STA z:0x15,X
    REP #0x20
    LDA z:0x14,X
    BPL .loc_C46011
    JML .loc_C46059

.loc_C46011:
    LDA z:0x1A,X
    AND #0xFF
    CMP z:0x14,X
    BCC .loc_C4601E
    JML .loc_C46059

.loc_C4601E:
    SEP #0x20
    LDA z:0x1A,X
    STA z:0x14,X
    STZ z:0xF,X
    LDA #8
    STA z:0x42
    JSL random2
    SEP #0x20
    AND #3
    BEQ .loc_C4603C
    STA z:0x40

.loc_C46036:
    ASL z:0x42
    DEC z:0x40
    BNE .loc_C46036

.loc_C4603C:
    LDA z:0x42
    STA z:0xE,X
    REP #0x20
    AND #0x78
    PHX
    TAX
    LDA f:byte_C3075F,X
    STA z:0xDB
    PLX
    LDA z:0xDB
    STA z:0x16,X
    REP #0x20
    LDA #addr(sub_C455EA)
    STA z:0,X

.loc_C46059:
    SEP #0x20
    LDA #bank(byte_C30488)
    STA z:0x52
    LDA #0x30
    STA z:0x48
    LDA z:0x11,X
    STA z:0x42
    LDA z:0x14,X
    STA z:0x45
    REP #0x20
    LDA z:3,X
    AND #0x3F
    STA z:0x40
    LDA z:0xC,X
    AND #0xC0
    ORA z:0x40
    ASL A
    PHX
    TAX
    LDA f:off_C304BF,X
    STA z:0x50
    PLX
    JSL sub_C6278B
    RTL

animation_frame_C4608A:
    db 8
    frame_oam_tile 0, 0x10, 0x2202, 0x20
    frame_oam_tile 0xF0, 0x10, 0x2002, 0x20
    frame_oam_tile 0xF8, 0, 0x102, 0x20
    frame_oam_tile 0xF8, 0xF0, 0x2100, 0x20
    frame_oam_tile 0xF0, 0xF0, 0x2000, 0
    frame_oam_tile 0, 0xE8, 0x1200, 0
    frame_oam_tile 0, 0xE0, 0x200, 0
    frame_oam_tile 0xF0, 0xE0, 0, 0x20
animation_frame_C460B3:
    db 8
    frame_oam_tile 0, 0x10, 0x2602, 0x20
    frame_oam_tile 0xF0, 0x10, 0x2402, 0x20
    frame_oam_tile 0, 0, 0x602, 0x20
    frame_oam_tile 0xF0, 0, 0x402, 0x20
    frame_oam_tile 0, 0xF0, 0x2600, 0x20
    frame_oam_tile 0xF0, 0xF0, 0x2400, 0x20
    frame_oam_tile 0, 0xE0, 0x201, 0x20
    frame_oam_tile 0xF0, 0xE0, 1, 0x20
animation_frame_C460DC:
    db 8
    frame_oam_tile 0, 0x10, 0x2203, 0x20
    frame_oam_tile 0xF0, 0x10, 0x2003, 0x20
    frame_oam_tile 0, 0, 0x203, 0x20
    frame_oam_tile 0xF0, 0, 3, 0x20
    frame_oam_tile 0, 0xF0, 0x2201, 0x20
    frame_oam_tile 0xF0, 0xF0, 0x2001, 0x20
    frame_oam_tile 0, 0xE0, 0x201, 0x20
    frame_oam_tile 0xF0, 0xE0, 1, 0x20
animation_frame_C46105:
    db 8
    frame_oam_tile 0, 0x10, 0x2603, 0x20
    frame_oam_tile 0xF0, 0x10, 0x2403, 0x20
    frame_oam_tile 0, 0, 0x603, 0x20
    frame_oam_tile 0xF0, 0, 0x403, 0x20
    frame_oam_tile 0, 0xF0, 0x2601, 0x20
    frame_oam_tile 0xF0, 0xF0, 0x2401, 0x20
    frame_oam_tile 0, 0xE0, 0x601, 0x20
    frame_oam_tile 0xF0, 0xE0, 0x401, 0x20
animation_frame_C4612E:
    db 0xE
    frame_oam_tile 8, 0x18, 0x3303, 0
    frame_oam_tile 0, 0x18, 0x3203, 0
    frame_oam_tile 0xF8, 0x18, 0x3103, 0
    frame_oam_tile 0xF0, 0x18, 0x3003, 0
    frame_oam_tile 8, 0x10, 0x2306, 0
    frame_oam_tile 0, 0x10, 0x2206, 0
    frame_oam_tile 0xF8, 0x10, 0x2106, 0
    frame_oam_tile 0xF0, 0x10, 0x2006, 0
    frame_oam_tile 0, 0, 0x206, 0x20
    frame_oam_tile 0xF0, 0, 6, 0x20
    frame_oam_tile 0, 0xF0, 0x2204, 0x20
    frame_oam_tile 0xF0, 0xF0, 0x2004, 0x20
    frame_oam_tile 0, 0xE0, 0x204, 0x20
    frame_oam_tile 0xF0, 0xE0, 4, 0x20
animation_frame_C46175:
    db 8
    frame_oam_tile 0, 0x10, 0x2607, 0x20
    frame_oam_tile 0xF0, 0x10, 0x2407, 0x20
    frame_oam_tile 0, 0, 0x606, 0x20
    frame_oam_tile 0xF0, 0, 0x406, 0x20
    frame_oam_tile 0, 0xF0, 0x2604, 0x20
    frame_oam_tile 0xF0, 0xF0, 0x2404, 0x20
    frame_oam_tile 0, 0xE0, 0x604, 0x20
    frame_oam_tile 0xF0, 0xE0, 0x404, 0x20
animation_frame_C4619E:
    db 0xC
    frame_oam_tile 8, 0, 0x307, 0
    frame_oam_tile 0, 0, 0x207, 0
    frame_oam_tile 0, 8, 0x2207, 0
    frame_oam_tile 0xF8, 0x10, 0x2107, 0x20
    frame_oam_tile 0xF8, 8, 0x1107, 0
    frame_oam_tile 0xF8, 0, 0x107, 0
    frame_oam_tile 0, 0xF0, 0x2205, 0x20
    frame_oam_tile 0xF8, 0xF8, 0x3105, 0
    frame_oam_tile 0xF8, 0xF0, 0x2105, 0
    frame_oam_tile 0xF0, 0xF0, 0x2005, 0
    frame_oam_tile 0, 0xE0, 0x205, 0x20
    frame_oam_tile 0xF0, 0xE0, 5, 0x20
animation_frame_C461DB:
    db 8
    frame_oam_tile 0, 0x10, 0x2607, 0x20
    frame_oam_tile 0xF0, 0x10, 0x2407, 0x20
    frame_oam_tile 0, 0, 0x607, 0x20
    frame_oam_tile 0xF0, 0, 0x407, 0x20
    frame_oam_tile 0, 0xF0, 0x2605, 0x20
    frame_oam_tile 0xF0, 0xF0, 0x2405, 0x20
    frame_oam_tile 0, 0xE0, 0x605, 0x20
    frame_oam_tile 0xF0, 0xE0, 0x405, 0x20
animation_frame_C46204:
    db 2
    frame_oam_tile 0, 0xF8, 0x2606, 0x20
    frame_oam_tile 0xF0, 0xF8, 0x2406, 0x20
animation_frame_C4620F:
    db 0x18
    frame_oam_tile 0x38, 8, 0x1002, 0
    frame_oam_tile 0x38, 0, 2, 0
    frame_oam_tile 0x38, 0xF8, 0x3000, 0
    frame_oam_tile 0x28, 8, 0x3106, 0
    frame_oam_tile 0x20, 8, 0x3006, 0
    frame_oam_tile 0x20, 0xF8, 0x500, 0x20
    frame_oam_tile 0x10, 8, 0x302, 0
    frame_oam_tile 0x10, 0, 0x3300, 0
    frame_oam_tile 0x10, 0xF8, 0x2300, 0
    frame_oam_tile 8, 8, 0x3307, 0
    frame_oam_tile 8, 0, 0x2307, 0
    frame_oam_tile 8, 0xF8, 0x1307, 0
    frame_oam_tile 0xF8, 8, 0x2007, 0
    frame_oam_tile 0xF0, 8, 7, 0
    frame_oam_tile 0xF8, 0, 0x1007, 0
    frame_oam_tile 0xF0, 0, 0x3005, 0
    frame_oam_tile 0xF8, 0xF8, 0x3306, 0
    frame_oam_tile 0xF0, 0xF8, 0x3206, 0
    frame_oam_tile 0xE0, 8, 0x3106, 0
    frame_oam_tile 0xD8, 8, 0x3006, 0
    frame_oam_tile 0xC8, 8, 0x1700, 0
    frame_oam_tile 0xC0, 8, 0x700, 0
    frame_oam_tile 0xD8, 0xF8, 0x500, 0x20
    frame_oam_tile 0xC0, 0xF8, 0x300, 0x20
byte_C46288:
    db 1
    animation_frame animation_frame_C4608A, 0xFF
byte_C4628D:
    db 1
    animation_frame animation_frame_C460B3, 0xFF
byte_C46292:
    db 1
    animation_frame animation_frame_C460DC, 0xFF
byte_C46297:
    db 1
    animation_frame animation_frame_C46105, 0xFF
byte_C4629C:
    db 1
    animation_frame animation_frame_C4612E, 0xFF
byte_C462A1:
    db 1
    animation_frame animation_frame_C46175, 0xFF
byte_C462A6:
    db 1
    animation_frame animation_frame_C4619E, 0xFF
byte_C462AB:
    db 1
    animation_frame animation_frame_C461DB, 0xFF
byte_C462B0:
    db 1
    animation_frame animation_frame_C46204, 0xFF
byte_C462B5:
    db 1
    animation_frame animation_frame_C4620F, 0xFF
sub_C462BA:
i16
    REP #0x20
    LDA #0x5000
    STA a:addr(unk_7E0E5C) ; orig=0x0E5C
    LDA #0
    STA a:addr(unk_7E0E5A) ; orig=0x0E5A
    LDA #0x5000
    STA a:addr(unk_7E0E9C) ; orig=0x0E9C
    LDA #0
    STA a:addr(unk_7E0E9A) ; orig=0x0E9A
    SEP #0x20
    PHX
    LDX #0xD40
    STZ z:6,X
    STZ z:7,X
    STZ z:5,X
    LDA #0x20
    STA z:0xE,X
    STZ z:0x1F,X
    REP #0x20
    STZ z:0x1A,X
    STZ z:0x1C,X
    JSL sub_C4774A
    SEP #0x20
    LDX #0xD80
    STZ z:6,X
    STZ z:7,X
    LDA #1
    STA z:5,X
    LDA #0x20
    STA z:0xE,X
    LDA #2
    STA z:0x1F,X
    REP #0x20
    STZ z:0x1A,X
    STZ z:0x1C,X
    JSL sub_C4774A
    SEP #0x20
    LDX #0xDC0
    STZ z:6,X
    LDA #2
    STA z:5,X
    LDA #0x20
    STA z:0xE,X
    LDA #0xA
    STA z:0x1F,X
    JSL sub_C4774A
    SEP #0x20
    LDX #0xE00
    STZ z:6,X
    LDA #3
    STA z:5,X
    LDA #0x20
    STA z:0xE,X
    LDA #8
    STA z:0x1F,X
    JSL sub_C4774A
    PLX
    RTL

sub_C4633F:
i16
    JSL stage_related_init
    JSL sub_C462BA
    SEP #0x20
    LDA #0x31
    STA a:addr(current_screen) ; orig=0x00A4
    LDA #0x31
    STA a:addr(level_manager_object.fade_related_) ; orig=0x0D10
    STZ a:addr(game_flags) ; orig=0x0314
    JMP a:addr(sub_C46896)

sub_C46359:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x41
    BEQ .loc_C46365
    JMP a:addr(nullsub_C463DD)

.loc_C46365:
    SEP #0x20
    LDA z:0x10,X
    CMP #0x34
    BEQ .loc_C46388
    CMP #0x35
    BEQ .loc_C46388
    CMP #0x36
    BEQ .loc_C46388
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #3
    BNE .loc_C46388
    LDA z:0x25,X
    CMP #2
    BCS .loc_C46388
    STZ z:0x35,X
    JMP a:addr(sub_C463DE)
    RTL

.loc_C46388:
    SEP #0x20
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #2
    BNE sub_C463A5
    LDA z:0x32,X
    BNE sub_C463A5
    STZ z:0x35,X
    REP #0x20
    LDA #addr(sub_C4667D)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C4667D)
    STA z:2,X
    RTL

sub_C463A5:
    JSL sub_C466D8
    SEP #0x20
    LDX #0xD00
    LDA a:addr(current_screen) ; orig=0x00A4
    CMP z:0x10,X
    BEQ nullsub_C463DD
    LDA a:addr(level_manager_object.fade_related_) ; orig=0x0D10
    STA a:addr(level_manager_object.anonymous_2) ; orig=0x0D16
    LDA a:addr(level_manager_object.level_representation) ; orig=0x0D24
    STA a:addr(level_manager_object.anonymous_2+1) ; orig=0x0D17
    LDA a:addr(current_screen) ; orig=0x00A4
    STA z:0x10,X
    LDA #0x80
    STA a:addr(game_flags) ; orig=0x0314
    LDA #0xF
    STA a:addr(word_7E031A) ; orig=0x031A
    REP #0x20
    LDA #addr(sub_C46872)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C46872)
    STA z:2,X
    ; fallthrough

nullsub_C463DD:
    RTL

sub_C463DE:
    REP #0x20
    LDA #addr(.loc_C46406)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C46406)
    STA z:2,X
    JSL sub_C4669F
    BCS nullsub_C463DD
    REP #0x20
    LDA #INVINCIBILITY_FRAMES
    STA z:player.invincibility_countdown,X
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    ORA #4
    STA a:addr(game_flags) ; orig=0x0314
    STZ a:addr(level_manager_object.anonymous_9) ; orig=0x0D35
    RTL

.loc_C46406:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x41
    BEQ .loc_C46412
    JMP a:addr(nullsub_C463DD)

.loc_C46412:
    SEP #0x20
    INC z:0x35,X
    LDA z:0x35,X
    CMP #0xFF
    BEQ .loc_C46420
    JML nullsub_C463DD

.loc_C46420:
    STZ z:0x35,X
    PHX
    JSL sub_C4669F
    PLX
    BCC .loc_C4642E
    JML sub_C46662

.loc_C4642E:
    SEP #0x20
    LDY #7
    LDA #addr(BLACK_PALETTE)
    STA z:0x40
    LDA #1
    JSL palette_related
    LDA #2
    JSL palette_related
    LDA #3
    JSL palette_related
    LDA #4
    JSL palette_related
    LDA #5
    JSL palette_related
    LDA #6
    JSL palette_related
    LDA #7
    JSL palette_related
    LDA #8
    JSL palette_related
    LDA #9
    JSL palette_related
    LDA #0xA
    JSL palette_related
    LDA #0xB
    JSL palette_related
    LDA #0xC
    JSL palette_related
    LDA #0xD
    JSL palette_related
    LDA #0xF
    JSL palette_related
    REP #0x20
    LDA #addr(.loc_C46498)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C46498)
    STA z:2,X

.loc_C46498:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x41
    BEQ .loc_C464A4
    JMP a:addr(nullsub_C463DD)

.loc_C464A4:
    SEP #0x20
    INC z:0x35,X
    LDA z:0x35,X
    CMP #0x40
    BEQ .loc_C464B2
    JML nullsub_C463DD

.loc_C464B2:
    JSL sub_C4245D
    REP #0x20
    LDA #addr(.loc_C464C6)
    STA a:addr(level_manager_object+object.handler) ; orig=0x0D00
    SEP #0x20
    LDA #bank(.loc_C464C6)
    STA a:addr(level_manager_object+object.handler+2) ; orig=0x0D02
    RTL

.loc_C464C6:
    JSL sub_C4669F
    SEP #0x20
    INC z:6,X
    LDA z:6,X
    STA a:addr(level_manager_object.anonymous_1) ; orig=0x0D12
    LDA z:5,X
    STA a:addr(level_manager_object.anonymous_1+1) ; orig=0x0D13
    JSL sub_C55C7F
    REP #0x20
    LDA #0x42D8
    STA z:0x40
    LDA #0
    STA z:0x42
    JSL sub_C465EB
    REP #0x20
    LDA #0x42E0
    STA z:0x40
    LDA #1
    STA z:0x42
    JSL sub_C465EB
    REP #0x20
    LDA #0x42E8
    STA z:0x40
    LDA #2
    STA z:0x42
    JSL sub_C465EB
    REP #0x20
    LDA #addr(.loc_C465A9)
    STA z:0x50
    SEP #0x20
    LDA #bank(.loc_C465A9)
    STA z:0x52
    JSL sub_C62514
    REP #0x20
    LDX #0xD00
    LDA #8
    STA z:0x3E,X
    LDA #0
    STA a:addr(bg3_v_scroll) ; orig=0x0CA5
    SEP #0x20
    LDY #0
    LDA #0x40
    STA z:0x40
    LDA #0xC
    JSL palette_related
    LDA #0x41
    STA z:0x40
    LDA #0xD
    JSL palette_related
    LDA #0x79
    STA z:0x40
    LDA #0xE
    JSL palette_related
    LDA f:palette_allocation_related_array+8
    STA z:0x40
    LDA #8
    JSL palette_related
    LDA f:palette_allocation_related_array+9
    STA z:0x40
    LDA #9
    JSL palette_related
    STZ a:addr(player_1.gameover_related) ; orig=0x0D44
    STZ a:addr(player_2.gameover_related) ; orig=0x0D84
    STZ a:addr(player_3.gameover_related) ; orig=0x0DC4
    STZ a:addr(player_4.gameover_related) ; orig=0x0E04
    REP #0x20
    LDA #addr(.loc_C46582)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C46582)
    STA z:2,X
    RTL

.loc_C46582:
    REP #0x20
    LDA z:0x3E,X
    CLC
    ADC #0x10
    STA z:0x3E,X
    STA a:addr(bg3_v_scroll) ; orig=0x0CA5
    CMP #0xE8
    BNE .locret_C465A8
    SEP #0x20
    LDA #6
    STA a:addr(current_mode) ; orig=0x0C3C
    REP #0x20
    LDA #addr(sub_C46359)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C46359)
    STA z:2,X

.locret_C465A8:
    RTL

.loc_C465A9:
    REP #0x20
    LDA #0x5CC0
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x600
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(scoreboard_tilemap)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(scoreboard_tilemap)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    RTL

sub_C465CB:
    REP #0x20
    LDA z:0x40
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x10
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA z:0x53
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA z:0x55
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    RTL
    
sub_C465EB:
    SEP #0x20
    LDA #low(.loc_C46616)
    STA z:0xDB
    LDA #high(.loc_C46616)
    STA z:0xDC
    LDA #bank(.loc_C46616)
    STA z:0xDD
    LDA #0x80
    STA z:0xD3
    JSL create_object
    BCS .locret_C46615
    REP #0x20
    LDA z:0x40
    STA a:addr(0x30),Y
    LDA z:0x42
    STA a:addr(0x32),Y
    LDA #4
    STA a:addr(0x20),Y

.locret_C46615:
    RTL

.loc_C46616:
    REP #0x20
    DEC z:0x20,X
    BNE .locret_C46655
    INC z:0x32,X
    LDA z:0x32,X
    CMP #3
    BNE .loc_C4662A
    LDA #0
    STA z:0x32,X

.loc_C4662A:
    ASL A
    ASL A
    PHX
    TAX
    LDA f:.byte_C46656,X
    STA z:0x53
    LDA f:.byte_C46656+1,X
    STA z:0x54
    PLX
    LDA #8
    STA z:0x20,X
    LDA z:0x30,X
    STA z:0x40
    REP #0x20
    LDA #addr(sub_C465CB)
    STA z:0x50
    SEP #0x20
    LDA #bank(sub_C465CB)
    STA z:0x52
    JSL sub_C62514

.locret_C46655:
    RTL

.byte_C46656:
    dw 0x5DB7, 0x00C1
    dw 0x5DC7, 0x00C1
    dw 0x5DD7, 0x00C1

sub_C46662:
    SEP #0x20
    LDX #addr(level_manager_object)
    LDA #0x3A
    STA a:addr(current_screen) ; orig=0x00A4
    STZ a:addr(current_mode) ; orig=0x0C3C
    REP #0x20
    LDA #addr(sub_C46359)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C46359)
    STA z:2,X
    RTL

sub_C4667D:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    BIT #0x41
    BEQ .loc_C46689
    JMP a:addr(nullsub_C463DD)

.loc_C46689:
    SEP #0x20
    INC z:0x35,X
    LDA z:0x35,X
    CMP #0x40
    BEQ .loc_C46697
    JML nullsub_C463DD

.loc_C46697:
    LDA #0x37
    STA a:addr(current_screen) ; orig=0x00A4
    JMP a:addr(sub_C463A5)

sub_C4669F:
    REP #0x20
    LDX #0xD40

.loc_C466A4:
    LDA z:4,X
    BIT #1
    BEQ .loc_C466B2
    LDA z:0x2F,X
    AND #0xFF
    BEQ .loc_C466BF

.loc_C466B2:
    TXA
    CLC
    ADC #0x40
    TAX
    CMP #addr(player_4 + player.sizeof)
    BNE .loc_C466A4
    SEC
    RTL

.loc_C466BF:
    CLC
    RTL
sub_C466C1:
    SEP #0x20
    LDA z:0x40
    LSR A
    EOR #0xFF
    AND #0xF
    STA z:0x42
    LDA z:0x40
    CLC
    ADC a:addr(word_7E031A) ; orig=0x031A
    STA a:addr(word_7E031A) ; orig=0x031A
    CMP z:0x42
    RTL

sub_C466D8:
    SEP #0x20
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #3
    BNE .loc_C466E5
    JML .loc_C467EE

.loc_C466E5:
    CMP #2
    BEQ .loc_C466ED
    JML .loc_C467DF

.loc_C466ED:
    LDA z:0x32,X
    CMP #1
    BEQ .loc_C466F7
    JML .loc_C467DF

.loc_C466F7:
    LDY #0xD40
    LDX #0xD80
    LDA a:addr(4),Y
    BEQ .loc_C46708
    LDY #0xD80
    LDX #0xD40

.loc_C46708:
    LDA a:addr(0x22),Y
    ORA a:addr(0x23),Y
    BIT #0xC0
    BNE .loc_C46739
    LDA a:addr(0x23),Y
    BIT #0x10
    BNE .loc_C4671D
    JML .loc_C467DF

.loc_C4671D:
    TYA
    PHY
    LDY #0
    BIT #0x40
    BNE .loc_C46729
    LDY #2

.loc_C46729:
    LDA #0x10
    STA a:addr(0xCF1),Y
    LDA #0
    STA a:addr(0xCF8),Y
    LDA #0
    STA a:addr(0xCF9),Y
    PLY

.loc_C46739:
    LDA #0
    XBA
    LDA z:0x3D,X
    BNE .loc_C46744
    JML .loc_C467DF

.loc_C46744:
    PHX
    TAX
    LDA f:.byte_C467E3,X
    STA z:0x40
    PLX
    LDA z:0x3D,X
    SEC
    SBC z:0x40
    STA z:0x3D,X
    LDA z:0x40
    DEC A
    STA a:addr(0x3D),Y
    LDA #0xFF
    STA a:addr(4),Y
    REP #0x20
    LDA #0
    STA a:addr(0x1A),Y
    LDA #0
    STA a:addr(0x1C),Y
    LDA #0x5000
    STA a:addr(0x11C),Y
    LDA #0
    STA a:addr(0x11A),Y
    SEP #0x20
    PHY
    LDA a:addr(5),Y
    STA z:0x40
    LDY #0x46
    LDA z:0x40
    BEQ .loc_C4678B
    LDY #0x68

.loc_C4678B:
    REP #0x20
    LDA #0xB
    STA z:0x40
    REP #0x20
    LDA #addr(storymode_hud_tilemap+0x46)
    STA z:0x50
    SEP #0x20
    LDA #bank(storymode_hud_tilemap+0x46)
    STA z:0x52
    JSL copy_to_bg3_tilemap
    REP #0x20
    TYA
    CLC
    ADC #0x2A
    TAY
    LDA #0xB
    STA z:0x40
    REP #0x20
    LDA #addr(storymode_hud_tilemap+0x86)
    STA z:0x50
    SEP #0x20
    LDA #bank(storymode_hud_tilemap+0x86)
    STA z:0x52
    JSL copy_to_bg3_tilemap
    PLY
    PHY
    JSL draw_number_of_lives
    PLY
    TYX
    REP #0x20
    LDA #addr(init_player_handler)
    STA z:0,X
    SEP #0x20
    LDA #bank(init_player_handler)
    STA z:2,X
    STZ z:7,X
    JSL draw_number_of_lives
    INC a:addr(level_manager_object.gameover_related) ; orig=0x0D32

.loc_C467DF:
    LDX #addr(level_manager_object)
    RTL
.byte_C467E3:
    db 0, 1, 1, 2, 2, 3, 3, 4
    db 4, 5, 5

.loc_C467EE:
    LDX #0xD40

.loc_C467F1:
    REP #0x20
    LDA z:5,X
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA a:addr(0xCF0),X
    PLX
    BIT #0xC0C0
    BEQ .loc_C46861
    LDA z:5,X
    AND #0xFF
    PHX
    TAX
    LDA f:byte_C3092C,X
    AND #0xFF
    STA z:0x40
    LDA a:addr(0xC5F),X
    BIT #2
    BEQ .loc_C4686F
    SEP #0x20
    LDA #0
    STA a:addr(0xC5F),X
    PLX
    REP #0x20
    LDA z:5,X
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:byte_C30930,X
    PLX
    LDY z:0x40
    STA a:addr(0x816),Y
    INC A
    STA a:addr(0x818),Y
    CLC
    ADC #0xF
    STA a:addr(0x856),Y
    INC A
    STA a:addr(0x858),Y
    REP #0x20
    LDA #addr(init_player_handler)
    STA z:0,X
    SEP #0x20
    LDA #bank(init_player_handler)
    STA z:2,X
    LDA #0xFF
    STA z:4,X
    INC a:addr(level_manager_object.gameover_related) ; orig=0x0D32
    INC a:addr(level_manager_object.enemy_count) ; orig=0x0D25
    INC a:addr(level_manager_object.number_of_human_players) ; orig=0x0D36

.loc_C46861:
    REP #0x20
    TXA
    CLC
    ADC #0x40
    TAX
    CMP #addr(player_4 + player.sizeof)
    BNE .loc_C467F1
    RTL

.loc_C4686F:
    PLX
    BRA .loc_C46861

sub_C46872:
    SEP #0x20
    LDA #0xFF
    STA z:0x40
    JSL sub_C466C1
    LDA z:0x38,X
    BIT #1
    BEQ .loc_C46890
    LDA a:addr(word_7E031A) ; orig=0x031A
    AND #0xF
    ASL A
    ASL A
    ASL A
    ASL A
    EOR #0xFF
    STA a:addr(byte_7E0CA9) ; orig=0x0CA9

.loc_C46890:
    LDA a:addr(word_7E031A) ; orig=0x031A
    BEQ sub_C46896
    RTL

sub_C46896:
    REP #0x20
    LDA #addr(screen_load_related)
    STA a:addr(level_manager_object+object.handler) ; orig=0x0D00
    SEP #0x20
    LDA #bank(screen_load_related)
    STA a:addr(level_manager_object+object.handler+2) ; orig=0x0D02
    REP #0x20
    LDA #0x3FF
    STA a:addr(bg3_v_scroll) ; orig=0x0CA5
    STZ a:addr(number_of_visible_bonuses) ; orig=0x0C91
    JSL stage_related_init
    SEP #0x20
    STZ a:addr(byte_7E0CA9) ; orig=0x0CA9
    STZ a:addr(byte_7E0C3E) ; orig=0x0C3E
    LDA #8
    STA a:addr(bg1_h_scroll) ; orig=0x0C9D
    LDA #0
    STA a:addr(bg1_h_scroll+1) ; orig=0x0C9E
    LDA #0
    STA a:addr(word_7E031A) ; orig=0x031A
    LDY #0
    LDA #addr(BLACK_PALETTE)
    STA z:0x40
    LDA #0
    JSL palette_related
    LDA #1
    JSL palette_related
    LDA #2
    JSL palette_related
    LDA #3
    JSL palette_related
    LDA #4
    JSL palette_related
    LDA #5
    JSL palette_related
    LDA #6
    JSL palette_related
    LDA #7
    JSL palette_related
    LDA #0xF
    STA z:0x40
    LDA #8
    JSL palette_related
    LDA #9
    JSL palette_related
    LDA #0xA
    JSL palette_related
    LDA #0xB
    JSL palette_related
    LDA #0xC
    JSL palette_related
    LDA #0xD
    JSL palette_related
    LDA #0xE
    JSL palette_related
    LDA #0xF
    JSL palette_related
    RTL

screen_load_related:
i16
    SEP #0x20
    LDA #0x8F
    STA a:addr(SCREEN_DISPLAY_REGISTER)
    LDA #bank(stage_1_1)
    STA z:0x52
    JSL sub_C62007
    REP #0x20
    LDA z:0x10,X
    AND #0xFF
    ASL A
    TAX
    LDA f:screens_table,X
    STA z:0x50
    LDA f:[z:0x50]
    STA a:addr(level_manager_object.anonymous_5) ; orig=0x0D1C
    INC z:0x50
    INC z:0x50
    LDX #0xD00
    LDA f:[z:0x50]
    STA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    INC z:0x50
    INC z:0x50
    STA z:0x30,X
    STA a:addr(current_mode) ; orig=0x0C3C
    CMP #6
    BNE .loc_C4697E
    JML menu_screens_related

.loc_C4697E:
    CMP #1
    BNE .loc_C46987
    JML menu_screens_related

.loc_C46987:
    LDA f:[z:0x50]
    STA a:addr(level_manager_object.anonymous_10) ; orig=0x0D3A
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDX #0
    LDA #0x2000
    STA z:0x40
    JSL graphics_decompression_81aa_terminated_interleaved
    REP #0x20
    LDA #0x1C00
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x800
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(byte_7E3400)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(byte_7E3400)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDX #0xC00
    LDA #0x2000
    STA z:0x40
    JSL graphics_decompression_81aa_terminated_interleaved
    JSL sub_C47C58
    REP #0x20
    LDA #0
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x2000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDX #0
    LDA #0x2000
    STA z:0x40
    JSL graphics_decompression_81aa_terminated_interleaved
    REP #0x20
    LDA #0x2000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x2000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDX #0
    LDA #0x2000
    STA z:0x40
    REP #0x20
    LDA #addr(bonuses_graphic)
    STA z:0x53
    SEP #0x20
    LDA #bank(bonuses_graphic)
    STA z:0x55
    JSL graphics_decompression_81aa_terminated_interleaved
    REP #0x20
    LDA #0x1000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1800
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    JSL sub_C47B11
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    JSL sub_C47B33
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    JSL sub_C47A8D
    SEP #0x20
    LDA f:[z:0x50]
    STA a:addr(level_manager_object.level_representation) ; orig=0x0D24
    JSL level_initialization_related
    JSL hud_related_0
    JSL sub_C61C7B
    JSL sub_C61690
    REP #0x20
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x48    ; hard_blocks
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:addr(level_manager_object.soft_blocks) ; orig=0x0D3C
    INC z:0x50
    INC z:0x50
    JSL generate_hard_blocks_and_exit
    JSL call_screen_init_functions
    JSL copy_enemy_creation_functions
    JSL process_bonuses
    JSL related_to_enemy_bonuses
    REP #0x20
    LDA #addr(unk_7F0670)
    STA z:0x59
    SEP #0x20
    LDA #bank(unk_7F0670)
    STA z:0x5B
    JSL generate_soft_blocks
    JSL create_enemies
    REP #0x20
    LDA #addr(~(PLAYER|0x6000))
    JSL apply_mask_to_collision_map
    JSL sub_C42702
    SEP #0x20
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #3
    BNE .loc_C46B2A
    JML sub_C46E2A

.loc_C46B2A:
    REP #0x20
    LDA #addr(off_C47087)
    STA z:0x53
    SEP #0x20
    LDA #bank(off_C47087)
    STA z:0x55
    JSL graphics_decompression_8192_bytes
    REP #0x20
    LDA #0x7000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDA #addr(splash_graphics)
    STA z:0x53
    SEP #0x20
    LDA #bank(splash_graphics)
    STA z:0x55
    JSL graphics_decompression_8192_bytes
    REP #0x20
    LDA #0x7800
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    SEP #0x20
    LDA #0xF
    STA a:addr(word_7E031A) ; orig=0x031A
    LDA #0x1F
    STA a:addr(bg1_v_scroll) ; orig=0x0C9F
    LDA #3
    STA a:addr(bg1_v_scroll+1) ; orig=0x0CA0
    LDA #0x20
    STA a:addr(level_manager_object.anonymous_6) ; orig=0x0D20
    LDY #4
    LDA #0
    STA z:0x40
    LDA #0
    JSL palette_related
    LDY #0
    LDA #addr(SPLASH_PALETTE)
    STA z:0x40
    LDA #8
    JSL palette_related
    REP #0x20
    LDA #0
    STA a:addr(unknown_object+0x20) ; orig=0x0FE0
    LDA #0x3FF
    STA a:addr(unknown_object+0x22) ; orig=0x0FE2
    LDA a:addr(unknown_object+0x22) ; orig=0x0FE2
    STA a:addr(bg3_v_scroll_2) ; orig=0x0CA7
    REP #0x20
    LDA #addr(sub_C46C0B)
    STA a:addr(level_manager_object+object.handler) ; orig=0x0D00
    SEP #0x20
    LDA #bank(sub_C46C0B)
    STA a:addr(level_manager_object+object.handler+2) ; orig=0x0D02
    SEP #0x20
    LDA #bank(stage_intro_music_list)
    STA z:0x52
    REP #0x20
    LDA a:addr(level_manager_object.level_representation) ; orig=0x0D24
    AND #0xF0
    LSR A
    LSR A
    LSR A
    LSR A
    CLC
    ADC #addr(stage_intro_music_list)
    STA z:0x50
    LDA f:[z:0x50]
    AND #0xFF
    TAY
    JSL play_music
    RTL

stage_intro_music_list:
    db 0, 0xD, 0x1E, 0x20, 0x22, 0x24, 0x26
sub_C46C0B:
    SEP #0x20
    DEC z:0x20,X
    BEQ .loc_C46C15
    JML nullsub_C463DD

.loc_C46C15:
    REP #0x20
    LDA #0x830
    STA z:0xE,X
    LDA #0xFFD0
    STA z:0x11,X
    LDA #0x50
    STA z:0x14,X
    REP #0x20
    LDA #addr(.loc_C46C33)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C46C33)
    STA z:2,X

.loc_C46C33:
    REP #0x20
    LDA z:0x11,X
    CLC
    ADC #0x10
    STA z:0x11,X
    BMI .loc_C46C5C
    CMP #0x50
    BCC .loc_C46C5C
    LDA #0x50
    STA z:0x11,X
    SEP #0x20
    LDA #0x20
    STA z:0x21,X
    REP #0x20
    LDA #addr(sub_C46C61)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C46C61)
    STA z:2,X

.loc_C46C5C:
    JSL sub_C46FD8
    RTL

sub_C46C61:
    SEP #0x20
    DEC z:0x21,X
    BEQ .loc_C46C6B
    JML .loc_C46CBB

.loc_C46C6B:
    JSL sub_C4757D
    REP #0x20
    LDA #addr(.loc_C46C7C)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C46C7C)
    STA z:2,X

.loc_C46C7C:
    SEP #0x20
    LDA #0x1F
    STA z:0x20,X
    REP #0x20
    LDA #addr(.loc_C46C8F)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C46C8F)
    STA z:2,X

.loc_C46C8F:
    SEP #0x20
    LDA z:0x20,X
    CLC
    ADC #8
    CMP #0xE8
    STA z:0x20,X
    BCC .loc_C46CB1
    LDA #0xE7
    STA z:0x20,X
    LDA #0x40
    STA z:0x21,X
    REP #0x20
    LDA #addr(sub_C46CC0)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C46CC0)
    STA z:2,X

.loc_C46CB1:
    LDA z:0x20,X
    STA a:addr(bg1_v_scroll) ; orig=0x0C9F
    LDA #3
    STA a:addr(bg1_v_scroll+1) ; orig=0x0CA0

.loc_C46CBB:
    JSL sub_C46FD8
    RTL

sub_C46CC0:
    SEP #0x20
    DEC z:0x21,X
    BEQ .loc_C46CCA
    JML sub_C46C61.loc_C46CBB

.loc_C46CCA:
    REP #0x20
    LDA #addr(.loc_C46CD7)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C46CD7)
    STA z:2,X

.loc_C46CD7:
    REP #0x20
    LDA z:0x11,X
    CLC
    ADC #0x10
    STA z:0x11,X
    CMP #0x150
    BCC sub_C46C61.loc_C46CBB
    REP #0x20
    LDA a:addr(level_manager_object.fade_related_) ; orig=0x0D10
    AND #0xFF
    ASL A
    TAX
    LDA f:screen_music_table,X
    AND #0xFF
    TAY
    JSL play_music

sub_C46CFC:
    JSL sub_C475A1
    SEP #0x20
    LDA #0x7F
    STA z:0x55
    REP #0x20
    LDA #0x600
    STA z:0x53
    JSL graphics_decompression_8192_bytes
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300

.loc_C46D16:
    CMP a:addr(frame_count) ; orig=0x0300
    BEQ .loc_C46D16
    LDA #0
    STA a:addr(H_DMA_CHANNEL_ENABLE)
    REP #0x20
    LDA #0x6000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    JSL graphics_decompression_8192_bytes
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300

.loc_C46D4A:
    CMP a:addr(frame_count) ; orig=0x0300
    BEQ .loc_C46D4A
    LDA #0
    STA a:addr(H_DMA_CHANNEL_ENABLE)
    REP #0x20
    LDA #0x6800
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    JSL graphics_decompression_8192_bytes
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300

.loc_C46D7E:
    CMP a:addr(frame_count) ; orig=0x0300
    BEQ .loc_C46D7E
    LDA #0
    STA a:addr(H_DMA_CHANNEL_ENABLE)
    REP #0x20
    LDA #0x7000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    JSL graphics_decompression_8192_bytes
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300

.loc_C46DB2:
    CMP a:addr(frame_count) ; orig=0x0300
    BEQ .loc_C46DB2
    LDA #0
    STA a:addr(H_DMA_CHANNEL_ENABLE)
    REP #0x20
    LDA #0x7800
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    JSL sub_C61F91
    REP #0x20
    LDA #addr(sub_C46DF1)
    STA a:addr(level_manager_object+object.handler) ; orig=0x0D00
    SEP #0x20
    LDA #bank(sub_C46DF1)
    STA a:addr(level_manager_object+object.handler+2) ; orig=0x0D02
    RTL

sub_C46DF1:
    SEP #0x20
    LDA a:addr(game_flags) ; orig=0x0314
    AND #8
    STA a:addr(game_flags) ; orig=0x0314
    STZ a:addr(level_manager_object.current_screen) ; orig=0x0D3F
    REP #0x20
    LDA #addr(sub_C46359)
    STA a:addr(level_manager_object+object.handler) ; orig=0x0D00
    SEP #0x20
    LDA #bank(sub_C46359)
    STA a:addr(level_manager_object+object.handler+2) ; orig=0x0D02
    RTL

sub_C46E0E:
    SEP #0x20
    STZ a:addr(word_7E0CAE+1) ; orig=0x0CAF
    JSL random2
    SEP #0x20
    BIT #1
    BNE .locret_C46E29
    JSL random2
    SEP #0x20
    AND #1
    INC A
    STA a:addr(word_7E0CAE+1) ; orig=0x0CAF

.locret_C46E29:
    RTL

sub_C46E2A:
i16
    JSL sub_C46E0E
    REP #0x20
    LDA f:[z:0x50]
    STA a:addr(main_screen_status) ; orig=0x0C97
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:addr(color_addition_settings) ; orig=0x0C99
    INC z:0x50
    INC z:0x50
    LDA #0xE0
    STA a:addr(FIXED_COLOR_DATA)
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:addr(bg2_h_scroll) ; orig=0x0CA1
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:addr(bg2_v_scroll) ; orig=0x0CA3
    SEP #0x20
    LDA #0
    STA a:addr(word_7E031A) ; orig=0x031A
    LDA #0xE7
    STA a:addr(bg1_v_scroll) ; orig=0x0C9F
    LDA #3
    STA a:addr(bg1_v_scroll+1) ; orig=0x0CA0
    LDA #0x20
    STA a:addr(level_manager_object.anonymous_6+1) ; orig=0x0D21
    LDY #0
    LDA #0
    STA z:0x40
    LDA #0
    JSL palette_related
    SEP #0x20
    LDA #8
    STA a:addr(game_flags) ; orig=0x0314
    JSL sub_C4757D
    JSL sub_C46CFC
    REP #0x20
    LDA #addr(sub_C46EBD)
    STA a:addr(level_manager_object+object.handler) ; orig=0x0D00
    SEP #0x20
    LDA #bank(sub_C46EBD)
    STA a:addr(level_manager_object+object.handler+2) ; orig=0x0D02
    SEP #0x20
    LDA a:addr(level_manager_object.anonymous_2) ; orig=0x0D16
    INC A
    CMP a:addr(level_manager_object.fade_related_) ; orig=0x0D10
    BEQ .locret_C46EBC
    REP #0x20
    LDA a:addr(level_manager_object.fade_related_) ; orig=0x0D10
    AND #0xFF
    ASL A
    TAX
    LDA f:screen_music_table,X
    AND #0xFF
    TAY
    JSL play_music

.locret_C46EBC:
    RTL

sub_C46EBD:
    SEP #0x20
    LDA #1
    STA z:0x40
    JSL sub_C466C1
    BEQ .loc_C46ECD
    JML nullsub_C463DD

.loc_C46ECD:
    REP #0x20
    LDA #addr(.loc_C46EDA)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C46EDA)
    STA z:2,X

.loc_C46EDA:
    SEP #0x20
    DEC z:0x21,X
    BEQ .loc_C46EE4
    JML nullsub_C463DD

.loc_C46EE4:
    LDA #0
    STA a:addr(game_flags) ; orig=0x0314
    REP #0x20
    LDA #addr(sub_C46359)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C46359)
    STA z:2,X
    RTL

hud_related_0:
i16
    REP #0x20
    LDA a:addr(level_manager_object.anonymous_8) ; orig=0x0D30
    CMP #3
    BEQ .loc_C46F4C
    CMP #1
    BEQ .loc_C46F3A
    REP #0x20
    LDA #addr(storymode_hud_tilemap)
    STA z:0x53
    SEP #0x20
    LDA #bank(storymode_hud_tilemap)
    STA z:0x55
    JSL sub_C46FC9
    REP #0x20
    LDX #addr(player_1)
    STZ z:0x40
    STZ z:0x42
    JSL add_to_score_if_allowed
    JSL draw_number_of_lives
    REP #0x20
    LDX #addr(player_2)
    STZ z:0x40
    STZ z:0x42
    JSL add_to_score_if_allowed
    JSL draw_number_of_lives
    RTL

.loc_C46F3A:
    REP #0x20
    LDA #addr(empty_tilemap)
    STA z:0x53
    SEP #0x20
    LDA #bank(empty_tilemap)
    STA z:0x55
    JSL sub_C46FC9
    RTL

.loc_C46F4C:
    REP #0x20
    LDA #addr(battlemode_hud_tilemap)
    STA z:0x53
    SEP #0x20
    LDA #bank(battlemode_hud_tilemap)
    STA z:0x55
    JSL sub_C46FC9
    LDX #0xD40
    REP #0x20

.loc_C46F62:
    LDA z:5,X
    AND #0xFF
    PHX
    TAX
    LDA a:addr(word_7E0C5F),X
    STA z:0x40
    LDA f:byte_C3092C,X
    PLX
    AND #0xFF
    STA z:0x42
    LDA z:0x40
    BIT #2
    BEQ .loc_C46FA0
    LDA z:5,X
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:byte_C30940,X
    PLX
    LDY z:0x42
    STA a:addr(bg3_tilemap),Y
    INC A
    STA a:addr(bg3_tilemap+2),Y
    CLC
    ADC #0xF
    STA a:addr(bg3_tilemap+0x40),Y
    INC A
    STA a:addr(bg3_tilemap+0x42),Y

.loc_C46FA0:
    LDY z:0x42
    INY
    INY
    INY
    INY
    LDA z:object.handler+6,X
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:hud_digits_tilenos_upper,X
    PLX
    STA a:addr(bg3_tilemap),Y
    CLC
    ADC #0x10
    STA a:addr(bg3_tilemap+0x40),Y
    TXA
    CLC
    ADC #0x40
    TAX
    CMP #addr(player_4 + player.sizeof)
    BNE .loc_C46F62
    RTL

sub_C46FC9:
i16
    REP #0x20
    LDY #0xFE

.loc_C46FCE:
    LDA f:[z:0x53],Y
    STA a:addr(bg3_tilemap),Y
    DEY
    DEY
    BPL .loc_C46FCE
    RTL

sub_C46FD8:
    SEP #0x20
    LDA #bank(word_C4709F)
    STA z:0x52
    REP #0x20
    LDA z:0x11,X
    PHA
    LDA z:0x14,X
    PHA
    LDA z:0x11,X
    CLC
    ADC #8
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0x10
    STA z:0x14,X
    LDA z:0x24,X
    AND #0xF0
    LSR A
    LSR A
    LSR A
    ADC #addr(word_C4709F)
    STA z:0x50
    LDA f:[z:0x50]
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    JSL sub_C625D3
    REP #0x20
    LDA z:0x11,X
    CLC
    ADC #0x30
    STA z:0x11,X
    LDA #addr(byte_C462B0)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    JSL sub_C625D3
    REP #0x20
    LDA z:0x11,X
    CLC
    ADC #0x30
    STA z:0x11,X
    LDA z:0x24,X
    AND #0xF
    ASL A
    ADC #addr(word_C4709F)
    STA z:0x50
    LDA f:[z:0x50]
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    JSL sub_C625D3
    REP #0x20
    LDA z:0x11,X
    SEC
    SBC #0x30
    STA z:0x11,X
    LDA z:0x14,X
    CLC
    ADC #0x30
    STA z:0x14,X
    LDA #addr(byte_C462B5)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    JSL sub_C625D3
    REP #0x20
    PLA
    STA z:0x14,X
    PLA
    STA z:0x11,X
    RTL

off_C47087:
    df splash_graphic_0
    df splash_graphic_1
    df splash_graphic_2
    df splash_graphic_3
splash_graphics:
    df splash_graphic_4
    df splash_graphic_5
    df splash_graphic_6
    df splash_graphic_7
word_C4709F:
    dw 0
    da byte_C46288
    da byte_C4628D
    da byte_C46292
    da byte_C46297
    da byte_C4629C
    da byte_C462A1
    da byte_C462A6
    da byte_C462AB
menu_screens_related:
i16
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDX #0
    LDA #0x2000
    STA z:0x40
    JSL graphics_decompression_81aa_terminated_interleaved
    REP #0x20
    LDA #0
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x2000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDX #0
    LDA #0x2000
    STA z:0x40
    JSL graphics_decompression_81aa_terminated_interleaved
    REP #0x20
    LDA #0x1000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x2000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDX #0
    LDA #0x2000
    STA z:0x40
    JSL graphics_decompression_81aa_terminated_interleaved
    REP #0x20
    LDA #0x2000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x2000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDX #0
    LDA #0x2000
    STA z:0x40
    JSL graphics_decompression_81aa_terminated_interleaved
    REP #0x20
    LDA #0x3000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x2000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    JSL sub_C47B11
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    JSL sub_C47B33
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    JSL sub_C47A8D
    JSL level_initialization_related
    JSL hud_related_0
    JSL sub_C61C7B
    JSL sub_C61690
    JSL call_screen_init_functions
    REP #0x20
    LDA #graphics_table - unk_7F0000
    STA z:0x53
    SEP #0x20
    LDA #bank(graphics_table)
    STA z:0x55
    LDA #0x10
    STA a:addr(game_flags) ; orig=0x0314
    LDA a:addr(level_manager_object.fade_related_) ; orig=0x0D10
    CMP #0x32
    BEQ .loc_C4720F
    CMP #0x39
    BEQ .loc_C4720F
    LDA #0
    STA a:addr(game_flags) ; orig=0x0314

.loc_C4720F:
    JSL graphics_decompression_8192_bytes
    REP #0x20
    LDA #0x6000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    JSL graphics_decompression_8192_bytes
    REP #0x20
    LDA #0x6800
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    JSL graphics_decompression_8192_bytes
    REP #0x20
    LDA #0x7000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    JSL graphics_decompression_8192_bytes
    REP #0x20
    LDA #0x7800
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    SEP #0x20
    LDY #0
    LDA #0
    STA z:0x40
    LDA #0
    JSL palette_related
    LDA #0
    STA a:addr(word_7E031A) ; orig=0x031A
    LDA #0xE7
    STA a:addr(bg1_v_scroll) ; orig=0x0C9F
    LDA #3
    STA a:addr(bg1_v_scroll+1) ; orig=0x0CA0
    JSL sub_C4757D
    JSL sub_C475A1
    REP #0x20
    LDA #addr(sub_C472EF)
    STA a:addr(level_manager_object+object.handler) ; orig=0x0D00
    SEP #0x20
    LDA #bank(sub_C472EF)
    STA a:addr(level_manager_object+object.handler+2) ; orig=0x0D02
    REP #0x20
    LDA a:addr(level_manager_object.fade_related_) ; orig=0x0D10
    AND #0xFF
    ASL A
    TAX
    LDA f:screen_music_table,X
    AND #0xFF
    TAY
    JSL play_music
    RTL

sub_C472EF:
    SEP #0x20
    LDA #1
    STA z:0x40
    JSL sub_C466C1
    BEQ .loc_C472FF
    JML nullsub_C463DD

.loc_C472FF:
    REP #0x20
    LDA #addr(sub_C46359)
    STA z:0,X
    SEP #0x20
    LDA #bank(sub_C46359)
    STA z:2,X
    RTL

sub_C4730D:
i16
    REP #0x20
    PHX
    LDA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    BIT #0x200
    BEQ .loc_C4731C
    JSL sub_C47560

.loc_C4731C:
    SEP #0x20
    LDA a:addr(level_manager_object.anonymous_8) ; orig=0x0D30
    PHA
    LDA #3
    STA a:addr(level_manager_object.anonymous_8) ; orig=0x0D30
    LDA #bank(stage_1_1)
    STA z:0x52
    REP #0x20
    LDA z:0x40
    AND #0xFF
    ASL A
    TAX
    LDA f:screens_table+0x7A,X
    STA z:0x50
    LDA f:[z:0x50]
    STA a:addr(level_manager_object.anonymous_5) ; orig=0x0D1C
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    INC z:0x50
    INC z:0x50
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:addr(level_manager_object.anonymous_10) ; orig=0x0D3A
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDX #0
    LDA #0x2000
    STA z:0x40
    JSL graphics_decompression_81aa_terminated_interleaved
    REP #0x20
    INC z:0x50
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    LDA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    BIT #0x4000
    BEQ .loc_C473A4
    REP #0x20
    LDA #addr(empty_tilemap)
    STA z:0x53
    SEP #0x20
    LDA #bank(empty_tilemap)
    STA z:0x55

.loc_C473A4:
    REP #0x20
    LDX #0x1000
    LDA #0x2002
    STA z:0x40
    JSL graphics_decompression_81aa_terminated_interleaved
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    JSL sub_C47B33
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    JSL tilemap_decompression
    JSL sub_C61C7B
    JSL sub_C61690
    REP #0x20
    INC z:0x50
    INC z:0x50
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:addr(level_manager_object.soft_blocks) ; orig=0x0D3C
    INC z:0x50
    INC z:0x50
    INC z:0x50
    INC z:0x50
    INC z:0x50
    JSL sub_C4753D
    JSL call_screen_init_functions
    JSL copy_enemy_creation_functions
    JSL process_bonuses
    REP #0x20
    LDA z:0x46
    STA z:0x48
    JSL related_to_enemy_bonuses
    REP #0x20
    LDA #addr(unk_7F0670)
    STA z:0x59
    SEP #0x20
    LDA #bank(unk_7F0670)
    STA z:0x5B
    JSL generate_soft_blocks
    REP #0x20
    LDA z:0x50
    PHA
    LDA z:0x51
    PHA
    JSL sub_C4757D
    JSL update_palettes
    REP #0x20
    PLA
    STA z:0x51
    PLA
    STA z:0x50
    LDA #addr(~(PLAYER|0x6000))
    JSL apply_mask_to_collision_map
    JSL sub_C42702
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300

.loc_C4744E:
    CMP a:addr(frame_count) ; orig=0x0300
    BEQ .loc_C4744E
    LDA #0
    STA a:addr(H_DMA_CHANNEL_ENABLE)
    SEP #0x20
    LDA #0x8F
    STA a:addr(SCREEN_DISPLAY_REGISTER)
    LDY #6
    LDA f:[z:0x50],Y
    STA a:addr(bg2_h_scroll) ; orig=0x0CA1
    STA a:addr(BG_2_H_SCROLL_OFFSET)
    INY
    LDA f:[z:0x50],Y
    STA a:addr(bg2_h_scroll+1) ; orig=0x0CA2
    STA a:addr(BG_2_H_SCROLL_OFFSET)
    INY
    LDA f:[z:0x50],Y
    STA a:addr(bg2_v_scroll) ; orig=0x0CA3
    STA a:addr(BG_2_V_SCROLL_OFFSET)
    INY
    LDA f:[z:0x50],Y
    STA a:addr(bg2_v_scroll+1) ; orig=0x0CA4
    STA a:addr(BG_2_V_SCROLL_OFFSET)
    REP #0x20
    LDY #0
    LDA f:[z:0x50],Y
    STA a:addr(main_screen_status) ; orig=0x0C97
    LDY #2
    LDA f:[z:0x50],Y
    STA a:addr(color_addition_settings) ; orig=0x0C99
    LDY #4
    LDA f:[z:0x50],Y
    STA a:addr(FIXED_COLOR_DATA)
    JSL sub_C62460
    REP #0x20
    LDA #0
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0xC00
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDA #0x2400
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x400
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(unk_7E4000)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(unk_7E4000)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDA #0x5000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x322
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(bg1_tilemap)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #0
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDA #0x5400
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x800
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(unexpanded_collision_map)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(unexpanded_collision_map)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    SEP #0x20
    LDA #0x60
    STA z:0x40

.loc_C4752D:
    DEC z:0x40
    BNE .loc_C4752D
    LDA a:addr(word_7E031A) ; orig=0x031A
    STA a:addr(SCREEN_DISPLAY_REGISTER)
    PLA
    STA a:addr(level_manager_object.anonymous_8) ; orig=0x0D30
    PLX
    RTL

sub_C4753D:
i16
    REP #0x20
    PHX
    LDX #0xF00

.loc_C47543:
    TXA
    CLC
    ADC #0x40
    CMP #0x1C40
    BEQ .loc_C4755E
    TAX
    LDA z:3,X
    AND #0xFF
    CMP #2
    BNE .loc_C47543
    JSL delete_object
    BRA .loc_C47543

.loc_C4755E:
    PLX
    RTL

sub_C47560:
i16
    REP #0x20
    LDX #0xF40

.loc_C47565:
    LDA z:0,X
    CMP #addr(bonus_handling_object)
    BEQ .loc_C47576
    LDA z:6,X
    CMP #0xFFFF
    BEQ nullsub_C4757C
    TAX
    BRA .loc_C47565

.loc_C47576:
    JSL delete_object
    BRA sub_C47560
    ; fallthrough
nullsub_C4757C:
    RTL

sub_C4757D:
    REP #0x20
    LDA #addr(palette_allocation_related_array)
    STA z:0x53
    SEP #0x20
    LDA #bank(palette_allocation_related_array)
    STA z:0x55
    REP #0x20
    INC z:0x53
    LDA #1
    STA z:0x42
    LDA a:addr(level_manager_object.anonymous_5) ; orig=0x0D1C
    STA z:0x44
    LSR z:0x44
    LDA #8
    STA z:0x46
    BRA sub_C475C8

sub_C475A1:
i16
    REP #0x20
    LDA #addr(palette_allocation_related_array)
    STA z:0x53
    SEP #0x20
    LDA #bank(palette_allocation_related_array)
    STA z:0x55
    REP #0x20
    LDA #addr(palette_allocation_related_array)
    CLC
    ADC #8
    STA z:0x53
    LDA #8
    STA z:0x42
    LDA a:addr(level_manager_object.anonymous_5+1) ; orig=0x0D1D
    STA z:0x44
    LDA #0x10
    STA z:0x46

sub_C475C8:
    REP #0x20
    LDY #6
    ROR z:0x44
    BCS .loc_C475D4
    LDY #0

.loc_C475D4:
    SEP #0x20
    LDA f:[z:0x53]
    STA z:0x40
    LDA z:0x42
    JSL palette_related
    REP #0x20
    INC z:0x53
    INC z:0x42
    LDA z:0x42
    CMP z:0x46
    BNE sub_C475C8
    RTL

stage_related_init:
i16
    REP #0x20
    STZ a:addr(free_offset_in_object_pointer_array) ; orig=0x00BA
    LDA #0x64
    STA a:addr(max_object_pointer_object) ; orig=0x00BC
    LDY #0
    LDX #addr(unknown_object)

.loc_C475FE:
    TXA
    STA a:addr(object_pointer_array),Y
    INY
    INY
    STZ z:0,X
    STZ z:2,X
    TXA
    CLC
    ADC #player.sizeof
    TAX
    CMP #addr(unk_7E1C40)
    BNE .loc_C475FE
    LDA #0
    STA a:addr(unk_7E0F44) ; orig=0x0F44
    LDA #0
    STA a:addr(word_7E0F42+1) ; orig=0x0F43
    LDA #addr(unk_7E0F80)
    STA a:addr(word_7E0F46) ; orig=0x0F46
    REP #0x20
    LDA #addr(gameover_writing_object)
    STA a:addr(enemy_objects) ; orig=0x0F40
    SEP #0x20
    LDA #bank(gameover_writing_object)
    STA a:addr(word_7E0F42) ; orig=0x0F42
    REP #0x20
    LDX #addr(unk_7E0F80)
    LDA #addr(enemy_objects)
    STA z:4,X
    LDA #0xFFFF
    STA z:6,X
    REP #0x20
    LDA #addr(hud_related_object)
    STA z:0,X
    SEP #0x20
    LDA #bank(hud_related_object)
    STA z:2,X
    LDA #0xFE
    STA z:3,X
    REP #0x20
    LDX #0xD00
    SEP #0x20
    LDA #low(handle_pause)
    STA z:0xDB
    LDA #high(handle_pause)
    STA z:0xDC
    LDA #bank(handle_pause)
    STA z:0xDD
    LDA #0x80
    STA z:0xD3
    JSL create_object
    REP #0x20
    STZ a:addr(word_7E0078) ; orig=0x0078
    LDA #0x2C
    STA a:addr(word_7E007A) ; orig=0x007A
    LDY #0
    LDX #0x1CC0

.loc_C47680:
    TXA
    STA a:addr(unk_7E04C4),Y
    INY
    INY
    STZ z:0,X
    TXA
    CLC
    ADC #0x20
    TAX
    CMP #addr(unk_7E1F80)
    BNE .loc_C47680
    LDX #addr(unk_7E1C80)
    LDA #addr(nullsub_C4757C)
    STA z:0,X
    LDA #0
    STA z:4,X
    LDA #0x1CA0
    STA z:6,X
    LDX #0x1CA0
    LDA #0
    STA z:0,X
    LDA #0x1C80
    STA z:4,X
    LDA #0xFFFF
    STA z:6,X
    STZ z:0x40
    LDX #0x1F80
    LDY #0x10

.loc_C476BF:
    LDA #0xFF
    STA z:0,X
    LDA z:0x40
    STA z:4,X
    INX
    INX
    INX
    INX
    INX
    INX
    INX
    INX
    LDA z:0x40
    CLC
    ADC #0x20
    STA z:0x40
    DEY
    BNE .loc_C476BF
    REP #0x20
    LDA #addr(init_player_handler)
    STA a:addr(player_1+object.handler) ; orig=0x0D40
    SEP #0x20
    LDA #bank(init_player_handler)
    STA a:addr(player_1+object.handler+2) ; orig=0x0D42
    REP #0x20
    LDA #addr(init_player_handler)
    STA a:addr(player_2+object.handler) ; orig=0x0D80
    SEP #0x20
    LDA #bank(init_player_handler)
    STA a:addr(player_2+object.handler+2) ; orig=0x0D82
    REP #0x20
    LDA #addr(init_player_handler)
    STA a:addr(player_3+object.handler) ; orig=0x0DC0
    SEP #0x20
    LDA #bank(init_player_handler)
    STA a:addr(player_3+object.handler+2) ; orig=0x0DC2
    REP #0x20
    LDA #addr(init_player_handler)
    STA a:addr(player_4+object.handler) ; orig=0x0E00
    SEP #0x20
    LDA #bank(init_player_handler)
    STA a:addr(player_4+object.handler+2) ; orig=0x0E02
    LDA #0
    STA a:addr(player_1.current_bomb_count) ; orig=0x0D64
    LDA #0
    STA a:addr(player_2.current_bomb_count) ; orig=0x0DA4
    LDA #0
    STA a:addr(player_3.current_bomb_count) ; orig=0x0DE4
    LDA #0
    STA a:addr(player_4.current_bomb_count) ; orig=0x0E24
    LDA #0
    STA a:addr(word_7E0E48) ; orig=0x0E48
    LDA #0
    STA a:addr(word_7E0E88) ; orig=0x0E88
    LDA #0
    STA a:addr(word_7E0EC8) ; orig=0x0EC8
    LDA #0
    STA a:addr(word_7E0F08) ; orig=0x0F08
    LDA #0
    STA a:addr(player_3.gameover_related) ; orig=0x0DC4
    LDA #0
    STA a:addr(player_4.gameover_related) ; orig=0x0E04
    RTL

sub_C4774A:
    REP #0x20
    STZ z:0x30,X
    STZ z:0x32,X
    STZ z:0x34,X
    STZ z:0x36,X
    STZ z:0x38,X
    STZ z:0x3A,X
    STZ z:0x3B,X
    RTL

sub_C4775B:
    SEP #0x20
    LDA z:0x31,X
    AND #0x7F
    STA z:0x31,X
    DEC z:0x32,X
    BPL .loc_C47769
    STZ z:0x32,X

.loc_C47769:
    STZ z:0x33,X
    STZ z:0x38,X
    STZ z:0x39,X
    RTL

sub_C47770:
    REP #0x20
    LDA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    BIT #0x10
    BNE .loc_C477AB
    BIT #0x100
    BNE .loc_C477D2
    BIT #8
    BNE .loc_C477F9
    LDA #0x100
    STA z:0x30,X
    LDA #1
    STA z:0x32,X
    STZ z:0x34,X
    LDA #0
    STA z:0x36,X
    STZ z:0x38,X
    STZ z:0x3A,X
    STZ z:0x3B,X
    LDA #0
    STA a:addr(0x130),X
    LDA #0
    STA a:addr(0x132),X
    STZ a:addr(0x134),X
    RTL

.loc_C477AB:
    LDA #0x100
    STA z:0x30,X
    LDA #6
    STA z:0x32,X
    STZ z:0x34,X
    LDA #0
    STA z:0x36,X
    STZ z:0x38,X
    STZ z:0x3A,X
    STZ z:0x3B,X
    LDA #0
    STA a:addr(0x130),X
    LDA #0
    STA a:addr(0x132),X
    STZ a:addr(0x134),X
    RTL

.loc_C477D2:
    LDA #0x905
    STA z:0x30,X
    LDA #3
    STA z:0x32,X
    STZ z:0x34,X
    STZ z:0x36,X
    LDA #0x300
    STA z:0x38,X
    STZ z:0x3A,X
    STZ z:0x3B,X
    LDA #0
    STA a:addr(0x130),X
    LDA #0
    STA a:addr(0x132),X
    STZ a:addr(0x134),X
    RTL

.loc_C477F9:
    LDA #0x100
    STA z:0x30,X
    LDA #1
    STA z:0x32,X
    STZ z:0x34,X
    LDA #0
    STA z:0x36,X
    STZ z:0x38,X
    STZ z:0x3A,X
    STZ z:0x3B,X
    LDA #0
    STA a:addr(0x130),X
    LDA #0
    STA a:addr(0x132),X
    STZ a:addr(0x134),X
    RTL

byte_C47820:
    db 0x28, 0, 0x18, 0, 0, 0, 0xFF, 0
    db 0xE8, 0, 0xB8, 0, 2, 2, 0xFF, 1
    db 0xE8, 0, 0x18, 0, 8, 8, 0xFF, 2
    db 0x28, 0, 0xB8, 0, 0xA, 0xA, 0xFF, 3
byte_C47840:
    db 0x68, 0, 0x58, 0, 0, 0, 0xFF, 0
    db 0xA8, 0, 0x78, 0, 2, 2, 0xFF, 1
    db 0xA8, 0, 0x58, 0, 8, 8, 0xFF, 2
    db 0x68, 0, 0x78, 0, 0xA, 0xA, 0xFF, 3
    db 0x48, 0, 0x38, 0, 0, 0, 0xFF, 0
    db 0xC8, 0, 0x98, 0, 2, 2, 0xFF, 1
    db 0xC8, 0, 0x38, 0, 8, 8, 0xFF, 2
    db 0x48, 0, 0x98, 0, 0xA, 0xA, 0xFF, 3
    db 0x28, 0, 0x18, 0, 0, 0, 0xFF, 0
    db 0xE8, 0, 0x18, 0, 2, 2, 0xFF, 1
    db 0x28, 0, 0x38, 0, 0, 0, 0xFF, 0
    db 0xE8, 0, 0x38, 0, 2, 2, 0xFF, 1
byte_C478A0:
    db 0, 0, 0, 0, 0, 0, 1, 1
    db 0, 1, 1, 1, 1, 1, 2, 2
    db 1, 2, 2, 2, 2, 2, 3, 3
    db 2, 3, 3, 3, 3, 3, 4, 4
    db 3, 4, 4, 4, 4, 4, 4, 4
level_initialization_related:
i16
    SEP #0x20
    STZ a:addr(level_manager_object.enemy_count) ; orig=0x0D25
    STZ a:addr(player_1.is_ai) ; orig=0x0D47
    STZ a:addr(player_2.is_ai) ; orig=0x0D87
    STZ a:addr(player_3.is_ai) ; orig=0x0DC7
    STZ a:addr(player_4.is_ai) ; orig=0x0E07
    LDA #0x20
    STA a:addr(player_1.palette) ; orig=0x0D4E
    LDA #0x20
    STA a:addr(player_2.palette) ; orig=0x0D8E
    LDA #0x20
    STA a:addr(player_3.palette) ; orig=0x0DCE
    LDA #0x20
    STA a:addr(player_4.palette) ; orig=0x0E0E
    STZ a:addr(player_1.palette+1) ; orig=0x0D4F
    STZ a:addr(player_2.palette+1) ; orig=0x0D8F
    STZ a:addr(player_3.palette+1) ; orig=0x0DCF
    STZ a:addr(player_4.palette+1) ; orig=0x0E0F
    LDA #0
    STA a:addr(player_1.real_palette) ; orig=0x0D5F
    LDA #2
    STA a:addr(player_2.real_palette) ; orig=0x0D9F
    LDA #0xA
    STA a:addr(player_3.real_palette) ; orig=0x0DDF
    LDA #8
    STA a:addr(player_4.real_palette) ; orig=0x0E1F
    LDA a:addr(current_mode) ; orig=0x0C3C
    CMP #3
    BEQ .loc_C47918
    JML .locret_C47A28

.loc_C47918:
    STZ a:addr(player_1.gameover_related) ; orig=0x0D44
    STZ a:addr(player_2.gameover_related) ; orig=0x0D84
    STZ a:addr(player_3.gameover_related) ; orig=0x0DC4
    STZ a:addr(player_4.gameover_related) ; orig=0x0E04
    LDA a:addr(level_manager_object.gameover_related) ; orig=0x0D32
    CLC
    ADC a:addr(level_manager_object.gameover_related+1) ; orig=0x0D33
    STA a:addr(level_manager_object.enemy_count) ; orig=0x0D25
    LDA a:addr(level_manager_object.gameover_related) ; orig=0x0D32
    STA a:addr(level_manager_object.number_of_human_players) ; orig=0x0D36
    LDA a:addr(level_manager_object.gameover_related+1) ; orig=0x0D33
    STA a:addr(level_manager_object.number_of_ai_players) ; orig=0x0D37
    LDA #bank(byte_C47820)
    STA z:0x5E
    REP #0x20
    LDA #addr(byte_C47820)
    STA z:0x5C
    LDA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    BIT #0x208
    BEQ .loc_C47952
    LDA #addr(byte_C47840)
    STA z:0x5C

.loc_C47952:
    REP #0x20
    LDA z:0x53
    PHA
    LDA z:0x50
    PHA
    LDA z:0x51
    PHA
    LDA #0xC5F
    STA z:0x53
    LDX #0xD40
    LDY #0

.loc_C47968:
    SEP #0x20
    LDA [z:0x53]
    BEQ .loc_C479A8
    CMP #2
    BNE .loc_C47976
    JML .loc_C479CC

.loc_C47976:
    REP #0x20
    LDA #addr(handle_player_movement_0)
    STA z:0,X
    SEP #0x20
    LDA #bank(handle_player_movement_0)
    STA z:2,X
    LDA #1
    STA z:7,X
    LDA a:addr(word_7E0C63) ; orig=0x0C63
    ASL A
    ASL A
    STA z:0x40
    LDA #0
    XBA
    LDA z:5,X
    SEC
    SBC a:addr(level_manager_object.gameover_related) ; orig=0x0D32
    SEC
    SBC #3
    EOR #0xFF
    INC A
    ORA z:0x40
    PHX
    TAX
    LDA f:byte_C478A0,X
    PLX
    STA z:0x3D,X

.loc_C479A8:
    SEP #0x20
    LDA #0xFF
    STA z:4,X
    REP #0x20
    LDA f:[z:0x5C],Y
    STA z:0x11,X
    INY
    INY
    LDA f:[z:0x5C],Y
    STA z:0x14,X
    INY
    INY
    INY
    INY
    INY
    INY
    TYA
    LSR A
    LSR A
    LSR A
    DEC A
    STA a:addr(0x13E),X
    JSL sub_C47770
.loc_C479CC:
    REP #0x20
    TXA
    CLC
    ADC #0x40
    TAX
    INC z:0x53
    LDA z:0x53
    CMP #0xC63
    BEQ .loc_C479E1
    JML .loc_C47968

.loc_C479E1:
    LDX #0xD40
    LDA #0xC5F
    STA z:0x53

.loc_C479E9:
    LDA [z:0x53]
    BIT #2
    BEQ .loc_C47A0C
    LDA f:[z:0x5C],Y
    STA z:0x11,X
    INY
    INY
    LDA f:[z:0x5C],Y
    STA z:0x14,X
    INY
    INY
    INY
    INY
    INY
    INY
    TYA
    LSR A
    LSR A
    LSR A
    DEC A
    STA a:addr(0x13E),X
    JSL sub_C47770

.loc_C47A0C:
    TXA
    CLC
    ADC #0x40
    TAX
    INC z:0x53
    LDA z:0x53
    CMP #0xC63
    BEQ .loc_C47A1F
    JML .loc_C479E9

.loc_C47A1F:
    PLA
    STA z:0x51
    PLA
    STA z:0x50
    PLA
    STA z:0x53
.locret_C47A28:
    RTL

sub_C47A29:
    REP #0x20
    JSL tilemap_decompression
    LDA #0x5000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x800
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(unexpanded_collision_map)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(unexpanded_collision_map)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    RTL

sub_C47A4F:
i16
    REP #0x20
    JSL tilemap_decompression
    LDA #0x5000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x800
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(unexpanded_collision_map)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(unexpanded_collision_map)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDX #0
    LDY #0

.loc_C47A7C:
    LDA f:0x7E4800,X
    STA a:addr(bg1_tilemap),Y
    INX
    INX
    INY
    INY
    CPY #0x322
    BNE .loc_C47A7C
    RTL

sub_C47A8D:
    REP #0x20
    JSL tilemap_decompression
    LDA #0x5400
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x800
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(unexpanded_collision_map)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(unexpanded_collision_map)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    RTL

tilemap_decompression:
i16
    SEP #0x20
    LDA z:0x55
    PHA
    PLB
    REP #0x20
    LDY z:0x53
    PHX
    LDX #0
    LDA #1
    STA z:0x44

.loc_C47AC6:
    DEC z:0x44
    BNE .loc_C47AE0
    LDA #0x10
    STA z:0x44
    LDA #0
    STA z:0x46
    LDA #0
    STA z:0x48
    LDA a:addr(0),Y
    STA z:0x40
    INY
    INY

.loc_C47AE0:
    ASL z:0x40
    BCC .loc_C47AF2
    LDA a:addr(0),Y
    STA z:0x46
    INY
    INY
    LDA a:addr(0),Y
    STA z:0x48
    INY
    INY

.loc_C47AF2:
    LDA z:0x46
    STA f:0x7E4800,X
    LDA z:0x48
    STA f:0x7E4802,X
    INX
    INX
    INX
    INX
    CPX #0x800
    BNE .loc_C47AC6
    PLX
    SEP #0x20
    LDA #0
    PHA
    PLB
    REP #0x20
    RTL

sub_C47B11:
    REP #0x20
    LDA #0x5000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x800
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(empty_tilemap)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(empty_tilemap)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    RTL

sub_C47B33:
i16
    REP #0x20
    LDA a:addr(level_manager_object.fade_related_) ; orig=0x0D10
    AND #0xFF
    CMP #0x30
    BNE .loc_C47B44
    JML sub_C47A29

.loc_C47B44:
    CMP #0x39
    BNE .loc_C47B4D
    JML sub_C47A4F

.loc_C47B4D:
    PHX
    LDX #0
    LDA #1
    STA z:0x44

.loc_C47B56:
    DEC z:0x44
    BNE .loc_C47B67
    LDA #0x10
    STA z:0x44
    LDA f:[z:0x53]
    STA z:0x40
    INC z:0x53
    INC z:0x53

.loc_C47B67:
    LDA #0
    STA z:0x42
    ASL z:0x40
    BCC .loc_C47B75
    LDA #HARD_BLOCK
    STA z:0x42

.loc_C47B75:
    LDA z:0x42
    STA f:0x7E4800,X
    INX
    INX
    CPX #0x1C0
    BNE .loc_C47B56
    LDX #0
    LDA #1
    STA z:0x44
    LDA #0
    STA z:0x46
    LDA #0
    STA z:0x48

.loc_C47B94:
    DEC z:0x44
    BNE .loc_C47BA5
    LDA #0x10
    STA z:0x44
    LDA f:[z:0x53]
    STA z:0x40
    INC z:0x53
    INC z:0x53

.loc_C47BA5:
    ASL z:0x40
    BCC .loc_C47BB9
    LDA f:[z:0x53]
    STA z:0x46
    INC z:0x53
    INC z:0x53
    LDA f:[z:0x53]
    STA z:0x48
    INC z:0x53
    INC z:0x53

.loc_C47BB9:
    LDA z:0x46
    STA f:0x7E4A00,X
    LDA z:0x48
    STA f:0x7E4A02,X
    INX
    INX
    INX
    INX
    CPX #0x1BC
    BNE .loc_C47B94
    LDX #0
    LDY #0
    LDA #13    ; 13 rows
    STA z:0x44

.loc_C47BD9:        ; Expand the maps from 17 rows to 32 rows
    LDA #17
    STA z:0x42

.loc_C47BDE:
    LDA f:0x7E4A00,X
    STA a:addr(bg1_tilemap),Y
    STA a:addr(bg1_tilemap+0x20),Y
    LDA f:0x7E4800,X
    STA a:addr(collision_map),Y
    INX
    INX
    INY
    INY
    DEC z:0x42
    BNE .loc_C47BDE
    TYA
    CLC
    ADC #(32 - 17) * 2
    TAY
    DEC z:0x44
    BNE .loc_C47BD9
    PLX
    LDA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    BIT #0x8000
    BNE .loc_C47C25
    SEP #0x20
    LDA a:addr(level_manager_object.fade_related_) ; orig=0x0D10
    CMP #0x31
    BEQ .loc_C47C32
    REP #0x20
    LDA a:addr(bg1_tilemap+0x86) ; orig=0x057A ; The first (top left) hard block
    STA a:addr(bg1_tilemap+0x24) ; orig=0x0518 ; Special place in the tile map to store the Hard Block tile
    LDA a:addr(bg1_tilemap+0x44) ; orig=0x0538 ; The top left empty spot
    AND #0x1C00    ; Only take the palette. Shadow tiles are always:
         ; 4 for no shadow
         ; 5 for soft-block shadow
         ; 6 for hard-block shadow
    STA a:addr(bg1_tilemap+0x22) ; orig=0x0516 ; And another one for the empty tile.
    RTL

.loc_C47C25:
    LDA #0x804
    STA a:addr(bg1_tilemap+0x24) ; orig=0x0518 ; Special place in the tile map to store the Hard Block tile
    LDA #0x808
    STA a:addr(bg1_tilemap+0x22) ; orig=0x0516 ; And another one for the empty tile.
    RTL

.loc_C47C32:        ; clear screen AFTER ALL THE HARD WORK
    REP #0x20
    LDY #0
    LDA #13
    STA z:0x44

.loc_C47C3C:
    LDA #17
    STA z:0x42
    LDA #0

.loc_C47C44:
    STA a:addr(bg1_tilemap+0x20),Y
    INY
    INY
    DEC z:0x42
    BNE .loc_C47C44
    TYA
    CLC
    ADC #(32 - 17) * 2
    TAY
    DEC z:0x44
    BNE .loc_C47C3C
    RTL

sub_C47C58:
i16
    SEP #0x20
    LDA z:0x52
    PHA
    LDA #bank(byte_7E3400)
    STA z:0x52
    STA z:0x55
    LDA #0x60
    STA z:0x40
    REP #0x20
    LDA z:0x50
    PHA
    LDA #addr(byte_7E3400)
    STA z:0x50
    LDA #addr(byte_7E3400+0x10)
    STA z:0x53
    LDY #0xFFF0

.loc_C47C79:
    REP #0x20
    TYA
    CLC
    ADC #0x10
    TAY
    LDA z:0x40
    AND #0x11
    ASL A
    TAX
    LDA f:byte_C47F9E,X
    TAX
    SEP #0x20
    LDA #7
    STA z:0x41

.loc_C47C93:
    LDA f:[z:0x50],Y
    ORA f:[z:0x53],Y
    INY
    ORA f:[z:0x50],Y
    ORA f:[z:0x53],Y
    EOR #0xFF
    STA z:0x44
    STA z:0x45
    DEY
    REP #0x20
    LDA f:0x7E2800,X
    AND z:0x44
    ORA f:[z:0x50],Y
    STA f:[z:0x50],Y
    LDA f:0x7E2810,X
    AND z:0x44
    ORA f:[z:0x53],Y
    STA f:[z:0x53],Y
    SEP #0x20
    INY
    INY
    INX
    INX
    DEC z:0x41
    BPL .loc_C47C93
    INC z:0x40
    BNE .loc_C47C79
    REP #0x20
    PLA
    STA z:0x50
    SEP #0x20
    PLA
    STA z:0x52
    RTL

battle_stage_loader:
i16
    JSL sub_C46E0E
    SEP #0x20
    LDA #bank(stage_1_1)
    STA z:0x52
    REP #0x20
    LDA a:addr(level_manager_object.fade_related_) ; orig=0x0D10
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:screen_music_table,X
    AND #0xFF
    TAY
    JSL play_music
    REP #0x20
    LDA a:addr(level_manager_object.fade_related_) ; orig=0x0D10
    AND #0xFF
    ASL A
    TAX
    LDA f:screens_table,X
    STA z:0x50
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:addr(level_manager_object.spawn_and_flags) ; orig=0x0D38
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:addr(level_manager_object.anonymous_8) ; orig=0x0D30
    STA a:addr(current_mode) ; orig=0x0C3C
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:addr(level_manager_object.anonymous_10) ; orig=0x0D3A
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDX #0
    LDA #0x2000
    STA z:0x40
    JSL graphics_decompression_81aa_terminated_interleaved
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300

.loc_C47D48:
    CMP a:addr(frame_count) ; orig=0x0300
    BEQ .loc_C47D48
    LDA #0
    STA a:addr(H_DMA_CHANNEL_ENABLE)
    REP #0x20
    LDA #0x1C00
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x800
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(byte_7E3400)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(byte_7E3400)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDX #0xC00
    LDA #0x2000
    STA z:0x40
    JSL graphics_decompression_81aa_terminated_interleaved
    JSL sub_C47C58
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300

.loc_C47D9A:
    CMP a:addr(frame_count) ; orig=0x0300
    BEQ .loc_C47D9A
    LDA #0
    STA a:addr(H_DMA_CHANNEL_ENABLE)
    REP #0x20
    LDA #0x600
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1400
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(byte_7E3400)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(byte_7E3400)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    REP #0x20
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDX #0
    LDA #0x2000
    STA z:0x40
    JSL graphics_decompression_81aa_terminated_interleaved
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300

.loc_C47DE8:
    CMP a:addr(frame_count) ; orig=0x0300
    BEQ .loc_C47DE8
    LDA #0
    STA a:addr(H_DMA_CHANNEL_ENABLE)
    REP #0x20
    LDA #0x2000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300

.loc_C47E18:
    CMP a:addr(frame_count) ; orig=0x0300
    BEQ .loc_C47E18
    LDA #0
    STA a:addr(H_DMA_CHANNEL_ENABLE)
    REP #0x20
    LDA #0x2800
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(byte_7E3400+0x400)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(byte_7E3400+0x400)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    LDX #0xD00
    JSL level_initialization_related
    JSL hud_related_0
    REP #0x20
    LDA z:0x50
    CLC
    ADC #0xC
    STA z:0x50
    LDA f:[z:0x50]
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x54
    INC z:0x50
    INC z:0x50
    REP #0x20
    LDA z:0x50
    PHA
    JSL call_function_at_0053
    REP #0x20
    PLA
    STA z:0x50
    JSL sub_C475A1
    REP #0x20
    LDA z:0x50
    PHA
    LDA z:0x51
    PHA
    JSL update_palettes
    REP #0x20
    PLA
    STA z:0x51
    PLA
    STA z:0x50
    SEP #0x20
    LDA #bank(graphics_table)
    STA z:0x55
    REP #0x20
    LDA #graphics_table - unk_7F0000
    STA z:0x53
    JSL graphics_decompression_8192_bytes
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300

.loc_C47EA2:
    CMP a:addr(frame_count) ; orig=0x0300
    BEQ .loc_C47EA2
    LDA #0
    STA a:addr(H_DMA_CHANNEL_ENABLE)
    REP #0x20
    LDA #0x6000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    JSL graphics_decompression_8192_bytes
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300

.loc_C47ED6:
    CMP a:addr(frame_count) ; orig=0x0300
    BEQ .loc_C47ED6
    LDA #0
    STA a:addr(H_DMA_CHANNEL_ENABLE)
    REP #0x20
    LDA #0x6800
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    JSL graphics_decompression_8192_bytes
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300

.loc_C47F0A:
    CMP a:addr(frame_count) ; orig=0x0300
    BEQ .loc_C47F0A
    LDA #0
    STA a:addr(H_DMA_CHANNEL_ENABLE)
    REP #0x20
    LDA #0x7000
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    JSL graphics_decompression_8192_bytes
    SEP #0x20
    LDA a:addr(frame_count) ; orig=0x0300

.loc_C47F3E:
    CMP a:addr(frame_count) ; orig=0x0300
    BEQ .loc_C47F3E
    LDA #0
    STA a:addr(H_DMA_CHANNEL_ENABLE)
    REP #0x20
    LDA #0x7800
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x1000
    STA a:addr(DMA_4_BYTES_COUNT_LOW_BYTE)
    REP #0x20
    LDA #addr(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_LOW_BYTE)
    SEP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA a:addr(DMA_4_A_ADDRESS_BANK)
    JSL dma_related_
    JSL sub_C61F91
    PLX
    SEP #0x20
    LDA #0x20
    STA z:0x21,X
    LDA #0b11100000
    STA a:addr(FIXED_COLOR_DATA)
    LDA #8
    STA a:addr(game_flags) ; orig=0x0314
    REP #0x20
    LDA #addr(_screen_loader_object)
    STA z:object.handler,X
    SEP #0x20
    LDA #bank(_screen_loader_object)
    STA z:object.handler+2,X

_screen_loader_object:
    SEP #0x20
    DEC z:0x21,X
    BEQ .loc_C47F95
    JML nullsub_C463DD

.loc_C47F95:
    LDA #0
    STA a:addr(game_flags) ; orig=0x0314
    JML delete_object

byte_C47F9E:
    db 0, 1, 0x20, 1, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 3, 0x20, 3
data_end