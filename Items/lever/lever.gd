class_name Lever extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var interaction_area : InteractionArea = $InteractionArea

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact() -> void:
	animation_player.play("switch_on")

func _on_lever_reset() -> void:
	await animation_player.animation_finished
	animation_player.play("switch_reverse")
