//----------------------------------------------------------------------------
// user_logic.vhd - module
//----------------------------------------------------------------------------
//
// ***************************************************************************
// ** Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.            **
// **                                                                       **
// ** Xilinx, Inc.                                                          **
// ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
// ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
// ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
// ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
// ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
// ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
// ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
// ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
// ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
// ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
// ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
// ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
// ** FOR A PARTICULAR PURPOSE.                                             **
// **                                                                       **
// ***************************************************************************
//
//----------------------------------------------------------------------------
// Filename:          user_logic.vhd
// Version:           1.00.a
// Description:       User logic module.
// Date:              Thu Nov 21 14:01:25 2013 (by Create and Import Peripheral Wizard)
// Verilog Standard:  Verilog-2001
//----------------------------------------------------------------------------
// Naming Conventions:
//   active low signals:                    "*_n"
//   clock signals:                         "clk", "clk_div#", "clk_#x"
//   reset signals:                         "rst", "rst_n"
//   generics:                              "C_*"
//   user defined types:                    "*_TYPE"
//   state machine next state:              "*_ns"
//   state machine current state:           "*_cs"
//   combinatorial signals:                 "*_com"
//   pipelined or register delay signals:   "*_d#"
//   counter signals:                       "*cnt*"
//   clock enable signals:                  "*_ce"
//   internal version of output port:       "*_i"
//   device pins:                           "*_pin"
//   ports:                                 "- Names begin with Uppercase"
//   processes:                             "*_PROCESS"
//   component instantiations:              "<ENTITY_>I_<#|FUNC>"
//----------------------------------------------------------------------------

module user_logic
(
  // -- ADD USER PORTS BELOW THIS LINE ---------------
  // --USER ports added here     
  vga_HS,
  vga_VS,
  vga_R,
  vga_G,
  vga_B,
  // -- ADD USER PORTS ABOVE THIS LINE ---------------

  // -- DO NOT EDIT BELOW THIS LINE ------------------
  // -- Bus protocol ports, do not add to or delete 
  Bus2IP_Clk,                     // Bus to IP clock
  Bus2IP_Reset,                   // Bus to IP reset
  Bus2IP_Data,                    // Bus to IP data bus
  Bus2IP_BE,                      // Bus to IP byte enables
  Bus2IP_RdCE,                    // Bus to IP read chip enable
  Bus2IP_WrCE,                    // Bus to IP write chip enable
  IP2Bus_Data,                    // IP to Bus data bus
  IP2Bus_RdAck,                   // IP to Bus read transfer acknowledgement
  IP2Bus_WrAck,                   // IP to Bus write transfer acknowledgement
  IP2Bus_Error,                   // IP to Bus error response
  IP2Bus_IntrEvent                // IP to Bus interrupt event
  // -- DO NOT EDIT ABOVE THIS LINE ------------------
); // user_logic

// -- ADD USER PARAMETERS BELOW THIS LINE ------------
// --USER parameters added here 
// -- ADD USER PARAMETERS ABOVE THIS LINE ------------

// -- DO NOT EDIT BELOW THIS LINE --------------------
// -- Bus protocol parameters, do not add to or delete
parameter C_SLV_DWIDTH                   = 32;
parameter C_NUM_REG                      = 56;
parameter C_NUM_INTR                     = 1;
// -- DO NOT EDIT ABOVE THIS LINE --------------------

// -- ADD USER PORTS BELOW THIS LINE -----------------
// --USER ports added here 
output                                    vga_HS;
output                                    vga_VS;
output                                    vga_R;
output                                    vga_G;
output                                    vga_B;
// -- ADD USER PORTS ABOVE THIS LINE -----------------

// -- DO NOT EDIT BELOW THIS LINE --------------------
// -- Bus protocol ports, do not add to or delete
input                                     Bus2IP_Clk;
input                                     Bus2IP_Reset;
input      [0 : C_SLV_DWIDTH-1]           Bus2IP_Data;
input      [0 : C_SLV_DWIDTH/8-1]         Bus2IP_BE;
input      [0 : C_NUM_REG-1]              Bus2IP_RdCE;
input      [0 : C_NUM_REG-1]              Bus2IP_WrCE;
output     [0 : C_SLV_DWIDTH-1]           IP2Bus_Data;
output                                    IP2Bus_RdAck;
output                                    IP2Bus_WrAck;
output                                    IP2Bus_Error;
output     [0 : C_NUM_INTR-1]             IP2Bus_IntrEvent;
// -- DO NOT EDIT ABOVE THIS LINE --------------------

//----------------------------------------------------------------------------
// Implementation
//----------------------------------------------------------------------------

  // --USER nets declarations added here, as needed for user logic

  // Nets for user logic slave model s/w accessible register example
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg0;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg1;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg2;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg3;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg4;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg5;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg6;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg7;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg8;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg9;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg10;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg11;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg12;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg13;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg14;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg15;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg16;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg17;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg18;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg19;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg20;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg21;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg22;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg23;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg24;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg25;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg26;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg27;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg28;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg29;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg30;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg31;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg32;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg33;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg34;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg35;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg36;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg37;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg38;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg39;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg40;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg41;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg42;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg43;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg44;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg45;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg46;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg47;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg48;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg49;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg50;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg51;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg52;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg53;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg54;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg55;
  wire       [0 : 55]                       slv_reg_write_sel;
  wire       [0 : 55]                       slv_reg_read_sel;
  reg        [0 : C_SLV_DWIDTH-1]           slv_ip2bus_data;
  wire                                      slv_read_ack;
  wire                                      slv_write_ack;
  integer                                   byte_index, bit_index;

  // --USER logic implementation added here
  // Keeping the register read/write logic. Adding the VGA controller to the
  // logic beneath this (not good design practice, but it'll work)
  wire                                      IP2Bus_IntrEvent = 1'b0;
  wire      [31:0]                          score = slv_reg54;
  wire      [31:0]                          level = slv_reg55;
  wire      [10:0]                          cnt_X;
  wire      [9:0]                           cnt_Y;
  wire      [7:0]                           tile;   // selection from raster
  reg       [7:0]                           glyph;  // returned value (glyph, level or score)
  wire      [47:0]                          pixels;

  always @( posedge Bus2IP_Clk )
    begin : TILE_SELECTION

        if ( Bus2IP_Reset == 1 )
          begin
            glyph <= 8'd0;
          end
        else
          case ( tile )
            8'd0 : glyph   <= slv_reg0[24:31];
            8'd1 : glyph   <= slv_reg0[16:23];
            8'd2 : glyph   <= slv_reg0[8:15];
            8'd3 : glyph   <= slv_reg0[0:7];
            8'd4 : glyph   <= slv_reg1[24:31];
            8'd5 : glyph   <= slv_reg1[16:23];
            8'd6 : glyph   <= slv_reg1[8:15];
            8'd7 : glyph   <= slv_reg1[0:7];
            8'd8 : glyph   <= slv_reg2[24:31];
            8'd9 : glyph   <= slv_reg2[16:23];
            8'd10 : glyph  <= slv_reg2[8:15];
            8'd11 : glyph  <= slv_reg2[0:7];
            8'd12 : glyph  <= slv_reg3[24:31];
            8'd13 : glyph  <= slv_reg3[16:23];
            8'd14 : glyph  <= slv_reg3[8:15];
            8'd15 : glyph  <= slv_reg3[0:7];
            8'd16 : glyph  <= slv_reg4[24:31];
            8'd17 : glyph  <= slv_reg4[16:23];
            8'd18 : glyph  <= slv_reg4[8:15];
            8'd19 : glyph  <= slv_reg4[0:7];
            8'd20 : glyph  <= slv_reg5[24:31];
            8'd21 : glyph  <= slv_reg5[16:23];
            8'd22 : glyph  <= slv_reg5[8:15];
            8'd23 : glyph  <= slv_reg5[0:7];
            8'd24 : glyph  <= slv_reg6[24:31];
            8'd25 : glyph  <= slv_reg6[16:23];
            8'd26 : glyph  <= slv_reg6[8:15];
            8'd27 : glyph  <= slv_reg6[0:7];
            8'd28 : glyph  <= slv_reg7[24:31];
            8'd29 : glyph  <= slv_reg7[16:23];
            8'd30 : glyph  <= slv_reg7[8:15];
            8'd31 : glyph  <= slv_reg7[0:7];
            8'd32 : glyph  <= slv_reg8[24:31];
            8'd33 : glyph  <= slv_reg8[16:23];
            8'd34 : glyph  <= slv_reg8[8:15];
            8'd35 : glyph  <= slv_reg8[0:7];
            8'd36 : glyph  <= slv_reg9[24:31];
            8'd37 : glyph  <= slv_reg9[16:23];
            8'd38 : glyph  <= slv_reg9[8:15];
            8'd39 : glyph  <= slv_reg9[0:7];
            8'd40 : glyph  <= slv_reg10[24:31];
            8'd41 : glyph  <= slv_reg10[16:23];
            8'd42 : glyph  <= slv_reg10[8:15];
            8'd43 : glyph  <= slv_reg10[0:7];
            8'd44 : glyph  <= slv_reg11[24:31];
            8'd45 : glyph  <= slv_reg11[16:23];
            8'd46 : glyph  <= slv_reg11[8:15];
            8'd47 : glyph  <= slv_reg11[0:7];
            8'd48 : glyph  <= slv_reg12[24:31];
            8'd49 : glyph  <= slv_reg12[16:23];
            8'd50 : glyph  <= slv_reg12[8:15];
            8'd51 : glyph  <= slv_reg12[0:7];
            8'd52 : glyph  <= slv_reg13[24:31];
            8'd53 : glyph  <= slv_reg13[16:23];
            8'd54 : glyph  <= slv_reg13[8:15];
            8'd55 : glyph  <= slv_reg13[0:7];
            8'd56 : glyph  <= slv_reg14[24:31];
            8'd57 : glyph  <= slv_reg14[16:23];
            8'd58 : glyph  <= slv_reg14[8:15];
            8'd59 : glyph  <= slv_reg14[0:7];
            8'd60 : glyph  <= slv_reg15[24:31];
            8'd61 : glyph  <= slv_reg15[16:23];
            8'd62 : glyph  <= slv_reg15[8:15];
            8'd63 : glyph  <= slv_reg15[0:7];
            8'd64 : glyph  <= slv_reg16[24:31];
            8'd65 : glyph  <= slv_reg16[16:23];
            8'd66 : glyph  <= slv_reg16[8:15];
            8'd67 : glyph  <= slv_reg16[0:7];
            8'd68 : glyph  <= slv_reg17[24:31];
            8'd69 : glyph  <= slv_reg17[16:23];
            8'd70 : glyph  <= slv_reg17[8:15];
            8'd71 : glyph  <= slv_reg17[0:7];
            8'd72 : glyph  <= slv_reg18[24:31];
            8'd73 : glyph  <= slv_reg18[16:23];
            8'd74 : glyph  <= slv_reg18[8:15];
            8'd75 : glyph  <= slv_reg18[0:7];
            8'd76 : glyph  <= slv_reg19[24:31];
            8'd77 : glyph  <= slv_reg19[16:23];
            8'd78 : glyph  <= slv_reg19[8:15];
            8'd79 : glyph  <= slv_reg19[0:7];
            8'd80 : glyph  <= slv_reg20[24:31];
            8'd81 : glyph  <= slv_reg20[16:23];
            8'd82 : glyph  <= slv_reg20[8:15];
            8'd83 : glyph  <= slv_reg20[0:7];
            8'd84 : glyph  <= slv_reg21[24:31];
            8'd85 : glyph  <= slv_reg21[16:23];
            8'd86 : glyph  <= slv_reg21[8:15];
            8'd87 : glyph  <= slv_reg21[0:7];
            8'd88 : glyph  <= slv_reg22[24:31];
            8'd89 : glyph  <= slv_reg22[16:23];
            8'd90 : glyph  <= slv_reg22[8:15];
            8'd91 : glyph  <= slv_reg22[0:7];
            8'd92 : glyph  <= slv_reg23[24:31];
            8'd93 : glyph  <= slv_reg23[16:23];
            8'd94 : glyph  <= slv_reg23[8:15];
            8'd95 : glyph  <= slv_reg23[0:7];
            8'd96 : glyph  <= slv_reg24[24:31];
            8'd97 : glyph  <= slv_reg24[16:23];
            8'd98 : glyph  <= slv_reg24[8:15];
            8'd99 : glyph  <= slv_reg24[0:7];
            8'd100 : glyph <= slv_reg25[24:31];
            8'd101 : glyph <= slv_reg25[16:23];
            8'd102 : glyph <= slv_reg25[8:15];
            8'd103 : glyph <= slv_reg25[0:7];
            8'd104 : glyph <= slv_reg26[24:31];
            8'd105 : glyph <= slv_reg26[16:23];
            8'd106 : glyph <= slv_reg26[8:15];
            8'd107 : glyph <= slv_reg26[0:7];
            8'd108 : glyph <= slv_reg27[24:31];
            8'd109 : glyph <= slv_reg27[16:23];
            8'd110 : glyph <= slv_reg27[8:15];
            8'd111 : glyph <= slv_reg27[0:7];
            8'd112 : glyph <= slv_reg28[24:31];
            8'd113 : glyph <= slv_reg28[16:23];
            8'd114 : glyph <= slv_reg28[8:15];
            8'd115 : glyph <= slv_reg28[0:7];
            8'd116 : glyph <= slv_reg29[24:31];
            8'd117 : glyph <= slv_reg29[16:23];
            8'd118 : glyph <= slv_reg29[8:15];
            8'd119 : glyph <= slv_reg29[0:7];
            8'd120 : glyph <= slv_reg30[24:31];
            8'd121 : glyph <= slv_reg30[16:23];
            8'd122 : glyph <= slv_reg30[8:15];
            8'd123 : glyph <= slv_reg30[0:7];
            8'd124 : glyph <= slv_reg31[24:31];
            8'd125 : glyph <= slv_reg31[16:23];
            8'd126 : glyph <= slv_reg31[8:15];
            8'd127 : glyph <= slv_reg31[0:7];
            8'd128 : glyph <= slv_reg32[24:31];
            8'd129 : glyph <= slv_reg32[16:23];
            8'd130 : glyph <= slv_reg32[8:15];
            8'd131 : glyph <= slv_reg32[0:7];
            8'd132 : glyph <= slv_reg33[24:31];
            8'd133 : glyph <= slv_reg33[16:23];
            8'd134 : glyph <= slv_reg33[8:15];
            8'd135 : glyph <= slv_reg33[0:7];
            8'd136 : glyph <= slv_reg34[24:31];
            8'd137 : glyph <= slv_reg34[16:23];
            8'd138 : glyph <= slv_reg34[8:15];
            8'd139 : glyph <= slv_reg34[0:7];
            8'd140 : glyph <= slv_reg35[24:31];
            8'd141 : glyph <= slv_reg35[16:23];
            8'd142 : glyph <= slv_reg35[8:15];
            8'd143 : glyph <= slv_reg35[0:7];
            8'd144 : glyph <= slv_reg36[24:31];
            8'd145 : glyph <= slv_reg36[16:23];
            8'd146 : glyph <= slv_reg36[8:15];
            8'd147 : glyph <= slv_reg36[0:7];
            8'd148 : glyph <= slv_reg37[24:31];
            8'd149 : glyph <= slv_reg37[16:23];
            8'd150 : glyph <= slv_reg37[8:15];
            8'd151 : glyph <= slv_reg37[0:7];
            8'd152 : glyph <= slv_reg38[24:31];
            8'd153 : glyph <= slv_reg38[16:23];
            8'd154 : glyph <= slv_reg38[8:15];
            8'd155 : glyph <= slv_reg38[0:7];
            8'd156 : glyph <= slv_reg39[24:31];
            8'd157 : glyph <= slv_reg39[16:23];
            8'd158 : glyph <= slv_reg39[8:15];
            8'd159 : glyph <= slv_reg39[0:7];
            8'd160 : glyph <= slv_reg40[24:31];
            8'd161 : glyph <= slv_reg40[16:23];
            8'd162 : glyph <= slv_reg40[8:15];
            8'd163 : glyph <= slv_reg40[0:7];
            8'd164 : glyph <= slv_reg41[24:31];
            8'd165 : glyph <= slv_reg41[16:23];
            8'd166 : glyph <= slv_reg41[8:15];
            8'd167 : glyph <= slv_reg41[0:7];
            8'd168 : glyph <= slv_reg42[24:31];
            8'd169 : glyph <= slv_reg42[16:23];
            8'd170 : glyph <= slv_reg42[8:15];
            8'd171 : glyph <= slv_reg42[0:7];
            8'd172 : glyph <= slv_reg43[24:31];
            8'd173 : glyph <= slv_reg43[16:23];
            8'd174 : glyph <= slv_reg43[8:15];
            8'd175 : glyph <= slv_reg43[0:7];
            8'd176 : glyph <= slv_reg44[24:31];
            8'd177 : glyph <= slv_reg44[16:23];
            8'd178 : glyph <= slv_reg44[8:15];
            8'd179 : glyph <= slv_reg44[0:7];
            8'd180 : glyph <= slv_reg45[24:31];
            8'd181 : glyph <= slv_reg45[16:23];
            8'd182 : glyph <= slv_reg45[8:15];
            8'd183 : glyph <= slv_reg45[0:7];
            8'd184 : glyph <= slv_reg46[24:31];
            8'd185 : glyph <= slv_reg46[16:23];
            8'd186 : glyph <= slv_reg46[8:15];
            8'd187 : glyph <= slv_reg46[0:7];
            8'd188 : glyph <= slv_reg47[24:31];
            8'd189 : glyph <= slv_reg47[16:23];
            8'd190 : glyph <= slv_reg47[8:15];
            8'd191 : glyph <= slv_reg47[0:7];
            8'd192 : glyph <= slv_reg48[24:31];
            8'd193 : glyph <= slv_reg48[16:23];
            8'd194 : glyph <= slv_reg48[8:15];
            8'd195 : glyph <= slv_reg48[0:7];
            8'd196 : glyph <= slv_reg49[24:31];
            8'd197 : glyph <= slv_reg49[16:23];
            8'd198 : glyph <= slv_reg49[8:15];
            8'd199 : glyph <= slv_reg49[0:7];
            8'd200 : glyph <= slv_reg50[24:31];
            8'd201 : glyph <= slv_reg50[16:23];
            8'd202 : glyph <= slv_reg50[8:15];
            8'd203 : glyph <= slv_reg50[0:7];
            8'd204 : glyph <= slv_reg51[24:31];
            8'd205 : glyph <= slv_reg51[16:23];
            8'd206 : glyph <= slv_reg51[8:15];
            8'd207 : glyph <= slv_reg51[0:7];
            8'd208 : glyph <= slv_reg52[24:31];
            8'd209 : glyph <= slv_reg52[16:23];
            8'd210 : glyph <= slv_reg52[8:15];
            8'd211 : glyph <= slv_reg52[0:7];
            8'd212 : glyph <= slv_reg53[24:31];
            8'd213 : glyph <= slv_reg53[16:23];
            8'd214 : glyph <= slv_reg53[8:15];
            8'd215 : glyph <= slv_reg53[0:7];
            default: glyph <= 8'd0;
          endcase
    end

  siggen siggen(
      .clk(Bus2IP_Clk),
      .rst(Bus2IP_Reset),
      .cnt_X(cnt_X),
      .cnt_Y(cnt_Y),
      .tile(tile),
      .glyph(glyph),
      .pixels(pixels)
  );

  vga vga(
      .clk(Bus2IP_Clk),
      .rst(Bus2IP_Reset),
      .pixels(pixels),
      .cnt_X(cnt_X),
      .cnt_Y(cnt_Y),
      .vga_HS(vga_HS),
      .vga_VS(vga_VS),
      .vga_R(vga_R),
      .vga_G(vga_G),
      .vga_B(vga_B)
  );

  

  // ------------------------------------------------------
  // Example code to read/write user logic slave model s/w accessible registers
  // 
  // Note:
  // The example code presented here is to show you one way of reading/writing
  // software accessible registers implemented in the user logic slave model.
  // Each bit of the Bus2IP_WrCE/Bus2IP_RdCE signals is configured to correspond
  // to one software accessible register by the top level template. For example,
  // if you have four 32 bit software accessible registers in the user logic,
  // you are basically operating on the following memory mapped registers:
  // 
  //    Bus2IP_WrCE/Bus2IP_RdCE   Memory Mapped Register
  //                     "1000"   C_BASEADDR + 0x0
  //                     "0100"   C_BASEADDR + 0x4
  //                     "0010"   C_BASEADDR + 0x8
  //                     "0001"   C_BASEADDR + 0xC
  // 
  // ------------------------------------------------------

  assign
    slv_reg_write_sel = Bus2IP_WrCE[0:55],
    slv_reg_read_sel  = Bus2IP_RdCE[0:55],
    slv_write_ack     = Bus2IP_WrCE[0] || Bus2IP_WrCE[1] || Bus2IP_WrCE[2] || Bus2IP_WrCE[3] || Bus2IP_WrCE[4] || Bus2IP_WrCE[5] || Bus2IP_WrCE[6] || Bus2IP_WrCE[7] || Bus2IP_WrCE[8] || Bus2IP_WrCE[9] || Bus2IP_WrCE[10] || Bus2IP_WrCE[11] || Bus2IP_WrCE[12] || Bus2IP_WrCE[13] || Bus2IP_WrCE[14] || Bus2IP_WrCE[15] || Bus2IP_WrCE[16] || Bus2IP_WrCE[17] || Bus2IP_WrCE[18] || Bus2IP_WrCE[19] || Bus2IP_WrCE[20] || Bus2IP_WrCE[21] || Bus2IP_WrCE[22] || Bus2IP_WrCE[23] || Bus2IP_WrCE[24] || Bus2IP_WrCE[25] || Bus2IP_WrCE[26] || Bus2IP_WrCE[27] || Bus2IP_WrCE[28] || Bus2IP_WrCE[29] || Bus2IP_WrCE[30] || Bus2IP_WrCE[31] || Bus2IP_WrCE[32] || Bus2IP_WrCE[33] || Bus2IP_WrCE[34] || Bus2IP_WrCE[35] || Bus2IP_WrCE[36] || Bus2IP_WrCE[37] || Bus2IP_WrCE[38] || Bus2IP_WrCE[39] || Bus2IP_WrCE[40] || Bus2IP_WrCE[41] || Bus2IP_WrCE[42] || Bus2IP_WrCE[43] || Bus2IP_WrCE[44] || Bus2IP_WrCE[45] || Bus2IP_WrCE[46] || Bus2IP_WrCE[47] || Bus2IP_WrCE[48] || Bus2IP_WrCE[49] || Bus2IP_WrCE[50] || Bus2IP_WrCE[51] || Bus2IP_WrCE[52] || Bus2IP_WrCE[53] || Bus2IP_WrCE[54] || Bus2IP_WrCE[55],
    slv_read_ack      = Bus2IP_RdCE[0] || Bus2IP_RdCE[1] || Bus2IP_RdCE[2] || Bus2IP_RdCE[3] || Bus2IP_RdCE[4] || Bus2IP_RdCE[5] || Bus2IP_RdCE[6] || Bus2IP_RdCE[7] || Bus2IP_RdCE[8] || Bus2IP_RdCE[9] || Bus2IP_RdCE[10] || Bus2IP_RdCE[11] || Bus2IP_RdCE[12] || Bus2IP_RdCE[13] || Bus2IP_RdCE[14] || Bus2IP_RdCE[15] || Bus2IP_RdCE[16] || Bus2IP_RdCE[17] || Bus2IP_RdCE[18] || Bus2IP_RdCE[19] || Bus2IP_RdCE[20] || Bus2IP_RdCE[21] || Bus2IP_RdCE[22] || Bus2IP_RdCE[23] || Bus2IP_RdCE[24] || Bus2IP_RdCE[25] || Bus2IP_RdCE[26] || Bus2IP_RdCE[27] || Bus2IP_RdCE[28] || Bus2IP_RdCE[29] || Bus2IP_RdCE[30] || Bus2IP_RdCE[31] || Bus2IP_RdCE[32] || Bus2IP_RdCE[33] || Bus2IP_RdCE[34] || Bus2IP_RdCE[35] || Bus2IP_RdCE[36] || Bus2IP_RdCE[37] || Bus2IP_RdCE[38] || Bus2IP_RdCE[39] || Bus2IP_RdCE[40] || Bus2IP_RdCE[41] || Bus2IP_RdCE[42] || Bus2IP_RdCE[43] || Bus2IP_RdCE[44] || Bus2IP_RdCE[45] || Bus2IP_RdCE[46] || Bus2IP_RdCE[47] || Bus2IP_RdCE[48] || Bus2IP_RdCE[49] || Bus2IP_RdCE[50] || Bus2IP_RdCE[51] || Bus2IP_RdCE[52] || Bus2IP_RdCE[53] || Bus2IP_RdCE[54] || Bus2IP_RdCE[55];

  // implement slave model register(s)
  always @( posedge Bus2IP_Clk )
    begin: SLAVE_REG_WRITE_PROC

      if ( Bus2IP_Reset == 1 )
        begin
          slv_reg0 <= 0;
          slv_reg1 <= 0;
          slv_reg2 <= 0;
          slv_reg3 <= 0;
          slv_reg4 <= 0;
          slv_reg5 <= 0;
          slv_reg6 <= 0;
          slv_reg7 <= 0;
          slv_reg8 <= 0;
          slv_reg9 <= 0;
          slv_reg10 <= 0;
          slv_reg11 <= 0;
          slv_reg12 <= 0;
          slv_reg13 <= 0;
          slv_reg14 <= 0;
          slv_reg15 <= 0;
          slv_reg16 <= 0;
          slv_reg17 <= 0;
          slv_reg18 <= 0;
          slv_reg19 <= 0;
          slv_reg20 <= 0;
          slv_reg21 <= 0;
          slv_reg22 <= 0;
          slv_reg23 <= 0;
          slv_reg24 <= 0;
          slv_reg25 <= 0;
          slv_reg26 <= 0;
          slv_reg27 <= 0;
          slv_reg28 <= 0;
          slv_reg29 <= 0;
          slv_reg30 <= 0;
          slv_reg31 <= 0;
          slv_reg32 <= 0;
          slv_reg33 <= 0;
          slv_reg34 <= 0;
          slv_reg35 <= 0;
          slv_reg36 <= 0;
          slv_reg37 <= 0;
          slv_reg38 <= 0;
          slv_reg39 <= 0;
          slv_reg40 <= 0;
          slv_reg41 <= 0;
          slv_reg42 <= 0;
          slv_reg43 <= 0;
          slv_reg44 <= 0;
          slv_reg45 <= 0;
          slv_reg46 <= 0;
          slv_reg47 <= 0;
          slv_reg48 <= 0;
          slv_reg49 <= 0;
          slv_reg50 <= 0;
          slv_reg51 <= 0;
          slv_reg52 <= 0;
          slv_reg53 <= 0;
          slv_reg54 <= 0;
          slv_reg55 <= 0;
        end
      else
		  begin
        case ( slv_reg_write_sel )
		  /*
          56'b10000000000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg0[bit_index] <= Bus2IP_Data[bit_index];
		  */
          56'b01000000000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg1[bit_index] <= Bus2IP_Data[bit_index];
          56'b00100000000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg2[bit_index] <= Bus2IP_Data[bit_index];
          56'b00010000000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg3[bit_index] <= Bus2IP_Data[bit_index];
          56'b00001000000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg4[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000100000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg5[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000010000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg6[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000001000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg7[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000100000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg8[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000010000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg9[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000001000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg10[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000100000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg11[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000010000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg12[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000001000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg13[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000100000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg14[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000010000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg15[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000001000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg16[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000100000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg17[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000010000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg18[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000001000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg19[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000100000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg20[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000010000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg21[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000001000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg22[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000100000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg23[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000010000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg24[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000001000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg25[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000100000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg26[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000010000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg27[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000001000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg28[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000100000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg29[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000010000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg30[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000001000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg31[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000100000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg32[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000010000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg33[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000001000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg34[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000100000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg35[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000010000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg36[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000001000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg37[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000100000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg38[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000010000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg39[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000001000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg40[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000100000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg41[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000010000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg42[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000001000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg43[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000000100000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg44[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000000010000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg45[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000000001000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg46[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000000000100000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg47[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000000000010000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg48[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000000000001000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg49[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000000000000100000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg50[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000000000000010000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg51[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000000000000001000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg52[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000000000000000100 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg53[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000000000000000010 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg54[bit_index] <= Bus2IP_Data[bit_index];
          56'b00000000000000000000000000000000000000000000000000000001 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg55[bit_index] <= Bus2IP_Data[bit_index];
          default : ;
        endcase
		  slv_reg0 <= {6'd0, cnt_Y[9:0], 5'd0, cnt_X[10:0]};
		end
    end // SLAVE_REG_WRITE_PROC

  // implement slave model register read mux
  always @( slv_reg_read_sel or slv_reg0 or slv_reg1 or slv_reg2 or slv_reg3 or slv_reg4 or slv_reg5 or slv_reg6 or slv_reg7 or slv_reg8 or slv_reg9 or slv_reg10 or slv_reg11 or slv_reg12 or slv_reg13 or slv_reg14 or slv_reg15 or slv_reg16 or slv_reg17 or slv_reg18 or slv_reg19 or slv_reg20 or slv_reg21 or slv_reg22 or slv_reg23 or slv_reg24 or slv_reg25 or slv_reg26 or slv_reg27 or slv_reg28 or slv_reg29 or slv_reg30 or slv_reg31 or slv_reg32 or slv_reg33 or slv_reg34 or slv_reg35 or slv_reg36 or slv_reg37 or slv_reg38 or slv_reg39 or slv_reg40 or slv_reg41 or slv_reg42 or slv_reg43 or slv_reg44 or slv_reg45 or slv_reg46 or slv_reg47 or slv_reg48 or slv_reg49 or slv_reg50 or slv_reg51 or slv_reg52 or slv_reg53 or slv_reg54 or slv_reg55 )
    begin: SLAVE_REG_READ_PROC

      case ( slv_reg_read_sel )
        56'b10000000000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= 0; //slv_reg0;
        56'b01000000000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= 1; //slv_reg1;
        56'b00100000000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= 2; //slv_reg2;
        56'b00010000000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= 3; //slv_reg3;
        56'b00001000000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= 4; //slv_reg4;
        56'b00000100000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= 5; //slv_reg5;
        56'b00000010000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= 6; //slv_reg6;
        56'b00000001000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= 7; //slv_reg7;
        56'b00000000100000000000000000000000000000000000000000000000 : slv_ip2bus_data <= 8; //slv_reg8;
        56'b00000000010000000000000000000000000000000000000000000000 : slv_ip2bus_data <= 9; //slv_reg9;
        56'b00000000001000000000000000000000000000000000000000000000 : slv_ip2bus_data <= 10; //slv_reg10;
        56'b00000000000100000000000000000000000000000000000000000000 : slv_ip2bus_data <= 1; //slv_reg11;
        56'b00000000000010000000000000000000000000000000000000000000 : slv_ip2bus_data <= 2; //slv_reg12;
        56'b00000000000001000000000000000000000000000000000000000000 : slv_ip2bus_data <= 3; //slv_reg13;
        56'b00000000000000100000000000000000000000000000000000000000 : slv_ip2bus_data <= 4; //slv_reg14;
        56'b00000000000000010000000000000000000000000000000000000000 : slv_ip2bus_data <= 5; //slv_reg15;
        56'b00000000000000001000000000000000000000000000000000000000 : slv_ip2bus_data <= 6; //slv_reg16;
        56'b00000000000000000100000000000000000000000000000000000000 : slv_ip2bus_data <= 7; //slv_reg17;
        56'b00000000000000000010000000000000000000000000000000000000 : slv_ip2bus_data <= 8; //slv_reg18;
        56'b00000000000000000001000000000000000000000000000000000000 : slv_ip2bus_data <= 9; //slv_reg19;
        56'b00000000000000000000100000000000000000000000000000000000 : slv_ip2bus_data <= 10; //slv_reg20;
        56'b00000000000000000000010000000000000000000000000000000000 : slv_ip2bus_data <= 1; //slv_reg21;
        56'b00000000000000000000001000000000000000000000000000000000 : slv_ip2bus_data <= 2; //slv_reg22;
        56'b00000000000000000000000100000000000000000000000000000000 : slv_ip2bus_data <= 3; //slv_reg23;
        56'b00000000000000000000000010000000000000000000000000000000 : slv_ip2bus_data <= 4; //slv_reg24;
        56'b00000000000000000000000001000000000000000000000000000000 : slv_ip2bus_data <= 5; //slv_reg25;
        56'b00000000000000000000000000100000000000000000000000000000 : slv_ip2bus_data <= 6; //slv_reg26;
        56'b00000000000000000000000000010000000000000000000000000000 : slv_ip2bus_data <= 7; //slv_reg27;
        56'b00000000000000000000000000001000000000000000000000000000 : slv_ip2bus_data <= 8; //slv_reg28;
        56'b00000000000000000000000000000100000000000000000000000000 : slv_ip2bus_data <= 9; //slv_reg29;
        56'b00000000000000000000000000000010000000000000000000000000 : slv_ip2bus_data <= 10; //slv_reg30;
        56'b00000000000000000000000000000001000000000000000000000000 : slv_ip2bus_data <= 1; //slv_reg31;
        56'b00000000000000000000000000000000100000000000000000000000 : slv_ip2bus_data <= 2; //slv_reg32;
        56'b00000000000000000000000000000000010000000000000000000000 : slv_ip2bus_data <= 3; //slv_reg33;
        56'b00000000000000000000000000000000001000000000000000000000 : slv_ip2bus_data <= 4; //slv_reg34;
        56'b00000000000000000000000000000000000100000000000000000000 : slv_ip2bus_data <= 5; //slv_reg35;
        56'b00000000000000000000000000000000000010000000000000000000 : slv_ip2bus_data <= 6; //slv_reg36;
        56'b00000000000000000000000000000000000001000000000000000000 : slv_ip2bus_data <= 7; //slv_reg37;
        56'b00000000000000000000000000000000000000100000000000000000 : slv_ip2bus_data <= 8; //slv_reg38;
        56'b00000000000000000000000000000000000000010000000000000000 : slv_ip2bus_data <= 9; //slv_reg39;
        56'b00000000000000000000000000000000000000001000000000000000 : slv_ip2bus_data <= 10; //slv_reg40;
        56'b00000000000000000000000000000000000000000100000000000000 : slv_ip2bus_data <= 1; //slv_reg41;
        56'b00000000000000000000000000000000000000000010000000000000 : slv_ip2bus_data <= 2; //slv_reg42;
        56'b00000000000000000000000000000000000000000001000000000000 : slv_ip2bus_data <= 3; //slv_reg43;
        56'b00000000000000000000000000000000000000000000100000000000 : slv_ip2bus_data <= 4; //slv_reg44;
        56'b00000000000000000000000000000000000000000000010000000000 : slv_ip2bus_data <= 5; //slv_reg45;
        56'b00000000000000000000000000000000000000000000001000000000 : slv_ip2bus_data <= 6; //slv_reg46;
        56'b00000000000000000000000000000000000000000000000100000000 : slv_ip2bus_data <= 7; //slv_reg47;
        56'b00000000000000000000000000000000000000000000000010000000 : slv_ip2bus_data <= 8; //slv_reg48;
        56'b00000000000000000000000000000000000000000000000001000000 : slv_ip2bus_data <= 9; //slv_reg49;
        56'b00000000000000000000000000000000000000000000000000100000 : slv_ip2bus_data <= 10; //slv_reg50;
        56'b00000000000000000000000000000000000000000000000000010000 : slv_ip2bus_data <= 1; //slv_reg51;
        56'b00000000000000000000000000000000000000000000000000001000 : slv_ip2bus_data <= 2; //slv_reg52;
        56'b00000000000000000000000000000000000000000000000000000100 : slv_ip2bus_data <= 3; //slv_reg53;
        56'b00000000000000000000000000000000000000000000000000000010 : slv_ip2bus_data <= 4; //slv_reg54;
        56'b00000000000000000000000000000000000000000000000000000001 : slv_ip2bus_data <= 7; //slv_reg55;
        default : slv_ip2bus_data <= 0;
      endcase

    end // SLAVE_REG_READ_PROC

  // ------------------------------------------------------------
  // Example code to drive IP to Bus signals
  // ------------------------------------------------------------

  assign IP2Bus_Data    = slv_ip2bus_data;
  assign IP2Bus_WrAck   = slv_write_ack;
  assign IP2Bus_RdAck   = slv_read_ack;
  assign IP2Bus_Error   = 0;

endmodule
