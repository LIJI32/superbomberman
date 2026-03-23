segment "BANK0"

; Various graphics
asset graphics/overlays, bomb_and_explosions_graphic

; The different parts of the logo have different encodings.
; The first is non-terminated background (similar to how overlays are encoded)
; The second is a normal 81AA00 terminated background.
asset graphics/overlays, title_graphic
if TM_ON_LOGO
asset graphics/backgrounds, title_2_graphic
else
asset_j graphics/backgrounds, title_2_graphic
endif

asset graphics/backgrounds, map_graphic
if FALLING_BOMBERMEN_DRAW
; When using FALLING_BOMBERMEN_DRAW, the DRAW letters are used as a background
; instead of sprites. This merges the draw graphics and the gradient graphics
; to the same image.
draw_screen_gradient_graphic:
endif
if FALLING_BOMBERMEN_DRAW & (!TIGHT_DRAW_SPACING)
warning "FALLING_BOMBERMEN_DRAW requires TIGHT_DRAW_SPACING"
endif
if TIGHT_DRAW_SPACING
asset_j graphics/backgrounds, draw_graphic
else
asset graphics/sprites, draw_graphic_0
asset graphics/sprites, draw_graphic_1
asset graphics/sprites, draw_graphic_2
asset graphics/sprites, draw_graphic_3
asset graphics/sprites, draw_graphic_4
asset graphics/sprites, draw_graphic_5
asset graphics/sprites, draw_graphic_6
endif
asset graphics/backgrounds, battle_win_graphic
asset graphics/backgrounds, circus_graphic
asset graphics/backgrounds, warp_zone_graphic
asset graphics/sprites, tractor_graphic
asset graphics/backgrounds, trampoline_and_crane_graphic
asset graphics/backgrounds, peace_town_graphic
asset graphics/backgrounds, village_graphic
asset graphics/backgrounds, castle_graphic
asset graphics/backgrounds, dome_graphic
asset graphics/backgrounds, park_graphic
asset graphics/backgrounds, normal_zone_graphic
asset graphics/backgrounds, garden_graphic
asset graphics/backgrounds, diamond_tower_tileset_graphic
asset graphics/backgrounds, speed_zone_graphic
asset graphics/sprites, mecha_onita_graphic_0
asset graphics/sprites, mecha_onita_graphic_1
asset graphics/sprites, mecha_onita_graphic_2
asset graphics/sprites, anzenda_graphic_0
asset graphics/sprites, anzenda_graphic_1
asset graphics/backgrounds, factory_graphic
asset graphics/sprites, kinkaru_graphic_0
asset graphics/sprites, kinkaru_graphic_1
asset graphics/backgrounds, musical_note_graphic
data_end

; Interrupt handlers
fill 0xC0FF80
a8
i8

Native_mode_RESET:
    RTI

Emulation_mode_RESET:
    SEI
ifdef J
    JMP a:Emulation_mode_RESET_2
else
    CLC
    XCE
    JMP main
endif

Native_mode_IRQ:
    JMP irq

Native_mode_NMI:
    JMP vblank
ifdef J
Emulation_mode_RESET_2:
    CLC
    XCE
    JMP main
endif

; SNES Header
fill 0xC0FFC0
snes_header:
        db "SUPER BOMBERMAN      "
        db 0x21                  ; HiROM
        db 0                    ; ROM only
        db 9                    ; ROM Size = 0x80000
        db 0                    ; RAM Size
        db COUNTRY_CODE
        db 0x18                  ; Licensee Code
        db 0                    ; Version
        dw 0xFFFF                ; Checksum Complement
        dw 0x0000                ; Checksum
        db 0xFF, 0xFF, 0xFF, 0xFF   ; Unused
        da Native_mode_RESET    ; Native-mode COP
        da Native_mode_RESET    ; Native-mode BRK
        da Native_mode_RESET    ; Native-mode ABORT
        da Native_mode_NMI      ; Native-mode NMI
        da Native_mode_RESET    ; Native-mode RESET
        da Native_mode_IRQ      ; Native-mode IRQ
        db 0xFF, 0xFF, 0xFF, 0xFF   ; Unused
        da Native_mode_RESET    ; Emulation-mode COP
        db 0xFF, 0xFF             ; Unused
        da Native_mode_RESET    ; Emulation-mode ABORT
        da Native_mode_RESET    ; Emulation-mode NMI
        da Emulation_mode_RESET ; Emulation-mode RESET
        da Native_mode_RESET    ; Emulation-mode IRQ
