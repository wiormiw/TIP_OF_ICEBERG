extends Node

const PLAYER = preload("res://Player/player.tscn")
const INVENTORY_DATA : InventoryData = preload("res://GUI/inventory/player_inventory.tres")
const SECRET_NOTE_DATA : SecretNoteData = preload("res://GUI/secret_note/scripts/player_secret_note_inventory.tres")

var player : Player
var player_spawned : bool = false

func _ready() -> void:
	var parent = get_parent()
	if parent is Level:
		AddPlayerInstance()
		await get_tree().create_timer(0.2).timeout
		player_spawned = true

func AddPlayerInstance() -> void:
	if player == null:
		player = PLAYER.instantiate()
		add_child(player)
		print("Player instance added.")
	else:
		print("Player instance already exists.")
	pass
	
func SetHealth(hp : int, max_hp : int) -> void:
	player.max_hp = max_hp
	player.hp = hp
	player.UpdateHP(0)
	
func SetPlayerPosition(_new_pos : Vector2) -> void:
	player.global_position = _new_pos
	pass
	
func SetAsParent( _p : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)
		
func UnparentPlayer(_p : Node2D) -> void:
	_p.remove_child(player)

func InitializeSpriteData(
		body_sprite : Sprite2D, 
		arms_sprite : Sprite2D, 
		eyes_sprite : Sprite2D, 
		hair_sprite : Sprite2D, 
		uniform_sprite : Sprite2D, 
		sleeves_sprite : Sprite2D, 
		pants_sprite : Sprite2D, 
		shoes_sprite : Sprite2D
	) -> void:
	if not SaveManager.HasEmptyValues(SaveManager.current_save.player_data):
		body_sprite.modulate = Global.selected_body_color
		arms_sprite.modulate = Global.selected_body_color
		eyes_sprite.modulate = Global.selected_eyes_color

		if Global.selected_hair != "none":
			hair_sprite.texture = Global.hair_collection[Global.selected_hair]
			hair_sprite.modulate = Global.selected_hair_color
			
		uniform_sprite.texture = Global.uniform_collection[Global.selected_uniform]
		sleeves_sprite.texture = Global.sleeves_collection[Global.selected_sleeves]
		pants_sprite.texture = Global.pants_collection[Global.selected_pants]
		shoes_sprite.texture = Global.shoes_collection[Global.selected_shoes]
