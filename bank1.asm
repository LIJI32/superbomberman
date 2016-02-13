.SEGMENT "BANK1"
.ORG $C10000

; Various graphics
ASSET graphics, animated_tiles_graphic
ASSET2 graphics, backgrounds, power_zone_graphic
ASSET2 graphics, backgrounds, arena_graphic
ASSET graphics, bg3_tileset_graphic
ASSET2 graphics, backgrounds, bonuses_graphic
ASSET2 graphics, backgrounds, spiderer_bg_graphic
ASSET2 graphics, sprites, victory_pose_graphic_0
ASSET2 graphics, sprites, victory_pose_graphic_1
ASSET2 graphics, sprites, victory_pose_graphic_2
ASSET2 graphics, sprites, victory_pose_graphic_3
ASSET2 graphics, sprites, victory_pose_graphic_4
ASSET2 graphics, sprites, victory_pose_graphic_5
ASSET2 graphics, sprites, victory_pose_graphic_6
ASSET2 graphics, backgrounds, continue_background_graphic
DATA_END

; General tilemaps
ASSET tilemaps, storymode_hud_tilemap
ASSET tilemaps, battlemode_hud_tilemap
ASSET tilemaps, scoreboard_tilemap
ASSET tilemaps, compressed_spotlight_tilemap
ASSET tilemaps, compressed_handcrane_tilemap

; Level structures
ASSET level_structures, peace_town_level_structure
ASSET level_structures, village_level_structure
ASSET level_structures, castle_level_structure
ASSET level_structures, dome_level_structure
ASSET level_structures, park_level_structure
ASSET level_structures, unused_level_structure_2
ASSET level_structures, circus_level_structure
ASSET level_structures, factory_level_structure
ASSET level_structures, crane_boss_level_structure
ASSET level_structures, arena_level_structure
ASSET level_structures, garden_level_structure
ASSET level_structures, power_zone_level_structure
ASSET level_structures, diamond_tower_level_structure
ASSET level_structures, speed_zone_level_structure
ASSET level_structures, normal_zone_level_structure
ASSET level_structures, warp_zone_level_structure
ASSET level_structures, tunnel_zone_level_structure
ASSET level_structures, unused_level_structure

; Misc. Tilemaps
ASSET tilemaps, compressed_tunnel_zone_overlay_tilemap
ASSET tilemaps, compressed_map_tilemap
ASSET tilemaps, compressed_draw_and_victory_tilemap
ASSET tilemaps, compressed_title_tilemap
ASSET tilemaps, compressed_introduction_tilemap
ASSET tilemaps, compressed_title_tilemap_2
ASSET tilemaps, compressed_continue_tilemap
ASSET tilemaps, compressed_pattern_tilemap
ASSET tilemaps, compressed_stage_1_6_overlay_tilemap
ASSET tilemaps, compressed_spiderer_tilemap

; "Skipped" level structure
ASSET level_structures, belt_zone_level_structure

; Credits screen graphics
ASSET tilemaps, compressed_credits_tilemap
; Similarly to the title, the first graphics use unterminated (overlay-like)
; compression, while only the last one uses 81aa00 terminated one.
ASSET2 graphics, overlays, credit_image_1_graphic
ASSET2 graphics, overlays, credit_image_2_graphic
ASSET2 graphics, overlays, credit_image_3_graphic
ASSET2 graphics, backgrounds, credit_image_4_graphic
DATA_END