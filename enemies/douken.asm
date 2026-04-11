create_douken:
    STY z:0x56
    SEP #0x20
    create_enemy douken_init
    init_enemy 1
    allocate_object_graphics douken_graphics, 1
    allocate_object_palette DOUKEN_PALETTE
    RTL

douken_init:
    set_enemy_animations douken_animations
    REP #0x20
    start_animation #addr(douken_animation)
    SEP #0x20
    LDA #0x30
    STA z:enemy.palette, X
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 100
    STZ z:0x30, X
    set_handler douken
    ; Fallthrough

douken:
    basic_enemy wanderer_movement
