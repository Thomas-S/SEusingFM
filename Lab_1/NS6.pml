mtype = {ok, err, msg1, msg2, msg3, keyA, keyB, agentA, agentB,
         nonceA, nonceB, agentI, keyI, nonceI };

typedef Crypt { mtype key, content1, content2};

chan network = [0] of {mtype, /* msg# */
                       mtype, /* receiver */
                       Crypt
};

bool knows_nonceA = false;
bool knows_nonceB = false;

/* global variables for verification */
mtype partnerA, partnerB;
mtype statusA = err;
mtype statusB = err; 

/* Agent (A)lice */
active proctype Alice() {
  /* local variables */
  
  mtype pkey;      /* the other agent's public key                 */
  mtype pnonce;    /* nonce that we receive from the other agent   */
  Crypt messageAB; /* our encrypted message to the other party     */
  Crypt data;      /* received encrypted message                   */


  /* Initialization  */
  
  /* Task (4) - Modification */
  /* Choosing random recipient */
  
  if
  	::	partnerA = agentB;
    	pkey     = keyB; 
    ::	partnerA = agentI;
    	pkey	 = keyI;
  fi;

  /* Prepare the first message */
  
  messageAB.key = pkey;
  messageAB.content1 = agentA;
  messageAB.content2 = nonceA;  

  /* Send the first message to the other party */
  
  network ! msg1 (partnerA, messageAB);

  /* Wait for an answer. Observe the we are pattern-matching on the
     messages that start with msg2 and agentA, that is, we block until 
     we see a message with values msg2 and agentA as the first and second  
     components. The third component is copied to the variable data. */

  network ? (msg2, agentA, data);

  /* We proceed only if the key field of the data matches keyA and the
     received nonce is the one that we have sent earlier; block
     otherwise.  */

  (data.key == keyA) && (data.content1 == nonceA);

  /* Obtain Bob's nonce */
  
  pnonce = data.content2;

  /* Prepare the last message */  
  messageAB.key = pkey;
  messageAB.content1 = pnonce; 
  messageAB.content2 = 0;  /* content2 is not used in the last message,
                              just set it to 0 */

  
  /* Send the prepared messaage */
  network ! msg3 (partnerA, messageAB);

  
  /* and last - update the auxilary status variable */
  statusA = ok;
}

active proctype Bob() {
  
  mtype pkey;      /* the other agent's public key                 */
  mtype pnonce;    /* nonce that we receive from the other agent   */
  
  Crypt data;      /* received encrypted message                   */
  Crypt messageBA; /* our encrypted message to the other party     */
  
   
  pkey = keyA;
  
  partnerB = agentA;
  
  
  network ? msg1(agentB,data);
  
  /* We proceed only if the key field of the data matches keyB. */
  data.key == keyB;
  
  /* Creating message record */
  pnonce = data.content2;
  
  messageBA.key = pkey;
  messageBA.content1 = pnonce;
  messageBA.content2 = nonceB;
  
  /* Sending reply to agentA */
  network ! msg2(partnerB,messageBA);
  
  /* Receiving third message */
  network ? msg3(agentB,data);
  
  /* We proceed only if the key field of the data matches keyB and the
     received nonce is the one that we have sent earlier; block
     otherwise.  */
  (data.key == keyB) && (data.content1 == nonceB);
   
  statusB = ok;
}

active proctype Intruder() {
  mtype msg, recpt;
  Crypt data, intercepted;
  mtype sender, pnonceA, pnonceB;
  
  do
    :: network ? (msg, _, data) ->
       if /* perhaps store the message */
         :: intercepted.key   = data.key;
            intercepted.content1 = data.content1;
            intercepted.content2 = data.content2;
         :: skip;
       fi;
       /* Task (5) - Extended if-statement */
       /* -------------------------------- */
       if
       	 :: data.key == keyI ->
       	 	if
       	 		:: (msg == msg1) -> knows_nonceA = true; pnonceA = data.content2;
       	 		:: (msg == msg2) -> knows_nonceA = true; knows_nonceB = true; pnonceA = data.content1; pnonceB = data.content2;
       	 		:: (msg == msg3) -> knows_nonceB = true; pnonceB = data.content1;
       	 	fi;
       	 :: else -> skip;
       fi;
	   /* -------------------------------- */


    :: /* Replay or send a message */
       if /* choose message type */
         :: msg = msg1;
         :: msg = msg2;
         :: msg = msg3;
       fi;
       if /* choose a recepient */
         :: recpt = agentA;
         :: recpt = agentB;
       fi;
       if /* replay intercepted message or assemble it */
         :: data.key    = intercepted.key;
            data.content1  = intercepted.content1;
            data.content2  = intercepted.content2;
         :: if /* assemble content1 */
         	  /* Task 5) change */	
         	  :: knows_nonceA -> data.content1 = pnonceA;
         	  :: knows_nonceB -> data.content1 = pnonceB; 
              :: data.content1 = agentA;
              :: data.content1 = agentB;
              :: data.content1 = agentI;
              :: data.content1 = nonceI;
            fi;     
            if /* assemble key */
              :: data.key = keyA;
              :: data.key = keyB;
              :: data.key = keyI;
            fi;
            /* Task 5) change */
            if
              :: knows_nonceA -> data.content2 = pnonceA;
         	  :: knows_nonceB -> data.content2 = pnonceB; 
         	  :: msg == msg3 -> data.content2 = 0;
			  :: data.content2 = nonceI;
       fi;
      network ! msg (recpt, data);
  od
}

ltl BOTH_ARE_OK {<> (statusA == ok && statusB == ok)}