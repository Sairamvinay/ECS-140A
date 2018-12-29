//Sairamvinay Vijayaraghavan
//ECS 140 Section A02 (W: 5:10-6 p.m)
package eval

import (
  "fmt"
  "testing"
)

//!+Simplify
func TestSimplify(t *testing.T) {
  tests := []struct {
    expr string
    env  Env
    want string
  } {
     
    {"10 / X", Env{"X": 2}, "5"},
    {"(X + X) - Y", Env{"X": 2}, "(4 - Y)"},
    {"(X + X) - Y", Env{"Y": 8}, "((X + X) - 8)"},
    {"5 + 2", Env{}, "7"},
    {"10 - 1 + X - Y", Env{}, "((9 + X) - Y)"},
    {"X + 3 + 5", Env{}, "((X + 3) + 5)"},
    {"3 * 4 ",Env{},"12"},
    {"0 + X",Env{},"X"},
    {"X + 0",Env{},"X"},
    {"X * 0",Env{},"0"},
    {"0 * X",Env{},"0"},
    {"1 * Y",Env{},"Y"},
    {"Y * 1",Env{},"Y"},
    {"-X + 7",Env{"X":3},"4"},
    {"+C",Env{"C":10},"10"},
    {"-X",Env{},"(-X)"},
  }

  for _, test := range tests {
    expr, err := Parse(test.expr)
    if err != nil {
      t.Error(err) // parse error
      continue
    }

    fmt.Printf("\n%s\n", test.expr)

    // Run the method
    result := expr.Simplify(test.env)

    // Display the result
    got := Format(result)
    fmt.Printf("\t%s, %v => %s\n", Format(expr), test.env, got)

    // Check the result
    if got != test.want {
      t.Errorf("(%s).Simplify() in %v = %q, want %q\n",
        test.expr, test.env, got, test.want)
    }
  }
}

func TestSimplify_Failure(t *testing.T) {
  tests := []struct {
    expr Expr
  } {
    {measure{"m", Literal(10.0)}},
  }

  for _, test := range tests {
    func() {
      defer func() {
        if recover() == nil {
          t.Errorf("(%s).Simplify(Env{}) did not panic, but should\n",
            test.expr)
        }
      }()

      test.expr.Simplify(Env{})
    }()
  }
}
//!-Simplify