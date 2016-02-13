normal_zone:	.BYTE 0			; saved_to_d1c
        .BYTE 0
        .BYTE 0			; spawn_and_flags
        .BYTE $80		; more_flags
        .WORD 3			; screen_mode
        .WORD $200		; saved_to_d3a
        .FARADDR normal_zone_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR normal_zone_level_structure
        .FARADDR empty_tilemap
        .WORD $14		; level_representation
        .WORD 0			; hard_blocks
        .WORD 80		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR locret_C463DD
        .FARADDR load_palettes
        .FARADDR normal_zone_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR western_zone_graphics
        .WORD $10
        .BYTE 0
        .WORD $F0F0
        .WORD 0
        .WORD BOMB_UP, BOMB_UP,	BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP
        .WORD FIRE_UP, FIRE_UP,	SPEED_UP, SPEED_UP, SPEED_UP, KICK, KICK, KICK,	PUNCH, PUNCH
        .WORD PUNCH, POISON, POISON, 0
        .BYTE $17, $17,	0, $83,	$E5, 0,	0, 0, 0, 0
western_zone_graphics:.FARADDR bomberman_graphic_0
        .FARADDR bomberman_graphic_1
        .FARADDR bomberman_graphic_2
        .FARADDR bomberman_graphic_3
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR unknown_graphic
        .FARADDR tractor_graphic
        .FARADDR battle_menu_graphic_5
        .FARADDR battle_menu_graphic_6
        .FARADDR scoreboard_graphic
        .FARADDR time_up_graphic_1
        .FARADDR time_up_graphic_2
        .FARADDR bomb_graphic
        .FARADDR time_up_graphic_0
western_zone:	.BYTE 1			; saved_to_d1c
        .BYTE 0
        .BYTE 8			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 3			; screen_mode
        .WORD $200		; saved_to_d3a
        .FARADDR village_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR village_level_structure
        .FARADDR empty_tilemap
        .WORD $15		; level_representation
        .WORD 0			; hard_blocks
        .WORD 65		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR locret_C463DD
        .FARADDR load_palettes
        .FARADDR western_zone_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR western_zone_graphics
        .WORD $10
        .BYTE 0
        .WORD $F0F0
        .WORD 0
        .WORD BOMB_UP, BOMB_UP,	BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP, SPEED_UP, KICK
        .WORD KICK, KICK, PUNCH, PUNCH, PUNCH, POISON, POISON, FULL_FIRE, FULL_FIRE, 0
        .BYTE $17, $17,	0, $83,	$E7, 0,	0, 0, 0, 0
bomb_zone:	.BYTE 0			; saved_to_d1c
        .BYTE 0
        .BYTE 0			; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 3			; screen_mode
        .WORD $200		; saved_to_d3a
        .FARADDR peace_town_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR peace_town_level_structure
        .FARADDR empty_tilemap
        .WORD $14		; level_representation
        .WORD 0			; hard_blocks
        .WORD 60		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR create_random_bomb_drop
        .FARADDR load_palettes
        .FARADDR bomb_zone_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR bomb_zone_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR peace_town_unshaded_soft_animation
        .WORD 6
        .FARADDR tile_animation
        .FARADDR peace_town_shaded_soft_animation
        .WORD 2
        .WORD $F0F0
        .WORD 0
        .WORD BOMB_UP, BOMB_UP,	BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP,	SPEED_UP
        .WORD SPEED_UP,	KICK, KICK, KICK, PUNCH, PUNCH, PUNCH, POISON, POISON, 0
        .BYTE $17, $17,	0, $83,	$E8, 0,	0, 0, 0, 0
bomb_zone_graphics:.FARADDR bomberman_graphic_0
        .FARADDR bomberman_graphic_1
        .FARADDR bomberman_graphic_2
        .FARADDR bomberman_graphic_3
        .FARADDR bakuda_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR unknown_graphic
        .FARADDR menu_graphic_0
        .FARADDR battle_menu_graphic_5
        .FARADDR battle_menu_graphic_6
        .FARADDR scoreboard_graphic
        .FARADDR time_up_graphic_1
        .FARADDR time_up_graphic_2
        .FARADDR bomb_graphic
        .FARADDR time_up_graphic_0
jump_zone:	.BYTE 0			; saved_to_d1c
        .BYTE 0
        .BYTE $40		; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 3			; screen_mode
        .WORD $200		; saved_to_d3a
        .FARADDR castle_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR trampoline_and_crane_graphic		; overlay_tileset_bank
        .FARADDR castle_level_structure
        .FARADDR empty_tilemap
        .WORD $14		; level_representation
        .WORD 0			; hard_blocks
        .WORD 55		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR locret_C463DD
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
        .WORD BOMB_UP, BOMB_UP,	BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP,	SPEED_UP
        .WORD SPEED_UP,	POISON,	POISON,	KICK, KICK, KICK, PUNCH, PUNCH, PUNCH, 0
        .BYTE $17, $17,	0, $83,	$E8, 0,	0, 0, 0, 0
belt_zone:	.BYTE 0			; saved_to_d1c
        .BYTE 0
        .BYTE 0			; spawn_and_flags
        .BYTE $10		; more_flags
        .WORD 3			; screen_mode
        .WORD $200		; saved_to_d3a
        .FARADDR factory_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR belt_zone_level_structure
        .FARADDR empty_tilemap
        .WORD $14		; level_representation
        .WORD 0			; hard_blocks
        .WORD 55		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR locret_C463DD
        .FARADDR load_palettes
        .FARADDR belt_zone_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR belt_zone_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C537C4+$4D
        .WORD $48
        .FARADDR tile_animation
        .FARADDR byte_C53862
        .WORD $4A
        .FARADDR tile_animation
        .FARADDR byte_C538B3
        .WORD $4C
        .FARADDR tile_animation
        .FARADDR byte_C53904
        .WORD $4E
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52504
        .WORD 6
        .WORD $F0F0
        .WORD 0
        .WORD BOMB_UP, BOMB_UP,	BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP
        .WORD SPEED_UP,	SPEED_UP, SPEED_UP, KICK, KICK,	KICK, PUNCH, PUNCH, PUNCH, 0
        .BYTE $17, $17,	0, $83,	$E8, 0,	0, 0, 0, 0
belt_zone_graphics:.FARADDR bomberman_graphic_0
        .FARADDR bomberman_graphic_1
        .FARADDR bomberman_graphic_2
        .FARADDR bomberman_graphic_3
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR menu_graphic_0
        .FARADDR unknown_graphic
        .FARADDR menu_graphic_0
        .FARADDR battle_menu_graphic_5
        .FARADDR battle_menu_graphic_6
        .FARADDR scoreboard_graphic
        .FARADDR time_up_graphic_1
        .FARADDR time_up_graphic_2
        .FARADDR bomb_graphic
        .FARADDR time_up_graphic_0
tunnel_zone:	.BYTE 0			; saved_to_d1c
        .BYTE 0
        .BYTE 0			; spawn_and_flags
        .BYTE 8			; more_flags
        .WORD 3			; screen_mode
        .WORD $200		; saved_to_d3a
        .FARADDR tunnel_zone_graphic		; tileset_bank
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR tunnel_zone_level_structure
        .FARADDR compressed_tunnel_zone_overlay_tilemap
        .WORD $14		; level_representation
        .WORD 0			; hard_blocks
        .WORD 50		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR locret_C463DD
        .FARADDR load_palettes
        .FARADDR tunnel_zone_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR western_zone_graphics
        .WORD $10
        .BYTE 0
        .WORD $F0F0
        .WORD 0
        .WORD BOMB_UP, BOMB_UP,	BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP
        .WORD FIRE_UP, FIRE_UP,	SPEED_UP, SPEED_UP, SPEED_UP, POISON, POISON, KICK, KICK, KICK
        .WORD 0
        .BYTE $1F, 0, 2, $A3, $E8, 0, 8, 0, $E7, 3
duel_zone:	.BYTE 0			; saved_to_d1c
        .BYTE 0
        .BYTE 0			; spawn_and_flags
        .BYTE 2			; more_flags
        .WORD 3			; screen_mode
        .WORD $200		; saved_to_d3a
        .FARADDR park_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR park_level_structure
        .FARADDR empty_tilemap
        .WORD $14		; level_representation
        .WORD 0			; hard_blocks
        .WORD 0			; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR locret_C463DD
        .FARADDR load_palettes
        .FARADDR duel_zone_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR western_zone_graphics
        .WORD $10
        .BYTE 0
        .WORD $F0F0
        .WORD 0
        .WORD 0
        .BYTE $17, $17,	0, $83,	$E8, 0,	0, 0, 0, 0
flower_zone:	.BYTE 0			; saved_to_d1c
        .BYTE 0
        .BYTE 0			; spawn_and_flags
        .BYTE $40		; more_flags
        .WORD 3			; screen_mode
        .WORD $200		; saved_to_d3a
        .FARADDR garden_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR clouds_graphic
        .FARADDR garden_level_structure
        .FARADDR compressed_stage_1_6_overlay_tilemap
        .WORD $14		; level_representation
        .WORD 0			; hard_blocks
        .WORD 50		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR create_flower_zone_handler
        .FARADDR load_palettes
        .FARADDR flower_zone_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR western_zone_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C52565
        .WORD 6
        .FARADDR tile_animation
        .FARADDR byte_C52688
        .WORD 2
        .FARADDR create_overlay_scroller
        .WORD 0
        .WORD 0
        .WORD $FFFF
        .WORD 0
        .WORD $F0F0
        .WORD 0
        .WORD BOMB_UP, BOMB_UP,	BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, SPEED_UP,	SPEED_UP
        .WORD SPEED_UP,	POISON,	POISON,	REMOTE_CONTROL, REMOTE_CONTROL, KICK, KICK, KICK,	PUNCH, PUNCH
        .WORD PUNCH, 0
        .BYTE $17, 0, 2, $83, $E4, 0, 0, 0, 0, 0
light_zone:	.BYTE 0			; saved_to_d1c
        .BYTE 0
        .BYTE 0			; spawn_and_flags
        .BYTE 4			; more_flags
        .WORD 3			; screen_mode
        .WORD $200		; saved_to_d3a
        .FARADDR dome_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR dome_level_structure
        .FARADDR compressed_spotlight_tilemap
        .WORD $14		; level_representation
        .WORD 0			; hard_blocks
        .WORD 55		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR create_spotlight
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
        .WORD BOMB_UP, BOMB_UP,	BOMB_UP, BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP
        .WORD SPEED_UP,	SPEED_UP, SPEED_UP, KICK, KICK,	PUNCH, PUNCH,	POISON,	POISON,	POISON
        .WORD POISON, POISON, POISON, POISON, POISON, 0
        .BYTE $12, $1D,	2, $83,	$E0, 0,	$80, 0,	$80, 0
power_zone:	.BYTE 0			; saved_to_d1c
        .BYTE 0
        .BYTE 0			; spawn_and_flags
        .BYTE 1			; more_flags
        .WORD 3			; screen_mode
        .WORD $200		; saved_to_d3a
        .FARADDR power_zone_graphic; tileset_pointer
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR power_zone_level_structure
        .FARADDR empty_tilemap
        .WORD $41		; level_representation
        .WORD 0			; hard_blocks
        .WORD 0			; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR locret_C463DD
        .FARADDR load_palettes
        .FARADDR power_zone_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR western_zone_graphics
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
        .WORD 0
        .WORD POISON, POISON, POISON, POISON, POISON, POISON, POISON, POISON, POISON, POISON
        .WORD 3, 0
        .BYTE $17, $17,	0, $83,	$E8, 0,	0, 0, 0, 0
warp_zone:	.BYTE 0			; saved_to_d1c
        .BYTE 0
        .BYTE $20		; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 3			; screen_mode
        .WORD $200		; saved_to_d3a
        .FARADDR warp_zone_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR warp_zone_level_structure
        .FARADDR empty_tilemap
        .WORD $14		; level_representation
        .WORD 0			; hard_blocks
        .WORD 50		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR locret_C463DD
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
        .WORD BOMB_UP, BOMB_UP,	BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP
        .WORD SPEED_UP,	SPEED_UP, SPEED_UP, POISON, POISON, KICK, KICK,	KICK, PUNCH, PUNCH
        .WORD PUNCH, FULL_FIRE, FULL_FIRE, 0
        .BYTE $17, $17,	0, $83,	$E8, 0,	0, 0, 0, 0
warp_zone_graphics:.FARADDR bomberman_graphic_0
        .FARADDR bomberman_graphic_1
        .FARADDR bomberman_graphic_2
        .FARADDR bomberman_graphic_3
warp_graphics:	.FARADDR bomberman_extra_graphic_0
        .FARADDR bomberman_extra_graphic_1
        .FARADDR menu_graphic_0
        .FARADDR unknown_graphic
        .FARADDR menu_graphic_0
        .FARADDR battle_menu_graphic_5
        .FARADDR battle_menu_graphic_6
        .FARADDR scoreboard_graphic
        .FARADDR time_up_graphic_1
        .FARADDR time_up_graphic_2
        .FARADDR bomb_graphic
        .FARADDR time_up_graphic_0
warp_mini_graphics:.FARADDR bomberman_mini_graphic_4
        .FARADDR bomberman_mini_warp_graphic
        .FARADDR menu_graphic_0
        .FARADDR unknown_graphic
speed_zone:	.BYTE 0			; saved_to_d1c
        .BYTE 0
        .BYTE $10		; spawn_and_flags
        .BYTE 0			; more_flags
        .WORD 3			; screen_mode
        .WORD $200		; saved_to_d3a
        .FARADDR speed_zone_graphic
        .FARADDR bomb_and_explosions_graphic
        .FARADDR empty_tilemap
        .FARADDR speed_zone_level_structure
        .FARADDR empty_tilemap
        .WORD $41		; level_representation
        .WORD 0			; hard_blocks
        .WORD 80		; soft_blocks
                    ; Off by one in	story mode, for	the level exit
        .FARADDR locret_C463DD
        .FARADDR load_palettes
        .FARADDR speed_zone_battle_palettes
        .WORD $10
        .BYTE 0
        .FARADDR load_global_sprites
        .FARADDR western_zone_graphics
        .WORD $10
        .BYTE 0
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 2
        .FARADDR tile_animation
        .FARADDR byte_C52854
        .WORD 6
        .WORD $F0F0
        .WORD 0
        .WORD BOMB_UP, BOMB_UP,	BOMB_UP, BOMB_UP, BOMB_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP, FIRE_UP
        .WORD POISON, POISON, KICK, KICK, KICK,	PUNCH, PUNCH,	PUNCH, FULL_FIRE,	FULL_FIRE
        .WORD REMOTE_CONTROL, REMOTE_CONTROL, 0
        .BYTE $17, $17,	0, $83,	$E8, 0,	0, 0, 0, 0
normal_zone_palettes:.BYTE HUD_PALETTE,	PEACE_TOWN_PALETTE_1, NORMAL_ZONE_PALETTE; a_palettes
        .BYTE PEACE_TOWN_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE NORMAL_ZONE_BOMB_PALETTE,	NORMAL_ZONE_FIRE_PALETTE; a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes
unknown_palettes_0:.BYTE HUD_PALETTE, PEACE_TOWN_PALETTE_1, PEACE_TOWN_PALETTE_2; a_palettes
        .BYTE PEACE_TOWN_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE PEACE_TOWN_BOMB_PALETTE, PEACE_TOWN_FIRE_PALETTE;	a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes
bomb_zone_palettes:.BYTE HUD_PALETTE, PEACE_TOWN_PALETTE_1, PEACE_TOWN_PALETTE_2; a_palettes
        .BYTE PEACE_TOWN_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE PEACE_TOWN_BOMB_PALETTE, PEACE_TOWN_FIRE_PALETTE;	a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes
jump_zone_palettes:.BYTE HUD_PALETTE, CASTLE_PALETTE_1,	CASTLE_PALETTE_2; a_palettes
        .BYTE CASTLE_PALETTE_3,	BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE CASTLE_BOMB_PALETTE, CASTLE_FIRE_PALETTE;	a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes
tunnel_zone_palettes:.BYTE HUD_PALETTE,	TUNNEL_ZONE_PALETTE_1, TUNNEL_ZONE_PALETTE_2; a_palettes
        .BYTE TUNNEL_ZONE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE TUNNEL_ZONE_BOMB_PALETTE,	TUNNEL_ZONE_FIRE_PALETTE; a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes
belt_zone_palettes:.BYTE HUD_PALETTE, FACTORY_PALETTE_1, FACTORY_PALETTE_2; a_palettes
        .BYTE FACTORY_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE FACTORY_BOMB_PALETTE, FACTORY_FIRE_PALETTE; a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes
unknown_palettes:.BYTE HUD_PALETTE, DIAMOND_TOWER_PALETTE_1, DIAMOND_TOWER_PALETTE_2; a_palettes
        .BYTE DIAMOND_TOWER_BOMB_PALETTE, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE DIAMOND_TOWER_BOMB_PALETTE, DIAMOND_TOWER_FIRE_PALETTE; a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE AKA_PALETTE, AO_PALETTE, FREE, WHITE_PALETTE; b_palettes
unknown_palettes2:.BYTE	HUD_PALETTE, $56, $57, $58, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE $59, $5A		; a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, GREEN_BOMB_PALETTE; b_palettes
        .BYTE RED_BOMB_PALETTE,	AKA_PALETTE, AO_PALETTE, BLACK_PALETTE;	b_palettes
        .BYTE WHITE_PALETTE	; b_palettes
duel_zone_palettes:.BYTE HUD_PALETTE, PARK_PALETTE_1, PARK_PALETTE_2, PARK_PALETTE_3; a_palettes
        .BYTE BONUS_PALETTE_1, BONUS_PALETTE_2,	PARK_BOMB_PALETTE; a_palettes
        .BYTE PARK_FIRE_PALETTE	; a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes
flower_zone_palettes:.BYTE HUD_PALETTE,	GARDEN_PALETTE_1, GARDEN_PALETTE_2; a_palettes
        .BYTE GARDEN_PALETTE_3_COPY, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE GARDEN_BOMB_PALETTE, GARDEN_FIRE_PALETTE;	a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes
light_zone_palettes:.BYTE HUD_PALETTE, DOME_PALETTE_1_INVERT, DOME_PALETTE_2_INVERT; a_palettes
        .BYTE DOME_PALETTE_3_INVERT, BONUS_1_INVERT_PALETTE, BONUS_2_INVERT_PALETTE; a_palettes
        .BYTE DOME_BOMB_PALETTE_INVERT,	DOME_FIRE_PALETTE_INVERT; a_palettes
        .BYTE INVERT_SHIRO, INVERT_KURO, INVERT_BOMB, INVERT_FIRE_BOMB;	b_palettes
        .BYTE INVERT_AKA, INVERT_AO, INVERT_BLACK, INVERT_WHITE; b_palettes
warp_zone_palettes:.BYTE HUD_PALETTE, WARP_ZONE_PALETTE_1, WARP_ZONE_PALETTE_2;	a_palettes
        .BYTE WARP_ZONE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE WARP_ZONE_BOMB_PALETTE, WARP_ZONE_FIRE_PALETTE; a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes
western_zone_palettes:.BYTE HUD_PALETTE, VILLAGE_PALETTE_1, VILLAGE_PALETTE_2; a_palettes
        .BYTE VILLAGE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE VILLAGE_BOMB_PALETTE, VILLAGE_FIRE_PALETTE; a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes
speed_zone_battle_palettes:.BYTE HUD_PALETTE, SPEED_ZONE_PALETTE_1, SPEED_ZONE_PALETTE_2; a_palettes
        .BYTE SPEED_ZONE_PALETTE_3, BONUS_PALETTE_1, BONUS_PALETTE_2; a_palettes
        .BYTE SPEED_ZONE_BOMB_PALETTE, SPEED_ZONE_FIRE_PALETTE;	a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes
power_zone_palettes:.BYTE HUD_PALETTE, POWER_ZONE_PALETTE_1, HUD_PALETTE, POWER_ZONE_PALETTE_2;	a_palettes
        .BYTE BONUS_PALETTE_1, BONUS_PALETTE_2,	POWER_ZONE_BOMB_PALETTE; a_palettes
        .BYTE POWER_ZONE_FIRE_PALETTE; a_palettes
        .BYTE SHIRO_PALETTE, KURO_PALETTE, BOMB_PALETTE, RED_BOMB_PALETTE; b_palettes
        .BYTE AKA_PALETTE, AO_PALETTE, BLACK_PALETTE, WHITE_PALETTE; b_palettes