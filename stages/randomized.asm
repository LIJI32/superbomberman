stage_1_1:

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
    .FARADDR park_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR park_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $11        ; level_representation
    .WORD 1         ; hard_blocks
    .WORD 31         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR park_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_1_2:

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
    .FARADDR speed_zone_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR speed_zone_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $12        ; level_representation
    .WORD 10         ; hard_blocks
    .WORD 39         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR speed_zone_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 6

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_1_3:

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
    .FARADDR village_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR village_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $13        ; level_representation
    .WORD 28         ; hard_blocks
    .WORD 26         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR village_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_1_4:

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
    .FARADDR park_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR park_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $14        ; level_representation
    .WORD 7         ; hard_blocks
    .WORD 26         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR park_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_1_5:

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
    .FARADDR garden_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR garden_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $15        ; level_representation
    .WORD 6         ; hard_blocks
    .WORD 46         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR garden_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C52565
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C52688
        .WORD 2

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_1_6:

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
    .FARADDR park_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR park_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $16        ; level_representation
    .WORD 14         ; hard_blocks
    .WORD 24         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR park_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_1_7:

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
    .FARADDR diamond_tower_tileset_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR diamond_tower_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $17        ; level_representation
    .WORD 10         ; hard_blocks
    .WORD 28         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR diamond_tower_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_1_8:

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
    .FARADDR park_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR park_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $18        ; level_representation
    .WORD 23         ; hard_blocks
    .WORD 40         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR park_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_2_1:

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
    .FARADDR park_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR park_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $21        ; level_representation
    .WORD 3         ; hard_blocks
    .WORD 47         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR park_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_2_2:

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
    .FARADDR diamond_tower_tileset_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR diamond_tower_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $22        ; level_representation
    .WORD 0         ; hard_blocks
    .WORD 31         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR diamond_tower_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_2_3:

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
    .FARADDR circus_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR circus_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $23        ; level_representation
    .WORD 22         ; hard_blocks
    .WORD 30         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR circus_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


        .FARADDR tile_animation
        .FARADDR byte_C522FA
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C523FF
        .WORD 2
    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_2_4:

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
    .FARADDR peace_town_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR peace_town_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $24        ; level_representation
    .WORD 4         ; hard_blocks
    .WORD 40         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR peace_town_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR peace_town_unshaded_soft_animation
        .WORD 6
        .FARADDR tile_animation
        .FARADDR peace_town_shaded_soft_animation
        .WORD 2

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_2_5:

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
    .FARADDR peace_town_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR peace_town_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $25        ; level_representation
    .WORD 17         ; hard_blocks
    .WORD 39         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR peace_town_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR peace_town_unshaded_soft_animation
        .WORD 6
        .FARADDR tile_animation
        .FARADDR peace_town_shaded_soft_animation
        .WORD 2
.FARADDR create_random_bomb_drop
    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_2_6:

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
    .FARADDR diamond_tower_tileset_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR diamond_tower_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $26        ; level_representation
    .WORD 5         ; hard_blocks
    .WORD 34         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR diamond_tower_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_2_7:

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
    .FARADDR village_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR village_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $27        ; level_representation
    .WORD 22         ; hard_blocks
    .WORD 37         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR village_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_2_8:

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
    .FARADDR village_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR village_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $28        ; level_representation
    .WORD 7         ; hard_blocks
    .WORD 41         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR village_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_3_1:

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
    .FARADDR circus_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR circus_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $31        ; level_representation
    .WORD 1         ; hard_blocks
    .WORD 30         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR circus_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_3_2:

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
    .FARADDR speed_zone_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR speed_zone_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $32        ; level_representation
    .WORD 20         ; hard_blocks
    .WORD 37         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR speed_zone_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 6

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_3_3:

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
    .FARADDR dome_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR dome_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $33        ; level_representation
    .WORD 23         ; hard_blocks
    .WORD 33         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR dome_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_3_4:

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
    .FARADDR diamond_tower_tileset_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR diamond_tower_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $34        ; level_representation
    .WORD 0         ; hard_blocks
    .WORD 32         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR diamond_tower_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_3_5:

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
    .FARADDR village_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR village_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $35        ; level_representation
    .WORD 20         ; hard_blocks
    .WORD 39         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR village_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_3_6:

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
    .FARADDR diamond_tower_tileset_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR diamond_tower_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $36        ; level_representation
    .WORD 30         ; hard_blocks
    .WORD 40         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR diamond_tower_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_3_7:

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
    .FARADDR dome_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR dome_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $37        ; level_representation
    .WORD 8         ; hard_blocks
    .WORD 45         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR dome_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_3_8:

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
    .FARADDR factory_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR factory_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $38        ; level_representation
    .WORD 5         ; hard_blocks
    .WORD 39         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR factory_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 6
        .FARADDR create_moving_platforms

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_4_1:

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
    .FARADDR park_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR park_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $41        ; level_representation
    .WORD 16         ; hard_blocks
    .WORD 39         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR park_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_4_2:

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
    .FARADDR peace_town_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR peace_town_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $42        ; level_representation
    .WORD 8         ; hard_blocks
    .WORD 41         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR peace_town_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR peace_town_unshaded_soft_animation
        .WORD 6
        .FARADDR tile_animation
        .FARADDR peace_town_shaded_soft_animation
        .WORD 2

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_4_3:

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
    .FARADDR circus_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR circus_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $43        ; level_representation
    .WORD 1         ; hard_blocks
    .WORD 37         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR circus_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_4_4:

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
    .FARADDR diamond_tower_tileset_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR diamond_tower_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $44        ; level_representation
    .WORD 8         ; hard_blocks
    .WORD 38         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR diamond_tower_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_4_5:

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
    .FARADDR dome_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR dome_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $45        ; level_representation
    .WORD 4         ; hard_blocks
    .WORD 30         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR dome_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_4_6:

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
    .FARADDR circus_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR circus_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $46        ; level_representation
    .WORD 21         ; hard_blocks
    .WORD 27         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR circus_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_4_7:

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
    .FARADDR park_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR park_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $47        ; level_representation
    .WORD 23         ; hard_blocks
    .WORD 41         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR park_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_4_8:

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
    .FARADDR diamond_tower_tileset_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR diamond_tower_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $48        ; level_representation
    .WORD 8         ; hard_blocks
    .WORD 48         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR diamond_tower_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_5_1:

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
    .FARADDR diamond_tower_tileset_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR diamond_tower_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $51        ; level_representation
    .WORD 32         ; hard_blocks
    .WORD 38         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR diamond_tower_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C527F3
        .WORD 4

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_5_2:

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
    .FARADDR speed_zone_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR speed_zone_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $52        ; level_representation
    .WORD 13         ; hard_blocks
    .WORD 47         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR speed_zone_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 6

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_5_3:

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
    .FARADDR dome_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR dome_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $53        ; level_representation
    .WORD 1         ; hard_blocks
    .WORD 25         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR dome_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_5_4:

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
    .FARADDR circus_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR circus_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $54        ; level_representation
    .WORD 22         ; hard_blocks
    .WORD 43         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR circus_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_5_5:

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
    .FARADDR village_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR village_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $55        ; level_representation
    .WORD 17         ; hard_blocks
    .WORD 32         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR village_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_5_6:

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
    .FARADDR dome_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR dome_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $56        ; level_representation
    .WORD 4         ; hard_blocks
    .WORD 33         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR dome_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_5_7:

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
    .FARADDR circus_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR circus_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $57        ; level_representation
    .WORD 17         ; hard_blocks
    .WORD 38         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR circus_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_5_8:

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
    .FARADDR park_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR park_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $58        ; level_representation
    .WORD 14         ; hard_blocks
    .WORD 34         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR park_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_6_1:

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
    .FARADDR village_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR village_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $61        ; level_representation
    .WORD 9         ; hard_blocks
    .WORD 38         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR village_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_6_2:

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
    .FARADDR peace_town_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR peace_town_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $62        ; level_representation
    .WORD 32         ; hard_blocks
    .WORD 46         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR peace_town_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR peace_town_unshaded_soft_animation
        .WORD 6
        .FARADDR tile_animation
        .FARADDR peace_town_shaded_soft_animation
        .WORD 2
.FARADDR create_random_bomb_drop
    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_6_3:

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
    .FARADDR garden_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR garden_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $63        ; level_representation
    .WORD 19         ; hard_blocks
    .WORD 26         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR garden_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C52565
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C52688
        .WORD 2

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_6_4:

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
    .FARADDR garden_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR garden_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $64        ; level_representation
    .WORD 3         ; hard_blocks
    .WORD 36         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR garden_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C52565
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C52688
        .WORD 2

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_6_5:

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
    .FARADDR peace_town_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR peace_town_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $65        ; level_representation
    .WORD 10         ; hard_blocks
    .WORD 39         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR peace_town_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR peace_town_unshaded_soft_animation
        .WORD 6
        .FARADDR tile_animation
        .FARADDR peace_town_shaded_soft_animation
        .WORD 2
.FARADDR create_random_bomb_drop
    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_6_6:

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
    .FARADDR castle_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR castle_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $66        ; level_representation
    .WORD 4         ; hard_blocks
    .WORD 24         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR castle_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C51E3C
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C51E3C
        .WORD 2

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_6_7:

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
    .FARADDR park_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR park_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $67        ; level_representation
    .WORD 32         ; hard_blocks
    .WORD 29         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR park_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?


    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
stage_6_8:

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
    .FARADDR dome_graphic ; Tileset graphic
    .FARADDR bomb_and_explosions_graphic ; Bomb overlay graphic
    .FARADDR empty_tilemap ; Foreground Tileset (Despite the default being a tilemap!)
    .FARADDR dome_level_structure ; Level structure
    .FARADDR empty_tilemap ; Foreground Tilemap
    .WORD $68        ; level_representation
    .WORD 3         ; hard_blocks
    .WORD 43         ; soft_blocks
                     ; Off by one in    story mode, for    the level exit
    .FARADDR load_palettes; Init functions and their parameters
    .FARADDR dome_palettes
    .WORD $10 ; Number of palettes
    .BYTE 0 ; Unused?
    .FARADDR load_global_sprites
    .FARADDR standard_level_graphics
    .WORD $10 ; Number of graphic lists
    .BYTE 0 ; Unused?

        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2

    .WORD $F0F0        ; F0F0 marks the end of the init function list
    ; List of enemy create functions
    .FARADDR create_propene
    .FARADDR create_propene
    .FARADDR create_propene
    .WORD 0            ; null terminator
    .WORD BOMB_UP, BOMB_UP, FIRE_UP, 0 ; null terminated bonus array
