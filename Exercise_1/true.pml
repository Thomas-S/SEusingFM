/* This process always evaluates the 2nd alternative. */

active proctype TRUE() {
if
	/* Reason: ONLY the 2nd alternative is true */
	:: false -> printf("1\n")
	:: true -> printf("2\n")
fi
}