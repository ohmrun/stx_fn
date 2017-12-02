package stx;

using stx.Pointwise;
import haxe.ds.Option;
import stx.data.Embed as TEmbed;

@:forward abstract Embed<T>(TEmbed<T>) from TEmbed<T>{
  public function new(){
    this = Embeds.embed();
  }
}
class Embeds{
  /*
    You can pass around the Block that comes from pack without annotation, and wherever you have the reference
    to the Embedding, you can unpack it in a typed way, *only if* you have the correct reference.
  */
  static public function embed<T>():TEmbed<T>{
    var r  : Option<T> = haxe.ds.Option.None;
    //had to prefedine this for runtime issue.
    var unpack : Block -> Option<T> = null;
    unpack = function(fn){
      r = None;
      fn();//If the function was created by *this* Embedding, it should fill r with the value.
      return r;
    }
    return {
      pack : function(v:T){
        var o = Some(v);
        return function(){
          //Use the scope introduced by the embed function to assign a variable.
          r = o;
        }
      },
      unpack: unpack,
       // If the value is Some(_), then we've got the right reference.
      check:function(fn){
        return switch(unpack(fn)){
          case Some(_)   : true;
          case None      : false;
        }
      }
    }
  }
  /*
  static function main(){
    var str : String = "Hello World!";
    var embedding = new Embed();
    var key = embedding.pack(str);//Block. No type constraints here...
    var out = embedding.unpack(key);//Some("Hello World");
  }*/
}