extends LogicBlock

func _on_value_received(value):
	self.send_value(value)
