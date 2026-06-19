uiteru_v_random_bonuses:
    dw FIRE_UP, FIRE_UP, EXTRA_TIME, HEART, HEART, PUNCH, PUNCH, PUNCH

uiteru_v_create_shadow:
    SEP #0x20
    create_object uiteru_v_shadow
    REP #0x20
    BCC .loc_C76A63
    JML create_bonus_spawner.ret

.loc_C76A63:
    TXA
    STA a:0x32, Y
    LDA z:0x11, X
    STA a:0x11, Y
    LDA z:0x14, X
    CLC
    ADC #0
    STA a:0x14, Y
    LDA z:0x30, X
    STA a:0x30, Y
    RTL

uiteru_v_shadow:
i16
    REP #0x20
    LDA #0x410
    STA z:0xE, X
    LDA #8
    STA z:0x1E, X
    start_animation #addr(uiteru_v_shadow_animation)
    SEP #0x20
    LDY #7
    LDA #INTRO_BALOON_PALETTE
    STA z:0x40
    LDA #0xC
    JSL set_palette
    set_handler .loc_C76AB2

.loc_C76AB2:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ .loc_C76AC7
    JML .loc_C76ADD

.loc_C76AC7:
    REP #0x20
    LDA a:addr(game_flags)
    BIT #GAME_FLAGS_BATTLE_DELAY
    BEQ .loc_C76AD5
    JML delete_object

.loc_C76AD5:
    LDA z:0x30, X
    BEQ .loc_C76ADD
    DEC z:0x30, X
    BRA .loc_C76B01
.loc_C76ADD:
    REP #0x20
    LDY z:0x32, X
    LDA a:0x11, Y
    CLC
    ADC #0
    STA z:0x11, X
    LDA a:0x14, Y
    CLC
    ADC #0x18
    STA z:0x14, X
    LDA #0x1010
    STA z:0x42
    LDA #0x2002
    STA z:0x44
    JSL enemy_hit_players_in_range

.loc_C76B01:
    REP #0x20
    LDA z:0x14, X
    PHA
    LDA #1
    STA z:0x14, X
    JSL render_sprite
    REP #0x20
    PLA
    STA z:0x14, X
    RTL

create_uiteru_v:
    SEP #0x20
    create_object uiteru_v
    REP #0x20
    TXA
    STA a:0x38, Y
    LDA #0x430
    STA a:0xE, Y
    LDA #8
    STA a:0x1E, Y
    LDA z:0x11, X
    STA a:0x11, Y
    LDA z:0x14, X
    STA a:0x14, Y
    LDA #0xC0
    STA a:0x30, Y
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
    STA z:0x20, X
    LDA #0x10
    STA z:0x32, X
    LDA #0x100
    STA z:0x34, X
    LDA #5
    STA z:0x36, X
    set_handler .loc_C76BD5
    SEP #0x20
    LDY #0
    LDA #0x75
    STA z:0x40
    LDA #3
    JSL set_palette
    LDA #0x79
    STA z:0x40
    LDA #4
    JSL set_palette
    LDA #addr(POISON_PALETTE)
    STA z:0x40
    LDA #0xD
    JSL set_palette
    LDA #addr(POISON_PALETTE)
    STA z:0x40
    LDA #0xC
    JSL set_palette
    REP #0x20
    LDA #addr(compressed_spiderer_tilemap+0xFC)
    STA z:0x53
    SEP #0x20
    LDA #bank(compressed_spiderer_tilemap+0xFC)
    STA z:0x53 + 2
    JSL tilemap_decompression
    REP #0x20
    LDA #addr(uiteru_v_load_background)
    STA z:0x50
    SEP #0x20
    LDA #bank(uiteru_v_load_background)
    STA z:0x52
    JSL schedule_vblank_function

.loc_C76BD5:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ .loc_C76BEA
    JML .loc_C76D6C

.loc_C76BEA:
    REP #0x20
    LDA z:0x13, X
    SEC
    SBC #0x20
    STA z:0x13, X
    DEC z:0x30, X
    BEQ .loc_C76BFC
    JML .loc_C76D6C

.loc_C76BFC:
    LDA #0x80
    STA z:0x30, X
    set_handler .loc_C76C0E

.loc_C76C0E:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ .loc_C76C23
    JML .loc_C76D6C

.loc_C76C23:
    REP #0x20
    DEC z:0x30, X
    BEQ .loc_C76C2D
    JML .loc_C76D6C

.loc_C76C2D:
    set_handler .loc_C76C3A
    ; fallthrough

.loc_C76C3A:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ .loc_C76C4F
    JML .loc_C76D6C

.loc_C76C4F:
    REP #0x20
    LDA #addr(word_C76D91)
    STA z:0xDB
    SEP #0x20
    LDA #bank(word_C76D91)
    STA z:0xDD
    REP #0x20
    DEC z:0x32, X
    BMI .loc_C76C66
    JML .loc_C76CF6

.loc_C76C66:
    JSL enemy_find_closest_player
    REP #0x20
    LDA z:0x2A, X
    PHA
    JSL sub_C63BF9
    REP #0x20
    STA z:0x40
    PLA
    STA z:0x2A, X
    LDA z:0x40
    AND #0xF
    ASL A
    ASL A
    ASL A
    PHA
    JSL sub_C76F62
    PLY
    INC z:0x20, X
    LDA z:0x20, X
    AND #0x1F
    ASL A
    ASL A
    PHX
    TAX
    LDA z:0x53
    STA z:0x40
    LDA f:word_C76D91, X
    BPL .loc_C76CA1
    EOR #0xFFFF
    INC A

.loc_C76CA1:
    STA z:0x42
    LDA f:word_C76D91, X
    EOR f:[z:0xDB], Y
    BIT #0x8000
    BEQ .loc_C76CB2
    LSR z:0x42
    LSR z:0x42

.loc_C76CB2:
    JSL sub_C76F41
    STA z:0x53
    LDA z:0x56
    STA z:0x40
    LDA f:word_C76D91+2, X
    BPL .loc_C76CC6
    EOR #0xFFFF
    INC A

.loc_C76CC6:
    STA z:0x42
    LDA f:word_C76D91+2, X
    INY
    INY
    EOR f:[z:0xDB], Y
    BIT #0x8000
    BEQ .loc_C76CD9
    LSR z:0x42
    LSR z:0x42

.loc_C76CD9:
    JSL sub_C76F41
    CLC
    ADC z:0x53
    LSR A
    CMP #2
    BPL .loc_C76CEB
    LDA #2
    BRA .loc_C76CF3

.loc_C76CEB:
    CMP #0x18
    BCC .loc_C76CF3
    LDA #0x18

.loc_C76CF3:
    PLX
    STA z:0x32, X

.loc_C76CF6:
    REP #0x20
    LDA z:0x20, X
    AND #0x1F
    ASL A
    ASL A
    TAY
    STZ z:0x40
    LDA f:[z:0xDB], Y
    BPL .loc_C76D08
    DEC z:0x40

.loc_C76D08:
    CLC
    ADC z:0x10, X
    STA z:0x10, X
    SEP #0x20
    LDA z:0x40
    ADC z:0x12, X
    STA z:0x12, X
    REP #0x20
    STZ z:0x40
    INY
    INY
    LDA f:[z:0xDB], Y
    BPL .loc_C76D21
    DEC z:0x40

.loc_C76D21:
    CLC
    ADC z:0x13, X
    STA z:0x13, X
    SEP #0x20
    LDA z:0x40
    ADC z:0x15, X
    STA z:0x15, X
    JSL sub_C76EE6
    REP #0x20
    LDA z:0x46
    BEQ .loc_C76D4C
    LDY #0x17
    JSL play_sound
    set_handler sub_C76E11

.loc_C76D4C:
    REP #0x20
    DEC z:0x34, X
    BNE .loc_C76D6C
    LDA #0x100
    STA z:0x34, X
    LDA a:addr(number_of_visible_bonuses)
    CMP #0x20
    BCS .loc_C76D6C
    JSL sub_C76F8F
    REP #0x20
    BCC .loc_C76D6C
    LDA #0x80
    STA z:0x34, X
    
.loc_C76D6C:
    REP #0x20
    LDA z:0x11, X
    SEC
    SBC #0x78
    EOR #0xFFFF
    INC A
    CLC
    ADC #0x88
    STA a:addr(bg2_h_scroll)
    LDA z:0x14, X
    SEC
    SBC #0x70
    EOR #0xFFFF
    INC A
    CLC
    ADC #0x88
    STA a:addr(bg2_v_scroll)
    RTL

word_C76D91:
    dw 0, 0xFF00
    dw 0x20, 0xFF20
    dw 0x40, 0xFF40
    dw 0x60, 0xFF60
    dw 0x80, 0xFF80
    dw 0xA0, 0xFFA0
    dw 0xC0, 0xFFC0
    dw 0xE0, 0xFFE0
    dw 0x100, 0
    dw 0xE0, 0x20
    dw 0xC0, 0x40
    dw 0xA0, 0x60
    dw 0x80, 0x80
    dw 0x60, 0xA0
    dw 0x40, 0xC0
    dw 0x20, 0xE0
    dw 0, 0x100
    dw 0xFFE0, 0xE0
    dw 0xFFC0, 0xC0
    dw 0xFFA0, 0xA0
    dw 0xFF80, 0x80
    dw 0xFF60, 0x60
    dw 0xFF40, 0x40
    dw 0xFF20, 0x20
    dw 0xFF00, 0
    dw 0xFF20, 0xFFE0
    dw 0xFF40, 0xFFC0
    dw 0xFF60, 0xFFA0
    dw 0xFF80, 0xFF80
    dw 0xFFA0, 0xFF60
    dw 0xFFC0, 0xFF40
    dw 0xFFE0, 0xFF20
sub_C76E11:
i16
    REP #0x20
    LDA #0x80
    STA z:0x30, X
    REP #0x20
    LDA #addr(word_C76EDE)
    STA z:0x53
    SEP #0x20
    LDA #bank(word_C76EDE)
    STA z:0x53 + 2
    REP #0x20
    LDA #addr(word_C76EAE + 2)
    STA z:0x50
    SEP #0x20
    LDA #bank(word_C76EAE + 2)
    STA z:0x52
    JSL schedule_vblank_function
    set_handler .loc_C76E43

.loc_C76E43:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ .loc_C76E58
    JML uiteru_v.loc_C76D6C

.loc_C76E58:
    REP #0x20
    LDA z:0x30, X
    AND #1
    PHX
    TAX
    LDA f:word_C76EAE, X
    STA z:0x40
    PLX
    LDY #0
    LDA #3
    JSL set_palette
    REP #0x20
    DEC z:0x30, X
    BNE .loc_C76EAB
    DEC z:0x36, X
    BNE .loc_C76E80
    JML sub_C77161

.loc_C76E80:
    REP #0x20
    LDA #addr(word_C76ED6)
    STA z:0x53
    SEP #0x20
    LDA #bank(word_C76ED6)
    STA z:0x53 + 2
    REP #0x20
    LDA #addr(word_C76EAE + 2)
    STA z:0x50
    SEP #0x20
    LDA #bank(word_C76EAE + 2)
    STA z:0x52
    JSL schedule_vblank_function
    set_handler uiteru_v.loc_C76C3A

.loc_C76EAB:
    JMP a:uiteru_v.loc_C76D6C

word_C76EAE:
    dw 0x7578, 0x20E2 
    dw 0x81A9, 0x158D 
    dw 0xC221, 0xA920 
    dw 0x55AF, 0x168D 
    dw 0xA021, 0x0000 

; Unused
sub_C76EC2:
    LDA f:[z:0x53], Y
    STA a:VMDATAL
    INY
    INY
    CPY #6
    BNE sub_C76EC2
    SEP #0x20
    LDA #0x80
    STA a:VMAIN
    RTL

word_C76ED6:
    dw 0x3240, 0x3242, 0x3244, 0
word_C76EDE:
    dw 0x3246, 0x3248, 0x324A, 0

sub_C76EE6:
    JSL get_object_square_index
    REP #0x20
    SEC
    SBC #0x42
    TAY
    LDA #0
    STA z:0x46
    LDA #2
    STA z:0x42

.loc_C76EFB:
    LDA #3
    STA z:0x40

.loc_C76F00:
    TYA
    BMI .loc_C76F29
    LDA a:addr(collision_map), Y
    BIT #0x20
    BEQ .loc_C76F29
    AND #0x23F
    CMP #0x23F
    BEQ .loc_C76F3A
    PHY
    SEP #0x20
    LDA z:2, X
    PHA
    LDA #1
    STA z:2, X
    JSL sub_C45B9A
    SEP #0x20
    PLA
    STA z:2, X
    PLY
    REP #0x20

.loc_C76F29:
    INY
    INY
    DEC z:0x40
    BNE .loc_C76F00
    TYA
    CLC
    ADC #0x3A
    TAY
    DEC z:0x42
    BNE .loc_C76EFB
    RTL

.loc_C76F3A:
    LDA #1
    STA z:0x46
    BRA .loc_C76F29

sub_C76F41:
    REP #0x20
    LDA z:0x42
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    SEP #0x20
    STA a:WRMPYA
    LDA z:0x40
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

sub_C76F62:
    REP #0x20
    LDA a:0x11, Y
    AND #0xFF
    SEC
    SBC z:0x11, X
    BPL .loc_C76F73
    EOR #0xFFFF
    INC A

.loc_C76F73:
    LSR A
    LSR A
    LSR A
    LSR A
    STA z:0x53
    LDA a:0x14, Y
    AND #0xFF
    SEC
    SBC z:0x14, X
    BPL .loc_C76F88
    EOR #0xFFFF
    INC A

.loc_C76F88:
    LSR A
    LSR A
    LSR A
    LSR A
    STA z:0x56
    RTL

sub_C76F8F:
    SEP #0x20
    create_object sub_C76FD6
    REP #0x20
    BCS .locret_C76FD5
    LDA z:0x11, X
    STA a:0x11, Y
    LDA z:0x14, X
    STA a:0x14, Y
    LDA #0x430
    STA a:0xE, Y
    LDA #0xA
    STA a:0x1E, Y
    LDA #0x20
    STA a:0x20, Y
    LDA #0xFFFF
    STA z:0x48
    JSL randomize_bomb_trajectory
    BCC .locret_C76FD5
    JSL delete_object
    SEC

.locret_C76FD5:
    RTL

sub_C76FD6:
i16
    REP #0x20
    start_animation #addr(uiteru_v_poison_bonus_animation)
    LDY #SOUND_SUDDEN_DEATH_BLOCK
    JSL play_sound
    set_handler .loc_C76FFB

.loc_C76FFB:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ .loc_C77010
    JML .loc_C77072

.loc_C77010:
    REP #0x20
    LDA z:0x10, X
    CLC
    ADC z:0x1A, X
    STA z:0x10, X
    STZ z:0x42
    LDA z:0x1C, X
    CLC
    ADC z:0x18, X
    STA z:0x1C, X
    BPL .loc_C77026
    DEC z:0x42

.loc_C77026:
    CLC
    ADC z:0x13, X
    STA z:0x13, X
    SEP #0x20
    LDA z:0x42
    ADC z:0x15, X
    STA z:0x15, X
    DEC z:0x20, X
    BNE .loc_C77072
    LDA z:0x16, X
    STA z:0x11, X
    LDA z:0x17, X
    STA z:0x14, X
    STZ z:0x12, X
    STZ z:0x15, X
    LDA #8
    STA z:0x3E, X
    LDA z:0x1B, X
    BPL .loc_C7704F
    LDA #0x18
    STA z:0x3E, X

.loc_C7704F:
    LDA z:0x3E, X
    STZ z:0x3F, X
    REP #0x20
    AND #0x18
    PHX
    TAX
    LDA f:byte_C3075F, X
    STA z:0x40
    PLX
    LDA z:0x40
    STA z:0x16, X
    set_handler sub_C77077

.loc_C77072:
    JSL render_sprite_animated
    RTL

sub_C77077:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ .loc_C7708C
    JML .loc_C77121

.loc_C7708C:
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
    LDA z:0x3E, X
    AND #0x38
    TAY
    SEP #0x20
    LDA z:0x3F, X
    AND #0x3F
    CMP f:[z:0xDE], Y
    BEQ .loc_C770BC
    JML .loc_C770F5

.loc_C770BC:
    JSL get_object_square_index
    REP #0x20
    TAY
    LDA a:addr(collision_map), Y
    AND #0x3FF
    BNE .loc_C770CF
    JML .loc_C77126

.loc_C770CF:
    SEP #0x20
    LDA z:0x3E, X
    ORA #0x20
    STA z:0x3E, X
    LDA z:0x11, X
    AND #0xF0
    ORA #8
    STA z:0x11, X
    LDA z:0x14, X
    AND #0xF0
    ORA #8
    STA z:0x14, X
    STZ z:0x3F, X
    REP #0x20
    LDA z:0x3E, X
    AND #0x38
    TAY
    LDA f:[z:0xDB], Y
    STA z:0x16, X
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
    BCS .locret_C77125
    INY
    INY
    LDA f:[z:0xDB], Y
    CLC
    ADC z:0x10, X
    STA z:0x10, X
    SEP #0x20
    INC z:0x3F, X
    LDA z:0x3F, X
    AND #0x3F
    STA z:0x3F, X

.loc_C77121:
    JSL render_sprite_animated

.locret_C77125:
    RTL
.loc_C77126:
    REP #0x20
    LDA #0xF
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

word_C77159:
    dw 0x1F, 0x1F, 0x120, 3
sub_C77161:
i16
    REP #0x20
    LDA a:addr(game_flags)
    ORA #GAME_FLAGS_BATTLE_DELAY
    STA a:addr(game_flags)
    LDA #0x200
    STA z:0x3E, X
    LDA z:0x14, X
    PHA
    LDA z:0x14, X
    SEC
    SBC #0x20
    STA z:0x14, X
    REP #0x20
    LDA #addr(word_C77159)
    STA z:0x50
    SEP #0x20
    LDA #bank(word_C77159)
    STA z:0x52
    JSL create_boss_exploisions
    REP #0x20
    PLA
    STA z:0x14, X
    SEP #0x20
    PHX
    LDX #addr(player_1)
    LDA z:0x1F, X
    STA z:0x1E, X
    LDA z:0x20, X
    STA z:0x40
    JSL change_direction_and_start_animation
    SEP #0x20
    LDX #addr(player_2)
    LDA z:0x1F, X
    STA z:0x1E, X
    LDA z:0x20, X
    STA z:0x40
    JSL change_direction_and_start_animation
    PLX
    set_handler .loc_C771C3

.loc_C771C3:
    SEP #0x20
    handler_return_in_transition
    BIT #GAME_FLAGS_DEBUG_MENU | GAME_FLAGS_PAUSED
    BEQ .loc_C771D8
    JML .loc_C771F7

.loc_C771D8:
    REP #0x20
    LDA z:0x3E, X
    DEC z:0x3E, X
    BNE .loc_C771E4
    JML sub_C77292

.loc_C771E4:
    CMP #0x100
    BNE .loc_C771F7
    LDA #0x2E
    STA z:0x40
    LDA #addr(WHITE_PALETTE)
    STA z:0x42
    JSL sub_C77490
.loc_C771F7:
    REP #0x20
    LDA z:0x3E, X
    CMP #0x60
    BNE nullsub_10
    REP #0x20
    LDA #0xFFFF
    STA z:0x40
    JSL sub_C7720C

nullsub_10:
    RTL
    
sub_C7720C:
    SEP #0x20
    create_object sub_C77232
    REP #0x20
    BCS nullsub_10
    LDA #1
    STA a:0x10, Y
    LDA z:0x40
    STA a:0x12, Y
    RTL

sub_C77232:
i16
    REP #0x20
    DEC z:0x12, X
    BNE .loc_C7723C
    JML delete_object

.loc_C7723C:
    DEC z:0x10, X
    BNE nullsub_10
    LDA #0x10
    STA z:0x10, X
    LDY #4
    JSL play_sound
    RTL

sub_C7724D:
    SEP #0x20
    create_object sub_C77277
    REP #0x20
    BCC .loc_C7726B
    JML nullsub_10

.loc_C7726B:
    LDA #1
    STA a:0x10, Y
    LDA z:0x40
    STA a:0x12, Y
    RTL

sub_C77277:
i16
    REP #0x20
    DEC z:0x12, X
    BNE .loc_C77281
    JML delete_object

.loc_C77281:
    DEC z:0x10, X
    BNE nullsub_10
    LDA #0x10
    STA z:0x10, X
    LDY #SOUND_BUILDING_CRUMBLE
    JSL play_sound
    RTL

sub_C77292:
i16
    PHX
    JSL sub_C4245D
    LDX #addr(player_1)
    REP #0x20
    LDA #0x68
    STA z:0x11, X
    LDA #0xB8
    STA z:0x14, X
    set_handler sub_C4273F
    LDX #addr(player_2)
    REP #0x20
    LDA #0xA8
    STA z:0x11, X
    LDA #0xB8
    STA z:0x14, X
    set_handler sub_C4273F
    PLX
    JSL sub_C774F0
    REP #0x20
    LDA #0x150
    STA a:addr(bg2_h_scroll)
    LDA #0xC30
    STA z:0x40
    LDA #8
    STA z:0x42
    LDA #0
    STA z:0x44
    LDA #0xA8
    STA z:0x46
    LDA #0x58
    STA z:0x48
    REP #0x20
    LDA #addr(off_C71F3D)
    STA z:0x50
    SEP #0x20
    LDA #bank(off_C71F3D)
    STA z:0x52
    JSL sub_C773D7
    REP #0x20
    LDA #0x930
    STA z:0x40
    LDA #0xA
    STA z:0x42
    LDA #1
    STA z:0x44
    LDA #0x68
    STA z:0x46
    LDA #0x58
    STA z:0x48
    REP #0x20
    LDA #addr(off_C71F6D)
    STA z:0x50
    SEP #0x20
    LDA #bank(off_C71F6D)
    STA z:0x52
    JSL sub_C773D7
    REP #0x20
    LDA #0x408
    STA a:addr(bg1_tilemap+0x30E)
    LDA #0x408
    STA a:addr(bg1_tilemap+0x310)
    LDA #0x408
    STA a:addr(bg1_tilemap+0x312)
    LDA #0x280
    STA z:0x20, X
    LDA a:addr(bg1_v_scroll)
    STA z:0x22, X
    REP #0x20
    LDA #addr(.loc_C7735D)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C7735D)
    STA z:2,X

.loc_C7735D:
    REP #0x20
    DEC z:0x20,X
    LDA z:0x20,X
    AND #0xF
    ASL A
    PHX
    TAX
    LDA f:word_C773B7,X
    PLX
    CLC
    ADC z:0x22,X
    STA a:addr(bg1_v_scroll)
    LDA z:0x20,X
    CMP #0x180
    BEQ .loc_C77390
    CMP #0
    BNE .locret_C7738F
    SEP #0x20
    LDA #0x39
    STA a:addr(current_screen)
    JSL fade_out_music
    JSL delete_object

.locret_C7738F:
    RTL

.loc_C77390:
    REP #0x20
    PHX
    LDX #addr(player_1)
    add_to_score_if_allowed 10000
    LDX #addr(player_2)
    add_to_score_if_allowed 10000
    PLX
    RTL

word_C773B7:
    dw 0xFFFC, 0x0001, 0x0003, 0xFFFF
    dw 0x0002, 0x0000, 0x0001, 0xFFFE
    dw 0xFFFF, 0xFFFC, 0x0000, 0x0002
    dw 0xFFFF, 0x0002, 0xFFFE, 0xFFFF
sub_C773D7:
    SEP #0x20
    create_object sub_C77415
    BCS .locret_C77414
    REP #0x20
    LDA z:0x50
    STA a:0x18, Y
    LDA z:0x51
    STA a:0x19, Y
    LDA z:0x40
    STA a:0xE, Y
    LDA z:0x42
    STA a:0x1E, Y
    LDA z:0x44
    STA a:0x20, Y
    LDA z:0x46
    STA a:0x11, Y
    LDA z:0x48
    STA a:0x14, Y

.locret_C77414:
    RTL

sub_C77415:
    REP #0x20
    LDA #0x60
    STA z:0x30,X
    LDA #9
    STA z:0x40
    JSL sub_C57F9F
    REP #0x20
    LDA #addr(.loc_C77432)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C77432)
    STA z:2,X

.loc_C77432:
    REP #0x20
    DEC z:0x30,X
    BNE .loc_C7745C
    LDA #8
    STA z:0x30,X
    LDA #0xFFFF
    STA z:0x32,X
    LDA z:0x20,X
    BNE .loc_C7744B
    LDA #1
    STA z:0x32,X

.loc_C7744B:
    REP #0x20
    LDA #addr(.loc_C77461)
    STA z:0,X
    SEP #0x20
    LDA #bank(.loc_C77461)
    STA z:2,X
    REP #0x20
    BRA .loc_C77473

.loc_C7745C:
    JSL render_sprite_animated
    RTL

.loc_C77461:
    REP #0x20
    LDA z:0x11,X
    CLC
    ADC z:0x32,X
    STA z:0x11,X
    DEC z:0x30,X
    BNE .loc_C7748B
    LDA #0x10
    STA z:0x30,X

.loc_C77473:
    LDA #1
    STA z:0x40
    LDA z:0x32,X
    EOR #0xFFFF
    INC A
    STA z:0x32,X
    BPL .loc_C77487
    LDA #2
    STA z:0x40

.loc_C77487:
    JSL sub_C57F9F

.loc_C7748B:
    JSL render_sprite_animated
    RTL

sub_C77490:
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
    LDA z:0x42
    STA z:0x40
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

sub_C774F0:
i16
    SEP #0x20
    LDY #7
    LDA #0
    STA z:0x40
    LDA #0
    JSL set_palette
    LDA #0x40
    STA z:0x40
    LDA #1
    JSL set_palette
    LDA #0x41
    STA z:0x40
    LDA #2
    JSL set_palette
    LDA #4
    STA z:0x40
    LDA #4
    JSL set_palette
    LDA #5
    STA z:0x40
    LDA #5
    JSL set_palette
    LDA #0x42
    STA z:0x40
    LDA #6
    JSL set_palette
    LDA #0x43
    STA z:0x40
    LDA #7
    JSL set_palette
    LDA #addr(SHIRO_PALETTE)
    STA z:0x40
    LDA #8
    JSL set_palette
    LDA #addr(KURO_PALETTE)
    STA z:0x40
    LDA #9
    JSL set_palette
    LDA #addr(MOOK_PALETTE)
    STA z:0x40
    LDA #0xC
    JSL set_palette
    LDA #addr(CARAT_DIAMOND_PALETTE)
    STA z:0x40
    LDA #0xD
    JSL set_palette
    RTL