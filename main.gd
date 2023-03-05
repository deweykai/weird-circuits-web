extends Node2D

enum NodeTypes {
	Timer,
	Button,
	Binary,
	Memory,
	Print,
}

var timer = preload("res://logic block/timer_block.tscn")
var button = preload("res://logic block/button_block.tscn")
var binary = preload("res://logic block/binary_op_block.tscn")
var memory = preload("res://logic block/memory_block.tscn")
var printblk = preload("res://logic block/print_block.tscn")

signal node_selected(NodeType)

var current_type

@onready var ui_menu = $Panel/Container/MenuButton
@onready var ui_place_button = $Panel/Container/CheckButton
@onready var ui_selected_label = $Panel/Container/SelectedLabel
@onready var ui_note_label = $Panel/Container/NoteLabel

var place_mode = false



func set_type(x):
	current_type = x
	node_selected.emit(x)
	ui_menu.text = NodeTypes.keys()[x]
	ui_place_button.button_pressed = true

func set_selection_text(name, note: String):
	ui_selected_label.text = 'Selection: %s' % name
	ui_note_label.text = note

func _ready():
	for item in NodeTypes:
		ui_menu.get_popup().add_item(str(item))
		
	for child in get_children():
		if child is LogicBlock:
			child.clicked.connect(_on_child_node_block_click)
		
	ui_menu.get_popup().id_pressed.connect(_on_popup_id_pressed)
	set_type(NodeTypes.Timer)
	
	set_selection_text('none', '')
	

func _on_popup_id_pressed(id):
	set_type(id)
	
var nodes_created = 0

func create_node():
	var mouse_position = get_global_mouse_position()
	if place_mode:
		ui_place_button.button_pressed = false
		var node
		# creat node
		match current_type:
			NodeTypes.Timer: 
				node = timer.instantiate()
				node.set_meta('name', 'timer %s' % str(nodes_created))
				node.set_meta('note', '')
			NodeTypes.Button: 
				node = button.instantiate()
				node.set_meta('name', 'button %s' % str(nodes_created))
				node.set_meta('note', '')
			NodeTypes.Binary:
				node = binary.instantiate()
				node.set_meta('name', 'binary %s' % str(nodes_created))
				node.set_meta('note', 'make sure right input does not directly connect to this nodes output')
				
			NodeTypes.Memory:
				node = memory.instantiate()
				node.set_meta('name', 'memory %s' % str(nodes_created))
				node.set_meta('note', '')
			NodeTypes.Print:
				node = printblk.instantiate()
				node.set_meta('name', 'print %s' % str(nodes_created))
				node.set_meta('note', '')
			
		nodes_created += 1
			
		node.position = mouse_position
		node.clicked.connect(_on_child_node_block_click)
		node.set_label(node.get_meta('name'))
		add_child(node)
		
var selected_node
		
func _on_child_node_block_click(node):
	if node is LogicBlock:
		if selected_node is LogicBlock and selected_node != node:
			selected_node.handle_node_action(node)

			selected_node = null
			set_selection_text('none', '')
		else:
			if selected_node == null:
				selected_node = node
				set_selection_text(
					selected_node.get_meta('name'),
					selected_node.get_meta('note'))
			else:
				selected_node = null
				set_selection_text('none', '')

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			create_node()


func _on_check_button_toggled(button_pressed):
	place_mode = button_pressed


func _on_clear_button_pressed():
	for child in get_children():
		if child is LogicBlock or child is Line2D:
			remove_child(child)
