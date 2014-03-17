package espruino;

import esx.Either;
import espruino.Espruino;

@:build(espruino.util.Macro.buildPorts([
	{prefix : "I2C", range : [1,#if discovery 4 #else 3 #end], type : "I2C" }
]))
extern class I2C
{
	public function readFrom(address : Int, quantity : Int) : Int;
	public function setup(options : I2COptions) : Void;
	public function writeTo(address : Int, data : Int) : Void;

	public inline function writeStringTo(address : Int, string : String) : Void
		untyped __js__("writeTo")(address, string);

	public inline function writeBytesTo(address : Int, data : Int8Array) : Void
		untyped __js__("writeTo")(address, data);
}

typedef I2COptions = {
	scl : Either<Pin, Int>,
	sda : Either<Pin, Int>
}