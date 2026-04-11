create_propene:
    STY z:0x56
    SEP #0x20
    create_enemy propene_init
    init_enemy 1
    allocate_object_graphics propene_graphics, 2
    allocate_object_palette PROPENE_PALETTE
    RTL

propene_init:
    REP #0x20
    LDA #addr(propene_animations)
    STA z:object.handler+0x16, X
    SEP #0x20
    LDA #bank(propene_animations)
    STA z:object.handler+0x18, X
    REP #0x20
    start_animation #addr(propene_animation_down)
    SEP #0x20
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 100
    STZ z:enemy.field_30, X
    set_handler propene
    ; Fallthrough

propene:
    basic_enemy wanderer_movement
