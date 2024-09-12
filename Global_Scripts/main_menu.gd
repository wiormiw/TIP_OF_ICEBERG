class_name MainMenu extends CanvasLayer

@onready var audio_stream_player : AudioStreamPlayer = %AudioStreamPlayer
@onready var audio : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var how_to_scene : PackedScene = preload("res://Global_Scenes/how_to.tscn")
@onready var materials : PackedScene = preload("res://Global_Scenes/materials.tscn")

func _ready() -> void:
	audio_stream_player.stream = audio
	pass
	
func _on_play_button_pressed():
	audio_stream_player.play()
	SaveManager.LoadGame()

func _on_how_to_button_pressed():
	audio_stream_player.play()
	var how_to_instance = how_to_scene.instantiate()
	get_tree().current_scene.add_child(how_to_instance)

func _on_materials_button_pressed():
	var materials_instance = materials.instantiate()
	get_tree().current_scene.add_child(materials_instance)
