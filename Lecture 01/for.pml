#define N 10 /* symbol definition C-like preprocessing */

active proctype P() {
  int sum = 0; byte i = 1;
  do 
  :: i > N -> break;
  :: else -> sum = sum + i; i++
  od
}
