; Note: despite its internal functions not being shared with other enemies, they're not grouped together with Pakupa's main code

create_pakupa:
    STY z:0x56
    SEP #0x20
    create_enemy pakupa_init
    init_enemy 3
    allocate_object_graphics pakupa_graphics, 3
    allocate_object_palette PAKUPA_PALETTE
    RTL

pakupa_init:
    set_enemy_animations pakupa_animations
    REP #0x20
    start_animation #addr(pakupa_animation_down)
    SEP #0x20
    LDA #0x30
    STA z:enemy.palette, X
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 400
    set_handler pakupa
    ; Fallthrough

pakupa:
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

    JSL pakupa_movement
    JSL handle_enemy_damage
    BCC +
    JML kill_enemy ; Hitpoints reached 0
+
    JSL replace_bomb_with_hard_block
    
.render_and_hit_players
    REP #0x20
    LDA #0xC0C ; Set .X_LIMIT and .Y_LIMIT to 12
    STA z:enemy_hit_players_in_centered_range.Y_LIMIT
    JSL enemy_hit_players_in_centered_range
    JSL render_sprite_animated
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
