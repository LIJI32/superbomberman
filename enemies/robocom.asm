create_robocom:
    STY z:0x56
    SEP #0x20
    create_enemy robocom_init
    init_enemy 3
    allocate_object_graphics robocom_graphics, 3
    allocate_object_palette ROBOCOM_PALETTE
    RTL

robocom_init:
    set_enemy_animations robocom_animations
    REP #0x20
    LDA #0xE0
    STA z:0x1C, X
    start_animation #addr(robocom_animation_down)
    SEP #0x20
    LDA #0x30
    STA z:enemy.palette, X
    LDA #1
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 800
    set_handler robocom
    ; Fallthrough

robocom:
    basic_enemy follower_movement
