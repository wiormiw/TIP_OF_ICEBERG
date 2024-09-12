class_name DungeonDoor extends Node2D

@export var is_open : bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var is_open_data : PersistentDataHandler = $PersistentDataHandler

func _ready() -> void:
	is_open_data.DataLoaded.connect(SetState)
	if is_open:
		animation_player.play("open")
	else:
		SetState()

func SetState() -> void:
	is_open = is_open_data.value
	if is_open:
		animation_player.play("open")
	else:
		animation_player.play("closed")
	
func OpenDoor() -> void:
	animation_player.play("open_door")
	is_open_data.SetValue()
	pass
	
func CloseDoor() -> void:
	animation_player.play("close_door")
	pass
