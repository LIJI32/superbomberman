create_dengurin:
    STY z:0x56
    SEP #0x20
    create_enemy dengurin_init
    init_enemy 1
    allocate_object_graphics dengurin_graphics, 3
    allocate_object_palette DENGURIN_PALETTE
    RTL

dengurin_init:
    set_enemy_animations dengurin_animations
    REP #0x20
    ; Bug - this and Metal Propene are the only enemies that face up instead of down if spawned trapped
    start_animation #addr(dengurin_animation_up)
    SEP #0x20
    LDA #0x40
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0x40
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 400
    STZ z:0x30, X
    set_handler dengurin
    ; Fallthrough

dengurin:
    basic_enemy random_wanderer_movement
