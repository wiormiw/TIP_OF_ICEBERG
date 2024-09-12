class_name UniformCustomization extends Node2D

@onready var uniform_sprite_2d : Sprite2D = $Sprite2D
@onready var sleeves_sprite_2d : Sprite2D = $"../Sleeves/Sprite2D"
@onready var audio : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var audio_stream_player = %AudioStreamPlayer

var uniform_keys = []
var sleeves_keys = []
var current_uniform_index : int = 0 # Sleeves linked with uniform, so doesn't need separate index for that.

func _ready() -> void:
	audio_stream_player.stream = audio
	set_sprite_keys()
	update_sprite()

func set_sprite_keys() -> void:
	uniform_keys = Global.uniform_collection.keys()
	sleeves_keys = Global.sleeves_collection.keys()

func update_sprite() -> void:
	var current_uniform_sprite = uniform_keys[current_uniform_index]
	var current_sleeves_sprite = sleeves_keys[current_uniform_index]
	uniform_sprite_2d.texture = Global.uniform_collection[current_uniform_sprite]
	sleeves_sprite_2d.texture = Global.sleeves_collection[current_sleeves_sprite]
	
	Global.selected_uniform = current_uniform_sprite
	Global.selected_sleeves = current_sleeves_sprite

func _on_prev_uniform_pressed() -> void:
	audio_stream_player.play()
	current_uniform_index = (current_uniform_index - 1 + uniform_keys.size()) % uniform_keys.size()
	update_sprite()

func _on_next_uniform_pressed() -> void:
	audio_stream_player.play()
	current_uniform_index = (current_uniform_index + 1) % uniform_keys.size()
	update_sprite()
