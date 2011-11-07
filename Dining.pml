#define NUM_PHIL 4

// Fork is true <=> it is in use
bool forks[NUM_PHIL];

proctype phil(int id) {
byte firstFork = id;
byte secondFork = (id == NUM_PHIL-1 -> 0 : firstFork+1);

do 
  ::
  	printf("Philosopher %d is thinking\n", id);
  	
  	// TODO: Fork id space must be circular!
  	
  	atomic {
  		!forks[firstFork] && !forks[secondFork];
  		forks[firstFork] = true;
  		forks[secondFork] = true;
  	}
  	
  	printf("Philosopher %d is eating\n", id);
  	
  	atomic {  		
  		forks[firstFork] = false;
  		forks[secondFork] = false;
  	}
od
}

init {
int j = 0;
int i = 0; 

for (j in forks) {
	forks[j] = false;
}

do 
:: i >= NUM_PHIL -> break
:: else -> run phil(i); 
           i++ 
od 
}