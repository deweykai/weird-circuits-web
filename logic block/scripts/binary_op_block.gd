extends LogicBlock

enum Operator {
	Add, Sub, Mul, Div
}

@export
var operator: Operator

var input_1 = 0
var input_2 = 0

@export
var push_on_input_1 = false

@export
var push_on_input_2 = false

		
func _on_input_1_value_received(value: float):
	input_1 = value
	if push_on_input_1:
		value_received()
	
	
func _on_input_2_value_received(value: float):
	input_2 = value
	if push_on_input_2:
		value_received()


func value_received():
	match operator:
		Operator.Add: self.send_value(input_1 + input_2)
		Operator.Sub: self.send_value(input_1 - input_2)
		Operator.Mul: self.send_value(input_1 * input_2)
		Operator.Div: self.send_value(input_1 / input_2)
