.SEGMENT "BANK5"
.ORG $C50000


animation_frame_C50000:.BYTE 2
		frame_oam_tile $FC, 0,	$3405, 2
		frame_oam_tile $FC, $F8, $2405, 2
animation_frame_C5000B:.BYTE 1
		frame_oam_tile $F8, $F8, 3, $24
animation_frame_C50011:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $203,	$24
animation_frame_C50017:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $403,	$24
animation_frame_C5001D:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $603,	$24
animation_frame_C50023:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $2003, $24
animation_frame_C50029:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $2203, $24
animation_frame_C5002F:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $2403, $24
animation_frame_C50035:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $2603, $24
animation_frame_C5003B:.BYTE 1		       ; 0
		frame_oam_tile $F8, $F8, $2404, $24
animation_frame_C50041:.BYTE 5		       ; 0
		frame_oam_tile $FE, $F8, $3604, $84
		frame_oam_tile 6, $F8,	$2504, 4
		frame_oam_tile 6, 0, $3704, 4
		frame_oam_tile $FE, 0,	$3604, 4
		frame_oam_tile $F4, $F8, 3, $24
animation_frame_C5005B:.BYTE 2		       ; 0
		frame_oam_tile $FD, $F8, 3, $24
		frame_oam_tile $F4, $F8, 3, $24
animation_frame_C50066:.BYTE 2		       ; 0
		frame_oam_tile $FE, $F8, $203,	$24
		frame_oam_tile $F4, $F8, 3, $24
animation_frame_C50071:.BYTE 3		       ; 0
		frame_oam_tile 8, $F8,	$2001, $24
		frame_oam_tile $F8, $F8, $2401, $24
		frame_oam_tile $E8, $F8, $600,	$24
animation_frame_C50081:.BYTE 3		       ; 0
		frame_oam_tile 8, $F8,	$600, $26
		frame_oam_tile $F8, $F8, $400,	$26
		frame_oam_tile $E8, $F8, $2600, $26
animation_frame_C50091:
.IFNDEF J

        .BYTE 3
		frame_oam_tile 8, $F8,	$200, $28
		frame_oam_tile $F8, $F8, $200,	$28
		frame_oam_tile $E8, $F8, $400,	$28
.ELSE
; The Japanese version uses 9 OAM tiles for the OFF label
        .BYTE 9
        frame_oam_tile $D, 0, $1100, 8
        frame_oam_tile 5, 0, $1000, 8
        frame_oam_tile $10, $F8, $101, 8
        frame_oam_tile 8, $F8, 1, 8
        frame_oam_tile $FD, 0, $1100, 8
        frame_oam_tile $F5, 0, $1000, 8
        frame_oam_tile 0, $F8, $101, 8
        frame_oam_tile $F8, $F8, 1, 8
        frame_oam_tile $E8, $F8, $400, $28
.ENDIF
 byte_C500A1:    .BYTE 1
                 animation_frame animation_frame_C50000, $FF
 byte_C500A6:    .BYTE 1
                 animation_frame animation_frame_C5000B, $FF
 byte_C500AB:    .BYTE 1
                 animation_frame animation_frame_C50011, $FF
 byte_C500B0:    .BYTE 1
                 animation_frame animation_frame_C50017, $FF
 byte_C500B5:    .BYTE 1
                 animation_frame animation_frame_C5001D, $FF
 byte_C500BA:    .BYTE 1
                 animation_frame animation_frame_C50023, $FF
 byte_C500BF:    .BYTE 1
                 animation_frame animation_frame_C50029, $FF
 byte_C500C4:    .BYTE 1
                 animation_frame animation_frame_C5002F, $FF
 byte_C500C9:    .BYTE 1
                 animation_frame animation_frame_C50035, $FF
 byte_C500CE:    .BYTE 1
                 animation_frame animation_frame_C5003B, $FF
 byte_C500D3:    .BYTE 1
                 animation_frame animation_frame_C50041, $FF
 byte_C500D8:    .BYTE 1
                 animation_frame animation_frame_C5005B, $FF
 byte_C500DD:    .BYTE 1
                 animation_frame animation_frame_C50066, $FF
 byte_C500E2:    .BYTE 1
                 animation_frame animation_frame_C50071, $FF
 byte_C500E7:    .BYTE 1
                 animation_frame animation_frame_C50081, $FF
 byte_C500EC:    .BYTE 1
                 animation_frame animation_frame_C50091, $FF
.IF !USE_KATAKANA
normal_zone_label_frame:.BYTE $27
		frame_oam_tile $2C, 5,	$2505, 2; 0
		frame_oam_tile $2C, $FD, $2505, 2; 1
		frame_oam_tile $2C, $F5, $2505, 2; 2
		frame_oam_tile $24, $F5, $2505, 2; 3
		frame_oam_tile $1C, $F5, $2505, 2; 4
		frame_oam_tile $14, $F5, $2505, 2; 5
		frame_oam_tile $C, $F5, $2505,	2; 6
		frame_oam_tile 4, $F5,	$2505, 2; 7
		frame_oam_tile $24, 5,	$2505, 2; 8
		frame_oam_tile $1C, 5,	$2505, 2; 9
		frame_oam_tile $14, 5,	$2505, 2; $A
		frame_oam_tile $C, 5, $2505, 2; $B
		frame_oam_tile 4, 5, $2505, 2; $C
		frame_oam_tile $24, $FD, $404,	2; $D
		frame_oam_tile $1C, $FD, $2705, 2; $E
		frame_oam_tile $14, $FD, $3304, 2; $F
		frame_oam_tile $C, $FD, $3204,	2; $10
		frame_oam_tile 4, $FD,	$2505, 2; $11
		frame_oam_tile $FC, $FD, $2304, 2; $12
		frame_oam_tile $F4, $FD, 4, 2; $13
		frame_oam_tile $EC, $FD, $2605, 2; $14
		frame_oam_tile $E4, $FD, $1204, 2; $15
		frame_oam_tile $DC, $FD, $3304, 2; $16
		frame_oam_tile $D4, $FD, $2705, 2; $17
		frame_oam_tile $DC, $F5, $2505, 2; $18
		frame_oam_tile $E4, $F5, $2505, 2; $19
		frame_oam_tile $EC, $F5, $2505, 2; $1A
		frame_oam_tile $F4, $F5, $2505, 2; $1B
		frame_oam_tile $FC, $F5, $2505, 2; $1C
		frame_oam_tile $FC, 5,	$2505, 2; $1D
		frame_oam_tile $F4, 5,	$2505, 2; $1E
		frame_oam_tile $EC, 5,	$2505, 2; $1F
		frame_oam_tile $E4, 5,	$2505, 2; $20
		frame_oam_tile $DC, 5,	$2505, 2; $21
		frame_oam_tile $D4, 5,	$2505, 2; $22
		frame_oam_tile $CC, 5,	$2505, 2; $23
		frame_oam_tile $CC, $FD, $2505, 2; $24
		frame_oam_tile $CC, $F5, $2505, 2; $25
		frame_oam_tile $D4, $F5, $2505, 2; $26
western_zone_label_frame:.BYTE $2A
		frame_oam_tile $30, 5,	$2505, 2
		frame_oam_tile $30, $FD, $2505, 2
		frame_oam_tile $30, $F5, $2505, 2
		frame_oam_tile $28, $F5, $2505, 2
		frame_oam_tile $20, $F5, $2505, 2
		frame_oam_tile $18, $F5, $2505, 2
		frame_oam_tile $10, $F5, $2505, 2
		frame_oam_tile $28, 5,	$2505, 2
		frame_oam_tile $20, 5,	$2505, 2
		frame_oam_tile $18, 5,	$2505, 2
		frame_oam_tile $10, 5,	$2505, 2
		frame_oam_tile $28, $FD, $404,	2
		frame_oam_tile $20, $FD, $2705, 2
		frame_oam_tile $18, $FD, $3304, 2
		frame_oam_tile $10, $FD, $3204, 2
		frame_oam_tile 0, $FD,	$2705, 2
		frame_oam_tile $F8, $FD, $1204, 2
		frame_oam_tile $F0, $FD, $404,	2
		frame_oam_tile $E0, $FD, $1304, 2
		frame_oam_tile $D8, $FD, $404,	2
		frame_oam_tile $D0, $FD, $1704, 2
		frame_oam_tile $E8, $FD, $1404, 2
		frame_oam_tile $C8, $F5, $2505, 2
		frame_oam_tile $C8, $FD, $2505, 2
		frame_oam_tile $C8, 5,	$2505, 2
		frame_oam_tile $D0, 5,	$2505, 2
		frame_oam_tile $D8, 5,	$2505, 2
		frame_oam_tile $E0, 5,	$2505, 2
		frame_oam_tile $E8, 5,	$2505, 2
		frame_oam_tile $F0, 5,	$2505, 2
		frame_oam_tile $F8, 5,	$2505, 2
		frame_oam_tile 0, 5, $2505, 2
		frame_oam_tile 8, 5, $2505, 2
		frame_oam_tile 8, $FD,	$2505, 2
		frame_oam_tile 8, $F5,	$2505, 2
		frame_oam_tile 0, $F5,	$2505, 2
		frame_oam_tile $F8, $F5, $2505, 2
		frame_oam_tile $F0, $F5, $2505, 2
		frame_oam_tile $E8, $F5, $2505, 2
		frame_oam_tile $E0, $F5, $2505, 2
		frame_oam_tile $D8, $F5, $2505, 2
		frame_oam_tile $D0, $F5, $2505, 2
bomb_zone_label_frame:.BYTE $21
		frame_oam_tile $1C, $F5, $2505, 2
		frame_oam_tile $1C, 5,	$2505, 2
		frame_oam_tile $24, 5,	$2505, 2
		frame_oam_tile $24, $FD, $2505, 2
		frame_oam_tile $24, $F5, $2505, 2
		frame_oam_tile $1C, $FD, $404,	2
		frame_oam_tile $14, $FD, $2705, 2
		frame_oam_tile $C, $FD, $3304,	2
		frame_oam_tile 4, $FD,	$3204, 2
		frame_oam_tile $FC, $FD, $2505, 2
		frame_oam_tile $14, $F5, $2505, 2
		frame_oam_tile $14, 5,	$2505, 2
		frame_oam_tile $D4, 5,	$2505, 2
		frame_oam_tile $D4, $F5, $2505, 2
		frame_oam_tile $E4, $FD, $3304, 2
		frame_oam_tile $EC, $FD, $2605, 2
		frame_oam_tile $F4, $FD, $104,	2
		frame_oam_tile $DC, $FD, $104,	2
		frame_oam_tile $F4, $F5, $2505, 2
		frame_oam_tile $DC, $F5, $2505, 2
		frame_oam_tile $D4, $FD, $2505, 2
		frame_oam_tile $DC, 5,	$2505, 2
		frame_oam_tile $E4, 5,	$2505, 2
		frame_oam_tile $EC, 5,	$2505, 2
		frame_oam_tile $F4, 5,	$2505, 2
		frame_oam_tile $FC, 5,	$2505, 2
		frame_oam_tile 4, 5, $2505, 2
		frame_oam_tile $C, 5, $2505, 2
		frame_oam_tile $C, $F5, $2505,	2
		frame_oam_tile 4, $F5,	$2505, 2
		frame_oam_tile $FC, $F5, $2505, 2
		frame_oam_tile $EC, $F5, $2505, 2
		frame_oam_tile $E4, $F5, $2505, 2
jump_zone_label_frame:.BYTE $21
		frame_oam_tile $1C, $FD, $404,	2
		frame_oam_tile $14, $FD, $2705, 2
		frame_oam_tile $C, $FD, $3304,	2
		frame_oam_tile 4, $FD,	$3204, 2
		frame_oam_tile $FC, $FD, $2505, 2
		frame_oam_tile $F4, $FD, $1004, 2
		frame_oam_tile $EC, $FD, $2605, 2
		frame_oam_tile $E4, $FD, $1504, 2
		frame_oam_tile $DC, $FD, $2104, 2
		frame_oam_tile $24, 5,	$2505, 2
		frame_oam_tile $24, $FD, $2505, 2
		frame_oam_tile $24, $F5, $2505, 2
		frame_oam_tile $D4, 5,	$2505, 2
		frame_oam_tile $D4, $FD, $2505, 2
		frame_oam_tile $D4, $F5, $2505, 2
		frame_oam_tile $DC, $F5, $2505, 2
		frame_oam_tile $DC, 5,	$2505, 2
		frame_oam_tile $E4, 5,	$2505, 2
		frame_oam_tile $EC, 5,	$2505, 2
		frame_oam_tile $F4, 5,	$2505, 2
		frame_oam_tile $FC, 5,	$2505, 2
		frame_oam_tile 4, 5, $2505, 2
		frame_oam_tile $C, 5, $2505, 2
		frame_oam_tile $14, 5,	$2505, 2
		frame_oam_tile $1C, 5,	$2505, 2
		frame_oam_tile $1C, $F5, $2505, 2
		frame_oam_tile $14, $F5, $2505, 2
		frame_oam_tile $C, $F5, $2505,	2
		frame_oam_tile 4, $F5,	$2505, 2
		frame_oam_tile $FC, $F5, $2505, 2
		frame_oam_tile $F4, $F5, $2505, 2
		frame_oam_tile $EC, $F5, $2505, 2
		frame_oam_tile $E4, $F5, $2505, 2
belt_zone_label_frame:.BYTE $21
		frame_oam_tile $24, $F5, $2505, 2
		frame_oam_tile $24, $FD, $2505, 2
		frame_oam_tile $24, 5,	$2505, 2
		frame_oam_tile $1C, $FD, $404,	2
		frame_oam_tile $14, $FD, $2705, 2
		frame_oam_tile 4, $FD,	$3204, 2
		frame_oam_tile $E4, 5,	$2505, 2
		frame_oam_tile $DC, 5,	$2505, 2
		frame_oam_tile $D4, 5,	$2505, 2
		frame_oam_tile $D4, $FD, $2505, 2
		frame_oam_tile $D4, $F5, $2505, 2
		frame_oam_tile $DC, $F5, $2505, 2
		frame_oam_tile $E4, $F5, $2505, 2
		frame_oam_tile $DC, $FD, $104,	2
		frame_oam_tile $E4, $FD, $404,	2
		frame_oam_tile $EC, $FD, $2304, 2
		frame_oam_tile $F4, $FD, $1404, 2
		frame_oam_tile $FC, $FD, $2505, 2
		frame_oam_tile $C, $FD, $3304,	2
		frame_oam_tile $1C, 5,	$2505, 2
		frame_oam_tile $14, 5,	$2505, 2
		frame_oam_tile $C, 5, $2505, 2
		frame_oam_tile 4, 5, $2505, 2
		frame_oam_tile $FC, 5,	$2505, 2
		frame_oam_tile $F4, 5,	$2505, 2
		frame_oam_tile $EC, 5,	$2505, 2
		frame_oam_tile $EC, $F5, $2505, 2
		frame_oam_tile $1C, $F5, $2505, 2
		frame_oam_tile $14, $F5, $2505, 2
		frame_oam_tile $C, $F5, $2505,	2
		frame_oam_tile 4, $F5,	$2505, 2
		frame_oam_tile $FC, $F5, $2505, 2
		frame_oam_tile $F4, $F5, $2505, 2
tunnel_zone_label_frame:.BYTE $27
		frame_oam_tile $2C, 5,	$2505, 2
		frame_oam_tile $2C, $FD, $2505, 2
		frame_oam_tile $2C, $F5, $2505, 2
		frame_oam_tile $24, $F5, $2505, 2
		frame_oam_tile $1C, $F5, $2505, 2
		frame_oam_tile $14, $F5, $2505, 2
		frame_oam_tile $C, $F5, $2505,	2
		frame_oam_tile $24, 5,	$2505, 2
		frame_oam_tile $1C, 5,	$2505, 2
		frame_oam_tile $14, 5,	$2505, 2
		frame_oam_tile $C, 5, $2505, 2
		frame_oam_tile $24, $FD, $404,	2
		frame_oam_tile $1C, $FD, $2705, 2
		frame_oam_tile $14, $FD, $3304, 2
		frame_oam_tile $C, $FD, $3204,	2
		frame_oam_tile $E4, 5,	$2505, 2
		frame_oam_tile $E4, $F5, $2505, 2
		frame_oam_tile $FC, $FD, $2304, 2
		frame_oam_tile $F4, $FD, $404,	2
		frame_oam_tile $EC, $FD, $2705, 2
		frame_oam_tile $E4, $FD, $2705, 2
		frame_oam_tile $DC, $FD, $1504, 2
		frame_oam_tile $D4, $FD, $1404, 2
		frame_oam_tile 4, 5, $2505, 2
		frame_oam_tile 4, $FD,	$2505, 2
		frame_oam_tile 4, $F5,	$2505, 2
		frame_oam_tile $CC, $FD, $2505, 2
		frame_oam_tile $CC, 5,	$2505, 2
		frame_oam_tile $CC, $F5, $2505, 2
		frame_oam_tile $D4, $F5, $2505, 2
		frame_oam_tile $DC, $F5, $2505, 2
		frame_oam_tile $EC, $F5, $2505, 2
		frame_oam_tile $F4, $F5, $2505, 2
		frame_oam_tile $FC, $F5, $2505, 2
		frame_oam_tile $FC, 5,	$2505, 2
		frame_oam_tile $F4, 5,	$2505, 2
		frame_oam_tile $EC, 5,	$2505, 2
		frame_oam_tile $DC, 5,	$2505, 2
		frame_oam_tile $D4, 5,	$2505, 2
duel_zone_label_frame:.BYTE $21
		frame_oam_tile $D4, $FD, $2505, 2
		frame_oam_tile $24, $FD, $2505, 2
		frame_oam_tile $1C, $FD, $404,	2
		frame_oam_tile $14, $FD, $2705, 2
		frame_oam_tile $C, $FD, $3304,	2
		frame_oam_tile 4, $FD,	$3204, 2
		frame_oam_tile $FC, $FD, $2505, 2
		frame_oam_tile $F4, $FD, $2304, 2
		frame_oam_tile $EC, $FD, $404,	2
		frame_oam_tile $E4, $FD, $1504, 2
		frame_oam_tile $DC, $FD, $304,	2
		frame_oam_tile $24, $F5, $2505, 2
		frame_oam_tile $24, 5,	$2505, 2
		frame_oam_tile $1C, 5,	$2505, 2
		frame_oam_tile $1C, $F5, $2505, 2
		frame_oam_tile $D4, 5,	$2505, 2
		frame_oam_tile $D4, $F5, $2505, 2
		frame_oam_tile $14, 5,	$2505, 2
		frame_oam_tile $C, 5, $2505, 2
		frame_oam_tile 4, 5, $2505, 2
		frame_oam_tile $FC, 5,	$2505, 2
		frame_oam_tile $F4, 5,	$2505, 2
		frame_oam_tile $EC, 5,	$2505, 2
		frame_oam_tile $E4, 5,	$2505, 2
		frame_oam_tile $DC, 5,	$2505, 2
		frame_oam_tile $14, $F5, $2505, 2
		frame_oam_tile $C, $F5, $2505,	2
		frame_oam_tile 4, $F5,	$2505, 2
		frame_oam_tile $FC, $F5, $2505, 2
		frame_oam_tile $F4, $F5, $2505, 2
		frame_oam_tile $EC, $F5, $2505, 2
		frame_oam_tile $E4, $F5, $2505, 2
		frame_oam_tile $DC, $F5, $2505, 2
flower_zone_label_frame:.BYTE $27
		frame_oam_tile $2C, $FD, $2505, 2
		frame_oam_tile $24, $FD, $404,	2
		frame_oam_tile $1C, $FD, $2705, 2
		frame_oam_tile $14, $FD, $3304, 2
		frame_oam_tile $C, $FD, $3204,	2
		frame_oam_tile 4, $FD,	$2505, 2
		frame_oam_tile $FC, $FD, $1204, 2
		frame_oam_tile $F4, $FD, $404,	2
		frame_oam_tile $EC, $FD, $1704, 2
		frame_oam_tile $E4, $FD, $3304, 2
		frame_oam_tile $DC, $FD, $2304, 2
		frame_oam_tile $D4, $FD, $504,	2
		frame_oam_tile $F4, $F5, $2505, 2
		frame_oam_tile $F4, 5,	$2505, 2
		frame_oam_tile $2C, $F5, $2505, 2
		frame_oam_tile $2C, 5,	$2505, 2
		frame_oam_tile $D4, $F5, $2505, 2
		frame_oam_tile $CC, $F5, $2505, 2
		frame_oam_tile $CC, $FD, $2505, 2
		frame_oam_tile $CC, 5,	$2505, 2
		frame_oam_tile $D4, 5,	$2505, 2
		frame_oam_tile $DC, $F5, $2505, 2
		frame_oam_tile $DC, 5,	$2505, 2
		frame_oam_tile $24, 5,	$2505, 2
		frame_oam_tile $24, $F5, $2505, 2
		frame_oam_tile $1C, 5,	$2505, 2
		frame_oam_tile $14, 5,	$2505, 2
		frame_oam_tile $C, 5, $2505, 2
		frame_oam_tile 4, 5, $2505, 2
		frame_oam_tile $FC, 5,	$2505, 2
		frame_oam_tile $EC, 5,	$2505, 2
		frame_oam_tile $E4, 5,	$2505, 2
		frame_oam_tile $1C, $F5, $2505, 2
		frame_oam_tile $14, $F5, $2505, 2
		frame_oam_tile $C, $F5, $2505,	2
		frame_oam_tile 4, $F5,	$2505, 2
		frame_oam_tile $FC, $F5, $2505, 2
		frame_oam_tile $EC, $F5, $2505, 2
		frame_oam_tile $E4, $F5, $2505, 2
light_zone_label_frame:.BYTE $24
		frame_oam_tile 8, $F5,	$2505, 2
		frame_oam_tile $10, $F5, $2505, 2
		frame_oam_tile $18, $F5, $2505, 2
		frame_oam_tile $20, $F5, $2505, 2
		frame_oam_tile $28, $F5, $2505, 2
		frame_oam_tile $28, $FD, $2505, 2
		frame_oam_tile $28, 5,	$2505, 2
		frame_oam_tile $20, 5,	$2505, 2
		frame_oam_tile $18, 5,	$2505, 2
		frame_oam_tile 8, 5, $2505, 2
		frame_oam_tile $10, 5,	$2505, 2
		frame_oam_tile $20, $FD, $404,	2
		frame_oam_tile $18, $FD, $2705, 2
		frame_oam_tile $10, $FD, $3304, 2
		frame_oam_tile 8, $FD,	$3204, 2
		frame_oam_tile $D0, $FD, $2505, 2
		frame_oam_tile 0, $F5,	$2505, 2
		frame_oam_tile 0, $FD,	$2505, 2
		frame_oam_tile 0, 5, $2505, 2
		frame_oam_tile $D0, $F5, $2505, 2
		frame_oam_tile $D0, 5,	$2505, 2
		frame_oam_tile $F8, $FD, $1404, 2
		frame_oam_tile $F0, $FD, $704,	2
		frame_oam_tile $E8, $FD, $604,	2
		frame_oam_tile $E0, $FD, $2004, 2
		frame_oam_tile $D8, $FD, $2304, 2
		frame_oam_tile $F8, 5,	$2505, 2
		frame_oam_tile $F8, $F5, $2505, 2
		frame_oam_tile $F0, 5,	$2505, 2
		frame_oam_tile $E8, 5,	$2505, 2
		frame_oam_tile $E0, 5,	$2505, 2
		frame_oam_tile $D8, 5,	$2505, 2
		frame_oam_tile $F0, $F5, $2505, 2
		frame_oam_tile $E8, $F5, $2505, 2
		frame_oam_tile $E0, $F5, $2505, 2
		frame_oam_tile $D8, $F5, $2505, 2
power_zone_label_frame:.BYTE $24
		frame_oam_tile $20, $FD, $404,	2
		frame_oam_tile $18, $FD, $2705, 2
		frame_oam_tile $10, $FD, $3304, 2
		frame_oam_tile 8, $FD,	$3204, 2
		frame_oam_tile 0, $F5,	$2505, 2
		frame_oam_tile 0, $FD,	$2505, 2
		frame_oam_tile 0, 5, $2505, 2
		frame_oam_tile $D0, $F5, $2505, 2
		frame_oam_tile $D0, $FD, $2505, 2
		frame_oam_tile $D0, 5,	$2505, 2
		frame_oam_tile $28, $F5, $2505, 2
		frame_oam_tile $28, $FD, $2505, 2
		frame_oam_tile $28, 5,	$2505, 2
		frame_oam_tile $D8, $FD, $1004, 2
		frame_oam_tile $E0, $FD, $3304, 2
		frame_oam_tile $E8, $FD, $1704, 2
		frame_oam_tile $F0, $FD, $404,	2
		frame_oam_tile $F8, $FD, $1204, 2
		frame_oam_tile $E0, $F5, $2505, 2
		frame_oam_tile $E8, $F5, $2505, 2
		frame_oam_tile $F0, $F5, $2505, 2
		frame_oam_tile $F8, $F5, $2505, 2
		frame_oam_tile 8, $F5,	$2505, 2
		frame_oam_tile $10, $F5, $2505, 2
		frame_oam_tile $18, $F5, $2505, 2
		frame_oam_tile $20, $F5, $2505, 2
		frame_oam_tile $20, 5,	$2505, 2
		frame_oam_tile $D8, $F5, $2505, 2
		frame_oam_tile $D8, 5,	$2505, 2
		frame_oam_tile $E0, 5,	$2505, 2
		frame_oam_tile $E8, 5,	$2505, 2
		frame_oam_tile $F0, 5,	$2505, 2
		frame_oam_tile $F8, 5,	$2505, 2
		frame_oam_tile 8, 5, $2505, 2
		frame_oam_tile $10, 5,	$2505, 2
		frame_oam_tile $18, 5,	$2505, 2
warp_zone_label_frame:.BYTE $21
		frame_oam_tile $14, $FD, $2705, 2
		frame_oam_tile $C, $FD, $3304,	2
		frame_oam_tile 4, $FD,	$3204, 2
		frame_oam_tile $D4, 5,	$2505, 2
		frame_oam_tile $D4, $FD, $2505, 2
		frame_oam_tile $D4, $F5, $2505, 2
		frame_oam_tile $24, $F5, $2505, 2
		frame_oam_tile $24, $FD, $2505, 2
		frame_oam_tile $24, 5,	$2505, 2
		frame_oam_tile $1C, $FD, $404,	2
		frame_oam_tile $DC, $FD, $1704, 2
		frame_oam_tile $E4, $FD, 4, 2
		frame_oam_tile $EC, $FD, $1204, 2
		frame_oam_tile $F4, $FD, $1004, 2
		frame_oam_tile $FC, $FD, $2505, 2
		frame_oam_tile $DC, $F5, $2505, 2
		frame_oam_tile $DC, 5,	$2505, 2
		frame_oam_tile $1C, 5,	$2505, 2
		frame_oam_tile $1C, $F5, $2505, 2
		frame_oam_tile $14, 5,	$2505, 2
		frame_oam_tile $C, 5, $2505, 2
		frame_oam_tile 4, 5, $2505, 2
		frame_oam_tile $FC, 5,	$2505, 2
		frame_oam_tile $F4, 5,	$2505, 2
		frame_oam_tile $EC, 5,	$2505, 2
		frame_oam_tile $E4, 5,	$2505, 2
		frame_oam_tile $14, $F5, $2505, 2
		frame_oam_tile $C, $F5, $2505,	2
		frame_oam_tile 4, $F5,	$2505, 2
		frame_oam_tile $FC, $F5, $2505, 2
		frame_oam_tile $F4, $F5, $2505, 2
		frame_oam_tile $EC, $F5, $2505, 2
		frame_oam_tile $E4, $F5, $2505, 2
speed_zone_label_frame:.BYTE $24
		frame_oam_tile 8, $F5,	$2505, 2
		frame_oam_tile $10, $F5, $2505, 2
		frame_oam_tile $18, $F5, $2505, 2
		frame_oam_tile $20, $F5, $2505, 2
		frame_oam_tile $28, $F5, $2505, 2
		frame_oam_tile $28, $FD, $2505, 2
		frame_oam_tile $28, 5,	$2505, 2
		frame_oam_tile $20, 5,	$2505, 2
		frame_oam_tile $18, 5,	$2505, 2
		frame_oam_tile $10, 5,	$2505, 2
		frame_oam_tile 8, 5, $2505, 2
		frame_oam_tile $20, $FD, $404,	2
		frame_oam_tile $18, $FD, $2705, 2
		frame_oam_tile $10, $FD, $3304, 2
		frame_oam_tile 8, $FD,	$3204, 2
		frame_oam_tile 0, $F5,	$2505, 2
		frame_oam_tile 0, $FD,	$2505, 2
		frame_oam_tile 0, 5, $2505, 2
		frame_oam_tile $F8, $FD, $304,	2
		frame_oam_tile $F0, $FD, $404,	2
		frame_oam_tile $E8, $FD, $404,	2
		frame_oam_tile $E0, $FD, $1004, 2
		frame_oam_tile $D8, $FD, $1304, 2
		frame_oam_tile $D0, $FD, $2505, 2
		frame_oam_tile $D0, $F5, $2505, 2
		frame_oam_tile $D8, $F5, $2505, 2
		frame_oam_tile $E0, $F5, $2505, 2
		frame_oam_tile $E8, $F5, $2505, 2
		frame_oam_tile $F0, $F5, $2505, 2
		frame_oam_tile $F8, $F5, $2505, 2
		frame_oam_tile $F8, 5,	$2505, 2
		frame_oam_tile $F0, 5,	$2505, 2
		frame_oam_tile $E8, 5,	$2505, 2
		frame_oam_tile $E0, 5,	$2505, 2
		frame_oam_tile $D8, 5,	$2505, 2
		frame_oam_tile $D0, 5,	$2505, 2
.ELSE
normal_zone_label_frame:
        .BYTE $1C
        frame_oam_tile $1C, $FD, $2505, 2
        frame_oam_tile $FF, $F6, $3505, 2
        frame_oam_tile $EC, $F5, $2505, 2
        frame_oam_tile $F4, $F5, $2505, 2
        frame_oam_tile $FC, $F5, $2505, 2
        frame_oam_tile 4, $F5, $2505, 2
        frame_oam_tile $C, $F5, $2505, 2
        frame_oam_tile $14, $F5, $2505, 2
        frame_oam_tile $1C, $F5, $2505, 2
        frame_oam_tile $1C, 5, $2505, 2
        frame_oam_tile $14, 5, $2505, 2
        frame_oam_tile $C, 5, $2505, 2
        frame_oam_tile 4, 5, $2505, 2
        frame_oam_tile $FC, 5, $2505, 2
        frame_oam_tile $F4, 5, $2505, 2
        frame_oam_tile $EC, 5, $2505, 2
        frame_oam_tile $E4, 5, $2505, 2
        frame_oam_tile $DC, 5, $2505, 2
        frame_oam_tile $DC, $FD, $2505, 2
        frame_oam_tile $DC, $F5, $2505, 2
        frame_oam_tile $E4, $F5, $2505, 2
        frame_oam_tile $14, $FD, $604, 2
        frame_oam_tile $C, $FD, $504, 2
        frame_oam_tile 4, $FD, $404, 2
        frame_oam_tile $FC, $FD, $304, 2
        frame_oam_tile $F4, $FD, $204, 2
        frame_oam_tile $EC, $FD, $104, 2
        frame_oam_tile $E4, $FD, 4, 2
western_zone_label_frame:
        .BYTE $21
        frame_oam_tile $D4, $F5, $2505, 2
        frame_oam_tile $D4, $FD, $2505, 2
        frame_oam_tile $D4, 5, $2505, 2
        frame_oam_tile $DC, 5, $2505, 2
        frame_oam_tile $E4, 5, $2505, 2
        frame_oam_tile $EC, 5, $2505, 2
        frame_oam_tile $F4, 5, $2505, 2
        frame_oam_tile $FC, 5, $2505, 2
        frame_oam_tile 4, 5, $2505, 2
        frame_oam_tile $C, 5, $2505, 2
        frame_oam_tile $14, 5, $2505, 2
        frame_oam_tile $1C, 5, $2505, 2
        frame_oam_tile $24, 5, $2505, 2
        frame_oam_tile $24, $FD, $2505, 2
        frame_oam_tile $24, $F5, $2505, 2
        frame_oam_tile $1C, $F5, $2505, 2
        frame_oam_tile $14, $F5, $2505, 2
        frame_oam_tile $C, $F5, $2505, 2
        frame_oam_tile 4, $F5, $2505, 2
        frame_oam_tile $FC, $F5, $2505, 2
        frame_oam_tile $F4, $F5, $2505, 2
        frame_oam_tile $EC, $F5, $2505, 2
        frame_oam_tile $E4, $F5, $2505, 2
        frame_oam_tile $DC, $F5, $2505, 2
        frame_oam_tile $1C, $FD, $1404, 2
        frame_oam_tile $14, $FD, $1304, 2
        frame_oam_tile $C, $FD, $204, 2
        frame_oam_tile 4, $FD, $1204, 2
        frame_oam_tile $FC, $FD, $704, 2
        frame_oam_tile $F4, $FD, $1104, 2
        frame_oam_tile $EC, $FD, $1004, 2
        frame_oam_tile $E4, $FD, $704, 2
        frame_oam_tile $DC, $FD, $204, 2
bomb_zone_label_frame:
        .BYTE $20
        frame_oam_tile $14, $F6, $3505, 2
        frame_oam_tile 4, $F6, $3505, 2
        frame_oam_tile 0, $F5, $2505, 2
        frame_oam_tile $D8, $F5, $2505, 2
        frame_oam_tile $D8, $FD, $2505, 2
        frame_oam_tile $D8, 5, $2505, 2
        frame_oam_tile $E0, 5, $2505, 2
        frame_oam_tile $E8, 5, $2505, 2
        frame_oam_tile $F0, 5, $2505, 2
        frame_oam_tile $F8, 5, $2505, 2
        frame_oam_tile 0, 5, $2505, 2
        frame_oam_tile 8, 5, $2505, 2
        frame_oam_tile $10, 5, $2505, 2
        frame_oam_tile $18, 5, $2505, 2
        frame_oam_tile $20, 5, $2505, 2
        frame_oam_tile $20, $FD, $2505, 2
        frame_oam_tile $20, $F5, $2505, 2
        frame_oam_tile $18, $F5, $2505, 2
        frame_oam_tile $10, $F5, $2505, 2
        frame_oam_tile 8, $F5, $2505, 2
        frame_oam_tile $F8, $F5, $2505, 2
        frame_oam_tile $F0, $F5, $2505, 2
        frame_oam_tile $E8, $F5, $2505, 2
        frame_oam_tile $E0, $F5, $2505, 2
        frame_oam_tile $18, $FD, $1404, 2
        frame_oam_tile $10, $FD, $2004, 2
        frame_oam_tile 8, $FD, $1704, 2
        frame_oam_tile 0, $FD, $1604, 2
        frame_oam_tile $F0, $FD, $1504, 2
        frame_oam_tile $F8, $FD, $1004, 2
        frame_oam_tile $E8, $FD, $1004, 2
        frame_oam_tile $E0, $FD, $1504, 2
jump_zone_label_frame:
        .BYTE $21
        frame_oam_tile $1E, $F6, $3305, 2
        frame_oam_tile 6, $F6, $3505, 2
        frame_oam_tile $E4, $F6, $3505, 2
        frame_oam_tile $D8, $F5, $2505, 2
        frame_oam_tile $D8, $FD, $2505, 2
        frame_oam_tile $D8, 5, $2505, 2
        frame_oam_tile $E0, 5, $2505, 2
        frame_oam_tile $E8, 5, $2505, 2
        frame_oam_tile $F0, 5, $2505, 2
        frame_oam_tile $F8, 5, $2505, 2
        frame_oam_tile 0, 5, $2505, 2
        frame_oam_tile 8, 5, $2505, 2
        frame_oam_tile $10, 5, $2505, 2
        frame_oam_tile $18, 5, $2505, 2
        frame_oam_tile $20, 5, $2505, 2
        frame_oam_tile $20, $FD, $2505, 2
        frame_oam_tile $20, $F5, $2505, 2
        frame_oam_tile $18, $F5, $2505, 2
        frame_oam_tile $10, $F5, $2505, 2
        frame_oam_tile 8, $F5, $2505, 2
        frame_oam_tile 0, $F5, $2505, 2
        frame_oam_tile $F8, $F5, $2505, 2
        frame_oam_tile $F0, $F5, $2505, 2
        frame_oam_tile $E8, $F5, $2505, 2
        frame_oam_tile $E0, $F5, $2505, 2
        frame_oam_tile $18, $FD, 4, 2
        frame_oam_tile $10, $FD, $1404, 2
        frame_oam_tile 8, $FD, $2304, 2
        frame_oam_tile 0, $FD, $704, 2
        frame_oam_tile $F8, $FD, $1404, 2
        frame_oam_tile $F0, $FD, $2204, 2
        frame_oam_tile $E8, $FD, $2204, 2
        frame_oam_tile $E0, $FD, $2104, 2
belt_zone_label_frame:
        .BYTE $1D
        frame_oam_tile $10, $F6, $3505, 2
        frame_oam_tile $E8, $F6, $3505, 2
        frame_oam_tile $1D, $F5, $2505, 2
        frame_oam_tile $1D, $FD, $2505, 2
        frame_oam_tile $1D, 5, $2505, 2
        frame_oam_tile $15, 5, $2505, 2
        frame_oam_tile $D, 5, $2505, 2
        frame_oam_tile 5, 5, $2505, 2
        frame_oam_tile $FD, 5, $2505, 2
        frame_oam_tile $F5, 5, $2505, 2
        frame_oam_tile $ED, 5, $2505, 2
        frame_oam_tile $E5, 5, $2505, 2
        frame_oam_tile $DD, 5, $2505, 2
        frame_oam_tile $DD, $FD, $2505, 2
        frame_oam_tile $DD, $F5, $2505, 2
        frame_oam_tile $15, $F5, $2505, 2
        frame_oam_tile $D, $F5, $2505, 2
        frame_oam_tile 5, $F5, $2505, 2
        frame_oam_tile $FD, $F5, $2505, 2
        frame_oam_tile $F5, $F5, $2505, 2
        frame_oam_tile $ED, $F5, $2505, 2
        frame_oam_tile $E5, $F5, $2505, 2
        frame_oam_tile $ED, $FD, $2604, 2
        frame_oam_tile $15, $FD, $3104, 2
        frame_oam_tile $D, $FD, $3004, 2
        frame_oam_tile 5, $FD, $1404, 2
        frame_oam_tile $FD, $FD, $1504, 2
        frame_oam_tile $F5, $FD, $3204, 2
        frame_oam_tile $E5, $FD, $3004, 2
tunnel_zone_label_frame:
        .BYTE $1E
        frame_oam_tile 9, $F6, $3505, 2
        frame_oam_tile 1, $F6, $3505, 2
        frame_oam_tile $E8, $F7, $3505, 2
        frame_oam_tile $1D, 5, $2505, 2
        frame_oam_tile $1D, $FD, $2505, 2
        frame_oam_tile $1D, $F5, $2505, 2
        frame_oam_tile $DD, $FD, $2505, 2
        frame_oam_tile $DD, 5, $2505, 2
        frame_oam_tile $DD, $F5, $2505, 2
        frame_oam_tile $E5, $F5, $2505, 2
        frame_oam_tile $ED, $F5, $2505, 2
        frame_oam_tile $F5, $F5, $2505, 2
        frame_oam_tile $FD, $F5, $2505, 2
        frame_oam_tile 5, $F5, $2505, 2
        frame_oam_tile $D, $F5, $2505, 2
        frame_oam_tile $15, $F5, $2505, 2
        frame_oam_tile $15, 5, $2505, 2
        frame_oam_tile $D, 5, $2505, 2
        frame_oam_tile 5, 5, $2505, 2
        frame_oam_tile $FD, 5, $2505, 2
        frame_oam_tile $F5, 5, $2505, 2
        frame_oam_tile $ED, 5, $2505, 2
        frame_oam_tile $E5, 5, $2505, 2
        frame_oam_tile $15, $FD, $1404, 2
        frame_oam_tile $D, $FD, $304, 2
        frame_oam_tile 5, $FD, $2104, 2
        frame_oam_tile $FD, $FD, $504, 2
        frame_oam_tile $F5, $FD, $1404, 2
        frame_oam_tile $ED, $FD, $304, 2
        frame_oam_tile $E5, $FD, $3204, 2
duel_zone_label_frame:
        .BYTE $1E
        frame_oam_tile $20, 5, $2505, 2
        frame_oam_tile $20, $FD, $2505, 2
        frame_oam_tile $20, $F5, $2505, 2
        frame_oam_tile $D8, 5, $2505, 2
        frame_oam_tile $D8, $FD, $2505, 2
        frame_oam_tile $D8, $F5, $2505, 2
        frame_oam_tile $18, 5, $2505, 2
        frame_oam_tile $10, 5, $2505, 2
        frame_oam_tile 8, 5, $2505, 2
        frame_oam_tile 0, 5, $2505, 2
        frame_oam_tile $F8, 5, $2505, 2
        frame_oam_tile $F0, 5, $2505, 2
        frame_oam_tile $E8, 5, $2505, 2
        frame_oam_tile $E0, 5, $2505, 2
        frame_oam_tile $18, $F5, $2505, 2
        frame_oam_tile $10, $F5, $2505, 2
        frame_oam_tile 8, $F5, $2505, 2
        frame_oam_tile 0, $F5, $2505, 2
        frame_oam_tile $F8, $F5, $2505, 2
        frame_oam_tile $F0, $F5, $2505, 2
        frame_oam_tile $E8, $F5, $2505, 2
        frame_oam_tile $E0, $F5, $2505, 2
        frame_oam_tile $18, $FD, $3605, 2
        frame_oam_tile $10, $FD, $504, 2
        frame_oam_tile 8, $FD, $1005, 2
        frame_oam_tile 0, $FD, $3104, 2
        frame_oam_tile $F8, $FD, $2705, 2
        frame_oam_tile $F0, $FD, $504, 2
        frame_oam_tile $E8, $FD, $2605, 2
        frame_oam_tile $E0, $FD, $3304, 2
flower_zone_label_frame:
        .BYTE $1D
        frame_oam_tile $F8, $F6, $3505, 2
        frame_oam_tile $E9, $F5, $3505, 2
        frame_oam_tile $DC, $F5, $2505, 2
        frame_oam_tile $DC, $FD, $2505, 2
        frame_oam_tile $DC, 5, $2505, 2
        frame_oam_tile $1C, 5, $2505, 2
        frame_oam_tile $1C, $F5, $2505, 2
        frame_oam_tile $1C, $FD, $2505, 2
        frame_oam_tile $14, 5, $2505, 2
        frame_oam_tile $C, 5, $2505, 2
        frame_oam_tile 4, 5, $2505, 2
        frame_oam_tile $FC, 5, $2505, 2
        frame_oam_tile $F4, 5, $2505, 2
        frame_oam_tile $EC, 5, $2505, 2
        frame_oam_tile $E4, 5, $2505, 2
        frame_oam_tile $14, $F5, $2505, 2
        frame_oam_tile $C, $F5, $2505, 2
        frame_oam_tile 4, $F5, $2505, 2
        frame_oam_tile $FC, $F5, $2505, 2
        frame_oam_tile $F4, $F5, $2505, 2
        frame_oam_tile $EC, $F5, $2505, 2
        frame_oam_tile $E4, $F5, $2505, 2
        frame_oam_tile $14, $FD, $1605, 2
        frame_oam_tile $C, $FD, $1405, 2
        frame_oam_tile 4, $FD, $2305, 2
        frame_oam_tile $FC, $FD, 4, 2
        frame_oam_tile $F4, $FD, $1205, 2
        frame_oam_tile $EC, $FD, $1404, 2
        frame_oam_tile $E4, $FD, $2704, 2
light_zone_label_frame:
        .BYTE $1C
        frame_oam_tile $EA, $F6, $3305, 2
        frame_oam_tile $DD, $F5, $2505, 2
        frame_oam_tile $DD, $FD, $2505, 2
        frame_oam_tile $DD, 5, $2505, 2
        frame_oam_tile $1D, 5, $2505, 2
        frame_oam_tile $1D, $FD, $2505, 2
        frame_oam_tile $1D, $F5, $2505, 2
        frame_oam_tile $15, 5, $2505, 2
        frame_oam_tile $D, 5, $2505, 2
        frame_oam_tile 5, 5, $2505, 2
        frame_oam_tile $FD, 5, $2505, 2
        frame_oam_tile $F5, 5, $2505, 2
        frame_oam_tile $ED, 5, $2505, 2
        frame_oam_tile $E5, 5, $2505, 2
        frame_oam_tile $15, $F5, $2505, 2
        frame_oam_tile $D, $F5, $2505, 2
        frame_oam_tile 5, $F5, $2505, 2
        frame_oam_tile $FD, $F5, $2505, 2
        frame_oam_tile $F5, $F5, $2505, 2
        frame_oam_tile $ED, $F5, $2505, 2
        frame_oam_tile $E5, $F5, $2505, 2
        frame_oam_tile $15, $FD, $3204, 2
        frame_oam_tile $D, $FD, $1005, 2
        frame_oam_tile 5, $FD, $2305, 2
        frame_oam_tile $FD, $FD, $2205, 2
        frame_oam_tile $F5, $FD, $304, 2
        frame_oam_tile $ED, $FD, $2605, 2
        frame_oam_tile $E5, $FD, $2104, 2
power_zone_label_frame:
        .BYTE $1E
        frame_oam_tile $D, $F6, $3305, 2
        frame_oam_tile $FC, $F6, $3505, 2
        frame_oam_tile $EC, $F6, $3505, 2
        frame_oam_tile $E8, $F5, $2505, 2
        frame_oam_tile $F0, $F5, $2505, 2
        frame_oam_tile $F8, $F5, $2505, 2
        frame_oam_tile 0, $F5, $2505, 2
        frame_oam_tile 8, $F5, $2505, 2
        frame_oam_tile $10, $F5, $2505, 2
        frame_oam_tile $18, $F5, $2505, 2
        frame_oam_tile $20, $F5, $2505, 2
        frame_oam_tile $20, $FD, $2505, 2
        frame_oam_tile $20, 5, $2505, 2
        frame_oam_tile $E0, $F5, $2505, 2
        frame_oam_tile $E0, $FD, $2505, 2
        frame_oam_tile $E0, 5, $2505, 2
        frame_oam_tile $E8, 5, $2505, 2
        frame_oam_tile $F0, 5, $2505, 2
        frame_oam_tile $F8, 5, $2505, 2
        frame_oam_tile 0, 5, $2505, 2
        frame_oam_tile 8, 5, $2505, 2
        frame_oam_tile $10, 5, $2505, 2
        frame_oam_tile $18, 5, $2505, 2
        frame_oam_tile $18, $FD, $1605, 2
        frame_oam_tile $10, $FD, $1405, 2
        frame_oam_tile 8, $FD, $1604, 2
        frame_oam_tile 0, $FD, $1404, 2
        frame_oam_tile $F8, $FD, $604, 2
        frame_oam_tile $F0, $FD, $1404, 2
        frame_oam_tile $E8, $FD, $604, 2
warp_zone_label_frame:
        .BYTE $1D
        frame_oam_tile $1B, $F7, $3305, 2
        frame_oam_tile $E8, $F6, $3505, 2
        frame_oam_tile $DC, $F5, $2505, 2
        frame_oam_tile $DC, $FD, $2505, 2
        frame_oam_tile $DC, 5, $2505, 2
        frame_oam_tile $1C, 5, $2505, 2
        frame_oam_tile $1C, $F5, $2505, 2
        frame_oam_tile $1C, $FD, $2505, 2
        frame_oam_tile $14, 5, $2505, 2
        frame_oam_tile $C, 5, $2505, 2
        frame_oam_tile 4, 5, $2505, 2
        frame_oam_tile $FC, 5, $2505, 2
        frame_oam_tile $F4, 5, $2505, 2
        frame_oam_tile $EC, 5, $2505, 2
        frame_oam_tile $E4, 5, $2505, 2
        frame_oam_tile $14, $F5, $2505, 2
        frame_oam_tile $C, $F5, $2505, 2
        frame_oam_tile 4, $F5, $2505, 2
        frame_oam_tile $FC, $F5, $2505, 2
        frame_oam_tile $F4, $F5, $2505, 2
        frame_oam_tile $EC, $F5, $2505, 2
        frame_oam_tile $E4, $F5, $2505, 2
        frame_oam_tile $14, $FD, 4, 2
        frame_oam_tile $C, $FD, $1605, 2
        frame_oam_tile 4, $FD, $1405, 2
        frame_oam_tile $FC, $FD, $1404, 2
        frame_oam_tile $F4, $FD, $1304, 2
        frame_oam_tile $EC, $FD, $104, 2
        frame_oam_tile $E4, $FD, $2705, 2
speed_zone_label_frame:
        .BYTE $20
        frame_oam_tile $1B, $F8, $3505, 2
        frame_oam_tile $ED, $F5, $3505, 2
        frame_oam_tile $D8, 5, $2505, 2
        frame_oam_tile $D8, $FD, $2505, 2
        frame_oam_tile $D8, $F5, $2505, 2
        frame_oam_tile $E0, $F5, $2505, 2
        frame_oam_tile $E8, $F5, $2505, 2
        frame_oam_tile $F0, $F5, $2505, 2
        frame_oam_tile $F8, $F5, $2505, 2
        frame_oam_tile 0, $F5, $2505, 2
        frame_oam_tile 8, $F5, $2505, 2
        frame_oam_tile $10, $F5, $2505, 2
        frame_oam_tile $18, $F5, $2505, 2
        frame_oam_tile $20, $F5, $2505, 2
        frame_oam_tile $20, $FD, $2505, 2
        frame_oam_tile $20, 5, $2505, 2
        frame_oam_tile $18, 5, $2505, 2
        frame_oam_tile $10, 5, $2505, 2
        frame_oam_tile 8, 5, $2505, 2
        frame_oam_tile 0, 5, $2505, 2
        frame_oam_tile $F8, 5, $2505, 2
        frame_oam_tile $F0, 5, $2505, 2
        frame_oam_tile $E8, 5, $2505, 2
        frame_oam_tile $E0, 5, $2505, 2
        frame_oam_tile $10, $FD, $2604, 2
        frame_oam_tile $18, $FD, $3204, 2
        frame_oam_tile 8, $FD, $1605, 2
        frame_oam_tile 0, $FD, $1405, 2
        frame_oam_tile $F8, $FD, $1404, 2
        frame_oam_tile $F0, $FD, $504, 2
        frame_oam_tile $E8, $FD, $2004, 2
        frame_oam_tile $E0, $FD, $1005, 2
.ENDIF
animation_frame_C5096D:.BYTE 1
		frame_oam_tile $F8, $F8, $2206, $22
animation_frame_C50973:.BYTE 1
		frame_oam_tile $F8, $F8, $2406, $22
animation_frame_C50979:.BYTE 1
		frame_oam_tile $F8, $F8, $2606, $22
animation_frame_C5097F:.BYTE 1
		frame_oam_tile $F8, $F8, 6, $22
animation_frame_C50985:.BYTE 1
		frame_oam_tile $F8, $F8, $206,	$22
animation_frame_C5098B:.BYTE 4
		frame_oam_tile 8, $F8,	$3705, $42
		frame_oam_tile $F0, $F8, $3705, 2
		frame_oam_tile $F8, $E8, $2005, $22
		frame_oam_tile $F8, $F8, $406,	$22
animation_frame_C509A0:.BYTE 4
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $A, $F8, $3705,	$42
		frame_oam_tile $EE, $F8, $3705, 2
		frame_oam_tile $F8, $E6, $2005, $22
animation_frame_C509B5:.BYTE 1
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C509BB:.BYTE 2
		frame_oam_tile $10, $F8, $2206, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C509C6:.BYTE 2
		frame_oam_tile $10, $F8, $2406, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C509D1:.BYTE 2
		frame_oam_tile $10, $F8, $2606, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C509DC:.BYTE 2
		frame_oam_tile $10, $F8, 6, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C509E7:.BYTE 2
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $206,	$22
animation_frame_C509F2:.BYTE 5
		frame_oam_tile $20, $F8, $3705, $42
		frame_oam_tile 8, $F8,	$3705, 2
		frame_oam_tile $10, $E8, $2005, $22
		frame_oam_tile $10, $F8, $406,	$22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50A0C:.BYTE 5
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $22, $F8, $3705, $42
		frame_oam_tile 6, $F8,	$3705, 2
		frame_oam_tile $10, $E6, $2005, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50A26:.BYTE 2
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50A31:.BYTE 3
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2206, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50A41:.BYTE 3
		frame_oam_tile $28, $F8, $2406, $22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50A51:.BYTE 3
		frame_oam_tile $28, $F8, $2606, $22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50A61:.BYTE 3
		frame_oam_tile $28, $F8, 6, $22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50A71:.BYTE 3
		frame_oam_tile $28, $F8, $206,	$22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50A81:.BYTE 6
		frame_oam_tile $38, $F8, $3705, $42
		frame_oam_tile $20, $F8, $3705, 2
		frame_oam_tile $28, $E8, $2005, $22
		frame_oam_tile $28, $F8, $406,	$22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50AA0:.BYTE 6
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $39, $F8, $3705, $42
		frame_oam_tile $1F, $F8, $3705, 2
		frame_oam_tile $28, $E7, $2005, $22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50ABF:.BYTE 3
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50ACF:.BYTE 4
		frame_oam_tile $40, $F8, $2206, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50AE4:.BYTE 4
		frame_oam_tile $40, $F8, $2406, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50AF9:.BYTE 4
		frame_oam_tile $40, $F8, $2606, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50B0E:.BYTE 4
		frame_oam_tile $40, $F8, 6, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50B23:.BYTE 4
		frame_oam_tile $40, $F8, $206,	$22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50B38:.BYTE 7
		frame_oam_tile $50, $F8, $3705, $42
		frame_oam_tile $38, $F8, $3705, 2
		frame_oam_tile $40, $E8, $2005, $22
		frame_oam_tile $40, $F8, $406,	$22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50B5C:.BYTE 7
		frame_oam_tile $40, $E6, $2005, $22
		frame_oam_tile $52, $F8, $3705, $42
		frame_oam_tile $36, $F8, $3705, 2
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50B80:.BYTE 4
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
animation_frame_C50B95:.BYTE 2
		frame_oam_tile 0, $F5,	$606, 2
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50BA0:.BYTE 3
		frame_oam_tile $F8, 3,	$1606, 2
		frame_oam_tile 0, $F5,	$706, 2
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50BB0:.BYTE 3
		frame_oam_tile $F8, 3,	$1706, 2
		frame_oam_tile 0, $F5,	$1706, 2
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50BC0:.BYTE 3
		frame_oam_tile $F8, 2,	$706, 2
		frame_oam_tile 0, $F5,	$1606, 2
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50BD0:.BYTE 2
		frame_oam_tile $F8, 3,	$606, 2
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50BDB:.BYTE 3
		frame_oam_tile $18, $F5, $606,	2
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50BEB:.BYTE 4
		frame_oam_tile $10, 3,	$1606, 2
		frame_oam_tile $18, $F5, $706,	2
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50C00:.BYTE 4
		frame_oam_tile $10, 3,	$1706, 2
		frame_oam_tile $18, $F5, $1706, 2
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50C15:.BYTE 4
		frame_oam_tile $10, 3,	$706, 2
		frame_oam_tile $18, $F5, $1606, 2
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50C2A:.BYTE 3
		frame_oam_tile $10, 3,	$606, 2
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50C3A:.BYTE 4
		frame_oam_tile $30, $F5, $606,	2
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50C4F:.BYTE 5
		frame_oam_tile $28, 2,	$1606, 2
		frame_oam_tile $30, $F5, $706,	2
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50C69:.BYTE 5
		frame_oam_tile $28, 3,	$1706, 2
		frame_oam_tile $30, $F6, $1706, 2
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50C83:.BYTE 5
		frame_oam_tile $28, 3,	$706, 2
		frame_oam_tile $30, $F5, $1606, 2
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50C9D:.BYTE 4
		frame_oam_tile $28, 3,	$606, 2
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50CB2:.BYTE 5
		frame_oam_tile $48, $F5, $606,	2
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50CCC:.BYTE 6
		frame_oam_tile $40, 3,	$1606, 2
		frame_oam_tile $48, $F5, $706,	2
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50CEB:.BYTE 6
		frame_oam_tile $40, 3,	$1706, 2
		frame_oam_tile $48, $F5, $1706, 2
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50D0A:.BYTE 6
		frame_oam_tile $40, 3,	$706, 2
		frame_oam_tile $48, $F5, $1606, 2
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50D29:.BYTE 5
		frame_oam_tile $40, 3,	$606, 2
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
.IFNDEF J
; Moved up
animation_frame_C50D43:.BYTE 0
.ENDIF
normal_zone_label:	.BYTE 1
		animation_frame normal_zone_label_frame, $FF
western_zone_label:	.BYTE 1
		animation_frame western_zone_label_frame, $FF
bomb_zone_label:	.BYTE 1
		animation_frame bomb_zone_label_frame, $FF
jump_zone_label:	.BYTE 1
		animation_frame jump_zone_label_frame, $FF
belt_zone_label:	.BYTE 1
		animation_frame belt_zone_label_frame, $FF
tunnel_zone_label:	.BYTE 1
		animation_frame tunnel_zone_label_frame, $FF
duel_zone_label:	.BYTE 1
		animation_frame duel_zone_label_frame, $FF
flower_zone_label:	.BYTE 1
		animation_frame flower_zone_label_frame, $FF
light_zone_label:	.BYTE 1
		animation_frame light_zone_label_frame, $FF
power_zone_label:	.BYTE 1
		animation_frame power_zone_label_frame, $FF
warp_zone_label:	.BYTE 1
		animation_frame warp_zone_label_frame, $FF
speed_zone_label:	.BYTE 1
		animation_frame speed_zone_label_frame, $FF
.IFDEF J
animation_frame_C50D43:.BYTE 0
.ENDIF
byte_C50D80:	.BYTE $F
		animation_frame animation_frame_C50D43, $20; 0
		animation_frame animation_frame_C5096D, 4; 1
		animation_frame animation_frame_C50973, 4; 2
		animation_frame animation_frame_C50979, 3; 3
		animation_frame animation_frame_C5097F, 3; 4
		animation_frame animation_frame_C50985, 2; 5
		animation_frame animation_frame_C5098B, 2; 6
		animation_frame animation_frame_C509A0, 2; 7
		animation_frame animation_frame_C509B5, $10; 8
		animation_frame animation_frame_C50B95, 5; 9
		animation_frame animation_frame_C50BA0, 5; $A
		animation_frame animation_frame_C50BB0, 5; $B
		animation_frame animation_frame_C50BC0, 5; $C
		animation_frame animation_frame_C50BD0, 5; $D
		animation_frame animation_frame_C509B5, $FF; $E
byte_C50DBD:	.BYTE $F
		animation_frame animation_frame_C509B5, $20; 0
		animation_frame animation_frame_C509BB, 4; 1
		animation_frame animation_frame_C509C6, 4; 2
		animation_frame animation_frame_C509D1, 3; 3
		animation_frame animation_frame_C509DC, 3; 4
		animation_frame animation_frame_C509E7, 2; 5
		animation_frame animation_frame_C509F2, 2; 6
		animation_frame animation_frame_C50A0C, 2; 7
		animation_frame animation_frame_C50A26, $10; 8
		animation_frame animation_frame_C50BDB, 5; 9
		animation_frame animation_frame_C50BEB, 5; $A
		animation_frame animation_frame_C50C00, 5; $B
		animation_frame animation_frame_C50C15, 5; $C
		animation_frame animation_frame_C50C2A, 5; $D
		animation_frame animation_frame_C50A26, $FF; $E
byte_C50DFA:	.BYTE $F
		animation_frame animation_frame_C50A26, $20; 0
		animation_frame animation_frame_C50A31, 4; 1
		animation_frame animation_frame_C50A41, 4; 2
		animation_frame animation_frame_C50A51, 3; 3
		animation_frame animation_frame_C50A61, 3; 4
		animation_frame animation_frame_C50A71, 2; 5
		animation_frame animation_frame_C50A81, 2; 6
		animation_frame animation_frame_C50AA0, 2; 7
		animation_frame animation_frame_C50ABF, $10; 8
		animation_frame animation_frame_C50C3A, 5; 9
		animation_frame animation_frame_C50C4F, 5; 10
		animation_frame animation_frame_C50C69, 5; 11
		animation_frame animation_frame_C50C83, 5; 12
		animation_frame animation_frame_C50C9D, 5; 13
		animation_frame animation_frame_C50ABF, $FF; 14
byte_C50E37:	.BYTE $F
		animation_frame animation_frame_C50ABF, $20; 0
		animation_frame animation_frame_C50ACF, 4; 1
		animation_frame animation_frame_C50AE4, 4; 2
		animation_frame animation_frame_C50AF9, 3; 3
		animation_frame animation_frame_C50B0E, 3; 4
		animation_frame animation_frame_C50B23, 2; 5
		animation_frame animation_frame_C50B38, 2; 6
		animation_frame animation_frame_C50B5C, 2; 7
		animation_frame animation_frame_C50B80, $10; 8
		animation_frame animation_frame_C50CB2, 5; 9
		animation_frame animation_frame_C50CCC, 5; 10
		animation_frame animation_frame_C50CEB, 5; 11
		animation_frame animation_frame_C50D0A, 5; 12
		animation_frame animation_frame_C50D29, 5; 13
		animation_frame animation_frame_C50B80, $FF; 14
animation_frame_C50E74:.BYTE 5
		frame_oam_tile $58, $F8, $2206, $22
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50E8E:.BYTE 5
		frame_oam_tile $58, $F8, $2406, $22
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50EA8:.BYTE 5
		frame_oam_tile $58, $F8, $2606, $22
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50EC2:.BYTE 5
		frame_oam_tile $58, $F8, 6, $22
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50EDC:.BYTE 5
		frame_oam_tile $58, $F8, $206,	$22
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50EF6:.BYTE 8
		frame_oam_tile $68, $F8, $3705, $42
		frame_oam_tile $50, $F8, $3705, 2
		frame_oam_tile $58, $E8, $2005, $22
		frame_oam_tile $58, $F8, $406,	$22
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50F1F:.BYTE 8
		frame_oam_tile $58, $F8, $2006, $22
		frame_oam_tile $58, $E6, $2005, $22
		frame_oam_tile $6A, $F8, $3705, $42
		frame_oam_tile $4E, $F8, $3705, 2
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50F48:.BYTE 5
		frame_oam_tile $58, $F8, $2006, $22
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C50F62:.BYTE 1
		frame_oam_tile $FC, $FC, $3205, 2
animation_frame_C50F68:.BYTE $32
stru_C50F69:	frame_oam_tile $A0, $64, $2402, $62
		frame_oam_tile $A0, $A0, $2402, $22
		frame_oam_tile $90, $50, $2602, $22
		frame_oam_tile $90, $60, $602,	$A2
		frame_oam_tile $90, $40, $2602, $22
		frame_oam_tile $90, $30, $2602, $22
		frame_oam_tile $90, $20, $2602, $22
		frame_oam_tile $90, $10, $2602, $22
		frame_oam_tile $90, 0,	$2602, $22
		frame_oam_tile $90, $F0, $2602, $22
		frame_oam_tile $90, $E0, $2602, $22
		frame_oam_tile $90, $D0, $2602, $22
		frame_oam_tile $90, $C0, $2602, $22
		frame_oam_tile $90, $B0, $2602, $22
		frame_oam_tile $90, $A0, $202,	$22
		frame_oam_tile $50, $64, $2402, $62
		frame_oam_tile $6C, $50, $2602, $A2
		frame_oam_tile $60, $60, $202,	$E2
		frame_oam_tile $40, $64, $2402, $62
		frame_oam_tile $30, $64, $2402, $62
		frame_oam_tile $20, $64, $2402, $62
		frame_oam_tile $10, $64, $2402, $62
		frame_oam_tile 0, $64,	$2402, $62
		frame_oam_tile $F0, $64, $2402, $62
		frame_oam_tile $E0, $64, $2402, $62
		frame_oam_tile $D0, $64, $2402, $62
		frame_oam_tile $C0, $64, $2402, $62
		frame_oam_tile $B0, $64, $2402, $62
		frame_oam_tile $6C, $30, $2602, $A2
		frame_oam_tile $6C, $20, $2602, $A2
		frame_oam_tile $6C, $10, $2602, $A2
		frame_oam_tile $6C, 0,	$2602, $A2
		frame_oam_tile $6C, $F0, $2602, $A2
		frame_oam_tile $6C, $E0, $2602, $A2
		frame_oam_tile $6C, $D0, $2602, $A2
		frame_oam_tile $6C, $C0, $2602, $A2
		frame_oam_tile $6C, $B0, $2602, $A2
		frame_oam_tile $6C, $40, $2602, $A2
		frame_oam_tile $60, $A0, $602,	$62
		frame_oam_tile $50, $A0, $2402, $22
		frame_oam_tile $40, $A0, $2402, $22
		frame_oam_tile $30, $A0, $2402, $22
		frame_oam_tile $20, $A0, $2402, $22
		frame_oam_tile $10, $A0, $2402, $22
		frame_oam_tile 0, $A0,	$2402, $22
		frame_oam_tile $F0, $A0, $2402, $22
		frame_oam_tile $E0, $A0, $2402, $22
		frame_oam_tile $D0, $A0, $2402, $22
		frame_oam_tile $C0, $A0, $2402, $22
		frame_oam_tile $B0, $A0, $2402, $22
animation_frame_C51063:.BYTE $32
		frame_oam_tile $A0, $64, $2402, $22
		frame_oam_tile $A0, $A0, $2402, $62
		frame_oam_tile $90, $50, $2602, $A2
		frame_oam_tile $90, $60, $202,	$A2
		frame_oam_tile $90, $A0, $602,	$22
		frame_oam_tile $90, $40, $2602, $A2
		frame_oam_tile $90, $30, $2602, $A2
		frame_oam_tile $90, $20, $2602, $A2
		frame_oam_tile $90, $10, $2602, $A2
		frame_oam_tile $90, 0,	$2602, $A2
		frame_oam_tile $90, $F0, $2602, $A2
		frame_oam_tile $90, $E0, $2602, $A2
		frame_oam_tile $90, $D0, $2602, $A2
		frame_oam_tile $90, $C0, $2602, $A2
		frame_oam_tile $90, $B0, $2602, $A2
		frame_oam_tile $6C, $50, $2602, $22
		frame_oam_tile $60, $60, $602,	$E2
		frame_oam_tile $50, $64, $2402, $22
		frame_oam_tile $40, $64, $2402, $22
		frame_oam_tile $30, $64, $2402, $22
		frame_oam_tile $20, $64, $2402, $22
		frame_oam_tile $10, $64, $2402, $22
		frame_oam_tile 0, $64,	$2402, $22
		frame_oam_tile $F0, $64, $2402, $22
		frame_oam_tile $E0, $64, $2402, $22
		frame_oam_tile $D0, $64, $2402, $22
		frame_oam_tile $C0, $64, $2402, $22
		frame_oam_tile $B0, $64, $2402, $22
		frame_oam_tile $60, $A0, $202,	$62
		frame_oam_tile $6C, $30, $2602, $22
		frame_oam_tile $6C, $20, $2602, $22
		frame_oam_tile $6C, $10, $2602, $22
		frame_oam_tile $6C, 0,	$2602, $22
		frame_oam_tile $6C, $F0, $2602, $22
		frame_oam_tile $6C, $E0, $2602, $22
		frame_oam_tile $6C, $D0, $2602, $22
		frame_oam_tile $6C, $C0, $2602, $22
		frame_oam_tile $6C, $B0, $2602, $22
		frame_oam_tile $6C, $40, $2602, $22
		frame_oam_tile $50, $A0, $2402, $62
		frame_oam_tile $40, $A0, $2402, $62
		frame_oam_tile $30, $A0, $2402, $62
		frame_oam_tile $20, $A0, $2402, $62
		frame_oam_tile $10, $A0, $2402, $62
		frame_oam_tile 0, $A0,	$2402, $62
		frame_oam_tile $F0, $A0, $2402, $62
		frame_oam_tile $E0, $A0, $2402, $62
		frame_oam_tile $D0, $A0, $2402, $62
		frame_oam_tile $C0, $A0, $2402, $62
		frame_oam_tile $B0, $A0, $2402, $62
animation_frame_C5115E:.BYTE $32
		frame_oam_tile $A0, $A0, $2002, $22
		frame_oam_tile $A0, $60, $2002, $A2
		frame_oam_tile $90, $50, $2202, $22
		frame_oam_tile $90, $60, $402,	$A2
		frame_oam_tile $90, $40, $2202, $22
		frame_oam_tile $90, $30, $2202, $22
		frame_oam_tile $90, $20, $2202, $22
		frame_oam_tile $90, $10, $2202, $22
		frame_oam_tile $90, 0,	$2202, $22
		frame_oam_tile $90, $F0, $2202, $22
		frame_oam_tile $90, $E0, $2202, $22
		frame_oam_tile $90, $D0, $2202, $22
		frame_oam_tile $90, $C0, $2202, $22
		frame_oam_tile $90, $B0, $2202, $22
		frame_oam_tile $90, $A0, $402,	$22
		frame_oam_tile $6C, $50, $2202, $22
		frame_oam_tile $60, $60, $402,	$E2
		frame_oam_tile $50, $60, $2002, $A2
		frame_oam_tile $40, $60, $2002, $A2
		frame_oam_tile $30, $60, $2002, $A2
		frame_oam_tile $20, $60, $2002, $A2
		frame_oam_tile $10, $60, $2002, $A2
		frame_oam_tile 0, $60,	$2002, $A2
		frame_oam_tile $F0, $60, $2002, $A2
		frame_oam_tile $E0, $60, $2002, $A2
		frame_oam_tile $D0, $60, $2002, $A2
		frame_oam_tile $C0, $60, $2002, $A2
		frame_oam_tile $B0, $60, $2002, $A2
		frame_oam_tile $50, $A0, $2002, $22
		frame_oam_tile $40, $A0, $2002, $22
		frame_oam_tile $30, $A0, $2002, $22
		frame_oam_tile $20, $A0, $2002, $22
		frame_oam_tile $10, $A0, $2002, $22
		frame_oam_tile 0, $A0,	$2002, $22
		frame_oam_tile $F0, $A0, $2002, $22
		frame_oam_tile $E0, $A0, $2002, $22
		frame_oam_tile $D0, $A0, $2002, $22
		frame_oam_tile $C0, $A0, $2002, $22
		frame_oam_tile $B0, $A0, $2002, $22
		frame_oam_tile $60, $A0, $402,	$62
		frame_oam_tile $6C, $B0, $2202, $22
		frame_oam_tile $6C, $C0, $2202, $22
		frame_oam_tile $6C, $D0, $2202, $22
		frame_oam_tile $6C, $E0, $2202, $22
		frame_oam_tile $6C, $F0, $2202, $22
		frame_oam_tile $6C, 0,	$2202, $22
		frame_oam_tile $6C, $10, $2202, $22
		frame_oam_tile $6C, $20, $2202, $22
		frame_oam_tile $6C, $30, $2202, $22
		frame_oam_tile $6C, $40, $2202, $22
animation_frame_C51259:.BYTE $24
		frame_oam_tile $B8, $18, $603,	$22
		frame_oam_tile $FA, $18, $401,	$22
		frame_oam_tile $EC, $18, $2401, $22
		frame_oam_tile $DE, $18, $2000, $22
		frame_oam_tile $D0, $18, $601,	$22
		frame_oam_tile $16, $18, $201,	$22
		frame_oam_tile 8, $18,	1, $22
		frame_oam_tile $1E, $38, $2000, $26
		frame_oam_tile $11, $38, 1, $26
		frame_oam_tile 4, $38,	$2400, $26
		frame_oam_tile $F7, $38, 1, $26
		frame_oam_tile $EA, $38, $2000, $26
		frame_oam_tile $D2, $38, $600,	$26
		frame_oam_tile $C5, $38, $400,	$26
		frame_oam_tile $B8, $38, $2600, $26
		frame_oam_tile $FA, $F8, $401,	$22
		frame_oam_tile $EC, $F8, $2401, $22
		frame_oam_tile $DE, $F8, $2000, $22
		frame_oam_tile $D0, $F8, $601,	$22
		frame_oam_tile $16, $F8, $201,	$22
		frame_oam_tile 8, $F8,	1, $22
		frame_oam_tile $FA, $D8, $401,	$22
		frame_oam_tile $EC, $D8, $2401, $22
		frame_oam_tile $DE, $D8, $2000, $22
		frame_oam_tile $D0, $D8, $601,	$22
		frame_oam_tile $16, $D8, $201,	$22
		frame_oam_tile 8, $D8,	1, $22
		frame_oam_tile $FA, $B8, $401,	$22
		frame_oam_tile $EC, $B8, $2401, $22
		frame_oam_tile $DE, $B8, $2000, $22
		frame_oam_tile $D0, $B8, $601,	$22
		frame_oam_tile $B8, $F8, $403,	$22
		frame_oam_tile $B8, $D8, $203,	$22
		frame_oam_tile $B8, $B8, 3, $22
		frame_oam_tile $16, $B8, $201,	$22
		frame_oam_tile 8, $B8,	1, $22
animation_frame_C5130E:.BYTE $D
		frame_oam_tile $CD, $B0, $600,	$A2
		frame_oam_tile $35, $B0, $2201, $22
		frame_oam_tile $27, $B0, $2600, $22
		frame_oam_tile $19, $B0, $2601, $22
		frame_oam_tile $B, $B0, $2401,	$22
		frame_oam_tile $FD, $B0, $600,	$22
		frame_oam_tile $E4, $B0, $2001, $22
		frame_oam_tile $D9, $B0, 0, $22
		frame_oam_tile $F2, $D0, 1, $22
		frame_oam_tile $E3, $D0, $2200, $22
		frame_oam_tile $D5, $D0, $2401, $22
		frame_oam_tile $C7, $D0, $2601, $22
		frame_oam_tile $B8, $D0, 2, $22
animation_frame_C51350:.BYTE $A
		frame_oam_tile $30, $F8, $607,	$20
		frame_oam_tile $20, $F8, $2407, $20
		frame_oam_tile $10, $F8, $407,	$20
		frame_oam_tile 0, $F8,	$2207, $20
		frame_oam_tile $40, $F8, $2607, $20
		frame_oam_tile $F0, $F8, $2007, $20
		frame_oam_tile $E0, $F8, $607,	$20
		frame_oam_tile $D0, $F8, $407,	$20
		frame_oam_tile $C0, $F8, $207,	$20
		frame_oam_tile $B0, $F8, 7, $20
animation_frame_C51383:.BYTE $10
		frame_oam_tile $B8, $38, $705,	0
		frame_oam_tile $B0, $38, $605,	0
		frame_oam_tile $B8, $40, $1705, 0
		frame_oam_tile $B0, $40, $1705, $40
		frame_oam_tile $B8, $20, $1505, 0
		frame_oam_tile $B0, $20, $1505, $40
		frame_oam_tile $B8, $18, $505,	0
		frame_oam_tile $B0, $18, $405,	0
		frame_oam_tile $B0, 0,	$1305, $40
		frame_oam_tile $B8, 0,	$1305, 0
		frame_oam_tile $B8, $F8, $305,	0
		frame_oam_tile $B0, $F8, $205,	0
		frame_oam_tile $B0, $E0, $1105, $40
		frame_oam_tile $B8, $E0, $1105, 0
		frame_oam_tile $B8, $D8, $105,	0
		frame_oam_tile $B0, $D8, 5, 0
animation_frame_C513D4:.BYTE 6
		frame_oam_tile $60, $F5, $606,	2
		frame_oam_tile $58, $F8, $2006, $22
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C513F3:.BYTE 7
		frame_oam_tile $58, 3,	$1606, 2
		frame_oam_tile $60, $F5, $706,	2
		frame_oam_tile $58, $F8, $2006, $22
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C51417:.BYTE 7
		frame_oam_tile $58, 3,	$1706, 2
		frame_oam_tile $60, $F5, $1706, 2
		frame_oam_tile $58, $F8, $2006, $22
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C5143B:.BYTE 7
		frame_oam_tile $58, 3,	$706, 2
		frame_oam_tile $60, $F5, $1606, 2
		frame_oam_tile $58, $F8, $2006, $22
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C5145F:.BYTE 6
		frame_oam_tile $58, 3,	$606, 2
		frame_oam_tile $58, $F8, $2006, $22
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C5147E:.BYTE 4
		frame_oam_tile $40, $F8, $2006, $22
		frame_oam_tile $28, $F8, $2006, $22
		frame_oam_tile $10, $F8, $2006, $22
		frame_oam_tile $F8, $F8, $2006, $22
animation_frame_C51493:.BYTE 2
		frame_oam_tile $FC, $FC, $3205, $82
		frame_oam_tile $F8, 0,	$2005, 0
animation_frame_C5149E:.BYTE 1
		frame_oam_tile $F8, $F8, $3702, 0
byte_C514A4:	.BYTE $F
		animation_frame animation_frame_C5147E, $20
		animation_frame animation_frame_C50E74, 4
		animation_frame animation_frame_C50E8E, 4
		animation_frame animation_frame_C50EA8, 3
		animation_frame animation_frame_C50EC2, 3
		animation_frame animation_frame_C50EDC, 2
		animation_frame animation_frame_C50EF6, 2
		animation_frame animation_frame_C50F1F, 2
		animation_frame animation_frame_C50F48, $10
		animation_frame animation_frame_C513D4, 5
		animation_frame animation_frame_C513F3, 5
		animation_frame animation_frame_C51417, 5
		animation_frame animation_frame_C5143B, 5
		animation_frame animation_frame_C5145F, 5
		animation_frame animation_frame_C50F48, $FF
byte_C514E1:
		.BYTE 2
		animation_frame animation_frame_C50F62, 2
		animation_frame animation_frame_C5149E, 2
byte_C514EA:
		.BYTE 4
		animation_frame animation_frame_C50F68, 4
		animation_frame animation_frame_C5115E, 2
		animation_frame animation_frame_C51063, 4
		animation_frame animation_frame_C5115E, 2
byte_C514FB:
		.BYTE 1
		animation_frame animation_frame_C51259, $FF
byte_C51500:
		.BYTE 1
		animation_frame animation_frame_C5130E, $FF
byte_C51505:
		.BYTE 1
		animation_frame animation_frame_C51350, $FF
byte_C5150A:
		.BYTE 1
		animation_frame animation_frame_C51383, $FF
byte_C5150F:
		.BYTE 2
		animation_frame animation_frame_C51493, 2
		animation_frame animation_frame_C5149E, 2
animation_frame_C51518:.BYTE $12
		frame_oam_tile $42, $FD, $1600, 0
		frame_oam_tile $3A, $FD, $500,	0
		frame_oam_tile $32, $FD, $1400, 0
		frame_oam_tile $2A, $FD, $1500, 0
		frame_oam_tile $24, $FD, $400,	0
		frame_oam_tile $1C, $FD, $1400, 0
		frame_oam_tile $17, $FD, $1100, 0
		frame_oam_tile $E4, $FD, $500,	0
		frame_oam_tile $DC, $FD, $1500, 0
		frame_oam_tile $D4, $FD, $1200, 0
		frame_oam_tile $CC, $FD, $1400, 0
		frame_oam_tile $C4, $FD, $1500, 0
		frame_oam_tile $10, $FD, $3003, 0
		frame_oam_tile 0, $FE,	$1300, 0
		frame_oam_tile $F8, $FD, $300,	0
		frame_oam_tile $BC, $FD, $200,	0
		frame_oam_tile $B7, $FD, $1100, 0
		frame_oam_tile $B0, $FD, $1000, 0
animation_frame_C51573:.BYTE $A
		frame_oam_tile $32, $F8, 2, $20
		frame_oam_tile $25, $F8, $2600, $20
		frame_oam_tile $19, $F8, $2001, $20
		frame_oam_tile $D, $F8, $2002,	$20
		frame_oam_tile $FD, $F8, $2201, $20
		frame_oam_tile $F1, $F8, $2001, $20
		frame_oam_tile $E4, $F8, $2600, $20
		frame_oam_tile $D8, $F8, $2400, $20
		frame_oam_tile $CC, $F8, $2200, $20
		frame_oam_tile $C0, $F8, $2000, $20
animation_frame_C515A6:.BYTE $A
		frame_oam_tile $32, $F8, 2, $20
		frame_oam_tile $26, $F8, 3, $20
		frame_oam_tile $1A, $F8, $2200, $20
		frame_oam_tile $D, $F8, $2600,	$20
		frame_oam_tile $FC, $F8, 2, $20
		frame_oam_tile $F0, $F8, $2201, $20
		frame_oam_tile $E4, $F8, $2601, $20
		frame_oam_tile $D8, $F8, $2601, $20
		frame_oam_tile $CC, $F8, $2001, $20
		frame_oam_tile $C0, $F8, $2401, $20
animation_frame_C515D9:.BYTE 8
		frame_oam_tile $14, $F8, 3, $20
		frame_oam_tile 8, $F8,	$2400, $20
		frame_oam_tile $FC, $F8, $2200, $20
		frame_oam_tile $F0, $F8, $602,	$20
		frame_oam_tile $E4, $F8, $402,	$20
		frame_oam_tile $D8, $F8, $402,	$20
		frame_oam_tile $CC, $F8, $2001, $20
		frame_oam_tile $C0, $F8, $202,	$20
animation_frame_C51602:.BYTE $12
		frame_oam_tile $C7, $F8, $100,	0
		frame_oam_tile $BD, $F8, 0, 0
		frame_oam_tile $B5, $F8, $3203, 0
		frame_oam_tile $48, $F8, $3203, 0
		frame_oam_tile $40, $F8, $3103, 0
		frame_oam_tile $38, $F8, $3702, 0
		frame_oam_tile $30, $F8, $3602, 0
		frame_oam_tile $25, $F8, $3003, 0
		frame_oam_tile $1D, $F8, $3702, 0
		frame_oam_tile $15, $F8, $3602, 0
		frame_oam_tile $D, $F8, $2303,	0
		frame_oam_tile 5, $F8,	$2203, 0
		frame_oam_tile $FD, $F8, $2103, 0
		frame_oam_tile $F1, $F8, $2003, 0
		frame_oam_tile $E9, $F8, $2702, 0
		frame_oam_tile $E1, $F8, $2702, 0
		frame_oam_tile $DB, $F8, $2602, 0
		frame_oam_tile $D0, $F8, $2402, 0
animation_frame_C5165D:.BYTE 1
		frame_oam_tile $FD, $FA, $2202, $20
animation_frame_C51663:.BYTE $E
		frame_oam_tile $28, $17, $2200, $20
		frame_oam_tile $1C, $17, $2000, $20
		frame_oam_tile $E9, $17, $402,	$20
		frame_oam_tile $DD, $17, 2, $20
		frame_oam_tile $D1, $17, $2403, $20
		frame_oam_tile $2A, 2,	$2603, $20
		frame_oam_tile $1E, 2,	2, $20
		frame_oam_tile $12, 2,	$603, $20
		frame_oam_tile 6, 2, $2000, $20
		frame_oam_tile $FC, 2,	$403, $20
		frame_oam_tile $F2, 2,	$2601, $20
		frame_oam_tile $E7, 2,	$2000, $20
		frame_oam_tile $DB, 2,	$2200, $20
		frame_oam_tile $CF, 2,	$203, $20
animation_frame_C516AA:.BYTE 1
		frame_oam_tile $F8, $F8, 4, $22
animation_frame_C516B0:.BYTE 1
		frame_oam_tile $F8, $F8, $204,	$22
animation_frame_C516B6:.BYTE 1
		frame_oam_tile $F8, $F8, $404,	$22
animation_frame_C516BC:.BYTE 1
		frame_oam_tile $F8, $F8, $604,	$22
animation_frame_C516C2:.BYTE 1
		frame_oam_tile $F8, $F8, $2004, $22
animation_frame_C516C8:.BYTE 1
		frame_oam_tile $F8, $F8, $2204, $22
animation_frame_C516CE:.BYTE 1
		frame_oam_tile $F8, $F8, $2404, $22
animation_frame_C516D4:.BYTE 1
		frame_oam_tile $F8, $F8, $2604, $22
animation_frame_C516DA:.BYTE $11
		frame_oam_tile $3A, $FC, $3203, 0
		frame_oam_tile $32, $FC, $3103, 0
		frame_oam_tile $2A, $FC, $3702, 0
		frame_oam_tile $22, $FC, $3602, 0
		frame_oam_tile $18, $FC, $3003, 0
		frame_oam_tile $10, $FC, $3702, 0
		frame_oam_tile 8, $FC,	$3602, 0
		frame_oam_tile 0, $FC,	$2303, 0
		frame_oam_tile $F8, $FC, $2203, 0
		frame_oam_tile $F0, $FC, $2103, 0
		frame_oam_tile $E1, $FC, $2003, 0
		frame_oam_tile $D9, $FC, $2702, 0
		frame_oam_tile $D1, $FC, $2702, 0
		frame_oam_tile $CB, $FC, $2602, 0
		frame_oam_tile $C8, $FB, $2502, 0
		frame_oam_tile $C0, 3,	$3402, 0
		frame_oam_tile $C0, $FB, $2402, 0
byte_C51730:
		.BYTE 1
		animation_frame animation_frame_C51518, $FF
byte_C51735:
		.BYTE 1
		animation_frame animation_frame_C51573, $FF
byte_C5173A:
		.BYTE 1
		animation_frame animation_frame_C515A6, $FF
byte_C5173F:	.BYTE 1
		animation_frame animation_frame_C515D9, $FF
byte_C51744:
		.BYTE 1
		animation_frame animation_frame_C51602, $FF
byte_C51749:	.BYTE 1
		animation_frame animation_frame_C5165D, $FF
byte_C5174E:	.BYTE 1
		animation_frame animation_frame_C51663, $FF
byte_C51753:	.BYTE 1
		animation_frame animation_frame_C516AA, $FF
byte_C51758:	.BYTE 1
		animation_frame animation_frame_C516B0, $FF
byte_C5175D:	.BYTE 1
		animation_frame animation_frame_C516B6, $FF
byte_C51762:	.BYTE 1
		animation_frame animation_frame_C516BC, $FF
byte_C51767:	.BYTE 1
		animation_frame animation_frame_C516C2, $FF
byte_C5176C:	.BYTE 1
		animation_frame animation_frame_C516C8, $FF
byte_C51771:	.BYTE 1
		animation_frame animation_frame_C516CE, $FF
byte_C51776:	.BYTE 1
		animation_frame animation_frame_C516D4, $FF
byte_C5177B:
		.BYTE 1
		animation_frame animation_frame_C516DA, $FF
animation_frame_C51780:.BYTE 6
		frame_oam_tile 8, 8, $202, 0
		frame_oam_tile $F8, 8,	2, $20
		frame_oam_tile 8, $F8,	$2200, $20
		frame_oam_tile $F8, $F8, $2000, $20
		frame_oam_tile 8, $E8,	$200, $20
		frame_oam_tile $F8, $E8, 0, $20
		.BYTE 6
		.BYTE 8, 7, 2, 2, 0
		.BYTE $F8, 7, 2, 0, $20
		.BYTE 8, $F7, 0, $22, $20
		.BYTE $F8, $F7,	0, $20,	$20
		.BYTE 8, $E7, 0, 2, $20
		.BYTE $F8, $E7,	0, 0, $20
animation_frame_C517BE:.BYTE 6
		frame_oam_tile 8, 8, $202, 0
		frame_oam_tile 8, $E8,	$600, $20
		frame_oam_tile $F8, $E8, $400,	$20
		frame_oam_tile $F8, 8,	2, $20
		frame_oam_tile 8, $F8,	$2200, $20
		frame_oam_tile $F8, $F8, $2000, $20
animation_frame_C517DD:.BYTE $A
		frame_oam_tile $F8, $E7, $2303, 0
		frame_oam_tile $F8, $EF, $3303, 0
		frame_oam_tile 8, $E7,	$2403, 0
		frame_oam_tile 8, $EF,	$3403, 0
		frame_oam_tile 0, $E7,	$500, 0
		frame_oam_tile 0, $EF,	$1500, 0
		frame_oam_tile 8, 7, $202, 0
		frame_oam_tile $F8, 7,	2, $20
		frame_oam_tile 8, $F7,	$2200, $20
		frame_oam_tile $F8, $F7, $2000, $20
animation_frame_C51810:.BYTE 6
		frame_oam_tile 8, 8, $202, 0
		frame_oam_tile 8, $E8,	$2600, $20
		frame_oam_tile $F8, $E8, $2400, $20
		frame_oam_tile $F8, 8,	2, $20
		frame_oam_tile 8, $F8,	$2200, $20
		frame_oam_tile $F8, $F8, $2000, $20
animation_frame_C5182F:.BYTE 6
		frame_oam_tile 8, 7, $202, 0
		frame_oam_tile 8, $E7,	$2600, $20
		frame_oam_tile $F8, $E7, $2400, $20
		frame_oam_tile $F8, 7,	2, $20
		frame_oam_tile 8, $F7,	$2200, $20
		frame_oam_tile $F8, $F7, $2000, $20
animation_frame_C5184E:.BYTE 6
		frame_oam_tile 8, 8, $202, 0
		frame_oam_tile 8, $F8,	$201, $20
		frame_oam_tile $F8, $F8, 1, $20
		frame_oam_tile 8, $E8,	$602, $20
		frame_oam_tile $F8, $E8, $402,	$20
		frame_oam_tile $F8, 8,	2, $20
animation_frame_C5186D:.BYTE 6
		frame_oam_tile 8, 7, $202, 0
		frame_oam_tile 8, $F7,	$201, $20
		frame_oam_tile $F8, $F7, 1, $20
		frame_oam_tile 8, $E7,	$602, $20
		frame_oam_tile $F8, $E7, $402,	$20
		frame_oam_tile $F8, 7,	2, $20
animation_frame_C5188C:.BYTE 6
		frame_oam_tile 8, 8, $202, 0
		frame_oam_tile 8, $E8,	$2201, $20
		frame_oam_tile $F8, $E8, $2001, $20
		frame_oam_tile 8, $F8,	$203, $20
		frame_oam_tile $F8, $F8, 3, $20
		frame_oam_tile $F8, 8,	2, $20
animation_frame_C518AB:.BYTE 6
		frame_oam_tile 8, 7, $202, 0
		frame_oam_tile 8, $E7,	$2201, $20
		frame_oam_tile $F8, $E7, $2001, $20
		frame_oam_tile 8, $F7,	$203, $20
		frame_oam_tile $F8, $F7, 3, $20
		frame_oam_tile $F8, 7,	2, $20
animation_frame_C518CA:.BYTE 6
		frame_oam_tile 8, 8, $202, 0
		frame_oam_tile 8, $E8,	$601, $20
		frame_oam_tile $F8, $E8, $401,	$20
		frame_oam_tile 8, $F8,	$2601, $20
		frame_oam_tile $F8, $F8, $2401, $20
		frame_oam_tile $F8, 8,	2, $20
animation_frame_C518E9:.BYTE 6
		frame_oam_tile 8, 7, $202, 0
		frame_oam_tile 8, $E7,	$601, $20
		frame_oam_tile $F8, $E7, $401,	$20
		frame_oam_tile 8, $F7,	$2601, $20
		frame_oam_tile $F8, $F7, $2401, $20
		frame_oam_tile $F8, 7,	2, $20
animation_frame_C51908:.BYTE 6
		frame_oam_tile 8, 8, $202, 0
		frame_oam_tile 8, $E8,	$603, $20
		frame_oam_tile $F8, $E8, $403,	$20
		frame_oam_tile 8, $F8,	$2202, $20
		frame_oam_tile $F8, $F8, $2002, $20
		frame_oam_tile $F8, 8,	2, $20
animation_frame_C51927:.BYTE 6
		frame_oam_tile 8, 7, $202, 0
		frame_oam_tile 8, $E7,	$603, $20
		frame_oam_tile $F8, $E7, $403,	$20
		frame_oam_tile 8, $F7,	$2202, $20
		frame_oam_tile $F8, $F7, $2002, $20
		frame_oam_tile $F8, 7,	2, $20
animation_frame_C51946:.BYTE 7
		frame_oam_tile 8, $F8,	$2203, 0
		frame_oam_tile 8, 0, $3203, 0
		frame_oam_tile 8, 8, $202, 0
		frame_oam_tile 8, $E8,	$2602, $20
		frame_oam_tile $F8, $E8, $2402, $20
		frame_oam_tile $F8, $F8, $2003, $20
		frame_oam_tile $F8, 8,	2, $20
animation_frame_C5196A:.BYTE 7
		frame_oam_tile 8, $F7,	$2203, 0
		frame_oam_tile 8, $FF,	$3203, 0
		frame_oam_tile 8, 7, $202, 0
		frame_oam_tile 8, $E7,	$2602, $20
		frame_oam_tile $F8, $E7, $2402, $20
		frame_oam_tile $F8, $F7, $2003, $20
		frame_oam_tile $F8, 7,	2, $20
animation_frame_C5198E:.BYTE 6
		frame_oam_tile 0, $F0,	$3503, 0
		frame_oam_tile 8, 8, $202, 0
		frame_oam_tile 8, 0, $1302, 0
		frame_oam_tile 8, $F8,	$302, 0
		frame_oam_tile $F8, $F8, $2603, $20
		frame_oam_tile $F8, 8,	2, $20
animation_frame_C519AD:.BYTE 6
		frame_oam_tile 0, $EF,	$3503, 0
		frame_oam_tile 8, 7, $202, 0
		frame_oam_tile 8, $FF,	$1302, 0
		frame_oam_tile 8, $F7,	$302, 0
		frame_oam_tile $F8, $F7, $2603, $20
		frame_oam_tile $F8, 7,	2, $20
byte_C519CC:	.BYTE 1
		animation_frame animation_frame_C51780, $FF
byte_C519D1:	.BYTE $10
		animation_frame animation_frame_C517BE, 8
		animation_frame animation_frame_C517DD, 8
		animation_frame animation_frame_C51810, 8
		animation_frame animation_frame_C5182F, 8
		animation_frame animation_frame_C5184E, 8
		animation_frame animation_frame_C5186D, 8
		animation_frame animation_frame_C5188C, 8
		animation_frame animation_frame_C518AB, 8
		animation_frame animation_frame_C518CA, 8
		animation_frame animation_frame_C518E9, 8
		animation_frame animation_frame_C51908, 8
		animation_frame animation_frame_C51927, 8
		animation_frame animation_frame_C51946, 8
		animation_frame animation_frame_C5196A, 8
		animation_frame animation_frame_C5198E, 8
		animation_frame animation_frame_C519AD, 8
byte_C51A12:	.BYTE 1
		animation_frame animation_frame_C5198E, $FF
byte_C51A17:	.BYTE 2
		animation_frame animation_frame_C517BE, 8
		animation_frame animation_frame_C517DD, 8
animation_frame_C51A20:.BYTE $34
		frame_oam_tile 0, $F4,	$602, $20
		frame_oam_tile 0, 4, $2602, $20
		frame_oam_tile 0, $34,	$2001, $62
		frame_oam_tile 0, $24,	1, $62
		frame_oam_tile $20, $34, $2400, $62
		frame_oam_tile $20, $24, $400,	$62
		frame_oam_tile $10, $34, $2600, $62
		frame_oam_tile $10, $24, $600,	$62
		frame_oam_tile $10, $14, $2004, $62
		frame_oam_tile $10, 4,	4, $60
		frame_oam_tile 0, $14,	$2204, $62
		frame_oam_tile $20, $F4, $2402, $62
		frame_oam_tile $20, $E4, $402,	$62
		frame_oam_tile $10, $F4, $2002, $62
		frame_oam_tile $18, $EC, $1002, $42
		frame_oam_tile $18, $E4, 2, $42
		frame_oam_tile $10, $EC, $1102, $40
		frame_oam_tile $10, $E4, $102,	$40
		frame_oam_tile 0, $E4,	$202, $60
		frame_oam_tile 0, $D4,	$2200, $60
		frame_oam_tile $10, $D4, $2000, $60
		frame_oam_tile $10, $C4, 0, $60
		frame_oam_tile 0, $CC,	$1300, $40
		frame_oam_tile 8, $CC,	$1200, $40
		frame_oam_tile 8, $C4,	$200, $40
		frame_oam_tile 0, $C4,	$300, $42
		frame_oam_tile $F0, $34, $2001, $22
		frame_oam_tile $E0, $34, $2600, $22
		frame_oam_tile $D0, $34, $2400, $22
		frame_oam_tile $F0, $24, 1, $22
		frame_oam_tile $E0, $24, $600,	$22
		frame_oam_tile $D0, $24, $400,	$22
		frame_oam_tile $F0, $14, $2204, $22
		frame_oam_tile $E0, $14, $2004, $22
		frame_oam_tile $F0, 4,	$204, $20
		frame_oam_tile $E0, 4,	4, $20
		frame_oam_tile $F0, $F4, $2202, $20
		frame_oam_tile $D0, $F4, $2402, $22
		frame_oam_tile $D0, $E4, $402,	$22
		frame_oam_tile $E0, $F4, $2002, $22
		frame_oam_tile $F0, $E4, $202,	$20
		frame_oam_tile $F0, $D4, $2200, $20
		frame_oam_tile $F8, $CC, $1300, 0
		frame_oam_tile $F8, $C4, $300,	2
		frame_oam_tile $F0, $CC, $1200, 0
		frame_oam_tile $F0, $C4, $200,	0
		frame_oam_tile $E8, $EC, $1102, 0
		frame_oam_tile $E8, $E4, $102,	0
		frame_oam_tile $E0, $EC, $1002, 2
		frame_oam_tile $E0, $E4, 2, 2
		frame_oam_tile $E0, $D4, $2000, $20
		frame_oam_tile $E0, $C4, 0, $20
animation_frame_C51B25:.BYTE $21
		frame_oam_tile $50, $F8, $701,	4
		frame_oam_tile $B0, 8,	$2605, $24
		frame_oam_tile $20, 8,	$201, $24
		frame_oam_tile $C0, 8,	6, $24
		frame_oam_tile $D0, 8,	$206, $24
		frame_oam_tile $E0, 8,	$406, $24
		frame_oam_tile $F0, 8,	$606, $24
		frame_oam_tile 0, 8, $2006, $24
		frame_oam_tile $10, 8,	$2603, $24
		frame_oam_tile $48, $F0, $1701, 4
		frame_oam_tile $40, $F0, $1601, 4
		frame_oam_tile $40, $F8, $2601, $24
		frame_oam_tile $40, 8,	$603, $24
		frame_oam_tile $30, $18, $2403, $24
		frame_oam_tile $30, 8,	$403, $24
		frame_oam_tile $30, $F8, $2401, $24
		frame_oam_tile $30, $E8, $401,	$24
		frame_oam_tile $20, $E8, $2005, $24
		frame_oam_tile $10, $E8, $2604, $24
		frame_oam_tile 0, $E8,	$2404, $24
		frame_oam_tile $F0, $E8, $605,	$24
		frame_oam_tile $E0, $E8, $405,	$24
		frame_oam_tile $D0, $E8, $205,	$24
		frame_oam_tile $C0, $E8, 5, $24
		frame_oam_tile $B0, $E8, $604,	$24
		frame_oam_tile $20, $F8, $2405, $24
		frame_oam_tile $10, $F8, $2205, $24
		frame_oam_tile 0, $F8,	$404, $24
		frame_oam_tile $F0, $F8, $2203, $24
		frame_oam_tile $E0, $F8, $2003, $24
		frame_oam_tile $D0, $F8, $203,	$24
		frame_oam_tile $C0, $F8, 3, $24
		frame_oam_tile $B0, $F8, $2201, $24
byte_C51BCB:	.BYTE 1
		animation_frame animation_frame_C51A20, $FF
byte_C51BD0:	.BYTE 1
		animation_frame animation_frame_C51B25, $FF
animation_frame_C51BD5:.BYTE 2
		frame_oam_tile $F8, 0,	$200, $20
		frame_oam_tile $F8, $F0, 0, $20
animation_frame_C51BE0:.BYTE 2
		frame_oam_tile $F8, 0,	$200, $60
		frame_oam_tile $F8, $F0, 0, $60
byte_C51BEB:
		.BYTE 1
		animation_frame animation_frame_C51BD5, $FF
byte_C51BF0:
		.BYTE 1
		animation_frame animation_frame_C51BE0, $FF
animation_frame_C51BF5:.BYTE 7
		frame_oam_tile 8, $C, $600, 0
		frame_oam_tile 0, $C, $500, 0
		frame_oam_tile $F8, $C, $400, 0
		frame_oam_tile 8, 4, $3200, 0
		frame_oam_tile 8, $FC,	$2200, 0
		frame_oam_tile $F8, $FC, $2000, $20
		frame_oam_tile $FB, $EC, 0, $22
animation_frame_C51C19:.BYTE $D
		frame_oam_tile 3, $EC,	$300, 2
		frame_oam_tile $FB, $EC, $200,	2
		frame_oam_tile 3, $F4,	$1100, 2
		frame_oam_tile $FB, $F4, $1000, 2
		frame_oam_tile 8, $C, $1600, 0
		frame_oam_tile 0, $C, $1500, 0
		frame_oam_tile $F8, $C, $1400,	0
		frame_oam_tile $F8, 4,	$3400, 0
		frame_oam_tile $F8, $FC, $2400, 0
		frame_oam_tile 8, 4, $2300, 0
		frame_oam_tile 8, $FC,	$1300, 0
		frame_oam_tile 0, 4, $3100, 0
		frame_oam_tile 0, $FC,	$2100, 0
animation_frame_C51C5B:.BYTE $D
		frame_oam_tile 8, $B, $1600, 0
		frame_oam_tile 0, $B, $1500, 0
		frame_oam_tile $F8, $B, $1400,	0
		frame_oam_tile $F8, 3,	$3400, 0
		frame_oam_tile $F8, $FB, $2400, 0
		frame_oam_tile 8, 3, $2300, 0
		frame_oam_tile 8, $FB,	$1300, 0
		frame_oam_tile 0, 3, $3100, 0
		frame_oam_tile 0, $FB,	$2100, 0
		frame_oam_tile 3, $EB,	$300, 2
		frame_oam_tile $FB, $EB, $200,	2
		frame_oam_tile 3, $F3,	$1100, 2
		frame_oam_tile $FB, $F3, $1000, 2
byte_C51C9D:	.BYTE 4
		animation_frame animation_frame_C51BF5, 4
		animation_frame animation_frame_C51C19, 2
		animation_frame animation_frame_C51C5B, 1
		animation_frame animation_frame_C51C19, 1
animation_frame_C51CAE:.BYTE 1
		frame_oam_tile $F8, $F8, $2002, $20
byte_C51CB4:	.BYTE 0
byte_C51CB5:	.BYTE 2
		animation_frame animation_frame_C51CAE, 2
		animation_frame byte_C51CB4, 2
animation_frame_C51CBE:.BYTE $C
		frame_oam_tile $20, 8,	$2201, $24
		frame_oam_tile $10, 8,	$2001, $24
		frame_oam_tile 0, 8, $2600, $24
		frame_oam_tile $F0, 8,	$2400, $24
		frame_oam_tile $E0, 8,	$2200, $24
		frame_oam_tile $D0, 8,	$2000, $24
		frame_oam_tile $20, $F8, $201,	$24
		frame_oam_tile $10, $F8, 1, $24
		frame_oam_tile 0, $F8,	$600, $24
		frame_oam_tile $F0, $F8, $400,	$24
		frame_oam_tile $E0, $F8, $200,	$24
		frame_oam_tile $D0, $F8, 0, $24
animation_frame_C51CFB:.BYTE $12
		frame_oam_tile $C8, 8,	$401, 4
		frame_oam_tile $D0, 8,	$501, 4
		frame_oam_tile $D8, 8,	$601, 4
		frame_oam_tile $E0, 8,	$701, 4
		frame_oam_tile $E8, 8,	$1401, 4
		frame_oam_tile $F0, 8,	$1501, 4
		frame_oam_tile $F8, 8,	$1601, 4
		frame_oam_tile 0, 8, $1701, 4
		frame_oam_tile 8, 8, $2401, $24
		frame_oam_tile $18, 8,	$2601, $24
		frame_oam_tile $28, 8,	$2603, $24
		frame_oam_tile $28, $F8, $2403, $24
		frame_oam_tile $18, $F8, $2203, $24
		frame_oam_tile 8, $F8,	$2003, $24
		frame_oam_tile $F8, $F8, $603,	$24
		frame_oam_tile $E8, $F8, $403,	$24
		frame_oam_tile $D8, $F8, $203,	$24
		frame_oam_tile $C8, $F8, 3, $24
animation_frame_C51D56:.BYTE 0
byte_C51D57:	.BYTE 2
		animation_frame animation_frame_C51CBE, 4
		animation_frame animation_frame_C51D56, 1
byte_C51D60:	.BYTE 1
		animation_frame animation_frame_C51CFB, $FF
animation_frame_C51D65:.BYTE 4
		frame_oam_tile 0, 0, 2, $E0
		frame_oam_tile $F0, 0,	2, $A0
		frame_oam_tile 0, $F0,	2, $60
		frame_oam_tile $F0, $F0, 2, $20
animation_frame_C51D7A:.BYTE 4
		frame_oam_tile 0, 0, $202, $E0
		frame_oam_tile $F0, 0,	$202, $A0
		frame_oam_tile 0, $F0,	$202, $60
		frame_oam_tile $F0, $F0, $202,	$20
animation_frame_C51D8F:.BYTE 4
		frame_oam_tile 0, 0, $402, $E0
		frame_oam_tile $F0, 0,	$402, $A0
		frame_oam_tile 0, $F0,	$402, $60
		frame_oam_tile $F0, $F0, $402,	$20
animation_frame_C51DA4:.BYTE 4
		frame_oam_tile 1, 1, $602, $E0
		frame_oam_tile $EF, 1,	$602, $A0
		frame_oam_tile 1, $EF,	$602, $60
		frame_oam_tile $EF, $EF, $602,	$20
byte_C51DB9:	.BYTE 4
		animation_frame animation_frame_C51D65, 4
		animation_frame animation_frame_C51D7A, 5
		animation_frame animation_frame_C51D8F, 4
		animation_frame animation_frame_C51DA4, 3
peace_town_unshaded_soft_animation:.BYTE $1C
		.WORD 0, 0, 0, 0, 0, 0,	0
		.WORD $40, $40,	$40, $40, $40, $40, $40
		.WORD $80, $80,	$80, $80, $80, $80, $80
		.WORD $C0, $C0,	$C0, $C0, $C0, $C0, $C0
peace_town_shaded_soft_animation:.BYTE $1C
		.WORD $100, $100, $100,	$100, $100, $100, $100
		.WORD $140, $140, $140,	$140, $140, $140, $140
		.WORD $180, $180, $180,	$180, $180, $180, $180
		.WORD $1C0, $1C0, $1C0,	$1C0, $1C0, $1C0, $1C0
byte_C51E3C:	.BYTE $D8
word_C51E3D:	.WORD $400, $400, $400,	$400, $400, $400, $400
		.WORD $400, $400, $400,	$400, $400, $400, $400
		.WORD $400, $400, $400,	$400, $400, $400, $400
		.WORD $400, $400, $400,	$400, $400, $400, $400
		.WORD $400, $400, $400,	$400, $400, $400, $400
		.WORD $400, $400, $400,	$400, $400, $400, $400
		.WORD $440, $440, $480,	$480, $4C0, $4C0, $4C0
		.WORD $4C0, $4C0, $4C0,	$4C0, $4C0, $4C0, $4C0
		.WORD $4C0, $4C0, $4C0,	$4C0, $4C0, $4C0, $4C0
		.WORD $4C0, $4C0, $4C0,	$4C0, $4C0, $4C0, $4C0
		.WORD $4C0, $4C0, $4C0,	$4C0, $4C0, $4C0, $4C0
		.WORD $4C0, $4C0, $4C0,	$4C0, $4C0, $4C0, $4C0
		.WORD $4C0, $4C0, $4C0,	$4C0, $480, $480, $480
		.WORD $480, $480, $480,	$480, $480, $480, $480
		.WORD $440, $440, $440,	$440, $440, $440, $440
		.WORD $440, $440, $440,	$400, $400, $400, $400
		.WORD $400, $400, $400,	$400, $400, $400, $400
		.WORD $400, $400, $400,	$400, $400, $400, $400
		.WORD $400, $400, $400,	$400, $400, $400, $400
		.WORD $400, $400, $400,	$400, $400, $400, $400
		.WORD $400, $400, $400,	$400, $400, $400, $400
		.WORD $400, $400, $400,	$500, $500, $540, $540
		.WORD $580, $580, $580,	$580, $580, $580, $580
		.WORD $580, $580, $580,	$580, $580, $580, $580
		.WORD $580, $580, $580,	$580, $580, $580, $580
		.WORD $580, $580, $580,	$580, $580, $580, $580
		.WORD $580, $580, $580,	$580, $580, $580, $580
		.WORD $580, $580, $580,	$580, $580, $580, $580
		.WORD $540, $540, $540,	$540, $540, $540, $540
		.WORD $540, $540, $540,	$500, $500, $500, $500
		.WORD $500, $500, $500,	$500, $500, $500
byte_C51FED:	.BYTE $F
		.WORD $5C0, $5C0, $5C0,	$800, $800, $800, $840
		.WORD $840, $840, $880,	$880, $880, $8C0, $8C0
		.WORD $8C0
byte_C5200C:	.BYTE $F
		.WORD $900, $900, $900,	$940, $940, $940, $980
		.WORD $980, $980, $9C0,	$9C0, $9C0, $C00, $C00
		.WORD $C00
		.BYTE $72
		.WORD $1100, $1100, $1100, $1100, $1100, $1100,	$1100
		.WORD $1100, $1100, $1100, $1100, $1100, $1100,	$1100
		.WORD $1100, $1100, $1100, $1100, $1100, $1100,	$1100
		.WORD $1100, $1100, $1100, $1100, $1100, $1100,	$1100
		.WORD $1100, $1100, $1100, $1100, $1100, $1100,	$1100
		.WORD $1100, $1100, $1100, $1100, $1100, $1100,	$1100
		.WORD $1100, $1100, $1100, $1100, $1100, $1100,	$1140
		.WORD $1140, $1140, $1140, $1140, $1140, $1140,	$1140
		.WORD $1140, $1180, $1180, $1180, $1180, $1180,	$1180
		.WORD $1180, $1180, $1180, $1180, $1180, $1180,	$1180
		.WORD $1180, $1180, $1180, $1180, $1180, $1180,	$1180
		.WORD $1180, $1180, $1180, $1180, $1180, $1180,	$1180
		.WORD $1180, $1180, $1180, $1180, $1180, $1180,	$1180
		.WORD $1180, $1180, $1180, $1180, $1180, $1180,	$1180
		.WORD $1180, $1180, $1180, $1180, $1180, $1180,	$1180
		.WORD $1140, $1140, $1140, $1140, $1140, $1140,	$1140
		.WORD $1140, $1140
		.BYTE $72
		.WORD $11C0, $11C0, $11C0, $11C0, $11C0, $11C0,	$11C0
		.WORD $11C0, $11C0, $11C0, $11C0, $11C0, $11C0,	$11C0
		.WORD $11C0, $11C0, $11C0, $11C0, $11C0, $11C0,	$11C0
		.WORD $11C0, $11C0, $11C0, $11C0, $11C0, $11C0,	$11C0
		.WORD $11C0, $11C0, $11C0, $11C0, $11C0, $11C0,	$11C0
		.WORD $11C0, $11C0, $11C0, $11C0, $11C0, $11C0,	$11C0
		.WORD $11C0, $11C0, $11C0, $11C0, $11C0, $11C0,	$1400
		.WORD $1400, $1400, $1400, $1400, $1400, $1400,	$1400
		.WORD $1400, $1440, $1440, $1440, $1440, $1440,	$1440
		.WORD $1440, $1440, $1440, $1440, $1440, $1440,	$1440
		.WORD $1440, $1440, $1440, $1440, $1440, $1440,	$1440
		.WORD $1440, $1440, $1440, $1440, $1440, $1440,	$1440
		.WORD $1440, $1440, $1440, $1440, $1440, $1440,	$1440
		.WORD $1440, $1440, $1440, $1440, $1440, $1440,	$1440
		.WORD $1440, $1440, $1440, $1440, $1440, $1440,	$1440
		.WORD $1400, $1400, $1400, $1400, $1400, $1400,	$1400
		.WORD $1400, $1400
		.BYTE $82
		.WORD $1480, $1480, $1480, $1480, $1480, $1480,	$1480
		.WORD $1480, $1480, $1480, $1480, $1480, $1480,	$1480
		.WORD $1480, $1480, $1480, $1480, $1480, $1480,	$1480
		.WORD $1480, $1480, $1480, $1480, $1480, $1480,	$1480
		.WORD $1480, $1480, $1480, $1480, $1480, $1480,	$1480
		.WORD $1480, $1480, $1480, $1480, $1480, $1480,	$1480
		.WORD $1480, $1480, $1480, $1480, $1480, $1480,	$1480
		.WORD $1480, $1480, $1480, $1480, $1480, $1480,	$1480
		.WORD $1480, $1480, $1480, $1480, $1480, $1480,	$1480
		.WORD $1480, $1480, $1480, $1480, $1480, $1480,	$1480
		.WORD $1480, $1480, $1480, $1480, $1480, $1480,	$1480
		.WORD $1480, $1480, $1480, $14C0, $14C0, $14C0,	$14C0
		.WORD $14C0, $1500, $1500, $1540, $1540, $1580,	$1580
		.WORD $1580, $1580, $1580, $1580, $1580, $1580,	$1580
		.WORD $1580, $1580, $1580, $1580, $1580, $1580,	$1580
		.WORD $1580, $1580, $1580, $1580, $1580, $1580,	$1580
		.WORD $1580, $1580, $1580, $1580, $1580, $1580,	$1580
		.WORD $1580, $1580, $1540, $1540, $1500, $1500,	$14C0
		.WORD $14C0, $14C0, $14C0, $14C0
byte_C522FA:	.BYTE $82
word_C522FB:	.WORD $15C0, $15C0, $15C0, $15C0, $15C0, $15C0,	$15C0
		.WORD $15C0, $15C0, $15C0, $15C0, $15C0, $15C0,	$15C0
		.WORD $15C0, $15C0, $15C0, $15C0, $15C0, $15C0,	$15C0
		.WORD $15C0, $15C0, $15C0, $15C0, $15C0, $15C0,	$15C0
		.WORD $15C0, $15C0, $15C0, $15C0, $15C0, $15C0,	$15C0
		.WORD $15C0, $15C0, $15C0, $15C0, $15C0, $15C0,	$15C0
		.WORD $15C0, $15C0, $15C0, $15C0, $15C0, $15C0,	$15C0
		.WORD $15C0, $15C0, $15C0, $15C0, $15C0, $15C0,	$15C0
		.WORD $15C0, $15C0, $15C0, $15C0, $15C0, $15C0,	$15C0
		.WORD $15C0, $15C0, $15C0, $15C0, $15C0, $15C0,	$15C0
		.WORD $15C0, $15C0, $15C0, $15C0, $15C0, $15C0,	$15C0
		.WORD $15C0, $15C0, $15C0, $1800, $1800, $1800,	$1800
		.WORD $1800, $1840, $1840, $1880, $1880, $18C0,	$18C0
		.WORD $18C0, $18C0, $18C0, $18C0, $18C0, $18C0,	$18C0
		.WORD $18C0, $18C0, $18C0, $18C0, $18C0, $18C0,	$18C0
		.WORD $18C0, $18C0, $18C0, $18C0, $18C0, $18C0,	$18C0
		.WORD $18C0, $18C0, $18C0, $18C0, $18C0, $18C0,	$18C0
		.WORD $18C0, $18C0, $1880, $1880, $1840, $1840,	$1800
		.WORD $1800, $1800, $1800, $1800
byte_C523FF:	.BYTE $82
		.WORD $1900, $1900, $1900, $1900, $1900, $1900,	$1900
		.WORD $1900, $1900, $1900, $1900, $1900, $1900,	$1900
		.WORD $1900, $1900, $1900, $1900, $1900, $1900,	$1900
		.WORD $1900, $1900, $1900, $1900, $1900, $1900,	$1900
		.WORD $1900, $1900, $1900, $1900, $1900, $1900,	$1900
		.WORD $1900, $1900, $1900, $1900, $1900, $1900,	$1900
		.WORD $1900, $1900, $1900, $1900, $1900, $1900,	$1900
		.WORD $1900, $1900, $1900, $1900, $1900, $1900,	$1900
		.WORD $1900, $1900, $1900, $1900, $1900, $1900,	$1900
		.WORD $1900, $1900, $1900, $1900, $1900, $1900,	$1900
		.WORD $1900, $1900, $1900, $1900, $1900, $1900,	$1900
		.WORD $1900, $1900, $1900, $1940, $1940, $1940,	$1940
		.WORD $1940, $1980, $1980, $19C0, $19C0, $1C00,	$1C00
		.WORD $1C00, $1C00, $1C00, $1C00, $1C00, $1C00,	$1C00
		.WORD $1C00, $1C00, $1C00, $1C00, $1C00, $1C00,	$1C00
		.WORD $1C00, $1C00, $1C00, $1C00, $1C00, $1C00,	$1C00
		.WORD $1C00, $1C00, $1C00, $1C00, $1C00, $1C00,	$1C00
		.WORD $1C00, $1C00, $19C0, $19C0, $1980, $1980,	$1940
		.WORD $1940, $1940, $1940, $1940
byte_C52504:	.BYTE $30
		.WORD $1C40, $1C40, $1C40, $1C40, $1C80, $1C80,	$1C80
		.WORD $1C80, $1CC0, $1CC0, $1CC0, $1CC0, $1D00,	$1D00
		.WORD $1D00, $1D00, $1D40, $1D40, $1D40, $1D40,	$1D80
		.WORD $1D80, $1D80, $1D80, $1DC0, $1DC0, $1DC0,	$1DC0
		.WORD $2000, $2000, $2000, $2000, $2040, $2040,	$2040
		.WORD $2040, $2080, $2080, $2080, $2080, $20C0,	$20C0
		.WORD $20C0, $20C0, $2100, $2100, $2100, $2100
byte_C52565:	.BYTE $91
		.WORD $2400, $2400, $2400, $2400, $2400, $2400,	$2400
		.WORD $2400, $2400, $2400, $2400, $2400, $2400,	$2400
		.WORD $2400, $2400, $2400, $2400, $2400, $2400,	$2400
		.WORD $2400, $2400, $2400, $2400, $2400, $2400,	$2400
		.WORD $2400, $2400, $2400, $2400, $2400, $2400,	$2400
		.WORD $2400, $2400, $2400, $2400, $2400, $2400,	$2400
		.WORD $2400, $2400, $2400, $2400, $2400, $2400,	$2400
		.WORD $2400, $2400, $2400, $2400, $2400, $2400,	$2400
		.WORD $2400, $2400, $2400, $2400, $2400, $2400,	$2400
		.WORD $2400, $2400, $2400, $2400, $2400, $2400,	$2400
		.WORD $2400, $2400, $2400, $2400, $2400, $2400,	$2400
		.WORD $2400, $2400, $2400, $2440, $2440, $2440,	$2440
		.WORD $2440, $2480, $2480, $2480, $2480, $2480,	$2440
		.WORD $2440, $2440, $2440, $2440, $2480, $2480,	$2480
		.WORD $2480, $2480, $2440, $2440, $2440, $2440,	$2440
		.WORD $2480, $2480, $2480, $2480, $2480, $2440,	$2440
		.WORD $2440, $2440, $2440, $2480, $2480, $2480,	$2480
		.WORD $2480, $2440, $2440, $2440, $2440, $2440,	$2480
		.WORD $2480, $2480, $2480, $2480, $2440, $2440,	$2440
		.WORD $2440, $2440, $2480, $2480, $2480, $2480,	$2480
		.WORD $2440, $2440, $2440, $2440, $2440
byte_C52688:	.BYTE $91
		.WORD $24C0, $24C0, $24C0, $24C0, $24C0, $24C0,	$24C0
		.WORD $24C0, $24C0, $24C0, $24C0, $24C0, $24C0,	$24C0
		.WORD $24C0, $24C0, $24C0, $24C0, $24C0, $24C0,	$24C0
		.WORD $24C0, $24C0, $24C0, $24C0, $24C0, $24C0,	$24C0
		.WORD $24C0, $24C0, $24C0, $24C0, $24C0, $24C0,	$24C0
		.WORD $24C0, $24C0, $24C0, $24C0, $24C0, $24C0,	$24C0
		.WORD $24C0, $24C0, $24C0, $24C0, $24C0, $24C0,	$24C0
		.WORD $24C0, $24C0, $24C0, $24C0, $24C0, $24C0,	$24C0
		.WORD $24C0, $24C0, $24C0, $24C0, $24C0, $24C0,	$24C0
		.WORD $24C0, $24C0, $24C0, $24C0, $24C0, $24C0,	$24C0
		.WORD $24C0, $24C0, $24C0, $24C0, $24C0, $24C0,	$24C0
		.WORD $24C0, $24C0, $24C0, $2500, $2500, $2500,	$2500
		.WORD $2500, $2540, $2540, $2540, $2540, $2540,	$2500
		.WORD $2500, $2500, $2500, $2500, $2540, $2540,	$2540
		.WORD $2540, $2540, $2500, $2500, $2500, $2500,	$2500
		.WORD $2540, $2540, $2540, $2540, $2540, $2500,	$2500
		.WORD $2500, $2500, $2500, $2540, $2540, $2540,	$2540
		.WORD $2540, $2500, $2500, $2500, $2500, $2500,	$2540
		.WORD $2540, $2540, $2540, $2540, $2500, $2500,	$2500
		.WORD $2500, $2500, $2540, $2540, $2540, $2540,	$2540
		.WORD $2500, $2500, $2500, $2500, $2500
byte_C527AB:	.BYTE 4
		.WORD $2580, $2580, $25C0, $25C0
byte_C527B4:	.BYTE 4
		.WORD $2800, $2800, $2840, $2840
byte_C527BD:	.BYTE 4
		.WORD $2880, $2880, $28C0, $28C0
byte_C527C6:	.BYTE 4
		.WORD $2900, $2900, $2940, $2940
byte_C527CF:	.BYTE 4
		.WORD $2980, $2980, $29C0, $29C0
byte_C527D8:	.BYTE 4
		.WORD $2840, $2840, $2800, $2800
byte_C527E1:	.BYTE 4
		.WORD $2940, $2940, $2900, $2900
byte_C527EA:	.BYTE 4
		.WORD $29C0, $29C0, $2980, $2980
byte_C527F3:	.BYTE $30
		.WORD $2C40, $2C40, $2C40, $2C40, $2C40, $2C40,	$2C40
		.WORD $2C40, $2C40, $2C40, $2C40, $2C40, $2C40,	$2C40
		.WORD $2C40, $2C40, $2C40, $2C40, $2C40, $2C40,	$2C40
		.WORD $2C40, $2C40, $2C40, $2C40, $2C40, $2C40,	$2C40
		.WORD $2C40, $2C40, $2C40, $2C40, $2C00, $2C00,	$2C00
		.WORD $2C00, $2C00, $2C00, $2C00, $2C00, $2C00,	$2C00
		.WORD $2C00, $2C00, $2C00, $2C00, $2C00, $2C00
byte_C52854:	.BYTE $60
		.WORD $2C80, $2C80, $2C80, $2C80, $2C80, $2C80,	$2C80
		.WORD $2C80, $2C80, $2C80, $2C80, $2C80, $2C80,	$2C80
		.WORD $2C80, $2C80, $2C80, $2C80, $2C80, $2C80,	$2C80
		.WORD $2C80, $2C80, $2C80, $2C80, $2C80, $2C80,	$2C80
		.WORD $2C80, $2C80, $2C80, $2C80, $2CC0, $2CC0,	$2CC0
		.WORD $2CC0, $2CC0, $2CC0, $2CC0, $2CC0, $2CC0,	$2CC0
		.WORD $2CC0, $2CC0, $2CC0, $2CC0, $2CC0, $2CC0,	$2CC0
		.WORD $2CC0, $2CC0, $2CC0, $2CC0, $2CC0, $2CC0,	$2CC0
		.WORD $2CC0, $2CC0, $2CC0, $2CC0, $2CC0, $2CC0,	$2CC0
		.WORD $2CC0, $2D00, $2D00, $2D00, $2D00, $2D00,	$2D00
		.WORD $2D00, $2D00, $2D00, $2D00, $2D00, $2D00,	$2D00
		.WORD $2D00, $2D00, $2D00, $2D00, $2D00, $2D00,	$2D00
		.WORD $2D00, $2D00, $2D00, $2D00, $2D00, $2D00,	$2D00
		.WORD $2D00, $2D00, $2D00, $2D00, $2D00
byte_C52915:	.BYTE $C
		.WORD $2DC0, $2DC0, $2DC0, $2DC0, $3000, $3000,	$3000
		.WORD $3000, $3040, $3040, $3040, $3040
byte_C5292E:	.BYTE $77
		.WORD $40C0, $40C0, $40C0, $40C0, $40C0, $40C0,	$40C0
		.WORD $40C0, $40C0, $40C0, $40C0, $40C0, $40C0,	$40C0
		.WORD $40C0, $40C0, $40C0, $40C0, $40C0, $40C0,	$40C0
		.WORD $40C0, $40C0, $40C0, $40C0, $40C0, $40C0,	$40C0
		.WORD $40C0, $40C0, $40C0, $40C0, $40C0, $40C0,	$40C0
		.WORD $40C0, $40C0, $40C0, $40C0, $40C0, $40C0,	$40C0
		.WORD $40C0, $40C0, $40C0, $40C0, $40C0, $40C0,	$4100
		.WORD $4100, $4100, $4100, $4100, $4100, $4100,	$4100
		.WORD $4100, $4100, $4100, $4100, $4140, $4140,	$4140
		.WORD $4140, $4140, $4140, $4140, $4140, $4140,	$4140
		.WORD $4140, $4140, $4140, $4180, $4180, $4180,	$4180
		.WORD $4180, $4180, $4180, $4180, $4180, $4180,	$4180
		.WORD $4180, $4180, $4180, $41C0, $41C0, $41C0,	$41C0
		.WORD $41C0, $41C0, $41C0, $41C0, $41C0, $41C0,	$41C0
		.WORD $41C0, $41C0, $4400, $4400, $4400, $4400,	$4400
		.WORD $4400, $4400, $4400, $4400, $4400, $4440,	$4440
		.WORD $4440, $4440, $4440, $4440, $4440, $4440,	$4440
byte_C52A1D:	.BYTE $CB
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3400, $3400, $3400, $3400, $3400, $3400,	$3400
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
byte_C52BB4:	.BYTE $CB
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3400, $3400, $3400, $3400, $3400, $3400,	$3400
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
byte_C52D4B:	.BYTE $CB
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3400, $3400, $3400, $3400, $3400, $3400,	$3400
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
byte_C52EE2:	.BYTE $CB
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3400, $3400, $3400, $3400, $3400, $3400,	$3400
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
byte_C53079:	.BYTE $CB
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3400, $3400, $3400, $3400, $3400, $3400,	$3400
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
byte_C53210:	.BYTE $CB
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3400, $3400, $3400, $3400, $3400, $3400,	$3400
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
byte_C533A7:	.BYTE $CB
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3400, $3400, $3400, $3400, $3400, $3400,	$3400
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
byte_C5353E:	.BYTE $CB
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3400, $3400, $3400, $3400, $3400, $3400,	$3400
		.WORD $31C0, $31C0, $31C0, $31C0, $31C0, $31C0,	$31C0
		.WORD $3180, $3180, $3180, $3180, $3180, $3180,	$3180
		.WORD $3140, $3140, $3140, $3140, $3140, $3140,	$3140
		.WORD $3100, $3100, $3100, $3100, $3100, $3100,	$3100
		.WORD $30C0, $30C0, $30C0, $30C0, $30C0, $30C0,	$30C0
		.WORD $3440, $3440, $3440, $3440, $3440, $3440,	$3440
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
		.WORD $3480, $3480, $3480, $3480, $3480, $3480,	$3480
byte_C536D5:	.BYTE $20
		.WORD $34C0, $34C0, $34C0, $34C0, $34C0, $34C0,	$34C0
		.WORD $34C0, $34C0, $34C0, $34C0, $34C0, $34C0,	$34C0
		.WORD $34C0, $34C0, $3500, $3500, $3500, $3500,	$3500
		.WORD $3500, $3500, $3500, $3500, $3500, $3500,	$3500
		.WORD $3500, $3500, $3500, $3500
byte_C53716:	.BYTE $30
		.WORD $3540, $3540, $3540, $3540, $3540, $3540,	$3540
		.WORD $3540, $3540, $3540, $3540, $3540, $3540,	$3540
		.WORD $3540, $3540, $3540, $3540, $3540, $3540,	$3540
		.WORD $3540, $3540, $3540, $3580, $3580, $3580,	$3580
		.WORD $3580, $3580, $3580, $3580, $3580, $3580,	$3580
		.WORD $3580, $3580, $3580, $3580, $3580, $3580,	$3580
		.WORD $3580, $3580, $3580, $3580, $3580, $3580
byte_C53777:	.BYTE $26
		.WORD $35C0, $35C0, $35C0, $35C0, $35C0, $35C0,	$35C0
		.WORD $35C0, $35C0, $35C0, $35C0, $35C0, $35C0,	$35C0
		.WORD $35C0, $35C0, $35C0, $35C0, $35C0, $3800,	$3800
		.WORD $3800, $3800, $3800, $3800, $3800, $3800,	$3800
		.WORD $3800, $3800, $3800, $3800, $3800, $3800,	$3800
		.WORD $3800, $3800, $3800
byte_C537C4:	.BYTE $26
		.WORD $3840, $3840, $3840, $3840, $3840, $3840,	$3840
		.WORD $3840, $3840, $3840, $3840, $3840, $3840,	$3840
		.WORD $3840, $3840, $3840, $3840, $3840, $3880,	$3880
		.WORD $3880, $3880, $3880, $3880, $3880, $3880,	$3880
		.WORD $3880, $3880, $3880, $3880, $3880, $3880,	$3880
		.WORD $3880, $3880, $3880
byte_C53811:	.BYTE $28
		.WORD $38C0, $38C0, $38C0, $38C0, $38C0, $38C0,	$38C0
		.WORD $38C0, $38C0, $38C0, $3900, $3900, $3900,	$3900
		.WORD $3900, $3900, $3900, $3900, $3900, $3900,	$3940
		.WORD $3940, $3940, $3940, $3940, $3940, $3940,	$3940
		.WORD $3940, $3940, $3980, $3980, $3980, $3980,	$3980
		.WORD $3980, $3980, $3980, $3980, $3980
byte_C53862:	.BYTE $28
		.WORD $39C0, $39C0, $39C0, $39C0, $39C0, $39C0,	$39C0
		.WORD $39C0, $39C0, $39C0, $3C00, $3C00, $3C00,	$3C00
		.WORD $3C00, $3C00, $3C00, $3C00, $3C00, $3C00,	$3C40
		.WORD $3C40, $3C40, $3C40, $3C40, $3C40, $3C40,	$3C40
		.WORD $3C40, $3C40, $3C80, $3C80, $3C80, $3C80,	$3C80
		.WORD $3C80, $3C80, $3C80, $3C80, $3C80
byte_C538B3:	.BYTE $28
		.WORD $3CC0, $3CC0, $3CC0, $3CC0, $3CC0, $3CC0,	$3CC0
		.WORD $3CC0, $3CC0, $3CC0, $3D00, $3D00, $3D00,	$3D00
		.WORD $3D00, $3D00, $3D00, $3D00, $3D00, $3D00,	$3D40
		.WORD $3D40, $3D40, $3D40, $3D40, $3D40, $3D40,	$3D40
		.WORD $3D40, $3D40, $3D80, $3D80, $3D80, $3D80,	$3D80
		.WORD $3D80, $3D80, $3D80, $3D80, $3D80
byte_C53904:	.BYTE $28
		.WORD $3DC0, $3DC0, $3DC0, $3DC0, $3DC0, $3DC0,	$3DC0
		.WORD $3DC0, $3DC0, $3DC0, $4000, $4000, $4000,	$4000
		.WORD $4000, $4000, $4000, $4000, $4000, $4000,	$4040
		.WORD $4040, $4040, $4040, $4040, $4040, $4040,	$4040
		.WORD $4040, $4040, $4080, $4080, $4080, $4080,	$4080
		.WORD $4080, $4080, $4080, $4080, $4080
.A8
.I16
; e=1

sub_C53955:
		LDY	#.LOWORD(joypad_1_pressed)
		BRA	loc_C53967
; End of function sub_C53955

.A16
.I16
; e=0

sub_C5395A:

; FUNCTION CHUNK AT 3967 SIZE 0000000F BYTES

		LDY	#.LOWORD(joypad_1_pressed+1)
		BRA	loc_C53967
; End of function sub_C5395A

.A16
.I16

sub_C5395F:
		LDY	#.LOWORD(joypad_1)
		BRA	loc_C53967
; End of function sub_C5395F

.A8
.I16
; e=1

sub_C53964:
		LDY	#.LOWORD(joypad_1+1)
; End of function sub_C53964

; START	OF FUNCTION CHUNK FOR sub_C5395A

loc_C53967:
		SEP	#$20
		LDA	a:.LOWORD(0),Y
		ORA	a:.LOWORD(2),Y
		ORA	a:.LOWORD(4),Y
		ORA	a:.LOWORD(6),Y
		RTL
; END OF FUNCTION CHUNK	FOR sub_C5395A
.A16
.I16
; e=0

sub_C53976:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C539B7)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C539B7)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C539B7)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCC	loc_C53992
		JML	f:locret_C53A06
; ---------------------------------------------------------------------------

loc_C53992:
		REP	#$20
.A16
		LDA	z:$11,X
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($11),Y
		LDA	z:$14,X
		AND	#$F0
		ORA	#8
		STA	a:.LOWORD($14),Y
		LDA	#$330
		STA	a:.LOWORD($E),Y
		LDA	#0
		STA	a:.LOWORD($1E),Y
		RTL
; End of function sub_C53976

.A16
.I16

sub_C539B7:
		REP	#$20
		REP	#$20
		LDA	#.LOWORD(byte_C705CF)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_C705CF)
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C539D7)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C539D7)
		STA	z:2,X

loc_C539D7:
		JSL	f:load_animation_frame
		BCC	locret_C539E1
		JML	f:delete_object
; ---------------------------------------------------------------------------

locret_C539E1:
		RTL
; End of function sub_C539B7

.A16
.I16

sub_C539E2:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C53A07)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C53A07)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C53A07)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	locret_C53A06
		LDA	z:$11,X
		STA	a:.LOWORD($11),Y
		LDA	z:$14,X
		STA	a:.LOWORD($14),Y
.A8

locret_C53A06:
		RTL
; End of function sub_C539E2

.A8
.I16

sub_C53A07:
		REP	#$20
.A16
		LDA	#$C30
		STA	z:$E,X
		LDA	#0
		STA	z:$1E,X
		LDA	#.LOWORD(byte_C51DB9)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C53A2F)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C53A2F)
		STA	z:2,X

loc_C53A2F:
		JSL	f:load_animation_frame
		BCC	locret_C53A39
		JML	f:delete_object
; ---------------------------------------------------------------------------

locret_C53A39:
		RTL
; End of function sub_C53A07

.A8
.I16

draw_falling_letters:
		SEP	#$20
		LDA	#.LOBYTE(sub_C53A9F)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C53A9F)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C53A9F)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		LDA	#$3F
		STA	z:$40
		LDA	#$40
		STA	z:$42
		LDA	#$599
		STA	z:$53
		JSL	f:sub_C53ACB
		LDA	#$6B
		STA	z:$40
		LDA	#$60
		STA	z:$42
		LDA	#$59E
		STA	z:$53
		JSL	f:sub_C53ACB
		LDA	#$98
		STA	z:$40
		LDA	#$80
		STA	z:$42
		LDA	#$5A3
		STA	z:$53
		JSL	f:sub_C53ACB
		LDA	#$C3
		STA	z:$40
		LDA	#$A0
		STA	z:$42
		LDA	#$5A8
		STA	z:$53
		JSL	f:sub_C53ACB
		RTL
; End of function draw_falling_letters

.A16
.I16

sub_C53A9F:

; FUNCTION CHUNK AT 63C4 SIZE 00000039 BYTES

		SEP	#$20
.A8
		LDA	#$17
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$17
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#0
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#0
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		LDA	#$E0
		STA	a:.LOWORD(FIXED_COLOR_DATA)
		REP	#$20
.A16
		LDA	#0
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	#0
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		JMP	a:.LOWORD(loc_C563C4)
; End of function sub_C53A9F

.A16
.I16

sub_C53ACB:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C53B0B)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C53B0B)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C53B0B)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		LDA	#$830
		STA	a:.LOWORD($E),Y
		LDA	#8
		STA	a:.LOWORD($1E),Y
		LDA	z:$40
		STA	a:.LOWORD($11),Y
		LDA	#$FFC0
		STA	a:.LOWORD($14),Y
		LDA	#0
		STA	a:.LOWORD($18),Y
		LDA	z:$42
		STA	a:.LOWORD($20),Y
		LDA	z:$53
		STA	a:.LOWORD($22),Y
		RTL
; End of function sub_C53ACB

.A16
.I16

sub_C53B0B:
		SEP	#$20
.A8
		LDA	#$C7
		STA	z:$52
		REP	#$20
.A16
		LDA	z:$22,X
		STA	z:$50
		JSL	f:start_animation
		REP	#$20
		LDA	#.LOWORD(loc_C53B28)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C53B28)
		STA	z:2,X

loc_C53B28:
		REP	#$20
.A16
		DEC	z:$20,X
		BPL	locret_C53B5C
		LDA	z:$18,X
		CLC
		ADC	#$C0
		STA	z:$18,X
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		LDA	#0
		ADC	z:$15,X
		STA	z:$15,X
		LDA	z:$14,X
		BMI	loc_C53B58
		CMP	#$28
		BCC	loc_C53B58
		REP	#$20
		LDA	#.LOWORD(loc_C53B58)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C53B58)
		STA	z:2,X

loc_C53B58:
		JSL	f:load_animation_frame

locret_C53B5C:
		RTL
; End of function sub_C53B0B

.A16
.I16

sub_C53B5D:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C53B7C)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C53B7C)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C53B7C)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	locret_C53B7B
		JML	f:loc_C55264
; ---------------------------------------------------------------------------

locret_C53B7B:
		RTL
; End of function sub_C53B5D

.A16
.I16

sub_C53B7C:
		LDY	#5
		JSL	f:play_sound
		REP	#$20
		LDA	#$C30
		STA	z:$E,X
		LDA	#4
		STA	z:$1E,X
		LDA	#$140
		STA	z:$11,X
		LDA	#$66
		STA	z:$14,X
		LDA	#0
		STA	z:$20,X
		LDA	#.LOWORD(byte_C51D57)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C53BBA)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C53BBA)
		STA	z:2,X

loc_C53BBA:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C53BC7
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C53BC7:
		BIT	#$41
		BEQ	loc_C53BCF
		JML	f:loc_C53BF2
; ---------------------------------------------------------------------------

loc_C53BCF:
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#4
		BEQ	loc_C53BDD
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C53BDD:
		LDA	z:$11,X
		DEC
		DEC
		STA	z:$11,X
		BPL	loc_C53BF2
		CMP	#$FFC0
		BCS	loc_C53BF2
		JSL	f:sub_C53C8A
		JSL	f:delete_object
.A8

loc_C53BF2:
		JSL	f:load_animation_frame
		RTL
; End of function sub_C53B7C

.A8
.I16

sub_C53BF7:
		SEP	#$20
		LDA	#.LOBYTE(sub_C53C16)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C53C16)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C53C16)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	locret_C53C15
		JML	f:loc_C55264
; ---------------------------------------------------------------------------

locret_C53C15:
		RTL
; End of function sub_C53BF7

.A16
.I16

sub_C53C16:
		REP	#$20
		LDA	#$C30
		STA	z:$E,X
		LDA	#4
		STA	z:$1E,X
		LDA	#$88
		STA	z:$11,X
		LDA	#$FFE0
		STA	z:$14,X
		LDA	#0
		STA	z:$20,X
		LDA	#.LOWORD(byte_C51D60)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C53C4D)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C53C4D)
		STA	z:2,X

loc_C53C4D:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C53C5A
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C53C5A:
		BIT	#$41
		BEQ	loc_C53C62
		JML	f:loc_C53C85
; ---------------------------------------------------------------------------

loc_C53C62:
		REP	#$20
.A16
		LDA	z:$14,X
		CLC
		ADC	#$10
		STA	z:$14,X
		BMI	loc_C53C85
		CMP	#$66
		BCC	loc_C53C85
		LDA	#$66
		STA	z:$14,X
		REP	#$20
		LDA	#.LOWORD(loc_C53C85)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C53C85)
		STA	z:2,X

loc_C53C85:
		JSL	f:load_animation_frame
		RTL
; End of function sub_C53C16

.A16
.I16

sub_C53C8A:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C53CA9)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C53CA9)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C53CA9)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	locret_C53CA8
		JML	f:loc_C55264
; ---------------------------------------------------------------------------

locret_C53CA8:
		RTL
; End of function sub_C53C8A

.A16
.I16

sub_C53CA9:
		REP	#$20
		LDA	#$40
		STA	z:$20,X
		REP	#$20
		LDA	#.LOWORD(loc_C53CBD)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C53CBD)
		STA	z:2,X

loc_C53CBD:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C53CCA
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C53CCA:
		BIT	#$41
		BEQ	loc_C53CD2
		JML	f:locret_C53E1D
; ---------------------------------------------------------------------------

loc_C53CD2:
		REP	#$20
.A16
		DEC	z:$20,X
		BEQ	loc_C53CDC
		JML	f:locret_C53E1D
; ---------------------------------------------------------------------------

loc_C53CDC:
		LDA	#$C30
		STA	z:$E,X
		LDA	#0
		STA	z:$1E,X
		LDA	#$28
		STA	z:$11,X
		LDA	#$B8
		STA	z:$14,X
		LDA	#0
		STA	z:$20,X
		REP	#$20
		LDA	#.LOWORD(loc_C53D9E)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C53D9E)
		STA	z:2,X
.A16

loc_C53D02:
		REP	#$20
		LDA	#.LOWORD(sudden_death_related_data)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sudden_death_related_data)
		STA	z:$52
		REP	#$20
.A16
		LDA	z:$20,X
		ASL
		ASL
		ASL
		TAY
		LDA	[$50],Y
		STA	z:$16,X
		INY
		INY
		LDA	[$50],Y
		STA	z:$18,X
		INY
		INY
		LDA	[$50],Y
		STA	z:$1A,X
		INY
		INY
		LDA	[$50],Y
		STA	z:$1C,X

loc_C53D2D:
		JSL	f:get_object_square_index
		REP	#$20
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$80
		BEQ	loc_C53D40
		JML	f:loc_C53DDC
; ---------------------------------------------------------------------------

loc_C53D40:
		LDA	#HARD_BLOCK|$500
		STA	a:.LOWORD(collision_map),Y
		LDA	a:.LOWORD(bg1_tilemap+$24)	; orig=0x0518
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$800
		BEQ	loc_C53D70
		TYA
		LSR
		ADC	#$5400
		STA	z:$53
		REP	#$20
		LDA	#.LOWORD(sub_C53E6B)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C53E6B)
		STA	z:$52
		PHX
		PHY
		JSL	f:sub_C62514
		PLY
		PLX

loc_C53D70:
		JSL	f:sub_C53E1E
		LDY	#7
		JSL	f:play_sound
		REP	#$20
.A16
		LDA	#$10
		STA	z:$30,X
		LDA	#.LOWORD(byte_C51CB5)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C53D9E)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C53D9E)
		STA	z:2,X

loc_C53D9E:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C53DAB
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C53DAB:
		BIT	#$41
		BEQ	loc_C53DB3
		JML	f:loc_C53DD7
; ---------------------------------------------------------------------------

loc_C53DB3:
		JSL	f:get_object_square_index
		REP	#$20
.A16
		TAY
		LDA	#$580
		STA	a:.LOWORD(collision_map),Y
		LDA	a:.LOWORD(bg1_tilemap+$24)	; orig=0x0518
		STA	a:.LOWORD(bg1_tilemap),Y
		DEC	z:$30,X
		BNE	loc_C53DD7
		REP	#$20
		LDA	#.LOWORD(loc_C53DDC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C53DDC)
		STA	z:2,X

loc_C53DD7:
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------
.A16

loc_C53DDC:
		REP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#4
		BEQ	loc_C53DEA
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C53DEA:
		LDA	z:$11,X
		CLC
		ADC	z:$1A,X
		STA	z:$11,X
		LDA	z:$14,X
		CLC
		ADC	z:$1C,X
		STA	z:$14,X
		LDA	z:$11,X
		CMP	z:$16,X
		BEQ	loc_C53E02
		JML	f:loc_C53D2D
; ---------------------------------------------------------------------------

loc_C53E02:
		LDA	z:$14,X
		CMP	z:$18,X
		BEQ	loc_C53E0C
		JML	f:loc_C53D2D
; ---------------------------------------------------------------------------

loc_C53E0C:
		INC	z:$20,X
		LDA	z:$20,X
		CMP	#8
		BEQ	loc_C53E19
		JML	f:loc_C53D02
; ---------------------------------------------------------------------------

loc_C53E19:
		JSL	f:delete_object

locret_C53E1D:
		RTL
; End of function sub_C53CA9

.A8
.I16

.IFDEF J
; Moved to bank 3
sudden_death_related_data:
        .WORD $28, $18, 0, $FFF0, $E8, $18, $10
		.WORD 0, $E8, $B8, 0, $10, $38,	$B8, $FFF0, 0, $38
		.WORD $28, 0, $FFF0, $D8, $28, $10, 0, $D8, $A8, 0
		.WORD $10, $38,	$A8, $FFF0, 0
.ENDIF

sub_C53E1E:
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$40
		BNE	locret_C53E6A
		BIT	#$1000
		BNE	locret_C53E6A
		CPY	#$2C4
		BCS	locret_C53E6A
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags) ;	orig=0x0D38
		BIT	#$20
		BEQ	loc_C53E42
		LDA	a:.LOWORD($554),Y
		CMP	#$826
		BEQ	loc_C53E5C

loc_C53E42:
		LDA	a:.LOWORD($956),Y
		BIT	#$3E0
		BNE	loc_C53E53
		LDA	#$C
		ORA	a:.LOWORD(bg1_tilemap+$22)	; orig=0x0516
		STA	a:.LOWORD($534),Y

loc_C53E53:
		LDA	#$C
		ORA	a:.LOWORD(bg1_tilemap+$22)	; orig=0x0516
		STA	a:.LOWORD($554),Y

loc_C53E5C:
		LDA	a:.LOWORD($956),Y
		BIT	#$40
		BEQ	locret_C53E6A
		LDA	#$802
		STA	a:.LOWORD($534),Y

locret_C53E6A:
		RTL
; End of function sub_C53E1E

.A16
.I16

sub_C53E6B:
		SEP	#$20
.A8
		LDA	#$80
		STA	a:.LOWORD(VRAM_ADDRESS_INCREMENT_VALUE)
		REP	#$20
.A16
		LDA	z:$53
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#0
		STA	a:.LOWORD(DATA_FOR_VRAM_WRITE_LOW_BYTE)
		RTL
; End of function sub_C53E6B

.A8
.I16

sub_C53E80:
		SEP	#$20
		LDA	#.LOBYTE(sub_C53EAB)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C53EAB)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C53EAB)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C53E9E
		JML	f:loc_C55264
; ---------------------------------------------------------------------------

loc_C53E9E:
		LDA	#1
		STA	a:.LOWORD($20),Y
		LDA	#0
		STA	a:.LOWORD($22),Y
		RTL
; End of function sub_C53E80

.A16
.I16

sub_C53EAB:
		REP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$DD
		BNE	locret_C53EDD
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_10) ; orig=0x0D3A
		CMP	#$100
		BCC	locret_C53EDD
		DEC	z:$20,X
		BNE	locret_C53EDD
		JSL	f:random2
		REP	#$20
		AND	#$FF
		CLC
		ADC	#$80
		STA	z:$20,X
		LDA	z:$22,X
		CMP	#4
		BCS	locret_C53EDD
		INC	z:$22,X
		JSL	f:sub_C53EDE

locret_C53EDD:
		RTL
; End of function sub_C53EAB

.A16
.I16

sub_C53EDE:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C53F01)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C53F01)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C53F01)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C53EFC
		JML	f:loc_C55264
; ---------------------------------------------------------------------------

loc_C53EFC:
		TXA
		STA	a:.LOWORD($22),Y
		RTL
; End of function sub_C53EDE

.A16
.I16

sub_C53F01:
		REP	#$20
		LDA	#$830
		STA	z:$E,X
		LDA	#0
		STA	z:$1E,X
		LDA	#$FFF0
		STA	z:$14,X
		LDA	#$10
		STA	z:$20,X
		PHX
		LDX	#7
		JSL	f:random
		PLX
		REP	#$20
		INC
		ASL
		ASL
		ASL
		ASL
		ASL
		AND	#$FF
		ORA	#5
		STA	z:$11,X
		JSL	f:random2
		REP	#$20
		AND	#$70
		CLC
		ADC	#$30
		STA	z:$18,X
		LDA	#.LOWORD(byte_C51C9D)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C53F5B)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C53F5B)
		STA	z:2,X

loc_C53F5B:
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#4
		BEQ	loc_C53F69
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C53F69:
		BIT	#$41
		BNE	loc_C53F9C
		STZ	z:$40
		LDA	z:$18,X
		BPL	loc_C53F76
		DEC	z:$40

loc_C53F76:
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		LDA	z:$15,X
		ADC	z:$40
		STA	z:$15,X
		LDA	z:$18,X
		LDA	z:$14,X
		BEQ	loc_C53FA5
		BMI	loc_C53F9C
		CMP	#$120
		BCC	loc_C53F9C
		LDY	z:$22,X
		LDA	a:.LOWORD($22),Y
		DEC
		STA	a:.LOWORD($22),Y
		JSL	f:delete_object
		RTL
; ---------------------------------------------------------------------------

loc_C53F9C:
		JSL	f:sub_C53FA9
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C53FA5:
		INC	z:$14,X
		BRA	loc_C53F9C
; End of function sub_C53F01

.A16
.I16

sub_C53FA9:
		REP	#$20
		LDA	z:$11,X
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$40
		LDA	z:$14,X
		CLC
		ADC	z:$20,X
		AND	#$3F0
		ASL
		ASL
		ADC	z:$40
		CMP	#$2DE
		BCS	locret_C53FDF
		TAY
		LDA	a:.LOWORD(collision_map),Y
		BIT	#$20
		BEQ	locret_C53FDF
		JSL	f:sub_C53FE0
		BCS	locret_C53FDF
		REP	#$20
		LDA	z:$20,X
		CLC
		ADC	#$10
		STA	z:$20,X

locret_C53FDF:
		RTL
; End of function sub_C53FA9

.A16
.I16

sub_C53FE0:
		REP	#$20
		STY	z:$50
		LDY	#$1C80

loc_C53FE7:
		LDA	a:.LOWORD(0),Y
		CMP	#.LOWORD(loc_C44DA9)
		BNE	loc_C54013
		LDA	a:.LOWORD($A),Y
		CMP	z:$50
		BNE	loc_C54013
		LDA	#.LOWORD(sub_C44FCB)
		STA	a:.LOWORD(0),Y
		LDA	z:$20,X
		STA	a:.LOWORD($18),Y
		PHX
		PHY
		TYA
		TAX
		JSL	f:sub_C4576B
		PLY
		PLX
		REP	#$20
		TXA
		STA	a:.LOWORD(8),Y
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C54013:
		LDA	a:.LOWORD(6),Y
		TAY
		INC
		BNE	loc_C53FE7
		SEC
		RTL
; End of function sub_C53FE0

.A16
.I16

create_moving_platforms:
		REP	#$20
		LDA	#$10
		STA	z:$40
		LDA	#.LOWORD(byte_C51BEB)
		STA	z:$42
		JSL	f:create_moving_platform
		LDA	#$100
		STA	z:$40
		LDA	#.LOWORD(byte_C51BF0)
		STA	z:$42
		JSL	f:create_moving_platform
		RTL
; End of function create_moving_platforms

.A16
.I16

create_moving_platform:
		SEP	#$20
.A8
		LDA	#.LOBYTE(moving_platform)
		STA	z:$DB
		LDA	#.HIBYTE(moving_platform)
		STA	z:$DC
		LDA	#.BANKBYTE(moving_platform)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C54059
		JML	f:loc_C55264
; ---------------------------------------------------------------------------

loc_C54059:
		LDA	z:$40
		STA	a:.LOWORD($11),Y
		LDA	z:$42
		STA	a:.LOWORD($20),Y
		REP	#$20
		LDA	#1
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(moving_platform_graphics)
		STA	z:$5F
		SEP	#$20
.A8
		LDA	#.BANKBYTE(moving_platform_graphics)
		STA	z:$61
		PHY
		JSL	f:allocate_graphics
		PLY
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($F),Y
		SEP	#$20
		LDA	#.LOWORD(MOVING_PLATFORM_PALETTE)
		STA	z:$40
		JSL	f:palette_allocation_related
		SEP	#$20
		LDA	z:$42
		STA	a:.LOWORD($1E),Y
		STA	a:.LOWORD($1F),Y
		REP	#$20
.A16
		RTL
; End of function create_moving_platform

.A16
.I16

moving_platform:
		SEP	#$20
.A8
		LDA	#$30
		STA	z:$E,X
		REP	#$20
.A16
		LDA	z:$20,X
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C540EE)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C540EE)
		STA	z:2,X

loc_C540BE:
		SEP	#$20
		JSL	f:random2
		REP	#$20
.A16
		AND	#$70
		CLC
		ADC	#$30
		STA	z:$18,X
		JSL	f:random2
		REP	#$20
		AND	#2
		PHX
		TAX
		LDA	f:byte_C54133,X
		PLX
		STA	z:$14,X
		CMP	#0
		BMI	loc_C540EE
		LDA	z:$18,X
		EOR	#$FFFF
		INC
		STA	z:$18,X

loc_C540EE:
		REP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#4
		BNE	locret_C54132
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$80
		BNE	locret_C54132
		STZ	z:$40
		LDA	z:$18,X
		BPL	loc_C54108
		DEC	z:$40

loc_C54108:
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		LDA	z:$15,X
		ADC	z:$40
		STA	z:$15,X
		LDA	z:$18,X
		BMI	loc_C54125
		LDA	z:$14,X
		BMI	loc_C5412E
		CMP	#$120
		BCS	loc_C540BE
		JSL	f:load_animation_frame
		RTL
; ---------------------------------------------------------------------------

loc_C54125:
		LDA	z:$14,X
		BPL	loc_C5412E
		CMP	#$FFE0
		BCC	loc_C540BE

loc_C5412E:
		JSL	f:load_animation_frame

locret_C54132:
		RTL
; End of function moving_platform

; ---------------------------------------------------------------------------
byte_C54133:	.BYTE $F0, $FF,	0, 1
.A16
.I16

set_overlay_blending:
		REP	#$20
		LDA	[$50]
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		INC	z:$50
		INC	z:$50
		RTL
; End of function set_overlay_blending

.A16
.I16

sub_C5414C:
		REP	#$20
		LDA	[$50]
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD(FIXED_COLOR_DATA)
		INC	z:$50
		INC	z:$50
		LDA	[$50],Y
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		INC	z:$50
		INC	z:$50
		LDA	[$50],Y
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		INC	z:$50
		INC	z:$50
		RTL
; End of function sub_C5414C

.A16
.I16

create_overlay_scroller:
		SEP	#$20
.A8
		LDA	#.LOBYTE(overlay_scroller)
		STA	z:$DB
		LDA	#.HIBYTE(overlay_scroller)
		STA	z:$DC
		LDA	#.BANKBYTE(overlay_scroller)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCS	locret_C541C1
		REP	#$20
.A16
		LDA	[$50]
		STA	a:.LOWORD($20),Y
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD($22),Y
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD($24),Y
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD($26),Y
		INC	z:$50
		INC	z:$50
		SEP	#$20
.A8
		LDA	#2
		STA	a:.LOWORD(3),Y

locret_C541C1:
		RTL
; End of function create_overlay_scroller

.A8
.I16

overlay_scroller:
		REP	#$20
.A16
		LDA	z:$20,X
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	z:$22,X
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		REP	#$20
		LDA	#.LOWORD(loc_C541DB)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C541DB)
		STA	z:2,X

loc_C541DB:
		REP	#$20
.A16
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BNE	locret_C541F7
		LDA	z:$24,X
		CLC
		ADC	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	z:$26,X
		CLC
		ADC	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3

locret_C541F7:
		RTL
; End of function overlay_scroller

.A16
.I16

sub_C541F8:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C5421B)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C5421B)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C5421B)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		JSL	f:sub_C54C8B
		JSL	f:sub_C54CF7
		JSL	f:sub_C54D63
		RTL
; End of function sub_C541F8

.A8
.I16

sub_C5421B:
		SEP	#$20
		LDA	#$13
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#3
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#2
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#$10
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		LDA	#$E0
		STA	a:.LOWORD(FIXED_COLOR_DATA)
		REP	#$20
.A16
		LDA	#$300
		STA	a:.LOWORD(word_7E0C93) ; orig=0x0C93
		LDA	#$100
		STA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		LDA	#$3F8
		STA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		LDA	#0
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	#$11F
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		LDA	#$100
		STA	z:$20,X
		REP	#$20
		LDA	#.LOWORD(loc_C54268)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54268)
		STA	z:2,X

loc_C54268:
		REP	#$20
.A16
		DEC	z:$20,X
		BEQ	loc_C54272
		JML	f:loc_C542E8
; ---------------------------------------------------------------------------

loc_C54272:
		REP	#$20
		LDA	#.LOWORD(loc_C54295)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54295)
		STA	z:2,X
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C543CA)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C543CA)
		STA	z:$52
		PHX
		PHY
		JSL	f:sub_C62514
		PLY
		PLX
		RTL
; ---------------------------------------------------------------------------

loc_C54295:
		REP	#$20
.A16
		LDA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		SEC
		SBC	#$10
		STA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		LDA	a:.LOWORD(word_7E0C93) ; orig=0x0C93
		CLC
		ADC	#$10
		STA	a:.LOWORD(word_7E0C93) ; orig=0x0C93
		CMP	#$415
		BCC	loc_C542E8
		SEP	#$20
.A8
		LDY	#0
		LDA	#$2E
		STA	z:$40
		LDA	#1
		JSL	f:palette_related
		LDA	#4
		JSL	f:palette_related
		LDA	#5
		JSL	f:palette_related
		LDA	#.LOWORD(WHITE_PALETTE)
		STA	z:$40
		LDA	#8
		JSL	f:palette_related
		LDA	#9
		JSL	f:palette_related
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C54307)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C54307)
		STA	z:2,X
loc_C542E8:
.IFNDEF J
		SEP	#$20
.A8
		LDA	a:.LOWORD(word_7E0CAE) ; orig=0x0CAE
		BEQ	locret_C54306
.ENDIF
		JSL	f:sub_C5395A
		SEP	#$20
		BIT	#$10
		BEQ	locret_C54306
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C54307)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C54307)
		STA	z:2,X

locret_C54306:
		RTL
; End of function sub_C5421B

.A8
.I16

sub_C54307:
		REP	#$20
.A16
		LDA	#0
		STA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		LDA	#0
		STA	a:.LOWORD(word_7E0C93) ; orig=0x0C93
		REP	#$20
		LDA	#.LOWORD(sub_C54323)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C54323)
		STA	z:2,X
		RTL
; End of function sub_C54307

.A8
.I16

sub_C54323:
		SEP	#$20
		LDY	#0
		LDA	#$72
		STA	z:$40
		LDA	#1
		JSL	f:palette_related
		LDA	#$67
		STA	z:$40
		LDA	#4
		JSL	f:palette_related
		LDA	#$68
		STA	z:$40
		LDA	#5
		JSL	f:palette_related
		LDA	#.LOWORD(INTRO_BALOON_PALETTE)
		STA	z:$40
		LDA	#8
		JSL	f:palette_related
		LDA	#.LOWORD(INTRO_SHIP_PALETTE)
		STA	z:$40
		LDA	#9
		JSL	f:palette_related
		LDY	#5
		LDA	#.LOWORD(MAIN_MENU_PALETTE)
		STA	z:$40
		LDA	#$C
		JSL	f:palette_related
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C543E6)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C543E6)
		STA	z:$52
		JSL	f:sub_C62514
		REP	#$20
.A16
		LDA	#$28
		STA	z:$20,X
		REP	#$20
		LDA	#.LOWORD(loc_C5438C)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C5438C)
		STA	z:2,X

loc_C5438C:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	locret_C543BA
		SEP	#$20
.A8
		LDA	#$17
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$17
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#0
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#0
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		LDA	#$E0
		STA	a:.LOWORD(FIXED_COLOR_DATA)
		REP	#$20
.A16
		LDA	#.LOWORD(locret_C543BA)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(locret_C543BA)
		STA	z:2,X

locret_C543BA:
		RTL
; End of function sub_C54323

.A8
.I16

sub_C543BB:
		SEP	#$20
		LDA	a:.LOWORD(word_7E0C93) ; orig=0x0C93
		STA	a:.LOWORD(BG_1_H_SCROLL_OFFSET)
		LDA	a:.LOWORD(word_7E0C93+1) ;	orig=0x0C94
		STA	a:.LOWORD(BG_1_H_SCROLL_OFFSET)
		RTL
; End of function sub_C543BB

.A8
.I16

sub_C543CA:
		SEP	#$20
		LDA	#$44
		STA	a:.LOWORD(V_COUNT_TIMER)
		LDA	#$70
		STA	a:.LOWORD(H_COUNT_TIMER)
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C543BB)
		STA	a:.LOWORD(unknown_function_pointer) ; orig=0x00D0
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C543BB)
		STA	a:.LOWORD(unknown_function_pointer+2) ; orig=0x00D2
		RTL
; End of function sub_C543CA

.A8
.I16

sub_C543E6:
		SEP	#$20
		LDA	#$20
		STA	a:.LOWORD(V_COUNT_TIMER)
		LDA	#$B8
		STA	a:.LOWORD(H_COUNT_TIMER)
		REP	#$20
.A16
		LDA	#.LOWORD(locret_C53A06)
		STA	a:.LOWORD(unknown_function_pointer) ; orig=0x00D0
		SEP	#$20
.A8
		LDA	#.BANKBYTE(locret_C53A06)
		STA	a:.LOWORD(unknown_function_pointer+2) ; orig=0x00D2
		RTL
; End of function sub_C543E6

; ---------------------------------------------------------------------------
animation_frame_C54402:.BYTE $17	       ; 0
		frame_oam_tile 0, $18,	$2400, $60
		frame_oam_tile $F0, $18, $2400, $20
		frame_oam_tile 0, 8, $2200, $20
		frame_oam_tile $F0, 8,	$2000, $20
		frame_oam_tile $10, $F8, $300,	$40
		frame_oam_tile $10, 0,	$700, $40
		frame_oam_tile $E8, 0,	$700, 0
		frame_oam_tile $E8, $F8, $300,	0
		frame_oam_tile 0, $F8,	$2600, $60
		frame_oam_tile $F0, $F8, $2600, $20
		frame_oam_tile $10, $F0, $1600, $40
		frame_oam_tile $10, $E8, $600,	$40
		frame_oam_tile $10, $E0, $1300, $40
		frame_oam_tile $E8, $E0, $1300, 0
		frame_oam_tile $E8, $F0, $1600, 0
		frame_oam_tile $E8, $E8, $600,	0
		frame_oam_tile 0, $E8,	$400, $60
		frame_oam_tile 8, $E0,	$1000, $40
		frame_oam_tile 8, $D8,	0, $40
		frame_oam_tile 0, $E0,	$1200, 0
		frame_oam_tile 0, $D8,	$200, 0
		frame_oam_tile $F0, $E8, $400,	$20
		frame_oam_tile $F0, $D8, 0, $20
animation_frame_C54476:.BYTE $17	       ; 0
		frame_oam_tile 0, $17,	$2400, $60
		frame_oam_tile $F0, $17, $2400, $20
		frame_oam_tile 0, 7, $2200, $20
		frame_oam_tile $F0, 7,	$2000, $20
		frame_oam_tile $10, $F7, $300,	$40
		frame_oam_tile $10, $FF, $700,	$40
		frame_oam_tile $E8, $FF, $700,	0
		frame_oam_tile $E8, $F7, $300,	0
		frame_oam_tile 0, $F7,	$2600, $60
		frame_oam_tile $F0, $F7, $2600, $20
		frame_oam_tile $10, $EF, $1600, $40
		frame_oam_tile $10, $E7, $600,	$40
		frame_oam_tile $10, $DF, $1300, $40
		frame_oam_tile $E8, $DF, $1300, 0
		frame_oam_tile $E8, $EF, $1600, 0
		frame_oam_tile $E8, $E7, $600,	0
		frame_oam_tile 0, $E7,	$400, $60
		frame_oam_tile 8, $DF,	$1000, $40
		frame_oam_tile 8, $D7,	0, $40
		frame_oam_tile 0, $DF,	$1200, 0
		frame_oam_tile 0, $D7,	$200, 0
		frame_oam_tile $F0, $E7, $400,	$20
		frame_oam_tile $F0, $D7, 0, $20
animation_frame_C544EA:.BYTE $17	       ; 0
		frame_oam_tile 0, $16,	$2400, $60
		frame_oam_tile $F0, $16, $2400, $20
		frame_oam_tile 0, 6, $2200, $20
		frame_oam_tile $F0, 6,	$2000, $20
		frame_oam_tile $10, $F6, $300,	$40
		frame_oam_tile $10, $FE, $700,	$40
		frame_oam_tile $E8, $FE, $700,	0
		frame_oam_tile $E8, $F6, $300,	0
		frame_oam_tile 0, $F6,	$2600, $60
		frame_oam_tile $F0, $F6, $2600, $20
		frame_oam_tile $10, $EE, $1600, $40
		frame_oam_tile $10, $E6, $600,	$40
		frame_oam_tile $10, $DE, $1300, $40
		frame_oam_tile $E8, $DE, $1300, 0
		frame_oam_tile $E8, $EE, $1600, 0
		frame_oam_tile $E8, $E6, $600,	0
		frame_oam_tile 0, $E6,	$400, $60
		frame_oam_tile 8, $DE,	$1000, $40
		frame_oam_tile 8, $D6,	0, $40
		frame_oam_tile 0, $DE,	$1200, 0
		frame_oam_tile 0, $D6,	$200, 0
		frame_oam_tile $F0, $E6, $400,	$20
		frame_oam_tile $F0, $D6, 0, $20
animation_frame_C5455E:.BYTE $17	       ; 0
		frame_oam_tile 0, $19,	$2400, $60
		frame_oam_tile $F0, $19, $2400, $20
		frame_oam_tile 0, 9, $2200, $20
		frame_oam_tile $F0, 9,	$2000, $20
		frame_oam_tile $10, $F9, $300,	$40
		frame_oam_tile $10, 1,	$700, $40
		frame_oam_tile $E8, 1,	$700, 0
		frame_oam_tile $E8, $F9, $300,	0
		frame_oam_tile 0, $F9,	$2600, $60
		frame_oam_tile $F0, $F9, $2600, $20
		frame_oam_tile $10, $F1, $1600, $40
		frame_oam_tile $10, $E9, $600,	$40
		frame_oam_tile $10, $E1, $1300, $40
		frame_oam_tile $E8, $E1, $1300, 0
		frame_oam_tile $E8, $F1, $1600, 0
		frame_oam_tile $E8, $E9, $600,	0
		frame_oam_tile 0, $E9,	$400, $60
		frame_oam_tile 8, $E1,	$1000, $40
		frame_oam_tile 8, $D9,	0, $40
		frame_oam_tile 0, $E1,	$1200, 0
		frame_oam_tile 0, $D9,	$200, 0
		frame_oam_tile $F0, $E9, $400,	$20
		frame_oam_tile $F0, $D9, 0, $20
animation_frame_C545D2:.BYTE $17	       ; 0
		frame_oam_tile 0, $1A,	$2400, $60
		frame_oam_tile $F0, $1A, $2400, $20
		frame_oam_tile 0, $A, $2200, $20
		frame_oam_tile $F0, $A, $2000,	$20
		frame_oam_tile $10, $FA, $300,	$40
		frame_oam_tile $10, 2,	$700, $40
		frame_oam_tile $E8, 2,	$700, 0
		frame_oam_tile $E8, $FA, $300,	0
		frame_oam_tile 0, $FA,	$2600, $60
		frame_oam_tile $F0, $FA, $2600, $20
		frame_oam_tile $10, $F2, $1600, $40
		frame_oam_tile $10, $EA, $600,	$40
		frame_oam_tile $10, $E2, $1300, $40
		frame_oam_tile $E8, $E2, $1300, 0
		frame_oam_tile $E8, $F2, $1600, 0
		frame_oam_tile $E8, $EA, $600,	0
		frame_oam_tile 0, $EA,	$400, $60
		frame_oam_tile 8, $E2,	$1000, $40
		frame_oam_tile 8, $DA,	0, $40
		frame_oam_tile 0, $E2,	$1200, 0
		frame_oam_tile 0, $DA,	$200, 0
		frame_oam_tile $F0, $EA, $400,	$20
		frame_oam_tile $F0, $DA, 0, $20
animation_frame_C54646:.BYTE $15	       ; 0
		frame_oam_tile $20, $10, 2, $82
		frame_oam_tile $20, $E8, 2, 2
		frame_oam_tile $20, 8,	$1002, $82
		frame_oam_tile $20, $F0, $1002, 2
		frame_oam_tile $20, 0,	$2002, $82
		frame_oam_tile $20, $F8, $2002, 2
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C546B0:.BYTE $14	       ; 0
		frame_oam_tile $20, $E9, $3002, 2
		frame_oam_tile $20, $F1, $102,	2
		frame_oam_tile $20, 9,	$3102, 2
		frame_oam_tile $20, 1,	$2102, 2
		frame_oam_tile $20, $F9, $1102, 2
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C54715:.BYTE $13	       ; 0
		frame_oam_tile $20, $F0, $202,	2
		frame_oam_tile $20, 8,	$3202, 2
		frame_oam_tile $20, 0,	$2202, 2
		frame_oam_tile $20, $F8, $1202, 2
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C54775:.BYTE $13	       ; 0
		frame_oam_tile $20, $F0, $302,	2
		frame_oam_tile $20, 8,	$3302, 2
		frame_oam_tile $20, 0,	$2302, 2
		frame_oam_tile $20, $F8, $1302, 2
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C547D5:.BYTE $12	       ; 0
		frame_oam_tile $20, $F3, $402,	2
		frame_oam_tile $20, 3,	$2402, 2
		frame_oam_tile $20, $FB, $1402, 2
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C54830:.BYTE $12	       ; 0
		frame_oam_tile $20, $F3, $3402, 2
		frame_oam_tile $20, 3,	$1502, 2
		frame_oam_tile $20, $FB, $502,	2
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C5488B:.BYTE $11	       ; 0
		frame_oam_tile $20, 0,	$3502, 2
		frame_oam_tile $20, $F8, $2502, 2
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C548E1:.BYTE $11	       ; 0
		frame_oam_tile $20, 0,	$1602, 2
		frame_oam_tile $20, $F8, $602,	2
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C54937:.BYTE $11	       ; 0
		frame_oam_tile $20, 0,	$1702, 2
		frame_oam_tile $20, $F8, $702,	2
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C5498D:.BYTE $11	       ; 0
		frame_oam_tile $20, $F8, $1602, $82
		frame_oam_tile $20, 0,	$602, $82
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C549E3:.BYTE $11	       ; 0
		frame_oam_tile $20, $F8, $3502, $82
		frame_oam_tile $20, 0,	$2502, $82
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C54A39:.BYTE $12	       ; 0
		frame_oam_tile $20, 5,	$3402, $82
		frame_oam_tile $20, $F5, $1502, $82
		frame_oam_tile $20, $FD, $502,	$82
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C54A94:.BYTE $12	       ; 0
		frame_oam_tile $20, $F5, $2402, $82
		frame_oam_tile $20, 5,	$402, $82
		frame_oam_tile $20, $FD, $1402, $82
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C54AEF:.BYTE $13	       ; 0
		frame_oam_tile $20, $F0, $3302, $82
		frame_oam_tile $20, $F8, $2302, $82
		frame_oam_tile $20, 8,	$302, $82
		frame_oam_tile $20, 0,	$1302, $82
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C54B4F:.BYTE $13	       ; 0
		frame_oam_tile $20, $F0, $3202, $82
		frame_oam_tile $20, $F8, $2202, $82
		frame_oam_tile $20, 8,	$202, $82
		frame_oam_tile $20, 0,	$1202, $82
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C54BAF:.BYTE $14	       ; 0
		frame_oam_tile $20, $EF, $3102, $82
		frame_oam_tile $20, $F7, $2102, $82
		frame_oam_tile $20, $F, $3002,	$82
		frame_oam_tile $20, 7,	$102, $82
		frame_oam_tile $20, $FF, $1102, $82
		frame_oam_tile 8, $10,	$3601, 2
		frame_oam_tile 0, $10,	$2701, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, $10, $2601, 2
		frame_oam_tile $F8, 8,	$1401, 2
		frame_oam_tile $F0, 8,	$1401, 2
		frame_oam_tile $F0, $F0, $2201, 2
		frame_oam_tile $F8, $F0, $2201, 2
		frame_oam_tile $10, 0,	$601, $22
		frame_oam_tile 0, 0, $401, $22
		frame_oam_tile $10, $F0, $2401, $22
		frame_oam_tile 0, $F0,	$2201, $22
		frame_oam_tile $F0, $F8, $201,	$22
		frame_oam_tile $E0, 0,	$2001, $22
		frame_oam_tile $E0, $F0, 1, $22
animation_frame_C54C14:.BYTE 3		       ; 0
		frame_oam_tile $FC, 8,	$2003, 2
		frame_oam_tile 0, $F8,	3, $22
		frame_oam_tile $F0, $F8, $2602, $22
intro_related_animation:.BYTE 8
stru_C54C25:	animation_frame animation_frame_C54402, $10; 0
		animation_frame animation_frame_C54476, $10; 1
		animation_frame animation_frame_C544EA, $10; 2
		animation_frame animation_frame_C54476, $10; 3
		animation_frame animation_frame_C54402, $10; 4
		animation_frame animation_frame_C5455E, $10; 5
		animation_frame animation_frame_C545D2, $10; 6
		animation_frame animation_frame_C5455E, $10; 7
intro_related_animation2:.BYTE $10
		animation_frame animation_frame_C54646, 1; 0
		animation_frame animation_frame_C546B0, 1; 1
		animation_frame animation_frame_C54715, 2; 2
		animation_frame animation_frame_C54775, 2; 3
		animation_frame animation_frame_C547D5, 2; 4
		animation_frame animation_frame_C54830, 2; 5
		animation_frame animation_frame_C5488B, 2; 6
		animation_frame animation_frame_C548E1, 3; 7
		animation_frame animation_frame_C54937, 3; 8
		animation_frame animation_frame_C5498D, 3; 9
		animation_frame animation_frame_C549E3, 2; $A
		animation_frame animation_frame_C54A39, 2; $B
		animation_frame animation_frame_C54A94, 2; $C
		animation_frame animation_frame_C54AEF, 2; $D
		animation_frame animation_frame_C54B4F, 2; $E
		animation_frame animation_frame_C54BAF, 1; $F
byte_C54C86:	.BYTE 1
		animation_frame animation_frame_C54C14, $FF
.A8
.I16

sub_C54C8B:
		SEP	#$20
		LDA	#.LOBYTE(sub_C54CA2)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C54CA2)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C54CA2)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		RTL
; End of function sub_C54C8B

.A8
.I16

sub_C54CA2:
		REP	#$20
.A16
		LDA	#$20
		STA	z:$11,X
		LDA	#$20
		STA	z:$14,X
		LDA	#$520
		STA	z:$E,X
		LDA	#0
		STA	z:$1E,X
		LDA	#.LOWORD(intro_related_animation)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C54CD4)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54CD4)
		STA	z:2,X

loc_C54CD4:
		REP	#$20
.A16
		LDA	z:$10,X
		CLC
		ADC	#$20
		STA	z:$10,X
		LDA	#0
		ADC	z:$12,X
		STA	z:$12,X
		LDA	z:$11,X
		BMI	loc_C54CF2
		CMP	#$120
		BCC	loc_C54CF2
		JSL	f:delete_object

loc_C54CF2:
		JSL	f:load_animation_frame
		RTL
; End of function sub_C54CA2

.A8
.I16

sub_C54CF7:
		SEP	#$20
		LDA	#.LOBYTE(sub_C54D0E)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C54D0E)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C54D0E)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		RTL
; End of function sub_C54CF7

.A8
.I16

sub_C54D0E:
		REP	#$20
.A16
		LDA	#$120
		STA	z:$11,X
		LDA	#$50
		STA	z:$14,X
		LDA	#$520
		STA	z:$E,X
		LDA	#0
		STA	z:$1E,X
		LDA	#.LOWORD(intro_related_animation2)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C54D40)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54D40)
		STA	z:2,X

loc_C54D40:
		REP	#$20
.A16
		LDA	z:$10,X
		CLC
		ADC	#$FFA0
		STA	z:$10,X
		LDA	z:$12,X
		ADC	#$FF
		STA	z:$12,X
		LDA	z:$11,X
		BPL	loc_C54D5E
		CMP	#$FFE0
		BCS	loc_C54D5E
		JSL	f:delete_object

loc_C54D5E:
		JSL	f:load_animation_frame
		RTL
; End of function sub_C54D0E

.A8
.I16

sub_C54D63:
		SEP	#$20
		LDA	#.LOBYTE(sub_C54D7A)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C54D7A)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C54D7A)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		RTL
; End of function sub_C54D63

.A8
.I16

sub_C54D7A:
		REP	#$20
.A16
		LDA	#$50
		STA	z:$11,X
		LDA	#$70
		STA	z:$14,X
		LDA	#$520
		STA	z:$E,X
		LDA	#0
		STA	z:$1E,X
		LDA	#.LOWORD(byte_C54C86)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C54DAC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54DAC)
		STA	z:2,X

loc_C54DAC:
		REP	#$20
.A16
		LDA	z:$10,X
		CLC
		ADC	#$10
		STA	z:$10,X
		LDA	z:$12,X
		ADC	#0
		STA	z:$12,X
		LDA	z:$11,X
		CMP	#$120
		BCC	loc_C54DC8
		JSL	f:delete_object

loc_C54DC8:
		JSL	f:load_animation_frame
		RTL
; End of function sub_C54D7A

.A16
.I16

sub_C54DCD:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C54DEF)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C54DEF)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C54DEF)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		LDA	[$50]
		STA	a:.LOWORD($20),Y
		INC	z:$50
		INC	z:$50
		RTL
; End of function sub_C54DCD

.A16
.I16

sub_C54DEF:
		REP	#$20
		LDA	#.LOWORD(off_C54FC2)
		STA	z:$DB
		SEP	#$20
.A8
		LDA	#.BANKBYTE(off_C54FC2)
		STA	z:$DD
		REP	#$20
.A16
		LDA	#$30
		STA	z:$E,X
		LDA	#8
		STA	z:$1E,X
		LDY	z:$20,X
		LDA	[$DB],Y
		STA	z:$50
		INY
		INY
		LDA	[$DB],Y
		STA	z:$11,X
		INY
		INY
		LDA	[$DB],Y
		STA	z:$14,X
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C54E31)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54E31)
		STA	z:2,X

loc_C54E31:
		REP	#$20
.A16
		LDA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		BNE	locret_C54E49
		REP	#$20
		LDA	#.LOWORD(loc_C54E45)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54E45)
		STA	z:2,X

loc_C54E45:
		JSL	f:load_animation_frame
.A16

locret_C54E49:
		RTL
; End of function sub_C54DEF

.A16
.I16

sub_C54E4A:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C54E77)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C54E77)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C54E77)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		SEP	#$20
		LDA	#0
		STA	a:.LOWORD(player1_object+player::gameover_related)	; orig=0x0D44
		LDA	#0
		STA	a:.LOWORD(player2_object+player::gameover_related)	; orig=0x0D84
		LDA	#0
		STA	a:.LOWORD(player3_object+player::gameover_related)	; orig=0x0DC4
		LDA	#0
		STA	a:.LOWORD(player4_object+player::gameover_related)	; orig=0x0E04
		RTL
; End of function sub_C54E4A

.A8
.I16

sub_C54E77:
		SEP	#$20
		STZ	a:.LOWORD(level_manager_object+level_manager_object::level_representation) ; orig=0x0D24
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2) ; orig=0x0D16
		CMP	#$33
		BEQ	loc_C54E97
		CMP	#$34
		BEQ	loc_C54E97
		CMP	#$35
		BEQ	loc_C54E97
		CMP	#$36
		BEQ	loc_C54E97
		LDA	#$FF
		STA	a:.LOWORD(level_manager_object+$1F) ; orig=0x0D1F
		STZ	a:.LOWORD(word_7E0C8F) ; orig=0x0C8F

loc_C54E97:
		REP	#$20
.A16
		LDA	#$30
		STA	z:$E,X
		LDA	#8
		STA	z:$1E,X
		LDA	#$48
		STA	z:$11,X
		LDA	#$87
		STA	z:$14,X
		STZ	z:$20,X
		STZ	z:$22,X
		LDA	#$100
		STA	z:$24,X
		LDA	f:unk_C54FC4
		SEC
		SBC	#$48
		STA	z:$11,X
		LDA	#.LOWORD(byte_C51749)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C54EDC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54EDC)
		STA	z:2,X

loc_C54EDC:
		REP	#$20
.A16
		INC	z:$22,X
		LDA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		BEQ	loc_C54EE9
		JML	f:locret_C54E49
; ---------------------------------------------------------------------------

loc_C54EE9:
.IFNDEF J
		SEP	#$20
.A8
		LDA	a:.LOWORD(word_7E0CAE) ; orig=0x0CAE
		BNE	loc_C54F0D
		INC	a:.LOWORD(word_7E0CAE) ; orig=0x0CAE
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C54F01)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54F01)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C54F01:
		REP	#$20
.A16
		INC	z:$22,X
		DEC	z:$24,X
		BEQ	loc_C54F0D
		JML	f:locret_C54E49
; ---------------------------------------------------------------------------

loc_C54F0D:
.ENDIF
		REP	#$20
		LDA	#$460
		STA	z:$22,X
		REP	#$20
		LDA	#.LOWORD(sub_C54F22)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C54F22)
		STA	z:2,X
		RTL
; End of function sub_C54E77

.A8
.I16

sub_C54F22:
		JSL	f:sub_C5395A
		REP	#$20
.A16
		AND	#$FF
		BEQ	loc_C54F42
		LDA	z:$22,X
		CLC
		ADC	#$140
		STA	z:$22,X
		REP	#$20
		LDA	#.LOWORD(loc_C54F42)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54F42)
		STA	z:2,X

loc_C54F42:
		JSL	f:advance_animation
		REP	#$20
.A16
		INC	z:$7C
		DEC	z:$22,X
		BNE	loc_C54F52
		JML	f:loc_C55051
; ---------------------------------------------------------------------------

loc_C54F52:
; Sound test access
.IF FIX_JOYPAD_5_BUG
; Bugfix: the Japanese version did not verify Joypad 5 is connected.
		LDA	a:.LOWORD(joypad_5_connected) ; orig=0x0CEF
		AND	#$1F
		CMP	#1
		BNE	loc_C54F69
.ENDIF
		LDA	a:.LOWORD(joypad_5) ; orig=0x0CE9
		BIT	#$10
		BEQ	loc_C54F69
		JML	f:loc_C54FEA
; ---------------------------------------------------------------------------

loc_C54F69:
		JSL	f:sub_C5395A
		REP	#$20
		BIT	#$10
		BEQ	loc_C54F78
		JML	f:loc_C55006
; ---------------------------------------------------------------------------

loc_C54F78:
		BIT	#$2C
		BEQ	locret_C54FC1
		BIT	#$24
		BNE	loc_C54F8D
		DEC	z:$20,X
		BPL	loc_C54F98
		LDA	#2
		STA	z:$20,X
		BRA	loc_C54F98
; ---------------------------------------------------------------------------

loc_C54F8D:
		INC	z:$20,X
		LDA	z:$20,X
		CMP	#3
		BNE	loc_C54F98
		STZ	z:$20,X

loc_C54F98:
		REP	#$20
		LDA	#.LOWORD(word_C54FC6)
		STA	z:$DB
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C54FC6)
		STA	z:$DD
		REP	#$20
.A16
		LDA	z:$20,X
		ASL
		ASL
		ASL
		TAY
		LDA	[$DB],Y
		SEC
		SBC	#3
		STA	z:$14,X
		LDY	#0
		JSL	f:play_sound
		RTL
; ---------------------------------------------------------------------------

loc_C54FBD:
		JSL	f:advance_animation

locret_C54FC1:
		RTL
; ---------------------------------------------------------------------------
off_C54FC2:	.ADDR byte_C51735
unk_C54FC4:	.BYTE $90 ; ê
		.BYTE	0
word_C54FC6:	.BYTE $8A ; ä
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.ADDR byte_C5173A
		.BYTE $90 ; ê
		.BYTE	0
		.BYTE $98 ; ò
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.ADDR byte_C5173F
		.BYTE $90 ; ê
		.BYTE	0
		.BYTE $A6 ; ¶
		.BYTE	0
		.BYTE	0
		.BYTE	0
.IF TRADEMARK_LINE
		.ADDR byte_C51744
.ELSE
        .ADDR byte_C5177B
.ENDIF
		.BYTE $88 ; à
		.BYTE	0
		.BYTE $B7 ; ∑
		.BYTE	0
		.BYTE	0
		.BYTE	0
.IF DISPLAY_LICENSED_BY
		.ADDR byte_C51730
		.BYTE $8E ; é
		.BYTE	0
		.BYTE $BC ; º
		.BYTE	0
		.BYTE	0
		.BYTE	0
.ENDIF
; ---------------------------------------------------------------------------

loc_C54FEA:
		SEP	#$20
.A8
		LDA	#$3C
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		LDY	#1
		JSL	f:play_sound
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C54FBD)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54FBD)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------
.A16

loc_C55006:
		LDY	#1
		JSL	f:play_sound
		JSL	f:fade_out_music
		SEP	#$20
.A8
		LDA	z:$20,X
		CMP	#1
		BEQ	loc_C5503C
		CMP	#2
		BNE	loc_C55021
		JML	f:loc_C5509A
; ---------------------------------------------------------------------------

loc_C55021:
		LDA	#$39
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		JSL	f:sub_C550AF
		JSL	f:sub_C462BA
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C54FBD)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54FBD)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C5503C:
		SEP	#$20
		LDA	#$32
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C54FBD)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54FBD)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------
.A16

loc_C55051:
		SEP	#$20
.A8
		LDA	#0
		STA	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		LDA	#4
		STA	a:.LOWORD(level_manager_object+level_manager_object::gameover_related+1) ; orig=0x0D33
		LDA	#1
		STA	a:.LOWORD(word_7E0C5F) ; orig=0x0C5F
		LDA	#1
		STA	a:.LOWORD(word_7E0C5F+1) ;	orig=0x0C60
		LDA	#1
		STA	a:.LOWORD(word_7E0C61) ; orig=0x0C61
		LDA	#1
		STA	a:.LOWORD(word_7E0C61+1) ;	orig=0x0C62
		LDA	#9
		STA	a:.LOWORD(word_7E0C63) ; orig=0x0C63
		LDA	#0
		XBA
		PHX
		LDA	a:.LOWORD(level_manager_object+$1F) ; orig=0x0D1F
		INC

loc_C5507E:
		STA	a:.LOWORD(level_manager_object+$1F) ; orig=0x0D1F
		TAX
		LDA	f:demo_screens_list,X
		BEQ	loc_C5507E
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		PLX
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C54FBD)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54FBD)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C5509A:
		SEP	#$20
		LDA	#$38
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C54FBD)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C54FBD)
		STA	z:2,X
		RTL
; End of function sub_C54F22

.A8
.I16

sub_C550AF:
		SEP	#$20
		LDA	#5
		STA	z:$40
		LDA	a:.LOWORD(word_7E0C8F) ; orig=0x0C8F
		BEQ	loc_C550C1
		LDA	#9
		STA	z:$40
		STZ	a:.LOWORD(word_7E0C8F) ; orig=0x0C8F

loc_C550C1:
		LDA	#$FF
		STA	a:.LOWORD(player1_object+player::gameover_related)	; orig=0x0D44
		LDA	z:$40
		STA	a:.LOWORD(player1_object+player::number_of_lives) ; orig=0x0D7D
		LDA	#0
		STA	a:.LOWORD(player2_object+player::gameover_related)	; orig=0x0D84
		LDA	#0
		STA	a:.LOWORD(player2_object+player::number_of_lives) ; orig=0x0DBD
		LDA	a:.LOWORD(joypad_2_pressed+1) ; orig=0x0CFB
		BIT	#$10
		BEQ	loc_C550F0
		LDA	#0
		STA	a:.LOWORD(player1_object+player::gameover_related)	; orig=0x0D44
		LDA	#0
		STA	a:.LOWORD(player1_object+player::number_of_lives) ; orig=0x0D7D
		LDA	#$FF
		STA	a:.LOWORD(player2_object+player::gameover_related)	; orig=0x0D84
		LDA	z:$40
		STA	a:.LOWORD(player2_object+player::number_of_lives) ; orig=0x0DBD

loc_C550F0:
		LDA	#0
		STA	a:.LOWORD(player3_object+player::gameover_related)	; orig=0x0DC4
		LDA	#0
		STA	a:.LOWORD(player4_object+player::gameover_related)	; orig=0x0E04
		LDA	#1
		STA	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		RTL
; End of function sub_C550AF

.A8
.I16

sub_C55100:
		SEP	#$20
		LDA	#5
		STA	z:$40
		LDA	a:.LOWORD(word_7E0C8F) ; orig=0x0C8F
		BEQ	loc_C55112
		LDA	#9
		STA	z:$40
		STZ	a:.LOWORD(word_7E0C8F) ; orig=0x0C8F

loc_C55112:
		LDA	#$FF
		STA	a:.LOWORD(player1_object+player::gameover_related)	; orig=0x0D44
		LDA	z:$40
		STA	a:.LOWORD(player1_object+player::number_of_lives) ; orig=0x0D7D
		LDA	#0
		STA	a:.LOWORD(player2_object+player::gameover_related)	; orig=0x0D84
		LDA	#0
		STA	a:.LOWORD(player2_object+player::number_of_lives) ; orig=0x0DBD
		REP	#$20
.A16
		LDA	a:.LOWORD(joypad_2_pressed) ; orig=0x0CFA
		BIT	#$1080
		BEQ	loc_C55146
		SEP	#$20
.A8
		LDA	#0
		STA	a:.LOWORD(player1_object+player::gameover_related)	; orig=0x0D44
		LDA	#0
		STA	a:.LOWORD(player1_object+player::number_of_lives) ; orig=0x0D7D
		LDA	#$FF
		STA	a:.LOWORD(player2_object+player::gameover_related)	; orig=0x0D84
		LDA	z:$40
		STA	a:.LOWORD(player2_object+player::number_of_lives) ; orig=0x0DBD

loc_C55146:
		SEP	#$20
		LDA	#0
		STA	a:.LOWORD(player3_object+player::gameover_related)	; orig=0x0DC4
		LDA	#0
		STA	a:.LOWORD(player4_object+player::gameover_related)	; orig=0x0E04
		LDA	#1
		STA	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		RTL
; End of function sub_C55100

; ---------------------------------------------------------------------------
demo_screens_list:
.IF SHOW_INTRODUCTION
    	.BYTE $33,  $34, $33,  $35,	$33,  $36, 0
.ELSE
    	.BYTE $34, $35,	$36, 0
.ENDIF
.A8
.I16

tile_animation:
		SEP	#$20
		LDA	#.LOBYTE(sub_C551B7)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C551B7)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C551B7)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	loc_C551AC
		LDA	[$50]
		STA	z:$53
		STA	a:.LOWORD($16),Y
		INC	z:$50
		LDA	[$50]
		STA	z:$54
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		ASL
		ASL
		ASL
		ASL
		STA	a:.LOWORD($20),Y
		INC	z:$50
		INC	z:$50
		LDA	#$FFFF
		STA	a:.LOWORD($B),Y
		LDA	[$53]
		AND	#$FF
		STA	a:.LOWORD($D),Y
		SEP	#$20
.A8
		LDA	#2
		STA	a:.LOWORD(3),Y
		RTL
; ---------------------------------------------------------------------------
		REP	#$20
.A16

loc_C551AC:
		INC	z:$50
		INC	z:$50
		INC	z:$50
		INC	z:$50
		INC	z:$50
		RTL
; End of function tile_animation

.A16
.I16

sub_C551B7:
		LDA	#.BANKBYTE(sub_C551F3)
		STA	z:$52
		REP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$80
		BNE	locret_C551F2
		INC	z:$B,X
		LDA	z:$B,X
		CMP	z:$D,X
		BNE	loc_C551D3
		LDA	#0
		STA	z:$B,X

loc_C551D3:
		ASL
		ADC	z:$16,X
		INC
		STA	z:$50
		LDA	[$50]
		STA	z:$42
		LDA	z:$20,X
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(sub_C551F3)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C551F3)
		STA	z:$52
		JSL	f:sub_C62514

locret_C551F2:
		RTL
; End of function sub_C551B7

.A8
.I16

sub_C551F3:
		REP	#$20
.A16
		LDA	z:$40
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$40
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		LDA	z:$42
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#$80
		STA	a:.LOWORD(VRAM_ADDRESS_INCREMENT_VALUE)
		LDA	#1
		STA	a:.LOWORD(DMA_4_PARAMS)
		LDA	#$18
		STA	a:.LOWORD(DMA_4_B_ADDRESS)
		LDA	#$C1
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		LDA	#$10
		STA	a:.LOWORD(REGULAR_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	z:$40
		ORA	#$100
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	z:$42
		ORA	#$200
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		LDA	#$40
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#$10
		STA	a:.LOWORD(REGULAR_DMA_CHANNEL_ENABLE)
		RTL
; End of function sub_C551F3

.A8
.I16

sub_C55240:
		SEP	#$20
		LDA	#.LOBYTE(sub_C55267)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C55267)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C55267)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	loc_C55264
		LDA	[$50]
		STA	a:.LOWORD($30),Y
		LDA	z:$48
		STA	a:.LOWORD($31),Y

loc_C55264:
		INC	z:$50
		RTL
; End of function sub_C55240

.A16
.I16

sub_C55267:
		REP	#$20
		LDA	#.LOWORD(battle_menu_items)
		STA	z:$DB
		SEP	#$20
.A8
		LDA	#.BANKBYTE(battle_menu_items)
		STA	z:$DD
		SEP	#$20
		LDA	#$30
		STA	z:$E,X
		LDA	#0
		STA	z:$F,X
		LDA	#0
		STA	z:$20,X
		REP	#$20
.A16

loc_C55284:
		LDA	z:$30,X
		AND	#$FF
		ASL
		ASL
		ASL
		ASL
		TAY
		LDA	[$DB],Y
		STA	z:player::x_position,X
		INY
		INY
		LDA	[$DB],Y
		STA	z:player::y_position,X
		INY
		INY
		INY
		INY
		LDA	[$DB],Y
		STA	z:$53
		INY
		INY
		LDA	[$DB],Y
		STA	z:$1E,X
		LDA	z:$30,X
		AND	#$FF
		CLC
		ADC	#.LOWORD(word_7E0C5F)
		STA	z:$50
		LDA	z:$30,X
		CMP	#4
		BCS	loc_C552D5
		AND	#$FF
		PHY
		TAY
		SEP	#$20
.A8
		LDA	a:.LOWORD(joypad_1_connected),Y
		STA	z:$40
		PLY
		LDA	z:$40
.IF JOYPAD_RELATED_BUGFIX
		AND	#$1F
		CMP	#1
		BEQ	loc_C552D5
.ELSE
		BNE	loc_C552D5
.ENDIF
		LDA	($50)
		BNE	loc_C552D5
		LDA	#1
		STA	($50)

loc_C552D5:
		SEP	#$20
		LDA	#$C3
		STA	z:$55
		REP	#$20
.A16
		LDA	($50)
		AND	#$FF
		ASL
		TAY
		LDA	[$53],Y
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C5530B)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C5530B)
		STA	z:2,X
		SEP	#$20
		LDA	z:$30,X
		CMP	#6
		BNE	loc_C5530B
		JSL	f:sub_C553CF

loc_C5530B:
		REP	#$20
.A16
		LDA	#.LOWORD(battle_menu_items+battle_menu_item::max_value)
		STA	z:$DB
		SEP	#$20
.A8
		LDA	#.BANKBYTE(battle_menu_items+battle_menu_item::max_value)
		STA	z:$DD
		SEP	#$20
		LDY	z:$31,X
		LDA	a:.LOWORD($3F),Y
		BEQ	loc_C55325
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55325:
		LDA	a:.LOWORD($20),Y
		CMP	z:$30,X
		BNE	loc_C5539A
		LDA	a:.LOWORD(level_manager_object+level_manager_object::soft_blocks+1) ; orig=0x0D3D
		BNE	loc_C5539A
		REP	#$20
.A16
		LDA	z:$30,X
		AND	#$FF
		PHA
		CLC
		ADC	#$C5F
		STA	z:$53
		PLA
		ASL
		ASL
		ASL
		ASL
		TAY
		SEP	#$20
.A8
		LDA	a:.LOWORD(level_manager_object+level_manager_object::soft_blocks) ; orig=0x0D3C
		AND	#3
		BEQ	loc_C5539A
		BIT	#1
		BNE	loc_C55360
		LDA	($53)
		DEC
		STA	($53)
		BPL	loc_C5536D
		LDA	[$DB],Y
		DEC
		STA	($53)
		BRA	loc_C5536D
; ---------------------------------------------------------------------------

loc_C55360:
		LDA	($53)
		INC
		STA	($53)
		CMP	[$DB],Y
		BNE	loc_C5536D
		LDA	#0
		STA	($53)

loc_C5536D:
		LDA	z:$30,X
		CMP	#4
		BCC	loc_C5539F

loc_C55373:
		LDA	#6
		STA	a:.LOWORD(level_manager_object+level_manager_object::soft_blocks+1) ; orig=0x0D3D
		REP	#$20
.A16
		INY
		INY
		LDA	[$DB],Y
		STA	z:$50
		LDA	($53)
		AND	#$FF
		ASL
		TAY
		LDA	#$C3
		STA	z:$52
		LDA	[$50],Y
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation

loc_C5539A:
		JSL	f:sub_C55710
		RTL
; ---------------------------------------------------------------------------

loc_C5539F:
		REP	#$20
.A16
		LDA	z:$30,X
		AND	#$FF
		PHY
		TAY
		SEP	#$20
.A8
.A8
		LDA	a:.LOWORD(joypad_1_connected),Y
		STA	z:$40
		PLY
		LDA	z:$40
.IF JOYPAD_RELATED_BUGFIX
		AND	#$1F
		CMP	#1
		BEQ	loc_C55373
.ELSE
		BNE	loc_C55373
.ENDIF
		LDA	($53)
		BNE	loc_C55373
		LDA	a:.LOWORD(level_manager_object+level_manager_object::soft_blocks) ; orig=0x0D3C
		BIT	#1
		BNE	loc_C553C9
		LDA	#2
		STA	($53)
		BRA	loc_C55373
; ---------------------------------------------------------------------------

loc_C553C9:
		LDA	#1
		STA	($53)
		BRA	loc_C55373
; End of function sub_C55267

.A8
.I16

sub_C553CF:
		SEP	#$20
		LDA	#.LOBYTE(sub_C553F3)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C553F3)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C553F3)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C553ED
		JML	f:loc_C55264
; ---------------------------------------------------------------------------

loc_C553ED:
		LDA	z:$31,X
		STA	a:.LOWORD($31),Y
		RTL
; End of function sub_C553CF

.A16
.I16

sub_C553F3:
		SEP	#$20
.A8
		LDA	#$30
		STA	z:$E,X
		LDA	#0
		STA	z:$F,X
		LDA	#0
		STA	z:$1E,X
		LDA	#$FF
		STA	z:$20,X
		REP	#$20
.A16
		LDA	#$88
		STA	z:$11,X
		LDA	#$180
		STA	z:$14,X
		REP	#$20
		LDA	#.LOWORD(loc_C5541E)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C5541E)
		STA	z:2,X

loc_C5541E:
		SEP	#$20
		LDY	z:$31,X
		LDA	a:.LOWORD($3F),Y
		BEQ	loc_C5542B
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C5542B:
		LDA	a:.LOWORD(word_7E0C65) ; orig=0x0C65
		CMP	z:$20,X
		BEQ	loc_C55457
		STA	z:$20,X
		REP	#$20
.A16
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:battle_stages_labels,X
		STA	z:$50
		PLX
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	z:$20,X
		STA	z:$40
		JSL	f:sub_C4730D

loc_C55457:
		JSL	f:sub_C55710
		RTL
; End of function sub_C553F3

.A8
.I16

sub_C5545C:
		SEP	#$20
		LDA	#$18
		STA	a:.LOWORD(V_COUNT_TIMER)
		LDA	#$A0
		STA	a:.LOWORD(H_COUNT_TIMER)
		REP	#$20
.A16
		LDA	#.LOWORD(locret_C53A06)
		STA	a:.LOWORD(unknown_function_pointer) ; orig=0x00D0
		SEP	#$20
.A8
		LDA	#.BANKBYTE(locret_C53A06)
		STA	a:.LOWORD(unknown_function_pointer+2) ; orig=0x00D2
		RTL
; End of function sub_C5545C

.A8
.I16

sub_C55478:
		SEP	#$20
		LDA	#$20
		STA	a:.LOWORD(V_COUNT_TIMER)
		LDA	#$B8
		STA	a:.LOWORD(H_COUNT_TIMER)
		REP	#$20
.A16
		LDA	#.LOWORD(locret_C53A06)
		STA	a:.LOWORD(unknown_function_pointer) ; orig=0x00D0
		SEP	#$20
.A8
		LDA	#.BANKBYTE(locret_C53A06)
		STA	a:.LOWORD(unknown_function_pointer+2) ; orig=0x00D2
		REP	#$20
.A16
		LDA	#$3FF
		STA	a:.LOWORD(bg3_v_scroll) ; orig=0x0CA5
		RTL
; End of function sub_C55478

.A16
.I16

sub_C5549C:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C554FC)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C554FC)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C554FC)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCS	nullsub_8
		REP	#$20
.A16
		TYA
		STA	z:$48
		LDA	#8
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	#$3E8
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		LDA	#$F
		STA	a:.LOWORD(level_manager_object+level_manager_object::field_3E) ;	orig=0x0D3E
		SEP	#$20
.A8
		LDA	#0
		STA	a:.LOWORD($32),Y
		LDA	#0
		STA	a:.LOWORD($34),Y
		LDA	#1
		STA	a:.LOWORD($33),Y
		LDA	#0
		STA	a:.LOWORD($3F),Y
		REP	#$20
.A16
		LDA	#2
		STA	a:.LOWORD(unknown_object+$20) ; orig=0x0FE0
		LDA	#$428
		STA	a:.LOWORD(unknown_object+$22) ; orig=0x0FE2
		LDA	a:.LOWORD(unknown_object+$22) ; orig=0x0FE2
		STA	a:.LOWORD(bg3_v_scroll_2) ; orig=0x0CA7
		LDA	#$20
		STA	a:.LOWORD(bg3_v_scroll) ; orig=0x0CA5
; End of function sub_C5549C

nullsub_8:
        RTL
.A8
.I16

sub_C554FC:
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2) ; orig=0x0D16
		CMP	#$31
		BNE	loc_C55528
		LDA	#0
		STA	a:.LOWORD(word_7E0C5F) ; orig=0x0C5F
		LDA	#0
		STA	a:.LOWORD(word_7E0C5F+1) ;	orig=0x0C60
		LDA	#0
		STA	a:.LOWORD(word_7E0C61) ; orig=0x0C61
		LDA	#0
		STA	a:.LOWORD(word_7E0C61+1) ;	orig=0x0C62
		LDA	#0
		STA	a:.LOWORD(word_7E0C63) ; orig=0x0C63
		LDA	#0
		STA	a:.LOWORD(word_7E0C63+1) ;	orig=0x0C64
		LDA	#0
		STA	a:.LOWORD(word_7E0C65) ; orig=0x0C65

loc_C55528:
		LDA	#0
		STA	z:$20,X
		LDA	#$20
		STA	a:.LOWORD(level_manager_object+level_manager_object::soft_blocks+1) ; orig=0x0D3D
		LDA	#0
		STA	z:$22,X
		LDA	#0
		STA	z:$1E,X
		REP	#$20
.A16
		LDA	#$30
		STA	z:$E,X
		LDA	f:word_C5562F
		STA	z:$11,X
		LDA	f:word_C5562F+2
		STA	z:$14,X
		REP	#$20
		LDA	#.LOWORD(sub_C5545C)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C5545C)
		STA	z:$52
		JSL	f:sub_C62514
		JSL	f:sub_C5572F
		REP	#$20
.A16
		LDA	#.LOWORD(byte_C500A1)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C55580)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C55580)
		STA	z:2,X
		RTL
; End of function sub_C554FC

.A8
.I16

sub_C55580:
		REP	#$20
.A16
		LDA	#$A00

loc_C55585:
		DEC
		BNE	loc_C55585
		SEP	#$20
.A8
		LDA	z:$22,X
		BEQ	loc_C55592
		JML	f:loc_C5561E
; ---------------------------------------------------------------------------

loc_C55592:
		JSL	f:sub_C53964
		SEP	#$20
		STA	a:.LOWORD(level_manager_object+level_manager_object::soft_blocks) ; orig=0x0D3C
		LDA	a:.LOWORD(level_manager_object+level_manager_object::soft_blocks+1) ; orig=0x0D3D
		BEQ	loc_C555A6
		DEC	a:.LOWORD(level_manager_object+level_manager_object::soft_blocks+1) ; orig=0x0D3D
		JMP	a:.LOWORD(loc_C5561E)
; ---------------------------------------------------------------------------

loc_C555A6:
		JSL	f:sub_C5395A
		SEP	#$20
		BIT	#$10
		BEQ	loc_C555B4
		JML	f:loc_C55661
; ---------------------------------------------------------------------------

loc_C555B4:
		LDA	a:.LOWORD(level_manager_object+level_manager_object::soft_blocks) ; orig=0x0D3C
		AND	#$C
		BNE	loc_C555BF
		JML	f:loc_C5561E
; ---------------------------------------------------------------------------

loc_C555BF:
		BIT	#4
		BNE	loc_C555D7
		DEC	z:$20,X
		LDA	z:$20,X
		CMP	#4
		BNE	loc_C555CF
		LDA	#1
		STA	z:$22,X

loc_C555CF:
		LDA	z:$20,X
		BPL	loc_C555ED
		STZ	z:$20,X
		BRA	loc_C5561E
; ---------------------------------------------------------------------------

loc_C555D7:
		INC	z:$20,X
		LDA	z:$20,X
		CMP	#5
		BNE	loc_C555E3
		LDA	#2
		STA	z:$22,X

loc_C555E3:
		CMP	#7
		BNE	loc_C555ED
		LDA	#6
		STA	z:$20,X
		BRA	loc_C5561E
; ---------------------------------------------------------------------------

loc_C555ED:
		LDA	#6
		STA	a:.LOWORD(level_manager_object+level_manager_object::soft_blocks+1) ; orig=0x0D3D
		PHA
		LDY	#0
		JSL	f:play_sound
		SEP	#$20
		PLA
		REP	#$20
.A16
		LDA	#.LOWORD(word_C5562F)
		STA	z:$DB
		SEP	#$20
.A8
		LDA	#.BANKBYTE(word_C5562F)
		STA	z:$DD
		REP	#$20
.A16
		LDA	z:$20,X
		AND	#$FF
		ASL
		ASL
		TAY
		LDA	[$DB],Y
		STA	z:$11,X
		INY
		INY
		LDA	[$DB],Y
		STA	z:$14,X
.A8

loc_C5561E:
		JSL	f:sub_C55710
		RTL
; ---------------------------------------------------------------------------

loc_C55623:
		LDY	#$1D
		JSL	f:play_sound
		JSL	f:sub_C55710
		RTL
; ---------------------------------------------------------------------------
word_C5562F:	.WORD $2C, $18,	$2C, $38, $2C, $58, $2C
		.WORD $78, $2C,	$98, $30, $118,	$30, $138
; ---------------------------------------------------------------------------

loc_C5564B:
		SEP	#$20
		STA	z:$42
		STZ	z:$40
		LDY	#3

loc_C55654:
		LDA	a:.LOWORD($C5F),Y
		CMP	z:$42
		BNE	loc_C5565D
		INC	z:$40

loc_C5565D:
		DEY
		BPL	loc_C55654
		RTL
; ---------------------------------------------------------------------------

loc_C55661:
		SEP	#$20
		LDA	z:$20,X
		CMP	#5
		BCS	loc_C55674
		LDA	#5
		STA	z:$20,X
		LDA	#2
		STA	z:$22,X
		JMP	a:.LOWORD(loc_C555ED)
; ---------------------------------------------------------------------------

loc_C55674:
		SEP	#$20
		LDA	#0
		JSL	f:loc_C5564B
		LDA	z:$40
		STA	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		LDA	#1
		JSL	f:loc_C5564B
		LDA	z:$40
		STA	a:.LOWORD(level_manager_object+level_manager_object::gameover_related+1) ; orig=0x0D33
		CLC
		ADC	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		CMP	#2
		BCS	loc_C55698
		JML	f:loc_C55623
; ---------------------------------------------------------------------------

loc_C55698:
		LDY	#1
		JSL	f:play_sound
		SEP	#$20
		LDA	f:word_C32F81
		CLC
		ADC	a:.LOWORD(word_7E0C65) ; orig=0x0C65
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		STA	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		LDA	a:.LOWORD(word_7E0C63+1) ;	orig=0x0C64
		STA	a:.LOWORD(level_manager_object+$34) ; orig=0x0D34
		LDA	#$FF
		STA	z:$3F,X
		PHX
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_8) ; orig=0x0D30
		PHA
		LDA	#3
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_8) ; orig=0x0D30
		JSL	f:hud_related_0
		JSL	f:loc_C40816
		SEP	#$20
		PLA
		STA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_8) ; orig=0x0D30
		PLX
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C55478)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C55478)
		STA	z:$52
		JSL	f:sub_C62514
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C556F1)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C556F1)
		STA	z:2,X
		RTL
; End of function sub_C55580

.A8
.I16

sub_C556F1:
		PHX
		LDX	#$FC0
		JSL	f:loc_C60045
		SEP	#$20
		LDA	z:$20,X
		PLX
		CMP	#0
		BNE	locret_C5570F
		REP	#$20
.A16
		LDA	#.LOWORD(battle_stage_loader)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(battle_stage_loader)
		STA	z:2,X

locret_C5570F:
		RTL
; End of function sub_C556F1

.A16
.I16

sub_C55710:
		REP	#$20
		LDA	z:$14,X
		PHA
		LDA	a:.LOWORD(level_manager_object+level_manager_object::field_3E) ;	orig=0x0D3E
		SEC
		SBC	#$13
		STA	z:$40
		LDA	z:$14,X
		SEC

loc_C55721:
		SBC	z:$40
		STA	z:$14,X
		JSL	f:load_animation_frame
		REP	#$20
		PLA
		STA	z:$14,X
		RTL
; End of function sub_C55710

.A8
.I16

sub_C5572F:
		SEP	#$20
		LDA	#.LOBYTE(sub_C5574C)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C5574C)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C5574C)
		STA	z:$DD
		LDA	#$20
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		TXA
		STA	a:.LOWORD($30),Y
		RTL
; End of function sub_C5572F

.A16
.I16

sub_C5574C:
		SEP	#$20
.A8
		LDY	z:$30,X
		LDA	a:.LOWORD($3F),Y
		BEQ	loc_C55759
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55759:
		LDA	a:.LOWORD($22),Y
		BEQ	locret_C55793
		CMP	#1
		BEQ	loc_C5577B
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::field_3E) ;	orig=0x0D3E
		CLC
		ADC	#$20
		STA	a:.LOWORD(level_manager_object+level_manager_object::field_3E) ;	orig=0x0D3E
		CMP	#$10F
		BNE	locret_C55793
		SEP	#$20
.A8
		LDA	#0
		STA	a:.LOWORD($22),Y
		RTL
; ---------------------------------------------------------------------------

loc_C5577B:
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::field_3E) ;	orig=0x0D3E
		SEC
		SBC	#$20
		STA	a:.LOWORD(level_manager_object+level_manager_object::field_3E) ;	orig=0x0D3E
		CMP	#$F
		BNE	locret_C55793
		SEP	#$20
.A8
		LDA	#0
		STA	a:.LOWORD($22),Y

locret_C55793:
		RTL
; End of function sub_C5574C

.A8
.I16

sub_C55794:
		SEP	#$20
		LDA	#.LOBYTE(sub_C557DF)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C557DF)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C557DF)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		LDA	[$50]
		STA	a:.LOWORD($1E),Y
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD($E),Y
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD($11),Y
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD($14),Y
		INC	z:$50
		INC	z:$50
		LDA	[$50]
		STA	a:.LOWORD($16),Y
		INC	z:$50
		INC	z:$50
		LDA	z:$48
		STA	a:.LOWORD($31),Y
		RTL
; End of function sub_C55794

.A16
.I16

sub_C557DF:
		REP	#$20
		LDA	z:$16,X
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C557FD)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C557FD)
		STA	z:2,X
		RTL
; End of function sub_C557DF

.A8
.I16

sub_C557FD:
		SEP	#$20
		LDY	z:$31,X
		LDA	a:.LOWORD($3F),Y
		BEQ	loc_C5580A
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C5580A:
		JSL	f:sub_C55710
		RTL
; End of function sub_C557FD

.A8
.I16

sub_C5580F:
		SEP	#$20
		LDA	#.LOBYTE(sub_C5582C)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C5582C)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C5582C)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCC	locret_C5582B
		JML	f:nullsub_8
; ---------------------------------------------------------------------------

locret_C5582B:
		RTL
; End of function sub_C5580F

.A8
.I16

sub_C5582C:
		REP	#$20
.A16
		LDA	#4
		STA	z:$1E,X
		LDA	#$830
		STA	z:$E,X
		LDA	#$88
		STA	z:$11,X
		LDA	#$1BC
		STA	z:$14,X
		LDA	#.LOWORD(byte_C514A4)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C5585F)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C5585F)
		STA	z:2,X
		RTL
; End of function sub_C5582C

.A8
.I16

sub_C5585F:
		JSL	f:sub_C55710
		RTL
; End of function sub_C5585F

.A8
.I16

create_flower_zone_handler:
		SEP	#$20
		LDA	#.LOBYTE(flower_zone_handler)
		STA	z:$DB
		LDA	#.HIBYTE(flower_zone_handler)
		STA	z:$DC
		LDA	#.BANKBYTE(flower_zone_handler)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCC	locret_C55880
		JML	f:nullsub_8
; ---------------------------------------------------------------------------

locret_C55880:
		RTL
; End of function create_flower_zone_handler

.A8
.I16

flower_zone_handler:
		SEP	#$20
		LDA	#$38
		STA	f:palette_allocation_related_array+3
		LDA	#2
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$15
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#2
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#$22
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		JSL	f:sub_C53E80
		REP	#$20
.A16
		LDA	#.LOWORD(_flower_zone_handler)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(_flower_zone_handler)
		STA	z:2,X
		RTL
; End of function flower_zone_handler

.A8
.I16

_flower_zone_handler:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$80
		BNE	locret_C55909
		LDA	#0
		STA	z:$20,X
		LDA	#5
		STA	z:$20,X
		LDY	#7
		LDA	#$38
		STA	z:$40
		LDA	#3
		JSL	f:palette_related
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C558DB)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C558DB)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C558DB:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C558E8
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C558E8:
		BIT	#$41
		BEQ	loc_C558F0
		JML	f:locret_C55909
; ---------------------------------------------------------------------------

loc_C558F0:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	locret_C55909
		JSL	f:create_flower_creator
		JSL	f:random2
		REP	#$20
		AND	#$FF
		CLC
		ADC	#$40
		STA	z:$20,X
.A8

locret_C55909:
		RTL
; End of function _flower_zone_handler

; ---------------------------------------------------------------------------
word_C5590A:	.WORD $844, $844, $844,	$844, $844
		.WORD $844, $844, $844,	$844, $844
		.WORD $844, $844, $846,	$846, $846
		.WORD $846, $846, $846,	$846, $846
		.WORD $846, $846, $846,	$846, $848
		.WORD $848, $848, $848,	$848, $848
		.WORD $848, $848, $848,	$848, $848
		.WORD $84A, $84A, $84A,	$84A, $84A
		.WORD $84A, $84A, $84A,	$84A, $84A
		.WORD $84A, $84C, $84C,	$84C, $84C
		.WORD $84C, $84C, $84C,	$84C, $84C
		.WORD $84E, $84E, $84E,	$84E, $84E
		.WORD $84E, $84E, $84E,	$806
.A16
.I16

create_flower_creator:
		SEP	#$20
.A8
		LDA	#.LOBYTE(flower_creator)
		STA	z:$DB
		LDA	#.HIBYTE(flower_creator)
		STA	z:$DC
		LDA	#.BANKBYTE(flower_creator)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCC	locret_C559A6
		JML	f:nullsub_8
; ---------------------------------------------------------------------------

locret_C559A6:
		RTL
; End of function create_flower_creator

.A8
.I16

flower_creator:
		REP	#$20
.A16
		PHX
		LDX	#$D
		JSL	f:random
		SEP	#$20
.A8
		INC
		INC
		ASL
		ASL
		ASL
		ASL
		ORA	#8
		STA	z:$40
		REP	#$20
.A16
		LDX	#$B
		LDA	z:$40
		PHA
		JSL	f:random
		SEP	#$20
.A8
		INC
		ASL
		ASL
		ASL
		ASL
		ORA	#8
		STA	z:$42
		REP	#$20
.A16
		PLA
		STA	z:$40
		PLX
		LDA	z:$40
		AND	#$F0
		LSR
		LSR
		LSR
		STA	z:$40
		LDA	z:$42
		AND	#$F0
		ASL
		ASL
		ADC	z:$40
		TAY
		CPY	#$44
		BNE	loc_C559F7
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C559F7:
		CPY	#$46
		BNE	loc_C55A00
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55A00:
		CPY	#$84
		BNE	loc_C55A09
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55A09:
		CPY	#$5A
		BNE	loc_C55A12
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55A12:
		CPY	#$5C
		BNE	loc_C55A1B
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55A1B:
		CPY	#$9C
		BNE	loc_C55A24
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55A24:
		CPY	#$284
		BNE	loc_C55A2D
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55A2D:
		CPY	#$2C4
		BNE	loc_C55A36
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55A36:
		CPY	#$2C6
		BNE	loc_C55A3F
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55A3F:
		CPY	#$29C
		BNE	loc_C55A48
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55A48:
		CPY	#$2DC
		BNE	loc_C55A51
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55A51:
		CPY	#$2DA
		BNE	loc_C55A5A
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55A5A:
		LDA	a:.LOWORD(collision_map),Y
		AND	#BONUS_MASK|BOMB|SOFT_BLOCK|HARD_BLOCK
		BEQ	loc_C55A66
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55A66:
		STY	z:$12,X
		STZ	z:$10,X
		REP	#$20
		LDA	#.LOWORD(loc_C55A77)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C55A77)
		STA	z:2,X

loc_C55A77:
		SEP	#$20
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$90
		BEQ	loc_C55A84
		JML	f:locret_C30015
; ---------------------------------------------------------------------------

loc_C55A84:
		BIT	#$41
		BEQ	loc_C55A8C
		JML	f:locret_C55ABD
; ---------------------------------------------------------------------------

loc_C55A8C:
		REP	#$20
.A16
		LDY	z:$12,X
		LDA	a:.LOWORD(collision_map),Y
		CMP	#$580
		BNE	loc_C55A9C
		JML	f:delete_object
; ---------------------------------------------------------------------------

loc_C55A9C:
		LDA	z:$10,X
		PHX
		TAX
		LDA	f:word_C5590A,X
		STA	a:.LOWORD(bg1_tilemap),Y
		LDA	#$40
		STA	a:.LOWORD(collision_map),Y
		PLX
		INC	z:$10,X
		INC	z:$10,X
		LDA	z:$10,X
		CMP	#$80
		BNE	locret_C55ABD
		JML	f:delete_object
; ---------------------------------------------------------------------------
.A8

locret_C55ABD:
		RTL
; End of function flower_creator

.A8
.I16

create_spotlight:
		SEP	#$20
		LDA	#.LOBYTE(spotlight)
		STA	z:$DB
		LDA	#.HIBYTE(spotlight)
		STA	z:$DC
		LDA	#.BANKBYTE(spotlight)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCC	locret_C55ADA
		JML	f:nullsub_8
; ---------------------------------------------------------------------------

locret_C55ADA:
		RTL
; End of function create_spotlight

.A8
.I16

spotlight:
		SEP	#$20
		LDA	#6
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$11
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#2
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#$83
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		REP	#$20
.A16
		LDA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		STA	z:$11,X
		LDA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		STA	z:$14,X
		LDA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		STA	z:$31,X
		LDA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		STA	z:$34,X
		STZ	z:$16,X
		STZ	z:$18,X
		STZ	z:$36,X
		STZ	z:$38,X
		STZ	z:$20,X
		PHX
		JSL	f:sub_C55C34
		TXA
		ORA	#$20
		TAX
		JSL	f:sub_C55C34
		PLX
		REP	#$20
		LDA	#.LOWORD(loc_C55B2D)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C55B2D)
		STA	z:2,X

loc_C55B2D:
		REP	#$20
.A16
		LDA	z:$20,X
		EOR	#$20
		STA	z:$20,X
		TXA
		ORA	z:$20,X
		PHX
		TAX
		LDA	a:.LOWORD(game_flags) ; orig=0x0314
		BIT	#$D9
		BNE	loc_C55B4D
		JSL	f:sub_C55BDE
		BCC	loc_C55B4D
		JSL	f:sub_C55C34

loc_C55B4D:
		REP	#$20
		LDA	z:$11,X
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	z:$14,X
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		PLX
		RTL
; End of function spotlight

.A16
.I16

sub_C55B5B:
		REP	#$20
		LDA	z:$10,X
		STA	z:$30,X
		LDA	z:$11,X
		SEC
		SBC	#$80
		EOR	#$FFFF
		INC
		CLC
		ADC	z:$16,X
		STA	z:$16,X
		CLC
		ADC	z:$10,X
		STA	z:$10,X
		SEC
		SBC	z:$30,X
		BPL	loc_C55B7E
		EOR	#$FFFF
		INC

loc_C55B7E:
		STA	z:$30,X
		LDA	z:$13,X
		STA	z:$32,X
		LDA	z:$14,X
		SEC
		SBC	#$68
		EOR	#$FFFF
		INC
		CLC
		ADC	z:$18,X
		STA	z:$18,X
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		SEC
		SBC	z:$32,X
		BPL	loc_C55BA1
		EOR	#$FFFF
		INC

loc_C55BA1:
		CMP	#$100
		BCS	locret_C55BDD
		LDA	z:$30,X
		CMP	#$100
		BCS	locret_C55BDD
		JSL	f:random2
		REP	#$20
		AND	#$1F
		BIT	#$10
		BNE	loc_C55BBF
		EOR	#$FFFF
		INC

loc_C55BBF:
		CLC
		ADC	#$80
		STA	z:$34,X
		JSL	f:random2
		REP	#$20
		AND	#$1F
		BIT	#$10
		BNE	loc_C55BD7
		EOR	#$FFFF
		INC

loc_C55BD7:
		CLC
		ADC	#$68
		STA	z:$36,X

locret_C55BDD:
		RTL
; End of function sub_C55B5B

.A16
.I16

sub_C55BDE:
		REP	#$20
		LDA	z:$16,X
		BMI	loc_C55BF7
		CLC
		ADC	z:$10,X
		CMP	#$D500
		BCS	loc_C55BF0
		STA	z:$10,X
		BRA	loc_C55C0A
; ---------------------------------------------------------------------------

loc_C55BF0:
		LDA	#$D500
		STA	z:$10,X
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C55BF7:
		CLC
		ADC	z:$10,X
		CMP	#$2C00
		BCC	loc_C55C03
		STA	z:$10,X
		BRA	loc_C55C0A
; ---------------------------------------------------------------------------

loc_C55C03:
		LDA	#$2C00
		STA	z:$10,X
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C55C0A:
		LDA	z:$18,X
		BMI	loc_C55C21
		CLC
		ADC	z:$13,X
		CMP	#$B800
		BCS	loc_C55C1A
		STA	z:$13,X
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C55C1A:
		LDA	#$B800
		STA	z:$13,X
		SEC
		RTL
; ---------------------------------------------------------------------------

loc_C55C21:
		CLC
		ADC	z:$13,X
		CMP	#$4800
		BCC	loc_C55C2D
		STA	z:$13,X
		CLC
		RTL
; ---------------------------------------------------------------------------

loc_C55C2D:
		LDA	#$4800
		STA	z:$13,X
		SEC
		RTL
; End of function sub_C55BDE

.A16
.I16

sub_C55C34:
		JSL	f:random2
		REP	#$20
		AND	#$7F
		CLC
		ADC	#$80
		ASL
		STA	z:$40
		BIT	#8
		BNE	loc_C55C51
		LDA	z:$40
		EOR	#$FFFF
		INC
		STA	z:$40

loc_C55C51:
		LDA	z:$40
		STA	z:$16,X
		JSL	f:random2
		REP	#$20
		AND	#$7F
		CLC
		ADC	#$80
		ASL
		STA	z:$40
		BIT	#8
		BNE	loc_C55C72
		LDA	z:$40
		EOR	#$FFFF
		INC
		STA	z:$40

loc_C55C72:
		LDA	z:$40
		STA	z:$18,X
		RTL
; End of function sub_C55C34

; ---------------------------------------------------------------------------
		.WORD $139, $159, $179,	$199
.A8
.I16

sub_C55C7F:
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::spawn_and_flags+1)	; orig=0x0D39
		BIT	#4
		BEQ	loc_C55C92
		LDA	#$16
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$1D
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98

loc_C55C92:
		JSL	f:sub_C55D79
		JSL	f:sub_C55DF9
		REP	#$20
.A16
		LDA	#$88
		STA	z:$40
		LDA	#$136
		STA	z:$42
		LDA	#$430
		STA	z:$44
		LDA	#$C
		STA	z:$46
		LDA	#.LOWORD(byte_C5150A)
		STA	z:$50
		JSL	f:sub_C55D23
		LDA	#$88
		STA	z:$40
		LDA	#$F8
		STA	z:$42
		LDA	#$430
		STA	z:$44
		LDA	#8
		STA	z:$46
		LDA	#.LOWORD(byte_C51505)
		STA	z:$50
		JSL	f:sub_C55D23
		LDA	#$119
		STA	z:$42
		LDA	#$430
		STA	z:$44
		LDA	#$D40
		STA	z:$46
		JSL	f:sub_C55E66
		LDA	#$139
		STA	z:$42
		LDA	#$430
		STA	z:$44
		LDA	#$D80
		STA	z:$46
		JSL	f:sub_C55E66
		LDA	#$159
		STA	z:$42
		LDA	#$430
		STA	z:$44
		LDA	#$DC0
		STA	z:$46
		JSL	f:sub_C55E66
		LDA	#$179
		STA	z:$42
		LDA	#$430
		STA	z:$44
		LDA	#$E00
		STA	z:$46
		JSL	f:sub_C55E66
		RTL
; End of function sub_C55C7F

.A16
.I16

sub_C55D23:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C55D57)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C55D57)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C55D57)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	locret_C55D56
		LDA	z:$40
		STA	a:.LOWORD($11),Y
		LDA	z:$42
		STA	a:.LOWORD($14),Y
		LDA	z:$44
		STA	a:.LOWORD($E),Y
		LDA	z:$50
		STA	a:.LOWORD($20),Y
		LDA	z:$46
		STA	a:.LOWORD($1E),Y

locret_C55D56:
		RTL
; End of function sub_C55D23

.A16
.I16

sub_C55D57:
		REP	#$20
		LDA	z:$20,X
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C55D74)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C55D74)
		STA	z:2,X

loc_C55D74:
		JSL	f:sub_C55710
		RTL
; End of function sub_C55D57

.A8
.I16

sub_C55D79:
		SEP	#$20
		LDA	#.LOBYTE(sub_C55D9A)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C55D9A)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C55D9A)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	locret_C55D56
		LDA	#$40
		STA	a:.LOWORD($20),Y
		RTL
; End of function sub_C55D79

.A16
.I16

sub_C55D9A:
		REP	#$20
		DEC	z:$20,X
		BNE	locret_C55DB2
		LDA	#$50
		STA	z:$20,X
		REP	#$20
		LDA	#.LOWORD(sub_C55DB3)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C55DB3)
		STA	z:2,X

locret_C55DB2:
		RTL
; End of function sub_C55D9A

.A8
.I16

sub_C55DB3:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	locret_C55DB2
		REP	#$20
		LDA	#.LOWORD(sub_C55DC7)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C55DC7)
		STA	z:2,X
		RTL
; End of function sub_C55DB3

.A8
.I16

sub_C55DC7:
		REP	#$20
.A16
		LDA	#.LOWORD(locret_C55DB2)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(locret_C55DB2)
		STA	z:2,X
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+$34) ; orig=0x0D34
		INC
		CMP	a:.LOWORD(level_manager_object+level_manager_object::anonymous_1) ; orig=0x0D12
		BNE	loc_C55DF3
		SEP	#$20
		STZ	a:.LOWORD(player1_object+6) ; orig=0x0D46
		STZ	a:.LOWORD(player2_object+6) ; orig=0x0D86
		STZ	a:.LOWORD(player3_object+6) ; orig=0x0DC6
		STZ	a:.LOWORD(player4_object+6) ; orig=0x0E06
		LDA	#$3B
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		RTL
; ---------------------------------------------------------------------------

loc_C55DF3:
		SEP	#$20
		DEC	a:.LOWORD(level_manager_object+level_manager_object::fade_related_) ; orig=0x0D10
		RTL
; End of function sub_C55DC7

.A8
.I16

sub_C55DF9:
		SEP	#$20
		LDA	#.LOBYTE(sub_C55E20)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C55E20)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C55E20)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		BCS	locret_C55E1F
		REP	#$20
.A16
		LDA	#0
		STA	a:.LOWORD($20),Y
		LDA	#7
		STA	a:.LOWORD($22),Y

locret_C55E1F:
		RTL
; End of function sub_C55DF9

.A16
.I16

sub_C55E20:
		REP	#$20
		DEC	z:$22,X
		BNE	locret_C55E1F
		LDA	#$10
		STA	z:$22,X
		LDY	#0
		INC	z:$20,X
		LDA	z:$20,X
		CMP	#4
		BNE	loc_C55E3C
		LDA	#0
		STA	z:$20,X

loc_C55E3C:
		PHX
		TAX
		SEP	#$20
.A8
		LDA	f:scoreboard_palettes,X
		STA	z:$40
		PLX
		LDA	#$C
		JSL	f:palette_related
		RTL
; End of function sub_C55E20

; ---------------------------------------------------------------------------
scoreboard_palettes:.BYTE SCOREBOARD_PALETTE_0,	SCOREBOARD_PALETTE_1, SCOREBOARD_PALETTE_2, SCOREBOARD_PALETTE_3
byte_C55E52:	.BYTE 1
		animation_frame animation_frame_C55E57, $FF
animation_frame_C55E57:.BYTE 0
off_C55E58:	.ADDR byte_C55E52, byte_C50D80,	byte_C50DBD, byte_C50DFA, byte_C50E37
		.ADDR byte_C514A4, byte_C514A4
.A16
.I16

sub_C55E66:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C55EA4)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C55EA4)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C55EA4)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C55E84
		JML	f:locret_C55D56
; ---------------------------------------------------------------------------

loc_C55E84:
		TXA
		STA	a:.LOWORD($22),Y
		LDA	#$68
		STA	a:.LOWORD($11),Y
		LDA	z:$42
		STA	a:.LOWORD($14),Y
		LDA	z:$44
		STA	a:.LOWORD($E),Y
		LDA	z:$46
		STA	a:.LOWORD($20),Y
		LDA	#8
		STA	a:.LOWORD($1E),Y
		RTL
; End of function sub_C55E66

.A16
.I16

sub_C55EA4:
		REP	#$20
		LDA	#.LOWORD(loc_C55EF5)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C55EF5)
		STA	z:2,X
		REP	#$20
.A16
		LDY	z:$20,X
		LDA	z:$20,X
		CMP	z:$22,X
		BEQ	loc_C55ED5
		REP	#$20
		LDA	#.LOWORD(loc_C55EF1)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C55EF1)
		STA	z:2,X
		REP	#$20
.A16
		LDA	a:.LOWORD(6),Y
		AND	#$FF
		BEQ	loc_C55EDA
		INC
		BRA	loc_C55EDA
; ---------------------------------------------------------------------------

loc_C55ED5:
		REP	#$20
		LDA	a:.LOWORD(6),Y

loc_C55EDA:
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:off_C55E58,X
		STA	z:$50
		PLX
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation

loc_C55EF1:
		SEP	#$20
		STZ	z:$C,X

loc_C55EF5:
		REP	#$20
.A16
		LDA	z:$C,X
		CMP	#$202
		BNE	loc_C55F05
		LDY	#2
		JSL	f:play_sound

loc_C55F05:
		JSL	f:sub_C55710
		RTL
; End of function sub_C55EA4

.A16
.I16

sub_C55F0A:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C55F5C)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C55F5C)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C55F5C)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C55F28
		JML	f:locret_C55D56
; ---------------------------------------------------------------------------

loc_C55F28:
		LDA	#$100
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	#$10
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		SEP	#$20
.A8
		LDA	#$17
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$17
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#0
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#0
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		LDA	#$E0
		STA	a:.LOWORD(FIXED_COLOR_DATA)
		JSL	f:sub_C56084
		JSL	f:sub_C5600A
		JSL	f:sub_C5604C
		RTL
; End of function sub_C55F0A

.A8
.I16

sub_C55F5C:
		REP	#$20
.A16
		LDA	#$FFC0
		STA	z:$11,X
		LDA	#$7C
		STA	z:$14,X
		LDA	#$30
		STA	z:$E,X
		LDA	#0
		STA	z:$1E,X
		LDA	#$200
		STA	z:$20,X
		LDA	#.LOWORD(byte_C51BCB)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_1+1) ; orig=0x0D13
		AND	#$FF
		ASL
		PHX
		TAX
		SEP	#$20
.A8
		LDY	#7
		LDA	f:victory_palettes,X
		STA	z:$40
		LDA	#8
		JSL	f:palette_related
		LDA	f:victory_palettes+1,X
		STA	z:$40
		LDA	#9
		JSL	f:palette_related
		PLX
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C55FBC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C55FBC)
		STA	z:2,X

loc_C55FBC:
		REP	#$20
.A16
		LDA	z:$20,X
		CMP	#$130
		BCS	loc_C55FD9
		LDA	z:$11,X
		CLC
		ADC	#$C
		STA	z:$11,X
		BMI	loc_C55FD9
		CMP	#$88
		BCC	loc_C55FD9
		LDA	#$88
		STA	z:$11,X

loc_C55FD9:
		JSL	f:sub_C5395A
		REP	#$20
		BIT	#$10
		BNE	loc_C55FF1
		LDA	z:$20,X
		CMP	#$F3
		BNE	loc_C55FEB

loc_C55FEB:
		REP	#$20
		DEC	z:$20,X
		BNE	loc_C56005

loc_C55FF1:
		SEP	#$20
.A8
		LDA	#$32
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C56005)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C56005)
		STA	z:2,X

loc_C56005:
		JSL	f:load_animation_frame
		RTL
; End of function sub_C55F5C

.A8
.I16

sub_C5600A:
		SEP	#$20
		LDA	#.LOBYTE(sub_C5602F)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C5602F)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C5602F)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C56028
		JML	f:locret_C55D56
; ---------------------------------------------------------------------------

loc_C56028:
		LDA	#$40
		STA	a:.LOWORD($20),Y
		RTL
; End of function sub_C5600A

.A16
.I16

sub_C5602F:
		REP	#$20
		DEC	z:$20,X
		BNE	locret_C5604B
		JSL	f:random2
		REP	#$20
		AND	#$3F
		CLC
		ADC	#$20
		STA	z:$20,X
		LDY	#$11
		JSL	f:play_sound

locret_C5604B:
		RTL
; End of function sub_C5602F

.A8
.I16

sub_C5604C:
		SEP	#$20
		LDA	#.LOBYTE(sub_C56071)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C56071)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C56071)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C5606A
		JML	f:locret_C55D56
; ---------------------------------------------------------------------------

loc_C5606A:
		LDA	#$20
		STA	a:.LOWORD($20),Y
		RTL
; End of function sub_C5604C

.A16
.I16

sub_C56071:
		REP	#$20
		DEC	z:$20,X
		BNE	locret_C56083
		LDA	#$18
		STA	z:$20,X
		LDY	#$12
		JSL	f:play_sound

locret_C56083:
		RTL
; End of function sub_C56071

.A8
.I16

sub_C56084:
		SEP	#$20
		LDA	#.LOBYTE(sub_C560A3)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C560A3)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C560A3)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	locret_C560A2
		JML	f:locret_C55D56
; ---------------------------------------------------------------------------

locret_C560A2:
		RTL
; End of function sub_C56084

.A16
.I16

sub_C560A3:
		REP	#$20
		LDA	#$B9
		STA	z:$11,X
		LDA	#$FFC0
		STA	z:$14,X
		LDA	#$30
		STA	z:$E,X
		LDA	#0
		STA	z:$1E,X
		LDA	#0
		STA	z:$20,X
		LDA	#$80
		STA	z:$22,X
		LDA	#0
		STA	z:$18,X
		LDA	#.LOWORD(byte_C51BD0)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C560E4)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C560E4)
		STA	z:2,X

loc_C560E4:
		REP	#$20
.A16
		DEC	z:$22,X
		BPL	loc_C5613F
		LDA	z:$10,X
		CLC
		ADC	#$FF80
		STA	z:$10,X
		STZ	z:$40
		LDA	z:$18,X
		CLC
		ADC	#$40
		STA	z:$18,X
		BPL	loc_C56100
		DEC	z:$40

loc_C56100:
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		LDA	z:$40
		ADC	z:$15,X
		STA	z:$15,X
		LDA	z:$14,X
		BMI	loc_C5613F
		CMP	#$20
		BCC	loc_C5613F
		LDA	#$20
		STA	z:$14,X
		LDA	z:$20,X
		ASL
		PHX
		TAX
		LDA	f:word_C56144,X
		PLX
		STA	z:$18,X
		LDA	z:$40
		STA	z:$16,X
		INC	z:$20,X
		LDA	z:$20,X
		CMP	#4
		BNE	loc_C5613F
		REP	#$20
		LDA	#.LOWORD(loc_C5613F)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C5613F)
		STA	z:2,X

loc_C5613F:
		JSL	f:load_animation_frame
		RTL
; End of function sub_C560A3

; ---------------------------------------------------------------------------
word_C56144:	.WORD $FC00
		.WORD $FD00
		.WORD $FE00
		.WORD $FF00
		.WORD 0
victory_palettes:.BYTE WHITE_VICTORY_PALETTE_0,	WHITE_VICTORY_PALETTE_1
		.BYTE BLACK_VICTORY_PALETTE_0, BLACK_VICTORY_PALETTE_1
		.BYTE BLUE_VICTORY_PALETTE_0, BLUE_VICTORY_PALETTE_1
		.BYTE RED_VICTORY_PALETTE_0, RED_VICTORY_PALETTE_1
byte_C56156:	.BYTE $ED, 4, 2, 0, $1D, $FC, 3, 0
byte_C5615E:	.BYTE $ED, $F3,	3, 0, $14, $C, 1, 0
byte_C56166:	.BYTE $FD, $DC,	3, 0, $FD, $C, 0, 0
byte_C5616E:	.BYTE $1C, $14,	2, 0, $DD, $FC,	1, 0
byte_C56176:	.BYTE $E5, $FC,	2, 0, $15, $FC,	0, 0
byte_C5617E:	.BYTE $15, $FC,	1, 0, $ED, 4, 0, 0
byte_C56186:	.BYTE $C5, $C, 2, 0, $FD, $C, 3, 0, $1D, $FC, 1, 0
byte_C56192:	.BYTE $FD, $2C,	2, 0, $E5, 4, 3, 0, $34, $14, 0, 0
byte_C5619E:	.BYTE $2D, $FC,	3, 0, $FD, $14,	1, 0, $BD, $FC,	0, 0
byte_C561AA:	.BYTE $DD, $1C,	2, 0, $FD, $FC,	1, 0, $1D, $14,	0, 0
byte_C561B6:	.BYTE $F5, $D4,	2, 0, $D4, $EC,	3, 0, $27, $EC,	1, 0, $FD
		.BYTE $FC, 0, 0
animation_frame_C561C6:.BYTE $10
		frame_oam_tile $E0, $F0, $2200, $60
		frame_oam_tile $E0, $E0, $200,	$60
		frame_oam_tile $E0, $10, $2400, $60
		frame_oam_tile $10, $10, $2400, $20
		frame_oam_tile $E0, 0,	$400, $60
		frame_oam_tile $10, 0,	$400, $20
		frame_oam_tile $F0, $E0, 0, $60
		frame_oam_tile $F0, $F0, $2000, $60
		frame_oam_tile $10, $E0, $200,	$20
		frame_oam_tile $10, $F0, $2200, $20
		frame_oam_tile 0, $E0,	0, $20
		frame_oam_tile 0, $F0,	$2000, $20
		frame_oam_tile 0, 0, $202, $20
		frame_oam_tile $F0, 0,	2, $20
		frame_oam_tile 0, $10,	$2202, $20
		frame_oam_tile $F0, $10, $2002, $20
animation_frame_C56217:.BYTE $10
		frame_oam_tile $10, $10, $2401, 2
		frame_oam_tile $10, $E0, 1, $22
		frame_oam_tile $10, $F0, $2001, $22
		frame_oam_tile $E0, $E0, $600,	$22
		frame_oam_tile $E0, $F0, $2600, $22
		frame_oam_tile $F0, $E0, $402,	$22
		frame_oam_tile 0, $E0,	$602, $22
		frame_oam_tile $F0, $F0, $2402, $22
		frame_oam_tile 0, $F0,	$2602, $22
		frame_oam_tile $E0, 0,	3, $22
		frame_oam_tile $E0, $10, $2003, $22
		frame_oam_tile $F0, 0,	$203, $22
		frame_oam_tile $F0, $10, $2203, $22
		frame_oam_tile 0, 0, $201, $22
		frame_oam_tile $10, 0,	$401, $22
		frame_oam_tile 0, $10,	$2201, $22
animation_frame_C56268:.BYTE $F
		frame_oam_tile 0, $18,	$2004, $24
		frame_oam_tile $E8, $F0, $2501, 4
		frame_oam_tile $10, $F0, $3501, 4
		frame_oam_tile $E8, $18, $3401, 4
		frame_oam_tile $F0, $18, $604,	$24
		frame_oam_tile $10, 8,	$404, $24
		frame_oam_tile 0, 8, $204, $24
		frame_oam_tile $F0, 8,	4, $24
		frame_oam_tile $E0, 8,	$2601, $24
		frame_oam_tile $E0, $F8, $601,	$24
		frame_oam_tile $10, $F8, $2603, $24
		frame_oam_tile $F0, $F8, $603,	$24
		frame_oam_tile 0, $F8,	$2403, $24
		frame_oam_tile $F0, $E8, $403,	$64
		frame_oam_tile 0, $E8,	$403, $24
animation_frame_C562B4:.BYTE $10
		frame_oam_tile $E8, $10, $2304, 6
		frame_oam_tile $E8, $E8, $2204, 6
		frame_oam_tile $10, 0,	$606, $26
		frame_oam_tile $10, $F0, $2005, $26
		frame_oam_tile $10, $E0, 5, $26
		frame_oam_tile 0, $E0,	$2604, $26
		frame_oam_tile $F0, $E0, $2404, $26
		frame_oam_tile $10, $10, $406,	$26
		frame_oam_tile 0, $10,	$206, $26
		frame_oam_tile $F0, $10, 6, $26
		frame_oam_tile 0, 0, $2605, $26
		frame_oam_tile 0, $F0,	$605, $26
		frame_oam_tile $F0, 0,	$2405, $26
		frame_oam_tile $F0, $F0, $405,	$26
		frame_oam_tile $E0, 0,	$2205, $26
		frame_oam_tile $E0, $F0, $205,	$26
byte_C56305:	.BYTE 1
		animation_frame animation_frame_C561C6, $FF
byte_C5630A:	.BYTE 1
		animation_frame animation_frame_C56217, $FF
byte_C5630F:	.BYTE 1
		animation_frame animation_frame_C56268, $FF
byte_C56314:	.BYTE 1
		animation_frame animation_frame_C562B4, $FF
; ---------------------------------------------------------------------------
draw_falling_bombermen:
		SEP	#$20
		LDA	#.LOBYTE(sub_C56338)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C56338)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C56338)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	locret_C56337
		JML	f:locret_C55D56
; ---------------------------------------------------------------------------

locret_C56337:
		RTL
.A16
.I16

sub_C56338:
		SEP	#$20
.A8
		LDA	#$17
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$17
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#0
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#0
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		LDA	#$E0
		STA	a:.LOWORD(FIXED_COLOR_DATA)
		LDA	#.BANKBYTE(byte_C5617E)
		STA	z:$5B
		PHX
		LDX	#$D40
		LDY	#0
		REP	#$20
.A16
		LDA	#0
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	#0
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		LDA	#0
		STA	z:$40
		LDA	#0
		STA	z:$42
		LDA	#$C5F
		STA	z:$50

loc_C5637B:
		LDA	($50)
		AND	#$FF
		CMP	#2
		BEQ	loc_C5639A
		LDA	z:5,X
		AND	#$FF
		PHX
		TAX
		LDA	f:byte_C56407,X
		PLX
		AND	#$FF
		ORA	z:$40
		STA	z:$40
		INC	z:$42

loc_C5639A:
		INC	z:$50
		TXA
		CLC
		ADC	#$40
		TAX
		CMP	#$E40
		BNE	loc_C5637B
		LDA	z:$40
		ASL
		TAX
		LDA	f:off_C58051,X
		STA	z:$59

loc_C563B1:
		LDA	z:$42
		ASL
		TAX
		LDA	f:word_C563FD,X
		STA	z:$40
		JSL	f:sub_C5640B
		DEC	z:$42
		BNE	loc_C563B1
		PLX
; End of function sub_C56338

; START	OF FUNCTION CHUNK FOR sub_C53A9F

loc_C563C4:
		REP	#$20
		LDA	#$120
		STA	z:$20,X
		REP	#$20
		LDA	#.LOWORD(loc_C563D8)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C563D8)
		STA	z:2,X

loc_C563D8:
		JSL	f:sub_C5395A
		REP	#$20
.A16
		BIT	#$10
		BNE	loc_C563E7
		DEC	z:$20,X
		BNE	locret_C563FC

loc_C563E7:
		SEP	#$20
.A8
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2) ; orig=0x0D16
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		REP	#$20
.A16
		LDA	#.LOWORD(locret_C563FC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(locret_C563FC)
		STA	z:2,X
.A16

locret_C563FC:
		RTL
; END OF FUNCTION CHUNK	FOR sub_C53A9F
; ---------------------------------------------------------------------------
word_C563FD:	.WORD 0
		.WORD $80
		.WORD $A0
		.WORD $C0
		.WORD $E0
byte_C56407:	.BYTE 1
		.BYTE 2
		.BYTE 4
		.BYTE 8
.A16
.I16

sub_C5640B:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C56487)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C56487)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C56487)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C56429
		JML	f:locret_C55D56
; ---------------------------------------------------------------------------

loc_C56429:
		LDA	#0
		STA	a:.LOWORD($1E),Y
		LDA	#$30
		STA	a:.LOWORD($E),Y
		LDA	#0
		STA	a:.LOWORD($13),Y
		LDA	#$FFC0
		STA	a:.LOWORD($14),Y
		LDA	#0
		STA	a:.LOWORD($18),Y
		LDA	z:$40
		STA	a:.LOWORD($22),Y
		LDA	#$88
		CLC
		ADC	[$59]
		AND	#$FF
		STA	a:.LOWORD($11),Y
		INC	z:$59
		LDA	#$88
		CLC
		ADC	[$59]
		AND	#$FF
		STA	a:.LOWORD($1A),Y
		INC	z:$59
		LDA	[$59]
		INC	z:$59
		INC	z:$59
		AND	#$FF
		ASL
		TAX
		LDA	f:off_C56E5F,X
		STA	z:$50
		TYX
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		RTL
; End of function sub_C5640B

.A16
.I16

sub_C56487:
		REP	#$20
		DEC	z:$22,X
		BEQ	loc_C56491
		JML	f:locret_C563FC
; ---------------------------------------------------------------------------

loc_C56491:
		REP	#$20
		LDA	#.LOWORD(loc_C5649E)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C5649E)
		STA	z:2,X

loc_C5649E:
		REP	#$20
.A16
		STZ	z:$42
		LDA	z:$18,X
		CLC
		ADC	#$40
		STA	z:$18,X
		BMI	loc_C564B0
		JML	f:loc_C564B2
; ---------------------------------------------------------------------------

loc_C564B0:
		DEC	z:$42

loc_C564B2:
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		LDA	z:$42
		ADC	z:$15,X
		STA	z:$15,X
		LDA	z:$14,X
		BMI	loc_C564D6
		CMP	z:$1A,X
		BCC	loc_C564D6
		LDA	z:$1A,X
		STA	z:$14,X
		REP	#$20
		LDA	#.LOWORD(loc_C564D6)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C564D6)
		STA	z:2,X

loc_C564D6:
		JSL	f:load_animation_frame
		RTL
; End of function sub_C56487

.A8
.I16

sub_C564DB:
		SEP	#$20
		LDA	#.LOBYTE(sub_C56515)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C56515)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C56515)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C564F9
		JML	f:locret_C56514
; ---------------------------------------------------------------------------

loc_C564F9:
		LDA	#1
		STA	a:.LOWORD($20),Y
		LDA	#0
		STA	a:.LOWORD($22),Y
		LDA	#0
		STA	a:.LOWORD($24),Y
		SEP	#$20
.A8
		STZ	a:.LOWORD(word_7E0C95) ; orig=0x0C95
		STZ	a:.LOWORD(word_7E0C95+1) ;	orig=0x0C96
		RTL
; ---------------------------------------------------------------------------
.A16

locret_C56514:
		RTL
; End of function sub_C564DB

.A16
.I16

sub_C56515:
		JSL	f:sub_C53955
		SEP	#$20
.A8
		STA	z:$40
		JSL	f:sub_C56698
		LDA	a:.LOWORD(word_7E0C95+1) ;	orig=0x0C96
		BNE	loc_C565A0
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$14)	; orig=0x082A
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$16)	; orig=0x082C
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$54)	; orig=0x086A
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$56)	; orig=0x086C
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$18)	; orig=0x082E
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$1A)	; orig=0x0830
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$58)	; orig=0x086E
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$5A)	; orig=0x0870
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$1C)	; orig=0x0832
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$1E)	; orig=0x0834
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$5C)	; orig=0x0872
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$5E)	; orig=0x0874
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$20)	; orig=0x0836
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$22)	; orig=0x0838
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$60)	; orig=0x0876
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$62)	; orig=0x0878
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$24)	; orig=0x083A
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$26)	; orig=0x083C
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$64)	; orig=0x087A
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$66)	; orig=0x087C
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$28)	; orig=0x083E
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$2A)	; orig=0x0840
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$68)	; orig=0x087E
		LDA	#0
		STA	a:.LOWORD(bg3_tilemap+$6A)	; orig=0x0880
		BRA	loc_C565FB
; ---------------------------------------------------------------------------

loc_C565A0:
		REP	#$20
.A16
		AND	#$F8
		LSR
		BEQ	loc_C565FB
		TAY
		LDA	#$4E
		STA	a:.LOWORD($826),Y
		LDA	#$20
		STA	a:.LOWORD($827),Y
		LDA	#$4F
		STA	a:.LOWORD($828),Y
		LDA	#$20
		STA	a:.LOWORD($829),Y
		LDA	#$5E
		STA	a:.LOWORD($866),Y
		LDA	#$20
		STA	a:.LOWORD($867),Y
		LDA	#$5F
		STA	a:.LOWORD($868),Y
		LDA	#$20
		STA	a:.LOWORD($869),Y
		SEP	#$20
.A8
		LDA	a:.LOWORD(word_7E0C95+1) ;	orig=0x0C96
		CMP	#$30
		BNE	loc_C565FB
		INC	a:.LOWORD(word_7E0C8F) ; orig=0x0C8F
		REP	#$20
.A16
		LDY	#1
		JSL	f:play_sound
		REP	#$20
		LDA	#.LOWORD(loc_C565FB)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C565FB)
		STA	z:2,X

loc_C565FB:
		JSL	f:sub_C53964
		SEP	#$20
		BIT	#$10
		BEQ	loc_C56609
		JSL	f:sub_C56633

loc_C56609:
		JSL	f:sub_C5666E
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	locret_C56632
		LDA	z:$22,X
		CMP	#5
		BEQ	sub_C56633
		LDA	#$170
		STA	z:$20,X
		JSL	f:sub_C56BFA
		INC	z:$22,X
		LDA	z:$22,X
		CMP	#1
		BNE	locret_C56632
		JSL	f:sub_C56BFA
		INC	z:$22,X

locret_C56632:
		RTL
; End of function sub_C56515

.A8
.I16

sub_C56633:
		SEP	#$20
		LDA	#$FF
		STA	z:$20,X
		LDA	#$FF
		STA	z:$21,X
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C5664B)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C5664B)
		STA	z:2,X
		RTL
; End of function sub_C56633

.A8
.I16

sub_C5664B:
		JSL	f:sub_C5666E
		REP	#$20
.A16
		DEC	z:$20,X
		LDA	z:$20,X
		CMP	#$FFE0
		BNE	loc_C5665E
		JML	f:fade_out_music
; ---------------------------------------------------------------------------

loc_C5665E:
		CMP	#$FFC0
		BEQ	loc_C56667
		JML	f:locret_C56632
; ---------------------------------------------------------------------------

loc_C56667:
		LDA	#$31
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		RTL
; End of function sub_C5664B

.A8
.I16

sub_C5666E:
		REP	#$20
.A16
		LDA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		CLC
		ADC	#5
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		LDA	z:$24,X
		INC	z:$24,X
		AND	#1
		PHX
		TAX
		SEP	#$20
.A8
		LDA	f:byte_C56696,X
		STA	z:$40
		LDY	#0
		LDA	#0
		JSL	f:palette_related
		PLX
		RTL
; End of function sub_C5666E

; ---------------------------------------------------------------------------
byte_C56696:	.BYTE $70, 0
.A8
.I16

sub_C56698:
		SEP	#$20
		INC	a:.LOWORD(word_7E0C95) ; orig=0x0C95
		LDA	a:.LOWORD(word_7E0C95) ; orig=0x0C95
		CMP	#$20
		BCS	loc_C566BC
		LDA	z:$40
		BIT	#$40
		BEQ	locret_C566C2
		LDA	a:.LOWORD(word_7E0C95) ; orig=0x0C95
		STZ	a:.LOWORD(word_7E0C95) ; orig=0x0C95
		CMP	#7
		BCC	loc_C566BC
		CMP	#$A
		BCS	loc_C566BC
		INC	a:.LOWORD(word_7E0C95+1) ;	orig=0x0C96
		RTL
; ---------------------------------------------------------------------------

loc_C566BC:
		STZ	a:.LOWORD(word_7E0C95) ; orig=0x0C95
		STZ	a:.LOWORD(word_7E0C95+1) ;	orig=0x0C96

locret_C566C2:
		RTL
; End of function sub_C56698

; ---------------------------------------------------------------------------
animation_frame_C566C3:.BYTE $19
		frame_oam_tile $E0, $10, $2401, 0
		frame_oam_tile $E0, $18, $3401, 0
		frame_oam_tile $18, $18, $3501, 0
		frame_oam_tile $20, $10, $2005, $20
		frame_oam_tile $30, $10, 5, $20
		frame_oam_tile $20, $F0, $601,	$20
		frame_oam_tile $30, $F0, $603,	$20
		frame_oam_tile $30, 0,	$2603, $20
		frame_oam_tile $20, 0,	$2601, $20
		frame_oam_tile $30, $20, $401,	$20
		frame_oam_tile $10, $30, $2000, $20
		frame_oam_tile $20, $30, $2200, $20
		frame_oam_tile $10, $20, $2004, $20
		frame_oam_tile $20, $20, $2204, $20
		frame_oam_tile $30, $30, 4, $20
		frame_oam_tile $E0, $20, $403,	$20
		frame_oam_tile $E0, $30, $2403, $20
		frame_oam_tile $D0, $30, $2203, $20
		frame_oam_tile $D0, $20, $203,	$20
		frame_oam_tile $D0, $10, $2201, $20
		frame_oam_tile $D0, 0,	$201, $20
		frame_oam_tile $C0, 0,	1, $20
		frame_oam_tile $C0, $10, $2001, $20
		frame_oam_tile $C0, $20, 3, $20
		frame_oam_tile $C0, $30, $2003, $20
animation_frame_C56741:.BYTE $30
		frame_oam_tile $20, $20, $205,	$60
		frame_oam_tile $20, $30, $2205, $60
		frame_oam_tile $10, $20, $405,	$60
		frame_oam_tile $10, $30, $2405, $60
		frame_oam_tile 0, $20,	$605, $60
		frame_oam_tile 0, $30,	$2605, $60
		frame_oam_tile $D0, $30, $2205, $20
		frame_oam_tile $D0, $20, $205,	$20
		frame_oam_tile $E0, $30, $2405, $20
		frame_oam_tile $E0, $20, $405,	$20
		frame_oam_tile $F0, $30, $2605, $20
		frame_oam_tile $F0, $20, $605,	$20
		frame_oam_tile $30, $F0, $2002, $60
		frame_oam_tile $30, $E0, 2, $60
		frame_oam_tile $30, $C0, 0, $60
		frame_oam_tile $20, $F0, $2202, $60
		frame_oam_tile $20, $E0, $202,	$60
		frame_oam_tile $20, $C0, $200,	$60
		frame_oam_tile $10, $10, $2404, $60
		frame_oam_tile $10, 0,	$404, $60
		frame_oam_tile $10, $F0, $2402, $60
		frame_oam_tile $10, $E0, $402,	$60
		frame_oam_tile $10, $D0, $2400, $60
		frame_oam_tile $10, $C0, $400,	$60
		frame_oam_tile 0, $10,	$2604, $60
		frame_oam_tile 0, 0, $604, $60
		frame_oam_tile 0, $F0,	$2602, $60
		frame_oam_tile 0, $E0,	$602, $60
		frame_oam_tile 0, $D0,	$2600, $60
		frame_oam_tile 0, $C0,	$600, $60
		frame_oam_tile $C0, $F0, $2002, $20
		frame_oam_tile $C0, $E0, 2, $20
		frame_oam_tile $D0, $F0, $2202, $20
		frame_oam_tile $D0, $E0, $202,	$20
		frame_oam_tile $E0, $10, $2404, $20
		frame_oam_tile $E0, 0,	$404, $20
		frame_oam_tile $E0, $F0, $2402, $20
		frame_oam_tile $F0, $10, $2604, $20
		frame_oam_tile $F0, 0,	$604, $20
		frame_oam_tile $F0, $F0, $2602, $20
		frame_oam_tile $F0, $E0, $602,	$20
		frame_oam_tile $E0, $E0, $402,	$20
		frame_oam_tile $F0, $D0, $2600, $20
		frame_oam_tile $E0, $D0, $2400, $20
		frame_oam_tile $F0, $C0, $600,	$20
		frame_oam_tile $E0, $C0, $400,	$20
		frame_oam_tile $D0, $C0, $200,	$20
		frame_oam_tile $C0, $C0, 0, $20
animation_frame_C56832:.BYTE $3C
stru_C56833:	frame_oam_tile $20, $30, $2405, $22
		frame_oam_tile $30, $30, $2605, $22
		frame_oam_tile $30, $20, $605,	$22
		frame_oam_tile $20, $20, $405,	$22
		frame_oam_tile $30, $10, $2603, $22
		frame_oam_tile $20, $10, $2403, $22
		frame_oam_tile $10, $10, $2203, $22
		frame_oam_tile $10, $20, $205,	$22
		frame_oam_tile $10, $30, $2205, $22
		frame_oam_tile 0, $30,	$2005, $22
		frame_oam_tile 0, $20,	5, $22
		frame_oam_tile 0, $10,	$2003, $22
		frame_oam_tile $F0, $10, $2602, $22
		frame_oam_tile $F0, $20, $604,	$22
		frame_oam_tile $F0, $30, $2604, $22
		frame_oam_tile $E0, $30, $2404, $22
		frame_oam_tile $E0, $20, $404,	$22
		frame_oam_tile $E0, $10, $2402, $22
		frame_oam_tile $D0, $10, $2202, $22
		frame_oam_tile $D0, $20, $204,	$22
		frame_oam_tile $D0, $30, $2204, $22
		frame_oam_tile $C0, $30, $2004, $22
		frame_oam_tile $C0, $20, 4, $22
		frame_oam_tile $C0, $10, $2002, $22
		frame_oam_tile $30, 0,	$603, $22
		frame_oam_tile $20, 0,	$403, $22
		frame_oam_tile $10, 0,	$203, $22
		frame_oam_tile 0, 0, 3, $22
		frame_oam_tile $F0, 0,	3, $62
		frame_oam_tile $E0, 0,	$402, $22
		frame_oam_tile $D0, 0,	$202, $22
		frame_oam_tile $C0, 0,	2, $22
		frame_oam_tile 0, $F0,	$602, $62
		frame_oam_tile $F0, $F0, $602,	$22
		frame_oam_tile $30, $F0, $201,	$62
		frame_oam_tile $C0, $F0, $201,	$22
		frame_oam_tile $20, $F0, $401,	$62
		frame_oam_tile $D0, $F0, $401,	$22
		frame_oam_tile $10, $F0, $601,	$62
		frame_oam_tile $E0, $F0, $601,	$22
		frame_oam_tile $30, $E0, $2001, $62
		frame_oam_tile $C0, $E0, $2001, $22
		frame_oam_tile $20, $E0, $2201, $62
		frame_oam_tile $D0, $E0, $2201, $22
		frame_oam_tile $10, $E0, $2401, $62
		frame_oam_tile $E0, $E0, $2401, $22
		frame_oam_tile 0, $E0,	$2601, $62
		frame_oam_tile $F0, $E0, $2601, $22
		frame_oam_tile $30, $D0, $200,	$62
		frame_oam_tile $C0, $D0, $200,	$22
		frame_oam_tile $20, $D0, $400,	$62
		frame_oam_tile $D0, $D0, $400,	$22
		frame_oam_tile $10, $D0, $600,	$62
		frame_oam_tile $E0, $D0, $600,	$22
		frame_oam_tile 0, $D0,	1, $62
		frame_oam_tile $F0, $D0, 1, $22
		frame_oam_tile $10, $C0, $2600, $22
		frame_oam_tile 0, $C0,	$2400, $22
		frame_oam_tile $F0, $C0, $2200, $22
		frame_oam_tile $E0, $C0, $2000, $22
animation_frame_C5695F:.BYTE $40
		frame_oam_tile $C0, $30, $201,	$26
		frame_oam_tile $C0, $20, $201,	$26
		frame_oam_tile $C0, $10, $201,	$26
		frame_oam_tile $30, 0,	$201, $26
		frame_oam_tile $30, $F0, $201,	$26
		frame_oam_tile $30, $E0, $201,	$26
		frame_oam_tile $30, $D0, $201,	$26
		frame_oam_tile $30, $C0, $201,	$26
		frame_oam_tile $20, $D0, $201,	$26
		frame_oam_tile $20, $C0, $201,	$26
		frame_oam_tile $10, $D0, $201,	$26
		frame_oam_tile $10, $C0, $201,	$26
		frame_oam_tile 0, $C0,	$201, $26
		frame_oam_tile $F0, $C0, $201,	$26
		frame_oam_tile $E0, $C0, $201,	$26
		frame_oam_tile $D0, $C0, $201,	$26
		frame_oam_tile $C0, $C0, $201,	$26
		frame_oam_tile 0, $D0,	1, $26
		frame_oam_tile $F0, $D0, $600,	$26
		frame_oam_tile $E0, $D0, $400,	$26
		frame_oam_tile $D0, $D0, $200,	$26
		frame_oam_tile $C0, $D0, 0, $26
		frame_oam_tile $E0, $F0, $402,	$26
		frame_oam_tile $D0, $F0, $202,	$26
		frame_oam_tile $E0, 0,	$2402, $26
		frame_oam_tile $D0, 0,	$2202, $26
		frame_oam_tile $C0, 0,	$2002, $26
		frame_oam_tile $C0, $F0, 2, $26
		frame_oam_tile $C0, $E0, $2000, $26
		frame_oam_tile $D0, $E0, $2200, $26
		frame_oam_tile $E0, $E0, $2400, $26
		frame_oam_tile $F0, $E0, $2600, $26
		frame_oam_tile 0, $E0,	$2001, $26
		frame_oam_tile $10, $E0, $2201, $26
		frame_oam_tile $20, $E0, $2401, $26
		frame_oam_tile 0, $F0,	3, $26
		frame_oam_tile $F0, $F0, $602,	$26
		frame_oam_tile $10, $F0, $203,	$26
		frame_oam_tile $20, $F0, $403,	$26
		frame_oam_tile $F0, 0,	$2602, $26
		frame_oam_tile 0, 0, $2003, $26
		frame_oam_tile $10, 0,	$2203, $26
		frame_oam_tile $20, 0,	$2403, $26
		frame_oam_tile $D0, $10, $401,	$26
		frame_oam_tile $E0, $10, $601,	$26
		frame_oam_tile $F0, $10, $2601, $26
		frame_oam_tile 0, $10,	$603, $26
		frame_oam_tile $10, $10, $2603, $26
		frame_oam_tile $30, $10, $2004, $26
		frame_oam_tile $20, $10, 4, $26
		frame_oam_tile $20, $20, $405,	$26
		frame_oam_tile $10, $20, $205,	$26
		frame_oam_tile 0, $20,	5, $26
		frame_oam_tile $F0, $20, $604,	$26
		frame_oam_tile $E0, $20, $404,	$26
		frame_oam_tile $D0, $20, $204,	$26
		frame_oam_tile $D0, $30, $2204, $26
		frame_oam_tile $E0, $30, $2404, $26
		frame_oam_tile $F0, $30, $2604, $26
		frame_oam_tile 0, $30,	$2005, $26
		frame_oam_tile $10, $30, $2205, $26
		frame_oam_tile $20, $30, $2405, $26
		frame_oam_tile $30, $20, $605,	$26
		frame_oam_tile $30, $30, $2605, $26
animation_frame_C56AA0:.BYTE $40
		frame_oam_tile $C0, $C0, 0, $24
		frame_oam_tile $C0, $D0, 0, $24
		frame_oam_tile $D0, $D0, 0, $24
		frame_oam_tile $D0, $C0, 0, $24
		frame_oam_tile $E0, $C0, 0, $24
		frame_oam_tile $F0, $C0, 0, $24
		frame_oam_tile 0, $C0,	0, $24
		frame_oam_tile $10, $C0, 0, $24
		frame_oam_tile $30, $C0, 0, $24
		frame_oam_tile $20, $D0, 0, $24
		frame_oam_tile $10, $D0, 0, $24
		frame_oam_tile 0, $D0,	0, $24
		frame_oam_tile $F0, $D0, 0, $24
		frame_oam_tile $E0, $E0, 0, $24
		frame_oam_tile $D0, $E0, 0, $24
		frame_oam_tile $30, $D0, $2400, $24
		frame_oam_tile $C0, $E0, $2400, $E4
		frame_oam_tile $20, $C0, $200,	$24
		frame_oam_tile $E0, $D0, $200,	$24
		frame_oam_tile $30, $E0, $601,	$24
		frame_oam_tile $20, $E0, $401,	$24
		frame_oam_tile $30, $F0, $2601, $24
		frame_oam_tile $20, $F0, $2401, $24
		frame_oam_tile $30, 0,	$603, $24
		frame_oam_tile $20, 0,	$403, $24
		frame_oam_tile $30, $10, $2603, $24
		frame_oam_tile $20, $10, $2403, $24
		frame_oam_tile $30, $20, $605,	$24
		frame_oam_tile $20, $20, $405,	$24
		frame_oam_tile $30, $30, $2605, $24
		frame_oam_tile $20, $30, $2405, $24
		frame_oam_tile $10, $30, $2205, $24
		frame_oam_tile $10, $20, $205,	$24
		frame_oam_tile $10, $10, $2203, $24
		frame_oam_tile $10, 0,	$203, $24
		frame_oam_tile $10, $F0, $2201, $24
		frame_oam_tile $10, $E0, $201,	$24
		frame_oam_tile 0, $E0,	1, $24
		frame_oam_tile 0, $F0,	$2001, $24
		frame_oam_tile 0, 0, 3, $24
		frame_oam_tile 0, $10,	$2003, $24
		frame_oam_tile 0, $20,	5, $24
		frame_oam_tile 0, $30,	$2005, $24
		frame_oam_tile $F0, $30, $2604, $24
		frame_oam_tile $F0, $20, $604,	$24
		frame_oam_tile $F0, $10, $2602, $24
		frame_oam_tile $F0, 0,	$602, $24
		frame_oam_tile $F0, $F0, $2600, $24
		frame_oam_tile $F0, $E0, $600,	$24
		frame_oam_tile $E0, $F0, $2400, $24
		frame_oam_tile $E0, 0,	$402, $24
		frame_oam_tile $E0, $10, $2402, $24
		frame_oam_tile $E0, $20, $404,	$24
		frame_oam_tile $E0, $30, $2404, $24
		frame_oam_tile $D0, $30, $2204, $24
		frame_oam_tile $D0, $20, $204,	$24
		frame_oam_tile $D0, $10, $2202, $24
		frame_oam_tile $D0, 0,	$202, $24
		frame_oam_tile $D0, $F0, $2200, $24
		frame_oam_tile $C0, $F0, $2000, $24
		frame_oam_tile $C0, 0,	2, $24
		frame_oam_tile $C0, $10, $2002, $24
		frame_oam_tile $C0, $20, 4, $24
		frame_oam_tile $C0, $30, $2004, $24
byte_C56BE1:	.BYTE 1
		animation_frame animation_frame_C566C3, $FF
byte_C56BE6:	.BYTE 1
		animation_frame animation_frame_C56741, $FF
byte_C56BEB:	.BYTE 1
		animation_frame animation_frame_C56832, $FF
byte_C56BF0:	.BYTE 1
		animation_frame animation_frame_C5695F, $FF
byte_C56BF5:	.BYTE 1
		animation_frame animation_frame_C56AA0, $FF
.A16
.I16

sub_C56BFA:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C56C37)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C56C37)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C56C37)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
; End of function sub_C56BFA

.A8
.I16

sub_C56C10:
		REP	#$20
.A16
		BCC	loc_C56C18
		JML	f:locret_C56514
; ---------------------------------------------------------------------------

loc_C56C18:
		LDA	z:$22,X
		STA	a:.LOWORD($22),Y
		LDA	#0
		STA	a:.LOWORD($32),Y
		LDA	#$6000
		STA	a:.LOWORD($34),Y
		LDA	z:$22,X
		ASL
		ASL
		ASL
		ASL
		CLC
		ADC	#.LOWORD(intro_screen_graphics)
		STA	a:.LOWORD($30),Y
		RTL
; End of function sub_C56C10

.A16
.I16

sub_C56C37:
		SEP	#$20
.A8
		LDA	z:$22,X
		CMP	#1
		BNE	loc_C56C43
		JML	f:loc_C56CB5
; ---------------------------------------------------------------------------

loc_C56C43:
		LDA	#$C3
		STA	z:$55
		PHX
		REP	#$20
.A16
		LDA	z:$36,X
		TAY
		LDA	z:$32,X
		STA	z:$40
		BIT	#1
		BNE	loc_C56C65
		LDA	z:$30,X
		STA	z:$53
		LDA	[$53]
		TAY
		INC	z:$53
		INC	z:$53
		LDA	z:$53
		STA	z:$30,X

loc_C56C65:
		LDA	z:$32,X
		AND	#$1E
		TAX
		LDA	f:graphic_load_offsets,X
		TAX
		LDA	z:$40
		BIT	#1
		BEQ	loc_C56C78
		INX

loc_C56C78:
		SEP	#$20
.A8
		LDA	#$C3
		PHA
		PLB
; ds=C3000 B=C3
		JSL	f:graphics_decompression_128_bytes
		JSL	f:graphics_decompression_128_bytes
		JSL	f:graphics_decompression_128_bytes
		JSL	f:graphics_decompression_128_bytes
		SEP	#$20
		LDA	#0
		PHA
		PLB
; ds=0 B=0
		REP	#$20
.A16
		PLX
		TYA
		STA	z:$36,X
		INC	z:$32,X
		LDA	z:$32,X
		CMP	#$10
		BEQ	loc_C56CA7
		JML	f:locret_C56D63
; ---------------------------------------------------------------------------

loc_C56CA7:
		REP	#$20
		LDA	#.LOWORD(loc_C56CC6)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C56CC6)
		STA	z:2,X
		RTL
; ---------------------------------------------------------------------------

loc_C56CB5:
		REP	#$20
.A16
		INC	z:$32,X
		LDA	z:$32,X
		CMP	#$18
		BEQ	loc_C56CC4
		JML	f:locret_C56D63
; ---------------------------------------------------------------------------

loc_C56CC4:
		BRA	loc_C56D01
; ---------------------------------------------------------------------------

loc_C56CC6:
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	z:$55
		REP	#$20
.A16
		LDA	z:$34,X
		STA	z:$40
		LDA	z:$34,X
		SEC
		SBC	#$6000
		ASL
		CLC
		ADC	#.LOWORD(temp_uncompressed_graphics)
		STA	z:$53
		REP	#$20
		LDA	#.LOWORD(sub_C56DA2)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C56DA2)
		STA	z:$52
		PHY
		JSL	f:sub_C62514
		PLY
		REP	#$20
.A16
		LDA	z:$34,X
		CLC
		ADC	#$400
		STA	z:$34,X
		CMP	#$8000
		BNE	locret_C56D63

loc_C56D01:
		REP	#$20
		LDA	#$88
		STA	z:$11,X
		LDA	#0
		STA	z:$13,X
		LDA	#$108
		STA	z:$14,X
		LDA	#0
		STA	z:$1E,X
		LDA	z:$22,X
		ASL
		ASL
		PHX
		TAX
		LDA	f:off_C56D64,X
		STA	z:$50
		LDA	f:word_C56D66,X
		PLX
		STA	z:$E,X
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C56D41)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C56D41)
		STA	z:2,X

loc_C56D41:
		REP	#$20
.A16
		LDA	z:$13,X
		CLC
		ADC	#$FF00
		STA	z:$13,X
		LDA	#$FF
		ADC	z:$15,X
		STA	z:$15,X
		LDA	z:$14,X
		BPL	loc_C56D5F
		CMP	#$FFA8
		BCS	loc_C56D5F
		JSL	f:delete_object

loc_C56D5F:
		JSL	f:load_animation_frame

locret_C56D63:
		RTL
; End of function sub_C56C37

; ---------------------------------------------------------------------------
off_C56D64:	.ADDR byte_C56BE6
word_C56D66:	.WORD $30
		.ADDR byte_C56BE1
		.WORD $30
		.ADDR byte_C56BEB
		.WORD $30
		.ADDR byte_C56BF0
		.WORD $1030
		.ADDR byte_C56BF5
		.WORD $1030
.A16
.I16

sub_C56D78:
		SEP	#$20
.A8
		LDA	#$C3
		STA	z:$55
		REP	#$20
.A16
		LDA	z:$30,X
		STA	z:$53
		PHX
		JSL	f:graphics_decompression_8192_bytes
		PLX
		REP	#$20
		LDA	z:$34,X
		STA	z:$40
		REP	#$20
		LDA	#.LOWORD(sub_C56DA2)
		STA	z:$50
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C56DA2)
		STA	z:$52
		JSL	f:sub_C62514
		RTL
; End of function sub_C56D78

.A8
.I16

sub_C56DA2:
		REP	#$20
.A16
		LDA	z:$40
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$800
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	z:$53
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	z:$55
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		RTL
; End of function sub_C56DA2

.A8
.I16

sub_C56DC2:
		JSL	f:graphics_decompression_8192_bytes
		SEP	#$20
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C56DCB:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C56DCB
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$6800
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:graphics_decompression_8192_bytes
		SEP	#$20
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C56DFF:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C56DFF
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$7000
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		JSL	f:graphics_decompression_8192_bytes
		SEP	#$20
		LDA	a:.LOWORD(frame_count) ; orig=0x0300

loc_C56E33:
		CMP	a:.LOWORD(frame_count) ; orig=0x0300
		BEQ	loc_C56E33
		LDA	#0
		STA	a:.LOWORD(H_DMA_CHANNEL_ENABLE)
		REP	#$20
.A16
		LDA	#$7800
		STA	a:.LOWORD(ADDRESS_FOR_VRAM_READ_WRITE_LOW_BYTE)
		LDA	#$1000
		STA	a:.LOWORD(DMA_4_BYTES_COUNT_LOW_BYTE)
		REP	#$20
		LDA	#.LOWORD(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_LOW_BYTE)
		SEP	#$20
.A8
		LDA	#.BANKBYTE(temp_uncompressed_graphics)
		STA	a:.LOWORD(DMA_4_A_ADDRESS_BANK)
		JSL	f:dma_related_
		RTL
; End of function sub_C56DC2

; ---------------------------------------------------------------------------
off_C56E5F:	.ADDR byte_C56305, byte_C5630A,	byte_C56314, byte_C5630F
.A8
.I16

sub_C56E67:
		SEP	#$20
		LDA	#.LOBYTE(sub_C56E92)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C56E92)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C56E92)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C56E85
		JML	f:nullsub_7
; ---------------------------------------------------------------------------

loc_C56E85:
		LDA	#$400
		STA	a:.LOWORD($20),Y
		LDA	#0
		STA	a:.LOWORD($22),Y
; End of function sub_C56E67

nullsub_7:
        RTL
.A16
.I16

sub_C56E92:
		JSL	f:sub_C5395A
		SEP	#$20
.A8
		BIT	#$10
		BNE	loc_C56EA2
; End of function sub_C56E92

.A8
.I16

sub_C56E9C:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	locret_C56EB1

loc_C56EA2:
		SEP	#$20
.A8
		LDA	#$31
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		JSL	f:delete_object
		JSL	f:fade_out_music

locret_C56EB1:
		RTL
; End of function sub_C56E9C

; ---------------------------------------------------------------------------
word_C56EB2:	.WORD $48
		.WORD $92
.A8
.I16

sub_C56EB6:
		SEP	#$20
		LDA	#.LOBYTE(sub_C56ED5)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C56ED5)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C56ED5)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	locret_C56ED4
		JML	f:nullsub_7
; ---------------------------------------------------------------------------

locret_C56ED4:
		RTL
; End of function sub_C56EB6

.A16
.I16

sub_C56ED5:
		SEP	#$20
.A8
		LDA	#$17
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$17
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#0
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#0
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		REP	#$20
.A16
		LDA	#$3F8
		STA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		LDA	#$3E8
		STA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		LDA	#$48
		STA	z:$11,X
		LDA	#$5D
		STA	z:$14,X
		LDA	#$30
		STA	z:$E,X
		LDA	#8
		STA	z:$1E,X
		LDA	#0
		STA	z:$20,X
		LDA	#.LOWORD(byte_C51749)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2+1) ; orig=0x0D17
		AND	#$F
		CMP	#8
		BNE	loc_C56F32
		DEC	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2+1) ; orig=0x0D17
		DEC	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2) ; orig=0x0D16

loc_C56F32:
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C56F72)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C56F72)
		STA	z:2,X
		JSL	f:generate_password
		JSL	f:sub_C57038
		REP	#$20
.A16
		LDA	#$58
		STA	z:$42
		LDA	a:.LOWORD(word_7E0C7F) ; orig=0x0C7F
		STA	z:$40
		JSL	f:sub_C5708E
		LDA	a:.LOWORD(word_7E0C7F+1) ;	orig=0x0C80
		STA	z:$40
		JSL	f:sub_C5708E
		LDA	a:.LOWORD(word_7E0C81) ; orig=0x0C81
		STA	z:$40
		JSL	f:sub_C5708E
		LDA	a:.LOWORD(word_7E0C81+1) ;	orig=0x0C82
		STA	z:$40
		JSL	f:sub_C5708E

loc_C56F72:
		JSL	f:sub_C5395A
		REP	#$20
		BIT	#$10
		BNE	loc_C56FA1
		AND	#3
		BEQ	loc_C56F9C
		REP	#$20
		LDY	#0
		JSL	f:play_sound
		LDA	z:$20,X
		EOR	#1
		STA	z:$20,X
		ASL
		PHX
		TAX
		LDA	f:word_C56EB2,X
		PLX
		STA	z:$11,X

loc_C56F9C:
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C56FA1:
		LDY	#1
		JSL	f:play_sound
		SEP	#$20
.A8
		LDA	z:$20,X
		BNE	loc_C56FFC
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2) ; orig=0x0D16
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		JSL	f:sub_C550AF
		JSL	f:sub_C462BA
		SEP	#$20
		LDA	#1
		STA	a:.LOWORD(player1_object+$31) ; orig=0x0D71
		LDA	#1
		STA	a:.LOWORD(player1_object+$32) ; orig=0x0D72
		LDA	#0
		STA	a:.LOWORD(player2_object+$31) ; orig=0x0DB1
		LDA	#0
		STA	a:.LOWORD(player2_object+$32) ; orig=0x0DB2
		LDA	a:.LOWORD(joypad_2_pressed+1) ; orig=0x0CFB
		BIT	#$10
		BEQ	loc_C56FED
		LDA	#0
		STA	a:.LOWORD(player1_object+$31) ; orig=0x0D71
		LDA	#0
		STA	a:.LOWORD(player1_object+$32) ; orig=0x0D72
		LDA	#1
		STA	a:.LOWORD(player2_object+$31) ; orig=0x0DB1
		LDA	#1
		STA	a:.LOWORD(player2_object+$32) ; orig=0x0DB2

loc_C56FED:
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C56F9C)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C56F9C)
		STA	z:2,X
		BRA	loc_C56F9C
; ---------------------------------------------------------------------------

loc_C56FFC:
		LDY	#$F
		JSL	f:play_music
		REP	#$20
.A16
		LDA	#$140
		STA	z:$20,X
		REP	#$20
		LDA	#.LOWORD(loc_C57017)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57017)
		STA	z:2,X

loc_C57017:
		REP	#$20
.A16
		DEC	z:$20,X
		BEQ	loc_C57021
		JML	f:loc_C56F9C
; ---------------------------------------------------------------------------

loc_C57021:
		SEP	#$20
.A8
		LDA	#$31
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C56F9C)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C56F9C)
		STA	z:2,X
		JMP	a:.LOWORD(loc_C56F9C)
; End of function sub_C56ED5

.A8
.I16

sub_C57038:
		SEP	#$20
		LDA	#.LOBYTE(sub_C57057)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C57057)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C57057)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	locret_C57056
		JML	f:nullsub_7
; ---------------------------------------------------------------------------

locret_C57056:
		RTL
; End of function sub_C57038

.A16
.I16

sub_C57057:
		REP	#$20
		LDA	#$88
		STA	z:$11,X
		LDA	#$40
		STA	z:$14,X
		LDA	#$30
		STA	z:$E,X
		LDA	#8
		STA	z:$1E,X
		LDA	#.LOWORD(byte_C5174E)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C57089)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57089)
		STA	z:2,X

loc_C57089:
		JSL	f:advance_animation
		RTL
; End of function sub_C57057

.A16
.I16

sub_C5708E:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C570CD)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C570CD)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C570CD)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	loc_C570C4
		LDA	z:$40
		STA	a:.LOWORD($20),Y
		LDA	z:$42
		STA	a:.LOWORD($11),Y
		LDA	#$88
		STA	a:.LOWORD($14),Y
		LDA	#$30
		STA	a:.LOWORD($E),Y
		LDA	#8
		STA	a:.LOWORD($1E),Y

loc_C570C4:
		LDA	z:$42
		CLC
		ADC	#$20
		STA	z:$42
		RTL
; End of function sub_C5708E

.A16
.I16

sub_C570CD:
		REP	#$20
		LDA	z:$20,X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:off_C570FA,X
		STA	z:$50
		PLX
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C570F5)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C570F5)
		STA	z:2,X

loc_C570F5:
		JSL	f:advance_animation
		RTL
; End of function sub_C570CD

; ---------------------------------------------------------------------------
off_C570FA:	.ADDR byte_C51753, byte_C51758,	byte_C5175D, byte_C51762, byte_C51767
		.ADDR byte_C5176C, byte_C51771,	byte_C51776
.IFDEF J
; Moved to bank 3
password_encryption_key:.WORD 5, 0, 4, 1, 2, 6, 3, 7
password_decryption_key:.WORD 1, 3, 4, 6, 2, 0, 5, 7
.ENDIF
.A16
.I16

sub_C5710A:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C57129)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C57129)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C57129)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	locret_C57128
		JML	f:nullsub_7
; ---------------------------------------------------------------------------

locret_C57128:
		RTL
; End of function sub_C5710A

.A16
.I16

sub_C57129:
		REP	#$20
		LDA	#$98
		STA	z:$11,X
		LDA	#$48
		STA	z:$14,X
		LDA	#$30
		STA	z:$E,X
		LDA	#8
		STA	z:$1E,X
		LDA	#.LOWORD(byte_C5173F)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		JSL	f:advance_animation
		RTL
; End of function sub_C57129

.A8
.I16

sub_C57153:
		SEP	#$20
		LDA	#.LOBYTE(sub_C57172)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C57172)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C57172)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	locret_C57171
		JML	f:nullsub_7
; ---------------------------------------------------------------------------

locret_C57171:
		RTL
; End of function sub_C57153

.A16
.I16

sub_C57172:
		JSL	f:sub_C5710A
; End of function sub_C57172

.A16
.I16

sub_C57176:
		SEP	#$20
.A8
		LDA	#$17
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$17
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#0
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#0
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		REP	#$20
.A16
		LDA	#$3F8
		STA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		LDA	#$3E8
		STA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		LDA	#$48
		STA	z:$11,X
		LDA	#$70
		STA	z:$14,X
		LDA	#$30
		STA	z:$E,X
		LDA	#8
		STA	z:$1E,X
		LDA	#0
		STA	z:$20,X
		LDA	a:.LOWORD(word_7E0C7F) ; orig=0x0C7F
		STA	z:$30,X
		LDA	a:.LOWORD(word_7E0C81) ; orig=0x0C81
		STA	z:$32,X
		LDA	#.LOWORD(byte_C51749)
		STA	z:$50
; End of function sub_C57176

.A16
.I16

sub_C571C2:
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C571F3)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C571F3)
		STA	z:2,X
		REP	#$20
.A16
		LDA	#$58
		STA	z:$42
		TXA
		STA	z:$40
		JSL	f:sub_C57382
		JSL	f:sub_C57382
		JSL	f:sub_C57382
		JSL	f:sub_C57382

loc_C571F3:
		JSL	f:sub_C53955
		STA	z:$48
		JSL	f:sub_C5395A
		STA	z:$49
		SEP	#$20
.A8
		LDA	z:$49
		BIT	#$10
		BEQ	loc_C5720B
		JML	f:sub_C572B0
; ---------------------------------------------------------------------------

loc_C5720B:
		LDA	z:$48
		BIT	#$80
		BEQ	loc_C57226
		INC	z:$20,X
		LDA	z:$20,X
		CMP	#4
		BNE	loc_C5721D
		JML	f:sub_C572B0
; ---------------------------------------------------------------------------

loc_C5721D:
		LDY	#1
		JSL	f:play_sound
		SEP	#$20

loc_C57226:
		LDA	#0
		XBA
		LDA	z:$20,X
		AND	#3
		STA	z:$20,X
		PHX
		TAX
		LDA	f:word_C5737E,X
		PLX
		STA	z:$11,X
		REP	#$20
.A16
		LDA	z:$20,X
		AND	#$FF
		STA	z:$40
		PHX
		TXA
		CLC
		ADC	z:$40
		TAX
		SEP	#$20
.A8
		LDA	z:$49
		BIT	#$C
		BEQ	loc_C57264
		LDY	#0
		JSL	f:play_sound
		SEP	#$20
		INC	z:$30,X
		LDA	z:$49
		BIT	#4
		BEQ	loc_C57264
		DEC	z:$30,X
		DEC	z:$30,X

loc_C57264:
		LDA	z:$30,X
		AND	#7
		STA	z:$30,X
		PLX
; End of function sub_C571C2

; START	OF FUNCTION CHUNK FOR sub_C572B0

loc_C5726B:
		JSL	f:advance_animation
		RTL
; END OF FUNCTION CHUNK	FOR sub_C572B0
.A8
.I16

sub_C57270:
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C572AB)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C572AB)
		STA	z:2,X
		SEP	#$20
		LDA	#$31
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		LDY	#$1D
		LDA	z:$30,X
		CMP	#5
		BNE	loc_C572A7
		LDA	z:$31,X
		CMP	#6
		BNE	loc_C572A7
		LDA	z:$32,X
		CMP	#5
		BNE	loc_C572A7
		LDA	z:$33,X
		CMP	#6
		BNE	loc_C572A7
		LDA	#1
		STA	a:.LOWORD(word_7E0C8F+1) ;	orig=0x0C90
		LDY	#$E

loc_C572A7:
		JSL	f:play_sound

loc_C572AB:
		JSL	f:advance_animation
		RTL
; End of function sub_C57270

.A8
.I16

sub_C572B0:

; FUNCTION CHUNK AT 726B SIZE 00000005 BYTES

		REP	#$20
.A16
		LDA	z:$30,X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:password_decryption_key,X
		PLX
		SEP	#$20
.A8
		STA	z:$38,X
		REP	#$20
.A16
		LDA	z:$31,X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:password_decryption_key,X
		PLX
		SEP	#$20
.A8
		STA	z:$39,X
		REP	#$20
.A16
		LDA	z:$32,X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:password_decryption_key,X
		PLX
		SEP	#$20
.A8
		STA	z:$3A,X
		REP	#$20
.A16
		LDA	z:$33,X
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:password_decryption_key,X
		PLX
		SEP	#$20
.A8
		BIT	#1
		BEQ	loc_C57302
		JML	f:sub_C57270
; ---------------------------------------------------------------------------

loc_C57302:
		STA	z:$3B,X
		LDA	z:$39,X
		CLC
		ADC	z:$3A,X
		CLC
		ADC	z:$3B,X
		AND	#7
		CMP	z:$38,X
		BEQ	loc_C57316
		JML	f:sub_C57270
; ---------------------------------------------------------------------------

loc_C57316:
		LDA	z:$39,X
		ASL
		ASL
		ASL
		CLC
		ADC	z:$3A,X
		CMP	#$30
		BCC	loc_C57326
		JML	f:sub_C57270
; ---------------------------------------------------------------------------

loc_C57326:
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		LDY	#1
		JSL	f:play_sound
		JSL	f:sub_C55100
		JSL	f:sub_C462BA
		SEP	#$20
		LDA	#1
		STA	a:.LOWORD(player1_object+$31) ; orig=0x0D71
		LDA	#1
		STA	a:.LOWORD(player1_object+$32) ; orig=0x0D72
		LDA	#0
		STA	a:.LOWORD(player2_object+$31) ; orig=0x0DB1
		LDA	#0
		STA	a:.LOWORD(player2_object+$32) ; orig=0x0DB2
		REP	#$20
.A16
		LDA	a:.LOWORD(joypad_2_pressed) ; orig=0x0CFA
		BIT	#$1080
		BEQ	loc_C5736E
		SEP	#$20
.A8
		LDA	#0
		STA	a:.LOWORD(player1_object+$31) ; orig=0x0D71
		LDA	#0
		STA	a:.LOWORD(player1_object+$32) ; orig=0x0D72
		LDA	#1
		STA	a:.LOWORD(player2_object+$31) ; orig=0x0DB1
		LDA	#1
		STA	a:.LOWORD(player2_object+$32) ; orig=0x0DB2

loc_C5736E:
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C5726B)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C5726B)
		STA	z:2,X
		JMP	a:.LOWORD(loc_C5726B)
; End of function sub_C572B0

; ---------------------------------------------------------------------------
word_C5737E:	.WORD $6848
		.WORD $A888
.A16
.I16

sub_C57382:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C573C7)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C573C7)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C573C7)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	loc_C573A0
		JML	f:loc_C573BC
; ---------------------------------------------------------------------------

loc_C573A0:
		LDA	z:$40
		STA	a:.LOWORD($30),Y
		LDA	z:$42
		STA	a:.LOWORD($11),Y
		LDA	#$70
		STA	a:.LOWORD($14),Y
		LDA	#$30
		STA	a:.LOWORD($E),Y
		LDA	#8
		STA	a:.LOWORD($1E),Y

loc_C573BC:
		INC	z:$40
		LDA	z:$42
		CLC
		ADC	#$20
		STA	z:$42
		RTL
; End of function sub_C57382

.A16
.I16

sub_C573C7:
		REP	#$20
		LDY	z:$30,X
		LDA	a:.LOWORD($30),Y
		AND	#$FF
		ASL
		PHX
		TAX
		LDA	f:off_C570FA,X
		STA	z:$50
		PLX
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		JSL	f:advance_animation
		RTL
; End of function sub_C573C7

.A16
.I16

sub_C573EA:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C57409)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C57409)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C57409)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	locret_C57408
		JML	f:nullsub_7
; ---------------------------------------------------------------------------

locret_C57408:
		RTL
; End of function sub_C573EA

.A16
.I16

sub_C57409:
		REP	#$20
		LDA	#$C30
		STA	z:$E,X
		LDA	#8
		STA	z:$1E,X
		LDA	#$7C
		STA	z:$11,X
		LDA	#$59
		STA	z:$14,X
		LDA	#.LOWORD(byte_C519CC)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2+1) ; orig=0x0D17
		CMP	#$68
		BEQ	loc_C57449
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C57444)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57444)
		STA	z:2,X

loc_C57444:
		JSL	f:advance_animation
		RTL
; ---------------------------------------------------------------------------

loc_C57449:
		LDY	#$1B
		JSL	f:play_music
		REP	#$20
.A16
		LDA	#$180
		STA	z:$20,X
		LDA	#.LOWORD(byte_C51A17)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(loc_C57473)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57473)
		STA	z:2,X

loc_C57473:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	loc_C574A0
		LDA	#.LOWORD(byte_C519D1)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C574A5)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C574A5)
		STA	z:2,X
		REP	#$20
.A16
		LDA	#$90
		STA	z:$40
		JSL	f:sub_C7724D

loc_C574A0:
		JSL	f:advance_animation
		RTL
; End of function sub_C57409

.A16
.I16

sub_C574A5:
		JSL	f:advance_animation
		BCC	locret_C574CE
		REP	#$20
		LDA	#$F0
		STA	z:$20,X
		LDA	#.LOWORD(byte_C51A12)
		STA	z:$50
		SEP	#$20
.A8
		PHK
		PLA
		STA	z:$52
		JSL	f:start_animation
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C574CF)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C574CF)
		STA	z:2,X

locret_C574CE:
		RTL
; End of function sub_C574A5

.A8
.I16

sub_C574CF:
		JSL	f:advance_animation
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	locret_C574ED
		LDY	#$11
		JSL	f:play_music
		REP	#$20
		LDA	#.LOWORD(loc_C574A0)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C574A0)
		STA	z:2,X

locret_C574ED:
		RTL
; End of function sub_C574CF

.A8
.I16

sub_C574EE:
		SEP	#$20
		LDY	#0
		LDA	#.LOWORD(MECHA_BOMBER_GREEN_PALETTE)
		STA	z:$40
		LDA	#$A
		JSL	f:palette_related
		REP	#$20
.A16
		INC	z:$50

loc_C57501:
		INC	z:$50
		RTL
; End of function sub_C574EE

.A16
.I16

sub_C57504:

; FUNCTION CHUNK AT 7CE8 SIZE 00000054 BYTES

		REP	#$20
		LDY	#$C
		LDA	[$50],Y
		TAY
		LDA	a:.LOWORD(4),Y
		AND	#$FF
		BNE	loc_C57567
		SEP	#$20
.A8
		LDA	#.LOBYTE(loc_C5753B)
		STA	z:$DB
		LDA	#.HIBYTE(loc_C5753B)
		STA	z:$DC
		LDA	#.BANKBYTE(loc_C5753B)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	loc_C57567
		LDA	z:$50
		STA	a:.LOWORD($22),Y
		LDA	#$C5
		STA	a:.LOWORD($24),Y
		BRA	loc_C57567
; ---------------------------------------------------------------------------

loc_C5753B:
		JSL	f:sub_C57570
		JMP	a:.LOWORD(loc_C57CE8)
; ---------------------------------------------------------------------------

loc_C57542:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C57570)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C57570)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C57570)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	loc_C57567
		LDA	z:$50
		STA	a:.LOWORD($22),Y
		LDA	#$C5
		STA	a:.LOWORD($24),Y

loc_C57567:
		LDA	z:$50
		CLC
		ADC	#$E
		STA	z:$50
		RTL
; End of function sub_C57504

.A16
.I16

sub_C57570:
		REP	#$20
		LDA	z:$22,X
		STA	z:$50
		LDA	z:$23,X
		STA	z:$51
		LDA	#$30
		STA	z:$E,X
		LDY	#2
		LDA	[$50],Y
		STA	z:$1E,X
		LDY	#4
		LDA	[$50],Y
		STA	z:$11,X
		LDY	#6
		LDA	[$50],Y
		STA	z:$14,X
		LDY	#$A
		LDA	[$50],Y
		STA	z:$30,X
		REP	#$20
		LDA	#.LOWORD(player_animation_list)
		STA	z:$18,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(player_animation_list)
		STA	z:$1A,X
		LDY	#8
		LDA	[$50],Y
		STA	z:$40
		JSL	f:sub_C57F9F
		REP	#$20
.A16
		LDA	#.LOWORD(sub_C575C1)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C575C1)
		STA	z:2,X
		RTL
; End of function sub_C57570

.A8
.I16

sub_C575C1:
		REP	#$20
.A16
		DEC	z:$30,X
		BNE	loc_C575E2
		LDA	#$B30
		STA	z:$E,X
		LDA	#$1C
		STA	z:$40
		JSL	f:sub_C57F9F
		REP	#$20
		LDA	#.LOWORD(sub_C575FD)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C575FD)
		STA	z:2,X

loc_C575E2:
		REP	#$20
.A16
		LDA	z:$14,X
		PHA
		LDA	z:$1E,X
		CMP	#$A
		BNE	loc_C575F3
		LDA	#1
		STA	z:$14,X

loc_C575F3:
		JSL	f:advance_animation_2
		REP	#$20
		PLA
		STA	z:$14,X
		RTL
; End of function sub_C575C1

.A16
.I16

sub_C575FD:
		JSL	f:advance_animation
		RTL
; End of function sub_C575FD

.A16
.I16

sub_C57602:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C57621)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C57621)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C57621)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCC	locret_C57620
		JML	f:nullsub_7
; ---------------------------------------------------------------------------

locret_C57620:
		RTL
; End of function sub_C57602

.A16
.I16

sub_C57621:
		JSL	f:sub_C573EA
		JSL	f:sub_C576B5
		REP	#$20
		LDA	#.LOWORD(loc_C5767D)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C5767D)
		STA	z:2,X
		SEP	#$20
		LDA	#$17
		STA	a:.LOWORD(main_screen_status) ; orig=0x0C97
		LDA	#$17
		STA	a:.LOWORD(subscreen_status) ; orig=0x0C98
		LDA	#0
		STA	a:.LOWORD(color_addition_settings)	; orig=0x0C99
		LDA	#0
		STA	a:.LOWORD(add_substract_select_and_enable)	; orig=0x0C9A
		REP	#$20
.A16
		LDA	#0
		STA	a:.LOWORD(bg2_h_scroll) ; orig=0x0CA1
		LDA	#0
		STA	a:.LOWORD(bg2_v_scroll) ; orig=0x0CA3
		LDA	#0
		STA	a:.LOWORD(bg1_h_scroll) ; orig=0x0C9D
		LDA	#$3FF
		STA	a:.LOWORD(bg1_v_scroll) ; orig=0x0C9F
		STZ	z:$10,X
		LDA	#$180
		STA	z:$12,X
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2+1) ; orig=0x0D17
		AND	#$FF
		CMP	#$68
		BNE	loc_C5767D
		LDA	#$500
		STA	z:$12,X

loc_C5767D:
		REP	#$20
		LDA	z:$12,X
		INC	z:$10,X
		CMP	z:$10,X
		BEQ	loc_C5769D
		CMP	#$500
		BEQ	locret_C576B4
		LDA	z:$10,X
		CMP	#$80
		BCC	locret_C576B4
		JSL	f:sub_C5395A
		SEP	#$20
.A8
		BIT	#$10
		BEQ	locret_C576B4

loc_C5769D:
		SEP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2) ; orig=0x0D16
		CMP	#$31
		BNE	loc_C576A8
		LDA	#$FF

loc_C576A8:
		INC
		STA	a:.LOWORD(current_screen) ; orig=0x00A4
		JSL	f:delete_object
		JSL	f:fade_out_music

locret_C576B4:
		RTL
; End of function sub_C57621

.A16
.I16

sub_C576B5:
		SEP	#$20
.A8
		LDA	#.BANKBYTE(byte_C576E3)
		STA	z:$52
		LDA	#.BANKBYTE(byte_C576E3)
		STA	z:$55
		REP	#$20
.A16
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2+1) ; orig=0x0D17
		AND	#$F0
		LSR
		LSR
		LSR
		PHX
		TAX
		LDA	f:off_C57AB1,X
		PLX
		STA	z:$50

loc_C576D3:
		LDA	[$50]
		STA	z:$53
		JSL	f:call_function_at_0053
		LDA	[$50]
		CMP	#$FFFF
		BNE	loc_C576D3
		RTL
; End of function sub_C576B5

; ---------------------------------------------------------------------------
byte_C576E3:	.ADDR sub_C57B11
		.BYTE $48, 0, $90, 0
		.BYTE $48, 0, $90, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE $90, 0, 6, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $48, 0, $90, 0
		.BYTE $48, 0, $90, 0
		.BYTE 2, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE $90, 0, 6, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0
		.WORD $FFFF
off_C57725:	.ADDR sub_C57B11
		.BYTE $48, 0, $90, 0
		.BYTE $79, 0, $90, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0, $60, 0
		.BYTE $60, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $48, 0, $90, 0
		.BYTE $79, 0, $90, 0
		.BYTE 2, 0, 0, 0
		.BYTE 0, 0, $60, 0
		.BYTE $60, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0
		.WORD $FFFF
off_C57767:	.ADDR sub_C57B11
		.BYTE $79, 0, $90, 0
		.BYTE $B0, 0, $90, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0, $60, 0
		.BYTE $60, 0, 0, 0
		.BYTE 1, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0, 0, 0, $B0
		.BYTE 0, $90, 0, $B0
		.BYTE 0, $82, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0, 0, $20
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0
		.FARADDR player_animation_list
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $79, 0, $90, 0
		.BYTE $B0, 0, $90, 0
		.BYTE 2, 0, 0, 0
		.BYTE 0, 0, $60, 0
		.BYTE $60, 0, 0, 0
		.BYTE 1, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0, 0, 0, $B0
		.BYTE 0, $90, 0, $B0
		.BYTE 0, $82, 0, 2
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0, 0, $20
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0
		.FARADDR player_animation_list
		.BYTE 0
		.WORD $FFFF
off_C577E9:	.ADDR sub_C57B11
		.BYTE $B1, 0, $60, 0
		.BYTE $B8, 0, $3F, 0
		.BYTE 6, 0, 4, 0
		.BYTE 0, 0, $40, 0
		.BYTE $60, 0, 1, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.ADDR off_C71F25
		.BYTE $C7
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $B1, 0, $60, 0
		.BYTE $B8, 0, $3F, 0
		.BYTE 0, 0, 0, 0
		.BYTE $60, 0, $20, 0
		.BYTE $60, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $B1, 0, $60, 0
		.BYTE $B8, 0, $3F, 0
		.BYTE 2, 0, 0, 0
		.BYTE $60, 0, $20, 0
		.BYTE $60, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0
		.ADDR sub_C574EE
		.ADDR loc_C57542
		.BYTE $A, 0, $94, 0
		.BYTE $70, 0, 4, 0
		.BYTE 1, 0, 0, 0
		.ADDR loc_C57542
		.BYTE $C, 0, $94, 0
		.BYTE $88, 0, 4, 0
		.BYTE 1, 0, 0, 0
		.ADDR loc_C57542
		.BYTE $E, 0, $CD, 0
		.BYTE $70, 0, 4, 0
		.BYTE 1, 0, 0, 0
		.ADDR loc_C57542
		.BYTE 4, 0, $CD, 0
		.BYTE $88, 0, 4, 0
		.BYTE 1, 0, 0, 0
		.WORD $FFFF
off_C57885:	.ADDR sub_C57B11
		.BYTE $A0, 0, $30, 0
		.BYTE $5E, 0, $30, 0
		.BYTE 6, 0, 4, 0
		.BYTE 0, 0, $40, 0
		.BYTE $60, 0, 1, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.ADDR off_C71F25
		.BYTE $C7
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $A0, 0, $30, 0
		.BYTE $5E, 0, $30, 0
		.BYTE 0, 0, 0, 0
		.BYTE $60, 0, $20, 0
		.BYTE $60, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $A0, 0, $30, 0
		.BYTE $5E, 0, $30, 0
		.BYTE 2, 0, 0, 0
		.BYTE $60, 0, $20, 0
		.BYTE $60, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0
		.WORD $FFFF
off_C578E7:	.ADDR sub_C57B11
		.BYTE $50, 0, $40, 0
		.BYTE $68, 0, $5F, 0
		.BYTE 4, 0, 8, 0
		.BYTE 0, 0, $40, 0
		.BYTE $60, 0, 1, 0
		.BYTE 1, 0, 0, 0
		.BYTE 0, 0
		.ADDR off_C71F55
		.BYTE $C7
		.BYTE 0, 0, 0, $68
		.BYTE 0, $5F, 0, $88
		.BYTE 0, $5F, 0, 4
		.BYTE 0, 8, 0, 0
		.BYTE 0, 0, 0, $28
		.BYTE 0, 1, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0
		.ADDR off_C71F55
		.BYTE $C7
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $40, 0, $40, 0
		.BYTE $58, 0, $5F, 0
		.BYTE 6, 0, 4, 0
		.BYTE 0, 0, $40, 0
		.BYTE $60, 0, 1, 0
		.BYTE 1, 0, 0, 0
		.BYTE 0, 0
		.ADDR off_C71F25
		.BYTE $C7
		.BYTE 0, 0, 0, $58
		.BYTE 0, $5F, 0, $78
		.BYTE 0, $5F, 0, 6
		.BYTE 0, 4, 0, 0
		.BYTE 0, 0, 0, $28
		.BYTE 0, 1, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0
		.ADDR off_C71F25
		.BYTE $C7
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $48, 0, $40, 0
		.BYTE $60, 0, $5F, 0
		.BYTE 0, 0, 0, 0
		.BYTE $60, 0, $20, 0
		.BYTE $60, 0, 0, 0
		.BYTE 1, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $60, 0, $5F, 0
		.BYTE $80, 0, $5F, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE $28, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $48, 0, $40, 0
		.BYTE $60, 0, $5F, 0
		.BYTE 2, 0, 0, 0
		.BYTE $60, 0, $20, 0
		.BYTE $60, 0, 0, 0
		.BYTE 1, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $60, 0, $5F, 0
		.BYTE $80, 0, $5F, 0
		.BYTE 2, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE $28, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0
		.WORD $FFFF
off_C579E9:	.ADDR sub_C57504
		.BYTE 0, 0, $93, 0
		.BYTE $69, 0, 8, 0
		.BYTE $FB, 2, $40, $D
		.ADDR sub_C57504
		.BYTE 2, 0, $6D, 0
		.BYTE $69, 0, 8, 0
		.BYTE $FB, 2, $80, $D
		.ADDR loc_C57542
		.BYTE $A, 0, $80, 0
		.BYTE $3D, 0, 4, 0
		.BYTE $FB, 2, 0, 0
		.ADDR loc_C57542
		.BYTE $C, 0, $58, 0
		.BYTE $58, 0, 1, 0
		.BYTE $FB, 2, 0, 0
		.ADDR loc_C57542
		.BYTE $E, 0, $A8, 0
		.BYTE $58, 0, 2, 0
		.BYTE $FB, 2, 0, 0
		.ADDR sub_C57B11
		.BYTE $88, 0, $5F, 0
		.BYTE $93, 0, $50, 0
		.BYTE 4, 0, 8, 0
		.BYTE $FF, 0, 8, 0
		.BYTE $30, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.ADDR off_C71F6D
		.BYTE $C7
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $78, 0, $5F, 0
		.BYTE $6D, 0, $50, 0
		.BYTE 6, 0, 4, 0
		.BYTE $FF, 0, 8, 0
		.BYTE $30, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.ADDR off_C71F3D
		.BYTE $C7
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $80, 0, $5F, 0
		.BYTE $93, 0, $69, 0
		.BYTE 0, 0, 0, 0
		.BYTE $70, 0, 8, 0
		.BYTE $30, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0
		.ADDR sub_C57B11
		.BYTE $80, 0, $5F, 0
		.BYTE $6D, 0, $69, 0
		.BYTE 2, 0, 0, 0
		.BYTE $70, 0, 8, 0
		.BYTE $30, 0, 0, 0
		.BYTE 0, 0, 0, 0
		.BYTE 0, 0
		.FARADDR player_animation_list
		.BYTE 0
		.WORD $FFFF
off_C57AB1:	.ADDR byte_C576E3, off_C57725, off_C57767, off_C577E9, off_C57885
		.ADDR off_C578E7, off_C579E9
.A16
.I16

sub_C57ABF:
		REP	#$20
		STZ	z:$16,X
		LDA	z:$F,X
		AND	#$FF
		BNE	locret_C57B10
		LDA	#$FFF8
		STA	z:$40
		LDA	#$D80
		STA	z:$42
		LDA	z:$1E,X
		AND	#$FF
		BNE	loc_C57AE5
		LDA	#8
		STA	z:$40
		LDA	#$D40
		STA	z:$42

loc_C57AE5:
		LDY	z:$42
		LDA	a:.LOWORD(4),Y
		AND	#$FF
		BNE	loc_C57AF3
		JML	f:loc_C57CBE
; ---------------------------------------------------------------------------

loc_C57AF3:
		LDA	a:.LOWORD(level_manager_object+level_manager_object::gameover_related) ; orig=0x0D32
		AND	#$FF
		CMP	#1
		BEQ	locret_C57B10
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2+1) ; orig=0x0D17
		AND	#$FF
		CMP	#$68
		BEQ	locret_C57B10
		LDA	z:$11,X
		CLC
		ADC	z:$40
		STA	z:$11,X

locret_C57B10:
		RTL
; End of function sub_C57ABF

.A16
.I16

sub_C57B11:
		SEP	#$20
.A8
		LDA	#.LOBYTE(sub_C57B47)
		STA	z:$DB
		LDA	#.HIBYTE(sub_C57B47)
		STA	z:$DC
		LDA	#.BANKBYTE(sub_C57B47)
		STA	z:$DD
		LDA	#$80
		STA	z:$D3
		JSL	f:create_object
		REP	#$20
.A16
		BCS	loc_C57B36
		LDA	z:$50
		STA	a:.LOWORD($22),Y
		LDA	#$C5
		STA	a:.LOWORD($24),Y

loc_C57B36:
		LDY	#$16
		LDA	[$50],Y
		INC
		ASL
		ASL
		ASL
		ASL
		ASL
		CLC
		ADC	z:$50
		STA	z:$50
		RTL
; End of function sub_C57B11

.A16
.I16

sub_C57B47:
		REP	#$20
		LDA	z:$22,X
		STA	z:$50
		LDA	z:$23,X
		STA	z:$51
		LDA	#$30
		STA	z:$E,X
		LDY	#$C
		LDA	[$50],Y
		STA	z:$F,X
		LDY	#$A
		LDA	[$50],Y
		STA	z:$1E,X
		LDA	#0
		STA	z:$10,X
		LDA	#0
		STA	z:$13,X
		LDY	#2
		LDA	[$50],Y
		STA	z:$11,X
		LDY	#4
		LDA	[$50],Y
		STA	z:$14,X
		LDY	#$1C
		LDA	[$50],Y
		STA	z:$18,X
		LDY	#$1E
		LDA	[$50],Y
		STA	z:$1A,X
		LDY	#$E
		LDA	[$50],Y
		STA	z:$30,X
		LDY	#$10
		LDA	[$50],Y
		STA	z:$32,X
		LDY	#$12
		LDA	[$50],Y
		STA	z:$34,X
		LDY	#$16
		LDA	[$50],Y
		STA	z:$36,X
		STZ	z:$3C,X
		LDA	#4
		STA	z:$40
		JSL	f:sub_C57F9F
		JSL	f:sub_C57ABF
		REP	#$20
		LDA	#.LOWORD(loc_C57BC2)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57BC2)
		STA	z:2,X

loc_C57BC2:
		REP	#$20
.A16
		DEC	z:$30,X
		BMI	loc_C57BCC
		JML	f:locret_C57C52
; ---------------------------------------------------------------------------

loc_C57BCC:
		REP	#$20
		LDA	#.LOWORD(loc_C57BD9)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57BD9)
		STA	z:2,X

loc_C57BD9:
		REP	#$20
.A16
		DEC	z:$32,X
		BMI	loc_C57BE3
		JML	f:loc_C57C4E
; ---------------------------------------------------------------------------

loc_C57BE3:
		LDA	z:$22,X
		STA	z:$50
		LDA	z:$23,X
		STA	z:$51
		LDY	#$14
		LDA	[$50],Y
		BIT	#2
		BNE	loc_C57BF9
		JSL	f:sub_C57EF3

loc_C57BF9:
		REP	#$20
		LDA	#.LOWORD(loc_C57C06)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57C06)
		STA	z:2,X

loc_C57C06:
		REP	#$20
.A16
		LDA	z:$22,X
		STA	z:$50
		LDA	z:$23,X
		STA	z:$51
		LDY	#$14
		LDA	[$50],Y
		BIT	#2
		BNE	loc_C57C3B
		CLC
		LDA	z:$38,X
		ADC	z:$10,X
		STA	z:$10,X
		CLC
		LDA	z:$3A,X
		ADC	z:$13,X
		STA	z:$13,X
		DEC	z:$34,X
		BNE	loc_C57C4E
		DEC	z:$36,X
		BMI	loc_C57C53
		LDA	z:$22,X
		CLC
		ADC	#$20
		STA	z:$22,X
		JMP	a:.LOWORD(sub_C57B47)
; ---------------------------------------------------------------------------

loc_C57C3B:
		DEC	z:$34,X
		BNE	loc_C57C9C
		DEC	z:$36,X
		BMI	loc_C57C53
		LDA	z:$22,X
		CLC
		ADC	#$20
		STA	z:$22,X
		JMP	a:.LOWORD(sub_C57B47)
; ---------------------------------------------------------------------------

loc_C57C4E:
		JSL	f:advance_animation

locret_C57C52:
		RTL
; ---------------------------------------------------------------------------

loc_C57C53:
		REP	#$20
		LDA	z:$22,X
		STA	z:$50
		LDA	z:$23,X
		STA	z:$51
		LDY	#6
		LDA	[$50],Y
		STA	z:$11,X
		LDY	#8
		LDA	[$50],Y
		STA	z:$14,X
		JSL	f:sub_C57ABF
		REP	#$20
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2+1) ; orig=0x0D17
		AND	#$FF
		CMP	#$68
		BEQ	loc_C57CC3
		LDY	#$14
		LDA	[$50],Y
		BIT	#1
		BNE	loc_C57CBE
		LDA	#4
		STA	z:$40
		JSL	f:sub_C57F9F
		REP	#$20
		LDA	#.LOWORD(loc_C57C9C)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57C9C)
		STA	z:2,X

loc_C57C9C:
		REP	#$20
.A16
		LDA	z:$22,X
		STA	z:$50
		LDA	z:$23,X
		STA	z:$51
		LDY	#$14
		LDA	[$50],Y
		BIT	#4
		BEQ	loc_C57CB9
		INC	z:$3C,X
		LDA	z:$3C,X
		BIT	#$20
		BEQ	locret_C57CBD

loc_C57CB9:
		JSL	f:advance_animation_2

locret_C57CBD:
		RTL
; ---------------------------------------------------------------------------

loc_C57CBE:
		JSL	f:delete_object
		RTL
; ---------------------------------------------------------------------------

loc_C57CC3:
		REP	#$20
		LDA	#.LOWORD(loc_C57D02)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57D02)
		STA	z:2,X
		REP	#$20
.A16
		LDA	z:$F,X
		AND	#$FF
		BEQ	loc_C57D37
		REP	#$20
		LDA	#.LOWORD(sub_C57DF7)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C57DF7)
		STA	z:2,X
		BRA	loc_C57D37
; End of function sub_C57B47

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_C57504

loc_C57CE8:
		REP	#$20
.A16
		LDA	#$A9
		STA	z:$20,X
		REP	#$20
		LDA	#.LOWORD(loc_C57CFC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57CFC)
		STA	z:2,X

loc_C57CFC:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	loc_C57D37

loc_C57D02:
		REP	#$20
		LDA	#$180
		STA	z:$20,X
		LDA	#8
		STA	z:$40
		JSL	f:sub_C57F9F
		REP	#$20
		LDA	#.LOWORD(loc_C57D1F)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57D1F)
		STA	z:2,X

loc_C57D1F:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	loc_C57D37
		LDA	#$10
		STA	z:$20,X
		REP	#$20
		LDA	#.LOWORD(sub_C57D3C)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C57D3C)
		STA	z:2,X

loc_C57D37:
		JSL	f:advance_animation_2
		RTL
; END OF FUNCTION CHUNK	FOR sub_C57504
.A8
.I16

sub_C57D3C:
		REP	#$20
.A16
		DEC	z:$14,X
		DEC	z:$20,X
		BNE	loc_C57D5A
		LDA	#$14
		STA	z:$40
		JSL	f:sub_C57F9F
		REP	#$20
		LDA	#.LOWORD(sub_C57D5F)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C57D5F)
		STA	z:2,X

loc_C57D5A:
		JSL	f:advance_animation
		RTL
; End of function sub_C57D3C

.A8
.I16

sub_C57D5F:
		JSL	f:advance_animation
		BCC	locret_C57D82
		REP	#$20
.A16
		LDA	#$10
		STA	z:$20,X
		LDA	#8
		STA	z:$40
		JSL	f:sub_C57F9F
		REP	#$20
		LDA	#.LOWORD(sub_C57D83)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C57D83)
		STA	z:2,X

locret_C57D82:
		RTL
; End of function sub_C57D5F

.A8
.I16

sub_C57D83:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	loc_C57DA4
		LDA	#$10
		STA	z:$20,X
		LDA	#4
		STA	z:$40
		JSL	f:sub_C57F9F
		REP	#$20
		LDA	#.LOWORD(sub_C57DA9)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C57DA9)
		STA	z:2,X

loc_C57DA4:
		JSL	f:advance_animation_2
		RTL
; End of function sub_C57D83

.A8
.I16

sub_C57DA9:
		REP	#$20
.A16
		INC	z:$14,X
		DEC	z:$20,X
		BNE	loc_C57DCC
		LDA	#$F0
		STA	z:$20,X
		LDA	#8
		STA	z:$40
		JSL	f:sub_C57F9F
		REP	#$20
		LDA	#.LOWORD(sub_C57DD1)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C57DD1)
		STA	z:2,X

loc_C57DCC:
		JSL	f:advance_animation
		RTL
; End of function sub_C57DA9

.A8
.I16

sub_C57DD1:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	loc_C57DF2
		LDA	#$B30
		STA	z:$E,X
		LDA	#$1C
		STA	z:$40
		JSL	f:sub_C57F9F
		REP	#$20
		LDA	#.LOWORD(loc_C57DCC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57DCC)
		STA	z:2,X

loc_C57DF2:
		JSL	f:advance_animation_2
		RTL
; End of function sub_C57DD1

.A8
.I16

sub_C57DF7:
		REP	#$20
.A16
		LDA	#$100
		STA	z:$20,X
		LDA	#4
		STA	z:$40
		JSL	f:sub_C57F9F
		REP	#$20
		LDA	#.LOWORD(loc_C57E14)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57E14)
		STA	z:2,X

loc_C57E14:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	loc_C57E38
		LDA	#0
		STA	z:$20,X
		LDA	#$FA00
		STA	z:$34,X
		REP	#$20
		LDA	#.LOWORD(sub_C57E3D)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C57E3D)
		STA	z:2,X
		LDY	#$16
		JSL	f:play_sound

loc_C57E38:
		JSL	f:advance_animation
		RTL
; End of function sub_C57DF7

.A8
.I16

sub_C57E3D:
		REP	#$20
.A16
		LDA	z:$20,X
		ASL
		PHX
		TAX
		LDA	f:word_C57EED,X
		PLX
		STA	z:$34,X
		REP	#$20
		LDA	#.LOWORD(loc_C57E58)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57E58)
		STA	z:2,X

loc_C57E58:
		REP	#$20
.A16
		LDA	#$B
		STA	z:$40
		STZ	z:$42
		LDA	z:$34,X
		CLC
		ADC	#$20
		STA	z:$34,X
		BPL	loc_C57E74
		DEC	z:$42
		PHA
		LDA	#4
		STA	z:$40
		PLA

loc_C57E74:
		CLC
		ADC	z:$13,X
		STA	z:$13,X
		SEP	#$20
.A8
		LDA	z:$42
		ADC	z:$15,X
		STA	z:$15,X
		LDA	z:$20,X
		BEQ	loc_C57E89
		LDA	#$B
		STA	z:$40

loc_C57E89:
		JSL	f:sub_C57F9F
		REP	#$20
.A16
		LDA	z:$14,X
		BMI	loc_C57EC7
		CMP	#$58
		BCC	loc_C57EC7
		LDA	#$58
		STA	z:$14,X
		REP	#$20
		LDA	#.LOWORD(sub_C57E3D)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C57E3D)
		STA	z:2,X
		REP	#$20
.A16
		INC	z:$20,X
		LDA	z:$20,X
		CMP	#3
		BNE	loc_C57EC7
		LDA	#$20
		STA	z:$20,X
		REP	#$20
		LDA	#.LOWORD(sub_C57ECC)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(sub_C57ECC)
		STA	z:2,X

loc_C57EC7:
		JSL	f:advance_animation
		RTL
; End of function sub_C57E3D

.A8
.I16

sub_C57ECC:
		REP	#$20
.A16
		DEC	z:$20,X
		BNE	loc_C57EE8
		LDA	#$A
		STA	z:$40
		JSL	f:sub_C57F9F
		REP	#$20
		LDA	#.LOWORD(loc_C57EE8)
		STA	z:0,X
		SEP	#$20
.A8
		LDA	#.BANKBYTE(loc_C57EE8)
		STA	z:2,X

loc_C57EE8:
		JSL	f:advance_animation
		RTL
; End of function sub_C57ECC

; ---------------------------------------------------------------------------
word_C57EED:	.WORD $FA00, $FD00, $FE00
.A16
.I16

sub_C57EF3:
		REP	#$20
		LDA	z:$22,X
		STA	z:$50
		LDA	z:$23,X
		STA	z:$51
		LDY	#6
		LDA	[$50],Y
		LDY	#2
		SEC
		SBC	[$50],Y
		STA	z:$40
		JSL	f:sub_C57F51
		LDA	z:$40
		STA	z:$38,X
		LDY	#8
		LDA	[$50],Y
		LDY	#4
		SEC
		SBC	[$50],Y
		STA	z:$40
		JSL	f:sub_C57F51
		LDA	z:$40
		STA	z:$3A,X
		LDA	z:$38,X
		SEC
		SBC	z:$3A,X
		BCS	loc_C57F3E
		LDA	#8
		STA	z:$40
		LDA	z:$3A,X
		BMI	loc_C57F4C
		LDA	#4
		STA	z:$40
		BRA	loc_C57F4C
; ---------------------------------------------------------------------------

loc_C57F3E:
		LDA	#2
		STA	z:$40
		LDA	z:$38,X
		BMI	loc_C57F4C
		LDA	#1
		STA	z:$40

loc_C57F4C:
		JSL	f:sub_C57F9F
		RTL
; End of function sub_C57EF3

.A16
.I16

sub_C57F51:
		SEP	#$20
.A8
		LDA	#0
		STA	z:$44
		LDA	z:0
		STA	a:.LOWORD(DIVIDEND_LOW_BYTE)
		LDA	z:$40
		STA	a:.LOWORD(DIVIDEND_HIGH_BYTE)
		LDA	z:$41
		BPL	loc_C57F76
		LDA	z:$40
		EOR	#$FF
		INC
		STA	a:.LOWORD(DIVIDEND_HIGH_BYTE)
		LDA	z:0
		STA	a:.LOWORD(DIVIDEND_LOW_BYTE)
		LDA	#1
		STA	z:$44

loc_C57F76:
		LDA	z:$34,X
		STA	a:.LOWORD(DIVISOR_B)
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		REP	#$20
.A16
		LDA	a:.LOWORD(QUOTIENT_OF_DIVIDE_RESULT_LOW_BYTE)
		STA	z:$40
		LDA	z:$44
		BEQ	locret_C57F9E
		LDA	z:$40
		EOR	#$FFFF
		INC
		STA	z:$40

locret_C57F9E:
		RTL
; End of function sub_C57F51

.A16
.I16

sub_C57F9F:
		REP	#$20
		LDA	z:$1A,X
		STA	z:$52
		LDA	z:$40
		AND	#$FF
		ASL
		CLC
		ADC	z:$18,X
		STA	z:$50
		LDA	[$50]
		STA	z:$50
		JSL	f:start_animation
		RTL
; End of function sub_C57F9F

.A8
.I16

generate_password:
		SEP	#$20
		PHX
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2+1) ; orig=0x0D17
		SEC
		SBC	#$10
		AND	#$70
		LSR
		LSR
		LSR
		LSR
		STA	a:.LOWORD(word_7E0C7F+1) ;	orig=0x0C80
		LDA	a:.LOWORD(level_manager_object+level_manager_object::anonymous_2+1) ; orig=0x0D17
		DEC
		AND	#7
		STA	a:.LOWORD(word_7E0C81) ; orig=0x0C81
		LDX	#8
		JSL	f:random
		SEP	#$20
		AND	#6
		STA	a:.LOWORD(word_7E0C81+1) ;	orig=0x0C82
		CLC
		ADC	a:.LOWORD(word_7E0C81) ; orig=0x0C81
		CLC
		ADC	a:.LOWORD(word_7E0C7F+1) ;	orig=0x0C80
		AND	#7
		STA	a:.LOWORD(word_7E0C7F) ; orig=0x0C7F
		REP	#$20
.A16
		LDA	a:.LOWORD(word_7E0C7F) ; orig=0x0C7F
		AND	#$FF
		ASL
		TAX
		LDA	f:password_encryption_key,X
		SEP	#$20
.A8
		STA	a:.LOWORD(word_7E0C7F) ; orig=0x0C7F
		REP	#$20
.A16
		LDA	a:.LOWORD(word_7E0C7F+1) ;	orig=0x0C80
		AND	#$FF
		ASL
		TAX
		LDA	f:password_encryption_key,X
		SEP	#$20
.A8
		STA	a:.LOWORD(word_7E0C7F+1) ;	orig=0x0C80
		REP	#$20
.A16
		LDA	a:.LOWORD(word_7E0C81) ; orig=0x0C81

loc_C5801A:
		AND	#$FF
		ASL
		TAX
		LDA	f:password_encryption_key,X
		SEP	#$20
.A8
		STA	a:.LOWORD(word_7E0C81) ; orig=0x0C81
		REP	#$20
.A16
		LDA	a:.LOWORD(word_7E0C81+1) ;	orig=0x0C82
		AND	#$FF
		ASL
		TAX
		LDA	f:password_encryption_key,X
		SEP	#$20
.A8
		STA	a:.LOWORD(word_7E0C81+1) ;	orig=0x0C82
		PLX
		REP	#$20
.A16
		LDA	a:.LOWORD(word_7E0C7F) ; orig=0x0C7F
		STA	a:.LOWORD(word_7E0C83) ; orig=0x0C83
		STA	a:.LOWORD(word_7E0C87) ; orig=0x0C87
		LDA	a:.LOWORD(word_7E0C81) ; orig=0x0C81
		STA	a:.LOWORD(word_7E0C85) ; orig=0x0C85
		STA	a:.LOWORD(word_7E0C89) ; orig=0x0C89
		RTL
; End of function generate_password

off_C58051:
        .WORD 0
		.WORD 0
		.WORD 0
		.ADDR byte_C5617E
		.WORD 0
		.ADDR byte_C56176
		.ADDR byte_C5616E
		.ADDR byte_C561AA
		.WORD 0
		.ADDR byte_C56166
		.ADDR byte_C5615E
		.ADDR byte_C5619E
		.ADDR byte_C56156
		.ADDR byte_C56192
		.ADDR byte_C56186
		.ADDR byte_C561B6
DATA_END