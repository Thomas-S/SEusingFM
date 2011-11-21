#define N 5

active proctype ARRAY() {
	int a[N];
	int prod = 0;
	
	/* === */
	byte i;
	
	/* non-deterministically choose value from 1 to 5 */
	for (i in a) {
		if
			:: true -> a[i] = 1
			:: true -> a[i] = 2
			:: true -> a[i] = 3
			:: true -> a[i] = 4
			:: true -> a[i] = 5
		fi
	}
	
	/* CAUTION */
	/* setting 'prod' multiplicatively neutral */
	prod = 1;
	
	/* compute product */
	/* MIN-value = 1 */
	/* MAX-value = 3125 */
	for (i : 0 .. N-1) {
		prod = prod * a[i];
	}
	
	/* === */
	
	printf("The product is: %d\n", prod)
}