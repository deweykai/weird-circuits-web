extends LogicBlock

@export
var input_node: LogicBlock

var state = 0
func set_input_block(node):
	if node != null:
		state += 1
		add_line(node)
		node.value_pushed.connect(_on_input_value_pushed)

func handle_node_action(node):
	if state == 0:
		set_input_block(node)

func _ready():
	set_input_block(input_node)

func _on_input_value_pushed(value: float):
	$OutputLabel.text = str(value)
