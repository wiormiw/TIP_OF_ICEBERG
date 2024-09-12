class_name StateWalk extends State

@export var move_speed : float = 50.0

var next_state : State = null
var active : bool = false
var item_data : ItemData

@onready var idle : State = $"../Idle"
@onready var run : State = $"../Run"
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
	player.UpdateAnimation("walk")
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
	
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("walk")
		
	if player.direction == Vector2.ZERO:
		return idle
	
	if next_state:
		return next_state
	
	return null
	
func Physics(_delta : float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("jump"):
		return jump
	if _event.is_action_pressed("run") && player.direction != Vector2.ZERO:
		return run
	return null
	
func _item_changed(_item_data : ItemData) -> void:
	if not active:
		return
		
	if _item_data:
		_item_data = item_data
		next_state = hold_item
		player.on_arms_item.texture = _item_data.texture
		player.on_arms_item.visible = true
	else:
		next_state = self
