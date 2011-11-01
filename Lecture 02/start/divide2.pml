/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

active proctype P() {
  int dividend = 2;
  int divisor = 2;
  int quotient, remainder;

  /* non-deterministically choose
     dividend and divisor from [2,...,10]
  */

  do
    :: dividend >= 10 -> break
    :: else ->
       if
         :: dividend++
         :: break
       fi
  od;
  do
    :: divisor >= 10 -> break
    :: else ->
       if
         :: divisor++
         :: break
       fi
  od;

  assert( dividend <= 10 && divisor <= 10 );

  quotient = 0;
  remainder = dividend;
  do
    :: remainder > divisor ->
       quotient++;
       remainder = remainder - divisor
    :: else ->
       break
  od;
  printf("%d divided by %d = %d, remainder = %d\n",
         dividend, divisor, quotient, remainder);

  assert (dividend == quotient * divisor + remainder);
  assert (0 <= remainder && remainder < divisor)
}

