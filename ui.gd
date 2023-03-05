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

var current_type

signal node_selected(NodeType)

func set_type(x):
	current_type = x
	node_selected.emit(x)
	$Panel/MenuButton.text = NodeTypes.keys()[x]

func _ready():
	for item in NodeTypes:
		$Panel/MenuButton.get_popup().add_item(str(item))
		
	$Panel/MenuButton.get_popup().id_pressed.connect(_on_popup_id_pressed)
	set_type(NodeTypes.Timer)

func _on_popup_id_pressed(id):
	set_type(id)
