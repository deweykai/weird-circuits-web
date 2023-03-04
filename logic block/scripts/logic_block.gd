class_name LogicBlock
extends Node2D

signal value_pushed(pushed_value:float)

func send_value(value):
	value_pushed.emit(value)
