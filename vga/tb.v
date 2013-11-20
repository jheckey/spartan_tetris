
module tb (
    input   wire        clk,        // 50MHz
    input   wire        rst,
    output  wire        vga_HS,
    output  wire        vga_VS,
    output  wire        vga_R,
    output  wire        vga_G,
    output  wire        vga_B
);

wire [47:0] pixels;
wire [10:0] cnt_X;
wire [9:0]  cnt_Y;

vga vga1(
    .clk(clk),
    .rst(rst),
    .pixels(pixels),
    .cnt_X(cnt_X),
    .cnt_Y(cnt_Y),
    .vga_HS(vga_HS),
    .vga_VS(vga_VS),
    .vga_R(vga_R),
    .vga_G(vga_G),
    .vga_B(vga_B)
);

siggen siggen1(
    .clk(clk),
    .rst(rst),
    .cnt_X(cnt_X),
    .cnt_Y(cnt_Y),
    .pixels(pixels)
);

endmodule

