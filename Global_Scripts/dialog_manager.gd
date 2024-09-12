extends Node

@onready var text_box_scene = preload("res://GUI/text_box/text_box.tscn")

var dialog_lines : Array[String] = []
var current_line_index : int = 0

var text_box : TextBox
var text_box_pos : Vector2

var sfx : AudioStream

var is_dialog_active : bool = false
var can_advance_line : bool = false

signal DialogFinished

func StartDialog(position : Vector2, lines : Array[String], speech_sfx : AudioStream):
	if is_dialog_active:
		return
		
	dialog_lines = lines
	text_box_pos = position
	sfx = speech_sfx
	_show_text_box()
	
	is_dialog_active = true
	
func _show_text_box() -> void:
	text_box = text_box_scene.instantiate()
	text_box.FinishedDisplaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_pos
	text_box.z_index = 1000
	text_box.DisplayText(dialog_lines[current_line_index], sfx)
	can_advance_line = false
	
func _on_text_box_finished_displaying() -> void:
	can_advance_line = true
	
func _unhandled_input(event : InputEvent):
	if (
		event.is_action_pressed("advance_dialog") &&
		is_dialog_active &&
		can_advance_line
	):
		text_box.queue_free()
		
		current_line_index += 1
		if current_line_index >= dialog_lines.size():
			is_dialog_active = false
			current_line_index = 0
			DialogFinished.emit()
			return
			
		_show_text_box()
	
