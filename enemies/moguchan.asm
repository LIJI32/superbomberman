create_moguchan:
    STY z:0x56
    SEP #0x20
    create_enemy moguchan_init
    init_enemy 1
    allocate_object_graphics moguchan_graphics, 3
    allocate_object_palette MOGUCHAN_PALETTE
    RTL

moguchan_init:
    set_enemy_animations moguchan_animations
    REP #0x20
    LDA #0xE0
    STA z:0x1C, X
    start_animation #addr(moguchan_animation_down)
    SEP #0x20
    LDA #0x30
    STA z:enemy.palette, X
    LDA #1
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 400
    JSL fast_random
    REP #0x20
    AND #0xFF
    CLC
    ADC #0x400
    STA z:0x30, X
    set_handler moguchan
    ; fallthrough

moguchan:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_KILL_ENEMIES
    BEQ .loc_C67713
    JML kill_enemy

.loc_C67713:
    BIT #GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_SCREEN_TRANSITION
    BEQ .loc_C6771B
    JML handler_early_exit

.loc_C6771B:
    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
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
    LDA #0xC0C ; Set .X_LIMIT and .Y_LIMIT to 12
    STA z:enemy_hit_players_in_centered_range.Y_LIMIT
    JSL enemy_hit_players_in_centered_range
    JSL render_sprite_animated
    RTL

.loc_C67747:
    JSL fast_random
    SEP #0x20
    AND #0x1F
    CLC
    ADC #0x60
    STA z:0x30, X
    REP #0x20
    start_animation #addr(moguchan_animation_dig_in)
    set_handler .loc_C67772

.loc_C67772:
    JSL render_sprite_animated
    BCC .locret_C67785
    set_handler sub_C67786

.locret_C67785:
    RTL

sub_C67786:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ .loc_C6779B
    JML moguchan.locret_C67785

.loc_C6779B:
    REP #0x20
    DEC z:0x30, X
    BNE moguchan.locret_C67785
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
    start_animation #addr(moguchan_animation_dig_out)
    set_handler .loc_C677EC

.loc_C677EC:
    JSL render_sprite_animated
    BCS .loc_C677F6
    JML moguchan.locret_C67785

.loc_C677F6:
    JSL fast_random
    SEP #0x20
    AND #0x3F
    ORA #0xC0
    STA z:0x30, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    REP #0x20
    start_animation #addr(moguchan_animation_down)
    set_handler moguchan
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
