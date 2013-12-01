/*****************************************************************************
* Filename:          /home/jheckey/Dropbox/homework/ece253/spartan_tetris/tetris_cpu/drivers/click_rot_enc_v1_00_a/src/click_rot_enc.h
* Version:           1.00.a
* Description:       click_rot_enc Driver Header File
* Date:              Sat Nov 30 11:22:31 2013 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef CLICK_ROT_ENC_H
#define CLICK_ROT_ENC_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xil_io.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLV_REG0 : user logic slave module register 0
 */
#define CLICK_ROT_ENC_USER_SLV_SPACE_OFFSET (0x00000000)
#define CLICK_ROT_ENC_SLV_REG0_OFFSET (CLICK_ROT_ENC_USER_SLV_SPACE_OFFSET + 0x00000000)

/**
 * Interrupt Controller Space Offsets
 * -- INTR_DISR  : device (peripheral) interrupt status register
 * -- INTR_DIPR  : device (peripheral) interrupt pending register
 * -- INTR_DIER  : device (peripheral) interrupt enable register
 * -- INTR_DIIR  : device (peripheral) interrupt id (priority encoder) register
 * -- INTR_DGIER : device (peripheral) global interrupt enable register
 * -- INTR_ISR   : ip (user logic) interrupt status register
 * -- INTR_IER   : ip (user logic) interrupt enable register
 */
#define CLICK_ROT_ENC_INTR_CNTRL_SPACE_OFFSET (0x00000100)
#define CLICK_ROT_ENC_INTR_DISR_OFFSET (CLICK_ROT_ENC_INTR_CNTRL_SPACE_OFFSET + 0x00000000)
#define CLICK_ROT_ENC_INTR_DIPR_OFFSET (CLICK_ROT_ENC_INTR_CNTRL_SPACE_OFFSET + 0x00000004)
#define CLICK_ROT_ENC_INTR_DIER_OFFSET (CLICK_ROT_ENC_INTR_CNTRL_SPACE_OFFSET + 0x00000008)
#define CLICK_ROT_ENC_INTR_DIIR_OFFSET (CLICK_ROT_ENC_INTR_CNTRL_SPACE_OFFSET + 0x00000018)
#define CLICK_ROT_ENC_INTR_DGIER_OFFSET (CLICK_ROT_ENC_INTR_CNTRL_SPACE_OFFSET + 0x0000001C)
#define CLICK_ROT_ENC_INTR_IPISR_OFFSET (CLICK_ROT_ENC_INTR_CNTRL_SPACE_OFFSET + 0x00000020)
#define CLICK_ROT_ENC_INTR_IPIER_OFFSET (CLICK_ROT_ENC_INTR_CNTRL_SPACE_OFFSET + 0x00000028)

/**
 * Interrupt Controller Masks
 * -- INTR_TERR_MASK : transaction error
 * -- INTR_DPTO_MASK : data phase time-out
 * -- INTR_IPIR_MASK : ip interrupt requeset
 * -- INTR_RFDL_MASK : read packet fifo deadlock interrupt request
 * -- INTR_WFDL_MASK : write packet fifo deadlock interrupt request
 * -- INTR_IID_MASK  : interrupt id
 * -- INTR_GIE_MASK  : global interrupt enable
 * -- INTR_NOPEND    : the DIPR has no pending interrupts
 */
#define INTR_TERR_MASK (0x00000001UL)
#define INTR_DPTO_MASK (0x00000002UL)
#define INTR_IPIR_MASK (0x00000004UL)
#define INTR_RFDL_MASK (0x00000020UL)
#define INTR_WFDL_MASK (0x00000040UL)
#define INTR_IID_MASK (0x000000FFUL)
#define INTR_GIE_MASK (0x80000000UL)
#define INTR_NOPEND (0x80)

/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a CLICK_ROT_ENC register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the CLICK_ROT_ENC device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void CLICK_ROT_ENC_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define CLICK_ROT_ENC_mWriteReg(BaseAddress, RegOffset, Data) \
 	Xil_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a CLICK_ROT_ENC register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the CLICK_ROT_ENC device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 CLICK_ROT_ENC_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define CLICK_ROT_ENC_mReadReg(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from CLICK_ROT_ENC user logic slave registers.
 *
 * @param   BaseAddress is the base address of the CLICK_ROT_ENC device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void CLICK_ROT_ENC_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 CLICK_ROT_ENC_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define CLICK_ROT_ENC_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (CLICK_ROT_ENC_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))

#define CLICK_ROT_ENC_mReadSlaveReg0(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (CLICK_ROT_ENC_SLV_REG0_OFFSET) + (RegOffset))

/************************** Function Prototypes ****************************/


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
void CLICK_ROT_ENC_EnableInterrupt(void * baseaddr_p);

/**
 *
 * Example interrupt controller handler.
 *
 * @param   baseaddr_p is the base address of the CLICK_ROT_ENC device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void CLICK_ROT_ENC_Intr_DefaultHandler(void * baseaddr_p);

/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the CLICK_ROT_ENC instance to be worked on.
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
XStatus CLICK_ROT_ENC_SelfTest(void * baseaddr_p);

#endif /** CLICK_ROT_ENC_H */
