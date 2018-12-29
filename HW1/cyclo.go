//Sairamvinay Vijayaraghavan
//ECS 140 Section A02 (W: 5:10-6 p.m)
package analysis

import (
  "go/ast"
  "go/parser"
  "go/token"
)

func cyclomatic(node ast.Stmt) uint {

  switch N:= node.(type){
      case *ast.BlockStmt:
        var complexity uint = 1
        for _,inner:= range N.List{
            complexity = complexity * cyclomatic(inner)
        }
        return complexity
      
      case *ast.CaseClause:
          var complexity uint = 1
          for _,inner := range N.Body{
              
              complexity *= cyclomatic(inner)
          }
          
          return complexity
      
      case *ast.SwitchStmt:
          
          var complexity uint = 0
          var counter uint = 0
          length:= len(N.Body.List)
          for i:=0;i<length;i++{
              caseC,ok := N.Body.List[i].(*ast.CaseClause)
              if (ok){
                  if (caseC.List == nil){
                      counter++
                  }else{
                      
                      complexity += cyclomatic(caseC)
                  }
              }
          }
          
          if(counter >= 1){
            
              complexity += uint(1)
          }
          return complexity
    
    case *ast.TypeSwitchStmt:
    var complexity uint = 0
          var counter uint = 0
          length:= len(N.Body.List)
          for i:=0;i<length;i++{
              caseC,ok := N.Body.List[i].(*ast.CaseClause)
              if (ok){
                  if (caseC.List == nil){
                      counter++
                  }else{
                      
                      complexity += cyclomatic(caseC)
                  }
              }
          }
          
          if(counter >= 1){
            
              complexity += uint(1)
          }
          return complexity
        
    case *ast.IfStmt:
            
            return cyclomatic(N.Body) + cyclomatic(N.Else)
        
        case *ast.ForStmt:
            
            return (1 + cyclomatic(N.Body))
        
        case *ast.RangeStmt:
            return (1 + cyclomatic(N.Body))
        default:
            return 1
    }
}

func CyclomaticComplexity(src string) map[string]uint {
  fset := token.NewFileSet()
  f, err := parser.ParseFile(fset, "src.go", src, 0)
  if err != nil {
    panic(err)
  }
  m := make(map[string]uint)
  for _, decl := range f.Decls {
    switch fn := decl.(type) {
    case *ast.FuncDecl:
      m[fn.Name.Name] = cyclomatic(fn.Body)
    }
  }

  return m
}
