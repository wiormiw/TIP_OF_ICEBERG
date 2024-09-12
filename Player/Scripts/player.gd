class_name Player extends CharacterBody2D

signal DirectionChanged(new_direction : Vector2)
signal PlayerDamaged(hurt_box : HurtBox)
signal PlayerDied

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var cardinal_direction : Vector2 = Vector2.UP
var direction : Vector2 = Vector2.ZERO

var invulnerable : bool = false
var hp : int = 6
var max_hp : int = 6
var reset_index : String = "01"

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player : AnimationPlayer = $EffectAnimationPlayer
@onready var body_sprite : Sprite2D = $Skeleton/Body
@onready var hair_sprite : Sprite2D = $Skeleton/Hair
@onready var eyes_sprite : Sprite2D = $Skeleton/Eyes
@onready var eyes_base_sprite : Sprite2D = $Skeleton/EyesBase
@onready var uniform_sprite : Sprite2D = $Skeleton/Uniform
@onready var pants_sprite : Sprite2D = $Skeleton/Pants
@onready var shoes_sprite : Sprite2D = $Skeleton/Shoes
@onready var arms_sprite : Sprite2D = $Skeleton/Arms
@onready var sleeves_sprite : Sprite2D = $Skeleton/Sleeves
@onready var on_arms_item = $Skeleton/Arms/OnArmsItem
@onready var state_machine : PlayerStateMachine = $StateMachine
@onready var hit_box : HitBox = $HitBox
@onready var die = $StateMachine/Die
@onready var speech_sfx : AudioStream = preload("res://Assets/Audio/text.wav")

func _ready() -> void:
	PlayerManager.player = self
	PlayerManager.InitializeSpriteData(
		body_sprite,
		arms_sprite,
		eyes_sprite,
		hair_sprite,
		uniform_sprite,
		sleeves_sprite,
		pants_sprite,
		shoes_sprite
	)
	state_machine.Initialize(self)
	on_arms_item.visible = false
	hit_box.Damaged.connect(_take_damage)
	die.PlayerDiedCompleted.connect(_on_player_died_completed)
	Global.GlobalPositionReset.connect(_on_reset_index)
	UpdateHP(99)
	pass

func _process(_delta):
	if DialogManager.is_dialog_active:
		return
		
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	pass
	
func _physics_process(_delta):
	move_and_slide()
	
func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_direction = DIR_4[direction_id]
	
	if new_direction == cardinal_direction:
		return false

	cardinal_direction = new_direction	
	DirectionChanged.emit(new_direction)
	body_sprite.scale.x = -1 if cardinal_direction == Vector2.RIGHT else 1
	eyes_base_sprite.scale.x = -1 if cardinal_direction == Vector2.RIGHT else 1
	eyes_sprite.scale.x = -1 if cardinal_direction == Vector2.RIGHT else 1
	hair_sprite.scale.x = -1 if cardinal_direction == Vector2.RIGHT else 1
	uniform_sprite.scale.x = -1 if cardinal_direction == Vector2.RIGHT else 1
	pants_sprite.scale.x = -1 if cardinal_direction == Vector2.RIGHT else 1
	shoes_sprite.scale.x = -1 if cardinal_direction == Vector2.RIGHT else 1
	arms_sprite.scale.x = -1 if cardinal_direction == Vector2.RIGHT else 1
	sleeves_sprite.scale.x = -1 if cardinal_direction == Vector2.RIGHT else 1
	
	return true
	
func UpdateAnimation(state : String, _anim_speed : float = 1.0) -> void:
	animation_player.speed_scale = _anim_speed
	if state == "die":
		animation_player.play(state)
		return
		
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
	UpdateHP(-hurt_box.damage)
	if hp > 0:
		PlayerDamaged.emit(hurt_box)
	else:
		PlayerDied.emit()
		await die.PlayerDiedCompleted
		UpdateHP(99)
		queue_free()
		GameOver._on_game_over(reset_index)
	pass	

func UpdateHP(delta : int) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	PlayerHUD.UpdateHP(hp, max_hp)
	pass
	
func MakeInvulnerable(_duration : float = 1.0) ->  void:
	invulnerable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer(_duration).timeout
	
	invulnerable = false
	hit_box.monitoring = true
	pass
	
func _on_player_died_completed() -> void:
	pass
	
func _on_reset_index(_reset_index : String) -> void:
	reset_index = _reset_index
	
