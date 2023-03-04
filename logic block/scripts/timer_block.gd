extends LogicBlock

@export
var frequency: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = 1 / frequency
	$Timer.start()


func _on_timer_timeout():
	self.send_value(1)
	
	
	$FlashTimer.start()
	$FlashRect.visible = true
	await $FlashTimer.timeout
	$FlashRect.visible = false
