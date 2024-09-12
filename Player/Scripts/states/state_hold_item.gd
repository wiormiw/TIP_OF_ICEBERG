class_name StateHoldItem extends State

var holding_item : bool = true
var next_state : State = null
var active : bool = false

@onready var idle : State = $"../Idle"
@onready var walk : State = $"../Walk"

func Init() -> void:
	Inventory.ItemChanged.connect(_item_changed)
	player.on_arms_item.visible = true

func Enter() -> void:
	if DialogManager.is_dialog_active or Global.current_stage == "24" or Global.current_stage == "23":
		player.on_arms_item.visible = false
		player.UpdateAnimation("idle")
		state_machine.ChangeState(idle)
		return
		
	active = true
	player.UpdateAnimation("hold_item_idle")
	pass
	
func Exit() -> void:
	active = false
	next_state = null
	pass
	
func Process(_delta : float) -> State:	
	if Global.current_stage == "24" or Global.current_stage == "23":
		player.on_arms_item.visible = false
		player.UpdateAnimation("idle")
		state_machine.ChangeState(idle)
		return
	
	if DialogManager.is_dialog_active:
		player.velocity = Vector2.ZERO
		player.on_arms_item.visible = false
		player.UpdateAnimation("idle")
		state_machine.ChangeState(idle)
		return
		
	player.velocity = player.direction * walk.move_speed
	
	if player.SetDirection() || player.direction != Vector2.ZERO:
		player.UpdateAnimation("hold_item")
	elif player.direction == Vector2.ZERO:
		player.UpdateAnimation("hold_item_idle")
	
	if next_state:
		return next_state
	
	return next_state
	
func Physics(_delta : float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	return null
	
func _item_changed(_item_data : ItemData) -> void:
	if not active:
		return
	
	if _item_data:
		player.on_arms_item.texture = _item_data.texture
		player.on_arms_item.visible = true
		holding_item = true
		state_machine.ChangeState(self)
		next_state = self
	else:
		player.on_arms_item.texture = null
		player.on_arms_item.visible = false
		holding_item = false
		next_state = idle
		
