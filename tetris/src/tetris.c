
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
#include "qpn_port.h"

#define TETRIS_VGA_START 				0xC9A00000
#define RESET_VALUE                 	100000000	// 100M at 50Mhz (20ns/cycle) ~= 2s
#define DEBOUNCE_TIME 	                125000	    // * 20ns = 2.5ms


enum Lab2ASignals {
	ENCODER_RIGHT = Q_USER_SIG,
	ENCODER_LEFT,
	ENCODER_CLICK,
    TIMER_FALL
};

// Tetraminos
char    I0[4][4] = { {0, 0, 3, 0},
                     {0, 0, 3, 0},
                     {0, 0, 3, 0},
                     {0, 0, 3, 0} };
char    I1[4][4] = { {0, 0, 0, 0},
                     {0, 0, 0, 0},
                     {3, 3, 3, 3},
                     {0, 0, 0, 0} };
char    I2[4][4] = { {0, 3, 0, 0},
                     {0, 3, 0, 0},
                     {0, 3, 0, 0},
                     {0, 3, 0, 0} };
char    I3[4][4] = { {0, 0, 0, 0},
                     {3, 3, 3, 3},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
char    J0[4][4] = { {1, 1, 1, 0},
                     {0, 0, 1, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
char    J1[4][4] = { {0, 1, 1, 0},
                     {0, 0, 1, 0},
                     {0, 0, 1, 0},
                     {0, 0, 0, 0} };
char    J2[4][4] = { {0, 0, 1, 0},
                     {1, 1, 1, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
char    J3[4][4] = { {1, 0, 0, 0},
                     {1, 0, 0, 0},
                     {1, 1, 0, 0},
                     {0, 0, 0, 0} };
char    L0[4][4] = { {5, 5, 5, 0},
                     {5, 0, 0, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
char    L5[4][4] = { {5, 5, 0, 0},
                     {0, 5, 0, 0},
                     {0, 5, 0, 0},
                     {0, 0, 0, 0} };
char    L2[4][4] = { {0, 0, 5, 0},
                     {5, 5, 5, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
char    L3[4][4] = { {5, 0, 0, 0},
                     {5, 0, 0, 0},
                     {5, 5, 0, 0},
                     {0, 0, 0, 0} };
char    O0[4][4] = { {0, 6, 6, 0},
                     {0, 6, 6, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
char    O1[4][4] = { {0, 6, 6, 0},
                     {0, 6, 6, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
char    O2[4][4] = { {0, 6, 6, 0},
                     {0, 6, 6, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
char    O3[4][4] = { {0, 6, 6, 0},
                     {0, 6, 6, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
char    T0[4][4] = { {0, 0, 0, 0},
                     {7, 7, 7, 0},
                     {0, 7, 0, 0},
                     {0, 0, 0, 0} };
char    T1[4][4] = { {0, 7, 0, 0},
                     {7, 7, 0, 0},
                     {0, 7, 0, 0},
                     {0, 0, 0, 0} };
char    T2[4][4] = { {0, 7, 0, 0},
                     {7, 7, 7, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
char    T3[4][4] = { {0, 7, 0, 0},
                     {0, 7, 7, 0},
                     {0, 7, 0, 0},
                     {0, 0, 0, 0} };
char    S0[4][4] = { {0, 2, 2, 0},
                     {2, 2, 0, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
char    S1[4][4] = { {2, 0, 0, 0},
                     {2, 2, 0, 0},
                     {0, 2, 0, 0},
                     {0, 0, 0, 0} };
char    S2[4][4] = { {0, 2, 2, 0},
                     {2, 2, 0, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
char    S3[4][4] = { {2, 0, 0, 0},
                     {2, 2, 0, 0},
                     {0, 2, 0, 0},
                     {0, 0, 0, 0} };
char    N0[4][4] = { {4, 4, 0, 0},
                     {0, 4, 4, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
char    N1[4][4] = { {0, 4, 0, 0},
                     {4, 4, 0, 0},
                     {4, 0, 0, 0},
                     {0, 0, 0, 0} };
char    N2[4][4] = { {4, 4, 0, 0},
                     {0, 4, 4, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
char    N3[4][4] = { {0, 4, 0, 0},
                     {4, 4, 0, 0},
                     {4, 0, 0, 0},
                     {0, 0, 0, 0} };

// typedefs
typedef struct Tableau_t {
    char*    tetramino;
} Tableau;

typedef struct Tetris_t {
    QActive super;

    int     score;
    int     level;

    Tableau next;
    char    gameboard[20][10];
} Tetris;


// Globals
// -- system vars
static  unsigned char   click = 0;
static  Xuint32			enc = 0;
static  Xuint32         top;
static  Xuint32         ret = 0x01234567;
static  Xuint32         cnt = 0;

// -- system objs
static  XIntc           sys_intc;
static  XTmrCtr         sys_tmrctr;
static  XGpio           sys_buttons;
static  XGpio           sys_encoder;
static  XGpio           leds;
static  QEvent          l_tetrisQueue[30];
struct  Tetris 			Game;

QActiveCB const Q_ROM Q_ROM_VAR QF_active[] = {
	{ (QActive *)0,            (QEvent *)0,          0                    },
	{ (QActive *)&Game,        l_tetrisQueue,        Q_DIM(l_tetrisQueue) }
};

// Prototypes
void    Tetris_ctor(void);
int     sys_init();
void    vga_handler();
void    button_handler();
void    encoder_handler();
void    timer_handler();
void    QF_onStartup(void);
void    QF_onIdle(void);

// Declarations
int main(void)
{
	//int i;
	XStatus status;

    xil_printf("QActive size: %d\n", sizeof(QActive));
    status = sys_init();
    if (status != XST_SUCCESS) {
    	xil_printf("Failed to initialize interrupts!\n");
    	return -1;
    }
	//QF_run();

	return 0;
} // end main

int sys_init()
{
    XGpio_Initialize(&leds, XPAR_LEDS_8BIT_DEVICE_ID);
	XGpio_Initialize(&sys_buttons, XPAR_CLICK_DEVICE_ID);
	XGpio_Initialize(&sys_encoder, XPAR_ENCODER_DEVICE_ID);
	XIntc_Initialize(&sys_intc, XPAR_XPS_INTC_0_DEVICE_ID);
	XTmrCtr_Initialize(&sys_tmrctr, XPAR_XPS_TIMER_0_DEVICE_ID);

	// Configure GPIO
    XGpio_SetDataDirection(&leds, 1, 0x00000000);
    XGpio_SetDataDirection(&sys_buttons, 1, 0x0000000F);
    XGpio_SetDataDirection(&sys_encoder, 1, 0x00000003);

    /* vga interrupt cfg */
	XIntc_Connect(&sys_intc,XPAR_XPS_INTC_0_TETRIS_VGA_0_IP2INTC_IRPT_INTR,
			(XInterruptHandler)vga_handler, (void*)TETRIS_VGA_START);
    XIntc_Enable(&sys_intc, XPAR_XPS_INTC_0_TETRIS_VGA_0_IP2INTC_IRPT_INTR);

    /* timer interrupt cfg */
	XIntc_Connect(&sys_intc,XPAR_XPS_INTC_0_XPS_TIMER_0_INTERRUPT_INTR,
			(XInterruptHandler)timer_handler, &sys_tmrctr);
    XIntc_Enable(&sys_intc, XPAR_XPS_INTC_0_XPS_TIMER_0_INTERRUPT_INTR);

    /* button interrupt cfg */
	XIntc_Connect(&sys_intc,XPAR_XPS_INTC_0_XPS_GPIO_0_IP2INTC_IRPT_INTR,
			(XInterruptHandler)button_handler, &sys_buttons);
	XGpio_InterruptGlobalEnable(&sys_buttons);
	XGpio_InterruptEnable(&sys_buttons,XPAR_XPS_INTC_0_XPS_GPIO_0_IP2INTC_IRPT_INTR);
	XIntc_Enable(&sys_intc, XPAR_XPS_INTC_0_XPS_GPIO_0_IP2INTC_IRPT_INTR);

    /* encoder interrupt cfg */
	XIntc_Connect(&sys_intc,XPAR_XPS_INTC_0_XPS_GPIO_1_IP2INTC_IRPT_INTR,
			(XInterruptHandler)encoder_handler, &sys_encoder);
	XGpio_InterruptGlobalEnable(&sys_encoder);
	XGpio_InterruptEnable(&sys_encoder,XGPIO_IR_CH1_MASK);
	XIntc_Enable(&sys_intc, XPAR_XPS_INTC_0_XPS_GPIO_1_IP2INTC_IRPT_INTR);

    // Enable VGA
    TETRIS_VGA_EnableInterrupt((void*)TETRIS_VGA_START);
    //TETRIS_VGA_mWriteReg(TETRIS_VGA_START, TETRIS_VGA_INTR_IPIER_OFFSET, 0x00000001);
    //TETRIS_VGA_mWriteReg(TETRIS_VGA_START, TETRIS_VGA_INTR_DIER_OFFSET, INTR_TERR_MASK | INTR_DPTO_MASK | INTR_IPIR_MASK);
    //TETRIS_VGA_mWriteReg(TETRIS_VGA_START, TETRIS_VGA_INTR_DGIER_OFFSET, INTR_GIE_MASK);
    TETRIS_VGA_mWriteReg(TETRIS_VGA_START, 0, 1);

    // Configure and start Timer
    XTmrCtr_SetOptions(&sys_tmrctr, 0, XTC_INT_MODE_OPTION | XTC_AUTO_RELOAD_OPTION);
	XTmrCtr_SetResetValue(&sys_tmrctr, 0, 0xFFFFFFFF-DEBOUNCE_TIME);
	//XTmrCtr_Start(&sys_tmrctr, 0);

    /* Start interrupts */
	XIntc_Start(&sys_intc, XIN_REAL_MODE);
	microblaze_register_handler((XInterruptHandler)XIntc_DeviceInterruptHandler,
			(void*)XPAR_XPS_INTC_0_DEVICE_ID);
	microblaze_enable_interrupts();

    return XST_SUCCESS;
}


/*..........................................................................*/
void QF_onStartup(void)                   /* entered with interrupts locked */
{
    /* Enable interrupts */
	//xil_printf("\n\rQF_onStartup");
}

/* Do not touch QF_onIdle */
/*..........................................................................*/
void QF_onIdle(void)          /* entered with interrupts locked, see NOTE01 */
{
    QF_INT_UNLOCK();                       /* unlock interrupts, see NOTE01 */
}

/* Do not touch Q_onAssert */
/*..........................................................................*/
void Q_onAssert(char const Q_ROM * const Q_ROM_VAR file, int line)
{
    (void)file;                                   /* avoid compiler warning */
    (void)line;                                   /* avoid compiler warning */
    QF_INT_LOCK();                  
    for (;;) {
    }
}

void vga_handler()
{
	Xuint32 baseaddr;
	Xuint32 IntrStatus;
	Xuint32 IpStatus;
	int i;

	XIntc_Stop(&sys_intc);

	baseaddr = (Xuint32) TETRIS_VGA_START;
	IntrStatus = TETRIS_VGA_mReadReg(baseaddr, TETRIS_VGA_INTR_DISR_OFFSET);
	//xil_printf("Device Interrupt! DISR value : 0x%08x \n\r", IntrStatus);

	if ( (IntrStatus & INTR_IPIR_MASK) == INTR_IPIR_MASK )
	{
		//xil_printf("User logic interrupt! \n\r");
		if (cnt++ > 60) {
			cnt = 0;
			XTmrCtr_Start(&sys_tmrctr, 0);
			for (i=2;i<58; i++) {
				TETRIS_VGA_mWriteReg(TETRIS_VGA_START, i<<2, ret);
				// Poor-man's 4-bit barrel shift
				top = ret >> 28;
				ret = ret << 4 | top;
			}
			top = ret >> 28;
			ret = ret << 4 | top;
			XTmrCtr_Stop(&sys_tmrctr, 0);
			i = XTmrCtr_GetValue(&sys_tmrctr, 0);
			XGpio_DiscreteWrite(&leds,1,i>>8);
		}


		IpStatus = TETRIS_VGA_mReadReg(baseaddr, TETRIS_VGA_INTR_IPISR_OFFSET);
		TETRIS_VGA_mWriteReg(baseaddr, TETRIS_VGA_INTR_IPISR_OFFSET, IpStatus);
	}
	XIntc_Start(&sys_intc, XIN_REAL_MODE);
}

void button_handler()
{
	/* Display status */
    click = XGpio_DiscreteRead(&sys_buttons,1);
	//XGpio_DiscreteWrite(&leds,1,click);

	/* Reset timer */
    if (click) {
		XTmrCtr_Reset(&sys_tmrctr, 0);
		XTmrCtr_Start(&sys_tmrctr, 0);
    }

	/* Clear int */
	XGpio_InterruptClear(&sys_buttons,XGPIO_IR_CH1_MASK);
    //QActive_postISR((QActive *)&AO_Lab2A, ENCODER_CLICK);
}

void encoder_handler()
{
	char tmp;

	/* Display status */
    //xil_printf("\n\rTwist");
    tmp = XGpio_DiscreteRead(&sys_encoder,1);
	enc = enc << 2;		// shift the data up for next entry
	enc |= tmp & 3;		// should never be >3, but why chance it
	//xil_printf("\n\rR%-02x", enc);
	//XGpio_DiscreteWrite(&leds,1,enc);	// only get last 8 bits

	/* Update state and Reset timer */
	XTmrCtr_Reset(&sys_tmrctr, 0);
	XTmrCtr_Start(&sys_tmrctr, 0);

	/* Clear int */
	XGpio_InterruptClear(&sys_encoder,XGPIO_IR_CH1_MASK);
	/*
    if (rd1 == rd2 && rd1 == 2) {
        QActive_postISR((QActive *)&AO_Lab2A, ENCODER_UP);
    } else if (rd1 == rd2 && rd1 == 1) {
        QActive_postISR((QActive *)&AO_Lab2A, ENCODER_DOWN);
    }
    */
}

void timer_handler()
{
	Xuint32 status;

	/* Check what kicked off the timer */
	if (click) {
	    QActive_postISR((QActive *)&AO_Lab2B, ENCODER_CLICK);
	    click = 0; // play nice, keep your variables clean
	} else if (enc != 0 && enc > 256) {	// really need at least 4 to get a good sequence
		//xil_printf("\n\rD%08x", enc);
		while (enc) {
			switch (enc&0x3f) {
			// cases are deliberately encoded in order of frequency
			// Left sequences have more false positives than Right, so check those first
			case 0x38:	// 0-2-3	0% false
			case 0x1E:	// 2-3-1	0% false
			case 0x3A:	// 2-2-3	0% false
			case 0x2A:	// 2-2-2	4% false
				QActive_postISR((QActive *)&AO_Lab2B, ENCODER_LEFT);
				enc = 0;
				break;
			// Check Up sequences
			case 0x35:	// 1-1-3	2% false
			case 0x2E:	// 1-3-2	0% false
			case 0x15:	// 1-1-1	5% false
			case 0x0B:	// 3-2-0	0% false
				QActive_postISR((QActive *)&AO_Lab2B, ENCODER_RIGHT);
				enc = 0;
				break;
			}
			// remove latest sample and try again; short below smallest value
			enc = enc >> 2;
			if (enc < 0x0B)
				enc = 0;
		}
	}

	/* Clear interrupt */
	XTmrCtr_Reset(&sys_tmrctr, 0);
	XTmrCtr_Stop(&sys_tmrctr,0);
	status = XTimerCtr_ReadReg(sys_tmrctr.BaseAddress, 0, XTC_TCSR_OFFSET);
	XTmrCtr_WriteReg(sys_tmrctr.BaseAddress, 0, XTC_TCSR_OFFSET, status|XTC_CSR_INT_OCCURED_MASK);
}

