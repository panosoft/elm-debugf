var _panosoft$elm_debugf$Native_DebugF = function() {
	function toStringF(v)
	{
		var objectsEncountered = [];
		var indentStr = '  ';
		var indent = function(depth) {
			var indent = '';
			for (var i = 0; i < depth; ++i)
				indent += indentStr;
			return indent;
		};
		var deleteQuoted = function(str) {
			var newStr = '';
			var inQuote = false;
			var quoteChar = null;
			for (var i = 0; i < str.length; ++i) {
				if (str[i] == '\\') {
					++i;
					continue;
				}
				if (inQuote) {
					if (str[i] == quoteChar)
						inQuote = false;
					continue;
				}
				if (str[i] == '\'' || str[i] == '"')
				{
					inQuote = true;
					quoteChar = str[i];
				}
				else
					newStr += str[i];
			}
			return newStr;
		};
		var tooLong = function(str) {
			return str.length > 30;
		};
		var shouldMultiline = function(str) {
			str = deleteQuoted(str);
			return str.indexOf('\n') != -1 || tooLong(str);
		};
		var commaList = function(output) {
			var s = '';
			var prefix = "";
			for (var i = 0; i < output.length; ++i) {
				s += prefix + output[i];
				prefix = ",\n";
			}
			return s;
		};
		var indentLines = function(s, depth) {
			return indent(depth) + s.replace(/\n(?!$)/g,'\n' + indent(depth));
		};
		var toString2 = function (v, depth) {
			var type = typeof v;
			if (type === 'function')
			{
				var name = v.func ? v.func.name : v.name;
				return '<function' + (name === '' ? '' : ':') + name + '>';
			}

			if (type === 'boolean')
			{
				return v ? 'True' : 'False';
			}

			if (type === 'number')
			{
				return String(v);
			}

			if (v instanceof String)
			{
				return '\'' + v + '\'';
			}

			if (type === 'string')
			{
				return '"' + v + '"';
			}

			if (v === null)
			{
				return 'null';
			}

			if (type === 'object' && 'ctor' in v)
			{
				var ctorStarter = v.ctor.substring(0, 5);

				if (ctorStarter === '_Tupl')
				{
					var output = [];
					for (var k in v)
					{
						if (k === 'ctor') continue;
						output.push(toString2(v[k], depth));
					}
					var list = commaList(output);
					if (list.indexOf('\n') != 1)
						return '(\n' + indentLines(list, depth) + '\n)';
					else
						return '(' + list + ')';
				}

				if (ctorStarter === '_Task')
				{
					return '<task>'
				}

				if (v.ctor === '_Array')
				{
					var list = _elm_lang$core$Array$toList(v);
					return 'Array.fromList ' + toString2(list, depth);
				}

				if (v.ctor === '<decoder>')
				{
					return '<decoder>';
				}

				if (v.ctor === '_Process')
				{
					return '<process:' + v.id + '>';
				}

				if (v.ctor === '::')
				{
					var output = [];
					output.push(toString2(v._0, depth));
					v = v._1;
					while (v.ctor === '::')
					{
						output.push(toString2(v._0, depth));
						v = v._1;
					}
					var list = commaList(output);
					if (list.indexOf('\n') != 1)
						return '[\n' + indentLines(list, depth) + '\n]';
					else
						return '[' + list + ']';
				}
				if (v.ctor === '[]')
				{
					return '[]';
				}

				if (v.ctor === 'Set_elm_builtin')
				{
					return 'Set.fromList ' + toString2(_elm_lang$core$Set$toList(v), depth);
				}

				if (v.ctor === 'RBNode_elm_builtin' || v.ctor === 'RBEmpty_elm_builtin')
				{
					return 'Dict.fromList ' + toString2(_elm_lang$core$Dict$toList(v), depth);
				}

				var output = '';
				for (var i in v)
				{
					if (i === 'ctor') continue;
					var str = String(toString2(v[i], depth + 1));
					var c0 = str[0];
					var parenless = c0 === '{' || c0 === '(' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
					output += ' ' + (parenless ? str : '(' + str + ')');
				}
				return v.ctor + output;
			}

			if (type === 'object')
			{
				if (objectsEncountered.indexOf(v) != -1)
					return '<circular reference>';
				objectsEncountered.push(v);
				if (v instanceof Date)
				{
					return '<' + v.toString() + '>';
				}

				if (v.elm_web_socket)
				{
					return '<websocket>';
				}

				var output = [];
				for (var k in v)
					output.push(k + ' = ' + toString2(v[k], depth));
				if (output.length === 0)
					return '{}';
				var list = commaList(output);
				if (list.indexOf('\n') != 1)
					return '{\n' + indentLines(list, depth) + '\n}';
				else
					return '{' + list + '}';
			}

			return '<internal structure>';
		};
		return toString2(v, 1);
	}
	function log(tag, value)
    {
        var msg;
        if (typeof value == 'string' || value instanceof String)
            msg = value + '\n';
        else
            msg = '\n-------------------------' + tag + '-------------------------\n\n' + toStringF(value) + '\n';
        if (process && process.stdout)
            process.stdout.write(msg);
        else
            console.log(msg);
        return value;
    }
    return {
        toStringF: toStringF,
        log: F2(log)
    }
}();
