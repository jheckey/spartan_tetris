
module vga (
    input   wire        clk,        // 50MHz
    input   wire        rst,
    output  reg         vga_HS,
    output  reg         vga_VS,
    output  reg         vga_R,
    output  reg         vga_G,
    output  reg         vga_B
);

reg clk25;
reg [9:0] CounterX;
reg [8:0] CounterY;

wire CounterXmaxed = (CounterX==767);

always @(posedge clk) clk25 <= ~clk25;

/*
CounterX counts 768 values (from 0 to 767) and CounterY counts 512 values (0 to 511).

Now, CounterX is used to generate HS, and CounterY to generate VS. Using a 25MHz
clock, we get 32.5KHz for HS and 63.5Hz for VS. The pulses need to be active
long enough for the monitor to detect them. Let's use a 16 clocks pulse (0.64µs)
for HS and a full horizontal line length pulse for VS (768 clocks or 30µs).
That's shorter than what the VGA spec calls for but works fine anyway.

We generate the HS and VS pulses from D flip-flop (to get glitch free outputs).
*/

always @(posedge clk25 or posedge rst)
begin
    if (rst) begin
        CounterX    <= 0;
        CounterY    <= 0;
        vga_HS      <= 0;
        vga_VS      <= 0;
        vga_R       <= 0;
        vga_G       <= 0;
        vga_B       <= 0;
    end
    else begin
        if (CounterXmaxed) begin
            CounterX <= 0;
            CounterY <= CounterY + 1;
        end
        else begin
            CounterX <= CounterX + 1;
        end

        // The VGA outputs need to be negative, so we invert the signals.
        vga_HS <= ~(CounterX[9:4]==0);   // active for 16 clocks
        vga_VS <= ~(CounterY==0);   // active for 768 clocks

        // Draw a checker board while in normal pixel region
		  if (CounterX >= 96+16 && CounterX < 96+16+640 &&
              CounterY >= 2+10 && CounterY < 2+10+480) begin
			  vga_R <= (CounterY[4] ^ CounterX[4]);
			  vga_G <= (CounterY[4] ^ CounterX[4]);
			  vga_B <= (CounterY[4] ^ CounterX[4]);
		  end
		  // Else, go blank
		  else begin
			  vga_R <= 0;
			  vga_G <= 0;
			  vga_B <= 0;
		  end
    end
end


endmodule
