class_name Certificate extends CanvasLayer

const NAME_MAX_LENGTH : int = 34

var local_name : String

@onready var texture_button = $Control/NinePatchRect/TextureButton
@onready var player_certificate_name : Label = $Control/NinePatchRect/Label
@onready var audio_stream_player : AudioStreamPlayer = %AudioStreamPlayer
@onready var audio : AudioStream = preload("res://Assets/Audio/cancel.wav")
@onready var audio_paper : AudioStream = preload("res://Assets/Audio/page_turning.wav")
@onready var secret_note_final_count : Label = $Control/NinePatchRect/Label4

func _ready() -> void:
	if SaveManager.current_save.player_data.player_name != "":
		local_name = SaveManager.current_save.player_data.player_name
	elif Global.player_name != "":
		local_name = Global.player_name
	else:
		local_name = "Player"
	player_certificate_name.text = local_name
	if SaveManager.ItemCount() >= 0:
		secret_note_final_count.text = str(SaveManager.ItemCount())
	elif Global.secret_note_count >= 0:
		secret_note_final_count.text = str(Global.secret_note_count)
	else:
		secret_note_final_count.text = "0"
	audio_stream_player.stream = audio_paper
	audio_stream_player.play()
	texture_button.pressed.connect(_on_btn_pressed)
	
func _on_btn_pressed() -> void:
	audio_stream_player.stream = audio
	audio_stream_player.play()
	queue_free()
