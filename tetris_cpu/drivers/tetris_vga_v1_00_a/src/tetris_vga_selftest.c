/*****************************************************************************
* Filename:          /home/jheckey/Dropbox/homework/ece253/spartan_tetris/tetris_cpu/drivers/tetris_vga_v1_00_a/src/tetris_vga_selftest.c
* Version:           1.00.a
* Description:       Contains a diagnostic self-test function for the tetris_vga driver
* Date:              Sat Nov 23 12:11:38 2013 (by Create and Import Peripheral Wizard)
*****************************************************************************/


/***************************** Include Files *******************************/

#include "tetris_vga.h"

/************************** Constant Definitions ***************************/


/************************** Variable Definitions ****************************/


/************************** Function Definitions ***************************/

/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the TETRIS_VGA instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus TETRIS_VGA_SelfTest(void * baseaddr_p)
{
  int     Index;
  Xuint32 baseaddr;
  Xuint8  Reg8Value;
  Xuint16 Reg16Value;
  Xuint32 Reg32Value;
  
  /*
   * Check and get the device address
   */
  /*
   * Base Address maybe 0. Up to developer to uncomment line below.
  XASSERT_NONVOID(baseaddr_p != XNULL);
   */
  baseaddr = (Xuint32) baseaddr_p;

  xil_printf("******************************\n\r");
  xil_printf("* User Peripheral Self Test\n\r");
  xil_printf("******************************\n\n\r");

  /*
   * Reset the device to get it back to the default state
   */
  xil_printf("Soft reset test...\n\r");
  TETRIS_VGA_mReset(baseaddr);
  xil_printf("   - write 0x%08x to software reset register\n\r", SOFT_RESET);
  xil_printf("   - soft reset passed\n\n\r");

  /*
   * Write to user logic slave module register(s) and read back
   */
  xil_printf("User logic slave module test...\n\r");
  xil_printf("   - write 1 to slave register 0 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg0(baseaddr, 0, 1);
  Reg32Value = TETRIS_VGA_mReadSlaveReg0(baseaddr, 0);
  xil_printf("   - read %d from register 0 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 1 )
  {
    xil_printf("   - slave register 0 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 2 to slave register 1 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg1(baseaddr, 0, 2);
  Reg32Value = TETRIS_VGA_mReadSlaveReg1(baseaddr, 0);
  xil_printf("   - read %d from register 1 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 2 )
  {
    xil_printf("   - slave register 1 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 3 to slave register 2 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg2(baseaddr, 0, 3);
  Reg32Value = TETRIS_VGA_mReadSlaveReg2(baseaddr, 0);
  xil_printf("   - read %d from register 2 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 3 )
  {
    xil_printf("   - slave register 2 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 4 to slave register 3 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg3(baseaddr, 0, 4);
  Reg32Value = TETRIS_VGA_mReadSlaveReg3(baseaddr, 0);
  xil_printf("   - read %d from register 3 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 4 )
  {
    xil_printf("   - slave register 3 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 5 to slave register 4 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg4(baseaddr, 0, 5);
  Reg32Value = TETRIS_VGA_mReadSlaveReg4(baseaddr, 0);
  xil_printf("   - read %d from register 4 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 5 )
  {
    xil_printf("   - slave register 4 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 6 to slave register 5 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg5(baseaddr, 0, 6);
  Reg32Value = TETRIS_VGA_mReadSlaveReg5(baseaddr, 0);
  xil_printf("   - read %d from register 5 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 6 )
  {
    xil_printf("   - slave register 5 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 7 to slave register 6 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg6(baseaddr, 0, 7);
  Reg32Value = TETRIS_VGA_mReadSlaveReg6(baseaddr, 0);
  xil_printf("   - read %d from register 6 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 7 )
  {
    xil_printf("   - slave register 6 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 8 to slave register 7 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg7(baseaddr, 0, 8);
  Reg32Value = TETRIS_VGA_mReadSlaveReg7(baseaddr, 0);
  xil_printf("   - read %d from register 7 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 8 )
  {
    xil_printf("   - slave register 7 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 9 to slave register 8 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg8(baseaddr, 0, 9);
  Reg32Value = TETRIS_VGA_mReadSlaveReg8(baseaddr, 0);
  xil_printf("   - read %d from register 8 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 9 )
  {
    xil_printf("   - slave register 8 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 10 to slave register 9 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg9(baseaddr, 0, 10);
  Reg32Value = TETRIS_VGA_mReadSlaveReg9(baseaddr, 0);
  xil_printf("   - read %d from register 9 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 10 )
  {
    xil_printf("   - slave register 9 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 11 to slave register 10 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg10(baseaddr, 0, 11);
  Reg32Value = TETRIS_VGA_mReadSlaveReg10(baseaddr, 0);
  xil_printf("   - read %d from register 10 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 11 )
  {
    xil_printf("   - slave register 10 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 12 to slave register 11 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg11(baseaddr, 0, 12);
  Reg32Value = TETRIS_VGA_mReadSlaveReg11(baseaddr, 0);
  xil_printf("   - read %d from register 11 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 12 )
  {
    xil_printf("   - slave register 11 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 13 to slave register 12 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg12(baseaddr, 0, 13);
  Reg32Value = TETRIS_VGA_mReadSlaveReg12(baseaddr, 0);
  xil_printf("   - read %d from register 12 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 13 )
  {
    xil_printf("   - slave register 12 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 14 to slave register 13 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg13(baseaddr, 0, 14);
  Reg32Value = TETRIS_VGA_mReadSlaveReg13(baseaddr, 0);
  xil_printf("   - read %d from register 13 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 14 )
  {
    xil_printf("   - slave register 13 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 15 to slave register 14 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg14(baseaddr, 0, 15);
  Reg32Value = TETRIS_VGA_mReadSlaveReg14(baseaddr, 0);
  xil_printf("   - read %d from register 14 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 15 )
  {
    xil_printf("   - slave register 14 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 16 to slave register 15 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg15(baseaddr, 0, 16);
  Reg32Value = TETRIS_VGA_mReadSlaveReg15(baseaddr, 0);
  xil_printf("   - read %d from register 15 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 16 )
  {
    xil_printf("   - slave register 15 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 17 to slave register 16 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg16(baseaddr, 0, 17);
  Reg32Value = TETRIS_VGA_mReadSlaveReg16(baseaddr, 0);
  xil_printf("   - read %d from register 16 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 17 )
  {
    xil_printf("   - slave register 16 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 18 to slave register 17 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg17(baseaddr, 0, 18);
  Reg32Value = TETRIS_VGA_mReadSlaveReg17(baseaddr, 0);
  xil_printf("   - read %d from register 17 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 18 )
  {
    xil_printf("   - slave register 17 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 19 to slave register 18 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg18(baseaddr, 0, 19);
  Reg32Value = TETRIS_VGA_mReadSlaveReg18(baseaddr, 0);
  xil_printf("   - read %d from register 18 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 19 )
  {
    xil_printf("   - slave register 18 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 20 to slave register 19 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg19(baseaddr, 0, 20);
  Reg32Value = TETRIS_VGA_mReadSlaveReg19(baseaddr, 0);
  xil_printf("   - read %d from register 19 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 20 )
  {
    xil_printf("   - slave register 19 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 21 to slave register 20 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg20(baseaddr, 0, 21);
  Reg32Value = TETRIS_VGA_mReadSlaveReg20(baseaddr, 0);
  xil_printf("   - read %d from register 20 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 21 )
  {
    xil_printf("   - slave register 20 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 22 to slave register 21 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg21(baseaddr, 0, 22);
  Reg32Value = TETRIS_VGA_mReadSlaveReg21(baseaddr, 0);
  xil_printf("   - read %d from register 21 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 22 )
  {
    xil_printf("   - slave register 21 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 23 to slave register 22 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg22(baseaddr, 0, 23);
  Reg32Value = TETRIS_VGA_mReadSlaveReg22(baseaddr, 0);
  xil_printf("   - read %d from register 22 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 23 )
  {
    xil_printf("   - slave register 22 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 24 to slave register 23 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg23(baseaddr, 0, 24);
  Reg32Value = TETRIS_VGA_mReadSlaveReg23(baseaddr, 0);
  xil_printf("   - read %d from register 23 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 24 )
  {
    xil_printf("   - slave register 23 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 25 to slave register 24 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg24(baseaddr, 0, 25);
  Reg32Value = TETRIS_VGA_mReadSlaveReg24(baseaddr, 0);
  xil_printf("   - read %d from register 24 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 25 )
  {
    xil_printf("   - slave register 24 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 26 to slave register 25 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg25(baseaddr, 0, 26);
  Reg32Value = TETRIS_VGA_mReadSlaveReg25(baseaddr, 0);
  xil_printf("   - read %d from register 25 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 26 )
  {
    xil_printf("   - slave register 25 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 27 to slave register 26 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg26(baseaddr, 0, 27);
  Reg32Value = TETRIS_VGA_mReadSlaveReg26(baseaddr, 0);
  xil_printf("   - read %d from register 26 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 27 )
  {
    xil_printf("   - slave register 26 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 28 to slave register 27 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg27(baseaddr, 0, 28);
  Reg32Value = TETRIS_VGA_mReadSlaveReg27(baseaddr, 0);
  xil_printf("   - read %d from register 27 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 28 )
  {
    xil_printf("   - slave register 27 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 29 to slave register 28 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg28(baseaddr, 0, 29);
  Reg32Value = TETRIS_VGA_mReadSlaveReg28(baseaddr, 0);
  xil_printf("   - read %d from register 28 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 29 )
  {
    xil_printf("   - slave register 28 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 30 to slave register 29 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg29(baseaddr, 0, 30);
  Reg32Value = TETRIS_VGA_mReadSlaveReg29(baseaddr, 0);
  xil_printf("   - read %d from register 29 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 30 )
  {
    xil_printf("   - slave register 29 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 31 to slave register 30 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg30(baseaddr, 0, 31);
  Reg32Value = TETRIS_VGA_mReadSlaveReg30(baseaddr, 0);
  xil_printf("   - read %d from register 30 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 31 )
  {
    xil_printf("   - slave register 30 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 32 to slave register 31 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg31(baseaddr, 0, 32);
  Reg32Value = TETRIS_VGA_mReadSlaveReg31(baseaddr, 0);
  xil_printf("   - read %d from register 31 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 32 )
  {
    xil_printf("   - slave register 31 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 33 to slave register 32 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg32(baseaddr, 0, 33);
  Reg32Value = TETRIS_VGA_mReadSlaveReg32(baseaddr, 0);
  xil_printf("   - read %d from register 32 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 33 )
  {
    xil_printf("   - slave register 32 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 34 to slave register 33 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg33(baseaddr, 0, 34);
  Reg32Value = TETRIS_VGA_mReadSlaveReg33(baseaddr, 0);
  xil_printf("   - read %d from register 33 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 34 )
  {
    xil_printf("   - slave register 33 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 35 to slave register 34 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg34(baseaddr, 0, 35);
  Reg32Value = TETRIS_VGA_mReadSlaveReg34(baseaddr, 0);
  xil_printf("   - read %d from register 34 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 35 )
  {
    xil_printf("   - slave register 34 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 36 to slave register 35 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg35(baseaddr, 0, 36);
  Reg32Value = TETRIS_VGA_mReadSlaveReg35(baseaddr, 0);
  xil_printf("   - read %d from register 35 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 36 )
  {
    xil_printf("   - slave register 35 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 37 to slave register 36 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg36(baseaddr, 0, 37);
  Reg32Value = TETRIS_VGA_mReadSlaveReg36(baseaddr, 0);
  xil_printf("   - read %d from register 36 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 37 )
  {
    xil_printf("   - slave register 36 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 38 to slave register 37 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg37(baseaddr, 0, 38);
  Reg32Value = TETRIS_VGA_mReadSlaveReg37(baseaddr, 0);
  xil_printf("   - read %d from register 37 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 38 )
  {
    xil_printf("   - slave register 37 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 39 to slave register 38 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg38(baseaddr, 0, 39);
  Reg32Value = TETRIS_VGA_mReadSlaveReg38(baseaddr, 0);
  xil_printf("   - read %d from register 38 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 39 )
  {
    xil_printf("   - slave register 38 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 40 to slave register 39 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg39(baseaddr, 0, 40);
  Reg32Value = TETRIS_VGA_mReadSlaveReg39(baseaddr, 0);
  xil_printf("   - read %d from register 39 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 40 )
  {
    xil_printf("   - slave register 39 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 41 to slave register 40 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg40(baseaddr, 0, 41);
  Reg32Value = TETRIS_VGA_mReadSlaveReg40(baseaddr, 0);
  xil_printf("   - read %d from register 40 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 41 )
  {
    xil_printf("   - slave register 40 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 42 to slave register 41 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg41(baseaddr, 0, 42);
  Reg32Value = TETRIS_VGA_mReadSlaveReg41(baseaddr, 0);
  xil_printf("   - read %d from register 41 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 42 )
  {
    xil_printf("   - slave register 41 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 43 to slave register 42 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg42(baseaddr, 0, 43);
  Reg32Value = TETRIS_VGA_mReadSlaveReg42(baseaddr, 0);
  xil_printf("   - read %d from register 42 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 43 )
  {
    xil_printf("   - slave register 42 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 44 to slave register 43 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg43(baseaddr, 0, 44);
  Reg32Value = TETRIS_VGA_mReadSlaveReg43(baseaddr, 0);
  xil_printf("   - read %d from register 43 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 44 )
  {
    xil_printf("   - slave register 43 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 45 to slave register 44 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg44(baseaddr, 0, 45);
  Reg32Value = TETRIS_VGA_mReadSlaveReg44(baseaddr, 0);
  xil_printf("   - read %d from register 44 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 45 )
  {
    xil_printf("   - slave register 44 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 46 to slave register 45 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg45(baseaddr, 0, 46);
  Reg32Value = TETRIS_VGA_mReadSlaveReg45(baseaddr, 0);
  xil_printf("   - read %d from register 45 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 46 )
  {
    xil_printf("   - slave register 45 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 47 to slave register 46 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg46(baseaddr, 0, 47);
  Reg32Value = TETRIS_VGA_mReadSlaveReg46(baseaddr, 0);
  xil_printf("   - read %d from register 46 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 47 )
  {
    xil_printf("   - slave register 46 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 48 to slave register 47 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg47(baseaddr, 0, 48);
  Reg32Value = TETRIS_VGA_mReadSlaveReg47(baseaddr, 0);
  xil_printf("   - read %d from register 47 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 48 )
  {
    xil_printf("   - slave register 47 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 49 to slave register 48 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg48(baseaddr, 0, 49);
  Reg32Value = TETRIS_VGA_mReadSlaveReg48(baseaddr, 0);
  xil_printf("   - read %d from register 48 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 49 )
  {
    xil_printf("   - slave register 48 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 50 to slave register 49 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg49(baseaddr, 0, 50);
  Reg32Value = TETRIS_VGA_mReadSlaveReg49(baseaddr, 0);
  xil_printf("   - read %d from register 49 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 50 )
  {
    xil_printf("   - slave register 49 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 51 to slave register 50 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg50(baseaddr, 0, 51);
  Reg32Value = TETRIS_VGA_mReadSlaveReg50(baseaddr, 0);
  xil_printf("   - read %d from register 50 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 51 )
  {
    xil_printf("   - slave register 50 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 52 to slave register 51 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg51(baseaddr, 0, 52);
  Reg32Value = TETRIS_VGA_mReadSlaveReg51(baseaddr, 0);
  xil_printf("   - read %d from register 51 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 52 )
  {
    xil_printf("   - slave register 51 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 53 to slave register 52 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg52(baseaddr, 0, 53);
  Reg32Value = TETRIS_VGA_mReadSlaveReg52(baseaddr, 0);
  xil_printf("   - read %d from register 52 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 53 )
  {
    xil_printf("   - slave register 52 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 54 to slave register 53 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg53(baseaddr, 0, 54);
  Reg32Value = TETRIS_VGA_mReadSlaveReg53(baseaddr, 0);
  xil_printf("   - read %d from register 53 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 54 )
  {
    xil_printf("   - slave register 53 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 55 to slave register 54 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg54(baseaddr, 0, 55);
  Reg32Value = TETRIS_VGA_mReadSlaveReg54(baseaddr, 0);
  xil_printf("   - read %d from register 54 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 55 )
  {
    xil_printf("   - slave register 54 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 56 to slave register 55 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg55(baseaddr, 0, 56);
  Reg32Value = TETRIS_VGA_mReadSlaveReg55(baseaddr, 0);
  xil_printf("   - read %d from register 55 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 56 )
  {
    xil_printf("   - slave register 55 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 57 to slave register 56 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg56(baseaddr, 0, 57);
  Reg32Value = TETRIS_VGA_mReadSlaveReg56(baseaddr, 0);
  xil_printf("   - read %d from register 56 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 57 )
  {
    xil_printf("   - slave register 56 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 58 to slave register 57 word 0\n\r");
  TETRIS_VGA_mWriteSlaveReg57(baseaddr, 0, 58);
  Reg32Value = TETRIS_VGA_mReadSlaveReg57(baseaddr, 0);
  xil_printf("   - read %d from register 57 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 58 )
  {
    xil_printf("   - slave register 57 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - slave register write/read passed\n\n\r");

  /*
   * Enable all possible interrupts and clear interrupt status register(s)
   */
  xil_printf("Interrupt controller test...\n\r");
  Reg32Value = TETRIS_VGA_mReadReg(baseaddr, TETRIS_VGA_INTR_IPISR_OFFSET);
  xil_printf("   - IP (user logic) interrupt status : 0x%08x\n\r", Reg32Value);
  xil_printf("   - clear IP (user logic) interrupt status register\n\r");
  TETRIS_VGA_mWriteReg(baseaddr, TETRIS_VGA_INTR_IPISR_OFFSET, Reg32Value);
  Reg32Value = TETRIS_VGA_mReadReg(baseaddr, TETRIS_VGA_INTR_DISR_OFFSET);
  xil_printf("   - Device (peripheral) interrupt status : 0x%08x\n\r", Reg32Value);
  xil_printf("   - clear Device (peripheral) interrupt status register\n\r");
  TETRIS_VGA_mWriteReg(baseaddr, TETRIS_VGA_INTR_DISR_OFFSET, Reg32Value);
  xil_printf("   - enable all possible interrupt(s)\n\r");
  TETRIS_VGA_EnableInterrupt(baseaddr_p);
  xil_printf("   - write/read interrupt register passed\n\n\r");

  return XST_SUCCESS;
}
