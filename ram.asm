org 0x7E0074
unused_fast_rng_seed: ; Written but never read
    ds 2
fast_rng_seed:
    ds 2
small_allocator_cyclic_buffer_read_pointer:
    ds 2
small_allocator_cyclic_buffer_write_pointer:
    ds 2
rng_seed:
    ds 2
    
org 0x7E00A0
word_7E00A0:
    ds 2
word_7E00A2:
    ds 2
debug_menu_data:
current_screen:
    ds 1
debug_no_death:
    ds 1
debug_game_speed:
    ds 1
debug_bomb_up:
    ds 1
debug_fire_up:
    ds 1
debug_speed_up:
    ds 1
debug_remocon:
    ds 1
debug_wall_pass:
    ds 1
debug_bomb_pass:
    ds 1
debug_fire_pass:
    ds 1
debug_full_fire:
    ds 1
debug_break_thr:
    ds 1
debug_power:
    ds 1
debug_kick:
    ds 1
debug_skull:
    ds 1
debug_time_check:
    ds 1
debug_vs_check:
    ds 1
debug_bgm:
    ds 1
debug_se:
    ds 1

org 0x7E00BA
allocator_cyclic_buffer_read_pointer:
    ds 2
allocator_cyclic_buffer_write_pointer:
    ds 2
first_sprite_ptr:
    ds 2
    
    
org 0x7E00D0
unknown_function_pointer:
    ds 2
word_7E00D2:
    ds 2
    
org 0x7E00DB
unk_7E00DB:
    ds 1
unk_7E00DC:
    ds 1
    
org 0x7E0100
dboot_ram_start:
number_of_music_banks:
    ds 2
array_of_music_related_pointers:
    ds 4
unk_dboot_6:
    ds 1
    ds 1
unk_dboot_8:
    ds 2
    
org 0x7E0114
unk_dboot_14:

org 0x7E011A
current_music_bank:
    ds 2
unk_dboot_1C:
    ds 2
number_of_instruments:
    ds 2
number_of_sounds:
    ds 2
number_of_musics_in_bank:
    ds 2
pointer_to_instrument_list:
    ds 2
unk_dboot_26:
    ds 2
pointer_to_sounds_list:
    ds 2
    
org 0x7E012C
pointer_to_current_music_list:
    ds 3
unk_dboot_2f:
    ds 1
dboot_paramater_0:
    ds 1
unk_dboot_31:
    ds 1
unk_dboot_32:
    ds 1
unk_dboot_33:
    ds 1
unk_dboot_34:
    ds 1
unk_dboot_35:
    ds 1

org 0x7E0138
unk_dboot_38:

org 0x7E013A
unk_dboot_3A:

org 0x7E013C
number_of_loaded_instruments:
    ds 2
unk_dboot_3e:
    ds 1
unk_dboot_3f:
    ds 1
    
org 0x7E0148
dboot_temp:

org 0x7E014C
instrument_loop_counter:

org 0x7E0150
dboot_temp_pointer:

org 0x7E0154
current_pointer_to_instrument_related_data:

org 0x7E0164
unk_dboot_64:
    ds 2
unk_dboot_66:
    ds 2
unk_dboot_68:
    ds 2

org 0x7E0176
last_write_to_apu_io_0:

org 0x7E0300
frame_count:
    ds 2

org 0x7E0304
palette_fade_disable_mask: ; Fade debug variable, not used
    ds 2
ptr_7E0306:
    ds 3
byte_7E0309:
    ds 1
vblank_queue_overflows: ; Seems like a debug variable, has no real effect
    ds 2
vblank_queue_read_end:
    ds 2
vblank_queue_write_end:
    ds 2
word_7E0310:
    ds 2
screen_flags:
    ds 2
game_flags:
    ds 2
debug_cursor:
    ds 2
palettes_require_transfer:
    ds 2
word_7E031A:
    ds 2
vblank_queue_cyclic_buffer:
rept 32
    vblank_queued_function
endr
.end
allocator_cyclic_buffer:
    ds (50 + 2) * 2
.end

org 0x7E04C4
small_allocator_cyclic_buffer:
    ds 0x30
.end

bg1_tilemap:
    ds 0x322
.end

bg3_tilemap:
    ds 0x100
.end

collision_map:
    ds 0x320
.end

org 0x7E0C3C
current_mode:
    ds 1

org 0x7E0C3E
byte_7E0C3E:

org 0x7E0C3F
combo_counters:
    ds 0x10

org 0x7E0C5F
word_7E0C5F:
    ds 2
word_7E0C61:
    ds 2
word_7E0C63:
    ds 2
word_7E0C65:

org 0x7E0C7F
word_7E0C7F:
    ds 2
word_7E0C81:
    ds 2
word_7E0C83:
    ds 2
word_7E0C85:
    ds 2
word_7E0C87:
    ds 2
word_7E0C89:
    ds 2
word_7E0C8B:
    ds 2
word_7E0C8D:
    ds 2
byte_7E0C8F:
    ds 1
use_mini_graphics:
    ds 1
number_of_visible_bonuses:
    ds 2
word_7E0C93:
    ds 2
word_7E0C95:
    ds 2
main_screen_status:
    ds 1
subscreen_status:
    ds 1
color_addition_settings:
    ds 1
add_substract_select_and_enable:
    ds 1
    
org 0x7E0C9D
bg1_h_scroll:
    ds 2
bg1_v_scroll:
    ds 2
bg2_h_scroll:
    ds 2
bg2_v_scroll:
    ds 2
bg3_v_scroll:
    ds 2    
bg3_v_scroll_2:
    ds 2
byte_7E0CA9:
    ds 1
story_mode_timers:
    ds 2 ; Player 1
    ds 2 ; Player 2
word_7E0CAE:
    ds 2
    
org 0x7E0CE0
multitap_status:
    ds 1
    
if USE_MULTI5_BIOS
joypad_1:
    ds 2
joypad_2:
    ds 2
joypad_3:
    ds 2
joypad_4:
    ds 2
joypad_5:
    ds 2
endif

joypad_1_connected:
    ds 1
joypad_2_connected:
    ds 1
joypad_3_connected:
    ds 1
joypad_4_connected:
    ds 1
joypad_5_connected:
    ds 1
    
if !USE_MULTI5_BIOS
joypad_1:
    ds 2
joypad_2:
    ds 2
joypad_3:
    ds 2
joypad_4:
    ds 2
joypad_5:
    ds 2
endif

joypad_1_previous:
    ds 2
joypad_2_previous:
    ds 2
joypad_3_previous:
    ds 2
joypad_4_previous:
    ds 2
joypad_1_pressed:
    ds 2
joypad_2_pressed:
    ds 2
joypad_3_pressed:
    ds 2
joypad_4_pressed:
    ds 2

level_manager_object:
.handler:
    ds 3
.bonus_count:
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
    ds 1
    ds 1
    ds 1
.fade_related_:
    ds 2
.anonymous_1:
    ds 2
    ds 1
    ds 1
.anonymous_2:
    ds 2
.pointer_to_enemy_list:
    ds 2
.pointer_to_bonus_list:
    ds 2
.anonymous_5:
    ds 2
    ds 1
    ds 1
.anonymous_6:
    ds 2
    ds 1
    ds 1
.level_representation:
    ds 1
.enemy_count:
    ds 2
    ds 1
.rendering_linked_list:
    ds rendering_linked_list.sizeof
    ds 1
    ds 1
.game_mode:
    ds 2
.unknown_flags:
    ds 2
    ds 1
.anonymous_9:
    ds 1
.number_of_human_players:
    ds 1
.number_of_ai_players:
    ds 1
.spawn_and_flags:
    ds 2
.anonymous_10:
    ds 2
.soft_blocks:
    ds 2
.field_3E:
    ds 1
.current_screen:
    ds 1

player_1:
    player
player_2:
    player
player_3:
    player
player_4:
    player
    
; These extra structs are already defined by their respective player struct, we
; just need to reserve space for the,
player_1_extra:
    ds object.sizeof
player_2_extra:
    ds object.sizeof
player_3_extra:
    ds object.sizeof
player_4_extra:
    ds object.sizeof
gameover_related_object:
    dynamic_object
hud_related_object:
    dynamic_object
dynamic_objects:
pause_object: ; The pause object is dynamically allocated, but assumed to be here
    pause_handler
    ds object.sizeof * 49
dynamic_objects.end:
    
org 0x7E0E48
word_7E0E48:

org 0x7E0E5A
unk_7E0E5A:
    ds 2
unk_7E0E5C:

org 0x7E0E88
word_7E0E88:

org 0x7E0E9A
unk_7E0E9A:
    ds 2
unk_7E0E9C:

org 0x7E0EC8
word_7E0EC8:

org 0x7E0F08
word_7E0F08:

org 0x7E0F42
word_7E0F42:
    ds 2
unk_7E0F44:
    ds 2
word_7E0F46:
    ds 2
    
org 0x7E1C80
unknown_static_small_object:
    ds 0x20
unknown_static_small_object_2:
    ds 0x20
small_objects:
    ds 0x20 * 22
.end

palette_slots:
rept 16
    palette_slot
endr
.end

unk_7E2000:

org 0x7E2020
unk_7E2020:

org 0x7E2038
unk_7E2038:

org 0x7E203A
unk_7E203A:

org 0x7E2180
bg3_ram_map:

org 0x7E21E6
unk_7E21E6:

org 0x7E2800
temp_uncompressed_graphics:

org 0x7E2802
unk_7E2802:
    ds 2
byte3_7E2804:
    ds 3
    
org 0x7E2808
byte3_7E2808:
    ds 3
    
org 0x7E280C
byte3_7E280C:
    ds 3
    
org 0x7E3400
byte_7E3400:

org 0x7E4000
unk_7E4000:

org 0x7E4800
unexpanded_collision_map:
    ds 0x200
unk_7E4A00:
    
org 0x7E6800
empty_tilemap:

org 0x7F0000
oam:
    ds 0x200
hi_oam:
    ds 0x20
    .end

; Unknown
    ds 0x1e0

palettes:
    ds 0x200
    .end

graphics_table:
    ds 0x60
palette_table:
    .background
    ds 8
    .sprite
    ds 8
    .end
shuffled_bonus_index_array:
    ds 0x40
    
org 0x7F06AE
unk_7F06AE:
    ds 2
enemy_creation_functions:
    ; Arbitrary size, not actually limited by it and not directly followed by anything
    ds 0x60

org 0x7FFC00
sound_related_buffer:
    ds 0x80
unk_7FFC80:
    ds 0x80

org 0x7FFD00
loaded_instruments:
    ds 0x80
unk_7FFD80:
    ds 0x80
unk_7FFE00:
