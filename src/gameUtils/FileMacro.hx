package gameUtils;

class FileMacro {

	macro public static function getContent(path:String):haxe.macro.Expr.ExprOf<String> {
		var fileContent:String;
		if (sys.FileSystem.exists(path)) {
			fileContent = sys.io.File.getContent(path);
		}
		else {
			haxe.macro.Context.error("Couldn't fetch " + path, haxe.macro.Context.currentPos());
		}

		return macro $v{fileContent};
	}
}
