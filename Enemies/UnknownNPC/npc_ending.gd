class_name NPCEnding extends CharacterBody2D

var player_name : String

@onready var speech_sfx : AudioStream = preload("res://Assets/Audio/text.wav")

@export var lines : Array[String]

@onready var npcexit_area : Area2D = %NPCEXIT
@onready var audio_ending : AudioStreamPlayer = $"../AudioEnding"

@onready var animation_player : AnimationPlayer = $AnimationPlayer


var is_interacted : bool = false

func _ready() -> void:
	npcexit_area.body_entered.connect(_on_body_entered)
	set_player_name()
	lines = [
		"Hi " + player_name + "!",
		"Kita bertemu lagi!",
		"Seperti layaknya semua mimpi...",
		"Ini harus berakhir",
	]
	
func set_player_name() -> void:
	if Global.player_name != "":
		player_name = Global.player_name
	elif SaveManager.current_save.player_name != "":
		player_name = SaveManager.current_save.player_name
	else:
		player_name = "Player"

func _on_body_entered(_b : Node2D) -> void:
	if _b is Player and is_interacted == false:
		DialogManager.StartDialog(global_position + Vector2(0, 10), lines, speech_sfx)
		await DialogManager.DialogFinished
		lines = [
			"..............................",
			"Bagaimana petualanganmu di TOI-WORLD?",
			"Aku harap menyenangkan....",
			"Semoga pengalaman ini...",
			"Dapat menjadi bekal",
			"Untuk masa depanmu!",
			"Sampai bertemu di lain kesempatan!",
			"Kini saatnya kamu untuk kembali.",
			"Oh iya....",
			"Ingat namaku ya!",
			"'DREAMON'",
		]
		audio_ending.play()
		DialogManager.StartDialog(global_position + Vector2(0, 10), lines, speech_sfx)
		await DialogManager.DialogFinished
		animation_player.play("die")
		is_interacted = true
	
