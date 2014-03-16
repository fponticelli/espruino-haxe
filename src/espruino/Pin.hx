package espruino;

extern class Pin
{
	public function read() : Int;
	public function reset() : Void;
	public function set() : Void;
	public function write(value : Bool) : Void;
	public function writeAtTime(value : Bool, time : Int) : Void;

	public inline function toString() : String
		return "" + untyped this;

	public inline function toInt() : Int
		return 0 + untyped this;
}