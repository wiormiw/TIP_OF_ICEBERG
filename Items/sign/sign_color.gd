class_name ColorSign extends Node2D

@export var lines : Array[String]

@onready var interaction_area = $InteractionArea

@onready var speech_sfx : AudioStream = preload("res://Assets/Audio/text.wav")

@onready var color_lever = $".."

var color_data : String

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	color_lever.SetColorName.connect(_set_color)
	
func _on_interact() -> void:
	DialogManager.StartDialog(global_position, lines, speech_sfx)
	await DialogManager.DialogFinished
	
func _set_color(_color : String) -> void:
	if lines.size() > 0 :
		lines[0] = _color
	else:
		lines.append(_color)
