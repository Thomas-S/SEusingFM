#define NUM_PHIL 4

byte forks[NUM_PHIL];

proctype phil(int id) {
byte fork1, fork2;

fork1 = (id == 0 -> NUM_PHIL - 1 : id - 1);
fork2 = id;

do 
  ::printf("Philosopher %d is thinking\n", id);

  // Simultaneous check & set operations to
  // avoid interleaving 
  atomic {
    forks[fork1] == 0 && forks[fork2] == 0;	
    forks[fork1]++;
    forks[fork2]++;
  }

  // Task (1)
  byte i;
  for (i in forks) {
    assert(forks[i] <= 1);
  }

  printf("Philosopher %d is eating with forks %d and %d\n", id, fork2, fork1);
  
  atomic {
    forks[fork1]--;
    forks[fork2]--;
  }

od
}

init {
int i = 0; 
do 
:: i >= NUM_PHIL -> break
:: else -> run phil(i); 
           i++ 
od 
}

// Task (3)
ltl forksME { [] (forks[0] <= 1 && forks[1] <= 1 && forks[2] <= 1 && forks[3] <= 1) }
