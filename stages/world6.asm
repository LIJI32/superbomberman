stage_6_1:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $35		; saved_to_d3a
        .FARADDR speed_zone_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR clouds_graphic
        .FARADDR speed_zone_level_structure
        .FARADDR compressed_stage_1_6_overlay_tilemap
        .WORD $61		; level_representation
        .WORD 4			; hard_blocks
        .WORD 36		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR speed_zone_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 6
        .FARADDR set_overlay_blending
        .BYTE 2
        .BYTE $15		; TODO
        .BYTE 2
        .BYTE $22
        .FARADDR create_overlay_scroller
        .WORD 0
        .WORD 0
        .WORD $FFFF
        .WORD 0
        .WORD $F0F0
        .FARADDR create_propene
        .FARADDR create_banen
        .FARADDR create_banen
        .FARADDR create_propene
        .FARADDR create_denkyun
        .FARADDR create_denkyun
        .WORD 0
        .WORD BOMB_UP, FIRE_UP,	WALL_PASS, 0
stage_6_2:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $40		; saved_to_d3a
        .FARADDR speed_zone_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR clouds_graphic
        .FARADDR speed_zone_level_structure
        .FARADDR compressed_stage_1_6_overlay_tilemap
        .WORD $62		; level_representation
        .WORD 4			; hard_blocks
        .WORD 35		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR speed_zone_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 6
        .FARADDR set_overlay_blending
        .BYTE 2
        .BYTE $15
        .BYTE 2
        .BYTE $22
        .FARADDR create_overlay_scroller
        .WORD 0
        .WORD 0
        .WORD 1
        .WORD 0
        .FARADDR hidden_bonus_object
        .WORD 9
        .BYTE 0
        .WORD CAKE
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_moguchan
        .FARADDR create_moguchan
        .FARADDR create_kierun
        .FARADDR create_kierun
        .FARADDR create_bakuda
        .FARADDR create_bakuda
        .FARADDR create_bakuda
        .WORD 0
        .WORD KICK, SPEED_UP, 0
stage_6_3:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $37		; saved_to_d3a
        .FARADDR speed_zone_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR clouds_graphic
        .FARADDR speed_zone_level_structure
        .FARADDR compressed_stage_1_6_overlay_tilemap
        .WORD $63		; level_representation
        .WORD 4			; hard_blocks
        .WORD 34		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR speed_zone_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 6
        .FARADDR set_overlay_blending
        .BYTE 2
        .BYTE $15
        .BYTE 2
        .BYTE $22
        .FARADDR create_overlay_scroller
        .WORD 0
        .WORD $100
        .WORD $FFFF
        .WORD 0
        .WORD $F0F0
        .FARADDR create_kuwagen
        .FARADDR create_kuwagen
        .FARADDR create_kuwagen
        .FARADDR create_robocom
        .FARADDR create_robocom
        .FARADDR create_robocom
        .FARADDR create_metal_u
        .FARADDR create_metal_u
        .WORD 0
        .WORD BOMB_UP, REMOTE_CONTROL, PUNCH, 0
stage_6_4:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $30		; saved_to_d3a
        .FARADDR diamond_tower_tileset_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR diamond_tower_level_structure
        .FARADDR empty_tilemap
        .WORD $64		; level_representation
        .WORD 0			; hard_blocks
        .WORD 23		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR diamond_tower_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4
        .FARADDR hidden_bonus_object
        .WORD $B
        .BYTE 0
        .WORD APPLE
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_yoroisu
        .FARADDR create_yoroisu
        .WORD 0
        .WORD BOMB_UP, EXTRA_TIME, EXTRA_LIFE, 0
stage_6_5:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $40		; saved_to_d3a
        .FARADDR diamond_tower_tileset_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR diamond_tower_level_structure
        .FARADDR empty_tilemap
        .WORD $65		; level_representation
        .WORD 3			; hard_blocks
        .WORD 35		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR diamond_tower_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4
        .FARADDR hidden_bonus_object
        .WORD 8
        .BYTE 0
        .WORD ICE_CREAM
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_robocom
        .FARADDR create_robocom
        .FARADDR create_robocom
        .FARADDR create_metal_kuwagen
        .FARADDR create_metal_kuwagen
        .FARADDR create_pakupa
        .FARADDR create_pakupa
        .FARADDR create_pakupa
        .WORD 0
        .WORD BOMB_UP, KICK, EXTRA_TIME,	0
stage_6_6:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $45		; saved_to_d3a
        .FARADDR diamond_tower_tileset_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR diamond_tower_level_structure
        .FARADDR empty_tilemap
        .WORD $66		; level_representation
        .WORD 5			; hard_blocks
        .WORD 35		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR diamond_tower_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4
        .WORD $F0F0
        .FARADDR create_metal_propene
        .FARADDR create_metal_propene
        .FARADDR create_kinkaru
        .FARADDR create_kinkaru
        .FARADDR create_robocom
        .FARADDR create_robocom
        .FARADDR create_robocom
        .FARADDR create_robocom
        .WORD 0
        .WORD REMOTE_CONTROL, WALL_PASS, 0
stage_6_7:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $36		; saved_to_d3a
        .FARADDR diamond_tower_tileset_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR diamond_tower_level_structure
        .FARADDR empty_tilemap
        .WORD $67		; level_representation
        .WORD 4			; hard_blocks
        .WORD 37		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR diamond_tower_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4
        .FARADDR hidden_bonus_object
        .WORD 3
        .BYTE 0
        .WORD HEART
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_kinkaru
        .FARADDR create_kinkaru
        .FARADDR create_kinkaru
        .FARADDR create_red_bakuda
        .FARADDR create_red_bakuda
        .FARADDR create_red_bakuda
        .FARADDR create_robocom
        .FARADDR create_robocom
        .WORD 0
        .WORD EXTRA_LIFE, REMOTE_CONTROL, FULL_FIRE,	0
stage_6_8:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 3			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $90		; saved_to_d3a
        .FARADDR diamond_tower_tileset_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR spiderer_bg_graphic; overlay_tileset_pointer
        .FARADDR diamond_tower_level_structure
        .FARADDR compressed_spiderer_tilemap
        .WORD $68		; level_representation
        .WORD 0			; hard_blocks
        .WORD 0			; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR spiderer_boss_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR spiderer_boss_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4
        .WORD $F0F0
        .FARADDR create_spiderer
        .WORD 0
        .WORD 0
spiderer_boss_graphics:
        .FARADDR bomberman_graphic_0
        .FARADDR bomberman_graphic_1
        .FARADDR bomberman_graphic_2
        .FARADDR bomberman_graphic_3
        .FARADDR spiderer_graphic_0
        .FARADDR spiderer_graphic_1
        .FARADDR spiderer_graphic_2
        .FARADDR spiderer_graphic_3
        .FARADDR spiderer_graphic_4
        .FARADDR carat_diamond_graphic_0
        .FARADDR carat_diamond_graphic_1
        .FARADDR carat_diamond_graphic_2
        .FARADDR mook_graphic_0
        .FARADDR mook_graphic_1
        .FARADDR score_banner_and_bomb_graphic
        .FARADDR explosion_graphic
speed_zone_palettes:.BYTE HUD_PALETTE, SPEED_ZONE_PALETTE_1, SPEED_ZONE_PALETTE_2; a_palettes
        .BYTE SPEED_ZONE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE SPEED_ZONE_BOMB_PALETTE, SPEED_ZONE_FIRE_PALETTE;	a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE FREE, FREE, FREE,	WHITE_PALETTE; b_palettes
diamond_tower_palettes:.BYTE HUD_PALETTE, DIAMOND_TOWER_PALETTE_1, DIAMOND_TOWER_PALETTE_2; a_palettes
        .BYTE DIAMOND_TOWER_BOMB_PALETTE, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE DIAMOND_TOWER_BOMB_PALETTE, DIAMOND_TOWER_FIRE_PALETTE; a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE FREE, FREE, FREE,	WHITE_PALETTE; b_palettes
spiderer_boss_palettes:.BYTE HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
        .BYTE BACKGROUND_BLACK_PALETTE,	BACKGROUND_BLACK_PALETTE; a_palettes
        .BYTE BACKGROUND_BLACK_PALETTE,	BACKGROUND_BLACK_PALETTE; a_palettes
        .BYTE BACKGROUND_BLACK_PALETTE;	a_palettes
        .BYTE BLACK_PALETTE, BLACK_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE BLACK_PALETTE, BLACK_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes