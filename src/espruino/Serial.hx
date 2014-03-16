package espruino;

import espruino.Espruino;

@:build(espruino.util.Macro.buildPorts([
	{prefix : "Serial", range : [1,6], type : "Serial" }
]))
extern class Serial
{
	public function onData(handler : { data : Dynamic } -> Void) : Void;
	public function print(test : String) : Void;
	public function println(test : String) : Void;
	public function setConsole() : Void;
	public function setup(baudrate : Int, options : SerialOptions) : Void;

	@:overload(function(byte : Int) : Void {})
	@:overload(function(data : String) : Void {})
	public function write(data : ArrayAccess<Int>) : Void;
}

typedef SerialOptions = {
	rx : Either<Pin, Int>,
	tx : Either<Pin, Int>,
	?bytesize : Int,
	?parity : Parity,
	?stopbits : Int
}

@:enum
abstract Parity(String)
{
	var None = null;
	var Odd  = 'odd';
	var Even = 'even';
}