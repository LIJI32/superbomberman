stage_1_1:

    level 0x11, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x50,
          peace_town_graphic, bomb_and_explosions_graphic, peace_town_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          8, 32 ; hard/soft blocks
    
    load_palettes peace_town_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, peace_town_unshaded_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, peace_town_shaded_soft_animation
    init_functions_end

    df create_propene
    df create_propene
    df create_propene
    dw 0
    
    dw BOMB_UP, SPEED_UP, 0
    
stage_1_2:
    level 0x12, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x50,
          peace_town_graphic, bomb_and_explosions_graphic, peace_town_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          6, 34 ; hard/soft blocks

    load_palettes peace_town_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, peace_town_unshaded_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, peace_town_shaded_soft_animation
    init_functions_end

    df create_propene
    df create_propene
    df create_propene
    df create_denkyun
    df create_denkyun
    dw 0
    
    dw BOMB_UP, FIRE_UP, 0
    
stage_1_3:
    level 0x13, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xF, 0x50,
          village_graphic, bomb_and_explosions_graphic, village_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          6, 34 ; hard/soft blocks

    load_palettes village_palettes
    load_global_sprites standard_level_graphics
    hidden_bonus_object BONUS_COND_COMBO_OF_3, RANDOM
    init_functions_end

    df create_propene
    df create_propene
    df create_denkyun
    df create_denkyun
    df create_starnuts
    df create_starnuts
    df create_starnuts
    df create_starnuts
    df create_starnuts
    dw 0
    
    dw BOMB_UP, KENDAMA, 0
    
stage_1_4:
    level 0x14, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xF, 0x49,
          village_graphic, bomb_and_explosions_graphic, village_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          6, 33 ; hard/soft blocks

    load_palettes village_palettes
    load_global_sprites standard_level_graphics
    hidden_bonus_object BONUS_COND_PRESS_START, CAKE
    init_functions_end

    df create_starnuts
    df create_starnuts
    df create_denkyun
    df create_denkyun
    df create_bakuda
    df create_bakuda
    dw 0
    
    dw SPEED_UP, FIRE_UP, 0
    
stage_1_5:
    level 0x15, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xF, 0x48,
          village_graphic, bomb_and_explosions_graphic, village_level_structure, ; graphics
          clouds_graphic, compressed_cloud_overlay_tilemap, ; overlay
          6, 33 ; hard/soft blocks

    load_palettes village_palettes
    load_global_sprites standard_level_graphics
    hidden_bonus_object BONUS_COND_UNCOVER_ALL_BONUSES, ONIGIRI
    set_overlay_blending BG2_EN, BG1_EN | BG3_EN | OBJ_EN, COLMAT_USE_SUBSCREEN | COLMAT_BG2 | COLMAT_BACKDROP
    create_overlay_scroller 0, 0, 0, -1, 0
    init_functions_end

    df create_bakuda
    df create_bakuda
    df create_bakuda
    df create_pakupa
    df create_starnuts
    df create_starnuts
    dw 0
    
    dw EXTRA_TIME, KICK, APPLE, 0
    
stage_1_6:
    level 0x16, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT | LEVEL_FLAGS_LIGHT_ZONE, 0xE, 0x47,
          castle_graphic, bomb_and_explosions_graphic, castle_level_structure, ; graphics
          clouds_graphic, compressed_cloud_overlay_tilemap, ; overlay
          6, 33 ; hard/soft blocks

    load_palettes castle_palettes_inverted
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, castle_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, castle_soft_animation
    set_overlay_blending BG2_EN, BG1_EN | BG3_EN | OBJ_EN, COLMAT_USE_SUBSCREEN | COLMAT_BG2 | COLMAT_BACKDROP | COLMAT_SUBTRACT
    create_overlay_scroller 2, 0, 0, -1, 0
    init_functions_end

    df create_senshiyan
    df create_senshiyan
    df create_senshiyan
    df create_bakuda
    df create_bakuda
    df create_bakuda
    dw 0
    
    dw BOMB_UP, POPSICLE, 0
    
stage_1_7:
    level 0x17, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT | LEVEL_FLAGS_JUMP_ZONE, 0xE, 0x46,
          castle_graphic, bomb_and_explosions_graphic, castle_level_structure, ; graphics
          trampoline_and_crane_graphic, empty_tilemap, ; overlay
          7, 32 ; hard/soft blocks

    load_palettes castle_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, castle_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, castle_soft_animation
    hidden_bonus_object BONUS_COND_BOMBS_IN_CORNERS, HEART
    init_functions_end

    df create_senshiyan
    df create_senshiyan
    df create_pakupa
    df create_pakupa
    df create_bakuda
    df create_bakuda
    
    dw 0
    
    dw FIRE_UP, SPEED_UP, RANDOM, 0
    
stage_1_8:
    level 0x18, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_BOSS, 0xE, 0x70,
          castle_graphic, bomb_and_explosions_graphic, castle_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 0 ; hard/soft blocks

    load_palettes bigaron_boss_palettes
    load_global_sprites boss_level_graphics
    tile_animation TILE_SOFTBLOCK, castle_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, castle_soft_animation
    init_functions_end

    df create_bigaron
    dw 0
    
    dw 0
    
peace_town_palettes:
    db HUD_PALETTE, PEACE_TOWN_PALETTE_1, PEACE_TOWN_PALETTE_2; a_palettes
    db PEACE_TOWN_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db PEACE_TOWN_BOMB_PALETTE, PEACE_TOWN_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE_PALETTE, FREE_PALETTE, FREE_PALETTE, WHITE_PALETTE; b_palettes
    
village_palettes:
    db HUD_PALETTE, VILLAGE_PALETTE_1, VILLAGE_PALETTE_2; a_palettes
    db VILLAGE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db VILLAGE_BOMB_PALETTE, VILLAGE_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE_PALETTE, FREE_PALETTE, FREE_PALETTE, WHITE_PALETTE; b_palettes
    
castle_palettes:
    db HUD_PALETTE, CASTLE_PALETTE_1, CASTLE_PALETTE_2; a_palettes
    db CASTLE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db CASTLE_BOMB_PALETTE, CASTLE_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE_PALETTE, FREE_PALETTE, FREE_PALETTE, WHITE_PALETTE; b_palettes
    
castle_palettes_inverted:
    db HUD_PALETTE, CASTLE_PALETTE_1 | PALETTE_INVERT_FLAG, CASTLE_PALETTE_2 | PALETTE_INVERT_FLAG; a_palettes
    db CASTLE_PALETTE_3 | PALETTE_INVERT_FLAG, BONUS_PALETTE_1 | PALETTE_INVERT_FLAG, BONUS_PALETTE_2 | PALETTE_INVERT_FLAG; a_palettes
    db CASTLE_BOMB_PALETTE | PALETTE_INVERT_FLAG, CASTLE_FIRE_PALETTE | PALETTE_INVERT_FLAG;    a_palettes
    db SHIRO_PALETTE | PALETTE_INVERT_FLAG, KURO_PALETTE | PALETTE_INVERT_FLAG, BOMB_PALETTE | PALETTE_INVERT_FLAG, RED_BOMB_PALETTE | PALETTE_INVERT_FLAG; b_palettes
    db FREE_PALETTE, FREE_PALETTE, FREE_PALETTE, WHITE_PALETTE | PALETTE_INVERT_FLAG; b_palettes
    
bigaron_boss_palettes:
    db HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BLACK_PALETTE, BLACK_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db BLACK_PALETTE, BLACK_PALETTE, BLACK_PALETTE, BLACK_PALETTE; b_palettes