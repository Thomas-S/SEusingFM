/* example of non-deterministic evaluation */

active proctype NONDET() {
do
	/* if more than one guard evaluates to true: */
	/* => an alternative is randomly chosen */
	::   true -> printf("1\n");
	::   true ; printf("2\n");
	::   printf("3\n")
od
}