class_name Lever10 extends Node2D

signal IncorrectAnswer

var is_answered : bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var interaction_area : InteractionArea = $InteractionArea
@onready var level_10_puzzle_container = $"../Level10PuzzleContainer"
@onready var lever_10_answer = $"../Lever10Answer"
@onready var is_answered_data : PersistentDataHandler = $PersistentDataHandler
@onready var item_pickup_key_10 = $"../ItemPickupKey10"

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	lever_10_answer.LeverInteract10.connect(_on_correct_answered)
	item_pickup_key_10.KeyUsed.connect(_on_key_used)
	is_answered_data.DataLoaded.connect(SetState)
	SetState()
	
func _on_interact() -> void:
	animation_player.play("switch_on")
	IncorrectAnswer.emit()
	await get_tree().create_timer(0.5).timeout
	_on_lever_reset()

func _on_lever_reset() -> void:
	await animation_player.animation_finished
	animation_player.play("switch_reverse")
	
func _on_correct_answered() -> void:
	interaction_area.monitoring = false
	animation_player.play("default")

func _on_key_used() -> void:
	is_answered_data.SetValue()

func SetState() -> void:
	is_answered = is_answered_data.value
	if is_answered:
		interaction_area.monitoring = false
		animation_player.play("default")
	else:
		interaction_area.monitoring = true
