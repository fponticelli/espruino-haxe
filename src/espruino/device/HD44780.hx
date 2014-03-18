package espruino.device;

import espruino.Espruino.*;
import espruino.I2C;
import esx.Either;

class HD44780
{
	public static function createI2C(i2c : I2C)
		return new HD44780(new HD44780CommI2C(i2c));

	var writer : HD44780Comm;
	function new(writer : HD44780Comm)
	{
		this.writer = writer;
		// initialize
		write(0x33,true);
		write(0x32,true);
		write(0x28,true);
		write(0x0C,true);
		write(0x06,true);
		write(0x01,true);
	}

	public inline function write(x : Int, ?c : Bool = false)
		writer.write(x, c);

	public function clear()
		write(0x01, true);

	// print text
	public function print(str : String)
		for (i in 0...str.length)
			write(str.charCodeAt(i));

	// flashing block for the current cursor, or underline
	public function cursor(block : Bool)
		write(block ? 0x0F : 0x0E, true);

	static var cursorLine = [0x00,0x40,0x14,0x54];
	// set cursor pos, top left = 0,0
	public function setCursor(x : Int,y : Int)
		write(0x80 | (cursorLine[y] + x), true);

	// set special character 0..7, data is an array(8) of bytes, and then return to home addr
	public function createChar(ch, data)
	{
		write(0x40 | ((ch & 7) << 3), true);
		for (i in 0...8)
			write(data[i]);
		write(0x80, true);
	}
}

interface HD44780Comm
{
	function write(x : Int, c : Bool) : Void;
}

class HD44780CommI2C implements HD44780Comm
{
	var i2c : I2C;
	public function new(i2c : I2C)
		this.i2c = i2c;

	public function write(x : Int, c : Bool) : Void
	{
		var a = (x & 0xF0) |8| (c ? 0 : 1),
			b = ((x << 4) & 0xF0) |8| (c ? 0 : 1);
		i2c.writeBytesTo(0x27, cast [a,a,a|4,a|4,a,a,b,b,b|4,b|4,b,b]);
	}
}

class HD44780CommDirect implements HD44780Comm
{
	var rs : Either<Pin, Int>;
	var en : Either<Pin, Int>;
	var data : Array<Either<Pin, Int>>;

	public function new(rs : Either<Pin, Int>, en : Either<Pin, Int>, d4 : Either<Pin, Int>, d5 : Either<Pin, Int>, d6 : Either<Pin, Int>, d7 : Either<Pin, Int>)
	{
		this.rs = rs;
		this.en = en;
		data = [d7, d6, d5, d4];
	}

	public function write(x : Int, c : Bool) : Void
	{
		digitalWrite(rs, !c);
		digitalWriteArray(data, x >> 4);
		digitalPulse(en, true, 0.01);
		digitalWriteArray(data, x);
		digitalPulse(en, true, 0.01);
	}
}

