include "config/" + CONFIG + ".asm"

include "macros.asm"
include "structs.asm"
include "enums.asm"
include "hw.asm"
include "ram.asm"
    
; These banks are (almost) pure data and are not shared with DBoot
include "bank0.asm"
include "bank1.asm"
include "bank2.asm"
include "bank3.asm"

; Banks 4-7 use addresses 0000-7FFF for general code and data, and addresses
; 8000-FFFF for DBoot code, data and firmware. Bank 5's general code/data "sub
; section" overflow to DBoot data in the English localization, overwriting an
; (unused?) sound sample.
include "bank4.asm"
include "dboot.asm"
dboot_data_start:
dboot_data_offsets:
FIRST_DBOOT_BANK_SIZE = 0xC50000 - dboot_data_start
incbin "dboot/data.bin", 0, FIRST_DBOOT_BANK_SIZE

include "bank5.asm"
fill 0xC58000
; The English localizations OVERFLOW this bank and overwrite sound data! When
; building in most English-language configurations, an overflow warning will be
; issued.
incbin "dboot/data.bin", FIRST_DBOOT_BANK_SIZE + (. - 0xC58000), 0x8000 - (. - 0xC58000)

include "bank6.asm"
fill 0xC68000
incbin "dboot/data.bin", FIRST_DBOOT_BANK_SIZE + 0x8000, 0x8000

include "bank7.asm"
fill 0xC78000
incbin "dboot/data.bin", FIRST_DBOOT_BANK_SIZE + 0x10000