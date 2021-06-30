package gameUtils;

enum abstract TextScrollerNumbers(Int) from Int to Int {
	var scrollMultiplier = 200;
}

class ScrollController {

	var scrollText:h2d.Text;
	var scene:h2d.Scene;
	var dragScrollingLastPosition:Float;

	var bottomMargin:Float;
	var leftMargin:Float;
	var rightMargin:Float;
	var topMargin:Float;

	var yScrollMax:Float;
	var yScrollMin:Float;

	public var moveUpKeys:Array<Int>;
	public var moveDownKeys:Array<Int>;

	public function new(scrollText:h2d.Text, scene:h2d.Scene,
			topMargin:Float, rightMargin:Float, bottomMargin:Float, leftMargin:Float) {
		scrollText.x = leftMargin;
		scrollText.maxWidth = scene.width - leftMargin - rightMargin;
		yScrollMin = scene.height - bottomMargin - scrollText.textHeight;
		yScrollMax = scrollText.y = topMargin;

		this.scrollText = scrollText;
		this.scene = scene;

		this.topMargin = topMargin;
		this.rightMargin = rightMargin;
		this.bottomMargin = bottomMargin;
		this.leftMargin = leftMargin;

		moveUpKeys = [hxd.Key.UP];
		moveDownKeys = [hxd.Key.DOWN];

		if (scrollText.textHeight > (scene.height - scrollText.y)) {
			scene.addEventListener(scrollMe);
		}
	}

	function dragScroll(event:hxd.Event) {
		event.propagate = false;
		switch (event.kind) {
			case ERelease, EReleaseOutside, EFocusLost, EOut:
				scene.stopCapture();
			case EMove:
				scrollText.y += event.relY - dragScrollingLastPosition;
				dragScrollingLastPosition = event.relY;
				limitScrollY();
			default:
		}
	}

	function scrollMe(event:hxd.Event) {
		switch (event.kind) {
			case EWheel:
				scrollText.y += (event.wheelDelta * TextScrollerNumbers.scrollMultiplier);
				limitScrollY();
			case EKeyDown:
				if (moveUpKeys.contains(event.keyCode)) {
					scrollText.y += scrollText.font.size;
				}
				else if (moveDownKeys.contains(event.keyCode)) {
					scrollText.y -= scrollText.font.size;
				}
				limitScrollY();
			case EPush:
				if (event.relY > topMargin && event.relY < (scene.height - bottomMargin)) {
					dragScrollingLastPosition = event.relY;
					scene.startCapture(dragScroll);
				}
			default:
		}
	}

	function limitScrollY() {
		if (scrollText.y > yScrollMax) {
			scrollText.y = yScrollMax;
		}
		else if (scrollText.y < yScrollMin) {
			scrollText.y = yScrollMin;
		}
	}
}
