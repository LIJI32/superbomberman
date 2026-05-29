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

    df create_level_missile
    df create_level_missile
    df create_level_missile
    df create_red_bakuda
    df create_red_bakuda
    df create_red_bakuda
    df create_senshiyan
    df create_senshiyan
    dw 0
    
    dw BOMB_UP, FIRE_UP, WALL_PASS, 0
    
stage_4_2:
    level 0x42, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x40,
          dome_graphic, bomb_and_explosions_graphic, dome_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          8, 32 ; hard/soft blocks

    load_palettes dome_palettes
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, dome_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, dome_shaded_soft_animation
    init_functions_end

    
    df create_level_missile
    df create_level_missile
    df create_level_missile
    df create_metal_kuwagen
    df create_metal_kuwagen
    df create_metal_kuwagen
    df create_kinkaru
    df create_kinkaru
    df create_kinkaru
    dw 0
    
    dw RANDOM, KICK, PUNCH, 0
    

stage_4_3:
    level 0x43, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT | LEVEL_FLAGS_LIGHT_ZONE, 0xE, 0x49,
          dome_graphic, bomb_and_explosions_graphic, dome_level_structure, ; graphics
          empty_tilemap, compressed_spotlight_tilemap, ; overlay
          11, 31 ; hard/soft blocks

    df create_spotlight
    load_palettes dome_palettes_inverted
    load_global_sprites standard_level_graphics
    tile_animation TILE_SOFTBLOCK, dome_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, dome_shaded_soft_animation
    init_functions_end

    df create_moguchan
    df create_moguchan
    df create_moguchan
    df create_kierun
    df create_kierun
    df create_kierun
    df create_chameleoman
    df create_chameleoman
    df create_chameleoman
    dw 0
    
    dw BOMB_UP, SPEED_UP, RED_BOMBS, 0
        
stage_4_4:
    level 0x44, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x38,
          tunnel_zone_graphic, bomb_and_explosions_graphic, tunnel_zone_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          7, 40 ; hard/soft blocks

    load_palettes tunnel_zone_story_palettes
    load_global_sprites standard_level_graphics
    hidden_bonus_object BONUS_COND_COMBO_OF_3, ONIGIRI
    init_functions_end

    df create_senshiyan
    df create_senshiyan
    df create_senshiyan
    df create_metal_u
    df create_metal_u
    df create_metal_u
    df create_metal_propene
    dw 0
    
    dw BOMB_PASS, FULL_FIRE, PUNCH, EXTRA_TIME, 0
    
stage_4_5:
    level 0x45, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT | LEVEL_FLAGS_TUNNEL_ZONE, 0xE, 0x33,
          tunnel_zone_graphic, bomb_and_explosions_graphic, tunnel_zone_level_structure, ; graphics
          empty_tilemap, compressed_tunnel_zone_overlay_tilemap, ; overlay
          0, 32 ; hard/soft blocks

    load_palettes tunnel_zone_story_palettes
    load_global_sprites standard_level_graphics
    hidden_bonus_object BONUS_COND_BOMBS_IN_CORNERS, ICE_CREAM
    df create_tunnel_zone_scroller
    init_functions_end

    df create_metal_propene
    df create_metal_propene
    df create_bakuda
    df create_bakuda
    df create_bakuda
    df create_kierun
    df create_kierun
    df create_kierun
    df create_chameleoman
    df create_chameleoman
    df create_chameleoman
    dw 0
    
    dw VEST, EXTRA_TIME, WALL_PASS, 0
    
stage_4_6:
    level 0x46, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT, 0xE, 0x48,
          warp_zone_graphic, bomb_and_explosions_graphic, warpless_warp_zone_level_structure, ; graphics
          clouds_graphic, compressed_cloud_overlay_tilemap, ; overlay
          11, 40 ; hard/soft blocks

    load_palettes warp_zone_fog_palettes
    load_global_sprites standard_level_graphics
    set_overlay_blending BG2_EN, BG1_EN | BG3_EN | OBJ_EN, COLMAT_USE_SUBSCREEN | COLMAT_BG2 | COLMAT_BACKDROP
    create_overlay_scroller 0, 0, 0x100, -1, 0
    init_functions_end

    df create_metal_u
    df create_metal_u
    df create_starnuts
    df create_starnuts
    df create_starnuts
    df create_starnuts
    df create_metal_kuwagen
    df create_metal_kuwagen
    df create_metal_kuwagen
    df create_bakuda
    df create_bakuda
    df create_bakuda
    dw 0
    
    dw RED_BOMBS, BOMB_UP, EXTRA_LIFE, 0
    
stage_4_7:
    level 0x47, GAME_MODE_STORY, LEVEL_FLAGS_SPAWN_DEFAULT | LEVEL_FLAGS_WARP_ZONE, 0xE, 0x49,
          warp_zone_graphic, bomb_and_explosions_graphic, warp_zone_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 40 ; hard/soft blocks

    load_palettes warp_zone_story_palettes
    load_global_sprites warp_zone_level_graphics
    tile_animation 0x26, warp_animation
    hidden_bonus_object BONUS_COND_BOMBS_IN_CORNERS, HEART
    init_functions_end

    df create_pakupa
    df create_pakupa
    df create_pakupa
    df create_level_missile
    df create_level_missile
    df create_level_missile
    df create_moguchan
    df create_moguchan
    df create_moguchan
    dw 0
    
    dw SPEED_UP, KICK, BOMB_UP, RANDOM, 0
    
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
    db FREE_PALETTE, FREE_PALETTE, FREE_PALETTE, WHITE_PALETTE; b_palettes

dome_palettes_inverted:
    db HUD_PALETTE, DOME_PALETTE_1 | PALETTE_INVERT_FLAG, DOME_PALETTE_2 | PALETTE_INVERT_FLAG, DOME_PALETTE_3 | PALETTE_INVERT_FLAG; a_palettes
    db BONUS_PALETTE_1 | PALETTE_INVERT_FLAG, BONUS_PALETTE_2 | PALETTE_INVERT_FLAG, DOME_BOMB_PALETTE | PALETTE_INVERT_FLAG; a_palettes
    db DOME_FIRE_PALETTE | PALETTE_INVERT_FLAG ; a_palettes
    db SHIRO_PALETTE | PALETTE_INVERT_FLAG, KURO_PALETTE | PALETTE_INVERT_FLAG, BOMB_PALETTE | PALETTE_INVERT_FLAG, RED_BOMB_PALETTE | PALETTE_INVERT_FLAG; b_palettes
    db FREE_PALETTE, FREE_PALETTE, FREE_PALETTE, WHITE_PALETTE | PALETTE_INVERT_FLAG; b_palettes
    
tunnel_zone_story_palettes:
    db HUD_PALETTE, TUNNEL_ZONE_PALETTE_1, TUNNEL_ZONE_PALETTE_2; a_palettes
    db TUNNEL_ZONE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db TUNNEL_ZONE_BOMB_PALETTE, TUNNEL_ZONE_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE_PALETTE, FREE_PALETTE, FREE_PALETTE, WHITE_PALETTE; b_palettes
    
warp_zone_story_palettes:
    db HUD_PALETTE, WARP_ZONE_PALETTE_1, WARP_ZONE_PALETTE_2;    a_palettes
    db WARP_ZONE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db WARP_ZONE_BOMB_PALETTE, WARP_ZONE_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE_PALETTE, FREE_PALETTE, FREE_PALETTE, WHITE_PALETTE; b_palettes
    
warp_zone_fog_palettes:
    db HUD_PALETTE, WARP_ZONE_PALETTE_1, WARP_ZONE_FOG_PALETTE_2;    a_palettes
    db WARP_ZONE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db WARP_ZONE_BOMB_PALETTE, WARP_ZONE_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE_PALETTE, FREE_PALETTE, FREE_PALETTE, WHITE_PALETTE; b_palettes

warp_zone_level_graphics:
    df bomberman_graphic_0
    df bomberman_graphic_1
    df bomberman_graphic_2
    df bomberman_graphic_3
    df bomberman_extra_graphic_0
    df bomberman_extra_graphic_1
    df 0
    df 0
    df 0
    df 0
    df 0
    df 0
    df 0
    df 0
    df score_banner_and_bomb_graphic
    df enemy_explosion_graphic

mecha_onita_boss_palettes:
    db HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE;    a_palettes
    db BLACK_PALETTE, BLACK_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db BLACK_PALETTE, ONITA_FADE_PALETTE_1, ONITA_FADE_PALETTE_2; b_palettes
    db WHITE_PALETTE ; b_palettes