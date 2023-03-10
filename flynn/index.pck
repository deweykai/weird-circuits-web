GDPC                  p                                                                      
   T   res://.godot/exported/133200997/export-1b11a992ebcc6f262e4ee4a4db300a0d-theme.res   0            ?~)?pI????FLD?    P   res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn?       ?      ??U?ۂ?S?`?        res://.godot/extension_list.cfg ?,      5       q?Y??C?)?$    ,   res://.godot/global_script_class_cache.cfg          ?       
o?`?t ?1?)?*       res://.godot/uid_cache.bin  ?'      ?      t??ƈ?qAf???z.??       res://icon.svg  0      N      ]??s?9^w/??????       res://main.gd   @      ?      L?/??[?T?"p       res://main.tscn.remap   P      a       ?J?Sw? ??????       res://project.binary?,      ?      ??n#+rG???p!??5?       res://theme.tres.remap  ?      b       _lE?x{"DC}?l???    ?F?!??ħ??list=Array[Dictionary]([{
"base": &"Node2D",
"class": &"LogicBlock",
"icon": "",
"language": &"GDScript",
"path": "res://logic block/scripts/logic_block.gd"
}])
+ү???R????,-2RSRC                     PackedScene            ????????                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script    res://main.gd ????????   Theme    res://theme.tres ,?[??'      local://RectangleShape2D_oxxfv w         local://PackedScene_a0rps ?         RectangleShape2D       
    ?8F H?E         PackedScene          	         names "   "      Node2D    script    Area2D    CollisionShape2D    visible 	   position    shape    metadata/_edit_lock_    Panel 
   top_level    offset_right    offset_bottom    PanelContainer 
   Container    layout_mode    VBoxContainer    MenuButton    size_flags_vertical    theme    text    flat    CheckButton    ClearButton    Button    SelectedLabel    Label 
   NoteLabel    autowrap_mode    _on_area_2d_input_event    input_event    _on_check_button_toggled    toggled    _on_clear_button_pressed    pressed    	   variants                        
    aE ??D                     iC    ??C                            Select Node       Place Node       Clear             node_count    
         nodes     p   ????????        ????                            ????                     ????                                             ????   	      
                             ????                          ????                  	      
                          ????                                ????                                ????                          ????                         conn_count             conns                                                               !                        node_paths              editable_instances              version             RSRC???XsZ??T7$extends Node2D

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
?'3??-?????RSRC                     Theme            ????????                                                  resource_local_to_scene    resource_name    default_base_scale    default_font    default_font_size    script           local://Theme_7ms5e          Theme          RSRC?[remap]

path="res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn"
vd0??)??#??>?[remap]

path="res://.godot/exported/133200997/export-1b11a992ebcc6f262e4ee4a4db300a0d-theme.res"
???!6??$???Q+<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><g transform="translate(32 32)"><path d="m-16-32c-8.86 0-16 7.13-16 15.99v95.98c0 8.86 7.13 15.99 16 15.99h96c8.86 0 16-7.13 16-15.99v-95.98c0-8.85-7.14-15.99-16-15.99z" fill="#363d52"/><path d="m-16-32c-8.86 0-16 7.13-16 15.99v95.98c0 8.86 7.13 15.99 16 15.99h96c8.86 0 16-7.13 16-15.99v-95.98c0-8.85-7.14-15.99-16-15.99zm0 4h96c6.64 0 12 5.35 12 11.99v95.98c0 6.64-5.35 11.99-12 11.99h-96c-6.64 0-12-5.35-12-11.99v-95.98c0-6.64 5.36-11.99 12-11.99z" fill-opacity=".4"/></g><g stroke-width="9.92746" transform="matrix(.10073078 0 0 .10073078 12.425923 2.256365)"><path d="m0 0s-.325 1.994-.515 1.976l-36.182-3.491c-2.879-.278-5.115-2.574-5.317-5.459l-.994-14.247-27.992-1.997-1.904 12.912c-.424 2.872-2.932 5.037-5.835 5.037h-38.188c-2.902 0-5.41-2.165-5.834-5.037l-1.905-12.912-27.992 1.997-.994 14.247c-.202 2.886-2.438 5.182-5.317 5.46l-36.2 3.49c-.187.018-.324-1.978-.511-1.978l-.049-7.83 30.658-4.944 1.004-14.374c.203-2.91 2.551-5.263 5.463-5.472l38.551-2.75c.146-.01.29-.016.434-.016 2.897 0 5.401 2.166 5.825 5.038l1.959 13.286h28.005l1.959-13.286c.423-2.871 2.93-5.037 5.831-5.037.142 0 .284.005.423.015l38.556 2.75c2.911.209 5.26 2.562 5.463 5.472l1.003 14.374 30.645 4.966z" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 919.24059 771.67186)"/><path d="m0 0v-47.514-6.035-5.492c.108-.001.216-.005.323-.015l36.196-3.49c1.896-.183 3.382-1.709 3.514-3.609l1.116-15.978 31.574-2.253 2.175 14.747c.282 1.912 1.922 3.329 3.856 3.329h38.188c1.933 0 3.573-1.417 3.855-3.329l2.175-14.747 31.575 2.253 1.115 15.978c.133 1.9 1.618 3.425 3.514 3.609l36.182 3.49c.107.01.214.014.322.015v4.711l.015.005v54.325c5.09692 6.4164715 9.92323 13.494208 13.621 19.449-5.651 9.62-12.575 18.217-19.976 26.182-6.864-3.455-13.531-7.369-19.828-11.534-3.151 3.132-6.7 5.694-10.186 8.372-3.425 2.751-7.285 4.768-10.946 7.118 1.09 8.117 1.629 16.108 1.846 24.448-9.446 4.754-19.519 7.906-29.708 10.17-4.068-6.837-7.788-14.241-11.028-21.479-3.842.642-7.702.88-11.567.926v.006c-.027 0-.052-.006-.075-.006-.024 0-.049.006-.073.006v-.006c-3.872-.046-7.729-.284-11.572-.926-3.238 7.238-6.956 14.642-11.03 21.479-10.184-2.264-20.258-5.416-29.703-10.17.216-8.34.755-16.331 1.848-24.448-3.668-2.35-7.523-4.367-10.949-7.118-3.481-2.678-7.036-5.24-10.188-8.372-6.297 4.165-12.962 8.079-19.828 11.534-7.401-7.965-14.321-16.562-19.974-26.182 4.4426579-6.973692 9.2079702-13.9828876 13.621-19.449z" fill="#478cbf" transform="matrix(4.162611 0 0 -4.162611 104.69892 525.90697)"/><path d="m0 0-1.121-16.063c-.135-1.936-1.675-3.477-3.611-3.616l-38.555-2.751c-.094-.007-.188-.01-.281-.01-1.916 0-3.569 1.406-3.852 3.33l-2.211 14.994h-31.459l-2.211-14.994c-.297-2.018-2.101-3.469-4.133-3.32l-38.555 2.751c-1.936.139-3.476 1.68-3.611 3.616l-1.121 16.063-32.547 3.138c.015-3.498.06-7.33.06-8.093 0-34.374 43.605-50.896 97.781-51.086h.066.067c54.176.19 97.766 16.712 97.766 51.086 0 .777.047 4.593.063 8.093z" fill="#478cbf" transform="matrix(4.162611 0 0 -4.162611 784.07144 817.24284)"/><path d="m0 0c0-12.052-9.765-21.815-21.813-21.815-12.042 0-21.81 9.763-21.81 21.815 0 12.044 9.768 21.802 21.81 21.802 12.048 0 21.813-9.758 21.813-21.802" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 389.21484 625.67104)"/><path d="m0 0c0-7.994-6.479-14.473-14.479-14.473-7.996 0-14.479 6.479-14.479 14.473s6.483 14.479 14.479 14.479c8 0 14.479-6.485 14.479-14.479" fill="#414042" transform="matrix(4.162611 0 0 -4.162611 367.36686 631.05679)"/><path d="m0 0c-3.878 0-7.021 2.858-7.021 6.381v20.081c0 3.52 3.143 6.381 7.021 6.381s7.028-2.861 7.028-6.381v-20.081c0-3.523-3.15-6.381-7.028-6.381" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 511.99336 724.73954)"/><path d="m0 0c0-12.052 9.765-21.815 21.815-21.815 12.041 0 21.808 9.763 21.808 21.815 0 12.044-9.767 21.802-21.808 21.802-12.05 0-21.815-9.758-21.815-21.802" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 634.78706 625.67104)"/><path d="m0 0c0-7.994 6.477-14.473 14.471-14.473 8.002 0 14.479 6.479 14.479 14.473s-6.477 14.479-14.479 14.479c-7.994 0-14.471-6.485-14.471-14.479" fill="#414042" transform="matrix(4.162611 0 0 -4.162611 656.64056 631.05679)"/></g></svg>
h"   h??SlΤ%   res://ani/block-1.png?ٕ'ı?j   res://ani/block-2.png?t(??$?Z   res://ani/block-3.pngR????l   res://ani/block-4.png?k?f=?u   res://ani/block-5.png???YY-h   res://ani/block-6.png}2?4??y   res://ani/block-7.png??K??   res://ani/block-8.png????yѯ`   res://block/block-1.png?D??|.   res://block/block-2.png??;??A   res://block/block-3.png??f?s   res://block/block-4.pngJ?0h:??W   res://block/block-5.png???>M%:   res://block/block-6.pngJ?鷴/   res://block/block-7.png?(H?N?   res://block/block-8.png?pP7??2   res://flynn/index.144x144.png?,??T?    res://flynn/index.180x180.png!?F;??B|   res://flynn/index.512x512.png????   res://flynn/index.png?y????&   res://logic block/binary_op_block.tscn[Yw?u^?#   res://logic block/button_block.tscn??????H)   res://logic block/logic_block_sprite.tscnr?w??~;k#   res://logic block/memory_block.tscnoQ $9??T"   res://logic block/print_block.tscn?? ???l"   res://logic block/timer_block.tscn??~*X?c   res://icon.svg?э????   res://main.tscn,?[??'   res://theme.tres? P??Wfn   res://ui.tscn??a???ks!   res://flynn/web/index.144x144.png?߄q?(8!   res://flynn/web/index.180x180.png???Ѝ?   res://flynn/web/index.png?9?[???t!   res://flynn/web/index.512x512.png:vCy?mق0res://addons/godot-git-plugin/git_plugin.gdextension
]??n7??r?IZECFG      application/config/name         Flynn      application/run/main_scene         res://main.tscn    application/config/features$   "         4.0    Forward Plus       application/config/icon         res://icon.svg  "   editor/version_control/plugin_name      	   GitPlugin   *   editor/version_control/autoload_on_startup         #   rendering/renderer/rendering_method         gl_compatibility4   rendering/textures/vram_compression/import_s3tc_bptc         w?