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
