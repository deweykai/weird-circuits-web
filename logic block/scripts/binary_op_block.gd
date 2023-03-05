extends LogicBlock

enum Operator {
	Add, Sub, Mul, Div
}



@export
var input_1 = 0
@export
var input_2 = 0

@export
var node_1: LogicBlock

@export
var node_2: LogicBlock

@export
var push_on_input_1 = true

@export
var push_on_input_2 = false

@export
var operator: Operator
		
func _on_input_1_value_received(value: float):
	input_1 = value
	if push_on_input_1:
		value_received()
	
	
func _on_input_2_value_received(value: float):
	input_2 = value
	if push_on_input_2:
		value_received()
	
var state = 0	
func handle_node_action(node):
	if state == 0:
		set_input_block(_on_input_1_value_received, -50).call(node)
	elif state == 1:
		set_input_block(_on_input_2_value_received, 50).call(node)


func set_input_block(callback, offset):
	return func(node):
		if node != null:
			state += 1
			add_line(node, offset)
			node.value_pushed.connect(callback)


func _ready():
	set_input_block(_on_input_1_value_received, -50).call(node_1)
	set_input_block(_on_input_2_value_received, 50).call(node_2)


func value_received():
	match operator:
		Operator.Add: self.send_value(input_1 + input_2)
		Operator.Sub: self.send_value(input_1 - input_2)
		Operator.Mul: self.send_value(input_1 * input_2)
		Operator.Div: self.send_value(input_1 / input_2)
