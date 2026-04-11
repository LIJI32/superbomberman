create_yoroisu:
    STY z:0x56
    SEP #0x20
    create_enemy yoroisu_init
    init_enemy 8
    allocate_object_graphics yoroisu_graphics, 6
    allocate_object_palette YOROISU_PALETTE
    RTL

yoroisu_init:
    REP #0x20
    start_animation #addr(yoroisu_animation_down)
    set_enemy_animations yoroisu_animations
    SEP #0x20
    LDA #0x30
    STA z:enemy.palette, X
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 3200
    set_handler yoroisu
    ; Fallthrough

yoroisu:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_KILL_ENEMIES
    BEQ .loc_C6687F
    JML kill_enemy

.loc_C6687F:
    BIT #GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_SCREEN_TRANSITION
    BEQ .loc_C66887
    JML handler_early_exit

.loc_C66887:
    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
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
    LDA #0xC0C ; Set .X_LIMIT and .Y_LIMIT to 12
    STA z:enemy_hit_players_in_centered_range.Y_LIMIT
    JSL enemy_hit_players_in_centered_range
    JSL render_sprite_animated
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
    LDA f:yoroisu_shield_animations, X
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