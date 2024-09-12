@tool
class_name LevelTransition extends Area2D

enum SIDE { LEFT, RIGHT, TOP, BOTTOM }

@export_file("*.tscn") var level 
@export var target_transition_area : String = "LevelTransition"
@export var center_player : bool = false

@export_category("Collision Area Settings")

@export_range(1, 12, 1, "or_greater") var size : int = 2:
	set(_value):
		size = _value
		UpdateArea()
		 
@export var side : SIDE = SIDE.LEFT:
	set(_value):
		side = _value
		UpdateArea()
		
@export var snap_to_grid : bool = false:
	set(_value):
		SnapToGrid()

@onready var collision_shape : CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	UpdateArea()
	if Engine.is_editor_hint():
		return
	
	monitoring = false
	_place_player()
	
	await LevelManager.LevelLoaded	
	
	monitoring = true
	body_entered.connect(_player_entered)
	
	pass
	
func _player_entered(_p : Node2D) -> void:
	LevelManager.LoadNewLevel(level, target_transition_area, GetOffset())
	pass
	
func _place_player() -> void:
	if name != LevelManager.target_transition:
		return
	PlayerManager.SetPlayerPosition(global_position + LevelManager.position_offset)
	
func GetOffset() -> Vector2:
	var offset : Vector2 = Vector2.ZERO
	var player_pos = PlayerManager.player.global_position
	
	if side == SIDE.LEFT or side == SIDE.RIGHT:
		if center_player == true:
			offset.y = 0
		else:
			offset.y = player_pos.y - global_position.y
		offset.x = 32
		if side == SIDE.LEFT:
			offset.x *= -1
	else:
		if center_player:
			offset.x = 0
		else:
			offset.x = player_pos.x - global_position.x
		offset.y = 32
		if side == SIDE.TOP:
			offset.y *= -1
			
	return offset

func UpdateArea() -> void:
	var new_rect : Vector2 = Vector2(16, 16)
	var new_position : Vector2 = Vector2.ZERO
	
	if side == SIDE.TOP:
		new_rect.x *= size
		new_position.y -= 16
	elif side == SIDE.BOTTOM:
		new_rect.x *= size
		new_position.y += 16
	elif side == SIDE.LEFT:
		new_rect.y *= size
		new_position.x -= 16
	elif side == SIDE.RIGHT:
		new_rect.y *= size
		new_position.x += 16
		
	if collision_shape == null:
		collision_shape = get_node("CollisionShape2D")
	
	collision_shape.shape.size = new_rect
	collision_shape.position = new_position
	
func SnapToGrid() -> void:
	position.x = round(position.x / 8) * 8
	position.y = round(position.y / 8) * 8
		
