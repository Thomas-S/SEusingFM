	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC SIMPLE */

	case 3: /* STATE 2 */
		;
		((P0 *)this)->_1_y = trpt->bup.ovals[1];
		((P0 *)this)->_1_x = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 4: /* STATE 4 */
		;
		p_restor(II);
		;
		;
		goto R999;
	}

