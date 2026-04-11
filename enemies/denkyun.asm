create_denkyun:
    STY z:0x56
    SEP #0x20
    create_enemy denkyun_init
    init_enemy 2
    allocate_object_graphics denkyun_graphics, 1
    allocate_object_palette DENKYUN_PALETTE
    RTL

denkyun_init:
    REP #0x20
    LDA #addr(denkyun_animations)
    STA z:object.handler+0x16, X
    SEP #0x20
    LDA #bank(denkyun_animations)
    STA z:object.handler+0x18, X
    REP #0x20
    start_animation #addr(denkyun_animation)
    SEP #0x20
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 400
    STZ z:0x30, X
    set_handler denkyun
    ; Fallthrough

denkyun:
    basic_enemy wanderer_movement
