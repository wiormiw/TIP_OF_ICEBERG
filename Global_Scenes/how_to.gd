class_name HowTo extends CanvasLayer

@onready var audio_stream_player_how_to : AudioStreamPlayer = %AudioStreamPlayerHowTo
@onready var cancel_audio : AudioStream = preload("res://Assets/Audio/cancel.wav")

@onready var action_img : TextureRect = $Control/Panel/TextureRect
@onready var sprite_2d : Sprite2D = $Control/Panel/Sprite2D
@onready var label : Label = $Control/Panel/Title

@onready var next_button : TextureButton = $Control/HBoxContainer/NextButton
@onready var prev_button : TextureButton = $Control/HBoxContainer/PrevButton

var current_page : int = 0

var pages : Array = [
	{"title": "Kenalan ama ToI yuk!", "image_path": "res://Assets/Objects/Sprites/GUI_Element/Tujuan_2.png", "sprite_path": ""},
	{"title": "Di ToI kamu akan..", "image_path": "res://Assets/Objects/Sprites/GUI_Element/Tujuan_1.png", "sprite_path": ""},
	{"title": "Move", "image_path": "res://Assets/Objects/Sprites/GUI_Element/HOW_TO_5.png", "sprite_path": "res://Assets/Objects/Sprites/GUI_Element/animated_wasd.png"},
	{"title": "Jump", "image_path": "res://Assets/Objects/Sprites/GUI_Element/HOW_TO_3.png", "sprite_path": "res://Assets/Objects/Sprites/GUI_Element/animated_spacebar.png"},
	{"title": "Run", "image_path": "res://Assets/Objects/Sprites/GUI_Element/HOW_TO_4.png", "sprite_path": "res://Assets/Objects/Sprites/GUI_Element/animated_m.png"},
	{"title": "Interact", "image_path": "res://Assets/Objects/Sprites/GUI_Element/HOW_TO_2.png", "sprite_path": "res://Assets/Objects/Sprites/GUI_Element/animated_f.png"},
	{"title": "Pause", "image_path": "res://Assets/Objects/Sprites/GUI_Element/HOW_TO_1.png", "sprite_path": "res://Assets/Objects/Sprites/GUI_Element/animated_esc.png"}
]

func _ready() -> void:
	update_page()

func _on_prev_button_pressed() -> void:
	if current_page > 0:
		current_page -= 1
		update_page()
		audio_stream_player_how_to.play()

func _on_next_button_pressed() -> void:
	if current_page < pages.size() - 1:
		current_page += 1
		update_page()
		audio_stream_player_how_to.play()

func update_page() -> void:
	var page = pages[current_page]
	action_img.texture = load(page["image_path"]) as Texture
	sprite_2d.texture = load(page["sprite_path"]) as Texture
	label.text = page["title"]
	prev_button.disabled = current_page == 0
	next_button.disabled = current_page == pages.size() - 1

func _on_close_btn_pressed():
	audio_stream_player_how_to.stream = cancel_audio
	audio_stream_player_how_to.play()
	queue_free()
