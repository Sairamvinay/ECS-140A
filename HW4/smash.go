package smash

import (
	"io"
	"bufio"
	"sync"
)

type word string

// Smash takes as input an io.Reader and a smasher function,
// and returns
func Smash(r io.Reader, smasher func(word) uint32) map[uint32]uint{
	m := make(map[uint32]uint)
	
	// TODO: Incomplete!
	
	var wg sync.WaitGroup
	
	var c uint32
	scanner := bufio.NewScanner(r)
	scanner.Split(bufio.ScanWords)
	for scanner.Scan(){
	   
	    s := word(scanner.Text())
	    c = smasher(s)
	    wg.Add(1)

	    //CONCURRENT SOLUTION
	    go func(key uint32,mp map[uint32]uint,wg *sync.WaitGroup){
	        
	        mp[key] = mp[key] + 1
	        wg.Done()

	    }(c,m,&wg)
	    
	    wg.Wait()

	    //NON-CONCURRENT SOLUTION
	    
	    /*if val, ok := m[c]; ok{
	        m[c] = val + 1
	    }else{
	        m[c] = uint(1)  
	    }*/
    }
	
	return m
}
