normal_zone:
    db 0 ; saved_to_d1c
    db 0
    db 0 ; spawn_and_flags
    db 0x80 ; more_flags
    dw 3 ; screen_mode
    dw 0x200 ; saved_to_d3a
    df normal_zone_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df normal_zone_level_structure
    df empty_tilemap
    dw 0x14 ; level_representation
    dw 0 ; hard_blocks
    dw 80 ; soft_blocks, off by one in story mode, for the level exit
    df locret_C463DD
    df load_palettes
    df normal_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df western_zone_graphics
    dw 0x10
    db 0
    dw 0xF0F0
    dw 0
    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP
    dw FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP, SPEED_UP, KICK, KICK, KICK, PUNCH, PUNCH
    dw PUNCH, POISON, POISON, 0
    db 0x17, 0x17, 0, 0x83, 0xE5, 0, 0, 0, 0, 0
    
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
    db 1 ; saved_to_d1c
    db 0
    db 8 ; spawn_and_flags
    db 0 ; more_flags
    dw 3 ; screen_mode
    dw 0x200 ; saved_to_d3a
    df village_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df village_level_structure
    df empty_tilemap
    dw 0x15 ; level_representation
    dw 0 ; hard_blocks
    dw 65 ; soft_blocks, off by one in story mode, for the level exit
    df locret_C463DD
    df load_palettes
    df western_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df western_zone_graphics
    dw 0x10
    db 0
    dw 0xF0F0
    dw 0
    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP, KICK
    dw KICK, KICK, PUNCH, PUNCH, PUNCH, POISON, POISON, FULL_FIRE, FULL_FIRE, 0
    db 0x17, 0x17, 0, 0x83, 0xE7, 0, 0, 0, 0, 0
    
bomb_zone:
    db 0 ; saved_to_d1c
    db 0
    db 0 ; spawn_and_flags
    db 0 ; more_flags
    dw 3 ; screen_mode
    dw 0x200 ; saved_to_d3a
    df peace_town_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df peace_town_level_structure
    df empty_tilemap
    dw 0x14 ; level_representation
    dw 0 ; hard_blocks
    dw 60 ; soft_blocks, off by one in story mode, for the level exit
    df create_random_bomb_drop
    df load_palettes
    df bomb_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df bomb_zone_graphics
    dw 0x10
    db 0
    df tile_animation
    df peace_town_unshaded_soft_animation
    dw 6
    df tile_animation
    df peace_town_shaded_soft_animation
    dw 2
    dw 0xF0F0
    dw 0
    dw BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP
    dw SPEED_UP, KICK, KICK, KICK, PUNCH, PUNCH, PUNCH, POISON, POISON, 0
    db 0x17, 0x17, 0, 0x83, 0xE8, 0, 0, 0, 0, 0
    
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
    db 0 ; saved_to_d1c
    db 0
    db 0x40 ; spawn_and_flags
    db 0 ; more_flags
    dw 3 ; screen_mode
    dw 0x200 ; saved_to_d3a
    df castle_graphic
    df bomb_and_explosions_graphic
    df trampoline_and_crane_graphic ; overlay_tileset_bank
    df castle_level_structure
    df empty_tilemap
    dw 0x14 ; level_representation
    dw 0 ; hard_blocks
    dw 55 ; soft_blocks, off by one in story mode, for the level exit
    df locret_C463DD
    df load_palettes
    df jump_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df western_zone_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C51E3C
    dw 6
    df tile_animation
    df byte_C51E3C
    dw 2
    dw 0xF0F0
    dw 0
    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP
    dw SPEED_UP, POISON, POISON, KICK, KICK, KICK, PUNCH, PUNCH, PUNCH, 0
    db 0x17, 0x17, 0, 0x83, 0xE8, 0, 0, 0, 0, 0
    
belt_zone:
    db 0 ; saved_to_d1c
    db 0
    db 0 ; spawn_and_flags
    db 0x10 ; more_flags
    dw 3 ; screen_mode
    dw 0x200 ; saved_to_d3a
    df factory_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df belt_zone_level_structure
    df empty_tilemap
    dw 0x14 ; level_representation
    dw 0 ; hard_blocks
    dw 55 ; soft_blocks, off by one in story mode, for the level exit
    df locret_C463DD
    df load_palettes
    df belt_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df belt_zone_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C537C4+0x4D
    dw 0x48
    df tile_animation
    df byte_C53862
    dw 0x4A
    df tile_animation
    df byte_C538B3
    dw 0x4C
    df tile_animation
    df byte_C53904
    dw 0x4E
    df tile_animation
    df byte_C52504
    dw 2
    df tile_animation
    df byte_C52504
    dw 6
    dw 0xF0F0
    dw 0
    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP
    dw SPEED_UP, SPEED_UP, SPEED_UP, KICK, KICK, KICK, PUNCH, PUNCH, PUNCH, 0
    db 0x17, 0x17, 0, 0x83, 0xE8, 0, 0, 0, 0, 0
    
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
    db 0 ; saved_to_d1c
    db 0
    db 0 ; spawn_and_flags
    db 8 ; more_flags
    dw 3 ; screen_mode
    dw 0x200 ; saved_to_d3a
    df tunnel_zone_graphic ; tileset_bank
    df bomb_and_explosions_graphic
    df empty_tilemap
    df tunnel_zone_level_structure
    df compressed_tunnel_zone_overlay_tilemap
    dw 0x14 ; level_representation
    dw 0 ; hard_blocks
    dw 50 ; soft_blocks, off by one in story mode, for the level exit
    df locret_C463DD
    df load_palettes
    df tunnel_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df western_zone_graphics
    dw 0x10
    db 0
    dw 0xF0F0
    dw 0
    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP
    dw FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP, SPEED_UP, POISON, POISON, KICK, KICK, KICK
    dw 0
    db 0x1F, 0, 2, 0xA3, 0xE8, 0, 8, 0, 0xE7, 3
    
duel_zone:
    db 0 ; saved_to_d1c
    db 0
    db 0 ; spawn_and_flags
    db 2 ; more_flags
    dw 3 ; screen_mode
    dw 0x200 ; saved_to_d3a
    df park_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df park_level_structure
    df empty_tilemap
    dw 0x14 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df locret_C463DD
    df load_palettes
    df duel_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df western_zone_graphics
    dw 0x10
    db 0
    dw 0xF0F0
    dw 0
    dw 0
    db 0x17, 0x17, 0, 0x83, 0xE8, 0, 0, 0, 0, 0
    
flower_zone:
    db 0 ; saved_to_d1c
    db 0
    db 0 ; spawn_and_flags
    db 0x40 ; more_flags
    dw 3 ; screen_mode
    dw 0x200 ; saved_to_d3a
    df garden_graphic
    df bomb_and_explosions_graphic
    df clouds_graphic
    df garden_level_structure
    df compressed_stage_1_6_overlay_tilemap
    dw 0x14 ; level_representation
    dw 0 ; hard_blocks
    dw 50 ; soft_blocks, off by one in story mode, for the level exit
    df create_flower_zone_handler
    df load_palettes
    df flower_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df western_zone_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52565
    dw 6
    df tile_animation
    df byte_C52688
    dw 2
    df create_overlay_scroller
    dw 0
    dw 0
    dw 0xFFFF
    dw 0
    dw 0xF0F0
    dw 0
    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP
    dw SPEED_UP, POISON, POISON, REMOTE_CONTROL, REMOTE_CONTROL, KICK, KICK, KICK, PUNCH, PUNCH
    dw PUNCH, 0
    db 0x17, 0, 2, 0x83, 0xE4, 0, 0, 0, 0, 0
    
light_zone:
    db 0 ; saved_to_d1c
    db 0
    db 0 ; spawn_and_flags
    db 4 ; more_flags
    dw 3 ; screen_mode
    dw 0x200 ; saved_to_d3a
    df dome_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df dome_level_structure
    df compressed_spotlight_tilemap
    dw 0x14 ; level_representation
    dw 0 ; hard_blocks
    dw 55 ; soft_blocks, off by one in story mode, for the level exit
    df create_spotlight
    df load_palettes
    df light_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df western_zone_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C51FED
    dw 6
    df tile_animation
    df byte_C5200C
    dw 2
    dw 0xF0F0
    dw 0
    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP
    dw SPEED_UP, SPEED_UP, SPEED_UP, KICK, KICK, PUNCH, PUNCH, POISON, POISON, POISON
    dw POISON, POISON, POISON, POISON, POISON, 0
    db 0x12, 0x1D, 2, 0x83, 0xE0, 0, 0x80, 0, 0x80, 0
    
power_zone:
    db 0 ; saved_to_d1c
    db 0
    db 0 ; spawn_and_flags
    db 1 ; more_flags
    dw 3 ; screen_mode
    dw 0x200 ; saved_to_d3a
    df power_zone_graphic; tileset_pointer
    df bomb_and_explosions_graphic
    df empty_tilemap
    df power_zone_level_structure
    df empty_tilemap
    dw 0x41 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df locret_C463DD
    df load_palettes
    df power_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df western_zone_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C527AB
    dw 0x22
    df tile_animation
    df byte_C527B4
    dw 0x24
    df tile_animation
    df byte_C527BD
    dw 0x28
    df tile_animation
    df byte_C527C6
    dw 0x2A
    df tile_animation
    df byte_C527CF
    dw 0x40
    df tile_animation
    df byte_C527D8
    dw 0x26
    df tile_animation
    df byte_C527E1
    dw 0x2E
    df tile_animation
    df byte_C527EA
    dw 0x2C
    dw 0xF0F0
    dw 0
    dw POISON, POISON, POISON, POISON, POISON, POISON, POISON, POISON, POISON, POISON
    dw 3, 0
    db 0x17, 0x17, 0, 0x83, 0xE8, 0, 0, 0, 0, 0
    
warp_zone:
    db 0 ; saved_to_d1c
    db 0
    db 0x20 ; spawn_and_flags
    db 0 ; more_flags
    dw 3 ; screen_mode
    dw 0x200 ; saved_to_d3a
    df warp_zone_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df warp_zone_level_structure
    df empty_tilemap
    dw 0x14 ; level_representation
    dw 0 ; hard_blocks
    dw 50 ; soft_blocks, off by one in story mode, for the level exit
    df locret_C463DD
    df load_palettes
    df warp_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df warp_zone_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52915
    dw 0x26
    dw 0xF0F0
    dw 0
    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP
    dw SPEED_UP, SPEED_UP, SPEED_UP, POISON, POISON, KICK, KICK, KICK, PUNCH, PUNCH
    dw PUNCH, FULL_FIRE, FULL_FIRE, 0
    db 0x17, 0x17, 0, 0x83, 0xE8, 0, 0, 0, 0, 0
    
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
    db 0 ; saved_to_d1c
    db 0
    db 0x10 ; spawn_and_flags
    db 0 ; more_flags
    dw 3 ; screen_mode
    dw 0x200 ; saved_to_d3a
    df speed_zone_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df speed_zone_level_structure
    df empty_tilemap
    dw 0x41 ; level_representation
    dw 0 ; hard_blocks
    dw 80 ; soft_blocks, off by one in story mode, for the level exit
    df locret_C463DD
    df load_palettes
    df speed_zone_battle_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df western_zone_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52854
    dw 2
    df tile_animation
    df byte_C52854
    dw 6
    dw 0xF0F0
    dw 0
    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP
    dw POISON, POISON, KICK, KICK, KICK, PUNCH, PUNCH, PUNCH, FULL_FIRE, FULL_FIRE
    dw REMOTE_CONTROL, REMOTE_CONTROL, 0
    db 0x17, 0x17, 0, 0x83, 0xE8, 0, 0, 0, 0, 0
    
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
    
unknown_palettes:
    db HUD_PALETTE, DIAMOND_TOWER_PALETTE_1, DIAMOND_TOWER_PALETTE_2; a_palettes
    db DIAMOND_TOWER_BOMB_PALETTE, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db DIAMOND_TOWER_BOMB_PALETTE, DIAMOND_TOWER_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db AKA_PALETTE, AO_PALETTE, FREE, WHITE_PALETTE; b_palettes
    
unknown_palettes2:
    db    HUD_PALETTE, 0x56, 0x57, 0x58, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db 0x59, 0x5A ; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, GREEN_BOMB_PALETTE; b_palettes
    db RED_BOMB_PALETTE, AKA_PALETTE, AO_PALETTE, BLACK_PALETTE;    b_palettes
    db WHITE_PALETTE ; b_palettes
    
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
    db HUD_PALETTE, DOME_PALETTE_1_INVERT, DOME_PALETTE_2_INVERT; a_palettes
    db DOME_PALETTE_3_INVERT, BONUS_1_INVERT_PALETTE, BONUS_2_INVERT_PALETTE; a_palettes
    db DOME_BOMB_PALETTE_INVERT, DOME_FIRE_PALETTE_INVERT; a_palettes
    db INVERT_SHIRO, INVERT_KURO, INVERT_BOMB, INVERT_FIRE_BOMB;    b_palettes
    db INVERT_AKA, INVERT_AO, INVERT_BLACK, INVERT_WHITE; b_palettes
    
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