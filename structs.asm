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

; Object structures

struct object
.handler:
    ds 3
endstruct

; Fields that are common to both player, enemy and most other visible objects
struct sprite
    object
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
    ds 2
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
    ds 1 ; Unknown
.gameover_related:
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
    ds 2
.wrap_delay: ; 0x10
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
    ds 1 ; Unknown
.down_keys:
    ds 2
.current_bomb_count:
    ds 2
    ds 2 ; Unknown
.anonymous_6:
    ds 2
    ds 5 ; Unknown
.hit_flags:
    ds 1
.bombups:
    ds 1 ; 0x30
.fireups:  ; 31
    ds 1
.speed:   ; 32
    ds 1
.powerups_1:
    ds 1 ; 33
.trampoline_state: ;34-35
    ds 2
.invincibility_countdown: ;36-37
    ds 2
.powerups_2: ;38-39
    ds 2
.position_related: ; 3a-3c
    ds 1
    ds 2 ; Unknown
.lives: ; 3d
    ds 1
    ds 2 ; Unknown 3e-3f
endstruct

struct shadow_player
org 0x30
; Collected bonuses
.bombups:
    ds 1
.fireups:
    ds 1
.speedups:
    ds 1
.remote_controls:
    ds 1
.kicks:
    ds 1
.punches:
    ds 1
org 0x40
endstruct

struct enemy
    object
    ds 1
.prev:
    ds 2
.next:
    ds 2
.current_animation:
    ds 3
.max_frame:
    ds 1
.current_frame:
    ds 1
.ticks_left_for_frames:
    ds 1
.palette:
    ds 2
.fractional_x:
    ds 1
.x_position:
    ds 1
    ds 1
.fractional_y:
    ds 1
.y_position:
    ds 1
    ds 1
.animation:
    ds 1
    ds 1
    ds 1
.speed:
    ds 1
.hitpoints_left:
    ds 1
    ds 1
.collision_mask:
    ds 1
    ds 1
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
.anonymous_6:
    ds 2
    ds 1
    ds 1
    ds 1
    ds 1
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
.position_related:
    ds 1
    ds 1
    ds 1
.score_index:
    ds 1
.carried_bonus:
    ds 1
.flags:
    ds 1
endstruct

struct score_popup_object
    object
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