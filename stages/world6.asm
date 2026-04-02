stage_6_1:
    level 0x61, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x35,
          speed_zone_graphic, bomb_and_explosions_graphic, speed_zone_level_structure, ; graphics
          clouds_graphic, compressed_stage_1_6_overlay_tilemap, ; overlay
          4, 36 ; hard/soft blocks

    load_palettes speed_zone_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK_SHADED, speed_zone_soft_animation
    tile_animation TILE_SOFTBLOCK, speed_zone_soft_animation
    set_overlay_blending BG2_EN, BG1_EN | BG3_EN | OBJ_EN, COLMAT_USE_SUBSCREEN | COLMAT_BG2 | COLMAT_BACKDROP
    create_overlay_scroller 0, 0, -1, 0
    init_functions_end

    df create_propene
    df create_banen
    df create_banen
    df create_propene
    df create_denkyun
    df create_denkyun
    dw 0
    
    dw BOMB_UP, FIRE_UP, WALL_PASS, 0
    
stage_6_2:
    level 0x62, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x40,
          speed_zone_graphic, bomb_and_explosions_graphic, speed_zone_level_structure, ; graphics
          clouds_graphic, compressed_stage_1_6_overlay_tilemap, ; overlay
          4, 35 ; hard/soft blocks

    load_palettes speed_zone_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK_SHADED, speed_zone_soft_animation
    tile_animation TILE_SOFTBLOCK, speed_zone_soft_animation
    set_overlay_blending BG2_EN, BG1_EN | BG3_EN | OBJ_EN, COLMAT_USE_SUBSCREEN | COLMAT_BG2 | COLMAT_BACKDROP
    create_overlay_scroller 0, 0, 1, 0
    hidden_bonus_object BONUS_COND_PUNCHED_BOMB_HIT, CAKE
    init_functions_end

    df create_moguchan
    df create_moguchan
    df create_kierun
    df create_kierun
    df create_bakuda
    df create_bakuda
    df create_bakuda
    dw 0
    
    dw KICK, SPEED_UP, 0
    
stage_6_3:
    level 0x63, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x37,
          speed_zone_graphic, bomb_and_explosions_graphic, speed_zone_level_structure, ; graphics
          clouds_graphic, compressed_stage_1_6_overlay_tilemap, ; overlay
          4, 34 ; hard/soft blocks

    load_palettes speed_zone_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK_SHADED, speed_zone_soft_animation
    tile_animation TILE_SOFTBLOCK, speed_zone_soft_animation
    set_overlay_blending BG2_EN, BG1_EN | BG3_EN | OBJ_EN, COLMAT_USE_SUBSCREEN | COLMAT_BG2 | COLMAT_BACKDROP
    create_overlay_scroller 0, 0x100, -1, 0
    init_functions_end

    df create_kuwagen
    df create_kuwagen
    df create_kuwagen
    df create_robocom
    df create_robocom
    df create_robocom
    df create_metal_u
    df create_metal_u
    dw 0
    
    dw BOMB_UP, REMOTE_CONTROL, PUNCH, 0
    
stage_6_4:
    level 0x64, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x30,
          diamond_tower_tileset_graphic, bomb_and_explosions_graphic, diamond_tower_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 23 ; hard/soft blocks

    load_palettes diamond_tower_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_HARDBLOCK, diamond_tower_hard_animation
    hidden_bonus_object BONUS_COND_SCORE_ENDS_WITH_20, APPLE
    init_functions_end

    df create_yoroisu
    df create_yoroisu
    dw 0
    
    dw BOMB_UP, EXTRA_TIME, EXTRA_LIFE, 0
    
stage_6_5:
    level 0x65, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x40,
          diamond_tower_tileset_graphic, bomb_and_explosions_graphic, diamond_tower_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          3, 35 ; hard/soft blocks

    load_palettes diamond_tower_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_HARDBLOCK, diamond_tower_hard_animation
    hidden_bonus_object BONUS_COND_5_PUNCHES, ICE_CREAM
    init_functions_end

    df create_robocom
    df create_robocom
    df create_robocom
    df create_metal_kuwagen
    df create_metal_kuwagen
    df create_pakupa
    df create_pakupa
    df create_pakupa
    dw 0
    
    dw BOMB_UP, KICK, EXTRA_TIME, 0
    
stage_6_6:
    level 0x66, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x45,
          diamond_tower_tileset_graphic, bomb_and_explosions_graphic, diamond_tower_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          5, 35 ; hard/soft blocks

    load_palettes diamond_tower_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_HARDBLOCK, diamond_tower_hard_animation
    init_functions_end

    df create_metal_propene
    df create_metal_propene
    df create_kinkaru
    df create_kinkaru
    df create_robocom
    df create_robocom
    df create_robocom
    df create_robocom
    dw 0
    
    dw REMOTE_CONTROL, WALL_PASS, 0
    
stage_6_7:
    level 0x67, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x36,
          diamond_tower_tileset_graphic, bomb_and_explosions_graphic, diamond_tower_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          4, 37 ; hard/soft blocks

    load_palettes diamond_tower_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_HARDBLOCK, diamond_tower_hard_animation
    hidden_bonus_object BONUS_COND_PRESS_START, HEART
    init_functions_end

    df create_kinkaru
    df create_kinkaru
    df create_kinkaru
    df create_red_bakuda
    df create_red_bakuda
    df create_red_bakuda
    df create_robocom
    df create_robocom
    dw 0
    
    dw EXTRA_LIFE, REMOTE_CONTROL, FULL_FIRE, 0
    
stage_6_8:
    level 0x68, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_BOSS_ALT, 0xE, 0x90,
          diamond_tower_tileset_graphic, bomb_and_explosions_graphic, diamond_tower_level_structure, ; graphics
          spiderer_bg_graphic, compressed_spiderer_tilemap, ; overlay
          0, 0 ; hard/soft blocks

    load_palettes spiderer_boss_palettes
    load_global_sprites spiderer_boss_graphics
    tile_animation TILE_HARDBLOCK, diamond_tower_hard_animation
    init_functions_end

    df create_spiderer
    dw 0
    
    dw 0
    
spiderer_boss_graphics:
    df bomberman_graphic_0
    df bomberman_graphic_1
    df bomberman_graphic_2
    df bomberman_graphic_3
    df spiderer_graphic_0
    df spiderer_graphic_1
    df spiderer_graphic_2
    df spiderer_graphic_3
    df spiderer_graphic_4
    df carat_diamond_graphic_0
    df carat_diamond_graphic_1
    df carat_diamond_graphic_2
    df mook_graphic_0
    df mook_graphic_1
    df score_banner_and_bomb_graphic
    df explosion_graphic
    
speed_zone_palettes:
    db HUD_PALETTE, SPEED_ZONE_PALETTE_1, SPEED_ZONE_PALETTE_2; a_palettes
    db SPEED_ZONE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db SPEED_ZONE_BOMB_PALETTE, SPEED_ZONE_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE, FREE, FREE, WHITE_PALETTE; b_palettes
    
diamond_tower_palettes:
    db HUD_PALETTE, DIAMOND_TOWER_PALETTE_1, DIAMOND_TOWER_PALETTE_2; a_palettes
    db DIAMOND_TOWER_BOMB_PALETTE, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db DIAMOND_TOWER_BOMB_PALETTE, DIAMOND_TOWER_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE, FREE, FREE, WHITE_PALETTE; b_palettes
    
spiderer_boss_palettes:
    db HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE;    a_palettes
    db BLACK_PALETTE, BLACK_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db BLACK_PALETTE, BLACK_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes