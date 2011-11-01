/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

active proctype P() {
  int x = 1, y = 1;
  int a, b;

  do
    :: x >= 10 -> break
    :: else ->
       if
         :: x++
         :: break
       fi
  od;

  do
    :: y >= 10 -> break
    :: else ->
       if
         :: y++
         :: break
       fi
  od;

  a = x; b = y;
  do
    :: a > b -> a = a - b
    :: b > a -> b = b - a
    :: a == b -> break
  od;
  printf("The GCD of %d and %d = %d\n", x, y, a);
  assert (x % a == 0 && y % a == 0);
  assert (a == b);
}
