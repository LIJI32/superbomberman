macro empty_palette
dw 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F
endmacro

macro palette type, name
incbin "$OUT/graphics/$type/$name.bin"
endmacro

macro partial_palette type, name, start, end
incbin "$OUT/graphics/$type/$name.bin", ($start) * 2, (($end) - ($start)) * 2
endmacro

macro bomb_palette name
partial_palette overlays, bomb_and_explosions_palette_1, (. / 2) & 0xF, 11
partial_palette backgrounds, $name, 11, 14
partial_palette overlays, bomb_and_explosions_palette_1, 14, 16
endmacro

macro fire_palette name
partial_palette overlays, bomb_and_explosions_palette_0, (./2) & 0xF, 11
partial_palette backgrounds, $name, 11, 14
partial_palette overlays, bomb_and_explosions_palette_0, 14, 16
endmacro

a_palettes:
incbin "$OUT/graphics/bg3_tileset_palette.bin" ; 0x0 HUD_PALETTE
palette backgrounds, peace_town_palette_1 ; 0x1 PEACE_TOWN_PALETTE_1
palette backgrounds, peace_town_palette_0 ; 0x2 PEACE_TOWN_PALETTE_2
palette backgrounds, peace_town_palette_3 ; 0x3 PEACE_TOWN_PALETTE_3
palette backgrounds, bonuses_palette_1 ; 0x4 BONUS_PALETTE_1
palette backgrounds, bonuses_palette_0 ; 0x5 BONUS_PALETTE_2
bomb_palette peace_town_palette_3 ; 0x6 PEACE_TOWN_BOMB_PALETTE
fire_palette peace_town_palette_3 ; 0x7 PEACE_TOWN_FIRE_PALETTE
dw 0x400, 0, 0, 0x108, 0x16B, 0x1EF, 0x2B5, 0x75A, 0x3BFD, 0x7FFF, 0x2108, 0x14A5, 0x2D8C, 0x5F, 0x4EEB, 0x2E09 ; [8]_palette
dw 0, 0x11C3, 0x4D43, 0, 0xD44, 0x1E66, 0x26E8, 0x3BCE, 0x1103, 0x69E7, 0x63F7, 0x3524, 0x730A, 0x2901, 0x7FFF, 0x7FD8 ; [9]_palette
palette backgrounds, village_palette_0  ; 0xa VILLAGE_PALETTE_1
palette backgrounds, village_palette_2  ; 0xb VILLAGE_PALETTE_2
palette backgrounds, village_palette_3  ; 0xc VILLAGE_PALETTE_3
bomb_palette village_palette_2 ; 0xd VILLAGE_BOMB_PALETTE
fire_palette village_palette_2 ; 0xe VILLAGE_FIRE_PALETTE
dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; BACKGROUND_BLACK_PALETTE
palette backgrounds, castle_palette_2  ; 0x10 CASTLE_PALETTE_1
palette backgrounds, castle_palette_1  ; 0x11 CASTLE_PALETTE_2
palette backgrounds, castle_palette_0  ; 0x12 CASTLE_PALETTE_3
bomb_palette castle_palette_2  ; 0x13 CASTLE_BOMB_PALETTE
fire_palette castle_palette_2  ; 0x14 CASTLE_FIRE_PALETTE
palette backgrounds, dome_palette_3  ; 0x15 DOME_PALETTE_1
palette backgrounds, dome_palette_1  ; 0x16 DOME_PALETTE_2
palette backgrounds, dome_palette_0  ; 0x17 DOME_PALETTE_3
bomb_palette dome_palette_0 ; 0x18 DOME_BOMB_PALETTE
fire_palette dome_palette_0   ; 0x19 DOME_FIRE_PALETTE
palette backgrounds, park_palette_3  ; 0x1a PARK_PALETTE_1
palette backgrounds, park_palette_0  ; 0x1b PARK_PALETTE_2
palette backgrounds, park_palette_1  ; 0x1c PARK_PALETTE_3
bomb_palette park_palette_0 ; 0x1d PARK_BOMB_PALETTE
fire_palette park_palette_0 ; 0x1e PARK_FIRE_PALETTE
dw 0xC63, 0xE40, 0x1FF, 0, 0x5800, 0xC, 0x13, 0xFF, 0x7FFF, 0x1A, 0x7D20, 0x1B1, 0x16B9, 0x4400, 0x3C00, 0x7C00 ; [0x1F]_palette
dw 0x1084, 0x2860, 0x5800, 0xE40, 0x118, 0xCF, 0xAA, 0x25, 0x15C, 0x7D20, 0, 0x7FFF, 0x7C00, 0x3C00, 0x1B1, 0x16B9 ; [0x20]_palette
dw 0x157, 0x88, 0x17C, 0xAC, 0x95, 0x7BFE, 0x15B, 0x6B9E, 0x7D60, 0x7F60, 0x4000, 0xE40, 0x160, 0x2720, 0x1C, 0x7FFF ; [0x21]_palette
dw 0x6000, 0x2D68, 0x3D87, 0x7752, 0x2BF, 0x624B, 0x4A91, 0x7FFF, 0x2905, 0x1CE4, 0x800, 0xE40, 0x160, 0x2720, 0x14A2, 0x41F ; [0x22]_palette
dw 0x45CA, 0x10, 0x12, 0x23FF, 0x2DF, 0xB8, 0x17F, 0x7FFF, 0x2D, 0x29, 0x25, 0xE40, 0x160, 0x2720, 0x66, 0x1F ; [0x23]_palette
palette backgrounds, circus_palette_2  ; 0x24 CIRCUS_PALETTE_1
palette backgrounds, circus_palette_1  ; 0x25 CIRCUS_PALETTE_2
palette backgrounds, circus_palette_0  ; 0x26 CIRCUS_PALETTE_3

if FIXED_OVERLAY_PALETTES
bomb_palette circus_palette_1 ; 0x27 CIRCUS_BOMB_PALETTE
fire_palette circus_palette_1 ; 0x28 CIRCUS_FIRE_PALETTE
else
; 0x27 CIRCUS_BOMB_PALETTE
partial_palette overlays, bomb_and_explosions_palette_1, 0, 10
partial_palette backgrounds, circus_palette_1, 10, 13
dw 0x0088
partial_palette overlays, bomb_and_explosions_palette_1, 14, 16
; 0x28 CIRCUS_BOMB_PALETTE
partial_palette overlays, bomb_and_explosions_palette_0, 0, 10
partial_palette backgrounds, circus_palette_1, 10, 13
dw 0x0088
partial_palette overlays, bomb_and_explosions_palette_0, 14, 16
endif

palette backgrounds, factory_palette_3  ; 0x29 FACTORY_PALETTE_1
palette backgrounds, factory_palette_2  ; 0x2a FACTORY_PALETTE_2
palette backgrounds, factory_palette_0  ; 0x2b FACTORY_PALETTE_3

if FIXED_OVERLAY_PALETTES
bomb_palette factory_palette_3 ; 0x2c FACTORY_BOMB_PALETTE
fire_palette factory_palette_3 ;0x2d FACTORY_FIRE_PALETTE
else
; 0x2c FACTORY_BOMB_PALETTE
partial_palette overlays, bomb_and_explosions_palette_1, 0, 11
partial_palette backgrounds, factory_palette_3, 11, 13
dw 0x0015
partial_palette overlays, bomb_and_explosions_palette_1, 14, 16
; 0x2d FACTORY_FIRE_PALETTE
dw 0x7C1F
partial_palette overlays, bomb_and_explosions_palette_0, 1, 11
partial_palette backgrounds, factory_palette_3, 11, 13
dw 0x0015
partial_palette overlays, bomb_and_explosions_palette_0, 14, 16
endif

dw 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF ; 0x2e BACKGROUND_WHITE_PALETTE
palette backgrounds, arena_palette_1  ; 0x2f ARENA_PALETTE_1
palette backgrounds, arena_palette_0  ; 0x30 ARENA_PALETTE_2
palette backgrounds, arena_palette_2  ; 0x31 ARENA_PALETTE_3

bomb_palette arena_palette_1 ; 0x32 ARENA_BOMB_PALETTE
if !FIXED_OVERLAY_PALETTES
dw 0x7C1F
endif
fire_palette arena_palette_1 ; 0x33 ARENA_FIRE_PALETTE

dw 0x21C8, 0xDF, 0x7FFF, 0x35F, 0x7FFF, 0x1FF, 0x1C, 0x18, 0x14, 0x1D, 0x2400, 0x3F, 0x15, 0x1F, 0x1A, 0x4C ; [0x34]_palette
palette backgrounds, trampoline_and_crane_palette_1 ; 0x35 CRANE_BG_PALETTE
palette backgrounds, garden_palette_1  ; 0x36 GARDEN_PALETTE_1
palette backgrounds, garden_palette_0  ; 0x37 GARDEN_PALETTE_2
palette backgrounds, garden_palette_2  ; 0x38 GARDEN_PALETTE_3
bomb_palette garden_palette_1 ; 0x39 GARDEN_BOMB_PALETTE
fire_palette garden_palette_1 ; 0x3a GARDEN_FIRE_PALETTE
palette backgrounds, power_zone_palette_0  ; 0x3b POWER_ZONE_PALETTE_1
palette backgrounds, power_zone_palette_1  ; 0x3c POWER_ZONE_PALETTE_2
bomb_palette power_zone_palette_0 ; 0x3d POWER_ZONE_BOMB_PALETTE
fire_palette power_zone_palette_0 ; 0x3e POWER_ZONE_FIRE_PALETTE
palette backgrounds, circus_palette_4  ; 0x3f CLOWN_MASK_SPOTLIGHT_PALETTE
palette backgrounds, diamond_tower_tileset_palette_0  ; 0x40 DIAMOND_TOWER_PALETTE_1
palette backgrounds, diamond_tower_tileset_palette_1  ; 0x41 DIAMOND_TOWER_PALETTE_2
bomb_palette diamond_tower_tileset_palette_0  ; 0x42 DIAMOND_TOWER_BOMB_PALETTE
fire_palette diamond_tower_tileset_palette_0  ; 0x43 DIAMOND_TOWER_FIRE_PALETTE
palette backgrounds, speed_zone_palette_3  ; 0x44 SPEED_ZONE_PALETTE_1
palette backgrounds, speed_zone_palette_0  ; 0x45 SPEED_ZONE_PALETTE_2
palette backgrounds, speed_zone_palette_1  ; 0x46 SPEED_ZONE_PALETTE_3
bomb_palette speed_zone_palette_3 ; 0x47 SPEED_ZONE_BOMB_PALETTE
fire_palette speed_zone_palette_3 ; 0x48 SPEED_ZONE_FIRE_PALETTE
palette backgrounds, normal_zone_palette_0  ; 0x49 NORMAL_ZONE_PALETTE

if FIXED_OVERLAY_PALETTES
bomb_palette normal_zone_palette_0  ; 0x4a NORMAL_ZONE_BOMB_PALETTE
fire_palette normal_zone_palette_0  ; 0x4b NORMAL_ZONE_FIRE_PALETTE
else
; 0x4a NORMAL_ZONE_BOMB_PALETTE
partial_palette overlays, bomb_and_explosions_palette_1, 0, 10
partial_palette backgrounds, normal_zone_palette_0, 10, 12
dw 0x7C1F
dw 0x7C1F
partial_palette overlays, bomb_and_explosions_palette_1, 14, 16
; 0x4b NORMAL_ZONE_FIRE_PALETTE
partial_palette overlays, bomb_and_explosions_palette_0, 0, 10
partial_palette backgrounds, normal_zone_palette_0, 10, 12
dw 0x7C1F
dw 0x7C1F
partial_palette overlays, bomb_and_explosions_palette_0, 14, 16
endif

palette backgrounds, warp_zone_palette_0  ; 0x4c WARP_ZONE_PALETTE_1
palette backgrounds, warp_zone_palette_2  ; 0x4d WARP_ZONE_PALETTE_2
palette backgrounds, warp_zone_palette_3  ; 0x4e WARP_ZONE_PALETTE_3
bomb_palette warp_zone_palette_3 ; 0x4f WARP_ZONE_BOMB_PALETTE
fire_palette warp_zone_palette_3 ; 0x50 WARP_ZONE_FIRE_PALETTE
palette backgrounds, tunnel_zone_palette_0  ; 0x51 TUNNEL_ZONE_PALETTE_1
palette backgrounds, tunnel_zone_palette_1  ; 0x52 TUNNEL_ZONE_PALETTE_2
palette backgrounds, tunnel_zone_palette_2  ; 0x53 TUNNEL_ZONE_PALETTE_3
bomb_palette tunnel_zone_palette_0 ; 0x54 TUNNEL_ZONE_BOMB_PALETTE
fire_palette tunnel_zone_palette_0 ; 0x55 TUNNEL_ZONE_FIRE_PALETTE
empty_palette ; [0x56]_palette
empty_palette ; [0x57]_palette
empty_palette ; [0x58]_palette
empty_palette ; [0x59]_palette
empty_palette ; [0x5A]_palette
palette backgrounds, map_palette_0  ; 0x5b MAP_PALETTE_1
palette backgrounds, map_palette_1  ; 0x5c MAP_PALETTE_2
palette backgrounds, map_palette_2  ; 0x5d MAP_PALETTE_3
palette backgrounds, draw_screen_gradient_palette ; 0x5e DRAW_BG_PALETTE
dw 0x400, 0x154A, 0x21EF, 0x3739, 0x7FFF, 0x3C00, 0x7AC0, 0x89, 0x4CA, 0x7800, 0x67, 0x7B30, 0x2800, 0x2CE3, 0xE7, 0x7DC0 ; [0x5F]_palette
palette backgrounds, battle_win_palette_1  ; 0x60 VICTORY_YELLOW_BOMBERMAN_PALETTE
palette backgrounds, battle_win_palette_2  ; 0x61 VICTORY_ORANGE_BOMBERMAN_PALETTE
palette backgrounds, battle_win_palette_3  ; 0x62 VICTORY_BLUE_BOMBERMAN_PALETTE
palette backgrounds, battle_win_palette_4  ; 0x63 VICTORY_GREEN_BOMBERMAN_PALETTE
palette backgrounds, battle_win_palette_5  ; 0x64 VICTORY_MAGENTA_BOMBERMAN_PALETTE
palette backgrounds, battle_win_palette_0  ; 0x65 VICTORY_GRASS_PALETTE
palette backgrounds, battle_win_palette_6  ; 0x66 VICTORY_PURPLE_BOMBERMAN_PALETTE
palette overlays, title_palette_0  ; 0x67 LOGO_PALETTE_1
palette overlays, title_palette_1  ; 0x68 LOGO_PALETTE_2
palette backgrounds, dome_invert_palette_3  ; 0x69 DOME_PALETTE_1_INVERT
palette backgrounds, dome_invert_palette_1  ; 0x6a DOME_PALETTE_2_INVERT
palette backgrounds, dome_invert_palette_0  ; 0x6b DOME_PALETTE_3_INVERT
dw 0x6000, 0x5297, 0x4278, 0x8AD, 0x7D40, 0x1DB4, 0x356E, 0, 0x56FA, 0x631B, 0x77FF, 0x3A58, 0x42FE, 0x1B7, 0x6B5D, 0x7BE0 ; 0x6c DOME_BOMB_PALETTE_INVERT
palette backgrounds, dome_invert_palette_2  ; 0x6d DOME_FIRE_PALETTE_INVERT
palette backgrounds, bonuses_invert_palette_1  ; 0x6e BONUS_1_INVERT_PALETTE
palette backgrounds, bonuses_invert_palette_0  ; 0x6f BONUS_2_INVERT_PALETTE
dw 0x4631, 0x52, 0x7FFF, 0x21E, 0, 0x4FFF, 0x52, 0x21E, 0, 0x1C, 0x5C00, 0x21E, 0, 0x52, 0x7FFF, 0x21E ; [0x70]_palette
palette backgrounds, continue_background_palette  ; 0x71 CONTINUE_PALETTE_1
palette backgrounds, title_background_palette  ; 0x72 CONTINUE_PALETTE_2
palette backgrounds, spiderer_bg_palette_0  ; 0x73 SPIDERER_BG_PALETTE_1
palette overlays, credit_image_2_palette_1  ; 0x74 CREDITS_END_PALETTE
palette backgrounds, spiderer_bg_palette_1  ; 0x75 SPIDERER_BG_PALETTE_2
palette backgrounds, spiderer_fire_bg_palette_0  ; 0x76 SPIDERER_FIRE_BG_PALETTE_1
dw 0x31E6, 0xC87, 0x4AD9, 0x318C, 0xD, 0x18C6, 0x6F7B, 0x214C, 0x11F, 0xAE, 0x1A, 0x1FF, 0x3DEF, 0x13E, 0x7FFF, 0x73A ; [0x77]_palette
palette backgrounds, spiderer_fire_bg_palette_1  ; 0x78 SPIDERER_FIRE_BG_PALETTE_2
palette backgrounds, spiderer_bg_palette_2 ; 0x79 SPIDERER_BG_PALETTE_3
dw 0x29CD, 0, 0, 0x3DEF, 0x2529, 0x18C6, 0x180, 0x80, 0x240, 0x320, 0x155, 0x1DE, 0x3DF, 0x120, 0x1C, 0x7FFF ; 0x7a GARDEN_PALETTE_3_COPY
empty_palette ; [0x7B]_palette
empty_palette ; [0x7C]_palette
palette overlays, credit_image_1_palette_1  ; 0x7d CREDITS_SEPIA_PALETTE_1
dw 0, 0x2616, 0x1992, 0xD2E, 0x2EDD, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F ; [0x7E]_palette
palette overlays, credit_image_2_palette_0  ; 0x7f CREDITS_SEPIA_PALETTE_2
palette overlays, credit_image_1_palette_0  ; 0x80 CREDITS_SEPIA_PALETTE_3
dw 0, 0x19F5, 0xD91, 0x110D, 0x2258, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F ; [0x81]_palette
dw 0, 0x1A17, 0xD92, 0x110D, 0x267A, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F, 0x7C1F ; [0x82]_palette
empty_palette ; [0x83]_palette
empty_palette ; [0x84]_palette
empty_palette ; [0x85]_palette
empty_palette ; [0x86]_palette
empty_palette ; [0x87]_palette
empty_palette ; [0x88]_palette
empty_palette ; [0x89]_palette
empty_palette ; [0x8A]_palette
empty_palette ; [0x8B]_palette
empty_palette ; [0x8C]_palette
empty_palette ; [0x8D]_palette
empty_palette ; [0x8E]_palette
empty_palette ; [0x8F]_palette
b_palettes:
dw 0x11C3, 0, 0xC6, 0x108, 0x16B, 0x1EF, 0x2B5, 0x75A, 0x3BFD, 0x7FFF, 0x2108, 0x14A5, 0x2D8C, 0x24B2, 0x4EEB, 0x2E09 ; [0]_palette
palette sprites, splash_palette  ; 0x1 SPLASH_PALETTE
palette sprites, metal_kuwagen_palette  ; 0x2 METAL_KUWAGEN_PALETTE
palette sprites, kuwagen_palette  ; 0x3 KUWAGEN_PALETTE
palette sprites, red_bomb_palette  ; 0x4 RED_BOMB_PALETTE
palette sprites, senshiyan_palette  ; 0x5 SENSHIYAN_PALETTE
palette sprites, bomberman_palette_0  ; 0x6 SHIRO_PALETTE
palette sprites, kuro_bomberman_palette  ; 0x7 KURO_PALETTE
palette sprites, aka_bomberman_palette  ; 0x8 AKA_PALETTE
palette sprites, ao_bomberman_palette  ; 0x9 AO_PALETTE
palette sprites, cuppen_palette  ; 0xa CUPPEN_PALETTE
palette sprites, purple_bomberman_palette  ; 0xb PURPLE_BOMBERMAN_PALETTE (Unused)
palette sprites, banen_palette  ; 0xc BANEN_PALETTE
palette sprites, clown_mask_palette_2  ; 0xd CLOWN_MASK_PALETTE_0
dw 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF ; WHITE_PALETTE
dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; BLACK_PALETTE
palette sprites, clown_mask_palette_1  ; 0x10 CLOWN_MASK_PALETTE_1
palette sprites, clown_mask_palette_0  ; 0x11 CLOWN_MASK_PALETTE_2
palette sprites, clown_mask_fire_palette  ; 0x12 GENERIC_BOSS_FIRE_PALETTE
palette sprites, mook_palette  ; 0x13 MOOK_PALETTE
palette sprites, crane_palette  ; 0x14 CRANE_PALETTE
palette sprites, anzenda_palette  ; 0x15 ANZENDA_PALETTE
dw 0x2D6B, 0, 0x37F, 0x234, 0x7FFF, 0x1CE7, 0x318C, 0x5294, 0x16E, 0x7C00, 0x5000, 0x3000, 0x2C00, 0x1E, 0x14, 0x40E ; [0x16]_palette
palette sprites, moguchan_palette_j  ; 0x17 MOGUCHAN_PALETTE_J
dw 0x21C8, 0xDF, 0x7FFF, 0x35F, 0x7FFF, 0x1FF, 0x1C, 0x18, 0x14, 0x1D, 0x2400, 0x3F, 0x19, 0x19FF, 0xF, 0x4C ; [0x18]_palette
palette sprites, propen_palette  ; 0x19 PROPENE_PALETTE
palette sprites, moving_platform_palette  ; 0x1a MOVING_PLATFORM_PALETTE
palette sprites, yoroisu_palette  ; 0x1b YOROISO_PALETTE
dw 0x3064, 0x6422, 0x1084, 0, 0x14A5, 0x18C6, 0x1F, 0x20E7, 0x2508, 0xC63, 0x842, 0x421, 0xC63, 6, 0x7C1F, 0x7C1F ; [0x1C]_palette
dw 0x4105, 0, 0x318C, 0x294A, 0x7FFF, 0x6739, 0x11F, 0x2108, 0x18C6, 0x47, 0x4631, 0xAD, 0x24, 0x14E, 0x1084, 0x7C1F ; [0x1D]_palette
dw 0x4105, 0x54, 0x19F, 0x1D, 0x3DF, 0x7FFF, 0x3DF, 0x11, 0xA, 0x47, 0x25F, 0xAD, 0x24, 0x14E, 7, 0x7C1F ; [0x1E]_palette
palette sprites, bigaron_palette_0  ; 0x1f BIGARON_PALETTE_1
palette sprites, bigaron_palette_1  ; 0x20 BIGARON_PALETTE_2
palette sprites, bigaron_fire_palette  ; 0x21 BIGARON_FIRE_PALETTE
dw 0x294A, 0x7FFF, 0x4A52, 0x4826, 0x51, 0xC9, 0x10E, 7, 0x61E0, 0x1FA, 0x1DF, 0x1991, 0x6CCF, 0x3257, 0x52FF, 0x3EBB ; [0x22]_palette
palette sprites, missle_palette  ; 0x23 MISSLE_PALETTE
palette sprites, mecha_onita_palette  ; 0x24 MECHA_ONITA_PALETTE
palette sprites, mecha_onita_shock_palette  ; 0x25 MECHA_ONITA_SHOCK_PALETTE
palette sprites, spiderer_palette_0  ; 0x26 SPIDERER_PALETTE_0
palette sprites, spiderer_palette_1  ; 0x27 SPIDERER_PALETTE_1
palette sprites, spiderer_fire_palette  ; 0x28 SPIDERER_FIRE_PALETTE
palette sprites, bomb_palette  ; 0x29 BOMB_PALETTE
palette sprites, kouraru_palette  ; 0x2a KOURARU_PALETTE
dw 0x180, 0x1DB, 0x3FF, 0x18C, 0x7FFF, 0x29F, 0x7BF, 0x177, 0x531, 0x10D, 0x4E73, 0x39CE, 0x294A, 0x6318, 0, 0x1F ; 0x2b UNKNOWN_FADING_PALETTE_0
dw 0x180, 0x115, 0x339, 0xC6, 0x6739, 0x1D9, 0x2F9, 0xB1, 0x6B, 0x47, 0x35AD, 0x2108, 0x1084, 0x4A52, 0, 0x19 ; 0x2c UNKNOWN_FADING_PALETTE_1
dw 0x180, 0x4F, 0x273, 0, 0x4E73, 0x113, 0x233, 0xB, 5, 1, 0x1CE7, 0x842, 0, 0x318C, 0, 0x13 ; 0x2d UNKNOWN_FADING_PALETTE_2
palette sprites, pakupa_palette  ; 0x2e PAKUPA_PALETTE
palette sprites, douken_palette  ; 0x2f DOUKEN_PALETTE
if FIXED_MECHA_BOMBER_PALETTES
palette sprites, white_mecha_bomberman_palette  ; 0x30 MECHA_BOMBER_WHITE_PALETTE
palette sprites, black_mecha_bomberman_palette  ; 0x31 MECHA_BOMBER_BLACK_PALETTE
palette sprites, red_mecha_bomberman_palette  ; 0x32 MECHA_BOMBER_RED_PALETTE
palette sprites, blue_mecha_bomberman_palette  ; 0x33 MECHA_BOMBER_BLUE_PALETTE
palette sprites, gold_mecha_bomberman_palette  ; 0x34 MECHA_BOMBER_GOLD_PALETTE
palette sprites, green_mecha_bomberman_palette  ; 0x35 MECHA_BOMBER_GREEN_PALETTE
palette sprites, magenta_mecha_bomberman_palette  ; 0x36 MECHA_BOMBER_MAGENTA_PALETTE
palette sprites, purple_mecha_bomberman_palette  ; 0x37 MECHA_BOMBER_PURPLE_PALETTE
else
palette sprites, white_mecha_bomberman_palette_j  ; 0x30 MECHA_BOMBER_WHITE_PALETTE
palette sprites, black_mecha_bomberman_palette_j  ; 0x31 MECHA_BOMBER_BLACK_PALETTE
palette sprites, red_mecha_bomberman_palette_j  ; 0x32 MECHA_BOMBER_RED_PALETTE
palette sprites, blue_mecha_bomberman_palette_j  ; 0x33 MECHA_BOMBER_BLUE_PALETTE
palette sprites, gold_mecha_bomberman_palette_j  ; 0x34 MECHA_BOMBER_GOLD_PALETTE
palette sprites, green_mecha_bomberman_palette_j  ; 0x35 MECHA_BOMBER_GREEN_PALETTE
palette sprites, magenta_mecha_bomberman_palette_j  ; 0x36 MECHA_BOMBER_MAGENTA_PALETTE
palette sprites, purple_mecha_bomberman_palette_j  ; 0x37 MECHA_BOMBER_PURPLE_PALETTE
endif
palette sprites, enemy_explosion_palette  ; 0x38 EXPLOSIONS_PALETTE
palette sprites, carat_diamond_palette  ; 0x39 CARAT_DIAMOND_PALETTE
palette sprites, dengurin_palette  ; 0x3a DENGURIN_PALETTE
palette sprites, robocom_palette  ; 0x3b ROBOCOM_PALETTE
palette sprites, chameloman_palette  ; 0x3c CHAMELEOMAN_PALETTE
palette sprites, old_gold_mecha_bomberman_palette  ; 0x3d OLD_MECHA_BOMBER_GOLD_PALETTE (Unused)
palette sprites, kierun_palette  ; 0x3e OLD_KIERUN_PALETTE
if NEW_MAIN_MENU_COLORS
palette sprites, menu_palette  ; 0x3f MAIN_MENU_PALETTE
else
palette sprites, menu_palette_j  ; 0x3f MAIN_MENU_PALETTE
endif
palette sprites, scoreboard_palette  ; 0x40 SCOREBOARD_PALETTE_0
palette sprites, battle_menu_palette_0  ; 0x41 BATTLE_SCREEN_ORANGE_PALETTE
palette sprites, battle_menu_palette_1  ; 0x42 BATTLE_SCREEN_BLUE_PALETTE
if WESTERN_MOGUCHAN_PALETTE
palette sprites, moguchan_palette  ; 0x43 MOGUCHAN_PALETTE
else
palette sprites, moguchan_palette_j  ; 0x43 MOGUCHAN_PALETTE
endif
palette sprites, bakuda_palette  ; 0x44 BAKUDA_PALETTE
palette sprites, kierun_palette  ; 0x45 KIERUN_PALETTE
palette sprites, green_bomb_palette  ; 0x46 GREEN_BOMB_PALETTE
palette sprites, diamond_tower_palette  ; 0x47 DIAMOND_TOWER_PALETTE
dw 0x3A57, 0x294A, 0x1CE7, 0, 0x14A5, 0x1084, 0xE0, 0x1E0, 0x39CE, 0x5294, 0x1F1, 0x31C, 7, 0x10, 0x11F, 0x7FFF ; [0x48]_palette
palette sprites, falling_bombermen_palette_0  ; 0x49 WHITE_FALLING_PALETTE
palette sprites, falling_bombermen_palette_2  ; 0x4a BLACK_FALLING_PALETTE
palette sprites, falling_bombermen_palette_1  ; 0x4b RED_FALLING_PALETTE
palette sprites, falling_bombermen_palette_3  ; 0x4c BLUE_FALLING_PALETTE
if NEW_VICTORY_PALETTES
palette sprites, shiro_victory_pose_palette_0  ; 0x4d WHITE_VICTORY_PALETTE_0
palette sprites, shiro_victory_pose_palette_2  ; 0x4e WHITE_VICTORY_PALETTE_1
palette sprites, shiro_victory_pose_palette_1  ; 0x4f VICTORY_TEXT_PALETTE
if FIXED_KURO_VICTORY_PALETTE
palette sprites, kuro_victory_pose_f_palette_0  ; 0x50 BLACK_VICTORY_PALETTE_0
palette sprites, kuro_victory_pose_f_palette_2  ; 0x51 BLACK_VICTORY_PALETTE_1
else
palette sprites, kuro_victory_pose_palette_0  ; 0x50 BLACK_VICTORY_PALETTE_0
palette sprites, kuro_victory_pose_palette_2  ; 0x51 BLACK_VICTORY_PALETTE_1
endif
palette sprites, aka_victory_pose_palette_0  ; 0x52 RED_VICTORY_PALETTE_0
palette sprites, aka_victory_pose_palette_2  ; 0x53 RED_VICTORY_PALETTE_1
palette sprites, ao_victory_pose_palette_0  ; 0x54 BLUE_VICTORY_PALETTE_0
palette sprites, ao_victory_pose_palette_2  ; 0x55 BLUE_VICTORY_PALETTE_1
else
palette sprites, shiro_victory_pose_palette_0_j  ; 0x4d WHITE_VICTORY_PALETTE_0
palette sprites, shiro_victory_pose_palette_2_j  ; 0x4e WHITE_VICTORY_PALETTE_1
palette sprites, shiro_victory_pose_palette_1_j  ; 0x4f VICTORY_TEXT_PALETTE
palette sprites, kuro_victory_pose_palette_0_j  ; 0x50 BLACK_VICTORY_PALETTE_0
palette sprites, kuro_victory_pose_palette_2_j  ; 0x51 BLACK_VICTORY_PALETTE_1
palette sprites, aka_victory_pose_palette_0_j  ; 0x52 RED_VICTORY_PALETTE_0
palette sprites, aka_victory_pose_palette_2_j  ; 0x53 RED_VICTORY_PALETTE_1
palette sprites, ao_victory_pose_palette_0_j  ; 0x54 BLUE_VICTORY_PALETTE_0
palette sprites, ao_victory_pose_palette_2_j  ; 0x55 BLUE_VICTORY_PALETTE_1
endif
palette sprites, battle_menu_palette_2  ; 0x56 BATTLE_SCREEN_RED_PALETTE
palette sprites, battle_menu_palette_3  ; 0x57 BATTLE_SCREEN_GREEN_PALETTE
dw 0, 0x19B, 0x7FFF, 0xF0, 0x27F, 0, 0x7EE3, 0x7DA0, 0x5800, 0x3FF, 0x2D8, 0x58E, 0xFF, 0x18, 0xE, 0x1A06 ; [0x58]_palette
dw 0, 0x33F, 0x3FF, 0x233, 0x7FFF, 0x27F, 0x3FF, 0x2BF, 0x21F, 0x1BF, 0x2FF, 0x19F, 0x7A, 0x3FF, 0xBF, 0x1F ; [0x59]_palette
palette sprites, intro_1_palette  ; 0x5a INTRO_1_palette
palette sprites, intro_2_palette  ; 0x5b INTRO_2_palette
palette sprites, intro_4_palette  ; 0x5c INTRO_4_palette
palette sprites, intro_3_palette  ; 0x5d INTRO_3_palette
dw 0x6165, 0x7FFF, 0, 0x318C, 0x2108, 0, 0x56B5, 0x4210, 0x7C00, 0x7F00, 0x7E8E, 0x174, 0x53FF, 0x7FEB, 0x7FF3, 0x3FF ; INVERT_SHIRO_PALETTE
dw 0x6285, 0x7FFF, 0x7FFF, 0x4631, 0x7FFF, 0, 0x7FFF, 0x7FFF, 0x7D60, 0x1F00, 0x7ECE, 0x6318, 0x6F7B, 0x33E6, 0x4F0D, 0x6739 ; INVERT_KURO_PALETTE
dw 0x2E8C, 0x5297, 0x4278, 0x8AD, 0x7D40, 0x1DB4, 0x356E, 0, 0x56FA, 0x631B, 0x77FF, 0x7D80, 0x7A23, 0x3E67, 0x6B5D, 0x7BE0 ; INVERT_BOMB_PALETTE
dw 0x4184, 0x7FEF, 0x7FED, 0x5C00, 0x7D20, 0x7F47, 0x7E80, 0, 0x7FD2, 0x7FD6, 0x7FDA, 0x7D00, 0x3E0, 0x3E0, 0x7F77, 0x7F20 ; INVERT_FIRE_BOMB_PALETTE
dw 0x6285, 0x7FFF, 0x7F20, 0x294A, 0x7FE8, 0, 0x7FF6, 0x7FF1, 0x7C00, 0x7D80, 0x7E4D, 0x7EC0, 0x7FF4, 0x7EA3, 0x772B, 0x7FE8 ; INVERT_AKA_PALETTE
dw 0x6A87, 0x7FFF, 0x3FF, 0x1CE7, 0x3FFF, 0, 0x67FF, 0x53FF, 0x7C00, 0x7F00, 0x7E8E, 0x174, 0x53FF, 0x7FEB, 0x7FF3, 0x3FF ; INVERT_AO_PALETTE
dw 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF ; INVERT_BLACK_PALETTE
dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; INVERT_WHITE_PALETTE
palette sprites, mecha_onita_fade_1_palette  ; 0x66 ONITA_FADE_PALETTE_1
palette sprites, mecha_onita_fade_2_palette  ; 0x67 ONITA_FADE_PALETTE_2
palette sprites, password_digits_palette  ; 0x68 PASSWORD_DIGITS_PALETTE
empty_palette ; [0x69]_palette
dw 0x1A0, 0x54B5, 0x7AEF, 0x1DF, 0xD8, 0x2E86, 0x29B, 0x33F, 0xBF, 0x4ADB, 0xE, 0x3235, 0x192B, 0, 0x7FFF, 0x540E ; POISON_PALETTE
palette sprites, hot_air_baloon_palette  ; 0x6b INTRO_BALOON_PALETTE
palette sprites, airship_palette  ; 0x6c INTRO_SHIP_PALETTE
palette sprites, old_starnuts_palette  ; 0x6d OLD_STARNUTS_PALETTE (Unused)
palette sprites, keibin_palette  ; 0x6e KEIBIN_PALETTE
palette sprites, starnuts_palette  ; 0x6f STARNUTS_PALETTE
palette sprites, metal_propene_palette  ; 0x70 METAL_PROPENE_PALETTE
palette sprites, kinkaru_palette  ; 0x71 KINKARU_PALETTE
palette sprites, metal_u_palette  ; 0x72 METAL_U_PALETTE
palette sprites, red_bakuda_palette  ; 0x73 RED_BAKUDA_PALETTE
palette sprites, arena_gate_palette  ; 0x74 ARENA_GATE_PALETTE
palette sprites, denkyun_palette  ; 0x75 DENKYUN_PALETTE
palette sprites, scoreboard_2_palette  ; 0x76 SCOREBOARD_PALETTE_1
palette sprites, scoreboard_3_palette  ; 0x77 SCOREBOARD_PALETTE_2
palette sprites, scoreboard_4_palette  ; 0x78 SCOREBOARD_PALETTE_3
palette sprites, battle_menu_palette_4  ; 0x79 SCOREBOARD_ICONS_PALETTE
palette sprites, draw_palette  ; 0x7a DRAW_SPRITE_PALETTE
empty_palette ; FIRST_UNUSED_A_PALETTE
empty_palette ; [0x7C]_palette
empty_palette ; [0x7D]_palette
empty_palette ; [0x7E]_palette
empty_palette ; [0x7F]_palette
empty_palette ; [0x80]_palette
empty_palette ; [0x81]_palette
empty_palette ; [0x82]_palette
empty_palette ; [0x83]_palette
empty_palette ; [0x84]_palette
empty_palette ; [0x85]_palette
empty_palette ; [0x86]_palette
empty_palette ; [0x87]_palette
empty_palette ; [0x88]_palette
empty_palette ; [0x89]_palette
empty_palette ; [0x8A]_palette
empty_palette ; [0x8B]_palette
empty_palette ; [0x8C]_palette
empty_palette ; [0x8D]_palette
empty_palette ; [0x8E]_palette
empty_palette ; [0x8F]_palette
data_end