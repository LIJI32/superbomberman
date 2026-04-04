; Derived from https://wiki.superfamicom.org/registers

; PPU Registers

INIDISP     = 0x2100 ; Screen Display Register
OBSEL       = 0x2101 ; Object Size and Character Size Register
OAMADDL     = 0x2102 ; OAM Address Registers (Low)
OAMADDH     = 0x2103 ; OAM Address Registers (High)
OAMDATA     = 0x2104 ; OAM Data Write Register
BGMODE      = 0x2105 ; BG Mode and Character Size Register
MOSAIC      = 0x2106 ; Mosaic Register
BG1SC       = 0x2107 ; BG Tilemap Address Registers (BG1)
BG2SC       = 0x2108 ; BG Tilemap Address Registers (BG2)
BG3SC       = 0x2109 ; BG Tilemap Address Registers (BG3)
BG4SC       = 0x210A ; BG Tilemap Address Registers (BG4)
BG12NBA     = 0x210B ; BG Character Address Registers (BG1&2)
BG34NBA     = 0x210C ; BG Character Address Registers (BG3&4)
BG1HOFS     = 0x210D ; BG Scroll Registers (BG1)
BG1VOFS     = 0x210E ; BG Scroll Registers (BG1)
BG2HOFS     = 0x210F ; BG Scroll Registers (BG2)
BG2VOFS     = 0x2110 ; BG Scroll Registers (BG2)
BG3HOFS     = 0x2111 ; BG Scroll Registers (BG3)
BG3VOFS     = 0x2112 ; BG Scroll Registers (BG3)
BG4HOFS     = 0x2113 ; BG Scroll Registers (BG4)
BG4VOFS     = 0x2114 ; BG Scroll Registers (BG4)
VMAIN       = 0x2115 ; Video Port Control Register
VMADDL      = 0x2116 ; VRAM Address Registers (Low)
VMADDH      = 0x2117 ; VRAM Address Registers (High)
VMDATAL     = 0x2118 ; VRAM Data Write Registers (Low)
VMDATAH     = 0x2119 ; VRAM Data Write Registers (High)
M7SEL       = 0x211A ; Mode 7 Settings Register
M7A         = 0x211B ; Mode 7 Matrix Registers
M7B         = 0x211C ; Mode 7 Matrix Registers
M7C         = 0x211D ; Mode 7 Matrix Registers
M7D         = 0x211E ; Mode 7 Matrix Registers
M7X         = 0x211F ; Mode 7 Matrix Registers
M7Y         = 0x2120 ; Mode 7 Matrix Registers
CGADD       = 0x2121 ; CGRAM Address Register
CGDATA      = 0x2122 ; CGRAM Data Write Register
W12SEL      = 0x2123 ; Window Mask Settings Registers
W34SEL      = 0x2124 ; Window Mask Settings Registers
WOBJSEL     = 0x2125 ; Window Mask Settings Registers
WH0         = 0x2126 ; Window Position Registers (WH0)
WH1         = 0x2127 ; Window Position Registers (WH1)
WH2         = 0x2128 ; Window Position Registers (WH2)
WH3         = 0x2129 ; Window Position Registers (WH3)
WBGLOG      = 0x212A ; Window Mask Logic registers (BG)
WOBJLOG     = 0x212B ; Window Mask Logic registers (OBJ)
TM          = 0x212C ; Screen Destination Registers
TS          = 0x212D ; Screen Destination Registers
TMW         = 0x212E ; Window Mask Destination Registers
TSW         = 0x212F ; Window Mask Destination Registers
CGWSEL      = 0x2130 ; Color Math Registers
CGADSUB     = 0x2131 ; Color Math Registers
COLDATA     = 0x2132 ; Color Math Registers
SETINI      = 0x2133 ; Screen Mode Select Register
MPYL        = 0x2134 ; Multiplication Result Registers
MPYM        = 0x2135 ; Multiplication Result Registers
MPYH        = 0x2136 ; Multiplication Result Registers
SLHV        = 0x2137 ; Software Latch Register
OAMDATAREAD = 0x2138 ; OAM Data Read Register
VMDATALREAD = 0x2139 ; VRAM Data Read Register (Low)
VMDATAHREAD = 0x213A ; VRAM Data Read Register (High)
CGDATAREAD  = 0x213B ; CGRAM Data Read Register
OPHCT       = 0x213C ; Scanline Location Registers (Horizontal)
OPVCT       = 0x213D ; Scanline Location Registers (Vertical)
STAT77      = 0x213E ; PPU Status Register
STAT78      = 0x213F ; PPU Status Register
APUIO0      = 0x2140 ; APU IO Registers
APUIO1      = 0x2141 ; APU IO Registers
APUIO2      = 0x2142 ; APU IO Registers
APUIO3      = 0x2143 ; APU IO Registers
WMDATA      = 0x2180 ; WRAM Data Register
WMADDL      = 0x2181 ; WRAM Address Registers
WMADDM      = 0x2182 ; WRAM Address Registers
WMADDH      = 0x2183 ; WRAM Address Registers

; Joypad Registers
JOYSER0     = 0x4016 ; Old Style Joypad Registers
JOYSER1     = 0x4017 ; Old Style Joypad Registers

; Internal CPU Registers
NMITIMEN    = 0x4200 ; Interrupt Enable Register
WRIO        = 0x4201 ; IO Port Write Register
WRMPYA      = 0x4202 ; Multiplicand Registers
WRMPYB      = 0x4203 ; Multiplicand Registers
WRDIVL      = 0x4204 ; Divisor & Dividend Registers
WRDIVH      = 0x4205 ; Divisor & Dividend Registers
WRDIVB      = 0x4206 ; Divisor & Dividend Registers
HTIMEL      = 0x4207 ; IRQ Timer Registers (Horizontal - Low)
HTIMEH      = 0x4208 ; IRQ Timer Registers (Horizontal - High)
VTIMEL      = 0x4209 ; IRQ Timer Registers (Vertical - Low)
VTIMEH      = 0x420A ; IRQ Timer Registers (Vertical - High)
MDMAEN      = 0x420B ; DMA Enable Register
HDMAEN      = 0x420C ; HDMA Enable Register
MEMSEL      = 0x420D ; ROM Speed Register
RDNMI       = 0x4210 ; Interrupt Flag Registers
TIMEUP      = 0x4211 ; Interrupt Flag Registers
HVBJOY      = 0x4212 ; PPU Status Register
RDIO        = 0x4213 ; IO Port Read Register
RDDIVL      = 0x4214 ; Multiplication Or Divide Result Registers (Low)
RDDIVH      = 0x4215 ; Multiplication Or Divide Result Registers (High)
RDMPYL      = 0x4216 ; Multiplication Or Divide Result Registers (Low)
RDMPYH      = 0x4217 ; Multiplication Or Divide Result Registers (High)
JOY1L       = 0x4218 ; Controller Port Data Registers (Pad 1 - Low)
JOY1H       = 0x4219 ; Controller Port Data Registers (Pad 1 - High)
JOY2L       = 0x421A ; Controller Port Data Registers (Pad 2 - Low)
JOY2H       = 0x421B ; Controller Port Data Registers (Pad 2 - High)
JOY3L       = 0x421C ; Controller Port Data Registers (Pad 3 - Low)
JOY3H       = 0x421D ; Controller Port Data Registers (Pad 3 - High)
JOY4L       = 0x421E ; Controller Port Data Registers (Pad 4 - Low)
JOY4H       = 0x421F ; Controller Port Data Registers (Pad 4 - High)

macro dma_registers x
; DMA Registers
DMAP$x      = 0x4300 + ($x * 0x10) ; DMA Control Register
BBAD$x      = 0x4301 + ($x * 0x10) ; DMA Destination Register
A1TL$x      = 0x4302 + ($x * 0x10) ; DMA Source Address Registers
A1TH$x      = 0x4303 + ($x * 0x10) ; DMA Source Address Registers
A1B$x       = 0x4304 + ($x * 0x10) ; DMA Source Address Registers
DASL$x      = 0x4305 + ($x * 0x10) ; DMA Size Registers (Low)
DASH$x      = 0x4306 + ($x * 0x10) ; DMA Size Registers (High)

; HDMA Registers
DMAP$x      = 0x4300 + ($x * 0x10) ; HDMA Control Register
BBAD$x      = 0x4301 + ($x * 0x10) ; HDMA Destination Register
A1TL$x      = 0x4302 + ($x * 0x10) ; HDMA Table Address Registers
A1TH$x      = 0x4303 + ($x * 0x10) ; HDMA Table Address Registers
A1B$x       = 0x4304 + ($x * 0x10) ; HDMA Table Address Registers
DASL$x      = 0x4305 + ($x * 0x10) ; HDMA Indirect Address Registers
DASH$x      = 0x4306 + ($x * 0x10) ; HDMA Indirect Address Registers
DASB$x      = 0x4307 + ($x * 0x10) ; HDMA Indirect Address Registers
A2AL$x      = 0x4308 + ($x * 0x10) ; HDMA Mid Frame Table Address Registers (Low)
A2AH$x      = 0x4309 + ($x * 0x10) ; HDMA Mid Frame Table Address Registers (High)
NTLR$x      = 0x430A + ($x * 0x10) ; HDMA Line Counter Register
endmacro

dma_registers 0
dma_registers 1
dma_registers 2
dma_registers 3
dma_registers 4
dma_registers 5
dma_registers 6
dma_registers 7

unmacro dma_registers