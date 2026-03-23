stage_4_1:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x40 ; saved_to_d3a
    df dome_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df dome_level_structure
    df empty_tilemap
    dw 0x41 ; level_representation
    dw 6 ; hard_blocks
    dw 32 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df dome_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C51FED
    dw 6
    df tile_animation
    df byte_C5200C
    dw 2
    df hidden_bonus_object
    dw 4
    db 0
    dw POPSICLE
    db 0
    dw 0xF0F0
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
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x40 ; saved_to_d3a
    df dome_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df dome_level_structure
    df empty_tilemap
    dw 0x42 ; level_representation
    dw 3 ; hard_blocks
    dw 34 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df dome_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C51FED
    dw 6
    df tile_animation
    df byte_C5200C
    dw 2
    dw 0xF0F0
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
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x49 ; saved_to_d3a
    df dome_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df dome_level_structure
    df empty_tilemap
    dw 0x43 ; level_representation
    dw 5 ; hard_blocks
    dw 33 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df dome_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C51FED
    dw 6
    df tile_animation
    df byte_C5200C
    dw 2
    dw 0xF0F0
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
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x38 ; saved_to_d3a
    df dome_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df dome_level_structure
    df empty_tilemap
    dw 0x44 ; level_representation
    dw 7 ; hard_blocks
    dw 32 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df dome_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C51FED
    dw 6
    df tile_animation
    df byte_C5200C
    dw 2
    df hidden_bonus_object
    dw 6
    db 0
    dw RANDOM
    db 0
    dw 0xF0F0
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
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x33 ; saved_to_d3a
    df dome_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df dome_level_structure
    df empty_tilemap
    dw 0x45 ; level_representation
    dw 3 ; hard_blocks
    dw 32 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df dome_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C51FED
    dw 6
    df tile_animation
    df byte_C5200C
    dw 2
    df hidden_bonus_object
    dw 0
    db 0
    dw FIRE_EXT
    db 0
    dw 0xF0F0
    df create_metal_propene
    df create_metal_propene
    df create_metal_propene
    df create_red_bakuda
    df create_red_bakuda
    df create_red_bakuda
    dw 0
    dw EXTRA_LIFE, EXTRA_TIME, EXTRA_TIME, 0
    
stage_4_6:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x48 ; saved_to_d3a
    df dome_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df dome_level_structure
    df empty_tilemap
    dw 0x46 ; level_representation
    dw 5 ; hard_blocks
    dw 32 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df dome_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C51FED
    dw 6
    df tile_animation
    df byte_C5200C
    dw 2
    dw 0xF0F0
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
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x49 ; saved_to_d3a
    df dome_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df dome_level_structure
    df empty_tilemap
    dw 0x47 ; level_representation
    dw 5 ; hard_blocks
    dw 35 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df dome_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C51FED
    dw 6
    df tile_animation
    df byte_C5200C
    dw 2
    df hidden_bonus_object
    dw 2
    db 0
    dw HEART
    db 0
    dw 0xF0F0
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
    db 0xE ; saved_to_d1c
    db 0
    db 3 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x80 ; saved_to_d3a
    df power_zone_graphic; tileset_pointer
    df bomb_and_explosions_graphic
    df empty_tilemap
    df power_zone_level_structure
    df empty_tilemap
    dw 0x48 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df mecha_onita_boss_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df off_C31A35
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
    df create_mecha_onita
    dw 0
    dw 0
    
off_C31A35:
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