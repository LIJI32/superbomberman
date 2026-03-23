struct registers_init_table_entry
.offset:
    ds 1
.value:
    ds 1
endstruct

macro registers_init_table_entry offset, value
    db low(offset)
    db value
endmacro

struct animation_frame
.address:
    ds 3
.length:
    ds 1
endstruct

macro animation_frame address, length
    df address
    db length
endmacro

struct frame_oam_tile
.x_position:
    ds 1
.y_position:
    ds 1
.tile:
    ds 2
.flags_and_palette:
    ds 1
endstruct

macro frame_oam_tile x_position, y_position, tile, flags_and_palette
    db (x_position) & 0xFF
    db (y_position) & 0xFF
    dw tile
    db flags_and_palette
endmacro

struct battle_menu_item
.x_position:
    ds 2
.y_position:
    ds 2
.max_value:
    ds 2
.option_list:
    ds 2
.unused:
    ds 2
    ds 2
    ds 2
    ds 2
endstruct

macro battle_menu_item x_position, y_position, max_value, option_list
    dw x_position
    dw y_position
    dw max_value
    dw option_list
    ds 8
endmacro


; Object structures

struct object
.handler:
    ds 3
endstruct

; Fields that are common to both player, enemy and most other visible objects
struct sprite
    .handler:
    ds 3
    ds 1
    ds 1
    ds 1
    ds 1
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
    ds 1
.x_position:
    ds 1
    ds 1
    ds 1
.y_position:
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
.effective_palette:
    ds 1
.real_palette:
    ds 1
.direction:
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
    ds 2
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
    ds 1
    ds 1
    ds 1
endstruct

struct player
.handler:
    ds 3
    ds 1
.gameover_related:
    ds 1
.player_index:
    ds 1
    ds 1
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
.wrap_delay:
    ds 1
.x_position:
    ds 1
    ds 1
    ds 1
.y_position:
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
.score_digits_56:
    ds 1
.score_digits_78:
    ds 1
.socre_digits_12:
    ds 1
.score_digits_34:
    ds 1
.effective_palette:
    ds 1
.real_palette:
    ds 1
.direction:
    ds 1
    ds 1
.down_keys:
    ds 2
.current_bomb_count:
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
.anonymous_7:
    ds 2
    ds 1
    ds 1
    ds 1
.trampoline_state:
    ds 2
    ds 1
    ds 1
    ds 1
    ds 1
.position_related:
    ds 1
    ds 1
    ds 1
.number_of_lives:
    ds 1
    ds 1
.field_3F:
    ds 1
endstruct

struct enemy
.handler:
    ds 3
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
.anonymous_7:
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
.handler:
    ds 3
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