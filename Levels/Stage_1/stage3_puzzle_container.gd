class_name Stage3PuzzleContainer extends Node2D

@onready var stage_3_hurt_box = %Stage3HurtBox
@onready var lever_3 = %Lever3
@onready var lever_4 = %Lever4
@onready var lever_7 = %Lever7
@onready var lever_8 = %Lever8
@onready var lever_6 = %Lever6
@onready var lever_5 = %Lever5
@onready var audio_true : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var audio_false : AudioStream = preload("res://Assets/Audio/wrong_answer.wav")
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	stage_3_hurt_box.monitoring = false
	
	var levers = [lever_3, lever_4, lever_5, lever_6, lever_7, lever_8]
	
	for lever in levers:
		lever.Answer.connect(_on_get_answer)
		
func _on_get_answer(_lever : Lever3, _answer : bool) -> void:
	if _answer:
		audio_stream_player_2d.stream = audio_true
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		_lever.door_to_open.OpenDoor()
	else:
		audio_stream_player_2d.stream = audio_false
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		stage_3_hurt_box.monitoring = true
		_lever.animation_player.play("reverse_switch")
		await get_tree().create_timer(0.2).timeout
		stage_3_hurt_box.monitoring = false
