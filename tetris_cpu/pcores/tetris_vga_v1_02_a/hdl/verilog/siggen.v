
module siggen (
    input   wire        clk,        // 50MHz
    input   wire        rst,
    input   wire [0:10] hcnt,
    input   wire [0:9]  vcnt,

    // Tile/glyph translation
    //output  reg  [0:7]  tile,
    //input   wire [0:7]  glyph,

    output  reg  [0:47] pixels
);

localparam XOFFSET = 221;		// 224 clks before visible pixels; 224/(16 pix/tile * 2 clks/pix) = 7; +1 to start before the tile needed
localparam YOFFSET = 12;	// 12 lines scanned above display area

// 640 / 16 = 40
// 480 / 16 = 30
wire    [0:10]  offset_x = hcnt - XOFFSET;		// Reset to start of display area
wire    [0:9]   offset_y = vcnt - YOFFSET;		// Reset to start of display area
wire    [0:5]   tile_x 	 = offset_x[0:5];
wire    [0:5]   tile_y 	 = offset_y[0:5];
reg     [0:47]  pixels_n;

always @( posedge clk ) begin
    if ( rst ) begin
        //tile    <= 8'd0;
        pixels  <= 48'd0;
    end
    else begin
        //tile    <= 8'd0;
        pixels  <= pixels_n;
    end
end

always @* begin
    /*
    if ( tile_x >= 7 && tile_x <= 16 && tile_y >= 6 && tile_y <= 25) begin
        pixels_n = {16{glyph[0:2]}};
    end
    else begin
    */
        pixels_n = {8{{tile_x[3:5],tile_y[3:5]}}};
        //pixels_n = {16{{tile_x[5],tile_x[4],tile_x[3]}}};
		  //pixels_n = {16{tile_x[3:5]}};
    /*
    end
    */
end

endmodule

