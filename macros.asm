
.macro FILL addr
.if addr > *
		.RES addr - *, $00
.elseif addr < *
        .warning .concat("Overflow detected at ", .STRING(*))
.endif
.endmacro

.macro DATA_END
		NOP ; A NOP command (EA) marks the end of most data sections
.endmacro

.macro ASSET type, name
name:
.incbin .CONCAT(.STRING(type), "/", .STRING(name), ".bin")
.endmacro

.macro ASSET2 type, subtype, name
name:
.incbin .CONCAT(.STRING(type), "/", .STRING(subtype), "/", .STRING(name), ".bin")
.endmacro

.macro ASSET_J type, name
name:
.incbin .CONCAT(.STRING(type), "/", .STRING(name), "_j.bin")
.endmacro

.macro ASSET2_J type, subtype, name
name:
.incbin .CONCAT(.STRING(type), "/", .STRING(subtype), "/", .STRING(name), "_j.bin")
.endmacro

.macro DATA length
.ORG * + length
.endmacro