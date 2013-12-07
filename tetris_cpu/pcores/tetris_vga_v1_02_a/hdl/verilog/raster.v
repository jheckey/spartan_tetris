
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
        next_tet    <= 1'b0;
        gb_tile     <= 1'b0;
        glyph       <= 8'd0;
        color       <= 3'd0;
        pixels      <= 48'd0;
    end
    else begin
        tile_x      <= tile_x_n;
        tile_y      <= tile_y_n;
        tile_row    <= tile_row_n;
        next_tet    <= next_tet_n;
        gb_tile     <= gb_tile_n;
        glyph       <= glyph_n;
        color       <= color_n;
        pixels      <= pixels_n;
    end
end

always @* begin
    case (tile_y)
        // Next vertical tiles
        6'd2:       begin tile_row_n = {24'd0, next_tiles[0   +: 32], 24'd0}; next_tet_n = 1; gb_tile_n = 1; end
        6'd3:       begin tile_row_n = {24'd0, next_tiles[32  +: 32], 24'd0}; next_tet_n = 1; gb_tile_n = 1; end
        6'd4:       begin tile_row_n = {24'd0, next_tiles[64  +: 32], 24'd0}; next_tet_n = 1; gb_tile_n = 1; end
        6'd5:       begin tile_row_n = {24'd0, next_tiles[96  +: 32], 24'd0}; next_tet_n = 1; gb_tile_n = 1; end
        // Game board vertical tiles
        6'd8:       begin tile_row_n = tiles[0    +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd9:       begin tile_row_n = tiles[80   +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd10:      begin tile_row_n = tiles[160  +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd11:      begin tile_row_n = tiles[240  +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd12:      begin tile_row_n = tiles[320  +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd13:      begin tile_row_n = tiles[400  +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd14:      begin tile_row_n = tiles[480  +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd15:      begin tile_row_n = tiles[560  +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd16:      begin tile_row_n = tiles[640  +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd17:      begin tile_row_n = tiles[720  +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd18:      begin tile_row_n = tiles[800  +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd19:      begin tile_row_n = tiles[880  +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd20:      begin tile_row_n = tiles[960  +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd21:      begin tile_row_n = tiles[1040 +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd22:      begin tile_row_n = tiles[1120 +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd23:      begin tile_row_n = tiles[1200 +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd24:      begin tile_row_n = tiles[1280 +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd25:      begin tile_row_n = tiles[1360 +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd26:      begin tile_row_n = tiles[1440 +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        6'd27:      begin tile_row_n = tiles[1520 +: 80]; next_tet_n = 0; gb_tile_n = 1; end
        default:    begin tile_row_n = 80'd0; next_tet_n = 0; gb_tile_n = 0; end
    endcase

    case (tile_x)
        // Gameboard horizontal glyphs
        6'd14:   begin glyph_n = tile_row_n[7  -: 8]; end
        6'd15:   begin glyph_n = tile_row_n[15 -: 8]; end
        6'd16:   begin glyph_n = tile_row_n[23 -: 8]; end
        6'd17:   begin glyph_n = tile_row_n[31 -: 8]; end
        6'd18:   begin glyph_n = tile_row_n[39 -: 8]; end
        6'd19:   begin glyph_n = tile_row_n[47 -: 8]; end
        6'd20:   begin glyph_n = tile_row_n[55 -: 8]; end
        6'd21:   begin glyph_n = tile_row_n[63 -: 8]; end
        6'd22:   begin glyph_n = tile_row_n[71 -: 8]; end
        6'd23:   begin glyph_n = tile_row_n[79 -: 8]; end
        default: begin glyph_n = 3'd0; end
    endcase

    color_n = glyph[5:7];

    // Draw gameboard

    // Usually draw black
    pixels_n = 48'd0;

    if (gb_tile && !next_tet && tile_x >= 6'd14 && tile_x <= 6'd23 && line != 4'hf) begin
        pixels_n = { 3'd0, { 15{ color } } };
    end

    // Draw next piece
    else if (gb_tile && next_tet && tile_x >= 6'd17 && tile_x <= 6'd20 && line != 4'hf) begin
        pixels_n = { 3'd0, { 15{ color } } };
    end

    // Draw vertical boarders
    else if (gb_tile && !next_tet && tile_x == 6'd13) begin
        pixels_n = {3'h0, 6'h3f, 39'h0};
    end
    else if (gb_tile && !next_tet && tile_x == 6'd24) begin
        pixels_n = {39'h0, 6'h3f, 3'h0};
    end
    else if (gb_tile && next_tet && tile_x == 6'd16) begin
        pixels_n = {3'h0, 6'h3f, 39'h0};
    end
    else if (gb_tile && next_tet && tile_x == 6'd21) begin
        pixels_n = {39'h0, 6'h3f, 3'h0};
    end

    // Draw horizontal boarders
    else if (!gb_tile && !next_tet && tile_x >= 6'd14 && tile_x <= 6'd23 && tile_y == 6'd28 &&
             (line == 4'd1 || line == 4'd2)) begin
        pixels_n = 48'hffff_ffff_ffff;
    end
    else if (!gb_tile && !next_tet && tile_x >= 6'd17 && tile_x <= 6'd20 &&
             (tile_y == 6'h6 && (line == 4'd1  || line == 4'd2))) begin
        pixels_n = 48'hffff_ffff_ffff;
    end
    else if (!gb_tile && !next_tet && tile_x >= 6'd17 && tile_x <= 6'd20 &&
             (tile_y == 6'd1 && (line == 4'd13 || line == 4'd14))) begin
        pixels_n = 48'hffff_ffff_ffff;
    end

    // Draw NEXT North-West corners
    else if (!gb_tile && !next_tet && tile_x == 6'd16 && tile_y == 6'd1 &&
             (line == 4'd13 || line == 4'd14)) begin
        pixels_n = {9'h1ff, 39'd0};
    end
    else if (!gb_tile && !next_tet && tile_x == 6'd16 && tile_y == 6'd1 &&
             line == 4'd15) begin
        pixels_n = {9'h03f, 39'd0};
    end

    // Draw NEXT North-East corners
    else if (!gb_tile && !next_tet && tile_x == 6'd21 && tile_y == 6'd1 &&
             (line == 4'd13 || line == 4'd14)) begin
        pixels_n = {39'd0, 9'h1ff};
    end
    else if (!gb_tile && !next_tet && tile_x == 6'd21 && tile_y == 6'd1 &&
             line == 4'd15) begin
        pixels_n = {39'd0, 9'h1f8};
    end

    // Draw South-West corners
    else if (!gb_tile && !next_tet &&
             ((tile_x == 6'd16 && tile_y == 6'd6) || (tile_x == 6'd13 && tile_y == 6'd28)) &&
             (line == 4'd1 || line == 4'd2)) begin
        pixels_n = {9'h1ff, 39'd0};
    end
    else if (!gb_tile && !next_tet &&
             ((tile_x == 6'd16 && tile_y == 6'd6) || (tile_x == 6'd13 && tile_y == 6'd28)) &&
             (line == 4'd0)) begin
        pixels_n = {9'h03f, 39'd0};
    end

    // Draw South-East corners
    else if (!gb_tile && !next_tet &&
             ((tile_x == 6'd21 && tile_y == 6'd6) || (tile_x == 6'd24 && tile_y == 6'd28)) &&
             (line == 4'd1 || line == 4'd2)) begin
        pixels_n = {39'd0, 9'h1ff};
    end
    else if (!gb_tile && !next_tet &&
             ((tile_x == 6'd21 && tile_y == 6'd6) || (tile_x == 6'd24 && tile_y == 6'd28)) &&
             line == 4'd0) begin
        pixels_n = {39'd0, 9'h1f8};
    end
end

endmodule

