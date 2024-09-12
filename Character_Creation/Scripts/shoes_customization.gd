class_name ShoesCustomization extends Node2D

@onready var shoes_sprite_2d : Sprite2D = $Sprite2D
@onready var audio : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var audio_stream_player = %AudioStreamPlayer

var shoes_keys = []
var current_shoes_index : int = 0

func _ready() -> void:
	audio_stream_player.stream = audio
	set_sprite_keys()
	update_sprite()

func set_sprite_keys() -> void:
	shoes_keys = Global.shoes_collection.keys()

func update_sprite() -> void:
	var current_shoes_sprite = shoes_keys[current_shoes_index]
	shoes_sprite_2d.texture = Global.shoes_collection[current_shoes_sprite]
	
	Global.selected_shoes = current_shoes_sprite

func _on_prev_shoes_pressed() -> void:
	audio_stream_player.play()
	current_shoes_index = (current_shoes_index - 1 + shoes_keys.size()) % shoes_keys.size()
	update_sprite()

func _on_next_shoes_pressed() -> void:
	audio_stream_player.play()
	current_shoes_index = (current_shoes_index + 1) % shoes_keys.size()
	update_sprite()
