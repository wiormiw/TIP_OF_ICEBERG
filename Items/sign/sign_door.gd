class_name SignDoor extends Node2D

@export var lines : Array[String]

@export var door_to_open : DungeonDoor

@onready var interaction_area = $InteractionArea

@onready var speech_sfx : AudioStream = preload("res://Assets/Audio/text.wav")

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact() -> void:
	DialogManager.StartDialog(global_position, lines, speech_sfx)
	await DialogManager.DialogFinished
	if door_to_open.is_open == false:
		door_to_open.OpenDoor()
		door_to_open.is_open = true
