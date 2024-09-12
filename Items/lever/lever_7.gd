class_name Lever7 extends Node2D

signal LeverInteract

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var interaction_area : InteractionArea = $InteractionArea
@onready var color_lever = $".."

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	color_lever.LeverReset.connect(_on_lever_reset)
	
func _on_interact() -> void:
	animation_player.play("switch_on")
	LeverInteract.emit()

func _on_lever_reset() -> void:
	await animation_player.animation_finished
	animation_player.play("switch_reverse")
