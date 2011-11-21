active proctype SIMPLE() {
int x = 0;
int y;
x++;
y = x;
assert(y == 1);
}