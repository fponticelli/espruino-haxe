package espruino;

import espruino.Espruino;

@:build(espruino.util.Macro.buildPorts([
	{prefix : "SPI", range : [1,#if discovery 4 #else 3 #end], type : "SPI" }
]))
extern class SPI
{
	// TODO check return type
	// TODO check ArrayAccess type to support other Array types
	public function send(data : Either3<String, Int, ArrayAccess<Int>>, nss_pin : Either<Pin, Int>) : Dynamic;
	public function send4bit(data : Either3<String, Int, ArrayAccess<Int>>, bit0 : Int, bit1 : Int, nss_pin : Either<Pin, Int>) : Dynamic;
	public function send8bit(data : Either3<String, Int, ArrayAccess<Int>>, bit0 : Int, bit1 : Int, nss_pin : Either<Pin, Int>) : Dynamic;

	public function setup(?options : SPIOptions) : Void;
}

typedef SPIOptions = {
	ck   : Either<Pin, Int>,
	miso : Either<Pin, Int>,
	mosi : Either<Pin, Int>,
	?baud : Int,
	?mode : Int
}