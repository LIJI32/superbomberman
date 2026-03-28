org 0x7E00BA
free_offset_in_object_pointer_array:
org 0x7E00BC
max_object_pointer_object:
org 0x7E00D0
unknown_function_pointer:
org 0x7E012C
pointer_to_current_music_list:
org 0x7E013C
number_of_loaded_instruments:
org 0x7E0300
frame_count:
org 0x7E0312
screen_flags:
org 0x7E0314
game_flags:
org 0x7E045C
object_pointer_array:
org 0x7E04F4
bg1_tilemap:
org 0x7E0816
bg3_tilemap:
org 0x7E0916
collision_map:
ds 0x320
.end
org 0x7E0C3C
current_mode:
org 0x7E0C91
number_of_visible_bonuses:
org 0x7E0C97
main_screen_status:
org 0x7E0C98
subscreen_status:
org 0x7E0C99
color_addition_settings:
org 0x7E0C9A
add_substract_select_and_enable:
org 0x7E0C9D
bg1_h_scroll:
org 0x7E0C9F
bg1_v_scroll:
org 0x7E0CA1
bg2_h_scroll:
org 0x7E0CA3
bg2_v_scroll:
org 0x7E0CA5
bg3_v_scroll:
org 0x7E0CA7
bg3_v_scroll_2:
org 0x7E0CE0
multitap_status:
org 0x7E0CE6 - USE_MULTI5_BIOS * 5
joypad_1:
    ds 2
joypad_2:
    ds 2
joypad_3:
    ds 2
joypad_4:
    ds 2
joypad_5:

org 0x7E0CE1 + USE_MULTI5_BIOS * 0xA
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
    
org 0x7E0CF0
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

org 0x7E0D40
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
    
org 0x7E0FC0
pause_object:
    pause_handler
    
org 0x7E2180
bg3_ram_map:
org 0x7E2800
temp_uncompressed_graphics:
org 0x7E6800
empty_tilemap:
org 0x7F0660
palette_allocation_related_array:
org 0x7E0D00
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
.hit_flags:
    ds 2
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
    ds 1
.anonymous_8:
    ds 2
.gameover_related:
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
org 0x7E0052
byte_7E0052:
org 0x7E0C3E
byte_7E0C3E:
org 0x7E0CA9
byte_7E0CA9:
org 0x7E3400
byte_7E3400:
org 0x7E0000
unk_7E0000:
org 0x7E0055
unk_7E0055:
org 0x7E013A
unk_7E013A:
org 0x7E04C4
unk_7E04C4:
org 0x7E0E5A
unk_7E0E5A:
org 0x7E0E5C
unk_7E0E5C:
org 0x7E0E9A
unk_7E0E9A:
org 0x7E0E9C
unk_7E0E9C:
org 0x7E0F44
unk_7E0F44:
org 0x7E0F80
unk_7E0F80:
org 0x7E1C40
unk_7E1C40:
org 0x7E1C80
unk_7E1C80:
org 0x7E1F80
unk_7E1F80:
org 0x7E2802
unk_7E2802:
org 0x7E2804
unk_7E2804:
org 0x7E2806
unk_7E2806:
org 0x7E2808
unk_7E2808:
org 0x7E280A
unk_7E280A:
org 0x7E280C
unk_7E280C:
org 0x7E280E
unk_7E280E:
org 0x7E4800
unexpanded_collision_map:
org 0x7E4802
unk_7E4802:
org 0x7E4A00
unk_7E4A00:
org 0x7F0000
unk_7F0000:
org 0x7E0040
word_7E0040:
org 0x7E0042
word_7E0042:
org 0x7E0048
word_7E0048:
org 0x7E0050
word_7E0050:
org 0x7E0053
word_7E0053:
org 0x7E0056
word_7E0056:
org 0x7E0058
word_7E0058:
org 0x7E0078
word_7E0078:
org 0x7E007A
word_7E007A:
org 0x7E00A4
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
org 0x7E00B5
word_7E00B5:
org 0x7E00BE
word_7E00BE:
org 0x7E00D2
word_7E00D2:
org 0x7E0306
word_7E0306:
org 0x7E0308
word_7E0308:
org 0x7E0310
word_7E0310:
org 0x7E031A
word_7E031A:
org 0x7E0C5F
word_7E0C5F:
org 0x7E0C63
word_7E0C63:
org 0x7E0C7F
word_7E0C7F:
org 0x7E0C81
word_7E0C81:
org 0x7E0C83
word_7E0C83:
org 0x7E0C85
word_7E0C85:
org 0x7E0C87
word_7E0C87:
org 0x7E0C89
word_7E0C89:
org 0x7E0C8B
word_7E0C8B:
org 0x7E0C8D
word_7E0C8D:
org 0x7E0C8F
word_7E0C8F:

org 0x7E0CAA
story_mode_timers:
    ds 2 ; Player 1
    ds 2 ; Player 2
    
org 0x7E0CAC
word_7E0CAC:
org 0x7E0CAE
word_7E0CAE:
org 0x7E0E48
word_7E0E48:
org 0x7E0E88
word_7E0E88:
org 0x7E0EC8
word_7E0EC8:
org 0x7E0F08
word_7E0F08:
org 0x7E0F40
word_7E0F40:
org 0x7E0F42
word_7E0F42:
org 0x7E0F46
word_7E0F46:
org 0x7E0100
dboot_ram_start:
number_of_music_banks:
org 0x7E0102
array_of_music_related_pointers:
org 0x7E011A
current_music_bank:
org 0x7E011E
number_of_instruments:
org 0x7E0120
number_of_sounds:
org 0x7E0122
number_of_musics_in_bank:
org 0x7E0124
pointer_to_instrument_list:
org 0x7E0128
pointer_to_sounds_list:
org 0x7E0130
dboot_internal_parameter:
org 0x7E0148
dboot_temp:
org 0x7E014C
instrument_loop_counter:
org 0x7E0150
dboot_temp_pointer:
org 0x7E0154
current_pointer_to_instrument_related_data:
org 0x7E0176
last_write_to_apu_io_0:
org 0x7FFC00
sound_related_buffer:
org 0x7FFD00
loaded_instruments:
org 0x7E011C
unk_7E011C:
org 0x7E0134
unk_7E0134:
org 0x7E0138
unk_7E0138:
org 0x7E0164
unk_7E0164:
org 0x7E0166
unk_7E0166:
org 0x7E0168
unk_7E0168:
org 0x7FFC80
unk_7FFC80:
org 0x7FFD80
unk_7FFD80:
org 0x7FFE00
unk_7FFE00:
org 0x7E0050
byte_7E0050:
org 0x7E0051
byte_7E0051:
org 0x7F0600
graphics_table:
org 0x7E0057
unk_7E0057:
org 0x7E2810
unk_7E2810:
org 0x7E4000
unk_7E4000:
org 0x7E4A02
unk_7E4A02:
org 0x7F0670
unk_7F0670:
org 0x7F06AE
unk_7F06AE:
org 0x7E0055
word_7E0055:
org 0x7E2804
byte3_7E2804:
org 0x7E2808
byte3_7E2808:
org 0x7E280C
byte3_7E280C:
org 0x7E0C61
word_7E0C61:
org 0x7E0C65
word_7E0C65:
org 0x7E0C93
word_7E0C93:
org 0x7E0C95
word_7E0C95:
org 0x7E00DB
unk_7E00DB:
org 0x7E00DC
unk_7E00DC:
org 0x7E1FC0
unk_7E1FC0:
org 0x7E2000
unk_7E2000:
org 0x7E2020
unk_7E2020:
org 0x7E2038
unk_7E2038:
org 0x7E203A
unk_7E203A:
org 0x7E21E6
unk_7E21E6:
org 0x7F0400
unk_7F0400:
org 0x7F06B0
unk_7F06B0:
org 0x7E00A0
word_7E00A0:
org 0x7E00B6
word_7E00B6:
org 0x7E0304
word_7E0304:
org 0x7E030A
word_7E030A:
org 0x7E030C
word_7E030C:
org 0x7E030E
word_7E030E:
org 0x7E0316
debug_cursor:
org 0x7E0318
word_7E0318:
org 0x7E0C3F
combo_counter:
org 0x7E0CE0
word_7E0CE0:
org 0x7E00A0
byte_7E00A0:
org 0x7E00A2
byte_7E00A2:
org 0x7E0F40
enemy_objects: