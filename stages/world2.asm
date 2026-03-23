stage_2_1:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x47 ; saved_to_d3a
    df park_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df park_level_structure
    df empty_tilemap
    dw 0x21 ; level_representation
    dw 6 ; hard_blocks
    dw 33 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df park_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    dw 0xF0F0
    df create_cuppen
    df create_cuppen
    df create_douken
    df create_douken
    df create_banen
    df create_banen
    df create_banen
    df create_banen
    dw 0
    dw BOMB_UP, VEST, EXTRA_TIME, 0
    
stage_2_2:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x45 ; saved_to_d3a
    df park_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df park_level_structure
    df empty_tilemap
    dw 0x22 ; level_representation
    dw 6 ; hard_blocks
    dw 32 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df park_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df hidden_bonus_object
    dw 3
    db 0
    dw ONIGIRI
    db 0
    dw 0xF0F0
    df create_bakuda
    df create_cuppen
    df create_cuppen
    df create_bakuda
    df create_bakuda
    df create_cuppen
    df create_cuppen
    dw 0
    dw PUNCH, BOMB_PASS, 0
    
stage_2_3:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x44 ; saved_to_d3a
    df park_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df park_level_structure
    df empty_tilemap
    dw 0x23 ; level_representation
    dw 5 ; hard_blocks
    dw 34 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df park_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    dw 0xF0F0
    df create_douken
    df create_douken
    df create_douken
    df create_banen
    df create_banen
    df create_banen
    df create_metal_u
    dw 0
    dw BOMB_UP, FIRE_UP, REMOTE_CONTROL, 0
    
stage_2_4:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x44 ; saved_to_d3a
    df park_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df park_level_structure
    df empty_tilemap
    dw 0x24 ; level_representation
    dw 5 ; hard_blocks
    dw 33 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df park_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df hidden_bonus_object
    dw 5
    db 0
    dw RANDOM
    db 0
    dw 0xF0F0
    df create_kierun
    df create_kierun
    df create_kierun
    df create_bakuda
    df create_bakuda
    df create_bakuda
    df create_denkyun
    df create_denkyun
    dw 0
    dw WALL_PASS, VEST, 0
    
stage_2_5:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x43 ; saved_to_d3a
    df park_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df park_level_structure
    df empty_tilemap
    dw 0x25 ; level_representation
    dw 7 ; hard_blocks
    dw 32 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df park_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    dw 0xF0F0
    df create_kinkaru
    df create_banen
    df create_banen
    df create_banen
    df create_kinkaru
    df create_kinkaru
    df create_kinkaru
    dw 0
    dw BOMB_UP, SPEED_UP, FIRE_UP, 0
    
stage_2_6:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x43 ; saved_to_d3a
    df circus_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df circus_level_structure
    df empty_tilemap
    dw 0x26 ; level_representation
    dw 4 ; hard_blocks
    dw 35 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df circus_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    dw 0xF0F0
    df create_douken
    df create_douken
    df create_douken
    df create_banen
    df create_banen
    df create_red_bakuda
    df create_red_bakuda
    dw 0
    dw KICK, PUNCH, 0
    
stage_2_7:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x42 ; saved_to_d3a
    df circus_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df circus_level_structure
    df empty_tilemap
    dw 0x27 ; level_representation
    dw 3 ; hard_blocks
    dw 34 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df circus_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C522FA
    dw 6
    df tile_animation
    df byte_C523FF
    dw 2
    df hidden_bonus_object
    dw 8
    db 0
    dw HEART
    db 0
    dw 0xF0F0
    df create_cuppen
    df create_cuppen
    df create_banen
    df create_banen
    df create_pakupa
    df create_pakupa
    df create_pakupa
    dw 0
    dw BOMB_UP, SPEED_UP, SPEED_UP, 0
    
stage_2_8:
    db 0xE ; saved_to_d1c
    db 0
    db 2 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x80 ; saved_to_d3a
    df circus_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df circus_level_structure
    df compressed_spotlight_tilemap
    dw 0x28 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df clown_mask_boss_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df boss_level_graphics
    dw 0x10
    db 0
    dw 0xF0F0
    df create_clown_mask
    dw 0
    dw 0
    
park_palettes:
    db HUD_PALETTE, PARK_PALETTE_1, PARK_PALETTE_2, PARK_PALETTE_3; a_palettes
    db BONUS_PALETTE_1, BONUS_PALETTE_2, PARK_BOMB_PALETTE; a_palettes
    db PARK_FIRE_PALETTE ; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE, FREE, FREE, WHITE_PALETTE; b_palettes
    
circus_palettes:
    db HUD_PALETTE, CIRCUS_PALETTE_1, CIRCUS_PALETTE_2; a_palettes
    db CIRCUS_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db CIRCUS_BOMB_PALETTE, CIRCUS_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE, FREE, FREE, WHITE_PALETTE; b_palettes
    
clown_mask_boss_palettes:
    db HUD_PALETTE, CIRCUS_PALETTE_1, CIRCUS_PALETTE_2; a_palettes
    db CIRCUS_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db CIRCUS_BOMB_PALETTE, CIRCUS_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db CLOWN_MASK_PALETTE_0, CLOWN_MASK_PALETTE_1, CLOWN_MASK_PALETTE_2;    b_palettes
    db WHITE_PALETTE ; b_palettes