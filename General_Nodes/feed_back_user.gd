class_name FeedBackUser extends CanvasLayer

@onready var text_edit : TextEdit = $Control/TextEdit
@onready var accept_dialog : AcceptDialog = $Control/AcceptDialog
@onready var audio : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var audio_cancel : AudioStream = preload("res://Assets/Audio/cancel.wav")
@onready var audio_stream_player : AudioStreamPlayer = $Control/AudioStreamPlayer

var next_scene : String = "res://Levels/Stage_After/hall_of_fame.tscn"

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

func _on_texture_button_pressed():
	audio_stream_player.stream = audio
	audio_stream_player.play()
	var text_content = text_edit.text.strip_edges()
	
	if text_content == "":
		accept_dialog.set_text("Ayo isi pesan/kesannya :), Hatur nuhun")
		accept_dialog.popup_centered()
	else:
		var file_path = "res://feedback.txt"
		var file = FileAccess.open(file_path, FileAccess.WRITE)
		
		if file:
			file.store_string(text_content)
			file.close()
			print("Text saved to ", file_path)
			if PlayerManager.player == null:
				PlayerManager.AddPlayerInstance()
			SaveManager.SaveGame(Global.default_position["28"])
			LevelManager.LoadNewLevel(next_scene, "", Vector2.ZERO)
			await LevelManager.LevelLoadStarted
			PlayerManager.SetPlayerPosition(Global.default_position["28"])
			PlayerManager.SetHealth(SaveManager.current_save.player.hp, SaveManager.current_save.player.max_hp)
		else:
			print("Failed to open file for writing.")
