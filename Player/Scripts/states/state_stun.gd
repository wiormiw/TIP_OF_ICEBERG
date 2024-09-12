class_name StateStun extends State

@export var knockback_speed : float = 100.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 1.0

var hurt_box : HurtBox
var direction : Vector2

var next_state : State = null
var item_data : ItemData

@onready var idle : State = $"../Idle"
@onready var hold_item : State = $"../Hold_Item"

func Init() -> void:
	player.PlayerDamaged.connect(_player_damaged)
	Inventory.ItemChanged.connect(_on_item_changed)

func Enter() -> void:
	player.on_arms_item.visible = false
	player.animation_player.animation_finished.connect(_animation_finished)
	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity = direction * -knockback_speed
	player.SetDirection()
	player.UpdateAnimation("stun")
	player.MakeInvulnerable(invulnerable_duration)
	player.effect_animation_player.play("damaged")
	pass
	
func Exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect(_animation_finished)
	pass
	
func Process(_delta : float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	return next_state
	
func Physics(_delta : float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	return null
	
func _player_damaged(_hurt_box : HurtBox) -> void:
	hurt_box = _hurt_box
	state_machine.ChangeState(self)
	pass
	
func _animation_finished(_a : String) -> void:
	if item_data:
		player.on_arms_item.visible = true
		next_state = hold_item
		return
	player.on_arms_item.visible = true
	next_state = idle
	pass
	
func _on_item_changed(_item_data : ItemData) -> void:
	if _item_data:
		item_data = _item_data
		return
	item_data = null
