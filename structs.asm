.struct registers_init_table_entry
    offset .BYTE
    value .BYTE
.endstruct

.macro registers_init_table_entry offset, value
        .BYTE .LOBYTE(offset)
        .BYTE value
.endmacro

.struct animation_frame
    address .FARADDR
    length .BYTE
.endstruct

.macro animation_frame address, length
        .FARADDR address
        .BYTE length
.endmacro

.struct frame_oam_tile
x_position        .BYTE
y_position        .BYTE
tile              .WORD
flags_and_palette .BYTE
.endstruct

.macro frame_oam_tile x_position, y_position, tile, flags_and_palette
        .BYTE (x_position) & $FF
        .BYTE (y_position) & $FF
        .WORD tile
        .BYTE flags_and_palette
.endmacro

.struct battle_menu_item
    x_position     .WORD
    y_position     .WORD
    max_value      .WORD
    option_list    .ADDR
    unused         .WORD
                   .WORD
                   .WORD
                   .WORD
.endstruct

.macro battle_menu_item x_position, y_position, max_value, option_list
        .WORD x_position
        .WORD y_position
        .WORD max_value
        .ADDR option_list
        .RES 8
.endmacro


; Object structures

.struct object
    handler .FARADDR
.endstruct

.struct level_manager_object
    .TAG object
    bonus_count     .BYTE
                    .BYTE
                    .BYTE
                    .BYTE
                    .BYTE
                    .BYTE
                    .BYTE
                    .BYTE
                    .BYTE
                    .BYTE
                    .BYTE
                    .BYTE
                    .BYTE
    fade_related_   .WORD
    anonymous_1     .WORD
                    .BYTE
                    .BYTE
    anonymous_2     .WORD
    pointer_to_enemy_list .ADDR
    pointer_to_bonus_list .ADDR
    anonymous_5     .WORD
                    .BYTE
                    .BYTE
    anonymous_6     .WORD
                    .BYTE
                    .BYTE
    level_representation .BYTE
    enemy_count     .WORD
                    .BYTE
    anonymous_7     .WORD
                    .BYTE
                    .BYTE
                    .BYTE
                    .BYTE
                    .BYTE
                    .BYTE
    anonymous_8     .WORD
    gameover_related .WORD
                    .BYTE
    anonymous_9     .BYTE
    number_of_human_players .BYTE
    number_of_ai_players .BYTE
    spawn_and_flags .WORD
    anonymous_10    .WORD
    soft_blocks     .WORD
    field_3E        .BYTE
    current_screen        .BYTE
.endstruct

; Fields that are common to both player, enemy and most other visible objects
.struct sprite
    .TAG object
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
current_animation .FARADDR
max_frame       .BYTE
current_frame   .BYTE
ticks_left_for_frames .BYTE
palette         .WORD
                .BYTE
x_position      .BYTE
                .BYTE
                .BYTE
y_position      .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
effective_palette .BYTE
real_palette    .BYTE
direction       .BYTE
                .BYTE
                .WORD
                .WORD
                .BYTE
                .BYTE
                .WORD
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .WORD
                .BYTE
                .BYTE
                .BYTE
                .WORD
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
.endstruct

.struct player
    .TAG object
                .BYTE
gameover_related .BYTE
player_index    .BYTE
                .BYTE
is_ai           .BYTE
current_animation .FARADDR
max_frame       .BYTE
current_frame   .BYTE
ticks_left_for_frames .BYTE
palette         .WORD
wrap_delay      .BYTE
x_position      .BYTE
                .BYTE
                .BYTE
y_position      .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
score_digits_56 .BYTE
score_digits_78 .BYTE
socre_digits_12 .BYTE
score_digits_34 .BYTE
effective_palette .BYTE
real_palette    .BYTE
direction       .BYTE
                .BYTE
down_keys       .WORD
current_bomb_count .WORD
                .BYTE
                .BYTE
anonymous_6     .WORD
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
anonymous_7     .WORD
                .BYTE
                .BYTE
                .BYTE
trampoline_state .WORD
                .BYTE
                .BYTE
                .BYTE
                .BYTE
position_related .BYTE
                .BYTE
                .BYTE
number_of_lives .BYTE
                .BYTE
field_3F        .BYTE
.endstruct

.struct enemy
.TAG object
                .BYTE
prev            .WORD
next            .WORD
current_animation .FARADDR
max_frame       .BYTE
current_frame   .BYTE
ticks_left_for_frames .BYTE
palette         .WORD
fractional_x    .BYTE
x_position      .BYTE
                .BYTE
fractional_y    .BYTE
y_position      .BYTE
                .BYTE
animation       .BYTE
                .BYTE
                .BYTE
speed           .BYTE
hitpoints_left  .BYTE
                .BYTE
collision_mask  .BYTE
                .BYTE
effective_palette .BYTE
real_palette    .BYTE
direction       .BYTE
hits_left_for_direction_switch .BYTE
animation_direction .WORD
                .WORD
                .BYTE
                .BYTE
anonymous_6     .WORD
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
anonymous_7     .BYTE
field_30        .BYTE
                .BYTE
                .BYTE
                .BYTE
                .WORD
                .BYTE
                .BYTE
                .BYTE
                .BYTE
position_related .BYTE
                .BYTE
                .BYTE
score_index     .BYTE
carried_bonus   .BYTE
flags           .BYTE
.endstruct

.struct score_popup_object
.TAG object
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .FARADDR
                .BYTE
                .BYTE
                .BYTE
palette         .WORD
                .BYTE
x_position      .BYTE
                .BYTE
                .BYTE
y_position      .BYTE
                .BYTE
score_index     .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
effective_palette .BYTE
real_palette    .BYTE
                .BYTE
                .BYTE
                .WORD
                .WORD
                .BYTE
                .BYTE
                .WORD
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .WORD
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
                .BYTE
field_3D        .BYTE
carried_bonus   .BYTE
flags           .BYTE
.endstruct