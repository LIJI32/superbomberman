create_missile:
    REP #0x20
    STY z:0x56
    SEP #0x20
    create_enemy missile_init
    LDA #0
    STA a:enemy.hitpoints_left, Y
    LDA #2
    STA a:0x20, Y
    TXA
    STA a:0x38, Y
    INC z:0x30, X
    PHX
    LDA z:0x34, X
    TAX
    LDA z:enemy.x_position, X
    PLX
    SEC
    SBC #0x88
    EOR #0xFFFF
    INC A
    CLC
    ADC #0x88
    STA a:enemy.x_position, Y
    LDA #0x40
    STA a:enemy.y_position, Y
    REP #0x20
    LDA #addr(enemy_creation_functions)
    STA a:enemy.creation_functions_array_ptr, Y
    SEP #0x20
    LDA #bank(enemy_creation_functions)
    STA a:enemy.creation_functions_array_ptr + 2, Y
    SEP #0x20
    LDA #1
    STA a:3, Y
    LDA #0x30
    STA a:enemy.palette, Y
    LDA #8
    STA a:enemy.graphics_slot, Y
    LDA #0xC
    STA a:enemy.effective_palette, Y
    LDA #0xC
    STA a:enemy.real_palette, Y
    LDA #0
    STA a:enemy.carried_bonus, Y
    LDA #0
    STA a:enemy.flags, Y
    RTL

missile_init:
    set_enemy_animations missile_animations
    REP #0x20
    LDA #0
    STA z:enemy.hitpoints_left, X
    start_animation #addr(missile_animation_down)
    SEP #0x20
    LDA #0x10
    STA z:0x30, X
    LDA #0
    STA z:enemy.speed, X
    LDA #DIR_DOWN
    STA z:enemy.direction, X
    set_handler missile
    ; Fallthrough

missile:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_KILL_ENEMIES
    BEQ .loc_C66D0C
    JML kill_enemy

.loc_C66D0C:
    BIT #GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_SCREEN_TRANSITION
    BEQ .loc_C66D14
    JML handler_early_exit

.loc_C66D14:
    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
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
    LDA a:0x32, Y
    DEC A
    STA a:0x32, Y
    JMP a:.loc_C66DE1
    STY z:0x56
    SEP #0x20
    create_enemy .loc_C66DE1
    init_enemy 1
    allocate_object_graphics missile_graphics, 2
    allocate_object_palette MISSILE_PALETTE
    REP #0x20
    TYA
    STA a:0x38, Y
    RTL

.loc_C66DE1:
    set_enemy_animations missile_animations
    REP #0x20
    start_animation #addr(missile_animation_down)
    SEP #0x20
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 400
    set_handler .loc_C66E1E

.loc_C66E1E:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_KILL_ENEMIES
    BEQ .loc_C66E2B
    JML kill_enemy

.loc_C66E2B:
    BIT #GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_SCREEN_TRANSITION
    BEQ .loc_C66E33
    JML handler_early_exit

.loc_C66E33:
    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
    BEQ .loc_C66E3B
    JML .loc_C66E56

.loc_C66E3B:
    JSL missile_movement
    JSL handle_enemy_damage
    BCC .loc_C66E56
    SEP #0x20
    PHY
    LDY z:0x38, X
    LDA a:0x30, Y
    DEC A
    STA a:0x30, Y
    PLY
    JML kill_enemy

.loc_C66E56:
    REP #0x20
    LDA #0xC0C ; Set .X_LIMIT and .Y_LIMIT to 12
    STA z:enemy_hit_players_in_centered_range.Y_LIMIT
    JSL enemy_hit_players_in_centered_range
    JSL render_sprite_animated
    RTL
