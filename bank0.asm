.SEGMENT "BANK0"
.ORG $C00000

; Various graphics
ASSET2 graphics, overlays, bomb_and_explosions_graphic

; The different parts of the logo have different encodings.
; The first is non-terminated background (similar to how overlays are encoded)
; The second is a normal 81AA00 terminated background.
ASSET2 graphics, overlays, title_graphic
.IF TM_ON_LOGO
ASSET2 graphics, backgrounds, title_2_graphic
.ELSE
ASSET2_J graphics, backgrounds, title_2_graphic
.ENDIF

ASSET2 graphics, backgrounds, map_graphic
.IF FALLING_BOMBERMEN_DRAW
; When using FALLING_BOMBERMEN_DRAW, the DRAW letters are used as a background
; instead of sprites. This merges the draw graphics and the gradient graphics
; to the same image.
draw_screen_gradient_graphic:
.ENDIF
.IF FALLING_BOMBERMEN_DRAW & (!TIGHT_DRAW_SPACING)
.WARNING "FALLING_BOMBERMEN_DRAW requires TIGHT_DRAW_SPACING"
.ENDIF
.IF TIGHT_DRAW_SPACING
ASSET2_J graphics, backgrounds, draw_graphic
.ELSE
ASSET2 graphics, sprites, draw_graphic_0
ASSET2 graphics, sprites, draw_graphic_1
ASSET2 graphics, sprites, draw_graphic_2
ASSET2 graphics, sprites, draw_graphic_3
ASSET2 graphics, sprites, draw_graphic_4
ASSET2 graphics, sprites, draw_graphic_5
ASSET2 graphics, sprites, draw_graphic_6
.ENDIF
ASSET2 graphics, backgrounds, battle_win_graphic
ASSET2 graphics, backgrounds, circus_graphic
ASSET2 graphics, backgrounds, warp_zone_graphic
ASSET2 graphics, sprites, tractor_graphic
ASSET2 graphics, backgrounds, trampoline_and_crane_graphic
ASSET2 graphics, backgrounds, peace_town_graphic
ASSET2 graphics, backgrounds, village_graphic
ASSET2 graphics, backgrounds, castle_graphic
ASSET2 graphics, backgrounds, dome_graphic
ASSET2 graphics, backgrounds, park_graphic
ASSET2 graphics, backgrounds, normal_zone_graphic
ASSET2 graphics, backgrounds, garden_graphic
ASSET2 graphics, backgrounds, diamond_tower_tileset_graphic
ASSET2 graphics, backgrounds, speed_zone_graphic
ASSET2 graphics, sprites, mecha_onita_graphic_0
ASSET2 graphics, sprites, mecha_onita_graphic_1
ASSET2 graphics, sprites, mecha_onita_graphic_2
ASSET2 graphics, sprites, anzenda_graphic_0
ASSET2 graphics, sprites, anzenda_graphic_1
DATA_END

; Interrupt handlers
FILL $C0FF80
.A8
.I8

Native_mode_RESET:
		RTI

Emulation_mode_RESET:
		SEI
.IFDEF J
        JMP Emulation_mode_RESET_2
.ELSE
		CLC
		XCE
		JML	 main
.ENDIF

Native_mode_IRQ:
		JML	 irq

Native_mode_NMI:
		JML	 vblank
.IFDEF J
Emulation_mode_RESET_2:
	CLC
	XCE
	JML	 main
.ENDIF

; SNES Header
FILL $C0FFC0
snes_header:	.BYTE "SUPER BOMBERMAN      "
		.BYTE $21		; HiROM
		.BYTE 0			; ROM only
		.BYTE 9			; ROM Size = 0x80000
		.BYTE 0			; RAM Size
		.BYTE COUNTRY_CODE
		.BYTE $18		; Licensee Code
		.BYTE 0			; Version
		.WORD $FFFF		; Checksum Complement
		.WORD $0000		; Checksum
		.BYTE $FF, $FF,	$FF, $FF ; Unused
		.ADDR Native_mode_RESET	; Native-mode COP
		.ADDR Native_mode_RESET	; Native-mode BRK
		.ADDR Native_mode_RESET	; Native-mode ABORT
		.ADDR Native_mode_NMI	; Native-mode NMI
		.ADDR Native_mode_RESET	; Native-mode RESET
		.ADDR Native_mode_IRQ	; Native-mode IRQ
		.BYTE $FF, $FF,	$FF, $FF ; Unused
		.ADDR Native_mode_RESET	; Emulation-mode COP
		.BYTE $FF, $FF		; Unused
		.ADDR Native_mode_RESET	; Emulation-mode ABORT
		.ADDR Native_mode_RESET	; Emulation-mode NMI
		.ADDR Emulation_mode_RESET ; Emulation-mode RESET
		.ADDR Native_mode_RESET	; Emulation-mode IRQ
; End of Bank 0

