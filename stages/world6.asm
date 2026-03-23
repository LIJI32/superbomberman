stage_6_1:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x35 ; saved_to_d3a
    df speed_zone_graphic
    df bomb_and_explosions_graphic
    df clouds_graphic
    df speed_zone_level_structure
    df compressed_stage_1_6_overlay_tilemap
    dw 0x61 ; level_representation
    dw 4 ; hard_blocks
    dw 36 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df speed_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52854
    dw 2
    df tile_animation
    df byte_C52854
    dw 6
    df set_overlay_blending
    db 2
    db 0x15 ; TODO
    db 2
    db 0x22
    df create_overlay_scroller
    dw 0
    dw 0
    dw 0xFFFF
    dw 0
    dw 0xF0F0
    df create_propene
    df create_banen
    df create_banen
    df create_propene
    df create_denkyun
    df create_denkyun
    dw 0
    dw BOMB_UP, FIRE_UP, WALL_PASS, 0
    
stage_6_2:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x40 ; saved_to_d3a
    df speed_zone_graphic
    df bomb_and_explosions_graphic
    df clouds_graphic
    df speed_zone_level_structure
    df compressed_stage_1_6_overlay_tilemap
    dw 0x62 ; level_representation
    dw 4 ; hard_blocks
    dw 35 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df speed_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52854
    dw 2
    df tile_animation
    df byte_C52854
    dw 6
    df set_overlay_blending
    db 2
    db 0x15
    db 2
    db 0x22
    df create_overlay_scroller
    dw 0
    dw 0
    dw 1
    dw 0
    df hidden_bonus_object
    dw 9
    db 0
    dw CAKE
    db 0
    dw 0xF0F0
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
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x37 ; saved_to_d3a
    df speed_zone_graphic
    df bomb_and_explosions_graphic
    df clouds_graphic
    df speed_zone_level_structure
    df compressed_stage_1_6_overlay_tilemap
    dw 0x63 ; level_representation
    dw 4 ; hard_blocks
    dw 34 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df speed_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52854
    dw 2
    df tile_animation
    df byte_C52854
    dw 6
    df set_overlay_blending
    db 2
    db 0x15
    db 2
    db 0x22
    df create_overlay_scroller
    dw 0
    dw 0x100
    dw 0xFFFF
    dw 0
    dw 0xF0F0
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
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x30 ; saved_to_d3a
    df diamond_tower_tileset_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df diamond_tower_level_structure
    df empty_tilemap
    dw 0x64 ; level_representation
    dw 0 ; hard_blocks
    dw 23 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df diamond_tower_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C527F3
    dw 4
    df hidden_bonus_object
    dw 0xB
    db 0
    dw APPLE
    db 0
    dw 0xF0F0
    df create_yoroisu
    df create_yoroisu
    dw 0
    dw BOMB_UP, EXTRA_TIME, EXTRA_LIFE, 0
    
stage_6_5:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x40 ; saved_to_d3a
    df diamond_tower_tileset_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df diamond_tower_level_structure
    df empty_tilemap
    dw 0x65 ; level_representation
    dw 3 ; hard_blocks
    dw 35 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df diamond_tower_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C527F3
    dw 4
    df hidden_bonus_object
    dw 8
    db 0
    dw ICE_CREAM
    db 0
    dw 0xF0F0
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
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x45 ; saved_to_d3a
    df diamond_tower_tileset_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df diamond_tower_level_structure
    df empty_tilemap
    dw 0x66 ; level_representation
    dw 5 ; hard_blocks
    dw 35 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df diamond_tower_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C527F3
    dw 4
    dw 0xF0F0
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
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x36 ; saved_to_d3a
    df diamond_tower_tileset_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df diamond_tower_level_structure
    df empty_tilemap
    dw 0x67 ; level_representation
    dw 4 ; hard_blocks
    dw 37 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df diamond_tower_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C527F3
    dw 4
    df hidden_bonus_object
    dw 3
    db 0
    dw HEART
    db 0
    dw 0xF0F0
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
    db 0xE ; saved_to_d1c
    db 0
    db 3 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x90 ; saved_to_d3a
    df diamond_tower_tileset_graphic
    df bomb_and_explosions_graphic
    df spiderer_bg_graphic; overlay_tileset_pointer
    df diamond_tower_level_structure
    df compressed_spiderer_tilemap
    dw 0x68 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df spiderer_boss_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df spiderer_boss_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C527F3
    dw 4
    dw 0xF0F0
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