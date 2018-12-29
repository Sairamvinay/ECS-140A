//Sairamvinay Vijayaraghavan
//ECS 140 Section A02 (W: 5:10-6 p.m)
package analysis

import (
   //"fmt"
  "testing"
)

//!+ComputeBranchFactors
func TestComputeBranchFactors(t *testing.T) {
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
      for y := range []uint{1, 1, 2, 3} {
        // do nothing
      }

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
    
    func m(){
      for j := 1; j <= 5; j++ {
      for i:=1;i<=4;i++{
          fmt.Println(i+j)
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
    branches uint
  }{
    {"f", 0},
    {"g", 3},
    {"h", 1},
    {"m",2},
    {"p",1},
  }

  branch_factors := ComputeBranchFactors(test_code)

  for _, test := range tests {
    if branch_factors[test.name] != test.branches {
      t.Errorf("ComputeBranchFactors()[%v] = %d, want %d\n",
        test.name, branch_factors[test.name], test.branches)
    }
  }
}
//!-ComputeBranchFactors
