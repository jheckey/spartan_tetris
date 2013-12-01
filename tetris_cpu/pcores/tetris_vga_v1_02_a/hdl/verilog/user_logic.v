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
// Version:           1.06.a
// Description:       User logic module.
// Date:              Sat Nov 23 12:11:21 2013 (by Create and Import Peripheral Wizard)
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
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg56;
  reg        [0 : C_SLV_DWIDTH-1]           slv_reg57;
  wire       [0 : 57]                       slv_reg_write_sel;
  wire       [0 : 57]                       slv_reg_read_sel;
  reg        [0 : C_SLV_DWIDTH-1]           slv_ip2bus_data;
  wire                                      slv_read_ack;
  wire                                      slv_write_ack;
  integer                                   byte_index, bit_index;

  // --USER logic implementation added here
  // -- Implement decode logic here
  wire                                      IP2Bus_IntrEvent = ~vga_VS;
  wire      [0:47]                          pixels, r_pixels, t_pixels;
  wire      [0:10]                          hcnt;
  wire      [0:9]                           vcnt;
  wire      [0:31]                          score = slv_reg56;
  wire      [0:31]                          level = slv_reg57;
  wire                                      enable = slv_reg0[31];
  wire                                      test_patt = slv_reg0[30];
  wire                                      clear = slv_reg0[0];
  wire      [0:(4*32)-1]                    next_tiles = { slv_reg52, slv_reg53, slv_reg54, slv_reg55 };
  wire      [0:(32*50)-1]                   tiles = { slv_reg2, slv_reg3, slv_reg4, slv_reg5, slv_reg6,
                                                      slv_reg7, slv_reg8, slv_reg9, slv_reg10, slv_reg11,
                                                      slv_reg12, slv_reg13, slv_reg14, slv_reg15, slv_reg16,
                                                      slv_reg17, slv_reg18, slv_reg19, slv_reg20, slv_reg21,
                                                      slv_reg22, slv_reg23, slv_reg24, slv_reg25, slv_reg26,
                                                      slv_reg27, slv_reg28, slv_reg29, slv_reg30, slv_reg31,
                                                      slv_reg32, slv_reg33, slv_reg34, slv_reg35, slv_reg36,
                                                      slv_reg37, slv_reg38, slv_reg39, slv_reg40, slv_reg41,
                                                      slv_reg42, slv_reg43, slv_reg44, slv_reg45, slv_reg46,
                                                      slv_reg47, slv_reg48, slv_reg49, slv_reg50, slv_reg51 };

  assign pixels = (test_patt) ? t_pixels : r_pixels;

  vga driver(
      .clk      (Bus2IP_Clk),
      .rst      (Bus2IP_Reset),
      .enable   (enable),
      .clear    (clear),
      .pixels   (pixels),
      .hcnt     (hcnt),
      .vcnt     (vcnt),
      .vga_HS   (vga_HS),
      .vga_VS   (vga_VS),
      .vga_R    (vga_R),
      .vga_G    (vga_G),
      .vga_B    (vga_B)
  );

  siggen testpatt(
      .clk      (Bus2IP_Clk),
      .rst      (Bus2IP_Reset),
      .hcnt     (hcnt),
      .vcnt     (vcnt),
      .pixels   (t_pixels)
  );

  raster render(
      .clk          (Bus2IP_Clk),
      .rst          (Bus2IP_Reset),
      .hcnt         (hcnt),
      .vcnt         (vcnt),
      .tiles        (tiles),
      .next_tiles   (next_tiles),
      .pixels       (r_pixels)
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
    slv_reg_write_sel = Bus2IP_WrCE[0:57],
    slv_reg_read_sel  = Bus2IP_RdCE[0:57],
    slv_write_ack     = Bus2IP_WrCE[0] || Bus2IP_WrCE[1] || Bus2IP_WrCE[2] || Bus2IP_WrCE[3] || Bus2IP_WrCE[4] || Bus2IP_WrCE[5] || Bus2IP_WrCE[6] || Bus2IP_WrCE[7] || Bus2IP_WrCE[8] || Bus2IP_WrCE[9] || Bus2IP_WrCE[10] || Bus2IP_WrCE[11] || Bus2IP_WrCE[12] || Bus2IP_WrCE[13] || Bus2IP_WrCE[14] || Bus2IP_WrCE[15] || Bus2IP_WrCE[16] || Bus2IP_WrCE[17] || Bus2IP_WrCE[18] || Bus2IP_WrCE[19] || Bus2IP_WrCE[20] || Bus2IP_WrCE[21] || Bus2IP_WrCE[22] || Bus2IP_WrCE[23] || Bus2IP_WrCE[24] || Bus2IP_WrCE[25] || Bus2IP_WrCE[26] || Bus2IP_WrCE[27] || Bus2IP_WrCE[28] || Bus2IP_WrCE[29] || Bus2IP_WrCE[30] || Bus2IP_WrCE[31] || Bus2IP_WrCE[32] || Bus2IP_WrCE[33] || Bus2IP_WrCE[34] || Bus2IP_WrCE[35] || Bus2IP_WrCE[36] || Bus2IP_WrCE[37] || Bus2IP_WrCE[38] || Bus2IP_WrCE[39] || Bus2IP_WrCE[40] || Bus2IP_WrCE[41] || Bus2IP_WrCE[42] || Bus2IP_WrCE[43] || Bus2IP_WrCE[44] || Bus2IP_WrCE[45] || Bus2IP_WrCE[46] || Bus2IP_WrCE[47] || Bus2IP_WrCE[48] || Bus2IP_WrCE[49] || Bus2IP_WrCE[50] || Bus2IP_WrCE[51] || Bus2IP_WrCE[52] || Bus2IP_WrCE[53] || Bus2IP_WrCE[54] || Bus2IP_WrCE[55] || Bus2IP_WrCE[56] || Bus2IP_WrCE[57],
    slv_read_ack      = Bus2IP_RdCE[0] || Bus2IP_RdCE[1] || Bus2IP_RdCE[2] || Bus2IP_RdCE[3] || Bus2IP_RdCE[4] || Bus2IP_RdCE[5] || Bus2IP_RdCE[6] || Bus2IP_RdCE[7] || Bus2IP_RdCE[8] || Bus2IP_RdCE[9] || Bus2IP_RdCE[10] || Bus2IP_RdCE[11] || Bus2IP_RdCE[12] || Bus2IP_RdCE[13] || Bus2IP_RdCE[14] || Bus2IP_RdCE[15] || Bus2IP_RdCE[16] || Bus2IP_RdCE[17] || Bus2IP_RdCE[18] || Bus2IP_RdCE[19] || Bus2IP_RdCE[20] || Bus2IP_RdCE[21] || Bus2IP_RdCE[22] || Bus2IP_RdCE[23] || Bus2IP_RdCE[24] || Bus2IP_RdCE[25] || Bus2IP_RdCE[26] || Bus2IP_RdCE[27] || Bus2IP_RdCE[28] || Bus2IP_RdCE[29] || Bus2IP_RdCE[30] || Bus2IP_RdCE[31] || Bus2IP_RdCE[32] || Bus2IP_RdCE[33] || Bus2IP_RdCE[34] || Bus2IP_RdCE[35] || Bus2IP_RdCE[36] || Bus2IP_RdCE[37] || Bus2IP_RdCE[38] || Bus2IP_RdCE[39] || Bus2IP_RdCE[40] || Bus2IP_RdCE[41] || Bus2IP_RdCE[42] || Bus2IP_RdCE[43] || Bus2IP_RdCE[44] || Bus2IP_RdCE[45] || Bus2IP_RdCE[46] || Bus2IP_RdCE[47] || Bus2IP_RdCE[48] || Bus2IP_RdCE[49] || Bus2IP_RdCE[50] || Bus2IP_RdCE[51] || Bus2IP_RdCE[52] || Bus2IP_RdCE[53] || Bus2IP_RdCE[54] || Bus2IP_RdCE[55] || Bus2IP_RdCE[56] || Bus2IP_RdCE[57];

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
          slv_reg56 <= 0;
          slv_reg57 <= 0;
        end
      else
        case ( slv_reg_write_sel )
          58'b1000000000000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg0[bit_index] <= Bus2IP_Data[bit_index];
        /* DEBUG REG, read only
          58'b0100000000000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg1[bit_index] <= Bus2IP_Data[bit_index];
        */
          58'b0010000000000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg2[bit_index] <= Bus2IP_Data[bit_index];
          58'b0001000000000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg3[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000100000000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg4[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000010000000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg5[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000001000000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg6[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000100000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg7[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000010000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg8[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000001000000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg9[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000100000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg10[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000010000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg11[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000001000000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg12[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000100000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg13[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000010000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg14[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000001000000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg15[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000100000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg16[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000010000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg17[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000001000000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg18[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000100000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg19[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000010000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg20[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000001000000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg21[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000100000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg22[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000010000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg23[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000001000000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg24[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000100000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg25[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000010000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg26[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000001000000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg27[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000100000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg28[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000010000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg29[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000001000000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg30[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000100000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg31[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000010000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg32[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000001000000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg33[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000100000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg34[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000010000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg35[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000001000000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg36[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000100000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg37[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000010000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg38[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000001000000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg39[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000100000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg40[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000010000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg41[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000001000000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg42[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000100000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg43[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000010000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg44[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000001000000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg45[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000000100000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg46[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000000010000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg47[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000000001000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg48[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000000000100000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg49[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000000000010000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg50[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000000000001000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg51[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000000000000100000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg52[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000000000000010000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg53[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000000000000001000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg54[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000000000000000100 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg55[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000000000000000010 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg56[bit_index] <= Bus2IP_Data[bit_index];
          58'b0000000000000000000000000000000000000000000000000000000001 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg57[bit_index] <= Bus2IP_Data[bit_index];
          default : ;
        endcase

        // Assign Debug
        slv_reg1 <= {5'd0,hcnt[0:10],6'd0,vcnt[0:9]};

    end // SLAVE_REG_WRITE_PROC

  // implement slave model register read mux
  always @( slv_reg_read_sel or slv_reg0 or slv_reg1 or slv_reg2 or slv_reg3 or slv_reg4 or slv_reg5 or slv_reg6 or slv_reg7 or slv_reg8 or slv_reg9 or slv_reg10 or slv_reg11 or slv_reg12 or slv_reg13 or slv_reg14 or slv_reg15 or slv_reg16 or slv_reg17 or slv_reg18 or slv_reg19 or slv_reg20 or slv_reg21 or slv_reg22 or slv_reg23 or slv_reg24 or slv_reg25 or slv_reg26 or slv_reg27 or slv_reg28 or slv_reg29 or slv_reg30 or slv_reg31 or slv_reg32 or slv_reg33 or slv_reg34 or slv_reg35 or slv_reg36 or slv_reg37 or slv_reg38 or slv_reg39 or slv_reg40 or slv_reg41 or slv_reg42 or slv_reg43 or slv_reg44 or slv_reg45 or slv_reg46 or slv_reg47 or slv_reg48 or slv_reg49 or slv_reg50 or slv_reg51 or slv_reg52 or slv_reg53 or slv_reg54 or slv_reg55 or slv_reg56 or slv_reg57 )
    begin: SLAVE_REG_READ_PROC

      case ( slv_reg_read_sel )
        58'b1000000000000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg0;
        58'b0100000000000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg1;
        58'b0010000000000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg2;
        58'b0001000000000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg3;
        58'b0000100000000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg4;
        58'b0000010000000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg5;
        58'b0000001000000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg6;
        58'b0000000100000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg7;
        58'b0000000010000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg8;
        58'b0000000001000000000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg9;
        58'b0000000000100000000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg10;
        58'b0000000000010000000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg11;
        58'b0000000000001000000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg12;
        58'b0000000000000100000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg13;
        58'b0000000000000010000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg14;
        58'b0000000000000001000000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg15;
        58'b0000000000000000100000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg16;
        58'b0000000000000000010000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg17;
        58'b0000000000000000001000000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg18;
        58'b0000000000000000000100000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg19;
        58'b0000000000000000000010000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg20;
        58'b0000000000000000000001000000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg21;
        58'b0000000000000000000000100000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg22;
        58'b0000000000000000000000010000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg23;
        58'b0000000000000000000000001000000000000000000000000000000000 : slv_ip2bus_data <= slv_reg24;
        58'b0000000000000000000000000100000000000000000000000000000000 : slv_ip2bus_data <= slv_reg25;
        58'b0000000000000000000000000010000000000000000000000000000000 : slv_ip2bus_data <= slv_reg26;
        58'b0000000000000000000000000001000000000000000000000000000000 : slv_ip2bus_data <= slv_reg27;
        58'b0000000000000000000000000000100000000000000000000000000000 : slv_ip2bus_data <= slv_reg28;
        58'b0000000000000000000000000000010000000000000000000000000000 : slv_ip2bus_data <= slv_reg29;
        58'b0000000000000000000000000000001000000000000000000000000000 : slv_ip2bus_data <= slv_reg30;
        58'b0000000000000000000000000000000100000000000000000000000000 : slv_ip2bus_data <= slv_reg31;
        58'b0000000000000000000000000000000010000000000000000000000000 : slv_ip2bus_data <= slv_reg32;
        58'b0000000000000000000000000000000001000000000000000000000000 : slv_ip2bus_data <= slv_reg33;
        58'b0000000000000000000000000000000000100000000000000000000000 : slv_ip2bus_data <= slv_reg34;
        58'b0000000000000000000000000000000000010000000000000000000000 : slv_ip2bus_data <= slv_reg35;
        58'b0000000000000000000000000000000000001000000000000000000000 : slv_ip2bus_data <= slv_reg36;
        58'b0000000000000000000000000000000000000100000000000000000000 : slv_ip2bus_data <= slv_reg37;
        58'b0000000000000000000000000000000000000010000000000000000000 : slv_ip2bus_data <= slv_reg38;
        58'b0000000000000000000000000000000000000001000000000000000000 : slv_ip2bus_data <= slv_reg39;
        58'b0000000000000000000000000000000000000000100000000000000000 : slv_ip2bus_data <= slv_reg40;
        58'b0000000000000000000000000000000000000000010000000000000000 : slv_ip2bus_data <= slv_reg41;
        58'b0000000000000000000000000000000000000000001000000000000000 : slv_ip2bus_data <= slv_reg42;
        58'b0000000000000000000000000000000000000000000100000000000000 : slv_ip2bus_data <= slv_reg43;
        58'b0000000000000000000000000000000000000000000010000000000000 : slv_ip2bus_data <= slv_reg44;
        58'b0000000000000000000000000000000000000000000001000000000000 : slv_ip2bus_data <= slv_reg45;
        58'b0000000000000000000000000000000000000000000000100000000000 : slv_ip2bus_data <= slv_reg46;
        58'b0000000000000000000000000000000000000000000000010000000000 : slv_ip2bus_data <= slv_reg47;
        58'b0000000000000000000000000000000000000000000000001000000000 : slv_ip2bus_data <= slv_reg48;
        58'b0000000000000000000000000000000000000000000000000100000000 : slv_ip2bus_data <= slv_reg49;
        58'b0000000000000000000000000000000000000000000000000010000000 : slv_ip2bus_data <= slv_reg50;
        58'b0000000000000000000000000000000000000000000000000001000000 : slv_ip2bus_data <= slv_reg51;
        58'b0000000000000000000000000000000000000000000000000000100000 : slv_ip2bus_data <= slv_reg52;
        58'b0000000000000000000000000000000000000000000000000000010000 : slv_ip2bus_data <= slv_reg53;
        58'b0000000000000000000000000000000000000000000000000000001000 : slv_ip2bus_data <= slv_reg54;
        58'b0000000000000000000000000000000000000000000000000000000100 : slv_ip2bus_data <= slv_reg55;
        58'b0000000000000000000000000000000000000000000000000000000010 : slv_ip2bus_data <= slv_reg56;
        58'b0000000000000000000000000000000000000000000000000000000001 : slv_ip2bus_data <= slv_reg57;
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
