
#include "qpn_port.h"

typedef struct Lab2BTag  {               //Lab2A State machine
	QActive super;

	char tmp[9];	// Temp string for editing
	char str[9];	// Saved string
	char cursor;	// Cursor location - must be set to 0 when going to a new menu
}  Lab2B;

/* Setup state machines */
/**********************************************************************/
static QState Lab2B_initial (Lab2B *me);
static QState Lab2B_on      (Lab2B *me);
static QState MENU  		(Lab2B *me);
static QState DISPLAY  		(Lab2B *me);
static QState EDIT  		(Lab2B *me);
static QState EDIT_LETTER  	(Lab2B *me);

/**********************************************************************/


Lab2B AO_Lab2B;


void Lab2B_ctor(void)  {
	Lab2B *me = &AO_Lab2B;
	QActive_ctor(&me->super, (QStateHandler)&Lab2B_initial);
	strcpy(me->str, "<none>");
	strcpy(me->tmp, "AAAAAAAA");
	me->cursor = 0;
}


/* Create Lab2B_on state and do any initialization code if needed */
/******************************************************************/

QState Lab2B_initial(Lab2B *me) {
	xil_printf("\n\rInitialization");
    return Q_TRAN(&Lab2B_on);
}

QState Lab2B_on(Lab2B *me) {
	switch (Q_SIG(me)) {
		case Q_ENTRY_SIG: {
			xil_printf("\n\rOn");
			}

		case Q_INIT_SIG: {
			return Q_TRAN(&MENU);
			}
	}

	return Q_SUPER(&QHsm_top);
}

QState MENU(Lab2B *me) {
	//WriteString("MENU");
	switch (Q_SIG(me)){
          case Q_ENTRY_SIG: {
			me->cursor = 0;
			DisplayClear();
			DisplayOnOff(1,0,1);
			SetCursor(1,1);
			WriteString("EDIT     DISPLAY");
			SetCursor(1,1);
			return Q_HANDLED();
			}

          case ENCODER_CLICK:  {
			if(!(me->cursor)) {
                 return Q_TRAN(&EDIT);
                 }
            else {
                 return Q_TRAN(&DISPLAY);
                 }
	      }

      	  case ENCODER_UP: {
	        me->cursor = (me->cursor + 1) % 2;
	        if (me->cursor)
	        	SetCursor(1,10);
	        else
	        	SetCursor(1,1);
			return Q_HANDLED();
      	  }

		  case ENCODER_DOWN: {
	        me->cursor = (me->cursor - 1) % 2;
	        if (me->cursor)
	        	SetCursor(1,10);
	        else
	        	SetCursor(1,1);
			return Q_HANDLED();
		}
	}
	return Q_SUPER(&Lab2B_on);
}

QState DISPLAY(Lab2B *me) {
	switch (Q_SIG(me)) {
		case Q_ENTRY_SIG: {
			DisplayClear();
			DisplayOnOff(1,0,1);
			WriteString(me->str);
			SetCursor(2,1);
			WriteString("Back");
			SetCursor(2,1);
			return Q_HANDLED();
			}
		 case ENCODER_CLICK:  {
            return Q_TRAN(&MENU);
            }

      	  case ENCODER_UP: {
            return Q_HANDLED();
            }

		  case ENCODER_DOWN: {
			return Q_HANDLED();
	        }
	}
	return Q_SUPER(&Lab2B_on);
}


QState EDIT(Lab2B *me) {
	switch (Q_SIG(me)) {
	case Q_ENTRY_SIG: {
		me->cursor = 0;
		strcpy(me->tmp, "AAAAAAAA");
		DisplayClear();
		DisplayOnOff(1,0,1);
		SetCursor(1,1);
		WriteString("AAAAAAAA");
		SetCursor(2,1);
		WriteString("Back");
		SetCursor(2,13);
		WriteString("Save");
		SetCursor(1,1);
		DisplayOnOff(1,0,1);
		return Q_HANDLED();
	}
	case ENCODER_UP: {
		// inc cursor position
		me->cursor = (me->cursor + 1) % 10;

		// Select character
		if (me->cursor < 8)
			SetCursor(1,me->cursor+1);
		// Select Back
		else if (me->cursor == 8)
			SetCursor(2,1);
		// Select Save
		else
			SetCursor(2,13);
		return Q_HANDLED();
	}
	case ENCODER_DOWN: {
		// inc cursor position
		me->cursor = (me->cursor) ? (me->cursor - 1) % 10 : 9;

		// Select character
		if (me->cursor < 8)
			SetCursor(1,me->cursor+1);
		// Select Back
		else if (me->cursor == 8)
			SetCursor(2,1);
		// Select Save
		else
			SetCursor(2,13);
		return Q_HANDLED();
	}
	case ENCODER_CLICK: {
		// Select character
		if (me->cursor < 8) {
			return Q_TRAN(&EDIT_LETTER);
		// Select Back
		} else if (me->cursor == 8) {
			write_leds(0xCC);
			return Q_TRAN(&MENU);
		// Select Save
		} else {
			write_leds(0xff);
			strcpy(me->str, me->tmp);
			return Q_TRAN(&MENU);
		}
	}
	}
	return Q_SUPER(&Lab2B_on);
}

QState EDIT_LETTER (Lab2B *me) {
	switch (Q_SIG(me)) {
	case Q_ENTRY_SIG: {
		DisplayOnOff(1,1,0);	// Turn off blinking, but add the line to show what is changing
		SetCursor(1,me->cursor+1);
		return Q_HANDLED();
	}
	case Q_EXIT_SIG: {
		DisplayOnOff(1,0,1);	// Turn blinking back on
		return Q_HANDLED();
	}
	case ENCODER_UP: {
		if ( (me->tmp[(int)me->cursor] >= 'A' && me->tmp[(int)me->cursor] < 'Z') ||
			 (me->tmp[(int)me->cursor] >= '0' && me->tmp[(int)me->cursor] < '9') ) {
			me->tmp[(int)me->cursor]++;
		} else if (me->tmp[(int)me->cursor] == 'Z') {
			me->tmp[(int)me->cursor] = '0';
		} else {
			// '9' or anything else - go to 'A'
			me->tmp[(int)me->cursor] = 'A';
		}
		PutChar(me->tmp[(int)me->cursor]);
		SetCursor(1,me->cursor+1);
		return Q_HANDLED();
	}
	case ENCODER_DOWN: {
		if ( (me->tmp[(int)me->cursor] > 'A' && me->tmp[(int)me->cursor] <= 'Z') ||
			 (me->tmp[(int)me->cursor] > '0' && me->tmp[(int)me->cursor] <= '9') ) {
			me->tmp[(int)me->cursor]--;
		} else if (me->tmp[(int)me->cursor] == 'A') {
			me->tmp[(int)me->cursor] = '9';
		} else if (me->tmp[(int)me->cursor] == '0') {
			me->tmp[(int)me->cursor] = 'Z';
		} else {
			// anything else - go to 'A'
			me->tmp[(int)me->cursor] = 'A';
		}
		PutChar(me->tmp[(int)me->cursor]);
		SetCursor(1,me->cursor+1);
		return Q_HANDLED();
	}
	case ENCODER_CLICK: {
		return Q_TRAN(&EDIT);
	}
	}
	return Q_SUPER(&EDIT);
}
