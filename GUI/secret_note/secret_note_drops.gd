@tool
class_name SecretNoteDrops extends CharacterBody2D

@export var item_data : ItemData : set = _set_item_data

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	if SaveManager.IsItemCollected(item_data.resource_path):
		queue_free()
		return
	interaction_area.interact = Callable(self, "_on_interact")
	pass
	
func _physics_process(delta : float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	velocity -= velocity * delta * 4

func _on_interact() -> void:
	if item_data:
		if PlayerManager.SECRET_NOTE_DATA.AddSecretNoteItem(item_data) == true:
			SecretNotePickedUp()
	pass
	
func SecretNotePickedUp() -> void:
	animation_player.play("default")
	await animation_player.animation_finished
	queue_free()
	pass

func _set_item_data(value : ItemData) -> void:
	item_data = value
	_update_texture()
	pass

func _update_texture() -> void:
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture
	pass
