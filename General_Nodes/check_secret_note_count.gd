class_name CheckSecretNoteCount extends Node2D

@export var door_to_open : DungeonDoor
@export var item_count_to_open : int

var door_opened: bool = false

func _process(_delta : float) -> void:
	_check_secret_note()

func _check_secret_note() -> void:
	if not door_opened and (SaveManager.ItemCount() >= item_count_to_open or Global.secret_note_count >= item_count_to_open):
		await get_tree().create_timer(0.5).timeout
		door_to_open.OpenDoor()
		door_opened = true
	elif not door_opened:
		door_to_open.animation_player.play("closed")
