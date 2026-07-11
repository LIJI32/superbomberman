stage_2_1:
    level 0x21, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x47,
          park_graphic, bomb_and_explosions_graphic, park_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          6, 33 ; hard/soft blocks

    load_palettes park_palettes
    load_global_sprites standard_level_graphics
    hidden_bonus_object BONUS_COND_UNCOVER_ALL_BONUSES, RANDOM
    init_functions_end

    df create_cuppen
    df create_cuppen
    df create_douken
    df create_douken
    df create_banen
    df create_banen
    df create_banen
    df create_banen
    dw 0
    
    dw BOMB_UP, KICK, ONIGIRI, 0
    
stage_2_2:
    level 0x22, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x45,
          park_graphic, bomb_and_explosions_graphic, park_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          12, 30 ; hard/soft blocks

    load_palettes park_palettes
    load_global_sprites standard_level_graphics
    init_functions_end

    df create_red_bakuda
    df create_cuppen
    df create_cuppen
    df create_red_bakuda
    df create_red_bakuda
    df create_cuppen
    df create_cuppen
    dw 0
    
    dw RED_BOMBS, BOMB_PASS, 0
    
stage_2_3:
    level 0x23, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x44,
          park_graphic, bomb_and_explosions_graphic, park_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          14, 30 ; hard/soft blocks

    load_palettes park_palettes
    load_global_sprites standard_level_graphics
    init_functions_end

    df create_douken
    df create_douken
    df create_douken
    df create_red_bakuda
    df create_red_bakuda
    df create_red_bakuda
    df create_metal_u
    dw 0
    
    dw BOMB_UP, FIRE_UP, EXTRA_TIME, 0
    
stage_2_4:
    level 0x24, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x44,
          park_graphic, bomb_and_explosions_graphic, park_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          10, 32 ; hard/soft blocks

    df create_random_bomb_drop
    load_palettes park_palettes
    load_global_sprites standard_level_graphics
    hidden_bonus_object BONUS_COND_PUNCHED_BOMB_HIT, FIRE_EXT
    init_functions_end

    df create_kinkaru
    df create_kinkaru
    df create_kinkaru
    df create_kierun
    df create_kierun
    df create_kierun
    df create_pakupa
    df create_pakupa
    dw 0
    
    dw SPEED_UP, RED_BOMBS, 0
    
stage_2_5:
    level 0x25, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x43,
          circus_graphic, bomb_and_explosions_graphic, circus_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          7, 40 ; hard/soft blocks

    load_palettes circus_palettes
    load_global_sprites standard_level_graphics
    init_functions_end

    df create_kinkaru
    df create_douken
    df create_kinkaru
    df create_douken
    df create_bakuda
    df create_bakuda
    df create_bakuda
    df create_kinkaru
    dw 0
    
    dw BOMB_UP, SPEED_UP, KICK, POISON, POISON, POISON, 0
    
stage_2_6:
    level 0x26, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x43,
          circus_graphic, bomb_and_explosions_graphic, circus_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          10, 40 ; hard/soft blocks

    load_palettes circus_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, circus_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, circus_shaded_soft_animation
    init_functions_end

    df create_metal_u
    df create_metal_u
    df create_kinkaru
    df create_kinkaru
    df create_bakuda
    df create_bakuda
    df create_bakuda
    dw 0
    
    dw EXTRA_TIME, KICK, BOMB_UP, FIRE_UP, POISON, POISON, POISON, POISON, 0
    
stage_2_7:
    level 0x27, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT | LEVEL_FLAGS_LIGHT_ZONE, 0xE, 0x42,
          circus_graphic, bomb_and_explosions_graphic, circus_level_structure, ; graphics
          empty_tilemap, compressed_spotlight_tilemap, ; overlay
          3, 34 ; hard/soft blocks

    df create_spotlight
    load_palettes circus_palettes_inverted
    load_global_sprites standard_level_graphics
    hidden_bonus_object BONUS_COND_PLACE_6_BOMBS, HEART
    init_functions_end

    df create_bakuda
    df create_bakuda
    df create_kierun
    df create_kierun
    df create_kierun
    df create_pakupa
    df create_pakupa
    df create_pakupa
    dw 0
    
    dw BOMB_UP, SPEED_UP, POISON, POISON, POISON, POISON, RANDOM, 0
    
stage_2_8:
    level 0x28, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_BOSS, 0xE, 0x80,
          circus_graphic, bomb_and_explosions_graphic, circus_level_structure, ; graphics
          empty_tilemap, compressed_spotlight_tilemap, ; overlay
          0, 0 ; hard/soft blocks

    load_palettes clown_mask_boss_palettes
    load_global_sprites boss_level_graphics
    init_functions_end

    df create_clown_mask
    dw 0
    
    dw 0
    
park_palettes:
    db HUD_PALETTE, PARK_PALETTE_1, PARK_PALETTE_2, PARK_PALETTE_3; a_palettes
    db BONUS_PALETTE_1, BONUS_PALETTE_2, PARK_BOMB_PALETTE; a_palettes
    db PARK_FIRE_PALETTE ; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE_PALETTE, FREE_PALETTE, FREE_PALETTE, WHITE_PALETTE; b_palettes
    
circus_palettes:
    db HUD_PALETTE, CIRCUS_PALETTE_1, CIRCUS_PALETTE_2; a_palettes
    db CIRCUS_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db CIRCUS_BOMB_PALETTE, CIRCUS_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BAKUDA_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE_PALETTE, FREE_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes
    
circus_palettes_inverted:
    db HUD_PALETTE, CLOWN_MASK_SPOTLIGHT_PALETTE | PALETTE_INVERT_FLAG, CIRCUS_PALETTE_2 | PALETTE_INVERT_FLAG; a_palettes
    db CIRCUS_PALETTE_3 | PALETTE_INVERT_FLAG, BONUS_PALETTE_1 | PALETTE_INVERT_FLAG, BONUS_PALETTE_2 | PALETTE_INVERT_FLAG; a_palettes
    db CIRCUS_BOMB_PALETTE | PALETTE_INVERT_FLAG, CIRCUS_FIRE_PALETTE | PALETTE_INVERT_FLAG;    a_palettes
    db SHIRO_PALETTE | PALETTE_INVERT_FLAG, KURO_PALETTE | PALETTE_INVERT_FLAG, BAKUDA_PALETTE | PALETTE_INVERT_FLAG, RED_BOMB_PALETTE | PALETTE_INVERT_FLAG; b_palettes
    db FREE_PALETTE, FREE_PALETTE, BLACK_PALETTE | PALETTE_INVERT_FLAG, WHITE_PALETTE | PALETTE_INVERT_FLAG; b_palettes
    
clown_mask_boss_palettes:
    db HUD_PALETTE, CIRCUS_PALETTE_1, CIRCUS_PALETTE_2; a_palettes
    db CIRCUS_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db CIRCUS_BOMB_PALETTE, CIRCUS_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db CLOWN_MASK_PALETTE_0, CLOWN_MASK_PALETTE_1, CLOWN_MASK_PALETTE_2;    b_palettes
    db WHITE_PALETTE ; b_palettes