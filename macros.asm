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

; Converts the position of object at `register` to a map index
macro lda_tile_id register
    LDA z:sprite.x_position,$register
    AND #0xF0
    LSR A
    LSR A
    LSR A
    STA z:0x40
    
    LDA z:sprite.y_position,$register
    AND #0xF0
    ASL A
    ASL A
    ADC z:0x40
endmacro

macro lda_tile_id_offset register, x, y
    LDA z:sprite.x_position,X
    CLC
    ADC #($x) & 0xffff
    AND #0xF0
    LSR A
    LSR A
    LSR A
    STA z:0x40
    
    LDA z:sprite.y_position,X
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

macro handler_return_if_paused
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
    db 0 ; Unused?
endmacro

macro load_global_sprites graphics
    df load_global_sprites
    df $graphics
    dw 0x10 ; Number of graphic lists
    db 0 ; Unused?
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

macro init_functions_end
    dw 0xF0F0
endmacro