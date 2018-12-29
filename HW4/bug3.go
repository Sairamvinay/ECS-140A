package bug3

// Merge sends the output from channels ch1 and ch2 to out.
func merge(ch1, ch2,out chan uint) {
	defer close(out)
    ok1:= true
    ok2:= true
	for (ok1 || ok2){
		select{
    		case x1,ok1 := <-ch1: // Either input from ch1
    		if ok1{
    			 out <- x1
    		}else{
    		    ch1 =nil
    		}
    		
    		case  x2,ok2 := <-ch2:// or input from ch2
    		    if ok2{    
    			    out <- x2
    		    }else{
    		        ch2 = nil
    		    }
    	 
		
		
	}
		
	}
}



func bug3(producer1 func(chan uint), producer2 func(chan uint)) chan uint {
	// Create channels for producers
	ch1, ch2 := make(chan uint), make(chan uint)
	// Create channel for consumer
	out := make(chan uint)
	// Spawn each goroutine
	go producer1(ch1)
	go producer2(ch2)
	go merge(ch1, ch2,out)
    
	// Return the output channel
	return out
}
//it currently prints "out is undefined"
//bug_test.go:24 fmt.Println(out --> x).