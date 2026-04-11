create_chameleoman:
    STY z:0x56
    SEP #0x20
    create_enemy chameleoman_init
    init_enemy 1
    allocate_object_graphics chameleoman_graphics, 1
    allocate_object_palette CHAMELEOMAN_PALETTE
    RTL

chameleoman_init:
    set_enemy_animations player_animation_list+0x42
    REP #0x20
    LDA #0xE0
    STA z:0x1C, X
    REP #0x20
    start_animation_far warpping_animation
    SEP #0x20
    LDA z:enemy.effective_palette, X
    STA z:0x33, X
    LDA z:0xF, X
    STA z:0x34, X
    LDA #0x30
    STA z:enemy.palette, X
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    LDA #1
    STA z:0x31, X
    LDA #0
    STA z:0x32, X
    set_enemy_score 400
    set_handler chameleoman
    ; Fallthrough

sub_C669ED:
    JSL fast_random
    SEP #0x20
    AND #0x3F
    CLC
    ADC #0xC0
    STA z:0x30, X
    RTL

chameleoman:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_KILL_ENEMIES
    BEQ .loc_C66A08
    JML kill_enemy

.loc_C66A08:
    BIT #GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_SCREEN_TRANSITION
    BEQ .loc_C66A10
    JML handler_early_exit

.loc_C66A10:
    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
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
    LDA #0xC0C ; Set .X_LIMIT and .Y_LIMIT to 12
    STA z:enemy_hit_players_in_centered_range.Y_LIMIT
    JSL enemy_hit_players_in_centered_range
    JSL render_sprite_animated
.loc_C66A3F:
    JSL handle_enemy_damage
    BCS .loc_C66A49
    JML .locret_C66A6A

.loc_C66A49:
    SEP #0x20
    LDA z:0x33, X
    CMP z:enemy.effective_palette, X
    BNE .loc_C66A55
    JML kill_enemy

.loc_C66A55:
    LDA #0
    STA z:0x3E, X
    LDA #0x20
    STA z:0x3F, X
    set_handler .loc_C66A6B

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
    set_handler .loc_C66A93

.loc_C66A93:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_KILL_ENEMIES
    BEQ .loc_C66AA0
    JML kill_enemy

.loc_C66AA0:
    BIT #GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_SCREEN_TRANSITION
    BEQ .loc_C66AA8
    JML handler_early_exit

.loc_C66AA8:
    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
    BEQ .loc_C66AB0
    JML .loc_C66AC1

.loc_C66AB0:
    DEC z:0x3F, X
    BNE .loc_C66AC1
    set_handler .loc_C66AE3

.loc_C66AC1:
    REP #0x20
    LDA #0xC0C ; Set .X_LIMIT and .Y_LIMIT to 12
    STA z:enemy_hit_players_in_centered_range.Y_LIMIT
    JSL enemy_hit_players_in_centered_range
    JSL render_sprite
    SEP #0x20
    LDA #0xE
    STA z:enemy.effective_palette, X
    LDA z:0x3E, X
    EOR #1
    STA z:0x3E, X
    BEQ .locret_C66A6A
    LDA z:0x32, X
    STA z:enemy.effective_palette, X
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
    set_handler .loc_C66B29
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
    BIT #GAME_FLAGS_KILL_ENEMIES
    BEQ .loc_C66B36
    JML kill_enemy

.loc_C66B36:
    BIT #GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_SCREEN_TRANSITION
    BEQ .loc_C66B3E
    JML handler_early_exit

.loc_C66B3E:
    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
    BEQ .loc_C66B46
    JML .loc_C66A3F

.loc_C66B46:
    REP #0x20
    LDA #0xC0C ; Set .X_LIMIT and .Y_LIMIT to 12
    STA z:enemy_hit_players_in_centered_range.Y_LIMIT
    JSL enemy_hit_players_in_centered_range
    JSL render_sprite
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
    STA z:enemy.real_palette, X
    LDA #0
    STA z:0xF, X
    LDA #bank(player_animation_list)
    STA z:0x53 + 2
    LDY #1
    LDA f:[z:0xDB], Y
    STA z:0x36, X
    LDA f:[z:0xDB]
    BEQ .loc_C66BBB
    LDA z:0x33, X
    STA z:enemy.real_palette, X
    LDA z:0x34, X
    STA z:0xF, X
    LDA #bank(player_animation_list)
    STA z:0x53 + 2

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
    LDA z:0x53 + 2
    STA z:0x52
    JSL start_animation

.locret_C66BE5:
    RTL

.loc_C66BE6:
    SEP #0x20
    LDA #0xFF
    STA z:enemy.animation_direction, X
    set_handler chameleoman
    JMP a:chameleoman.loc_C66A3F

byte_C66BFC:
    db 0, 0x20, 1, 1, 0, 3, 1, 1
    db 0, 3, 1, 1, 0, 3, 1, 1
    db 0, 2, 1, 1, 0, 2, 1, 1
    db 0, 2, 1, 1, 0, 1, 1, 1
    db 0, 1, 1, 1, 0, 1, 1, 2
    db 0, 1, 1, 2, 0, 1, 1, 2
    db 0, 1, 1, 3, 0, 1, 1, 3
    db 0, 1, 1, 3, 0, 1, 1, 0x20