package maze;
public class Maze {

	// CONSTANTS -- MOVE
	public final static int MOVE_UP    = 0;
	public final static int MOVE_DOWN  = 1;
	public final static int MOVE_LEFT  = 2;
	public final static int MOVE_RIGHT = 3;

	// CONSTANTS -- FIELDS    
	public final static int FREE = 0;
	public final static int WALL = 1;
	public final static int EXIT = 2;

	// playfield
	/** The playfield is given as a rectangle where
	- walls are represented by entries of value Maze.WALL ('1')
	- the exit is represented as an entry of value Maze.EXIT ('2')
        - all other entries are MAZE.FREE ('0')
       	- A playfield has <em>exactly</em> one exit.
	- The first number determines the column, the second determines
	the row. Row and column numbers start at 0. 
        - Each row has the same number of columns.        

	Example: 6x6 maze with an exit at position (5,3) (5th row, 3rd
	column):

	0 1 1 1 1 0
	0 0 0 0 0 0
	1 1 1 1 0 1
	0 1 0 0 0 1
	0 0 0 1 0 0
	1 1 0 2 1 0

	 */   	

	/*@ 
      public invariant 
      (\exists int colNr; colNr >= 0; 
      (\forall int row; row >= 0 && row < maze.length;
      maze[row].length == colNr));
      @*/      

	/*@ 
      public invariant 
      (\forall int row; row >= 0 && row < maze.length;
      (\forall int col; col >= 0 && col < maze[row].length;
      maze[row][col] >= FREE && maze[row][col] <= EXIT));
      @*/      

	/*@ 
      public invariant 
      (\exists int row; row >= 0 && row < maze.length;
      (\exists int col; col >= 0 && col < maze[row].length;
      maze[row][col] == EXIT && 
      (\forall int row2;(\forall int col2;
      (row2 >= 0 && row2 < maze.length && 
      col2 >= 0 && col2 < maze[row].length);
      maze[row2][col2] == EXIT ==> (row2 == row && col2 == col)))));
      @*/
	private /*@ spec_public @*/ int[][] maze;

	/** Player Position:
	the position of a player must always denote a field inside the maze
	which is not a wall
	 */
	/*@ 
      private invariant 
      playerRow >= 0 && playerRow < maze.length &&
      (playerCol >= 0 && playerCol < maze[playerRow].length && maze[playerRow][playerCol] != WALL);       
      @*/
	private /*@ spec_public @*/ int playerRow, playerCol;


	public Maze(int[][] maze, int startRow, int startCol) {
		this.maze = maze;
		// set player on start position
		this.playerRow = startRow;
		this.playerCol = startCol;	
	}

	/**
	 * returns true if the player has reached the exit field; 
	 * the method does not affect the state 
	 */
	/*@ public normal_behavior
      @ ensures \result == (maze[playerRow][playerCol] == EXIT);
      @*/
	public /*@ pure @*/ boolean won() {
                // TO BE IMPLEMENTED
                throw new RuntimeException();
	}

	/** 
	 * A move to position (newRow,newCol) is possible iff. the
	 * field is inside the maze and free (i.e. not a wall); 
	 * the method does not affect the state 
	 */    
	/*@ public normal_behavior
      @   requires newRow >= 0 && newCol >= 0 && 
      @             newRow < maze.length && newCol < maze[newRow].length;	                      
      @   ensures \result == (maze[newRow][newCol] != WALL);
      @
      @ also 
      @
      @ public normal_behavior
      @    requires !(newRow >= 0 && newCol >= 0 && 
      @              newRow < maze.length && newCol < maze[newRow].length);	                      
      @    ensures !\result;
      @*/
	public /*@ pure @*/ boolean isPossible(int newRow, int newCol) {
		// check if inside maze
                // TO BE IMPLEMENTED
                throw new RuntimeException();
	}


	/**
	 * takes a direction and performs the move if possible, otherwise
	 * the player stays at the current position; the direction must be
	 * one of the defined move directions (see constants
	 * MOVE_xyz). The return value indicates if the move was successful.
	 */
	/*@ public normal_behavior 
      @  requires direction >= MOVE_UP && direction <= MOVE_RIGHT &&
      @     isPossible(playerRow +  
      @                            (direction == MOVE_UP ? -1 : direction == MOVE_DOWN ? 1 : 0),
      @                playerCol + 
      @                            (direction == MOVE_LEFT ? -1 : direction == MOVE_RIGHT ? 1 : 0));
      @  ensures \result &&
      @              (playerRow == \old(playerRow) + 
      @                (direction == MOVE_UP ? -1 : direction == MOVE_DOWN ? 1 : 0)) &&
      @    	    (playerCol == \old(playerCol) + 
      @                (direction == MOVE_LEFT ? -1 : direction == MOVE_RIGHT ? 1 : 0));
      @  assignable playerRow, playerCol;   
      @
      @ also
      @
      @ public normal_behavior
      @   requires direction >= MOVE_UP && direction <= MOVE_RIGHT &&
      @     !isPossible(playerRow +  
      @                            (direction == MOVE_UP ? -1 : direction == MOVE_DOWN ? 1 : 0),
      @                playerCol + 
      @                            (direction == MOVE_LEFT ? -1 : direction == MOVE_RIGHT ? 1 : 0));
      @    ensures !\result;              
      @	 assignable \nothing;
      @
      @ also
      @
      @ public exceptional_behavior
      @   requires direction < 0 || direction > 3;
      @   assignable \nothing;
      @*/
	public boolean move(int direction) {
		int newRow = playerRow;
		int newCol = playerCol;

		switch (direction) {
		case MOVE_UP:
			newRow = newRow - 1;
			break;
		case MOVE_DOWN:
			newRow = newRow + 1;
			break;
		case MOVE_LEFT:
			newCol = newCol - 1;
			break;
		case MOVE_RIGHT:
			newCol = newCol + 1;
			break;
		default:
			// wrong direction
			throw new IllegalArgumentException();
		}

		if (isPossible(newRow, newCol)) {
			playerRow = newRow;
			playerCol = newCol;
			return true;
		} else {	
			return false;
		}
	}
}
