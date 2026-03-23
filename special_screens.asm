title_screen:
    db 0xE
    db 3
    db 0
    db 0
    db 1
    db 0
    df title_graphic
    df title_2_graphic
    df title_background_graphic
    df empty_tilemap
    df compressed_title_tilemap
    df compressed_title_tilemap_2
    df load_palettes
    df title_screen_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df title_graphics
    dw 0x10
    db 0
    df sub_C541F8
    df sub_C54E4A
    df sub_C54DCD
    dw 0
    df sub_C54DCD
    dw 8
    df sub_C54DCD
    dw 0x10
    df sub_C54DCD
    dw 0x18
if DISPLAY_LICENSED_BY
    df sub_C54DCD
    dw 0x20
endif
    dw 0xF0F0

title_graphics:
    df menu_graphic_0
    df menu_graphic_1
    df menu_graphic_2
    df menu_graphic_3
    df menu_graphic_0
    df hot_air_baloon_graphic
    df airship_graphic_0
    df airship_graphic_1
    df airship_graphic_2
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0

battle_screen:
    db 0xE
    db 1
    db 0
    db 0
    db 6
    db 0
    df empty_tilemap
    df bonuses_graphic
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df load_palettes
    df battle_screen_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df battle_menu_graphics
    dw 0x10
    db 0
    df sub_C5549C
    df sub_C55240
    db 0
    df sub_C55240
    db 1
    df sub_C55240
    db 2
    df sub_C55240
    db 3
    df sub_C55240
    db 4
    df sub_C55240
    db 5
    df sub_C55240
    db 6
    df sub_C55794
    dw 0
    dw 0x30
    dw 0x88
    dw 0x58
    da byte_C514EA
    df sub_C55794
    dw 0
    dw 0x30
    dw 0x88
    dw 0x158
    da byte_C514EA
    df sub_C55794
    dw 0
    dw 0x30
    dw 0x88
    dw 0x58
    da byte_C514FB
    df sub_C55794
    dw 0
    dw 0x30
    dw 0x88
    dw 0x160
    da byte_C51500
    df sub_C55794
    dw 0
    dw 0x30
    dw 0x88
    dw 0xB8
    da byte_C514E1
    df sub_C55794
    dw 0
    dw 0x30
    dw 0x88
    dw 0x108
    da byte_C5150F
    dw 0xF0F0

battle_menu_graphics:
    df battle_menu_graphic_0
    df battle_menu_graphic_1
    df battle_menu_graphic_2
    df battle_menu_graphic_3
    df battle_menu_graphic_4
    df battle_menu_graphic_5
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0

introduction_screen:
    db 0
    db 0
    db 0
    db 0
    db 1
    db 0
    df draw_screen_gradient_graphic
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df compressed_introduction_tilemap
    df load_palettes
    df introduction_screen_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df intro_screen_fake_graphics
    dw 0x10
    db 0
    df sub_C564DB
    dw 0xF0F0

intro_screen_fake_graphics:
    df intro_1_graphic_0
    df intro_1_graphic_0
    df intro_1_graphic_0
    df intro_1_graphic_0
    df intro_1_graphic_0
    df intro_1_graphic_0
    df intro_1_graphic_0
    df intro_1_graphic_0
    df intro_1_graphic_0
    df intro_1_graphic_0
    df intro_1_graphic_0
    df intro_1_graphic_0
    df intro_1_graphic_0
    df intro_1_graphic_0
    df intro_1_graphic_0
    df intro_1_graphic_0

intro_screen_graphics:
    da intro_1_graphic_0, intro_1_graphic_1, intro_1_graphic_2, intro_1_graphic_3, intro_1_graphic_4, intro_1_graphic_5, intro_1_graphic_0, intro_1_graphic_0
    da intro_1_graphic_0, intro_1_graphic_1, intro_1_graphic_2, intro_1_graphic_3, intro_1_graphic_4, intro_1_graphic_5, intro_1_graphic_0, intro_1_graphic_0
    da intro_2_graphic_0, intro_2_graphic_1, intro_2_graphic_2, intro_2_graphic_3, intro_2_graphic_4, intro_2_graphic_5, intro_1_graphic_0, intro_1_graphic_0
    da intro_3_graphic_0, intro_3_graphic_1, intro_3_graphic_2, intro_3_graphic_3, intro_3_graphic_4, intro_3_graphic_5, intro_1_graphic_0, intro_1_graphic_0
    da intro_4_graphic_0, intro_4_graphic_1, intro_4_graphic_2, intro_4_graphic_3, intro_4_graphic_4, intro_4_graphic_5, intro_1_graphic_0, intro_1_graphic_0

draw_screen:
    db 0x3E
    db 0xF
    db 0
    db 0
    db 1
    db 0
    df draw_screen_gradient_graphic
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df compressed_draw_and_victory_tilemap
    df load_palettes
    df draw_screen_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df draw_screen_graphics
    dw 0x10
    db 0
if FALLING_BOMBERMEN_DRAW
    df draw_falling_bombermen
else
    df draw_falling_letters
endif
    dw 0xF0F0

draw_screen_graphics:
    df falling_bombermen_graphic_0
    df falling_bombermen_graphic_1
    df falling_bombermen_graphic_2
    df falling_bombermen_graphic_3
    df falling_bombermen_graphic_4
    df falling_bombermen_graphic_5
    df falling_bombermen_graphic_6
    df menu_graphic_0
if !FALLING_BOMBERMEN_DRAW
    df draw_graphic_0
    df draw_graphic_1
    df draw_graphic_2
    df draw_graphic_3
    df draw_graphic_4
    df draw_graphic_5
    df draw_graphic_6
else
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
endif
    df menu_graphic_0

victory_screen:
    db 0xBE
    db 0
    db 0
    db 0
    db 1
    db 0
    df battle_win_graphic
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df compressed_draw_and_victory_tilemap
    df load_palettes
    df victory_screen_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df victory_screen_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52A1D
    dw 2
    df tile_animation
    df byte_C52BB4
    dw 4
    df tile_animation
    df byte_C52D4B
    dw 6
    df tile_animation
    df byte_C52EE2
    dw 8
    df tile_animation
    df byte_C53079
    dw 0xA
    df tile_animation
    df byte_C53210
    dw 0xC
    df tile_animation
    df byte_C533A7
    dw 0xE
    df tile_animation
    df byte_C5353E
    dw 0x20
    df sub_C55F0A
    dw 0xF0F0

victory_screen_graphics:
    df victory_pose_graphic_0
    df victory_pose_graphic_1
    df victory_pose_graphic_2
    df victory_pose_graphic_3
    df victory_pose_graphic_4
    df victory_pose_graphic_5
    df victory_pose_graphic_6
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0

map_screen:
    db 0
    db 0
    db 0
    db 0
    db 1
    db 0
    df empty_tilemap
    df empty_tilemap
    df map_graphic
    df empty_tilemap
    df compressed_map_tilemap
    df compressed_pattern_tilemap
    df load_palettes
    df map_screen_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df map_graphics
    dw 0x10
    db 0
    df sub_C57602
    df tile_animation
    df byte_C5292E
    dw 0x200
    dw 0xF0F0

map_graphics:
    df bomberman_graphic_0
    df bomberman_graphic_1
    df bomberman_graphic_2
    df bomberman_graphic_3
    df mook_graphic_0
    df mook_graphic_1
    df crane_graphic
    df menu_graphic_0
    df carat_diamond_graphic_0
    df carat_diamond_graphic_1
    df carat_diamond_graphic_2
    df bomberman_extra_graphic_1
    df diamond_tower_graphic_0
    df diamond_tower_graphic_1
    df diamond_tower_graphic_2
    df diamond_tower_graphic_3

credits_screen:
    db 0xE
    db 1
    db 0
    db 0
    db 1
    db 0
    df credit_image_1_graphic
    df credit_image_2_graphic
    df credit_image_3_graphic
    df credit_image_4_graphic
    df compressed_credits_tilemap
    df compressed_credits_tilemap
    df load_palettes
    df credits_screen_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df credits_graphics
    dw 0x10
    db 0
    df sub_C775CC
    dw 0xF0F0

credits_graphics:
    df big_font_graphic_0
    df big_font_graphic_1
    df big_font_graphic_2
    df big_font_graphic_3
    df small_font_graphic_0
    df small_font_graphic_1
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0

light_zone_demo:
    db 0   ; saved_to_d1c
    db 0
    db 1   ; spawn_and_flags
    db 4   ; more_flags
    dw 3   ; screen_mode
    dw 0x200  ; saved_to_d3a
    df dome_graphic; tileset_pointer  ; tileset_bank
    df bomb_and_explosions_graphic; unknown_pointer2  ; unknown_bank2
    df empty_tilemap
    df dome_level_structure
    df compressed_spotlight_tilemap; anonymous_2  ; field_16
    dw 0   ; level_representation
    dw 0   ; hard_blocks
    dw 55  ; soft_blocks, off by one in story mode, for the level exit
    df create_spotlight
    df sub_C56E67
    df load_palettes
    df light_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df western_zone_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C51FED
    dw 6
    df tile_animation
    df byte_C5200C
    dw 2
    dw 0xF0F0
    dw 0
    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP
    dw SPEED_UP, SPEED_UP, SPEED_UP, KICK, KICK, 0xD, 0xD, POISON, POISON, POISON
    dw POISON, POISON, POISON, POISON, POISON, 0
    db 0x12, 0x1D, 2, 0x83, 0xE0, 0, 0x80, 0, 0x80, 0

warp_zone_demo:
    db 0   ; saved_to_d1c
    db 0
    db 0x21  ; spawn_and_flags
    db 0   ; more_flags
    dw 3   ; screen_mode
    dw 0x200  ; saved_to_d3a
    df warp_zone_graphic; tileset_pointer  ; tileset_bank
    df bomb_and_explosions_graphic; unknown_pointer2  ; unknown_bank2
    df empty_tilemap
    df warp_zone_level_structure
    df empty_tilemap
    dw 0   ; level_representation
    dw 0   ; hard_blocks
    dw 50  ; soft_blocks, off by one in story mode, for the level exit
    df sub_C56E67
    df load_palettes
    df warp_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df warp_zone_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C52915
    dw 0x26
    dw 0xF0F0
    dw 0
    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP
    dw SPEED_UP, SPEED_UP, SPEED_UP, POISON, POISON, KICK, KICK, KICK, 0xD, 0xD
    dw 0xD, 0xA, 0xA, 0
    db 0x17, 0x17, 0, 0x83, 0xE8, 0, 0, 0, 0, 0

jump_zone_demo:
    db 0   ; saved_to_d1c
    db 0
    db 0x41  ; spawn_and_flags
    db 0   ; more_flags
    dw 3   ; screen_mode
    dw 0x200  ; saved_to_d3a
    df castle_graphic; tileset_pointer  ; tileset_bank
    df bomb_and_explosions_graphic; unknown_pointer2  ; unknown_bank2
    df trampoline_and_crane_graphic  ; overlay_tileset_bank
    df castle_level_structure
    df empty_tilemap
    dw 0   ; level_representation
    dw 0   ; hard_blocks
    dw 55  ; soft_blocks, off by one in story mode, for the level exit
    df sub_C56E67
    df load_palettes
    df jump_zone_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df western_zone_graphics
    dw 0x10
    db 0
    df tile_animation
    df byte_C51E3C
    dw 6
    df tile_animation
    df byte_C51E3C
    dw 2
    dw 0xF0F0
    dw 0
    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP
    dw SPEED_UP, POISON, POISON, KICK, KICK, KICK, 0xD, 0xD, 0xD, 0
    db 0x17, 0x17, 0, 0x83, 0xE8, 0, 0, 0, 0, 0

continue_screen:
    db 0
    db 0
    db 0
    db 0
    db 1
    db 0
    df continue_border_graphic
    df empty_tilemap
    df continue_background_graphic
    df empty_tilemap
    df compressed_continue_tilemap
    df compressed_pattern_tilemap
    df load_palettes
    df continue_screen_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df continue_graphics
    dw 0x10
    db 0
    df sub_C56EB6
    df create_overlay_scroller
    dw 0
    dw 0
    dw 1
    dw 1
    dw 0xF0F0

continue_graphics:
    df menu_graphic_0
    df menu_graphic_1
    df menu_graphic_2
    df menu_graphic_3
    df password_digits_graphic
    df menu_graphic_0
    df menu_graphic_0
    df menu_graphic_0
    df big_font_graphic_0
    df big_font_graphic_1
    df big_font_graphic_2
    df big_font_graphic_3
    df small_font_graphic_0
    df small_font_graphic_1
    df menu_graphic_0
    df menu_graphic_0

sound_test:
    db 0
    db 0
    db 0
    db 0
    db 1
    db 0
    df continue_border_graphic
    df empty_tilemap
    df musical_note_graphic
    df empty_tilemap
    df compressed_continue_tilemap
    df compressed_pattern_tilemap
    df load_palettes
    df continue_screen_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df continue_graphics
    dw 0x10
    db 0
    df sub_C705E0
    dw 0xF0F0

password_screen:
    db 0
    db 0
    db 0
    db 0
    db 1
    db 0
    df continue_border_graphic
    df empty_tilemap
    df continue_background_graphic
    df empty_tilemap
    df compressed_continue_tilemap
    df compressed_pattern_tilemap
    df load_palettes
    df continue_screen_palettes
    dw 0x10
    db 0
    df load_global_sprites
    df continue_graphics
    dw 0x10
    db 0
    df sub_C57153
    df create_overlay_scroller
    dw 0
    dw 0
    dw 0xFFFF
    dw 0xFFFF
    dw 0xF0F0

title_screen_palettes:
    db HUD_PALETTE, CONTINUE_PALETTE_2, CONTINUE_PALETTE_2, CONTINUE_PALETTE_2
    db LOGO_PALETTE_1, LOGO_PALETTE_2, PEACE_TOWN_BOMB_PALETTE, PEACE_TOWN_FIRE_PALETTE
    db INTRO_BALOON_PALETTE, INTRO_SHIP_PALETTE, 0, 0
    db BLACK_PALETTE, 0, 0, 0

continue_screen_palettes:
    db HUD_PALETTE, CONTINUE_PALETTE_1, CONTINUE_PALETTE_1, CONTINUE_PALETTE_1
    db CONTINUE_PALETTE_1, CONTINUE_PALETTE_1, CASTLE_PALETTE_2, CASTLE_PALETTE_2
    db 0, BATTLE_SCREEN_ORANGE_PALETTE, BATTLE_SCREEN_BLUE_PALETTE
    db MOGUCHAN_PALETTE, MAIN_MENU_PALETTE, PASSWORD_DIGITS_PALETTE
    db SHIRO_PALETTE, KURO_PALETTE

draw_screen_palettes:
    db HUD_PALETTE, DRAW_BG_PALETTE, HUD_PALETTE, HUD_PALETTE, HUD_PALETTE
    db HUD_PALETTE, HUD_PALETTE, HUD_PALETTE
    db WHITE_FALLING_PALETTE, BLACK_FALLING_PALETTE, RED_FALLING_PALETTE
    db BLUE_FALLING_PALETTE, DRAW_SPRITE_PALETTE, 0
    db 0, 0

battle_screen_palettes:
    db HUD_PALETTE, NORMAL_ZONE_PALETTE, 8, 9, BONUS_PALETTE_1, BONUS_PALETTE_2
    db PEACE_TOWN_BOMB_PALETTE, PEACE_TOWN_FIRE_PALETTE
    db SCOREBOARD_PALETTE_0, BATTLE_SCREEN_ORANGE_PALETTE
    db BATTLE_SCREEN_BLUE_PALETTE, BATTLE_SCREEN_RED_PALETTE
    db BATTLE_SCREEN_GREEN_PALETTE, SENSHIYAN_PALETTE, SHIRO_PALETTE
    db KURO_PALETTE

victory_screen_palettes:
    db HUD_PALETTE, VICTORY_YELLOW_BOMBERMAN_PALETTE, VICTORY_ORANGE_BOMBERMAN_PALETTE
    db VICTORY_BLUE_BOMBERMAN_PALETTE, VICTORY_GREEN_BOMBERMAN_PALETTE
    db VICTORY_MAGENTA_BOMBERMAN_PALETTE, VICTORY_GRASS_PALETTE
    db VICTORY_PURPLE_BOMBERMAN_PALETTE
    db SHIRO_PALETTE, KURO_PALETTE, VICTORY_TEXT_PALETTE
    db RED_BOMB_PALETTE, AKA_PALETTE, AO_PALETTE, BLACK_PALETTE
    db WHITE_PALETTE

introduction_screen_palettes:
    db HUD_PALETTE, VICTORY_BLUE_BOMBERMAN_PALETTE, VICTORY_ORANGE_BOMBERMAN_PALETTE, VICTORY_BLUE_BOMBERMAN_PALETTE
    db VICTORY_GREEN_BOMBERMAN_PALETTE, VICTORY_MAGENTA_BOMBERMAN_PALETTE, VICTORY_GRASS_PALETTE, VICTORY_PURPLE_BOMBERMAN_PALETTE
    db INTRO_1_PALETTE, INTRO_2_PALETTE, INTRO_4_PALETTE
    db INTRO_3_PALETTE, 0, 0, 0, 0

map_screen_palettes:
    db HUD_PALETTE, MAP_PALETTE_1, MAP_PALETTE_2, MAP_PALETTE_3
    db LOGO_PALETTE_1, LOGO_PALETTE_2, PEACE_TOWN_BOMB_PALETTE, PEACE_TOWN_FIRE_PALETTE
    db SHIRO_PALETTE, KURO_PALETTE, CARAT_DIAMOND_PALETTE
    db MOOK_PALETTE, DIAMOND_TOWER_PALETTE, MECHA_BOMBER_BLUE_PALETTE
    db MECHA_BOMBER_RED_PALETTE, MECHA_BOMBER_MAGENTA_PALETTE

credits_screen_palettes:
    db HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE
    db BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE
    db WHITE_PALETTE, WHITE_PALETTE, WHITE_PALETTE, WHITE_PALETTE
    db BLACK_PALETTE, WHITE_PALETTE, WHITE_PALETTE, WHITE_PALETTE