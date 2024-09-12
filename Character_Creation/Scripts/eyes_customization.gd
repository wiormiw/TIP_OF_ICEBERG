class_name EyesCustomization extends Node2D

@onready var eyes_sprite_2d : Sprite2D = $Sprite2D
@onready var audio : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var audio_stream_player = %AudioStreamPlayer

var color_keys = []
var current_color_index : int = 0

func _ready():
	audio_stream_player.stream = audio
	update_sprite()

func update_sprite() -> void:		
	eyes_sprite_2d.modulate = Global.eyes_color_options[current_color_index]

	Global.selected_eyes = "01"
	Global.selected_eyes_color = Global.color_to_hex(Global.eyes_color_options[current_color_index])

func _on_prev_eyes_pressed() -> void:
	audio_stream_player.play()
	current_color_index = (current_color_index - 1 + Global.eyes_color_options.size()) % Global.eyes_color_options.size()
	update_sprite()

func _on_next_eyes_pressed() -> void:
	audio_stream_player.play()
	current_color_index = (current_color_index + 1) % Global.eyes_color_options.size()
	update_sprite()
