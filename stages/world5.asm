stage_5_1:
    db 0xE ; saved_to_d1c
    db 0
    db 5 ; spawn_and_flags
    db 0x80 ; 0x80 here sets a flags that disables "automatic" detection
 ; of hard block and free spaces tiles, and forces the hard
 ; coded values of 0804 and 0808. It is used in all stages in
 ; world 5.
    dw 2 ; screen_mode
    dw 0x30 ; saved_to_d3a
    df arena_graphic ; tileset_bank
    df bomb_and_explosions_graphic
    df empty_tilemap
    df arena_level_structure
    df empty_tilemap
    dw 0x51 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df arena_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df off_C31D6D
    dw 0x10
    db 0
    df loc_C436C1
    df locret_C463DD
    df tile_animation
    df byte_C536D5
    dw 0x20
    df tile_animation
    df byte_C53716
    dw 0x22
    df tile_animation
    df byte_C53716+0x61
    dw 0x24
    df tile_animation
    df byte_C537C4
    dw 0x26
    dw 0xF0F0
    dw 0
    dw 0
    
stage_5_2:
    db 0xE ; saved_to_d1c
    db 0
    db 5 ; spawn_and_flags
    db 0x80 ; more_flags
    dw 2 ; screen_mode
    dw 0x30 ; saved_to_d3a
    df arena_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df arena_level_structure
    df empty_tilemap
    dw 0x52 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df arena_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df off_C31D6D
    dw 0x10
    db 0
    df loc_C436C1
    df locret_C463DD
    df tile_animation
    df byte_C536D5
    dw 0x20
    df tile_animation
    df byte_C53716
    dw 0x22
    df tile_animation
    df byte_C53716+0x61
    dw 0x24
    df tile_animation
    df byte_C537C4
    dw 0x26
    dw 0xF0F0
    dw 0
    dw 0
    
stage_5_3:
    db 0xE ; saved_to_d1c
    db 0
    db 5 ; spawn_and_flags
    db 0x80 ; more_flags
    dw 2 ; screen_mode
    dw 0x30 ; saved_to_d3a
    df arena_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df arena_level_structure
    df empty_tilemap
    dw 0x53 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df arena_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df off_C31D6D
    dw 0x10
    db 0
    df loc_C436C1
    df locret_C463DD
    df tile_animation
    df byte_C536D5
    dw 0x20
    df tile_animation
    df byte_C53716
    dw 0x22
    df tile_animation
    df byte_C53716+0x61
    dw 0x24
    df tile_animation
    df byte_C537C4
    dw 0x26
    dw 0xF0F0
    dw 0
    dw 0
    
stage_5_4:
    db 0xE ; saved_to_d1c
    db 0
    db 5 ; spawn_and_flags
    db 0x80 ; more_flags
    dw 2 ; screen_mode
    dw 0x30 ; saved_to_d3a
    df arena_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df arena_level_structure
    df empty_tilemap
    dw 0x54 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df arena_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df off_C31D6D
    dw 0x10
    db 0
    df loc_C436C1
    df locret_C463DD
    df tile_animation
    df byte_C536D5
    dw 0x20
    df tile_animation
    df byte_C53716
    dw 0x22
    df tile_animation
    df byte_C53716+0x61
    dw 0x24
    df tile_animation
    df byte_C537C4
    dw 0x26
    dw 0xF0F0
    dw 0
    dw 0
    
stage_5_5:
    db 0xE ; saved_to_d1c
    db 0
    db 5 ; spawn_and_flags
    db 0x80 ; more_flags
    dw 2 ; screen_mode
    dw 0x30 ; saved_to_d3a
    df arena_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df arena_level_structure
    df empty_tilemap
    dw 0x55 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df arena_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df off_C31D6D
    dw 0x10
    db 0
    df loc_C436C1
    df locret_C463DD
    df tile_animation
    df byte_C536D5
    dw 0x20
    df tile_animation
    df byte_C53716
    dw 0x22
    df tile_animation
    df byte_C53716+0x61
    dw 0x24
    df tile_animation
    df byte_C537C4
    dw 0x26
    dw 0xF0F0
    dw 0
    dw 0
    
stage_5_6:
    db 0xE ; saved_to_d1c
    db 0
    db 5 ; spawn_and_flags
    db 0x80 ; more_flags
    dw 2 ; screen_mode
    dw 0x30 ; saved_to_d3a
    df arena_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df arena_level_structure
    df empty_tilemap
    dw 0x56 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df arena_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df off_C31D6D
    dw 0x10
    db 0
    df loc_C436C1
    df locret_C463DD
    df tile_animation
    df byte_C536D5
    dw 0x20
    df tile_animation
    df byte_C53716
    dw 0x22
    df tile_animation
    df byte_C53716+0x61
    dw 0x24
    df tile_animation
    df byte_C537C4
    dw 0x26
    dw 0xF0F0
    dw 0
    dw 0
    
stage_5_7:
    db 0xE ; saved_to_d1c
    db 0
    db 5 ; spawn_and_flags
    db 0x80 ; more_flags
    dw 2 ; screen_mode
    dw 0x30 ; saved_to_d3a
    df arena_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df arena_level_structure
    df empty_tilemap
    dw 0x57 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df arena_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df off_C31D6D
    dw 0x10
    db 0
    df loc_C436C1
    df locret_C463DD
    df tile_animation
    df byte_C536D5
    dw 0x20
    df tile_animation
    df byte_C53716
    dw 0x22
    df tile_animation
    df byte_C53716+0x61
    dw 0x24
    df tile_animation
    df byte_C537C4
    dw 0x26
    dw 0xF0F0
    dw 0
    dw 0
    
stage_5_8:
    db 0xE ; saved_to_d1c
    db 0
    db 5 ; spawn_and_flags
    db 0x80 ; more_flags
    dw 2 ; screen_mode
    dw 0x50 ; saved_to_d3a
    df arena_graphic
    df bomb_and_explosions_graphic
    df empty_tilemap
    df arena_level_structure
    df empty_tilemap
    dw 0x58 ; level_representation
    dw 0 ; hard_blocks
    dw 0 ; soft_blocks, off by one in story mode, for the level exit
    df load_palettes
    df arena_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df off_C31D6D
    dw 0x10
    db 0
    df loc_C436C1
    df locret_C463DD
    df tile_animation
    df byte_C536D5
    dw 0x20
    df tile_animation
    df byte_C53716
    dw 0x22
    df tile_animation
    df byte_C53716+0x61
    dw 0x24
    df tile_animation
    df byte_C537C4
    dw 0x26
    dw 0xF0F0
    dw 0
    dw 0
    
arena_palettes:
    db HUD_PALETTE, ARENA_PALETTE_1, ARENA_PALETTE_2, ARENA_PALETTE_3; a_palettes
    db BONUS_PALETTE_1, BONUS_PALETTE_2, ARENA_BOMB_PALETTE; a_palettes
    db ARENA_FIRE_PALETTE; a_palettes
    db SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
    db MECHA_BOMBER_GOLD_PALETTE, ARENA_GATE_PALETTE, BLACK_PALETTE; b_palettes
    db WHITE_PALETTE ; b_palettes
    
off_C31D6D:
    df bomberman_graphic_0
    df bomberman_graphic_1
    df bomberman_graphic_2
    df bomberman_graphic_3
    df mecha_bomberman_graphic_0
    df mecha_bomberman_graphic_1
    df mecha_bomberman_graphic_2
    df mecha_bomberman_graphic_3
    df mook_graphic_0
    df mook_graphic_1
    df carat_diamond_graphic_0
    df carat_diamond_graphic_1
    df carat_diamond_graphic_2
    df arena_gate_graphic
    df bomb_graphic
    df time_up_graphic_0
