create_banen:
    STY z:0x56
    SEP #0x20
    create_enemy banen_init
    init_enemy 1
    allocate_object_graphics banen_graphics, 2
    allocate_object_palette BANEN_PALETTE
    RTL

banen_init:
    set_enemy_animations banen_animations
    REP #0x20
    start_animation #addr(banen_animation_down)
    SEP #0x20
    LDA #0x30
    STA z:enemy.palette, X
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 200
    set_handler banen
    ; Fallthrough

banen:
    basic_enemy wanderer_movement2
