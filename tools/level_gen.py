import random

# Each tuple is: (graphics, structure, palettes, graphic list, forced features, optional features)
# Not included yet: areas from battle mode
areas = [
    ("peace_town_graphic", "peace_town_level_structure", "peace_town_palettes", "standard_level_graphics", """
        .FARADDR tile_animation
        .FARADDR peace_town_unshaded_soft_animation
        .WORD 6
        .FARADDR tile_animation
        .FARADDR peace_town_shaded_soft_animation
        .WORD 2""", ".FARADDR create_random_bomb_drop"),
    ("village_graphic", "village_level_structure", "village_palettes", "standard_level_graphics", "", ""),
    ("castle_graphic", "castle_level_structure", "castle_palettes", "standard_level_graphics", """
        .FARADDR tile_animation
        .FARADDR byte_C51E3C
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C51E3C
        .WORD 2""", ""),
    ("park_graphic", "park_level_structure", "park_palettes", "standard_level_graphics", "", ""),
    ("circus_graphic", "circus_level_structure", "circus_palettes", "standard_level_graphics", "", """
        .FARADDR tile_animation
        .FARADDR byte_C522FA
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C523FF
        .WORD 2"""),
    ("garden_graphic", "garden_level_structure", "garden_palettes", "standard_level_graphics", """
        .FARADDR tile_animation
        .FARADDR byte_C52565
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C52688
        .WORD 2""", ".FARADDR create_flower_zone_handler"),
    ("factory_graphic", "factory_level_structure", "factory_palettes", "standard_level_graphics", """
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 6
        .FARADDR create_moving_platforms""", ""),
    ("dome_graphic", "dome_level_structure", "dome_palettes", "standard_level_graphics", """
        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2""", ""),
    ("speed_zone_graphic", "speed_zone_level_structure", "speed_zone_palettes", "standard_level_graphics", """
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 6""", ""),
    ("diamond_tower_tileset_graphic", "diamond_tower_level_structure", "diamond_tower_palettes", "standard_level_graphics", """
        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4""", ""),

    # Stages from battle mode
    ("normal_zone_graphic", "normal_zone_level_structure", "normal_zone_level_palettes", "standard_level_graphics", "", ""),
    ("tunnel_zone_graphic", "tunnel_zone_level_structure", "tunnel_zone_level_palettes", "standard_level_graphics", "", ""),
    ("warp_zone_graphic", "warp_zone_level_structure", "warp_zone_level_palettes", "standard_level_graphics", "", ""),
]

def generate_random_level(world, level):
    # Just repeat the first level with differnt backgrounds, and optionally random features.
    area = areas[world_areas[world - 1][level - 1]]
    print """
    .BYTE $E
    .BYTE 0
    .BYTE 1         ; Spawn spot index and flags
                    ; Bit   1: Power Mode (Battle mode only)
                    ; Bit   2: Western mode, but without not-allowed soft-block locations (Battle mode only)
                    ; Bit   4: Required for Light Zone to correctly display the scoreboard
                    ; Bit   8: Disable soft blocks inside tunnels in tunnel zone
                    ; Bit $10: Belt Mode
                    ; Bit $20: Unused?
                    ; Bit $40: Used in Flower Zone, NOT related to flower growth, tractors or clouds.
                    ; Bit $80: Default tile and pallete IDs for hard block and empty tiles
    .BYTE 0         ; More flags
    .WORD 2         ; Screen mode. Always 2 for story mode stages
    .WORD $50       ; saved_to_d3a, unknown
    .FARADDR %s ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR %s ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $%x        ; level_representation
    .WORD %d         ; hard_blocks
    .WORD %d         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR %s
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR %s
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?
%s
%s
    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array""" % (area[0], area[1], world * 16 + level, random.randint(0, 32), random.randint(24, 48), area[2], area[3], area[4], "" if random.randint(0, 1) else area[5])


# How areas the divided between worlds. This will later be altered to take the arena and bosses into account
world_areas = [[0,0,0,0,1,1,1,1], [2,2,2,2,3,3,3,3], [4,4,4,4,5,5,5,5], [6,6,6,6,7,7,7,7], [8,8,8,8,9,9,9,9], [10,10,11,11,11,12,12,12]]
random.shuffle(world_areas)
random.shuffle(areas)
for world in xrange(0, 6):
    for level in xrange(0, 8):
        print "stage_%d_%d:" % (world + 1, level + 1)
        generate_random_level(world + 1, level + 1)
