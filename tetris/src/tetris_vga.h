/*****************************************************************************
* Filename:          /home/jheckey/Dropbox/homework/ece253/spartan_tetris/drivers/tetris_vga_v1_00_a/src/tetris_vga.h
* Version:           1.00.a
* Description:       tetris_vga Driver Header File
* Date:              Thu Nov 21 14:01:34 2013 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef TETRIS_VGA_H
#define TETRIS_VGA_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xil_io.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLV_REG0 : user logic slave module register 0
 * -- SLV_REG1 : user logic slave module register 1
 * -- SLV_REG2 : user logic slave module register 2
 * -- SLV_REG3 : user logic slave module register 3
 * -- SLV_REG4 : user logic slave module register 4
 * -- SLV_REG5 : user logic slave module register 5
 * -- SLV_REG6 : user logic slave module register 6
 * -- SLV_REG7 : user logic slave module register 7
 * -- SLV_REG8 : user logic slave module register 8
 * -- SLV_REG9 : user logic slave module register 9
 * -- SLV_REG10 : user logic slave module register 10
 * -- SLV_REG11 : user logic slave module register 11
 * -- SLV_REG12 : user logic slave module register 12
 * -- SLV_REG13 : user logic slave module register 13
 * -- SLV_REG14 : user logic slave module register 14
 * -- SLV_REG15 : user logic slave module register 15
 * -- SLV_REG16 : user logic slave module register 16
 * -- SLV_REG17 : user logic slave module register 17
 * -- SLV_REG18 : user logic slave module register 18
 * -- SLV_REG19 : user logic slave module register 19
 * -- SLV_REG20 : user logic slave module register 20
 * -- SLV_REG21 : user logic slave module register 21
 * -- SLV_REG22 : user logic slave module register 22
 * -- SLV_REG23 : user logic slave module register 23
 * -- SLV_REG24 : user logic slave module register 24
 * -- SLV_REG25 : user logic slave module register 25
 * -- SLV_REG26 : user logic slave module register 26
 * -- SLV_REG27 : user logic slave module register 27
 * -- SLV_REG28 : user logic slave module register 28
 * -- SLV_REG29 : user logic slave module register 29
 * -- SLV_REG30 : user logic slave module register 30
 * -- SLV_REG31 : user logic slave module register 31
 * -- SLV_REG32 : user logic slave module register 32
 * -- SLV_REG33 : user logic slave module register 33
 * -- SLV_REG34 : user logic slave module register 34
 * -- SLV_REG35 : user logic slave module register 35
 * -- SLV_REG36 : user logic slave module register 36
 * -- SLV_REG37 : user logic slave module register 37
 * -- SLV_REG38 : user logic slave module register 38
 * -- SLV_REG39 : user logic slave module register 39
 * -- SLV_REG40 : user logic slave module register 40
 * -- SLV_REG41 : user logic slave module register 41
 * -- SLV_REG42 : user logic slave module register 42
 * -- SLV_REG43 : user logic slave module register 43
 * -- SLV_REG44 : user logic slave module register 44
 * -- SLV_REG45 : user logic slave module register 45
 * -- SLV_REG46 : user logic slave module register 46
 * -- SLV_REG47 : user logic slave module register 47
 * -- SLV_REG48 : user logic slave module register 48
 * -- SLV_REG49 : user logic slave module register 49
 * -- SLV_REG50 : user logic slave module register 50
 * -- SLV_REG51 : user logic slave module register 51
 * -- SLV_REG52 : user logic slave module register 52
 * -- SLV_REG53 : user logic slave module register 53
 * -- SLV_REG54 : user logic slave module register 54
 * -- SLV_REG55 : user logic slave module register 55
 */
#define TETRIS_VGA_USER_SLV_SPACE_OFFSET (0x00000000)
#define TETRIS_VGA_SLV_REG0_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000000)
#define TETRIS_VGA_SLV_REG1_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000004)
#define TETRIS_VGA_SLV_REG2_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000008)
#define TETRIS_VGA_SLV_REG3_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x0000000C)
#define TETRIS_VGA_SLV_REG4_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000010)
#define TETRIS_VGA_SLV_REG5_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000014)
#define TETRIS_VGA_SLV_REG6_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000018)
#define TETRIS_VGA_SLV_REG7_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x0000001C)
#define TETRIS_VGA_SLV_REG8_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000020)
#define TETRIS_VGA_SLV_REG9_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000024)
#define TETRIS_VGA_SLV_REG10_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000028)
#define TETRIS_VGA_SLV_REG11_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x0000002C)
#define TETRIS_VGA_SLV_REG12_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000030)
#define TETRIS_VGA_SLV_REG13_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000034)
#define TETRIS_VGA_SLV_REG14_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000038)
#define TETRIS_VGA_SLV_REG15_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x0000003C)
#define TETRIS_VGA_SLV_REG16_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000040)
#define TETRIS_VGA_SLV_REG17_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000044)
#define TETRIS_VGA_SLV_REG18_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000048)
#define TETRIS_VGA_SLV_REG19_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x0000004C)
#define TETRIS_VGA_SLV_REG20_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000050)
#define TETRIS_VGA_SLV_REG21_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000054)
#define TETRIS_VGA_SLV_REG22_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000058)
#define TETRIS_VGA_SLV_REG23_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x0000005C)
#define TETRIS_VGA_SLV_REG24_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000060)
#define TETRIS_VGA_SLV_REG25_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000064)
#define TETRIS_VGA_SLV_REG26_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000068)
#define TETRIS_VGA_SLV_REG27_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x0000006C)
#define TETRIS_VGA_SLV_REG28_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000070)
#define TETRIS_VGA_SLV_REG29_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000074)
#define TETRIS_VGA_SLV_REG30_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000078)
#define TETRIS_VGA_SLV_REG31_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x0000007C)
#define TETRIS_VGA_SLV_REG32_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000080)
#define TETRIS_VGA_SLV_REG33_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000084)
#define TETRIS_VGA_SLV_REG34_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000088)
#define TETRIS_VGA_SLV_REG35_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x0000008C)
#define TETRIS_VGA_SLV_REG36_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000090)
#define TETRIS_VGA_SLV_REG37_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000094)
#define TETRIS_VGA_SLV_REG38_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x00000098)
#define TETRIS_VGA_SLV_REG39_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x0000009C)
#define TETRIS_VGA_SLV_REG40_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000A0)
#define TETRIS_VGA_SLV_REG41_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000A4)
#define TETRIS_VGA_SLV_REG42_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000A8)
#define TETRIS_VGA_SLV_REG43_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000AC)
#define TETRIS_VGA_SLV_REG44_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000B0)
#define TETRIS_VGA_SLV_REG45_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000B4)
#define TETRIS_VGA_SLV_REG46_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000B8)
#define TETRIS_VGA_SLV_REG47_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000BC)
#define TETRIS_VGA_SLV_REG48_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000C0)
#define TETRIS_VGA_SLV_REG49_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000C4)
#define TETRIS_VGA_SLV_REG50_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000C8)
#define TETRIS_VGA_SLV_REG51_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000CC)
#define TETRIS_VGA_SLV_REG52_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000D0)
#define TETRIS_VGA_SLV_REG53_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000D4)
#define TETRIS_VGA_SLV_REG54_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000D8)
#define TETRIS_VGA_SLV_REG55_OFFSET (TETRIS_VGA_USER_SLV_SPACE_OFFSET + 0x000000DC)

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
#define TETRIS_VGA_INTR_CNTRL_SPACE_OFFSET (0x00000200)
#define TETRIS_VGA_INTR_DISR_OFFSET (TETRIS_VGA_INTR_CNTRL_SPACE_OFFSET + 0x00000000)
#define TETRIS_VGA_INTR_DIPR_OFFSET (TETRIS_VGA_INTR_CNTRL_SPACE_OFFSET + 0x00000004)
#define TETRIS_VGA_INTR_DIER_OFFSET (TETRIS_VGA_INTR_CNTRL_SPACE_OFFSET + 0x00000008)
#define TETRIS_VGA_INTR_DIIR_OFFSET (TETRIS_VGA_INTR_CNTRL_SPACE_OFFSET + 0x00000018)
#define TETRIS_VGA_INTR_DGIER_OFFSET (TETRIS_VGA_INTR_CNTRL_SPACE_OFFSET + 0x0000001C)
#define TETRIS_VGA_INTR_IPISR_OFFSET (TETRIS_VGA_INTR_CNTRL_SPACE_OFFSET + 0x00000020)
#define TETRIS_VGA_INTR_IPIER_OFFSET (TETRIS_VGA_INTR_CNTRL_SPACE_OFFSET + 0x00000028)

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
 * Write a value to a TETRIS_VGA register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the TETRIS_VGA device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void TETRIS_VGA_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define TETRIS_VGA_mWriteReg(BaseAddress, RegOffset, Data) \
 	Xil_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a TETRIS_VGA register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the TETRIS_VGA device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 TETRIS_VGA_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define TETRIS_VGA_mReadReg(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from TETRIS_VGA user logic slave registers.
 *
 * @param   BaseAddress is the base address of the TETRIS_VGA device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void TETRIS_VGA_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 TETRIS_VGA_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define TETRIS_VGA_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg1(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG1_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg2(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG2_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg3(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG3_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg4(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG4_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg5(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG5_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg6(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG6_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg7(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG7_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg8(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG8_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg9(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG9_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg10(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG10_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg11(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG11_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg12(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG12_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg13(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG13_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg14(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG14_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg15(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG15_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg16(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG16_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg17(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG17_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg18(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG18_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg19(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG19_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg20(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG20_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg21(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG21_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg22(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG22_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg23(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG23_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg24(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG24_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg25(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG25_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg26(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG26_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg27(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG27_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg28(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG28_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg29(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG29_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg30(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG30_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg31(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG31_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg32(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG32_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg33(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG33_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg34(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG34_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg35(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG35_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg36(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG36_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg37(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG37_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg38(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG38_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg39(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG39_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg40(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG40_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg41(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG41_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg42(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG42_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg43(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG43_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg44(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG44_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg45(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG45_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg46(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG46_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg47(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG47_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg48(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG48_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg49(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG49_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg50(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG50_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg51(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG51_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg52(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG52_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg53(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG53_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg54(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG54_OFFSET) + (RegOffset), (Xuint32)(Value))
#define TETRIS_VGA_mWriteSlaveReg55(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (TETRIS_VGA_SLV_REG55_OFFSET) + (RegOffset), (Xuint32)(Value))

#define TETRIS_VGA_mReadSlaveReg0(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG0_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg1(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG1_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg2(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG2_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg3(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG3_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg4(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG4_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg5(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG5_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg6(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG6_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg7(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG7_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg8(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG8_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg9(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG9_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg10(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG10_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg11(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG11_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg12(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG12_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg13(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG13_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg14(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG14_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg15(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG15_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg16(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG16_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg17(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG17_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg18(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG18_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg19(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG19_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg20(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG20_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg21(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG21_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg22(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG22_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg23(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG23_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg24(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG24_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg25(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG25_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg26(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG26_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg27(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG27_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg28(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG28_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg29(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG29_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg30(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG30_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg31(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG31_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg32(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG32_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg33(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG33_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg34(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG34_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg35(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG35_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg36(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG36_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg37(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG37_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg38(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG38_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg39(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG39_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg40(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG40_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg41(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG41_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg42(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG42_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg43(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG43_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg44(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG44_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg45(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG45_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg46(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG46_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg47(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG47_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg48(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG48_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg49(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG49_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg50(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG50_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg51(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG51_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg52(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG52_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg53(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG53_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg54(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG54_OFFSET) + (RegOffset))
#define TETRIS_VGA_mReadSlaveReg55(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (TETRIS_VGA_SLV_REG55_OFFSET) + (RegOffset))

/************************** Function Prototypes ****************************/


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
void TETRIS_VGA_EnableInterrupt(void * baseaddr_p);

/**
 *
 * Example interrupt controller handler.
 *
 * @param   baseaddr_p is the base address of the TETRIS_VGA device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void TETRIS_VGA_Intr_DefaultHandler(void * baseaddr_p);

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
XStatus TETRIS_VGA_SelfTest(void * baseaddr_p);

#endif /** TETRIS_VGA_H */
