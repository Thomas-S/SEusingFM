#define N 5
active proctype P() {
  byte a[N];
  byte sum = 0, i = 0;
  a[0] = 0; a[1] = 10; a[2] = 20; a[3] = 30; a[4] = 40;
  do 
    :: i > N-1 -> goto exitloop;
    :: else    -> sum = sum + a[i];
		  i++
  od;
exitloop:
  printf("The sum is %d\n", sum)
}
