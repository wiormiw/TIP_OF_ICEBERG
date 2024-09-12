@tool
class_name TreasureChest extends Node2D

@export var item_data : ItemData : set = _set_item_data
@export var door_to_open : CellDoor

var is_open : bool = false

@onready var sprite_2d : Sprite2D = $ItemSprite
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var interaction_area : InteractionArea = $InteractionArea
@onready var is_open_data : PersistentDataHandler = $IsOpen

func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	interaction_area.interact = Callable(self, "_on_interact")	
	is_open_data.DataLoaded.connect(SetChestState)
	SetChestState()
	process_mode = Node.PROCESS_MODE_INHERIT
	
func SetChestState() -> void:
	is_open = is_open_data.value
	if is_open:
		animation_player.play("open")
	else:
		animation_player.play("closed")
	
func _on_interact() -> void:
	if is_open == true:
		return
	is_open = true
	is_open_data.SetValue()
	animation_player.play("open_chest")
	if item_data:
		PlayerManager.SECRET_NOTE_DATA.AddSecretNoteItem(item_data)
		await get_tree().create_timer(1.5).timeout
		door_to_open.OpenDoor()
	else:
		printerr("No Item In Chest!")
		door_to_open.animation_player.play("closed")

func _set_item_data(value : ItemData) -> void:
	item_data = value
	_update_texture()
	pass
	
func _update_texture() -> void:
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture
