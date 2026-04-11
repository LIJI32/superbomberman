segment "BANK6"

encode debug_menu, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.,:☺0123456789", 1
encode debug_menu, "{}[]-\" ", 0x30

encoding debug_menu

BG3_SCROLL_UNPAUSED = 0x3FF
BG3_SCROLL_PAUSED = 0x428

handle_pause:
i16
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_SCREEN_TRANSITION | GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_BATTLE_DELAY
    BNE .ret
    LDA z:pause_handler.state, X
    BEQ .idle
    JML animate_pause

.idle
    JSL should_toggle_pause
    BCS +
ifndef DEBUG
    JML .debug_ret
else
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_DEBUG_MENU
    BEQ .debug_ret
    JSL handle_debug_menu_input
    RTL
endif
+

    LDA a:addr(game_flags)
    EOR #GAME_FLAGS_PAUSED
    STA a:addr(game_flags)
    BIT #GAME_FLAGS_PAUSED
    BEQ .unpause
    
    LDY #SOUND_PAUSE
    JSL play_sound
    
    SEP #0x20
    LDA #PAUSE_HANDLER_STATE_OPENING
    STA z:pause_handler.state, X
    STZ z:pause_handler.state + 1, X
    LDA #low(BG3_SCROLL_UNPAUSED)
    STA z:pause_handler.scroll, X
    LDA #high(BG3_SCROLL_UNPAUSED)
    STA z:pause_handler.scroll + 1, X
    RTL

.unpause:
    LDA #PAUSE_HANDLER_STATE_CLOSING
    STA z:pause_handler.state, X

.ret:
    RTL

.debug_ret:
    RTL

animate_pause:
    REP #0x20
    LDA z:pause_handler.state, X
    BIT #PAUSE_HANDLER_STATE_OPENING
    BNE .opening
    
    LDA z:pause_handler.scroll, X
    SEC
    SBC #5
    CMP #BG3_SCROLL_UNPAUSED
    STA z:pause_handler.scroll, X
    BCS .done
    
    LDA #BG3_SCROLL_UNPAUSED ; Overflowed, cap the value
    STA z:pause_handler.scroll, X
    STZ z:pause_handler.state, X
    BRA .done
    RTL

.opening:
    LDA z:pause_handler.scroll, X
    CLC
    ADC #5
    
    CMP #BG3_SCROLL_PAUSED
    STA z:pause_handler.scroll, X
    BCC .done
    
    LDA #BG3_SCROLL_PAUSED ; Overflowed, cap the value
    STA z:pause_handler.scroll, X
    STZ z:pause_handler.state, X

.done:
    REP #0x20
    LDA z:pause_handler.scroll, X
    STA a:addr(bg3_v_scroll_2)
    RTL

should_toggle_pause:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_LEVEL_END
    BNE .ret_false
    LDA a:addr(current_mode)
    CMP #GAME_MODE_BATTLE
    BEQ +
    CMP #GAME_MODE_STORY
    BNE .ret_false
+

    LDA a:addr(level_manager_object.fade_related_)
    CMP #0x34
    BEQ .ret_false
    CMP #0x35
    BEQ .ret_false
    CMP #0x36
    BEQ .ret_false
    
    LDA #0
    XBA
    LDA #0
    STA z:0x40

.loop:
    TAY
    LDA a:addr(player_1.is_ai), Y
    BNE +
    LDA a:addr(player_1.unknown_flags), Y
    BEQ .continue
+
    TYA
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    PHY
    TAY
    LDA a:addr(joypad_1_pressed+1), Y
    PLY
    BIT #high(BUTTON_START | BUTTON_SELECT)
    BNE .ret_true

.continue:
    INC z:0x40
    TYA
    CLC
    ADC #player.sizeof
    BNE .loop

.ret_false:
    CLC
    RTL

.ret_true:
ifdef DEBUG
    BIT #high(BUTTON_SELECT)
    BNE toggle_debug
endif
    SEC
    RTL

toggle_debug:
    LDA a:addr(game_flags)
    EOR #GAME_FLAGS_DEBUG_MENU
    BIT #GAME_FLAGS_DEBUG_MENU
    BNE open_debug_menu
    JML close_debug_menu


DEBUG_MENU_LENGTH     = 19

open_debug_menu:
    ; Y = player index * 0x40
    REP #0x20
    TYA
    CLC
    ADC #addr(player_1)
    STA z:pause_handler.controlling_player, X
    LDA z:0x40
    PHA
    PHX
    JSL draw_debug_menu
    PLX
    JSL draw_debug_cursor
    REP #0x20
    PLA
    STA z:0x40
    REP #0x20
    LDA #addr(unk_7E21E6)
    STA z:0x53
    SEP #0x20
    LDA #bank(unk_7E21E6)
    STA z:0x53 + 2
    LDA z:0x40
    ORA #0x20
    STA f:[z:0x53]
    set_handler debug_menu_initializer
    RTL

debug_menu_initializer:
    set_handler handle_pause
    SEP #0x20
    LDA a:addr(game_flags)
    ORA #GAME_FLAGS_DEBUG_MENU
    STA a:addr(game_flags)
    JSL fill_debug_info
    SEP #0x20
    LDA a:addr(debug_cursor)
    PHA
    LDA #0
    STA a:addr(debug_cursor)

.loc_C60141:
    REP #0x20
    PHX
    LDA a:addr(debug_cursor)
    AND #0xFF
    TAX
    SEP #0x20
    LDA f:debug_menu_value_types, X
    STA z:0x40
    REP #0x20
    PLX
    SEP #0x20
    LDA z:0x40
    BEQ .on_off
    BIT #0x80
    BEQ +
    JML .enum
+

    BRA .number

.loop:
    SEP #0x20
    INC a:addr(debug_cursor)
    LDA a:addr(debug_cursor)
    CMP #DEBUG_MENU_LENGTH
    BNE .loc_C60141
    PLA
    STA a:addr(debug_cursor)
    RTL

.on_off:
    SEP #0x20
    JSL get_debug_data_addr
    LDA f:[z:0x50]
    JSL write_on_off
    JMP a:.loop

.enum:
    SEP #0x20
    JSL get_debug_data_addr
    LDA f:[z:0x50]
    JSL draw_speed_or_screen_name
    JMP a:.loop

.number:
    SEP #0x20
    JSL get_debug_data_addr
    LDA f:[z:0x50]
    JSL draw_number
    JMP a:.loop

get_debug_data_addr:
    SEP #0x20
    STZ z:0x52
    REP #0x20
    LDA a:addr(debug_cursor)
    AND #0xFF
    CLC
    ADC #addr(debug_menu_data)
    STA z:0x50
    SEP #0x20
    RTL

handle_debug_menu_input:
    SEP #0x20
    LDY z:0x10, X
    LDA a:0x22, Y
    BIT #0x30
    BNE .loc_C601C8
    INY
    INY
    INY
    INY

.loc_C601C8:
    PHY
    LDA a:0x22, Y
    BIT #0x80
    BEQ .loc_C6020E
    LDA a:addr(debug_cursor)
    CMP #0x11
    BNE .loc_C601EE
    REP #0x20
    PHX
    LDA a:addr(debug_bgm)
    AND #0xFF
    TAX
    LDA f:sounds_list, X
    PLX
    AND #0xFF
    TAY
    JSL play_music

.loc_C601EE:
    SEP #0x20
    LDA a:addr(debug_cursor)
    CMP #0x12
    BNE .loc_C6020E
    REP #0x20
    PHX
    LDA a:addr(debug_se)
    AND #0xFF
    TAX
    LDA f:musics_lists, X
    PLX
    AND #0xFF
    TAY
    JSL play_sound

.loc_C6020E:
    SEP #0x20
    PLY
    LDA a:0x23, Y
    STA z:0x4E
    AND #0xC
    BEQ .loc_C60247
    JSL clear_debug_cursor
    SEP #0x20
    LDA z:0x4E
    BIT #8
    BEQ .loc_C60235
    DEC a:addr(debug_cursor)
    BPL .loc_C60230
    LDA #0x12
    STA a:addr(debug_cursor)

.loc_C60230:
    JSL draw_debug_cursor
    RTL

.loc_C60235:
    INC a:addr(debug_cursor)
    LDA a:addr(debug_cursor)
    CMP #DEBUG_MENU_LENGTH
    BNE .loc_C60242
    STZ a:addr(debug_cursor)

.loc_C60242:
    JSL draw_debug_cursor

.locret_C60246:
    RTL

.loc_C60247:
    SEP #0x20
    LDA z:0x4E
    AND #3
    BEQ .locret_C60246
    REP #0x20
    PHX
    LDA a:addr(debug_cursor)
    AND #0xFF
    TAX
    SEP #0x20
    LDA f:debug_menu_value_types, X
    STA z:0x40
    REP #0x20
    PLX
    SEP #0x20
    LDA z:0x40
    BEQ .loc_C60274
    BIT #0x80
    BEQ .loc_C60272
    JML .loc_C602D3

.loc_C60272:
    BRA .loc_C60293

.loc_C60274:
    SEP #0x20
    STZ z:0x52
    REP #0x20
    LDA a:addr(debug_cursor)
    AND #0xFF
    CLC
    ADC #0xA4
    STA z:0x50
    SEP #0x20
    LDA f:[z:0x50]
    EOR #1
    STA f:[z:0x50]
    JSL write_on_off
    RTL

.loc_C60293:
    SEP #0x20
    STA z:0x40
    STZ z:0x52
    REP #0x20
    LDA a:addr(debug_cursor)
    AND #0xFF
    CLC
    ADC #0xA4
    STA z:0x50
    SEP #0x20
    LDA z:0x4E
    BIT #1
    BNE .loc_C602C1
    LDA f:[z:0x50]
    DEC A
    BPL .loc_C602CA
    DEC z:0x40
    LDA z:0x40
    STA f:[z:0x50]
    STA z:0x40
    JSL draw_number
    RTL

.loc_C602C1:
    LDA f:[z:0x50]
    INC A
    CMP z:0x40
    BNE .loc_C602CA
    LDA z:0

.loc_C602CA:
    STA f:[z:0x50]
    STA z:0x40
    JSL draw_number
    RTL

.loc_C602D3:
    SEP #0x20
    EOR #0xFF
    INC A
    STA z:0x40
    STZ z:0x52
    REP #0x20
    LDA a:addr(debug_cursor)
    AND #0xFF
    CLC
    ADC #0xA4
    STA z:0x50
    SEP #0x20
    LDA z:0x4E
    BIT #1
    BNE .loc_C602FF
    LDA f:[z:0x50]
    DEC A
    BPL .loc_C602FB
    DEC z:0x40
    LDA z:0x40

.loc_C602FB:
    STA f:[z:0x50]
    BRA .loc_C6030A

.loc_C602FF:
    LDA f:[z:0x50]
    INC A
    CMP z:0x40
    BNE .loc_C60308
    LDA #0

.loc_C60308:
    STA f:[z:0x50]

.loc_C6030A:
    JSL draw_speed_or_screen_name
    RTL

clear_debug_cursor:
    REP #0x20
    LDA #addr(unk_7E2020)
    STA z:0x53
    PHX
    SEP #0x20
    LDA #bank(unk_7E2020)
    STA z:0x53 + 2
    LDA a:addr(debug_cursor)
    CLC
    ADC #8
    REP #0x20
    AND #0xFF
    ASL A
    TAX
    LDA f:offsets_to_debug_menu_map, X
    CLC
    ADC z:0x53
    STA z:0x53
    SEP #0x20
    LDA #' '
    STA f:[z:0x53]
    REP #0x20
    PLX
    RTL

draw_debug_cursor:
    REP #0x20
    LDA #addr(unk_7E2020)
    STA z:0x53
    SEP #0x20
    LDA #bank(unk_7E2020)
    STA z:0x53 + 2
    PHX
    LDA a:addr(debug_cursor)
    CLC
    ADC #8
    REP #0x20
    AND #0xFF
    ASL A
    TAX
    LDA f:offsets_to_debug_menu_map, X
    CLC
    ADC z:0x53
    STA z:0x53
    SEP #0x20
    LDA #'☺'
    STA f:[z:0x53]
    REP #0x20
    PLX
    RTL

write_on_off:
    SEP #0x20
    STA z:0x40
    REP #0x20
    LDA #addr(unk_7E2038)
    STA z:0x53
    PHX
    SEP #0x20
    LDA #bank(unk_7E2038)
    STA z:0x53 + 2
    LDA a:addr(debug_cursor)
    CLC
    ADC #8
    REP #0x20
    AND #0xFF
    ASL A
    TAX
    LDA f:offsets_to_debug_menu_map, X
    CLC
    ADC z:0x53
    STA z:0x53
    SEP #0x20
    LDA z:0x40
    BNE .write_on

; write off
    LDA #'O'
    STA f:[z:0x53]
    REP #0x20
    INC z:0x53
    INC z:0x53
    SEP #0x20
    LDA #'F'
    STA f:[z:0x53]
    REP #0x20
    INC z:0x53
    INC z:0x53
    SEP #0x20
    LDA #'F'
    STA f:[z:0x53]
    BRA .loc_C603D5

.write_on:
    SEP #0x20
    LDA #' '
    STA f:[z:0x53]
    REP #0x20
    INC z:0x53
    INC z:0x53
    SEP #0x20
    LDA #'O'
    STA f:[z:0x53]
    REP #0x20
    INC z:0x53
    INC z:0x53
    SEP #0x20
    LDA #'N'
    STA f:[z:0x53]

.loc_C603D5:
    REP #0x20
    PLX
    RTL

draw_number:
    REP #0x20
    AND #0xFF
    STA z:0x40
    SEP #0x20
    LDA #bank(unk_7E203A)
    STA z:0x53 + 2
    LDA a:addr(debug_cursor)
    CLC
    ADC #8
    REP #0x20
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:offsets_to_debug_menu_map, X
    CLC
    ADC #addr(unk_7E203A)
    STA z:0x53
    SEP #0x20
    LDA a:addr(debug_cursor)
    CMP #0x11
    BEQ .loc_C6040B
    CMP #0x12
    BNE .loc_C6041B

.loc_C6040B:
    REP #0x20
    LDA z:0x40
    AND #0xFF
    TAX
    SEP #0x20
    LDA f:int_to_bcd, X
    STA z:0x40

.loc_C6041B:
    REP #0x20
    LDA z:0x40
    AND #0xF0
    LSR A
    LSR A
    LSR A
    LSR A
    TAX
    SEP #0x20
    LDA f:hex_digits, X
    STA f:[z:0x53]
    REP #0x20
    LDA z:0x40
    AND #0xF
    TAX
    INC z:0x53
    INC z:0x53
    SEP #0x20
    LDA f:hex_digits, X
    STA f:[z:0x53]
    REP #0x20
    PLX
    RTL

int_to_bcd:
    db 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
    db 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19
    db 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29
    db 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39
    db 0x40, 0x41, 0x42, 0x43, 0x44, 0x45
    
draw_speed_or_screen_name:
    SEP #0x20
    STA z:0x40
    LDA a:addr(debug_cursor)
    BEQ .loc_C604D4
    REP #0x20
    LDA #addr(unk_7E2038)
    STA z:0x53
    PHX
    SEP #0x20
    LDA #bank(unk_7E2038)
    STA z:0x53 + 2
    LDA a:addr(debug_cursor)
    CLC
    ADC #8
    REP #0x20
    AND #0xFF
    ASL A
    TAX
    LDA f:offsets_to_debug_menu_map, X
    CLC
    ADC z:0x53
    STA z:0x53
    LDA z:0x40
    AND #0xFF
    ASL A
    ASL A
    TAX
    SEP #0x20
    LDA f:speed_names, X
    STA f:[z:0x53]
    REP #0x20
    INC z:0x53
    INC z:0x53
    INX
    SEP #0x20
    LDA f:speed_names, X
    STA f:[z:0x53]
    REP #0x20
    INC z:0x53
    INC z:0x53
    INX
    SEP #0x20
    LDA f:speed_names, X
    STA f:[z:0x53]
    REP #0x20
    PLX
    RTL

.loc_C604D4:
    REP #0x20
    LDA #addr(unk_7E2038)
    STA z:0x53
    PHX
    SEP #0x20
    LDA #bank(unk_7E2038)
    STA z:0x53 + 2
    LDA a:addr(debug_cursor)
    CLC
    ADC #8
    REP #0x20
    AND #0xFF
    ASL A
    TAX
    LDA f:offsets_to_debug_menu_map, X
    CLC
    ADC z:0x53
    STA z:0x53
    LDA z:0x40
    AND #0xFF
    ASL A
    ASL A
    TAX
    SEP #0x20
    LDA f:screen_names, X
    STA f:[z:0x53]
    REP #0x20
    INC z:0x53
    INC z:0x53
    INX
    SEP #0x20
    LDA f:screen_names, X
    STA f:[z:0x53]
    REP #0x20
    INC z:0x53
    INC z:0x53
    INX
    SEP #0x20
    LDA f:screen_names, X
    STA f:[z:0x53]
    REP #0x20
    PLX
    RTL

close_debug_menu:
    JSL remove_debug_menu_from_tilemap
    set_handler set_data_from_debug_menu
    RTL

set_data_from_debug_menu:
    SEP #0x20
    LDA a:addr(game_flags)
    AND #~GAME_FLAGS_DEBUG_MENU
    STA a:addr(game_flags)
    REP #0x20
    PHX
    LDA z:pause_handler.controlling_player, X
    TAX
    SEP #0x20
    LDA a:addr(debug_no_death)
    STA z:player.no_death, X
    
    LDA a:addr(debug_bomb_up)
    STA z:player.bombups, X
    
    LDA z:player.fireups, X
    AND #0x80 ; Clear max fire
    ORA a:addr(debug_fire_up)
    STA z:player.fireups, X
    
    LDA a:addr(debug_speed_up)
    STA z:player.speedups, X
    
    LDA a:addr(debug_remocon)
    STA z:player.remote_control, X
    
    STZ z:player.powerups + 1, X
    LDA a:addr(debug_wall_pass)
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    AND #high(POWERUPS_WALL_PASS)
    ORA z:player.powerups + 1, X
    STA z:player.powerups + 1, X
    
    LDA a:addr(debug_bomb_pass)
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    AND #high(POWERUPS_BOMB_PASS)
    ORA z:player.powerups + 1, X
    STA z:player.powerups + 1, X
    
    LDA a:addr(debug_fire_pass)
    STA z:player.invincibility_countdown, X
    BEQ +
    REP #0x20
    LDA #0x160 ; A lot shorter than INVINCIBILITY_FRAMES for some reason
    STA z:player.invincibility_countdown, X
    SEP #0x20
+

    LDA a:addr(debug_full_fire)
    BEQ .clear_full_fire
    LDA z:player.fireups, X
    ORA #0x80 ; set full fire flag
    BRA +

.clear_full_fire:
    LDA z:player.fireups, X
    AND #0x7F
+

    STA z:player.fireups, X
    
    LDA a:addr(debug_break_thr)
    STA z:player.powerups, X
    
    LDA a:addr(debug_power)
    AND #high(POWERUPS_KICK) ; Yes, this is a bug in the original
    ORA z:player.powerups + 1, X
    STA z:player.powerups + 1, X
    
    LDA a:addr(debug_kick)
    ASL A
    AND #high(POWERUPS_PUNCH) ; Yes, this is a bug in the original
    ORA z:player.powerups + 1, X
    STA z:player.powerups + 1, X
    
    LDA a:addr(debug_skull)
    BEQ .no_poison
    JSL apply_poison
    SEP #0x20
    
; Restore handler
    PLX
    set_handler handle_pause
    RTL

.no_poison:
    STA z:player.debug_skull, X
    
; Restore handler
    PLX
    set_handler handle_pause
    RTL

fill_debug_info:
    REP #0x20
    PHX
    LDA z:pause_handler.controlling_player, X
    TAX
    SEP #0x20
    
    LDA z:player.no_death, X
    STA a:addr(debug_no_death)
    LDA z:player.bombups, X
    STA a:addr(debug_bomb_up)
    LDA z:player.fireups, X
    AND #0x7F ; Clear the Max Fire flag
    STA a:addr(debug_fire_up)
    LDA z:player.speedups, X
    STA a:addr(debug_speed_up)
    LDA z:player.remote_control, X
    STA a:addr(debug_remocon)
    LDA z:player.powerups + 1, X
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    AND #1
    STA a:addr(debug_wall_pass)
    LDA z:player.powerups + 1, X
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    AND #1
    STA a:addr(debug_bomb_pass)
    LDA z:player.invincibility_countdown, X
    BEQ +
    LDA #1
+

    STA a:addr(debug_fire_pass)
    LDA z:player.fireups, X
    AND #0x80 ; Max fire flag
    BEQ +
    LDA #1
+

    STA a:addr(debug_full_fire)
    LDA z:player.powerups, X
    STA a:addr(debug_break_thr)
    LDA z:player.powerups + 1, X
    AND #1
    STA a:addr(debug_power)
    LDA z:player.powerups + 1, X
    LSR A
    AND #1
    STA a:addr(debug_kick)
    LDA z:player.debug_skull, X
    STA a:addr(debug_skull)
    PLX
    RTL

screen_names:
    db "1-1 "
    db "1-2 "
    db "1-3 "
    db "1-4 "
    db "1-5 "
    db "1-6 "
    db "1-7 "
    db "1-8 "
    db "2-1 "
    db "2-2 "
    db "2-3 "
    db "2-4 "
    db "2-5 "
    db "2-6 "
    db "2-7 "
    db "2-8 "
    db "3-1 "
    db "3-2 "
    db "3-3 "
    db "3-4 "
    db "3-5 "
    db "3-6 "
    db "3-7 "
    db "3-8 "
    db "4-1 "
    db "4-2 "
    db "4-3 "
    db "4-4 "
    db "4-5 "
    db "4-6 "
    db "4-7 "
    db "4-8 "
    db "5-1 "
    db "5-2 "
    db "5-3 "
    db "5-4 "
    db "5-5 "
    db "5-6 "
    db "5-7 "
    db "5-8 "
    db "6-1 "
    db "6-2 "
    db "6-3 "
    db "6-4 "
    db "6-5 "
    db "6-6 "
    db "6-7 "
    db "6-8 "
    db "END "
    db "TIT "
    db "SEL "
    db "DM1 "
    db "DM2 "
    db "DM3 "
    db "DM4 "
    db "CON "
    db "PAS "
    db "PRM "
    db "DRW "
    db "WIN "
    db "B-1 "
    db "B-2 "
    db "B-3 "
    db "B-4 "
    db "B-5 "
    db "B-6 "
    db "B-7 "
    db "B-8 "
    db "B-9 "
    db "B-A "
    db "B-B "
    db "B-C "
    db "DR  "
    db "WIN "
    db "2-1 "
    db "2-2 "
    db "2-3 "
    db "2-4 "
    db "2-5 "
    db "2-6 "
    db "2-7 "
    db "2-8 "
    
speed_names:
    db " X1 "
    db " X2 "
    db " X3 "
    db " X4 "
    
hex_digits:
    db "0123456789ABCDEF"
    
debug_menu_value_types:
    db 0xB2, 0, 0xFC, 0xA
    db 0xA, 8, 0, 0
    db 0, 0, 0, 0
    db 0, 0, 0, 0
    db 0, 0x2A, 0x28, 2
    
DEBUG_MENU_X = 16
DEBUG_MENU_Y = 7

macro debug_menu_line string
    db DEBUG_MENU_X, DEBUG_MENU_Y, $string
    DEBUG_MENU_Y = DEBUG_MENU_Y + 1
endmacro

debug_menu_map:
    debug_menu_line " P:            "
    debug_menu_line " STAGE NO.  1-1"
    debug_menu_line " NO DEATH   OFF"
    debug_menu_line " GAME SPEED  X1"
    debug_menu_line " BOMB UP     00"
    debug_menu_line " FIRE UP     00"
    debug_menu_line " SPEED UP    00"
    debug_menu_line " REMOCON    OFF"
    debug_menu_line " WALL PASS  OFF"
    debug_menu_line " BOMB PASS  OFF"
    debug_menu_line " FIRE PASS  OFF"
    debug_menu_line " FIRE FULL  OFF"
    debug_menu_line " BREAK THR. OFF"
    debug_menu_line " POWER      OFF"
    debug_menu_line " KICK       OFF"
    debug_menu_line " SKULL      OFF"
    debug_menu_line " TIME CHECK OFF"
    debug_menu_line " VS CHECK   OFF"
    debug_menu_line " BGM NO.     00"
    debug_menu_line " SE NO.      00"
    db 0xFF
    
offsets_to_debug_menu_map:
    dw 0, 0x40, 0x80, 0xC0, 0x100, 0x140, 0x180, 0x1C0, 0x200, 0x240, 0x280, 0x2C0, 0x300, 0x340, 0x380, 0x3C0, 0x400
    dw 0x440, 0x480, 0x4C0, 0x500, 0x540, 0x580, 0x5C0, 0x600, 0x640, 0x680, 0x6C0, 0x700, 0x740, 0x780, 0x7C0
    
musics_lists:
    db 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0x10
    db 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F, 0x20, 0x21
    db 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x28, 0x28, 0x28
    
sounds_list:
    db 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0x10
    db 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F, 0x20, 0x21
    db 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29
    
unknown_debug_related:
    db 0, 1, 3, 4, 5, 0x1B, 7, 0x1C, 0xA, 0xD, 2, 0xE, 0xF, 0x10, 0x11, 0x12, 0x19
    db 0x14, 0x15, 0x16, 0x17, 0x18, 0x1A, 0x1D, 0x1E
        
remove_debug_menu_from_tilemap:
i16
    REP #0x20
    LDA #addr(bg3_ram_map)
    STA z:0x50
    SEP #0x20
    LDA #bank(bg3_ram_map)
    STA z:0x52
    REP #0x20
    LDY #0x680
    LDA #0

.loc_C609EE:
    STA f:[z:0x50], Y
    DEY
    DEY
    BNE .loc_C609EE
    RTL

draw_debug_menu:
    REP #0x20
    LDA #addr(debug_menu_map)
    STA z:0x50
    SEP #0x20
    LDA #bank(debug_menu_map)
    STA z:0x52

.loc_C60A02:
    REP #0x20
    LDA #addr(unk_7E2000)
    STA z:0x53
    SEP #0x20
    LDA #bank(unk_7E2000)
    STA z:0x53 + 2
    LDA f:[z:0x50]
    CMP #0xFF
    BNE .loc_C60A16
    RTL

.loc_C60A16:
    REP #0x20
    AND #0xFF
    ASL A
    CLC
    ADC z:0x53
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    AND #0xFF
    ASL A
    TAX
    LDA f:offsets_to_debug_menu_map, X
    CLC
    ADC z:0x53
    STA z:0x53
    INC z:0x50
    SEP #0x20
    LDA #0xF
    STA z:0x40

.loc_C60A3B:
    LDA f:[z:0x50]
    STA f:[z:0x53]
    REP #0x20
    INC z:0x53
    SEP #0x20
    LDA #0x20
    STA f:[z:0x53]
    REP #0x20
    INC z:0x53
    INC z:0x50
    SEP #0x20
    DEC z:0x40
    BNE .loc_C60A3B
    BRA .loc_C60A02
    
; The dynamic allocator works this way: allocator_cyclic_buffer is a cyclic buffer containing
; up to 52 pointers (50 objects that can be allocated + 2 extra do tell empty/full queues apart).
; Initially, the buffer is filled with a pointer to every (unallocated) object in dynamic objects,
; the read pointer is initialized with the start of the buffer, and the write pointer is set to 50,
; after every free pointer. Allocating an object is simply reading a pointer from the buffer and
; advancing the read pointer, and deallocating an object is simply writing it back and advancing
; the write buffer.

create_object:
i16
    SEP #0x20
    PHX
    LDA z:0xD3 ; Always 0x80, except when handler = sub_C5574C. Seems to be execution priority.
    CMP #0xFF ; This value is never actually used as an argument.
    REP #0x20
    BNE +
    JML .out_of_memory ; Never happens here
+

    LDX a:addr(allocator_cyclic_buffer_read_pointer)
    CPX a:addr(allocator_cyclic_buffer_write_pointer)
    BNE +
    JML .out_of_memory
+

    TXA
    INC A
    INC A
    CMP #allocator_cyclic_buffer.end - allocator_cyclic_buffer
    BNE +
    LDA #0
+

    STA a:addr(allocator_cyclic_buffer_read_pointer)
    LDY a:addr(allocator_cyclic_buffer), X
    LDA z:0xDB
    STA a:object.handler, Y
    LDA z:0xDC
    STA a:object.handler + 1, Y
    LDX #addr(gameover_related_object) ; Just before the rest of the dynamic objects

.loop:
    SEP #0x20
    LDA z:dynamic_object.execution_priority, X
    CMP z:0xD3
    REP #0x20
    BEQ .continue
    BCC .continue
    
    ; Insert according to the priorty
    LDA z:dynamic_object.prev, X
    STA a:dynamic_object.prev, Y
    PHA
    TYA
    STA z:dynamic_object.prev, X
    TXA
    STA a:dynamic_object.next, Y
    PLX
    TYA
    STA z:dynamic_object.next, X
    PLX
    CLC
    RTL

.continue:
    LDA z:dynamic_object.next, X
    TAX
    CMP #0xFFFF
    BEQ .out_of_memory
    BRA .loop

.out_of_memory:
    LDY #addr(dynamic_objects.end)
    PLX
    SEC
    RTL

create_small_object:
i16
    REP #0x20
    PHX
    LDX a:addr(small_allocator_cyclic_buffer_read_pointer)
    CPX a:addr(small_allocator_cyclic_buffer_write_pointer)
    BNE +
    JML .out_of_memory
+

    TXA
    INC A
    INC A
    CMP #small_allocator_cyclic_buffer.end - small_allocator_cyclic_buffer
    BNE +
    LDA #0
+

    STA a:addr(small_allocator_cyclic_buffer_read_pointer)
    LDY a:addr(small_allocator_cyclic_buffer), X
    LDA z:0x40
    STA a:dynamic_object.handler, Y ; Todo: switch to small_object
    LDX #addr(unknown_static_small_object) ; The first small object, comes before the static ones

.loop:
    LDA z:dynamic_object.handler, X
    BNE .empty
    LDA z:dynamic_object.prev, X
    STA a:dynamic_object.prev, Y
    STA z:0x44
    TYA
    STA z:dynamic_object.prev, X
    TXA
    STA a:dynamic_object.next, Y
    LDX z:0x44
    TYA
    STA z:dynamic_object.next, X
    PLX
    CLC
    RTL

.empty:
    LDA z:dynamic_object.next, X
    TAX
    INC A
    BNE .loop

.out_of_memory:
    PLX
    SEC
    RTL

delete_object:
    REP #0x20
    LDA a:addr(allocator_cyclic_buffer_write_pointer)
    TAY
    INC A
    INC A
    CMP #0x68
    BNE +
    LDA #0
+

    STA a:addr(allocator_cyclic_buffer_write_pointer)
    
    TXA
    STA a:addr(allocator_cyclic_buffer), Y
    
    LDY z:dynamic_object.prev, X
    LDA z:dynamic_object.next, X
    STA a:dynamic_object.next, Y
    PHA
    PHY
    PLA
    PLY
    STA a:dynamic_object.prev, Y
    STZ z:dynamic_object.handler, X
    STZ z:dynamic_object.handler+2, X
    RTL

free_small_object:
    REP #0x20
    LDA a:addr(small_allocator_cyclic_buffer_write_pointer)
    TAY
    INC A
    INC A
    CMP #small_allocator_cyclic_buffer.end - small_allocator_cyclic_buffer
    BNE +
    LDA #0
+

    STA a:addr(small_allocator_cyclic_buffer_write_pointer)
    TXA
    STA a:addr(small_allocator_cyclic_buffer), Y
    LDY z:dynamic_object.prev, X
    LDA z:dynamic_object.next, X
    STA a:dynamic_object.next, Y
    PHA
    PHY
    PLA
    PLY
    STA a:dynamic_object.prev, Y
    STZ z:dynamic_object.handler, X
    RTL

diagonal_zigzag_button_map:
    ; FF is the button combo results in a diagonal zigzag movement, 0 otherwise
    ;   --   --->  <---  BOTH    
    db 0x00, 0x00, 0x00, 0x00 ; None
    db 0x00, 0xFF, 0xFF, 0x00 ; Down
    db 0x00, 0xFF, 0xFF, 0x00 ; Up
    db 0x00, 0x00, 0x00, 0x00 ; Both
    
is_player_on_obstacle:
    ; BOMB = high(POWERUPS_BOMB_PASS)
    ; SOFT_BLOCK = high(POWERUPS_WALL_PASS)
    REP #0x20
    LDA z:player.powerups + 1, X
    AND #high(POWERUPS_BOMB_PASS | POWERUPS_WALL_PASS)    
    EOR #0xFF
    AND #BOMB | SOFT_BLOCK | HARD_BLOCK   
    STA z:0x42
    
    lda_tile_id X
    TAY
    LDA a:addr(collision_map), Y
    
    AND z:0x42
    BNE .ret_true
    CLC
    RTL

.ret_true:
    SEC
    RTL

get_collision_mask_for_position:
    .X = 0x40 ; Argument
    .Y = 0x42 ; Argument
    .OFFSET = 0x44
    REP #0x20
    LDA z:.X
    AND #0xF0
    LSR A
    LSR A
    LSR A
    STA z:.OFFSET
    LDA z:.Y
    AND #0xF0
    ASL A
    ASL A
    ADC z:.OFFSET
    TAY
    LDA a:addr(collision_map), Y
    RTL

get_object_square_index:
    REP #0x20
    lda_tile_id X
    RTL

center_object_on_tile:
    SEP #0x20
    LDA z:sprite.x_position, X
    AND #0xF0
    ORA #8
    STA z:sprite.x_position, X
    LDA z:sprite.y_position, X
    AND #0xF0
    ORA #8
    STA z:sprite.y_position, X
    RTL

; Bug: This function is sometimes called even when the game is paused.
; Specifically, the flashing counter ticks down for enemies that just
; spawned out of the exit even if the game is paused
handle_enemy_damage:
    SEP #0x20
    ; Reset the palette from potentially the white one
    LDA z:enemy.real_palette, X
    STA z:enemy.effective_palette, X
    
    ; Then set it to white based on the flashing counter
    LDA z:enemy.flashing_counter, X
    BEQ +
    DEC z:enemy.flashing_counter, X
    BIT #1
    BEQ .ret_false
    LDA #PALETTE_STATIC_WHITE
    STA z:enemy.effective_palette, X
    BRA .ret_false
+

    REP #0x20
    
    lda_tile_id X
    TAY
    LDA a:addr(collision_map), Y

    BIT #BLAST
    BNE .hit
    ; TODO: figure these constants
    AND #0x3F
    CMP #0x3F
    BNE .ret_false
    LDA a:addr(collision_map), Y
    ORA #0xF03F ; This one too
    STA a:addr(collision_map), Y

.hit:
    SEP #0x20
    LDA z:enemy.hitpoints_left, X
    BEQ .ret_true
    DEC z:enemy.hitpoints_left, X
    LDA #32 ; Flash for 32 frames
    STA z:enemy.flashing_counter, X
    CLC
    RTL

.ret_true:
    SEC
    RTL

.ret_false:
    CLC
    RTL

handle_player_tile:
    REP #0x20
    
    lda_tile_id X
    TAY
    LDA a:addr(collision_map), Y
    
    AND #BONUS_MASK | BOMB | SOFT_BLOCK | HARD_BLOCK | BLAST
    BEQ .empty_tile
    BIT #BOMB
    BEQ +
    JML .bomb
+

    BIT #BLAST
    BEQ +
    JML set_player_hit
+

    BIT #HARD_BLOCK | SOFT_BLOCK | BOMB
    BNE .nothing
    
    ; Bonus
    AND #BONUS_MASK
    PHX
    ASL A
    TAX
    LDA #bank(bomb_up_bonus)
    STA z:0x53 + 2
    LDA f:bonus_handlers, X
    STA z:0x53
    PLX
    JSL call_far_function_at_0053

.nothing:
    SEP #0x20
    LDA z:player.unknown_flags, X
    ORA #0x80
    STA z:player.unknown_flags, X
    RTL

.empty_tile:
    REP #0x20
    LDA a:addr(level_manager_object.spawn_and_flags)
    BIT #LEVEL_FLAGS_WARP_ZONE
    BNE .warp_zone
    
    BIT #LEVEL_FLAGS_JUMP_ZONE
    BEQ .nothing
    LDA a:addr(bg1_tilemap), Y
    CMP #ATTRIBUTED_TILE_TRAMPOLINE
    BNE .nothing
    
    ; Handle trampoline
    SEP #0x20
    LDA z:player.unknown_flags, X
    BIT #0x80
    BEQ .ret
    
    AND #~0x80
    STA z:player.unknown_flags, X
    JSL create_trampoline_animator
    SEP #0x20
    LDA z:player.is_ai, X
    BNE .is_ai
    
    set_handler do_trampoline
    RTL

.is_ai:
    set_handler do_trampoline
    RTL

.warp_zone:
    REP #0x20
    LDA a:addr(bg1_tilemap), Y
    CMP #0x826 ; Warp tile
    BNE .nothing
    
    LDA z:player.unknown_flags, X
    BIT #0x80
    BEQ .ret
    
    SEP #0x20
    LDA z:player.unknown_flags, X
    AND #~0x80
    STA z:player.unknown_flags, X
    LDA z:player.is_ai, X
    BNE .warp_is_ai
    
    set_handler do_player_warp
    RTL

.warp_is_ai:
    set_handler do_player_warp_ai

.ret:
    RTL
    
    ; Dead code
    REP #0x20

.bomb:
    AND #BONUS_MASK | BOMB
    CMP #BONUS_MASK | BOMB
    BNE .ret2
    LDA z:player.hit_flags, X
    ORA #HIT_FLAG_PUNCHED_BOMB
    STA z:player.hit_flags, X
    LDA a:addr(collision_map), Y
    ORA #BONUS_MASK | BOMB | PLAYER | 0x7000 ; TODO: unknown constant
    STA a:addr(collision_map), Y

.ret2:
    RTL

bonus_handlers:
    da 0, bomb_up_bonus, fire_up_bonus, remote_control_bonus, speed_up_bonus, vest, extra_life_bonus, bomb_pass_bonus
    da wall_pass_bonus, extra_time_bonus, full_fire_bonus, red_bombs_bonus, kick_bonus, punch_bonus, onigiri_bonus, poison_bonus
    da exit_bonus, heart_bonus, cake_bonus, question_mark_bonus, kendama_bonus, apple_bonus, fire_extinguisher_bonus, popsicle_bonus
    da ice_cream_bonus, poison_bonus, poison_bonus, unused_bonus, unused_bonus, unused_bonus, unused_bonus, unused_bonus
    da set_player_hit, set_player_hit, set_player_hit, set_player_hit, set_player_hit
    
bomb_up_bonus:
i16
    REP #0x20
    
    add_to_score_if_allowed 10
    JSL clear_bonus_tile
    
    SEP #0x20
    INC a:player.collected_bombups, X
    LDA z:player.bombups, X
    CMP #9
    BEQ .maxed
    INC z:player.bombups, X

.maxed:
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

unused_bonus:
    RTL
    
fire_up_bonus:
i16
    REP #0x20
    
    add_to_score_if_allowed 200    
    JSL clear_bonus_tile
    
    SEP #0x20
    INC a:player.collected_fireups, X
    LDA z:player.fireups, X
    CMP #9
    BEQ .maxed
    INC z:player.fireups, X

.maxed:
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

remote_control_bonus:
i16
    REP #0x20
    
    add_to_score_if_allowed 300    
    JSL clear_bonus_tile
    
    SEP #0x20
    LDA z:player.remote_control, X
    ORA #remote_control_REMOTE_CONTROL
    STA z:player.remote_control, X
    INC a:player.collected_remote_controls, X
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

speed_up_bonus:
i16
    REP #0x20

    add_to_score_if_allowed 400

    JSL clear_bonus_tile
    
    SEP #0x20
    INC a:player.collected_speedups, X
    LDA z:player.speedups, X
    CMP #3
    BCS .maxed
    INC z:player.speedups, X

.maxed:
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

vest:
i16
    REP #0x20
    LDA #INVINCIBILITY_FRAMES
    STA z:player.invincibility_countdown, X

    add_to_score_if_allowed 500

    JSL clear_bonus_tile
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

extra_life_bonus:
    REP #0x20

    add_to_score_if_allowed 600

    JSL clear_bonus_tile
    ; fallthrough

add_extra_life:
i16
    SEP #0x20
    LDA z:player.lives, X
    CMP #9
    BEQ .maxed
    INC z:0x3D, X

.maxed:
    JSL draw_number_of_lives
    LDY #SOUND_EXTRA_LIFE
    JSL play_sound
    RTL

bomb_pass_bonus:
i16
    REP #0x20

    add_to_score_if_allowed 700

    JSL clear_bonus_tile
    
    SEP #0x20
    LDA z:player.powerups + 1, X
    ORA #high(POWERUPS_BOMB_PASS)
    AND #low(~high(POWERUPS_KICK))
    STA z:player.powerups + 1, X
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

wall_pass_bonus:
i16
    REP #0x20

    add_to_score_if_allowed 800

    JSL clear_bonus_tile
    
    SEP #0x20
    LDA z:player.powerups + 1, X
    ORA #high(POWERUPS_WALL_PASS)
    STA z:player.powerups + 1, X
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

extra_time_bonus:
i16
    REP #0x20
    
    LDA z:player.is_ai, X
    AND #0xFF
    BNE .ai
    
    LDA z:player.player_index, X
    AND #0xFF
    ASL A
    TAY
    LDA #0
    STA a:addr(story_mode_timers), Y
    
    ; Tilemap copy dest
    pos y, 1, 3 ; Player 1
    LDA z:player.player_index, X
    AND #0xFF
    BEQ +
    pos y, 17, 3 ; Player 2
+

    ; Tiles to copy - 1
    LDA #STORY_MODE_TIMER_TICKS - 1 
    STA z:0x40 
    
    ; Source address
    REP #0x20
    LDA #addr(storymode_hud_tilemap+0xC2)
    STA z:0x50
    
    SEP #0x20
    LDA #bank(storymode_hud_tilemap+0xC2)
    STA z:0x52
    
    ; Update the timer blocks in the HUD
    JSL copy_to_bg3_tilemap
    
    REP #0x20
    add_to_score_if_allowed 900

.ai:
    JSL clear_bonus_tile
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

full_fire_bonus:
i16
    REP #0x20

    add_to_score_if_allowed 1000

    JSL clear_bonus_tile
    
    ; Mark fireups as temporarily maxed
    SEP #0x20
    LDA z:player.fireups, X
    ORA #0x80
    STA z:player.fireups, X
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

red_bombs_bonus:
i16
    REP #0x20

    add_to_score_if_allowed 2000

    JSL clear_bonus_tile
    
    SEP #0x20
    LDA z:player.powerups, X
    ORA #POWERUPS_RED_BOMBS
    STA z:player.powerups, X
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

kick_bonus:
i16
    REP #0x20

    add_to_score_if_allowed 3000

    JSL clear_bonus_tile
    
    SEP #0x20
    INC a:player.collected_kicks, X
    
    LDA z:player.powerups + 1, X
    ORA #high(POWERUPS_KICK)
    AND #low(~high(POWERUPS_BOMB_PASS))
    STA z:player.powerups + 1, X
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

punch_bonus:
i16
    REP #0x20

    add_to_score_if_allowed 4000

    JSL clear_bonus_tile
    
    SEP #0x20
    INC a:player.collected_punches, X
    
    LDA z:player.powerups + 1, X
    ORA #high(POWERUPS_PUNCH)
    STA z:player.powerups + 1, X
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

onigiri_bonus:
i16
    REP #0x20

    add_to_score_if_allowed 5000

    JSL clear_bonus_tile
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

poison_bonus:
i16
    REP #0x20

    add_to_score_if_allowed 6000

    JSL clear_bonus_tile
    JSL apply_poison
    
    LDY #SOUND_POISON
    JSL play_sound
    RTL

exit_bonus:
    SEP #0x20
    LDA a:addr(level_manager_object.enemy_count)
    BNE .ret
    JSL is_object_misaligned
    BCS .ret
    set_handler enter_level_exit
    
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_LEVEL_END
    BNE .ret
    LDA a:addr(game_flags)
    AND #GAME_FLAGS_SCREEN_TRANSITION
    ORA #GAME_FLAGS_LEVEL_END
    STA a:addr(game_flags)

.ret:
    RTL

set_player_hit:
    SEP #0x20
    LDA #HIT_FLAG_BLAST
    STA z:player.hit_flags, X
    RTL

heart_bonus:
i16
    SEP #0x20
    LDA z:player.powerups + 1, X
    ORA #high(POWERUPS_HEART)
    STA z:player.powerups + 1, X
    
    REP #0x20
    add_to_score_if_allowed 800
    JSL clear_bonus_tile
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

cake_bonus:
i16
    REP #0x20
    
    add_to_score_if_allowed 999900    
    JSL clear_bonus_tile
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

question_mark_bonus:
i16
    SEP #0x20
    LDA #bank(bomb_up_bonus)
    STA z:0x53 + 2
    PHX
    LDX #0x17
    JSL random
    REP #0x20
    INC A
    CMP #POISON
    BEQ .extra_life
    CMP #EXIT
    BEQ .extra_life
    CMP #RANDOM
    BNE +

.extra_life:
    LDA #EXTRA_LIFE
+

    ASL A
    TAX
    LDA f:bonus_handlers, X
    PLX
    STA z:0x53
    JSL call_far_function_at_0053
    RTL

kendama_bonus:
i16
    REP #0x20

    add_to_score_if_allowed 100

    JSL clear_bonus_tile
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

unused_score_bonus:
i16
    REP #0x20

    add_to_score_if_allowed 100

    JSL clear_bonus_tile
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

apple_bonus:
i16
    REP #0x20

    add_to_score_if_allowed 8000

    JSL clear_bonus_tile
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

fire_extinguisher_bonus:
i16
    SEP #0x20
    LDA #9
    STA z:player.lives, X
    
    REP #0x20
    add_to_score_if_allowed 9000

    JSL draw_number_of_lives
    JSL clear_bonus_tile
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

popsicle_bonus:
i16
    REP #0x20

    add_to_score_if_allowed 500

    JSL clear_bonus_tile
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

ice_cream_bonus:
i16
    REP #0x20
    
    add_to_score_if_allowed 50000    
    JSL clear_bonus_tile
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

clear_bonus_tile:
    JSL get_object_square_index
    TAY
    REP #0x20
    LDA #0
    STA a:addr(collision_map), Y
    LDA a:addr(bg1_tilemap+0x20), Y
    STA a:addr(bg1_tilemap), Y
    RTL

apply_poison:
i16
    REP #0x20
    PHX
    LDX #7
    LDA a:addr(current_mode)
    AND #0xFF
    CMP #GAME_MODE_BATTLE
    BEQ .battle_mode
    ; Check for World 5
    LDA a:addr(level_manager_object.level_representation)
    AND #0xF0
    CMP #0x50
    BNE .battle_mode
    LDX #6 ; Skip the last poison effect in story mode (effectively only the final boss)

.battle_mode:
    JSL random
    AND #0xFF
    ASL A
    ASL A
    TAX
    LDA f:poison_table, X
    STA z:0x40
    LDA f:poison_table+2, X
    STA z:0x42
    PLX
    LDA z:0x40
    STA a:player.poison_state, X
    LDA z:0x42
    STA a:player.poison_state + 2, X
    RTL

poison_table:
    dl POISON_TIMER_MAX | POISON_MIN_SPEED
    dl POISON_TIMER_MAX | POISON_MAX_SPEED
    dl POISON_TIMER_MAX | POISON_AUTO_BOMB_DROP
    dl POISON_TIMER_MAX | POISON_NO_BOMBS
    dl POISON_TIMER_MAX | POISON_MAX_SPEED | POISON_AUTO_BOMB_DROP
    dl POISON_TIMER_MAX | POISON_MIN_FIRE_SINGLE_BOMB
    dl POISON_TIMER_MAX | POISON_INVISIBILITY
    
; Dead code start
    
create_unused_palette_manager:
    SEP #0x20
    create_object unused_palette_manager_init
    BCS .ret
    SEP #0x20
    LDA #2
    TSB a:addr(game_flags)
.ret:
    RTL
    
unused_palette_manager_init:
i16
    SEP #0x20
    LDY #0
    LDA #PAKUPA_PALETTE
    STA z:0x40
    LDA #1
    JSL set_palette
    LDA #2
    JSL set_palette
    LDA #3
    JSL set_palette
    LDA #4
    JSL set_palette
    LDA #5
    JSL set_palette
    LDA #6
    JSL set_palette
    LDA #7
    JSL set_palette
    
    LDA #addr(WHITE_PALETTE)
    STA z:0x40
    LDA #8
    JSL set_palette
    LDA #9
    JSL set_palette
    LDA #10
    JSL set_palette
    LDA #11
    JSL set_palette
    LDA #12
    JSL set_palette
    LDA #13
    JSL set_palette
    set_handler unused_palette_manager
    RTL

unused_palette_manager:
i16
    REP #0x20
    LDA #addr(palette_table)
    STA z:0x53
    SEP #0x20
    LDA #bank(palette_table)
    STA z:0x53 + 2
    REP #0x20
    INC z:0x53
    LDA #1
    STA z:0x42
    LDA #0
    STA z:0x44
    LDA #8
    STA z:0x46
    JSL sub_C475C8
    REP #0x20
    LDA #addr(palette_table)
    STA z:0x53
    SEP #0x20
    LDA #bank(palette_table)
    STA z:0x53 + 2
    REP #0x20
    LDA #addr(palette_table)
    CLC
    ADC #8
    STA z:0x53
    LDA #8
    STA z:0x42
    LDA #0
    STA z:0x44
    LDA #0x10
    STA z:0x46
    JSL sub_C475C8
    set_handler .loc_C612AC
    REP #0x20
    LDA #0x20
    STA z:0x10, X
    LDA a:addr(level_manager_object.level_representation)
    AND #0xF0
    CMP #0x50
    BNE .loc_C612AC
    LDA a:addr(level_manager_object.level_representation)
    AND #0xF
    DEC A
    PHX
    TAX
    SEP #0x20
    LDA f:palette_per_mecha_bomber, X
    STA z:0x40
    LDY #0
    LDA #0xC
    JSL set_palette
    PLX

.loc_C612AC:
    SEP #0x20
    handler_return_if_paused_or_in_transition
    REP #0x20
    DEC z:0x10, X
    BNE .ret
    JSL sub_C61309
    REP #0x20
    LDA #0x10
    STA z:0x10, X
    set_handler .loc_C612DF

.loc_C612DF:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ .loc_C612F4
    JML .ret

.loc_C612F4:
    REP #0x20
    DEC z:0x10, X
    BNE .ret
    SEP #0x20
    LDA a:addr(game_flags)
    ; The bit it's setting off isn't even used, what is it trying to achieve?
    AND #GAME_FLAGS_SCREEN_TRANSITION | GAME_FLAGS_PAUSED | GAME_FLAGS_KILL_ENEMIES | GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_BATTLE_DELAY | GAME_FLAGS_LEVEL_END | GAME_FLAGS_DEBUG_MENU
    STA a:addr(game_flags)
    JSL delete_object

.ret:
    RTL

sub_C61309:
i16
    REP #0x20
    PHX
    LDX #0x1C80

.loc_C6130F:
    LDA z:0, X
    CMP #addr(sub_C44DA9)
    BNE .loc_C61324
    SEP #0x20
    LDA #8
    STA z:3, X
    LDA z:0xC, X
    ORA #0x10
    STA z:0xC, X
    REP #0x20

.loc_C61324:
    LDA z:6, X
    TAX
    INC A
    BNE .loc_C6130F
    PLX
    RTL

; Dead code end

trampoline_animation_length:
    db 0x23
trampoline_animation_tiles:
    dw 0xA40, 0xA48, 0xA48, 0xA48, 0xA4A, 0xA4A, 0xA4A, 0xA4C, 0xA4C, 0xA4C, 0xA4C, 0xA4C, 0xA4C, 0xA4C, 0xA4A, 0xA4A, 0xA48
    dw 0xA40, 0xA42, 0xA44, 0xA46, 0xA46, 0xA44, 0xA42, 0xA40, 0xA48, 0xA4A, 0xA4C, 0xA4A, 0xA48, 0xA40, 0xA42, 0xA40, 0xA48
    dw 0xA40

create_trampoline_animator:
    STY z:0x40
    SEP #0x20
    create_object trampoline_animator
    REP #0x20
    BCC +
    JML create_unused_palette_manager.ret ; Failed allocation
+

    LDA z:0x40
    STA a:addr(trampoline_animator.tile_offset), Y
    LDA #0
    STA a:addr(trampoline_animator.animation_counter), Y
    RTL

trampoline_animator:
    SEP #0x20
    handler_return_if_paused_or_in_transition
    REP #0x20
    LDY z:trampoline_animator.tile_offset, X
    LDA z:trampoline_animator.animation_counter, X
    ASL A
    PHX
    TAX
    SEP #0x20
    LDA f:trampoline_animation_tiles, X
    STA z:0x40
    PLX
    LDA z:0x40
    STA a:addr(bg1_tilemap+0x20), Y
    LDA a:addr(collision_map), Y
    BIT #BOMB
    BNE .skip_render
    LDA a:addr(collision_map + 1), Y
    BIT #high(BLAST)
    BNE .skip_render
    LDA z:0x40
    STA a:addr(bg1_tilemap), Y

.skip_render:
    INC z:trampoline_animator.animation_counter, X
    LDA z:trampoline_animator.animation_counter, X
    CMP f:trampoline_animation_length
    BNE .ret
    JML delete_object

.ret:
    RTL

handle_zigzag_inputs:
    .INPUT_DIRECTIONS = 0x4E
    REP #0x20
    PHX
    LDA z:.INPUT_DIRECTIONS
    AND #0xF
    TAX
    SEP #0x20
    LDA f:diagonal_zigzag_button_map, X
    STA z:0x40
    PLX
    LDA z:0x40
    BEQ .non_diagonal
    LDA z:player.last_zigzag_direction, X
    AND z:.INPUT_DIRECTIONS
    BNE .resume_zigzag
    ; The last zigzag direction is not being held anymore
    LDA z:player.direction, X
    AND #DIR_MASK_RIGHT | DIR_MASK_LEFT
    BEQ .facing_vertically
    
    ; Already facing horizontally, keep moving in that direction
    LDA z:.INPUT_DIRECTIONS
    AND #DIR_MASK_RIGHT | DIR_MASK_LEFT
    STA z:player.direction, X
    STA z:player.last_zigzag_direction, X
    BRA +

.facing_vertically:
    ; Already facing vertically, keep moving in that direction
    LDA z:.INPUT_DIRECTIONS
    AND #DIR_MASK_UP | DIR_MASK_DOWN
    STA z:player.direction, X
    STA z:player.last_zigzag_direction, X
+

    JSL start_animation_by_index
    SEP #0x20

.resume_zigzag:
    LDA z:.INPUT_DIRECTIONS
    CMP #DIR_MASK_DOWN | DIR_MASK_LEFT
    BNE +
    JML .down_left
+

    CMP #DIR_MASK_DOWN | DIR_MASK_RIGHT
    BNE +
    JML .down_right
+

    CMP #DIR_MASK_UP | DIR_MASK_RIGHT
    BEQ .up_right
    BRA .up_left

.non_diagonal:
    STZ z:player.last_zigzag_direction, X
    RTL

.up_right:
    JSL is_hard_block_above
    BCC +
    JML .keep_direction
+

    JSL is_hard_block_on_right
    BCC +
    JML .keep_direction
+

    SEP #0x20
    LDA z:player.last_zigzag_direction, X
    EOR #DIR_MASK_UP | DIR_MASK_RIGHT
    STA z:.INPUT_DIRECTIONS
    RTL

.up_left:
    JSL is_hard_block_above
    BCC +
    JML .keep_direction
+

    JSL is_hard_block_on_left
    BCC +
    JML .keep_direction
+

    SEP #0x20
    LDA z:player.last_zigzag_direction, X
    EOR #DIR_MASK_UP | DIR_MASK_LEFT
    STA z:.INPUT_DIRECTIONS
    RTL

.down_left:
    JSL is_hard_block_below
    BCC +
    JML .keep_direction
+

    JSL is_hard_block_on_left
    BCC +
    JML .keep_direction
+

    SEP #0x20
    LDA z:player.last_zigzag_direction, X
    EOR #DIR_MASK_DOWN | DIR_MASK_LEFT
    STA z:.INPUT_DIRECTIONS
    RTL

.down_right:
    JSL is_hard_block_below
    BCS .keep_direction
    JSL is_hard_block_on_right
    BCS .keep_direction
    SEP #0x20
    LDA z:player.last_zigzag_direction, X
    EOR #DIR_MASK_DOWN | DIR_MASK_RIGHT
    STA z:.INPUT_DIRECTIONS
    RTL

.keep_direction:
    SEP #0x20
    LDA z:player.direction, X
    CMP z:player.last_zigzag_direction, X
    BNE +
    STA z:.INPUT_DIRECTIONS
    RTL
+

    STA z:player.last_zigzag_direction, X
    STA z:.INPUT_DIRECTIONS
    RTL

is_hard_block_on_right:
    SEP #0x20
    LDA z:sprite.x_position, X
    AND #0xF
    CMP #8
    BNE .ret_false ; Not centered vertically
    JSL get_object_square_index
    REP #0x20
    ; X += 1
    INC A
    INC A
    TAY
    LDA a:addr(collision_map), Y
    BIT #HARD_BLOCK
    BNE .ret_true

.ret_false:
    CLC
    RTL

.ret_true:
    SEC
    RTL

is_hard_block_on_left:
    SEP #0x20
    LDA z:sprite.x_position, X
    AND #0xF
    CMP #8
    BNE .ret_false ; Not centered vertically
    JSL get_object_square_index
    REP #0x20
    ; X -= 1
    DEC A
    DEC A
    TAY
    LDA a:addr(collision_map), Y
    BIT #HARD_BLOCK
    BNE .ret_true

.ret_false:
    CLC
    RTL

.ret_true:
    SEC
    RTL

is_hard_block_below:
    SEP #0x20
    LDA z:sprite.y_position, X
    AND #0xF
    CMP #8
    BNE .ret_false ; Not centered vertically
    JSL get_object_square_index
    REP #0x20
    CLC
    ADC #0x40 ; Y += 1
    TAY
    LDA a:addr(collision_map), Y
    BIT #HARD_BLOCK
    BNE .ret_true

.ret_false:
    CLC
    RTL

.ret_true:
    SEC
    RTL

is_hard_block_above:
    SEP #0x20
    LDA z:sprite.y_position, X
    AND #0xF
    CMP #8
    BNE .ret_false ; Not centered vertically
    JSL get_object_square_index
    REP #0x20
    SEC
    SBC #0x40 ; Y -= 1
    TAY
    LDA a:addr(collision_map), Y
    BIT #HARD_BLOCK
    BNE .ret_true

.ret_false:
    CLC
    RTL

.ret_true:
    SEC
    RTL

test_collision:
    .MASK = 0x42
    REP #0x20
    lda_tile_id_offset X, 0, 0
    TAY
    LDA a:addr(collision_map), Y
    BIT z:.MASK
    RTL

test_collision_above:
    REP #0x20
    lda_tile_id_offset X, 0, -9
    TAY
    LDA a:addr(collision_map), Y
    BIT z:test_collision.MASK
    RTL

test_collision_below:
    REP #0x20
    lda_tile_id_offset X, 0, 8
    TAY
    LDA a:addr(collision_map), Y
    BIT z:test_collision.MASK
    RTL

test_collision_on_the_left:
    REP #0x20
    lda_tile_id_offset X, -9, 0
    TAY
    LDA a:addr(collision_map), Y
    BIT z:test_collision.MASK
    RTL

test_collision_on_the_right:
    REP #0x20
    lda_tile_id_offset X, 8, 0
    TAY
    LDA a:addr(collision_map), Y
    BIT z:test_collision.MASK
    RTL

fast_random:
    REP #0x20
    LDA z:addr(fast_rng_seed)
    SEC
    SBC #0x18
    BCS +
    CLC
    ADC #random_data.end - random_data
+

    STA z:addr(unused_fast_rng_seed)
    PHX
    TAX
    LDA f:random_data, X
    LDX z:addr(fast_rng_seed)
    EOR f:random_data, X
    PLX
    PHA
    INC z:addr(fast_rng_seed)
    LDA z:addr(fast_rng_seed)
    CMP #random_data.end - random_data
    BCC +
    STZ z:addr(fast_rng_seed)
+

    PLA
    RTL

random_data:
    db 0x6B, 0x7A, 0x32, 0x74, 0x02, 0xFE, 0x6A, 0x27
    db 0xF6, 0xFA, 0x91, 0x36, 0x39, 0x1D, 0x43, 0x6D
    db 0x3D, 0xB4, 0xB5, 0x01, 0x16, 0x7F, 0x16, 0x7C
    db 0xB4, 0x20, 0x80, 0x78, 0x88, 0x12, 0x1E, 0xF0
    db 0x2E, 0x1B, 0xDA, 0xEB, 0xB0, 0x6B, 0xBD, 0xA9
    db 0xFC, 0xD9, 0xB3, 0xEB, 0x43, 0x5D, 0x3A, 0xBD
    db 0xA7, 0x99, 0x58, 0x7C, 0x80, 0x44, 0x8C
.end
    
ds 9

call_screen_init_functions:
    SEP #0x20
    STZ a:addr(byte_7E0C3E)

-
    REP #0x20
    LDA f:[z:0x50]
    CMP #INIT_FUNCTIONS_TERMINATOR
    BEQ .done
    STA z:0x53
    INC z:0x50
    LDA f:[z:0x50]
    STA z:0x53 + 1
    INC z:0x50
    INC z:0x50
    LDA z:0x53
    PHA
    LDA z:0x56
    PHA
    JSL call_far_function_at_0053
    REP #0x20
    PLA
    STA z:0x56
    PLA
    STA z:0x53
    BRA -

.done:
    INC z:0x50
    INC z:0x50
    RTL

level_reset:
i16
    REP #0x20
    LDX #0
    LDA #0

-
    STA f:graphics_table, X
    INX
    INX
    CPX #0x60
    BNE -
    
    LDX #0
    LDA #0xFFFF
-
    STA f:palette_table, X
    INX
    INX
    CPX #0x10
    BNE -
    
    LDX #0
    LDA #0xFFFF
-
    STA f:shuffled_bonus_index_array, X
    INX
    INX
    CPX #0x40
    BNE -
    
    LDX #0
    LDA #0
-
    STA f:combo_counters & 0xFFFF, X ; Access through bank 0 rather than 7E, for some reason
    INX
    INX
    CPX #0x10
    BNE -
    RTL

create_enemies:
    REP #0x20
    .ROM_ENEMY_FUNCTION_PTR = 0x56
    .BONUS_PTR = 0x5C
    .RAM_ENEMY_FUNCTION_PTR = 0x5F
    .BONUSES_LEFT = 0x4A
    .ASSIGNED_BONUS = 0x48
    .SHUFFLED_BONUS_INDEX_ARRAY_PTR = 0x59
    
    ; Initialize local variables
    LDA #addr(enemy_creation_functions)
    STA z:.RAM_ENEMY_FUNCTION_PTR
    SEP #0x20
    LDA #bank(enemy_creation_functions)
    STA z:.RAM_ENEMY_FUNCTION_PTR + 2
    
    SEP #0x20
    LDA a:addr(level_manager_object.pointer_to_enemy_list)
    STA z:.ROM_ENEMY_FUNCTION_PTR
    LDA a:addr(level_manager_object.pointer_to_enemy_list+1)
    STA z:.ROM_ENEMY_FUNCTION_PTR + 1
    LDA #bank(stage_1_1)
    STA z:.ROM_ENEMY_FUNCTION_PTR + 2
    
    LDA a:addr(level_manager_object.pointer_to_bonus_list)
    STA z:.BONUS_PTR
    LDA a:addr(level_manager_object.pointer_to_bonus_list+1)
    STA z:.BONUS_PTR + 1
    LDA #bank(stage_1_1)
    STA z:.BONUS_PTR + 2
    
    LDA a:addr(level_manager_object.game_mode)
    CMP #GAME_MODE_BATTLE
    BNE +
    JML .ret
+

.loop
    JSL generate_random_position
    JSL get_collision_mask_for_position
    REP #0x20
    BIT #HARD_BLOCK |  SOFT_BLOCK | BOMB | EXIT | ENEMY | RESERVED_FREE
    BNE .loop
    
    ; No more enemies
    LDA f:[z:.ROM_ENEMY_FUNCTION_PTR]
    BEQ .ret
    
    ; Copy the function pointer to 0x53 so we can call it later via call_far_function_at_0053
    STA z:0x53
    INC z:.ROM_ENEMY_FUNCTION_PTR
    LDA f:[z:.ROM_ENEMY_FUNCTION_PTR]
    STA z:0x53 + 1
    INC z:.ROM_ENEMY_FUNCTION_PTR
    INC z:.ROM_ENEMY_FUNCTION_PTR
    
    ; Update collision mask for the tile
    LDA #ENEMY
    STA a:addr(collision_map), Y
    
    STZ z:.ASSIGNED_BONUS
    LDA z:.BONUSES_LEFT
    BEQ +
    
    ; Assign a bonus by the shuffled bonus index array
    DEC z:.BONUSES_LEFT
    LDA f:[z:.SHUFFLED_BONUS_INDEX_ARRAY_PTR]
    INC z:.SHUFFLED_BONUS_INDEX_ARRAY_PTR
    INC z:.SHUFFLED_BONUS_INDEX_ARRAY_PTR
    PHY
    ASL A
    TAY
    LDA f:[z:.BONUS_PTR], Y
    STA z:.ASSIGNED_BONUS
    PLY
+

    ; Save temp variables
    LDA z:0x50
    PHA
    LDA z:0x53
    PHA
    LDA z:.ROM_ENEMY_FUNCTION_PTR
    PHA
    LDA z:.RAM_ENEMY_FUNCTION_PTR
    PHA
    LDA z:0x60
    PHA
    
    JSL call_far_function_at_0053
    
    ; Restore temp variables
    REP #0x20
    PLA
    STA z:0x60
    PLA
    STA z:.RAM_ENEMY_FUNCTION_PTR
    PLA
    STA z:.ROM_ENEMY_FUNCTION_PTR
    PLA
    STA z:0x53
    PLA
    STA z:0x50
    
    ; Next enemy
    INC z:.RAM_ENEMY_FUNCTION_PTR
    INC z:.RAM_ENEMY_FUNCTION_PTR
    INC z:.RAM_ENEMY_FUNCTION_PTR
    BRA .loop
.ret:
    RTL

call_far_function_at_0053:
    JML [0x53]
    RTI
    
load_global_sprites:
    .ARGS = 0x50
    .TABLE_PTR = 0x62
    
    REP #0x20
    LDA f:[z:.ARGS]
    STA z:allocate_graphics.GRAPHICS
    INC z:.ARGS
    LDA f:[z:.ARGS]
    STA z:allocate_graphics.GRAPHICS + 1
    INC z:.ARGS
    INC z:.ARGS
    
    LDA f:[z:.ARGS]
    STA z:allocate_graphics.COUNT
    INC z:.ARGS
    INC z:.ARGS
    
    INC z:.ARGS ; Unused single byte argument
    
    PHY
    PHX
    JSL allocate_graphics
    SEP #0x20
    LDA a:addr(use_mini_graphics)
    BEQ .done
    
    .COUNT = 0x40
    ; Iterate 15 graphics, replace with mini graphics if needed
    REP #0x20
    LDA #addr(graphics_table)
    STA z:.TABLE_PTR
    SEP #0x20
    LDA #bank(graphics_table)
    STA z:.TABLE_PTR + 2
    
    REP #0x20
    LDA #0xF
    STA z:.COUNT

-
    JSL replace_graphics_with_mini
    INC z:.TABLE_PTR
    INC z:.TABLE_PTR
    INC z:.TABLE_PTR
    DEC z:.COUNT
    BNE -

.done:
    PLX
    PLY
    RTL

replace_graphics_with_mini:
i16
    .TABLE_PTR = 0x62
    .LOOP_COUNTER = 0x42

    REP #0x20
    LDX #0
    LDY #1
    LDA #(bomberman_graphics_2.end - bomberman_graphics_2) / 3
    STA z:.LOOP_COUNTER

-
    LDA f:[z:.TABLE_PTR]
    CMP f:bomberman_graphics_2, X
    BNE +
    LDA f:[z:.TABLE_PTR], Y
    CMP f:bomberman_graphics_2+1, X
    BNE +
    LDA f:bomberman_mini_graphics, X
    STA f:[z:.TABLE_PTR]
    LDA f:bomberman_mini_graphics+1, X
    STA f:[z:.TABLE_PTR], Y
    RTL
+

    INX
    INX
    INX
    DEC z:.LOOP_COUNTER
    BNE -
    RTL

bomberman_graphics_2:
    df bomberman_graphic_0
    df bomberman_graphic_1
    df bomberman_graphic_2
    df bomberman_graphic_3
    df bomberman_extra_graphic_0
    df bomberman_extra_graphic_1
    .end
    
bomberman_mini_graphics:
    df bomberman_mini_graphic_0
    df bomberman_mini_graphic_1
    df bomberman_mini_graphic_2
    df bomberman_mini_graphic_3
    df bomberman_mini_graphic_4
    df bomberman_mini_warp_graphic

allocate_graphics:
i16
    .GRAPHICS = 0x5F ; argument
    .COUNT = 0x40 ; argument
    .TABLE_PTR = 0x62
    .INDEX_USED = 0x42 ; output

    REP #0x20
    STZ z:.INDEX_USED
    REP #0x20
    LDA #addr(graphics_table)
    STA z:.TABLE_PTR
    SEP #0x20
    LDA #bank(graphics_table)
    STA z:.TABLE_PTR + 2

-
    REP #0x20
    LDA f:[z:.GRAPHICS]
    CMP f:[z:.TABLE_PTR]
    BNE +
    LDY #1
    LDA f:[z:.GRAPHICS], Y
    CMP f:[z:.TABLE_PTR], Y
    BNE +
    ; Already loaded
    RTL
+

    LDA f:[z:.TABLE_PTR]
    BEQ .found_free
    INC z:.TABLE_PTR
    INC z:.TABLE_PTR
    INC z:.TABLE_PTR
    INC z:.INDEX_USED
    BRA -

.found_free:
    ; Copy the graphics list
-
    LDA f:[z:.GRAPHICS]
    STA f:[z:.TABLE_PTR]
    LDY #1
    LDA f:[z:.GRAPHICS], Y
    STA f:[z:.TABLE_PTR], Y
    INC z:.GRAPHICS
    INC z:.GRAPHICS
    INC z:.GRAPHICS
    INC z:.TABLE_PTR
    INC z:.TABLE_PTR
    INC z:.TABLE_PTR
    DEC z:.COUNT
    BNE -
    RTL

load_palettes:
    .ARGS = 0x50
    .PALETTES = 0x5F
    .COUNT = 0x44
    .TABLE_PTR = 0x62
    
    REP #0x20
    LDA f:[z:.ARGS]
    STA z:.PALETTES
    INC z:.ARGS
    LDA f:[z:.ARGS]
    STA z:.PALETTES + 1
    INC z:.ARGS
    INC z:.ARGS
    
    LDA f:[z:.ARGS]
    STA z:.COUNT
    INC z:.ARGS
    INC z:.ARGS
    
    INC z:.ARGS ; Unused argument
    
    REP #0x20
    LDA #addr(palette_table)
    STA z:.TABLE_PTR
    SEP #0x20
    LDA #bank(palette_table)
    STA z:.TABLE_PTR + 2
    SEP #0x20

    ; Simply copy the buffer to the palette table
-
    LDA f:[z:.PALETTES]
    STA f:[z:.TABLE_PTR]
    REP #0x20
    INC z:.PALETTES
    INC z:.TABLE_PTR
    SEP #0x20
    DEC z:.COUNT
    BNE -
    RTL

allocate_sprite_palette:
    .TABLE_PTR = 0x62
    .PALETTE = 0x40 ; Argument
    .SLOT_INDEX = 0x42 ; Return value
    REP #0x20
    STZ z:.SLOT_INDEX
    REP #0x20
    LDA #addr(palette_table.sprite)
    STA z:.TABLE_PTR
    SEP #0x20
    LDA #bank(palette_table.sprite)
    STA z:.TABLE_PTR + 2

-
    LDA f:[z:.TABLE_PTR]
    CMP z:.PALETTE ; Already loaded?
    BEQ .ret
    
    CMP #FREE_PALETTE
    BEQ .found_free
    
    REP #0x20
    INC z:.TABLE_PTR
    LDA z:.TABLE_PTR
    
    ; No space ?
    CMP #addr(palette_table.end)
    BEQ .ret
    
    INC z:.SLOT_INDEX
    INC z:.SLOT_INDEX
    SEP #0x20
    BRA -

.found_free:
    LDA z:.PALETTE
    STA f:[z:.TABLE_PTR]

.ret:
    RTL

; Possibly related to a deleted battle stage
unknown_unused_data:
    dw 0x028, 0x018, 0x0E8, 0x0B8, 0x0E8
    dw 0x018, 0x028, 0x0B8, 0x028, 0x038
    dw 0x0E8, 0x0A8, 0x0E8, 0x038, 0x028
    dw 0x0A8, 0x000, 0x000, 0x000, 0x101
    dw 0x100, 0x101, 0x101, 0x202, 0x201
    dw 0x202, 0x202, 0x303, 0x302, 0x303
    dw 0x303, 0x404, 0x403, 0x404, 0x404
    dw 0x404
    
; Duel zone soft block locations are static. Boring!

macro duel_zone_block x, y
    dw 0x44 + ($x) * 2 + ($y) * 0x40, ATTRIBUTED_TILE_SOFTBLOCK, SOFT_BLOCK
endmacro

duel_zone_block_locations:
    duel_zone_block 2,  1
    duel_zone_block 10, 1
    duel_zone_block 2,  2
    duel_zone_block 4,  2
    duel_zone_block 6,  2
    duel_zone_block 8,  2
    duel_zone_block 10, 2
    duel_zone_block 4,  3
    duel_zone_block 6,  3
    duel_zone_block 8,  3
    duel_zone_block 2,  4
    duel_zone_block 3,  4
    duel_zone_block 9,  4
    duel_zone_block 10, 4
    duel_zone_block 2,  6
    duel_zone_block 3,  6
    duel_zone_block 9,  6
    duel_zone_block 10, 6
    duel_zone_block 4,  7
    duel_zone_block 8,  7
    duel_zone_block 6,  7
    duel_zone_block 2,  8
    duel_zone_block 4,  8
    duel_zone_block 6,  8
    duel_zone_block 8,  8
    duel_zone_block 10, 8
    duel_zone_block 2,  9
    duel_zone_block 10, 9
    .end
unmacro duel_zone_block
    
macro duel_zone_bonus x, y, bonus
    dw 0x44 + ($x) * 2 + ($y) * 0x40, $bonus
endmacro
duel_zone_bonuses:
    duel_zone_bonus 0,  0,  BOMB_UP
    duel_zone_bonus 0,  2,  BOMB_UP
    duel_zone_bonus 0,  4,  KICK
    duel_zone_bonus 0,  6,  PUNCH
    duel_zone_bonus 0,  8,  BOMB_UP
    duel_zone_bonus 0,  10, BOMB_UP
    duel_zone_bonus 2,  0,  BOMB_UP
    duel_zone_bonus 4,  0,  SPEED_UP
    duel_zone_bonus 6,  0,  FULL_FIRE
    duel_zone_bonus 8,  0,  SPEED_UP
    duel_zone_bonus 10, 0,  BOMB_UP
    duel_zone_bonus 12, 0,  BOMB_UP
    duel_zone_bonus 12, 2,  BOMB_UP
    duel_zone_bonus 12, 4,  PUNCH
    duel_zone_bonus 12, 6,  KICK
    duel_zone_bonus 12, 8,  BOMB_UP
    duel_zone_bonus 12, 10, BOMB_UP
    duel_zone_bonus 2,  10, BOMB_UP
    duel_zone_bonus 4,  10, SPEED_UP
    duel_zone_bonus 6,  10, FULL_FIRE
    duel_zone_bonus 8,  10, SPEED_UP
    duel_zone_bonus 10, 10, BOMB_UP
    .end
unmacro duel_zone_bonus
    
generate_soft_blocks:
i16
    .REMAINING_BONUSES = 0x48 ; Argument
    .SHUFFLED_BONUS_INDEXES = 0x59 ; Argument
    .COUNTDOWN = 0x46
    .BONUS_PTR = 0x53
    
    REP #0x20
    LDA a:addr(level_manager_object.soft_blocks)
    STA z:.COUNTDOWN
    
    BNE .normal_mode
    LDA a:addr(level_manager_object.spawn_and_flags)
    BIT #LEVEL_FLAGS_DUEL_ZONE
    BEQ .ret
    
    ; Duel zone
    PHX
    PHY
    LDX #0
-
    LDA f:duel_zone_block_locations, X ; Get block offset
    TAY
    LDA f:duel_zone_block_locations + 2, X ; Save tile to tilemap
    STA a:addr(bg1_tilemap), Y
    LDA f:duel_zone_block_locations + 4, X ; and collision mask to the map
    STA a:addr(collision_map), Y
    
    INX
    INX
    INX
    INX
    INX
    INX
    
    CPX #duel_zone_block_locations.end - duel_zone_block_locations
    BNE -
    
    LDX #0
-
    LDA f:duel_zone_bonuses, X ; Get tile offset
    TAY
    LDA f:duel_zone_bonuses + 2, X ; and the bonus
    PHX
    JSL create_bonus_object ; and make them into a bonus object
    PLX
    INX
    INX
    INX
    INX
    CPX #duel_zone_bonuses.end - duel_zone_bonuses
    BNE -
    PLY
    PLX

.ret:
    RTL

    ; Normal mode
.normal_mode:
    SEP #0x20
    LDA a:addr(level_manager_object.pointer_to_bonus_list)
    STA z:.BONUS_PTR
    LDA a:addr(level_manager_object.pointer_to_bonus_list+1)
    STA z:.BONUS_PTR + 1
    LDA #bank(stage_1_1)
    STA z:.BONUS_PTR + 2
    
-
    JSL generate_random_position
    JSL get_collision_mask_for_position
    REP #0x20
    BIT #EXIT | BOMB | SOFT_BLOCK | HARD_BLOCK | RESERVED_FREE
    BNE -

    REP #0x20
    LDA #ATTRIBUTED_TILE_SOFTBLOCK
    STA a:addr(bg1_tilemap), Y
    LDA z:.REMAINING_BONUSES
    BEQ .no_bonus
    
    ; Obtain a bonus and place it
    DEC z:.REMAINING_BONUSES
    LDA f:[z:.SHUFFLED_BONUS_INDEXES]
    INC z:.SHUFFLED_BONUS_INDEXES
    INC z:.SHUFFLED_BONUS_INDEXES
    PHY
    ASL A
    TAY
    LDA f:[z:.BONUS_PTR], Y
    PLY

.no_bonus:
    ORA #SOFT_BLOCK
    STA a:addr(collision_map), Y
    DEC z:.COUNTDOWN
    BEQ +
    JML -
+

    SEP #0x20
    LDA a:addr(level_manager_object.spawn_and_flags)
    BIT #LEVEL_FLAGS_JUMP_ZONE
    BNE +
    RTL
+

    .REMAINING_TRAMPOLINES = .REMAINING_BONUSES
    REP #0x20
    LDA #0x10
    STA z:.REMAINING_TRAMPOLINES

-
    JSL generate_random_position
    JSL get_collision_mask_for_position
    REP #0x20
    BIT #EXIT | BOMB | SOFT_BLOCK | HARD_BLOCK | RESERVED_FREE
    BNE -
    
    REP #0x20
    LDA #ATTRIBUTED_TILE_TRAMPOLINE
    STA a:addr(bg1_tilemap), Y
    STA a:addr(bg1_tilemap+0x20), Y
    DEC z:.REMAINING_TRAMPOLINES
    BNE -
    RTL

copy_enemy_creation_functions:
    .SRC = 0x50 ; Argument, points to the relevant part of the level struct
    .DEST = 0x53
    REP #0x20
    LDA #addr(enemy_creation_functions)
    STA z:.DEST
    SEP #0x20
    LDA #bank(enemy_creation_functions)
    STA z:.DEST + 2
    
    REP #0x20
    LDA z:.SRC
    STA a:addr(level_manager_object.pointer_to_enemy_list)

-
    LDA f:[z:.SRC]
    STA f:[z:.DEST]
    BEQ .done
    INC z:.SRC
    INC z:.DEST
    LDA f:[z:.SRC]
    STA f:[z:.DEST]
    INC z:.SRC
    INC z:.SRC
    INC z:.DEST
    INC z:.DEST
    INC a:addr(level_manager_object.enemy_count)
    BRA -

.done:
    INC z:.SRC
    INC z:.SRC
    RTL

count_level_bonuses:
    .BONUS_LIST = 0x50 ; The level struct pointer. At this point, it points to the bonus list
    .BONUS_COUNT = 0x46 ; Output
    REP #0x20
    LDA z:.BONUS_LIST
    STA a:addr(level_manager_object.pointer_to_bonus_list)
    STZ z:.BONUS_COUNT

-
    LDA f:[z:.BONUS_LIST]
    BEQ .done
    INC z:.BONUS_LIST
    INC z:.BONUS_LIST
    INC z:.BONUS_COUNT
    BRA -

.done:
    INC z:0x50
    INC z:0x50
    RTL

shuffle_and_divide_bonuses:
i16
    .BONUS_COUNT = count_level_bonuses.BONUS_COUNT ; Input
    .ENEMY_BONUSES = 0x4A
    .SOFTBLOCK_BONUSES = 0x48
    .SHUFFLED_COUNTER = 0xD3
    .SHUFFLED_ARRAY_LENGTH = 0xD5
    REP #0x20
    LDA z:.BONUS_COUNT
    STA z:0x48
    LDA z:.BONUS_COUNT
    STA a:addr(level_manager_object.bonus_count)
    
    LDA a:addr(level_manager_object.game_mode)
    CMP #GAME_MODE_BATTLE
    BEQ .battle_mode
    
    LDA #0
    STA z:.SOFTBLOCK_BONUSES
    LDA #0
    STA z:.ENEMY_BONUSES
    
    LDA z:.BONUS_COUNT
    BEQ .ret_false ; No bonuses in this stage
    
    LDX z:.BONUS_COUNT
    JSL random
    STA z:.SOFTBLOCK_BONUSES
    LDA z:.BONUS_COUNT
    SEC
    SBC z:.SOFTBLOCK_BONUSES
    CMP a:addr(level_manager_object.enemy_count)
    BCS shuffle_and_divide_bonuses ; Assigned more enemy bonuses than enemies, restart the process
    STA z:.ENEMY_BONUSES

.battle_mode:
    STZ z:.SHUFFLED_COUNTER
    LDA z:.BONUS_COUNT
    BEQ .ret_false

-
    LDA z:.SHUFFLED_COUNTER
    STA z:.SHUFFLED_ARRAY_LENGTH
    LDX z:.BONUS_COUNT
    JSL random
    LDX #-2
    JSL .search_in_shuffled_array
    BCS - ; Already in the shuffled array, try again
    
    ; Put in the shuffled array
    PHA
    LDA z:.SHUFFLED_COUNTER
    ASL A
    TAX
    PLA
    STA f:shuffled_bonus_index_array, X
    
    ; Advance and continue
    INC z:.SHUFFLED_COUNTER
    LDA z:.SHUFFLED_COUNTER
    CMP z:.BONUS_COUNT
    BNE -
    RTL

.search_in_shuffled_array:
    INX
    INX
    DEC z:.SHUFFLED_ARRAY_LENGTH
    BMI .ret_false
    CMP f:shuffled_bonus_index_array, X
    BNE .search_in_shuffled_array
    SEC
    RTL

.ret_false:
    CLC
    RTL
    
macro tile_offset x, y
    dw 0x44 + ($x) * 2 + ($y) * 0x40
endmacro

tunnel_zone_reserved_free_tiles:
    tile_offset 0,  3
    tile_offset 0,  4
    tile_offset 1,  4
    tile_offset 0,  5
    tile_offset 7,  0
    tile_offset 8,  0
    tile_offset 9,  0
    tile_offset 8,  1
    tile_offset 6,  3
    tile_offset 6,  4
    tile_offset 5,  4
    tile_offset 7,  4
    tile_offset 6,  5
    tile_offset 6,  6
    tile_offset 5,  6
    tile_offset 7,  6
    tile_offset 6,  7
    tile_offset 12, 5
    tile_offset 12, 6
    tile_offset 11, 6
    tile_offset 12, 7
    tile_offset 3,  10
    tile_offset 4,  10
    tile_offset 4,  9
    tile_offset 5,  10
    .end
    
extended_story_mode_reserved_free_tiles:
    tile_offset 2,  0
    tile_offset 3,  0
    tile_offset 2,  1
    tile_offset 2,  2
    tile_offset 1,  2
    tile_offset 0,  2
    tile_offset 0,  3
    tile_offset 10, 0
    tile_offset 9,  0
    tile_offset 10, 1
    tile_offset 10, 2
    tile_offset 11, 2
    tile_offset 12, 2
    tile_offset 12, 3
    .end
    
belt_zone_reserved_free_tiles:
    tile_offset 0,  0
    tile_offset 1,  0
    tile_offset 2,  0
    tile_offset 0,  1
    tile_offset 0,  2
    tile_offset 10, 0
    tile_offset 11, 0
    tile_offset 12, 0
    tile_offset 12, 1
    tile_offset 12, 2
    tile_offset 0,  8
    tile_offset 0,  9
    tile_offset 0,  10
    tile_offset 1,  10
    tile_offset 2,  10
    tile_offset 12, 8
    tile_offset 12, 9
    tile_offset 12, 10
    tile_offset 11, 10
    tile_offset 10, 10
    .end
    
standard_reserved_free_tiles:
    tile_offset 0,  0
    tile_offset 1,  0
    tile_offset 0,  1
    tile_offset 11, 0
    tile_offset 12, 0
    tile_offset 12, 1
    .story_mode_end
    tile_offset 0,  9
    tile_offset 0,  10
    tile_offset 1,  10
    tile_offset 12, 9
    tile_offset 12, 10
    tile_offset 11, 10
    .battle_mode_end
    
western_zone_reserved_free_tiles:
    tile_offset 4, 4
    tile_offset 5, 4
    tile_offset 6, 4
    tile_offset 7, 4
    tile_offset 8, 4
    tile_offset 4, 5
    tile_offset 6, 5
    tile_offset 8, 5
    tile_offset 4, 6
    tile_offset 5, 6
    tile_offset 6, 6
    tile_offset 7, 6
    tile_offset 8, 6
    .end
    
warp_zone_reserved_free_tiles:
    tile_offset 2,  2
    tile_offset 1,  2
    tile_offset 2,  1
    tile_offset 3,  2
    tile_offset 2,  3
    tile_offset 10, 2
    tile_offset 9,  2
    tile_offset 10, 1
    tile_offset 11, 2
    tile_offset 10, 3
    tile_offset 2,  8
    tile_offset 2,  7
    tile_offset 1,  8
    tile_offset 3,  8
    tile_offset 2,  9
    tile_offset 10, 8
    tile_offset 9,  8
    tile_offset 10, 7
    tile_offset 11, 8
    tile_offset 10, 9
    tile_offset 6,  4
    tile_offset 6,  5
    tile_offset 6,  6
    .end
    
reserve_free_level_tiles:
    REP #0x20
    LDA a:addr(level_manager_object.game_mode)
    AND #0xFF
    CMP #GAME_MODE_STORY
    BNE + ; Battle mode
    LDA a:addr(level_manager_object.level_representation)
    AND #0xF
    CMP #8
    BNE + ; Non-boss
    JML set_collision_mask_for_tiles.ret ; Story mode boss, do nothing
+

    LDA a:addr(level_manager_object.spawn_and_flags)
    BIT #LEVEL_FLAGS_SOFTBLOCK_ANYWHERE
    BEQ +
    JML set_collision_mask_for_tiles.ret
+

    BIT #LEVEL_FLAGS_WESTERN
    BEQ +
    JML western_zone_reserve_free_level_tiles
+

    BIT #LEVEL_FLAGS_WARP_ZONE
    BEQ +
    JML warp_zone_reserve_free_level_tiles
+

    BIT #LEVEL_FLAGS_BELT_ZONE
    BEQ +
    JML belt_zone_reserve_free_level_tiles
+

    BIT #LEVEL_FLAGS_TUNNEL_ZONE
    BEQ +
    JML tunnel_zone_reserve_free_level_tiles
+

    REP #0x20
    LDA #addr(standard_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY
    SEP #0x20
    LDA #bank(standard_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY + 2
    
    REP #0x20
    LDA #RESERVED_FREE
    STA z:set_collision_mask_for_tiles.MASK_VALUE
    
    LDA #(standard_reserved_free_tiles.battle_mode_end - standard_reserved_free_tiles) / 2
    STA z:set_collision_mask_for_tiles.COUNT
    
    LDA a:addr(level_manager_object.game_mode)
    CMP #GAME_MODE_BATTLE
    BEQ set_collision_mask_for_tiles
    
    ; Story mode
    LDA #(standard_reserved_free_tiles.story_mode_end - standard_reserved_free_tiles) / 2
    STA z:set_collision_mask_for_tiles.COUNT

    LDA #RESERVED_FREE | ENEMY
    STA z:set_collision_mask_for_tiles.MASK_VALUE
    JSL set_collision_mask_for_tiles
    
    ; Allow soft blocks in these, but forbid enemies
    REP #0x20
    LDA #addr(extended_story_mode_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY
    SEP #0x20
    LDA #bank(extended_story_mode_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY + 2
    REP #0x20
    LDA #(extended_story_mode_reserved_free_tiles.end - extended_story_mode_reserved_free_tiles) / 2
    STA z:set_collision_mask_for_tiles.COUNT
    LDA #ENEMY
    STA z:set_collision_mask_for_tiles.MASK_VALUE
    ; fallthrough

set_collision_mask_for_tiles:
    ; Arguments
    .OFFSET_ARRAY = 0x5c
    .COUNT = 0x4A
    .MASK_VALUE = 0xDB
    LDA f:[z:.OFFSET_ARRAY]
    TAY
    LDA z:.MASK_VALUE
    STA a:addr(collision_map), Y
    INC z:.OFFSET_ARRAY
    INC z:.OFFSET_ARRAY
    DEC z:.COUNT
    BNE set_collision_mask_for_tiles

.ret:
    RTL

western_zone_reserve_free_level_tiles:
    REP #0x20
    LDA #addr(western_zone_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY
    SEP #0x20
    LDA #bank(western_zone_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY + 2
    REP #0x20
    LDA #RESERVED_FREE
    STA z:set_collision_mask_for_tiles.MASK_VALUE
    LDA #(western_zone_reserved_free_tiles.end - western_zone_reserved_free_tiles) / 2
    STA z:set_collision_mask_for_tiles.COUNT
    BRA set_collision_mask_for_tiles

warp_zone_reserve_free_level_tiles:
    REP #0x20
    LDA #addr(warp_zone_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY
    SEP #0x20
    LDA #bank(warp_zone_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY + 2
    REP #0x20
    LDA #RESERVED_FREE
    STA z:set_collision_mask_for_tiles.MASK_VALUE
    LDA #(warp_zone_reserved_free_tiles.end - warp_zone_reserved_free_tiles) / 2
    STA z:set_collision_mask_for_tiles.COUNT
    JSL set_collision_mask_for_tiles
    
    REP #0x20
    LDA #addr(standard_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY
    SEP #0x20
    LDA #bank(standard_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY + 2
    REP #0x20
    LDA #RESERVED_FREE
    STA z:set_collision_mask_for_tiles.MASK_VALUE
    LDA #(standard_reserved_free_tiles.battle_mode_end - standard_reserved_free_tiles) / 2
    STA z:set_collision_mask_for_tiles.COUNT
    BRA set_collision_mask_for_tiles

belt_zone_reserve_free_level_tiles:
    REP #0x20
    LDA #addr(belt_zone_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY
    SEP #0x20
    LDA #bank(belt_zone_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY + 2
    REP #0x20
    LDA #RESERVED_FREE
    STA z:set_collision_mask_for_tiles.MASK_VALUE
    LDA #(belt_zone_reserved_free_tiles.end - belt_zone_reserved_free_tiles) / 2
    STA z:set_collision_mask_for_tiles.COUNT
    BRA set_collision_mask_for_tiles

tunnel_zone_reserve_free_level_tiles:
    REP #0x20
    LDA #addr(tunnel_zone_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY
    SEP #0x20
    LDA #bank(tunnel_zone_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY + 2
    REP #0x20
    LDA #RESERVED_FREE
    STA z:set_collision_mask_for_tiles.MASK_VALUE
    LDA #(tunnel_zone_reserved_free_tiles.end - tunnel_zone_reserved_free_tiles) / 2
    STA z:set_collision_mask_for_tiles.COUNT
    JSL set_collision_mask_for_tiles
    
    REP #0x20
    LDA #addr(standard_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY
    SEP #0x20
    LDA #bank(standard_reserved_free_tiles)
    STA z:set_collision_mask_for_tiles.OFFSET_ARRAY + 2
    REP #0x20
    LDA #RESERVED_FREE
    STA z:set_collision_mask_for_tiles.MASK_VALUE
    LDA #(standard_reserved_free_tiles.battle_mode_end - standard_reserved_free_tiles) / 2
    STA z:set_collision_mask_for_tiles.COUNT
    JMP a:set_collision_mask_for_tiles

generate_hard_blocks_and_exit:
    .FREE_TILES = 0x4A
    .COUNT = 0x48 ; argument
    REP #0x20
    LDA a:addr(current_mode)
    CMP #GAME_MODE_STORY
    BNE .ret
    LDA a:addr(level_manager_object.spawn_and_flags)
    BIT #LEVEL_FLAGS_SPAWN_BOSS | LEVEL_FLAGS_SPAWN_WORLD_5
    BNE .ret
    LDA #112 ; Number of free tiles in an empty level, + 1
    STA z:.FREE_TILES ; Used later in is_map_non_continuous
    BRA .loop

.delete_and_retry:
    LDA #0
    STA a:addr(collision_map), Y

.loop:
    JSL generate_random_position
    JSL get_collision_mask_for_position
    REP #0x20
    BIT #EXIT | BOMB | SOFT_BLOCK | HARD_BLOCK | RESERVED_FREE
    BNE .loop
    
    REP #0x20
    LDA #addr(HARD_BLOCK)
    STA a:addr(collision_map), Y
    PHY
    JSL is_map_non_continuous
    PLY
    BCS .delete_and_retry
    
    REP #0x20
    LDA a:addr(bg1_tilemap + 0x24) ; Contains the hard block tile at this point in time
    STA a:addr(bg1_tilemap), Y
    
    DEC z:.FREE_TILES
    DEC z:.COUNT
    BPL .loop
    
    ; Replace the last tile with an exist softblock
    LDA #EXIT | SOFT_BLOCK
    STA a:addr(collision_map), Y
    LDA #ATTRIBUTED_TILE_SOFTBLOCK
    STA a:addr(bg1_tilemap), Y

.ret:
    RTL

generate_random_position:
    .X = 0x40 ; Output
    .Y = 0x42 ; Output
i16
    REP #0x20
    LDX #13
    JSL random
    SEP #0x20
    INC A
    INC A
    ASL A
    ASL A
    ASL A
    ASL A
    STA z:.X
    
    REP #0x20
    LDX #11
    LDA z:.X
    PHA
    JSL random
    SEP #0x20
    INC A
    ASL A
    ASL A
    ASL A
    ASL A
    STA z:.Y
    REP #0x20
    PLA
    STA z:.X ; Write X again because it was overwritten
    RTL

is_map_non_continuous:
    .EXPECTED_TILES = generate_hard_blocks_and_exit.FREE_TILES
    .STACK = 0x5F
    .STACK_OFFSET = 0x5C
    .REACHED_TILES = 0x4C
i16
    REP #0x20
    LDA #bank(temp_uncompressed_graphics)
    STA z:.STACK + 2
    LDY #0x44       ; Default Player 1 start position
    STZ z:.STACK_OFFSET
    STZ z:.REACHED_TILES

.process_tile
    JSL add_unprocessed_neighbor_tiles_to_stack
    LDA z:add_unprocessed_neighbor_tiles_to_stack.NEIGHBORS_ADDED
    BEQ .pop_stack ; Didn't find new neighbors, pop stack
    LDA z:.REACHED_TILES
    CMP z:.EXPECTED_TILES
    BNE .process_tile
    
    ; Reached the target, we're continuous
    LDA #addr(~(PLAYER))
    JSL apply_mask_to_collision_map ; Clean up
    CLC
    RTL

.finished_stack:
    ; Emptied the stack without reaching the target, not continuous 
    LDA #addr(~(PLAYER))
    JSL apply_mask_to_collision_map ; Clean up
    SEC
    RTL

.pop_stack:
    REP #0x20
    LDA z:.STACK_OFFSET
    BEQ .finished_stack
    DEC z:.STACK_OFFSET
    DEC z:.STACK_OFFSET
    LDA z:.STACK_OFFSET
    CLC
    ADC #addr(temp_uncompressed_graphics) ; Reused as a stack of unprocessed tiles
    STA z:.STACK
    LDA f:[z:.STACK]
    TAY
    BRA .process_tile

add_unprocessed_neighbor_tiles_to_stack:
    .TILE_OFFSET = 0x53
    .NEIGHBORS_ADDED = 0x44
    .NEIGHBORS_LEFT = 0x46
    .STACK = is_map_non_continuous.STACK
    .STACK_OFFSET = is_map_non_continuous.STACK_OFFSET
    .REACHED_TILES = is_map_non_continuous.REACHED_TILES
    
    REP #0x20
    STZ z:0x44
    LDA #3
    STA z:.NEIGHBORS_LEFT
    STY z:.TILE_OFFSET

.loop:
    ; Get offset to neighbor
    PHY
    LDA z:.NEIGHBORS_LEFT
    ASL A
    TAX
    TYA
    CLC
    ADC f:collision_map_direction_offsets, X
    TAY
    
    ; Get the collision mask for the neighbor
    LDA a:addr(collision_map), Y
    BIT #PLAYER ; Reuse the player bit as a "visited" mark
    BNE .skip
    
    AND #BONUS_MASK | BOMB | SOFT_BLOCK | HARD_BLOCK ; Blocked
    BNE .skip
    
    INC z:.NEIGHBORS_ADDED
    LDA z:.NEIGHBORS_ADDED
    CMP #1
    BEQ .first_added
    
    LDA z:.STACK_OFFSET
    CLC
    ADC #addr(temp_uncompressed_graphics)
    STA z:.STACK
    TYA
    STA f:[z:.STACK]
    INC z:.STACK_OFFSET
    INC z:.STACK_OFFSET
    LDA a:addr(collision_map), Y
    ORA #PLAYER
    STA a:addr(collision_map), Y
    INC z:.REACHED_TILES

.skip:
    PLY
    DEC z:.NEIGHBORS_LEFT
    BPL .loop
    LDY z:.TILE_OFFSET
    RTL

.first_added:
    STY z:.TILE_OFFSET
    LDA a:addr(collision_map), Y
    ORA #PLAYER
    STA a:addr(collision_map), Y
    INC z:.REACHED_TILES
    PLY
    DEC z:.NEIGHBORS_LEFT
    BPL .loop
    LDY z:.TILE_OFFSET
    RTL

apply_mask_to_collision_map:
i16
    REP #0x20
    STA z:0x40
    LDY #collision_map.end - collision_map

-
    LDA a:addr(collision_map), Y
    AND z:0x40
    STA a:addr(collision_map), Y
    DEY
    DEY
    BPL -
    RTL

collision_map_direction_offsets:
    dw -0x40
    dw -2
    dw 2
    dw 0x40
    
random:
    REP #0x20
    LDA z:addr(rng_seed)
    ORA #1 ; This makes the PRNG 15-bit instead of 16-bit for absolutely no reason. Should have been INC A.
    STA z:multiply.FIRST
    LDA #899
    STA z:multiply.SECOND
    JSL multiply
    LDA z:multiply.RESULT
    STA z:multiply_and_divide_by_0x10000.FIRST
    STA z:addr(rng_seed)
    TXA
    XBA
    STA z:multiply_and_divide_by_0x10000.SECOND
    JSL multiply_and_divide_by_0x10000
    LDA z:multiply_and_divide_by_0x10000.RESULT
    RTL

multiply_and_divide_by_0x10000:
i16
    .RESULT = 0x40 ; Result
    .FIRST = 0x42 ; Argument
    .SECOND = 0xDB ; Argument
    .MULTIPLICATION = 0x44
    STZ z:.MULTIPLICATION
    STZ z:.RESULT
    LDY #8

-
    ASL z:.MULTIPLICATION
    ROL z:.RESULT
    ASL z:.SECOND
    BCC .zero_bit
    LDA z:.FIRST
    CLC
    ADC z:.MULTIPLICATION
    STA z:.MULTIPLICATION
    BCC .zero_bit
    INC z:.RESULT

.zero_bit:
    DEY
    BNE -
    RTL

multiply:
i16
    .FIRST = 0x40 ; Argument
    .SECOND = 0x42 ; Argument
    .RESULT = 0x44 ; Result
    LDY #0x10

-
    ASL z:.RESULT
    ASL z:.FIRST
    BCC .zero_bit
    LDA z:.SECOND
    CLC
    ADC z:.RESULT
    STA z:.RESULT

.zero_bit:
    DEY
    BNE -
    RTL

; Unused function
is_close_to_player_1:
i16
    REP #0x20
    LDY #addr(player_1)
    SEP #0x20
    LDA a:sprite.x_position, Y
    SEC
    SBC z:sprite.x_position, X
    ; Absolute value
    BCS +
    EOR #0xFF
    INC A
+

    CMP #0x40
    BCS .return_false
    LDA a:sprite.y_position, Y
    SEC
    SBC z:sprite.y_position, X
    ; Absolute value
    BCS +
    EOR #0xFF
    INC A
+

.return_true:
    CMP #0x40
    BCS .return_false
    SEC
    RTL

.return_false:
    CLC
    RTL

write_paused_text:
    SEP #0x20
    LDA #0x80
    STA a:VMAIN
    
    REP #0x20
    LDA #BG3_BASE + 0xCC
    STA a:VMADDL
    
    .TILE = 0x4E8
rept 8
    LDA #.TILE
    STA a:VMDATAL
    .TILE = .TILE + 1
endr
    
    LDA #BG3_BASE + 0xEC
    STA a:VMADDL

    .TILE = 0x4F8
rept 8
    LDA #.TILE
    STA a:VMDATAL
    .TILE = .TILE + 1
endr
    RTL

clear_paused_text:
    SEP #0x20
    LDA #0x80
    STA a:VMAIN
    
    REP #0x20
    LDA #BG3_BASE + 0xCC
    STA a:VMADDL
    
rept 8
    LDA #0
    STA a:VMDATAL
endr
    
    LDA #BG3_BASE + 0xEC
    STA a:VMADDL

rept 8
    LDA #0
    STA a:VMDATAL
endr
    RTL

; Dead code start

sub_C6207D:
    REP #0x20
    LDA #0
    STA z:0x40
    JSL sub_C620A4
    LDA #1
    STA z:0x40
    JSL sub_C620A4
    LDA #2
    STA z:0x40
    JSL sub_C620A4
    LDA #3
    STA z:0x40
    JSL sub_C620A4
    RTL

sub_C620A4:
    SEP #0x20
    create_object sub_C620C4
    REP #0x20
    BCS .locret_C620C3
    LDA z:0x40
    STA a:0x20, Y

.locret_C620C3:
    RTL

sub_C620C4:
i16
    REP #0x20
    LDY #addr(player_1)

.loc_C620C9:
    SEP #0x20
    LDA a:4, Y
    BEQ .loc_C620FA
    LDA a:0x11, Y
    SEC
    SBC z:0x11, X
    BEQ .loc_C620F2
    BCS .loc_C620DD
    EOR #0xFF
    INC A

.loc_C620DD:
    CMP #0x10
    BCS .loc_C620FA
    LDA a:0x14, Y
    SEC
    SBC z:0x14, X

.loc_C620E7:
    BCS .loc_C620EC
    EOR #0xFF
    INC A

.loc_C620EC:
    CMP #0x10
    BCS .loc_C620FA
    SEC
    RTL

.loc_C620F2:
    LDA a:0x14, Y
    SEC
    SBC z:0x14, X
    BNE .loc_C620E7

.loc_C620FA:
    REP #0x20
    LDA a:6, Y
    TAY
    CMP #0xFFFF
    BNE .loc_C620C9
    CLC
    RTL

sub_C62107:
i16
    SEP #0x20
    STZ z:0x4E

.loc_C6210B:
    REP #0x20
    LDA z:0x40
    PHA
    LDA z:0x50
    PHA
    SEP #0x20
    LDA f:[z:0x50]
    STA z:0x40
    LDA z:0x4E
    LDY #0
    JSL set_palette
    REP #0x20
    PLA
    STA z:0x50
    PLA
    STA z:0x40
    INC z:0x50
    SEP #0x20
    INC z:0x4E
    LDA z:0x4E
    CMP #0x10
    BNE .loc_C6210B
    RTL

; Dead code end

update_palettes:
i16
    SEP #0x20
    LDX #addr(palette_slots)

-
    LDA z:palette_slot.flags, X
    BIT #PALETTE_SLOT_FLAG_NEEDS_UPDATE
    BEQ .next
    CMP #PALETTE_SLOT_FLAG_NEEDS_UPDATE | PALETTE_SLOT_FLAG_FADING
    BNE .fade
    JSL load_a_palette
    SEP #0x20
    BRA .next

.fade:
    STA z:palette_slot.flags, X
    JSL fade_a_palette
    SEP #0x20

.next:
    INX
    INX
    INX
    INX
    INX
    INX
    INX
    INX
    CPX #addr(palette_slots + palette_slot.sizeof * 8)
    BNE -

-
    LDA z:palette_slot.flags, X
    BIT #PALETTE_SLOT_FLAG_NEEDS_UPDATE
    BEQ .next_b
    CMP #PALETTE_SLOT_FLAG_NEEDS_UPDATE | PALETTE_SLOT_FLAG_FADING
    BNE .fade_b
    JSL load_b_palette
    SEP #0x20
    BRA .next_b

.fade_b:
    STA z:palette_slot.flags, X
    JSL fade_b_palette
    SEP #0x20

.next_b:
    INX
    INX
    INX
    INX
    INX
    INX
    INX
    INX
    CPX #addr(palette_slots.end)
    BNE -
    
    LDA a:addr(palettes_require_transfer)
    BEQ .ret
    STZ a:addr(palettes_require_transfer)
    REP #0x20
    LDA #addr(transfer_palettes)
    STA z:schedule_vblank_function.FUNCTION
    SEP #0x20
    LDA #bank(transfer_palettes)
    STA z:schedule_vblank_function.FUNCTION + 2
    JSL schedule_vblank_function

.ret:
    RTL

load_a_palette:
    REP #0x20
    LDA #addr(a_palettes)
    STA z:load_palette.BASE
    SEP #0x20
    LDA #bank(a_palettes)
    STA z:load_palette.BASE + 2
    BRA load_palette

load_b_palette:
    REP #0x20
    LDA #addr(b_palettes)
    STA z:load_palette.BASE
    SEP #0x20
    LDA #bank(b_palettes)
    STA z:load_palette.BASE + 2
    ; fallthrough

load_palette:
    .BASE = 0x53 ; Argument
    .PALETTE = 0x50
    .ROM_OFFSET = 0x42
    SEP #0x20
    STZ z:palette_slot.fade_counter, X
    LDA z:palette_slot.flags, X
    AND #~PALETTE_SLOT_FLAG_NEEDS_UPDATE
    STA z:palette_slot.flags, X
    
    REP #0x20
    LDA z:palette_slot.offset, X
    CLC
    ADC #addr(palettes)
    STA z:.PALETTE
    SEP #0x20
    LDA #bank(palettes)
    STA z:.PALETTE + 2
    
    REP #0x20
    LDA z:palette_slot.palette_index, X
    AND #0xFF
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    STA z:.ROM_OFFSET
    CLC
    
    ADC z:.BASE
    STA z:.BASE
    ; Copy
rept 16
    LDA f:[z:.BASE]
    STA f:[z:.PALETTE]
    INC z:.BASE
    INC z:.BASE
    INC z:.PALETTE
    INC z:.PALETTE
endr
    
    LDA a:addr(palettes_require_transfer)
    ORA #1
    STA a:addr(palettes_require_transfer)
    RTL

fade_palette.ret:
    RTL
    
fade_a_palette:
    REP #0x20
    LDA #addr(a_palettes)
    STA z:fade_palette.BASE
    SEP #0x20
    LDA #bank(a_palettes)
    STA z:addr(fade_palette.BASE + 2)
    BRA fade_palette
    
    SEP #0x20 ; Dead code
    
fade_b_palette:

    REP #0x20
    LDA #addr(b_palettes)
    STA z:fade_palette.BASE
    SEP #0x20
    LDA #bank(b_palettes)
    STA z:fade_palette.BASE + 2
    ; fallthrough

fade_palette:
    .BASE = 0x53 ; Argument
    .LOOP_COUNTER = 0x4A
    
    ; Calculate the step size. TODO: figure what it does
    REP #0x20
    LDA z:palette_slot.fade_flags, X
    PHX
    AND #0xF
    TAX
    TAY
    SEP #0x20
    LDA f:fade_steps_related_2, X
    PLX
    AND a:addr(palette_fade_disable_mask) ; Always zero, never set
    BNE .ret ; Never happens
    PHX
    REP #0x20
    TYA
    TAX
    SEP #0x20
    LDA f:fade_steps_related, X
    PLX
    STA z:step_color.STEP
    
    LDA z:palette_slot.fade_counter, X
    SEC
    SBC z:step_color.STEP
    
    STA z:palette_slot.fade_counter, X
    BCS +
    STZ z:palette_slot.fade_counter, X
    LDA z:palette_slot.flags, X
    AND #~PALETTE_SLOT_FLAG_NEEDS_UPDATE
    STA z:palette_slot.flags, X
+

    REP #0x20
    LDA z:palette_slot.offset, X
    CLC
    ADC #addr(palettes)
    STA z:copy_color.DEST
    SEP #0x20
    LDA #bank(palettes)
    STA z:copy_color.DEST + 2
    REP #0x20
    LDA z:palette_slot.palette_index, X
    AND #0xFF
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    STA z:0x42 ; Never read again
    CLC
    ADC z:copy_color.SRC
    STA z:copy_color.SRC
    
    LDA #0x10
    STA z:.LOOP_COUNTER

-
    JSL step_color
    REP #0x20
    DEC z:.LOOP_COUNTER
    BNE -

    RTL

copy_color:
    .SRC = 0x53 ; Argument
    .DEST = 0x50 ; Argument
    REP #0x20
    LDA f:[z:.SRC]
    STA f:[z:.DEST]
    INC z:.SRC
    INC z:.SRC
    INC z:.DEST
    INC z:.DEST
    SEP #0x20
    LDA a:addr(palettes_require_transfer)
    ORA #1
    STA a:addr(palettes_require_transfer)
    RTL
    
step_color:
    .SRC_PTR = 0x50 ; Argument
    .DEST_PTR = 0x53 ; Argument
    .STEP = 0x40 ; Argument
    .DEST_COLOR = 0x48
    .SRC_COLOR = 0x42
    .OUT_COLOR = 0x46
    
    REP #0x20
    LDA z:palette_slot.flags, X
    AND #PALETTE_SLOT_FLAG_NEEDS_UPDATE
    BEQ copy_color
    
    LDA f:[z:.SRC_PTR]
    STA z:.SRC_COLOR
    LDA f:[z:0x53]
    STA z:.DEST_COLOR
    
    ; Red
    STZ z:.OUT_COLOR
    SEP #0x20
    LDA z:.DEST_COLOR
    AND #0x1F
    STA z:step_color_value.DEST_VALUE
    LDA z:.SRC_COLOR
    AND #0x1F
    STA z:step_color_value.SRC_VALUE
    JSL step_color_value
    
    ; Store
    SEP #0x20
    AND #0x1F
    STA z:.OUT_COLOR
    
    ; Green
    REP #0x20
    LDA z:.DEST_COLOR
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    SEP #0x20
    AND #0x1F
    STA z:step_color_value.DEST_VALUE
    REP #0x20
    LDA z:.SRC_COLOR
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    SEP #0x20
    AND #0x1F
    STA z:step_color_value.SRC_VALUE
    JSL step_color_value

    ; Store
    REP #0x20
    AND #0x1F
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    ORA z:.OUT_COLOR
    STA z:.OUT_COLOR
    
    ; Blue
    LDA z:.DEST_COLOR + 1
    LSR A
    LSR A
    AND #0x1F
    STA z:step_color_value.DEST_VALUE
    LDA z:.SRC_COLOR + 1
    LSR A
    LSR A
    AND #0x1F
    STA z:step_color_value.SRC_VALUE
    JSL step_color_value

    ; Store
    SEP #0x20
    AND #0x1F
    ASL A
    ASL A
    ORA z:.OUT_COLOR + 1
    STA z:.OUT_COLOR + 1
    
    ; Update
    REP #0x20
    LDA z:.OUT_COLOR
    STA f:[z:.SRC_PTR]
    
    INC z:.SRC_PTR
    INC z:.SRC_PTR
    INC z:.DEST_PTR
    INC z:.DEST_PTR
    RTL

step_color_value:
    .SRC_VALUE = 0x44 ; Argument
    .DEST_VALUE = 0x41 ; Argument
    .STEP = step_color.STEP ; Argument
    ; A = SRC_VALUE on entry
    
    SEP #0x20
    SEC
    SBC z:.DEST_VALUE
    BCS .fade ; SRC > DEST
    
    LDA z:.DEST_VALUE
    SEC
    SBC z:.SRC_VALUE
    CMP z:palette_slot.fade_counter, X
    BCC .ret_src ; DEST - SRC > counter, it's too early to start fading the source

.fade:
    LDA a:addr(palettes_require_transfer)
    ORA #1
    STA a:addr(palettes_require_transfer)
    
    LDA z:.SRC_VALUE
    CMP z:.DEST_VALUE
    BEQ .ret ; SRC = DEST, nothing to do
    
    BCC .increase
    SEC
    SBC z:.STEP
    BCS +
    LDA z:.DEST_VALUE ; Overflowed, set to dest directly
+
    RTL

.increase:
    CLC
    ADC z:.STEP
    CMP #0x1F
    BCC +
    LDA z:.DEST_VALUE ; Overflowed, set to dest directly
+
.ret
    RTL

.ret_src:
    LDA z:.SRC_VALUE
    RTL

fade_steps_related:
    db 0x20, 0x10
    db 8, 4
    db 2, 1
    db 1, 1
    db 1, 1
    db 1, 1
    db 1, 1
    db 1, 1
    
fade_steps_related_2:
    db 0, 0
    db 0, 0
    db 0, 0
    db 1, 3
    db 7, 0xF
    db 0x1F, 0x3F
    db 0x7F, 0xFF
    db 0xFF, 0xFF
    
; A      = Palette slot to assign
; z:0x40 = Palette number to use
; Y      = Fade flags?
    
set_palette:
    .PALETTE = 0x40
    REP #0x20
    PHX
    AND #0xF
    ASL A
    ASL A
    ASL A
    CLC
    ADC #addr(palette_slots)
    TAX
    SEP #0x20
    LDA z:.PALETTE
    STA z:palette_slot.palette_index, X
    TYA
    STA z:palette_slot.fade_flags, X
    LDA #0x20
    STA z:palette_slot.fade_counter, X
    LDA #1
    STA z:palette_slot.flags, X
    TYA
    AND #0xFF
    BNE .needs_fade
    LDA #3
    STA z:palette_slot.flags, X

.needs_fade:
    PLX
    RTL

process_vblank_queue:
    .FUNCTION = 0x50
    .PTR_ARG = 0x53
    .WORD_ARG_1 = 0x40
    .WORD_ARG_2 = 0x42
    
    REP #0x20
    LDA a:addr(vblank_queue_read_end)
    CMP a:addr(vblank_queue_write_end)
    BNE +
    RTL ; Cyclic buffer empty
+

    TAX
    CLC
    ADC #vblank_queued_function.sizeof
    CMP #vblank_queue_cyclic_buffer.end - vblank_queue_cyclic_buffer
    BCC +
    LDA #0 ; Wrap around
+

    STA a:addr(vblank_queue_read_end)
    SEP #0x20
    LDA a:addr(vblank_queue_cyclic_buffer.function), X
    STA z:.FUNCTION
    LDA a:addr(vblank_queue_cyclic_buffer.function + 1), X
    STA z:.FUNCTION + 1
    LDA a:addr(vblank_queue_cyclic_buffer.function + 2), X
    STA z:.FUNCTION + 2
    
    LDA a:addr(vblank_queue_cyclic_buffer.ptr_arg), X
    STA z:.PTR_ARG
    LDA a:addr(vblank_queue_cyclic_buffer.ptr_arg + 1), X
    STA z:.PTR_ARG + 1
    LDA a:addr(vblank_queue_cyclic_buffer.ptr_arg + 2), X
    STA z:.PTR_ARG + 2
    
    REP #0x20
    LDA a:addr(vblank_queue_cyclic_buffer.word_arg_1), X
    STA z:.WORD_ARG_1
    LDA a:addr(vblank_queue_cyclic_buffer.word_arg_2), X
    STA z:.WORD_ARG_2
    
    JSL call_far_function_at_0050
    JML process_vblank_queue

transfer_palettes:
    SEP #0x20
    LDA #0
    STA a:CGADD
    LDA #0
    STA a:DMAP5
    LDA #0x22
    STA a:BBAD5
    LDA #low(palettes)
    STA a:A1TL5
    LDA #high(palettes)
    STA a:A1TH5
    LDA #bank(palettes)
    STA a:A1B5
    LDA #low(palettes.end - palettes)
    STA a:DASL5
    LDA #high(palettes.end - palettes)
    STA a:DASH5
    LDA #0x20
    STA a:MDMAEN
    RTL

; Unused
transfer_palette_from_address:
    .ADDRESS = 0x53
    SEP #0x20
    LDA #0
    STA a:CGADD
    SEP #0x20
    LDA #0
    STA a:DMAP5
    LDA #0x22
    STA a:BBAD5
    LDA a:.ADDRESS
    STA a:A1TL5
    LDA a:.ADDRESS + 1
    STA a:A1TH5
    LDA a:.ADDRESS + 2
    STA a:A1B5
    LDA #0x20 ; One palette
    STA a:DASL5
    LDA #0
    STA a:DASH5
    LDA #0x20
    STA a:MDMAEN
    RTL

schedule_vblank_function:
    .FUNCTION = 0x50 ; Argument
    .PTR_ARG = 0x53 ; Argument
    .WORD_ARG_1 = 0x40 ; Argument
    .WORD_ARG_2 = 0x42 ; Argument
    
    REP #0x20
    PHX
    LDA a:addr(vblank_queue_write_end)
    TAX
    CLC
    ADC #vblank_queued_function.sizeof
    CMP #vblank_queue_cyclic_buffer.end - vblank_queue_cyclic_buffer
    BCC +
    LDA #0 ; Wrap around
+

    CMP a:addr(vblank_queue_read_end)
    BEQ .out_of_space
    TAY
    SEP #0x20

    LDA z:.FUNCTION
    STA a:addr(vblank_queue_cyclic_buffer.function), X
    LDA z:.FUNCTION + 1
    STA a:addr(vblank_queue_cyclic_buffer.function + 1), X
    LDA z:.FUNCTION + 2
    STA a:addr(vblank_queue_cyclic_buffer.function + 2), X
    
    LDA z:.PTR_ARG
    STA a:addr(vblank_queue_cyclic_buffer.ptr_arg), X
    LDA z:.PTR_ARG + 1
    STA a:addr(vblank_queue_cyclic_buffer.ptr_arg + 1), X
    LDA z:.PTR_ARG + 2
    STA a:addr(vblank_queue_cyclic_buffer.ptr_arg + 2), X
    
    REP #0x20
    LDA z:.WORD_ARG_1
    STA a:addr(vblank_queue_cyclic_buffer.word_arg_1), X
    LDA z:.WORD_ARG_2
    STA a:addr(vblank_queue_cyclic_buffer.word_arg_2), X
    TYA
    STA a:addr(vblank_queue_write_end)

.done:
    PLX
    RTL

.out_of_space:
    INC a:addr(vblank_queue_overflows)
    BRA .done

reset_vblank_queue:
    REP #0x20
    STZ a:addr(vblank_queue_read_end)
    STZ a:addr(vblank_queue_write_end)
    RTL

render_sprite:
    REP #0x20
    LDA #0xFF
    STA z:render_sprite_animated.FLAG
    BRA +

; TODO: There are two rendering lists and they're somehow coupled with specifically player 1 and 2's rendering list, figure that out
render_sprite_animated:
    .FLAG = 0x40
    REP #0x20
    LDA #0
    STA z:.FLAG
+

    LDA #addr(level_manager_object.rendering_linked_list)
    STA z:0x56
    LDA a:addr(level_manager_object.rendering_linked_list)

-
    TAY
    LDA a:rendering_linked_list.neighbor_y, Y
    AND #0xFF
    CMP z:sprite.y_position, X
    BCC .found
    STY z:0x56
    LDA a:rendering_linked_list.prev, Y
    CMP #0xFFFF
    BNE -

.found
    LDY a:addr(first_sprite_ptr)
    LDA [z:0x56]
    STA a:rendering_linked_list.prev, Y
    TYA
    STA [z:0x56]
    LDA z:sprite.y_position, X
    STA a:rendering_linked_list.neighbor_y, Y
    TXA
    STA a:rendering_linked_list.next, Y
    LDA a:addr(first_sprite_ptr)
    CLC
    ADC #object.sizeof
    STA a:addr(first_sprite_ptr)
    
    SEP #0x20
    LDA z:.FLAG
    STA a:rendering_linked_list.animation_paused, Y
    LDA z:sprite.ticks_left_for_frames, X
    DEC A
    BNE +
    LDA z:sprite.current_frame, X
    INC A
    CMP z:sprite.max_frame, X
    BCC +
    REP #0x20
    SEC
    RTL
+

    REP #0x20
    CLC
    RTL

sub_C625D3:
    SEP #0x20
    LDA a:rendering_linked_list.animation_paused, Y
    BEQ load_animation_frame
    
    REP #0x20
    LDA z:sprite.current_frame, X
    PHA
    JSL load_animation_frame
    REP #0x20
    PLA
    STA z:sprite.current_frame, X ; Don't let it advance
    CLC
    RTL

load_animation_frame:
i16
    SEP #0x20
    LDA a:addr(byte_7E0309)
    BIT #0xC0
    BEQ .loc_C62601
    BIT #0x80
    BEQ +
    JML .loc_C62729
+

    EOR #1
    STA a:addr(byte_7E0309)
    RTL

.loc_C62601:
    LDA z:0xC, X
    ASL A
    ASL A
    CLC
    ADC z:8, X
    STA z:0x50
    LDA #0
    ADC z:9, X
    STA z:0x51
    LDA z:0xA, X
    STA z:0x52
    LDY #1
    LDA f:[z:0x50]
    STA z:0x53
    LDA f:[z:0x50], Y
    INY
    STA z:0x53 + 1
    LDA f:[z:0x50], Y
    STA z:0x53 + 2
    LDA f:[z:0x53]
    BNE .loc_C6262C
    JML .loc_C62731

.loc_C6262C:
    STA z:0x4C
    INC z:0x53
    BNE .loc_C62634
    INC z:0x53 + 1

.loc_C62634:
    LDA a:addr(ptr_7E0306)
    STA z:0x56
    LDA a:addr(ptr_7E0306+1)
    STA z:0x57
    LDA a:addr(ptr_7E0306 + 2)
    STA z:0x58
    REP #0x20
    LDA z:0x11, X
    SEC
    SBC #8
    STA z:0x4A
    LDA z:0x14, X
    CLC
    ADC #0x18
    STA z:0xD3
    SEP #0x20

.loc_C62657:
    STZ z:0x41
    LDA f:[z:0x53]
    BPL .loc_C6265F
    DEC z:0x41

.loc_C6265F:
    CLC
    ADC z:0x4A
    STA f:[z:0x56]
    INC z:0x56
    LDA z:0x41
    ADC z:0x4B
    AND #1
    STA z:0x4D
    LDY #1
    LDA f:[z:0x53], Y
    CLC
    ADC z:0xD3
    STA f:[z:0x56]
    INC z:0x56
    STZ z:0x41
    LDA f:[z:0x53], Y
    STA z:0x40
    BPL .loc_C62684
    DEC z:0x41

.loc_C62684:
    REP #0x20
    LDA z:0xD3
    CLC
    ADC z:0x40
    BPL .loc_C62698
    CMP #0xFFE0
    BCS .loc_C62696
    JML .loc_C62712

.loc_C62696:
    BRA .loc_C626A1

.loc_C62698:
    CMP #0xF0
    BCC .loc_C626A1
    JML .loc_C62712

.loc_C626A1:
    SEP #0x20
    INY
    LDA #0
    XBA
    LDA f:[z:0x53], Y
    CLC
    ADC z:0xF, X
    AND #0xF
    PHX
    TAX
    STZ z:0x47
    BIT #8
    BEQ .loc_C626B8
    INC z:0x47

.loc_C626B8:
    LDA f:byte_C307D7+0x58, X
    PLX
    LDY #3
    ORA f:[z:0x53], Y
    STA f:[z:0x56]
    INC z:0x56
    INY
    LDA f:[z:0x53], Y
    AND #0xCF
    ORA z:0xE, X
    ORA z:0x47
    CLC
    ADC z:0x1E, X
    STA f:[z:0x56]
    LDA f:[z:0x53], Y
    AND #0x20
    PHX
    TAX
    LDA f:byte_C307D7+0x58, X
    PLX
    ORA z:0x4D
    LDY #0x200
    STA f:[z:0x56], Y
    INC z:0x56
    LDA a:addr(ptr_7E0306)
    CLC
    ADC #4
    STA a:addr(ptr_7E0306)
    BNE .loc_C626FF
    LDA a:addr(ptr_7E0306+1)
    BIT #1
    BNE .loc_C62729
    INC a:addr(ptr_7E0306+1)
    INC z:0x57

.loc_C626FF:
    REP #0x20
    LDA z:0x53
    CLC
    ADC #5
    STA z:0x53
    SEP #0x20
    DEC z:0x4C
    BEQ .loc_C62731
    JMP a:.loc_C62657
.loc_C62712:
    REP #0x20
    DEC z:0x56
    DEC z:0x56
    LDA z:0x53
    CLC
    ADC #5
    STA z:0x53
    SEP #0x20
    DEC z:0x4C
    BEQ .loc_C62731
    JMP a:.loc_C62657

.loc_C62729:
    LDA a:addr(byte_7E0309)
    ORA #0x80
    STA a:addr(byte_7E0309)

.loc_C62731:
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_SCREEN_TRANSITION | GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
    BNE .loc_C6273F
    LDA z:0xD, X
    DEC A
    BEQ .loc_C62743
    STA z:0xD, X

.loc_C6273F:
    REP #0x20
    CLC
    RTL

.loc_C62743:
    LDA z:0xC, X
    INC A
    CMP z:0xB, X
    BCC .loc_C62763
    STZ z:0xC, X
    LDA z:8, X
    STA z:0x50
    LDA z:9, X
    STA z:0x51
    LDA z:0xA, X
    STA z:0x52
    LDY #3
    LDA f:[z:0x50], Y
    STA z:0xD, X
    REP #0x20
    SEC
    RTL

.loc_C62763:
    STA z:0xC, X
    ASL A
    ASL A
    CLC
    ADC z:8, X
    STA z:0x50
    LDA #0x7500
    ORA #0x5185
    LDA z:0xA, X
    STA z:0x52
    LDY #3
    LDA f:[z:0x50], Y
    STA z:0xD, X
    REP #0x20
    CLC
    RTL

sub_C62781:
    SEP #0x20
    DEC z:0x56
    DEC z:0x56
    JML load_animation_frame.loc_C626FF

sub_C6278B:
i16
    SEP #0x20
    LDA a:addr(byte_7E0309)
    BIT #0xC0
    BEQ .loc_C627A2
    BIT #0x80
    BEQ .loc_C6279C
    JML .loc_C6280B

.loc_C6279C:
    EOR #1
    STA a:addr(byte_7E0309)
    RTL

.loc_C627A2:
    LDA a:addr(ptr_7E0306)
    STA z:0x56
    LDA a:addr(ptr_7E0306+1)
    STA z:0x57
    LDA a:addr(ptr_7E0306 + 2)
    STA z:0x58
    LDA #0xF0
    CLC
    ADC z:0x42
    STA f:[z:0x56]
    INC z:0x56
    LDA #0x10
    CLC
    ADC z:0x45
    STA f:[z:0x56]
    INC z:0x56
    LDY #2
    LDA #0
    STA z:0x47
    XBA
    LDA f:[z:0x50], Y
    PHX
    TAX
    BIT #8
    BEQ .loc_C627D5
    INC z:0x47

.loc_C627D5:
    LDA f:byte_C307D7+0x58, X
    PLX
    LDY #3
    ORA f:[z:0x50], Y
    STA f:[z:0x56]
    INC z:0x56
    INY
    LDA f:[z:0x50], Y
    AND #0xF
    ORA z:0x48
    ORA z:0x47
    STA f:[z:0x56]
    LDA #2
    LDY #0x200
    STA f:[z:0x56], Y
    LDA a:addr(ptr_7E0306)
    CLC
    ADC #4
    STA a:addr(ptr_7E0306)
    BNE .locret_C6280A
    LDA a:addr(ptr_7E0306+1)
    BIT #1
    BNE .loc_C6280B
    INC a:addr(ptr_7E0306+1)

.locret_C6280A:
    RTL

.loc_C6280B:
    LDA a:addr(byte_7E0309)
    ORA #0x80
    STA a:addr(byte_7E0309)
    RTL

start_animation:
    .ANIMATION = 0x50
i16
    SEP #0x20
    LDA f:[z:.ANIMATION]
    STA z:player.max_frame, X
    STZ z:player.current_frame, X
    REP #0x20
    INC z:.ANIMATION
    LDA z:.ANIMATION
    STA z:player.current_animation, X
    SEP #0x20
    LDA z:.ANIMATION + 2
    STA z:player.current_animation+2, X
    LDY #3
    LDA f:[z:.ANIMATION], Y
    STA z:player.ticks_left_for_frames, X
    REP #0x20
    RTL

sub_C62834:
    REP #0x30
    LDX a:addr(word_7E00A0)
    CPX a:addr(word_7E00A2)
    BEQ .loc_C6288D
    SEP #0x20
    LDA z:0x6C
    BNE .loc_C6288D
    LDA a:0x80, X
    STA z:0x40
    REP #0x20
    AND #0xFF
    TAX
    SEP #0x20
    LDA f:byte_C62896, X
    CMP z:0x6E
    BCS .loc_C6285D
    LDA z:0x6F
    BNE .loc_C62881

.loc_C6285D:
    LDA f:byte_C62896, X
    STA z:0x6E
    LDA z:0x40
    CMP z:0x70
    BNE .loc_C62876
    LDA #0
    STA a:APUIO2
    STA z:0x6F
    STA z:0x6E
    DEC A
    STA z:0x70
    RTL

.loc_C62876:
    STA z:0x70
    STA a:APUIO2
    LDA f:byte_C628C8, X
    STA z:0x6F

.loc_C62881:
    REP #0x20
    LDA a:addr(word_7E00A0)
    INC A
    AND #0x1F
    STA a:addr(word_7E00A0)

.loc_C6288D:
    SEP #0x20
    LDA z:0x6F
    BEQ .locret_C62895
    DEC z:0x6F

.locret_C62895:
    RTL

byte_C62896:
    db 0x28, 0xA, 0xA, 0xA, 0x14, 0x14, 0xA, 0x14, 0x14, 0x14, 0x14
    db 0x1E, 0x14, 0x1E, 0xA, 0x14, 0x14, 0x1E, 0x14, 0xA, 0x14, 0x14
    db 0xA, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0xA, 0x1E, 0x1E, 0x14
    db 0xA, 0xA, 0xA, 0xA, 0xA, 0xA, 0xA, 0xA, 0xA, 0xA, 0xA, 0xA, 0xA
    db 0xA, 0xA, 0xA, 0xA
byte_C628C8:
    db 0, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10
    db 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x30, 0x10, 0x10, 0x10
    db 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10
    db 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10
    db 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0xE2
    db 0x20, 0xA5, 0x40, 0xC2, 0x20, 0xDA, 0xAD, 0xA2, 0, 0xAA, 0x1A
    db 0xCD, 0xA0, 0, 0xF0, 0x10, 0xE2, 0x20, 0xA5, 0x40, 0x9D, 0x80
    db 0, 0xAD, 0xA2, 0, 0x1A, 0x29, 0x1F, 0x8D, 0xA2, 0, 0xFA
    db 0x6B, 0xE2, 0x20, 0xA9, 0x80, 0x8D, 0x15, 0x21, 0xA9, 1, 0x8D
    db 0x40, 0x43, 0xA9, 0x18, 0x8D, 0x41, 0x43, 0xC2, 0x20, 0xAD
    db 0x9B, 0xC, 0x85, 0x5C, 0x22, 0x3A, 0x29, 0xC6, 0x6B, 0xE2
    db 0x20, 0xA5, 0x5C, 0x8D, 0x16, 0x21, 0xA5, 0x5D, 0x8D, 0x17
    db 0x21, 0xAD, 0x50, 0, 0x8D, 0x42, 0x43, 0xAD, 0x51, 0, 0x8D
    db 0x43, 0x43, 0xAD, 0x52, 0, 0x8D, 0x44, 0x43, 0xA5, 0x40, 0x8D
    db 0x45, 0x43, 0xA5, 0x41, 0x8D, 0x46, 0x43, 0xA9, 0x10, 0x8D
    db 0xB, 0x42, 0x6B
graphics_decompression_8192_bytes:
    REP #0x20
    LDA #0
    STA z:0x48

.loc_C6296F:
    LDA f:[z:0x53]
    TAY
    INC z:0x53
    INC z:0x53
    SEP #0x20
    LDA f:[z:0x53]
    STA z:0x52
    REP #0x20
    INC z:0x53
    JSL graphics_decompression_1024_bytes
    REP #0x20
    INC z:0x48
    LDA z:0x48
    CMP #4
    BNE .loc_C6296F
    RTL

sub_C62990:
    REP #0x20
    STZ z:0x48
    LDA z:0x53
    TAY
    SEP #0x20
    LDA z:0x53 + 2
    STA z:0x52

.loc_C6299D:
    JSL graphics_decompression_1024_bytes
    REP #0x20
    INC z:0x48
    LDA z:0x48
    CMP #8
    BNE .loc_C6299D
    RTL

graphics_decompression_1024_bytes:
    REP #0x20
    LDA z:0x48
    AND #0xF
    ASL A
    TAX
    LDA f:graphic_load_offsets, X
    TAX
    SEP #0x20
    LDA z:0x52
    PHA
    PLB
    PHX
    JSL graphics_decompression_128_bytes
    JSL graphics_decompression_128_bytes
    JSL graphics_decompression_128_bytes
    JSL graphics_decompression_128_bytes
    PLX
    INX
    JSL graphics_decompression_128_bytes
    JSL graphics_decompression_128_bytes
    JSL graphics_decompression_128_bytes
    JSL graphics_decompression_128_bytes
    SEP #0x20
    LDA #0
    PHA
    PLB
    REP #0x20
    RTL

graphics_decompression_128_bytes:
    SEP #0x20
    LDA #0x10
    STA z:0x46

.loc_C629F3:
    LDA #8
    STA z:0x44
    STZ z:0x42
    LDA a:0, Y
    STA z:0x43
    INY

.loc_C629FF:
    ASL z:0x43
    BCS .loc_C62A07
    LDA z:0x42
    BRA .loc_C62A0D

.loc_C62A07:
    LDA a:0, Y
    STA z:0x42
    INY

.loc_C62A0D:
    STA f:0x7E2800, X
    INX
    INX
    DEC z:0x44
    BNE .loc_C629FF
    DEC z:0x46
    BNE .loc_C629F3
    REP #0x20
    TXA
    CLC
    ADC #0x100
    TAX
    RTL

graphics_decompression_81aa_terminated_interleaved:
    REP #0x20
    LDY z:0x53
    SEP #0x20
    LDA z:0x53 + 2
    PHA
    PLB
    PHX
    JSL graphics_decompression_81aa_terminated
    PLX
    INX
    JSL graphics_decompression_81aa_terminated
    SEP #0x20
    LDA #0
    PHA
    PLB
    REP #0x20
    RTL

graphics_decompression_81aa_terminated:
    SEP #0x20
    LDA #8
    STA z:0x44
    STZ z:0x42
    LDA a:0, Y
    STA z:0x43
    INY
    CMP #0x81
    BNE .loc_C62A5F
    LDA a:0, Y
    CMP #0xAA
    BNE .loc_C62A5F
    INY
    INY
    BRA .locret_C62A7E

.loc_C62A5F:
    ASL z:0x43
    BCS .loc_C62A67
    LDA z:0x42
    BRA .loc_C62A6D

.loc_C62A67:
    LDA a:0, Y
    STA z:0x42
    INY

.loc_C62A6D:
    STA f:0x7E2800, X
    INX
    INX
    DEC z:0x44
    BNE .loc_C62A5F
    REP #0x20
    TXA
    CMP z:0x40
    BCC graphics_decompression_81aa_terminated

.locret_C62A7E:
    RTL

graphic_load_offsets:
    dw 0     ; 0
    dw 0x100    ; 1
    dw 0x800    ; 2
    dw 0x900    ; 3
    dw 0x1000    ; 4
    dw 0x1100    ; 5
    dw 0x1800    ; 6
    dw 0x1900    ; 7
    dw 0x2000    ; 8
    dw 0x2100    ; 9
    dw 0x2800    ; 0xA
    dw 0x2900    ; 0xB
    dw 0x3000    ; 0xC
    dw 0x3100    ; 0xD
    dw 0x3800    ; 0xE
    dw 0x3900    ; 0xF
some_graphic_offsets_array:
    dw 0x3900, 0x3800, 0x3100, 0x3000, 0x2900, 0x2800, 0x2100
    dw 0x2000, 0x1900, 0x1800, 0x1100, 0x1000, 0x900, 0x800, 0x100
    dw 0
hidden_bonus_object:
    SEP #0x20
    create_object sub_C62B03
    REP #0x20
    LDA f:[z:0x50]
    STA a:0x16, Y
    INC z:0x50
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:0x18, Y
    INC z:0x50
    INC z:0x50
    INC z:0x50
    LDA #0
    STA a:0x20, Y
    STA a:0x22, Y
    STA a:0x24, Y
    STA a:0x26, Y
    STA a:0x28, Y
    STA a:0x2A, Y

.locret_C62B02:
    RTL

sub_C62B03:
i16
    REP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_SCREEN_TRANSITION
    BNE hidden_bonus_object.locret_C62B02
    LDA #bank(lives_drop_to_zero_bonus)
    STA z:0x53 + 2
    LDA z:0x16, X
    ASL A
    PHX
    TAX
    LDA f:hidden_bonus_verifiers_array, X
    STA z:0x53
    PLX
    LDY #addr(player_1)
    JSL call_far_function_at_0053
    BCS .loc_C62B35
    LDY #addr(player_2)
    PHX
    INX
    INX
    JSL call_far_function_at_0053
    PLX
    BCS .loc_C62B35
    RTL

.loc_C62B35:
    set_handler .loc_C62B42

.loc_C62B42:
    JSL sub_C43B6E
    BCS hidden_bonus_object.locret_C62B02
    REP #0x20
    LDA z:0x18, X
    JSL create_bonus_object
    LDY #SOUND_SECRET_BONUS_APPEAR
    JSL play_sound
    JSL delete_object
    RTL

lives_drop_to_zero_bonus:
    REP #0x20
    LDA a:addr(object.handler), Y
    CMP #addr(_player_death)
    BNE clear_carry
    SEP #0x20
    LDA a:0x3D, Y
    CMP #1
    BNE clear_carry
    ; fallthrough

set_carry:
    SEC
    RTL

clear_carry:
    CLC
    RTL

dont_move_bonus:
    REP #0b100000
    LDA a:4, Y
    AND #0xFF
    BEQ clear_carry
    LDA a:player.down_keys, Y
    BEQ .loc_C62B84
    STZ z:0x20, X

.loc_C62B84:
    INC z:0x20, X
    LDA z:0x20, X
    CMP #0x500
    BEQ set_carry
    CLC
    RTL

dont_move_on_exit_bonus:
    REP #0x20
    LDA a:4, Y
    AND #0xFF
    BEQ clear_carry
    PHX
    TYX
    JSL get_object_square_index
    PLX
    TAY
    LDA a:addr(collision_map), Y
    AND #BONUS_MASK
    CMP #EXIT
    BEQ .loc_C62BAE
    STZ z:0x20, X

.loc_C62BAE:
    INC z:0x20, X
    LDA z:0x20, X
    CMP #0x500
    BNE .loc_C62BBB
    JML set_carry

.loc_C62BBB:
    CLC
    RTL

press_start_bonus:
    SEP #0x20
    LDA a:player.down_keys+1, Y
    BIT #0x10
    BNE .loc_C62BCA
    JML clear_carry

.loc_C62BCA:
    SEC
    RTL

bombs_in_corners_bonus:
i16
    SEP #0x20
    LDY #0x44
    LDA #1
    JSL verify_bomb_in_location
    LDY #0x5C
    LDA #2
    JSL verify_bomb_in_location
    LDY #0x2C4
    LDA #4
    JSL verify_bomb_in_location
    LDY #0x2DC
    LDA #8
    JSL verify_bomb_in_location
    LDA z:0x20, X
    CMP #0xF
    BEQ .loc_C62BFC
    JML clear_carry

.loc_C62BFC:
    SEC
    RTL

verify_bomb_in_location:
    STA z:0x40
    LDA a:addr(collision_map), Y
    AND #EXIT|BOMB|SOFT_BLOCK|HARD_BLOCK
    CMP #BOMB
    BNE .locret_C62C0F
    LDA z:0x20, X
    ORA z:0x40
    STA z:0x20, X

.locret_C62C0F:
    RTL

uncover_all_bonuses_bonus:
    SEP #0x20
    LDA a:addr(level_manager_object.bonus_count)
    INC A
    CMP a:addr(number_of_visible_bonuses)
    BEQ .loc_C62C1F
    JML clear_carry

.loc_C62C1F:
    SEC
    RTL

combo_of_3_bonus:
    REP #0x20
    TYA
    AND #0x80
    LSR A
    LSR A
    LSR A
    TAY
    SEP #0x20
    LDA a:addr(combo_counters), Y
    CMP #3
    BCC .loc_C62C38
    JML set_carry

.loc_C62C38:
    LDA a:addr(combo_counters+1), Y
    CMP #3
    BCC .loc_C62C43
    JML set_carry

.loc_C62C43:
    LDA a:addr(combo_counters+2), Y
    CMP #3
    BCC .loc_C62C4E
    JML set_carry

.loc_C62C4E:
    LDA a:addr(combo_counters+3), Y
    CMP #3
    BCC .loc_C62C59
    JML set_carry

.loc_C62C59:
    LDA a:addr(combo_counters+4), Y
    CMP #3
    BCC .loc_C62C64
    JML set_carry

.loc_C62C64:
    LDA a:addr(combo_counters+5), Y
    CMP #3
    BCC .loc_C62C6F
    JML set_carry

.loc_C62C6F:
    LDA a:addr(combo_counters+6), Y
    CMP #3
    BCC .loc_C62C7A
    JML set_carry

.loc_C62C7A:
    LDA a:addr(combo_counters+7), Y
    CMP #3
    BCC .loc_C62C85
    JML set_carry

.loc_C62C85:
    LDA a:addr(combo_counters+8), Y
    CMP #3
    BCC .loc_C62C90
    JML set_carry

.loc_C62C90:
    LDA a:addr(combo_counters+9), Y
    CMP #3
    BCC .loc_C62C9B
    JML set_carry

.loc_C62C9B:
    LDA a:addr(combo_counters+0xA), Y
    CMP #3
    BCC .loc_C62CA6
    JML set_carry

.loc_C62CA6:
    LDA a:addr(combo_counters+0xB), Y
    CMP #3
    BCC .loc_C62CB1
    JML set_carry

.loc_C62CB1:
    LDA a:addr(combo_counters+0xC), Y
    CMP #3
    BCC .loc_C62CBC
    JML set_carry

.loc_C62CBC:
    LDA a:addr(combo_counters+0xD), Y
    CMP #3
    BCC .loc_C62CC7
    JML set_carry

.loc_C62CC7:
    LDA a:addr(combo_counters+0xE), Y
    CMP #3
    BCC .loc_C62CD2
    JML set_carry

.loc_C62CD2:
    LDA a:addr(combo_counters+0xF), Y
    CMP #3
    BCC .loc_C62CDD
    JML set_carry

.loc_C62CDD:
    CLC
    RTL

spawn_enemy_bonus:
    SEP #0x20
    LDA z:0x24, X
    BEQ .loc_C62CE9
    JML .loc_C62CF0

.loc_C62CE9:
    INC z:0x24, X
    LDA a:addr(level_manager_object.enemy_count)
    STA z:0x20, X

.loc_C62CF0:
    LDA z:0x20, X
    CMP a:addr(level_manager_object.enemy_count)
    BCS .loc_C62CFB
    JML set_carry

.loc_C62CFB:
    LDA a:addr(level_manager_object.enemy_count)
    STA z:0x20, X
    CLC
    RTL

punch_5_bonus:
    REP #0x20
    LDA a:0, Y
    CMP #addr(punch)
    BEQ .loc_C62D10
    JML clear_carry

.loc_C62D10:
    INC z:0x20, X
    LDA z:0x20, X
    CMP #5
    BEQ .loc_C62D1D
    JML clear_carry

.loc_C62D1D:
    SEC
    RTL

bomb_hit_bonus:
    REP #0x20
    LDA a:0, Y
    CMP #addr(_play_hit_by_bomb_animation)
    BNE .loc_C62D2D
    JML set_carry

.loc_C62D2D:
    CLC
    RTL

place_6_bombs_bonus:
    SEP #0x20
    LDA a:player.current_bomb_count, Y
    CMP #6
    BNE .loc_C62D3C
    JML set_carry

.loc_C62D3C:
    CLC
    RTL

score_20_bonus:
    SEP #0x20
    LDA a:player.score_digits_12, Y
    CMP #0x20
    BNE .loc_C62D4B
    JML set_carry

.loc_C62D4B:
    CLC
    RTL

hidden_bonus_verifiers_array:
    da lives_drop_to_zero_bonus ; 0
    da dont_move_bonus ; 1
    da dont_move_on_exit_bonus; 2
    da press_start_bonus ; 3
    da bombs_in_corners_bonus; 4
    da uncover_all_bonuses_bonus; 5
    da combo_of_3_bonus ; 6
    da spawn_enemy_bonus ; 7
    da punch_5_bonus ; 8
    da bomb_hit_bonus ; 9
    da place_6_bombs_bonus; 0xA
    da score_20_bonus ; 0xB
animation_frame_C62D65:
    animation_frame_tile_count
    frame_oam_tile    0,  -16, 0x027, 0x40
    frame_oam_tile    0,   -8, 0x02f, 0x40
    frame_oam_tile    0,    0, 0x03f, 0x40
    frame_oam_tile   -8,  -16, 0x027, 0x00
    frame_oam_tile   -8,   -8, 0x02f, 0x00
    frame_oam_tile   -8,    0, 0x03f, 0x00
    .end
animation_frame_C62D84:
    animation_frame_tile_count
    frame_oam_tile    0,  -24, 0x027, 0x40
    frame_oam_tile    0,  -16, 0x02f, 0x40
    frame_oam_tile    0,   -8, 0x037, 0x40
    frame_oam_tile    0,    0, 0x03f, 0x40
    frame_oam_tile   -8,  -24, 0x027, 0x00
    frame_oam_tile   -8,  -16, 0x02f, 0x00
    frame_oam_tile   -8,   -8, 0x037, 0x00
    frame_oam_tile   -8,    0, 0x03f, 0x00
    .end
animation_frame_C62DAD:
    animation_frame_tile_count
    frame_oam_tile    0,  -32, 0x027, 0x40
    frame_oam_tile   -8,  -32, 0x027, 0x00
    frame_oam_tile    0,  -24, 0x02f, 0x40
    frame_oam_tile   -8,  -24, 0x02f, 0x00
    frame_oam_tile    0,  -16, 0x029, 0x40
    frame_oam_tile   -8,  -16, 0x029, 0x00
    frame_oam_tile    0,   -8, 0x037, 0x40
    frame_oam_tile    0,    0, 0x03f, 0x40
    frame_oam_tile   -8,   -8, 0x037, 0x00
    frame_oam_tile   -8,    0, 0x03f, 0x00
    .end
animation_frame_C62DE0:
    animation_frame_tile_count
    frame_oam_tile    8,  -24, 0x020, 0x40
    frame_oam_tile    0,  -24, 0x021, 0x40
    frame_oam_tile    0,  -16, 0x029, 0x40
    frame_oam_tile    0,   -8, 0x031, 0x40
    frame_oam_tile    0,    0, 0x039, 0x40
    frame_oam_tile  -16,  -24, 0x020, 0x00
    frame_oam_tile   -8,  -24, 0x021, 0x00
    frame_oam_tile   -8,  -16, 0x029, 0x00
    frame_oam_tile   -8,   -8, 0x031, 0x00
    frame_oam_tile   -8,    0, 0x039, 0x00
    .end
animation_frame_C62E13:
    animation_frame_tile_count
    frame_oam_tile    8,  -24, 0x028, 0x40
    frame_oam_tile    0,  -24, 0x030, 0x40
    frame_oam_tile    0,  -16, 0x038, 0x40
    frame_oam_tile    0,   -8, 0x039, 0x40
    frame_oam_tile  -16,  -24, 0x028, 0x00
    frame_oam_tile   -8,  -24, 0x030, 0x00
    frame_oam_tile   -8,  -16, 0x038, 0x00
    frame_oam_tile   -8,   -8, 0x039, 0x00
    .end
animation_frame_C62E3C:
    animation_frame_tile_count
    frame_oam_tile    8,  -24, 0x02b, 0x40
    frame_oam_tile    8,  -32, 0x023, 0x40
    frame_oam_tile    0,  -32, 0x024, 0x40
    frame_oam_tile    0,  -24, 0x02c, 0x40
    frame_oam_tile    0,  -16, 0x034, 0x40
    frame_oam_tile  -16,  -24, 0x02b, 0x00
    frame_oam_tile  -16,  -32, 0x023, 0x00
    frame_oam_tile   -8,  -32, 0x024, 0x00
    frame_oam_tile   -8,  -24, 0x02c, 0x00
    frame_oam_tile   -8,  -16, 0x034, 0x00
    .end
animation_frame_C62E6F:
    animation_frame_tile_count
    frame_oam_tile    0,  -16, 0x033, 0x40
    frame_oam_tile    0,  -32, 0x032, 0x40
    frame_oam_tile    0,  -24, 0x03a, 0x40
    frame_oam_tile   -8,  -16, 0x033, 0x00
    frame_oam_tile   -8,  -32, 0x032, 0x00
    frame_oam_tile   -8,  -24, 0x03a, 0x00
    .end
animation_frame_C62E8E:
    animation_frame_tile_count
    frame_oam_tile    0,  -18, 0x036, 0x00
    frame_oam_tile   -8,  -34, 0x025, 0x20
    .end
byte_C62E99:
    animation_frame_count
    animation_frame animation_frame_C62D65, 2
    animation_frame animation_frame_C62D84, 2
    animation_frame animation_frame_C62DAD, 2
    animation_frame animation_frame_C62DE0, 2
    animation_frame animation_frame_C62E13, 2
    animation_frame animation_frame_C62E3C, 2
    animation_frame animation_frame_C62E6F, 2
    animation_frame animation_frame_C62E8E, 2
    .end
animation_frame_C62EBA:
    animation_frame_tile_count
    frame_oam_tile  -16,    0, 0x020, 0x60
    frame_oam_tile  -16,  -16, 0x020, 0xE0
    frame_oam_tile    0,  -16, 0x020, 0xA0
    frame_oam_tile    0,    0, 0x020, 0x20
    .end
animation_frame_C62ECF:
    animation_frame_tile_count
    frame_oam_tile    0,    0, 0x022, 0xE0
    frame_oam_tile  -16,    0, 0x022, 0xA0
    frame_oam_tile    0,  -16, 0x022, 0x60
    frame_oam_tile  -16,  -16, 0x022, 0x20
    .end
animation_frame_C62EE4:
    animation_frame_tile_count
    frame_oam_tile  -16,    0, 0x030, 0xE0
    frame_oam_tile  -16,  -16, 0x030, 0x60
    frame_oam_tile    0,    0, 0x030, 0xA0
    frame_oam_tile    0,  -16, 0x030, 0x20
    .end
animation_frame_C62EF9:
    animation_frame_tile_count
    frame_oam_tile    0,    0, 0x032, 0xE0
    frame_oam_tile  -16,    0, 0x032, 0xA0
    frame_oam_tile    0,  -16, 0x032, 0x60
    frame_oam_tile  -16,  -16, 0x032, 0x20
    .end
animation_frame_C62F0E:
    animation_frame_tile_count
    frame_oam_tile  -16,    0, 0x024, 0xA0
    frame_oam_tile    0,    0, 0x024, 0xE0
    frame_oam_tile    0,  -16, 0x024, 0x60
    frame_oam_tile  -16,  -16, 0x024, 0x20
    .end
byte_C62F23:
    animation_frame_count
    animation_frame animation_frame_C62EBA, 5
    animation_frame animation_frame_C62ECF, 4
    animation_frame animation_frame_C62EE4, 2
    animation_frame animation_frame_C62EF9, 1
    animation_frame animation_frame_C62F0E, 1
    .end
animation_frame_C62F38:
    animation_frame_tile_count
    frame_oam_tile    0,   -8, 0x010, 0xE0
    frame_oam_tile    0,    8, 0x000, 0xE0
    frame_oam_tile  -16,    8, 0x000, 0xA0
    frame_oam_tile  -16,   -8, 0x010, 0xA0
    frame_oam_tile    0,  -24, 0x000, 0x60
    frame_oam_tile    0,   -8, 0x010, 0x60
    frame_oam_tile  -16,  -24, 0x000, 0x20
    frame_oam_tile  -16,   -8, 0x010, 0x20
    .end
animation_frame_C62F61:
    animation_frame_tile_count
    frame_oam_tile   32,    0, 0x014, 0x60
    frame_oam_tile   16,    0, 0x016, 0xE0
    frame_oam_tile    0,    0, 0x030, 0xE0
    frame_oam_tile  -48,    0, 0x014, 0x20
    frame_oam_tile  -32,    0, 0x016, 0xA0
    frame_oam_tile  -16,    0, 0x030, 0xA0
    frame_oam_tile   16,   16, 0x020, 0xE0
    frame_oam_tile    0,   16, 0x022, 0xE0
    frame_oam_tile  -32,   16, 0x020, 0xA0
    frame_oam_tile  -16,   16, 0x022, 0xA0
    frame_oam_tile   16,   32, 0x004, 0xE0
    frame_oam_tile    0,   32, 0x006, 0xE0
    frame_oam_tile  -32,   32, 0x004, 0xA0
    frame_oam_tile  -16,   32, 0x006, 0xA0
    frame_oam_tile   32,  -16, 0x014, 0x60
    frame_oam_tile   16,  -48, 0x004, 0x60
    frame_oam_tile   16,  -32, 0x020, 0x60
    frame_oam_tile   16,  -16, 0x016, 0x60
    frame_oam_tile    0,  -48, 0x006, 0x60
    frame_oam_tile    0,  -32, 0x022, 0x60
    frame_oam_tile    0,  -16, 0x030, 0x60
    frame_oam_tile  -32,  -48, 0x004, 0x20
    frame_oam_tile  -16,  -48, 0x006, 0x20
    frame_oam_tile  -32,  -32, 0x020, 0x20
    frame_oam_tile  -16,  -32, 0x022, 0x20
    frame_oam_tile  -48,  -16, 0x014, 0x20
    frame_oam_tile  -32,  -16, 0x016, 0x20
    frame_oam_tile  -16,  -16, 0x030, 0x20
    .end
animation_frame_C62FEE:
    db 0x28
stru_C62FEF:
    frame_oam_tile   16,    0, 0x050, 0xE0
    frame_oam_tile   16,  -16, 0x050, 0x60
    frame_oam_tile  -32,    0, 0x050, 0xA0
    frame_oam_tile  -32,  -16, 0x050, 0x20
    frame_oam_tile   32,    0, 0x046, 0xE0
    frame_oam_tile  -48,    0, 0x046, 0xA0
    frame_oam_tile   32,   16, 0x040, 0xE0
    frame_oam_tile   16,   16, 0x042, 0xE0
    frame_oam_tile    0,   16, 0x044, 0xE0
    frame_oam_tile  -16,   16, 0x044, 0xA0
    frame_oam_tile  -32,   16, 0x042, 0xA0
    frame_oam_tile  -48,   16, 0x040, 0xA0
    frame_oam_tile   32,   32, 0x032, 0xE0
    frame_oam_tile   16,   32, 0x034, 0xE0
    frame_oam_tile    0,   32, 0x036, 0xE0
    frame_oam_tile  -16,   32, 0x036, 0xA0
    frame_oam_tile  -32,   32, 0x034, 0xA0
    frame_oam_tile  -48,   32, 0x032, 0xA0
    frame_oam_tile   16,   48, 0x024, 0xE0
    frame_oam_tile    0,   48, 0x026, 0xE0
    frame_oam_tile  -16,   48, 0x026, 0xA0
    frame_oam_tile  -32,   48, 0x024, 0xA0
    frame_oam_tile   32,  -48, 0x032, 0x60
    frame_oam_tile   32,  -32, 0x040, 0x60
    frame_oam_tile   32,  -16, 0x046, 0x60
    frame_oam_tile   16,  -64, 0x024, 0x6E
    frame_oam_tile   16,  -48, 0x034, 0x60
    frame_oam_tile   16,  -32, 0x042, 0x60
    frame_oam_tile    0,  -64, 0x026, 0x60
    frame_oam_tile    0,  -48, 0x036, 0x60
    frame_oam_tile    0,  -32, 0x044, 0x60
    frame_oam_tile  -16,  -64, 0x026, 0x20
    frame_oam_tile  -32,  -64, 0x024, 0x20
    frame_oam_tile  -16,  -48, 0x036, 0x20
    frame_oam_tile  -32,  -48, 0x034, 0x20
    frame_oam_tile  -48,  -48, 0x032, 0x20
    frame_oam_tile  -16,  -32, 0x044, 0x20
    frame_oam_tile  -32,  -32, 0x042, 0x20
    frame_oam_tile  -48,  -32, 0x040, 0x20
    frame_oam_tile  -48,  -16, 0x046, 0x20
animation_frame_C630B7:
    db 0x30
stru_C630B8:
    frame_oam_tile    0,   -8, 0x010, 0xE0
    frame_oam_tile    0,    8, 0x000, 0xE0
    frame_oam_tile  -16,    8, 0x000, 0xA0
    frame_oam_tile  -16,   -8, 0x010, 0xA0
    frame_oam_tile    0,  -24, 0x000, 0x60
    frame_oam_tile    0,   -8, 0x010, 0x60
    frame_oam_tile  -16,  -24, 0x000, 0x20
    frame_oam_tile  -16,   -8, 0x010, 0x20
    frame_oam_tile   16,    0, 0x050, 0xE0
    frame_oam_tile   16,  -16, 0x050, 0x60
    frame_oam_tile  -32,    0, 0x050, 0xA0
    frame_oam_tile  -32,  -16, 0x050, 0x20
    frame_oam_tile   32,    0, 0x046, 0xE0
    frame_oam_tile  -48,    0, 0x046, 0xA0
    frame_oam_tile   32,   16, 0x040, 0xE0
    frame_oam_tile   16,   16, 0x042, 0xE0
    frame_oam_tile    0,   16, 0x044, 0xE0
    frame_oam_tile  -16,   16, 0x044, 0xA0
    frame_oam_tile  -32,   16, 0x042, 0xA0
    frame_oam_tile  -48,   16, 0x040, 0xA0
    frame_oam_tile   32,   32, 0x032, 0xE0
    frame_oam_tile   16,   32, 0x034, 0xE0
    frame_oam_tile    0,   32, 0x036, 0xE0
    frame_oam_tile  -16,   32, 0x036, 0xA0
    frame_oam_tile  -32,   32, 0x034, 0xA0
    frame_oam_tile  -48,   32, 0x032, 0xA0
    frame_oam_tile   16,   48, 0x024, 0xE0
    frame_oam_tile    0,   48, 0x026, 0xE0
    frame_oam_tile  -16,   48, 0x026, 0xA0
    frame_oam_tile  -32,   48, 0x024, 0xA0
    frame_oam_tile   32,  -48, 0x032, 0x60
    frame_oam_tile   32,  -32, 0x040, 0x60
    frame_oam_tile   32,  -16, 0x046, 0x60
    frame_oam_tile   16,  -64, 0x024, 0x60
    frame_oam_tile   16,  -48, 0x034, 0x60
    frame_oam_tile   16,  -32, 0x042, 0x60
    frame_oam_tile    0,  -64, 0x026, 0x60
    frame_oam_tile    0,  -48, 0x036, 0x60
    frame_oam_tile    0,  -32, 0x044, 0x60
    frame_oam_tile  -16,  -64, 0x026, 0x20
    frame_oam_tile  -32,  -64, 0x024, 0x20
    frame_oam_tile  -16,  -48, 0x036, 0x20
    frame_oam_tile  -32,  -48, 0x034, 0x20
    frame_oam_tile  -48,  -48, 0x032, 0x20
    frame_oam_tile  -16,  -32, 0x044, 0x20
    frame_oam_tile  -32,  -32, 0x042, 0x20
    frame_oam_tile  -48,  -32, 0x040, 0x20
    frame_oam_tile  -48,  -16, 0x046, 0x20
byte_C631A8:
    animation_frame_count
    animation_frame animation_frame_C62F38, 3
    animation_frame animation_frame_C62F61, 3
    animation_frame animation_frame_C62FEE, 3
    animation_frame animation_frame_C630B7, 3
    animation_frame animation_frame_C62F61, 3
    animation_frame animation_frame_C62FEE, 3
    .end
sub_C631C1:
    REP #0x20
    LDA z:0x11, X
    AND #0xF0
    LSR A
    LSR A
    LSR A
    LSR A
    STA z:0x40
    LDA z:0x14, X
    AND #0xF0
    ADC z:0x40
    TAY
.ret:
    RTL
    
create_boss_exploisions:
    SEP #0x20
    create_object boss_exploisions
    BCC .loc_C631F3
    JML sub_C631C1.ret

.loc_C631F3:
    REP #0x20
    LDA z:0x11, X
    STA a:0x11, Y
    LDA z:0x14, X
    STA a:0x14, Y
    LDA f:[z:0x50]
    STA a:0x16, Y
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:0x19, Y
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:0x20, Y
    INC z:0x50
    INC z:0x50
    LDA #0
    STA a:0x24, Y
    LDA #0
    STA a:0x26, Y
    LDA #0
    STA a:0x28, Y
    LDA f:[z:0x50]
    PHA
    AND #0x7FFF
    STA a:0x22, Y
    LDA #addr(byte_C62F23)
    STA z:0x50
    LDA #0xE30
    STA a:0xE, Y
    LDA #6
    STA a:0x1E, Y
    PLA
    BIT #0x8000
    BEQ .loc_C6325D
    LDA #addr(byte_C631A8)
    STA z:0x50
    LDA #0xB30
    STA a:0xE, Y
    LDA #6
    STA a:0x1E, Y

.loc_C6325D:
    PHX
    TYX
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    PLX
    RTL

boss_exploisions:
i16
    SEP #0x20
    handler_return_if_paused_or_in_transition
    REP #0x20
    LDA z:0x26, X
    INC z:0x26, X
    BIT #0x1F
    BNE .loc_C63292
    LDY #SOUND_BOSS_EXPLOSION
    JSL play_sound

.loc_C63292:
    REP #0x20
    LDA z:0x28, X
    INC z:0x28, X
    BIT #0xF
    BNE .loc_C632A4
    LDY #SOUND_BOMB_EXPLOSION
    JSL play_sound

.loc_C632A4:
    REP #0x20
    DEC z:0x20, X
    BNE .loc_C632AE
    JML delete_object

.loc_C632AE:
    DEC z:0x24, X
    BPL .ret
    LDA z:0x22, X
    STA z:0x24, X
    JSL sub_C632C8
    PHX
    INX
    INX
    INX
    JSL sub_C632C8
    PLX
    JSL sub_C632DF
.ret:
    RTL

sub_C632C8:
    JSL fast_random
    REP #0x20
    AND z:0x16, X
    BIT #1
    BNE .loc_C632D9
    EOR #0xFFFF
    INC A

.loc_C632D9:
    CLC
    ADC z:0x11, X
    STA z:0x30, X
    RTL

sub_C632DF:
    SEP #0x20
    create_object sub_C63321
    REP #0x20
    BCC .loc_C632FD
    JML sub_C631C1.ret

.loc_C632FD:
    LDA z:0x30, X
    STA a:0x11, Y
    LDA z:0x33, X
    STA a:0x14, Y
    LDA z:8, X
    STA a:8, Y
    LDA z:0xA, X
    STA a:0xA, Y
    LDA z:0xC, X
    STA a:0xC, Y
    LDA z:0xE, X
    STA a:0xE, Y
    LDA z:0x1E, X
    STA a:0x1E, Y
    RTL

sub_C63321:
    JSL load_animation_frame
    BCC .locret_C6332B
    JML delete_object

.locret_C6332B:
    RTL

create_enemy_explosion:
    SEP #0x20
    create_object enemy_explosion
    BCC .loc_C63348
    JML sub_C631C1.ret

.loc_C63348:
    REP #0x20
    LDA z:enemy.x_position, X
    STA a:enemy.x_position, Y
    LDA z:enemy.y_position, X
    STA a:enemy.y_position, Y
    LDA z:0x46
    STA a:enemy.animations, Y
    SEP #0x20
    LDA z:enemy.flags, X
    STA a:enemy.flags, Y
    RTL

enemy_explosion:
i16
    LDY #SOUND_ENEMY_DEATH
    JSL play_sound
    SEP #0x20
    LDA #6
    STA z:enemy.effective_palette, X
    LDA #0xE
    STA z:enemy.palette+1, X
    LDA #0x30
    STA z:enemy.palette, X
    REP #0x20
    start_animation #addr(byte_C62E99)
    set_handler _enemy_explosion

_enemy_explosion:
    SEP #0x20
    handler_return_if_paused_or_in_transition
    JSL render_sprite_animated
    BCC .ret
    SEP #0x20
    LDA z:enemy.flags, X
    BIT #4
    BNE .loc_C633BB
    JSL create_score_popup

.loc_C633BB:
    JSL delete_object

.ret:
    RTL

kill_enemy:
    SEP #0x20
    LDA #0x20
    STA z:0x20, X
    LDA #0
    STA z:enemy.hits_left_for_direction_switch, X
    LDA a:addr(collision_map+1), Y
    STA z:enemy.flags, X
    set_handler _kill_enemy

_kill_enemy:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_SCREEN_TRANSITION | GAME_FLAGS_BATTLE_MENU
    BEQ .loc_C633E9
    JML .locret_C63455

.loc_C633E9:
    JSL render_sprite
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ .loc_C63402
    JML .loc_C63406

.loc_C63402:
    DEC z:enemy.direction, X
    BEQ .loc_C63417

.loc_C63406:
    LDA #0xE
    STA z:enemy.effective_palette, X
    LDA z:enemy.hits_left_for_direction_switch, X
    EOR #1
    STA z:enemy.hits_left_for_direction_switch, X
    BNE .locret_C63455
    LDA z:enemy.real_palette, X
    STA z:enemy.effective_palette, X
    RTL

.loc_C63417:
    JSL calculate_score_for_enemy
    JSL create_enemy_explosion
    REP #0x20
    JSL get_object_square_index
    TAY
    LDA a:addr(collision_map), Y
    AND #BONUS_MASK|BOMB|SOFT_BLOCK|HARD_BLOCK|0x100
    BNE .loc_C63439
    LDA z:enemy.carried_bonus, X
    AND #0x1F
    BEQ .loc_C63439
    JSL create_bonus_object

.loc_C63439:
    REP #0x20
    LDA z:enemy.creation_functions_array_ptr, X
    STA z:0x50
    LDA z:0x3B, X
    STA z:0x51
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    ORA #0x10
    STA f:[z:0x50]
    DEC a:addr(level_manager_object.enemy_count)
    JSL delete_object
.locret_C63455:
    RTL

calculate_score_for_enemy:
    REP #0x20
    LDA #0
    STA z:0x40
    LDA z:enemy.flags, X
    BIT #4
    BNE .locret_C63494
    BIT #2
    BEQ .loc_C6346E
    LDA #0x10
    STA z:0x40

.loc_C6346E:
    LDA z:enemy.flags, X
    AND #0xF0
    LSR A
    LSR A
    LSR A
    LSR A
    ORA z:0x40
    TAY
    SEP #0x20
    LDA a:addr(combo_counters), Y
    CMP #4
    BCC .loc_C63485
    LDA #4

.loc_C63485:
    STA z:0x46
    INC A
    STA a:addr(combo_counters), Y
    LDA z:enemy.score_index, X
    CLC
    ADC z:0x46
    STA z:0x46
    STZ z:0x47

.locret_C63494:
    RTL

test_collision_mask_for_enemy_next_square:
    .FUNCTION_PTR = 0x53
    .FUNCTION_ARRAY_PTR = 0x50
    SEP #0x20
    LDA #bank(test_collision_funtions)
    STA z:.FUNCTION_ARRAY_PTR + 2
    LDA #bank(test_collision_above)
    STA z:.FUNCTION_PTR + 2
    REP #0x20
    LDA z:enemy.direction, X
    AND #0xFF
    ASL A
    CLC
    ADC #addr(test_collision_funtions)
    STA z:.FUNCTION_ARRAY_PTR
    LDA f:[z:.FUNCTION_ARRAY_PTR]
    STA z:.FUNCTION_PTR
    JML [.FUNCTION_PTR]

    RTI
    
test_collision_funtions:
    da test_collision_above, test_collision_on_the_right, test_collision_below, test_collision_on_the_left
    
check_for_enemy_with_enemy_collision:
i16
    LDY #addr(gameover_related_object)
    STX z:0x50

.loc_C634C2:
    SEP #0x20
    LDA a:3, Y
    BIT #1
    BEQ .loc_C634EB
    LDA a:enemy.x_position, Y
    SEC
    SBC z:enemy.x_position, X
    BCS .loc_C634D6
    EOR #0xFF
    INC A

.loc_C634D6:
    CMP #0x10
    BCS .loc_C634EB
    LDA a:enemy.y_position, Y
    SEC
    SBC z:enemy.y_position, X
    BCS .loc_C634E5
    EOR #0xFF
    INC A

.loc_C634E5:
    CMP #0x10
    BCS .loc_C634EB
    SEC
    RTL

.loc_C634EB:
    REP #0x20
    LDA a:enemy.next, Y
    TAY
    CMP z:0x50
    BEQ .loc_C634EB
    CMP #0xFFFF
    BNE .loc_C634C2
    CLC
    RTL

enemy_hit_players_in_centered_range:
i16
    .X_LIMIT = 0x41
    .Y_LIMIT = 0x40
    REP #0x20
    LDY #addr(player_1)

-
    SEP #0x20
    LDA a:player.unknown_flags, Y
    BIT #1
    BEQ .next
    LDA a:player.x_position, Y
    SEC
    SBC z:enemy.x_position, X
    ; Abs value
    BCS +
    EOR #0xFF
    INC A
+
    CMP z:.X_LIMIT
    BCS .next
    
    LDA a:player.y_position, Y
    SEC
    SBC z:enemy.y_position, X
    ; Abs value
    BCS +
    EOR #0xFF
    INC A
+
    CMP z:.Y_LIMIT
    BCS .next
    
    SEP #0x20
    LDA #1
    STA a:player.hit_flags, Y

.next:
    REP #0x20
    TYA
    CLC
    ADC #player.sizeof
    TAY
    CMP #addr(player_3)
    BNE -
    RTL

enemy_hit_players_in_range:
    .LIMIT = 0x46
    .LEFT_LIMIT = 0x43 ; Argument
    .RIGHT_LIMIT = 0x42 ; Argument
    .UP_LIMIT = 0x45 ; Argument
    .DOWN_LIMIT = 0x44 ; Argument
i16
    REP #0x20
    LDY #addr(player_1)

-
    LDA a:player.unknown_flags, Y
    BIT #0xFF
    BEQ .next
    
    LDA z:.RIGHT_LIMIT
    AND #0xFF
    STA z:.LIMIT
    LDA a:player.x_position, Y
    SEC
    SBC z:enemy.x_position, X
    BCS +
    EOR #0xFFFF
    INC A
    PHA
    LDA z:.LEFT_LIMIT
    AND #0xFF
    STA z:.LIMIT
    PLA
+
    CMP z:.LIMIT
    BCS .next

    LDA z:.DOWN_LIMIT
    AND #0xFF
    STA z:.LIMIT
    LDA a:player.y_position, Y
    SEC
    SBC z:enemy.y_position, X
    BCS +
    EOR #0xFFFF
    INC A
    PHA
    LDA z:.UP_LIMIT
    AND #0xFF
    STA z:.LIMIT
    PLA
+

    CMP z:.LIMIT
    BCS .next
    LDA a:player.hit_flags, Y
    ORA #1
    STA a:player.hit_flags, Y

.next:
    TYA
    CLC
    ADC #player.sizeof
    TAY
    CMP #addr(player_3)
    BNE -
    RTL

is_player_in_enemy_range:
    .X_LIMIT = 0x41
    .Y_LIMIT = 0x40
    .LEFT_LIMIT = 0x43 ; Argument
    .RIGHT_LIMIT = 0x42 ; Argument
    .UP_LIMIT = 0x45 ; Argument
    .DOWN_LIMIT = 0x44 ; Argument
    
    SEP #0x20
    LDA a:player.unknown_flags, Y
    BIT #1
    BEQ .ret_false
    LDA z:.RIGHT_LIMIT
    STA z:.X_LIMIT
    LDA a:player.x_position, Y
    SEC
    SBC z:enemy.x_position, X
    BCS +
    PHA
    LDA z:.LEFT_LIMIT
    STA z:.X_LIMIT
    PLA
    EOR #0xFF
    INC A
+
    CMP z:.X_LIMIT 
    BCS .ret_false
    
    LDA z:.DOWN_LIMIT
    STA z:.Y_LIMIT
    LDA a:player.y_position, Y
    SEC
    SBC z:enemy.y_position, X
    BCS .loc_C635D6
    PHA
    LDA z:.UP_LIMIT
    STA z:.Y_LIMIT
    PLA
    EOR #0xFF
    INC A

.loc_C635D6:
    CMP z:.Y_LIMIT
    BCS .ret_false
    REP #0x20
    SEC
    RTL

.ret_false:
    REP #0x20
    CLC
    RTL

sub_C635E2:
    SEP #0x20
    LDA z:0x42
    CMP #0x50
    BNE sub_C635FD

sub_C635EA:
    SEP #0x20
    LDA #1
    STA z:0x44
    LDA a:0x11, Y
    SEC
    SBC z:0x11, X
    BCS .locret_C635FC
    LDA #3
    STA z:0x44

.locret_C635FC:
    RTL

sub_C635FD:
    SEP #0x20
    LDA #2
    STA z:0x44
    LDA a:0x14, Y
    SEC
    SBC z:0x14, X
    BCS .locret_C6360D
    STZ z:0x44

.locret_C6360D:
    RTL

straight_movement:
    SEP #0x20
    LDA #bank(vectors_for_speed_and_direction)
    STA z:0x53 + 2
    LDA z:enemy.speed, X
    REP #0x20
    AND #0xFF
    ASL A
    ASL A
    ASL A
    ASL A
    STA z:0x40
    LDA z:enemy.direction, X
    AND #0xF
    ASL A
    ASL A
    CLC
    ADC #addr(vectors_for_speed_and_direction)
    ADC z:0x40
    STA z:0x53
    LDA z:enemy.fractional_x, X
    PHA
    LDA z:enemy.fractional_y, X
    PHA
    LDA z:enemy.direction, X
    BIT #1
    BNE .loc_C63643
    JSL straighten_x
    BRA .loc_C63647

.loc_C63643:
    JSL straighten_y

.loc_C63647:
    REP #0x20
    LDA z:enemy.fractional_x, X
    CLC
    ADC f:[z:0x53]
    STA z:enemy.fractional_x, X
    INC z:0x53
    INC z:0x53
    LDA z:enemy.fractional_y, X
    CLC
    ADC f:[z:0x53]
    STA z:enemy.fractional_y, X
    JSL check_for_enemy_with_enemy_collision
    REP #0x20
    BCS .loc_C63667
    PLA
    PLA
    CLC
    RTL

.loc_C63667:
    PLA
    STA z:enemy.fractional_y, X
    PLA
    STA z:enemy.fractional_x, X
    JSL fast_random
    SEP #0x20
    AND #3
    CMP z:enemy.direction, X
    BNE .loc_C63681

.loc_C63679:
    LDA z:enemy.direction, X
    EOR #2
    STA z:enemy.direction, X
    SEC
    RTL

.loc_C63681:
    JSL test_collision_mask_for_enemy_next_square
    SEP #0x20
    BNE .loc_C63679
    SEC
    RTL

    LDA z:0x20, X
    INC A
    AND #3
    STA z:0x20, X
    SEC
    RTL
    JMP a:sub_C63818
    
straighten_x:
    SEP #0x20
    LDA z:enemy.x_position, X
    AND #0xF
    CMP #8
    BEQ .locret_C636A8
    BCC .loc_C636A6
    DEC z:enemy.x_position, X
    RTL

.loc_C636A6:
    INC z:enemy.x_position, X

.locret_C636A8:
    RTL

straighten_y:
    SEP #0x20
    LDA z:enemy.y_position, X
    AND #0xF
    CMP #8
    BEQ .locret_C636BA
    BCC .loc_C636B8
    DEC z:enemy.y_position, X
    RTL

.loc_C636B8:
    INC z:enemy.y_position, X

.locret_C636BA:
    RTL

vectors_for_speed_and_direction:
    dw 0, 0xFF80, 0x80,  0, 0, 0x80,  0xFF80, 0; 0
    dw 0, 0xFF00, 0x100, 0, 0, 0x100, 0xFF00, 0; 8
    dw 0, 0xFF00, 0x100, 0, 0, 0x100, 0xFF00, 0; 0x10
    dw 0, 0xFF20, 0xE0,  0, 0, 0xE0,  0xFF20, 0; 0x18
    dw 0, 0xFE80, 0x180, 0, 0, 0x180, 0xFE80, 0; 0x20

enemy_detect_blast_in_range:
    .LEFT_LIMIT = 0x43 ; Argument
    .RIGHT_LIMIT = 0x42 ; Argument
    .UP_LIMIT = 0x45 ; Argument
    .DOWN_LIMIT = 0x44 ; Argument
    .TEMP = 0x40
    .MAP_OFFSET = 0x46
    REP #0x20
    
    ; Get the bottom-right tile
    LDA z:.RIGHT_LIMIT
    CLC
    ADC z:enemy.x_position, X
    AND #0x1F0
    LSR A
    LSR A
    LSR A
    STA z:.TEMP
    LDA z:.DOWN_LIMIT
    CLC
    ADC z:enemy.y_position, X
    AND #0xF0
    ASL A
    ASL A
    ORA z:.TEMP
    TAY
    
    ; Convert arguments from pixels to tiles
    
    ; This also converts left
    LSR z:.RIGHT_LIMIT
    LSR z:.RIGHT_LIMIT
    LSR z:.RIGHT_LIMIT
    LSR z:.RIGHT_LIMIT
    
    ; This also converts up
    LSR z:.DOWN_LIMIT
    LSR z:.DOWN_LIMIT
    LSR z:.DOWN_LIMIT
    LSR z:.DOWN_LIMIT
    
    ; Reuse RIGHT_LIMIT and UP_LIMIT as the X and Y loop counters
    SEP #0x20
    LDA z:.LEFT_LIMIT
    CLC
    ADC z:.RIGHT_LIMIT
    INC A
    STA z:.RIGHT_LIMIT
    
    LDA z:.UP_LIMIT
    CLC
    ADC z:.DOWN_LIMIT
    INC A
    STA z:.UP_LIMIT

.y_loop:
    STY z:.MAP_OFFSET
    LDA z:.RIGHT_LIMIT
    STA z:.LEFT_LIMIT

.x_loop:
    CPY #0x2DE ; Edge of the collision mask
    BCS +
    LDA a:addr(collision_map + 1), Y
    BIT #high(BLAST)
    BNE .ret_true
+

    DEY
    DEY
    DEC z:.LEFT_LIMIT
    BNE .x_loop
    REP #0x20
    LDA z:.MAP_OFFSET
    SEC
    SBC #0x40 ; Up one row
    TAY
    SEP #0x20
    DEC z:.UP_LIMIT 
    BNE .y_loop
    CLC
    RTL

.ret_true:
    SEC
    RTL

wanderer_movement:
    REP #0x20
    LDA #BOMB|SOFT_BLOCK|HARD_BLOCK
    STA z:0x42
    JSL test_collision_mask_for_enemy_next_square
    BEQ .loc_C63785
    JML enemy_hit_deadend

.loc_C63785:
    JSL straight_movement
    BCC .loc_C6378F
    JML nullsub_C63ADE

.loc_C6378F:
    SEP #0x20
    LDA z:0x18, X
    STA z:0x52
    LDA z:enemy.direction, X
    CMP z:enemy.animation_direction, X
    BEQ .locret_C637AF
    STA z:enemy.animation_direction, X
    REP #0x20
    AND #0xFF
    ASL A
    ADC z:enemy.animations, X
    STA z:0x50
    LDA f:[z:0x50]
    STA z:0x50
    JSL start_animation

.locret_C637AF:
    RTL

random_wanderer_movement:
    SEP #0x20
    DEC z:0x21, X
    BNE .loc_C637CF
    INC z:0x21, X
    JSL is_object_misaligned
    BCS .loc_C637CF
    JSL fast_random
    SEP #0x20
    AND #0x3F
    CLC
    ADC #0x10
    STA z:0x21, X
    JSL sub_C6382F

.loc_C637CF:
    REP #0x20
    LDA #BOMB|HARD_BLOCK
    STA z:0x42
    JSL test_collision_mask_for_enemy_next_square
    BNE sub_C6382F
    JSL straight_movement
    BCC .loc_C637E6
    JML nullsub_C63ADE

.loc_C637E6:
    SEP #0x20
    LDA z:0x18, X
    STA z:0x52
    LDA z:0x20, X
    CMP z:0x22, X
    BEQ .locret_C63806
    STA z:0x22, X
    REP #0x20
    AND #0xFF
    ASL A
    ADC z:0x16, X
    STA z:0x50
    LDA f:[z:0x50]
    STA z:0x50
    JSL start_animation

.locret_C63806:
    RTL

enemy_hit_deadend:
    SEP #0x20
    DEC z:enemy.hits_left_for_direction_switch, X
    BNE .loc_C63811
    JML sub_C63818

.loc_C63811:
    LDA z:enemy.direction, X
    EOR #2
    STA z:enemy.direction, X
    RTL

sub_C63818:
    SEP #0x20
    LDA z:enemy.direction, X
    INC A
    AND #3
    STA z:enemy.direction, X
    JSL fast_random
    SEP #0x20
    AND #3
    INC A
    INC A
    INC A
    STA z:enemy.hits_left_for_direction_switch, X
    RTL

sub_C6382F:
    JSL fast_random
    SEP #0x20
    AND #3
    STA z:0x20, X
    RTL

follower_movement:
    REP #0x20
    JSL is_object_misaligned
    BCC .loc_C6388E
    REP #0x20
    LDA z:enemy.collision_mask, X
    STA z:0x42
    JSL test_collision_mask_for_enemy_next_square
    BEQ .loc_C63852
    JML .loc_C6388E
.loc_C63852:
    JSL straight_movement
    BCC .loc_C6385C
    JML nullsub_C63ADE

.loc_C6385C:
    SEP #0x20
    LDA z:0x18, X
    STA z:0x52
    LDA z:enemy.direction, X
    CMP z:enemy.animation_direction, X
    BEQ .locret_C6387C
    STA z:enemy.animation_direction, X
    REP #0x20
    AND #0xFF
    ASL A
    ADC z:enemy.animations, X
    STA z:0x50
    LDA f:[z:0x50]
    STA z:0x50
    JSL start_animation

.locret_C6387C:
    RTL

.loc_C6387D:
    SEP #0x20
    INC z:enemy.hits_left_for_direction_switch, X
    REP #0x20
    LDA z:enemy.collision_mask, X
    STA z:0x42
    JSL test_collision_mask_for_enemy_next_square
    BEQ .loc_C63852
    RTL

.loc_C6388E:
    JSL enemy_find_closest_player
    SEP #0x20
    LDA z:enemy.hits_left_for_direction_switch, X
    BEQ .loc_C6387D
    STZ z:enemy.hits_left_for_direction_switch, X
    LDA z:0x20, X
    BIT #1
    BNE .loc_C638A8
    JSL sub_C635EA
    BEQ .loc_C638C6
    BRA .loc_C638AE

.loc_C638A8:
    JSL sub_C635FD
    BEQ .loc_C638C6

.loc_C638AE:
    LDA z:0x20, X
    PHA
    LDA z:0x44
    STA z:enemy.direction, X
    REP #0x20
    LDA z:enemy.collision_mask, X
    STA z:0x42
    JSL test_collision_mask_for_enemy_next_square
    SEP #0x20
    BEQ .loc_C638E0
    PLA
    STA z:enemy.direction, X

.loc_C638C6:
    REP #0x20
    LDA z:enemy.collision_mask, X
    STA z:0x42
    JSL test_collision_mask_for_enemy_next_square
    BNE .loc_C638D6
    JML .loc_C63852

.loc_C638D6:
    SEP #0x20
    LDA z:enemy.direction, X
    INC A
    AND #3
    STA z:enemy.direction, X
    RTL

.loc_C638E0:
    PLA
    JMP a:.loc_C63852

missile_movement:
    REP #0x20
    LDA #BOMB|SOFT_BLOCK|HARD_BLOCK
    STA z:0x42
    JSL test_collision_mask_for_enemy_next_square
    BEQ .loc_C638F5
    JML .loc_C63920

.loc_C638F5:
    JSL straight_movement
    BCC .loc_C638FF
    JML nullsub_C63ADE

.loc_C638FF:
    SEP #0x20
    LDA z:0x18, X
    STA z:0x52
    LDA z:0x20, X
    CMP z:0x22, X
    BEQ .locret_C6391F
    STA z:0x22, X
    REP #0x20
    AND #0xFF
    ASL A
    ADC z:0x16, X
    STA z:0x50
    LDA f:[z:0x50]
    STA z:0x50
    JSL start_animation

.locret_C6391F:
    RTL

.loc_C63920:
    REP #0x20
    BIT #0x20
    BEQ sub_C63983
    LDA z:0x20, X
    PHA
    AND #0xFF
    PHX
    TAX
    SEP #0x20
    LDA f:byte_C63943, X
    PLX
    STA z:0x20, X
    JSL sub_C41D24
    REP #0x20
    PLA
    STA z:0x20, X
    BRA .loc_C638F5
byte_C63943:
    db 8, 1, 4, 2

wanderer_movement2:
    REP #0x20
    LDA #BOMB|SOFT_BLOCK|HARD_BLOCK
    STA z:0x42
    JSL test_collision_mask_for_enemy_next_square
    BEQ .loc_C63958
    JML sub_C63983

.loc_C63958:
    JSL straight_movement
    BCC .loc_C63962
    JML nullsub_C63ADE

.loc_C63962:
    SEP #0x20
    LDA z:0x18, X
    STA z:0x52
    LDA z:0x20, X
    CMP z:0x22, X
    BEQ .locret_C63982
    STA z:0x22, X
    REP #0x20
    AND #0xFF
    ASL A
    ADC z:0x16, X
    STA z:0x50
    LDA f:[z:0x50]
    STA z:0x50
    JSL start_animation

.locret_C63982:
    RTL

sub_C63983:
    JSL enemy_find_closest_player
    SEP #0x20
    LDA z:0x20, X
    BIT #1
    BNE .loc_C63997
    JSL sub_C635EA
    BEQ .loc_C639B6
    BRA .loc_C6399D

.loc_C63997:
    JSL sub_C635FD
    BEQ .loc_C639B6

.loc_C6399D:
    LDA z:0x20, X
    PHA
    LDA z:0x44
    STA z:0x20, X
    REP #0x20
    LDA #BOMB|SOFT_BLOCK|HARD_BLOCK
    STA z:0x42
    JSL test_collision_mask_for_enemy_next_square
    SEP #0x20
    BEQ .loc_C639BE
    PLA
    STA z:0x20, X

.loc_C639B6:
    LDA z:0x20, X
    INC A
    AND #3
    STA z:0x20, X
    RTL

.loc_C639BE:
    PLA
    RTL

enemy_find_closest_player:
i16
    REP #0x20
    LDY #addr(player_2)
    LDA a:addr(player_1.unknown_flags)
    AND #0xFF
    BEQ .locret_C63A1B
    LDY #addr(player_1)
    LDA a:addr(player_2.unknown_flags)
    AND #0xFF
    BEQ .locret_C63A1B
    LDA z:enemy.x_position, X
    SEC
    SBC a:addr(player_1.x_position)
    BPL .loc_C639E4
    EOR #0xFFFF
    INC A

.loc_C639E4:
    STA z:0x40
    LDA z:enemy.y_position, X
    SEC
    SBC a:addr(player_1.y_position)
    BPL .loc_C639F2
    EOR #0xFFFF
    INC A

.loc_C639F2:
    CLC
    ADC z:0x40
    STA z:0x42
    LDA z:enemy.x_position, X
    SEC
    SBC a:addr(player_2.x_position)
    BPL .loc_C63A03
    EOR #0xFFFF
    INC A

.loc_C63A03:
    STA z:0x40
    LDA z:enemy.y_position, X
    SEC
    SBC a:addr(player_2.y_position)
    BPL .loc_C63A11
    EOR #0xFFFF
    INC A

.loc_C63A11:
    CLC
    ADC z:0x40
    CMP z:0x42
    BCS .locret_C63A1B
    LDY #addr(player_2)

.locret_C63A1B:
    RTL

pakupa_is_bomb_in_direction:
    REP #0x20
    LDA z:0x40
    PHA
    JSL get_object_square_index
    TAY
    PLA
    STA z:0x40
    LDA #8
    STA z:0x42

.loc_C63A2E:
    TYA
    CLC
    ADC z:0x40
    TAY
    LDA a:addr(collision_map), Y
    BIT #SOFT_BLOCK|HARD_BLOCK
    BNE .loc_C63A55
    BIT #BOMB
    BNE .loc_C63A57
    LDA a:addr(debug_vs_check)
    AND #0xFF
    BEQ .loc_C63A51
    LDA a:addr(bg1_tilemap), Y
    ORA #0x200
    STA a:addr(bg1_tilemap), Y

.loc_C63A51:
    DEC z:0x42
    BNE .loc_C63A2E

.loc_C63A55:
    CLC
    RTL

.loc_C63A57:
    SEC
    RTL

line_of_sight_offsets:
    dw addr(-0x40)
    dw 2
    dw 0x40
    dw addr(-2)
pakupa_is_bomb_in_line_of_sight:
    REP #0x20
    LDA #0
    STA z:0x44
    LDA z:enemy.direction, X
    PHA

.loc_C63A6B:
    SEP #0x20
    LDA z:enemy.direction, X
    AND #3
    STA z:enemy.direction, X
    INC z:enemy.direction, X
    REP #0x20
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:line_of_sight_offsets, X
    PLX
    STA z:0x40
    JSL pakupa_is_bomb_in_direction
    BCS .loc_C63A98
    INC z:0x44
    LDA z:0x44
    CMP #4
    BNE .loc_C63A6B
    PLA
    STA z:enemy.direction, X
    CLC
    RTL

.loc_C63A98:
    PLA
    DEC z:enemy.direction, X
    SEC
    RTL

pakupa_movement:
    REP #0x20
    JSL pakupa_is_bomb_in_line_of_sight
    REP #0x20
    LDA #SOFT_BLOCK|HARD_BLOCK
    STA z:0x42
    JSL test_collision_mask_for_enemy_next_square
    BEQ .loc_C63AB4
    JML enemy_hit_deadend

.loc_C63AB4:
    JSL straight_movement
    BCC .loc_C63ABE
    JML nullsub_C63ADE

.loc_C63ABE:
    SEP #0x20
    LDA z:0x18, X
    STA z:0x52
    LDA z:enemy.direction, X
    CMP z:enemy.animation_direction, X
    BEQ nullsub_C63ADE
    STA z:enemy.animation_direction, X
    REP #0x20
    AND #0xFF
    ASL A
    ADC z:enemy.animations, X
    STA z:0x50
    LDA f:[z:0x50]
    STA z:0x50
    JSL start_animation
    ; fallthrough

nullsub_C63ADE:
    RTL

kuwagen_movement:
i16
    REP #0x20
    LDA z:enemy.speed, X
    PHA
    LDY #addr(player_1)
    JSL is_in_line_of_sight
    BCC .loc_C63B39
    LDY #addr(player_2)
    JSL is_in_line_of_sight
    BCC .loc_C63B39
    REP #0x20
    STZ z:0x30, X
    LDA #BOMB|SOFT_BLOCK|HARD_BLOCK
    STA z:0x42
    JSL test_collision_mask_for_enemy_next_square
    BEQ .loc_C63B0D
    REP #0x20
    PLA
    STA z:0x19, X
    JMP a:enemy_hit_deadend

.loc_C63B0D:
    JSL straight_movement
    BCS .loc_C63B33

.loc_C63B13:
    SEP #0x20
    LDA z:0x18, X
    STA z:0x52
    LDA z:0x20, X
    CMP z:0x22, X
    BEQ .loc_C63B33
    STA z:0x22, X
    REP #0x20
    AND #0xFF
    ASL A
    ADC z:0x16, X
    STA z:0x50
    LDA f:[z:0x50]
    STA z:0x50
    JSL start_animation

.loc_C63B33:
    REP #0x20
    PLA
    STA z:0x19, X
    RTL

.loc_C63B39:
    SEP #0x20
    LDA z:enemy.direction, X
    BIT #1
    BNE .loc_C63B4B
    LDA z:enemy.x_position, X
    AND #0xF
    CMP #8
    BNE .loc_C63B0D
    BRA .loc_C63B53

.loc_C63B4B:
    LDA z:enemy.y_position, X
    AND #0xF
    CMP #8
    BNE .loc_C63B0D

.loc_C63B53:
    REP #0x20
    INC z:enemy.field_30, X
    LDA z:enemy.field_30, X
    CMP #0x20
    BNE .loc_C63B13
    DEC z:enemy.field_30, X
    INC z:enemy.speed, X
    BRA .loc_C63B0D

is_in_line_of_sight:
    REP #0x20
    LDA #0x5050
    STA z:0x42
    LDA #0xC0C
    STA z:0x44
    LDA z:0x20, X
    BIT #1
    BNE .loc_C63B81
    LDA #0xC0C
    STA z:0x42
    LDA #0x5050
    STA z:0x44

.loc_C63B81:
    LDA z:0x42
    PHA
    LDA z:0x44
    PHA
    JSL is_player_in_enemy_range
    BCS .loc_C63B91
    JML .loc_C63BC0

.loc_C63B91:
    JSL sub_C635E2
    REP #0x20
    PLA
    PLA
    SEP #0x20
    LDA z:0x44
    EOR #2
    CMP z:0x20, X
    BEQ .loc_C63BBE
    LDA z:0x20, X
    STA z:0x45
    LDA z:0x44
    STA z:0x20, X
    REP #0x20
    LDA #BOMB|SOFT_BLOCK|HARD_BLOCK
    STA z:0x42
    JSL test_collision_mask_for_enemy_next_square
    SEP #0x20
    BEQ .loc_C63BF7

.loc_C63BBA:
    LDA z:0x45
    STA z:0x20, X
.loc_C63BBE:
    SEC
    RTL

.loc_C63BC0:
    REP #0x20
    PLA
    STA z:0x42
    PLA
    STA z:0x44
    JSL is_player_in_enemy_range
    BCS .loc_C63BD2
    JML .loc_C63BBE

.loc_C63BD2:
    JSL sub_C635E2
    SEP #0x20
    LDA z:0x44
    EOR #2
    CMP z:0x20, X
    BEQ .loc_C63BBE
    LDA z:0x20, X
    STA z:0x45
    LDA z:0x44
    STA z:0x20, X
    REP #0x20
    LDA #BOMB|SOFT_BLOCK|HARD_BLOCK
    STA z:0x42
    JSL test_collision_mask_for_enemy_next_square
    SEP #0x20
    BNE .loc_C63BBA

.loc_C63BF7:
    CLC
    RTL

sub_C63BF9:
    REP #0x20
    LDA z:0x11, X
    CLC
    ADC #0x200
    STA z:0x48
    LDA z:0x14, X
    CLC
    ADC #0x200
    STA z:0x4A
    LDA a:0x11, Y
    AND #0xFF
    CLC
    ADC #0x200
    STA z:0x4C
    LDA a:0x14, Y
    CLC
    ADC #0x200
    STA z:0x4E
    LDA z:0x4A
    SEC
    SBC #6
    CMP z:0x4E
    BCS .loc_C63C44
    CLC
    ADC #0xC
    CMP z:0x4E
    BCS .loc_C63C36
    JML .loc_C63CAA

.loc_C63C36:
    LDA z:0x48
    CMP z:0x4C
    BCC .loc_C63C40
    LDA #0xC
    RTL

.loc_C63C40:
    LDA #4
    RTL

.loc_C63C44:
    LDA z:0x48
    CLC
    ADC #6
    CMP z:0x4C
    BCC .loc_C63C5A
    SEC
    SBC #0xC
    CMP z:0x4C
    BCS .loc_C63C82
    LDA #0
    RTL

.loc_C63C5A:
    LDA z:0x4C
    SEC
    SBC z:0x48
    STA z:0x46
    LDA z:0x4A
    SEC
    SBC z:0x4E
    SEC
    SBC z:0x46
    BCC .loc_C63C74
    CMP #0x18
    BCC .loc_C63C7E
    LDA #1
    RTL

.loc_C63C74:
    CLC
    ADC #0x20
    BCS .loc_C63C7E
    LDA #3
    RTL

.loc_C63C7E:
    LDA #2
    RTL

.loc_C63C82:
    LDA z:0x48
    SEC
    SBC z:0x4C
    STA z:0x46
    LDA z:0x4A
    SEC
    SBC z:0x4E
    SEC
    SBC z:0x46
    BCC .loc_C63C9C
    CMP #0x18
    BCC .loc_C63CA6
    LDA #0xF
    RTL

.loc_C63C9C:
    CLC
    ADC #0x20
    BCS .loc_C63CA6
    LDA #0xD
    RTL

.loc_C63CA6:
    LDA #0xE
    RTL

.loc_C63CAA:
    LDA z:0x48
    CLC
    ADC #6
    CMP z:0x4C
    BCC .loc_C63CC0
    SEC
    SBC #0xC
    CMP z:0x4C
    BCS .loc_C63CDA
    LDA #8
    RTL

.loc_C63CC0:
    LDA z:0x4C
    SEC
    SBC z:0x48
    STA z:0x46
    LDA z:0x4E
    SEC
    SBC z:0x4A
    SEC
    SBC z:0x46
    BCC .loc_C63D02
    CMP #0x18
    BCC .loc_C63D0C
    LDA #7
    RTL

.loc_C63CDA:
    LDA z:0x48
    SEC
    SBC z:0x4C
    STA z:0x46
    LDA z:0x4E
    SEC
    SBC z:0x4A
    SEC
    SBC z:0x46
    BCC .loc_C63CF4
    CMP #0x18
    BCC .loc_C63CFE
    LDA #9
    RTL

.loc_C63CF4:
    CLC
    ADC #0x20
    BCS .loc_C63CFE
    LDA #0xB
    RTL

.loc_C63CFE:
    LDA #0xA
    RTL

.loc_C63D02:
    CLC
    ADC #0x20
    BCS .loc_C63D0C
    LDA #5
    RTL

.loc_C63D0C:
    LDA #6
    RTL

; Enemy animations and frames

include "enemies/animations.asm"

; Enemy code

macro basic_enemy movement
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_KILL_ENEMIES
    BEQ +
    JML kill_enemy
+

    BIT #GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_SCREEN_TRANSITION
    BEQ +
    JML handler_early_exit
+

    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
    BEQ +
    JML .render_and_hit_players
+

    JSL $movement
    JSL handle_enemy_damage
    BCC +
    JML kill_enemy ; Hitpoints reached 0
+

.render_and_hit_players
    REP #0x20
    LDA #0xC0C ; Set .X_LIMIT and .Y_LIMIT to 12
    STA z:enemy_hit_players_in_centered_range.Y_LIMIT
    JSL enemy_hit_players_in_centered_range
    JSL render_sprite_animated
    RTL
endmacro

include "enemies/kuwagen.asm"
include "enemies/senshiyan.asm"
include "enemies/metal_propene.asm"
include "enemies/propene.asm"
include "enemies/denkyun.asm"
include "enemies/starnuts.asm"
include "enemies/banen.asm"
include "enemies/cuppen.asm"
include "enemies/keibin.asm"
include "enemies/anzenda.asm"
include "enemies/yoroisu.asm"
include "enemies/chameleoman.asm"
include "enemies/missile.asm"
include "enemies/kouraru.asm"
include "enemies/pakupa.asm"
include "enemies/douken.asm"
include "enemies/dengurin.asm"
include "enemies/robocom.asm"
include "enemies/metal_u.asm"
include "enemies/kinkaru.asm"
include "enemies/moguchan.asm"
include "enemies/bakuda.asm"
include "enemies/kierun.asm"

; Enemy animation lists

kuwagen_animations:
    da kuwagen_animation_up, kuwagen_animation_right, kuwagen_animation_down, kuwagen_animation_left
senshiyan_animations:
    da senshiyan_animation_up, senshiyan_animation_right, senshiyan_animation_down, senshiyan_animation_left
propene_animations:
    da propene_animation_up, propene_animation_right, propene_animation_down, propene_animation_left
banen_animations:
    da banen_animation_up, banen_animation_right, banen_animation_down, banen_animation_left
cuppen_animations:
    da cuppen_animation, cuppen_animation, cuppen_animation, cuppen_animation
anzenda_animations:
    da anzenda_animation_up, anzenda_animation_right, anzenda_animation_down, anzenda_animation_left
yoroisu_animations:
    da yoroisu_animation_up, yoroisu_animation_right, yoroisu_animation_down, yoroisu_animation_left
yoroisu_shield_animations:
    da yoroisu_shield_animation_up, yoroisu_shield_animation_right, yoroisu_shield_animation_down, yoroisu_shield_animation_left
kouraru_animations:
    da kouraru_animation, kouraru_animation, kouraru_animation, kouraru_animation
pakupa_animations:
    da pakupa_animation_up, pakupa_animation_right, pakupa_animation_down, pakupa_animation_left
douken_animations:
    da douken_animation, douken_animation, douken_animation, douken_animation
dengurin_animations:
    da dengurin_animation_up, dengurin_animation_right, dengurin_animation_down, dengurin_animation_left
missile_animations:
    da missile_animation_up, missile_animation_right, missile_animation_down, missile_animation_left
robocom_animations:
    da robocom_animation_up, robocom_animation_right, robocom_animation_down, robocom_animation_left
moguchan_animations:
    da moguchan_animation_up, moguchan_animation_right, moguchan_animation_down, moguchan_animation_left
bakuda_animations:
    da bakuda_animation_up, bakuda_animation_right, bakuda_animation_down, bakuda_animation_left
kierun_animations:
    da kierun_animation, kierun_animation, kierun_animation, kierun_animation
keibin_animations:
    da keibin_animation, keibin_animation, keibin_animation, keibin_animation
starnuts_animations:
    da starnuts_animation_up, starnuts_animation_right, starnuts_animation_down, starnuts_animation_left
kinkaru_animations:
    da kinkaru_animation, kinkaru_animation, kinkaru_animation, kinkaru_animation
metal_u_animations:
    da metal_u_animation, metal_u_animation, metal_u_animation, metal_u_animation
denkyun_animations:
    da denkyun_animation, denkyun_animation, denkyun_animation, denkyun_animation
data_end
