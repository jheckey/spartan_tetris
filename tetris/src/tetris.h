
//#include "qpn_port.h"


enum TetrisSignals {
	RIGHT = Q_USER_SIG,
	LEFT,
	ROTATE,
    FALL
};

// Prototypes
void    Tetris_ctor(void);
int     sys_init();
void    vga_handler();
void    button_handler();
void    encoder_handler();
void    timer_handler();
void	fall_handler();
//void    QF_onStartup(void);
//void    QF_onIdle(void);

extern struct Tetris_t Game;
