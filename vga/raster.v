
module raster (
    input   wire                clk,
    input   wire                rst,
    input   wire [0:10]         hcnt,
    input   wire [0:9]          vcnt,

    // Tile/color translation
    input   wire [0:(8*200)-1]  tiles,
    input   wire [0:(16*8)-1]   next_tets,

    output  reg  [0:47]         pixels
);

localparam XOFFSET = 218;   // 224 clks before visible pixels; 224/(16 pix/tile * 2 clks/pix) = 7; +1 to start before the tile needed
localparam YOFFSET = 12;    // 12 lines scanned above display area

wire    [0:10]      offset_x    = hcnt - XOFFSET;       // Reset to start of display area
wire    [0:9]       offset_y    = vcnt - YOFFSET;       // Reset to start of display area
wire    [0:5]       tile_x_n    = offset_x[0:5];
wire    [0:5]       tile_y_n    = offset_y[0:5];
wire    [0:3]       line        = offset_y[6:9];        // Which line of the tile to display

reg     [0:5]       tile_x, tile_y;
reg     [0:7]       glyph, glyph_n;
reg     [0:2]       color, color_n;
reg                 next_tet, next_tet_n;
reg                 gb_tile, gb_tile_n;
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
        // Next vertical tiles
        6'd2:       begin tile_row_n = next_tets[0   +: 32]; next_tet_n = 1; end
        6'd3:       begin tile_row_n = next_tets[32  +: 32]; next_tet_n = 1; end
        6'd4:       begin tile_row_n = next_tets[64  +: 32]; next_tet_n = 1; end
        6'd5:       begin tile_row_n = next_tets[96  +: 32]; next_tet_n = 1; end
        // Game board vertical tiles
        6'd8:       begin tile_row_n = tiles[0    +: 80]; next_tet_n = 0; end
        6'd9:       begin tile_row_n = tiles[80   +: 80]; next_tet_n = 0; end
        6'd10:      begin tile_row_n = tiles[160  +: 80]; next_tet_n = 0; end
        6'd11:      begin tile_row_n = tiles[240  +: 80]; next_tet_n = 0; end
        6'd12:      begin tile_row_n = tiles[320  +: 80]; next_tet_n = 0; end
        6'd13:      begin tile_row_n = tiles[400  +: 80]; next_tet_n = 0; end
        6'd14:      begin tile_row_n = tiles[480  +: 80]; next_tet_n = 0; end
        6'd15:      begin tile_row_n = tiles[560  +: 80]; next_tet_n = 0; end
        6'd16:      begin tile_row_n = tiles[640  +: 80]; next_tet_n = 0; end
        6'd17:      begin tile_row_n = tiles[720  +: 80]; next_tet_n = 0; end
        6'd18:      begin tile_row_n = tiles[800  +: 80]; next_tet_n = 0; end
        6'd19:      begin tile_row_n = tiles[880  +: 80]; next_tet_n = 0; end
        6'd20:      begin tile_row_n = tiles[960  +: 80]; next_tet_n = 0; end
        6'd21:      begin tile_row_n = tiles[1040 +: 80]; next_tet_n = 0; end
        6'd22:      begin tile_row_n = tiles[1120 +: 80]; next_tet_n = 0; end
        6'd23:      begin tile_row_n = tiles[1200 +: 80]; next_tet_n = 0; end
        6'd24:      begin tile_row_n = tiles[1280 +: 80]; next_tet_n = 0; end
        6'd25:      begin tile_row_n = tiles[1360 +: 80]; next_tet_n = 0; end
        6'd26:      begin tile_row_n = tiles[1440 +: 80]; next_tet_n = 0; end
        6'd27:      begin tile_row_n = tiles[1520 +: 80]; next_tet_n = 0; end
        6'd28:      begin tile_row_n = (line == 4'd2 || line == 4'd3) ? {10{8'd3}} : 80'd0; next_tet_n = 0; end
        default:    begin tile_row_n = 80'd0; next_tet_n = 0; end
    endcase

    case (tile_x)
        // Gameboard horizontal glyphs
        6'd14:   begin glyph_n = tile_row_n[7  -: 8];
        6'd15:   begin glyph_n = tile_row_n[15 -: 8];
        6'd16:   begin glyph_n = tile_row_n[23 -: 8];
        6'd17:   begin glyph_n = tile_row_n[31 -: 8];
        6'd18:   begin glyph_n = tile_row_n[39 -: 8];
        6'd19:   begin glyph_n = tile_row_n[47 -: 8];
        6'd20:   begin glyph_n = tile_row_n[55 -: 8];
        6'd21:   begin glyph_n = tile_row_n[63 -: 8];
        6'd22:   begin glyph_n = tile_row_n[71 -: 8];
        6'd23:   begin glyph_n = tile_row_n[79 -: 8];
        default: begin glyph_n = 3'd0;
    endcase

    color_n = glyph;

    if (tile_x >= 6'd14 && tile_x <= 6'd23) begin
        pixels_n = (line == 4'hF) ? 48'd0 : { 3'd0, { 15{ color } } };
    end
    else begin
        pixels_n = 48'd0;
    end
end

endmodule

