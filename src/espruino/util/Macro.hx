package espruino.util;

import haxe.macro.Context;
import haxe.macro.Expr;

class Macro
{
	macro public static function buildPorts(definitions : Array<{ prefix : String, range : Array<Int>, type : String }>) : Array<Field>
	{
		var fields = Context.getBuildFields();
		definitions.map(function(definition) {
			for(i in definition.range[0]...definition.range[1]+1)
			{
				var name = definition.prefix + i,
					t    = definition.type,
					type = macro : espruino.$t;

				fields.push({
					name: name,
					doc: null,
					meta: [],
					access: [AStatic, APublic],
					kind: FProp('get_$name', 'null', type ),
					pos: Context.currentPos()
				});

				fields.push({
					name: 'get_$name',
					doc: null,
					meta: [],
					access: [AStatic, APrivate, AInline],
					kind: FFun({
						args: [],
						ret:  type,
						expr: macro return untyped __js__($v{name})
					}),
					pos: Context.currentPos()
				});
			}
		});
		return fields;
	}
}