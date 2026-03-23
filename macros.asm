macro fill addr
    if addr > .
        org addr
    elif addr < .
        warning "Overflow detected at ", .
    endif
endmacro

macro data_end
    nop ; A nop opcode (EA) marks the end of most data sections
endmacro

macro asset type, name
name:
incbin "type/name.bin"
endmacro

macro asset_j type, name
name:
incbin "type/name" + "_j.bin"
endmacro

macro struct struct_name
org 0
struct_name:
endmacro

macro endstruct
.size
endmacro