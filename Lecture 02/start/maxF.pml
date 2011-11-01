active proctype P() {
  byte a, b, max;

  /* non-deterministically choose
     a and b from {1,2,3} */
  if
    :: a = 1
    :: a = 2
    :: a = 3
  fi;
  if
    :: b = 1
    :: b = 2
    :: b = 3
  fi;

  /* compute max */
  if
    :: a >= b -> max = a
    :: a <= b -> max = b+1
  fi;

  assert (max == (a > b -> a : b))

}
