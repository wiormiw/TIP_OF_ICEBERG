extends Node

signal GlobalPositionReset(_on_reset_index : String)
signal DoneAccessSecretNote

#Character Customization
var bodies_collection = {
	"01" : preload("res://Assets/Character/Body/Body.png")
}

var eyes_base_collection = {
	"01" : preload("res://Assets/Character/Eyes/EyesBase.png")
}

var eyes_collection = {
	"01" : preload("res://Assets/Character/Eyes/Eyes.png")
}

var hair_collection = {
	"none" : null,
	"01" : preload("res://Assets/Character/Hair/Hair_0.png"),
	"02" : preload("res://Assets/Character/Hair/Hair_1.png"),
	"03" : preload("res://Assets/Character/Hair/Hair_2.png"),
	"04" : preload("res://Assets/Character/Hair/Hair_3.png"),
	"05" : preload("res://Assets/Character/Hair/Hair_4.png"),
	"06" : preload("res://Assets/Character/Hair/Hair_5.png"),
	"07" : preload("res://Assets/Character/Hair/Hair_6.png"),
	"08" : preload("res://Assets/Character/Hair/Hair_7.png")
}

var uniform_collection = {
	"01" : preload("res://Assets/Character/Uniform/Uniform_0.png"),
	"02" : preload("res://Assets/Character/Uniform/Uniform_1.png"),
	"03" : preload("res://Assets/Character/Uniform/Uniform_2.png"),
	"04" : preload("res://Assets/Character/Uniform/Uniform_3.png"),
	"05" : preload("res://Assets/Character/Uniform/Uniform_4.png")
}

var pants_collection = {
	"01" : preload("res://Assets/Character/Pants/Pants_0.png"),
	"02" : preload("res://Assets/Character/Pants/Pants_1.png"),
	"03" : preload("res://Assets/Character/Pants/Pants_2.png"),
	"04" : preload("res://Assets/Character/Pants/Pants_3.png")
}

var shoes_collection = {
	"01" : preload("res://Assets/Character/Shoes/Shoes_0.png"),
	"02" : preload("res://Assets/Character/Shoes/Shoes_1.png")
}

var arms_collection = {
	"01" : preload("res://Assets/Character/Arms/Arms.png")
}

var sleeves_collection = {
	"01" : preload("res://Assets/Character/Sleeves/Sleeves_0.png"),
	"02" : preload("res://Assets/Character/Sleeves/Sleeves_1.png"),
	"03" : preload("res://Assets/Character/Sleeves/Sleeves_2.png"),
	"04" : preload("res://Assets/Character/Sleeves/Sleeves_3.png"),
	"05" : preload("res://Assets/Character/Sleeves/Sleeves_4.png")
}

# Body colors
var body_color_options = [
	Color(0.96, 0.80, 0.69, 1.0), # Bisque
	Color(0.71, 0.54, 0.39, 1.0), # Pale Goldenrod
	Color(0.45, 0.30, 0.27, 1.0) # Sienna
]

# Hair colors
var hair_color_options = [
	Color(1.0, 0.95, 0.71, 1.0), # Light Goldenrod Yellow
	Color(1.0, 0.84, 0.0, 1.0), # Gold
	Color(0.87, 0.69, 0.22, 1.0), # Goldenrod
	Color(0.77, 0.64, 0.49, 1.0), # Burly Wood
	Color(0.65, 0.47, 0.32, 1.0), # Peru
	Color(0.42, 0.27, 0.07, 1.0), # Saddle Brown
	Color(0.31, 0.16, 0.02, 1.0), # Sienna
	Color(0.55, 0.27, 0.07, 1.0) # Chocolate
]

# Eyes colors
var eyes_color_options = [
	Color(0.69, 0.83, 0.94, 1.0), # Light Blue
	Color(0.0, 0.0, 1.0, 1.0), # Blue
	Color(0.0, 0.0, 0.55, 1.0), # Medium Blue
	Color(0.06, 0.32, 0.74, 1.0), # Azure
	Color(0.60, 0.98, 0.60, 1.0), # Pale Green
	Color(0.0, 0.5, 0.0, 1.0), # Green
	Color(0.0, 0.39, 0.0, 1.0), # Dark Green
	Color(0.33, 0.42, 0.18, 1.0), # Olive Drab
	Color(0.63, 0.31, 0.18, 1.0), # Peru
	Color(0.55, 0.27, 0.07, 1.0), # Chocolate
	Color(0.34, 0.26, 0.20, 1.0), # Rosy Brown
	Color(0.85, 0.50, 0.0, 1.0), # Dark Goldenrod
	Color(0.83, 0.83, 0.83, 1.0), # Light Gray
	Color(0.5, 0.5, 0.5, 1.0), # Gray
	Color(0.31, 0.31, 0.31, 1.0), # Dim Gray
	Color(0.42, 0.42, 0.42, 1.0) # Dark Gray
]

#Player data
var player_name : String = ""
var selected_body : String = ""
var selected_eyes : String = ""
var selected_hair : String = ""
var selected_uniform : String = ""
var selected_pants : String = ""
var selected_shoes : String = ""
var selected_arms : String = ""
var selected_sleeves : String = ""
var selected_body_color : String = ""
var selected_hair_color : String = ""
var selected_eyes_color : String = ""

func color_to_hex(color : Color) -> String:
	return color.to_html()

func hex_to_color(hex : String) -> Color:
	return Color(hex)
	
#Default position:
var default_position = {
	"01" : Vector2(177,286), # intro
	"02" : Vector2(608,601), # stage_0
	"03" : Vector2(0, -69), # stage_1
	"04" : Vector2(-312, -37), # stage_2
	"05" : Vector2(0, -9), # stage_3
	"06" : Vector2(0, -101), # stage_4
	"07" : Vector2(0, -3), # stage_5
	"08" : Vector2(0, -213), # stage_6
	"09" : Vector2(0, -125), # stage_7
	"10" : Vector2(0, -211), # stage_8
	"11" : Vector2(0, -3), # stage_9
	"12" : Vector2(0, -109), # stage_10
	"13" : Vector2(25, -37), # stage_11
	"14" : Vector2(-64	, -245), # stage_A1
	"15" : Vector2(-64	, -245), # stage_A2
	"16" : Vector2(-64	, -245), # stage_A3
	"17" : Vector2(-64	, -245), # stage_A4
	"18" : Vector2(-64	, -245), # stage_A5
	"19" : Vector2(-64	, -245), # stage_A6
	"20" : Vector2(-64	, -245), # stage_A7
	"21" : Vector2(-64	, -245), # stage_A8
	"22" : Vector2(-64	, -245), # stage_A9
	"23" : Vector2(-64	, -245), # stage_A10
	"24" : Vector2(-64	, -245), # stage_A11
	"25" : Vector2(0, -40), # stage_0-1
	"26" : Vector2(-69, 18), # stage_0-2,
	"27" : Vector2(-8, -21), # lorong,
	"28" : Vector2(408, 477), # finish stage,
}

var default_scene_idx = {
	"res://Stage_Intro/stage_intro.tscn" : "01",
	"res://Levels/Stage_1/stage_0.tscn" : "02",
	"res://Levels/Stage_1/stage_1.tscn" : "03",
	"res://Levels/Stage_1/stage_2.tscn" : "04",
	"res://Levels/Stage_1/stage_3.tscn" : "05",
	"res://Levels/Stage_1/stage_4.tscn" : "06",
	"res://Levels/Stage_2/stage_5.tscn" : "07",
	"res://Levels/Stage_2/stage_6.tscn" : "08",
	"res://Levels/Stage_2/stage_7.tscn" : "09",
	"res://Levels/Stage_2/stage_8.tscn" : "10",
	"res://Levels/Stage_3/stage_9.tscn" : "11",
	"res://Levels/Stage_3/stage_10.tscn" : "12",
	"res://Levels/Stage_3/stage_11.tscn" : "13",
	"res://Levels/ChestRoom/chest_room_a1.tscn" : "14",
	"res://Levels/ChestRoom/chest_room_a2.tscn" : "15",
	"res://Levels/ChestRoom/chest_room_a3.tscn" : "16",
	"res://Levels/ChestRoom/chest_room_a4.tscn" : "17",
	"res://Levels/ChestRoom/chest_room_a5.tscn" : "18",
	"res://Levels/ChestRoom/chest_room_a6.tscn" : "19",
	"res://Levels/ChestRoom/chest_room_a7.tscn" : "20",
	"res://Levels/ChestRoom/chest_room_a8.tscn" : "21",
	"res://Levels/ChestRoom/chest_room_a9.tscn" : "22",
	"res://Levels/ChestRoom/chest_room_a10.tscn" : "23",
	"res://Levels/ChestRoom/chest_room_a11.tscn" : "24",
	"res://Levels/Stage_2/pre_stage_0-1.tscn" : "25",
	"res://Levels/Stage_3/pre_stage_0-2.tscn" : "26",
	"res://Levels/Stage_After/lorong.tscn" : "27",
	"res://Levels/Stage_After/hall_of_fame.tscn": "28",
}

var current_stage : String = ""

# Secret Note Content:
var secret_note_content_idx : String = ""

var secret_note_collection = {
	"01" : preload("res://Assets/Secret_Notes/Slide 16_9 - 1.png"),
	"02" : preload("res://Assets/Secret_Notes/Slide 16_9 - 2.png"),
	"03" : preload("res://Assets/Secret_Notes/Slide 16_9 - 3.png"),
	"04" : preload("res://Assets/Secret_Notes/Slide 16_9 - 4.png"),
	"05" : preload("res://Assets/Secret_Notes/Slide 16_9 - 5.png"),
	"06" : preload("res://Assets/Secret_Notes/Slide 16_9 - 6.png"),
	"07" : preload("res://Assets/Secret_Notes/Slide 16_9 - 7.png"),
	"08" : preload("res://Assets/Secret_Notes/Slide 16_9 - 8.png"),
	"09" : preload("res://Assets/Secret_Notes/Slide 16_9 - 9.png"),
	"10" : preload("res://Assets/Secret_Notes/Slide 16_9 - 10.png"),
	"11" : preload("res://Assets/Secret_Notes/Slide 16_9 - 11.png"),
	"12" : preload("res://Assets/Secret_Notes/Slide 16_9 - 12.png"),
	"13" : preload("res://Assets/Secret_Notes/Slide 16_9 - 13.png"),
	"14" : preload("res://Assets/Secret_Notes/Slide 16_9 - 14.png"),
	"15" : preload("res://Assets/Secret_Notes/Slide 16_9 - 15.png"),
	"16" : preload("res://Assets/Secret_Notes/Slide 16_9 - 16.png"),
	"17" : preload("res://Assets/Secret_Notes/Slide 16_9 - 17.png"),
	"18" : preload("res://Assets/Secret_Notes/Slide 16_9 - 18.png"),
	"19" : preload("res://Assets/Secret_Notes/Slide 16_9 - 19.png"),
	"20" : preload("res://Assets/Secret_Notes/Slide 16_9 - 20.png"),
	"21" : preload("res://Assets/Secret_Notes/Slide 16_9 - 21.png"),
	"22" : preload("res://Assets/Secret_Notes/Slide 16_9 - 22.png"),
	"23" : preload("res://Assets/Secret_Notes/Slide 16_9 - 23.png"),
}

# Pre-stage Total Secret Note:
# 4 Pre-stage 1
# 5 Pre-stage 2
# 3 Pre-stage 3
# Kalo current_save total secret note = 4
# Untuk testing karena belum ada stage dungeonnya,
# Jadi itung 5 + 4 (Pre-stage 2)
# 3 + 5 + 4 (Pre-stage 3)
# Kalo udah ada dungeonnya, jadi:
# 5 + (4 + 4) = 13
# 3 + (5 + 4) + (4 + 4) = 20
# Ada pergantian untuk pre-stage 0 jadi pre-stage kedua, pre-stage 1 jadi pertama
# 5
# 5 + 4
# 5 + 4 + 3

signal NewSecretNote
#
var secret_note_count : int = 0
	
# Stage 6:
var key_used_count : int = 0
	
# Stage 11:
var item_to_destroy : String = ""
