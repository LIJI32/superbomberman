stage_4_1:
    level 0x41, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x40,
          dome_graphic, bomb_and_explosions_graphic, dome_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          6, 32 ; hard/soft blocks

    load_palettes dome_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, dome_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, dome_shaded_soft_animation
    hidden_bonus_object BONUS_COND_BOMBS_IN_CORNERS, POPSICLE
    init_functions_end

    df create_bakuda
    df create_bakuda
    df create_bakuda
    df create_red_bakuda
    df create_red_bakuda
    df create_red_bakuda
    df create_senshiyan
    df create_senshiyan
    dw 0
    
    dw BOMB_UP, FIRE_UP, 0xD, 0
    
stage_4_2:
    level 0x42, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x40,
          dome_graphic, bomb_and_explosions_graphic, dome_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          3, 34 ; hard/soft blocks

    load_palettes dome_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, dome_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, dome_shaded_soft_animation
    init_functions_end

    df create_metal_kuwagen
    df create_metal_kuwagen
    df create_metal_kuwagen
    df create_kierun
    df create_kierun
    df create_kierun
    df create_denkyun
    df create_denkyun
    dw 0
    
    dw WALL_PASS, 5, 0
    
stage_4_3:
    level 0x43, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x49,
          dome_graphic, bomb_and_explosions_graphic, dome_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          5, 33 ; hard/soft blocks

    load_palettes dome_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, dome_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, dome_shaded_soft_animation
    init_functions_end

    df create_metal_u
    df create_metal_u
    df create_metal_kuwagen
    df create_metal_kuwagen
    df create_metal_kuwagen
    df create_kinkaru
    df create_kinkaru
    df create_kinkaru
    dw 0
    
    dw BOMB_UP, SPEED_UP, KICK, 0
    
stage_4_4:
    level 0x44, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x38,
          dome_graphic, bomb_and_explosions_graphic, dome_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          7, 32 ; hard/soft blocks

    load_palettes dome_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, dome_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, dome_shaded_soft_animation
    hidden_bonus_object BONUS_COND_COMBO_OF_3, RANDOM
    init_functions_end

    df create_senshiyan
    df create_senshiyan
    df create_metal_u
    df create_metal_u
    df create_metal_u
    df create_metal_u
    df create_metal_propene
    dw 0
    
    dw BOMB_PASS, FIRE_UP, 0
    
stage_4_5:
    level 0x45, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x33,
          dome_graphic, bomb_and_explosions_graphic, dome_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          3, 32 ; hard/soft blocks

    load_palettes dome_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, dome_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, dome_shaded_soft_animation
    hidden_bonus_object BONUS_COND_LIVES_DROP_TO_ZERO, FIRE_EXT
    init_functions_end

    df create_metal_propene
    df create_metal_propene
    df create_metal_propene
    df create_red_bakuda
    df create_red_bakuda
    df create_red_bakuda
    dw 0
    
    dw EXTRA_LIFE, EXTRA_TIME, EXTRA_TIME, 0
    
stage_4_6:
    level 0x46, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x48,
          dome_graphic, bomb_and_explosions_graphic, dome_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          5, 32 ; hard/soft blocks

    load_palettes dome_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, dome_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, dome_shaded_soft_animation
    init_functions_end

    df create_denkyun
    df create_denkyun
    df create_kinkaru
    df create_kinkaru
    df create_kinkaru
    df create_metal_kuwagen
    df create_metal_kuwagen
    dw 0
    
    dw RED_BOMBS, REMOTE_CONTROL, 0
    
stage_4_7:
    level 0x47, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x49,
          dome_graphic, bomb_and_explosions_graphic, dome_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          5, 35 ; hard/soft blocks

    load_palettes dome_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, dome_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, dome_shaded_soft_animation
    hidden_bonus_object BONUS_COND_DONT_MOVE_ON_EXIT, HEART
    init_functions_end

    df create_red_bakuda
    df create_red_bakuda
    df create_red_bakuda
    df create_kinkaru
    df create_kinkaru
    df create_kinkaru
    df create_kinkaru
    df create_kinkaru
    dw 0
    
    dw SPEED_UP, PUNCH, BOMB_UP, 0
    
stage_4_8:
    level 0x48, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_BOSS_ALT, 0xE, 0x80,
          power_zone_graphic, bomb_and_explosions_graphic, power_zone_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 0 ; hard/soft blocks

    load_palettes mecha_onita_boss_palettes
    load_global_sprites level_4_8_graphics_array
    tile_animation 0x22, power_zone_fence_horizontal_edge_animation
    tile_animation 0x24, power_zone_fence_horizontal_1_animation
    tile_animation 0x28, power_zone_fence_vertical_edge_animation
    tile_animation 0x2A, power_zone_fence_vertical_1_animation
    tile_animation 0x40, power_zone_fence_vertical_3_animation
    tile_animation 0x26, power_zone_fence_horizontal_2_animation
    tile_animation 0x2E, power_zone_fence_vertical_2_animation
    tile_animation 0x2C, power_zone_fence_vertical_4_animation
    init_functions_end

    df create_mecha_onita
    dw 0

    dw 0
    
level_4_8_graphics_array:
    df bomberman_graphic_0
    df bomberman_graphic_1
    df bomberman_graphic_2
    df bomberman_graphic_3
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    dw 0
    db 0
    df score_banner_and_bomb_graphic
    df explosion_graphic
    
dome_palettes:
    db HUD_PALETTE, DOME_PALETTE_1, DOME_PALETTE_2, DOME_PALETTE_3; a_palettes
    db BONUS_PALETTE_1, BONUS_PALETTE_2, DOME_BOMB_PALETTE; a_palettes
    db DOME_FIRE_PALETTE ; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE, FREE, FREE, WHITE_PALETTE; b_palettes
    
mecha_onita_boss_palettes:
    db    HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE;    a_palettes
    db BLACK_PALETTE, BLACK_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db BLACK_PALETTE, ONITA_FADE_PALETTE_1, ONITA_FADE_PALETTE_2; b_palettes
    db WHITE_PALETTE ; b_palettes