segment "BANK1"

; Various graphics
asset graphics, animated_tiles_graphic
asset graphics/backgrounds, power_zone_graphic
asset graphics/backgrounds, arena_graphic
asset graphics, bg3_tileset_graphic
asset graphics/backgrounds, bonuses_graphic
asset graphics/backgrounds, spiderer_bg_graphic
asset graphics/sprites, victory_pose_graphic_0
asset graphics/sprites, victory_pose_graphic_1
asset graphics/sprites, victory_pose_graphic_2
asset graphics/sprites, victory_pose_graphic_3
asset graphics/sprites, victory_pose_graphic_4
asset graphics/sprites, victory_pose_graphic_5
asset graphics/sprites, victory_pose_graphic_6
asset graphics/backgrounds, continue_background_graphic
data_end

; General tilemaps
asset tilemaps, storymode_hud_tilemap
asset tilemaps, battlemode_hud_tilemap
asset tilemaps, scoreboard_tilemap
asset tilemaps, compressed_spotlight_tilemap
asset tilemaps, compressed_handcrane_tilemap

; Level structures
asset level_structures, peace_town_level_structure
asset level_structures, village_level_structure
asset level_structures, castle_level_structure
asset level_structures, dome_level_structure
asset level_structures, park_level_structure
asset level_structures, unused_level_structure_2
asset level_structures, circus_level_structure
asset level_structures, factory_level_structure
asset level_structures, crane_boss_level_structure
asset level_structures, arena_level_structure
asset level_structures, garden_level_structure
asset level_structures, power_zone_level_structure
asset level_structures, diamond_tower_level_structure
asset level_structures, speed_zone_level_structure
asset level_structures, normal_zone_level_structure
asset level_structures, warp_zone_level_structure
asset level_structures, tunnel_zone_level_structure
asset level_structures, unused_level_structure

; Misc. Tilemaps
asset tilemaps, compressed_tunnel_zone_overlay_tilemap
asset tilemaps, compressed_map_tilemap
asset tilemaps, compressed_draw_and_victory_tilemap
asset tilemaps, compressed_title_tilemap
asset tilemaps, compressed_introduction_tilemap
asset tilemaps, compressed_title_tilemap_2
asset tilemaps, compressed_continue_tilemap
asset tilemaps, compressed_pattern_tilemap
asset tilemaps, compressed_stage_1_6_overlay_tilemap
asset tilemaps, compressed_spiderer_tilemap

; "Skipped" level structure
asset level_structures, belt_zone_level_structure

; Credits screen graphics
asset tilemaps, compressed_credits_tilemap
; Similarly to the title, the first graphics use unterminated (overlay-like)
; compression, while only the last one uses 81aa00 terminated one.
asset graphics/overlays, credit_image_1_graphic
asset graphics/overlays, credit_image_2_graphic
asset graphics/overlays, credit_image_3_graphic
asset graphics/backgrounds, credit_image_4_graphic
data_end