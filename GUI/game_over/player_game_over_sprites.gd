class_name PlayerGameOverSprites extends Node2D

@onready var body : Sprite2D = $Body/Sprite2D
@onready var eyes : Sprite2D = $Eyes/Sprite2D
@onready var eyes_base : Sprite2D = $Eyes/Sprite2DBase
@onready var hair : Sprite2D = $Hair/Sprite2D
@onready var uniform : Sprite2D = $Uniform/Sprite2D
@onready var pants : Sprite2D = $Pants/Sprite2D
@onready var shoes : Sprite2D = $Shoes/Sprite2D
@onready var arms : Sprite2D = $Arms/Sprite2D
@onready var sleeves : Sprite2D = $Sleeves/Sprite2D

func _ready() -> void:
	body.modulate = Global.hex_to_color(Global.selected_body_color)
	arms.modulate = Global.hex_to_color(Global.selected_body_color)
	eyes.modulate = Global.hex_to_color(Global.selected_eyes_color)
	if Global.selected_hair != null:
		hair.texture = Global.hair_collection[Global.selected_hair]
		hair.modulate = Global.hex_to_color(Global.selected_hair_color)
		
	uniform.texture = Global.uniform_collection[Global.selected_uniform]
	pants.texture = Global.pants_collection[Global.selected_pants]
	shoes.texture = Global.shoes_collection[Global.selected_shoes]
	sleeves.texture = Global.sleeves_collection[Global.sleeves_uniform]
