package nfa

// A nondeterministic Finite Automaton (NFA) consists of states,
// symbols in an alphabet, and a transition function.

// A state in the NFA is represented as an unsigned integer.
type state uint

// An symbol in the NFA is a single rune, i.e. a character.
type symbol rune

// Given the current state and a symbol, the transition function
// of an NFA returns the set of next states the NFA can transition to
// on reading the given symbol.
// This set of next states could be empty.
type TransitionFunction func(st state, sym symbol) []state

// Reachable returns true if there exists a sequence of transitions
// from `transitions` such that if the NFA starts at the start state
// `start` it would reach the final state `final` after reading the
// entire sequence of symbols `input`; Reachable returns false otherwise.
//func Reachable(transitions TransitionFunction, start, final state, input []symbol) bool {
	// TODO
	/*
	1) run through each symbol in the input (recurse)
	2) for each symbol call transitions and get the set of possible states 
	3) run through each possible state and check with each of these states with the remaining of the input
	4) if any path returns true, return true
	5) else false
	*/
	
	
/*	if (len(input)>0){
	    
	    states:= transitions(start,input[0])
	    for _,possible := range states{
	        if (Reachable(transitions,possible,final,input[1:])) {
	            return true
	        }
	   }
	    
	} else{
	    //test whether ur last and final are same
	    if (start == final){
	      return true
	   }
	}
	return false
}

}

*/

package nfa
import "sync"

// A nondeterministic Finite Automaton (NFA) consists of states,
// symbols in an alphabet, and a transition function.

// A state in the NFA is represented as an unsigned integer.
type state uint

// An symbol in the NFA is a single rune, i.e. a character.
type symbol rune

// Given the current state and a symbol, the transition function
// of an NFA returns the set of next states the NFA can transition to
// on reading the given symbol.
// This set of next states could be empty.
type TransitionFunction func(st state, sym symbol) []state

// Reachable returns true if there exists a sequence of transitions
// from `transitions` such that if the NFA starts at the start state
// `start` it would reach the final state `final` after reading the
// entire sequence of symbols `input`; Reachable returns false otherwise.
func Reachable(transitions TransitionFunction, start, final state, input []symbol) bool{
	// TODO
	/*
	1) run through each symbol in the input (recurse)
	2) for each symbol call transitions and get the set of possible states 
	3) run through each possible state and check with each of these states with the remaining of the input
	4) if any path returns true, return true
	5) else false
	*/
	
	
	//NON-CONCURRENT SOLUTION
	
	/*if (len(input)>0){
	    
	    states:= transitions(start,input[0])
	    for _,possible := range states{
	        if (Reachable(transitions,possible,final,input[1:])) {
	            return true
	        }
	   }
	    
	} else{
	    //test whether ur last and final are same
	    if (start == final){
	      return true
	   }
	}
	return false
	*/

	
	//CONCURRENT SOLUTION

	returns := make(chan bool)
	var wg sync.WaitGroup
	helper(input,start,final,0,returns,&wg,transitions)
	
	go func(){
	    wg.Wait()
	    close(returns)
	}()
	
	return <- returns
	
}

func step(input []symbol,start,final state,index int,returns chan bool,wg *sync.WaitGroup,transitions TransitionFunction){
    
    
    if (index == (len(input))){
        if (start == final){
            returns <- true
            
        }
    }else{
        states:= transitions(start,input[index])
        for _,possible := range states{
                helper(input,possible,final,index+1,returns,wg,transitions)
            }
    }
}
//call a step function which takes current index of input and a current state and call next call with i+1
func helper (input []symbol,start,final state,index int,returns chan bool,wg *sync.WaitGroup,transitions TransitionFunction){
     wg.Add(1)
        go func(){
            step(input,start,final,index,returns,wg,transitions)
            wg.Done()
        }()
}





