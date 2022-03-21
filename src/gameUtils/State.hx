package gameUtils;

@:generic
class State<T> {
	public var value(default, null):Null<T>;
	var handlers:Array<(T, T) -> Void>;

	public function new(initial:T) {
		handlers = [];
		value = initial;
	}

	public function addChangeHandler(func:(T, T) -> Void) {
		handlers.push(func);
	}

	public function removeChangeHanlder(func:(T, T) -> Void) {
		for (hndlr in handlers) {
			if (Reflect.compareMethods(hndlr, func)) {
				handlers.remove(hndlr);
			}
		}
	}

	public function change(newState:T) {
		var oldState = value;
		value = newState;
		for (hndlr in handlers) {
			hndlr(oldState, newState);
		}
	}
}
