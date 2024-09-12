class_name PlayerDialogArea extends Area2D

@onready var speech_sfx : AudioStream = preload("res://Assets/Audio/text.wav")

@export var lines : Array[String]

@onready var player_dialog_area : Area2D = $"."
@onready var is_interacted_data : PersistentDataHandler = $PersistentDataHandler

var is_interacted : bool = false

func _ready() -> void:
	player_dialog_area.body_entered.connect(_on_body_entered)
	is_interacted_data.DataLoaded.connect(SetState)
	SetState()

func SetState() -> void:
	is_interacted = is_interacted_data.value
	
func _on_body_entered(_b : Node2D) -> void:
	if is_interacted == false:
		DialogManager.StartDialog(_b.global_position, lines, speech_sfx)
		await DialogManager.DialogFinished
		is_interacted_data.SetValue()
		is_interacted = true
	

