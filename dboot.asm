fill 0xC48000
dboot_command:
    BRA .loc_C48012
db " DBOOT VER1.03 ", 0

.loc_C48012:
    PHP
    PHB
    PHD
    REP #0x30
    PHA
    PHX
    PHY
    PHX
    LDX #addr(dboot_ram_start)
    PHX
    PLD
; D=100
    PHK
    PLB
; ds=C4000 B=C4
    AND #0xFF
    ASL A
    TAX
    JMP [addr(dboot_commands_array), X]
    ; fallthrough

sub_C4802A:
    PLY
    PLX
    PLA
    PLD
    PLB
    PLP
    RTL

dboot_commands_array:
    da dboot_init_internal, sub_C48076; 0
    da sub_C48085, sub_C48099; 2
    da sub_C480A6, sub_C480B3; 4
    da dboot_init_internal, dboot_init_internal; 6
    da dboot_init_internal, dboot_init_internal; 8
    da dboot_init_internal, dboot_init_internal; 0xA
    da dboot_init_internal, dboot_init_internal; 0xC
    da dboot_init_internal, dboot_init_internal; 0xE
    da sub_C480CC, sub_C480CC; 0x10
    da sub_C480CC, play_music_internal; 0x12
    da play_sound_internal, fade_out_music_internal; 0x14
    da sub_C48114, sub_C48123; 0x16
    da sub_C48132, sub_C48141; 0x18
    da sub_C48150 ; 0x1A
dboot_init_internal:
    PLX
    PHP
    REP #0x30
    JSR a:addr(clear_dboot_data)
    JSR a:addr(init_array_of_music_related_pointers)
    PLP
    JML sub_C4802A

sub_C48076:
    PLX
    PHP
    REP #0x30
    JSR a:addr(init_array_of_music_related_pointers)
    JSR a:addr(sub_C4840E)
    PLP
    JML sub_C4802A

sub_C48085:
    PLX
    PHP
    REP #0x30
    TYA
    PHA
    JSR a:addr(init_array_of_music_related_pointers)
    PLA
    STA z:0x1A
    JSR a:addr(load_music_bank)
    PLP
    JML sub_C4802A

sub_C48099:
    PLX
    PHP
    REP #0x30
    TYA
    JSR a:addr(send_7_bit_data_on_apu_io_0)
    PLP
    JML sub_C4802A

sub_C480A6:
    PLX
    PHP
    REP #0x30
    TYA
    JSR a:addr(send_7_bit_data_on_apu_io_1)
    PLP
    JML sub_C4802A

sub_C480B3:
    PLX
    PHP
    REP #0x30
    PHX
    PHY
    JSR a:addr(init_array_of_music_related_pointers)
    STZ z:0x1A
    PLY
    PLX
    STY z:2
    STX z:4
    JSR a:addr(load_music_bank)
    PLP
    JML sub_C4802A

sub_C480CC:
    PLX
    PHP
    REP #0x30
    JSR a:addr(clear_dboot_data)
    JSR a:addr(init_array_of_music_related_pointers)
    JSR a:addr(sub_C4840E)
    PLP
    JML sub_C4802A

play_music_internal:
    PLX
    PHP
    REP #0x30
    PHY
    TYA
    JSR a:addr(play_music_return_should_reload_bank)
    BCC .loc_C480EF
    JSR a:addr(init_array_of_music_related_pointers)
    JSR a:addr(load_music_bank)

.loc_C480EF:
    PLA
    JSR a:addr(send_7_bit_data_on_apu_io_0)
    PLP
    JML sub_C4802A

play_sound_internal:
    PLX
    PHP
    REP #0x30
    TYA
    JSR a:addr(send_7_bit_data_on_apu_io_1)
    PLP
    JML sub_C4802A

fade_out_music_internal:
    PLX
    PHP
    REP #0x30
    LDA #0x3B
    JSR a:addr(send_7_bit_data_on_apu_io_0)
    PLP
    JML sub_C4802A

sub_C48114:
    PLX
    PHP
    REP #0x30
    LDA #0x3A
    JSR a:addr(send_7_bit_data_on_apu_io_0)
    PLP
    JML sub_C4802A

sub_C48123:
    PLX
    PHP
    REP #0x30
    LDA #0x39
    JSR a:addr(send_7_bit_data_on_apu_io_0)
    PLP
    JML sub_C4802A

sub_C48132:
    PLX
    PHP
    REP #0x30
    LDA #0x38
    JSR a:addr(send_7_bit_data_on_apu_io_0)
    PLP
    JML sub_C4802A

sub_C48141:
    PLX
    PHP
    REP #0x30
    TYA
    AND #0xFF
    STA z:0x74
    PLP
    JML sub_C4802A

sub_C48150:
    PLX
    PHP
    REP #0x30
    LDA #0x3F
    JSR a:addr(send_7_bit_data_on_apu_io_0)
    PLP
    JML sub_C4802A

play_music_return_should_reload_bank:
    PHP
    REP #0x30
    AND #0x3F
    STA z:dboot_paramater_0 - dboot_ram_start
    LDA z:current_music_bank - dboot_ram_start
    INC A
    BEQ .loc_C48177
    JSR a:addr(init_array_of_music_related_pointers)
    JSR a:addr(parse_music_bank)
    JSR a:addr(is_music_in_current_bank)
    BCC .loc_C48193

.loc_C48177:
    STZ z:current_music_bank - dboot_ram_start

.loc_C48179:
    JSR a:addr(init_array_of_music_related_pointers)
    JSR a:addr(parse_music_bank)
    JSR a:addr(is_music_in_current_bank)
    BCC .loc_C48190
    INC z:current_music_bank - dboot_ram_start
    LDA z:0
    CMP z:current_music_bank - dboot_ram_start
    BNE .loc_C48179
    JML .loc_C48193

.loc_C48190:
    PLP
    SEC
    RTS

.loc_C48193:
    PLP
    CLC
    RTS

is_music_in_current_bank:
    PHP
    SEP #0x20
    SEP #0x10
    LDY #0
    LDX z:number_of_musics_in_bank - dboot_ram_start
    BEQ .loc_C481AB

.loc_C481A1:
    LDA f:[z:pointer_to_current_music_list - number_of_music_banks], Y
    CMP z:dboot_paramater_0 - dboot_ram_start
    BEQ .loc_C481AE
    INY
    DEX
    BNE .loc_C481A1

.loc_C481AB:
    PLP
    SEC
    RTS

.loc_C481AE:
    PLP
    CLC
    RTS

sub_C481B1:
    PHP
    REP #0x30
    PHA
    LDA z:unk_dboot_1C - dboot_ram_start
    JSR a:addr(send_command_on_apu_io_2_3)
    PLA
    JSR a:addr(send_command_on_apu_io_2_3_part_2)
    INC z:unk_dboot_1C - dboot_ram_start
    INC z:unk_dboot_1C - dboot_ram_start
    PLP
    RTS

dboot_send_4_byte_command:
    PHP
    REP #0x30
    LDA z:unk_dboot_64 - dboot_ram_start
    JSR a:addr(send_command_on_apu_io_2_3)
    LDA z:unk_dboot_68 - dboot_ram_start
    JSR a:addr(send_command_on_apu_io_2_3_part_2)
    PLP
    RTS

sub_C481D3:
    PHP
    REP #0x30
    LDA z:0x1C
    JSR a:addr(send_command_on_apu_io_2_3)
    LDY z:0x64
    STZ z:0x64
    LDA z:0x68
    INC A
    AND #0xFFFE
    LSR A
    TAX

.loc_C481E7:
    LDA f:[z:0x64], Y
    STA f:APU_I_O_PORT_2
    SEP #0x20
    LDA f:APU_I_O_PORT_0
    EOR #0x80
    AND #0x80
    STA f:APU_I_O_PORT_0

.loc_C481FB:
    CMP f:APU_I_O_PORT_0
    BNE .loc_C481FB
    REP #0x20
    INY
    INY
    BPL .loc_C48217

.loc_C48207:
    DEX
    BNE .loc_C481E7
    LDA z:0x1C
    CLC
    ADC z:0x68
    INC A
    AND #0xFFFE
    STA z:0x1C
    PLP
    RTS

.loc_C48217:
    INC z:0x66
    LDY #0x8000
    JML .loc_C48207

sub_C48220:
    PHP
    REP #0x30
    LDA z:0x1C
    JSR a:addr(send_command_on_apu_io_2_3)
    LDY z:0x64
    STZ z:0x64
    LDA z:0x68
    INC A
    AND #0xFFFE
    LSR A
    TAX

.loc_C48234:
    LDA f:[z:0x64], Y
    STA f:APU_I_O_PORT_2
    SEP #0x20
    LDA f:APU_I_O_PORT_0
    EOR #0x80
    AND #0x80
    STA f:APU_I_O_PORT_0

.loc_C48248:
    CMP f:APU_I_O_PORT_0
    BNE .loc_C48248
    REP #0x20
    INY
    INY
    DEX
    BNE .loc_C48234
    LDA z:0x1C
    CLC
    ADC z:0x68
    INC A
    AND #0xFFFE
    STA z:0x1C
    PLP
    RTS

send_command_on_apu_io_2_3:
    PHP
    REP #0x20
    STA f:APU_I_O_PORT_2
    SEP #0x20
    LDA f:APU_I_O_PORT_0
    EOR #0x80
    ORA #0x40
    STA f:APU_I_O_PORT_0

.loc_C48277:
    CMP f:APU_I_O_PORT_0
    BNE .loc_C48277
    PLP
    RTS

send_command_on_apu_io_2_3_part_2:
    PHP
    REP #0x20
    STA f:APU_I_O_PORT_2
    SEP #0x20
    LDA f:APU_I_O_PORT_0
    EOR #0x80
    AND #0x80
    STA f:APU_I_O_PORT_0

.loc_C48294:
    CMP f:APU_I_O_PORT_0
    BNE .loc_C48294
    PLP
    RTS

load_music_bank:
    PHP
    REP #0x20
    LDA #0x2200
    STA z:unk_dboot_1C - dboot_ram_start
    JSR a:addr(parse_music_bank)
    JSR a:addr(clear_sound_related_buffer)
    JSR a:addr(send_apu_command_3e)
    JSR a:addr(load_instruments)
    JSR a:addr(sub_C4863B)
    JSR a:addr(sub_C48728)
    JSR a:addr(sub_C4882B)
    JSR a:addr(sub_C4892E)
    JSR a:addr(sub_C489B7)
    JSR a:addr(sub_C484D1)
    PLP
    RTS

init_array_of_music_related_pointers:
    PHP
    REP #0x20
    SEP #0x10
    LDX #0

.loc_C482CB:
    LDA f:dboot_data_offsets, X
    XBA
    STA z:unk_dboot_66 - dboot_ram_start
    LDA f:dboot_data_offsets + 2, X
    XBA
    STA z:unk_dboot_64 - dboot_ram_start
    CMP #0x8000
    ROL z:unk_dboot_66 - dboot_ram_start
    CLC
    LDA z:unk_dboot_64 - dboot_ram_start
    AND #0x7FFF
    ADC #addr(dboot_data_offsets)
    ORA #0x8000
    STA z:array_of_music_related_pointers - number_of_music_banks, X
    LDA z:unk_dboot_66 - dboot_ram_start
    ADC #bank(dboot_data_offsets)
    STA z:array_of_music_related_pointers + 2 - number_of_music_banks, X
    INX
    INX
    INX
    INX
    CPX #0x18
    BNE .loc_C482CB
    LDY #0
    LDA f:[z:array_of_music_related_pointers - number_of_music_banks], Y
    XBA
    STA z:number_of_music_banks - number_of_music_banks
    LDA z:array_of_music_related_pointers - dboot_ram_start
    CLC
    ADC #2
    STA z:array_of_music_related_pointers - dboot_ram_start
    LDA z:array_of_music_related_pointers + 2 - number_of_music_banks
    ADC #0
    STA z:array_of_music_related_pointers + 2 - number_of_music_banks
    PLP
    RTS

parse_music_bank:
    PHP
    REP #0x30
    LDA #0
    TAY
    STA z:dboot_temp - dboot_ram_start
    LDA z:current_music_bank - dboot_ram_start
    CMP z:number_of_music_banks - number_of_music_banks
    BCC .loc_C48324
    STZ z:current_music_bank - dboot_ram_start

.loc_C48324:
    LDA z:dboot_temp - dboot_ram_start
    CMP z:current_music_bank - dboot_ram_start
    BNE .loc_C48331
    INY
    INY
    JSR a:addr(save_pointers_for_current_sound_bank) ; Pointer to the bank triplet
    BRA .loc_C48352

.loc_C48331:
    SEC
    LDA z:array_of_music_related_pointers - dboot_ram_start
    ADC f:[z:array_of_music_related_pointers - number_of_music_banks], Y
    STA z:array_of_music_related_pointers - dboot_ram_start
    LDA z:array_of_music_related_pointers+2 - dboot_ram_start
    ADC #0
    STA z:array_of_music_related_pointers+2 - dboot_ram_start
    SEC
    TYA
    ADC z:array_of_music_related_pointers - dboot_ram_start
    STA z:array_of_music_related_pointers - dboot_ram_start
    LDA #0
    ADC z:array_of_music_related_pointers+2 - dboot_ram_start
    STA z:array_of_music_related_pointers+2 - dboot_ram_start
    INC z:dboot_temp - dboot_ram_start
    JML .loc_C48324

.loc_C48352:
    PLP
    RTS

save_pointers_for_current_sound_bank:
i16
    PHP
    REP #0x20
    LDA #0
    SEP #0x20
    LDA f:[z:array_of_music_related_pointers - number_of_music_banks], Y
    REP #0x20 
    STA z:number_of_instruments - number_of_music_banks 
    TYA
    SEC
    ADC z:array_of_music_related_pointers - dboot_ram_start
    STA z:pointer_to_instrument_list - dboot_ram_start
    LDA #0
    ADC z:array_of_music_related_pointers+2 - dboot_ram_start
    STA z:pointer_to_instrument_list+2 - dboot_ram_start
    LDA z:pointer_to_instrument_list - dboot_ram_start
    CLC
    ADC z:number_of_instruments - number_of_music_banks
    STA z:array_of_music_related_pointers - dboot_ram_start
    LDA z:pointer_to_instrument_list+2 - dboot_ram_start
    ADC #0
    STA z:array_of_music_related_pointers+2 - dboot_ram_start
    LDY #0
    TYA
    SEP #0x20
    LDA f:[z:array_of_music_related_pointers - number_of_music_banks], Y
    REP #0x20 
    STA z:number_of_sounds - dboot_ram_start
    TYA
    SEC
    ADC z:array_of_music_related_pointers - dboot_ram_start
    STA z:pointer_to_sounds_list - dboot_ram_start
    LDA #0
    ADC z:array_of_music_related_pointers+2 - dboot_ram_start
    STA z:pointer_to_sounds_list+2 - dboot_ram_start
    LDA z:pointer_to_sounds_list - dboot_ram_start
    CLC
    ADC z:number_of_sounds - dboot_ram_start
    STA z:array_of_music_related_pointers - dboot_ram_start
    LDA z:pointer_to_sounds_list+2 - dboot_ram_start
    ADC #0
    STA z:array_of_music_related_pointers+2 - dboot_ram_start
    LDY #0
    TYA
    SEP #0x20
    LDA f:[z:array_of_music_related_pointers - number_of_music_banks], Y
    REP #0x20 
    STA z:number_of_musics_in_bank - dboot_ram_start
    TYA
    SEC
    ADC z:array_of_music_related_pointers - dboot_ram_start
    STA z:pointer_to_current_music_list - number_of_music_banks
    LDA #0
    ADC z:array_of_music_related_pointers+2 - dboot_ram_start
    STA z:pointer_to_current_music_list+2 - dboot_ram_start
    LDA z:pointer_to_current_music_list - number_of_music_banks
    CLC
    ADC z:number_of_musics_in_bank - dboot_ram_start
    STA z:array_of_music_related_pointers - dboot_ram_start
    LDA z:pointer_to_current_music_list+2 - dboot_ram_start
    ADC #0
    STA z:array_of_music_related_pointers+2 - dboot_ram_start
    PLP
    RTS

clear_sound_related_buffer:
    PHP
    SEP #0x30
    LDX #0x7F
    LDA #0xFF

.loc_C483D4:
    STA f:sound_related_buffer, X
    STA f:unk_7FFC80, X
    STA f:loaded_instruments, X
    STA f:unk_7FFD80, X
    STA f:unk_7FFE00, X
    DEX
    BPL .loc_C483D4
    PLP
    RTS

clear_dboot_data:
    PHP
    SEP #0x30
    LDX #0x7F

.loc_C483F2:
    STZ z:number_of_music_banks - number_of_music_banks, X
    DEX
    BPL .loc_C483F2
    REP #0x10
i16
    LDX #0x27F
    LDA #0

.loc_C483FE:
    STA f:0x7FFC00, X
    DEX
    BPL .loc_C483FE
    REP #0x20
    LDA #0xFFFF
    STA z:current_music_bank - dboot_ram_start
    PLP
    RTS

sub_C4840E:
    PHP
    REP #0x20
    LDA z:array_of_music_related_pointers+0xC - dboot_ram_start
    STA z:dboot_temp_pointer - dboot_ram_start
    LDA z:array_of_music_related_pointers+0xE - dboot_ram_start
    STA z:dboot_temp_pointer+2 - dboot_ram_start
    JSR a:addr(dboot_load_spc_program)
    JSR a:addr(sub_C484D1)
    PLP
    RTS

dboot_load_spc_program:
    PHP
    REP #0x30
    LDY z:dboot_temp_pointer - dboot_ram_start
    STZ z:dboot_temp_pointer - dboot_ram_start
    LDA #0xBBAA

.loc_C4842B:
    CMP f:APU_I_O_PORT_0
    BNE .loc_C4842B
    SEP #0x20
    LDA #0xCC
    BRA .loc_C48476

.loc_C48437:
    LDY #0x8000
    INC z:dboot_temp_pointer+2 - dboot_ram_start
    JML .loc_C4844E

.loc_C48440:
    LDY #0x8000
    INC z:dboot_temp_pointer+2 - dboot_ram_start
    JML .loc_C48459

.loc_C48449:
    LDA f:[z:dboot_temp_pointer - number_of_music_banks], Y
    INY
    BEQ .loc_C48437

.loc_C4844E:
    XBA
    LDA #0
    BRA .loc_C48461

.loc_C48453:
    XBA
    LDA f:[z:dboot_temp_pointer - number_of_music_banks], Y
    INY
    BEQ .loc_C48440

.loc_C48459:
    XBA

.loc_C4845A:
    CMP f:APU_I_O_PORT_0
    BNE .loc_C4845A
    INC A

.loc_C48461:
    REP #0x20
    STA f:APU_I_O_PORT_0
    SEP #0x20
    DEX
    BNE .loc_C48453

.loc_C4846C:
    CMP f:APU_I_O_PORT_0
    BNE .loc_C4846C

.loc_C48472:
    ADC #3
    BEQ .loc_C48472

.loc_C48476:
    PHA
    REP #0x20
    LDA f:[z:dboot_temp_pointer - number_of_music_banks], Y
    INY
    INY
    BPL .loc_C484A7

.loc_C4847F:
    TAX
    LDA f:[z:dboot_temp_pointer - number_of_music_banks], Y
    INY
    INY
    BPL .loc_C484AE

.loc_C48486:
    STA f:APU_I_O_PORT_2
    SEP #0x20
    CPX #1
    LDA #0
    ROL A
    STA f:APU_I_O_PORT_1
    ADC #0x7F
    PLA
    STA f:APU_I_O_PORT_0

.loc_C4849D:
    CMP f:APU_I_O_PORT_0
    BNE .loc_C4849D
    BVS .loc_C48449
    PLP
    RTS

.loc_C484A7:
    JSR a:addr(sub_C484B5)
    JML .loc_C4847F

.loc_C484AE:
    JSR a:addr(sub_C484B5)
    JML .loc_C48486

sub_C484B5:
    PHP
    REP #0x30
    PHA
    TYA
    ORA #0x8000
    TAY
    INC z:dboot_temp_pointer+2 - dboot_ram_start
    PLA
    PLP
    RTS

send_apu_command_3e:
    PHP
    REP #0x20
    LDA #0x3E
    JSR a:addr(send_7_bit_data_on_apu_io_0)
    JSR a:addr(apu_io2_related)
    PLP
    RTS

sub_C484D1:
    PHP
    REP #0x20
    LDA #0x968

.loc_C484D7:
    CMP f:APU_I_O_PORT_2
    BNE .loc_C484D7
    STZ z:0x76
    PLP
    RTS

apu_io2_related:
    PHP
    REP #0x20
    LDA #0
    STA f:APU_I_O_PORT_2
    LDA #0x265

.loc_C484EE:
    CMP f:APU_I_O_PORT_2
    BNE .loc_C484EE
    PHA
    LDA #0
    STA f:APU_I_O_PORT_0
    PLA
    STA f:APU_I_O_PORT_2
    PLP
    RTS

send_7_bit_data_on_apu_io_0:
    PHP
    SEP #0x20
    STA z:dboot_paramater_0 - dboot_ram_start
    LDA z:last_write_to_apu_io_0 - dboot_ram_start

.loc_C4850A:
    CMP f:APU_I_O_PORT_0
    BNE .loc_C4850A
    LDA f:APU_I_O_PORT_0
    EOR #0x80    ; Toggle the last bit every write
    AND #0x80
    ORA z:dboot_paramater_0 - dboot_ram_start
    STA f:APU_I_O_PORT_0
    STA z:last_write_to_apu_io_0 - dboot_ram_start
    PLP
    RTS

send_7_bit_data_on_apu_io_1:
    PHP
    SEP #0x20
    STA z:dboot_paramater_0 - dboot_ram_start
    LDA f:APU_I_O_PORT_1
    EOR #0x80
    AND #0x80
    ORA z:dboot_paramater_0 - dboot_ram_start
    STA f:APU_I_O_PORT_1
    PLP
    RTS

load_instruments:
    PHP
    REP #0x30
    LDA #0x800
    STA z:unk_dboot_64 - dboot_ram_start
    LDA z:unk_dboot_1C - dboot_ram_start
    STA z:unk_dboot_68 - dboot_ram_start
    JSR a:addr(dboot_send_4_byte_command)
    LDA z:number_of_instruments - number_of_music_banks
    STA z:instrument_loop_counter - dboot_ram_start
    ASL A
    CLC
    ADC z:unk_dboot_1C - dboot_ram_start
    STA z:dboot_paramater_0 - dboot_ram_start
    LDA z:pointer_to_instrument_list - dboot_ram_start
    STA z:dboot_temp_pointer - dboot_ram_start
    LDA z:pointer_to_instrument_list+2 - dboot_ram_start
    STA z:dboot_temp_pointer+2 - dboot_ram_start
    LDA z:array_of_music_related_pointers+4 - dboot_ram_start
    STA z:current_pointer_to_instrument_related_data - dboot_ram_start
    LDA z:array_of_music_related_pointers+6 - dboot_ram_start
    STA z:current_pointer_to_instrument_related_data+2 - dboot_ram_start
    LDY #2
    STZ z:number_of_loaded_instruments - dboot_ram_start

.loc_C48565:
    LDA z:dboot_paramater_0 - dboot_ram_start
    JSR a:addr(sub_C481B1)
    LDA #0
    SEP #0x20
    LDA f:[z:dboot_temp_pointer - number_of_music_banks]
    TAX
    LDA z:number_of_loaded_instruments - dboot_ram_start
    STA f:loaded_instruments, X
    INC z:number_of_loaded_instruments - dboot_ram_start
    REP #0x20 
    INC z:dboot_temp_pointer - dboot_ram_start
    BNE .loc_C48582
    INC z:dboot_temp_pointer+2 - dboot_ram_start

.loc_C48582:
    TXA
    ASL A
    ASL A
    CLC
    ADC #4
    TAY
    LDA f:[z:current_pointer_to_instrument_related_data - number_of_music_banks], Y
    XBA
    CLC
    ADC z:dboot_paramater_0 - dboot_ram_start
    STA z:dboot_paramater_0 - dboot_ram_start
    DEC z:instrument_loop_counter - dboot_ram_start
    BNE .loc_C48565
    LDA z:pointer_to_instrument_list - dboot_ram_start
    STA z:dboot_temp_pointer - dboot_ram_start
    LDA z:pointer_to_instrument_list+2 - dboot_ram_start
    STA z:dboot_temp_pointer+2 - dboot_ram_start
    LDA z:number_of_instruments - number_of_music_banks
    STA z:instrument_loop_counter - dboot_ram_start
    LDA z:array_of_music_related_pointers+4 - dboot_ram_start
    STA z:current_pointer_to_instrument_related_data - dboot_ram_start
    LDA z:array_of_music_related_pointers+6 - dboot_ram_start
    STA z:current_pointer_to_instrument_related_data+2 - dboot_ram_start
    STZ z:number_of_loaded_instruments - dboot_ram_start

.loc_C485AC:
    LDA #0
    SEP #0x20
    LDA f:[z:dboot_temp_pointer - number_of_music_banks]
    REP #0x20
    ASL A
    ASL A
    CLC
    ADC #2
    TAY
    INC z:dboot_temp_pointer - dboot_ram_start
    BNE .loc_C485C2
    INC z:0x52

.loc_C485C2:
    LDA f:[z:current_pointer_to_instrument_related_data - number_of_music_banks], Y
    XBA
    STA z:unk_dboot_34 - dboot_ram_start
    INY
    INY
    LDA f:[z:0x54], Y
    XBA
    LSR A
    LSR A
    LSR A
    LSR A
    STA z:0x38

.loc_C485D2:
    LDA z:unk_dboot_34 - dboot_ram_start
    CLC
    ADC #0xC
    TAY
    LDA #0
    SEP #0x20
    LDA f:[z:current_pointer_to_instrument_related_data - number_of_music_banks], Y
    TAX
    LDA f:unk_7FFD80, X
    CMP #0xFF
    BNE .loc_C485F1
    LDA z:number_of_loaded_instruments - dboot_ram_start
    STA f:0x7FFD80, X
    INC z:number_of_loaded_instruments - dboot_ram_start

.loc_C485F1:    
    REP #0x20 
    LDA z:unk_dboot_34 - dboot_ram_start
    CLC
    ADC z:current_pointer_to_instrument_related_data - dboot_ram_start
    STA z:unk_dboot_64 - dboot_ram_start
    LDA #0
    ADC z:current_pointer_to_instrument_related_data+2 - dboot_ram_start
    STA z:unk_dboot_66 - dboot_ram_start
    LDA #0x10
    STA z:unk_dboot_68 - dboot_ram_start
    JSR a:addr(sub_C481D3)
    LDA z:unk_dboot_34 - dboot_ram_start
    CLC
    ADC #0x10
    STA z:unk_dboot_34 - dboot_ram_start
    DEC z:unk_dboot_38 - dboot_ram_start
    BEQ .loc_C48619
    JML .loc_C485D2

.loc_C48619:
    DEC z:instrument_loop_counter - dboot_ram_start
    BEQ .loc_C48621
    JML .loc_C485AC

.loc_C48621:
    SEP #0x30
    LDY #0

.loc_C48625:
    TYX
    LDA f:0x7FFD80, X
    CMP #0xFF
    BEQ .loc_C48634
    TAX
    TYA
    STA f:0x7FFE00, X

.loc_C48634:
    INY
    CPY #0x80
    BNE .loc_C48625
    PLP
    RTS

sub_C4863B:
    PHP
    REP #0x30
    LDA z:0x1C
    AND #0xFF
    EOR #0xFFFF
    INC A
    CLC
    ADC #0x100
    AND #0xFF
    CLC
    ADC z:0x1C
    STA z:0x1C
    SEP #0x30
    LDX #0x7F
    STZ z:0x30

.loc_C48659:
    LDA f:0x7FFE00, X
    CMP #0xFF
    BEQ .loc_C48663
    INC z:0x30

.loc_C48663:
    DEX
    BPL .loc_C48659
    REP #0x30
    LDA z:0x30
    AND #0xFF
    ASL A
    ASL A
    CLC
    ADC z:0x1C
    STA z:0x30
    LDA #0x802
    STA z:0x64
    LDA z:0x1C
    STA z:0x68
    JSR a:addr(dboot_send_4_byte_command)
    LDA z:0xA
    STA z:0x50
    LDA z:0xC
    STA z:0x52
    LDA #0x80
    STA z:0x4C
    LDX #0

.loc_C48690:
    LDA f:0x7FFE00, X
    INX
    AND #0xFF
    CMP #0xFF
    BEQ .loc_C486C5
    ASL A
    ASL A
    ASL A
    CLC
    ADC #6
    TAY
    LDA f:[z:0x50], Y
    XBA
    CLC
    ADC z:0x30
    STA z:0x3C
    LDA z:0x30
    JSR a:addr(sub_C481B1)
    LDA z:0x3C
    JSR a:addr(sub_C481B1)
    DEY
    DEY
    LDA f:[z:0x50], Y
    XBA
    CLC
    ADC z:0x30
    INC A
    AND #0xFFFE
    STA z:0x30

.loc_C486C5:
    DEC z:0x4C
    BEQ .loc_C486CD
    JML .loc_C48690

.loc_C486CD:
    LDA z:0xA
    STA z:0x50
    LDA z:0xC
    STA z:0x52
    LDA #0x80
    STA z:0x4C
    LDX #0

.loc_C486DD:
    LDA f:0x7FFE00, X
    INX
    AND #0xFF
    CMP #0xFF
    BEQ .loc_C4871E
    ASL A
    ASL A
    ASL A
    TAY
    LDA f:[z:0x50], Y
    XBA
    STA z:0x66
    INY
    INY
    LDA f:[z:0x50], Y
    XBA
    STA z:0x64
    CMP #0x8000
    ROL z:0x66
    CLC
    LDA z:0x64
    AND #0x7FFF
    ADC z:0x50
    ORA #0x8000
    STA z:0x64
    LDA z:0x66
    ADC z:0x52
    STA z:0x66
    INY
    INY
    LDA f:[z:0x50], Y
    XBA
    STA z:0x68
    PHX
    JSR a:addr(sub_C481D3)
    PLX

.loc_C4871E:
    DEC z:0x4C
    BEQ .loc_C48726
    JML .loc_C486DD

.loc_C48726:
    PLP
    RTS

sub_C48728:
    PHP
    REP #0x30
    LDA #0x804
    STA z:0x64
    LDA z:0x1C
    STA z:0x68
    JSR a:addr(dboot_send_4_byte_command)
    LDA z:0x20
    BNE .loc_C4873F
    JML .loc_C48829

.loc_C4873F:
    STA z:0x4C
    INC A
    ASL A
    CLC
    ADC z:0x1C
    STA z:0x30
    LDA z:0x4C
    XBA
    JSR a:addr(sub_C481B1)
    LDA z:0x28
    STA z:0x50
    LDA z:0x2A
    STA z:0x52
    LDA z:0x12
    STA z:0x54
    LDA z:0x14
    STA z:0x56
    STZ z:0x3C

.loc_C48760:
    LDA z:0x30
    JSR a:addr(sub_C481B1)
    LDA f:[z:0x50]
    INC z:0x50
    BNE .loc_C4876D
    INC z:0x52

.loc_C4876D:
    AND #0xFF
    TAX
    SEP #0x20
    LDA z:0x3C
    STA f:0x7FFC80, X
    INC z:0x3C
    REP #0x20
    TXA
    ASL A
    ASL A
    ASL A
    CLC
    ADC #8
    CLC
    ADC z:0x54
    ORA #0x8000
    STA z:0x58
    LDA #0
    ADC z:0x56
    STA z:0x5A
    LDA f:[z:0x58]
    XBA
    CLC
    ADC z:0x30
    INC A
    AND #0xFFFE
    STA z:0x30
    DEC z:0x4C
    BNE .loc_C48760
    LDA z:0x28
    STA z:0x50
    LDA z:0x2A
    STA z:0x52
    LDA z:0x20
    STA z:0x4C
    LDA z:0x12
    STA z:0x54
    LDA z:0x14
    STA z:0x56

.loc_C487B8:
    LDA f:[z:0x50]
    INC z:0x50
    BNE .loc_C487C0
    INC z:0x52

.loc_C487C0:
    AND #0xFF
    ASL A
    ASL A
    ASL A
    INC A
    INC A
    CLC
    ADC z:0x54
    ORA #0x8000
    STA z:0x58
    LDA #0
    ADC z:0x56
    STA z:0x5A
    LDA f:[z:0x58]
    XBA
    STA z:0x66
    LDA z:0x58
    CLC
    ADC #2
    ORA #0x8000
    STA z:0x58
    LDA z:0x5A
    ADC #0
    STA z:0x5A
    LDA f:[z:0x58]
    XBA
    STA z:0x64
    CMP #0x8000
    ROL z:0x66
    CLC
    LDA z:0x64
    AND #0x7FFF
    ADC z:0x54
    ORA #0x8000
    STA z:0x64
    LDA z:0x66
    ADC z:0x56
    STA z:0x66
    LDA z:0x58
    CLC
    ADC #4
    ORA #0x8000
    STA z:0x58
    LDA z:0x5A
    ADC #0
    STA z:0x5A
    LDA f:[z:0x58]
    XBA
    STA z:0x68
    JSR a:addr(sub_C481D3)
    DEC z:0x4C
    BNE .loc_C487B8

.loc_C48829:
    PLP
    RTS

sub_C4882B:
    PHP
    REP #0x30
    LDA #0x806
    STA z:0x64
    LDA z:0x1C
    STA z:0x68
    JSR a:addr(dboot_send_4_byte_command)
    LDA z:0x22
    BNE .loc_C48842
    JML .loc_C4892C

.loc_C48842:
    STA z:0x4C
    INC A
    ASL A
    CLC
    ADC z:0x1C
    STA z:0x30
    LDA z:0x4C
    XBA
    JSR a:addr(sub_C481B1)
    LDA z:0x2C
    STA z:0x50
    LDA z:0x2E
    STA z:0x52
    LDA z:0x16
    STA z:0x54
    LDA z:0x18
    STA z:0x56
    STZ z:0x3C

.loc_C48863:
    LDA z:0x30
    JSR a:addr(sub_C481B1)
    LDA f:[z:0x50]
    INC z:0x50
    BNE .loc_C48870
    INC z:0x52

.loc_C48870:
    AND #0xFF
    TAX
    SEP #0x20
    LDA z:0x3C
    STA f:0x7FFC00, X
    INC z:0x3C
    REP #0x20
    TXA
    ASL A
    ASL A
    ASL A
    CLC
    ADC #8
    CLC
    ADC z:0x54
    ORA #0x8000
    STA z:0x58
    LDA #0
    ADC z:0x56
    STA z:0x5A
    LDA f:[z:0x58]

    XBA
    CLC
    ADC z:0x30
    INC A
    AND #0xFFFE
    STA z:0x30
    DEC z:0x4C
    BNE .loc_C48863
    LDA z:0x2C
    STA z:0x50
    LDA z:0x2E
    STA z:0x52
    LDA z:0x22
    STA z:0x4C
    LDA z:0x16
    STA z:0x54
    LDA z:0x18
    STA z:0x56

.loc_C488BB:
    LDA f:[z:0x50]
    INC z:0x50
    BNE .loc_C488C3
    INC z:0x52

.loc_C488C3:
    AND #0xFF
    ASL A
    ASL A
    ASL A
    INC A
    INC A
    CLC
    ADC z:0x54
    ORA #0x8000
    STA z:0x58
    LDA #0
    ADC z:0x56
    STA z:0x5A
    LDA f:[z:0x58]
    XBA
    STA z:0x66
    LDA z:0x58
    CLC
    ADC #2
    ORA #0x8000
    STA z:0x58
    LDA z:0x5A
    ADC #0
    STA z:0x5A
    LDA f:[z:0x58]
    XBA
    STA z:0x64
    CMP #0x8000
    ROL z:0x66
    CLC
    LDA z:0x64
    AND #0x7FFF
    ADC z:0x54
    ORA #0x8000
    STA z:0x64
    LDA z:0x66
    ADC z:0x56
    STA z:0x66
    LDA z:0x58
    CLC
    ADC #4
    ORA #0x8000
    STA z:0x58
    LDA z:0x5A
    ADC #0
    STA z:0x5A
    LDA f:[z:0x58]
    XBA
    STA z:0x68
    JSR a:addr(sub_C481D3)
    DEC z:0x4C
    BNE .loc_C488BB

.loc_C4892C:
    PLP
    RTS

sub_C4892E:
    PHP
    REP #0x30
    LDA #0x808
    STA z:0x64
    LDA z:0x1C
    STA z:0x68
    JSR a:addr(dboot_send_4_byte_command)
    LDA #0xFC00
    STA z:0x64
    LDA #0x7F
    STA z:0x66
    LDA #0x80
    STA z:0x68
    JSR a:addr(sub_C48220)
    LDA #0x80A
    STA z:0x64
    LDA z:0x1C
    STA z:0x68
    JSR a:addr(dboot_send_4_byte_command)
    LDA #0xFC80
    STA z:0x64
    LDA #0x7F
    STA z:0x66
    LDA #0x80
    STA z:0x68
    JSR a:addr(sub_C48220)
    LDA #0x80C
    STA z:0x64
    LDA z:0x1C
    STA z:0x68
    JSR a:addr(dboot_send_4_byte_command)
    LDA #0xFD00
    STA z:0x64
    LDA #0x7F
    STA z:0x66
    LDA #0x80
    STA z:0x68
    JSR a:addr(sub_C48220)
    LDA #0x80E
    STA z:0x64
    LDA z:0x1C
    STA z:0x68
    JSR a:addr(dboot_send_4_byte_command)
    LDA #0xFD80
    STA z:0x64
    LDA #0x7F
    STA z:0x66
    LDA #0x80
    STA z:0x68
    JSR a:addr(sub_C48220)
    LDA #0x810
    STA z:0x64
    LDA z:0x74
    STA z:0x68
    JSR a:addr(dboot_send_4_byte_command)
    PLP
    RTS

sub_C489B7:
    PHP
    SEP #0x20
    LDA f:APU_I_O_PORT_0
    EOR #0x80
    ORA #1
    STA f:APU_I_O_PORT_0
    PLP
    RTS

