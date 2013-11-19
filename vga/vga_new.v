// Counter max value in 50MHz clocks from 0
`define VGA_TSYNC_H     1600
`define VGA_TDISP_H     1504
`define VGA_TPULSE_H    192
`define VGA_TFP_H       224
//`define VGA_TBP_H       1408
// In lines
`define VGA_TSYNC_V     521
`define VGA_TDISP_V     492
`define VGA_TPULSE_V    2
`define VGA_TFP_V       12
//`define VGA_TBP_V       29

module vga (
    input   wire        clk,        // 50MHz
    input   wire        rst,
    //input   wire [23:0] pix,
    output  reg         vga_HS,
    output  reg         vga_VS,
    output  reg         vga_R,
    output  reg         vga_G,
    output  reg         vga_B
);

// Counters are 1 bit larger than they need to be to downscale from 50MHz to
// 25MHz
reg  [10:0] cnt_X;
reg  [9:0]  cnt_Y;

reg  [10:0] cnt_X_n;
reg  [9:0]  cnt_Y_n;
reg         vga_HS_n;
reg         vga_VS_n;
reg         vga_R_n;
reg         vga_G_n;
reg         vga_B_n;

// Registers
always @(posedge clk or posedge rst) begin
    if (rst) begin
        cnt_X       <= 0;
        cnt_Y       <= 0;
        vga_HS      <= 1'b0;
        vga_VS      <= 1'b0;
        vga_R       <= 1'b0;
        vga_G       <= 1'b0;
        vga_B       <= 1'b0;
    end
    else begin
        cnt_X       <= cnt_X_n;
        cnt_Y       <= cnt_Y_n;
        vga_HS      <= vga_HS_n;
        vga_VS      <= vga_VS_n;
        vga_R       <= vga_R_n;
        vga_G       <= vga_G_n;
        vga_B       <= vga_B_n;
    end
end

// Logic
// -- Counters lead the output by 1 cycle
always @* begin
    // No latches
    vga_R_n = 1'b0;
    vga_G_n = 1'b0;
    vga_B_n = 1'b0;
    cnt_X_n = 10'd0;
    cnt_Y_n = cnt_Y;

    // Sync pulses
    vga_HS_n = ( cnt_X < `VGA_TPULSE_H-1 ) ? 1'b0 : 1'b1;   // High while active, low pulse
    vga_VS_n = ( cnt_Y < `VGA_TPULSE_H-1 ) ? 1'b0 : 1'b1;   // High while active, low pulse

    // inc counters, wrap at the end (*2 because of 50MHz clock)
    if ( cnt_X < `VGA_TSYNC_H ) begin
        cnt_X_n = cnt_X + 10'd1;
    end
    else begin
        cnt_X_n = 10'd0;
        // Increment at end of line
        cnt_Y_n = ( cnt_Y < `VGA_TSYNC_V ) ? cnt_Y + 10'd1 : 10'd0;
    end

    // Display active between Tfp and Tdisp
    if ( cnt_X >= `VGA_TFP_H && cnt_X < `VGA_TDISP_H && 
         cnt_Y >= `VGA_TFP_V && cnt_Y < `VGA_TDISP_V ) begin
        // Demo output
        vga_R_n = cnt_X[5] ^ cnt_Y[5];
        vga_G_n = cnt_X[5] ^ cnt_Y[5];
        vga_B_n = cnt_X[5] ^ cnt_Y[5];
    end
end


endmodule
