package gameUtils;

class Version {
	macro public static function getVersion():haxe.macro.Expr.ExprOf<String> {
		var version:String;
		var versionFile = ".version";
		if (sys.FileSystem.exists(versionFile)) {
			version = sys.io.File.getContent(versionFile);
		}
		else {
			var gitDescribe = new sys.io.Process("git", ["describe", "--long", "--dirty"]);
			if (gitDescribe.exitCode() != 0) {
				var message:String = gitDescribe.stderr.readAll().toString();
				haxe.macro.Context.error("Couldn't find version file and git didn't work: " + message, haxe.macro.Context.currentPos());
			}
			version = gitDescribe.stdout.readLine();
		}

		return macro $v{version};
	}
}
