package espruino.board;

import espruino.Espruino.*;

class Leds
{
	static var leds(default, null) : Array<Pin>;

	public static inline function getLed(index : Int) : Pin
	{
		if(index < 0)
			index = -index - 1;
		return leds[index % leds.length];
	}

	static function __init__()
		leds = [
			LED1, LED2, LED3
			#if discovery
				, LED4
			#end
		];
}