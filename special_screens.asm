macro create_title_text_object text_id
    df create_title_text_object
    dw ($text_id) * 8
endmacro

title_screen:
    dw 0x30E, 0, GAME_MODE_MENU
    
    df title_graphic
    df title_2_graphic
    df title_background_graphic
    df empty_tilemap
    df compressed_title_tilemap
    df compressed_title_tilemap_2
    
    load_palettes title_screen_palettes
    load_global_sprites title_graphics
    df title_screen_init
    df create_title_input_handler
    create_title_text_object 0
    create_title_text_object 1
    create_title_text_object 2
    create_title_text_object 3
if DISPLAY_LICENSED_BY
    create_title_text_object 4
endif
    init_functions_end

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


macro create_battle_menu_setting_handler setting
    df create_battle_menu_setting_handler
    db $setting
endmacro

macro create_battle_menu_static_object object, x, y, palette
    df create_battle_menu_static_object
    dw ($palette) * 2
    dw 0x30 ; unknown
    dw $x
    dw $y
    da $object
endmacro

battle_screen:
    dw 0x10E, 0, GAME_MODE_BATTLE_MENU
    
    df empty_tilemap
    df bonuses_graphic
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    
    load_palettes battle_screen_palettes
    load_global_sprites battle_menu_graphics
    df create_battle_menu_handler
    create_battle_menu_setting_handler BATTLE_MENU_SETTING_PLAYER_1
    create_battle_menu_setting_handler BATTLE_MENU_SETTING_PLAYER_2
    create_battle_menu_setting_handler BATTLE_MENU_SETTING_PLAYER_3
    create_battle_menu_setting_handler BATTLE_MENU_SETTING_PLAYER_4
    create_battle_menu_setting_handler BATTLE_MENU_SETTING_COM_LEVEL
    create_battle_menu_setting_handler BATTLE_MENU_SETTING_GAME_COUNT
    create_battle_menu_setting_handler BATTLE_MENU_SETTING_STAGE
    create_battle_menu_static_object battle_menu_leds, 0x88, 0x58, 0
    create_battle_menu_static_object battle_menu_leds, 0x88, 0x158, 0
    create_battle_menu_static_object battle_menu_page_1_static_text, 0x88, 0x58, 0
    create_battle_menu_static_object battle_menu_page_2_static_text, 0x88, 0x160, 0
    create_battle_menu_static_object battle_menu_page_1_flashing_arrow, 0x88, 0xB8, 0
    create_battle_menu_static_object battle_menu_page_2_flashing_arrow, 0x88, 0x108, 0
    init_functions_end

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
    dw 0, 0, GAME_MODE_MENU
    
    df draw_screen_gradient_graphic
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df compressed_introduction_tilemap
    load_palettes introduction_screen_palettes
    load_global_sprites intro_screen_fake_graphics
    df create_intro_scene_handler
    init_functions_end

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
    dw 0xf3e, 0, GAME_MODE_MENU
    
    df draw_screen_gradient_graphic
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df compressed_draw_and_victory_tilemap
    load_palettes draw_screen_palettes
    load_global_sprites draw_screen_graphics
if FALLING_BOMBERMEN_DRAW
    df draw_falling_bombermen
else
    df draw_falling_letters
endif
    init_functions_end

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
    dw 0xbe, 0, GAME_MODE_MENU

    df battle_win_graphic
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df empty_tilemap
    df compressed_draw_and_victory_tilemap
    
    load_palettes victory_screen_palettes
    load_global_sprites victory_screen_graphics
    tile_animation 2, victory_crowd_wave_animation_1
    tile_animation 4, victory_crowd_wave_animation_2
    tile_animation 6, victory_crowd_wave_animation_3
    tile_animation 8, victory_crowd_wave_animation_4
    tile_animation 0xA, victory_crowd_wave_animation_5
    tile_animation 0xC, victory_crowd_wave_animation_6
    tile_animation 0xE, victory_crowd_wave_animation_7
    tile_animation 0x20, victory_crowd_wave_animation_8
    df init_victory_screen
    init_functions_end

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
    load_palettes map_screen_palettes
    load_global_sprites map_graphics
    df create_map_screen_handler
    tile_animation 0x200, water_animation
    init_functions_end

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
    load_palettes credits_screen_palettes
    load_global_sprites credits_graphics
    df credits_screen_init
    init_functions_end

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
    level 0, GAME_MODE_BATTLE, LEVEL_FLAGS_DEMO | LEVEL_FLAGS_LIGHT_ZONE, 0, 0x200,
          dome_graphic, bomb_and_explosions_graphic, dome_level_structure, ; graphics
          empty_tilemap, compressed_spotlight_tilemap, ; overlay
          0, 55 ; hard/soft blocks

    df create_spotlight
    df create_demo_handler
    load_palettes light_zone_palettes
    load_global_sprites western_zone_graphics
    tile_animation TILE_SOFTBLOCK, dome_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, dome_shaded_soft_animation
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP,
       SPEED_UP, SPEED_UP, SPEED_UP, KICK, KICK, PUNCH, PUNCH, POISON, POISON, POISON,
       POISON, POISON, POISON, POISON, POISON, 0
       
    battle_stage_ppu_regs OBJ_EN | BG2_EN, OBJ_EN | BG1_EN | BG3_EN | BG4_EN,
                          COLMAT_SUBSTRACT | COLMAT_BG2 | COLMAT_BG1 | COLMAT_USE_SUBSCREEN, 0,
                          128, 128

warp_zone_demo:
    level 0, GAME_MODE_BATTLE, LEVEL_FLAGS_DEMO | LEVEL_FLAGS_WARP_ZONE, 0, 0x200,
          warp_zone_graphic, bomb_and_explosions_graphic, warp_zone_level_structure, ; graphics
          empty_tilemap, empty_tilemap, ; overlay
          0, 50 ; hard/soft blocks

    df create_demo_handler
    load_palettes warp_zone_palettes
    load_global_sprites warp_zone_graphics
    tile_animation 0x26, warp_animation
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP,
       SPEED_UP, SPEED_UP, SPEED_UP, POISON, POISON, KICK, KICK, KICK, PUNCH, PUNCH,
       PUNCH, FULL_FIRE, FULL_FIRE, 0

    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | OBJ_EN, BG1_EN | BG2_EN | BG3_EN | OBJ_EN,
                          COLMAT_SUBSTRACT | COLMAT_BG2 | COLMAT_BG1, 8,
                          0, 0

jump_zone_demo:
    level 0, GAME_MODE_BATTLE, LEVEL_FLAGS_DEMO | LEVEL_FLAGS_JUMP_ZONE, 0, 0x200,
          castle_graphic, bomb_and_explosions_graphic, castle_level_structure, ; graphics
          trampoline_and_crane_graphic, empty_tilemap, ; overlay
          0, 55 ; hard/soft blocks

    df create_demo_handler
    load_palettes jump_zone_palettes
    load_global_sprites western_zone_graphics
    tile_animation TILE_SOFTBLOCK, castle_soft_animation
    tile_animation TILE_SOFTBLOCK_SHADED, castle_soft_animation
    init_functions_end

    dw 0

    dw BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP,
       SPEED_UP, POISON, POISON, KICK, KICK, KICK, PUNCH, PUNCH, PUNCH, 0

    battle_stage_ppu_regs BG1_EN | BG2_EN | BG3_EN | OBJ_EN, BG1_EN | BG2_EN | BG3_EN | OBJ_EN,
                          COLMAT_SUBSTRACT | COLMAT_BG2 | COLMAT_BG1, 8,
                          0, 0

continue_screen:
    dw 0, 0, GAME_MODE_MENU
    df continue_border_graphic
    df empty_tilemap
    df continue_background_graphic
    df empty_tilemap
    df compressed_continue_tilemap
    df compressed_pattern_tilemap
    load_palettes continue_screen_palettes
    load_global_sprites continue_graphics
    df create_continue_screen_handler
    create_overlay_scroller 0, 0, 1, 1
    init_functions_end

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
    dw 0, 0, GAME_MODE_MENU
    df continue_border_graphic
    df empty_tilemap
    df musical_note_graphic
    df empty_tilemap
    df compressed_continue_tilemap
    df compressed_pattern_tilemap
    load_palettes continue_screen_palettes
    load_global_sprites continue_graphics
    df create_sound_test_handler
    init_functions_end

password_screen:
    dw 0, 0, GAME_MODE_MENU
    df continue_border_graphic
    df empty_tilemap
    df continue_background_graphic
    df empty_tilemap
    df compressed_continue_tilemap
    df compressed_pattern_tilemap
    load_palettes continue_screen_palettes
    load_global_sprites continue_graphics
    df create_password_screen_handler
    create_overlay_scroller 0, 0, -1, -1
    init_functions_end

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