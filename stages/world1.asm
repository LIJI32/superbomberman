stage_1_1:	.BYTE $E		; saved_to_d1c
		.BYTE 0
		; Bit   1 and 2: Spawn spot index (story mode only)
		; Bit   4: Disables not-allowed soft-block locations, and exist in Story Mode
		; Bit   8: Western mode (Breaks story mode)
		; Bit $10: Speed Mode (Battle mode only)
		; Bit $20: Required for warps to work. Disable soft blocks on warp
		; Bit $40: Trampolines
		; Bit $80: Unused?
		.BYTE 1			; Spawn spot index and flags
		; Bit   1: Power Mode (Battle mode only)
		; Bit   2: Western mode, but without not-allowed soft-block locations (Battle mode only)
		; Bit   4: Required for Light Zone to correctly display the scoreboard
		; Bit   8: Disable soft blocks inside tunnels in tunnel zone
		; Bit $10: Belt Mode
		; Bit $20: Unused?
		; Bit $40: Used in Flower Zone, NOT related to flower growth, tractors or clouds.
		; Bit $80: Default tile and pallete IDs for hard block and empty tiles
		.BYTE 0			; More flags
		.WORD 2			; screen_mode
		.WORD $50		; saved_to_d3a
		.FARADDR peace_town_graphic ; Tileset graphic
		.FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
		.FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
		.FARADDR peace_town_level_structure ; Level structure
		.FARADDR empty_tilemap ; Foreground Tilemap
		.WORD $11		; level_representation
		.WORD 8			; hard_blocks
		.WORD 32		; soft_blocks
					; Off by one in	story mode, for	the level exit
		.FARADDR load_palettes; Init functions and their parameters
		.FARADDR peace_town_palettes
		.WORD $10 ; Number of palettes
		.BYTE 0 ; Unused?
		.FARADDR load_global_sprites
		.FARADDR standard_level_graphics
		.WORD $10 ; Number of graphic lists
		.BYTE 0 ; Unused?
		.FARADDR tile_animation
		.FARADDR peace_town_unshaded_soft_animation ; Animation definition
		.WORD 6 ; Tile id to animate
		.FARADDR tile_animation
		.FARADDR peace_town_shaded_soft_animation ; Animation definition
		.WORD 2 ; Tile id to animate
		.WORD $F0F0		; F0F0 marks the end of the init function list
		; List of enemy create functions
		.FARADDR create_propene
		.FARADDR create_propene
		.FARADDR create_propene
		.WORD 0			; null terminator
		.WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_1_2:	.BYTE $E		; saved_to_d1c
		.BYTE 0
		.BYTE 1			; spawn_and_flags
		.BYTE 0			; more_flags
		.WORD 2			; screen_mode
		.WORD $50		; saved_to_d3a
		.FARADDR peace_town_graphic
		.FARADDR bomb_and_explosions_graphic
		.FARADDR empty_tilemap
		.FARADDR peace_town_level_structure
		.FARADDR empty_tilemap
		.WORD $12		; level_representation
		.WORD 6			; hard_blocks
		.WORD 34		; soft_blocks
					; Off by one in	story mode, for	the level exit
		.FARADDR load_palettes
		.FARADDR peace_town_palettes
		.WORD $10
		.BYTE 0
		.FARADDR load_global_sprites
		.FARADDR standard_level_graphics
		.WORD $10
		.BYTE 0
		.FARADDR tile_animation
		.FARADDR peace_town_unshaded_soft_animation
		.WORD 6
		.FARADDR tile_animation
		.FARADDR peace_town_shaded_soft_animation
		.WORD 2
		.FARADDR hidden_bonus_object
		.WORD 7
		.BYTE 0
		.WORD $18
		.BYTE 0
		.WORD $F0F0
		.FARADDR create_propene
		.FARADDR create_propene
		.FARADDR create_propene
		.FARADDR create_denkyun
		.FARADDR create_denkyun
		.WORD 0
		.WORD BOMB_UP, SPEED_UP, 0
stage_1_3:	.BYTE $F		; saved_to_d1c
		.BYTE 0
		.BYTE 1			; spawn_and_flags
		.BYTE 0			; more_flags
		.WORD 2			; screen_mode
		.WORD $50		; saved_to_d3a
		.FARADDR village_graphic
		.FARADDR bomb_and_explosions_graphic
		.FARADDR empty_tilemap
		.FARADDR village_level_structure
		.FARADDR empty_tilemap
		.WORD $13		; level_representation
		.WORD 6			; hard_blocks
		.WORD 34		; soft_blocks
					; Off by one in	story mode, for	the level exit
		.FARADDR load_palettes
		.FARADDR village_palettes
		.WORD $10
		.BYTE 0
		.FARADDR load_global_sprites
		.FARADDR standard_level_graphics
		.WORD $10
		.BYTE 0
		.FARADDR hidden_bonus_object
		.WORD 6
		.BYTE 0
		.WORD POPSICLE
		.BYTE 0
		.WORD $F0F0
		.FARADDR create_starnuts
		.FARADDR create_starnuts
		.FARADDR create_starnuts
		.FARADDR create_starnuts
		.FARADDR create_starnuts
		.FARADDR create_starnuts
		.FARADDR create_starnuts
		.FARADDR create_starnuts
		.FARADDR create_starnuts
		.WORD 0
		.WORD BOMB_UP, KICK, FIRE_UP, 0
stage_1_4:	.BYTE $F		; saved_to_d1c
		.BYTE 0
		.BYTE 1			; spawn_and_flags
		.BYTE 0			; more_flags
		.WORD 2			; screen_mode
		.WORD $49		; saved_to_d3a
		.FARADDR village_graphic
		.FARADDR bomb_and_explosions_graphic
		.FARADDR empty_tilemap
		.FARADDR village_level_structure
		.FARADDR empty_tilemap
		.WORD $14		; level_representation
		.WORD 6			; hard_blocks
		.WORD 33		; soft_blocks
					; Off by one in	story mode, for	the level exit
		.FARADDR load_palettes
		.FARADDR village_palettes
		.WORD $10
		.BYTE 0
		.FARADDR load_global_sprites
		.FARADDR standard_level_graphics
		.WORD $10
		.BYTE 0
		.FARADDR hidden_bonus_object
		.WORD 2
		.BYTE 0
		.WORD $12
		.BYTE 0
		.WORD $F0F0
		.FARADDR create_propene
		.FARADDR create_propene
		.FARADDR create_denkyun
		.FARADDR create_denkyun
		.FARADDR create_bakuda
		.FARADDR create_bakuda
		.WORD 0
		.WORD SPEED_UP,	5, 0
stage_1_5:	.BYTE $F		; saved_to_d1c
		.BYTE 0
		.BYTE 1			; spawn_and_flags
		.BYTE 0			; more_flags
		.WORD 2			; screen_mode
		.WORD $48		; saved_to_d3a
		.FARADDR village_graphic
		.FARADDR bomb_and_explosions_graphic
		.FARADDR empty_tilemap
		.FARADDR village_level_structure
		.FARADDR empty_tilemap
		.WORD $15		; level_representation
		.WORD 6			; hard_blocks
		.WORD 33		; soft_blocks
					; Off by one in	story mode, for	the level exit
		.FARADDR load_palettes
		.FARADDR village_palettes
		.WORD $10
		.BYTE 0
		.FARADDR load_global_sprites
		.FARADDR standard_level_graphics
		.WORD $10
		.BYTE 0
		.FARADDR hidden_bonus_object
		.WORD 4
		.BYTE 0
		.WORD $13
		.BYTE 0
		.WORD $F0F0
		.FARADDR create_bakuda
		.FARADDR create_bakuda
		.FARADDR create_bakuda
		.FARADDR create_pakupa
		.FARADDR create_propene
		.FARADDR create_propene
		.WORD 0
		.WORD 9, 3, KICK, 0
stage_1_6:	.BYTE $E		; saved_to_d1c
		.BYTE 0
		.BYTE 1			; spawn_and_flags
		.BYTE 0			; more_flags
		.WORD 2			; screen_mode
		.WORD $47		; saved_to_d3a
		.FARADDR castle_graphic
		.FARADDR bomb_and_explosions_graphic
		.FARADDR clouds_graphic
		.FARADDR castle_level_structure
		.FARADDR compressed_stage_1_6_overlay_tilemap
		.WORD $16		; level_representation
		.WORD 6			; hard_blocks
		.WORD 33		; soft_blocks
					; Off by one in	story mode, for	the level exit
		.FARADDR load_palettes
		.FARADDR castle_palettes
		.WORD $10
		.BYTE 0
		.FARADDR load_global_sprites
		.FARADDR standard_level_graphics
		.WORD $10
		.BYTE 0
		.FARADDR tile_animation
		.FARADDR byte_C51E3C
		.WORD 6
		.FARADDR tile_animation
		.FARADDR byte_C51E3C
		.WORD 2
		.FARADDR set_overlay_blending
		.WORD $1502
		.WORD $2202
		.FARADDR create_overlay_scroller
		.WORD 0
		.WORD 0
		.WORD $FFFF
		.WORD 0
		.WORD $F0F0
		.FARADDR create_senshiyan
		.FARADDR create_senshiyan
		.FARADDR create_denkyun
		.FARADDR create_denkyun
		.FARADDR create_bakuda
		.FARADDR create_bakuda
		.WORD 0
		.WORD BOMB_UP, WALL_PASS, 0
stage_1_7:	.BYTE $E		; saved_to_d1c
		.BYTE 0
		.BYTE 1			; spawn_and_flags
		.BYTE 0			; more_flags
		.WORD 2			; screen_mode
		.WORD $46		; saved_to_d3a
		.FARADDR castle_graphic
		.FARADDR bomb_and_explosions_graphic
		.FARADDR empty_tilemap
		.FARADDR castle_level_structure
		.FARADDR empty_tilemap
		.WORD $17		; level_representation
		.WORD 7			; hard_blocks
		.WORD 32		; soft_blocks
					; Off by one in	story mode, for	the level exit
		.FARADDR load_palettes
		.FARADDR castle_palettes
		.WORD $10
		.BYTE 0
		.FARADDR load_global_sprites
		.FARADDR standard_level_graphics
		.WORD $10
		.BYTE 0
		.FARADDR tile_animation
		.FARADDR byte_C51E3C
		.WORD 6
		.FARADDR tile_animation
		.FARADDR byte_C51E3C
		.WORD 2
		.FARADDR hidden_bonus_object
		.WORD 1
		.BYTE 0
		.WORD HEART
		.BYTE 0
		.WORD $F0F0
		.FARADDR create_senshiyan
		.FARADDR create_senshiyan
		.FARADDR create_senshiyan
		.FARADDR create_bakuda
		.FARADDR create_bakuda
		.FARADDR create_bakuda
		.WORD 0
		.WORD BOMB_UP, SPEED_UP, 6, 0
stage_1_8:	.BYTE $E		; saved_to_d1c
		.BYTE 0
		.BYTE 2			; spawn_and_flags
		.BYTE 0			; more_flags
		.WORD 2			; screen_mode
		.WORD $70		; saved_to_d3a
		.FARADDR castle_graphic
		.FARADDR bomb_and_explosions_graphic
		.FARADDR empty_tilemap
		.FARADDR castle_level_structure
		.FARADDR empty_tilemap
		.WORD $18		; level_representation
		.WORD 0			; hard_blocks
		.WORD 0			; soft_blocks
					; Off by one in	story mode, for	the level exit
		.FARADDR load_palettes
		.FARADDR bigaron_boss_palettes
		.WORD $10
		.BYTE 0
		.FARADDR load_global_sprites
		.FARADDR boss_level_graphics
		.WORD $10
		.BYTE 0
		.FARADDR tile_animation
		.FARADDR byte_C51E3C
		.WORD 6
		.FARADDR tile_animation
		.FARADDR byte_C51E3C
		.WORD 2
		.WORD $F0F0
		.FARADDR create_bigaron
		.WORD 0
		.WORD 0