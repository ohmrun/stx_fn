package stx.core;

import stx.data.*;

class Quinary {
  static public function ccw<P1, P2, P3, P4, P5, R>(f: P1->P2->P3->P4->P5->R):P2->P3->P4->P5->P1->R{
    return function(p2:P2, p3:P3, p4:P4, p5:P5, p1:P1){
      return f(p1, p2, p3, p4, p5);
    }
  }
  /**
		Produces a function that ignores any error the occurs whilst calling the input function.
	**/
  public static function swallow<A, B, C, D, E>(f: A->B->C->D->E->Void): A->B->C->D->E->Void {
    return enclose(swallowWith(f, null));
  }
  /**
		Produces a function that ignores any error the occurs whilst calling the input function, and produces `d` if error occurs.
	**/
  public static function swallowWith<A, B, C, D, E, R>(f: A->B->C->D->E->R, def: R): A->B->C->D->E->R {
    return function(a, b, c, d, e) {
      try {
        return f(a, b, c, d, e);
      }
      catch (e: Dynamic) { }
      return def;
    }
  }
  /**
		Produces a function that calls `f`, ignores its result, and returns the result produced by thunk.
	**/
  public static function returning<P1, P2, P3, P4, P5, R1, R2>(f: P1->P2->P3->P4->P5->R1,thunk: Thunk<R2>): P1->P2->P3->P4->P5->R2 {
    return function(p1, p2, p3, p4, p5) {
      f(p1, p2, p3, p4, p5);

      return thunk();
    }
  }
  /**
    Produces a function that produces a function for each parameter in the originating function. When these
    functions have been called, the result of the original function is produced.
  **/
  public static function curry<P1, P2, P3, P4, P5, R>(f: P1->P2->P3->P4->P5->R) {
    return function(p1: P1) {
      return function(p2: P2) {
        return function(p3: P3) {
          return function(p4: P4) {
            return function(p5: P5) {
              return f(p1, p2, p3, p4, p5);
            }
          }
        }
      }
    }
  }
  /**
    Takes a function with one parameter that returns a function of one parameter, and produces
    a function that takes two parameters that calls the two functions sequentially,

  **/
  public static function uncurry<P1, P2, P3, P4, P5, R>(f:(P1->(P2->(P3->(P4->(P5-> R)))))): P1->P2->P3->P4->P5->R {
    return function(p1: P1, p2: P2, p3: P3, p4: P4, p5: P5) {
      return f(p1)(p2)(p3)(p4)(p5);
    }
  }
  /**
		Produdes a function that calls `f` with the given parameters `p1....pn`.
	**/
  public static function lazy<P1, P2, P3, P4, P5, R>(f: P1->P2->P3->P4->P5->R, p1: P1, p2: P2, p3: P3, p4: P4, p5: P5): Thunk<R> {
    var r : R = null;

    return function() {
      return if (r == null) { r = f(p1, p2, p3, p4, p5); r; } else r;
    }
  }
  /**
		Produces a function that calls `f`, ignoring the result.
	**/
  public static function enclose<P1, P2, P3, P4, P5, R>(f: P1->P2->P3->P4->P5->R): P1->P2->P3->P4->P5->Void {
    return function(p1, p2, p3, p4, p5) {
      f(p1, p2, p3, p4, p5);
    }
  }
  /**
		Method equals.
	**/
  public static function equals<P1, P2, P3, P4, P5, R>(a:P1->P2->P3->P4->P5->R,b:P1->P2->P3->P4->P5->R):Bool{
    return Reflect.compareMethods(a,b);
  }
}
