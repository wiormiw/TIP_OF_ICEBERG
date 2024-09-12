class_name BodyCustomization extends Node2D

@onready var body_sprite_2d : Sprite2D = $Sprite2D
@onready var arms_sprite_2d : Sprite2D = $"../Arms/Sprite2D"
@onready var audio : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var audio_stream_player = %AudioStreamPlayer

var color_keys = []
var current_color_index : int = 0

func _ready() -> void:
	audio_stream_player.stream = audio
	update_sprite()

func update_sprite() -> void:		
	body_sprite_2d.modulate = Global.body_color_options[current_color_index]
	arms_sprite_2d.modulate = Global.body_color_options[current_color_index]

	Global.selected_body = "01"
	Global.selected_arms = "01"
	Global.selected_body_color = Global.color_to_hex(Global.body_color_options[current_color_index])

func _on_prev_body_pressed() -> void:
	audio_stream_player.play()
	current_color_index = (current_color_index - 1 + Global.body_color_options.size()) % Global.body_color_options.size()
	update_sprite()

func _on_next_body_pressed() -> void:
	audio_stream_player.play()
	current_color_index = (current_color_index + 1) % Global.body_color_options.size()
	update_sprite()
	
	
