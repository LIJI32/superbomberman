create_metal_kuwagen:
    i16
    STY z:0x56
    SEP #0x20
    create_enemy kuwagen_init
    init_enemy 2
    allocate_object_graphics kuwagen_graphic_pointers, 2
    allocate_object_palette METAL_KUWAGEN_PALETTE
    RTL

create_kuwagen:
    STY z:0x56
    SEP #0x20
    create_object kuwagen_init
    REP #0x20
    BCS create_enemy_ret
    init_enemy 1
    allocate_object_graphics kuwagen_graphic_pointers, 2
    allocate_object_palette KUWAGEN_PALETTE
create_enemy_ret:
    RTL

kuwagen_init:
    REP #0x20
    LDA #0
    STA z:0x30, X
    start_animation #addr(kuwagen_animation_down)
    set_enemy_animations kuwagen_animations
    SEP #0x20
    set_enemy_score 400
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_handler kuwagen
    ; Fallthrough

kuwagen:
    basic_enemy kuwagen_movement
