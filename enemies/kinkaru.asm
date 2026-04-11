create_kinkaru:
    STY z:0x56
    SEP #0x20
    create_enemy kinkaru_init
    init_enemy 1
    allocate_object_graphics kinkaru_graphics, 2
    allocate_object_palette KINKARU_PALETTE
    RTL

kinkaru_init:
    set_enemy_animations kinkaru_animations
    REP #0x20
    LDA #0xA0
    STA z:0x1C, X
    start_animation #addr(kinkaru_animation)
    SEP #0x20
    LDA #0x30
    STA z:enemy.palette, X
    LDA #1
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #3
    STA z:enemy.speed, X
    set_enemy_score 1600
    set_handler kinkaru
    ; Fallthrough

kinkaru:
    basic_enemy follower_movement
