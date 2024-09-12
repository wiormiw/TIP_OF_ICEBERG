class_name RedPlatform extends Node2D

signal Activated
signal Deactivated

var bodies : int = 0
var is_active : bool = false
var off_rect : Rect2

@onready var area_2d : Area2D = $Area2D
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var audio_activated : AudioStream = preload("res://Assets/Audio/lever-01.wav")
@onready var audio_deactivated : AudioStream = preload("res://Assets/Audio/lever-02.wav")

func _ready() -> void:
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.body_exited.connect(_on_body_exited)
	off_rect = sprite_2d.region_rect
	
func _on_body_entered(_b : Node2D) -> void:
	bodies += 1
	CheckIsActivated()
	pass
	
func _on_body_exited(_b : Node2D) -> void:
	bodies -= 1
	CheckIsActivated()
	pass
	
func CheckIsActivated() -> void:
	if bodies > 0 and is_active == false:
		is_active = true
		sprite_2d.region_rect.position.x = off_rect.position.x + 32
		PlayAudio(audio_activated)
		Activated.emit()
	elif bodies <= 0 and is_active == true:
		is_active = false
		sprite_2d.region_rect.position.x = off_rect.position.x
		PlayAudio(audio_deactivated)
		Deactivated.emit()
		
func PlayAudio(_stream : AudioStream) -> void:
	audio_stream_player_2d.stream = _stream
	audio_stream_player_2d.play()


