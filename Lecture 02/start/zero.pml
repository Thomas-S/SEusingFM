int a, b, c;

active proctype P() {
  a = 1;
  b = 1;
  c = 1;
  if
    :: a != 0 -> c = b / a
    :: else -> c = b
  fi;
  printf("a == %d, b == %d, c == %d\n", a, b, c); 
}

active proctype Q() {
  a = 0
}
