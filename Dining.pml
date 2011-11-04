#define NUM_PHIL 4

// Fork is true <=> it is in use
bool forks[5];

proctype phil(int id) {
do 
  ::
  	printf("Philosopher %d is thinking\n", id);
  	
  	// TODO: Fork id space must be circular!
  	
  	atomic {
  		!forks[id] && !forks[id+1];
  		forks[id] = true;
  		forks[id+1] = true;
  	}
  	
  	printf("Philosopher %d is eating\n", id);
  	
  	atomic {  		
  		forks[id] = false;
  		forks[id+1] = false;
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