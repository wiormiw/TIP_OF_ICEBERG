class_name StateRun extends State

var next_state : State = null
var active : bool = false

@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"

@onready var idle : State = $"../Idle"
@onready var walk : State = $"../Walk"
@onready var jump : State = $"../Jump"
@onready var hold_item = $"../Hold_Item"

func Init() -> void:
	Inventory.ItemChanged.connect(_item_changed)

func Enter() -> void:
	if DialogManager.is_dialog_active:
		player.velocity = Vector2.ZERO
		player.UpdateAnimation("idle")
		state_machine.ChangeState(idle)
		return
		
	active = true
	player.UpdateAnimation("run")
	pass
	
func Exit() -> void:
	active = false
	next_state = null
	pass
	
func Process(_delta : float) -> State:
	if DialogManager.is_dialog_active:
		player.velocity = Vector2.ZERO
		player.UpdateAnimation("idle")
		state_machine.ChangeState(idle)
		return
	
	player.velocity = player.direction * (walk.move_speed * 1.5)
	
	if player.SetDirection():
		player.UpdateAnimation("run")
	
	if player.direction == Vector2.ZERO:
		return idle
	elif Input.is_action_just_released("run"):
		return walk
		
	if next_state:
		return next_state
	
	return null
	
func Physics(_delta : float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("jump"):
		return jump
	return null
	
func _item_changed(_item_data : ItemData) -> void:
	if not active:
		return
		
	if _item_data:
		next_state = hold_item
		player.on_arms_item.texture = _item_data.texture
		player.on_arms_item.visible = true
	else:
		next_state = self
