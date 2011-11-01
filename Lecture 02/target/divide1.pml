/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

active proctype P() {
  int dividend = 12;
  int divisor  = 4;
  int quotient, remainder;

  quotient = 0;
  remainder = dividend;
  do
    :: remainder >= divisor ->
       quotient++;
       remainder = remainder - divisor
    :: else ->
       break
  od;
  assert ( dividend == divisor * quotient + remainder );
  printf("%d divided by %d = %d, remainder = %d\n",
         dividend, divisor, quotient, remainder);
}

