@tool
class_name ItemPickup extends Node2D

@export var item_data : ItemData : set = _set_item_data

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	interaction_area.interact = Callable(self, "_on_interact")
	pass

func _on_interact() -> void:
	if item_data:
		if PlayerManager.INVENTORY_DATA.AddItem(item_data):
			Inventory.ItemChanged.emit(item_data)
			ItemPickedUp()
	pass
	
func ItemPickedUp() -> void:
	audio_stream_player_2d.play()
	await audio_stream_player_2d.finished
	pass

func _set_item_data(value : ItemData) -> void:
	item_data = value
	_update_texture()
	pass

func _update_texture() -> void:
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture
	pass
