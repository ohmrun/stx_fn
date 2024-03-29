package stx.fn;

/**
  Function taking two inputs in the form `Couple<Pi,Pii>` and returning `Couple<Ri,Rii`.
**/
@:using(stx.fn.Dual.DualLift)
@:forward @:callable abstract Dual<Pi,Pii,Ri,Rii>(DualDef<Pi,Pii,Ri,Rii>) from DualDef<Pi,Pii,Ri,Rii> to DualDef<Pi,Pii,Ri,Rii>{
  static public var _(default,never) = DualLift;
  @:noUsing static public function unit<Pi,Pii>():Dual<Pi,Pii,Pi,Pii>{
    return new Dual(
      (tp:Couple<Pi,Pii>) -> (tp:Couple<Pi,Pii>)
    );
  }
  public function new(self:DualDef<Pi,Pii,Ri,Rii>){
    this = self;
  }
  @:from static public function fromUnary<Pi,Pii,Ri,Rii>(self:Unary<Couple<Pi,Pii>,Couple<Ri,Rii>>):Dual<Pi,Pii,Ri,Rii>{
    return new Dual(self);
  }
  @:to public function toUnary():Unary<Couple<Pi,Pii>,Couple<Ri,Rii>>{
    return this;
  }
}
class DualLift{
  static public function then<Pi,Pii,Ri,Rii,Riii>(self:Dual<Pi,Pii,Ri,Rii>,then:Couple<Ri,Rii>->Riii):Unary<Couple<Pi,Pii>,Riii>{
    return Unary._.then(self,then);
  }
  static public function into<Pi,Pii,Ri,Rii,Riii>(self:Dual<Pi,Pii,Ri,Rii>,fn:Ri->Rii->Riii):Unary<Couple<Pi,Pii>,Riii>{
    return then(self,__.decouple(fn));
  }
  static public function pass<Pi,Pii,Ri,Ri0,Rii0>(self:Dual<Pi,Pii,Ri0,Rii0>,fn:Ri0->Rii0->Couple<Ri0,Rii0>):Dual<Pi,Pii,Ri0,Rii0>{
    return self.then(__.decouple(fn));
  }
  static public function first<Pi,Pii,Ri,Rii,Riii>(self:Dual<Pi,Pii,Ri,Rii>,fn:Ri->Riii):Dual<Pi,Pii,Riii,Rii>{
    return self.then(fn.fn().first());
  }
  static public function second<Pi,Pii,Ri,Rii,Riii>(self:Dual<Pi,Pii,Ri,Rii>,fn:Rii->Riii):Dual<Pi,Pii,Ri,Riii>{
    return self.then(fn.fn().second());
  }
}
