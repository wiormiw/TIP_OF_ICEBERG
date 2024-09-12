class_name GuessTheColor extends Node2D

@export var dungeon_door : Node

@onready var color_rect : ColorRect = $Board/ColorRect
@onready var color_lever = %ColorLever
@onready var color_lever_2 = %ColorLever2
@onready var color_lever_3 = %ColorLever3
@onready var color_lever_4 = %ColorLever4
@onready var guess_the_color_hurt_box : HurtBox = %GuessTheColorHurtBox
@onready var audio_stream_player_2d :AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_true : AudioStream = preload("res://Assets/Audio/confirm_1.wav")
@onready var audio_false : AudioStream = preload("res://Assets/Audio/wrong_answer.wav")

var color_options : Dictionary = {
	"Red": Color.RED,
	"Green": Color.GREEN,
	"Blue": Color.BLUE,
	"Yellow": Color.YELLOW,
	"Purple": Color.PURPLE,
	"Orange": Color.ORANGE,
	"Pink": Color.PINK,
	"Brown": Color.BROWN,
	"Gray": Color.GRAY,
	"Black": Color.BLACK,
	"White": Color.WHITE
}

var levers : Array = []

func _ready() -> void:
	guess_the_color_hurt_box.monitoring = false
	levers = [color_lever, color_lever_2, color_lever_3, color_lever_4]
	
	for lever in levers:
		lever.LeverInteracted.connect(_on_lever_interacted)
	
	color_rect.color = color_options["Red"]
	
func _on_lever_interacted(lever_color_name : String):
	var color_rect_color : Color = color_rect.color
	var lever_color = color_options.get(lever_color_name, Color.WHITE)
	
	if lever_color == color_rect_color:
		audio_stream_player_2d.stream = audio_true
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		dungeon_door.OpenDoor()
	else:
		audio_stream_player_2d.stream = audio_false
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		dungeon_door.animation_player.play("closed")
		guess_the_color_hurt_box.monitoring = true
		randomize_colors()
		await get_tree().create_timer(0.5).timeout
		for lever in levers:
			lever.lever._on_lever_reset()
		guess_the_color_hurt_box.monitoring = false

func randomize_colors():
	var color_names = color_options.keys()
	
	if color_names.size() < levers.size():
		print("Not enough colors for the levers.")
		return
	
	# Shuffle the color names to randomize the order
	color_names.shuffle()
	
	# Select the color for the ColorRect (first color in the shuffled list)
	var color_rect_name = color_names[0]
	color_rect.color = color_options[color_rect_name]
	
	# Randomly select a lever to be assigned the correct color
	var lever_with_correct_color = levers[randi() % levers.size()]
	lever_with_correct_color.SetColor.emit(color_rect_name)
	
	# Remove the color used for the ColorRect from the list
	color_names.erase(color_rect_name)
	
	# Shuffle remaining colors again
	color_names.shuffle()
	
	# Assign remaining colors to the other levers
	var color_index = 0
	for lever in levers:
		if lever != lever_with_correct_color:
			# Ensure we don't go out of bounds of the color_names array
			if color_index < color_names.size():
				var lever_color_name = color_names[color_index]
				lever.SetColor.emit(lever_color_name)
				color_index += 1
			else:
				print("Warning: Not enough colors to assign unique values to all levers.")
				break
