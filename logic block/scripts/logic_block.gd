class_name LogicBlock
extends Node2D

signal value_pushed(pushed_value:float)

signal clicked(LogicBlock)

func set_label(name):
	var label = Label.new()
	label.text = name
	label.position = Vector2(-40, -70)
	add_child(label)

func _on_logic_block_clicked():
	clicked.emit(self)
	
func handle_node_action(node):
	print('no node action')

func add_line(other_node, offset=0):
	var line = Line2D.new()
	var height = 160 - 20
	line.add_point(self.position + Vector2(offset, -height/2.))
	line.add_point(other_node.position + Vector2(0, height/2.))
	line.z_index = -1
	get_parent().call_deferred('add_child', line)

func send_value(value):
	value_pushed.emit(value)
