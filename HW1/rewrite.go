//Sairamvinay Vijayaraghavan
//ECS 140 Section A02 (W: 5:10-6 p.m)
package analysis

import (
  "go/ast"
  "go/parser"
  "go/token"
  "go/format"
  "bytes"
  "eval"
  "strconv"

)

// rewriteCalls should modify the passed AST
func rewriteCalls(node ast.Node) {
    
 ast.Inspect(node,func(node1 ast.Node) bool{
     switch N := node1.(type){
         case *ast.CallExpr:
            if (len(N.Args) == 2){
                switch call_type := N.Fun.(type){
                    case ast.Expr:
                        T,ok1 := call_type.(*ast.SelectorExpr)
                        if (ok1){
                            switch caller_name_type := T.X.(type){
                                case ast.Expr:
                                    S,ok2 := caller_name_type.(*ast.Ident)
                                    if (ok2){
                                        if S.Name == "eval" && T.Sel.Name == "ParseAndEval"{
                                            switch argument_type := N.Args[0].(type){
                                                case ast.Expr:
                                                    V,ok3 := argument_type.(*ast.BasicLit)
                                                    if (ok3){
                                                        arg1,_ := strconv.Unquote(V.Value)
                                                        expr_arg,err := eval.Parse(arg1)
                                                        if (err == nil){
                                                           result:= expr_arg.Simplify(eval.Env{})
                                                           str1 := strconv.Quote(eval.Format(result))
                                                           V.Value = str1
                                                        }
                                                    }
                                            }
                                        }
                                    }
                            }
                        }
                }
            }
     }
 return true})
    
}

func SimplifyParseAndEval(src string) string {
  fset := token.NewFileSet()
  f, err := parser.ParseFile(fset, "src.go", src, 0)
  if err != nil {
    panic(err)
  }

  rewriteCalls(f)
  var buf bytes.Buffer
  format.Node(&buf, fset, f)
  return buf.String()
}
