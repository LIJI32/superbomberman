normal_zone:
    level 0x14, GAME_MODE_BATTLE, LEVEL_FLAGS_HARDCODED_HARDBLOCKS, 0, 0x200,
          normal_zone_graphic, bomb_and_explosions_graphic, normal_zone_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 80 ; hard/soft blocks

    df null_versus_initializer
    load_palettes normal_zone_palettes
    load_global_sprites western_zone_graphics
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP,
       FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP, SPEED_UP, KICK, KICK, KICK, PUNCH, PUNCH,
       PUNCH, POISON, POISON, 0

    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | OBJ_EN, BG1_EN | BG2_EN | BG3_EN | OBJ_EN,
                          COLMAT_SUBTRACT | COLMAT_BG2 | COLMAT_BG1, 5,
                          0, 0

western_zone_graphics:
    df bomberman_graphic_0
    df bomberman_graphic_1
    df bomberman_graphic_2
    df bomberman_graphic_3
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df unknown_graphic
    df tractor_graphic
    df battle_menu_graphic_5
    df battle_menu_graphic_6
    df scoreboard_graphic
    df time_up_graphic_1
    df time_up_graphic_2
    df bomb_graphic
    df time_up_graphic_0

western_zone:
    level 0x15, GAME_MODE_BATTLE, LEVEL_FLAGS_WESTERN, 1, 0x200,
          village_graphic, bomb_and_explosions_graphic, village_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 65 ; hard/soft blocks

    df null_versus_initializer
    load_palettes western_zone_palettes
    load_global_sprites western_zone_graphics
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP, KICK,
       KICK, KICK, PUNCH, PUNCH, PUNCH, POISON, POISON, FULL_FIRE, FULL_FIRE, 0

    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | OBJ_EN, BG1_EN | BG2_EN | BG3_EN | OBJ_EN,
                          COLMAT_SUBTRACT | COLMAT_BG2 | COLMAT_BG1, 7,
                          0, 0
bomb_zone:
    level 0x14, GAME_MODE_BATTLE, 0, 0, 0x200,
          peace_town_graphic, bomb_and_explosions_graphic, peace_town_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 60 ; hard/soft blocks

    df create_random_bomb_drop
    load_palettes bomb_zone_palettes
    load_global_sprites bomb_zone_graphics
    tile_animation TILE_SOFTBLOCK, peace_town_unshaded_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, peace_town_shaded_soft_animation
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP
    dw SPEED_UP, KICK, KICK, KICK, PUNCH, PUNCH, PUNCH, POISON, POISON, 0

    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | OBJ_EN, BG1_EN | BG2_EN | BG3_EN | OBJ_EN,
                          COLMAT_SUBTRACT | COLMAT_BG2 | COLMAT_BG1, 8,
                          0, 0

bomb_zone_graphics:
    df bomberman_graphic_0
    df bomberman_graphic_1
    df bomberman_graphic_2
    df bomberman_graphic_3
    df bakuda_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df unknown_graphic
    df menu_graphic_0
    df battle_menu_graphic_5
    df battle_menu_graphic_6
    df scoreboard_graphic
    df time_up_graphic_1
    df time_up_graphic_2
    df bomb_graphic
    df time_up_graphic_0

jump_zone:
    level 0x14, GAME_MODE_BATTLE, LEVEL_FLAGS_JUMP_ZONE, 0, 0x200,
          castle_graphic, bomb_and_explosions_graphic, castle_level_structure, ; graphics
          trampoline_and_crane_graphic, empty_tilemap, ; overlay
          0, 55 ; hard/soft blocks

    df null_versus_initializer
    load_palettes jump_zone_palettes
    load_global_sprites western_zone_graphics
    tile_animation TILE_SOFTBLOCK, castle_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, castle_soft_animation
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP,
       SPEED_UP, POISON, POISON, KICK, KICK, KICK, PUNCH, PUNCH, PUNCH, 0

    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | OBJ_EN, BG1_EN | BG2_EN | BG3_EN | OBJ_EN,
                          COLMAT_SUBTRACT | COLMAT_BG2 | COLMAT_BG1, 8,
                          0, 0

belt_zone:
    level 0x14, GAME_MODE_BATTLE, LEVEL_FLAGS_BELT_ZONE, 0, 0x200,
          factory_graphic, bomb_and_explosions_graphic, belt_zone_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 55 ; hard/soft blocks

    df null_versus_initializer
    load_palettes belt_zone_palettes
    load_global_sprites belt_zone_graphics
    tile_animation 0x48, belt_up_animation
    tile_animation 0x4A, belt_right_animation
    tile_animation 0x4C, belt_down_animation
    tile_animation 0x4E, belt_left_animation
    tile_animation TILE_SOFTBLOCK_SHADED, factory_soft_animation
    tile_animation TILE_SOFTBLOCK, factory_soft_animation
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP,
       SPEED_UP, SPEED_UP, SPEED_UP, KICK, KICK, KICK, PUNCH, PUNCH, PUNCH, 0

    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | OBJ_EN, BG1_EN | BG2_EN | BG3_EN | OBJ_EN,
                          COLMAT_SUBTRACT | COLMAT_BG2 | COLMAT_BG1, 8,
                          0, 0
belt_zone_graphics:
    df bomberman_graphic_0
    df bomberman_graphic_1
    df bomberman_graphic_2
    df bomberman_graphic_3
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df unknown_graphic
    df menu_graphic_0
    df battle_menu_graphic_5
    df battle_menu_graphic_6
    df scoreboard_graphic
    df time_up_graphic_1
    df time_up_graphic_2
    df bomb_graphic
    df time_up_graphic_0

tunnel_zone:
    level 0x14, GAME_MODE_BATTLE, LEVEL_FLAGS_TUNNEL_ZONE, 0, 0x200,
          tunnel_zone_graphic, bomb_and_explosions_graphic, tunnel_zone_level_structure, ; graphics
          empty_tilemap, compressed_tunnel_zone_overlay_tilemap, ; overlay
          0, 50 ; hard/soft blocks

    df null_versus_initializer
    load_palettes tunnel_zone_palettes
    load_global_sprites western_zone_graphics
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP,
       FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP, SPEED_UP, POISON, POISON, KICK, KICK, KICK, 0

    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | BG4_EN | OBJ_EN, 0,
                          COLMAT_SUBTRACT | COLMAT_BACKDROP | COLMAT_BG1 | COLMAT_BG2 | COLMAT_USE_SUBSCREEN, 8,
                          8, -25

duel_zone:
    level 0x14, GAME_MODE_BATTLE, LEVEL_FLAGS_DUEL_ZONE, 0, 0x200,
          park_graphic, bomb_and_explosions_graphic, park_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 0 ; hard/soft blocks

    df null_versus_initializer
    load_palettes duel_zone_palettes
    load_global_sprites western_zone_graphics
    init_functions_end

    dw 0

    dw 0

    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | OBJ_EN, BG1_EN | BG2_EN | BG3_EN | OBJ_EN,
                          COLMAT_SUBTRACT | COLMAT_BG2 | COLMAT_BG1, 8,
                          0, 0
flower_zone:
    level 0x14, GAME_MODE_BATTLE, LEVEL_FLAGS_FLOWER_ZONE, 0, 0x200,
          garden_graphic, bomb_and_explosions_graphic, garden_level_structure, ; graphics
          clouds_graphic, compressed_cloud_overlay_tilemap, ; overlay
          0, 50 ; hard/soft blocks

    df create_flower_zone_handler
    load_palettes flower_zone_palettes
    load_global_sprites western_zone_graphics
    tile_animation TILE_SOFTBLOCK, garden_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, garden_shaded_soft_animation
    create_overlay_scroller 0, 0, 0, -1, 0
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP,
       SPEED_UP, POISON, POISON, REMOTE_CONTROL, REMOTE_CONTROL, KICK, KICK, KICK, PUNCH, PUNCH,
       PUNCH, 0

    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | OBJ_EN, 0,
                          COLMAT_SUBTRACT | COLMAT_BG2 | COLMAT_BG1 | COLMAT_USE_SUBSCREEN, 4,
                          0, 0

light_zone:
    level 0x14, GAME_MODE_BATTLE, LEVEL_FLAGS_LIGHT_ZONE, 0, 0x200,
          dome_graphic, bomb_and_explosions_graphic, dome_level_structure, ; graphics
          empty_tilemap, compressed_spotlight_tilemap, ; overlay
          0, 55 ; hard/soft blocks

    df create_spotlight
    load_palettes light_zone_palettes
    load_global_sprites western_zone_graphics
    tile_animation TILE_SOFTBLOCK, dome_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, dome_shaded_soft_animation
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP,
       SPEED_UP, SPEED_UP, SPEED_UP, KICK, KICK, PUNCH, PUNCH, POISON, POISON, POISON,
       POISON, POISON, POISON, POISON, POISON, 0
       
    battle_stage_ppu_regs OBJ_EN | BG2_EN, OBJ_EN | BG1_EN | BG3_EN | BG4_EN,
                          COLMAT_SUBTRACT | COLMAT_BG2 | COLMAT_BG1 | COLMAT_USE_SUBSCREEN, 0,
                          128, 128

power_zone:
    level 0x41, GAME_MODE_BATTLE, LEVEL_FLAGS_POWER_ZONE, 0, 0x200,
          power_zone_graphic, bomb_and_explosions_graphic, power_zone_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 0 ; hard/soft blocks

    df null_versus_initializer
    load_palettes power_zone_palettes
    load_global_sprites western_zone_graphics
    tile_animation 0x22, power_zone_fence_horizontal_edge_animation
    tile_animation 0x24, power_zone_fence_horizontal_1_animation
    tile_animation 0x28, power_zone_fence_vertical_edge_animation
    tile_animation 0x2A, power_zone_fence_vertical_1_animation
    tile_animation 0x40, power_zone_fence_vertical_3_animation
    tile_animation 0x26, power_zone_fence_horizontal_2_animation
    tile_animation 0x2E, power_zone_fence_vertical_2_animation
    tile_animation 0x2C, power_zone_fence_vertical_4_animation
    init_functions_end

    dw 0

    dw POISON, POISON, POISON, POISON, POISON, POISON, POISON, POISON, POISON, POISON,
       REMOTE_CONTROL, 0
       
    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | OBJ_EN, BG1_EN | BG2_EN | BG3_EN | OBJ_EN,
                          COLMAT_SUBTRACT | COLMAT_BG2 | COLMAT_BG1, 8,
                          0, 0

warp_zone:
    level 0x14, GAME_MODE_BATTLE, LEVEL_FLAGS_WARP_ZONE, 0, 0x200,
          warp_zone_graphic, bomb_and_explosions_graphic, warp_zone_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 50 ; hard/soft blocks

    df null_versus_initializer
    load_palettes warp_zone_palettes
    load_global_sprites warp_zone_graphics
    tile_animation 0x26, warp_animation
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP,
       SPEED_UP, SPEED_UP, SPEED_UP, POISON, POISON, KICK, KICK, KICK, PUNCH, PUNCH,
       PUNCH, FULL_FIRE, FULL_FIRE, 0

    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | OBJ_EN, BG1_EN | BG2_EN | BG3_EN | OBJ_EN,
                          COLMAT_SUBTRACT | COLMAT_BG2 | COLMAT_BG1, 8,
                          0, 0
warp_zone_graphics:
    df bomberman_graphic_0
    df bomberman_graphic_1
    df bomberman_graphic_2
    df bomberman_graphic_3

warp_graphics:
    df bomberman_extra_graphic_0
    df bomberman_extra_graphic_1
    df menu_graphic_0
    df unknown_graphic
    df menu_graphic_0
    df battle_menu_graphic_5
    df battle_menu_graphic_6
    df scoreboard_graphic
    df time_up_graphic_1
    df time_up_graphic_2
    df bomb_graphic
    df time_up_graphic_0

warp_mini_graphics:
    df bomberman_mini_graphic_4
    df bomberman_mini_warp_graphic
    df menu_graphic_0
    df unknown_graphic

speed_zone:
    level 0x41, GAME_MODE_BATTLE, LEVEL_FLAGS_SPEED_MODE, 0, 0x200,
          speed_zone_graphic, bomb_and_explosions_graphic, speed_zone_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 80 ; hard/soft blocks

    df null_versus_initializer
    load_palettes speed_zone_battle_palettes
    load_global_sprites western_zone_graphics
    tile_animation TILE_SOFTBLOCK_SHADED, speed_zone_soft_animation
    tile_animation TILE_SOFTBLOCK, speed_zone_soft_animation
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP,
       POISON, POISON, KICK, KICK, KICK, PUNCH, PUNCH, PUNCH, FULL_FIRE, FULL_FIRE,
       REMOTE_CONTROL, REMOTE_CONTROL, 0
    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | OBJ_EN, BG1_EN | BG2_EN | BG3_EN | OBJ_EN,
                          COLMAT_SUBTRACT | COLMAT_BG2 | COLMAT_BG1, 8,
                          0, 0

illusion_zone:
    level 0x14, GAME_MODE_BATTLE, 0, 0, 0x200,
          circus_graphic, bomb_and_explosions_graphic, circus_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 65 ; hard/soft blocks

    df null_versus_initializer
    load_palettes illusion_zone_palettes
    load_global_sprites western_zone_graphics
    tile_animation TILE_SOFTBLOCK, circus_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, circus_shaded_soft_animation
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, POISON, POISON, FIRE_UP, FIRE_UP, FIRE_UP,
       FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP, SPEED_UP, KICK, KICK, KICK, PUNCH, PUNCH,
       PUNCH, POISON, POISON, RED_BOMBS, WALL_PASS, 0

    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | OBJ_EN, BG1_EN | BG2_EN | BG3_EN | OBJ_EN,
                          COLMAT_SUBTRACT | COLMAT_BG2 | COLMAT_BG1, 5,
                          0, 0

arena_zone:
    level 0x14, GAME_MODE_BATTLE, LEVEL_FLAGS_ARENA_ZONE, 0, 0x200,
          arena_graphic, bomb_and_explosions_graphic, arena_zone_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 0 ; hard/soft blocks

    df null_versus_initializer
    load_palettes arena_zone_palettes
    load_global_sprites western_zone_graphics
    tile_animation 0x24, arena_crowd_side_purple_animation
    tile_animation 0x26, arena_crowd_side_red_animation
    df create_arena_zone_handler
    init_functions_end

    dw 0

    dw 0

    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | OBJ_EN, BG1_EN | BG2_EN | BG3_EN | OBJ_EN,
                          COLMAT_SUBTRACT | COLMAT_BG2 | COLMAT_BG1, 5,
                          0, 0
                          
smoking_zone:
    level 0x14, GAME_MODE_BATTLE, LEVEL_FLAGS_LIGHT_ZONE, 0, 0x200,
          diamond_tower_tileset_graphic, bomb_and_explosions_graphic, diamond_tower_level_structure, ; graphics
          clouds_graphic, compressed_cloud_pal3_overlay_tilemap, ; overlay
          0, 70 ; hard/soft blocks

    df null_versus_initializer
    load_palettes smoking_zone_palettes
    load_global_sprites western_zone_graphics
    df create_fog_animator
    create_overlay_scroller 2, 0, 0x100, -1, 0
    tile_animation TILE_HARDBLOCK, diamond_tower_hard_animation
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP,
       FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP, SPEED_UP, KICK, KICK, KICK, PUNCH, PUNCH,
       PUNCH, POISON, POISON, POISON, POISON, 0

    battle_stage_ppu_regs OBJ_EN | BG2_EN, OBJ_EN | BG1_EN | BG3_EN | BG4_EN,
                          COLMAT_SUBTRACT | COLMAT_BG2 | COLMAT_BG1 | COLMAT_USE_SUBSCREEN, 0,
                          0, 0x100
                          
normal_zone_palettes:
    db HUD_PALETTE, PEACE_TOWN_PALETTE_1, NORMAL_ZONE_PALETTE; a_palettes
    db PEACE_TOWN_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db NORMAL_ZONE_BOMB_PALETTE, NORMAL_ZONE_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes

unknown_palettes_0:
    db HUD_PALETTE, PEACE_TOWN_PALETTE_1, PEACE_TOWN_PALETTE_2; a_palettes
    db PEACE_TOWN_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db PEACE_TOWN_BOMB_PALETTE, PEACE_TOWN_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes

bomb_zone_palettes:
    db HUD_PALETTE, PEACE_TOWN_PALETTE_1, PEACE_TOWN_PALETTE_2; a_palettes
    db PEACE_TOWN_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db PEACE_TOWN_BOMB_PALETTE, PEACE_TOWN_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes

jump_zone_palettes:
    db HUD_PALETTE, CASTLE_PALETTE_1, CASTLE_PALETTE_2; a_palettes
    db CASTLE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db CASTLE_BOMB_PALETTE, CASTLE_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes

tunnel_zone_palettes:
    db HUD_PALETTE, TUNNEL_ZONE_PALETTE_1, TUNNEL_ZONE_PALETTE_2; a_palettes
    db TUNNEL_ZONE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db TUNNEL_ZONE_BOMB_PALETTE, TUNNEL_ZONE_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes

belt_zone_palettes:
    db HUD_PALETTE, FACTORY_PALETTE_1, FACTORY_PALETTE_2; a_palettes
    db FACTORY_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db FACTORY_BOMB_PALETTE, FACTORY_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes

illusion_zone_palettes:
    db HUD_PALETTE, CIRCUS_PALETTE_1, CIRCUS_PALETTE_2; a_palettes
    db CIRCUS_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db CIRCUS_BOMB_PALETTE, CIRCUS_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes

arena_zone_palettes:
    db HUD_PALETTE, ARENA_PALETTE_1, ARENA_PALETTE_2, ARENA_PALETTE_3; a_palettes
    db BONUS_PALETTE_1, BONUS_PALETTE_2, ARENA_BOMB_PALETTE; a_palettes
    db ARENA_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes

duel_zone_palettes:
    db HUD_PALETTE, PARK_PALETTE_1, PARK_PALETTE_2, PARK_PALETTE_3; a_palettes
    db BONUS_PALETTE_1, BONUS_PALETTE_2, PARK_BOMB_PALETTE; a_palettes
    db PARK_FIRE_PALETTE ; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes

flower_zone_palettes:
    db HUD_PALETTE, GARDEN_PALETTE_1, GARDEN_PALETTE_2; a_palettes
    db GARDEN_PALETTE_3_COPY, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db GARDEN_BOMB_PALETTE, GARDEN_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes

light_zone_palettes:
    db HUD_PALETTE, DOME_PALETTE_1 | PALETTE_INVERT_FLAG, DOME_PALETTE_2 | PALETTE_INVERT_FLAG; a_palettes
    db DOME_PALETTE_3 | PALETTE_INVERT_FLAG, BONUS_PALETTE_1 | PALETTE_INVERT_FLAG, BONUS_PALETTE_2 | PALETTE_INVERT_FLAG; a_palettes
    db DOME_BOMB_PALETTE | PALETTE_INVERT_FLAG, DOME_FIRE_PALETTE | PALETTE_INVERT_FLAG; a_palettes
    db SHIRO_PALETTE | PALETTE_INVERT_FLAG, KURO_PALETTE | PALETTE_INVERT_FLAG, BOMB_PALETTE | PALETTE_INVERT_FLAG, RED_BOMB_PALETTE | PALETTE_INVERT_FLAG; b_palettes
    db AKA_PALETTE | PALETTE_INVERT_FLAG, AO_PALETTE | PALETTE_INVERT_FLAG, BLACK_PALETTE | PALETTE_INVERT_FLAG, WHITE_PALETTE | PALETTE_INVERT_FLAG; b_palettes

warp_zone_palettes:
    db HUD_PALETTE, WARP_ZONE_PALETTE_1, WARP_ZONE_PALETTE_2;    a_palettes
    db WARP_ZONE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db WARP_ZONE_BOMB_PALETTE, WARP_ZONE_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes

western_zone_palettes:
    db HUD_PALETTE, VILLAGE_PALETTE_1, VILLAGE_PALETTE_2; a_palettes
    db VILLAGE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db VILLAGE_BOMB_PALETTE, VILLAGE_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes

speed_zone_battle_palettes:
    db HUD_PALETTE, SPEED_ZONE_PALETTE_1, SPEED_ZONE_PALETTE_2; a_palettes
    db SPEED_ZONE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db SPEED_ZONE_BOMB_PALETTE, SPEED_ZONE_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes

power_zone_palettes:
    db HUD_PALETTE, POWER_ZONE_PALETTE_1, HUD_PALETTE, POWER_ZONE_PALETTE_2; a_palettes
    db BONUS_PALETTE_1, BONUS_PALETTE_2, POWER_ZONE_BOMB_PALETTE; a_palettes
    db POWER_ZONE_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes
    
smoking_zone_palettes:
    db HUD_PALETTE, DIAMOND_TOWER_PALETTE_1  | PALETTE_INVERT_FLAG, DIAMOND_TOWER_PALETTE_2  | PALETTE_INVERT_FLAG; a_palettes
    db CASTLE_PALETTE_2 | PALETTE_INVERT_FLAG, BONUS_PALETTE_1  | PALETTE_INVERT_FLAG, BONUS_PALETTE_2  | PALETTE_INVERT_FLAG; a_palettes
    db DIAMOND_TOWER_BOMB_PALETTE  | PALETTE_INVERT_FLAG, DIAMOND_TOWER_FIRE_PALETTE  | PALETTE_INVERT_FLAG; a_palettes
    db SHIRO_PALETTE | PALETTE_INVERT_FLAG, KURO_PALETTE | PALETTE_INVERT_FLAG, BOMB_PALETTE | PALETTE_INVERT_FLAG, RED_BOMB_PALETTE | PALETTE_INVERT_FLAG; b_palettes
    db AKA_PALETTE | PALETTE_INVERT_FLAG, AO_PALETTE | PALETTE_INVERT_FLAG, BLACK_PALETTE | PALETTE_INVERT_FLAG, WHITE_PALETTE | PALETTE_INVERT_FLAG; b_palettes
