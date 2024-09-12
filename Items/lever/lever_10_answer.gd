class_name Lever10Answer extends Node2D

signal LeverInteract10

var is_answered : bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var interaction_area : InteractionArea = $InteractionArea
@onready var is_answered_data : PersistentDataHandler = $PersistentDataHandler
@onready var item_pickup_key_10 = %ItemPickupKey10

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	item_pickup_key_10.KeyUsed.connect(_on_key_used)
	is_answered_data.DataLoaded.connect(SetState)
	SetState()
	
func _on_interact() -> void:
	animation_player.play("switch_on")
	LeverInteract10.emit()

func _on_lever_reset() -> void:
	await animation_player.animation_finished
	animation_player.play("switch_reverse")
	
func _on_key_used() -> void:
	is_answered_data.SetValue()

func SetState() -> void:
	is_answered = is_answered_data.value
	if is_answered:
		interaction_area.monitoring = false
		animation_player.play("answered")
	else:
		animation_player.play("default")
