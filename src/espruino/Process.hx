package espruino;

@:native('process')
extern class Process
{
	public static var env(default, null) : Env;
	public static function memory() : Memory;
	public static var version(default, null) : String;
}

typedef Env = {
	VERSION 	: String,
	BUILD_DATE 	: String,
	BUILD_TIME 	: String,
	BOARD 		: String,
	CHIP 		: String,
	CHIP_FAMILY : String,
	FLASH 		: String,
	RAM 		: String,
	SERIAL 		: String,
	CONSOLE 	: String
}

typedef Memory = {
	free :				Int,
	usage :				Int,
	total :				Int,
	history :			Int,
	stackEndAddress :	Int,
	flash_start :		Int,
	flash_binary_end :	Int,
	flash_code_start :	Int,
	flash_length :		Int
}
