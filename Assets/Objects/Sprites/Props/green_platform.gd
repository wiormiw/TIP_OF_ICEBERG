class_name GreenPlatform extends Node2D

signal Activated
signal Deactivated

var bodies : int = 0
var is_active : bool = false
var off_rect : Rect2

@onready var area_2d : Area2D = $Area2D
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var audio : AudioStream = preload("res://Assets/Audio/suck_1v2.wav")

func _ready() -> void:
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.body_exited.connect(_on_body_exited)
	off_rect = sprite_2d.region_rect
	
func _on_body_entered(b : Node2D) -> void:
	bodies += 1
	PlayAudio(audio)
	pass
	
func _on_body_exited(b : Node2D) -> void:
	bodies -= 1
	pass
		
func PlayAudio(_stream : AudioStream) -> void:
	audio_stream_player_2d.stream = _stream
	audio_stream_player_2d.play()

