//Sairamvinay Vijayaraghavan
//ECS 140 Section A02 (W: 5:10-6 p.m)

package eval

func (v Var) Depth() uint {
    
  
  return uint(1)
  
}

func (f Literal) Depth() uint {
    return uint(1)
  
}

func (u unary) Depth() uint {
  
  return u.x.Depth()
}

func (b binary) Depth() uint {
  
  if (b.x.Depth() > b.y.Depth()){
      return 1 + b.x.Depth()
  }
  return 1 + b.y.Depth()
}

func (m measure) Depth() uint {
  
  return 1 + m.x.Depth()
}
