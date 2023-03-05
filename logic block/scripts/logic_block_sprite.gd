extends Node2D

@export
var color: Color

func set_color(new_color):
	color = new_color
	$ColorOverlay.set_deferred('color', new_color)

@export
var enabled = true

func _ready():
	$ColorOverlay.color = color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if enabled:
		$AnimatedSprite2D.play()
		
signal clicked


func _on_button_pressed():
	clicked.emit()
