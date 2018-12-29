//Sairamvinay Vijayaraghavan
//ECS 140 Section A02 (W: 5:10-6 p.m)
package eval
func (v Var) Simplify(env Env) Expr {
  
  if (len(env) == 0){
      return Var(v)
  }
  if val, ok := env[v];ok {
      return Literal(val)
  } else{ 
    return v
  }
}

func (f Literal) Simplify(env Env) Expr {
  
  return Literal(f)
}

func (u unary) Simplify(env Env) Expr {
 
 
 res,ok:= u.x.Simplify(env).(Literal)
 if ok==true{
     switch(u.op){
        case '+':
            return res
        
        case '-':
            return -res
     }
 }
 return u
}

func (b binary) Simplify(env Env) Expr {
 
  left:=b.x.Simplify(env)
  rt:=b.y.Simplify(env)
  
  res1,ok1:=left.(Literal)
  res2,ok2:=rt.(Literal)
  if (ok1 && ok2){
      switch(b.op){
          case '+':
            return res1 + res2
          
          case '-':
            return res1 - res2
          
          case '*':
            return res1 * res2
        
          case '/':
            return res1 / res2
      }
  }else if(ok1){
      
      if res1 == 0{
          switch(b.op){
              
              case '+':
                return rt
              
              case '*':
                return Literal(0)
          }
          
      }else if res1 == 1{
          if b.op == '*'{
              return rt
          }
      } 
      
  }else if (ok2){
      
      if res2 == 0{
          switch(b.op){
              
              case '+':
                return left
              
              case '*':
                return Literal(0)
          }
      }else if res2 == 1{
          if b.op == '*'{
              return left
          }
      } 
  }
  
  return binary{b.op,left,rt}
}

func (m measure) Simplify(env Env) Expr {
  // don't need to implement this
  panic("cannot simplify measure expression")
}
