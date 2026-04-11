struct level level_representation, game_mode, flags, d1c, d3a,
             tileset, bomb_tileset, level_structure,
             overlay_tileset, overlay_tilemap,
             hard_blocks, soft_blocks
    dw $d1c
.flags
    dw $flags
.game_mode
    dw $game_mode
    dw $d3a

.tileset
    df $tileset
.bomb_tilset
    df $bomb_tileset
.overlay_tileset
    df $overlay_tileset
.level_structure
    df $level_structure
.overlay_tilemap
    df $overlay_tilemap
.level_representation
    dw $level_representation
.hard_blocks
    dw $hard_blocks
.soft_blocks
    dw $soft_blocks ; off by one in story mode, for the level exit
endstruct

struct battle_stage_ppu_regs main_flags, subscreen_flags, color_math, grey, scroll_x, scroll_y
.main_flags
    db $main_flags
.subscreen_flags
    db $subscreen_flags
.color_math
    dw $color_math
.color_data
    dw ($grey) | 0xe0
.scroll_x
    dw ($scroll_x) & 0x3ff
.scroll_y
    dw ($scroll_y) & 0x3ff
endstruct

struct registers_init_table_entry offset, value
.offset:
    db low($offset)
.value:
    db $value
endstruct

struct animation_frame address, length
.address:
    df $address
.length:
    db $length
endstruct

struct frame_oam_tile x_position, y_position, tile, flags_and_palette
.x_position:
    db low($x_position)
.y_position:
    db low($y_position)
.tile:
    dw $tile
.flags_and_palette:
    db $flags_and_palette
endstruct

struct battle_menu_item x_position, y_position, max_value, option_list
.x_position:
    dw $x_position
.y_position:
    dw $y_position
.max_value:
    dw $max_value
.option_list:
    da $option_list
.unused:
    ds 8
endstruct

struct vblank_queued_function
.function
    ds 3
.ptr_arg:
    ds 3
.word_arg_1:
    ds 2
.word_arg_2:
    ds 2    
endstruct

struct rendering_linked_list
.prev
    ds 2
.next
    ds 2
.neighbor_y
    ds 1
.animation_paused:
    ds 1
endstruct

; Object structures

struct object
.handler:
    ds 3
    org 0x40
endstruct

struct dynamic_object
    object
    org 3
.execution_priority
    ds 1
.prev
    ds 2
.next
    ds 2
    org 0x40
endstruct

struct pause_handler
    dynamic_object

; Debug menu only
org 0x10
.controlling_player 
    ds 2 ; short address
    
org 0x20
.state
    ds 2
.scroll
    ds 2

org 0x40
endstruct

PAUSE_HANDLER_STATE_IDLE = 0
PAUSE_HANDLER_STATE_OPENING = 1
PAUSE_HANDLER_STATE_CLOSING = 2

; Fields that are common to both player, enemy and most other visible objects
struct sprite
    dynamic_object ; Note: player objects are static objects
    org 3
    ds 5 ; Unknown / defined by "subclasses"
.current_animation:
    ds 3
.max_frame:
    ds 1
.current_frame:
    ds 1
.ticks_left_for_frames:
    ds 1
.palette:
    ds 1
.graphics_slot:
    ds 1
    ds 1
.x_position:
    ds 3
.y_position:
    ds 3
    ds 7 ; Unknown / defined by "subclasses"
.effective_palette:
    ds 1
.real_palette:
    ds 1
.direction:
    ds 1
org 0x40 ; The rest of the fields are defined by subclasses
endstruct

struct player
    object
    org 3
    ds 1 ; Unknown
.unknown_flags:
    ds 1
.player_index:
    ds 1
    ds 1 ; Unknown
.is_ai:
    ds 1
.current_animation:
    ds 3
.max_frame:
    ds 1
.current_frame:
    ds 1
.ticks_left_for_frames:
    ds 1
.palette:
    ds 1
.graphics_slot:
    ds 1
.warp_delay: ; 0x10
    ds 1
.x_position:
    ds 2
    ds 1 ; Unknown
.y_position:
    ds 2
    ds 1 ; Unknown
    ds 3 ; Unknown
    
    ; Score in BCD
.score_digits_56:
    ds 1
.score_digits_78:
    ds 1
.score_digits_12:
    ds 1
.score_digits_34:
    ds 1
.effective_palette:
    ds 1
.real_palette:
    ds 1
.direction: ; 0x20
    ds 1
.last_zigzag_direction
    ds 1
.down_keys:
    ds 2
.current_bomb_count:
    ds 2
    ds 2 ; Unknown
.rendering_linked_list:
    ds rendering_linked_list.sizeof
.no_death: ; Debug-controlled
    ds 1
.hit_flags:
    ds 1
.bombups:
    ds 1 ; 0x30
.fireups:  ; 31
    ds 1
.speedups:   ; 32
    ds 1
.remote_control:
    ds 1 ; 33
.trampoline_state: ;34-35
    ds 2
.invincibility_countdown: ;36-37
    ds 2
.powerups: ;38-39
    ds 2
.invisibility_poison_flashing: ; 3a-3c
    ds 1
    ds 1 ; Unknown
.debug_skull:
    ds 1
.lives: ; 3d
    ds 1
.effective_speed
    ds 2
    
; Player structs always have a struct for extra info, located 0x100 bytes after
; them. Since there can but other data between the player data and extra data,
; we will not count it for this structs size.

org 0x12f
.unknown_poison_related
    ds 1
    ; Collected bonuses
.collected_bombups:
    ds 1
.collected_fireups:
    ds 1
.collected_speedups:
    ds 1
.collected_remote_controls:
    ds 1
.collected_kicks:
    ds 1
.collected_punches:
    ds 1
    
    ds 4 ; Unknown
.poison_state
    ds 4

org 0x40
endstruct

struct enemy
    dynamic_object
    org 8
.current_animation:
    ds 3
.max_frame:
    ds 1
.current_frame:
    ds 1
.ticks_left_for_frames:
    ds 1
.palette:
    ds 1
.graphics_slot:
    ds 1
.fractional_x:
    ds 1
.x_position:
    ds 2
.fractional_y:
    ds 1
.y_position:
    ds 2
.animations:
    ds 3
.speed:
    ds 1
.hitpoints_left:
    ds 1
.flashing_counter
    ds 1
.collision_mask:
    ds 2
.effective_palette:
    ds 1
.real_palette:
    ds 1
.direction:
    ds 1
.hits_left_for_direction_switch:
    ds 1
.animation_direction:
    ds 2
    ds 2
    ds 1
    ds 1
.rendering_linked_list:
    ds rendering_linked_list.sizeof
    ds 1
.hit_flags:
    ds 1
.field_30:
    ds 1
    ds 1
    ds 1
    ds 1
    ds 2
    ds 1
    ds 1
    ds 1
    ds 1
.creation_functions_array_ptr:
    ds 3
.score_index:
    ds 1
.carried_bonus:
    ds 1
.flags:
    ds 1
endstruct

struct score_popup_object
    dynamic_object
    org 3
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
    ds 3
    ds 1
    ds 1
    ds 1
.palette:
    ds 2
    ds 1
.x_position:
    ds 1
    ds 1
    ds 1
.y_position:
    ds 1
    ds 1
.score_index:
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
.effective_palette:
    ds 1
.real_palette:
    ds 1
    ds 1
    ds 1
    ds 2
    ds 2
    ds 1
    ds 1
    ds 2
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
    ds 2
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
.field_3D:
    ds 1
.carried_bonus:
    ds 1
.flags:
    ds 1
endstruct

struct palette_slot
.palette_index:
    ds 1
.fade_flags: ; Unsure
    ds 1
.fade_counter:
    ds 1
.flags:
    ds 1
.offset:
    ds 2
    ds 2 ; padding
endstruct

struct trampoline_animator
    dynamic_object
org 0x20
.tile_offset:
    ds 2
.animation_counter:
    ds 2
org 0x40
endstruct

struct tile_animator
    dynamic_object
org 0xb
.current_frame:
    ds 2
.max_frame:
    ds 2    
org 0x16
.animation_address
    ds 2
org 0x40
endstruct

struct crowd_player ; Either whistle_player or crowd_cheer_player
    dynamic_object
org 0x20
.timer:
    ds 2
org 0x40
endstruct

struct password_entry
    sprite
org 0x30
.digits
    ds 4
org 0x40
endstruct