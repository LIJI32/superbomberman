macro fill addr
    if $addr > .
        org $addr
    elif $addr < .
        warning "Overflow detected at", .
    endif
endmacro

macro data_end
    nop ; A nop opcode (EA) marks the end of most data sections
endmacro

macro asset type, name
$name:
incbin "$OUT/$type/$name.bin"
endmacro

macro asset_j type, name
$name:
incbin "$OUT/$type/$name" + "_j.bin"
endmacro

macro pos reg, x, y
LD$reg #(($y) * 0x20 + ($x)) * 2
endmacro

macro create_object handler
    LDA #low($handler)
    STA z:0xDB
    LDA #high($handler)
    STA z:0xDC
    LDA #bank($handler)
    STA z:0xDD
    LDA #0x80
    STA z:0xD3
    JSL create_object
endmacro

macro set_handler handler
    REP #0x20
    LDA #addr($handler)
    STA z:object.handler, X
    SEP #0x20
    LDA #bank($handler)
    STA z:object.handler + 2, X
endmacro

macro set_enemy_animations animations
    REP #0x20
    LDA #addr($animations)
    STA z:enemy.animations, X
    SEP #0x20
    LDA #bank($animations)
    STA z:enemy.animations + 2, X
endmacro

ENEMY_SCORE_100  = 0
ENEMY_SCORE_200  = 1
ENEMY_SCORE_400  = 2
ENEMY_SCORE_800  = 3
ENEMY_SCORE_1600 = 4
ENEMY_SCORE_3200 = 5
ENEMY_SCORE_6400 = 6

macro set_enemy_score score
    LDA #(ENEMY_SCORE_$score)
    STA z:enemy.score_index, X
endmacro

macro start_animation animation...
    LDA $animation
    STA z:start_animation.ANIMATION
    SEP #0x20
    PHK
    PLA
    STA z:start_animation.ANIMATION + 2
    JSL start_animation
endmacro

macro start_animation_far animation
    LDA #addr($animation)
    STA z:start_animation.ANIMATION
    SEP #0x20
    LDA #bank($animation)
    STA z:start_animation.ANIMATION + 2
    JSL start_animation
endmacro

macro create_enemy handler
    create_object $handler
    REP #0x20
    BCC +
    JML create_enemy_ret
+
endmacro

macro init_enemy hitpoints
if $hitpoints
    LDA #($hitpoints) - 1
    STA a:enemy.hitpoints_left, Y
    LDA #DIR_MASK_LEFT
    STA a:enemy.direction, Y
endif
    REP #0x20
    LDA z:generate_random_position.X
    ; Center in tile
    AND #0xF0
    ORA #8
    STA a:enemy.x_position, Y
    LDA z:generate_random_position.Y
    ; Center in tile
    AND #0xF0
    ORA #8
    STA a:enemy.y_position, Y
    LDA z:create_enemies.RAM_ENEMY_FUNCTION_PTR
    STA a:enemy.creation_functions_array_ptr, Y
    LDA z:create_enemies.RAM_ENEMY_FUNCTION_PTR + 1
    STA a:enemy.creation_functions_array_ptr + 1, Y
    SEP #0x20
    LDA z:create_enemies.ASSIGNED_BONUS
    STA a:enemy.carried_bonus, Y
    LDA #0x30
    STA a:enemy.palette, Y
    LDA a:enemy.execution_priority, Y
    ORA #1
    STA a:enemy.execution_priority, Y
endmacro

macro add_to_score_if_allowed score
    .TEMP_SCORE = (0x$score)
    LDA #.TEMP_SCORE & 0xFFFF
    STA z:add_to_score.SCORE
    LDA #.TEMP_SCORE >> 16
    STA z:add_to_score.SCORE + 2
    JSL add_to_score_if_allowed
    unset .TEMP_SCORE
endmacro

; Converts the position of object at `register` to a map index
macro lda_tile_id register
    LDA z:sprite.x_position, $register
    AND #0xF0
    LSR A
    LSR A
    LSR A
    STA z:0x40
    
    LDA z:sprite.y_position, $register
    AND #0xF0
    ASL A
    ASL A
    ADC z:0x40
endmacro

macro lda_tile_id_offset register, x, y
    LDA z:sprite.x_position, X
    CLC
    ADC #($x) & 0xffff
    AND #0xF0
    LSR A
    LSR A
    LSR A
    STA z:0x40
    
    LDA z:sprite.y_position, X
    CLC
    ADC #($y) & 0xffff
    AND #0xF0
    ASL A
    ASL A
    ADC z:0x40
endmacro

macro handler_return_in_transition
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_SCREEN_TRANSITION | GAME_FLAGS_BATTLE_MENU
    BEQ +
    JML handler_early_exit
+
endmacro

macro handler_return_if_paused_or_in_transition
    handler_return_in_transition
    
    BIT #GAME_FLAGS_PAUSED | GAME_FLAGS_DEBUG_MENU
    BEQ +
    JML .ret
+
endmacro

macro load_palettes palettes
    df load_palettes
    df $palettes
    dw 0x10 ; Number of palettes
    db 0 ; Unused
endmacro

macro load_global_sprites graphics
    df load_global_sprites
    df $graphics
    dw 0x10 ; Number of graphic lists
    db 0 ; Unused
endmacro

macro tile_animation tile, animation
    df tile_animation
    df $animation
    dw $tile
endmacro

macro hidden_bonus_object event, bonus
    df hidden_bonus_object
    dw $event
    db 0
    dw $bonus
    db 0
endmacro

macro set_overlay_blending main_flags, subscreen_flags, color_math
    df set_overlay_blending
    db $main_flags, $subscreen_flags
    dw $color_math
endmacro

macro create_overlay_scroller start_x, start_y, speed_x, speed_y
    df create_overlay_scroller
    dw $start_x, $start_y, $speed_x, $speed_y
endmacro

INIT_FUNCTIONS_TERMINATOR = 0xF0F0

macro init_functions_end
    dw INIT_FUNCTIONS_TERMINATOR
endmacro

macro allocate_graphics list, count
    REP #0x20
    LDA #$count
    STA z:allocate_graphics.COUNT
    
    REP #0x20
    LDA #addr($list)
    STA z:allocate_graphics.GRAPHICS
    SEP #0x20
    LDA #bank($list)
    STA z:allocate_graphics.GRAPHICS + 2
    
    PHY
    JSL allocate_graphics
    PLY
endmacro

macro allocate_object_graphics list, count
    allocate_graphics $list, $count
    SEP #0x20
    LDA z:allocate_graphics.INDEX_USED
    STA a:sprite.graphics_slot, Y
endmacro

macro allocate_object_palette palette_index
    SEP #0x20
    LDA #$palette_index
    STA z:allocate_sprite_palette.PALETTE
    JSL allocate_sprite_palette
    SEP #0x20
    LDA z:allocate_sprite_palette.SLOT_INDEX
    STA a:sprite.effective_palette, Y
    STA a:sprite.real_palette, Y
endmacro

macro animation_frame_tile_count
    db (.end - . - 1) / frame_oam_tile.sizeof
endmacro

macro animation_frame_count
    db (.end - . - 1) / animation_frame.sizeof
endmacro
