class_name HairCustomization extends Node2D

@onready var hair_sprite_2d : Sprite2D = $Sprite2D
@onready var audio : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var audio_stream_player = %AudioStreamPlayer

var hair_keys = []
var color_keys = []
var current_hair_index : int = 0
var current_color_index : int = 0

func _ready() -> void:
	audio_stream_player.stream = audio
	set_sprite_keys()
	update_sprite()

func set_sprite_keys() -> void:
	hair_keys = Global.hair_collection.keys()

func update_sprite() -> void:
	var current_hair_sprite = hair_keys[current_hair_index]
	if current_hair_sprite == "none":
		hair_sprite_2d.texture = null
	else:
		hair_sprite_2d.texture = Global.hair_collection[current_hair_sprite]
		hair_sprite_2d.modulate = Global.hair_color_options[current_color_index]
	
	Global.selected_hair = current_hair_sprite
	Global.selected_hair_color = Global.color_to_hex(Global.hair_color_options[current_color_index])

func _on_prev_hair_pressed() -> void:
	audio_stream_player.play()
	current_hair_index = (current_hair_index - 1 + hair_keys.size()) % hair_keys.size()
	update_sprite()

func _on_next_hair_pressed() -> void:
	audio_stream_player.play()
	current_hair_index = (current_hair_index + 1) % hair_keys.size()
	update_sprite()

func _on_prev_hair_color_pressed() -> void:
	audio_stream_player.play()
	current_color_index = (current_color_index - 1 + Global.hair_color_options.size()) % Global.hair_color_options.size()
	update_sprite()

func _on_next_hair_color_pressed() -> void:
	audio_stream_player.play()
	current_color_index = (current_color_index + 1) % Global.hair_color_options.size()
	update_sprite()
