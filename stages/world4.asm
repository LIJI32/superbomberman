stage_4_1:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $40		; saved_to_d3a
        .FARADDR dome_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR dome_level_structure
        .FARADDR empty_tilemap
        .WORD $41		; level_representation
        .WORD 6			; hard_blocks
        .WORD 32		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR dome_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2
        .FARADDR hidden_bonus_object
        .WORD 4
        .BYTE 0
        .WORD POPSICLE
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_bakuda
        .FARADDR create_bakuda
        .FARADDR create_bakuda
        .FARADDR create_red_bakuda
        .FARADDR create_red_bakuda
        .FARADDR create_red_bakuda
        .FARADDR create_senshiyan
        .FARADDR create_senshiyan
        .WORD 0
        .WORD BOMB_UP, FIRE_UP,	$D, 0
stage_4_2:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $40		; saved_to_d3a
        .FARADDR dome_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR dome_level_structure
        .FARADDR empty_tilemap
        .WORD $42		; level_representation
        .WORD 3			; hard_blocks
        .WORD 34		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR dome_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2
        .WORD $F0F0
        .FARADDR create_metal_kuwagen
        .FARADDR create_metal_kuwagen
        .FARADDR create_metal_kuwagen
        .FARADDR create_kierun
        .FARADDR create_kierun
        .FARADDR create_kierun
        .FARADDR create_denkyun
        .FARADDR create_denkyun
        .WORD 0
        .WORD WALL_PASS, 5, 0
stage_4_3:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $49		; saved_to_d3a
        .FARADDR dome_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR dome_level_structure
        .FARADDR empty_tilemap
        .WORD $43		; level_representation
        .WORD 5			; hard_blocks
        .WORD 33		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR dome_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2
        .WORD $F0F0
        .FARADDR create_metal_u
        .FARADDR create_metal_u
        .FARADDR create_metal_kuwagen
        .FARADDR create_metal_kuwagen
        .FARADDR create_metal_kuwagen
        .FARADDR create_kinkaru
        .FARADDR create_kinkaru
        .FARADDR create_kinkaru
        .WORD 0
        .WORD BOMB_UP, SPEED_UP, KICK, 0
stage_4_4:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $38		; saved_to_d3a
        .FARADDR dome_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR dome_level_structure
        .FARADDR empty_tilemap
        .WORD $44		; level_representation
        .WORD 7			; hard_blocks
        .WORD 32		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR dome_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2
        .FARADDR hidden_bonus_object
        .WORD 6
        .BYTE 0
        .WORD RANDOM
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_senshiyan
        .FARADDR create_senshiyan
        .FARADDR create_metal_u
        .FARADDR create_metal_u
        .FARADDR create_metal_u
        .FARADDR create_metal_u
        .FARADDR create_metal_propene
        .WORD 0
        .WORD BOMB_PASS, FIRE_UP, 0
stage_4_5:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $33		; saved_to_d3a
        .FARADDR dome_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR dome_level_structure
        .FARADDR empty_tilemap
        .WORD $45		; level_representation
        .WORD 3			; hard_blocks
        .WORD 32		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR dome_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2
        .FARADDR hidden_bonus_object
        .WORD 0
        .BYTE 0
        .WORD FIRE_EXT
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_metal_propene
        .FARADDR create_metal_propene
        .FARADDR create_metal_propene
        .FARADDR create_red_bakuda
        .FARADDR create_red_bakuda
        .FARADDR create_red_bakuda
        .WORD 0
        .WORD EXTRA_LIFE, EXTRA_TIME, EXTRA_TIME, 0
stage_4_6:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $48		; saved_to_d3a
        .FARADDR dome_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR dome_level_structure
        .FARADDR empty_tilemap
        .WORD $46		; level_representation
        .WORD 5			; hard_blocks
        .WORD 32		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR dome_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2
        .WORD $F0F0
        .FARADDR create_denkyun
        .FARADDR create_denkyun
        .FARADDR create_kinkaru
        .FARADDR create_kinkaru
        .FARADDR create_kinkaru
        .FARADDR create_metal_kuwagen
        .FARADDR create_metal_kuwagen
        .WORD 0
        .WORD RED_BOMBS, REMOTE_CONTROL, 0
stage_4_7:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $49		; saved_to_d3a
        .FARADDR dome_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR dome_level_structure
        .FARADDR empty_tilemap
        .WORD $47		; level_representation
        .WORD 5			; hard_blocks
        .WORD 35		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR dome_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2
        .FARADDR hidden_bonus_object
        .WORD 2
        .BYTE 0
        .WORD HEART
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_red_bakuda
        .FARADDR create_red_bakuda
        .FARADDR create_red_bakuda
        .FARADDR create_kinkaru
        .FARADDR create_kinkaru
        .FARADDR create_kinkaru
        .FARADDR create_kinkaru
        .FARADDR create_kinkaru
        .WORD 0
        .WORD SPEED_UP,	PUNCH, BOMB_UP, 0
stage_4_8:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 3			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $80		; saved_to_d3a
        .FARADDR power_zone_graphic; tileset_pointer
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR power_zone_level_structure
        .FARADDR empty_tilemap
        .WORD $48		; level_representation
        .WORD 0			; hard_blocks
        .WORD 0			; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR mecha_onita_boss_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR off_C31A35
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C527AB
        .WORD $22
        .FARADDR tile_animation
        .FARADDR byte_C527B4
        .WORD $24
        .FARADDR tile_animation
        .FARADDR byte_C527BD
        .WORD $28
        .FARADDR tile_animation
        .FARADDR byte_C527C6
        .WORD $2A
        .FARADDR tile_animation
        .FARADDR byte_C527CF
        .WORD $40
        .FARADDR tile_animation
        .FARADDR byte_C527D8
        .WORD $26
        .FARADDR tile_animation
        .FARADDR byte_C527E1
        .WORD $2E
        .FARADDR tile_animation
        .FARADDR byte_C527EA
        .WORD $2C
        .WORD $F0F0
        .FARADDR create_mecha_onita
        .WORD 0
        .WORD 0
off_C31A35:	.FARADDR bomberman_graphic_0
        .FARADDR bomberman_graphic_1
        .FARADDR bomberman_graphic_2
        .FARADDR bomberman_graphic_3
        .WORD 0
        .BYTE 0
        .WORD 0
        .BYTE 0
        .WORD 0
        .BYTE 0
        .WORD 0
        .BYTE 0
        .WORD 0
        .BYTE 0
        .WORD 0
        .BYTE 0
        .WORD 0
        .BYTE 0
        .WORD 0
        .BYTE 0
        .WORD 0
        .BYTE 0
        .WORD 0
        .BYTE 0
        .FARADDR score_banner_and_bomb_graphic
        .FARADDR explosion_graphic
dome_palettes:	.BYTE HUD_PALETTE, DOME_PALETTE_1, DOME_PALETTE_2, DOME_PALETTE_3; a_palettes
        .BYTE BONUS_PALETTE_1, BONUS_PALETTE_2,	DOME_BOMB_PALETTE; a_palettes
        .BYTE DOME_FIRE_PALETTE	; a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE FREE, FREE, FREE,	WHITE_PALETTE; b_palettes
mecha_onita_boss_palettes:.BYTE	HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
        .BYTE BACKGROUND_BLACK_PALETTE,	BACKGROUND_BLACK_PALETTE; a_palettes
        .BYTE BACKGROUND_BLACK_PALETTE,	BACKGROUND_BLACK_PALETTE; a_palettes
        .BYTE BACKGROUND_BLACK_PALETTE;	a_palettes
        .BYTE BLACK_PALETTE, BLACK_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE BLACK_PALETTE, ONITA_FADE_PALETTE_1, ONITA_FADE_PALETTE_2; b_palettes
        .BYTE WHITE_PALETTE	; b_palettes