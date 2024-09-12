extends CanvasLayer

signal Shown
signal Hidden

const UNPAUSE = preload("res://Assets/Audio/unpause.wav")
const PAUSE = preload("res://Assets/Audio/pause.wav")

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var button_save : Button = $Control/HBoxContainer/ButtonSave
@onready var button_load : Button = $Control/HBoxContainer/ButtonLoad
@onready var secret_note_description = $Control/SecretNoteDescription

var is_paused : bool = false

func _ready() -> void:
	HidePauseMenu()
	button_save.pressed.connect(_on_save_pressed)
	button_load.pressed.connect(_on_load_pressed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		for c in get_tree().root.get_children():
			if c is Level:
				if is_paused == false:
					audio_stream_player.stream = PAUSE
					ShowPauseMenu()
					audio_stream_player.play(0)
				else:
					audio_stream_player.stream = UNPAUSE
					HidePauseMenu()
					audio_stream_player.play(0)
				get_viewport().set_input_as_handled()


func ShowPauseMenu() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true
	button_save.grab_focus()
	Shown.emit()

func HidePauseMenu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false
	Hidden.emit()

func _on_save_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.SaveGame()
	HidePauseMenu()
	pass

func _on_load_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.LoadGame()
	await LevelManager.LevelLoadStarted
	HidePauseMenu()
	pass
	
func UpdateSecretNoteDescription(new_text : String) -> void:
	secret_note_description.text = new_text 
