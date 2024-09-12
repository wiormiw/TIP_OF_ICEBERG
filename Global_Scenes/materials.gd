class_name Materials extends CanvasLayer

@onready var audio_stream_player_materials : AudioStreamPlayer = %AudioStreamPlayerMaterials
@onready var cancel_audio : AudioStream = preload("res://Assets/Audio/cancel.wav")

@onready var action_img : TextureRect = %Materials
@onready var label : Label = $Control/Panel/Title

@onready var next_button : TextureButton = $Control/HBoxContainer/NextButton
@onready var prev_button : TextureButton = $Control/HBoxContainer/PrevButton

var current_page : int = 0

var pages : Array = [
	{"title": "Percabangan", "image_path": "res://Assets/Objects/Sprites/GUI_Element/MATERIALS-1.png"},
	{"title": "If", "image_path": "res://Assets/Objects/Sprites/GUI_Element/MATERIALS-2.png"},
	{"title": "If-Else", "image_path": "res://Assets/Objects/Sprites/GUI_Element/MATERIALS-3.png"},
	{"title": "If-Else if-Else", "image_path": "res://Assets/Objects/Sprites/GUI_Element/MATERIALS-4.png"},
	{"title": "Switch-Case", "image_path": "res://Assets/Objects/Sprites/GUI_Element/MATERIALS-5.png"},
	{"title": "Nested If", "image_path": "res://Assets/Objects/Sprites/GUI_Element/MATERIALS-6.png"},
	{"title": "Nested If - Example", "image_path": "res://Assets/Objects/Sprites/GUI_Element/MATERIALS-7.png"},
	{"title": "Perulangan", "image_path": "res://Assets/Objects/Sprites/GUI_Element/MATERIALS-8.png"},
	{"title": "While", "image_path": "res://Assets/Objects/Sprites/GUI_Element/MATERIALS-9.png"},
	{"title": "Do-While", "image_path": "res://Assets/Objects/Sprites/GUI_Element/MATERIALS-10.png"},
	{"title": "For", "image_path": "res://Assets/Objects/Sprites/GUI_Element/MATERIALS-11.png"},
	{"title": "Nested Loop", "image_path": "res://Assets/Objects/Sprites/GUI_Element/MATERIALS-12.png"},
]

func _ready() -> void:
	update_page()

func _on_prev_button_pressed() -> void:
	if current_page > 0:
		current_page -= 1
		update_page()
		audio_stream_player_materials.play()

func _on_next_button_pressed() -> void:
	if current_page < pages.size() - 1:
		current_page += 1
		update_page()
		audio_stream_player_materials.play()

func update_page() -> void:
	var page = pages[current_page]
	action_img.texture = load(page["image_path"]) as Texture
	label.text = page["title"]
	prev_button.disabled = current_page == 0
	next_button.disabled = current_page == pages.size() - 1

func _on_close_btn_pressed():
	audio_stream_player_materials.stream = cancel_audio
	audio_stream_player_materials.play()
	queue_free()
