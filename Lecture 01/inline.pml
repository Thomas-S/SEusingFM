typedef DATE {
  byte day, month, year;
}

inline printDate(D) {
  printf("%d", D.year);
  if
    :: D.month < 10 -> printf("0%d", D.month)
    :: else         -> printf("%d", D.month)
  fi;
  if
    :: D.day < 10 -> printf("0%d\n", D.day)
    :: else       -> printf("%d\n", D.day)
  fi
}

inline setDate(D, DD, MM, YY) {
  D.day = DD;
  D.month = MM;
  D.year = YY
}

active proctype P() {
  DATE d;
  setDate(d,1,7,62);
  printDate(d)
}
