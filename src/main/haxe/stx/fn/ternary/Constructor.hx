package stx.fn.ternary;

class Constructor extends Clazz{
  static public var ZERO(default,never) = new Constructor();
  public var _(default,never) = new Destructure();
}
class Destructure extends Clazz{
  /**
		Places first parameter at the back.
	**/
  public function rotate<Pi, Pii, Piii, R>(f: Pi->Pii->Piii->R): Pii->Piii->Pi->R {
    return function(pII:Pii,pIII:Piii,pI:Pi){
      return f(pI,pII,pIII);
    }
  }
  /**
    Produces a function that produces a function for each parameter in the originating function. When these
    functions have been called, the result of the original function is produced.
  **/
  public function curry<Pi, Pii, Piii, R>(f: Pi->Pii->Piii->R): Pi -> (Pii -> (Piii -> R)) {
    return (pI) -> (pII) -> (pIII) -> f(pI,pII,pIII);
  }
  /**
		Produdes a function that calls `f` with the given parameters `pI....pn`.
	**/
  public function cache<Pi, Pii, Piii, R>(pI: Pi, pII: Pii, pIII: Piii,self: Pi->Pii->Piii->R): Thunk<R> {
    var r : R   = null;

    return function() {
      return if (r == null) {
        r = untyped (false);//<--- breaks live lock
        r = self(pI,pII,pIII); r;
      }else{
        r;
      }
    }
  }
  /**
		Compares function identity.
	**/
  public function equals<Pi, Pii, Piii, R>(that:Pi->Pii->Piii->R,self:Pi->Pii->Piii->R){
    return Reflect.compareMethods(self,that);
  }
}