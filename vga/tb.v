//`define SIM

module tb (
`ifndef SIM
    input   wire        clk,
    input   wire        rst,
`endif
    output  wire        vga_HS,
    output  wire        vga_VS,
    output  wire        vga_R,
    output  wire        vga_G,
    output  wire        vga_B,
	output  wire [0:7]  leds
);

reg [0:31]  counter;

reg         enable;
reg         clear;
wire [0:47] pixels;
wire [0:10] hcnt;
wire [0:9]  vcnt;
wire [0:200*8-1] tiles = 1600'd0;
wire [0:16*8-1]  next_tile = 128'd0;

`ifdef SIM
reg        clk;        // 50MHz
reg        rst;
initial begin
	clk = 0;
	rst = 1;
	enable = 1;
	clear = 0;
	counter = 0;
	#10 rst = 0;
end
always #1 clk <= ~clk;
`endif // SIM

vga vga1(
    .clk(clk),
    .rst(rst),
    .enable(1'b1),
    .clear(1'b0),
    .pixels(pixels),
    .hcnt(hcnt),
    .vcnt(vcnt),
    .vga_HS(vga_HS),
    .vga_VS(vga_VS),
    .vga_R(vga_R),
    .vga_G(vga_G),
    .vga_B(vga_B)
);

/*
siggen siggen1(
    .clk(clk),
    .rst(rst),
    .hcnt(hcnt),
    .vcnt(vcnt),
    .pixels(pixels)
);
*/

raster render(
  .clk      (clk),
  .rst      (rst),
  .hcnt     (hcnt),
  .vcnt     (vcnt),
  .tiles    (tiles),
  .next_tile(next_tile),
  .pixels   (pixels)
);

assign leds = {enable, clear, counter[24:29]};

always @( posedge clk ) begin
    if ( rst ) begin
        counter <= 32'd0;
        enable  <= 1'b1;
        clear   <= 1'b0;
    end
    else if ( counter == 32'd250_000_000 ) begin
        counter <= 32'd0;
        //{enable,clear} <= {enable,clear} + 2'd1;
        //clear   <= ~clear;
    end
    else begin
        counter <= counter + 32'd1;
    end
end

endmodule

