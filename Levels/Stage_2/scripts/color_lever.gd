class_name ColorLever extends Node2D

signal LeverInteracted
signal SetColor(color_name : String)
signal LeverReset

@onready var guess_the_color = $".."
@onready var lever = %"Lever7-7"
@onready var label = $Label

func _ready() -> void:
	lever.LeverInteract.connect(_on_lever_interact)
	SetColor.connect(_set_label_color)	
	
func _on_lever_interact() -> void:
	LeverInteracted.emit(label.text)

func _set_label_color(color_name : String) -> void:
	label.text = color_name
