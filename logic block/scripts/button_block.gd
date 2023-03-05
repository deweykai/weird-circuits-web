extends LogicBlock

var color1: Color = Color('#bfb3f09a')
var color2: Color = Color('#a28ee6d4')

func _ready():
	$LogicBlockSprite.set_color(color1)


func _clicked():
	$LogicBlockSprite.set_color(color2)
	$ClickTimer.start()
	await $ClickTimer.timeout
	$LogicBlockSprite.set_color(color1)
	value_pushed.emit(1)

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_clicked()
