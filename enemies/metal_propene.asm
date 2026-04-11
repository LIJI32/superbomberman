create_metal_propene:
    STY z:0x56
    SEP #0x20
    create_enemy metal_propene_init
    init_enemy 5
    allocate_object_graphics metal_propene_graphics, 2
    allocate_object_palette METAL_PROPENE_PALETTE
    RTL

metal_propene_init:
    set_enemy_animations propene_animations
    REP #0x20
    ; Bug - this and Dengurin are the only enemies that face up instead of down if spawned trapped
    start_animation #addr(propene_animation_up)
    SEP #0x20
    LDA #0x40
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #2
    STA z:enemy.speed, X
    set_enemy_score 6400
    STZ z:0x30, X
    set_handler metal_propene
    ; Fallthrough

metal_propene:
    basic_enemy wanderer_movement
