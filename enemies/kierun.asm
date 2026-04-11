create_kierun:
    STY z:0x56
    SEP #0x20
    create_enemy kierun_init
    init_enemy 1
    allocate_object_graphics kierun_graphics, 2
    allocate_object_palette KIERUN_PALETTE
    RTL

kierun_init:
    set_enemy_animations kierun_animations
    REP #0x20
    start_animation #addr(kierun_animation)
    SEP #0x20
    LDA #0x40
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 800
    set_handler kierun
    ; Fallthrough
sub_C67BE6:
    JSL fast_random
    SEP #0x20
    AND #0x3F
    ORA #0xC0
    STA z:0x30, X
    RTL

kierun:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_KILL_ENEMIES
    BEQ .loc_C67C00
    JML kill_enemy

.loc_C67C00:
    BIT #GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_SCREEN_TRANSITION
    BEQ .loc_C67C08
    JML handler_early_exit

.loc_C67C08:
    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
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
    LDA #0xC0C ; Set .X_LIMIT and .Y_LIMIT to 12
    STA z:enemy_hit_players_in_centered_range.Y_LIMIT
    JSL enemy_hit_players_in_centered_range
    JSL render_sprite_animated
    RTL

sub_C67C34:
    REP #0x20
    start_animation #addr(kierun_disappearing_animation)
    set_handler .loc_C67C52

.loc_C67C52:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_KILL_ENEMIES
    BEQ .loc_C67C5F
    JML kill_enemy

.loc_C67C5F:
    BIT #GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_SCREEN_TRANSITION
    BEQ .loc_C67C67
    JML handler_early_exit

.loc_C67C67:
    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
    BEQ .loc_C67C6F
    JML sub_C67C1A

.loc_C67C6F:
    JSL sub_C67C1A
    BCC .locret_C67C93
    REP #0x20
    start_animation #addr(kierun_hidden_animation)
    set_handler sub_C67C94

.locret_C67C93:
    RTL

sub_C67C94:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_KILL_ENEMIES
    BEQ .loc_C67CA1
    JML kill_enemy

.loc_C67CA1:
    BIT #GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_SCREEN_TRANSITION
    BEQ .loc_C67CA9
    JML handler_early_exit

.loc_C67CA9:
    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
    BEQ .loc_C67CB1
    JML sub_C67C1A

.loc_C67CB1:
    JSL sub_C67C1A
    BCC sub_C67C34.locret_C67C93
    REP #0x20
    start_animation #addr(kierun_appearing_animation)
    set_handler sub_C67CD6
    RTL

sub_C67CD6:
i16
    JSL sub_C67C1A
    BCS .loc_C67CE0
    JML sub_C67C34.locret_C67C93

.loc_C67CE0:
    REP #0x20
    start_animation #addr(kierun_animation)
    set_handler kierun
    JSL sub_C67BE6
    RTL
