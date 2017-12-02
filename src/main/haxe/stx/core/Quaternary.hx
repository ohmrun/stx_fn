package stx.core;

using stx.Pointwise;

class Quaternary {
  /**
		Pushes first parameter to the last
	**/
  static public function ccw<P1, P2, P3, P4, R>(f:P1->P2->P3->P4->R):P2->P3->P4->P1->R{
    return function(p2,p3,p4,p1){
      return f(p1,p2,p3,p4);
    }
  }
  /**
		Produces a function that ignores any error the occurs whilst calling the input function.
	**/
  public static function swallow<A, B, C, D, R>(f: A->B->C->D->R): A->B->C->D->R {
    return swallowWith(f, null);
  }
  /**
		Produces a function that ignores any error the occurs whilst calling the input function, and produces `d` if error occurs.
	**/
  public static function swallowWith<A, B, C, D, R>(f: A->B->C->D->R, def: R): A->B->C->D->R {
    return function(a, b, c, d) {
      try {
        return f(a, b, c, d);
      }
      catch (e: Dynamic) { }
      return def;
    }
  }
  /**
		Produces a function that calls `f`, ignores its result, and returns the result produced by thunk.
	**/
  public static function returning<P1, P2, P3, P4, R1, R2>(f: P1->P2->P3->P4->R1, thunk: Thunk<R2>): P1->P2->P3->P4->R2 {
    return function(p1, p2, p3, p4) {
      f(p1, p2, p3, p4);

      return thunk();
    }
  }
  /**
    Produces a function that produces a function for each parameter in the originating function. When these
    functions have been called, the result of the original function is produced.
  **/
  public static function curry<P1, P2, P3, P4, R>(f: P1->P2->P3->P4->R): (P1->(P2->(P3->(P4->R)))) {
    return function(p1: P1) {
      return function(p2: P2) {
        return function(p3: P3) {
          return function(p4: P4) {
            return f(p1, p2, p3, p4);
          }
        }
      }
    }
  }
  /**
    Takes a function with one parameter that returns a function of one parameter, and produces
    a function that takes two parameters that calls the two functions sequentially,
  **/
  public static function uncurry<P1, P2, P3, P4, R>(f: (P1->(P2->(P3->(P4->R))))): P1->P2->P3->P4->R {
    return function(p1: P1, p2: P2, p3: P3, p4: P4) {
      return f(p1)(p2)(p3)(p4);
    }
  }
  /**
		Produdes a function that calls `f` with the given parameters `p1....pn`.
	**/
  public static function lazy<P1, P2, P3, P4, R>(f: P1->P2->P3->P4->R, p1: P1, p2: P2, p3: P3, p4: P4): Thunk<R> {
    var r : R = null;

    return function() {
      return if (r == null) { r = f(p1, p2, p3, p4); r; } else r;
    }
  }
  /**
		Produces a function that calls `f`, ignoring the result.
	**/
  public static function enclose<P1, P2, P3, P4, R>(f: P1->P2->P3->P4->R): P1->P2->P3->P4->Void {
    return function(p1, p2, p3, p4) {
      f(p1, p2, p3, p4);
    }
  }
  /**
		Compares identity of methods.
	**/
  public static function equals<P1, P2, P3, P4, R>(a: P1->P2->P3->P4->R,b:P1->P2->P3->P4->R){
    return Reflect.compareMethods(a,b);
  }
}