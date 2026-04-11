create_starnuts:
    STY z:0x56
    SEP #0x20
    create_enemy starnuts_init
    init_enemy 1
    allocate_object_graphics starnuts_graphics, 3
    allocate_object_palette STARNUTS_PALETTE
    RTL

starnuts_init:
    set_enemy_animations starnuts_animations
    REP #0x20
    start_animation #addr(starnuts_animation_down)
    SEP #0x20
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 200
    STZ z:0x30, X
    set_handler starnuts
    ; Fallthrough

starnuts:
    basic_enemy wanderer_movement
