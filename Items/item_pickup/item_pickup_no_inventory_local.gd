@tool
class_name ItemPickupNoInventoryLocal extends Node2D

@export var item_data : ItemData : set = _set_item_data
@export var door_to_open : Node2D

var is_used : bool = false

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var is_used_data : PersistentDataHandler = $PersistentDataHandler
@onready var puzzle_9_checker = $"../Puzzle9Checker"

func _ready() -> void:
	is_used_data.DataLoaded.connect(SetState)
	_update_texture()
	if Engine.is_editor_hint():
		return
	interaction_area.interact = Callable(self, "_on_interact")
	puzzle_9_checker.CorrectAnswer.connect(_on_correct_answer)
	puzzle_9_checker.IncorrectAnswer.connect(_on_incorrect_answer)
	SetState()
	visible = false
	interaction_area.monitoring = false
	pass
	
func SetState() -> void:
	is_used = is_used_data.value
	if is_used:
		Global.key_used_count += 1
		queue_free()
		Global.key_used_count = 0

func _on_interact() -> void:
	if item_data:
		ItemPickedUp()
	pass
	
func ItemPickedUp() -> void:
	audio_stream_player_2d.play()
	await audio_stream_player_2d.finished
	door_to_open.OpenDoor()
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
	
func _on_correct_answer() -> void:
	visible = true
	interaction_area.monitoring = true

func _on_incorrect_answer() -> void:
	visible = false
	interaction_area.monitoring = false
