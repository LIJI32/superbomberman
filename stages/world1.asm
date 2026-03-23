stage_1_1:
    db 0xE ; saved_to_d1c
    db 0
    ; Bit   1 and 2: Spawn spot index (story mode only)
    ; Bit   4: disables not-allowed soft-block locations, and exist in Story Mode
    ; Bit   8: Western mode (Breaks story mode)
    ; Bit 0x10: Speed Mode (Battle mode only)
    ; Bit 0x20: Required for warps to work. Disable soft blocks on warp
    ; Bit 0x40: Trampolines
    ; Bit 0x80: Unused?
    db 1 ; Spawn spot index and flags
    ; Bit   1: Power Mode (Battle mode only)
    ; Bit   2: Western mode, but without not-allowed soft-block locations (Battle mode only)
    ; Bit   4: Required for Light Zone to correctly display the scoreboard
    ; Bit   8: disable soft blocks inside tunnels in tunnel zone
    ; Bit 0x10: Belt Mode
    ; Bit 0x20: Unused?
    ; Bit 0x40: Used in Flower Zone, NOT related to flower growth, tractors or clouds.
    ; Bit 0x80: default tile and pallete IDs for hard block and empty tiles
    db 0 ; More flags
    dw 2 ; screen_mode
    dw 0x50 ; saved_to_d3a
    df peace_town_graphic ; Tileset graphic
    df bomb_and_explosions_graphic ; Bomb overlay graphic
    df empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    df peace_town_level_structure ; Level structure
    df empty_tilemap ; Foreground Tilemap
    dw 0x11 ; level_representation
    dw 8 ; hard_blocks
    dw 32 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes ; Init functions and their parameters
    df peace_town_palettes
    dw 0x10 ; Number of palettes
    db 0 ; Unused?
    df load_global_sprites
    df standard_level_graphics
    dw 0x10 ; Number of graphic lists
    db 0 ; Unused?
    df tile_animation
    df peace_town_unshaded_soft_animation ; Animation definition
    dw 6 ; Tile id to animate
    df tile_animation
    df peace_town_shaded_soft_animation ; Animation definition
    dw 2 ; Tile id to animate
    dw 0xF0F0 ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    df create_propene
    df create_propene
    df create_propene
    dw 0 ; null terminator
    dw BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
    
stage_1_2:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x50 ; saved_to_d3a
    df peace_town_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df peace_town_level_structure
    df empty_tilemap
    dw 0x12 ; level_representation
    dw 6 ; hard_blocks
    dw 34 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df peace_town_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df peace_town_unshaded_soft_animation
    dw 6
    df tile_animation
    df peace_town_shaded_soft_animation
    dw 2
    df hidden_bonus_object
    dw 7
    db 0
    dw ICE_CREAM
    db 0
    dw 0xF0F0
    df create_propene
    df create_propene
    df create_propene
    df create_denkyun
    df create_denkyun
    dw 0
    dw BOMB_UP, SPEED_UP, 0
    
stage_1_3:
    db 0xF ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x50 ; saved_to_d3a
    df village_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df village_level_structure
    df empty_tilemap
    dw 0x13 ; level_representation
    dw 6 ; hard_blocks
    dw 34 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df village_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df hidden_bonus_object
    dw 6
    db 0
    dw POPSICLE
    db 0
    dw 0xF0F0
    df create_starnuts
    df create_starnuts
    df create_starnuts
    df create_starnuts
    df create_starnuts
    df create_starnuts
    df create_starnuts
    df create_starnuts
    df create_starnuts
    dw 0
    dw BOMB_UP, KICK, FIRE_UP, 0
    
stage_1_4:
    db 0xF ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x49 ; saved_to_d3a
    df village_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df village_level_structure
    df empty_tilemap
    dw 0x14 ; level_representation
    dw 6 ; hard_blocks
    dw 33 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df village_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df hidden_bonus_object
    dw 2
    db 0
    dw CAKE
    db 0
    dw 0xF0F0
    df create_propene
    df create_propene
    df create_denkyun
    df create_denkyun
    df create_bakuda
    df create_bakuda
    dw 0
    dw SPEED_UP, VEST, 0
    
stage_1_5:
    db 0xF ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x48 ; saved_to_d3a
    df village_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df village_level_structure
    df empty_tilemap
    dw 0x15 ; level_representation
    dw 6 ; hard_blocks
    dw 33 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df village_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df hidden_bonus_object
    dw 4
    db 0
    dw RANDOM
    db 0
    dw 0xF0F0
    df create_bakuda
    df create_bakuda
    df create_bakuda
    df create_pakupa
    df create_propene
    df create_propene
    dw 0
    dw EXTRA_TIME, REMOTE_CONTROL, KICK, 0
    
stage_1_6:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x47 ; saved_to_d3a
    df castle_graphic
    df bomb_and_explosions_graphic
    df clouds_graphic
    df castle_level_structure
    df compressed_stage_1_6_overlay_tilemap
    dw 0x16 ; level_representation
    dw 6 ; hard_blocks
    dw 33 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df castle_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C51E3C
    dw 6
    df tile_animation
    df byte_C51E3C
    dw 2
    df set_overlay_blending
    dw 0x1502
    dw 0x2202
    df create_overlay_scroller
    dw 0
    dw 0
    dw 0xFFFF
    dw 0
    dw 0xF0F0
    df create_senshiyan
    df create_senshiyan
    df create_denkyun
    df create_denkyun
    df create_bakuda
    df create_bakuda
    dw 0
    dw BOMB_UP, WALL_PASS, 0
    
stage_1_7:
    db 0xE ; saved_to_d1c
    db 0
    db 1 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x46 ; saved_to_d3a
    df castle_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df castle_level_structure
    df empty_tilemap
    dw 0x17 ; level_representation
    dw 7 ; hard_blocks
    dw 32 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df castle_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df standard_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C51E3C
    dw 6
    df tile_animation
    df byte_C51E3C
    dw 2
    df hidden_bonus_object
    dw 1
    db 0
    dw HEART
    db 0
    dw 0xF0F0
    df create_senshiyan
    df create_senshiyan
    df create_senshiyan
    df create_bakuda
    df create_bakuda
    df create_bakuda
    dw 0
    dw BOMB_UP, SPEED_UP, EXTRA_LIFE, 0
    
stage_1_8:
    db 0xE ; saved_to_d1c
    db 0
    db 2 ; spawn_and_flags
    db 0 ; more_flags
    dw 2 ; screen_mode
    dw 0x70 ; saved_to_d3a
    df castle_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df castle_level_structure
    df empty_tilemap
    dw 0x18 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df bigaron_boss_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df boss_level_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C51E3C
    dw 6
    df tile_animation
    df byte_C51E3C
    dw 2
    dw 0xF0F0
    df create_bigaron
    dw 0
    dw 0
    
peace_town_palettes:
    db HUD_PALETTE, PEACE_TOWN_PALETTE_1, PEACE_TOWN_PALETTE_2; a_palettes
    db PEACE_TOWN_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db PEACE_TOWN_BOMB_PALETTE, PEACE_TOWN_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE, FREE, FREE, WHITE_PALETTE; b_palettes
    
village_palettes:
    db HUD_PALETTE, VILLAGE_PALETTE_1, VILLAGE_PALETTE_2; a_palettes
    db VILLAGE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db VILLAGE_BOMB_PALETTE, VILLAGE_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE, FREE, FREE, WHITE_PALETTE; b_palettes
    
castle_palettes:
    db HUD_PALETTE, CASTLE_PALETTE_1, CASTLE_PALETTE_2; a_palettes
    db CASTLE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db CASTLE_BOMB_PALETTE, CASTLE_FIRE_PALETTE;    a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db FREE, FREE, FREE, WHITE_PALETTE; b_palettes
    
bigaron_boss_palettes:
    db HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BACKGROUND_BLACK_PALETTE, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE; a_palettes
    db BLACK_PALETTE, BLACK_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db BLACK_PALETTE, BLACK_PALETTE, BLACK_PALETTE, BLACK_PALETTE; b_palettes