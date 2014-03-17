package nodejs;

import js.Node;

class Serial
{
	static var factory : Dynamic = (function() return untyped __js__('require("serialport")') )();
	public static inline function create(
		path : String,
		?options : SerialPortOptions,
		?openImmediately : Bool,
		?callback : ErrorCallback
	) : SerialPort
		return untyped __js__('new nodejs.Serial.factory.SerialPort')(path, options, openImmediately, callback);
}

typedef SerialPort = {> NodeEventEmitter,

	public function open(?callback : ErrorCallback) : Void;

	// TODO add Buffer from nodejs
	@:overload(function(buffer : Int, ?callback : ErrorCallback) : Void {})
	@:overload(function(buffer : Array<Int>, ?callback : ErrorCallback) : Void {})
	public function write(buffer : String, ?callback : ErrorCallback) : Void;

	public function pause() : Void;
	public function resume() : Void;
	public function flush(?callback : ErrorCallback) : Void;
	public function drain(?callback : ErrorCallback) : Void;
	public function close(?callback : ErrorCallback) : Void;

	// TODO
	//public function on<T>(event : SerialPortEvent, handler : T -> Void) : Void;
}

typedef ErrorCallback = String -> Void;

typedef SerialPortOptions = {
	?baudRate : Int,
	?dataBits : Int,
	?stopBits : Int,
	?parity : String,
	?rtscts : Bool,
	?xon : Bool,
	?xoff : Bool,
	?xany : Bool,
	?flowControl : FlowControl,
	?bufferSize : Int,
	?parser : Dynamic -> Dynamic -> Void, // TODO
	?encoding : Int, // TODO
	?dataCallback : Dynamic -> Void, // TODO
	?disconnectedCallback : Void -> Void
}

@:enum
abstract FlowControl(String) {
	var XON = "XON";
	var XOFF = "XOFF";
	var XANY = "XANY";
	var RTSCTS = "RTSCTS";
}

@:enum
abstract SerialPortEvent(String) {
	var Open = "open";
	var Data = "data";
	var Close = "close";
	var Error = "error";
}