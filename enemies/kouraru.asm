create_kouraru:
    STY z:0x56
    SEP #0x20
    create_enemy kouraru_init
    init_enemy 1
    allocate_object_graphics kouraru_graphics, 3
    allocate_object_palette KOURARU_PALETTE
    RTL

kouraru_init:
    set_enemy_animations kouraru_animations
    REP #0x20
    start_animation #addr(kouraru_animation)
    SEP #0x20
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 200
    STZ z:0x30, X
    set_handler kouraru
    ; Fallthrough

kouraru:
    basic_enemy wanderer_movement
