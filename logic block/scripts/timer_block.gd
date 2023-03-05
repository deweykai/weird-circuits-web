extends LogicBlock

@export
var frequency: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = 1 / frequency
	$Timer.start()
	$FrequencyLabel.text = str(frequency)
	

func _on_timer_timeout():
	self.send_value(1)
	
	
	$FlashTimer.start()
	$FlashRect.visible = true
	await $FlashTimer.timeout
	$FlashRect.visible = false


func _on_num_input_value_changed(value):
	frequency = value
	if frequency > 0:
		$FrequencyLabel.text = str(frequency)
		$Timer.wait_time = 1 / frequency
		$Timer.start()
	else:
		$FrequencyLabel.text = 'Paused'
		$Timer.stop()
