package maze;

public class HighscoreSorted extends Highscore {
	
	/*@ public invariant   
      @   (\forall int i; 
      @      (\forall int j; i>=0 && j>=0 && j<=i && i<size; highscores[j].score <= highscores[i].score)); 
      @*/
	
	/** 
	 * creates the high score list with <tt>capacity</tt> slots to be filled
	 * 
	 * @param capacity the maximum number of slots (list entries); the number must be non-negative
	 */
	/*@ public normal_behavior
	  @ requires p_capacity > 0;
	  @ assignable capacity, size, highscores, min;
	  @*/
	public HighscoreSorted(int p_capacity) {
		super(p_capacity);
	}
	
	/** 
	 * returns an index with a maximal score or <tt>-1</tt> if the high score list is empty
	 */
	public int max() {
		// to be implemented
		throw new RuntimeException("To be implemented.");
	}
	
	/*@ private normal_behavior 
	  @ requires in != null && at >= 0 && at<in.length;
	  @ ensures in[at] == rec;
	  @ ensures (\forall int i; i>at && i<in.length; in[i] == \old(in[i-1])); 
	  @ assignable in[at..in.length];
	  @
	  @ // fill in the missing exceptional specification cases
	  @*/
	private void insertAt(/*@ nullable @*/ Record rec, int at, /*@ nullable @*/ Record[] in) {
		if (in == null) {
			throw new NullPointerException();
		} 
		if (at < 0 || at >= in.length) {
			throw new IndexOutOfBoundsException();
		}
		
		int start = in.length - 1;
		
		// in the specification below complete the specification by replacing the placeholders YYY and ZZZ
		// do not forget to uncomment (remove the double slashes) 
		/*@ // loop_invariant start >= at && start < in.length && YYY;  
		  @ // assignable in[at+1..in.length-1], start;
		  @ // decreases ZZZ;
		  @*/
		while (start > at) {
			in[start] = in[start - 1];
			start--;
		}
		
		in[at] = rec;		
	}
	
	/**
	 * ignore; not in this lab
	 */
	public Record add(Record r) {
		throw new RuntimeException("Not in this lab");
	}
	
	
}
