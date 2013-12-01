/*****************************************************************************
* Filename:          /home/jheckey/Dropbox/homework/ece253/spartan_tetris/drivers/tetris_vga_v1_00_a/src/tetris_vga.c
* Version:           1.00.a
* Description:       tetris_vga Driver Source File
* Date:              Thu Nov 21 14:01:34 2013 (by Create and Import Peripheral Wizard)
*****************************************************************************/


/***************************** Include Files *******************************/

#include "tetris_vga.h"

/************************** Function Definitions ***************************/

/**
 *
 * Enable all possible interrupts from TETRIS_VGA device.
 *
 * @param   baseaddr_p is the base address of the TETRIS_VGA device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void TETRIS_VGA_EnableInterrupt(void * baseaddr_p)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Enable all interrupt source from user logic.
   */
  TETRIS_VGA_mWriteReg(baseaddr, TETRIS_VGA_INTR_IPIER_OFFSET, 0x00000001);

  /*
   * Enable all possible interrupt sources from device.
   */
  TETRIS_VGA_mWriteReg(baseaddr, TETRIS_VGA_INTR_DIER_OFFSET,
    INTR_TERR_MASK
    | INTR_DPTO_MASK
    | INTR_IPIR_MASK
    );

  /*
   * Set global interrupt enable.
   */
  TETRIS_VGA_mWriteReg(baseaddr, TETRIS_VGA_INTR_DGIER_OFFSET, INTR_GIE_MASK);
}

/**
 *
 * Example interrupt controller handler for TETRIS_VGA device.
 * This is to show example of how to toggle write back ISR to clear interrupts.
 *
 * @param   baseaddr_p is the base address of the TETRIS_VGA device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void TETRIS_VGA_Intr_DefaultHandler(void * baseaddr_p)
{
  Xuint32 baseaddr;
  Xuint32 IntrStatus;
  Xuint32 IpStatus;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Get status from Device Interrupt Status Register.
   */
  IntrStatus = TETRIS_VGA_mReadReg(baseaddr, TETRIS_VGA_INTR_DISR_OFFSET);

  xil_printf("Device Interrupt! DISR value : 0x%08x \n\r", IntrStatus);

  /*
   * Verify the source of the interrupt is the user logic and clear the interrupt
   * source by toggle write baca to the IP ISR register.
   */
  if ( (IntrStatus & INTR_IPIR_MASK) == INTR_IPIR_MASK )
  {
    xil_printf("User logic interrupt! \n\r");
    IpStatus = TETRIS_VGA_mReadReg(baseaddr, TETRIS_VGA_INTR_IPISR_OFFSET);
    TETRIS_VGA_mWriteReg(baseaddr, TETRIS_VGA_INTR_IPISR_OFFSET, IpStatus);
  }

}

