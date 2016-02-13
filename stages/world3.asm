stage_3_1:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $43		; saved_to_d3a
        .FARADDR garden_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR garden_level_structure
        .FARADDR empty_tilemap
        .WORD $31		; level_representation
        .WORD 7			; hard_blocks
        .WORD 33		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR garden_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C52565
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C52688
        .WORD 2
        .WORD $F0F0
        .FARADDR create_kouraru
        .FARADDR create_moguchan
        .FARADDR create_kouraru
        .FARADDR create_kouraru
        .FARADDR create_moguchan
        .FARADDR create_moguchan
        .WORD 0
        .WORD BOMB_UP, KICK, RED_BOMBS, 0
stage_3_2:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $42		; saved_to_d3a
        .FARADDR garden_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR garden_level_structure
        .FARADDR empty_tilemap
        .WORD $32		; level_representation
        .WORD 4			; hard_blocks
        .WORD 32		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR garden_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C52565
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C52688
        .WORD 2
        .WORD $F0F0
        .FARADDR create_moguchan
        .FARADDR create_moguchan
        .FARADDR create_pakupa
        .FARADDR create_pakupa
        .FARADDR create_pakupa
        .FARADDR create_kouraru
        .FARADDR create_kouraru
        .FARADDR create_kouraru
        .WORD 0
        .WORD PUNCH, VEST, 0
stage_3_3:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $41		; saved_to_d3a
        .FARADDR garden_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR garden_level_structure
        .FARADDR empty_tilemap
        .WORD $33		; level_representation
        .WORD 5			; hard_blocks
        .WORD 35		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR garden_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C52565
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C52688
        .WORD 2
        .FARADDR hidden_bonus_object
        .WORD $B
        .BYTE 0
        .WORD APPLE
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_kierun
        .FARADDR create_kierun
        .FARADDR create_moguchan
        .FARADDR create_moguchan
        .FARADDR create_dengurin
        .FARADDR create_dengurin
        .WORD 0
        .WORD BOMB_UP, FULL_FIRE, BOMB_UP, 0
stage_3_4:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $40		; saved_to_d3a
        .FARADDR factory_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR factory_level_structure
        .FARADDR empty_tilemap
        .WORD $34		; level_representation
        .WORD 6			; hard_blocks
        .WORD 33		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR factory_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 6
        .FARADDR create_moving_platforms
        .FARADDR hidden_bonus_object
        .WORD 0
        .BYTE 0
        .WORD KENDAMA
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_anzenda
        .FARADDR create_anzenda
        .FARADDR create_anzenda
        .FARADDR create_anzenda
        .FARADDR create_anzenda
        .FARADDR create_keibin
        .FARADDR create_keibin
        .FARADDR create_keibin
        .WORD 0
        .WORD REMOTE_CONTROL, PUNCH, 0
stage_3_5:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $40		; saved_to_d3a
        .FARADDR factory_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR factory_level_structure
        .FARADDR empty_tilemap
        .WORD $35		; level_representation
        .WORD 6			; hard_blocks
        .WORD 34		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR factory_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 6
        .FARADDR create_moving_platforms
        .WORD $F0F0
        .FARADDR create_anzenda
        .FARADDR create_anzenda
        .FARADDR create_anzenda
        .FARADDR create_kuwagen
        .FARADDR create_kuwagen
        .FARADDR create_kuwagen
        .FARADDR create_kuwagen
        .FARADDR create_anzenda
        .WORD 0
        .WORD EXTRA_TIME, EXTRA_LIFE, EXTRA_TIME, 0
stage_3_6:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $39		; saved_to_d3a
        .FARADDR factory_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR factory_level_structure
        .FARADDR empty_tilemap
        .WORD $36		; level_representation
        .WORD 7			; hard_blocks
        .WORD 32		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR factory_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 6
        .FARADDR create_moving_platforms
        .FARADDR hidden_bonus_object
        .WORD $A
        .BYTE 0
        .WORD FIRE_EXT
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_chameleoman
        .FARADDR create_chameleoman
        .FARADDR create_chameleoman
        .FARADDR create_chameleoman
        .FARADDR create_chameleoman
        .FARADDR create_chameleoman
        .FARADDR create_chameleoman
        .WORD 0
        .WORD BOMB_UP, RED_BOMBS, 0
stage_3_7:	.BYTE $E		; saved_to_d1c
        .BYTE 0
        .BYTE 1			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 2			; screen_mode
        .WORD $38		; saved_to_d3a
        .FARADDR factory_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR factory_level_structure
        .FARADDR empty_tilemap
        .WORD $37		; level_representation
        .WORD 6			; hard_blocks
        .WORD 22		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR factory_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR standard_level_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 6
        .FARADDR create_moving_platforms
        .FARADDR hidden_bonus_object
        .WORD 7
        .BYTE 0
        .WORD HEART
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_kuwagen
        .FARADDR create_kuwagen
        .FARADDR create_kuwagen
        .FARADDR create_kuwagen
        .FARADDR create_chameleoman
        .FARADDR create_chameleoman
        .FARADDR create_chameleoman
        .FARADDR create_chameleoman
        .WORD 0
        .WORD KICK, SPEED_UP, PUNCH, 0
stage_3_8:	.BYTE 0			; saved_to_d1c
        .BYTE 0
        .BYTE 2			; spawn_and_flags
        .BYTE $80		; $80 here sets a flags that disables "automatic" detection
                        ; of hard block and free spaces tiles, and forces the hard
                        ; coded values of 0804 and 0808.
        .WORD 2			; screen_mode
        .WORD $80		; saved_to_d3a
        .FARADDR factory_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR trampoline_and_crane_graphic; overlay_tileset_pointer
        .FARADDR crane_boss_level_structure
        .FARADDR compressed_handcrane_tilemap
        .WORD $38		; level_representation
        .WORD 0			; hard_blocks
        .WORD 0			; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR load_palettes
        .FARADDR crane_hand_boss_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR level_3_8_graphics_array
        .WORD $10
        .BYTE 0
        .WORD $F0F0
        .FARADDR create_crane_hand
        .WORD 0
        .WORD 0
level_3_8_graphics_array:.FARADDR bomberman_graphic_0
        .FARADDR bomberman_graphic_1
        .FARADDR bomberman_graphic_2
        .FARADDR bomberman_graphic_3
        .FARADDR mook_graphic_0
        .FARADDR mook_graphic_1
        .FARADDR crane_graphic
        .FARADDR bomberman_extra_graphic_1
        .FARADDR missle_graphic_0
        .FARADDR missle_graphic_1
        .FARADDR menu_graphic_0
        .FARADDR big_explosion_graphic_0
        .FARADDR big_explosion_graphic_1
        .FARADDR big_explosion_graphic_2
        .FARADDR score_banner_and_bomb_graphic
        .FARADDR enemy_explosion_graphic
garden_palettes:.BYTE HUD_PALETTE, GARDEN_PALETTE_1, GARDEN_PALETTE_2; a_palettes
        .BYTE GARDEN_PALETTE_3,	BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE GARDEN_BOMB_PALETTE, GARDEN_FIRE_PALETTE;	a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE FREE, FREE, FREE,	WHITE_PALETTE; b_palettes
factory_palettes:.BYTE HUD_PALETTE, FACTORY_PALETTE_1, FACTORY_PALETTE_2; a_palettes
        .BYTE FACTORY_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE FACTORY_BOMB_PALETTE, FACTORY_FIRE_PALETTE; a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE FREE, FREE, FREE,	WHITE_PALETTE; b_palettes
crane_hand_boss_palettes:.BYTE HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE;	a_palettes
        .BYTE BACKGROUND_BLACK_PALETTE,	BACKGROUND_BLACK_PALETTE; a_palettes
        .BYTE BONUS_PALETTE_2, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
        .BYTE BLACK_PALETTE, BLACK_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE BLACK_PALETTE, BLACK_PALETTE, MISSLE_PALETTE, WHITE_PALETTE; b_palettes
