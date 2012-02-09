package maze;
public class Highscore {
	/** 
	 *   <ol> 
	 *    <li> the array highscores contains all achieved high scores; 
	 *      it can store <tt>capacity</tt> number of records, but not more </li>
	 *    <li>
	 *    	the minimum capacity is <tt>1<tt>
	 *    </li>
	 *    <li> the integer field <tt>size</tt> refers to the next entry not yet used to store a high score;
	 *       only array components with an index greater-or-equal to <tt>size</tt> may be <tt>null</tt>. 
	 *       The high score list itself is always not null.
	 *    </li>
	 *    <li> the array 'highscores' is not shared with other Highscore instances</li>
	 *   </ol>  
	 */
	private /*@ spec_public @*/ final int capacity;

	protected /*@ spec_public @*/ int size; 

	/** 
	 * Hint: the nullable modifier for arrays containing objects means that the field itself 
	 * can be null as well as the components of the array 
	 */
	protected final /*@ spec_public nullable @*/ Record[] highscores;

	/** 
	 * The field <tt>min</tt> is <tt>-1</tt> if and only if the list is empty 
	 * otherwise denotes its value the <em>index</em>(!) of the entry with a 
	 * minimal element. 
	 * (Hint: make the "if and only if" explicit in your specification and add all 
	 *  size constraints that adhere to min)
	 */
	protected /*@ spec_public @*/ int min;


	/** 
	 * creates the highscore list with <tt>capacity</tt> slots to be filled
	 * @param capacity the maximum number of slots (list entries)
	 */
	/*@ public normal_behavior
	  @ requires p_capacity > 0;
	  @ assignable capacity, size, highscores, min;
	  @*/
	public Highscore(int p_capacity) {
		this.capacity = p_capacity;
		this.highscores = new Record[capacity];
		this.size = 0;
		this.min = -1;
	}

	/**
	 * return number of stored high scores
	 */
	public /*@ pure @*/ int size() {
		return size;
	}

	/** 
	 * returns the index of an element of maximal score or <tt>-1</tt> if the high score list is empty
	 */
	/*@ public normal_behavior
	  @ requires size > 0;
	  @ ensures (\forall int i; i>=0 && i<size; highscores[i].score >= highscores[\result].score);
	  @ ensures \result >=0 && \result < size;
	  @
	  @ also
	  @
	  @ public normal_behavior
	  @ requires size == 0;
	  @ ensures \result == -1;
	  @*/
	public /*@ pure @*/ int findNewMin() {
		int minIdx = -1;
		int idx = 0;

		/*@ loop_invariant 
		  @    (idx > 0 <==> minIdx >= 0) && idx >= 0 && idx <= size &&
		  @      minIdx >= -1 && minIdx < idx &&
		  @        (\forall int i; i>= 0 && i < idx; 
		  @                 highscores[minIdx].score <= highscores[i].score);
		  @ assignable idx, minIdx;
		  @ decreases size - idx;
		  @*/
		while (idx < size) {			
			if (minIdx == -1 || highscores[idx].getScore() < highscores[minIdx].getScore()) {
				minIdx = idx; 
			}
			idx++;
		}
		return minIdx;
	}

	/**
	 * returns the minimal score 
	 */
	/*@ public normal_behavior
	  @ requires true;
	  @ ensures (\forall int i; i>=0 && i<size; \result <= highscores[i].score);
	  @ ensures (\exists int i; i>=0 && i<size; \result == highscores[i].score);
	  @*/
	public /*@ pure @*/ int minScore() {
		return highscores[min].getScore();
	}


	/**
	 * If the maximal capacity has not yet been reached, 
	 * the high score list contains the given record afterwards and <tt>null</tt> is returned.
	 * Otherwise, if the new record is greater than a current minimal entry, replace the latter 
	 * by the given record and return the removed one. In any other case, the high score list is not 
	 * changed and the given score is returned.
	 */
	/*@ public normal_behavior
	  @ requires size < capacity;
	  @ ensures (\exists int i; i >= 0 && i<size; highscores[i] == rec);
          @ ensures \result == null;
          @ ensures size == \old(size) + 1;
	  @ assignable min, size, highscores[*];
	  @
	  @ // add here the missing specification cases
	  @*/
	public /*@ nullable @*/ Record add(Record rec) {
		if (size < capacity) {
			highscores[size] = rec;

			if (highscores[size].getScore() < highscores[min].getScore()) {
				min = size;
			}

			size++;
			return null;
		} else {
			if (rec.getScore() > highscores[min].getScore()) {
				Record old = highscores[min];
				highscores[min] = rec;
				min = findNewMin();
				return old;
			} 	
			return rec;
		}	
	}
}
