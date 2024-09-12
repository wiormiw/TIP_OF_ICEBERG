class_name Sign extends Node2D

@export var lines : Array[String]

@onready var interaction_area = $InteractionArea

@onready var speech_sfx : AudioStream = preload("res://Assets/Audio/text.wav")

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact() -> void:
	DialogManager.StartDialog(global_position, lines, speech_sfx)
	await DialogManager.DialogFinished
