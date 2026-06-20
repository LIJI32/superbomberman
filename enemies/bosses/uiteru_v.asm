struct uiteru_v
    enemy
    org 0x20
.orbit_angle
.shake_animation ; during defeat
    ds 1
    ds 1 ; padding
.base_v_scroll
    ds 2
    org 0x30
.countdown
    ds 2
.movement_countdown ; How many frames left before advancing orbit_angle
    ds 2
.poison_throw_countdown
    ds 2
.hitpoints
    ds 2
.spiderer
    ds 2
    org 0x3E
.death_countdown
    ds 2
    org enemy.sizeof
endstruct

struct uiteru_v_shadow
    enemy
    org 0x30
.countdown
    ds 2
.parent
    ds 2
    org enemy.sizeof
endstruct

uiteru_v_random_bonuses:
    dw FIRE_UP, FIRE_UP, EXTRA_TIME, HEART, HEART, PUNCH, PUNCH, PUNCH

uiteru_v_create_shadow:
    SEP #0x20
    create_object uiteru_v_shadow
    REP #0x20
    BCC +
    JML create_bonus_spawner.ret
+

    TXA
    STA a:uiteru_v_shadow.parent, Y
    LDA z:uiteru_v.x_position, X
    STA a:uiteru_v_shadow.x_position, Y
    LDA z:uiteru_v.y_position, X
    CLC
    ADC #0
    STA a:uiteru_v_shadow.y_position, Y
    LDA z:uiteru_v.countdown, X
    STA a:uiteru_v_shadow.countdown, Y
    RTL

uiteru_v_shadow:
i16
    REP #0x20
    LDA #0x410
    STA z:uiteru_v_shadow.object_priority, X
    LDA #8
    STA z:uiteru_v_shadow.effective_palette, X
    start_animation #addr(uiteru_v_shadow_animation)
    
    SEP #0x20
    LDY #7
    LDA #INTRO_BALOON_PALETTE
    STA z:0x40
    LDA #12
    JSL set_palette
    set_handler .main

.main:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ +
    JML .move_and_hit
+

    REP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_BATTLE_DELAY
    BEQ +
    JML delete_object
+

    LDA z:uiteru_v_shadow.countdown, X
    BEQ .move_and_hit
    DEC z:uiteru_v_shadow.countdown, X
    BRA .render
    
.move_and_hit:
    REP #0x20
    LDY z:uiteru_v_shadow.parent, X
    LDA a:uiteru_v.x_position, Y
    CLC
    ADC #0
    STA z:uiteru_v_shadow.x_position, X
    LDA a:uiteru_v.y_position, Y
    CLC
    ADC #24
    STA z:uiteru_v_shadow.y_position, X
    
    LDA #0x1010
    STA z:enemy_hit_players_in_range.RIGHT_LIMIT ; Set the left and right limits to 16
    LDA #0x2002
    STA z:enemy_hit_players_in_range.DOWN_LIMIT ; Set the down limit to 32, and up to 2
    JSL enemy_hit_players_in_range

.render:
    ; Render with with Y = 1 to force a lower priority
    REP #0x20
    LDA z:uiteru_v_shadow.y_position, X
    PHA
    LDA #1
    STA z:uiteru_v_shadow.y_position, X
    JSL render_sprite
    REP #0x20
    PLA
    STA z:uiteru_v_shadow.y_position, X
    RTL

create_uiteru_v:
    SEP #0x20
    create_object uiteru_v
    REP #0x20
    TXA
    STA a:uiteru_v.spiderer, Y
    LDA #0x430
    STA a:uiteru_v.object_priority, Y
    LDA #8
    STA a:uiteru_v.effective_palette, Y
    LDA z:uiteru_v.x_position, X
    STA a:uiteru_v.x_position, Y
    LDA z:uiteru_v.y_position, X
    STA a:uiteru_v.y_position, Y
    LDA #192
    STA a:uiteru_v.countdown, Y
    RTL

uiteru_v:
i16
    REP #0x20
    LDA #addr(uiteru_v_random_bonuses)
    STA z:create_bonus_spawner.BONUSES
    SEP #0x20
    LDA #bank(uiteru_v_random_bonuses)
    STA z:create_bonus_spawner.BONUSES + 2
    JSL create_bonus_spawner
    JSL uiteru_v_create_shadow
    
    REP #0x20
    LDA #0
    STA z:uiteru_v.orbit_angle, X
    LDA #0x10
    STA z:uiteru_v.movement_countdown, X
    LDA #256
    STA z:uiteru_v.poison_throw_countdown, X
    LDA #5
    STA z:uiteru_v.hitpoints, X
    set_handler .intro_raise
    
    SEP #0x20
    LDY #0 ; No fade
    LDA #UITERU_V_PALETTE
    STA z:set_palette.PALETTE
    LDA #3
    JSL set_palette
    
    LDA #MOOK_AND_CARET_BG_PALETTE
    STA z:set_palette.PALETTE
    LDA #4
    JSL set_palette
    
    LDA #POISON_PALETTE
    STA z:set_palette.PALETTE
    LDA #13
    JSL set_palette
    
    LDA #POISON_PALETTE
    STA z:set_palette.PALETTE
    LDA #12
    JSL set_palette
    
    REP #0x20
    LDA #addr(compressed_spiderer_tilemap+0xFC)
    STA z:tilemap_decompression.SOURCE
    SEP #0x20
    LDA #bank(compressed_spiderer_tilemap+0xFC)
    STA z:tilemap_decompression.SOURCE + 2
    JSL tilemap_decompression

    REP #0x20
    LDA #addr(uiteru_v_load_background)
    STA z:schedule_vblank_function.FUNCTION
    SEP #0x20
    LDA #bank(uiteru_v_load_background)
    STA z:schedule_vblank_function.FUNCTION + 2
    JSL schedule_vblank_function

.intro_raise:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ +
    JML .update_scroll
+

    REP #0x20
    LDA z:uiteru_v.fractional_y, X
    SEC
    SBC #0x20
    STA z:uiteru_v.fractional_y, X
    DEC z:uiteru_v.countdown, X
    BEQ +
    JML .update_scroll
+

    LDA #128
    STA z:uiteru_v.countdown, X
    set_handler .wait

.wait:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ +
    JML .update_scroll
+

    REP #0x20
    DEC z:uiteru_v.countdown, X
    BEQ +
    JML .update_scroll
+

    set_handler .main
    
.main:
    .ORBIT_TABLE = 0xDB
    .TEMP = 0x40
    .SIGN_EXT = 0x40
    .STEPS = 0x53
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ +
    JML .update_scroll
+

    REP #0x20
    LDA #addr(uiteru_v_orbit_table)
    STA z:.ORBIT_TABLE
    SEP #0x20
    LDA #bank(uiteru_v_orbit_table)
    STA z:.ORBIT_TABLE + 2
    REP #0x20
    DEC z:uiteru_v.movement_countdown, X
    BMI +
    JML .move
+

    JSL enemy_find_closest_player
    REP #0x20
    
    ; Back up some unused variable?
    LDA z:0x2A, X
    PHA
    
    JSL uiteru_v_calc_player_angle
    REP #0x20
    STA z:.TEMP
    
    ; And restore it
    PLA
    STA z:0x2A, X
    
    LDA z:.TEMP
    AND #0xF
    ASL A
    ASL A
    ASL A
    PHA
    
    JSL uiteru_v_calc_player_distance
    PLY
    INC z:uiteru_v.orbit_angle, X
    LDA z:uiteru_v.orbit_angle, X
    AND #0x1F
    ASL A
    ASL A
    PHX
    TAX
    LDA z:uiteru_v_calc_player_distance.X_DIST
    STA z:uiteru_v_multiply_velocity.TILE_DISTANCE
    LDA f:uiteru_v_orbit_table, X
    
    ; Absolute value
    BPL +
    EOR #0xFFFF
    INC A
+

    STA z:uiteru_v_multiply_velocity.ABS_VELOCITY
    LDA f:uiteru_v_orbit_table, X ; Current movement vector
    EOR f:[z:.ORBIT_TABLE], Y ; Vector towards the player
    BIT #0x8000
    BEQ + ; Same Direction?
    ; Wrong direction, scale velocity down
    LSR z:uiteru_v_multiply_velocity.ABS_VELOCITY
    LSR z:uiteru_v_multiply_velocity.ABS_VELOCITY
+

    JSL uiteru_v_multiply_velocity
    STA z:.STEPS
    LDA z:uiteru_v_calc_player_distance.Y_DIST
    STA z:uiteru_v_multiply_velocity.TILE_DISTANCE
    LDA f:uiteru_v_orbit_table+2, X
    ; Absolute value
    BPL +
    EOR #0xFFFF
    INC A
+

    STA z:uiteru_v_multiply_velocity.ABS_VELOCITY
    LDA f:uiteru_v_orbit_table+2, X ; Current movement vector
    INY
    INY
    EOR f:[z:.ORBIT_TABLE], Y ; Vector towards the player
    BIT #0x8000
    BEQ + ; Same Direction
    ; Wrong direction, scale velocity down
    LSR z:uiteru_v_multiply_velocity.ABS_VELOCITY
    LSR z:uiteru_v_multiply_velocity.ABS_VELOCITY
+

    JSL uiteru_v_multiply_velocity
    CLC
    ADC z:.STEPS
    LSR A
    ; Minimum steps
    CMP #2
    BPL +
    LDA #2
    BRA .set_steps
+

    ; Maximum steps
    CMP #24
    BCC .set_steps
    LDA #24

.set_steps:
    PLX
    STA z:uiteru_v.movement_countdown, X

.move:
    REP #0x20
    LDA z:uiteru_v.orbit_angle, X
    AND #0x1F
    ASL A
    ASL A
    TAY
    STZ z:.SIGN_EXT
    LDA f:[z:.ORBIT_TABLE], Y
    BPL +
    DEC z:.SIGN_EXT
+

    CLC
    ADC z:uiteru_v.fractional_x, X
    STA z:uiteru_v.fractional_x, X
    SEP #0x20
    LDA z:.SIGN_EXT
    ADC z:uiteru_v.x_position + 1, X
    STA z:uiteru_v.x_position + 1, X
    REP #0x20
    STZ z:.SIGN_EXT
    INY
    INY
    LDA f:[z:.ORBIT_TABLE], Y
    BPL +
    DEC z:.SIGN_EXT
+

    CLC
    ADC z:uiteru_v.fractional_y, X
    STA z:uiteru_v.fractional_y, X
    SEP #0x20
    LDA z:.SIGN_EXT
    ADC z:uiteru_v.y_position + 1, X
    STA z:uiteru_v.y_position + 1, X

    JSL uiteru_v_handle_bombs
    REP #0x20
    LDA z:uiteru_v_handle_bombs.WAS_HIT
    BEQ +
    LDY #SOUND_CRANE
    JSL play_sound
    set_handler uiteru_v_hit
+

    REP #0x20
    DEC z:uiteru_v.poison_throw_countdown, X
    BNE .update_scroll
    LDA #0x100
    STA z:uiteru_v.poison_throw_countdown, X
    LDA a:addr(number_of_visible_bonuses)
    CMP #32
    BCS .update_scroll
    JSL uiteru_v_create_poison_bonus
    REP #0x20
    BCC .update_scroll
    ; uiteru_v_create_poison_bonus failed, try again after half the time
    LDA #0x80
    STA z:uiteru_v.poison_throw_countdown, X
    
.update_scroll:
    REP #0x20
    LDA z:uiteru_v.x_position, X
    SEC
    SBC #120
    EOR #0xFFFF
    INC A
    CLC
    ADC #136
    STA a:addr(bg2_h_scroll)
    
    LDA z:uiteru_v.y_position, X
    SEC
    SBC #112
    EOR #0xFFFF
    INC A
    CLC
    ADC #136
    STA a:addr(bg2_v_scroll)
    RTL

uiteru_v_orbit_table:
    dw      0, -0x100
    dw   0x20,  -0xE0
    dw   0x40,  -0xC0
    dw   0x60,  -0xA0
    dw   0x80,  -0x80
    dw   0xA0,  -0x60
    dw   0xC0,  -0x40
    dw   0xE0,  -0x20
    dw  0x100,      0
    dw   0xE0,   0x20
    dw   0xC0,   0x40
    dw   0xA0,   0x60
    dw   0x80,   0x80
    dw   0x60,   0xA0
    dw   0x40,   0xC0
    dw   0x20,   0xE0
    dw      0,  0x100
    dw  -0x20,   0xE0
    dw  -0x40,   0xC0
    dw  -0x60,   0xA0
    dw  -0x80,   0x80
    dw  -0xA0,   0x60
    dw  -0xC0,   0x40
    dw  -0xE0,   0x20
    dw -0x100,      0
    dw  -0xE0,  -0x20
    dw  -0xC0,  -0x40
    dw  -0xA0,  -0x60
    dw  -0x80,  -0x80
    dw  -0x60,  -0xA0
    dw  -0x40,  -0xC0
    dw  -0x20,  -0xE0
    
uiteru_v_hit:
i16
    REP #0x20
    LDA #0x80
    STA z:uiteru_v.countdown, X
    REP #0x20
    LDA #addr(uiteru_v_hurt_tiles)
    STA z:schedule_vblank_function.PTR_ARG
    SEP #0x20
    LDA #bank(uiteru_v_hurt_tiles)
    STA z:schedule_vblank_function.PTR_ARG + 2
    REP #0x20
    LDA #addr(uiteru_v_vram_transfer)
    STA z:schedule_vblank_function.FUNCTION
    SEP #0x20
    LDA #bank(uiteru_v_vram_transfer)
    STA z:schedule_vblank_function.FUNCTION + 2
    JSL schedule_vblank_function
    set_handler .flash

.flash:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ +
    JML uiteru_v.update_scroll
+

    REP #0x20
    LDA z:uiteru_v.countdown, X
    AND #1
    PHX
    TAX
    LDA f:uiteru_v_bg_palettes, X
    STA z:set_palette.PALETTE
    PLX
    LDY #0
    LDA #3
    JSL set_palette
    
    REP #0x20
    DEC z:uiteru_v.countdown, X
    BNE .render
    DEC z:uiteru_v.hitpoints, X
    BNE +
    JML uiteru_v_die
+

    REP #0x20
    LDA #addr(uiteru_v_non_hurt_tiles)
    STA z:schedule_vblank_function.PTR_ARG
    SEP #0x20
    LDA #bank(uiteru_v_non_hurt_tiles)
    STA z:schedule_vblank_function.PTR_ARG + 2
    REP #0x20
    LDA #addr(uiteru_v_vram_transfer)
    STA z:schedule_vblank_function.FUNCTION
    SEP #0x20
    LDA #bank(uiteru_v_vram_transfer)
    STA z:schedule_vblank_function.FUNCTION + 2
    JSL schedule_vblank_function
    set_handler uiteru_v.main

.render:
    JMP a:uiteru_v.update_scroll

uiteru_v_bg_palettes:
    db UITERU_V_FIRE_PALETTE, UITERU_V_PALETTE

uiteru_v_vram_transfer:
    SEP #0x20
    LDA #0x81
    STA a:VMAIN
    REP #0x20
    LDA #BG2_BASE + 0x1AF
    STA a:VMADDL
    LDY #0
    
-
    LDA f:[z:0x53], Y
    STA a:VMDATAL
    INY
    INY
    CPY #6
    BNE -
    
    SEP #0x20
    LDA #0x80
    STA a:VMAIN
    RTL

uiteru_v_non_hurt_tiles:
    dw 0x3240, 0x3242, 0x3244, 0

uiteru_v_hurt_tiles:
    dw 0x3246, 0x3248, 0x324A, 0

uiteru_v_handle_bombs:
    .WAS_HIT     = 0x46 ; out
    .ROW_COUNTER = 0x42
    .COL_COUNTER = 0x40
    JSL get_object_square_index
    REP #0x20
    SEC
    SBC #0x42 ; One tile up, on tile left
    TAY
    LDA #0
    STA z:.WAS_HIT
    LDA #2
    STA z:.ROW_COUNTER

.next_row:
    LDA #3
    STA z:.COL_COUNTER

.next_col:
    TYA
    BMI .advance ; tile out of bounds
    LDA a:addr(collision_map), Y
    BIT #BOMB ; is there a bomb here?
    BEQ .advance
    AND #PUNCHED_BOMB | BOMB | 0x1F
    CMP #PUNCHED_BOMB | BOMB | 0x1F ; bomb in landed-by-punch state?
    BEQ .hit_by_punched_bomb
    
    PHY
    SEP #0x20
    ; force_detonate_bomb_at_tile assumes X points to a bomb_object and expects a
    ; valid assiciation value. Back the overlapping variable (handler's bank) first
    ; then temporarily set association to 1
    LDA z:bomb_object.association, X 
    PHA
    LDA #1 ; Player 1
    STA z:bomb_object.association, X
    JSL force_detonate_bomb_at_tile
    SEP #0x20
    PLA
    STA z:bomb_object.association, X ; restore handler bank
    PLY
    REP #0x20

.advance:
    INY
    INY
    DEC z:.COL_COUNTER
    BNE .next_col
    TYA
    CLC
    ADC #0x40 - 3 * 2
    TAY
    DEC z:.ROW_COUNTER
    BNE .next_row
    RTL

.hit_by_punched_bomb:
    LDA #1
    STA z:.WAS_HIT
    BRA .advance

uiteru_v_multiply_velocity:
    .ABS_VELOCITY = 0x42
    .TILE_DISTANCE = 0x40
    REP #0x20
    LDA z:.ABS_VELOCITY
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    SEP #0x20
    STA a:WRMPYA
    LDA z:.TILE_DISTANCE
    STA a:WRMPYB
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    REP #0x20
    LDA a:RDMPYL
    RTL

uiteru_v_calc_player_distance:
    .X_DIST = 0x53 ; Output
    .Y_DIST = 0x56 ; Output
    REP #0x20
    LDA a:uiteru_v.x_position, Y
    AND #0xFF
    SEC
    SBC z:uiteru_v.x_position, X
    
    ; Absolute value
    BPL +
    EOR #0xFFFF
    INC A
+

    LSR A
    LSR A
    LSR A
    LSR A
    STA z:.X_DIST
    LDA a:uiteru_v.y_position, Y
    AND #0xFF
    SEC
    SBC z:uiteru_v.y_position, X
    
    ; Absolute value
    BPL +
    EOR #0xFFFF
    INC A
+

    LSR A
    LSR A
    LSR A
    LSR A
    STA z:.Y_DIST
    RTL

struct uiteru_v_poison_bonus
    enemy
    org 0x16
    ; Matches with bomb_object
.target_x
    ds 1
.target_y
    ds 1
.y_accel
    ds 2
.x_velocity
    ds 2
.y_velocity
    ds 2
    org 0x20
.flight_countdown
    ds 1
    org 0x3E
.direction_flags
    ds 1
.frame_counter
    ds 1
    org enemy.sizeof
endstruct

uiteru_v_create_poison_bonus:
    SEP #0x20
    create_object uiteru_v_poison_bonus
    REP #0x20
    BCS +
    LDA z:uiteru_v.x_position, X
    STA a:uiteru_v_poison_bonus.x_position, Y
    LDA z:uiteru_v.y_position, X
    STA a:uiteru_v_poison_bonus.y_position, Y
    LDA #0x430
    STA a:uiteru_v_poison_bonus.object_priority, Y
    LDA #10
    STA a:uiteru_v_poison_bonus.effective_palette, Y
    LDA #32
    STA a:uiteru_v_poison_bonus.flight_countdown, Y
    LDA #0xFFFF
    STA z:randomize_bomb_trajectory.RETRY_LIMIT
    JSL randomize_bomb_trajectory
    BCC +
    JSL delete_object
    SEC
+

    RTL

uiteru_v_poison_bonus:
i16
    .SIGN_EXT = 0x42
    REP #0x20
    start_animation #addr(uiteru_v_poison_bonus_animation)
    LDY #SOUND_SUDDEN_DEATH_BLOCK
    JSL play_sound
    set_handler .fly

.fly:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ +
    JML .render
+

    REP #0x20
    LDA z:uiteru_v_poison_bonus.fractional_x, X
    CLC
    ADC z:uiteru_v_poison_bonus.x_velocity, X
    STA z:uiteru_v_poison_bonus.fractional_x, X
    STZ z:.SIGN_EXT
    LDA z:uiteru_v_poison_bonus.y_velocity, X
    CLC
    ADC z:uiteru_v_poison_bonus.y_accel, X
    STA z:uiteru_v_poison_bonus.y_velocity, X
    BPL +
    DEC z:.SIGN_EXT
+

    CLC
    ADC z:uiteru_v_poison_bonus.fractional_y, X
    STA z:uiteru_v_poison_bonus.fractional_y, X
    SEP #0x20
    LDA z:.SIGN_EXT
    ADC z:uiteru_v_poison_bonus.y_position + 1, X
    STA z:uiteru_v_poison_bonus.y_position + 1, X
    
    DEC z:uiteru_v_poison_bonus.flight_countdown, X
    BNE .render
    
    ; Arc complete, snap to target tile
    LDA z:uiteru_v_poison_bonus.target_x, X
    STA z:uiteru_v_poison_bonus.x_position, X
    LDA z:uiteru_v_poison_bonus.target_y, X
    STA z:uiteru_v_poison_bonus.y_position, X
    STZ z:uiteru_v_poison_bonus.x_position + 1, X
    STZ z:uiteru_v_poison_bonus.y_position + 1, X
    
    LDA #BOMB_PUNCH_DIRECTION_RIGHT
    STA z:uiteru_v_poison_bonus.direction_flags, X
    LDA z:uiteru_v_poison_bonus.x_velocity + 1, X
    BPL +
    LDA #BOMB_PUNCH_DIRECTION_LEFT
    STA z:uiteru_v_poison_bonus.direction_flags, X
+

    LDA z:uiteru_v_poison_bonus.direction_flags, X
    STZ z:uiteru_v_poison_bonus.frame_counter, X
    REP #0x20
    AND #0x18
    PHX
    TAX
    LDA f:byte_C3075F, X
    STA z:0x40
    PLX
    LDA z:0x40
    STA z:uiteru_v_poison_bonus.target_x, X ; TODO: not actually target_x
    set_handler uiteru_v_poison_bonus_bounce

.render:
    JSL render_sprite_animated
    RTL

uiteru_v_poison_bonus_bounce: ; TODO
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ +
    JML .render
+

    REP #0x20
    LDA #addr(byte_C3075F)
    STA z:0xDB
    SEP #0x20
    LDA #bank(byte_C3075F)
    STA z:0xDD
    REP #0x20
    LDA #addr(byte_C3075F+6)
    STA z:0xDE
    SEP #0x20
    LDA #bank(byte_C3075F+6)
    STA z:0xE0
    REP #0x20
    LDA z:uiteru_v_poison_bonus.direction_flags, X
    AND #0x38
    TAY
    SEP #0x20
    LDA z:uiteru_v_poison_bonus.frame_counter, X
    AND #0x3F
    CMP f:[z:0xDE], Y
    BEQ +
    JML .loc_C770F5
+

    JSL get_object_square_index
    REP #0x20
    TAY
    LDA a:addr(collision_map), Y
    AND #0x3FF
    BNE + ; tile occupied, bounce
    JML .create_bonus
+

    SEP #0x20
    LDA z:uiteru_v_poison_bonus.direction_flags, X
    ORA #0x20
    STA z:uiteru_v_poison_bonus.direction_flags, X
    LDA z:uiteru_v_poison_bonus.x_position, X
    AND #0xF0
    ORA #8
    STA z:uiteru_v_poison_bonus.x_position, X
    LDA z:uiteru_v_poison_bonus.y_position, X
    AND #0xF0
    ORA #8
    STA z:uiteru_v_poison_bonus.y_position, X
    STZ z:uiteru_v_poison_bonus.frame_counter, X
    REP #0x20
    LDA z:uiteru_v_poison_bonus.direction_flags, X
    AND #0x38
    TAY
    LDA f:[z:0xDB], Y
    STA z:uiteru_v_poison_bonus.target_x, X
    
.loc_C770F5:
    REP #0x20
    LDA #addr(byte_C3075F+2)
    STA z:0xDB
    SEP #0x20
    LDA #bank(byte_C3075F+2)
    STA z:0xDD
    REP #0x20
    LDA f:[z:0xDB], Y
    STA z:0x40
    JSL sub_C4572E
    BCS .ret
    INY
    INY
    LDA f:[z:0xDB], Y
    CLC
    ADC z:uiteru_v_poison_bonus.fractional_x, X
    STA z:uiteru_v_poison_bonus.fractional_x, X
    SEP #0x20
    INC z:uiteru_v_poison_bonus.frame_counter, X
    LDA z:uiteru_v_poison_bonus.frame_counter, X
    AND #0x3F
    STA z:uiteru_v_poison_bonus.frame_counter, X

.render:
    JSL render_sprite_animated

.ret:
    RTL
    
.create_bonus:
    REP #0x20
    LDA #POISON
    STA a:addr(collision_map), Y
    JSL create_bonus_object
    JSL delete_object
    RTL

uiteru_v_load_background:
    REP #0x20
    LDA #0x5400
    STA a:VMADDL
    LDA #0x800
    STA a:DASL4
    REP #0x20
    LDA #addr(unexpanded_collision_map)
    STA a:A1TL4
    SEP #0x20
    LDA #bank(unexpanded_collision_map)
    STA a:A1B4
    JSL start_dma
    RTL

uiteru_v_death_explosion_args:
    dw 0x1F, 0x1F, 0x120, 3

uiteru_v_die:
i16
    REP #0x20
    LDA a:addr(game_flags)
    ORA #GAME_FLAGS_BATTLE_DELAY
    STA a:addr(game_flags)
    LDA #0x200
    STA z:uiteru_v.death_countdown, X
    
    LDA z:uiteru_v.y_position, X
    PHA
    LDA z:uiteru_v.y_position, X
    SEC
    SBC #0x20
    STA z:uiteru_v.y_position, X ; offset y for explosion center
    REP #0x20
    LDA #addr(uiteru_v_death_explosion_args)
    STA z:create_boss_exploisions.ARGS_PTR
    SEP #0x20
    LDA #bank(uiteru_v_death_explosion_args)
    STA z:create_boss_exploisions.ARGS_PTR + 2
    JSL create_boss_exploisions
    REP #0x20
    PLA
    STA z:uiteru_v.y_position, X
    
    SEP #0x20
    PHX
    LDX #addr(player_1)
    LDA z:player.real_palette, X
    STA z:player.effective_palette, X ; reset player palette
    LDA z:player.direction, X
    STA z:change_direction_and_start_animation.DIRECTION
    JSL change_direction_and_start_animation
    
    SEP #0x20
    LDX #addr(player_2)
    LDA z:player.real_palette, X
    STA z:player.effective_palette, X ; reset player palette
    LDA z:player.direction, X
    STA z:change_direction_and_start_animation.DIRECTION
    JSL change_direction_and_start_animation
    PLX
    
    set_handler .wait

.wait:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ +
    JML .advance
+

    REP #0x20
    LDA z:uiteru_v.death_countdown, X
    DEC z:uiteru_v.death_countdown, X
    BNE +
    JML uiteru_v_victory_scene
+

    CMP #0x100
    BNE .advance
    LDA #BACKGROUND_WHITE_PALETTE
    STA z:uiteru_v_fade_out_palettes.BG_PALETTE
    LDA #WHITE_PALETTE
    STA z:uiteru_v_fade_out_palettes.OBJ_PALETTE
    JSL uiteru_v_fade_out_palettes
    
.advance:
    REP #0x20
    LDA z:uiteru_v.death_countdown, X
    CMP #0x60
    BNE .ret
    
    REP #0x20
    LDA #0xFFFF ; Forever (essentially)
    STA z:uiteru_v_create_building_shake_sound_loop.LOOP_COUNT
    JSL uiteru_v_create_building_shake_sound_loop

.ret:
    RTL
    
    
struct uiteru_v_sound_loop
    dynamic_object
    org 0x10
.countdown
    ds 2
.loop_count
    ds 2
    org dynamic_object.sizeof
endstruct
    
uiteru_v_create_building_shake_sound_loop:
    .LOOP_COUNT = 0x40
    SEP #0x20
    create_object uiteru_v_building_shake_sound_loop
    REP #0x20
    BCS uiteru_v_die.ret
    LDA #1
    STA a:uiteru_v_sound_loop.countdown, Y
    LDA z:.LOOP_COUNT
    STA a:uiteru_v_sound_loop.loop_count, Y
    RTL

uiteru_v_building_shake_sound_loop:
i16
    REP #0x20
    DEC z:uiteru_v_sound_loop.loop_count, X
    BNE +
    JML delete_object
+

    DEC z:uiteru_v_sound_loop.countdown, X
    BNE uiteru_v_die.ret
    LDA #16
    STA z:uiteru_v_sound_loop.countdown, X
    LDY #SOUND_SECRET_BONUS_APPEAR
    JSL play_sound
    RTL

create_crumble_sound_loop:
    .LOOP_COUNT = 0x40
    SEP #0x20
    create_object crumble_sound_loop
    REP #0x20
    BCC +
    JML uiteru_v_die.ret
+

    LDA #1
    STA a:uiteru_v_sound_loop.countdown, Y
    LDA z:.LOOP_COUNT
    STA a:uiteru_v_sound_loop.loop_count, Y
    RTL

crumble_sound_loop:
i16
    REP #0x20
    DEC z:uiteru_v_sound_loop.loop_count, X
    BNE +
    JML delete_object
+

    DEC z:uiteru_v_sound_loop.countdown, X
    BNE uiteru_v_die.ret
    LDA #16
    STA z:uiteru_v_sound_loop.countdown, X
    LDY #SOUND_BUILDING_CRUMBLE
    JSL play_sound
    RTL

uiteru_v_victory_scene:
i16
    PHX
    JSL delete_all_bombs
    
    LDX #addr(player_1)
    REP #0x20
    LDA #6 * 16 + 8
    STA z:player.x_position, X
    LDA #11 * 16 + 8
    STA z:player.y_position, X
    set_handler player_uiteru_v_victory_scene_handler
    
    LDX #addr(player_2)
    REP #0x20
    LDA #10 * 16 + 8
    STA z:player.x_position, X
    LDA #11 * 16 + 8
    STA z:player.y_position, X
    set_handler player_uiteru_v_victory_scene_handler
    PLX
    
    JSL uiteru_v_fade_in_palettes
    REP #0x20
    LDA #336
    STA a:addr(bg2_h_scroll)
    
    LDA #0xC30
    STA z:uiteru_v_create_running_villain.OBJECT_PRIORITY
    LDA #8
    STA z:uiteru_v_create_running_villain.EFFECTIVE_PALETTE
    LDA #0
    STA z:uiteru_v_create_running_villain.DIRECTION
    LDA #10 * 16 + 8
    STA z:uiteru_v_create_running_villain.X_POSITION
    LDA #5 * 16 + 8
    STA z:uiteru_v_create_running_villain.Y_POSITION
    REP #0x20
    LDA #addr(mook_animations)
    STA z:uiteru_v_create_running_villain.ANIMATION_PTR
    SEP #0x20
    LDA #bank(mook_animations)
    STA z:uiteru_v_create_running_villain.ANIMATION_PTR + 2
    JSL uiteru_v_create_running_villain
    
    REP #0x20
    LDA #0x930
    STA z:uiteru_v_create_running_villain.OBJECT_PRIORITY
    LDA #10
    STA z:uiteru_v_create_running_villain.EFFECTIVE_PALETTE
    LDA #1
    STA z:uiteru_v_create_running_villain.DIRECTION
    LDA #6 * 16 + 8
    STA z:uiteru_v_create_running_villain.X_POSITION
    LDA #5 * 16 + 8
    STA z:uiteru_v_create_running_villain.Y_POSITION
    REP #0x20
    LDA #addr(caret_diamond_animations)
    STA z:uiteru_v_create_running_villain.ANIMATION_PTR
    SEP #0x20
    LDA #bank(caret_diamond_animations)
    STA z:uiteru_v_create_running_villain.ANIMATION_PTR + 2
    JSL uiteru_v_create_running_villain
    
    ; Open an "exit" at the bottom
    REP #0x20
    LDA #0x408
    STA a:addr(bg1_tilemap+0x30E)
    LDA #0x408
    STA a:addr(bg1_tilemap+0x310)
    LDA #0x408
    STA a:addr(bg1_tilemap+0x312)
    LDA #0x280
    STA z:uiteru_v.shake_animation, X
    LDA a:addr(bg1_v_scroll)
    STA z:uiteru_v.base_v_scroll, X
    set_handler .shake_screen

.shake_screen:
    REP #0x20
    DEC z:uiteru_v.shake_animation, X
    LDA z:uiteru_v.shake_animation, X
    AND #0xF
    ASL A
    PHX
    TAX
    LDA f:uiteru_v_shake_scroll_table, X
    PLX
    CLC
    ADC z:uiteru_v.base_v_scroll,X
    STA a:addr(bg1_v_scroll)
    LDA z:uiteru_v.shake_animation, X
    CMP #0x180
    BEQ .add_score
    CMP #0
    BNE +
    SEP #0x20
    LDA #SCREEN_MAP
    STA a:addr(current_screen)
    JSL fade_out_music
    JSL delete_object
+

    RTL

.add_score:
    REP #0x20
    PHX
    LDX #addr(player_1)
    add_to_score_if_allowed 10000
    LDX #addr(player_2)
    add_to_score_if_allowed 10000
    PLX
    RTL

uiteru_v_shake_scroll_table:
    dw -4,  1,  3, -1
    dw  2,  0,  1, -2
    dw -1, -4,  0,  2
    dw -1,  2, -2, -1
    
    
struct uiteru_v_running_villain
    enemy
    org 0x18
.animation_table
    ds 3
    org 0x30
.countdown
    ds 2
.x_velocity
    ds 2
    org enemy.sizeof
endstruct

uiteru_v_create_running_villain:
    .OBJECT_PRIORITY   = 0x40 ; Argument
    .EFFECTIVE_PALETTE = 0x42 ; Argument
    .DIRECTION         = 0x44 ; Argument
    .X_POSITION        = 0x46 ; Argument
    .Y_POSITION        = 0x48 ; Argument
    .ANIMATION_PTR     = 0x50 ; Argument
    SEP #0x20
    create_object uiteru_v_running_villain
    BCS +
    REP #0x20
    LDA z:.ANIMATION_PTR
    STA a:uiteru_v_running_villain.animation_table, Y
    LDA z:.ANIMATION_PTR + 1
    STA a:uiteru_v_running_villain.animation_table + 1, Y
    LDA z:.OBJECT_PRIORITY
    STA a:uiteru_v_running_villain.object_priority, Y
    LDA z:.EFFECTIVE_PALETTE
    STA a:uiteru_v_running_villain.effective_palette, Y
    LDA z:.DIRECTION
    STA a:uiteru_v_running_villain.direction, Y
    LDA z:.X_POSITION
    STA a:uiteru_v_running_villain.x_position, Y
    LDA z:.Y_POSITION
    STA a:uiteru_v_running_villain.y_position, Y
+

    RTL

uiteru_v_running_villain:
    REP #0x20
    LDA #96
    STA z:uiteru_v_running_villain.countdown, X
    LDA #9
    STA z:0x40
    JSL sub_C57F9F
    set_handler .wait

.wait:
    REP #0x20
    DEC z:uiteru_v_running_villain.countdown, X
    BNE .render
    LDA #8
    STA z:uiteru_v_running_villain.countdown, X
    LDA #-1
    STA z:uiteru_v_running_villain.x_velocity, X
    LDA z:uiteru_v_running_villain.direction, X
    BNE +
    LDA #1
    STA z:uiteru_v_running_villain.x_velocity, X
+

    set_handler .run
    REP #0x20
    BRA .reverse_direction

.render:
    JSL render_sprite_animated
    RTL

.run:
    REP #0x20
    LDA z:uiteru_v_running_villain.x_position, X
    CLC
    ADC z:uiteru_v_running_villain.x_velocity, X
    STA z:uiteru_v_running_villain.x_position, X
    DEC z:uiteru_v_running_villain.countdown, X
    BNE .render2
    LDA #0x10
    STA z:uiteru_v_running_villain.countdown, X

.reverse_direction:
    LDA #1
    STA z:0x40
    LDA z:uiteru_v_running_villain.x_velocity, X
    EOR #0xFFFF
    INC A
    STA z:uiteru_v_running_villain.x_velocity, X
    BPL +
    LDA #2
    STA z:0x40
+

    JSL sub_C57F9F

.render2:
    JSL render_sprite_animated
    RTL

uiteru_v_fade_out_palettes:
    .BG_PALETTE  = set_palette.PALETTE
    .OBJ_PALETTE = 0x42
i16
    SEP #0x20
    LDY #7
    LDA #0
    JSL set_palette
    LDA #1
    JSL set_palette
    LDA #2
    JSL set_palette
    LDA #3
    JSL set_palette
    LDA #4
    JSL set_palette
    LDA #5
    JSL set_palette
    LDA #6
    JSL set_palette
    LDA #7
    JSL set_palette
    LDA z:.OBJ_PALETTE
    STA z:set_palette.PALETTE
    LDA #8
    JSL set_palette
    LDA #9
    JSL set_palette
    LDA #0xA
    JSL set_palette
    LDA #0xB
    JSL set_palette
    LDA #0xC
    JSL set_palette
    LDA #0xD
    JSL set_palette
    REP #0x20
    RTL

uiteru_v_fade_in_palettes:
i16
    SEP #0x20
    LDY #7 ; Fade flags
    
    LDA #HUD_PALETTE
    STA z:set_palette.PALETTE
    LDA #0
    JSL set_palette
    
    LDA #DIAMOND_TOWER_PALETTE_1
    STA z:set_palette.PALETTE
    LDA #1
    JSL set_palette
    
    LDA #DIAMOND_TOWER_PALETTE_2
    STA z:set_palette.PALETTE
    LDA #2
    JSL set_palette
    
    LDA #BONUS_PALETTE_1
    STA z:set_palette.PALETTE
    LDA #4
    JSL set_palette
    
    LDA #BONUS_PALETTE_2
    STA z:set_palette.PALETTE
    LDA #5
    JSL set_palette
    
    LDA #DIAMOND_TOWER_BOMB_PALETTE
    STA z:set_palette.PALETTE
    LDA #6
    JSL set_palette
    
    LDA #DIAMOND_TOWER_FIRE_PALETTE
    STA z:set_palette.PALETTE
    LDA #7
    JSL set_palette
    
    LDA #SHIRO_PALETTE
    STA z:set_palette.PALETTE
    LDA #8
    JSL set_palette
    
    LDA #KURO_PALETTE
    STA z:set_palette.PALETTE
    LDA #9
    JSL set_palette
    
    LDA #MOOK_PALETTE
    STA z:set_palette.PALETTE
    LDA #12
    JSL set_palette
    
    LDA #CARAT_DIAMOND_PALETTE
    STA z:set_palette.PALETTE
    LDA #13
    JSL set_palette
    RTL