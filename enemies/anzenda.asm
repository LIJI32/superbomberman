create_anzenda:
    STY z:0x56
    SEP #0x20
    create_enemy anzenda_init
    init_enemy 2
    allocate_object_graphics anzenda_graphics, 2
    allocate_object_palette ANZENDA_PALETTE
    RTL

anzenda_init:
    set_enemy_animations anzenda_animations
    REP #0x20
    start_animation #addr(anzenda_animation_down)
    SEP #0x20
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 800
    STZ z:0x30, X
    set_handler anzenda
    ; Fallthrough

anzenda:
    basic_enemy wanderer_movement
