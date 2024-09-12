class_name Lever4 extends Node2D

signal Submit (lever : Lever4)

@export var label_text : String = ""

var is_submit : bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var interaction_area : InteractionArea = $InteractionArea
@onready var is_submit_data : PersistentDataHandler = $PersistentDataHandler
@onready var label : Label = $Label
@onready var stage_4_puzzle_container = $"../Stage4PuzzleContainer"

func _ready() -> void:
	label.text = label_text
	interaction_area.interact = Callable(self, "_on_interact")
	is_submit_data.DataLoaded.connect(SetState)
	SetState()
	pass

func SetState() -> void:
	is_submit = is_submit_data.value
	label.text = label_text
	if is_submit:
		animation_player.play("used")
		interaction_area.monitoring = false
	else:
		animation_player.play("default")

func _on_interact() -> void:
	animation_player.play("switch_on")
	Submit.emit(self)
	
