
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
#include <string.h>

#define TETRIS_VGA_START 				0xC9A00000
#define RESET_VALUE                 	10000010	// * 20ns ~= 2s
#define DEBOUNCE_TIME 	                125000	    // * 20ns = 2.5ms

#define ACTION_DISPLAY					0x00000001
#define ACTION_NEXT						0x00000002
#define ACTION_FALL						0x00000004
#define ACTION_LEFT						0x00000008
#define ACTION_RIGHT					0x00000010
#define ACTION_ROTATE					0x00000020
#define ACTION_GAME_OVER				0x00000040
#define ACTION_CHECK_LINES				0x00000080
#define ACTION_CLEAR_LINES				0x00000100
#define ACTION_DEBUG					0x80000000

// Make it prettier
#define TETRAMINO(G,Y,X)\
	*((char*)((int)(G)+(Y)*4+(X)))

// Globals
// -- system vars
static  Xuint32         actions;
static  Xuint8			click = 0;
static  Xuint32			enc = 0;

// -- system objs
static  XIntc           sys_intc;
static  XGpio           sys_buttons;
static  XGpio           sys_encoder;
static  XTmrCtr         sys_tmrctr;
static  XTmrCtr         sys_tmrfall;
static  XGpio           leds;

// Tetraminos
static const char    NT[4][4] = { {0, 0, 0, 0},
                                  {0, 0, 0, 0},
                                  {0, 0, 0, 0},
                                  {0, 0, 0, 0} };
static const char    I0[4][4] = { {0, 0, 3, 0},
                                  {0, 0, 3, 0},
                                  {0, 0, 3, 0},
                                  {0, 0, 3, 0} };
static const char    I1[4][4] = { {0, 0, 0, 0},
                                  {0, 0, 0, 0},
                                  {3, 3, 3, 3},
                                  {0, 0, 0, 0} };
static const char    I2[4][4] = { {0, 3, 0, 0},
                                  {0, 3, 0, 0},
                                  {0, 3, 0, 0},
                                  {0, 3, 0, 0} };
static const char    I3[4][4] = { {0, 0, 0, 0},
                                  {3, 3, 3, 3},
                                  {0, 0, 0, 0},
                                  {0, 0, 0, 0} };
static const char    J0[4][4] = { {0, 0, 0, 0},
                                  {1, 1, 1, 0},
                                  {0, 0, 1, 0},
                                  {0, 0, 0, 0} };
static const char    J1[4][4] = { {0, 0, 1, 0},
                                  {0, 0, 1, 0},
                                  {0, 1, 1, 0},
                                  {0, 0, 0, 0} };
static const char    J2[4][4] = { {0, 0, 0, 0},
                                  {0, 0, 1, 0},
                                  {1, 1, 1, 0},
                                  {0, 0, 0, 0} };
static const char    J3[4][4] = { {0, 1, 1, 0},
                                  {0, 1, 0, 0},
                                  {0, 1, 0, 0},
                                  {0, 0, 0, 0} };
static const char    L0[4][4] = { {0, 0, 0, 0},
                                  {5, 5, 5, 0},
                                  {5, 0, 0, 0},
                                  {0, 0, 0, 0} };
static const char    L1[4][4] = { {0, 5, 5, 0},
                                  {0, 0, 5, 0},
                                  {0, 0, 5, 0},
                                  {0, 0, 0, 0} };
static const char    L2[4][4] = { {0, 0, 0, 0},
                                  {0, 0, 5, 0},
                                  {5, 5, 5, 0},
                                  {0, 0, 0, 0} };
static const char    L3[4][4] = { {0, 5, 0, 0},
                                  {0, 5, 0, 0},
                                  {0, 5, 5, 0},
                                  {0, 0, 0, 0} };
static const char    O0[4][4] = { {0, 6, 6, 0},
                                  {0, 6, 6, 0},
                                  {0, 0, 0, 0},
                                  {0, 0, 0, 0} };
static const char    O1[4][4] = { {0, 6, 6, 0},
                                  {0, 6, 6, 0},
                                  {0, 0, 0, 0},
                                  {0, 0, 0, 0} };
static const char    O2[4][4] = { {0, 6, 6, 0},
                                  {0, 6, 6, 0},
                                  {0, 0, 0, 0},
                                  {0, 0, 0, 0} };
static const char    O3[4][4] = { {0, 6, 6, 0},
                                  {0, 6, 6, 0},
                                  {0, 0, 0, 0},
                                  {0, 0, 0, 0} };
static const char    T0[4][4] = { {0, 0, 0, 0},
                                  {7, 7, 7, 0},
                                  {0, 7, 0, 0},
                                  {0, 0, 0, 0} };
static const char    T1[4][4] = { {0, 0, 7, 0},
                                  {0, 7, 7, 0},
                                  {0, 0, 7, 0},
                                  {0, 0, 0, 0} };
static const char    T2[4][4] = { {0, 0, 0, 0},
                                  {0, 7, 0, 0},
                                  {7, 7, 7, 0},
                                  {0, 0, 0, 0} };
static const char    T3[4][4] = { {0, 7, 0, 0},
                                  {0, 7, 7, 0},
                                  {0, 7, 0, 0},
                                  {0, 0, 0, 0} };
static const char    S0[4][4] = { {0, 2, 2, 0},
                                  {2, 2, 0, 0},
                                  {0, 0, 0, 0},
                                  {0, 0, 0, 0} };
static const char    S1[4][4] = { {0, 2, 0, 0},
                                  {0, 2, 2, 0},
                                  {0, 0, 2, 0},
                                  {0, 0, 0, 0} };
static const char    S2[4][4] = { {0, 2, 2, 0},
                                  {2, 2, 0, 0},
                                  {0, 0, 0, 0},
                                  {0, 0, 0, 0} };
static const char    S3[4][4] = { {0, 2, 0, 0},
                                  {0, 2, 2, 0},
                                  {0, 0, 2, 0},
                                  {0, 0, 0, 0} };
static const char    N0[4][4] = { {4, 4, 0, 0},
                                  {0, 4, 4, 0},
                                  {0, 0, 0, 0},
                                  {0, 0, 0, 0} };
static const char    N1[4][4] = { {0, 0, 4, 0},
                                  {0, 4, 4, 0},
                                  {0, 4, 0, 0},
                                  {0, 0, 0, 0} };
static const char    N2[4][4] = { {4, 4, 0, 0},
                                  {0, 4, 4, 0},
                                  {0, 0, 0, 0},
                                  {0, 0, 0, 0} };
static const char    N3[4][4] = { {0, 0, 4, 0},
                                  {0, 4, 4, 0},
                                  {0, 4, 0, 0},
                                  {0, 0, 0, 0} };


typedef struct Tetris_t {
    //QActive super;

	int		play;
	int 	lines;
    int     score;
    int     level;

    int		x, dx;
    int		y, dy;
    int     fall_time;

    char** 	next;
    char** 	tetramino;
    char    gameboard[20][10];
} Tetris;

Tetris Game;

// Protos
void    Tetris_ctor(void);
int     sys_init();
void    vga_handler();
void	fall_handler();
void	button_handler();
void	encoder_handler();
void	timer_handler();
char**	get_next();
char	check_move(Tetris *me, int dx, int dy);
void	check_lines(Tetris *me);
void	clear_lines(Tetris *me);
void	do_rotate(Tetris *me);
void	draw_piece(Tetris *me, char erase);
void	update_display(Tetris *me);


// Declarations
int main(void)
{
	//int i, j;
	XStatus status;

	Tetris_ctor();
	Game.next = NT;
	Game.tetramino = NT;
    status = sys_init();
    if (status != XST_SUCCESS) {
    	xil_printf("Failed to initialize interrupts!\n");
    	return -1;
    }

//#define ACTION_DISPLAY					0x00000001
//#define ACTION_NEXT						0x00000002
//#define ACTION_FALL						0x00000004
//#define ACTION_LEFT						0x00000008
//#define ACTION_RIGHT						0x00000010
//#define ACTION_ROTATE						0x00000020
//#define ACTION_GAME_OVER					0x00000040
//#define ACTION_DEBUG						0x80000000

	for(;;) {
		while (!actions) {}

		XIntc_Stop(&sys_intc);
        if (Game.play) {
            if (actions & ACTION_DISPLAY) {
                update_display(&Game);
                actions &= ~ACTION_DISPLAY;
            } else if (actions & ACTION_NEXT) {
                // Update next
                Game.tetramino = Game.next;
                Game.next = get_next();
                //xil_printf("N:%x\n", Game.next);
                Game.x = 3;
                Game.y = 0;
                actions &= ~ACTION_NEXT;
            } else if (actions & ACTION_CHECK_LINES) {
                check_lines(&Game);
                if ( !Game.lines ) {
                	actions |= ACTION_NEXT;
                }
                actions &= ~ACTION_CHECK_LINES;
            } else if (actions & ACTION_CLEAR_LINES) {
                clear_lines(&Game);
                actions |= ACTION_NEXT;
                actions &= ~ACTION_CLEAR_LINES;
            } else if (actions & ACTION_FALL) {
            	if (Game.lines) {
            	    actions |= ACTION_CLEAR_LINES;
            	} else if (check_move(&Game, 0, 1)) {
                    Game.y++;
                } else if (Game.y == 0) {
                    actions |= ACTION_GAME_OVER;
                } else {
                    draw_piece(&Game,0);
                    Game.tetramino = NT;
                    actions |= ACTION_CHECK_LINES;
                }
                actions &= ~ACTION_FALL;
            } else if (actions & ACTION_LEFT) {
                if (check_move(&Game, -1, 0)) {
                    Game.x--;
                }
                actions &= ~ACTION_LEFT;
            } else if (actions & ACTION_RIGHT) {
                if (check_move(&Game, 1, 0)) {
                    Game.x++;
                }
                actions &= ~ACTION_RIGHT;
            } else if (actions & ACTION_ROTATE) {
                do_rotate(&Game);
                actions &= ~ACTION_ROTATE;
            } else if (actions & ACTION_GAME_OVER) {
                //return 0;
                draw_piece(&Game,0);
                XTmrCtr_Stop(&sys_tmrfall, 0);
                Game.play = 0;
                actions &= ~ACTION_GAME_OVER;
            }
        } else {
            if (actions & ACTION_DISPLAY) {
                update_display(&Game);
                actions &= ~ACTION_DISPLAY;
            } else if (actions & ACTION_ROTATE) {
                Tetris_ctor();
                XTmrCtr_Start(&sys_tmrfall, 0);
                Game.play = 1;
                actions &= ~ACTION_ROTATE;
                // Seed the random number generator based on the inputs
                // -- Read the timers from the VGA interface and use those as the seed
                status = TETRIS_VGA_mReadReg(TETRIS_VGA_START, 4);
                status ^= (status << 6);    // ensure that all bits have the possibility of being filled
                srand(status);
            } else {
                actions = 0;
            }
        }
		XIntc_Start(&sys_intc, XIN_REAL_MODE);
	}

	return 0;
} // end main

void Tetris_ctor(void)  {
	Tetris *me = &Game;
	//QActive_ctor(&me->super, (QStateHandler)&Tetris_initial);
	me->play = 0;
	me->lines = 0;
	me->score = 0;
	me->level = 1;
	me->x = 3;		// Center Tetramino to start
	me->y = 0;
	me->dx = 0;
	me->dy = 0;
    me->fall_time = RESET_VALUE - (1000 << me->level);
	me->next = get_next();
	me->tetramino = get_next();
	memset(me->gameboard, 0, 200);
}

int sys_init()
{
	XIntc_Initialize(&sys_intc, XPAR_XPS_INTC_0_DEVICE_ID);
    XGpio_Initialize(&leds, XPAR_LEDS_8BIT_DEVICE_ID);
	XGpio_Initialize(&sys_buttons, XPAR_CLICK_DEVICE_ID);
	XGpio_Initialize(&sys_encoder, XPAR_ENCODER_DEVICE_ID);
	XTmrCtr_Initialize(&sys_tmrctr, XPAR_XPS_TIMER_0_DEVICE_ID);
	XTmrCtr_Initialize(&sys_tmrfall, XPAR_FALL_TIMER_DEVICE_ID);

	// Configure GPIO
    XGpio_SetDataDirection(&leds, 1, 0x00000000);

    /* vga interrupt cfg */
	XIntc_Connect(&sys_intc,XPAR_XPS_INTC_0_TETRIS_VGA_0_IP2INTC_IRPT_INTR,
			(XInterruptHandler)vga_handler, (void*)TETRIS_VGA_START);
    XIntc_Enable(&sys_intc, XPAR_XPS_INTC_0_TETRIS_VGA_0_IP2INTC_IRPT_INTR);

    /* fall timer interrupt cfg */
	XIntc_Connect(&sys_intc,XPAR_XPS_INTC_0_FALL_TIMER_INTERRUPT_INTR,
			(XInterruptHandler)fall_handler, &sys_tmrfall);
    XIntc_Enable(&sys_intc, XPAR_XPS_INTC_0_FALL_TIMER_INTERRUPT_INTR);

    /* timer interrupt cfg */
	XIntc_Connect(&sys_intc,XPAR_XPS_INTC_0_XPS_TIMER_0_INTERRUPT_INTR,
			(XInterruptHandler)timer_handler, &sys_tmrctr);
    XIntc_Enable(&sys_intc, XPAR_XPS_INTC_0_XPS_TIMER_0_INTERRUPT_INTR);

    /* button interrupt cfg */
	XIntc_Connect(&sys_intc,XPAR_XPS_INTC_0_CLICK_IP2INTC_IRPT_INTR,
			(XInterruptHandler)button_handler, &sys_buttons);
	XGpio_InterruptGlobalEnable(&sys_buttons);
	XGpio_InterruptEnable(&sys_buttons,XPAR_XPS_INTC_0_CLICK_IP2INTC_IRPT_INTR);
	XIntc_Enable(&sys_intc, XPAR_XPS_INTC_0_CLICK_IP2INTC_IRPT_INTR);

    /* encoder interrupt cfg */
	XIntc_Connect(&sys_intc,XPAR_XPS_INTC_0_ENCODER_IP2INTC_IRPT_INTR,
			(XInterruptHandler)encoder_handler, &sys_encoder);
	XGpio_InterruptGlobalEnable(&sys_encoder);
	XGpio_InterruptEnable(&sys_encoder,XGPIO_IR_CH1_MASK);
	XIntc_Enable(&sys_intc, XPAR_XPS_INTC_0_ENCODER_IP2INTC_IRPT_INTR);

    // Enable VGA
    TETRIS_VGA_EnableInterrupt((void*)TETRIS_VGA_START);
    //TETRIS_VGA_mWriteReg(TETRIS_VGA_START, TETRIS_VGA_INTR_IPIER_OFFSET, 0x00000001);
    //TETRIS_VGA_mWriteReg(TETRIS_VGA_START, TETRIS_VGA_INTR_DIER_OFFSET, INTR_TERR_MASK | INTR_DPTO_MASK | INTR_IPIR_MASK);
    //TETRIS_VGA_mWriteReg(TETRIS_VGA_START, TETRIS_VGA_INTR_DGIER_OFFSET, INTR_GIE_MASK);
    TETRIS_VGA_mWriteReg(TETRIS_VGA_START, 0, 1);

    // Configure Timers
    XTmrCtr_SetOptions(&sys_tmrctr, 0, XTC_INT_MODE_OPTION);
	XTmrCtr_SetResetValue(&sys_tmrctr, 0, 0xFFFFFFFF-DEBOUNCE_TIME);
    XTmrCtr_SetOptions(&sys_tmrfall, 0, XTC_INT_MODE_OPTION | XTC_AUTO_RELOAD_OPTION);
	XTmrCtr_SetResetValue(&sys_tmrfall, 0, 0xFFFFFFFF-Game.fall_time);

	/* Start interrupts */
	XIntc_Start(&sys_intc, XIN_REAL_MODE);
	microblaze_register_handler((XInterruptHandler)XIntc_DeviceInterruptHandler,
			(void*)XPAR_XPS_INTC_0_DEVICE_ID);
	microblaze_enable_interrupts();

    return XST_SUCCESS;
}

void vga_handler()
{
	Xuint32 baseaddr;
	Xuint32 IntrStatus;
	Xuint32 IpStatus;

	XIntc_Stop(&sys_intc);

	//xil_printf("D\n");
	baseaddr = (Xuint32) TETRIS_VGA_START;
	IntrStatus = TETRIS_VGA_mReadReg(baseaddr, TETRIS_VGA_INTR_DISR_OFFSET);
	//xil_printf("Device Interrupt! DISR value : 0x%08x \n\r", IntrStatus);

	if ( (IntrStatus & INTR_IPIR_MASK) == INTR_IPIR_MASK )
	{
		//update_display(&Game);
		actions |= ACTION_DISPLAY;
		IpStatus = TETRIS_VGA_mReadReg(baseaddr, TETRIS_VGA_INTR_IPISR_OFFSET);
		TETRIS_VGA_mWriteReg(baseaddr, TETRIS_VGA_INTR_IPISR_OFFSET, IpStatus);
	}
	XIntc_Start(&sys_intc, XIN_REAL_MODE);
}

void fall_handler() {
	Xuint32 ControlStatusReg;
	XIntc_Stop(&sys_intc);
	actions |= ACTION_FALL;
    // update fall time
	XTmrCtr_SetResetValue(&sys_tmrfall, 0, 0xFFFFFFFF-Game.fall_time);
    // clear interrupt
	ControlStatusReg = XTimerCtr_ReadReg(sys_tmrfall.BaseAddress, 0, XTC_TCSR_OFFSET);
	XTmrCtr_WriteReg(sys_tmrfall.BaseAddress, 0, XTC_TCSR_OFFSET, ControlStatusReg|XTC_CSR_INT_OCCURED_MASK);
	XIntc_Start(&sys_intc, XIN_REAL_MODE);
}

void button_handler()
{
	XIntc_Stop(&sys_intc);
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
	XIntc_Start(&sys_intc, XIN_REAL_MODE);
}

void encoder_handler()
{
	char tmp;

	XIntc_Stop(&sys_intc);
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
	XIntc_Start(&sys_intc, XIN_REAL_MODE);
}

void timer_handler()
{
	Xuint32 status;

	XIntc_Stop(&sys_intc);

	/* Check what kicked off the timer */
	if (click) {
		actions |= ACTION_ROTATE;
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
				actions |= ACTION_LEFT;
				enc = 0;
				break;
			// Check Right sequences
			case 0x35:	// 1-1-3	2% false
			case 0x2E:	// 1-3-2	0% false
			case 0x15:	// 1-1-1	5% false
			case 0x0B:	// 3-2-0	0% false
				actions |= ACTION_RIGHT;
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

	XIntc_Start(&sys_intc, XIN_REAL_MODE);
}

char** get_next() {
	char	id = rand() % 7;
	int 	sel = rand() & 3;
	// Each tetramino is 16 bytes (4x4 char)
	switch (id) {
	case 0:		return (char**)((int)I0 + (sel<<4));
	case 1:		return (char**)((int)J0 + (sel<<4));
	case 2:		return (char**)((int)L0 + (sel<<4));
	case 3:		return (char**)((int)O0 + (sel<<4));
	case 4:		return (char**)((int)T0 + (sel<<4));
	case 5:		return (char**)((int)S0 + (sel<<4));
	case 6:		return (char**)((int)N0 + (sel<<4));
	}
	return (char**)O0;
}

char check_move(Tetris *me, int dx, int dy) {
	int i, j, gy, gx;
	// Get gameboard coordinates
	gx = me->x + dx;
	gy = me->y + dy;
	for (i=0; i<4; i++, gy++) {
		for (j=0; j<4; j++, gx++) {
			if ( TETRAMINO(me->tetramino,i,j) ) {
				if (gy >= 20) {
					//xil_printf("gy %d, %d, %d", i, j, gy);
					return 0;	// Off board
				}
				if (gx < 0 || gx > 9) {
					//xil_printf("gx %d, %d, %d, %d", i, j, gx, TETRAMINO(me,i,j));
					return 0;	// Off board
				}
				if (me->gameboard[gy][gx]) {
					//xil_printf("clip %d, %d, %d, %d", i, j, me->gameboard[gy][gx], TETRAMINO(me,i,j));
					return 0;	// move will cause overlap
				}
			}
		}
		gx -= 4;
	}
	return 1;
}

// Mark all filled lines, remove them, update score and level
void check_lines(Tetris *me) {
    int i, j, l=0;
    for (i=0; i<20; i++) {
        for (j=0; j<10; j++) {
            if ( !me->gameboard[i][j] ) 
                break;
        }
        // If all the columns in the row have tiles,
        // clear the board and mark the line
        if (j == 10) {
            l += 1;
            me->lines |= ( 1 << 19-i );
            for (j=0; j<10; j++) {
                me->gameboard[i][j] = 0;
            }
        }
    }
    me->score += (l == 1) ? 10 :
    			 (l == 2) ? 30 :
    			 (l == 3) ? 60 :
    			 (l == 4) ? 100 : 0;
    me->level = (me->score >> 5) + 1;
    XGpio_DiscreteWrite(&leds,1,me->level);
    me->fall_time = RESET_VALUE - (10000 << me->level);
    return;
}

// Compact all clear lines
void clear_lines(Tetris *me) {
    int ct, cf, j;
    cf = 19;
    for (ct=19; ct>=0; ct--, cf--) {
        // Find next line to copy from
        while ( ( me->lines & ( 1 << 19-cf ) ) && cf >= 0 ) { cf--; }
        // Reached top of board, blank row and exit
        if ( cf == -1 ) {
            for (j=0; j<10; j++) {
                me->gameboard[ct][j] = 0;
            }
            break;
        }
        // Don't copy if we don't need to
        if ( cf != ct) {
            for (j=0; j<10; j++) {
                me->gameboard[ct][j] = me->gameboard[cf][j];
                me->gameboard[cf][j] = 0;
            }
        }
    }
    // Clear vars, play nice
    me->lines = 0;
    return;
}


void do_rotate(Tetris *me) {
	int i, j, gy, gx;
	char** rot;
	// Get next tetramino board
	// -- All tetraminos are 16 bytes, so check for the
	// -- last of the set and goto first, or just add 16
	if 		((int)me->tetramino == (int)I3) rot = (char**)I0;
	else if ((int)me->tetramino == (int)J3) rot = (char**)J0;
	else if ((int)me->tetramino == (int)L3) rot = (char**)L0;
	else if ((int)me->tetramino == (int)O3) rot = (char**)O0;
	else if ((int)me->tetramino == (int)T3) rot = (char**)T0;
	else if ((int)me->tetramino == (int)S3) rot = (char**)S0;
	else if ((int)me->tetramino == (int)N3) rot = (char**)N0;
	else 									rot = (char**)((int)me->tetramino + 16);
	// Get gameboard coordinates
	gx = me->x;
	gy = me->y;
	for (i=0; i<4; i++, gy++) {
		for (j=0; j<4; j++, gx++) {
			if ( TETRAMINO(rot,i,j) ) {
				if (gy >= 20) {
					//xil_printf("gy %d, %d, %d", i, j, gy);
					return 0;	// Off board
				}
				if (gx < 0 || gx > 9) {
					//xil_printf("gx %d, %d, %d, %d", i, j, gx, TETRAMINO(me,i,j));
					return 0;	// Off board
				}
				if (me->gameboard[gy][gx]) {
					//xil_printf("clip %d, %d, %d, %d", i, j, me->gameboard[gy][gx], TETRAMINO(me,i,j));
					return 0;	// move will cause overlap
				}
			}
		}
		gx -= 4;
	}
	me->tetramino = rot;
	return;
}

void draw_piece(Tetris *me, char erase) {
	int i, j, gx, gy;
	gx = me->x; gy = me->y;
	for (i=0; i<4; i++, gy++) {
		for (j=0; j<4; j++, gx++) {
			// check_move should prevent any out-of-bounds
			if ( TETRAMINO(me->tetramino,i,j) ) {
				me->gameboard[gy][gx] = (erase) ? 0 : TETRAMINO(me->tetramino,i,j);
			}
		}
		gx -= 4;
	}
}

void update_display(Tetris *me) {
	int i;
	// Write next to regs
	for (i=0; i<16; i+=4) {
		TETRIS_VGA_mWriteReg(TETRIS_VGA_START+208, i, *((Xuint32*)((int)(me->next) + i)) );
	}
	// Draw piece on board
	draw_piece(me,0);
	// Write gameboard to regs (32-bit access)
	for (i=0; i<200; i+=4) {
		TETRIS_VGA_mWriteReg(TETRIS_VGA_START+8, i, *((Xuint32*)((int)(me->gameboard) + i)) );
	}
	// Erase piece from board - will not interfere with check_move
	draw_piece(me,1);
	return;
}

#ifdef SCRATCH
// Debug display
xil_printf("%x, %x", (Xuint32)I0, (Xuint32)Game.tetramino);
xil_printf("\n");
for (i=0; i<4; i++) {
	for (j=0; j<4; j++) {
		xil_printf("%x ", Game.tetramino[i][j]);
	}
	xil_printf("\n");
}
xil_printf("\n");
update_display(&Game);
for (i=0; i<20; i++) {
	for (j=0; j<10; j++) {
		xil_printf("%x ", Game.gameboard[i][j] & 7);
	}
	xil_printf("\n");
}
xil_printf("Bye ");
xil_printf("Bye ");
xil_printf("Bye ");
return 0;

// Manual mapping
//	for (j=0, gx=8; j<20; j+=2, gx+=20) {
//		i = (me->gameboard[j][0] << 24) | (me->gameboard[j][1] << 16) | (me->gameboard[j][2] << 8) | me->gameboard[j][3];
//		TETRIS_VGA_mWriteReg(TETRIS_VGA_START, gx, i);
//		i = (me->gameboard[j][4] << 24) | (me->gameboard[j][5] << 16) | (me->gameboard[j][6] << 8) | me->gameboard[j][7];
//		TETRIS_VGA_mWriteReg(TETRIS_VGA_START, gx+4, i);
//		i = (me->gameboard[j][8] << 24) | (me->gameboard[j][9] << 16) | (me->gameboard[j+1][0] << 8) | me->gameboard[j+1][1];
//		TETRIS_VGA_mWriteReg(TETRIS_VGA_START, gx+8, i);
//		i = (me->gameboard[j+1][2] << 24) | (me->gameboard[j+1][3] << 16) | (me->gameboard[j+1][4] << 8) | me->gameboard[j+1][5];
//		TETRIS_VGA_mWriteReg(TETRIS_VGA_START, gx+12, i);
//		i = (me->gameboard[j+1][6] << 24) | (me->gameboard[j+1][7] << 16) | (me->gameboard[j+1][8] << 8) | me->gameboard[j+1][9];
//		TETRIS_VGA_mWriteReg(TETRIS_VGA_START, gx+16, i);
//	}

xil_printf("I0 %x\n", I0);
xil_printf("I1 %x\n", I1);
xil_printf("I2 %x\n", I2);
xil_printf("I3 %x\n", I3);
xil_printf("J0 %x\n", J0);
xil_printf("J1 %x\n", J1);
xil_printf("J2 %x\n", J2);
xil_printf("J3 %x\n", J3);
xil_printf("L0 %x\n", L0);
xil_printf("L1 %x\n", L1);
xil_printf("L2 %x\n", L2);
xil_printf("L3 %x\n", L3);
xil_printf("O0 %x\n", O0);
xil_printf("O1 %x\n", O1);
xil_printf("O2 %x\n", O2);
xil_printf("O3 %x\n", O3);
xil_printf("T0 %x\n", T0);
xil_printf("T1 %x\n", T1);
xil_printf("T2 %x\n", T2);
xil_printf("T3 %x\n", T3);
xil_printf("S0 %x\n", S0);
xil_printf("S1 %x\n", S1);
xil_printf("S2 %x\n", S2);
xil_printf("S3 %x\n", S3);
xil_printf("N0 %x\n", N0);
xil_printf("N1 %x\n", N1);
xil_printf("N2 %x\n", N2);
xil_printf("N3 %x\n", N3);

#endif // SCRATCH

#ifdef COMMENT

#include "tetris.h"

#define TETRIS_VGA_START 				0xC9A00000
#define RESET_VALUE                 	100000000	// 100M at 50Mhz (20ns/cycle) ~= 2s
#define DEBOUNCE_TIME 	                125000	    // * 20ns = 2.5ms


// Globals
// -- system vars
static  Xuint32         top;
static  Xuint32         ret = 0x01234567;
static  Xuint32         cnt = 0;
static  unsigned char   click = 0;
static  Xuint32			enc = 0;
static	Xuint32			fall_time = 100000000;

// -- system objs
static  XIntc           sys_intc;
static  XTmrCtr         sys_tmrctr;
static  XTmrCtr         sys_tmrfall;
static  XGpio           sys_buttons;
static  XGpio           sys_encoder;
static  XGpio           leds;
static  QEvent          l_tetrisQueue[30];

QActiveCB const Q_ROM Q_ROM_VAR QF_active[] = {
	{ (QActive *)0,            (QEvent *)0,          0                    },
	{ (QActive *)&Game,        l_tetrisQueue,        Q_DIM(l_tetrisQueue) }
};

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
	XTmrCtr_Initialize(&sys_tmrfall, XPAR_FALL_TIMER_DEVICE_ID);

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

    /* fall timer interrupt cfg */
	XIntc_Connect(&sys_intc,XPAR_XPS_INTC_0_FALL_TIMER_INTERRUPT_INTR,
			(XInterruptHandler)fall_handler, &sys_tmrfall);
    XIntc_Enable(&sys_intc, XPAR_XPS_INTC_0_FALL_TIMER_INTERRUPT_INTR);

    /* button interrupt cfg */
	XIntc_Connect(&sys_intc,XPAR_XPS_INTC_0_CLICK_IP2INTC_IRPT_INTR,
			(XInterruptHandler)button_handler, &sys_buttons);
	XGpio_InterruptGlobalEnable(&sys_buttons);
	XGpio_InterruptEnable(&sys_buttons,XPAR_XPS_INTC_0_CLICK_IP2INTC_IRPT_INTR);
	XIntc_Enable(&sys_intc, XPAR_XPS_INTC_0_CLICK_IP2INTC_IRPT_INTR);

    /* encoder interrupt cfg */
	XIntc_Connect(&sys_intc,XPAR_XPS_INTC_0_ENCODER_IP2INTC_IRPT_INTR,
			(XInterruptHandler)encoder_handler, &sys_encoder);
	XGpio_InterruptGlobalEnable(&sys_encoder);
	XGpio_InterruptEnable(&sys_encoder,XGPIO_IR_CH1_MASK);
	XIntc_Enable(&sys_intc, XPAR_XPS_INTC_0_ENCODER_IP2INTC_IRPT_INTR);

    // Enable VGA
    TETRIS_VGA_EnableInterrupt((void*)TETRIS_VGA_START);
    //TETRIS_VGA_mWriteReg(TETRIS_VGA_START, TETRIS_VGA_INTR_IPIER_OFFSET, 0x00000001);
    //TETRIS_VGA_mWriteReg(TETRIS_VGA_START, TETRIS_VGA_INTR_DIER_OFFSET, INTR_TERR_MASK | INTR_DPTO_MASK | INTR_IPIR_MASK);
    //TETRIS_VGA_mWriteReg(TETRIS_VGA_START, TETRIS_VGA_INTR_DGIER_OFFSET, INTR_GIE_MASK);
    TETRIS_VGA_mWriteReg(TETRIS_VGA_START, 0, 1);

    // Configure Timers
    XTmrCtr_SetOptions(&sys_tmrctr, 0, XTC_INT_MODE_OPTION);
	XTmrCtr_SetResetValue(&sys_tmrctr, 0, 0xFFFFFFFF-DEBOUNCE_TIME);
    XTmrCtr_SetOptions(&sys_tmrfall, 0, XTC_INT_MODE_OPTION | XTC_AUTO_RELOAD_OPTION);
	XTmrCtr_SetResetValue(&sys_tmrfall, 0, 0xFFFFFFFF-fall_time);

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
			//XGpio_DiscreteWrite(&leds,1,i>>8);
		}


		IpStatus = TETRIS_VGA_mReadReg(baseaddr, TETRIS_VGA_INTR_IPISR_OFFSET);
		TETRIS_VGA_mWriteReg(baseaddr, TETRIS_VGA_INTR_IPISR_OFFSET, IpStatus);
	}
	XIntc_Start(&sys_intc, XIN_REAL_MODE);
}

void button_handler()
{
	XIntc_Stop(&sys_intc);
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
	XIntc_Start(&sys_intc, XIN_REAL_MODE);
}

void encoder_handler()
{
	char tmp;

	XIntc_Stop(&sys_intc);
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
	XIntc_Start(&sys_intc, XIN_REAL_MODE);
}

void timer_handler()
{
	Xuint32 status;

	XIntc_Stop(&sys_intc);

	/* Check what kicked off the timer */
	if (click) {
	    QActive_postISR((QActive *)&Game, ROTATE);
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
				QActive_postISR((QActive *)&Game, LEFT);
				enc = 0;
				break;
			// Check Up sequences
			case 0x35:	// 1-1-3	2% false
			case 0x2E:	// 1-3-2	0% false
			case 0x15:	// 1-1-1	5% false
			case 0x0B:	// 3-2-0	0% false
				QActive_postISR((QActive *)&Game, RIGHT);
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

	XIntc_Start(&sys_intc, XIN_REAL_MODE);
}

void fall_handler() {
	XIntc_Stop(&sys_intc);
	QActive_postISR((QActive *)&Game, FALL);
	XIntc_Start(&sys_intc, XIN_REAL_MODE);
}

#endif // COMMENT
