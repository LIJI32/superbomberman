title_screen: .BYTE $E
        .BYTE 3
        .BYTE 0
        .BYTE 0
        .BYTE 1
        .BYTE 0
        .FARADDR title_graphic
        .FARADDR title_2_graphic
        .FARADDR title_background_graphic
        .FARADDR empty_tilemap
        .FARADDR compressed_title_tilemap
        .FARADDR compressed_title_tilemap_2
        .FARADDR load_palettes
        .FARADDR title_screen_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR title_graphics
        .WORD $10
        .BYTE 0
        .FARADDR sub_C541F8
        .FARADDR sub_C54E4A
        .FARADDR sub_C54DCD
        .WORD 0
        .FARADDR sub_C54DCD
        .WORD 8
        .FARADDR sub_C54DCD
        .WORD $10
        .FARADDR sub_C54DCD
        .WORD $18
.IF DISPLAY_LICENSED_BY
        .FARADDR sub_C54DCD
        .WORD $20
.ENDIF
        .WORD $F0F0
title_graphics: .FARADDR menu_graphic_0
        .FARADDR menu_graphic_1
        .FARADDR menu_graphic_2
        .FARADDR menu_graphic_3
        .FARADDR menu_graphic_0
        .FARADDR hot_air_baloon_graphic
        .FARADDR airship_graphic_0
        .FARADDR airship_graphic_1
        .FARADDR airship_graphic_2
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
battle_screen: .BYTE $E
        .BYTE 1
        .BYTE 0
        .BYTE 0
        .BYTE 6
        .BYTE 0
        .FARADDR empty_tilemap
        .FARADDR bonuses_graphic
        .FARADDR empty_tilemap
        .FARADDR empty_tilemap
        .FARADDR empty_tilemap
        .FARADDR empty_tilemap
        .FARADDR load_palettes
        .FARADDR battle_screen_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR battle_menu_graphics
        .WORD $10
        .BYTE 0
        .FARADDR sub_C5549C
        .FARADDR sub_C55240
        .BYTE 0
        .FARADDR sub_C55240
        .BYTE 1
        .FARADDR sub_C55240
        .BYTE 2
        .FARADDR sub_C55240
        .BYTE 3
        .FARADDR sub_C55240
        .BYTE 4
        .FARADDR sub_C55240
        .BYTE 5
        .FARADDR sub_C55240
        .BYTE 6
        .FARADDR sub_C55794
        .WORD 0
        .WORD $30
        .WORD $88
        .WORD $58
        .ADDR byte_C514EA
        .FARADDR sub_C55794
        .WORD 0
        .WORD $30
        .WORD $88
        .WORD $158
        .ADDR byte_C514EA
        .FARADDR sub_C55794
        .WORD 0
        .WORD $30
        .WORD $88
        .WORD $58
        .ADDR byte_C514FB
        .FARADDR sub_C55794
        .WORD 0
        .WORD $30
        .WORD $88
        .WORD $160
        .ADDR byte_C51500
        .FARADDR sub_C55794
        .WORD 0
        .WORD $30
        .WORD $88
        .WORD $B8
        .ADDR byte_C514E1
        .FARADDR sub_C55794
        .WORD 0
        .WORD $30
        .WORD $88
        .WORD $108
        .ADDR byte_C5150F
        .WORD $F0F0
battle_menu_graphics:.FARADDR battle_menu_graphic_0
        .FARADDR battle_menu_graphic_1
        .FARADDR battle_menu_graphic_2
        .FARADDR battle_menu_graphic_3
        .FARADDR battle_menu_graphic_4
        .FARADDR battle_menu_graphic_5
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
introduction_screen:.BYTE 0
        .BYTE 0
        .BYTE 0
        .BYTE 0
        .BYTE 1
        .BYTE 0
        .FARADDR draw_screen_gradient_graphic
        .FARADDR empty_tilemap
        .FARADDR empty_tilemap
        .FARADDR empty_tilemap
        .FARADDR empty_tilemap
        .FARADDR compressed_introduction_tilemap
        .FARADDR load_palettes
        .FARADDR introduction_screen_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR intro_screen_fake_graphics
        .WORD $10
        .BYTE 0
        .FARADDR sub_C564DB
        .WORD $F0F0
intro_screen_fake_graphics:.FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
        .FARADDR intro_1_graphic_0
intro_screen_graphics:
        .ADDR intro_1_graphic_0, intro_1_graphic_1, intro_1_graphic_2, intro_1_graphic_3, intro_1_graphic_4, intro_1_graphic_5, intro_1_graphic_0, intro_1_graphic_0
        .ADDR intro_1_graphic_0, intro_1_graphic_1, intro_1_graphic_2, intro_1_graphic_3, intro_1_graphic_4, intro_1_graphic_5, intro_1_graphic_0, intro_1_graphic_0
        .ADDR intro_2_graphic_0, intro_2_graphic_1, intro_2_graphic_2, intro_2_graphic_3, intro_2_graphic_4, intro_2_graphic_5, intro_1_graphic_0, intro_1_graphic_0
        .ADDR intro_3_graphic_0, intro_3_graphic_1, intro_3_graphic_2, intro_3_graphic_3, intro_3_graphic_4, intro_3_graphic_5, intro_1_graphic_0, intro_1_graphic_0
        .ADDR intro_4_graphic_0, intro_4_graphic_1, intro_4_graphic_2, intro_4_graphic_3, intro_4_graphic_4, intro_4_graphic_5, intro_1_graphic_0, intro_1_graphic_0
draw_screen: .BYTE $3E
        .BYTE $F
        .BYTE 0
        .BYTE 0
        .BYTE 1
        .BYTE 0
        .FARADDR draw_screen_gradient_graphic
        .FARADDR empty_tilemap
        .FARADDR empty_tilemap
        .FARADDR empty_tilemap
        .FARADDR empty_tilemap
        .FARADDR compressed_draw_and_victory_tilemap
        .FARADDR load_palettes
        .FARADDR draw_screen_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR draw_screen_graphics
        .WORD $10
        .BYTE 0
.IF FALLING_BOMBERMEN_DRAW
        .FARADDR draw_falling_bombermen
.ELSE
        .FARADDR draw_falling_letters
.ENDIF
        .WORD $F0F0
draw_screen_graphics:
        .FARADDR falling_bombermen_graphic_0
        .FARADDR falling_bombermen_graphic_1
        .FARADDR falling_bombermen_graphic_2
        .FARADDR falling_bombermen_graphic_3
        .FARADDR falling_bombermen_graphic_4
        .FARADDR falling_bombermen_graphic_5
        .FARADDR falling_bombermen_graphic_6
        .FARADDR menu_graphic_0
.IF !FALLING_BOMBERMEN_DRAW
        .FARADDR draw_graphic_0
        .FARADDR draw_graphic_1
        .FARADDR draw_graphic_2
        .FARADDR draw_graphic_3
        .FARADDR draw_graphic_4
        .FARADDR draw_graphic_5
        .FARADDR draw_graphic_6
.ELSE
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
.ENDIF
        .FARADDR menu_graphic_0
victory_screen: .BYTE $BE
        .BYTE 0
        .BYTE 0
        .BYTE 0
        .BYTE 1
        .BYTE 0
        .FARADDR battle_win_graphic
        .FARADDR empty_tilemap
        .FARADDR empty_tilemap
        .FARADDR empty_tilemap
        .FARADDR empty_tilemap
        .FARADDR compressed_draw_and_victory_tilemap
        .FARADDR load_palettes
        .FARADDR victory_screen_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR victory_screen_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C52A1D
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52BB4
        .WORD 4
        .FARADDR tile_animation
        .FARADDR byte_C52D4B
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C52EE2
        .WORD 8
        .FARADDR tile_animation
        .FARADDR byte_C53079
        .WORD $A
        .FARADDR tile_animation
        .FARADDR byte_C53210
        .WORD $C
        .FARADDR tile_animation
        .FARADDR byte_C533A7
        .WORD $E
        .FARADDR tile_animation
        .FARADDR byte_C5353E
        .WORD $20
        .FARADDR sub_C55F0A
        .WORD $F0F0
victory_screen_graphics:.FARADDR victory_pose_graphic_0
        .FARADDR victory_pose_graphic_1
        .FARADDR victory_pose_graphic_2
        .FARADDR victory_pose_graphic_3
        .FARADDR victory_pose_graphic_4
        .FARADDR victory_pose_graphic_5
        .FARADDR victory_pose_graphic_6
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
map_screen: .BYTE 0
        .BYTE 0
        .BYTE 0
        .BYTE 0
        .BYTE 1
        .BYTE 0
        .FARADDR empty_tilemap
        .FARADDR empty_tilemap
        .FARADDR map_graphic
        .FARADDR empty_tilemap
        .FARADDR compressed_map_tilemap
        .FARADDR compressed_pattern_tilemap
        .FARADDR load_palettes
        .FARADDR map_screen_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR map_graphics
        .WORD $10
        .BYTE 0
        .FARADDR sub_C57602
        .FARADDR tile_animation
        .FARADDR byte_C5292E
        .WORD $200
        .WORD $F0F0
map_graphics: .FARADDR bomberman_graphic_0
        .FARADDR bomberman_graphic_1
        .FARADDR bomberman_graphic_2
        .FARADDR bomberman_graphic_3
        .FARADDR mook_graphic_0
        .FARADDR mook_graphic_1
        .FARADDR crane_graphic
        .FARADDR menu_graphic_0
        .FARADDR carat_diamond_graphic_0
        .FARADDR carat_diamond_graphic_1
        .FARADDR carat_diamond_graphic_2
        .FARADDR bomberman_extra_graphic_1
        .FARADDR diamond_tower_graphic_0
        .FARADDR diamond_tower_graphic_1
        .FARADDR diamond_tower_graphic_2
        .FARADDR diamond_tower_graphic_3
credits_screen: .BYTE $E
        .BYTE 1
        .BYTE 0
        .BYTE 0
        .BYTE 1
        .BYTE 0
        .FARADDR credit_image_1_graphic
        .FARADDR credit_image_2_graphic
        .FARADDR credit_image_3_graphic
        .FARADDR credit_image_4_graphic
        .FARADDR compressed_credits_tilemap
        .FARADDR compressed_credits_tilemap
        .FARADDR load_palettes
        .FARADDR credits_screen_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR credits_graphics
        .WORD $10
        .BYTE 0
        .FARADDR sub_C775CC
        .WORD $F0F0
credits_graphics:.FARADDR big_font_graphic_0
        .FARADDR big_font_graphic_1
        .FARADDR big_font_graphic_2
        .FARADDR big_font_graphic_3
        .FARADDR small_font_graphic_0
        .FARADDR small_font_graphic_1
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
light_zone_demo:.BYTE 0   ; saved_to_d1c
        .BYTE 0
        .BYTE 1   ; spawn_and_flags
        .BYTE 4   ; more_flags
        .WORD 3   ; screen_mode
        .WORD $200  ; saved_to_d3a
        .FARADDR dome_graphic; tileset_pointer  ; tileset_bank
        .FARADDR bomb_and_explosions_graphic; unknown_pointer2  ; unknown_bank2
        .FARADDR empty_tilemap
        .FARADDR dome_level_structure
        .FARADDR compressed_spotlight_tilemap; anonymous_2  ; field_16
        .WORD 0   ; level_representation
        .WORD 0   ; hard_blocks
        .WORD 55  ; soft_blocks
                    ; Off by one in story mode, for the level exit
        .FARADDR create_spotlight
        .FARADDR sub_C56E67
        .FARADDR load_palettes
        .FARADDR light_zone_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR western_zone_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C51FED
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C5200C
        .WORD 2
        .WORD $F0F0
        .WORD 0
        .WORD BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP
        .WORD SPEED_UP, SPEED_UP, SPEED_UP, KICK, KICK, $D, $D, POISON, POISON, POISON
        .WORD POISON, POISON, POISON, POISON, POISON, 0
        .BYTE $12, $1D, 2, $83, $E0, 0, $80, 0, $80, 0
warp_zone_demo: .BYTE 0   ; saved_to_d1c
        .BYTE 0
        .BYTE $21  ; spawn_and_flags
        .BYTE 0   ; more_flags
        .WORD 3   ; screen_mode
        .WORD $200  ; saved_to_d3a
        .FARADDR warp_zone_graphic; tileset_pointer  ; tileset_bank
        .FARADDR bomb_and_explosions_graphic; unknown_pointer2  ; unknown_bank2
        .FARADDR empty_tilemap
        .FARADDR warp_zone_level_structure
        .FARADDR empty_tilemap
        .WORD 0   ; level_representation
        .WORD 0   ; hard_blocks
        .WORD 50  ; soft_blocks
                    ; Off by one in story mode, for the level exit
        .FARADDR sub_C56E67
        .FARADDR load_palettes
        .FARADDR warp_zone_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR warp_zone_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C52915
        .WORD $26
        .WORD $F0F0
        .WORD 0
        .WORD BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP
        .WORD SPEED_UP, SPEED_UP, SPEED_UP, POISON, POISON, KICK, KICK, KICK, $D, $D
        .WORD $D, $A, $A, 0
        .BYTE $17, $17, 0, $83, $E8, 0, 0, 0, 0, 0
jump_zone_demo: .BYTE 0   ; saved_to_d1c
        .BYTE 0
        .BYTE $41  ; spawn_and_flags
        .BYTE 0   ; more_flags
        .WORD 3   ; screen_mode
        .WORD $200  ; saved_to_d3a
        .FARADDR castle_graphic; tileset_pointer  ; tileset_bank
        .FARADDR bomb_and_explosions_graphic; unknown_pointer2  ; unknown_bank2
        .FARADDR trampoline_and_crane_graphic  ; overlay_tileset_bank
        .FARADDR castle_level_structure
        .FARADDR empty_tilemap
        .WORD 0   ; level_representation
        .WORD 0   ; hard_blocks
        .WORD 55  ; soft_blocks
                    ; Off by one in story mode, for the level exit
        .FARADDR sub_C56E67
        .FARADDR load_palettes
        .FARADDR jump_zone_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR western_zone_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C51E3C
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C51E3C
        .WORD 2
        .WORD $F0F0
        .WORD 0
        .WORD BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP
        .WORD SPEED_UP, POISON, POISON, KICK, KICK, KICK, $D, $D, $D, 0
        .BYTE $17, $17, 0, $83, $E8, 0, 0, 0, 0, 0
continue_screen:.BYTE 0
        .BYTE 0
        .BYTE 0
        .BYTE 0
        .BYTE 1
        .BYTE 0
        .FARADDR continue_border_graphic
        .FARADDR empty_tilemap
        .FARADDR continue_background_graphic
        .FARADDR empty_tilemap
        .FARADDR compressed_continue_tilemap
        .FARADDR compressed_pattern_tilemap
        .FARADDR load_palettes
        .FARADDR continue_screen_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR continue_graphics
        .WORD $10
        .BYTE 0
        .FARADDR sub_C56EB6
        .FARADDR create_overlay_scroller
        .WORD 0
        .WORD 0
        .WORD 1
        .WORD 1
        .WORD $F0F0
continue_graphics:.FARADDR menu_graphic_0
        .FARADDR menu_graphic_1
        .FARADDR menu_graphic_2
        .FARADDR menu_graphic_3
        .FARADDR password_digits_graphic
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR big_font_graphic_0
        .FARADDR big_font_graphic_1
        .FARADDR big_font_graphic_2
        .FARADDR big_font_graphic_3
        .FARADDR small_font_graphic_0
        .FARADDR small_font_graphic_1
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
sound_test: .BYTE 0
        .BYTE 0
        .BYTE 0
        .BYTE 0
        .BYTE 1
        .BYTE 0
        .FARADDR continue_border_graphic
        .FARADDR empty_tilemap
        .FARADDR musical_note_graphic
        .FARADDR empty_tilemap
        .FARADDR compressed_continue_tilemap
        .FARADDR compressed_pattern_tilemap
        .FARADDR load_palettes
        .FARADDR continue_screen_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR continue_graphics
        .WORD $10
        .BYTE 0
        .FARADDR sub_C705E0
        .WORD $F0F0
password_screen:.BYTE 0
        .BYTE 0
        .BYTE 0
        .BYTE 0
        .BYTE 1
        .BYTE 0
        .FARADDR continue_border_graphic
        .FARADDR empty_tilemap
        .FARADDR continue_background_graphic
        .FARADDR empty_tilemap
        .FARADDR compressed_continue_tilemap
        .FARADDR compressed_pattern_tilemap
        .FARADDR load_palettes
        .FARADDR continue_screen_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR continue_graphics
        .WORD $10
        .BYTE 0
        .FARADDR sub_C57153
        .FARADDR create_overlay_scroller
        .WORD 0
        .WORD 0
        .WORD $FFFF
        .WORD $FFFF
        .WORD $F0F0

title_screen_palettes:
        .BYTE HUD_PALETTE, CONTINUE_PALETTE_2, CONTINUE_PALETTE_2, CONTINUE_PALETTE_2
        .BYTE LOGO_PALETTE_1, LOGO_PALETTE_2, PEACE_TOWN_BOMB_PALETTE, PEACE_TOWN_FIRE_PALETTE
        .BYTE INTRO_BALOON_PALETTE, INTRO_SHIP_PALETTE, 0, 0
        .BYTE BLACK_PALETTE, 0, 0, 0
continue_screen_palettes:
        .BYTE HUD_PALETTE, CONTINUE_PALETTE_1, CONTINUE_PALETTE_1, CONTINUE_PALETTE_1
        .BYTE CONTINUE_PALETTE_1, CONTINUE_PALETTE_1, CASTLE_PALETTE_2, CASTLE_PALETTE_2
        .BYTE 0, BATTLE_SCREEN_ORANGE_PALETTE, BATTLE_SCREEN_BLUE_PALETTE
        .BYTE MOGUCHAN_PALETTE, MAIN_MENU_PALETTE, PASSWORD_DIGITS_PALETTE
        .BYTE SHIRO_PALETTE, KURO_PALETTE
draw_screen_palettes:
        .BYTE HUD_PALETTE, DRAW_BG_PALETTE, HUD_PALETTE, HUD_PALETTE, HUD_PALETTE
        .BYTE HUD_PALETTE, HUD_PALETTE, HUD_PALETTE
        .BYTE WHITE_FALLING_PALETTE, BLACK_FALLING_PALETTE, RED_FALLING_PALETTE
        .BYTE BLUE_FALLING_PALETTE, DRAW_SPRITE_PALETTE, 0
        .BYTE 0, 0
battle_screen_palettes:
        .BYTE HUD_PALETTE, NORMAL_ZONE_PALETTE, 8, 9, BONUS_PALETTE_1, BONUS_PALETTE_2
        .BYTE PEACE_TOWN_BOMB_PALETTE, PEACE_TOWN_FIRE_PALETTE
        .BYTE SCOREBOARD_PALETTE_0, BATTLE_SCREEN_ORANGE_PALETTE
        .BYTE BATTLE_SCREEN_BLUE_PALETTE, BATTLE_SCREEN_RED_PALETTE
        .BYTE BATTLE_SCREEN_GREEN_PALETTE, SENSHIYAN_PALETTE, SHIRO_PALETTE
        .BYTE KURO_PALETTE
victory_screen_palettes:
        .BYTE HUD_PALETTE, VICTORY_YELLOW_BOMBERMAN_PALETTE, VICTORY_ORANGE_BOMBERMAN_PALETTE
        .BYTE VICTORY_BLUE_BOMBERMAN_PALETTE, VICTORY_GREEN_BOMBERMAN_PALETTE
        .BYTE VICTORY_MAGENTA_BOMBERMAN_PALETTE, VICTORY_GRASS_PALETTE
        .BYTE VICTORY_PURPLE_BOMBERMAN_PALETTE
        .BYTE SHIRO_PALETTE, KURO_PALETTE, VICTORY_TEXT_PALETTE
        .BYTE RED_BOMB_PALETTE, AKA_PALETTE, AO_PALETTE, BLACK_PALETTE
        .BYTE WHITE_PALETTE
introduction_screen_palettes:
        .BYTE HUD_PALETTE, VICTORY_BLUE_BOMBERMAN_PALETTE, VICTORY_ORANGE_BOMBERMAN_PALETTE, VICTORY_BLUE_BOMBERMAN_PALETTE
        .BYTE VICTORY_GREEN_BOMBERMAN_PALETTE, VICTORY_MAGENTA_BOMBERMAN_PALETTE, VICTORY_GRASS_PALETTE, VICTORY_PURPLE_BOMBERMAN_PALETTE
        .BYTE INTRO_1_PALETTE, INTRO_2_PALETTE, INTRO_4_PALETTE
        .BYTE INTRO_3_PALETTE, 0, 0, 0, 0
map_screen_palettes:
        .BYTE HUD_PALETTE, MAP_PALETTE_1, MAP_PALETTE_2, MAP_PALETTE_3
        .BYTE LOGO_PALETTE_1, LOGO_PALETTE_2, PEACE_TOWN_BOMB_PALETTE, PEACE_TOWN_FIRE_PALETTE
        .BYTE SHIRO_PALETTE, KURO_PALETTE, CARAT_DIAMOND_PALETTE
        .BYTE MOOK_PALETTE, DIAMOND_TOWER_PALETTE, MECHA_BOMBER_BLUE_PALETTE
        .BYTE MECHA_BOMBER_RED_PALETTE, MECHA_BOMBER_MAGENTA_PALETTE
credits_screen_palettes:
        .BYTE HUD_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE
        .BYTE BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE, BACKGROUND_BLACK_PALETTE
        .BYTE WHITE_PALETTE, WHITE_PALETTE, WHITE_PALETTE, WHITE_PALETTE
        .BYTE BLACK_PALETTE, WHITE_PALETTE, WHITE_PALETTE, WHITE_PALETTE