
module vga (
    input   wire        clk,        // 50MHz
    input   wire        rst,
    input   wire        enable,
    input   wire        clear,
    input   wire [0:47] pixels,
    // Counters are 1 bit larger than they need to be to downscale from 50MHz to
    // 25MHz
    output  reg  [0:10] hcnt,
    output  reg  [0:9]  vcnt,
    output  reg         vga_HS,
    output  reg         vga_VS,
    output  reg         vga_R,
    output  reg         vga_G,
    output  reg         vga_B
);

// In clocks (2*pixel clocks)
localparam VGA_TSYNC_H  = 1600;
localparam VGA_TDISP_H  = 1568;
localparam VGA_TPULSE_H = 192;
localparam VGA_TFP_H    = 224;

// In lines
localparam VGA_TSYNC_V  = 521;
localparam VGA_TDISP_V  = 492;
localparam VGA_TPULSE_V = 2;
localparam VGA_TFP_V    = 12;

reg  [0:47] buffer;

reg  [0:10] __hcnt, hcnt_n;
reg  [0:9]  __vcnt, vcnt_n;
reg  [0:47] buffer_n;
reg         vga_HS_n;
reg         vga_VS_n;
reg         vga_R_n;
reg         vga_G_n;
reg         vga_B_n;

// Registers
always @( posedge clk ) begin
    if (rst) begin
        __hcnt      <= 11'd0;
        __vcnt      <= 10'd0;
        hcnt        <= 11'd0;
        vcnt        <= 10'd0;
        buffer      <= 48'd0;
        vga_HS      <= 1'b0;
        vga_VS      <= 1'b0;
        vga_R       <= 1'b0;
        vga_G       <= 1'b0;
        vga_B       <= 1'b0;
    end
    else if (!enable) begin
        __hcnt      <= 11'd0;
        __vcnt      <= 10'd0;
        hcnt        <= 11'd0;
        vcnt        <= 10'd0;
        buffer      <= 48'd0;
        vga_HS      <= 1'b1;
        vga_VS      <= 1'b1;
        vga_R       <= 1'b0;
        vga_G       <= 1'b0;
        vga_B       <= 1'b0;
    end
    else begin
        __hcnt      <= hcnt_n;
        __vcnt      <= vcnt_n;
        hcnt        <= hcnt_n;
        vcnt        <= vcnt_n;
        buffer      <= buffer_n;
        vga_HS      <= vga_HS_n;
        vga_VS      <= vga_VS_n;
        vga_R       <= (clear) ? 1'b0 : vga_R_n;
        vga_G       <= (clear) ? 1'b0 : vga_G_n;
        vga_B       <= (clear) ? 1'b0 : vga_B_n;
    end
end

// Logic
// -- Counters lead the output by 1 cycle
always @* begin
    // No latches
    hcnt_n     = hcnt;
    vcnt_n     = vcnt;

    // Sync pulses
    vga_HS_n = ( hcnt < VGA_TPULSE_H ) ? 1'b0 : 1'b1;   // High while active, low pulse
    vga_VS_n = ( vcnt < VGA_TPULSE_H ) ? 1'b0 : 1'b1;   // High while active, low pulse

    // inc counters, wrap at the end (*2 because of 50MHz clock)
    if ( hcnt < VGA_TSYNC_H ) begin
        hcnt_n = hcnt + 10'd1;
    end
    else begin
        hcnt_n = 10'd0;
        // Increment at end of line
        vcnt_n = ( vcnt < VGA_TSYNC_V ) ? vcnt + 10'd1 : 10'd0;
    end

    // Display active between Tfp and Tdisp
    if ( __hcnt >= VGA_TFP_H && __hcnt < VGA_TDISP_H && 
         __vcnt >= VGA_TFP_V && __vcnt < VGA_TDISP_V ) begin
        // Second half of pixel clock should be the same as the first
        if ( __hcnt[10] == 1'b1 ) begin
               vga_R_n = vga_R;
               vga_G_n = vga_G;
               vga_B_n = vga_B;
        end
        // Load new pixel
        else begin
               vga_R_n = buffer[45];
               vga_G_n = buffer[46];
               vga_B_n = buffer[47];
        end
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
    if ( hcnt[6:10] == 5'h1E ) begin
        buffer_n = pixels;
    end
    else if ( hcnt >= VGA_TFP_H && hcnt < VGA_TDISP_H && 
              vcnt >= VGA_TFP_V && vcnt < VGA_TDISP_V &&
                  hcnt[10] == 1'b0) begin
        buffer_n = buffer >> 3; // shift out displayed pixels
    end
    else begin
        buffer_n = buffer;  // No update
    end
end


endmodule
