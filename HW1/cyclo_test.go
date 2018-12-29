//Sairamvinay Vijayaraghavan
//ECS 140 Section A02 (W: 5:10-6 p.m)
package analysis

import (
  // "fmt"
  "testing"
)

//!+CyclomaticComplexity
func TestCyclomaticComplexity(t *testing.T) {
  var test_code = `
    package main

    import (
      "fmt"
      "eval"
    )

    func f() {
      return 42
    }

    func g(x int) {
      if x < 0 {
        return -1;
      } else if x > 0 {
        return 1;
      } else {
        return 0;
      }
    }

    func h() {
      switch 5 {
      case 0:
        // pass
      case 5:
        fmt.Println("It's five!")
      default:
        fmt.Println("It isn't five...")
      }
    }
    
    func baz() {
        for x := range []uint{1, 2, 3, 4} {
            if x == 1 {
                fmt.Println("A good number")
            } else {
                fmt.Println("Not so great")
            } 
        }
    }
    
    func bar(x uint) uint {
        var y uint
        if x == 4 { 
            y=2
        } else if x == 5 {
            y = 42
        }
        
        if x == 10 {
            y += 101
        }
        return y 
    }
    
    func foo(x uint) uint {
        if x == 4 {
            return 2
        } else {
            if x == 5 {
                return 42
            } else {
                return 101
            } 
        }
    }
    
    
    
    func p(i interface{}) {
	switch v := i.(type) {
	case int:
		fmt.Printf("This is integer type")
	case string:
		fmt.Printf("This is string type")
	default:
		fmt.Printf("This is neither int nor string type ")
	}
}
`

  tests := []struct {
    name string
    cyclo uint
  }{
    {"f", 1},
    {"g", 3},
    {"h", 3},
    {"baz",3},
    {"bar",6},
    {"foo",3},
    {"p",3},
  }

  cyclos := CyclomaticComplexity(test_code)

  for _, test := range tests {
    if cyclos[test.name] != test.cyclo {
      t.Errorf("CyclomaticComplexity()[%v] = %d, want %d\n",
        test.name, cyclos[test.name], test.cyclo)
    }
  }
}
//!-CyclomaticComplexity
