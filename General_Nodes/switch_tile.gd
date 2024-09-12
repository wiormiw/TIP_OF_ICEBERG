class_name SwitchTile extends Node2D

signal TileChange(value : bool, value_correct : bool, tile : SwitchTile)

@export var tile_correctness : bool = false

var tile_value : bool = false

@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var interaction_area : InteractionArea = $InteractionArea
@onready var audio_check : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var audio_uncheck : AudioStream = preload("res://Assets/Audio/cancel.wav")
@onready var tile_value_data : PersistentDataHandler = $PersistentDataHandler
@onready var sprite_2d : Sprite2D = $Sprite2D

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	tile_value_data.DataLoaded.connect(SetState)
	SetState()
	pass
	
func SetState() -> void:
	tile_value = tile_value_data.value
	if tile_value:
		sprite_2d.frame = 1
	else:
		sprite_2d.frame = 0
		
func _on_interact() -> void:
	if tile_value == false:
		audio_stream_player_2d.stream = audio_check
		audio_stream_player_2d.play()
		sprite_2d.frame = 1
		await audio_stream_player_2d.finished
		tile_value = true
	else:
		audio_stream_player_2d.stream = audio_uncheck
		audio_stream_player_2d.play()
		sprite_2d.frame = 0
		await audio_stream_player_2d.finished
		tile_value = false
	TileChange.emit(tile_value, tile_correctness, self)
	
