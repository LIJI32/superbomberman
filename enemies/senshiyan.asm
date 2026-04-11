create_senshiyan:
    STY z:0x56
    SEP #0x20
    create_enemy senshiyan_init
    init_enemy 3
    allocate_object_graphics senshiyan_graphics, 3
    allocate_object_palette SENSHIYAN_PALETTE
    RTL

senshiyan_init:
    set_enemy_animations senshiyan_animations
    REP #0x20
    LDA #0
    STA z:0x34, X
    start_animation #addr(senshiyan_animation_down)
    SEP #0x20
    LDA #3
    STA z:enemy.hits_left_for_direction_switch, X
    LDA #0xFF
    STA z:enemy.animation_direction, X
    LDA #0
    STA z:enemy.speed, X
    set_enemy_score 1600
    JSL create_senshiyan_part
    set_handler senshiyan
    ; fallthrough

sub_C65B4D:
    JSL fast_random
    REP #0x20
    AND #0xFF
    CLC
    ADC #0x40
    STA z:0x30, X
    RTL

senshiyan:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_KILL_ENEMIES
    BEQ .loc_C65B6A
    JML kill_enemy

.loc_C65B6A:
    BIT #GAME_FLAGS_BATTLE_MENU | GAME_FLAGS_SCREEN_TRANSITION
    BEQ .loc_C65B72
    JML handler_early_exit

.loc_C65B72:
    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
    BEQ .loc_C65B7A
    JML .loc_C65B9F

.loc_C65B7A:
    REP #0x20
    LDA z:0x34, X
    BNE .loc_C65BAF
    JSL wanderer_movement
    JSL handle_enemy_damage
    BCC .loc_C65B8E
    JML kill_enemy

.loc_C65B8E:
    REP #0x20
    DEC z:0x30, X
    BNE .loc_C65B9F
    LDA #0x81
    STA z:0x34, X
    JSL sub_C65B4D
    BRA .loc_C65BAF
.loc_C65B9F:
    REP #0x20
    LDA #0xC0C ; Set .X_LIMIT and .Y_LIMIT to 12
    STA z:enemy_hit_players_in_centered_range.Y_LIMIT
    JSL enemy_hit_players_in_centered_range
    JSL render_sprite_animated
    RTL

.loc_C65BAF:
    JSL handle_enemy_damage
    BCC .loc_C65BB9
    JML kill_enemy

.loc_C65BB9:
    REP #0x20
    DEC z:0x34, X
    LDA #0xC0C ; Set .X_LIMIT and .Y_LIMIT to 12
    STA z:enemy_hit_players_in_centered_range.Y_LIMIT
    JSL enemy_hit_players_in_centered_range
    JSL render_sprite
    RTL

sub_C65BCB:
    REP #0x20
    LDA z:enemy.x_position, X
    PHA
    LDA z:enemy.y_position, X
    PHA
    LDA z:enemy.animation_direction, X
    AND #0xFF
    CMP #0xFF
    BNE .loc_C65BE0
    LDA #2

.loc_C65BE0:
    ASL A
    PHX
    TAX
    LDA f:unk_C65EB9, X
    PLX
    SEP #0x20
    CLC
    ADC z:enemy.x_position, X
    STA z:enemy.x_position, X
    XBA
    CLC
    ADC z:enemy.y_position, X
    STA z:enemy.y_position, X
    STZ z:0x32, X
    JSL sub_C65D5E
    REP #0x20
    PLA
    STA z:enemy.y_position, X
    PLA
    STA z:enemy.x_position, X
    RTL

create_senshiyan_part:
    SEP #0x20
    create_object sub_C65C3B
    BCC .loc_C65C20
    JML create_enemy_ret

.loc_C65C20:
    REP #0x20
    LDA z:enemy.palette, X
    STA a:enemy.palette, Y
    LDA z:enemy.effective_palette, X
    STA a:enemy.effective_palette, Y
    LDA z:enemy.x_position, X
    STA a:enemy.x_position, Y
    LDA z:enemy.y_position, X
    STA a:enemy.y_position, Y
    TXA
    STA a:0x34, Y
    RTL

sub_C65C3B:
    REP #0x20
    start_animation #addr(some_senshinya_animation_4)
    set_handler sub_C65C59
    ; fallthrough

sub_C65C59:
    SEP #0x20
    LDY z:0x34, X
    LDA a:enemy.direction, Y
    STA z:enemy.direction, X
    LDA a:enemy.animation_direction, Y
    STA z:enemy.animation_direction, X
    REP #0x20
    LDA a:enemy.x_position, Y
    STA z:enemy.x_position, X
    LDA a:enemy.y_position, Y
    STA z:enemy.y_position, X
    LDA a:0, Y
    BNE .loc_C65C7C
    JML delete_object

.loc_C65C7C:
    LDA a:0x34, Y
    CMP #0x80
    BNE .loc_C65C9B
    SEP #0x20
    LDA #0xFF
    STA z:0x23, X
    LDA #9
    STA z:0x24, X
    set_handler sub_C65CC2

.loc_C65C9B:
    SEP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_SCREEN_TRANSITION
    BNE .locret_C65CC1
    SEP #0x20
    LDA z:enemy.animation_direction, X
    CMP #0xFF
    BNE .loc_C65CAE
    LDA #2

.loc_C65CAE:
    ASL A
    STA z:enemy.current_frame, X
    REP #0x20
    LDA z:enemy.y_position, X
    PHA
    INC z:enemy.y_position, X
    JSL render_sprite
    REP #0x20
    PLA
    STA z:enemy.y_position, X

.locret_C65CC1:
    RTL

sub_C65CC2:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ .loc_C65CD7
    JML .loc_C65D03

.loc_C65CD7:
    REP #0x20
    LDY z:0x34, X
    LDA a:0, Y
    BNE .loc_C65CE4
    JML delete_object

.loc_C65CE4:
    SEP #0x20
    LDA z:enemy.current_frame, X
    CMP z:0x23, X
    BEQ .loc_C65D03
    STA z:0x23, X
    DEC z:0x24, X
    BNE .loc_C65D03
    LDA #0x20
    STA z:0x23, X
    set_handler sub_C65D14

.loc_C65D03:
    REP #0x20
    LDA z:enemy.y_position, X
    PHA
    INC z:enemy.y_position, X
    JSL render_sprite_animated
    REP #0x20
    PLA
    STA z:enemy.y_position, X
    RTL

sub_C65D14:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ .loc_C65D29
    JML .loc_C65D4D

.loc_C65D29:
    REP #0x20
    LDY z:0x34, X
    LDA a:0, Y
    BNE .loc_C65D36
    JML delete_object

.loc_C65D36:
    SEP #0x20
    DEC z:0x23, X
    BNE .loc_C65D4D
    JSL sub_C65BCB
    set_handler sub_C65C59

.loc_C65D4D:
    REP #0x20
    LDA z:enemy.y_position, X
    PHA
    INC z:enemy.y_position, X
    JSL render_sprite
    REP #0x20
    PLA
    STA z:enemy.y_position, X
    RTL

sub_C65D5E:
    SEP #0x20
    create_object sub_C65DB6
    BCC .loc_C65D7A
    JML create_enemy_ret

.loc_C65D7A:
    SEP #0x20
    LDA a:3, Y
    AND #0xFE
    STA a:3, Y
    LDA z:enemy.animation_direction, X
    CMP #0xFF
    BNE .loc_C65D8C
    LDA #2

.loc_C65D8C:
    STA a:0x22, Y
    LDA z:0x32, X
    STA a:0x32, Y
    LDA #4
    STA a:0x1E, Y
    REP #0x20
    LDA z:0x34, X
    STA a:0x34, Y
    LDA z:enemy.palette, X
    STA a:enemy.palette, Y
    LDA z:enemy.x_position, X
    STA a:enemy.x_position, Y
    LDA z:enemy.y_position, X
    STA a:enemy.y_position, Y
    LDA #0
    STA a:0x30, Y
    RTL

sub_C65DB6:
    REP #0x20
    LDY z:0x34, X
    LDA a:0, Y
    BNE .loc_C65DC3
    JML delete_object

.loc_C65DC3:
    LDA z:0x32, X
    AND #0xFE
    STA z:0x40
    ASL z:0x40
    PHX
    TAX
    LDA f:some_senshiyan_animations, X
    STA z:0x50
    PLX
    LDA z:enemy.animation_direction, X
    AND #0xFF
    ASL A
    ASL A
    ASL A
    ASL A
    CLC
    ADC z:0x40
    PHX
    TAX
    LDA f:unk_C65EC1, X
    ASL A
    ASL A
    STA z:0x40
    LDA f:unk_C65EC3, X
    ASL A
    ASL A
    PLX
    STA z:enemy.animations + 2, X
    LDA z:0x40
    STA z:enemy.animations, X
    SEP #0x20
    PHK
    PLA
    STA z:0x52
    JSL start_animation
    set_handler .loc_C65E0F

.loc_C65E0F:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ .loc_C65E24
    JML .loc_C65E84

.loc_C65E24:
    REP #0x20
    LDY z:0x34, X
    LDA a:0, Y
    BNE .loc_C65E31
    JML delete_object

.loc_C65E31:
    INC z:0x30, X
    LDA z:0x30, X
    CMP #0x40
    BNE .loc_C65E3E
    JML delete_object

.loc_C65E3E:
    CMP #7
    BCS .loc_C65E84
    CMP #6
    BNE .loc_C65E56
    SEP #0x20
    INC z:0x32, X
    LDA z:0x32, X
    CMP #6
    BEQ .loc_C65E84
    JSL sub_C65D5E

.loc_C65E56:
    REP #0x20
    STZ z:0x40
    LDA z:enemy.animations, X
    BPL .loc_C65E60
    DEC z:0x40

.loc_C65E60:
    CLC
    ADC z:enemy.fractional_x, X
    STA z:enemy.fractional_x, X
    SEP #0x20
    LDA z:0x40
    ADC z:enemy.x_position + 1, X
    STA z:enemy.x_position + 1, X
    REP #0x20
    STZ z:0x40
    LDA z:enemy.animations + 2, X
    BPL .loc_C65E77
    DEC z:0x40

.loc_C65E77:
    CLC
    ADC z:enemy.fractional_y, X
    STA z:enemy.fractional_y, X
    SEP #0x20
    LDA z:0x40
    ADC z:enemy.y_position + 1, X
    STA z:enemy.y_position + 1, X

.loc_C65E84:
    REP #0x20
    LDA z:0x12, X
    ORA z:0x15, X
    AND #0xFF
    BNE .loc_C65E98
    LDA #0x404
    STA z:0x40
    JSL enemy_hit_players_in_centered_range

.loc_C65E98:
    REP #0x20
    LDA z:enemy.y_position, X
    PHA
    LDA z:enemy.animation_direction, X
    AND #0xFF
    CMP #2
    BNE .loc_C65EAF
    LDA z:enemy.y_position, X
    CLC
    ADC #0x10
    STA z:enemy.y_position, X

.loc_C65EAF:
    JSL render_sprite_animated
    REP #0x20
    PLA
    STA z:enemy.y_position, X
    RTL

unk_C65EB9:
    db 0
    db 0xF0
    db 8
    db 0xF0
    db 0
    db 0xF0
    db 0xF8
    db 0xF0
unk_C65EC1:
    db 0
    db 0
unk_C65EC3:
    db 0xC0
    db 0xFF
    db 0
    db 0
    db 0x80
    db 0xFF
    db 0
    db 0
    db 0x60
    db 0xFF
    db 0
    db 0
    db 0
    db 0
    db 0x40
    db 0
    db 0x40
    db 0
    db 0x80
    db 0
    db 0x20
    db 0
    db 0xA0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0x40
    db 0
    db 0
    db 0
    db 0x80
    db 0
    db 0
    db 0
    db 0xA0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0xC0
    db 0xFF
    db 0x40
    db 0
    db 0x80
    db 0xFF
    db 0x20
    db 0
    db 0x60
    db 0xFF
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
some_senshiyan_animations:
    da some_senshinya_animation_1, some_senshinya_animation_2, some_senshinya_animation_3
