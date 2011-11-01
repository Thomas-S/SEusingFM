active proctype P() {
  byte range = 5;
  if
    :: range = 0 
    :: range = 1
    :: range = 2
    :: range = 3
    :: range = 4
  fi;
  printf("Range is %d\n",range)
}

