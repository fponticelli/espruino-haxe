package espruino;

class FS
{
	inline public static function appendFileSync(path : String, data : String) : Bool
		return _.appendFileSync(path, data);
	inline public static function readFileSync(path : String) : String
		return _.readFileSync(path);
	inline public static function readdirSync(path : String) : Array<String>
		return _.readdirSync(path);
	inline public static function unlinkSync(path : String) : Bool
		return _.unlinkSync(path);
	inline public static function writeFileSync(path : String, data : String) : Bool
		return _.writeFileSync(path, data);

	static var _ : Dynamic = untyped __js__('require("fs")');
}