active proctype P() {
  bit  b1 = 0;
  bool b2 = 1;
  printf("%d\n", b2 == 3); /* is false */
  printf("%d\n", b1 < b2); /* is true */
  b2 = 3;
  printf("%d\n", b2); /* raises error */
}
