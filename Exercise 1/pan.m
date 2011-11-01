#define rand	pan_rand
#if defined(HAS_CODE) && defined(VERBOSE)
	cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC SIMPLE */
	case 3: /* STATE 1 - simple.pml:4 - [x = (x+1)] (0:4:2 - 1) */
		IfNotBlocked
		reached[0][1] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((P0 *)this)->_1_x;
		((P0 *)this)->_1_x = (((P0 *)this)->_1_x+1);
#ifdef VAR_RANGES
		logval("SIMPLE:x", ((P0 *)this)->_1_x);
#endif
		;
		/* merge: y = x(4, 2, 4) */
		reached[0][2] = 1;
		(trpt+1)->bup.ovals[1] = ((P0 *)this)->_1_y;
		((P0 *)this)->_1_y = ((P0 *)this)->_1_x;
#ifdef VAR_RANGES
		logval("SIMPLE:y", ((P0 *)this)->_1_y);
#endif
		;
		/* merge: assert((y==1))(4, 3, 4) */
		reached[0][3] = 1;
		spin_assert((((P0 *)this)->_1_y==1), "(y==1)", II, tt, t);
		_m = 3; goto P999; /* 2 */
	case 4: /* STATE 4 - simple.pml:7 - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][4] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

