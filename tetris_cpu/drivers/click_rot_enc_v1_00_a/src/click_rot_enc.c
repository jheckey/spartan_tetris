/*****************************************************************************
* Filename:          /home/jheckey/Dropbox/homework/ece253/spartan_tetris/tetris_cpu/drivers/click_rot_enc_v1_00_a/src/click_rot_enc.c
* Version:           1.00.a
* Description:       click_rot_enc Driver Source File
* Date:              Sat Nov 30 11:22:31 2013 (by Create and Import Peripheral Wizard)
*****************************************************************************/


/***************************** Include Files *******************************/

#include "click_rot_enc.h"

/************************** Function Definitions ***************************/

/**
 *
 * Enable all possible interrupts from CLICK_ROT_ENC device.
 *
 * @param   baseaddr_p is the base address of the CLICK_ROT_ENC device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void CLICK_ROT_ENC_EnableInterrupt(void * baseaddr_p)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Enable all interrupt source from user logic.
   */
  CLICK_ROT_ENC_mWriteReg(baseaddr, CLICK_ROT_ENC_INTR_IPIER_OFFSET, 0x00000001);

  /*
   * Enable all possible interrupt sources from device.
   */
  CLICK_ROT_ENC_mWriteReg(baseaddr, CLICK_ROT_ENC_INTR_DIER_OFFSET,
    INTR_TERR_MASK
    | INTR_DPTO_MASK
    | INTR_IPIR_MASK
    );

  /*
   * Set global interrupt enable.
   */
  CLICK_ROT_ENC_mWriteReg(baseaddr, CLICK_ROT_ENC_INTR_DGIER_OFFSET, INTR_GIE_MASK);
}

/**
 *
 * Example interrupt controller handler for CLICK_ROT_ENC device.
 * This is to show example of how to toggle write back ISR to clear interrupts.
 *
 * @param   baseaddr_p is the base address of the CLICK_ROT_ENC device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void CLICK_ROT_ENC_Intr_DefaultHandler(void * baseaddr_p)
{
  Xuint32 baseaddr;
  Xuint32 IntrStatus;
Xuint32 IpStatus;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Get status from Device Interrupt Status Register.
   */
  IntrStatus = CLICK_ROT_ENC_mReadReg(baseaddr, CLICK_ROT_ENC_INTR_DISR_OFFSET);

  xil_printf("Device Interrupt! DISR value : 0x%08x \n\r", IntrStatus);

  /*
   * Verify the source of the interrupt is the user logic and clear the interrupt
   * source by toggle write baca to the IP ISR register.
   */
  if ( (IntrStatus & INTR_IPIR_MASK) == INTR_IPIR_MASK )
  {
    xil_printf("User logic interrupt! \n\r");
    IpStatus = CLICK_ROT_ENC_mReadReg(baseaddr, CLICK_ROT_ENC_INTR_IPISR_OFFSET);
    CLICK_ROT_ENC_mWriteReg(baseaddr, CLICK_ROT_ENC_INTR_IPISR_OFFSET, IpStatus);
  }

}

