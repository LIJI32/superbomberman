TRUE: ; Fake symbol for IFDEF

.INCLUDE "config.asm"
.INCLUDE .CONCAT("config/", CONFIG, ".asm")

.INCLUDE "macros.asm"
.INCLUDE "structs.asm"
.INCLUDE "enums.asm"
.INCLUDE "hw.asm"
.INCLUDE "ram.asm"
    
; These banks are (almost) pure data and are not shared with DBoot
.INCLUDE "bank0.asm"
.INCLUDE "bank1.asm"
.INCLUDE "bank2.asm"
.INCLUDE "bank3.asm"

; Banks 4-7 use addresses 0000-7FFF for general code and data, and addresses
; 8000-FFFF for DBoot code, data and firmware. Bank 5's general code/data "sub
; section" overflow to DBoot data in the English localization, overwriting an
; (unused?) sound sample.
.INCLUDE "bank4.asm"
.INCLUDE "dboot.asm"
dboot_data_start:
dboot_data_offsets:
.DEFINE FIRST_DBOOT_BANK_SIZE $C50000 - dboot_data_start
.INCBIN "dboot/data.bin", 0, FIRST_DBOOT_BANK_SIZE

.INCLUDE "bank5.asm"
FILL $C58000
; The English localizations OVERFLOW this bank and overwrite sound data! When
; building in most English-language configurations, an overflow warning will be
; issued.
.INCBIN "dboot/data.bin", FIRST_DBOOT_BANK_SIZE + (* - $C58000), $8000 - (* - $C58000)

.INCLUDE "bank6.asm"
FILL $C68000
.INCBIN "dboot/data.bin", FIRST_DBOOT_BANK_SIZE + $8000, $8000

.INCLUDE "bank7.asm"
FILL $C78000
.INCBIN "dboot/data.bin", FIRST_DBOOT_BANK_SIZE + $10000

; Save space on bank 0
ASSET2 graphics, backgrounds, factory_graphic
ASSET2 graphics, sprites, kinkaru_graphic_0
ASSET2 graphics, sprites, kinkaru_graphic_1
ASSET2 graphics, backgrounds, musical_note_graphic