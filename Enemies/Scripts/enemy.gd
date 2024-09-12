class_name Enemy extends CharacterBody2D

signal DirectionChanged(new_direction : Vector2)
signal EnemyDamaged(hurt_box : HurtBox)
signal EnemyDestroyed(hurt_box : HurtBox)

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp : int = 3

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var player : Player
var invulnerable : bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var hit_box : HitBox = $HitBox
@onready var state_machine : EnemyStateMachine = $EnemyStateMachine

func _ready() -> void:
	state_machine.Initialize(self)
	player = PlayerManager.player 
	hit_box.Damaged.connect(_take_damage)
	pass

func _process(_delta) -> void:
	pass

func _physics_process(_delta) -> void:
	move_and_slide()
	
func SetDirection(_new_direction : Vector2) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_direction = DIR_4[direction_id]
	
	if new_direction == cardinal_direction:
		return false

	cardinal_direction = new_direction	
	DirectionChanged.emit(new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.RIGHT else 1
	
	return true
	
func UpdateAnimation(state : String) -> void:
	animation_player.play(state + "_" + AnimDirection())
	pass
	
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
		
func _take_damage(hurt_box : HurtBox) -> void:
	if invulnerable == true:
		return
	hp -= hurt_box.damage
	if hp > 0:
		EnemyDamaged.emit(hurt_box)
	else:
		EnemyDestroyed.emit(hurt_box)
