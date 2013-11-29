
#include "xparameters.h"                        // Contains hardware addresses and bit masks
#include "xgpio.h"                              // LED and Button driver
#include "xtmrctr.h"
#include "xintc.h"
#include "xtmrctr_l.h"                          // Low-level timer drivers
#include "xintc_l.h"                            // Low-level interrupt controller drivers
#include "mb_interface.h"                       // Very low level bus interface drivers
#include "tetris_vga.h"
#include <xbasic_types.h>                       // XGpio, Xuint32, etc. typedefs
#include <xio.h>                                // Very low-level i/o stuff
#include <stdlib.h>

#define TETRIS_VGA_START 0xC9A00000

int main () {
	int i, ret;

	xil_printf("Loaded...");
	TETRIS_VGA_mWriteReg(TETRIS_VGA_START, 0, 1);
	ret = TETRIS_VGA_mReadReg(TETRIS_VGA_START, 0);
	if (ret)
		xil_printf("VGA Enabled (%d)\n", ret);
	TETRIS_VGA_mWriteReg(TETRIS_VGA_START, 2*4, 0x71234567);

	for (i=0;i<58; i++) {
		xil_printf("reg %d: %08x\n", i, TETRIS_VGA_mReadReg(TETRIS_VGA_START, i<<2));
	}

//	for (;;) {
//		i = 0;
		while (100000000<i++) {}
//		TETRIS_VGA_mWriteReg(TETRIS_VGA_USER_SLV_SPACE_OFFSET, 1, 512);
//		i = TETRIS_VGA_mReadReg(TETRIS_VGA_USER_SLV_SPACE_OFFSET, 1);
//		xil_printf("vcnt = 0x%04x, hcnt = 0x%04x\n", i & 0xFFFF, i >> 16);
//	}
	xil_printf("Bye!");
	return 0;
}