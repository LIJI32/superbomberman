create_metal_u:
    STY z:0x56
    SEP #0x20
    create_enemy metal_u_init
    init_enemy 2
    allocate_object_graphics metal_u_graphics, 1
    allocate_object_palette METAL_U_PALETTE
    RTL

metal_u_init:
    set_enemy_animations metal_u_animations
    REP #0x20
    LDA #BOMB|SOFT_BLOCK|HARD_BLOCK
    STA z:enemy.collision_mask, X
    start_animation #addr(metal_u_animation)
    SEP #0x20
    LDA #0x30
    STA z:enemy.palette, X
    LDA #1
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 3200
    set_handler metal_u
    ; Fallthrough

metal_u:
    basic_enemy follower_movement
