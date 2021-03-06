
module vga (
    input   wire        clk,        // 50MHz
    input   wire        rst,
    input   wire [47:0] pixels,
    // Counters are 1 bit larger than they need to be to downscale from 50MHz to
    // 25MHz
    output  reg  [10:0] cnt_X,
    output  reg  [9:0]  cnt_Y,
    output  reg         vga_HS,
    output  reg         vga_VS,
    output  reg         vga_R,
    output  reg         vga_G,
    output  reg         vga_B
);

// In clocks (2*pixel clocks)
localparam VGA_TSYNC_H  = 1600;
localparam VGA_TDISP_H  = 1568;
localparam VGA_TPULSE_H	= 192;
localparam VGA_TFP_H	= 224;

// In lines
localparam VGA_TSYNC_V  = 521;
localparam VGA_TDISP_V  = 492;
localparam VGA_TPULSE_V	= 2;
localparam VGA_TFP_V	= 12;

reg  [47:0] buffer;

reg  [10:0] cnt_X_n;
reg  [9:0]  cnt_Y_n;
reg  [47:0] buffer_n;
reg         vga_HS_n;
reg         vga_VS_n;
reg         vga_R_n;
reg         vga_G_n;
reg         vga_B_n;

// Registers
always @( posedge clk ) begin
    if (rst) begin
        cnt_X       <= 0;
        cnt_Y       <= 0;
        buffer      <= 0;
        vga_HS      <= 1'b0;
        vga_VS      <= 1'b0;
        vga_R       <= 1'b0;
        vga_G       <= 1'b0;
        vga_B       <= 1'b0;
    end
    else begin
        cnt_X       <= cnt_X_n;
        cnt_Y       <= cnt_Y_n;
        buffer      <= buffer_n;
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
    cnt_X_n     = cnt_X;
    cnt_Y_n     = cnt_Y;

    // Sync pulses
    vga_HS_n = ( cnt_X < VGA_TPULSE_H ) ? 1'b0 : 1'b1;   // High while active, low pulse
    vga_VS_n = ( cnt_Y < VGA_TPULSE_H ) ? 1'b0 : 1'b1;   // High while active, low pulse

    // inc counters, wrap at the end (*2 because of 50MHz clock)
    if ( cnt_X < VGA_TSYNC_H ) begin
        cnt_X_n = cnt_X + 10'd1;
    end
    else begin
        cnt_X_n = 10'd0;
        // Increment at end of line
        cnt_Y_n = ( cnt_Y < VGA_TSYNC_V ) ? cnt_Y + 10'd1 : 10'd0;
    end

    // Display active between Tfp and Tdisp
    if ( cnt_X >= VGA_TFP_H && cnt_X < VGA_TDISP_H && 
         cnt_Y >= VGA_TFP_V && cnt_Y < VGA_TDISP_V ) begin
        vga_R_n = buffer[2];
        vga_G_n = buffer[1];
        vga_B_n = buffer[0];
    end
    else begin
        // Go blank in no display areas
        vga_R_n = 1'b0;
        vga_G_n = 1'b0;
        vga_B_n = 1'b0;
    end

    // Update buffer with next 16 pixels the cycle before they are needed
    // -- Do this even if not in the display area because the buffer will not
    // -- be used and we will not drop the first 16 pixels in a line due to
    // -- checking only in the display area
    if ( cnt_X[4:0] == 5'h1F ) begin
        buffer_n = pixels;
    end
    else if ( cnt_X >= VGA_TFP_H && cnt_X < VGA_TDISP_H && 
              cnt_Y >= VGA_TFP_V && cnt_Y < VGA_TDISP_V &&
				  cnt_X[0] == 1'b1) begin
        buffer_n = buffer >> 3; // shift out displayed pixels
    end
    else begin
        buffer_n = buffer;  // No update
    end
end


endmodule
