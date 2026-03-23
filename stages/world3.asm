stage_3_1:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x43 ; saved_to_d3a
    df garden_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df garden_level_structure
    df empty_tilemap
    dw 0x31 ; level_representation
    dw 7 ; hard_blocks
    dw 33 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df garden_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52565
    dw 6
    df tile_animation
    df byte_C52688
    dw 2
    dw 0xF0F0
    df create_kouraru
    df create_moguchan
    df create_kouraru
    df create_kouraru
    df create_moguchan
    df create_moguchan
    dw 0
    dw BOMB_UP, KICK, RED_BOMBS, 0
    
stage_3_2:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x42 ; saved_to_d3a
    df garden_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df garden_level_structure
    df empty_tilemap
    dw 0x32 ; level_representation
    dw 4 ; hard_blocks
    dw 32 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df garden_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52565
    dw 6
    df tile_animation
    df byte_C52688
    dw 2
    dw 0xF0F0
    df create_moguchan
    df create_moguchan
    df create_pakupa
    df create_pakupa
    df create_pakupa
    df create_kouraru
    df create_kouraru
    df create_kouraru
    dw 0
    dw PUNCH, VEST, 0
    
stage_3_3:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x41 ; saved_to_d3a
    df garden_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df garden_level_structure
    df empty_tilemap
    dw 0x33 ; level_representation
    dw 5 ; hard_blocks
    dw 35 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df garden_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52565
    dw 6
    df tile_animation
    df byte_C52688
    dw 2
    df hidden_bonus_object
    dw 0xB
    db 0
    dw APPLE
    db 0
    dw 0xF0F0
    df create_kierun
    df create_kierun
    df create_moguchan
    df create_moguchan
    df create_dengurin
    df create_dengurin
    dw 0
    dw BOMB_UP, FULL_FIRE, BOMB_UP, 0
    
stage_3_4:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x40 ; saved_to_d3a
    df factory_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df factory_level_structure
    df empty_tilemap
    dw 0x34 ; level_representation
    dw 6 ; hard_blocks
    dw 33 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df factory_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52504
    dw 2
    df tile_animation
    df byte_C52504
    dw 6
    df create_moving_platforms
    df hidden_bonus_object
    dw 0
    db 0
    dw KENDAMA
    db 0
    dw 0xF0F0
    df create_anzenda
    df create_anzenda
    df create_anzenda
    df create_anzenda
    df create_anzenda
    df create_keibin
    df create_keibin
    df create_keibin
    dw 0
    dw REMOTE_CONTROL, PUNCH, 0
    
stage_3_5:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x40 ; saved_to_d3a
    df factory_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df factory_level_structure
    df empty_tilemap
    dw 0x35 ; level_representation
    dw 6 ; hard_blocks
    dw 34 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df factory_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52504
    dw 2
    df tile_animation
    df byte_C52504
    dw 6
    df create_moving_platforms
    dw 0xF0F0
    df create_anzenda
    df create_anzenda
    df create_anzenda
    df create_kuwagen
    df create_kuwagen
    df create_kuwagen
    df create_kuwagen
    df create_anzenda
    dw 0
    dw EXTRA_TIME, EXTRA_LIFE, EXTRA_TIME, 0
    
stage_3_6:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x39 ; saved_to_d3a
    df factory_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df factory_level_structure
    df empty_tilemap
    dw 0x36 ; level_representation
    dw 7 ; hard_blocks
    dw 32 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df factory_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52504
    dw 2
    df tile_animation
    df byte_C52504
    dw 6
    df create_moving_platforms
    df hidden_bonus_object
    dw 0xA
    db 0
    dw FIRE_EXT
    db 0
    dw 0xF0F0
    df create_chameleoman
    df create_chameleoman
    df create_chameleoman
    df create_chameleoman
    df create_chameleoman
    df create_chameleoman
    df create_chameleoman
    dw 0
    dw BOMB_UP, RED_BOMBS, 0
    
stage_3_7:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x38 ; saved_to_d3a
    df factory_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df factory_level_structure
    df empty_tilemap
    dw 0x37 ; level_representation
    dw 6 ; hard_blocks
    dw 22 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df factory_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52504
    dw 2
    df tile_animation
    df byte_C52504
    dw 6
    df create_moving_platforms
    df hidden_bonus_object
    dw 7
    db 0
    dw HEART
    db 0
    dw 0xF0F0
    df create_kuwagen
    df create_kuwagen
    df create_kuwagen
    df create_kuwagen
    df create_chameleoman
    df create_chameleoman
    df create_chameleoman
    df create_chameleoman
    dw 0
    dw KICK, SPEED_UP, PUNCH, 0
    
stage_3_8:
    db 0 ; saved_to_d1c
    db 0
    db 2 ; spawn_and_flags
    db 0x80 ; 0x80 here sets a flags that disables "automatic" detection
 ; of hard block and free spaces tiles, and forces the hard
 ; coded values of 0804 and 0808.
    dw 2 ; screen_mode
    dw 0x80 ; saved_to_d3a
    df factory_graphic
    df bomb_and_explosions_graphic
    df trampoline_and_crane_graphic; overlay_tileset_pointer
    df crane_boss_level_structure
    df compressed_handcrane_tilemap
    dw 0x38 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df crane_hand_boss_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df level_3_8_graphics_array
    dw 0x10
    db 0
    dw 0xF0F0
    df create_crane_hand
    dw 0
    dw 0
    
level_3_8_graphics_array:
    df bomberman_graphic_0
    df bomberman_graphic_1
    df bomberman_graphic_2
    df bomberman_graphic_3
    df mook_graphic_0
    df mook_graphic_1
    df crane_graphic
    df bomberman_extra_graphic_1
    df missle_graphic_0
    df missle_graphic_1
    df menu_graphic_0
    df big_explosion_graphic_0
    df big_explosion_graphic_1
    df big_explosion_graphic_2
    df score_banner_and_bomb_graphic
    df enemy_explosion_graphic
    
garden_palettes:
    db HUD_PALETTE, GARDEN_PALETTE_1, GARDEN_PALETTE_2; a_palettes
    db GARDEN_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db GARDEN_BOMB_PALETTE, GARDEN_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE, FREE, FREE, WHITE_PALETTE; b_palettes
    
factory_palettes:
    db HUD_PALETTE, FACTORY_PALETTE_1, FACTORY_PALETTE_2; a_palettes
    db FACTORY_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db FACTORY_BOMB_PALETTE, FACTORY_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE, FREE, FREE, WHITE_PALETTE; b_palettes
    
crane_hand_boss_palettes:
    db HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE;    a_palettes
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BONUS_PALETTE_2, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BLACK_PALETTE, BLACK_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db BLACK_PALETTE, BLACK_PALETTE, MISSLE_PALETTE, WHITE_PALETTE; b_palettes
