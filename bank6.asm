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
    STA z:addr(far_function_pointer)
    SEP #0x20
    LDA #bank(unk_7E21E6)
    STA z:addr(far_function_pointer + 2)
    LDA z:0x40
    ORA #0x20
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    LDA #addr(debug_menu_initializer)
    STA z:pause_handler.handler, X
    SEP #0x20
    LDA #bank(debug_menu_initializer)
    STA z:pause_handler.handler + 2, X
    RTL

debug_menu_initializer:
    REP #0x20
    LDA #addr(handle_pause)
    STA z:pause_handler.handler, X
    SEP #0x20
    LDA #bank(handle_pause)
    STA z:pause_handler.handler + 2, X
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
    LDA a:addr(0x22), Y
    BIT #0x30
    BNE .loc_C601C8
    INY
    INY
    INY
    INY

.loc_C601C8:
    PHY
    LDA a:addr(0x22), Y
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
    LDA a:addr(0x23), Y
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
    STA z:addr(far_function_pointer)
    PHX
    SEP #0x20
    LDA #bank(unk_7E2020)
    STA z:addr(far_function_pointer + 2)
    LDA a:addr(debug_cursor)
    CLC
    ADC #8
    REP #0x20
    AND #0xFF
    ASL A
    TAX
    LDA f:offsets_to_debug_menu_map, X
    CLC
    ADC z:addr(far_function_pointer)
    STA z:addr(far_function_pointer)
    SEP #0x20
    LDA #' '
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    PLX
    RTL

draw_debug_cursor:
    REP #0x20
    LDA #addr(unk_7E2020)
    STA z:addr(far_function_pointer)
    SEP #0x20
    LDA #bank(unk_7E2020)
    STA z:addr(far_function_pointer + 2)
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
    ADC z:addr(far_function_pointer)
    STA z:addr(far_function_pointer)
    SEP #0x20
    LDA #'☺'
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    PLX
    RTL

write_on_off:
    SEP #0x20
    STA z:0x40
    REP #0x20
    LDA #addr(unk_7E2038)
    STA z:addr(far_function_pointer)
    PHX
    SEP #0x20
    LDA #bank(unk_7E2038)
    STA z:addr(far_function_pointer + 2)
    LDA a:addr(debug_cursor)
    CLC
    ADC #8
    REP #0x20
    AND #0xFF
    ASL A
    TAX
    LDA f:offsets_to_debug_menu_map, X
    CLC
    ADC z:addr(far_function_pointer)
    STA z:addr(far_function_pointer)
    SEP #0x20
    LDA z:0x40
    BNE .write_on

; write off
    LDA #'O'
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    SEP #0x20
    LDA #'F'
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    SEP #0x20
    LDA #'F'
    STA f:[z:addr(far_function_pointer)]
    BRA .loc_C603D5

.write_on:
    SEP #0x20
    LDA #' '
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    SEP #0x20
    LDA #'O'
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    SEP #0x20
    LDA #'N'
    STA f:[z:addr(far_function_pointer)]

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
    STA z:addr(far_function_pointer + 2)
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
    STA z:addr(far_function_pointer)
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
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    LDA z:0x40
    AND #0xF
    TAX
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    SEP #0x20
    LDA f:hex_digits, X
    STA f:[z:addr(far_function_pointer)]
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
    STA z:addr(far_function_pointer)
    PHX
    SEP #0x20
    LDA #bank(unk_7E2038)
    STA z:addr(far_function_pointer + 2)
    LDA a:addr(debug_cursor)
    CLC
    ADC #8
    REP #0x20
    AND #0xFF
    ASL A
    TAX
    LDA f:offsets_to_debug_menu_map, X
    CLC
    ADC z:addr(far_function_pointer)
    STA z:addr(far_function_pointer)
    LDA z:0x40
    AND #0xFF
    ASL A
    ASL A
    TAX
    SEP #0x20
    LDA f:speed_names, X
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INX
    SEP #0x20
    LDA f:speed_names, X
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INX
    SEP #0x20
    LDA f:speed_names, X
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    PLX
    RTL

.loc_C604D4:
    REP #0x20
    LDA #addr(unk_7E2038)
    STA z:addr(far_function_pointer)
    PHX
    SEP #0x20
    LDA #bank(unk_7E2038)
    STA z:addr(far_function_pointer + 2)
    LDA a:addr(debug_cursor)
    CLC
    ADC #8
    REP #0x20
    AND #0xFF
    ASL A
    TAX
    LDA f:offsets_to_debug_menu_map, X
    CLC
    ADC z:addr(far_function_pointer)
    STA z:addr(far_function_pointer)
    LDA z:0x40
    AND #0xFF
    ASL A
    ASL A
    TAX
    SEP #0x20
    LDA f:screen_names, X
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INX
    SEP #0x20
    LDA f:screen_names, X
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INX
    SEP #0x20
    LDA f:screen_names, X
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    PLX
    RTL

close_debug_menu:
    JSL remove_debug_menu_from_tilemap
    REP #0x20
    LDA #addr(set_data_from_debug_menu)
    STA z:pause_handler.handler, X
    SEP #0x20
    LDA #bank(set_data_from_debug_menu)
    STA z:pause_handler.handler + 2, X
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
    REP #0x20
    LDA #addr(handle_pause)
    STA z:object.handler, X
    SEP #0x20
    LDA #bank(handle_pause)
    STA z:object.handler + 2, X
    RTL

.no_poison:
    STA z:player.debug_skull, X
    
; Restore handler
    PLX
    REP #0x20
    LDA #addr(handle_pause)
    STA z:object.handler, X
    SEP #0x20
    LDA #bank(handle_pause)
    STA z:object.handler + 2, X
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
    STA z:addr(far_function_pointer)
    SEP #0x20
    LDA #bank(unk_7E2000)
    STA z:addr(far_function_pointer + 2)
    LDA f:[z:0x50]
    CMP #0xFF
    BNE .loc_C60A16
    RTL

.loc_C60A16:
    REP #0x20
    AND #0xFF
    ASL A
    CLC
    ADC z:addr(far_function_pointer)
    STA z:addr(far_function_pointer)
    INC z:0x50
    LDA f:[z:0x50]
    AND #0xFF
    ASL A
    TAX
    LDA f:offsets_to_debug_menu_map, X
    CLC
    ADC z:addr(far_function_pointer)
    STA z:addr(far_function_pointer)
    INC z:0x50
    SEP #0x20
    LDA #0xF
    STA z:0x40

.loc_C60A3B:
    LDA f:[z:0x50]
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    INC z:addr(far_function_pointer)
    SEP #0x20
    LDA #0x20
    STA f:[z:addr(far_function_pointer)]
    REP #0x20
    INC z:addr(far_function_pointer)
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
    STA z:addr(far_function_pointer + 2)
    LDA f:bonus_handlers, X
    STA z:addr(far_function_pointer)
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
    
    REP #0x20
    LDA #addr(do_trampoline)
    STA z:player.handler, X
    SEP #0x20
    LDA #bank(do_trampoline)
    STA z:player.handler + 2, X
    RTL

.is_ai:
    REP #0x20
    LDA #addr(do_trampoline)
    STA z:player.handler, X
    SEP #0x20
    LDA #bank(do_trampoline)
    STA z:player.handler + 2, X
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
    
    REP #0x20
    LDA #addr(do_player_warp)
    STA z:player.handler, X
    SEP #0x20
    LDA #bank(do_player_warp)
    STA z:player.handler + 2, X
    RTL

.warp_is_ai:
    REP #0x20
    LDA #addr(do_player_warp_ai)
    STA z:player.handler, X
    SEP #0x20
    LDA #bank(do_player_warp_ai)
    STA z:player.handler + 2, X

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
    
    ; Add 10 to the score
    LDA #0x0010
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed
    
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
    
    ; Add 200 to the score
    LDA #0x0200
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed
    
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
    
    ; Add 300 to the score
    LDA #0x0300
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed
    
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

    ; Add 400 to the score
    LDA #0x0400
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

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

    ; Add 500 to the score
    LDA #0x0500
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

    JSL clear_bonus_tile
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

extra_life_bonus:
    REP #0x20

    ; Add 600 to the score
    LDA #0x0600
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

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

    ; Add 700 to the score
    LDA #0x0700
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

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

    ; Add 800 to the score
    LDA #0x0800
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

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
    ; Add 900 to the score
    LDA #0x0900
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

.ai:
    JSL clear_bonus_tile
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

full_fire_bonus:
i16
    REP #0x20

    ; Add 1000 to the score
    LDA #0x1000
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

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

    ; Add 2000 to the score
    LDA #0x2000
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

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

    ; Add 3000 to the score
    LDA #0x3000
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

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

    ; Add 4000 to the score
    LDA #0x4000
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

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

    ; Add 5000 to the score
    LDA #0x5000
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

    JSL clear_bonus_tile
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

poison_bonus:
i16
    REP #0x20

    ; Add 6000 to the score
    LDA #0x6000
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

    JSL clear_bonus_tile
    JSL apply_poison
    
    LDY #SOUND_POISON
    JSL play_sound
    RTL

exit_bonus:
    SEP #0x20
    LDA a:addr(level_manager_object.enemy_count)
    BNE .ret
    JSL is_object_aligned
    BCS .ret
    REP #0x20
    LDA #addr(enter_level_exit)
    STA z:player.handler, X
    SEP #0x20
    LDA #bank(enter_level_exit)
    STA z:player.handler + 2, X
    
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
    
    ; Add 800 to the score
    REP #0x20
    LDA #0x800
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

    JSL clear_bonus_tile
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

cake_bonus:
i16
    REP #0x20
    
    ; Add 999900 to the score
    LDA #0x9900
    STA z:0x40
    LDA #0x99
    STA z:0x42
    JSL add_to_score_if_allowed
    
    JSL clear_bonus_tile
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

question_mark_bonus:
i16
    SEP #0x20
    LDA #bank(bomb_up_bonus)
    STA z:addr(far_function_pointer + 2)
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
    STA z:addr(far_function_pointer)
    JSL call_far_function_at_0053
    RTL

kendama_bonus:
i16
    REP #0x20

    ; Add 100 to the score
    LDA #0x100
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

    JSL clear_bonus_tile
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

unused_score_bonus:
i16
    REP #0x20

    ; Add 100 to the score
    LDA #0x100
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

    JSL clear_bonus_tile
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

apple_bonus:
i16
    REP #0x20

    ; Add 8000 to the score
    LDA #0x8000
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

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
    ; Add 9000 to the score
    LDA #0x9000
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

    JSL draw_number_of_lives
    JSL clear_bonus_tile
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

popsicle_bonus:
i16
    REP #0x20

    ; Add 500 to the score
    LDA #0x500
    STA z:0x40
    LDA #0x0000
    STA z:0x42
    JSL add_to_score_if_allowed

    JSL clear_bonus_tile
    
    LDY #SOUND_BONUS
    JSL play_sound
    RTL

ice_cream_bonus:
i16
    REP #0x20
    
    ; Add 50000 to the score
    LDA #0
    STA z:0x40
    LDA #5
    STA z:0x42
    JSL add_to_score_if_allowed
    
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
    REP #0x20
    LDA #addr(unused_palette_manager)
    STA z:0, X
    SEP #0x20
    LDA #bank(unused_palette_manager)
    STA z:2, X
    RTL

unused_palette_manager:
i16
    REP #0x20
    LDA #addr(palette_table)
    STA z:addr(far_function_pointer)
    SEP #0x20
    LDA #bank(palette_table)
    STA z:addr(far_function_pointer + 2)
    REP #0x20
    INC z:addr(far_function_pointer)
    LDA #1
    STA z:0x42
    LDA #0
    STA z:0x44
    LDA #8
    STA z:0x46
    JSL sub_C475C8
    REP #0x20
    LDA #addr(palette_table)
    STA z:addr(far_function_pointer)
    SEP #0x20
    LDA #bank(palette_table)
    STA z:addr(far_function_pointer + 2)
    REP #0x20
    LDA #addr(palette_table)
    CLC
    ADC #8
    STA z:addr(far_function_pointer)
    LDA #8
    STA z:0x42
    LDA #0
    STA z:0x44
    LDA #0x10
    STA z:0x46
    JSL sub_C475C8
    REP #0x20
    LDA #addr(.loc_C612AC)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C612AC)
    STA z:2, X
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
    handler_return_if_paused
    REP #0x20
    DEC z:0x10, X
    BNE .ret
    JSL sub_C61309
    REP #0x20
    LDA #0x10
    STA z:0x10, X
    REP #0x20
    LDA #addr(.loc_C612DF)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C612DF)
    STA z:2, X

.loc_C612DF:
    SEP #0x20
    handler_return_in_transition

    BIT #0x41
    BEQ .loc_C612F4
    JML .ret

.loc_C612F4:
    REP #0x20
    DEC z:0x10, X
    BNE .ret
    SEP #0x20
    LDA a:addr(game_flags)
    ; The bit it's setting off isn't even used, what is it trying to achieve?
    AND #GAME_FLAGS_SCREEN_TRANSITION | GAME_FLAGS_PAUSED | GAME_FLAGS_UNKNOWN | GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_BATTLE_DELAY | GAME_FLAGS_LEVEL_END | GAME_FLAGS_DEBUG_MENU
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
    handler_return_if_paused
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
    AND #DIR_RIGHT | DIR_LEFT
    BEQ .facing_vertically
    
    ; Already facing horizontally, keep moving in that direction
    LDA z:.INPUT_DIRECTIONS
    AND #DIR_RIGHT | DIR_LEFT
    STA z:player.direction, X
    STA z:player.last_zigzag_direction, X
    BRA +

.facing_vertically:
    ; Already facing vertically, keep moving in that direction
    LDA z:.INPUT_DIRECTIONS
    AND #DIR_UP | DIR_DOWN
    STA z:player.direction, X
    STA z:player.last_zigzag_direction, X
+

    JSL start_animation_by_index
    SEP #0x20

.resume_zigzag:
    LDA z:.INPUT_DIRECTIONS
    CMP #DIR_DOWN | DIR_LEFT
    BNE +
    JML .down_left
+

    CMP #DIR_DOWN | DIR_RIGHT
    BNE +
    JML .down_right
+

    CMP #DIR_UP | DIR_RIGHT
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
    EOR #DIR_UP | DIR_RIGHT
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
    EOR #DIR_UP | DIR_LEFT
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
    EOR #DIR_DOWN | DIR_LEFT
    STA z:.INPUT_DIRECTIONS
    RTL

.down_right:
    JSL is_hard_block_below
    BCS .keep_direction
    JSL is_hard_block_on_right
    BCS .keep_direction
    SEP #0x20
    LDA z:player.last_zigzag_direction, X
    EOR #DIR_DOWN | DIR_RIGHT
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
    REP #0x20
    lda_tile_id_offset X, 0, 0
    TAY
    LDA a:addr(collision_map), Y
    BIT z:0x42
    RTL

test_collision_above:
    REP #0x20
    lda_tile_id_offset X, 0, -9
    TAY
    LDA a:addr(collision_map), Y
    BIT z:0x42
    RTL

test_collision_below:
    REP #0x20
    lda_tile_id_offset X, 0, 8
    TAY
    LDA a:addr(collision_map), Y
    BIT z:0x42
    RTL

test_collision_on_the_left:
    REP #0x20
    lda_tile_id_offset X, -9, 0
    TAY
    LDA a:addr(collision_map), Y
    BIT z:0x42
    RTL

test_collision_on_the_right:
    REP #0x20
    lda_tile_id_offset X, 8, 0
    TAY
    LDA a:addr(collision_map), Y
    BIT z:0x42
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
    STA z:addr(far_function_pointer)
    INC z:0x50
    LDA f:[z:0x50]
    STA z:addr(far_function_pointer + 1)
    INC z:0x50
    INC z:0x50
    LDA z:addr(far_function_pointer)
    PHA
    LDA z:0x56
    PHA
    JSL call_far_function_at_0053
    REP #0x20
    PLA
    STA z:0x56
    PLA
    STA z:addr(far_function_pointer)
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
    STA z:addr(far_function_pointer)
    INC z:.ROM_ENEMY_FUNCTION_PTR
    LDA f:[z:.ROM_ENEMY_FUNCTION_PTR]
    STA z:addr(far_function_pointer + 1)
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
    LDA z:addr(far_function_pointer)
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
    STA z:addr(far_function_pointer)
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
    STA z:addr(.BONUS_PTR)
    LDA a:addr(level_manager_object.pointer_to_bonus_list+1)
    STA z:addr(.BONUS_PTR + 1)
    LDA #bank(stage_1_1)
    STA z:addr(.BONUS_PTR + 2)
    
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
    LDA f:[z:addr(.BONUS_PTR)], Y
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
    STA z:addr(.DEST)
    SEP #0x20
    LDA #bank(enemy_creation_functions)
    STA z:addr(.DEST + 2)
    
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
    JMP a:addr(set_collision_mask_for_tiles)

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
    LDY z:addr(.TILE_OFFSET)
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

sub_C61F91:
    SEP #0x20
    LDA #0x80
    STA a:addr(VRAM_ADDRESS_INCREMENT_VALUE)
    REP #0x20
    LDA #0x58CC
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x4E8
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x4E9
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x4EA
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x4EB
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x4EC
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x4ED
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x4EE
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x4EF
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x58EC
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0x4F8
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x4F9
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x4FA
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x4FB
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x4FC
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x4FD
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x4FE
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x4FF
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    RTL

sub_C62007:
    SEP #0x20
    LDA #0x80
    STA a:addr(VRAM_ADDRESS_INCREMENT_VALUE)
    REP #0x20
    LDA #0x58CC
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0x58EC
    STA a:addr(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    LDA #0
    STA a:addr(DATA_FOR_VRAM_WRITE_LOW_BYTE)
    RTL

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
    STA a:addr(0x20), Y

.locret_C620C3:
    RTL

sub_C620C4:
i16
    REP #0x20
    LDY #addr(player_1)

.loc_C620C9:
    SEP #0x20
    LDA a:addr(4), Y
    BEQ .loc_C620FA
    LDA a:addr(0x11), Y
    SEC
    SBC z:0x11, X
    BEQ .loc_C620F2
    BCS .loc_C620DD
    EOR #0xFF
    INC A

.loc_C620DD:
    CMP #0x10
    BCS .loc_C620FA
    LDA a:addr(0x14), Y
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
    LDA a:addr(0x14), Y
    SEC
    SBC z:0x14, X
    BNE .loc_C620E7

.loc_C620FA:
    REP #0x20
    LDA a:addr(6), Y
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

update_palettes:
i16
    SEP #0x20
    LDX #addr(palette_slots)

.loc_C6213C:
    LDA z:3, X
    BIT #1
    BEQ .loc_C62156
    CMP #3
    BNE .loc_C6214E
    JSL load_a_palette
    SEP #0x20
    BRA .loc_C62156

.loc_C6214E:
    STA z:3, X
    JSL fade_a_palette
    SEP #0x20

.loc_C62156:
    INX
    INX
    INX
    INX
    INX
    INX
    INX
    INX
    CPX #addr(palette_slots + palette_slot.sizeof * 8)
    BNE .loc_C6213C

.loc_C62163:
    LDA z:3, X
    BIT #1
    BEQ .loc_C6217D
    CMP #3
    BNE .loc_C62175
    JSL load_b_palette
    SEP #0x20
    BRA .loc_C6217D

.loc_C62175:
    STA z:3, X
    JSL fade_b_palette
    SEP #0x20

.loc_C6217D:
    INX
    INX
    INX
    INX
    INX
    INX
    INX
    INX
    CPX #0x2000
    BNE .loc_C62163
    LDA a:addr(word_7E0318)
    BEQ .locret_C621A3
    STZ a:addr(word_7E0318)
    REP #0x20
    LDA #addr(sub_C624AF)
    STA z:0x50
    SEP #0x20
    LDA #bank(sub_C624AF)
    STA z:0x52
    JSL sub_C62514

.locret_C621A3:
    RTL

load_a_palette:
    REP #0x20
    LDA #addr(a_palettes)
    STA z:addr(far_function_pointer)
    SEP #0x20
    LDA #bank(a_palettes)
    STA z:addr(far_function_pointer + 2)
    BRA load_palette_at_53

load_b_palette:
    REP #0x20
    LDA #addr(b_palettes)
    STA z:addr(far_function_pointer)
    SEP #0x20
    LDA #bank(b_palettes)
    STA z:addr(far_function_pointer + 2)

load_palette_at_53:
    SEP #0x20
    STZ z:2, X
    LDA z:3, X
    AND #0xFE
    STA z:3, X
    REP #0x20
    LDA z:4, X
    CLC
    ADC #addr(unk_7F0400)
    STA z:0x50
    SEP #0x20
    LDA #bank(unk_7F0400)
    STA z:0x52
    REP #0x20
    LDA z:0, X
    AND #0xFF
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    STA z:0x42
    CLC
    ADC z:addr(far_function_pointer)
    STA z:addr(far_function_pointer)
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    LDA a:addr(word_7E0318)
    ORA #1
    STA a:addr(word_7E0318)
    RTL

-
    RTL
    
fade_a_palette:
    REP #0x20
    LDA #addr(a_palettes)
    STA z:addr(far_function_pointer)
    SEP #0x20
    LDA #bank(a_palettes)
    STA z:addr(far_function_pointer + 2)
    BRA fade_palette

    SEP #0x20
fade_b_palette:

    REP #0x20
    LDA #addr(b_palettes)
    STA z:addr(far_function_pointer)
    SEP #0x20
    LDA #bank(b_palettes)
    STA z:addr(far_function_pointer + 2)

fade_palette:
    REP #0x20
    LDA z:1, X
    PHX
    AND #0xF
    TAX
    TAY
    SEP #0x20
    LDA f:byte_C62426, X
    PLX
    AND a:addr(word_7E0304)
    BNE -
    PHX
    REP #0x20
    TYA
    TAX
    SEP #0x20
    LDA f:byte_C62416, X
    PLX
    STA z:0x40
    LDA z:2, X
    SEC
    SBC z:0x40
    STA z:2, X
    BCS .loc_C6230B
    STZ z:2, X
    LDA z:3, X
    AND #0xFE
    STA z:3, X

.loc_C6230B:
    REP #0x20
    LDA z:4, X
    CLC
    ADC #addr(unk_7F0400)
    STA z:0x50
    SEP #0x20
    LDA #bank(unk_7F0400)
    STA z:0x52
    REP #0x20
    LDA z:0, X
    AND #0xFF
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    STA z:0x42
    CLC
    ADC z:addr(far_function_pointer)
    STA z:addr(far_function_pointer)
    LDA #0x10
    STA z:0x4A

.loc_C62333:
    JSL sub_C62357
    REP #0x20
    DEC z:0x4A
    BNE .loc_C62333
    RTL

sub_C6233E:
    REP #0x20
    LDA f:[z:addr(far_function_pointer)]
    STA f:[z:0x50]
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    INC z:0x50
    INC z:0x50
    SEP #0x20
    LDA a:addr(word_7E0318)
    ORA #1
    STA a:addr(word_7E0318)
    RTL
    
sub_C62357:
    REP #0x20
    LDA z:3, X
    AND #1
    BEQ sub_C6233E
    LDA f:[z:0x50]
    STA z:0x42
    LDA f:[z:addr(far_function_pointer)]
    STA z:0x48
    STZ z:0x46
    SEP #0x20
    LDA z:0x48
    AND #0x1F
    STA z:0x41
    LDA z:0x42
    AND #0x1F
    STA z:0x44
    JSL sub_C623E1
    SEP #0x20
    AND #0x1F
    STA z:0x46
    REP #0x20
    LDA z:0x48
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    SEP #0x20
    AND #0x1F
    STA z:0x41
    REP #0x20
    LDA z:0x42
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    SEP #0x20
    AND #0x1F
    STA z:0x44
    JSL sub_C623E1
    REP #0x20
    AND #0x1F
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    ORA z:0x46
    STA z:0x46
    LDA z:0x49
    LSR A
    LSR A
    AND #0x1F
    STA z:0x41
    LDA z:0x43
    LSR A
    LSR A
    AND #0x1F
    STA z:0x44
    JSL sub_C623E1
    SEP #0x20
    AND #0x1F
    ASL A
    ASL A
    ORA z:0x47
    STA z:0x47
    REP #0x20
    LDA z:0x46
    STA f:[z:0x50]
    INC z:0x50
    INC z:0x50
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    RTL

sub_C623E1:
    SEP #0x20
    SEC
    SBC z:0x41
    BCS .loc_C623F1
    LDA z:0x41
    SEC
    SBC z:0x44
    CMP z:2, X
    BCC .loc_C62413

.loc_C623F1:
    LDA a:addr(word_7E0318)
    ORA #1
    STA a:addr(word_7E0318)
    LDA z:0x44
    CMP z:0x41
    BEQ .locret_C62412
    BCC .loc_C62409
    SEC
    SBC z:0x40
    BCS .locret_C62408
    LDA z:0x41

.locret_C62408:
    RTL

.loc_C62409:
    CLC
    ADC z:0x40
    CMP #0x1F
    BCC .locret_C62412
    LDA z:0x41

.locret_C62412:
    RTL

.loc_C62413:
    LDA z:0x44
    RTL

byte_C62416:
    db 0x20, 0x10
    db 8, 4
    db 2, 1
    db 1, 1
    db 1, 1
    db 1, 1
    db 1, 1
    db 1, 1
    
byte_C62426:
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
    LDA z:0x40
    STA z:palette_slot.palette_index, X
    TYA
    STA z:palette_slot.fade_flags, X
    LDA #0x20
    STA z:palette_slot.fade_counter, X
    LDA #1
    STA z:palette_slot.fade_state, X
    TYA
    AND #0xFF
    BNE .needs_fade
    LDA #3
    STA z:palette_slot.fade_state, X

.needs_fade:
    PLX
    RTL

sub_C62460:
    REP #0x20
    LDA a:addr(word_7E030C)
    CMP a:addr(word_7E030E)
    BNE .loc_C6246B
    RTL

.loc_C6246B:
    TAX
    CLC
    ADC #0xA
    CMP #0x140
    BCC .loc_C62478
    LDA #0

.loc_C62478:
    STA a:addr(word_7E030C)
    SEP #0x20
    LDA a:addr(unk_7E031C), X
    STA z:0x50
    LDA a:addr(unk_7E031C + 1), X
    STA z:0x51
    LDA a:addr(unk_7E031C + 2), X
    STA z:0x52
    LDA a:addr(unk_7E031C + 3), X
    STA z:addr(far_function_pointer)
    LDA a:addr(unk_7E031C + 4), X
    STA z:addr(far_function_pointer + 1)
    LDA a:addr(unk_7E031C + 5), X
    STA z:addr(far_function_pointer + 2)
    REP #0x20
    LDA a:addr(unk_7E031C + 6), X
    STA z:0x40
    LDA a:addr(unk_7E031C + 8), X
    STA z:0x42
    JSL call_function_at_0050
    JML sub_C62460

sub_C624AF:
    SEP #0x20
    LDA #0
    STA a:addr(ADDRESS_FOR_CG_RAM_WRITE)
    LDA #0
    STA a:addr(DMA_5_PARAMS)
    LDA #0x22
    STA a:addr(DMA_5_B_ADDRESS)
    LDA #low(unk_7F0400)
    STA a:addr(DMA_5_A_ADDRESS_LOW_BYTE)
    LDA #high(unk_7F0400)
    STA a:addr(DMA_5_A_ADDRESS_HIGH_BYTE)
    LDA #bank(unk_7F0400)
    STA a:addr(DMA_5_A_ADDRESS_BANK)
    LDA #0
    STA a:addr(DMA_5_BYTES_COUNT_LOW_BYTE)
    LDA #2
    STA a:addr(DMA_5_BYTES_COUNT_HIGH_BYTE)
    LDA #0x20
    STA a:addr(REGULAR_DMA_CHANNEL_ENABLE)
    RTL

sub_C624DF:
    SEP #0x20
    LDA #0
    STA a:addr(ADDRESS_FOR_CG_RAM_WRITE)
    SEP #0x20
    LDA #0
    STA a:addr(DMA_5_PARAMS)
    LDA #0x22
    STA a:addr(DMA_5_B_ADDRESS)
    LDA a:0x53
    STA a:addr(DMA_5_A_ADDRESS_LOW_BYTE)
    LDA a:0x54
    STA a:addr(DMA_5_A_ADDRESS_HIGH_BYTE)
    LDA a:0x55
    STA a:addr(DMA_5_A_ADDRESS_BANK)
    LDA #0x20
    STA a:addr(DMA_5_BYTES_COUNT_LOW_BYTE)
    LDA #0
    STA a:addr(DMA_5_BYTES_COUNT_HIGH_BYTE)
    LDA #0x20
    STA a:addr(REGULAR_DMA_CHANNEL_ENABLE)
    RTL

sub_C62514:
    REP #0x20
    PHX
    LDA a:addr(word_7E030E)
    TAX
    CLC
    ADC #0xA
    CMP #0x140
    BCC .loc_C62527
    LDA #0

.loc_C62527:
    CMP a:addr(word_7E030C)
    BEQ .loc_C6255F
    TAY
    SEP #0x20
    LDA z:0x50
    STA a:addr(unk_7E031C), X
    LDA z:0x51
    STA a:addr(unk_7E031C + 1), X
    LDA z:0x52
    STA a:addr(unk_7E031C + 2), X
    LDA z:addr(far_function_pointer)
    STA a:addr(unk_7E031C + 3), X
    LDA z:addr(far_function_pointer + 1)
    STA a:addr(unk_7E031C + 4), X
    LDA z:addr(far_function_pointer + 2)
    STA a:addr(unk_7E031C + 5), X
    REP #0x20
    LDA z:0x40
    STA a:addr(unk_7E031C + 6), X
    LDA z:0x42
    STA a:addr(unk_7E031C + 8), X
    TYA
    STA a:addr(word_7E030E)

.loc_C6255D:
    PLX
    RTL

.loc_C6255F:
    INC a:addr(word_7E030A)
    BRA .loc_C6255D

unknown_init_:
    REP #0x20
    STZ a:addr(word_7E030C)
    STZ a:addr(word_7E030E)
    RTL

advance_animation_2:
    REP #0x20
    LDA #0xFF
    STA z:0x40
    BRA advance_animation.loc_C6257D
    ; fallthrough

advance_animation:
    REP #0x20
    LDA #0
    STA z:0x40

.loc_C6257D:
    LDA #addr(level_manager_object.hit_flags)
    STA z:0x56
    LDA a:addr(level_manager_object.hit_flags)

.loc_C62585:
    TAY
    LDA a:addr(4), Y
    AND #0xFF
    CMP z:player.y_position, X
    BCC .loc_C6259A
    STY z:0x56
    LDA a:addr(0), Y
    CMP #0xFFFF
    BNE .loc_C62585

.loc_C6259A:
    LDY a:addr(word_7E00BE)
    LDA [z:0x56]
    STA a:addr(0), Y
    TYA
    STA [z:0x56]
    LDA z:player.y_position, X
    STA a:addr(4), Y
    TXA
    STA a:addr(2), Y
    LDA a:addr(word_7E00BE)
    CLC
    ADC #0x40
    STA a:addr(word_7E00BE)
    SEP #0x20
    LDA z:0x40
    STA a:addr(5), Y
    LDA z:player.ticks_left_for_frames, X
    DEC A
    BNE .loc_C625CF
    LDA z:player.current_frame, X
    INC A
    CMP z:player.max_frame, X
    BCC .loc_C625CF
    REP #0x20
    SEC
    RTL

.loc_C625CF:
    REP #0x20
    CLC
    RTL

sub_C625D3:
    SEP #0x20
    LDA a:addr(5), Y
    BEQ load_animation_frame
    REP #0x20
    LDA z:0xC, X
    PHA
    JSL load_animation_frame
    REP #0x20
    PLA
    STA z:0xC, X
    CLC
    RTL

load_animation_frame:
i16
    SEP #0x20
    LDA a:addr(word_7E0308+1)
    BIT #0xC0
    BEQ .loc_C62601
    BIT #0x80
    BEQ .loc_C625FB
    JML .loc_C62729

.loc_C625FB:
    EOR #1
    STA a:addr(word_7E0308+1)
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
    STA z:addr(far_function_pointer)
    LDA f:[z:0x50], Y
    INY
    STA z:addr(far_function_pointer + 1)
    LDA f:[z:0x50], Y
    STA z:addr(far_function_pointer + 2)
    LDA f:[z:addr(far_function_pointer)]
    BNE .loc_C6262C
    JML .loc_C62731

.loc_C6262C:
    STA z:0x4C
    INC z:addr(far_function_pointer)
    BNE .loc_C62634
    INC z:addr(far_function_pointer + 1)

.loc_C62634:
    LDA a:addr(word_7E0306)
    STA z:0x56
    LDA a:addr(word_7E0306+1)
    STA z:0x57
    LDA a:addr(word_7E0308)
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
    LDA f:[z:addr(far_function_pointer)]
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
    LDA f:[z:addr(far_function_pointer)], Y
    CLC
    ADC z:0xD3
    STA f:[z:0x56]
    INC z:0x56
    STZ z:0x41
    LDA f:[z:addr(far_function_pointer)], Y
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
    LDA f:[z:addr(far_function_pointer)], Y
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
    ORA f:[z:addr(far_function_pointer)], Y
    STA f:[z:0x56]
    INC z:0x56
    INY
    LDA f:[z:addr(far_function_pointer)], Y
    AND #0xCF
    ORA z:0xE, X
    ORA z:0x47
    CLC
    ADC z:0x1E, X
    STA f:[z:0x56]
    LDA f:[z:addr(far_function_pointer)], Y
    AND #0x20
    PHX
    TAX
    LDA f:byte_C307D7+0x58, X
    PLX
    ORA z:0x4D
    LDY #0x200
    STA f:[z:0x56], Y
    INC z:0x56
    LDA a:addr(word_7E0306)
    CLC
    ADC #4
    STA a:addr(word_7E0306)
    BNE .loc_C626FF
    LDA a:addr(word_7E0306+1)
    BIT #1
    BNE .loc_C62729
    INC a:addr(word_7E0306+1)
    INC z:0x57

.loc_C626FF:
    REP #0x20
    LDA z:addr(far_function_pointer)
    CLC
    ADC #5
    STA z:addr(far_function_pointer)
    SEP #0x20
    DEC z:0x4C
    BEQ .loc_C62731
    JMP a:addr(.loc_C62657)
.loc_C62712:
    REP #0x20
    DEC z:0x56
    DEC z:0x56
    LDA z:addr(far_function_pointer)
    CLC
    ADC #5
    STA z:addr(far_function_pointer)
    SEP #0x20
    DEC z:0x4C
    BEQ .loc_C62731
    JMP a:addr(.loc_C62657)

.loc_C62729:
    LDA a:addr(word_7E0308+1)
    ORA #0x80
    STA a:addr(word_7E0308+1)

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
    LDA a:addr(word_7E0308+1)
    BIT #0xC0
    BEQ .loc_C627A2
    BIT #0x80
    BEQ .loc_C6279C
    JML .loc_C6280B

.loc_C6279C:
    EOR #1
    STA a:addr(word_7E0308+1)
    RTL

.loc_C627A2:
    LDA a:addr(word_7E0306)
    STA z:0x56
    LDA a:addr(word_7E0306+1)
    STA z:0x57
    LDA a:addr(word_7E0308)
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
    LDA a:addr(word_7E0306)
    CLC
    ADC #4
    STA a:addr(word_7E0306)
    BNE .locret_C6280A
    LDA a:addr(word_7E0306+1)
    BIT #1
    BNE .loc_C6280B
    INC a:addr(word_7E0306+1)

.locret_C6280A:
    RTL

.loc_C6280B:
    LDA a:addr(word_7E0308+1)
    ORA #0x80
    STA a:addr(word_7E0308+1)
    RTL

start_animation:
i16
    SEP #0x20
    LDA f:[z:0x50]
    STA z:player.max_frame, X
    STZ z:player.current_frame, X
    REP #0x20
    INC z:0x50
    LDA z:0x50
    STA z:player.current_animation, X
    SEP #0x20
    LDA z:0x52
    STA z:player.current_animation+2, X
    LDY #3
    LDA f:[z:0x50], Y
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
    LDA a:addr(0x80), X
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
    STA a:addr(APU_I_O_PORT_2)
    STA z:0x6F
    STA z:0x6E
    DEC A
    STA z:0x70
    RTL

.loc_C62876:
    STA z:0x70
    STA a:addr(APU_I_O_PORT_2)
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
    LDA f:[z:addr(far_function_pointer)]
    TAY
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    SEP #0x20
    LDA f:[z:addr(far_function_pointer)]
    STA z:0x52
    REP #0x20
    INC z:addr(far_function_pointer)
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
    LDA z:addr(far_function_pointer)
    TAY
    SEP #0x20
    LDA z:addr(far_function_pointer + 2)
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
    LDA a:addr(0), Y
    STA z:0x43
    INY

.loc_C629FF:
    ASL z:0x43
    BCS .loc_C62A07
    LDA z:0x42
    BRA .loc_C62A0D

.loc_C62A07:
    LDA a:addr(0), Y
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
    LDY z:addr(far_function_pointer)
    SEP #0x20
    LDA z:addr(far_function_pointer + 2)
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
    LDA a:addr(0), Y
    STA z:0x43
    INY
    CMP #0x81
    BNE .loc_C62A5F
    LDA a:addr(0), Y
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
    LDA a:addr(0), Y
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
    STA a:addr(0x16), Y
    INC z:0x50
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:addr(0x18), Y
    INC z:0x50
    INC z:0x50
    INC z:0x50
    LDA #0
    STA a:addr(0x20), Y
    STA a:addr(0x22), Y
    STA a:addr(0x24), Y
    STA a:addr(0x26), Y
    STA a:addr(0x28), Y
    STA a:addr(0x2A), Y

.locret_C62B02:
    RTL

sub_C62B03:
i16
    REP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_SCREEN_TRANSITION
    BNE hidden_bonus_object.locret_C62B02
    LDA #bank(lives_drop_to_zero_bonus)
    STA z:addr(far_function_pointer + 2)
    LDA z:0x16, X
    ASL A
    PHX
    TAX
    LDA f:hidden_bonus_verifiers_array, X
    STA z:addr(far_function_pointer)
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
    REP #0x20
    LDA #addr(.loc_C62B42)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C62B42)
    STA z:2, X

.loc_C62B42:
    JSL sub_C43B6E
    BCS hidden_bonus_object.locret_C62B02
    REP #0x20
    LDA z:0x18, X
    JSL create_bonus_object
    LDY #4
    JSL play_sound
    JSL delete_object
    RTL

lives_drop_to_zero_bonus:
    REP #0x20
    LDA a:addr(object.handler), Y
    CMP #addr(_player_death)
    BNE clear_carry
    SEP #0x20
    LDA a:addr(0x3D), Y
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
    LDA a:addr(4), Y
    AND #0xFF
    BEQ clear_carry
    LDA a:addr(player.down_keys), Y
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
    LDA a:addr(4), Y
    AND #0xFF
    BEQ clear_carry
    PHX
    TYX
    JSL get_object_square_index
    PLX
    TAY
    LDA a:addr(collision_map), Y
    AND #BONUS_MASK
    CMP #addr(EXIT)
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
    LDA a:addr(player.down_keys+1), Y
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
    CMP #addr(BOMB)
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
    LDA a:addr(0), Y
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
    LDA a:addr(0), Y
    CMP #addr(_play_hit_by_bomb_animation)
    BNE .loc_C62D2D
    JML set_carry

.loc_C62D2D:
    CLC
    RTL

place_6_bombs_bonus:
    SEP #0x20
    LDA a:addr(player.current_bomb_count), Y
    CMP #6
    BNE .loc_C62D3C
    JML set_carry

.loc_C62D3C:
    CLC
    RTL

score_20_bonus:
    SEP #0x20
    LDA a:addr(player.score_digits_12), Y
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
    db 6
    frame_oam_tile 0, 0xF0, 0x701, 0x40
    frame_oam_tile 0, 0xF8, 0x1701, 0x40
    frame_oam_tile 0, 0, 0x3701, 0x40
    frame_oam_tile 0xF8, 0xF0, 0x701, 0
    frame_oam_tile 0xF8, 0xF8, 0x1701, 0
    frame_oam_tile 0xF8, 0, 0x3701, 0
animation_frame_C62D84:
    db 8
    frame_oam_tile 0, 0xE8, 0x701, 0x40
    frame_oam_tile 0, 0xF0, 0x1701, 0x40
    frame_oam_tile 0, 0xF8, 0x2701, 0x40
    frame_oam_tile 0, 0, 0x3701, 0x40
    frame_oam_tile 0xF8, 0xE8, 0x701, 0
    frame_oam_tile 0xF8, 0xF0, 0x1701, 0
    frame_oam_tile 0xF8, 0xF8, 0x2701, 0
    frame_oam_tile 0xF8, 0, 0x3701, 0
animation_frame_C62DAD:
    db 0xA
    frame_oam_tile 0, 0xE0, 0x701, 0x40
    frame_oam_tile 0xF8, 0xE0, 0x701, 0
    frame_oam_tile 0, 0xE8, 0x1701, 0x40
    frame_oam_tile 0xF8, 0xE8, 0x1701, 0
    frame_oam_tile 0, 0xF0, 0x1101, 0x40
    frame_oam_tile 0xF8, 0xF0, 0x1101, 0
    frame_oam_tile 0, 0xF8, 0x2701, 0x40
    frame_oam_tile 0, 0, 0x3701, 0x40
    frame_oam_tile 0xF8, 0xF8, 0x2701, 0
    frame_oam_tile 0xF8, 0, 0x3701, 0
animation_frame_C62DE0:
    db 0xA
    frame_oam_tile 8, 0xE8, 1, 0x40
    frame_oam_tile 0, 0xE8, 0x101, 0x40
    frame_oam_tile 0, 0xF0, 0x1101, 0x40
    frame_oam_tile 0, 0xF8, 0x2101, 0x40
    frame_oam_tile 0, 0, 0x3101, 0x40
    frame_oam_tile 0xF0, 0xE8, 1, 0
    frame_oam_tile 0xF8, 0xE8, 0x101, 0
    frame_oam_tile 0xF8, 0xF0, 0x1101, 0
    frame_oam_tile 0xF8, 0xF8, 0x2101, 0
    frame_oam_tile 0xF8, 0, 0x3101, 0
animation_frame_C62E13:
    db 8
    frame_oam_tile 8, 0xE8, 0x1001, 0x40
    frame_oam_tile 0, 0xE8, 0x2001, 0x40
    frame_oam_tile 0, 0xF0, 0x3001, 0x40
    frame_oam_tile 0, 0xF8, 0x3101, 0x40
    frame_oam_tile 0xF0, 0xE8, 0x1001, 0
    frame_oam_tile 0xF8, 0xE8, 0x2001, 0
    frame_oam_tile 0xF8, 0xF0, 0x3001, 0
    frame_oam_tile 0xF8, 0xF8, 0x3101, 0
animation_frame_C62E3C:
    db 0xA
    frame_oam_tile 8, 0xE8, 0x1301, 0x40
    frame_oam_tile 8, 0xE0, 0x301, 0x40
    frame_oam_tile 0, 0xE0, 0x401, 0x40
    frame_oam_tile 0, 0xE8, 0x1401, 0x40
    frame_oam_tile 0, 0xF0, 0x2401, 0x40
    frame_oam_tile 0xF0, 0xE8, 0x1301, 0
    frame_oam_tile 0xF0, 0xE0, 0x301, 0
    frame_oam_tile 0xF8, 0xE0, 0x401, 0
    frame_oam_tile 0xF8, 0xE8, 0x1401, 0
    frame_oam_tile 0xF8, 0xF0, 0x2401, 0
animation_frame_C62E6F:
    db 6
    frame_oam_tile 0, 0xF0, 0x2301, 0x40
    frame_oam_tile 0, 0xE0, 0x2201, 0x40
    frame_oam_tile 0, 0xE8, 0x3201, 0x40
    frame_oam_tile 0xF8, 0xF0, 0x2301, 0
    frame_oam_tile 0xF8, 0xE0, 0x2201, 0
    frame_oam_tile 0xF8, 0xE8, 0x3201, 0
animation_frame_C62E8E:
    db 2
    frame_oam_tile 0, 0xEE, 0x2601, 0
    frame_oam_tile 0xF8, 0xDE, 0x501, 0x20
byte_C62E99:
    db 8
    animation_frame animation_frame_C62D65, 2
    animation_frame animation_frame_C62D84, 2
    animation_frame animation_frame_C62DAD, 2
    animation_frame animation_frame_C62DE0, 2
    animation_frame animation_frame_C62E13, 2
    animation_frame animation_frame_C62E3C, 2
    animation_frame animation_frame_C62E6F, 2
    animation_frame animation_frame_C62E8E, 2
animation_frame_C62EBA:
    db 4
    frame_oam_tile 0xF0, 0, 1, 0x60
    frame_oam_tile 0xF0, 0xF0, 1, 0xE0
    frame_oam_tile 0, 0xF0, 1, 0xA0
    frame_oam_tile 0, 0, 1, 0x20
animation_frame_C62ECF:
    db 4
    frame_oam_tile 0, 0, 0x201, 0xE0
    frame_oam_tile 0xF0, 0, 0x201, 0xA0
    frame_oam_tile 0, 0xF0, 0x201, 0x60
    frame_oam_tile 0xF0, 0xF0, 0x201, 0x20
animation_frame_C62EE4:
    db 4
    frame_oam_tile 0xF0, 0, 0x2001, 0xE0
    frame_oam_tile 0xF0, 0xF0, 0x2001, 0x60
    frame_oam_tile 0, 0, 0x2001, 0xA0
    frame_oam_tile 0, 0xF0, 0x2001, 0x20
animation_frame_C62EF9:
    db 4
    frame_oam_tile 0, 0, 0x2201, 0xE0
    frame_oam_tile 0xF0, 0, 0x2201, 0xA0
    frame_oam_tile 0, 0xF0, 0x2201, 0x60
    frame_oam_tile 0xF0, 0xF0, 0x2201, 0x20
animation_frame_C62F0E:
    db 4
    frame_oam_tile 0xF0, 0, 0x401, 0xA0
    frame_oam_tile 0, 0, 0x401, 0xE0
    frame_oam_tile 0, 0xF0, 0x401, 0x60
    frame_oam_tile 0xF0, 0xF0, 0x401, 0x20
byte_C62F23:
    db 5
    animation_frame animation_frame_C62EBA, 5
    animation_frame animation_frame_C62ECF, 4
    animation_frame animation_frame_C62EE4, 2
    animation_frame animation_frame_C62EF9, 1
    animation_frame animation_frame_C62F0E, 1
animation_frame_C62F38:
    db 8
    frame_oam_tile 0, 0xF8, 0x2000, 0xE0
    frame_oam_tile 0, 8, 0, 0xE0
    frame_oam_tile 0xF0, 8, 0, 0xA0
    frame_oam_tile 0xF0, 0xF8, 0x2000, 0xA0
    frame_oam_tile 0, 0xE8, 0, 0x60
    frame_oam_tile 0, 0xF8, 0x2000, 0x60
    frame_oam_tile 0xF0, 0xE8, 0, 0x20
    frame_oam_tile 0xF0, 0xF8, 0x2000, 0x20
animation_frame_C62F61:
    db 0x1C
    frame_oam_tile 0x20, 0, 0x2400, 0x60
    frame_oam_tile 0x10, 0, 0x2600, 0xE0
    frame_oam_tile 0, 0, 0x2001, 0xE0
    frame_oam_tile 0xD0, 0, 0x2400, 0x20
    frame_oam_tile 0xE0, 0, 0x2600, 0xA0
    frame_oam_tile 0xF0, 0, 0x2001, 0xA0
    frame_oam_tile 0x10, 0x10, 1, 0xE0
    frame_oam_tile 0, 0x10, 0x201, 0xE0
    frame_oam_tile 0xE0, 0x10, 1, 0xA0
    frame_oam_tile 0xF0, 0x10, 0x201, 0xA0
    frame_oam_tile 0x10, 0x20, 0x400, 0xE0
    frame_oam_tile 0, 0x20, 0x600, 0xE0
    frame_oam_tile 0xE0, 0x20, 0x400, 0xA0
    frame_oam_tile 0xF0, 0x20, 0x600, 0xA0
    frame_oam_tile 0x20, 0xF0, 0x2400, 0x60
    frame_oam_tile 0x10, 0xD0, 0x400, 0x60
    frame_oam_tile 0x10, 0xE0, 1, 0x60
    frame_oam_tile 0x10, 0xF0, 0x2600, 0x60
    frame_oam_tile 0, 0xD0, 0x600, 0x60
    frame_oam_tile 0, 0xE0, 0x201, 0x60
    frame_oam_tile 0, 0xF0, 0x2001, 0x60
    frame_oam_tile 0xE0, 0xD0, 0x400, 0x20
    frame_oam_tile 0xF0, 0xD0, 0x600, 0x20
    frame_oam_tile 0xE0, 0xE0, 1, 0x20
    frame_oam_tile 0xF0, 0xE0, 0x201, 0x20
    frame_oam_tile 0xD0, 0xF0, 0x2400, 0x20
    frame_oam_tile 0xE0, 0xF0, 0x2600, 0x20
    frame_oam_tile 0xF0, 0xF0, 0x2001, 0x20
animation_frame_C62FEE:
    db 0x28
stru_C62FEF:
    frame_oam_tile 0x10, 0, 0x2002, 0xE0
    frame_oam_tile 0x10, 0xF0, 0x2002, 0x60
    frame_oam_tile 0xE0, 0, 0x2002, 0xA0
    frame_oam_tile 0xE0, 0xF0, 0x2002, 0x20
    frame_oam_tile 0x20, 0, 0x602, 0xE0
    frame_oam_tile 0xD0, 0, 0x602, 0xA0
    frame_oam_tile 0x20, 0x10, 2, 0xE0
    frame_oam_tile 0x10, 0x10, 0x202, 0xE0
    frame_oam_tile 0, 0x10, 0x402, 0xE0
    frame_oam_tile 0xF0, 0x10, 0x402, 0xA0
    frame_oam_tile 0xE0, 0x10, 0x202, 0xA0
    frame_oam_tile 0xD0, 0x10, 2, 0xA0
    frame_oam_tile 0x20, 0x20, 0x2201, 0xE0
    frame_oam_tile 0x10, 0x20, 0x2401, 0xE0
    frame_oam_tile 0, 0x20, 0x2601, 0xE0
    frame_oam_tile 0xF0, 0x20, 0x2601, 0xA0
    frame_oam_tile 0xE0, 0x20, 0x2401, 0xA0
    frame_oam_tile 0xD0, 0x20, 0x2201, 0xA0
    frame_oam_tile 0x10, 0x30, 0x401, 0xE0
    frame_oam_tile 0, 0x30, 0x601, 0xE0
    frame_oam_tile 0xF0, 0x30, 0x601, 0xA0
    frame_oam_tile 0xE0, 0x30, 0x401, 0xA0
    frame_oam_tile 0x20, 0xD0, 0x2201, 0x60
    frame_oam_tile 0x20, 0xE0, 2, 0x60
    frame_oam_tile 0x20, 0xF0, 0x602, 0x60
    frame_oam_tile 0x10, 0xC0, 0x401, 0x6E
    frame_oam_tile 0x10, 0xD0, 0x2401, 0x60
    frame_oam_tile 0x10, 0xE0, 0x202, 0x60
    frame_oam_tile 0, 0xC0, 0x601, 0x60
    frame_oam_tile 0, 0xD0, 0x2601, 0x60
    frame_oam_tile 0, 0xE0, 0x402, 0x60
    frame_oam_tile 0xF0, 0xC0, 0x601, 0x20
    frame_oam_tile 0xE0, 0xC0, 0x401, 0x20
    frame_oam_tile 0xF0, 0xD0, 0x2601, 0x20
    frame_oam_tile 0xE0, 0xD0, 0x2401, 0x20
    frame_oam_tile 0xD0, 0xD0, 0x2201, 0x20
    frame_oam_tile 0xF0, 0xE0, 0x402, 0x20
    frame_oam_tile 0xE0, 0xE0, 0x202, 0x20
    frame_oam_tile 0xD0, 0xE0, 2, 0x20
    frame_oam_tile 0xD0, 0xF0, 0x602, 0x20
animation_frame_C630B7:
    db 0x30
stru_C630B8:
    frame_oam_tile 0, 0xF8, 0x2000, 0xE0
    frame_oam_tile 0, 8, 0, 0xE0
    frame_oam_tile 0xF0, 8, 0, 0xA0
    frame_oam_tile 0xF0, 0xF8, 0x2000, 0xA0
    frame_oam_tile 0, 0xE8, 0, 0x60
    frame_oam_tile 0, 0xF8, 0x2000, 0x60
    frame_oam_tile 0xF0, 0xE8, 0, 0x20
    frame_oam_tile 0xF0, 0xF8, 0x2000, 0x20
    frame_oam_tile 0x10, 0, 0x2002, 0xE0
    frame_oam_tile 0x10, 0xF0, 0x2002, 0x60
    frame_oam_tile 0xE0, 0, 0x2002, 0xA0
    frame_oam_tile 0xE0, 0xF0, 0x2002, 0x20
    frame_oam_tile 0x20, 0, 0x602, 0xE0
    frame_oam_tile 0xD0, 0, 0x602, 0xA0
    frame_oam_tile 0x20, 0x10, 2, 0xE0
    frame_oam_tile 0x10, 0x10, 0x202, 0xE0
    frame_oam_tile 0, 0x10, 0x402, 0xE0
    frame_oam_tile 0xF0, 0x10, 0x402, 0xA0
    frame_oam_tile 0xE0, 0x10, 0x202, 0xA0
    frame_oam_tile 0xD0, 0x10, 2, 0xA0
    frame_oam_tile 0x20, 0x20, 0x2201, 0xE0
    frame_oam_tile 0x10, 0x20, 0x2401, 0xE0
    frame_oam_tile 0, 0x20, 0x2601, 0xE0
    frame_oam_tile 0xF0, 0x20, 0x2601, 0xA0
    frame_oam_tile 0xE0, 0x20, 0x2401, 0xA0
    frame_oam_tile 0xD0, 0x20, 0x2201, 0xA0
    frame_oam_tile 0x10, 0x30, 0x401, 0xE0
    frame_oam_tile 0, 0x30, 0x601, 0xE0
    frame_oam_tile 0xF0, 0x30, 0x601, 0xA0
    frame_oam_tile 0xE0, 0x30, 0x401, 0xA0
    frame_oam_tile 0x20, 0xD0, 0x2201, 0x60
    frame_oam_tile 0x20, 0xE0, 2, 0x60
    frame_oam_tile 0x20, 0xF0, 0x602, 0x60
    frame_oam_tile 0x10, 0xC0, 0x401, 0x60
    frame_oam_tile 0x10, 0xD0, 0x2401, 0x60
    frame_oam_tile 0x10, 0xE0, 0x202, 0x60
    frame_oam_tile 0, 0xC0, 0x601, 0x60
    frame_oam_tile 0, 0xD0, 0x2601, 0x60
    frame_oam_tile 0, 0xE0, 0x402, 0x60
    frame_oam_tile 0xF0, 0xC0, 0x601, 0x20
    frame_oam_tile 0xE0, 0xC0, 0x401, 0x20
    frame_oam_tile 0xF0, 0xD0, 0x2601, 0x20
    frame_oam_tile 0xE0, 0xD0, 0x2401, 0x20
    frame_oam_tile 0xD0, 0xD0, 0x2201, 0x20
    frame_oam_tile 0xF0, 0xE0, 0x402, 0x20
    frame_oam_tile 0xE0, 0xE0, 0x202, 0x20
    frame_oam_tile 0xD0, 0xE0, 2, 0x20
    frame_oam_tile 0xD0, 0xF0, 0x602, 0x20
byte_C631A8:
    db 6
    animation_frame animation_frame_C62F38, 3
    animation_frame animation_frame_C62F61, 3
    animation_frame animation_frame_C62FEE, 3
    animation_frame animation_frame_C630B7, 3
    animation_frame animation_frame_C62F61, 3
    animation_frame animation_frame_C62FEE, 3
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
    
sub_C631D7:
    SEP #0x20
    create_object sub_C6326B
    BCC .loc_C631F3
    JML sub_C631C1.ret

.loc_C631F3:
    REP #0x20
    LDA z:0x11, X
    STA a:addr(0x11), Y
    LDA z:0x14, X
    STA a:addr(0x14), Y
    LDA f:[z:0x50]
    STA a:addr(0x16), Y
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:addr(0x19), Y
    INC z:0x50
    INC z:0x50
    LDA f:[z:0x50]
    STA a:addr(0x20), Y
    INC z:0x50
    INC z:0x50
    LDA #0
    STA a:addr(0x24), Y
    LDA #0
    STA a:addr(0x26), Y
    LDA #0
    STA a:addr(0x28), Y
    LDA f:[z:0x50]
    PHA
    AND #0x7FFF
    STA a:addr(0x22), Y
    LDA #addr(byte_C62F23)
    STA z:0x50
    LDA #0xE30
    STA a:addr(0xE), Y
    LDA #6
    STA a:addr(0x1E), Y
    PLA
    BIT #0x8000
    BEQ .loc_C6325D
    LDA #addr(byte_C631A8)
    STA z:0x50
    LDA #0xB30
    STA a:addr(0xE), Y
    LDA #6
    STA a:addr(0x1E), Y

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

sub_C6326B:
i16
    SEP #0x20
    handler_return_if_paused
    REP #0x20
    LDA z:0x26, X
    INC z:0x26, X
    BIT #0x1F
    BNE .loc_C63292
    LDY #0x1B
    JSL play_sound

.loc_C63292:
    REP #0x20
    LDA z:0x28, X
    INC z:0x28, X
    BIT #0xF
    BNE .loc_C632A4
    LDY #0x15
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
    STA a:addr(0x11), Y
    LDA z:0x33, X
    STA a:addr(0x14), Y
    LDA z:8, X
    STA a:addr(8), Y
    LDA z:0xA, X
    STA a:addr(0xA), Y
    LDA z:0xC, X
    STA a:addr(0xC), Y
    LDA z:0xE, X
    STA a:addr(0xE), Y
    LDA z:0x1E, X
    STA a:addr(0x1E), Y
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
    STA a:addr(enemy.x_position), Y
    LDA z:enemy.y_position, X
    STA a:addr(enemy.y_position), Y
    LDA z:0x46
    STA a:addr(enemy.animation), Y
    SEP #0x20
    LDA z:enemy.flags, X
    STA a:addr(enemy.flags), Y
    RTL

enemy_explosion:
i16
    LDY #0x16
    JSL play_sound
    SEP #0x20
    LDA #6
    STA z:enemy.effective_palette, X
    LDA #0xE
    STA z:enemy.palette+1, X
    LDA #0x30
    STA z:enemy.palette, X
    REP #0x20
    LDA #addr(byte_C62E99)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(_enemy_explosion)
    STA z:object.handler, X
    SEP #0x20
    LDA #bank(_enemy_explosion)
    STA z:object.handler+2, X

_enemy_explosion:
    SEP #0x20
    handler_return_if_paused
    JSL advance_animation
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
    REP #0x20
    LDA #addr(_kill_enemy)
    STA z:0, X
    SEP #0x20
    LDA #bank(_kill_enemy)
    STA z:2, X

_kill_enemy:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_SCREEN_TRANSITION | GAME_FLAGS_BATTLE_MENU
    BEQ .loc_C633E9
    JML .locret_C63455

.loc_C633E9:
    JSL advance_animation_2
    SEP #0x20
    handler_return_in_transition

    BIT #0x41
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
    LDA z:enemy.unknown_3a, X
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
    SEP #0x20
    LDA #bank(test_collision_above)
    STA z:0x52
    LDA #bank(test_collision_above)
    STA z:addr(far_function_pointer + 2)
    REP #0x20
    LDA z:enemy.direction, X
    AND #0xFF
    ASL A
    CLC
    ADC #addr(test_collision_funtions)
    STA z:0x50
    LDA f:[z:0x50]
    STA z:addr(far_function_pointer)
    JML [0x53]

    RTI
    
test_collision_funtions:
    da test_collision_above, test_collision_on_the_right, test_collision_below, test_collision_on_the_left
    
check_for_enemy_with_enemy_collision:
i16
    LDY #addr(gameover_related_object)
    STX z:0x50

.loc_C634C2:
    SEP #0x20
    LDA a:addr(3), Y
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

sub_C634FC:
i16
    REP #0x20
    LDY #addr(player_1)

.loc_C63501:
    SEP #0x20
    LDA a:addr(4), Y
    BIT #1
    BEQ .loc_C6352F
    LDA a:addr(0x11), Y
    SEC
    SBC z:0x11, X
    BCS .loc_C63515
    EOR #0xFF
    INC A

.loc_C63515:
    CMP z:0x41
    BCS .loc_C6352F
    LDA a:addr(0x14), Y
    SEC
    SBC z:0x14, X
    BCS .loc_C63524
    EOR #0xFF
    INC A

.loc_C63524:
    CMP z:0x40
    BCS .loc_C6352F
    SEP #0x20
    LDA #1
    STA a:addr(0x2F), Y

.loc_C6352F:
    REP #0x20
    TYA
    CLC
    ADC #0x40
    TAY
    CMP #addr(player_3)
    BNE .loc_C63501
    RTL

sub_C6353D:
i16
    REP #0x20
    LDY #addr(player_1)

.loc_C63542:
    LDA a:addr(4), Y
    BIT #0xFF
    BEQ .loc_C63593
    LDA z:0x42
    AND #0xFF
    STA z:0x46
    LDA a:addr(0x11), Y
    SEC
    SBC z:0x11, X
    BCS .loc_C63566
    EOR #0xFFFF
    INC A
    PHA
    LDA z:0x43
    AND #0xFF
    STA z:0x46
    PLA

.loc_C63566:
    CMP z:0x46
    BCS .loc_C63593
    LDA z:0x44
    AND #0xFF
    STA z:0x46
    LDA a:addr(0x14), Y
    SEC
    SBC z:0x14, X
    BCS .loc_C63586
    EOR #0xFFFF
    INC A
    PHA
    LDA z:0x45
    AND #0xFF
    STA z:0x46
    PLA

.loc_C63586:
    CMP z:0x46
    BCS .loc_C63593
    LDA a:addr(0x2F), Y
    ORA #1
    STA a:addr(0x2F), Y

.loc_C63593:
    TYA
    CLC
    ADC #0x40
    TAY
    CMP #addr(player_3)
    BNE .loc_C63542
    RTL

sub_C6359F:
    SEP #0x20
    LDA a:addr(4), Y
    BIT #1
    BEQ .loc_C635DE
    LDA z:0x42
    STA z:0x41
    LDA a:addr(0x11), Y
    SEC
    SBC z:0x11, X
    BCS .loc_C635BD
    PHA
    LDA z:0x43
    STA z:0x41
    PLA
    EOR #0xFF
    INC A

.loc_C635BD:
    CMP z:0x41
    BCS .loc_C635DE
    LDA z:0x44
    STA z:0x40
    LDA a:addr(0x14), Y
    SEC
    SBC z:0x14, X
    BCS .loc_C635D6
    PHA
    LDA z:0x45
    STA z:0x40
    PLA
    EOR #0xFF
    INC A

.loc_C635D6:
    CMP z:0x40
    BCS .loc_C635DE
    REP #0x20
    SEC
    RTL

.loc_C635DE:
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
    LDA a:addr(0x11), Y
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
    LDA a:addr(0x14), Y
    SEC
    SBC z:0x14, X
    BCS .locret_C6360D
    STZ z:0x44

.locret_C6360D:
    RTL

straight_movement:
    SEP #0x20
    LDA #bank(vectors_for_speed_and_direction)
    STA z:addr(far_function_pointer + 2)
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
    STA z:addr(far_function_pointer)
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
    ADC f:[z:addr(far_function_pointer)]
    STA z:enemy.fractional_x, X
    INC z:addr(far_function_pointer)
    INC z:addr(far_function_pointer)
    LDA z:enemy.fractional_y, X
    CLC
    ADC f:[z:addr(far_function_pointer)]
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
    JMP a:addr(sub_C63818)
    
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
    dw 0, 0xFF80, 0x80, 0, 0, 0x80, 0xFF80, 0; 0
    dw 0, 0xFF00, 0x100, 0, 0, 0x100, 0xFF00, 0; 8
    dw 0, 0xFF00, 0x100, 0, 0, 0x100, 0xFF00, 0; 0x10
    dw 0, 0xFF20, 0xE0, 0, 0, 0xE0, 0xFF20, 0; 0x18
    dw 0, 0xFE80, 0x180, 0, 0, 0x180, 0xFE80, 0; 0x20
sub_C6370B:
    REP #0x20
    LDA z:0x42
    CLC
    ADC z:0x11, X
    AND #0x1F0
    LSR A
    LSR A
    LSR A
    STA z:0x40
    LDA z:0x44
    CLC
    ADC z:0x14, X
    AND #0xF0
    ASL A
    ASL A
    ORA z:0x40
    TAY
    LSR z:0x42
    LSR z:0x42
    LSR z:0x42
    LSR z:0x42
    LSR z:0x44
    LSR z:0x44
    LSR z:0x44
    LSR z:0x44
    SEP #0x20
    LDA z:0x43
    CLC
    ADC z:0x42
    INC A
    STA z:0x42
    LDA z:0x45
    CLC
    ADC z:0x44
    INC A
    STA z:0x45

.loc_C63749:
    STY z:0x46
    LDA z:0x42
    STA z:0x43

.loc_C6374F:
    CPY #0x2DE
    BCS .loc_C6375B
    LDA a:addr(collision_map + 1), Y
    BIT #1
    BNE .loc_C63772

.loc_C6375B:
    DEY
    DEY
    DEC z:0x43
    BNE .loc_C6374F
    REP #0x20
    LDA z:0x46
    SEC
    SBC #0x40
    TAY
    SEP #0x20
    DEC z:0x45
    BNE .loc_C63749
    CLC
    RTL

.loc_C63772:
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
    ADC z:enemy.animation, X
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
    JSL is_object_aligned
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
    JSL is_object_aligned
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
    ADC z:enemy.animation, X
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
    JSL follower_movement_2
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
    JMP a:addr(.loc_C63852)

missle_movement:
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
    JSL follower_movement_2
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

follower_movement_2:
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
    ADC z:enemy.animation, X
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
    JMP a:addr(enemy_hit_deadend)

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
    JSL sub_C6359F
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
    JSL sub_C6359F
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
    LDA a:addr(0x11), Y
    AND #0xFF
    CLC
    ADC #0x200
    STA z:0x4C
    LDA a:addr(0x14), Y
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

animation_frame_C63D10:
    db 3
    frame_oam_tile 0, 0, 0x2000, 0x40
    frame_oam_tile 0xF8, 0, 0x2000, 0
    frame_oam_tile 0xF8, 0xF0, 0x2200, 0x20
animation_frame_C63D20:
    db 3
    frame_oam_tile 0, 0, 0x3000, 0x40
    frame_oam_tile 0xF8, 0, 0x3000, 0
    frame_oam_tile 0xF8, 0xF0, 0x2200, 0x20
animation_frame_C63D30:
    db 3
    frame_oam_tile 0xF8, 0, 0x3100, 0x40
    frame_oam_tile 0, 0, 0x3100, 0
    frame_oam_tile 0xF8, 0xF0, 0x2200, 0x20
animation_frame_C63D40:
    db 3
    frame_oam_tile 0xFC, 0xF8, 0x2600, 0x60
    frame_oam_tile 0xF9, 0xE8, 0x2201, 0x60
    frame_oam_tile 0xEC, 0xF8, 0x401, 0x60
animation_frame_C63D50:
    db 3
    frame_oam_tile 0xFC, 0xF8, 0x2001, 0x60
    frame_oam_tile 0xF9, 0xE8, 0x2201, 0x60
    frame_oam_tile 0xEC, 0xF8, 0x401, 0x60
animation_frame_C63D60:
    db 3
    frame_oam_tile 0xFC, 0xF8, 0x2400, 0x60
    frame_oam_tile 0xF9, 0xE8, 0x2201, 0x60
    frame_oam_tile 0xEC, 0xF8, 0x401, 0x60
animation_frame_C63D70:
    db 3
    frame_oam_tile 0xFC, 0xF8, 0x201, 0x60
    frame_oam_tile 0xF9, 0xE8, 0x2201, 0x60
    frame_oam_tile 0xEC, 0xF8, 0x401, 0x60
animation_frame_C63D80:
    db 3
    frame_oam_tile 0xFC, 0xF8, 0x601, 0x60
    frame_oam_tile 0xF9, 0xE8, 0x2201, 0x60
    frame_oam_tile 0xEC, 0xF8, 0x401, 0x60
animation_frame_C63D90:
    db 3
    frame_oam_tile 0xFC, 0xF8, 0x2401, 0x60
    frame_oam_tile 0xF9, 0xE8, 0x2201, 0x60
    frame_oam_tile 0xEC, 0xF8, 0x401, 0x60
animation_frame_C63DA0:
    db 4
    frame_oam_tile 0xF8, 0xE8, 0x600, 0x20
    frame_oam_tile 0, 0xF8, 0x100, 0
    frame_oam_tile 0xF8, 0xF8, 0, 0
    frame_oam_tile 0xF8, 0, 1, 0x20
animation_frame_C63DB5:
    db 4
    frame_oam_tile 0, 0xF8, 0x1100, 0
    frame_oam_tile 0xF8, 0xF8, 0x1000, 0
    frame_oam_tile 0xF8, 0xE8, 0x600, 0x20
    frame_oam_tile 0xF8, 0, 1, 0x20
animation_frame_C63DCA:
    db 4
    frame_oam_tile 0, 0xF8, 0x300, 0
    frame_oam_tile 0xF8, 0xF8, 0x200, 0
    frame_oam_tile 0xF8, 0xE8, 0x600, 0x20
    frame_oam_tile 0xF8, 0, 1, 0x20
animation_frame_C63DDF:
    db 4
    frame_oam_tile 0, 0xF8, 0x1300, 0
    frame_oam_tile 0xF8, 0xF8, 0x1200, 0
    frame_oam_tile 0xF8, 0xE8, 0x600, 0x20
    frame_oam_tile 0xF8, 0, 1, 0x20
animation_frame_C63DF4:
    db 4
    frame_oam_tile 0, 0xF8, 0x500, 0
    frame_oam_tile 0xF8, 0xF8, 0x400, 0
    frame_oam_tile 0xF8, 0xE8, 0x600, 0x20
    frame_oam_tile 0xF8, 0, 1, 0x20
animation_frame_C63E09:
    db 4
    frame_oam_tile 0, 0xF8, 0x1500, 0
    frame_oam_tile 0xF8, 0xF8, 0x1400, 0
    frame_oam_tile 0xF8, 0xE8, 0x600, 0x20
    frame_oam_tile 0xF8, 0, 1, 0x20
animation_frame_C63E1E:
    db 3
    frame_oam_tile 0xF4, 0xF8, 0x2600, 0x20
    frame_oam_tile 4, 0xF8, 0x401, 0x20
    frame_oam_tile 0xF7, 0xE8, 0x2201, 0x20
animation_frame_C63E2E:
    db 3
    frame_oam_tile 0xF4, 0xF8, 0x2001, 0x20
    frame_oam_tile 4, 0xF8, 0x401, 0x20
    frame_oam_tile 0xF7, 0xE8, 0x2201, 0x20
animation_frame_C63E3E:
    db 3
    frame_oam_tile 0xF4, 0xF8, 0x2400, 0x20
    frame_oam_tile 4, 0xF8, 0x401, 0x20
    frame_oam_tile 0xF7, 0xE8, 0x2201, 0x20
animation_frame_C63E4E:
    db 3
    frame_oam_tile 0xF4, 0xF8, 0x201, 0x20
    frame_oam_tile 4, 0xF8, 0x401, 0x20
    frame_oam_tile 0xF7, 0xE8, 0x2201, 0x20
animation_frame_C63E5E:
    db 3
    frame_oam_tile 0xF4, 0xF8, 0x601, 0x20
    frame_oam_tile 4, 0xF8, 0x401, 0x20
    frame_oam_tile 0xF7, 0xE8, 0x2201, 0x20
animation_frame_C63E6E:
    db 3
    frame_oam_tile 0xF4, 0xF8, 0x2401, 0x20
    frame_oam_tile 4, 0xF8, 0x401, 0x20
    frame_oam_tile 0xF7, 0xE8, 0x2201, 0x20
byte_C63E7E:
    db 4
    animation_frame animation_frame_C63D10, 2
    animation_frame animation_frame_C63D20, 2
    animation_frame animation_frame_C63D30, 2
    animation_frame animation_frame_C63D20, 2
byte_C63E8F:
    db 0xA
    animation_frame animation_frame_C63D40, 0x10
    animation_frame animation_frame_C63D50, 3
    animation_frame animation_frame_C63D60, 3
    animation_frame animation_frame_C63D70, 3
    animation_frame animation_frame_C63D80, 3
    animation_frame animation_frame_C63D90, 0x10
    animation_frame animation_frame_C63D80, 3
    animation_frame animation_frame_C63D70, 3
    animation_frame animation_frame_C63D60, 3
    animation_frame animation_frame_C63D50, 3
byte_C63EB8:
    db 0xB
    animation_frame animation_frame_C63DA0, 0x10
    animation_frame animation_frame_C63DB5, 3
    animation_frame animation_frame_C63DCA, 3
    animation_frame animation_frame_C63DDF, 3
    animation_frame animation_frame_C63DF4, 3
    animation_frame animation_frame_C63E09, 0x10
    animation_frame animation_frame_C63DF4, 3
    animation_frame animation_frame_C63DDF, 3
    animation_frame animation_frame_C63DCA, 3
    animation_frame animation_frame_C63DB5, 3
    animation_frame animation_frame_C63DA0, 3
byte_C63EE5:
    db 0xB
    animation_frame animation_frame_C63E1E, 0x10
    animation_frame animation_frame_C63E2E, 3
    animation_frame animation_frame_C63E3E, 3
    animation_frame animation_frame_C63E4E, 3
    animation_frame animation_frame_C63E5E, 3
    animation_frame animation_frame_C63E6E, 0x10
    animation_frame animation_frame_C63E5E, 3
    animation_frame animation_frame_C63E4E, 3
    animation_frame animation_frame_C63E3E, 3
    animation_frame animation_frame_C63E2E, 3
    animation_frame animation_frame_C63E1E, 3
animation_frame_C63F12:
    db 4
    frame_oam_tile 0, 0xEB, 0x201, 0x20
    frame_oam_tile 0xF0, 0xEB, 1, 0x20
    frame_oam_tile 0, 0xFB, 0x2201, 0x20
    frame_oam_tile 0xF0, 0xFB, 0x2001, 0x20
animation_frame_C63F27:
    db 4
    frame_oam_tile 0, 0xFB, 0x601, 0x20
    frame_oam_tile 0xF0, 0xFB, 0x401, 0x20
    frame_oam_tile 0, 0xEB, 0x201, 0x20
    frame_oam_tile 0xF0, 0xEB, 1, 0x20
animation_frame_C63F3C:
    db 4
    frame_oam_tile 0, 0xFB, 0x2000, 0x60
    frame_oam_tile 0xF0, 0xFB, 0x2200, 0x60
    frame_oam_tile 0xF0, 0xEB, 0x200, 0x60
    frame_oam_tile 0, 0xEB, 0, 0x60
animation_frame_C63F51:
    db 4
    frame_oam_tile 0xF0, 0xFB, 0x202, 0x60
    frame_oam_tile 0, 0xFB, 2, 0x60
    frame_oam_tile 0xF0, 0xEB, 0x200, 0x60
    frame_oam_tile 0, 0xEB, 0, 0x60
animation_frame_C63F66:
    db 4
    frame_oam_tile 0, 0xEB, 0x600, 0x20
    frame_oam_tile 0xF0, 0xEB, 0x400, 0x20
    frame_oam_tile 0, 0xFB, 0x2600, 0x20
    frame_oam_tile 0xF0, 0xFB, 0x2400, 0x20
animation_frame_C63F7B:
    db 4
    frame_oam_tile 0, 0xFB, 0x2601, 0x20
    frame_oam_tile 0xF0, 0xFB, 0x2401, 0x20
    frame_oam_tile 0, 0xEB, 0x600, 0x20
    frame_oam_tile 0xF0, 0xEB, 0x400, 0x20
animation_frame_C63F90:
    db 4
    frame_oam_tile 0, 0xFB, 0x2200, 0x20
    frame_oam_tile 0xF0, 0xFB, 0x2000, 0x20
    frame_oam_tile 0, 0xEB, 0x200, 0x20
    frame_oam_tile 0xF0, 0xEB, 0, 0x20
animation_frame_C63FA5:
    db 4
    frame_oam_tile 0, 0xFB, 0x202, 0x20
    frame_oam_tile 0xF0, 0xFB, 2, 0x20
    frame_oam_tile 0, 0xEB, 0x200, 0x20
    frame_oam_tile 0xF0, 0xEB, 0, 0x20
animation_frame_C63FBA:
    db 1
    frame_oam_tile 0xFD, 0xFD, 0x402, 2
animation_frame_C63FC0:
    db 1
    frame_oam_tile 0xFD, 0xFD, 0x402, 0x42
animation_frame_C63FC6:
    db 1
    frame_oam_tile 0xFD, 0xFD, 0x402, 0xC2
animation_frame_C63FCC:
    db 1
    frame_oam_tile 0xFD, 0xFD, 0x402, 0x82
animation_frame_C63FD2:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x602, 0x22
animation_frame_C63FD8:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x602, 0x62
animation_frame_C63FDE:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x602, 0xE2
animation_frame_C63FE4:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x602, 0xA2
animation_frame_C63FEA:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2602, 0x22
animation_frame_C63FF0:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2602, 0x62
animation_frame_C63FF6:
    db 1
    frame_oam_tile 0xF8, 0xF9, 0x2602, 0xE2
animation_frame_C63FFC:
    db 1
    frame_oam_tile 0xF8, 0xF9, 0x2602, 0xA2
animation_frame_C64002:
    db 1
    frame_oam_tile 0xFF, 0xF3, 0x2002, 0
animation_frame_C64008:
    db 1
    frame_oam_tile 0xF9, 0xF2, 0x2202, 0
animation_frame_C6400E:
    db 1
    frame_oam_tile 0xF8, 0xF0, 0x2102, 0
animation_frame_C64014:
    db 1
    frame_oam_tile 0xFA, 0xEB, 0x2302, 0
animation_frame_C6401A:
    db 1
    frame_oam_tile 0xFF, 0xEB, 0x3002, 0
animation_frame_C64020:
    db 1
    frame_oam_tile 0xFF, 0xEB, 0x2302, 0x40
animation_frame_C64026:
    db 1
    frame_oam_tile 1, 0xF0, 0x2102, 0x40
animation_frame_C6402C:
    db 1
    frame_oam_tile 0, 0xF2, 0x2202, 0x40
byte_C64032:
    db 2
stru_C64033:
    animation_frame animation_frame_C63F12, 0xE
    animation_frame animation_frame_C63F27, 0xE
byte_C6403B:
    db 2
    animation_frame animation_frame_C63F3C, 0xE
    animation_frame animation_frame_C63F51, 0xE
byte_C64044:
    db 2
    animation_frame animation_frame_C63F66, 0xE
    animation_frame animation_frame_C63F7B, 0xE
byte_C6404D:
    db 2
    animation_frame animation_frame_C63F90, 0xE
    animation_frame animation_frame_C63FA5, 0xE
byte_C64056:
    db 4
    animation_frame animation_frame_C63FBA, 3
    animation_frame animation_frame_C63FC0, 3
    animation_frame animation_frame_C63FC6, 3
    animation_frame animation_frame_C63FCC, 3
byte_C64067:
    db 4
    animation_frame animation_frame_C63FD2, 3
    animation_frame animation_frame_C63FD8, 3
    animation_frame animation_frame_C63FDE, 3
    animation_frame animation_frame_C63FE4, 3
byte_C64078:
    db 4
    animation_frame animation_frame_C63FEA, 3
    animation_frame animation_frame_C63FF0, 3
    animation_frame animation_frame_C63FF6, 3
    animation_frame animation_frame_C63FFC, 3
    db 1
    animation_frame animation_frame_C63F12, 0xFF
    db 1
    animation_frame animation_frame_C63F3C, 0xFF
    db 1
    animation_frame animation_frame_C63F66, 0xFF
    db 1
    animation_frame animation_frame_C63F90, 0xFF
byte_C6409D:
    db 8
    animation_frame animation_frame_C6401A, 4
    animation_frame animation_frame_C64020, 4
    animation_frame animation_frame_C64026, 4
    animation_frame animation_frame_C6402C, 4
    animation_frame animation_frame_C64002, 4
    animation_frame animation_frame_C64008, 4
    animation_frame animation_frame_C6400E, 4
    animation_frame animation_frame_C64014, 4
animation_frame_C640BE:
    db 3
    frame_oam_tile 0, 0, 0x1301, 0
    frame_oam_tile 0xF8, 0, 0x1201, 0
    frame_oam_tile 0xF8, 0xF0, 0x401, 0x20
animation_frame_C640CE:
    db 3
    frame_oam_tile 0xF8, 0xF0, 0x2001, 0x20
    frame_oam_tile 0, 0, 0x1301, 0
    frame_oam_tile 0xF8, 0, 0x1201, 0
animation_frame_C640DE:
    db 3
    frame_oam_tile 0, 0, 0x1301, 0
    frame_oam_tile 0xF8, 0, 0x1201, 0
    frame_oam_tile 0xF8, 0xF0, 0x601, 0x20
animation_frame_C640EE:
    db 3
    frame_oam_tile 0xF8, 0xF0, 0x2201, 0x20
    frame_oam_tile 0, 0, 0x1301, 0
    frame_oam_tile 0xF8, 0, 0x1201, 0
animation_frame_C640FE:
    db 3
    frame_oam_tile 0, 0, 0x101, 0
    frame_oam_tile 0xF8, 0, 1, 0
    frame_oam_tile 0xF8, 0xF0, 0x400, 0x60
animation_frame_C6410E:
    db 3
    frame_oam_tile 0, 0, 0x101, 0
    frame_oam_tile 0xF8, 0, 1, 0
    frame_oam_tile 0xF8, 0xF0, 0x2400, 0x60
animation_frame_C6411E:
    db 3
    frame_oam_tile 0, 0, 0x101, 0
    frame_oam_tile 0xF8, 0, 1, 0
    frame_oam_tile 0xF8, 0xF0, 0x600, 0x60
animation_frame_C6412E:
    db 3
    frame_oam_tile 0, 0, 0x101, 0
    frame_oam_tile 0xF8, 0, 1, 0
    frame_oam_tile 0xF8, 0xF0, 0x2600, 0x60
animation_frame_C6413E:
    db 3
    frame_oam_tile 0, 0, 0x1101, 0
    frame_oam_tile 0xF8, 0, 0x1001, 0
    frame_oam_tile 0xF8, 0xF0, 0, 0x20
animation_frame_C6414E:
    db 3
    frame_oam_tile 0, 0, 0x1101, 0
    frame_oam_tile 0xF8, 0, 0x1001, 0
    frame_oam_tile 0xF8, 0xF0, 0x2000, 0x20
animation_frame_C6415E:
    db 3
    frame_oam_tile 0, 0, 0x1101, 0
    frame_oam_tile 0xF8, 0, 0x1001, 0
    frame_oam_tile 0xF8, 0xF0, 0x200, 0x20
animation_frame_C6416E:
    db 3
    frame_oam_tile 0, 0, 0x1101, 0
    frame_oam_tile 0xF8, 0, 0x1001, 0
    frame_oam_tile 0xF8, 0xF0, 0x2200, 0x20
animation_frame_C6417E:
    db 3
    frame_oam_tile 0, 0, 1, 0x40
    frame_oam_tile 0xF8, 0, 0x101, 0x40
    frame_oam_tile 0xF8, 0xF0, 0x400, 0x20
animation_frame_C6418E:
    db 3
    frame_oam_tile 0, 0, 1, 0x40
    frame_oam_tile 0xF8, 0, 0x101, 0x40
    frame_oam_tile 0xF8, 0xF0, 0x2400, 0x20
animation_frame_C6419E:
    db 3
    frame_oam_tile 0, 0, 1, 0x40
    frame_oam_tile 0xF8, 0, 0x101, 0x40
    frame_oam_tile 0xF8, 0xF0, 0x600, 0x20
animation_frame_C641AE:
    db 3
    frame_oam_tile 0, 0, 1, 0x40
    frame_oam_tile 0xF8, 0, 0x101, 0x40
    frame_oam_tile 0xF8, 0xF0, 0x2600, 0x20
byte_C641BE:
    db 4
    animation_frame animation_frame_C640BE, 1
    animation_frame animation_frame_C640CE, 1
    animation_frame animation_frame_C640DE, 1
    animation_frame animation_frame_C640EE, 1
byte_C641CF:
    db 4
    animation_frame animation_frame_C640FE, 1
    animation_frame animation_frame_C6410E, 1
    animation_frame animation_frame_C6411E, 1
    animation_frame animation_frame_C6412E, 1
propene_animation:
    db 4
    animation_frame animation_frame_C6413E, 1; 0
    animation_frame animation_frame_C6414E, 1; 1
    animation_frame animation_frame_C6415E, 1; 2
    animation_frame animation_frame_C6416E, 1; 3
byte_C641F1:
    db 4
    animation_frame animation_frame_C6417E, 1; 0
    animation_frame animation_frame_C6418E, 1; 1
    animation_frame animation_frame_C6419E, 1; 2
    animation_frame animation_frame_C641AE, 1; 3
animation_frame_C64202:
    db 4
    frame_oam_tile 0, 0, 0x2200, 0x20
    frame_oam_tile 0xF0, 0, 0x2000, 0x20
    frame_oam_tile 0, 0xF0, 0x200, 0x20
    frame_oam_tile 0xF0, 0xF0, 0, 0x20
animation_frame_C64217:
    db 2
    frame_oam_tile 0xF8, 0, 0x2400, 0x20
    frame_oam_tile 0xF8, 0xF0, 0x400, 0x20
animation_frame_C64222:
    db 2
    frame_oam_tile 0xF8, 0, 0x2600, 0x20
    frame_oam_tile 0xF8, 0xF0, 0x600, 0x20
animation_frame_C6422D:
    db 4
    frame_oam_tile 0, 0, 0x2000, 0x60
    frame_oam_tile 0, 0xF0, 0, 0x60
    frame_oam_tile 0xF0, 0, 0x2200, 0x60
    frame_oam_tile 0xF0, 0xF0, 0x200, 0x60
    db 4
    db 0, 0, 1, 0x22, 0, 0xF0, 0, 1
    db 0x20, 0x20, 0, 0xF0, 1, 2, 0x20, 0xF0
    db 0xF0, 1, 0, 0x20
    db 4
    db 0, 0, 1, 0x22, 0
    db 0, 0xF0, 1, 2, 0x20
    db 0xF0, 0, 1, 0x24, 0x20
    db 0xF0, 0xF0, 1, 4, 0x20
    db 4
    db 0, 0xF0, 1, 2, 0x20
    db 0, 0, 1, 0x22, 0
    db 0xF0, 0, 1, 0x26, 0x20
    db 0xF0, 0xF0, 1, 6, 0x20
    db 4
    db 0, 0, 1, 0x22, 0
    db 0, 0xF0, 1, 2, 0x20
    db 0xF0, 0xF0, 1, 6, 0x20
    db 0xF0, 0, 2, 0, 0x20
    db 1
    animation_frame animation_frame_C64222, 0xFF
    db 1
    animation_frame animation_frame_C64202, 0xFF
    db 1
    animation_frame animation_frame_C64217, 0xFF
    db 1
    animation_frame animation_frame_C6422D, 0xFF
animation_frame_C642AA:
    db 2
    frame_oam_tile 0xF8, 0xF7, 0x2000, 0x20
    frame_oam_tile 0xF8, 0xE7, 0, 0x20
animation_frame_C642B5:
    db 2
    frame_oam_tile 0xF8, 0xFC, 0x2200, 0x20
    frame_oam_tile 0xF8, 0xEC, 0x200, 0x20
animation_frame_C642C0:
    db 2
    frame_oam_tile 0xF8, 0, 0x2400, 0x20
    frame_oam_tile 0xF8, 0xF0, 0x400, 0x20
animation_frame_C642CB:
    db 2
    frame_oam_tile 0xF8, 0xF5, 0x2000, 0x20
    frame_oam_tile 0xF8, 0xE5, 0, 0x20
animation_frame_C642D6:
    db 2
    frame_oam_tile 0xF8, 0xF3, 0x2000, 0x20
    frame_oam_tile 0xF8, 0xE3, 0, 0x20
animation_frame_C642E1:
    db 2
    frame_oam_tile 0xF8, 0xF0, 0x201, 0x20
    frame_oam_tile 0xF8, 0, 0x2400, 0x20
animation_frame_C642EC:
    db 2
    frame_oam_tile 0xF8, 0xEC, 1, 0x20
    frame_oam_tile 0xF8, 0xFC, 0x2200, 0x20
animation_frame_C642F7:
    db 2
    frame_oam_tile 0xF8, 0xE7, 0x600, 0x20
    frame_oam_tile 0xF8, 0xF7, 0x2000, 0x20
animation_frame_C64302:
    db 2
    frame_oam_tile 0xF8, 0xF5, 0x2000, 0x20
    frame_oam_tile 0xF8, 0xE5, 0x600, 0x20
animation_frame_C6430D:
    db 2
    frame_oam_tile 0xF8, 0xF3, 0x2000, 0x20
    frame_oam_tile 0xF8, 0xE3, 0x600, 0x20
animation_frame_C64318:
    db 2
    frame_oam_tile 0xF8, 0xF0, 0x2201, 0x20
    frame_oam_tile 0xF8, 0, 0x2400, 0x20
animation_frame_C64323:
    db 2
    frame_oam_tile 0xF8, 0xEC, 0x2001, 0x20
    frame_oam_tile 0xF8, 0xFC, 0x2200, 0x20
animation_frame_C6432E:
    db 2
    frame_oam_tile 0xF8, 0xE7, 0x2600, 0x20
    frame_oam_tile 0xF8, 0xF7, 0x2000, 0x20
animation_frame_C64339:
    db 2
    frame_oam_tile 0xF8, 0xE5, 0x2600, 0x20
    frame_oam_tile 0xF8, 0xF5, 0x2000, 0x20
animation_frame_C64344:
    db 2
    frame_oam_tile 0xF8, 0xE3, 0x2600, 0x20
    frame_oam_tile 0xF8, 0xF3, 0x2000, 0x20
animation_frame_C6434F:
    db 2
    frame_oam_tile 0xF8, 0xF0, 0x201, 0x60
    frame_oam_tile 0xF8, 0, 0x2400, 0x60
animation_frame_C6435A:
    db 2
    frame_oam_tile 0xF8, 0xEC, 1, 0x60
    frame_oam_tile 0xF8, 0xFC, 0x2200, 0x60
animation_frame_C64365:
    db 2
    frame_oam_tile 0xF8, 0xE7, 0x600, 0x60
    frame_oam_tile 0xF8, 0xF7, 0x2000, 0x60
animation_frame_C64370:
    db 2
    frame_oam_tile 0xF8, 0xE5, 0x600, 0x60
    frame_oam_tile 0xF8, 0xF5, 0x2000, 0x60
animation_frame_C6437B:
    db 2
    frame_oam_tile 0xF8, 0xE3, 0x600, 0x60
    frame_oam_tile 0xF8, 0xF3, 0x2000, 0x60
byte_C64386:
    db 8
    animation_frame animation_frame_C642C0, 0x10
    animation_frame animation_frame_C642B5, 3
    animation_frame animation_frame_C642AA, 4
    animation_frame animation_frame_C642CB, 6
    animation_frame animation_frame_C642D6, 8
    animation_frame animation_frame_C642CB, 6
    animation_frame animation_frame_C642AA, 4
    animation_frame animation_frame_C642B5, 3
byte_C643A7:
    db 8
    animation_frame animation_frame_C6434F, 0x10
    animation_frame animation_frame_C6435A, 3
    animation_frame animation_frame_C64365, 4
    animation_frame animation_frame_C64370, 6
    animation_frame animation_frame_C6437B, 8
    animation_frame animation_frame_C64370, 6
    animation_frame animation_frame_C64365, 4
    animation_frame animation_frame_C6435A, 3
byte_C643C8:
    db 8
    animation_frame animation_frame_C64318, 0x10
    animation_frame animation_frame_C64323, 3
    animation_frame animation_frame_C6432E, 4
    animation_frame animation_frame_C64339, 6
    animation_frame animation_frame_C64344, 8
    animation_frame animation_frame_C64339, 6
    animation_frame animation_frame_C6432E, 4
    animation_frame animation_frame_C64323, 3
byte_C643E9:
    db 8
    animation_frame animation_frame_C642E1, 0x10
    animation_frame animation_frame_C642EC, 3
    animation_frame animation_frame_C642F7, 4
    animation_frame animation_frame_C64302, 6
    animation_frame animation_frame_C6430D, 8
    animation_frame animation_frame_C64302, 6
    animation_frame animation_frame_C642F7, 4
    animation_frame animation_frame_C642EC, 3
animation_frame_C6440A:
    db 3
    frame_oam_tile 0, 0xF0, 0x3100, 0
    frame_oam_tile 0xF8, 0xF0, 0x3000, 0
    frame_oam_tile 0xF8, 0xF8, 0, 0x20
animation_frame_C6441A:
    db 3
    frame_oam_tile 0, 0xF0, 0x3300, 0
    frame_oam_tile 0xF8, 0xF0, 0x3200, 0
    frame_oam_tile 0xF8, 0xF8, 0x200, 0x20
animation_frame_C6442A:
    db 3
    frame_oam_tile 0, 0xF0, 0x3500, 0
    frame_oam_tile 0xF8, 0xF0, 0x3400, 0
    frame_oam_tile 0xF8, 0xF8, 0x400, 0x20
animation_frame_C6443A:
    db 3
    frame_oam_tile 0, 0xF0, 0x3700, 0
    frame_oam_tile 0xF8, 0xF0, 0x3600, 0
    frame_oam_tile 0xF8, 0xF8, 0x600, 0x20
animation_frame_C6444A:
    db 3
    frame_oam_tile 0xFE, 0xF0, 0x2100, 0
    frame_oam_tile 0xF6, 0xF0, 0x2000, 0
    frame_oam_tile 0xF6, 0xF8, 1, 0x20
animation_frame_C6445A:
    db 3
    frame_oam_tile 0, 0xF0, 0x2300, 0
    frame_oam_tile 0xF8, 0xF0, 0x2200, 0
    frame_oam_tile 0xF8, 0xF8, 0x201, 0x20
animation_frame_C6446A:
    db 3
    frame_oam_tile 0, 0xF0, 0x2500, 0
    frame_oam_tile 0xF8, 0xF0, 0x2400, 0
    frame_oam_tile 0xF8, 0xF8, 0x401, 0x20
animation_frame_C6447A:
    db 3
    frame_oam_tile 0, 0xF0, 0x2700, 0
    frame_oam_tile 0xF8, 0xF0, 0x2600, 0
    frame_oam_tile 0xF8, 0xF8, 0x601, 0x20
byte_C6448A:
    db 8
    animation_frame animation_frame_C6440A, 9
    animation_frame animation_frame_C6441A, 9
    animation_frame animation_frame_C6442A, 9
    animation_frame animation_frame_C6443A, 9
    animation_frame animation_frame_C6444A, 9
    animation_frame animation_frame_C6445A, 9
    animation_frame animation_frame_C6446A, 9
    animation_frame animation_frame_C6447A, 9
animation_frame_C644AB:
    db 3
    frame_oam_tile 0, 0, 0x2300, 0
    frame_oam_tile 0xF8, 0, 0x2200, 0
    frame_oam_tile 0xF8, 0xF0, 0x600, 0x20
animation_frame_C644BB:
    db 3
    frame_oam_tile 0, 0xFF, 0x2500, 0
    frame_oam_tile 0xF8, 0xFF, 0x2400, 0
    frame_oam_tile 0xF8, 0xEF, 1, 0x20
animation_frame_C644CB:
    db 3
    frame_oam_tile 0xF8, 0xFF, 0x3400, 0
    frame_oam_tile 0, 0xFF, 0x3500, 0
    frame_oam_tile 0xF8, 0xEF, 0x201, 0x20
animation_frame_C644DB:
    db 3
    frame_oam_tile 0xF8, 0, 0x2700, 0x40
    frame_oam_tile 0, 0, 0x2600, 0x40
    frame_oam_tile 0xF8, 0xF0, 0x401, 0x60
animation_frame_C644EB:
    db 3
    frame_oam_tile 0xF8, 0xFF, 0x3700, 0x40
    frame_oam_tile 0, 0xFF, 0x3600, 0x40
    frame_oam_tile 0xF8, 0xEF, 0x601, 0x60
animation_frame_C644FB:
    db 3
    frame_oam_tile 0xF8, 0xFF, 0x2301, 0x40
    frame_oam_tile 0, 0xFF, 0x2201, 0x40
    frame_oam_tile 0xF8, 0xEF, 0x2001, 0x60
animation_frame_C6450B:
    db 3
    frame_oam_tile 0, 0, 0x2100, 0
    frame_oam_tile 0xF8, 0, 0x2000, 0
    frame_oam_tile 0xF8, 0xF0, 0, 0x20
animation_frame_C6451B:
    db 3
    frame_oam_tile 0, 0xFF, 0x3100, 0
    frame_oam_tile 0xF8, 0xFF, 0x3000, 0
    frame_oam_tile 0xF8, 0xEF, 0x200, 0x20
animation_frame_C6452B:
    db 3
    frame_oam_tile 0xF8, 0xFF, 0x3200, 0
    frame_oam_tile 0, 0xFF, 0x3300, 0
    frame_oam_tile 0xF8, 0xEF, 0x400, 0x20
animation_frame_C6453B:
    db 3
    frame_oam_tile 0, 0, 0x2700, 0
    frame_oam_tile 0xF8, 0, 0x2600, 0
    frame_oam_tile 0xF8, 0xF0, 0x401, 0x20
animation_frame_C6454B:
    db 3
    frame_oam_tile 0, 0xFF, 0x3700, 0
    frame_oam_tile 0xF8, 0xFF, 0x3600, 0
    frame_oam_tile 0xF8, 0xEF, 0x601, 0x20
animation_frame_C6455B:
    db 3
    frame_oam_tile 0, 0xFF, 0x2301, 0
    frame_oam_tile 0xF8, 0xFF, 0x2201, 0
    frame_oam_tile 0xF8, 0xEF, 0x2001, 0x20
byte_C6456B:
    db 4
    animation_frame animation_frame_C644AB, 0xE
    animation_frame animation_frame_C644BB, 0xE
    animation_frame animation_frame_C644AB, 0xE
    animation_frame animation_frame_C644CB, 0xE
byte_C6457C:
    db 4
    animation_frame animation_frame_C644DB, 0xE
    animation_frame animation_frame_C644EB, 0xE
    animation_frame animation_frame_C644DB, 0xE
    animation_frame animation_frame_C644FB, 0xE
byte_C6458D:
    db 4
    animation_frame animation_frame_C6450B, 0xE
    animation_frame animation_frame_C6451B, 0xE
    animation_frame animation_frame_C6450B, 0xE
    animation_frame animation_frame_C6452B, 0xE
byte_C6459E:
    db 4
    animation_frame animation_frame_C6453B, 0xE
    animation_frame animation_frame_C6454B, 0xE
    animation_frame animation_frame_C6453B, 0xE
    animation_frame animation_frame_C6455B, 0xE
animation_frame_C645AF:
    db 8
    frame_oam_tile 0xFE, 0xFF, 0x202, 0x20
    frame_oam_tile 0xEE, 0xFF, 2, 0x20
    frame_oam_tile 0xE, 0xEF, 0x2400, 0x20
    frame_oam_tile 0xFE, 0xEF, 0x2200, 0x20
    frame_oam_tile 0xEE, 0xEF, 0x2000, 0x20
    frame_oam_tile 0xE, 0xDF, 0x400, 0x20
    frame_oam_tile 0xFE, 0xDF, 0x200, 0x20
    frame_oam_tile 0xEE, 0xDF, 0, 0x20
animation_frame_C645D8:
    db 8
    frame_oam_tile 0xEE, 0xF0, 0x2405, 0x20
    frame_oam_tile 0xEE, 0xE0, 0x2205, 0x20
    frame_oam_tile 0xFE, 0, 0x202, 0x20
    frame_oam_tile 0xEE, 0, 2, 0x20
    frame_oam_tile 0xE, 0xF0, 0x2400, 0x20
    frame_oam_tile 0xFE, 0xF0, 0x2200, 0x20
    frame_oam_tile 0xE, 0xE0, 0x400, 0x20
    frame_oam_tile 0xFE, 0xE0, 0x200, 0x20
animation_frame_C64601:
    db 8
    frame_oam_tile 0xFE, 0xF0, 0x2600, 0x20
    frame_oam_tile 0xE, 0xF0, 0x2001, 0x20
    frame_oam_tile 0xE, 0xE0, 1, 0x20
    frame_oam_tile 0xFE, 0xE0, 0x600, 0x20
    frame_oam_tile 0xFE, 0, 0x202, 0x20
    frame_oam_tile 0xEE, 0, 2, 0x20
    frame_oam_tile 0xEE, 0xF0, 0x2000, 0x20
    frame_oam_tile 0xEE, 0xE0, 0, 0x20
animation_frame_C6462A:
    db 8
    frame_oam_tile 0x10, 0xFC, 0x203, 0x60
    frame_oam_tile 0x10, 0xEC, 0x2201, 0x60
    frame_oam_tile 0, 0xFC, 0x403, 0x60
    frame_oam_tile 0, 0xEC, 0x2401, 0x60
    frame_oam_tile 0, 0xDC, 0x401, 0x60
    frame_oam_tile 0xF0, 0xDC, 0x601, 0x60
    frame_oam_tile 0xF0, 0xEC, 0x2601, 0x60
    frame_oam_tile 0xF0, 0xFC, 0x603, 0x60
animation_frame_C64653:
    db 8
    frame_oam_tile 0xF0, 0xDD, 0x201, 0x60
    frame_oam_tile 0x10, 0xFD, 0x203, 0x60
    frame_oam_tile 0x10, 0xED, 0x2201, 0x60
    frame_oam_tile 0, 0xFD, 0x403, 0x60
    frame_oam_tile 0, 0xED, 0x2401, 0x60
    frame_oam_tile 0, 0xDD, 0x401, 0x60
    frame_oam_tile 0xF0, 0xED, 0x2601, 0x60
    frame_oam_tile 0xF0, 0xFD, 0x603, 0x60
animation_frame_C6467C:
    db 8
    frame_oam_tile 0x10, 0xFD, 0x2602, 0x60
    frame_oam_tile 0x10, 0xED, 0x602, 0x60
    frame_oam_tile 0, 0xFD, 0x2003, 0x60
    frame_oam_tile 0, 0xED, 3, 0x60
    frame_oam_tile 0, 0xDD, 0x401, 0x60
    frame_oam_tile 0xF0, 0xDD, 0x601, 0x60
    frame_oam_tile 0xF0, 0xED, 0x2601, 0x60
    frame_oam_tile 0xF0, 0xFD, 0x603, 0x60
animation_frame_C646A5:
    db 0xB
    frame_oam_tile 8, 0xDF, 0x2402, 0x20
    frame_oam_tile 0xF8, 0xDF, 0x2202, 0x20
    frame_oam_tile 0xE8, 0xFF, 0x402, 0x20
    frame_oam_tile 0xA, 0x10, 0x2204, 0x20
    frame_oam_tile 0xF8, 0xF, 0x2004, 0x20
    frame_oam_tile 0xA, 0, 0x204, 0x20
    frame_oam_tile 0xF8, 0xFF, 4, 0x20
    frame_oam_tile 8, 0xEF, 0x2603, 0x20
    frame_oam_tile 0xF8, 0xEF, 0x2403, 0x20
    frame_oam_tile 0xE8, 0xEF, 0x2203, 0x20
    frame_oam_tile 0xE8, 0xDF, 0x2002, 0x20
animation_frame_C646DD:
    db 0xB
    frame_oam_tile 0xFC, 0xE0, 0x604, 0x20
    frame_oam_tile 0xEC, 0xE0, 0x404, 0x20
    frame_oam_tile 0xE8, 0, 0x402, 0x20
    frame_oam_tile 0xA, 0x10, 0x2204, 0x20
    frame_oam_tile 0xF8, 0x10, 0x2004, 0x20
    frame_oam_tile 0xA, 0, 0x204, 0x20
    frame_oam_tile 0xF8, 0, 4, 0x20
    frame_oam_tile 8, 0xE0, 0x2402, 0x20
    frame_oam_tile 8, 0xF0, 0x2603, 0x20
    frame_oam_tile 0xF8, 0xF0, 0x2403, 0x20
    frame_oam_tile 0xE8, 0xF0, 0x2203, 0x20
animation_frame_C64715:
    db 9
    frame_oam_tile 0xFC, 0x10, 0x2005, 0x20
    frame_oam_tile 0xFC, 0, 0x2604, 0x20
    frame_oam_tile 0xEC, 0, 0x2404, 0x20
    frame_oam_tile 0xC, 0xF0, 0x605, 0x20
    frame_oam_tile 0xFC, 0xF0, 0x405, 0x20
    frame_oam_tile 0xEC, 0xF0, 0x205, 0x20
    frame_oam_tile 0xC, 0xE0, 0x2402, 0x20
    frame_oam_tile 0xFC, 0xE0, 0x2202, 0x20
    frame_oam_tile 0xEC, 0xE0, 0x2002, 0x20
animation_frame_C64743:
    db 8
    frame_oam_tile 0, 0xDC, 0x601, 0x20
    frame_oam_tile 0, 0xEC, 0x2601, 0x20
    frame_oam_tile 0, 0xFC, 0x603, 0x20
    frame_oam_tile 0xF0, 0xFC, 0x403, 0x20
    frame_oam_tile 0xF0, 0xEC, 0x2401, 0x20
    frame_oam_tile 0xF0, 0xDC, 0x401, 0x20
    frame_oam_tile 0xE0, 0xFC, 0x203, 0x20
    frame_oam_tile 0xE0, 0xEC, 0x2201, 0x20
animation_frame_C6476C:
    db 8
    frame_oam_tile 0, 0xDD, 0x201, 0x20
    frame_oam_tile 0, 0xED, 0x2601, 0x20
    frame_oam_tile 0, 0xFD, 0x603, 0x20
    frame_oam_tile 0xF0, 0xFD, 0x403, 0x20
    frame_oam_tile 0xF0, 0xED, 0x2401, 0x20
    frame_oam_tile 0xF0, 0xDD, 0x401, 0x20
    frame_oam_tile 0xE0, 0xFD, 0x203, 0x20
    frame_oam_tile 0xE0, 0xED, 0x2201, 0x20
animation_frame_C64795:
    db 8
    frame_oam_tile 0xE0, 0xFD, 0x2602, 0x20
    frame_oam_tile 0xE0, 0xED, 0x602, 0x20
    frame_oam_tile 0xF0, 0xFD, 0x2003, 0x20
    frame_oam_tile 0xF0, 0xED, 3, 0x20
    frame_oam_tile 0, 0xDD, 0x601, 0x20
    frame_oam_tile 0, 0xED, 0x2601, 0x20
    frame_oam_tile 0, 0xFD, 0x603, 0x20
    frame_oam_tile 0xF0, 0xDD, 0x401, 0x20
byte_C647BE:
    db 2
    animation_frame animation_frame_C645AF, 0x10
    animation_frame animation_frame_C645D8, 0x10
byte_C647C7:
    db 2
    animation_frame animation_frame_C6462A, 0x10
    animation_frame animation_frame_C64653, 0x10
byte_C647D0:
    db 2
    animation_frame animation_frame_C646A5, 0x10
    animation_frame animation_frame_C646DD, 0x10
byte_C647D9:
    db 2
    animation_frame animation_frame_C64743, 0x10
    animation_frame animation_frame_C6476C, 0x10
byte_C647E2:
    db 1
    animation_frame animation_frame_C64601, 0xFF
byte_C647E7:
    db 1
    animation_frame animation_frame_C6467C, 0xFF
byte_C647EC:
    db 1
    animation_frame animation_frame_C64715, 0xFF
byte_C647F1:
    db 1
    animation_frame animation_frame_C64795, 0xFF
animation_frame_C647F6:
    db 3
    frame_oam_tile 0xF0, 0xF8, 0x2201, 0x60
    frame_oam_tile 0, 0xF8, 0x2201, 0x20
    frame_oam_tile 0xF8, 0xE8, 1, 0x20
animation_frame_C64806:
    db 3
    frame_oam_tile 0, 0xF8, 0x2001, 0x60
    frame_oam_tile 0xF0, 0xF8, 0x2001, 0x20
    frame_oam_tile 0xF8, 0xE8, 1, 0x20
animation_frame_C64816:
    db 4
    frame_oam_tile 0xF0, 0xF8, 0x200, 0xE0
    frame_oam_tile 0xF0, 0xE8, 0x200, 0x60
    frame_oam_tile 0, 0xF8, 0x2000, 0x60
    frame_oam_tile 0, 0xE8, 0, 0x60
animation_frame_C6482B:
    db 4
    frame_oam_tile 0xF0, 0xF8, 0x2200, 0xE0
    frame_oam_tile 0xF0, 0xE8, 0x2200, 0x60
    frame_oam_tile 0, 0xF8, 0x2000, 0x60
    frame_oam_tile 0, 0xE8, 0, 0x60
animation_frame_C64840:
    db 4
    frame_oam_tile 0, 0xE8, 0x400, 0x60
    frame_oam_tile 0xF0, 0xE8, 0x400, 0x20
    frame_oam_tile 0, 0xF8, 0x2600, 0x20
    frame_oam_tile 0xF0, 0xF8, 0x2400, 0x20
animation_frame_C64855:
    db 4
    frame_oam_tile 0xF0, 0xE8, 0x600, 0x60
    frame_oam_tile 0, 0xE8, 0x600, 0x20
    frame_oam_tile 0, 0xF8, 0x2600, 0x20
    frame_oam_tile 0xF0, 0xF8, 0x2400, 0x20
animation_frame_C6486A:
    db 4
    frame_oam_tile 0, 0xF8, 0x200, 0xA0
    frame_oam_tile 0, 0xE8, 0x200, 0x20
    frame_oam_tile 0xF0, 0xF8, 0x2000, 0x20
    frame_oam_tile 0xF0, 0xE8, 0, 0x20
animation_frame_C6487F:
    db 4
    frame_oam_tile 0, 0xF8, 0x2200, 0xA0
    frame_oam_tile 0, 0xE8, 0x2200, 0x20
    frame_oam_tile 0xF0, 0xF8, 0x2000, 0x20
    frame_oam_tile 0xF0, 0xE8, 0, 0x20
byte_C64894:
    db 2
    animation_frame animation_frame_C647F6, 2
    animation_frame animation_frame_C64806, 3
byte_C6489D:
    db 2
    animation_frame animation_frame_C64816, 3
    animation_frame animation_frame_C6482B, 2
byte_C648A6:
    db 2
    animation_frame animation_frame_C64840, 2
    animation_frame animation_frame_C64855, 3
byte_C648AF:
    db 2
    animation_frame animation_frame_C6486A, 3
    animation_frame animation_frame_C6487F, 2
animation_frame_C648B8:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0, 0x20
animation_frame_C648BE:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x200, 0x20
animation_frame_C648C4:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2200, 0x20
animation_frame_C648CA:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2000, 0x20
animation_frame_C648D0:
    db 3
    frame_oam_tile 0, 0xF5, 0x100, 0
    frame_oam_tile 0xF8, 0xF5, 0, 0
    frame_oam_tile 0xF8, 0xFD, 0x2600, 0x20
animation_frame_C648E0:
    db 3
    frame_oam_tile 0xF8, 0xFB, 0x2400, 0x20
    frame_oam_tile 0, 0xF3, 0x100, 0
    frame_oam_tile 0xF8, 0xF3, 0, 0
animation_frame_C648F0:
    db 3
    frame_oam_tile 0, 0xF2, 0x100, 0
    frame_oam_tile 0xF8, 0xF2, 0, 0
    frame_oam_tile 0xF8, 0xFA, 0x600, 0x20
animation_frame_C64900:
    db 3
    frame_oam_tile 0xF8, 0xF8, 0x400, 0x20
    frame_oam_tile 0, 0xF0, 0x100, 0
    frame_oam_tile 0xF8, 0xF0, 0, 0
byte_C64910:
    db 9
    animation_frame animation_frame_C648B8, 8
    animation_frame animation_frame_C648BE, 8
    animation_frame animation_frame_C648C4, 8
    animation_frame animation_frame_C648CA, 8
    animation_frame animation_frame_C648B8, 8
    animation_frame animation_frame_C648D0, 3
    animation_frame animation_frame_C648E0, 3
    animation_frame animation_frame_C648F0, 3
    animation_frame animation_frame_C64900, 5
animation_frame_C64935:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0, 0x20
animation_frame_C6493B:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x200, 0x20
animation_frame_C64941:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x400, 0x20
animation_frame_C64947:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x600, 0x20
animation_frame_C6494D:
    db 1
    frame_oam_tile 0xF8, 0xF8, 1, 0x20
animation_frame_C64953:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x201, 0x20
animation_frame_C64959:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x401, 0x20
animation_frame_C6495F:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x601, 0x20
animation_frame_C64965:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2000, 0x20
animation_frame_C6496B:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2200, 0x20
animation_frame_C64971:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2400, 0x20
animation_frame_C64977:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2600, 0x20
animation_frame_C6497D:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2001, 0x20
animation_frame_C64983:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2201, 0x20
animation_frame_C64989:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2401, 0x20
animation_frame_C6498F:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2601, 0x20
animation_frame_C64995:
    db 1
    frame_oam_tile 0xF8, 0xF8, 2, 0x20
animation_frame_C6499B:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x202, 0x20
animation_frame_C649A1:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x402, 0x20
animation_frame_C649A7:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x602, 0x20
animation_frame_C649AD:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2401, 0x60
animation_frame_C649B3:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2601, 0x60
animation_frame_C649B9:
    db 1
    frame_oam_tile 0xF8, 0xF8, 2, 0x60
animation_frame_C649BF:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x202, 0x60
animation_frame_C649C5:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x402, 0x60
animation_frame_C649CB:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x602, 0x60
byte_C649D1:
    db 6
    animation_frame animation_frame_C64971, 0x10
    animation_frame animation_frame_C64977, 2
    animation_frame animation_frame_C6497D, 2
    animation_frame animation_frame_C64983, 2
    animation_frame animation_frame_C6497D, 2
    animation_frame animation_frame_C64977, 2
byte_C649EA:
    db 0xA
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
byte_C64A13:
    db 0x12
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
byte_C64A5C:
    db 0xA
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
animation_frame_C64A85:
    db 3
    frame_oam_tile 0, 0, 0x1100, 0
    frame_oam_tile 0xF8, 0, 0x1000, 0
    frame_oam_tile 0xF8, 0xF0, 0x2000, 0x20
animation_frame_C64A95:
    db 3
    frame_oam_tile 0, 0, 0x300, 0
    frame_oam_tile 0xF8, 0, 0x200, 0
    frame_oam_tile 0xF8, 0xF0, 0x2000, 0x20
    db 3
    db 0, 0, 0, 1, 0
    db 0xF8, 0, 0, 0, 0
    db 0xF8, 0xF0, 0, 0x20, 0x20
animation_frame_C64AB5:
    db 2
    frame_oam_tile 0xF8, 0xFD, 0x400, 0x20
    frame_oam_tile 0xF8, 0xED, 0x2000, 0x20
animation_frame_C64AC0:
    db 2
    frame_oam_tile 0xF8, 0xFB, 0x2600, 0x20
    frame_oam_tile 0xF8, 0xEB, 0x2000, 0x20
animation_frame_C64ACB:
    db 2
    frame_oam_tile 0xF8, 0xFC, 0x600, 0x20
    frame_oam_tile 0xF8, 0xEC, 0x2000, 0x20
animation_frame_C64AD6:
    db 2
    frame_oam_tile 0xF8, 0xF8, 0x2200, 0x20
    frame_oam_tile 0xF8, 0xE8, 0x2000, 0x20
animation_frame_C64AE1:
    db 2
    frame_oam_tile 0xF8, 0xFC, 0x2400, 0x20
    frame_oam_tile 0xF8, 0xEC, 0x2000, 0x20
animation_frame_C64AEC:
    db 3
    frame_oam_tile 0, 0, 0x1300, 0
    frame_oam_tile 0xF8, 0, 0x1200, 0
    frame_oam_tile 0xF8, 0xF0, 0x2000, 0x20
byte_C64AFC:
    db 0xD
    animation_frame animation_frame_C64A85, 0x15
    animation_frame animation_frame_C64A95, 7
    animation_frame animation_frame_C64AB5, 7
    animation_frame animation_frame_C64AC0, 7
    animation_frame animation_frame_C64AB5, 7
    animation_frame animation_frame_C64A95, 7
    animation_frame animation_frame_C64A85, 0x15
    animation_frame animation_frame_C64ACB, 0xA
    animation_frame animation_frame_C64AD6, 0xC
    animation_frame animation_frame_C64ACB, 0xA
    animation_frame animation_frame_C64A85, 0x15
    animation_frame animation_frame_C64AE1, 0xD
    animation_frame animation_frame_C64AEC, 0xC
animation_frame_C64B31:
    db 3
    frame_oam_tile 0, 6, 0x2100, 0
    frame_oam_tile 0xF8, 6, 0x2000, 0
    frame_oam_tile 0xF8, 0xF6, 0, 0x20
animation_frame_C64B41:
    db 3
    frame_oam_tile 0xF8, 0xF5, 0x2600, 0x20
    frame_oam_tile 0, 5, 0x3100, 0
    frame_oam_tile 0xF8, 5, 0x3000, 0
animation_frame_C64B51:
    db 3
    frame_oam_tile 0xF8, 0xF5, 0x2001, 0x20
    frame_oam_tile 0, 5, 0x3100, 0
    frame_oam_tile 0xF8, 5, 0x3000, 0
animation_frame_C64B61:
    db 3
    frame_oam_tile 0xF8, 0xF5, 0x2201, 0x20
    frame_oam_tile 0, 5, 0x3100, 0
    frame_oam_tile 0xF8, 5, 0x3000, 0
animation_frame_C64B71:
    db 3
    frame_oam_tile 0xF8, 0xF5, 0x2401, 0x20
    frame_oam_tile 0, 5, 0x3100, 0
    frame_oam_tile 0xF8, 5, 0x3000, 0
animation_frame_C64B81:
    db 3
    frame_oam_tile 0xF8, 0xF5, 0x2601, 0x20
    frame_oam_tile 0, 5, 0x3100, 0
    frame_oam_tile 0xF8, 5, 0x3000, 0
animation_frame_C64B91:
    db 3
    frame_oam_tile 0xF8, 0xF5, 2, 0x20
    frame_oam_tile 0, 5, 0x3100, 0
    frame_oam_tile 0xF8, 5, 0x3000, 0
animation_frame_C64BA1:
    db 3
    frame_oam_tile 0xF8, 0xF5, 0x202, 0x20
    frame_oam_tile 0, 5, 0x3100, 0
    frame_oam_tile 0xF8, 5, 0x3000, 0
animation_frame_C64BB1:
    db 3
    frame_oam_tile 0xF8, 0xF5, 0x402, 0x20
    frame_oam_tile 0, 5, 0x3100, 0
    frame_oam_tile 0xF8, 5, 0x3000, 0
animation_frame_C64BC1:
    db 3
    frame_oam_tile 0xF8, 0xF6, 0x200, 0x20
    frame_oam_tile 0, 6, 0x2100, 0
    frame_oam_tile 0xF8, 6, 0x2000, 0
animation_frame_C64BD1:
    db 3
    frame_oam_tile 0xF8, 0xF6, 0x400, 0x20
    frame_oam_tile 0, 6, 0x2100, 0
    frame_oam_tile 0xF8, 6, 0x2000, 0
animation_frame_C64BE1:
    db 3
    frame_oam_tile 0xF8, 0xF6, 0x600, 0x20
    frame_oam_tile 0, 6, 0x2100, 0
    frame_oam_tile 0xF8, 6, 0x2000, 0
animation_frame_C64BF1:
    db 3
    frame_oam_tile 0xF8, 0xF6, 1, 0x20
    frame_oam_tile 0, 6, 0x2100, 0
    frame_oam_tile 0xF8, 6, 0x2000, 0
animation_frame_C64C01:
    db 3
    frame_oam_tile 0xF8, 0xF6, 0x201, 0x20
    frame_oam_tile 0, 6, 0x2100, 0
    frame_oam_tile 0xF8, 6, 0x2000, 0
animation_frame_C64C11:
    db 3
    frame_oam_tile 0xF8, 0xF6, 0x401, 0x20
    frame_oam_tile 0, 6, 0x2100, 0
    frame_oam_tile 0xF8, 6, 0x2000, 0
animation_frame_C64C21:
    db 3
    frame_oam_tile 0xF8, 0xF6, 0x601, 0x20
    frame_oam_tile 0, 6, 0x2100, 0
    frame_oam_tile 0xF8, 6, 0x2000, 0
animation_frame_C64C31:
    db 3
    frame_oam_tile 0xF8, 0xF6, 0x2200, 0x20
    frame_oam_tile 0, 6, 0x2100, 0
    frame_oam_tile 0xF8, 6, 0x2000, 0
animation_frame_C64C41:
    db 3
    frame_oam_tile 0xF8, 0xF6, 0x2400, 0x20
    frame_oam_tile 0, 6, 0x2100, 0
    frame_oam_tile 0xF8, 6, 0x2000, 0
byte_C64C51:
    db 9
    animation_frame animation_frame_C64B31, 4
    animation_frame animation_frame_C64BB1, 4
    animation_frame animation_frame_C64BA1, 4
    animation_frame animation_frame_C64B91, 4
    animation_frame animation_frame_C64B81, 4
    animation_frame animation_frame_C64B71, 5
    animation_frame animation_frame_C64B61, 6
    animation_frame animation_frame_C64B51, 7
    animation_frame animation_frame_C64B41, 0xA
byte_C64C76:
    db 0xA
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
byte_C64C9F:
    db 9
    animation_frame animation_frame_C64B31, 4
    animation_frame animation_frame_C64B41, 0xA
    animation_frame animation_frame_C64B51, 7
    animation_frame animation_frame_C64B61, 6
    animation_frame animation_frame_C64B71, 5
    animation_frame animation_frame_C64B81, 4
    animation_frame animation_frame_C64B91, 4
    animation_frame animation_frame_C64BA1, 4
    animation_frame animation_frame_C64BB1, 4
byte_C64CC4:
    db 0xA
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
animation_frame_C64CED:
    db 3
    frame_oam_tile 0, 0, 0x2700, 0
    frame_oam_tile 0xF8, 0, 0x2600, 0
    frame_oam_tile 0xF8, 0xF0, 0x600, 0x20
animation_frame_C64CFD:
    db 3
    frame_oam_tile 0, 0xFF, 0x2101, 0
    frame_oam_tile 0xF8, 0xFF, 0x2001, 0
    frame_oam_tile 0xF8, 0xEF, 1, 0x20
animation_frame_C64D0D:
    db 3
    frame_oam_tile 0, 0xFF, 0x2301, 0
    frame_oam_tile 0xF8, 0xFF, 0x2201, 0
    frame_oam_tile 0xF8, 0xEF, 0x201, 0x20
animation_frame_C64D1D:
    db 3
    frame_oam_tile 0, 0, 0x3101, 0
    frame_oam_tile 0xF8, 0, 0x3001, 0
    frame_oam_tile 0xF8, 0xF0, 0x401, 0x20
animation_frame_C64D2D:
    db 3
    frame_oam_tile 0, 0xFF, 0x3301, 0
    frame_oam_tile 0xF8, 0xFF, 0x3201, 0
    frame_oam_tile 0xF8, 0xEF, 0x601, 0x20
animation_frame_C64D3D:
    db 3
    frame_oam_tile 0xF8, 0xFF, 0x3000, 0
    frame_oam_tile 0, 0xFF, 0x3100, 0
    frame_oam_tile 0xF8, 0xEF, 2, 0x20
animation_frame_C64D4D:
    db 3
    frame_oam_tile 0xF8, 0xFF, 0x2200, 0
    frame_oam_tile 0, 0xFF, 0x2300, 0
    frame_oam_tile 0xF8, 0xEF, 0x200, 0x20
animation_frame_C64D5D:
    db 3
    frame_oam_tile 0, 0, 0x2100, 0
    frame_oam_tile 0xF8, 0, 0x2000, 0
    frame_oam_tile 0xF8, 0xF0, 0, 0x20
animation_frame_C64D6D:
    db 3
    frame_oam_tile 0, 0xFF, 0x2500, 0
    frame_oam_tile 0xF8, 0xFF, 0x2400, 0
    frame_oam_tile 0xF8, 0xEF, 0x400, 0x20
animation_frame_C64D7D:
    db 3
    frame_oam_tile 0xF8, 0, 0x3200, 0
    frame_oam_tile 0, 0, 0x3300, 0
    frame_oam_tile 0xF8, 0xF0, 0x202, 0x20
animation_frame_C64D8D:
    db 3
    frame_oam_tile 0xF8, 0xFF, 0x3400, 0
    frame_oam_tile 0, 0xFF, 0x3500, 0
    frame_oam_tile 0xF8, 0xEF, 0x402, 0x20
animation_frame_C64D9D:
    db 3
    frame_oam_tile 0xF8, 0xFF, 0x3600, 0
    frame_oam_tile 0, 0xFF, 0x3700, 0
    frame_oam_tile 0xF8, 0xEF, 0x602, 0x20
animation_frame_C64DAD:
    db 3
    frame_oam_tile 0, 0, 0x3300, 0
    frame_oam_tile 0xF8, 0, 0x3200, 0
    frame_oam_tile 0xF8, 0xF0, 0x2002, 0x20
animation_frame_C64DBD:
    db 3
    frame_oam_tile 0, 0xFF, 0x3500, 0
    frame_oam_tile 0xF8, 0xFF, 0x3400, 0
    frame_oam_tile 0xF8, 0xEF, 0x2401, 0x20
animation_frame_C64DCD:
    db 3
    frame_oam_tile 0, 0xFF, 0x3700, 0
    frame_oam_tile 0xF8, 0xFF, 0x3600, 0
    frame_oam_tile 0xF8, 0xEF, 0x2601, 0x20
animation_frame_C64DDD:
    db 3
    frame_oam_tile 0, 0, 0x3200, 0x40
    frame_oam_tile 0xF8, 0, 0x3300, 0x40
    frame_oam_tile 0xF8, 0xF0, 0x202, 0x60
animation_frame_C64DED:
    db 3
    frame_oam_tile 0, 0, 0x3200, 0x40
    frame_oam_tile 0xF8, 0, 0x3300, 0x40
    frame_oam_tile 0xF8, 0xF0, 0x2002, 0x60
animation_frame_C64DFD:
    db 3
    frame_oam_tile 0, 0xFF, 0x3400, 0x40
    frame_oam_tile 0xF8, 0xFF, 0x3500, 0x40
    frame_oam_tile 0xF8, 0xEF, 0x402, 0x60
animation_frame_C64E0D:
    db 3
    frame_oam_tile 0, 0xFF, 0x3400, 0x40
    frame_oam_tile 0xF8, 0xFF, 0x3500, 0x40
    frame_oam_tile 0xF8, 0xEF, 0x2401, 0x60
animation_frame_C64E1D:
    db 3
    frame_oam_tile 0, 0xFF, 0x3600, 0x40
    frame_oam_tile 0xF8, 0xFF, 0x3700, 0x40
    frame_oam_tile 0xF8, 0xEF, 0x602, 0x60
animation_frame_C64E2D:
    db 3
    frame_oam_tile 0, 0xFF, 0x3600, 0x40
    frame_oam_tile 0xF8, 0xFF, 0x3700, 0x40
    frame_oam_tile 0xF8, 0xEF, 0x2601, 0x60
byte_C64E3D:
    db 4
    animation_frame animation_frame_C64D1D, 0xE
    animation_frame animation_frame_C64D2D, 0xE
    animation_frame animation_frame_C64D1D, 0xE
    animation_frame animation_frame_C64D3D, 0xE
byte_C64E4E:
    db 8
    animation_frame animation_frame_C64D7D, 7
    animation_frame animation_frame_C64DAD, 7
    animation_frame animation_frame_C64D8D, 7
    animation_frame animation_frame_C64DBD, 7
    animation_frame animation_frame_C64D7D, 7
    animation_frame animation_frame_C64DAD, 7
    animation_frame animation_frame_C64D9D, 7
    animation_frame animation_frame_C64DCD, 7
byte_C64E6F:
    db 8
    animation_frame animation_frame_C64D5D, 7
    animation_frame animation_frame_C64CED, 7
    animation_frame animation_frame_C64D4D, 7
    animation_frame animation_frame_C64CFD, 7
    animation_frame animation_frame_C64D5D, 7
    animation_frame animation_frame_C64CED, 7
    animation_frame animation_frame_C64D6D, 7
    animation_frame animation_frame_C64D0D, 7
byte_C64E90:
    db 8
    animation_frame animation_frame_C64DDD, 7
    animation_frame animation_frame_C64DED, 7
    animation_frame animation_frame_C64DFD, 7
    animation_frame animation_frame_C64E0D, 7
    animation_frame animation_frame_C64DDD, 7
    animation_frame animation_frame_C64DED, 7
    animation_frame animation_frame_C64E1D, 7
    animation_frame animation_frame_C64E2D, 7
animation_frame_C64EB1:
    db 3
    frame_oam_tile 0, 0, 0x2301, 0
    frame_oam_tile 0xF8, 0, 0x2201, 0
    frame_oam_tile 0xF8, 0xF0, 0x201, 0x20
animation_frame_C64EC1:
    db 3
    frame_oam_tile 0xF8, 0xEF, 1, 0x20
    frame_oam_tile 0, 0xFF, 0x2101, 0
    frame_oam_tile 0xF8, 0xFF, 0x2001, 0
animation_frame_C64ED1:
    db 3
    frame_oam_tile 0xF8, 0xEF, 0x600, 0x20
    frame_oam_tile 0xF8, 0xFF, 0x2600, 0
    frame_oam_tile 0, 0xFF, 0x2700, 0
animation_frame_C64EE1:
    db 3
    frame_oam_tile 0xF8, 0xFF, 0x2501, 0x40
    frame_oam_tile 0, 0xFF, 0x2401, 0x40
    frame_oam_tile 0xF8, 0xEF, 0x401, 0x60
animation_frame_C64EF1:
    db 3
    frame_oam_tile 0xF8, 0xEF, 0x601, 0x60
    frame_oam_tile 0, 0xFF, 0x2601, 0x40
    frame_oam_tile 0xF8, 0xFF, 0x2701, 0x40
animation_frame_C64F01:
    db 3
    frame_oam_tile 0xF8, 0, 0x2102, 0x40
    frame_oam_tile 0, 0, 0x2002, 0x40
    frame_oam_tile 0xF8, 0xF0, 2, 0x60
animation_frame_C64F11:
    db 3
    frame_oam_tile 0xF8, 0xF0, 0x400, 0x20
    frame_oam_tile 0, 0, 0x2500, 0
    frame_oam_tile 0xF8, 0, 0x2400, 0
animation_frame_C64F21:
    db 3
    frame_oam_tile 0, 0xFF, 0x2300, 0
    frame_oam_tile 0xF8, 0xFF, 0x2200, 0
    frame_oam_tile 0xF8, 0xEF, 0x200, 0x20
animation_frame_C64F31:
    db 3
    frame_oam_tile 0xF8, 0xEF, 0, 0x20
    frame_oam_tile 0, 0xFF, 0x2100, 0
    frame_oam_tile 0xF8, 0xFF, 0x2000, 0
animation_frame_C64F41:
    db 3
    frame_oam_tile 0xF8, 0xF0, 2, 0x20
    frame_oam_tile 0, 0, 0x2102, 0
    frame_oam_tile 0xF8, 0, 0x2002, 0
animation_frame_C64F51:
    db 3
    frame_oam_tile 0xF8, 0xEF, 0x601, 0x20
    frame_oam_tile 0, 0xFF, 0x2701, 0
    frame_oam_tile 0xF8, 0xFF, 0x2601, 0
animation_frame_C64F61:
    db 3
    frame_oam_tile 0xF8, 0xEF, 0x401, 0x20
    frame_oam_tile 0, 0xFF, 0x2501, 0
    frame_oam_tile 0xF8, 0xFF, 0x2401, 0
animation_frame_C64F71:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x202, 0x20
animation_frame_C64F77:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x402, 0x20
animation_frame_C64F7D:
    db 3
    frame_oam_tile 0, 0xF8, 0x3300, 0
    frame_oam_tile 0, 0, 0x3700, 0
    frame_oam_tile 0xF8, 0, 0x3600, 0
animation_frame_C64F8D:
    db 3
    frame_oam_tile 0xF8, 0xF8, 0x3400, 0
    frame_oam_tile 0, 0, 0x3101, 0
    frame_oam_tile 0xF8, 0, 0x3001, 0
animation_frame_C64F9D:
    db 2
    frame_oam_tile 0, 0, 0x3301, 0
    frame_oam_tile 0xF8, 0, 0x3201, 0
animation_frame_C64FA8:
    db 2
    frame_oam_tile 0, 0, 0x3501, 0
    frame_oam_tile 0xF8, 0, 0x3401, 0
animation_frame_C64FB3:
    db 2
    frame_oam_tile 0, 0, 0x3701, 0
    frame_oam_tile 0xF8, 0, 0x3601, 0
animation_frame_C64FBE:
    db 2
    frame_oam_tile 0, 0, 0x3102, 0
    frame_oam_tile 0xF8, 0, 0x3002, 0
animation_frame_C64FC9:
    db 2
    frame_oam_tile 0, 0, 0x3100, 0
    frame_oam_tile 0xF8, 0, 0x3000, 0
animation_frame_C64FD4:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x602, 0x20
animation_frame_C64FDA:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2402, 0x20
animation_frame_C64FE0:
    db 3
    frame_oam_tile 0, 0, 0x3100, 0
    frame_oam_tile 0xF8, 0, 0x3000, 0
    frame_oam_tile 0xF8, 0xF0, 0x2602, 0x20
animation_frame_C64FF0:
    db 3
    frame_oam_tile 0, 0, 0x3100, 0
    frame_oam_tile 0xF8, 0, 0x3000, 0
    frame_oam_tile 0xF8, 0xEE, 0x2602, 0x20
animation_frame_C65000:
    db 3
    frame_oam_tile 0, 0, 0x3100, 0
    frame_oam_tile 0xF8, 0, 0x3000, 0
    frame_oam_tile 0xF8, 0xEB, 0x2602, 0x20
animation_frame_C65010:
    db 1
    frame_oam_tile 0xF8, 0xF6, 0x2202, 0x20
byte_C65016:
    db 4
    animation_frame animation_frame_C64EB1, 9
    animation_frame animation_frame_C64EC1, 0x10
    animation_frame animation_frame_C64EB1, 9
    animation_frame animation_frame_C64ED1, 0x10
byte_C65027:
    db 4
    animation_frame animation_frame_C64F01, 9
    animation_frame animation_frame_C64EE1, 0x10
    animation_frame animation_frame_C64F01, 9
    animation_frame animation_frame_C64EF1, 0x10
byte_C65038:
    db 4
    animation_frame animation_frame_C64F11, 9
    animation_frame animation_frame_C64F21, 0x10
    animation_frame animation_frame_C64F11, 9
    animation_frame animation_frame_C64F31, 0x10
byte_C65049:
    db 4
    animation_frame animation_frame_C64F41, 9
    animation_frame animation_frame_C64F51, 0x10
    animation_frame animation_frame_C64F41, 9
    animation_frame animation_frame_C64F61, 0x10
byte_C6505A:
    db 0xB
    animation_frame animation_frame_C64F11, 0x20
    animation_frame animation_frame_C65010, 8
    animation_frame animation_frame_C64F71, 7
    animation_frame animation_frame_C64F77, 7
    animation_frame animation_frame_C64F7D, 7
    animation_frame animation_frame_C64F8D, 6
    animation_frame animation_frame_C64F9D, 5
    animation_frame animation_frame_C64FA8, 5
    animation_frame animation_frame_C64FB3, 5
    animation_frame animation_frame_C64FBE, 5
    animation_frame animation_frame_C64FC9, 0x30
byte_C65087:
    db 0xA
    animation_frame animation_frame_C64FC9, 0x20
    animation_frame animation_frame_C64FD4, 8
    animation_frame animation_frame_C64FDA, 6
    animation_frame animation_frame_C64FE0, 4
    animation_frame animation_frame_C64FF0, 4
    animation_frame animation_frame_C65000, 0xC
    animation_frame animation_frame_C64FF0, 5
    animation_frame animation_frame_C64FE0, 4
    animation_frame animation_frame_C65010, 0x10
    animation_frame animation_frame_C64F11, 0x20
animation_frame_C650B0:
    db 3
    frame_oam_tile 0, 0, 0x701, 0
    frame_oam_tile 0xF8, 0, 0x601, 0
    frame_oam_tile 0xF8, 0xF0, 0x2200, 0x20
animation_frame_C650C0:
    db 3
    frame_oam_tile 0, 0, 0x701, 0
    frame_oam_tile 0xF8, 0, 0x601, 0
    frame_oam_tile 0xF8, 0xF0, 0x2000, 0x20
animation_frame_C650D0:
    db 2
    frame_oam_tile 0xFC, 0, 0x1601, 0
    frame_oam_tile 0xF8, 0xEF, 0x2200, 0x20
animation_frame_C650DB:
    db 2
    frame_oam_tile 0xFC, 0, 0x1601, 0
    frame_oam_tile 0xF8, 0xEF, 0x2000, 0x20
animation_frame_C650E6:
    db 2
    frame_oam_tile 0xFC, 0, 0x1701, 0
    frame_oam_tile 0xF8, 0xEE, 0x2200, 0x20
animation_frame_C650F1:
    db 2
    frame_oam_tile 0xFC, 0, 0x1701, 0
    frame_oam_tile 0xF8, 0xEE, 0x2000, 0x20
animation_frame_C650FC:
    db 3
    frame_oam_tile 0, 0, 0x701, 0
    frame_oam_tile 0xF8, 0, 0x601, 0
    frame_oam_tile 0xF8, 0xF0, 0x600, 0x60
animation_frame_C6510C:
    db 3
    frame_oam_tile 0, 0, 0x701, 0
    frame_oam_tile 0xF8, 0, 0x601, 0
    frame_oam_tile 0xF8, 0xF0, 1, 0x60
animation_frame_C6511C:
    db 2
    frame_oam_tile 0xFC, 0, 0x1601, 0
    frame_oam_tile 0xF8, 0xEF, 0x600, 0x60
animation_frame_C65127:
    db 2
    frame_oam_tile 0xFC, 0, 0x1601, 0
    frame_oam_tile 0xF8, 0xEF, 1, 0x60
animation_frame_C65132:
    db 2
    frame_oam_tile 0xFC, 0, 0x1701, 0
    frame_oam_tile 0xF8, 0xEE, 0x600, 0x60
animation_frame_C6513D:
    db 2
    frame_oam_tile 0xFC, 0, 0x1701, 0
    frame_oam_tile 0xF8, 0xEE, 1, 0x60
animation_frame_C65148:
    db 3
    frame_oam_tile 0, 0, 0x701, 0
    frame_oam_tile 0xF8, 0, 0x601, 0
    frame_oam_tile 0xF8, 0xF0, 0x201, 0x20
animation_frame_C65158:
    db 3
    frame_oam_tile 0, 0, 0x701, 0
    frame_oam_tile 0xF8, 0, 0x601, 0
    frame_oam_tile 0xF8, 0xF0, 0x401, 0x20
animation_frame_C65168:
    db 2
    frame_oam_tile 0xFC, 0, 0x1601, 0
    frame_oam_tile 0xF8, 0xEF, 0x201, 0x20
animation_frame_C65173:
    db 2
    frame_oam_tile 0xFC, 0, 0x1601, 0
    frame_oam_tile 0xF8, 0xEF, 0x401, 0x20
animation_frame_C6517E:
    db 2
    frame_oam_tile 0xFC, 0, 0x1701, 0
    frame_oam_tile 0xF8, 0xEE, 0x201, 0x20
animation_frame_C65189:
    db 2
    frame_oam_tile 0xFC, 0, 0x1701, 0
    frame_oam_tile 0xF8, 0xEE, 0x401, 0x20
animation_frame_C65194:
    db 3
    frame_oam_tile 0, 0, 0x701, 0
    frame_oam_tile 0xF8, 0, 0x601, 0
    frame_oam_tile 0xF8, 0xF0, 0x600, 0x20
animation_frame_C651A4:
    db 3
    frame_oam_tile 0, 0, 0x701, 0
    frame_oam_tile 0xF8, 0, 0x601, 0
    frame_oam_tile 0xF8, 0xF0, 1, 0x20
animation_frame_C651B4:
    db 2
    frame_oam_tile 0xFC, 0, 0x1601, 0
    frame_oam_tile 0xF8, 0xEF, 0x600, 0x20
animation_frame_C651BF:
    db 2
    frame_oam_tile 0xFC, 0, 0x1601, 0
    frame_oam_tile 0xF8, 0xEF, 1, 0x20
animation_frame_C651CA:
    db 2
    frame_oam_tile 0xFC, 0, 0x1701, 0
    frame_oam_tile 0xF8, 0xEE, 0x600, 0x20
animation_frame_C651D5:
    db 2
    frame_oam_tile 0xFC, 0, 0x1701, 0
    frame_oam_tile 0xF8, 0xEE, 1, 0x20
animation_frame_C651E0:
    db 3
    frame_oam_tile 0, 0, 0x701, 0
    frame_oam_tile 0xF8, 0, 0x601, 0
    frame_oam_tile 0xF8, 0xF0, 0x200, 0x20
animation_frame_C651F0:
    db 3
    frame_oam_tile 0, 0, 0x701, 0
    frame_oam_tile 0xF8, 0, 0x601, 0
    frame_oam_tile 0xF8, 0xF2, 0x200, 0x20
animation_frame_C65200:
    db 3
    frame_oam_tile 0, 0, 0x701, 0
    frame_oam_tile 0xF8, 0, 0x601, 0
    frame_oam_tile 0xF8, 0xF4, 0x200, 0x20
animation_frame_C65210:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x200, 0x20
animation_frame_C65216:
    db 3
    frame_oam_tile 0xF8, 0xF0, 0x400, 0x20
    frame_oam_tile 0, 0, 0x701, 0
    frame_oam_tile 0xF8, 0, 0x601, 0
animation_frame_C65226:
    db 3
    frame_oam_tile 0xF8, 0xF0, 0, 0x20
    frame_oam_tile 0, 0, 0x701, 0
    frame_oam_tile 0xF8, 0, 0x601, 0
byte_C65236:
    db 0xA
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
byte_C6525F:
    db 0xB
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
byte_C6528C:
    db 0xB
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
byte_C652B9:
    db 0xB
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
byte_C652E6:
    db 0xA    ; Wrong count!
    animation_frame animation_frame_C651E0, 0x10
stru_C652EB:
    animation_frame animation_frame_C65216, 0xD
    animation_frame animation_frame_C651E0, 0xB
    animation_frame animation_frame_C65226, 0xD
    animation_frame animation_frame_C651E0, 0xB
    animation_frame animation_frame_C65216, 0xD
    animation_frame animation_frame_C651E0, 0x10
    animation_frame animation_frame_C651F0, 3
    animation_frame animation_frame_C65200, 2
    animation_frame animation_frame_C65210, 0x20
byte_C6530F:
    db 0xA
    animation_frame animation_frame_C65210, 0x20
    animation_frame animation_frame_C65200, 2
    animation_frame animation_frame_C651F0, 3
    animation_frame animation_frame_C651E0, 0x10
    animation_frame animation_frame_C65216, 0xD
    animation_frame animation_frame_C651E0, 0xB
    animation_frame animation_frame_C65226, 0xD
    animation_frame animation_frame_C651E0, 0xB
    animation_frame animation_frame_C65216, 0xD
    animation_frame animation_frame_C651E0, 0x10
animation_frame_C65338:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0, 0x20
animation_frame_C6533E:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x200, 0x20
animation_frame_C65344:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x400, 0x20
animation_frame_C6534A:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x600, 0x20
animation_frame_C65350:
    db 1
    frame_oam_tile 0xF8, 0xF8, 1, 0x20
animation_frame_C65356:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x201, 0x20
animation_frame_C6535C:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x401, 0x20
animation_frame_C65362:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x601, 0x20
animation_frame_C65368:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2000, 0x20
animation_frame_C6536E:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2200, 0x20
animation_frame_C65374:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2400, 0x20
animation_frame_C6537A:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2600, 0x20
animation_frame_C65380:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2001, 0x20
animation_frame_C65386:
    db 1
    frame_oam_tile 0xFC, 0xFD, 0x2201, 0
animation_frame_C6538C:
    db 1
    frame_oam_tile 0xFC, 0xFD, 0x2301, 0
animation_frame_C65392:
    db 1
    frame_oam_tile 0xFC, 0xFD, 0x2401, 0
animation_frame_C65398:
    db 1
    frame_oam_tile 0xFC, 0xFD, 0x2501, 0
animation_frame_C6539E:
    db 1
    frame_oam_tile 0xFC, 0xFD, 0x2601, 0
animation_frame_C653A4:
    db 1
    frame_oam_tile 0xFC, 0xFD, 0x2701, 0
animation_frame_C653AA:
    db 1
    frame_oam_tile 0xFC, 0xFD, 0x3201, 0
animation_frame_C653B0:
    db 1
    frame_oam_tile 0xFC, 0xFD, 0x3301, 0
animation_frame_C653B6:
    db 1
    frame_oam_tile 0xFC, 0xFD, 0x3401, 0
animation_frame_C653BC:
    db 1
    frame_oam_tile 0xFC, 0xFD, 0x3501, 0
animation_frame_C653C2:
    db 1
    frame_oam_tile 0xFC, 0xFD, 0x3601, 0
animation_frame_C653C8:
    db 1
    frame_oam_tile 0xFC, 0xFD, 0x3701, 0
byte_C653CE:
    db 2
    animation_frame animation_frame_C65338, 0x18
    animation_frame animation_frame_C6533E, 0x18
byte_C653D7:
    db 0xC
    animation_frame animation_frame_C65344, 0x20
    animation_frame animation_frame_C6534A, 0x20
    animation_frame animation_frame_C65350, 0x20
    animation_frame animation_frame_C65356, 0x30
    animation_frame animation_frame_C6535C, 5
    animation_frame animation_frame_C65362, 5
    animation_frame animation_frame_C65368, 5
    animation_frame animation_frame_C6536E, 5
    animation_frame animation_frame_C65374, 5
    animation_frame animation_frame_C6537A, 5
    animation_frame animation_frame_C65380, 5
    animation_frame animation_frame_C65386, 5
byte_C65408:
    db 0x10
    animation_frame animation_frame_C65386, 0x30
    animation_frame animation_frame_C6538C, 4
    animation_frame animation_frame_C65392, 0x20
    animation_frame animation_frame_C6538C, 4
    animation_frame animation_frame_C65386, 4
    animation_frame animation_frame_C65398, 4
    animation_frame animation_frame_C6539E, 0x20
    animation_frame animation_frame_C65398, 4
    animation_frame animation_frame_C65386, 0x20
    animation_frame animation_frame_C653A4, 4
    animation_frame animation_frame_C653AA, 4
    animation_frame animation_frame_C653B0, 4
    animation_frame animation_frame_C653B6, 4
    animation_frame animation_frame_C653BC, 4
    animation_frame animation_frame_C653C2, 4
    animation_frame animation_frame_C653C8, 4
byte_C65449:
    db 0xD
    animation_frame animation_frame_C65386, 5
    animation_frame animation_frame_C65380, 5
    animation_frame animation_frame_C65380, 5
    animation_frame animation_frame_C6537A, 5
    animation_frame animation_frame_C65374, 5
    animation_frame animation_frame_C6536E, 5
    animation_frame animation_frame_C65368, 5
    animation_frame animation_frame_C65362, 5
    animation_frame animation_frame_C6535C, 5
    animation_frame animation_frame_C65356, 0x30
    animation_frame animation_frame_C65350, 0x20
    animation_frame animation_frame_C6534A, 0x20
    animation_frame animation_frame_C65344, 0x20
animation_frame_C6547E:
    db 2
    frame_oam_tile 0xF8, 0xFC, 1, 0x20
    frame_oam_tile 0xF8, 0xEC, 0, 0x20
animation_frame_C65489:
    db 2
    frame_oam_tile 0xF8, 0xFC, 0x2001, 0x20
    frame_oam_tile 0xF8, 0xEC, 0x200, 0x20
animation_frame_C65494:
    db 2
    frame_oam_tile 0xF8, 0xFC, 1, 0x20
    frame_oam_tile 0xF8, 0xEC, 0x400, 0x20
animation_frame_C6549F:
    db 2
    frame_oam_tile 0xF8, 0xFC, 0x2001, 0x20
    frame_oam_tile 0xF8, 0xEC, 0x600, 0x20
animation_frame_C654AA:
    db 2
    frame_oam_tile 0xF8, 0xFC, 1, 0x20
    frame_oam_tile 0xF8, 0xEC, 0x2000, 0x20
animation_frame_C654B5:
    db 2
    frame_oam_tile 0xF8, 0xFC, 0x2001, 0x20
    frame_oam_tile 0xF8, 0xEC, 0x2600, 0x20
animation_frame_C654C0:
    db 2
    frame_oam_tile 0xF8, 0xFC, 1, 0x20
    frame_oam_tile 0xF8, 0xEC, 0x2400, 0x20
animation_frame_C654CB:
    db 2
    frame_oam_tile 0xF8, 0xFC, 0x2001, 0x20
    frame_oam_tile 0xF8, 0xEC, 0x2200, 0x20
byte_C654D6:
    db 8
    animation_frame animation_frame_C6547E, 9
    animation_frame animation_frame_C65489, 9
    animation_frame animation_frame_C65494, 9
    animation_frame animation_frame_C6549F, 9
    animation_frame animation_frame_C654AA, 9
    animation_frame animation_frame_C654B5, 9
    animation_frame animation_frame_C654C0, 9
    animation_frame animation_frame_C654CB, 9
animation_frame_C654F7:
    db 3
    frame_oam_tile 0xF8, 0xF7, 0x2200, 0x20
    frame_oam_tile 0, 0xEF, 0x300, 0
    frame_oam_tile 0xF8, 0xEF, 0x200, 0
animation_frame_C65507:
    db 3
    frame_oam_tile 0xF8, 0xF8, 0x2200, 0x20
    frame_oam_tile 0, 0xF0, 0x1300, 0
    frame_oam_tile 0xF8, 0xF0, 0x1200, 0
animation_frame_C65517:
    db 3
    frame_oam_tile 0xF8, 0xF8, 0x2200, 0x20
    frame_oam_tile 0, 0xF0, 0x500, 0
    frame_oam_tile 0xF8, 0xF0, 0x400, 0
animation_frame_C65527:
    db 3
    frame_oam_tile 0xF8, 0xF8, 0x2200, 0x20
    frame_oam_tile 0, 0xF0, 0x1500, 0
    frame_oam_tile 0xF8, 0xF0, 0x1400, 0
animation_frame_C65537:
    db 3
    frame_oam_tile 0xF8, 0xF8, 0x2200, 0x20
    frame_oam_tile 0, 0xF0, 0x700, 0
    frame_oam_tile 0xF8, 0xF0, 0x600, 0
animation_frame_C65547:
    db 3
    frame_oam_tile 0xF8, 0xF8, 0x2200, 0x20
    frame_oam_tile 0, 0xF0, 0x1700, 0
    frame_oam_tile 0xF8, 0xF0, 0x1600, 0
animation_frame_C65557:
    db 3
    frame_oam_tile 0xF8, 0xF7, 0x2200, 0x20
    frame_oam_tile 0, 0xEF, 0x101, 0
    frame_oam_tile 0xF8, 0xEF, 1, 0
animation_frame_C65567:
    db 3
    frame_oam_tile 0xF8, 0xF6, 0x2200, 0x20
    frame_oam_tile 0, 0xEE, 0x1101, 0
    frame_oam_tile 0xF8, 0xEE, 0x1001, 0
animation_frame_C65577:
    db 3
    frame_oam_tile 0xF8, 0xF6, 0x2200, 0x20
    frame_oam_tile 0, 0xEE, 0x2100, 0
    frame_oam_tile 0xF8, 0xEE, 0x2000, 0
animation_frame_C65587:
    db 3
    frame_oam_tile 0xF8, 0xFE, 0x3100, 0x40
    frame_oam_tile 0, 0xFE, 0x3200, 0x40
    frame_oam_tile 0xF8, 0xEE, 0x2400, 0x60
animation_frame_C65597:
    db 3
    frame_oam_tile 0xF8, 0xFF, 0x3100, 0x40
    frame_oam_tile 0, 0xFF, 0x3200, 0x40
    frame_oam_tile 0xF8, 0xEF, 0x2600, 0x60
animation_frame_C655A7:
    db 3
    frame_oam_tile 0xF8, 0xF0, 0x2001, 0x60
    frame_oam_tile 0xF8, 0, 0x3100, 0x40
    frame_oam_tile 0, 0, 0x3200, 0x40
animation_frame_C655B7:
    db 3
    frame_oam_tile 0xF8, 0xF0, 0x2201, 0x60
    frame_oam_tile 0xF8, 0, 0x3100, 0x40
    frame_oam_tile 0, 0, 0x3200, 0x40
animation_frame_C655C7:
    db 3
    frame_oam_tile 0xF8, 0xEF, 0x2401, 0x60
    frame_oam_tile 0xF8, 0xFF, 0x3100, 0x40
    frame_oam_tile 0, 0xFF, 0x3200, 0x40
animation_frame_C655D7:
    db 3
    frame_oam_tile 0xF8, 0xEE, 0x2601, 0x60
    frame_oam_tile 0xF8, 0xFE, 0x3100, 0x40
    frame_oam_tile 0, 0xFE, 0x3200, 0x40
animation_frame_C655E7:
    db 3
    frame_oam_tile 0xF8, 0xEE, 2, 0x60
    frame_oam_tile 0xF8, 0xFE, 0x3100, 0x40
    frame_oam_tile 0, 0xFE, 0x3200, 0x40
animation_frame_C655F7:
    db 3
    frame_oam_tile 0, 0xEF, 0x300, 0
    frame_oam_tile 0xF8, 0xEF, 0x200, 0
    frame_oam_tile 0xF8, 0xF7, 0, 0x20
animation_frame_C65607:
    db 3
    frame_oam_tile 0xF8, 0xF8, 0, 0x20
    frame_oam_tile 0, 0xF0, 0x1300, 0
    frame_oam_tile 0xF8, 0xF0, 0x1200, 0
animation_frame_C65617:
    db 3
    frame_oam_tile 0xF8, 0xF8, 0, 0x20
    frame_oam_tile 0, 0xF0, 0x500, 0
    frame_oam_tile 0xF8, 0xF0, 0x400, 0
animation_frame_C65627:
    db 3
    frame_oam_tile 0xF8, 0xF8, 0, 0x20
    frame_oam_tile 0, 0xF0, 0x1500, 0
    frame_oam_tile 0xF8, 0xF0, 0x1400, 0
animation_frame_C65637:
    db 3
    frame_oam_tile 0xF8, 0xF8, 0, 0x20
    frame_oam_tile 0, 0xF0, 0x700, 0
    frame_oam_tile 0xF8, 0xF0, 0x600, 0
animation_frame_C65647:
    db 3
    frame_oam_tile 0xF8, 0xF8, 0, 0x20
    frame_oam_tile 0, 0xF0, 0x1700, 0
    frame_oam_tile 0xF8, 0xF0, 0x1600, 0
animation_frame_C65657:
    db 3
    frame_oam_tile 0xF8, 0xF7, 0, 0x20
    frame_oam_tile 0, 0xEF, 0x101, 0
    frame_oam_tile 0xF8, 0xEF, 1, 0
animation_frame_C65667:
    db 3
    frame_oam_tile 0xF8, 0xF6, 0, 0x20
    frame_oam_tile 0, 0xEE, 0x1101, 0
    frame_oam_tile 0xF8, 0xEE, 0x1001, 0
animation_frame_C65677:
    db 3
    frame_oam_tile 0xF8, 0xF6, 0, 0x20
    frame_oam_tile 0, 0xEE, 0x2100, 0
    frame_oam_tile 0xF8, 0xEE, 0x2000, 0
animation_frame_C65687:
    db 3
    frame_oam_tile 0, 0xFE, 0x3100, 0
    frame_oam_tile 0xF8, 0xFE, 0x3000, 0
    frame_oam_tile 0xF8, 0xEE, 0x2400, 0x20
animation_frame_C65697:
    db 3
    frame_oam_tile 0, 0xFF, 0x3100, 0
    frame_oam_tile 0xF8, 0xFF, 0x3000, 0
    frame_oam_tile 0xF8, 0xEF, 0x2600, 0x20
animation_frame_C656A7:
    db 3
    frame_oam_tile 0, 0, 0x3100, 0
    frame_oam_tile 0xF8, 0, 0x3000, 0
    frame_oam_tile 0xF8, 0xF0, 0x2001, 0x20
animation_frame_C656B7:
    db 3
    frame_oam_tile 0xF8, 0xF0, 0x2201, 0x20
    frame_oam_tile 0, 0, 0x3100, 0
    frame_oam_tile 0xF8, 0, 0x3000, 0
animation_frame_C656C7:
    db 3
    frame_oam_tile 0xF8, 0xEF, 0x2401, 0x20
    frame_oam_tile 0, 0xFF, 0x3100, 0
    frame_oam_tile 0xF8, 0xFF, 0x3000, 0
animation_frame_C656D7:
    db 3
    frame_oam_tile 0xF8, 0xEE, 0x2601, 0x20
    frame_oam_tile 0, 0xFE, 0x3100, 0
    frame_oam_tile 0xF8, 0xFE, 0x3000, 0
animation_frame_C656E7:
    db 3
    frame_oam_tile 0xF8, 0xEE, 2, 0x20
    frame_oam_tile 0, 0xFE, 0x3100, 0
    frame_oam_tile 0xF8, 0xFE, 0x3000, 0
byte_C656F7:
    db 9
    animation_frame animation_frame_C654F7, 4
    animation_frame animation_frame_C65507, 4
    animation_frame animation_frame_C65517, 4
    animation_frame animation_frame_C65527, 5
    animation_frame animation_frame_C65537, 3
    animation_frame animation_frame_C65547, 3
    animation_frame animation_frame_C65557, 3
    animation_frame animation_frame_C65567, 3
    animation_frame animation_frame_C65577, 4
byte_C6571C:
    db 7
    animation_frame animation_frame_C65587, 6
    animation_frame animation_frame_C65597, 5
    animation_frame animation_frame_C655A7, 5
    animation_frame animation_frame_C655B7, 6
    animation_frame animation_frame_C655C7, 4
    animation_frame animation_frame_C655D7, 4
    animation_frame animation_frame_C655E7, 4
byte_C65739:
    db 9
    animation_frame animation_frame_C655F7, 4
    animation_frame animation_frame_C65607, 4
    animation_frame animation_frame_C65617, 5
    animation_frame animation_frame_C65627, 3
    animation_frame animation_frame_C65637, 3
    animation_frame animation_frame_C65647, 3
    animation_frame animation_frame_C65657, 3
    animation_frame animation_frame_C65667, 3
    animation_frame animation_frame_C65677, 4
byte_C6575E:
    db 7
    animation_frame animation_frame_C65687, 6
    animation_frame animation_frame_C65697, 5
    animation_frame animation_frame_C656A7, 5
    animation_frame animation_frame_C656B7, 6
    animation_frame animation_frame_C656C7, 4
    animation_frame animation_frame_C656D7, 4
    animation_frame animation_frame_C656E7, 4
animation_frame_C6577B:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2000, 0x60
animation_frame_C65781:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2200, 0x60
animation_frame_C65787:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2400, 0x60
animation_frame_C6578D:
    db 1
    frame_oam_tile 0xF7, 0xF8, 0x2600, 0x60
animation_frame_C65793:
    db 1
    frame_oam_tile 0xF8, 0xF8, 1, 0x60
animation_frame_C65799:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x201, 0x20
animation_frame_C6579F:
    db 1
    frame_oam_tile 0xF8, 0xF8, 1, 0x20
animation_frame_C657A5:
    db 1
    frame_oam_tile 0xF9, 0xF8, 0x600, 0x20
animation_frame_C657AB:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x400, 0x20
animation_frame_C657B1:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x200, 0x20
animation_frame_C657B7:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0, 0x20
animation_frame_C657BD:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x200, 0x60
animation_frame_C657C3:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x400, 0x60
animation_frame_C657C9:
    db 1
    frame_oam_tile 0xF7, 0xF8, 0x600, 0x60
animation_frame_C657CF:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2600, 0x20
animation_frame_C657D5:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2400, 0x20
animation_frame_C657DB:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2200, 0x20
byte_C657E1:
    db 0x12
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
animation_frame_C6582A:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0, 0x20
animation_frame_C65830:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x200, 0x20
animation_frame_C65836:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2000, 0x20
animation_frame_C6583C:
    db 1
    frame_oam_tile 0xF8, 0xF8, 0x2200, 0x20
byte_C65842:
    db 6
    animation_frame animation_frame_C6582A, 0xC
    animation_frame animation_frame_C65830, 0xC
    animation_frame animation_frame_C65836, 0xC
    animation_frame animation_frame_C6583C, 0xC
    animation_frame animation_frame_C65836, 0xC
    animation_frame animation_frame_C65830, 0xC
animation_frame_C6585B:
    db 2
    frame_oam_tile 0xF8, 0xF6, 0, 0x20
    frame_oam_tile 0xF8, 0, 0x600, 0x20
animation_frame_C65866:
    db 2
    frame_oam_tile 0xF8, 0xF5, 0x2000, 0x20
    frame_oam_tile 0xF8, 0, 0x600, 0x20
animation_frame_C65871:
    db 2
    frame_oam_tile 0xF8, 0xF4, 0x200, 0x20
    frame_oam_tile 0xF8, 0, 0x600, 0x20
animation_frame_C6587C:
    db 2
    frame_oam_tile 0xF8, 0xF3, 0x2200, 0x20
    frame_oam_tile 0xF8, 0, 0x600, 0x20
animation_frame_C65887:
    db 2
    frame_oam_tile 0xF8, 0xF2, 0x400, 0x20
    frame_oam_tile 0xF8, 0, 0x600, 0x20
animation_frame_C65892:
    db 2
    frame_oam_tile 0xF8, 0xF1, 0x2400, 0x20
    frame_oam_tile 0xF8, 0, 0x600, 0x20
denkyun_animation:
    db 0xA
    animation_frame animation_frame_C6585B, 0x10; 0
    animation_frame animation_frame_C65866, 4; 1
    animation_frame animation_frame_C65871, 4; 2
    animation_frame animation_frame_C6587C, 4; 3
    animation_frame animation_frame_C65887, 4; 4
    animation_frame animation_frame_C65892, 0x10; 5
    animation_frame animation_frame_C65887, 4; 6
    animation_frame animation_frame_C6587C, 4; 7
    animation_frame animation_frame_C65871, 4; 8
    animation_frame animation_frame_C65866, 4; 9

create_metal_kuwagen:
    i16
    STY z:0x56
    SEP #0x20
    create_object kuwagen
    REP #0x20
    BCC .loc_C658E6
    JML create_enemy_ret

.loc_C658E6:
    LDA #1
    STA a:addr(enemy.hitpoints_left), Y
    LDA #2
    STA a:addr(enemy.direction), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(enemy.x_position), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(enemy.y_position), Y
    LDA z:0x5F
    STA a:addr(enemy.unknown_3a), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(enemy.carried_bonus), Y
    LDA #0x30
    STA a:addr(enemy.palette), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics kuwagen_graphic_pointers, 2
    allocate_object_palette METAL_KUWAGEN_PALETTE
    RTL

create_kuwagen:
    STY z:0x56
    SEP #0x20
    create_object kuwagen
    REP #0x20
    BCS create_enemy_ret
    LDA #0
    STA a:addr(enemy.hitpoints_left), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics kuwagen_graphic_pointers, 2
    allocate_object_palette KUWAGEN_PALETTE
create_enemy_ret:
    RTL

kuwagen:
    REP #0x20
    LDA #0
    STA z:0x30, X
    LDA #addr(byte_C63EB8)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(off_C67D03)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D03)
    STA z:0x18, X
    SEP #0x20
    LDA #2
    STA z:0x3D, X
    LDA #3
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    REP #0x20
    LDA #addr(_kuwagen)
    STA z:0, X
    SEP #0x20
    LDA #bank(_kuwagen)
    STA z:2, X

_kuwagen:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C65A41
    JML kill_enemy

.loc_C65A41:
    BIT #0x90
    BEQ .loc_C65A49
    JML handler_early_exit

.loc_C65A49:
    BIT #0x41
    BEQ .loc_C65A51
    JML .loc_C65A5F

.loc_C65A51:
    JSL kuwagen_movement
    JSL handle_enemy_damage
    BCC .loc_C65A5F
    JML kill_enemy

.loc_C65A5F:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_senshiyan:
    STY z:0x56
    SEP #0x20
    create_object senshiyan
    REP #0x20
    BCC .loc_C65A8F
    JML create_enemy_ret

.loc_C65A8F:
    LDA #2
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics senshiyan_graphics, 3
    allocate_object_palette SENSHIYAN_PALETTE
    RTL

senshiyan:
    REP #0x20
    LDA #addr(off_C67D0B)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D0B)
    STA z:0x18, X
    REP #0x20
    LDA #0
    STA z:0x34, X
    LDA #addr(byte_C64044)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #3
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #4
    STA z:0x3D, X
    JSL create_senshiyan_part
    REP #0x20
    LDA #addr(sub_C65B5D)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C65B5D)
    STA z:2, X
sub_C65B4D:
    JSL fast_random
    REP #0x20
    AND #0xFF
    CLC
    ADC #0x40
    STA z:0x30, X
    RTL

sub_C65B5D:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C65B6A
    JML kill_enemy

.loc_C65B6A:
    BIT #0x90
    BEQ .loc_C65B72
    JML handler_early_exit

.loc_C65B72:
    BIT #0x41
    BEQ .loc_C65B7A
    JML .loc_C65B9F

.loc_C65B7A:
    REP #0x20
    LDA z:0x34, X
    BNE .loc_C65BAF
    JSL wanderer_movement
    JSL handle_enemy_damage
    BCC .loc_C65B8E
    JML kill_enemy

.loc_C65B8E:
    REP #0x20
    DEC z:0x30, X
    BNE .loc_C65B9F
    LDA #0x81
    STA z:0x34, X
    JSL sub_C65B4D
    BRA .loc_C65BAF
.loc_C65B9F:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

.loc_C65BAF:
    JSL handle_enemy_damage
    BCC .loc_C65BB9
    JML kill_enemy

.loc_C65BB9:
    REP #0x20
    DEC z:0x34, X
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation_2
    RTL

sub_C65BCB:
    REP #0x20
    LDA z:0x11, X
    PHA
    LDA z:0x14, X
    PHA
    LDA z:0x22, X
    AND #0xFF
    CMP #0xFF
    BNE .loc_C65BE0
    LDA #2

.loc_C65BE0:
    ASL A
    PHX
    TAX
    LDA f:unk_C65EB9, X
    PLX
    SEP #0x20
    CLC
    ADC z:0x11, X
    STA z:0x11, X
    XBA
    CLC
    ADC z:0x14, X
    STA z:0x14, X
    STZ z:0x32, X
    JSL sub_C65D5E
    REP #0x20
    PLA
    STA z:0x14, X
    PLA
    STA z:0x11, X
    RTL

create_senshiyan_part:
    SEP #0x20
    create_object sub_C65C3B
    BCC .loc_C65C20
    JML create_enemy_ret

.loc_C65C20:
    REP #0x20
    LDA z:0xE, X
    STA a:addr(0xE), Y
    LDA z:0x1E, X
    STA a:addr(0x1E), Y
    LDA z:0x11, X
    STA a:addr(0x11), Y
    LDA z:0x14, X
    STA a:addr(0x14), Y
    TXA
    STA a:addr(0x34), Y
    RTL

sub_C65C3B:
    REP #0x20
    LDA #addr(byte_C6409D)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(sub_C65C59)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C65C59)
    STA z:2, X
    ; fallthrough

sub_C65C59:
    SEP #0x20
    LDY z:0x34, X
    LDA a:addr(0x20), Y
    STA z:0x20, X
    LDA a:addr(0x22), Y
    STA z:0x22, X
    REP #0x20
    LDA a:addr(0x11), Y
    STA z:0x11, X
    LDA a:addr(0x14), Y
    STA z:0x14, X
    LDA a:addr(0), Y
    BNE .loc_C65C7C
    JML delete_object

.loc_C65C7C:
    LDA a:addr(0x34), Y
    CMP #0x80
    BNE .loc_C65C9B
    SEP #0x20
    LDA #0xFF
    STA z:0x23, X
    LDA #9
    STA z:0x24, X
    REP #0x20
    LDA #addr(sub_C65CC2)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C65CC2)
    STA z:2, X

.loc_C65C9B:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_SCREEN_TRANSITION
    BNE .locret_C65CC1
    SEP #0x20
    LDA z:0x22, X
    CMP #0xFF
    BNE .loc_C65CAE
    LDA #2

.loc_C65CAE:
    ASL A
    STA z:0xC, X
    REP #0x20
    LDA z:0x14, X
    PHA
    INC z:0x14, X
    JSL advance_animation_2
    REP #0x20
    PLA
    STA z:0x14, X

.locret_C65CC1:
    RTL

sub_C65CC2:
    SEP #0x20
    handler_return_in_transition

    BIT #0x41
    BEQ .loc_C65CD7
    JML .loc_C65D03

.loc_C65CD7:
    REP #0x20
    LDY z:0x34, X
    LDA a:addr(0), Y
    BNE .loc_C65CE4
    JML delete_object

.loc_C65CE4:
    SEP #0x20
    LDA z:0xC, X
    CMP z:0x23, X
    BEQ .loc_C65D03
    STA z:0x23, X
    DEC z:0x24, X
    BNE .loc_C65D03
    LDA #0x20
    STA z:0x23, X
    REP #0x20
    LDA #addr(sub_C65D14)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C65D14)
    STA z:2, X

.loc_C65D03:
    REP #0x20
    LDA z:0x14, X
    PHA
    INC z:0x14, X
    JSL advance_animation
    REP #0x20
    PLA
    STA z:0x14, X
    RTL

sub_C65D14:
    SEP #0x20
    handler_return_in_transition

    BIT #0x41
    BEQ .loc_C65D29
    JML .loc_C65D4D

.loc_C65D29:
    REP #0x20
    LDY z:0x34, X
    LDA a:addr(0), Y
    BNE .loc_C65D36
    JML delete_object

.loc_C65D36:
    SEP #0x20
    DEC z:0x23, X
    BNE .loc_C65D4D
    JSL sub_C65BCB
    REP #0x20
    LDA #addr(sub_C65C59)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C65C59)
    STA z:2, X

.loc_C65D4D:
    REP #0x20
    LDA z:0x14, X
    PHA
    INC z:0x14, X
    JSL advance_animation_2
    REP #0x20
    PLA
    STA z:0x14, X
    RTL

sub_C65D5E:
    SEP #0x20
    create_object sub_C65DB6
    BCC .loc_C65D7A
    JML create_enemy_ret

.loc_C65D7A:
    SEP #0x20
    LDA a:addr(3), Y
    AND #0xFE
    STA a:addr(3), Y
    LDA z:0x22, X
    CMP #0xFF
    BNE .loc_C65D8C
    LDA #2

.loc_C65D8C:
    STA a:addr(0x22), Y
    LDA z:0x32, X
    STA a:addr(0x32), Y
    LDA #4
    STA a:addr(0x1E), Y
    REP #0x20
    LDA z:0x34, X
    STA a:addr(0x34), Y
    LDA z:0xE, X
    STA a:addr(0xE), Y
    LDA z:0x11, X
    STA a:addr(0x11), Y
    LDA z:0x14, X
    STA a:addr(0x14), Y
    LDA #0
    STA a:addr(0x30), Y
    RTL

sub_C65DB6:
    REP #0x20
    LDY z:0x34, X
    LDA a:addr(0), Y
    BNE .loc_C65DC3
    JML delete_object

.loc_C65DC3:
    LDA z:0x32, X
    AND #0xFE
    STA z:0x40
    ASL z:0x40
    PHX
    TAX
    LDA f:off_C65F01, X
    STA z:0x50
    PLX
    LDA z:0x22, X
    AND #0xFF
    ASL A
    ASL A
    ASL A
    ASL A
    CLC
    ADC z:0x40
    PHX
    TAX
    LDA f:unk_C65EC1, X
    ASL A
    ASL A
    STA z:0x40
    LDA f:unk_C65EC3, X
    ASL A
    ASL A
    PLX
    STA z:0x18, X
    LDA z:0x40
    STA z:0x16, X
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C65E0F)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C65E0F)
    STA z:2, X

.loc_C65E0F:
    SEP #0x20
    handler_return_in_transition

    BIT #0x41
    BEQ .loc_C65E24
    JML .loc_C65E84

.loc_C65E24:
    REP #0x20
    LDY z:0x34, X
    LDA a:addr(0), Y
    BNE .loc_C65E31
    JML delete_object

.loc_C65E31:
    INC z:0x30, X
    LDA z:0x30, X
    CMP #0x40
    BNE .loc_C65E3E
    JML delete_object

.loc_C65E3E:
    CMP #7
    BCS .loc_C65E84
    CMP #6
    BNE .loc_C65E56
    SEP #0x20
    INC z:0x32, X
    LDA z:0x32, X
    CMP #6
    BEQ .loc_C65E84
    JSL sub_C65D5E

.loc_C65E56:
    REP #0x20
    STZ z:0x40
    LDA z:0x16, X
    BPL .loc_C65E60
    DEC z:0x40

.loc_C65E60:
    CLC
    ADC z:0x10, X
    STA z:0x10, X
    SEP #0x20
    LDA z:0x40
    ADC z:0x12, X
    STA z:0x12, X
    REP #0x20
    STZ z:0x40
    LDA z:0x18, X
    BPL .loc_C65E77
    DEC z:0x40

.loc_C65E77:
    CLC
    ADC z:0x13, X
    STA z:0x13, X
    SEP #0x20
    LDA z:0x40
    ADC z:0x15, X
    STA z:0x15, X

.loc_C65E84:
    REP #0x20
    LDA z:0x12, X
    ORA z:0x15, X
    AND #0xFF
    BNE .loc_C65E98
    LDA #0x404
    STA z:0x40
    JSL sub_C634FC

.loc_C65E98:
    REP #0x20
    LDA z:0x14, X
    PHA
    LDA z:0x22, X
    AND #0xFF
    CMP #2
    BNE .loc_C65EAF
    LDA z:0x14, X
    CLC
    ADC #0x10
    STA z:0x14, X

.loc_C65EAF:
    JSL advance_animation
    REP #0x20
    PLA
    STA z:0x14, X
    RTL

unk_C65EB9:
    db 0
    db 0xF0
    db 8
    db 0xF0
    db 0
    db 0xF0
    db 0xF8
    db 0xF0
unk_C65EC1:
    db 0
    db 0
unk_C65EC3:
    db 0xC0
    db 0xFF
    db 0
    db 0
    db 0x80
    db 0xFF
    db 0
    db 0
    db 0x60
    db 0xFF
    db 0
    db 0
    db 0
    db 0
    db 0x40
    db 0
    db 0x40
    db 0
    db 0x80
    db 0
    db 0x20
    db 0
    db 0xA0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0x40
    db 0
    db 0
    db 0
    db 0x80
    db 0
    db 0
    db 0
    db 0xA0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0xC0
    db 0xFF
    db 0x40
    db 0
    db 0x80
    db 0xFF
    db 0x20
    db 0
    db 0x60
    db 0xFF
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
off_C65F01:
    da byte_C64056, byte_C64067, byte_C64078
create_metal_propene:
    STY z:0x56
    SEP #0x20
    create_object metal_propene
    REP #0x20
    BCC .loc_C65F27
    JML create_enemy_ret

.loc_C65F27:
    LDA #4
    STA a:addr(enemy.hitpoints_left), Y
    LDA #2
    STA a:addr(enemy.direction), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(enemy.x_position), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(enemy.y_position), Y
    LDA z:0x5F
    STA a:addr(enemy.unknown_3a), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(enemy.carried_bonus), Y
    LDA #0x30
    STA a:addr(enemy.palette), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics metal_propene_graphics, 2
    allocate_object_palette METAL_PROPENE_PALETTE
    RTL

metal_propene:
    REP #0x20
    LDA #addr(off_C67D13)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D13)
    STA z:0x18, X
    REP #0x20
    LDA #addr(byte_C641BE)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #0x40
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #2
    STA z:0x19, X
    LDA #6
    STA z:0x3D, X
    STZ z:0x30, X
    REP #0x20
    LDA #addr(.loc_C65FDE)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C65FDE)
    STA z:2, X

.loc_C65FDE:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C65FEB
    JML kill_enemy

.loc_C65FEB:
    BIT #0x90
    BEQ .loc_C65FF3
    JML handler_early_exit

.loc_C65FF3:
    BIT #0x41
    BEQ .loc_C65FFB
    JML .loc_C66009

.loc_C65FFB:
    JSL wanderer_movement
    JSL handle_enemy_damage
    BCC .loc_C66009
    JML kill_enemy

.loc_C66009:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_propene:
    STY z:0x56
    SEP #0x20
    create_object propene
    REP #0x20
    BCC .loc_C66039
    JML create_enemy_ret

.loc_C66039:
    LDA #0
    STA a:addr(enemy.hitpoints_left), Y
    LDA #2
    STA a:addr(enemy.direction), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(enemy.x_position), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(enemy.y_position), Y
    LDA z:0x5F
    STA a:addr(enemy.unknown_3a), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(enemy.carried_bonus), Y
    LDA #0x30
    STA a:addr(enemy.palette), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics propene_graphics, 2
    allocate_object_palette PROPENE_PALETTE
    RTL

propene:
    REP #0x20
    LDA #addr(off_C67D13)
    STA z:object.handler+0x16, X
    SEP #0x20
    LDA #bank(off_C67D13)
    STA z:object.handler+0x18, X
    REP #0x20
    LDA #addr(propene_animation)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    LDA #0
    STA z:enemy.score_index, X
    STZ z:enemy.field_30, X
    REP #0x20
    LDA #addr(_propene)
    STA z:object.handler, X
    SEP #0x20
    LDA #bank(_propene)
    STA z:object.handler+2, X

_propene:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C660FD
    JML kill_enemy

.loc_C660FD:
    BIT #0x90
    BEQ .loc_C66105
    JML handler_early_exit

.loc_C66105:
    BIT #0x41
    BEQ .loc_C6610D
    JML .loc_C6611B

.loc_C6610D:
    JSL wanderer_movement
    JSL handle_enemy_damage
    BCC .loc_C6611B
    JML kill_enemy

.loc_C6611B:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_denkyun:
    STY z:0x56
    SEP #0x20
    create_object denkyun
    REP #0x20
    BCC .loc_C6614B
    JML create_enemy_ret

.loc_C6614B:
    LDA #1
    STA a:addr(enemy.hitpoints_left), Y
    LDA #2
    STA a:addr(enemy.direction), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics denkyun_graphics, 1
    allocate_object_palette DENKYUN_PALETTE
    RTL

denkyun:
    REP #0x20
    LDA #addr(off_C67DAB)
    STA z:object.handler+0x16, X
    SEP #0x20
    LDA #bank(off_C67DAB)
    STA z:object.handler+0x18, X
    REP #0x20
    LDA #addr(denkyun_animation)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #3
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #2
    STA z:enemy.score_index, X
    STZ z:0x30, X
    REP #0x20
    LDA #addr(.loc_C66202)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C66202)
    STA z:2, X

.loc_C66202:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C6620F
    JML kill_enemy

.loc_C6620F:
    BIT #0x90
    BEQ .loc_C66217
    JML handler_early_exit

.loc_C66217:
    BIT #0x41
    BEQ .loc_C6621F
    JML .loc_C6622D

.loc_C6621F:
    JSL wanderer_movement
    JSL handle_enemy_damage
    BCC .loc_C6622D
    JML kill_enemy

.loc_C6622D:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_starnuts:
    STY z:0x56
    SEP #0x20
    create_object starnuts
    REP #0x20
    BCC .loc_C6625D
    JML create_enemy_ret

.loc_C6625D:
    LDA #0
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics starnuts_graphics, 3
    allocate_object_palette STARNUTS_PALETTE
    RTL

starnuts:
    REP #0x20
    LDA #addr(off_C67D93)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D93)
    STA z:0x18, X
    REP #0x20
    LDA #addr(byte_C65739)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #3
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #1
    STA z:0x3D, X
    STZ z:0x30, X
    REP #0x20
    LDA #addr(.loc_C66314)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C66314)
    STA z:2, X

.loc_C66314:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C66321
    JML kill_enemy

.loc_C66321:
    BIT #0x90
    BEQ .loc_C66329
    JML handler_early_exit

.loc_C66329:
    BIT #0x41
    BEQ .loc_C66331
    JML .loc_C6633F

.loc_C66331:
    JSL wanderer_movement
    JSL handle_enemy_damage
    BCC .loc_C6633F
    JML kill_enemy

.loc_C6633F:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_banen:
    STY z:0x56
    SEP #0x20
    create_object banen
    REP #0x20
    BCC .loc_C6636F
    JML create_enemy_ret

.loc_C6636F:
    LDA #0
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics banen_graphics, 2
    allocate_object_palette BANEN_PALETTE
    RTL

banen:
    REP #0x20
    LDA #addr(off_C67D1B)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D1B)
    STA z:0x18, X
    REP #0x20
    LDA #addr(byte_C643C8)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #0x30
    STA z:0xE, X
    LDA #3
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #1
    STA z:0x3D, X
    REP #0x20
    LDA #addr(.loc_C66428)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C66428)
    STA z:2, X

.loc_C66428:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C66435
    JML kill_enemy

.loc_C66435:
    BIT #0x90
    BEQ .loc_C6643D
    JML handler_early_exit

.loc_C6643D:
    BIT #0x41
    BEQ .loc_C66445
    JML .loc_C66453

.loc_C66445:
    JSL wanderer_movement2
    JSL handle_enemy_damage
    BCC .loc_C66453
    JML kill_enemy

.loc_C66453:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_cuppen:
    STY z:0x56
    SEP #0x20
    create_object cuppen
    REP #0x20
    BCC .loc_C66483
    JML create_enemy_ret

.loc_C66483:
    LDA #0
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics cuppen_graphics, 2
    allocate_object_palette CUPPEN_PALETTE
    RTL

cuppen:
    REP #0x20
    LDA #addr(off_C67D23)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D23)
    STA z:0x18, X
    REP #0x20
    LDA #addr(byte_C6448A)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #0x40
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #2
    STA z:0x3D, X
    STZ z:0x30, X
    REP #0x20
    LDA #addr(.loc_C6653A)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C6653A)
    STA z:2, X

.loc_C6653A:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C66547
    JML kill_enemy

.loc_C66547:
    BIT #0x90
    BEQ .loc_C6654F
    JML handler_early_exit

.loc_C6654F:
    BIT #0x41
    BEQ .loc_C66557
    JML .loc_C66565

.loc_C66557:
    JSL random_wanderer_movement
    JSL handle_enemy_damage
    BCC .loc_C66565
    JML kill_enemy

.loc_C66565:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_keibin:
    STY z:0x56
    SEP #0x20
    create_object keibin
    REP #0x20
    BCC .loc_C66595
    JML create_enemy_ret

.loc_C66595:
    LDA #2
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics keibin_graphics, 2
    allocate_object_palette KEIBIN_PALETTE
    RTL

keibin:
    REP #0x20
    LDA #addr(off_C67D8B)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D8B)
    STA z:0x18, X
    REP #0x20
    LDA #addr(byte_C654D6)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #0x40
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #2
    STA z:0x3D, X
    STZ z:0x30, X
    REP #0x20
    LDA #addr(.loc_C6664C)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C6664C)
    STA z:2, X

.loc_C6664C:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C66659
    JML kill_enemy

.loc_C66659:
    BIT #0x90
    BEQ .loc_C66661
    JML handler_early_exit

.loc_C66661:
    BIT #0x41
    BEQ .loc_C66669
    JML .loc_C66677

.loc_C66669:
    JSL random_wanderer_movement
    JSL handle_enemy_damage
    BCC .loc_C66677
    JML kill_enemy

.loc_C66677:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_anzenda:
    STY z:0x56
    SEP #0x20
    create_object anzenda
    REP #0x20
    BCC .loc_C666A7
    JML create_enemy_ret

.loc_C666A7:
    LDA #1
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics anzenda_graphics, 2
    allocate_object_palette ANZENDA_PALETTE
    RTL

anzenda:
    REP #0x20
    LDA #addr(off_C67D2B)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D2B)
    STA z:0x18, X
    REP #0x20
    LDA #addr(byte_C6458D)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #3
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #3
    STA z:0x3D, X
    STZ z:0x30, X
    REP #0x20
    LDA #addr(.loc_C6675E)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C6675E)
    STA z:2, X

.loc_C6675E:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C6676B
    JML kill_enemy

.loc_C6676B:
    BIT #0x90
    BEQ .loc_C66773
    JML handler_early_exit

.loc_C66773:
    BIT #0x41
    BEQ .loc_C6677B
    JML .loc_C66789

.loc_C6677B:
    JSL wanderer_movement
    JSL handle_enemy_damage
    BCC .loc_C66789
    JML kill_enemy

.loc_C66789:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_yoroisu:
    STY z:0x56
    SEP #0x20
    create_object yoroisu
    REP #0x20
    BCC .loc_C667B9
    JML create_enemy_ret

.loc_C667B9:
    LDA #7
    STA a:enemy.hitpoints_left, Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics yoroisu_graphics, 6
    allocate_object_palette YOROISO_PALETTE
    RTL

yoroisu:
    REP #0x20
    LDA #addr(byte_C647D0)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(off_C67D33)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D33)
    STA z:0x18, X
    SEP #0x20
    LDA #0x30
    STA z:0xE, X
    LDA #3
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #5
    STA z:0x3D, X
    REP #0x20
    LDA #addr(.loc_C66872)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C66872)
    STA z:2, X

.loc_C66872:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C6687F
    JML kill_enemy

.loc_C6687F:
    BIT #0x90
    BEQ .loc_C66887
    JML handler_early_exit

.loc_C66887:
    BIT #0x41
    BEQ .loc_C6688F
    JML .loc_C668AC

.loc_C6688F:
    JSL get_object_square_index
    REP #0x20
    TAY
    LDA a:addr(collision_map), Y
    BIT #0x100
    BNE .loc_C668BC

.loc_C6689E:
    JSL handle_enemy_damage
    BCC .loc_C668A8
    JML kill_enemy

.loc_C668A8:
    JSL kuwagen_movement
.loc_C668AC:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

.loc_C668BC:
    REP #0x20
    LDA a:addr(collision_map), Y
    AND #0xF
    SEC
    SBC #0xC
    STA z:0x40
    LDA z:0x20, X
    AND #0xFF
    PHX
    TAX
    SEP #0x20
    LDA f:byte_C668F9, X
    PLX
    CMP z:0x40
    BNE .loc_C6689E
    REP #0x20
    LDA z:0x20, X
    AND #0xFF
    ASL A
    PHX
    TAX
    LDA f:off_C67D3B, X
    STA z:0x50
    PLX
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    BRA .loc_C668AC

byte_C668F9:
    db 1, 3, 0, 2

create_chameleoman:
    STY z:0x56
    SEP #0x20
    create_object chameleoman
    REP #0x20
    BCC .loc_C6691D
    JML create_enemy_ret

.loc_C6691D:
    LDA #0
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics chameleoman_graphics, 1
    allocate_object_palette CHAMELEOMAN_PALETTE
    RTL

chameleoman:
    REP #0x20
    LDA #addr(player_animation_list+0x42)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(player_animation_list+0x42)
    STA z:0x18, X
    REP #0x20
    LDA #0xE0
    STA z:0x1C, X
    REP #0x20
    LDA #addr(warpping_animation)
    STA z:0x50
    SEP #0x20
    LDA #bank(warpping_animation)
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA z:0x1E, X
    STA z:0x33, X
    LDA z:0xF, X
    STA z:0x34, X
    LDA #0x30
    STA z:0xE, X
    LDA #3
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #1
    STA z:0x31, X
    LDA #0
    STA z:0x32, X
    LDA #2
    STA z:0x3D, X
    REP #0x20
    LDA #addr(sub_C669FB)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C669FB)
    STA z:2, X

sub_C669ED:
    JSL fast_random
    SEP #0x20
    AND #0x3F
    CLC
    ADC #0xC0
    STA z:0x30, X
    RTL

sub_C669FB:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C66A08
    JML kill_enemy

.loc_C66A08:
    BIT #0x90
    BEQ .loc_C66A10
    JML handler_early_exit

.loc_C66A10:
    BIT #0x41
    BEQ .loc_C66A18
    JML .loc_C66A30

.loc_C66A18:
    SEP #0x20
    DEC z:0x30, X
    BNE .loc_C66A22
    JML .loc_C66AE3

.loc_C66A22:
    LDA z:0x31, X
    BEQ .loc_C66A2C
    JSL wanderer_movement2
    BRA .loc_C66A30

.loc_C66A2C:
    JSL follower_movement

.loc_C66A30:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
.loc_C66A3F:
    JSL handle_enemy_damage
    BCS .loc_C66A49
    JML .locret_C66A6A

.loc_C66A49:
    SEP #0x20
    LDA z:0x33, X
    CMP z:0x1E, X
    BNE .loc_C66A55
    JML kill_enemy

.loc_C66A55:
    LDA #0
    STA z:0x3E, X
    LDA #0x20
    STA z:0x3F, X
    REP #0x20
    LDA #addr(.loc_C66A6B)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C66A6B)
    STA z:2, X

.locret_C66A6A:
    RTL

.loc_C66A6B:
    SEP #0x20
    LDA #bank(player_animation_list)
    STA z:0x52
    REP #0x20
    LDA z:0x20, X
    AND #0xFF
    ASL A
    ADC #addr(player_animation_list+0x3A)
    STA z:0x50
    LDA f:[z:0x50]
    STA z:0x50
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C66A93)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C66A93)
    STA z:2, X

.loc_C66A93:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C66AA0
    JML kill_enemy

.loc_C66AA0:
    BIT #0x90
    BEQ .loc_C66AA8
    JML handler_early_exit

.loc_C66AA8:
    BIT #0x41
    BEQ .loc_C66AB0
    JML .loc_C66AC1

.loc_C66AB0:
    DEC z:0x3F, X
    BNE .loc_C66AC1
    REP #0x20
    LDA #addr(.loc_C66AE3)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C66AE3)
    STA z:2, X

.loc_C66AC1:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation_2
    SEP #0x20
    LDA #0xE
    STA z:0x1E, X
    LDA z:0x3E, X
    EOR #1
    STA z:0x3E, X
    BEQ .locret_C66A6A
    LDA z:0x32, X
    STA z:0x1E, X
    RTL

.loc_C66AE3:
    JSL sub_C669ED
    SEP #0x20
    LDA z:0x31, X
    EOR #1
    STA z:0x31, X
    BNE .loc_C66AFB
    JSL fast_random
    SEP #0x20
    AND #2
    STA z:0x32, X

.loc_C66AFB:
    REP #0x20
    LDA #addr(.loc_C66B29)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C66B29)
    STA z:2, X
    SEP #0x20
    LDA #0x20
    STA z:0x36, X
    LDA #0
    STA z:0x37, X
    LDA #bank(player_animation_list+0x42)
    STA z:0x18, X
    REP #0x20
    LDA #addr(player_animation_list+0x42)
    STA z:0x16, X
    LDA z:0x31, X
    BIT #1
    BNE .loc_C66B29
    LDA #addr(player_animation_list+0x3A)
    STA z:0x16, X

.loc_C66B29:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C66B36
    JML kill_enemy

.loc_C66B36:
    BIT #0x90
    BEQ .loc_C66B3E
    JML handler_early_exit

.loc_C66B3E:
    BIT #0x41
    BEQ .loc_C66B46
    JML .loc_C66A3F

.loc_C66B46:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation_2
    JSL sub_C66B64
    JSL handle_enemy_damage
    BCC .locret_C66B63
    JML kill_enemy

.locret_C66B63:
    RTL

sub_C66B64:
i16
    SEP #0x20
    LDA #bank(byte_C66BFC)
    STA z:0xDD
    DEC z:0x36, X
    BNE .locret_C66BE5
    LDA z:0x37, X
    CMP #0x20
    BEQ .loc_C66BE6
    INC z:0x37, X
    STA z:0x40
    LDA z:0x31, X
    BIT #1
    BNE .loc_C66B88
    LDA z:0x40
    SEC
    SBC #0x1F
    EOR #0xFF
    INC A
    STA z:0x40

.loc_C66B88:
    LDA z:0x40
    ASL A
    REP #0x20
    AND #0xFF
    CLC
    ADC #addr(byte_C66BFC)
    STA z:0xDB
    SEP #0x20
    LDA z:0x32, X
    STA z:0x1F, X
    LDA #0
    STA z:0xF, X
    LDA #bank(player_animation_list)
    STA z:addr(far_function_pointer + 2)
    LDY #1
    LDA f:[z:0xDB], Y
    STA z:0x36, X
    LDA f:[z:0xDB]
    BEQ .loc_C66BBB
    LDA z:0x33, X
    STA z:0x1F, X
    LDA z:0x34, X
    STA z:0xF, X
    LDA #bank(player_animation_list)
    STA z:addr(far_function_pointer + 2)

.loc_C66BBB:
    SEP #0x20
    LDA #bank(player_animation_list)
    STA z:0x52
    REP #0x20
    LDA f:[z:0xDB]
    AND #0xFF
    ASL A
    ASL A
    ASL A
    TAY
    LDA z:0x20, X
    AND #0xFF
    ASL A
    ADC #addr(player_animation_list+0x3A)
    STA z:0x50
    LDA f:[z:0x50], Y
    STA z:0x50
    SEP #0x20
    LDA z:addr(far_function_pointer + 2)
    STA z:0x52
    JSL start_animation

.locret_C66BE5:
    RTL

.loc_C66BE6:
    SEP #0x20
    LDA #0xFF
    STA z:0x22, X
    REP #0x20
    LDA #addr(sub_C669FB)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C669FB)
    STA z:2, X
    JMP a:addr(sub_C669FB.loc_C66A3F)

byte_C66BFC:
    db 0, 0x20, 1, 1, 0, 3, 1, 1
    db 0, 3, 1, 1, 0, 3, 1, 1
    db 0, 2, 1, 1, 0, 2, 1, 1
    db 0, 2, 1, 1, 0, 1, 1, 1
    db 0, 1, 1, 1, 0, 1, 1, 2
    db 0, 1, 1, 2, 0, 1, 1, 2
    db 0, 1, 1, 3, 0, 1, 1, 3
    db 0, 1, 1, 3, 0, 1, 1, 0x20
    
create_missle:
    REP #0x20
    STY z:0x56
    SEP #0x20
    create_object missle
    REP #0x20
    BCC .loc_C66C5E
    JML create_enemy_ret

.loc_C66C5E:
    LDA #0
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    TXA
    STA a:addr(0x38), Y
    INC z:0x30, X
    PHX
    LDA z:0x34, X
    TAX
    LDA z:0x11, X
    PLX
    SEC
    SBC #0x88
    EOR #0xFFFF
    INC A
    CLC
    ADC #0x88
    STA a:addr(0x11), Y
    LDA #0x40
    STA a:addr(0x14), Y
    REP #0x20
    LDA #addr(enemy_creation_functions)
    STA a:addr(0x3A), Y
    SEP #0x20
    LDA #bank(enemy_creation_functions)
    STA a:addr(0x3C), Y
    SEP #0x20
    LDA #1
    STA a:addr(3), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA #8
    STA a:addr(0xF), Y
    LDA #0xC
    STA a:addr(0x1E), Y
    LDA #0xC
    STA a:addr(0x1F), Y
    LDA #0
    STA a:addr(0x3E), Y
    LDA #0
    STA a:addr(0x3F), Y
    RTL

missle:
    REP #0x20
    LDA #addr(off_C67D63)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D63)
    STA z:0x18, X
    REP #0x20
    LDA #0
    STA z:0x1A, X
    LDA #addr(byte_C648A6)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #0x10
    STA z:0x30, X
    LDA #0
    STA z:0x19, X
    LDA #2
    STA z:0x20, X
    REP #0x20
    LDA #addr(.loc_C66CFF)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C66CFF)
    STA z:2, X

.loc_C66CFF:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C66D0C
    JML kill_enemy

.loc_C66D0C:
    BIT #0x90
    BEQ .loc_C66D14
    JML handler_early_exit

.loc_C66D14:
    BIT #0x41
    BEQ .loc_C66D1C
    JML .loc_C66E56

.loc_C66D1C:
    REP #0x20
    LDA #0xC0
    STA z:0x42
    JSL straight_movement
    BCC .loc_C66D2D
    JML .loc_C66E56

.loc_C66D2D:
    SEP #0x20
    DEC z:0x30, X
    BEQ .loc_C66D37
    JML .loc_C66E56

.loc_C66D37:
    LDY z:0x38, X
    LDA a:addr(0x32), Y
    DEC A
    STA a:addr(0x32), Y
    JMP a:addr(.loc_C66DE1)
    STY z:0x56
    SEP #0x20
    create_object .loc_C66DE1
    REP #0x20
    BCC .loc_C66D63
    JML create_enemy_ret

.loc_C66D63:
    LDA #0
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics missle_graphics, 2
    allocate_object_palette MISSLE_PALETTE
    REP #0x20
    TYA
    STA a:addr(0x38), Y
    RTL

.loc_C66DE1:
    REP #0x20
    LDA #addr(off_C67D63)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D63)
    STA z:0x18, X
    REP #0x20
    LDA #addr(byte_C648A6)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #3
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #2
    STA z:0x3D, X
    REP #0x20
    LDA #addr(.loc_C66E1E)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C66E1E)
    STA z:2, X

.loc_C66E1E:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C66E2B
    JML kill_enemy

.loc_C66E2B:
    BIT #0x90
    BEQ .loc_C66E33
    JML handler_early_exit

.loc_C66E33:
    BIT #0x41
    BEQ .loc_C66E3B
    JML .loc_C66E56

.loc_C66E3B:
    JSL missle_movement
    JSL handle_enemy_damage
    BCC .loc_C66E56
    SEP #0x20
    PHY
    LDY z:0x38, X
    LDA a:addr(0x30), Y
    DEC A
    STA a:addr(0x30), Y
    PLY
    JML kill_enemy

.loc_C66E56:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_kouraru:
    STY z:0x56
    SEP #0x20
    create_object kouraru
    REP #0x20
    BCC .loc_C66E86
    JML create_enemy_ret

.loc_C66E86:
    LDA #0
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics kouraru_graphics, 3
    allocate_object_palette KOURARU_PALETTE
    RTL

kouraru:
    REP #0x20
    LDA #addr(off_C67D43)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D43)
    STA z:0x18, X
    REP #0x20
    LDA #addr(byte_C64910)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #3
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #1
    STA z:0x3D, X
    STZ z:0x30, X
    REP #0x20
    LDA #addr(.loc_C66F3D)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C66F3D)
    STA z:2, X

.loc_C66F3D:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C66F4A
    JML kill_enemy

.loc_C66F4A:
    BIT #0x90
    BEQ .loc_C66F52
    JML handler_early_exit

.loc_C66F52:
    BIT #0x41
    BEQ .loc_C66F5A
    JML .loc_C66F68

.loc_C66F5A:
    JSL wanderer_movement
    JSL handle_enemy_damage
    BCC .loc_C66F68
    JML kill_enemy

.loc_C66F68:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_pakupa:
    STY z:0x56
    SEP #0x20
    create_object pakupa
    REP #0x20
    BCC .loc_C66F98
    JML create_enemy_ret

.loc_C66F98:
    LDA #2
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics pakupa_graphics, 3
    allocate_object_palette PAKUPA_PALETTE
    RTL

pakupa:
    REP #0x20
    LDA #addr(off_C67D4B)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D4B)
    STA z:0x18, X
    REP #0x20
    LDA #addr(byte_C64A13)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #0x30
    STA z:0xE, X
    LDA #3
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #2
    STA z:0x3D, X
    REP #0x20
    LDA #addr(.loc_C67051)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C67051)
    STA z:2, X

.loc_C67051:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C6705E
    JML kill_enemy

.loc_C6705E:
    BIT #0x90
    BEQ .loc_C67066
    JML handler_early_exit

.loc_C67066:
    BIT #0x41
    BEQ .loc_C6706E
    JML .loc_C67080

.loc_C6706E:
    JSL pakupa_movement
    JSL handle_enemy_damage
    BCC .loc_C6707C
    JML kill_enemy

.loc_C6707C:
    JSL replace_bomb_with_hard_block

.loc_C67080:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

replace_bomb_with_hard_block:
    JSL get_object_square_index
    REP #0x20
    TAY
    LDA a:addr(collision_map), Y
    BIT #BOMB
    BEQ .locret_C670A5
    LDA #HARD_BLOCK|0x500
    STA a:addr(collision_map), Y

.locret_C670A5:
    RTL

create_douken:
    STY z:0x56
    SEP #0x20
    create_object douken
    REP #0x20
    BCC .loc_C670C6
    JML create_enemy_ret

.loc_C670C6:
    LDA #0
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics douken_graphics, 1
    allocate_object_palette DOUKEN_PALETTE
    RTL

douken:
    REP #0x20
    LDA #addr(off_C67D53)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D53)
    STA z:0x18, X
    REP #0x20
    LDA #addr(byte_C64AFC)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #0x30
    STA z:0xE, X
    LDA #3
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #0
    STA z:0x3D, X
    STZ z:0x30, X
    REP #0x20
    LDA #addr(.loc_C67181)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C67181)
    STA z:2, X

.loc_C67181:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C6718E
    JML kill_enemy

.loc_C6718E:
    BIT #0x90
    BEQ .loc_C67196
    JML handler_early_exit

.loc_C67196:
    BIT #0x41
    BEQ .loc_C6719E
    JML .loc_C671AC

.loc_C6719E:
    JSL wanderer_movement
    JSL handle_enemy_damage
    BCC .loc_C671AC
    JML kill_enemy

.loc_C671AC:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_dengurin:
    STY z:0x56
    SEP #0x20
    create_object dengurin
    REP #0x20
    BCC .loc_C671DC
    JML create_enemy_ret

.loc_C671DC:
    LDA #0
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics dengurin_graphics, 3
    allocate_object_palette DENGURIN_PALETTE
    RTL

dengurin:
    REP #0x20
    LDA #addr(off_C67D5B)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D5B)
    STA z:0x18, X
    REP #0x20
    LDA #addr(byte_C64C51)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #0x40
    STA z:0x21, X
    LDA #0x40
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #2
    STA z:0x3D, X
    STZ z:0x30, X
    REP #0x20
    LDA #addr(.loc_C67293)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C67293)
    STA z:2, X

.loc_C67293:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C672A0
    JML kill_enemy

.loc_C672A0:
    BIT #0x90
    BEQ .loc_C672A8
    JML handler_early_exit

.loc_C672A8:
    BIT #0x41
    BEQ .loc_C672B0
    JML .loc_C672BE

.loc_C672B0:
    JSL random_wanderer_movement
    JSL handle_enemy_damage
    BCC .loc_C672BE
    JML kill_enemy

.loc_C672BE:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_robocom:
    STY z:0x56
    SEP #0x20
    create_object robocom
    REP #0x20
    BCC .loc_C672EE
    JML create_enemy_ret

.loc_C672EE:
    LDA #2
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics robocom_graphics, 3
    allocate_object_palette ROBOCOM_PALETTE
    RTL

robocom:
    REP #0x20
    LDA #addr(off_C67D6B)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D6B)
    STA z:0x18, X
    REP #0x20
    LDA #0xE0
    STA z:0x1C, X
    LDA #addr(byte_C64E6F)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #0x30
    STA z:0xE, X
    LDA #1
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #3
    STA z:0x3D, X
    REP #0x20
    LDA #addr(.loc_C673AC)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C673AC)
    STA z:2, X

.loc_C673AC:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C673B9
    JML kill_enemy

.loc_C673B9:
    BIT #0x90
    BEQ .loc_C673C1
    JML handler_early_exit

.loc_C673C1:
    BIT #0x41
    BEQ .loc_C673C9
    JML .loc_C673D7

.loc_C673C9:
    JSL follower_movement
    JSL handle_enemy_damage
    BCC .loc_C673D7
    JML kill_enemy

.loc_C673D7:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_metal_u:
    STY z:0x56
    SEP #0x20
    create_object metal_u
    REP #0x20
    BCC .loc_C67407
    JML create_enemy_ret

.loc_C67407:
    LDA #1
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics metal_u_graphics, 1
    allocate_object_palette METAL_U_PALETTE
    RTL

metal_u:
    REP #0x20
    LDA #addr(off_C67DA3)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67DA3)
    STA z:0x18, X
    REP #0x20
    LDA #BOMB|SOFT_BLOCK|HARD_BLOCK
    STA z:enemy.collision_mask, X
    LDA #addr(byte_C65842)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #0x30
    STA z:0xE, X
    LDA #1
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #5
    STA z:0x3D, X
    REP #0x20
    LDA #addr(.loc_C674C5)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C674C5)
    STA z:2, X

.loc_C674C5:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C674D2
    JML kill_enemy

.loc_C674D2:
    BIT #0x90
    BEQ .loc_C674DA
    JML handler_early_exit

.loc_C674DA:
    BIT #0x41
    BEQ .loc_C674E2
    JML .loc_C674F0

.loc_C674E2:
    JSL follower_movement
    JSL handle_enemy_damage
    BCC .loc_C674F0
    JML kill_enemy

.loc_C674F0:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_kinkaru:
    STY z:0x56
    SEP #0x20
    create_object kinkaru
    REP #0x20
    BCC .loc_C67520
    JML create_enemy_ret

.loc_C67520:
    LDA #0
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics kinkaru_graphics, 2
    allocate_object_palette KINKARU_PALETTE
    RTL

kinkaru:
    REP #0x20
    LDA #addr(off_C67D9B)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D9B)
    STA z:0x18, X
    REP #0x20
    LDA #0xA0
    STA z:0x1C, X
    LDA #addr(byte_C657E1)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #0x30
    STA z:0xE, X
    LDA #1
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #3
    STA z:0x19, X
    LDA #4
    STA z:0x3D, X
    REP #0x20
    LDA #addr(.loc_C675DE)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C675DE)
    STA z:2, X

.loc_C675DE:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C675EB
    JML kill_enemy

.loc_C675EB:
    BIT #0x90
    BEQ .loc_C675F3
    JML handler_early_exit

.loc_C675F3:
    BIT #0x41
    BEQ .loc_C675FB
    JML .loc_C67609

.loc_C675FB:
    JSL follower_movement
    JSL handle_enemy_damage
    BCC .loc_C67609
    JML kill_enemy

.loc_C67609:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

create_moguchan:
    STY z:0x56
    SEP #0x20
    create_object moguchan
    REP #0x20
    BCC .loc_C67639
    JML create_enemy_ret

.loc_C67639:
    LDA #0
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics moguchan_graphics, 3
    allocate_object_palette MOGUCHAN_PALETTE
    RTL

moguchan:
    REP #0x20
    LDA #addr(off_C67D73)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D73)
    STA z:0x18, X
    REP #0x20
    LDA #0xE0
    STA z:0x1C, X
    LDA #addr(byte_C65038)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #0x30
    STA z:0xE, X
    LDA #1
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #2
    STA z:0x3D, X
    JSL fast_random
    REP #0x20
    AND #0xFF
    CLC
    ADC #0x400
    STA z:0x30, X
    REP #0x20
    LDA #addr(sub_C67706)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C67706)
    STA z:2, X
    ; fallthrough

sub_C67706:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C67713
    JML kill_enemy

.loc_C67713:
    BIT #0x90
    BEQ .loc_C6771B
    JML handler_early_exit

.loc_C6771B:
    BIT #0x41
    BEQ .loc_C67723
    JML .loc_C67737

.loc_C67723:
    REP #0x20
    DEC z:0x30, X
    BEQ .loc_C67747
    JSL follower_movement
    JSL handle_enemy_damage
    BCC .loc_C67737
    JML kill_enemy
.loc_C67737:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

.loc_C67747:
    JSL fast_random
    SEP #0x20
    AND #0x1F
    CLC
    ADC #0x60
    STA z:0x30, X
    REP #0x20
    LDA #addr(byte_C6505A)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C67772)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C67772)
    STA z:2, X

.loc_C67772:
    JSL advance_animation
    BCC .locret_C67785
    REP #0x20
    LDA #addr(sub_C67786)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C67786)
    STA z:2, X

.locret_C67785:
    RTL

sub_C67786:
    SEP #0x20
    handler_return_in_transition

    BIT #0x41
    BEQ .loc_C6779B
    JML sub_C67706.locret_C67785

.loc_C6779B:
    REP #0x20
    DEC z:0x30, X
    BNE sub_C67706.locret_C67785
    PHX
    JSL generate_random_position
    PLX
    JSL sub_C67825
    BNE .loc_C677C9
    REP #0x20
    LDA z:0x40
    AND #0xFF
    ORA #8
    STA z:0x11, X
    LDA z:0x42
    AND #0xFF
    ORA #8
    STA z:0x14, X
    JSL check_for_enemy_with_enemy_collision
    BCC .loc_C677CE

.loc_C677C9:
    SEP #0x20
    INC z:0x30, X
    RTL

.loc_C677CE:
    REP #0x20
    LDA #addr(byte_C65087)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C677EC)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C677EC)
    STA z:2, X

.loc_C677EC:
    JSL advance_animation
    BCS .loc_C677F6
    JML sub_C67706.locret_C67785

.loc_C677F6:
    JSL fast_random
    SEP #0x20
    AND #0x3F
    ORA #0xC0
    STA z:0x30, X
    LDA #0xFF
    STA z:0x22, X
    REP #0x20
    LDA #addr(byte_C65038)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(sub_C67706)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C67706)
    STA z:2, X
    RTL

sub_C67825:
    REP #0x20
    LDA z:0x40
    AND #0xF0
    LSR A
    LSR A
    LSR A
    STA z:0x44
    LDA z:0x42
    AND #0xF0
    ASL A
    ASL A
    ADC z:0x44
    TAY
    LDA a:addr(collision_map), Y
    BIT #0xFF
    RTL

create_red_bakuda:
    STY z:0x56
    SEP #0x20
    create_object bakuda
    REP #0x20
    BCC .loc_C67862
    JML create_enemy_ret

.loc_C67862:
    LDA #1
    STA a:addr(0x38), Y
    LDA #0
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics bakuda_graphics, 2
    allocate_object_palette RED_BAKUDA_PALETTE
    RTL

create_bakuda:
    STY z:0x56
    SEP #0x20
    create_object bakuda
    REP #0x20
    BCC .loc_C67900
    JML create_enemy_ret

.loc_C67900:
    LDA #0
    STA a:addr(0x38), Y
    LDA #0
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics bakuda_graphics, 2
    allocate_object_palette BAKUDA_PALETTE
    RTL

bakuda:
    REP #0x20
    LDA #addr(off_C67D7B)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D7B)
    STA z:0x18, X
    REP #0x20
    LDA #addr(byte_C6528C)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #3
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #3
    STA z:0x3D, X
    REP #0x20
    LDA #addr(sub_C679C8)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C679C8)
    STA z:2, X
sub_C679BB:
    JSL fast_random
    SEP #0x20
    AND #0x3F
    ORA #0xC0
    STA z:0x30, X
    RTL

sub_C679C8:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C679D5
    JML kill_enemy

.loc_C679D5:
    BIT #0x90
    BEQ .loc_C679DD
    JML handler_early_exit

.loc_C679DD:
    BIT #0x41
    BEQ .loc_C679E5
    JML .loc_C679FB

.loc_C679E5:
    SEP #0x20
    LDA z:0x30, X
    BEQ .loc_C67A0B
    DEC z:0x30, X
.loc_C679ED:
    JSL wanderer_movement
    JSL handle_enemy_damage
    BCC .loc_C679FB
    JML kill_enemy
.loc_C679FB:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

.loc_C67A0B:
    JSL is_object_aligned
    BCC .loc_C67A15
    JML .loc_C679ED

.loc_C67A15:
    JSL get_object_square_index
    REP #0x20
    TAY
    LDA a:addr(collision_map), Y
    AND #0xFF
    BEQ .loc_C67A28
    JML .loc_C679ED

.loc_C67A28:
    STY z:0x26, X
    LDA #addr(byte_C652E6)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C67A46)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C67A46)
    STA z:2, X

.loc_C67A46:
    JSL handle_enemy_damage
    BCC .loc_C67A50
    JML kill_enemy

.loc_C67A50:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    BCS .loc_C67A65
    JML .locret_C67B10

.loc_C67A65:
    REP #0x20
    LDA z:0x26, X
    STA z:0x56
    LDA #addr(byte_C6530F)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA z:5, X
    PHA
    LDA #2
    STA z:0x31, X
    LDA #0
    STA z:0x33, X
    LDA #2
    STA z:5, X
    JSL sub_C44BA4
    JSL center_object_on_tile
    SEP #0x20
    LDA #0x20
    STA z:0x31, X
    LDA #0xFF
    STA z:0x22, X
    PLA
    STA z:5, X
    REP #0x20
    LDA #addr(.loc_C67AAD)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C67AAD)
    STA z:2, X

.loc_C67AAD:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C67ABA
    JML kill_enemy

.loc_C67ABA:
    BIT #0x90
    BEQ .loc_C67AC2
    JML handler_early_exit

.loc_C67AC2:
    BIT #0x41
    BEQ .loc_C67ACA
    JML .locret_C67B10

.loc_C67ACA:
    SEP #0x20
    DEC z:0x31, X
    BNE .locret_C67B10
    REP #0x20
    LDA #addr(.loc_C67ADD)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C67ADD)
    STA z:2, X

.loc_C67ADD:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    BCC .locret_C67B10
    JSL sub_C679BB
    REP #0x20
    LDA #addr(byte_C6528C)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(sub_C679C8)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C679C8)
    STA z:2, X

.locret_C67B10:
    RTL

create_kierun:
    STY z:0x56
    SEP #0x20
    create_object kierun
    REP #0x20
    BCC .loc_C67B31
    JML create_enemy_ret

.loc_C67B31:
    LDA #0
    STA a:addr(0x1A), Y
    LDA #2
    STA a:addr(0x20), Y
    REP #0x20
    LDA z:0x40
    AND #0xF0
    ORA #8
    STA a:addr(0x11), Y
    LDA z:0x42
    AND #0xF0
    ORA #8
    STA a:addr(0x14), Y
    LDA z:0x5F
    STA a:addr(0x3A), Y
    LDA z:0x60
    STA a:addr(0x3B), Y
    SEP #0x20
    LDA z:0x48
    STA a:addr(0x3E), Y
    LDA #0x30
    STA a:addr(0xE), Y
    LDA a:addr(3), Y
    ORA #1
    STA a:addr(3), Y
    allocate_object_graphics kierun_graphics, 2
    allocate_object_palette KIERUN_PALETTE
    RTL

kierun:
    REP #0x20
    LDA #addr(off_C67D83)
    STA z:0x16, X
    SEP #0x20
    LDA #bank(off_C67D83)
    STA z:0x18, X
    REP #0x20
    LDA #addr(byte_C653CE)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    SEP #0x20
    LDA #0x40
    STA z:0x21, X
    LDA #0xFF
    STA z:0x22, X
    LDA #0
    STA z:0x19, X
    LDA #3
    STA z:0x3D, X
    REP #0x20
    LDA #addr(sub_C67BF3)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C67BF3)
    STA z:2, X

sub_C67BE6:
    JSL fast_random
    SEP #0x20
    AND #0x3F
    ORA #0xC0
    STA z:0x30, X
    RTL

sub_C67BF3:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C67C00
    JML kill_enemy

.loc_C67C00:
    BIT #0x90
    BEQ .loc_C67C08
    JML handler_early_exit

.loc_C67C08:
    BIT #0x41
    BEQ .loc_C67C10
    JML sub_C67C1A

.loc_C67C10:
    SEP #0x20
    DEC z:0x30, X
    BEQ sub_C67C34
    JSL random_wanderer_movement

sub_C67C1A:
    JSL handle_enemy_damage
    BCC .loc_C67C24
    JML kill_enemy

.loc_C67C24:
    REP #0x20
    LDA #0xC0C
    STA z:0x40
    JSL sub_C634FC
    JSL advance_animation
    RTL

sub_C67C34:
    REP #0x20
    LDA #addr(byte_C653D7)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(.loc_C67C52)
    STA z:0, X
    SEP #0x20
    LDA #bank(.loc_C67C52)
    STA z:2, X

.loc_C67C52:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C67C5F
    JML kill_enemy

.loc_C67C5F:
    BIT #0x90
    BEQ .loc_C67C67
    JML handler_early_exit

.loc_C67C67:
    BIT #0x41
    BEQ .loc_C67C6F
    JML sub_C67C1A

.loc_C67C6F:
    JSL sub_C67C1A
    BCC .locret_C67C93
    REP #0x20
    LDA #addr(byte_C65408)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(sub_C67C94)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C67C94)
    STA z:2, X

.locret_C67C93:
    RTL

sub_C67C94:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_UNKNOWN
    BEQ .loc_C67CA1
    JML kill_enemy

.loc_C67CA1:
    BIT #0x90
    BEQ .loc_C67CA9
    JML handler_early_exit

.loc_C67CA9:
    BIT #0x41
    BEQ .loc_C67CB1
    JML sub_C67C1A

.loc_C67CB1:
    JSL sub_C67C1A
    BCC sub_C67C34.locret_C67C93
    REP #0x20
    LDA #addr(byte_C65449)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(sub_C67CD6)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C67CD6)
    STA z:2, X
    RTL

sub_C67CD6:
i16
    JSL sub_C67C1A
    BCS .loc_C67CE0
    JML sub_C67C34.locret_C67C93

.loc_C67CE0:
    REP #0x20
    LDA #addr(byte_C653CE)
    STA z:0x50
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    REP #0x20
    LDA #addr(sub_C67BF3)
    STA z:0, X
    SEP #0x20
    LDA #bank(sub_C67BF3)
    STA z:2, X
    JSL sub_C67BE6
    RTL

off_C67D03:
    da byte_C63E7E, byte_C63E8F, byte_C63EB8, byte_C63EE5
off_C67D0B:
    da byte_C64032, byte_C6403B, byte_C64044, byte_C6404D
off_C67D13:
    da byte_C641BE, byte_C641CF, propene_animation, byte_C641F1
off_C67D1B:
    da byte_C64386, byte_C643A7, byte_C643C8, byte_C643E9
off_C67D23:
    da byte_C6448A, byte_C6448A, byte_C6448A, byte_C6448A
off_C67D2B:
    da byte_C6456B, byte_C6457C, byte_C6458D, byte_C6459E
off_C67D33:
    da byte_C647BE, byte_C647C7, byte_C647D0, byte_C647D9
off_C67D3B:
    da byte_C647E2, byte_C647E7, byte_C647EC, byte_C647F1
off_C67D43:
    da byte_C64910, byte_C64910, byte_C64910, byte_C64910
off_C67D4B:
    da byte_C649D1, byte_C649EA, byte_C64A13, byte_C64A5C
off_C67D53:
    da byte_C64AFC, byte_C64AFC, byte_C64AFC, byte_C64AFC
off_C67D5B:
    da byte_C64C51, byte_C64C76, byte_C64C9F, byte_C64CC4
off_C67D63:
    da byte_C64894, byte_C6489D, byte_C648A6, byte_C648AF
off_C67D6B:
    da byte_C64E3D, byte_C64E4E, byte_C64E6F, byte_C64E90
off_C67D73:
    da byte_C65016, byte_C65027, byte_C65038, byte_C65049
off_C67D7B:
    da byte_C65236, byte_C6525F, byte_C6528C, byte_C652B9
off_C67D83:
    da byte_C653CE, byte_C653CE, byte_C653CE, byte_C653CE
off_C67D8B:
    da byte_C654D6, byte_C654D6, byte_C654D6, byte_C654D6
off_C67D93:
    da byte_C656F7, byte_C6571C, byte_C65739, byte_C6575E
off_C67D9B:
    da byte_C657E1, byte_C657E1, byte_C657E1, byte_C657E1
off_C67DA3:
    da byte_C65842, byte_C65842, byte_C65842, byte_C65842
off_C67DAB:
    da denkyun_animation, denkyun_animation, denkyun_animation, denkyun_animation
data_end
