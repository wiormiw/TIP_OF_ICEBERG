class_name PlayerSpawn extends Node2D

func _ready() -> void:
	visible = false
	if PlayerManager.player_spawned == false:
		PlayerManager.SetPlayerPosition(global_position)
		PlayerManager.player_spawned = true
		
