class_name Lever3 extends Node2D

signal Answer(_lever3 : Lever3, _answer : bool)

@export var text_label : String = ""
@export var answer : bool = false
@export var door_to_open : CellDoor

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var interaction_area : InteractionArea = $InteractionArea
@onready var label : Label = $Label

func _ready() -> void:
	label.text = text_label
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact() -> void:
	animation_player.play("switch_on")
	Answer.emit(self, answer)

func _on_lever_reset() -> void:
	await animation_player.animation_finished
	animation_player.play("switch_reverse")
