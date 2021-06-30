.PHONY: lint
lint: .haxelib
	haxelib install checkstyle
	haxelib run checkstyle -s src -s test --exitcode

.PHONY: test
test: .haxelib
	haxelib install test.hxml --always
	haxe test.hxml

.haxelib:
	haxelib newrepo
