# Each tuple is: (graphics, structure, palettes, graphic list, forced features, optional features, palettes prefix)
areas = [
    ("peace_town_graphic", "peace_town_level_structure", "peace_town_palettes", "standard_level_graphics", """
        .FARADDR tile_animation
        .FARADDR peace_town_unshaded_soft_animation
        .WORD 6
        .FARADDR tile_animation
        .FARADDR peace_town_shaded_soft_animation
        .WORD 2""", ".FARADDR create_random_bomb_drop", "PEACE_TOWN_"),
    ("village_graphic", "village_level_structure", "village_palettes", "standard_level_graphics", "", "", "VILLAGE_"),
    ("castle_graphic", "castle_level_structure", "castle_palettes", "standard_level_graphics", """
        .FARADDR tile_animation
        .FARADDR byte_C51E3C
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C51E3C
        .WORD 2""", "", "CASTLE_"),
    ("park_graphic", "park_level_structure", "park_palettes", "standard_level_graphics", "", "", "PARK_"),
    ("circus_graphic", "circus_level_structure", "circus_palettes", "standard_level_graphics", "", """
        .FARADDR tile_animation
        .FARADDR byte_C522FA
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C523FF
        .WORD 2""", "CIRCUS_"),
    ("garden_graphic", "garden_level_structure", "garden_palettes", "standard_level_graphics", """
        .FARADDR tile_animation
        .FARADDR byte_C52565
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C52688
        .WORD 2""", ".FARADDR create_flower_zone_handler", "GARDEN_"),
    ("factory_graphic", "factory_level_structure", "factory_palettes", "standard_level_graphics", """
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 6
        .FARADDR create_moving_platforms""", "", "FACTORY_"),
    ("dome_graphic", "dome_level_structure", "dome_palettes", "standard_level_graphics", """
        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2""", "", "DOME_"),
    ("speed_zone_graphic", "speed_zone_level_structure", "speed_zone_palettes", "standard_level_graphics", """
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 6""", "", "SPEED_ZONE_"),
    ("diamond_tower_tileset_graphic", "diamond_tower_level_structure", "diamond_tower_palettes", "standard_level_graphics", """
        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4""", "", "DIAMOND_TOWER_"),

    # Stages from battle mode
    ("normal_zone_graphic", "normal_zone_level_structure", "normal_zone_level_palettes", "standard_level_graphics", "", "", "NORMAL_ZONE_"),
    ("tunnel_zone_graphic", "tunnel_zone_level_structure", "tunnel_zone_level_palettes", "standard_level_graphics", "", "", "TUNNEL_ZONE_"),
    ("warp_zone_graphic", "warp_zone_level_structure", "warp_zone_level_palettes", "standard_level_graphics", "", "", "WARP_ZONE_"),
]

boss_stages = [
"""
    .DEFINE BIGARON_BOSS_PALETTE_1 {3}PALETTE_1
    .DEFINE BIGARON_BOSS_PALETTE_2 {3}PALETTE_2
    .DEFINE BIGARON_BOSS_PALETTE_3 {3}PALETTE_3
    .DEFINE BIGARON_BOSS_BOMB_PALETTE {3}BOMB_PALETTE
    .DEFINE BIGARON_BOSS_FIRE_PALETTE {3}FIRE_PALETTE
    .DEFINE BIGARON_WORLD {2}
    .BYTE $E		; saved_to_d1c
    .BYTE 0
    .BYTE 2			; spawn_and_flags
    .BYTE 0			; more_flags
    .WORD 2			; screen_mode
    .WORD $70		; saved_to_d3a
    .FARADDR {0}
    .FARADDR bomb_and_explosions_graphic
    .FARADDR empty_tilemap
    .FARADDR {1}
    .FARADDR empty_tilemap
    .WORD ${2}8		; level_representation
    .WORD 0			; hard_blocks
    .WORD 0			; soft_blocks
                ; Off by one in	story mode, for	the level exit
    .FARADDR load_palettes
    .FARADDR bigaron_boss_palettes
    .WORD $10
    .BYTE 0
    .FARADDR load_global_sprites
    .FARADDR boss_level_graphics
    .WORD $10
    .BYTE 0
    .FARADDR tile_animation
    .FARADDR byte_C51E3C
    .WORD 6
    .FARADDR tile_animation
    .FARADDR byte_C51E3C
    .WORD 2
    .WORD $F0F0
    .FARADDR create_bigaron
    .WORD 0
    .WORD 0
""",
"""
    .DEFINE CLOWN_MASK_BOSS_PALETTE_1 {3}PALETTE_1
    .DEFINE CLOWN_MASK_BOSS_PALETTE_2 {3}PALETTE_2
    .DEFINE CLOWN_MASK_BOSS_PALETTE_3 {3}PALETTE_3
    .DEFINE CLOWN_MASK_BOSS_BOMB_PALETTE {3}BOMB_PALETTE
    .DEFINE CLOWN_MASK_BOSS_FIRE_PALETTE {3}FIRE_PALETTE
    .BYTE $E		; saved_to_d1c
    .BYTE 0
    .BYTE 2			; spawn_and_flags
    .BYTE 0			; more_flags
    .WORD 2			; screen_mode
    .WORD $80		; saved_to_d3a
    .FARADDR {0}
    .FARADDR bomb_and_explosions_graphic
    .FARADDR spotlights_graphic
    .FARADDR {1}
    .FARADDR compressed_clown_spotlight_tilemap
    .WORD ${2}8		; level_representation
    .WORD 0			; hard_blocks
    .WORD 0			; soft_blocks
                ; Off by one in	story mode, for	the level exit
    .FARADDR load_palettes
    .FARADDR clown_mask_boss_palettes
    .WORD $10
    .BYTE 0
    .FARADDR load_global_sprites
    .FARADDR boss_level_graphics
    .WORD $10
    .BYTE 0
    .WORD $F0F0
    .FARADDR create_clown_mask
    .WORD 0
    .WORD 0
""",
"""
    .BYTE 0			; saved_to_d1c
    .BYTE 0
    .BYTE 2			; spawn_and_flags
    .BYTE $80		; $80 here sets a flags that disables "automatic" detection
                    ; of hard block and free spaces tiles, and forces the hard
                    ; coded values of 0804 and 0808.
    .WORD 2			; screen_mode
    .WORD $80		; saved_to_d3a
    .FARADDR factory_graphic
    .FARADDR bomb_and_explosions_graphic ; {0}
    .FARADDR trampoline_and_crane_graphic; overlay_tileset_pointer
    .FARADDR crane_boss_level_structure
    .FARADDR compressed_handcrane_tilemap ; {1}
    .WORD ${2}8		; level_representation
    .WORD 0			; hard_blocks
    .WORD 0			; soft_blocks
                ; Off by one in	story mode, for	the level exit
    .FARADDR load_palettes
    .FARADDR crane_hand_boss_palettes
    .WORD $10
    .BYTE 0
    .FARADDR load_global_sprites
    .FARADDR level_3_8_graphics_array
    .WORD $10
    .BYTE 0
    .WORD $F0F0
    .FARADDR create_crane_hand
    .WORD 0
    .WORD 0
""",
"""
    .BYTE $E		; saved_to_d1c
    .BYTE 0
    .BYTE 3			; spawn_and_flags
    .BYTE 0			; more_flags
    .WORD 2			; screen_mode
    .WORD $80		; saved_to_d3a
    .FARADDR power_zone_graphic; {0}
    .FARADDR bomb_and_explosions_graphic
    .FARADDR empty_tilemap
    .FARADDR power_zone_level_structure ; {1}
    .FARADDR empty_tilemap
    .WORD ${2}8		; level_representation
    .WORD 0			; hard_blocks
    .WORD 0			; soft_blocks
                ; Off by one in	story mode, for	the level exit
    .FARADDR load_palettes
    .FARADDR mecha_onita_boss_palettes
    .WORD $10
    .BYTE 0
    .FARADDR load_global_sprites
    .FARADDR off_C31A35
    .WORD $10
    .BYTE 0
    .FARADDR tile_animation
    .FARADDR byte_C527AB
    .WORD $22
    .FARADDR tile_animation
    .FARADDR byte_C527B4
    .WORD $24
    .FARADDR tile_animation
    .FARADDR byte_C527BD
    .WORD $28
    .FARADDR tile_animation
    .FARADDR byte_C527C6
    .WORD $2A
    .FARADDR tile_animation
    .FARADDR byte_C527CF
    .WORD $40
    .FARADDR tile_animation
    .FARADDR byte_C527D8
    .WORD $26
    .FARADDR tile_animation
    .FARADDR byte_C527E1
    .WORD $2E
    .FARADDR tile_animation
    .FARADDR byte_C527EA
    .WORD $2C
    .WORD $F0F0
    .FARADDR create_mecha_onita
    .WORD 0
    .WORD 0
""",
"""
    .BYTE $E		; saved_to_d1c
    .BYTE 0
    .BYTE 3			; spawn_and_flags
    .BYTE 0			; more_flags
    .WORD 2			; screen_mode
    .WORD $90		; saved_to_d3a
    .FARADDR diamond_tower_tileset_graphic ; {0}
    .FARADDR bomb_and_explosions_graphic
    .FARADDR spiderer_bg_graphic; overlay_tileset_pointer
    .FARADDR diamond_tower_level_structure ; {1}
    .FARADDR compressed_spiderer_tilemap
    .WORD ${2}8		; level_representation
    .WORD 0			; hard_blocks
    .WORD 0			; soft_blocks
                ; Off by one in	story mode, for	the level exit
    .FARADDR load_palettes
    .FARADDR spiderer_boss_palettes
    .WORD $10
    .BYTE 0
    .FARADDR load_global_sprites
    .FARADDR spiderer_boss_graphics
    .WORD $10
    .BYTE 0
    .FARADDR tile_animation
    .FARADDR byte_C527F3
    .WORD 4
    .WORD $F0F0
    .FARADDR create_spiderer
    .WORD 0
    .WORD 0
"""
]

easy_enemies   = [(1,   x) for x in ["banen", "douken", "kouraru", "starnuts", "propene"]]
medium_enemies = [(1.5, x) for x in ["anzenda", "denkyun", "cuppen", "dengurin", "bakuda"]] + \
                 [(2.5, x) for x in ["moguchan", "red_bakuda", "kinkaru", "kierun", "chameleoman", "kuwagen"]]
hard_enemies   = [(3,   x) for x in ["keibin",  "metal_kuwagen", "metal_u"]] + \
                 [(4,   x) for x in ["metal_propene", "pakupa", "robocom", "senshiyan"]]

basic_bonuses = ["BOMB_UP", "BOMB_UP", "BOMB_UP", "FIRE_UP", "FIRE_UP", "SPEED_UP"]
special_bonuses = ["REMOTE_CONTROL", "BOMB_PASS", "WALL_PASS", "RED_BOMBS", "KICK", "PUNCH", "FULL_FIRE"]
diff_reduce_bonuses = ["VEST", "EXTRA_LIFE", "EXTRA_TIME"]
hidden_bonuses = ["RANDOM", "RANDOM", "RANDOM", "ONIGIRI", "CAKE", "KENDAMA", "APPLE", "FIRE_EXT", "POPSICLE", "ICE_CREAM"]

mecha_bomberman_palettes = ["MECHA_BOMBER_WHITE_PALETTE", "MECHA_BOMBER_BLACK_PALETTE", "MECHA_BOMBER_RED_PALETTE", "MECHA_BOMBER_BLUE_PALETTE", "MECHA_BOMBER_GREEN_PALETTE",	"MECHA_BOMBER_MAGENTA_PALETTE", "MECHA_BOMBER_PURPLE_PALETTE", "MECHA_BOMBER_GOLD_PALETTE"]

# How areas the divided between worlds.
world_areas = [[0,0,0,0,1,1,1], [2,2,2,3,3,3,3], [4,4,4,5,5,6,6], [7,7,7,8,8,9,9], [10,10,11,11,11,12,12]]