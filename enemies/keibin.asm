create_keibin:
    STY z:0x56
    SEP #0x20
    create_enemy keibin_init
    init_enemy 3
    allocate_object_graphics keibin_graphics, 2
    allocate_object_palette KEIBIN_PALETTE
    RTL

keibin_init:
    set_enemy_animations keibin_animations
    REP #0x20
    start_animation #addr(keibin_animation)
    SEP #0x20
    LDA #0x40
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 400
    STZ z:0x30, X
    set_handler keibin
    ; Fallthrough

keibin:
    basic_enemy random_wanderer_movement
