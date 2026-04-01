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
