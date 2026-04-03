stage_3_1:
    level 0x31, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x43,
          garden_graphic, bomb_and_explosions_graphic, garden_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          7, 33 ; hard/soft blocks

    load_palettes garden_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, garden_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, garden_shaded_soft_animation
    init_functions_end

    df create_kouraru
    df create_moguchan
    df create_kouraru
    df create_kouraru
    df create_moguchan
    df create_moguchan
    dw 0
    
    dw BOMB_UP, KICK, RED_BOMBS, 0
    
stage_3_2:
    level 0x32, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x42,
          garden_graphic, bomb_and_explosions_graphic, garden_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          4, 32 ; hard/soft blocks

    load_palettes garden_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, garden_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, garden_shaded_soft_animation
    init_functions_end

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
    level 0x33, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x41,
          garden_graphic, bomb_and_explosions_graphic, garden_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          5, 35 ; hard/soft blocks

    load_palettes garden_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, garden_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, garden_shaded_soft_animation
    hidden_bonus_object BONUS_COND_SCORE_ENDS_WITH_20, APPLE
    init_functions_end

    df create_kierun
    df create_kierun
    df create_moguchan
    df create_moguchan
    df create_dengurin
    df create_dengurin
    dw 0
    
    dw BOMB_UP, FULL_FIRE, BOMB_UP, 0
    
stage_3_4:
    level 0x34, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x40,
          factory_graphic, bomb_and_explosions_graphic, factory_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          6, 33 ; hard/soft blocks

    load_palettes factory_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK_SHADED, factory_soft_animation
    tile_animation TILE_SOFTBLOCK, factory_soft_animation
    df create_moving_platforms
    hidden_bonus_object BONUS_COND_LIVES_DROP_TO_ZERO, KENDAMA
    init_functions_end

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
    level 0x35, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x40,
          factory_graphic, bomb_and_explosions_graphic, factory_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          6, 34 ; hard/soft blocks

    load_palettes factory_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK_SHADED, factory_soft_animation
    tile_animation TILE_SOFTBLOCK, factory_soft_animation
    df create_moving_platforms
    init_functions_end

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
    level 0x36, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x39,
          factory_graphic, bomb_and_explosions_graphic, factory_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          7, 32 ; hard/soft blocks

    load_palettes factory_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK_SHADED, factory_soft_animation
    tile_animation TILE_SOFTBLOCK, factory_soft_animation
    df create_moving_platforms
    hidden_bonus_object BONUS_COND_PLACE_6_BOMBS, FIRE_EXT
    init_functions_end

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
    level 0x37, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x38,
          factory_graphic, bomb_and_explosions_graphic, factory_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          6, 22 ; hard/soft blocks

    load_palettes factory_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK_SHADED, factory_soft_animation
    tile_animation TILE_SOFTBLOCK, factory_soft_animation
    df create_moving_platforms
    hidden_bonus_object BONUS_COND_SPAWN_ENEMY, HEART
    init_functions_end

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
    level 0x38, GAME_MODE_STORY, LEVEL_FLAGS_HARDCODED_HARDBLOCKS | LEVEL_FLAGS_SPAWN_BOSS, 0, 0x80,
          factory_graphic, bomb_and_explosions_graphic, crane_boss_level_structure, ; graphics
          trampoline_and_crane_graphic, compressed_handcrane_tilemap, ; overlay
          0, 0 ; hard/soft blocks

    load_palettes crane_hand_boss_palettes
    load_global_sprites level_3_8_graphics_array
    init_functions_end

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
    db FREE_PALETTE, FREE_PALETTE, FREE_PALETTE, WHITE_PALETTE; b_palettes
    
factory_palettes:
    db HUD_PALETTE, FACTORY_PALETTE_1, FACTORY_PALETTE_2; a_palettes
    db FACTORY_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db FACTORY_BOMB_PALETTE, FACTORY_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE_PALETTE, FREE_PALETTE, FREE_PALETTE, WHITE_PALETTE; b_palettes
    
crane_hand_boss_palettes:
    db HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE;    a_palettes
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BONUS_PALETTE_2, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BLACK_PALETTE, BLACK_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db BLACK_PALETTE, BLACK_PALETTE, MISSLE_PALETTE, WHITE_PALETTE; b_palettes
