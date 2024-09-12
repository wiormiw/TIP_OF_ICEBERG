class_name PressurePlate extends Node2D

@export var correct_box_id: int

signal Activated
signal Deactivated
signal StoneTrue(value : int)
signal StoneFalse(value : int)

var bodies : int = 0
var is_active : bool = false
var off_rect : Rect2

@onready var area_2d : Area2D = $Area2D
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var audio_activate : AudioStream = preload("res://Assets/Audio/lever-01.wav")
@onready var audio_deactivate : AudioStream = preload("res://Assets/Audio/lever-02.wav")
@onready var audio_true : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var audio_false : AudioStream = preload("res://Assets/Audio/wrong_answer.wav")

func _ready() -> void:
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.body_exited.connect(_on_body_exited)
	off_rect = sprite_2d.region_rect
	
func _on_body_entered(b : Node2D) -> void:
	bodies += 1
	CheckIsActivated()
	CheckAnswer(b)
	pass
	
func _on_body_exited(b : Node2D) -> void:
	bodies -= 1
	CheckIsActivated()
	CheckAnswerExit(b)
	pass
	
func CheckIsActivated() -> void:
	if bodies > 0 and is_active == false:
		is_active = true
		sprite_2d.region_rect.position.x = off_rect.position.x + 32
		PlayAudio(audio_activate)
		Activated.emit()
	elif bodies <= 0 and is_active == true:
		is_active = false
		sprite_2d.region_rect.position.x = off_rect.position.x
		PlayAudio(audio_deactivate)
		Deactivated.emit()
		
func PlayAudio(_stream : AudioStream) -> void:
	audio_stream_player_2d.stream = _stream
	audio_stream_player_2d.play()
	
func CheckAnswer(b : Node2D) -> void:
	if b is PushableStone:
		var pushable_stone = b as PushableStone
		if pushable_stone.correct_answer == correct_box_id:
			PlayAudio(audio_true)
			StoneTrue.emit(1)
		else:
			PlayAudio(audio_false)
			StoneFalse.emit(0)
	else:
		print("Body is not a PushableStone")
		
func CheckAnswerExit(b : Node2D) -> void:
	if b is PushableStone:
		var pushable_stone = b as PushableStone
		if pushable_stone.correct_answer == correct_box_id:
			StoneTrue.emit(-1)
		else:
			StoneFalse.emit(0)
	else:
		print("Body is not a PushableStone")
