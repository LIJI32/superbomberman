stage_2_1:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $47		; saved_to_d3a
        .FARADDR park_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR park_level_structure
        .FARADDR empty_tilemap
        .WORD $21		; level_representation
        .WORD 6			; hard_blocks
        .WORD 33		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR park_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_cuppen
        .FARADDR create_cuppen
        .FARADDR create_douken
        .FARADDR create_douken
        .FARADDR create_banen
        .FARADDR create_banen
        .FARADDR create_banen
        .FARADDR create_banen
        .WORD 0
        .WORD BOMB_UP, VEST, EXTRA_TIME, 0
stage_2_2:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $45		; saved_to_d3a
        .FARADDR park_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR park_level_structure
        .FARADDR empty_tilemap
        .WORD $22		; level_representation
        .WORD 6			; hard_blocks
        .WORD 32		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR park_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR hidden_bonus_object
        .WORD 3
        .BYTE 0
        .WORD ONIGIRI
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_bakuda
        .FARADDR create_cuppen
        .FARADDR create_cuppen
        .FARADDR create_bakuda
        .FARADDR create_bakuda
        .FARADDR create_cuppen
        .FARADDR create_cuppen
        .WORD 0
        .WORD PUNCH, BOMB_PASS, 0
stage_2_3:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $44		; saved_to_d3a
        .FARADDR park_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR park_level_structure
        .FARADDR empty_tilemap
        .WORD $23		; level_representation
        .WORD 5			; hard_blocks
        .WORD 34		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR park_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_douken
        .FARADDR create_douken
        .FARADDR create_douken
        .FARADDR create_banen
        .FARADDR create_banen
        .FARADDR create_banen
        .FARADDR create_metal_u
        .WORD 0
        .WORD BOMB_UP, FIRE_UP,	REMOTE_CONTROL, 0
stage_2_4:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $44		; saved_to_d3a
        .FARADDR park_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR park_level_structure
        .FARADDR empty_tilemap
        .WORD $24		; level_representation
        .WORD 5			; hard_blocks
        .WORD 33		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR park_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR hidden_bonus_object
        .WORD 5
        .BYTE 0
        .WORD RANDOM
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_kierun
        .FARADDR create_kierun
        .FARADDR create_kierun
        .FARADDR create_bakuda
        .FARADDR create_bakuda
        .FARADDR create_bakuda
        .FARADDR create_denkyun
        .FARADDR create_denkyun
        .WORD 0
        .WORD WALL_PASS, VEST, 0
stage_2_5:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $43		; saved_to_d3a
        .FARADDR park_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR park_level_structure
        .FARADDR empty_tilemap
        .WORD $25		; level_representation
        .WORD 7			; hard_blocks
        .WORD 32		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR park_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_kinkaru
        .FARADDR create_banen
        .FARADDR create_banen
        .FARADDR create_banen
        .FARADDR create_kinkaru
        .FARADDR create_kinkaru
        .FARADDR create_kinkaru
        .WORD 0
        .WORD BOMB_UP, SPEED_UP, FIRE_UP, 0
stage_2_6:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $43		; saved_to_d3a
        .FARADDR circus_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR circus_level_structure
        .FARADDR empty_tilemap
        .WORD $26		; level_representation
        .WORD 4			; hard_blocks
        .WORD 35		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR circus_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_douken
        .FARADDR create_douken
        .FARADDR create_douken
        .FARADDR create_banen
        .FARADDR create_banen
        .FARADDR create_red_bakuda
        .FARADDR create_red_bakuda
        .WORD 0
        .WORD KICK, PUNCH,	0
stage_2_7:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $42		; saved_to_d3a
        .FARADDR circus_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR circus_level_structure
        .FARADDR empty_tilemap
        .WORD $27		; level_representation
        .WORD 3			; hard_blocks
        .WORD 34		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR circus_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C522FA
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C523FF
        .WORD 2
        .FARADDR hidden_bonus_object
        .WORD 8
        .BYTE 0
        .WORD HEART
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_cuppen
        .FARADDR create_cuppen
        .FARADDR create_banen
        .FARADDR create_banen
        .FARADDR create_pakupa
        .FARADDR create_pakupa
        .FARADDR create_pakupa
        .WORD 0
        .WORD BOMB_UP, SPEED_UP, SPEED_UP, 0
stage_2_8:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 2			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $80		; saved_to_d3a
        .FARADDR circus_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR circus_level_structure
        .FARADDR compressed_spotlight_tilemap
        .WORD $28		; level_representation
        .WORD 0			; hard_blocks
        .WORD 0			; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR clown_mask_boss_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR boss_level_graphics
        .WORD $10
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_clown_mask
        .WORD 0
        .WORD 0
park_palettes:	.BYTE HUD_PALETTE, PARK_PALETTE_1, PARK_PALETTE_2, PARK_PALETTE_3; a_palettes
        .BYTE BONUS_PALETTE_1, BONUS_PALETTE_2,	PARK_BOMB_PALETTE; a_palettes
        .BYTE PARK_FIRE_PALETTE	; a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE FREE, FREE, FREE,	WHITE_PALETTE; b_palettes
circus_palettes:.BYTE HUD_PALETTE, CIRCUS_PALETTE_1, CIRCUS_PALETTE_2; a_palettes
        .BYTE CIRCUS_PALETTE_3,	BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE CIRCUS_BOMB_PALETTE, CIRCUS_FIRE_PALETTE;	a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE FREE, FREE, FREE,	WHITE_PALETTE; b_palettes
clown_mask_boss_palettes:.BYTE HUD_PALETTE, CIRCUS_PALETTE_1, CIRCUS_PALETTE_2; a_palettes
        .BYTE CIRCUS_PALETTE_3,	BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE CIRCUS_BOMB_PALETTE, CIRCUS_FIRE_PALETTE;	a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE CLOWN_MASK_PALETTE_0, CLOWN_MASK_PALETTE_1, CLOWN_MASK_PALETTE_2;	b_palettes
        .BYTE WHITE_PALETTE	; b_palettes