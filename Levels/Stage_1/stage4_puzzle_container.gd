class_name Stage4PuzzleContainer extends Node2D

var final_result : bool = false

var correct_answer : int = 0

var incorrect_answer : int = 0

@export var door_to_open : CellDoor
@onready var switch_tile = %SwitchTile
@onready var switch_tile_2 = %SwitchTile2
@onready var switch_tile_3 = %SwitchTile3
@onready var switch_tile_4 = %SwitchTile4
@onready var switch_tile_5 = %SwitchTile5
@onready var switch_tile_6 = %SwitchTile6
@onready var switch_tile_7 = %SwitchTile7
@onready var switch_tile_8 = %SwitchTile8
@onready var switch_tile_9 = %SwitchTile9
@onready var switch_tile_10 = %SwitchTile10
@onready var switch_tile_11 = %SwitchTile11
@onready var switch_tile_12 = %SwitchTile12
@onready var switch_tile_13 = %SwitchTile13
@onready var switch_tile_14 = %SwitchTile14
@onready var switch_tile_15 = %SwitchTile15
@onready var switch_tile_16 = %SwitchTile16
@onready var switch_tile_17 = %SwitchTile17
@onready var switch_tile_18 = %SwitchTile18
@onready var switch_tile_19 = %SwitchTile19
@onready var switch_tile_20 = %SwitchTile20
@onready var switch_tile_21 = %SwitchTile21
@onready var switch_tile_22 = %SwitchTile22
@onready var switch_tile_23 = %SwitchTile23
@onready var switch_tile_24 = %SwitchTile24
@onready var switch_tile_25 = %SwitchTile25
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_true : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var audio_false : AudioStream = preload("res://Assets/Audio/wrong_answer.wav")
@onready var lever_4 = %"Lever4-4"
@onready var stage_4_hurt_box : HurtBox = %Stage4HurtBox
@onready var int_persistent_data_handler : IntPersistenDataHandler = $IntPersistentDataHandler

func _ready() -> void:
	stage_4_hurt_box.monitoring = false
	var switchs = [
		switch_tile, switch_tile_2, switch_tile_3, switch_tile_4, switch_tile_5,
		switch_tile_6, switch_tile_7, switch_tile_8, switch_tile_9, switch_tile_10,
		switch_tile_11, switch_tile_12, switch_tile_13, switch_tile_14, switch_tile_15,
		switch_tile_16, switch_tile_17, switch_tile_18, switch_tile_19, switch_tile_20,
		switch_tile_21, switch_tile_22, switch_tile_23, switch_tile_24, switch_tile_25
	]
	
	for switch in switchs:
		switch.TileChange.connect(_on_tile_changed)
	lever_4.Submit.connect(_on_submit)		
	int_persistent_data_handler.IntDataLoaded.connect(SetState)
	SetState()
	
func SetState() -> void:
	correct_answer = int_persistent_data_handler.GetIntValueByKey("correct_answer")
	incorrect_answer = int_persistent_data_handler.GetIntValueByKey("incorrect_answer")

func _on_tile_changed(value : bool, correctness : bool, _tile : SwitchTile) -> void:
	if value and correctness:
		correct_answer += 1
	elif not value and correctness:
		if correct_answer > 0:
			correct_answer -= 1 
	elif value and not correctness:
		incorrect_answer += 1
	else:
		if incorrect_answer > 0:
			incorrect_answer -= 1
	int_persistent_data_handler.SetIntValue("correct_answer", correct_answer)
	int_persistent_data_handler.SetIntValue("incorrect_answer", incorrect_answer)
	_tile.tile_value_data.SetValue()

func _on_submit(_lever : Lever4) -> void:
	if correct_answer >= 16 and incorrect_answer == 0:
		final_result = true
		audio_stream_player_2d.stream = audio_true
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		door_to_open.OpenDoor()
		_lever.is_submit_data.SetValue()
	else:
		final_result = false
		audio_stream_player_2d.stream = audio_false
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		door_to_open.animation_player.play("closed")
		_lever.animation_player.play("reverse_switch")
		stage_4_hurt_box.monitoring = true
		await get_tree().create_timer(0.2).timeout
		stage_4_hurt_box.monitoring = false
