
module raster (
    input   wire                clk,
    input   wire                rst,
    input   wire [0:10]         hcnt,
    input   wire [0:9]          vcnt,

    // Tile/color translation
    input   wire [0:(8*200)-1]  tiles,
    input   wire [0:(16*8)-1]   next_tiles,

    output  reg  [0:47]         pixels
);

localparam XOFFSET = 218;   // 224 clks before visible pixels; 224/(16 pix/tile * 2 clks/pix) = 7; +1 to start before the tile needed
localparam YOFFSET = 12;    // 12 lines scanned above display area

// Define tile coordinates
/*
localparam
GAME_TILE_0		    = {6'd6, 6'd6},
GAME_TILE_1		    = {6'd7, 6'd6},
GAME_TILE_2		    = {6'd8, 6'd6},
GAME_TILE_3		    = {6'd9, 6'd6},
GAME_TILE_4		    = {6'd10, 6'd6},
GAME_TILE_5		    = {6'd11, 6'd6},
GAME_TILE_6		    = {6'd12, 6'd6},
GAME_TILE_7		    = {6'd13, 6'd6},
GAME_TILE_8		    = {6'd14, 6'd6},
GAME_TILE_9		    = {6'd15, 6'd6},
GAME_TILE_10		= {6'd6, 6'd7},
GAME_TILE_11		= {6'd7, 6'd7},
GAME_TILE_12		= {6'd8, 6'd7},
GAME_TILE_13		= {6'd9, 6'd7},
GAME_TILE_14		= {6'd10, 6'd7},
GAME_TILE_15		= {6'd11, 6'd7},
GAME_TILE_16		= {6'd12, 6'd7},
GAME_TILE_17		= {6'd13, 6'd7},
GAME_TILE_18		= {6'd14, 6'd7},
GAME_TILE_19		= {6'd15, 6'd7},
GAME_TILE_20		= {6'd6, 6'd8},
GAME_TILE_21		= {6'd7, 6'd8},
GAME_TILE_22		= {6'd8, 6'd8},
GAME_TILE_23		= {6'd9, 6'd8},
GAME_TILE_24		= {6'd10, 6'd8},
GAME_TILE_25		= {6'd11, 6'd8},
GAME_TILE_26		= {6'd12, 6'd8},
GAME_TILE_27		= {6'd13, 6'd8},
GAME_TILE_28		= {6'd14, 6'd8},
GAME_TILE_29		= {6'd15, 6'd8},
GAME_TILE_30		= {6'd6, 6'd9},
GAME_TILE_31		= {6'd7, 6'd9},
GAME_TILE_32		= {6'd8, 6'd9},
GAME_TILE_33		= {6'd9, 6'd9},
GAME_TILE_34		= {6'd10, 6'd9},
GAME_TILE_35		= {6'd11, 6'd9},
GAME_TILE_36		= {6'd12, 6'd9},
GAME_TILE_37		= {6'd13, 6'd9},
GAME_TILE_38		= {6'd14, 6'd9},
GAME_TILE_39		= {6'd15, 6'd9},
GAME_TILE_40		= {6'd6, 6'd10},
GAME_TILE_41		= {6'd7, 6'd10},
GAME_TILE_42		= {6'd8, 6'd10},
GAME_TILE_43		= {6'd9, 6'd10},
GAME_TILE_44		= {6'd10, 6'd10},
GAME_TILE_45		= {6'd11, 6'd10},
GAME_TILE_46		= {6'd12, 6'd10},
GAME_TILE_47		= {6'd13, 6'd10},
GAME_TILE_48		= {6'd14, 6'd10},
GAME_TILE_49		= {6'd15, 6'd10},
GAME_TILE_50		= {6'd6, 6'd11},
GAME_TILE_51		= {6'd7, 6'd11},
GAME_TILE_52		= {6'd8, 6'd11},
GAME_TILE_53		= {6'd9, 6'd11},
GAME_TILE_54		= {6'd10, 6'd11},
GAME_TILE_55		= {6'd11, 6'd11},
GAME_TILE_56		= {6'd12, 6'd11},
GAME_TILE_57		= {6'd13, 6'd11},
GAME_TILE_58		= {6'd14, 6'd11},
GAME_TILE_59		= {6'd15, 6'd11},
GAME_TILE_60		= {6'd6, 6'd12},
GAME_TILE_61		= {6'd7, 6'd12},
GAME_TILE_62		= {6'd8, 6'd12},
GAME_TILE_63		= {6'd9, 6'd12},
GAME_TILE_64		= {6'd10, 6'd12},
GAME_TILE_65		= {6'd11, 6'd12},
GAME_TILE_66		= {6'd12, 6'd12},
GAME_TILE_67		= {6'd13, 6'd12},
GAME_TILE_68		= {6'd14, 6'd12},
GAME_TILE_69		= {6'd15, 6'd12},
GAME_TILE_70		= {6'd6, 6'd13},
GAME_TILE_71		= {6'd7, 6'd13},
GAME_TILE_72		= {6'd8, 6'd13},
GAME_TILE_73		= {6'd9, 6'd13},
GAME_TILE_74		= {6'd10, 6'd13},
GAME_TILE_75		= {6'd11, 6'd13},
GAME_TILE_76		= {6'd12, 6'd13},
GAME_TILE_77		= {6'd13, 6'd13},
GAME_TILE_78		= {6'd14, 6'd13},
GAME_TILE_79		= {6'd15, 6'd13},
GAME_TILE_80		= {6'd6, 6'd14},
GAME_TILE_81		= {6'd7, 6'd14},
GAME_TILE_82		= {6'd8, 6'd14},
GAME_TILE_83		= {6'd9, 6'd14},
GAME_TILE_84		= {6'd10, 6'd14},
GAME_TILE_85		= {6'd11, 6'd14},
GAME_TILE_86		= {6'd12, 6'd14},
GAME_TILE_87		= {6'd13, 6'd14},
GAME_TILE_88		= {6'd14, 6'd14},
GAME_TILE_89		= {6'd15, 6'd14},
GAME_TILE_90		= {6'd6, 6'd15},
GAME_TILE_91		= {6'd7, 6'd15},
GAME_TILE_92		= {6'd8, 6'd15},
GAME_TILE_93		= {6'd9, 6'd15},
GAME_TILE_94		= {6'd10, 6'd15},
GAME_TILE_95		= {6'd11, 6'd15},
GAME_TILE_96		= {6'd12, 6'd15},
GAME_TILE_97		= {6'd13, 6'd15},
GAME_TILE_98		= {6'd14, 6'd15},
GAME_TILE_99		= {6'd15, 6'd15},
GAME_TILE_100		= {6'd6, 6'd16},
GAME_TILE_101		= {6'd7, 6'd16},
GAME_TILE_102		= {6'd8, 6'd16},
GAME_TILE_103		= {6'd9, 6'd16},
GAME_TILE_104		= {6'd10, 6'd16},
GAME_TILE_105		= {6'd11, 6'd16},
GAME_TILE_106		= {6'd12, 6'd16},
GAME_TILE_107		= {6'd13, 6'd16},
GAME_TILE_108		= {6'd14, 6'd16},
GAME_TILE_109		= {6'd15, 6'd16},
GAME_TILE_110		= {6'd6, 6'd17},
GAME_TILE_111		= {6'd7, 6'd17},
GAME_TILE_112		= {6'd8, 6'd17},
GAME_TILE_113		= {6'd9, 6'd17},
GAME_TILE_114		= {6'd10, 6'd17},
GAME_TILE_115		= {6'd11, 6'd17},
GAME_TILE_116		= {6'd12, 6'd17},
GAME_TILE_117		= {6'd13, 6'd17},
GAME_TILE_118		= {6'd14, 6'd17},
GAME_TILE_119		= {6'd15, 6'd17},
GAME_TILE_120		= {6'd6, 6'd18},
GAME_TILE_121		= {6'd7, 6'd18},
GAME_TILE_122		= {6'd8, 6'd18},
GAME_TILE_123		= {6'd9, 6'd18},
GAME_TILE_124		= {6'd10, 6'd18},
GAME_TILE_125		= {6'd11, 6'd18},
GAME_TILE_126		= {6'd12, 6'd18},
GAME_TILE_127		= {6'd13, 6'd18},
GAME_TILE_128		= {6'd14, 6'd18},
GAME_TILE_129		= {6'd15, 6'd18},
GAME_TILE_130		= {6'd6, 6'd19},
GAME_TILE_131		= {6'd7, 6'd19},
GAME_TILE_132		= {6'd8, 6'd19},
GAME_TILE_133		= {6'd9, 6'd19},
GAME_TILE_134		= {6'd10, 6'd19},
GAME_TILE_135		= {6'd11, 6'd19},
GAME_TILE_136		= {6'd12, 6'd19},
GAME_TILE_137		= {6'd13, 6'd19},
GAME_TILE_138		= {6'd14, 6'd19},
GAME_TILE_139		= {6'd15, 6'd19},
GAME_TILE_140		= {6'd6, 6'd20},
GAME_TILE_141		= {6'd7, 6'd20},
GAME_TILE_142		= {6'd8, 6'd20},
GAME_TILE_143		= {6'd9, 6'd20},
GAME_TILE_144		= {6'd10, 6'd20},
GAME_TILE_145		= {6'd11, 6'd20},
GAME_TILE_146		= {6'd12, 6'd20},
GAME_TILE_147		= {6'd13, 6'd20},
GAME_TILE_148		= {6'd14, 6'd20},
GAME_TILE_149		= {6'd15, 6'd20},
GAME_TILE_150		= {6'd6, 6'd21},
GAME_TILE_151		= {6'd7, 6'd21},
GAME_TILE_152		= {6'd8, 6'd21},
GAME_TILE_153		= {6'd9, 6'd21},
GAME_TILE_154		= {6'd10, 6'd21},
GAME_TILE_155		= {6'd11, 6'd21},
GAME_TILE_156		= {6'd12, 6'd21},
GAME_TILE_157		= {6'd13, 6'd21},
GAME_TILE_158		= {6'd14, 6'd21},
GAME_TILE_159		= {6'd15, 6'd21},
GAME_TILE_160		= {6'd6, 6'd22},
GAME_TILE_161		= {6'd7, 6'd22},
GAME_TILE_162		= {6'd8, 6'd22},
GAME_TILE_163		= {6'd9, 6'd22},
GAME_TILE_164		= {6'd10, 6'd22},
GAME_TILE_165		= {6'd11, 6'd22},
GAME_TILE_166		= {6'd12, 6'd22},
GAME_TILE_167		= {6'd13, 6'd22},
GAME_TILE_168		= {6'd14, 6'd22},
GAME_TILE_169		= {6'd15, 6'd22},
GAME_TILE_170		= {6'd6, 6'd23},
GAME_TILE_171		= {6'd7, 6'd23},
GAME_TILE_172		= {6'd8, 6'd23},
GAME_TILE_173		= {6'd9, 6'd23},
GAME_TILE_174		= {6'd10, 6'd23},
GAME_TILE_175		= {6'd11, 6'd23},
GAME_TILE_176		= {6'd12, 6'd23},
GAME_TILE_177		= {6'd13, 6'd23},
GAME_TILE_178		= {6'd14, 6'd23},
GAME_TILE_179		= {6'd15, 6'd23},
GAME_TILE_180		= {6'd6, 6'd24},
GAME_TILE_181		= {6'd7, 6'd24},
GAME_TILE_182		= {6'd8, 6'd24},
GAME_TILE_183		= {6'd9, 6'd24},
GAME_TILE_184		= {6'd10, 6'd24},
GAME_TILE_185		= {6'd11, 6'd24},
GAME_TILE_186		= {6'd12, 6'd24},
GAME_TILE_187		= {6'd13, 6'd24},
GAME_TILE_188		= {6'd14, 6'd24},
GAME_TILE_189		= {6'd15, 6'd24},
GAME_TILE_190		= {6'd6, 6'd25},
GAME_TILE_191		= {6'd7, 6'd25},
GAME_TILE_192		= {6'd8, 6'd25},
GAME_TILE_193		= {6'd9, 6'd25},
GAME_TILE_194		= {6'd10, 6'd25},
GAME_TILE_195		= {6'd11, 6'd25},
GAME_TILE_196		= {6'd12, 6'd25},
GAME_TILE_197		= {6'd13, 6'd25},
GAME_TILE_198		= {6'd14, 6'd25},
GAME_TILE_199		= {6'd15, 6'd25},

NEXT_TILE_0         = {6'd21, 6'd8},
NEXT_TILE_1         = {6'd22, 6'd8},
NEXT_TILE_2         = {6'd23, 6'd8},
NEXT_TILE_3         = {6'd24, 6'd8},
NEXT_TILE_4         = {6'd21, 6'd9},
NEXT_TILE_5         = {6'd22, 6'd9},
NEXT_TILE_6         = {6'd23, 6'd9},
NEXT_TILE_7         = {6'd24, 6'd9},
NEXT_TILE_8         = {6'd21, 6'd10},
NEXT_TILE_9         = {6'd22, 6'd10},
NEXT_TILE_10        = {6'd23, 6'd10},
NEXT_TILE_11        = {6'd24, 6'd10},
NEXT_TILE_12        = {6'd21, 6'd11},
NEXT_TILE_13        = {6'd22, 6'd11},
NEXT_TILE_14        = {6'd23, 6'd11},
NEXT_TILE_15        = {6'd24, 6'd11},

BOARDER_TILE_0      = {6'd5, 6'd6},
BOARDER_TILE_1      = {6'd26, 6'd6},
BOARDER_TILE_2      = {6'd5, 6'd7},
BOARDER_TILE_3      = {6'd26, 6'd7},
BOARDER_TILE_4      = {6'd5, 6'd8},
BOARDER_TILE_5      = {6'd26, 6'd8},
BOARDER_TILE_6      = {6'd5, 6'd9},
BOARDER_TILE_7      = {6'd26, 6'd9},
BOARDER_TILE_8      = {6'd5, 6'd10},
BOARDER_TILE_9      = {6'd26, 6'd10},
BOARDER_TILE_10     = {6'd5, 6'd11},
BOARDER_TILE_11     = {6'd26, 6'd11},
BOARDER_TILE_12     = {6'd5, 6'd12},
BOARDER_TILE_13     = {6'd26, 6'd12},
BOARDER_TILE_14     = {6'd5, 6'd13},
BOARDER_TILE_15     = {6'd26, 6'd13},
BOARDER_TILE_16     = {6'd5, 6'd14},
BOARDER_TILE_17     = {6'd26, 6'd14},
BOARDER_TILE_18     = {6'd5, 6'd15},
BOARDER_TILE_19     = {6'd26, 6'd15},
BOARDER_TILE_20     = {6'd5, 6'd16},
BOARDER_TILE_21     = {6'd26, 6'd16},
BOARDER_TILE_22     = {6'd5, 6'd17},
BOARDER_TILE_23     = {6'd26, 6'd17},
BOARDER_TILE_24     = {6'd5, 6'd18},
BOARDER_TILE_25     = {6'd26, 6'd18},
BOARDER_TILE_26     = {6'd5, 6'd19},
BOARDER_TILE_27     = {6'd26, 6'd19},
BOARDER_TILE_28     = {6'd5, 6'd20},
BOARDER_TILE_29     = {6'd26, 6'd20},
BOARDER_TILE_30     = {6'd5, 6'd21},
BOARDER_TILE_31     = {6'd26, 6'd21},
BOARDER_TILE_32     = {6'd5, 6'd22},
BOARDER_TILE_33     = {6'd26, 6'd22},
BOARDER_TILE_34     = {6'd5, 6'd23},
BOARDER_TILE_35     = {6'd26, 6'd23},
BOARDER_TILE_36     = {6'd5, 6'd24},
BOARDER_TILE_37     = {6'd26, 6'd24},
BOARDER_TILE_38     = {6'd5, 6'd25},
BOARDER_TILE_39     = {6'd26, 6'd25},
BOARDER_TILE_40     = {6'd6, 6'd26},
BOARDER_TILE_41     = {6'd7, 6'd26},
BOARDER_TILE_42     = {6'd8, 6'd26},
BOARDER_TILE_43     = {6'd9, 6'd26},
BOARDER_TILE_44     = {6'd10, 6'd26},
BOARDER_TILE_45     = {6'd11, 6'd26},
BOARDER_TILE_46     = {6'd12, 6'd26},
BOARDER_TILE_47     = {6'd13, 6'd26},
BOARDER_TILE_48     = {6'd14, 6'd26},
BOARDER_TILE_49     = {6'd15, 6'd26},
BOARDER_TILE_50     = {6'd19, 6'd6},
BOARDER_TILE_51     = {6'd20, 6'd6},
BOARDER_TILE_52     = {6'd21, 6'd6},
BOARDER_TILE_53     = {6'd22, 6'd6},
BOARDER_TILE_54     = {6'd23, 6'd6},
BOARDER_TILE_55     = {6'd24, 6'd6},
BOARDER_TILE_56     = {6'd25, 6'd6},
BOARDER_TILE_57     = {6'd19, 6'd7},
BOARDER_TILE_58     = {6'd25, 6'd7},
BOARDER_TILE_59     = {6'd19, 6'd8},
BOARDER_TILE_60     = {6'd25, 6'd8},
BOARDER_TILE_61     = {6'd19, 6'd9},
BOARDER_TILE_62     = {6'd25, 6'd9},
BOARDER_TILE_63     = {6'd19, 6'd10},
BOARDER_TILE_64     = {6'd25, 6'd10},
BOARDER_TILE_65     = {6'd19, 6'd11},
BOARDER_TILE_66     = {6'd25, 6'd11},
BOARDER_TILE_67     = {6'd19, 6'd12},
BOARDER_TILE_68     = {6'd20, 6'd12},
BOARDER_TILE_69     = {6'd21, 6'd12},
BOARDER_TILE_70     = {6'd22, 6'd12},
BOARDER_TILE_71     = {6'd23, 6'd12},
BOARDER_TILE_72     = {6'd24, 6'd12},
BOARDER_TILE_73     = {6'd25, 6'd12};
*/

wire    [0:10]      offset_x    = hcnt - XOFFSET;       // Reset to start of display area
wire    [0:9]       offset_y    = vcnt - YOFFSET;       // Reset to start of display area
wire    [0:5]       tile_x_n    = offset_x[0:5];
wire    [0:5]       tile_y_n    = offset_y[0:5];
wire    [0:3]       line        = offset_y[6:9];        // Which line of the tile to display

reg     [0:5]       tile_x, tile_y;
reg     [0:7]       glyph, glyph_n;
reg     [0:2]       color, color_n;
reg     [0:47]      pixels_n;
reg     [0:10*8-1]  tile_row, tile_row_n;

always @( posedge clk ) begin
    if ( rst ) begin
        tile_x      <= 6'd0;
        tile_y      <= 6'd0;
        tile_row    <= 79'd0;
        glyph       <= 8'd0;
        color       <= 3'd0;
        pixels      <= 48'd0;
    end
    else begin
        tile_x      <= tile_x_n;
        tile_y      <= tile_y_n;
        tile_row    <= tile_row_n;
        glyph       <= glyph_n;
        color       <= color_n;
        pixels      <= pixels_n;
    end
end

always @* begin
    case (tile_y)
        6'd6:       tile_row_n = tiles[0    +: 80];
        6'd7:       tile_row_n = tiles[80   +: 80];
        6'd8:       tile_row_n = tiles[160  +: 80];
        6'd9:       tile_row_n = tiles[240  +: 80];
        6'd10:      tile_row_n = tiles[320  +: 80];
        6'd11:      tile_row_n = tiles[400  +: 80];
        6'd12:      tile_row_n = tiles[480  +: 80];
        6'd13:      tile_row_n = tiles[560  +: 80];
        6'd14:      tile_row_n = tiles[640  +: 80];
        6'd15:      tile_row_n = tiles[720  +: 80];
        6'd16:      tile_row_n = tiles[800  +: 80];
        6'd17:      tile_row_n = tiles[880  +: 80];
        6'd18:      tile_row_n = tiles[960  +: 80];
        6'd19:      tile_row_n = tiles[1040 +: 80];
        6'd20:      tile_row_n = tiles[1120 +: 80];
        6'd21:      tile_row_n = tiles[1200 +: 80];
        6'd22:      tile_row_n = tiles[1280 +: 80];
        6'd23:      tile_row_n = tiles[1360 +: 80];
        6'd24:      tile_row_n = tiles[1440 +: 80];
        6'd25:      tile_row_n = tiles[1520 +: 80];
        default:    tile_row_n = 80'd0;
    endcase

    case (tile_x)
        6'd14:   glyph_n = tile_row_n[7  -: 8];
        6'd15:   glyph_n = tile_row_n[15 -: 8];
        6'd16:   glyph_n = tile_row_n[23 -: 8];
        6'd17:   glyph_n = tile_row_n[31 -: 8];
        6'd18:   glyph_n = tile_row_n[39 -: 8];
        6'd19:   glyph_n = tile_row_n[47 -: 8];
        6'd20:   glyph_n = tile_row_n[55 -: 8];
        6'd21:   glyph_n = tile_row_n[63 -: 8];
        6'd22:   glyph_n = tile_row_n[71 -: 8];
        6'd23:   glyph_n = tile_row_n[79 -: 8];
        default: glyph_n = 3'd0;
    endcase

    color_n = glyph;

    if (tile_x >= 6'd14 && tile_x <= 6'd23) begin
        pixels_n = (line == 4'hF) ? 48'd0 : { 3'd0, { 15{ color } } };
    end
    else begin
        pixels_n = 48'd0;
    end
/*
    if (tile_x == 6'd0 && tile_y == 6'd0) begin
        tile_n = 11'd0;
    end
	 else if (tile_x >= 40 || tile_y >= 30) begin
        tile_n = tile;
    else if 
	 end
*/
/*
    // Draw game board
    if (tile_y > 5 && tile_y < 26) begin
        if (tile_x > 5 && tile_x < 16) begin
            pixels_n = {3'd0, {15{tiles[(tile_x-6) +: 3]}}};
        end
    end
*/
/*    case ({tile_x,tile_y})
    GAME_TILE_0	 : pixels_n = {3'd0, {15{tiles[0 +: 3]}}};
    GAME_TILE_1	 : pixels_n = {3'd0, {15{tiles[8 +: 3]}}};
    GAME_TILE_2	 : pixels_n = {3'd0, {15{tiles[16 +: 3]}}};
    GAME_TILE_3	 : pixels_n = {3'd0, {15{tiles[24 +: 3]}}};
    GAME_TILE_4	 : pixels_n = {3'd0, {15{tiles[32 +: 3]}}};
    GAME_TILE_5	 : pixels_n = {3'd0, {15{tiles[40 +: 3]}}};
    GAME_TILE_6	 : pixels_n = {3'd0, {15{tiles[48 +: 3]}}};
    GAME_TILE_7	 : pixels_n = {3'd0, {15{tiles[56 +: 3]}}};
    GAME_TILE_8	 : pixels_n = {3'd0, {15{tiles[64 +: 3]}}};
    GAME_TILE_9	 : pixels_n = {3'd0, {15{tiles[72 +: 3]}}};
    GAME_TILE_10 : pixels_n = {3'd0, {15{tiles[80 +: 3]}}};
    GAME_TILE_11 : pixels_n = {3'd0, {15{tiles[88 +: 3]}}};
    GAME_TILE_12 : pixels_n = {3'd0, {15{tiles[96 +: 3]}}};
    GAME_TILE_13 : pixels_n = {3'd0, {15{tiles[104 +: 3]}}};
    GAME_TILE_14 : pixels_n = {3'd0, {15{tiles[112 +: 3]}}};
    GAME_TILE_15 : pixels_n = {3'd0, {15{tiles[120 +: 3]}}};
    GAME_TILE_16 : pixels_n = {3'd0, {15{tiles[128 +: 3]}}};
    GAME_TILE_17 : pixels_n = {3'd0, {15{tiles[136 +: 3]}}};
    GAME_TILE_18 : pixels_n = {3'd0, {15{tiles[144 +: 3]}}};
    GAME_TILE_19 : pixels_n = {3'd0, {15{tiles[152 +: 3]}}};
    GAME_TILE_20 : pixels_n = {3'd0, {15{tiles[160 +: 3]}}};
    GAME_TILE_21 : pixels_n = {3'd0, {15{tiles[168 +: 3]}}};
    GAME_TILE_22 : pixels_n = {3'd0, {15{tiles[176 +: 3]}}};
    GAME_TILE_23 : pixels_n = {3'd0, {15{tiles[184 +: 3]}}};
    GAME_TILE_24 : pixels_n = {3'd0, {15{tiles[192 +: 3]}}};
    GAME_TILE_25 : pixels_n = {3'd0, {15{tiles[200 +: 3]}}};
    GAME_TILE_26 : pixels_n = {3'd0, {15{tiles[208 +: 3]}}};
    GAME_TILE_27 : pixels_n = {3'd0, {15{tiles[216 +: 3]}}};
    GAME_TILE_28 : pixels_n = {3'd0, {15{tiles[224 +: 3]}}};
    GAME_TILE_29 : pixels_n = {3'd0, {15{tiles[232 +: 3]}}};
    GAME_TILE_30 : pixels_n = {3'd0, {15{tiles[240 +: 3]}}};
    GAME_TILE_31 : pixels_n = {3'd0, {15{tiles[248 +: 3]}}};
    GAME_TILE_32 : pixels_n = {3'd0, {15{tiles[256 +: 3]}}};
    GAME_TILE_33 : pixels_n = {3'd0, {15{tiles[264 +: 3]}}};
    GAME_TILE_34 : pixels_n = {3'd0, {15{tiles[272 +: 3]}}};
    GAME_TILE_35 : pixels_n = {3'd0, {15{tiles[280 +: 3]}}};
    GAME_TILE_36 : pixels_n = {3'd0, {15{tiles[288 +: 3]}}};
    GAME_TILE_37 : pixels_n = {3'd0, {15{tiles[296 +: 3]}}};
    GAME_TILE_38 : pixels_n = {3'd0, {15{tiles[304 +: 3]}}};
    GAME_TILE_39 : pixels_n = {3'd0, {15{tiles[312 +: 3]}}};
    GAME_TILE_40 : pixels_n = {3'd0, {15{tiles[320 +: 3]}}};
    GAME_TILE_41 : pixels_n = {3'd0, {15{tiles[328 +: 3]}}};
    GAME_TILE_42 : pixels_n = {3'd0, {15{tiles[336 +: 3]}}};
    GAME_TILE_43 : pixels_n = {3'd0, {15{tiles[344 +: 3]}}};
    GAME_TILE_44 : pixels_n = {3'd0, {15{tiles[352 +: 3]}}};
    GAME_TILE_45 : pixels_n = {3'd0, {15{tiles[360 +: 3]}}};
    GAME_TILE_46 : pixels_n = {3'd0, {15{tiles[368 +: 3]}}};
    GAME_TILE_47 : pixels_n = {3'd0, {15{tiles[376 +: 3]}}};
    GAME_TILE_48 : pixels_n = {3'd0, {15{tiles[384 +: 3]}}};
    GAME_TILE_49 : pixels_n = {3'd0, {15{tiles[392 +: 3]}}};
    GAME_TILE_50 : pixels_n = {3'd0, {15{tiles[400 +: 3]}}};
    GAME_TILE_51 : pixels_n = {3'd0, {15{tiles[408 +: 3]}}};
    GAME_TILE_52 : pixels_n = {3'd0, {15{tiles[416 +: 3]}}};
    GAME_TILE_53 : pixels_n = {3'd0, {15{tiles[424 +: 3]}}};
    GAME_TILE_54 : pixels_n = {3'd0, {15{tiles[432 +: 3]}}};
    GAME_TILE_55 : pixels_n = {3'd0, {15{tiles[440 +: 3]}}};
    GAME_TILE_56 : pixels_n = {3'd0, {15{tiles[448 +: 3]}}};
    GAME_TILE_57 : pixels_n = {3'd0, {15{tiles[456 +: 3]}}};
    GAME_TILE_58 : pixels_n = {3'd0, {15{tiles[464 +: 3]}}};
    GAME_TILE_59 : pixels_n = {3'd0, {15{tiles[472 +: 3]}}};
    GAME_TILE_60 : pixels_n = {3'd0, {15{tiles[480 +: 3]}}};
    GAME_TILE_61 : pixels_n = {3'd0, {15{tiles[488 +: 3]}}};
    GAME_TILE_62 : pixels_n = {3'd0, {15{tiles[496 +: 3]}}};
    GAME_TILE_63 : pixels_n = {3'd0, {15{tiles[504 +: 3]}}};
    GAME_TILE_64 : pixels_n = {3'd0, {15{tiles[512 +: 3]}}};
    GAME_TILE_65 : pixels_n = {3'd0, {15{tiles[520 +: 3]}}};
    GAME_TILE_66 : pixels_n = {3'd0, {15{tiles[528 +: 3]}}};
    GAME_TILE_67 : pixels_n = {3'd0, {15{tiles[536 +: 3]}}};
    GAME_TILE_68 : pixels_n = {3'd0, {15{tiles[544 +: 3]}}};
    GAME_TILE_69 : pixels_n = {3'd0, {15{tiles[552 +: 3]}}};
    GAME_TILE_70 : pixels_n = {3'd0, {15{tiles[560 +: 3]}}};
    GAME_TILE_71 : pixels_n = {3'd0, {15{tiles[568 +: 3]}}};
    GAME_TILE_72 : pixels_n = {3'd0, {15{tiles[576 +: 3]}}};
    GAME_TILE_73 : pixels_n = {3'd0, {15{tiles[584 +: 3]}}};
    GAME_TILE_74 : pixels_n = {3'd0, {15{tiles[592 +: 3]}}};
    GAME_TILE_75 : pixels_n = {3'd0, {15{tiles[600 +: 3]}}};
    GAME_TILE_76 : pixels_n = {3'd0, {15{tiles[608 +: 3]}}};
    GAME_TILE_77 : pixels_n = {3'd0, {15{tiles[616 +: 3]}}};
    GAME_TILE_78 : pixels_n = {3'd0, {15{tiles[624 +: 3]}}};
    GAME_TILE_79 : pixels_n = {3'd0, {15{tiles[632 +: 3]}}};
    GAME_TILE_80 : pixels_n = {3'd0, {15{tiles[640 +: 3]}}};
    GAME_TILE_81 : pixels_n = {3'd0, {15{tiles[648 +: 3]}}};
    GAME_TILE_82 : pixels_n = {3'd0, {15{tiles[656 +: 3]}}};
    GAME_TILE_83 : pixels_n = {3'd0, {15{tiles[664 +: 3]}}};
    GAME_TILE_84 : pixels_n = {3'd0, {15{tiles[672 +: 3]}}};
    GAME_TILE_85 : pixels_n = {3'd0, {15{tiles[680 +: 3]}}};
    GAME_TILE_86 : pixels_n = {3'd0, {15{tiles[688 +: 3]}}};
    GAME_TILE_87 : pixels_n = {3'd0, {15{tiles[696 +: 3]}}};
    GAME_TILE_88 : pixels_n = {3'd0, {15{tiles[704 +: 3]}}};
    GAME_TILE_89 : pixels_n = {3'd0, {15{tiles[712 +: 3]}}};
    GAME_TILE_90 : pixels_n = {3'd0, {15{tiles[720 +: 3]}}};
    GAME_TILE_91 : pixels_n = {3'd0, {15{tiles[728 +: 3]}}};
    GAME_TILE_92 : pixels_n = {3'd0, {15{tiles[736 +: 3]}}};
    GAME_TILE_93 : pixels_n = {3'd0, {15{tiles[744 +: 3]}}};
    GAME_TILE_94 : pixels_n = {3'd0, {15{tiles[752 +: 3]}}};
    GAME_TILE_95 : pixels_n = {3'd0, {15{tiles[760 +: 3]}}};
    GAME_TILE_96 : pixels_n = {3'd0, {15{tiles[768 +: 3]}}};
    GAME_TILE_97 : pixels_n = {3'd0, {15{tiles[776 +: 3]}}};
    GAME_TILE_98 : pixels_n = {3'd0, {15{tiles[784 +: 3]}}};
    GAME_TILE_99 : pixels_n = {3'd0, {15{tiles[792 +: 3]}}};
    GAME_TILE_100: pixels_n = {3'd0, {15{tiles[800 +: 3]}}};
    GAME_TILE_101: pixels_n = {3'd0, {15{tiles[808 +: 3]}}};
    GAME_TILE_102: pixels_n = {3'd0, {15{tiles[816 +: 3]}}};
    GAME_TILE_103: pixels_n = {3'd0, {15{tiles[824 +: 3]}}};
    GAME_TILE_104: pixels_n = {3'd0, {15{tiles[832 +: 3]}}};
    GAME_TILE_105: pixels_n = {3'd0, {15{tiles[840 +: 3]}}};
    GAME_TILE_106: pixels_n = {3'd0, {15{tiles[848 +: 3]}}};
    GAME_TILE_107: pixels_n = {3'd0, {15{tiles[856 +: 3]}}};
    GAME_TILE_108: pixels_n = {3'd0, {15{tiles[864 +: 3]}}};
    GAME_TILE_109: pixels_n = {3'd0, {15{tiles[872 +: 3]}}};
    GAME_TILE_110: pixels_n = {3'd0, {15{tiles[880 +: 3]}}};
    GAME_TILE_111: pixels_n = {3'd0, {15{tiles[888 +: 3]}}};
    GAME_TILE_112: pixels_n = {3'd0, {15{tiles[896 +: 3]}}};
    GAME_TILE_113: pixels_n = {3'd0, {15{tiles[904 +: 3]}}};
    GAME_TILE_114: pixels_n = {3'd0, {15{tiles[912 +: 3]}}};
    GAME_TILE_115: pixels_n = {3'd0, {15{tiles[920 +: 3]}}};
    GAME_TILE_116: pixels_n = {3'd0, {15{tiles[928 +: 3]}}};
    GAME_TILE_117: pixels_n = {3'd0, {15{tiles[936 +: 3]}}};
    GAME_TILE_118: pixels_n = {3'd0, {15{tiles[944 +: 3]}}};
    GAME_TILE_119: pixels_n = {3'd0, {15{tiles[952 +: 3]}}};
    GAME_TILE_120: pixels_n = {3'd0, {15{tiles[960 +: 3]}}};
    GAME_TILE_121: pixels_n = {3'd0, {15{tiles[968 +: 3]}}};
    GAME_TILE_122: pixels_n = {3'd0, {15{tiles[976 +: 3]}}};
    GAME_TILE_123: pixels_n = {3'd0, {15{tiles[984 +: 3]}}};
    GAME_TILE_124: pixels_n = {3'd0, {15{tiles[992 +: 3]}}};
    GAME_TILE_125: pixels_n = {3'd0, {15{tiles[1000 +: 3]}}};
    GAME_TILE_126: pixels_n = {3'd0, {15{tiles[1008 +: 3]}}};
    GAME_TILE_127: pixels_n = {3'd0, {15{tiles[1016 +: 3]}}};
    GAME_TILE_128: pixels_n = {3'd0, {15{tiles[1024 +: 3]}}};
    GAME_TILE_129: pixels_n = {3'd0, {15{tiles[1032 +: 3]}}};
    GAME_TILE_130: pixels_n = {3'd0, {15{tiles[1040 +: 3]}}};
    GAME_TILE_131: pixels_n = {3'd0, {15{tiles[1048 +: 3]}}};
    GAME_TILE_132: pixels_n = {3'd0, {15{tiles[1056 +: 3]}}};
    GAME_TILE_133: pixels_n = {3'd0, {15{tiles[1064 +: 3]}}};
    GAME_TILE_134: pixels_n = {3'd0, {15{tiles[1072 +: 3]}}};
    GAME_TILE_135: pixels_n = {3'd0, {15{tiles[1080 +: 3]}}};
    GAME_TILE_136: pixels_n = {3'd0, {15{tiles[1088 +: 3]}}};
    GAME_TILE_137: pixels_n = {3'd0, {15{tiles[1096 +: 3]}}};
    GAME_TILE_138: pixels_n = {3'd0, {15{tiles[1104 +: 3]}}};
    GAME_TILE_139: pixels_n = {3'd0, {15{tiles[1112 +: 3]}}};
    GAME_TILE_140: pixels_n = {3'd0, {15{tiles[1120 +: 3]}}};
    GAME_TILE_141: pixels_n = {3'd0, {15{tiles[1128 +: 3]}}};
    GAME_TILE_142: pixels_n = {3'd0, {15{tiles[1136 +: 3]}}};
    GAME_TILE_143: pixels_n = {3'd0, {15{tiles[1144 +: 3]}}};
    GAME_TILE_144: pixels_n = {3'd0, {15{tiles[1152 +: 3]}}};
    GAME_TILE_145: pixels_n = {3'd0, {15{tiles[1160 +: 3]}}};
    GAME_TILE_146: pixels_n = {3'd0, {15{tiles[1168 +: 3]}}};
    GAME_TILE_147: pixels_n = {3'd0, {15{tiles[1176 +: 3]}}};
    GAME_TILE_148: pixels_n = {3'd0, {15{tiles[1184 +: 3]}}};
    GAME_TILE_149: pixels_n = {3'd0, {15{tiles[1192 +: 3]}}};
    GAME_TILE_150: pixels_n = {3'd0, {15{tiles[1200 +: 3]}}};
    GAME_TILE_151: pixels_n = {3'd0, {15{tiles[1208 +: 3]}}};
    GAME_TILE_152: pixels_n = {3'd0, {15{tiles[1216 +: 3]}}};
    GAME_TILE_153: pixels_n = {3'd0, {15{tiles[1224 +: 3]}}};
    GAME_TILE_154: pixels_n = {3'd0, {15{tiles[1232 +: 3]}}};
    GAME_TILE_155: pixels_n = {3'd0, {15{tiles[1240 +: 3]}}};
    GAME_TILE_156: pixels_n = {3'd0, {15{tiles[1248 +: 3]}}};
    GAME_TILE_157: pixels_n = {3'd0, {15{tiles[1256 +: 3]}}};
    GAME_TILE_158: pixels_n = {3'd0, {15{tiles[1264 +: 3]}}};
    GAME_TILE_159: pixels_n = {3'd0, {15{tiles[1272 +: 3]}}};
    GAME_TILE_160: pixels_n = {3'd0, {15{tiles[1280 +: 3]}}};
    GAME_TILE_161: pixels_n = {3'd0, {15{tiles[1288 +: 3]}}};
    GAME_TILE_162: pixels_n = {3'd0, {15{tiles[1296 +: 3]}}};
    GAME_TILE_163: pixels_n = {3'd0, {15{tiles[1304 +: 3]}}};
    GAME_TILE_164: pixels_n = {3'd0, {15{tiles[1312 +: 3]}}};
    GAME_TILE_165: pixels_n = {3'd0, {15{tiles[1320 +: 3]}}};
    GAME_TILE_166: pixels_n = {3'd0, {15{tiles[1328 +: 3]}}};
    GAME_TILE_167: pixels_n = {3'd0, {15{tiles[1336 +: 3]}}};
    GAME_TILE_168: pixels_n = {3'd0, {15{tiles[1344 +: 3]}}};
    GAME_TILE_169: pixels_n = {3'd0, {15{tiles[1352 +: 3]}}};
    GAME_TILE_170: pixels_n = {3'd0, {15{tiles[1360 +: 3]}}};
    GAME_TILE_171: pixels_n = {3'd0, {15{tiles[1368 +: 3]}}};
    GAME_TILE_172: pixels_n = {3'd0, {15{tiles[1376 +: 3]}}};
    GAME_TILE_173: pixels_n = {3'd0, {15{tiles[1384 +: 3]}}};
    GAME_TILE_174: pixels_n = {3'd0, {15{tiles[1392 +: 3]}}};
    GAME_TILE_175: pixels_n = {3'd0, {15{tiles[1400 +: 3]}}};
    GAME_TILE_176: pixels_n = {3'd0, {15{tiles[1408 +: 3]}}};
    GAME_TILE_177: pixels_n = {3'd0, {15{tiles[1416 +: 3]}}};
    GAME_TILE_178: pixels_n = {3'd0, {15{tiles[1424 +: 3]}}};
    GAME_TILE_179: pixels_n = {3'd0, {15{tiles[1432 +: 3]}}};
    GAME_TILE_180: pixels_n = {3'd0, {15{tiles[1440 +: 3]}}};
    GAME_TILE_181: pixels_n = {3'd0, {15{tiles[1448 +: 3]}}};
    GAME_TILE_182: pixels_n = {3'd0, {15{tiles[1456 +: 3]}}};
    GAME_TILE_183: pixels_n = {3'd0, {15{tiles[1464 +: 3]}}};
    GAME_TILE_184: pixels_n = {3'd0, {15{tiles[1472 +: 3]}}};
    GAME_TILE_185: pixels_n = {3'd0, {15{tiles[1480 +: 3]}}};
    GAME_TILE_186: pixels_n = {3'd0, {15{tiles[1488 +: 3]}}};
    GAME_TILE_187: pixels_n = {3'd0, {15{tiles[1496 +: 3]}}};
    GAME_TILE_188: pixels_n = {3'd0, {15{tiles[1504 +: 3]}}};
    GAME_TILE_189: pixels_n = {3'd0, {15{tiles[1512 +: 3]}}};
    GAME_TILE_190: pixels_n = {3'd0, {15{tiles[1520 +: 3]}}};
    GAME_TILE_191: pixels_n = {3'd0, {15{tiles[1528 +: 3]}}};
    GAME_TILE_192: pixels_n = {3'd0, {15{tiles[1536 +: 3]}}};
    GAME_TILE_193: pixels_n = {3'd0, {15{tiles[1544 +: 3]}}};
    GAME_TILE_194: pixels_n = {3'd0, {15{tiles[1552 +: 3]}}};
    GAME_TILE_195: pixels_n = {3'd0, {15{tiles[1560 +: 3]}}};
    GAME_TILE_196: pixels_n = {3'd0, {15{tiles[1568 +: 3]}}};
    GAME_TILE_197: pixels_n = {3'd0, {15{tiles[1576 +: 3]}}};
    GAME_TILE_198: pixels_n = {3'd0, {15{tiles[1584 +: 3]}}};
    GAME_TILE_199: pixels_n = {3'd0, {15{tiles[1592 +: 3]}}};

    NEXT_TILE_0  : pixels_n = {3'd0, {15{next_tile[0 +: 3]}}};
    NEXT_TILE_1  : pixels_n = {3'd0, {15{next_tile[8 +: 3]}}};
    NEXT_TILE_2  : pixels_n = {3'd0, {15{next_tile[16 +: 3]}}};
    NEXT_TILE_3  : pixels_n = {3'd0, {15{next_tile[24 +: 3]}}};
    NEXT_TILE_4  : pixels_n = {3'd0, {15{next_tile[32 +: 3]}}};
    NEXT_TILE_5  : pixels_n = {3'd0, {15{next_tile[40 +: 3]}}};
    NEXT_TILE_6  : pixels_n = {3'd0, {15{next_tile[48 +: 3]}}};
    NEXT_TILE_7  : pixels_n = {3'd0, {15{next_tile[56 +: 3]}}};
    NEXT_TILE_8  : pixels_n = {3'd0, {15{next_tile[64 +: 3]}}};
    NEXT_TILE_9  : pixels_n = {3'd0, {15{next_tile[72 +: 3]}}};
    NEXT_TILE_10 : pixels_n = {3'd0, {15{next_tile[80 +: 3]}}};
    NEXT_TILE_11 : pixels_n = {3'd0, {15{next_tile[88 +: 3]}}};
    NEXT_TILE_12 : pixels_n = {3'd0, {15{next_tile[96 +: 3]}}};
    NEXT_TILE_13 : pixels_n = {3'd0, {15{next_tile[104 +: 3]}}};
    NEXT_TILE_14 : pixels_n = {3'd0, {15{next_tile[112 +: 3]}}};
    NEXT_TILE_15 : pixels_n = {3'd0, {15{next_tile[120 +: 3]}}};

    BOARDER_TILE_0 : pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_1 : pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_2 : pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_3 : pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_4 : pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_5 : pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_6 : pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_7 : pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_8 : pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_9 : pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_10: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_11: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_12: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_13: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_14: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_15: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_16: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_17: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_18: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_19: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_20: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_21: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_22: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_23: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_24: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_25: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_26: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_27: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_28: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_29: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_30: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_31: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_32: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_33: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_34: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_35: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_36: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_37: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_38: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_39: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_40: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_41: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_42: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_43: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_44: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_45: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_46: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_47: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_48: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_49: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_50: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_51: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_52: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_53: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_54: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_55: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_56: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_57: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_58: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_59: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_60: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_61: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_62: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_63: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_64: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_65: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_66: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_67: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_68: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_69: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_70: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_71: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_72: pixels_n = 48'h1FFF_FFFF_FFFF;
    BOARDER_TILE_73: pixels_n = 48'h1FFF_FFFF_FFFF;
    default:       pixels_n = 16'd0;
    endcase
*/
end

endmodule

