package espruino.device;

import espruino.Serial;

class GPS
{
	var serial : Serial;

	public var time(default, null) : String;
	public var latitude(default, null)  : Float;
	public var longitude(default, null)  : Float;
	public var fix(default, null)  : Int;
	public var satellites(default, null) : Int;
	public var altitude(default, null)   : Float;

	public function new(serial : Serial)
	{
		this.serial = serial;
		serial.onData((function() {
			var buf = '';
			return function(e) {
				switch(e.data)
				{
					case "\n":
						onData(buf);
						buf = "";
					case c:
						buf += c;
				}
			};
		})());
	}

	function onData(line : String)
	{
		if(line.substr(0, 3) != "$GP")
			throw 'Invalid line: $line';
		switch(line.substr(3, 3))
		{
			// case "DTM": // Datum Reference
			// $GPDTM,LLL,LSD,lat,N/S,lon,E/W,alt,RRR*cs<CR><LF>
			// case "GBS": // GNSS Satellite Fault Detection
			// $GPGBS,hhmmss.ss,errlat,errlon,erralt,svid,prob,bias,stddev*cs<CR><LF>

			case "GGA":
				var d    = line.split(','),
					dlat = d[2].indexOf("."),
					dlon = d[4].indexOf(".");

				time       = d[1].substr(0, 6);
				latitude   = (Std.parseInt(d[2].substr(0,dlat-2))+Std.parseFloat(d[2].substr(dlat-2))/60)*(d[3]=="S"?-1:1);
				longitude  = (Std.parseInt(d[4].substr(0,dlon-2))+Std.parseFloat(d[4].substr(dlon-2))/60)*(d[5]=="W"?-1:1);
				fix        = Std.parseInt(d[6]);
				satellites = Std.parseInt(d[7]);
				altitude   = Std.parseFloat(d[9]);

				trace(toString());

			// case "GLL": // Latitude and longitude, with time of position fix and status
			// $GPGLL,Latitude,N,Longitude,E,hhmmss.ss,Valid,Mode*cs<CR><LF>
			// case "GPQ": // Poll message
			// $xxGPQ,sid*cs<CR><LF>
			// case "GRS": // GNSS Range Residuals
			// $GPGRS,hhmmss.ss, mode {,residual}*cs<CR><LF>
			// case "GSA": // GNSS DOP and Active Satellites
			// $GPGSA,Smode,FS{,sv},PDOP,HDOP,VDOP*cs<CR><LF>
			// case "GST": // GNSS Pseudo Range Error Statistics
			// $GPGST,hhmmss.ss,range_rms,std_major,std_minor,hdg,std_lat,std_long,std_alt*cs<CR><LF>
			// case "GSV": // GNSS Satellites in View
			// $GPGSV,NoMsg,MsgNo,NoSv,{,sv,elv,az,cno}*cs<CR><LF>
			// case "RMC": // Recommended Minimum data
			// $GPRMC,hhmmss,status,latitude,N,longitude,E,spd,cog,ddmmyy,mv,mvE,mode*cs<CR><LF>
			// case "THS": // True Heading and Status
			// $GPTHS,headt,status*cs<CR><LF>
			// case "TXT": // Text Transmission
			// $GPTXT,xx,yy,zz,ascii data*cs<CR><LF>
			// case "VTG": // Course over ground and Ground speed
			// $GPVTG,cogt,T,cogm,M,sog,N,kph,K,mode*cs<CR><LF>
			// case "ZDA": // Time and Date
			// $GPZDA,hhmmss.ss,day,month,year,ltzh,ltzn*cs<CR><LF>
		}
	}

	static inline function round(v : Float)
		return Math.round(v * 100000) / 100000;

	public function destroy()
		serial.onData(null);

	public function toString()
		return 'GPS: lat ${round(latitude)}, lon ${round(longitude)}, alt $altitude (fix $fix, satellites $satellites)';
}