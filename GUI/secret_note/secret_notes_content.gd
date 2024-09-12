class_name SecretNotesContent extends CanvasLayer

@onready var sprite : Sprite2D = $Control/Sprite2D
@onready var texture_button = $Control/TextureButton
@onready var audio_stream_player : AudioStreamPlayer = %AudioStreamPlayer
@onready var audio : AudioStream = preload("res://Assets/Audio/cancel.wav")
@onready var audio_paper : AudioStream = preload("res://Assets/Audio/page_turning.wav")

func _ready() -> void:
	audio_stream_player.stream = audio_paper
	audio_stream_player.play()
	texture_button.pressed.connect(_on_btn_pressed)
	
func _on_btn_pressed() -> void:
	audio_stream_player.stream = audio
	audio_stream_player.play()
	Global.DoneAccessSecretNote.emit()
	queue_free()
	
func _update_texture(new_texture) -> void:
	sprite.texture = new_texture
	
