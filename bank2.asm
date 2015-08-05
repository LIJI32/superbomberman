.SEGMENT "BANK2"
.ORG $C20000

; Palletes
.INCLUDE "palettes.asm"

; More Graphics
ASSET2 graphics, sprites, menu_graphic_0
ASSET2 graphics, sprites, menu_graphic_1
ASSET2 graphics, sprites, menu_graphic_2
ASSET2 graphics, sprites, menu_graphic_3
ASSET2 graphics, sprites, password_digits_graphic
ASSET2 graphics, sprites, splash_graphic_0
ASSET2 graphics, sprites, splash_graphic_1
ASSET2 graphics, sprites, splash_graphic_2
ASSET2 graphics, sprites, splash_graphic_3
ASSET2 graphics, sprites, splash_graphic_4
ASSET2 graphics, sprites, splash_graphic_5
ASSET2 graphics, sprites, splash_graphic_6
ASSET2 graphics, sprites, splash_graphic_7
.IF USE_KATAKANA
ASSET2_J graphics, sprites, battle_menu_graphic_0
ASSET2_J graphics, sprites, battle_menu_graphic_1
ASSET2_J graphics, sprites, battle_menu_graphic_2
ASSET2_J graphics, sprites, battle_menu_graphic_3
ASSET2_J graphics, sprites, battle_menu_graphic_4
ASSET2_J graphics, sprites, battle_menu_graphic_5
ASSET2_J graphics, sprites, battle_menu_graphic_6
.ELSE
ASSET2 graphics, sprites, battle_menu_graphic_0
ASSET2 graphics, sprites, battle_menu_graphic_1
ASSET2 graphics, sprites, battle_menu_graphic_2
ASSET2 graphics, sprites, battle_menu_graphic_3
ASSET2 graphics, sprites, battle_menu_graphic_4
ASSET2 graphics, sprites, battle_menu_graphic_5
ASSET2 graphics, sprites, battle_menu_graphic_6
.ENDIF
ASSET2 graphics, sprites, scoreboard_graphic
ASSET2 graphics, sprites, big_explosion_graphic_0
ASSET2 graphics, sprites, big_explosion_graphic_1
ASSET2 graphics, sprites, big_explosion_graphic_2
ASSET2 graphics, sprites, score_banner_and_bomb_graphic
ASSET2 graphics, sprites, enemy_explosion_graphic
ASSET2 graphics, sprites, explosion_graphic
ASSET2 graphics, sprites, time_up_graphic_1
ASSET2 graphics, sprites, time_up_graphic_2
ASSET2 graphics, sprites, bomb_graphic
ASSET2 graphics, sprites, time_up_graphic_0
ASSET2 graphics, sprites, unknown_graphic
ASSET2 graphics, sprites, bomberman_graphic_0
ASSET2 graphics, sprites, bomberman_graphic_1
ASSET2 graphics, sprites, bomberman_graphic_2
ASSET2 graphics, sprites, bomberman_graphic_3
ASSET2 graphics, sprites, bomberman_extra_graphic_0
ASSET2 graphics, sprites, bomberman_extra_graphic_1
ASSET2 graphics, sprites, kuwagen_graphic_0
ASSET2 graphics, sprites, kuwagen_graphic_1
ASSET2 graphics, sprites, senshiyan_graphic_0
ASSET2 graphics, sprites, senshiyan_graphic_1
ASSET2 graphics, sprites, senshiyan_graphic_2
ASSET2 graphics, sprites, propen_graphic_0
ASSET2 graphics, sprites, propen_graphic_1
ASSET2 graphics, sprites, arena_gate_graphic
ASSET2 graphics, sprites, banen_graphic_0
ASSET2 graphics, sprites, banen_graphic_1
ASSET2 graphics, backgrounds, continue_border_graphic
continue_background_graphic_copy: ; For some reason, it exists twice
.INCBIN "graphics/backgrounds/continue_background_graphic.bin"
ASSET2 graphics, sprites, mook_graphic_0
ASSET2 graphics, sprites, mook_graphic_1
ASSET2 graphics, sprites, crane_graphic
ASSET2 graphics, sprites, yoroisu_graphic_0
ASSET2 graphics, sprites, yoroisu_graphic_1
ASSET2 graphics, sprites, yoroisu_graphic_2
ASSET2 graphics, sprites, yoroisu_graphic_3
ASSET2 graphics, sprites, yoroisu_graphic_4
ASSET2 graphics, sprites, yoroisu_graphic_5
ASSET2 graphics, sprites, chameloman_graphic
ASSET2 graphics, sprites, moving_platform_graphic
ASSET2 graphics, sprites, mecha_bomberman_graphic_0
ASSET2 graphics, sprites, mecha_bomberman_graphic_1
ASSET2 graphics, sprites, mecha_bomberman_graphic_2
ASSET2 graphics, sprites, mecha_bomberman_graphic_3
ASSET2 graphics, sprites, carat_diamond_graphic_0
ASSET2 graphics, sprites, carat_diamond_graphic_1
ASSET2 graphics, sprites, carat_diamond_graphic_2
ASSET2 graphics, sprites, missle_graphic_0
ASSET2 graphics, sprites, missle_graphic_1
ASSET2 graphics, sprites, kouraru_graphic
ASSET2 graphics, sprites, pakupa_graphic_0
ASSET2 graphics, sprites, pakupa_graphic_1
ASSET2 graphics, sprites, pakupa_graphic_2
ASSET2 graphics, sprites, douken_graphic
ASSET2 graphics, sprites, dengurin_graphic_0
ASSET2 graphics, sprites, dengurin_graphic_1
ASSET2 graphics, sprites, dengurin_graphic_2
ASSET2 graphics, sprites, robocom_graphic_0
ASSET2 graphics, sprites, robocom_graphic_1
ASSET2 graphics, sprites, robocom_graphic_2
.IF WESTERN_MOGUCHAN_GRAPHIC
ASSET2 graphics, sprites, moguchan_graphic_0
ASSET2 graphics, sprites, moguchan_graphic_1
ASSET2 graphics, sprites, moguchan_graphic_2
.ELSE
ASSET2_J graphics, sprites, moguchan_graphic_0
ASSET2_J graphics, sprites, moguchan_graphic_1
ASSET2_J graphics, sprites, moguchan_graphic_2
.ENDIF
ASSET2 graphics, sprites, kierun_graphic_0
ASSET2 graphics, sprites, kierun_graphic_1
ASSET2 graphics, backgrounds, clouds_graphic
ASSET2 graphics, sprites, denkyun_graphic
ASSET2 graphics, sprites, starnuts_graphic_0
ASSET2 graphics, sprites, starnuts_graphic_1
ASSET2 graphics, sprites, starnuts_graphic_2
DATA_END