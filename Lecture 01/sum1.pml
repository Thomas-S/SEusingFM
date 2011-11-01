#define N 5
active proctype P() {
  int sum = 0, i;
 for (i : 1 .. N) {
    sum = sum + 1
  };
  printf("The sum is %d\n", sum)
}
