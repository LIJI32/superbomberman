struct bakuda
    enemy
    org 0x38
.is_red_bomb:
    ds 1
    org 0x40
endstruct

create_red_bakuda:
    STY z:0x56
    SEP #0x20
    create_enemy bakuda_init
    LDA #1
    STA a:bakuda.is_red_bomb, Y
    init_enemy 1
    allocate_object_graphics bakuda_graphics, 2
    allocate_object_palette RED_BAKUDA_PALETTE
    RTL

create_bakuda:
    STY z:0x56
    SEP #0x20
    create_enemy bakuda_init
    LDA #0
    STA a:bakuda.is_red_bomb, Y
    init_enemy 1
    allocate_object_graphics bakuda_graphics, 2
    allocate_object_palette BAKUDA_PALETTE
    RTL

bakuda_init:
    set_enemy_animations bakuda_animations
    REP #0x20
    start_animation #addr(bakuda_animation_down)
    SEP #0x20
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 800
    set_handler bakuda
    ; Fallthrough
    
sub_C679BB:
    JSL fast_random
    SEP #0x20
    AND #0x3F
    ORA #0xC0
    STA z:0x30, X
    RTL

bakuda:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_KILL_ENEMIES
    BEQ .loc_C679D5
    JML kill_enemy

.loc_C679D5:
    BIT #GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_SCREEN_TRANSITION
    BEQ .loc_C679DD
    JML handler_early_exit

.loc_C679DD:
    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
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
    LDA #0xC0C ; Set .X_LIMIT and .Y_LIMIT to 12
    STA z:enemy_hit_players_in_centered_range.Y_LIMIT
    JSL enemy_hit_players_in_centered_range
    JSL render_sprite_animated
    RTL

.loc_C67A0B:
    JSL is_object_misaligned
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
    start_animation #addr(bakuda_sit_down_animation)
    set_handler .loc_C67A46

.loc_C67A46:
    JSL handle_enemy_damage
    BCC .loc_C67A50
    JML kill_enemy

.loc_C67A50:
    REP #0x20
    LDA #0xC0C ; Set .X_LIMIT and .Y_LIMIT to 12
    STA z:enemy_hit_players_in_centered_range.Y_LIMIT
    JSL enemy_hit_players_in_centered_range
    JSL render_sprite_animated
    BCS .loc_C67A65
    JML .locret_C67B10

.loc_C67A65:
    REP #0x20
    LDA z:0x26, X
    STA z:0x56
    start_animation #addr(bakuda_stand_up_animation)
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
    STA z:enemy.animation_direction, X
    PLA
    STA z:5, X
    set_handler .loc_C67AAD

.loc_C67AAD:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_KILL_ENEMIES
    BEQ .loc_C67ABA
    JML kill_enemy

.loc_C67ABA:
    BIT #GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_SCREEN_TRANSITION
    BEQ .loc_C67AC2
    JML handler_early_exit

.loc_C67AC2:
    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
    BEQ .loc_C67ACA
    JML .locret_C67B10

.loc_C67ACA:
    SEP #0x20
    DEC z:0x31, X
    BNE .locret_C67B10
    set_handler .loc_C67ADD

.loc_C67ADD:
    REP #0x20
    LDA #0xC0C ; Set .X_LIMIT and .Y_LIMIT to 12
    STA z:enemy_hit_players_in_centered_range.Y_LIMIT
    JSL enemy_hit_players_in_centered_range
    JSL render_sprite_animated
    BCC .locret_C67B10
    JSL sub_C679BB
    REP #0x20
    start_animation #addr(bakuda_animation_down)
    set_handler bakuda

.locret_C67B10:
    RTL
