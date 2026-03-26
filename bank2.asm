segment "BANK2"

; Palletes
include "palettes.asm"

; More Graphics
asset graphics/sprites, menu_graphic_0
asset graphics/sprites, menu_graphic_1
asset graphics/sprites, menu_graphic_2
asset graphics/sprites, menu_graphic_3
asset graphics/sprites, password_digits_graphic
asset graphics/sprites, splash_graphic_0
asset graphics/sprites, splash_graphic_1
asset graphics/sprites, splash_graphic_2
asset graphics/sprites, splash_graphic_3
asset graphics/sprites, splash_graphic_4
asset graphics/sprites, splash_graphic_5
asset graphics/sprites, splash_graphic_6
asset graphics/sprites, splash_graphic_7
if USE_KATAKANA
asset_j graphics/sprites, battle_menu_graphic_0
asset_j graphics/sprites, battle_menu_graphic_1
asset_j graphics/sprites, battle_menu_graphic_2
asset_j graphics/sprites, battle_menu_graphic_3
asset_j graphics/sprites, battle_menu_graphic_4
asset_j graphics/sprites, battle_menu_graphic_5
asset_j graphics/sprites, battle_menu_graphic_6
else
asset graphics/sprites, battle_menu_graphic_0
asset graphics/sprites, battle_menu_graphic_1
asset graphics/sprites, battle_menu_graphic_2
asset graphics/sprites, battle_menu_graphic_3
asset graphics/sprites, battle_menu_graphic_4
asset graphics/sprites, battle_menu_graphic_5
asset graphics/sprites, battle_menu_graphic_6
endif
asset graphics/sprites, scoreboard_graphic
asset graphics/sprites, big_explosion_graphic_0
asset graphics/sprites, big_explosion_graphic_1
asset graphics/sprites, big_explosion_graphic_2
asset graphics/sprites, score_banner_and_bomb_graphic
asset graphics/sprites, enemy_explosion_graphic
asset graphics/sprites, explosion_graphic
asset graphics/sprites, time_up_graphic_1
asset graphics/sprites, time_up_graphic_2
asset graphics/sprites, bomb_graphic
asset graphics/sprites, time_up_graphic_0
asset graphics/sprites, unknown_graphic
asset graphics/sprites, bomberman_graphic_0
asset graphics/sprites, bomberman_graphic_1
asset graphics/sprites, bomberman_graphic_2
asset graphics/sprites, bomberman_graphic_3
asset graphics/sprites, bomberman_extra_graphic_0
asset graphics/sprites, bomberman_extra_graphic_1
asset graphics/sprites, kuwagen_graphic_0
asset graphics/sprites, kuwagen_graphic_1
asset graphics/sprites, senshiyan_graphic_0
asset graphics/sprites, senshiyan_graphic_1
asset graphics/sprites, senshiyan_graphic_2
asset graphics/sprites, propen_graphic_0
asset graphics/sprites, propen_graphic_1
asset graphics/sprites, arena_gate_graphic
asset graphics/sprites, banen_graphic_0
asset graphics/sprites, banen_graphic_1
asset graphics/backgrounds, continue_border_graphic
continue_background_graphic_copy: ; For some reason, it exists twice
incbin "$OUT/graphics/backgrounds/continue_background_graphic.bin"
asset graphics/sprites, mook_graphic_0
asset graphics/sprites, mook_graphic_1
asset graphics/sprites, crane_graphic
asset graphics/sprites, yoroisu_graphic_0
asset graphics/sprites, yoroisu_graphic_1
asset graphics/sprites, yoroisu_graphic_2
asset graphics/sprites, yoroisu_graphic_3
asset graphics/sprites, yoroisu_graphic_4
asset graphics/sprites, yoroisu_graphic_5
asset graphics/sprites, chameloman_graphic
asset graphics/sprites, moving_platform_graphic
asset graphics/sprites, mecha_bomberman_graphic_0
asset graphics/sprites, mecha_bomberman_graphic_1
asset graphics/sprites, mecha_bomberman_graphic_2
asset graphics/sprites, mecha_bomberman_graphic_3
asset graphics/sprites, carat_diamond_graphic_0
asset graphics/sprites, carat_diamond_graphic_1
asset graphics/sprites, carat_diamond_graphic_2
asset graphics/sprites, missle_graphic_0
asset graphics/sprites, missle_graphic_1
asset graphics/sprites, kouraru_graphic
asset graphics/sprites, pakupa_graphic_0
asset graphics/sprites, pakupa_graphic_1
asset graphics/sprites, pakupa_graphic_2
asset graphics/sprites, douken_graphic
asset graphics/sprites, dengurin_graphic_0
asset graphics/sprites, dengurin_graphic_1
asset graphics/sprites, dengurin_graphic_2
asset graphics/sprites, robocom_graphic_0
asset graphics/sprites, robocom_graphic_1
asset graphics/sprites, robocom_graphic_2
if WESTERN_MOGUCHAN_GRAPHIC
asset graphics/sprites, moguchan_graphic_0
asset graphics/sprites, moguchan_graphic_1
asset graphics/sprites, moguchan_graphic_2
else
asset_j graphics/sprites, moguchan_graphic_0
asset_j graphics/sprites, moguchan_graphic_1
asset_j graphics/sprites, moguchan_graphic_2
endif
asset graphics/sprites, kierun_graphic_0
asset graphics/sprites, kierun_graphic_1
asset graphics/backgrounds, clouds_graphic
asset graphics/sprites, denkyun_graphic
asset graphics/sprites, starnuts_graphic_0
asset graphics/sprites, starnuts_graphic_1
asset graphics/sprites, starnuts_graphic_2
data_end