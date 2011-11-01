/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */
/* makro expansion by hand: Wolfgang Ahrendt */

byte    n = 0;

proctype P() {
    byte temp;
    byte i = 1;
    do
    :: i > 2 -> break
    :: else ->
       temp = n;
       n = temp + 1;
       i++
    od;
    assert(i == 3)
}

init {
    atomic {
        run P();
        run P()
    }
    (_nr_pr == 1);
    printf("The value is %d\n", n)
}

