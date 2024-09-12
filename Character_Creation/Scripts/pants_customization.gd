class_name PantsCustomization extends Node2D

@onready var pants_sprite_2d : Sprite2D = $Sprite2D
@onready var audio : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var audio_stream_player = %AudioStreamPlayer

var pants_keys = []
var current_pants_index : int = 0

func _ready() -> void:
	audio_stream_player.stream = audio
	set_sprite_keys()
	update_sprite()

func set_sprite_keys() -> void:
	pants_keys = Global.pants_collection.keys()

func update_sprite() -> void:
	var current_pants_sprite = pants_keys[current_pants_index]
	pants_sprite_2d.texture = Global.pants_collection[current_pants_sprite]
	
	Global.selected_pants = current_pants_sprite

func _on_prev_pants_pressed() -> void:
	audio_stream_player.play()
	current_pants_index = (current_pants_index - 1 + pants_keys.size()) % pants_keys.size()
	update_sprite()

func _on_next_pants_pressed() -> void:
	audio_stream_player.play()
	current_pants_index = (current_pants_index + 1) % pants_keys.size()
	update_sprite()
