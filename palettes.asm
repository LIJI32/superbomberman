.macro EMPTY_PALETTE
.WORD $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F
.endmacro

.macro PALETTE type, name
.incbin .CONCAT("graphics/", .STRING(type), "/", .STRING(name), ".bin")
.endmacro

.macro PARTTIAL_PALETTE type, name, start, end
.incbin .CONCAT("graphics/", .STRING(type), "/", .STRING(name), ".bin"), (start) * 2, ((end) - (start)) * 2
.endmacro

.macro BOMB_PALETTE name
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_1, (*/2) & $F, 11
PARTTIAL_PALETTE backgrounds, name, 11, 14
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_1, 14, 16
.endmacro

.macro FIRE_PALETTE name
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_0, (*/2) & $F, 11
PARTTIAL_PALETTE backgrounds, name, 11, 14
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_0, 14, 16
.endmacro

a_palettes:
.INCBIN "graphics/bg3_tileset_palette.bin" ; 0x0 HUD_PALETTE
PALETTE backgrounds, peace_town_palette_1 ; 0x1 PEACE_TOWN_PALETTE_1
PALETTE backgrounds, peace_town_palette_0 ; 0x2 PEACE_TOWN_PALETTE_2
PALETTE backgrounds, peace_town_palette_3 ; 0x3 PEACE_TOWN_PALETTE_3
PALETTE backgrounds, bonuses_palette_1 ; 0x4 BONUS_PALETTE_1
PALETTE backgrounds, bonuses_palette_0 ; 0x5 BONUS_PALETTE_2
BOMB_PALETTE peace_town_palette_3 ; 0x6 PEACE_TOWN_BOMB_PALETTE
FIRE_PALETTE peace_town_palette_3 ; 0x7 PEACE_TOWN_FIRE_PALETTE
.WORD $400, 0, 0, $108, $16B, $1EF, $2B5, $75A, $3BFD, $7FFF, $2108, $14A5, $2D8C, $5F, $4EEB, $2E09 ; [8]_PALETTE
.WORD 0, $11C3, $4D43, 0, $D44, $1E66, $26E8, $3BCE, $1103, $69E7, $63F7, $3524, $730A, $2901, $7FFF, $7FD8 ; [9]_PALETTE
PALETTE backgrounds, village_palette_0  ; 0xa VILLAGE_PALETTE_1
PALETTE backgrounds, village_palette_2 ; 0xb VILLAGE_PALETTE_2
PALETTE backgrounds, village_palette_3  ; 0xc VILLAGE_PALETTE_3
BOMB_PALETTE village_palette_2 ; 0xd VILLAGE_BOMB_PALETTE
FIRE_PALETTE village_palette_2 ; 0xe VILLAGE_FIRE_PALETTE
.WORD 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; BACKGROUND_BLACK_PALETTE
PALETTE backgrounds, castle_palette_2  ; 0x10 CASTLE_PALETTE_1
PALETTE backgrounds, castle_palette_1  ; 0x11 CASTLE_PALETTE_2
PALETTE backgrounds, castle_palette_0  ; 0x12 CASTLE_PALETTE_3
BOMB_PALETTE castle_palette_2  ; 0x13 CASTLE_BOMB_PALETTE
FIRE_PALETTE castle_palette_2  ; 0x14 CASTLE_FIRE_PALETTE
PALETTE backgrounds, dome_palette_3  ; 0x15 DOME_PALETTE_1
PALETTE backgrounds, dome_palette_1  ; 0x16 DOME_PALETTE_2
PALETTE backgrounds, dome_palette_0  ; 0x17 DOME_PALETTE_3
BOMB_PALETTE dome_palette_0 ; 0x18 DOME_BOMB_PALETTE
FIRE_PALETTE dome_palette_0   ; 0x19 DOME_FIRE_PALETTE
PALETTE backgrounds, park_palette_3  ; 0x1a PARK_PALETTE_1
PALETTE backgrounds, park_palette_0  ; 0x1b PARK_PALETTE_2
PALETTE backgrounds, park_palette_1  ; 0x1c PARK_PALETTE_3
BOMB_PALETTE park_palette_0 ; 0x1d PARK_BOMB_PALETTE
FIRE_PALETTE park_palette_0 ; 0x1e PARK_FIRE_PALETTE
.WORD $C63, $E40, $1FF, 0, $5800, $C, $13, $FF, $7FFF, $1A, $7D20, $1B1, $16B9, $4400, $3C00, $7C00 ; [$1F]_PALETTE
.WORD $1084, $2860, $5800, $E40, $118, $CF, $AA, $25, $15C, $7D20, 0, $7FFF, $7C00, $3C00, $1B1, $16B9 ; [$20]_PALETTE
.WORD $157, $88, $17C, $AC, $95, $7BFE, $15B, $6B9E, $7D60, $7F60, $4000, $E40, $160, $2720, $1C, $7FFF ; [$21]_PALETTE
.WORD $6000, $2D68, $3D87, $7752, $2BF, $624B, $4A91, $7FFF, $2905, $1CE4, $800, $E40, $160, $2720, $14A2, $41F ; [$22]_PALETTE
.WORD $45CA, $10, $12, $23FF, $2DF, $B8, $17F, $7FFF, $2D, $29, $25, $E40, $160, $2720, $66, $1F ; [$23]_PALETTE
PALETTE backgrounds, circus_palette_2  ; 0x24 CIRCUS_PALETTE_1
PALETTE backgrounds, circus_palette_1  ; 0x25 CIRCUS_PALETTE_2
PALETTE backgrounds, circus_palette_0  ; 0x26 CIRCUS_PALETTE_3

.IF FIXED_OVERLAY_PALETTES
BOMB_PALETTE circus_palette_1 ; 0x27 CIRCUS_BOMB_PALETTE
FIRE_PALETTE circus_palette_1 ; 0x28 CIRCUS_FIRE_PALETTE
.ELSE
; 0x27 CIRCUS_BOMB_PALETTE
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_1, 0, 10
PARTTIAL_PALETTE backgrounds, circus_palette_1, 10, 13
.WORD $0088
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_1, 14, 16
; 0x28 CIRCUS_BOMB_PALETTE
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_0, 0, 10
PARTTIAL_PALETTE backgrounds, circus_palette_1, 10, 13
.WORD $0088
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_0, 14, 16
.ENDIF

PALETTE backgrounds, factory_palette_3  ; 0x29 FACTORY_PALETTE_1
PALETTE backgrounds, factory_palette_2  ; 0x2a FACTORY_PALETTE_2
PALETTE backgrounds, factory_palette_0  ; 0x2b FACTORY_PALETTE_3

.IF FIXED_OVERLAY_PALETTES
BOMB_PALETTE factory_palette_3 ; 0x2c FACTORY_BOMB_PALETTE
FIRE_PALETTE factory_palette_3 ;0x2d FACTORY_FIRE_PALETTE
.ELSE
; 0x2c FACTORY_BOMB_PALETTE
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_1, 0, 11
PARTTIAL_PALETTE backgrounds, factory_palette_3, 11, 13
.WORD $0015
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_1, 14, 16
; 0x2d FACTORY_FIRE_PALETTE
.WORD $7C1F
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_0, 1, 11
PARTTIAL_PALETTE backgrounds, factory_palette_3, 11, 13
.WORD $0015
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_0, 14, 16
.ENDIF

.WORD $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF ; 0x2e BACKGROUND_WHITE_PALETTE
PALETTE backgrounds, arena_palette_1  ; 0x2f ARENA_PALETTE_1
PALETTE backgrounds, arena_palette_0  ; 0x30 ARENA_PALETTE_2
PALETTE backgrounds, arena_palette_2  ; 0x31 ARENA_PALETTE_3

BOMB_PALETTE arena_palette_1 ; 0x32 ARENA_BOMB_PALETTE
.IF !FIXED_OVERLAY_PALETTES
.WORD $7C1F
.ENDIF
FIRE_PALETTE arena_palette_1 ; 0x33 ARENA_FIRE_PALETTE

.WORD $21C8, $DF, $7FFF, $35F, $7FFF, $1FF, $1C, $18, $14, $1D, $2400, $3F, $15, $1F, $1A, $4C ; [$34]_PALETTE
PALETTE backgrounds, trampoline_and_crane_palette_1 ; 0x35 CRANE_BG_PALETTE
PALETTE backgrounds, garden_palette_1  ; 0x36 GARDEN_PALETTE_1
PALETTE backgrounds, garden_palette_0  ; 0x37 GARDEN_PALETTE_2
PALETTE backgrounds, garden_palette_2  ; 0x38 GARDEN_PALETTE_3
BOMB_PALETTE garden_palette_1 ; 0x39 GARDEN_BOMB_PALETTE
FIRE_PALETTE garden_palette_1 ; 0x3a GARDEN_FIRE_PALETTE
PALETTE backgrounds, power_zone_palette_0  ; 0x3b POWER_ZONE_PALETTE_1
PALETTE backgrounds, power_zone_palette_1  ; 0x3c POWER_ZONE_PALETTE_2
BOMB_PALETTE power_zone_palette_0 ; 0x3d POWER_ZONE_BOMB_PALETTE
FIRE_PALETTE power_zone_palette_0 ; 0x3e POWER_ZONE_FIRE_PALETTE

; 0x3f CLOWN_MASK_SPOTLIGHT_PALETTE
.incbin "graphics/bg3_tileset_palette.bin", 0, 8 * 2
PARTTIAL_PALETTE backgrounds, spotlights_palette, 8, 16  

PALETTE backgrounds, diamond_tower_tileset_palette_0  ; 0x40 DIAMOND_TOWER_PALETTE_1
PALETTE backgrounds, diamond_tower_tileset_palette_1  ; 0x41 DIAMOND_TOWER_PALETTE_2
BOMB_PALETTE diamond_tower_tileset_palette_0  ; 0x42 DIAMOND_TOWER_BOMB_PALETTE
FIRE_PALETTE diamond_tower_tileset_palette_0  ; 0x43 DIAMOND_TOWER_FIRE_PALETTE
PALETTE backgrounds, speed_zone_palette_3  ; 0x44 SPEED_ZONE_PALETTE_1
PALETTE backgrounds, speed_zone_palette_0  ; 0x45 SPEED_ZONE_PALETTE_2
PALETTE backgrounds, speed_zone_palette_1  ; 0x46 SPEED_ZONE_PALETTE_3
BOMB_PALETTE speed_zone_palette_3 ; 0x47 SPEED_ZONE_BOMB_PALETTE
FIRE_PALETTE speed_zone_palette_3 ; 0x48 SPEED_ZONE_FIRE_PALETTE
PALETTE backgrounds, normal_zone_palette_0  ; 0x49 NORMAL_ZONE_PALETTE

.IF FIXED_OVERLAY_PALETTES
BOMB_PALETTE normal_zone_palette_0  ; 0x4a NORMAL_ZONE_BOMB_PALETTE
FIRE_PALETTE normal_zone_palette_0  ; 0x4b NORMAL_ZONE_FIRE_PALETTE
.ELSE
; 0x4a NORMAL_ZONE_BOMB_PALETTE
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_1, 0, 10
PARTTIAL_PALETTE backgrounds, normal_zone_palette_0, 10, 12
.WORD $7C1F
.WORD $7C1F
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_1, 14, 16
; 0x4b NORMAL_ZONE_FIRE_PALETTE
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_0, 0, 10
PARTTIAL_PALETTE backgrounds, normal_zone_palette_0, 10, 12
.WORD $7C1F
.WORD $7C1F
PARTTIAL_PALETTE overlays, bomb_and_explosions_palette_0, 14, 16
.ENDIF

PALETTE backgrounds, warp_zone_palette_0  ; 0x4c WARP_ZONE_PALETTE_1
PALETTE backgrounds, warp_zone_palette_2  ; 0x4d WARP_ZONE_PALETTE_2
PALETTE backgrounds, warp_zone_palette_3  ; 0x4e WARP_ZONE_PALETTE_3
BOMB_PALETTE warp_zone_palette_3 ; 0x4f WARP_ZONE_BOMB_PALETTE
FIRE_PALETTE warp_zone_palette_3 ; 0x50 WARP_ZONE_FIRE_PALETTE
PALETTE backgrounds, tunnel_zone_palette_0  ; 0x51 TUNNEL_ZONE_PALETTE_1
PALETTE backgrounds, tunnel_zone_palette_1  ; 0x52 TUNNEL_ZONE_PALETTE_2
PALETTE backgrounds, tunnel_zone_palette_2  ; 0x53 TUNNEL_ZONE_PALETTE_3
BOMB_PALETTE tunnel_zone_palette_0 ; 0x54 TUNNEL_ZONE_BOMB_PALETTE
FIRE_PALETTE tunnel_zone_palette_0 ; 0x55 TUNNEL_ZONE_FIRE_PALETTE
EMPTY_PALETTE ; [$56]_PALETTE
EMPTY_PALETTE ; [$57]_PALETTE
EMPTY_PALETTE ; [$58]_PALETTE
EMPTY_PALETTE ; [$59]_PALETTE
EMPTY_PALETTE ; [$5A]_PALETTE
PALETTE backgrounds, map_palette_0  ; 0x5b MAP_PALETTE_1
PALETTE backgrounds, map_palette_1  ; 0x5c MAP_PALETTE_2
PALETTE backgrounds, map_palette_2  ; 0x5d MAP_PALETTE_3
PALETTE backgrounds, draw_screen_gradient_palette ; 0x5e DRAW_BG_PALETTE
.WORD $400, $154A, $21EF, $3739, $7FFF, $3C00, $7AC0, $89, $4CA, $7800, $67, $7B30, $2800, $2CE3, $E7, $7DC0 ; [$5F]_PALETTE
PALETTE backgrounds, battle_win_palette_1  ; 0x60 VICTORY_YELLOW_BOMBERMAN_PALETTE
PALETTE backgrounds, battle_win_palette_2  ; 0x61 VICTORY_ORANGE_BOMBERMAN_PALETTE
PALETTE backgrounds, battle_win_palette_3  ; 0x62 VICTORY_BLUE_BOMBERMAN_PALETTE
PALETTE backgrounds, battle_win_palette_4  ; 0x63 VICTORY_GREEN_BOMBERMAN_PALETTE
PALETTE backgrounds, battle_win_palette_5  ; 0x64 VICTORY_MAGENTA_BOMBERMAN_PALETTE
PALETTE backgrounds, battle_win_palette_0  ; 0x65 VICTORY_GRASS_PALETTE
PALETTE backgrounds, battle_win_palette_6  ; 0x66 VICTORY_PURPLE_BOMBERMAN_PALETTE
PALETTE overlays, title_palette_0  ; 0x67 LOGO_PALETTE_1
PALETTE overlays, title_palette_1  ; 0x68 LOGO_PALETTE_2
PALETTE backgrounds, dome_battle_palette_3  ; 0x69 DOME_PALETTE_1_ALT
PALETTE backgrounds, dome_invert_palette_1  ; 0x6a DOME_PALETTE_2_INVERT
PALETTE backgrounds, dome_invert_palette_0  ; 0x6b DOME_PALETTE_3_INVERT
.WORD $6000, $5297, $4278, $8AD, $7D40, $1DB4, $356E, 0, $56FA, $631B, $77FF, $3A58, $42FE, $1B7, $6B5D, $7BE0 ; 0x6c DOME_BOMB_PALETTE_INVERT
PALETTE backgrounds, dome_invert_palette_2  ; 0x6d DOME_FIRE_PALETTE_INVERT
PALETTE backgrounds, bonuses_invert_palette_1  ; 0x6e BONUS_1_INVERT_PALETTE
PALETTE backgrounds, bonuses_invert_palette_0  ; 0x6f BONUS_2_INVERT_PALETTE
.WORD $4631, $52, $7FFF, $21E, 0, $4FFF, $52, $21E, 0, $1C, $5C00, $21E, 0, $52, $7FFF, $21E ; [$70]_PALETTE
PALETTE backgrounds, continue_background_palette  ; 0x71 CONTINUE_PALETTE_1
PALETTE backgrounds, title_background_palette  ; 0x72 CONTINUE_PALETTE_2
PALETTE backgrounds, spiderer_bg_palette_0  ; 0x73 SPIDERER_BG_PALETTE_1
PALETTE overlays, credit_image_2_palette_1  ; 0x74 CREDITS_END_PALETTE
PALETTE backgrounds, spiderer_bg_palette_1  ; 0x75 SPIDERER_BG_PALETTE_2
PALETTE backgrounds, spiderer_fire_bg_palette_0  ; 0x76 SPIDERER_FIRE_BG_PALETTE_1
.WORD $31E6, $C87, $4AD9, $318C, $D, $18C6, $6F7B, $214C, $11F, $AE, $1A, $1FF, $3DEF, $13E, $7FFF, $73A ; [$77]_PALETTE
PALETTE backgrounds, spiderer_fire_bg_palette_1  ; 0x78 SPIDERER_FIRE_BG_PALETTE_2
PALETTE backgrounds, spiderer_bg_palette_2 ; 0x79 SPIDERER_BG_PALETTE_3
.WORD $29CD, 0, 0, $3DEF, $2529, $18C6, $180, $80, $240, $320, $155, $1DE, $3DF, $120, $1C, $7FFF ; 0x7a GARDEN_PALETTE_3_COPY
EMPTY_PALETTE ; [$7B]_PALETTE
EMPTY_PALETTE ; [$7C]_PALETTE
PALETTE overlays, credit_image_1_palette_1  ; 0x7d CREDITS_SEPIA_PALETTE_1
.WORD 0, $2616, $1992, $D2E, $2EDD, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F ; [$7E]_PALETTE
PALETTE overlays, credit_image_2_palette_0  ; 0x7f CREDITS_SEPIA_PALETTE_2
PALETTE overlays, credit_image_1_palette_0  ; 0x80 CREDITS_SEPIA_PALETTE_3
.WORD 0, $19F5, $D91, $110D, $2258, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F ; [$81]_PALETTE
.WORD 0, $1A17, $D92, $110D, $267A, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F, $7C1F ; [$82]_PALETTE

; Some of the colors in the HUD palettes are not used in story mode.
; We take advtange of this to allow clouds and spotlights to appear
; in all levels
; DEP: graphics/backgrounds/spotlights_palette.bin
; 0x83 STORY_HUD_PALETTE
.incbin "graphics/bg3_tileset_palette.bin", 0, 8 * 2
.WORD 0, 0, 0, 0, 0, 0
PARTTIAL_PALETTE backgrounds, spotlights_palette, 14, 16

EMPTY_PALETTE ; [$84]_PALETTE
EMPTY_PALETTE ; [$85]_PALETTE
EMPTY_PALETTE ; [$86]_PALETTE
EMPTY_PALETTE ; [$87]_PALETTE
EMPTY_PALETTE ; [$88]_PALETTE
EMPTY_PALETTE ; [$89]_PALETTE
EMPTY_PALETTE ; [$8A]_PALETTE
EMPTY_PALETTE ; [$8B]_PALETTE
EMPTY_PALETTE ; [$8C]_PALETTE
EMPTY_PALETTE ; [$8D]_PALETTE
EMPTY_PALETTE ; [$8E]_PALETTE
EMPTY_PALETTE ; [$8F]_PALETTE
b_palettes:
.WORD $11C3, 0, $C6, $108, $16B, $1EF, $2B5, $75A, $3BFD, $7FFF, $2108, $14A5, $2D8C, $24B2, $4EEB, $2E09 ; [0]_PALETTE
PALETTE sprites, splash_palette  ; 0x1 SPLASH_PALETTE
PALETTE sprites, metal_kuwagen_palette  ; 0x2 METAL_KUWAGEN_PALETTE
PALETTE sprites, kuwagen_palette  ; 0x3 KUWAGEN_PALETTE
PALETTE sprites, red_bomb_palette  ; 0x4 RED_BOMB_PALETTE
PALETTE sprites, senshiyan_palette  ; 0x5 SENSHIYAN_PALETTE
PALETTE sprites, bomberman_palette_0  ; 0x6 SHIRO_PALETTE
PALETTE sprites, kuro_bomberman_palette  ; 0x7 KURO_PALETTE
PALETTE sprites, aka_bomberman_palette  ; 0x8 AKA_PALETTE
PALETTE sprites, ao_bomberman_palette  ; 0x9 AO_PALETTE
PALETTE sprites, cuppen_palette  ; 0xa CUPPEN_PALETTE
PALETTE sprites, purple_bomberman_palette  ; 0xb PURPLE_BOMBERMAN_PALETTE (Unused)
PALETTE sprites, banen_palette  ; 0xc BANEN_PALETTE
PALETTE sprites, clown_mask_palette_2  ; 0xd CLOWN_MASK_PALETTE_0
.WORD $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF ; WHITE_PALETTE
.WORD 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; BLACK_PALETTE
PALETTE sprites, clown_mask_palette_1  ; 0x10 CLOWN_MASK_PALETTE_1
PALETTE sprites, clown_mask_palette_0  ; 0x11 CLOWN_MASK_PALETTE_2
PALETTE sprites, clown_mask_fire_palette  ; 0x12 GENERIC_BOSS_FIRE_PALETTE
PALETTE sprites, mook_palette  ; 0x13 MOOK_PALETTE
PALETTE sprites, crane_palette  ; 0x14 CRANE_PALETTE
PALETTE sprites, anzenda_palette  ; 0x15 ANZENDA_PALETTE
.WORD $2D6B, 0, $37F, $234, $7FFF, $1CE7, $318C, $5294, $16E, $7C00, $5000, $3000, $2C00, $1E, $14, $40E ; [$16]_PALETTE
PALETTE sprites, moguchan_palette_j  ; 0x17 MOGUCHAN_PALETTE_J
.WORD $21C8, $DF, $7FFF, $35F, $7FFF, $1FF, $1C, $18, $14, $1D, $2400, $3F, $19, $19FF, $F, $4C ; [$18]_PALETTE
PALETTE sprites, propen_palette  ; 0x19 PROPENE_PALETTE
PALETTE sprites, moving_platform_palette  ; 0x1a MOVING_PLATFORM_PALETTE
PALETTE sprites, yoroisu_palette  ; 0x1b YOROISO_PALETTE
.WORD $3064, $6422, $1084, 0, $14A5, $18C6, $1F, $20E7, $2508, $C63, $842, $421, $C63, 6, $7C1F, $7C1F ; [$1C]_PALETTE
.WORD $4105, 0, $318C, $294A, $7FFF, $6739, $11F, $2108, $18C6, $47, $4631, $AD, $24, $14E, $1084, $7C1F ; [$1D]_PALETTE
.WORD $4105, $54, $19F, $1D, $3DF, $7FFF, $3DF, $11, $A, $47, $25F, $AD, $24, $14E, 7, $7C1F ; [$1E]_PALETTE
PALETTE sprites, bigaron_palette_0  ; 0x1f BIGARON_PALETTE_1
PALETTE sprites, bigaron_palette_1  ; 0x20 BIGARON_PALETTE_2
PALETTE sprites, bigaron_fire_palette  ; 0x21 BIGARON_FIRE_PALETTE
.WORD $294A, $7FFF, $4A52, $4826, $51, $C9, $10E, 7, $61E0, $1FA, $1DF, $1991, $6CCF, $3257, $52FF, $3EBB ; [$22]_PALETTE
PALETTE sprites, missle_palette  ; 0x23 MISSLE_PALETTE
PALETTE sprites, mecha_onita_palette  ; 0x24 MECHA_ONITA_PALETTE
PALETTE sprites, mecha_onita_shock_palette  ; 0x25 MECHA_ONITA_SHOCK_PALETTE
PALETTE sprites, spiderer_palette_0  ; 0x26 SPIDERER_PALETTE_0
PALETTE sprites, spiderer_palette_1  ; 0x27 SPIDERER_PALETTE_1
PALETTE sprites, spiderer_fire_palette  ; 0x28 SPIDERER_FIRE_PALETTE
PALETTE sprites, bomb_palette  ; 0x29 BOMB_PALETTE
PALETTE sprites, kouraru_palette  ; 0x2a KOURARU_PALETTE
.WORD $180, $1DB, $3FF, $18C, $7FFF, $29F, $7BF, $177, $531, $10D, $4E73, $39CE, $294A, $6318, 0, $1F ; 0x2b UNKNOWN_FADING_PALETTE_0
.WORD $180, $115, $339, $C6, $6739, $1D9, $2F9, $B1, $6B, $47, $35AD, $2108, $1084, $4A52, 0, $19 ; 0x2c UNKNOWN_FADING_PALETTE_1
.WORD $180, $4F, $273, 0, $4E73, $113, $233, $B, 5, 1, $1CE7, $842, 0, $318C, 0, $13 ; 0x2d UNKNOWN_FADING_PALETTE_2
PALETTE sprites, pakupa_palette  ; 0x2e PAKUPA_PALETTE
PALETTE sprites, douken_palette  ; 0x2f DOUKEN_PALETTE
.IF FIXED_MECHA_BOMBER_PALETTES
PALETTE sprites, white_mecha_bomberman_palette  ; 0x30 MECHA_BOMBER_WHITE_PALETTE
PALETTE sprites, black_mecha_bomberman_palette  ; 0x31 MECHA_BOMBER_BLACK_PALETTE
PALETTE sprites, red_mecha_bomberman_palette  ; 0x32 MECHA_BOMBER_RED_PALETTE
PALETTE sprites, blue_mecha_bomberman_palette  ; 0x33 MECHA_BOMBER_BLUE_PALETTE
PALETTE sprites, gold_mecha_bomberman_palette  ; 0x34 MECHA_BOMBER_GOLD_PALETTE
PALETTE sprites, green_mecha_bomberman_palette  ; 0x35 MECHA_BOMBER_GREEN_PALETTE
PALETTE sprites, magenta_mecha_bomberman_palette  ; 0x36 MECHA_BOMBER_MAGENTA_PALETTE
PALETTE sprites, purple_mecha_bomberman_palette  ; 0x37 MECHA_BOMBER_PURPLE_PALETTE
.ELSE
PALETTE sprites, white_mecha_bomberman_palette_j  ; 0x30 MECHA_BOMBER_WHITE_PALETTE
PALETTE sprites, black_mecha_bomberman_palette_j  ; 0x31 MECHA_BOMBER_BLACK_PALETTE
PALETTE sprites, red_mecha_bomberman_palette_j  ; 0x32 MECHA_BOMBER_RED_PALETTE
PALETTE sprites, blue_mecha_bomberman_palette_j  ; 0x33 MECHA_BOMBER_BLUE_PALETTE
PALETTE sprites, gold_mecha_bomberman_palette_j  ; 0x34 MECHA_BOMBER_GOLD_PALETTE
PALETTE sprites, green_mecha_bomberman_palette_j  ; 0x35 MECHA_BOMBER_GREEN_PALETTE
PALETTE sprites, magenta_mecha_bomberman_palette_j  ; 0x36 MECHA_BOMBER_MAGENTA_PALETTE
PALETTE sprites, purple_mecha_bomberman_palette_j  ; 0x37 MECHA_BOMBER_PURPLE_PALETTE
.ENDIF
PALETTE sprites, enemy_explosion_palette  ; 0x38 EXPLOSIONS_PALETTE
PALETTE sprites, carat_diamond_palette  ; 0x39 CARAT_DIAMOND_PALETTE
PALETTE sprites, dengurin_palette  ; 0x3a DENGURIN_PALETTE
PALETTE sprites, robocom_palette  ; 0x3b ROBOCOM_PALETTE
PALETTE sprites, chameloman_palette  ; 0x3c CHAMELEOMAN_PALETTE
PALETTE sprites, old_gold_mecha_bomberman_palette  ; 0x3d OLD_MECHA_BOMBER_GOLD_PALETTE (Unused)
PALETTE sprites, kierun_palette  ; 0x3e OLD_KIERUN_PALETTE
.IF NEW_MAIN_MENU_COLORS
PALETTE sprites, menu_palette  ; 0x3f MAIN_MENU_PALETTE
.ELSE
PALETTE sprites, menu_palette_j  ; 0x3f MAIN_MENU_PALETTE
.ENDIF
PALETTE sprites, scoreboard_palette  ; 0x40 SCOREBOARD_PALETTE_0
PALETTE sprites, battle_menu_palette_0  ; 0x41 BATTLE_SCREEN_ORANGE_PALETTE
PALETTE sprites, battle_menu_palette_1  ; 0x42 BATTLE_SCREEN_BLUE_PALETTE
.IF WESTERN_MOGUCHAN_PALETTE
PALETTE sprites, moguchan_palette  ; 0x43 MOGUCHAN_PALETTE
.ELSE
PALETTE sprites, moguchan_palette_j  ; 0x43 MOGUCHAN_PALETTE
.ENDIF
PALETTE sprites, bakuda_palette  ; 0x44 BAKUDA_PALETTE
PALETTE sprites, kierun_palette  ; 0x45 KIERUN_PALETTE
PALETTE sprites, green_bomb_palette  ; 0x46 GREEN_BOMB_PALETTE
PALETTE sprites, diamond_tower_palette  ; 0x47 DIAMOND_TOWER_PALETTE
.WORD $3A57, $294A, $1CE7, 0, $14A5, $1084, $E0, $1E0, $39CE, $5294, $1F1, $31C, 7, $10, $11F, $7FFF ; [$48]_PALETTE
PALETTE sprites, falling_bombermen_palette_0  ; 0x49 WHITE_FALLING_PALETTE
PALETTE sprites, falling_bombermen_palette_2  ; 0x4a BLACK_FALLING_PALETTE
PALETTE sprites, falling_bombermen_palette_1  ; 0x4b RED_FALLING_PALETTE
PALETTE sprites, falling_bombermen_palette_3  ; 0x4c BLUE_FALLING_PALETTE
.IF NEW_VICTORY_PALETTES
PALETTE sprites, shiro_victory_pose_palette_0  ; 0x4d WHITE_VICTORY_PALETTE_0
PALETTE sprites, shiro_victory_pose_palette_2  ; 0x4e WHITE_VICTORY_PALETTE_1
PALETTE sprites, shiro_victory_pose_palette_1  ; 0x4f VICTORY_TEXT_PALETTE
.IF FIXED_KURO_VICTORY_PALETTE
PALETTE sprites, kuro_victory_pose_f_palette_0  ; 0x50 BLACK_VICTORY_PALETTE_0
PALETTE sprites, kuro_victory_pose_f_palette_2  ; 0x51 BLACK_VICTORY_PALETTE_1
.ELSE
PALETTE sprites, kuro_victory_pose_palette_0  ; 0x50 BLACK_VICTORY_PALETTE_0
PALETTE sprites, kuro_victory_pose_palette_2  ; 0x51 BLACK_VICTORY_PALETTE_1
.ENDIF
PALETTE sprites, aka_victory_pose_palette_0  ; 0x52 RED_VICTORY_PALETTE_0
PALETTE sprites, aka_victory_pose_palette_2  ; 0x53 RED_VICTORY_PALETTE_1
PALETTE sprites, ao_victory_pose_palette_0  ; 0x54 BLUE_VICTORY_PALETTE_0
PALETTE sprites, ao_victory_pose_palette_2  ; 0x55 BLUE_VICTORY_PALETTE_1
.ELSE
PALETTE sprites, shiro_victory_pose_palette_0_j  ; 0x4d WHITE_VICTORY_PALETTE_0
PALETTE sprites, shiro_victory_pose_palette_2_j  ; 0x4e WHITE_VICTORY_PALETTE_1
PALETTE sprites, shiro_victory_pose_palette_1_j  ; 0x4f VICTORY_TEXT_PALETTE
PALETTE sprites, kuro_victory_pose_palette_0_j  ; 0x50 BLACK_VICTORY_PALETTE_0
PALETTE sprites, kuro_victory_pose_palette_2_j  ; 0x51 BLACK_VICTORY_PALETTE_1
PALETTE sprites, aka_victory_pose_palette_0_j  ; 0x52 RED_VICTORY_PALETTE_0
PALETTE sprites, aka_victory_pose_palette_2_j  ; 0x53 RED_VICTORY_PALETTE_1
PALETTE sprites, ao_victory_pose_palette_0_j  ; 0x54 BLUE_VICTORY_PALETTE_0
PALETTE sprites, ao_victory_pose_palette_2_j  ; 0x55 BLUE_VICTORY_PALETTE_1
.ENDIF
PALETTE sprites, battle_menu_palette_2  ; 0x56 BATTLE_SCREEN_RED_PALETTE
PALETTE sprites, battle_menu_palette_3  ; 0x57 BATTLE_SCREEN_GREEN_PALETTE
.WORD 0, $19B, $7FFF, $F0, $27F, 0, $7EE3, $7DA0, $5800, $3FF, $2D8, $58E, $FF, $18, $E, $1A06 ; [$58]_PALETTE
.WORD 0, $33F, $3FF, $233, $7FFF, $27F, $3FF, $2BF, $21F, $1BF, $2FF, $19F, $7A, $3FF, $BF, $1F ; [$59]_PALETTE
PALETTE sprites, intro_1_palette  ; 0x5a INTRO_1_PALETTE
PALETTE sprites, intro_2_palette  ; 0x5b INTRO_2_PALETTE
PALETTE sprites, intro_4_palette  ; 0x5c INTRO_4_PALETTE
PALETTE sprites, intro_3_palette  ; 0x5d INTRO_3_PALETTE
.WORD $6165, $7FFF, 0, $318C, $2108, 0, $56B5, $4210, $7C00, $7F00, $7E8E, $174, $53FF, $7FEB, $7FF3, $3FF ; INVERT_SHIRO_PALETTE
.WORD $6285, $7FFF, $7FFF, $4631, $7FFF, 0, $7FFF, $7FFF, $7D60, $1F00, $7ECE, $6318, $6F7B, $33E6, $4F0D, $6739 ; INVERT_KURO_PALETTE
.WORD $2E8C, $5297, $4278, $8AD, $7D40, $1DB4, $356E, 0, $56FA, $631B, $77FF, $7D80, $7A23, $3E67, $6B5D, $7BE0 ; INVERT_BOMB_PALETTE
.WORD $4184, $7FEF, $7FED, $5C00, $7D20, $7F47, $7E80, 0, $7FD2, $7FD6, $7FDA, $7D00, $3E0, $3E0, $7F77, $7F20 ; INVERT_FIRE_BOMB_PALETTE
.WORD $6285, $7FFF, $7F20, $294A, $7FE8, 0, $7FF6, $7FF1, $7C00, $7D80, $7E4D, $7EC0, $7FF4, $7EA3, $772B, $7FE8 ; INVERT_AKA_PALETTE
.WORD $6A87, $7FFF, $3FF, $1CE7, $3FFF, 0, $67FF, $53FF, $7C00, $7F00, $7E8E, $174, $53FF, $7FEB, $7FF3, $3FF ; INVERT_AO_PALETTE
.WORD $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF ; INVERT_BLACK_PALETTE
.WORD 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; INVERT_WHITE_PALETTE
PALETTE sprites, mecha_onita_fade_1_palette  ; 0x66 ONITA_FADE_PALETTE_1
PALETTE sprites, mecha_onita_fade_2_palette  ; 0x67 ONITA_FADE_PALETTE_2
PALETTE sprites, password_digits_palette  ; 0x68 PASSWORD_DIGITS_PALETTE
EMPTY_PALETTE ; [$69]_PALETTE
.WORD $1A0, $54B5, $7AEF, $1DF, $D8, $2E86, $29B, $33F, $BF, $4ADB, $E, $3235, $192B, 0, $7FFF, $540E ; POISON_PALETTE
PALETTE sprites, hot_air_baloon_palette  ; 0x6b INTRO_BALOON_PALETTE
PALETTE sprites, airship_palette  ; 0x6c INTRO_SHIP_PALETTE
PALETTE sprites, old_starnuts_palette  ; 0x6d OLD_STARNUTS_PALETTE (Unused)
PALETTE sprites, keibin_palette  ; 0x6e KEIBIN_PALETTE
PALETTE sprites, starnuts_palette  ; 0x6f STARNUTS_PALETTE
PALETTE sprites, metal_propene_palette  ; 0x70 METAL_PROPENE_PALETTE
PALETTE sprites, kinkaru_palette  ; 0x71 KINKARU_PALETTE
PALETTE sprites, metal_u_palette  ; 0x72 METAL_U_PALETTE
PALETTE sprites, red_bakuda_palette  ; 0x73 RED_BAKUDA_PALETTE
PALETTE sprites, arena_gate_palette  ; 0x74 ARENA_GATE_PALETTE
PALETTE sprites, denkyun_palette  ; 0x75 DENKYUN_PALETTE
PALETTE sprites, scoreboard_2_palette  ; 0x76 SCOREBOARD_PALETTE_1
PALETTE sprites, scoreboard_3_palette  ; 0x77 SCOREBOARD_PALETTE_2
PALETTE sprites, scoreboard_4_palette  ; 0x78 SCOREBOARD_PALETTE_3
PALETTE sprites, battle_menu_palette_4  ; 0x79 SCOREBOARD_ICONS_PALETTE
PALETTE sprites, draw_palette  ; 0x7a DRAW_SPRITE_PALETTE
EMPTY_PALETTE ; FIRST_UNUSED_A_PALETTE
EMPTY_PALETTE ; [$7C]_PALETTE
EMPTY_PALETTE ; [$7D]_PALETTE
EMPTY_PALETTE ; [$7E]_PALETTE
EMPTY_PALETTE ; [$7F]_PALETTE
EMPTY_PALETTE ; [$80]_PALETTE
EMPTY_PALETTE ; [$81]_PALETTE
EMPTY_PALETTE ; [$82]_PALETTE
EMPTY_PALETTE ; [$83]_PALETTE
EMPTY_PALETTE ; [$84]_PALETTE
EMPTY_PALETTE ; [$85]_PALETTE
EMPTY_PALETTE ; [$86]_PALETTE
EMPTY_PALETTE ; [$87]_PALETTE
EMPTY_PALETTE ; [$88]_PALETTE
EMPTY_PALETTE ; [$89]_PALETTE
EMPTY_PALETTE ; [$8A]_PALETTE
EMPTY_PALETTE ; [$8B]_PALETTE
EMPTY_PALETTE ; [$8C]_PALETTE
EMPTY_PALETTE ; [$8D]_PALETTE
EMPTY_PALETTE ; [$8E]_PALETTE
EMPTY_PALETTE ; [$8F]_PALETTE
DATA_END