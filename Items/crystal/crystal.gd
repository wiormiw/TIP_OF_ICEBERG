@tool
class_name Crystal extends Node2D

@export var item_data : ItemData : set = _set_item_data

var inventory_item_data : ItemData

var is_destroyed : bool = false

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var sprite_2d = $Sprite2D
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var crystal_hurt_box : HurtBox = %CrystalHurtBox
@onready var crystal_hurt_box_collision : CollisionShape2D = $CrystalHurtBox/CollisionShape2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var is_destroyed_data : PersistentDataHandler = $IsDestroyed

func _ready() -> void:
	crystal_hurt_box_collision.disabled = true
	crystal_hurt_box.monitoring = false
	_update_texture()
	if Engine.is_editor_hint():
		return
	interaction_area.interact = Callable(self, "_on_interact")
	Inventory.ItemChanged.connect(_get_inventory_data)
	SetCrystalState()
	process_mode = Node.PROCESS_MODE_INHERIT
	pass
	
func SetCrystalState() -> void:
	is_destroyed = is_destroyed_data.value
	if is_destroyed:
		queue_free()
		return
	pass

func _on_interact() -> void:
	if inventory_item_data:
		inventory_item_data.Use()
		DestroyItem(Global.item_to_destroy)
		is_destroyed = true
		is_destroyed_data.SetValue()		
	else:
		DestroyItem("")
	pass

func _set_item_data(value : ItemData) -> void:
	item_data = value
	_update_texture()
	pass

func _update_texture() -> void:
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture
	pass
	
func DestroyItem(_item_to_destroy : String) -> void:
	print(_item_to_destroy)
	if _item_to_destroy == item_data.name:
		animation_player.play("destroyed")
		await animation_player.animation_finished
		queue_free()
	else:
		crystal_hurt_box_collision.disabled = false
		crystal_hurt_box.monitoring = true
		animation_player.play("triggered")
		await animation_player.animation_finished
		crystal_hurt_box_collision.disabled = true
		crystal_hurt_box.monitoring = false
	pass
	
func _get_inventory_data(_item_data : ItemData) -> void:
	inventory_item_data = _item_data	
