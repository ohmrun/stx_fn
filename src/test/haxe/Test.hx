import EmbedTest;

import stx.core.Y;
import haxe.unit.TestCase;

using stx.Pointwise;

import tink.CoreApi;

import stx.core.State;
import stx.fn.LeftChoice;
import stx.fn.RightChoice;
import stx.Partial;
import stx.core.Binary;
import stx.core.Blocks;
import stx.core.Compose;
import stx.core.Quaternary;
//import stx.core.Partial;
import stx.core.Quinary;
import stx.core.Senary;
import stx.core.Sinks;
import stx.core.Ternary;
import stx.core.Thunks;
import stx.core.Thunks;
import stx.core.Unary;

import stx.data.Block;
import stx.data.Embed;
import stx.data.Sink;
import stx.data.Thunk;

import stx.Pointwise;

import Type in T;

class Test{
  static function main(){
    var runner = new haxe.unit.TestRunner();
        runner.add(new ChoiceTest());
        runner.run();
  }
}
class ChoiceTest extends haxe.unit.TestCase{
  public function testLR(){
    var a = function(x:Int){
      return Right(x + 2);
    }.fromRight();

    var o0 = a(Left(3));
    this.assertTrue(T.enumEq(Left(3),o0));
    var o1 = a(Right(3));
    this.assertTrue(T.enumEq(Right(5),o1));

    var b = function(x:Int):Int{
      return x*2;
    }.right();

    var o2 = b(Right(10));
    this.assertTrue(T.enumEq(Right(20),o2));

    var c = function(i:Int):Either<String,Int>{
      return Left('issues from $i');
    }.fromRight();

    trace(c(Right(0)));
    trace(c(Left('ok')));
  }
}
