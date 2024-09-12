class_name PushableStone extends RigidBody2D

@export var push_speed : float = 30.0
@export var correct_answer : int = 0
@export var label_text : String = ""

var push_direction : Vector2 = Vector2.ZERO : set = _set_push

@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var label = $Sprite2D/Label

func _ready() -> void:
	label.text = label_text	

func _physics_process(_delta : float) -> void:
	linear_velocity = push_direction * push_speed
	pass
	
func _set_push(value : Vector2) -> void:
	push_direction = value
	if push_direction == Vector2.ZERO:
		audio_stream_player_2d.stop()
	else:
		audio_stream_player_2d.play()
	pass



