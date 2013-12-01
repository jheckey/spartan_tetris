#include "tetris.h"
#include <stdlib.h>
#include <string.h>
#include "qpn_port.h"

// Tetraminos
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
static const char    J0[4][4] = { {1, 1, 1, 0},
                     {0, 0, 1, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
static const char    J1[4][4] = { {0, 1, 1, 0},
                     {0, 0, 1, 0},
                     {0, 0, 1, 0},
                     {0, 0, 0, 0} };
static const char    J2[4][4] = { {0, 0, 1, 0},
                     {1, 1, 1, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
static const char    J3[4][4] = { {1, 0, 0, 0},
                     {1, 0, 0, 0},
                     {1, 1, 0, 0},
                     {0, 0, 0, 0} };
static const char    L0[4][4] = { {5, 5, 5, 0},
                     {5, 0, 0, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
static const char    L5[4][4] = { {5, 5, 0, 0},
                     {0, 5, 0, 0},
                     {0, 5, 0, 0},
                     {0, 0, 0, 0} };
static const char    L2[4][4] = { {0, 0, 5, 0},
                     {5, 5, 5, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
static const char    L3[4][4] = { {5, 0, 0, 0},
                     {5, 0, 0, 0},
                     {5, 5, 0, 0},
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
static const char    T1[4][4] = { {0, 7, 0, 0},
                     {7, 7, 0, 0},
                     {0, 7, 0, 0},
                     {0, 0, 0, 0} };
static const char    T2[4][4] = { {0, 7, 0, 0},
                     {7, 7, 7, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
static const char    T3[4][4] = { {0, 7, 0, 0},
                     {0, 7, 7, 0},
                     {0, 7, 0, 0},
                     {0, 0, 0, 0} };
static const char    S0[4][4] = { {0, 2, 2, 0},
                     {2, 2, 0, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
static const char    S1[4][4] = { {2, 0, 0, 0},
                     {2, 2, 0, 0},
                     {0, 2, 0, 0},
                     {0, 0, 0, 0} };
static const char    S2[4][4] = { {0, 2, 2, 0},
                     {2, 2, 0, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
static const char    S3[4][4] = { {2, 0, 0, 0},
                     {2, 2, 0, 0},
                     {0, 2, 0, 0},
                     {0, 0, 0, 0} };
static const char    N0[4][4] = { {4, 4, 0, 0},
                     {0, 4, 4, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
static const char    N1[4][4] = { {0, 4, 0, 0},
                     {4, 4, 0, 0},
                     {4, 0, 0, 0},
                     {0, 0, 0, 0} };
static const char    N2[4][4] = { {4, 4, 0, 0},
                     {0, 4, 4, 0},
                     {0, 0, 0, 0},
                     {0, 0, 0, 0} };
static const char    N3[4][4] = { {0, 4, 0, 0},
                     {4, 4, 0, 0},
                     {4, 0, 0, 0},
                     {0, 0, 0, 0} };


// typedefs
/*
typedef struct Tableau_t {
	int		x;
	int		y;
	int		dx;
	int		dy;
    char*   tetramino;
} Tableau;
*/

typedef struct Tetris_t {
    QActive super;

    int     score;
    int     level;

    int		x, dx;
    int		y, dy;

    char** 	next;
    char** 	tetramino;
    char    gameboard[20][10];
} Tetris;

Tetris Game;

/* Setup state machines */
/**********************************************************************/
static QState Tetris_initial	(Tetris *me);
static QState Tetris_on      	(Tetris *me);
static QState Tetris_play		(Tetris *me);
static QState Tetris_next		(Tetris *me);

/**********************************************************************/

char**	get_next();
char	check_move(Tetris* me, int dx, int dy);

void Tetris_ctor(void)  {
	Tetris *me = &Game;
	QActive_ctor(&me->super, (QStateHandler)&Tetris_initial);
	me->score = 0;
	me->level = 1;
	me->x = 3;		// Center Tetramino to start
	me->y = 0;
	me->dx = 0;
	me->dy = 0;
	me->next = NULL;
	me->tetramino = NULL;
	memset(me->gameboard, 0, 200);
}


QState Tetris_initial(Tetris *me) {
	xil_printf("\n\rInitialization");
    return Q_TRAN(&Tetris_on);
}

QState Tetris_on(Tetris *me) {
	switch (Q_SIG(me)) {
		case Q_ENTRY_SIG: {
			xil_printf("Click to Play \n");
		}

		case ROTATE: {
			memset(me->gameboard, 0, 200);
			return Q_TRAN(&Tetris_play);
		}
	}

	return Q_SUPER(&QHsm_top);
}

QState Tetris_play(Tetris *me) {
	switch (Q_SIG(me)){
          case Q_ENTRY_SIG: {
        	  xil_printf("Game started\n");
        	  me->score = 0;
        	  me->level = 1;
        	  me->x = 3;		// Center Tetramino to start
        	  me->y = 0;
        	  me->dx = 0;
        	  me->dy = 0;
        	  me->next = get_next();
        	  me->tetramino = get_next();
        	  return Q_HANDLED();
          }

          case Q_EXIT_SIG: {
        	  xil_printf("Game started\n");
        	  me->next = NULL;
        	  me->tetramino = NULL;
        	  return Q_HANDLED();
          }

          case ROTATE:  {
        	  return Q_HANDLED();
	      }

      	  case LEFT: {
      		  return Q_HANDLED();
      	  }

		  case RIGHT: {
			  return Q_HANDLED();
		  }

		  case FALL: {
			  if (check_move(me, 0, 1)) {
				  me->dy++;
			  } else {
				  // Check for game over
				  if (me->y + me->dy == 0) {
					  return Q_TRAN(&Tetris_on);
				  }
				  return Q_TRAN(&Tetris_next);
			  }
			  return Q_HANDLED();
		  }
	}
	return Q_SUPER(&Tetris_on);
}

QState Tetris_next(Tetris *me) {
	switch (Q_SIG(me)){
          case Q_ENTRY_SIG: {
        	  xil_printf("Wait for next \n");
        	  return Q_HANDLED();
          }

          case FALL: {
        	  // Update tetramino
        	  me->tetramino = me->next;
        	  me->next = get_next();
        	  return Q_TRAN(&Tetris_play);
          }

          // Do nothing until next fall to ensure screen is updated
          case ROTATE:
          case LEFT:
		  case RIGHT:
			  return Q_HANDLED();
	}
	return Q_SUPER(&Tetris_play);
}

char** get_next() {
	char	id = rand() % 7;
	int 	sel = rand() & 3;
	// Each tetramino is 16 bytes (4x4 char)
	switch (id) {
	case 0:		return (char**)((int)I0 + ((sel&1)<<16));
	case 1:		return (char**)((int)J0 + (sel<<16));
	case 2:		return (char**)((int)L0 + (sel<<16));
	case 3:		return (char**)((int)O0);
	case 4:		return (char**)((int)T0 + (sel<<16));
	case 5:		return (char**)((int)S0 + ((sel&1)<<16));
	case 6:		return (char**)((int)N0 + ((sel&1)<<16));
	}
	return (char**)O0;
}

char check_move(Tetris* me, int dx, int dy) {
	int i, j, gy, gx;
	// Get gameboard coordinates
	gx = me->x + me->dx + dx;
	gy = me->y + me->dy + dy;
	for (i=0; i<4; i++, gy++) {
		for (j=0; j<4; j++, gx++) {
			if (gy >= 20)
				return 0;	// Off board
			if (me->tetramino[i][j] && (gx < 0 || gx > 9))
				return 0;	// Off board
			if (me->tetramino[i][j] && me->gameboard[gy][gx])
				return 0;	// move will cause overlap
		}
	}
	return 1;
}
