class_name PlayerCreation extends Node2D

var next_scene : String = "res://Stage_Intro/stage_intro.tscn"
var player_added : bool = false

@onready var text_edit : TextEdit = $CreatorScreen/ContentHolder/Details/TextEdit
@onready var accept_dialog : AcceptDialog = $AcceptDialog
@onready var audio : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var audio_cancel : AudioStream = preload("res://Assets/Audio/cancel.wav")
@onready var audio_stream_player = %AudioStreamPlayer

func _ready() -> void:
	accept_dialog.canceled.connect(_on_accept_dialog_canceled)
	accept_dialog.confirmed.connect(_on_accept_dialog_confirmed)
	audio_stream_player.stream = audio

func _on_accept_dialog_canceled() -> void:
	audio_stream_player.stream = audio_cancel
	audio_stream_player.play()
	
func _on_accept_dialog_confirmed() -> void:
	audio_stream_player.stream = audio
	audio_stream_player.play()

func _on_confirm_btn_pressed() -> void:
	audio_stream_player.stream = audio
	audio_stream_player.play()
	if text_edit.get_text().strip_edges() == "":
		show_alert("Please enter a name!")
	else:
		Global.player_name = text_edit.get_text()
		
		SaveManager.SaveGame(Global.default_position["01"])
		if PlayerManager.player == null:
			PlayerManager.AddPlayerInstance()
		LevelManager.LoadNewLevel(next_scene, "", Global.default_position["01"]) 
		await LevelManager.LevelLoadStarted
		await get_tree().process_frame
	
func show_alert(message: String) -> void:
	accept_dialog.set_text(message)
	accept_dialog.popup_centered()
