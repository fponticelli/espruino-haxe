package espruino;

import esx.Either;

@:coreType @:notNull @:runtimeValue abstract Int16 to Int { }
@:coreType @:notNull @:runtimeValue abstract Int8 to Int16 { }

@:coreType @:notNull @:runtimeValue abstract UInt32 to Float { }
@:coreType @:notNull @:runtimeValue abstract UInt16 to Int to UInt32 { }
@:coreType @:notNull @:runtimeValue abstract UInt8 to UInt16 { }

typedef Byte = UInt8;

@:build(espruino.util.Macro.buildPorts([
	{prefix : "LED", range : [0,#if discovery 4 #else 3 #end], type : "Pin" },
	{prefix : "A",   range : [0,15], type : "Pin" },
	{prefix : "B",   range : [0,15], type : "Pin" },
	{prefix : "C",   range : [0,15], type : "Pin" },
	{prefix : "D",   range : [0,#if discovery 15 #else 2 #end],  type : "Pin" },
	#if discovery
	{prefix : "E",   range : [0,15], type : "Pin" },
	{prefix : "H",   range : [0,1], type : "Pin" },
	#end
]))
extern class Espruino
{
	public static inline function analogRead(pin : Either<Pin, Int>) : Float
		return untyped __js__("analogRead")(pin);

	public static inline function analogWrite(pin : Either<Pin, Int>, value : Float, ?options : AnalogWriteOptions) : Void
		untyped __js__("analogWrite")(pin, value, options);

	public static inline function digitalWrite(pin : Either<Pin, Int>, value : Bool) : Void
		untyped __js__("digitalWrite")(pin, value);

	public static inline function digitalWriteArray(pins : Array<Either<Pin, Int>>, value : Int) : Void
		untyped __js__("digitalWrite")(pins, value);

	public static inline function digitalPulse(pin : Either<Pin, Int>, value : Bool, time : Float) : Void
		untyped __js__("digitalPulse")(pin, value, time);

	public static inline function digitalRead(pin : Either<Pin, Int>) : Bool
		return untyped __js__("digitalRead")(pin);

	public static inline function setInterval(callback : Void -> Void, delay : Int) : TimerID
		return untyped __js__("setInterval")(callback, delay);

	public static inline function changeInterval(timerId : TimerID, delay : Int) : Void
		untyped __js__("changeInterval")(timerId, delay);

	public static inline function clearInterval(timerId : TimerID) : Void
		untyped __js__("clearInterval")(timerId);

	public static inline function setTimeout(callback : Void -> Void, delay : Int) : TimerID
		return untyped __js__("setTimeout")(callback, delay);

	public static inline function clearTimeout(timerId : TimerID) : Void
		untyped __js__("clearTimeout")(timerId);

	public static inline function clearWatch(id : WatchID) : Void
		untyped __js__("clearWatch")(id);

	public static inline function dump() : Void
		untyped __js__("dump")();

	public static inline function echo(echoOn : Bool) : Void
		untyped __js__("echo")(echoOn);

	public static inline function edit(functionName : String) : Void
		untyped __js__("edit")(functionName);

	public static inline function eval(code : String) : String
		return untyped __js__("eval")(code);

	public static inline function getSerial() : String
		return untyped __js__("getSerial")();

	public static inline function getTime() : Float
		return untyped __js__("getTime")();

	public static inline function load() : Void
		untyped __js__("load")();

	public static inline function peek8(addr : Int) : Int
		return untyped __js__("peek8")(addr);

	public static inline function peek16(addr : Int) : Int
		return untyped __js__("peek16")(addr);

	public static inline function peek32(addr : Int) : Int
		return untyped __js__("peek32")(addr);

	public static inline function pinMode(pin : Either<Pin, Int>, mode : PinMode) : Void
		untyped __js__("pinMode")(pin, mode);
	public static inline function poke16(addr : Int, value : Int) : Void
		untyped __js__("poke16")(addr, value);
	public static inline function poke32(addr : Int, value : Int) : Void
		untyped __js__("poke32")(addr, value);
	public static inline function poke8(addr : Int, value : Int) : Void
		untyped __js__("poke8")(addr, value);
	public static inline function print(text : String) : Void
		untyped __js__("print")(text);
	public static inline function require(moduleName : String) : Dynamic
		return untyped __js__("require")(moduleName);
	public static inline function reset() : Void
		untyped __js__("reset")();
	public static inline function save() : Void
		untyped __js__("save")();
	public static inline function setBusyIndicator(pin : Either<Pin, Int>) : Void
		untyped __js__("setBusyIndicator")(pin);
	public static inline function setDeepSleep(sleep : Bool) : Void
		untyped __js__("setDeepSleep")(sleep);
	public static inline function setSleepIndicator(pin : Either<Pin, Int>) : Void
		untyped __js__("setSleepIndicator")(pin);
	public static inline function setWatch(handler : Void -> Void, pin : Either<Pin, Int>, ?options : WatchOptions) : WatchID
		return untyped __js__("setWatch")(handler, pin, options);
	// TODO check type of root
	public static inline function trace(root : String) : Void
		untyped __js__("trace")(root);
	public static inline function setIntervalCounter(handler : Int -> Void, time : Int) : TimerID
	{
		var i = 0;
		return setInterval(function() {
			handler(i);
			i++;
		}, time);
	}

	public static inline function toFixed(value : Float, decimalPlaces : Int) : Float
		return (untyped value).toFixed(decimalPlaces);
}

typedef AnalogWriteOptions = {
	?freq : Int
}

typedef WatchOptions = {
	?repeat : Bool,
	?edge : Edge,
	?debounce : Int
}

extern class TimerID {}

extern class WatchID {}

@:enum
abstract Edge(String)
{
	var Rising  = 'rising';
	var Falling = 'falling';
	var Both    = 'both';
}

@:enum
abstract PinMode(String)
{
	var Input         = 'input';
	var InputPullUp   = 'input_pullup';
	var InputPullDown = 'input_pulldown';
	var Output        = 'output';
	var OpenDrain     = 'opendrain';
}

@:native("ArrayBuffer")
extern class ArrayBuffer implements ArrayAccess<Int> extends TypedArray<Byte>
{

}

@:native("Int8Array")
extern class Int8Array implements ArrayAccess<Int> extends TypedArray<Int8>
{
	@:overload(function(length : Int) : Void {})
	@:overload(function(arr : Int8Array) : Void {})
	function new(arr : Array<Int>) : Void;
}

extern class TypedArray<T>
{
	function forEach(handler : T -> ?Int -> Void, ?scope : Dynamic) : Void;
	function indexOf(value : Int) : T;
	function join(separator : String) : String;
	function map<TOut>(handler : T -> ?Int -> TOut, ?scope : Dynamic) : Array<TOut>;
	function pop() : T;
	function push(a : T, ?b : T, ?c : T, ?d : T, ?e : T, ?f : T, ?g : T, ?h : T, ?i : T) : Int;
	function slice(start : Int, ?end : Int) : TypedArray<T>;
	function sort(handler : T -> T -> Int) : TypedArray<T>;
	function splice(index : Int, howMany : Int, ?el1 : T, ?el2 : T, ?el3 : T, ?el4 : T, ?el5 : T, ?el6 : T)  : TypedArray<T>;
}
