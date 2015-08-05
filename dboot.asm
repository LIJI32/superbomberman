FILL $C48000
.A16
.I16

dboot_command:				
		BRA	loc_C48012
; ---------------------------------------------------------------------------
.ASCIIZ " DBOOT VER1.03 "
; ---------------------------------------------------------------------------

loc_C48012:				
		PHP
		PHB
		PHD
		REP	#$30 
		PHA
		PHX
		PHY
		PHX
		LDX	#.LOWORD(dboot_ram_start)
		PHX
		PLD
; D=100
		PHK
		PLB
; ds=C4000 B=C4
		AND	#$FF
		ASL
		TAX
		JMP	(.LOWORD(dboot_commands_array),X) 
; ---------------------------------------------------------------------------

loc_C4802A:				
		PLY
		PLX
		PLA
		PLD
		PLB
		PLP
		RTL
; End of function dboot_command

; ---------------------------------------------------------------------------
dboot_commands_array:
        .ADDR dboot_init_internal,	sub_C48076; 0 
		.ADDR sub_C48085, sub_C48099; 2
		.ADDR sub_C480A6, sub_C480B3; 4
		.ADDR dboot_init_internal, dboot_init_internal;	6
		.ADDR dboot_init_internal, dboot_init_internal;	8
		.ADDR dboot_init_internal, dboot_init_internal;	$A
		.ADDR dboot_init_internal, dboot_init_internal;	$C
		.ADDR dboot_init_internal, dboot_init_internal;	$E
		.ADDR sub_C480CC, sub_C480CC; $10
		.ADDR sub_C480CC, play_music_internal; $12
		.ADDR play_sound_internal, fade_out_music_internal; $14
		.ADDR sub_C48114, sub_C48123; $16
		.ADDR sub_C48132, sub_C48141; $18
		.ADDR sub_C48150	; $1A
.A16
.I16

dboot_init_internal:			
		PLX
		PHP
		REP	#$30 
		JSR	a:.LOWORD(clear_dboot_data) 
		JSR	a:.LOWORD(init_array_of_music_related_pointers) 
		PLP
		JML	f:loc_C4802A	
; End of function dboot_init_internal

.A16
.I16

sub_C48076:				
		PLX
		PHP
		REP	#$30 
		JSR	a:.LOWORD(init_array_of_music_related_pointers) 
		JSR	a:.LOWORD(sub_C4840E)	
		PLP
		JML	f:loc_C4802A	
; End of function sub_C48076

.A16
.I16

sub_C48085:				
		PLX
		PHP
		REP	#$30 
		TYA
		PHA
		JSR	a:.LOWORD(init_array_of_music_related_pointers) 
		PLA
		STA	z:$1A		
		JSR	a:.LOWORD(load_music_bank)	
		PLP
		JML	f:loc_C4802A	
; End of function sub_C48085

.A16
.I16

sub_C48099:				
		PLX
		PHP
		REP	#$30 
		TYA
		JSR	a:.LOWORD(send_7_bit_data_on_apu_io_0) 
		PLP
		JML	f:loc_C4802A	
; End of function sub_C48099

.A16
.I16

sub_C480A6:				
		PLX
		PHP
		REP	#$30 
		TYA
		JSR	a:.LOWORD(send_7_bit_data_on_apu_io_1) 
		PLP
		JML	f:loc_C4802A	
; End of function sub_C480A6

.A16
.I16

sub_C480B3:				
		PLX
		PHP
		REP	#$30 
		PHX
		PHY
		JSR	a:.LOWORD(init_array_of_music_related_pointers) 
		STZ	z:$1A		
		PLY
		PLX
		STY	z:2		
		STX	z:4		
		JSR	a:.LOWORD(load_music_bank)	
		PLP
		JML	f:loc_C4802A	
; End of function sub_C480B3

.A16
.I16

sub_C480CC:				
		PLX
		PHP
		REP	#$30 
		JSR	a:.LOWORD(clear_dboot_data) 
		JSR	a:.LOWORD(init_array_of_music_related_pointers) 
		JSR	a:.LOWORD(sub_C4840E)	
		PLP
		JML	f:loc_C4802A	
; End of function sub_C480CC

.A16
.I16

play_music_internal:			
		PLX
		PHP
		REP	#$30 
		PHY
		TYA
		JSR	a:.LOWORD(play_music_return_should_reload_bank) 
		BCC	loc_C480EF
		JSR	a:.LOWORD(init_array_of_music_related_pointers) 
		JSR	a:.LOWORD(load_music_bank)	

loc_C480EF:				
		PLA
		JSR	a:.LOWORD(send_7_bit_data_on_apu_io_0) 
		PLP
		JML	f:loc_C4802A	
; End of function play_music_internal

.A16
.I16

play_sound_internal:			
		PLX
		PHP
		REP	#$30 
		TYA
		JSR	a:.LOWORD(send_7_bit_data_on_apu_io_1) 
		PLP
		JML	f:loc_C4802A	
; End of function play_sound_internal

.A16
.I16

fade_out_music_internal:		
		PLX
		PHP
		REP	#$30 
		LDA	#$3B 
		JSR	a:.LOWORD(send_7_bit_data_on_apu_io_0) 
		PLP
		JML	f:loc_C4802A	
; End of function fade_out_music_internal

.A16
.I16

sub_C48114:				
		PLX
		PHP
		REP	#$30 
		LDA	#$3A 
		JSR	a:.LOWORD(send_7_bit_data_on_apu_io_0) 
		PLP
		JML	f:loc_C4802A	
; End of function sub_C48114

.A16
.I16

sub_C48123:				
		PLX
		PHP
		REP	#$30 
		LDA	#$39 
		JSR	a:.LOWORD(send_7_bit_data_on_apu_io_0) 
		PLP
		JML	f:loc_C4802A	
; End of function sub_C48123

.A16
.I16

sub_C48132:				
		PLX
		PHP
		REP	#$30 
		LDA	#$38 
		JSR	a:.LOWORD(send_7_bit_data_on_apu_io_0) 
		PLP
		JML	f:loc_C4802A	
; End of function sub_C48132

.A16
.I16

sub_C48141:				
		PLX
		PHP
		REP	#$30 
		TYA
		AND	#$FF
		STA	z:$74		
		PLP
		JML	f:loc_C4802A	
; End of function sub_C48141

.A16
.I16

sub_C48150:				
		PLX
		PHP
		REP	#$30 
		LDA	#$3F 
		JSR	a:.LOWORD(send_7_bit_data_on_apu_io_0) 
		PLP
		JML	f:loc_C4802A	
; End of function sub_C48150

.A16
.I16

play_music_return_should_reload_bank:	
		PHP
		REP	#$30 
		AND	#$3F 
		STA	z:dboot_internal_parameter - dboot_ram_start
		LDA	z:current_music_bank - dboot_ram_start
		INC
		BEQ	loc_C48177
		JSR	a:.LOWORD(init_array_of_music_related_pointers) 
		JSR	a:.LOWORD(parse_music_bank) 
		JSR	a:.LOWORD(is_music_in_current_bank) 
		BCC	loc_C48193

loc_C48177:				
		STZ	z:current_music_bank - dboot_ram_start

loc_C48179:				
		JSR	a:.LOWORD(init_array_of_music_related_pointers) 
		JSR	a:.LOWORD(parse_music_bank) 
		JSR	a:.LOWORD(is_music_in_current_bank) 
		BCC	loc_C48190
		INC	z:current_music_bank - dboot_ram_start
		LDA	z:0		
		CMP	z:current_music_bank - dboot_ram_start
		BNE	loc_C48179
		JML	f:loc_C48193	
; ---------------------------------------------------------------------------

loc_C48190:				
		PLP
		SEC
		RTS
; ---------------------------------------------------------------------------

loc_C48193:				
		PLP
		CLC
		RTS
; End of function play_music_return_should_reload_bank

.A16
.I16

is_music_in_current_bank:		
		PHP
		SEP	#$20 
.A8
		SEP	#$10
.I8
		LDY	#0
		LDX	z:number_of_musics_in_bank - dboot_ram_start
		BEQ	loc_C481AB

loc_C481A1:				
		LDA	[pointer_to_current_music_list - number_of_music_banks],Y 
		CMP	z:dboot_internal_parameter - dboot_ram_start
		BEQ	loc_C481AE
		INY
		DEX
		BNE	loc_C481A1

loc_C481AB:				
		PLP
.A16
.I16
		SEC
		RTS
; ---------------------------------------------------------------------------

loc_C481AE:				
		PLP
		CLC
		RTS
; End of function is_music_in_current_bank

.A16
.I16

sub_C481B1:				
		PHP
		REP	#$30 
		PHA
		LDA	z:unk_7E011C - dboot_ram_start
		JSR	a:.LOWORD(send_command_on_apu_io_2_3) 
		PLA
		JSR	a:.LOWORD(send_command_on_apu_io_2_3_part_2) 
		INC	z:unk_7E011C - dboot_ram_start
		INC	z:unk_7E011C - dboot_ram_start
		PLP
		RTS
; End of function sub_C481B1

.A16
.I16

dboot_send_4_byte_command:		
		PHP
		REP	#$30 
		LDA	z:unk_7E0164 - dboot_ram_start
		JSR	a:.LOWORD(send_command_on_apu_io_2_3) 
		LDA	z:unk_7E0168 - dboot_ram_start
		JSR	a:.LOWORD(send_command_on_apu_io_2_3_part_2) 
		PLP
		RTS
; End of function dboot_send_4_byte_command

.A16
.I16

sub_C481D3:				
		PHP
		REP	#$30 
		LDA	z:$1C		
		JSR	a:.LOWORD(send_command_on_apu_io_2_3) 
		LDY	z:$64		
		STZ	z:$64		
		LDA	z:$68		
		INC
		AND	#$FFFE
		LSR
		TAX

loc_C481E7:				
		LDA	[$64],Y	
		STA	f:APU_I_O_PORT_2	
		SEP	#$20 
.A8
		LDA	f:APU_I_O_PORT_0	
		EOR	#$80 
		AND	#$80 
		STA	f:APU_I_O_PORT_0	

loc_C481FB:				
		CMP	f:APU_I_O_PORT_0	
		BNE	loc_C481FB
		REP	#$20 
.A16
		INY
		INY
		BPL	loc_C48217

loc_C48207:				
		DEX
		BNE	loc_C481E7
		LDA	z:$1C		
		CLC
		ADC	z:$68		
		INC
		AND	#$FFFE
		STA	z:$1C		
		PLP
		RTS
; ---------------------------------------------------------------------------

loc_C48217:				
		INC	z:$66		
		LDY	#$8000
		JML	f:loc_C48207	
; End of function sub_C481D3

.A16
.I16

sub_C48220:				
		PHP
		REP	#$30 
		LDA	z:$1C		
		JSR	a:.LOWORD(send_command_on_apu_io_2_3) 
		LDY	z:$64		
		STZ	z:$64		
		LDA	z:$68		
		INC
		AND	#$FFFE
		LSR
		TAX

loc_C48234:				
		LDA	[$64],Y	
		STA	f:APU_I_O_PORT_2	
		SEP	#$20 
.A8
		LDA	f:APU_I_O_PORT_0
		EOR	#$80 
		AND	#$80 
		STA	f:APU_I_O_PORT_0

loc_C48248:				
		CMP	f:APU_I_O_PORT_0
		BNE	loc_C48248
		REP	#$20 
.A16
		INY
		INY
		DEX
		BNE	loc_C48234
		LDA	z:$1C		
		CLC
		ADC	z:$68		
		INC
		AND	#$FFFE
		STA	z:$1C		
		PLP
		RTS
; End of function sub_C48220

.A16
.I16

send_command_on_apu_io_2_3:		
		PHP
		REP	#$20 
		STA	f:APU_I_O_PORT_2	
		SEP	#$20 
.A8
		LDA	f:APU_I_O_PORT_0	
		EOR	#$80 
		ORA	#$40 
		STA	f:APU_I_O_PORT_0	

loc_C48277:				
		CMP	f:APU_I_O_PORT_0	
		BNE	loc_C48277
		PLP
.A16
		RTS
; End of function send_command_on_apu_io_2_3

.A16
.I16

send_command_on_apu_io_2_3_part_2:	
		PHP
		REP	#$20 
		STA	f:APU_I_O_PORT_2	
		SEP	#$20 
.A8
		LDA	f:APU_I_O_PORT_0	
		EOR	#$80 
		AND	#$80 
		STA	f:APU_I_O_PORT_0	

loc_C48294:				
		CMP	f:APU_I_O_PORT_0	
		BNE	loc_C48294
		PLP
.A16
		RTS
; End of function send_command_on_apu_io_2_3_part_2

.A16
.I16

load_music_bank:			
		PHP
		REP	#$20 
		LDA	#$2200
		STA	z:unk_7E011C - dboot_ram_start
		JSR	a:.LOWORD(parse_music_bank) 
		JSR	a:.LOWORD(clear_sound_related_buffer) 
		JSR	a:.LOWORD(send_apu_command_3e) 
		JSR	a:.LOWORD(load_instruments) 
		JSR	a:.LOWORD(sub_C4863B)	
		JSR	a:.LOWORD(sub_C48728)	
		JSR	a:.LOWORD(sub_C4882B)	
		JSR	a:.LOWORD(sub_C4892E)	
		JSR	a:.LOWORD(sub_C489B7)	
		JSR	a:.LOWORD(sub_C484D1)	
		PLP
		RTS
; End of function load_music_bank

.A16
.I16

init_array_of_music_related_pointers:	
		PHP
		REP	#$20 
		SEP	#$10
.I8
		LDX	#0

loc_C482CB:				
		LDA	f:dboot_data_offsets,X 
		XBA
		STA	z:unk_7E0166 - dboot_ram_start
		LDA	f:dboot_data_offsets + 2,X 
		XBA
		STA	z:unk_7E0164 - dboot_ram_start
		CMP	#$8000
		ROL	z:unk_7E0166 - dboot_ram_start
		CLC
		LDA	z:unk_7E0164 - dboot_ram_start
		AND	#$7FFF
		ADC	#.LOWORD(dboot_data_offsets)
		ORA	#$8000
		STA	z:array_of_music_related_pointers - number_of_music_banks,X 
		LDA	z:unk_7E0166 - dboot_ram_start
		ADC	#.BANKBYTE(dboot_data_offsets)
		STA	z:array_of_music_related_pointers + 2 -	number_of_music_banks,X	
		INX
		INX
		INX
		INX
		CPX	#$18
		BNE	loc_C482CB
		LDY	#0
		LDA	[array_of_music_related_pointers - number_of_music_banks],Y ;	
		XBA
		STA	z:number_of_music_banks	- number_of_music_banks	
		LDA	z:array_of_music_related_pointers - dboot_ram_start
		CLC
		ADC	#2
		STA	z:array_of_music_related_pointers - dboot_ram_start
		LDA	z:array_of_music_related_pointers + 2 -	number_of_music_banks ;	
		ADC	#0
		STA	z:array_of_music_related_pointers + 2 -	number_of_music_banks ;	
		PLP
.I16
		RTS
; End of function init_array_of_music_related_pointers

.A16
.I16

parse_music_bank:			
		PHP
		REP	#$30 
		LDA	#0
		TAY
		STA	z:dboot_temp - dboot_ram_start
		LDA	z:current_music_bank - dboot_ram_start
		CMP	z:number_of_music_banks	- number_of_music_banks	
		BCC	loc_C48324
		STZ	z:current_music_bank - dboot_ram_start

loc_C48324:				
		LDA	z:dboot_temp - dboot_ram_start
		CMP	z:current_music_bank - dboot_ram_start
		BNE	loc_C48331
		INY
		INY
		JSR	a:.LOWORD(save_pointers_for_current_sound_bank) ; Pointer to the bank triplet
		BRA	loc_C48352
; ---------------------------------------------------------------------------

loc_C48331:				
		SEC
		LDA	z:array_of_music_related_pointers - dboot_ram_start
		ADC	[array_of_music_related_pointers - number_of_music_banks],Y ;	
		STA	z:array_of_music_related_pointers - dboot_ram_start
		LDA	z:array_of_music_related_pointers+2 - dboot_ram_start
		ADC	#0
		STA	z:array_of_music_related_pointers+2 - dboot_ram_start
		SEC
		TYA
		ADC	z:array_of_music_related_pointers - dboot_ram_start
		STA	z:array_of_music_related_pointers - dboot_ram_start
		LDA	#0
		ADC	z:array_of_music_related_pointers+2 - dboot_ram_start
		STA	z:array_of_music_related_pointers+2 - dboot_ram_start
		INC	z:dboot_temp - dboot_ram_start
		JML	f:loc_C48324	
; ---------------------------------------------------------------------------

loc_C48352:				
		PLP
		RTS
; End of function parse_music_bank

.A16
.I16

save_pointers_for_current_sound_bank:	
		PHP
		REP	#$20 
		LDA	#0
		SEP	#$20 
.A8
		LDA	[array_of_music_related_pointers - number_of_music_banks],Y ;	
		REP	#$20 
.A16
		STA	z:number_of_instruments	- number_of_music_banks	
		TYA
		SEC
		ADC	z:array_of_music_related_pointers - dboot_ram_start
		STA	z:pointer_to_instrument_list - dboot_ram_start
		LDA	#0
		ADC	z:array_of_music_related_pointers+2 - dboot_ram_start
		STA	z:pointer_to_instrument_list+2 - dboot_ram_start
		LDA	z:pointer_to_instrument_list - dboot_ram_start
		CLC
		ADC	z:number_of_instruments	- number_of_music_banks	
		STA	z:array_of_music_related_pointers - dboot_ram_start
		LDA	z:pointer_to_instrument_list+2 - dboot_ram_start
		ADC	#0
		STA	z:array_of_music_related_pointers+2 - dboot_ram_start
		LDY	#0
		TYA
		SEP	#$20 
.A8
		LDA	[array_of_music_related_pointers - number_of_music_banks],Y ;	
		REP	#$20 
.A16
		STA	z:number_of_sounds - dboot_ram_start
		TYA
		SEC
		ADC	z:array_of_music_related_pointers - dboot_ram_start
		STA	z:pointer_to_sounds_list - dboot_ram_start
		LDA	#0
		ADC	z:array_of_music_related_pointers+2 - dboot_ram_start
		STA	z:pointer_to_sounds_list+2 - dboot_ram_start
		LDA	z:pointer_to_sounds_list - dboot_ram_start
		CLC
		ADC	z:number_of_sounds - dboot_ram_start
		STA	z:array_of_music_related_pointers - dboot_ram_start
		LDA	z:pointer_to_sounds_list+2 - dboot_ram_start
		ADC	#0
		STA	z:array_of_music_related_pointers+2 - dboot_ram_start
		LDY	#0
		TYA
		SEP	#$20 
.A8
		LDA	[array_of_music_related_pointers - number_of_music_banks],Y ;	
		REP	#$20 
.A16
		STA	z:number_of_musics_in_bank - dboot_ram_start
		TYA
		SEC
		ADC	z:array_of_music_related_pointers - dboot_ram_start
		STA	z:pointer_to_current_music_list	- number_of_music_banks	
		LDA	#0
		ADC	z:array_of_music_related_pointers+2 - dboot_ram_start
		STA	z:pointer_to_current_music_list+2 - dboot_ram_start
		LDA	z:pointer_to_current_music_list	- number_of_music_banks	
		CLC
		ADC	z:number_of_musics_in_bank - dboot_ram_start
		STA	z:array_of_music_related_pointers - dboot_ram_start
		LDA	z:pointer_to_current_music_list+2 - dboot_ram_start
		ADC	#0
		STA	z:array_of_music_related_pointers+2 - dboot_ram_start
		PLP
		RTS
; End of function save_pointers_for_current_sound_bank

.A16
.I16

clear_sound_related_buffer:		
		PHP
		SEP	#$30 
.A8
.I8
		LDX	#$7F 
		LDA	#$FF

loc_C483D4:				
		STA	f:sound_related_buffer,X 
		STA	f:unk_7FFC80,X	
		STA	f:loaded_instruments,X 
		STA	f:unk_7FFD80,X	
		STA	f:unk_7FFE00,X	
		DEX
		BPL	loc_C483D4
		PLP
.A16
.I16
		RTS
; End of function clear_sound_related_buffer

.A16
.I16

clear_dboot_data:			
		PHP
		SEP	#$30 
.A8
.I8
		LDX	#$7F 

loc_C483F2:				
		STZ	z:number_of_music_banks	- number_of_music_banks,X 
		DEX
		BPL	loc_C483F2
		REP	#$10
.I16
		LDX	#$27F
		LDA	#0

loc_C483FE:				
		STA	f:$7FFC00,X	
		DEX
		BPL	loc_C483FE
		REP	#$20 
.A16
		LDA	#$FFFF
		STA	z:current_music_bank - dboot_ram_start
		PLP
		RTS
; End of function clear_dboot_data

.A16
.I16

sub_C4840E:				
		PHP
		REP	#$20 
		LDA	z:array_of_music_related_pointers+$C - dboot_ram_start
		STA	z:dboot_temp_pointer - dboot_ram_start
		LDA	z:array_of_music_related_pointers+$E - dboot_ram_start
		STA	z:dboot_temp_pointer+2 - dboot_ram_start
		JSR	a:.LOWORD(dboot_load_spc_program) 
		JSR	a:.LOWORD(sub_C484D1)	
		PLP
		RTS
; End of function sub_C4840E

.A16
.I16

dboot_load_spc_program:			
		PHP
		REP	#$30 
		LDY	z:dboot_temp_pointer - dboot_ram_start
		STZ	z:dboot_temp_pointer - dboot_ram_start
		LDA	#$BBAA

loc_C4842B:				
		CMP	f:APU_I_O_PORT_0	
		BNE	loc_C4842B
		SEP	#$20 
.A8
		LDA	#$CC 
		BRA	loc_C48476
; ---------------------------------------------------------------------------

loc_C48437:				
		LDY	#$8000
		INC	z:dboot_temp_pointer+2 - dboot_ram_start
		JML	f:loc_C4844E	
; ---------------------------------------------------------------------------

loc_C48440:				
		LDY	#$8000
		INC	z:dboot_temp_pointer+2 - dboot_ram_start
		JML	f:loc_C48459	
; ---------------------------------------------------------------------------

loc_C48449:				
		LDA	[dboot_temp_pointer -	number_of_music_banks],Y 
		INY
		BEQ	loc_C48437

loc_C4844E:				
		XBA
		LDA	#0
		BRA	loc_C48461
; ---------------------------------------------------------------------------

loc_C48453:				
		XBA
		LDA	[dboot_temp_pointer -	number_of_music_banks],Y 
		INY
		BEQ	loc_C48440

loc_C48459:				
		XBA

loc_C4845A:				
		CMP	f:APU_I_O_PORT_0	
		BNE	loc_C4845A
		INC

loc_C48461:				
		REP	#$20 
.A16
		STA	f:APU_I_O_PORT_0	
		SEP	#$20 
.A8
		DEX
		BNE	loc_C48453

loc_C4846C:				
		CMP	f:APU_I_O_PORT_0	
		BNE	loc_C4846C

loc_C48472:				
		ADC	#3
		BEQ	loc_C48472

loc_C48476:				
		PHA
		REP	#$20 
.A16
		LDA	[dboot_temp_pointer -	number_of_music_banks],Y 
		INY
		INY
		BPL	loc_C484A7

loc_C4847F:				
		TAX
		LDA	[dboot_temp_pointer -	number_of_music_banks],Y 
		INY
		INY
		BPL	loc_C484AE

loc_C48486:				
		STA	f:APU_I_O_PORT_2	
		SEP	#$20 
.A8
		CPX	#1
		LDA	#0
		ROL
		STA	f:APU_I_O_PORT_1	
		ADC	#$7F 
		PLA
		STA	f:APU_I_O_PORT_0	

loc_C4849D:				
		CMP	f:APU_I_O_PORT_0	
		BNE	loc_C4849D
		BVS	loc_C48449
		PLP
.A16
		RTS
; ---------------------------------------------------------------------------

loc_C484A7:				
		JSR	a:.LOWORD(sub_C484B5)	
		JML	f:loc_C4847F	
; ---------------------------------------------------------------------------

loc_C484AE:				
		JSR	a:.LOWORD(sub_C484B5)	
		JML	f:loc_C48486	
; End of function dboot_load_spc_program

.A16
.I16

sub_C484B5:				
		PHP
		REP	#$30 
		PHA
		TYA
		ORA	#$8000
		TAY
		INC	z:dboot_temp_pointer+2 - dboot_ram_start
		PLA
		PLP
		RTS
; End of function sub_C484B5

.A16
.I16

send_apu_command_3e:			
		PHP
		REP	#$20 
		LDA	#$3E 
		JSR	a:.LOWORD(send_7_bit_data_on_apu_io_0) 
		JSR	a:.LOWORD(apu_io2_related)	
		PLP
		RTS
; End of function send_apu_command_3e

.A16
.I16

sub_C484D1:				
		PHP
		REP	#$20 
		LDA	#$968

loc_C484D7:				
		CMP	f:APU_I_O_PORT_2
		BNE	loc_C484D7
		STZ	z:$76		
		PLP
		RTS
; End of function sub_C484D1

.A16
.I16

apu_io2_related:			
		PHP
		REP	#$20 
		LDA	#0
		STA	f:APU_I_O_PORT_2	
		LDA	#$265

loc_C484EE:				
		CMP	f:APU_I_O_PORT_2	
		BNE	loc_C484EE
		PHA
		LDA	#0
		STA	f:APU_I_O_PORT_0	
		PLA
		STA	f:APU_I_O_PORT_2	
		PLP
		RTS
; End of function apu_io2_related

.A16
.I16

send_7_bit_data_on_apu_io_0:		
		PHP
		SEP	#$20 
.A8
		STA	z:dboot_internal_parameter - dboot_ram_start
		LDA	z:last_write_to_apu_io_0 - dboot_ram_start

loc_C4850A:				
		CMP	f:APU_I_O_PORT_0	
		BNE	loc_C4850A
		LDA	f:APU_I_O_PORT_0	
		EOR	#$80       ; Toggle the last bit every write
		AND	#$80 
		ORA	z:dboot_internal_parameter - dboot_ram_start
		STA	f:APU_I_O_PORT_0	
		STA	z:last_write_to_apu_io_0 - dboot_ram_start
		PLP
.A16
		RTS
; End of function send_7_bit_data_on_apu_io_0

.A16
.I16

send_7_bit_data_on_apu_io_1:		
		PHP
		SEP	#$20 
.A8
		STA	z:dboot_internal_parameter - dboot_ram_start
		LDA	f:APU_I_O_PORT_1	
		EOR	#$80 
		AND	#$80 
		ORA	z:dboot_internal_parameter - dboot_ram_start
		STA	f:APU_I_O_PORT_1	
		PLP
.A16
		RTS
; End of function send_7_bit_data_on_apu_io_1

.A16
.I16

load_instruments:			
		PHP
		REP	#$30 
		LDA	#$800
		STA	z:unk_7E0164 - dboot_ram_start
		LDA	z:unk_7E011C - dboot_ram_start
		STA	z:unk_7E0168 - dboot_ram_start
		JSR	a:.LOWORD(dboot_send_4_byte_command) 
		LDA	z:number_of_instruments	- number_of_music_banks	
		STA	z:instrument_loop_counter - dboot_ram_start
		ASL
		CLC
		ADC	z:unk_7E011C - dboot_ram_start
		STA	z:dboot_internal_parameter - dboot_ram_start
		LDA	z:pointer_to_instrument_list - dboot_ram_start
		STA	z:dboot_temp_pointer - dboot_ram_start
		LDA	z:pointer_to_instrument_list+2 - dboot_ram_start
		STA	z:dboot_temp_pointer+2 - dboot_ram_start
		LDA	z:array_of_music_related_pointers+4 - dboot_ram_start
		STA	z:current_pointer_to_instrument_related_data - dboot_ram_start
		LDA	z:array_of_music_related_pointers+6 - dboot_ram_start
		STA	z:current_pointer_to_instrument_related_data+2 - dboot_ram_start
		LDY	#2
		STZ	z:number_of_loaded_instruments - dboot_ram_start

loc_C48565:				
		LDA	z:dboot_internal_parameter - dboot_ram_start
		JSR	a:.LOWORD(sub_C481B1)	
		LDA	#0
		SEP	#$20 
.A8
		LDA	[dboot_temp_pointer -	number_of_music_banks] 
		TAX
		LDA	z:number_of_loaded_instruments - dboot_ram_start
		STA	f:loaded_instruments,X 
		INC	z:number_of_loaded_instruments - dboot_ram_start
		REP	#$20 
.A16
		INC	z:dboot_temp_pointer - dboot_ram_start
		BNE	loc_C48582
		INC	z:dboot_temp_pointer+2 - dboot_ram_start

loc_C48582:				
		TXA
		ASL
		ASL
		CLC
		ADC	#4
		TAY
		LDA	[current_pointer_to_instrument_related_data -	number_of_music_banks],Y 
		XBA
		CLC
		ADC	z:dboot_internal_parameter - dboot_ram_start
		STA	z:dboot_internal_parameter - dboot_ram_start
		DEC	z:instrument_loop_counter - dboot_ram_start
		BNE	loc_C48565
		LDA	z:pointer_to_instrument_list - dboot_ram_start
		STA	z:dboot_temp_pointer - dboot_ram_start
		LDA	z:pointer_to_instrument_list+2 - dboot_ram_start
		STA	z:dboot_temp_pointer+2 - dboot_ram_start
		LDA	z:number_of_instruments	- number_of_music_banks	
		STA	z:instrument_loop_counter - dboot_ram_start
		LDA	z:array_of_music_related_pointers+4 - dboot_ram_start
		STA	z:current_pointer_to_instrument_related_data - dboot_ram_start
		LDA	z:array_of_music_related_pointers+6 - dboot_ram_start
		STA	z:current_pointer_to_instrument_related_data+2 - dboot_ram_start
		STZ	z:number_of_loaded_instruments - dboot_ram_start

loc_C485AC:				
		LDA	#0
		SEP	#$20 
.A8
		LDA	[dboot_temp_pointer -	number_of_music_banks] 
		REP	#$20 
.A16
		ASL
		ASL
		CLC
		ADC	#2
		TAY
		INC	z:dboot_temp_pointer - dboot_ram_start
		BNE	loc_C485C2
		INC	z:$52		

loc_C485C2:				
		LDA	[current_pointer_to_instrument_related_data -	number_of_music_banks],Y 
		XBA
		STA	z:unk_7E0134 - dboot_ram_start
		INY
		INY
		LDA	[$54],Y	
		XBA
		LSR
		LSR
		LSR
		LSR
		STA	z:$38		

loc_C485D2:				
		LDA	z:unk_7E0134 - dboot_ram_start
		CLC
		ADC	#$C
		TAY
		LDA	#0
		SEP	#$20 
.A8
		LDA	[current_pointer_to_instrument_related_data -	number_of_music_banks],Y 
		TAX
		LDA	f:unk_7FFD80,X	
		CMP	#$FF
		BNE	loc_C485F1
		LDA	z:number_of_loaded_instruments - dboot_ram_start
		STA	f:$7FFD80,X	
		INC	z:number_of_loaded_instruments - dboot_ram_start

loc_C485F1:				
		REP	#$20 
.A16
		LDA	z:unk_7E0134 - dboot_ram_start
		CLC
		ADC	z:current_pointer_to_instrument_related_data - dboot_ram_start
		STA	z:unk_7E0164 - dboot_ram_start
		LDA	#0
		ADC	z:current_pointer_to_instrument_related_data+2 - dboot_ram_start
		STA	z:unk_7E0166 - dboot_ram_start
		LDA	#$10
		STA	z:unk_7E0168 - dboot_ram_start
		JSR	a:.LOWORD(sub_C481D3)	
		LDA	z:unk_7E0134 - dboot_ram_start
		CLC
		ADC	#$10
		STA	z:unk_7E0134 - dboot_ram_start
		DEC	z:unk_7E0138 - dboot_ram_start
		BEQ	loc_C48619
		JML	f:loc_C485D2	
; ---------------------------------------------------------------------------

loc_C48619:				
		DEC	z:instrument_loop_counter - dboot_ram_start
		BEQ	loc_C48621
		JML	f:loc_C485AC	
; ---------------------------------------------------------------------------

loc_C48621:				
		SEP	#$30 
.A8
.I8
		LDY	#0

loc_C48625:				
		TYX
		LDA	f:$7FFD80,X	
		CMP	#$FF
		BEQ	loc_C48634
		TAX
		TYA
		STA	f:$7FFE00,X	

loc_C48634:				
		INY
		CPY	#$80 
		BNE	loc_C48625
		PLP
.A16
.I16
		RTS
; End of function load_instruments

.A16
.I16

sub_C4863B:				
		PHP
		REP	#$30 
		LDA	z:$1C		
		AND	#$FF
		EOR	#$FFFF
		INC
		CLC
		ADC	#$100
		AND	#$FF
		CLC
		ADC	z:$1C		
		STA	z:$1C		
		SEP	#$30 
.A8
.I8
		LDX	#$7F 
		STZ	z:$30		

loc_C48659:				
		LDA	f:$7FFE00,X	
		CMP	#$FF
		BEQ	loc_C48663
		INC	z:$30		

loc_C48663:				
		DEX
		BPL	loc_C48659
		REP	#$30 
.A16
.I16
		LDA	z:$30		
		AND	#$FF
		ASL
		ASL
		CLC
		ADC	z:$1C		
		STA	z:$30		
		LDA	#$802
		STA	z:$64		
		LDA	z:$1C		
		STA	z:$68		
		JSR	a:.LOWORD(dboot_send_4_byte_command) 
		LDA	z:$A		
		STA	z:$50		
		LDA	z:$C		
		STA	z:$52		
		LDA	#$80 
		STA	z:$4C		
		LDX	#0

loc_C48690:				
		LDA	f:$7FFE00,X	
		INX
		AND	#$FF
		CMP	#$FF
		BEQ	loc_C486C5
		ASL
		ASL
		ASL
		CLC
		ADC	#6
		TAY
		LDA	[$50],Y	
		XBA
		CLC
		ADC	z:$30		
		STA	z:$3C		
		LDA	z:$30		
		JSR	a:.LOWORD(sub_C481B1)	
		LDA	z:$3C		
		JSR	a:.LOWORD(sub_C481B1)	
		DEY
		DEY
		LDA	[$50],Y	
		XBA
		CLC
		ADC	z:$30		
		INC
		AND	#$FFFE
		STA	z:$30		

loc_C486C5:				
		DEC	z:$4C		
		BEQ	loc_C486CD
		JML	f:loc_C48690	
; ---------------------------------------------------------------------------

loc_C486CD:				
		LDA	z:$A		
		STA	z:$50		
		LDA	z:$C		
		STA	z:$52		
		LDA	#$80 
		STA	z:$4C		
		LDX	#0

loc_C486DD:				
		LDA	f:$7FFE00,X	
		INX
		AND	#$FF
		CMP	#$FF
		BEQ	loc_C4871E
		ASL
		ASL
		ASL
		TAY
		LDA	[$50],Y	
		XBA
		STA	z:$66		
		INY
		INY
		LDA	[$50],Y	
		XBA
		STA	z:$64		
		CMP	#$8000
		ROL	z:$66		
		CLC
		LDA	z:$64		
		AND	#$7FFF
		ADC	z:$50		
		ORA	#$8000
		STA	z:$64		
		LDA	z:$66		
		ADC	z:$52		
		STA	z:$66		
		INY
		INY
		LDA	[$50],Y	
		XBA
		STA	z:$68		
		PHX
		JSR	a:.LOWORD(sub_C481D3)	
		PLX

loc_C4871E:				
		DEC	z:$4C		
		BEQ	loc_C48726
		JML	f:loc_C486DD	
; ---------------------------------------------------------------------------

loc_C48726:				
		PLP
		RTS
; End of function sub_C4863B

.A16
.I16

sub_C48728:				
		PHP
		REP	#$30 
		LDA	#$804
		STA	z:$64		
		LDA	z:$1C		
		STA	z:$68		
		JSR	a:.LOWORD(dboot_send_4_byte_command) 
		LDA	z:$20		
		BNE	loc_C4873F
		JML	f:loc_C48829	
; ---------------------------------------------------------------------------

loc_C4873F:				
		STA	z:$4C		
		INC
		ASL
		CLC
		ADC	z:$1C		
		STA	z:$30		
		LDA	z:$4C		
		XBA
		JSR	a:.LOWORD(sub_C481B1)	
		LDA	z:$28		
		STA	z:$50		
		LDA	z:$2A		
		STA	z:$52		
		LDA	z:$12		
		STA	z:$54		
		LDA	z:$14		
		STA	z:$56		
		STZ	z:$3C		

loc_C48760:				
		LDA	z:$30		
		JSR	a:.LOWORD(sub_C481B1)	
		LDA	[$50]		
		INC	z:$50		
		BNE	loc_C4876D
		INC	z:$52		

loc_C4876D:				
		AND	#$FF
		TAX
		SEP	#$20 
.A8
		LDA	z:$3C		
		STA	f:$7FFC80,X	
		INC	z:$3C		
		REP	#$20 
.A16
		TXA
		ASL
		ASL
		ASL
		CLC
		ADC	#8
		CLC
		ADC	z:$54		
		ORA	#$8000
		STA	z:$58		
		LDA	#0
		ADC	z:$56		
		STA	z:$5A		
		LDA	[$58]		
		XBA
		CLC
		ADC	z:$30		
		INC
		AND	#$FFFE
		STA	z:$30		
		DEC	z:$4C		
		BNE	loc_C48760
		LDA	z:$28		
		STA	z:$50		
		LDA	z:$2A		
		STA	z:$52		
		LDA	z:$20		
		STA	z:$4C		
		LDA	z:$12		
		STA	z:$54		
		LDA	z:$14		
		STA	z:$56		

loc_C487B8:				
		LDA	[$50]		
		INC	z:$50		
		BNE	loc_C487C0
		INC	z:$52		

loc_C487C0:				
		AND	#$FF
		ASL
		ASL
		ASL
		INC
		INC
		CLC
		ADC	z:$54		
		ORA	#$8000
		STA	z:$58		
		LDA	#0
		ADC	z:$56		
		STA	z:$5A		
		LDA	[$58]		
		XBA
		STA	z:$66		
		LDA	z:$58		
		CLC
		ADC	#2
		ORA	#$8000
		STA	z:$58		
		LDA	z:$5A		
		ADC	#0
		STA	z:$5A		
		LDA	[$58]		
		XBA
		STA	z:$64		
		CMP	#$8000
		ROL	z:$66		
		CLC
		LDA	z:$64		
		AND	#$7FFF
		ADC	z:$54		
		ORA	#$8000
		STA	z:$64		
		LDA	z:$66		
		ADC	z:$56		
		STA	z:$66		
		LDA	z:$58		
		CLC
		ADC	#4
		ORA	#$8000
		STA	z:$58		
		LDA	z:$5A		
		ADC	#0
		STA	z:$5A		
		LDA	[$58]		
		XBA
		STA	z:$68		
		JSR	a:.LOWORD(sub_C481D3)	
		DEC	z:$4C		
		BNE	loc_C487B8

loc_C48829:				
		PLP
		RTS
; End of function sub_C48728

.A16
.I16

sub_C4882B:				
		PHP
		REP	#$30 
		LDA	#$806
		STA	z:$64		
		LDA	z:$1C		
		STA	z:$68		
		JSR	a:.LOWORD(dboot_send_4_byte_command) 
		LDA	z:$22		
		BNE	loc_C48842
		JML	f:loc_C4892C	
; ---------------------------------------------------------------------------

loc_C48842:				
		STA	z:$4C		
		INC
		ASL
		CLC
		ADC	z:$1C		
		STA	z:$30		
		LDA	z:$4C		
		XBA
		JSR	a:.LOWORD(sub_C481B1)	
		LDA	z:$2C		
		STA	z:$50		
		LDA	z:$2E		
		STA	z:$52		
		LDA	z:$16		
		STA	z:$54		
		LDA	z:$18		
		STA	z:$56		
		STZ	z:$3C		

loc_C48863:				
		LDA	z:$30		
		JSR	a:.LOWORD(sub_C481B1)	
		LDA	[$50]		
		INC	z:$50		
		BNE	loc_C48870
		INC	z:$52		

loc_C48870:				
		AND	#$FF
		TAX
		SEP	#$20 
.A8
		LDA	z:$3C		
		STA	f:$7FFC00,X	
		INC	z:$3C		
		REP	#$20 
.A16
		TXA
		ASL
		ASL
		ASL
		CLC
		ADC	#8
		CLC
		ADC	z:$54		
		ORA	#$8000
		STA	z:$58		
		LDA	#0
		ADC	z:$56		
		STA	z:$5A		
		LDA	[$58]		
		XBA
		CLC
		ADC	z:$30		
		INC
		AND	#$FFFE
		STA	z:$30		
		DEC	z:$4C		
		BNE	loc_C48863
		LDA	z:$2C		
		STA	z:$50		
		LDA	z:$2E		
		STA	z:$52		
		LDA	z:$22		
		STA	z:$4C		
		LDA	z:$16		
		STA	z:$54		
		LDA	z:$18		
		STA	z:$56		

loc_C488BB:				
		LDA	[$50]		
		INC	z:$50		
		BNE	loc_C488C3
		INC	z:$52		

loc_C488C3:				
		AND	#$FF
		ASL
		ASL
		ASL
		INC
		INC
		CLC
		ADC	z:$54		
		ORA	#$8000
		STA	z:$58		
		LDA	#0
		ADC	z:$56		
		STA	z:$5A		
		LDA	[$58]		
		XBA
		STA	z:$66		
		LDA	z:$58		
		CLC
		ADC	#2
		ORA	#$8000
		STA	z:$58		
		LDA	z:$5A		
		ADC	#0
		STA	z:$5A		
		LDA	[$58]		
		XBA
		STA	z:$64		
		CMP	#$8000
		ROL	z:$66		
		CLC
		LDA	z:$64		
		AND	#$7FFF
		ADC	z:$54		
		ORA	#$8000
		STA	z:$64		
		LDA	z:$66		
		ADC	z:$56		
		STA	z:$66		
		LDA	z:$58		
		CLC
		ADC	#4
		ORA	#$8000
		STA	z:$58		
		LDA	z:$5A		
		ADC	#0
		STA	z:$5A		
		LDA	[$58]		
		XBA
		STA	z:$68		
		JSR	a:.LOWORD(sub_C481D3)	
		DEC	z:$4C		
		BNE	loc_C488BB

loc_C4892C:				
		PLP
		RTS
; End of function sub_C4882B

.A16
.I16

sub_C4892E:				
		PHP
		REP	#$30 
		LDA	#$808
		STA	z:$64		
		LDA	z:$1C		
		STA	z:$68		
		JSR	a:.LOWORD(dboot_send_4_byte_command) 
		LDA	#$FC00
		STA	z:$64		
		LDA	#$7F 
		STA	z:$66		
		LDA	#$80 
		STA	z:$68		
		JSR	a:.LOWORD(sub_C48220)	
		LDA	#$80A
		STA	z:$64		
		LDA	z:$1C		
		STA	z:$68		
		JSR	a:.LOWORD(dboot_send_4_byte_command) 
		LDA	#$FC80
		STA	z:$64		
		LDA	#$7F 
		STA	z:$66		
		LDA	#$80 
		STA	z:$68		
		JSR	a:.LOWORD(sub_C48220)	
		LDA	#$80C
		STA	z:$64		
		LDA	z:$1C		
		STA	z:$68		
		JSR	a:.LOWORD(dboot_send_4_byte_command) 
		LDA	#$FD00
		STA	z:$64		
		LDA	#$7F 
		STA	z:$66		
		LDA	#$80 
		STA	z:$68		
		JSR	a:.LOWORD(sub_C48220)	
		LDA	#$80E
		STA	z:$64		
		LDA	z:$1C		
		STA	z:$68		
		JSR	a:.LOWORD(dboot_send_4_byte_command) 
		LDA	#$FD80
		STA	z:$64		
		LDA	#$7F 
		STA	z:$66		
		LDA	#$80 
		STA	z:$68		
		JSR	a:.LOWORD(sub_C48220)	
		LDA	#$810
		STA	z:$64		
		LDA	z:$74		
		STA	z:$68		
		JSR	a:.LOWORD(dboot_send_4_byte_command) 
		PLP
		RTS
; End of function sub_C4892E

.A16
.I16

sub_C489B7:				
		PHP
		SEP	#$20 
.A8
		LDA	f:APU_I_O_PORT_0	
		EOR	#$80 
		ORA	#1
		STA	f:APU_I_O_PORT_0	
		PLP
.A16
		RTS
; End of function sub_C489B7

; ---------------------------------------------------------------------------
