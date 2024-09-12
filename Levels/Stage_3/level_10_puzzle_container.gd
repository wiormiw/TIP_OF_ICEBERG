class_name Level10PuzzleContainer extends Node2D

@onready var hurt_box_10 : HurtBox = %HurtBox10
@onready var audio_false : AudioStream = preload("res://Assets/Audio/wrong_answer.wav")
@onready var lever_10 = %Lever10
@onready var lever_11 = %Lever11
@onready var lever_12 = %Lever12
@onready var lever_13 = %Lever13
@onready var lever_14 = %Lever14
@onready var lever_15 = %Lever15
@onready var lever_16 = %Lever16
@onready var lever_17 = %Lever17
@onready var lever_18 = %Lever18
@onready var lever_19 = %Lever19
@onready var lever_20 = %Lever20
@onready var lever_21 = %Lever21
@onready var lever_22 = %Lever22
@onready var lever_23 = %Lever23
@onready var lever_24 = %Lever24
@onready var lever_25 = %Lever25
@onready var lever_26 = %Lever26
@onready var lever_27 = %Lever27
@onready var lever_28 = %Lever28
@onready var lever_10_answer = %Lever10Answer
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	hurt_box_10.monitoring = false

	var levers = [
		lever_11, lever_12, lever_13, lever_14, lever_15,
		lever_16, lever_17, lever_18, lever_19, lever_20,
		lever_21, lever_22, lever_23, lever_24, lever_25,
		lever_26, lever_27, lever_28, lever_10
	]

	for lever in levers:
		lever.IncorrectAnswer.connect(_on_incorrect_answer)
	lever_10_answer.LeverInteract10.connect(_on_correct_answer)

func _on_incorrect_answer() -> void:
	audio_stream_player_2d.stream = audio_false
	audio_stream_player_2d.play()
	await audio_stream_player_2d.finished
	hurt_box_10.monitoring = true
	await get_tree().create_timer(0.2).timeout
	hurt_box_10.monitoring = false
	
func _on_correct_answer() -> void:
	hurt_box_10.monitoring = false
	
	
