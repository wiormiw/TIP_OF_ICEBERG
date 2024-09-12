@tool
class_name ItemPickupNoInventory extends Node2D

@export var item_data : ItemData : set = _set_item_data
@export var door_to_open : Node2D

var is_used : bool = false

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var is_used_data : PersistentDataHandler = $PersistentDataHandler
@onready var key_hurt_box : HurtBox = %KeyHurtBox
@onready var speech_sfx : AudioStream = preload("res://Assets/Audio/text.wav")

var lines : Array[String] = [
	"Jangan greedy!",
	"Terima hukumanmu!"
]

func _ready() -> void:
	is_used_data.DataLoaded.connect(SetState)
	Global.key_used_count = 0
	key_hurt_box.monitoring = false
	_update_texture()
	if Engine.is_editor_hint():
		return
	interaction_area.interact = Callable(self, "_on_interact")
	SetState()
	pass
	
func SetState() -> void:
	is_used = is_used_data.value
	if is_used:
		Global.key_used_count += 1
		queue_free()

func _on_interact() -> void:
	if item_data:
		ItemPickedUp()
		if Global.key_used_count == 0:
			door_to_open.OpenDoor()
			Global.key_used_count += 1
			is_used_data.SetValue()
			queue_free()
		else:
			DialogManager.StartDialog(global_position, lines, speech_sfx)
			await DialogManager.DialogFinished
			key_hurt_box.monitoring = true
			Global.key_used_count = 0
			await get_tree().create_timer(0.5).timeout
			key_hurt_box.monitoring = false
			queue_free()
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
