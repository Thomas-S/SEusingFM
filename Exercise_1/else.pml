/* This process always evaluates the 2nd alternative. */

active proctype TRUE() {
if
	/* REASON: The 2nd alternative is chosen BECAUSE */
	/* 		   the 1st alternative is false */
	:: false -> printf("1\n")
	:: else -> printf("2\n")
fi
}