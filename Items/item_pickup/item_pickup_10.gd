@tool
class_name ItemPickupKey10 extends Node2D

@export var item_data : ItemData : set = _set_item_data
@export var door_to_open : Node2D

var is_found : bool = false

signal KeyUsed

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var is_found_data : PersistentDataHandler = $PersistentDataHandler
@onready var speech_sfx : AudioStream = preload("res://Assets/Audio/text.wav")
@onready var audio_true : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var audio_pickup : AudioStream = preload("res://Assets/Audio/item_pickup.wav")
@onready var lever_10_answer = $"../Lever10Answer"

var lines : Array[String] = [
	"Selamat!",
	"Kunci ditemukan!",
	"Lanjut...."
]

func _ready() -> void:
	sprite_2d.visible = false
	interaction_area.monitoring = false
	is_found_data.DataLoaded.connect(SetState)
	lever_10_answer.LeverInteract10.connect(ShowKey)
	Global.key_used_count = 0
	_update_texture()
	if Engine.is_editor_hint():
		return
	interaction_area.interact = Callable(self, "_on_interact")
	SetState()
	pass
	
func SetState() -> void:
	is_found = is_found_data.value
	if is_found:
		Global.key_used_count += 1
		sprite_2d.visible = true
		interaction_area.monitoring = false
		Global.key_used_count = 0

func ShowKey() -> void:
	audio_stream_player_2d.stream = audio_true
	audio_stream_player_2d.play()
	sprite_2d.visible = true
	interaction_area.monitoring = true

func _on_interact() -> void:
	if item_data:
		ItemPickedUp()
		DialogManager.StartDialog(global_position, lines, speech_sfx)
		await DialogManager.DialogFinished
		door_to_open.OpenDoor()
		Global.key_used_count += 1
		is_found_data.SetValue()
		KeyUsed.emit()
	pass
	
func ItemPickedUp() -> void:
	sprite_2d.visible = true
	audio_stream_player_2d.stream = audio_pickup
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
