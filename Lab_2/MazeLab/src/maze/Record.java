package maze;

/**
 * A record consists of the player's name and the achieved score. 
 * An achieved score is always non-negative.
 */
public class Record {
	
	/** the player's name */
	private final /*@ spec_public @*/ String name;
	
	/** the player's score */
	private final /*@ spec_public @*/ int score;
	
	/**
	 * creates a record with the players name and score
	 * @param name the players name 
	 * @param score the achieved high score
	 */
	public Record(String p_name, int p_score) {
		this.name  = p_name;
		this.score = p_score;
	}
	
	/**
	 * returns the player's name
	 */
	public  /*@ pure @*/ String getName() {
		return name;
	}

	/**
	 * returns the achieved high score
	 */
	public  /*@ pure @*/ int getScore() {
		return score;
	}
	
}
