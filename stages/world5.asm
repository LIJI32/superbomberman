stage_5_1:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 5			; spawn_and_flags
        .BYTE $80		; $80 here sets a flags that disables "automatic" detection
				        ; of hard block and free spaces tiles, and forces the hard
				        ; coded values of 0804 and 0808. It is used in all stages in
				        ; world 5.
        .WORD 2			; screen_mode
        .WORD $30		; saved_to_d3a
        .FARADDR arena_graphic		; tileset_bank
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR arena_level_structure
        .FARADDR empty_tilemap
        .WORD $51		; level_representation
        .WORD 0			; hard_blocks
        .WORD 0			; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR arena_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR off_C31D6D
        .WORD $10
        .BYTE 0
        .FARADDR loc_C436C1
        .FARADDR locret_C463DD
        .FARADDR tile_animation
        .FARADDR byte_C536D5
        .WORD $20
        .FARADDR tile_animation
        .FARADDR byte_C53716
        .WORD $22
        .FARADDR tile_animation
        .FARADDR byte_C53716+$61
        .WORD $24
        .FARADDR tile_animation
        .FARADDR byte_C537C4
        .WORD $26
        .WORD $F0F0
        .WORD 0
        .WORD 0
stage_5_2:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 5			; spawn_and_flags
        .BYTE $80		; more_flags
        .WORD 2			; screen_mode
        .WORD $30		; saved_to_d3a
        .FARADDR arena_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR arena_level_structure
        .FARADDR empty_tilemap
        .WORD $52		; level_representation
        .WORD 0			; hard_blocks
        .WORD 0			; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR arena_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR off_C31D6D
        .WORD $10
        .BYTE 0
        .FARADDR loc_C436C1
        .FARADDR locret_C463DD
        .FARADDR tile_animation
        .FARADDR byte_C536D5
        .WORD $20
        .FARADDR tile_animation
        .FARADDR byte_C53716
        .WORD $22
        .FARADDR tile_animation
        .FARADDR byte_C53716+$61
        .WORD $24
        .FARADDR tile_animation
        .FARADDR byte_C537C4
        .WORD $26
        .WORD $F0F0
        .WORD 0
        .WORD 0
stage_5_3:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 5			; spawn_and_flags
        .BYTE $80		; more_flags
        .WORD 2			; screen_mode
        .WORD $30		; saved_to_d3a
        .FARADDR arena_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR arena_level_structure
        .FARADDR empty_tilemap
        .WORD $53		; level_representation
        .WORD 0			; hard_blocks
        .WORD 0			; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR arena_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR off_C31D6D
        .WORD $10
        .BYTE 0
        .FARADDR loc_C436C1
        .FARADDR locret_C463DD
        .FARADDR tile_animation
        .FARADDR byte_C536D5
        .WORD $20
        .FARADDR tile_animation
        .FARADDR byte_C53716
        .WORD $22
        .FARADDR tile_animation
        .FARADDR byte_C53716+$61
        .WORD $24
        .FARADDR tile_animation
        .FARADDR byte_C537C4
        .WORD $26
        .WORD $F0F0
        .WORD 0
        .WORD 0
stage_5_4:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 5			; spawn_and_flags
        .BYTE $80		; more_flags
        .WORD 2			; screen_mode
        .WORD $30		; saved_to_d3a
        .FARADDR arena_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR arena_level_structure
        .FARADDR empty_tilemap
        .WORD $54		; level_representation
        .WORD 0			; hard_blocks
        .WORD 0			; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR arena_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR off_C31D6D
        .WORD $10
        .BYTE 0
        .FARADDR loc_C436C1
        .FARADDR locret_C463DD
        .FARADDR tile_animation
        .FARADDR byte_C536D5
        .WORD $20
        .FARADDR tile_animation
        .FARADDR byte_C53716
        .WORD $22
        .FARADDR tile_animation
        .FARADDR byte_C53716+$61
        .WORD $24
        .FARADDR tile_animation
        .FARADDR byte_C537C4
        .WORD $26
        .WORD $F0F0
        .WORD 0
        .WORD 0
stage_5_5:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 5			; spawn_and_flags
        .BYTE $80		; more_flags
        .WORD 2			; screen_mode
        .WORD $30		; saved_to_d3a
        .FARADDR arena_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR arena_level_structure
        .FARADDR empty_tilemap
        .WORD $55		; level_representation
        .WORD 0			; hard_blocks
        .WORD 0			; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR arena_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR off_C31D6D
        .WORD $10
        .BYTE 0
        .FARADDR loc_C436C1
        .FARADDR locret_C463DD
        .FARADDR tile_animation
        .FARADDR byte_C536D5
        .WORD $20
        .FARADDR tile_animation
        .FARADDR byte_C53716
        .WORD $22
        .FARADDR tile_animation
        .FARADDR byte_C53716+$61
        .WORD $24
        .FARADDR tile_animation
        .FARADDR byte_C537C4
        .WORD $26
        .WORD $F0F0
        .WORD 0
        .WORD 0
stage_5_6:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 5			; spawn_and_flags
        .BYTE $80		; more_flags
        .WORD 2			; screen_mode
        .WORD $30		; saved_to_d3a
        .FARADDR arena_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR arena_level_structure
        .FARADDR empty_tilemap
        .WORD $56		; level_representation
        .WORD 0			; hard_blocks
        .WORD 0			; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR arena_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR off_C31D6D
        .WORD $10
        .BYTE 0
        .FARADDR loc_C436C1
        .FARADDR locret_C463DD
        .FARADDR tile_animation
        .FARADDR byte_C536D5
        .WORD $20
        .FARADDR tile_animation
        .FARADDR byte_C53716
        .WORD $22
        .FARADDR tile_animation
        .FARADDR byte_C53716+$61
        .WORD $24
        .FARADDR tile_animation
        .FARADDR byte_C537C4
        .WORD $26
        .WORD $F0F0
        .WORD 0
        .WORD 0
stage_5_7:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 5			; spawn_and_flags
        .BYTE $80		; more_flags
        .WORD 2			; screen_mode
        .WORD $30		; saved_to_d3a
        .FARADDR arena_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR arena_level_structure
        .FARADDR empty_tilemap
        .WORD $57		; level_representation
        .WORD 0			; hard_blocks
        .WORD 0			; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR arena_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR off_C31D6D
        .WORD $10
        .BYTE 0
        .FARADDR loc_C436C1
        .FARADDR locret_C463DD
        .FARADDR tile_animation
        .FARADDR byte_C536D5
        .WORD $20
        .FARADDR tile_animation
        .FARADDR byte_C53716
        .WORD $22
        .FARADDR tile_animation
        .FARADDR byte_C53716+$61
        .WORD $24
        .FARADDR tile_animation
        .FARADDR byte_C537C4
        .WORD $26
        .WORD $F0F0
        .WORD 0
        .WORD 0
stage_5_8:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 5			; spawn_and_flags
        .BYTE $80		; more_flags
        .WORD 2			; screen_mode
        .WORD $50		; saved_to_d3a
        .FARADDR arena_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR arena_level_structure
        .FARADDR empty_tilemap
        .WORD $58		; level_representation
        .WORD 0			; hard_blocks
        .WORD 0			; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR arena_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR off_C31D6D
        .WORD $10
        .BYTE 0
        .FARADDR loc_C436C1
        .FARADDR locret_C463DD
        .FARADDR tile_animation
        .FARADDR byte_C536D5
        .WORD $20
        .FARADDR tile_animation
        .FARADDR byte_C53716
        .WORD $22
        .FARADDR tile_animation
        .FARADDR byte_C53716+$61
        .WORD $24
        .FARADDR tile_animation
        .FARADDR byte_C537C4
        .WORD $26
        .WORD $F0F0
        .WORD 0
        .WORD 0
arena_palettes:	.BYTE HUD_PALETTE, ARENA_PALETTE_1, ARENA_PALETTE_2, ARENA_PALETTE_3; a_palettes
.BYTE BONUS_PALETTE_1, BONUS_PALETTE_2,	ARENA_BOMB_PALETTE; a_palettes
.BYTE ARENA_FIRE_PALETTE; a_palettes
.BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
.BYTE MECHA_BOMBER_GOLD_PALETTE, ARENA_GATE_PALETTE, BLACK_PALETTE; b_palettes
.BYTE WHITE_PALETTE	; b_palettes
off_C31D6D:	.FARADDR bomberman_graphic_0
        .FARADDR bomberman_graphic_1
        .FARADDR bomberman_graphic_2
        .FARADDR bomberman_graphic_3
        .FARADDR mecha_bomberman_graphic_0
        .FARADDR mecha_bomberman_graphic_1
        .FARADDR mecha_bomberman_graphic_2
        .FARADDR mecha_bomberman_graphic_3
        .FARADDR mook_graphic_0
        .FARADDR mook_graphic_1
        .FARADDR carat_diamond_graphic_0
        .FARADDR carat_diamond_graphic_1
        .FARADDR carat_diamond_graphic_2
        .FARADDR arena_gate_graphic
        .FARADDR bomb_graphic
        .FARADDR time_up_graphic_0
